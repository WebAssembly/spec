open Prose
open Printf
open Util.Source


(* Errors *)

let error at msg = Util.Error.error at "prose rendering" msg


(* Environment *)

module Set = Set.Make(String)
module Map = Map.Make(String)

type env =
  {
    prose: prose;
    render_latex: Backend_latex.Render.env;
    symbol: Symbol.env;
    macro: Macro.env;
  }

let env inputs outputs render_latex el prose : env =
  let symbol = Symbol.env el in
  let macro = Macro.env inputs outputs in
  let env = { prose; render_latex; symbol; macro; } in
  env

(* Helpers *)

let indent = "   "

let rec repeat str num =
  if num = 0 then ""
  else if Int.rem num 2 = 0 then repeat (str ^ str) (num / 2)
  else str ^ repeat (str ^ str) (num / 2)

let math = ":math:"

let render_math s =
  if (String.length s > 0) then math ^ sprintf "`%s`" s
  else s

let render_opt prefix stringifier suffix = function
  | None -> ""
  | Some x -> prefix ^ stringifier x ^ suffix

let render_order index depth =
  index := !index + 1;

  let num_idx = if !index = 1 then string_of_int !index else "#" in
  let alp_idx = if !index = 1 then Char.escaped (Char.chr (96 + !index)) else "#" in

  match depth mod 4 with
  | 0 -> num_idx ^ "."
  | 1 -> alp_idx ^ "."
  | 2 -> num_idx ^ ")"
  | 3 -> alp_idx ^ ")"
  | _ -> assert false

(* Translation from Al inverse call exp to Al binary exp *)

let al_invcalle_to_al_bine e id nl el =
  let efree = (match e.it with Al.Ast.TupE el -> el | _ -> [ e ]) in
  let ebound, erhs =
    let nbound = List.length nl - List.length efree in
    Util.Lib.List.split nbound el
  in
  let eargs, _, _ =
    List.fold_left
      (fun (eargs, efree, ebound) n ->
        match n with
        | Some _ -> (match efree with
          | e :: efree -> eargs @ [ e ], efree, ebound
          | _ -> assert false)
        | None -> (match ebound with
          | e :: ebound -> eargs @ [ e ], efree, ebound
          | _ -> assert false))
      ([], efree, ebound) nl
  in
  let elhs = Al.Al_util.callE (id, eargs) in
  let erhs = (match erhs with
    | [ e ] -> e
    | _ -> Al.Al_util.tupE erhs)
  in
  elhs, erhs

(* Translation from Al exp to El exp *)

let (let*) = Option.bind

let al_to_el_atom atom =
  let atom', typ = atom in
  atom' $$ (no_region, El.Atom.info typ)

let al_to_el_unop = function
  | Al.Ast.MinusOp -> Some El.Ast.MinusOp
  | _ -> None

let al_to_el_binop = function
  | Al.Ast.AddOp -> Some El.Ast.AddOp
  | Al.Ast.SubOp -> Some El.Ast.SubOp
  | Al.Ast.MulOp -> Some El.Ast.MulOp
  | Al.Ast.DivOp -> Some El.Ast.DivOp
  | Al.Ast.ModOp -> Some El.Ast.ModOp
  | Al.Ast.ExpOp -> Some El.Ast.ExpOp
  | _ -> None

let rec al_to_el_iter iter = match iter with
  | Al.Ast.Opt -> Some El.Ast.Opt
  | Al.Ast.List -> Some El.Ast.List
  | Al.Ast.List1 -> Some El.Ast.List1
  | Al.Ast.ListN (e, id) ->
    let* ele = al_to_el_expr e in
    let elid = Option.map (fun id -> id $ no_region) id in
    Some (El.Ast.ListN (ele, elid))

and al_to_el_path pl =
  let fold_path p elp =
    let elp' = (match p.it with
      | Al.Ast.IdxP ei ->
        let* elei = al_to_el_expr ei in
        Some (El.Ast.IdxP (elp, elei))
      | Al.Ast.SliceP (el, eh) ->
        let* elel = al_to_el_expr el in
        let* eleh = al_to_el_expr eh in
        Some (El.Ast.SliceP (elp, elel, eleh))
      | Al.Ast.DotP a ->
        let ela = al_to_el_atom a in
        Some (El.Ast.DotP (elp, ela)))
    in
    Option.map (fun elp' -> elp' $ no_region) elp'
  in
  List.fold_left
    (fun elp p -> Option.bind elp (fold_path p))
    (Some (El.Ast.RootP $ no_region)) pl

and al_to_el_expr expr =
  let exp' =
    match expr.it with
    | Al.Ast.NumE i ->
      let eli = El.Ast.NatE (El.Ast.DecOp, i) in
      Some eli
    | Al.Ast.UnE (op, e) ->
      let* elop = al_to_el_unop op in
      let* ele = al_to_el_expr e in
      Some (El.Ast.UnE (elop, ele))
    | Al.Ast.BinE (op, e1, e2) ->
      let* elop = al_to_el_binop op in
      let* ele1 = al_to_el_expr e1 in
      let* ele2 = al_to_el_expr e2 in
      Some (El.Ast.BinE (ele1, elop, ele2))
    | Al.Ast.TupE el ->
      let* elel = al_to_el_exprs el in
      Some (El.Ast.TupE elel)
    | Al.Ast.CallE (id, el) ->
      let elid = id $ no_region in
      let* elel = al_to_el_exprs el in
      let elel = List.map
        (fun ele ->
          let elarg = El.Ast.ExpA ele in
          (ref elarg) $ no_region)
        elel
      in
      Some (El.Ast.CallE (elid, elel))
    | Al.Ast.CatE (e1, e2) ->
      let* ele1 = al_to_el_expr e1 in
      let* ele2 = al_to_el_expr e2 in
      Some (El.Ast.SeqE [ ele1; ele2 ])
    | Al.Ast.LenE e ->
      let* ele = al_to_el_expr e in
      Some (El.Ast.LenE ele)
    | Al.Ast.ListE el ->
      let* elel = al_to_el_exprs el in
      if (List.length elel > 0) then Some (El.Ast.SeqE elel)
      else Some (El.Ast.EpsE)
    | Al.Ast.AccE (e, p) ->
      let* ele = al_to_el_expr e in
      (match p.it with
      | Al.Ast.IdxP ei ->
          let* elei = al_to_el_expr ei in
          Some (El.Ast.IdxE (ele, elei))
      | Al.Ast.SliceP (el, eh) ->
          let* elel = al_to_el_expr el in
          let* eleh = al_to_el_expr eh in
          Some (El.Ast.SliceE (ele, elel, eleh))
      | DotP a ->
          let ela = al_to_el_atom a in
          Some (El.Ast.DotE (ele, ela)))
    | Al.Ast.UpdE (e1, pl, e2) ->
      let* ele1 = al_to_el_expr e1 in
      let* elp = al_to_el_path pl in
      let* ele2 = al_to_el_expr e2 in
      Some (El.Ast.UpdE (ele1, elp, ele2))
    | Al.Ast.ExtE (e1, pl, e2, _) ->
      let* ele1 = al_to_el_expr e1 in
      let* elp = al_to_el_path pl in
      let* ele2 = al_to_el_expr e2 in
      Some (El.Ast.ExtE (ele1, elp, ele2))
    | Al.Ast.StrE r ->
      let* elexpfield = al_to_el_record r in
      Some (El.Ast.StrE elexpfield)
    | Al.Ast.VarE id | Al.Ast.SubE (id, _) ->
      let elid = id $ no_region in
      Some (El.Ast.VarE (elid, []))
    | Al.Ast.IterE (e, _, iter) ->
      let* ele = al_to_el_expr e in
      let* eliter = al_to_el_iter iter in
      let ele =
        match ele.it with
        | El.Ast.IterE (_, eliter2) when eliter2 <> eliter ->
          El.Ast.ParenE (ele, `Insig) $ ele.at
        | _ -> ele
      in
      Some (El.Ast.IterE (ele, eliter))
    | Al.Ast.InfixE (e1, op, e2) ->
      let* ele1 = al_to_el_expr e1 in
      let elop = al_to_el_atom op in
      let* ele2 = al_to_el_expr e2 in
      Some (El.Ast.InfixE (ele1, elop, ele2))
    | Al.Ast.CaseE (a, el) ->
      let ela = al_to_el_atom a in
      let ela = (El.Ast.AtomE ela) $ no_region in
      let* elel = al_to_el_exprs el in
      let ele = El.Ast.SeqE ([ ela ] @ elel) in
      if List.length elel = 0 then Some ele
      else Some (El.Ast.ParenE (ele $ no_region, `Insig))
    | Al.Ast.OptE (Some e) ->
      let* ele = al_to_el_expr e in
      Some (ele.it)
    | Al.Ast.OptE None -> Some (El.Ast.EpsE)
    | _ -> None
  in
  Option.map (fun exp' -> exp' $ no_region) exp'

and al_to_el_exprs exprs =
  List.fold_left
    (fun exps e ->
      let* exps = exps in
      let* exp = al_to_el_expr e in
      Some (exps @ [ exp ]))
    (Some []) exprs

and al_to_el_record record =
  Util.Record.fold
    (fun a e expfield ->
      let* expfield = expfield in
      let* ele = al_to_el_expr e in
      let ela = al_to_el_atom a in
      let elelem = El.Ast.Elem (ela, ele) in
      Some (expfield @ [ elelem ]))
    record (Some [])

(* Operators *)

let render_prose_cmpop = function
  | Eq -> "equal to"
  | Ne -> "different with"
  | Lt -> "less than"
  | Gt -> "greater than"
  | Le -> "less than or equal to"
  | Ge -> "greater than or equal to"

let render_al_unop = function
  | Al.Ast.NotOp -> "not"
  | Al.Ast.MinusOp -> "minus"

let render_al_binop = function
  | Al.Ast.AndOp -> "and"
  | Al.Ast.OrOp -> "or"
  | Al.Ast.ImplOp -> "implies"
  | Al.Ast.EquivOp -> "is equivalent to"
  | Al.Ast.AddOp -> "plus"
  | Al.Ast.SubOp -> "minus"
  | Al.Ast.MulOp -> "multiplied by"
  | Al.Ast.DivOp -> "divided by"
  | Al.Ast.ModOp -> "modulo"
  | Al.Ast.ExpOp -> "to the power of"
  | Al.Ast.EqOp -> "is"
  | Al.Ast.NeOp -> "is not"
  | Al.Ast.LtOp -> "is less than"
  | Al.Ast.GtOp -> "is greater than"
  | Al.Ast.LeOp -> "is less than or equal to"
  | Al.Ast.GeOp -> "is greater than or equal to"

(* Names *)

let render_atom env a =
  let ela = al_to_el_atom a in
  let sela = Backend_latex.Render.render_atom env.render_latex ela in
  render_math sela 


(* Expressions and Paths *)

(* Invariant: All AL expressions fall into one of the three categories:
  1. EL-like expression, only containing EL subexpressions
  2. AL-only expression, possibly containing EL subexpressions
  3. pseudo-EL-like expression, containing at least one AL-only subexpression *)

(* Category 1 is translated to EL then rendered by the Latex backend *)

let render_el_exp env exp =
  (* embedded math blocks cannot have line-breaks *)
  let newline = Str.regexp "\n" in
  let sexp = Backend_latex.Render.render_exp env.render_latex exp in
  let sexp = Str.global_replace newline "" sexp in
  render_math sexp

let rec render_expr env expr = match al_to_el_expr expr with
  | Some exp -> render_el_exp env exp
  | None -> render_expr' env expr

(* Categories 2 and 3 are rendered by the prose backend,
   yet EL subexpressions are still rendered by the Latex backend *)

and render_expr' env expr =
  match expr.it with
  | Al.Ast.BoolE b -> string_of_bool b
  | Al.Ast.UnE (NotOp, { it = Al.Ast.IsCaseOfE (e, a); _ }) ->
    let se = render_expr env e in
    let sa = render_atom env a in
    sprintf "%s is not of the case %s" se sa
  | Al.Ast.UnE (NotOp, { it = Al.Ast.IsDefinedE e; _ }) ->
    let se = render_expr env e in
    sprintf "%s is not defined" se
  | Al.Ast.UnE (NotOp, { it = Al.Ast.IsValidE e; _ }) ->
    let se = render_expr env e in
    sprintf "%s is not valid" se
  | Al.Ast.UnE (NotOp, { it = Al.Ast.MatchE (e1, e2); _ }) ->
    let se1 = render_expr env e1 in
    let se2 = render_expr env e2 in
    sprintf "%s does not match %s" se1 se2
  | Al.Ast.UnE (op, e) ->
    let sop = render_al_unop op in
    let se = render_expr env e in
    sprintf "%s %s" sop se
  | Al.Ast.BinE (op, e1, e2) ->
    let sop = render_al_binop op in
    let se1 = render_expr env e1 in
    let se2 = render_expr env e2 in
    sprintf "%s %s %s" se1 sop se2
  | Al.Ast.UpdE (e1, ps, e2) ->
    let se1 = render_expr env e1 in
    let sps = render_paths env ps in
    let se2 = render_expr env e2 in
    sprintf "%s with %s replaced by %s" se1 sps se2
  | Al.Ast.ExtE (e1, ps, e2, dir) ->
    let se1 = render_expr env e1 in
    let sps = render_paths env ps in
    let se2 = render_expr env e2 in
    (match dir with
    | Al.Ast.Front -> sprintf "%s with %s prepended by %s" se1 sps se2
    | Al.Ast.Back -> sprintf "%s with %s appended by %s" se1 sps se2)
  | Al.Ast.InvCallE (id, nl, el) ->
    let e =
      if id = "lsizenn" || id = "lsizenn1" || id = "lsizenn2" then Al.Al_util.varE "N"
      else if List.length nl = 1 then Al.Al_util.varE "fresh"
      else
        let el =
          nl
          |> List.filter_map (Option.map (fun x -> Al.Al_util.varE ("fresh_" ^ (string_of_int x))))
        in
        Al.Al_util.tupE el
    in
    let elhs, erhs = al_invcalle_to_al_bine e id nl el in
    sprintf "%s for which %s %s %s"
      (render_expr env e)
      (render_expr env elhs)
      (render_math "=")
      (render_expr env erhs)
  | Al.Ast.IterE (e, ids, iter) when al_to_el_expr e = None ->
    let se = render_expr env e in
    let ids = Al.Al_util.tupE (List.map Al.Al_util.varE ids) in
    let loop = Al.Al_util.iterE (ids, [], iter) in
    let sloop = render_expr env loop in
    sprintf "for all %s, %s" sloop se
  | Al.Ast.ArityE e ->
    let se = render_expr env e in
    sprintf "the arity of %s" se
  | Al.Ast.GetCurStateE -> "the current state"
  | Al.Ast.GetCurLabelE -> "the current label"
  | Al.Ast.GetCurFrameE -> "the current frame"
  | Al.Ast.GetCurContextE -> "the current context"
  | Al.Ast.FrameE (None, e2) ->
    let se2 = render_expr env e2 in
    sprintf "the activation of %s" se2
  | Al.Ast.FrameE (Some e1, e2) ->
    let se1 = render_expr env e1 in
    let se2 = render_expr env e2 in
    sprintf "the activation of %s with arity %s" se2 se1
  | Al.Ast.ContE e ->
    let se = render_expr env e in
    sprintf "the continuation of %s" se
  | Al.Ast.LabelE (e1, e2) ->
    let se1 = render_expr env e1 in
    let se2 = render_expr env e2 in
    sprintf "the label whose arity is %s and whose continuation is %s" se1 se2
  | Al.Ast.ContextKindE (a, e) ->
    let sa = render_atom env a in
    let se = render_expr env e in
    sprintf "%s is %s" se sa
  | Al.Ast.IsDefinedE e ->
    let se = render_expr env e in
    sprintf "%s is defined" se
  | Al.Ast.IsCaseOfE (e, a) ->
    let se = render_expr env e in
    let sa = render_atom env a in
    sprintf "%s is of the case %s" se sa
  | Al.Ast.HasTypeE (e, t) ->
    let se = render_expr env e in
    sprintf "the type of %s is %s" se t
  | Al.Ast.IsValidE e ->
    let se = render_expr env e in
    sprintf "%s is valid" se
  | Al.Ast.TopLabelE -> "a label is now on the top of the stack"
  | Al.Ast.TopFrameE -> "a frame is now on the top of the stack"
  | Al.Ast.TopValueE (Some e) ->
    let se = render_expr env e in
    sprintf "a value of value type %s is on the top of the stack" se
  | Al.Ast.TopValueE None -> "a value is on the top of the stack"
  | Al.Ast.TopValuesE e ->
    let se = render_expr env e in
    sprintf "there are at least %s values on the top of the stack" se
  | Al.Ast.MatchE (e1, e2) ->
    let se1 = render_expr env e1 in
    let se2 = render_expr env e2 in
    sprintf "%s matches %s" se1 se2
  | _ ->
    let se = "`" ^ (Al.Print.string_of_expr expr) ^ "`" in
    let msg = sprintf "expr cannot be rendered %s" se in
    error expr.at msg

and render_path env path =
  match path.it with
  | Al.Ast.IdxP e ->
    let se = render_expr env e in
    let space = if (String.starts_with ~prefix:math se) then " " else "" in
    sprintf "the %s%s-th element" (render_expr env e) space
  | Al.Ast.SliceP (e1, e2) ->
    let se1 = render_expr env e1 in
    let se2 = render_expr env e2 in
    sprintf "the slice from %s to %s" se1 se2 
  | Al.Ast.DotP a ->
    sprintf "the field %s" (render_atom env a)

and render_paths env paths =
  let spaths = List.map (render_path env) paths in
  String.concat " of " spaths

(* Instructions *)

let rec render_prose_instr env depth = function
  | LetI (e1, e2) ->
    sprintf "* Let %s be %s."
      (render_expr env e1)
      (render_expr env e2)
  | CmpI (e1, cmpop, e2) ->
    sprintf "* %s must be %s %s."
      (String.capitalize_ascii (render_expr env e1))
      (render_prose_cmpop cmpop)
      (render_expr env e2)
  | MemI (e1, e2) ->
    sprintf "* %s must be contained in %s."
      (String.capitalize_ascii (render_expr env e1))
      (render_expr env e2)
  | MustValidI (e1, e2, e3) ->
    sprintf "* Under the context %s, %s must be valid%s."
      (render_expr env e1)
      (render_expr env e2)
      (render_opt " with type " (render_expr env) "" e3)
  | MustMatchI (e1, e2) ->
    sprintf "* %s must match %s."
      (String.capitalize_ascii (render_expr env e1))
      (render_expr env e2)
  | IsValidI e ->
    sprintf "* The instruction is valid%s."
      (render_opt " with type " (render_expr env) "" e)
  | IfI (c, is) ->
    sprintf "* If %s,%s"
      (render_expr env c)
      (render_prose_instrs env (depth + 1) is)
  | ForallI (e1, e2, is) ->
    sprintf "* For all %s in %s,%s"
      (render_expr env e1)
      (render_expr env e2)
      (render_prose_instrs env (depth + 1) is)
  | EquivI (c1, c2) ->
    sprintf "* %s if and only if %s."
      (String.capitalize_ascii (render_expr env c1))
      (render_expr env c2)
  | YetI s ->
    sprintf "* YetI: %s." s

and render_prose_instrs env depth instrs =
  List.fold_left
    (fun sinstrs i ->
      sinstrs ^ "\n\n" ^ repeat indent depth ^ render_prose_instr env depth i)
    "" instrs

(* Prefix for stack push/pop operations *)
let render_stack_prefix expr =
  match expr.it with
  | Al.Ast.GetCurContextE
  | Al.Ast.GetCurFrameE
  | Al.Ast.GetCurLabelE
  | Al.Ast.ContE _
  | Al.Ast.FrameE _
  | Al.Ast.LabelE _
  | Al.Ast.VarE ("F" | "L") -> ""
  | Al.Ast.IterE _ -> "the values "
  | _ -> "the value "

let rec render_al_instr env algoname index depth instr =
  match instr.it with
  | Al.Ast.IfI (c, il, []) ->
    sprintf "%s If %s, then:%s" (render_order index depth)
      (render_expr env c) (render_al_instrs env algoname (depth + 1) il)
  | Al.Ast.IfI (c, il1, [ { it = IfI (inner_c, inner_il1, []); _ } ]) ->
    let if_index = render_order index depth in
    let else_if_index = render_order index depth in
    sprintf "%s If %s, then:%s\n\n%s Else if %s, then:%s"
      if_index
      (render_expr env c)
      (render_al_instrs env algoname (depth + 1) il1)
      (repeat indent depth ^ else_if_index)
      (render_expr env inner_c)
      (render_al_instrs env algoname (depth + 1) inner_il1)
  | Al.Ast.IfI (c, il1, [ { it = IfI (inner_c, inner_il1, inner_il2); _ } ]) ->
    let if_index = render_order index depth in
    let else_if_index = render_order index depth in
    let else_index = render_order index depth in
    sprintf "%s If %s, then:%s\n\n%s Else if %s, then:%s\n\n%s Else:%s"
      if_index
      (render_expr env c)
      (render_al_instrs env algoname (depth + 1) il1)
      (repeat indent depth ^ else_if_index)
      (render_expr env inner_c)
      (render_al_instrs env algoname (depth + 1) inner_il1)
      (repeat indent depth ^ else_index)
      (render_al_instrs env algoname (depth + 1) inner_il2)
  | Al.Ast.IfI (c, il1, il2) ->
    let if_index = render_order index depth in
    let else_index = render_order index depth in
    sprintf "%s If %s, then:%s\n\n%s Else:%s"
      if_index
      (render_expr env c)
      (render_al_instrs env algoname (depth + 1) il1)
      (repeat indent depth ^ else_index)
      (render_al_instrs env algoname (depth + 1) il2)
  | Al.Ast.OtherwiseI il ->
    sprintf "%s Otherwise:%s" (render_order index depth)
      (render_al_instrs env algoname (depth + 1) il)
  | Al.Ast.EitherI (il1, il2) ->
    let either_index = render_order index depth in
    let or_index = render_order index depth in
    sprintf "%s Either:%s\n\n%s Or:%s"
      either_index
      (render_al_instrs env algoname (depth + 1) il1)
      (repeat indent depth ^ or_index)
      (render_al_instrs env algoname (depth + 1) il2)
  | Al.Ast.AssertI c ->
    let vref =
      if Macro.find_section env.macro ("valid-" ^ algoname) then
        ":ref:`validation <valid-" ^ algoname ^">`"
      else
        "validation"
    in
    sprintf "%s Assert: Due to %s, %s." (render_order index depth)
      vref (render_expr env c)
  | Al.Ast.PushI e ->
    sprintf "%s Push %s%s to the stack." (render_order index depth)
      (render_stack_prefix e) (render_expr env e)
  | Al.Ast.PopI e ->
    sprintf "%s Pop %s%s from the stack." (render_order index depth)
      (render_stack_prefix e) (render_expr env e)
  | Al.Ast.PopAllI e ->
    sprintf "%s Pop all values %s from the top of the stack." (render_order index depth)
      (render_expr env e)
  | Al.Ast.LetI (e, { it = Al.Ast.IterE ({ it = Al.Ast.InvCallE (id, nl, el); _ }, ids, iter); _ }) ->
    let elhs, erhs = al_invcalle_to_al_bine e id nl el in
    let ebin = Al.Al_util.binE (Al.Ast.EqOp, elhs, erhs) in
    let eiter = Al.Al_util.iterE (ebin, ids, iter) in
    sprintf "%s Let %s be the result for which %s."
      (render_order index depth)
      (render_expr env e)
      (render_expr env eiter)
  | Al.Ast.LetI (e, { it = Al.Ast.InvCallE (id, nl, el); _ }) ->
    let elhs, erhs = al_invcalle_to_al_bine e id nl el in
    sprintf "%s Let %s be the result for which %s %s %s."
      (render_order index depth)
      (render_expr env e)
      (render_expr env elhs)
      (render_math "=")
      (render_expr env erhs)
  | Al.Ast.LetI (n, e) ->
    sprintf "%s Let %s be %s." (render_order index depth) (render_expr env n)
      (render_expr env e)
  | Al.Ast.TrapI -> sprintf "%s Trap." (render_order index depth)
  | Al.Ast.NopI -> sprintf "%s Do nothing." (render_order index depth)
  | Al.Ast.ReturnI e_opt ->
    sprintf "%s Return%s." (render_order index depth)
      (render_opt " " (render_expr env) "" e_opt)
  | Al.Ast.EnterI (e1, e2, il) ->
    sprintf "%s Enter %s with label %s.%s" (render_order index depth)
      (render_expr env e1) (render_expr env e2)
      (render_al_instrs env algoname (depth + 1) il)
  | Al.Ast.ExecuteI e ->
    sprintf "%s Execute the instruction %s." (render_order index depth) (render_expr env e)
  | Al.Ast.ExecuteSeqI e ->
    sprintf "%s Execute the sequence %s." (render_order index depth) (render_expr env e)
  | Al.Ast.PerformI (n, es) ->
    sprintf "%s Perform %s." (render_order index depth) (render_expr env (Al.Al_util.callE (n, es) ~at:no_region))
  | Al.Ast.ExitI a ->
    sprintf "%s Exit from %s." (render_order index depth) (render_atom env a)
  | Al.Ast.ReplaceI (e1, p, e2) ->
    sprintf "%s Replace %s with %s." (render_order index depth)
      (render_expr env (Al.Al_util.accE (e1, p) ~at:no_region)) (render_expr env e2)
  | Al.Ast.AppendI (e1, e2) ->
    sprintf "%s Append %s to the %s." (render_order index depth)
      (render_expr env e2) (render_expr env e1)
  | Al.Ast.YetI s -> sprintf "%s YetI: %s." (render_order index depth) s

and render_al_instrs env algoname depth instrs =
  let index = ref 0 in
  List.fold_left
    (fun sinstrs i ->
      sinstrs ^ "\n\n" ^ repeat indent depth ^ render_al_instr env algoname index depth i)
    "" instrs

(* Prose *)

let render_atom_title env name params =
  (* TODO a workaround, for algorithms named label or name
     that are defined as LABEL_ or FRAME_ in the dsl *)
  let name', typ = name in 
  let name' =
    match name' with
    | El.Atom.Atom "label" -> El.Atom.Atom "LABEL_"
    | El.Atom.Atom "frame" -> El.Atom.Atom "FRAME_"
    | El.Atom.Atom s -> El.Atom.Atom (String.uppercase_ascii s)
    | _ -> name'
  in
  let name = (name', typ) in
  let expr = Al.Al_util.caseE (name, params) ~at:no_region in
  match al_to_el_expr expr with
  | Some ({ it = El.Ast.ParenE (exp, _); _ }) -> render_el_exp env exp
  | Some exp -> render_el_exp env exp
  | None -> render_expr' env expr

let render_funcname_title env fname params =
  render_expr env (Al.Al_util.callE (fname, params) ~at:no_region)

let render_pred env name params instrs =
  let title = render_atom_title env name params in
  title ^ "\n" ^
  String.make (String.length title) '.' ^ "\n" ^
  render_prose_instrs env 0 instrs

let render_rule env name params instrs =
  let title = render_atom_title env name params in
  let rname = Al.Print.string_of_atom name in
  title ^ "\n" ^
  String.make (String.length title) '.' ^ "\n" ^
  render_al_instrs env rname 0 instrs

let render_func env fname params instrs =
  let title = render_funcname_title env fname params in
  title ^ "\n" ^
  String.make (String.length title) '.' ^ "\n" ^
  render_al_instrs env fname 0 instrs

let render_def env = function
  | Pred (name, params, instrs) ->
    "\n" ^ render_pred env name params instrs ^ "\n\n"
  | Algo algo -> (match algo with
    | Al.Ast.RuleA (name, params, instrs) ->
      "\n" ^ render_rule env name params instrs ^ "\n\n"
    | Al.Ast.FuncA (name, params, instrs) ->
      "\n" ^ render_func env name params instrs ^ "\n\n")

let render_prose env prose = List.map (render_def env) prose |> String.concat ""

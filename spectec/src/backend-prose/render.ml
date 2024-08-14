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
    config : Config.config;
    render_latex: Backend_latex.Render.env;
    macro: Macro.env;
  }

let env config inputs outputs render_latex : env =
  let macro = Macro.env inputs outputs in
  let env = { config; render_latex; macro; } in
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

let render_list stringifier sep = function
  | [] -> ""
  | hd :: tl -> List.fold_left (fun acc x -> acc ^ sep ^ (stringifier x)) (stringifier hd) tl

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
let e2a e = Al.Ast.ExpA e $ e.at
let a2e a =
  match a.it with
  | Al.Ast.ExpA e -> e
  | Al.Ast.TypA _ -> error a.at "Caannot render inverse function with type argument"

let al_invcalle_to_al_bine e id nl al =
  let efree = (match e.it with Al.Ast.TupE el -> el | _ -> [ e ]) in
  let abound, arhs =
    let nbound = List.length nl - List.length efree in
    Util.Lib.List.split nbound al
  in

  let args, _, _ =
    List.fold_left
      (fun (args, efree, abound) n ->
        match n with
        | Some _ -> args @ [ List.hd efree |> e2a ], List.tl efree, abound
        | None ->   args @ [ List.hd abound ],       efree,         List.tl abound)
      ([], efree, abound) nl
  in
  let erhs = List.map a2e arhs in

  let elhs = Al.Al_util.callE (id, args) ~note:Al.Al_util.no_note in
  let erhs = (match erhs with
    | [ e ] -> e
    | _ -> Al.Al_util.tupE erhs ~note:Al.Al_util.no_note)
  in
  elhs, erhs

(* Translation from Al exp to El exp *)

let (let*) = Option.bind

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
        Some (El.Ast.DotP (elp, a)))
    in
    Option.map (fun elp' -> elp' $ no_region) elp'
  in
  List.fold_left
    (fun elp p -> Option.bind elp (fold_path p))
    (Some (El.Ast.RootP $ no_region)) pl

and al_to_el_arg arg =
  match arg.it with
  | Al.Ast.ExpA e ->
    let* ele = al_to_el_expr e in
    Some (El.Ast.ExpA ele)
  | Al.Ast.TypA _typ ->
    (* TODO: Require Il.Ast.typ to El.Ast.typ translation *)
    Some (El.Ast.(TypA (VarT ("TODO" $ arg.at, []) $ arg.at)))

and al_to_el_args args =
  List.fold_left
    (fun args a ->
      let* args = args in
      let* arg = al_to_el_arg a in
      Some (args @ [ arg ]))
    (Some []) args

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
    | Al.Ast.CallE (id, al) ->
      let elid = id $ no_region in
      let* elal = al_to_el_args al in
      let elal = List.map
        (fun elarg ->
          (ref elarg) $ no_region)
        elal
      in
      Some (El.Ast.CallE (elid, elal))
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
          Some (El.Ast.DotE (ele, a)))
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
    | Al.Ast.CaseE2 (op, el) ->
      let elal = mixop_to_el_exprs op in
      let* elel = al_to_el_exprs el in
      let ele = El.Ast.SeqE (case_to_el_exprs elal elel) in
      (match elel with
      | _::_ -> Some (El.Ast.ParenE (ele $ no_region, `Insig))
      | [] -> Some ele
      )
    | Al.Ast.OptE (Some e) ->
      let* ele = al_to_el_expr e in
      Some (ele.it)
    | Al.Ast.OptE None -> Some (El.Ast.EpsE)
    | _ -> None
  in
  Option.map (fun exp' -> exp' $ no_region) exp'

and case_to_el_exprs al el =
  match al with
  | [] -> error no_region "empty mixop in a AL case expr"
  | hd::tl ->
    List.fold_left2 (fun acc a e -> a::Some(e)::acc) [ hd ] tl el
    |> List.filter_map (fun x -> x)
    |> List.rev

and mixop_to_el_exprs op =
  List.map
    (fun al ->
      match al with
      | [ a ] -> Some((El.Ast.AtomE a) $ no_region)
      | _ -> None
    )
  op

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
      let elelem = El.Ast.Elem (a, ele) in
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
  let sela = Backend_latex.Render.render_atom env.render_latex a in
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
  | Al.Ast.InvCallE (id, nl, al) ->
    let e =
      if id = "lsizenn" || id = "lsizenn1" || id = "lsizenn2" then Al.Al_util.varE "N" ~note:Al.Al_util.no_note
      else if List.length nl = 1 then Al.Al_util.varE "fresh" ~note:Al.Al_util.no_note
      else
        let el =
          nl
          |> List.filter_map (Option.map (fun x -> Al.Al_util.varE ("fresh_" ^ (string_of_int x)) ~note:Al.Al_util.no_note))
        in
        Al.Al_util.tupE el ~note:Al.Al_util.no_note
    in
    let elhs, erhs = al_invcalle_to_al_bine e id nl al in
    sprintf "%s for which %s %s %s"
      (render_expr env e)
      (render_expr env elhs)
      (render_math "=")
      (render_expr env erhs)
  | Al.Ast.LenE e ->
    let se = render_expr env e in
    sprintf "the length of %s" se
  | Al.Ast.IterE (e, ids, iter) when al_to_el_expr e = None ->
    let se = render_expr env e in
    let ids = Al.Al_util.tupE (List.map (Al.Al_util.varE ~note:Al.Al_util.no_note) ids) ~note:Al.Al_util.no_note in
    let loop = Al.Al_util.iterE (ids, [], iter) ~note:Al.Al_util.no_note in
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
  | Al.Ast.ChooseE e ->
    let se = render_expr env e in
    sprintf "an element of %s" se
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
    if env.config.panic_on_error then (
      let msg = sprintf "expr cannot be rendered %s" se in
      error expr.at msg);
    se

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
  | IsValidI (c_opt, e, el) ->
    sprintf "* %s%s is valid%s."
      (render_opt "Under the context " (render_expr env) ", " c_opt)
      (render_expr env e)
      (if el = [] then "" else " with type " ^ render_list (render_expr env) " and " el)
  | MatchesI (e1, e2) ->
    sprintf "* %s matches %s."
      (String.capitalize_ascii (render_expr env e1))
      (render_expr env e2)
  | IsConstI (c_opt, e) ->
    sprintf "* %s%s is const."
      (render_opt "Under the context " (render_expr env) ", " c_opt)
      (render_expr env e)
  | IfI (c, il) ->
    sprintf "* If %s,%s"
      (render_expr env c)
      (render_prose_instrs env (depth + 1) il)
  | ForallI (iters, il) ->
    let render_iter env (e1, e2) = (render_expr env e1) ^ " in " ^ (render_expr env e2) in
    let render_iters env iters = List.map (render_iter env) iters |> String.concat " and " in
    sprintf "* For all %s,%s"
      (render_iters env iters)
      (render_prose_instrs env (depth + 1) il)
  | EquivI (c1, c2) ->
    sprintf "* %s if and only if %s."
      (String.capitalize_ascii (render_expr env c1))
      (render_expr env c2)
  | EitherI ill ->
    let il_head, ill = List.hd ill, List.tl ill in
    let sil_head = render_prose_instrs env (depth + 1) il_head in
    let sill =
      List.fold_left
        (fun sill il ->
          sprintf "%s%s* Or:%s"
            sill
            (repeat indent depth)
            (render_prose_instrs env (depth + 1) il))
        "" ill
    in
    sprintf "* Either:%s\n\n%s" sil_head sill
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
  | Al.Ast.LetI (e, { it = Al.Ast.IterE ({ it = Al.Ast.InvCallE (id, nl, al); _ }, ids, iter); _ }) ->
    let elhs, erhs = al_invcalle_to_al_bine e id nl al in
    let ebin = Al.Al_util.binE (Al.Ast.EqOp, elhs, erhs) ~note:Al.Al_util.no_note in
    let eiter = Al.Al_util.iterE (ebin, ids, iter) ~note:Al.Al_util.no_note in
    sprintf "%s Let %s be the result for which %s."
      (render_order index depth)
      (render_expr env e)
      (render_expr env eiter)
  | Al.Ast.LetI (e, { it = Al.Ast.InvCallE (id, nl, al); _ }) ->
    let elhs, erhs = al_invcalle_to_al_bine e id nl al in
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
      (render_expr env e2) (render_expr env e1)
      (render_al_instrs env algoname (depth + 1) il)
  | Al.Ast.ExecuteI e ->
    sprintf "%s Execute the instruction %s." (render_order index depth) (render_expr env e)
  | Al.Ast.ExecuteSeqI e ->
    sprintf "%s Execute the sequence %s." (render_order index depth) (render_expr env e)
  | Al.Ast.PerformI (n, es) ->
    sprintf "%s Perform %s." (render_order index depth) (render_expr env (Al.Al_util.callE (n, es) ~at:no_region ~note:Al.Al_util.no_note))
  | Al.Ast.ExitI a ->
    sprintf "%s Exit from %s." (render_order index depth) (render_atom env a)
  | Al.Ast.ReplaceI (e1, p, e2) ->
    sprintf "%s Replace %s with %s." (render_order index depth)
      (render_expr env (Al.Al_util.accE (e1, p) ~note:Al.Al_util.no_note ~at:no_region)) (render_expr env e2)
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
  let name' =
    match name.it with
    | El.Atom.Atom "label" -> El.Atom.Atom "LABEL_"
    | El.Atom.Atom "frame" -> El.Atom.Atom "FRAME_"
    | El.Atom.Atom s -> El.Atom.Atom (String.uppercase_ascii s)
    | _ -> name.it
  in
  let name = name' $$ no_region % name.note in
  let op = [name] :: List.init (List.length params) (fun _ -> []) in
  let params = List.filter_map (fun a -> match a.it with Al.Ast.ExpA e -> Some e | _ -> None) params in
  let expr = Al.Al_util.caseE2 (op, params) ~at:no_region ~note:Al.Al_util.no_note in
  match al_to_el_expr expr with
  | Some ({ it = El.Ast.ParenE (exp, _); _ }) -> render_el_exp env exp
  | Some exp -> render_el_exp env exp
  | None -> render_expr' env expr

let render_funcname_title env fname params =
  render_expr env (Al.Al_util.callE (fname, params) ~at:no_region ~note:Al.Al_util.no_note)

let _render_pred env name params instrs =
  let title = render_atom_title env name params in
  title ^ "\n" ^
  String.make (String.length title) '.' ^ "\n" ^
  render_prose_instrs env 0 instrs

let render_iff env concl prems =
  match prems with
  | [] -> render_prose_instr env 0 concl
  | _ ->
      let sconcl = render_prose_instr env 0 concl in
      let sconcl = String.sub sconcl 0 (String.length sconcl - 1) in
      let sprems = render_prose_instrs env 1 prems in
      sprintf "%s if and only if:\n%s" sconcl sprems

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
  | Iff (_, _, concl, prems) ->
      "\n" ^ render_iff env concl prems ^ "\n\n"
  | Algo algo -> (match algo.it with
    | Al.Ast.RuleA (name, _, params, instrs) ->
      "\n" ^ render_rule env name params instrs ^ "\n\n"
    | Al.Ast.FuncA (name, params, instrs) ->
      "\n" ^ render_func env name params instrs ^ "\n\n")

let render_prose env prose = List.map (render_def env) prose |> String.concat ""

open Prose
open Printf
open Config
open Util.Source

(* Environment *)

module Set = Set.Make(String)
module Map = Map.Make(String)

type env =
  {
    config: config;
    prose: prose;
    render_latex: Backend_latex.Render.env;
    symbol: Symbol.env;
    macro: Macro.env;
  }

let gen_macro env =
  if env.config.macros then
    Macro.gen_macro env.macro env.symbol

let env config inputs outputs render_latex el prose : env =
  let symbol = Symbol.env el in
  let macro = Macro.env inputs outputs in
  let env = { config; prose; render_latex; symbol; macro; } in
  env

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
  | Al.Ast.ExpOp -> Some El.Ast.ExpOp
  | _ -> None

let al_to_el_infixop = function
  | "->" -> Some El.Ast.Arrow
  | s -> Some (El.Ast.Atom s)

let rec al_to_el_iter iter = match iter with
  | Al.Ast.Opt -> Some El.Ast.Opt
  | Al.Ast.List -> Some El.Ast.List
  | Al.Ast.List1 -> Some El.Ast.List1
  | Al.Ast.ListN (e, id) ->
      let* ele = al_to_el_exp e in
      let elid = Option.map (fun id -> id $ no_region) id in
      Some (El.Ast.ListN (ele, elid))

and al_to_el_path pl =
  let fold_path p elp = 
    let elp' = (match p.it with
      | Al.Ast.IdxP ei ->
          let* elei = al_to_el_exp ei in
          Some (El.Ast.IdxP (elp, elei))
      | Al.Ast.SliceP (el, eh) ->
          let* elel = al_to_el_exp el in
          let* eleh = al_to_el_exp eh in
          Some (El.Ast.SliceP (elp, elel, eleh))
      | Al.Ast.DotP kwd ->
          let (kwd, _) = kwd in
          let elatom = El.Ast.Atom kwd in
          Some (El.Ast.DotP (elp, elatom)))
    in
    Option.map (fun elp' -> elp' $ no_region) elp'
  in
  List.fold_left
    (fun elp p -> Option.bind elp (fold_path p))
    (Some (El.Ast.RootP $ no_region)) pl

and al_to_el_exp expr =
  let exp' =
    match expr.it with
    | Al.Ast.NumE i -> 
        let ei = Int64.to_int i in
        let eli = El.Ast.NatE (El.Ast.DecOp, ei) in
        Some eli
    | Al.Ast.UnE (op, e) ->
        let* elop = al_to_el_unop op in 
        let* ele = al_to_el_exp e in
        Some (El.Ast.UnE (elop, ele))
    | Al.Ast.BinE (op, e1, e2) ->
        let* elop = al_to_el_binop op in
        let* ele1 = al_to_el_exp e1 in
        let* ele2 = al_to_el_exp e2 in
        Some (El.Ast.BinE (ele1, elop, ele2))
    | Al.Ast.TupE el ->
        let* elel = al_to_el_exps el in
        Some (El.Ast.TupE elel)
    | Al.Ast.CallE (id, el) ->
        let elid = id $ no_region in
        let* elel = al_to_el_exps el in
        let elel = List.map
          (fun ele ->
            let elarg = El.Ast.ExpA ele in
            (ref elarg) $ no_region)
          elel
        in
        Some (El.Ast.CallE (elid, elel))
    | Al.Ast.CatE (e1, e2) ->
        let* ele1 = al_to_el_exp e1 in
        let* ele2 = al_to_el_exp e2 in
        Some (El.Ast.SeqE [ ele1; ele2 ])
    | Al.Ast.LenE e ->
        let* ele = al_to_el_exp e in
        Some (El.Ast.LenE ele)
    | Al.Ast.ListE el ->
        let* elel = al_to_el_exps el in
        if (List.length elel > 0) then Some (El.Ast.SeqE elel)
        else Some (El.Ast.EpsE)
    | Al.Ast.AccE (e, p) ->
        let* ele = al_to_el_exp e in
        (match p.it with
        | Al.Ast.IdxP ei ->
            let* elei = al_to_el_exp ei in
            Some (El.Ast.IdxE (ele, elei))
        | Al.Ast.SliceP (el, eh) ->
            let* elel = al_to_el_exp el in
            let* eleh = al_to_el_exp eh in
            Some (El.Ast.SliceE (ele, elel, eleh))
        | DotP (kwd, _) ->
            let elatom = El.Ast.Atom kwd in
            Some (El.Ast.DotE (ele, elatom)))
    | Al.Ast.UpdE (e1, pl, e2) ->
        let* ele1 = al_to_el_exp e1 in
        let* elp = al_to_el_path pl in
        let* ele2 = al_to_el_exp e2 in
        Some (El.Ast.UpdE (ele1, elp, ele2))
    | Al.Ast.ExtE (e1, pl, e2, _) ->
        let* ele1 = al_to_el_exp e1 in
        let* elp = al_to_el_path pl in
        let* ele2 = al_to_el_exp e2 in
        Some (El.Ast.ExtE (ele1, elp, ele2))
    | Al.Ast.StrE r ->
        let* elexpfield = al_to_el_expfield r in
        Some (El.Ast.StrE elexpfield)
    | Al.Ast.VarE id | Al.Ast.SubE (id, _) -> 
        let elid = id $ no_region in
        Some (El.Ast.VarE (elid, []))
    | Al.Ast.IterE (e, _, iter) ->
        let* ele = al_to_el_exp e in
        let* eliter = al_to_el_iter iter in
        Some (El.Ast.IterE (ele, eliter))
    | Al.Ast.InfixE (e1, op, e2) ->
        let* ele1 = al_to_el_exp e1 in
        let* elop = al_to_el_infixop op in
        let* ele2 = al_to_el_exp e2 in
        Some (El.Ast.InfixE (ele1, elop, ele2))
    | Al.Ast.CaseE ((kwd, _), el) ->
        let ekwd = (El.Ast.AtomE (El.Ast.Atom kwd)) $ no_region in
        let* elel = al_to_el_exps el in
        Some (El.Ast.SeqE ([ ekwd ] @ elel))
    | Al.Ast.OptE (Some e) ->
        let* ele = al_to_el_exp e in
        Some (ele.it)
    | Al.Ast.OptE None -> Some (El.Ast.EpsE)
    | _ -> None
  in
  Option.map (fun exp' -> exp' $ no_region) exp'

and al_to_el_exps exprs =
  List.fold_left
    (fun exps e ->
      let* exps = exps in
      let* exp = al_to_el_exp e in
      Some (exps @ [ exp ]))
    (Some []) exprs

and al_to_el_expfield record =
  Util.Record.fold
    (fun (kwd, _) e expfield ->
      let* expfield = expfield in
      let elatom = El.Ast.Atom kwd in
      let* ele = al_to_el_exp e in
      let elelem = El.Ast.Elem (elatom, ele) in
      Some (expfield @ [ elelem ]))
    record (Some [])

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

  let num_idx = string_of_int !index in
  let alp_idx = Char.escaped (Char.chr (96 + !index)) in

  match depth mod 4 with
  | 0 -> num_idx ^ "."
  | 1 -> alp_idx ^ "."
  | 2 -> num_idx ^ ")"
  | 3 -> alp_idx ^ ")"
  | _ -> failwith "unreachable"

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
  | Al.Ast.MinusOp -> "-"

let render_al_binop = function
  | Al.Ast.AndOp -> "and"
  | Al.Ast.OrOp -> "or"
  | Al.Ast.ImplOp -> "implies"
  | Al.Ast.EquivOp -> "is equivanlent to"
  | Al.Ast.AddOp -> "+"
  | Al.Ast.SubOp -> "-"
  | Al.Ast.MulOp -> "\\cdot"
  | Al.Ast.DivOp -> "/"
  | Al.Ast.ExpOp -> "^"
  | Al.Ast.EqOp -> "is"
  | Al.Ast.NeOp -> "is not"
  | Al.Ast.LtOp -> "is less than"
  | Al.Ast.GtOp -> "is greater than"
  | Al.Ast.LeOp -> "is less than or equal to"
  | Al.Ast.GeOp -> "is greater than or equal to"

(* Names and Iters *)

let rec render_name name = match String.index_opt name '_' with
  | Some idx ->
      let base = String.sub name 0 idx in
      let subscript = String.sub name (idx + 1) ((String.length name) - idx - 1) in
      base ^ "_{" ^ subscript ^ "}"
  | _ -> name

and render_kwd env kwd = match Symbol.narrow_kwd env.symbol kwd with
  | Some kwd ->
      let lhs, rhs = Macro.macro_kwd env.macro kwd in
      if env.config.macros then lhs else rhs
  | None -> render_name (Al.Print.string_of_kwd kwd)


(* Expressions and Paths *)

(* Invariant: All AL expressions fall into one of the three categories:
  1. EL-like expression, only containing EL subexpressions
  2. AL-only expression, possibly containing EL subexpressions 
  3. pseudo-EL-like expression, containing at least one AL-only subexpression *)

(* Category 1 is translated to EL then rendered by the Latex backend *)

and render_expr env expr = match al_to_el_exp expr with
  | Some exp -> 
      (* embedded math blocks cannot have line-breaks *)
      let newline = Str.regexp "\n" in
      let sexp = Backend_latex.Render.render_exp env.render_latex exp in
      let sexp = Str.global_replace newline "" sexp in
      render_math sexp
  | None -> render_expr' env expr

(* Categories 2 and 3 are rendered by the prose backend,
   yet EL subexpressions are still rendered by the Latex backend *)

and render_expr' env expr =
  match expr.it with
  | Al.Ast.BoolE b -> string_of_bool b
  | Al.Ast.UnE (NotOp, { it = Al.Ast.IsCaseOfE (e, kwd); _ }) ->
      let se = render_expr env e in
      let skwd = render_math (render_kwd env kwd) in
      sprintf "%s is not of the case %s" se skwd
  | Al.Ast.UnE (NotOp, { it = Al.Ast.IsDefinedE e; _ }) ->
      let se = render_expr env e in
      sprintf "%s is not defined" se
  | Al.Ast.UnE (NotOp, { it = Al.Ast.IsValidE e; _ }) ->
      let se = render_expr env e in
      sprintf "%s is not valid" se
  | Al.Ast.UnE (op, e) when Option.is_none (al_to_el_unop op) ->
      let sop = render_al_unop op in
      let se = render_expr env e in
      sprintf "%s %s" sop se
  | Al.Ast.BinE (op, e1, e2) when Option.is_none (al_to_el_binop op)  ->
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
  | Al.Ast.IterE (e, ids, iter) when Option.is_none (al_to_el_exp e) ->
      let se = render_expr env e in
      let ids = Al.Al_util.tupE (List.map Al.Al_util.varE ids) in
      let loop = Al.Al_util.iterE (ids, [], iter) in
      let sloop = render_expr env loop in
      sprintf "for all %s, %s" sloop se
  | Al.Ast.ArityE e -> 
      let se = render_expr env e in
      sprintf "the arity of %s" se 
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
  | Al.Ast.ContextKindE (kwd, e) ->
      let skwd = render_math (render_kwd env kwd) in
      let se = render_expr env e in
      sprintf "%s is %s" se skwd
  | Al.Ast.IsDefinedE e ->
      let se = render_expr env e in
      sprintf "%s is defined" se
  | Al.Ast.IsCaseOfE (e, kwd) ->
      let se = render_expr env e in
      let skwd = render_math (render_kwd env kwd) in
      sprintf "%s is of the case %s" se skwd
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
      let s = Al.Print.string_of_expr expr in
      let at = Util.Source.string_of_region expr.at in
      sprintf "warning: %s (%s) was not properly handled by prose backend\n" s at
      |> failwith;

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
  | Al.Ast.DotP (s, _) -> s 

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
      sprintf "* %s and %s are equivalent."
        (String.capitalize_ascii (render_expr env c1))
        (render_expr env c2)
  | YetI s ->
      sprintf "* YetI: %s." s

and render_prose_instrs env depth instrs =
  List.fold_left
    (fun sinstrs i ->
      sinstrs ^ "\n\n" ^ repeat indent depth ^ render_prose_instr env depth i)
    "" instrs

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
      sprintf "%s Push %s to the stack." (render_order index depth)
        (render_expr env e)
  (* TODO hardcoded for PopI on label or frame by raw string *)
  | Al.Ast.PopI ({ it = Al.Ast.VarE s; _ }) when s = "the label" || s = "the frame" ->
      sprintf "%s Pop %s from the stack." (render_order index depth) s
  | Al.Ast.PopI e ->
      sprintf "%s Pop %s from the stack." (render_order index depth)
        (render_expr env e)
  | Al.Ast.PopAllI e ->
      sprintf "%s Pop all values %s from the stack." (render_order index depth)
        (render_expr env e)
  | Al.Ast.LetI (n, e) ->
      sprintf "%s Let %s be %s." (render_order index depth) (render_expr env n)
        (render_expr env e)
  | Al.Ast.TrapI -> sprintf "%s Trap." (render_order index depth)
  | Al.Ast.NopI -> sprintf "%s Do nothing." (render_order index depth)
  | Al.Ast.ReturnI e_opt ->
      sprintf "%s Return%s." (render_order index depth)
        (render_opt " " (render_expr env) "" e_opt)
  | Al.Ast.EnterI (e1, e2, il) ->
      sprintf "%s Enter %s with label %s:%s" (render_order index depth)
        (render_expr env e1) (render_expr env e2)
        (render_al_instrs env algoname (depth + 1) il)
  | Al.Ast.ExecuteI e ->
      sprintf "%s Execute %s." (render_order index depth) (render_expr env e)
  | Al.Ast.ExecuteSeqI e ->
      sprintf "%s Execute the sequence %s." (render_order index depth) (render_expr env e)
  | Al.Ast.PerformI (n, es) ->
      sprintf "%s Perform %s." (render_order index depth) (render_expr env (Al.Ast.CallE (n, es) $ no_region))
  | Al.Ast.ExitI -> render_order index depth ^ " Exit current context."
  | Al.Ast.ReplaceI (e1, p, e2) ->
      sprintf "%s Replace %s with %s." (render_order index depth)
        (render_expr env (Al.Ast.AccE (e1, p) $ no_region)) (render_expr env e2)
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

let render_kwd_title env kwd params =
  (* TODO a workaround, for algorithms named label or name
     that are defined as LABEL_ or FRAME_ in the dsl *)
  let (name, syntax) = kwd in
  let kwd =
    if name = "LABEL" then ("LABEL_", syntax)
    else if name = "FRAME" then ("FRAME_", syntax)
    else kwd
  in
  render_expr env (Al.Ast.CaseE (kwd, params) $ no_region)

let render_funcname_title env fname params =
  render_expr env (Al.Ast.CallE (fname, params) $ no_region)

let render_pred env name params instrs =
  let (pname, syntax) = name in
  let kwd = (String.uppercase_ascii pname, syntax) in
  let title = render_kwd_title env kwd params in
  title ^ "\n" ^
  String.make (String.length title) '.' ^ "\n" ^
  render_prose_instrs env 0 instrs

let render_rule env name params instrs =
  let (rname, syntax) = name in
  let kwd = (String.uppercase_ascii rname, syntax) in
  let title = render_kwd_title env kwd params in
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

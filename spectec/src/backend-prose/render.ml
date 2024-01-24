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
    symbol: Symbol.env;
    macro: Macro.env;
    hint: Hint.env;
  }

let gen_macro env =
  if env.config.macros then
    Macro.gen_macro env.macro env.symbol

let env config inputs outputs render_latex el prose : env =
  let symbol = Symbol.env el in
  let macro = Macro.env inputs outputs in
  let hint = Hint.env render_latex el in
  let env = { config; prose; symbol; macro; hint; } in
  env

(* Helpers *)

let indent = "   "

let rec repeat str num =
  if num = 0 then ""
  else if Int.rem num 2 = 0 then repeat (str ^ str) (num / 2)
  else str ^ repeat (str ^ str) (num / 2)

let math = ":math:"

let render_math s = math ^ sprintf "`%s`" s

let force_math in_math s = if in_math then s else render_math s

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

let render_list stringifier left sep right = function
  | [] -> left ^ right
  | h :: t ->
      let limit = 16 in
      let is_long = List.length t > limit in
      left
      ^ List.fold_left
          (fun acc elem -> acc ^ sep ^ stringifier elem)
          (stringifier h) (List.filteri (fun i _ -> i <= limit) t)
      ^ (if is_long then (sep ^ "...") else "")
      ^ right

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

(* assume Names and Iters are always embedded in math blocks *)

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

and render_funcname env fname =
  if Symbol.find_func env.symbol fname
  then (
    let lhs, rhs = Macro.macro_func env.macro fname in
    if env.config.macros then lhs else rhs
  )
  else (
    let escape acc c =
      if c = '.' then acc ^ "{.}"
      else if c = '_' then acc ^ "\\_"
      else acc ^ (String.make 1 c)
    in
    String.fold_left escape "" fname
  )

let rec render_iter env = function
  | Al.Ast.Opt -> "^?"
  | Al.Ast.List -> "^\\ast"
  | Al.Ast.List1 -> "^{+}"
  | Al.Ast.ListN (expr, None) -> "^{" ^ render_expr env true expr ^ "}"
  | Al.Ast.ListN (expr, Some name) ->
      "^{(" ^ render_name name ^ "<" ^ render_expr env true expr ^ ")}"

and render_iters env iters = List.map (render_iter env) iters |> List.fold_left (^) ""

(* Expressions and Paths *)

and render_expr env in_math expr =
  match expr.it with
  | Al.Ast.NumE i ->
      let si = Int64.to_string i in
      if in_math then si else render_math si
  | Al.Ast.BoolE b ->
      string_of_bool b
  | Al.Ast.UnE (MinusOp, e) ->
      let se = render_expr env in_math e in
      let s = sprintf "-%s" se in
      force_math in_math s
  | Al.Ast.UnE (NotOp, { it = Al.Ast.IsCaseOfE (e, c); _ }) ->
      sprintf "%s is not of the case %s"
        (render_expr env in_math e)
        (render_math (render_kwd env c))
  | Al.Ast.UnE (NotOp, { it = Al.Ast.IsDefinedE e; _ }) ->
      sprintf "%s is not defined" (render_expr env in_math e)
  | Al.Ast.UnE (NotOp, { it = Al.Ast.IsValidE e; _ }) ->
      sprintf "%s is not valid" (render_expr env in_math e)
  | Al.Ast.UnE (op, e) ->
      sprintf "%s %s" (render_al_unop op) (render_expr env in_math e)
  | Al.Ast.BinE (op, e1, e2) ->
      let sop = render_al_binop op in
      let se1 = render_expr env true e1 in
      let se2 = render_expr env true e2 in
      let s =
        (match op with
        | AddOp | SubOp | MulOp | DivOp | ExpOp ->
          sprintf "{%s} %s {%s}" se1 sop se2
        | _ ->
          sprintf "%s \\textrm{ %s } %s" se1 sop se2)
      in
      force_math in_math s
  | Al.Ast.TupE el ->
      let sel = render_list (render_expr env true) "(" "~" ")" el in
      if in_math then sel else render_math sel
  | Al.Ast.CallE (fn, es) ->
      let sfn = render_funcname env fn in
      let ses = List.map (render_expr env true) es in
      let sdefault = sprintf "%s(%s)" sfn (String.concat ", " ses) in
      let shint =
        if Symbol.find_func env.symbol fn
        then Hint.apply_func_hint env.hint fn ses
        else None
      in
      let s = Option.value shint ~default:sdefault in
      force_math in_math s
  (* TODO a better way to flatten single-element list? *)
  | Al.Ast.CatE ({ it = Al.Ast.ListE e1; _ }, { it = Al.Ast.ListE e2; _ }) when List.length e1 = 1 && List.length e2 = 1 ->
      let se1 = render_expr env true (List.hd e1) in
      let se2 = render_expr env true (List.hd e2) in
      let s = sprintf "%s~%s" se1 se2 in
      force_math in_math s
  | Al.Ast.CatE ({ it = Al.Ast.ListE e1; _ }, e2) when List.length e1 = 1 ->
      let se1 = render_expr env true (List.hd e1) in
      let se2 = render_expr env true e2 in
      let s = sprintf "%s~%s" se1 se2 in
      force_math in_math s
  | Al.Ast.CatE (e1, { it = Al.Ast.ListE e2; _ }) when List.length e2 = 1 ->
      let se1 = render_expr env true e1 in
      let se2 = render_expr env true (List.hd e2) in
      let s = sprintf "%s~%s" se1 se2 in
      force_math in_math s
  | Al.Ast.CatE (e1, e2) ->
      let se1 = render_expr env true e1 in
      let se2 = render_expr env true e2 in
      let s = sprintf "%s~%s" se1 se2 in
      force_math in_math s
  | Al.Ast.LenE e ->
      let se = render_expr env true e in
      if in_math then "|" ^ se ^ "|" else "the length of " ^ render_math se
  | Al.Ast.ArityE e -> sprintf "the arity of %s" (render_expr env in_math e)
  | Al.Ast.GetCurLabelE -> "the current label"
  | Al.Ast.GetCurFrameE -> "the current frame"
  | Al.Ast.GetCurContextE -> "the current context"
  | Al.Ast.FrameE (None, e2) ->
      sprintf "the activation of %s" (render_expr env in_math e2)
  | Al.Ast.FrameE (Some e1, e2) ->
      sprintf "the activation of %s with arity %s" (render_expr env in_math e2)
        (render_expr env in_math e1)
  | Al.Ast.ListE el ->
      let sel =
        if List.length el > 0 then
          render_list (render_expr env true) "" "~" "" el
        else
          "\\epsilon"
      in
      if in_math then sel else render_math sel
  | Al.Ast.AccE (e, p) ->
      let se = render_expr env true e in
      let sp = render_path env p in
      let s = sprintf "%s%s" se sp in
      force_math in_math s
  | Al.Ast.ExtE (e1, ps, e2, dir) ->
      let se1 = render_expr env in_math e1 in
      let sps = render_paths env in_math ps in
      let se2 = render_expr env in_math e2 in
      if in_math then
        (match dir with
        | Al.Ast.Front -> sprintf "\\{%s~%s\\}~\\bigoplus~%s" sps se2 se1
        | Al.Ast.Back -> sprintf "%s~\\bigoplus~\\{%s~%s\\}" se1 sps se2)
      else
        (match dir with
        | Al.Ast.Front -> sprintf "%s with %s prepended by %s" se1 sps se2
        | Al.Ast.Back -> sprintf "%s with %s appended by %s" se1 sps se2)
  | Al.Ast.UpdE (e1, ps, e2) ->
      sprintf "%s with %s replaced by %s"
        (render_expr env in_math e1)
        (render_paths env in_math ps)
        (render_expr env in_math e2)
  | Al.Ast.StrE r ->
      let sr =
        Util.Record.fold
          (fun k v acc -> acc @ [ render_kwd env k ^ "~" ^ render_expr env true v ])
          r []
      in
      let sr = render_list Fun.id "\\{" ", " "\\}" sr in
      if in_math then sr else render_math sr
  | Al.Ast.ContE e -> sprintf "the continuation of %s" (render_expr env in_math e)
  | Al.Ast.LabelE (e1, e2) ->
      sprintf "the label whose arity is %s and whose continuation is %s" (render_expr env in_math e1) (render_expr env in_math e2)
  | Al.Ast.VarE n | Al.Ast.SubE (n, _) ->
      let sn = render_name n in
      if in_math then sn else render_math sn
  | Al.Ast.IterE ({ it = Al.Ast.VarE n; _ }, _, iter) ->
      let sn = render_name n in
      let siter = render_iter env iter in
      let s = sprintf "{%s}{%s}" sn siter in
      force_math in_math s
  | Al.Ast.IterE (e, _, iter) ->
      let se = render_expr env true e in
      let siter = render_iter env iter in
      let s = sprintf "{(%s)}{%s}" se siter in
      force_math in_math s
  | Al.Ast.InfixE (e1, infix, e2) ->
      let se1 = render_expr env true e1 in
      (* Hardcoded rendering of infix *)
      let sinfix =
        match infix with
        | "->" -> "\\to"
        | "X" -> "\\times"
        | _ -> infix
      in
      let se2 = render_expr env true e2 in
      let s = sprintf "%s %s %s" se1 sinfix se2 in
      force_math in_math s
  | Al.Ast.CaseE (kwd, es) ->
      let skwd = render_kwd env kwd in
      let ses = List.map (render_expr env true) es in
      let sdefault =
        if List.length ses = 0 then skwd
        else sprintf "%s~%s" skwd (String.concat "~" ses)
      in
      let shint =
        Option.map
          (fun kwd_narrow -> Hint.apply_kwd_hint env.hint kwd_narrow ses)
          (Symbol.narrow_kwd env.symbol kwd)
      in
      let shint = Option.join shint in
      let s = Option.value shint ~default:sdefault in
      force_math in_math s
  | Al.Ast.OptE (Some e) ->
      let se = render_expr env true e in
      let s = sprintf "{%s}^?" se in
      force_math in_math s
  | Al.Ast.OptE None ->
      let s = "\\epsilon" in
      force_math in_math s
  (* Assume conditional expressions are always embedded in math blocks. *)
  | Al.Ast.ContextKindE (kwd, e) ->
      let skwd = render_kwd env kwd in
      let se = render_expr env true e in
      let s = sprintf "%s\\textrm{ is }%s" se skwd in
      force_math in_math s
  | Al.Ast.IsDefinedE e ->
      let se = render_expr env true e in
      let s = sprintf "%s\\textrm{ is defined}" se in
      force_math in_math s
  | Al.Ast.IsCaseOfE (e, kwd) ->
      let se = render_expr env true e in
      let skwd = render_kwd env kwd in
      let s = sprintf "%s\\textrm{ is of the case }%s" se skwd in
      force_math in_math s
  | Al.Ast.HasTypeE (e, t) ->
      let se = render_expr env true e in
      let s = sprintf "\\textrm{the type of }%s\\textrm{ is }%s" se t in
      force_math in_math s
  | Al.Ast.IsValidE e ->
      let se = render_expr env true e in
      let s = sprintf "%s\\textrm{ is valid}" se in
      force_math in_math s
  | Al.Ast.TopLabelE ->
      let s = "\\textrm{a label is now on the top of the stack}" in
      force_math in_math s
  | Al.Ast.TopFrameE ->
      let s = "\\textrm{a frame is now on the top of the stack}" in
      force_math in_math s
  | Al.Ast.TopValueE (Some e) ->
      let se = render_expr env true e in
      let s = sprintf "\\textrm{a value of value type }%s\\textrm{ is on the top of the stack}" se in
      force_math in_math s
  | Al.Ast.TopValueE None ->
      let s = "\\textrm{a value is on the top of the stack}" in
      force_math in_math s
  | Al.Ast.TopValuesE e ->
      let se = render_expr env true e in
      let s = sprintf "\\textrm{there are at least }%s\\textrm{ values on the top of the stack}" se in
      force_math in_math s
  | Al.Ast.MatchE (e1, e2) ->
      let se1 = render_expr env true e1 in
      let se2 = render_expr env true e2 in
      let s = sprintf "%s\\textrm{ matches }%s" se1 se2 in
      force_math in_math s
  | Al.Ast.YetE s -> sprintf "YetE (%s)" s

(* assume Paths are always embedded in math blocks *)

and render_path env path =
  match path.it with
  | Al.Ast.IdxP e -> sprintf "[%s]" (render_expr env true e)
  | Al.Ast.SliceP (e1, e2) ->
      sprintf "[%s : %s]" (render_expr env true e1) (render_expr env true e2)
  | Al.Ast.DotP s -> sprintf ".%s" (render_kwd env s)

and render_paths env in_math paths =
  let spaths = List.map (render_path env) paths |> List.fold_left (^) "" in
  if in_math then spaths else render_math spaths


(* Instructions *)

let rec render_prose_instr env depth = function
  | LetI (e1, e2) ->
      sprintf "* Let %s be %s."
        (render_expr env false e1)
        (render_expr env false e2)
  | CmpI (e1, cmpop, e2) ->
      sprintf "* %s must be %s %s."
        (String.capitalize_ascii (render_expr env false e1))
        (render_prose_cmpop cmpop)
        (render_expr env false e2)
  | MustValidI (e1, e2, e3) ->
      sprintf "* Under the context %s, %s must be valid%s."
        (render_expr env false e1)
        (render_expr env false e2)
        (render_opt " with type " (render_expr env false) "" e3)
  | MustMatchI (e1, e2) ->
      sprintf "* %s must match %s."
        (String.capitalize_ascii (render_expr env false e1))
        (render_expr env false e2)
  | IsValidI e ->
      sprintf "* The instruction is valid%s."
        (render_opt " with type " (render_expr env false) "" e)
  | IfI (c, is) ->
      sprintf "* If %s,%s"
        (render_expr env false c)
        (render_prose_instrs env (depth + 1) is)
  | ForallI (e1, e2, is) ->
      sprintf "* For all %s in %s,%s"
        (render_expr env false e1)
        (render_expr env false e2)
        (render_prose_instrs env (depth + 1) is)
  | EquivI (c1, c2) ->
      sprintf "* %s and %s are equivalent."
        (String.capitalize_ascii (render_expr env false c1))
        (render_expr env false c2)
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
      sprintf "%s If %s, then:%s" (render_order index depth) (render_expr env false c)
        (render_al_instrs env algoname (depth + 1) il)
  | Al.Ast.IfI (c, il1, [ { it = IfI (inner_c, inner_il1, []); _ } ]) ->
      let if_index = render_order index depth in
      let else_if_index = render_order index depth in
      sprintf "%s If %s, then:%s\n\n%s Else if %s, then:%s"
        if_index
        (render_expr env false c)
        (render_al_instrs env algoname (depth + 1) il1)
        (repeat indent depth ^ else_if_index)
        (render_expr env false inner_c)
        (render_al_instrs env algoname (depth + 1) inner_il1)
  | Al.Ast.IfI (c, il1, [ { it = IfI (inner_c, inner_il1, inner_il2); _ } ]) ->
      let if_index = render_order index depth in
      let else_if_index = render_order index depth in
      let else_index = render_order index depth in
      sprintf "%s If %s, then:%s\n\n%s Else if %s, then:%s\n\n%s Else:%s"
        if_index
        (render_expr env false c)
        (render_al_instrs env algoname (depth + 1) il1)
        (repeat indent depth ^ else_if_index)
        (render_expr env false inner_c)
        (render_al_instrs env algoname (depth + 1) inner_il1)
        (repeat indent depth ^ else_index)
        (render_al_instrs env algoname (depth + 1) inner_il2)
  | Al.Ast.IfI (c, il1, il2) ->
      let if_index = render_order index depth in
      let else_index = render_order index depth in
      sprintf "%s If %s, then:%s\n\n%s Else:%s" if_index (render_expr env false c)
        (render_al_instrs env algoname (depth + 1) il1)
        (repeat indent depth ^ else_index)
        (render_al_instrs env algoname (depth + 1) il2)
  | Al.Ast.OtherwiseI il ->
      sprintf "%s Otherwise:%s" (render_order index depth)
        (render_al_instrs env algoname (depth + 1) il)
  | Al.Ast.EitherI (il1, il2) ->
      let either_index = render_order index depth in
      let or_index = render_order index depth in
      sprintf "%s Either:%s\n\n%s Or:%s" either_index
        (render_al_instrs env algoname (depth + 1) il1)
        (repeat indent depth ^ or_index)
        (render_al_instrs env algoname (depth + 1) il2)
  | Al.Ast.AssertI c ->
      let vref = if Macro.find_section env.macro ("valid-" ^ algoname) then ":ref:`validation <valid-" ^ algoname ^">`" else "validation" in
      sprintf "%s Assert: Due to %s, %s." (render_order index depth) vref (render_expr env false c)
  | Al.Ast.PushI e ->
      sprintf "%s Push %s to the stack." (render_order index depth)
        (render_expr env false e)
  (* TODO hardcoded for PopI on label or frame by raw string *)
  | Al.Ast.PopI ({ it = Al.Ast.VarE s; _ }) when s = "the label" || s = "the frame" ->
      sprintf "%s Pop %s from the stack." (render_order index depth) s
  | Al.Ast.PopI e ->
      sprintf "%s Pop %s from the stack." (render_order index depth)
        (render_expr env false e)
  | Al.Ast.PopAllI e ->
      sprintf "%s Pop all values %s from the stack." (render_order index depth)
        (render_expr env false e)
  | Al.Ast.LetI (n, e) ->
      sprintf "%s Let %s be %s." (render_order index depth) (render_expr env false n)
        (render_expr env false e)
  | Al.Ast.TrapI -> sprintf "%s Trap." (render_order index depth)
  | Al.Ast.NopI -> sprintf "%s Do nothing." (render_order index depth)
  | Al.Ast.ReturnI e_opt ->
      sprintf "%s Return%s." (render_order index depth)
        (render_opt " " (render_expr env false) "" e_opt)
  | Al.Ast.EnterI (e1, e2, il) ->
      sprintf "%s Enter %s with label %s:%s" (render_order index depth)
        (render_expr env false e1) (render_expr env false e2)
        (render_al_instrs env algoname (depth + 1) il)
  | Al.Ast.ExecuteI e ->
      sprintf "%s Execute %s." (render_order index depth) (render_expr env false e)
  | Al.Ast.ExecuteSeqI e ->
      sprintf "%s Execute the sequence %s." (render_order index depth) (render_expr env false e)
  | Al.Ast.PerformI (n, es) ->
      sprintf "%s Perform %s." (render_order index depth) (render_expr env false (Al.Ast.CallE (n, es) $ instr.at))
  | Al.Ast.ExitI -> render_order index depth ^ " Exit current context."
  | Al.Ast.ReplaceI (e1, p, e2) ->
      sprintf "%s Replace %s with %s." (render_order index depth)
        (render_expr env false (Al.Ast.AccE (e1, p) $ e1.at)) (render_expr env false e2)
  | Al.Ast.AppendI (e1, e2) ->
      sprintf "%s Append %s to the %s." (render_order index depth)
        (render_expr env false e2) (render_expr env false e1)
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
  render_expr env false (Al.Ast.CaseE (kwd, params) $ no_region)

let render_funcname_title env fname params =
  render_expr env false (Al.Ast.CallE (fname, params) $ no_region)

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

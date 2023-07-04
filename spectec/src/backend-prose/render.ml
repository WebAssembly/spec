open Prose
open Printf

(* Helpers *)

let indent = "   "

let rec repeat str num =
  if num = 0 then ""
  else if Int.rem num 2 = 0 then repeat (str ^ str) (num / 2)
  else str ^ repeat (str ^ str) (num / 2)

let math = ":math:"

let render_math s = math ^ sprintf "`%s`" s

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

let render_al_cmpop = function
  | Al.Ast.Eq -> "is"
  | Al.Ast.Ne -> "is not"
  | Al.Ast.Gt -> "greater than"
  | Al.Ast.Ge -> "greater than or equal to"
  | Al.Ast.Lt -> "less than"
  | Al.Ast.Le -> "less than or equal to"

let render_al_logop = function
  | Al.Ast.And -> "and"
  | Al.Ast.Or -> "or"
  | Al.Ast.Impl -> "=>"
  | Al.Ast.Equiv -> "<=>"

let render_al_mathop = function
  | Al.Ast.Add -> "+"
  | Al.Ast.Sub -> "-"
  | Al.Ast.Mul -> "·"
  | Al.Ast.Div -> "/"
  | Al.Ast.Exp -> "^"

(* Names and Iters *)

let rec render_name = function
  | Al.Ast.N s ->
      let sprefix = 
        if String.contains s '_' then (
          let i = String.index s '_' in
          String.sub s 0 i)
        else s
      in
      if String.length sprefix > 1 then
        sprintf "\\%s" s
      else
        s
  | Al.Ast.SubN (n, s) -> sprintf "%s_%s" (render_name n) s

let render_iter = function
  | Al.Ast.Opt -> "^?"
  | Al.Ast.List -> "^\\ast"
  | Al.Ast.List1 -> "+"
  | Al.Ast.ListN name -> "^" ^ render_name name

let render_iters iters = List.map render_iter iters |> List.fold_left (^) ""

(* Expressions and Paths *)

let rec render_expr in_math = function
  | Al.Ast.NumE i ->
      let si = Int64.to_string i in
      if in_math then si else render_math si
  | Al.Ast.StringE s -> s
  | Al.Ast.MinusE e ->
      let se = render_expr in_math e in
      let s = sprintf "-%s" se in
      if in_math then s else render_math s
  | Al.Ast.BinopE (op, e1, e2) ->
      let sop = render_al_mathop op in
      let se1 = render_expr true e1 in
      let se2 = render_expr true e2 in
      let s = sprintf "%s%s%s" se1 sop se2 in
      if in_math then s else render_math s
  | Al.Ast.PairE (e1, e2) ->
      let se1 = render_expr true e1 in
      let se2 = render_expr true e2 in
      let s = sprintf "%s~%s" se1 se2 in
      if in_math then s else render_math s
  | Al.Ast.AppE (n, es) ->
      let sn = render_name n in
      let ses = render_list (render_expr true) "" ", " "" es in
      let s = sprintf "%s(%s)" sn ses in
      if in_math then s else render_math s
  | Al.Ast.MapE (n, el, iters) ->
      sprintf "$%s(%s)%s" (render_name n)
        (render_list (render_expr in_math) "" ", " "" el)
        (render_iters iters)
  (* TODO a better way to flatten single-element list? *)
  | Al.Ast.ConcatE (Al.Ast.ListE e1, Al.Ast.ListE e2) when List.length e1 = 1 && List.length e2 = 1 ->
      sprintf "%s~%s" (render_expr in_math (List.hd e1)) (render_expr in_math (List.hd e2))
  | Al.Ast.ConcatE (Al.Ast.ListE e1, e2) when List.length e1 = 1 ->
      sprintf "%s~%s" (render_expr in_math (List.hd e1)) (render_expr in_math e2)
  | Al.Ast.ConcatE (e1, Al.Ast.ListE e2) when List.length e2 = 1 ->
      sprintf "%s~%s" (render_expr in_math e1) (render_expr in_math (List.hd e2))
  | Al.Ast.ConcatE (e1, e2) ->
      sprintf "%s~%s" (render_expr in_math e1) (render_expr in_math e2)
  | Al.Ast.LengthE e ->
      let se = render_expr true e in
      "the length of " ^
      if in_math then se else render_math se
  | Al.Ast.ArityE e -> sprintf "the arity of %s" (render_expr in_math e)
  | Al.Ast.GetCurLabelE -> "the current label"
  | Al.Ast.GetCurFrameE -> "the current frame"
  | Al.Ast.GetCurContextE -> "the current context"
  | Al.Ast.FrameE (e1, e2) ->
      sprintf "the activation of %s with arity %s" (render_expr in_math e2)
        (render_expr in_math e1)
  | Al.Ast.ListE el -> render_list (render_expr in_math) "[" "~" "]" el
  | Al.Ast.ListFillE (e1, e2) -> render_expr in_math e1 ^ "^" ^ render_expr in_math e2
  | Al.Ast.AccessE (e, p) ->
      let se = render_expr true e in
      let sp = render_path true p in
      let s = sprintf "%s%s" se sp in
      if in_math then s else render_math s
  | Al.Ast.ExtendE (e1, ps, e2, dir) ->
      let se1 = render_expr in_math e1 in
      let sps = render_paths in_math ps in
      let se2 = render_expr in_math e2 in
      (match dir with
      | Al.Ast.Front -> sprintf "%s with %s prepended by %s" se1 sps se2
      | Al.Ast.Back -> sprintf "%s with %s appended by %s" se1 sps se2)
  | Al.Ast.ReplaceE (e1, ps, e2) ->
      sprintf "%s with %s replaced by %s" (render_expr in_math e1) (render_paths in_math ps) (render_expr in_math e2)
  | Al.Ast.RecordE r ->
      let keys = Al.Record.Record.keys r in
      let sfields =
        List.map
          (fun k ->
            let v = Al.Record.Record.find k r in
            render_name (N k) ^ "~" ^ render_expr true v)
          keys
      in
      let sr = render_list Fun.id "\\{ " ", " " \\}" sfields in
      if in_math then sr else render_math sr
  | Al.Ast.ContE e -> sprintf "the continuation of %s" (render_expr in_math e)
  | Al.Ast.LabelE (e1, e2) ->
      sprintf "the label whose arity is %s and whose continuation is %s" (render_expr in_math e1) (render_expr in_math e2)
  | Al.Ast.NameE n ->
      let sn = render_name n in
      if in_math then sn else render_math sn
  | Al.Ast.IterE (Al.Ast.NameE n, iter) ->
      let sn = render_name n in
      let siter = render_iter iter in
      let s = sprintf "%s%s" sn siter in
      if in_math then s else render_math s
  | Al.Ast.IterE (e, iter) -> render_expr in_math e ^ render_iter iter
  | Al.Ast.ArrowE (e1, e2) ->
      let se1 = (match e1 with ListE _ -> render_expr true e1 | _ -> "[" ^ render_expr true e1 ^ "]" ) in
      let se2 = (match e2 with ListE _ -> render_expr true e2 | _ -> "[" ^ render_expr true e2 ^ "]" ) in
      let s = sprintf "%s \\to %s" se1 se2 in
      if in_math then s else render_math s
  | Al.Ast.ConstructE (s, []) ->
      let s = sprintf "\\%s" (String.uppercase_ascii s) in
      if in_math then s else render_math s
  | Al.Ast.ConstructE (s, es) ->
      let s = String.uppercase_ascii s in
      let ses = render_list (render_expr true) "" "~" "" es in
      let s = sprintf "\\%s~%s" s ses in
      if in_math then s else render_math s
  | Al.Ast.OptE (Some e) -> "(" ^ render_expr in_math e ^ ")^?"
  | Al.Ast.OptE None -> "()^?"
  | Al.Ast.YetE s -> sprintf "YetE (%s)" s

and render_path in_math = function
  | Al.Ast.IndexP e -> sprintf "[%s]" (render_expr in_math e)
  | Al.Ast.SliceP (e1, e2) ->
      sprintf "[%s : %s]" (render_expr in_math e1) (render_expr in_math e2)
  | Al.Ast.DotP s -> sprintf ".%s" s

and render_paths in_math paths = List.map (render_path in_math) paths |> List.fold_left (^) ""

(* Conditions *)

and render_cond in_math = function
  | Al.Ast.NotC (Al.Ast.IsCaseOfC (e, c)) ->
      sprintf "%s is not of the case %s" (render_expr in_math e) c
  | Al.Ast.NotC (Al.Ast.IsDefinedC e) ->
      sprintf "%s is not defined" (render_expr in_math e)
  | Al.Ast.NotC (Al.Ast.ValidC e) ->
      sprintf "%s is not valid" (render_expr in_math e)
  | Al.Ast.NotC c -> sprintf "not %s" (render_cond in_math c)
  | Al.Ast.BinopC (op, c1, c2) ->
      sprintf "%s %s %s" (render_cond in_math c1) (render_al_logop op) (render_cond in_math c2)
  | Al.Ast.CompareC (op, e1, e2) ->
      sprintf "%s %s %s" (render_expr in_math e1) (render_al_cmpop op) (render_expr in_math e2)
  | Al.Ast.ContextKindC (s, e) -> sprintf "%s is %s" (render_expr in_math e) s
  | Al.Ast.IsDefinedC e -> sprintf "%s is defined" (render_expr in_math e)
  | Al.Ast.IsCaseOfC (e, c) -> sprintf "%s is of the case %s" (render_expr in_math e) c
  | Al.Ast.IsTopC s -> sprintf "the top of the stack is %s" s
  | Al.Ast.ValidC e -> sprintf "%s is valid" (render_expr in_math e)
  | Al.Ast.YetC s -> sprintf "YetC (%s)" s

(* Instructions *)

let rec render_prose_instr depth = function
  | LetI (e1, e2) ->
      sprintf "* Let %s be %s."
        (render_expr false e1)
        (render_expr false e2)
  | CmpI (e1, cmpop, e2) ->
      sprintf "* %s must be %s %s."
        (String.capitalize_ascii (render_expr false e1))
        (render_prose_cmpop cmpop)
        (render_expr false e2)
  | MustValidI (e1, e2, e3) ->
      sprintf "* Under the context %s, %s must be valid%s."
        (render_expr false e1)
        (render_expr false e2)
        (render_opt " with type " (render_expr false) "" e3)
  | MustMatchI (e1, e2) ->
      sprintf "* %s must match %s."
        (String.capitalize_ascii (render_expr false e1))
        (render_expr false e2)
  | IsValidI e ->
      sprintf "* The instruction is valid%s."
        (render_opt " with type " (render_expr false) "" e)
  | IfI (c, is) ->
      sprintf "* If %s,%s"
        (render_cond false c)
        (render_prose_instrs (depth + 1) is)
  | ForallI (e1, e2, is) ->
      sprintf "* For all %s in %s,%s"
        (render_expr false e1)
        (render_expr false e2)
        (render_prose_instrs (depth + 1) is)
  | EquivI (c1, c2) ->
      sprintf "* %s and %s are equivalent."
        (String.capitalize_ascii (render_cond false c1))
        (render_cond false c2)
  | YetI s ->
      sprintf "* YetI: %s." s

and render_prose_instrs depth instrs =
  List.fold_left
    (fun sinstrs i ->
      sinstrs ^ "\n\n" ^ repeat indent depth ^ render_prose_instr depth i)
    "" instrs

let rec render_al_instr index depth = function
  | Al.Ast.IfI (c, il, []) ->
      sprintf "%s If %s, then:%s" (render_order index depth) (render_cond false c)
        (render_al_instrs (depth + 1) il)
  | Al.Ast.IfI (c, il1, [ IfI (inner_c, inner_il1, []) ]) ->
      let if_index = render_order index depth in
      let else_if_index = render_order index depth in
      sprintf "%s If %s, then:%s\n\n%s Else if %s, then:%s"
        if_index
        (render_cond false c)
        (render_al_instrs (depth + 1) il1)
        (repeat indent depth ^ else_if_index)
        (render_cond false inner_c)
        (render_al_instrs (depth + 1) inner_il1)
  | Al.Ast.IfI (c, il1, [ IfI (inner_c, inner_il1, inner_il2) ]) ->
      let if_index = render_order index depth in
      let else_if_index = render_order index depth in
      let else_index = render_order index depth in
      sprintf "%s If %s, then:%s\n\n%s Else if %s, then:%s\n%s Else:%s"
        if_index
        (render_cond false c)
        (render_al_instrs (depth + 1) il1)
        (repeat indent depth ^ else_if_index)
        (render_cond false inner_c)
        (render_al_instrs (depth + 1) inner_il1)
        (repeat indent depth ^ else_index)
        (render_al_instrs (depth + 1) inner_il2)
  | Al.Ast.IfI (c, il1, il2) ->
      let if_index = render_order index depth in
      let else_index = render_order index depth in
      sprintf "%s If %s, then:%s\n\n%s Else:%s" if_index (render_cond false c)
        (render_al_instrs (depth + 1) il1)
        (repeat indent depth ^ else_index)
        (render_al_instrs (depth + 1) il2)
  | Al.Ast.OtherwiseI il ->
      sprintf "%s Otherwise:%s" (render_order index depth)
        (render_al_instrs (depth + 1) il)
  | Al.Ast.WhileI (c, il) ->
      sprintf "%s While %s, do:%s" (render_order index depth) (render_cond false c)
        (render_al_instrs (depth + 1) il)
  | Al.Ast.EitherI (il1, il2) ->
      let either_index = render_order index depth in
      let or_index = render_order index depth in
      sprintf "%s Either:%s\n\n%s Or:%s" either_index
        (render_al_instrs (depth + 1) il1)
        (repeat indent depth ^ or_index)
        (render_al_instrs (depth + 1) il2)
  | Al.Ast.ForI (e, il) ->
      sprintf "%s For i in range |%s|:%s" (render_order index depth)
        (render_expr false e)
        (render_al_instrs (depth + 1) il)
  | Al.Ast.ForeachI (e1, e2, il) ->
      sprintf "%s Foreach %s in %s:%s" (render_order index depth)
        (render_expr false e1)
        (render_expr false e2)
        (render_al_instrs (depth + 1) il)
  | Al.Ast.AssertI s -> sprintf "%s Assert: %s." (render_order index depth) s
  | Al.Ast.PushI e ->
      sprintf "%s Push %s to the stack." (render_order index depth)
        (render_expr false e)
  | Al.Ast.PopI e ->
      sprintf "%s Pop %s from the stack." (render_order index depth)
        (render_expr false e)
  | Al.Ast.PopAllI e ->
      sprintf "%s Pop all values %s from the stack." (render_order index depth)
        (render_expr false e)
  | Al.Ast.LetI (n, e) ->
      sprintf "%s Let %s be %s." (render_order index depth) (render_expr false n)
        (render_expr false e)
  | Al.Ast.CallI (e, n, es) ->
      sprintf "%s Let %s be the result of computing %s." (render_order index depth)
        (render_expr false e)
        (render_expr false (Al.Ast.AppE(n, es)))
  | Al.Ast.MapI (e, n, es, its) ->
      sprintf "%s Let %s be the result of computing %s." (render_order index depth)
        (render_expr false e)
        (render_expr false (Al.Ast.MapE(n, es, its)))
  | Al.Ast.TrapI -> sprintf "%s Trap." (render_order index depth)
  | Al.Ast.NopI -> sprintf "%s Do nothing." (render_order index depth)
  | Al.Ast.ReturnI e_opt ->
      sprintf "%s Return%s." (render_order index depth)
        (render_opt " " (render_expr false) "" e_opt)
  | Al.Ast.EnterI (e1, e2) ->
      sprintf "%s Enter %s with label %s." (render_order index depth)
        (render_expr false e1) (render_expr false e2)
  | Al.Ast.ExecuteI e ->
      sprintf "%s Execute %s." (render_order index depth) (render_expr false e)
  | Al.Ast.ExecuteSeqI e ->
      sprintf "%s Execute the sequence (%s)." (render_order index depth) (render_expr false e)
  | Al.Ast.JumpI e ->
      sprintf "%s Jump to %s." (render_order index depth) (render_expr false e)
  | Al.Ast.PerformI (n, es) ->
      sprintf "%s Perform %s." (render_order index depth) (render_expr false (Al.Ast.AppE (n, es)))
  | Al.Ast.ExitNormalI _ | Al.Ast.ExitAbruptI _ -> render_order index depth ^ " Exit current context."
  | Al.Ast.ReplaceI (e1, p, e2) ->
      sprintf "%s Replace %s%s with %s." (render_order index depth)
        (render_expr false e1) (render_path false p) (render_expr false e2)
  | Al.Ast.AppendI (e1, e2) ->
      sprintf "%s Append %s to the %s." (render_order index depth)
        (render_expr false e2) (render_expr false e1)
  | Al.Ast.AppendListI (e1, e2) ->
      sprintf "%s Append the sequence %s to the %s." (render_order index depth)
        (render_expr false e2) (render_expr false e1)
  | Al.Ast.YetI s -> sprintf "%s YetI: %s." (render_order index depth) s

and render_al_instrs depth instrs =
  let index = ref 0 in
  List.fold_left
    (fun sinstrs i ->
      sinstrs ^ "\n\n" ^ repeat indent depth ^ render_al_instr index depth i)
    "" instrs

(* Params *)

let rec render_params in_math = function
  | [] -> ""
  | p :: ps ->
    render_expr in_math p ^ " " ^ render_params in_math ps

(* Prose *)

let render_title name params =
  render_expr false (Al.Ast.ConstructE (name, params))

let render_pred name params instrs =
  let prefix = "validation_of_" in
  let name =
    if String.starts_with ~prefix:prefix name then
      String.sub name (String.length prefix) ((String.length name) - (String.length prefix))
    else
      name
  in
  let title = render_title name params in
  title ^ "\n" ^
  String.make (String.length title) '.' ^ "\n" ^
  render_prose_instrs 0 instrs

let render_algo name params instrs =
  let prefix = "execution_of_" in
  let name =
    if String.starts_with ~prefix:prefix name then
      String.sub name (String.length prefix) ((String.length name) - (String.length prefix))
    else
      name
  in
  let title = render_title name (List.map (fun p -> let (e, _) = p in e) params) in
  title ^ "\n" ^
  String.make (String.length title) '.' ^ "\n" ^
  render_al_instrs 0 instrs

let render_def = function
  | Pred (name, params, instrs) ->
    "\n" ^ render_pred name params instrs ^ "\n\n"
  | Algo (Al.Ast.Algo (name, params, instrs)) ->
    "\n" ^ render_algo name params instrs ^ "\n\n"

let render_prose prose = List.map render_def prose |> String.concat ""

type env = prose
let env _ = Gen.gen_prose

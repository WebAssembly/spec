open Prose
open Printf

(* Helpers *)

let indent = "  "

let render_opt prefix stringifier suffix = function
  | None -> ""
  | Some x -> prefix ^ stringifier x ^ suffix

let rec repeat str num =
  if num = 0 then ""
  else if Int.rem num 2 = 0 then repeat (str ^ str) (num / 2)
  else str ^ repeat (str ^ str) (num / 2)

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

(* Expressions and Paths *)

let render_expr expr = "TODO" ^ "(" ^ Al.Print.string_of_expr expr ^ ")"

and render_path path = "TODO" ^ "(" ^ Al.Print.string_of_path path ^ ")"

(* Conditions *)

let render_cond cond = "TODO" ^ "(" ^ Al.Print.string_of_cond cond ^ ")"

(* Instructions *)

let rec render_prose_instrs index depth = function
  | [] -> ""
  | i :: is ->
    match i with
    | LetI (_e1, _e2) -> "TODO" ^ render_prose_instrs (index + 1) depth is
    | CmpI (_e1, _cmpop, _e2) -> "TODO" ^ render_prose_instrs (index + 1) depth is
    | MustValidI (_e1, _e2, _e3) -> "TODO" ^ render_prose_instrs (index + 1) depth is
    | MustMatchI (_e1, _e2) -> "TODO" ^ render_prose_instrs (index + 1) depth is
    | IsValidI _e -> "TODO" ^ render_prose_instrs (index + 1) depth is
    | ForallI (_s, _is) -> "TODO" ^ render_prose_instrs (index + 1) depth is
    | EquivI (_c1, _c2) -> "TODO" ^ render_prose_instrs (index + 1) depth is
    | YetI s -> s

let rec render_al_instr index depth = function
  | Al.Ast.IfI (c, il, []) ->
      sprintf "%s If %s, then:%s" (render_order index depth) (render_cond c)
        (render_al_instrs (depth + 1) il)
  | Al.Ast.IfI (c, il1, [ IfI (inner_c, inner_il1, []) ]) ->
      let if_index = render_order index depth in
      let else_if_index = render_order index depth in
      sprintf "%s If %s, then:%s\n%s Else if %s, then:%s"
        if_index
        (render_cond c)
        (render_al_instrs (depth + 1) il1)
        (repeat indent depth ^ else_if_index)
        (render_cond inner_c)
        (render_al_instrs (depth + 1) inner_il1)
  | Al.Ast.IfI (c, il1, [ IfI (inner_c, inner_il1, inner_il2) ]) ->
      let if_index = render_order index depth in
      let else_if_index = render_order index depth in
      let else_index = render_order index depth in
      sprintf "%s If %s, then:%s\n%s Else if %s, then:%s\n%s Else:%s"
        if_index
        (render_cond c)
        (render_al_instrs (depth + 1) il1)
        (repeat indent depth ^ else_if_index)
        (render_cond inner_c)
        (render_al_instrs (depth + 1) inner_il1)
        (repeat indent depth ^ else_index)
        (render_al_instrs (depth + 1) inner_il2)
  | Al.Ast.IfI (c, il1, il2) ->
      let if_index = render_order index depth in
      let else_index = render_order index depth in
      sprintf "%s If %s, then:%s\n%s Else:%s" if_index (render_cond c)
        (render_al_instrs (depth + 1) il1)
        (repeat indent depth ^ else_index)
        (render_al_instrs (depth + 1) il2)
  | Al.Ast.OtherwiseI il ->
      sprintf "%s Otherwise:%s" (render_order index depth)
        (render_al_instrs (depth + 1) il)
  | Al.Ast.WhileI (c, il) ->
      sprintf "%s While %s, do:%s" (render_order index depth) (render_cond c)
        (render_al_instrs (depth + 1) il)
  | Al.Ast.EitherI (il1, il2) ->
      let either_index = render_order index depth in
      let or_index = render_order index depth in
      sprintf "%s Either:%s\n%s Or:%s" either_index
        (render_al_instrs (depth + 1) il1)
        (repeat indent depth ^ or_index)
        (render_al_instrs (depth + 1) il2)
  | Al.Ast.ForI (e, il) ->
      sprintf "%s For i in range |%s|:%s" (render_order index depth)
        (render_expr e)
        (render_al_instrs (depth + 1) il)
  | Al.Ast.ForeachI (e1, e2, il) ->
      sprintf "%s Foreach %s in %s:%s" (render_order index depth)
        (render_expr e1)
        (render_expr e2)
        (render_al_instrs (depth + 1) il)
  | Al.Ast.AssertI s -> sprintf "%s Assert: %s." (render_order index depth) s
  | Al.Ast.PushI e ->
      sprintf "%s Push %s to the stack." (render_order index depth)
        (render_expr e)
  | Al.Ast.PopI e ->
      sprintf "%s Pop %s from the stack." (render_order index depth)
        (render_expr e)
  | Al.Ast.PopAllI e ->
      sprintf "%s Pop all values %s from the stack." (render_order index depth)
        (render_expr e)
  | Al.Ast.LetI (n, e) ->
      sprintf "%s Let %s be %s." (render_order index depth) (render_expr n)
        (render_expr e)
  | Al.Ast.TrapI -> sprintf "%s Trap." (render_order index depth)
  | Al.Ast.NopI -> sprintf "%s Do nothing." (render_order index depth)
  | Al.Ast.ReturnI e_opt ->
      sprintf "%s Return%s." (render_order index depth)
        (render_opt " " render_expr "" e_opt)
  | Al.Ast.EnterI (e1, e2) ->
      sprintf "%s Enter %s with label %s." (render_order index depth)
        (render_expr e1) (render_expr e2)
  | Al.Ast.ExecuteI e ->
      sprintf "%s Execute %s." (render_order index depth) (render_expr e)
  | Al.Ast.ExecuteSeqI e ->
      sprintf "%s Execute the sequence (%s)." (render_order index depth) (render_expr e)
  | Al.Ast.JumpI e ->
      sprintf "%s Jump to %s." (render_order index depth) (render_expr e)
  | Al.Ast.PerformI e ->
      sprintf "%s Perform %s." (render_order index depth) (render_expr e)
  | Al.Ast.ExitNormalI _ | Al.Ast.ExitAbruptI _ -> render_order index depth ^ " Exit current context."
  | Al.Ast.ReplaceI (e1, p, e2) ->
      sprintf "%s Replace %s%s with %s." (render_order index depth)
        (render_expr e1) (render_path p) (render_expr e2)
  | Al.Ast.AppendI (e1, e2) ->
      sprintf "%s Append %s to the %s." (render_order index depth)
        (render_expr e2) (render_expr e1)
  | Al.Ast.AppendListI (e1, e2) ->
      sprintf "%s Append the sequence %s to the %s." (render_order index depth)
        (render_expr e2) (render_expr e1)
  | Al.Ast.YetI s -> sprintf "%s YetI: %s." (render_order index depth) s

and render_al_instrs depth instrs =
  let index = ref 0 in
  List.fold_left
    (fun acc i ->
      acc ^ "\n" ^ repeat indent depth ^ render_al_instr index depth i)
    "" instrs

(* Params *)

let rec render_params = function
  | [] -> ""
  | p :: ps -> 
    render_expr p ^ " " ^ render_params ps

(* Prose *)

let render_title name params =
  ":math:`\\" ^ (String.uppercase_ascii name) ^ "~" ^
  (List.fold_left (fun pstring p -> pstring ^ "\\" ^ render_expr p ^ "~") String.empty params) ^
  "\\END`"

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
  render_prose_instrs 0 0 instrs

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

let rec render_defs = function
  | [] -> ""
  | d :: ds ->
    match d with  
    | Pred (name, params, instrs) ->
        "$$\n" ^ render_pred name params instrs ^ "\n$$\n\n" ^
        render_defs ds
    | Algo (Al.Ast.Algo (name, params, instrs)) ->
        "$$\n" ^ render_algo name params instrs ^ "\n$$\n\n" ^
        render_defs ds

let render_prose prose = render_defs prose

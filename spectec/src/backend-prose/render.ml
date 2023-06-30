open Prose

(* Environment *)

module Set = Set.Make(String)
module Map = Map.Make(String)

(* Operators *)

(* Conditions *)

(* Expressions *)

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

let rec render_al_instrs index depth = function
  | [] -> ""
  | i :: is -> 
      (Al.Print.string_of_instr (ref index) depth i) ^ "\n" ^
      render_al_instrs (index + 1) depth is 

(* Params *)

let rec render_params = function
  | [] -> ""
  | p :: ps -> 
    Al.Print.string_of_expr p ^ " " ^ render_params ps

(* Prose *)

let render_title name params =
  ":math:`\\" ^ (String.uppercase_ascii name) ^ "~" ^
  (List.fold_left (fun pstring p -> pstring ^ "\\" ^ Al.Print.string_of_expr p ^ "~") String.empty params) ^
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
  render_al_instrs 0 0 instrs

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

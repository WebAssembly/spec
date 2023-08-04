open Al.Print
open Prose
open Printf

(* Helpers *)
let string_of_list stringifier left sep right = function
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

let indent_depth = ref 0
let indent () = ((List.init !indent_depth (fun _ -> "  ")) |> String.concat "") ^ "-"

let string_of_cmpop = function
  | Eq -> "equal to"
  | Ne -> "different with"
  | Lt -> "less than"
  | Gt -> "greater than"
  | Le -> "less than or equal to"
  | Ge -> "greater than or equal to"

let rec string_of_instr = function
  | LetI (e1, e2) ->
      sprintf "%s Let %s be %s." (indent ())
        (string_of_expr e1)
        (string_of_expr e2)
  | CmpI (e1, cmpop, e2) ->
      sprintf "%s %s must be %s %s." (indent ())
        (string_of_expr e1)
        (string_of_cmpop cmpop)
        (string_of_expr e2)
  | MustValidI (e1, e2, eo) ->
      sprintf "%s Under the context %s, %s must be valid%s." (indent ())
        (string_of_expr e1)
        (string_of_expr e2)
        (string_of_opt " with type " string_of_expr "" eo)
  | MustMatchI (e1, e2) ->
      sprintf "%s %s must match %s." (indent ())
        (string_of_expr e2)
        (string_of_expr e1)
  | IsValidI e_opt ->
      sprintf "%s The instruction is valid%s." (indent ())
        (string_of_opt " with type " string_of_expr "" e_opt)
  | IfI (c, is) ->
      sprintf "%s If %s, \n%s" (indent ())
        (string_of_cond c)
        (string_of_list indented_string_of_instr "" "\n" "" is)
  | ForallI (e1, e2, is) ->
      sprintf "%s For all %s in %s,\n%s" (indent ())
        (string_of_expr e1)
        (string_of_expr e2)
        (string_of_list indented_string_of_instr "" "\n" "" is)
  | EquivI (e1, e2) ->
      sprintf "%s (%s) and (%s) are equivalent." (indent ())
        (string_of_cond e2)
        (string_of_cond e1)
  | YetI s -> indent () ^ " Yet: " ^ s

and indented_string_of_instr i =
  indent_depth := !indent_depth + 1;
  let result = string_of_instr i in
  indent_depth := !indent_depth - 1;
  result

let string_of_def = function
| Pred (name, params, instrs) ->
    "validation_of_" ^ string_of_keyword name
    ^ string_of_list string_of_expr " " " " "\n" params
    ^ string_of_list string_of_instr "" "\n" "\n" instrs
| Algo algo -> string_of_algorithm algo

let string_of_prose prose = List.map string_of_def prose |> String.concat "\n"

(* Structured string *)

let string_of_structured_instr = function
  | LetI _ -> "LetI(...)"
  | CmpI _ -> "CmpI(...)"
  | MustValidI (e1, e2, eo) ->
      "MustValidI ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ", "
      ^ "(" ^ string_of_opt "" structured_string_of_expr "" eo ^ ")"
      ^ ")"
  | MustMatchI (e1, e2) ->
      "MustMatchI ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | IsValidI e_opt ->
      "IsValidI" ^ string_of_opt " (" structured_string_of_expr ")" e_opt
  | IfI _ -> "IfI(...)"
  | ForallI _ -> "ForallI(...)"
  | EquivI _ -> "EquivI ..."
  | YetI s -> "YetI (" ^ s ^ ")"


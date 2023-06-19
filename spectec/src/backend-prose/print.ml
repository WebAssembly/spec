open Prose
open Backend_interpreter
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
        (Print.string_of_expr e1)
        (Print.string_of_expr e2)
  | CmpI (e1, cmpop, e2) ->
      sprintf "%s %s must be %s %s." (indent ())
        (Print.string_of_expr e1)
        (string_of_cmpop cmpop)
        (Print.string_of_expr e2)
  | MustValidI (e1, e2, eo) ->
      sprintf "%s Under the context %s, %s must be valid%s." (indent ())
        (Print.string_of_expr e1)
        (Print.string_of_expr e2)
        (Print.string_of_opt " with type " Print.string_of_expr "" eo)
  | MustMatchI (e1, e2) ->
      sprintf "%s %s must match %s." (indent ())
        (Print.string_of_expr e2)
        (Print.string_of_expr e1)
  | IsValidI e_opt ->
      sprintf "%s The instruction is valid%s." (indent ())
        (Print.string_of_opt " with type " Print.string_of_expr "" e_opt)
  | ForallI (s, is) ->
      sprintf "%s %s\n%s" (indent ())
        s
        (string_of_list indented_string_of_instr "" "\n" "" is)
  | EquivI (e1, e2) ->
      sprintf "%s (%s) and (%s) are equivalent." (indent ())
        (Print.string_of_cond e2)
        (Print.string_of_cond e1)
  | YetI s -> indent () ^ " Yet: " ^ s

and indented_string_of_instr i =
  indent_depth := !indent_depth + 1;
  let result = string_of_instr i in
  indent_depth := !indent_depth - 1;
  result

let string_of_def = function
| Pred (name, params, instrs) ->
    name
    ^ string_of_list Print.string_of_expr " " " " "\n" params
    ^ string_of_list string_of_instr "" "\n" "\n" instrs
| Algo algo -> Print.string_of_algorithm algo

let string_of_prose prose = List.map string_of_def prose |> String.concat "\n"

(* Structured string *)

let string_of_structured_instr = function
  | LetI _ -> "LetI(...)"
  | CmpI _ -> "CmpI(...)"
  | MustValidI (e1, e2, eo) ->
      "MustValidI ("
      ^ Print.structured_string_of_expr e1
      ^ ", "
      ^ Print.structured_string_of_expr e2
      ^ ", "
      ^ "(" ^ Print.string_of_opt "" Print.structured_string_of_expr "" eo ^ ")"
      ^ ")"
  | MustMatchI (e1, e2) ->
      "MustMatchI ("
      ^ Print.structured_string_of_expr e1
      ^ ", "
      ^ Print.structured_string_of_expr e2
      ^ ")"
  | IsValidI e_opt ->
      "IsValidI" ^ Print.string_of_opt " (" Print.structured_string_of_expr ")" e_opt
  | ForallI _ -> "ForallI(...)"
  | EquivI _ -> "EquivI ..."
  | YetI s -> "YetI (" ^ s ^ ")"


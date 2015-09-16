(*
 * (c) 2015 Andreas Rossberg
 *)

(* Types *)

type value_type = Int32Type | Int64Type | Float32Type | Float64Type
type expr_type = value_type option
type func_type = {ins : value_type list; out : expr_type}

(* String conversion *)

let string_of_value_type = function
  | Int32Type -> "i32"
  | Int64Type -> "i64"
  | Float32Type -> "f32"
  | Float64Type -> "f64"

let string_of_value_type_list = function
  | [t] -> string_of_value_type t
  | ts -> "(" ^ String.concat " " (List.map string_of_value_type ts) ^ ")"

let string_of_expr_type = function
  | None -> "()"
  | Some t -> string_of_value_type t

let string_of_func_type {ins; out} =
  string_of_value_type_list ins ^ " -> " ^ string_of_expr_type out

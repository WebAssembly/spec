(* Types *)

type value_type = Int32Type | Int64Type | Float32Type | Float64Type
type stack_type = value_type list
type func_type = FuncType of stack_type * stack_type


(* String conversion *)

let string_of_value_type = function
  | Int32Type -> "i32"
  | Int64Type -> "i64"
  | Float32Type -> "f32"
  | Float64Type -> "f64"

let string_of_stack_type = function
  | [t] -> string_of_value_type t
  | ts -> "(" ^ String.concat " " (List.map string_of_value_type ts) ^ ")"

let string_of_func_type (FuncType (ins, out)) =
  string_of_stack_type ins ^ " -> " ^ string_of_stack_type out

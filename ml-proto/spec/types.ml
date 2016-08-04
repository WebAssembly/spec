(* Types *)

type value_type = I32Type | I64Type | F32Type | F64Type
type stack_type = value_type list
type result_type = Stack of stack_type | Bot
type func_type = FuncType of stack_type * stack_type


(* Attributes *)

let size = function
  | I32Type | F32Type -> 4
  | I64Type | F64Type -> 8


(* String conversion *)

let string_of_value_type = function
  | I32Type -> "i32"
  | I64Type -> "i64"
  | F32Type -> "f32"
  | F64Type -> "f64"

let string_of_value_types = function
  | [t] -> string_of_value_type t
  | ts -> "(" ^ String.concat " " (List.map string_of_value_type ts) ^ ")"

let string_of_stack_type ts =
  "(" ^ String.concat " " (List.map string_of_value_type ts) ^ ")"

let string_of_result_type = function
  | Stack ts -> string_of_stack_type ts
  | Bot -> "_|_"

let string_of_func_type (FuncType (ins, out)) =
  string_of_stack_type ins ^ " -> " ^ string_of_stack_type out

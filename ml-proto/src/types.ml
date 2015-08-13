(*
 * (c) 2015 Andreas Rossberg
 *)

(* Number formats *)

type uint32 = int32   (* approximate *)
type uint64 = int64   (* approximate *)
type float32 = float  (* approximate *)
type float64 = float


(* Types *)

type value_type = Int32Type | Int64Type | Float32Type | Float64Type
type expr_type = value_type list
type func_type = {ins : expr_type; outs : expr_type}


(* String conversion *)

let string_of_value_type = function
  | Int32Type -> "Int32"
  | Int64Type -> "Int64"
  | Float32Type -> "Float32"
  | Float64Type -> "Float64"

let string_of_expr_type = function
  | [t] -> string_of_value_type t
  | ts -> "(" ^ String.concat " " (List.map string_of_value_type ts) ^ ")"

let string_of_func_type {ins; outs} =
  string_of_expr_type ins ^ " -> " ^ string_of_expr_type outs

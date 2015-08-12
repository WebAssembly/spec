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


(* Values and operators *)

type ('i32, 'i64, 'f32, 'f64) op =
  Int32 of 'i32 | Int64 of 'i64 | Float32 of 'f32 | Float64 of 'f64

type value = (int32, int64, float32, float64) op

let type_of = function
  | Int32 _ -> Int32Type
  | Int64 _ -> Int64Type
  | Float32 _ -> Float32Type
  | Float64 _ -> Float64Type

let default_value = function
  | Int32Type -> Int32 Int32.zero
  | Int64Type -> Int64 Int64.zero
  | Float32Type -> Float32 0.0
  | Float64Type -> Float64 0.0

let string_of_value = function
  | Int32 i -> Int32.to_string i
  | Int64 i -> Int64.to_string i
  | Float32 z | Float64 z -> string_of_float z

let string_of_values = function
  | [v] -> string_of_value v
  | vs -> "(" ^ String.concat " " (List.map string_of_value vs) ^ ")"

(*
 * (c) 2015 Andreas Rossberg
 *)

open Types


(* Values and operators *)

type ('i32, 'i64, 'f32, 'f64) op =
  Int32 of 'i32 | Int64 of 'i64 | Float32 of 'f32 | Float64 of 'f64

type value = (I32.t, I64.t, F32.t, F64.t) op

(* Typing *)

let type_of = function
  | Int32 _ -> Int32Type
  | Int64 _ -> Int64Type
  | Float32 _ -> Float32Type
  | Float64 _ -> Float64Type

let default_value = function
  | Int32Type -> Int32 I32.zero
  | Int64Type -> Int64 I64.zero
  | Float32Type -> Float32 F32.zero
  | Float64Type -> Float64 F64.zero


(* String conversion *)

let string_of_value = function
  | Int32 i -> I32.to_string i
  | Int64 i -> I64.to_string i
  | Float32 z -> F32.to_string z
  | Float64 z -> F64.to_string z

let string_of_values = function
  | [v] -> string_of_value v
  | vs -> "(" ^ String.concat " " (List.map string_of_value vs) ^ ")"

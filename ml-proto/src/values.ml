(*
 * (c) 2015 Andreas Rossberg
 *)

open Types


(* Values and operators *)

type ('i32, 'i64, 'f32, 'f64) op =
  Int32 of 'i32 | Int64 of 'i64 | Float32 of 'f32 | Float64 of 'f64

type value = (int32, int64, float32, float64) op


(* Typing *)

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


(* String conversion *)

let string_of_value = function
  | Int32 i -> Int32.to_string i
  | Int64 i -> Int64.to_string i
  | Float32 z | Float64 z -> string_of_float z

let string_of_values = function
  | [v] -> string_of_value v
  | vs -> "(" ^ String.concat " " (List.map string_of_value vs) ^ ")"


(* Float32 truncation *)

let float32 x = Int32.float_of_bits (Int32.bits_of_float x)

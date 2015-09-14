(*
 * (c) 2015 Andreas Rossberg
 *)

open Types


(* Values and operators *)

type ('i32, 'i64, 'f32, 'f64) op =
  Int32 of 'i32 | Int64 of 'i64 | Float32 of 'f32 | Float64 of 'f64

type value = (int32, int64, Float32.t, Float64.t) op


(* Typing *)

let type_of = function
  | Int32 _ -> Int32Type
  | Int64 _ -> Int64Type
  | Float32 _ -> Float32Type
  | Float64 _ -> Float64Type

let default_value = function
  | Int32Type -> Int32 Int32.zero
  | Int64Type -> Int64 Int64.zero
  | Float32Type -> Float32 Float32.zero
  | Float64Type -> Float64 Float64.zero


(* String conversion *)

let string_of_value = function
  | Int32 i -> Int32.to_string i
  | Int64 i -> Int64.to_string i
  | Float32 z -> Float32.to_string z
  | Float64 z -> Float64.to_string z

let string_of_values = function
  | [v] -> string_of_value v
  | vs -> "(" ^ String.concat " " (List.map string_of_value vs) ^ ")"

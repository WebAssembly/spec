open Types


(* Values and operators *)

type ('i32, 'i64, 'f32, 'f64) op =
  I32 of 'i32 | I64 of 'i64 | F32 of 'f32 | F64 of 'f64

type value = (I32.t, I64.t, F32.t, F64.t) op


(* Typing *)

let type_of = function
  | I32 _ -> I32Type
  | I64 _ -> I64Type
  | F32 _ -> F32Type
  | F64 _ -> F64Type

let default_value = function
  | I32Type -> I32 I32.zero
  | I64Type -> I64 I64.zero
  | F32Type -> F32 F32.zero
  | F64Type -> F64 F64.zero


(* Conversion *)

let value_of_bool b = I32 (if b then 1l else 0l)

let string_of_value = function
  | I32 i -> I32.to_string_s i
  | I64 i -> I64.to_string_s i
  | F32 z -> F32.to_string z
  | F64 z -> F64.to_string z

let string_of_values = function
  | [v] -> string_of_value v
  | vs -> "[" ^ String.concat " " (List.map string_of_value vs) ^ "]"


(* Injection & projection *)

exception Value of value_type

module type ValueType =
sig
  type t
  val to_value : t -> value
  val of_value : value -> t (* raise Value *)
end

module I32Value =
struct
  type t = I32.t
  let to_value i = I32 i
  let of_value = function I32 i -> i | _ -> raise (Value I32Type)
end

module I64Value =
struct
  type t = I64.t
  let to_value i = I64 i
  let of_value = function I64 i -> i | _ -> raise (Value I64Type)
end

module F32Value =
struct
  type t = F32.t
  let to_value i = F32 i
  let of_value = function F32 z -> z | _ -> raise (Value F32Type)
end

module F64Value =
struct
  type t = F64.t
  let to_value i = F64 i
  let of_value = function F64 z -> z | _ -> raise (Value F64Type)
end

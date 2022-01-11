open Types


(* Values and operators *)

type ('i32, 'i64, 'f32, 'f64) op =
  I32 of 'i32 | I64 of 'i64 | F32 of 'f32 | F64 of 'f64

type ('v128) vecop =
  V128 of 'v128

type num = (I32.t, I64.t, F32.t, F64.t) op
type vec = (V128.t) vecop

type ref_ = ..
type ref_ += NullRef of ref_type

type value = Num of num | Vec of vec | Ref of ref_


(* Injection & projection *)

let as_num = function
  | Num n -> n
  | _ -> failwith "as_num"

let as_vec = function
  | Vec i -> i
  | _ -> failwith "as_vec"

let as_ref = function
  | Ref r -> r
  | _ -> failwith "as_ref"


exception TypeError of int * num * num_type

module type NumType =
sig
  type t
  val to_num : t -> num
  val of_num : int -> num -> t
end

module I32Num =
struct
  type t = I32.t
  let to_num i = I32 i
  let of_num n = function I32 i -> i | v -> raise (TypeError (n, v, I32Type))
end

module I64Num =
struct
  type t = I64.t
  let to_num i = I64 i
  let of_num n = function I64 i -> i | v -> raise (TypeError (n, v, I64Type))
end

module F32Num =
struct
  type t = F32.t
  let to_num i = F32 i
  let of_num n = function F32 z -> z | v -> raise (TypeError (n, v, F32Type))
end

module F64Num =
struct
  type t = F64.t
  let to_num i = F64 i
  let of_num n = function F64 z -> z | v -> raise (TypeError (n, v, F64Type))
end

module type VecType =
sig
  type t
  val to_vec : t -> vec
  val of_vec : int -> vec -> t
end

module V128Vec =
struct
  type t = V128.t
  let to_vec i = V128 i
  let of_vec _n = function V128 z -> z
end


(* Typing *)

let type_of_num = function
  | I32 _ -> I32Type
  | I64 _ -> I64Type
  | F32 _ -> F32Type
  | F64 _ -> F64Type

let type_of_vec = function
  | V128 _ -> V128Type

let type_of_ref' = ref (function NullRef t -> t | _ -> assert false)
let type_of_ref r = !type_of_ref' r

let type_of_value = function
  | Num n -> NumType (type_of_num n)
  | Vec i -> VecType (type_of_vec i)
  | Ref r -> RefType (type_of_ref r)


(* Comparison *)

let eq_num n1 n2 = n1 = n2

let eq_vec v1 v2 = v1 = v2

let eq_ref' = ref (fun r1 r2 ->
  match r1, r2 with
  | NullRef _, NullRef _ -> true
  | _, _ -> false
)

let eq_ref r1 r2 = !eq_ref' r1 r2

let eq v1 v2 =
  match v1, v2 with
  | Num n1, Num n2 -> eq_num n1 n2
  | Vec v1, Vec v2 -> eq_vec v1 v2
  | Ref r1, Ref r2 -> eq_ref r1 r2
  | _, _ -> false


(* Defaults *)

let default_num = function
  | I32Type -> I32 I32.zero
  | I64Type -> I64 I64.zero
  | F32Type -> F32 F32.zero
  | F64Type -> F64 F64.zero

let default_vec = function
  | V128Type -> V128 V128.zero

let default_ref = function
  | t -> NullRef t

let default_value = function
  | NumType t' -> Num (default_num t')
  | VecType t' -> Vec (default_vec t')
  | RefType t' -> Ref (default_ref t')


(* Conversion *)

let value_of_bool b = Num (I32 (if b then 1l else 0l))

let string_of_num = function
  | I32 i -> I32.to_string_s i
  | I64 i -> I64.to_string_s i
  | F32 z -> F32.to_string z
  | F64 z -> F64.to_string z

let hex_string_of_num = function
  | I32 i -> I32.to_hex_string i
  | I64 i -> I64.to_hex_string i
  | F32 z -> F32.to_hex_string z
  | F64 z -> F64.to_hex_string z

let string_of_vec = function
  | V128 v -> V128.to_string v

let hex_string_of_vec = function
  | V128 v -> V128.to_hex_string v

let string_of_ref' = ref (function NullRef _t -> "null" | _ -> "ref")
let string_of_ref r = !string_of_ref' r

let string_of_value = function
  | Num n -> string_of_num n
  | Vec i -> string_of_vec i
  | Ref r -> string_of_ref r

let string_of_values = function
  | [v] -> string_of_value v
  | vs -> "[" ^ String.concat " " (List.map string_of_value vs) ^ "]"

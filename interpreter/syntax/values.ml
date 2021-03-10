open Types


(* Values and operators *)

type ('i32, 'i64, 'f32, 'f64) op =
  I32 of 'i32 | I64 of 'i64 | F32 of 'f32 | F64 of 'f64

type num = (I32.t, I64.t, F32.t, F64.t) op

type ref_ = ..
type ref_ += NullRef of ref_type

type value = Num of num | Ref of ref_


(* Typing *)

let type_of_num = function
  | I32 _ -> I32Type
  | I64 _ -> I64Type
  | F32 _ -> F32Type
  | F64 _ -> F64Type

let type_of_ref' = ref (function NullRef t -> t | _ -> assert false)
let type_of_ref r = !type_of_ref' r

let type_of_value = function
  | Num n -> NumType (type_of_num n)
  | Ref r -> RefType (type_of_ref r)


(* Projections *)

let as_num = function
  | Num n -> n
  | Ref _ -> failwith "as_num"

let as_ref = function
  | Num _ -> failwith "as_ref"
  | Ref r -> r


(* Defaults *)

let default_num = function
  | I32Type -> I32 I32.zero
  | I64Type -> I64 I64.zero
  | F32Type -> F32 F32.zero
  | F64Type -> F64 F64.zero

let default_ref = function
  | t -> NullRef t

let default_value = function
  | NumType t' -> Num (default_num t')
  | RefType t' -> Ref (default_ref t')


(* Conversion *)

let value_of_bool b = Num (I32 (if b then 1l else 0l))

let string_of_num = function
  | I32 i -> I32.to_string_s i
  | I64 i -> I64.to_string_s i
  | F32 z -> F32.to_string z
  | F64 z -> F64.to_string z

let string_of_ref' = ref (function NullRef t -> "null" | _ -> "ref")
let string_of_ref r = !string_of_ref' r

let string_of_value = function
  | Num n -> string_of_num n
  | Ref r -> string_of_ref r

let string_of_values = function
  | [v] -> string_of_value v
  | vs -> "[" ^ String.concat " " (List.map string_of_value vs) ^ "]"

open Types


(* Values and operators *)

type ('i32, 'i64, 'f32, 'f64) op =
  I32 of 'i32 | I64 of 'i64 | F32 of 'f32 | F64 of 'f64

type ('v128) vecop =
  V128 of 'v128

type num = (I32.t, I64.t, F32.t, F64.t) op
type vec = (V128.t) vecop

type ref_ = ..

type value = Num of num | Vec of vec | Ref of ref_
type t = value

type ref_ += NullRef of heap_type
type ref_ += ExnRef of Tag.t * value list


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
  let of_num n = function I32 i -> i | v -> raise (TypeError (n, v, I32T))
end

module I64Num =
struct
  type t = I64.t
  let to_num i = I64 i
  let of_num n = function I64 i -> i | v -> raise (TypeError (n, v, I64T))
end

module F32Num =
struct
  type t = F32.t
  let to_num i = F32 i
  let of_num n = function F32 z -> z | v -> raise (TypeError (n, v, F32T))
end

module F64Num =
struct
  type t = F64.t
  let to_num i = F64 i
  let of_num n = function F64 z -> z | v -> raise (TypeError (n, v, F64T))
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
  let of_vec n = function V128 z -> z
end

let is_null_ref = function
  | NullRef _ -> true
  | _ -> false


(* Typing *)

let type_of_op = function
  | I32 _ -> I32T
  | I64 _ -> I64T
  | F32 _ -> F32T
  | F64 _ -> F64T

let type_of_vecop = function
  | V128 _ -> V128T

let type_of_num = type_of_op
let type_of_vec = type_of_vecop

let type_of_ref' = ref (function _ -> assert false)
let type_of_ref = function
  | NullRef t -> (Null, Match.bot_of_heap_type [] t)
  | ExnRef _ -> (NoNull, ExnHT)
  | r -> (NoNull, !type_of_ref' r)

let type_of_value = function
  | Num n -> NumT (type_of_num n)
  | Vec i -> VecT (type_of_vec i)
  | Ref r -> RefT (type_of_ref r)


(* Comparison *)

let eq_num n1 n2 = n1 = n2

let eq_vec v1 v2 = v1 = v2

let eq_ref' = ref (fun r1 r2 ->
  match r1, r2 with
  | NullRef _, NullRef _ -> true
  | _, _ -> r1 == r2
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
  | I32T -> Some (Num (I32 I32.zero))
  | I64T -> Some (Num (I64 I64.zero))
  | F32T -> Some (Num (F32 F32.zero))
  | F64T -> Some (Num (F64 F64.zero))

let default_vec = function
  | V128T -> Some (Vec (V128 V128.zero))

let default_ref = function
  | (Null, t) -> Some (Ref (NullRef t))
  | (NoNull, _) -> None

let default_value = function
  | NumT t -> default_num t
  | VecT t -> default_vec t
  | RefT t -> default_ref t
  | BotT -> assert false


(* Representation *)

exception Type

let rec i64_of_bits bs =
  if bs = "" then 0L else
  let bs' = String.sub bs 1 (String.length bs - 1) in
  Int64.(logor (of_int (Char.code bs.[0])) (shift_left (i64_of_bits bs') 8))

let num_of_bits t bs =
  let n = i64_of_bits bs in
  match t with
  | I32T -> I32 (Int64.to_int32 n)
  | I64T -> I64 n
  | F32T -> F32 (F32.of_bits (Int64.to_int32 n))
  | F64T -> F64 (F64.of_bits n)

let vec_of_bits t bs =
  match t with
  | V128T -> V128 (V128.of_bits bs)

let val_of_bits t bs =
  match t with
  | NumT nt -> Num (num_of_bits nt bs)
  | VecT vt -> Vec (vec_of_bits vt bs)
  | RefT _ -> raise Type
  | BotT -> assert false

let extend n ext x =
  match ext with
  | Pack.ZX -> x
  | Pack.SX -> let sh = 64 - 8 * n in Int64.(shift_right (shift_left x sh) sh)

let num_of_packed_bits t sz ext bs =
  assert (Pack.packed_size sz <= num_size t);
  let n = Pack.packed_size sz in
  let x = extend n ext (i64_of_bits bs) in
  match t with
  | I32T -> I32 (Int64.to_int32 x)
  | I64T -> I64 x
  | _ -> raise Type

let val_of_storage_bits st bs =
  match st with
  | ValStorageT t -> val_of_bits t bs
  | PackStorageT sz -> Num (num_of_packed_bits I32T sz Pack.ZX bs)


let vec_of_packed_bits t sz ext bs =
  let open Pack in
  assert (packed_size sz < vec_size t);
  let x = i64_of_bits bs in
  let b = Bytes.make 16 '\x00' in
  Bytes.set_int64_le b 0 x;
  let v = V128.of_bits (Bytes.to_string b) in
  let r =
    match sz, ext with
    | Pack64, ExtLane (Pack8x8, SX) -> V128.I16x8_convert.extend_low_s v
    | Pack64, ExtLane (Pack8x8, ZX) -> V128.I16x8_convert.extend_low_u v
    | Pack64, ExtLane (Pack16x4, SX) -> V128.I32x4_convert.extend_low_s v
    | Pack64, ExtLane (Pack16x4, ZX) -> V128.I32x4_convert.extend_low_u v
    | Pack64, ExtLane (Pack32x2, SX) -> V128.I64x2_convert.extend_low_s v
    | Pack64, ExtLane (Pack32x2, ZX) -> V128.I64x2_convert.extend_low_u v
    | _, ExtLane _ -> assert false
    | Pack8, ExtSplat -> V128.I8x16.splat (I8.of_int_s (Int64.to_int x))
    | Pack16, ExtSplat -> V128.I16x8.splat (I16.of_int_s (Int64.to_int x))
    | Pack32, ExtSplat -> V128.I32x4.splat (I32.of_int_s (Int64.to_int x))
    | Pack64, ExtSplat -> V128.I64x2.splat x
    | Pack32, ExtZero -> v
    | Pack64, ExtZero -> v
    | _, ExtZero -> assert false
  in V128 r


let rec bits_of_i64 w n =
  if w = 0 then "" else
  let b = Char.chr (Int64.to_int n land 0xff) in
  String.make 1 b ^ bits_of_i64 (w - 1) (Int64.shift_right n 8)

let bits_of_num n =
  let w = num_size (type_of_num n) in
  match n with
  | I32 x -> bits_of_i64 w (Int64.of_int32 x)
  | I64 x -> bits_of_i64 w x
  | F32 x -> bits_of_i64 w (Int64.of_int32 (F32.to_bits x))
  | F64 x -> bits_of_i64 w (F64.to_bits x)

let bits_of_vec v =
  match v with
  | V128 x -> V128.to_bits x

let bits_of_val v =
  match v with
  | Num n -> bits_of_num n
  | Vec v -> bits_of_vec v
  | Ref _ -> raise Type

let wrap n x =
  let sh = 64 - 8 * n in Int64.(shift_right_logical (shift_left x sh) sh)

let packed_bits_of_num sz n =
  assert (Pack.packed_size sz <= num_size (type_of_num n));
  let w = Pack.packed_size sz in
  match n with
  | I32 x -> bits_of_i64 w (wrap w (Int64.of_int32 x))
  | I64 x -> bits_of_i64 w (wrap w x)
  | _ -> raise Type

let storage_bits_of_val st v =
  match st with
  | ValStorageT t -> assert (t = type_of_value v); bits_of_val v
  | PackStorageT sz ->
    match v with
    | Num n -> packed_bits_of_num sz n
    | _ -> raise Type


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

let string_of_ref' = ref (function _ -> "ref")
let string_of_ref = function
  | NullRef _ -> "null"
  | ExnRef _ -> "exn"
  | r -> !string_of_ref' r

let string_of_value = function
  | Num n -> string_of_num n
  | Vec i -> string_of_vec i
  | Ref r -> string_of_ref r

let string_of_values = function
  | [v] -> string_of_value v
  | vs -> "[" ^ String.concat " " (List.map string_of_value vs) ^ "]"

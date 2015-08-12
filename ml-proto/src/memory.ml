(*
 * (c) 2015 Andreas Rossberg
 *)

open Bigarray

type address = int
type alignment = Aligned | Unaligned
type mem_type =
  | SInt8Mem | SInt16Mem | SInt32Mem | SInt64Mem
  | UInt8Mem | UInt16Mem | UInt32Mem | UInt64Mem
  | Float32Mem | Float64Mem

type memory = (int, int8_unsigned_elt, c_layout) Array1.t
type sint8_memory = (int, int8_signed_elt, c_layout) Array1.t
type sint16_memory = (int, int16_signed_elt, c_layout) Array1.t
type sint32_memory = (int32, int32_elt, c_layout) Array1.t
type sint64_memory = (int64, int64_elt, c_layout) Array1.t
type uint8_memory = (int, int8_unsigned_elt, c_layout) Array1.t
type uint16_memory = (int, int16_unsigned_elt, c_layout) Array1.t
type uint32_memory = (int32, int32_elt, c_layout) Array1.t
type uint64_memory = (int64, int64_elt, c_layout) Array1.t
type float32_memory = (float, float32_elt, c_layout) Array1.t
type float64_memory = (float, float64_elt, c_layout) Array1.t
type t = memory

let cast_memory : memory -> ('c, 'd, c_layout) Array1.t = Obj.magic

let create n =
  let m = Array1.create Int8_unsigned C_layout n in
  Array1.fill m 0;
  m

exception Bounds
exception Align
exception Address

let mem_size = function
  | SInt8Mem | UInt8Mem -> 1
  | SInt16Mem | UInt16Mem -> 2
  | SInt32Mem | UInt32Mem | Float32Mem -> 4
  | SInt64Mem | UInt64Mem | Float64Mem -> 8

let mem_alignment = mem_size

let align ty a =
  let n = mem_alignment ty in
  if a mod n <> 0 then raise Align else a / n


open Types

let address_of_value = function
  | Int32 i -> Int32.to_int i
  | Int64 i -> Int64.to_int i
  | _ -> raise Address


let load_aligned mem a ty =
  try match ty with
  | SInt8Mem ->
    Int32 (Int32.of_int (cast_memory mem : sint8_memory).{align ty a})
  | SInt16Mem ->
    Int32 (Int32.of_int (cast_memory mem : sint16_memory).{align ty a})
  | SInt32Mem ->
    Int32 (cast_memory mem : sint32_memory).{align ty a}
  | SInt64Mem ->
    Int64 (cast_memory mem : sint64_memory).{align ty a}
  | UInt8Mem ->
    Int32 (Int32.of_int (cast_memory mem : uint8_memory).{align ty a})
  | UInt16Mem ->
    Int32 (Int32.of_int (cast_memory mem : uint16_memory).{align ty a})
  | UInt32Mem -> Int32 (cast_memory mem : uint32_memory).{align ty a}
  | UInt64Mem -> Int64 (cast_memory mem : uint64_memory).{align ty a}
  | Float32Mem -> Float32 (cast_memory mem : float32_memory).{align ty a}
  | Float64Mem -> Float64 (cast_memory mem : float64_memory).{align ty a}
  with Invalid_argument _ -> raise Bounds

let store_aligned mem a ty v =
  try match ty, v with
  | SInt8Mem, Int32 x ->
    (cast_memory mem : sint8_memory).{align ty a} <- Int32.to_int x
  | SInt16Mem, Int32 x ->
    (cast_memory mem : sint16_memory).{align ty a} <- Int32.to_int x
  | SInt32Mem, Int32 x ->
    (cast_memory mem : sint32_memory).{align ty a} <- x
  | SInt64Mem, Int64 x ->
    (cast_memory mem : sint64_memory).{align ty a} <- x
  | UInt8Mem, Int32 x ->
    (cast_memory mem : uint8_memory).{align ty a} <- Int32.to_int x
  | UInt16Mem, Int32 x ->
    (cast_memory mem : uint16_memory).{align ty a} <- Int32.to_int x
  | UInt32Mem, Int32 x ->
    (cast_memory mem : uint32_memory).{align ty a} <- x
  | UInt64Mem, Int64 x ->
    (cast_memory mem : uint64_memory).{align ty a} <- x
  | Float32Mem, Float32 x ->
    (cast_memory mem : float32_memory).{align ty a} <- x
  | Float64Mem, Float64 x ->
    (cast_memory mem : float64_memory).{align ty a} <- x
  | _ -> assert false
  with Invalid_argument _ -> raise Bounds


let buf = create 8

let load_unaligned mem a ty =
  try
    Array1.blit (Array1.sub mem a (mem_size ty)) buf;
    load_aligned buf 0 ty
  with Invalid_argument _ -> raise Bounds

let store_unaligned mem a ty v =
  try
    store_aligned buf 0 ty v;
    Array1.blit (Array1.sub buf 0 (mem_size ty))
      (Array1.sub mem a (mem_size ty))
  with Invalid_argument _ -> raise Bounds


let load mem align =
  (match align with Aligned -> load_aligned | Unaligned -> load_unaligned) mem
let store mem align =
  (match align with Aligned -> store_aligned | Unaligned -> store_unaligned) mem

(*
 * (c) 2015 Andreas Rossberg
 *)

open Bigarray


(* Types and view types *)

type address = int
type alignment = Aligned | Unaligned
type mem_type =
  | SInt8Mem | SInt16Mem | SInt32Mem | SInt64Mem
  | UInt8Mem | UInt16Mem | UInt32Mem | UInt64Mem
  | Float32Mem | Float64Mem

type memory = (int, int8_unsigned_elt, c_layout) Array1.t
type t = memory

type char_view = (char, int8_unsigned_elt, c_layout) Array1.t
type sint8_view = (int, int8_signed_elt, c_layout) Array1.t
type sint16_view = (int, int16_signed_elt, c_layout) Array1.t
type sint32_view = (int32, int32_elt, c_layout) Array1.t
type sint64_view = (int64, int64_elt, c_layout) Array1.t
type uint8_view = (int, int8_unsigned_elt, c_layout) Array1.t
type uint16_view = (int, int16_unsigned_elt, c_layout) Array1.t
type uint32_view = (int32, int32_elt, c_layout) Array1.t
type uint64_view = (int64, int64_elt, c_layout) Array1.t
type float32_view = (float, float32_elt, c_layout) Array1.t
type float64_view = (float, float64_elt, c_layout) Array1.t

let view : memory -> ('c, 'd, c_layout) Array1.t = Obj.magic


(* Creation and initialization *)

exception Bounds
exception Align
exception Address

let create n =
  let mem = Array1.create Int8_unsigned C_layout n in
  Array1.fill mem 0;
  mem

let init mem s =
  if String.length s > Array1.dim mem then raise Bounds;
  (* There currently is no way to blit from a string. *)
  for i = 0 to String.length s - 1 do
    (view mem : char_view).{i} <- s.[i]
  done


(* Alignment *)

let mem_size = function
  | SInt8Mem | UInt8Mem -> 1
  | SInt16Mem | UInt16Mem -> 2
  | SInt32Mem | UInt32Mem | Float32Mem -> 4
  | SInt64Mem | UInt64Mem | Float64Mem -> 8

let mem_alignment = mem_size

let align ty a =
  let n = mem_alignment ty in
  if a mod n <> 0 then raise Align else a / n


open Values

let address_of_value = function
  | Int32 i -> Int32.to_int i
  | Int64 i -> Int64.to_int i
  | _ -> raise Address


(* Load and store *)

let load_aligned mem a ty =
  try match ty with
  | SInt8Mem -> Int32 (Int32.of_int (view mem : sint8_view).{align ty a})
  | SInt16Mem -> Int32 (Int32.of_int (view mem : sint16_view).{align ty a})
  | SInt32Mem -> Int32 (view mem : sint32_view).{align ty a}
  | SInt64Mem -> Int64 (view mem : sint64_view).{align ty a}
  | UInt8Mem -> Int32 (Int32.of_int (view mem : uint8_view).{align ty a})
  | UInt16Mem -> Int32 (Int32.of_int (view mem : uint16_view).{align ty a})
  | UInt32Mem -> Int32 (view mem : uint32_view).{align ty a}
  | UInt64Mem -> Int64 (view mem : uint64_view).{align ty a}
  | Float32Mem -> Float32 (view mem : float32_view).{align ty a}
  | Float64Mem -> Float64 (view mem : float64_view).{align ty a}
  with Invalid_argument _ -> raise Bounds

let store_aligned mem a ty v =
  try match ty, v with
  | SInt8Mem, Int32 x -> (view mem : sint8_view).{align ty a} <- Int32.to_int x
  | SInt16Mem, Int32 x -> (view mem : sint16_view).{align ty a} <- Int32.to_int x
  | SInt32Mem, Int32 x -> (view mem : sint32_view).{align ty a} <- x
  | SInt64Mem, Int64 x -> (view mem : sint64_view).{align ty a} <- x
  | UInt8Mem, Int32 x -> (view mem : uint8_view).{align ty a} <- Int32.to_int x
  | UInt16Mem, Int32 x -> (view mem : uint16_view).{align ty a} <- Int32.to_int x
  | UInt32Mem, Int32 x -> (view mem : uint32_view).{align ty a} <- x
  | UInt64Mem, Int64 x -> (view mem : uint64_view).{align ty a} <- x
  | Float32Mem, Float32 x -> (view mem : float32_view).{align ty a} <- x
  | Float64Mem, Float64 x -> (view mem : float64_view).{align ty a} <- x
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

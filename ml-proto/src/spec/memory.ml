(*
 * (c) 2015 Andreas Rossberg
 *)

open Bigarray


(* Types and view types *)

type address = int
type size = address
type mem_size = int
type mem_type =
  | SInt8Mem | SInt16Mem | SInt32Mem | SInt64Mem
  | UInt8Mem | UInt16Mem | UInt32Mem | UInt64Mem
  | Float32Mem | Float64Mem

type segment =
{
  addr : address;
  data : string
}

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


(* Queries *)

let mem_size = function
  | SInt8Mem | UInt8Mem -> 1
  | SInt16Mem | UInt16Mem -> 2
  | SInt32Mem | UInt32Mem | Float32Mem -> 4
  | SInt64Mem | UInt64Mem | Float64Mem -> 8


(* Creation and initialization *)

exception Type
exception Bounds
exception Address

let create n =
  let mem = Array1.create Int8_unsigned C_layout n in
  Array1.fill mem 0;
  mem

let init_seg mem seg =
  (* There currently is no way to blit from a string. *)
  for i = 0 to String.length seg.data - 1 do
    (view mem : char_view).{seg.addr + i} <- seg.data.[i]
  done

let init mem segs =
  try List.iter (init_seg mem) segs with Invalid_argument _ -> raise Bounds


open Values

let address_of_value = function
  | Int32 i -> Int32.to_int i
  | _ -> raise Address


(* Load and store *)

let int32_mask = Int64.shift_right_logical (Int64.of_int (-1)) 32
let int64_of_int32_u i = Int64.logand (Int64.of_int32 i) int32_mask

let buf = create 8

let load mem a memty valty =
  let sz = mem_size memty in
  let open Types in
  try
    Array1.blit (Array1.sub mem a sz) (Array1.sub buf 0 sz);
    match memty, valty with
    | SInt8Mem, Int32Type -> Int32 (Int32.of_int (view buf : sint8_view).{0})
    | SInt8Mem, Int64Type -> Int64 (Int64.of_int (view buf : sint8_view).{0})
    | SInt16Mem, Int32Type -> Int32 (Int32.of_int (view buf : sint16_view).{0})
    | SInt16Mem, Int64Type -> Int64 (Int64.of_int (view buf : sint16_view).{0})
    | SInt32Mem, Int32Type -> Int32 (view buf : sint32_view).{0}
    | SInt32Mem, Int64Type ->
      Int64 (Int64.of_int32 (view buf : sint32_view).{0})
    | SInt64Mem, Int64Type -> Int64 (view buf : sint64_view).{0}
    | UInt8Mem, Int32Type -> Int32 (Int32.of_int (view buf : uint8_view).{0})
    | UInt8Mem, Int64Type -> Int64 (Int64.of_int (view buf : uint8_view).{0})
    | UInt16Mem, Int32Type -> Int32 (Int32.of_int (view buf : uint16_view).{0})
    | UInt16Mem, Int64Type -> Int64 (Int64.of_int (view buf : uint16_view).{0})
    | UInt32Mem, Int32Type -> Int32 (view buf : uint32_view).{0}
    | UInt32Mem, Int64Type ->
      Int64 (int64_of_int32_u (view buf : uint32_view).{0})
    | UInt64Mem, Int64Type -> Int64 (view buf : uint64_view).{0}
    | Float32Mem, Float32Type -> Float32 (view buf : float32_view).{0}
    | Float64Mem, Float64Type -> Float64 (view buf : float64_view).{0}
    | _ -> raise Type
  with Invalid_argument _ -> raise Bounds

let store mem a memty v =
  let sz = mem_size memty in
  try
    (match memty, v with
    | SInt8Mem, Int32 x -> (view buf : sint8_view).{0} <- Int32.to_int x
    | SInt8Mem, Int64 x -> (view buf : sint8_view).{0} <- Int64.to_int x
    | SInt16Mem, Int32 x -> (view buf : sint16_view).{0} <- Int32.to_int x
    | SInt16Mem, Int64 x -> (view buf : sint16_view).{0} <- Int64.to_int x
    | SInt32Mem, Int32 x -> (view buf : sint32_view).{0} <- x
    | SInt32Mem, Int64 x -> (view buf : sint32_view).{0} <- Int64.to_int32 x
    | SInt64Mem, Int64 x -> (view buf : sint64_view).{0} <- x
    | UInt8Mem, Int32 x -> (view buf : uint8_view).{0} <- Int32.to_int x
    | UInt8Mem, Int64 x -> (view buf : uint8_view).{0} <- Int64.to_int x
    | UInt16Mem, Int32 x -> (view buf : uint16_view).{0} <- Int32.to_int x
    | UInt16Mem, Int64 x -> (view buf : uint16_view).{0} <- Int64.to_int x
    | UInt32Mem, Int32 x -> (view buf : uint32_view).{0} <- x
    | UInt32Mem, Int64 x -> (view buf : uint32_view).{0} <- Int64.to_int32 x
    | UInt64Mem, Int64 x -> (view buf : uint64_view).{0} <- x
    | Float32Mem, Float32 x -> (view buf : float32_view).{0} <- x
    | Float64Mem, Float64 x -> (view buf : float64_view).{0} <- x
    | _ -> raise Type);
    Array1.blit (Array1.sub buf 0 sz) (Array1.sub mem a sz)
  with Invalid_argument _ -> raise Bounds

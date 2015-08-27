(*
 * (c) 2015 Andreas Rossberg
 *)

open Bigarray


(* Types and view types *)

type address = int
type size = address
type alignment = Aligned | Unaligned
type mem_type =
  | SInt8Mem | SInt16Mem | SInt32Mem | SInt64Mem
  | UInt8Mem | UInt16Mem | UInt32Mem | UInt64Mem
  | Float32Mem | Float64Mem

let mem_size = function
  | SInt8Mem | UInt8Mem -> 1
  | SInt16Mem | UInt16Mem -> 2
  | SInt32Mem | UInt32Mem | Float32Mem -> 4
  | SInt64Mem | UInt64Mem | Float64Mem -> 8

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


(* Creation and initialization *)

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

let buf = create 8

let load mem a ty =
  let sz = mem_size ty in
  try
    Array1.blit (Array1.sub mem a sz) (Array1.sub buf 0 sz);
    match ty with
    | SInt8Mem -> Int32 (Int32.of_int (view buf : sint8_view).{0})
    | SInt16Mem -> Int32 (Int32.of_int (view buf : sint16_view).{0})
    | SInt32Mem -> Int32 (view buf : sint32_view).{0}
    | SInt64Mem -> Int64 (view buf : sint64_view).{0}
    | UInt8Mem -> Int32 (Int32.of_int (view buf : uint8_view).{0})
    | UInt16Mem -> Int32 (Int32.of_int (view buf : uint16_view).{0})
    | UInt32Mem -> Int32 (view buf : uint32_view).{0}
    | UInt64Mem -> Int64 (view buf : uint64_view).{0}
    | Float32Mem -> Float32 (view buf : float32_view).{0}
    | Float64Mem -> Float64 (view buf : float64_view).{0}
  with Invalid_argument _ -> raise Bounds

let store mem a ty v =
  let sz = mem_size ty in
  try
    (match ty, v with
    | SInt8Mem, Int32 x -> (view buf : sint8_view).{0} <- Int32.to_int x
    | SInt16Mem, Int32 x -> (view buf : sint16_view).{0} <- Int32.to_int x
    | SInt32Mem, Int32 x -> (view buf : sint32_view).{0} <- x
    | SInt64Mem, Int64 x -> (view buf : sint64_view).{0} <- x
    | UInt8Mem, Int32 x -> (view buf : uint8_view).{0} <- Int32.to_int x
    | UInt16Mem, Int32 x -> (view buf : uint16_view).{0} <- Int32.to_int x
    | UInt32Mem, Int32 x -> (view buf : uint32_view).{0} <- x
    | UInt64Mem, Int64 x -> (view buf : uint64_view).{0} <- x
    | Float32Mem, Float32 x -> (view buf : float32_view).{0} <- x
    | Float64Mem, Float64 x -> (view buf : float64_view).{0} <- x
    | _ -> assert false);
    Array1.blit (Array1.sub buf 0 sz) (Array1.sub mem a sz)
  with Invalid_argument _ -> raise Bounds

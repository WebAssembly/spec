(*
 * (c) 2015 Andreas Rossberg
 *)

open Bigarray


(* Types and view types *)

type address = int
type size = address
type mem_size = int
type extension = SX | ZX | NX
type mem_type =
  Int8Mem | Int16Mem | Int32Mem | Int64Mem | Float32Mem | Float64Mem

type segment =
{
  addr : address;
  data : string
}

type memory' = (int, int8_unsigned_elt, c_layout) Array1.t
type memory = memory' ref
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
type float32_view = (int32, int32_elt, c_layout) Array1.t
type float64_view = (int64, int64_elt, c_layout) Array1.t

let view : memory' -> ('c, 'd, c_layout) Array1.t = Obj.magic


(* Queries *)

let mem_size = function
  | Int8Mem -> 1
  | Int16Mem -> 2
  | Int32Mem | Float32Mem -> 4
  | Int64Mem | Float64Mem -> 8


(* Creation and initialization *)

exception Type
exception Bounds
exception Address

let create' n =
  let mem = Array1.create Int8_unsigned C_layout n in
  Array1.fill mem 0;
  mem

let create n =
  ref (create' n)

let init_seg mem seg =
  (* There currently is no way to blit from a string. *)
  for i = 0 to String.length seg.data - 1 do
    (view !mem : char_view).{seg.addr + i} <- seg.data.[i]
  done

let init mem segs =
  try List.iter (init_seg mem) segs with Invalid_argument _ -> raise Bounds


let size mem =
  Array1.dim !mem

let resize mem n =
  let before = !mem in
  let after = create' n in
  let min = min (Array1.dim before) n in
  Array1.blit (Array1.sub before 0 min) (Array1.sub after 0 min);
  mem := after

open Values

let address_of_value = function
  | Int32 i -> Int32.to_int i
  | _ -> raise Address


(* Load and store *)

let int32_mask = Int64.shift_right_logical (Int64.of_int (-1)) 32
let int64_of_int32_u i = Int64.logand (Int64.of_int32 i) int32_mask

let buf = create' 8

let load mem a memty ext =
  let sz = mem_size memty in
  let open Types in
  try
    Array1.blit (Array1.sub !mem a sz) (Array1.sub buf 0 sz);
    match memty, ext with
    | Int8Mem, SX -> Int32 (Int32.of_int (view buf : sint8_view).{0})
    | Int8Mem, ZX -> Int32 (Int32.of_int (view buf : uint8_view).{0})
    | Int16Mem, SX -> Int32 (Int32.of_int (view buf : sint16_view).{0})
    | Int16Mem, ZX -> Int32 (Int32.of_int (view buf : uint16_view).{0})
    | Int32Mem, NX -> Int32 (view buf : sint32_view).{0}
    | Int64Mem, NX -> Int64 (view buf : sint64_view).{0}
    | Float32Mem, NX -> Float32 (Float32.of_bits (view buf : float32_view).{0})
    | Float64Mem, NX -> Float64 (Float64.of_bits (view buf : float64_view).{0})
    | _ -> raise Type
  with Invalid_argument _ -> raise Bounds

let store mem a memty v =
  let sz = mem_size memty in
  try
    (match memty, v with
    | Int8Mem, Int32 x -> (view buf : sint8_view).{0} <- Int32.to_int x
    | Int16Mem, Int32 x -> (view buf : sint16_view).{0} <- Int32.to_int x
    | Int32Mem, Int32 x -> (view buf : sint32_view).{0} <- x
    | Int64Mem, Int64 x -> (view buf : sint64_view).{0} <- x
    | Float32Mem, Float32 x -> (view buf : float32_view).{0} <- Float32.to_bits x
    | Float64Mem, Float64 x -> (view buf : float64_view).{0} <- Float64.to_bits x
    | _ -> raise Type);
    Array1.blit (Array1.sub buf 0 sz) (Array1.sub !mem a sz)
  with Invalid_argument _ -> raise Bounds

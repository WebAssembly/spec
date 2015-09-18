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
    !mem.{seg.addr + i} <- Char.code seg.data.[i]
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

(* TODO: Can the conversion to int overflow? *)
let address_of_value = function
  | Int32 i -> Int32.to_int i
  | _ -> raise Address


(* Load and store *)

let load8 mem a ext =
  (match ext with
  | SX -> Int32.shift_right (Int32.shift_left (Int32.of_int !mem.{a}) 24) 24
  | _ -> Int32.of_int !mem.{a})

let load16 mem a ext =
  Int32.logor (load8 mem a NX) (Int32.shift_left (load8 mem (a+1) ext) 8)

let load32 mem a =
  Int32.logor (load16 mem a NX) (Int32.shift_left (load16 mem (a+2) NX) 16)

let load64 mem a =
  Int64.logor (Int64.of_int32 (load32 mem a)) (Int64.shift_left (Int64.of_int32 (load32 mem (a+4))) 32)

let store8 mem a bits =
  !mem.{a} <- Int32.to_int (Int32.logand bits (Int32.of_int 255))

let store16 mem a bits =
  store8 mem (a+0) bits;
  store8 mem (a+1) (Int32.shift_right_logical bits 8)

let store32 mem a bits =
  store16 mem (a+0) bits;
  store16 mem (a+2) (Int32.shift_right_logical bits 16)

let store64 mem a bits =
  store32 mem (a+0) (Int64.to_int32 bits);
  store32 mem (a+4) (Int64.to_int32 (Int64.shift_right_logical bits 32))

let load mem a memty ext =
  let open Types in
  try
    match memty, ext with
    | Int8Mem, _ -> Int32 (load8 mem a ext)
    | Int16Mem, _ -> Int32 (load16 mem a ext)
    | Int32Mem, NX -> Int32 (load32 mem a)
    | Int64Mem, NX -> Int64 (load64 mem a)
    | Float32Mem, NX -> Float32 (Float32.of_bits (load32 mem a))
    | Float64Mem, NX -> Float64 (Float64.of_bits (load64 mem a))
    | _ -> raise Type
  with Invalid_argument _ -> raise Bounds

let store mem a memty v =
  try
    (match memty, v with
    | Int8Mem, Int32 x -> store8 mem a x
    | Int16Mem, Int32 x -> store16 mem a x
    | Int32Mem, Int32 x -> store32 mem a x
    | Int64Mem, Int64 x -> store64 mem a x
    | Float32Mem, Float32 x -> store32 mem a (Float32.to_bits x)
    | Float64Mem, Float64 x -> store64 mem a (Float64.to_bits x)
    | _ -> raise Type)
  with Invalid_argument _ -> raise Bounds

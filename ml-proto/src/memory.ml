(*
 * (c) 2015 Andreas Rossberg
 *)

open Bigarray


(* Types and view types *)

type address = int
type size = address
type signed = bool option

type segment =
{
  addr : address;
  data : string
}

type memory = (int, int8_unsigned_elt, c_layout) Array1.t
type t = memory

type char_view = (char, int8_unsigned_elt, c_layout) Array1.t
type sint8_view = (int, int8_signed_elt, c_layout) Array1.t
type uint8_view = (int, int8_unsigned_elt, c_layout) Array1.t
type sint16_view = (int, int16_signed_elt, c_layout) Array1.t
type uint16_view = (int, int16_unsigned_elt, c_layout) Array1.t
type int32_view = (int32, int32_elt, c_layout) Array1.t
type int64_view = (int64, int64_elt, c_layout) Array1.t
type float32_view = (float, float32_elt, c_layout) Array1.t
type float64_view = (float, float64_elt, c_layout) Array1.t

let view : memory -> ('c, 'd, c_layout) Array1.t = Obj.magic


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

let load mem a sz t signed =
  try
    Array1.blit (Array1.sub mem a (sz/8)) (Array1.sub buf 0 (sz/8));
    let open Types in
    match t, sz, signed with
    | Int32Type, 8, Some true ->
      Int32 (Int32.of_int (view buf : sint8_view).{0})
    | Int32Type, 8, Some false ->
      Int32 (Int32.of_int (view buf : uint8_view).{0})
    | Int32Type, 16, Some true ->
      Int32 (Int32.of_int (view buf : sint16_view).{0})
    | Int32Type, 16, Some false ->
      Int32 (Int32.of_int (view buf : uint16_view).{0})
    | Int32Type, 32, None ->
      Int32 (view buf : int32_view).{0}
    | Int64Type, 8, Some true ->
      Int64 (Int64.of_int (view buf : sint8_view).{0})
    | Int64Type, 8, Some false ->
      Int64 (Int64.of_int (view buf : uint8_view).{0})
    | Int64Type, 16, Some true ->
      Int64 (Int64.of_int (view buf : sint16_view).{0})
    | Int64Type, 16, Some false ->
      Int64 (Int64.of_int (view buf : uint16_view).{0})
    | Int64Type, 32, Some true ->
      Int64 (Int64.of_int32 (view buf : int32_view).{0})
    | Int64Type, 32, Some false ->
      Int64 (int64_of_int32_u (view buf : int32_view).{0})
    | Int64Type, 64, None ->
      Int64 (view buf : int64_view).{0}
    | Float32Type, 32, None -> Float32 (view buf : float32_view).{0}
    | Float64Type, 64, None -> Float64 (view buf : float64_view).{0}
    | _ -> raise Type
  with Invalid_argument _ -> raise Bounds

let store mem a sz v =
  try
    (match v, sz with
    | Int32 x, 8 -> (view buf : sint8_view).{0} <- Int32.to_int x
    | Int64 x, 8 -> (view buf : sint8_view).{0} <- Int64.to_int x
    | Int32 x, 16 -> (view buf : sint16_view).{0} <- Int32.to_int x
    | Int64 x, 16 -> (view buf : sint16_view).{0} <- Int64.to_int x
    | Int32 x, 32 -> (view buf : int32_view).{0} <- x
    | Int64 x, 32 -> (view buf : int32_view).{0} <- Int64.to_int32 x
    | Int64 x, 64 -> (view buf : int64_view).{0} <- x
    | Float32 x, 32 -> (view buf : float32_view).{0} <- x
    | Float64 x, 64 -> (view buf : float64_view).{0} <- x
    | _ -> raise Type);
    Array1.blit (Array1.sub buf 0 (sz/8)) (Array1.sub mem a (sz/8))
  with Invalid_argument _ -> raise Bounds

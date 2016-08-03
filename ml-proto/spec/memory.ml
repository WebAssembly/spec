open Bigarray
open Types
open Values

type size = int64
type address = int64
type offset = int64

type mem_size = Mem8 | Mem16 | Mem32
type extension = SX | ZX

type value = Values.value
type value_type = Types.value_type

type memory' = (int, int8_unsigned_elt, c_layout) Array1.t
type memory = {mutable content : memory'; max : size option}
type t = memory

exception Type
exception Bounds
exception SizeOverflow
exception SizeLimit

let page_size = 0x10000L (* 64 KiB *)

(*
 * These limitations should be considered part of the host environment and not
 * part of the spec defined by this file.
 * ==========================================================================
 *)

let host_size_of_int64 n =
  if n < 0L || n > Int64.of_int max_int then raise Out_of_memory;
  Int64.to_int n

let int64_of_host_size n =
  Int64.of_int n

let host_index_of_int64 a n =
  assert (n >= 0);
  let n' = Int64.of_int n in
  if (a < 0L) ||
     (Int64.sub Int64.max_int a < n') ||
     (Int64.add a n' > Int64.of_int max_int) then raise Bounds;
  Int64.to_int a

(* ========================================================================== *)

let within_limits n = function
  | None -> true
  | Some max -> I64.le_u n max

let create' n =
  let sz = host_size_of_int64 (Int64.mul n page_size) in
  let mem = Array1.create Int8_unsigned C_layout sz in
  Array1.fill mem 0;
  mem

let create n max =
  assert (within_limits n max);
  {content = create' n; max}

let size mem =
  Int64.div (int64_of_host_size (Array1.dim mem.content)) page_size

let grow mem delta =
  let host_old_size = Array1.dim mem.content in
  let old_size = size mem in
  let new_size = Int64.add old_size delta in
  if I64.gt_u old_size new_size then raise SizeOverflow else
  if not (within_limits new_size mem.max) then raise SizeLimit else
  let after = create' new_size in
  Array1.blit
    (Array1.sub mem.content 0 host_old_size)
    (Array1.sub after 0 host_old_size);
  mem.content <- after

let effective_address a o =
  let ea = Int64.add a o in
  if I64.lt_u ea a then raise Bounds;
  ea

let rec loadn' mem n i =
  let byte = Int64.of_int mem.content.{i} in
  if n = 1 then
    byte
  else
    Int64.logor byte (Int64.shift_left (loadn' mem (n-1) (i+1)) 8)

let rec storen' mem n i v =
  mem.content.{i} <- Int64.to_int v land 255;
  if n > 1 then
    storen' mem (n - 1) (i + 1) (Int64.shift_right v 8)

let loadn mem n ea =
  assert (n > 0 && n <= 8);
  let i = host_index_of_int64 ea n in
  try loadn' mem n i with Invalid_argument _ -> raise Bounds

let storen mem n ea v =
  assert (n > 0 && n <= 8);
  let i = host_index_of_int64 ea n in
  try storen' mem n i v with Invalid_argument _ -> raise Bounds

let load mem a o t =
  let ea = effective_address a o in
  match t with
  | Int32Type -> Int32 (Int64.to_int32 (loadn mem 4 ea))
  | Int64Type -> Int64 (loadn mem 8 ea)
  | Float32Type -> Float32 (F32.of_bits (Int64.to_int32 (loadn mem 4 ea)))
  | Float64Type -> Float64 (F64.of_bits (loadn mem 8 ea))

let store mem a o v =
  let ea = effective_address a o in
  match v with
  | Int32 x -> storen mem 4 ea (Int64.of_int32 x)
  | Int64 x -> storen mem 8 ea x
  | Float32 x -> storen mem 4 ea (Int64.of_int32 (F32.to_bits x))
  | Float64 x -> storen mem 8 ea (F64.to_bits x)

let loadn_sx mem n ea =
  assert (n > 0 && n <= 8);
  let v = loadn mem n ea in
  let shift = 64 - (8 * n) in
  Int64.shift_right (Int64.shift_left v shift) shift

let load_extend mem a o sz ext t =
  let ea = effective_address a o in
  match sz, ext, t with
  | Mem8,  ZX, Int32Type -> Int32 (Int64.to_int32 (loadn    mem 1 ea))
  | Mem8,  SX, Int32Type -> Int32 (Int64.to_int32 (loadn_sx mem 1 ea))
  | Mem8,  ZX, Int64Type -> Int64 (loadn mem 1 ea)
  | Mem8,  SX, Int64Type -> Int64 (loadn_sx mem 1 ea)
  | Mem16, ZX, Int32Type -> Int32 (Int64.to_int32 (loadn    mem 2 ea))
  | Mem16, SX, Int32Type -> Int32 (Int64.to_int32 (loadn_sx mem 2 ea))
  | Mem16, ZX, Int64Type -> Int64 (loadn    mem 2 ea)
  | Mem16, SX, Int64Type -> Int64 (loadn_sx mem 2 ea)
  | Mem32, ZX, Int64Type -> Int64 (loadn    mem 4 ea)
  | Mem32, SX, Int64Type -> Int64 (loadn_sx mem 4 ea)
  | _ -> raise Type

let store_wrap mem a o sz v =
  let ea = effective_address a o in
  match sz, v with
  | Mem8,  Int32 x -> storen mem 1 ea (Int64.of_int32 x)
  | Mem8,  Int64 x -> storen mem 1 ea x
  | Mem16, Int32 x -> storen mem 2 ea (Int64.of_int32 x)
  | Mem16, Int64 x -> storen mem 2 ea x
  | Mem32, Int64 x -> storen mem 4 ea x
  | _ -> raise Type

let blit mem addr data =
  let base = host_index_of_int64 addr 1 in
  try
    for i = 0 to String.length data - 1 do
      mem.content.{base + i} <- Char.code data.[i]
    done
  with Invalid_argument _ -> raise Bounds

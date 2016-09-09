open Bigarray
open Types
open Values

type size = int32  (* number of pages *)
type address = int64
type offset = int64

type mem_size = Mem8 | Mem16 | Mem32
type extension = SX | ZX

type value = Values.value
type value_type = Types.value_type
type 'a limits = 'a Types.limits

type memory' = (int, int8_unsigned_elt, c_layout) Array1.t
type memory = {mutable content : memory'; max : size option}
type t = memory

exception Type
exception Bounds
exception SizeOverflow
exception SizeLimit
exception OutOfMemory

let page_size = 0x10000L (* 64 KiB *)

let mem_size = function
  | Mem8 -> 1
  | Mem16 -> 2
  | Mem32 -> 4

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
  | Some max -> I32.le_u n max

let create' n =
  if I32.gt_u n 0x10000l then raise SizeOverflow else
  try
    let sz = host_size_of_int64 (Int64.mul (Int64.of_int32 n) page_size) in
    let mem = Array1.create Int8_unsigned C_layout sz in
    Array1.fill mem 0;
    mem
  with Out_of_memory -> raise OutOfMemory

let create {min; max} =
  assert (within_limits min max);
  {content = create' min; max}

let size mem =
  Int64.to_int32
    (Int64.div (int64_of_host_size (Array1.dim mem.content)) page_size)

let limits mem =
  {min = size mem; max = mem.max}

let grow mem delta =
  let host_old_size = Array1.dim mem.content in
  let old_size = size mem in
  let new_size = Int32.add old_size delta in
  if I32.gt_u old_size new_size then raise SizeOverflow else
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
  | I32Type -> I32 (Int64.to_int32 (loadn mem 4 ea))
  | I64Type -> I64 (loadn mem 8 ea)
  | F32Type -> F32 (F32.of_bits (Int64.to_int32 (loadn mem 4 ea)))
  | F64Type -> F64 (F64.of_bits (loadn mem 8 ea))

let store mem a o v =
  let ea = effective_address a o in
  match v with
  | I32 x -> storen mem 4 ea (Int64.of_int32 x)
  | I64 x -> storen mem 8 ea x
  | F32 x -> storen mem 4 ea (Int64.of_int32 (F32.to_bits x))
  | F64 x -> storen mem 8 ea (F64.to_bits x)

let loadn_sx mem n ea =
  assert (n > 0 && n <= 8);
  let v = loadn mem n ea in
  let shift = 64 - (8 * n) in
  Int64.shift_right (Int64.shift_left v shift) shift

let load_packed sz ext mem a o t =
  let ea = effective_address a o in
  match sz, ext, t with
  | Mem8,  ZX, I32Type -> I32 (Int64.to_int32 (loadn    mem 1 ea))
  | Mem8,  SX, I32Type -> I32 (Int64.to_int32 (loadn_sx mem 1 ea))
  | Mem8,  ZX, I64Type -> I64 (loadn mem 1 ea)
  | Mem8,  SX, I64Type -> I64 (loadn_sx mem 1 ea)
  | Mem16, ZX, I32Type -> I32 (Int64.to_int32 (loadn    mem 2 ea))
  | Mem16, SX, I32Type -> I32 (Int64.to_int32 (loadn_sx mem 2 ea))
  | Mem16, ZX, I64Type -> I64 (loadn    mem 2 ea)
  | Mem16, SX, I64Type -> I64 (loadn_sx mem 2 ea)
  | Mem32, ZX, I64Type -> I64 (loadn    mem 4 ea)
  | Mem32, SX, I64Type -> I64 (loadn_sx mem 4 ea)
  | _ -> raise Type

let store_packed sz mem a o v =
  let ea = effective_address a o in
  match sz, v with
  | Mem8,  I32 x -> storen mem 1 ea (Int64.of_int32 x)
  | Mem8,  I64 x -> storen mem 1 ea x
  | Mem16, I32 x -> storen mem 2 ea (Int64.of_int32 x)
  | Mem16, I64 x -> storen mem 2 ea x
  | Mem32, I64 x -> storen mem 4 ea x
  | _ -> raise Type

let blit mem addr data =
  let base = host_index_of_int64 addr 1 in
  try
    for i = 0 to String.length data - 1 do
      mem.content.{base + i} <- Char.code data.[i]
    done
  with Invalid_argument _ -> raise Bounds

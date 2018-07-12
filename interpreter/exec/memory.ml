open Bigarray
open Lib.Bigarray
open Types
open Values

type size = int32  (* number of pages *)
type address = int64
type offset = int32

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

let within_limits n = function
  | None -> true
  | Some max -> I32.le_u n max

let create' n =
  if I32.gt_u n 0x10000l then raise SizeOverflow else
  try
    let size = Int64.(mul (of_int32 n) page_size) in
    let mem = Array1_64.create Int8_unsigned C_layout size in
    Array1.fill mem 0;
    mem
  with Out_of_memory -> raise OutOfMemory

let create {min; max} =
  assert (within_limits min max);
  {content = create' min; max}

let bound mem =
  Array1_64.dim mem.content

let size mem =
  Int64.(to_int32 (div (bound mem) page_size))

let limits mem =
  {min = size mem; max = mem.max}

let grow mem delta =
  let old_size = size mem in
  let new_size = Int32.add old_size delta in
  if I32.gt_u old_size new_size then raise SizeOverflow else
  if not (within_limits new_size mem.max) then raise SizeLimit else
  let after = create' new_size in
  let dim = Array1_64.dim mem.content in
  Array1.blit (Array1_64.sub mem.content 0L dim) (Array1_64.sub after 0L dim);
  mem.content <- after

let effective_address a o =
  let ea = Int64.(add a (of_int32 o)) in
  if I64.lt_u ea a then raise Bounds;
  ea

let loadn mem n ea =
  assert (n > 0 && n <= 8);
  let rec loop mem n i =
    if n = 0 then 0L else
    let rest = Int64.(shift_left (loop mem (n - 1) (add i 1L)) 8) in
    let byte = Int64.of_int (Array1_64.get mem.content i) in
    Int64.logor byte rest
  in
  try loop mem n ea with Invalid_argument _ -> raise Bounds

let storen mem n ea v =
  assert (n > 0 && n <= 8);
  let rec loop mem n i v =
    if n > 0 then begin
      Int64.(loop mem (n - 1) (add i 1L) (shift_right v 8));
      Array1_64.set mem.content i (Int64.to_int v land 255)
    end
  in
  try loop mem n ea v with Invalid_argument _ -> raise Bounds

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
  Int64.(shift_right (shift_left v shift) shift)

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
  try
    for i = String.length data - 1 downto 0 do
      Array1_64.set mem.content Int64.(add addr (of_int i)) (Char.code data.[i])
    done
  with Invalid_argument _ -> raise Bounds

let gm = create {max=None; min=1l}

let of_bytes s =
  let m = gm in
  let sz = Bytes.length s in
  for i = 0 to sz-1 do
    Array1_64.set m.content (Int64.of_int i) (Char.code (Bytes.get s i))
  done;
  m

let to_bytes m =
(*  let sz = Int64.to_int (Array1_64.dim m.content) in *)
  let sz = 16 in
  let res = Bytes.create sz in
  for i = 0 to sz-1 do
    Bytes.set res i (Char.chr (Array1_64.get m.content (Int64.of_int i)))
  done;
  res


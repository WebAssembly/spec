open Types
open Value
open Bigarray
open Lib.Bigarray

type size = int64  (* number of pages *)
type offset = address
type count = int32

type memory' = (int, int8_unsigned_elt, c_layout) Array1.t
type memory = {mutable ty : memorytype; mutable content : memory'}
type t = memory

exception Type = Value.Type
exception Bounds
exception SizeOverflow
exception SizeLimit
exception OutOfMemory

let page_size = 0x10000L (* 64 KiB *)

let valid_limits {min; max} =
  match max with
  | None -> true
  | Some m -> I64.le_u min m

let valid_size at i =
  match at with
  | I32AT -> I64.le_u i 0xffffL
  | I64AT -> true

let create n =
  try
    let size = Int64.(mul n page_size) in
    let mem = Array1_64.create Int8_unsigned C_layout size in
    Array1.fill mem 0;
    mem
  with Out_of_memory -> raise OutOfMemory

let alloc (MemoryT (at, lim) as ty) =
  assert Free.((memorytype ty).types = Set.empty);
  if not (valid_size at lim.min) then raise SizeOverflow;
  if not (valid_limits lim) then raise Type;
  {ty; content = create lim.min}

let bound mem =
  Array1_64.dim mem.content

let size mem =
  Int64.(div (bound mem) page_size)

let type_of mem =
  mem.ty

let addrtype_of mem =
  let MemoryT (at, _) = type_of mem in at

let grow mem delta =
  let MemoryT (at, lim) = mem.ty in
  assert (lim.min = size mem);
  let old_size = lim.min in
  let new_size = Int64.add old_size delta in
  if I64.gt_u old_size new_size then raise SizeOverflow else
  let lim' = {lim with min = new_size} in
  if not (valid_size at new_size) then raise SizeOverflow else
  if not (valid_limits lim') then raise SizeLimit else
  let after = create new_size in
  let dim = Array1_64.dim mem.content in
  Array1.blit (Array1_64.sub mem.content 0L dim) (Array1_64.sub after 0L dim);
  mem.ty <- MemoryT (at, lim');
  mem.content <- after

let load_byte mem a =
  if a < 0L || a >= Array1_64.dim mem.content then raise Bounds;
  Array1_64.get mem.content a

let store_byte mem a b =
  if a < 0L || a >= Array1_64.dim mem.content then raise Bounds;
  Array1_64.set mem.content a b

let load_bytes mem a n =
  let buf = Buffer.create n in
  for i = 0 to n - 1 do
    Buffer.add_char buf (Char.chr (load_byte mem Int64.(add a (of_int i))))
  done;
  Buffer.contents buf

let store_bytes mem a bs =
  if a < 0L then raise Bounds;
  for i = String.length bs - 1 downto 0 do
    store_byte mem Int64.(add a (of_int i)) (Char.code bs.[i])
  done


(* Typed accessors *)

let effective_address a o =
  let ea = Int64.(add a o) in
  if I64.lt_u ea a then raise Bounds;
  ea

let load_num mem a o nt =
  let bs = load_bytes mem (effective_address a o) (Types.num_size nt) in
  Value.num_of_bits nt bs

let store_num mem a o n =
  let bs = Value.bits_of_num n in
  store_bytes mem (effective_address a o) bs

let load_num_packed sz sx mem a o nt =
  let bs = load_bytes mem (effective_address a o) (Pack.packed_size sz) in
  Value.num_of_packed_bits nt sz sx bs

let store_num_packed sz mem a o n =
  let bs = Value.packed_bits_of_num sz n in
  store_bytes mem (effective_address a o) bs

let load_vec mem a o vt =
  let bs = load_bytes mem (effective_address a o) (Types.vec_size vt) in
  Value.vec_of_bits vt bs

let store_vec mem a o v =
  let bs = Value.bits_of_vec v in
  store_bytes mem (effective_address a o) bs

let load_vec_packed sz vext mem a o t =
  let bs = load_bytes mem (effective_address a o) (Pack.packed_size sz) in
  Value.vec_of_packed_bits t sz vext bs

let load_val mem a o t =
  let bs = load_bytes mem (effective_address a o) (Types.val_size t) in
  Value.val_of_bits t bs

let store_val mem a o v =
  let bs = Value.bits_of_val v in
  store_bytes mem (effective_address a o) bs

let load_val_storage mem a o st =
  let bs = load_bytes mem (effective_address a o) (Types.storage_size st) in
  Value.val_of_storage_bits st bs

let store_val_storage mem a o st v =
  let bs = Value.storage_bits_of_val st v in
  store_bytes mem (effective_address a o) bs

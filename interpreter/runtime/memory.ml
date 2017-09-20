open Bigarray
open Lib.Bigarray
open Types
open Values

type size = int32  (* number of pages *)
type address = int64
type offset = int32

type mem_size = Mem8 | Mem16 | Mem32
type extension = SX | ZX

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

let create n =
  if I32.gt_u n 0x10000l then raise SizeOverflow else
  try
    let size = Int64.(mul (of_int32 n) page_size) in
    let mem = Array1_64.create Int8_unsigned C_layout size in
    Array1.fill mem 0;
    mem
  with Out_of_memory -> raise OutOfMemory

let alloc (MemoryType {min; max}) =
  assert (within_limits min max);
  {content = create min; max}

let bound mem =
  Array1_64.dim mem.content

let size mem =
  Int64.(to_int32 (div (bound mem) page_size))

let type_of mem =
  MemoryType {min = size mem; max = mem.max}

let grow mem delta =
  let old_size = size mem in
  let new_size = Int32.add old_size delta in
  if I32.gt_u old_size new_size then raise SizeOverflow else
  if not (within_limits new_size mem.max) then raise SizeLimit else
  let after = create new_size in
  let dim = Array1_64.dim mem.content in
  Array1.blit (Array1_64.sub mem.content 0L dim) (Array1_64.sub after 0L dim);
  mem.content <- after

let load_byte mem a =
  try Array1_64.get mem.content a with Invalid_argument _ -> raise Bounds

let store_byte mem a b =
  try Array1_64.set mem.content a b with Invalid_argument _ -> raise Bounds

let load_bytes mem a n =
  let buf = Buffer.create n in
  for i = 0 to n - 1 do
    Buffer.add_char buf (Char.chr (load_byte mem Int64.(add a (of_int i))))
  done;
  Buffer.contents buf

let store_bytes mem a bs =
  for i = String.length bs - 1 downto 0 do
    store_byte mem Int64.(add a (of_int i)) (Char.code bs.[i])
  done

let effective_address a o =
  let ea = Int64.(add a (of_int32 o)) in
  if I64.lt_u ea a then raise Bounds;
  ea

let loadn mem a o n =
  assert (n > 0 && n <= 8);
  let rec loop a n =
    if n = 0 then 0L else begin
      let x = Int64.(shift_left (loop (add a 1L) (n - 1)) 8) in
      Int64.logor (Int64.of_int (load_byte mem a)) x
    end
  in loop (effective_address a o) n

let storen mem a o n x =
  assert (n > 0 && n <= 8);
  let rec loop a n x =
    if n > 0 then begin
      Int64.(loop (add a 1L) (n - 1) (shift_right x 8));
      store_byte mem a (Int64.to_int x land 0xff)
    end
  in loop (effective_address a o) n x

let load_value mem a o t =
  let n = loadn mem a o (Types.size t) in
  match t with
  | I32Type -> I32 (Int64.to_int32 n)
  | I64Type -> I64 n
  | F32Type -> F32 (F32.of_bits (Int64.to_int32 n))
  | F64Type -> F64 (F64.of_bits n)

let store_value mem a o v =
  let x =
    match v with
    | I32 x -> Int64.of_int32 x
    | I64 x -> x
    | F32 x -> Int64.of_int32 (F32.to_bits x)
    | F64 x -> F64.to_bits x
  in storen mem a o (Types.size (Values.type_of v)) x

let extend x n = function
  | ZX -> x
  | SX -> let sh = 64 - 8 * n in Int64.(shift_right (shift_left x sh) sh)

let load_packed sz ext mem a o t =
  assert (mem_size sz <= Types.size t);
  let n = mem_size sz in
  let x = extend (loadn mem a o n) n ext in
  match t with
  | I32Type -> I32 (Int64.to_int32 x)
  | I64Type -> I64 x
  | _ -> raise Type

let store_packed sz mem a o v =
  assert (mem_size sz <= Types.size (Values.type_of v));
  let n = mem_size sz in
  let x =
    match v with
    | I32 x -> Int64.of_int32 x
    | I64 x -> x
    | _ -> raise Type
  in storen mem a o n x

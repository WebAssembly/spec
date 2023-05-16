open Types
open Value

type data = string ref
type t = data
type address = Memory.address

exception Type
exception Bounds

let alloc bs = ref bs
let size seg = I64.of_int_u (String.length !seg)
let load seg a =
  try (!seg).[Int64.to_int a] with Invalid_argument _ -> raise Bounds
let bytes seg = !seg
let drop seg = seg := ""

let load_bytes seg a n =
  let buf = Buffer.create n in
  for i = 0 to n - 1 do
    Buffer.add_char buf (load seg Int64.(add a (of_int i)))
  done;
  Buffer.contents buf

let loadn seg a n =
  assert (n > 0 && n <= 8);
  let rec loop a n =
    if n = 0 then 0L else begin
      let x = Int64.(shift_left (loop (add a 1L) (n - 1)) 8) in
      Int64.logor (Int64.of_int (Char.code (load seg a))) x
    end
  in loop a n

let extend x n = function
  | Pack.ZX -> x
  | Pack.SX -> let sh = 64 - 8 * n in Int64.(shift_right (shift_left x sh) sh)

let load_num seg a t =
  let n = loadn seg a (num_size t) in
  match t with
  | I32T -> I32 (Int64.to_int32 n)
  | I64T -> I64 n
  | F32T -> F32 (F32.of_bits (Int64.to_int32 n))
  | F64T -> F64 (F64.of_bits n)

let load_vec seg a t =
  let bs = load_bytes seg a (vec_size t) in
  match t with
  | V128T -> V128 (V128.of_bits bs)

let load_val seg a t =
  match t with
  | NumT nt -> Num (load_num seg a nt)
  | VecT vt -> Vec (load_vec seg a vt)
  | RefT _ -> raise Type
  | BotT -> assert false

let load_num_packed sz ext seg a t =
  assert (Pack.packed_size sz <= num_size t);
  let n = Pack.packed_size sz in
  let x = extend (loadn seg a n) n ext in
  match t with
  | I32T -> I32 (Int64.to_int32 x)
  | I64T -> I64 x
  | _ -> raise Type

let load_field seg a st =
  match st with
  | ValStorageT t -> load_val seg a t
  | PackStorageT sz -> Num (load_num_packed sz Pack.ZX seg a I32T)

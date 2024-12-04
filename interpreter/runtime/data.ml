type data = string ref
type t = data

exception Bounds

let alloc bs = ref bs

let size seg = I64.of_int_u (String.length !seg)

let drop seg = seg := ""

let load_byte seg a =
  let i = Int64.to_int a in
  if i < 0 || i >= String.length !seg then raise Bounds;
  !seg.[i]

let load_bytes seg a n =
  let i = Int64.to_int a in
  if i < 0 || i + n < 0 || i + n > String.length !seg then raise Bounds;
  String.sub !seg i n


(* Typed accessors *)

let load_num seg a nt =
  let bs = load_bytes seg a (Types.num_size nt) in
  Value.num_of_bits nt bs

let load_num_packed sz ext seg a nt =
  let bs = load_bytes seg a (Pack.packed_size sz) in
  Value.num_of_packed_bits nt sz ext bs

let load_vec seg a vt =
  let bs = load_bytes seg a (Types.vec_size vt) in
  Value.vec_of_bits vt bs

let load_vec_packed sz ext seg a t =
  let bs = load_bytes seg a (Pack.packed_size sz) in
  Value.vec_of_packed_bits t sz ext bs

let load_val seg a t =
  let bs = load_bytes seg a (Types.val_size t) in
  Value.val_of_bits t bs

let load_val_storage seg a st =
  let bs = load_bytes seg a (Types.storage_size st) in
  Value.val_of_storage_bits st bs

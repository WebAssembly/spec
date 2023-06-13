type data = string ref
type t = data

exception Bounds

let alloc bs = ref bs

let size seg = I64.of_int_u (String.length !seg)

let load seg i =
  let i' = Int64.to_int i in
  if i' < 0 || i' >= String.length !seg then raise Bounds;
  !seg.[i']

let drop seg = seg := ""

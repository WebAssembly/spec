type elem = Value.ref_ list ref
type t = elem

exception Bounds

let alloc rs = ref rs
let size seg = Lib.List64.length !seg

let load seg i =
  if i < 0L || i >= Lib.List64.length !seg then raise Bounds;
  Lib.List64.nth !seg i

let drop seg = seg := []

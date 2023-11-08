type elem = Value.ref_ list ref
type t = elem

exception Bounds

let alloc rs = ref rs
let size seg = Lib.List32.length !seg

let load seg i =
  if i < 0l || i >= Lib.List32.length !seg then raise Bounds;
  Lib.List32.nth !seg i

let drop seg = seg := []

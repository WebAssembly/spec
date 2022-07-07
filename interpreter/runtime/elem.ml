type elem = Values.ref_ list ref
type t = elem

let alloc rs = ref rs
let size seg = Lib.List32.length !seg
let load seg i = Lib.List32.nth !seg i
let drop seg = seg := []

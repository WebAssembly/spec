type elem = Value.ref_ list ref
type t = elem

exception Bounds

let alloc rs = ref rs
let size seg = Lib.List32.length !seg
let load seg i = try Lib.List32.nth !seg i with Failure _ -> raise Bounds
let drop seg = seg := []

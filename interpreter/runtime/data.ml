type data = string ref
type t = data

let alloc bs = ref bs
let size seg = I64.of_int_u (String.length !seg)
let load seg i = (!seg).[Int64.to_int i]
let drop seg = seg := ""

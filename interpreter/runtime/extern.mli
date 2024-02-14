open Value

type extern = ref_
type t = extern

type ref_ += ExternRef of extern

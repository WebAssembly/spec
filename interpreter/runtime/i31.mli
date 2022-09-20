open Value

type i31 = int
type t = i31

type ref_ += I31Ref of i31

val of_i32 : int32 -> i31
val to_i32 : Pack.extension -> i31 -> int32

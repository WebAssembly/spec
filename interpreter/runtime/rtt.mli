open Types

type rtt = Rtt of type_addr
type t = rtt

val alloc : type_addr -> rtt

val type_inst_of : rtt -> type_addr
val ctx_type_of : rtt -> ctx_type

val eq_rtt : rtt -> rtt -> bool
val match_rtt : rtt -> rtt -> bool

val string_of_rtt : rtt -> string

open Types
open Value

type rtt = Rtt of sem_var
type t = rtt

type ref_ += RttRef of rtt

val alloc : sem_var -> rtt

val type_inst_of : rtt -> sem_var
val ctx_type_of : rtt -> ctx_type

val match_rtt : rtt -> rtt -> bool

val string_of_rtt : rtt -> string

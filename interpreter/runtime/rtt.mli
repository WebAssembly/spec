open Types
open Value

type rtt = Rtt of sem_var * rtt option
type t = rtt

type ref_ += RttRef of rtt

val alloc : sem_var -> rtt option -> rtt

val type_inst_of : rtt -> sem_var
val def_type_of : rtt -> def_type
val depth : rtt -> int32

val match_rtt : rtt -> rtt -> bool

val string_of_rtt : rtt -> string

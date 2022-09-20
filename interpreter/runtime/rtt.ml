open Types

type rtt = Rtt of type_addr
type t = rtt


let alloc a = Rtt a

let type_inst_of (Rtt a) = a
let ctx_type_of d = def_of (type_inst_of d)

let eq_rtt (Rtt a1) (Rtt a2) = Match.eq_var_type [] (DynX a1) (DynX a2) 
let match_rtt (Rtt a1) (Rtt a2) = Match.match_var_type [] (DynX a1) (DynX a2)

let string_of_rtt (Rtt a) = string_of_var (DynX a)

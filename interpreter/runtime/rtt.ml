open Types

type rtt = Rtt of sem_var
type t = rtt


let alloc x = Rtt x

let type_inst_of (Rtt x) = x
let ctx_type_of d = def_of (type_inst_of d)

let eq_rtt (Rtt x1) (Rtt x2) = Match.eq_var_type [] (SemVar x1) (SemVar x2) 
let match_rtt (Rtt x1) (Rtt x2) = Match.match_var_type [] (SemVar x1) (SemVar x2)

let string_of_rtt (Rtt x) = string_of_var (SemVar x)

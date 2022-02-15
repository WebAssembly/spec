open Types
open Value

type rtt = Rtt of sem_var
type t = rtt

type ref_ += RttRef of rtt


let alloc x = Rtt x

let type_inst_of (Rtt x) = x
let ctx_type_of d = def_of (type_inst_of d)

let eq_rtt (Rtt x1) (Rtt x2) = Match.eq_var_type [] (SemVar x1) (SemVar x2) 
let match_rtt (Rtt x1) (Rtt x2) = Match.match_var_type [] (SemVar x1) (SemVar x2)

let string_of_rtt (Rtt x) = string_of_var (SemVar x)


let () =
  let eq_ref' = !Value.eq_ref' in
  Value.eq_ref' := fun r1 r2 ->
    match r1, r2 with
    | RttRef rtt1, RttRef rtt2 -> eq_rtt rtt1 rtt2
    | _, _ -> eq_ref' r1 r2

let () =
  let type_of_ref' = !Value.type_of_ref' in
  Value.type_of_ref' := function
    | RttRef (Rtt x) -> RttHeapType (SemVar x)
    | r -> type_of_ref' r

let () =
  let string_of_ref' = !Value.string_of_ref' in
  Value.string_of_ref' := function
    | RttRef (Rtt x) -> "(rtt " ^ string_of_var (SemVar x) ^ ")"
    | r -> string_of_ref' r

open Types
open Value

type extern = ref_
type t = extern

type ref_ += ExternRef of extern

let () =
  let eq_ref' = !Value.eq_ref' in
  Value.eq_ref' := fun r1 r2 ->
    match r1, r2 with
    | ExternRef r1', ExternRef r2' -> Value.eq_ref r1' r2'
    | _, _ -> eq_ref' r1 r2

let () =
  let type_of_ref' = !Value.type_of_ref' in
  Value.type_of_ref' := function
    | ExternRef _ -> ExternHT
    | r -> type_of_ref' r

let () =
  let string_of_ref' = !Value.string_of_ref' in
  Value.string_of_ref' := function
    | ExternRef r -> "(extern " ^ string_of_ref r ^ ")"
    | r -> string_of_ref' r

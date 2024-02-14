open Types
open Value

type i31 = int
type t = i31

type ref_ += I31Ref of i31

let of_i32 i = Int32.to_int i land 0x7fff_ffff
let to_i32 ext i =
  let i' = Int32.of_int i in
  match ext with
  | Pack.ZX -> i'
  | Pack.SX -> Int32.(shift_right (shift_left i' 1) 1)

let () =
  let eq_ref' = !Value.eq_ref' in
  Value.eq_ref' := fun r1 r2 ->
    match r1, r2 with
    | I31Ref i1, I31Ref i2 -> i1 = i2
    | _, _ -> eq_ref' r1 r2

let () =
  let type_of_ref' = !Value.type_of_ref' in
  Value.type_of_ref' := function
    | I31Ref f -> I31HT
    | r -> type_of_ref' r

let () =
  let string_of_ref' = !Value.string_of_ref' in
  Value.string_of_ref' := function
    | I31Ref i -> "(i31 " ^ string_of_int i ^ ")"
    | r -> string_of_ref' r

open Types
open Value

type exn_ = Exn of Tag.t * value list

type ref_ += ExnRef of exn_

let alloc_exn tag vs =
  let TagT dt = Tag.type_of tag in
  assert Free.((def_type dt).types = Set.empty);
  let FuncT (ts1, ts2) = as_func_str_type (expand_def_type dt) in
  assert (List.length vs = List.length ts1);
  assert (ts2 = []);
  Exn (tag, vs)

let type_of_exn (Exn (tag, _)) =
  let TagT dt = Tag.type_of tag in
  dt

let () =
  let eq_ref' = !Value.eq_ref' in
  Value.eq_ref' := fun r1 r2 ->
    match r1, r2 with
    | ExnRef _, ExnRef _ -> failwith "eq_ref"
    | _, _ -> eq_ref' r1 r2

let () =
  let type_of_ref' = !Value.type_of_ref' in
  Value.type_of_ref' := function
    | ExnRef e -> DefHT (type_of_exn e)
    | r -> type_of_ref' r

let () =
  let string_of_ref' = !Value.string_of_ref' in
  Value.string_of_ref' := function
    | ExnRef (Exn (_tag, vs)) ->
      "(tag " ^ String.concat " " (List.map string_of_value vs) ^ ")"
    | r -> string_of_ref' r

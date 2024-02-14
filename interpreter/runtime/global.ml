open Types
open Value

type global = {ty : global_type; mutable content : value}
type t = global

exception Type
exception NotMutable

let alloc (GlobalT (_mut, t) as ty) v =
  assert Free.((val_type t).types = Set.empty);
  if not (Match.match_val_type [] (type_of_value v) t) then raise Type;
  {ty; content = v}

let type_of glob =
  glob.ty

let load glob =
  glob.content

let store glob v =
  let GlobalT (mut, t) = glob.ty in
  if mut <> Var then raise NotMutable;
  if not (Match.match_val_type [] (type_of_value v) t) then raise Type;
  glob.content <- v

open Types.Sem
open Value

type global = {ty : global_type; mutable content : value}
type t = global

exception Type
exception NotMutable

let alloc (`Global (_mut, t) as ty) v =
  if not (Match.Sem.match_val_type () [] (type_of_value v) t) then raise Type;
  {ty; content = v}

let type_of glob =
  glob.ty

let load glob =
  glob.content

let store glob v =
  let `Global (mut, t) = glob.ty in
  if mut <> `Var then raise NotMutable;
  if not (Match.Sem.match_val_type () [] (type_of_value v) t) then raise Type;
  glob.content <- v

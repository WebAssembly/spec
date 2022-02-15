open Types
open Value

type global = {ty : global_type; mutable content : value}
type t = global

exception Type
exception NotMutable

let alloc (GlobalType (t, _) as ty) v =
  if not (Match.match_value_type [] (type_of_value v) t) then raise Type;
  {ty; content = v}

let type_of glob =
  glob.ty

let load glob =
  glob.content

let store glob v =
  let GlobalType (t, mut) = glob.ty in
  if mut <> Mutable then raise NotMutable;
  if not (Match.match_value_type [] (type_of_value v) t) then raise Type;
  glob.content <- v

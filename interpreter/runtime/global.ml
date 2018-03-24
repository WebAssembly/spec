open Types
open Values

type global = {mutable content : value; ty : value_type; mut : mutability}
type t = global

exception Type
exception NotMutable

let alloc (GlobalType (ty, mut)) v =
  if not (match_value_type (type_of_value v) ty) then raise Type;
  {content = v; ty; mut}

let type_of glob = GlobalType (glob.ty, glob.mut)

let load glob = glob.content
let store glob v =
  if glob.mut <> Mutable then raise NotMutable;
  if not (match_value_type (type_of_value v) glob.ty) then raise Type;
  glob.content <- v

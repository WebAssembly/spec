open Types
open Values

type global = {mutable content : value; mut : mutability}
type t = global

exception NotMutable

let alloc (GlobalType (t, mut)) v =
  assert (type_of v = t);
  {content = v; mut = mut}

let type_of glob =
  GlobalType (type_of glob.content, glob.mut)

let load glob = glob.content
let store glob v =
  assert (Values.type_of v = Values.type_of glob.content);
  if glob.mut = Immutable then raise NotMutable;
  glob.content <- v

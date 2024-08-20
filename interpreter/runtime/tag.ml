open Types

type tag = {ty : tag_type}
type t = tag

let alloc ty =
   {ty}

let type_of tg =
  tg.ty

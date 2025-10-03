open Types

type tag = {ty : tagtype}
type t = tag

let alloc ty =
   {ty}

let type_of tg =
  tg.ty

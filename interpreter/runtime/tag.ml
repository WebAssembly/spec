open Types

type tag = {ty : func_type}
type t = tag

let alloc ty =
   {ty}

let type_of tg =
  tg.ty

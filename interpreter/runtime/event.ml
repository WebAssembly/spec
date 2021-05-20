open Types

type event = {ty : func_type}
type t = event

let alloc ty =
   {ty}

let type_of evt =
  evt.ty

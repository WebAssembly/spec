open Types
open Values

type size = int32
type index = int32

type table' = ref_ array
type table =
  {mutable content : table'; max : size option; elem_type : ref_type}
type t = table

exception Type
exception Bounds
exception SizeOverflow
exception SizeLimit
exception OutOfMemory

let within_limits size = function
  | None -> true
  | Some max -> I32.le_u size max

let create size r =
  try Lib.Array32.make size r
  with Out_of_memory | Invalid_argument _ -> raise OutOfMemory

let alloc (TableType ({min; max}, elem_type)) r =
  assert (within_limits min max);
  {content = create min r; max; elem_type}

let size tab =
  Lib.Array32.length tab.content

let type_of tab =
  TableType ({min = size tab; max = tab.max}, tab.elem_type)

let grow tab delta r =
  let old_size = size tab in
  let new_size = Int32.add old_size delta in
  if I32.gt_u old_size new_size then raise SizeOverflow else
  if not (within_limits new_size tab.max) then raise SizeLimit else
  let after = create new_size r in
  Array.blit tab.content 0 after 0 (Array.length tab.content);
  tab.content <- after

let load tab i =
  try Lib.Array32.get tab.content i with Invalid_argument _ -> raise Bounds

let store tab i r =
  if not (match_ref_type (type_of_ref r) tab.elem_type) then raise Type;
  try Lib.Array32.set tab.content i r with Invalid_argument _ -> raise Bounds

let blit tab offset rs =
  let data = Array.of_list rs in
  try Lib.Array32.blit data 0l tab.content offset (Lib.Array32.length data)
  with Invalid_argument _ -> raise Bounds

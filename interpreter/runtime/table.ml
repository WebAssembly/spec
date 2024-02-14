open Types
open Value

type size = int32
type index = int32
type count = int32

type table = {mutable ty : table_type; mutable content : ref_ array}
type t = table

exception Type
exception Bounds
exception SizeOverflow
exception SizeLimit
exception OutOfMemory

let valid_limits {min; max} =
  match max with
  | None -> true
  | Some m -> I32.le_u min m

let create size r =
  try Lib.Array32.make size r
  with Out_of_memory | Invalid_argument _ -> raise OutOfMemory

let alloc (TableT (lim, t) as ty) r =
  assert Free.((ref_type t).types = Set.empty);
  if not (valid_limits lim) then raise Type;
  {ty; content = create lim.min r}

let size tab =
  Lib.Array32.length tab.content

let type_of tab =
  tab.ty

let grow tab delta r =
  let TableT (lim, t) = tab.ty in
  assert (lim.min = size tab);
  let old_size = lim.min in
  let new_size = Int32.add old_size delta in
  if I32.gt_u old_size new_size then raise SizeOverflow else
  let lim' = {lim with min = new_size} in
  if not (valid_limits lim') then raise SizeLimit else
  let after = create new_size r in
  Array.blit tab.content 0 after 0 (Array.length tab.content);
  tab.ty <- TableT (lim', t);
  tab.content <- after

let load tab i =
  if i < 0l || i >= Lib.Array32.length tab.content then raise Bounds;
  Lib.Array32.get tab.content i

let store tab i r =
  let TableT (lim, t) = tab.ty in
  if not (Match.match_ref_type [] (type_of_ref r) t) then raise Type;
  if i < 0l || i >= Lib.Array32.length tab.content then raise Bounds;
  Lib.Array32.set tab.content i r

let blit tab offset rs =
  let data = Array.of_list rs in
  let len = Lib.Array32.length data in
  if offset < 0l || offset > Int32.sub (Lib.Array32.length tab.content) len then raise Bounds;
  Lib.Array32.blit data 0l tab.content offset len

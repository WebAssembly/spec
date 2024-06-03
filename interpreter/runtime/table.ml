open Types
open Value

type size = int64
type index = int64
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
  | Some m -> I64.le_u min m

let valid_index it i =
  match it with
  | I32IndexType -> I64.le_u i 0xffff_ffffL
  | I64IndexType -> true

let create size r =
  try Lib.Array64.make size r
  with Out_of_memory | Invalid_argument _ -> raise OutOfMemory

let alloc (TableT (lim, it, t) as ty) r =
  assert Free.((ref_type t).types = Set.empty);
  if not (valid_limits lim) then raise Type;
  {ty; content = create lim.min r}

let size tab =
  Lib.Array64.length tab.content

let type_of tab =
  tab.ty

let index_type_of tab =
  let (TableT (_, it, _)) = type_of tab in it

let index_of_num x =
  match x with
  | I64 i -> i
  | I32 i -> I64_convert.extend_i32_u i
  | _ -> raise Type

let grow tab delta r =
  let TableT (lim, it, t) = tab.ty in
  assert (lim.min = size tab);
  let old_size = lim.min in
  let new_size = Int64.add old_size delta in
  if I64.gt_u old_size new_size then raise SizeOverflow else
  let lim' = {lim with min = new_size} in
  if not (valid_index it new_size) then raise SizeOverflow else
  if not (valid_limits lim') then raise SizeLimit else
  let after = create new_size r in
  Array.blit tab.content 0 after 0 (Array.length tab.content);
  tab.ty <- TableT (lim', it, t);
  tab.content <- after

let load tab i =
  if i < 0L || i >= Lib.Array64.length tab.content then raise Bounds;
  Lib.Array64.get tab.content i

let store tab i r =
  let TableT (_lim, _it, t) = tab.ty in
  if not (Match.match_ref_type [] (type_of_ref r) t) then raise Type;
  if i < 0L || i >= Lib.Array64.length tab.content then raise Bounds;
  Lib.Array64.set tab.content i r

let blit tab offset rs =
  let data = Array.of_list rs in
  let len = Lib.Array64.length data in
  if offset < 0L || offset > Int64.sub (Lib.Array64.length tab.content) len then raise Bounds;
  Lib.Array64.blit data 0L tab.content offset len

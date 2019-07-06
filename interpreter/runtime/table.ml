open Types

type size = int32
type index = int32
type count = int32

type elem = ..
type elem += Uninitialized

type table' = elem array
type table =
  {mutable content : table'; max : size option; elem_type : elem_type}
type t = table

exception Bounds
exception SizeOverflow
exception SizeLimit

let within_limits size = function
  | None -> true
  | Some max -> I32.le_u size max

let create size =
  try Lib.Array32.make size Uninitialized
  with Invalid_argument _ -> raise Out_of_memory

let alloc (TableType ({min; max}, elem_type)) =
  assert (within_limits min max);
  {content = create min; max; elem_type}

let size tab =
  Lib.Array32.length tab.content

let type_of tab =
  TableType ({min = size tab; max = tab.max}, tab.elem_type)

let grow tab delta =
  let old_size = size tab in
  let new_size = Int32.add old_size delta in
  if I32.gt_u old_size new_size then raise SizeOverflow else
  if not (within_limits new_size tab.max) then raise SizeLimit else
  let after = create new_size in
  Array.blit tab.content 0 after 0 (Array.length tab.content);
  tab.content <- after

let load tab i =
  try Lib.Array32.get tab.content i with Invalid_argument _ -> raise Bounds

let store tab i v =
  try Lib.Array32.set tab.content i v with Invalid_argument _ -> raise Bounds

let init tab es d s n =
  let rec loop es d s n =
    match s, n, es with
    | s, 0l, _ -> ()
    | 0l, n, e::es' ->
      store tab d e;
      loop es' (Int32.add d 1l) 0l (Int32.sub n 1l)
    | s, n, _::es' -> loop es' d (Int32.sub s 1l) n
    | _ -> raise Bounds
  in loop es d s n

let copy tab d s n =
  let rec loop d s n dx =
    if I32.gt_u n 0l then begin
      store tab d (load tab s);
      loop (Int32.add d dx) (Int32.add s dx) (Int32.sub n 1l) dx
    end
  in (if s < d then
    loop Int32.(add d (sub n 1l)) Int32.(add s (sub n 1l)) n (-1l)
  else
    loop d s n 1l)

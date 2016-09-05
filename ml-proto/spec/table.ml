open Types
open Values

type size = int32
type index = int32

type elem = exn option
type elem_type = Types.elem_type
type 'a limits = 'a Types.limits

type table' = elem array
type table = {mutable content : table'; max : size option}
type t = table

exception Bounds
exception SizeOverflow
exception SizeLimit

(*
 * These limitations should be considered part of the host environment and not
 * part of the spec defined by this file.
 * ==========================================================================
 *)

let host_size_of_int32 n =
  if n < 0l || Int64.of_int32 n > Int64.of_int max_int then raise Out_of_memory;
  Int32.to_int n

let int32_of_host_size n =
  Int32.of_int n

let host_index_of_int32 i =
  if i < 0l || Int64.of_int32 i > Int64.of_int max_int then raise Bounds;
  Int32.to_int i

(* ========================================================================== *)

let within_limits size = function
  | None -> true
  | Some max -> I32.le_u size max

let create' size =
  Array.make (host_size_of_int32 size) None

let create {min; max} =
  assert (within_limits min max);
  {content = create' min; max}

let size tab =
  int32_of_host_size (Array.length tab.content)

let limits tab =
  {min = size tab; max = tab.max}

let grow tab delta =
  let old_size = size tab in
  let new_size = Int32.add old_size delta in
  if I32.gt_u old_size new_size then raise SizeOverflow else
  if not (within_limits new_size tab.max) then raise SizeLimit else
  let after = create' new_size in
  Array.blit tab.content 0 after 0 (Array.length tab.content);
  tab.content <- after

let load tab i t =
  assert (t = AnyFuncType);
  let j = host_index_of_int32 i in
  try tab.content.(j) with Invalid_argument _ -> raise Bounds

let store tab i v =
  let j = host_index_of_int32 i in
  try tab.content.(j) <- v with Invalid_argument _ -> raise Bounds

let blit tab offset elems =
  let data = Array.of_list elems in
  let base = host_index_of_int32 offset in
  try
    Array.blit data 0 tab.content base (Array.length data) 
  with Invalid_argument _ -> raise Bounds

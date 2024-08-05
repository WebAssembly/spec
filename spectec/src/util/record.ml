include List

let empty = []

let clone r =
  map (fun (k, v) -> (k, v)) r

let keys r =
  map (fun (k, _) -> k) r

let mem = mem_assoc

let size = length

let add k v r =
  if mem_assoc k r then
    let f (k', v') = if k = k' then k, ref v else k', v' in
    map f r
  else
    r @ [ k, ref v ]

let find s r =
  try assoc s r |> (!) with
  | _ -> failwith ("No field name\n")

let find_opt s r =
  assoc_opt s r |> Option.map (!)

let replace k v r =
  let ref = assoc k r in
  ref := v

let map fk fv =
  map (fun (k, v) -> k |> fk, !v |> fv |> ref)

let fold f r acc =
  fold_left (fun acc (k, v) -> f k !v acc) acc r

let filter f =
  filter (fun (k, v) -> f k !v)

let to_list r = r

let of_list r = r

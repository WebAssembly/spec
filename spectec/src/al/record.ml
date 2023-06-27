
(* Helper functions for record *)
module Record = struct include List
  (* Record is finite mapping whose key is string *)

  let empty = []

  let clone r =
    map (fun (k, v) -> (k, v)) r

  let keys r =
    map (fun (k, _) -> k) r |> sort String.compare
  
  let size = length

  let add k v r =
    if mem_assoc k r then
      let f (k', v') = if k = k' then k, ref v else k', v' in
      map f r
    else
      r @ [ k, ref v ]

  let find s r =
    try assoc s r |> (!) with
    | _ -> failwith ("No field name: " ^ s ^ "\n")

  let replace k v r =
    let ref = assoc k r in
    ref := v

  let map f =
    map (fun (k, v) -> k, !v |> f |> ref)

  let fold f r acc =
    fold_left (fun acc (k, v) -> f k !v acc) acc r

  let filter f =
    filter (fun (k, v) -> f k !v)

end

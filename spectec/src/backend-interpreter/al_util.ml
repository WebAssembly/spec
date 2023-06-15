
(* Helper functions for record *)
module Record = struct include List

  let empty = []

  let add k v r =
    if mem_assoc k r then
      let f (k', v') = if k = k' then k, ref v else k', v' in
      map f r
    else
      r @ [ k, ref v ]

  let find s r = assoc s r |> (!)

  let map f =
    map (fun (k, v) -> k, !v |> f |> ref)

  let fold f =
    fold_right (fun (k, v) acc -> f k !v acc)

  let filter f =
    filter (fun (k, v) -> f k !v)

end

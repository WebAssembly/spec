let page_size = 4096L

let has_feature = fun str -> match str with
  (* We always support this feature :-). *)
  | "wasm" -> true
  (* If we don't recognize a feature name, we don't support the feature. *)
  | _ -> false

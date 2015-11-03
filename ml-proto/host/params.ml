let page_size = 0x10000L (* 64 KiB *)

let has_feature = fun str -> match str with
  (* We always support this feature :-). *)
  | "wasm" -> true
  (* If we don't recognize a feature name, we don't support the feature. *)
  | _ -> false

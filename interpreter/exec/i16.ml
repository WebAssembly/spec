(* I16 for SIMD. Uses Int32 as the underlying storage. All int16 values will be
 * stored signed-extended. E.g. -1 will be stored with all high bits set.
 *)
include Int.Make (struct
  include Int32

  let bitwidth = 16

  let min_int = Int32.of_int (-32768)
  let max_int = Int32.of_int 32767
  (* TODO incorrect for negative values. *)
  let to_hex_string = Printf.sprintf "%lx"
end)

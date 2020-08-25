(* I16 for SIMD. Uses Int32 as the underlying storage. All int16 values will be
 * stored signed-extended. E.g. -1 will be stored with all high bits set.
 *)
include Int.Make (struct
  include Int32

  let bitwidth = 16
  let to_hex_string i =
    (* Always print the full 32-bits (8 hex characters), and pad with 0s.
     * Then only take the 4 least significant characters. *)
    let s = Printf.sprintf "%08lx" i in
    String.sub s ((String.length s) - 4) 4

  let of_int64 = Int64.to_int32
  let to_int64 = Int64.of_int32
end)

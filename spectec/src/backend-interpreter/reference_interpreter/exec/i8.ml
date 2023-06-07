(* Uses Int32 as the underlying storage. All int8 values will be
 * stored signed-extended. E.g. -1 will be stored with all high bits set.
 *)
include Ixx.Make (struct
  include Int32

  let bitwidth = 8
  let to_hex_string i = Printf.sprintf "%lx" (Int32.logand i 0xffl)

  let of_int64 = Int64.to_int32
  let to_int64 = Int64.of_int32
end)

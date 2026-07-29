(* Uses Int32 as the underlying storage. All int16 values will be
 * stored signed-extended. E.g. -1 will be stored with all high bits set.
 *)
include (Ixx.Make
  (struct
    let bitwidth = 16
    include Int
    let of_int = Fun.id
    let to_int = Fun.id
    let of_int64 = Int64.to_int
    let to_int64 = Int64.of_int
    let to_hex_string = Printf.sprintf "%x"
  end) : Ixx.T)

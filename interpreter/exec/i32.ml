(* WebAssembly-compatible i32 implementation *)

include Ixx.Make
  (struct
    include Int32
    let bitwidth = 32
    let to_hex_string = Printf.sprintf "%lx"

    let of_int64 = Int64.to_int32
    let to_int64 = Int64.of_int32
  end)

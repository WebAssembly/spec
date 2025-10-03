(* WebAssembly-compatible i32 implementation *)

include Ixx.Make
  (struct
    let bitwidth = 32
    include Int32
    let of_int64 = Int64.to_int32
    let to_int64 = Int64.of_int32
    let to_hex_string = Printf.sprintf "%lx"
  end)

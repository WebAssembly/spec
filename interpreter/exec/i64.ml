(* WebAssembly-compatible i64 implementation *)

include Ixx.Make
  (struct
    let bitwidth = 64
    include Int64
    let of_int64 = Fun.id
    let to_int64 = Fun.id
    let to_hex_string = Printf.sprintf "%Lx"
  end)

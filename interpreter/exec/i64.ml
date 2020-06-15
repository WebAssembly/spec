(* WebAssembly-compatible i64 implementation *)

include Int.Make
  (struct
    include Int64
    let bitwidth = 64
    let to_hex_string = Printf.sprintf "%Lx"
  end)

(* WebAssembly-compatible i64 implementation *)

include Int.Make
  (struct
    include Int64
    let bitwidth = 64
    let to_hex_string = Printf.sprintf "%Lx"
    let avgr_u x y = failwith "unimplemented i64x2.avgr_u"
  end)

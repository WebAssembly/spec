(* WebAssembly-compatible i64 implementation *)

include Int.Make
  (struct
    include Int64
    let bitwidth = 64
  end)

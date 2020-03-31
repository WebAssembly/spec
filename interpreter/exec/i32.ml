(* WebAssembly-compatible i32 implementation *)

include Ixx.Make
  (struct
    include Int32
    let bitwidth = 32
  end)

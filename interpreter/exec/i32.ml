(* WebAssembly-compatible i32 implementation *)

include Int.Make
  (struct
    include Int32
    let bitwidth = 32
    let to_hex_string = Printf.sprintf "%lx"

    let avgr_u x y =
      let open Int64 in
      let mask = of_int (-1) in
      let x64 = logand mask (of_int32 x) in
      let y64 = logand mask (of_int32 y) in
      to_int32 (div (add (add x64 y64) one) (of_int 2))
  end)

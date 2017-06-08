include Float.Make
  (struct
    include Int64
    let pos_nan = 0x7ff8000000000000L
    let neg_nan = 0xfff8000000000000L
    let bare_nan = 0x7ff0000000000000L
    let to_hex_string = Printf.sprintf "%Lx"
  end)

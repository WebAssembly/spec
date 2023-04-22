include Fxx.Make
  (struct
    include Int64
    let mantissa = 52
    let pos_nan = 0x7ff8_0000_0000_0000L
    let neg_nan = 0xfff8_0000_0000_0000L
    let bare_nan = 0x7ff0_0000_0000_0000L
    let to_hex_string = Printf.sprintf "%Lx"
  end)

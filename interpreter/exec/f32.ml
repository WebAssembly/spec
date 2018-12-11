(*
 * OCaml lacks 32-bit floats, however we can emulate all the basic operations
 * using 64-bit floats, as described in the paper
 * "When is double rounding innocuous?" by Samuel A. Figueroa.
 *)
include Float.Make
  (struct
    include Int32
    let pos_nan = 0x7fc00000l
    let neg_nan = 0xffc00000l
    let bare_nan = 0x7f800000l
    let to_hex_string = Printf.sprintf "%lx"
  end)

(* I16 for SIMD. Uses Int32 as the underlying storage. All int16 values will be
 * stored signed-extended. E.g. -1 will be stored with all high bits set.
 *)
include Int.Make (struct
  include Int32

  let bitwidth = 16

  (* TODO incorrect for negative values. *)
  let to_hex_string = Printf.sprintf "%lx"

  let avgr_u x y =
    (* Mask top bits to treat the value as unsigned. *)
    let mask = Int32.of_int 0xffff in
    let x_u16 = logand mask x in
    let y_u16 = logand mask y in
    Int32.div (Int32.add (Int32.add x_u16 y_u16) one) (Int32.of_int 2)
end)

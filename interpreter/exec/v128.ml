include Simd.Make
  (struct
    include Bytes
    let bytewidth = 16

    (* Constructs v128 of a certain shape from a list of strings. Does not do any validation,
     * as that is done in the parser. *)
    let of_strings shape ss =
      let open Bytes in
      let b = create bytewidth in
      (match shape with
      | Simd.I8x16 ->
        List.iteri (fun i s -> set_uint8 b i (Int32.to_int (I32.of_string s))) ss
      | Simd.I16x8 ->
        List.iteri (fun i s -> set_uint16_le b i (Int32.to_int (I32.of_string s))) ss
      | Simd.I32x4 ->
        List.iteri (fun i s -> set_int32_le b i (I32.of_string s)) ss
      | Simd.I64x2 ->
        List.iteri (fun i s -> set_int64_le b i (I64.of_string s)) ss
      | Simd.F32x4 ->
        List.iteri (fun i s -> set_int32_le b i (F32.to_bits (F32.of_string s))) ss
      | Simd.F64x2 ->
        List.iteri (fun i s -> set_int64_le b i (F64.to_bits (F64.of_string s))) ss);
      b
  end)

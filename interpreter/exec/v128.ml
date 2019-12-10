include Simd.Make
  (struct
    include Bytes
    let bytewidth = 16

    let of_strings shape ss =
      if List.length ss <> Simd.lanes shape then raise (Invalid_argument "wrong length");
      let range_check i32 min max at =
        let i = Int32.to_int i32 in
        if i > max || i < min then raise (Failure "constant out of range") else i in
      (* TODO create proper I8 and I16 modules *)
      let i8_of_string s = range_check (I32.of_string s) (-128) 255 s in
      let i16_of_string s = range_check (I32.of_string s) (-32768) 65535 s in
      let open Bytes in
      let b = create bytewidth in
      (match shape with
      | Simd.I8x16 ->
        List.iteri (fun i s -> set_uint8 b i (i8_of_string s)) ss
      | Simd.I16x8 ->
        List.iteri (fun i s -> set_uint16_le b i (i16_of_string s)) ss
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

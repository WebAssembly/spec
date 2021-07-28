(* TODO
- inline Simd functor
- unify shape and packed num types for simd & memory
*)

include Simd.Make
  (struct
    include String
    let bytewidth = 16

    let to_i8x16 s =
      List.init 16 (fun i -> (Int32.of_int (Bytes.get_int8 (Bytes.of_string s) i)))

    let of_i8x16 fs =
      let b = Bytes.create bytewidth in
      List.iteri (fun i f -> Bytes.set_int8 b i (Int32.to_int f)) fs;
      Bytes.to_string b

    let to_i16x8 s =
      List.init 8 (fun i -> Int32.of_int (Bytes.get_int16_le (Bytes.of_string s) (i*2)))

    let of_i16x8 fs =
      let b = Bytes.create bytewidth in
      List.iteri (fun i f -> Bytes.set_int16_le b (i*2) (Int32.to_int f)) fs;
      Bytes.to_string b

    let to_i32x4 s =
      List.init 4 (fun i -> I32.of_bits (Bytes.get_int32_le (Bytes.of_string s) (i*4)))

    let of_i32x4 fs =
      let b = Bytes.create bytewidth in
      List.iteri (fun i f -> Bytes.set_int32_le b (i*4) (I32.to_bits f)) fs;
      Bytes.to_string b

    let to_i64x2 s =
      List.init 2 (fun i -> I64.of_bits (Bytes.get_int64_le (Bytes.of_string s) (i*8)))

    let of_i64x2 fs =
      let b = Bytes.create bytewidth in
      List.iteri (fun i f -> Bytes.set_int64_le b (i*8) (I64.to_bits f)) fs;
      Bytes.to_string b

    let to_f32x4 s =
      List.init 4 (fun i -> F32.of_bits (Bytes.get_int32_le (Bytes.of_string s) (i*4)))

    let of_f32x4 fs =
      let b = Bytes.create bytewidth in
      List.iteri (fun i f -> Bytes.set_int32_le b (i*4) (F32.to_bits f)) fs;
      Bytes.to_string b

    let to_f64x2 s =
      List.init 2 (fun i -> F64.of_bits (Bytes.get_int64_le (Bytes.of_string s) (i*8)))

    let of_f64x2 fs =
      let b = Bytes.create bytewidth in
      List.iteri (fun i f -> Bytes.set_int64_le b (i*8) (F64.to_bits f)) fs;
      Bytes.to_string b

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
        List.iteri (fun i s -> set_int16_le b (i * 2) (i16_of_string s)) ss
      | Simd.I32x4 ->
        List.iteri (fun i s -> set_int32_le b (i * 4) (I32.of_string s)) ss
      | Simd.I64x2 ->
        List.iteri (fun i s -> set_int64_le b (i * 8) (I64.of_string s)) ss
      | Simd.F32x4 ->
        List.iteri (fun i s -> set_int32_le b (i * 4) (F32.to_bits (F32.of_string s))) ss
      | Simd.F64x2 ->
        List.iteri (fun i s -> set_int64_le b (i * 8) (F64.to_bits (F64.of_string s))) ss);
      Bytes.to_string b

    (* This is needed for generating text format. In the text format, we can specify a shape,
     * like "v128.const i8x16", but the binary format does not keep the shape, so we have to
     * pick one when converting to text. Arbitrary pick i32x4, and make sure to be consistent.
     *)
    let to_string s =
      let i32x4 = to_i32x4 s in
      String.concat " " (List.map I32.to_string_s i32x4)
    let to_hex_string s =
      let i32x4 = to_i32x4 s in
      String.concat " " (List.map I32.to_hex_string i32x4)
  end)

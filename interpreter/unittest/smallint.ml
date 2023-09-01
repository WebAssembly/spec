(* Simple, non-exhaustive tests for small ints (i8, i16). *)

let s32max = 0x7fffffffl
let s32min = 0x80000000l
let u32max = 0xffffffffl
let u32min = 0l

(* Smaller ints are stored sign extended in an Int32. *)
let s16max = 32767l
let s16min = -32768l
let u16max = u32max
let u16min = 0l

let s8max = 127l
let s8min = -128l
let u8max = u32max
let u8min = 0l

let assert_equal x y =
  if x <> y then raise (Failure
  (Printf.sprintf "Expected: %ld, but got %ld." x y))

let () =
  (* test addition wrap around *)
  assert_equal u32min (I32.add u32max 1l);
  assert_equal u16min (I16.add u16max 1l);
  assert_equal u8min (I8.add u8max 1l);
  assert_equal s32min (I32.add s32max 1l);
  assert_equal s16min (I16.add s16max 1l);
  assert_equal s8min (I8.add s8max 1l);

  (* test subtraction wrap around *)
  assert_equal u32max (I32.sub u32min 1l);
  assert_equal u16max (I16.sub u16min 1l);
  assert_equal u8max (I8.sub u8min 1l);
  assert_equal s32max (I32.sub s32min 1l);
  assert_equal s16max (I16.sub s16min 1l);
  assert_equal s8max (I8.sub s8min 1l);

  (* test mul wrap around *)
  assert_equal 1l (I32.mul u32max u32max);
  assert_equal 1l (I16.mul u16max u16max);
  assert_equal 1l (I8.mul u8max u8max);
  assert_equal 1l (I32.mul s32max s32max);
  assert_equal 1l (I16.mul s16max s16max);
  assert_equal 1l (I8.mul s8max s8max);

  (* test add_sat_s *)
  assert_equal s16max (I16.add_sat_s s16max 1l);
  assert_equal s8max (I8.add_sat_s s8max 1l);
  assert_equal u16max (I16.add_sat_u u16max 1l);
  assert_equal u8max (I8.add_sat_u u8max 1l);

  (* test sub_sat_s *)
  assert_equal s16min (I16.sub_sat_s s16min 1l);
  assert_equal s8min (I8.sub_sat_s s8min 1l);
  assert_equal 0l (I16.sub_sat_u 0l 1l);
  assert_equal 0l (I8.sub_sat_u 0l 1l);

  (* test div wrap around *)
  try
    ignore (I32.div_s s32min (-1l));
    ignore (I16.div_s s16min (-1l));
    ignore (I8.div_s s8min (-1l));
    assert false
  with Ixx.Overflow ->
    ();

  (* test shifts overflow *)
  assert_equal s16min (I16.shl 16384l 1l);
  assert_equal s8min (I8.shl 64l 1l);
  assert_equal 0x7fffl (I16.shr_u u16max 1l);
  assert_equal 0x7fl (I8.shr_u u8max 1l);
  (* check that the top bits are not messed with *)
  assert_equal u16max (I16.shr_u u16max 0l);
  assert_equal u8max (I8.shr_u u8max 0l);

  (* check rotation *)
  assert_equal 1l (I16.rotl s16min 1l);
  assert_equal 1l (I8.rotl s8min 1l);
  assert_equal s16min (I16.rotl 0x4000l 1l);
  assert_equal s8min (I8.rotl 0x40l 1l);

  assert_equal s32min (I32.rotr 1l 1l);
  assert_equal s16min (I16.rotr 1l 1l);
  assert_equal s8min (I8.rotr 1l 1l);

  assert_equal 1l (I32.rotr s32min 31l);
  assert_equal 1l (I16.rotr s16min 15l);
  assert_equal 1l (I8.rotr s8min 7l);
  assert_equal 0x40000000l (I32.rotr s32min 1l);
  assert_equal 0x4000l (I16.rotr s16min 1l);
  assert_equal 0x40l (I8.rotr s8min 1l);

  (* check clz *)
  assert_equal 0l (I16.clz s16min);
  assert_equal 0l (I8.clz s8min);
  assert_equal 1l (I16.clz s16max);
  assert_equal 1l (I8.clz s8max);

  (* check popcnt *)
  assert_equal 1l (I32.popcnt s32min);
  assert_equal 1l (I16.popcnt s16min);
  assert_equal 1l (I8.popcnt s8min);
  assert_equal 16l (I16.popcnt (-1l));
  assert_equal 8l (I8.popcnt (-1l));
  assert_equal 15l (I16.popcnt s16max);
  assert_equal 7l (I8.popcnt s8max);

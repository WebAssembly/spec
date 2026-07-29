(* Simple, non-exhaustive tests for small ints (i8, i16). *)

let s32max = 0x7fffffffl
let s32min = 0x80000000l
let u32max = 0xffffffffl
let u32min = 0l

(* Smaller ints are stored sign extended in an Int32. *)
let s16max = I16.of_int_s 0x7fff
let s16min = I16.of_int_s (-0x8000)
let u16max = I16.of_int_u 0xffff
let u16min = I16.of_int_u 0
let s16mone = I16.of_int_s (-1)
let u16one = I16.of_int_u 1

let s8max = I8.of_int_s 0x7f
let s8min = I8.of_int_u (-0x80)
let u8max = I8.of_int_u 0xff
let u8min = I8.of_int_u 0
let s8mone = I8.of_int_s (-1)
let u8one = I8.of_int_u 1

let str32 = Printf.sprintf "%lx"
let str16 = I16.to_hex_string
let str8 = I8.to_hex_string

let _ = Printexc.record_backtrace true
let assert_equal str i j =
  if i <> j then
    raise (Failure
      (Printf.sprintf "expected %s, but got %s" (str i) (str j)))

let assert_equal32 = assert_equal str32
let assert_equal16 = assert_equal str16
let assert_equal8 = assert_equal str8

let () =
  (* test addition wrap around *)
  assert_equal32 u32min (I32.add u32max 1l);
  assert_equal16 u16min (I16.add u16max u16one);
  assert_equal8 u8min (I8.add u8max u8one);
  assert_equal32 s32min (I32.add s32max 1l);
  assert_equal16 s16min (I16.add s16max u16one);
  assert_equal8 s8min (I8.add s8max u8one);

  (* test subtraction wrap around *)
  assert_equal32 u32max (I32.sub u32min 1l);
  assert_equal16 u16max (I16.sub u16min u16one);
  assert_equal8 u8max (I8.sub u8min u8one);
  assert_equal32 s32max (I32.sub s32min 1l);
  assert_equal16 s16max (I16.sub s16min u16one);
  assert_equal8 s8max (I8.sub s8min u8one);

  (* test mul wrap around *)
  assert_equal32 1l (I32.mul u32max u32max);
  assert_equal16 u16one (I16.mul u16max u16max);
  assert_equal8 u8one (I8.mul u8max u8max);
  assert_equal32 1l (I32.mul s32max s32max);
  assert_equal16 u16one (I16.mul s16max s16max);
  assert_equal8 u8one (I8.mul s8max s8max);

  (* test add_sat_s *)
  assert_equal16 s16max (I16.add_sat_s s16max u16one);
  assert_equal8 s8max (I8.add_sat_s s8max u8one);
  assert_equal16 u16max (I16.add_sat_u u16max u16one);
  assert_equal8 u8max (I8.add_sat_u u8max u8one);

  (* test sub_sat_s *)
  assert_equal16 s16min (I16.sub_sat_s s16min u16one);
  assert_equal8 s8min (I8.sub_sat_s s8min u8one);
  assert_equal16 u16min (I16.sub_sat_u u16min u16one);
  assert_equal8 u8min (I8.sub_sat_u u8min u8one);

  (* test div wrap around *)
  try
    ignore (I32.div_s s32min (-1l));
    ignore (I16.div_s s16min s16mone);
    ignore (I8.div_s s8min s8mone);
    assert false
  with Ixx.Overflow ->
    ();

  (* test shifts overflow *)
  assert_equal16 s16min (I16.shl (I16.of_int_u 16384) u16one);
  assert_equal8 s8min (I8.shl (I8.of_int_u 64) u8one);
  assert_equal16 (I16.of_int_u 0x7fff) (I16.shr_u u16max u16one);
  assert_equal8 (I8.of_int_u 0x7f) (I8.shr_u u8max u8one);
  (* check that the top bits are not messed with *)
  assert_equal16 u16max (I16.shr_u u16max u16min);
  assert_equal8 u8max (I8.shr_u u8max u8min);

  (* check rotation *)
  assert_equal16 u16one (I16.rotl s16min u16one);
  assert_equal8 u8one (I8.rotl s8min u8one);
  assert_equal16 s16min (I16.rotl (I16.of_int_u 0x4000) u16one);
  assert_equal8 s8min (I8.rotl (I8.of_int_u 0x40) u8one);

  assert_equal32 s32min (I32.rotr 1l 1l);
  assert_equal16 s16min (I16.rotr u16one u16one);
  assert_equal8 s8min (I8.rotr u8one u8one);

  assert_equal32 1l (I32.rotr s32min 31l);
  assert_equal16 u16one (I16.rotr s16min (I16.of_int_u 15));
  assert_equal8 u8one (I8.rotr s8min (I8.of_int_u 7));
  assert_equal32 0x40000000l (I32.rotr s32min 1l);
  assert_equal16 (I16.of_int_u 0x4000) (I16.rotr s16min u16one);
  assert_equal8 (I8.of_int_u 0x40) (I8.rotr s8min u8one);

  (* check clz *)
  assert_equal16 u16min (I16.clz s16min);
  assert_equal8 u8min (I8.clz s8min);
  assert_equal16 u16one (I16.clz s16max);
  assert_equal8 u8one (I8.clz s8max);

  (* check popcnt *)
  assert_equal32 1l (I32.popcnt s32min);
  assert_equal16 u16one (I16.popcnt s16min);
  assert_equal8 u8one (I8.popcnt s8min);
  assert_equal16 (I16.of_int_u 16) (I16.popcnt s16mone);
  assert_equal8 (I8.of_int_u 8) (I8.popcnt s8mone);
  assert_equal16 (I16.of_int_u 15) (I16.popcnt s16max);
  assert_equal8 (I8.of_int_u 7) (I8.popcnt s8max);

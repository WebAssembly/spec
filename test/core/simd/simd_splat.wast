(module
  (func (export "i8x16.splat") (param i32) (result v128) (i8x16.splat (local.get 0)))
  (func (export "i16x8.splat") (param i32) (result v128) (i16x8.splat (local.get 0)))
  (func (export "i32x4.splat") (param i32) (result v128) (i32x4.splat (local.get 0)))
  (func (export "f32x4.splat") (param f32) (result v128) (f32x4.splat (local.get 0)))
)

(assert_return (invoke "i8x16.splat" (i32.const 0)) (v128.const i8x16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
(assert_return (invoke "i8x16.splat" (i32.const 5)) (v128.const i8x16 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5))
(assert_return (invoke "i8x16.splat" (i32.const -5)) (v128.const i8x16 -5 -5 -5 -5 -5 -5 -5 -5 -5 -5 -5 -5 -5 -5 -5 -5))
(assert_return (invoke "i8x16.splat" (i32.const 257)) (v128.const i8x16 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(assert_return (invoke "i8x16.splat" (i32.const 0xff)) (v128.const i8x16 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1))
(assert_return (invoke "i8x16.splat" (i32.const -128)) (v128.const i8x16 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128))
(assert_return (invoke "i8x16.splat" (i32.const 127)) (v128.const i8x16 127 127 127 127 127 127 127 127 127 127 127 127 127 127 127 127))
(assert_return (invoke "i8x16.splat" (i32.const -129)) (v128.const i8x16 127 127 127 127 127 127 127 127 127 127 127 127 127 127 127 127))
(assert_return (invoke "i8x16.splat" (i32.const 128)) (v128.const i8x16 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128))
(assert_return (invoke "i8x16.splat" (i32.const 0xff7f)) (v128.const i8x16 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f))
(assert_return (invoke "i8x16.splat" (i32.const 0x80)) (v128.const i8x16 0x80 0x80 0x80 0x80 0x80 0x80 0x80 0x80 0x80 0x80 0x80 0x80 0x80 0x80 0x80 0x80))
(assert_return (invoke "i8x16.splat" (i32.const 0xAB)) (v128.const i32x4 0xABABABAB 0xABABABAB 0xABABABAB 0xABABABAB))

(assert_return (invoke "i16x8.splat" (i32.const 0)) (v128.const i16x8 0 0 0 0 0 0 0 0))
(assert_return (invoke "i16x8.splat" (i32.const 5)) (v128.const i16x8 5 5 5 5 5 5 5 5))
(assert_return (invoke "i16x8.splat" (i32.const -5)) (v128.const i16x8 -5 -5 -5 -5 -5 -5 -5 -5))
(assert_return (invoke "i16x8.splat" (i32.const 65537)) (v128.const i16x8 1 1 1 1 1 1 1 1))
(assert_return (invoke "i16x8.splat" (i32.const 0xffff)) (v128.const i16x8 -1 -1 -1 -1 -1 -1 -1 -1))
(assert_return (invoke "i16x8.splat" (i32.const -32768)) (v128.const i16x8 -32768 -32768 -32768 -32768 -32768 -32768 -32768 -32768))
(assert_return (invoke "i16x8.splat" (i32.const 32767)) (v128.const i16x8 32767 32767 32767 32767 32767 32767 32767 32767))
(assert_return (invoke "i16x8.splat" (i32.const -32769)) (v128.const i16x8 32767 32767 32767 32767 32767 32767 32767 32767))
(assert_return (invoke "i16x8.splat" (i32.const 32768)) (v128.const i16x8 -32768 -32768 -32768 -32768 -32768 -32768 -32768 -32768))
(assert_return (invoke "i16x8.splat" (i32.const 0xffff7fff)) (v128.const i16x8 0x7fff 0x7fff 0x7fff 0x7fff 0x7fff 0x7fff 0x7fff 0x7fff))
(assert_return (invoke "i16x8.splat" (i32.const 0x8000)) (v128.const i16x8 0x8000 0x8000 0x8000 0x8000 0x8000 0x8000 0x8000 0x8000))
(assert_return (invoke "i16x8.splat" (i32.const 0xABCD)) (v128.const i32x4 0xABCDABCD 0xABCDABCD 0xABCDABCD 0xABCDABCD))

(assert_return (invoke "i32x4.splat" (i32.const 0)) (v128.const i32x4 0 0 0 0))
(assert_return (invoke "i32x4.splat" (i32.const 5)) (v128.const i32x4 5 5 5 5))
(assert_return (invoke "i32x4.splat" (i32.const -5)) (v128.const i32x4 -5 -5 -5 -5))
(assert_return (invoke "i32x4.splat" (i32.const 0xffffffff)) (v128.const i32x4 -1 -1 -1 -1))
(assert_return (invoke "i32x4.splat" (i32.const 4294967295)) (v128.const i32x4 -1 -1 -1 -1))
(assert_return (invoke "i32x4.splat" (i32.const -2147483648)) (v128.const i32x4 0x80000000 0x80000000 0x80000000 0x80000000))
(assert_return (invoke "i32x4.splat" (i32.const 2147483647)) (v128.const i32x4 0x7fffffff 0x7fffffff 0x7fffffff 0x7fffffff))
(assert_return (invoke "i32x4.splat" (i32.const 2147483648)) (v128.const i32x4 0x80000000 0x80000000 0x80000000 0x80000000))

(assert_return (invoke "f32x4.splat" (f32.const 0.0)) (v128.const f32x4 0.0 0.0 0.0 0.0))
(assert_return (invoke "f32x4.splat" (f32.const 1.1)) (v128.const f32x4 1.1 1.1 1.1 1.1))
(assert_return (invoke "f32x4.splat" (f32.const -1.1)) (v128.const f32x4 -1.1 -1.1 -1.1 -1.1))
(assert_return (invoke "f32x4.splat" (f32.const 1e38)) (v128.const f32x4 1e38 1e38 1e38 1e38))
(assert_return (invoke "f32x4.splat" (f32.const -1e38)) (v128.const f32x4 -1e38 -1e38 -1e38 -1e38))
(assert_return (invoke "f32x4.splat" (f32.const 0x1.fffffep127)) (v128.const f32x4 0x1.fffffep127 0x1.fffffep127 0x1.fffffep127 0x1.fffffep127))
(assert_return (invoke "f32x4.splat" (f32.const -0x1.fffffep127)) (v128.const f32x4 -0x1.fffffep127 -0x1.fffffep127 -0x1.fffffep127 -0x1.fffffep127))
(assert_return (invoke "f32x4.splat" (f32.const 0x1p127)) (v128.const f32x4 0x1p127 0x1p127 0x1p127 0x1p127))
(assert_return (invoke "f32x4.splat" (f32.const -0x1p127)) (v128.const f32x4 -0x1p127 -0x1p127 -0x1p127 -0x1p127))
(assert_return (invoke "f32x4.splat" (f32.const inf)) (v128.const f32x4 inf inf inf inf))
(assert_return (invoke "f32x4.splat" (f32.const -inf)) (v128.const f32x4 -inf -inf -inf -inf))
(assert_return (invoke "f32x4.splat" (f32.const nan)) (v128.const f32x4 nan nan nan nan))
(assert_return (invoke "f32x4.splat" (f32.const nan:0x1)) (v128.const f32x4 nan:0x1 nan:0x1 nan:0x1 nan:0x1))
(assert_return (invoke "f32x4.splat" (f32.const nan:0x7f_ffff)) (v128.const f32x4 nan:0x7f_ffff nan:0x7f_ffff nan:0x7f_ffff nan:0x7f_ffff))


;; Unknown operator

(assert_malformed (module quote "(func (result v128) (v128.splat (i32.const 0)))") "unknown operator")


;; Type mismatched

(assert_invalid (module (func (result v128) i8x16.splat (i64.const 0))) "type mismatch")
(assert_invalid (module (func (result v128) i8x16.splat (f32.const 0.0))) "type mismatch")
(assert_invalid (module (func (result v128) i8x16.splat (f64.const 0.0))) "type mismatch")
(assert_invalid (module (func (result v128) i16x8.splat (i64.const 1))) "type mismatch")
(assert_invalid (module (func (result v128) i16x8.splat (f32.const 1.0))) "type mismatch")
(assert_invalid (module (func (result v128) i16x8.splat (f64.const 1.0))) "type mismatch")
(assert_invalid (module (func (result v128) i32x4.splat (i64.const 2))) "type mismatch")
(assert_invalid (module (func (result v128) i32x4.splat (f32.const 2.0))) "type mismatch")
(assert_invalid (module (func (result v128) i32x4.splat (f64.const 2.0))) "type mismatch")
(assert_invalid (module (func (result v128) f32x4.splat (i32.const 4))) "type mismatch")
(assert_invalid (module (func (result v128) f32x4.splat (i64.const 4))) "type mismatch")
(assert_invalid (module (func (result v128) f32x4.splat (f64.const 4.0))) "type mismatch")


;; V128 splat operators as the argument of other SIMD instructions

;; v128.store
(module (memory 1)
  (func (export "as-v128_store-value-1") (param i32) (result v128)
    (v128.store (i32.const 0) (i8x16.splat (local.get 0)))
    (v128.load (i32.const 0)))
  (func (export "as-v128_store-value-2") (param i32) (result v128)
    (v128.store (i32.const 0) (i16x8.splat (local.get 0)))
    (v128.load (i32.const 0)))
  (func (export "as-v128_store-value-3") (param i32) (result v128)
    (v128.store (i32.const 0) (i32x4.splat (local.get 0)))
    (v128.load (i32.const 0)))
)
(assert_return (invoke "as-v128_store-value-1" (i32.const 1)) (v128.const i8x16 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
(assert_return (invoke "as-v128_store-value-2" (i32.const 256)) (v128.const i16x8 0x100 0x100 0x100 0x100 0x100 0x100 0x100 0x100))
(assert_return (invoke "as-v128_store-value-3" (i32.const 0xffffffff)) (v128.const i32x4 -1 -1 -1 -1))

(module
  ;; Accessing lane
  (func (export "as-i8x16_extract_lane_s-operand-first") (param i32) (result i32)
    (i8x16.extract_lane_s 0 (i8x16.splat (local.get 0))))
  (func (export "as-i8x16_extract_lane_s-operand-last") (param i32) (result i32)
    (i8x16.extract_lane_s 15 (i8x16.splat (local.get 0))))
  (func (export "as-i16x8_extract_lane_s-operand-first") (param i32) (result i32)
    (i16x8.extract_lane_s 0 (i16x8.splat (local.get 0))))
  (func (export "as-i16x8_extract_lane_s-operand-last") (param i32) (result i32)
    (i16x8.extract_lane_s 7 (i16x8.splat (local.get 0))))
  (func (export "as-i32x4_extract_lane_s-operand-first") (param i32) (result i32)
    (i32x4.extract_lane 0 (i32x4.splat (local.get 0))))
  (func (export "as-i32x4_extract_lane_s-operand-last") (param i32) (result i32)
    (i32x4.extract_lane 3 (i32x4.splat (local.get 0))))
  (func (export "as-f32x4_extract_lane_s-operand-first") (param f32) (result f32)
    (f32x4.extract_lane 0 (f32x4.splat (local.get 0))))
  (func (export "as-f32x4_extract_lane_s-operand-last") (param f32) (result f32)
    (f32x4.extract_lane 3 (f32x4.splat (local.get 0))))
  (func (export "as-v8x16_swizzle-operands") (param i32) (param i32) (result v128)
    (v8x16.swizzle (i8x16.splat (local.get 0)) (i8x16.splat (local.get 1))))

  ;; Integer arithmetic
  (func (export "as-i8x16_add_sub_mul-operands") (param i32 i32 i32 i32) (result v128)
    (i8x16.add (i8x16.splat (local.get 0))
      (i8x16.sub (i8x16.splat (local.get 1))
        (i8x16.mul (i8x16.splat (local.get 2)) (i8x16.splat (local.get 3))))))
  (func (export "as-i16x8_add_sub_mul-operands") (param i32 i32 i32 i32) (result v128)
    (i16x8.add (i16x8.splat (local.get 0))
      (i16x8.sub (i16x8.splat (local.get 1))
        (i16x8.mul (i16x8.splat (local.get 2)) (i16x8.splat (local.get 3))))))
  (func (export "as-i32x4_add_sub_mul-operands") (param i32 i32 i32 i32) (result v128)
    (i32x4.add (i32x4.splat (local.get 0))
      (i32x4.sub (i32x4.splat (local.get 1))
        (i32x4.mul (i32x4.splat (local.get 2)) (i32x4.splat (local.get 3))))))

  ;; Saturating integer arithmetic
  (func (export "as-i8x16_add_saturate_s-operands") (param i32 i32) (result v128)
    (i8x16.add_saturate_s (i8x16.splat (local.get 0)) (i8x16.splat (local.get 1))))
  (func (export "as-i16x8_add_saturate_s-operands") (param i32 i32) (result v128)
    (i16x8.add_saturate_s (i16x8.splat (local.get 0)) (i16x8.splat (local.get 1))))
  (func (export "as-i8x16_sub_saturate_u-operands") (param i32 i32) (result v128)
    (i8x16.sub_saturate_u (i8x16.splat (local.get 0)) (i8x16.splat (local.get 1))))
  (func (export "as-i16x8_sub_saturate_u-operands") (param i32 i32) (result v128)
    (i16x8.sub_saturate_u (i16x8.splat (local.get 0)) (i16x8.splat (local.get 1))))
  
  ;; Bit shifts
  (func (export "as-i8x16_shr_s-operand") (param i32 i32) (result v128)
    (i8x16.shr_s (i8x16.splat (local.get 0)) (local.get 1)))
  (func (export "as-i16x8_shr_s-operand") (param i32 i32) (result v128)
    (i16x8.shr_s (i16x8.splat (local.get 0)) (local.get 1)))
  (func (export "as-i32x4_shr_s-operand") (param i32 i32) (result v128)
    (i32x4.shr_s (i32x4.splat (local.get 0)) (local.get 1)))

  ;; Bitwise operantions
  (func (export "as-v128_and-operands") (param i32 i32) (result v128)
    (v128.and (i8x16.splat (local.get 0)) (i8x16.splat (local.get 1))))
  (func (export "as-v128_or-operands") (param i32 i32) (result v128)
    (v128.or (i16x8.splat (local.get 0)) (i16x8.splat (local.get 1))))
  (func (export "as-v128_xor-operands") (param i32 i32) (result v128)
    (v128.xor (i32x4.splat (local.get 0)) (i32x4.splat (local.get 1))))

  ;; Boolean horizontal reductions
  (func (export "as-i8x16_all_true-operand") (param i32) (result i32)
    (i8x16.all_true (i8x16.splat (local.get 0))))
  (func (export "as-i16x8_all_true-operand") (param i32) (result i32)
    (i16x8.all_true (i16x8.splat (local.get 0))))
  (func (export "as-i32x4_all_true-operand") (param i32) (result i32)
    (i32x4.all_true (i32x4.splat (local.get 0))))

  ;; Comparisons
  (func (export "as-i8x16_eq-operands") (param i32 i32) (result v128)
    (i8x16.eq (i8x16.splat (local.get 0)) (i8x16.splat (local.get 1))))
  (func (export "as-i16x8_eq-operands") (param i32 i32) (result v128)
    (i16x8.eq (i16x8.splat (local.get 0)) (i16x8.splat (local.get 1))))
  (func (export "as-i32x4_eq-operands") (param i32 i32) (result v128)
    (i32x4.eq (i32x4.splat (local.get 0)) (i32x4.splat (local.get 1))))
  (func (export "as-f32x4_eq-operands") (param f32 f32) (result v128)
    (f32x4.eq (f32x4.splat (local.get 0)) (f32x4.splat (local.get 1))))

  ;; Floating-point sign bit operations
  (func (export "as-f32x4_abs-operand") (param f32) (result v128)
    (f32x4.abs (f32x4.splat (local.get 0))))

  ;; Floating-point min
  (func (export "as-f32x4_min-operands") (param f32 f32) (result v128)
    (f32x4.min (f32x4.splat (local.get 0)) (f32x4.splat (local.get 1))))

  ;; Floating-point arithmetic
  (func (export "as-f32x4_div-operands") (param f32 f32) (result v128)
    (f32x4.div (f32x4.splat (local.get 0)) (f32x4.splat (local.get 1))))

  ;; Conversions
  (func (export "as-f32x4_convert_s_i32x4-operand") (param i32) (result v128)
    (f32x4.convert_i32x4_s (i32x4.splat (local.get 0))))
  (func (export "as-i32x4_trunc_s_f32x4_sat-operand") (param f32) (result v128)
    (i32x4.trunc_sat_f32x4_s (f32x4.splat (local.get 0))))
)

(assert_return (invoke "as-i8x16_extract_lane_s-operand-first" (i32.const 42)) (i32.const 42))
(assert_return (invoke "as-i8x16_extract_lane_s-operand-last" (i32.const -42)) (i32.const -42))
(assert_return (invoke "as-i16x8_extract_lane_s-operand-first" (i32.const 0xffff7fff)) (i32.const 32767))
(assert_return (invoke "as-i16x8_extract_lane_s-operand-last" (i32.const 0x8000)) (i32.const -32768))
(assert_return (invoke "as-i32x4_extract_lane_s-operand-first" (i32.const 0x7fffffff)) (i32.const 2147483647))
(assert_return (invoke "as-i32x4_extract_lane_s-operand-last" (i32.const 0x80000000)) (i32.const -2147483648))
(assert_return (invoke "as-f32x4_extract_lane_s-operand-first" (f32.const 1.5)) (f32.const 1.5))
(assert_return (invoke "as-f32x4_extract_lane_s-operand-last" (f32.const -0.25)) (f32.const -0.25))
(assert_return (invoke "as-v8x16_swizzle-operands" (i32.const 1) (i32.const -1)) (v128.const i8x16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))

(assert_return (invoke "as-i8x16_add_sub_mul-operands" (i32.const 3) (i32.const 2) (i32.const 1) (i32.const 3)) (v128.const i8x16 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2))
(assert_return (invoke "as-i16x8_add_sub_mul-operands" (i32.const 257) (i32.const 128) (i32.const 16) (i32.const 16)) (v128.const i16x8 129 129 129 129 129 129 129 129))
(assert_return (invoke "as-i32x4_add_sub_mul-operands" (i32.const 65535) (i32.const 65537) (i32.const 256) (i32.const 256)) (v128.const i32x4 0x10000 0x10000 0x10000 0x10000))
(assert_return (invoke "as-i8x16_add_saturate_s-operands" (i32.const 0x7f) (i32.const 1)) (v128.const i8x16 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f 0x7f))
(assert_return (invoke "as-i16x8_add_saturate_s-operands" (i32.const 0x7fff) (i32.const 1)) (v128.const i16x8 0x7fff 0x7fff 0x7fff 0x7fff 0x7fff 0x7fff 0x7fff 0x7fff))
(assert_return (invoke "as-i8x16_sub_saturate_u-operands" (i32.const 0x7f) (i32.const 0xff)) (v128.const i8x16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
(assert_return (invoke "as-i16x8_sub_saturate_u-operands" (i32.const 0x7fff) (i32.const 0xffff)) (v128.const i16x8 0 0 0 0 0 0 0 0))

(assert_return (invoke "as-i8x16_shr_s-operand" (i32.const 0xf0) (i32.const 3)) (v128.const i8x16 -2 -2 -2 -2 -2 -2 -2 -2 -2 -2 -2 -2 -2 -2 -2 -2))
(assert_return (invoke "as-i16x8_shr_s-operand" (i32.const 0x100) (i32.const 4)) (v128.const i16x8 16 16 16 16 16 16 16 16))
(assert_return (invoke "as-i32x4_shr_s-operand" (i32.const -1) (i32.const 16)) (v128.const i32x4 -1 -1 -1 -1))

(assert_return (invoke "as-v128_and-operands" (i32.const 0x11) (i32.const 0xff)) (v128.const i8x16 17 17 17 17 17 17 17 17 17 17 17 17 17 17 17 17))
(assert_return (invoke "as-v128_or-operands" (i32.const 0) (i32.const 0xffff)) (v128.const i16x8 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff))
(assert_return (invoke "as-v128_xor-operands" (i32.const 0xf0f0f0f0) (i32.const 0xffffffff)) (v128.const i32x4 0xf0f0f0f 0xf0f0f0f 0xf0f0f0f 0xf0f0f0f))

(assert_return (invoke "as-i8x16_all_true-operand" (i32.const 0)) (i32.const 0))
(assert_return (invoke "as-i16x8_all_true-operand" (i32.const 0xffff)) (i32.const 1))
(assert_return (invoke "as-i32x4_all_true-operand" (i32.const 0xf0f0f0f0)) (i32.const 1))

(assert_return (invoke "as-i8x16_eq-operands" (i32.const 1) (i32.const 2)) (v128.const i8x16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
(assert_return (invoke "as-i16x8_eq-operands" (i32.const -1) (i32.const 65535)) (v128.const i16x8 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff))
(assert_return (invoke "as-i32x4_eq-operands" (i32.const -1) (i32.const 0xffffffff)) (v128.const i32x4 0xffffffff 0xffffffff 0xffffffff 0xffffffff))
(assert_return (invoke "as-f32x4_eq-operands" (f32.const +0.0) (f32.const -0.0)) (v128.const i32x4 0xffffffff 0xffffffff 0xffffffff 0xffffffff))

(assert_return (invoke "as-f32x4_abs-operand" (f32.const -1.125)) (v128.const f32x4 1.125 1.125 1.125 1.125))
(assert_return (invoke "as-f32x4_min-operands" (f32.const 0.25) (f32.const 1e-38)) (v128.const f32x4 1e-38 1e-38 1e-38 1e-38))
(assert_return (invoke "as-f32x4_div-operands" (f32.const 1.0) (f32.const 8.0)) (v128.const f32x4 0.125 0.125 0.125 0.125))

(assert_return (invoke "as-f32x4_convert_s_i32x4-operand" (i32.const 12345)) (v128.const f32x4 12345.0 12345.0 12345.0 12345.0))
(assert_return (invoke "as-i32x4_trunc_s_f32x4_sat-operand" (f32.const 1.1)) (v128.const i32x4 1 1 1 1))


;; As the argument of control constructs and WASM instructions

(module
  (global $g (mut v128) (v128.const f32x4 0.0 0.0 0.0 0.0))
  (func (export "as-br-value") (param i32) (result v128)
    (block (result v128) (br 0 (i8x16.splat (local.get 0)))))
  (func (export "as-return-value") (param i32) (result v128)
    (return (i16x8.splat (local.get 0))))
  (func (export "as-local_set-value") (param i32) (result v128) (local v128)
    (local.set 1 (i32x4.splat (local.get 0)))
    (return (local.get 1)))
  (func (export "as-global_set-value") (param f32) (result v128)
    (global.set $g (f32x4.splat (local.get 0)))
    (return (global.get $g)))
)

(assert_return (invoke "as-br-value" (i32.const 0xAB)) (v128.const i8x16 0xAB 0xAB 0xAB 0xAB 0xAB 0xAB 0xAB 0xAB 0xAB 0xAB 0xAB 0xAB 0xAB 0xAB 0xAB 0xAB))
(assert_return (invoke "as-return-value" (i32.const 0xABCD)) (v128.const i16x8 0xABCD 0xABCD 0xABCD 0xABCD 0xABCD 0xABCD 0xABCD 0xABCD))
(assert_return (invoke "as-local_set-value" (i32.const 0x10000)) (v128.const i32x4 0x10000 0x10000 0x10000 0x10000))
(assert_return (invoke "as-global_set-value" (f32.const 1.0)) (v128.const f32x4 1.0 1.0 1.0 1.0))

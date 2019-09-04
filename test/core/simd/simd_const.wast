;; v128.const normal parameter (e.g. (i8x16, i16x8 i32x4, f32x4))

(module (func (v128.const i8x16  0xFF  0xFF  0xFF  0xFF  0xFF  0xFF  0xFF  0xFF  0xFF  0xFF  0xFF  0xFF  0xFF  0xFF  0xFF  0xFF) drop))
(module (func (v128.const i8x16 -0x80 -0x80 -0x80 -0x80 -0x80 -0x80 -0x80 -0x80 -0x80 -0x80 -0x80 -0x80 -0x80 -0x80 -0x80 -0x80) drop))
(module (func (v128.const i8x16  255  255  255  255  255  255  255  255  255  255  255  255  255  255  255  255) drop))
(module (func (v128.const i8x16 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128 -128) drop))
(module (func (v128.const i16x8  0xFFFF  0xFFFF  0xFFFF  0xFFFF  0xFFFF  0xFFFF  0xFFFF  0xFFFF) drop))
(module (func (v128.const i16x8 -0x8000 -0x8000 -0x8000 -0x8000 -0x8000 -0x8000 -0x8000 -0x8000) drop))
(module (func (v128.const i16x8  65535  65535  65535  65535  65535  65535  65535  65535) drop))
(module (func (v128.const i16x8 -32768 -32768 -32768 -32768 -32768 -32768 -32768 -32768) drop))
(module (func (v128.const i32x4  0xffffffff  0xffffffff  0xffffffff  0xffffffff) drop))
(module (func (v128.const i32x4 -0x80000000 -0x80000000 -0x80000000 -0x80000000) drop))
(module (func (v128.const i32x4  4294967295  4294967295  4294967295  4294967295) drop))
(module (func (v128.const i32x4 -2147483648 -2147483648 -2147483648 -2147483648) drop))
(module (func (v128.const f32x4  0x1p127  0x1p127  0x1p127  0x1p127) drop))
(module (func (v128.const f32x4 -0x1p127 -0x1p127 -0x1p127 -0x1p127) drop))
(module (func (v128.const f32x4  1e38  1e38  1e38  1e38) drop))
(module (func (v128.const f32x4 -1e38 -1e38 -1e38 -1e38) drop))
(module (func (v128.const f32x4  340282356779733623858607532500980858880 340282356779733623858607532500980858880
                                 340282356779733623858607532500980858880 340282356779733623858607532500980858880) drop))
(module (func (v128.const f32x4 -340282356779733623858607532500980858880 -340282356779733623858607532500980858880
                                -340282356779733623858607532500980858880 -340282356779733623858607532500980858880) drop))
(module (func (v128.const f32x4 nan:0x1 nan:0x1 nan:0x1 nan:0x1) drop))
(module (func (v128.const f32x4 nan:0x7f_ffff nan:0x7f_ffff nan:0x7f_ffff nan:0x7f_ffff) drop))

;; Non-splat cases

(module (func (v128.const i8x16  0xFF  0xFF  0xFF  0xFF  0xFF  0xFF  0xFF  0xFF
                                -0x80 -0x80 -0x80 -0x80 -0x80 -0x80 -0x80 -0x80) drop))
(module (func (v128.const i8x16  0xFF  0xFF  0xFF  0xFF   255   255   255   255
                                -0x80 -0x80 -0x80 -0x80 -0x80 -0x80 -0x80 -0x80) drop))
(module (func (v128.const i8x16  0xFF  0xFF  0xFF  0xFF   255   255   255   255
                                -0x80 -0x80 -0x80 -0x80  -128  -128  -128  -128) drop))
(module (func (v128.const i16x8 0xFF 0xFF  0xFF  0xFF -0x8000 -0x8000 -0x8000 -0x8000) drop))
(module (func (v128.const i16x8 0xFF 0xFF 65535 65535 -0x8000 -0x8000 -0x8000 -0x8000) drop))
(module (func (v128.const i16x8 0xFF 0xFF 65535 65535 -0x8000 -0x8000  -32768  -32768) drop))
(module (func (v128.const i32x4 0xffffffff 0xffffffff -0x80000000 -0x80000000) drop))
(module (func (v128.const i32x4 0xffffffff 4294967295 -0x80000000 -0x80000000) drop))
(module (func (v128.const i32x4 0xffffffff 4294967295 -0x80000000 -2147483648) drop))


;; Constant out of range (int literal is too large)

(module (memory 1))
(assert_malformed
  (module quote "(func (v128.const i8x16 0x100 0x100 0x100 0x100 0x100 0x100 0x100 0x100 0x100 0x100 0x100 0x100 0x100 0x100 0x100 0x100) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (v128.const i8x16 -0x81 -0x81 -0x81 -0x81 -0x81 -0x81 -0x81 -0x81 -0x81 -0x81 -0x81 -0x81 -0x81 -0x81 -0x81 -0x81) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (v128.const i8x16 256 256 256 256 256 256 256 256 256 256 256 256 256 256 256 256) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (v128.const i8x16 -129 -129 -129 -129 -129 -129 -129 -129 -129 -129 -129 -129 -129 -129 -129 -129) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (v128.const i16x8 0x10000 0x10000 0x10000 0x10000 0x10000 0x10000 0x10000 0x10000) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (v128.const i16x8 -0x8001 -0x8001 -0x8001 -0x8001 -0x8001 -0x8001 -0x8001 -0x8001) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (v128.const i16x8 65536 65536 65536 65536 65536 65536 65536 65536) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (v128.const i16x8 -32769 -32769 -32769 -32769 -32769 -32769 -32769 -32769) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (v128.const i32x4  0x100000000  0x100000000  0x100000000  0x100000000) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (v128.const i32x4 -0x80000001 -0x80000001 -0x80000001 -0x80000001) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (v128.const i32x4  4294967296  4294967296  4294967296  4294967296) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (v128.const i32x4 -2147483649 -2147483649 -2147483649 -2147483649) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (v128.const f32x4  0x1p128  0x1p128  0x1p128  0x1p128) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (v128.const f32x4 -0x1p128 -0x1p128 -0x1p128 -0x1p128) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (v128.const f32x4  1e39  1e39  1e39  1e39) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (v128.const f32x4 -1e39 -1e39 -1e39 -1e39) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (v128.const f32x4  340282356779733661637539395458142568448 340282356779733661637539395458142568448"
                "                         340282356779733661637539395458142568448 340282356779733661637539395458142568448) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (v128.const f32x4 -340282356779733661637539395458142568448 -340282356779733661637539395458142568448"
                "                        -340282356779733661637539395458142568448 -340282356779733661637539395458142568448) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (v128.const f32x4 nan:1 nan:1 nan:1 nan:1) drop)")
  "unknown operator"
)

(assert_malformed
  (module quote "(func (v128.const f32x4 nan:0x0 nan:0x0 nan:0x0 nan:0x0) drop)")
  "constant out of range"
)

(assert_malformed
  (module quote "(func (v128.const f32x4 nan:0x80_0000 nan:0x80_0000 nan:0x80_0000 nan:0x80_0000) drop)")
  "constant out of range"
)


;; Rounding behaviour

;; f32x4, small exponent
(module (func (export "f") (result v128) (v128.const f32x4 +0x1.00000100000000000p-50 +0x1.00000100000000000p-50 +0x1.00000100000000000p-50 +0x1.00000100000000000p-50)))
(assert_return (invoke "f") (v128.const f32x4 +0x1.000000p-50 +0x1.000000p-50 +0x1.000000p-50 +0x1.000000p-50))
(module (func (export "f") (result v128) (v128.const f32x4 -0x1.00000100000000000p-50 -0x1.00000100000000000p-50 -0x1.00000100000000000p-50 -0x1.00000100000000000p-50)))
(assert_return (invoke "f") (v128.const f32x4 -0x1.000000p-50 -0x1.000000p-50 -0x1.000000p-50 -0x1.000000p-50))
(module (func (export "f") (result v128) (v128.const f32x4 +0x1.00000500000000001p-50 +0x1.00000500000000001p-50 +0x1.00000500000000001p-50 +0x1.00000500000000001p-50)))
(assert_return (invoke "f") (v128.const f32x4 +0x1.000006p-50 +0x1.000006p-50 +0x1.000006p-50 +0x1.000006p-50))
(module (func (export "f") (result v128) (v128.const f32x4 -0x1.00000500000000001p-50 -0x1.00000500000000001p-50 -0x1.00000500000000001p-50 -0x1.00000500000000001p-50)))
(assert_return (invoke "f") (v128.const f32x4 -0x1.000006p-50 -0x1.000006p-50 -0x1.000006p-50 -0x1.000006p-50))

(module (func (export "f") (result v128) (v128.const f32x4 +0x4000.004000000p-64 +0x4000.004000000p-64 +0x4000.004000000p-64 +0x4000.004000000p-64)))
(assert_return (invoke "f") (v128.const f32x4 +0x1.000000p-50 +0x1.000000p-50 +0x1.000000p-50 +0x1.000000p-50))
(module (func (export "f") (result v128) (v128.const f32x4 -0x4000.004000000p-64 -0x4000.004000000p-64 -0x4000.004000000p-64 -0x4000.004000000p-64)))
(assert_return (invoke "f") (v128.const f32x4 -0x1.000000p-50 -0x1.000000p-50 -0x1.000000p-50 -0x1.000000p-50))
(module (func (export "f") (result v128) (v128.const f32x4 +0x4000.014000001p-64 +0x4000.014000001p-64 +0x4000.014000001p-64 +0x4000.014000001p-64)))
(assert_return (invoke "f") (v128.const f32x4 +0x1.000006p-50 +0x1.000006p-50 +0x1.000006p-50 +0x1.000006p-50))
(module (func (export "f") (result v128) (v128.const f32x4 -0x4000.014000001p-64 -0x4000.014000001p-64 -0x4000.014000001p-64 -0x4000.014000001p-64)))
(assert_return (invoke "f") (v128.const f32x4 -0x1.000006p-50 -0x1.000006p-50 -0x1.000006p-50 -0x1.000006p-50))

(module (func (export "f") (result v128) (v128.const f32x4 +8.8817847263968443573e-16 +8.8817847263968443573e-16 +8.8817847263968443573e-16 +8.8817847263968443573e-16)))
(assert_return (invoke "f") (v128.const f32x4 +0x1.000000p-50 +0x1.000000p-50 +0x1.000000p-50 +0x1.000000p-50))
(module (func (export "f") (result v128) (v128.const f32x4 -8.8817847263968443573e-16 -8.8817847263968443573e-16 -8.8817847263968443573e-16 -8.8817847263968443573e-16)))
(assert_return (invoke "f") (v128.const f32x4 -0x1.000000p-50 -0x1.000000p-50 -0x1.000000p-50 -0x1.000000p-50))
(module (func (export "f") (result v128) (v128.const f32x4 +8.8817857851880284253e-16 +8.8817857851880284253e-16 +8.8817857851880284253e-16 +8.8817857851880284253e-16)))
(assert_return (invoke "f") (v128.const f32x4 +0x1.000004p-50 +0x1.000004p-50 +0x1.000004p-50 +0x1.000004p-50))
(module (func (export "f") (result v128) (v128.const f32x4 -8.8817857851880284253e-16 -8.8817857851880284253e-16 -8.8817857851880284253e-16 -8.8817857851880284253e-16)))
(assert_return (invoke "f") (v128.const f32x4 -0x1.000004p-50 -0x1.000004p-50 -0x1.000004p-50 -0x1.000004p-50))

;; f32x4, large exponent
(module (func (export "f") (result v128) (v128.const f32x4 +0x1.00000100000000000p+50 +0x1.00000100000000000p+50 +0x1.00000100000000000p+50 +0x1.00000100000000000p+50)))
(assert_return (invoke "f") (v128.const f32x4 +0x1.000000p+50 +0x1.000000p+50 +0x1.000000p+50 +0x1.000000p+50))
(module (func (export "f") (result v128) (v128.const f32x4 -0x1.00000100000000000p+50 -0x1.00000100000000000p+50 -0x1.00000100000000000p+50 -0x1.00000100000000000p+50)))
(assert_return (invoke "f") (v128.const f32x4 -0x1.000000p+50 -0x1.000000p+50 -0x1.000000p+50 -0x1.000000p+50))
(module (func (export "f") (result v128) (v128.const f32x4 +0x1.00000500000000001p+50 +0x1.00000500000000001p+50 +0x1.00000500000000001p+50 +0x1.00000500000000001p+50)))
(assert_return (invoke "f") (v128.const f32x4 +0x1.000006p+50 +0x1.000006p+50 +0x1.000006p+50 +0x1.000006p+50))
(module (func (export "f") (result v128) (v128.const f32x4 -0x1.00000500000000001p+50 -0x1.00000500000000001p+50 -0x1.00000500000000001p+50 -0x1.00000500000000001p+50)))
(assert_return (invoke "f") (v128.const f32x4 -0x1.000006p+50 -0x1.000006p+50 -0x1.000006p+50 -0x1.000006p+50))

(module (func (export "f") (result v128) (v128.const f32x4 +0x4000004000000 +0x4000004000000 +0x4000004000000 +0x4000004000000)))
(assert_return (invoke "f") (v128.const f32x4 +0x1.000000p+50 +0x1.000000p+50 +0x1.000000p+50 +0x1.000000p+50))
(module (func (export "f") (result v128) (v128.const f32x4 -0x4000004000000 -0x4000004000000 -0x4000004000000 -0x4000004000000)))
(assert_return (invoke "f") (v128.const f32x4 -0x1.000000p+50 -0x1.000000p+50 -0x1.000000p+50 -0x1.000000p+50))
(module (func (export "f") (result v128) (v128.const f32x4 +0x400000c000000 +0x400000c000000 +0x400000c000000 +0x400000c000000)))
(assert_return (invoke "f") (v128.const f32x4 +0x1.000004p+50 +0x1.000004p+50 +0x1.000004p+50 +0x1.000004p+50))
(module (func (export "f") (result v128) (v128.const f32x4 -0x400000c000000 -0x400000c000000 -0x400000c000000 -0x400000c000000)))
(assert_return (invoke "f") (v128.const f32x4 -0x1.000004p+50 -0x1.000004p+50 -0x1.000004p+50 -0x1.000004p+50))

(module (func (export "f") (result v128) (v128.const f32x4 +1125899973951488 +1125899973951488 +1125899973951488 +1125899973951488)))
(assert_return (invoke "f") (v128.const f32x4 +0x1.000000p+50 +0x1.000000p+50 +0x1.000000p+50 +0x1.000000p+50))
(module (func (export "f") (result v128) (v128.const f32x4 -1125899973951488 -1125899973951488 -1125899973951488 -1125899973951488)))
(assert_return (invoke "f") (v128.const f32x4 -0x1.000000p+50 -0x1.000000p+50 -0x1.000000p+50 -0x1.000000p+50))
(module (func (export "f") (result v128) (v128.const f32x4 +1125900108169216 +1125900108169216 +1125900108169216 +1125900108169216)))
(assert_return (invoke "f") (v128.const f32x4 +0x1.000004p+50 +0x1.000004p+50 +0x1.000004p+50 +0x1.000004p+50))
(module (func (export "f") (result v128) (v128.const f32x4 -1125900108169216 -1125900108169216 -1125900108169216 -1125900108169216)))
(assert_return (invoke "f") (v128.const f32x4 -0x1.000004p+50 -0x1.000004p+50 -0x1.000004p+50 -0x1.000004p+50))

;; f32x4, subnormal
(module (func (export "f") (result v128) (v128.const f32x4 +0x0.00000100000000000p-126 +0x0.00000100000000000p-126 +0x0.00000100000000000p-126 +0x0.00000100000000000p-126)))
(assert_return (invoke "f") (v128.const f32x4 +0x0.000000p-126 +0x0.000000p-126 +0x0.000000p-126 +0x0.000000p-126))
(module (func (export "f") (result v128) (v128.const f32x4 -0x0.00000100000000000p-126 -0x0.00000100000000000p-126 -0x0.00000100000000000p-126 -0x0.00000100000000000p-126)))
(assert_return (invoke "f") (v128.const f32x4 -0x0.000000p-126 -0x0.000000p-126 -0x0.000000p-126 -0x0.000000p-126))
(module (func (export "f") (result v128) (v128.const f32x4 +0x0.00000500000000001p-126 +0x0.00000500000000001p-126 +0x0.00000500000000001p-126 +0x0.00000500000000001p-126)))
(assert_return (invoke "f") (v128.const f32x4 +0x0.000006p-126 +0x0.000006p-126 +0x0.000006p-126 +0x0.000006p-126))
(module (func (export "f") (result v128) (v128.const f32x4 -0x0.00000500000000001p-126 -0x0.00000500000000001p-126 -0x0.00000500000000001p-126 -0x0.00000500000000001p-126)))
(assert_return (invoke "f") (v128.const f32x4 -0x0.000006p-126 -0x0.000006p-126 -0x0.000006p-126 -0x0.000006p-126))

;; f32x4, round down at limit to infinity
(module (func (export "f") (result v128) (v128.const f32x4 +0x1.fffffe8p127 +0x1.fffffe8p127 +0x1.fffffe8p127 +0x1.fffffe8p127)))
(assert_return (invoke "f") (v128.const f32x4 +0x1.fffffep127 +0x1.fffffep127 +0x1.fffffep127 +0x1.fffffep127))
(module (func (export "f") (result v128) (v128.const f32x4 -0x1.fffffe8p127 -0x1.fffffe8p127 -0x1.fffffe8p127 -0x1.fffffe8p127)))
(assert_return (invoke "f") (v128.const f32x4 -0x1.fffffep127 -0x1.fffffep127 -0x1.fffffep127 -0x1.fffffep127))
(module (func (export "f") (result v128) (v128.const f32x4 +0x1.fffffefffffffffffp127 +0x1.fffffefffffffffffp127 +0x1.fffffefffffffffffp127 +0x1.fffffefffffffffffp127)))
(assert_return (invoke "f") (v128.const f32x4 +0x1.fffffep127 +0x1.fffffep127 +0x1.fffffep127 +0x1.fffffep127))
(module (func (export "f") (result v128) (v128.const f32x4 -0x1.fffffefffffffffffp127 -0x1.fffffefffffffffffp127 -0x1.fffffefffffffffffp127 -0x1.fffffefffffffffffp127)))
(assert_return (invoke "f") (v128.const f32x4 -0x1.fffffep127 -0x1.fffffep127 -0x1.fffffep127 -0x1.fffffep127))


;; As parameters of control constructs

(module (memory 1)
  (func (export "as-br-retval") (result v128)
    (block (result v128) (br 0 (v128.const i32x4 0x03020100 0x07060504 0x0b0a0908 0x0f0e0d0c)))
  )
  (func (export "as-br_if-retval") (result v128)
    (block (result v128)
      (br_if 0 (v128.const i32x4 0 1 2 3) (i32.const 1))
    )
  )
  (func (export "as-return-retval") (result v128)
    (return (v128.const i32x4 0 1 2 3))
  )
  (func (export "as-if-then-retval") (result v128)
    (if (result v128) (i32.const 1)
      (then (v128.const i32x4 0 1 2 3)) (else (v128.const i32x4 3 2 1 0))
    )
  )
  (func (export "as-if-else-retval") (result v128)
    (if (result v128) (i32.const 0)
      (then (v128.const i32x4 0 1 2 3)) (else (v128.const i32x4 3 2 1 0))
    )
  )
  (func $f (param v128 v128 v128) (result v128) (v128.const i32x4 0 1 2 3))
  (func (export "as-call-param") (result v128)
    (call $f (v128.const i32x4 0 1 2 3) (v128.const i32x4 0 1 2 3) (v128.const i32x4 0 1 2 3))
  )
  (type $sig (func (param v128 v128 v128) (result v128)))
  (table funcref (elem $f))
  (func (export "as-call_indirect-param") (result v128)
    (call_indirect (type $sig)
      (v128.const i32x4 0 1 2 3) (v128.const i32x4 0 1 2 3) (v128.const i32x4 0 1 2 3) (i32.const 0)
    )
  )
  (func (export "as-block-retval") (result v128)
    (block (result v128) (v128.const i32x4 0 1 2 3))
  )
  (func (export "as-loop-retval") (result v128)
    (loop (result v128) (v128.const i32x4 0 1 2 3))
  )
  (func (export "as-drop-operand")
    (drop (v128.const i32x4 0 1 2 3))
  )
)

(assert_return (invoke "as-br-retval") (v128.const i32x4 0x03020100 0x07060504 0x0b0a0908 0x0f0e0d0c))
(assert_return (invoke "as-br_if-retval") (v128.const i32x4 0 1 2 3))
(assert_return (invoke "as-return-retval") (v128.const i32x4 0 1 2 3))
(assert_return (invoke "as-if-then-retval") (v128.const i32x4 0 1 2 3))
(assert_return (invoke "as-if-else-retval") (v128.const i32x4 3 2 1 0))
(assert_return (invoke "as-call-param") (v128.const i32x4 0 1 2 3))
(assert_return (invoke "as-call_indirect-param") (v128.const i32x4 0 1 2 3))
(assert_return (invoke "as-block-retval") (v128.const i32x4 0 1 2 3))
(assert_return (invoke "as-loop-retval") (v128.const i32x4 0 1 2 3))
(assert_return (invoke "as-drop-operand"))


;; v128 locals

(module (memory 1)
  (func (export "as-local.set/get-value_0_0") (param $0 v128) (result v128)
    (local v128 v128 v128 v128)
    (local.set 0 (local.get $0))
    (local.get 0)
  )
  (func (export "as-local.set/get-value_0_1") (param $0 v128) (result v128)
    (local v128 v128 v128 v128)
    (local.set 0 (local.get $0))
    (local.set 1 (local.get 0))
    (local.set 2 (local.get 1))
    (local.set 3 (local.get 2))
    (local.get 0)
  )
  (func (export "as-local.set/get-value_3_0") (param $0 v128) (result v128)
    (local v128 v128 v128 v128)
    (local.set 0 (local.get $0))
    (local.set 1 (local.get 0))
    (local.set 2 (local.get 1))
    (local.set 3 (local.get 2))
    (local.get 3)
  )
  (func (export "as-local.tee-value") (result v128)
    (local v128)
    (local.tee 0 (v128.const i32x4 0 1 2 3))
  )
)

(assert_return (invoke "as-local.set/get-value_0_0" (v128.const i32x4 0 0 0 0)) (v128.const i32x4 0 0 0 0))
(assert_return (invoke "as-local.set/get-value_0_1" (v128.const i32x4 1 1 1 1)) (v128.const i32x4 1 1 1 1))
(assert_return (invoke "as-local.set/get-value_3_0" (v128.const i32x4 2 2 2 2)) (v128.const i32x4 2 2 2 2))
(assert_return (invoke "as-local.tee-value") (v128.const i32x4 0 1 2 3))


;; v128 globals

(module (memory 1)
  (global $g0 (mut v128) (v128.const i32x4 0 1 2 3))
  (global $g1 (mut v128) (v128.const i32x4 4 5 6 7))
  (global $g2 (mut v128) (v128.const i32x4 8 9 10 11))
  (global $g3 (mut v128) (v128.const i32x4 12 13 14 15))
  (global $g4 (mut v128) (v128.const i32x4 16 17 18 19))

  (func $set_g0 (export "as-global.set_value_$g0") (param $0 v128)
    (global.set $g0 (local.get $0))
  )
  (func $set_g1_g2 (export "as-global.set_value_$g1_$g2") (param $0 v128) (param $1 v128)
    (global.set $g1 (local.get $0))
    (global.set $g2 (local.get $1))
  )
  (func $set_g0_g1_g2_g3 (export "as-global.set_value_$g0_$g1_$g2_$g3") (param $0 v128) (param $1 v128) (param $2 v128) (param $3 v128)
    (call $set_g0 (local.get $0))
    (call $set_g1_g2 (local.get $1) (local.get $2))
    (global.set $g3 (local.get $3))
  )
  (func (export "global.get_g0") (result v128)
    (global.get $g0)
  )
  (func (export "global.get_g1") (result v128)
    (global.get $g1)
  )
  (func (export "global.get_g2") (result v128)
    (global.get $g2)
  )
  (func (export "global.get_g3") (result v128)
    (global.get $g3)
  )
)

(assert_return (invoke "as-global.set_value_$g0_$g1_$g2_$g3" (v128.const i32x4 1 1 1 1)
                                                             (v128.const i32x4 2 2 2 2)
                                                             (v128.const i32x4 3 3 3 3)
                                                             (v128.const i32x4 4 4 4 4)))
(assert_return (invoke "global.get_g0") (v128.const i32x4 1 1 1 1))
(assert_return (invoke "global.get_g1") (v128.const i32x4 2 2 2 2))
(assert_return (invoke "global.get_g2") (v128.const i32x4 3 3 3 3))
(assert_return (invoke "global.get_g3") (v128.const i32x4 4 4 4 4))


;; Test integer literal parsing.

(module
  (func (export "i32x4.test") (result v128) (return (v128.const i32x4 0x0bAdD00D 0x0bAdD00D 0x0bAdD00D 0x0bAdD00D)))
  (func (export "i32x4.smax") (result v128) (return (v128.const i32x4 0x7fffffff 0x7fffffff 0x7fffffff 0x7fffffff)))
  (func (export "i32x4.neg_smax") (result v128) (return (v128.const i32x4 -0x7fffffff -0x7fffffff -0x7fffffff -0x7fffffff)))
  (func (export "i32x4.inc_smin") (result v128) (return (i32x4.add (v128.const i32x4 -0x80000000 -0x80000000 -0x80000000 -0x80000000) (v128.const i32x4 1 1 1 1))))
  (func (export "i32x4.neg_zero") (result v128) (return (v128.const i32x4 -0x0 -0x0 -0x0 -0x0)))
  (func (export "i32x4.not_octal") (result v128) (return (v128.const i32x4 010 010 010 010)))
  (func (export "i32x4.plus_sign") (result v128) (return (v128.const i32x4 +42 +42 +42 +42)))

  (func (export "i32x4-dec-sep1") (result v128) (v128.const i32x4 1_000_000 1_000_000 1_000_000 1_000_000))
  (func (export "i32x4-dec-sep2") (result v128) (v128.const i32x4 1_0_0_0 1_0_0_0 1_0_0_0 1_0_0_0))
  (func (export "i32x4-hex-sep1") (result v128) (v128.const i32x4 0xa_0f_00_99 0xa_0f_00_99 0xa_0f_00_99 0xa_0f_00_99))
  (func (export "i32x4-hex-sep2") (result v128) (v128.const i32x4 0x1_a_A_0_f 0x1_a_A_0_f 0x1_a_A_0_f 0x1_a_A_0_f))
)

(assert_return (invoke "i32x4.test") (v128.const i32x4 195940365 195940365 195940365 195940365))
(assert_return (invoke "i32x4.smax") (v128.const i32x4 2147483647 2147483647 2147483647 2147483647))
(assert_return (invoke "i32x4.neg_smax") (v128.const i32x4 -2147483647 -2147483647 -2147483647 -2147483647))
(assert_return (invoke "i32x4.inc_smin") (v128.const i32x4 -2147483647 -2147483647 -2147483647 -2147483647))
(assert_return (invoke "i32x4.neg_zero") (v128.const i32x4 0 0 0 0))
(assert_return (invoke "i32x4.not_octal") (v128.const i32x4 10 10 10 10))
(assert_return (invoke "i32x4.plus_sign") (v128.const i32x4 42 42 42 42))

(assert_return (invoke "i32x4-dec-sep1") (v128.const i32x4 1000000 1000000 1000000 1000000))
(assert_return (invoke "i32x4-dec-sep2") (v128.const i32x4 1000 1000 1000 1000))
(assert_return (invoke "i32x4-hex-sep1") (v128.const i32x4 0xa0f0099 0xa0f0099 0xa0f0099 0xa0f0099))
(assert_return (invoke "i32x4-hex-sep2") (v128.const i32x4 0x1aa0f 0x1aa0f 0x1aa0f 0x1aa0f))

(assert_malformed
  (module quote "(global v128 (v128.const i32x4 _100 _100 _100 _100))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const i32x4 +_100 +_100 +_100 +_100))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const i32x4 -_100 -_100 -_100 -_100))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const i32x4 99_ 99_ 99_ 99_))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const i32x4 1__000 1__000 1__000 1__000))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const i32x4 _0x100 _0x100 _0x100 _0x100))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const i32x4 0_x100 0_x100 0_x100 0_x100))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const i32x4 0x_100 0x_100 0x_100 0x_100))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const i32x4 0x00_ 0x00_ 0x00_ 0x00_))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const i32x4 0xff__ffff 0xff__ffff 0xff__ffff 0xff__ffff))")
  "unknown operator"
)


;; Test floating-point literal parsing.

(module
  (func (export "f32-dec-sep1") (result v128) (v128.const f32x4 1_000_000 1_000_000 1_000_000 1_000_000))
  (func (export "f32-dec-sep2") (result v128) (v128.const f32x4 1_0_0_0 1_0_0_0 1_0_0_0 1_0_0_0))
  (func (export "f32-dec-sep3") (result v128) (v128.const f32x4 100_3.141_592 100_3.141_592 100_3.141_592 100_3.141_592))
  (func (export "f32-dec-sep4") (result v128) (v128.const f32x4 99e+1_3 99e+1_3 99e+1_3 99e+1_3))
  (func (export "f32-dec-sep5") (result v128) (v128.const f32x4 122_000.11_3_54E0_2_3 122_000.11_3_54E0_2_3 122_000.11_3_54E0_2_3 122_000.11_3_54E0_2_3))
  (func (export "f32-hex-sep1") (result v128) (v128.const f32x4 0xa_0f_00_99 0xa_0f_00_99 0xa_0f_00_99 0xa_0f_00_99))
  (func (export "f32-hex-sep2") (result v128) (v128.const f32x4 0x1_a_A_0_f 0x1_a_A_0_f 0x1_a_A_0_f 0x1_a_A_0_f))
  (func (export "f32-hex-sep3") (result v128) (v128.const f32x4 0xa0_ff.f141_a59a 0xa0_ff.f141_a59a 0xa0_ff.f141_a59a 0xa0_ff.f141_a59a))
  (func (export "f32-hex-sep4") (result v128) (v128.const f32x4 0xf0P+1_3 0xf0P+1_3 0xf0P+1_3 0xf0P+1_3))
  (func (export "f32-hex-sep5") (result v128) (v128.const f32x4 0x2a_f00a.1f_3_eep2_3 0x2a_f00a.1f_3_eep2_3 0x2a_f00a.1f_3_eep2_3 0x2a_f00a.1f_3_eep2_3))
)

(assert_return (invoke "f32-dec-sep1") (v128.const f32x4 1000000 1000000 1000000 1000000))
(assert_return (invoke "f32-dec-sep2") (v128.const f32x4 1000 1000 1000 1000))
(assert_return (invoke "f32-dec-sep3") (v128.const f32x4 1003.141592 1003.141592 1003.141592 1003.141592))
(assert_return (invoke "f32-dec-sep4") (v128.const f32x4 99e+13 99e+13 99e+13 99e+13))
(assert_return (invoke "f32-dec-sep5") (v128.const f32x4 122000.11354e23 122000.11354e23 122000.11354e23 122000.11354e23))
(assert_return (invoke "f32-hex-sep1") (v128.const f32x4 0xa0f0099 0xa0f0099 0xa0f0099 0xa0f0099))
(assert_return (invoke "f32-hex-sep2") (v128.const f32x4 0x1aa0f 0x1aa0f 0x1aa0f 0x1aa0f))
(assert_return (invoke "f32-hex-sep3") (v128.const f32x4 0xa0ff.f141a59a 0xa0ff.f141a59a 0xa0ff.f141a59a 0xa0ff.f141a59a))
(assert_return (invoke "f32-hex-sep4") (v128.const f32x4 0xf0P+13 0xf0P+13 0xf0P+13 0xf0P+13))
(assert_return (invoke "f32-hex-sep5") (v128.const f32x4 0x2af00a.1f3eep23 0x2af00a.1f3eep23 0x2af00a.1f3eep23 0x2af00a.1f3eep23))

(assert_malformed
  (module quote "(global v128 (v128.const f32x4 _100 _100 _100 _100))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 +_100 +_100 +_100 +_100))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 -_100 -_100 -_100 -_100))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 99_ 99_ 99_ 99_))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 1__000 1__000 1__000 1__000))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 _1.0 _1.0 _1.0 _1.0))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 1.0_ 1.0_ 1.0_ 1.0_))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 1_.0 1_.0 1_.0 1_.0))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 1._0 1._0 1._0 1._0))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 _1e1 _1e1 _1e1 _1e1))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 1e1_ 1e1_ 1e1_ 1e1_))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 1_e1 1_e1 1_e1 1_e1))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 1e_1 1e_1 1e_1 1e_1))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 _1.0e1 _1.0e1 _1.0e1 _1.0e1))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 1.0e1_ 1.0e1_ 1.0e1_ 1.0e1_))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 1.0_e1 1.0_e1 1.0_e1 1.0_e1))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 1.0e_1 1.0e_1 1.0e_1 1.0e_1))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 1.0e+_1 1.0e+_1 1.0e+_1 1.0e+_1))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 1.0e_+1 1.0e_+1 1.0e_+1 1.0e_+1))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 _0x100 _0x100 _0x100 _0x100))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 0_x100 0_x100 0_x100 0_x100))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 0x_100 0x_100 0x_100 0x_100))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 0x00_ 0x00_ 0x00_ 0x00_))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 0xff__ffff 0xff__ffff 0xff__ffff 0xff__ffff))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 0x_1.0 0x_1.0 0x_1.0 0x_1.0))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 0x1.0_ 0x1.0_ 0x1.0_ 0x1.0_))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 0x1_.0 0x1_.0 0x1_.0 0x1_.0))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 0x1._0 0x1._0 0x1._0 0x1._0))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 0x_1p1 0x_1p1 0x_1p1 0x_1p1))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 0x1p1_ 0x1p1_ 0x1p1_ 0x1p1_))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 0x1_p1 0x1_p1 0x1_p1 0x1_p1))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 0x1p_1 0x1p_1 0x1p_1 0x1p_1))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 0x_1.0p1 0x_1.0p1 0x_1.0p1 0x_1.0p1))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 0x1.0p1_ 0x1.0p1_ 0x1.0p1_ 0x1.0p1_))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 0x1.0_p1 0x1.0_p1 0x1.0_p1 0x1.0_p1))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 0x1.0p_1 0x1.0p_1 0x1.0p_1 0x1.0p_1))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 0x1.0p+_1 0x1.0p+_1 0x1.0p+_1 0x1.0p+_1))")
  "unknown operator"
)
(assert_malformed
  (module quote "(global v128 (v128.const f32x4 0x1.0p_+1 0x1.0p_+1 0x1.0p_+1 0x1.0p_+1))")
  "unknown operator"
)


;; Test parsing an integer from binary

(module binary
  "\00asm" "\01\00\00\00"
  "\01\05\01"                                ;; type   section
  "\60\00\01\7b"                             ;; type 0 (func)
  "\03\02\01\00"                             ;; func   section
  "\07\0f\01\0b"                             ;; export section
  "\70\61\72\73\65\5f\69\38\78\31\36\00\00"  ;; export name (parse_i8x16)
  "\0a\16\01"                                ;; code   section
  "\14\00\fd\02"                             ;; func body
  "\00\00\00\00"                             ;; data lane 0~3   (0,    0,    0,    0)
  "\80\80\80\80"                             ;; data lane 4~7   (-128, -128, -128, -128)
  "\ff\ff\ff\ff"                             ;; data lane 8~11  (0xff, 0xff, 0xff, 0xff)
  "\ff\ff\ff\ff"                             ;; data lane 12~15 (255,  255,  255,  255)
  "\0b"                                      ;; end
)
(assert_return (invoke "parse_i8x16") (v128.const i8x16 0 0 0 0 -128 -128 -128 -128 0xff 0xff 0xff 0xff 255 255 255 255))

(module binary
  "\00asm" "\01\00\00\00"
  "\01\05\01"                                ;; type   section
  "\60\00\01\7b"                             ;; type 0 (func)
  "\03\02\01\00"                             ;; func   section
  "\07\0f\01\0b"                             ;; export section
  "\70\61\72\73\65\5f\69\31\36\78\38\00\00"  ;; export name (parse_i16x8)
  "\0a\16\01"                                ;; code   section
  "\14\00\fd\02"                             ;; func body
  "\00\00\00\00"                             ;; data lane 0, 1 (0,      0)
  "\00\80\00\80"                             ;; data lane 2, 3 (-32768, -32768)
  "\ff\ff\ff\ff"                             ;; data lane 4, 5 (65535,  65535)
  "\ff\ff\ff\ff"                             ;; data lane 6, 7 (0xffff, 0xffff)
  "\0b"                                      ;; end
)
(assert_return (invoke "parse_i16x8") (v128.const i16x8 0 0 -32768 -32768 65535 65535 0xffff 0xffff))

(module binary
  "\00asm" "\01\00\00\00"
  "\01\05\01"                                ;; type   section
  "\60\00\01\7b"                             ;; type 0 (func)
  "\03\02\01\00"                             ;; func   section
  "\07\0f\01\0b"                             ;; export section
  "\70\61\72\73\65\5f\69\33\32\78\34\00\00"  ;; export name (parse_i32x4)
  "\0a\16\01"                                ;; code   section
  "\14\00\fd\02"                             ;; func body
  "\d1\ff\ff\ff"                             ;; data lane 0 (4294967249)
  "\d1\ff\ff\ff"                             ;; data lane 1 (4294967249)
  "\d1\ff\ff\ff"                             ;; data lane 2 (4294967249)
  "\d1\ff\ff\ff"                             ;; data lane 3 (4294967249)
  "\0b"                                      ;; end
)
(assert_return (invoke "parse_i32x4") (v128.const i32x4 4294967249 4294967249 4294967249 4294967249))


;; Test parsing a float from binary

(module binary
  "\00asm" "\01\00\00\00"
  "\01\05\01"                                ;; type   section
  "\60\00\01\7b"                             ;; type 0 (func)
  "\03\02\01\00"                             ;; func   section
  "\07\0f\01\0b"                             ;; export section
  "\70\61\72\73\65\5f\66\33\32\78\34\00\00"  ;; export name (parse_f32x4)
  "\0a\16\01"                                ;; code   section
  "\14\00\fd\02"                             ;; func body
  "\00\00\80\4f"                             ;; data lane 0 (4294967249)
  "\00\00\80\4f"                             ;; data lane 1 (4294967249)
  "\00\00\80\4f"                             ;; data lane 2 (4294967249)
  "\00\00\80\4f"                             ;; data lane 3 (4294967249)
  "\0b"                                      ;; end
)
(assert_return (invoke "parse_f32x4") (v128.const f32x4 4294967249 4294967249 4294967249 4294967249))

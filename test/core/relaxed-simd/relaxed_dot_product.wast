;; Tests for relaxed dot products.

(module
    (func (export "i16x8.dot_i8x16_i7x16_s") (param v128 v128) (result v128) (i16x8.dot_i8x16_i7x16_s (local.get 0) (local.get 1)))
    (func (export "i32x4.dot_i8x16_i7x16_add_s") (param v128 v128 v128) (result v128) (i32x4.dot_i8x16_i7x16_add_s (local.get 0) (local.get 1) (local.get 2)))
    (func (export "f32x4.relaxed_dot_bf16x8_add_f32x4") (param v128 v128 v128) (result v128) (f32x4.relaxed_dot_bf16x8_add_f32x4 (local.get 0) (local.get 1) (local.get 2)))
)

;; Simple values to ensure things are functional.
(assert_return (invoke "i16x8.dot_i8x16_i7x16_s"
                       (v128.const i8x16 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
                       (v128.const i8x16 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15))
               (v128.const i16x8 1 13 41 85 145 221 313 421))

;; Test max and min i8 values;
(assert_return (invoke "i16x8.dot_i8x16_i7x16_s"
                       (v128.const i8x16 -128 -128 127 127 0 0 0 0 0 0 0 0 0 0 0 0)
                       (v128.const i8x16 127 127 127 127 0 0 0 0 0 0 0 0 0 0 0 0))
               (v128.const i16x8 -32512 32258 0 0 0 0 0 0))

;; Simple values to ensure things are functional.
(assert_return (invoke "i32x4.dot_i8x16_i7x16_add_s"
                       (v128.const i8x16 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
                       (v128.const i8x16 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
                       (v128.const i32x4 0 1 2 3))
               ;; intermediate result is [14, 126, 366, 734]
               (v128.const f32x4 14 127 368 737))

;; Test max and min i8 values;
(assert_return (invoke "i32x4.dot_i8x16_i7x16_add_s"
                       (v128.const i8x16 -128 -128 -128 -128 127 127 127 127 0 0 0 0 0 0 0 0)
                       (v128.const i8x16 127 127 127 127 127 127 127 127 0 0 0 0 0 0 0 0)
                       (v128.const i32x4 1 2 3 4))
               ;; intermediate result is [-65024, 64516, 0, 0]
               (v128.const f32x4 -65023 64518 3 4))

;; Simple values to ensure things are functional.
(assert_return (invoke "f32x4.relaxed_dot_bf16x8_add_f32x4"
                       (v128.const i16x8 0x0000 0x3f80 0x4000 0x4040 0x4080 0x40a0 0x40c0 0x40e0)  ;; [0.0f, 1.0f, 2.0f, 3.0f, 4.0f, 5.0f, 6.0f, 7.0f]
                       (v128.const i16x8 0x0000 0x3f80 0x4000 0x4040 0x4080 0x40a0 0x40c0 0x40e0)
                       (v128.const f32x4 0 1 2 3))
               ;; intermediate result is [1, 13, 41, 85]
               (v128.const f32x4 1 14 43 88))

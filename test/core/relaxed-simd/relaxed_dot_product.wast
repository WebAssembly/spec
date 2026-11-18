;; Tests for relaxed dot products.

(module
    (func (export "i16x8.relaxed_dot_i8x16_i7x16_s") (param v128 v128) (result v128) (i16x8.relaxed_dot_i8x16_i7x16_s (local.get 0) (local.get 1)))
    (func (export "i32x4.relaxed_dot_i8x16_i7x16_add_s") (param v128 v128 v128) (result v128) (i32x4.relaxed_dot_i8x16_i7x16_add_s (local.get 0) (local.get 1) (local.get 2)))

    (func (export "i16x8.relaxed_dot_i8x16_i7x16_s_cmp") (param v128 v128) (result v128)
          (i16x8.eq
            (i16x8.relaxed_dot_i8x16_i7x16_s (local.get 0) (local.get 1))
            (i16x8.relaxed_dot_i8x16_i7x16_s (local.get 0) (local.get 1))))
    (func (export "i32x4.relaxed_dot_i8x16_i7x16_add_s_cmp") (param v128 v128 v128) (result v128)
          (i16x8.eq
            (i32x4.relaxed_dot_i8x16_i7x16_add_s (local.get 0) (local.get 1) (local.get 2))
            (i32x4.relaxed_dot_i8x16_i7x16_add_s (local.get 0) (local.get 1) (local.get 2))))
)

;; Simple values to ensure things are functional.
(assert_return (invoke "i16x8.relaxed_dot_i8x16_i7x16_s"
                       (v128.const i8x16 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
                       (v128.const i8x16 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15))
               (v128.const i16x8 1 13 41 85 145 221 313 421))

;; Test max and min i8 values;
(assert_return (invoke "i16x8.relaxed_dot_i8x16_i7x16_s"
                       (v128.const i8x16 -128 -128 127 127 0 0 0 0 0 0 0 0 0 0 0 0)
                       (v128.const i8x16 127 127 127 127 0 0 0 0 0 0 0 0 0 0 0 0))
               (v128.const i16x8 -32512 32258 0 0 0 0 0 0))

;; signed * unsigned   : -128 *  129 * 2 = -33,024 saturated to -32,768
;; signed * signed     : -128 * -127 * 2 =  32,512
(assert_return (invoke "i16x8.relaxed_dot_i8x16_i7x16_s"
                       (v128.const i8x16 -128 -128 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
                       (v128.const i8x16 -127 -127 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
               (either
                 (v128.const i16x8 -32768 0 0 0 0 0 0 0)
                 (v128.const i16x8  32512 0 0 0 0 0 0 0)))

;; Repeat 4 corner cases in both 64-bit halves (i16x8 lanes 0..3 and 4..7):
;;   lanes 0, 4 (a = -128, b = -128 or 128):
;;     signed * signed (wrapping)     : -128 * -128 * 2 =  32,768 wrapped to -32,768
;;     signed * unsigned (saturating) : -128 *  128 * 2 = -32,768 saturated to -32,768
;;   lanes 1, 5 (a = -128, b = -127 or 129):
;;     signed * signed (wrapping)     : -128 * -127 * 2 =  32,512
;;     signed * unsigned (saturating) : -128 *  129 * 2 = -33,024 saturated to -32,768
;;   lanes 2, 6 (a =  127, b = -128 or 128):
;;     signed * signed (wrapping)     :  127 * -128 * 2 = -32,512
;;     signed * unsigned (saturating) :  127 *  128 * 2 =  32,512
;;   lanes 3, 7 (a =  127, b =   -1 or 255):
;;     signed * signed (wrapping)     :  127 *   -1 * 2 =    -254
;;     signed * unsigned (saturating) :  127 *  255 * 2 =  64,770 saturated to  32,767
(assert_return (invoke "i16x8.relaxed_dot_i8x16_i7x16_s"
                       (v128.const i8x16 -128 -128 -128 -128  127  127 127 127 -128 -128 -128 -128  127  127 127 127)
                       (v128.const i8x16 -128 -128 -127 -127 -128 -128  -1  -1 -128 -128 -127 -127 -128 -128  -1  -1))
               (either
                 (v128.const i16x8 -32768  32512 -32512  -254 -32768  32512 -32512  -254)  ;; signed * signed, wrapping add (ARM NEON smull + smull2 + addp)
                 (v128.const i16x8 -32768 -32768  32512 32767 -32768 -32768  32512 32767))) ;; signed * unsigned, saturating add (x86-64 vpmaddubsw)

;; i16-intermediate overflow boundary. The existing cases above
;; pick byte values where the pair sum fits in i16 (e.g.
;; -128*-127*2 = 32512, within range). With a = b = -128 every
;; pair sum equals -128*-128 + -128*-128 = 32768, OUT of i16.
;; Per the spec the i16 lane is the relaxed truncation of that
;; pair sum, so for every interpretation the lane is either
;; -32768 (wrap) or 32767 (saturate).
;;
;; signed * signed wrap     : (int16)32768   = -32768
;; signed * signed saturate : clamp(32768)   =  32767
;; signed * unsigned (PMADDUBSW saturate)    : -128 *  128 * 2
;;                                           = -32768 saturated
;;                                           = -32768
;; unsigned * unsigned wrap : (int16)32768   = -32768
;; unsigned * unsigned sat  : clamp(32768)   =  32767
(assert_return (invoke "i16x8.relaxed_dot_i8x16_i7x16_s"
                       (v128.const i8x16 -128 -128 -128 -128 -128 -128 -128 -128
                                         -128 -128 -128 -128 -128 -128 -128 -128)
                       (v128.const i8x16 -128 -128 -128 -128 -128 -128 -128 -128
                                         -128 -128 -128 -128 -128 -128 -128 -128))
               (either
                 (v128.const i16x8 -32768 -32768 -32768 -32768 -32768 -32768 -32768 -32768)
                 (v128.const i16x8  32767  32767  32767  32767  32767  32767  32767  32767)))

;; Simple values to ensure things are functional.
(assert_return (invoke "i32x4.relaxed_dot_i8x16_i7x16_add_s"
                       (v128.const i8x16 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
                       (v128.const i8x16 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
                       (v128.const i32x4 0 1 2 3))
               ;; intermediate result is [14, 126, 366, 734]
               (v128.const i32x4 14 127 368 737))

;; Test max and min i8 values;
(assert_return (invoke "i32x4.relaxed_dot_i8x16_i7x16_add_s"
                       (v128.const i8x16 -128 -128 -128 -128 127 127 127 127 0 0 0 0 0 0 0 0)
                       (v128.const i8x16 127 127 127 127 127 127 127 127 0 0 0 0 0 0 0 0)
                       (v128.const i32x4 1 2 3 4))
               ;; intermediate result is [-65024, 64516, 0, 0]
               (v128.const i32x4 -65023 64518 3 4))

;; Test 4 corner cases in i32x4 lanes 0..3:
;;   lane 0 (a = -128, b = -128 or 128):
;;     signed * signed (16-bit wrapping)     : (-128 * -128 * 2 wrapped to -32,768) * 2 = -65,536 (+ 1)
;;     signed * unsigned (16-bit saturating) : (-128 *  128 * 2 = -32,768) * 2 = -65,536 (+ 1)
;;     signed * signed (32-bit)              : -128 * -128 * 4 =  65,536 (+ 1)
;;     signed * unsigned (32-bit)            : -128 *  128 * 4 = -65,536 (+ 1)
;;   lane 1 (a = -128, b = -127 or 129):
;;     signed * signed (16-bit wrapping)     : (-128 * -127 * 2 = 32,512) * 2 =  65,024 (+ 2)
;;     signed * unsigned (16-bit saturating) : (-128 *  129 * 2 = -33,024 saturated to -32,768) * 2 = -65,536 (+ 2)
;;     signed * signed (32-bit)              : -128 * -127 * 4 =  65,024 (+ 2)
;;     signed * unsigned (32-bit)            : -128 *  129 * 4 = -66,048 (+ 2)
;;   lane 2 (a =  127, b = -128 or 128):
;;     signed * signed (16-bit wrapping)     : (127 * -128 * 2 = -32,512) * 2 = -65,024 (+ 3)
;;     signed * unsigned (16-bit saturating) : (127 *  128 * 2 =  32,512) * 2 =  65,024 (+ 3)
;;     signed * signed (32-bit)              :  127 * -128 * 4 = -65,024 (+ 3)
;;     signed * unsigned (32-bit)            :  127 *  128 * 4 =  65,024 (+ 3)
;;   lane 3 (a =  127, b =   -1 or 255):
;;     signed * signed (16-bit wrapping)     : (127 *  -1 * 2 = -254) * 2 =   -508 (+ 4)
;;     signed * unsigned (16-bit saturating) : (127 * 255 * 2 = 64,770 saturated to 32,767) * 2 = 65,534 (+ 4)
;;     signed * signed (32-bit)              :  127 *  -1 * 4 =    -508 (+ 4)
;;     signed * unsigned (32-bit)            :  127 * 255 * 4 = 129,540 (+ 4)
(assert_return (invoke "i32x4.relaxed_dot_i8x16_i7x16_add_s"
                       (v128.const i8x16 -128 -128 -128 -128 -128 -128 -128 -128  127  127  127  127 127 127 127 127)
                       (v128.const i8x16 -128 -128 -128 -128 -127 -127 -127 -127 -128 -128 -128 -128  -1  -1  -1  -1)
                       (v128.const i32x4 1 2 3 4))
               (either
                 (v128.const i32x4 -65535  65026 -65021   -504)  ;; signed * signed, 16-bit wrapping add (ARM NEON smull + smull2 + addp + sadalp)
                 (v128.const i32x4 -65535 -65534  65027  65538)  ;; signed * unsigned, 16-bit saturating add (x86-64 vpmaddubsw + vpmaddwd + vpaddd)
                 (v128.const i32x4  65537  65026 -65021   -504)  ;; signed * signed, 32-bit add (ARM64 sdot, x86-64 vpdpbssd)
                 (v128.const i32x4 -65535 -66046  65027 129544))) ;; signed * unsigned, 32-bit add (x86-64 vpdpbusd)

;; i16-intermediate overflow boundary for the add variant. The
;; existing cases above all choose byte values where the i16
;; pair sum fits in i16 (e.g. -128*-127*2 = 32512, within range),
;; so an implementation that skips the i16 intermediate and sums
;; four byte products directly into i32 will produce the same
;; answer on those inputs and the bug stays hidden. With
;; a = b = -128 every pair sum is 32768, which overflows i16:
;;
;;   per pair:  wrap -> -32768   |   saturate ->  32767
;;
;; extadd_pairwise then sums the two pair-i16s into i32 (no
;; further overflow possible), and the final + c wraps in i32.
;; With c = 0 the spec-allowed i32 lane values are:
;;
;;   wrap+wrap = -65536       (PMADDUBSW + extadd, or s*s wrap, etc.)
;;   sat+sat   =  65534       (s*s with saturating intermediate)
;;   wrap+sat  =     -1
;;
;; A direct-byte-sum implementation (the bug shape, no i16
;; truncation point at all) produces 65536 per lane, which is
;; NOT in this set.
(assert_return (invoke "i32x4.relaxed_dot_i8x16_i7x16_add_s"
                       (v128.const i8x16 -128 -128 -128 -128 -128 -128 -128 -128
                                         -128 -128 -128 -128 -128 -128 -128 -128)
                       (v128.const i8x16 -128 -128 -128 -128 -128 -128 -128 -128
                                         -128 -128 -128 -128 -128 -128 -128 -128)
                       (v128.const i32x4 0 0 0 0))
               (either
                 (v128.const i32x4 -65536 -65536 -65536 -65536)
                 (v128.const i32x4     -1     -1     -1     -1)
                 (v128.const i32x4  65534  65534  65534  65534)))

;; Check that multiple calls to the relaxed instruction with same inputs returns same results.

;; Test max and min i8 values;
(assert_return (invoke "i16x8.relaxed_dot_i8x16_i7x16_s_cmp"
                       (v128.const i8x16 -128 -128 127 127 0 0 0 0 0 0 0 0 0 0 0 0)
                       (v128.const i8x16 127 127 127 127 0 0 0 0 0 0 0 0 0 0 0 0))
               (v128.const i16x8 -1 -1 -1 -1 -1 -1 -1 -1))

;; Test max and min i8 values;
(assert_return (invoke "i32x4.relaxed_dot_i8x16_i7x16_add_s_cmp"
                       (v128.const i8x16 -128 -128 -128 -128 127 127 127 127 0 0 0 0 0 0 0 0)
                       (v128.const i8x16 127 127 127 127 127 127 127 127 0 0 0 0 0 0 0 0)
                       (v128.const i32x4 1 2 3 4))
               ;; intermediate result is [-65024, 64516, 0, 0]
               (v128.const i32x4 -1 -1 -1 -1))

;; signed * unsigned   : -128 *  129 * 2 = -33,024 saturated to -32,768
;; signed * signed     : -128 * -127 * 2 =  32,512
(assert_return (invoke "i16x8.relaxed_dot_i8x16_i7x16_s_cmp"
                       (v128.const i8x16 -128 -128 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
                       (v128.const i8x16 -127 -127 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
               (v128.const i16x8 -1 -1 -1 -1 -1 -1 -1 -1))

;; signed * signed (16-bit wrapping or 32-bit) : -128 * -127 * 4 = 65,024 (+ 1)
;; signed * unsigned (16-bit saturating)       : (-128 * 129 * 2 = -33,024 saturated to -32,768) * 2 = -65,536 (+ 1)
;; signed * unsigned (32-bit)                  : -128 *  129 * 4 = -66,048 (+ 1)
(assert_return (invoke "i32x4.relaxed_dot_i8x16_i7x16_add_s_cmp"
                       (v128.const i8x16 -128 -128 -128 -128 0 0 0 0 0 0 0 0 0 0 0 0)
                       (v128.const i8x16 -127 -127 -127 -127 0 0 0 0 0 0 0 0 0 0 0 0)
                       (v128.const i32x4 1 2 3 4))
               (v128.const i32x4 -1 -1 -1 -1))

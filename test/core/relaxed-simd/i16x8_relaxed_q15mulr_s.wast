;; Tests for i16x8.relaxed_q15mulr_s.
(module
    (func (export "i16x8.relaxed_q15mulr_s") (param v128 v128) (result v128) (i16x8.relaxed_q15mulr_s (local.get 0) (local.get 1)))
)

;; INT16_MIN = -32768
(assert_return (invoke "i16x8.relaxed_q15mulr_s"
                       (v128.const i16x8 -32768 -32767 32767 0 0 0 0 0)
                       (v128.const i16x8 -32768 -32768 32767 0 0 0 0 0))
               ;; overflows, return either INT16_MIN or INT16_MAX
               (either (v128.const i16x8 -32768 32767 32766 0 0 0 0 0)
                       (v128.const i16x8 32767 32767 32766 0 0 0 0 0)))


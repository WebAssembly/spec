;; Test t.const instructions

;; Syntax error

(module (func (i32.const 0xffffffff) drop))
(module (func (i32.const -0x80000000) drop))
(assert_malformed
  (module quote "(func (i32.const 0x100000000) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (i32.const -0x80000001) drop)")
  "constant out of range"
)

(module (func (i32.const 4294967295) drop))
(module (func (i32.const -2147483648) drop))
(assert_malformed
  (module quote "(func (i32.const 4294967296) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (i32.const -2147483649) drop)")
  "constant out of range"
)

(module (func (i64.const 0xffffffffffffffff) drop))
(module (func (i64.const -0x8000000000000000) drop))
(assert_malformed
  (module quote "(func (i64.const 0x10000000000000000) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (i64.const -0x8000000000000001) drop)")
  "constant out of range"
)

(module (func (i64.const 18446744073709551615) drop))
(module (func (i64.const -9223372036854775808) drop))
(assert_malformed
  (module quote "(func (i64.const 18446744073709551616) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (i64.const -9223372036854775809) drop)")
  "constant out of range"
)

(module (func (f32.const 0x1p127) drop))
(module (func (f32.const -0x1p127) drop))
(module (func (f32.const 0x1.fffffep127) drop))
(module (func (f32.const -0x1.fffffep127) drop))
(module (func (f32.const 0x1.fffffe7p127) drop))
(module (func (f32.const -0x1.fffffe7p127) drop))
(module (func (f32.const 0x1.fffffefffffff8000000p127) drop))
(module (func (f32.const -0x1.fffffefffffff8000000p127) drop))
(module (func (f32.const 0x1.fffffefffffffffffffp127) drop))
(module (func (f32.const -0x1.fffffefffffffffffffp127) drop))
(assert_malformed
  (module quote "(func (f32.const 0x1p128) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (f32.const -0x1p128) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (f32.const 0x1.ffffffp127) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (f32.const -0x1.ffffffp127) drop)")
  "constant out of range"
)

(module (func (f32.const 1e38) drop))
(module (func (f32.const -1e38) drop))
(assert_malformed
  (module quote "(func (f32.const 1e39) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (f32.const -1e39) drop)")
  "constant out of range"
)

(module (func (f32.const 340282356779733623858607532500980858880) drop))
(module (func (f32.const -340282356779733623858607532500980858880) drop))
(assert_malformed
  (module quote "(func (f32.const 340282356779733661637539395458142568448) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (f32.const -340282356779733661637539395458142568448) drop)")
  "constant out of range"
)

(module (func (f64.const 0x1p1023) drop))
(module (func (f64.const -0x1p1023) drop))
(module (func (f64.const 0x1.fffffffffffffp1023) drop))
(module (func (f64.const -0x1.fffffffffffffp1023) drop))
(module (func (f64.const 0x1.fffffffffffff7p1023) drop))
(module (func (f64.const -0x1.fffffffffffff7p1023) drop))
(module (func (f64.const 0x1.fffffffffffff7ffffffp1023) drop))
(module (func (f64.const -0x1.fffffffffffff7ffffffp1023) drop))
(assert_malformed
  (module quote "(func (f64.const 0x1p1024) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (f64.const -0x1p1024) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (f64.const 0x1.fffffffffffff8p1023) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (f64.const -0x1.fffffffffffff8p1023) drop)")
  "constant out of range"
)

(module (func (f64.const 1e308) drop))
(module (func (f64.const -1e308) drop))
(assert_malformed
  (module quote "(func (f64.const 1e309) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (f64.const -1e309) drop)")
  "constant out of range"
)

(module (func (f64.const 179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368) drop))
(module (func (f64.const -179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368) drop))
(assert_malformed
  (module quote "(func (f64.const 269653970229347356221791135597556535197105851288767494898376215204735891170042808140884337949150317257310688430271573696351481990334196274152701320055306275479074865864826923114368235135583993416113802762682700913456874855354834422248712838998185022412196739306217084753107265771378949821875606039276187287552) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (f64.const -269653970229347356221791135597556535197105851288767494898376215204735891170042808140884337949150317257310688430271573696351481990334196274152701320055306275479074865864826923114368235135583993416113802762682700913456874855354834422248712838998185022412196739306217084753107265771378949821875606039276187287552) drop)")
  "constant out of range"
)


;; Rounding behaviour

(module (func (export "f32") (param f32) (result f32) (local.get 0)))

;; Small exponent
(assert_return (invoke "f32" (f32.const +0x1.00000100000000000p-50)) (f32.const +0x1.000000p-50))
(assert_return (invoke "f32" (f32.const -0x1.00000100000000000p-50)) (f32.const -0x1.000000p-50))

(assert_return (invoke "f32" (f32.const +0x1.00000100000000001p-50)) (f32.const +0x1.000002p-50))
(assert_return (invoke "f32" (f32.const -0x1.00000100000000001p-50)) (f32.const -0x1.000002p-50))
(assert_return (invoke "f32" (f32.const +0x1.000001fffffffffffp-50)) (f32.const +0x1.000002p-50))
(assert_return (invoke "f32" (f32.const -0x1.000001fffffffffffp-50)) (f32.const -0x1.000002p-50))
(assert_return (invoke "f32" (f32.const +0x1.00000200000000000p-50)) (f32.const +0x1.000002p-50))
(assert_return (invoke "f32" (f32.const -0x1.00000200000000000p-50)) (f32.const -0x1.000002p-50))
(assert_return (invoke "f32" (f32.const +0x1.00000200000000001p-50)) (f32.const +0x1.000002p-50))
(assert_return (invoke "f32" (f32.const -0x1.00000200000000001p-50)) (f32.const -0x1.000002p-50))
(assert_return (invoke "f32" (f32.const +0x1.000002fffffffffffp-50)) (f32.const +0x1.000002p-50))
(assert_return (invoke "f32" (f32.const -0x1.000002fffffffffffp-50)) (f32.const -0x1.000002p-50))

(assert_return (invoke "f32" (f32.const +0x1.00000300000000000p-50)) (f32.const +0x1.000004p-50))
(assert_return (invoke "f32" (f32.const -0x1.00000300000000000p-50)) (f32.const -0x1.000004p-50))
(assert_return (invoke "f32" (f32.const +0x1.00000300000000001p-50)) (f32.const +0x1.000004p-50))
(assert_return (invoke "f32" (f32.const -0x1.00000300000000001p-50)) (f32.const -0x1.000004p-50))
(assert_return (invoke "f32" (f32.const +0x1.000003fffffffffffp-50)) (f32.const +0x1.000004p-50))
(assert_return (invoke "f32" (f32.const -0x1.000003fffffffffffp-50)) (f32.const -0x1.000004p-50))
(assert_return (invoke "f32" (f32.const +0x1.00000400000000000p-50)) (f32.const +0x1.000004p-50))
(assert_return (invoke "f32" (f32.const -0x1.00000400000000000p-50)) (f32.const -0x1.000004p-50))
(assert_return (invoke "f32" (f32.const +0x1.00000400000000001p-50)) (f32.const +0x1.000004p-50))
(assert_return (invoke "f32" (f32.const -0x1.00000400000000001p-50)) (f32.const -0x1.000004p-50))
(assert_return (invoke "f32" (f32.const +0x1.000004fffffffffffp-50)) (f32.const +0x1.000004p-50))
(assert_return (invoke "f32" (f32.const -0x1.000004fffffffffffp-50)) (f32.const -0x1.000004p-50))
(assert_return (invoke "f32" (f32.const +0x1.00000500000000000p-50)) (f32.const +0x1.000004p-50))
(assert_return (invoke "f32" (f32.const -0x1.00000500000000000p-50)) (f32.const -0x1.000004p-50))

(assert_return (invoke "f32" (f32.const +0x1.00000500000000001p-50)) (f32.const +0x1.000006p-50))
(assert_return (invoke "f32" (f32.const -0x1.00000500000000001p-50)) (f32.const -0x1.000006p-50))

;; Large exponent
(assert_return (invoke "f32" (f32.const +0x1.00000100000000000p+50)) (f32.const +0x1.000000p+50))
(assert_return (invoke "f32" (f32.const -0x1.00000100000000000p+50)) (f32.const -0x1.000000p+50))

(assert_return (invoke "f32" (f32.const +0x1.00000100000000001p+50)) (f32.const +0x1.000002p+50))
(assert_return (invoke "f32" (f32.const -0x1.00000100000000001p+50)) (f32.const -0x1.000002p+50))
(assert_return (invoke "f32" (f32.const +0x1.000001fffffffffffp+50)) (f32.const +0x1.000002p+50))
(assert_return (invoke "f32" (f32.const -0x1.000001fffffffffffp+50)) (f32.const -0x1.000002p+50))
(assert_return (invoke "f32" (f32.const +0x1.00000200000000000p+50)) (f32.const +0x1.000002p+50))
(assert_return (invoke "f32" (f32.const -0x1.00000200000000000p+50)) (f32.const -0x1.000002p+50))
(assert_return (invoke "f32" (f32.const +0x1.00000200000000001p+50)) (f32.const +0x1.000002p+50))
(assert_return (invoke "f32" (f32.const -0x1.00000200000000001p+50)) (f32.const -0x1.000002p+50))
(assert_return (invoke "f32" (f32.const +0x1.000002fffffffffffp+50)) (f32.const +0x1.000002p+50))
(assert_return (invoke "f32" (f32.const -0x1.000002fffffffffffp+50)) (f32.const -0x1.000002p+50))

(assert_return (invoke "f32" (f32.const +0x1.00000300000000000p+50)) (f32.const +0x1.000004p+50))
(assert_return (invoke "f32" (f32.const -0x1.00000300000000000p+50)) (f32.const -0x1.000004p+50))
(assert_return (invoke "f32" (f32.const +0x1.00000300000000001p+50)) (f32.const +0x1.000004p+50))
(assert_return (invoke "f32" (f32.const -0x1.00000300000000001p+50)) (f32.const -0x1.000004p+50))
(assert_return (invoke "f32" (f32.const +0x1.000003fffffffffffp+50)) (f32.const +0x1.000004p+50))
(assert_return (invoke "f32" (f32.const -0x1.000003fffffffffffp+50)) (f32.const -0x1.000004p+50))
(assert_return (invoke "f32" (f32.const +0x1.00000400000000000p+50)) (f32.const +0x1.000004p+50))
(assert_return (invoke "f32" (f32.const -0x1.00000400000000000p+50)) (f32.const -0x1.000004p+50))
(assert_return (invoke "f32" (f32.const +0x1.00000400000000001p+50)) (f32.const +0x1.000004p+50))
(assert_return (invoke "f32" (f32.const -0x1.00000400000000001p+50)) (f32.const -0x1.000004p+50))
(assert_return (invoke "f32" (f32.const +0x1.000004fffffffffffp+50)) (f32.const +0x1.000004p+50))
(assert_return (invoke "f32" (f32.const -0x1.000004fffffffffffp+50)) (f32.const -0x1.000004p+50))
(assert_return (invoke "f32" (f32.const +0x1.00000500000000000p+50)) (f32.const +0x1.000004p+50))
(assert_return (invoke "f32" (f32.const -0x1.00000500000000000p+50)) (f32.const -0x1.000004p+50))

(assert_return (invoke "f32" (f32.const +0x1.00000500000000001p+50)) (f32.const +0x1.000006p+50))
(assert_return (invoke "f32" (f32.const -0x1.00000500000000001p+50)) (f32.const -0x1.000006p+50))

;; Subnormal
(assert_return (invoke "f32" (f32.const +0x0.00000100000000000p-126)) (f32.const +0x0.000000p-126))
(assert_return (invoke "f32" (f32.const -0x0.00000100000000000p-126)) (f32.const -0x0.000000p-126))

(assert_return (invoke "f32" (f32.const +0x0.00000100000000001p-126)) (f32.const +0x0.000002p-126))
(assert_return (invoke "f32" (f32.const -0x0.00000100000000001p-126)) (f32.const -0x0.000002p-126))
(assert_return (invoke "f32" (f32.const +0x0.000001fffffffffffp-126)) (f32.const +0x0.000002p-126))
(assert_return (invoke "f32" (f32.const -0x0.000001fffffffffffp-126)) (f32.const -0x0.000002p-126))
(assert_return (invoke "f32" (f32.const +0x0.00000200000000000p-126)) (f32.const +0x0.000002p-126))
(assert_return (invoke "f32" (f32.const -0x0.00000200000000000p-126)) (f32.const -0x0.000002p-126))
(assert_return (invoke "f32" (f32.const +0x0.00000200000000001p-126)) (f32.const +0x0.000002p-126))
(assert_return (invoke "f32" (f32.const -0x0.00000200000000001p-126)) (f32.const -0x0.000002p-126))
(assert_return (invoke "f32" (f32.const +0x0.000002fffffffffffp-126)) (f32.const +0x0.000002p-126))
(assert_return (invoke "f32" (f32.const -0x0.000002fffffffffffp-126)) (f32.const -0x0.000002p-126))

(assert_return (invoke "f32" (f32.const +0x0.00000300000000000p-126)) (f32.const +0x0.000004p-126))
(assert_return (invoke "f32" (f32.const -0x0.00000300000000000p-126)) (f32.const -0x0.000004p-126))
(assert_return (invoke "f32" (f32.const +0x0.00000300000000001p-126)) (f32.const +0x0.000004p-126))
(assert_return (invoke "f32" (f32.const -0x0.00000300000000001p-126)) (f32.const -0x0.000004p-126))
(assert_return (invoke "f32" (f32.const +0x0.000003fffffffffffp-126)) (f32.const +0x0.000004p-126))
(assert_return (invoke "f32" (f32.const -0x0.000003fffffffffffp-126)) (f32.const -0x0.000004p-126))
(assert_return (invoke "f32" (f32.const +0x0.00000400000000000p-126)) (f32.const +0x0.000004p-126))
(assert_return (invoke "f32" (f32.const -0x0.00000400000000000p-126)) (f32.const -0x0.000004p-126))
(assert_return (invoke "f32" (f32.const +0x0.00000400000000001p-126)) (f32.const +0x0.000004p-126))
(assert_return (invoke "f32" (f32.const -0x0.00000400000000001p-126)) (f32.const -0x0.000004p-126))
(assert_return (invoke "f32" (f32.const +0x0.000004fffffffffffp-126)) (f32.const +0x0.000004p-126))
(assert_return (invoke "f32" (f32.const -0x0.000004fffffffffffp-126)) (f32.const -0x0.000004p-126))
(assert_return (invoke "f32" (f32.const +0x0.00000500000000000p-126)) (f32.const +0x0.000004p-126))
(assert_return (invoke "f32" (f32.const -0x0.00000500000000000p-126)) (f32.const -0x0.000004p-126))

(assert_return (invoke "f32" (f32.const +0x0.00000500000000001p-126)) (f32.const +0x0.000006p-126))
(assert_return (invoke "f32" (f32.const -0x0.00000500000000001p-126)) (f32.const -0x0.000006p-126))

;; Round down at limit to infinity
(assert_return (invoke "f32" (f32.const +0x1.fffffe8p127)) (f32.const +0x1.fffffep127))
(assert_return (invoke "f32" (f32.const -0x1.fffffe8p127)) (f32.const -0x1.fffffep127))
(assert_return (invoke "f32" (f32.const +0x1.fffffefffffff8p127)) (f32.const +0x1.fffffep127))
(assert_return (invoke "f32" (f32.const -0x1.fffffefffffff8p127)) (f32.const -0x1.fffffep127))
(assert_return (invoke "f32" (f32.const +0x1.fffffefffffffffffp127)) (f32.const +0x1.fffffep127))
(assert_return (invoke "f32" (f32.const -0x1.fffffefffffffffffp127)) (f32.const -0x1.fffffep127))


(module (func (export "f64") (param f64) (result f64) (local.get 0)))

;; Small exponent
(assert_return (invoke "f64" (f64.const +0x1.000000000000080000000000p-600)) (f64.const +0x1.0000000000000p-600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000080000000000p-600)) (f64.const -0x1.0000000000000p-600))

(assert_return (invoke "f64" (f64.const +0x1.000000000000080000000001p-600)) (f64.const +0x1.0000000000001p-600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000080000000001p-600)) (f64.const -0x1.0000000000001p-600))
(assert_return (invoke "f64" (f64.const +0x1.0000000000000fffffffffffp-600)) (f64.const +0x1.0000000000001p-600))
(assert_return (invoke "f64" (f64.const -0x1.0000000000000fffffffffffp-600)) (f64.const -0x1.0000000000001p-600))
(assert_return (invoke "f64" (f64.const +0x1.000000000000100000000000p-600)) (f64.const +0x1.0000000000001p-600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000100000000000p-600)) (f64.const -0x1.0000000000001p-600))
(assert_return (invoke "f64" (f64.const +0x1.000000000000100000000001p-600)) (f64.const +0x1.0000000000001p-600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000100000000001p-600)) (f64.const -0x1.0000000000001p-600))
(assert_return (invoke "f64" (f64.const +0x1.00000000000017ffffffffffp-600)) (f64.const +0x1.0000000000001p-600))
(assert_return (invoke "f64" (f64.const -0x1.00000000000017ffffffffffp-600)) (f64.const -0x1.0000000000001p-600))

(assert_return (invoke "f64" (f64.const +0x1.000000000000180000000000p-600)) (f64.const +0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000180000000000p-600)) (f64.const -0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const +0x1.000000000000180000000001p-600)) (f64.const +0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000180000000001p-600)) (f64.const -0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const +0x1.0000000000001fffffffffffp-600)) (f64.const +0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const -0x1.0000000000001fffffffffffp-600)) (f64.const -0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const +0x1.000000000000200000000000p-600)) (f64.const +0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000200000000000p-600)) (f64.const -0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const +0x1.000000000000200000000001p-600)) (f64.const +0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000200000000001p-600)) (f64.const -0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const +0x1.00000000000027ffffffffffp-600)) (f64.const +0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const -0x1.00000000000027ffffffffffp-600)) (f64.const -0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const +0x1.000000000000200000000000p-600)) (f64.const +0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000200000000000p-600)) (f64.const -0x1.0000000000002p-600))

(assert_return (invoke "f64" (f64.const +0x1.000000000000280000000001p-600)) (f64.const +0x1.0000000000003p-600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000280000000001p-600)) (f64.const -0x1.0000000000003p-600))

;; Large exponent
(assert_return (invoke "f64" (f64.const +0x1.000000000000080000000000p+600)) (f64.const +0x1.0000000000000p+600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000080000000000p+600)) (f64.const -0x1.0000000000000p+600))

(assert_return (invoke "f64" (f64.const +0x1.000000000000080000000001p+600)) (f64.const +0x1.0000000000001p+600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000080000000001p+600)) (f64.const -0x1.0000000000001p+600))
(assert_return (invoke "f64" (f64.const +0x1.0000000000000fffffffffffp+600)) (f64.const +0x1.0000000000001p+600))
(assert_return (invoke "f64" (f64.const -0x1.0000000000000fffffffffffp+600)) (f64.const -0x1.0000000000001p+600))
(assert_return (invoke "f64" (f64.const +0x1.000000000000100000000000p+600)) (f64.const +0x1.0000000000001p+600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000100000000000p+600)) (f64.const -0x1.0000000000001p+600))
(assert_return (invoke "f64" (f64.const +0x1.000000000000100000000001p+600)) (f64.const +0x1.0000000000001p+600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000100000000001p+600)) (f64.const -0x1.0000000000001p+600))
(assert_return (invoke "f64" (f64.const +0x1.00000000000017ffffffffffp+600)) (f64.const +0x1.0000000000001p+600))
(assert_return (invoke "f64" (f64.const -0x1.00000000000017ffffffffffp+600)) (f64.const -0x1.0000000000001p+600))

(assert_return (invoke "f64" (f64.const +0x1.000000000000180000000000p+600)) (f64.const +0x1.0000000000002p+600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000180000000000p+600)) (f64.const -0x1.0000000000002p+600))
(assert_return (invoke "f64" (f64.const +0x1.000000000000180000000001p+600)) (f64.const +0x1.0000000000002p+600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000180000000001p+600)) (f64.const -0x1.0000000000002p+600))
(assert_return (invoke "f64" (f64.const +0x1.0000000000001fffffffffffp+600)) (f64.const +0x1.0000000000002p+600))
(assert_return (invoke "f64" (f64.const -0x1.0000000000001fffffffffffp+600)) (f64.const -0x1.0000000000002p+600))
(assert_return (invoke "f64" (f64.const +0x1.000000000000200000000000p+600)) (f64.const +0x1.0000000000002p+600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000200000000000p+600)) (f64.const -0x1.0000000000002p+600))
(assert_return (invoke "f64" (f64.const +0x1.000000000000200000000001p+600)) (f64.const +0x1.0000000000002p+600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000200000000001p+600)) (f64.const -0x1.0000000000002p+600))
(assert_return (invoke "f64" (f64.const +0x1.00000000000027ffffffffffp+600)) (f64.const +0x1.0000000000002p+600))
(assert_return (invoke "f64" (f64.const -0x1.00000000000027ffffffffffp+600)) (f64.const -0x1.0000000000002p+600))
(assert_return (invoke "f64" (f64.const +0x1.000000000000280000000000p+600)) (f64.const +0x1.0000000000002p+600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000280000000000p+600)) (f64.const -0x1.0000000000002p+600))

(assert_return (invoke "f64" (f64.const +0x1.000000000000280000000001p+600)) (f64.const +0x1.0000000000003p+600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000280000000001p+600)) (f64.const -0x1.0000000000003p+600))

;; Subnormal
(assert_return (invoke "f64" (f64.const +0x0.000000000000080000000000p-1022)) (f64.const +0x0.0000000000000p-1022))
(assert_return (invoke "f64" (f64.const -0x0.000000000000080000000000p-1022)) (f64.const -0x0.0000000000000p-1022))

(assert_return (invoke "f64" (f64.const +0x0.000000000000080000000001p-1022)) (f64.const +0x0.0000000000001p-1022))
(assert_return (invoke "f64" (f64.const -0x0.000000000000080000000001p-1022)) (f64.const -0x0.0000000000001p-1022))
(assert_return (invoke "f64" (f64.const +0x0.0000000000000fffffffffffp-1022)) (f64.const +0x0.0000000000001p-1022))
(assert_return (invoke "f64" (f64.const -0x0.0000000000000fffffffffffp-1022)) (f64.const -0x0.0000000000001p-1022))
(assert_return (invoke "f64" (f64.const +0x0.000000000000100000000000p-1022)) (f64.const +0x0.0000000000001p-1022))
(assert_return (invoke "f64" (f64.const -0x0.000000000000100000000000p-1022)) (f64.const -0x0.0000000000001p-1022))
(assert_return (invoke "f64" (f64.const +0x0.000000000000100000000001p-1022)) (f64.const +0x0.0000000000001p-1022))
(assert_return (invoke "f64" (f64.const -0x0.000000000000100000000001p-1022)) (f64.const -0x0.0000000000001p-1022))
(assert_return (invoke "f64" (f64.const +0x0.00000000000017ffffffffffp-1022)) (f64.const +0x0.0000000000001p-1022))
(assert_return (invoke "f64" (f64.const -0x0.00000000000017ffffffffffp-1022)) (f64.const -0x0.0000000000001p-1022))

(assert_return (invoke "f64" (f64.const +0x0.000000000000180000000000p-1022)) (f64.const +0x0.0000000000002p-1022))
(assert_return (invoke "f64" (f64.const -0x0.000000000000180000000000p-1022)) (f64.const -0x0.0000000000002p-1022))
(assert_return (invoke "f64" (f64.const +0x0.000000000000180000000001p-1022)) (f64.const +0x0.0000000000002p-1022))
(assert_return (invoke "f64" (f64.const -0x0.000000000000180000000001p-1022)) (f64.const -0x0.0000000000002p-1022))
(assert_return (invoke "f64" (f64.const +0x0.0000000000001fffffffffffp-1022)) (f64.const +0x0.0000000000002p-1022))
(assert_return (invoke "f64" (f64.const -0x0.0000000000001fffffffffffp-1022)) (f64.const -0x0.0000000000002p-1022))
(assert_return (invoke "f64" (f64.const +0x0.000000000000200000000000p-1022)) (f64.const +0x0.0000000000002p-1022))
(assert_return (invoke "f64" (f64.const -0x0.000000000000200000000000p-1022)) (f64.const -0x0.0000000000002p-1022))
(assert_return (invoke "f64" (f64.const +0x0.000000000000200000000001p-1022)) (f64.const +0x0.0000000000002p-1022))
(assert_return (invoke "f64" (f64.const -0x0.000000000000200000000001p-1022)) (f64.const -0x0.0000000000002p-1022))
(assert_return (invoke "f64" (f64.const +0x0.00000000000027ffffffffffp-1022)) (f64.const +0x0.0000000000002p-1022))
(assert_return (invoke "f64" (f64.const -0x0.00000000000027ffffffffffp-1022)) (f64.const -0x0.0000000000002p-1022))
(assert_return (invoke "f64" (f64.const +0x0.000000000000280000000000p-1022)) (f64.const +0x0.0000000000002p-1022))
(assert_return (invoke "f64" (f64.const -0x0.000000000000280000000000p-1022)) (f64.const -0x0.0000000000002p-1022))

(assert_return (invoke "f64" (f64.const +0x1.000000000000280000000001p-1022)) (f64.const +0x1.0000000000003p-1022))
(assert_return (invoke "f64" (f64.const -0x1.000000000000280000000001p-1022)) (f64.const -0x1.0000000000003p-1022))

;; Round down at limit to infinity
(assert_return (invoke "f64" (f64.const +0x1.fffffffffffff4p1023)) (f64.const +0x1.fffffffffffffp1023))
(assert_return (invoke "f64" (f64.const -0x1.fffffffffffff4p1023)) (f64.const -0x1.fffffffffffffp1023))
(assert_return (invoke "f64" (f64.const +0x1.fffffffffffff7ffffffp1023)) (f64.const +0x1.fffffffffffffp1023))
(assert_return (invoke "f64" (f64.const -0x1.fffffffffffff7ffffffp1023)) (f64.const -0x1.fffffffffffffp1023))

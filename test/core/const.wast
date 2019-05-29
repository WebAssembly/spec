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

(module (func (f32.const nan:0x1) drop))
(module (func (f64.const nan:0x1) drop))
(module (func (f32.const nan:0x7f_ffff) drop))
(module (func (f64.const nan:0xf_ffff_ffff_ffff) drop))

(assert_malformed
  (module quote "(func (f32.const nan:1) drop)")
  "unknown operator"
)
(assert_malformed
  (module quote "(func (f64.const nan:1) drop)")
  "unknown operator"
)

(assert_malformed
  (module quote "(func (f32.const nan:0x0) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (f64.const nan:0x0) drop)")
  "constant out of range"
)

(assert_malformed
  (module quote "(func (f32.const nan:0x80_0000) drop)")
  "constant out of range"
)
(assert_malformed
  (module quote "(func (f64.const nan:0x10_0000_0000_0000) drop)")
  "constant out of range"
)


;; Signs on special values

(module
  (func (export "f32") (param f32) (result i32)
    (i32.reinterpret_f32 (local.get 0))
  )
  (func (export "f64") (param f64) (result i64)
    (i64.reinterpret_f64 (local.get 0))
  )
)

(assert_return (invoke "f32" (f32.const 0)) (i32.const 0x0000_0000))
(assert_return (invoke "f32" (f32.const +0)) (i32.const 0x0000_0000))
(assert_return (invoke "f32" (f32.const -0)) (i32.const 0x8000_0000))

(assert_return (invoke "f64" (f64.const 0)) (i64.const 0x0000_0000_0000_0000))
(assert_return (invoke "f64" (f64.const +0)) (i64.const 0x0000_0000_0000_0000))
(assert_return (invoke "f64" (f64.const -0)) (i64.const 0x8000_0000_0000_0000))

(assert_return (invoke "f32" (f32.const inf)) (i32.const 0x7f80_0000))
(assert_return (invoke "f32" (f32.const +inf)) (i32.const 0x7f80_0000))
(assert_return (invoke "f32" (f32.const -inf)) (i32.const 0xff80_0000))

(assert_return (invoke "f64" (f64.const inf)) (i64.const 0x7ff0_0000_0000_0000))
(assert_return (invoke "f64" (f64.const +inf)) (i64.const 0x7ff0_0000_0000_0000))
(assert_return (invoke "f64" (f64.const -inf)) (i64.const 0xfff0_0000_0000_0000))

(assert_return (invoke "f32" (f32.const nan)) (i32.const 0x7fc0_0000))
(assert_return (invoke "f32" (f32.const +nan)) (i32.const 0x7fc0_0000))
(assert_return (invoke "f32" (f32.const -nan)) (i32.const 0xffc0_0000))

(assert_return (invoke "f64" (f64.const nan)) (i64.const 0x7ff8_0000_0000_0000))
(assert_return (invoke "f64" (f64.const +nan)) (i64.const 0x7ff8_0000_0000_0000))
(assert_return (invoke "f64" (f64.const -nan)) (i64.const 0xfff8_0000_0000_0000))

(assert_return (invoke "f32" (f32.const nan:0x12_3456)) (i32.const 0x7f92_3456))
(assert_return (invoke "f32" (f32.const +nan:0x12_3456)) (i32.const 0x7f92_3456))
(assert_return (invoke "f32" (f32.const -nan:0x12_3456)) (i32.const 0xff92_3456))

(assert_return (invoke "f64" (f64.const nan:0x1_2345_6789_abcd)) (i64.const 0x7ff1_2345_6789_abcd))
(assert_return (invoke "f64" (f64.const +nan:0x1_2345_6789_abcd)) (i64.const 0x7ff1_2345_6789_abcd))
(assert_return (invoke "f64" (f64.const -nan:0x1_2345_6789_abcd)) (i64.const 0xfff1_2345_6789_abcd))


;; Rounding behaviour

(module
  (func (export "f32") (param f32) (result f32) (local.get 0))
  (func (export "f64") (param f64) (result f64) (local.get 0))
)

;; f32, small exponent
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

(assert_return (invoke "f32" (f32.const +0x4000.004000000p-64)) (f32.const +0x1.000000p-50))
(assert_return (invoke "f32" (f32.const -0x4000.004000000p-64)) (f32.const -0x1.000000p-50))
(assert_return (invoke "f32" (f32.const +0x4000.004000001p-64)) (f32.const +0x1.000002p-50))
(assert_return (invoke "f32" (f32.const -0x4000.004000001p-64)) (f32.const -0x1.000002p-50))
(assert_return (invoke "f32" (f32.const +0x4000.007ffffffp-64)) (f32.const +0x1.000002p-50))
(assert_return (invoke "f32" (f32.const -0x4000.007ffffffp-64)) (f32.const -0x1.000002p-50))
(assert_return (invoke "f32" (f32.const +0x4000.008000000p-64)) (f32.const +0x1.000002p-50))
(assert_return (invoke "f32" (f32.const -0x4000.008000000p-64)) (f32.const -0x1.000002p-50))
(assert_return (invoke "f32" (f32.const +0x4000.008000001p-64)) (f32.const +0x1.000002p-50))
(assert_return (invoke "f32" (f32.const -0x4000.008000001p-64)) (f32.const -0x1.000002p-50))
(assert_return (invoke "f32" (f32.const +0x4000.00bffffffp-64)) (f32.const +0x1.000002p-50))
(assert_return (invoke "f32" (f32.const -0x4000.00bffffffp-64)) (f32.const -0x1.000002p-50))
(assert_return (invoke "f32" (f32.const +0x4000.00c000000p-64)) (f32.const +0x1.000004p-50))
(assert_return (invoke "f32" (f32.const -0x4000.00c000000p-64)) (f32.const -0x1.000004p-50))
(assert_return (invoke "f32" (f32.const +0x4000.00c000001p-64)) (f32.const +0x1.000004p-50))
(assert_return (invoke "f32" (f32.const -0x4000.00c000001p-64)) (f32.const -0x1.000004p-50))
(assert_return (invoke "f32" (f32.const +0x4000.00fffffffp-64)) (f32.const +0x1.000004p-50))
(assert_return (invoke "f32" (f32.const -0x4000.00fffffffp-64)) (f32.const -0x1.000004p-50))
(assert_return (invoke "f32" (f32.const +0x4000.010000001p-64)) (f32.const +0x1.000004p-50))
(assert_return (invoke "f32" (f32.const -0x4000.010000001p-64)) (f32.const -0x1.000004p-50))
(assert_return (invoke "f32" (f32.const +0x4000.013ffffffp-64)) (f32.const +0x1.000004p-50))
(assert_return (invoke "f32" (f32.const -0x4000.013ffffffp-64)) (f32.const -0x1.000004p-50))
(assert_return (invoke "f32" (f32.const +0x4000.014000001p-64)) (f32.const +0x1.000006p-50))
(assert_return (invoke "f32" (f32.const -0x4000.014000001p-64)) (f32.const -0x1.000006p-50))

(assert_return (invoke "f32" (f32.const +8.8817847263968443573e-16)) (f32.const +0x1.000000p-50))
(assert_return (invoke "f32" (f32.const -8.8817847263968443573e-16)) (f32.const -0x1.000000p-50))
(assert_return (invoke "f32" (f32.const +8.8817847263968443574e-16)) (f32.const +0x1.000002p-50))
(assert_return (invoke "f32" (f32.const -8.8817847263968443574e-16)) (f32.const -0x1.000002p-50))
(assert_return (invoke "f32" (f32.const +8.8817857851880284252e-16)) (f32.const +0x1.000002p-50))
(assert_return (invoke "f32" (f32.const -8.8817857851880284252e-16)) (f32.const -0x1.000002p-50))
(assert_return (invoke "f32" (f32.const +8.8817857851880284253e-16)) (f32.const +0x1.000004p-50))
(assert_return (invoke "f32" (f32.const -8.8817857851880284253e-16)) (f32.const -0x1.000004p-50))

;; f32, large exponent
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

(assert_return (invoke "f32" (f32.const +0x4000004000000)) (f32.const +0x1.000000p+50))
(assert_return (invoke "f32" (f32.const -0x4000004000000)) (f32.const -0x1.000000p+50))
(assert_return (invoke "f32" (f32.const +0x4000004000001)) (f32.const +0x1.000002p+50))
(assert_return (invoke "f32" (f32.const -0x4000004000001)) (f32.const -0x1.000002p+50))
(assert_return (invoke "f32" (f32.const +0x4000007ffffff)) (f32.const +0x1.000002p+50))
(assert_return (invoke "f32" (f32.const -0x4000007ffffff)) (f32.const -0x1.000002p+50))
(assert_return (invoke "f32" (f32.const +0x4000008000000)) (f32.const +0x1.000002p+50))
(assert_return (invoke "f32" (f32.const -0x4000008000000)) (f32.const -0x1.000002p+50))
(assert_return (invoke "f32" (f32.const +0x4000008000001)) (f32.const +0x1.000002p+50))
(assert_return (invoke "f32" (f32.const -0x4000008000001)) (f32.const -0x1.000002p+50))
(assert_return (invoke "f32" (f32.const +0x400000bffffff)) (f32.const +0x1.000002p+50))
(assert_return (invoke "f32" (f32.const -0x400000bffffff)) (f32.const -0x1.000002p+50))
(assert_return (invoke "f32" (f32.const +0x400000c000000)) (f32.const +0x1.000004p+50))
(assert_return (invoke "f32" (f32.const -0x400000c000000)) (f32.const -0x1.000004p+50))

(assert_return (invoke "f32" (f32.const +1125899973951488)) (f32.const +0x1.000000p+50))
(assert_return (invoke "f32" (f32.const -1125899973951488)) (f32.const -0x1.000000p+50))
(assert_return (invoke "f32" (f32.const +1125899973951489)) (f32.const +0x1.000002p+50))
(assert_return (invoke "f32" (f32.const -1125899973951489)) (f32.const -0x1.000002p+50))
(assert_return (invoke "f32" (f32.const +1125900108169215)) (f32.const +0x1.000002p+50))
(assert_return (invoke "f32" (f32.const -1125900108169215)) (f32.const -0x1.000002p+50))
(assert_return (invoke "f32" (f32.const +1125900108169216)) (f32.const +0x1.000004p+50))
(assert_return (invoke "f32" (f32.const -1125900108169216)) (f32.const -0x1.000004p+50))

;; f32, subnormal
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

;; f32, round down at limit to infinity
(assert_return (invoke "f32" (f32.const +0x1.fffffe8p127)) (f32.const +0x1.fffffep127))
(assert_return (invoke "f32" (f32.const -0x1.fffffe8p127)) (f32.const -0x1.fffffep127))
(assert_return (invoke "f32" (f32.const +0x1.fffffefffffff8p127)) (f32.const +0x1.fffffep127))
(assert_return (invoke "f32" (f32.const -0x1.fffffefffffff8p127)) (f32.const -0x1.fffffep127))
(assert_return (invoke "f32" (f32.const +0x1.fffffefffffffffffp127)) (f32.const +0x1.fffffep127))
(assert_return (invoke "f32" (f32.const -0x1.fffffefffffffffffp127)) (f32.const -0x1.fffffep127))

;; f64, small exponent
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
(assert_return (invoke "f64" (f64.const +0x1.000000000000280000000001p-600)) (f64.const +0x1.0000000000003p-600))
(assert_return (invoke "f64" (f64.const -0x1.000000000000280000000001p-600)) (f64.const -0x1.0000000000003p-600))

(assert_return (invoke "f64" (f64.const +0x8000000.000000400000000000p-627)) (f64.const +0x1.0000000000000p-600))
(assert_return (invoke "f64" (f64.const -0x8000000.000000400000000000p-627)) (f64.const -0x1.0000000000000p-600))
(assert_return (invoke "f64" (f64.const +0x8000000.000000400000000001p-627)) (f64.const +0x1.0000000000001p-600))
(assert_return (invoke "f64" (f64.const -0x8000000.000000400000000001p-627)) (f64.const -0x1.0000000000001p-600))
(assert_return (invoke "f64" (f64.const +0x8000000.0000007fffffffffffp-627)) (f64.const +0x1.0000000000001p-600))
(assert_return (invoke "f64" (f64.const -0x8000000.0000007fffffffffffp-627)) (f64.const -0x1.0000000000001p-600))
(assert_return (invoke "f64" (f64.const +0x8000000.000000800000000000p-627)) (f64.const +0x1.0000000000001p-600))
(assert_return (invoke "f64" (f64.const -0x8000000.000000800000000000p-627)) (f64.const -0x1.0000000000001p-600))
(assert_return (invoke "f64" (f64.const +0x8000000.000000800000000001p-627)) (f64.const +0x1.0000000000001p-600))
(assert_return (invoke "f64" (f64.const -0x8000000.000000800000000001p-627)) (f64.const -0x1.0000000000001p-600))
(assert_return (invoke "f64" (f64.const +0x8000000.000000bfffffffffffp-627)) (f64.const +0x1.0000000000001p-600))
(assert_return (invoke "f64" (f64.const -0x8000000.000000bfffffffffffp-627)) (f64.const -0x1.0000000000001p-600))
(assert_return (invoke "f64" (f64.const +0x8000000.000000c00000000000p-627)) (f64.const +0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const -0x8000000.000000c00000000000p-627)) (f64.const -0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const +0x8000000.000000c00000000001p-627)) (f64.const +0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const -0x8000000.000000c00000000001p-627)) (f64.const -0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const +0x8000000.000000ffffffffffffp-627)) (f64.const +0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const -0x8000000.000000ffffffffffffp-627)) (f64.const -0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const +0x8000000.000001000000000000p-627)) (f64.const +0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const -0x8000000.000001000000000000p-627)) (f64.const -0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const +0x8000000.000001000000000001p-627)) (f64.const +0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const -0x8000000.000001000000000001p-627)) (f64.const -0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const +0x8000000.0000013fffffffffffp-627)) (f64.const +0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const -0x8000000.0000013fffffffffffp-627)) (f64.const -0x1.0000000000002p-600))
(assert_return (invoke "f64" (f64.const +0x8000000.000001400000000001p-627)) (f64.const +0x1.0000000000003p-600))
(assert_return (invoke "f64" (f64.const -0x8000000.000001400000000001p-627)) (f64.const -0x1.0000000000003p-600))

(assert_return (invoke "f64" (f64.const +5.3575430359313371995e+300)) (f64.const +0x1.0000000000000p+999))
(assert_return (invoke "f64" (f64.const -5.3575430359313371995e+300)) (f64.const -0x1.0000000000000p+999))
(assert_return (invoke "f64" (f64.const +5.3575430359313371996e+300)) (f64.const +0x1.0000000000001p+999))
(assert_return (invoke "f64" (f64.const -5.3575430359313371996e+300)) (f64.const -0x1.0000000000001p+999))
(assert_return (invoke "f64" (f64.const +5.3575430359313383891e+300)) (f64.const +0x1.0000000000001p+999))
(assert_return (invoke "f64" (f64.const -5.3575430359313383891e+300)) (f64.const -0x1.0000000000001p+999))
(assert_return (invoke "f64" (f64.const +5.3575430359313383892e+300)) (f64.const +0x1.0000000000002p+999))
(assert_return (invoke "f64" (f64.const -5.3575430359313383892e+300)) (f64.const -0x1.0000000000002p+999))

;; f64, large exponent
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

(assert_return (invoke "f64" (f64.const +0x2000000000000100000000000)) (f64.const +0x1.0000000000000p+97))
(assert_return (invoke "f64" (f64.const -0x2000000000000100000000000)) (f64.const -0x1.0000000000000p+97))
(assert_return (invoke "f64" (f64.const +0x2000000000000100000000001)) (f64.const +0x1.0000000000001p+97))
(assert_return (invoke "f64" (f64.const -0x2000000000000100000000001)) (f64.const -0x1.0000000000001p+97))
(assert_return (invoke "f64" (f64.const +0x20000000000001fffffffffff)) (f64.const +0x1.0000000000001p+97))
(assert_return (invoke "f64" (f64.const -0x20000000000001fffffffffff)) (f64.const -0x1.0000000000001p+97))
(assert_return (invoke "f64" (f64.const +0x2000000000000200000000000)) (f64.const +0x1.0000000000001p+97))
(assert_return (invoke "f64" (f64.const -0x2000000000000200000000000)) (f64.const -0x1.0000000000001p+97))
(assert_return (invoke "f64" (f64.const +0x2000000000000200000000001)) (f64.const +0x1.0000000000001p+97))
(assert_return (invoke "f64" (f64.const -0x2000000000000200000000001)) (f64.const -0x1.0000000000001p+97))
(assert_return (invoke "f64" (f64.const +0x20000000000002fffffffffff)) (f64.const +0x1.0000000000001p+97))
(assert_return (invoke "f64" (f64.const -0x20000000000002fffffffffff)) (f64.const -0x1.0000000000001p+97))
(assert_return (invoke "f64" (f64.const +0x2000000000000300000000000)) (f64.const +0x1.0000000000002p+97))
(assert_return (invoke "f64" (f64.const -0x2000000000000300000000000)) (f64.const -0x1.0000000000002p+97))
(assert_return (invoke "f64" (f64.const +0x2000000000000300000000001)) (f64.const +0x1.0000000000002p+97))
(assert_return (invoke "f64" (f64.const -0x2000000000000300000000001)) (f64.const -0x1.0000000000002p+97))
(assert_return (invoke "f64" (f64.const +0x20000000000003fffffffffff)) (f64.const +0x1.0000000000002p+97))
(assert_return (invoke "f64" (f64.const -0x20000000000003fffffffffff)) (f64.const -0x1.0000000000002p+97))
(assert_return (invoke "f64" (f64.const +0x2000000000000400000000000)) (f64.const +0x1.0000000000002p+97))
(assert_return (invoke "f64" (f64.const -0x2000000000000400000000000)) (f64.const -0x1.0000000000002p+97))
(assert_return (invoke "f64" (f64.const +0x2000000000000400000000001)) (f64.const +0x1.0000000000002p+97))
(assert_return (invoke "f64" (f64.const -0x2000000000000400000000001)) (f64.const -0x1.0000000000002p+97))
(assert_return (invoke "f64" (f64.const +0x20000000000004fffffffffff)) (f64.const +0x1.0000000000002p+97))
(assert_return (invoke "f64" (f64.const -0x20000000000004fffffffffff)) (f64.const -0x1.0000000000002p+97))
(assert_return (invoke "f64" (f64.const +0x2000000000000500000000000)) (f64.const +0x1.0000000000002p+97))
(assert_return (invoke "f64" (f64.const -0x2000000000000500000000000)) (f64.const -0x1.0000000000002p+97))
(assert_return (invoke "f64" (f64.const +0x2000000000000500000000001)) (f64.const +0x1.0000000000003p+97))
(assert_return (invoke "f64" (f64.const -0x2000000000000500000000001)) (f64.const -0x1.0000000000003p+97))

(assert_return (invoke "f64" (f64.const +1152921504606847104)) (f64.const +0x1.0000000000000p+60))
(assert_return (invoke "f64" (f64.const -1152921504606847104)) (f64.const -0x1.0000000000000p+60))
(assert_return (invoke "f64" (f64.const +1152921504606847105)) (f64.const +0x1.0000000000001p+60))
(assert_return (invoke "f64" (f64.const -1152921504606847105)) (f64.const -0x1.0000000000001p+60))
(assert_return (invoke "f64" (f64.const +1152921504606847359)) (f64.const +0x1.0000000000001p+60))
(assert_return (invoke "f64" (f64.const -1152921504606847359)) (f64.const -0x1.0000000000001p+60))
(assert_return (invoke "f64" (f64.const +1152921504606847360)) (f64.const +0x1.0000000000002p+60))
(assert_return (invoke "f64" (f64.const -1152921504606847360)) (f64.const -0x1.0000000000002p+60))

;; f64, subnormal
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

;; f64, round down at limit to infinity
(assert_return (invoke "f64" (f64.const +0x1.fffffffffffff4p1023)) (f64.const +0x1.fffffffffffffp1023))
(assert_return (invoke "f64" (f64.const -0x1.fffffffffffff4p1023)) (f64.const -0x1.fffffffffffffp1023))
(assert_return (invoke "f64" (f64.const +0x1.fffffffffffff7ffffffp1023)) (f64.const +0x1.fffffffffffffp1023))
(assert_return (invoke "f64" (f64.const -0x1.fffffffffffff7ffffffp1023)) (f64.const -0x1.fffffffffffffp1023))

;; Test interesting floating-point "expressions". These tests contain code
;; patterns which tempt common value-changing optimizations.

;; Test that x*y+z is not done with x87-style intermediate precision.

(module
  (func $f64.no_contraction (param $x f64) (param $y f64) (param $z f64) (result f64)
    (f64.add (f64.mul (get_local $x) (get_local $y)) (get_local $z)))
  (export "f64.no_contraction" $f64.no_contraction)
)

(assert_return (invoke "f64.no_contraction" (f64.const -0x1.9e87ce14273afp-103) (f64.const 0x1.2515ad31db63ep+664) (f64.const 0x1.868c6685e6185p+533)) (f64.const -0x1.da94885b11493p+561))
(assert_return (invoke "f64.no_contraction" (f64.const 0x1.da21c460a6f44p+52) (f64.const 0x1.60859d2e7714ap-321) (f64.const 0x1.e63f1b7b660e1p-302)) (f64.const 0x1.4672f256d1794p-268))
(assert_return (invoke "f64.no_contraction" (f64.const -0x1.f3eaf43f327cp-594) (f64.const 0x1.dfcc009906b57p+533) (f64.const 0x1.5984e03c520a1p-104)) (f64.const -0x1.d4797fb3db166p-60))
(assert_return (invoke "f64.no_contraction" (f64.const 0x1.dab6c772cb2e2p-69) (f64.const -0x1.d761663679a84p-101) (f64.const 0x1.f22f92c843226p-218)) (f64.const -0x1.b50d72dfcef68p-169))
(assert_return (invoke "f64.no_contraction" (f64.const -0x1.87c5def1e4d3dp-950) (f64.const -0x1.50cd5dab2207fp+935) (f64.const 0x1.e629bd0da8c5dp-54)) (f64.const 0x1.01b6feb4e78a7p-14))

;; Test that x*y+z is not folded to fma.

(module
  (func $f32.no_fma (param $x f32) (param $y f32) (param $z f32) (result f32)
    (f32.add (f32.mul (get_local $x) (get_local $y)) (get_local $z)))
  (export "f32.no_fma" $f32.no_fma)

  (func $f64.no_fma (param $x f64) (param $y f64) (param $z f64) (result f64)
    (f64.add (f64.mul (get_local $x) (get_local $y)) (get_local $z)))
  (export "f64.no_fma" $f64.no_fma)
)

(assert_return (invoke "f32.no_fma" (f32.const 0x1.a78402p+124) (f32.const 0x1.cf8548p-23) (f32.const 0x1.992adap+107)) (f32.const 0x1.a5262cp+107))
(assert_return (invoke "f32.no_fma" (f32.const 0x1.ed15a4p-28) (f32.const -0x1.613c72p-50) (f32.const 0x1.4757bp-88)) (f32.const -0x1.5406b8p-77))
(assert_return (invoke "f32.no_fma" (f32.const 0x1.ae63a2p+37) (f32.const 0x1.b3a59ap-13) (f32.const 0x1.c16918p+10)) (f32.const 0x1.6e385cp+25))
(assert_return (invoke "f32.no_fma" (f32.const 0x1.2a77fap-8) (f32.const -0x1.bb7356p+22) (f32.const -0x1.32be2ap+1)) (f32.const -0x1.0286d4p+15))
(assert_return (invoke "f32.no_fma" (f32.const 0x1.298fb6p+126) (f32.const -0x1.03080cp-70) (f32.const -0x1.418de6p+34)) (f32.const -0x1.2d15c6p+56))
(assert_return (invoke "f64.no_fma" (f64.const 0x1.ac357ff46eed4p+557) (f64.const 0x1.852c01a5e7297p+430) (f64.const -0x1.05995704eda8ap+987)) (f64.const 0x1.855d905d338ep+987))
(assert_return (invoke "f64.no_fma" (f64.const 0x1.e2fd6bf32010cp+749) (f64.const 0x1.01c2238d405e4p-130) (f64.const 0x1.2ecc0db4b9f94p+573)) (f64.const 0x1.e64eb07e063bcp+619))
(assert_return (invoke "f64.no_fma" (f64.const 0x1.92b7c7439ede3p-721) (f64.const -0x1.6aa97586d3de6p+1011) (f64.const 0x1.8de4823f6358ap+237)) (f64.const -0x1.1d4139fd20ecdp+291))
(assert_return (invoke "f64.no_fma" (f64.const -0x1.466d30bddb453p-386) (f64.const -0x1.185a4d739c7aap+443) (f64.const 0x1.5f9c436fbfc7bp+55)) (f64.const 0x1.bd61a350fcc1ap+57))
(assert_return (invoke "f64.no_fma" (f64.const 0x1.7e2c44058a799p+52) (f64.const 0x1.c73b71765b8b2p+685) (f64.const -0x1.16c641df0b108p+690)) (f64.const 0x1.53ccb53de0bd1p+738))

;; Test that x+0.0 is not folded to x.
;; See IEEE 754-2008 10.4 "Literal meaning and value-changing optimizations".

(module
  (func $f32.no_fold_add_zero (param $x f32) (result f32)
    (f32.add (get_local $x) (f32.const 0.0)))
  (export "f32.no_fold_add_zero" $f32.no_fold_add_zero)

  (func $f64.no_fold_add_zero (param $x f64) (result f64)
    (f64.add (get_local $x) (f64.const 0.0)))
  (export "f64.no_fold_add_zero" $f64.no_fold_add_zero)
)

(assert_return (invoke "f32.no_fold_add_zero" (f32.const -0.0)) (f32.const 0.0))
(assert_return (invoke "f64.no_fold_add_zero" (f64.const -0.0)) (f64.const 0.0))
(assert_return (invoke "f32.no_fold_add_zero" (f32.const nan:0x200000)) (f32.const nan:0x600000))
(assert_return (invoke "f64.no_fold_add_zero" (f64.const nan:0x4000000000000)) (f64.const nan:0xc000000000000))

;; Test that 0.0 - x is not folded to -x.

(module
  (func $f32.no_fold_zero_sub (param $x f32) (result f32)
    (f32.sub (f32.const 0.0) (get_local $x)))
  (export "f32.no_fold_zero_sub" $f32.no_fold_zero_sub)

  (func $f64.no_fold_zero_sub (param $x f64) (result f64)
    (f64.sub (f64.const 0.0) (get_local $x)))
  (export "f64.no_fold_zero_sub" $f64.no_fold_zero_sub)
)

(assert_return (invoke "f32.no_fold_zero_sub" (f32.const 0.0)) (f32.const 0.0))
(assert_return (invoke "f64.no_fold_zero_sub" (f64.const 0.0)) (f64.const 0.0))
(assert_return (invoke "f32.no_fold_zero_sub" (f32.const nan:0x200000)) (f32.const nan:0x600000))
(assert_return (invoke "f64.no_fold_zero_sub" (f64.const nan:0x4000000000000)) (f64.const nan:0xc000000000000))

;; Test that x - 0.0 is not folded to x.

(module
  (func $f32.no_fold_sub_zero (param $x f32) (result f32)
    (f32.sub (get_local $x) (f32.const 0.0)))
  (export "f32.no_fold_sub_zero" $f32.no_fold_sub_zero)

  (func $f64.no_fold_sub_zero (param $x f64) (result f64)
    (f64.sub (get_local $x) (f64.const 0.0)))
  (export "f64.no_fold_sub_zero" $f64.no_fold_sub_zero)
)

(assert_return (invoke "f32.no_fold_sub_zero" (f32.const nan:0x200000)) (f32.const nan:0x600000))
(assert_return (invoke "f64.no_fold_sub_zero" (f64.const nan:0x4000000000000)) (f64.const nan:0xc000000000000))

;; Test that x*0.0 is not folded to 0.0.

(module
  (func $f32.no_fold_mul_zero (param $x f32) (result f32)
    (f32.mul (get_local $x) (f32.const 0.0)))
  (export "f32.no_fold_mul_zero" $f32.no_fold_mul_zero)

  (func $f64.no_fold_mul_zero (param $x f64) (result f64)
    (f64.mul (get_local $x) (f64.const 0.0)))
  (export "f64.no_fold_mul_zero" $f64.no_fold_mul_zero)
)

(assert_return (invoke "f32.no_fold_mul_zero" (f32.const -0.0)) (f32.const -0.0))
(assert_return (invoke "f32.no_fold_mul_zero" (f32.const -1.0)) (f32.const -0.0))
(assert_return (invoke "f32.no_fold_mul_zero" (f32.const -2.0)) (f32.const -0.0))
(assert_return (invoke "f32.no_fold_mul_zero" (f32.const nan:0x200000)) (f32.const nan:0x600000))
(assert_return (invoke "f64.no_fold_mul_zero" (f64.const -0.0)) (f64.const -0.0))
(assert_return (invoke "f64.no_fold_mul_zero" (f64.const -1.0)) (f64.const -0.0))
(assert_return (invoke "f64.no_fold_mul_zero" (f64.const -2.0)) (f64.const -0.0))
(assert_return (invoke "f64.no_fold_mul_zero" (f64.const nan:0x4000000000000)) (f64.const nan:0xc000000000000))

;; Test that x*1.0 is not folded to x.
;; See IEEE 754-2008 10.4 "Literal meaning and value-changing optimizations".

(module
  (func $f32.no_fold_mul_one (param $x f32) (result f32)
    (f32.mul (get_local $x) (f32.const 1.0)))
  (export "f32.no_fold_mul_one" $f32.no_fold_mul_one)

  (func $f64.no_fold_mul_one (param $x f64) (result f64)
    (f64.mul (get_local $x) (f64.const 1.0)))
  (export "f64.no_fold_mul_one" $f64.no_fold_mul_one)
)

(assert_return (invoke "f32.no_fold_mul_one" (f32.const nan:0x200000)) (f32.const nan:0x600000))
(assert_return (invoke "f64.no_fold_mul_one" (f64.const nan:0x4000000000000)) (f64.const nan:0xc000000000000))

;; Test that 0.0/x is not folded to 0.0.

(module
  (func $f32.no_fold_zero_div (param $x f32) (result f32)
    (f32.div (f32.const 0.0) (get_local $x)))
  (export "f32.no_fold_zero_div" $f32.no_fold_zero_div)

  (func $f64.no_fold_zero_div (param $x f64) (result f64)
    (f64.div (f64.const 0.0) (get_local $x)))
  (export "f64.no_fold_zero_div" $f64.no_fold_zero_div)
)

(assert_return_nan (invoke "f32.no_fold_zero_div" (f32.const 0.0)))
(assert_return_nan (invoke "f32.no_fold_zero_div" (f32.const -0.0)))
(assert_return (invoke "f32.no_fold_zero_div" (f32.const nan)) (f32.const nan))
(assert_return (invoke "f32.no_fold_zero_div" (f32.const nan:0x200000)) (f32.const nan:0x600000))
(assert_return_nan (invoke "f64.no_fold_zero_div" (f64.const 0.0)))
(assert_return_nan (invoke "f64.no_fold_zero_div" (f64.const -0.0)))
(assert_return (invoke "f64.no_fold_zero_div" (f64.const nan)) (f64.const nan))
(assert_return (invoke "f64.no_fold_zero_div" (f64.const nan:0x4000000000000)) (f64.const nan:0xc000000000000))

;; Test that x/1.0 is not folded to x.

(module
  (func $f32.no_fold_div_one (param $x f32) (result f32)
    (f32.div (get_local $x) (f32.const 1.0)))
  (export "f32.no_fold_div_one" $f32.no_fold_div_one)

  (func $f64.no_fold_div_one (param $x f64) (result f64)
    (f64.div (get_local $x) (f64.const 1.0)))
  (export "f64.no_fold_div_one" $f64.no_fold_div_one)
)

(assert_return (invoke "f32.no_fold_div_one" (f32.const nan:0x200000)) (f32.const nan:0x600000))
(assert_return (invoke "f64.no_fold_div_one" (f64.const nan:0x4000000000000)) (f64.const nan:0xc000000000000))

;; Test that x/-1.0 is not folded to -x.

(module
  (func $f32.no_fold_div_neg1 (param $x f32) (result f32)
    (f32.div (get_local $x) (f32.const -1.0)))
  (export "f32.no_fold_div_neg1" $f32.no_fold_div_neg1)

  (func $f64.no_fold_div_neg1 (param $x f64) (result f64)
    (f64.div (get_local $x) (f64.const -1.0)))
  (export "f64.no_fold_div_neg1" $f64.no_fold_div_neg1)
)

(assert_return (invoke "f32.no_fold_div_neg1" (f32.const nan:0x200000)) (f32.const nan:0x600000))
(assert_return (invoke "f64.no_fold_div_neg1" (f64.const nan:0x4000000000000)) (f64.const nan:0xc000000000000))

;; Test that -0.0 - x is not folded to -x.

(module
  (func $f32.no_fold_neg0_sub (param $x f32) (result f32)
    (f32.sub (f32.const -0.0) (get_local $x)))
  (export "f32.no_fold_neg0_sub" $f32.no_fold_neg0_sub)

  (func $f64.no_fold_neg0_sub (param $x f64) (result f64)
    (f64.sub (f64.const -0.0) (get_local $x)))
  (export "f64.no_fold_neg0_sub" $f64.no_fold_neg0_sub)
)

(assert_return (invoke "f32.no_fold_neg0_sub" (f32.const nan:0x200000)) (f32.const nan:0x600000))
(assert_return (invoke "f64.no_fold_neg0_sub" (f64.const nan:0x4000000000000)) (f64.const nan:0xc000000000000))

;; Test that -1.0 * x is not folded to -x.

(module
  (func $f32.no_fold_neg1_mul (param $x f32) (result f32)
    (f32.mul (f32.const -1.0) (get_local $x)))
  (export "f32.no_fold_neg1_mul" $f32.no_fold_neg1_mul)

  (func $f64.no_fold_neg1_mul (param $x f64) (result f64)
    (f64.mul (f64.const -1.0) (get_local $x)))
  (export "f64.no_fold_neg1_mul" $f64.no_fold_neg1_mul)
)

(assert_return (invoke "f32.no_fold_neg1_mul" (f32.const nan:0x200000)) (f32.const nan:0x600000))
(assert_return (invoke "f64.no_fold_neg1_mul" (f64.const nan:0x4000000000000)) (f64.const nan:0xc000000000000))

;; Test that x == x is not folded to true.

(module
  (func $f32.no_fold_eq_self (param $x f32) (result i32)
    (f32.eq (get_local $x) (get_local $x)))
  (export "f32.no_fold_eq_self" $f32.no_fold_eq_self)

  (func $f64.no_fold_eq_self (param $x f64) (result i32)
    (f64.eq (get_local $x) (get_local $x)))
  (export "f64.no_fold_eq_self" $f64.no_fold_eq_self)
)

(assert_return (invoke "f32.no_fold_eq_self" (f32.const nan)) (i32.const 0))
(assert_return (invoke "f64.no_fold_eq_self" (f64.const nan)) (i32.const 0))

;; Test that x != x is not folded to false.

(module
  (func $f32.no_fold_ne_self (param $x f32) (result i32)
    (f32.ne (get_local $x) (get_local $x)))
  (export "f32.no_fold_ne_self" $f32.no_fold_ne_self)

  (func $f64.no_fold_ne_self (param $x f64) (result i32)
    (f64.ne (get_local $x) (get_local $x)))
  (export "f64.no_fold_ne_self" $f64.no_fold_ne_self)
)

(assert_return (invoke "f32.no_fold_ne_self" (f32.const nan)) (i32.const 1))
(assert_return (invoke "f64.no_fold_ne_self" (f64.const nan)) (i32.const 1))

;; Test that x - x is not folded to 0.0.

(module
  (func $f32.no_fold_sub_self (param $x f32) (result f32)
    (f32.sub (get_local $x) (get_local $x)))
  (export "f32.no_fold_sub_self" $f32.no_fold_sub_self)

  (func $f64.no_fold_sub_self (param $x f64) (result f64)
    (f64.sub (get_local $x) (get_local $x)))
  (export "f64.no_fold_sub_self" $f64.no_fold_sub_self)
)

(assert_return_nan (invoke "f32.no_fold_sub_self" (f32.const infinity)))
(assert_return (invoke "f32.no_fold_sub_self" (f32.const nan)) (f32.const nan))
(assert_return_nan (invoke "f64.no_fold_sub_self" (f64.const infinity)))
(assert_return (invoke "f64.no_fold_sub_self" (f64.const nan)) (f64.const nan))

;; Test that x/3 is not folded to x*(1/3).

(module
  (func $f32.no_fold_div_3 (param $x f32) (result f32)
    (f32.div (get_local $x) (f32.const 3.0)))
  (export "f32.no_fold_div_3" $f32.no_fold_div_3)

  (func $f64.no_fold_div_3 (param $x f64) (result f64)
    (f64.div (get_local $x) (f64.const 3.0)))
  (export "f64.no_fold_div_3" $f64.no_fold_div_3)
)

(assert_return (invoke "f32.no_fold_div_3" (f32.const -0x1.359c26p+50)) (f32.const -0x1.9cd032p+48))
(assert_return (invoke "f32.no_fold_div_3" (f32.const -0x1.e45646p+93)) (f32.const -0x1.42e42ep+92))
(assert_return (invoke "f32.no_fold_div_3" (f32.const -0x1.2a3916p-83)) (f32.const -0x1.8da172p-85))
(assert_return (invoke "f32.no_fold_div_3" (f32.const -0x1.1f8b38p-124)) (f32.const -0x1.7f644ap-126))
(assert_return (invoke "f32.no_fold_div_3" (f32.const -0x1.d64f64p-56)) (f32.const -0x1.398a42p-57))
(assert_return (invoke "f64.no_fold_div_3" (f64.const -0x1.a8a88d29e2cc3p+632)) (f64.const -0x1.1b1b08c69732dp+631))
(assert_return (invoke "f64.no_fold_div_3" (f64.const -0x1.bcf52dc950972p-167)) (f64.const -0x1.28a373db8b0f7p-168))
(assert_return (invoke "f64.no_fold_div_3" (f64.const 0x1.bd3c0d989f7a4p-874)) (f64.const 0x1.28d2b3bb14fc3p-875))
(assert_return (invoke "f64.no_fold_div_3" (f64.const -0x1.0138bf530a53cp+1007)) (f64.const -0x1.56f6546eb86fbp+1005))
(assert_return (invoke "f64.no_fold_div_3" (f64.const 0x1.052b87f9d794dp+415)) (f64.const 0x1.5c3a0aa274c67p+413))

;; Test that (x*z)+(y*z) is not folded to (x+y)*z

(module
  (func $f32.no_factor (param $x f32) (param $y f32) (param $z f32) (result f32)
    (f32.add (f32.mul (get_local $x) (get_local $z)) (f32.mul (get_local $y) (get_local $z))))
  (export "f32.no_factor" $f32.no_factor)

  (func $f64.no_factor (param $x f64) (param $y f64) (param $z f64) (result f64)
    (f64.add (f64.mul (get_local $x) (get_local $z)) (f64.mul (get_local $y) (get_local $z))))
  (export "f64.no_factor" $f64.no_factor)
)

(assert_return (invoke "f32.no_factor" (f32.const -0x1.4e2352p+40) (f32.const -0x1.842e2cp+49) (f32.const 0x1.eea602p+59)) (f32.const -0x1.77a7dp+109))
(assert_return (invoke "f32.no_factor" (f32.const -0x1.b4e7f6p-6) (f32.const 0x1.8c990cp-5) (f32.const -0x1.70cc02p-9)) (f32.const -0x1.00a342p-14))
(assert_return (invoke "f32.no_factor" (f32.const -0x1.06722ep-41) (f32.const 0x1.eed3cep-64) (f32.const 0x1.5c5558p+123)) (f32.const -0x1.651aaep+82))
(assert_return (invoke "f32.no_factor" (f32.const -0x1.f8c6a4p-64) (f32.const 0x1.08c806p-83) (f32.const 0x1.b5ceccp+118)) (f32.const -0x1.afa15p+55))
(assert_return (invoke "f32.no_factor" (f32.const -0x1.3aaa1ep-84) (f32.const 0x1.c6d5eep-71) (f32.const 0x1.8d2924p+20)) (f32.const 0x1.60c9cep-50))
(assert_return (invoke "f64.no_factor" (f64.const 0x1.3adeda9144977p-424) (f64.const 0x1.c15af887049e1p-462) (f64.const -0x1.905179c4c4778p-225)) (f64.const -0x1.ec606bcb87b1ap-649))
(assert_return (invoke "f64.no_factor" (f64.const 0x1.3c84821c1d348p-662) (f64.const -0x1.4ffd4c77ad037p-1009) (f64.const -0x1.dd275335c6f4p-957)) (f64.const 0x0p+0))
(assert_return (invoke "f64.no_factor" (f64.const -0x1.074f372347051p-334) (f64.const -0x1.aaeef661f4c96p-282) (f64.const -0x1.9bd34abe8696dp+479)) (f64.const 0x1.5767029593e2p+198))
(assert_return (invoke "f64.no_factor" (f64.const -0x1.c4ded58a6f389p-289) (f64.const 0x1.ba6fdef5d59c9p-260) (f64.const -0x1.c1201c0470205p-253)) (f64.const -0x1.841ada2e0f184p-512))
(assert_return (invoke "f64.no_factor" (f64.const 0x1.9d3688f8e375ap-608) (f64.const 0x1.bf91311588256p-579) (f64.const -0x1.1605a6b5d5ff8p+489)) (f64.const -0x1.e6118ca76af53p-90))

;; Test that (x+y)*z is not folded to (x*z)+(y*z)

(module
  (func $f32.no_distribute (param $x f32) (param $y f32) (param $z f32) (result f32)
    (f32.mul (f32.add (get_local $x) (get_local $y)) (get_local $z)))
  (export "f32.no_distribute" $f32.no_distribute)

  (func $f64.no_distribute (param $x f64) (param $y f64) (param $z f64) (result f64)
    (f64.mul (f64.add (get_local $x) (get_local $y)) (get_local $z)))
  (export "f64.no_distribute" $f64.no_distribute)
)

(assert_return (invoke "f32.no_distribute" (f32.const -0x1.4e2352p+40) (f32.const -0x1.842e2cp+49) (f32.const 0x1.eea602p+59)) (f32.const -0x1.77a7d2p+109))
(assert_return (invoke "f32.no_distribute" (f32.const -0x1.b4e7f6p-6) (f32.const 0x1.8c990cp-5) (f32.const -0x1.70cc02p-9)) (f32.const -0x1.00a34p-14))
(assert_return (invoke "f32.no_distribute" (f32.const -0x1.06722ep-41) (f32.const 0x1.eed3cep-64) (f32.const 0x1.5c5558p+123)) (f32.const -0x1.651abp+82))
(assert_return (invoke "f32.no_distribute" (f32.const -0x1.f8c6a4p-64) (f32.const 0x1.08c806p-83) (f32.const 0x1.b5ceccp+118)) (f32.const -0x1.afa14ep+55))
(assert_return (invoke "f32.no_distribute" (f32.const -0x1.3aaa1ep-84) (f32.const 0x1.c6d5eep-71) (f32.const 0x1.8d2924p+20)) (f32.const 0x1.60c9ccp-50))
(assert_return (invoke "f64.no_distribute" (f64.const 0x1.3adeda9144977p-424) (f64.const 0x1.c15af887049e1p-462) (f64.const -0x1.905179c4c4778p-225)) (f64.const -0x1.ec606bcb87b1bp-649))
(assert_return (invoke "f64.no_distribute" (f64.const 0x1.3c84821c1d348p-662) (f64.const -0x1.4ffd4c77ad037p-1009) (f64.const -0x1.dd275335c6f4p-957)) (f64.const -0x0p+0))
(assert_return (invoke "f64.no_distribute" (f64.const -0x1.074f372347051p-334) (f64.const -0x1.aaeef661f4c96p-282) (f64.const -0x1.9bd34abe8696dp+479)) (f64.const 0x1.5767029593e1fp+198))
(assert_return (invoke "f64.no_distribute" (f64.const -0x1.c4ded58a6f389p-289) (f64.const 0x1.ba6fdef5d59c9p-260) (f64.const -0x1.c1201c0470205p-253)) (f64.const -0x1.841ada2e0f183p-512))
(assert_return (invoke "f64.no_distribute" (f64.const 0x1.9d3688f8e375ap-608) (f64.const 0x1.bf91311588256p-579) (f64.const -0x1.1605a6b5d5ff8p+489)) (f64.const -0x1.e6118ca76af52p-90))

;; Test that x*(y/z) is not folded to (x*y)/z

(module
  (func $f32.no_regroup_div_mul (param $x f32) (param $y f32) (param $z f32) (result f32)
    (f32.mul (get_local $x) (f32.div (get_local $y) (get_local $z))))
  (export "f32.no_regroup_div_mul" $f32.no_regroup_div_mul)

  (func $f64.no_regroup_div_mul (param $x f64) (param $y f64) (param $z f64) (result f64)
    (f64.mul (get_local $x) (f64.div (get_local $y) (get_local $z))))
  (export "f64.no_regroup_div_mul" $f64.no_regroup_div_mul)
)

(assert_return (invoke "f32.no_regroup_div_mul" (f32.const -0x1.2d14a6p-115) (f32.const -0x1.575a6cp-64) (f32.const 0x1.5cee0ep-116)) (f32.const 0x1.2844cap-63))
(assert_return (invoke "f32.no_regroup_div_mul" (f32.const -0x1.454738p+91) (f32.const -0x1.b28a66p-115) (f32.const -0x1.f53908p+72)) (f32.const -0x0p+0))
(assert_return (invoke "f32.no_regroup_div_mul" (f32.const -0x1.6be56ep+16) (f32.const -0x1.b46fc6p-21) (f32.const -0x1.a51df6p-123)) (f32.const -0x1.792258p+118))
(assert_return (invoke "f32.no_regroup_div_mul" (f32.const -0x1.c343f8p-94) (f32.const 0x1.e4d906p+73) (f32.const 0x1.be69f8p+68)) (f32.const -0x1.ea1df2p-89))
(assert_return (invoke "f32.no_regroup_div_mul" (f32.const 0x1.c6ae76p+112) (f32.const 0x1.fc953cp+24) (f32.const -0x1.60b3e8p+71)) (f32.const -0x1.47d0eap+66))
(assert_return (invoke "f64.no_regroup_div_mul" (f64.const 0x1.3c04b815e30bp-423) (f64.const -0x1.379646fd98127p-119) (f64.const 0x1.bddb158506031p-642)) (f64.const -0x1.b9b3301f2dd2dp+99))
(assert_return (invoke "f64.no_regroup_div_mul" (f64.const 0x1.46b3a402f86d5p+337) (f64.const 0x1.6fbf1b9e1798dp-447) (f64.const -0x1.bd9704a5a6a06p+797)) (f64.const -0x0p+0))
(assert_return (invoke "f64.no_regroup_div_mul" (f64.const 0x1.6c9765bb4347fp-479) (f64.const 0x1.a4af42e34a141p+902) (f64.const 0x1.d2dde70eb68f9p-448)) (f64.const infinity))
(assert_return (invoke "f64.no_regroup_div_mul" (f64.const -0x1.706023645be72p+480) (f64.const -0x1.6c229f7d9101dp+611) (f64.const -0x1.4d50fa68d3d9ep+836)) (f64.const -0x1.926fa3cacc651p+255))
(assert_return (invoke "f64.no_regroup_div_mul" (f64.const 0x1.8cc63d8caf4c7p-599) (f64.const 0x1.8671ac4c35753p-878) (f64.const -0x1.ef35b1695e659p-838)) (f64.const -0x1.38d55f56406dp-639))

;; Test that (x*y)/z is not folded to x*(y/z)

(module
  (func $f32.no_regroup_mul_div (param $x f32) (param $y f32) (param $z f32) (result f32)
    (f32.div (f32.mul (get_local $x) (get_local $y)) (get_local $z)))
  (export "f32.no_regroup_mul_div" $f32.no_regroup_mul_div)

  (func $f64.no_regroup_mul_div (param $x f64) (param $y f64) (param $z f64) (result f64)
    (f64.div (f64.mul (get_local $x) (get_local $y)) (get_local $z)))
  (export "f64.no_regroup_mul_div" $f64.no_regroup_mul_div)
)

(assert_return (invoke "f32.no_regroup_mul_div" (f32.const -0x1.2d14a6p-115) (f32.const -0x1.575a6cp-64) (f32.const 0x1.5cee0ep-116)) (f32.const 0x0p+0))
(assert_return (invoke "f32.no_regroup_mul_div" (f32.const -0x1.454738p+91) (f32.const -0x1.b28a66p-115) (f32.const -0x1.f53908p+72)) (f32.const -0x1.1a00e8p-96))
(assert_return (invoke "f32.no_regroup_mul_div" (f32.const -0x1.6be56ep+16) (f32.const -0x1.b46fc6p-21) (f32.const -0x1.a51df6p-123)) (f32.const -0x1.79225ap+118))
(assert_return (invoke "f32.no_regroup_mul_div" (f32.const -0x1.c343f8p-94) (f32.const 0x1.e4d906p+73) (f32.const 0x1.be69f8p+68)) (f32.const -0x1.ea1df4p-89))
(assert_return (invoke "f32.no_regroup_mul_div" (f32.const 0x1.c6ae76p+112) (f32.const 0x1.fc953cp+24) (f32.const -0x1.60b3e8p+71)) (f32.const -infinity))
(assert_return (invoke "f64.no_regroup_mul_div" (f64.const 0x1.3c04b815e30bp-423) (f64.const -0x1.379646fd98127p-119) (f64.const 0x1.bddb158506031p-642)) (f64.const -0x1.b9b3301f2dd2ep+99))
(assert_return (invoke "f64.no_regroup_mul_div" (f64.const 0x1.46b3a402f86d5p+337) (f64.const 0x1.6fbf1b9e1798dp-447) (f64.const -0x1.bd9704a5a6a06p+797)) (f64.const -0x1.0da0b6328e09p-907))
(assert_return (invoke "f64.no_regroup_mul_div" (f64.const 0x1.6c9765bb4347fp-479) (f64.const 0x1.a4af42e34a141p+902) (f64.const 0x1.d2dde70eb68f9p-448)) (f64.const 0x1.4886b6d9a9a79p+871))
(assert_return (invoke "f64.no_regroup_mul_div" (f64.const -0x1.706023645be72p+480) (f64.const -0x1.6c229f7d9101dp+611) (f64.const -0x1.4d50fa68d3d9ep+836)) (f64.const -infinity))
(assert_return (invoke "f64.no_regroup_mul_div" (f64.const 0x1.8cc63d8caf4c7p-599) (f64.const 0x1.8671ac4c35753p-878) (f64.const -0x1.ef35b1695e659p-838)) (f64.const -0x0p+0))

;; Test that x+y+z+w is not reassociated.

(module
  (func $f32.no_reassociate_add (param $x f32) (param $y f32) (param $z f32) (param $w f32) (result f32)
    (f32.add (f32.add (f32.add (get_local $x) (get_local $y)) (get_local $z)) (get_local $w)))
  (export "f32.no_reassociate_add" $f32.no_reassociate_add)

  (func $f64.no_reassociate_add (param $x f64) (param $y f64) (param $z f64) (param $w f64) (result f64)
    (f64.add (f64.add (f64.add (get_local $x) (get_local $y)) (get_local $z)) (get_local $w)))
  (export "f64.no_reassociate_add" $f64.no_reassociate_add)
)

(assert_return (invoke "f32.no_reassociate_add" (f32.const -0x1.5f7ddcp+44) (f32.const 0x1.854e1p+34) (f32.const -0x1.b2068cp+47) (f32.const -0x1.209692p+41)) (f32.const -0x1.e26c76p+47))
(assert_return (invoke "f32.no_reassociate_add" (f32.const 0x1.da3b78p-9) (f32.const -0x1.4312fap-7) (f32.const 0x1.0395e6p-4) (f32.const -0x1.6d5ea6p-7)) (f32.const 0x1.78b31ap-5))
(assert_return (invoke "f32.no_reassociate_add" (f32.const -0x1.fdb93ap+34) (f32.const -0x1.b6fce6p+41) (f32.const 0x1.c131d8p+44) (f32.const 0x1.8835b6p+38)) (f32.const 0x1.8ff3a2p+44))
(assert_return (invoke "f32.no_reassociate_add" (f32.const 0x1.1739fcp+47) (f32.const 0x1.a4b186p+49) (f32.const -0x1.0c623cp+35) (f32.const 0x1.16a102p+51)) (f32.const 0x1.913ff6p+51))
(assert_return (invoke "f32.no_reassociate_add" (f32.const 0x1.733cfap+108) (f32.const -0x1.38d30cp+108) (f32.const 0x1.2f5854p+105) (f32.const -0x1.ccb058p+94)) (f32.const 0x1.813716p+106))
(assert_return (invoke "f64.no_reassociate_add" (f64.const -0x1.697a4d9ff19a6p+841) (f64.const 0x1.b305466238397p+847) (f64.const 0x1.e0b2d9bfb4e72p+855) (f64.const -0x1.6e1f3ae2b06bbp+857)) (f64.const -0x1.eb0e5936f087ap+856))
(assert_return (invoke "f64.no_reassociate_add" (f64.const 0x1.00ef6746b30e1p-543) (f64.const 0x1.cc1cfafdf3fe1p-544) (f64.const -0x1.f7726df3ecba6p-543) (f64.const -0x1.b26695f99d307p-594)) (f64.const -0x1.074892e3fad76p-547))
(assert_return (invoke "f64.no_reassociate_add" (f64.const -0x1.e807b3bd6d854p+440) (f64.const 0x1.cedae26c2c5fp+407) (f64.const -0x1.00ab6e1442541p+437) (f64.const 0x1.28538a55997bdp+397)) (f64.const -0x1.040e90bf871ebp+441))
(assert_return (invoke "f64.no_reassociate_add" (f64.const -0x1.ba2b6f35a2402p-317) (f64.const 0x1.ad1c3fea7cd9ep-307) (f64.const -0x1.93aace2bf1261p-262) (f64.const 0x1.9fddbe472847ep-260)) (f64.const 0x1.3af30abc2c01bp-260))
(assert_return (invoke "f64.no_reassociate_add" (f64.const -0x1.ccb9c6092fb1dp+641) (f64.const -0x1.4b7c28c108244p+614) (f64.const 0x1.8a7cefef4bde1p+646) (f64.const -0x1.901b28b08b482p+644)) (f64.const 0x1.1810579194126p+646))

;; Test that x*y*z*w is not reassociated.

(module
  (func $f32.no_reassociate_mul (param $x f32) (param $y f32) (param $z f32) (param $w f32) (result f32)
    (f32.mul (f32.mul (f32.mul (get_local $x) (get_local $y)) (get_local $z)) (get_local $w)))
  (export "f32.no_reassociate_mul" $f32.no_reassociate_mul)

  (func $f64.no_reassociate_mul (param $x f64) (param $y f64) (param $z f64) (param $w f64) (result f64)
    (f64.mul (f64.mul (f64.mul (get_local $x) (get_local $y)) (get_local $z)) (get_local $w)))
  (export "f64.no_reassociate_mul" $f64.no_reassociate_mul)
)

(assert_return (invoke "f32.no_reassociate_mul" (f32.const 0x1.950ba8p-116) (f32.const 0x1.efdacep-33) (f32.const -0x1.5f9bcp+102) (f32.const 0x1.f04508p-56)) (f32.const -0x1.ff356ep-101))
(assert_return (invoke "f32.no_reassociate_mul" (f32.const 0x1.5990aep-56) (f32.const -0x1.7dfb04p+102) (f32.const -0x1.4f774ap-125) (f32.const -0x1.595fe6p+70)) (f32.const -0x1.c7c8fcp-8))
(assert_return (invoke "f32.no_reassociate_mul" (f32.const 0x1.6ad9a4p-48) (f32.const -0x1.9138aap+55) (f32.const -0x1.4a774ep-40) (f32.const 0x1.1ff08p+76)) (f32.const 0x1.9cd8ecp+44))
(assert_return (invoke "f32.no_reassociate_mul" (f32.const 0x1.e1caecp-105) (f32.const 0x1.af0dd2p+77) (f32.const -0x1.016eep+56) (f32.const -0x1.ab70d6p+59)) (f32.const 0x1.54870ep+89))
(assert_return (invoke "f32.no_reassociate_mul" (f32.const -0x1.3b1dcp-99) (f32.const 0x1.4e5a34p-49) (f32.const -0x1.38ba5ap+3) (f32.const 0x1.7fb8eep+59)) (f32.const 0x1.5bbf98p-85))
(assert_return (invoke "f64.no_reassociate_mul" (f64.const -0x1.e7842ab7181p-667) (f64.const -0x1.fabf40ceeceafp+990) (f64.const -0x1.1a38a825ab01ap-376) (f64.const -0x1.27e8ea469b14fp+664)) (f64.const 0x1.336eb428af4f3p+613))
(assert_return (invoke "f64.no_reassociate_mul" (f64.const 0x1.4ca2292a6acbcp+454) (f64.const 0x1.6ffbab850089ap-516) (f64.const -0x1.547c32e1f5b93p-899) (f64.const -0x1.c7571d9388375p+540)) (f64.const 0x1.1ac796954fc1p-419))
(assert_return (invoke "f64.no_reassociate_mul" (f64.const 0x1.73881a52e0401p-501) (f64.const -0x1.1b68dd9efb1a7p+788) (f64.const 0x1.d1c5e6a3eb27cp-762) (f64.const -0x1.56cb2fcc7546fp+88)) (f64.const 0x1.f508db92c34efp-386))
(assert_return (invoke "f64.no_reassociate_mul" (f64.const 0x1.2efa87859987cp+692) (f64.const 0x1.68e4373e241p-423) (f64.const 0x1.4e2d0fb383a57p+223) (f64.const -0x1.301d3265c737bp-23)) (f64.const -0x1.4b2b6c393f30cp+470))
(assert_return (invoke "f64.no_reassociate_mul" (f64.const 0x1.1013f7498b95fp-234) (f64.const 0x1.d2d1c36fff138p-792) (f64.const -0x1.cbf1824ea7bfdp+728) (f64.const -0x1.440da9c8b836dp-599)) (f64.const 0x1.1a16512881c91p-895))

;; Test that x/0 is not folded away.

(module
  (func $f32.no_fold_div_0 (param $x f32) (result f32)
    (f32.div (get_local $x) (f32.const 0.0)))
  (export "f32.no_fold_div_0" $f32.no_fold_div_0)

  (func $f64.no_fold_div_0 (param $x f64) (result f64)
    (f64.div (get_local $x) (f64.const 0.0)))
  (export "f64.no_fold_div_0" $f64.no_fold_div_0)
)

(assert_return (invoke "f32.no_fold_div_0" (f32.const 1.0)) (f32.const infinity))
(assert_return (invoke "f32.no_fold_div_0" (f32.const -1.0)) (f32.const -infinity))
(assert_return (invoke "f32.no_fold_div_0" (f32.const infinity)) (f32.const infinity))
(assert_return (invoke "f32.no_fold_div_0" (f32.const -infinity)) (f32.const -infinity))
(assert_return_nan (invoke "f32.no_fold_div_0" (f32.const 0)))
(assert_return_nan (invoke "f32.no_fold_div_0" (f32.const -0)))
(assert_return (invoke "f32.no_fold_div_0" (f32.const nan:0x200000)) (f32.const nan:0x600000))
(assert_return (invoke "f32.no_fold_div_0" (f32.const nan)) (f32.const nan))
(assert_return (invoke "f64.no_fold_div_0" (f64.const 1.0)) (f64.const infinity))
(assert_return (invoke "f64.no_fold_div_0" (f64.const -1.0)) (f64.const -infinity))
(assert_return (invoke "f64.no_fold_div_0" (f64.const infinity)) (f64.const infinity))
(assert_return (invoke "f64.no_fold_div_0" (f64.const -infinity)) (f64.const -infinity))
(assert_return_nan (invoke "f64.no_fold_div_0" (f64.const 0)))
(assert_return_nan (invoke "f64.no_fold_div_0" (f64.const -0)))
(assert_return (invoke "f64.no_fold_div_0" (f64.const nan)) (f64.const nan))
(assert_return (invoke "f64.no_fold_div_0" (f64.const nan:0x4000000000000)) (f64.const nan:0xc000000000000))

;; Test that x/-0 is not folded away.

(module
  (func $f32.no_fold_div_neg0 (param $x f32) (result f32)
    (f32.div (get_local $x) (f32.const -0.0)))
  (export "f32.no_fold_div_neg0" $f32.no_fold_div_neg0)

  (func $f64.no_fold_div_neg0 (param $x f64) (result f64)
    (f64.div (get_local $x) (f64.const -0.0)))
  (export "f64.no_fold_div_neg0" $f64.no_fold_div_neg0)
)

(assert_return (invoke "f32.no_fold_div_neg0" (f32.const 1.0)) (f32.const -infinity))
(assert_return (invoke "f32.no_fold_div_neg0" (f32.const -1.0)) (f32.const infinity))
(assert_return (invoke "f32.no_fold_div_neg0" (f32.const infinity)) (f32.const -infinity))
(assert_return (invoke "f32.no_fold_div_neg0" (f32.const -infinity)) (f32.const infinity))
(assert_return_nan (invoke "f32.no_fold_div_neg0" (f32.const 0)))
(assert_return_nan (invoke "f32.no_fold_div_neg0" (f32.const -0)))
(assert_return (invoke "f32.no_fold_div_neg0" (f32.const nan:0x200000)) (f32.const nan:0x600000))
(assert_return (invoke "f32.no_fold_div_neg0" (f32.const nan)) (f32.const nan))
(assert_return (invoke "f64.no_fold_div_neg0" (f64.const 1.0)) (f64.const -infinity))
(assert_return (invoke "f64.no_fold_div_neg0" (f64.const -1.0)) (f64.const infinity))
(assert_return (invoke "f64.no_fold_div_neg0" (f64.const infinity)) (f64.const -infinity))
(assert_return (invoke "f64.no_fold_div_neg0" (f64.const -infinity)) (f64.const infinity))
(assert_return_nan (invoke "f64.no_fold_div_neg0" (f64.const 0)))
(assert_return_nan (invoke "f64.no_fold_div_neg0" (f64.const -0)))
(assert_return (invoke "f64.no_fold_div_neg0" (f64.const nan)) (f64.const nan))
(assert_return (invoke "f64.no_fold_div_neg0" (f64.const nan:0x4000000000000)) (f64.const nan:0xc000000000000))

;; Test that sqrt(x*x+y*y) is not folded to hypot.

(module
  (func $f32.no_fold_to_hypot (param $x f32) (param $y f32) (result f32)
    (f32.sqrt (f32.add (f32.mul (get_local $x) (get_local $x))
                       (f32.mul (get_local $y) (get_local $y)))))
  (export "f32.no_fold_to_hypot" $f32.no_fold_to_hypot)

  (func $f64.no_fold_to_hypot (param $x f64) (param $y f64) (result f64)
    (f64.sqrt (f64.add (f64.mul (get_local $x) (get_local $x))
                       (f64.mul (get_local $y) (get_local $y)))))
  (export "f64.no_fold_to_hypot" $f64.no_fold_to_hypot)
)

(assert_return (invoke "f32.no_fold_to_hypot" (f32.const 0x1.c2f338p-81) (f32.const 0x1.401b5ep-68)) (f32.const 0x1.401cccp-68))
(assert_return (invoke "f32.no_fold_to_hypot" (f32.const -0x1.c38d1p-71) (f32.const -0x1.359ddp-107)) (f32.const 0x1.c36a62p-71))
(assert_return (invoke "f32.no_fold_to_hypot" (f32.const -0x1.99e0cap-114) (f32.const -0x1.ed0c6cp-69)) (f32.const 0x1.ed0e48p-69))
(assert_return (invoke "f32.no_fold_to_hypot" (f32.const -0x1.1b6ceap+5) (f32.const 0x1.5440bep+17)) (f32.const 0x1.5440cp+17))
(assert_return (invoke "f32.no_fold_to_hypot" (f32.const 0x1.8f019ep-76) (f32.const -0x1.182308p-71)) (f32.const 0x1.17e2bcp-71))
(assert_return (invoke "f64.no_fold_to_hypot" (f64.const 0x1.1a0ac4f7c8711p-636) (f64.const 0x1.1372ebafff551p-534)) (f64.const 0x1.13463fa37014ep-534))
(assert_return (invoke "f64.no_fold_to_hypot" (f64.const 0x1.b793512167499p+395) (f64.const -0x1.11cbc52af4c36p+410)) (f64.const 0x1.11cbc530783a2p+410))
(assert_return (invoke "f64.no_fold_to_hypot" (f64.const 0x1.76777f44ff40bp-536) (f64.const -0x1.c3896e4dc1fbp-766)) (f64.const 0x1.8p-536))
(assert_return (invoke "f64.no_fold_to_hypot" (f64.const -0x1.889ac72cc6b5dp-521) (f64.const 0x1.8d7084e659f3bp-733)) (f64.const 0x1.889ac72ca843ap-521))
(assert_return (invoke "f64.no_fold_to_hypot" (f64.const 0x1.5ee588c02cb08p-670) (f64.const -0x1.05ce25788d9ecp-514)) (f64.const 0x1.05ce25788d9dfp-514))

;; Test that 1.0/x isn't approximated.

(module
  (func $f32.no_approximate_reciprocal (param $x f32) (param $y f32) (result f32)
    (f32.div (f32.const 1.0) (get_local $x)))
  (export "f32.no_approximate_reciprocal" $f32.no_approximate_reciprocal)
)

(assert_return (invoke "f32.no_approximate_reciprocal" (f32.const -0x1.2900b6p-10) (f32.const 0x1.d427e8p+56)) (f32.const -0x1.b950d4p+9))
(assert_return (invoke "f32.no_approximate_reciprocal" (f32.const 0x1.e7212p+127) (f32.const -0x1.55832ap+44)) (f32.const 0x1.0d11f8p-128))
(assert_return (invoke "f32.no_approximate_reciprocal" (f32.const -0x1.42a466p-93) (f32.const 0x1.7b62d8p+36)) (f32.const -0x1.963ee6p+92))
(assert_return (invoke "f32.no_approximate_reciprocal" (f32.const 0x1.5d0c32p+76) (f32.const 0x1.d14dccp-74)) (f32.const 0x1.778362p-77))
(assert_return (invoke "f32.no_approximate_reciprocal" (f32.const -0x1.601de2p-82) (f32.const -0x1.3c7abap+42)) (f32.const -0x1.743d7ep+81))

;; Test that 1.0/sqrt(x) isn't approximated.

(module
  (func $f32.no_approximate_reciprocal_sqrt (param $x f32) (param $y f32) (result f32)
    (f32.div (f32.const 1.0) (f32.sqrt (get_local $x))))
  (export "f32.no_approximate_reciprocal_sqrt" $f32.no_approximate_reciprocal_sqrt)
)

(assert_return (invoke "f32.no_approximate_reciprocal_sqrt" (f32.const 0x1.6af12ap-43) (f32.const 0x1.b2113ap-14)) (f32.const 0x1.300ed4p+21))
(assert_return (invoke "f32.no_approximate_reciprocal_sqrt" (f32.const 0x1.e82fc6p-8) (f32.const -0x1.56a382p-126)) (f32.const 0x1.72c376p+3))
(assert_return (invoke "f32.no_approximate_reciprocal_sqrt" (f32.const 0x1.b9fa9cp-66) (f32.const -0x1.35394cp+35)) (f32.const 0x1.85a9bap+32))
(assert_return (invoke "f32.no_approximate_reciprocal_sqrt" (f32.const 0x1.f4f546p-44) (f32.const -0x1.c92ecep+122)) (f32.const 0x1.6e01c2p+21))
(assert_return (invoke "f32.no_approximate_reciprocal_sqrt" (f32.const 0x1.5da7aap-86) (f32.const -0x1.665652p+119)) (f32.const 0x1.b618cap+42))

;; Test that sqrt(1.0/x) isn't approximated.

(module
  (func $f32.no_approximate_sqrt_reciprocal (param $x f32) (param $y f32) (result f32)
    (f32.sqrt (f32.div (f32.const 1.0) (get_local $x))))
  (export "f32.no_approximate_sqrt_reciprocal" $f32.no_approximate_sqrt_reciprocal)
)

(assert_return (invoke "f32.no_approximate_sqrt_reciprocal" (f32.const 0x1.a4c986p+60) (f32.const -0x1.04e29cp-72)) (f32.const 0x1.8f5ac6p-31))
(assert_return (invoke "f32.no_approximate_sqrt_reciprocal" (f32.const 0x1.50511ep-9) (f32.const -0x1.39228ep-32)) (f32.const 0x1.3bdd46p+4))
(assert_return (invoke "f32.no_approximate_sqrt_reciprocal" (f32.const 0x1.125ec2p+69) (f32.const -0x1.a7f42ep+92)) (f32.const 0x1.5db572p-35))
(assert_return (invoke "f32.no_approximate_sqrt_reciprocal" (f32.const 0x1.ba4c5p+13) (f32.const 0x1.947784p-72)) (f32.const 0x1.136f16p-7))
(assert_return (invoke "f32.no_approximate_sqrt_reciprocal" (f32.const 0x1.4a5be2p+104) (f32.const 0x1.a7b718p-19)) (f32.const 0x1.c2b5bp-53))

;; Test that converting i32/i64 to f32/f64 and back isn't folded away

(module
  (func $i32.no_fold_f32_s (param i32) (result i32)
    (i32.trunc_s/f32 (f32.convert_s/i32 (get_local 0))))
  (export "i32.no_fold_f32_s" $i32.no_fold_f32_s)

  (func $i32.no_fold_f32_u (param i32) (result i32)
    (i32.trunc_u/f32 (f32.convert_u/i32 (get_local 0))))
  (export "i32.no_fold_f32_u" $i32.no_fold_f32_u)

  (func $i64.no_fold_f64_s (param i64) (result i64)
    (i64.trunc_s/f64 (f64.convert_s/i64 (get_local 0))))
  (export "i64.no_fold_f64_s" $i64.no_fold_f64_s)

  (func $i64.no_fold_f64_u (param i64) (result i64)
    (i64.trunc_u/f64 (f64.convert_u/i64 (get_local 0))))
  (export "i64.no_fold_f64_u" $i64.no_fold_f64_u)
)

(assert_return (invoke "i32.no_fold_f32_s" (i32.const 0x1000000)) (i32.const 0x1000000))
(assert_return (invoke "i32.no_fold_f32_s" (i32.const 0x1000001)) (i32.const 0x1000000))
(assert_return (invoke "i32.no_fold_f32_s" (i32.const 0xf0000010)) (i32.const 0xf0000010))

(assert_return (invoke "i32.no_fold_f32_u" (i32.const 0x1000000)) (i32.const 0x1000000))
(assert_return (invoke "i32.no_fold_f32_u" (i32.const 0x1000001)) (i32.const 0x1000000))
(assert_return (invoke "i32.no_fold_f32_u" (i32.const 0xf0000010)) (i32.const 0xf0000000))

(assert_return (invoke "i64.no_fold_f64_s" (i64.const 0x20000000000000)) (i64.const 0x20000000000000))
(assert_return (invoke "i64.no_fold_f64_s" (i64.const 0x20000000000001)) (i64.const 0x20000000000000))
(assert_return (invoke "i64.no_fold_f64_s" (i64.const 0xf000000000000400)) (i64.const 0xf000000000000400))

(assert_return (invoke "i64.no_fold_f64_u" (i64.const 0x20000000000000)) (i64.const 0x20000000000000))
(assert_return (invoke "i64.no_fold_f64_u" (i64.const 0x20000000000001)) (i64.const 0x20000000000000))
(assert_return (invoke "i64.no_fold_f64_u" (i64.const 0xf000000000000400)) (i64.const 0xf000000000000000))

;; Test that x+y-y is not folded to x.

(module
  (func $f32.no_fold_add_sub (param $x f32) (param $y f32) (result f32)
    (f32.sub (f32.add (get_local $x) (get_local $y)) (get_local $y)))
  (export "f32.no_fold_add_sub" $f32.no_fold_add_sub)

  (func $f64.no_fold_add_sub (param $x f64) (param $y f64) (result f64)
    (f64.sub (f64.add (get_local $x) (get_local $y)) (get_local $y)))
  (export "f64.no_fold_add_sub" $f64.no_fold_add_sub)
)

(assert_return (invoke "f32.no_fold_add_sub" (f32.const 0x1.b553e4p-47) (f32.const -0x1.67db2cp-26)) (f32.const 0x1.cp-47))
(assert_return (invoke "f32.no_fold_add_sub" (f32.const -0x1.a884dp-23) (f32.const 0x1.f2ae1ep-19)) (f32.const -0x1.a884ep-23))
(assert_return (invoke "f32.no_fold_add_sub" (f32.const -0x1.fc04fp+82) (f32.const -0x1.65403ap+101)) (f32.const -0x1p+83))
(assert_return (invoke "f32.no_fold_add_sub" (f32.const 0x1.870fa2p-78) (f32.const 0x1.c54916p-56)) (f32.const 0x1.8p-78))
(assert_return (invoke "f32.no_fold_add_sub" (f32.const -0x1.17e966p-108) (f32.const -0x1.5fa61ap-84)) (f32.const -0x1p-107))

(assert_return (invoke "f64.no_fold_add_sub" (f64.const -0x1.1053ea172dba8p-874) (f64.const 0x1.113c413408ac8p-857)) (f64.const -0x1.1053ea172p-874))
(assert_return (invoke "f64.no_fold_add_sub" (f64.const 0x1.e377d54807972p-546) (f64.const 0x1.040a0a4d1ff7p-526)) (f64.const 0x1.e377d548p-546))
(assert_return (invoke "f64.no_fold_add_sub" (f64.const -0x1.75f53cd926b62p-30) (f64.const -0x1.66b176e602bb5p-3)) (f64.const -0x1.75f53dp-30))
(assert_return (invoke "f64.no_fold_add_sub" (f64.const -0x1.c450ff28332ap-341) (f64.const 0x1.15a5855023baep-305)) (f64.const -0x1.c451p-341))
(assert_return (invoke "f64.no_fold_add_sub" (f64.const -0x1.1ad4a596d3ea8p-619) (f64.const -0x1.17d81a41c0ea8p-588)) (f64.const -0x1.1ad4a8p-619))

;; Test that x-y+y is not folded to x.

(module
  (func $f32.no_fold_sub_add (param $x f32) (param $y f32) (result f32)
    (f32.add (f32.sub (get_local $x) (get_local $y)) (get_local $y)))
  (export "f32.no_fold_sub_add" $f32.no_fold_sub_add)

  (func $f64.no_fold_sub_add (param $x f64) (param $y f64) (result f64)
    (f64.add (f64.sub (get_local $x) (get_local $y)) (get_local $y)))
  (export "f64.no_fold_sub_add" $f64.no_fold_sub_add)
)

(assert_return (invoke "f32.no_fold_sub_add" (f32.const -0x1.523cb8p+9) (f32.const 0x1.93096cp+8)) (f32.const -0x1.523cbap+9))
(assert_return (invoke "f32.no_fold_sub_add" (f32.const -0x1.a31a1p-111) (f32.const 0x1.745efp-95)) (f32.const -0x1.a4p-111))
(assert_return (invoke "f32.no_fold_sub_add" (f32.const 0x1.3d5328p+26) (f32.const 0x1.58567p+35)) (f32.const 0x1.3d54p+26))
(assert_return (invoke "f32.no_fold_sub_add" (f32.const 0x1.374e26p-39) (f32.const -0x1.66a5p-27)) (f32.const 0x1.374p-39))
(assert_return (invoke "f32.no_fold_sub_add" (f32.const 0x1.320facp-3) (f32.const -0x1.ac069ap+14)) (f32.const 0x1.34p-3))

(assert_return (invoke "f64.no_fold_sub_add" (f64.const 0x1.8f92aad2c9b8dp+255) (f64.const -0x1.08cd4992266cbp+259)) (f64.const 0x1.8f92aad2c9b9p+255))
(assert_return (invoke "f64.no_fold_sub_add" (f64.const 0x1.5aaff55742c8bp-666) (f64.const 0x1.8f5f47181f46dp-647)) (f64.const 0x1.5aaff5578p-666))
(assert_return (invoke "f64.no_fold_sub_add" (f64.const 0x1.21bc52967a98dp+251) (f64.const -0x1.fcffaa32d0884p+300)) (f64.const 0x1.2p+251))
(assert_return (invoke "f64.no_fold_sub_add" (f64.const 0x1.9c78361f47374p-26) (f64.const -0x1.69d69f4edc61cp-13)) (f64.const 0x1.9c78361f48p-26))
(assert_return (invoke "f64.no_fold_sub_add" (f64.const 0x1.4dbe68e4afab2p-367) (f64.const -0x1.dc24e5b39cd02p-361)) (f64.const 0x1.4dbe68e4afacp-367))

;; Test that x*y/y is not folded to x.

(module
  (func $f32.no_fold_mul_div (param $x f32) (param $y f32) (result f32)
    (f32.div (f32.mul (get_local $x) (get_local $y)) (get_local $y)))
  (export "f32.no_fold_mul_div" $f32.no_fold_mul_div)

  (func $f64.no_fold_mul_div (param $x f64) (param $y f64) (result f64)
    (f64.div (f64.mul (get_local $x) (get_local $y)) (get_local $y)))
  (export "f64.no_fold_mul_div" $f64.no_fold_mul_div)
)

(assert_return (invoke "f32.no_fold_mul_div" (f32.const -0x1.cd859ap+54) (f32.const 0x1.6ca936p-47)) (f32.const -0x1.cd8598p+54))
(assert_return (invoke "f32.no_fold_mul_div" (f32.const -0x1.0b56b8p-26) (f32.const 0x1.48264cp-106)) (f32.const -0x1.0b56a4p-26))
(assert_return (invoke "f32.no_fold_mul_div" (f32.const -0x1.e7555cp-48) (f32.const -0x1.9161cp+48)) (f32.const -0x1.e7555ap-48))
(assert_return (invoke "f32.no_fold_mul_div" (f32.const 0x1.aaa50ep+52) (f32.const -0x1.dfb39ep+60)) (f32.const 0x1.aaa50cp+52))
(assert_return (invoke "f32.no_fold_mul_div" (f32.const -0x1.2b7dfap-92) (f32.const -0x1.7c4ca6p-37)) (f32.const -0x1.2b7dfep-92))

(assert_return (invoke "f64.no_fold_mul_div" (f64.const -0x1.3d79ff4118a1ap-837) (f64.const -0x1.b8b5dda31808cp-205)) (f64.const -0x1.3d79ff412263ep-837))
(assert_return (invoke "f64.no_fold_mul_div" (f64.const 0x1.f894d1ee6b3a4p+384) (f64.const 0x1.8c2606d03d58ap+585)) (f64.const 0x1.f894d1ee6b3a5p+384))
(assert_return (invoke "f64.no_fold_mul_div" (f64.const -0x1.a022260acc993p+238) (f64.const -0x1.5fbc128fc8e3cp-552)) (f64.const -0x1.a022260acc992p+238))
(assert_return (invoke "f64.no_fold_mul_div" (f64.const 0x1.9d4b8ed174f54p-166) (f64.const 0x1.ee3d467aeeac6p-906)) (f64.const 0x1.8dcc95a053b2bp-166))
(assert_return (invoke "f64.no_fold_mul_div" (f64.const -0x1.e95ea897cdcd4p+660) (f64.const -0x1.854d5df085f2ep-327)) (f64.const -0x1.e95ea897cdcd5p+660))

;; Test that x/y*y is not folded to x.

(module
  (func $f32.no_fold_div_mul (param $x f32) (param $y f32) (result f32)
    (f32.mul (f32.div (get_local $x) (get_local $y)) (get_local $y)))
  (export "f32.no_fold_div_mul" $f32.no_fold_div_mul)

  (func $f64.no_fold_div_mul (param $x f64) (param $y f64) (result f64)
    (f64.mul (f64.div (get_local $x) (get_local $y)) (get_local $y)))
  (export "f64.no_fold_div_mul" $f64.no_fold_div_mul)
)

(assert_return (invoke "f32.no_fold_div_mul" (f32.const -0x1.dc6364p+38) (f32.const 0x1.d630ecp+29)) (f32.const -0x1.dc6362p+38))
(assert_return (invoke "f32.no_fold_div_mul" (f32.const -0x1.1f9836p-52) (f32.const -0x1.16c4e4p-18)) (f32.const -0x1.1f9838p-52))
(assert_return (invoke "f32.no_fold_div_mul" (f32.const 0x1.c5972cp-126) (f32.const -0x1.d6659ep+7)) (f32.const 0x1.c5980ep-126))
(assert_return (invoke "f32.no_fold_div_mul" (f32.const -0x1.2e3a9ep-74) (f32.const -0x1.353994p+59)) (f32.const -0x1.2e3a4p-74))
(assert_return (invoke "f32.no_fold_div_mul" (f32.const 0x1.d96b82p-98) (f32.const 0x1.95d908p+27)) (f32.const 0x1.d96b84p-98))

(assert_return (invoke "f64.no_fold_div_mul" (f64.const 0x1.d01f913a52481p-876) (f64.const -0x1.2cd0668b28344p+184)) (f64.const 0x1.d020daf71cdcp-876))
(assert_return (invoke "f64.no_fold_div_mul" (f64.const -0x1.81cb7d400918dp-714) (f64.const 0x1.7caa643586d6ep-53)) (f64.const -0x1.81cb7d400918ep-714))
(assert_return (invoke "f64.no_fold_div_mul" (f64.const -0x1.66904c97b5c8ep-145) (f64.const 0x1.5c3481592ad4cp+428)) (f64.const -0x1.66904c97b5c8dp-145))
(assert_return (invoke "f64.no_fold_div_mul" (f64.const -0x1.e75859d2f0765p-278) (f64.const -0x1.5f19b6ab497f9p+283)) (f64.const -0x1.e75859d2f0764p-278))
(assert_return (invoke "f64.no_fold_div_mul" (f64.const -0x1.515fe9c3b5f5p+620) (f64.const 0x1.36be869c99f7ap+989)) (f64.const -0x1.515fe9c3b5f4fp+620))

;; Test that promote(demote(x)) is not folded to x.

(module
  (func $no_fold_demote_promote (param $x f64) (result f64)
    (f64.promote/f32 (f32.demote/f64 (get_local $x))))
  (export "no_fold_demote_promote" $no_fold_demote_promote)
)

(assert_return (invoke "no_fold_demote_promote" (f64.const -0x1.dece272390f5dp-133)) (f64.const -0x1.decep-133))
(assert_return (invoke "no_fold_demote_promote" (f64.const -0x1.19e6c79938a6fp-85)) (f64.const -0x1.19e6c8p-85))
(assert_return (invoke "no_fold_demote_promote" (f64.const 0x1.49b297ec44dc1p+107)) (f64.const 0x1.49b298p+107))
(assert_return (invoke "no_fold_demote_promote" (f64.const -0x1.74f5bd865163p-88)) (f64.const -0x1.74f5bep-88))
(assert_return (invoke "no_fold_demote_promote" (f64.const 0x1.26d675662367ep+104)) (f64.const 0x1.26d676p+104))

;; Test that demote(x+promote(y)) is not folded to demote(x)+y.

(module
  (func $no_demote_mixed_add (param $x f64) (param $y f32) (result f32)
    (f32.demote/f64 (f64.add (get_local $x) (f64.promote/f32 (get_local $y)))))
  (export "no_demote_mixed_add" $no_demote_mixed_add)

  (func $no_demote_mixed_add_commuted (param $y f32) (param $x f64) (result f32)
    (f32.demote/f64 (f64.add (f64.promote/f32 (get_local $y)) (get_local $x))))
  (export "no_demote_mixed_add_commuted" $no_demote_mixed_add_commuted)
)

(assert_return (invoke "no_demote_mixed_add" (f64.const 0x1.f51a9d04854f9p-95) (f32.const 0x1.3f4e9cp-119)) (f32.const 0x1.f51a9ep-95))
(assert_return (invoke "no_demote_mixed_add" (f64.const 0x1.065b3d81ad8dp+37) (f32.const 0x1.758cd8p+38)) (f32.const 0x1.f8ba76p+38))
(assert_return (invoke "no_demote_mixed_add" (f64.const 0x1.626c80963bd17p-119) (f32.const -0x1.9bbf86p-121)) (f32.const 0x1.f6f93ep-120))
(assert_return (invoke "no_demote_mixed_add" (f64.const -0x1.0d5110e3385bbp-20) (f32.const 0x1.096f4ap-29)) (f32.const -0x1.0ccc5ap-20))
(assert_return (invoke "no_demote_mixed_add" (f64.const -0x1.73852db4e5075p-20) (f32.const -0x1.24e474p-41)) (f32.const -0x1.738536p-20))

(assert_return (invoke "no_demote_mixed_add_commuted" (f32.const 0x1.3f4e9cp-119) (f64.const 0x1.f51a9d04854f9p-95)) (f32.const 0x1.f51a9ep-95))
(assert_return (invoke "no_demote_mixed_add_commuted" (f32.const 0x1.758cd8p+38) (f64.const 0x1.065b3d81ad8dp+37)) (f32.const 0x1.f8ba76p+38))
(assert_return (invoke "no_demote_mixed_add_commuted" (f32.const -0x1.9bbf86p-121) (f64.const 0x1.626c80963bd17p-119)) (f32.const 0x1.f6f93ep-120))
(assert_return (invoke "no_demote_mixed_add_commuted" (f32.const 0x1.096f4ap-29) (f64.const -0x1.0d5110e3385bbp-20)) (f32.const -0x1.0ccc5ap-20))
(assert_return (invoke "no_demote_mixed_add_commuted" (f32.const -0x1.24e474p-41) (f64.const -0x1.73852db4e5075p-20)) (f32.const -0x1.738536p-20))

;; Test that demote(x-promote(y)) is not folded to demote(x)-y.

(module
  (func $no_demote_mixed_sub (param $x f64) (param $y f32) (result f32)
    (f32.demote/f64 (f64.sub (get_local $x) (f64.promote/f32 (get_local $y)))))
  (export "no_demote_mixed_sub" $no_demote_mixed_sub)
)

(assert_return (invoke "no_demote_mixed_sub" (f64.const 0x1.a0a183220e9b1p+82) (f32.const 0x1.c5acf8p+61)) (f32.const 0x1.a0a174p+82))
(assert_return (invoke "no_demote_mixed_sub" (f64.const -0x1.6e2c5ac39f63ep+30) (f32.const 0x1.d48ca4p+17)) (f32.const -0x1.6e3bp+30))
(assert_return (invoke "no_demote_mixed_sub" (f64.const -0x1.98c74350dde6ap+6) (f32.const 0x1.9d69bcp-12)) (f32.const -0x1.98c7aap+6))
(assert_return (invoke "no_demote_mixed_sub" (f64.const 0x1.0459f34091dbfp-54) (f32.const 0x1.61ad08p-71)) (f32.const 0x1.045942p-54))
(assert_return (invoke "no_demote_mixed_sub" (f64.const 0x1.a7498dca3fdb7p+14) (f32.const 0x1.ed21c8p+15)) (f32.const -0x1.197d02p+15))

;; Test that converting between integer and float and back isn't folded away.

(module
  (func $f32.i32.no_fold_trunc_s_convert_s (param $x f32) (result f32)
    (f32.convert_s/i32 (i32.trunc_s/f32 (get_local $x))))
  (export "f32.i32.no_fold_trunc_s_convert_s" $f32.i32.no_fold_trunc_s_convert_s)

  (func $f32.i32.no_fold_trunc_u_convert_s (param $x f32) (result f32)
    (f32.convert_s/i32 (i32.trunc_u/f32 (get_local $x))))
  (export "f32.i32.no_fold_trunc_u_convert_s" $f32.i32.no_fold_trunc_u_convert_s)

  (func $f32.i32.no_fold_trunc_s_convert_u (param $x f32) (result f32)
    (f32.convert_u/i32 (i32.trunc_s/f32 (get_local $x))))
  (export "f32.i32.no_fold_trunc_s_convert_u" $f32.i32.no_fold_trunc_s_convert_u)

  (func $f32.i32.no_fold_trunc_u_convert_u (param $x f32) (result f32)
    (f32.convert_u/i32 (i32.trunc_u/f32 (get_local $x))))
  (export "f32.i32.no_fold_trunc_u_convert_u" $f32.i32.no_fold_trunc_u_convert_u)

  (func $f64.i32.no_fold_trunc_s_convert_s (param $x f64) (result f64)
    (f64.convert_s/i32 (i32.trunc_s/f64 (get_local $x))))
  (export "f64.i32.no_fold_trunc_s_convert_s" $f64.i32.no_fold_trunc_s_convert_s)

  (func $f64.i32.no_fold_trunc_u_convert_s (param $x f64) (result f64)
    (f64.convert_s/i32 (i32.trunc_u/f64 (get_local $x))))
  (export "f64.i32.no_fold_trunc_u_convert_s" $f64.i32.no_fold_trunc_u_convert_s)

  (func $f64.i32.no_fold_trunc_s_convert_u (param $x f64) (result f64)
    (f64.convert_u/i32 (i32.trunc_s/f64 (get_local $x))))
  (export "f64.i32.no_fold_trunc_s_convert_u" $f64.i32.no_fold_trunc_s_convert_u)

  (func $f64.i32.no_fold_trunc_u_convert_u (param $x f64) (result f64)
    (f64.convert_u/i32 (i32.trunc_u/f64 (get_local $x))))
  (export "f64.i32.no_fold_trunc_u_convert_u" $f64.i32.no_fold_trunc_u_convert_u)

  (func $f32.i64.no_fold_trunc_s_convert_s (param $x f32) (result f32)
    (f32.convert_s/i64 (i64.trunc_s/f32 (get_local $x))))
  (export "f32.i64.no_fold_trunc_s_convert_s" $f32.i64.no_fold_trunc_s_convert_s)

  (func $f32.i64.no_fold_trunc_u_convert_s (param $x f32) (result f32)
    (f32.convert_s/i64 (i64.trunc_u/f32 (get_local $x))))
  (export "f32.i64.no_fold_trunc_u_convert_s" $f32.i64.no_fold_trunc_u_convert_s)

  (func $f32.i64.no_fold_trunc_s_convert_u (param $x f32) (result f32)
    (f32.convert_u/i64 (i64.trunc_s/f32 (get_local $x))))
  (export "f32.i64.no_fold_trunc_s_convert_u" $f32.i64.no_fold_trunc_s_convert_u)

  (func $f32.i64.no_fold_trunc_u_convert_u (param $x f32) (result f32)
    (f32.convert_u/i64 (i64.trunc_u/f32 (get_local $x))))
  (export "f32.i64.no_fold_trunc_u_convert_u" $f32.i64.no_fold_trunc_u_convert_u)

  (func $f64.i64.no_fold_trunc_s_convert_s (param $x f64) (result f64)
    (f64.convert_s/i64 (i64.trunc_s/f64 (get_local $x))))
  (export "f64.i64.no_fold_trunc_s_convert_s" $f64.i64.no_fold_trunc_s_convert_s)

  (func $f64.i64.no_fold_trunc_u_convert_s (param $x f64) (result f64)
    (f64.convert_s/i64 (i64.trunc_u/f64 (get_local $x))))
  (export "f64.i64.no_fold_trunc_u_convert_s" $f64.i64.no_fold_trunc_u_convert_s)

  (func $f64.i64.no_fold_trunc_s_convert_u (param $x f64) (result f64)
    (f64.convert_u/i64 (i64.trunc_s/f64 (get_local $x))))
  (export "f64.i64.no_fold_trunc_s_convert_u" $f64.i64.no_fold_trunc_s_convert_u)

  (func $f64.i64.no_fold_trunc_u_convert_u (param $x f64) (result f64)
    (f64.convert_u/i64 (i64.trunc_u/f64 (get_local $x))))
  (export "f64.i64.no_fold_trunc_u_convert_u" $f64.i64.no_fold_trunc_u_convert_u)
)

(assert_return (invoke "f32.i32.no_fold_trunc_s_convert_s" (f32.const 1.5)) (f32.const 1.0))
(assert_return (invoke "f32.i32.no_fold_trunc_s_convert_s" (f32.const -1.5)) (f32.const -1.0))
(assert_return (invoke "f32.i32.no_fold_trunc_u_convert_s" (f32.const 1.5)) (f32.const 1.0))
(assert_return (invoke "f32.i32.no_fold_trunc_u_convert_s" (f32.const -0.5)) (f32.const 0.0))
(assert_return (invoke "f32.i32.no_fold_trunc_s_convert_u" (f32.const 1.5)) (f32.const 1.0))
(assert_return (invoke "f32.i32.no_fold_trunc_s_convert_u" (f32.const -1.5)) (f32.const 0x1p+32))
(assert_return (invoke "f32.i32.no_fold_trunc_u_convert_u" (f32.const 1.5)) (f32.const 1.0))
(assert_return (invoke "f32.i32.no_fold_trunc_u_convert_u" (f32.const -0.5)) (f32.const 0.0))

(assert_return (invoke "f64.i32.no_fold_trunc_s_convert_s" (f64.const 1.5)) (f64.const 1.0))
(assert_return (invoke "f64.i32.no_fold_trunc_s_convert_s" (f64.const -1.5)) (f64.const -1.0))
(assert_return (invoke "f64.i32.no_fold_trunc_u_convert_s" (f64.const 1.5)) (f64.const 1.0))
(assert_return (invoke "f64.i32.no_fold_trunc_u_convert_s" (f64.const -0.5)) (f64.const 0.0))
(assert_return (invoke "f64.i32.no_fold_trunc_s_convert_u" (f64.const 1.5)) (f64.const 1.0))
(assert_return (invoke "f64.i32.no_fold_trunc_s_convert_u" (f64.const -1.5)) (f64.const 0x1.fffffffep+31))
(assert_return (invoke "f64.i32.no_fold_trunc_u_convert_u" (f64.const 1.5)) (f64.const 1.0))
(assert_return (invoke "f64.i32.no_fold_trunc_u_convert_u" (f64.const -0.5)) (f64.const 0.0))

(assert_return (invoke "f32.i64.no_fold_trunc_s_convert_s" (f32.const 1.5)) (f32.const 1.0))
(assert_return (invoke "f32.i64.no_fold_trunc_s_convert_s" (f32.const -1.5)) (f32.const -1.0))
(assert_return (invoke "f32.i64.no_fold_trunc_u_convert_s" (f32.const 1.5)) (f32.const 1.0))
(assert_return (invoke "f32.i64.no_fold_trunc_u_convert_s" (f32.const -0.5)) (f32.const 0.0))
(assert_return (invoke "f32.i64.no_fold_trunc_s_convert_u" (f32.const 1.5)) (f32.const 1.0))
(assert_return (invoke "f32.i64.no_fold_trunc_s_convert_u" (f32.const -1.5)) (f32.const 0x1p+64))
(assert_return (invoke "f32.i64.no_fold_trunc_u_convert_u" (f32.const 1.5)) (f32.const 1.0))
(assert_return (invoke "f32.i64.no_fold_trunc_u_convert_u" (f32.const -0.5)) (f32.const 0.0))

(assert_return (invoke "f64.i64.no_fold_trunc_s_convert_s" (f64.const 1.5)) (f64.const 1.0))
(assert_return (invoke "f64.i64.no_fold_trunc_s_convert_s" (f64.const -1.5)) (f64.const -1.0))
(assert_return (invoke "f64.i64.no_fold_trunc_u_convert_s" (f64.const 1.5)) (f64.const 1.0))
(assert_return (invoke "f64.i64.no_fold_trunc_u_convert_s" (f64.const -0.5)) (f64.const 0.0))
(assert_return (invoke "f64.i64.no_fold_trunc_s_convert_u" (f64.const 1.5)) (f64.const 1.0))
(assert_return (invoke "f64.i64.no_fold_trunc_s_convert_u" (f64.const -1.5)) (f64.const 0x1p+64))
(assert_return (invoke "f64.i64.no_fold_trunc_u_convert_u" (f64.const 1.5)) (f64.const 1.0))
(assert_return (invoke "f64.i64.no_fold_trunc_u_convert_u" (f64.const -0.5)) (f64.const 0.0))

;; Test that dividing by a loop-invariant constant isn't optimized to be a
;; multiplication by a reciprocal, which would be particularly tempting since
;; the reciprocal computation could be hoisted.

(module
  (memory 1 1)
  (func $init (param $i i32) (param $x f32) (f32.store (get_local $i) (get_local $x)))
  (export "init" $init)

  (func $run (param $n i32) (param $z f32)
    (local $i i32)
    (loop $exit $cont
      (f32.store (get_local $i) (f32.div (f32.load (get_local $i)) (get_local $z)))
      (set_local $i (i32.add (get_local $i) (i32.const 4)))
      (br_if $cont (i32.lt_u (get_local $i) (get_local $n)))
    )
  )
  (export "run" $run)

  (func $check (param $i i32) (result f32) (f32.load (get_local $i)))
  (export "check" $check)
)

(invoke "init" (i32.const  0) (f32.const 15.1))
(invoke "init" (i32.const  4) (f32.const 15.2))
(invoke "init" (i32.const  8) (f32.const 15.3))
(invoke "init" (i32.const 12) (f32.const 15.4))
(assert_return (invoke "check" (i32.const  0)) (f32.const 15.1))
(assert_return (invoke "check" (i32.const  4)) (f32.const 15.2))
(assert_return (invoke "check" (i32.const  8)) (f32.const 15.3))
(assert_return (invoke "check" (i32.const 12)) (f32.const 15.4))
(invoke "run" (i32.const 16) (f32.const 3.0))
(assert_return (invoke "check" (i32.const  0)) (f32.const 0x1.422222p+2))
(assert_return (invoke "check" (i32.const  4)) (f32.const 0x1.444444p+2))
(assert_return (invoke "check" (i32.const  8)) (f32.const 0x1.466666p+2))
(assert_return (invoke "check" (i32.const 12)) (f32.const 0x1.488888p+2))

(module
  (memory 1 1)
  (func $init (param $i i32) (param $x f64) (f64.store (get_local $i) (get_local $x)))
  (export "init" $init)

  (func $run (param $n i32) (param $z f64)
    (local $i i32)
    (loop $exit $cont
      (f64.store (get_local $i) (f64.div (f64.load (get_local $i)) (get_local $z)))
      (set_local $i (i32.add (get_local $i) (i32.const 8)))
      (br_if $cont (i32.lt_u (get_local $i) (get_local $n)))
    )
  )
  (export "run" $run)

  (func $check (param $i i32) (result f64) (f64.load (get_local $i)))
  (export "check" $check)
)

(invoke "init" (i32.const  0) (f64.const 15.1))
(invoke "init" (i32.const  8) (f64.const 15.2))
(invoke "init" (i32.const 16) (f64.const 15.3))
(invoke "init" (i32.const 24) (f64.const 15.4))
(assert_return (invoke "check" (i32.const  0)) (f64.const 15.1))
(assert_return (invoke "check" (i32.const  8)) (f64.const 15.2))
(assert_return (invoke "check" (i32.const 16)) (f64.const 15.3))
(assert_return (invoke "check" (i32.const 24)) (f64.const 15.4))
(invoke "run" (i32.const 32) (f64.const 3.0))
(assert_return (invoke "check" (i32.const  0)) (f64.const 0x1.4222222222222p+2))
(assert_return (invoke "check" (i32.const  8)) (f64.const 0x1.4444444444444p+2))
(assert_return (invoke "check" (i32.const 16)) (f64.const 0x1.4666666666667p+2))
(assert_return (invoke "check" (i32.const 24)) (f64.const 0x1.4888888888889p+2))

;; Test that ult/ugt/etc. aren't folded to olt/ogt/etc.

(module
  (func $f32.ult (param $x f32) (param $y f32) (result i32) (i32.eqz (f32.ge (get_local $x) (get_local $y))))
  (func $f32.ule (param $x f32) (param $y f32) (result i32) (i32.eqz (f32.gt (get_local $x) (get_local $y))))
  (func $f32.ugt (param $x f32) (param $y f32) (result i32) (i32.eqz (f32.le (get_local $x) (get_local $y))))
  (func $f32.uge (param $x f32) (param $y f32) (result i32) (i32.eqz (f32.lt (get_local $x) (get_local $y))))

  (func $f64.ult (param $x f64) (param $y f64) (result i32) (i32.eqz (f64.ge (get_local $x) (get_local $y))))
  (func $f64.ule (param $x f64) (param $y f64) (result i32) (i32.eqz (f64.gt (get_local $x) (get_local $y))))
  (func $f64.ugt (param $x f64) (param $y f64) (result i32) (i32.eqz (f64.le (get_local $x) (get_local $y))))
  (func $f64.uge (param $x f64) (param $y f64) (result i32) (i32.eqz (f64.lt (get_local $x) (get_local $y))))

  (export "f32.ult" $f32.ult)
  (export "f32.ule" $f32.ule)
  (export "f32.ugt" $f32.ugt)
  (export "f32.uge" $f32.uge)
  (export "f64.ult" $f64.ult)
  (export "f64.ule" $f64.ule)
  (export "f64.ugt" $f64.ugt)
  (export "f64.uge" $f64.uge)
)

(assert_return (invoke "f32.ult" (f32.const 3.0) (f32.const 2.0)) (i32.const 0))
(assert_return (invoke "f32.ult" (f32.const 2.0) (f32.const 2.0)) (i32.const 0))
(assert_return (invoke "f32.ult" (f32.const 2.0) (f32.const 3.0)) (i32.const 1))
(assert_return (invoke "f32.ult" (f32.const 2.0) (f32.const nan)) (i32.const 1))
(assert_return (invoke "f32.ule" (f32.const 3.0) (f32.const 2.0)) (i32.const 0))
(assert_return (invoke "f32.ule" (f32.const 2.0) (f32.const 2.0)) (i32.const 1))
(assert_return (invoke "f32.ule" (f32.const 2.0) (f32.const 3.0)) (i32.const 1))
(assert_return (invoke "f32.ule" (f32.const 2.0) (f32.const nan)) (i32.const 1))
(assert_return (invoke "f32.ugt" (f32.const 3.0) (f32.const 2.0)) (i32.const 1))
(assert_return (invoke "f32.ugt" (f32.const 2.0) (f32.const 2.0)) (i32.const 0))
(assert_return (invoke "f32.ugt" (f32.const 2.0) (f32.const 3.0)) (i32.const 0))
(assert_return (invoke "f32.ugt" (f32.const 2.0) (f32.const nan)) (i32.const 1))
(assert_return (invoke "f32.uge" (f32.const 3.0) (f32.const 2.0)) (i32.const 1))
(assert_return (invoke "f32.uge" (f32.const 2.0) (f32.const 2.0)) (i32.const 1))
(assert_return (invoke "f32.uge" (f32.const 2.0) (f32.const 3.0)) (i32.const 0))
(assert_return (invoke "f32.uge" (f32.const 2.0) (f32.const nan)) (i32.const 1))
(assert_return (invoke "f64.ult" (f64.const 3.0) (f64.const 2.0)) (i32.const 0))
(assert_return (invoke "f64.ult" (f64.const 2.0) (f64.const 2.0)) (i32.const 0))
(assert_return (invoke "f64.ult" (f64.const 2.0) (f64.const 3.0)) (i32.const 1))
(assert_return (invoke "f64.ult" (f64.const 2.0) (f64.const nan)) (i32.const 1))
(assert_return (invoke "f64.ule" (f64.const 3.0) (f64.const 2.0)) (i32.const 0))
(assert_return (invoke "f64.ule" (f64.const 2.0) (f64.const 2.0)) (i32.const 1))
(assert_return (invoke "f64.ule" (f64.const 2.0) (f64.const 3.0)) (i32.const 1))
(assert_return (invoke "f64.ule" (f64.const 2.0) (f64.const nan)) (i32.const 1))
(assert_return (invoke "f64.ugt" (f64.const 3.0) (f64.const 2.0)) (i32.const 1))
(assert_return (invoke "f64.ugt" (f64.const 2.0) (f64.const 2.0)) (i32.const 0))
(assert_return (invoke "f64.ugt" (f64.const 2.0) (f64.const 3.0)) (i32.const 0))
(assert_return (invoke "f64.ugt" (f64.const 2.0) (f64.const nan)) (i32.const 1))
(assert_return (invoke "f64.uge" (f64.const 3.0) (f64.const 2.0)) (i32.const 1))
(assert_return (invoke "f64.uge" (f64.const 2.0) (f64.const 2.0)) (i32.const 1))
(assert_return (invoke "f64.uge" (f64.const 2.0) (f64.const 3.0)) (i32.const 0))
(assert_return (invoke "f64.uge" (f64.const 2.0) (f64.const nan)) (i32.const 1))

;; Test that x<y?x:y, etc. using select aren't folded to min, etc.

(module
  (func $f32.no_fold_lt_select (param $x f32) (param $y f32) (result f32) (select (get_local $x) (get_local $y) (f32.lt (get_local $x) (get_local $y))))
  (export "f32.no_fold_lt_select" $f32.no_fold_lt_select)
  (func $f32.no_fold_le_select (param $x f32) (param $y f32) (result f32) (select (get_local $x) (get_local $y) (f32.le (get_local $x) (get_local $y))))
  (export "f32.no_fold_le_select" $f32.no_fold_le_select)
  (func $f32.no_fold_gt_select (param $x f32) (param $y f32) (result f32) (select (get_local $x) (get_local $y) (f32.gt (get_local $x) (get_local $y))))
  (export "f32.no_fold_gt_select" $f32.no_fold_gt_select)
  (func $f32.no_fold_ge_select (param $x f32) (param $y f32) (result f32) (select (get_local $x) (get_local $y) (f32.ge (get_local $x) (get_local $y))))
  (export "f32.no_fold_ge_select" $f32.no_fold_ge_select)

  (func $f64.no_fold_lt_select (param $x f64) (param $y f64) (result f64) (select (get_local $x) (get_local $y) (f64.lt (get_local $x) (get_local $y))))
  (export "f64.no_fold_lt_select" $f64.no_fold_lt_select)
  (func $f64.no_fold_le_select (param $x f64) (param $y f64) (result f64) (select (get_local $x) (get_local $y) (f64.le (get_local $x) (get_local $y))))
  (export "f64.no_fold_le_select" $f64.no_fold_le_select)
  (func $f64.no_fold_gt_select (param $x f64) (param $y f64) (result f64) (select (get_local $x) (get_local $y) (f64.gt (get_local $x) (get_local $y))))
  (export "f64.no_fold_gt_select" $f64.no_fold_gt_select)
  (func $f64.no_fold_ge_select (param $x f64) (param $y f64) (result f64) (select (get_local $x) (get_local $y) (f64.ge (get_local $x) (get_local $y))))
  (export "f64.no_fold_ge_select" $f64.no_fold_ge_select)
)

(assert_return (invoke "f32.no_fold_lt_select" (f32.const 0.0) (f32.const nan)) (f32.const nan))
(assert_return (invoke "f32.no_fold_lt_select" (f32.const nan) (f32.const 0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_lt_select" (f32.const 0.0) (f32.const -0.0)) (f32.const -0.0))
(assert_return (invoke "f32.no_fold_lt_select" (f32.const -0.0) (f32.const 0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_le_select" (f32.const 0.0) (f32.const nan)) (f32.const nan))
(assert_return (invoke "f32.no_fold_le_select" (f32.const nan) (f32.const 0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_le_select" (f32.const 0.0) (f32.const -0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_le_select" (f32.const -0.0) (f32.const 0.0)) (f32.const -0.0))
(assert_return (invoke "f32.no_fold_gt_select" (f32.const 0.0) (f32.const nan)) (f32.const nan))
(assert_return (invoke "f32.no_fold_gt_select" (f32.const nan) (f32.const 0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_gt_select" (f32.const 0.0) (f32.const -0.0)) (f32.const -0.0))
(assert_return (invoke "f32.no_fold_gt_select" (f32.const -0.0) (f32.const 0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_ge_select" (f32.const 0.0) (f32.const nan)) (f32.const nan))
(assert_return (invoke "f32.no_fold_ge_select" (f32.const nan) (f32.const 0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_ge_select" (f32.const 0.0) (f32.const -0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_ge_select" (f32.const -0.0) (f32.const 0.0)) (f32.const -0.0))
(assert_return (invoke "f64.no_fold_lt_select" (f64.const 0.0) (f64.const nan)) (f64.const nan))
(assert_return (invoke "f64.no_fold_lt_select" (f64.const nan) (f64.const 0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_lt_select" (f64.const 0.0) (f64.const -0.0)) (f64.const -0.0))
(assert_return (invoke "f64.no_fold_lt_select" (f64.const -0.0) (f64.const 0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_le_select" (f64.const 0.0) (f64.const nan)) (f64.const nan))
(assert_return (invoke "f64.no_fold_le_select" (f64.const nan) (f64.const 0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_le_select" (f64.const 0.0) (f64.const -0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_le_select" (f64.const -0.0) (f64.const 0.0)) (f64.const -0.0))
(assert_return (invoke "f64.no_fold_gt_select" (f64.const 0.0) (f64.const nan)) (f64.const nan))
(assert_return (invoke "f64.no_fold_gt_select" (f64.const nan) (f64.const 0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_gt_select" (f64.const 0.0) (f64.const -0.0)) (f64.const -0.0))
(assert_return (invoke "f64.no_fold_gt_select" (f64.const -0.0) (f64.const 0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_ge_select" (f64.const 0.0) (f64.const nan)) (f64.const nan))
(assert_return (invoke "f64.no_fold_ge_select" (f64.const nan) (f64.const 0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_ge_select" (f64.const 0.0) (f64.const -0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_ge_select" (f64.const -0.0) (f64.const 0.0)) (f64.const -0.0))

;; Test that x<y?x:y, etc. using if and else aren't folded to min, etc.

(module
  (func $f32.no_fold_lt_if (param $x f32) (param $y f32) (result f32) (if (f32.lt (get_local $x) (get_local $y)) (get_local $x) (get_local $y)))
  (export "f32.no_fold_lt_if" $f32.no_fold_lt_if)
  (func $f32.no_fold_le_if (param $x f32) (param $y f32) (result f32) (if (f32.le (get_local $x) (get_local $y)) (get_local $x) (get_local $y)))
  (export "f32.no_fold_le_if" $f32.no_fold_le_if)
  (func $f32.no_fold_gt_if (param $x f32) (param $y f32) (result f32) (if (f32.gt (get_local $x) (get_local $y)) (get_local $x) (get_local $y)))
  (export "f32.no_fold_gt_if" $f32.no_fold_gt_if)
  (func $f32.no_fold_ge_if (param $x f32) (param $y f32) (result f32) (if (f32.ge (get_local $x) (get_local $y)) (get_local $x) (get_local $y)))
  (export "f32.no_fold_ge_if" $f32.no_fold_ge_if)

  (func $f64.no_fold_lt_if (param $x f64) (param $y f64) (result f64) (if (f64.lt (get_local $x) (get_local $y)) (get_local $x) (get_local $y)))
  (export "f64.no_fold_lt_if" $f64.no_fold_lt_if)
  (func $f64.no_fold_le_if (param $x f64) (param $y f64) (result f64) (if (f64.le (get_local $x) (get_local $y)) (get_local $x) (get_local $y)))
  (export "f64.no_fold_le_if" $f64.no_fold_le_if)
  (func $f64.no_fold_gt_if (param $x f64) (param $y f64) (result f64) (if (f64.gt (get_local $x) (get_local $y)) (get_local $x) (get_local $y)))
  (export "f64.no_fold_gt_if" $f64.no_fold_gt_if)
  (func $f64.no_fold_ge_if (param $x f64) (param $y f64) (result f64) (if (f64.ge (get_local $x) (get_local $y)) (get_local $x) (get_local $y)))
  (export "f64.no_fold_ge_if" $f64.no_fold_ge_if)
)

(assert_return (invoke "f32.no_fold_lt_if" (f32.const 0.0) (f32.const nan)) (f32.const nan))
(assert_return (invoke "f32.no_fold_lt_if" (f32.const nan) (f32.const 0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_lt_if" (f32.const 0.0) (f32.const -0.0)) (f32.const -0.0))
(assert_return (invoke "f32.no_fold_lt_if" (f32.const -0.0) (f32.const 0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_le_if" (f32.const 0.0) (f32.const nan)) (f32.const nan))
(assert_return (invoke "f32.no_fold_le_if" (f32.const nan) (f32.const 0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_le_if" (f32.const 0.0) (f32.const -0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_le_if" (f32.const -0.0) (f32.const 0.0)) (f32.const -0.0))
(assert_return (invoke "f32.no_fold_gt_if" (f32.const 0.0) (f32.const nan)) (f32.const nan))
(assert_return (invoke "f32.no_fold_gt_if" (f32.const nan) (f32.const 0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_gt_if" (f32.const 0.0) (f32.const -0.0)) (f32.const -0.0))
(assert_return (invoke "f32.no_fold_gt_if" (f32.const -0.0) (f32.const 0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_ge_if" (f32.const 0.0) (f32.const nan)) (f32.const nan))
(assert_return (invoke "f32.no_fold_ge_if" (f32.const nan) (f32.const 0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_ge_if" (f32.const 0.0) (f32.const -0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_ge_if" (f32.const -0.0) (f32.const 0.0)) (f32.const -0.0))
(assert_return (invoke "f64.no_fold_lt_if" (f64.const 0.0) (f64.const nan)) (f64.const nan))
(assert_return (invoke "f64.no_fold_lt_if" (f64.const nan) (f64.const 0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_lt_if" (f64.const 0.0) (f64.const -0.0)) (f64.const -0.0))
(assert_return (invoke "f64.no_fold_lt_if" (f64.const -0.0) (f64.const 0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_le_if" (f64.const 0.0) (f64.const nan)) (f64.const nan))
(assert_return (invoke "f64.no_fold_le_if" (f64.const nan) (f64.const 0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_le_if" (f64.const 0.0) (f64.const -0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_le_if" (f64.const -0.0) (f64.const 0.0)) (f64.const -0.0))
(assert_return (invoke "f64.no_fold_gt_if" (f64.const 0.0) (f64.const nan)) (f64.const nan))
(assert_return (invoke "f64.no_fold_gt_if" (f64.const nan) (f64.const 0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_gt_if" (f64.const 0.0) (f64.const -0.0)) (f64.const -0.0))
(assert_return (invoke "f64.no_fold_gt_if" (f64.const -0.0) (f64.const 0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_ge_if" (f64.const 0.0) (f64.const nan)) (f64.const nan))
(assert_return (invoke "f64.no_fold_ge_if" (f64.const nan) (f64.const 0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_ge_if" (f64.const 0.0) (f64.const -0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_ge_if" (f64.const -0.0) (f64.const 0.0)) (f64.const -0.0))

;; Test that x<0?-x:0, etc. using select aren't folded to abs

(module
  (func $f32.no_fold_lt_select_to_abs (param $x f32) (result f32) (select (f32.neg (get_local $x)) (get_local $x) (f32.lt (get_local $x) (f32.const 0.0))))
  (export "f32.no_fold_lt_select_to_abs" $f32.no_fold_lt_select_to_abs)
  (func $f32.no_fold_le_select_to_abs (param $x f32) (result f32) (select (f32.neg (get_local $x)) (get_local $x) (f32.le (get_local $x) (f32.const -0.0))))
  (export "f32.no_fold_le_select_to_abs" $f32.no_fold_le_select_to_abs)
  (func $f32.no_fold_gt_select_to_abs (param $x f32) (result f32) (select (get_local $x) (f32.neg (get_local $x)) (f32.gt (get_local $x) (f32.const -0.0))))
  (export "f32.no_fold_gt_select_to_abs" $f32.no_fold_gt_select_to_abs)
  (func $f32.no_fold_ge_select_to_abs (param $x f32) (result f32) (select (get_local $x) (f32.neg (get_local $x)) (f32.ge (get_local $x) (f32.const 0.0))))
  (export "f32.no_fold_ge_select_to_abs" $f32.no_fold_ge_select_to_abs)

  (func $f64.no_fold_lt_select_to_abs (param $x f64) (result f64) (select (f64.neg (get_local $x)) (get_local $x) (f64.lt (get_local $x) (f64.const 0.0))))
  (export "f64.no_fold_lt_select_to_abs" $f64.no_fold_lt_select_to_abs)
  (func $f64.no_fold_le_select_to_abs (param $x f64) (result f64) (select (f64.neg (get_local $x)) (get_local $x) (f64.le (get_local $x) (f64.const -0.0))))
  (export "f64.no_fold_le_select_to_abs" $f64.no_fold_le_select_to_abs)
  (func $f64.no_fold_gt_select_to_abs (param $x f64) (result f64) (select (get_local $x) (f64.neg (get_local $x)) (f64.gt (get_local $x) (f64.const -0.0))))
  (export "f64.no_fold_gt_select_to_abs" $f64.no_fold_gt_select_to_abs)
  (func $f64.no_fold_ge_select_to_abs (param $x f64) (result f64) (select (get_local $x) (f64.neg (get_local $x)) (f64.ge (get_local $x) (f64.const 0.0))))
  (export "f64.no_fold_ge_select_to_abs" $f64.no_fold_ge_select_to_abs)
)

(assert_return (invoke "f32.no_fold_lt_select_to_abs" (f32.const nan:0x200000)) (f32.const nan:0x200000))
(assert_return (invoke "f32.no_fold_lt_select_to_abs" (f32.const -nan)) (f32.const -nan))
(assert_return (invoke "f32.no_fold_lt_select_to_abs" (f32.const 0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_lt_select_to_abs" (f32.const -0.0)) (f32.const -0.0))
(assert_return (invoke "f32.no_fold_le_select_to_abs" (f32.const nan:0x200000)) (f32.const nan:0x200000))
(assert_return (invoke "f32.no_fold_le_select_to_abs" (f32.const -nan)) (f32.const -nan))
(assert_return (invoke "f32.no_fold_le_select_to_abs" (f32.const 0.0)) (f32.const -0.0))
(assert_return (invoke "f32.no_fold_le_select_to_abs" (f32.const -0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_gt_select_to_abs" (f32.const nan:0x200000)) (f32.const -nan:0x200000))
(assert_return (invoke "f32.no_fold_gt_select_to_abs" (f32.const -nan)) (f32.const nan))
(assert_return (invoke "f32.no_fold_gt_select_to_abs" (f32.const 0.0)) (f32.const -0.0))
(assert_return (invoke "f32.no_fold_gt_select_to_abs" (f32.const -0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_ge_select_to_abs" (f32.const nan:0x200000)) (f32.const -nan:0x200000))
(assert_return (invoke "f32.no_fold_ge_select_to_abs" (f32.const -nan)) (f32.const nan))
(assert_return (invoke "f32.no_fold_ge_select_to_abs" (f32.const 0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_ge_select_to_abs" (f32.const -0.0)) (f32.const -0.0))
(assert_return (invoke "f64.no_fold_lt_select_to_abs" (f64.const nan:0x4000000000000)) (f64.const nan:0x4000000000000))
(assert_return (invoke "f64.no_fold_lt_select_to_abs" (f64.const -nan)) (f64.const -nan))
(assert_return (invoke "f64.no_fold_lt_select_to_abs" (f64.const 0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_lt_select_to_abs" (f64.const -0.0)) (f64.const -0.0))
(assert_return (invoke "f64.no_fold_le_select_to_abs" (f64.const nan:0x4000000000000)) (f64.const nan:0x4000000000000))
(assert_return (invoke "f64.no_fold_le_select_to_abs" (f64.const -nan)) (f64.const -nan))
(assert_return (invoke "f64.no_fold_le_select_to_abs" (f64.const 0.0)) (f64.const -0.0))
(assert_return (invoke "f64.no_fold_le_select_to_abs" (f64.const -0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_gt_select_to_abs" (f64.const nan:0x4000000000000)) (f64.const -nan:0x4000000000000))
(assert_return (invoke "f64.no_fold_gt_select_to_abs" (f64.const -nan)) (f64.const nan))
(assert_return (invoke "f64.no_fold_gt_select_to_abs" (f64.const 0.0)) (f64.const -0.0))
(assert_return (invoke "f64.no_fold_gt_select_to_abs" (f64.const -0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_ge_select_to_abs" (f64.const nan:0x4000000000000)) (f64.const -nan:0x4000000000000))
(assert_return (invoke "f64.no_fold_ge_select_to_abs" (f64.const -nan)) (f64.const nan))
(assert_return (invoke "f64.no_fold_ge_select_to_abs" (f64.const 0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_ge_select_to_abs" (f64.const -0.0)) (f64.const -0.0))

;; Test that x<0?-x:0, etc. using if aren't folded to abs

(module
  (func $f32.no_fold_lt_if_to_abs (param $x f32) (result f32) (if (f32.lt (get_local $x) (f32.const 0.0)) (f32.neg (get_local $x)) (get_local $x)))
  (export "f32.no_fold_lt_if_to_abs" $f32.no_fold_lt_if_to_abs)
  (func $f32.no_fold_le_if_to_abs (param $x f32) (result f32) (if (f32.le (get_local $x) (f32.const -0.0)) (f32.neg (get_local $x)) (get_local $x)))
  (export "f32.no_fold_le_if_to_abs" $f32.no_fold_le_if_to_abs)
  (func $f32.no_fold_gt_if_to_abs (param $x f32) (result f32) (if (f32.gt (get_local $x) (f32.const -0.0)) (get_local $x) (f32.neg (get_local $x))))
  (export "f32.no_fold_gt_if_to_abs" $f32.no_fold_gt_if_to_abs)
  (func $f32.no_fold_ge_if_to_abs (param $x f32) (result f32) (if (f32.ge (get_local $x) (f32.const 0.0)) (get_local $x) (f32.neg (get_local $x))))
  (export "f32.no_fold_ge_if_to_abs" $f32.no_fold_ge_if_to_abs)

  (func $f64.no_fold_lt_if_to_abs (param $x f64) (result f64) (if (f64.lt (get_local $x) (f64.const 0.0)) (f64.neg (get_local $x)) (get_local $x)))
  (export "f64.no_fold_lt_if_to_abs" $f64.no_fold_lt_if_to_abs)
  (func $f64.no_fold_le_if_to_abs (param $x f64) (result f64) (if (f64.le (get_local $x) (f64.const -0.0)) (f64.neg (get_local $x)) (get_local $x)))
  (export "f64.no_fold_le_if_to_abs" $f64.no_fold_le_if_to_abs)
  (func $f64.no_fold_gt_if_to_abs (param $x f64) (result f64) (if (f64.gt (get_local $x) (f64.const -0.0)) (get_local $x) (f64.neg (get_local $x))))
  (export "f64.no_fold_gt_if_to_abs" $f64.no_fold_gt_if_to_abs)
  (func $f64.no_fold_ge_if_to_abs (param $x f64) (result f64) (if (f64.ge (get_local $x) (f64.const 0.0)) (get_local $x) (f64.neg (get_local $x))))
  (export "f64.no_fold_ge_if_to_abs" $f64.no_fold_ge_if_to_abs)
)

(assert_return (invoke "f32.no_fold_lt_if_to_abs" (f32.const nan:0x200000)) (f32.const nan:0x200000))
(assert_return (invoke "f32.no_fold_lt_if_to_abs" (f32.const -nan)) (f32.const -nan))
(assert_return (invoke "f32.no_fold_lt_if_to_abs" (f32.const 0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_lt_if_to_abs" (f32.const -0.0)) (f32.const -0.0))
(assert_return (invoke "f32.no_fold_le_if_to_abs" (f32.const nan:0x200000)) (f32.const nan:0x200000))
(assert_return (invoke "f32.no_fold_le_if_to_abs" (f32.const -nan)) (f32.const -nan))
(assert_return (invoke "f32.no_fold_le_if_to_abs" (f32.const 0.0)) (f32.const -0.0))
(assert_return (invoke "f32.no_fold_le_if_to_abs" (f32.const -0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_gt_if_to_abs" (f32.const nan:0x200000)) (f32.const -nan:0x200000))
(assert_return (invoke "f32.no_fold_gt_if_to_abs" (f32.const -nan)) (f32.const nan))
(assert_return (invoke "f32.no_fold_gt_if_to_abs" (f32.const 0.0)) (f32.const -0.0))
(assert_return (invoke "f32.no_fold_gt_if_to_abs" (f32.const -0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_ge_if_to_abs" (f32.const nan:0x200000)) (f32.const -nan:0x200000))
(assert_return (invoke "f32.no_fold_ge_if_to_abs" (f32.const -nan)) (f32.const nan))
(assert_return (invoke "f32.no_fold_ge_if_to_abs" (f32.const 0.0)) (f32.const 0.0))
(assert_return (invoke "f32.no_fold_ge_if_to_abs" (f32.const -0.0)) (f32.const -0.0))
(assert_return (invoke "f64.no_fold_lt_if_to_abs" (f64.const nan:0x4000000000000)) (f64.const nan:0x4000000000000))
(assert_return (invoke "f64.no_fold_lt_if_to_abs" (f64.const -nan)) (f64.const -nan))
(assert_return (invoke "f64.no_fold_lt_if_to_abs" (f64.const 0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_lt_if_to_abs" (f64.const -0.0)) (f64.const -0.0))
(assert_return (invoke "f64.no_fold_le_if_to_abs" (f64.const nan:0x4000000000000)) (f64.const nan:0x4000000000000))
(assert_return (invoke "f64.no_fold_le_if_to_abs" (f64.const -nan)) (f64.const -nan))
(assert_return (invoke "f64.no_fold_le_if_to_abs" (f64.const 0.0)) (f64.const -0.0))
(assert_return (invoke "f64.no_fold_le_if_to_abs" (f64.const -0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_gt_if_to_abs" (f64.const nan:0x4000000000000)) (f64.const -nan:0x4000000000000))
(assert_return (invoke "f64.no_fold_gt_if_to_abs" (f64.const -nan)) (f64.const nan))
(assert_return (invoke "f64.no_fold_gt_if_to_abs" (f64.const 0.0)) (f64.const -0.0))
(assert_return (invoke "f64.no_fold_gt_if_to_abs" (f64.const -0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_ge_if_to_abs" (f64.const nan:0x4000000000000)) (f64.const -nan:0x4000000000000))
(assert_return (invoke "f64.no_fold_ge_if_to_abs" (f64.const -nan)) (f64.const nan))
(assert_return (invoke "f64.no_fold_ge_if_to_abs" (f64.const 0.0)) (f64.const 0.0))
(assert_return (invoke "f64.no_fold_ge_if_to_abs" (f64.const -0.0)) (f64.const -0.0))

;; Test for a historic spreadsheet bug.
;; https://support.microsoft.com/en-us/kb/78113

(module
  (func $incorrect_correction (result f32)
    (f32.sub (f32.sub (f32.add (f32.const 1.333) (f32.const 1.225)) (f32.const 1.333)) (f32.const 1.225))
  )
  (export "incorrect_correction" $incorrect_correction)
)

(assert_return (invoke "incorrect_correction") (f32.const 0x1p-23))

(module
  (func $incorrect_correction (result f64)
    (f64.sub (f64.sub (f64.add (f64.const 1.333) (f64.const 1.225)) (f64.const 1.333)) (f64.const 1.225))
  )
  (export "incorrect_correction" $incorrect_correction)
)

(assert_return (invoke "incorrect_correction") (f64.const -0x1p-52))

;; Test for a historical calculator bug.
;; http://www.hpmuseum.org/cgi-sys/cgiwrap/hpmuseum/articles.cgi?read=735

(module
  (func $calculate (result f32)
    (local $x f32)
    (local $r f32)
    (local $q f32)
    (local $z0 f32)
    (local $z1 f32)
    (set_local $x (f32.const 156.25))
    (set_local $r (f32.const 208.333333334))
    (set_local $q (f32.const 1.77951304201))
    (set_local $z0 (f32.div (f32.mul (f32.neg (get_local $r)) (get_local $x)) (f32.sub (f32.mul (get_local $x) (get_local $q)) (get_local $r))))
    (set_local $z1 (f32.div (f32.mul (f32.neg (get_local $r)) (get_local $x)) (f32.sub (f32.mul (get_local $x) (get_local $q)) (get_local $r))))
    (block (br_if 0 (f32.eq (get_local $z0) (get_local $z1))) (unreachable))
    (get_local $z1)
  )
  (export "calculate" $calculate)
)

(assert_return (invoke "calculate") (f32.const -0x1.d2ed46p+8))

(module
  (func $calculate (result f64)
    (local $x f64)
    (local $r f64)
    (local $q f64)
    (local $z0 f64)
    (local $z1 f64)
    (set_local $x (f64.const 156.25))
    (set_local $r (f64.const 208.333333334))
    (set_local $q (f64.const 1.77951304201))
    (set_local $z0 (f64.div (f64.mul (f64.neg (get_local $r)) (get_local $x)) (f64.sub (f64.mul (get_local $x) (get_local $q)) (get_local $r))))
    (set_local $z1 (f64.div (f64.mul (f64.neg (get_local $r)) (get_local $x)) (f64.sub (f64.mul (get_local $x) (get_local $q)) (get_local $r))))
    (block (br_if 0 (f64.eq (get_local $z0) (get_local $z1))) (unreachable))
    (get_local $z1)
  )
  (export "calculate" $calculate)
)

(assert_return (invoke "calculate") (f64.const -0x1.d2ed4d0218c93p+8))

;; Test that 0 - (-0 - x) is not optimized to x.
;; https://llvm.org/bugs/show_bug.cgi?id=26746

(module
  (func $llvm_pr26746 (param $x f32) (result f32)
    (f32.sub (f32.const 0.0) (f32.sub (f32.const -0.0) (get_local $x)))
  )
  (export "llvm_pr26746" $llvm_pr26746)
)

(assert_return (invoke "llvm_pr26746" (f32.const -0.0)) (f32.const 0.0))

;; Test for improperly reassociating an addition and a conversion.
;; https://llvm.org/bugs/show_bug.cgi?id=27153

(module
  (func $llvm_pr27153 (param $x i32) (result f32)
    (f32.add (f32.convert_s/i32 (i32.and (get_local $x) (i32.const 268435455))) (f32.const -8388608.0))
  )
  (export "llvm_pr27153" $llvm_pr27153)
)

(assert_return (invoke "llvm_pr27153" (i32.const 33554434)) (f32.const 25165824.000000))

;; Test that (float)x + (float)y is not optimzied to (float)(x + y) when unsafe.
;; https://llvm.org/bugs/show_bug.cgi?id=27036

(module
  (func $llvm_pr27036 (param $x i32) (param $y i32) (result f32)
    (f32.add (f32.convert_s/i32 (i32.or (get_local $x) (i32.const -25034805)))
             (f32.convert_s/i32 (i32.and (get_local $y) (i32.const 14942208))))
  )
  (export "llvm_pr27936" $llvm_pr27036)
)

(assert_return (invoke "llvm_pr27936" (i32.const -25034805) (i32.const 14942208)) (f32.const -0x1.340068p+23))

;; Test for bugs in old versions of historic IEEE 754 platforms as reported in:
;;
;; N. L. Schryer. 1981. A Test of a Computer's Floating-Point Arithmetic Unit.
;; Tech. Rep. Computer Science Technical Report 89, AT&T Bell Laboratories, Feb.
;;
;; specifically, the appendices describing IEEE systems with "The Past" sections
;; describing specific bugs. The 0 < 0 bug is omitted here due to being already
;; covered elsewhere.
(module
  (func $thepast0 (param $a f64) (param $b f64) (param $c f64) (param $d f64) (result f64)
    (f64.div (f64.mul (get_local $a) (get_local $b)) (f64.mul (get_local $c) (get_local $d)))
  )
  (export "thepast0" $thepast0)

  (func $thepast1 (param $a f64) (param $b f64) (param $c f64) (result f64)
    (f64.sub (f64.mul (get_local $a) (get_local $b)) (get_local $c))
  )
  (export "thepast1" $thepast1)

  (func $thepast2 (param $a f32) (param $b f32) (param $c f32) (result f32)
    (f32.mul (f32.mul (get_local $a) (get_local $b)) (get_local $c))
  )
  (export "thepast2" $thepast2)
)

(assert_return (invoke "thepast0" (f64.const 0x1p-1021) (f64.const 0x1.fffffffffffffp-1) (f64.const 0x1p1) (f64.const 0x1p-1)) (f64.const 0x1.fffffffffffffp-1022))
(assert_return (invoke "thepast1" (f64.const 0x1p-54) (f64.const 0x1.fffffffffffffp-1) (f64.const 0x1p-54)) (f64.const -0x1p-107))
(assert_return (invoke "thepast2" (f32.const 0x1p-125) (f32.const 0x1p-1) (f32.const 0x1p0)) (f32.const 0x1p-126))

;; Test for floating point tolerances observed in some GPUs.
;; https://community.amd.com/thread/145582

(module
  (func $inverse (param $x f32) (result f32)
    (f32.div (f32.const 1.0) (get_local $x))
  )
  (export "inverse" $inverse)
)

(assert_return (invoke "inverse" (f32.const 96.0)) (f32.const 0x1.555556p-7))

(module
  (func $f32.add (param $x f32) (param $y f32) (result f32) (f32.add (get_local $x) (get_local $y)))
  (func $f32.sub (param $x f32) (param $y f32) (result f32) (f32.sub (get_local $x) (get_local $y)))
  (func $f32.mul (param $x f32) (param $y f32) (result f32) (f32.mul (get_local $x) (get_local $y)))
  (func $f32.div (param $x f32) (param $y f32) (result f32) (f32.div (get_local $x) (get_local $y)))
  (func $f32.sqrt (param $x f32) (result f32) (f32.sqrt (get_local $x)))
  (func $f32.abs (param $x f32) (result f32) (f32.abs (get_local $x)))
  (func $f32.neg (param $x f32) (result f32) (f32.neg (get_local $x)))
  (func $f32.copysign (param $x f32) (param $y f32) (result f32) (f32.copysign (get_local $x) (get_local $y)))
  (func $f32.ceil (param $x f32) (result f32) (f32.ceil (get_local $x)))
  (func $f32.floor (param $x f32) (result f32) (f32.floor (get_local $x)))
  (func $f32.trunc (param $x f32) (result f32) (f32.trunc (get_local $x)))
  (func $f32.nearest (param $x f32) (result f32) (f32.nearest (get_local $x)))

  (func $f64.add (param $x f64) (param $y f64) (result f64) (f64.add (get_local $x) (get_local $y)))
  (func $f64.sub (param $x f64) (param $y f64) (result f64) (f64.sub (get_local $x) (get_local $y)))
  (func $f64.mul (param $x f64) (param $y f64) (result f64) (f64.mul (get_local $x) (get_local $y)))
  (func $f64.div (param $x f64) (param $y f64) (result f64) (f64.div (get_local $x) (get_local $y)))
  (func $f64.sqrt (param $x f64) (result f64) (f64.sqrt (get_local $x)))
  (func $f64.abs (param $x f64) (result f64) (f64.abs (get_local $x)))
  (func $f64.neg (param $x f64) (result f64) (f64.neg (get_local $x)))
  (func $f64.copysign (param $x f64) (param $y f64) (result f64) (f64.copysign (get_local $x) (get_local $y)))
  (func $f64.ceil (param $x f64) (result f64) (f64.ceil (get_local $x)))
  (func $f64.floor (param $x f64) (result f64) (f64.floor (get_local $x)))
  (func $f64.trunc (param $x f64) (result f64) (f64.trunc (get_local $x)))
  (func $f64.nearest (param $x f64) (result f64) (f64.nearest (get_local $x)))

  (export "f32.add" $f32.add)
  (export "f32.sub" $f32.sub)
  (export "f32.mul" $f32.mul)
  (export "f32.div" $f32.div)
  (export "f32.sqrt" $f32.sqrt)
  (export "f32.abs" $f32.abs)
  (export "f32.neg" $f32.neg)
  (export "f32.copysign" $f32.copysign)
  (export "f32.ceil" $f32.ceil)
  (export "f32.floor" $f32.floor)
  (export "f32.trunc" $f32.trunc)
  (export "f32.nearest" $f32.nearest)

  (export "f64.add" $f64.add)
  (export "f64.sub" $f64.sub)
  (export "f64.mul" $f64.mul)
  (export "f64.div" $f64.div)
  (export "f64.sqrt" $f64.sqrt)
  (export "f64.abs" $f64.abs)
  (export "f64.neg" $f64.neg)
  (export "f64.copysign" $f64.copysign)
  (export "f64.ceil" $f64.ceil)
  (export "f64.floor" $f64.floor)
  (export "f64.trunc" $f64.trunc)
  (export "f64.nearest" $f64.nearest)
)

(assert_return (invoke "f32.add" (f32.const 1.1234567890) (f32.const 1.2345e-10)) (f32.const 1.123456789))

;; Computations that round differently in ties-to-odd mode.
(assert_return (invoke "f32.add" (f32.const 0x1p23) (f32.const 0x1p-1)) (f32.const 0x1p23))
(assert_return (invoke "f32.add" (f32.const 0x1.000002p+23) (f32.const 0x1p-1)) (f32.const 0x1.000004p+23))

;; Test that what some systems call signalling NaN behaves as a quiet NaN.
(assert_return_nan (invoke "f32.add" (f32.const nan(0x200000)) (f32.const 1.0)))

(assert_return (invoke "f64.add" (f64.const 1.1234567890) (f64.const 1.2345e-10)) (f64.const 0x1.1f9add37c11f7p+0))

;; Computations that round differently in round-to-odd mode.
(assert_return (invoke "f64.add" (f64.const 0x1p52) (f64.const 0x1p-1)) (f64.const 0x1p52))
(assert_return (invoke "f64.add" (f64.const 0x1.0000000000001p+52) (f64.const 0x1p-1)) (f64.const 0x1.0000000000002p+52))

;; Computations that round differently in round-upward mode.
(assert_return (invoke "f64.add" (f64.const 0x1.f33e1fbca27aap-413) (f64.const -0x1.6b192891ed61p+249)) (f64.const -0x1.6b192891ed61p+249))
(assert_return (invoke "f64.add" (f64.const -0x1.46f75d130eeb1p+76) (f64.const 0x1.25275d6f7a4acp-184)) (f64.const -0x1.46f75d130eeb1p+76))
(assert_return (invoke "f64.add" (f64.const 0x1.04dec9265a731p-148) (f64.const -0x1.11eed4e8c127cp-12)) (f64.const -0x1.11eed4e8c127cp-12))
(assert_return (invoke "f64.add" (f64.const 0x1.05773b7166b0ap+497) (f64.const 0x1.134022f2da37bp+66)) (f64.const 0x1.05773b7166b0ap+497))
(assert_return (invoke "f64.add" (f64.const 0x1.ef4f794282a82p+321) (f64.const 0x1.14a82266badep+394)) (f64.const 0x1.14a82266badep+394))

;; Computations that round differently in round-doward mode.
(assert_return (invoke "f64.add" (f64.const 0x1.f8dd15ca97d4ap+179) (f64.const -0x1.367317d1fe8bfp-527)) (f64.const 0x1.f8dd15ca97d4ap+179))
(assert_return (invoke "f64.add" (f64.const 0x1.5db08d739228cp+155) (f64.const -0x1.fb316fa147dcbp-61)) (f64.const 0x1.5db08d739228cp+155))
(assert_return (invoke "f64.add" (f64.const 0x1.bbb403cb85c07p-404) (f64.const -0x1.7e44046b8bbf3p-979)) (f64.const 0x1.bbb403cb85c07p-404))
(assert_return (invoke "f64.add" (f64.const -0x1.34d38af291831p+147) (f64.const -0x1.9890b47439953p+139)) (f64.const -0x1.366c1ba705bcap+147))
(assert_return (invoke "f64.add" (f64.const -0x1.b61dedf4e0306p+3) (f64.const 0x1.09e2f31773c4ap+290)) (f64.const 0x1.09e2f31773c4ap+290))

;; Computations that round differently in round-toward-zero mode.
(assert_return (invoke "f64.add" (f64.const 0x1.bf68acc263a0fp-777) (f64.const -0x1.5f9352965e5a6p+1004)) (f64.const -0x1.5f9352965e5a6p+1004))
(assert_return (invoke "f64.add" (f64.const -0x1.76eaa70911f51p+516) (f64.const -0x1.2d746324ce47ap+493)) (f64.const -0x1.76eaa963fabb6p+516))
(assert_return (invoke "f64.add" (f64.const -0x1.b637d82c15a7ap-967) (f64.const 0x1.cc654ccab4152p-283)) (f64.const 0x1.cc654ccab4152p-283))
(assert_return (invoke "f64.add" (f64.const -0x1.a5b1fb66e846ep-509) (f64.const 0x1.4bdd36f0bb5ccp-860)) (f64.const -0x1.a5b1fb66e846ep-509))
(assert_return (invoke "f64.add" (f64.const -0x1.14108da880f9ep+966) (f64.const 0x1.417f35701e89fp+800)) (f64.const -0x1.14108da880f9ep+966))

;; Computations that round differently on x87.
(assert_return (invoke "f64.add" (f64.const -0x1.fa0caf21ffebcp+804) (f64.const 0x1.4ca8fdcff89f9p+826)) (f64.const 0x1.4ca8f5e7c5e31p+826))
(assert_return (invoke "f64.add" (f64.const 0x1.016f1fcbdfd38p+784) (f64.const 0x1.375dffcbc9a2cp+746)) (f64.const 0x1.016f1fcbe4b0fp+784))
(assert_return (invoke "f64.add" (f64.const -0x1.dffda6d5bff3ap+624) (f64.const 0x1.f9e8cc2dff782p+674)) (f64.const 0x1.f9e8cc2dff77bp+674))
(assert_return (invoke "f64.add" (f64.const 0x1.fff4b43687dfbp+463) (f64.const 0x1.0fd5617c4a809p+517)) (f64.const 0x1.0fd5617c4a809p+517))
(assert_return (invoke "f64.add" (f64.const 0x1.535d380035da2p-995) (f64.const 0x1.cce37dddbb73bp-963)) (f64.const 0x1.cce37ddf0ed0fp-963))

;; Computations that round differently when computed via f32.
(assert_return (invoke "f64.add" (f64.const -0x1.d91cd3fc0c66fp+752) (f64.const -0x1.4e18c80229734p+952)) (f64.const -0x1.4e18c80229734p+952))
(assert_return (invoke "f64.add" (f64.const 0x1.afc70fd36e372p+193) (f64.const -0x1.bd10a9b377b46p+273)) (f64.const -0x1.bd10a9b377b46p+273))
(assert_return (invoke "f64.add" (f64.const -0x1.2abd570b078b2p+302) (f64.const 0x1.b3c1ad759cb5bp-423)) (f64.const -0x1.2abd570b078b2p+302))
(assert_return (invoke "f64.add" (f64.const -0x1.5b2ae84c0686cp-317) (f64.const -0x1.dba7a1c022823p+466)) (f64.const -0x1.dba7a1c022823p+466))
(assert_return (invoke "f64.add" (f64.const -0x1.ac627bd7cbf38p-198) (f64.const 0x1.2312e265b8d59p-990)) (f64.const -0x1.ac627bd7cbf38p-198))

;; Computations that utilize the maximum exponent value to avoid overflow.
(assert_return (invoke "f64.add" (f64.const -0x1.397be95d10fddp+719) (f64.const -0x1.e13909d198d32p+1023)) (f64.const -0x1.e13909d198d32p+1023))
(assert_return (invoke "f64.add" (f64.const -0x1.234a5a0412f41p+1023) (f64.const -0x1.53e9106c9367p+161)) (f64.const -0x1.234a5a0412f41p+1023))
(assert_return (invoke "f64.add" (f64.const -0x1.a86bdb66cbb32p+562) (f64.const 0x1.d10ff29e1d6e8p+1023)) (f64.const 0x1.d10ff29e1d6e8p+1023))
(assert_return (invoke "f64.add" (f64.const -0x1.dc295727a06e2p+1023) (f64.const 0x1.5e6979d7b24fp+485)) (f64.const -0x1.dc295727a06e2p+1023))
(assert_return (invoke "f64.add" (f64.const -0x1.3ff7dee2861c6p-557) (f64.const 0x1.84a2c18238b4cp+1023)) (f64.const 0x1.84a2c18238b4cp+1023))

;; Computations that utilize the minimum exponent value.
(assert_return (invoke "f64.add" (f64.const -0x0.2d2c9b631ae47p-1022) (f64.const -0x0.8e173a51d11a7p-1022)) (f64.const -0x0.bb43d5b4ebfeep-1022))
(assert_return (invoke "f64.add" (f64.const -0x0.ce7d534f2c7ep-1022) (f64.const -0x0.32f94dc4b7ee5p-1022)) (f64.const -0x1.0176a113e46c5p-1022))
(assert_return (invoke "f64.add" (f64.const -0x1.44d9fb78bf5d3p-1021) (f64.const -0x0.02766a20d263fp-1022)) (f64.const -0x1.46153089288f2p-1021))
(assert_return (invoke "f64.add" (f64.const 0x0.89e17f0fdc567p-1022) (f64.const -0x1.d9a93a01fd27dp-1021)) (f64.const -0x1.94b87a7a0efcap-1021))
(assert_return (invoke "f64.add" (f64.const -0x0.3f3d1a052fa2bp-1022) (f64.const -0x1.4b78292c7d2adp-1021)) (f64.const -0x1.6b16b62f14fc2p-1021))

;; Test that what some systems call signalling NaN behaves as a quiet NaN.
(assert_return_nan (invoke "f64.add" (f64.const nan(0x4000000000000)) (f64.const 1.0)))

;; Computations that round differently on x87.
(assert_return (invoke "f64.sub" (f64.const 0x1.c21151a709b6cp-78) (f64.const 0x1.0a12fff8910f6p-115)) (f64.const 0x1.c21151a701663p-78))
(assert_return (invoke "f64.sub" (f64.const 0x1.c57912aae2f64p-982) (f64.const 0x1.dbfbd4800b7cfp-1010)) (f64.const 0x1.c579128d2338fp-982))
(assert_return (invoke "f64.sub" (f64.const 0x1.ffef4399af9c6p-254) (f64.const 0x1.edb96dfaea8b1p-200)) (f64.const -0x1.edb96dfaea8b1p-200))
(assert_return (invoke "f64.sub" (f64.const -0x1.363eee391cde2p-39) (f64.const -0x1.a65462000265fp-69)) (f64.const -0x1.363eee32838c9p-39))
(assert_return (invoke "f64.sub" (f64.const 0x1.59016dba002a1p-25) (f64.const 0x1.5d4374f124cccp-3)) (f64.const -0x1.5d436f8d1f15dp-3))

(assert_return (invoke "f32.mul" (f32.const 1e15) (f32.const 1e15)) (f32.const 0x1.93e592p+99))
(assert_return (invoke "f32.mul" (f32.const 1e20) (f32.const 1e20)) (f32.const infinity))
(assert_return (invoke "f32.mul" (f32.const 1e25) (f32.const 1e25)) (f32.const infinity))

(assert_return (invoke "f64.mul" (f64.const 1e15) (f64.const 1e15)) (f64.const 0x1.93e5939a08ceap+99))
(assert_return (invoke "f64.mul" (f64.const 1e20) (f64.const 1e20)) (f64.const 0x1.d6329f1c35ca5p+132))
(assert_return (invoke "f64.mul" (f64.const 1e25) (f64.const 1e25)) (f64.const 0x1.11b0ec57e649bp+166))

;; Computations that round differently on x87.
(assert_return (invoke "f64.mul" (f64.const 0x1.f99fb602c89b7p-341) (f64.const 0x1.6caab46a31a2ep-575)) (f64.const 0x1.68201f986e9d7p-915))
(assert_return (invoke "f64.mul" (f64.const -0x1.86999c5eee379p-9) (f64.const 0x1.6e3b9e0d53e0dp+723)) (f64.const -0x1.17654a0ef35f5p+715))
(assert_return (invoke "f64.mul" (f64.const -0x1.069571b176f9p+367) (f64.const -0x1.e248b6ab0a0e3p-652)) (f64.const 0x1.eeaff575cae1dp-285))
(assert_return (invoke "f64.mul" (f64.const 0x1.c217645777dd2p+775) (f64.const 0x1.d93f5715dd646p+60)) (f64.const 0x1.a0064aa1d920dp+836))
(assert_return (invoke "f64.mul" (f64.const -0x1.848981b6e694ap-276) (f64.const 0x1.f5aacb64a0d19p+896)) (f64.const -0x1.7cb2296e6c2e5p+621))

;; Computations that round differently on x87 in double-precision mode.
(assert_return (invoke "f64.mul" (f64.const 0x1.db3bd2a286944p-599) (f64.const 0x1.ce910af1d55cap-425)) (f64.const 0x0.d6accdd538a39p-1022))
(assert_return (invoke "f64.mul" (f64.const -0x1.aca223916012p-57) (f64.const -0x1.2b2b4958dd228p-966)) (f64.const 0x0.fa74eccae5615p-1022))
(assert_return (invoke "f64.mul" (f64.const -0x1.bd062def16cffp-488) (f64.const -0x1.7ddd91a0c4c0ep-536)) (f64.const 0x0.a5f4d7769d90dp-1022))
(assert_return (invoke "f64.mul" (f64.const -0x1.c6a56169e9cep-772) (f64.const 0x1.517d55a474122p-255)) (f64.const -0x0.12baf260afb77p-1022))
(assert_return (invoke "f64.mul" (f64.const -0x1.08951b0b41705p-516) (f64.const -0x1.102dc27168d09p-507)) (f64.const 0x0.8ca6dbf3f592bp-1022))

(assert_return (invoke "f32.div" (f32.const 1.123456789) (f32.const 100)) (f32.const 0.011234568432))
(assert_return (invoke "f32.div" (f32.const 8391667.0) (f32.const 12582905.0)) (f32.const 0x1.55754p-1))
(assert_return (invoke "f32.div" (f32.const 65536.0) (f32.const 0x1p-37)) (f32.const 0x1p+53))
(assert_return (invoke "f32.div" (f32.const 0x1.dcbf6ap+0) (f32.const 0x1.fffffep+127)) (f32.const 0x1.dcbf68p-128))
(assert_return (invoke "f32.div" (f32.const 4) (f32.const 3)) (f32.const 0x1.555556p+0))

;; Test for a historic hardware bug.
(assert_return (invoke "f32.div" (f32.const 4195835) (f32.const 3145727)) (f32.const 0x1.557542p+0))

(assert_return (invoke "f64.div" (f64.const 1.123456789) (f64.const 100)) (f64.const 0.01123456789))
(assert_return (invoke "f64.div" (f64.const 8391667.0) (f64.const 12582905.0)) (f64.const 0x1.55753f1d9ba27p-1))
(assert_return (invoke "f64.div" (f64.const 65536.0) (f64.const 0x1p-37)) (f64.const 0x1p+53))
(assert_return (invoke "f64.div" (f64.const 4) (f64.const 3)) (f64.const 0x1.5555555555555p+0))

;; Test for a historic hardware bug.
(assert_return (invoke "f64.div" (f64.const 4195835) (f64.const 3145727)) (f64.const 0x1.557541c7c6b43p+0))

;; Computations that round differently on x87.
(assert_return (invoke "f64.div" (f64.const -0x1.9c52726aed366p+585) (f64.const -0x1.7d0568c75660fp+195)) (f64.const 0x1.1507ca2a65f23p+390))
(assert_return (invoke "f64.div" (f64.const -0x1.522672f461667p+546) (f64.const -0x1.36d36572c9f71p+330)) (f64.const 0x1.1681369370619p+216))
(assert_return (invoke "f64.div" (f64.const 0x1.01051b4e8cd61p+185) (f64.const -0x1.2cbb5ca3d33ebp+965)) (f64.const -0x1.b59471598a2f3p-781))
(assert_return (invoke "f64.div" (f64.const 0x1.5f93bb80fc2cbp+217) (f64.const 0x1.7e051aae9f0edp+427)) (f64.const 0x1.d732fa926ba4fp-211))
(assert_return (invoke "f64.div" (f64.const -0x1.e251d762163ccp+825) (f64.const 0x1.3ee63581e1796p+349)) (f64.const -0x1.8330077d90a07p+476))

;; Computations that round differently on x87 in double-precision mode.
(assert_return (invoke "f64.div" (f64.const 0x1.dcbf69f10006dp+0) (f64.const 0x1.fffffffffffffp+1023)) (f64.const 0x0.772fda7c4001bp-1022))
(assert_return (invoke "f64.div" (f64.const 0x1.e14169442fbcap-1011) (f64.const 0x1.505451d62ff7dp+12)) (f64.const 0x0.b727e85f38b39p-1022))
(assert_return (invoke "f64.div" (f64.const -0x1.d3ebe726ec964p-144) (f64.const -0x1.4a7bfc0b83608p+880)) (f64.const 0x0.5a9d8c50cbf87p-1022))
(assert_return (invoke "f64.div" (f64.const -0x1.6c3def770aee1p-393) (f64.const -0x1.8b84724347598p+631)) (f64.const 0x0.3af0707fcd0c7p-1022))
(assert_return (invoke "f64.div" (f64.const 0x1.16abda1bb3cb3p-856) (f64.const 0x1.6c9c7198eb1e6p+166)) (f64.const 0x0.c3a8fd6741649p-1022))
(assert_return (invoke "f64.div" (f64.const 0x1.7057d6ab553cap-1005) (f64.const -0x1.2abf1e98660ebp+23)) (f64.const -0x0.04ee8d8ec01cdp-1022))

;; Computations that round differently when div is mul by reciprocal.
(assert_return (invoke "f64.div" (f64.const 0x1.b2348a1c81899p+61) (f64.const -0x1.4a58aad903dd3p-861)) (f64.const -0x1.507c1e2a41b35p+922))
(assert_return (invoke "f64.div" (f64.const 0x1.23fa5137a918ap-130) (f64.const -0x1.7268db1951263p-521)) (f64.const -0x1.93965e0d896bep+390))
(assert_return (invoke "f64.div" (f64.const 0x1.dcb3915d82deep+669) (f64.const 0x1.50caaa1dc6b19p+638)) (f64.const 0x1.6a58ec814b09dp+31))
(assert_return (invoke "f64.div" (f64.const -0x1.046e378c0cc46p+182) (f64.const 0x1.ac925009a922bp+773)) (f64.const -0x1.3720aa94dab18p-592))
(assert_return (invoke "f64.div" (f64.const -0x1.8945fd69d8e11p-871) (f64.const -0x1.0a37870af809ap-646)) (f64.const 0x1.7a2e286c62382p-225))

;; Computations that round differently when computed via f32.
(assert_return (invoke "f64.div" (f64.const 0x1.82002af0ea1f3p-57) (f64.const 0x1.d0a9b0c2fa339p+0)) (f64.const 0x1.a952fbd1fc17cp-58))
(assert_return (invoke "f64.div" (f64.const 0x1.1e12b515db471p-102) (f64.const -0x1.41fc3c94fba5p-42)) (f64.const -0x1.c6e50cccb7cb6p-61))
(assert_return (invoke "f64.div" (f64.const 0x1.aba5adcd6f583p-41) (f64.const 0x1.17dfac639ce0fp-112)) (f64.const 0x1.872b0a008c326p+71))
(assert_return (invoke "f64.div" (f64.const 0x1.cf82510d0ae6bp+89) (f64.const 0x1.0207d86498053p+97)) (f64.const 0x1.cbdc804e2cf14p-8))
(assert_return (invoke "f64.div" (f64.const 0x1.4c82cbb508e21p-11) (f64.const -0x1.6b57208c2d5d5p+52)) (f64.const -0x1.d48e8b369129ap-64))

;; Computations that round differently on x87.
(assert_return (invoke "f64.sqrt" (f64.const 0x1.0263fcc94f259p-164)) (f64.const 0x1.0131485de579fp-82))
(assert_return (invoke "f64.sqrt" (f64.const 0x1.352dfa278c43dp+338)) (f64.const 0x1.195607dac5417p+169))
(assert_return (invoke "f64.sqrt" (f64.const 0x1.b15daa23924fap+402)) (f64.const 0x1.4d143db561493p+201))
(assert_return (invoke "f64.sqrt" (f64.const 0x1.518c8e68cb753p-37)) (f64.const 0x1.9fb8ef1ad5bfdp-19))
(assert_return (invoke "f64.sqrt" (f64.const 0x1.86d8b6518078ep-370)) (f64.const 0x1.3c5142a48fcadp-185))

;; Test that the bitwise floating point operators are bitwise on NaN.

(assert_return (invoke "f32.abs" (f32.const nan)) (f32.const nan))
(assert_return (invoke "f32.abs" (f32.const -nan)) (f32.const nan))
(assert_return (invoke "f32.abs" (f32.const nan(0x0f1e2))) (f32.const nan(0x0f1e2)))
(assert_return (invoke "f32.abs" (f32.const -nan(0x0f1e2))) (f32.const nan(0x0f1e2)))

(assert_return (invoke "f64.abs" (f64.const nan)) (f64.const nan))
(assert_return (invoke "f64.abs" (f64.const -nan)) (f64.const nan))
(assert_return (invoke "f64.abs" (f64.const nan(0x0f1e27a6b))) (f64.const nan(0x0f1e27a6b)))
(assert_return (invoke "f64.abs" (f64.const -nan(0x0f1e27a6b))) (f64.const nan(0x0f1e27a6b)))

(assert_return (invoke "f32.neg" (f32.const nan)) (f32.const -nan))
(assert_return (invoke "f32.neg" (f32.const -nan)) (f32.const nan))
(assert_return (invoke "f32.neg" (f32.const nan(0x0f1e2))) (f32.const -nan(0x0f1e2)))
(assert_return (invoke "f32.neg" (f32.const -nan(0x0f1e2))) (f32.const nan(0x0f1e2)))

(assert_return (invoke "f64.neg" (f64.const nan)) (f64.const -nan))
(assert_return (invoke "f64.neg" (f64.const -nan)) (f64.const nan))
(assert_return (invoke "f64.neg" (f64.const nan(0x0f1e27a6b))) (f64.const -nan(0x0f1e27a6b)))
(assert_return (invoke "f64.neg" (f64.const -nan(0x0f1e27a6b))) (f64.const nan(0x0f1e27a6b)))

(assert_return (invoke "f32.copysign" (f32.const nan) (f32.const nan)) (f32.const nan))
(assert_return (invoke "f32.copysign" (f32.const nan) (f32.const -nan)) (f32.const -nan))
(assert_return (invoke "f32.copysign" (f32.const -nan) (f32.const nan)) (f32.const nan))
(assert_return (invoke "f32.copysign" (f32.const -nan) (f32.const -nan)) (f32.const -nan))
(assert_return (invoke "f32.copysign" (f32.const nan(0x0f1e2)) (f32.const nan)) (f32.const nan(0x0f1e2)))
(assert_return (invoke "f32.copysign" (f32.const nan(0x0f1e2)) (f32.const -nan)) (f32.const -nan(0x0f1e2)))
(assert_return (invoke "f32.copysign" (f32.const -nan(0x0f1e2)) (f32.const nan)) (f32.const nan(0x0f1e2)))
(assert_return (invoke "f32.copysign" (f32.const -nan(0x0f1e2)) (f32.const -nan)) (f32.const -nan(0x0f1e2)))

(assert_return (invoke "f64.copysign" (f64.const nan) (f64.const nan)) (f64.const nan))
(assert_return (invoke "f64.copysign" (f64.const nan) (f64.const -nan)) (f64.const -nan))
(assert_return (invoke "f64.copysign" (f64.const -nan) (f64.const nan)) (f64.const nan))
(assert_return (invoke "f64.copysign" (f64.const -nan) (f64.const -nan)) (f64.const -nan))
(assert_return (invoke "f64.copysign" (f64.const nan(0x0f1e27a6b)) (f64.const nan)) (f64.const nan(0x0f1e27a6b)))
(assert_return (invoke "f64.copysign" (f64.const nan(0x0f1e27a6b)) (f64.const -nan)) (f64.const -nan(0x0f1e27a6b)))
(assert_return (invoke "f64.copysign" (f64.const -nan(0x0f1e27a6b)) (f64.const nan)) (f64.const nan(0x0f1e27a6b)))
(assert_return (invoke "f64.copysign" (f64.const -nan(0x0f1e27a6b)) (f64.const -nan)) (f64.const -nan(0x0f1e27a6b)))

;; Test that ceil isn't implemented as adding 0.5 and rounding to nearest.
(assert_return (invoke "f32.ceil" (f32.const 0x1.fffffep-1)) (f32.const 1.0))
(assert_return (invoke "f32.ceil" (f32.const 0x1p-126)) (f32.const 1.0))

;; Test that ceil isn't implemented as adding 0.5 and rounding to nearest.
(assert_return (invoke "f64.ceil" (f64.const 0x1.fffffffffffffp-1)) (f64.const 1.0))
(assert_return (invoke "f64.ceil" (f64.const 0x1p-1022)) (f64.const 1.0))

;; Test that floor isn't implemented as subtracting 0.5 and rounding to nearest.
(assert_return (invoke "f32.floor" (f32.const -0x1.fffffep-1)) (f32.const -1.0))
(assert_return (invoke "f32.floor" (f32.const -0x1p-126)) (f32.const -1.0))

;; Test that floor isn't implemented as subtracting 0.5 and rounding to nearest.
(assert_return (invoke "f64.floor" (f64.const -0x1.fffffffffffffp-1)) (f64.const -1.0))
(assert_return (invoke "f64.floor" (f64.const -0x1p-1022)) (f64.const -1.0))

;; Nearest should not round halfway cases away from zero (as C's round(3) does)
;; or up (as JS's Math.round does).
(assert_return (invoke "f32.nearest" (f32.const 4.5)) (f32.const 4.0))
(assert_return (invoke "f32.nearest" (f32.const -4.5)) (f32.const -4.0))
(assert_return (invoke "f32.nearest" (f32.const -3.5)) (f32.const -4.0))
(assert_return (invoke "f64.nearest" (f64.const 4.5)) (f64.const 4.0))
(assert_return (invoke "f64.nearest" (f64.const -4.5)) (f64.const -4.0))
(assert_return (invoke "f64.nearest" (f64.const -3.5)) (f64.const -4.0))

;; x87 loads and stores canonicalize some bit patterns. Test that wasm loads and
;; stores don't do this.

(module
  (memory 4 4)

  (func $store_i32 (param $x i32) (result i32)
    (i32.store (i32.const 0) (get_local $x)))

  (func $load_i32 (result i32)
    (i32.load (i32.const 0)))

  (func $store_f32 (param $x f32) (result f32)
    (f32.store (i32.const 0) (get_local $x)))

  (func $load_f32 (result f32)
    (f32.load (i32.const 0)))

  (export "store_i32" $store_i32)
  (export "load_i32" $load_i32)
  (export "store_f32" $store_f32)
  (export "load_f32" $load_f32)
)

(assert_return (invoke "store_i32" (i32.const 0x7f800001)) (i32.const 0x7f800001))
(assert_return (invoke "load_f32") (f32.const nan:0x000001))
(assert_return (invoke "store_i32" (i32.const 0x80000000)) (i32.const 0x80000000))
(assert_return (invoke "load_f32") (f32.const -0.0))

(assert_return (invoke "store_f32" (f32.const nan:0x000001)) (f32.const nan:0x000001))
(assert_return (invoke "load_i32") (i32.const 0x7f800001))
(assert_return (invoke "store_f32" (f32.const -0.0)) (f32.const -0.0))
(assert_return (invoke "load_i32") (i32.const 0x80000000))

(module
  (memory 8 8)

  (func $store_i64 (param $x i64) (result i64)
    (i64.store (i32.const 0) (get_local $x)))

  (func $load_i64 (result i64)
    (i64.load (i32.const 0)))

  (func $store_f64 (param $x f64) (result f64)
    (f64.store (i32.const 0) (get_local $x)))

  (func $load_f64 (result f64)
    (f64.load (i32.const 0)))

  (export "store_i64" $store_i64)
  (export "load_i64" $load_i64)
  (export "store_f64" $store_f64)
  (export "load_f64" $load_f64)
)

(assert_return (invoke "store_i64" (i64.const 0x7ff0000000000001)) (i64.const 0x7ff0000000000001))
(assert_return (invoke "load_f64") (f64.const nan:0x0000000000001))
(assert_return (invoke "store_i64" (i64.const 0x8000000000000000)) (i64.const 0x8000000000000000))
(assert_return (invoke "load_f64") (f64.const -0.0))

(assert_return (invoke "store_f64" (f64.const nan:0x0000000000001)) (f64.const nan:0x0000000000001))
(assert_return (invoke "load_i64") (i64.const 0x7ff0000000000001))
(assert_return (invoke "store_f64" (f64.const -0.0)) (f64.const -0.0))
(assert_return (invoke "load_i64") (i64.const 0x8000000000000000))

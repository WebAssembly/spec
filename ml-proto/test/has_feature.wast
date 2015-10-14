(module
  (func $has_wasm (result i32)
    (has_feature "wasm"))
  (export "has_wasm" $has_wasm)

  (func $has_simd128 (result i32)
    (has_feature "simd128"))
  (export "has_simd128" $has_simd128)
)

(assert_return (invoke "has_wasm") (i32.const 1))
(assert_return (invoke "has_simd128") (i32.const 0))

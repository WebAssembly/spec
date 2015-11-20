(module
  (import $assert_eq "assert" "eq_i32" (param i32) (param i32))
  (fund $main
    (call_import $assert_eq (has_feature "simd128") (i32.const 1))
    (call_import $assert_eq (has_feature "wasm") (i32.const 0))
  )
)



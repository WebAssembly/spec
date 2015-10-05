(module
  (func $test32 (result i32)
    (return (i32.const 0x0bAdD00D))
  )

  (func $max32 (result i32)
    (return (i32.const 0xffffffff))
  )

  (func $neg32 (result i32)
    (return (i32.const -0x7fffffff))
  )

  (func $test64 (result i64)
    (return (i64.const 0x0CABBA6E0ba66a6e))
  )

  (func $max64 (result i64)
    (return (i64.const 0xffffffffffffffff))
  )

  (func $neg64 (result i64)
    (return (i64.const -0x7fffffffffffffff))
  )

  (export "test32" $test32)
  (export "max32" $max32)
  (export "neg32" $neg32)
  (export "test64" $test64)
  (export "max64" $max64)
  (export "neg64" $neg64)
)

(assert_return (invoke "test32") (i32.const 195940365))
(assert_return (invoke "max32") (i32.const -1))
(assert_return (invoke "neg32") (i32.const -2147483647))
(assert_return (invoke "test64") (i64.const 913028331277281902))
(assert_return (invoke "max64") (i64.const -1))
(assert_return (invoke "neg64") (i64.const -9223372036854775807))

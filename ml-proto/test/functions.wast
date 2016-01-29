(module
  (func $return-none (i32.const 1))
  (export "return-none" $return-none)

  (func $empty)
  (export "empty" $empty)
)

(assert_return (invoke "return-none"))
(assert_return (invoke "empty"))

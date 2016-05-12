;; Test `nop` operator.

(module
  (func "eval"
    (nop)
  )

  (func "drop" (result i32)
    (nop)
    (i32.const 1)
  )
)

(assert_return (invoke "eval"))
(assert_return (invoke "drop") (i32.const 1))

(assert_invalid
  (module (func (result i32) (nop)))
  "type mismatch"
)

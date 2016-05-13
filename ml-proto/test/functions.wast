(module
  (func $empty)
  (export "empty" $empty)

  (func $nop (nop))
  (export "nop" $nop)

  (func $drop (drop (i32.const 1)))
  (export "drop" $drop)

  (func $return (return) (unreachable))
  (export "return" $return)
)

(assert_return (invoke "empty"))
(assert_return (invoke "nop"))
(assert_return (invoke "drop"))
(assert_return (invoke "return"))

(assert_invalid
  (module (func (return (nop))))
  "arity mismatch"
)


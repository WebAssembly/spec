;; Test order of execution/optimizer bait

(module
  (memory 0)
  (global $a (mut i32) (i32.const 0))

  (func (export "get-a") (result i32) (global.get $a))

  (func (export "div-by-zero") (local i32)
    (i32.const 0) (i32.const 0) (i32.div_s) (i32.const 1) (global.set $a) (local.set 0)
  )

  (func (export "memory-oob-read") (local i32)
    (i32.load (i32.const 0)) (i32.const 2) (global.set $a) (local.set 0)
  )

  (func $set_by_call (param i32)
    (local.get 0) (global.set $a)
  )

  (func (export "trapping-div-trapping-call") (local i32)
    (i32.const 0) (i32.const 0) (i32.div_s) (call $set_by_call (i32.const 3)) (local.set 0)
  )
)

(assert_trap (invoke "div-by-zero") "integer divide by zero")
(assert_return (invoke "get-a") (i32.const 0))
(assert_trap (invoke "memory-oob-read") "out of bounds memory access")
(assert_return (invoke "get-a") (i32.const 0))
(assert_trap (invoke "trapping-div-trapping-call") "integer divide by zero")
(assert_return (invoke "get-a") (i32.const 0))

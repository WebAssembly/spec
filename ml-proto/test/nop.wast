;; Test `nop` operator.

(module
  (func $dummy)

  (func (export "as-func-first") (result i32)
    (nop) (i32.const 1)
  )
  (func (export "as-func-mid") (result i32)
    (call $dummy) (nop) (i32.const 2)
  )
  (func (export "as-func-last")
    (call $dummy) (nop)
  )

  (func (export "as-block-first") (result i32)
    (block (nop) (i32.const 2))
  )
  (func (export "as-block-mid") (result i32)
    (block (call $dummy) (nop) (i32.const 2))
  )
  (func (export "as-block-last")
    (block (nop) (call $dummy) (nop))
  )

  (func (export "as-loop-first") (result i32)
    (loop (nop) (i32.const 2))
  )
  (func (export "as-loop-mid") (result i32)
    (loop (call $dummy) (nop) (i32.const 2))
  )
  (func (export "as-loop-last")
    (loop (call $dummy) (nop))
  )

  (func (export "as-if-then") (param i32)
    (block (if (get_local 0) (nop) (call $dummy)))
  )
  (func (export "as-if-else") (param i32)
    (block (if (get_local 0) (call $dummy) (nop)))
  )
)

(assert_return (invoke "as-func-first") (i32.const 1))
(assert_return (invoke "as-func-mid") (i32.const 2))
(assert_return (invoke "as-func-last"))

(assert_return (invoke "as-block-first") (i32.const 2))
(assert_return (invoke "as-block-mid") (i32.const 2))
(assert_return (invoke "as-block-last"))

(assert_return (invoke "as-loop-first") (i32.const 2))
(assert_return (invoke "as-loop-mid") (i32.const 2))
(assert_return (invoke "as-loop-last"))

(assert_return (invoke "as-if-then" (i32.const 0)))
(assert_return (invoke "as-if-then" (i32.const 4)))
(assert_return (invoke "as-if-else" (i32.const 0)))
(assert_return (invoke "as-if-else" (i32.const 3)))

(assert_invalid
  (module (func $type-i32 (result i32) (nop)))
  "type mismatch"
)
(assert_invalid
  (module (func $type-i64 (result i64) (nop)))
  "type mismatch"
)
(assert_invalid
  (module (func $type-f32 (result f32) (nop)))
  "type mismatch"
)
(assert_invalid
  (module (func $type-f64 (result f64) (nop)))
  "type mismatch"
)

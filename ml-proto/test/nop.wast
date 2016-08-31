;; Test `nop` operator.

(module
  (func $dummy)

  (export "as-func-first" (func (result i32)
    (nop) (i32.const 1)
  ))
  (export "as-func-mid" (func (result i32)
    (call $dummy) (nop) (i32.const 2)
  ))
  (export "as-func-last" (func
    (call $dummy) (nop)
  ))

  (export "as-block-first" (func (result i32)
    (block (nop) (i32.const 2))
  ))
  (export "as-block-mid" (func (result i32)
    (block (call $dummy) (nop) (i32.const 2))
  ))
  (export "as-block-last" (func
    (block (nop) (call $dummy) (nop))
  ))

  (export "as-loop-first" (func (result i32)
    (loop (nop) (i32.const 2))
  ))
  (export "as-loop-mid" (func (result i32)
    (loop (call $dummy) (nop) (i32.const 2))
  ))
  (export "as-loop-last" (func
    (loop (call $dummy) (nop))
  ))

  (export "as-if-then" (func (param i32)
    (block (if (get_local 0) (nop) (call $dummy)))
  ))
  (export "as-if-else" (func (param i32)
    (block (if (get_local 0) (call $dummy) (nop)))
  ))
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

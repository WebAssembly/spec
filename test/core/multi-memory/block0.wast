;; Test `block` operator

(module
  ;; Auxiliary definition
  (memory $mem0 1)
  (memory $mem1 1)

  (func (export "as-memory.grow-value1") (result i32)
    (memory.grow $mem0 (block (result i32) (i32.const 1)))
  )

  (func (export "as-memory.grow-value2") (result i32)
    (memory.grow $mem1 (block (result i32) (i32.const 1)))
  )
)

(assert_return (invoke "as-memory.grow-value1") (i32.const 1))
(assert_return (invoke "as-memory.grow-value2") (i32.const 1))

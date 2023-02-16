(module
  (memory $mem0 0)
  (memory $mem1 4)
  (memory $mem2 9)

  (func (export "as-memory.grow-value0") (result i32)
    (memory.grow $mem0 (loop (result i32) (i32.const 1)))
  )
  (func (export "as-memory.grow-value1") (result i32)
    (memory.grow $mem1 (loop (result i32) (i32.const 1)))
  )
  (func (export "as-memory.grow-value2") (result i32)
    (memory.grow $mem2 (loop (result i32) (i32.const 1)))
  )
)

(assert_return (invoke "as-memory.grow-value0") (i32.const 0))
(assert_return (invoke "as-memory.grow-value1") (i32.const 4))
(assert_return (invoke "as-memory.grow-value2") (i32.const 9))

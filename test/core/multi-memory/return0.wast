(module
  (memory $mem0 0)
  (memory $mem1 1)
  (memory $mem2 4)

  (func (export "as-memory.grow-size0") (result i32)
    (memory.grow $mem0 (return (i32.const 40)))
  )
  (func (export "as-memory.grow-size1") (result i32)
    (memory.grow $mem1 (return (i32.const 40)))
  )
  (func (export "as-memory.grow-size2") (result i32)
    (memory.grow $mem2 (return (i32.const 40)))
  )
)

(assert_return (invoke "as-memory.grow-size0") (i32.const 40))
(assert_return (invoke "as-memory.grow-size1") (i32.const 40))
(assert_return (invoke "as-memory.grow-size2") (i32.const 40))

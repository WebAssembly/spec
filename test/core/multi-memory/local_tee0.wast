(module
  (memory $mem0 0)
  (memory $mem1 2)
  (memory $mem2 5)

  (func (export "as-memory.grow-size0") (param i32) (result i32)
    (memory.grow $mem0 (local.tee 0 (i32.const 40)))
  )
  (func (export "as-memory.grow-size1") (param i32) (result i32)
    (memory.grow $mem1 (local.tee 0 (i32.const 40)))
  )
  (func (export "as-memory.grow-size2") (param i32) (result i32)
    (memory.grow $mem2 (local.tee 0 (i32.const 40)))
  )
)

(assert_return (invoke "as-memory.grow-size0" (i32.const 0)) (i32.const 0))
(assert_return (invoke "as-memory.grow-size1" (i32.const 0)) (i32.const 2))
(assert_return (invoke "as-memory.grow-size2" (i32.const 0)) (i32.const 5))

(module
  (memory $mem0 0)
  (memory $mem1 1)
  (memory $mem2 7)

  (func (export "as-memory.grow-value0") (param i32) (result i32)
    (memory.grow $mem0 (select (i32.const 1) (i32.const 2) (local.get 0)))
  )
  (func (export "as-memory.grow-value1") (param i32) (result i32)
    (memory.grow $mem1 (select (i32.const 1) (i32.const 2) (local.get 0)))
  )
  (func (export "as-memory.grow-value2") (param i32) (result i32)
    (memory.grow $mem2 (select (i32.const 1) (i32.const 2) (local.get 0)))
  )
)

(assert_return (invoke "as-memory.grow-value0" (i32.const 0)) (i32.const 0))
(assert_return (invoke "as-memory.grow-value0" (i32.const 1)) (i32.const 2))

(assert_return (invoke "as-memory.grow-value1" (i32.const 0)) (i32.const 1))
(assert_return (invoke "as-memory.grow-value1" (i32.const 1)) (i32.const 3))

(assert_return (invoke "as-memory.grow-value2" (i32.const 0)) (i32.const 7))
(assert_return (invoke "as-memory.grow-value2" (i32.const 1)) (i32.const 9))

(module
  (memory $mem0 3)
  (memory $mem1 4)
  (memory $mem2 9)

  (global $x (mut i32) (i32.const 3))

  (func (export "as-memory.grow-value0") (result i32)
    (memory.grow $mem0 (global.get $x))
  )
  (func (export "as-memory.grow-value1") (result i32)
    (memory.grow $mem1 (global.get $x))
  )
  (func (export "as-memory.grow-value2") (result i32)
    (memory.grow $mem2 (global.get $x))
  )
)

(assert_return (invoke "as-memory.grow-value0") (i32.const 3))
(assert_return (invoke "as-memory.grow-value1") (i32.const 4))
(assert_return (invoke "as-memory.grow-value2") (i32.const 9))

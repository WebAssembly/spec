(module
  (memory $mem0 0)
  (memory $mem1 1)
  (memory $mem2 2)

  (func $const-i32 (result i32) (i32.const 0x12))
  
  (func (export "as-memory.grow-value0") (result i32)
    (memory.grow $mem0 (call $const-i32))
  )
  (func (export "as-memory.grow-value1") (result i32)
    (memory.grow $mem1 (call $const-i32))
  )
  (func (export "as-memory.grow-value2") (result i32)
    (memory.grow $mem2 (call $const-i32))
  )
)

(assert_return (invoke "as-memory.grow-value0") (i32.const 0))
(assert_return (invoke "as-memory.grow-value1") (i32.const 1))
(assert_return (invoke "as-memory.grow-value2") (i32.const 2))

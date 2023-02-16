(module
  (memory $mem0 1)
  (memory $mem1 1)

  (func (export "as-memory.grow-size0") (result i32)
    (block (result i32) (memory.grow $mem0 (br_if 0 (i32.const 1) (i32.const 1))))
  )

  (func (export "as-memory.grow-size1") (result i32)
    (block (result i32) (memory.grow $mem1 (br_if 0 (i32.const 1) (i32.const 1))))
  )
)

(assert_return (invoke "as-memory.grow-size0") (i32.const 1))
(assert_return (invoke "as-memory.grow-size1") (i32.const 1))

(module
  (memory $mem0 1)
  (memory $mem1 1)

  (func (export "as-memory.grow-size0") (result i32)
    (block (result i32) (memory.grow $mem0 (br_table 0 (i32.const 40) (i32.const 0))))
  )

  (func (export "as-memory.grow-size1") (result i32)
    (block (result i32) (memory.grow $mem1 (br_table 0 (i32.const 40) (i32.const 0))))
  )
)

(assert_return (invoke "as-memory.grow-size0") (i32.const 40))
(assert_return (invoke "as-memory.grow-size1") (i32.const 40))

(module
  (memory $mem0 0)
  (memory $mem1 1)

  (type $out-i32 (func (result i32)))

  (table funcref
    (elem
      $const-i32 ))

  (func $const-i32 (type $out-i32) (i32.const 0x132))

  (func (export "as-memory.grow-value0") (result i32)
    (memory.grow $mem0 (call_indirect (type $out-i32) (i32.const 0)))
  )
  (func (export "as-memory.grow-value1") (result i32)
    (memory.grow $mem1 (call_indirect (type $out-i32) (i32.const 0)))
  )
)

(assert_return (invoke "as-memory.grow-value0") (i32.const 0))
(assert_return (invoke "as-memory.grow-value1") (i32.const 1))

(module
  (memory $mem0 1)
  (memory $mem1 4)

  (func (export "as-memory.grow-value0") (param i32) (result i32)
    (memory.grow $mem0
      (if (result i32) (local.get 0)
        (then (i32.const 1))
        (else (i32.const 0))
      )
    )
  )

  (func (export "as-memory.grow-value1") (param i32) (result i32)
    (memory.grow $mem1
      (if (result i32) (local.get 0)
        (then (i32.const 1))
        (else (i32.const 0))
      )
    )
  )
)

(assert_return (invoke "as-memory.grow-value0" (i32.const 0)) (i32.const 1))
(assert_return (invoke "as-memory.grow-value0" (i32.const 1)) (i32.const 1))

(assert_return (invoke "as-memory.grow-value1" (i32.const 0)) (i32.const 4))
(assert_return (invoke "as-memory.grow-value1" (i32.const 1)) (i32.const 4))


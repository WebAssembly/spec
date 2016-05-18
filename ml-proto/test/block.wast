;; Test `block` opcode

(module
  (func "empty"
    (block)
    (block $l)
  )

  (func "singular" (result i32)
    (block (nop))
    (block (i32.const 7))
  )

  (func $nop)
  (func "multi" (result i32)
    (block (call $nop) (call $nop) (call $nop) (call $nop))
    (block (call $nop) (call $nop) (call $nop) (i32.const 8))
  )

  (func "nested" (result i32)
    (block (block (call $nop) (block) (nop)) (block (call $nop) (i32.const 9)))
  )

  (func "deep" (result i32)
    (block (block (block (block (block (block (block (block (block (block
      (block (block (block (block (block (block (block (block (block (block
        (block (block (block (block (block (block (block (block (block (block
          (block (block (block (block (block (block (block (block (block (block
            (block (block (block (block (block (call $nop) (i32.const 150))))))
          ))))))))))
        ))))))))))
      ))))))))))
    ))))))))))
  )

  (func "unary-operand" (result i32)
    (i32.ctz (block (call $nop) (i32.const 13)))
  )
  (func "binary-operand" (result i32)
    (i32.mul (block (call $nop) (i32.const 3)) (block (call $nop) (i32.const 4)))
  )
  (func "test-operand" (result i32)
    (i32.eqz (block (call $nop) (i32.const 13)))
  )
  (func "compare-operand" (result i32)
    (f32.gt (block (call $nop) (f32.const 3)) (block (call $nop) (f32.const 3)))
  )

  (func "br-bare" (result i32)
    (block (br 0) (unreachable))
    (i32.const 19)
  )
  (func "br-value" (result i32)
    (block (br 0 (i32.const 18)) (i32.const 19))
  )
  (func "br-repeated" (result i32)
    (block
      (br 0 (i32.const 18))
      (br 0 (i32.const 19))
      (br 0 (i32.const 20))
      (i32.const 21)
    )
  )
  (func "br-inner" (result i32)
    (block
      (block (br 1 (i32.const 22)))
      (block (br 0))
      (i32.const 21)
    )
  )

  (func "drop-inner" (result i32)
    (block (call $fx) (i32.const 7) (call $nop) (i32.const 8))
  )
  (func "drop-last"
    (block (call $nop) (call $fx) (nop) (i32.const 8))
  )
  (func "drop-br-void"
    (block (br 0 (nop)))
    (block (br 0 (call $nop)))
  )
  (func "drop-br-value"
    (block (br 0 (i32.const 8)))
  )
  (func "drop-br-value-heterogeneous"
    (block (br 0 (i32.const 8)) (br 0 (f64.const 8)) (br 0 (f32.const 8)))
    (block (br 0 (i32.const 8)) (br 0) (br 0 (f64.const 8)))
    (block (br 0 (i32.const 8)) (br 0 (call $nop)) (br 0 (f64.const 8)))
    (block (br 0 (i32.const 8)) (br 0) (br 0 (f32.const 8)) (i64.const 3))
    (block (br 0) (br 0 (i32.const 8)) (br 0 (f64.const 8)) (br 0 (nop)))
    (block (br 0) (br 0 (i32.const 8)) (br 0 (f32.const 8)) (i64.const 3))
    (block (block (br 0) (br 1 (i32.const 8))) (br 0 (f32.const 8)) (i64.const 3))
  )

  (func "effects" $fx (result i32)
    (local i32)
    (block
      (set_local 0 (i32.const 1))
      (set_local 0 (i32.mul (get_local 0) (i32.const 3)))
      (set_local 0 (i32.sub (get_local 0) (i32.const 5)))
      (set_local 0 (i32.mul (get_local 0) (i32.const 7)))
      (br 0)
      (set_local 0 (i32.mul (get_local 0) (i32.const 100)))
    )
    (i32.eq (get_local 0) (i32.const -14))
  )
)

(assert_return (invoke "empty"))
(assert_return (invoke "singular") (i32.const 7))
(assert_return (invoke "multi") (i32.const 8))
(assert_return (invoke "nested") (i32.const 9))
(assert_return (invoke "deep") (i32.const 150))

(assert_return (invoke "unary-operand") (i32.const 0))
(assert_return (invoke "binary-operand") (i32.const 12))
(assert_return (invoke "test-operand") (i32.const 0))
(assert_return (invoke "compare-operand") (i32.const 0))

(assert_return (invoke "br-bare") (i32.const 19))
(assert_return (invoke "br-value") (i32.const 18))
(assert_return (invoke "br-repeated") (i32.const 18))
(assert_return (invoke "br-inner") (i32.const 22))

(assert_return (invoke "drop-inner") (i32.const 8))
(assert_return (invoke "drop-last"))
(assert_return (invoke "drop-br-void"))
(assert_return (invoke "drop-br-value"))
(assert_return (invoke "drop-br-value-heterogeneous"))

(assert_return (invoke "effects") (i32.const 1))

(assert_invalid
  (module (func (result i32) (block)))
  "type mismatch"
)
(assert_invalid
  (module (func (result i32) (block (nop))))
  "type mismatch"
)
(assert_invalid
  (module (func (result i32) (block (f32.const 0))))
  "type mismatch"
)
(assert_invalid
  (module (func (result i32) (block (br 0) (i32.const 1))))
  "type mismatch"
)
(assert_invalid
  (module (func (result i32) (block (br 0 (i32.const 1)) (nop))))
  "type mismatch"
)
(assert_invalid
  (module (func (result i32) (block (br 0 (i64.const 1)) (i32.const 1))))
  "type mismatch"
)
(assert_invalid
  (module (func (result i32) (block (br 0 (i64.const 1)) (br 0 (i32.const 1)))))
  "type mismatch"
)
(assert_invalid
  (module (func (result i32) (block (block (br 1 (i64.const 1))) (br 0 (i32.const 1)))))
  "type mismatch"
)


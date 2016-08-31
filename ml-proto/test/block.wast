;; Test `block` operator

(module
  ;; Auxiliary definition
  (func $dummy)

  (export "empty" (func
    (block)
    (block $l)
  ))

  (export "singular" (func (result i32)
    (block (nop))
    (block (i32.const 7))
  ))

  (export "multi" (func (result i32)
    (block (call $dummy) (call $dummy) (call $dummy) (call $dummy))
    (block (call $dummy) (call $dummy) (call $dummy) (i32.const 8))
  ))

  (export "nested" (func (result i32)
    (block
      (block (call $dummy) (block) (nop))
      (block (call $dummy) (i32.const 9))
    )
  ))

  (export "deep" (func (result i32)
    (block (block (block (block (block (block (block (block (block (block
      (block (block (block (block (block (block (block (block (block (block
        (block (block (block (block (block (block (block (block (block (block
          (block (block (block (block (block (block (block (block (block (block
            (block (block (block (block (call $dummy) (i32.const 150)))))
          ))))))))))
        ))))))))))
      ))))))))))
    ))))))))))
  ))

  (export "as-unary-operand" (func (result i32)
    (i32.ctz (block (call $dummy) (i32.const 13)))
  ))
  (export "as-binary-operand" (func (result i32)
    (i32.mul
      (block (call $dummy) (i32.const 3))
      (block (call $dummy) (i32.const 4))
    )
  ))
  (export "as-test-operand" (func (result i32)
    (i32.eqz (block (call $dummy) (i32.const 13)))
  ))
  (export "as-compare-operand" (func (result i32)
    (f32.gt
      (block (call $dummy) (f32.const 3))
      (block (call $dummy) (f32.const 3))
    )
  ))

  (export "break-bare" (func (result i32)
    (block (br 0) (unreachable))
    (block (br_if 0 (i32.const 1)) (unreachable))
    (block (br_table 0 (i32.const 0)) (unreachable))
    (block (br_table 0 0 0 (i32.const 1)) (unreachable))
    (i32.const 19)
  ))
  (export "break-value" (func (result i32)
    (block (br 0 (i32.const 18)) (i32.const 19))
  ))
  (export "break-repeated" (func (result i32)
    (block
      (br 0 (i32.const 18))
      (br 0 (i32.const 19))
      (br_if 0 (i32.const 20) (i32.const 0))
      (br_if 0 (i32.const 20) (i32.const 1))
      (br 0 (i32.const 21))
      (br_table 0 (i32.const 22) (i32.const 4))
      (br_table 0 0 0 (i32.const 23) (i32.const 1))
      (i32.const 21)
    )
  ))
  (export "break-inner" (func (result i32)
    (local i32)
    (set_local 0 (i32.const 0))
    (set_local 0 (i32.add (get_local 0) (block (block (br 1 (i32.const 0x1))))))
    (set_local 0 (i32.add (get_local 0) (block (block (br 0)) (i32.const 0x2))))
    (set_local 0
      (i32.add (get_local 0) (block (i32.ctz (br 0 (i32.const 0x4)))))
    )
    (set_local 0
      (i32.add (get_local 0) (block (i32.ctz (block (br 1 (i32.const 0x8))))))
    )
    (get_local 0)
  ))

  (export "effects" (func (result i32)
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
  ))
)

(assert_return (invoke "empty"))
(assert_return (invoke "singular") (i32.const 7))
(assert_return (invoke "multi") (i32.const 8))
(assert_return (invoke "nested") (i32.const 9))
(assert_return (invoke "deep") (i32.const 150))

(assert_return (invoke "as-unary-operand") (i32.const 0))
(assert_return (invoke "as-binary-operand") (i32.const 12))
(assert_return (invoke "as-test-operand") (i32.const 0))
(assert_return (invoke "as-compare-operand") (i32.const 0))

(assert_return (invoke "break-bare") (i32.const 19))
(assert_return (invoke "break-value") (i32.const 18))
(assert_return (invoke "break-repeated") (i32.const 18))
(assert_return (invoke "break-inner") (i32.const 0xf))

(assert_return (invoke "effects") (i32.const 1))

(assert_invalid
  (module (func $type-empty-i32 (result i32) (block)))
  "type mismatch"
)
(assert_invalid
  (module (func $type-empty-i64 (result i64) (block)))
  "type mismatch"
)
(assert_invalid
  (module (func $type-empty-f32 (result f32) (block)))
  "type mismatch"
)
(assert_invalid
  (module (func $type-empty-f64 (result f64) (block)))
  "type mismatch"
)

(assert_invalid
  (module (func $type-first-num-vs-void (result i32)
    (block (i32.const 7) (nop) (i32.const 8))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-mid-num-vs-void (result i32)
    (block (nop) (i32.const 7) (nop) (i32.const 8))
  ))
  "type mismatch"
)

(assert_invalid
  (module (func $type-value-num-vs-void
    (block (i32.const 1))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-value-void-vs-num (result i32)
    (block (nop))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-value-num-vs-num (result i32)
    (block (f32.const 0))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-value-num-vs-void-after-break
    (block (br 0) (i32.const 1))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-value-void-vs-num-after-break (result i32)
    (block (br 0 (i32.const 1)) (nop))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-value-num-vs-num-after-break (result i32)
    (block (br 0 (i32.const 1)) (f32.const 0))
  ))
  "type mismatch"
)

(assert_invalid
  (module (func $type-break-last-void-vs-empty
    (block (br 0 (nop)))
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-break-last-num-vs-empty
    (block (br 0 (i32.const 66)))
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-break-last-empty-vs-num (result i32)
    (block (br 0))
  ))
  "arity mismatch"
)

(assert_invalid
  (module (func $type-break-void-vs-empty
    (block (br 0 (nop)))
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-break-num-vs-empty
    (block (br 0 (i32.const 1)))
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-break-empty-vs-num (result i32)
    (block (br 0) (i32.const 1))
  ))
  "arity mismatch"
)

(assert_invalid
  (module (func $type-break-void-vs-num (result i32)
    (block (br 0 (nop)) (i32.const 1))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-break-num-vs-num (result i32)
    (block (br 0 (i64.const 1)) (i32.const 1))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-break-first-void-vs-num (result i32)
    (block (br 0 (nop)) (br 0 (i32.const 1)))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-break-first-num-vs-num (result i32)
    (block (br 0 (i64.const 1)) (br 0 (i32.const 1)))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-break-second-void-vs-num (result i32)
    (block (br 0 (i32.const 1)) (br 0 (nop)))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-break-second-num-vs-num (result i32)
    (block (br 0 (i32.const 1)) (br 0 (f64.const 1)))
  ))
  "type mismatch"
)

(assert_invalid
  (module (func $type-break-nested-void-vs-empty
    (block (block (br 1 (nop))) (br 0))
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-break-nested-num-vs-empty
    (block (block (br 1 (i32.const 1))) (br 0))
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-break-nested-empty-vs-num (result i32)
    (block (block (br 1)) (br 0 (i32.const 1)))
  ))
  "arity mismatch"
)

(assert_invalid
  (module (func $type-break-nested-void-vs-num (result i32)
    (block (block (br 1 (nop))) (br 0 (i32.const 1)))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-break-nested-num-vs-num (result i32)
    (block (block (br 1 (i64.const 1))) (br 0 (i32.const 1)))
  ))
  "type mismatch"
)

(assert_invalid
  (module (func $type-break-operand-empty-vs-num (result i32)
    (i32.ctz (block (br 0)))
  ))
  "arity mismatch"
)

(assert_invalid
  (module (func $type-break-operand-void-vs-num (result i32)
    (i64.ctz (block (br 0 (nop))))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-break-operand-num-vs-num (result i32)
    (i64.ctz (block (br 0 (i64.const 9))))
  ))
  "type mismatch"
)

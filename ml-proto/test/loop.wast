;; Test `loop` opcode

(module
  (func "empty"
    (loop)
    (loop $l)
  )

  (func "singular" (result i32)
    (loop (nop))
    (loop (i32.const 7))
  )

  (func $nop)
  (func "multi" (result i32)
    (loop (call $nop) (call $nop) (call $nop) (call $nop))
    (loop (call $nop) (call $nop) (call $nop) (i32.const 8))
  )

  (func "nested" (result i32)
    (loop (loop (call $nop) (block) (nop)) (loop (call $nop) (i32.const 9)))
  )

  (func "deep" (result i32)
    (loop (block (loop (block (loop (block (loop (block (loop (block
      (loop (block (loop (block (loop (block (loop (block (loop (block
        (loop (block (loop (block (loop (block (loop (block (loop (block
          (loop (block (loop (block (loop (block (loop (block (loop (block
            (loop (block (loop (block (loop (call $nop) (i32.const 150))))))
          ))))))))))
        ))))))))))
      ))))))))))
    ))))))))))
  )

  (func "unary-operand" (result i32)
    (i32.ctz (loop (call $nop) (i32.const 13)))
  )
  (func "binary-operand" (result i32)
    (i32.mul (loop (call $nop) (i32.const 3)) (loop (call $nop) (i32.const 4)))
  )
  (func "test-operand" (result i32)
    (i32.eqz (loop (call $nop) (i32.const 13)))
  )
  (func "compare-operand" (result i32)
    (f32.gt (loop (call $nop) (f32.const 3)) (loop (call $nop) (f32.const 3)))
  )

  (func "break-bare" (result i32)
    (loop (br 1) (br 0) (unreachable))
    (loop (br_if 1 (i32.const 1)) (unreachable))
    (loop (br_table 1 (i32.const 0)) (unreachable))
    (loop (br_table 1 1 1 (i32.const 1)) (unreachable))
    (i32.const 19)
  )
  (func "break-value" (result i32)
    (loop (br 1 (i32.const 18)) (br 0) (i32.const 19))
  )
  (func "break-repeated" (result i32)
    (loop
      (br 1 (i32.const 18))
      (br 1 (i32.const 19))
      (br_if 1 (i32.const 20) (i32.const 0))
      (br_if 1 (i32.const 20) (i32.const 1))
      (br 1 (i32.const 21))
      (br_table 1 (i32.const 22) (i32.const 0))
      (br_table 1 1 1 (i32.const 23) (i32.const 1))
      (i32.const 21)
    )
  )
  (func "break-inner" (result i32)
    (local i32)
    (set_local 0 (i32.const 0))
    (set_local 0 (i32.add (get_local 0) (loop (block (br 2 (i32.const 0x1))))))
    (set_local 0 (i32.add (get_local 0) (loop (loop (br 3 (i32.const 0x2))))))
    (set_local 0 (i32.add (get_local 0) (loop (loop (br 1 (i32.const 0x4))))))
    (set_local 0 (i32.add (get_local 0) (loop (i32.ctz (br 1 (i32.const 0x8))))))
    (set_local 0 (i32.add (get_local 0) (loop (i32.ctz (loop (br 3 (i32.const 0x10)))))))
    (get_local 0)
  )
  (func "cont-inner" (result i32)
    (local i32)
    (set_local 0 (i32.const 0))
    (set_local 0 (i32.add (get_local 0) (loop (loop (br 2)))))
    (set_local 0 (i32.add (get_local 0) (loop (i32.ctz (br 0)))))
    (set_local 0 (i32.add (get_local 0) (loop (i32.ctz (loop (br 2))))))
    (get_local 0)
  )

  (func "drop-mid" (result i32)
    (loop (call $fx) (i32.const 7) (call $nop) (i32.const 8))
  )
  (func "drop-last"
    (loop (call $nop) (call $fx) (nop) (i32.const 8))
  )
  (func "drop-break-void"
    (loop (br 1 (nop)))
    (loop (br 1 (call $nop)))
    (loop (br_if 1 (nop) (i32.const 0)))
    (loop (br_if 1 (nop) (i32.const 1)))
    (loop (br_if 1 (call $nop) (i32.const 0)))
    (loop (br_if 1 (call $nop) (i32.const 1)))
    (loop (br_table 1 (nop) (i32.const 3)))
    (loop (br_table 1 1 1 (nop) (i32.const 1)))
  )
  (func "drop-break-value"
    (loop (br 1 (i32.const 8)))
    (loop (br_if 1 (i32.const 11) (i32.const 0)))
    (loop (br_if 1 (i32.const 10) (i32.const 1)))
    (loop (br_table 1 (i32.const 9) (i32.const 5)))
    (loop (br_table 1 1 1 (i32.const 8) (i32.const 1)))
  )
  (func "drop-cont-void"
    (loop (br 0 (nop)))
    (loop (br 0 (call $nop)))
    (loop (br_if 0 (nop) (i32.const 0)))
    (loop (br_if 0 (nop) (i32.const 1)))
    (loop (br_if 0 (call $nop) (i32.const 0)))
    (loop (br_if 0 (call $nop) (i32.const 1)))
    (loop (br_table 0 (nop) (i32.const 3)))
    (loop (br_table 0 1 1 (nop) (i32.const 1)))
  )
  (func "drop-cont-value"
    (loop (br 0 (i32.const 8)))
    (loop (br_if 0 (i32.const 11) (i32.const 0)))
    (loop (br_if 0 (i32.const 10) (i32.const 1)))
    (loop (br_table 0 (i32.const 9) (i32.const 5)))
    (loop (br_table 0 0 1 (i32.const 8) (i32.const 1)))
  )
  (func "drop-break-value-heterogeneous"
    (loop (br 1 (i32.const 8)) (br 1 (f64.const 8)) (br 1 (f32.const 8)))
    (loop (br 1 (i32.const 8)) (br 1) (br 1 (f64.const 8)))
    (loop (br 1 (i32.const 8)) (br 1) (br 1 (f32.const 8)) (i64.const 3))
    (loop (br 1) (br 1 (i32.const 8)) (br 1 (f64.const 8)))
    (loop (br 1) (br 1 (i32.const 8)) (br 1 (f32.const 8)) (i64.const 3))
    (loop (loop (br 1) (br 3 (i32.const 8))) (br 1 (f32.const 8)) (block (br 2 (f64.const 7))) (i64.const 3))
  )
  (func "drop-cont-value-heterogeneous"
    (loop (br 0 (i32.const 8)) (br 0 (f64.const 8)) (br 1 (f32.const 8)))
    (loop (br 0 (i32.const 8)) (br 0) (br 0 (f64.const 8)))
    (loop (br 0 (i32.const 8)) (br 0) (br 0 (f32.const 8)) (i64.const 3))
    (loop (br 0) (br 0 (i32.const 8)) (br 0 (f64.const 8)))
    (loop (br 0) (br 0 (i32.const 8)) (br 0 (f32.const 8)) (i64.const 3))
    (loop (loop (br 1) (br 2 (i32.const 8))) (br 0 (f32.const 8)) (block (br 1 (f64.const 7))) (i64.const 3))
  )

  (func "effects" $fx (result i32)
    (local i32)
    (loop
      (set_local 0 (i32.const 1))
      (set_local 0 (i32.mul (get_local 0) (i32.const 3)))
      (set_local 0 (i32.sub (get_local 0) (i32.const 5)))
      (set_local 0 (i32.mul (get_local 0) (i32.const 7)))
      (br 1)
      (set_local 0 (i32.mul (get_local 0) (i32.const 100)))
    )
    (i32.eq (get_local 0) (i32.const -14))
  )

  (func "while" (param i64) (result i64)
    (local i64)
    (set_local 1 (i64.const 1))
    (loop
      (br_if 1 (i64.eqz (get_local 0)))
      (set_local 1 (i64.mul (get_local 0) (get_local 1)))
      (set_local 0 (i64.sub (get_local 0) (i64.const 1)))
      (br 0)
    )
    (get_local 1)
  )

  (func "for" (param i64) (result i64)
    (local i64 i64)
    (set_local 1 (i64.const 1))
    (set_local 2 (i64.const 2))
    (loop
      (br_if 1 (i64.gt_u (get_local 2) (get_local 0)))
      (set_local 1 (i64.mul (get_local 1) (get_local 2)))
      (set_local 2 (i64.add (get_local 2) (i64.const 1)))
      (br 0)
    )
    (get_local 1)
  )

  (func "nesting" (param f32 f32) (result f32)
    (local f32 f32)
    (loop
      (br_if 1 (f32.eq (get_local 0) (f32.const 0)))
      (set_local 2 (get_local 1))
      (loop
        (br_if 1 (f32.eq (get_local 2) (f32.const 0)))
        (br_if 3 (f32.lt (get_local 2) (f32.const 0)))
        (set_local 3 (f32.add (get_local 3) (get_local 2)))
        (set_local 2 (f32.sub (get_local 2) (f32.const 2)))
        (br 0)
      )
      (set_local 3 (f32.div (get_local 3) (get_local 0)))
      (set_local 0 (f32.sub (get_local 0) (f32.const 1)))
      (br 0)
    )
    (get_local 3)
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

(assert_return (invoke "break-bare") (i32.const 19))
(assert_return (invoke "break-value") (i32.const 18))
(assert_return (invoke "break-repeated") (i32.const 18))
(assert_return (invoke "break-inner") (i32.const 0x1f))

(assert_return (invoke "drop-mid") (i32.const 8))
(assert_return (invoke "drop-last"))
(assert_return (invoke "drop-break-void"))
(assert_return (invoke "drop-break-value"))
(assert_return (invoke "drop-break-value-heterogeneous"))

(assert_return (invoke "effects") (i32.const 1))

(assert_return (invoke "while" (i64.const 0)) (i64.const 1))
(assert_return (invoke "while" (i64.const 1)) (i64.const 1))
(assert_return (invoke "while" (i64.const 2)) (i64.const 2))
(assert_return (invoke "while" (i64.const 3)) (i64.const 6))
(assert_return (invoke "while" (i64.const 5)) (i64.const 120))
(assert_return (invoke "while" (i64.const 20)) (i64.const 2432902008176640000))

(assert_return (invoke "for" (i64.const 0)) (i64.const 1))
(assert_return (invoke "for" (i64.const 1)) (i64.const 1))
(assert_return (invoke "for" (i64.const 2)) (i64.const 2))
(assert_return (invoke "for" (i64.const 3)) (i64.const 6))
(assert_return (invoke "for" (i64.const 5)) (i64.const 120))
(assert_return (invoke "for" (i64.const 20)) (i64.const 2432902008176640000))

(assert_return (invoke "nesting" (f32.const 0) (f32.const 7)) (f32.const 0))
(assert_return (invoke "nesting" (f32.const 7) (f32.const 0)) (f32.const 0))
(assert_return (invoke "nesting" (f32.const 1) (f32.const 1)) (f32.const 1))
(assert_return (invoke "nesting" (f32.const 1) (f32.const 2)) (f32.const 2))
(assert_return (invoke "nesting" (f32.const 1) (f32.const 3)) (f32.const 4))
(assert_return (invoke "nesting" (f32.const 1) (f32.const 4)) (f32.const 6))
(assert_return (invoke "nesting" (f32.const 1) (f32.const 100)) (f32.const 2550))
(assert_return (invoke "nesting" (f32.const 1) (f32.const 101)) (f32.const 2601))
(assert_return (invoke "nesting" (f32.const 2) (f32.const 1)) (f32.const 1))
(assert_return (invoke "nesting" (f32.const 3) (f32.const 1)) (f32.const 1))
(assert_return (invoke "nesting" (f32.const 10) (f32.const 1)) (f32.const 1))
(assert_return (invoke "nesting" (f32.const 2) (f32.const 2)) (f32.const 3))
(assert_return (invoke "nesting" (f32.const 2) (f32.const 3)) (f32.const 4))
(assert_return (invoke "nesting" (f32.const 7) (f32.const 4)) (f32.const 10.3095235825))
(assert_return (invoke "nesting" (f32.const 7) (f32.const 100)) (f32.const 4381.54785156))
(assert_return (invoke "nesting" (f32.const 7) (f32.const 101)) (f32.const 2601))

(assert_invalid
  (module (func (result i32) (loop)))
  "type mismatch"
)
(assert_invalid
  (module (func (result i32) (loop (nop))))
  "type mismatch"
)
(assert_invalid
  (module (func (result i32) (loop (f32.const 0))))
  "type mismatch"
)
(assert_invalid
  (module (func (result i32) (loop (br 1) (i32.const 1))))
  "type mismatch"
)
(assert_invalid
  (module (func (result i32) (loop (br 1 (i32.const 1)) (nop))))
  "type mismatch"
)
(assert_invalid
  (module (func (result i32) (loop (br 1 (i64.const 1)) (i32.const 1))))
  "type mismatch"
)
(assert_invalid
  (module (func (result i32) (loop (br 1 (i64.const 1)) (br 1 (i32.const 1)))))
  "type mismatch"
)
(assert_invalid
  (module (func (result i32) (loop (loop (br 3 (i64.const 1))) (br 1 (i32.const 1)))))
  "type mismatch"
)
(assert_invalid
  (module (func (result i32) (loop (br 1))))
  "type mismatch"
)
(assert_invalid
  (module (func (result i32) (i32.ctz (loop (br 1)))))
  "type mismatch"
)


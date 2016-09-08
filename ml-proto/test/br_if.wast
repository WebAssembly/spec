;; Test `br_if` operator

(module
  (func $dummy)

  (func "as-block-first" (param i32) (result i32)
    (block (br_if 0 (get_local 0)) (return (i32.const 2))) (i32.const 3)
  )
  (func "as-block-mid" (param i32) (result i32)
    (block (call $dummy) (br_if 0 (get_local 0)) (return (i32.const 2)))
    (i32.const 3)
  )
  (func "as-block-last" (param i32)
    (block (call $dummy) (call $dummy) (br_if 0 (get_local 0)))
  )
  (func "as-block-last-value" (param i32) (result i32)
    (block (call $dummy) (call $dummy) (br_if 0 (i32.const 11) (get_local 0)))
  )

  (func "as-loop-first" (param i32) (result i32)
    (block (loop (br_if 1 (get_local 0)) (return (i32.const 2)))) (i32.const 3)
  )
  (func "as-loop-mid" (param i32) (result i32)
    (block (loop (call $dummy) (br_if 1 (get_local 0)) (return (i32.const 2))))
    (i32.const 4)
  )
  (func "as-loop-last" (param i32)
    (loop (call $dummy) (br_if 1 (get_local 0)))
  )

  (func "as-if-then" (param i32 i32)
    (block (if (get_local 0) (br_if 1 (get_local 1)) (call $dummy)))
  )
  (func "as-if-else" (param i32 i32)
    (block (if (get_local 0) (call $dummy) (br_if 1 (get_local 1))))
  )

  (func "nested-block-value" (param i32) (result i32)
    (i32.add
      (i32.const 1)
      (block
        (drop (i32.const 2))
        (i32.add
          (i32.const 4)
          (block (drop (br_if 1 (i32.const 8) (get_local 0))) (i32.const 16))
        )
      )
    )
  )

  (func "nested-br-value" (param i32) (result i32)
    (i32.add
      (i32.const 1)
      (block
        (drop (i32.const 2))
        (br 0
          (block (drop (br_if 1 (i32.const 8) (get_local 0))) (i32.const 4))
        )
        (i32.const 16)
      )
    )
  )

  (func "nested-br_if-value" (param i32) (result i32)
    (i32.add
      (i32.const 1)
      (block
        (drop (i32.const 2))
        (drop (br_if 0
          (block (drop (br_if 1 (i32.const 8) (get_local 0))) (i32.const 4))
          (i32.const 1)
        ))
        (i32.const 16)
      )
    )
  )

  (func "nested-br_if-value-cond" (param i32) (result i32)
    (i32.add
      (i32.const 1)
      (block
        (drop (i32.const 2))
        (drop (br_if 0
          (i32.const 4)
          (block (drop (br_if 1 (i32.const 8) (get_local 0))) (i32.const 1))
        ))
        (i32.const 16)
      )
    )
  )

  (func "nested-br_table-value" (param i32) (result i32)
    (i32.add
      (i32.const 1)
      (block
        (drop (i32.const 2))
        (br_table 0
          (block (drop (br_if 1 (i32.const 8) (get_local 0))) (i32.const 4))
          (i32.const 1)
        )
        (i32.const 16)
      )
    )
  )

  (func "nested-br_table-value-index" (param i32) (result i32)
    (i32.add
      (i32.const 1)
      (block
        (drop (i32.const 2))
        (br_table 0
          (i32.const 4)
          (block (drop (br_if 1 (i32.const 8) (get_local 0))) (i32.const 1))
        )
        (i32.const 16)
      )
    )
  )
)

(assert_return (invoke "as-block-first" (i32.const 0)) (i32.const 2))
(assert_return (invoke "as-block-first" (i32.const 1)) (i32.const 3))
(assert_return (invoke "as-block-mid" (i32.const 0)) (i32.const 2))
(assert_return (invoke "as-block-mid" (i32.const 1)) (i32.const 3))
(assert_return (invoke "as-block-last" (i32.const 0)))
(assert_return (invoke "as-block-last" (i32.const 1)))
(assert_return (invoke "as-block-last-value" (i32.const 0)) (i32.const 11))
(assert_return (invoke "as-block-last-value" (i32.const 1)) (i32.const 11))

(assert_return (invoke "as-loop-first" (i32.const 0)) (i32.const 2))
(assert_return (invoke "as-loop-first" (i32.const 1)) (i32.const 3))
(assert_return (invoke "as-loop-mid" (i32.const 0)) (i32.const 2))
(assert_return (invoke "as-loop-mid" (i32.const 1)) (i32.const 4))
(assert_return (invoke "as-loop-last" (i32.const 0)))
(assert_return (invoke "as-loop-last" (i32.const 1)))

(assert_return (invoke "as-if-then" (i32.const 0) (i32.const 0)))
(assert_return (invoke "as-if-then" (i32.const 4) (i32.const 0)))
(assert_return (invoke "as-if-then" (i32.const 0) (i32.const 1)))
(assert_return (invoke "as-if-then" (i32.const 4) (i32.const 1)))
(assert_return (invoke "as-if-else" (i32.const 0) (i32.const 0)))
(assert_return (invoke "as-if-else" (i32.const 3) (i32.const 0)))
(assert_return (invoke "as-if-else" (i32.const 0) (i32.const 1)))
(assert_return (invoke "as-if-else" (i32.const 3) (i32.const 1)))

(assert_return (invoke "nested-block-value" (i32.const 0)) (i32.const 21))
(assert_return (invoke "nested-block-value" (i32.const 1)) (i32.const 9))
(assert_return (invoke "nested-br-value" (i32.const 0)) (i32.const 5))
(assert_return (invoke "nested-br-value" (i32.const 1)) (i32.const 9))
(assert_return (invoke "nested-br_if-value" (i32.const 0)) (i32.const 5))
(assert_return (invoke "nested-br_if-value" (i32.const 1)) (i32.const 9))
(assert_return (invoke "nested-br_if-value-cond" (i32.const 0)) (i32.const 5))
(assert_return (invoke "nested-br_if-value-cond" (i32.const 1)) (i32.const 9))
(assert_return (invoke "nested-br_table-value" (i32.const 0)) (i32.const 5))
(assert_return (invoke "nested-br_table-value" (i32.const 1)) (i32.const 9))
(assert_return (invoke "nested-br_table-value-index" (i32.const 0)) (i32.const 5))
(assert_return (invoke "nested-br_table-value-index" (i32.const 1)) (i32.const 9))

(assert_invalid
  (module (func $type-false-i32 (block (i32.ctz (br_if 0 (i32.const 0))))))
  "type mismatch"
)
(assert_invalid
  (module (func $type-false-i64 (block (i64.ctz (br_if 0 (i32.const 0))))))
  "type mismatch"
)
(assert_invalid
  (module (func $type-false-f32 (block (f32.neg (br_if 0 (i32.const 0))))))
  "type mismatch"
)
(assert_invalid
  (module (func $type-false-f64 (block (f64.neg (br_if 0 (i32.const 0))))))
  "type mismatch"
)

(assert_invalid
  (module (func $type-true-i32 (block (i32.ctz (br_if 0 (i32.const 1))))))
  "type mismatch"
)
(assert_invalid
  (module (func $type-true-i64 (block (i64.ctz (br_if 0 (i64.const 1))))))
  "type mismatch"
)
(assert_invalid
  (module (func $type-true-f32 (block (f32.neg (br_if 0 (f32.const 1))))))
  "type mismatch"
)
(assert_invalid
  (module (func $type-true-f64 (block (f64.neg (br_if 0 (i64.const 1))))))
  "type mismatch"
)

(assert_invalid
  (module (func $type-false-arg-empty-vs-num (result i32)
    (block (br_if 0 (i32.const 0)) (i32.const 1))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-true-arg-empty-vs-num (result i32)
    (block (br_if 0 (i32.const 1)) (i32.const 1))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-false-arg-void-vs-empty
    (block (br_if 0 (nop) (i32.const 0)))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-true-arg-void-vs-empty
    (block (br_if 0 (nop) (i32.const 1)))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-false-arg-num-vs-empty
    (block (br_if 0 (i32.const 0) (i32.const 0)))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-true-arg-num-vs-empty
    (block (br_if 0 (i32.const 0) (i32.const 1)))
  ))
  "type mismatch"
)
(; TODO(stack): Should these become legal?
(assert_invalid
  (module (func $type-false-arg-poly-vs-empty
    (block (br_if 0 (unreachable) (i32.const 0)))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-true-arg-poly-vs-empty
    (block (br_if 0 (unreachable) (i32.const 1)))
  ))
  "type mismatch"
)
;)

(assert_invalid
  (module (func $type-false-arg-void-vs-num (result i32)
    (block (br_if 0 (nop) (i32.const 0)) (i32.const 1))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-true-arg-void-vs-num (result i32)
    (block (br_if 0 (nop) (i32.const 1)) (i32.const 1))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-false-arg-num-vs-num (result i32)
    (block (drop (br_if 0 (i64.const 1) (i32.const 0))) (i32.const 1))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-true-arg-num-vs-num (result i32)
    (block (drop (br_if 0 (i64.const 1) (i32.const 0))) (i32.const 1))
  ))
  "type mismatch"
)

(assert_invalid
  (module (func $type-cond-void-vs-i32
    (block (br_if 0 (nop)))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-cond-num-vs-i32
    (block (br_if 0 (i64.const 0)))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-arg-cond-void-vs-i32 (result i32)
    (block (br_if 0 (i32.const 0) (nop)) (i32.const 1))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-arg-cond-num-vs-i32 (result i32)
    (block (br_if 0 (i32.const 0) (i64.const 0)) (i32.const 1))
  ))
  "type mismatch"
)

(assert_invalid
  (module (func $type-binary (result i64)
    (block (i64.const 1) (i64.const 2) (i64.const 3) br_if 2 0)
    i64.add
  ))
  "invalid result arity"
)
(assert_invalid
  (module (func $type-binary-with-nop (result i32)
    (block (nop) (i32.const 7) (nop) (i32.const 8) (i64.const 3) br_if 2 0)
    i32.add
  ))
  "invalid result arity"
)

(assert_invalid
  (module (func $unbound-label (br_if 1 (i32.const 1))))
  "unknown label"
)
(assert_invalid
  (module (func $unbound-nested-label (block (block (br_if 5 (i32.const 1))))))
  "unknown label"
)
(assert_invalid
  (module (func $large-label (br_if 0x100000001 (i32.const 1))))
  "unknown label"
)


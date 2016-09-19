;; Test soft failures
;; These are invalid Wasm, but the failure is in dead code, which
;; implementations are not required to validate. If they do, they shall diagnose
;; the correct error.

(assert_soft_invalid
  (module (func $type-num-vs-num
    (unreachable) (drop (i64.eqz (i32.const 0))))
  )
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-poly-num-vs-num (result i32)
    (unreachable) (i64.const 0) (i32.const 0) (select)
  ))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-poly-transitive-num-vs-num (result i32)
    (unreachable)
    (i64.const 0) (i32.const 0) (select)
    (i32.const 0) (i32.const 0) (select)
  ))
  "type mismatch"
)

(assert_soft_invalid
  (module (func $type-unconsumed-const (unreachable) (i32.const 0)))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-unconsumed-result (unreachable) (i32.eqz)))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-unconsumed-result2 (unreachable) (i32.const 0) (i32.add)))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-unconsumed-poly0 (unreachable) (select)))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-unconsumed-poly1 (unreachable) (i32.const 0) (select)))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-unconsumed-poly2
    (unreachable) (i32.const 0) (i32.const 0) (select)
  ))
  "type mismatch"
)

(assert_soft_invalid
  (module (func $type-block-value-num-vs-void-after-break
    (block (br 0) (i32.const 1))
  ))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-block-value-num-vs-num-after-break (result i32)
    (block i32 (i32.const 1) (br 0) (f32.const 0))
  ))
  "type mismatch"
)

(assert_soft_invalid
  (module (func $type-loop-value-num-vs-void-after-break
    (block (loop (br 1) (i32.const 1)))
  ))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-loop-value-num-vs-num-after-break (result i32)
    (loop i32 (br 1 (i32.const 1)) (f32.const 0))
  ))
  "type mismatch"
)

(assert_soft_invalid
  (module (func $type-func-value-num-vs-void-after-break
    (br 0) (i32.const 1)
  ))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-func-value-num-vs-num-after-break (result i32)
    (br 0 (i32.const 1)) (f32.const 0)
  ))
  "type mismatch"
)

(assert_soft_invalid
  (module (func $type-br-second-num-vs-num (result i32)
    (block i32 (br 0 (i32.const 1)) (br 0 (f64.const 1)))
  ))
  "type mismatch"
)

(assert_soft_invalid
  (module (func $type-br_if-cond-num-vs-num
    (block (br_if 0 (unreachable) (f32.const 0)))
  ))
  "type mismatch"
)

(assert_soft_invalid
  (module (func $type-br_table-num-vs-num
    (block (br_table 0 (unreachable) (f32.const 1)))
  ))
  "type mismatch"
)

(assert_soft_invalid
  (module (func $type-block-value-nested-unreachable-num-vs-void
    (block (i32.const 3) (block (unreachable)))
  ))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-block-value-nested-unreachable-void-vs-num (result i32)
    (block (block (unreachable)))
  ))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-block-value-nested-unreachable-num-vs-num (result i32)
    (block i64 (i64.const 0) (block (unreachable)))
  ))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-block-value-nested-unreachable-num2-vs-void (result i32)
    (block (i32.const 3) (block (i64.const 1) (unreachable))) (i32.const 9)
  ))
  "type mismatch"
)

(assert_soft_invalid
  (module (func $type-block-value-nested-br-num-vs-void
    (block (i32.const 3) (block (br 1)))
  ))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-block-value-nested-br-void-vs-num (result i32)
    (block i32 (block (br 1 (i32.const 0))))
  ))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-block-value-nested-br-num-vs-num (result i32)
    (block i32 (i64.const 0) (block (br 1 (i32.const 0))))
  ))
  "type mismatch"
)

(assert_soft_invalid
  (module (func $type-block-value-nested2-br-num-vs-void
    (block (block (i32.const 3) (block (br 2))))
  ))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-block-value-nested2-br-void-vs-num (result i32)
    (block i32 (block (block (br 2 (i32.const 0)))))
  ))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-block-value-nested2-br-num-vs-num (result i32)
    (block i32 (block i64 (i64.const 0) (block (br 2 (i32.const 0)))))
  ))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-block-value-nested2-br-num2-vs-void (result i32)
    (block (i32.const 3) (block (i64.const 1) (br 1))) (i32.const 9)
  ))
  "type mismatch"
)

(assert_soft_invalid
  (module (func $type-block-value-nested-return-num-vs-void
    (block (i32.const 3) (block (return)))
  ))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-block-value-nested-return-void-vs-num (result i32)
    (block (block (return (i32.const 0))))
  ))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-block-value-nested-return-num-vs-num (result i32)
    (block i64 (i64.const 0) (block (return (i32.const 0))))
  ))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-block-value-nested-return-num2-vs-void (result i32)
    (block (i32.const 3) (block (i64.const 1) (return (i32.const 0))))
    (i32.const 9)
  ))
  "type mismatch"
)

(assert_soft_invalid
  (module (func $type-loop-value-nested-unreachable-num-vs-void
    (loop (i32.const 3) (block (unreachable)))
  ))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-loop-value-nested-unreachable-void-vs-num (result i32)
    (loop (block (unreachable)))
  ))
  "type mismatch"
)
(assert_soft_invalid
  (module (func $type-loop-value-nested-unreachable-num-vs-num (result i32)
    (loop i64 (i64.const 0) (block (unreachable)))
  ))
  "type mismatch"
)

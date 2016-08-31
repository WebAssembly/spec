;; Test `br` operator

(module
  ;; Auxiliary definition
  (func $dummy)

  (export "type-i32" (func (block (drop (i32.ctz (br 0))))))
  (export "type-i64" (func (block (drop (i64.ctz (br 0))))))
  (export "type-f32" (func (block (drop (f32.neg (br 0))))))
  (export "type-f64" (func (block (drop (f64.neg (br 0))))))

  (export "type-i32-value" (func (result i32) (block (i32.ctz (br 0 (i32.const 1))))))
  (export "type-i64-value" (func (result i64) (block (i64.ctz (br 0 (i64.const 2))))))
  (export "type-f32-value" (func (result f32) (block (f32.neg (br 0 (f32.const 3))))))
  (export "type-f64-value" (func (result f64) (block (f64.neg (br 0 (f64.const 4))))))

  (export "as-block-first" (func
    (block (br 0) (call $dummy))
  ))
  (export "as-block-mid" (func
    (block (call $dummy) (br 0) (call $dummy))
  ))
  (export "as-block-last" (func
    (block (nop) (call $dummy) (br 0))
  ))
  (export "as-block-value" (func (result i32)
    (block (nop) (call $dummy) (br 0 (i32.const 2)))
  ))

  (export "as-loop-first" (func (result i32)
    (loop (br 1 (i32.const 3)) (i32.const 2))
  ))
  (export "as-loop-mid" (func (result i32)
    (loop (call $dummy) (br 1 (i32.const 4)) (i32.const 2))
  ))
  (export "as-loop-last" (func (result i32)
    (loop (nop) (call $dummy) (br 1 (i32.const 5)))
  ))

  (export "as-br-value" (func (result i32)
    (block (br 0 (br 0 (i32.const 9))))
  ))

  (export "as-br_if-cond" (func
    (block (br_if 0 (br 0)))
  ))
  (export "as-br_if-value" (func (result i32)
    (block (br_if 0 (br 0 (i32.const 8)) (i32.const 1)) (i32.const 7))
  ))
  (export "as-br_if-value-cond" (func (result i32)
    (block (br_if 0 (i32.const 6) (br 0 (i32.const 9))) (i32.const 7))
  ))

  (export "as-br_table-index" (func
    (block (br_table 0 0 0 (br 0)))
  ))
  (export "as-br_table-value" (func (result i32)
    (block (br_table 0 0 0 (br 0 (i32.const 10)) (i32.const 1)) (i32.const 7))
  ))
  (export "as-br_table-value-index" (func (result i32)
    (block (br_table 0 0 (i32.const 6) (br 0 (i32.const 11))) (i32.const 7))
  ))

  (export "as-return-value" (func (result i64)
    (block (return (br 0 (i64.const 7))))
  ))

  (export "as-if-cond" (func (result i32)
    (block (if (br 0 (i32.const 2)) (i32.const 0) (i32.const 1)))
  ))
  (export "as-if-then" (func (param i32 i32) (result i32)
    (block (if (get_local 0) (br 1 (i32.const 3)) (get_local 1)))
  ))
  (export "as-if-else" (func (param i32 i32) (result i32)
    (block (if (get_local 0) (get_local 1) (br 1 (i32.const 4))))
  ))

  (export "as-select-first" (func (param i32 i32) (result i32)
    (block (select (br 0 (i32.const 5)) (get_local 0) (get_local 1)))
  ))
  (export "as-select-second" (func (param i32 i32) (result i32)
    (block (select (get_local 0) (br 0 (i32.const 6)) (get_local 1)))
  ))
  (export "as-select-cond" (func (result i32)
    (block (select (i32.const 0) (i32.const 1) (br 0 (i32.const 7))))
  ))

  (func $f (param i32 i32 i32) (result i32) (i32.const -1))
  (export "as-call-first" (func (result i32)
    (block (call $f (br 0 (i32.const 12)) (i32.const 2) (i32.const 3)))
  ))
  (export "as-call-mid" (func (result i32)
    (block (call $f (i32.const 1) (br 0 (i32.const 13)) (i32.const 3)))
  ))
  (export "as-call-last" (func (result i32)
    (block (call $f (i32.const 1) (i32.const 2) (br 0 (i32.const 14))))
  ))

  (type $sig (func (param i32 i32 i32) (result i32)))
  (table anyfunc (elem $f))
  (export "as-call_indirect-func" (func (result i32)
    (block
      (call_indirect $sig
        (br 0 (i32.const 20))
        (i32.const 1) (i32.const 2) (i32.const 3)
      )
    )
  ))
  (export "as-call_indirect-first" (func (result i32)
    (block
      (call_indirect $sig
        (i32.const 0)
        (br 0 (i32.const 21)) (i32.const 2) (i32.const 3)
      )
    )
  ))
  (export "as-call_indirect-mid" (func (result i32)
    (block
      (call_indirect $sig
        (i32.const 0)
        (i32.const 1) (br 0 (i32.const 22)) (i32.const 3)
      )
    )
  ))
  (export "as-call_indirect-last" (func (result i32)
    (block
      (call_indirect $sig
        (i32.const 0)
        (i32.const 1) (i32.const 2) (br 0 (i32.const 23))
      )
    )
  ))

  (export "as-set_local-value" (func (result i32) (local f32)
    (block (set_local 0 (br 0 (i32.const 17))) (i32.const -1))
  ))

  (memory 1)
  (export "as-load-address" (func (result f32)
    (block (f32.load (br 0 (f32.const 1.7))))
  ))
  (export "as-loadN-address" (func (result i64)
    (block (i64.load8_s (br 0 (i64.const 30))))
  ))

  (export "as-store-address" (func (result i32)
    (block (f64.store (br 0 (i32.const 30)) (f64.const 7)) (i32.const -1))
  ))
  (export "as-store-value" (func (result i32)
    (block (i64.store (i32.const 2) (br 0 (i32.const 31))) (i32.const -1))
  ))

  (export "as-storeN-address" (func (result i32)
    (block (i32.store8 (br 0 (i32.const 32)) (i32.const 7)) (i32.const -1))
  ))
  (export "as-storeN-value" (func (result i32)
    (block (i64.store16 (i32.const 2) (br 0 (i32.const 33))) (i32.const -1))
  ))

  (export "as-unary-operand" (func (result f32)
    (block (f32.neg (br 0 (f32.const 3.4))))
  ))

  (export "as-binary-left" (func (result i32)
    (block (i32.add (br 0 (i32.const 3)) (i32.const 10)))
  ))
  (export "as-binary-right" (func (result i64)
    (block (i64.sub (i64.const 10) (br 0 (i64.const 45))))
  ))

  (export "as-test-operand" (func (result i32)
    (block (i32.eqz (br 0 (i32.const 44))))
  ))

  (export "as-compare-left" (func (result i32)
    (block (f64.le (br 0 (i32.const 43)) (f64.const 10)))
  ))
  (export "as-compare-right" (func (result i32)
    (block (f32.ne (f32.const 10) (br 0 (i32.const 42))))
  ))

  (export "as-convert-operand" (func (result i32)
    (block (i32.wrap/i64 (br 0 (i32.const 41))))
  ))

  (export "as-grow_memory-size" (func (result i32)
    (block (grow_memory (br 0 (i32.const 40))))
  ))

  (export "nested-block-value" (func (result i32)
    (i32.add
      (i32.const 1)
      (block
        (call $dummy)
        (i32.add (i32.const 4) (br 0 (i32.const 8)))
      )
    )
  ))

  (export "nested-br-value" (func (result i32)
    (i32.add
      (i32.const 1)
      (block
        (drop (i32.const 2))
        (drop
          (block
            (drop (i32.const 4))
            (br 0 (br 1 (i32.const 8)))
          )
        )
        (i32.const 16)
      )
    )
  ))

  (export "nested-br_if-value" (func (result i32)
    (i32.add
      (i32.const 1)
      (block
        (drop (i32.const 2))
        (drop
          (block
            (drop (i32.const 4))
            (br_if 0 (br 1 (i32.const 8)) (i32.const 1))
            (i32.const 32)
          )
        )
        (i32.const 16)
      )
    )
  ))

  (export "nested-br_if-value-cond" (func (result i32)
    (i32.add
      (i32.const 1)
      (block
        (drop (i32.const 2))
        (br_if 0 (i32.const 4) (br 0 (i32.const 8)))
        (i32.const 16)
      )
    )
  ))

  (export "nested-br_table-value" (func (result i32)
    (i32.add
      (i32.const 1)
      (block
        (drop (i32.const 2))
        (drop
          (block
            (drop (i32.const 4))
            (br_table 0 (br 1 (i32.const 8)) (i32.const 1))
          )
        )
        (i32.const 16)
      )
    )
  ))

  (export "nested-br_table-value-index" (func (result i32)
    (i32.add
      (i32.const 1)
      (block
        (drop (i32.const 2))
        (br_table 0 (i32.const 4) (br 0 (i32.const 8)))
        (i32.const 16)
      )
    )
  ))
)

(assert_return (invoke "type-i32"))
(assert_return (invoke "type-i64"))
(assert_return (invoke "type-f32"))
(assert_return (invoke "type-f64"))

(assert_return (invoke "type-i32-value") (i32.const 1))
(assert_return (invoke "type-i64-value") (i64.const 2))
(assert_return (invoke "type-f32-value") (f32.const 3))
(assert_return (invoke "type-f64-value") (f64.const 4))

(assert_return (invoke "as-block-first"))
(assert_return (invoke "as-block-mid"))
(assert_return (invoke "as-block-last"))
(assert_return (invoke "as-block-value") (i32.const 2))

(assert_return (invoke "as-loop-first") (i32.const 3))
(assert_return (invoke "as-loop-mid") (i32.const 4))
(assert_return (invoke "as-loop-last") (i32.const 5))

(assert_return (invoke "as-br-value") (i32.const 9))

(assert_return (invoke "as-br_if-cond"))
(assert_return (invoke "as-br_if-value") (i32.const 8))
(assert_return (invoke "as-br_if-value-cond") (i32.const 9))

(assert_return (invoke "as-br_table-index"))
(assert_return (invoke "as-br_table-value") (i32.const 10))
(assert_return (invoke "as-br_table-value-index") (i32.const 11))

(assert_return (invoke "as-return-value") (i64.const 7))

(assert_return (invoke "as-if-cond") (i32.const 2))
(assert_return (invoke "as-if-then" (i32.const 1) (i32.const 6)) (i32.const 3))
(assert_return (invoke "as-if-then" (i32.const 0) (i32.const 6)) (i32.const 6))
(assert_return (invoke "as-if-else" (i32.const 0) (i32.const 6)) (i32.const 4))
(assert_return (invoke "as-if-else" (i32.const 1) (i32.const 6)) (i32.const 6))

(assert_return (invoke "as-select-first" (i32.const 0) (i32.const 6)) (i32.const 5))
(assert_return (invoke "as-select-first" (i32.const 1) (i32.const 6)) (i32.const 5))
(assert_return (invoke "as-select-second" (i32.const 0) (i32.const 6)) (i32.const 6))
(assert_return (invoke "as-select-second" (i32.const 1) (i32.const 6)) (i32.const 6))
(assert_return (invoke "as-select-cond") (i32.const 7))

(assert_return (invoke "as-call-first") (i32.const 12))
(assert_return (invoke "as-call-mid") (i32.const 13))
(assert_return (invoke "as-call-last") (i32.const 14))

(assert_return (invoke "as-call_indirect-func") (i32.const 20))
(assert_return (invoke "as-call_indirect-first") (i32.const 21))
(assert_return (invoke "as-call_indirect-mid") (i32.const 22))
(assert_return (invoke "as-call_indirect-last") (i32.const 23))

(assert_return (invoke "as-set_local-value") (i32.const 17))

(assert_return (invoke "as-load-address") (f32.const 1.7))
(assert_return (invoke "as-loadN-address") (i64.const 30))

(assert_return (invoke "as-store-address") (i32.const 30))
(assert_return (invoke "as-store-value") (i32.const 31))
(assert_return (invoke "as-storeN-address") (i32.const 32))
(assert_return (invoke "as-storeN-value") (i32.const 33))

(assert_return (invoke "as-unary-operand") (f32.const 3.4))

(assert_return (invoke "as-binary-left") (i32.const 3))
(assert_return (invoke "as-binary-right") (i64.const 45))

(assert_return (invoke "as-test-operand") (i32.const 44))

(assert_return (invoke "as-compare-left") (i32.const 43))
(assert_return (invoke "as-compare-right") (i32.const 42))

(assert_return (invoke "as-convert-operand") (i32.const 41))

(assert_return (invoke "as-grow_memory-size") (i32.const 40))

(assert_return (invoke "nested-block-value") (i32.const 9))
(assert_return (invoke "nested-br-value") (i32.const 9))
(assert_return (invoke "nested-br_if-value") (i32.const 9))
(assert_return (invoke "nested-br_if-value-cond") (i32.const 9))
(assert_return (invoke "nested-br_table-value") (i32.const 9))
(assert_return (invoke "nested-br_table-value-index") (i32.const 9))

(assert_invalid
  (module (func $type-arg-empty-vs-num (result i32)
    (block (br 0) (i32.const 1))
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-arg-void-vs-empty
    (block (br 0 (nop)))
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-arg-num-vs-empty
    (block (br 0 (i32.const 0)))
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-arg-poly-vs-empty
    (block (br 0 (unreachable)))
  ))
  "arity mismatch"
)

(assert_invalid
  (module (func $type-arg-void-vs-num (result i32)
    (block (br 0 (nop)) (i32.const 1))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-arg-num-vs-num (result i32)
    (block (br 0 (i64.const 1)) (i32.const 1))
  ))
  "type mismatch"
)

(assert_invalid
  (module (func $unbound-label (br 1)))
  "unknown label"
)
(assert_invalid
  (module (func $unbound-nested-label (block (block (br 5)))))
  "unknown label"
)
(assert_invalid
  (module (func $large-label (br 0x100000001)))
  "unknown label"
)

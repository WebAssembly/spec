;; Test `return` operator

(module
  ;; Auxiliary definition
  (func $dummy)

  (export "type-i32" (func (drop (i32.ctz (return)))))
  (export "type-i64" (func (drop (i64.ctz (return)))))
  (export "type-f32" (func (drop (f32.neg (return)))))
  (export "type-f64" (func (drop (f64.neg (return)))))

  (export "nullary" (func (return)))
  (export "unary" (func (result f64) (return (f64.const 3.1))))

  (export "as-func-first" (func (result i32)
    (return (i32.const 1)) (i32.const 2)
  ))
  (export "as-func-mid" (func (result i32)
    (call $dummy) (return (i32.const 2)) (i32.const 3)
  ))
  (export "as-func-last" (func
    (nop) (call $dummy) (return)
  ))
  (export "as-func-value" (func (result i32)
    (nop) (call $dummy) (return (i32.const 3))
  ))

  (export "as-block-first" (func
    (block (return) (call $dummy))
  ))
  (export "as-block-mid" (func
    (block (call $dummy) (return) (call $dummy))
  ))
  (export "as-block-last" (func
    (block (nop) (call $dummy) (return))
  ))
  (export "as-block-value" (func (result i32)
    (block (nop) (call $dummy) (return (i32.const 2)))
  ))

  (export "as-loop-first" (func (result i32)
    (loop (return (i32.const 3)) (i32.const 2))
  ))
  (export "as-loop-mid" (func (result i32)
    (loop (call $dummy) (return (i32.const 4)) (i32.const 2))
  ))
  (export "as-loop-last" (func (result i32)
    (loop (nop) (call $dummy) (return (i32.const 5)))
  ))

  (export "as-br-value" (func (result i32)
    (block (br 0 (return (i32.const 9))))
  ))

  (export "as-br_if-cond" (func
    (block (br_if 0 (return)))
  ))
  (export "as-br_if-value" (func (result i32)
    (block (br_if 0 (return (i32.const 8)) (i32.const 1)) (i32.const 7))
  ))
  (export "as-br_if-value-cond" (func (result i32)
    (block (br_if 0 (i32.const 6) (return (i32.const 9))) (i32.const 7))
  ))

  (export "as-br_table-index" (func (result i64)
    (block (br_table 0 0 0 (return (i64.const 9)))) (i64.const -1)
  ))
  (export "as-br_table-value" (func (result i32)
    (block (br_table 0 0 0 (return (i32.const 10)) (i32.const 1)) (i32.const 7))
  ))
  (export "as-br_table-value-index" (func (result i32)
    (block (br_table 0 0 (i32.const 6) (return (i32.const 11))) (i32.const 7))
  ))

  (export "as-return-value" (func (result i64)
    (return (return (i64.const 7)))
  ))

  (export "as-if-cond" (func (result i32)
    (if (return (i32.const 2)) (i32.const 0) (i32.const 1))
  ))
  (export "as-if-then" (func (param i32 i32) (result i32)
    (if (get_local 0) (return (i32.const 3)) (get_local 1))
  ))
  (export "as-if-else" (func (param i32 i32) (result i32)
    (if (get_local 0) (get_local 1) (return (i32.const 4)))
  ))

  (export "as-select-first" (func (param i32 i32) (result i32)
    (select (return (i32.const 5)) (get_local 0) (get_local 1))
  ))
  (export "as-select-second" (func (param i32 i32) (result i32)
    (select (get_local 0) (return (i32.const 6)) (get_local 1))
  ))
  (export "as-select-cond" (func (result i32)
    (select (i32.const 0) (i32.const 1) (return (i32.const 7)))
  ))

  (func $f (param i32 i32 i32) (result i32) (i32.const -1))
  (export "as-call-first" (func (result i32)
    (call $f (return (i32.const 12)) (i32.const 2) (i32.const 3))
  ))
  (export "as-call-mid" (func (result i32)
    (call $f (i32.const 1) (return (i32.const 13)) (i32.const 3))
  ))
  (export "as-call-last" (func (result i32)
    (call $f (i32.const 1) (i32.const 2) (return (i32.const 14)))
  ))

  (type $sig (func (param i32 i32 i32) (result i32)))
  (table anyfunc (elem $f))
  (export "as-call_indirect-func" (func (result i32)
    (call_indirect $sig (return (i32.const 20)) (i32.const 1) (i32.const 2) (i32.const 3))
  ))
  (export "as-call_indirect-first" (func (result i32)
    (call_indirect $sig (i32.const 0) (return (i32.const 21)) (i32.const 2) (i32.const 3))
  ))
  (export "as-call_indirect-mid" (func (result i32)
    (call_indirect $sig (i32.const 0) (i32.const 1) (return (i32.const 22)) (i32.const 3))
  ))
  (export "as-call_indirect-last" (func (result i32)
    (call_indirect $sig (i32.const 0) (i32.const 1) (i32.const 2) (return (i32.const 23)))
  ))

  (export "as-set_local-value" (func (result i32) (local f32)
    (set_local 0 (return (i32.const 17))) (i32.const -1)
  ))

  (memory 1)
  (export "as-load-address" (func (result f32)
    (f32.load (return (f32.const 1.7)))
  ))
  (export "as-loadN-address" (func (result i64)
    (i64.load8_s (return (i64.const 30)))
  ))

  (export "as-store-address" (func (result i32)
    (f64.store (return (i32.const 30)) (f64.const 7)) (i32.const -1)
  ))
  (export "as-store-value" (func (result i32)
    (i64.store (i32.const 2) (return (i32.const 31))) (i32.const -1)
  ))

  (export "as-storeN-address" (func (result i32)
    (i32.store8 (return (i32.const 32)) (i32.const 7)) (i32.const -1)
  ))
  (export "as-storeN-value" (func (result i32)
    (i64.store16 (i32.const 2) (return (i32.const 33))) (i32.const -1)
  ))

  (export "as-unary-operand" (func (result f32)
    (f32.neg (return (f32.const 3.4)))
  ))

  (export "as-binary-left" (func (result i32)
    (i32.add (return (i32.const 3)) (i32.const 10))
  ))
  (export "as-binary-right" (func (result i64)
    (i64.sub (i64.const 10) (return (i64.const 45)))
  ))

  (export "as-test-operand" (func (result i32)
    (i32.eqz (return (i32.const 44)))
  ))

  (export "as-compare-left" (func (result i32)
    (f64.le (return (i32.const 43)) (f64.const 10))
  ))
  (export "as-compare-right" (func (result i32)
    (f32.ne (f32.const 10) (return (i32.const 42)))
  ))

  (export "as-convert-operand" (func (result i32)
    (i32.wrap/i64 (return (i32.const 41)))
  ))

  (export "as-grow_memory-size" (func (result i32)
    (grow_memory (return (i32.const 40)))
  ))
)

(assert_return (invoke "type-i32"))
(assert_return (invoke "type-i64"))
(assert_return (invoke "type-f32"))
(assert_return (invoke "type-f64"))

(assert_return (invoke "nullary"))
(assert_return (invoke "unary") (f64.const 3.1))

(assert_return (invoke "as-func-first") (i32.const 1))
(assert_return (invoke "as-func-mid") (i32.const 2))
(assert_return (invoke "as-func-last"))
(assert_return (invoke "as-func-value") (i32.const 3))

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

(assert_return (invoke "as-br_table-index") (i64.const 9))
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

(assert_invalid
  (module (func $type-value-void-vs-empty (return (nop))))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-value-num-vs-empty (return (i32.const 0))))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-value-empty-vs-num (result f64) (return)))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-value-void-vs-num (result f64) (return (nop))))
  "type mismatch"
)
(assert_invalid
  (module (func $type-value-num-vs-num (result f64) (return (i64.const 1))))
  "type mismatch"
)


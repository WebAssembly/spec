;; Test `unreachable` operator

(module
  ;; Auxiliary definitions
  (func $dummy)
  (func $dummy3 (param i32 i32 i32))

  (export "type-i32" (func (result i32) (unreachable)))
  (export "type-i64" (func (result i32) (unreachable)))
  (export "type-f32" (func (result f64) (unreachable)))
  (export "type-f64" (func (result f64) (unreachable)))

  (export "as-func-first" (func (result i32)
    (unreachable) (i32.const -1)
  ))
  (export "as-func-mid" (func (result i32)
    (call $dummy) (unreachable) (i32.const -1)
  ))
  (export "as-func-last" (func
    (call $dummy) (unreachable)
  ))
  (export "as-func-value" (func (result i32)
    (call $dummy) (unreachable)
  ))

  (export "as-block-first" (func (result i32)
    (block (unreachable) (i32.const 2))
  ))
  (export "as-block-mid" (func (result i32)
    (block (call $dummy) (unreachable) (i32.const 2))
  ))
  (export "as-block-last" (func
    (block (nop) (call $dummy) (unreachable))
  ))
  (export "as-block-value" (func (result i32)
    (block (nop) (call $dummy) (unreachable))
  ))
  (export "as-block-broke" (func (result i32)
    (block (call $dummy) (br 0 (i32.const 1)) (unreachable))
  ))

  (export "as-loop-first" (func (result i32)
    (loop (unreachable) (i32.const 2))
  ))
  (export "as-loop-mid" (func (result i32)
    (loop (call $dummy) (unreachable) (i32.const 2))
  ))
  (export "as-loop-last" (func
    (loop (nop) (call $dummy) (unreachable))
  ))
  (export "as-loop-broke" (func (result i32)
    (loop (call $dummy) (br 1 (i32.const 1)) (unreachable))
  ))

  (export "as-br-value" (func (result i32)
    (block (br 0 (unreachable)))
  ))

  (export "as-br_if-cond" (func
    (block (br_if 0 (unreachable)))
  ))
  (export "as-br_if-value" (func (result i32)
    (block (br_if 0 (unreachable) (i32.const 1)) (i32.const 7))
  ))
  (export "as-br_if-value-cond" (func (result i32)
    (block (br_if 0 (i32.const 6) (unreachable)) (i32.const 7))
  ))

  (export "as-br_table-index" (func
    (block (br_table 0 0 0 (unreachable)))
  ))
  (export "as-br_table-value" (func (result i32)
    (block (br_table 0 0 0 (unreachable) (i32.const 1)) (i32.const 7))
  ))
  (export "as-br_table-value-index" (func (result i32)
    (block (br_table 0 0 (i32.const 6) (unreachable)) (i32.const 7))
  ))

  (export "as-return-value" (func (result i64)
    (return (unreachable))
  ))

  (export "as-if-cond" (func (result i32)
    (if (unreachable) (i32.const 0) (i32.const 1))
  ))
  (export "as-if-then" (func (param i32 i32) (result i32)
    (if (get_local 0) (unreachable) (get_local 1))
  ))
  (export "as-if-else" (func (param i32 i32) (result i32)
    (if (get_local 0) (get_local 1) (unreachable))
  ))

  (export "as-select-first" (func (param i32 i32) (result i32)
    (select (unreachable) (get_local 0) (get_local 1))
  ))
  (export "as-select-second" (func (param i32 i32) (result i32)
    (select (get_local 0) (unreachable) (get_local 1))
  ))
  (export "as-select-cond" (func (result i32)
    (select (i32.const 0) (i32.const 1) (unreachable))
  ))

  (export "as-call-first" (func
    (call $dummy3 (unreachable) (i32.const 2) (i32.const 3))
  ))
  (export "as-call-mid" (func
    (call $dummy3 (i32.const 1) (unreachable) (i32.const 3))
  ))
  (export "as-call-last" (func
    (call $dummy3 (i32.const 1) (i32.const 2) (unreachable))
  ))

  (type $sig (func (param i32 i32 i32)))
  (table anyfunc (elem $dummy3))
  (export "as-call_indirect-func" (func
    (call_indirect $sig (unreachable) (i32.const 1) (i32.const 2) (i32.const 3))
  ))
  (export "as-call_indirect-first" (func
    (call_indirect $sig (i32.const 0) (unreachable) (i32.const 2) (i32.const 3))
  ))
  (export "as-call_indirect-mid" (func
    (call_indirect $sig (i32.const 0) (i32.const 1) (unreachable) (i32.const 3))
  ))
  (export "as-call_indirect-last" (func
    (call_indirect $sig (i32.const 0) (i32.const 1) (i32.const 2) (unreachable))
  ))

  (export "as-set_local-value" (func (local f32)
    (set_local 0 (unreachable))
  ))

  (memory 1)
  (export "as-load-address" (func (result f32)
    (f32.load (unreachable))
  ))
  (export "as-loadN-address" (func (result i64)
    (i64.load8_s (unreachable))
  ))

  (export "as-store-address" (func
    (f64.store (unreachable) (f64.const 7))
  ))
  (export "as-store-value" (func
    (i64.store (i32.const 2) (unreachable))
  ))

  (export "as-storeN-address" (func
    (i32.store8 (unreachable) (i32.const 7))
  ))
  (export "as-storeN-value" (func
    (i64.store16 (i32.const 2) (unreachable))
  ))

  (export "as-unary-operand" (func (result f32)
    (f32.neg (unreachable))
  ))

  (export "as-binary-left" (func (result i32)
    (i32.add (unreachable) (i32.const 10))
  ))
  (export "as-binary-right" (func (result i64)
    (i64.sub (i64.const 10) (unreachable))
  ))

  (export "as-test-operand" (func (result i32)
    (i32.eqz (unreachable))
  ))

  (export "as-compare-left" (func (result i32)
    (f64.le (unreachable) (f64.const 10))
  ))
  (export "as-compare-right" (func (result i32)
    (f32.ne (f32.const 10) (unreachable))
  ))

  (export "as-convert-operand" (func (result i32)
    (i32.wrap/i64 (unreachable))
  ))

  (export "as-grow_memory-size" (func (result i32)
    (grow_memory (unreachable))
  ))
)

(assert_trap (invoke "type-i32") "unreachable")
(assert_trap (invoke "type-i64") "unreachable")
(assert_trap (invoke "type-f32") "unreachable")
(assert_trap (invoke "type-f64") "unreachable")

(assert_trap (invoke "as-func-first") "unreachable")
(assert_trap (invoke "as-func-mid") "unreachable")
(assert_trap (invoke "as-func-last") "unreachable")
(assert_trap (invoke "as-func-value") "unreachable")

(assert_trap (invoke "as-block-first") "unreachable")
(assert_trap (invoke "as-block-mid") "unreachable")
(assert_trap (invoke "as-block-last") "unreachable")
(assert_trap (invoke "as-block-value") "unreachable")
(assert_return (invoke "as-block-broke") (i32.const 1))

(assert_trap (invoke "as-loop-first") "unreachable")
(assert_trap (invoke "as-loop-mid") "unreachable")
(assert_trap (invoke "as-loop-last") "unreachable")
(assert_return (invoke "as-loop-broke") (i32.const 1))

(assert_trap (invoke "as-br-value") "unreachable")

(assert_trap (invoke "as-br_if-cond") "unreachable")
(assert_trap (invoke "as-br_if-value") "unreachable")
(assert_trap (invoke "as-br_if-value-cond") "unreachable")

(assert_trap (invoke "as-br_table-index") "unreachable")
(assert_trap (invoke "as-br_table-value") "unreachable")
(assert_trap (invoke "as-br_table-value-index") "unreachable")

(assert_trap (invoke "as-return-value") "unreachable")

(assert_trap (invoke "as-if-cond") "unreachable")
(assert_trap (invoke "as-if-then" (i32.const 1) (i32.const 6)) "unreachable")
(assert_return (invoke "as-if-then" (i32.const 0) (i32.const 6)) (i32.const 6))
(assert_trap (invoke "as-if-else" (i32.const 0) (i32.const 6)) "unreachable")
(assert_return (invoke "as-if-else" (i32.const 1) (i32.const 6)) (i32.const 6))

(assert_trap (invoke "as-select-first" (i32.const 0) (i32.const 6)) "unreachable")
(assert_trap (invoke "as-select-first" (i32.const 1) (i32.const 6)) "unreachable")
(assert_trap (invoke "as-select-second" (i32.const 0) (i32.const 6)) "unreachable")
(assert_trap (invoke "as-select-second" (i32.const 1) (i32.const 6)) "unreachable")
(assert_trap (invoke "as-select-cond") "unreachable")

(assert_trap (invoke "as-call-first") "unreachable")
(assert_trap (invoke "as-call-mid") "unreachable")
(assert_trap (invoke "as-call-last") "unreachable")

(assert_trap (invoke "as-call_indirect-func") "unreachable")
(assert_trap (invoke "as-call_indirect-first") "unreachable")
(assert_trap (invoke "as-call_indirect-mid") "unreachable")
(assert_trap (invoke "as-call_indirect-last") "unreachable")

(assert_trap (invoke "as-set_local-value") "unreachable")

(assert_trap (invoke "as-load-address") "unreachable")
(assert_trap (invoke "as-loadN-address") "unreachable")

(assert_trap (invoke "as-store-address") "unreachable")
(assert_trap (invoke "as-store-value") "unreachable")
(assert_trap (invoke "as-storeN-address") "unreachable")
(assert_trap (invoke "as-storeN-value") "unreachable")

(assert_trap (invoke "as-unary-operand") "unreachable")

(assert_trap (invoke "as-binary-left") "unreachable")
(assert_trap (invoke "as-binary-right") "unreachable")

(assert_trap (invoke "as-test-operand") "unreachable")

(assert_trap (invoke "as-compare-left") "unreachable")
(assert_trap (invoke "as-compare-right") "unreachable")

(assert_trap (invoke "as-convert-operand") "unreachable")

(assert_trap (invoke "as-grow_memory-size") "unreachable")


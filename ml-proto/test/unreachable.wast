;; Test `unreachable` operator

(module
  ;; Auxiliary definitions
  (func $dummy)
  (func $dummy3 (param i32 i32 i32))

  (func "type-i32" (result i32) (unreachable))
  (func "type-i64" (result i32) (unreachable))
  (func "type-f32" (result f64) (unreachable))
  (func "type-f64" (result f64) (unreachable))

  (func "as-func-first" (result i32)
    (unreachable) (i32.const -1)
  )
  (func "as-func-mid" (result i32)
    (call $dummy) (unreachable) (i32.const -1)
  )
  (func "as-func-last"
    (call $dummy) (unreachable)
  )
  (func "as-func-value" (result i32)
    (call $dummy) (unreachable)
  )

  (func "as-block-first" (result i32)
    (block (unreachable) (i32.const 2))
  )
  (func "as-block-mid" (result i32)
    (block (call $dummy) (unreachable) (i32.const 2))
  )
  (func "as-block-last"
    (block (nop) (call $dummy) (unreachable))
  )
  (func "as-block-value" (result i32)
    (block (nop) (call $dummy) (unreachable))
  )
  (func "as-block-broke" (result i32)
    (block (call $dummy) (br 0 (i32.const 1)) (unreachable))
  )

  (func "as-loop-first" (result i32)
    (loop (unreachable) (i32.const 2))
  )
  (func "as-loop-mid" (result i32)
    (loop (call $dummy) (unreachable) (i32.const 2))
  )
  (func "as-loop-last"
    (loop (nop) (call $dummy) (unreachable))
  )
  (func "as-loop-broke" (result i32)
    (loop (call $dummy) (br 1 (i32.const 1)) (unreachable))
  )

  (func "as-br-value" (result i32)
    (block (br 0 (unreachable)))
  )

  (func "as-br_if-cond"
    (block (br_if 0 (unreachable)))
  )
  (func "as-br_if-value" (result i32)
    (block (br_if 0 (unreachable) (i32.const 1)) (i32.const 7))
  )
  (func "as-br_if-value-cond" (result i32)
    (block (br_if 0 (i32.const 6) (unreachable)) (i32.const 7))
  )

  (func "as-br_table-index"
    (block (br_table 0 0 0 (unreachable)))
  )
  (func "as-br_table-value" (result i32)
    (block (br_table 0 0 0 (unreachable) (i32.const 1)) (i32.const 7))
  )
  (func "as-br_table-value-index" (result i32)
    (block (br_table 0 0 (i32.const 6) (unreachable)) (i32.const 7))
  )

  (func "as-return-value" (result i64)
    (return (unreachable))
  )

  (func "as-if-cond" (result i32)
    (if (unreachable) (i32.const 0) (i32.const 1))
  )
  (func "as-if-then" (param i32 i32) (result i32)
    (if (get_local 0) (unreachable) (get_local 1))
  )
  (func "as-if-else" (param i32 i32) (result i32)
    (if (get_local 0) (get_local 1) (unreachable))
  )

  (func "as-select-first" (param i32 i32) (result i32)
    (select (unreachable) (get_local 0) (get_local 1))
  )
  (func "as-select-second" (param i32 i32) (result i32)
    (select (get_local 0) (unreachable) (get_local 1))
  )
  (func "as-select-cond" (result i32)
    (select (i32.const 0) (i32.const 1) (unreachable))
  )

  (func "as-call-first"
    (call $dummy3 (unreachable) (i32.const 2) (i32.const 3))
  )
  (func "as-call-mid"
    (call $dummy3 (i32.const 1) (unreachable) (i32.const 3))
  )
  (func "as-call-last"
    (call $dummy3 (i32.const 1) (i32.const 2) (unreachable))
  )

  (import "spectest" "print" (param i32 i32 i32))
  (func "as-call_import-first"
    (call_import 0 (unreachable) (i32.const 2) (i32.const 3))
  )
  (func "as-call_import-mid"
    (call_import 0 (i32.const 1) (unreachable) (i32.const 3))
  )
  (func "as-call_import-last"
    (call_import 0 (i32.const 1) (i32.const 2) (unreachable))
  )

  (type $sig (func (param i32 i32 i32)))
  (table $dummy3)
  (func "as-call_indirect-func"
    (call_indirect $sig (unreachable) (i32.const 1) (i32.const 2) (i32.const 3))
  )
  (func "as-call_indirect-first"
    (call_indirect $sig (i32.const 0) (unreachable) (i32.const 2) (i32.const 3))
  )
  (func "as-call_indirect-mid"
    (call_indirect $sig (i32.const 0) (i32.const 1) (unreachable) (i32.const 3))
  )
  (func "as-call_indirect-last"
    (call_indirect $sig (i32.const 0) (i32.const 1) (i32.const 2) (unreachable))
  )

  (func "as-set_local-value" (local f32)
    (set_local 0 (unreachable))
  )

  (memory 1)
  (func "as-load-address" (result f32)
    (f32.load (unreachable))
  )
  (func "as-loadN-address" (result i64)
    (i64.load8_s (unreachable))
  )

  (func "as-store-address"
    (f64.store (unreachable) (f64.const 7))
  )
  (func "as-store-value"
    (i64.store (i32.const 2) (unreachable))
  )

  (func "as-storeN-address"
    (i32.store8 (unreachable) (i32.const 7))
  )
  (func "as-storeN-value"
    (i64.store16 (i32.const 2) (unreachable))
  )

  (func "as-unary-operand" (result f32)
    (f32.neg (unreachable))
  )

  (func "as-binary-left" (result i32)
    (i32.add (unreachable) (i32.const 10))
  )
  (func "as-binary-right" (result i64)
    (i64.sub (i64.const 10) (unreachable))
  )

  (func "as-test-operand" (result i32)
    (i32.eqz (unreachable))
  )

  (func "as-compare-left" (result i32)
    (f64.le (unreachable) (f64.const 10))
  )
  (func "as-compare-right" (result i32)
    (f32.ne (f32.const 10) (unreachable))
  )

  (func "as-convert-operand" (result i32)
    (i32.wrap/i64 (unreachable))
  )

  (func "as-grow_memory-size" (result i32)
    (grow_memory (unreachable))
  )
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

(assert_trap (invoke "as-call_import-first") "unreachable")
(assert_trap (invoke "as-call_import-mid") "unreachable")
(assert_trap (invoke "as-call_import-last") "unreachable")

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


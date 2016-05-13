;; Test `unreachable` operator

(module
  (func "type-i32" (result i32) (unreachable))
  (func "type-i64" (result i32) (unreachable))
  (func "type-f32" (result f64) (unreachable))
  (func "type-f64" (result f64) (unreachable))

  (func "block-first" (result i32)
    (block (unreachable) (i32.const 2))
  )
  (func "block-mid" (result i32)
    (block (i32.const 1) (unreachable) (i32.const 2))
  )
  (func "block-last"
    (block (nop) (i32.const 1) (unreachable))
  )
  (func "block-value" (result i32)
    (block (nop) (i32.const 1) (unreachable))
  )
  (func "block-broke" (result i32)
    (block (br 0 (i32.const 1)) (unreachable))
  )

  (func "loop-first" (result i32)
    (loop (unreachable) (i32.const 2))
  )
  (func "loop-mid" (result i32)
    (loop (i32.const 1) (unreachable) (i32.const 2))
  )
  (func "loop-last"
    (loop (nop) (i32.const 1) (unreachable))
  )
  (func "loop-broke" (result i32)
    (loop (br 1 (i32.const 1)) (unreachable))
  )

  (func "br-value" (result i32)
    (block (br 0 (unreachable)))
  )
  (func "br_if-cond"
    (block (br_if 0 (unreachable)))
  )
  (func "br_if-value" (result i32)
    (block (br_if 0 (unreachable) (i32.const 1)) (i32.const 7))
  )
  (func "br_if-value-cond" (result i32)
    (block (br_if 0 (i32.const 6) (unreachable)) (i32.const 7))
  )
  (func "br_table-index"
    (block (br_table 0 0 0 (unreachable)))
  )
  (func "br_table-value" (result i32)
    (block (br_table 0 0 0 (unreachable) (i32.const 1)) (i32.const 7))
  )
  (func "br_table-value-index" (result i32)
    (block (br_table 0 0 (i32.const 6) (unreachable)) (i32.const 7))
  )

  (func "return-value" (result i64)
    (return (unreachable))
  )

  (func "if-cond" (result i32)
    (if (unreachable) (i32.const 0) (i32.const 1))
  )
  (func "if-then" (param i32 i32) (result i32)
    (if (get_local 0) (unreachable) (get_local 1))
  )
  (func "if-else" (param i32 i32) (result i32)
    (if (get_local 0) (get_local 1) (unreachable))
  )

  (func "select-first" (param i32 i32) (result i32)
    (select (unreachable) (get_local 0) (get_local 1))
  )
  (func "select-second" (param i32 i32) (result i32)
    (select (get_local 0) (unreachable) (get_local 1))
  )
  (func "select-cond" (result i32)
    (select (i32.const 0) (i32.const 1) (unreachable))
  )

  (func $nop (param i32 i32 i32))
  (func "call-first"
    (call $nop (unreachable) (i32.const 2) (i32.const 3))
  )
  (func "call-mid"
    (call $nop (i32.const 1) (unreachable) (i32.const 3))
  )
  (func "call-last"
    (call $nop (i32.const 1) (i32.const 2) (unreachable))
  )

  (import "spectest" "print" (param i32 i32 i32))
  (func "call_import-first"
    (call_import 0 (unreachable) (i32.const 2) (i32.const 3))
  )
  (func "call_import-mid"
    (call_import 0 (i32.const 1) (unreachable) (i32.const 3))
  )
  (func "call_import-last"
    (call_import 0 (i32.const 1) (i32.const 2) (unreachable))
  )

  (type $sig (func (param i32 i32 i32)))
  (table $nop)
  (func "call_indirect-func"
    (call_indirect $sig (unreachable) (i32.const 1) (i32.const 2) (i32.const 3))
  )
  (func "call_indirect-first"
    (call_indirect $sig (i32.const 0) (unreachable) (i32.const 2) (i32.const 3))
  )
  (func "call_indirect-mid"
    (call_indirect $sig (i32.const 0) (i32.const 1) (unreachable) (i32.const 3))
  )
  (func "call_indirect-last"
    (call_indirect $sig (i32.const 0) (i32.const 1) (i32.const 2) (unreachable))
  )

  (func "set_local-value" (local f32)
    (set_local 0 (unreachable))
  )

  (memory 1)
  (func "load-address" (result f32)
    (f32.load (unreachable))
  )
  (func "loadN-address" (result i64)
    (i64.load8_s (unreachable))
  )

  (func "store-address"
    (f64.store (unreachable) (f64.const 7))
  )
  (func "store-value"
    (i64.store (i32.const 2) (unreachable))
  )

  (func "storeN-address"
    (i32.store8 (unreachable) (i32.const 7))
  )
  (func "storeN-value"
    (i64.store16 (i32.const 2) (unreachable))
  )

  (func "unary-operand" (result f32)
    (f32.neg (unreachable))
  )

  (func "binary-left" (result i32)
    (i32.add (unreachable) (i32.const 10))
  )
  (func "binary-right" (result i64)
    (i64.sub (i64.const 10) (unreachable))
  )

  (func "test-operand" (result i32)
    (i32.eqz (unreachable))
  )

  (func "compare-left" (result i32)
    (f64.le (unreachable) (f64.const 10))
  )
  (func "compare-right" (result i32)
    (f32.ne (f32.const 10) (unreachable))
  )

  (func "convert-operand" (result i32)
    (i32.wrap/i64 (unreachable))
  )

  (func "grow_memory-size" (result i32)
    (grow_memory (unreachable))
  )
)

(assert_trap (invoke "type-i32") "unreachable")
(assert_trap (invoke "type-i64") "unreachable")
(assert_trap (invoke "type-f32") "unreachable")
(assert_trap (invoke "type-f64") "unreachable")

(assert_trap (invoke "block-first") "unreachable")
(assert_trap (invoke "block-mid") "unreachable")
(assert_trap (invoke "block-last") "unreachable")
(assert_trap (invoke "block-value") "unreachable")
(assert_return (invoke "block-broke") (i32.const 1))

(assert_trap (invoke "loop-first") "unreachable")
(assert_trap (invoke "loop-mid") "unreachable")
(assert_trap (invoke "loop-last") "unreachable")
(assert_return (invoke "loop-broke") (i32.const 1))

(assert_trap (invoke "br-value") "unreachable")

(assert_trap (invoke "br_if-cond") "unreachable")
(assert_trap (invoke "br_if-value") "unreachable")
(assert_trap (invoke "br_if-value-cond") "unreachable")

(assert_trap (invoke "br_table-index") "unreachable")
(assert_trap (invoke "br_table-value") "unreachable")
(assert_trap (invoke "br_table-value-index") "unreachable")

(assert_trap (invoke "if-cond") "unreachable")
(assert_trap (invoke "if-then" (i32.const 1) (i32.const 6)) "unreachable")
(assert_return (invoke "if-then" (i32.const 0) (i32.const 6)) (i32.const 6))
(assert_trap (invoke "if-else" (i32.const 0) (i32.const 6)) "unreachable")
(assert_return (invoke "if-else" (i32.const 1) (i32.const 6)) (i32.const 6))

(assert_trap (invoke "select-first" (i32.const 0) (i32.const 6)) "unreachable")
(assert_trap (invoke "select-first" (i32.const 1) (i32.const 6)) "unreachable")
(assert_trap (invoke "select-second" (i32.const 0) (i32.const 6)) "unreachable")
(assert_trap (invoke "select-second" (i32.const 1) (i32.const 6)) "unreachable")
(assert_trap (invoke "select-cond") "unreachable")

(assert_trap (invoke "return-value") "unreachable")

(assert_trap (invoke "call-first") "unreachable")
(assert_trap (invoke "call-mid") "unreachable")
(assert_trap (invoke "call-last") "unreachable")

(assert_trap (invoke "call_import-first") "unreachable")
(assert_trap (invoke "call_import-mid") "unreachable")
(assert_trap (invoke "call_import-last") "unreachable")

(assert_trap (invoke "call_indirect-func") "unreachable")
(assert_trap (invoke "call_indirect-first") "unreachable")
(assert_trap (invoke "call_indirect-mid") "unreachable")
(assert_trap (invoke "call_indirect-last") "unreachable")

(assert_trap (invoke "set_local-value") "unreachable")

(assert_trap (invoke "load-address") "unreachable")
(assert_trap (invoke "loadN-address") "unreachable")

(assert_trap (invoke "store-address") "unreachable")
(assert_trap (invoke "store-value") "unreachable")
(assert_trap (invoke "storeN-address") "unreachable")
(assert_trap (invoke "storeN-value") "unreachable")

(assert_trap (invoke "unary-operand") "unreachable")

(assert_trap (invoke "binary-left") "unreachable")
(assert_trap (invoke "binary-right") "unreachable")

(assert_trap (invoke "test-operand") "unreachable")

(assert_trap (invoke "compare-left") "unreachable")
(assert_trap (invoke "compare-right") "unreachable")

(assert_trap (invoke "convert-operand") "unreachable")

(assert_trap (invoke "grow_memory-size") "unreachable")


;; Test `return` operator

(module
  (func "type-i32" (i32.ctz (return)))
  (func "type-i64" (i64.ctz (return)))
  (func "type-f32" (f32.neg (return)))
  (func "type-f64" (f64.neg (return)))

  (func "nullary" (return))
  (func "unary" (result f64) (return (f64.const 3.1)))

  (func "first" (result i32)
    (return (i32.const 1)) (i32.const 2)
  )
  (func "mid" (result i32)
    (i32.const 1) (return (i32.const 2)) (i32.const 3)
  )
  (func "last"
    (nop) (i32.const 1) (return)
  )
  (func "value" (result i32)
    (nop) (i32.const 1) (return (i32.const 3))
  )

  (func "block-first"
    (block (return) (i32.const 2))
  )
  (func "block-mid"
    (block (i32.const 1) (return) (i32.const 2))
  )
  (func "block-last"
    (block (nop) (i32.const 1) (return))
  )
  (func "block-value" (result i32)
    (block (nop) (i32.const 1) (return (i32.const 2)))
  )

  (func "loop-first" (result i32)
    (loop (return (i32.const 3)) (i32.const 2))
  )
  (func "loop-mid" (result i32)
    (loop (i32.const 1) (return (i32.const 4)) (i32.const 2))
  )
  (func "loop-last" (result i32)
    (loop (nop) (i32.const 1) (return (i32.const 5)))
  )

  (func "br-value" (result i32)
    (block (br 0 (return (i32.const 9))))
  )

  (func "br_if-cond"
    (block (br_if 0 (return)))
  )
  (func "br_if-value" (result i32)
    (block (br_if 0 (return (i32.const 8)) (i32.const 1)) (i32.const 7))
  )
  (func "br_if-value-cond" (result i32)
    (block (br_if 0 (i32.const 6) (return (i32.const 9))) (i32.const 7))
  )

  (func "br_table-index" (result i64)
    (block (br_table 0 0 0 (return (i64.const 9)))) (i64.const -1)
  )
  (func "br_table-value" (result i32)
    (block (br_table 0 0 0 (return (i32.const 10)) (i32.const 1)) (i32.const 7))
  )
  (func "br_table-value-index" (result i32)
    (block (br_table 0 0 (i32.const 6) (return (i32.const 11))) (i32.const 7))
  )

  (func "return-value" (result i64)
    (return (return (i64.const 7)))
  )

  (func "if-cond" (result i32)
    (if (return (i32.const 2)) (i32.const 0) (i32.const 1))
  )
  (func "if-then" (param i32 i32) (result i32)
    (if (get_local 0) (return (i32.const 3)) (get_local 1))
  )
  (func "if-else" (param i32 i32) (result i32)
    (if (get_local 0) (get_local 1) (return (i32.const 4)))
  )

  (func "select-first" (param i32 i32) (result i32)
    (select (return (i32.const 5)) (get_local 0) (get_local 1))
  )
  (func "select-second" (param i32 i32) (result i32)
    (select (get_local 0) (return (i32.const 6)) (get_local 1))
  )
  (func "select-cond" (result i32)
    (select (i32.const 0) (i32.const 1) (return (i32.const 7)))
  )

  (func $f (param i32 i32 i32) (result i32) (i32.const -1))
  (func "call-first" (result i32)
    (call $f (return (i32.const 12)) (i32.const 2) (i32.const 3))
  )
  (func "call-mid" (result i32)
    (call $f (i32.const 1) (return (i32.const 13)) (i32.const 3))
  )
  (func "call-last" (result i32)
    (call $f (i32.const 1) (i32.const 2) (return (i32.const 14)))
  )

  (import "spectest" "print" (param i32 i32 i32))
  (func "call_import-first"
    (call_import 0 (return) (i32.const 2) (i32.const 3))
  )
  (func "call_import-mid"
    (call_import 0 (i32.const 1) (return) (i32.const 3))
  )
  (func "call_import-last"
    (call_import 0 (i32.const 1) (i32.const 2) (return))
  )

  (type $sig (func (param i32 i32 i32) (result i32)))
  (table $f)
  (func "call_indirect-func" (result i32)
    (call_indirect $sig (return (i32.const 20)) (i32.const 1) (i32.const 2) (i32.const 3))
  )
  (func "call_indirect-first" (result i32)
    (call_indirect $sig (i32.const 0) (return (i32.const 21)) (i32.const 2) (i32.const 3))
  )
  (func "call_indirect-mid" (result i32)
    (call_indirect $sig (i32.const 0) (i32.const 1) (return (i32.const 22)) (i32.const 3))
  )
  (func "call_indirect-last" (result i32)
    (call_indirect $sig (i32.const 0) (i32.const 1) (i32.const 2) (return (i32.const 23)))
  )

  (func "set_local-value" (result i32) (local f32)
    (set_local 0 (return (i32.const 17))) (i32.const -1)
  )

  (memory 1)
  (func "load-address" (result f32)
    (f32.load (return (f32.const 1.7)))
  )
  (func "loadN-address" (result i64)
    (i64.load8_s (return (i64.const 30)))
  )

  (func "store-address" (result i32)
    (f64.store (return (i32.const 30)) (f64.const 7)) (i32.const -1)
  )
  (func "store-value" (result i32)
    (i64.store (i32.const 2) (return (i32.const 31))) (i32.const -1)
  )

  (func "storeN-address" (result i32)
    (i32.store8 (return (i32.const 32)) (i32.const 7)) (i32.const -1)
  )
  (func "storeN-value" (result i32)
    (i64.store16 (i32.const 2) (return (i32.const 33))) (i32.const -1)
  )

  (func "unary-operand" (result f32)
    (f32.neg (return (f32.const 3.4)))
  )

  (func "binary-left" (result i32)
    (i32.add (return (i32.const 3)) (i32.const 10))
  )
  (func "binary-right" (result i64)
    (i64.sub (i64.const 10) (return (i64.const 45)))
  )

  (func "test-operand" (result i32)
    (i32.eqz (return (i32.const 44)))
  )

  (func "compare-left" (result i32)
    (f64.le (return (i32.const 43)) (f64.const 10))
  )
  (func "compare-right" (result i32)
    (f32.ne (f32.const 10) (return (i32.const 42)))
  )

  (func "convert-operand" (result i32)
    (i32.wrap/i64 (return (i32.const 41)))
  )

  (func "grow_memory-size" (result i32)
    (grow_memory (return (i32.const 40)))
  )
)

(assert_return (invoke "type-i32"))
(assert_return (invoke "type-i64"))
(assert_return (invoke "type-f32"))
(assert_return (invoke "type-f64"))

(assert_return (invoke "nullary"))
(assert_return (invoke "unary") (f64.const 3.1))

(assert_invalid
  (module (func (result f64) (return)))
  "type mismatch"
)

(assert_invalid
  (module (func (result f64) (return (i64.const 1))))
  "type mismatch"
)

(assert_invalid
  (module (func (result f64) (return (f32.const 1))))
  "type mismatch"
)

(assert_return (invoke "first") (i32.const 1))
(assert_return (invoke "mid") (i32.const 2))
(assert_return (invoke "last"))
(assert_return (invoke "value") (i32.const 3))

(assert_return (invoke "block-first"))
(assert_return (invoke "block-mid"))
(assert_return (invoke "block-last"))
(assert_return (invoke "block-value") (i32.const 2))

(assert_return (invoke "loop-first") (i32.const 3))
(assert_return (invoke "loop-mid") (i32.const 4))
(assert_return (invoke "loop-last") (i32.const 5))

(assert_return (invoke "br-value") (i32.const 9))

(assert_return (invoke "br_if-cond"))
(assert_return (invoke "br_if-value") (i32.const 8))
(assert_return (invoke "br_if-value-cond") (i32.const 9))

(assert_return (invoke "br_table-index") (i64.const 9))
(assert_return (invoke "br_table-value") (i32.const 10))
(assert_return (invoke "br_table-value-index") (i32.const 11))

(assert_return (invoke "return-value") (i64.const 7))

(assert_return (invoke "if-cond") (i32.const 2))
(assert_return (invoke "if-then" (i32.const 1) (i32.const 6)) (i32.const 3))
(assert_return (invoke "if-then" (i32.const 0) (i32.const 6)) (i32.const 6))
(assert_return (invoke "if-else" (i32.const 0) (i32.const 6)) (i32.const 4))
(assert_return (invoke "if-else" (i32.const 1) (i32.const 6)) (i32.const 6))

(assert_return (invoke "select-first" (i32.const 0) (i32.const 6)) (i32.const 5))
(assert_return (invoke "select-first" (i32.const 1) (i32.const 6)) (i32.const 5))
(assert_return (invoke "select-second" (i32.const 0) (i32.const 6)) (i32.const 6))
(assert_return (invoke "select-second" (i32.const 1) (i32.const 6)) (i32.const 6))
(assert_return (invoke "select-cond") (i32.const 7))

(assert_return (invoke "call-first") (i32.const 12))
(assert_return (invoke "call-mid") (i32.const 13))
(assert_return (invoke "call-last") (i32.const 14))

(assert_return (invoke "call_import-first"))
(assert_return (invoke "call_import-mid"))
(assert_return (invoke "call_import-last"))

(assert_return (invoke "call_indirect-func") (i32.const 20))
(assert_return (invoke "call_indirect-first") (i32.const 21))
(assert_return (invoke "call_indirect-mid") (i32.const 22))
(assert_return (invoke "call_indirect-last") (i32.const 23))

(assert_return (invoke "set_local-value") (i32.const 17))

(assert_return (invoke "load-address") (f32.const 1.7))
(assert_return (invoke "loadN-address") (i64.const 30))

(assert_return (invoke "store-address") (i32.const 30))
(assert_return (invoke "store-value") (i32.const 31))
(assert_return (invoke "storeN-address") (i32.const 32))
(assert_return (invoke "storeN-value") (i32.const 33))

(assert_return (invoke "unary-operand") (f32.const 3.4))

(assert_return (invoke "binary-left") (i32.const 3))
(assert_return (invoke "binary-right") (i64.const 45))

(assert_return (invoke "test-operand") (i32.const 44))

(assert_return (invoke "compare-left") (i32.const 43))
(assert_return (invoke "compare-right") (i32.const 42))

(assert_return (invoke "convert-operand") (i32.const 41))

(assert_return (invoke "grow_memory-size") (i32.const 40))


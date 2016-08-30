;; Functions

(module
  (import "spectest" "print" (func (param i32)))
  (func (import "spectest" "print") (param i64))

  (import $print_i32 "spectest" "print" (func (param i32)))
  (import $print_i64 "spectest" "print" (func (param i64)))
  (import $print_i32_f32 "spectest" "print" (func (param i32 f32)))
  (import $print_i64_f64 "spectest" "print" (func (param i64 f64)))

  (func $print_i32-2 (import "spectest" "print") (param i32))
  (func $print_i64-2 (import "spectest" "print") (param i64))

  (func (export "print32") (param $i i32)
    (call 0 (get_local $i))
    (call $print_i32_f32
      (i32.add (get_local $i) (i32.const 1))
      (f32.const 42)
    )
    (call $print_i32 (get_local $i))
    (call $print_i32-2 (get_local $i))
  )

  (func (export "print64") (param $i i64)
    (call 1 (get_local $i))
    (call $print_i64_f64
      (i64.add (get_local $i) (i64.const 1))
      (f64.const 53)
    )
    (call $print_i64 (get_local $i))
    (call $print_i64-2 (get_local $i))
  )
)

(assert_return (invoke "print32" (i32.const 13)))
(assert_return (invoke "print64" (i64.const 24)))

(assert_unlinkable
  (module (import "spectest" "unknown" (func)))
  "unknown import"
)
(assert_unlinkable
  (module (import "spectest" "table" (func)))
  "type mismatch"
)
(assert_unlinkable
  (module (import "spectest" "func" (func (param i32))))
  "type mismatch"
)
(assert_unlinkable
  (module (import "spectest" "func" (func (result i32))))
  "type mismatch"
)


;; Globals

(module
  (import "spectest" "global" (global i32))
  (global (import "spectest" "global") i32)

  (import $x "spectest" "global" (global i32))
  (global $y (import "spectest" "global") i32)

  (func (export "get-0") (result i32) (get_global 0))
  (func (export "get-1") (result i32) (get_global 1))
  (func (export "get-x") (result i32) (get_global $x))
  (func (export "get-y") (result i32) (get_global $y))

  ;; TODO: mutable globals
  ;; (func (export "set-0") (param i32) (set_global 0 (get_local 0)))
  ;; (func (export "set-1") (param i32) (set_global 1 (get_local 0)))
  ;; (func (export "set-x") (param i32) (set_global $x (get_local 0)))
  ;; (func (export "set-y") (param i32) (set_global $y (get_local 0)))
)

(assert_return (invoke "get-0") (i32.const 666))
(assert_return (invoke "get-1") (i32.const 666))
(assert_return (invoke "get-x") (i32.const 666))
(assert_return (invoke "get-y") (i32.const 666))

(assert_unlinkable
  (module (import "spectest" "unknown" (global i32)))
  "unknown import"
)
(assert_unlinkable
  (module (import "spectest" "func" (global i32)))
  "type mismatch"
)

(module (import "spectest" "global" (global i64)))
(module (import "spectest" "global" (global f32)))
(module (import "spectest" "global" (global f64)))


;; Tables

(module
  (type (func (result i32)))
  (import "spectest" "table" (table 10 20 anyfunc))
  (elem 0 (i32.const 1) $f $g)

  (func (export "call") (param i32) (result i32) (call_indirect 0 (get_local 0)))
  (func $f (result i32) (i32.const 11))
  (func $g (result i32) (i32.const 22))
)

(assert_trap (invoke "call" (i32.const 0)) "uninitialized element")
(assert_return (invoke "call" (i32.const 1)) (i32.const 11))
(assert_return (invoke "call" (i32.const 2)) (i32.const 22))
(assert_trap (invoke "call" (i32.const 3)) "uninitialized element")
(assert_trap (invoke "call" (i32.const 100)) "undefined element")


(module
  (type (func (result i32)))
  (table (import "spectest" "table") 10 20 anyfunc)
  (elem 0 (i32.const 1) $f $g)

  (func (export "call") (param i32) (result i32) (call_indirect 0 (get_local 0)))
  (func $f (result i32) (i32.const 11))
  (func $g (result i32) (i32.const 22))
)

(assert_trap (invoke "call" (i32.const 0)) "uninitialized element")
(assert_return (invoke "call" (i32.const 1)) (i32.const 11))
(assert_return (invoke "call" (i32.const 2)) (i32.const 22))
(assert_trap (invoke "call" (i32.const 3)) "uninitialized element")
(assert_trap (invoke "call" (i32.const 100)) "undefined element")


(assert_unlinkable
  (module (import "spectest" "unknown" (table 10 anyfunc)))
  "unknown import"
)
(assert_unlinkable
  (module (import "spectest" "func" (table 10 anyfunc)))
  "type mismatch"
)
(assert_unlinkable
  (module (import "spectest" "table" (table 12 anyfunc)))
  "actual size smaller than declared"
)
(assert_unlinkable
  (module (import "spectest" "table" (table 10 15 anyfunc)))
  "maximum size larger than declared"
)


;; Memories

(module
  (import "spectest" "memory" (memory 1 2))
  (data 0 (i32.const 10) "\10")

  (func (export "load") (param i32) (result i32) (i32.load (get_local 0)))
)

(assert_return (invoke "load" (i32.const 0)) (i32.const 0))
(assert_return (invoke "load" (i32.const 10)) (i32.const 16))
(assert_return (invoke "load" (i32.const 8)) (i32.const 0x100000))
(assert_trap (invoke "load" (i32.const 1000000)) "out of bounds memory access")

(module
  (memory (import "spectest" "memory") 1 2)
  (data 0 (i32.const 10) "\10")

  (func (export "load") (param i32) (result i32) (i32.load (get_local 0)))
)

(assert_return (invoke "load" (i32.const 0)) (i32.const 0))
(assert_return (invoke "load" (i32.const 10)) (i32.const 16))
(assert_return (invoke "load" (i32.const 8)) (i32.const 0x100000))
(assert_trap (invoke "load" (i32.const 1000000)) "out of bounds memory access")


(assert_unlinkable
  (module (import "spectest" "unknown" (memory 1)))
  "unknown import"
)
(assert_unlinkable
  (module (import "spectest" "func" (memory 1)))
  "type mismatch"
)
(assert_unlinkable
  (module (import "spectest" "memory" (memory 2)))
  "actual size smaller than declared"
)
(assert_unlinkable
  (module (import "spectest" "memory" (memory 1 1)))
  "maximum size larger than declared"
)

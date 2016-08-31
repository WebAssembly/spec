;; Functions

(module
  (import "spectest" "print" (func (param i32)))
  (import "spectest" "print" (func (param i64)))
  (import "spectest" "print" (func $print_i32 (param i32)))
  (import "spectest" "print" (func $print_i64 (param i64)))
  (import "spectest" "print" (func $print_i32_f32 (param i32 f32)))
  (import "spectest" "print" (func $print_i64_f64 (param i64 f64)))

  (export "print32" (func (param $i i32)
    (call 0 (get_local $i))
    (call $print_i32_f32
      (i32.add (get_local $i) (i32.const 1))
      (f32.const 42)
    )
    (call $print_i32 (get_local $i))
  ))

  (export "print64" (func (param $i i64)
    (call 1 (get_local $i))
    (call $print_i64_f64
      (i64.add (get_local $i) (i64.const 1))
      (f64.const 53)
    )
    (call $print_i64 (get_local $i))
  ))
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

(; TODO: check linking against other Wasm module
(assert_unlinkable
  (module (import "spectest" "func" (func (param i32))))
  "type mismatch"
)
(assert_unlinkable
  (module (import "spectest" "func" (func (result i32))))
  "type mismatch"
)
;)

(assert_unlinkable
  (module (import "spectest" "print" (func)) (table anyfunc (elem 0)))
  "invalid use of host function"
)


;; Globals

(module
  (import "spectest" "global" (global i32))
  (import "spectest" "global" (global $x i32))

  (export "get-0" (func (result i32) (get_global 0)))
  (export "get-x" (func (result i32) (get_global $x)))

  ;; TODO: mutable globals
  ;; (export "set-0" (func (param i32) (set_global 0 (get_local 0))))
  ;; (export "set-x" (func (param i32) (set_global $x (get_local 0))))
)

(assert_return (invoke "get-0") (i32.const 666))
(assert_return (invoke "get-x") (i32.const 666))

(assert_unlinkable
  (module (import "spectest" "unknown" (global i32)))
  "unknown import"
)
(assert_unlinkable
  (module (import "spectest" "print" (global i32)))
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

  (export "call" (func (param i32) (result i32) (call_indirect 0 (get_local 0))))
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
  (import "spectest" "table" (table $tab 10 20 anyfunc))
  (elem 0 (i32.const 1) $f $g)

  (export "call" (func (param i32) (result i32) (call_indirect 0 (get_local 0))))
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
  (module (import "spectest" "print" (table 10 anyfunc)))
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

  (export "load" (func (param i32) (result i32) (i32.load (get_local 0))))
)

(assert_return (invoke "load" (i32.const 0)) (i32.const 0))
(assert_return (invoke "load" (i32.const 10)) (i32.const 16))
(assert_return (invoke "load" (i32.const 8)) (i32.const 0x100000))
(assert_trap (invoke "load" (i32.const 1000000)) "out of bounds memory access")

(module
  (import "spectest" "memory" (memory $mem 1 2))
  (data 0 (i32.const 10) "\10")

  (export "load" (func (param i32) (result i32) (i32.load (get_local 0))))
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
  (module (import "spectest" "print" (memory 1)))
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

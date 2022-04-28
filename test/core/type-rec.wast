;; Static matching of recursive function types

(module
  (rec (type $f1 (func)) (type (struct)))
  (rec (type $f2 (func)) (type (struct)))
  (global (ref $f1) (ref.func $f))
  (func $f (type $f2))
)

(assert_invalid
  (module
    (rec (type $f1 (func)) (type (struct)))
    (rec (type (struct)) (type $f2 (func)))
    (global (ref $f1) (ref.func $f))
    (func $f (type $f2))
  )
  "type mismatch"
)

(assert_invalid
  (module
    (rec (type $f1 (func)) (type (struct)))
    (rec (type $f2 (func)) (type (struct)) (type (func)))
    (global (ref $f1) (ref.func $f))
    (func $f (type $f2))
  )
  "type mismatch"
)


;; Link-time matching of recursive function types

(module $M
  (rec (type $f1 (func)) (type (struct)))
  (func (export "f") (type $f1))
)
(register "M" $M)

(module
  (rec (type $f2 (func)) (type (struct)))
  (func (import "M" "f") (type $f2))
)

(assert_unlinkable
  (module
    (rec (type (struct)) (type $f2 (func)))
    (func (import "M" "f") (type $f2))
  )
  "incompatible import type"
)

(assert_unlinkable
  (module
    (rec (type $f2 (func)))
    (func (import "M" "f") (type $f2))
  )
  "incompatible import type"
)


;; Dynamic matching of recursive function types

(module
  (rec (type $f1 (func)) (type (struct)))
  (rec (type $f2 (func)) (type (struct)))
  (table funcref (elem $f1))
  (func $f1 (type $f1))
  (func (export "run") (call_indirect (type $f2) (i32.const 0)))
)
(assert_return (invoke "run"))

(module
  (rec (type $f1 (func)) (type (struct)))
  (rec (type (struct)) (type $f2 (func)))
  (table funcref (elem $f1))
  (func $f1 (type $f1))
  (func (export "run") (call_indirect (type $f2) (i32.const 0)))
)
(assert_trap (invoke "run") "indirect call type mismatch")

(module
  (rec (type $f1 (func)) (type (struct)))
  (rec (type $f2 (func)))
  (table funcref (elem $f1))
  (func $f1 (type $f1))
  (func (export "run") (call_indirect (type $f2) (i32.const 0)))
)
(assert_trap (invoke "run") "indirect call type mismatch")

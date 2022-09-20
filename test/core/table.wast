;; Test table section structure

(module (table 0 funcref))
(module (table 1 funcref))
(module (table 0 0 funcref))
(module (table 0 1 funcref))
(module (table 1 256 funcref))
(module (table 0 65536 funcref))
(module (table 0 0xffff_ffff funcref))

(module (table 1 (ref null func)))
(module (table 1 (ref null extern)))
(module (table 1 (ref null $t)) (type $t (func)))

(module (table 0 funcref) (table 0 funcref))
(module (table (import "spectest" "table") 0 funcref) (table 0 funcref))

(module (table 0 funcref (ref.null func)))
(module (table 1 funcref (ref.null func)))
(module (table 1 (ref null func) (ref.null func)))

(assert_invalid (module (elem (i32.const 0))) "unknown table")
(assert_invalid (module (elem (i32.const 0) $f) (func $f)) "unknown table")


(assert_invalid
  (module (table 1 0 funcref))
  "size minimum must not be greater than maximum"
)
(assert_invalid
  (module (table 0xffff_ffff 0 funcref))
  "size minimum must not be greater than maximum"
)

(assert_malformed
  (module quote "(table 0x1_0000_0000 funcref)")
  "i32 constant out of range"
)
(assert_malformed
  (module quote "(table 0x1_0000_0000 0x1_0000_0000 funcref)")
  "i32 constant out of range"
)
(assert_malformed
  (module quote "(table 0 0x1_0000_0000 funcref)")
  "i32 constant out of range"
)

(assert_invalid
  (module (table 1 (ref null func) (i32.const 0)))
  "type mismatch"
)
(assert_invalid
  (module (table 1 (ref func) (ref.null extern)))
  "type mismatch"
)
(assert_invalid
  (module (type $t (func)) (table 1 (ref $t) (ref.null func)))
  "type mismatch"
)
(assert_invalid
  (module (table 1 (ref func) (ref.null func)))
  "type mismatch"
)
(assert_invalid
  (module (table 0 (ref func)))
  "type mismatch"
)
(assert_invalid
  (module (table 0 (ref extern)))
  "type mismatch"
)
(assert_invalid
  (module (type $t (func)) (table 0 (ref $t)))
  "type mismatch"
)


;; Table initializer

(module
  (type $dummy (func))
  (func $dummy)

  (table $t1 10 funcref)
  (table $t2 10 funcref (ref.func $dummy))
  (table $t3 10 (ref $dummy) (ref.func $dummy))

  (func (export "get1") (result funcref) (table.get $t1 (i32.const 1)))
  (func (export "get2") (result funcref) (table.get $t2 (i32.const 4)))
  (func (export "get3") (result funcref) (table.get $t3 (i32.const 7)))
)

(assert_return (invoke "get1") (ref.null))
(assert_return (invoke "get2") (ref.func))
(assert_return (invoke "get3") (ref.func))


;; Duplicate table identifiers

(assert_malformed
  (module quote
    "(table $foo 1 funcref)"
    "(table $foo 1 funcref)"
  )
  "duplicate table"
)
(assert_malformed
  (module quote
    "(import \"\" \"\" (table $foo 1 funcref))"
    "(table $foo 1 funcref)"
  )
  "duplicate table"
)
(assert_malformed
  (module quote
    "(import \"\" \"\" (table $foo 1 funcref))"
    "(import \"\" \"\" (table $foo 1 funcref))"
  )
  "duplicate table"
)

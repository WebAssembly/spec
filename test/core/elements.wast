;; Test the element section

(module
  (table 10 anyfunc)
  (elem (i32.const 0) $f)
  (func $f)
)

(module
  (table 10 anyfunc)
  (elem (i32.const 9) $f)
  (func $f)
)

(module
  (type $out-i32 (func (result i32)))
  (table 10 anyfunc)
  (elem (i32.const 7) $const-i32-a)
  (elem (i32.const 9) $const-i32-b)
  (func $const-i32-a (type $out-i32) (i32.const 65))
  (func $const-i32-b (type $out-i32) (i32.const 66))
  (func (export "call-7") (type $out-i32)
    (call_indirect $out-i32 (i32.const 7))
  )
  (func (export "call-9") (type $out-i32)
    (call_indirect $out-i32 (i32.const 9))
  )
)

(assert_return (invoke "call-7") (i32.const 65))
(assert_return (invoke "call-9") (i32.const 66))

;; Two elements target the same slot

(module
  (type $out-i32 (func (result i32)))
  (table 10 anyfunc)
  (elem (i32.const 9) $const-i32-a)
  (elem (i32.const 9) $const-i32-b)
  (func $const-i32-a (type $out-i32) (i32.const 65))
  (func $const-i32-b (type $out-i32) (i32.const 66))
  (func (export "call-overwritten-element") (type $out-i32)
    (call_indirect $out-i32 (i32.const 9))
  )
)

(assert_return (invoke "call-overwritten-element") (i32.const 66))

;; Invalid bounds for elements

(assert_unlinkable
  (module
    (table 10 anyfunc)
    (elem (i32.const 10) $f)
    (func $f)
  )
  "elements segment does not fit"
)

(assert_unlinkable
  (module
    (table 10 20 anyfunc)
    (elem (i32.const 10) $f)
    (func $f)
  )
  "elements segment does not fit"
)

(assert_unlinkable
  (module
    (table 10 anyfunc)
    (elem (i32.const -1) $f)
    (func $f)
  )
  "elements segment does not fit"
)

(assert_unlinkable
  (module
    (table 10 anyfunc)
    (elem (i32.const -10) $f)
    (func $f)
  )
  "elements segment does not fit"
)

;; Tests with an imported table

(module
  (import "spectest" "table" (table 10 anyfunc))
  (elem (i32.const 0) $f)
  (func $f)
)

(module
  (import "spectest" "table" (table 10 anyfunc))
  (elem (i32.const 9) $f)
  (func $f)
)

;; Two elements target the same slot

(module
  (type $out-i32 (func (result i32)))
  (import "spectest" "table" (table 10 anyfunc))
  (elem (i32.const 9) $const-i32-a)
  (elem (i32.const 9) $const-i32-b)
  (func $const-i32-a (type $out-i32) (i32.const 65))
  (func $const-i32-b (type $out-i32) (i32.const 66))
  (func (export "call-overwritten-element") (type $out-i32)
    (call_indirect $out-i32 (i32.const 9))
  )
)

(assert_return (invoke "call-overwritten-element") (i32.const 66))

;; Invalid bounds for elements

(assert_unlinkable
  (module
  (import "spectest" "table" (table 10 anyfunc))
    (elem (i32.const 10) $f)
    (func $f)
  )
  "elements segment does not fit"
)

(assert_unlinkable
  (module
  (import "spectest" "table" (table 10 20 anyfunc))
    (elem (i32.const 10) $f)
    (func $f)
  )
  "elements segment does not fit"
)

(assert_unlinkable
  (module
  (import "spectest" "table" (table 10 anyfunc))
    (elem (i32.const -1) $f)
    (func $f)
  )
  "elements segment does not fit"
)

(assert_unlinkable
  (module
  (import "spectest" "table" (table 10 anyfunc))
    (elem (i32.const -10) $f)
    (func $f)
  )
  "elements segment does not fit"
)

;; Element without table

(assert_invalid
  (module
    (elem (i32.const 0) $f)
    (func $f)
  )
  "unknown table 0"
)

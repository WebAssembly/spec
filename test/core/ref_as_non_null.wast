(module
  (type $t (func (result i32)))

  (func $nn (export "nonnullable") (param $r (ref $t)) (result i32)
    (call_ref (ref.as_non_null (local.get $r)))
  )
  (func $n (export "nullable") (param $r (ref null $t)) (result i32)
    (call_ref (ref.as_non_null (local.get $r)))
  )
  (func (export "null") (param $r nullref) (result i32)
    (call_ref (ref.as_non_null (local.get $r)))
  )

  (elem func $f)
  (func $f (result i32) (i32.const 7))

  (func (export "nonnullable-f") (result i32) (call $nn (ref.func $f)))
  (func (export "nullable-f") (result i32) (call $n (ref.func $f)))

  (func (export "unreachable") (result i32)
    (unreachable)
    (ref.as_non_null)
    (call $nn)
  )
)

(assert_trap (invoke "unreachable") "unreachable")

(assert_trap (invoke "nullable" (ref.null)) "null reference")
(assert_trap (invoke "null" (ref.null)) "null reference")

(assert_return (invoke "nonnullable-f") (i32.const 7))
(assert_return (invoke "nullable-f") (i32.const 7))

(assert_invalid
  (module
    (type $t (func (result i32)))
    (func $g (param $r (ref $t)) (drop (ref.as_non_null (local.get $r))))
    (func (call $g (ref.null)))
  )
  "type mismatch"
)

(assert_invalid
  (module
    (func $g (param $r nullref) (drop (ref.as_non_null (local.get $r))))
    (elem func $f)
    (func $f (result i32) (i32.const 7))
    (func (call $g (ref.func $f)))
  )
  "type mismatch"
)

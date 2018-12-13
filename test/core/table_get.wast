(module
  (table $t2 2 anyref)
  (table $t3 3 funcref) (elem $t3 (i32.const 1) $dummy)
  (func $dummy)

  (func (export "init") (param $r anyref)
    (table.set $t2 (i32.const 1) (local.get $r))
    (table.set $t3 (i32.const 2) (table.get $t3 (i32.const 1)))
  )

  (func (export "get-anyref") (param $i i32) (result anyref)
    (table.get $t2 (local.get $i))
  )
  (func $f3 (export "get-funcref") (param $i i32) (result funcref)
    (table.get $t3 (local.get $i))
  )

  (func (export "is_null-funcref") (param $i i32) (result i32)
    (ref.is_null (call $f3 (local.get $i)))
  )
)

(invoke "init" (ref.host 1))

(assert_return (invoke "get-anyref" (i32.const 0)) (ref.null))
(assert_return (invoke "get-anyref" (i32.const 1)) (ref.host 1))

(assert_return (invoke "get-funcref" (i32.const 0)) (ref.null))
(assert_return (invoke "is_null-funcref" (i32.const 1)) (i32.const 0))
(assert_return (invoke "is_null-funcref" (i32.const 2)) (i32.const 0))

(assert_trap (invoke "get-anyref" (i32.const 2)) "out of bounds")
(assert_trap (invoke "get-funcref" (i32.const 3)) "out of bounds")
(assert_trap (invoke "get-anyref" (i32.const -1)) "out of bounds")
(assert_trap (invoke "get-funcref" (i32.const -1)) "out of bounds")

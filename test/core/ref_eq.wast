(module
  (func $eq (export "eq") (param $x eqref) (param $y eqref) (result i32)
    (ref.eq (get_local $x) (get_local $y))
  )

  (table $t 2 eqref)

  (func (export "init") (param $r eqref)
    (set_table $t (i32.const 1) (get_local $r))
  )

  (func (export "eq-elem") (param $i i32) (param $x eqref) (result i32)
    (call $eq (get_table $t (get_local $i)) (get_local $x))
  )
)

(assert_return (invoke "eq" (ref.null) (ref.null)) (i32.const 1))
(assert_return (invoke "eq" (ref.host 1) (ref.host 1)) (i32.const 1))

(assert_return (invoke "eq" (ref.null) (ref.host 0)) (i32.const 0))
(assert_return (invoke "eq" (ref.host 0) (ref.null)) (i32.const 0))
(assert_return (invoke "eq" (ref.host 1) (ref.host 2)) (i32.const 0))

(invoke "init" (ref.host 0))

(assert_return (invoke "eq-elem" (i32.const 0) (ref.null)) (i32.const 1))
(assert_return (invoke "eq-elem" (i32.const 1) (ref.host 0)) (i32.const 1))

(assert_return (invoke "eq-elem" (i32.const 0) (ref.host 0)) (i32.const 0))
(assert_return (invoke "eq-elem" (i32.const 1) (ref.null)) (i32.const 0))
(assert_return (invoke "eq-elem" (i32.const 1) (ref.host 1)) (i32.const 0))


(assert_invalid
  (module
    (func (param $x anyref) (param $y eqref) (result i32)
      (ref.eq (get_local $x) (get_local $y))
    )
  )
  "type mismatch"
)

(assert_invalid
  (module
    (func (param $x anyfunc) (param $y eqref) (result i32)
      (ref.eq (get_local $x) (get_local $y))
    )
  )
  "type mismatch"
)

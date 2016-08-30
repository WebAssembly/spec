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


;; TODO: test other kinds of imports
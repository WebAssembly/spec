(module (func (i32.const 1)) (export "a1" 0))
(module (func (i32.const 1)) (export "a2" 0) (export "b2" 0))
(module (func (i32.const 1)) (func (i32.const 2)) (export "a3" 0) (export "b3" 1))
(assert_invalid
  (module (func (i32.const 1)) (export "a4" 1))
  "unknown function 1")
(assert_invalid
  (module (func (i32.const 1)) (func (i32.const 2)) (export "a4" 0) (export "a4" 1))
  "duplicate export name")
(assert_invalid
  (module (func (i32.const 1)) (export "a5" 0) (export "a5" 0))
  "duplicate export name")

(module
  (func $f (param $n i32) (result i32)
    (return (i32.add (get_local $n) (i32.const 1)))
  )

  (export "e" $f)
)

(assert_return (invoke "e" (i32.const 42)) (i32.const 43))

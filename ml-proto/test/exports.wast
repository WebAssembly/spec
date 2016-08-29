(module (func) (export "a" (func 0)))
(module (func) (export "a" (func 0)) (export "b" (func 0)))
(module (func) (func) (export "a" (func 0)) (export "b" (func 1)))

(assert_invalid
  (module (func) (export "a" (func 1)))
  "unknown function 1"
)
(assert_invalid
  (module (func) (func) (export "a" (func 0)) (export "a" (func 1)))
  "duplicate export name"
)
(assert_invalid
  (module (func) (export "a" (func 0)) (export "a" (func 0)))
  "duplicate export name"
)

(module
  (func $f (param $n i32) (result i32)
    (return (i32.add (get_local $n) (i32.const 1)))
  )

  (export "e" (func $f))
)

(assert_return (invoke "e" (i32.const 42)) (i32.const 43))

(module (memory 0 0) (export "a" (memory 0)))
(module (memory 0 0) (export "a" (memory 0)) (export "b" (memory 0)))
(assert_invalid (module (export "a" (memory 0))) "unknown memory")

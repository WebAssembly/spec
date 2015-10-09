;; (c) 2015 Andreas Rossberg

(module
  (export "even" $even)
  (export "odd" $odd)

  (func $even (param $n i32) (result i32)
      (block
      (br_unless $endif (i32.eq (get_local $n) (i32.const 0)))
      (return (i32.const 1))
    $endif)
      (call $odd (i32.sub (get_local $n) (i32.const 1)))
  )

  (func $odd (param $n i32) (result i32)
      (block
      (br_unless $endif (i32.eq (get_local $n) (i32.const 0)))
      (return (i32.const 0))
    $endif)
      (call $even (i32.sub (get_local $n) (i32.const 1)))
  )
)

(assert_return (invoke "even" (i32.const 13)) (i32.const 0))
(assert_return (invoke "even" (i32.const 20)) (i32.const 1))
(assert_return (invoke "odd" (i32.const 13)) (i32.const 1))
(assert_return (invoke "odd" (i32.const 20)) (i32.const 0))

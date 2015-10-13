(module
  ;; Statement br_switch
  (func $stmt (param $i i32) (result i32)
    (local $j i32)
    (set_local $j (i32.const 100))
    (block $end
    (block $default
    (block $case6
    (block $case5
    (block $case4
    (block $case3
    (block $case2
    (block $case1
    (block $case0
    (i32.br_switch (get_local $i)
                   $default 0 $case0 1 $case1 2 $case2 3 $case3 4 $case4 5 $case5 6 $case6))
    (return (get_local $i)))))
    (set_local $j (i32.sub (i32.const 0) (get_local $i))) (break $end))
    (break $end))
    (set_local $j (i32.const 101)) (break $end))
    (set_local $j (i32.const 101)))
    (set_local $j (i32.const 102)))
    (return (get_local $j))
  )

  ;; Expression br_switch
  (func $expr (param $i i64) (result i64)
    (local $j i64)
    (set_local $j (i64.const 100))
    (return
      (block $exit
      (block $default
      (block $case6
      (block $case3
      (block $case2
      (block $case1
      (block $case0
      (i64.br_switch (get_local $i)
                     $default 0 $case0 1 $case1 2 $case2 3 $case3 6 $case6))
      (return (get_local $i)))))
      (break $exit (i64.sub (i64.const 0) (get_local $i))))
      (set_local $j (i64.const 101)))
      (get_local $j))
    )
  )

  (export "stmt" $stmt)
  (export "expr" $expr)
)

(assert_return (invoke "stmt" (i32.const 0)) (i32.const 0))
(assert_return (invoke "stmt" (i32.const 1)) (i32.const -1))
(assert_return (invoke "stmt" (i32.const 2)) (i32.const -2))
(assert_return (invoke "stmt" (i32.const 3)) (i32.const -3))
(assert_return (invoke "stmt" (i32.const 4)) (i32.const 100))
(assert_return (invoke "stmt" (i32.const 5)) (i32.const 101))
(assert_return (invoke "stmt" (i32.const 6)) (i32.const 102))
(assert_return (invoke "stmt" (i32.const 7)) (i32.const 102))
(assert_return (invoke "stmt" (i32.const -10)) (i32.const 102))

(assert_return (invoke "expr" (i64.const 0)) (i64.const 0))
(assert_return (invoke "expr" (i64.const 1)) (i64.const -1))
(assert_return (invoke "expr" (i64.const 2)) (i64.const -2))
(assert_return (invoke "expr" (i64.const 3)) (i64.const -3))
(assert_return (invoke "expr" (i64.const 6)) (i64.const 101))
(assert_return (invoke "expr" (i64.const 7)) (i64.const 100))
(assert_return (invoke "expr" (i64.const -10)) (i64.const 100))

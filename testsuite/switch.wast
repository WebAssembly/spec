;; (c) 2015 Andreas Rossberg

(module
  ;; Statement switch
  (func $stmt (param $i i32) (result i32)
    (local $j i32)
    (set_local $j (i32.const 100))
    (label
      (i32.switch (get_local $i)
        (case 0 (return (get_local $i)))
        (case 1 (nop) fallthrough)
        (case 2)  ;; implicit fallthrough
        (case 3 (set_local $j (i32.sub (i32.const 0) (get_local $i))) (break 0))
        (case 4 (break 0))
        (case 5 (set_local $j (i32.const 101)))
        (case 6 (set_local $j (i32.const 101)) fallthrough)
        (;default;) (set_local $j (i32.const 102))
      )
    )
    (return (get_local $j))
  )

  ;; Expression switch
  (func $expr (param $i i64) (result i64)
    (local $j i64)
    (set_local $j (i64.const 100))
    (return
      (label $l
        (i64.switch (get_local $i)
          (case 0 (return (get_local $i)))
          (case 1 (nop) fallthrough)
          (case 2)  ;; implicit fallthrough
          (case 3 (break $l (i64.sub (i64.const 0) (get_local $i))))
          (case 6 (set_local $j (i64.const 101)) fallthrough)
          (;default;) (get_local $j)
        )
      )
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

;; (c) 2015 Andreas Rossberg

(module
  ;; Recursive factorial
  (func (param i64) (result i64)
    (if (i64.eq (get_local 0) (i64.const 0))
      (i64.const 1)
      (i64.mul (get_local 0) (call 0 (i64.sub (get_local 0) (i64.const 1))))
    )
  )

  ;; Recursive factorial named
  (func $fac-rec (param $n i64) (result i64)
    (if (i64.eq (get_local $n) (i64.const 0))
      (i64.const 1)
      (i64.mul
        (get_local $n)
        (call $fac-rec (i64.sub (get_local $n) (i64.const 1)))
      )
    )
  )

  ;; Iterative factorial
  (func (param i64) (result i64)
    (local i64 i64)
    (set_local 1 (get_local 0))
    (set_local 2 (i64.const 1))
    (label
      (loop
        (if
          (i64.eq (get_local 1) (i64.const 0))
          (break 0)
          (block
            (set_local 2 (i64.mul (get_local 1) (get_local 2)))
            (set_local 1 (i64.sub (get_local 1) (i64.const 1)))
          )
        )
      )
    )
    (return (get_local 2))
  )

  ;; Iterative factorial named
  (func $fac-iter (param $n i64) (result i64)
    (local $i i64)
    (local $res i64)
    (set_local $i (get_local $n))
    (set_local $res (i64.const 1))
    (label $done
      (loop
        (if
          (i64.eq (get_local $i) (i64.const 0))
          (break $done)
          (block
            (set_local $res (i64.mul (get_local $i) (get_local $res)))
            (set_local $i (i64.sub (get_local $i) (i64.const 1)))
          )
        )
      )
    )
    (return (get_local $res))
  )

  (export "fac-rec" 0)
  (export "fac-iter" 2)
  (export "fac-rec-named" $fac-rec)
  (export "fac-iter-named" $fac-iter)
)

(assert_return (invoke "fac-rec" (i64.const 25)) (i64.const 7034535277573963776))
(assert_return (invoke "fac-iter" (i64.const 25)) (i64.const 7034535277573963776))
(assert_return (invoke "fac-rec-named" (i64.const 25)) (i64.const 7034535277573963776))
(assert_return (invoke "fac-iter-named" (i64.const 25)) (i64.const 7034535277573963776))

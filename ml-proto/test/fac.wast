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
    (loop
      (if
        (i64.eq (get_local 1) (i64.const 0))
        (br0 2)
        (block
          (set_local 2 (i64.mul (get_local 1) (get_local 2)))
          (set_local 1 (i64.sub (get_local 1) (i64.const 1)))
        )
      )
      (br0 0)
    )
    (get_local 2)
  )

  ;; Iterative factorial named
  (func $fac-iter (param $n i64) (result i64)
    (local $i i64)
    (local $res i64)
    (set_local $i (get_local $n))
    (set_local $res (i64.const 1))
    (loop $done $loop
      (if
        (i64.eq (get_local $i) (i64.const 0))
        (br0 $done)
        (block
          (set_local $res (i64.mul (get_local $i) (get_local $res)))
          (set_local $i (i64.sub (get_local $i) (i64.const 1)))
        )
      )
      (br0 $loop)
    )
    (get_local $res)
  )

  ;; More-realistically optimized factorial.
  (func $fac-opt (param i64) (result i64)
    (local i64)
    (set_local 1 (i64.const 1))
    (block
      (br0_if 0 (i64.lt_s (get_local 0) (i64.const 2)))
      (loop
        (set_local 1 (i64.mul (get_local 1) (get_local 0)))
        (set_local 0 (i64.add (get_local 0) (i64.const -1)))
        (br0_if 0 (i64.gt_s (get_local 0) (i64.const 1)))
      )
    )
    (get_local 1)
  )

  (export "fac-rec" 0)
  (export "fac-iter" 2)
  (export "fac-rec-named" $fac-rec)
  (export "fac-iter-named" $fac-iter)
  (export "fac-opt" $fac-opt)
)

(assert_return (invoke "fac-rec" (i64.const 25)) (i64.const 7034535277573963776))
(assert_return (invoke "fac-iter" (i64.const 25)) (i64.const 7034535277573963776))
(assert_return (invoke "fac-rec-named" (i64.const 25)) (i64.const 7034535277573963776))
(assert_return (invoke "fac-iter-named" (i64.const 25)) (i64.const 7034535277573963776))
(assert_return (invoke "fac-opt" (i64.const 25)) (i64.const 7034535277573963776))
(assert_trap (invoke "fac-rec" (i64.const 1073741824)) "call stack exhausted")

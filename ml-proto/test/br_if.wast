;; Similar to fac.wasm, but using br_if instead of if.

(module
  (func (param i64) (result i64)
    (block $else
      (br_if $else (i64.ne (get_local 0) (i64.const 0)))
      (return (i64.const 1))
    )
    (i64.mul (get_local 0) (call 0 (i64.sub (get_local 0) (i64.const 1))))
  )

  (func (param i64) (result i64)
    (local i64 i64)
    (set_local 1 (get_local 0))
    (set_local 2 (i64.const 1))
    (loop $done $loop
      (br_if $done (i64.eq (get_local 1) (i64.const 0)))
      (set_local 2 (i64.mul (get_local 1) (get_local 2)))
      (set_local 1 (i64.sub (get_local 1) (i64.const 1)))
      (break $loop))
    (return (get_local 2))
  )

  (export "fac-rec" 0)
  (export "fac-iter" 1)
)

(assert_return (invoke "fac-rec" (i64.const 25)) (i64.const 7034535277573963776))
(assert_return (invoke "fac-iter" (i64.const 25)) (i64.const 7034535277573963776))

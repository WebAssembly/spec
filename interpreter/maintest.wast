(module
  ;; Recursive factorial named
  (func $fac-rec (export "fac-rec") (param $n i64) (result i64)
    (if (result i64) (i64.eq (get_local $n) (i64.const 0))
      (then (i64.const 1))
      (else
        (i64.mul
          (get_local $n)
          (call $fac-rec (i64.sub (get_local $n) (i64.const 1)))
        )
      )
    )
  )
  (func (export "_main") (param i32 i32) (result i32)
      (drop (call $fac-rec (i64.const 123)))
      (i32.const 0)
  )
)


(module
  ;; Recursive factorial named
  (import "input" "read" (func $read (param i64) (result i64)))
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
  (func $read-test (export "read-test") (param $n i64) (result i64)
          (call $read (get_local $n))
  )
  (func (export "error-test") (param $n i64) (result i64)
          (unreachable)
  )
)

(invoke "error-test" (i64.const 2))


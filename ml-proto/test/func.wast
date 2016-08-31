;; Test `func` declarations, i.e. functions

(module
  ;; Auxiliary definition
  (type $sig (func))
  (func $dummy)

  ;; Syntax

  (func)
  (func $f)
  (export "f" (func))
  (export "g" (func $g))

  (func (local))
  (func (local i32))
  (func (local $x i32))
  (func (local i32 f64 i64))
  (func (local i32) (local f64))
  (func (local i32 f32) (local $x i64) (local) (local i32 f64))

  (func (param))
  (func (param i32))
  (func (param $x i32))
  (func (param i32 f64 i64))
  (func (param i32) (param f64))
  (func (param i32 f32) (param $x i64) (param) (param i32 f64))

  (func (result i32) (unreachable))

  (func (type $sig))

  (func $complex
    (param i32 f32) (param $x i64) (param) (param i32)
    (result i32)
    (local f32) (local $y i32) (local i64 i32) (local) (local f64 i32)
    (unreachable) (unreachable)
  )
  (func $complex-sig
    (type $sig)
    (local f32) (local $y i32) (local i64 i32) (local) (local f64 i32)
    (unreachable) (unreachable)
  )


  ;; Typing of locals

  (export "local-first-i32" (func (result i32) (local i32 i32) (get_local 0)))
  (export "local-first-i64" (func (result i64) (local i64 i64) (get_local 0)))
  (export "local-first-f32" (func (result f32) (local f32 f32) (get_local 0)))
  (export "local-first-f64" (func (result f64) (local f64 f64) (get_local 0)))
  (export "local-second-i32" (func (result i32) (local i32 i32) (get_local 1)))
  (export "local-second-i64" (func (result i64) (local i64 i64) (get_local 1)))
  (export "local-second-f32" (func (result f32) (local f32 f32) (get_local 1)))
  (export "local-second-f64" (func (result f64) (local f64 f64) (get_local 1)))
  (export "local-mixed" (func (result f64)
    (local f32) (local $x i32) (local i64 i32) (local) (local f64 i32)
    (drop (f32.neg (get_local 0)))
    (drop (i32.eqz (get_local 1)))
    (drop (i64.eqz (get_local 2)))
    (drop (i32.eqz (get_local 3)))
    (drop (f64.neg (get_local 4)))
    (drop (i32.eqz (get_local 5)))
    (get_local 4)
  ))

  ;; Typing of parameters

  (export "param-first-i32" (func (param i32 i32) (result i32) (get_local 0)))
  (export "param-first-i64" (func (param i64 i64) (result i64) (get_local 0)))
  (export "param-first-f32" (func (param f32 f32) (result f32) (get_local 0)))
  (export "param-first-f64" (func (param f64 f64) (result f64) (get_local 0)))
  (export "param-second-i32" (func (param i32 i32) (result i32) (get_local 1)))
  (export "param-second-i64" (func (param i64 i64) (result i64) (get_local 1)))
  (export "param-second-f32" (func (param f32 f32) (result f32) (get_local 1)))
  (export "param-second-f64" (func (param f64 f64) (result f64) (get_local 1)))
  (export "param-mixed" (func (param f32 i32) (param) (param $x i64) (param i32 f64 i32)
    (result f64)
    (drop (f32.neg (get_local 0)))
    (drop (i32.eqz (get_local 1)))
    (drop (i64.eqz (get_local 2)))
    (drop (i32.eqz (get_local 3)))
    (drop (f64.neg (get_local 4)))
    (drop (i32.eqz (get_local 5)))
    (get_local 4)
  ))

  ;; Typing of result

  (export "empty" (func))
  (export "value-void" (func (call $dummy)))
  (export "value-i32" (func (result i32) (i32.const 77)))
  (export "value-i64" (func (result i64) (i64.const 7777)))
  (export "value-f32" (func (result f32) (f32.const 77.7)))
  (export "value-f64" (func (result f64) (f64.const 77.77)))
  (export "value-block-void" (func (block (call $dummy) (call $dummy))))
  (export "value-block-i32" (func (result i32) (block (call $dummy) (i32.const 77))))

  (export "return-empty" (func (return)))
  (export "return-i32" (func (result i32) (return (i32.const 78))))
  (export "return-i64" (func (result i64) (return (i64.const 7878))))
  (export "return-f32" (func (result f32) (return (f32.const 78.7))))
  (export "return-f64" (func (result f64) (return (f64.const 78.78))))
  (export "return-block-i32" (func (result i32)
    (return (block (call $dummy) (i32.const 77)))
  ))

  (export "break-empty" (func (br 0)))
  (export "break-i32" (func (result i32) (br 0 (i32.const 79))))
  (export "break-i64" (func (result i64) (br 0 (i64.const 7979))))
  (export "break-f32" (func (result f32) (br 0 (f32.const 79.9))))
  (export "break-f64" (func (result f64) (br 0 (f64.const 79.79))))
  (export "break-block-i32" (func (result i32)
    (br 0 (block (call $dummy) (i32.const 77)))
  ))

  (export "break-br_if-empty" (func (param i32)
    (br_if 0 (get_local 0))
  ))
  (export "break-br_if-num" (func (param i32) (result i32)
    (br_if 0 (i32.const 50) (get_local 0)) (i32.const 51)
  ))

  (export "break-br_table-empty" (func (param i32)
    (br_table 0 0 0 (get_local 0))
  ))
  (export "break-br_table-num" (func (param i32) (result i32)
    (br_table 0 0 (i32.const 50) (get_local 0)) (i32.const 51)
  ))
  (export "break-br_table-nested-empty" (func (param i32)
    (block (br_table 0 1 0 (get_local 0)))
  ))
  (export "break-br_table-nested-num" (func (param i32) (result i32)
    (i32.add
      (block (br_table 0 1 0 (i32.const 50) (get_local 0)) (i32.const 51))
      (i32.const 2)
    )
  ))

  ;; Default initialization of locals

  (export "init-local-i32" (func (result i32) (local i32) (get_local 0)))
  (export "init-local-i64" (func (result i64) (local i64) (get_local 0)))
  (export "init-local-f32" (func (result f32) (local f32) (get_local 0)))
  (export "init-local-f64" (func (result f64) (local f64) (get_local 0)))


  ;; Desugaring of implicit type signature
  (func $empty-sig-1)  ;; should be assigned type $sig
  (func $complex-sig-1 (param f64 i64 f64 i64 f64 i64 f32 i32))
  (func $empty-sig-2)  ;; should be assigned type $sig
  (func $complex-sig-2 (param f64 i64 f64 i64 f64 i64 f32 i32))
  (func $complex-sig-3 (param f64 i64 f64 i64 f64 i64 f32 i32))

  (type $empty-sig-duplicate (func))
  (type $complex-sig-duplicate (func (param f64 i64 f64 i64 f64 i64 f32 i32)))
  (table anyfunc
    (elem
      $complex-sig-3 $empty-sig-2 $complex-sig-1 $complex-sig-3 $empty-sig-1
    )
  )

  (export "signature-explicit-reused" (func
    (call_indirect $sig (i32.const 1))
    (call_indirect $sig (i32.const 4))
  ))

  (export "signature-implicit-reused" (func
    ;; The implicit index 16 in this test depends on the function and
    ;; type definitions, and may need adapting if they change.
    (call_indirect 16 (i32.const 0)
      (f64.const 0) (i64.const 0) (f64.const 0) (i64.const 0)
      (f64.const 0) (i64.const 0) (f32.const 0) (i32.const 0)
    )
    (call_indirect 16 (i32.const 2)
      (f64.const 0) (i64.const 0) (f64.const 0) (i64.const 0)
      (f64.const 0) (i64.const 0) (f32.const 0) (i32.const 0)
    )
    (call_indirect 16 (i32.const 3)
      (f64.const 0) (i64.const 0) (f64.const 0) (i64.const 0)
      (f64.const 0) (i64.const 0) (f32.const 0) (i32.const 0)
    )
  ))

  (export "signature-explicit-duplicate" (func
    (call_indirect $empty-sig-duplicate (i32.const 1))
  ))

  (export "signature-implicit-duplicate" (func
    (call_indirect $complex-sig-duplicate (i32.const 0)
      (f64.const 0) (i64.const 0) (f64.const 0) (i64.const 0)
      (f64.const 0) (i64.const 0) (f32.const 0) (i32.const 0)
    )
  ))
)

(assert_return (invoke "local-first-i32") (i32.const 0))
(assert_return (invoke "local-first-i64") (i64.const 0))
(assert_return (invoke "local-first-f32") (f32.const 0))
(assert_return (invoke "local-first-f64") (f64.const 0))
(assert_return (invoke "local-second-i32") (i32.const 0))
(assert_return (invoke "local-second-i64") (i64.const 0))
(assert_return (invoke "local-second-f32") (f32.const 0))
(assert_return (invoke "local-second-f64") (f64.const 0))
(assert_return (invoke "local-mixed") (f64.const 0))

(assert_return
  (invoke "param-first-i32" (i32.const 2) (i32.const 3)) (i32.const 2)
)
(assert_return
  (invoke "param-first-i64" (i64.const 2) (i64.const 3)) (i64.const 2)
)
(assert_return
  (invoke "param-first-f32" (f32.const 2) (f32.const 3)) (f32.const 2)
)
(assert_return
  (invoke "param-first-f64" (f64.const 2) (f64.const 3)) (f64.const 2)
)
(assert_return
  (invoke "param-second-i32" (i32.const 2) (i32.const 3)) (i32.const 3)
)
(assert_return
  (invoke "param-second-i64" (i64.const 2) (i64.const 3)) (i64.const 3)
)
(assert_return
  (invoke "param-second-f32" (f32.const 2) (f32.const 3)) (f32.const 3)
)
(assert_return
  (invoke "param-second-f64" (f64.const 2) (f64.const 3)) (f64.const 3)
)

(assert_return
  (invoke "param-mixed"
    (f32.const 1) (i32.const 2) (i64.const 3)
    (i32.const 4) (f64.const 5.5) (i32.const 6)
  )
  (f64.const 5.5)
)

(assert_return (invoke "empty"))
(assert_return (invoke "value-void"))
(assert_return (invoke "value-i32") (i32.const 77))
(assert_return (invoke "value-i64") (i64.const 7777))
(assert_return (invoke "value-f32") (f32.const 77.7))
(assert_return (invoke "value-f64") (f64.const 77.77))
(assert_return (invoke "value-block-void"))
(assert_return (invoke "value-block-i32") (i32.const 77))

(assert_return (invoke "return-empty"))
(assert_return (invoke "return-i32") (i32.const 78))
(assert_return (invoke "return-i64") (i64.const 7878))
(assert_return (invoke "return-f32") (f32.const 78.7))
(assert_return (invoke "return-f64") (f64.const 78.78))
(assert_return (invoke "return-block-i32") (i32.const 77))

(assert_return (invoke "break-empty"))
(assert_return (invoke "break-i32") (i32.const 79))
(assert_return (invoke "break-i64") (i64.const 7979))
(assert_return (invoke "break-f32") (f32.const 79.9))
(assert_return (invoke "break-f64") (f64.const 79.79))
(assert_return (invoke "break-block-i32") (i32.const 77))

(assert_return (invoke "break-br_if-empty" (i32.const 0)))
(assert_return (invoke "break-br_if-empty" (i32.const 2)))
(assert_return (invoke "break-br_if-num" (i32.const 0)) (i32.const 51))
(assert_return (invoke "break-br_if-num" (i32.const 1)) (i32.const 50))

(assert_return (invoke "break-br_table-empty" (i32.const 0)))
(assert_return (invoke "break-br_table-empty" (i32.const 1)))
(assert_return (invoke "break-br_table-empty" (i32.const 5)))
(assert_return (invoke "break-br_table-empty" (i32.const -1)))
(assert_return (invoke "break-br_table-num" (i32.const 0)) (i32.const 50))
(assert_return (invoke "break-br_table-num" (i32.const 1)) (i32.const 50))
(assert_return (invoke "break-br_table-num" (i32.const 10)) (i32.const 50))
(assert_return (invoke "break-br_table-num" (i32.const -100)) (i32.const 50))
(assert_return (invoke "break-br_table-nested-empty" (i32.const 0)))
(assert_return (invoke "break-br_table-nested-empty" (i32.const 1)))
(assert_return (invoke "break-br_table-nested-empty" (i32.const 3)))
(assert_return (invoke "break-br_table-nested-empty" (i32.const -2)))
(assert_return
  (invoke "break-br_table-nested-num" (i32.const 0)) (i32.const 52)
)
(assert_return
  (invoke "break-br_table-nested-num" (i32.const 1)) (i32.const 50)
)
(assert_return
  (invoke "break-br_table-nested-num" (i32.const 2)) (i32.const 52)
)
(assert_return
  (invoke "break-br_table-nested-num" (i32.const -3)) (i32.const 52)
)

(assert_return (invoke "init-local-i32") (i32.const 0))
(assert_return (invoke "init-local-i64") (i64.const 0))
(assert_return (invoke "init-local-f32") (f32.const 0))
(assert_return (invoke "init-local-f64") (f64.const 0))

(assert_return (invoke "signature-explicit-reused"))
(assert_return (invoke "signature-implicit-reused"))
(assert_return (invoke "signature-explicit-duplicate"))
(assert_return (invoke "signature-implicit-duplicate"))


;; Invalid typing of locals

(assert_invalid
  (module (func $type-local-num-vs-num (result i64) (local i32) (get_local 0)))
  "type mismatch"
)
(assert_invalid
  (module (func $type-local-num-vs-num (local f32) (i32.eqz (get_local 0))))
  "type mismatch"
)
(assert_invalid
  (module (func $type-local-num-vs-num (local f64 i64) (f64.neg (get_local 1))))
  "type mismatch"
)


;; Invalid typing of parameters

(assert_invalid
  (module (func $type-param-num-vs-num (param i32) (result i64) (get_local 0)))
  "type mismatch"
)
(assert_invalid
  (module (func $type-param-num-vs-num (param f32) (i32.eqz (get_local 0))))
  "type mismatch"
)
(assert_invalid
  (module (func $type-param-num-vs-num (param f64 i64) (f64.neg (get_local 1))))
  "type mismatch"
)


;; Invalid typing of result

(assert_invalid
  (module (func $type-empty-i32 (result i32)))
  "type mismatch"
)
(assert_invalid
  (module (func $type-empty-i64 (result i64)))
  "type mismatch"
)
(assert_invalid
  (module (func $type-empty-f32 (result f32)))
  "type mismatch"
)
(assert_invalid
  (module (func $type-empty-f64 (result f64)))
  "type mismatch"
)

(assert_invalid
  (module (func $type-value-void-vs-num (result i32)
    (nop)
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-value-num-vs-void
    (i32.const 0)
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-value-num-vs-num (result i32)
    (f32.const 0)
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-value-void-vs-num-after-return (result i32)
    (return (i32.const 1)) (nop)
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-value-num-vs-num-after-return (result i32)
    (return (i32.const 1)) (f32.const 0)
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-value-void-vs-num-after-break (result i32)
    (br 0 (i32.const 1)) (nop)
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-value-num-vs-num-after-break (result i32)
    (br 0 (i32.const 1)) (f32.const 0)
  ))
  "type mismatch"
)

(assert_invalid
  (module (func $type-return-last-void-vs-enpty
    (return (nop))
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-return-last-num-vs-enpty
    (return (i32.const 0))
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-return-last-empty-vs-num (result i32)
    (return)
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-return-last-void-vs-num (result i32)
    (return (nop))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-return-last-num-vs-num (result i32)
    (return (i64.const 0))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-return-void-vs-empty
    (return (nop))
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-return-num-vs-empty
    (return (i32.const 0))
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-return-empty-vs-num (result i32)
    (return) (i32.const 1)
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-return-void-vs-num (result i32)
    (return (nop)) (i32.const 1)
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-return-num-vs-num (result i32)
    (return (i64.const 1)) (i32.const 1)
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-return-first-num-vs-num (result i32)
    (return (i64.const 1)) (return (i32.const 1))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-return-second-num-vs-num (result i32)
    (return (i32.const 1)) (return (f64.const 1))
  ))
  "type mismatch"
)

(assert_invalid
  (module (func $type-break-last-void-vs-empty
    (br 0 (nop))
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-break-last-num-vs-empty
    (br 0 (i32.const 0))
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-break-last-empty-vs-num (result i32)
    (br 0)
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-break-last-void-vs-num (result i32)
    (br 0 (nop))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-break-last-num-vs-num (result i32)
    (br 0 (f32.const 0))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-break-void-vs-empty
    (br 0 (i64.const 1))
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-break-num-vs-empty
    (br 0 (i64.const 1))
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-break-empty-vs-num (result i32)
    (br 0) (i32.const 1)
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-break-void-vs-num (result i32)
    (br 0 (nop)) (i32.const 1)
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-break-num-vs-num (result i32)
    (br 0 (i64.const 1)) (i32.const 1)
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-break-first-num-vs-num (result i32)
    (br 0 (i64.const 1)) (br 0 (i32.const 1))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-break-second-num-vs-num (result i32)
    (br 0 (i32.const 1)) (br 0 (f64.const 1))
  ))
  "type mismatch"
)

(assert_invalid
  (module (func $type-break-nested-empty-vs-num (result i32)
    (block (br 1)) (br 0 (i32.const 1))
  ))
  "arity mismatch"
)
(assert_invalid
  (module (func $type-break-nested-void-vs-num (result i32)
    (block (br 1 (nop))) (br 0 (i32.const 1))
  ))
  "type mismatch"
)
(assert_invalid
  (module (func $type-break-nested-num-vs-num (result i32)
    (block (br 1 (i64.const 1))) (br 0 (i32.const 1))
  ))
  "type mismatch"
)


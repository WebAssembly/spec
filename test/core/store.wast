;; Store operator as the argument of control constructs and instructions

(module
  (memory 1)

  (func (export "as-block-value")
    (block (i32.store (i32.const 0) (i32.const 1)))
  )
  (func (export "as-loop-value")
    (loop (i32.store (i32.const 0) (i32.const 1)))
  )

  (func (export "as-br-value")
    (block (br 0 (i32.store (i32.const 0) (i32.const 1))))
  )
  (func (export "as-br_if-value")
    (block
      (br_if 0 (i32.store (i32.const 0) (i32.const 1)) (i32.const 1))
    )
  )
  (func (export "as-br_if-value-cond")
    (block
      (br_if 0 (i32.const 6) (i32.store (i32.const 0) (i32.const 1)))
    )
  )
  (func (export "as-br_table-value")
    (block
      (br_table 0 (i32.store (i32.const 0) (i32.const 1)) (i32.const 1))
    )
  )

  (func (export "as-return-value")
    (return (i32.store (i32.const 0) (i32.const 1)))
  )

  (func (export "as-if-then")
    (if (i32.const 1) (then (i32.store (i32.const 0) (i32.const 1))))
  )
  (func (export "as-if-else")
    (if (i32.const 0) (then) (else (i32.store (i32.const 0) (i32.const 1))))
  )
)

(assert_return (invoke "as-block-value"))
(assert_return (invoke "as-loop-value"))

(assert_return (invoke "as-br-value"))
(assert_return (invoke "as-br_if-value"))
(assert_return (invoke "as-br_if-value-cond"))
(assert_return (invoke "as-br_table-value"))

(assert_return (invoke "as-return-value"))

(assert_return (invoke "as-if-then"))
(assert_return (invoke "as-if-else"))

(assert_malformed
  (module quote
    "(memory 1)"
    "(func (param i32) (i32.store32 (local.get 0) (i32.const 0)))"
  )
  "unknown operator"
)
(assert_malformed
  (module quote
    "(memory 1)"
    "(func (param i32) (i32.store64 (local.get 0) (i64.const 0)))"
  )
  "unknown operator"
)

(assert_malformed
  (module quote
    "(memory 1)"
    "(func (param i32) (i64.store64 (local.get 0) (i64.const 0)))"
  )
  "unknown operator"
)

(assert_malformed
  (module quote
    "(memory 1)"
    "(func (param i32) (f32.store32 (local.get 0) (f32.const 0)))"
  )
  "unknown operator"
)
(assert_malformed
  (module quote
    "(memory 1)"
    "(func (param i32) (f32.store64 (local.get 0) (f64.const 0)))"
  )
  "unknown operator"
)

(assert_malformed
  (module quote
    "(memory 1)"
    "(func (param i32) (f64.store32 (local.get 0) (f32.const 0)))"
  )
  "unknown operator"
)
(assert_malformed
  (module quote
    "(memory 1)"
    "(func (param i32) (f64.store64 (local.get 0) (f64.const 0)))"
  )
  "unknown operator"
)
;; store should have no retval

(assert_invalid
  (module (memory 1) (func (param i32) (result i32) (i32.store (i32.const 0) (i32.const 1))))
  "type mismatch"
)
(assert_invalid
  (module (memory 1) (func (param i64) (result i64) (i64.store (i32.const 0) (i64.const 1))))
  "type mismatch"
)
(assert_invalid
  (module (memory 1) (func (param f32) (result f32) (f32.store (i32.const 0) (f32.const 1))))
  "type mismatch"
)
(assert_invalid
  (module (memory 1) (func (param f64) (result f64) (f64.store (i32.const 0) (f64.const 1))))
  "type mismatch"
)
(assert_invalid
  (module (memory 1) (func (param i32) (result i32) (i32.store8 (i32.const 0) (i32.const 1))))
  "type mismatch"
)
(assert_invalid
  (module (memory 1) (func (param i32) (result i32) (i32.store16 (i32.const 0) (i32.const 1))))
  "type mismatch"
)
(assert_invalid
  (module (memory 1) (func (param i64) (result i64) (i64.store8 (i32.const 0) (i64.const 1))))
  "type mismatch"
)
(assert_invalid
  (module (memory 1) (func (param i64) (result i64) (i64.store16 (i32.const 0) (i64.const 1))))
  "type mismatch"
)
(assert_invalid
  (module (memory 1) (func (param i64) (result i64) (i64.store32 (i32.const 0) (i64.const 1))))
  "type mismatch"
)


(assert_invalid
  (module
    (memory 1)
    (func $type-1st-operand-missing
      (i32.store)
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-2nd-operand-missing
     (i32.const 0) (i32.store)
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-1st-operand-missing-in-block
      (i32.const 0) (i32.const 0)
      (block (i32.store))
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-2nd-operand-missing-in-block
      (i32.const 0)
      (block (i32.const 0) (i32.store))
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-1st-operand-missing-in-loop
      (i32.const 0) (i32.const 0)
      (loop (i32.store))
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-2nd-operand-missing-in-loop
      (i32.const 0)
      (loop (i32.const 0) (i32.store))
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-1st-operand-missing-in-if
      (i32.const 0) (i32.const 0)
      (if (then (i32.store)))
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-2nd-operand-missing-in-if
      (i32.const 0)
      (if (then (i32.const 0) (i32.store)))
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-1st-operand-missing-in-else
      (i32.const 0) (i32.const 0)
      (if (result i32) (then (i32.const 0)) (else (i32.store)))
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-2nd-operand-missing-in-else
      (i32.const 0)
      (if (result i32) (then (i32.const 0)) (else (i32.const 0) (i32.store)))
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-1st-operand-missing-in-br
      (i32.const 0) (i32.const 0)
      (block (br 0 (i32.store)))
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-2nd-operand-missing-in-br
      (i32.const 0)
      (block (br 0 (i32.const 0) (i32.store)))
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-1st-operand-missing-in-br_if
      (i32.const 0) (i32.const 0)
      (block (br_if 0 (i32.store) (i32.const 1)) )
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-2nd-operand-missing-in-br_if
      (i32.const 0)
      (block (br_if 0 (i32.const 0) (i32.store) (i32.const 1)) )
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-1st-operand-missing-in-br_table
      (i32.const 0) (i32.const 0)
      (block (br_table 0 (i32.store)))
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-2nd-operand-missing-in-br_table
      (i32.const 0)
      (block (br_table 0 (i32.const 0) (i32.store)))
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-1st-operand-missing-in-return
      (return (i32.store))
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-2nd-operand-missing-in-return
      (return (i32.const 0) (i32.store))
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-1st-operand-missing-in-select
      (select (i32.store) (i32.const 1) (i32.const 2))
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-2nd-operand-missing-in-select
      (select (i32.const 0) (i32.store) (i32.const 1) (i32.const 2))
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-1st-operand-missing-in-call
      (call 1 (i32.store))
    )
    (func (param i32) (result i32) (local.get 0))
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $type-2nd-operand-missing-in-call
      (call 1 (i32.const 0) (i32.store))
    )
    (func (param i32) (result i32) (local.get 0))
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $f (param i32) (result i32) (local.get 0))
    (type $sig (func (param i32) (result i32)))
    (table funcref (elem $f))
    (func $type-1st-operand-missing-in-call_indirect
      (block (result i32)
        (call_indirect (type $sig)
          (i32.store) (i32.const 0)
        )
      )
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (memory 1)
    (func $f (param i32) (result i32) (local.get 0))
    (type $sig (func (param i32) (result i32)))
    (table funcref (elem $f))
    (func $type-2nd-operand-missing-in-call_indirect
      (block (result i32)
        (call_indirect (type $sig)
          (i32.const 0) (i32.store) (i32.const 0)
        )
      )
    )
  )
  "type mismatch"
)

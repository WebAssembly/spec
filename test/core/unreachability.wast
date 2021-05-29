(module

  ;; Check that both sides of the select are evaluated
  (func (export "select-trap-left") (param $cond i32) (result i32)
    (select (unreachable) (i32.const 0) (local.get $cond))
  )
  (func (export "select-trap-right") (param $cond i32) (result i32)
    (select (i32.const 0) (unreachable) (local.get $cond))
  )

  (func (export "select-unreached")
    (unreachable) (select)
    (unreachable) (i32.const 0) (select)
    (unreachable) (i32.const 0) (i32.const 0) (select)
    (unreachable) (i32.const 0) (i32.const 0) (i32.const 0) (select)
    (unreachable) (f32.const 0) (i32.const 0) (select)
    (unreachable)
  )

  (func (export "select_unreached_result_1") (result i32)
    (unreachable) (i32.add (select))
  )

  (func (export "select_unreached_result_2") (result i64)
    (unreachable) (i64.add (select (i64.const 0) (i32.const 0)))
  )

  (func (export "unreachable-num")
    (unreachable)
    (select)
    (i32.eqz)
    (drop)
  )
  (func (export "unreachable-ref")
    (unreachable)
    (select)
    (ref.is_null)
    (drop)
  )
)

(assert_trap (invoke "select-trap-left" (i32.const 1)) "unreachable")
(assert_trap (invoke "select-trap-left" (i32.const 0)) "unreachable")
(assert_trap (invoke "select-trap-right" (i32.const 1)) "unreachable")
(assert_trap (invoke "select-trap-right" (i32.const 0)) "unreachable")

;; Validation after unreachable

;; The first two operands should have the same type as each other
(assert_invalid
  (module (func (unreachable) (select (i32.const 1) (i64.const 1) (i32.const 1)) (drop)))
  "type mismatch"
)

(assert_invalid
  (module (func (unreachable) (select (i64.const 1) (i32.const 1) (i32.const 1)) (drop)))
  "type mismatch"
)

;; Third operand must be i32
(assert_invalid
  (module (func (unreachable) (select (i32.const 1) (i32.const 1) (i64.const 1)) (drop)))
  "type mismatch"
)

(assert_invalid
  (module (func (unreachable) (select (i32.const 1) (i64.const 1)) (drop)))
  "type mismatch"
)

(assert_invalid
  (module (func (unreachable) (select (i64.const 1)) (drop)))
  "type mismatch"
)

;; Result of select has type of first two operands (type of second operand when first one is omitted)
(assert_invalid
  (module (func (result i32) (unreachable) (select (i64.const 1) (i32.const 1))))
  "type mismatch"
)

;; select always has non-empty result
(assert_invalid
  (module (func (unreachable) (select)))
  "type mismatch"
)

(module
  (func (export "meet-bottom")
    (block (result f64)
      (block (result f32)
        (unreachable)
        (br_table 0 1 1 (i32.const 1))
      )
      (drop)
      (f64.const 0)
    )
    (drop)
  )
)

(assert_invalid
  (module (func $meet-bottom (param i32) (result externref)
    (block $l1 (result externref)
      (drop
        (block $l2 (result i32)
          (br_table $l2 $l1 $l2 (ref.null extern) (local.get 0))
        )
      )
      (ref.null extern)
    )
  ))
  "type mismatch"
)


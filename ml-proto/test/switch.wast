(module
  ;; Statement switch
  (func $stmt (param $i i32) (result i32)
    (local $j i32)
    (set_local $j (i32.const 100))
    (block
      (tableswitch (get_local $i)
        (table (case $0) (case $1) (case $2) (case $3) (case $4)
               (case $5) (case $6) (case $7))
        (default (case $default))
        (case $0 (return (get_local $i)))
        (case $1 (nop))  ;; fallthrough
        (case $2)  ;; fallthrough
        (case $3 (set_local $j (i32.sub (i32.const 0) (get_local $i))) (br 0))
        (case $4 (br 0))
        (case $5 (set_local $j (i32.const 101)) (br 0))
        (case $6 (set_local $j (i32.const 101)))  ;; fallthrough
        (case $default (set_local $j (i32.const 102)))
        (case $7)
      )
    )
    (return (get_local $j))
  )

  ;; Expression switch
  (func $expr (param $i i64) (result i64)
    (local $j i64)
    (set_local $j (i64.const 100))
    (return
      (block $l
        (tableswitch (i32.wrap/i64 (get_local $i))
          (table (case $0) (case $1) (case $2) (case $3) (case $4)
                 (case $5) (case $6) (case $7))
          (default (case $default))
          (case $0 (return (get_local $i)))
          (case $1 (nop))  ;; fallthrough
          (case $2)  ;; fallthrough
          (case $3 (br $l (i64.sub (i64.const 0) (get_local $i))))
          (case $6 (set_local $j (i64.const 101)))  ;; fallthrough
          (case $4)  ;; fallthrough
          (case $5)  ;; fallthrough
          (case $default (br $l (get_local $j)))
          (case $7 (i64.const -5))
        )
      )
    )
  )

  ;; Corner cases
  (func $corner (result i32)
    (local $x i32)
    (tableswitch (i32.const 0)
      (table)
      (default (case $default))
      (case $default)
    )
    (tableswitch (i32.const 0)
      (table)
      (default (case $default))
      (case $default (set_local $x (i32.add (get_local $x) (i32.const 1))))
    )
    (tableswitch (i32.const 1)
      (table (case $0))
      (default (case $default))
      (case $default (set_local $x (i32.add (get_local $x) (i32.const 2))))
      (case $0 (set_local $x (i32.add (get_local $x) (i32.const 4))))
    )
    (get_local $x)
  )

  ;; Break
  (func $break (result i32)
    (local $x i32)
    (tableswitch $l (i32.const 0)
      (table)
      (default (br $l))
    )
    (tableswitch $l (i32.const 0)
      (table (br $l))
      (default (case $default))
      (case $default (set_local $x (i32.add (get_local $x) (i32.const 1))))
    )
    (tableswitch $l (i32.const 1)
      (table (case $0))
      (default (br $l))
      (case $0 (set_local $x (i32.add (get_local $x) (i32.const 2))))
    )
    (get_local $x)
  )

  (export "stmt" $stmt)
  (export "expr" $expr)
  (export "corner" $corner)
  (export "break" $break)
)

(assert_return (invoke "stmt" (i32.const 0)) (i32.const 0))
(assert_return (invoke "stmt" (i32.const 1)) (i32.const -1))
(assert_return (invoke "stmt" (i32.const 2)) (i32.const -2))
(assert_return (invoke "stmt" (i32.const 3)) (i32.const -3))
(assert_return (invoke "stmt" (i32.const 4)) (i32.const 100))
(assert_return (invoke "stmt" (i32.const 5)) (i32.const 101))
(assert_return (invoke "stmt" (i32.const 6)) (i32.const 102))
(assert_return (invoke "stmt" (i32.const 7)) (i32.const 100))
(assert_return (invoke "stmt" (i32.const -10)) (i32.const 102))

(assert_return (invoke "expr" (i64.const 0)) (i64.const 0))
(assert_return (invoke "expr" (i64.const 1)) (i64.const -1))
(assert_return (invoke "expr" (i64.const 2)) (i64.const -2))
(assert_return (invoke "expr" (i64.const 3)) (i64.const -3))
(assert_return (invoke "expr" (i64.const 6)) (i64.const 101))
(assert_return (invoke "expr" (i64.const 7)) (i64.const -5))
(assert_return (invoke "expr" (i64.const -10)) (i64.const 100))

(assert_return (invoke "corner") (i32.const 7))
(assert_return (invoke "break") (i32.const 0))

(assert_invalid (module (func (tableswitch (i32.const 0) (table) (default (case 0))))) "invalid target")
(assert_invalid (module (func (tableswitch (i32.const 0) (table) (default (case 1)) (case)))) "invalid target")

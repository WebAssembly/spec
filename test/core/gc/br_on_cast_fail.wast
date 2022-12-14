;; Abstract Types

(module
  (type $ft (func (result i32)))
  (type $st (struct (field i16)))
  (type $at (array i8))

  (table 10 anyref)

  (elem declare func $f)
  (func $f (result i32) (i32.const 9))

  (func (export "init") (param $x externref)
    (table.set (i32.const 0) (ref.null any))
    (table.set (i32.const 1) (i31.new (i32.const 7)))
    (table.set (i32.const 2) (struct.new_canon $st (i32.const 6)))
    (table.set (i32.const 3) (array.new_canon $at (i32.const 5) (i32.const 3)))
    (table.set (i32.const 4) (extern.internalize (local.get $x)))
  )

  (func (export "br_on_non_null") (param $i i32) (result i32)
    (block $l (result (ref any))
      (br_on_non_null $l (table.get (local.get $i)))
      (return (i32.const 0))
    )
    (return (i32.const -1))
  )
  (func (export "br_on_non_i31") (param $i i32) (result i32)
    (block $l (result anyref)
      (br_on_cast_fail $l i31 (table.get (local.get $i)))
      (return (i31.get_u))
    )
    (return (i32.const -1))
  )
  (func (export "br_on_non_struct") (param $i i32) (result i32)
    (block $l (result anyref)
      (br_on_cast_fail $l struct (table.get (local.get $i)))
      (block $l2 (param structref) (result (ref $st))
        (block $l3 (param structref) (result (ref $at))
          (br_on_cast $l2 $st)
          (br_on_cast $l3 $at)
          (return (i32.const -2))
        )
        (return (array.get_u $at (i32.const 0)))
      )
      (return (struct.get_s $st 0))
    )
    (return (i32.const -1))
  )
  (func (export "br_on_non_array") (param $i i32) (result i32)
    (block $l (result anyref)
      (br_on_cast_fail $l array (table.get (local.get $i)))
      (return (array.len))
    )
    (return (i32.const -1))
  )
)

(invoke "init" (ref.extern 0))

(assert_return (invoke "br_on_non_null" (i32.const 0)) (i32.const 0))
(assert_return (invoke "br_on_non_null" (i32.const 1)) (i32.const -1))
(assert_return (invoke "br_on_non_null" (i32.const 2)) (i32.const -1))
(assert_return (invoke "br_on_non_null" (i32.const 3)) (i32.const -1))
(assert_return (invoke "br_on_non_null" (i32.const 4)) (i32.const -1))

(assert_return (invoke "br_on_non_i31" (i32.const 0)) (i32.const -1))
(assert_return (invoke "br_on_non_i31" (i32.const 1)) (i32.const 7))
(assert_return (invoke "br_on_non_i31" (i32.const 2)) (i32.const -1))
(assert_return (invoke "br_on_non_i31" (i32.const 3)) (i32.const -1))
(assert_return (invoke "br_on_non_i31" (i32.const 4)) (i32.const -1))

(assert_return (invoke "br_on_non_struct" (i32.const 0)) (i32.const -1))
(assert_return (invoke "br_on_non_struct" (i32.const 1)) (i32.const -1))
(assert_return (invoke "br_on_non_struct" (i32.const 2)) (i32.const 6))
(assert_return (invoke "br_on_non_struct" (i32.const 3)) (i32.const -1))
(assert_return (invoke "br_on_non_struct" (i32.const 4)) (i32.const -1))

(assert_return (invoke "br_on_non_array" (i32.const 0)) (i32.const -1))
(assert_return (invoke "br_on_non_array" (i32.const 1)) (i32.const -1))
(assert_return (invoke "br_on_non_array" (i32.const 2)) (i32.const -1))
(assert_return (invoke "br_on_non_array" (i32.const 3)) (i32.const 3))
(assert_return (invoke "br_on_non_array" (i32.const 4)) (i32.const -1))


;; Concrete Types

(module
  (type $t0 (sub (struct)))
  (type $t1 (sub $t0 (struct (field i32))))
  (type $t1' (sub $t0 (struct (field i32))))
  (type $t2 (sub $t1 (struct (field i32 i32))))
  (type $t2' (sub $t1' (struct (field i32 i32))))
  (type $t3 (sub $t0 (struct (field i32 i32))))
  (type $t0' (sub $t0 (struct)))
  (type $t4 (sub $t0' (struct (field i32 i32))))

  (table 20 structref)

  (func $init
    (table.set (i32.const 0) (struct.new_canon_default $t0))
    (table.set (i32.const 10) (struct.new_canon_default $t0))
    (table.set (i32.const 1) (struct.new_canon_default $t1))
    (table.set (i32.const 11) (struct.new_canon_default $t1'))
    (table.set (i32.const 2) (struct.new_canon_default $t2))
    (table.set (i32.const 12) (struct.new_canon_default $t2'))
    (table.set (i32.const 3) (struct.new_canon_default $t3 ))
    (table.set (i32.const 4) (struct.new_canon_default $t4))
  )

  (func (export "test-sub")
    (call $init)
    (block $l (result structref)
      ;; must not succeed
      (br_on_cast_fail $l null $t0 (ref.null struct))
      (br_on_cast_fail $l null $t0 (table.get (i32.const 0)))
      (br_on_cast_fail $l null $t0 (table.get (i32.const 1)))
      (br_on_cast_fail $l null $t0 (table.get (i32.const 2)))
      (br_on_cast_fail $l null $t0 (table.get (i32.const 3)))
      (br_on_cast_fail $l null $t0 (table.get (i32.const 4)))
      (br_on_cast_fail $l $t0 (table.get (i32.const 0)))
      (br_on_cast_fail $l $t0 (table.get (i32.const 1)))
      (br_on_cast_fail $l $t0 (table.get (i32.const 2)))
      (br_on_cast_fail $l $t0 (table.get (i32.const 3)))
      (br_on_cast_fail $l $t0 (table.get (i32.const 4)))

      (br_on_cast_fail $l null $t1 (ref.null struct))
      (br_on_cast_fail $l null $t1 (table.get (i32.const 1)))
      (br_on_cast_fail $l null $t1 (table.get (i32.const 2)))
      (br_on_cast_fail $l $t1 (table.get (i32.const 1)))
      (br_on_cast_fail $l $t1 (table.get (i32.const 2)))

      (br_on_cast_fail $l null $t2 (ref.null struct))
      (br_on_cast_fail $l null $t2 (table.get (i32.const 2)))
      (br_on_cast_fail $l $t2 (table.get (i32.const 2)))

      (br_on_cast_fail $l null $t3 (ref.null struct))
      (br_on_cast_fail $l null $t3 (table.get (i32.const 3)))
      (br_on_cast_fail $l $t3 (table.get (i32.const 3)))

      (br_on_cast_fail $l null $t4 (ref.null struct))
      (br_on_cast_fail $l null $t4 (table.get (i32.const 4)))
      (br_on_cast_fail $l $t4 (table.get (i32.const 4)))

      ;; must succeed
      (drop (block (result structref) (br_on_cast_fail 0 $t0 (ref.null struct))))

      (drop (block (result structref) (br_on_cast_fail 0 $t1 (ref.null struct))))
      (drop (block (result structref) (br_on_cast_fail 0 $t1 (table.get (i32.const 0)))))
      (drop (block (result structref) (br_on_cast_fail 0 $t1 (table.get (i32.const 3)))))
      (drop (block (result structref) (br_on_cast_fail 0 $t1 (table.get (i32.const 4)))))

      (drop (block (result structref) (br_on_cast_fail 0 $t2 (ref.null struct))))
      (drop (block (result structref) (br_on_cast_fail 0 $t2 (table.get (i32.const 0)))))
      (drop (block (result structref) (br_on_cast_fail 0 $t2 (table.get (i32.const 1)))))
      (drop (block (result structref) (br_on_cast_fail 0 $t2 (table.get (i32.const 3)))))
      (drop (block (result structref) (br_on_cast_fail 0 $t2 (table.get (i32.const 4)))))

      (drop (block (result structref) (br_on_cast_fail 0 $t3 (ref.null struct))))
      (drop (block (result structref) (br_on_cast_fail 0 $t3 (table.get (i32.const 0)))))
      (drop (block (result structref) (br_on_cast_fail 0 $t3 (table.get (i32.const 1)))))
      (drop (block (result structref) (br_on_cast_fail 0 $t3 (table.get (i32.const 2)))))
      (drop (block (result structref) (br_on_cast_fail 0 $t3 (table.get (i32.const 4)))))

      (drop (block (result structref) (br_on_cast_fail 0 $t4 (ref.null struct))))
      (drop (block (result structref) (br_on_cast_fail 0 $t4 (table.get (i32.const 0)))))
      (drop (block (result structref) (br_on_cast_fail 0 $t4 (table.get (i32.const 1)))))
      (drop (block (result structref) (br_on_cast_fail 0 $t4 (table.get (i32.const 2)))))
      (drop (block (result structref) (br_on_cast_fail 0 $t4 (table.get (i32.const 3)))))

      (return)
    )
    (unreachable)
  )

  (func (export "test-canon")
    (call $init)
    (block $l (result structref)
      (br_on_cast_fail $l $t0 (table.get (i32.const 0)))
      (br_on_cast_fail $l $t0 (table.get (i32.const 1)))
      (br_on_cast_fail $l $t0 (table.get (i32.const 2)))
      (br_on_cast_fail $l $t0 (table.get (i32.const 3)))
      (br_on_cast_fail $l $t0 (table.get (i32.const 4)))
      (br_on_cast_fail $l $t0 (table.get (i32.const 10)))
      (br_on_cast_fail $l $t0 (table.get (i32.const 11)))
      (br_on_cast_fail $l $t0 (table.get (i32.const 12)))

      (br_on_cast_fail $l $t1' (table.get (i32.const 1)))
      (br_on_cast_fail $l $t1' (table.get (i32.const 2)))

      (br_on_cast_fail $l $t1 (table.get (i32.const 11)))
      (br_on_cast_fail $l $t1 (table.get (i32.const 12)))

      (br_on_cast_fail $l $t2' (table.get (i32.const 2)))

      (br_on_cast_fail $l $t2 (table.get (i32.const 12)))

      (return)
    )
    (unreachable)
  )
)

(invoke "test-sub")
(invoke "test-canon")


;; Cases of nullability

(module
  (type $t (struct))

  (func (param (ref any)) (result (ref any))
    (block (result (ref $t)) (br_on_cast_fail 1 $t (local.get 0)))
  )
  (func (param (ref null any)) (result (ref null any))
    (block (result (ref $t)) (br_on_cast_fail 1 $t (local.get 0)))
  )
  (func (param (ref any)) (result (ref any))
    (block (result (ref null $t)) (br_on_cast_fail 1 null $t (local.get 0))) (ref.as_non_null)
  )
  (func (param (ref null any)) (result (ref null any))
    (block (result (ref null $t)) (br_on_cast_fail 1 null $t (local.get 0)))
  )
)

(assert_invalid
  (module
    (type $t (struct))
    (func (param (ref any)) (result (ref any))
      (block (result (ref $t)) (br_on_cast_fail 1 null $t (local.get 0)))
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (type $t (struct))
    (func (param (ref null any)) (result (ref any))
      (block (result (ref $t)) (br_on_cast_fail 1 $t (local.get 0)))
    )
  )
  "type mismatch"
)

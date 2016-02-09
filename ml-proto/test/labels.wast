(module
  (func $block (result i32)
    (block $exit
      (br $exit (i32.const 1))
      (i32.const 0)
    )
  )

  (func $loop1 (result i32)
    (local $i i32)
    (set_local $i (i32.const 0))
    (loop $exit $cont
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (if (i32.eq (get_local $i) (i32.const 5))
        (br $exit (get_local $i))
      )
      (br $cont)
    )
  )

  (func $loop2 (result i32)
    (local $i i32)
    (set_local $i (i32.const 0))
    (loop $exit $cont
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (if (i32.eq (get_local $i) (i32.const 5))
        (br $cont)
      )
      (if (i32.eq (get_local $i) (i32.const 8))
        (br $exit (get_local $i))
      )
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (br $cont)
    )
  )

  (func $loop3 (result i32)
    (local $i i32)
    (set_local $i (i32.const 0))
    (loop $exit $cont
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (if (i32.eq (get_local $i) (i32.const 5))
        (br $exit (get_local $i))
      )
      (get_local $i)
    )
  )

  (func $loop4 (param $max i32) (result i32)
    (local $i i32)
    (set_local $i (i32.const 1))
    (loop $exit $cont
      (set_local $i (i32.add (get_local $i) (get_local $i)))
      (if (i32.gt_u (get_local $i) (get_local $max))
        (br $exit (get_local $i))
      )
      (br $cont)
    )
  )

  (func $loop5 (result i32)
    (i32.add (loop $l0 $l1
               (i32.const 1)
             )
             (i32.const 1)
    )
  )

  (func $switch (param i32) (result i32)
    (block $ret
      (i32.mul (i32.const 10)
        (tableswitch $exit (get_local 0)
          (table (case $0) (case $1) (case $2) (case $3)) (case $default)
          (case $1 (i32.const 1))
          (case $2 (br $exit (i32.const 2)))
          (case $3 (br $ret (i32.const 3)))
          (case $default (i32.const 4))
          (case $0 (i32.const 5))
        )
      )
    )
  )

  (func $return (param i32) (result i32)
    (tableswitch (get_local 0)
      (table (case $0) (case $1)) (case $default)
      (case $0 (return (i32.const 0)))
      (case $1 (i32.const 1))
      (case $default (i32.const 2))
    )
  )

  (func $br_if0 (result i32)
    (local $i i32)
    (set_local $i (i32.const 0))
    (block $outer
      (block $inner
        (br_if $inner (i32.const 0))
        (set_local $i (i32.or (get_local $i) (i32.const 0x1)))
        (br_if $inner (i32.const 1))
        (set_local $i (i32.or (get_local $i) (i32.const 0x2)))
      )
      (br_if $outer (set_local $i (i32.or (get_local $i) (i32.const 0x4))) (i32.const 0))
      (set_local $i (i32.or (get_local $i) (i32.const 0x8)))
      (br_if $outer (set_local $i (i32.or (get_local $i) (i32.const 0x10))) (i32.const 1))
      (set_local $i (i32.or (get_local $i) (i32.const 0x20)))
    )
  )

  (func $br_if1 (result i32)
    (block $l0
      (br_if $l0 (block $l1 (br $l1 (i32.const 1))) (i32.const 1))
      (i32.const 1)))

  (func $br_if2 (result i32)
    (block $l0
      (if (i32.const 1)
        (br $l0
          (block $l1
            (br $l1 (i32.const 1)))))
      (i32.const 1)))

  (func $br_if3 (result i32)
    (local $i1 i32)
    (i32.add (block $l0
               (br_if $l0
                      (set_local $i1 (i32.const 1))
                      (set_local $i1 (i32.const 2)))
               (i32.const 0))
             (i32.const 0))
    (get_local $i1))

  (func $br_if4 (result f32)
    (block $l
      (br_if $l (f32.const 0) (i32.const 1))))

  (func $br_if5 (param i32) (result f32)
    (block $l
      (f32.neg
        (block $i
          (br_if $l (f32.const 3) (get_local 0))))))

  (func $br_if6
    (loop $l0 $l1
      (br $l0 (i32.const 0))))

  (func $br_if7
    (block $l0
      (br_if $l0 (nop) (i32.const 1))))

  (func $br_if8 (result i32)
    (block $l0
      (if_else (i32.const 1)
        (br $l0 (block $l1 (br $l1 (i32.const 1))))
        (block (block $l1 (br $l1 (i32.const 1))) (nop))
      )
    (i32.const 1)))

  (func $br_if9
    (block $l
      (f32.neg (br_if $l (f32.const 0) (i32.const 1)))))

  (func $misc1 (result i32)
   (block $l1 (i32.xor (br $l1 (i32.const 1)) (i32.const 2)))
  )

  (func $misc2 (result i32)
   (i32.xor (return (i32.const 1)) (i32.const 2))
  )

  (export "block" $block)
  (export "loop1" $loop1)
  (export "loop2" $loop2)
  (export "loop3" $loop3)
  (export "loop4" $loop4)
  (export "loop5" $loop5)
  (export "switch" $switch)
  (export "return" $return)
  (export "br_if0" $br_if0)
  (export "br_if1" $br_if1)
  (export "br_if2" $br_if2)
  (export "br_if3" $br_if3)
  (export "br_if4" $br_if4)
  (export "br_if5" $br_if5)
  (export "br_if6" $br_if6)
  (export "br_if7" $br_if7)
  (export "br_if8" $br_if8)
  (export "br_if9" $br_if9)
  (export "misc1" $misc1)
  (export "misc2" $misc2)
)

(assert_return (invoke "block") (i32.const 1))
(assert_return (invoke "loop1") (i32.const 5))
(assert_return (invoke "loop2") (i32.const 8))
(assert_return (invoke "loop3") (i32.const 1))
(assert_return (invoke "loop4" (i32.const 8)) (i32.const 16))
(assert_return (invoke "loop5") (i32.const 2))
(assert_return (invoke "switch" (i32.const 0)) (i32.const 50))
(assert_return (invoke "switch" (i32.const 1)) (i32.const 20))
(assert_return (invoke "switch" (i32.const 2)) (i32.const 20))
(assert_return (invoke "switch" (i32.const 3)) (i32.const 3))
(assert_return (invoke "switch" (i32.const 4)) (i32.const 50))
(assert_return (invoke "switch" (i32.const 5)) (i32.const 50))
(assert_return (invoke "return" (i32.const 0)) (i32.const 0))
(assert_return (invoke "return" (i32.const 1)) (i32.const 2))
(assert_return (invoke "return" (i32.const 2)) (i32.const 2))
(assert_return (invoke "br_if0") (i32.const 0x1d))
(assert_return (invoke "br_if1") (i32.const 1))
(assert_return (invoke "br_if2") (i32.const 1))
(assert_return (invoke "br_if3") (i32.const 2))
(assert_return (invoke "br_if4") (f32.const 0))
(assert_return (invoke "br_if5" (i32.const 0)) (f32.const -3))
(assert_return (invoke "br_if5" (i32.const 1)) (f32.const 3))
(assert_return (invoke "br_if6"))
(assert_return (invoke "br_if7"))
(assert_return (invoke "br_if8") (i32.const 1))
(assert_return (invoke "br_if9"))
(assert_return (invoke "misc1") (i32.const 1))
(assert_return (invoke "misc2") (i32.const 1))

(assert_invalid (module (func (block $l (f32.neg (br_if $l (i32.const 1))) (nop)))) "arity mismatch")

(assert_invalid (module (func (result i32) (block $l (br_if $l (f32.const 0) (i32.const 1))))) "type mismatch")
(assert_invalid (module (func (param i32) (result i32) (block $l (f32.neg (br_if $l (f32.const 0) (get_local 0)))))) "type mismatch")

;; br_if's own result type doesn't match the result type of the block it's in.
(assert_invalid (module
  (func (param i32) (result f32)
    (block $l
      (f32.convert_s/i32
        (block $i
          (br_if $l (f32.const 3) (get_local 0)))))))
  "type mismatch")

;; br_if's result value's type doesn't match the type of the destination block.
(assert_invalid (module
  (func (param i32) (result f32)
    (block $l
      (i32.trunc_s/f32
        (block $i
          (br_if $l (f32.const 3) (get_local 0)))))))
  "type mismatch")

;; br_if operand has incorrect type.
(assert_invalid (module
  (func (param i32) (result f32)
    (block $l
      (f32.neg
        (block $i
          (br_if $l (i32.const 3) (get_local 0)))))))
  "type mismatch")

;; Function return type is wrong.
(assert_invalid (module
  (func (param i32) (result i32)
    (block $l
      (f32.neg
        (block $i
          (br_if $l (f32.const 3) (get_local 0)))))))
  "type mismatch")

;; br_if result not used, but value's type doesn't match branched-to block.
(assert_invalid (module
  (func (param i32) (result i32)
    (block $l
      (br_if $l (f32.const 3) (get_local 0))
      (i32.const 0))))
  "type mismatch")

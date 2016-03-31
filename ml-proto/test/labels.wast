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
      (br0 $cont)
    )
  )

  (func $loop2 (result i32)
    (local $i i32)
    (set_local $i (i32.const 0))
    (loop $exit $cont
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (if (i32.eq (get_local $i) (i32.const 5))
        (br0 $cont)
      )
      (if (i32.eq (get_local $i) (i32.const 8))
        (br $exit (get_local $i))
      )
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (br0 $cont)
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
      (br0 $cont)
    )
  )

  (func $loop5 (result i32)
    (i32.add (loop $l0 $l1
               (i32.const 1)
             )
             (i32.const 1)
    )
  )

  (func $if (result i32)
    (local $i i32)
    (set_local $i (i32.const 0))
    (block
      (if
        (i32.const 1)
        (then $l (br0 $l) (set_local $i (i32.const 666)))
      )
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (if
        (i32.const 1)
        (then $l (br0 $l) (set_local $i (i32.const 666)))
        (else (set_local $i (i32.const 888)))
      )
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (if
        (i32.const 1)
        (then $l (br0 $l) (set_local $i (i32.const 666)))
        (else $l (set_local $i (i32.const 888)))
      )
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (if
        (i32.const 0)
        (then (set_local $i (i32.const 888)))
        (else $l (br0 $l) (set_local $i (i32.const 666)))
      )
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (if
        (i32.const 0)
        (then $l (set_local $i (i32.const 888)))
        (else $l (br0 $l) (set_local $i (i32.const 666)))
      )
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
    )
    (get_local $i)
  )

  (func $switch (param i32) (result i32)
    (block $ret
      (i32.mul (i32.const 10)
        (block $exit
          (block $0
            (block $default
              (block $3
                (block $2
                  (block $1
                    (br0_table $0 $1 $2 $3 $default (get_local 0))
                  ) ;; 1
                  (i32.const 1)
                ) ;; 2
                (br $exit (i32.const 2))
              ) ;; 3
              (br $ret (i32.const 3))
            ) ;; default
            (i32.const 4)
          ) ;; 0
          (i32.const 5)
        )
      )
    )
  )

  (func $return (param i32) (result i32)
    (block $default
      (block $1
        (block $0
          (br0_table $0 $1 (get_local 0))
          (br0 $default)
        ) ;; 0
        (return (i32.const 0))
      ) ;; 1
      (i32.const 1)
    ) ;; default
    (i32.const 2)
  )

  (func $br_if0 (result i32)
    (local $i i32)
    (set_local $i (i32.const 0))
    (block $outer
      (block $inner
        (br0_if $inner (i32.const 0))
        (set_local $i (i32.or (get_local $i) (i32.const 0x1)))
        (br0_if $inner (i32.const 1))
        (set_local $i (i32.or (get_local $i) (i32.const 0x2)))
      )
      (br_if $outer
        (set_local $i (i32.or (get_local $i) (i32.const 0x4))) (i32.const 0)
      )
      (set_local $i (i32.or (get_local $i) (i32.const 0x8)))
      (br_if $outer
        (set_local $i (i32.or (get_local $i) (i32.const 0x10))) (i32.const 1)
      )
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

  (func $misc1 (result i32)
   (block $l1 (i32.xor (br $l1 (i32.const 1)) (i32.const 2)))
  )

  (func $misc2 (result i32)
   (i32.xor (return (i32.const 1)) (i32.const 2))
  )

  (func $redefinition (result i32)
    (block $l1
      (i32.add (block $l1
                 (i32.const 2))
               (block $l1
                 (br $l1 (i32.const 3)))))
  )

  ;; Check that the return and break expression is equivalent to the
  ;; function top level and block fall-through expressions.

  ;; Supporting functions.
  (func $nop)
  (func $v1 (result i32)
    (i32.const 1))

  (func $nop1
    (nop))
  (func $nop1_return
    (return (nop)))
  (func $nop1_return0
    (return0))
  (func $nop1_block
    (block $top (nop)))
  (func $nop1_block_br
    (block $top (br $top (nop))))
  (func $nop1_block_br0
    (block $top (br0 $top)))

  (func $nop2
    (call $nop))
  (func $nop2_return
    (return (call $nop)))
  (func $nop2_block
    (block $top (call $nop)))
  (func $nop2_block_br
    (block $top (br $top (call $nop))))

  (func $nop3
    (i32.const 1))
  (func $nop3_return
    (return (i32.const 1)))
  (func $nop3_block
    (block $top (i32.const 1)))
  (func $nop3_block_br
    (block $top (br $top (i32.const 1))))

  (func $nop4
    (call $v1))
  (func $nop4_return
    (return (call $v1)))
  (func $nop4_block
    (block $top (call $v1)))
  (func $nop4_block_br
    (block $top (br $top (call $v1))))

  (func $nop_block_br_if
    (block $l1
      (br $l1 (if (i32.const 1) (i32.const 1)))))

  (func $loop_nop_br (result i32)
    (local $i i32)
    (set_local $i (i32.const 0))
    (loop $exit $cont
      (set_local $i (i32.add (get_local $i) (i32.const 1)))
      (if (i32.eq (get_local $i) (i32.const 5))
        (br $exit (get_local $i)))
      (br $cont (i32.const 1))))

  (func $nop_br0_if
    (block $l0 (br0_if $l0 (i32.const 1))))
  (func $nop_br_if
    (block $l0 (br_if $l0 (nop) (i32.const 1))))

  (func $misc_nop1 (result i32)
    (block $l0
      (if (i32.const 1)
	(br $l0 (block $l1 (br $l1 (i32.const 1))))
	(block (block $l1 (br $l1 (i32.const 1))) (nop)))
      (i32.const 1)))

  (export "block" $block)
  (export "loop1" $loop1)
  (export "loop2" $loop2)
  (export "loop3" $loop3)
  (export "loop4" $loop4)
  (export "loop5" $loop5)
  (export "if" $if)
  (export "switch" $switch)
  (export "return" $return)
  (export "br_if0" $br_if0)
  (export "br_if1" $br_if1)
  (export "br_if2" $br_if2)
  (export "br_if3" $br_if3)
  (export "misc1" $misc1)
  (export "misc2" $misc2)
  (export "redefinition" $redefinition)
  (export "nop1" $nop1)
  (export "nop1_return" $nop1_return)
  (export "nop1_return0" $nop1_return0)
  (export "nop1_block" $nop1_block)
  (export "nop1_block_br" $nop1_block_br)
  (export "nop1_block_br0" $nop1_block_br0)
  (export "nop2" $nop2)
  (export "nop2_return" $nop2_return)
  (export "nop2_block" $nop2_block)
  (export "nop2_block_br" $nop2_block_br)
  (export "nop3" $nop3)
  (export "nop3_return" $nop3_return)
  (export "nop3_block" $nop3_block)
  (export "nop3_block_br" $nop3_block_br)
  (export "nop4" $nop4)
  (export "nop4_return" $nop4_return)
  (export "nop4_block" $nop4_block)
  (export "nop4_block_br" $nop4_block_br)
  (export "nop_block_br_if" $nop_block_br_if)
  (export "loop_nop_br" $loop_nop_br)
  (export "nop_br0_if" $nop_br0_if)
  (export "nop_br_if" $nop_br_if)
  (export "misc_nop1" $misc_nop1)
)

(assert_return (invoke "block") (i32.const 1))
(assert_return (invoke "loop1") (i32.const 5))
(assert_return (invoke "loop2") (i32.const 8))
(assert_return (invoke "loop3") (i32.const 1))
(assert_return (invoke "loop4" (i32.const 8)) (i32.const 16))
(assert_return (invoke "loop5") (i32.const 2))
(assert_return (invoke "if") (i32.const 5))
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
(assert_return (invoke "misc1") (i32.const 1))
(assert_return (invoke "misc2") (i32.const 1))
(assert_return (invoke "redefinition") (i32.const 5))

(assert_return (invoke "nop1"))
(assert_return (invoke "nop1_return"))
(assert_return (invoke "nop1_return0"))
(assert_return (invoke "nop1_block"))
(assert_return (invoke "nop1_block_br"))
(assert_return (invoke "nop1_block_br0"))
(assert_return (invoke "nop2"))
(assert_return (invoke "nop2_return"))
(assert_return (invoke "nop2_block"))
(assert_return (invoke "nop2_block_br"))
(assert_return (invoke "nop3"))
(assert_return (invoke "nop3_return"))
(assert_return (invoke "nop3_block"))
(assert_return (invoke "nop3_block_br"))
(assert_return (invoke "nop4"))
(assert_return (invoke "nop4_return"))
(assert_return (invoke "nop4_block"))
(assert_return (invoke "nop4_block_br"))
(assert_return (invoke "nop_block_br_if"))
(assert_return (invoke "loop_nop_br") (i32.const 5))
(assert_return (invoke "nop_br0_if"))
(assert_return (invoke "nop_br_if"))
(assert_return (invoke "misc_nop1") (i32.const 1))

(assert_invalid (module (func (block $l (f32.neg (br0_if $l (i32.const 1))) (nop)))) "type mismatch")
(assert_invalid (module (func (result f32) (block $l (br_if $l (f32.const 0) (i32.const 1))))) "type mismatch")

(assert_invalid (module (func (result f32) (block $l (br_if $l (f32.const 0) (i32.const 1))))) "type mismatch")
(assert_invalid (module (func (result i32) (block $l (br_if $l (f32.const 0) (i32.const 1))))) "type mismatch")
(assert_invalid (module (func (block $l (f32.neg (br_if $l (f32.const 0) (i32.const 1)))))) "type mismatch")
(assert_invalid (module (func (param i32) (result i32) (block $l (f32.neg (br_if $l (f32.const 0) (get_local 0)))))) "type mismatch")
(assert_invalid (module (func (param i32) (result f32)
  (block $l (f32.neg (block $i (br_if $l (f32.const 3) (get_local 0)))))))
  "type mismatch")

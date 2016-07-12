(module
  (func $br (block (br 0)))
  (export "br" $br)

  (func $br_if (block (br_if 0 (i32.const 1))))
  (export "br_if" $br_if)

  (func $br_table (block (br_table 0 (i32.const 0))))
  (export "br_table" $br_table)
)

(assert_return (invoke "br"))
(assert_return (invoke "br_if"))
(assert_return (invoke "br_table"))

(assert_invalid
  (module (func (block (br 0 (nop)))))
  "type mismatch"
)

(assert_invalid
  (module (func (block (br_if 0 (nop) (i32.const 0)))))
  "type mismatch"
)

(assert_invalid
  (module (func (block (br_table 0 (nop) (i32.const 0)))))
  "type mismatch"
)


(module
  (func (export "br") (block (br 0)))
  (func (export "br_if") (block (br_if 0 (i32.const 1))))
  (func (export "br_table") (block (br_table 0 (i32.const 0))))
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


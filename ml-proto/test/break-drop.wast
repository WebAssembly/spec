(module
  (export "br" (func(block (br 0))))
  (export "br_if" (func(block (br_if 0 (i32.const 1)))))
  (export "br_table" (func(block (br_table 0 (i32.const 0)))))
)

(assert_return (invoke "br"))
(assert_return (invoke "br_if"))
(assert_return (invoke "br_table"))

(assert_invalid
  (module (func (block (br 0 (nop)))))
  "arity mismatch"
)

(assert_invalid
  (module (func (block (br_if 0 (nop) (i32.const 0)))))
  "arity mismatch"
)

(assert_invalid
  (module (func (block (br_table 0 (nop) (i32.const 0)))))
  "arity mismatch"
)


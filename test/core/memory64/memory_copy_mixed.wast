;; Valid cases
(module
  (memory $m32 1 1)
  (memory $m64 i64 1 1)

  (func (export "test32")
    (memory.copy $m32 $m32 (i32.const 13) (i32.const 2) (i32.const 3)))

  (func (export "test64")
    (memory.copy $m64 $m64 (i64.const 13) (i64.const 2) (i64.const 3)))

  (func (export "test_64to32")
    (memory.copy $m32 $m64 (i32.const 13) (i64.const 2) (i32.const 3)))

  (func (export "test_32to64")
    (memory.copy $m64 $m32 (i64.const 13) (i32.const 2) (i32.const 3)))
)

;; Invalid cases
(assert_invalid (module
  (memory $m32 1 1)
  (memory $m64 i64 1 1)

  (func (export "bad_size_arg")
    (memory.copy $m32 $m64 (i32.const 13) (i64.const 2) (i64.const 3)))
  )
  "type mismatch"
)

(assert_invalid (module
  (memory $m32 1 1)
  (memory $m64 i64 1 1)

  (func (export "bad_src_idx")
    (memory.copy $m32 $m64 (i32.const 13) (i32.const 2) (i32.const 3)))
  )
  "type mismatch"
)

(assert_invalid (module
  (memory $m32 1 1)
  (memory $m64 i64 1 1)

  (func (export "bad_dst_idx")
    (memory.copy $m32 $m64 (i64.const 13) (i64.const 2) (i32.const 3)))
  )
  "type mismatch"
)

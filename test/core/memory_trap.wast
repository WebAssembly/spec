(module
    (memory 1)

    (func $addr_limit (result i32)
      (i32.mul (current_memory) (i32.const 0x10000))
    )

    (func (export "store") (param $i i32) (param $v i32)
      (i32.store (i32.add (call $addr_limit) (get_local $i)) (get_local $v))
    )

    (func (export "load") (param $i i32) (result i32)
      (i32.load (i32.add (call $addr_limit) (get_local $i)))
    )

    (func (export "grow_memory") (param i32) (result i32)
      (grow_memory (get_local 0))
    )
)

(assert_return (invoke "store" (i32.const -4) (i32.const 42)))
(assert_return (invoke "load" (i32.const -4)) (i32.const 42))
(assert_trap (invoke "store" (i32.const -3) (i32.const 13)) "out of bounds memory access")
(assert_trap (invoke "load" (i32.const -3)) "out of bounds memory access")
(assert_trap (invoke "store" (i32.const -2) (i32.const 13)) "out of bounds memory access")
(assert_trap (invoke "load" (i32.const -2)) "out of bounds memory access")
(assert_trap (invoke "store" (i32.const -1) (i32.const 13)) "out of bounds memory access")
(assert_trap (invoke "load" (i32.const -1)) "out of bounds memory access")
(assert_trap (invoke "store" (i32.const 0) (i32.const 13)) "out of bounds memory access")
(assert_trap (invoke "load" (i32.const 0)) "out of bounds memory access")
(assert_trap (invoke "store" (i32.const 0x80000000) (i32.const 13)) "out of bounds memory access")
(assert_trap (invoke "load" (i32.const 0x80000000)) "out of bounds memory access")
(assert_return (invoke "grow_memory" (i32.const 0x10001)) (i32.const -1))


(module
  (memory 1)

  (func (export "i32.store16") (param $a i32) (param $v i32)
    (i32.store16 (get_local $a) (get_local $v))
  )
  (func (export "i32.store") (param $a i32) (param $v i32)
    (i32.store (get_local $a) (get_local $v))
  )
  (func (export "i64.store16") (param $a i32) (param $v i64)
    (i64.store16 (get_local $a) (get_local $v))
  )
  (func (export "i64.store32") (param $a i32) (param $v i64)
    (i64.store32 (get_local $a) (get_local $v))
  )
  (func (export "i64.store") (param $a i32) (param $v i64)
    (i64.store (get_local $a) (get_local $v))
  )

  (func (export "i64.load") (param $a i32) (result i64)
    (i64.load (get_local $a))
  )
)

(assert_trap
  (invoke "i32.store16" (i32.const 0xffff) (i32.const 0x01234567))
  "out of bounds memory access"
)
(assert_trap
  (invoke "i32.store" (i32.const 0xffff) (i32.const 0x01234567))
  "out of bounds memory access"
)
(assert_trap
  (invoke "i32.store" (i32.const 0xfffe) (i32.const 0x01234567))
  "out of bounds memory access"
)
(assert_trap
  (invoke "i32.store" (i32.const 0xfffd) (i32.const 0x01234567))
  "out of bounds memory access"
)

(assert_trap
  (invoke "i64.store16" (i32.const 0xffff) (i64.const 0x0123456701234567))
  "out of bounds memory access"
)
(assert_trap
  (invoke "i64.store32" (i32.const 0xffff) (i64.const 0x0123456701234567))
  "out of bounds memory access"
)
(assert_trap
  (invoke "i64.store32" (i32.const 0xfffe) (i64.const 0x0123456701234567))
  "out of bounds memory access"
)
(assert_trap
  (invoke "i64.store32" (i32.const 0xfffd) (i64.const 0x0123456701234567))
  "out of bounds memory access"
)
(assert_trap
  (invoke "i64.store" (i32.const 0xffff) (i64.const 0x0123456701234567))
  "out of bounds memory access"
)
(assert_trap
  (invoke "i64.store" (i32.const 0xfffe) (i64.const 0x0123456701234567))
  "out of bounds memory access"
)
(assert_trap
  (invoke "i64.store" (i32.const 0xfffd) (i64.const 0x0123456701234567))
  "out of bounds memory access"
)
(assert_trap
  (invoke "i64.store" (i32.const 0xfffc) (i64.const 0x0123456701234567))
  "out of bounds memory access"
)
(assert_trap
  (invoke "i64.store" (i32.const 0xfffb) (i64.const 0x0123456701234567))
  "out of bounds memory access"
)
(assert_trap
  (invoke "i64.store" (i32.const 0xfffa) (i64.const 0x0123456701234567))
  "out of bounds memory access"
)
(assert_trap
  (invoke "i64.store" (i32.const 0xfff9) (i64.const 0x0123456701234567))
  "out of bounds memory access"
)

;; No memory was changed
(assert_return (invoke "i64.load" (i32.const 0xfff8)) (i64.const 0))

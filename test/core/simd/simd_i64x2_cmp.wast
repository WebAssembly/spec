
;; Test all the i64x2 comparison operators on major boundary values and all special values.

(module
  (func (export "eq") (param $x v128) (param $y v128) (result v128) (i64x2.eq (local.get $x) (local.get $y)))
  (func (export "ne") (param $x v128) (param $y v128) (result v128) (i64x2.ne (local.get $x) (local.get $y)))
)


;; eq

;; i64x2.eq  (i64x2) (i64x2)
(assert_return (invoke "eq" (v128.const i64x2 0xFFFFFFFFFFFFFFFF 0xFFFFFFFFFFFFFFFF)
                            (v128.const i64x2 0xFFFFFFFFFFFFFFFF 0xFFFFFFFFFFFFFFFF))
                            (v128.const i64x2 -1 -1))
(assert_return (invoke "eq" (v128.const i64x2 0x0000000000000000 0x0000000000000000)
                            (v128.const i64x2 0x0000000000000000 0x0000000000000000))
                            (v128.const i64x2 -1 -1))
(assert_return (invoke "eq" (v128.const i64x2 0xF0F0F0F0F0F0F0F0 0xF0F0F0F0F0F0F0F0)
                            (v128.const i64x2 0xF0F0F0F0F0F0F0F0 0xF0F0F0F0F0F0F0F0))
                            (v128.const i64x2 -1 -1))
(assert_return (invoke "eq" (v128.const i64x2 0x0F0F0F0F0F0F0F0F 0x0F0F0F0F0F0F0F0F)
                            (v128.const i64x2 0x0F0F0F0F0F0F0F0F 0x0F0F0F0F0F0F0F0F))
                            (v128.const i64x2 -1 -1))
(assert_return (invoke "eq" (v128.const i64x2 0xFFFFFFFFFFFFFFFF 0x0000000000000000)
                            (v128.const i64x2 0xFFFFFFFFFFFFFFFF 0x0000000000000000))
                            (v128.const i64x2 -1 -1))
(assert_return (invoke "eq" (v128.const i64x2 0x0000000000000000 0xFFFFFFFFFFFFFFFF)
                            (v128.const i64x2 0x0000000000000000 0xFFFFFFFFFFFFFFFF))
                            (v128.const i64x2 -1 -1))
(assert_return (invoke "eq" (v128.const i64x2 0x03020100 0x11100904)
                            (v128.const i64x2 0x03020100 0x11100904))
                            (v128.const i64x2 -1 -1))
(assert_return (invoke "eq" (v128.const i64x2 0xFFFFFFFFFFFFFFFF 0xFFFFFFFFFFFFFFFF)
                            (v128.const i64x2 0x0FFFFFFFFFFFFFFF 0x0FFFFFFFFFFFFFFF))
                            (v128.const i64x2 0 0))
(assert_return (invoke "eq" (v128.const i64x2 0x1 0x1)
                            (v128.const i64x2 0x2 0x2))
                            (v128.const i64x2 0 0))

;; ne

;; i64x2.ne  (i64x2) (i64x2)

;; hex vs hex
(assert_return (invoke "ne" (v128.const i64x2 0xFFFFFFFF 0xFFFFFFFF)
                            (v128.const i64x2 0xFFFFFFFF 0xFFFFFFFF))
                            (v128.const i64x2 0 0))
(assert_return (invoke "ne" (v128.const i64x2 0x00000000 0x00000000)
                            (v128.const i64x2 0x00000000 0x00000000))
                            (v128.const i64x2 0 0))
(assert_return (invoke "ne" (v128.const i64x2 0xF0F0F0F0 0xF0F0F0F0)
                            (v128.const i64x2 0xF0F0F0F0 0xF0F0F0F0))
                            (v128.const i64x2 0 0))
(assert_return (invoke "ne" (v128.const i64x2 0x0F0F0F0F 0x0F0F0F0F)
                            (v128.const i64x2 0x0F0F0F0F 0x0F0F0F0F))
                            (v128.const i64x2 0 0))
(assert_return (invoke "ne" (v128.const i64x2 0xFFFFFFFF 0x00000000)
                            (v128.const i64x2 0xFFFFFFFF 0x00000000))
                            (v128.const i64x2 0 0))
(assert_return (invoke "ne" (v128.const i64x2 0x00000000 0xFFFFFFFF)
                            (v128.const i64x2 0x00000000 0xFFFFFFFF))
                            (v128.const i64x2 0 0))
(assert_return (invoke "ne" (v128.const i64x2 0x03020100 0x11100904)
                            (v128.const i64x2 0x03020100 0x11100904))
                            (v128.const i64x2 0 0))

;; Type check

(assert_invalid (module (func (result v128) (i64x2.eq (i32.const 0) (f32.const 0)))) "type mismatch")
(assert_invalid (module (func (result v128) (i64x2.ne (i32.const 0) (f32.const 0)))) "type mismatch")

;; Test operation with empty argument

(assert_invalid
  (module
    (func $i64x2.eq-1st-arg-empty (result v128)
      (i64x2.eq (v128.const i64x2 0 0))
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (func $i64x2.eq-arg-empty (result v128)
      (i64x2.eq)
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (func $i64x2.ne-1st-arg-empty (result v128)
      (i64x2.ne (v128.const i64x2 0 0))
    )
  )
  "type mismatch"
)
(assert_invalid
  (module
    (func $i64x2.ne-arg-empty (result v128)
      (i64x2.ne)
    )
  )
  "type mismatch"
)
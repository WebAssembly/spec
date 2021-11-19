;; From wasmtime misc_testsuite/multi-memory/simple.wast

;; Should be replaced with suitable extensions to ../meta/generate_memory_*.js

(module
  (memory $mem1 1)
  (memory $mem2 1)

  (func (export "init1") (result i32)
    (memory.init $mem1 $d (i32.const 1) (i32.const 0) (i32.const 4))
    (i32.load $mem1 (i32.const 1))
  )

  (func (export "init2") (result i32)
    (memory.init $mem2 $d (i32.const 1) (i32.const 4) (i32.const 4))
    (i32.load $mem2 (i32.const 1))
  )

  (data $d "\01\00\00\00" "\02\00\00\00")
)

(assert_return (invoke "init1") (i32.const 1))
(assert_return (invoke "init2") (i32.const 2))


(module
  (memory $mem1 1)
  (memory $mem2 1)

  (func (export "fill1") (result i32)
    (memory.fill $mem1 (i32.const 1) (i32.const 0x01) (i32.const 4))
    (i32.load $mem1 (i32.const 1))
  )

  (func (export "fill2") (result i32)
    (memory.fill $mem2 (i32.const 1) (i32.const 0x02) (i32.const 2))
    (i32.load $mem2 (i32.const 1))
  )
)

(assert_return (invoke "fill1") (i32.const 0x01010101))
(assert_return (invoke "fill2") (i32.const 0x0202))


;; Test syntax for load/store_lane immediates

(module
  (memory 1)
  (memory $m 1)

  (func
    (local $v v128)

    (drop (v128.load8_lane 1 (i32.const 0) (local.get $v)))
    (drop (v128.load8_lane 1 offset=0 1 (i32.const 0) (local.get $v)))
    (drop (v128.load8_lane 1 offset=0 align=1 1 (i32.const 0) (local.get $v)))
    (drop (v128.load8_lane 1 align=1 1 (i32.const 0) (local.get $v)))

    (drop (v128.load8_lane $m 1 (i32.const 0) (local.get $v)))
    (drop (v128.load8_lane $m offset=0 1 (i32.const 0) (local.get $v)))
    (drop (v128.load8_lane $m offset=0 align=1 1 (i32.const 0) (local.get $v)))
    (drop (v128.load8_lane $m align=1 1 (i32.const 0) (local.get $v)))

    (drop (v128.load8_lane 1 1 (i32.const 0) (local.get $v)))
    (drop (v128.load8_lane 1 offset=0 1 (i32.const 0) (local.get $v)))
    (drop (v128.load8_lane 1 offset=0 align=1 1 (i32.const 0) (local.get $v)))
    (drop (v128.load8_lane 1 align=1 1 (i32.const 0) (local.get $v)))

    (v128.store8_lane 1 (i32.const 0) (local.get $v))
    (v128.store8_lane offset=0 1 (i32.const 0) (local.get $v))
    (v128.store8_lane offset=0 align=1 1 (i32.const 0) (local.get $v))
    (v128.store8_lane align=1 1 (i32.const 0) (local.get $v))

    (v128.store8_lane $m 1 (i32.const 0) (local.get $v))
    (v128.store8_lane $m offset=0 1 (i32.const 0) (local.get $v))
    (v128.store8_lane $m offset=0 align=1 1 (i32.const 0) (local.get $v))
    (v128.store8_lane $m align=1 1 (i32.const 0) (local.get $v))

    (v128.store8_lane 1 1 (i32.const 0) (local.get $v))
    (v128.store8_lane 1 offset=0 1 (i32.const 0) (local.get $v))
    (v128.store8_lane 1 offset=0 align=1 1 (i32.const 0) (local.get $v))
    (v128.store8_lane 1 align=1 1 (i32.const 0) (local.get $v))
  )
)

(module
    (memory 100)

    (export "store" $store)
    (func $store (param $i i32) (param $v i32) (result i32) (i32.store (i32.add (memory_size) (get_local $i)) (get_local $v)))

    (export "load" $load)
    (func $load (param $i i32) (result i32) (i32.load (i32.add (memory_size) (get_local $i))))

    (export "grow_memory" $grow_memory)
    (func $grow_memory (param $i i32) (grow_memory (get_local $i)))

    (export "overflow_memory_size" $overflow_memory_size)
    (func $overflow_memory_size
      (grow_memory (i32.xor (i32.const -1) (i32.sub (i32.const 0x10000) (i32.const 1))))
    )
)

(assert_return (invoke "store" (i32.const -4) (i32.const 42)) (i32.const 42))
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
(assert_trap (invoke "grow_memory" (i32.const 3)) "growing memory by non-multiple of page size")
(assert_trap (invoke "overflow_memory_size") "memory size exceeds implementation limit")

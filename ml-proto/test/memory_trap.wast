(module
    (memory 100)

    (export "store" $store)
    (func $store (param $i i32) (param $v i32) (i32.store (i32.add (memory_size) (get_local $i)) (get_local $v)))
  
    (export "load" $load)
    (func $load (param $i i32) (result i32) (i32.load (i32.add (memory_size) (get_local $i))))
)

(invoke "store" (i32.const -4) (i32.const 42))
(assert_return (invoke "load" (i32.const -4)) (i32.const 42))
(assert_trap (invoke "store" (i32.const -3) (i32.const 13)) "runtime: out of bounds memory access")
(assert_trap (invoke "load" (i32.const -3)) "runtime: out of bounds memory access")
(assert_trap (invoke "store" (i32.const -2) (i32.const 13)) "runtime: out of bounds memory access")
(assert_trap (invoke "load" (i32.const -2)) "runtime: out of bounds memory access")
(assert_trap (invoke "store" (i32.const -1) (i32.const 13)) "runtime: out of bounds memory access")
(assert_trap (invoke "load" (i32.const -1)) "runtime: out of bounds memory access")
(assert_trap (invoke "store" (i32.const 0) (i32.const 13)) "runtime: out of bounds memory access")
(assert_trap (invoke "load" (i32.const 0)) "runtime: out of bounds memory access")

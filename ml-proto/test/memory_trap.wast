(module
    (memory 100)

    (export "store" $store)
    (func $store (param $i i32) (param $v i32) (i32.store (get_local $i) (get_local $v)))

    (export "load" $load)
    (func $load (param $i i32) (result i32) (i32.load (get_local $i)))
)

(invoke "store" (i32.const 96) (i32.const 42))
(assert_return (invoke "load" (i32.const 96)) (i32.const 42))
(assert_trap (invoke "store" (i32.const 97) (i32.const 13)) "runtime: out of bounds memory access")
(assert_trap (invoke "load" (i32.const 97)) "runtime: out of bounds memory access")
(assert_trap (invoke "store" (i32.const 98) (i32.const 13)) "runtime: out of bounds memory access")
(assert_trap (invoke "load" (i32.const 98)) "runtime: out of bounds memory access")
(assert_trap (invoke "store" (i32.const 99) (i32.const 13)) "runtime: out of bounds memory access")
(assert_trap (invoke "load" (i32.const 99)) "runtime: out of bounds memory access")

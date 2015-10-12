(module
    (memory 4096)

    (export "load" $load)
    (func $load (param $i i32) (result i32) (i32.load (get_local $i)))

    (export "store" $store)
    (func $store (param $i i32) (param $v i32) (result i32) (i32.store (get_local $i) (get_local $v)))

    (export "resize" $resize)
    (func $resize (param $sz i32) (resize_memory (get_local $sz)))

    (export "size" $size)
    (func $size (result i32) (memory_size))
)

(assert_return (invoke "size") (i32.const 4096))
(assert_return (invoke "store" (i32.const 0) (i32.const 42)) (i32.const 42))
(assert_return (invoke "load" (i32.const 0)) (i32.const 42))
(assert_trap (invoke "store" (i32.const 4096) (i32.const 42)) "runtime: out of bounds memory access")
(assert_trap (invoke "load" (i32.const 4096)) "runtime: out of bounds memory access")
(invoke "resize" (i32.const 8192))
(assert_return (invoke "size") (i32.const 8192))
(assert_return (invoke "load" (i32.const 0)) (i32.const 42))
(assert_return (invoke "load" (i32.const 4096)) (i32.const 0))
(assert_return (invoke "store" (i32.const 4096) (i32.const 43)) (i32.const 43))
(assert_return (invoke "load" (i32.const 4096)) (i32.const 43))
(invoke "resize" (i32.const 4096))
(assert_return (invoke "size") (i32.const 4096))
(assert_return (invoke "load" (i32.const 0)) (i32.const 42))
(assert_trap (invoke "store" (i32.const 4096) (i32.const 42)) "runtime: out of bounds memory access")
(assert_trap (invoke "load" (i32.const 4096)) "runtime: out of bounds memory access")

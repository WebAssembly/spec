(module
  (memory 0)
  (func (export "memory_grow") (param i32) (result i32) (memory.grow (get_local 0)))
  (func (export "memory_size") (result i32) (memory.size))
)

(assert_return (invoke "memory_size") (i32.const 0))
(assert_return (invoke "memory_grow" (i32.const 0)) (i32.const 0))
(assert_return (invoke "memory_size") (i32.const 0))
(assert_return (invoke "memory_grow" (i32.const 1)) (i32.const 0))
(assert_return (invoke "memory_size") (i32.const 1))

(module
  (memory 1)
  (func (export "grow") (param $m i32) (result i32) (memory.grow (get_local $m)))
  (func (export "size") (result i32) (memory.size))
)

(assert_return (invoke "size") (i32.const 1))
(assert_return (invoke "grow" (i32.const 65535)) (i32.const 1))
(assert_return (invoke "size") (i32.const 65536))
(assert_return (invoke "grow" (i32.const 1)) (i32.const -1))

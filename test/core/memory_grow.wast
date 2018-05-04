;; Test that newly allocated memory (program start and memory.grow) is zeroed

(module
  (memory 0)
  (func (export "grow") (param i32) (result i32)
    (memory.grow (get_local 0))
  )
  (func (export "new_allocate_memory_zero") (param i32 i32) (result i32)
    (local i32)
    (set_local 2 (i32.const 1))
    (block
      (loop
        (set_local 2 (i32.load8_u (get_local 0)))
        (br_if 1 (i32.ne (get_local 2) (i32.const 0)))
        (set_local 0 (i32.add (get_local 0) (i32.const 1)))
        (br_if 1 (i32.gt_u (get_local 0) (get_local 1)))
        (br 0)
      )
    )
    (get_local 2)
  )
)

(assert_return (invoke "grow" (i32.const 1)) (i32.const 0))
(assert_return (invoke "new_allocate_memory_zero" (i32.const 0) (i32.const 0xfffc)) (i32.const 0))

(module
  (func (export "fib") (param i32) (result i32)
    local.get 0
    i32.const 1
    i32.le_s
    if (result i32)
      local.get 0
    else
      local.get 0
      i32.const 1
      i32.sub
      call 0
      local.get 0
      i32.const 2
      i32.sub
      call 0
      i32.add
    end))

(assert_return (invoke "fib" (i32.const 10)) (i32.const 55))

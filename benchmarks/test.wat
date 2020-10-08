(module
  (type (;0;) (func (param i32)))
  (import "i" "import" (func (;0;) (type 0)))
  (memory (;0;) 1 1)
  (func $test (type 0)
    (local i32 i64 f64)
    loop
      local.get 1
      local.get 0
      i32.const 1
      i32.sub
      i32.eq
      if
        block
          local.get 2
          drop
          nop
          br 0
        end
        local.get 1
        call 0
      end
      local.get 1
      i32.const 1
      i32.add
      local.tee 1
      local.get 0
      i32.lt_u
      br_if 0
    end
    return
  )
  (export "test" (func $test))
)

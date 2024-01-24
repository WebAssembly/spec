(module
  (import "spectest" "print_i32" (func $print_i32 (param i32)))
  (global f32 (f32.const 1.4))
  (global f32 (f32.const 5.2))
  (global (mut i32) (i32.const 42))

  (table 3 funcref)
  (table 3 funcref)
  (table 3 funcref)

  (func $nop)
  (func $add (param i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.add
  )
  (func $sum (param i32) (result i32)
    local.get 0
    if (result i32)
      local.get 0
      local.get 0
      i32.const 1
      i32.sub
      call $sum
      i32.add
    else
      i32.const 0
    end
  )

  (func $return_frame (param i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.add
    return
    i32.const -1
    i32.add
  )

  (func $return_label (param i32 i32) (result i32)
    local.get 0
    local.get 1
    block (param i32 i32) (result i32)
      i32.add
      return
      br 1
    end
    i32.const -1
    i32.add
  )

  (func (export "binop") (result i32)
    i32.const 19
    i32.const 27
    i32.add
  )

  (func (export "testop") (result i32)
    i32.const 0
    i32.eqz
  )

  (func (export "relop_i32") (result i32)
    i32.const 1
    i32.const 3
    i32.gt_s
  )

  (func (export "relop_f32") (result i32)
    f32.const 1.4142135
    f32.const 3.1415926
    f32.gt
  )

  (func (export "nop") (result i64)
    i64.const 0
    nop
  )

  (func (export "drop") (result f64)
    f64.const 3.1
    f64.const 5.2
    drop
  )

  (func (export "select") (result f64)
    f64.const 1.7976931348623157E+308
    f64.const -0.0
    i32.const 0
    select
  )

  (func (export "local_set") (param i32 i32 i32) (result i32)
    local.get 2
    i32.const 1
    i32.add
    local.set 2
    local.get 2
  )

  (func (export "local_get") (param i32 i32 i32) (result i32)
    local.get 2
  )

  (func (export "local_tee") (param i32 i32 i32) (result i32)
    local.get 0
    local.tee 1
    local.get 1
    i32.add
  )

  (func (export "global_set") (result i32)
    global.get 2
    i32.const 1
    i32.add
    global.set 2
    global.get 2
  )

  (func (export "global_get1") (result f32)
    global.get 1
  )

  (func (export "global_get2") (result i32)
    global.get 2
  )

  (func (export "table_get") (result funcref)
    i32.const 1
    table.get 2
  )

  (func (export "call_nop") (result i32)
    i32.const 0
    call $nop
  )

  (func (export "call_add") (result i32)
    i32.const 1
    i32.const 2
    call $add
  )

  (func (export "call_sum") (result i32)
    i32.const 10
    call $sum
  )

  (func (export "call_add_return_frame") (result i32)
    i32.const 1
    i32.const 2
    call 3
  )

  (func (export "call_add_return_label") (result i32)
    i32.const 1
    i32.const 2
    call 4
  )

  (func (export "block") (result i32)
    i32.const 1
    i32.const 2
    block (param i32 i32) (result i32)
      i32.sub
    end
  )

  (func (export "br_zero") (result i32)
    i32.const 1
    block (param i32) (result i32)
      i32.const 32
      i32.const 42
      br 0
      i32.const 52
    end
    i32.const 1
    i32.add
  )

  (func (export "br_succ") (result i32)
    i32.const 1
    block (param i32) (result i32)
      i32.const 32
      block (param i32 i32) (result i32)
        i32.const 42
        br 1
        i32.const 52
      end
      drop
      i32.const 62
    end
    i32.const 1
    i32.add
  )

  (func (export "if_true") (result i32)
    i32.const 42
    i32.const 1
    if (param i32) (result i32)
      i32.const 2
      i32.add
    else
      i32.const 3
      i32.add
    end
  )

  (func (export "if_false") (result i32)
    i32.const 42
    i32.const 0
    if (param i32) (result i32)
      i32.const 2
      i32.add
    else
      i32.const 3
      i32.add
    end
  )

  (func (export "loop") (result i32)
    (block (result i32)
      i32.const 0
      (loop (param i32) (result i32)
        (if (result i32)
          (then i32.const 42 (br 2))
          (else i32.const 1 (br 1))
        )
      )
    )
  )

  (func $fib (export "fib") (param i32) (result i32)
    local.get 0
    i32.const 1
    i32.le_s
    if (result i32)
      local.get 0
    else
      local.get 0
      i32.const 1
      i32.sub
      call $fib
      local.get 0
      i32.const 2
      i32.sub
      call $fib
      i32.add
    end)

  (func $foo (param i32) (br 0))
  (func $check_exit (export "check_exit") (param i32) (result i32)
    (call $foo (i32.const 42))
    (call $print_i32 (local.get 0))
    (local.get 0)
  )
)


(assert_return (invoke "binop") (i32.const 46))
(assert_return (invoke "testop") (i32.const 1))
(assert_return (invoke "relop_i32") (i32.const 0))
(assert_return (invoke "relop_f32") (i32.const 0))
(assert_return (invoke "nop") (i64.const 0))
(assert_return (invoke "drop") (f64.const 3.1))
(assert_return (invoke "select") (f64.const -0.0))
(assert_return (invoke "local_set" (i32.const 3) (i32.const 0) (i32.const 7)) (i32.const 8))
(assert_return (invoke "local_get" (i32.const 3) (i32.const 0) (i32.const 7)) (i32.const 7))
(assert_return (invoke "local_tee" (i32.const 3) (i32.const 0) (i32.const 7)) (i32.const 6))
(assert_return (invoke "global_set") (i32.const 43))
(assert_return (invoke "global_get1") (f32.const 5.2))
(assert_return (invoke "global_get2") (i32.const 43))
(assert_return (invoke "table_get") (ref.null func))
(assert_return (invoke "call_nop") (i32.const 0))
(assert_return (invoke "call_add") (i32.const 3))
(assert_return (invoke "call_sum") (i32.const 55))
(assert_return (invoke "call_add_return_frame") (i32.const 3))
(assert_return (invoke "call_add_return_label") (i32.const 3))
(assert_return (invoke "block") (i32.const -1))
(assert_return (invoke "br_zero") (i32.const 43))
(assert_return (invoke "br_succ") (i32.const 43))
(assert_return (invoke "if_true") (i32.const 44))
(assert_return (invoke "if_false") (i32.const 45))
(assert_return (invoke "loop") (i32.const 42))
(assert_return (invoke "fib" (i32.const 10)) (i32.const 55))
(assert_return (invoke "check_exit" (i32.const 10)) (i32.const 10))

;;second module
(module (func (export "f")))
(assert_return (invoke "f"))

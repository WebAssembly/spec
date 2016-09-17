(module
  (func (export "fac-expr") (param $n i64) (result i64)
    (local $i i64)
    (local $res i64)
    (set_local $i (get_local $n))
    (set_local $res (i64.const 1))
    (block $done
      (loop $loop
        (if
          (i64.eq (get_local $i) (i64.const 0))
          (br $done)
          (block
            (set_local $res (i64.mul (get_local $i) (get_local $res)))
            (set_local $i (i64.sub (get_local $i) (i64.const 1)))
          )
        )
        (br $loop)
      )
    )
    (get_local $res)
  )

  (func (export "fac-stack") (param $n i64) (result i64)
    (local $i i64)
    (local $res i64)
    (get_local $n)
    (set_local $i)
    (i64.const 1)
    (set_local $res)
    (block $done
      (loop $loop
        (get_local $i)
        (i64.const 0)
        (i64.eq)
        (if
          (then (br $done))
          (else
            (get_local $i)
            (get_local $res)
            (i64.mul)
            (set_local $res)
            (get_local $i)
            (i64.const 1)
            (i64.sub)
            (set_local $i)
          )
        )
        (br $loop)
      )
    )
    (get_local $res)
  )

  (func (export "fac-stack-raw") (param $n i64) (result i64)
    (local $i i64)
    (local $res i64)
    get_local $n
    set_local $i
    i64.const 1
    set_local $res
    block $done
      loop $loop
        get_local $i
        i64.const 0
        i64.eq
        if
          br $done
        else
          get_local $i
          get_local $res
          i64.mul
          set_local $res
          get_local $i
          i64.const 1
          i64.sub
          set_local $i
        end
        br $loop
      end
    end
    get_local $res
  )

  (func (export "fac-mixed") (param $n i64) (result i64)
    (local $i i64)
    (local $res i64)
    (set_local $i (get_local $n))
    (set_local $res (i64.const 1))
    (block $done
      (loop $loop
        (i64.eq (get_local $i) (i64.const 0))
        (if
          (then (br $done))
          (else
            (i64.mul (get_local $i) (get_local $res))
            (set_local $res)
            (i64.sub (get_local $i) (i64.const 1))
            (set_local $i)
          )
        )
        (br $loop)
      )
    )
    (get_local $res)
  )

  (func (export "fac-mixed-raw") (param $n i64) (result i64)
    (local $i i64)
    (local $res i64)
    (set_local $i (get_local $n))
    (set_local $res (i64.const 1))
    block $done
      loop $loop
        (i64.eq (get_local $i) (i64.const 0))
        if
          br $done
        else
          (i64.mul (get_local $i) (get_local $res))
          set_local $res
          (i64.sub (get_local $i) (i64.const 1))
          set_local $i
        end
        br $loop
      end
    end
    get_local $res
  )
)

(assert_return (invoke "fac-expr" (i64.const 25)) (i64.const 7034535277573963776))
(assert_return (invoke "fac-stack" (i64.const 25)) (i64.const 7034535277573963776))
(assert_return (invoke "fac-mixed" (i64.const 25)) (i64.const 7034535277573963776))

;; from call.wast
(module
  (func (param i32 i32))
  (func $arity-nop-first (call 0 (nop) (i32.const 1) (i32.const 2)))
  (func $arity-nop-mid (call 0 (i32.const 1) (nop) (i32.const 2)))
  (func $arity-nop-last (call 0 (i32.const 1) (i32.const 2) (nop)))
)

;; from call_indirect.wast
(module
  (type (func (param i32 i32)))
  (table 0 anyfunc)
  (func $arity-nop-first
    (call_indirect 0 (nop) (i32.const 1) (i32.const 2) (i32.const 0))
  )
  (func $arity-nop-mid
    (call_indirect 0 (i32.const 1) (nop) (i32.const 2) (i32.const 0))
  )
  (func $arity-nop-last
    (call_indirect 0 (i32.const 1) (i32.const 2) (nop) (i32.const 0))
  )
)

;; from func.wast
(module (func $type-break-last-num-vs-void
  (i32.const 0) (br 0)
))

;; from loop.wast
(module (func $type-cont-num-vs-void
  (loop (i32.const 0) (br 0))
))
(module (func $type-cont-nested-num-vs-void
  (block (loop (i32.const 1) (loop (i32.const 1) (br 2)) (br 1)))
))

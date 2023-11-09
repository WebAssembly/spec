(module
  (type (;0;) (func (param i32)))
  (memory (;0;) 1 1)
  (func $dummy)
  (func $test1 (type 0)
    (local i32)
    local.get 1
    local.get 0
    i32.eq
    (@metadata.code.branch_hint "\00" ) if
      return
    end
    return
  )
  (func $test2 (type 0)
    (local i32)
    local.get 1
    local.get 0
    i32.eq
    (@metadata.code.branch_hint "\01" ) if
      return
    end
    return
  )
  (func (export "nested") (param i32 i32) (result i32)
    (@metadata.code.branch_hint "\00")
    (if (result i32) (local.get 0)
      (then
        (if (local.get 1) (then (call $dummy) (block) (nop)))
        (if (local.get 1) (then) (else (call $dummy) (block) (nop)))
        (@metadata.code.branch_hint "\01")
        (if (result i32) (local.get 1)
          (then (call $dummy) (i32.const 9))
          (else (call $dummy) (i32.const 10))
        )
      )
      (else
        (if (local.get 1) (then (call $dummy) (block) (nop)))
        (@metadata.code.branch_hint "\00")
        (if (local.get 1) (then) (else (call $dummy) (block) (nop)))
        (if (result i32) (local.get 1)
          (then (call $dummy) (i32.const 10))
          (else (call $dummy) (i32.const 11))
        )
      )
    )
  )
)

(assert_malformed_custom
  (module quote
    "(func $test2 (type 0)"
    "  (local i32)"
    "  local.get 1"
    "  local.get 0"
    "  i32.eq"
    "  (@metadata.code.branch_hint \"\\01\" )"
    "  (@metadata.code.branch_hint \"\\01\" )"
    "  if"
    "    return"
    "  end"
    "  return"
    ")"
  )
  "@metadata.code.branch_hint annotation: duplicate annotation"
)
(assert_malformed_custom
  (module quote
    "(module"
    "  (@metadata.code.branch_hint \"\\01\" )"
    "  (type (;0;) (func (param i32)))"
    "  (memory (;0;) 1 1)"
    "  (func $test (type 0)"
    "    (local i32)"
    "    local.get 1"
    "    local.get 0"
    "    i32.eq"
    "    return"
    "  )"
    ")"
  )
  "@metadata.code.branch_hint annotation: not in a function"
)

(assert_invalid_custom
  (module
    (type (;0;) (func (param i32)))
    (memory (;0;) 1 1)
    (func $test (type 0)
      (local i32)
      local.get 1
      local.get 0
      (@metadata.code.branch_hint "\01" )
      i32.eq
      return
    )
  )
  "@metadata.code.branch_hint annotation: invalid target"
)

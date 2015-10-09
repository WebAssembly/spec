(module 
  (import $write "stdio" "write" (param i32 i32))

  (memory 4096 4096 (segment 0 "hello, world!\0D\0A\00"))

  (func $print_hello
    (call_import $write (i32.const 0) (i32.const 15))
    (call_import $write (i32.const 4) (i32.const 2))
  )

  (export "print_hello" $print_hello)
)

(invoke "print_hello")
(module 
  (import $write "stdio" "write" (param i32 i32))

  (memory 4096 4096 (segment 0 "\89\50\4e\47\0d\0a\1a\0a\00"))

  (func $write_png_header
    (call_import $write (i32.const 0) (i32.const 9))
  )

  (export "write_png_header" $write_png_header)
)

(invoke "write_png_header")
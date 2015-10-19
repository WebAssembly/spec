(module 
    (import $print_i32 "stdio" "print" (param i32))
    (import $print_i64 "stdio" "print" (param i64))
    (import $print_i32_f32 "stdio" "print" (param i32 f32))
    (import $print_i64_f64 "stdio" "print" (param i64 f64))
    (func $print32 (param $i i32)
        (call_import $print_i32 (get_local $i))
        (call_import $print_i32_f32
            (i32.add (get_local $i) (i32.const 1))
            (f32.const 42)
        )
    )
    (func $print64 (param $i i64)
        (call_import $print_i64 (get_local $i))
        (call_import $print_i64_f64
            (i64.add (get_local $i) (i64.const 1))
            (f64.const 53)
        )
    )
    (func $init
        (invoke "print32" (i32.const 13))
        (invoke "print64" (i64.const 24))
    )
)


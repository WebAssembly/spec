(module
    (func $one (result i32) (i32.const 13))
    (export "one" $one)

    (func $two (param i32) (result i32) (i32.add (get_local 0) (i32.const 1)))
    (export "two" $two)

    (func $three (param $a i32) (result i32) (i32.sub (get_local 0) (i32.const 2)))
    (export "three" $three)

    (import $print "spectest" "print" (func_type (param i32)))
    (func $four (param i32) (call_import $print (get_local 0)))
    (export "four" $four)
)
(assert_return (invoke "one") (i32.const 13))
(assert_return (invoke "two" (i32.const 13)) (i32.const 14))
(assert_return (invoke "three" (i32.const 13)) (i32.const 11))
(invoke "four" (i32.const 83))

(module
    (table $t1 $t2 $t3 $u1 $u2 $t1 $t3)

    (func $t1 (result i32) (i32.const 1))
    (func $t2 (result i32) (i32.const 2))
    (func $t3 (result i32) (i32.const 3))
    (func $u1 (result i64) (i64.const 4))
    (func $u2 (result i64) (i64.const 5))

    (func $callt (param $i i32) (result i32)
        (call_indirect (func_type (param) (result i32)) (get_local $i))
    )
    (export "callt" $callt)

    (func $callu (param $i i32) (result i64)
        (call_indirect (func_type (param) (result i64)) (get_local $i))
    )
    (export "callu" $callu)
)

(assert_return (invoke "callt" (i32.const 0)) (i32.const 1))
(assert_return (invoke "callt" (i32.const 1)) (i32.const 2))
(assert_return (invoke "callt" (i32.const 2)) (i32.const 3))
(assert_trap   (invoke "callt" (i32.const 3)) "indirect call signature mismatch")
(assert_trap   (invoke "callt" (i32.const 4)) "indirect call signature mismatch")
(assert_return (invoke "callt" (i32.const 5)) (i32.const 1))
(assert_return (invoke "callt" (i32.const 6)) (i32.const 3))
(assert_trap   (invoke "callt" (i32.const 7)) "undefined table index 7")
(assert_trap   (invoke "callt" (i32.const 100)) "undefined table index 100")
(assert_trap   (invoke "callt" (i32.const -1)) "undefined table index -1")

(assert_trap   (invoke "callu" (i32.const 0)) "indirect call signature mismatch")
(assert_trap   (invoke "callu" (i32.const 1)) "indirect call signature mismatch")
(assert_trap   (invoke "callu" (i32.const 2)) "indirect call signature mismatch")
(assert_return (invoke "callu" (i32.const 3)) (i64.const 4))
(assert_return (invoke "callu" (i32.const 4)) (i64.const 5))
(assert_trap   (invoke "callu" (i32.const 5)) "indirect call signature mismatch")
(assert_trap   (invoke "callu" (i32.const 6)) "indirect call signature mismatch")
(assert_trap   (invoke "callu" (i32.const 7)) "undefined table index 7")
(assert_trap   (invoke "callu" (i32.const -1)) "undefined table index -1")

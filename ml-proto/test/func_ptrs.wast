(module
    (type    (func))                           ;; 0: void -> void
    (type $S (func))                           ;; 1: void -> void
    (type    (func (param)))                   ;; 2: void -> void
    (type    (func (result i32)))              ;; 3: void -> i32
    (type    (func (param) (result i32)))      ;; 4: void -> i32
    (type $T (func (param i32) (result i32)))  ;; 5: i32 -> i32
    (type $U (func (param i32)))               ;; 6: i32 -> void

    (func (type 0))
    (func (type $S))

    (func $one (type 4) (i32.const 13))
    (export "one" $one)

    (func $two (type $T) (i32.add (get_local 0) (i32.const 1)))
    (export "two" $two)

    ;; Both signature and parameters are allowed (and required to match)
    ;; since this allows the naming of parameters.
    (func $three (type $T) (param $a i32) (result i32) (i32.sub (get_local 0) (i32.const 2)))
    (export "three" $three)

    (import $print "stdio" "print" (type 6))
    (func $four (type $U) (call_import $print (get_local 0)))
    (export "four" $four)
)
(assert_return (invoke "one") (i32.const 13))
(assert_return (invoke "two" (i32.const 13)) (i32.const 14))
(assert_return (invoke "three" (i32.const 13)) (i32.const 11))
(invoke "four" (i32.const 83))

(assert_invalid (module (func (type 42))) "type index out of bounds")
(assert_invalid (module (import "stdio" "print" (type 43))) "type index out of bounds")

(module
  (memory 1)
  (data (i32.const 0) "abcdefghijklmnopqrstuvwxyz")

  (func (export "good1") (param $i i32) (result i32)
    (i32.load8_u offset=0 (get_local $i))  ;; 97 'a'
  )
  (func (export "good2") (param $i i32) (result i32)
    (i32.load8_u offset=1 (get_local $i))  ;; 98 'b'
  )
  (func (export "good3") (param $i i32) (result i32)
    (i32.load8_u offset=2 (get_local $i))  ;; 99 'c'
  )
  (func (export "good4") (param $i i32) (result i32)
    (i32.load8_u offset=25 (get_local $i)) ;; 122 'z'
  )

  (func (export "good5") (param $i i32) (result i32)
    (i32.load16_u offset=0 (get_local $i))          ;; 25185 'ab'
  )
  (func (export "good6") (param $i i32) (result i32)
    (i32.load16_u align=1 (get_local $i))           ;; 25185 'ab'
  )
  (func (export "good7") (param $i i32) (result i32)
    (i32.load16_u offset=1 align=1 (get_local $i))  ;; 25442 'bc'
  )
  (func (export "good8") (param $i i32) (result i32)
    (i32.load16_u offset=2 (get_local $i))          ;; 25699 'cd'
  )
  (func (export "good9") (param $i i32) (result i32)
    (i32.load16_u offset=25 align=1 (get_local $i)) ;; 122 'z\0'
  )

  (func (export "good10") (param $i i32) (result i32)
    (i32.load offset=0 (get_local $i))          ;; 1684234849 'abcd'
  )
  (func (export "good11") (param $i i32) (result i32)
    (i32.load offset=1 align=1 (get_local $i))  ;; 1701077858 'bcde'
  )
  (func (export "good12") (param $i i32) (result i32)
    (i32.load offset=2 align=2 (get_local $i))  ;; 1717920867 'cdef'
  )
  (func (export "good13") (param $i i32) (result i32)
    (i32.load offset=25 align=1 (get_local $i)) ;; 122 'z\0\0\0'
  )

  (func (export "bad") (param $i i32)
    (drop (i32.load offset=4294967295 (get_local $i)))
  )
)

(assert_return (invoke "good1" (i32.const 0)) (i32.const 97))
(assert_return (invoke "good2" (i32.const 0)) (i32.const 98))
(assert_return (invoke "good3" (i32.const 0)) (i32.const 99))
(assert_return (invoke "good4" (i32.const 0)) (i32.const 122))
(assert_return (invoke "good5" (i32.const 0)) (i32.const 25185))
(assert_return (invoke "good6" (i32.const 0)) (i32.const 25185))
(assert_return (invoke "good7" (i32.const 0)) (i32.const 25442))
(assert_return (invoke "good8" (i32.const 0)) (i32.const 25699))
(assert_return (invoke "good9" (i32.const 0)) (i32.const 122))
(assert_return (invoke "good10" (i32.const 0)) (i32.const 1684234849))
(assert_return (invoke "good11" (i32.const 0)) (i32.const 1701077858))
(assert_return (invoke "good12" (i32.const 0)) (i32.const 1717920867))
(assert_return (invoke "good13" (i32.const 0)) (i32.const 122))

(assert_return (invoke "good1" (i32.const 65507)) (i32.const 0))
(assert_return (invoke "good2" (i32.const 65507)) (i32.const 0))
(assert_return (invoke "good3" (i32.const 65507)) (i32.const 0))
(assert_return (invoke "good4" (i32.const 65507)) (i32.const 0))
(assert_return (invoke "good5" (i32.const 65507)) (i32.const 0))
(assert_return (invoke "good6" (i32.const 65507)) (i32.const 0))
(assert_return (invoke "good7" (i32.const 65507)) (i32.const 0))
(assert_return (invoke "good8" (i32.const 65507)) (i32.const 0))
(assert_return (invoke "good9" (i32.const 65507)) (i32.const 0))
(assert_return (invoke "good10" (i32.const 65507)) (i32.const 0))
(assert_return (invoke "good11" (i32.const 65507)) (i32.const 0))
(assert_return (invoke "good12" (i32.const 65507)) (i32.const 0))
(assert_return (invoke "good13" (i32.const 65507)) (i32.const 0))

(assert_return (invoke "good1" (i32.const 65508)) (i32.const 0))
(assert_return (invoke "good2" (i32.const 65508)) (i32.const 0))
(assert_return (invoke "good3" (i32.const 65508)) (i32.const 0))
(assert_return (invoke "good4" (i32.const 65508)) (i32.const 0))
(assert_return (invoke "good5" (i32.const 65508)) (i32.const 0))
(assert_return (invoke "good6" (i32.const 65508)) (i32.const 0))
(assert_return (invoke "good7" (i32.const 65508)) (i32.const 0))
(assert_return (invoke "good8" (i32.const 65508)) (i32.const 0))
(assert_return (invoke "good9" (i32.const 65508)) (i32.const 0))
(assert_return (invoke "good10" (i32.const 65508)) (i32.const 0))
(assert_return (invoke "good11" (i32.const 65508)) (i32.const 0))
(assert_return (invoke "good12" (i32.const 65508)) (i32.const 0))
(assert_trap (invoke "good13" (i32.const 65508)) "out of bounds memory access")

(assert_trap (invoke "bad" (i32.const 0)) "out of bounds memory access")
(assert_trap (invoke "bad" (i32.const 1)) "out of bounds memory access")

(assert_malformed
  (module quote
    "(memory 1)"
    "(func (drop (i32.load offset=4294967296 (i32.const 0))))"
  )
  "i32 constant"
)

;; Test that load/store addreses are full int32 (or int64)

(module
  (memory 1)
  (func (export "load") (param i32) (result i32) (i32.load (get_local 0)))
  (func (export "store") (param i32 i32) (i32.store (get_local 0) (get_local 1)))
)

(assert_return (invoke "load" (i32.const 0)) (i32.const 0))
(assert_return (invoke "store" (i32.const 0) (i32.const 0x80000000)))
(assert_return (invoke "load" (i32.const 0)) (i32.const 0x80000000))
(assert_return (invoke "store" (i32.const 0) (i32.const 0x80000001)))
(assert_return (invoke "load" (i32.const 0)) (i32.const 0x80000001))
(assert_return (invoke "store" (i32.const 0) (i32.const 0x80000002)))
(assert_return (invoke "load" (i32.const 0)) (i32.const 0x80000002))
(assert_return (invoke "store" (i32.const 0) (i32.const 4294967293)))
(assert_return (invoke "load" (i32.const 0)) (i32.const 4294967293))
(assert_return (invoke "store" (i32.const 0) (i32.const 4294967294)))
(assert_return (invoke "load" (i32.const 0)) (i32.const 4294967294))
(assert_return (invoke "store" (i32.const 0) (i32.const 4294967295)))
(assert_return (invoke "load" (i32.const 0)) (i32.const 4294967295))

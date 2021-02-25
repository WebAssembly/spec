;; Test syntax of struct types.

(module
  (type (struct))
  (type (struct (field)))
  (type (struct (field i8)))
  (type (struct (field i8 i8 i8 i8)))
  (type (struct (field $x1 i32) (field $y1 i32)))
  (type (struct (field i8 i16 i32 i64 f32 f64 anyref funcref (ref 0) (ref null 1))))
  (type (struct (field i32 i64 i8) (field) (field) (field (ref null i31) anyref)))
  (type (struct (field $x2 i32) (field f32 f64) (field $y2 i32)))
)


(assert_malformed
  (module quote
    "(type (struct (field $x i32) (field $x i32)))"
  )
  "duplicate field"
)
(assert_malformed
  (module quote
    "(type (struct (field $x i32)))"
    "(type (struct (field $x i32)))"
  )
  "duplicate field"
)

(assert_invalid
  (module
    (type (struct (field (mut (ref null 10)))))
  )
  "unknown type"
)


;; Test binding structure of struct types.

(module
  (type $s0 (struct (field (ref 0) (ref 1) (ref $s0) (ref $s1))))
  (type $s1 (struct (field (ref 0) (ref 1) (ref $s0) (ref $s1))))

  (func (param (ref $forward)))

  (type $forward (struct))
)

(assert_invalid
  (module (type (struct (field (ref 1)))))
  "unknown type"
)

(assert_invalid
  (module (func (param (ref 1))))
  "unknown type"
)


;; Test execution of basic struct insructions

(module
  (type $vec (struct (field f32) (field $y (mut f32)) (field $z f32)))

  (func $get_0 (param $v (ref $vec)) (result f32)
    (struct.get $vec 0 (local.get $v))
  )
  (func (export "get_0") (result f32)
    (call $get_0 (struct.new_default $vec (rtt.canon $vec)))
  )

  (func $set_get_y (param $v (ref $vec)) (param $y f32) (result f32)
    (struct.set $vec $y (local.get $v) (local.get $y))
    (struct.get $vec $y (local.get $v))
  )
  (func (export "set_get_y") (param $y f32) (result f32)
    (call $set_get_y (struct.new_default $vec (rtt.canon $vec)) (local.get $y))
  )

  (func $set_get_1 (param $v (ref $vec)) (param $y f32) (result f32)
    (struct.set $vec 1 (local.get $v) (local.get $y))
    (struct.get $vec $y (local.get $v))
  )
  (func (export "set_get_1") (param $y f32) (result f32)
    (call $set_get_1 (struct.new_default $vec (rtt.canon $vec)) (local.get $y))
  )
)

;;(assert_return (invoke "get_0") (f32.const 0))
;;(assert_return (invoke "set_get_y" (f32.const 7)) (f32.const 7))
;;(assert_return (invoke "set_get_1" (f32.const 7)) (f32.const 7))


;; Test null dereference.

(module
  (type $t (struct (field i32 (mut i32))))
  (func (export "struct.get-null")
    (local (ref null $t)) (drop (struct.get $t 1 (local.get 0)))
  )
  (func (export "struct.set-null")
    (local (ref null $t)) (struct.set $t 1 (local.get 0) (i32.const 0))
  )
)

;;(assert_trap (invoke "struct.get-null") "null dereference")
;;(assert_trap (invoke "struct.set-null") "null dereference")


;; Test static and dynamic equivalence of simple struct types

(module
  (type $vec1 (struct (field f32 f32 f32)))
  (type $vec2 (struct (field $x f32) (field $y f32) (field $z f32)))
  (type $func (func (param (ref $vec1)) (result f32)))

  (table funcref (elem $callee))

  (func $callee (param $v (ref $vec2)) (result f32)
    (struct.get $vec2 $x (local.get $v))
  )
  (func (export "call_indirect") (result f32)
    (call_indirect (type $func)
      (struct.new_default $vec2 (rtt.canon $vec2))
      (i32.const 0)
    )
  )
)

;;(assert_return (invoke "call_indirect") (f32.const 0))


;; Test static and dynamic equivalence of indirect struct types

(module
  (type $s0 (struct (field i32 f32)))
  (type $s1 (struct (field (ref $s0))))
  (type $s2 (struct (field (ref $s0))))
  (type $s3 (struct (field i32 (ref null $s1))))
  (type $s4 (struct (field i32 (ref null $s2))))
  (type $func (func (param (ref $s4)) (result i32)))

  (table funcref (elem $callee))

  (func $callee (param $v (ref $s3)) (result i32)
    (struct.get $s3 0 (local.get $v))
  )
  (func (export "call_indirect") (result i32)
    (call_indirect (type $func)
      (struct.new_default $s3 (rtt.canon $s3))
      (i32.const 0)
    )
  )
)

;;(assert_return (invoke "call_indirect") (i32.const 0))


;; Test static and dynamic equivalence of recursive struct types

(module
  (type $list1 (struct (field i32 (ref null $list1))))
  (type $list2 (struct (field i32 (ref null $list2))))
  (type $func (func (param (ref $list1)) (result i32)))

  (table funcref (elem $callee))

  (func $callee (param $v (ref $list2)) (result i32)
    (struct.get $list2 0 (local.get $v))
  )
  (func (export "call_indirect") (result i32)
    (call_indirect (type $func)
      (struct.new_default $list2 (rtt.canon $list2))
      (i32.const 0)
    )
  )
)

;;(assert_return (invoke "call_indirect") (i32.const 0))


;; Test static and dynamic equivalence of isomorphic recursive struct types

(module
  (type $list1 (struct (field i32 (ref null $list1))))
  (type $list2 (struct (field i32 (ref null $list3))))
  (type $list3 (struct (field i32 (ref null $list2))))
  (type $func (func (param (ref $list1)) (result i32)))

  (table funcref (elem $callee))

  (func $callee (param $v (ref $list2)) (result i32)
    (struct.get $list2 0 (local.get $v))
  )
  (func (export "call_indirect") (result i32)
    (call_indirect (type $func)
      (struct.new $list2 (i32.const 1) (ref.null $list1) (rtt.canon $list2))
      (i32.const 0)
    )
  )
)

;;(assert_return (invoke "call_indirect") (i32.const 0))


(module
  (type $list1 (struct (field i32 (ref null $list3))))
  (type $list2 (struct (field i32 (ref null $list2))))
  (type $list3 (struct (field i32 (ref null $list1))))
  (type $func (func (param (ref $list1)) (result i32)))

  (table funcref (elem $callee))

  (func $callee (param $v (ref $list2)) (result i32)
    (struct.get $list2 0 (local.get $v))
  )
  (func (export "call_indirect") (result i32)
    (call_indirect (type $func)
      (struct.new_default $list2 (rtt.canon $list2))
      (i32.const 0)
    )
  )
)

;;(assert_return (invoke "call_indirect") (i32.const 0))


(module
  (type $t1 (struct (field i32 (ref null $u1))))
  (type $u1 (struct (field f32 (ref null $t1))))
  (type $t2 (struct (field i32 (ref null $u3))))
  (type $u2 (struct (field f32 (ref null $t3))))
  (type $t3 (struct (field i32 (ref null $u2))))
  (type $u3 (struct (field f32 (ref null $t2))))
  (type $func (func (param (ref $t1)) (result i32)))

  (table funcref (elem $callee))

  (func $callee (param $v (ref $t2)) (result i32)
    (struct.get $t2 0 (local.get $v))
  )
  (func (export "call_indirect") (result i32)
    (call_indirect (type $func)
      (struct.new_default $t2 (rtt.canon $t2))
      (i32.const 0)
    )
  )
)

;;(assert_return (invoke "call_indirect") (i32.const 0))


;; Test link-time type equivalence

(module
  (type $vec (struct (field f32 f32 f32)))
  (func (export "f") (param (ref $vec)))
)
(register "M1")
(module
  (func (import "M1" "f") (param (ref $vec)))
  (type $vec (struct (field f32 f32 f32)))
)

(module
  (type $list (struct (field i32 (ref $list))))
  (func (export "f") (param (ref $list)))
)
(register "M2")
(module
  (type $list1 (struct (field i32 (ref $list2))))
  (type $list2 (struct (field i32 (ref $list1))))
  (func (import "M2" "f") (param (ref $list2)))
)

(module
  (type $list1 (struct (field i32 (ref $list2))))
  (type $list2 (struct (field i32 (ref $list1))))
  (func (export "f") (param (ref $list2)))
)
(register "M3")
(module
  (type $list (struct (field i32 (ref $list))))
  (func (import "M3" "f") (param (ref $list)))
)

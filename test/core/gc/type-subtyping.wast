;; Definitions

(module
  (type $e0 (array i32))
  (type $e1 (sub $e0 (array i32)))

  (type $e2 (array anyref))
  (type $e3 (sub (array (ref null $e0))))
  (type $e4 (sub (array (ref $e1))))

  (type $m1 (array (mut i32)))
  (type $m2 (sub $m1 (array (mut i32))))
)

(module
  (type $e0 (struct))
  (type $e1 (sub $e0 (struct)))
  (type $e2 (sub $e1 (struct (field i32))))
  (type $e3 (sub $e2 (struct (field i32 (ref null $e0)))))
  (type $e4 (sub $e3 (struct (field i32 (ref $e0) (mut i64)))))
  (type $e5 (sub $e4 (struct (field i32 (ref $e1) (mut i64)))))
)

(module
  (type $s (struct))
  (type $s' (sub $s (struct)))

  (type $f1 (func (param (ref $s')) (result anyref)))
  (type $f2 (sub $f1 (func (param (ref $s)) (result (ref any)))))
  (type $f3 (sub $f2 (func (param (ref null $s)) (result (ref $s)))))
  (type $f4 (sub $f3 (func (param (ref null data)) (result (ref $s')))))
)


;; Recursive definitions

(module
  (type $t (struct (field anyref)))
  (rec (type $r (sub $t (struct (field (ref $r))))))
  (type $t' (sub $r (struct (field (ref $r) i32))))
)

(module
  (rec
    (type $r1 (struct (field i32 (ref $r1))))
  )
  (rec
    (type $r2 (sub $r1 (struct (field i32 (ref $r3)))))
    (type $r3 (sub $r1 (struct (field i32 (ref $r2)))))
  )
)

(module
  (rec
    (type $a1 (struct (field i32 (ref $a2))))
    (type $a2 (struct (field i64 (ref $a1))))
  )
  (rec
    (type $b1 (sub $a2 (struct (field i64 (ref $a1) i32))))
    (type $b2 (sub $a1 (struct (field i32 (ref $a2) i32))))
    (type $b3 (sub $a2 (struct (field i64 (ref $b2) i32))))
  )
)


;; Subsumption

(module
  (rec
    (type $t1 (func (param i32 (ref $t3))))
    (type $t2 (sub $t1 (func (param i32 (ref $t2)))))
    (type $t3 (sub $t2 (func (param i32 (ref $t1)))))
  )

  (func $f1 (param $r (ref $t1))
    (call $f1 (local.get $r))
  )
  (func $f2 (param $r (ref $t2))
    (call $f1 (local.get $r))
    (call $f2 (local.get $r))
  )
  (func $f3 (param $r (ref $t3))
    (call $f1 (local.get $r))
    (call $f2 (local.get $r))
    (call $f3 (local.get $r))
  )
)

(module
  (rec
    (type $t1 (func (result i32 (ref $u1))))
    (type $u1 (func (result f32 (ref $t1))))
  )

  (rec
    (type $t2 (sub $t1 (func (result i32 (ref $u3)))))
    (type $u2 (sub $u1 (func (result f32 (ref $t3)))))
    (type $t3 (sub $t1 (func (result i32 (ref $u2)))))
    (type $u3 (sub $u1 (func (result f32 (ref $t2)))))
  )

  (func $f1 (param $r (ref $t1))
    (call $f1 (local.get $r))
  )
  (func $f2 (param $r (ref $t2))
    (call $f1 (local.get $r))
    (call $f2 (local.get $r))
  )
  (func $f3 (param $r (ref $t3))
    (call $f1 (local.get $r))
    (call $f3 (local.get $r))
  )
)


;; Runtime types

(module
  (rec (type $t1 (func (result (ref null $t1)))))
  (rec (type $t2 (sub $t1 (func (result (ref null $t2))))))

  (func $f1 (type $t1) (ref.null $t1))
  (func $f2 (type $t2) (ref.null $t2))
  (table funcref (elem $f1 $f2))

  (func (export "run")
    (block (result (ref null $t1)) (call_indirect (type $t1) (i32.const 0)))
    (block (result (ref null $t1)) (call_indirect (type $t1) (i32.const 0)))
    (block (result (ref null $t1)) (call_indirect (type $t1) (i32.const 1)))
    (block (result (ref null $t1)) (call_indirect (type $t1) (i32.const 1)))
    (block (result (ref null $t2)) (call_indirect (type $t2) (i32.const 1)))
    (block (result (ref null $t2)) (call_indirect (type $t2) (i32.const 1)))
    (br 0)
  )
)
(assert_return (invoke "run"))


;; Invalid subtyping definitions

(assert_invalid
  (module
    (type $a0 (array i32))
    (type $s0 (sub $a0 (struct)))
  )
  "sub type"
)

(assert_invalid 
  (module
    (type $f0 (func (param i32) (result i32)))
    (type $s0 (sub $f0 (struct)))
  )
  "sub type"
)

(assert_invalid
  (module
    (type $s0 (struct))
    (type $a0 (sub $s0 (array i32)))
  )
  "sub type"
)

(assert_invalid
  (module
    (type $f0 (func (param i32) (result i32)))
    (type $a0 (sub $f0 (array i32)))
  )
  "sub type"
)

(assert_invalid 
  (module
    (type $s0 (struct))
    (type $f0 (sub $s0 (func (param i32) (result i32))))
  )
  "sub type"
)

(assert_invalid 
  (module
    (type $a0 (array i32))
    (type $f0 (sub $a0 (func (param i32) (result i32))))
  )
  "sub type"
)

(assert_invalid
  (module
    (type $a0 (array i32))
    (type $a1 (sub $a0 (array i64)))
  )
  "sub type"
)

(assert_invalid
  (module
    (type $s0 (struct (field i32)))
    (type $s1 (sub $s0 (struct (field i64))))
  )
  "sub type"
)

(assert_invalid
  (module
    (type $f0 (func))
    (type $f1 (sub $f0 (func (param i32))))
  )
  "sub type"
)


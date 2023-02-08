(module $m1
  (global (export "g") i32 (i32.const 41))
  (func (export "f") (result i32) (i32.const 41))
  (func (export "inc") (param $x i32) (result i32)
    (i32.add (local.get $x) (i32.const 1))
  )
)

(module $m2
  (global (export "g") (mut i32) (i32.const 42))
  (func (export "f") (result i32) (i32.const 42))
  (func (export "add3") (param i32 i32 i32) (result i32)
    (i32.add (i32.add (local.get 0) (local.get 1)) (local.get 2))
  )
  (func (export "swap") (param i32 i32) (result i32 i32)
    (local.get 1) (local.get 0)
  )
  (func (export "nop"))
)

(assert_return (get "g") (i32.const 42))
(assert_return (get $m1 "g") (i32.const 41))
(assert_return (get $m2 "g") (i32.const 42))

(set "g" (i32.const 43))
(assert_return (set "g" (i32.const 43)))
(assert_return (get "g") (i32.const 43))
(set $m2 "g" (i32.const 44))
(assert_return (get "g") (i32.const 44))
(set "g" (invoke $m1 "inc" (get "g")))
(assert_return (get "g") (i32.const 45))

(assert_return (invoke "f") (i32.const 42))
(assert_return (invoke $m1 "f") (i32.const 41))
(assert_return (invoke $m2 "f") (i32.const 42))

(assert_return (invoke $m1 "inc" (i32.const 2)) (i32.const 3))
(assert_return (invoke $m1 "inc" (get $m1 "g")) (i32.const 42))
(assert_return (invoke $m1 "inc" (get $m2 "g")) (i32.const 46))
(assert_return (invoke $m1 "inc" (invoke $m1 "inc" (get "g"))) (i32.const 47))

(assert_return (invoke "add3" (get $m1 "g") (invoke $m1 "inc" (get "g")) (get "g")) (i32.const 132))
(assert_return (invoke "add3" (invoke "swap" (get $m1 "g") (invoke "nop") (invoke $m1 "inc" (get "g"))) (i32.const -20)) (i32.const 67))


(module
  (global (export "g-i32") i32 (i32.const 42))
  (global (export "g-i64") i64 (i64.const 42))
  (global (export "g-f32") f32 (f32.const 42))
  (global (export "g-f64") f64 (f64.const 42))
  (global (export "g-v128") v128 (v128.const i32x4 42 42 42 42))
  (global (export "g-funcref") funcref (ref.null func))
  (global (export "g-externref") externref (ref.null extern))

  (func (export "f-i32") (param i32) (result i32) (local.get 0))
  (func (export "f-i64") (param i64) (result i64) (local.get 0))
  (func (export "f-f32") (param f32) (result f32) (local.get 0))
  (func (export "f-f64") (param f64) (result f64) (local.get 0))
  (func (export "f-v128") (param v128) (result v128) (local.get 0))
  (func (export "f-funcref") (param funcref) (result funcref) (local.get 0))
  (func (export "f-externref") (param externref) (result externref) (local.get 0))
)

(assert_return (invoke "f-i32" (get "g-i32")) (i32.const 42))
(assert_return (invoke "f-i64" (get "g-i64")) (i64.const 42))
(assert_return (invoke "f-f32" (get "g-f32")) (f32.const 42))
(assert_return (invoke "f-f64" (get "g-f64")) (f64.const 42))
(assert_return (invoke "f-v128" (get "g-v128")) (v128.const i32x4 42 42 42 42))
(assert_return (invoke "f-funcref" (get "g-funcref")) (ref.null func))
(assert_return (invoke "f-externref" (get "g-externref")) (ref.null extern))


(module
  (global $g (export "g") (mut i32) (i32.const 1))
  (func (export "inc") (global.set $g (i32.add (global.get $g) (i32.const 1))))
  (func (export "get") (result i32) (global.get $g))
)

;; Left-to-right evaluation order
(assert_return
  (invoke "get"
    (set "g" (i32.const 3))
    (invoke "inc")
    (set "g" (invoke $m1 "inc" (get "g")))
    (invoke "inc")
  )
  (i32.const 6)
)

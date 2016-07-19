;; TODO: more tests

(module
  (global $x i32)
  (global f32 f64)
  (global $y i64)

  (func "get-x" (result i32) (get_global $x))
  (func "get-y" (result i64) (get_global $y))
  (func "set-x" (param i32) (set_global $x (get_local 0)))
  (func "set-y" (param i64) (set_global $y (get_local 0)))

  (func "get-1" (result f32) (get_global 1))
  (func "get-2" (result f64) (get_global 2))
  (func "set-1" (param f32) (set_global 1 (get_local 0)))
  (func "set-2" (param f64) (set_global 2 (get_local 0)))
)

(assert_return (invoke "get-x") (i32.const 0))
(assert_return (invoke "get-y") (i64.const 0))
(assert_return (invoke "get-1") (f32.const 0))
(assert_return (invoke "get-2") (f64.const 0))

(assert_return (invoke "set-x" (i32.const 6)))
(assert_return (invoke "set-y" (i64.const 7)))
(assert_return (invoke "set-1" (f32.const 8)))
(assert_return (invoke "set-2" (f64.const 9)))

(assert_return (invoke "get-x") (i32.const 6))
(assert_return (invoke "get-y") (i64.const 7))
(assert_return (invoke "get-1") (f32.const 8))
(assert_return (invoke "get-2") (f64.const 9))

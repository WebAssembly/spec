;; TODO: more tests

(module
  (global $x i32 (i32.const -2))
  (global f32 (f32.const -3))
  (global f64 (f64.const -4))
  (global $y i64 (i64.const -5))

  (export "get-x" (func (result i32) (get_global $x)))
  (export "get-y" (func (result i64) (get_global $y)))
  (export "set-x" (func (param i32) (set_global $x (get_local 0))))
  (export "set-y" (func (param i64) (set_global $y (get_local 0))))

  (export "get-1" (func (result f32) (get_global 1)))
  (export "get-2" (func (result f64) (get_global 2)))
  (export "set-1" (func (param f32) (set_global 1 (get_local 0))))
  (export "set-2" (func (param f64) (set_global 2 (get_local 0))))
)

(assert_return (invoke "get-x") (i32.const -2))
(assert_return (invoke "get-y") (i64.const -5))
(assert_return (invoke "get-1") (f32.const -3))
(assert_return (invoke "get-2") (f64.const -4))

(assert_return (invoke "set-x" (i32.const 6)))
(assert_return (invoke "set-y" (i64.const 7)))
(assert_return (invoke "set-1" (f32.const 8)))
(assert_return (invoke "set-2" (f64.const 9)))

(assert_return (invoke "get-x") (i32.const 6))
(assert_return (invoke "get-y") (i64.const 7))
(assert_return (invoke "get-1") (f32.const 8))
(assert_return (invoke "get-2") (f64.const 9))

(assert_invalid
  (module (global f32 (f32.neg (f32.const 0))))
  "constant expression required"
)

(assert_invalid
  (module (global f32 (get_local 0)))
  "constant expression required"
)

(assert_invalid
  (module (global i32 (f32.const 0)))
  "type mismatch"
)

(assert_invalid
  (module (global i32 (get_global 0)))
  "unknown global"
)

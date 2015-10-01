(module
  (func $eq_float32 (param $x f32) (param $y f32) (result i32)
    (f32.eq (get_local $x) (get_local $y))
  )

  (func $eq_float64 (param $x f64) (param $y f64) (result i32)
    (f64.eq (get_local $x) (get_local $y))
  )

  (func $div_float32 (param $x f32) (param $y f32) (result f32)
    (f32.div (get_local $x) (get_local $y))
  )

  (func $div_float64 (param $x f64) (param $y f64) (result f64)
    (f64.div (get_local $x) (get_local $y))
  )

  (export "eq_float32" $eq_float32)
  (export "eq_float64" $eq_float64)
  (export "div_float32" $div_float32)
  (export "div_float64" $div_float64)
)

(assert_eq
  (invoke "eq_float32"
    (f32.add (f32.const 1.1234567890) (f32.const 1.2345e-10))
    (f32.const 1.123456789)
  )
  (i32.const 1)
)

(assert_eq
  (invoke "eq_float64"
    (f64.add (f64.const 1.1234567890) (f64.const 1.2345e-10))
    (f64.const 1.123456789)
  )
  (i32.const 0)
)

(assert_eq
  (invoke "eq_float32"
    (f32.mul (f32.const 1e20) (f32.const 1e20))
    (f32.mul (f32.const 1e25) (f32.const 1e25))
  )
  (i32.const 1)
)

(assert_eq
  (invoke "eq_float64"
    (f64.mul (f64.const 1e20) (f64.const 1e20))
    (f64.mul (f64.const 1e25) (f64.const 1e25))
  )
  (i32.const 0)
)

(assert_eq
  (invoke "div_float32" (f32.const 1.123456789) (f32.const 100))
  (f32.const 0.011234568432)
)

(assert_eq
  (invoke "div_float64" (f64.const 1.123456789) (f64.const 100))
  (f64.const 0.01123456789)
)

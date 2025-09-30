(module
  (type $f1 (func))
  (tag $t (param i32))
  (func $throw
    (throw $t (i32.const 47))
  )
  (elem declare func $throw)
  (func (export "main") (param i32) (result i32)
    (try_table (catch $t 0)
      (call $throw)
    )
    i32.const 42 ;; unreachable
  )
)

(assert_return (invoke "main" (i32.const 44)) (i32.const 47))
(module
  (type $f1 (func))
  (tag $t (param i32))
  (func $throw
    (throw $t (i32.const 47))
  )
  (elem declare func $throw)
  (func (export "main") (param i32) (result i32)
    (block (result i32)
      (try_table (catch $t 0)
        (call $throw)
      )
      (i32.const 22)
    )
  )
)

(assert_return (invoke "main" (i32.const 44)) (i32.const 47))
(module
  (type $f1 (func))
  (tag $t (param i32))
  (func $throw
    (throw $t (i32.const 47))
  )
  (elem declare func $throw)
  (func (export "main") (param i32) (result i32)
    (i32.const 33)
    (block (result i32)
      (try_table (catch $t 0)
        (call $throw)
      )
      (i32.const 22)
    )
    return
  )
)

(assert_return (invoke "main" (i32.const 44)) (i32.const 47))
(module
  (type $f1 (func))
  (tag $t (param i32))
  (func $throw
    (throw $t (i32.const 47))
  )
  (elem declare func $throw)
  (func (export "main") (param i32) (result i32)
    (local f32)
    (local f32)
    (local f32)
    (i32.const 33)
    (block (result i32)
      (try_table (catch $t 0)
        (call $throw)
      )
      (i32.const 22)
    )
    return
  )
)

(assert_return (invoke "main" (i32.const 44)) (i32.const 47))
(module
  (type $f1 (func))
  (tag $t (param i32))
  (func $throw
    (throw $t (i32.const 47))
  )
  (elem declare func $throw)
  (func (export "main") (param i32) (result i32)
    (local f32)
    (local f32)
    (local f32)
    (i32.const 33)
    (block (result i32)
      (try_table (catch $t 1)
        (call $throw)
      )
      (i32.const 22)
    )
    return
  )
)

(assert_return (invoke "main" (i32.const 44)) (i32.const 47))
(module
  (type $f1 (func))
  (tag $t (param i32))
  (func $throw
    (throw $t (i32.const 47))
  )
  (elem declare func $throw)
  (func (export "main") (param i32) (result i32)
    (i32.add (i32.const 11) (call $f1 (local.get 0)))
  )
  (func $f1 (param i32) (result i32)
    (local f32)
    (local f32)
    (local f32)
    (i32.const 33)
    (block (result i32)
      (try_table (catch $t 1)
        (call $throw)
      )
      (i32.const 22)
    )
    return
  )
)

(assert_return (invoke "main" (i32.const 44)) (i32.const 58))
(module
  (type $f1 (func))
  (tag $t (param i64))
  (func $throw
    (throw $t (i64.const 9999999999))
  )
  (elem declare func $throw)
  (func (export "main") (param i64) (result i64)
    (try_table (catch $t 0)
      (call $throw)
    )
    i64.const 42 ;; unreachable
  )
)

(assert_return (invoke "main" (i64.const 123)) (i64.const 9999999999))
(module
  (type $f1 (func))
  (tag $t (param f32))
  (func $throw
    (throw $t (f32.const 3.25))
  )
  (elem declare func $throw)
  (func (export "main") (param f32) (result f32)
    (try_table (catch $t 0)
      (call $throw)
    )
    f32.const 42 ;; unreachable
  )
)

(assert_return (invoke "main" (f32.const 1.5)) (f32.const 3.25))
(module
  (type $f1 (func))
  (tag $t (param f64))
  (func $throw
    (throw $t (f64.const 6.022e23))
  )
  (elem declare func $throw)
  (func (export "main") (param f64) (result f64)
    (try_table (catch $t 0)
      (call $throw)
    )
    f64.const 42 ;; unreachable
  )
)

(assert_return (invoke "main" (f64.const 0.0)) (f64.const 6.022e23))
(module
  (type $f1 (func))
  (tag $t (param i32 f32))
  (func $throw
    (throw $t (i32.const 77) (f32.const 1.75))
  )
  (elem declare func $throw)
  (func (export "main") (param i32) (result i32 f32)
    (try_table (catch $t 0)
      (call $throw)
    )
    i32.const 0
    f32.const 0 ;; unreachable
  )
)

(assert_return (invoke "main" (i32.const 11)) (i32.const 77) (f32.const 1.75))
(module
  (type $f1 (func))
  (tag $t (param i32))
  (func $throw
    (throw $t (i32.const 99))
  )
  (elem declare func $throw)

  (func (export "main") (param i32) (result i32)
    (local i32 i64) ;; a couple of locals

    ;; initialize locals so they’re nontrivial
    (local.set 1 (i32.const 77777))
    (local.set 2 (i64.const 88888))

    ;; put some junk on the stack before entering try_table
    (local.get 1)
    (local.get 2)

    (try_table (result i32) (catch $t 0)
      ;; at this point, stack has 77777, 88888 on it
      (call $throw)
      ;; if throw didn’t happen, return a dummy
      i32.const 42
    )
    return ;; implicit pop
  )
)

(assert_return (invoke "main" (i32.const 44)) (i32.const 99))
(module
  (type $f1 (func))
  (tag $t (param i32))
  (func $throw
    (throw $t (i32.const 99))
  )
  (elem declare func $throw)

  (func (export "main") (param i32) (result i32)
    (local i32 i64) ;; a couple of locals

    ;; initialize locals so they’re nontrivial
    (local.set 1 (i32.const 77777))
    (local.set 2 (i64.const 88888))

    ;; put some junk on the stack before entering try_table
    (local.get 1)
    (local.get 2)

    (try_table (param i32 i64) (result i32) (catch $t 0)
      ;; at this point, stack has 77777, 88888 on it
      (call $throw)
      drop
      drop
      ;; pop if throw didn't
      i32.const 42
    )
  )
)

(assert_return (invoke "main" (i32.const 44)) (i32.const 99))

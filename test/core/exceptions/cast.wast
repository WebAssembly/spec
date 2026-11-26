(module
  (tag $e)

  (func $mkexn (result exnref)
    (block $h (result exnref)
      (try_table (catch_all_ref $h) (throw $e))
      (unreachable)
    )
  )

  (func (export "test") (result i32) (ref.test (ref exn) (call $mkexn)))
  (func (export "cast") (result i32) (ref.is_null (ref.cast (ref exn) (call $mkexn))))

  (global $g (mut exnref) (ref.null exn))
  (table $t 1 exnref)

  (func (export "global.set") (global.set $g (call $mkexn)))
  (func (export "table.set") (table.set $t (i32.const 0) (call $mkexn)))
)

(assert_return (invoke "test") (i32.const 1))
(assert_return (invoke "cast") (i32.const 0))
(assert_return (invoke "global.set"))
(assert_return (invoke "table.set"))

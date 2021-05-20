;; Test event section

(module
  (event)
  (event (param i32))
  (event (export "e2") (param i32))
  (event $e3 (param i32 f32))
  (export "e3" (event 3))
)

(register "test")

(module
  (event $e0 (import "test" "e2") (param i32))
  (import "test" "e3" (event $e1 (param i32 f32)))
)

(assert_invalid
  (module (event (result i32)))
  "non-empty event result type"
)

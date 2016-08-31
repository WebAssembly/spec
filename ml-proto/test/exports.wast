;; Functions

(module (func) (export "a" func 0))
(module (func) (export "a" func 0) (export "b" func 0))
(module (func) (func) (export "a" func 0) (export "b" func 1))

(module (export "a" (func)))
(module (export "a" (func $a)))

(assert_invalid
  (module (func) (export "a" func 1))
  "unknown function"
)
(assert_invalid
  (module (func) (export "a" func 0) (export "a" func 0))
  "duplicate export name"
)
(assert_invalid
  (module (func) (func) (export "a" func 0) (export "a" func 1))
  "duplicate export name"
)
(assert_invalid
  (module (func) (global i32 (i32.const 0)) (export "a" func 0) (export "a" global 0))
  "duplicate export name"
)
(assert_invalid
  (module (func) (table 0 anyfunc) (export "a" func 0) (export "a" table 0))
  "duplicate export name"
)
(assert_invalid
  (module (func) (memory 0) (export "a" func 0) (export "a" memory 0))
  "duplicate export name"
)

(module
  (func $f (param $n i32) (result i32)
    (return (i32.add (get_local $n) (i32.const 1)))
  )

  (export "e" func $f)
)

(assert_return (invoke "e" (i32.const 42)) (i32.const 43))


;; Globals

(module (global i32 (i32.const 0)) (export "a" global 0))
(module (global i32 (i32.const 0)) (export "a" global 0) (export "b" global 0))
(module (global i32 (i32.const 0)) (global i32 (i32.const 0)) (export "a" global 0) (export "b" global 1))

(module (export "a" (global i32 (i32.const 0))))
(module (export "a" (global $a i32 (i32.const 0))))

(assert_invalid
  (module (global i32 (i32.const 0)) (export "a" global 1))
  "unknown global"
)
(assert_invalid
  (module (global i32 (i32.const 0)) (export "a" global 0) (export "a" global 0))
  "duplicate export name"
)
(assert_invalid
  (module (global i32 (i32.const 0)) (global i32 (i32.const 0)) (export "a" global 0) (export "a" global 1))
  "duplicate export name"
)
(assert_invalid
  (module (global i32 (i32.const 0)) (func) (export "a" global 0) (export "a" func 0))
  "duplicate export name"
)
(assert_invalid
  (module (global i32 (i32.const 0)) (table 0 anyfunc) (export "a" global 0) (export "a" table 0))
  "duplicate export name"
)
(assert_invalid
  (module (global i32 (i32.const 0)) (memory 0) (export "a" global 0) (export "a" memory 0))
  "duplicate export name"
)

(; TODO: get global value ;)


;; Tables

(module (table 0 anyfunc) (export "a" table 0))
(module (table 0 anyfunc) (export "a" table 0) (export "b" table 0))
;; No multiple tables yet.
;; (module (table 0 anyfunc) (table 0 anyfunc) (export "a" table 0) (export "b" table 1))

(module (export "a" (table 0 anyfunc)))
(module (export "a" (table 0 1 anyfunc)))
(module (export "a" (table $a 0 anyfunc)))
(module (export "a" (table $a 0 1 anyfunc)))

(assert_invalid
  (module (table 0 anyfunc) (export "a" table 1))
  "unknown table"
)
(assert_invalid
  (module (table 0 anyfunc) (export "a" table 0) (export "a" table 0))
  "duplicate export name"
)
;; No multiple tables yet.
;; (assert_invalid
;;   (module (table 0 anyfunc) (table 0 anyfunc) (export "a" table 0) (export "a" table 1))
;;   "duplicate export name"
;; )
(assert_invalid
  (module (table 0 anyfunc) (func) (export "a" table 0) (export "a" func 0))
  "duplicate export name"
)
(assert_invalid
  (module (table 0 anyfunc) (global i32 (i32.const 0)) (export "a" table 0) (export "a" global 0))
  "duplicate export name"
)
(assert_invalid
  (module (table 0 anyfunc) (memory 0) (export "a" table 0) (export "a" memory 0))
  "duplicate export name"
)

(; TODO: access table ;)


;; Memories

(module (memory 0) (export "a" memory 0))
(module (memory 0) (export "a" memory 0) (export "b" memory 0))
;; No multiple memories yet.
;; (module (memory 0) (memory 0) (export "a" memory 0) (export "b" memory 1))

(module (export "a" (memory 0)))
(module (export "a" (memory 0 1)))
(module (export "a" (memory $a 0)))
(module (export "a" (memory $a 0 1)))

(assert_invalid
  (module (memory 0) (export "a" memory 1))
  "unknown memory"
)
(assert_invalid
  (module (memory 0) (export "a" memory 0) (export "a" memory 0))
  "duplicate export name"
)
;; No multiple memories yet.
;; (assert_invalid
;;   (module (memory 0) (memory 0) (export "a" memory 0) (export "a" memory 1))
;;   "duplicate export name"
;; )
(assert_invalid
  (module (memory 0) (func) (export "a" memory 0) (export "a" func 0))
  "duplicate export name"
)
(assert_invalid
  (module (memory 0) (global i32 (i32.const 0)) (export "a" memory 0) (export "a" global 0))
  "duplicate export name"
)
(assert_invalid
  (module (memory 0) (table 0 anyfunc) (export "a" memory 0) (export "a" table 0))
  "duplicate export name"
)

(; TODO: access memory ;)


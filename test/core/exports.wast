;; Functions

(module (func) (export "a" (func 0)))
(module (func) (export "a" (func 0)) (export "b" (func 0)))
(module (func) (func) (export "a" (func 0)) (export "b" (func 1)))

(module (func (export "a")))
(module (func (export "a") (export "b") (export "c")))
(module (func (export "a") (export "b") (param i32)))
(module (func) (export "a" (func 0)))
(module (func $a (export "a")))
(module (func $a) (export "a" (func $a)))
(module (export "a" (func 0)) (func))
(module (export "a" (func $a)) (func $a))

(module $Func
  (export "e" (func $f))
  (func $f (param $n i32) (result i32)
    (return (i32.add (get_local $n) (i32.const 1)))
  )
)
(assert_return (invoke "e" (i32.const 42)) (i32.const 43))
(assert_return (invoke $Func "e" (i32.const 42)) (i32.const 43))
(module)
(module $Other1)
(assert_return (invoke $Func "e" (i32.const 42)) (i32.const 43))

(assert_invalid
  (module (func) (export "a" (func 1)))
  "unknown function"
)
(assert_invalid
  (module (func) (export "a" (func 0)) (export "a" (func 0)))
  "duplicate export name"
)
(assert_invalid
  (module (func) (func) (export "a" (func 0)) (export "a" (func 1)))
  "duplicate export name"
)
(assert_invalid
  (module (func) (global i32 (i32.const 0)) (export "a" (func 0)) (export "a" (global 0)))
  "duplicate export name"
)
(assert_invalid
  (module (func) (table 0 anyfunc) (export "a" (func 0)) (export "a" (table 0)))
  "duplicate export name"
)
(assert_invalid
  (module (func) (mem 0) (export "a" (func 0)) (export "a" (mem 0)))
  "duplicate export name"
)


;; Globals

(module (global i32 (i32.const 0)) (export "a" (global 0)))
(module (global i32 (i32.const 0)) (export "a" (global 0)) (export "b" (global 0)))
(module (global i32 (i32.const 0)) (global i32 (i32.const 0)) (export "a" (global 0)) (export "b" (global 1)))

(module (global (export "a") i32 (i32.const 0)))
(module (global i32 (i32.const 0)) (export "a" (global 0)))
(module (global $a (export "a") i32 (i32.const 0)))
(module (global $a i32 (i32.const 0)) (export "a" (global $a)))
(module (export "a" (global 0)) (global i32 (i32.const 0)))
(module (export "a" (global $a)) (global $a i32 (i32.const 0)))

(module $Global
  (export "e" (global $g))
  (global $g i32 (i32.const 42))
)
(assert_return (get "e") (i32.const 42))
(assert_return (get $Global "e") (i32.const 42))
(module)
(module $Other2)
(assert_return (get $Global "e") (i32.const 42))

(assert_invalid
  (module (global i32 (i32.const 0)) (export "a" (global 1)))
  "unknown global"
)
(assert_invalid
  (module (global i32 (i32.const 0)) (export "a" (global 0)) (export "a" (global 0)))
  "duplicate export name"
)
(assert_invalid
  (module (global i32 (i32.const 0)) (global i32 (i32.const 0)) (export "a" (global 0)) (export "a" (global 1)))
  "duplicate export name"
)
(assert_invalid
  (module (global i32 (i32.const 0)) (func) (export "a" (global 0)) (export "a" (func 0)))
  "duplicate export name"
)
(assert_invalid
  (module (global i32 (i32.const 0)) (table 0 anyfunc) (export "a" (global 0)) (export "a" (table 0)))
  "duplicate export name"
)
(assert_invalid
  (module (global i32 (i32.const 0)) (mem 0) (export "a" (global 0)) (export "a" (mem 0)))
  "duplicate export name"
)


;; Tables

(module (table 0 anyfunc) (export "a" (table 0)))
(module (table 0 anyfunc) (export "a" (table 0)) (export "b" (table 0)))
;; No multiple tables yet.
;; (module (table 0 anyfunc) (table 0 anyfunc) (export "a" (table 0)) (export "b" (table 1)))

(module (table (export "a") 0 anyfunc))
(module (table (export "a") 0 1 anyfunc))
(module (table 0 anyfunc) (export "a" (table 0)))
(module (table 0 1 anyfunc) (export "a" (table 0)))
(module (table $a (export "a") 0 anyfunc))
(module (table $a (export "a") 0 1 anyfunc))
(module (table $a 0 anyfunc) (export "a" (table $a)))
(module (table $a 0 1 anyfunc) (export "a" (table $a)))
(module (export "a" (table 0)) (table 0 anyfunc))
(module (export "a" (table 0)) (table 0 1 anyfunc))
(module (export "a" (table $a)) (table $a 0 anyfunc))
(module (export "a" (table $a)) (table $a 0 1 anyfunc))

(; TODO: access table ;)

(assert_invalid
  (module (table 0 anyfunc) (export "a" (table 1)))
  "unknown table"
)
(assert_invalid
  (module (table 0 anyfunc) (export "a" (table 0)) (export "a" (table 0)))
  "duplicate export name"
)
;; No multiple tables yet.
;; (assert_invalid
;;   (module (table 0 anyfunc) (table 0 anyfunc) (export "a" (table 0)) (export "a" (table 1)))
;;   "duplicate export name"
;; )
(assert_invalid
  (module (table 0 anyfunc) (func) (export "a" (table 0)) (export "a" (func 0)))
  "duplicate export name"
)
(assert_invalid
  (module (table 0 anyfunc) (global i32 (i32.const 0)) (export "a" (table 0)) (export "a" (global 0)))
  "duplicate export name"
)
(assert_invalid
  (module (table 0 anyfunc) (mem 0) (export "a" (table 0)) (export "a" (mem 0)))
  "duplicate export name"
)


;; Memories

(module (mem 0) (export "a" (mem 0)))
(module (mem 0) (export "a" (mem 0)) (export "b" (mem 0)))
;; No multiple memories yet.
;; (module (mem 0) (mem 0) (export "a" (mem 0)) (export "b" (mem 1)))

(module (mem (export "a") 0))
(module (mem (export "a") 0 1))
(module (mem 0) (export "a" (mem 0)))
(module (mem 0 1) (export "a" (mem 0)))
(module (mem $a (export "a") 0))
(module (mem $a (export "a") 0 1))
(module (mem $a 0) (export "a" (mem $a)))
(module (mem $a 0 1) (export "a" (mem $a)))
(module (export "a" (mem 0)) (mem 0))
(module (export "a" (mem 0)) (mem 0 1))
(module (export "a" (mem $a)) (mem $a 0))
(module (export "a" (mem $a)) (mem $a 0 1))

(; TODO: access memory ;)

(assert_invalid
  (module (mem 0) (export "a" (mem 1)))
  "unknown memory"
)
(assert_invalid
  (module (mem 0) (export "a" (mem 0)) (export "a" (mem 0)))
  "duplicate export name"
)
;; No multiple memories yet.
;; (assert_invalid
;;   (module (mem 0) (mem 0) (export "a" (mem 0)) (export "a" (mem 1)))
;;   "duplicate export name"
;; )
(assert_invalid
  (module (mem 0) (func) (export "a" (mem 0)) (export "a" (func 0)))
  "duplicate export name"
)
(assert_invalid
  (module (mem 0) (global i32 (i32.const 0)) (export "a" (mem 0)) (export "a" (global 0)))
  "duplicate export name"
)
(assert_invalid
  (module (mem 0) (table 0 anyfunc) (export "a" (mem 0)) (export "a" (table 0)))
  "duplicate export name"
)

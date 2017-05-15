;; Test files can define multiple modules. Test that implementations treat
;; each module independently from the other.

(module
  (func (export "foo") (result i32) (i32.const 0))
)

(assert_return (invoke "foo") (i32.const 0))

;; Another module, same function name, different contents.

(module
  (func (export "foo") (result i32) (i32.const 1))
)

(assert_return (invoke "foo") (i32.const 1))


(module
  ;; Test that we can use the empty string as a symbol.
  (func (export "") (result i32) (i32.const 0))

  ;; Test that we can use names beginning with a digit.
  (func (export "0") (result i32) (i32.const 1))

  ;; Test that we can use names beginning with a dash.
  (func (export "-0") (result i32) (i32.const 2))

  ;; Test that we can use names beginning with an underscore.
  (func (export "_") (result i32) (i32.const 3))

  ;; Test that we can use names beginning with a dollar sign.
  (func (export "$") (result i32) (i32.const 4))

  ;; Test that we can use names beginning with an at sign.
  (func (export "@") (result i32) (i32.const 5))

  ;; Test that we can use non-alphanumeric names.
  (func (export "~!@#$%^&*()_+`-={}|[]\\:\";'<>?,./ ") (result i32) (i32.const 6))

  ;; Test that we can use names that have special meaning in JS.
  (func (export "NaN") (result i32) (i32.const 7))
  (func (export "Infinity") (result i32) (i32.const 8))
  (func (export "if") (result i32) (i32.const 9))

  ;; Test that we can use common libc names without conflict.
  (func (export "malloc") (result i32) (i32.const 10))

  ;; Test that we can use some libc hidden names without conflict.
  (func (export "_malloc") (result i32) (i32.const 11))
  (func (export "__malloc") (result i32) (i32.const 12))

  ;; Test that names are case-sensitive.
  (func (export "a") (result i32) (i32.const 13))
  (func (export "A") (result i32) (i32.const 14))

  ;; Test that UTF-8 BOM code points can appear in identifiers.
  (func (export "﻿") (result i32) (i32.const 15))

  ;; Test that Unicode normalization is not applied. These function names
  ;; contain different codepoints which normalize to the same thing under
  ;; NFC or NFD.
  (func (export "Å") (result i32) (i32.const 16))
  (func (export "Å") (result i32) (i32.const 17))
  (func (export "Å") (result i32) (i32.const 18))

  ;; Test that Unicode compatibility normalization is not applied. These
  ;; function names contain different codepoints which normalize to the
  ;; same thing under NFKC or NFKD.
  (func (export "ﬃ") (result i32) (i32.const 19))
  (func (export "fﬁ") (result i32) (i32.const 20))
  (func (export "ffi") (result i32) (i32.const 21))
)

(assert_return (invoke "") (i32.const 0))
(assert_return (invoke "0") (i32.const 1))
(assert_return (invoke "-0") (i32.const 2))
(assert_return (invoke "_") (i32.const 3))
(assert_return (invoke "$") (i32.const 4))
(assert_return (invoke "@") (i32.const 5))
(assert_return (invoke "~!@#$%^&*()_+`-={}|[]\\:\";'<>?,./ ") (i32.const 6))
(assert_return (invoke "NaN") (i32.const 7))
(assert_return (invoke "Infinity") (i32.const 8))
(assert_return (invoke "if") (i32.const 9))
(assert_return (invoke "malloc") (i32.const 10))
(assert_return (invoke "_malloc") (i32.const 11))
(assert_return (invoke "__malloc") (i32.const 12))
(assert_return (invoke "a") (i32.const 13))
(assert_return (invoke "A") (i32.const 14))
(assert_return (invoke "﻿") (i32.const 15))
(assert_return (invoke "Å") (i32.const 16))
(assert_return (invoke "Å") (i32.const 17))
(assert_return (invoke "Å") (i32.const 18))
(assert_return (invoke "ﬃ") (i32.const 19))
(assert_return (invoke "fﬁ") (i32.const 20))
(assert_return (invoke "ffi") (i32.const 21))

(module
  ;; Test that we can use indices instead of names to reference imports,
  ;; exports, functions and parameters.
  (import "spectest" "print" (func (param i32)))
  (func (import "spectest" "print") (param i32))
  (func (param i32) (param i32)
    (call 0 (get_local 0))
    (call 1 (get_local 1))
  )
  (export "print32" (func 2))
)

(invoke "print32" (i32.const 42) (i32.const 123))

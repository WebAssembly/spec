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

  ;; Test the C0 control codes.
  (func (export "\00\01\02\03\04\05\06\07\08\09\0a\0b\0c\0d\0e\0f") (result i32) (i32.const 22))
  (func (export "\10\11\12\13\14\15\16\17\18\19\1a\1b\1c\1d\1e\1f") (result i32) (i32.const 23))
  ;; Test miscellaneous control codes.
  (func (export " \7f") (result i32) (i32.const 24))
  ;; Test the C1 control codes.
  (func (export "\c2\80\c2\81\c2\82\c2\83\c2\84\c2\85\c2\86\c2\87\c2\88\c2\89\c2\8a\c2\8b\c2\8c\c2\8d\c2\8e\c2\8f") (result i32) (i32.const 25))
  (func (export "\c2\90\c2\91\c2\92\c2\93\c2\94\c2\95\c2\96\c2\97\c2\98\c2\99\c2\9a\c2\9b\c2\9c\c2\9d\c2\9e\c2\9f") (result i32) (i32.const 26))
  ;; Test the Unicode Specials.
  (func (export "\ef\bf\b0\ef\bf\b1\ef\bf\b2\ef\bf\b3\ef\bf\b4\ef\bf\b5\ef\bf\b6\ef\bf\b7") (result i32) (i32.const 27))
  (func (export "\ef\bf\b8\ef\bf\b9\ef\bf\ba\ef\bf\bb\ef\bf\bc\ef\bf\bd\ef\bf\be\ef\bf\bf") (result i32) (i32.const 28))

  ;; Test that the control pictures are distinct from the control codes they
  ;; depict. These correspond to the C0 and miscellaneous control code tests
  ;; above.
  (func (export "␀␁␂␃␄␅␆␇␈␉␊␋␌␍␎␏") (result i32) (i32.const 29))
  (func (export "␐␑␒␓␔␕␖␗␘␙␚␛␜␝␞␟") (result i32) (i32.const 30))
  (func (export "␠␡") (result i32) (i32.const 31))

  ;; Test the Unicode Specials in non-escaped form (excluding U+FFFE and
  ;; U+FFFF, so that generic tools don't detect this file as non-UTF-8).
  (func (export "￰￱￲￳￴￵￶￷￸￹￺￻￼�") (result i32) (i32.const 32))

  ;; Test a bare ZWJ code point.
  (func (export "‍") (result i32) (i32.const 33))
  ;; Test a bare ZWNJ code point.
  (func (export "‌") (result i32) (i32.const 34))

  ;; Test various bare joiner code points.
  (func (export "͏") (result i32) (i32.const 35))
  (func (export "⁠") (result i32) (i32.const 36))
  (func (export "⵿") (result i32) (i32.const 37))
  (func (export "𑁿") (result i32) (i32.const 38))
  (func (export "᠎") (result i32) (i32.const 39))

  ;; Test various interesting code points: reverse BOM, zero-width space,
  ;; no-break space, soft hyphen, word joiner, ogham space mark,
  ;; right-to-left override, left-to-right override.
  (func (export "￯​ ­⁠ ‮‭") (result i32) (i32.const 40))

  ;; Test more interesting code points: left-to-right mark, right-to-left mark,
  ;; non-breaking hyphen, line separator, paragraph separator,
  ;; left-to-right embedding, right-to-left embedding,
  ;; pop directional formatting, narrow no-break space, left-to-right isolate,
  ;; right-to-left isolate, first strong isolate, pop directional isolate.
  (func (export "‎‏‑  ‪‫‬ ⁦⁧⁨⁩") (result i32) (i32.const 41))

  ;; Test some deprecated code points: inhibit symmetric swapping,
  ;; activate symmetric swapping, inhibit arabic form shaping,
  ;; activate arabic form shaping, national digit shapes, nominal digit shapes.
  (func (export "⁪⁫⁬⁭⁮⁯") (result i32) (i32.const 42))

  ;; Test "invisible" operator code points.
  (func (export "⁡⁢⁣⁤") (result i32) (i32.const 43))

  ;; Test that code points outside the BMP are supported.
  (func (export "𐀀󟿿􏿿") (result i32) (i32.const 44))
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
(assert_return (invoke "\00\01\02\03\04\05\06\07\08\09\0a\0b\0c\0d\0e\0f") (i32.const 22))
(assert_return (invoke "\10\11\12\13\14\15\16\17\18\19\1a\1b\1c\1d\1e\1f") (i32.const 23))
(assert_return (invoke " \7f") (i32.const 24))
(assert_return (invoke "\c2\80\c2\81\c2\82\c2\83\c2\84\c2\85\c2\86\c2\87\c2\88\c2\89\c2\8a\c2\8b\c2\8c\c2\8d\c2\8e\c2\8f") (i32.const 25))
(assert_return (invoke "\c2\90\c2\91\c2\92\c2\93\c2\94\c2\95\c2\96\c2\97\c2\98\c2\99\c2\9a\c2\9b\c2\9c\c2\9d\c2\9e\c2\9f") (i32.const 26))
(assert_return (invoke "\ef\bf\b0\ef\bf\b1\ef\bf\b2\ef\bf\b3\ef\bf\b4\ef\bf\b5\ef\bf\b6\ef\bf\b7") (i32.const 27))
(assert_return (invoke "\ef\bf\b8\ef\bf\b9\ef\bf\ba\ef\bf\bb\ef\bf\bc\ef\bf\bd\ef\bf\be\ef\bf\bf") (i32.const 28))
(assert_return (invoke "␀␁␂␃␄␅␆␇␈␉␊␋␌␍␎␏") (i32.const 29))
(assert_return (invoke "␐␑␒␓␔␕␖␗␘␙␚␛␜␝␞␟") (i32.const 30))
(assert_return (invoke "␠␡") (i32.const 31))
(assert_return (invoke "￰￱￲￳￴￵￶￷￸￹￺￻￼�") (i32.const 32))
(assert_return (invoke "‍") (i32.const 33))
(assert_return (invoke "‌") (i32.const 34))
(assert_return (invoke "͏") (i32.const 35))
(assert_return (invoke "⁠") (i32.const 36))
(assert_return (invoke "⵿") (i32.const 37))
(assert_return (invoke "𑁿") (i32.const 38))
(assert_return (invoke "᠎") (i32.const 39))
(assert_return (invoke "￯​ ­⁠ ‮‭") (i32.const 40))
(assert_return (invoke "‎‏‑  ‪‫‬ ⁦⁧⁨⁩") (i32.const 41))
(assert_return (invoke "⁪⁫⁬⁭⁮⁯") (i32.const 42))
(assert_return (invoke "⁡⁢⁣⁤") (i32.const 43))
(assert_return (invoke "𐀀󟿿􏿿") (i32.const 44))

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

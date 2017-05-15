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

  ;; Test that WebAssembly implementations cope in the presence of Zalgo.
  (func (export "Z̴͇̫̥̪͓͈͔͎̗̞̺̯̱̞̙̱̜̖̠̏͆̆͛͌͘͞ḁ̶̰̳̭͙̲̱̹̝͎̼͗ͨ̎̄̆͗̿̀́͟͡l̶̷͉̩̹̫̝͖̙̲̼͇͚͍̮͎̥̞̈́͊͗ͦ̈́ͫ̇́̚ͅͅg̶͕͔͚̩̓̐̅ͮ̔̐̎̂̏̾͊̍͋͊ͧ́̆ͦ͞o̡͋̔͐ͪͩ͏̢̧̫̙̤̮͖͙͓̺̜̩̼̘̠́") (result i32) (i32.const 45))

  ;; Test Hangul filler code points.
  (func (export "ᅟᅠㅤﾠ") (result i32) (i32.const 46))

  ;; Test variation selectors (which are also ID_Continue code points).
  (func (export "︀") (result i32) (i32.const 47))
  (func (export "︄") (result i32) (i32.const 48))
  (func (export "󠄀") (result i32) (i32.const 49))
  (func (export "󠇯") (result i32) (i32.const 50))

  ;; Test an uncombined combining code point.
  (func (export "̈") (result i32) (i32.const 51))

  ;; Test that numerous different present and historical representations of the
  ;; "newline" concept are distinct. Tests largely inspired by:
  ;;   https://en.wikipedia.org/wiki/Newline#Representations
  ;;   https://en.wikipedia.org/wiki/Newline#Unicode and
  ;;   https://en.wikipedia.org/wiki/Newline#Reverse_and_partial_line_feeds
  (func (export "\0a") (result i32) (i32.const 52))
  (func (export "␤") (result i32) (i32.const 53))
  (func (export " ") (result i32) (i32.const 54))
  (func (export "\0d") (result i32) (i32.const 55))
  (func (export "\0d\0a") (result i32) (i32.const 56))
  (func (export "\0a\0d") (result i32) (i32.const 57))
  (func (export "\1e") (result i32) (i32.const 58))
  (func (export "\0b") (result i32) (i32.const 59))
  (func (export "\0c") (result i32) (i32.const 60))
  (func (export "\c2\85") (result i32) (i32.const 61))
  (func (export " ") (result i32) (i32.const 62))
  (func (export "…") (result i32) (i32.const 63))
  (func (export "⏎") (result i32) (i32.const 64))
  (func (export "\c2\8b") (result i32) (i32.const 65))
  (func (export "\c2\8c") (result i32) (i32.const 66))
  (func (export "\c2\8d") (result i32) (i32.const 67))
  (func (export "↵") (result i32) (i32.const 68))
  (func (export "↩") (result i32) (i32.const 69))
  (func (export "⌤") (result i32) (i32.const 70))
  (func (export "⤶") (result i32) (i32.const 71))
  (func (export "↲") (result i32) (i32.const 72))
  (func (export "⮨") (result i32) (i32.const 73))
  (func (export "⮰") (result i32) (i32.const 74))

  ;; Test that non-characters are not replaced by the replacement character.
  (func (export "�") (result i32) (i32.const 75))
  (func (export "\ef\b7\90") (result i32) (i32.const 76))
  (func (export "\ef\b7\91") (result i32) (i32.const 77))
  (func (export "\ef\b7\92") (result i32) (i32.const 78))
  (func (export "\ef\b7\93") (result i32) (i32.const 79))
  (func (export "\ef\b7\94") (result i32) (i32.const 80))
  (func (export "\ef\b7\95") (result i32) (i32.const 81))
  (func (export "\ef\b7\96") (result i32) (i32.const 82))
  (func (export "\ef\b7\97") (result i32) (i32.const 83))
  (func (export "\ef\b7\98") (result i32) (i32.const 84))
  (func (export "\ef\b7\99") (result i32) (i32.const 85))
  (func (export "\ef\b7\9a") (result i32) (i32.const 86))
  (func (export "\ef\b7\9b") (result i32) (i32.const 87))
  (func (export "\ef\b7\9c") (result i32) (i32.const 88))
  (func (export "\ef\b7\9d") (result i32) (i32.const 89))
  (func (export "\ef\b7\9e") (result i32) (i32.const 90))
  (func (export "\ef\b7\9f") (result i32) (i32.const 91))
  (func (export "\ef\b7\a0") (result i32) (i32.const 92))
  (func (export "\ef\b7\a1") (result i32) (i32.const 93))
  (func (export "\ef\b7\a2") (result i32) (i32.const 94))
  (func (export "\ef\b7\a3") (result i32) (i32.const 95))
  (func (export "\ef\b7\a4") (result i32) (i32.const 96))
  (func (export "\ef\b7\a5") (result i32) (i32.const 97))
  (func (export "\ef\b7\a6") (result i32) (i32.const 98))
  (func (export "\ef\b7\a7") (result i32) (i32.const 99))
  (func (export "\ef\b7\a8") (result i32) (i32.const 100))
  (func (export "\ef\b7\a9") (result i32) (i32.const 101))
  (func (export "\ef\b7\aa") (result i32) (i32.const 102))
  (func (export "\ef\b7\ab") (result i32) (i32.const 103))
  (func (export "\ef\b7\ac") (result i32) (i32.const 104))
  (func (export "\ef\b7\ad") (result i32) (i32.const 105))
  (func (export "\ef\b7\ae") (result i32) (i32.const 106))
  (func (export "\ef\b7\af") (result i32) (i32.const 107))
  (func (export "\ef\bf\be") (result i32) (i32.const 108))
  (func (export "\ef\bf\bf") (result i32) (i32.const 109))
  (func (export "\f0\9f\bf\be") (result i32) (i32.const 110))
  (func (export "\f0\9f\bf\bf") (result i32) (i32.const 111))
  (func (export "\f0\af\bf\be") (result i32) (i32.const 112))
  (func (export "\f0\af\bf\bf") (result i32) (i32.const 113))
  (func (export "\f0\bf\bf\be") (result i32) (i32.const 114))
  (func (export "\f0\bf\bf\bf") (result i32) (i32.const 115))
  (func (export "\f1\8f\bf\be") (result i32) (i32.const 116))
  (func (export "\f1\8f\bf\bf") (result i32) (i32.const 117))
  (func (export "\f1\9f\bf\be") (result i32) (i32.const 118))
  (func (export "\f1\9f\bf\bf") (result i32) (i32.const 119))
  (func (export "\f1\af\bf\be") (result i32) (i32.const 120))
  (func (export "\f1\af\bf\bf") (result i32) (i32.const 121))
  (func (export "\f1\bf\bf\be") (result i32) (i32.const 122))
  (func (export "\f1\bf\bf\bf") (result i32) (i32.const 123))
  (func (export "\f2\8f\bf\be") (result i32) (i32.const 124))
  (func (export "\f2\8f\bf\bf") (result i32) (i32.const 125))
  (func (export "\f2\9f\bf\be") (result i32) (i32.const 126))
  (func (export "\f2\9f\bf\bf") (result i32) (i32.const 127))
  (func (export "\f2\af\bf\be") (result i32) (i32.const 128))
  (func (export "\f2\af\bf\bf") (result i32) (i32.const 129))
  (func (export "\f2\bf\bf\be") (result i32) (i32.const 130))
  (func (export "\f2\bf\bf\bf") (result i32) (i32.const 131))
  (func (export "\f3\8f\bf\be") (result i32) (i32.const 132))
  (func (export "\f3\8f\bf\bf") (result i32) (i32.const 133))
  (func (export "\f3\9f\bf\be") (result i32) (i32.const 134))
  (func (export "\f3\9f\bf\bf") (result i32) (i32.const 135))
  (func (export "\f3\af\bf\be") (result i32) (i32.const 136))
  (func (export "\f3\af\bf\bf") (result i32) (i32.const 137))
  (func (export "\f3\bf\bf\be") (result i32) (i32.const 138))
  (func (export "\f3\bf\bf\bf") (result i32) (i32.const 139))
  (func (export "\f4\8f\bf\be") (result i32) (i32.const 140))
  (func (export "\f4\8f\bf\bf") (result i32) (i32.const 141))

  ;; Test an interrobang with combining diacritical marks above.
  ;; https://xkcd.com/1209/
  (func (export "̈‽̈̉") (result i32) (i32.const 142))
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
(assert_return (invoke "Z̴͇̫̥̪͓͈͔͎̗̞̺̯̱̞̙̱̜̖̠̏͆̆͛͌͘͞ḁ̶̰̳̭͙̲̱̹̝͎̼͗ͨ̎̄̆͗̿̀́͟͡l̶̷͉̩̹̫̝͖̙̲̼͇͚͍̮͎̥̞̈́͊͗ͦ̈́ͫ̇́̚ͅͅg̶͕͔͚̩̓̐̅ͮ̔̐̎̂̏̾͊̍͋͊ͧ́̆ͦ͞o̡͋̔͐ͪͩ͏̢̧̫̙̤̮͖͙͓̺̜̩̼̘̠́") (i32.const 45))
(assert_return (invoke "ᅟᅠㅤﾠ") (i32.const 46))
(assert_return (invoke "︀") (i32.const 47))
(assert_return (invoke "︄") (i32.const 48))
(assert_return (invoke "󠄀") (i32.const 49))
(assert_return (invoke "󠇯") (i32.const 50))
(assert_return (invoke "̈") (i32.const 51))
(assert_return (invoke "\0a") (i32.const 52))
(assert_return (invoke "␤") (i32.const 53))
(assert_return (invoke " ") (i32.const 54))
(assert_return (invoke "\0d") (i32.const 55))
(assert_return (invoke "\0d\0a") (i32.const 56))
(assert_return (invoke "\0a\0d") (i32.const 57))
(assert_return (invoke "\1e") (i32.const 58))
(assert_return (invoke "\0b") (i32.const 59))
(assert_return (invoke "\0c") (i32.const 60))
(assert_return (invoke "\c2\85") (i32.const 61))
(assert_return (invoke " ") (i32.const 62))
(assert_return (invoke "…") (i32.const 63))
(assert_return (invoke "⏎") (i32.const 64))
(assert_return (invoke "\c2\8b") (i32.const 65))
(assert_return (invoke "\c2\8c") (i32.const 66))
(assert_return (invoke "\c2\8d") (i32.const 67))
(assert_return (invoke "↵") (i32.const 68))
(assert_return (invoke "↩") (i32.const 69))
(assert_return (invoke "⌤") (i32.const 70))
(assert_return (invoke "⤶") (i32.const 71))
(assert_return (invoke "↲") (i32.const 72))
(assert_return (invoke "⮨") (i32.const 73))
(assert_return (invoke "⮰") (i32.const 74))
(assert_return (invoke "�") (i32.const 75))
(assert_return (invoke "\ef\b7\90") (i32.const 76))
(assert_return (invoke "\ef\b7\91") (i32.const 77))
(assert_return (invoke "\ef\b7\92") (i32.const 78))
(assert_return (invoke "\ef\b7\93") (i32.const 79))
(assert_return (invoke "\ef\b7\94") (i32.const 80))
(assert_return (invoke "\ef\b7\95") (i32.const 81))
(assert_return (invoke "\ef\b7\96") (i32.const 82))
(assert_return (invoke "\ef\b7\97") (i32.const 83))
(assert_return (invoke "\ef\b7\98") (i32.const 84))
(assert_return (invoke "\ef\b7\99") (i32.const 85))
(assert_return (invoke "\ef\b7\9a") (i32.const 86))
(assert_return (invoke "\ef\b7\9b") (i32.const 87))
(assert_return (invoke "\ef\b7\9c") (i32.const 88))
(assert_return (invoke "\ef\b7\9d") (i32.const 89))
(assert_return (invoke "\ef\b7\9e") (i32.const 90))
(assert_return (invoke "\ef\b7\9f") (i32.const 91))
(assert_return (invoke "\ef\b7\a0") (i32.const 92))
(assert_return (invoke "\ef\b7\a1") (i32.const 93))
(assert_return (invoke "\ef\b7\a2") (i32.const 94))
(assert_return (invoke "\ef\b7\a3") (i32.const 95))
(assert_return (invoke "\ef\b7\a4") (i32.const 96))
(assert_return (invoke "\ef\b7\a5") (i32.const 97))
(assert_return (invoke "\ef\b7\a6") (i32.const 98))
(assert_return (invoke "\ef\b7\a7") (i32.const 99))
(assert_return (invoke "\ef\b7\a8") (i32.const 100))
(assert_return (invoke "\ef\b7\a9") (i32.const 101))
(assert_return (invoke "\ef\b7\aa") (i32.const 102))
(assert_return (invoke "\ef\b7\ab") (i32.const 103))
(assert_return (invoke "\ef\b7\ac") (i32.const 104))
(assert_return (invoke "\ef\b7\ad") (i32.const 105))
(assert_return (invoke "\ef\b7\ae") (i32.const 106))
(assert_return (invoke "\ef\b7\af") (i32.const 107))
(assert_return (invoke "\ef\bf\be") (i32.const 108))
(assert_return (invoke "\ef\bf\bf") (i32.const 109))
(assert_return (invoke "\f0\9f\bf\be") (i32.const 110))
(assert_return (invoke "\f0\9f\bf\bf") (i32.const 111))
(assert_return (invoke "\f0\af\bf\be") (i32.const 112))
(assert_return (invoke "\f0\af\bf\bf") (i32.const 113))
(assert_return (invoke "\f0\bf\bf\be") (i32.const 114))
(assert_return (invoke "\f0\bf\bf\bf") (i32.const 115))
(assert_return (invoke "\f1\8f\bf\be") (i32.const 116))
(assert_return (invoke "\f1\8f\bf\bf") (i32.const 117))
(assert_return (invoke "\f1\9f\bf\be") (i32.const 118))
(assert_return (invoke "\f1\9f\bf\bf") (i32.const 119))
(assert_return (invoke "\f1\af\bf\be") (i32.const 120))
(assert_return (invoke "\f1\af\bf\bf") (i32.const 121))
(assert_return (invoke "\f1\bf\bf\be") (i32.const 122))
(assert_return (invoke "\f1\bf\bf\bf") (i32.const 123))
(assert_return (invoke "\f2\8f\bf\be") (i32.const 124))
(assert_return (invoke "\f2\8f\bf\bf") (i32.const 125))
(assert_return (invoke "\f2\9f\bf\be") (i32.const 126))
(assert_return (invoke "\f2\9f\bf\bf") (i32.const 127))
(assert_return (invoke "\f2\af\bf\be") (i32.const 128))
(assert_return (invoke "\f2\af\bf\bf") (i32.const 129))
(assert_return (invoke "\f2\bf\bf\be") (i32.const 130))
(assert_return (invoke "\f2\bf\bf\bf") (i32.const 131))
(assert_return (invoke "\f3\8f\bf\be") (i32.const 132))
(assert_return (invoke "\f3\8f\bf\bf") (i32.const 133))
(assert_return (invoke "\f3\9f\bf\be") (i32.const 134))
(assert_return (invoke "\f3\9f\bf\bf") (i32.const 135))
(assert_return (invoke "\f3\af\bf\be") (i32.const 136))
(assert_return (invoke "\f3\af\bf\bf") (i32.const 137))
(assert_return (invoke "\f3\bf\bf\be") (i32.const 138))
(assert_return (invoke "\f3\bf\bf\bf") (i32.const 139))
(assert_return (invoke "\f4\8f\bf\be") (i32.const 140))
(assert_return (invoke "\f4\8f\bf\bf") (i32.const 141))
(assert_return (invoke "̈‽̈̉") (i32.const 142))

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

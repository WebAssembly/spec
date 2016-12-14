(module "\00asm" "\0d\00\00\00" "\00\24\10" "a custom section" "this is the payload")
(module "\00asm" "\0d\00\00\00" "\00\24\10" "a custom section" "this is the payload" "\00\24\10" "a custom section" "this is the payload")

(assert_malformed (module "\00asm" "\0d\00\00\00" "\00\26\10" "a custom section" "this is the payload") "unexpected end")
(assert_malformed (module "\00asm" "\0d\00\00\00" "\00\24\11" "a custom section" "this is the payload" "\00\25\10" "a custom section" "this is the payload") "unexpected end")

;; custom sections mixed with canonical sections
(module
  ;; preramble
  "\00asm" "\0d\00\00\00"
  ;; type section
  "\01\07\01\60\02\7f\7f\01\7f"
  ;; custom section
  "\00\24\10" "a custom section" "this is the payload"
  ;; function section
  "\03\02\01\00"
  ;; export section
  "\07\0a\01\06\61\64\64\54\77\6f\00\00"
  ;; code
  "\0a\09\01\07\00\20\00\20\01\6a\0b"
  ;; another custom section
  "\00\2a\16" "another custom section" "this is the payload"
)

;; custom sections with invalid length mixed with canonical sections
(assert_malformed (module
  ;; preramble
  "\00asm" "\0d\00\00\00"
  ;; type section
  "\01\07\01\60\02\7f\7f\01\7f"
  ;; custom section with invalid length
  "\00\25\10" "a custom section" "this is the payload"
  ;; function section
  "\03\02\01\00"
  ;; export section
  "\07\0a\01\06\61\64\64\54\77\6f\00\00"
  ;; code
  "\0a\09\01\07\00\20\00\20\01\6a\0b"
  ;; another custom section
  "\00\2a\16" "another custom section" "this is the payload"
) "function and code section have inconsistent lengths")

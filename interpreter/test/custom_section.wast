(module "\00asm" "\0d\00\00\00" "\00\24\10" "a custom section" "this is the payload")
(module "\00asm" "\0d\00\00\00" "\00\24\10" "a custom section" "this is the payload" "\00\24\10" "a custom section" "this is the payload")

(assert_malformed (module "\00asm" "\0d\00\00\00" "\00\26\10" "a custom section" "this is the payload") "unexpected end")
(assert_malformed (module "\00asm" "\0d\00\00\00" "\00\24\11" "a custom section" "this is the payload" "\00\25\10" "a custom section" "this is the payload") "unexpected end")

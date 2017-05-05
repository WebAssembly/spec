;;;;;; Invalid UTF-8 custom section names

;;;; Continuation bytes not preceded by prefixes

;; encoding starts with (first) continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\02"                       ;; custom section
    "\01\80"                       ;; ""
  )
  "invalid UTF-8 encoding"
)

;; encoding starts with (0x8f) continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\02"                       ;; custom section
    "\01\8f"                       ;; ""
  )
  "invalid UTF-8 encoding"
)

;; encoding starts with (0x90) continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\02"                       ;; custom section
    "\01\90"                       ;; ""
  )
  "invalid UTF-8 encoding"
)

;; encoding starts with (0x9f) continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\02"                       ;; custom section
    "\01\9f"                       ;; ""
  )
  "invalid UTF-8 encoding"
)

;; encoding starts with (0xa0) continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\02"                       ;; custom section
    "\01\a0"                       ;; " "
  )
  "invalid UTF-8 encoding"
)

;; encoding starts with (last) continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\02"                       ;; custom section
    "\01\bf"                       ;; "¿"
  )
  "invalid UTF-8 encoding"
)

;;;; 2-byte sequences

;; 2-byte sequence contains 3 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\c2\80\80"                 ;; "Â"
  )
  "invalid UTF-8 encoding"
)

;; 2-byte sequence contains 1 byte at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\02"                       ;; custom section
    "\01\c2"                       ;; "Â"
  )
  "invalid UTF-8 encoding"
)

;; 2-byte sequence contains 1 byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\c2\2e"                    ;; "Â."
  )
  "invalid UTF-8 encoding"
)

;;;; 2-byte sequence contents

;; overlong encoding after 0xc0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\c0\80"                    ;; "À"
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xc0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\c0\bf"                    ;; "À¿"
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xc1 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\c1\80"                    ;; "Á"
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xc1 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\c1\bf"                    ;; "Á¿"
  )
  "invalid UTF-8 encoding"
)

;; byte after (first) 2-byte prefix not a contination byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\c2\00"                    ;; "Â "
  )
  "invalid UTF-8 encoding"
)

;; byte after (first) 2-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\c2\7f"                    ;; "Â"
  )
  "invalid UTF-8 encoding"
)

;; byte after (first) 2-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\c2\c0"                    ;; "ÂÀ"
  )
  "invalid UTF-8 encoding"
)

;; byte after (first) 2-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\c2\fd"                    ;; "Âı"
  )
  "invalid UTF-8 encoding"
)

;; byte after (last) 2-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\df\00"                    ;; "ß "
  )
  "invalid UTF-8 encoding"
)

;; byte after (last) 2-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\df\7f"                    ;; "ß"
  )
  "invalid UTF-8 encoding"
)

;; byte after (last) 2-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\df\c0"                    ;; "ßÀ"
  )
  "invalid UTF-8 encoding"
)

;; byte after (last) 2-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\df\fd"                    ;; "ßı"
  )
  "invalid UTF-8 encoding"
)

;;;; 3-byte sequences

;; 3-byte sequence contains 4 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\e1\80\80\80"              ;; "á"
  )
  "invalid UTF-8 encoding"
)

;; 3-byte sequence contains 2 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\e1\80"                    ;; "á"
  )
  "invalid UTF-8 encoding"
)

;; 3-byte sequence contains 2 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e1\80\2e"                 ;; "á."
  )
  "invalid UTF-8 encoding"
)

;; 3-byte sequence contains 1 byte at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\02"                       ;; custom section
    "\01\e1"                       ;; "á"
  )
  "invalid UTF-8 encoding"
)

;; 3-byte sequence contains 1 byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\e1\2e"                    ;; "á."
  )
  "invalid UTF-8 encoding"
)

;;;; 3-byte sequence contents

;; first byte after (0xe0) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e0\00\a0"                 ;; "à  "
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xe0) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e0\7f\a0"                 ;; "à "
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xe0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e0\80\80"                 ;; "à"
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xe0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e0\80\a0"                 ;; "à "
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xe0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e0\9f\a0"                 ;; "à "
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xe0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e0\9f\bf"                 ;; "à¿"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xe0) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e0\c0\a0"                 ;; "àÀ "
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xe0) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e0\fd\a0"                 ;; "àı "
  )
  "invalid UTF-8 encoding"
)

;; first byte after (first normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e1\00\80"                 ;; "á "
  )
  "invalid UTF-8 encoding"
)

;; first byte after (first normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e1\7f\80"                 ;; "á"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (first normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e1\c0\80"                 ;; "áÀ"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (first normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e1\fd\80"                 ;; "áı"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ec\00\80"                 ;; "ì "
  )
  "invalid UTF-8 encoding"
)

;; first byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ec\7f\80"                 ;; "ì"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ec\c0\80"                 ;; "ìÀ"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ec\fd\80"                 ;; "ìı"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xed) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ed\00\80"                 ;; "í "
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xed) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ed\7f\80"                 ;; "í"
  )
  "invalid UTF-8 encoding"
)

;; byte sequence reserved for UTF-16 surrogate half
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ed\a0\80"                 ;; "í "
  )
  "invalid UTF-8 encoding"
)

;; byte sequence reserved for UTF-16 surrogate half
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ed\a0\bf"                 ;; "í ¿"
  )
  "invalid UTF-8 encoding"
)

;; byte sequence reserved for UTF-16 surrogate half
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ed\bf\80"                 ;; "í¿"
  )
  "invalid UTF-8 encoding"
)

;; byte sequence reserved for UTF-16 surrogate half
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ed\bf\bf"                 ;; "í¿¿"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xed) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ed\c0\80"                 ;; "íÀ"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xed) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ed\fd\80"                 ;; "íı"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ee\00\80"                 ;; "î "
  )
  "invalid UTF-8 encoding"
)

;; first byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ee\7f\80"                 ;; "î"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ee\c0\80"                 ;; "îÀ"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ee\fd\80"                 ;; "îı"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (last normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ef\00\80"                 ;; "ï "
  )
  "invalid UTF-8 encoding"
)

;; first byte after (last normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ef\7f\80"                 ;; "ï"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (last normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ef\c0\80"                 ;; "ïÀ"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (last normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ef\fd\80"                 ;; "ïı"
  )
  "invalid UTF-8 encoding"
)

;;;; 3-byte sequence contents (third byte)

;; second byte after (0xe0) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e0\a0\00"                 ;; "à  "
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xe0) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e0\a0\7f"                 ;; "à "
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xe0) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e0\a0\c0"                 ;; "à À"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xe0) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e0\a0\fd"                 ;; "à ı"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (first normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e1\80\00"                 ;; "á "
  )
  "invalid UTF-8 encoding"
)

;; second byte after (first normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e1\80\7f"                 ;; "á"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (first normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e1\80\c0"                 ;; "áÀ"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (first normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\e1\80\fd"                 ;; "áı"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ec\80\00"                 ;; "ì "
  )
  "invalid UTF-8 encoding"
)

;; second byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ec\80\7f"                 ;; "ì"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ec\80\c0"                 ;; "ìÀ"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ec\80\fd"                 ;; "ìı"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xed) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ed\80\00"                 ;; "í "
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xed) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ed\80\7f"                 ;; "í"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xed) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ed\80\c0"                 ;; "íÀ"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xed) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ed\80\fd"                 ;; "íı"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ee\80\00"                 ;; "î "
  )
  "invalid UTF-8 encoding"
)

;; second byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ee\80\7f"                 ;; "î"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ee\80\c0"                 ;; "îÀ"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ee\80\fd"                 ;; "îı"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (last normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ef\80\00"                 ;; "ï "
  )
  "invalid UTF-8 encoding"
)

;; second byte after (last normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ef\80\7f"                 ;; "ï"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (last normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ef\80\c0"                 ;; "ïÀ"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (last normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\ef\80\fd"                 ;; "ïı"
  )
  "invalid UTF-8 encoding"
)

;;;; 4-byte sequences

;; 4-byte sequence contains 5 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\06"                       ;; custom section
    "\05\f1\80\80\80\80"           ;; "ñ"
  )
  "invalid UTF-8 encoding"
)

;; 4-byte sequence contains 3 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\f1\80\80"                 ;; "ñ"
  )
  "invalid UTF-8 encoding"
)

;; 4-byte sequence contains 3 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f1\80\80\23"              ;; "ñ#"
  )
  "invalid UTF-8 encoding"
)

;; 4-byte sequence contains 2 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\f1\80"                    ;; "ñ"
  )
  "invalid UTF-8 encoding"
)

;; 4-byte sequence contains 2 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\f1\80\23"                 ;; "ñ#"
  )
  "invalid UTF-8 encoding"
)

;; 4-byte sequence contains 1 byte at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\02"                       ;; custom section
    "\01\f1"                       ;; "ñ"
  )
  "invalid UTF-8 encoding"
)

;; 4-byte sequence contains 1 byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\f1\23"                    ;; "ñ#"
  )
  "invalid UTF-8 encoding"
)

;;;; 4-byte sequence contents

;; first byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f0\00\90\90"              ;; "ğ "
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f0\7f\90\90"              ;; "ğ"
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xf0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f0\80\80\80"              ;; "ğ"
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xf0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f0\80\90\90"              ;; "ğ"
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xf0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f0\8f\90\90"              ;; "ğ"
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xf0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f0\8f\bf\bf"              ;; "ğ¿¿"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f0\c0\90\90"              ;; "ğÀ"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f0\fd\90\90"              ;; "ğı"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f1\00\80\80"              ;; "ñ "
  )
  "invalid UTF-8 encoding"
)

;; first byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f1\7f\80\80"              ;; "ñ"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f1\c0\80\80"              ;; "ñÀ"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f1\fd\80\80"              ;; "ñı"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f3\00\80\80"              ;; "ó "
  )
  "invalid UTF-8 encoding"
)

;; first byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f3\7f\80\80"              ;; "ó"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f3\c0\80\80"              ;; "óÀ"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f3\fd\80\80"              ;; "óı"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f4\00\80\80"              ;; "ô "
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f4\7f\80\80"              ;; "ô"
  )
  "invalid UTF-8 encoding"
)

;; (first) invalid code point
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f4\90\80\80"              ;; "ô"
  )
  "invalid UTF-8 encoding"
)

;; invalid code point
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f4\bf\80\80"              ;; "ô¿"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f4\c0\80\80"              ;; "ôÀ"
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f4\fd\80\80"              ;; "ôı"
  )
  "invalid UTF-8 encoding"
)

;; (first) invalid 4-byte prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f5\80\80\80"              ;; "õ"
  )
  "invalid UTF-8 encoding"
)

;; (last) invalid 4-byte prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f7\80\80\80"              ;; "÷"
  )
  "invalid UTF-8 encoding"
)

;; (last) invalid 4-byte prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f7\bf\bf\bf"              ;; "÷¿¿¿"
  )
  "invalid UTF-8 encoding"
)

;;;; 4-byte sequence contents (third byte)

;; second byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f0\90\00\90"              ;; "ğ "
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f0\90\7f\90"              ;; "ğ"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f0\90\c0\90"              ;; "ğÀ"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f0\90\fd\90"              ;; "ğı"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f1\80\00\80"              ;; "ñ "
  )
  "invalid UTF-8 encoding"
)

;; second byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f1\80\7f\80"              ;; "ñ"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f1\80\c0\80"              ;; "ñÀ"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f1\80\fd\80"              ;; "ñı"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f3\80\00\80"              ;; "ó "
  )
  "invalid UTF-8 encoding"
)

;; second byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f3\80\7f\80"              ;; "ó"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f3\80\c0\80"              ;; "óÀ"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f3\80\fd\80"              ;; "óı"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f4\80\00\80"              ;; "ô "
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f4\80\7f\80"              ;; "ô"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f4\80\c0\80"              ;; "ôÀ"
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f4\80\fd\80"              ;; "ôı"
  )
  "invalid UTF-8 encoding"
)

;;;; 4-byte sequence contents (fourth byte)

;; third byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f0\90\90\00"              ;; "ğ "
  )
  "invalid UTF-8 encoding"
)

;; third byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f0\90\90\7f"              ;; "ğ"
  )
  "invalid UTF-8 encoding"
)

;; third byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f0\90\90\c0"              ;; "ğÀ"
  )
  "invalid UTF-8 encoding"
)

;; third byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f0\90\90\fd"              ;; "ğı"
  )
  "invalid UTF-8 encoding"
)

;; third byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f1\80\80\00"              ;; "ñ "
  )
  "invalid UTF-8 encoding"
)

;; third byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f1\80\80\7f"              ;; "ñ"
  )
  "invalid UTF-8 encoding"
)

;; third byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f1\80\80\c0"              ;; "ñÀ"
  )
  "invalid UTF-8 encoding"
)

;; third byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f1\80\80\fd"              ;; "ñı"
  )
  "invalid UTF-8 encoding"
)

;; third byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f3\80\80\00"              ;; "ó "
  )
  "invalid UTF-8 encoding"
)

;; third byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f3\80\80\7f"              ;; "ó"
  )
  "invalid UTF-8 encoding"
)

;; third byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f3\80\80\c0"              ;; "óÀ"
  )
  "invalid UTF-8 encoding"
)

;; third byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f3\80\80\fd"              ;; "óı"
  )
  "invalid UTF-8 encoding"
)

;; third byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f4\80\80\00"              ;; "ô "
  )
  "invalid UTF-8 encoding"
)

;; third byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f4\80\80\7f"              ;; "ô"
  )
  "invalid UTF-8 encoding"
)

;; third byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f4\80\80\c0"              ;; "ôÀ"
  )
  "invalid UTF-8 encoding"
)

;; third byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f4\80\80\fd"              ;; "ôı"
  )
  "invalid UTF-8 encoding"
)

;;;; 5-byte sequences

;; 5-byte sequence contains 6 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\07"                       ;; custom section
    "\06\f8\80\80\80\80\80"        ;; "ø"
  )
  "invalid UTF-8 encoding"
)

;; 5-byte sequence contains 4 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f8\80\80\80"              ;; "ø"
  )
  "invalid UTF-8 encoding"
)

;; 5-byte sequence contains 4 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\06"                       ;; custom section
    "\05\f8\80\80\80\23"           ;; "ø#"
  )
  "invalid UTF-8 encoding"
)

;; 5-byte sequence contains 3 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\f8\80\80"                 ;; "ø"
  )
  "invalid UTF-8 encoding"
)

;; 5-byte sequence contains 3 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\f8\80\80\23"              ;; "ø#"
  )
  "invalid UTF-8 encoding"
)

;; 5-byte sequence contains 2 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\f8\80"                    ;; "ø"
  )
  "invalid UTF-8 encoding"
)

;; 5-byte sequence contains 2 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\f8\80\23"                 ;; "ø#"
  )
  "invalid UTF-8 encoding"
)

;; 5-byte sequence contains 1 byte at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\02"                       ;; custom section
    "\01\f8"                       ;; "ø"
  )
  "invalid UTF-8 encoding"
)

;; 5-byte sequence contains 1 byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\f8\23"                    ;; "ø#"
  )
  "invalid UTF-8 encoding"
)

;;;; 5-byte sequence contents

;; (first) invalid 5-byte prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\06"                       ;; custom section
    "\05\f8\80\80\80\80"           ;; "ø"
  )
  "invalid UTF-8 encoding"
)

;; (last) invalid 5-byte prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\06"                       ;; custom section
    "\05\fb\bf\bf\bf\bf"           ;; "û¿¿¿¿"
  )
  "invalid UTF-8 encoding"
)

;;;; 6-byte sequences

;; 6-byte sequence contains 7 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\08"                       ;; custom section
    "\07\fc\80\80\80\80\80\80"     ;; "ü"
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 5 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\06"                       ;; custom section
    "\05\fc\80\80\80\80"           ;; "ü"
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 5 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\07"                       ;; custom section
    "\06\fc\80\80\80\80\23"        ;; "ü#"
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 4 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\fc\80\80\80"              ;; "ü"
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 4 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\06"                       ;; custom section
    "\05\fc\80\80\80\23"           ;; "ü#"
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 3 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\fc\80\80"                 ;; "ü"
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 3 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\fc\80\80\23"              ;; "ü#"
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 2 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\fc\80"                    ;; "ü"
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 2 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\04"                       ;; custom section
    "\03\fc\80\23"                 ;; "ü#"
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 1 byte at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\02"                       ;; custom section
    "\01\fc"                       ;; "ü"
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 1 byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\fc\23"                    ;; "ü#"
  )
  "invalid UTF-8 encoding"
)

;;;; 6-byte sequence contents

;; (first) invalid 6-byte prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\07"                       ;; custom section
    "\06\fc\80\80\80\80\80"        ;; "ü"
  )
  "invalid UTF-8 encoding"
)

;; (last) invalid 6-byte prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\07"                       ;; custom section
    "\06\fd\bf\bf\bf\bf\bf"        ;; "ı¿¿¿¿¿"
  )
  "invalid UTF-8 encoding"
)

;;;; Miscellaneous invalid bytes

;; invalid byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\02"                       ;; custom section
    "\01\fe"                       ;; "ş"
  )
  "invalid UTF-8 encoding"
)

;; invalid byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\02"                       ;; custom section
    "\01\ff"                       ;; "ÿ"
  )
  "invalid UTF-8 encoding"
)

;; UTF-16BE BOM
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\fe\ff"                    ;; "şÿ"
  )
  "invalid UTF-8 encoding"
)

;; UTF-32BE BOM
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\00\00\fe\ff"              ;; "  şÿ"
  )
  "invalid UTF-8 encoding"
)

;; UTF-16LE BOM
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\03"                       ;; custom section
    "\02\ff\fe"                    ;; "ÿş"
  )
  "invalid UTF-8 encoding"
)

;; UTF-32LE BOM
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\00\05"                       ;; custom section
    "\04\ff\fe\00\00"              ;; "ÿş  "
  )
  "invalid UTF-8 encoding"
)


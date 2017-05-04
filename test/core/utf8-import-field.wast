;;;;;; Invalid UTF-8 import field names

;;;; Continuation bytes not preceded by prefixes

;; encoding starts with (first) continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0b"                       ;; import section
    "\01"                          ;; length 1
    "\01\80"                       ;; ""
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; encoding starts with (0x8f) continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0b"                       ;; import section
    "\01"                          ;; length 1
    "\01\8f"                       ;; ""
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; encoding starts with (0x90) continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0b"                       ;; import section
    "\01"                          ;; length 1
    "\01\90"                       ;; ""
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; encoding starts with (0x9f) continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0b"                       ;; import section
    "\01"                          ;; length 1
    "\01\9f"                       ;; ""
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; encoding starts with (0xa0) continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0b"                       ;; import section
    "\01"                          ;; length 1
    "\01\a0"                       ;; " "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; encoding starts with (last) continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0b"                       ;; import section
    "\01"                          ;; length 1
    "\01\bf"                       ;; "¿"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;;;; 2-byte sequences

;; 2-byte sequence contains 3 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\c2\80\80"                 ;; "Â"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 2-byte sequence contains 1 byte at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0b"                       ;; import section
    "\01"                          ;; length 1
    "\01\c2"                       ;; "Â"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 2-byte sequence contains 1 byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\c2\2e"                    ;; "Â."
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;;;; 2-byte sequence contents

;; overlong encoding after 0xc0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\c0\80"                    ;; "À"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xc0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\c0\bf"                    ;; "À¿"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xc1 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\c1\80"                    ;; "Á"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xc1 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\c1\bf"                    ;; "Á¿"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; byte after (first) 2-byte prefix not a contination byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\c2\00"                    ;; "Â "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; byte after (first) 2-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\c2\7f"                    ;; "Â"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; byte after (first) 2-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\c2\c0"                    ;; "ÂÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; byte after (first) 2-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\c2\fd"                    ;; "Âı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; byte after (last) 2-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\df\00"                    ;; "ß "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; byte after (last) 2-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\df\7f"                    ;; "ß"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; byte after (last) 2-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\df\c0"                    ;; "ßÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; byte after (last) 2-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\df\fd"                    ;; "ßı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;;;; 3-byte sequences

;; 3-byte sequence contains 4 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\e1\80\80\80"              ;; "á"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 3-byte sequence contains 2 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\e1\80"                    ;; "á"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 3-byte sequence contains 2 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e1\80\2e"                 ;; "á."
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 3-byte sequence contains 1 byte at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0b"                       ;; import section
    "\01"                          ;; length 1
    "\01\e1"                       ;; "á"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 3-byte sequence contains 1 byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\e1\2e"                    ;; "á."
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;;;; 3-byte sequence contents

;; first byte after (0xe0) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e0\00\a0"                 ;; "à  "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xe0) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e0\7f\a0"                 ;; "à "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xe0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e0\80\80"                 ;; "à"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xe0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e0\80\a0"                 ;; "à "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xe0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e0\9f\a0"                 ;; "à "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xe0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e0\9f\bf"                 ;; "à¿"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xe0) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e0\c0\a0"                 ;; "àÀ "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xe0) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e0\fd\a0"                 ;; "àı "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (first normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e1\00\80"                 ;; "á "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (first normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e1\7f\80"                 ;; "á"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (first normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e1\c0\80"                 ;; "áÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (first normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e1\fd\80"                 ;; "áı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ec\00\80"                 ;; "ì "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ec\7f\80"                 ;; "ì"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ec\c0\80"                 ;; "ìÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ec\fd\80"                 ;; "ìı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xed) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ed\00\80"                 ;; "í "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xed) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ed\7f\80"                 ;; "í"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; byte sequence reserved for UTF-16 surrogate half
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ed\a0\80"                 ;; "í "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; byte sequence reserved for UTF-16 surrogate half
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ed\a0\bf"                 ;; "í ¿"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; byte sequence reserved for UTF-16 surrogate half
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ed\bf\80"                 ;; "í¿"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; byte sequence reserved for UTF-16 surrogate half
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ed\bf\bf"                 ;; "í¿¿"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xed) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ed\c0\80"                 ;; "íÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xed) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ed\fd\80"                 ;; "íı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ee\00\80"                 ;; "î "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ee\7f\80"                 ;; "î"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ee\c0\80"                 ;; "îÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ee\fd\80"                 ;; "îı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (last normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ef\00\80"                 ;; "ï "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (last normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ef\7f\80"                 ;; "ï"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (last normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ef\c0\80"                 ;; "ïÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (last normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ef\fd\80"                 ;; "ïı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;;;; 3-byte sequence contents (third byte)

;; second byte after (0xe0) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e0\a0\00"                 ;; "à  "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xe0) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e0\a0\7f"                 ;; "à "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xe0) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e0\a0\c0"                 ;; "à À"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xe0) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e0\a0\fd"                 ;; "à ı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (first normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e1\80\00"                 ;; "á "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (first normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e1\80\7f"                 ;; "á"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (first normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e1\80\c0"                 ;; "áÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (first normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\e1\80\fd"                 ;; "áı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ec\80\00"                 ;; "ì "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ec\80\7f"                 ;; "ì"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ec\80\c0"                 ;; "ìÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ec\80\fd"                 ;; "ìı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xed) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ed\80\00"                 ;; "í "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xed) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ed\80\7f"                 ;; "í"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xed) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ed\80\c0"                 ;; "íÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xed) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ed\80\fd"                 ;; "íı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ee\80\00"                 ;; "î "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ee\80\7f"                 ;; "î"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ee\80\c0"                 ;; "îÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ee\80\fd"                 ;; "îı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (last normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ef\80\00"                 ;; "ï "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (last normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ef\80\7f"                 ;; "ï"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (last normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ef\80\c0"                 ;; "ïÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (last normal) 3-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\ef\80\fd"                 ;; "ïı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;;;; 4-byte sequences

;; 4-byte sequence contains 5 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0f"                       ;; import section
    "\01"                          ;; length 1
    "\05\f1\80\80\80\80"           ;; "ñ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 4-byte sequence contains 3 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\f1\80\80"                 ;; "ñ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 4-byte sequence contains 3 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f1\80\80\23"              ;; "ñ#"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 4-byte sequence contains 2 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\f1\80"                    ;; "ñ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 4-byte sequence contains 2 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\f1\80\23"                 ;; "ñ#"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 4-byte sequence contains 1 byte at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0b"                       ;; import section
    "\01"                          ;; length 1
    "\01\f1"                       ;; "ñ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 4-byte sequence contains 1 byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\f1\23"                    ;; "ñ#"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;;;; 4-byte sequence contents

;; first byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f0\00\90\90"              ;; "ğ "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f0\7f\90\90"              ;; "ğ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xf0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f0\80\80\80"              ;; "ğ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xf0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f0\80\90\90"              ;; "ğ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xf0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f0\8f\90\90"              ;; "ğ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; overlong encoding after 0xf0 prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f0\8f\bf\bf"              ;; "ğ¿¿"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f0\c0\90\90"              ;; "ğÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f0\fd\90\90"              ;; "ğı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f1\00\80\80"              ;; "ñ "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f1\7f\80\80"              ;; "ñ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f1\c0\80\80"              ;; "ñÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f1\fd\80\80"              ;; "ñı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f3\00\80\80"              ;; "ó "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f3\7f\80\80"              ;; "ó"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f3\c0\80\80"              ;; "óÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f3\fd\80\80"              ;; "óı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f4\00\80\80"              ;; "ô "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f4\7f\80\80"              ;; "ô"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; (first) invalid code point
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f4\90\80\80"              ;; "ô"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; invalid code point
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f4\bf\80\80"              ;; "ô¿"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f4\c0\80\80"              ;; "ôÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; first byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f4\fd\80\80"              ;; "ôı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; (first) invalid 4-byte prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f5\80\80\80"              ;; "õ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; (last) invalid 4-byte prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f7\80\80\80"              ;; "÷"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; (last) invalid 4-byte prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f7\bf\bf\bf"              ;; "÷¿¿¿"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;;;; 4-byte sequence contents (third byte)

;; second byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f0\90\00\90"              ;; "ğ "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f0\90\7f\90"              ;; "ğ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f0\90\c0\90"              ;; "ğÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f0\90\fd\90"              ;; "ğı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f1\80\00\80"              ;; "ñ "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f1\80\7f\80"              ;; "ñ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f1\80\c0\80"              ;; "ñÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f1\80\fd\80"              ;; "ñı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f3\80\00\80"              ;; "ó "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f3\80\7f\80"              ;; "ó"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f3\80\c0\80"              ;; "óÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f3\80\fd\80"              ;; "óı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f4\80\00\80"              ;; "ô "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f4\80\7f\80"              ;; "ô"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f4\80\c0\80"              ;; "ôÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; second byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f4\80\fd\80"              ;; "ôı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;;;; 4-byte sequence contents (fourth byte)

;; third byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f0\90\90\00"              ;; "ğ "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; third byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f0\90\90\7f"              ;; "ğ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; third byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f0\90\90\c0"              ;; "ğÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; third byte after (0xf0) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f0\90\90\fd"              ;; "ğı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; third byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f1\80\80\00"              ;; "ñ "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; third byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f1\80\80\7f"              ;; "ñ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; third byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f1\80\80\c0"              ;; "ñÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; third byte after (first normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f1\80\80\fd"              ;; "ñı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; third byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f3\80\80\00"              ;; "ó "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; third byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f3\80\80\7f"              ;; "ó"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; third byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f3\80\80\c0"              ;; "óÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; third byte after (last normal) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f3\80\80\fd"              ;; "óı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; third byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f4\80\80\00"              ;; "ô "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; third byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f4\80\80\7f"              ;; "ô"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; third byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f4\80\80\c0"              ;; "ôÀ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; third byte after (0xf4) 4-byte prefix not a continuation byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f4\80\80\fd"              ;; "ôı"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;;;; 5-byte sequences

;; 5-byte sequence contains 6 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\10"                       ;; import section
    "\01"                          ;; length 1
    "\06\f8\80\80\80\80\80"        ;; "ø"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 5-byte sequence contains 4 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f8\80\80\80"              ;; "ø"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 5-byte sequence contains 4 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0f"                       ;; import section
    "\01"                          ;; length 1
    "\05\f8\80\80\80\23"           ;; "ø#"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 5-byte sequence contains 3 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\f8\80\80"                 ;; "ø"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 5-byte sequence contains 3 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\f8\80\80\23"              ;; "ø#"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 5-byte sequence contains 2 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\f8\80"                    ;; "ø"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 5-byte sequence contains 2 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\f8\80\23"                 ;; "ø#"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 5-byte sequence contains 1 byte at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0b"                       ;; import section
    "\01"                          ;; length 1
    "\01\f8"                       ;; "ø"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 5-byte sequence contains 1 byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\f8\23"                    ;; "ø#"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;;;; 5-byte sequence contents

;; (first) invalid 5-byte prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0f"                       ;; import section
    "\01"                          ;; length 1
    "\05\f8\80\80\80\80"           ;; "ø"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; (last) invalid 5-byte prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0f"                       ;; import section
    "\01"                          ;; length 1
    "\05\fb\bf\bf\bf\bf"           ;; "û¿¿¿¿"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;;;; 6-byte sequences

;; 6-byte sequence contains 7 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\11"                       ;; import section
    "\01"                          ;; length 1
    "\07\fc\80\80\80\80\80\80"     ;; "ü"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 5 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0f"                       ;; import section
    "\01"                          ;; length 1
    "\05\fc\80\80\80\80"           ;; "ü"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 5 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\10"                       ;; import section
    "\01"                          ;; length 1
    "\06\fc\80\80\80\80\23"        ;; "ü#"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 4 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\fc\80\80\80"              ;; "ü"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 4 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0f"                       ;; import section
    "\01"                          ;; length 1
    "\05\fc\80\80\80\23"           ;; "ü#"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 3 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\fc\80\80"                 ;; "ü"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 3 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\fc\80\80\23"              ;; "ü#"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 2 bytes at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\fc\80"                    ;; "ü"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 2 bytes
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0d"                       ;; import section
    "\01"                          ;; length 1
    "\03\fc\80\23"                 ;; "ü#"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 1 byte at end of string
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0b"                       ;; import section
    "\01"                          ;; length 1
    "\01\fc"                       ;; "ü"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; 6-byte sequence contains 1 byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\fc\23"                    ;; "ü#"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;;;; 6-byte sequence contents

;; (first) invalid 6-byte prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\10"                       ;; import section
    "\01"                          ;; length 1
    "\06\fc\80\80\80\80\80"        ;; "ü"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; (last) invalid 6-byte prefix
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\10"                       ;; import section
    "\01"                          ;; length 1
    "\06\fd\bf\bf\bf\bf\bf"        ;; "ı¿¿¿¿¿"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;;;; Miscellaneous invalid bytes

;; invalid byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0b"                       ;; import section
    "\01"                          ;; length 1
    "\01\fe"                       ;; "ş"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; invalid byte
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0b"                       ;; import section
    "\01"                          ;; length 1
    "\01\ff"                       ;; "ÿ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; UTF-16BE BOM
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\fe\ff"                    ;; "şÿ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; UTF-32BE BOM
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\00\00\fe\ff"              ;; "  şÿ"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; UTF-16LE BOM
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0c"                       ;; import section
    "\01"                          ;; length 1
    "\02\ff\fe"                    ;; "ÿş"
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)

;; UTF-32LE BOM
(assert_malformed
  (module
    "\00asm" "\01\00\00\00"
    "\02\0e"                       ;; import section
    "\01"                          ;; length 1
    "\04\ff\fe\00\00"              ;; "ÿş  "
    "\04\74\65\73\74"              ;; "test"
    "\03"                          ;; GlobalImport
    "\7f"                          ;; i32
    "\00"                          ;; immutable
  )
  "invalid UTF-8 encoding"
)


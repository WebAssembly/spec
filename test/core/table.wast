;; Duplicate table identifiers

(assert_malformed (module quote
  "(table $foo 1 funcref)"
  "(table $foo 1 funcref)")
  "duplicate table")
(assert_malformed (module quote
  "(import \"\" \"\" (table $foo 1 funcref))"
  "(table $foo 1 funcref)")
  "duplicate table")
(assert_malformed (module quote
  "(import \"\" \"\" (table $foo 1 funcref))"
  "(import \"\" \"\" (table $foo 1 funcref))")
  "duplicate table")

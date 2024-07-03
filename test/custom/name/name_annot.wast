;; Module names

(module (@name "Modül"))

(module $moduel (@name "Modül"))

(assert_malformed_custom
  (module quote "(module (@name \"M1\") (@name \"M2\"))")
  "@name annotation: multiple module"
)

(assert_malformed_custom
  (module quote "(module (func) (@name \"M\"))")
  "misplaced @name annotation"
)

(assert_malformed_custom
  (module quote "(module (start $f (@name \"M\")) (func $f))")
  "misplaced @name annotation"
)

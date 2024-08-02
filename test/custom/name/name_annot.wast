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


;; Function names

(module
  (type $t (func))
  (func (@name "λ") (type $t))
  (func $lambda (@name "λ") (type $t))
)


;; Tag names

(module
  (type $t (func))
  (tag (@name "θ") (type $t))
  (tag $theta (@name "θ") (type $t))
)

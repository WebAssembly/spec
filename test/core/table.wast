(assert_invalid
  (module (type $t (func)) (table 1 (ref $t)))
  "non-defaultable element type"
)

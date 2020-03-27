(module (table 1 (ref any)))
(module (table 1 (ref func)))
(module (table 1 (ref null)))
(module (table 1 (ref null $t)) (type $t (func)))

(assert_invalid
  (module (type $t (func)) (table 1 (ref $t)))
  "non-defaultable element type"
)

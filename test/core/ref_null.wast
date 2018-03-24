(module
  (func (export "eqref") (result eqref) (ref.null))
  (func (export "anyref") (result anyref) (ref.null))
  (func (export "anyfunc") (result anyfunc) (ref.null))
)

(assert_return (invoke "eqref") (ref.null))
(assert_return (invoke "anyref") (ref.null))
(assert_return (invoke "anyfunc") (ref.null))

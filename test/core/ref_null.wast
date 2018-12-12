(module
  (func (export "anyref") (result anyref) (ref.null))
  (func (export "funcref") (result funcref) (ref.null))
)

(assert_return (invoke "anyref") (ref.null))
(assert_return (invoke "funcref") (ref.null))

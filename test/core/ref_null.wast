(module
  (type $t (func))
  (func (export "anyref") (result anyref) (ref.null any))
  (func (export "funcref") (result funcref) (ref.null func))
  (func (export "ref") (result (ref null $t)) (ref.null $t))

  (global anyref (ref.null any))
  (global funcref (ref.null func))
  (global (ref null $t) (ref.null $t))
)

(assert_return (invoke "anyref") (ref.null any))
(assert_return (invoke "funcref") (ref.null func))
(assert_return (invoke "ref") (ref.null))


(module
  (type $t (func))
  (global $null nullref (ref.null none))
  (func (export "nullref") (result nullref) (global.get $null))
  (func (export "anyref") (result anyref) (global.get $null))
  (func (export "funcref") (result funcref) (global.get $null))
  (func (export "ref") (result (ref null $t)) (global.get $null))

  (global nullref (ref.null none))
  (global anyref (ref.null none))
  (global funcref (ref.null none))
  (global (ref null $t) (ref.null none))
)

(assert_return (invoke "nullref") (ref.null none))
(assert_return (invoke "anyref") (ref.null any))
(assert_return (invoke "funcref") (ref.null func))
(assert_return (invoke "ref") (ref.null))

(module
  (type (array i8))
  (type (array i16))
  (type (array i32))
  (type (array i64))
  (type (array f32))
  (type (array f64))
  (type (array anyref))
  (type (array (ref data)))
  (type (array (ref 0)))
  (type (array (ref null 1)))
  (type (array (rtt 1)))
  (type (array (rtt 10 1)))
  (type (array (mut i8)))
  (type (array (mut i16)))
  (type (array (mut i32)))
  (type (array (mut i64)))
  (type (array (mut i32)))
  (type (array (mut i64)))
  (type (array (mut anyref)))
  (type (array (mut (ref data))))
  (type (array (mut (ref 0))))
  (type (array (mut (ref null i31))))
  (type (array (mut (rtt 0))))
  (type (array (mut (rtt 10 0))))
)


(assert_invalid
  (module
    (type (array (mut (ref null 10))))
  )
  "unknown type"
)

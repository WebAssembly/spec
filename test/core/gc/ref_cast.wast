(module
  (type $t0 (struct))
  (type $t1 (sub $t0 (struct (field i32))))
  (type $t1' (sub $t0 (struct (field i32))))
  (type $t2 (sub $t1 (struct (field i32 i32))))
  (type $t2' (sub $t1' (struct (field i32 i32))))
  (type $t3 (sub $t0 (struct (field i32 i32))))
  (type $t0' (sub $t0 (struct)))
  (type $t4 (sub $t0' (struct (field i32 i32))))

  (table 20 (ref null data))

  (func $init
    (table.set (i32.const 0) (struct.new_canon_default $t0))
    (table.set (i32.const 10) (struct.new_canon_default $t0))
    (table.set (i32.const 1) (struct.new_canon_default $t1))
    (table.set (i32.const 11) (struct.new_canon_default $t1'))
    (table.set (i32.const 2) (struct.new_canon_default $t2))
    (table.set (i32.const 12) (struct.new_canon_default $t2'))
    (table.set (i32.const 3) (struct.new_canon_default $t3))
    (table.set (i32.const 4) (struct.new_canon_default $t4))
  )

  (func (export "test-sub")
    (call $init)

    (drop (ref.cast_canon $t0 (ref.null data)))
    (drop (ref.cast_canon $t0 (table.get (i32.const 0))))
    (drop (ref.cast_canon $t0 (table.get (i32.const 1))))
    (drop (ref.cast_canon $t0 (table.get (i32.const 2))))
    (drop (ref.cast_canon $t0 (table.get (i32.const 3))))
    (drop (ref.cast_canon $t0 (table.get (i32.const 4))))

    (drop (ref.cast_canon $t0 (ref.null data)))
    (drop (ref.cast_canon $t1 (table.get (i32.const 1))))
    (drop (ref.cast_canon $t1 (table.get (i32.const 2))))

    (drop (ref.cast_canon $t0 (ref.null data)))
    (drop (ref.cast_canon $t2 (table.get (i32.const 2))))

    (drop (ref.cast_canon $t0 (ref.null data)))
    (drop (ref.cast_canon $t3 (table.get (i32.const 3))))

    (drop (ref.cast_canon $t0 (ref.null data)))
    (drop (ref.cast_canon $t4 (table.get (i32.const 4))))
  )

  (func (export "test-canon")
    (call $init)

    (drop (ref.cast_canon $t0 (table.get (i32.const 0))))
    (drop (ref.cast_canon $t0 (table.get (i32.const 1))))
    (drop (ref.cast_canon $t0 (table.get (i32.const 2))))
    (drop (ref.cast_canon $t0 (table.get (i32.const 3))))
    (drop (ref.cast_canon $t0 (table.get (i32.const 4))))

    (drop (ref.cast_canon $t0 (table.get (i32.const 10))))
    (drop (ref.cast_canon $t0 (table.get (i32.const 11))))
    (drop (ref.cast_canon $t0 (table.get (i32.const 12))))

    (drop (ref.cast_canon $t1' (table.get (i32.const 1))))
    (drop (ref.cast_canon $t1' (table.get (i32.const 2))))

    (drop (ref.cast_canon $t1 (table.get (i32.const 11))))
    (drop (ref.cast_canon $t1 (table.get (i32.const 12))))

    (drop (ref.cast_canon $t2' (table.get (i32.const 2))))

    (drop (ref.cast_canon $t2 (table.get (i32.const 12))))
  )
)

(invoke "test-sub")
(invoke "test-canon")


(module
  (import "env" "memory" (memory $0 256))
  (func (export "_main") (param i32) (param i32)
     (local $n i32)
     (local $m i32)
     (local $f1 f32)
     (local $f2 f32)
     (set_local $n (i32.const 100))
     (set_local $m (i32.const 3))
     (set_local $f1 (f32.convert_s/i32 (get_local $n)))
     (set_local $f2 (f32.convert_s/i32 (get_local $m)))
     (set_local $f1 (f32.div (get_local $f1) (get_local $f2)))
     (set_local $n (i32.trunc_s/f32 (get_local $f1)))
  )
)

(invoke "_main" (i32.const 0) (i32.const 0))


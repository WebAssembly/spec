;;
;; Generated by ../meta/generate_memory_fill.js
;; DO NOT EDIT THIS FILE.  CHANGE THE SOURCE AND REGENERATE.
;;

(script
(module
  (memory 1 1)
  
  (func (export "checkRange") (param $from i32) (param $to i32) (param $expected i32) (result i32)
    (loop $cont
      (if (i32.eq (local.get $from) (local.get $to))
        (then
          (return (i32.const -1))))
      (if (i32.eq (i32.load8_u (local.get $from)) (local.get $expected))
        (then
          (local.set $from (i32.add (local.get $from) (i32.const 1)))
          (br $cont))))
    (return (local.get $from)))

  (func (export "test")
    (memory.fill (i32.const 0xFF00) (i32.const 0x55) (i32.const 256))))
(invoke "test")

(assert_return (invoke "checkRange" (i32.const 0) (i32.const 65280) (i32.const 0))
               (i32.const -1))
(assert_return (invoke "checkRange" (i32.const 65280) (i32.const 65536) (i32.const 85))
               (i32.const -1))
)
(script
(module
  (memory 1 1)
  
  (func (export "checkRange") (param $from i32) (param $to i32) (param $expected i32) (result i32)
    (loop $cont
      (if (i32.eq (local.get $from) (local.get $to))
        (then
          (return (i32.const -1))))
      (if (i32.eq (i32.load8_u (local.get $from)) (local.get $expected))
        (then
          (local.set $from (i32.add (local.get $from) (i32.const 1)))
          (br $cont))))
    (return (local.get $from)))

  (func (export "test")
    (memory.fill (i32.const 0xFF00) (i32.const 0x55) (i32.const 257))))
(assert_trap (invoke "test") "out of bounds memory access")
)

(script
(module
  (memory 1 1)
  
  (func (export "checkRange") (param $from i32) (param $to i32) (param $expected i32) (result i32)
    (loop $cont
      (if (i32.eq (local.get $from) (local.get $to))
        (then
          (return (i32.const -1))))
      (if (i32.eq (i32.load8_u (local.get $from)) (local.get $expected))
        (then
          (local.set $from (i32.add (local.get $from) (i32.const 1)))
          (br $cont))))
    (return (local.get $from)))

  (func (export "test")
    (memory.fill (i32.const 0xFFFFFF00) (i32.const 0x55) (i32.const 257))))
(assert_trap (invoke "test") "out of bounds memory access")
)

(script
(module
  (memory 1 1)
  
  (func (export "checkRange") (param $from i32) (param $to i32) (param $expected i32) (result i32)
    (loop $cont
      (if (i32.eq (local.get $from) (local.get $to))
        (then
          (return (i32.const -1))))
      (if (i32.eq (i32.load8_u (local.get $from)) (local.get $expected))
        (then
          (local.set $from (i32.add (local.get $from) (i32.const 1)))
          (br $cont))))
    (return (local.get $from)))

  (func (export "test")
    (memory.fill (i32.const 0x12) (i32.const 0x55) (i32.const 0))))
(invoke "test")

(assert_return (invoke "checkRange" (i32.const 0) (i32.const 65536) (i32.const 0))
               (i32.const -1))
)
(script
(module
  (memory 1 1)
  
  (func (export "checkRange") (param $from i32) (param $to i32) (param $expected i32) (result i32)
    (loop $cont
      (if (i32.eq (local.get $from) (local.get $to))
        (then
          (return (i32.const -1))))
      (if (i32.eq (i32.load8_u (local.get $from)) (local.get $expected))
        (then
          (local.set $from (i32.add (local.get $from) (i32.const 1)))
          (br $cont))))
    (return (local.get $from)))

  (func (export "test")
    (memory.fill (i32.const 0x10000) (i32.const 0x55) (i32.const 0))))
(invoke "test")
)

(script
(module
  (memory 1 1)
  
  (func (export "checkRange") (param $from i32) (param $to i32) (param $expected i32) (result i32)
    (loop $cont
      (if (i32.eq (local.get $from) (local.get $to))
        (then
          (return (i32.const -1))))
      (if (i32.eq (i32.load8_u (local.get $from)) (local.get $expected))
        (then
          (local.set $from (i32.add (local.get $from) (i32.const 1)))
          (br $cont))))
    (return (local.get $from)))

  (func (export "test")
    (memory.fill (i32.const 0x20000) (i32.const 0x55) (i32.const 0))))
(assert_trap (invoke "test") "out of bounds memory access")
)

(script
(module
  (memory 1 1)
  
  (func (export "checkRange") (param $from i32) (param $to i32) (param $expected i32) (result i32)
    (loop $cont
      (if (i32.eq (local.get $from) (local.get $to))
        (then
          (return (i32.const -1))))
      (if (i32.eq (i32.load8_u (local.get $from)) (local.get $expected))
        (then
          (local.set $from (i32.add (local.get $from) (i32.const 1)))
          (br $cont))))
    (return (local.get $from)))

  (func (export "test")
    (memory.fill (i32.const 0x1) (i32.const 0xAA) (i32.const 0xFFFE))))
(invoke "test")

(assert_return (invoke "checkRange" (i32.const 0) (i32.const 1) (i32.const 0))
               (i32.const -1))
(assert_return (invoke "checkRange" (i32.const 1) (i32.const 65535) (i32.const 170))
               (i32.const -1))
(assert_return (invoke "checkRange" (i32.const 65535) (i32.const 65536) (i32.const 0))
               (i32.const -1))
)

(script
(module
  (memory 1 1)
  
  (func (export "checkRange") (param $from i32) (param $to i32) (param $expected i32) (result i32)
    (loop $cont
      (if (i32.eq (local.get $from) (local.get $to))
        (then
          (return (i32.const -1))))
      (if (i32.eq (i32.load8_u (local.get $from)) (local.get $expected))
        (then
          (local.set $from (i32.add (local.get $from) (i32.const 1)))
          (br $cont))))
    (return (local.get $from)))

  (func (export "test")
     (memory.fill (i32.const 0x12) (i32.const 0x55) (i32.const 10))
     (memory.fill (i32.const 0x15) (i32.const 0xAA) (i32.const 4))))
(invoke "test")

(assert_return (invoke "checkRange" (i32.const 0) (i32.const 18) (i32.const 0))
               (i32.const -1))
(assert_return (invoke "checkRange" (i32.const 18) (i32.const 21) (i32.const 85))
               (i32.const -1))
(assert_return (invoke "checkRange" (i32.const 21) (i32.const 25) (i32.const 170))
               (i32.const -1))
(assert_return (invoke "checkRange" (i32.const 25) (i32.const 28) (i32.const 85))
               (i32.const -1))
(assert_return (invoke "checkRange" (i32.const 28) (i32.const 65536) (i32.const 0))
               (i32.const -1))
)
(assert_invalid
  (module
    (func (export "testfn")
      (memory.fill (i32.const 10) (i32.const 20) (i32.const 30))))
  "unknown memory 0")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i32.const 10) (i32.const 20) (f32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i32.const 10) (i32.const 20) (i64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i32.const 10) (i32.const 20) (f64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i32.const 10) (f32.const 20) (i32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i32.const 10) (f32.const 20) (f32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i32.const 10) (f32.const 20) (i64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i32.const 10) (f32.const 20) (f64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i32.const 10) (i64.const 20) (i32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i32.const 10) (i64.const 20) (f32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i32.const 10) (i64.const 20) (i64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i32.const 10) (i64.const 20) (f64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i32.const 10) (f64.const 20) (i32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i32.const 10) (f64.const 20) (f32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i32.const 10) (f64.const 20) (i64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i32.const 10) (f64.const 20) (f64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f32.const 10) (i32.const 20) (i32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f32.const 10) (i32.const 20) (f32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f32.const 10) (i32.const 20) (i64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f32.const 10) (i32.const 20) (f64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f32.const 10) (f32.const 20) (i32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f32.const 10) (f32.const 20) (f32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f32.const 10) (f32.const 20) (i64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f32.const 10) (f32.const 20) (f64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f32.const 10) (i64.const 20) (i32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f32.const 10) (i64.const 20) (f32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f32.const 10) (i64.const 20) (i64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f32.const 10) (i64.const 20) (f64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f32.const 10) (f64.const 20) (i32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f32.const 10) (f64.const 20) (f32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f32.const 10) (f64.const 20) (i64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f32.const 10) (f64.const 20) (f64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i64.const 10) (i32.const 20) (i32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i64.const 10) (i32.const 20) (f32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i64.const 10) (i32.const 20) (i64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i64.const 10) (i32.const 20) (f64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i64.const 10) (f32.const 20) (i32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i64.const 10) (f32.const 20) (f32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i64.const 10) (f32.const 20) (i64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i64.const 10) (f32.const 20) (f64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i64.const 10) (i64.const 20) (i32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i64.const 10) (i64.const 20) (f32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i64.const 10) (i64.const 20) (i64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i64.const 10) (i64.const 20) (f64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i64.const 10) (f64.const 20) (i32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i64.const 10) (f64.const 20) (f32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i64.const 10) (f64.const 20) (i64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (i64.const 10) (f64.const 20) (f64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f64.const 10) (i32.const 20) (i32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f64.const 10) (i32.const 20) (f32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f64.const 10) (i32.const 20) (i64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f64.const 10) (i32.const 20) (f64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f64.const 10) (f32.const 20) (i32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f64.const 10) (f32.const 20) (f32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f64.const 10) (f32.const 20) (i64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f64.const 10) (f32.const 20) (f64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f64.const 10) (i64.const 20) (i32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f64.const 10) (i64.const 20) (f32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f64.const 10) (i64.const 20) (i64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f64.const 10) (i64.const 20) (f64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f64.const 10) (f64.const 20) (i32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f64.const 10) (f64.const 20) (f32.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f64.const 10) (f64.const 20) (i64.const 30))))
  "type mismatch")

(assert_invalid
  (module
    (memory 1 1)
    (func (export "testfn")
      (memory.fill (f64.const 10) (f64.const 20) (f64.const 30))))
  "type mismatch")

(script
(module
  (memory 1 1 )
  
  (func (export "checkRange") (param $from i32) (param $to i32) (param $expected i32) (result i32)
    (loop $cont
      (if (i32.eq (local.get $from) (local.get $to))
        (then
          (return (i32.const -1))))
      (if (i32.eq (i32.load8_u (local.get $from)) (local.get $expected))
        (then
          (local.set $from (i32.add (local.get $from) (i32.const 1)))
          (br $cont))))
    (return (local.get $from)))

  (func (export "run") (param $offs i32) (param $val i32) (param $len i32)
    (memory.fill (local.get $offs) (local.get $val) (local.get $len))))

(assert_trap (invoke "run" (i32.const 65280) (i32.const 37) (i32.const 512))
              "out of bounds memory access")

(assert_return (invoke "checkRange" (i32.const 0) (i32.const 1) (i32.const 0))
               (i32.const -1))
)
(script
(module
  (memory 1 1 )
  
  (func (export "checkRange") (param $from i32) (param $to i32) (param $expected i32) (result i32)
    (loop $cont
      (if (i32.eq (local.get $from) (local.get $to))
        (then
          (return (i32.const -1))))
      (if (i32.eq (i32.load8_u (local.get $from)) (local.get $expected))
        (then
          (local.set $from (i32.add (local.get $from) (i32.const 1)))
          (br $cont))))
    (return (local.get $from)))

  (func (export "run") (param $offs i32) (param $val i32) (param $len i32)
    (memory.fill (local.get $offs) (local.get $val) (local.get $len))))

(assert_trap (invoke "run" (i32.const 65279) (i32.const 37) (i32.const 514))
              "out of bounds memory access")

(assert_return (invoke "checkRange" (i32.const 0) (i32.const 1) (i32.const 0))
               (i32.const -1))
)
(script
(module
  (memory 1 1 )
  
  (func (export "checkRange") (param $from i32) (param $to i32) (param $expected i32) (result i32)
    (loop $cont
      (if (i32.eq (local.get $from) (local.get $to))
        (then
          (return (i32.const -1))))
      (if (i32.eq (i32.load8_u (local.get $from)) (local.get $expected))
        (then
          (local.set $from (i32.add (local.get $from) (i32.const 1)))
          (br $cont))))
    (return (local.get $from)))

  (func (export "run") (param $offs i32) (param $val i32) (param $len i32)
    (memory.fill (local.get $offs) (local.get $val) (local.get $len))))

(assert_trap (invoke "run" (i32.const 65279) (i32.const 37) (i32.const 4294967295))
              "out of bounds memory access")

(assert_return (invoke "checkRange" (i32.const 0) (i32.const 1) (i32.const 0))
               (i32.const -1))
)

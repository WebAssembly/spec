;; Vaild alignment (align=1, 2, 4, 8, 16)

(module
  (memory 1)
  (data (i32.const 0) "\00\01\02\03\04\05\06\07\08\09\10\11\12\13\14\15")

  (func (export "v128.load_align_1") (result v128)
    (v128.load align=1 (i32.const 0))
  )
  (func (export "v128.load_align_2") (result v128)
    (v128.load align=2 (i32.const 0))
  )
  (func (export "v128.load_align_4") (result v128)
    (v128.load align=4 (i32.const 0))
  )
  (func (export "v128.load_align_8") (result v128)
    (v128.load align=8 (i32.const 0))
  )
  (func (export "v128.load_align_16") (result v128)
    (v128.load align=16 (i32.const 0))
  )

  (func (export "v128.store_align_1") (result v128)
    (v128.store align=1 (i32.const 0) (v128.const i32x4 0 1 2 3))
    (v128.load (i32.const 0))
  )
  (func (export "v128.store_align_2") (result v128)
    (v128.store align=2 (i32.const 0) (v128.const i32x4 0 1 2 3))
    (v128.load (i32.const 0))
  )
  (func (export "v128.store_align_4") (result v128)
    (v128.store align=4 (i32.const 0) (v128.const i32x4 0 1 2 3))
    (v128.load (i32.const 0))
  )
  (func (export "v128.store_align_8") (result v128)
    (v128.store align=8 (i32.const 0) (v128.const i32x4 0 1 2 3))
    (v128.load (i32.const 0))
  )
  (func (export "v128.store_align_16") (result v128)
    (v128.store align=16 (i32.const 0) (v128.const i32x4 0 1 2 3))
    (v128.load (i32.const 0))
  )
)

(assert_return (invoke "v128.load_align_1") (v128.const i32x4 0x03020100 0x07060504 0x11100908 0x15141312))
(assert_return (invoke "v128.load_align_2") (v128.const i32x4 0x03020100 0x07060504 0x11100908 0x15141312))
(assert_return (invoke "v128.load_align_4") (v128.const i32x4 0x03020100 0x07060504 0x11100908 0x15141312))
(assert_return (invoke "v128.load_align_8") (v128.const i32x4 0x03020100 0x07060504 0x11100908 0x15141312))
(assert_return (invoke "v128.load_align_16") (v128.const i32x4 0x03020100 0x07060504 0x11100908 0x15141312))

(assert_return (invoke "v128.store_align_1") (v128.const i32x4 0 1 2 3))
(assert_return (invoke "v128.store_align_2") (v128.const i32x4 0 1 2 3))
(assert_return (invoke "v128.store_align_4") (v128.const i32x4 0 1 2 3))
(assert_return (invoke "v128.store_align_8") (v128.const i32x4 0 1 2 3))
(assert_return (invoke "v128.store_align_16") (v128.const i32x4 0 1 2 3))


;; Invalid alignment

(assert_invalid
  (module
    (memory 1)
    (func (drop (v128.load align=32 (i32.const 0))))
  )
  "alignment must not be larger than natural"
)
(assert_malformed
  (module quote
    "(memory 1)"
    "(func (drop (v128.load align=-1 (i32.const 0))))"
  )
  "unknown operator"
)
(assert_malformed
  (module quote
    "(memory 1)"
    "(func (drop (v128.load align=0 (i32.const 0))))"
  )
  "alignment must be a power of two"
)
(assert_malformed
  (module quote
    "(memory 1)"
    "(func (drop (v128.load align=7 (i32.const 0))))"
  )
  "alignment must be a power of two"
)

(assert_invalid
  (module
    (memory 0)
    (func(v128.store align=32 (i32.const 0) (v128.const i32x4 0 0 0 0)))
  )
  "alignment must not be larger than natural"
)
(assert_malformed
  (module quote
    "(memory 1)"
    " (func (v128.store align=-1 (i32.const 0) (v128.const i32x4 0 0 0 0)))"
  )
  "unknown operator"
)
(assert_malformed
  (module quote
    "(memory 0)"
    " (func (v128.store align=0 (i32.const 0) (v128.const i32x4 0 0 0 0)))"
  )
  "alignment must be a power of two"
)
(assert_malformed
  (module quote
    "(memory 0)"
    " (func (v128.store align=7 (i32.const 0) (v128.const i32x4 0 0 0 0)))"
  )
  "alignment must be a power of two"
)

;; Test that misaligned SIMD loads/stores don't trap

(module
  (memory 1 1)
  (func (export "v128.load align=16") (param $address i32) (result v128)
    (v128.load align=16 (local.get $address))
  )
  (func (export "v128.store align=16") (param $address i32) (param $value v128)
    (v128.store align=16 (local.get $address) (local.get $value))
  )
)

(assert_return (invoke "v128.load align=16" (i32.const 0)) (v128.const i32x4 0 0 0 0))
(assert_return (invoke "v128.load align=16" (i32.const 1)) (v128.const i32x4 0 0 0 0))
(assert_return (invoke "v128.store align=16" (i32.const 1) (v128.const i8x16 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16)))
(assert_return (invoke "v128.load align=16" (i32.const 0)) (v128.const i8x16 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15))

;; Test aligned and unaligned read/write

(module
  (memory 1)
  (func (export "v128_unalign_read_and_write") (result v128)
    (local v128)
    (v128.store (i32.const 0) (v128.const i8x16 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15))
    (v128.load (i32.const 0))
  )
  (func (export "v128_aligned_read_and_write") (result v128)
    (local v128)
    (v128.store align=2 (i32.const 0) (v128.const i16x8 0 1 2 3 4 5 6 7))
    (v128.load align=2  (i32.const 0))
  )
  (func (export "v128_aligned_read_and_unalign_write") (result v128)
    (local v128)
    (v128.store (i32.const 0) (v128.const i32x4 0 1 2 3))
    (v128.load align=2 (i32.const 0))
  )
  (func (export "v128_unalign_read_and_aligned_write") (result v128)
    (local v128)
    (v128.store align=2 (i32.const 0) (v128.const i32x4 0 1 2 3))
    (v128.load (i32.const 0))
  )
)

(assert_return (invoke "v128_unalign_read_and_write") (v128.const i8x16 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15))
(assert_return (invoke "v128_aligned_read_and_write") (v128.const i16x8 0 1 2 3 4 5 6 7))
(assert_return (invoke "v128_aligned_read_and_unalign_write") (v128.const i32x4 0 1 2 3))
(assert_return (invoke "v128_unalign_read_and_aligned_write") (v128.const i32x4 0 1 2 3))

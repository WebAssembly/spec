# Generated SIMD Spec Tests from gen_tests.py

`gen_tests.py` builds partial SIMD spec tests using templates in `simd_*.py`.
Currently it only support following simd test files generation.

- 'simd_i8x16_cmp.wast'
- 'simd_i16x8_cmp.wast'
- 'simd_i32x4_cmp.wast'
- 'simd_f32x4_cmp.wast'
- 'simd_f64x2_cmp.wast'
- 'simd_i8x16_arith.wast'
- 'simd_i8x16_arith2.wast'
- 'simd_i16x8_arith.wast'
- 'simd_i16x8_arith2.wast'
- 'simd_i32x4_arith.wast'
- 'simd_i32x4_arith2.wast'
- 'simd_f32x4_arith.wast'
- 'simd_i64x2_arith.wast'
- 'simd_f64x2_arith.wast'
- 'simd_bitwise.wast'
- 'simd_i8x16_sat_arith.wast'
- 'simd_i16x8_sat_arith.wast'
- 'simd_f32x4.wast'
- 'simd_f64x2.wast'


Usage:

```
$ python gen_tests.py -a
```

This script requires Python 3.6+, more details are documented in `gen_tests.py`.

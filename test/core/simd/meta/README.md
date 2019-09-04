# Generated SIMD Spec Tests from gen_tests.py

`gen_tests.py` builds partial SIMD spec tests using templates in `simd_*.py`.
Currently it only support following simd test files generation.

- 'simd_i8x16_cmp.wast'
- 'simd_i16x8_cmp.wast'
- 'simd_i32x4_cmp.wast'
- 'simd_f32x4_cmp.wast'


Usage:

```
$ python gen_tests.py -a
```

More details documented in `gen_tests.py`.

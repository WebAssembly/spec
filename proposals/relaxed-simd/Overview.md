# Relaxed SIMD proposal

## Summary

This proposal adds a set of useful SIMD instructions that introduce local
non-determinism (where the results of the instructions may vary based on
hardware support).

## Motivation

Applications running on Wasm SIMD cannot take full advantage of hardware
capabilities. There are 3 reasons:

1. Instruction depends on hardware support
2. Approximate instructions that are underspecified in hardware
3. Some SIMD instructions penalize particular architecture

See [these
slides](https://docs.google.com/presentation/d/1Qnx0nbNTRYhMONLuKyygEduCXNOv3xtWODfXfYokx1Y/edit?usp=sharing)
for more details.

## Overview

Broadly, there are three categories of instructions that fit into the Relaxed SIMD proposal:

1. Integer instructions where the inputs are interpreted differently (e.g.
   swizzle,  4-D dot-product)
2. Floating-point instructions whose behavior for out-of-range and NaNs differ
   (e.g. float-to-int conversions, float min/max)
3. Floating-point instructions where the precision or order of operations
   differ (e.g. FMA, reciprocal instructions, sum reduction)

Example of some instructions we would like to add:

- Fused Multiply Add (single rounding if hardware supports it, double rounding if not)
- Approximate reciprocal/reciprocal sqrt
- Relaxed Swizzle (implementation defined out of bounds behavior)
- Relaxed Rounding Q-format Multiplication (optional saturation)

### Consistency

This proposal introduces non-deterministic instructions - given the same
inputs, two calls to the same instruction can return different results. For
example:

```wast
(module
  (func (param v128 v128 v128)
    (f32x4.qfma (local.get 0) (local.get 1) (local.get 2))   ;; (1)
    ;; some other computation
    (f32x4.qfma (local.get 0) (local.get 1) (local.get 2)))) ;; (2)
```

The same instruction at `(1)` and `(2)`, when given the same inputs, can return
two different results. This is compliant as the instruction is
non-deterministic, though unlikely on certain embeddings like the Web (where
the same implementation for `f32x4.qfma` is likely to be used for all calls to
that instruction). One can imagine splitting an application's module and
running them on multiple runtimes, where the runtimes produce
different results - this can be surprising to the application.

Applications can specify their consistency needs using a new module-level
entity `fpenv` (name subject to change). A `fpenv` is defined in the `fpenv`
section of a module.  All Relaxed SIMD instructions will take an additional
`varuint32` immediate, which is an index into the `fpenv` index space:

```wast
(module
  (func (param v128 v128 v128)
    (f32x4.qfma $fpu (local.get 0) (local.get 1) (local.get 2)) ;; (1)
    ;; ...
    (f32x4.qfma $fpu (local.get 0) (local.get 1) (local.get 2)) ;; (2)
  )
  (fpenv $fpu 0))
```

In the example above, both `f32x4.qfma` instructions refer to the same `fpenv`,
and will get the same results when given the same input.

A `fpenv` has a single `varuint32` attribute which is reserved for future
extensibility and must be `0` for now.  The value of an `fpenv` is
non-deterministically computed when the module which declares it is
instantiated.  This value determines the semantics of the instructions that
uses it as an immediate.

As such, all the non-determinism of Relaxed SIMD is encapsulated in `fpenv`,
which makes Relaxed SIMD instructions themselves deterministic.

Modules can import/export an `fpenv` to specify consistency requirements:

```wast
;; module a
(module
  (fpenv $fpu (export "foo") 0)
  (func (param v128 v128 v128)
    (f32x4.qfma $fpu (local.get 0) (local.get 1) (local.get 2)))) ;; (1)
```

```wast
;; module b
(module
  (import "a" "foo" (fpenv $fpu 0))
  (func (param v128 v128 v128)
    (f32x4.qfma $fpu (local.get 0) (local.get 1) (local.get 2)))) ;; (2)
```

In the above example, the same `fpenv` is exported by module `a`, and imported
by module `b`, so instructions `(1)` and `(2)` will consistently return the
same results when given the same inputs.

## Instructions

### Relaxed swizzle

- `relaxed i8x16.swizzle(a : v128, s : v128) -> v128`

`relaxed i8x16.swizzle(a, s)` selects lanes from `a` using indices in `s`, indices in the range `[0,15]` will select the `i`-th element of `a`, the result for any out of range indices is implementation-defined (i.e. if the index is `[16-255]`.

```python
def relaxed_i8x16_swizzle(a, s):
    result = []
    for i in range(16):
        if s[i] < 16:
            result[i] = a[s[i]]
        else:
            result[i] = UNDEFINED
    return result
```

### Float/Double to int conversions

- `relaxed i32x4.trunc_f32x4_s` (relaxed version of `i32x4.trunc_sat_f32x4_s`)
- `relaxed i32x4.trunc_f32x4_u` (relaxed version of `i32x4.trunc_sat_f32x4_u`)
- `relaxed i32x4.trunc_f64x2_s_zero` (relaxed version of `i32x4.trunc_sat_f64x2_s_zero`)
- `relaxed i32x4.trunc_f64x2_u_zero` (relaxed version of `i32x4.trunc_sat_f64x2_u_zero`)

These instructions have the same behavior as the non-relaxed instructions for
lanes that are in the range of an `i32` (signed or unsigned depending on the
instruction). For lanes that contain values which are out of bounds or NaN, the
result is implementation-defined.

```python
def relaxed_i32x4_trunc_f32x4(a : f32x4, signed : bool) -> i32x4:
    result = []
    min = signed ? INT32_MIN : UINT32_MIN
    max = signed ? INT32_MAX : UINT32_MAX
    for i in range(4):
      r = truncate(a[i])
      if min <= r <= max:
        result[i] = r
      else:
        result[i] = UNDEFINED

def relaxed_i32x4_trunc_f64x2_zero(a : f64x2, signed : bool) -> i32x4:
    result = [0, 0, 0, 0]
    min = signed ? INT32_MIN : UINT32_MIN
    max = signed ? INT32_MAX : UINT32_MAX
    for i in range(2):
      r = truncate(a[i])
      if min <= r <= max:
        result[i] = r
      else:
        result[i] = UNDEFINED
```

### Relaxed fused multiply-add and fused multiply-subtract

- `relaxed f32x4.fma`
- `relaxed f32x4.fms`
- `relaxed f64x2.fma`
- `relaxed f64x2.fms`

All the instructions take 3 operands, `a`, `b`, `c`, perform `a + (b * c)` or `a - (b * c)`:

- `relaxed f32x4.fma(a, b, c) = a + (b * c)`
- `relaxed f32x4.fms(a, b, c) = a - (b * c)`
- `relaxed f64x2.fma(a, b, c) = a + (b * c)`
- `relaxed f64x2.fms(a, b, c) = a - (b * c)`

where:

- the intermediate `b * c` is be rounded first, and the final result rounded again (for a total of 2 roundings), or
- the the entire expression evaluated with higher precision and then only rounded once (if supported by hardware).

### Relaxed bitselect (blend/laneselect)

- `i8x16.blend(a: v128, b: v128, m: v128) -> v128`
- `i16x8.blend(a: v128, b: v128, m: v128) -> v128`
- `i32x4.blend(a: v128, b: v128, m: v128) -> v128`
- `i64x2.blend(a: v128, b: v128, m: v128) -> v128`

Select lanes from `a` or `b` based on masks in `m`. If each lane-sized mask in `m` has all bits set or all bits unset, these instructions behave the same as `v128.bitselect`. Otherwise, the result is implementation defined.

```python
def blend(a : v128, b : v128, m: v128, lanes : int):
  result = []
  for i in range(lanes):
    mask = m[i]
    if mask == ~0:
      result[i] = a[i]
    elif mask == 0:
      result[i] = b[i]
    else:
      result[i] = UNDEFINED
  return result
```

## Binary format

> This is a placeholder for binary format of instructions and new constructs.

## References

- Poll for phase 1
  [presentation](https://docs.google.com/presentation/d/1Qnx0nbNTRYhMONLuKyygEduCXNOv3xtWODfXfYokx1Y/edit?usp=sharing)
  and [meeting
  notes](https://github.com/WebAssembly/meetings/blob/master/main/2021/CG-03-16.md)
- [SIMD proposal](https://github.com/WebAssembly/simd)

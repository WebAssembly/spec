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

The specification is updated with the idea of "Relaxed operations":

> Some operators are host-dependent, because the set of possible results may
> depend on properties of the host environment (such as hardware). Technically,
> each such operator produces a fixed-size list of sets of allowed values. For
> each execution of the operator in the same environment, only values from the
> set at the same position in the list are returned, i.e., each environment
> globally chooses a fixed projection for each operator.

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

### Relaxed laneselect

- `i8x16.laneselect(a: v128, b: v128, m: v128) -> v128`
- `i16x8.laneselect(a: v128, b: v128, m: v128) -> v128`
- `i32x4.laneselect(a: v128, b: v128, m: v128) -> v128`
- `i64x2.laneselect(a: v128, b: v128, m: v128) -> v128`

Select lanes from `a` or `b` based on masks in `m`. If each lane-sized mask in `m` has all bits set or all bits unset, these instructions behave the same as `v128.bitselect`. Otherwise, the result is implementation defined.

```python
def laneselect(a : v128, b : v128, m: v128, lanes : int):
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

### Relaxed min and max

- `f32x4.min(a: v128, b: v128) -> v128`
- `f32x4.max(a: v128, b: v128) -> v128`
- `f64x2.min(a: v128, b: v128) -> v128`
- `f64x2.max(a: v128, b: v128) -> v128`

Return the lane-wise minimum or maximum of two values. If either values is NaN, or the values are -0.0 and +0.0, the return value is implementation-defined.

```python
def min_or_max(a : v128, b : v128, lanes : int, is_min : bool):
  result = []
  for i in range(lanes):
    if isNaN(a[i]) or isNaN(b[i]):
      result[i] = IMPLEMENTATION_DEFINED_ONE_OF(a[i], b[i])
    elif (a[i] == -0.0 && b[i] == +0.0) or (a[i] == +0.0 && b[i] == -0.0):
      result[i] = IMPLEMENTATION_DEFINED_ONE_OF(a[i], b[i])
    else:
      result[i] = is_min ? min(a, b) : max(a, b)
  return result
```

Where `IMPLEMENTATION_DEFINED_ONE_OF(x, y)` returns either `x` or `y`, depending on the implementation.

### Relaxed Rounding Q-format Multiplication

- `i16x8.q15mulr_s(a: v128, b: v128) -> v128`

Returns the multiplication of 2 fixed-point numbers in Q15 format. If both
inputs are `INT16_MIN`, the result overflows, and the return value is
implementation defined (either `INT16_MIN` or `INT16_MAX`).

```python
def q15mulr(a, b):
  result = []
  for i in range(lanes):
    if (a[i] == INT16_MIN && b[i] == INT16_MIN):
      result[i] = IMPLEMENTATION_DEFINED_ONE_OF(INT16_MIN, INT16_MAX)
    else:
      result[i] = (a[i] * b[i] + 0x4000) >> 15
  return result
```

## Binary format

All opcodes have the `0xfd` prefix (same as SIMD proposal), which are omitted in the table below.

| instruction                        | opcode   |
| ---------------------------------- | -------- |
| `relaxed i8x16.swizzle`            | 0xa2     |
| `relaxed i32x4.trunc_f32x4_s`      | 0xa5     |
| `relaxed i32x4.trunc_f32x4_u`      | 0xa6     |
| `relaxed i32x4.trunc_f64x2_s_zero` | 0xc5     |
| `relaxed i32x4.trunc_f64x2_u_zero` | 0xc6     |
| `f32x4.fma`                        | 0xaf     |
| `f32x4.fms`                        | 0xb0     |
| `f64x2.fma`                        | 0xcf     |
| `f64x2.fms`                        | 0xd0     |
| `i8x16.laneselect`                 | 0xb2     |
| `i16x8.laneselect`                 | 0xb3     |
| `i32x4.laneselect`                 | 0xd2     |
| `i64x2.laneselect`                 | 0xd3     |
| `f32x4.min`                        | 0xb4     |
| `f32x4.max`                        | 0xe2     |
| `f64x2.min`                        | 0xd4     |
| `f64x2.max`                        | 0xee     |
| `i16x8.q15mulr_s`                  | ????     |

Note: the opcodes are chosen to fit into the existing opcode space of the SIMD proposal, see [Binary encoding of SIMD](https://github.com/WebAssembly/simd/blob/main/proposals/simd/BinarySIMD.md), or a [table view of the same opcodes](https://github.com/WebAssembly/simd/blob/main/proposals/simd/NewOpcodes.md) for a list of existing opcodes.

## References

- Poll for phase 1
  [presentation](https://docs.google.com/presentation/d/1Qnx0nbNTRYhMONLuKyygEduCXNOv3xtWODfXfYokx1Y/edit?usp=sharing)
  and [meeting
  notes](https://github.com/WebAssembly/meetings/blob/master/main/2021/CG-03-16.md)
- [SIMD proposal](https://github.com/WebAssembly/simd)

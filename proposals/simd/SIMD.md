# WebAssembly 128-bit packed SIMD Extension

This specification describes a 128-bit packed *Single Instruction Multiple
Data* (SIMD) extension to WebAssembly that can be implemented efficiently on
current popular instruction set architectures.

# Types

WebAssembly is extended with a new `v128` value type and a number of new kinds
of immediate operands used by the SIMD instructions.

## SIMD value type

The `v128` value type has a concrete mapping to a 128-bit representation with bits
numbered 0–127. The `v128` type corresponds to a vector register in a typical
SIMD ISA. The interpretation of the 128 bits in the vector register is provided
by the individual instructions. When a `v128` value is represented as 16 bytes,
bits 0-7 go in the first byte with bit 0 as the LSB, bits 8-15 go in the second
byte, etc.

## Immediate operands

Some of the new SIMD instructions defined here have immediate operands that are
encoded as individual bytes in the binary encoding. Many have a limited valid
range, and it is a validation error if the immediate operands are out of range.

* `ImmByte`: A single unconstrained byte (0-255).
* `LaneIdx2`: A byte with values in the range 0–1 identifying a lane.
* `LaneIdx4`: A byte with values in the range 0–3 identifying a lane.
* `LaneIdx8`: A byte with values in the range 0–7 identifying a lane.
* `LaneIdx16`: A byte with values in the range 0–15 identifying a lane.
* `LaneIdx32`: A byte with values in the range 0–31 identifying a lane.

## Interpreting the SIMD value type

The single `v128` SIMD type can represent packed data in multiple ways.
Instructions specify how the bits should be interpreted through a hierarchy of
*interpretations*.

### Lane division interpretation

The first level of interpretations of the `v128` type imposes a lane structure on
the bits:

* `v8x16 : v128`: 8-bit lanes numbered 0–15. Lane n corresponds to bits 8n – 8n+7.
* `v16x8 : v128`: 16-bit lanes numbered 0–7. Lane n corresponds to bits 16n – 16n+15.
* `v32x4 : v128`: 32-bit lanes numbered 0–3. Lane n corresponds to bits 32n – 32n+31.
* `v64x2 : v128`: 64-bit lanes numbered 0–1. Lane n corresponds to bits 64n – 64n+63.

The lane dividing interpretations don't say anything about the semantics of the
bits in each lane. The interpretations have *properties* used by the semantic
specification pseudo-code below:

|    S    | S.LaneBits | S.Lanes | S.MaskType |
|---------|-----------:|--------:|:----------:|
| `v8x16` |          8 |      16 | `i8x16`    |
| `v16x8` |         16 |       8 | `i16x8`    |
| `v32x4` |         32 |       4 | `i32x4`    |
| `v64x2` |         64 |       2 | `i64x2`    |

Since WebAssembly is little-endian, the least significant bit in each lane is
the bit with the lowest number.

### Modulo integer interpretations

The bits in a lane can be interpreted as integers with modulo arithmetic
semantics. Many arithmetic operations can be defined on these types which don't
impose a signed or unsigned integer interpretation.

* `i8x16 : v8x16`: Each lane is an `i8`.
* `i16x8 : v16x8`: Each lane is an `i16`.
* `i32x4 : v32x4`: Each lane is an `i32`.
* `i64x2 : v64x2`: Each lane is an `i64`.

Additional properties:

|    S    |  S.Smin | S.Smax | S.Umax |
|---------|--------:|-------:|-------:|
| `i8x16` |    -2^7 |  2^7-1 |  2^8-1 |
| `i16x8` |   -2^15 | 2^15-1 | 2^16-1 |
| `i32x4` |   -2^31 | 2^31-1 | 2^32-1 |
| `i64x2` |   -2^63 | 2^63-1 | 2^64-1 |

Some operations interpret each lane specifically as a signed or unsigned
integer. These operations have `_s` and `_u` suffixes as is the convention is
WebAssembly.

### Floating-point interpretations

Each lane is interpreted as an IEEE floating-point number.

* `f32x4 : v32x4`: Each lane is an `f32`.
* `f64x2 : v64x2`: Each lane is an `f64`.

The floating-point operations in this specification aim to be compatible with
WebAssembly's scalar floating-point operations. In particular, the rules about
NaN propagation and default NaN values are the same, and all operations use the
default *roundTiesToEven* rounding mode.

An implementation is allowed to flush subnormals in arithmetic floating-point
operations. This means that any subnormal operand is treated as 0, and any
subnormal result is rounded to 0. Note that this differs from WebAssembly
scalar floating-point semantics which require correct subnormal handling.

# Operations

The SIMD operations described in this sections are generally named
`S.Op`, where `S` is either a SIMD type or one of the interpretations
of a SIMD type.

Many operations are simply the lane-wise application of a scalar operation:

```python
def S.lanewise_unary(func, a):
    result = S.New()
    for i in range(S.Lanes):
        result[i] = func(a[i])
    return result

def S.lanewise_binary(func, a, b):
    result = S.New()
    for i in range(S.Lanes):
        result[i] = func(a[i], b[i])
    return result
```

Comparison operators produce a mask vector where the bits in each lane are 0
for false and all ones for true:

```python
def S.lanewise_comparison(func, a, b):
    all_ones = S.MaskType.Umax
    result = S.MaskType.New()
    for i in range(S.Lanes):
        result[i] = all_ones if func(a[i], b[i]) else 0
    return result
```

## Constructing SIMD values

### Constant
* `v128.const(imm: ImmByte[16]) -> v128`

Materialize a constant SIMD value from the immediate operands. The `v128.const`
instruction is encoded with 16 immediate bytes which provide the bits of the
vector directly.

### Create vector with identical lanes
* `i8x16.splat(x: i32) -> v128`
* `i16x8.splat(x: i32) -> v128`
* `i32x4.splat(x: i32) -> v128`
* `i64x2.splat(x: i64) -> v128`
* `f32x4.splat(x: f32) -> v128`
* `f64x2.splat(x: f64) -> v128`

Construct a vector with `x` replicated to all lanes:

```python
def S.splat(x):
    result = S.New()
    for i in range(S.Lanes):
        result[i] = x
    return result
```

## Accessing lanes

### Extract lane as a scalar
* `i8x16.extract_lane_s(a: v128, i: LaneIdx16) -> i32`
* `i8x16.extract_lane_u(a: v128, i: LaneIdx16) -> i32`
* `i16x8.extract_lane_s(a: v128, i: LaneIdx8) -> i32`
* `i16x8.extract_lane_u(a: v128, i: LaneIdx8) -> i32`
* `i32x4.extract_lane(a: v128, i: LaneIdx4) -> i32`
* `i64x2.extract_lane(a: v128, i: LaneIdx2) -> i64`
* `f32x4.extract_lane(a: v128, i: LaneIdx4) -> f32`
* `f64x2.extract_lane(a: v128, i: LaneIdx2) -> f64`

Extract the value of lane `i` in `a`.

```python
def S.extract_lane(a, i):
    return a[i]
```

The `_s` and `_u` variants will sign-extend or zero-extend the lane value to
`i32` respectively.

### Replace lane value
* `i8x16.replace_lane(a: v128, i: LaneIdx16, x: i32) -> v128`
* `i16x8.replace_lane(a: v128, i: LaneIdx8, x: i32) -> v128`
* `i32x4.replace_lane(a: v128, i: LaneIdx4, x: i32) -> v128`
* `i64x2.replace_lane(a: v128, i: LaneIdx2, x: i64) -> v128`
* `f32x4.replace_lane(a: v128, i: LaneIdx4, x: f32) -> v128`
* `f64x2.replace_lane(a: v128, i: LaneIdx2, x: f64) -> v128`

Return a new vector with lanes identical to `a`, except for lane `i` which has
the value `x`.

```python
def S.replace_lane(a, i, x):
    result = S.New()
    for j in range(S.Lanes):
        result[j] = a[j]
    result[i] = x
    return result
```

The input lane value, `x`, is interpreted the same way as for the splat
instructions. For the `i8` and `i16` lanes, the high bits of `x` are ignored.

### Swizzle lanes
* `v8x16.swizzle(a: v128, s: LaneIdx16[16]) -> v128`
* `v16x8.swizzle(a: v128, s: LaneIdx8[8]) -> v128`
* `v32x4.swizzle(a: v128, s: LaneIdx4[4]) -> v128`
* `v64x2.swizzle(a: v128, s: LaneIdx2[2]) -> v128`

Create vector with lanes rearranged:

```python
def S.swizzle(a, s):
    result = S.New()
    for i in range(S.Lanes):
        result[i] = a[s[i]]
    return result
```

### Shuffle lanes
* `v8x16.shuffle(a: v128, b: v128, s: LaneIdx32[16]) -> v128`
* `v16x8.shuffle(a: v128, b: v128, s: LaneIdx16[8]) -> v128`
* `v32x4.shuffle(a: v128, b: v128, s: LaneIdx8[4]) -> v128`
* `v64x2.shuffle(a: v128, b: v128, s: LaneIdx4[2]) -> v128`

Create vector with lanes selected from the lanes of two input vectors:

```python
def S.shuffle(a, b, s):
    result = S.New()
    for i in range(S.Lanes):
        if s[i] < S.lanes:
            result[i] = a[s[i]]
        else:
            result[i] = b[s[i] - S.lanes]
    return result
```

## Integer arithmetic

Wrapping integer arithmetic discards the high bits of the result.

```python
def S.Reduce(x):
    bitmask = (1 << S.LaneBits) - 1
    return x & bitmask
```

There is no integer division operation provided here. This operation is not
commonly part of bit 128-bit SIMD ISAs.

### Integer addition
* `i8x16.add(a: v128, b: v128) -> v128`
* `i16x8.add(a: v128, b: v128) -> v128`
* `i32x4.add(a: v128, b: v128) -> v128`
* `i64x2.add(a: v128, b: v128) -> v128`

Lane-wise wrapping integer addition:

```python
def S.add(a, b):
    def add(x, y):
        return S.Reduce(x + y)
    return S.lanewise_binary(add, a, b)
```

### Integer subtraction
* `i8x16.sub(a: v128, b: v128) -> v128`
* `i16x8.sub(a: v128, b: v128) -> v128`
* `i32x4.sub(a: v128, b: v128) -> v128`
* `i64x2.sub(a: v128, b: v128) -> v128`

Lane-wise wrapping integer subtraction:

```python
def S.sub(a, b):
    def sub(x, y):
        return S.Reduce(x - y)
    return S.lanewise_binary(sub, a, b)
```

### Integer multiplication
* `i8x16.mul(a: v128, b: v128) -> v128`
* `i16x8.mul(a: v128, b: v128) -> v128`
* `i32x4.mul(a: v128, b: v128) -> v128`
* `i64x2.mul(a: v128, b: v128) -> v128`

Lane-wise wrapping integer multiplication:

```python
def S.mul(a, b):
    def mul(x, y):
        return S.Reduce(x * y)
    return S.lanewise_binary(mul, a, b)
```

### Integer negation
* `i8x16.neg(a: v128) -> v128`
* `i16x8.neg(a: v128) -> v128`
* `i32x4.neg(a: v128) -> v128`
* `i64x2.neg(a: v128) -> v128`

Lane-wise wrapping integer negation. In wrapping arithmetic, `y = -x` is the
unique value such that `x + y == 0`.

```python
def S.neg(a):
    def neg(x):
        return S.Reduce(-x)
    return S.lanewise_unary(neg, a)
```

## Saturating integer arithmetic

Saturating integer arithmetic behaves differently on signed and unsigned lanes.
It is only defined here for 8-bit and 16-bit integer lanes.

```python
def S.SignedSaturate(x):
    if x < S.Smin:
        return S.Smin
    if x > S.Smax:
        return S.Smax
    return x

def S.UnsignedSaturate(x):
    if x < 0:
        return 0
    if x > S.Umax:
        return S.Umax
    return x
```

### Saturating integer addition
* `i8x16.add_saturate_s(a: v128, b: v128) -> v128`
* `i8x16.add_saturate_u(a: v128, b: v128) -> v128`
* `i16x8.add_saturate_s(a: v128, b: v128) -> v128`
* `i16x8.add_saturate_u(a: v128, b: v128) -> v128`

Lane-wise saturating addition:

```python
def S.add_saturate_s(a, b):
    def addsat(x, y):
        return S.SignedSaturate(x + y)
    return S.lanewise_binary(addsat, S.AsSigned(a), S.AsSigned(b))

def S.add_saturate_u(a, b):
    def addsat(x, y):
        return S.UnsignedSaturate(x + y)
    return S.lanewise_binary(addsat, S.AsUnsigned(a), S.AsUnsigned(b))
```

### Saturating integer subtraction
* `i8x16.sub_saturate_s(a: v128, b: v128) -> v128`
* `i8x16.sub_saturate_u(a: v128, b: v128) -> v128`
* `i16x8.sub_saturate_s(a: v128, b: v128) -> v128`
* `i16x8.sub_saturate_u(a: v128, b: v128) -> v128`

Lane-wise saturating subtraction:

```python
def S.sub_saturate_s(a, b):
    def subsat(x, y):
        return S.SignedSaturate(x - y)
    return S.lanewise_binary(subsat, S.AsSigned(a), S.AsSigned(b))

def S.sub_saturate_u(a, b):
    def subsat(x, y):
        return S.UnsignedSaturate(x - y)
    return S.lanewise_binary(subsat, S.AsUnsigned(a), S.AsUnsigned(b))
```

## Bit shifts

### Left shift by scalar
* `i8x16.shl(a: v128, y: i32) -> v128`
* `i16x8.shl(a: v128, y: i32) -> v128`
* `i32x4.shl(a: v128, y: i32) -> v128`
* `i64x2.shl(a: v128, y: i32) -> v128`

Shift the bits in each lane to the left by the same amount. Only the low bits
of the shift amount are used:

```python
def S.shl(a, x):
    # Number of bits to shift: 0 .. S.LaneBits - 1.
    amount = y mod S.LaneBits
    def shift(x):
        return S.Reduce(x << amount)
    return S.lanewise_unary(shift, a)
```

### Right shift by scalar
* `i8x16.shr_s(a: v128, y: i32) -> v128`
* `i8x16.shr_u(a: v128, y: i32) -> v128`
* `i16x8.shr_s(a: v128, y: i32) -> v128`
* `i16x8.shr_u(a: v128, y: i32) -> v128`
* `i32x4.shr_s(a: v128, y: i32) -> v128`
* `i32x4.shr_u(a: v128, y: i32) -> v128`
* `i64x2.shr_s(a: v128, y: i32) -> v128`
* `i64x2.shr_u(a: v128, y: i32) -> v128`

Shift the bits in each lane to the right by the same amount. This is an
arithmetic right shift for the `_s` variants and a logical right shift for the
`_u` variants.

```python
def S.shr_s(a, y):
    # Number of bits to shift: 0 .. S.LaneBits - 1.
    amount = y mod S.LaneBits
    def shift(x):
        return x >> amount
    return S.lanewise_unary(shift, S.AsSigned(a))

def S.shr_u(a, y):
    # Number of bits to shift: 0 .. S.LaneBits - 1.
    amount = y mod S.LaneBits
    def shift(x):
        return x >> amount
    return S.lanewise_unary(shift, S.AsUnsigned(a))
```


## Bitwise operations

Bitwise operations treat a `v128` value type as a vector of 128 independent bits.

### Bitwise logic
* `v128.and(a: v128, b: v128) -> v128`
* `v128.or(a: v128, b: v128) -> v128`
* `v128.xor(a: v128, b: v128) -> v128`
* `v128.not(a: v128) -> v128`

The logical operations defined on the scalar integer types are also available
on the `v128` type where they operate bitwise the same way C's `&`, `|`, `^`,
and `~` operators work on an `unsigned` type.

### Bitwise select
* `v128.bitselect(v1: v128, v2: v128, c: v128) -> v128`

Use the bits in the control mask `c` to select the corresponding bit from `v1`
when 1 and `v2` when 0.
This is the same as `v128.or(v128.and(v1, c), v128.and(v2, v128.not(c)))`.

Note that the normal WebAssembly `select` instruction also works with vector
types. It selects between two whole vectors controlled by a single scalar value,
rather than selecting bits controlled by a control mask vector.


## Boolean horizontal reductions

These operations reduce all the lanes of an integer vector to a single scalar
0 or 1 value. A lane is considered "true" if it is non-zero.

### Any lane true
* `i8x16.any_true(a: v128) -> i32`
* `i16x8.any_true(a: v128) -> i32`
* `i32x4.any_true(a: v128) -> i32`
* `i64x2.any_true(a: v128) -> i32`

These functions return 1 if any lane in `a` is non-zero, 0 otherwise.

```python
def S.any_true(a):
    for i in range(S.Lanes):
        if a[i] != 0:
            return 1
    return 0
```

### All lanes true
* `i8x16.all_true(a: v128) -> i32`
* `i16x8.all_true(a: v128) -> i32`
* `i32x4.all_true(a: v128) -> i32`
* `i64x2.all_true(a: v128) -> i32`

These functions return 1 if all lanes in `a` are non-zero, 0 otherwise.

```python
def S.all_true(a):
    for i in range(S.Lanes):
        if a[i] == 0:
            return 0
    return 1
```

## Comparisons

The comparison operations all compare two vectors lane-wise, and produce a
mask vector with the same number of lanes as the input interpretation.

### Equality
* `i8x16.eq(a: v128, b: v128) -> v128`
* `i16x8.eq(a: v128, b: v128) -> v128`
* `i32x4.eq(a: v128, b: v128) -> v128`
* `i64x2.eq(a: v128, b: v128) -> v128`
* `f32x4.eq(a: v128, b: v128) -> v128`
* `f64x2.eq(a: v128, b: v128) -> v128`

Integer equality is independent of the signed/unsigned interpretation. Floating
point equality follows IEEE semantics, so a NaN lane compares not equal with
anything, including itself, and +0.0 is equal to -0.0:

```python
def S.eq(a, b):
    def eq(x, y):
        return x == y
    return S.lanewise_comparison(eq, a, b)
```

### Non-equality
* `i8x16.ne(a: v128, b: v128) -> v128`
* `i16x8.ne(a: v128, b: v128) -> v128`
* `i32x4.ne(a: v128, b: v128) -> v128`
* `i64x2.ne(a: v128, b: v128) -> v128`
* `f32x4.ne(a: v128, b: v128) -> v128`
* `f64x2.ne(a: v128, b: v128) -> v128`

The `ne` operations produce the inverse of their `ne` counterparts:

```python
def S.ne(a, b):
    def ne(x, y):
        return x != y
    return S.lanewise_comparison(ne, a, b)
```

### Less than
* `i8x16.lt_s(a: v128, b: v128) -> v128`
* `i8x16.lt_u(a: v128, b: v128) -> v128`
* `i16x8.lt_s(a: v128, b: v128) -> v128`
* `i16x8.lt_u(a: v128, b: v128) -> v128`
* `i32x4.lt_s(a: v128, b: v128) -> v128`
* `i32x4.lt_u(a: v128, b: v128) -> v128`
* `i64x2.lt_s(a: v128, b: v128) -> v128`
* `i64x2.lt_u(a: v128, b: v128) -> v128`
* `f32x4.lt(a: v128, b: v128) -> v128`
* `f64x2.lt(a: v128, b: v128) -> v128`

### Less than or equal
* `i8x16.le_s(a: v128, b: v128) -> v128`
* `i8x16.le_u(a: v128, b: v128) -> v128`
* `i16x8.le_s(a: v128, b: v128) -> v128`
* `i16x8.le_u(a: v128, b: v128) -> v128`
* `i32x4.le_s(a: v128, b: v128) -> v128`
* `i32x4.le_u(a: v128, b: v128) -> v128`
* `i64x2.le_s(a: v128, b: v128) -> v128`
* `i64x2.le_u(a: v128, b: v128) -> v128`
* `f32x4.le(a: v128, b: v128) -> v128`
* `f64x2.le(a: v128, b: v128) -> v128`

### Greater than
* `i8x16.gt_s(a: v128, b: v128) -> v128`
* `i8x16.gt_u(a: v128, b: v128) -> v128`
* `i16x8.gt_s(a: v128, b: v128) -> v128`
* `i16x8.gt_u(a: v128, b: v128) -> v128`
* `i32x4.gt_s(a: v128, b: v128) -> v128`
* `i32x4.gt_u(a: v128, b: v128) -> v128`
* `i64x2.gt_s(a: v128, b: v128) -> v128`
* `i64x2.gt_u(a: v128, b: v128) -> v128`
* `f32x4.gt(a: v128, b: v128) -> v128`
* `f64x2.gt(a: v128, b: v128) -> v128`

### Greater than or equal
* `i8x16.ge_s(a: v128, b: v128) -> v128`
* `i8x16.ge_u(a: v128, b: v128) -> v128`
* `i16x8.ge_s(a: v128, b: v128) -> v128`
* `i16x8.ge_u(a: v128, b: v128) -> v128`
* `i32x4.ge_s(a: v128, b: v128) -> v128`
* `i32x4.ge_u(a: v128, b: v128) -> v128`
* `i64x2.ge_s(a: v128, b: v128) -> v128`
* `i64x2.ge_u(a: v128, b: v128) -> v128`
* `f32x4.ge(a: v128, b: v128) -> v128`
* `f64x2.ge(a: v128, b: v128) -> v128`

## Load and store

Load and store operations are provided for the `v128` vectors. The memory
operations take the same arguments and have the same semantics as the existing
scalar WebAssembly load and store instructions. The difference is that the
memory access size is 16 bytes which is also the natural alignment.

### Load

* `v128.load(memarg) -> v128`

Load a `v128` vector from the given heap address.

### Store

* `v128.store(memarg, data: v128)`

Store a `v128` vector to the given heap address.

## Floating-point sign bit operations

These floating point operations are simple manipulations of the sign bit. No
changes are made to the exponent or trailing significand bits, even for NaN
inputs.

### Negation
* `f32x4.neg(a: v128) -> v128`
* `f64x2.neg(a: v128) -> v128`

Apply the IEEE `negate(x)` function to each lane. This simply inverts the sign
bit, preserving all other bits.

```python
def S.neg(a):
    return S.lanewise_unary(ieee.negate, a)
```

### Absolute value
* `f32x4.abs(a: v128) -> v128`
* `f64x2.abs(a: v128) -> v128`

Apply the IEEE `abs(x)` function to each lane. This simply clears the sign bit,
preserving all other bits.

```python
def S.abs(a):
    return S.lanewise_unary(ieee.abs, a)
```

## Floating-point min and max

These operations are not part of the IEEE 754-2008 standard. They are lane-wise
versions of the existing scalar WebAssembly operations.

### NaN-propagating minimum
* `f32x4.min(a: v128, b: v128) -> v128`
* `f64x2.min(a: v128, b: v128) -> v128`

Lane-wise minimum value, propagating NaNs.

### NaN-propagating maximum
* `f32x4.max(a: v128, b: v128) -> v128`
* `f64x2.max(a: v128, b: v128) -> v128`

Lane-wise maximum value, propagating NaNs.

## Floating-point arithmetic

The floating-point arithmetic operations are all lane-wise versions of the
existing scalar WebAssembly operations.

### Addition
* `f32x4.add(a: v128, b: v128) -> v128`
* `f64x2.add(a: v128, b: v128) -> v128`

Lane-wise IEEE `addition`.

### Subtraction
* `f32x4.sub(a: v128, b: v128) -> v128`
* `f64x2.sub(a: v128, b: v128) -> v128`

Lane-wise IEEE `subtraction`.

### Division
* `f32x4.div(a: v128, b: v128) -> v128`
* `f64x2.div(a: v128, b: v128) -> v128`

Lane-wise IEEE `division`.

### Multiplication
* `f32x4.mul(a: v128, b: v128) -> v128`
* `f64x2.mul(a: v128, b: v128) -> v128`

Lane-wise IEEE `multiplication`.

### Square root
* `f32x4.sqrt(a: v128) -> v128`
* `f64x2.sqrt(a: v128) -> v128`

Lane-wise IEEE `squareRoot`.

## Conversions
### Integer to floating point
* `f32x4.convert_s/i32x4(a: v128) -> v128`
* `f32x4.convert_u/i32x4(a: v128) -> v128`
* `f64x2.convert_s/i64x2(a: v128) -> v128`
* `f64x2.convert_u/i64x2(a: v128) -> v128`

Lane-wise conversion from integer to floating point. Some integer values will be
rounded.

### Floating point to integer
* `i32x4.trunc_s/f32x4(a: v128) -> v128`
* `i32x4.trunc_u/f32x4(a: v128) -> v128`
* `i64x2.trunc_s/f64x2(a: v128) -> v128`
* `i64x2.trunc_u/f64x2(a: v128) -> v128`

Lane-wise conversion from floating point to integer using the IEEE
`convertToIntegerTowardZero` function. If any lane is a NaN or the rounded
integer value is outside the range of the destination type, these instructions
trap.

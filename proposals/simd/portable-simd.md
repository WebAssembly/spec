# Portable SIMD

This specification describes a *Single Instruction Multiple Data* (SIMD)
instruction set that can be implemented efficiently on current popular
instruction set architectures. It provides shared semantics for
[WebAssembly][wasm] and [SIMD.js][simdjs].

# Types

The types used in this specification can be concrete or abstract. Concrete types
have a defined representation as a bit pattern, while abstract types are simply
a set of allowed values.

## Scalar types

The concrete scalar integer types are not interpreted as either signed or
unsigned integers.

* `i8`: An 8-bit integer with bits numbered 0–7.
* `i16`: A 16-bit integer with bits numbered 0–15.
* `i32`: A 32-bit integer with bits numbered 0–31.
* `i64`: A 64-bit integer with bits numbered 0–63.

The concrete scalar floating-point types follow the encoding and semantics of
the [IEEE 754-2008 standard for floating-point arithmetic][ieee754]. See the
[Floating-point semantics](#floating-point-semantics) section for details and
exceptions.

* `f32`: A floating-point number in the [IEEE][ieee754] *binary32* interchange
  format.
* `f64`: A floating-point number in the [IEEE][ieee754] *binary64* interchange
  format.

The following abstract types don't have a specified representation as a bit
pattern:

* `boolean`: Either `true` or `false`.
* `LaneIdx2`: An integer in the range 0–1 identifying a lane.
* `LaneIdx4`: An integer in the range 0–3 identifying a lane.
* `LaneIdx8`: An integer in the range 0–7 identifying a lane.
* `LaneIdx16`: An integer in the range 0–15 identifying a lane.
* `LaneIdx32`: An integer in the range 0–31 identifying a lane.
* `RoundingMode`: Rounding mode for floating-point operations. One of
  `TiesToEven`, `TowardPositive`, `TowardNegative`, and `TowardZero`. See
  [Rounding modes](#rounding-modes).

## SIMD types

All of the numerical SIMD types have a concrete mapping to a 128-bit
representation. The boolean types do not have a bit-pattern representation.

* `v128`: A 128-bit SIMD vector. Bits are numbered 0–127.
* `b8x16`: A vector of 16 `boolean` lanes numbered 0–15.
* `b16x8`: A vector of 8 `boolean` lanes numbered 0–7.
* `b32x4`: A vector of 4 `boolean` lanes numbered 0–3.
* `b64x2`: A vector of 2 `boolean` lanes numbered 0–1.

The `v128` type corresponds to a vector register in a typical SIMD ISA. The
interpretation of the 128 bits in the vector register is provided by the
individual instructions.

The abstract boolean vector types can be mapped to vector registers or predicate
registers by an implementation. They have a property `S.Lanes` which is used by
the pseudo-code below:

|    S    | S.Lanes |
|---------|--------:|
| `b8x16` |      16 |
| `b16x8` |       8 |
| `b32x4` |       4 |
| `b64x2` |       2 |

## Interpreting SIMD types

The single `v128` SIMD type can represent packed data in multiple ways.
Instructions specify how the bits should be interpreted through a hierarchy of
*interpretations*.

The boolean vector types only have the one interpretation given by their type.

### Lane division interpretation

The first level of interpretations of the `v128` type impose a lane structure on
the bits:

* `v8x16 : v128`: 8-bit lanes numbered 0–15. Lane n corresponds to bits 8n – 8n+7.
* `v16x8 : v128`: 16-bit lanes numbered 0–7. Lane n corresponds to bits 16n – 16n+15.
* `v32x4 : v128`: 32-bit lanes numbered 0–3. Lane n corresponds to bits 32n – 32n+31.
* `v64x2 : v128`: 64-bit lanes numbered 0–1. Lane n corresponds to bits 64n – 64n+63.

The lane dividing interpretations don't say anything about the semantics of the
bits in each lane. The interpretations have *properties* used by the semantic
specification pseudo-code below:

|    S    | S.LaneBits | S.Lanes | S.BoolType |
|---------|-----------:|--------:|:----------:|
| `v8x16` |          8 |      16 | `b8x16`    |
| `v16x8` |         16 |       8 | `b16x8`    |
| `v32x4` |         32 |       4 | `b32x4`    |
| `v64x2` |         64 |       2 | `b64x2`    |


### Modulo integer interpretations

The bits in a lane can be interpreted as integers with modulo arithmetic
semantics. Many arithmetic operations can be defined on these types which don't
impose a signed or unsigned integer interpretation.

* `i8x16 : v8x16`: Each lane is an `i8`.
* `i16x8 : v16x8`: Each lane is an `i16`.
* `i32x4 : v32x4`: Each lane is an `i32`.
* `i64x2 : v64x2`: Each lane is an `i64`.

Additional properties:

|    S    | S.LaneType |
|---------|------------|
| `i8x16` |       `i8` |
| `i16x8` |      `i16` |
| `i32x4` |      `i32` |
| `i64x2` |      `i64` |

### Signed integer interpretations

Each lane is interpreted as a two's complement integer.

* `s8x16 : i8x16`: Lane values in the range -2^7 – 2^7-1.
* `s16x8 : i16x8`: Lane values in the range -2^15 – 2^15-1.
* `s32x4 : i32x4`: Lane values in the range -2^31 – 2^31-1.
* `s64x2 : i64x2`: Lane values in the range -2^63 – 2^63-1.

These interpretations get additional properties defining the range of values in
a lane:

|    S    | S.Min | S.Max  |
|---------|------:|-------:|
| `s8x16` | -2^7  | 2^7-1  |
| `s16x8` | -2^15 | 2^15-1 |
| `s32x4` | -2^31 | 2^31-1 |
| `s64x2` | -2^63 | 2^63-1 |

### Unsigned integer interpretations

Each lane is interpreted as an unsigned integer.

* `u8x16 : i8x16`: Lane values in the range 0 – 2^8-1.
* `u16x8 : i16x8`: Lane values in the range 0 – 2^16-1.
* `u32x4 : i32x4`: Lane values in the range 0 – 2^32-1.
* `u64x2 : i64x2`: Lane values in the range 0 – 2^64-1.

These interpretations get additional properties defining the range of values in
a lane:

|    S    | S.Min | S.Max  |
|---------|------:|-------:|
| `u8x16` |     0 | 2^8-1  |
| `u16x8` |     0 | 2^16-1 |
| `u32x4` |     0 | 2^32-1 |
| `u64x2` |     0 | 2^64-1 |

### Floating-point interpretations

Each lane is interpreted as an IEEE floating-point number.

* `f32x4 : v32x4`: Each lane is an `f32`.
* `f64x2 : v64x2`: Each lane is an `f64`.

Additional properties:

|    S    | S.LaneType |
|---------|------------|
| `f32x4` | `f32`      |
| `f64x2` | `f64`      |

# Floating-point semantics

The floating-point operations in this specification aim to be conforming to
[IEEE 754-2008][ieee754] while being compatible with WebAssembly and JavaScript.
Some things which are left unspecified by the IEEE standard are given stricter
semantics by WebAssembly.

## Rounding modes

Floating-point operations that need a *rounding mode* take a `RoundingMode`
operand which provides the rounding mode to use for the operation.

* `TiesToEven`: Round to nearest, ties towards even.
* `TowardPositive`: Round towards positive infinity.
* `TowardNegative`: Round towards negative infinity.
* `TowardZero`: Round towards zero.

## Default NaN value

When a floating-point operation needs to return a NaN and none of its operands
are NaN, it generates a default NaN value which is a quiet NaN with an all-zero
payload field. The sign of the default NaN is not specified:

```python
def f32.default_nan():
    if unspecified_choice():
        bits = 0x7fc00000
    else:
        bits = 0xffc00000
    return f32.from_bits(bits)

def f64.default_nan():
    if unspecified_choice():
        bits = 0x7ff8000000000000
    else:
        bits = 0xfff8000000000000
    return f64.from_bits(bits)
```

## Propagating NaN values

When propagating a NaN value from an operand, all the bits of the NaN are
preserved, except a signaling NaN is quieted by setting the most significand
bit in the trailing significand field.

```python
def canonicalize_nan(x):
    assert isnan(x)
    t = type(x)
    assert t == f32 or t == f64
    bits = x.to_bits()
    if t == f32:
        bits |= (1 << 22)
    else:
        bits |= (1 << 51)
    return t.from_bits(bits)
```

When two operands are NaN, one of them is propagated. Which one is not specified:

```python
def propagate_nan(x, y):
    assert isinan(x) or isnan(y)
    if not isnan(x):
        return canonicalize_nan(y)
    if not isnan(y)
        return canonicalize_nan(x)
    # Both x and y are NaNs: pick one to propagate.
    if unspecified_choice():
        return canonicalize_nan(x)
    else:
        return canonicalize_nan(y)
```

## Subnormal flushing

An implementation is allowed to flush subnormals in arithmetic floating-point
operations. This means that any subnormal operand is treated as 0, and any
subnormal result is rounded to 0.

Note that this differs from WebAssembly scalar floating-point semantics which
require correct subnormal handling.

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

Comparison operators produce a boolean vector:

```python
def S.lanewise_comparison(func, a, b):
    result = S.BoolType.New()
    for i in range(S.Lanes):
        result[i] = func(a[i], b[i])
    return result
```

## Constructing SIMD values

### Build vector from individual lanes
* `b8x16.build(x: boolean[16]) -> b8x16`
* `b16x8.build(x: boolean[8]) -> b16x8`
* `b32x4.build(x: boolean[4]) -> b32x4`
* `b64x2.build(x: boolean[2]) -> b64x2`
* `i8x16.build(x: i8[16]) -> v128`
* `i16x8.build(x: i16[8]) -> v128`
* `i32x4.build(x: i32[4]) -> v128`
* `i64x2.build(x: i64[2]) -> v128`
* `f32x4.build(x: f32[4]) -> v128`
* `f64x2.build(x: f64[2]) -> v128`

Construct a vector from an array of individual lane values.

```python
def S.build(x):
    result = S.New()
    for i in range(S.Lanes):
        result[i] = x[i]
    return result
```

### Create vector with identical lanes
* `b8x16.splat(x: boolean) -> b8x16`
* `b16x8.splat(x: boolean) -> b16x8`
* `b32x4.splat(x: boolean) -> b32x4`
* `b64x2.splat(x: boolean) -> b64x2`
* `i8x16.splat(x: i8) -> v128`
* `i16x8.splat(x: i16) -> v128`
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
* `b8x16.extractLane(a: b8x16, i: LaneIdx16) -> boolean`
* `b16x8.extractLane(a: b16x8, i: LaneIdx8) -> boolean`
* `b32x4.extractLane(a: b32x4, i: LaneIdx4) -> boolean`
* `b64x2.extractLane(a: b64x2, i: LaneIdx2) -> boolean`
* `i8x16.extractLane(a: v128, i: LaneIdx16) -> i8`
* `i16x8.extractLane(a: v128, i: LaneIdx8) -> i16`
* `i32x4.extractLane(a: v128, i: LaneIdx4) -> i32`
* `i64x2.extractLane(a: v128, i: LaneIdx2) -> i64`
* `f32x4.extractLane(a: v128, i: LaneIdx4) -> f32`
* `f64x2.extractLane(a: v128, i: LaneIdx2) -> f64`

Extract the value of lane `i` in `a`.

```python
def S.extractLane(a, i):
    return a[i]
```

### Replace lane value
* `b8x16.replaceLane(a: b8x16, i: LaneIdx16, x: boolean) -> b8x16`
* `b16x8.replaceLane(a: b16x8, i: LaneIdx8, x: boolean) -> b16x8`
* `b32x4.replaceLane(a: b32x4, i: LaneIdx4, x: boolean) -> b32x4`
* `b64x2.replaceLane(a: b64x2, i: LaneIdx2, x: boolean) -> b64x2`
* `i8x16.replaceLane(a: v128, i: LaneIdx16, x: i8) -> v128`
* `i16x8.replaceLane(a: v128, i: LaneIdx8, x: i16) -> v128`
* `i32x4.replaceLane(a: v128, i: LaneIdx4, x: i32) -> v128`
* `i64x2.replaceLane(a: v128, i: LaneIdx2, x: i64) -> v128`
* `f32x4.replaceLane(a: v128, i: LaneIdx4, x: f32) -> v128`
* `f64x2.replaceLane(a: v128, i: LaneIdx2, x: f64) -> v128`

Return a new vector with lanes identical to `a`, except for lane `i` which has
the value `x`.

```python
def S.replaceLane(a, i, x):
    result = S.New()
    for j in range(S.Lanes):
        result[j] = a[j]
    result[i] = x
    return result
```

### Lane-wise select
* `v8x16.select(s: b8x16, t: v128, f: v128) -> v128`
* `v16x8.select(s: b16x8, t: v128, f: v128) -> v128`
* `v32x4.select(s: b32x4, t: v128, f: v128) -> v128`
* `v64x2.select(s: b64x2, t: v128, f: v128) -> v128`

Use a boolean vector to select lanes from two numerical vectors.

```python
def S.select(s, t, f):
    result = S.New()
    for i in range(S.Lanes):
        if s[i]:
            result[i] = t[i]
        else
            result[i] = f[i]
    return result
```

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

Saturating integer arithmetic behaves differently on signed and unsigned types.
It is only defined for 8-bit and 16-bit integer lanes.

```python
def S.Saturate(x):
    if x < S.Min:
        return S.Min
    if x > S.Max:
        return S.Max
    return x
```

### Saturating integer addition
* `s8x16.addSaturate(a: v128, b: v128) -> v128`
* `s16x8.addSaturate(a: v128, b: v128) -> v128`
* `u8x16.addSaturate(a: v128, b: v128) -> v128`
* `u16x8.addSaturate(a: v128, b: v128) -> v128`

Lane-wise saturating addition:

```python
def S.addSaturate(a, b):
    def addsat(x, y):
        return S.Saturate(x + y)
    return S.lanewise_binary(addsat, a, b)
```

### Saturating integer subtraction
* `s8x16.subSaturate(a: v128, b: v128) -> v128`
* `s16x8.subSaturate(a: v128, b: v128) -> v128`
* `u8x16.subSaturate(a: v128, b: v128) -> v128`
* `u16x8.subSaturate(a: v128, b: v128) -> v128`

Lane-wise saturating subtraction:

```python
def S.subSaturate(a, b):
    def subsat(x, y):
        return S.Saturate(x - y)
    return S.lanewise_binary(subsat, a, b)
```

## Bit shifts

### Left shift by scalar
* `i8x16.shiftLeftByScalar(a: v128, y: i8) -> v128`
* `i16x8.shiftLeftByScalar(a: v128, y: i8) -> v128`
* `i32x4.shiftLeftByScalar(a: v128, y: i8) -> v128`
* `i64x2.shiftLeftByScalar(a: v128, y: i8) -> v128`

Shift the bits in each lane to the left by the same amount. Only the low bits of
the shift amount are used:

```python
def S.shiftLeftByScalar(a, x):
    # Number of bits to shift: 0 .. S.LaneBits - 1.
    amount = y mod S.LaneBits
    def shift(x):
        return S.Reduce(x << amount)
    return S.lanewise_unary(shift, a)
```

### Right shift by scalar
* `s8x16.shiftRightByScalar(a: v128, y: i8) -> v128`
* `s16x8.shiftRightByScalar(a: v128, y: i8) -> v128`
* `s32x4.shiftRightByScalar(a: v128, y: i8) -> v128`
* `s64x2.shiftRightByScalar(a: v128, y: i8) -> v128`
* `u8x16.shiftRightByScalar(a: v128, y: i8) -> v128`
* `u16x8.shiftRightByScalar(a: v128, y: i8) -> v128`
* `u32x4.shiftRightByScalar(a: v128, y: i8) -> v128`
* `u64x2.shiftRightByScalar(a: v128, y: i8) -> v128`

Shift the bits in each lane to the right by the same amount. This is an
arithmetic right shift for the signed integer interpretations and a logical
right shift for the unsigned integer interpretations.

```python
def S.shiftRightByScalar(a, y):
    # Number of bits to shift: 0 .. S.LaneBits - 1.
    amount = y mod S.LaneBits
    def shift(x):
        return x >> amount
    return S.lanewise_unary(shift, a)
```

## Logical operations

The logical operations are defined on the boolean SIMD types. See also the
[Bitwise operations](#bitwise-operations) below.

### Logical and
* `b8x16.and(a: b8x16, b: b8x16) -> b8x16`
* `b16x8.and(a: b16x8, b: b16x8) -> b16x8`
* `b32x4.and(a: b32x4, b: b32x4) -> b32x4`
* `b64x2.and(a: b64x2, b: b64x2) -> b64x2`

```python
def S.and(a, b):
    def logical_and(x, y):
        return x and y
    return S.lanewise_binary(logical_and, a, b)
```

### Logical or
* `b8x16.or(a: b8x16, b: b8x16) -> b8x16`
* `b16x8.or(a: b16x8, b: b16x8) -> b16x8`
* `b32x4.or(a: b32x4, b: b32x4) -> b32x4`
* `b64x2.or(a: b64x2, b: b64x2) -> b64x2`

```python
def S.or(a, b):
    def logical_or(x, y):
        return x or y
    return S.lanewise_binary(logical_or, a, b)
```

### Logical xor
* `b8x16.xor(a: b8x16, b: b8x16) -> b8x16`
* `b16x8.xor(a: b16x8, b: b16x8) -> b16x8`
* `b32x4.xor(a: b32x4, b: b32x4) -> b32x4`
* `b64x2.xor(a: b64x2, b: b64x2) -> b64x2`

```python
def S.xor(a, b):
    def logical_xor(x, y):
        return x xor y
    return S.lanewise_binary(logical_xor, a, b)
```

### Logical not
* `b8x16.not(a: b8x16) -> b8x16`
* `b16x8.not(a: b16x8) -> b16x8`
* `b32x4.not(a: b32x4) -> b32x4`
* `b64x2.not(a: b64x2) -> b64x2`

```python
def S.not(a):
    def logical_not(x):
        return not x
    return S.lanewise_unary(logical_not, a)
```

## Bitwise operations

The same logical operations defined on the boolean types are also available on
the `v128` type where they operate bitwise the same way C's `&`, `|`, `^`, and
`~` operators work on an `unsigned` type.

* `v128.and(a: v128, b: v128) -> v128`
* `v128.or(a: v128, b: v128) -> v128`
* `v128.xor(a: v128, b: v128) -> v128`
* `v128.not(a: v128) -> v128`

## Boolean horizontal reductions

These operations reduce all the lanes of a boolean vector to a single scalar
boolean value.

### Any lane true
* `b8x16.anyTrue(a: b8x16) -> boolean`
* `b16x8.anyTrue(a: b16x8) -> boolean`
* `b32x4.anyTrue(a: b32x4) -> boolean`
* `b64x2.anyTrue(a: b64x2) -> boolean`

These functions return true if any lane in `a` is true.

```python
def S.anyTrue(a):
    for i in range(S.Lanes):
        if a[i]:
            return true
    return false
```

### All lanes true
* `b8x16.allTrue(a: b8x16) -> boolean`
* `b16x8.allTrue(a: b16x8) -> boolean`
* `b32x4.allTrue(a: b32x4) -> boolean`
* `b64x2.allTrue(a: b64x2) -> boolean`

These functions return true if all lanes in `a` are true.

```python
def S.allTrue(a):
    for i in range(S.Lanes):
        if not a[i]:
            return false
    return true
```

## Comparisons

The comparison operations all compare two vectors lane-wise, and produce a
boolean vector with the same number of lanes as the input interpretation.

### Equality
* `i8x16.equal(a: v128, b: v128) -> b8x16`
* `i16x8.equal(a: v128, b: v128) -> b16x8`
* `i32x4.equal(a: v128, b: v128) -> b32x4`
* `i64x2.equal(a: v128, b: v128) -> b64x2`
* `f32x4.equal(a: v128, b: v128) -> b32x4`
* `f64x2.equal(a: v128, b: v128) -> b64x2`

Integer equality is independent of the signed/unsigned interpretation. Floating
point equality follows IEEE semantics, so a NaN lane compares not equal with
anything, including itself:

```python
def S.equal(a, b):
    def eq(x, y):
        return x == y
    return S.lanewise_comparison(eq, a, b)
```

### Non-equality
* `i8x16.notEqual(a: v128, b: v128) -> b8x16`
* `i16x8.notEqual(a: v128, b: v128) -> b16x8`
* `i32x4.notEqual(a: v128, b: v128) -> b32x4`
* `i64x2.notEqual(a: v128, b: v128) -> b64x2`
* `f32x4.notEqual(a: v128, b: v128) -> b32x4`
* `f64x2.notEqual(a: v128, b: v128) -> b64x2`

The `notEqual` operations produce the inverse of their `equal` counterparts:

```python
def S.notEqual(a, b):
    def ne(x, y):
        return x != y
    return S.lanewise_comparison(ne, a, b)
```

### Less than
* `s8x16.lessThan(a: v128, b: v128) -> b8x16`
* `s16x8.lessThan(a: v128, b: v128) -> b16x8`
* `s32x4.lessThan(a: v128, b: v128) -> b32x4`
* `s64x2.lessThan(a: v128, b: v128) -> b64x2`
* `u8x16.lessThan(a: v128, b: v128) -> b8x16`
* `u16x8.lessThan(a: v128, b: v128) -> b16x8`
* `u32x4.lessThan(a: v128, b: v128) -> b32x4`
* `u64x2.lessThan(a: v128, b: v128) -> b64x2`
* `f32x4.lessThan(a: v128, b: v128) -> b32x4`
* `f64x2.lessThan(a: v128, b: v128) -> b64x2`

Integer magnitude comparisons depend on the signed/unsigned interpretation of
the lanes. Floating point comparisons follow IEEE semantics:

```python
def S.lessThan(a, b):
    def lt(x, y):
        return x < y
    return S.lanewise_comparison(lt, a, b)
```

### Less than or equal
* `s8x16.lessThanOrEqual(a: v128, b: v128) -> b8x16`
* `s16x8.lessThanOrEqual(a: v128, b: v128) -> b16x8`
* `s32x4.lessThanOrEqual(a: v128, b: v128) -> b32x4`
* `s64x2.lessThanOrEqual(a: v128, b: v128) -> b64x2`
* `u8x16.lessThanOrEqual(a: v128, b: v128) -> b8x16`
* `u16x8.lessThanOrEqual(a: v128, b: v128) -> b16x8`
* `u32x4.lessThanOrEqual(a: v128, b: v128) -> b32x4`
* `u64x2.lessThanOrEqual(a: v128, b: v128) -> b64x2`
* `f32x4.lessThanOrEqual(a: v128, b: v128) -> b32x4`
* `f64x2.lessThanOrEqual(a: v128, b: v128) -> b64x2`

```python
def S.lessThanOrEqual(a, b):
    def le(x, y):
        return x <= y
    return S.lanewise_comparison(le, a, b)
```

### Greater than
* `s8x16.greaterThan(a: v128, b: v128) -> b8x16`
* `s16x8.greaterThan(a: v128, b: v128) -> b16x8`
* `s32x4.greaterThan(a: v128, b: v128) -> b32x4`
* `s64x2.greaterThan(a: v128, b: v128) -> b64x2`
* `u8x16.greaterThan(a: v128, b: v128) -> b8x16`
* `u16x8.greaterThan(a: v128, b: v128) -> b16x8`
* `u32x4.greaterThan(a: v128, b: v128) -> b32x4`
* `u64x2.greaterThan(a: v128, b: v128) -> b64x2`
* `f32x4.greaterThan(a: v128, b: v128) -> b32x4`
* `f64x2.greaterThan(a: v128, b: v128) -> b64x2`

```python
def S.greaterThan(a, b):
    def gt(x, y):
        return x > y
    return S.lanewise_comparison(gt, a, b)
```

### Greater than or equal
* `s8x16.greaterThanOrEqual(a: v128, b: v128) -> b8x16`
* `s16x8.greaterThanOrEqual(a: v128, b: v128) -> b16x8`
* `s32x4.greaterThanOrEqual(a: v128, b: v128) -> b32x4`
* `s64x2.greaterThanOrEqual(a: v128, b: v128) -> b64x2`
* `u8x16.greaterThanOrEqual(a: v128, b: v128) -> b8x16`
* `u16x8.greaterThanOrEqual(a: v128, b: v128) -> b16x8`
* `u32x4.greaterThanOrEqual(a: v128, b: v128) -> b32x4`
* `u64x2.greaterThanOrEqual(a: v128, b: v128) -> b64x2`
* `f32x4.greaterThanOrEqual(a: v128, b: v128) -> b32x4`
* `f64x2.greaterThanOrEqual(a: v128, b: v128) -> b64x2`

```python
def S.greaterThanOrEqual(a, b):
    def ge(x, y):
        return x >= y
    return S.lanewise_comparison(ge, a, b)
```

## Load and store

Load and store operations are provided for `v128` vectors, but not for the
boolean vectors; we don't want to impose a bitwise representation of the boolean
vectors.

The memory operations work on an abstract `Buffer` instance which can be
addressed by a `ByteOffset` type. Unaligned memory operations are allowed, but
they may be slower than aligned operations.

This specification does not address bounds checking and trap handling for memory
operations. It is assumed that the range `addr .. addr+15` are valid offsets in
the buffer, and that computing `addr+15` does not overflow the `ByteOffset`
type. Bounds checking should be handled by the embedding specification.

### Load

* `v8x16.load(mem: Buffer, addr: ByteOffset) -> v128`
* `v16x8.load(mem: Buffer, addr: ByteOffset) -> v128`
* `v32x4.load(mem: Buffer, addr: ByteOffset) -> v128`
* `v64x2.load(mem: Buffer, addr: ByteOffset) -> v128`

Load a `v128` vector from the given buffer and offset.

```python
def S.load(mem, addr):
    assert mem.in_range(addr, 16)
    result = S.New()
    lane_bytes = S.LaneBits / 8
    for i in range(S.Lanes):
        result[i] = mem.load(S.LaneBits, addr + i * lane_bytes)
    return result
```

### Store

* `v8x16.store(mem: Buffer, addr: ByteOffset, data: v128)`
* `v16x8.store(mem: Buffer, addr: ByteOffset, data: v128)`
* `v32x4.store(mem: Buffer, addr: ByteOffset, data: v128)`
* `v64x2.store(mem: Buffer, addr: ByteOffset, data: v128)`

Store a `v128` vector to the given buffer and offset.

```python
def S.store(mem, addr, data):
    assert mem.in_range(addr, 16)
    lane_bytes = S.LaneBits / 8
    for i in range(S.Lanes):
        mem.store(S.LaneBits, addr + i * lane_bytes, data[i])
```

### Byte order and lane numbering

The lane-wise load and store operations used above will read and write a lane
using the native byte order, so for example storing a vector with the `i32x4`
interpretation is equivalent to storing 4 `i32` values to memory. This
specification has some hard requirements for the lane and bit numbering:

- The bits in a `v128` are numbered 0-127.
- Lanes are numbered in the same direction as the `v128` bits.
- Lanes are stored in memory in ascending addresses, so lane 0 gets the lowest
  address.

These hard requirements still leave multiple ways of mapping byte order to
vectors:

- **Little-endian direct**: The bit with the lowest number in each lane is the
  *least* significant bit. This is the natural mapping for Intel SSE and the
  little-endian modes of ARM NEON and MIPS MSA.

- **Big-endian direct**: The bit with the lowest number in each lane is the *most*
  significant bit. This is the natural mapping for big-endian PowerPC.

- **Big-endian hybrid**: The bit with the lowest number in each lane is the
  *least* significant bit. This is the natural mapping for the big-endian modes
  of ARM NEON and MIPS MSA.

The mapping is visible when reinterpreting a vector:

```python
a = i64x2.build([0x0123456789abcdef, 0x1122334455667788])
x = i8x16.extractLane(a, 0)
```

The extracted lane, `x`, will be `0xef` in the little-endian direct and the
big-endian hybrid mappings, but `0x01` in the big-endian direct mapping.

The big-endian hybrid mapping requires separate load and store instructions for
each lane width, while the direct mappings can use the same instruction for all
vectors. For example, the `a` vector above will be stored like this with the
big-endian hybrid mapping:

```
v64x2.store: 01 23 45 67 89 ab cd ef 11 22 33 44 55 66 77 88
v32x4.store: 89 ab cd ef 01 23 45 67 55 66 77 88 11 22 33 44
v16x8.store: cd ef 89 ab 45 67 01 23 77 88 55 66 33 44 11 22
v8x16.store: ef cd ab 89 67 45 23 01 88 77 66 55 44 33 22 11
```

The big-endian direct mapping would write `a` like this:

```
v64x2.store: 01 23 45 67 89 ab cd ef 11 22 33 44 55 66 77 88
v32x4.store: 01 23 45 67 89 ab cd ef 11 22 33 44 55 66 77 88
v16x8.store: 01 23 45 67 89 ab cd ef 11 22 33 44 55 66 77 88
v8x16.store: 01 23 45 67 89 ab cd ef 11 22 33 44 55 66 77 88
```

The little-endian direct mapping would write `a` like this:

```
v64x2.store: ef cd ab 89 67 45 23 01 88 77 66 55 44 33 22 11
v32x4.store: ef cd ab 89 67 45 23 01 88 77 66 55 44 33 22 11
v16x8.store: ef cd ab 89 67 45 23 01 88 77 66 55 44 33 22 11
v8x16.store: ef cd ab 89 67 45 23 01 88 77 66 55 44 33 22 11
```

This specification doesn't address type conversions since there is only one
type, `v128`, but note that it is common for more fine-grained SIMD type systems
to specify 'bit casts' between different SIMD types of the same size as
equivalent to storing one type and loading another from the same address. Both
LLVM and SIMD.js specify bit casts that way. LLVM's ARM and MIPS targets use the
hybrid lane mapping in their big-endian modes and translate `bitcast`
instructions to shuffles.

It would be possible for SIMD.js to use the big-endian direct mapping on ARM and
MIPS by numbering the lanes differently and using the `64x2` load/store
instructions for all memory operations. It would also be possible to use the
big-endian hybrid mapping by expanding bit casts into shuffles.

WebAssembly is little-endian only.

### Partial load

* `v32x4.load1(mem: Buffer, addr: ByteOffset) -> v128`
* `v32x4.load2(mem: Buffer, addr: ByteOffset) -> v128`
* `v32x4.load3(mem: Buffer, addr: ByteOffset) -> v128`

These functions load the first 1, 2, or 3 lanes from a buffer and sets the
remaining lanes to all zeroes. The partial loads are only defined for 4-lane
interpretations.

```python
def partial_load(mem, addr, lanes):
    result = v32x4.splat(0)
    for i in range(lanes):
        result[i] = mem.load(32, addr + i * 4)
    return result

def v32x4.load1(mem, addr):
    assert mem.in_range(addr, 4)
    return partial_load(mem, addr, 1)

def v32x4.load2(mem, addr):
    assert mem.in_range(addr, 8)
    return partial_load(mem, addr, 2)

def v32x4.load3(mem, addr):
    assert mem.in_range(addr, 12)
    return partial_load(mem, addr, 3)
```

### Partial store

* `v32x4.store1(mem: Buffer, addr: ByteOffset, data: v128)`
* `v32x4.store2(mem: Buffer, addr: ByteOffset, data: v128)`
* `v32x4.store3(mem: Buffer, addr: ByteOffset, data: v128)`

These functions store the first 1, 2, or 3 lanes to a buffer. They are only
defined for the 4-lane interpretations.

```python
def partial_store(mem, addr, data, lanes):
    for i in range(lanes):
        mem.store(32, addr + i * 4, data[i])

def v32x4.store1(mem, addr, data):
    assert mem.in_range(addr, 4)
    partial_store(mem, addr, data, 1)

def v32x4.store2(mem, addr, data):
    assert mem.in_range(addr, 8)
    partial_store(mem, addr, data, 2)

def v32x4.store3(mem, addr, data):
    assert mem.in_range(addr, 12)
    partial_store(mem, addr, data, 3)
```

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

These operations are not part of the IEEE 754-2008 standard. Notably, the
`minNum` and `maxNum` operations defined here behave differently than the IEEE
`minNum` and `maxNum` operations when one operand is a signaling NaN.

The minimum and maximum value of +0 and -0 is computed as if -0 < +0.

### NaN-propagating minimum
* `f32x4.min(a: v128, b: v128) -> v128`
* `f64x2.min(a: v128, b: v128) -> v128`

Lane-wise minimum value, propagating NaNs:

```python
def S.min(a, b):
    def min(x, y):
        if isnan(x) or isnan(y):
            return propagate_nan(x, y)
        # Prefer -0 for min(-0, +0) and min(+0, -0).
        if x == 0 and y == 0 and signbit(x) != signbit(y):
            return -0.0
        if x < y:
            return x
        else:
            return y
    return S.lanewise_binary(min, a, b)
```

### NaN-propagating maximum
* `f32x4.max(a: v128, b: v128) -> v128`
* `f64x2.max(a: v128, b: v128) -> v128`

Lane-wise maximum value, propagating NaNs:

```python
def S.max(a, b):
    def max(x, y):
        if isnan(x) or isnan(y):
            return propagate_nan(x, y)
        # Prefer +0 for max(-0, +0) and max(+0, -0).
        if x == 0 and y == 0 and signbit(x) != signbit(y):
            return +0.0
        if x > y:
            return x
        else:
            return y
    return S.lanewise_binary(max, a, b)
```

### NaN-suppressing minimum
* `f32x4.minNum(a: v128, b: v128) -> v128`
* `f64x2.minNum(a: v128, b: v128) -> v128`

Lane-wise minimum value, suppressing single NaNs:

```python
def S.minNum(a, b):
    def minNum(x, y):
        if isnan(x) and isnan(y):
            return propagate_nan(x, y)
        if isnan(x):
            return y
        if isnan(y):
            return x
        # Prefer -0 for min(-0, +0) and min(+0, -0).
        if x == 0 and y == 0 and signbit(x) != signbit(y):
            return -0.0
        if x < y:
            return x
        else:
            return y
    return S.lanewise_binary(minNum, a, b)
```

Note that this function behaves differently than the IEEE 754 `minNum` function
when one of the operands is a signaling NaN.

### NaN-suppressing maximum
* `f32x4.maxNum(a: v128, b: v128) -> v128`
* `f64x2.maxNum(a: v128, b: v128) -> v128`

Lane-wise maximum value, suppressing single NaNs:

```python
def S.maxNum(a, b):
    def maxNum(a, b):
        if isnan(x) and isnan(y):
            return propagate_nan(x, y)
        if isnan(x):
            return y
        if isnan(y):
            return x
        # Prefer +0 for max(-0, +0) and max(+0, -0).
        if x == 0 and y == 0 and signbit(x) != signbit(y):
            return +0.0
        if x > y:
            return x
        else:
            return y
    return S.lanewise_binary(maxNum, a, b)
```

Note that this function behaves differently than the IEEE 754 `maxNum` function
when one of the operands is a signaling NaN.

## Floating-point arithmetic

The floating-point arithmetic operations handle NaNs more strictly specified
than the IEEE standard:

```python
def wrap_fp_unary(func, rmode):
    def wrapped(x):
        if isnan(x):
            return canonicalize_nan(x)
        result = func(x, rmode)
        if isnan(result):
            return type(result).default_nan()
        else:
            return result
    return wrapped

def wrap_fp_binary(func, rmode):
    def wrapped(x, y):
        if isnan(x) or isnan(y):
            return propagate_nan(x, y)
        result = func(x, y, rmode)
        if isnan(result):
            return type(result).default_nan()
        else:
            return result
    return wrapped
```

### Addition
* `f32x4.add(a: v128, b: v128, rmode: RoundingMode) -> v128`
* `f64x2.add(a: v128, b: v128, rmode: RoundingMode) -> v128`

Lane-wise IEEE `addition`.

```python
def S.add(a, b, rmode):
    return S.lanewise_binary(wrap_fp_binary(ieee.addition, rmode), a, b)
```

### Subtraction
* `f32x4.sub(a: v128, b: v128, rmode: RoundingMode) -> v128`
* `f64x2.sub(a: v128, b: v128, rmode: RoundingMode) -> v128`

Lane-wise IEEE `subtraction`.

```python
def S.sub(a, b, rmode):
    return S.lanewise_binary(wrap_fp_binary(ieee.subtraction, rmode), a, b)
```

### Division
* `f32x4.div(a: v128, b: v128, rmode: RoundingMode) -> v128`
* `f64x2.div(a: v128, b: v128, rmode: RoundingMode) -> v128`

Lane-wise IEEE `division`.

```python
def S.div(a, b, rmode):
    return S.lanewise_binary(wrap_fp_binary(ieee.division, rmode), a, b)
```

### Multiplication
* `f32x4.mul(a: v128, b: v128, rmode: RoundingMode) -> v128`
* `f64x2.mul(a: v128, b: v128, rmode: RoundingMode) -> v128`

Lane-wise IEEE `multiplication`.

```python
def S.mul(a, b, rmode):
    return S.lanewise_binary(wrap_fp_binary(ieee.multiplication, rmode), a, b)
```

### Square root
* `f32x4.sqrt(a: v128, rmode: RoundingMode) -> v128`
* `f64x2.sqrt(a: v128, rmode: RoundingMode) -> v128`

Lane-wise IEEE `squareRoot`.

```python
def S.sqrt(a, rmode):
    return S.lanewise_unary(wrap_fp_unary(ieee.squareRoot, rmode), a)
```

### Reciprocal approximation
* `f32x4.reciprocalApproximation(a: v128) -> v128`
* `f64x2.reciprocalApproximation(a: v128) -> v128`

Implementation-dependent approximation to the reciprocal.

```python
def S.reciprocalApproximation(a):
    def recip_approx(x):
        if isnan(x):
            return canonicalize_nan(x)
        if x == 0.0:
            # +0.0 -> +Inf, -0.0 -> -Inf.
            return 1/x
        if isinf(x):
            # +Inf -> +0.0, -Inf -> -0.0.
            return 1/x
        # The exact nature of the approximation is unspecified.
        return implementation_dependent(x)
    return S.lanewise_unary(recip_approx, a)
```

### Reciprocal square root approximation
* `f32x4.reciprocalSqrtApproximation(a: v128) -> v128`
* `f64x2.reciprocalSqrtApproximation(a: v128) -> v128`

Implementation-dependent approximation to the reciprocal of the square root.

```python
def S.reciprocalSqrtApproximation(a):
    def recip_sqrt_approx(x):
        if isnan(x):
            return canonicalize_nan(x)
        if x == 0:
            # +0.0 -> +Inf, -0.0 -> -Inf.
            return 1/x
        if isinf(x):
            # +Inf -> +0.0, -Inf -> -0.0.
            return 1/x
        # The exact nature of the approximation is unspecified.
        return implementation_dependent(x)
    return S.lanewise_unary(recip_sqrt_approx, a)
```

## Conversions
### Integer to floating point
* `f32x4.fromSignedInt(a: v128, rmode: RoundingMode) -> v128`
* `f64x2.fromSignedInt(a: v128, rmode: RoundingMode) -> v128`
* `f32x4.fromUnsignedInt(a: v128, rmode: RoundingMode) -> v128`
* `f64x2.fromUnsignedInt(a: v128, rmode: RoundingMode) -> v128`

Lane-wise conversion from integer to floating point. Some integer values will be
rounded.

```python
def S.fromSignedInt(a, rmode):
    def convert(x):
        return S.LaneType.convertFromInt(x, rmode)
    return S.lanewise_unary(convert, a)

def S.fromUnsignedInt(a, rmode):
    def convert(x):
        return S.LaneType.convertFromInt(x, rmode)
    return S.lanewise_unary(convert, a)
```

### Floating point to integer
* `s32x4.fromFloat(a: v128) -> (result: v128, fail: boolean)`
* `s64x2.fromFloat(a: v128) -> (result: v128, fail: boolean)`
* `u32x4.fromFloat(a: v128) -> (result: v128, fail: boolean)`
* `u64x2.fromFloat(a: v128) -> (result: v128, fail: boolean)`

Lane-wise conversion from floating point to integer using the IEEE
`convertToIntegerTowardZero` function. If any lane is a NaN or the rounded
integer value is outside the range of the destination type, return `fail = true`
and an unspecified `result`.

```python
def S.fromFloat(a):
    result = S.New()
    fail = false
    for i in range(S.Lanes):
        r = ieee.roundToIntegralTowardZero(a[i])
        if isnan(r):
            fail = true
        elif S.Min <= r and r <= S.Max:
            result[i] = r
        else:
            fail = true
    if fail:
       return (unspecified(), true)
    else
       return (result, false)
```

[wasm]: https://webassembly.github.io/ (WebAssembly)
[simdjs]: http://tc39.github.io/ecmascript_simd/ (SIMD.js specification)
[ieee754]: https://standards.ieee.org/findstds/standard/754-2008.html (754-2008 - IEEE Standard for Floating-Point Arithmetic)

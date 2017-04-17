# SIMD support for WebAssembly

This proposal describes how 128-bit SIMD types and operations can be added to
WebAssembly. It is based on [previous work on SIMD.js in the Ecma TC39
ECMAScript committee](https://github.com/tc39/ecmascript_simd) and the
[portable SIMD specification](https://github.com/stoklund/portable-simd) that
resulted.

There are three parts to the proposal:

1. [A specification of portable SIMD operations](portable-simd.md) that came
   out of the SIMD.js work.
2. [A table of proposed WebAssembly operations](webassembly-opcodes.md) with
   links to the portable specification.
3. This document which describes the mapping between WebAssembly and the
   portable specification.

# Mapping portable SIMD to WebAssembly

The types and operations in the portable SIMD specification are relatively
straightforward to map to WebAssembly. This section describes the details of
the mapping.

The following operations are *not* provided in WebAssembly:

- `f*.maxNum` and `f*.minNum`. These NaN-suppressing operations don't exist in
  scalar WebAssembly versions either. The NaN-propagating versions are provided.
- `f*.reciprocalApproximation` and `f*.reciprocalSqrtApproximation` are omitted
  from WebAssembly pending further discussion.

## New value types

The following value types are added to the WebAssembly type system to support
128-bit SIMD operations. Each new WebAssembly value type corresponds to the
[portable SIMD type](portable-simd.md#simd-types) of the same name.

* `v128`: A 128-bit SIMD vector.
* `b8x16`: A vector of 16 boolean lanes.
* `b16x8`: A vector of 8 boolean lanes.
* `b32x4`: A vector of 4 boolean lanes.
* `b64x2`: A vector of 2 boolean lanes.

The 128 bits in a `v128` value are interpreted differently by different
operations. They can represent vectors of integers or IEEE floating point
numbers.

The four boolean vector types do not have a prescribed representation in
memory; they can't be loaded or stored. This allows implementations to choose
the most efficient representation, whether as a predicate vector or some
variant of bits in a vector register.

## Scalar type mapping

Some operations in the portable SIMD specification use scalar types that don't
exist in WebAssembly. These types are mapped into WebAssembly as follows:

* `i8` and `i16`: SIMD operations that take these types as an input are passed
  a WebAssembly `i32` instead and use only the low bits, ignoring the high
  bits. The `extractLane` operation can return these types; it is provided in
  variants that either sign-extend or zero-extend to an `i32`.

* `boolean`: SIMD operations with a boolean argument will accept a WebAssembly
  `i32` instead and treat zero as false and non-zero values as true. SIMD
  operations that return a boolean will return an `i32` with the value 0 or 1.

* `LaneIdx2` through `LaneIdx32`: All lane indexes are encoded as `varuint7`
  immediate operands. Dynamic lane indexes are not used anywhere. An
  out-of-range lane index is a validation error.

* `RoundingMode`: Rounding modes are encoded as `varuint7` immediate operands.
  An out-of-range rounding mode is a validation error.

## SIMD operations

Most operation names are simply mapped from their portable SIMD versions. Some
are renamed to match existing conventions in WebAssembly. The integer
operations that distinguish between signed and unsigned integers are given `_s`
or `_u` suffixes. For example, `s32x4.greaterThan` becomes `i32x4.gt_s`, c.f.
the existing `i32.gt_s` WebAssembly operation.

[The complete set of proposed opcodes](webassembly-opcodes.md) can be found in
a separate table.

### Floating point conversions

The `fromSignedInt` and `fromUnsignedInt` conversions to float never fail, so
they are simply renamed:

* `f32x4.convert_s/i32x4(a: v128, rmode: RoundingMode) -> v128`
* `f64x2.convert_s/i64x2(a: v128, rmode: RoundingMode) -> v128`
* `f32x4.convert_u/i32x4(a: v128, rmode: RoundingMode) -> v128`
* `f64x2.convert_u/i64x2(a: v128, rmode: RoundingMode) -> v128`

The float to integer conversions can fail. Conversion failure in any lane is
converted to a trap, same as the scalar WebAssembly conversions:

* `i32x4.trunc_s/f32x4(a: v128) -> v128`
* `i64x2.trunc_s/f64x2(a: v128) -> v128`
* `i32x4.trunc_u/f32x4(a: v128) -> v128`
* `i64x2.trunc_u/f64x2(a: v128) -> v128`

### Memory accesses

The load and store operations use the same addressing and bounds checking as the
scalar WebAssembly memory instructions, and effective addresses are provided in
the same way by a dynamic address and an immediate offset operand.

Since WebAssembly is always little-endian, the `load` and `store` instructions
are not dependent on the lane-wise interpretation of the vector being loaded or
stored. This means that there are only two instructions:

* `v128.load(addr, offset) -> v128`
* `v128.store(addr, offset, data: v128)`

The natural alignment of these instructions is 16 bytes; unaligned accesses are
supported in the same way as for WebAssembly's normal scalar load and store
instructions, including the alignment hint.

The partial vector load/store instructions are specific to the 4-lane
interpretation:

* `v32x4.load1(addr, offset) -> v128`
* `v32x4.load2(addr, offset) -> v128`
* `v32x4.load3(addr, offset) -> v128`
* `v32x4.store1(addr, offset, data: v128)`
* `v32x4.store2(addr, offset, data: v128)`
* `v32x4.store3(addr, offset, data: v128)`

The natural alignment of these instructions is *4 bytes*, not the size of the
access.

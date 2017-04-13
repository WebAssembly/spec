# WebAssembly SIMD operations

The SIMD operations are grouped according to the interpretation of the input
and output vectors:

| Shape | Int | Float | Bool |
|:-----:|:---:|:-----:|:----:|
| [v8x16](#v8x16-operations) | [i8x16](#i8x16-operations) | - | [b8x16](#b8x16-operations) |
| [v16x8](#v16x8-operations) | [i16x8](#i16x8-operations) | - | [b16x8](#b16x8-operations) |
| [v32x4](#v32x4-operations) | [i32x4](#i32x4-operations) | [f32x4](#f32x4-operations) | [b32x4](#b32x4-operations) |
| [v64x2](#v64x2-operations) | [i64x2](#i64x2-operations) | [f64x2](#f64x2-operations) | [b64x2](#b64x2-operations) |

## `v128` operations
| WebAssembly                            | Portable SIMD |
|:---------------------------------------|:--------------|
| `v128.and(a: v128, b: v128) -> v128`   | [v128.and](portable-simd.md#bitwise-operations) |
| `v128.or(a: v128, b: v128) -> v128`    | [v128.or](portable-simd.md#bitwise-operations) |
| `v128.xor(a: v128, b: v128) -> v128`   | [v128.xor](portable-simd.md#bitwise-operations) |
| `v128.not(a: v128) -> v128`            | [v128.not](portable-simd.md#bitwise-operations) |
| `v128.load(addr, offset) -> v128`      | [v128.load](portable-simd.md#load) |
| `v128.store(addr, offset, data: v128)` | [v128.store](portable-simd.md#store) |

## `v8x16` operations
| WebAssembly                                                 | Portable SIMD |
|:------------------------------------------------------------|:--------------|
| `v8x16.select(s: b8x16, t: v128, f: v128) -> v128`          | [v8x16.select](portable-simd.md#lane-wise-select) |
| `v8x16.swizzle(a: v128, s: LaneIdx16[16]) -> v128`          | [v8x16.swizzle](portable-simd.md#swizzle-lanes) |
| `v8x16.shuffle(a: v128, b: v128, s: LaneIdx32[16]) -> v128` | [v8x16.shuffle](portable-simd.md#shuffle-lanes) |

## `i8x16` operations
| WebAssembly                                                | Portable SIMD |
|:-----------------------------------------------------------|:--------------|
| `i8x16.build(x: i32[16]) -> v128`                          | [i8x16.build](portable-simd.md#build-vector-from-individual-lanes) |
| `i8x16.splat(x: i32) -> v128`                              | [i8x16.splat](portable-simd.md#create-vector-with-identical-lanes) |
| `i8x16.extractLane_s(a: v128, i: LaneIdx16) -> i32`        | [i8x16.extractLane](portable-simd.md#extract-lane-as-a-scalar) |
| `i8x16.extractLane_u(a: v128, i: LaneIdx16) -> i32`        | [i8x16.extractLane](portable-simd.md#extract-lane-as-a-scalar) |
| `i8x16.replaceLane(a: v128, i: LaneIdx16, x: i32) -> v128` | [i8x16.replaceLane](portable-simd.md#replace-lane-value) |
| `i8x16.add(a: v128, b: v128) -> v128`                      | [i8x16.add](portable-simd.md#integer-addition) |
| `i8x16.sub(a: v128, b: v128) -> v128`                      | [i8x16.sub](portable-simd.md#integer-subtraction) |
| `i8x16.mul(a: v128, b: v128) -> v128`                      | [i8x16.mul](portable-simd.md#integer-multiplication) |
| `i8x16.neg(a: v128) -> v128`                               | [i8x16.neg](portable-simd.md#integer-negation) |
| `i8x16.addSaturate_s(a: v128, b: v128) -> v128`            | [s8x16.addSaturate](portable-simd.md#saturating-integer-addition) |
| `i8x16.addSaturate_u(a: v128, b: v128) -> v128`            | [u8x16.addSaturate](portable-simd.md#saturating-integer-addition) |
| `i8x16.subSaturate_s(a: v128, b: v128) -> v128`            | [s8x16.subSaturate](portable-simd.md#saturating-integer-subtraction) |
| `i8x16.subSaturate_u(a: v128, b: v128) -> v128`            | [u8x16.subSaturate](portable-simd.md#saturating-integer-subtraction) |
| `i8x16.shl(a: v128, y: i32) -> v128`                       | [i8x16.shiftLeftByScalar](portable-simd.md#left-shift-by-scalar) |
| `i8x16.shr_s(a: v128, y: i32) -> v128`                     | [s8x16.shiftRightByScalar](portable-simd.md#right-shift-by-scalar) |
| `i8x16.shr_u(a: v128, y: i32) -> v128`                     | [u8x16.shiftRightByScalar](portable-simd.md#right-shift-by-scalar) |
| `i8x16.eq(a: v128, b: v128) -> b8x16`                      | [i8x16.equal](portable-simd.md#equality) |
| `i8x16.ne(a: v128, b: v128) -> b8x16`                      | [i8x16.notEqual](portable-simd.md#non-equality) |
| `i8x16.lt_s(a: v128, b: v128) -> b8x16`                    | [s8x16.lessThan](portable-simd.md#less-than) |
| `i8x16.lt_u(a: v128, b: v128) -> b8x16`                    | [u8x16.lessThan](portable-simd.md#less-than) |
| `i8x16.le_s(a: v128, b: v128) -> b8x16`                    | [s8x16.lessThanOrEqual](portable-simd.md#less-than-or-equal) |
| `i8x16.le_u(a: v128, b: v128) -> b8x16`                    | [u8x16.lessThanOrEqual](portable-simd.md#less-than-or-equal) |
| `i8x16.gt_s(a: v128, b: v128) -> b8x16`                    | [s8x16.greaterThan](portable-simd.md#greater-than) |
| `i8x16.gt_u(a: v128, b: v128) -> b8x16`                    | [u8x16.greaterThan](portable-simd.md#greater-than) |
| `i8x16.ge_s(a: v128, b: v128) -> b8x16`                    | [s8x16.greaterThanOrEqual](portable-simd.md#greater-than-or-equal) |
| `i8x16.ge_u(a: v128, b: v128) -> b8x16`                    | [u8x16.greaterThanOrEqual](portable-simd.md#greater-than-or-equal) |

## `v16x8` operations
| WebAssembly                                                | Portable SIMD |
|:-----------------------------------------------------------|:--------------|
| `v16x8.select(s: b16x8, t: v128, f: v128) -> v128`         | [v16x8.select](portable-simd.md#lane-wise-select) |
| `v16x8.swizzle(a: v128, s: LaneIdx8[8]) -> v128`           | [v16x8.swizzle](portable-simd.md#swizzle-lanes) |
| `v16x8.shuffle(a: v128, b: v128, s: LaneIdx16[8]) -> v128` | [v16x8.shuffle](portable-simd.md#shuffle-lanes) |

## `i16x8` operations
| WebAssembly                                               | Portable SIMD |
|:----------------------------------------------------------|:--------------|
| `i16x8.build(x: i32[8]) -> v128`                          | [i16x8.build](portable-simd.md#build-vector-from-individual-lanes) |
| `i16x8.splat(x: i32) -> v128`                             | [i16x8.splat](portable-simd.md#create-vector-with-identical-lanes) |
| `i16x8.extractLane_s(a: v128, i: LaneIdx8) -> i32`        | [i16x8.extractLane](portable-simd.md#extract-lane-as-a-scalar) |
| `i16x8.extractLane_u(a: v128, i: LaneIdx8) -> i32`        | [i16x8.extractLane](portable-simd.md#extract-lane-as-a-scalar) |
| `i16x8.replaceLane(a: v128, i: LaneIdx8, x: i32) -> v128` | [i16x8.replaceLane](portable-simd.md#replace-lane-value) |
| `i16x8.add(a: v128, b: v128) -> v128`                     | [i16x8.add](portable-simd.md#integer-addition) |
| `i16x8.sub(a: v128, b: v128) -> v128`                     | [i16x8.sub](portable-simd.md#integer-subtraction) |
| `i16x8.mul(a: v128, b: v128) -> v128`                     | [i16x8.mul](portable-simd.md#integer-multiplication) |
| `i16x8.neg(a: v128) -> v128`                              | [i16x8.neg](portable-simd.md#integer-negation) |
| `i16x8.addSaturate_s(a: v128, b: v128) -> v128`           | [s16x8.addSaturate](portable-simd.md#saturating-integer-addition) |
| `i16x8.addSaturate_u(a: v128, b: v128) -> v128`           | [u16x8.addSaturate](portable-simd.md#saturating-integer-addition) |
| `i16x8.subSaturate_s(a: v128, b: v128) -> v128`           | [s16x8.subSaturate](portable-simd.md#saturating-integer-subtraction) |
| `i16x8.subSaturate_u(a: v128, b: v128) -> v128`           | [u16x8.subSaturate](portable-simd.md#saturating-integer-subtraction) |
| `i16x8.shl(a: v128, y: i32) -> v128`                      | [i16x8.shiftLeftByScalar](portable-simd.md#left-shift-by-scalar) |
| `i16x8.shr_s(a: v128, y: i32) -> v128`                    | [s16x8.shiftRightByScalar](portable-simd.md#right-shift-by-scalar) |
| `i16x8.shr_u(a: v128, y: i32) -> v128`                    | [u16x8.shiftRightByScalar](portable-simd.md#right-shift-by-scalar) |
| `i16x8.eq(a: v128, b: v128) -> b16x8`                     | [i16x8.equal](portable-simd.md#equality) |
| `i16x8.ne(a: v128, b: v128) -> b16x8`                     | [i16x8.notEqual](portable-simd.md#non-equality) |
| `i16x8.lt_s(a: v128, b: v128) -> b16x8`                   | [s16x8.lessThan](portable-simd.md#less-than) |
| `i16x8.lt_u(a: v128, b: v128) -> b16x8`                   | [u16x8.lessThan](portable-simd.md#less-than) |
| `i16x8.le_s(a: v128, b: v128) -> b16x8`                   | [s16x8.lessThanOrEqual](portable-simd.md#less-than-or-equal) |
| `i16x8.le_u(a: v128, b: v128) -> b16x8`                   | [u16x8.lessThanOrEqual](portable-simd.md#less-than-or-equal) |
| `i16x8.gt_s(a: v128, b: v128) -> b16x8`                   | [s16x8.greaterThan](portable-simd.md#greater-than) |
| `i16x8.gt_u(a: v128, b: v128) -> b16x8`                   | [u16x8.greaterThan](portable-simd.md#greater-than) |
| `i16x8.ge_s(a: v128, b: v128) -> b16x8`                   | [s16x8.greaterThanOrEqual](portable-simd.md#greater-than-or-equal) |
| `i16x8.ge_u(a: v128, b: v128) -> b16x8`                   | [u16x8.greaterThanOrEqual](portable-simd.md#greater-than-or-equal) |

## `v32x4` operations
| WebAssembly                                               | Portable SIMD |
|:----------------------------------------------------------|:--------------|
| `v32x4.select(s: b32x4, t: v128, f: v128) -> v128`        | [v32x4.select](portable-simd.md#lane-wise-select) |
| `v32x4.swizzle(a: v128, s: LaneIdx4[4]) -> v128`          | [v32x4.swizzle](portable-simd.md#swizzle-lanes) |
| `v32x4.shuffle(a: v128, b: v128, s: LaneIdx8[4]) -> v128` | [v32x4.shuffle](portable-simd.md#shuffle-lanes) |
| `v32x4.load1(addr, offset) -> v128`                       | [v32x4.load1](portable-simd.md#partial-load) |
| `v32x4.load2(addr, offset) -> v128`                       | [v32x4.load2](portable-simd.md#partial-load) |
| `v32x4.load3(addr, offset) -> v128`                       | [v32x4.load3](portable-simd.md#partial-load) |
| `v32x4.store1(addr, offset, data: v128)`                  | [v32x4.store1](portable-simd.md#partial-store) |
| `v32x4.store2(addr, offset, data: v128)`                  | [v32x4.store2](portable-simd.md#partial-store) |
| `v32x4.store3(addr, offset, data: v128)`                  | [v32x4.store3](portable-simd.md#partial-store) |

## `i32x4` operations
| WebAssembly                                               | Portable SIMD |
|:----------------------------------------------------------|:--------------|
| `i32x4.build(x: i32[4]) -> v128`                          | [i32x4.build](portable-simd.md#build-vector-from-individual-lanes) |
| `i32x4.splat(x: i32) -> v128`                             | [i32x4.splat](portable-simd.md#create-vector-with-identical-lanes) |
| `i32x4.extractLane(a: v128, i: LaneIdx4) -> i32`          | [i32x4.extractLane](portable-simd.md#extract-lane-as-a-scalar) |
| `i32x4.replaceLane(a: v128, i: LaneIdx4, x: i32) -> v128` | [i32x4.replaceLane](portable-simd.md#replace-lane-value) |
| `i32x4.add(a: v128, b: v128) -> v128`                     | [i32x4.add](portable-simd.md#integer-addition) |
| `i32x4.sub(a: v128, b: v128) -> v128`                     | [i32x4.sub](portable-simd.md#integer-subtraction) |
| `i32x4.mul(a: v128, b: v128) -> v128`                     | [i32x4.mul](portable-simd.md#integer-multiplication) |
| `i32x4.neg(a: v128) -> v128`                              | [i32x4.neg](portable-simd.md#integer-negation) |
| `i32x4.shl(a: v128, y: i32) -> v128`                      | [i32x4.shiftLeftByScalar](portable-simd.md#left-shift-by-scalar) |
| `i32x4.shr_s(a: v128, y: i32) -> v128`                    | [s32x4.shiftRightByScalar](portable-simd.md#right-shift-by-scalar) |
| `i32x4.shr_u(a: v128, y: i32) -> v128`                    | [u32x4.shiftRightByScalar](portable-simd.md#right-shift-by-scalar) |
| `i32x4.eq(a: v128, b: v128) -> b32x4`                     | [i32x4.equal](portable-simd.md#equality) |
| `i32x4.ne(a: v128, b: v128) -> b32x4`                     | [i32x4.notEqual](portable-simd.md#non-equality) |
| `i32x4.lt_s(a: v128, b: v128) -> b32x4`                   | [s32x4.lessThan](portable-simd.md#less-than) |
| `i32x4.lt_u(a: v128, b: v128) -> b32x4`                   | [u32x4.lessThan](portable-simd.md#less-than) |
| `i32x4.le_s(a: v128, b: v128) -> b32x4`                   | [s32x4.lessThanOrEqual](portable-simd.md#less-than-or-equal) |
| `i32x4.le_u(a: v128, b: v128) -> b32x4`                   | [u32x4.lessThanOrEqual](portable-simd.md#less-than-or-equal) |
| `i32x4.gt_s(a: v128, b: v128) -> b32x4`                   | [s32x4.greaterThan](portable-simd.md#greater-than) |
| `i32x4.gt_u(a: v128, b: v128) -> b32x4`                   | [u32x4.greaterThan](portable-simd.md#greater-than) |
| `i32x4.ge_s(a: v128, b: v128) -> b32x4`                   | [s32x4.greaterThanOrEqual](portable-simd.md#greater-than-or-equal) |
| `i32x4.ge_u(a: v128, b: v128) -> b32x4`                   | [u32x4.greaterThanOrEqual](portable-simd.md#greater-than-or-equal) |
| `i32x4.trunc_s/f32x4(a: v128) -> v128`                    | [s32x4.fromFloat](portable-simd.md#floating-point-to-integer) |
| `i32x4.trunc_u/f32x4(a: v128) -> v128`                    | [u32x4.fromFloat](portable-simd.md#floating-point-to-integer) |

## `f32x4` operations
| WebAssembly                                                   | Portable SIMD |
|:--------------------------------------------------------------|:--------------|
| `f32x4.build(x: f32[4]) -> v128`                              | [f32x4.build](portable-simd.md#build-vector-from-individual-lanes) |
| `f32x4.splat(x: f32) -> v128`                                 | [f32x4.splat](portable-simd.md#create-vector-with-identical-lanes) |
| `f32x4.extractLane(a: v128, i: LaneIdx4) -> f32`              | [f32x4.extractLane](portable-simd.md#extract-lane-as-a-scalar) |
| `f32x4.replaceLane(a: v128, i: LaneIdx4, x: f32) -> v128`     | [f32x4.replaceLane](portable-simd.md#replace-lane-value) |
| `f32x4.add(a: v128, b: v128, rmode: RoundingMode) -> v128`    | [f32x4.add](portable-simd.md#addition) |
| `f32x4.sub(a: v128, b: v128, rmode: RoundingMode) -> v128`    | [f32x4.sub](portable-simd.md#subtraction) |
| `f32x4.mul(a: v128, b: v128, rmode: RoundingMode) -> v128`    | [f32x4.mul](portable-simd.md#multiplication) |
| `f32x4.neg(a: v128) -> v128`                                  | [f32x4.neg](portable-simd.md#negation) |
| `f32x4.eq(a: v128, b: v128) -> b32x4`                         | [f32x4.equal](portable-simd.md#equality) |
| `f32x4.ne(a: v128, b: v128) -> b32x4`                         | [f32x4.notEqual](portable-simd.md#non-equality) |
| `f32x4.lt(a: v128, b: v128) -> b32x4`                         | [f32x4.lessThan](portable-simd.md#less-than) |
| `f32x4.le(a: v128, b: v128) -> b32x4`                         | [f32x4.lessThanOrEqual](portable-simd.md#less-than-or-equal) |
| `f32x4.gt(a: v128, b: v128) -> b32x4`                         | [f32x4.greaterThan](portable-simd.md#greater-than) |
| `f32x4.ge(a: v128, b: v128) -> b32x4`                         | [f32x4.greaterThanOrEqual](portable-simd.md#greater-than-or-equal) |
| `f32x4.abs(a: v128) -> v128`                                  | [f32x4.abs](portable-simd.md#absolute-value) |
| `f32x4.min(a: v128, b: v128) -> v128`                         | [f32x4.min](portable-simd.md#nan-propagating-minimum) |
| `f32x4.max(a: v128, b: v128) -> v128`                         | [f32x4.max](portable-simd.md#nan-propagating-maximum) |
| `f32x4.div(a: v128, b: v128, rmode: RoundingMode) -> v128`    | [f32x4.div](portable-simd.md#division) |
| `f32x4.sqrt(a: v128, rmode: RoundingMode) -> v128`            | [f32x4.sqrt](portable-simd.md#square-root) |
| `f32x4.reciprocalApproximation(a: v128) -> v128`              | [f32x4.reciprocalApproximation](portable-simd.md#reciprocal-approximation) |
| `f32x4.reciprocalSqrtApproximation(a: v128) -> v128`          | [f32x4.reciprocalSqrtApproximation](portable-simd.md#reciprocal-square-root-approximation) |
| `f32x4.convert_s/i32x4(a: v128, rmode: RoundingMode) -> v128` | [f32x4.fromSignedInt](portable-simd.md#integer-to-floating-point) |
| `f32x4.convert_u/i32x4(a: v128, rmode: RoundingMode) -> v128` | [f32x4.fromUnsignedInt](portable-simd.md#integer-to-floating-point) |

## `v64x2` operations
| WebAssembly                                               | Portable SIMD |
|:----------------------------------------------------------|:--------------|
| `v64x2.select(s: b64x2, t: v128, f: v128) -> v128`        | [v64x2.select](portable-simd.md#lane-wise-select) |
| `v64x2.swizzle(a: v128, s: LaneIdx2[2]) -> v128`          | [v64x2.swizzle](portable-simd.md#swizzle-lanes) |
| `v64x2.shuffle(a: v128, b: v128, s: LaneIdx4[2]) -> v128` | [v64x2.shuffle](portable-simd.md#shuffle-lanes) |

## `i64x2` operations
| WebAssembly                                               | Portable SIMD |
|:----------------------------------------------------------|:--------------|
| `i64x2.build(x: i64[2]) -> v128`                          | [i64x2.build](portable-simd.md#build-vector-from-individual-lanes) |
| `i64x2.splat(x: i64) -> v128`                             | [i64x2.splat](portable-simd.md#create-vector-with-identical-lanes) |
| `i64x2.extractLane(a: v128, i: LaneIdx2) -> i64`          | [i64x2.extractLane](portable-simd.md#extract-lane-as-a-scalar) |
| `i64x2.replaceLane(a: v128, i: LaneIdx2, x: i64) -> v128` | [i64x2.replaceLane](portable-simd.md#replace-lane-value) |
| `i64x2.add(a: v128, b: v128) -> v128`                     | [i64x2.add](portable-simd.md#integer-addition) |
| `i64x2.sub(a: v128, b: v128) -> v128`                     | [i64x2.sub](portable-simd.md#integer-subtraction) |
| `i64x2.mul(a: v128, b: v128) -> v128`                     | [i64x2.mul](portable-simd.md#integer-multiplication) |
| `i64x2.neg(a: v128) -> v128`                              | [i64x2.neg](portable-simd.md#integer-negation) |
| `i64x2.shl(a: v128, y: i32) -> v128`                      | [i64x2.shiftLeftByScalar](portable-simd.md#left-shift-by-scalar) |
| `i64x2.shr_s(a: v128, y: i32) -> v128`                    | [s64x2.shiftRightByScalar](portable-simd.md#right-shift-by-scalar) |
| `i64x2.shr_u(a: v128, y: i32) -> v128`                    | [u64x2.shiftRightByScalar](portable-simd.md#right-shift-by-scalar) |
| `i64x2.eq(a: v128, b: v128) -> b64x2`                     | [i64x2.equal](portable-simd.md#equality) |
| `i64x2.ne(a: v128, b: v128) -> b64x2`                     | [i64x2.notEqual](portable-simd.md#non-equality) |
| `i64x2.lt_s(a: v128, b: v128) -> b64x2`                   | [s64x2.lessThan](portable-simd.md#less-than) |
| `i64x2.lt_u(a: v128, b: v128) -> b64x2`                   | [u64x2.lessThan](portable-simd.md#less-than) |
| `i64x2.le_s(a: v128, b: v128) -> b64x2`                   | [s64x2.lessThanOrEqual](portable-simd.md#less-than-or-equal) |
| `i64x2.le_u(a: v128, b: v128) -> b64x2`                   | [u64x2.lessThanOrEqual](portable-simd.md#less-than-or-equal) |
| `i64x2.gt_s(a: v128, b: v128) -> b64x2`                   | [s64x2.greaterThan](portable-simd.md#greater-than) |
| `i64x2.gt_u(a: v128, b: v128) -> b64x2`                   | [u64x2.greaterThan](portable-simd.md#greater-than) |
| `i64x2.ge_s(a: v128, b: v128) -> b64x2`                   | [s64x2.greaterThanOrEqual](portable-simd.md#greater-than-or-equal) |
| `i64x2.ge_u(a: v128, b: v128) -> b64x2`                   | [u64x2.greaterThanOrEqual](portable-simd.md#greater-than-or-equal) |
| `i64x2.trunc_s/f64x2(a: v128) -> v128`                    | [s64x2.fromFloat](portable-simd.md#floating-point-to-integer) |
| `i64x2.trunc_u/f64x2(a: v128) -> v128`                    | [u64x2.fromFloat](portable-simd.md#floating-point-to-integer) |

## `f64x2` operations
| WebAssembly                                                   | Portable SIMD |
|:--------------------------------------------------------------|:--------------|
| `f64x2.build(x: f64[2]) -> v128`                              | [f64x2.build](portable-simd.md#build-vector-from-individual-lanes) |
| `f64x2.splat(x: f64) -> v128`                                 | [f64x2.splat](portable-simd.md#create-vector-with-identical-lanes) |
| `f64x2.extractLane(a: v128, i: LaneIdx2) -> f64`              | [f64x2.extractLane](portable-simd.md#extract-lane-as-a-scalar) |
| `f64x2.replaceLane(a: v128, i: LaneIdx2, x: f64) -> v128`     | [f64x2.replaceLane](portable-simd.md#replace-lane-value) |
| `f64x2.add(a: v128, b: v128, rmode: RoundingMode) -> v128`    | [f64x2.add](portable-simd.md#addition) |
| `f64x2.sub(a: v128, b: v128, rmode: RoundingMode) -> v128`    | [f64x2.sub](portable-simd.md#subtraction) |
| `f64x2.mul(a: v128, b: v128, rmode: RoundingMode) -> v128`    | [f64x2.mul](portable-simd.md#multiplication) |
| `f64x2.neg(a: v128) -> v128`                                  | [f64x2.neg](portable-simd.md#negation) |
| `f64x2.eq(a: v128, b: v128) -> b64x2`                         | [f64x2.equal](portable-simd.md#equality) |
| `f64x2.ne(a: v128, b: v128) -> b64x2`                         | [f64x2.notEqual](portable-simd.md#non-equality) |
| `f64x2.lt(a: v128, b: v128) -> b64x2`                         | [f64x2.lessThan](portable-simd.md#less-than) |
| `f64x2.le(a: v128, b: v128) -> b64x2`                         | [f64x2.lessThanOrEqual](portable-simd.md#less-than-or-equal) |
| `f64x2.gt(a: v128, b: v128) -> b64x2`                         | [f64x2.greaterThan](portable-simd.md#greater-than) |
| `f64x2.ge(a: v128, b: v128) -> b64x2`                         | [f64x2.greaterThanOrEqual](portable-simd.md#greater-than-or-equal) |
| `f64x2.abs(a: v128) -> v128`                                  | [f64x2.abs](portable-simd.md#absolute-value) |
| `f64x2.min(a: v128, b: v128) -> v128`                         | [f64x2.min](portable-simd.md#nan-propagating-minimum) |
| `f64x2.max(a: v128, b: v128) -> v128`                         | [f64x2.max](portable-simd.md#nan-propagating-maximum) |
| `f64x2.div(a: v128, b: v128, rmode: RoundingMode) -> v128`    | [f64x2.div](portable-simd.md#division) |
| `f64x2.sqrt(a: v128, rmode: RoundingMode) -> v128`            | [f64x2.sqrt](portable-simd.md#square-root) |
| `f64x2.reciprocalApproximation(a: v128) -> v128`              | [f64x2.reciprocalApproximation](portable-simd.md#reciprocal-approximation) |
| `f64x2.reciprocalSqrtApproximation(a: v128) -> v128`          | [f64x2.reciprocalSqrtApproximation](portable-simd.md#reciprocal-square-root-approximation) |
| `f64x2.convert_s/i64x2(a: v128, rmode: RoundingMode) -> v128` | [f64x2.fromSignedInt](portable-simd.md#integer-to-floating-point) |
| `f64x2.convert_u/i64x2(a: v128, rmode: RoundingMode) -> v128` | [f64x2.fromUnsignedInt](portable-simd.md#integer-to-floating-point) |

## `b8x16` operations
| WebAssembly                                                  | Portable SIMD |
|:-------------------------------------------------------------|:--------------|
| `b8x16.build(x: i32[16]) -> b8x16`                           | [b8x16.build](portable-simd.md#build-vector-from-individual-lanes) |
| `b8x16.splat(x: i32) -> b8x16`                               | [b8x16.splat](portable-simd.md#create-vector-with-identical-lanes) |
| `b8x16.extractLane(a: b8x16, i: LaneIdx16) -> i32`           | [b8x16.extractLane](portable-simd.md#extract-lane-as-a-scalar) |
| `b8x16.replaceLane(a: b8x16, i: LaneIdx16, x: i32) -> b8x16` | [b8x16.replaceLane](portable-simd.md#replace-lane-value) |
| `b8x16.and(a: b8x16, b: b8x16) -> b8x16`                     | [b8x16.and](portable-simd.md#logical-and) |
| `b8x16.or(a: b8x16, b: b8x16) -> b8x16`                      | [b8x16.or](portable-simd.md#logical-or) |
| `b8x16.xor(a: b8x16, b: b8x16) -> b8x16`                     | [b8x16.xor](portable-simd.md#logical-xor) |
| `b8x16.not(a: b8x16) -> b8x16`                               | [b8x16.not](portable-simd.md#logical-not) |
| `b8x16.anyTrue(a: b8x16) -> i32`                             | [b8x16.anyTrue](portable-simd.md#any-lane-true) |
| `b8x16.allTrue(a: b8x16) -> i32`                             | [b8x16.allTrue](portable-simd.md#all-lanes-true) |

## `b16x8` operations
| WebAssembly                                                 | Portable SIMD |
|:------------------------------------------------------------|:--------------|
| `b16x8.build(x: i32[8]) -> b16x8`                           | [b16x8.build](portable-simd.md#build-vector-from-individual-lanes) |
| `b16x8.splat(x: i32) -> b16x8`                              | [b16x8.splat](portable-simd.md#create-vector-with-identical-lanes) |
| `b16x8.extractLane(a: b16x8, i: LaneIdx8) -> i32`           | [b16x8.extractLane](portable-simd.md#extract-lane-as-a-scalar) |
| `b16x8.replaceLane(a: b16x8, i: LaneIdx8, x: i32) -> b16x8` | [b16x8.replaceLane](portable-simd.md#replace-lane-value) |
| `b16x8.and(a: b16x8, b: b16x8) -> b16x8`                    | [b16x8.and](portable-simd.md#logical-and) |
| `b16x8.or(a: b16x8, b: b16x8) -> b16x8`                     | [b16x8.or](portable-simd.md#logical-or) |
| `b16x8.xor(a: b16x8, b: b16x8) -> b16x8`                    | [b16x8.xor](portable-simd.md#logical-xor) |
| `b16x8.not(a: b16x8) -> b16x8`                              | [b16x8.not](portable-simd.md#logical-not) |
| `b16x8.anyTrue(a: b16x8) -> i32`                            | [b16x8.anyTrue](portable-simd.md#any-lane-true) |
| `b16x8.allTrue(a: b16x8) -> i32`                            | [b16x8.allTrue](portable-simd.md#all-lanes-true) |

## `b32x4` operations
| WebAssembly                                                 | Portable SIMD |
|:------------------------------------------------------------|:--------------|
| `b32x4.build(x: i32[4]) -> b32x4`                           | [b32x4.build](portable-simd.md#build-vector-from-individual-lanes) |
| `b32x4.splat(x: i32) -> b32x4`                              | [b32x4.splat](portable-simd.md#create-vector-with-identical-lanes) |
| `b32x4.extractLane(a: b32x4, i: LaneIdx4) -> i32`           | [b32x4.extractLane](portable-simd.md#extract-lane-as-a-scalar) |
| `b32x4.replaceLane(a: b32x4, i: LaneIdx4, x: i32) -> b32x4` | [b32x4.replaceLane](portable-simd.md#replace-lane-value) |
| `b32x4.and(a: b32x4, b: b32x4) -> b32x4`                    | [b32x4.and](portable-simd.md#logical-and) |
| `b32x4.or(a: b32x4, b: b32x4) -> b32x4`                     | [b32x4.or](portable-simd.md#logical-or) |
| `b32x4.xor(a: b32x4, b: b32x4) -> b32x4`                    | [b32x4.xor](portable-simd.md#logical-xor) |
| `b32x4.not(a: b32x4) -> b32x4`                              | [b32x4.not](portable-simd.md#logical-not) |
| `b32x4.anyTrue(a: b32x4) -> i32`                            | [b32x4.anyTrue](portable-simd.md#any-lane-true) |
| `b32x4.allTrue(a: b32x4) -> i32`                            | [b32x4.allTrue](portable-simd.md#all-lanes-true) |

## `b64x2` operations
| WebAssembly                                                 | Portable SIMD |
|:------------------------------------------------------------|:--------------|
| `b64x2.build(x: i32[2]) -> b64x2`                           | [b64x2.build](portable-simd.md#build-vector-from-individual-lanes) |
| `b64x2.splat(x: i32) -> b64x2`                              | [b64x2.splat](portable-simd.md#create-vector-with-identical-lanes) |
| `b64x2.extractLane(a: b64x2, i: LaneIdx2) -> i32`           | [b64x2.extractLane](portable-simd.md#extract-lane-as-a-scalar) |
| `b64x2.replaceLane(a: b64x2, i: LaneIdx2, x: i32) -> b64x2` | [b64x2.replaceLane](portable-simd.md#replace-lane-value) |
| `b64x2.and(a: b64x2, b: b64x2) -> b64x2`                    | [b64x2.and](portable-simd.md#logical-and) |
| `b64x2.or(a: b64x2, b: b64x2) -> b64x2`                     | [b64x2.or](portable-simd.md#logical-or) |
| `b64x2.xor(a: b64x2, b: b64x2) -> b64x2`                    | [b64x2.xor](portable-simd.md#logical-xor) |
| `b64x2.not(a: b64x2) -> b64x2`                              | [b64x2.not](portable-simd.md#logical-not) |
| `b64x2.anyTrue(a: b64x2) -> i32`                            | [b64x2.anyTrue](portable-simd.md#any-lane-true) |
| `b64x2.allTrue(a: b64x2) -> i32`                            | [b64x2.allTrue](portable-simd.md#all-lanes-true) |

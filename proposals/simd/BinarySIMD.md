# Binary encoding of SIMD

This document describes the binary encoding of the SIMD value type and
instructions.

## SIMD value type

The `v128` value type is encoded as 0x7b:

```
valtype ::= ...
          | 0x7B => v128
```

## SIMD instruction encodings

All SIMD instructions are encoded as a 0xfd prefix byte followed by a
SIMD-specific opcode in LEB128 format:

```
instr ::= ...
        | 0xFD simdop:varuint32 ...
```

Some SIMD instructions have additional immediate operands following `simdop`.
The `v8x16.shuffle` instruction has 16 bytes after `simdop`.

| Instruction                | `simdop` | Immediate operands |
| ---------------------------|---------:|--------------------|
| `v128.load`                |    `0x00`| m:memarg           |
| `v128.store`               |    `0x01`| m:memarg           |
| `v128.const`               |    `0x02`| i:ImmByte[16]      |
| `i8x16.splat`              |    `0x04`| -                  |
| `i8x16.extract_lane_s`     |    `0x05`| i:LaneIdx16        |
| `i8x16.extract_lane_u`     |    `0x06`| i:LaneIdx16        |
| `i8x16.replace_lane`       |    `0x07`| i:LaneIdx16        |
| `i16x8.splat`              |    `0x08`| -                  |
| `i16x8.extract_lane_s`     |    `0x09`| i:LaneIdx8         |
| `i16x8.extract_lane_u`     |    `0x0a`| i:LaneIdx8         |
| `i16x8.replace_lane`       |    `0x0b`| i:LaneIdx8         |
| `i32x4.splat`              |    `0x0c`| -                  |
| `i32x4.extract_lane`       |    `0x0d`| i:LaneIdx4         |
| `i32x4.replace_lane`       |    `0x0e`| i:LaneIdx4         |
| `i64x2.splat`              |    `0x0f`| -                  |
| `i64x2.extract_lane`       |    `0x10`| i:LaneIdx2         |
| `i64x2.replace_lane`       |    `0x11`| i:LaneIdx2         |
| `f32x4.splat`              |    `0x12`| -                  |
| `f32x4.extract_lane`       |    `0x13`| i:LaneIdx4         |
| `f32x4.replace_lane`       |    `0x14`| i:LaneIdx4         |
| `f64x2.splat`              |    `0x15`| -                  |
| `f64x2.extract_lane`       |    `0x16`| i:LaneIdx2         |
| `f64x2.replace_lane`       |    `0x17`| i:LaneIdx2         |
| `i8x16.eq`                 |    `0x18`| -                  |
| `i8x16.ne`                 |    `0x19`| -                  |
| `i8x16.lt_s`               |    `0x1a`| -                  |
| `i8x16.lt_u`               |    `0x1b`| -                  |
| `i8x16.gt_s`               |    `0x1c`| -                  |
| `i8x16.gt_u`               |    `0x1d`| -                  |
| `i8x16.le_s`               |    `0x1e`| -                  |
| `i8x16.le_u`               |    `0x1f`| -                  |
| `i8x16.ge_s`               |    `0x20`| -                  |
| `i8x16.ge_u`               |    `0x21`| -                  |
| `i16x8.eq`                 |    `0x22`| -                  |
| `i16x8.ne`                 |    `0x23`| -                  |
| `i16x8.lt_s`               |    `0x24`| -                  |
| `i16x8.lt_u`               |    `0x25`| -                  |
| `i16x8.gt_s`               |    `0x26`| -                  |
| `i16x8.gt_u`               |    `0x27`| -                  |
| `i16x8.le_s`               |    `0x28`| -                  |
| `i16x8.le_u`               |    `0x29`| -                  |
| `i16x8.ge_s`               |    `0x2a`| -                  |
| `i16x8.ge_u`               |    `0x2b`| -                  |
| `i32x4.eq`                 |    `0x2c`| -                  |
| `i32x4.ne`                 |    `0x2d`| -                  |
| `i32x4.lt_s`               |    `0x2e`| -                  |
| `i32x4.lt_u`               |    `0x2f`| -                  |
| `i32x4.gt_s`               |    `0x30`| -                  |
| `i32x4.gt_u`               |    `0x31`| -                  |
| `i32x4.le_s`               |    `0x32`| -                  |
| `i32x4.le_u`               |    `0x33`| -                  |
| `i32x4.ge_s`               |    `0x34`| -                  |
| `i32x4.ge_u`               |    `0x35`| -                  |
| `f32x4.eq`                 |    `0x40`| -                  |
| `f32x4.ne`                 |    `0x41`| -                  |
| `f32x4.lt`                 |    `0x42`| -                  |
| `f32x4.gt`                 |    `0x43`| -                  |
| `f32x4.le`                 |    `0x44`| -                  |
| `f32x4.ge`                 |    `0x45`| -                  |
| `f64x2.eq`                 |    `0x46`| -                  |
| `f64x2.ne`                 |    `0x47`| -                  |
| `f64x2.lt`                 |    `0x48`| -                  |
| `f64x2.gt`                 |    `0x49`| -                  |
| `f64x2.le`                 |    `0x4a`| -                  |
| `f64x2.ge`                 |    `0x4b`| -                  |
| `v128.not`                 |    `0x4c`| -                  |
| `v128.and`                 |    `0x4d`| -                  |
| `v128.or`                  |    `0x4e`| -                  |
| `v128.xor`                 |    `0x4f`| -                  |
| `v128.bitselect`           |    `0x50`| -                  |
| `i8x16.neg`                |    `0x51`| -                  |
| `i8x16.any_true`           |    `0x52`| -                  |
| `i8x16.all_true`           |    `0x53`| -                  |
| `i8x16.shl`                |    `0x54`| -                  |
| `i8x16.shr_s`              |    `0x55`| -                  |
| `i8x16.shr_u`              |    `0x56`| -                  |
| `i8x16.add`                |    `0x57`| -                  |
| `i8x16.add_saturate_s`     |    `0x58`| -                  |
| `i8x16.add_saturate_u`     |    `0x59`| -                  |
| `i8x16.sub`                |    `0x5a`| -                  |
| `i8x16.sub_saturate_s`     |    `0x5b`| -                  |
| `i8x16.sub_saturate_u`     |    `0x5c`| -                  |
| `i8x16.min_s`              |    `0x5e`| -                  |
| `i8x16.min_u`              |    `0x5f`| -                  |
| `i8x16.max_s`              |    `0x60`| -                  |
| `i8x16.max_u`              |    `0x61`| -                  |
| `i16x8.neg`                |    `0x62`| -                  |
| `i16x8.any_true`           |    `0x63`| -                  |
| `i16x8.all_true`           |    `0x64`| -                  |
| `i16x8.shl`                |    `0x65`| -                  |
| `i16x8.shr_s`              |    `0x66`| -                  |
| `i16x8.shr_u`              |    `0x67`| -                  |
| `i16x8.add`                |    `0x68`| -                  |
| `i16x8.add_saturate_s`     |    `0x69`| -                  |
| `i16x8.add_saturate_u`     |    `0x6a`| -                  |
| `i16x8.sub`                |    `0x6b`| -                  |
| `i16x8.sub_saturate_s`     |    `0x6c`| -                  |
| `i16x8.sub_saturate_u`     |    `0x6d`| -                  |
| `i16x8.mul`                |    `0x6e`| -                  |
| `i16x8.min_s`              |    `0x6f`| -                  |
| `i16x8.min_u`              |    `0x70`| -                  |
| `i16x8.max_s`              |    `0x71`| -                  |
| `i16x8.max_u`              |    `0x72`| -                  |
| `i32x4.neg`                |    `0x73`| -                  |
| `i32x4.any_true`           |    `0x74`| -                  |
| `i32x4.all_true`           |    `0x75`| -                  |
| `i32x4.shl`                |    `0x76`| -                  |
| `i32x4.shr_s`              |    `0x77`| -                  |
| `i32x4.shr_u`              |    `0x78`| -                  |
| `i32x4.add`                |    `0x79`| -                  |
| `i32x4.sub`                |    `0x7c`| -                  |
| `i32x4.mul`                |    `0x7f`| -                  |
| `i32x4.min_s`              |    `0x80`| -                  |
| `i32x4.min_u`              |    `0x81`| -                  |
| `i32x4.max_s`              |    `0x82`| -                  |
| `i32x4.max_u`              |    `0x83`| -                  |
| `i64x2.neg`                |    `0x84`| -                  |
| `i64x2.shl`                |    `0x87`| -                  |
| `i64x2.shr_s`              |    `0x88`| -                  |
| `i64x2.shr_u`              |    `0x89`| -                  |
| `i64x2.add`                |    `0x8a`| -                  |
| `i64x2.sub`                |    `0x8d`| -                  |
| `i64x2.mul`                |    `0x90`| -                  |
| `f32x4.abs`                |    `0x95`| -                  |
| `f32x4.neg`                |    `0x96`| -                  |
| `f32x4.sqrt`               |    `0x97`| -                  |
| `f32x4.add`                |    `0x9a`| -                  |
| `f32x4.sub`                |    `0x9b`| -                  |
| `f32x4.mul`                |    `0x9c`| -                  |
| `f32x4.div`                |    `0x9d`| -                  |
| `f32x4.min`                |    `0x9e`| -                  |
| `f32x4.max`                |    `0x9f`| -                  |
| `f64x2.abs`                |    `0xa0`| -                  |
| `f64x2.neg`                |    `0xa1`| -                  |
| `f64x2.sqrt`               |    `0xa2`| -                  |
| `f64x2.add`                |    `0xa5`| -                  |
| `f64x2.sub`                |    `0xa6`| -                  |
| `f64x2.mul`                |    `0xa7`| -                  |
| `f64x2.div`                |    `0xa8`| -                  |
| `f64x2.min`                |    `0xa9`| -                  |
| `f64x2.max`                |    `0xaa`| -                  |
| `i32x4.trunc_sat_f32x4_s`  |    `0xab`| -                  |
| `i32x4.trunc_sat_f32x4_u`  |    `0xac`| -                  |
| `i64x2.trunc_sat_f64x2_s`  |    `0xad`| -                  |
| `i64x2.trunc_sat_f64x2_u`  |    `0xae`| -                  |
| `f32x4.convert_i32x4_s`    |    `0xaf`| -                  |
| `f32x4.convert_i32x4_u`    |    `0xb0`| -                  |
| `f64x2.convert_i64x2_s`    |    `0xb1`| -                  |
| `f64x2.convert_i64x2_u`    |    `0xb2`| -                  |
| `v8x16.swizzle`            |    `0xc0`| -                  |
| `v8x16.shuffle`            |    `0xc1`| s:LaneIdx32[16]    |
| `v8x16.load_splat`         |    `0xc2`| -                  |
| `v16x8.load_splat`         |    `0xc3`| -                  |
| `v32x4.load_splat`         |    `0xc4`| -                  |
| `v64x2.load_splat`         |    `0xc5`| -                  |
| `i8x16.narrow_i16x8_s`     |    `0xc6`| -                  |
| `i8x16.narrow_i16x8_u`     |    `0xc7`| -                  |
| `i16x8.narrow_i32x4_s`     |    `0xc8`| -                  |
| `i16x8.narrow_i32x4_u`     |    `0xc9`| -                  |
| `i16x8.widen_low_i8x16_s`  |    `0xca`| -                  |
| `i16x8.widen_high_i8x16_s` |    `0xcb`| -                  |
| `i16x8.widen_low_i8x16_u`  |    `0xcc`| -                  |
| `i16x8.widen_high_i8x16_u` |    `0xcd`| -                  |
| `i32x4.widen_low_i16x8_s`  |    `0xce`| -                  |
| `i32x4.widen_high_i16x8_s` |    `0xcf`| -                  |
| `i32x4.widen_low_i16x8_u`  |    `0xd0`| -                  |
| `i32x4.widen_high_i16x8_u` |    `0xd1`| -                  |
| `i16x8.load8x8_s`          |    `0xd2`| m:memarg           |
| `i16x8.load8x8_u`          |    `0xd3`| m:memarg           |
| `i32x4.load16x4_s`         |    `0xd4`| m:memarg           |
| `i32x4.load16x4_u`         |    `0xd5`| m:memarg           |
| `i64x2.load32x2_s`         |    `0xd6`| m:memarg           |
| `i64x2.load32x2_u`         |    `0xd7`| m:memarg           |
| `v128.andnot`              |    `0xd8`| -                  |

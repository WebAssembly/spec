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
These immediate operands are encoded as individual bytes.
For example, the `i8x16.shuffle` instruction has 16 bytes after `simdop`.

In the description below, `ImmLaneIdx{I}` indicates the maximum value of the byte.
For example, `ImmLaneIdx16` is a byte with values in the range 0-15 (inclusive).


| Instruction                     | `simdop` | Immediate operands       |
| --------------------------------|---------:|--------------------------|
| `v128.load`                     |    `0x00`| m:memarg                 |
| `v128.load8x8_s`                |    `0x01`| m:memarg                 |
| `v128.load8x8_u`                |    `0x02`| m:memarg                 |
| `v128.load16x4_s`               |    `0x03`| m:memarg                 |
| `v128.load16x4_u`               |    `0x04`| m:memarg                 |
| `v128.load32x2_s`               |    `0x05`| m:memarg                 |
| `v128.load32x2_u`               |    `0x06`| m:memarg                 |
| `v128.load8_splat`              |    `0x07`| m:memarg                 |
| `v128.load16_splat`             |    `0x08`| m:memarg                 |
| `v128.load32_splat`             |    `0x09`| m:memarg                 |
| `v128.load64_splat`             |    `0x0a`| m:memarg                 |
| `v128.store`                    |    `0x0b`| m:memarg                 |
| `v128.const`                    |    `0x0c`| i:ImmByte[16]            |
| `i8x16.shuffle`                 |    `0x0d`| s:ImmLaneIdx32[16]       |
| `i8x16.swizzle`                 |    `0x0e`| -                        |
| `i8x16.splat`                   |    `0x0f`| -                        |
| `i16x8.splat`                   |    `0x10`| -                        |
| `i32x4.splat`                   |    `0x11`| -                        |
| `i64x2.splat`                   |    `0x12`| -                        |
| `f32x4.splat`                   |    `0x13`| -                        |
| `f64x2.splat`                   |    `0x14`| -                        |
| `i8x16.extract_lane_s`          |    `0x15`| i:ImmLaneIdx16           |
| `i8x16.extract_lane_u`          |    `0x16`| i:ImmLaneIdx16           |
| `i8x16.replace_lane`            |    `0x17`| i:ImmLaneIdx16           |
| `i16x8.extract_lane_s`          |    `0x18`| i:ImmLaneIdx8            |
| `i16x8.extract_lane_u`          |    `0x19`| i:ImmLaneIdx8            |
| `i16x8.replace_lane`            |    `0x1a`| i:ImmLaneIdx8            |
| `i32x4.extract_lane`            |    `0x1b`| i:ImmLaneIdx4            |
| `i32x4.replace_lane`            |    `0x1c`| i:ImmLaneIdx4            |
| `i64x2.extract_lane`            |    `0x1d`| i:ImmLaneIdx2            |
| `i64x2.replace_lane`            |    `0x1e`| i:ImmLaneIdx2            |
| `f32x4.extract_lane`            |    `0x1f`| i:ImmLaneIdx4            |
| `f32x4.replace_lane`            |    `0x20`| i:ImmLaneIdx4            |
| `f64x2.extract_lane`            |    `0x21`| i:ImmLaneIdx2            |
| `f64x2.replace_lane`            |    `0x22`| i:ImmLaneIdx2            |
| `i8x16.eq`                      |    `0x23`| -                        |
| `i8x16.ne`                      |    `0x24`| -                        |
| `i8x16.lt_s`                    |    `0x25`| -                        |
| `i8x16.lt_u`                    |    `0x26`| -                        |
| `i8x16.gt_s`                    |    `0x27`| -                        |
| `i8x16.gt_u`                    |    `0x28`| -                        |
| `i8x16.le_s`                    |    `0x29`| -                        |
| `i8x16.le_u`                    |    `0x2a`| -                        |
| `i8x16.ge_s`                    |    `0x2b`| -                        |
| `i8x16.ge_u`                    |    `0x2c`| -                        |
| `i16x8.eq`                      |    `0x2d`| -                        |
| `i16x8.ne`                      |    `0x2e`| -                        |
| `i16x8.lt_s`                    |    `0x2f`| -                        |
| `i16x8.lt_u`                    |    `0x30`| -                        |
| `i16x8.gt_s`                    |    `0x31`| -                        |
| `i16x8.gt_u`                    |    `0x32`| -                        |
| `i16x8.le_s`                    |    `0x33`| -                        |
| `i16x8.le_u`                    |    `0x34`| -                        |
| `i16x8.ge_s`                    |    `0x35`| -                        |
| `i16x8.ge_u`                    |    `0x36`| -                        |
| `i32x4.eq`                      |    `0x37`| -                        |
| `i32x4.ne`                      |    `0x38`| -                        |
| `i32x4.lt_s`                    |    `0x39`| -                        |
| `i32x4.lt_u`                    |    `0x3a`| -                        |
| `i32x4.gt_s`                    |    `0x3b`| -                        |
| `i32x4.gt_u`                    |    `0x3c`| -                        |
| `i32x4.le_s`                    |    `0x3d`| -                        |
| `i32x4.le_u`                    |    `0x3e`| -                        |
| `i32x4.ge_s`                    |    `0x3f`| -                        |
| `i32x4.ge_u`                    |    `0x40`| -                        |
| `f32x4.eq`                      |    `0x41`| -                        |
| `f32x4.ne`                      |    `0x42`| -                        |
| `f32x4.lt`                      |    `0x43`| -                        |
| `f32x4.gt`                      |    `0x44`| -                        |
| `f32x4.le`                      |    `0x45`| -                        |
| `f32x4.ge`                      |    `0x46`| -                        |
| `f64x2.eq`                      |    `0x47`| -                        |
| `f64x2.ne`                      |    `0x48`| -                        |
| `f64x2.lt`                      |    `0x49`| -                        |
| `f64x2.gt`                      |    `0x4a`| -                        |
| `f64x2.le`                      |    `0x4b`| -                        |
| `f64x2.ge`                      |    `0x4c`| -                        |
| `v128.not`                      |    `0x4d`| -                        |
| `v128.and`                      |    `0x4e`| -                        |
| `v128.andnot`                   |    `0x4f`| -                        |
| `v128.or`                       |    `0x50`| -                        |
| `v128.xor`                      |    `0x51`| -                        |
| `v128.bitselect`                |    `0x52`| -                        |
| `i8x16.abs`                     |    `0x60`| -                        |
| `i8x16.neg`                     |    `0x61`| -                        |
| `i8x16.all_true`                |    `0x63`| -                        |
| `i8x16.bitmask`                 |    `0x64`| -                        |
| `i8x16.narrow_i16x8_s`          |    `0x65`| -                        |
| `i8x16.narrow_i16x8_u`          |    `0x66`| -                        |
| `i8x16.shl`                     |    `0x6b`| -                        |
| `i8x16.shr_s`                   |    `0x6c`| -                        |
| `i8x16.shr_u`                   |    `0x6d`| -                        |
| `i8x16.add`                     |    `0x6e`| -                        |
| `i8x16.add_sat_s`               |    `0x6f`| -                        |
| `i8x16.add_sat_u`               |    `0x70`| -                        |
| `i8x16.sub`                     |    `0x71`| -                        |
| `i8x16.sub_sat_s`               |    `0x72`| -                        |
| `i8x16.sub_sat_u`               |    `0x73`| -                        |
| `i8x16.min_s`                   |    `0x76`| -                        |
| `i8x16.min_u`                   |    `0x77`| -                        |
| `i8x16.max_s`                   |    `0x78`| -                        |
| `i8x16.max_u`                   |    `0x79`| -                        |
| `i8x16.avgr_u`                  |    `0x7b`| -                        |
| `i16x8.abs`                     |    `0x80`| -                        |
| `i16x8.neg`                     |    `0x81`| -                        |
| `i16x8.all_true`                |    `0x83`| -                        |
| `i16x8.bitmask`                 |    `0x84`| -                        |
| `i16x8.narrow_i32x4_s`          |    `0x85`| -                        |
| `i16x8.narrow_i32x4_u`          |    `0x86`| -                        |
| `i16x8.extend_low_i8x16_s`      |    `0x87`| -                        |
| `i16x8.extend_high_i8x16_s`     |    `0x88`| -                        |
| `i16x8.extend_low_i8x16_u`      |    `0x89`| -                        |
| `i16x8.extend_high_i8x16_u`     |    `0x8a`| -                        |
| `i16x8.shl`                     |    `0x8b`| -                        |
| `i16x8.shr_s`                   |    `0x8c`| -                        |
| `i16x8.shr_u`                   |    `0x8d`| -                        |
| `i16x8.add`                     |    `0x8e`| -                        |
| `i16x8.add_sat_s`               |    `0x8f`| -                        |
| `i16x8.add_sat_u`               |    `0x90`| -                        |
| `i16x8.sub`                     |    `0x91`| -                        |
| `i16x8.sub_sat_s`               |    `0x92`| -                        |
| `i16x8.sub_sat_u`               |    `0x93`| -                        |
| `i16x8.mul`                     |    `0x95`| -                        |
| `i16x8.min_s`                   |    `0x96`| -                        |
| `i16x8.min_u`                   |    `0x97`| -                        |
| `i16x8.max_s`                   |    `0x98`| -                        |
| `i16x8.max_u`                   |    `0x99`| -                        |
| `i16x8.avgr_u`                  |    `0x9b`| -                        |
| `i32x4.abs`                     |    `0xa0`| -                        |
| `i32x4.neg`                     |    `0xa1`| -                        |
| `i32x4.all_true`                |    `0xa3`| -                        |
| `i32x4.bitmask`                 |    `0xa4`| -                        |
| `i32x4.extend_low_i16x8_s`      |    `0xa7`| -                        |
| `i32x4.extend_high_i16x8_s`     |    `0xa8`| -                        |
| `i32x4.extend_low_i16x8_u`      |    `0xa9`| -                        |
| `i32x4.extend_high_i16x8_u`     |    `0xaa`| -                        |
| `i32x4.shl`                     |    `0xab`| -                        |
| `i32x4.shr_s`                   |    `0xac`| -                        |
| `i32x4.shr_u`                   |    `0xad`| -                        |
| `i32x4.add`                     |    `0xae`| -                        |
| `i32x4.sub`                     |    `0xb1`| -                        |
| `i32x4.mul`                     |    `0xb5`| -                        |
| `i32x4.min_s`                   |    `0xb6`| -                        |
| `i32x4.min_u`                   |    `0xb7`| -                        |
| `i32x4.max_s`                   |    `0xb8`| -                        |
| `i32x4.max_u`                   |    `0xb9`| -                        |
| `i32x4.dot_i16x8_s`             |    `0xba`| -                        |
| `i64x2.abs`                     |    `0xc0`| -                        |
| `i64x2.neg`                     |    `0xc1`| -                        |
| `i64x2.bitmask`                 |    `0xc4`| -                        |
| `i64x2.extend_low_i32x4_s`      |    `0xc7`| -                        |
| `i64x2.extend_high_i32x4_s`     |    `0xc8`| -                        |
| `i64x2.extend_low_i32x4_u`      |    `0xc9`| -                        |
| `i64x2.extend_high_i32x4_u`     |    `0xca`| -                        |
| `i64x2.shl`                     |    `0xcb`| -                        |
| `i64x2.shr_s`                   |    `0xcc`| -                        |
| `i64x2.shr_u`                   |    `0xcd`| -                        |
| `i64x2.add`                     |    `0xce`| -                        |
| `i64x2.sub`                     |    `0xd1`| -                        |
| `i64x2.mul`                     |    `0xd5`| -                        |
| `f32x4.ceil`                    |    `0x67`| -                        |
| `f32x4.floor`                   |    `0x68`| -                        |
| `f32x4.trunc`                   |    `0x69`| -                        |
| `f32x4.nearest`                 |    `0x6a`| -                        |
| `f64x2.ceil`                    |    `0x74`| -                        |
| `f64x2.floor`                   |    `0x75`| -                        |
| `f64x2.trunc`                   |    `0x7a`| -                        |
| `f64x2.nearest`                 |    `0x94`| -                        |
| `f32x4.abs`                     |    `0xe0`| -                        |
| `f32x4.neg`                     |    `0xe1`| -                        |
| `f32x4.sqrt`                    |    `0xe3`| -                        |
| `f32x4.add`                     |    `0xe4`| -                        |
| `f32x4.sub`                     |    `0xe5`| -                        |
| `f32x4.mul`                     |    `0xe6`| -                        |
| `f32x4.div`                     |    `0xe7`| -                        |
| `f32x4.min`                     |    `0xe8`| -                        |
| `f32x4.max`                     |    `0xe9`| -                        |
| `f32x4.pmin`                    |    `0xea`| -                        |
| `f32x4.pmax`                    |    `0xeb`| -                        |
| `f64x2.abs`                     |    `0xec`| -                        |
| `f64x2.neg`                     |    `0xed`| -                        |
| `f64x2.sqrt`                    |    `0xef`| -                        |
| `f64x2.add`                     |    `0xf0`| -                        |
| `f64x2.sub`                     |    `0xf1`| -                        |
| `f64x2.mul`                     |    `0xf2`| -                        |
| `f64x2.div`                     |    `0xf3`| -                        |
| `f64x2.min`                     |    `0xf4`| -                        |
| `f64x2.max`                     |    `0xf5`| -                        |
| `f64x2.pmin`                    |    `0xf6`| -                        |
| `f64x2.pmax`                    |    `0xf7`| -                        |
| `i32x4.trunc_sat_f32x4_s`       |    `0xf8`| -                        |
| `i32x4.trunc_sat_f32x4_u`       |    `0xf9`| -                        |
| `f32x4.convert_i32x4_s`         |    `0xfa`| -                        |
| `f32x4.convert_i32x4_u`         |    `0xfb`| -                        |
| `v128.load32_zero`              |    `0x5c`| m:memarg                 |
| `v128.load64_zero`              |    `0x5d`| m:memarg                 |
| `i16x8.extmul_low_i8x16_s`      |    `0x9c`| -                        |
| `i16x8.extmul_high_i8x16_s`     |    `0x9d`| -                        |
| `i16x8.extmul_low_i8x16_u`      |    `0x9e`| -                        |
| `i16x8.extmul_high_i8x16_u`     |    `0x9f`| -                        |
| `i32x4.extmul_low_i16x8_s`      |    `0xbc`| -                        |
| `i32x4.extmul_high_i16x8_s`     |    `0xbd`| -                        |
| `i32x4.extmul_low_i16x8_u`      |    `0xbe`| -                        |
| `i32x4.extmul_high_i16x8_u`     |    `0xbf`| -                        |
| `i64x2.extmul_low_i32x4_s`      |    `0xdc`| -                        |
| `i64x2.extmul_high_i32x4_s`     |    `0xdd`| -                        |
| `i64x2.extmul_low_i32x4_u`      |    `0xde`| -                        |
| `i64x2.extmul_high_i32x4_u`     |    `0xdf`| -                        |
| `i16x8.q15mulr_sat_s`           |    `0x82`| -                        |
| `v128.any_true`                 |    `0x53`| -                        |
| `v128.load8_lane`               |    `0x54`| m:memarg, i:ImmLaneIdx16 |
| `v128.load16_lane`              |    `0x55`| m:memarg, i:ImmLaneIdx8  |
| `v128.load32_lane`              |    `0x56`| m:memarg, i:ImmLaneIdx4  |
| `v128.load64_lane`              |    `0x57`| m:memarg, i:ImmLaneIdx2  |
| `v128.store8_lane`              |    `0x58`| m:memarg, i:ImmLaneIdx16 |
| `v128.store16_lane`             |    `0x59`| m:memarg, i:ImmLaneIdx8  |
| `v128.store32_lane`             |    `0x5a`| m:memarg, i:ImmLaneIdx4  |
| `v128.store64_lane`             |    `0x5b`| m:memarg, i:ImmLaneIdx2  |
| `i64x2.eq`                      |    `0xd6`| -                        |
| `i64x2.ne`                      |    `0xd7`| -                        |
| `i64x2.lt_s`                    |    `0xd8`| -                        |
| `i64x2.gt_s`                    |    `0xd9`| -                        |
| `i64x2.le_s`                    |    `0xda`| -                        |
| `i64x2.ge_s`                    |    `0xdb`| -                        |
| `i64x2.all_true`                |    `0xc3`| -                        |
| `f64x2.convert_low_i32x4_s`     |    `0xfe`| -                        |
| `f64x2.convert_low_i32x4_u`     |    `0xff`| -                        |
| `i32x4.trunc_sat_f64x2_s_zero`  |    `0xfc`| -                        |
| `i32x4.trunc_sat_f64x2_u_zero`  |    `0xfd`| -                        |
| `f32x4.demote_f64x2_zero`       |    `0x5e`| -                        |
| `f64x2.promote_low_f32x4`       |    `0x5f`| -                        |
| `i8x16.popcnt`                  |    `0x62`| -                        |
| `i16x8.extadd_pairwise_i8x16_s` |    `0x7c`| -                        |
| `i16x8.extadd_pairwise_i8x16_u` |    `0x7d`| -                        |
| `i32x4.extadd_pairwise_i16x8_s` |    `0x7e`| -                        |
| `i32x4.extadd_pairwise_i16x8_u` |    `0x7f`| -                        |

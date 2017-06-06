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

| Instruction               | `simdop` | Immediate operands |
| --------------------------|---------:|--------------------|
| `v128.const`              |        0 | -                  |
| `v128.load`               |        1 | m:memarg           |
| `v128.store`              |        2 | m:memarg           |
| `i8x16.splat`             |        3 | -                  |
| `i16x8.splat`             |        4 | -                  |
| `i32x4.splat`             |        5 | -                  |
| `i64x2.splat`             |        6 | -                  |
| `f32x4.splat`             |        7 | -                  |
| `f64x2.splat`             |        8 | -                  |
| `i8x16.extract_lane_s`    |        9 | i:LaneIdx16        |
| `i8x16.extract_lane_u`    |       10 | i:LaneIdx16        |
| `i16x8.extract_lane_s`    |       11 | i:LaneIdx8         |
| `i16x8.extract_lane_u`    |       12 | i:LaneIdx8         |
| `i32x4.extract_lane`      |       13 | i:LaneIdx4         |
| `i64x2.extract_lane`      |       14 | i:LaneIdx2         |
| `f32x4.extract_lane`      |       15 | i:LaneIdx4         |
| `f64x2.extract_lane`      |       16 | i:LaneIdx2         |
| `i8x16.replace_lane`      |       17 | i:LaneIdx16        |
| `i16x8.replace_lane`      |       18 | i:LaneIdx8         |
| `i32x4.replace_lane`      |       19 | i:LaneIdx4         |
| `i64x2.replace_lane`      |       20 | i:LaneIdx2         |
| `f32x4.replace_lane`      |       21 | i:LaneIdx4         |
| `f64x2.replace_lane`      |       22 | i:LaneIdx2         |
| `v8x16.shuffle`           |       23 | s:LaneIdx32[16]    |
| `i8x16.add`               |       24 | -                  |
| `i16x8.add`               |       25 | -                  |
| `i32x4.add`               |       26 | -                  |
| `i64x2.add`               |       27 | -                  |
| `i8x16.sub`               |       28 | -                  |
| `i16x8.sub`               |       29 | -                  |
| `i32x4.sub`               |       30 | -                  |
| `i64x2.sub`               |       31 | -                  |
| `i8x16.mul`               |       32 | -                  |
| `i16x8.mul`               |       33 | -                  |
| `i32x4.mul`               |       34 | -                  |
| `i8x16.neg`               |       35 | -                  |
| `i16x8.neg`               |       36 | -                  |
| `i32x4.neg`               |       37 | -                  |
| `i64x2.neg`               |       38 | -                  |
| `i8x16.add_saturate_s`    |       39 | -                  |
| `i8x16.add_saturate_u`    |       40 | -                  |
| `i16x8.add_saturate_s`    |       41 | -                  |
| `i16x8.add_saturate_u`    |       42 | -                  |
| `i8x16.sub_saturate_s`    |       43 | -                  |
| `i8x16.sub_saturate_u`    |       44 | -                  |
| `i16x8.sub_saturate_s`    |       45 | -                  |
| `i16x8.sub_saturate_u`    |       46 | -                  |
| `i8x16.shl`               |       47 | -                  |
| `i16x8.shl`               |       48 | -                  |
| `i32x4.shl`               |       49 | -                  |
| `i64x2.shl`               |       50 | -                  |
| `i8x16.shr_s`             |       51 | -                  |
| `i8x16.shr_u`             |       52 | -                  |
| `i16x8.shr_s`             |       53 | -                  |
| `i16x8.shr_u`             |       54 | -                  |
| `i32x4.shr_s`             |       55 | -                  |
| `i32x4.shr_u`             |       56 | -                  |
| `i64x2.shr_s`             |       57 | -                  |
| `i64x2.shr_u`             |       58 | -                  |
| `v128.and`                |       59 | -                  |
| `v128.or`                 |       60 | -                  |
| `v128.xor`                |       61 | -                  |
| `v128.not`                |       62 | -                  |
| `v128.bitselect`          |       63 | -                  |
| `i8x16.any_true`          |       64 | -                  |
| `i16x8.any_true`          |       65 | -                  |
| `i32x4.any_true`          |       66 | -                  |
| `i64x2.any_true`          |       67 | -                  |
| `i8x16.all_true`          |       68 | -                  |
| `i16x8.all_true`          |       69 | -                  |
| `i32x4.all_true`          |       70 | -                  |
| `i64x2.all_true`          |       71 | -                  |
| `i8x16.eq`                |       72 | -                  |
| `i16x8.eq`                |       73 | -                  |
| `i32x4.eq`                |       74 | -                  |
| `f32x4.eq`                |       75 | -                  |
| `f64x2.eq`                |       76 | -                  |
| `i8x16.ne`                |       77 | -                  |
| `i16x8.ne`                |       78 | -                  |
| `i32x4.ne`                |       79 | -                  |
| `f32x4.ne`                |       80 | -                  |
| `f64x2.ne`                |       81 | -                  |
| `i8x16.lt_s`              |       82 | -                  |
| `i8x16.lt_u`              |       83 | -                  |
| `i16x8.lt_s`              |       84 | -                  |
| `i16x8.lt_u`              |       85 | -                  |
| `i32x4.lt_s`              |       86 | -                  |
| `i32x4.lt_u`              |       87 | -                  |
| `f32x4.lt`                |       88 | -                  |
| `f64x2.lt`                |       89 | -                  |
| `i8x16.le_s`              |       90 | -                  |
| `i8x16.le_u`              |       91 | -                  |
| `i16x8.le_s`              |       92 | -                  |
| `i16x8.le_u`              |       93 | -                  |
| `i32x4.le_s`              |       94 | -                  |
| `i32x4.le_u`              |       95 | -                  |
| `f32x4.le`                |       96 | -                  |
| `f64x2.le`                |       97 | -                  |
| `i8x16.gt_s`              |       98 | -                  |
| `i8x16.gt_u`              |       99 | -                  |
| `i16x8.gt_s`              |      100 | -                  |
| `i16x8.gt_u`              |      101 | -                  |
| `i32x4.gt_s`              |      102 | -                  |
| `i32x4.gt_u`              |      103 | -                  |
| `f32x4.gt`                |      104 | -                  |
| `f64x2.gt`                |      105 | -                  |
| `i8x16.ge_s`              |      106 | -                  |
| `i8x16.ge_u`              |      107 | -                  |
| `i16x8.ge_s`              |      108 | -                  |
| `i16x8.ge_u`              |      109 | -                  |
| `i32x4.ge_s`              |      110 | -                  |
| `i32x4.ge_u`              |      111 | -                  |
| `f32x4.ge`                |      112 | -                  |
| `f64x2.ge`                |      113 | -                  |
| `f32x4.neg`               |      114 | -                  |
| `f64x2.neg`               |      115 | -                  |
| `f32x4.abs`               |      116 | -                  |
| `f64x2.abs`               |      117 | -                  |
| `f32x4.min`               |      118 | -                  |
| `f64x2.min`               |      119 | -                  |
| `f32x4.max`               |      120 | -                  |
| `f64x2.max`               |      121 | -                  |
| `f32x4.add`               |      122 | -                  |
| `f64x2.add`               |      123 | -                  |
| `f32x4.sub`               |      124 | -                  |
| `f64x2.sub`               |      125 | -                  |
| `f32x4.div`               |      126 | -                  |
| `f64x2.div`               |      127 | -                  |
| `f32x4.mul`               |      128 | -                  |
| `f64x2.mul`               |      129 | -                  |
| `f32x4.sqrt`              |      130 | -                  |
| `f64x2.sqrt`              |      131 | -                  |
| `f32x4.convert_s/i32x4`   |      132 | -                  |
| `f32x4.convert_u/i32x4`   |      133 | -                  |
| `f64x2.convert_s/i64x2`   |      134 | -                  |
| `f64x2.convert_u/i64x2`   |      135 | -                  |
| `i32x4.trunc_s/f32x4:sat` |      136 | -                  |
| `i32x4.trunc_u/f32x4:sat` |      137 | -                  |
| `i64x2.trunc_s/f64x2:sat` |      138 | -                  |
| `i64x2.trunc_u/f64x2:sat` |      139 | -                  |

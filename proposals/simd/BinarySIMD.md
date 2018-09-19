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
| `v128.const`              |        0 | i:ImmByte[16]      |
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
| `i8x16.neg`               |       36 | -                  |
| `i16x8.neg`               |       37 | -                  |
| `i32x4.neg`               |       38 | -                  |
| `i64x2.neg`               |       39 | -                  |
| `i8x16.add_saturate_s`    |       40 | -                  |
| `i8x16.add_saturate_u`    |       41 | -                  |
| `i16x8.add_saturate_s`    |       42 | -                  |
| `i16x8.add_saturate_u`    |       43 | -                  |
| `i8x16.sub_saturate_s`    |       44 | -                  |
| `i8x16.sub_saturate_u`    |       45 | -                  |
| `i16x8.sub_saturate_s`    |       46 | -                  |
| `i16x8.sub_saturate_u`    |       47 | -                  |
| `i8x16.shl`               |       48 | -                  |
| `i16x8.shl`               |       49 | -                  |
| `i32x4.shl`               |       50 | -                  |
| `i64x2.shl`               |       51 | -                  |
| `i8x16.shr_s`             |       52 | -                  |
| `i8x16.shr_u`             |       53 | -                  |
| `i16x8.shr_s`             |       54 | -                  |
| `i16x8.shr_u`             |       55 | -                  |
| `i32x4.shr_s`             |       56 | -                  |
| `i32x4.shr_u`             |       57 | -                  |
| `i64x2.shr_s`             |       58 | -                  |
| `i64x2.shr_u`             |       59 | -                  |
| `v128.and`                |       60 | -                  |
| `v128.or`                 |       61 | -                  |
| `v128.xor`                |       62 | -                  |
| `v128.not`                |       63 | -                  |
| `v128.bitselect`          |       64 | -                  |
| `i8x16.any_true`          |       65 | -                  |
| `i16x8.any_true`          |       66 | -                  |
| `i32x4.any_true`          |       67 | -                  |
| `i64x2.any_true`          |       68 | -                  |
| `i8x16.all_true`          |       69 | -                  |
| `i16x8.all_true`          |       70 | -                  |
| `i32x4.all_true`          |       71 | -                  |
| `i64x2.all_true`          |       72 | -                  |
| `i8x16.eq`                |       73 | -                  |
| `i16x8.eq`                |       74 | -                  |
| `i32x4.eq`                |       75 | -                  |
| `f32x4.eq`                |       77 | -                  |
| `f64x2.eq`                |       78 | -                  |
| `i8x16.ne`                |       79 | -                  |
| `i16x8.ne`                |       80 | -                  |
| `i32x4.ne`                |       81 | -                  |
| `f32x4.ne`                |       83 | -                  |
| `f64x2.ne`                |       84 | -                  |
| `i8x16.lt_s`              |       85 | -                  |
| `i8x16.lt_u`              |       86 | -                  |
| `i16x8.lt_s`              |       87 | -                  |
| `i16x8.lt_u`              |       88 | -                  |
| `i32x4.lt_s`              |       89 | -                  |
| `i32x4.lt_u`              |       90 | -                  |
| `f32x4.lt`                |       93 | -                  |
| `f64x2.lt`                |       94 | -                  |
| `i8x16.le_s`              |       95 | -                  |
| `i8x16.le_u`              |       96 | -                  |
| `i16x8.le_s`              |       97 | -                  |
| `i16x8.le_u`              |       98 | -                  |
| `i32x4.le_s`              |       99 | -                  |
| `i32x4.le_u`              |      100 | -                  |
| `f32x4.le`                |      103 | -                  |
| `f64x2.le`                |      104 | -                  |
| `i8x16.gt_s`              |      105 | -                  |
| `i8x16.gt_u`              |      106 | -                  |
| `i16x8.gt_s`              |      107 | -                  |
| `i16x8.gt_u`              |      108 | -                  |
| `i32x4.gt_s`              |      109 | -                  |
| `i32x4.gt_u`              |      110 | -                  |
| `f32x4.gt`                |      113 | -                  |
| `f64x2.gt`                |      114 | -                  |
| `i8x16.ge_s`              |      115 | -                  |
| `i8x16.ge_u`              |      116 | -                  |
| `i16x8.ge_s`              |      117 | -                  |
| `i16x8.ge_u`              |      118 | -                  |
| `i32x4.ge_s`              |      119 | -                  |
| `i32x4.ge_u`              |      120 | -                  |
| `f32x4.ge`                |      123 | -                  |
| `f64x2.ge`                |      124 | -                  |
| `f32x4.neg`               |      125 | -                  |
| `f64x2.neg`               |      126 | -                  |
| `f32x4.abs`               |      127 | -                  |
| `f64x2.abs`               |      128 | -                  |
| `f32x4.min`               |      129 | -                  |
| `f64x2.min`               |      130 | -                  |
| `f32x4.max`               |      131 | -                  |
| `f64x2.max`               |      132 | -                  |
| `f32x4.add`               |      133 | -                  |
| `f64x2.add`               |      134 | -                  |
| `f32x4.sub`               |      135 | -                  |
| `f64x2.sub`               |      136 | -                  |
| `f32x4.div`               |      137 | -                  |
| `f64x2.div`               |      138 | -                  |
| `f32x4.mul`               |      139 | -                  |
| `f64x2.mul`               |      140 | -                  |
| `f32x4.sqrt`              |      141 | -                  |
| `f64x2.sqrt`              |      142 | -                  |
| `f32x4.convert_s/i32x4`   |      143 | -                  |
| `f32x4.convert_u/i32x4`   |      144 | -                  |
| `f64x2.convert_s/i64x2`   |      145 | -                  |
| `f64x2.convert_u/i64x2`   |      146 | -                  |
| `i32x4.trunc_s/f32x4:sat` |      147 | -                  |
| `i32x4.trunc_u/f32x4:sat` |      148 | -                  |
| `i64x2.trunc_s/f64x2:sat` |      149 | -                  |
| `i64x2.trunc_u/f64x2:sat` |      150 | -                  |

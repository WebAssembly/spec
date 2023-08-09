# Non-trapping Float-to-int Conversions

## Introduction

### Motivation

The primary motivations are:

 - LLVM’s float-to-int conversion has an undefined result, rather than undefined behavior, and it seems LLVM does speculate it under certain conditions.
 - For the SIMD proposal, it’s more SIMD-hardware-like if no SIMD operations trap. This proposal would establish a convention for saturating operations which SIMD could share, to avoid introducing trapping.

This proposal is not motivated by performance data.

It's plausible that LLVM could be changed, to have something like an "nsw" flag for the "fptosi" instruction, especially with some of the recent proposals to modify the poison concept in LLVM. However, no one is currently working on this.

### Background

This issue has been discussed in several areas including here:

https://github.com/WebAssembly/design/issues/986

While performance concerns initially motivated the discussion, the performance
effects were due to a particular implementation detail which has since been
fixed.

Since then, no real-world performance problems related to this issue have
been reported.

This topic was discussed at the CG-05 meeting:

https://github.com/WebAssembly/meetings/pull/3

and

https://github.com/WebAssembly/meetings/blob/main/2017/CG-05.md#non-trapping-float-to-int

which made decisions about which semantics to choose, and which encoding strategy.

These decisions were captured in a design repo PR:

https://github.com/WebAssembly/design/pull/1089

At the CG-07-06 meeting it was decided that a full spec repo fork should be
created to follow the new process for new features:

https://github.com/WebAssembly/meetings/blob/main/2017/CG-07-06.md#float-to-int-conversion

This led to the creation of the present repo:

https://github.com/WebAssembly/nontrapping-float-to-int-conversions

### Design

This proposal introduces 8 new instructions:

 - `i32.trunc_sat_f32_s`
 - `i32.trunc_sat_f32_u`
 - `i32.trunc_sat_f64_s`
 - `i32.trunc_sat_f64_u`
 - `i64.trunc_sat_f32_s`
 - `i64.trunc_sat_f32_u`
 - `i64.trunc_sat_f64_s`
 - `i64.trunc_sat_f64_u`

The semantics are the same as the corresponding non-`_sat` instructions, except:
 - Instead of trapping on positive or negative overflow, they return the maximum
   or minimum integer value, respectively, and do not trap. (This behavior is
   also referred to as "saturating".)
 - Instead of trapping on NaN, they return 0 and do not trap.

### Encoding

This proposal introduces a new prefix byte:

| Prefix | Name    | Description |
| ------ | ------- | ----------- |
| `0xfc` | misc    | Miscellaneous operations :bowling: |

which is intended to be used as a prefix for other future miscellaneous operations
as well.

The encodings for the new instructions use this new prefix and are as follows:

| Name | Opcode | Immediate | Description |
| ---- | ---- | ---- | ---- |
| `i32.trunc_sat_f32_s` | `0xfc` `0x00` | | :bowling: saturating form of `i32.trunc_f32_s` |
| `i32.trunc_sat_f32_u` | `0xfc` `0x01` | | :bowling: saturating form of `i32.trunc_f32_u` |
| `i32.trunc_sat_f64_s` | `0xfc` `0x02` | | :bowling: saturating form of `i32.trunc_f64_s` |
| `i32.trunc_sat_f64_u` | `0xfc` `0x03` | | :bowling: saturating form of `i32.trunc_f64_u` |
| `i64.trunc_sat_f32_s` | `0xfc` `0x04` | | :bowling: saturating form of `i64.trunc_f32_s` |
| `i64.trunc_sat_f32_u` | `0xfc` `0x05` | | :bowling: saturating form of `i64.trunc_f32_u` |
| `i64.trunc_sat_f64_s` | `0xfc` `0x06` | | :bowling: saturating form of `i64.trunc_f64_s` |
| `i64.trunc_sat_f64_u` | `0xfc` `0x07` | | :bowling: saturating form of `i64.trunc_f64_u` |

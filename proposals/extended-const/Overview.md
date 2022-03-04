# Extended Constant Expressions

## Introduction

This page describes a proposal for extending constant expressions in
WebAssembly.  The current [spec][] for constant expressions is fairly limited,
and was always intended to be extended.

This proposal adds new instructions to the list of *constant instructions* that
can be used in *constant expressions*.

An overview of this proposal was presented at the 01-19-20 CG meeting along with
a brief [presentation][].  This issue was originally discusses in
https://github.com/WebAssembly/design/issues/1392.

### Motivation

The primay/initial motivation comes from LLVM where we could benefit from using
integer addition in both global initializers and in segment initializers.  Both
of these use cases stem from dynamic linking, which is currently
[experimental][abi].

1. With dynamic linking the data segments are relative to a global import called
   `__memory_base` which is supplied by the dynamic linker.   We currently have
   to have [combine][] all our memory segments into one because there is no way
   to do `__memory_base + CONST_OFFSET` in a segment initilizer.

2. The linker currently has to generate [dynamic relocations][reloc] for certain
   WebAssembly globals because its currently not possible to initialize a global
   with a value of `__memory_base + CONST_OFFSET`.  Specifically, this happens
   when the static linker decides that a given symbol is local to the currently
   module.  In this case, rather than importing a global it creates a new
   global which points insides the a data segment (i.e. it's value is an offset
   from `__memory_base` or `__table_base` which are themselves imported).

## New Instructions

This proposal adds the following new instructions to the list of valid constant
instruction:

 - `i32.add`
 - `i32.sub`
 - `i32.mul`
 - `i64.add`
 - `i64.sub`
 - `i64.mul`

## Implementation Status

- spec interpreter: Done
- wabt: [Done](https://github.com/WebAssembly/debugging/issues/17#issuecomment-1041130743)
- Firefox: [Done](https://github.com/WebAssembly/debugging/issues/17#issuecomment-1041130743)
- v8: [Done](https://chromium.googlesource.com/v8/v8/+/bf1565d7081cabc510e39c42eaea67ea6e79484e)

[spec]: https://webassembly.github.io/spec/core/valid/instructions.html#constant-expressions
[presentation]: https://docs.google.com/presentation/d/1sM9mJJ6iM7D8324ipYxot91hSKnWCtB8jX4Kh3bde5E
[abi]: https://github.com/WebAssembly/tool-conventions/blob/master/DynamicLinking.md
[combine]: https://github.com/llvm/llvm-project/blob/5f9be2c3e37c0428ba56876dd84af04b8d9d8915/lld/wasm/Writer.cpp#L868
[reloc]: https://github.com/llvm/llvm-project/blob/5f9be2c3e37c0428ba56876dd84af04b8d9d8915/lld/wasm/SyntheticSections.cpp#L311

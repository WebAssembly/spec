# Branch hinting

## Introduction

### Motivation

The motivation for this proposal is to improve the performance of the compiled wasm
code, by informing the engine that a particular branch instruction is very likely to take
a specific path.

This allows the engine to make better decisions for code layout (improving instruction cache hits)
and register allocation.


### Background

This proposal has first been presented here:

https://github.com/WebAssembly/design/issues/1363

This topic was preliminarily discussed at the CG-09-29 meeting:

https://github.com/WebAssembly/meetings/blob/master/main/2020/CG-09-29.md

The consensus seems to be to proceed with the idea, but to present some benchmarks
to prove the need for the proposal (see [here](benchmarks)).

This repo contains the current work toward a spec, and the benchmarks.

### Design

This proposal introduces 1 new instruction:

 - `branch_hint`

The semantic of the instruction is a `nop`, but the engine can use this information
when compiling the branch instruction following `branch_hint`.

### Encoding

The encoding for the new instruction is the following:

| Name | Opcode | Immediate | Description |
| ---- | ---- | ---- | ---- |
| `branch_hint` | `0xXX` | index: `varint32` | The following branching instruction is very likely to take branch `index` |

### Open questions

- Should it be a validation error to have a `branch_hint` not followed by a branch instruction? Or with an immediate with a value out of range?
- What kind of branches are supported? (what about `br_table`? should it support multiple preceding `branch_hint` instructions?)
- Would it be better to implement this functionality through custom sections, instead of a new instruction?

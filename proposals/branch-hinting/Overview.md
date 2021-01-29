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
to prove the need for the proposal (see [here](/benchmarks)).

This repo contains the current work toward a spec, and the benchmarks.

### Design

This proposal introduces a new custom section named "branchHints".

The section, if present, must appear before the code section (this can help a
streaming compiler to make use of the hints).

The content of the section consists of a sequence of subsections.

Each subsection corresponds to one function and consists of:

- the u32 index of the function
- the u32 number of branch hints contained in the subsection
- the list of branch hints for the function

Each element of the branch hints list consists of:
- the u32 byte offset of the hinted istruction from the beginning of the function
- A byte indicating the direction of the hint:

| value | meaning      |
|-------|--------------|
| 0     | likely false |
| 1     | likely true  |


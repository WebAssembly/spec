# Branch hinting

## Introduction

### Motivation

The motivation for this proposal is to improve the performance of the compiled wasm
code, by informing the engine that a particular branch instruction is very likely to take
a specific path.

This allows the engine to make better decisions for code layout (improving instruction cache hits)
and register allocation.

See [Motivation](/proposals/branch-hinting/Motivation.md) for more information.


### Background

This proposal has first been presented here:

https://github.com/WebAssembly/design/issues/1363

This topic was preliminarily discussed at the CG-09-29 meeting:

https://github.com/WebAssembly/meetings/blob/master/main/2020/CG-09-29.md

The consensus seemed to be to proceed with the idea, but to present some benchmarks
to prove the need for the proposal.

A [preliminary benchmark](/benchmarks) showed that the proposal is worth investigating

The proposal was accepted for phase 1 at the CG-11-10 meeting:

https://github.com/WebAssembly/meetings/blob/master/main/2020/CG-11-10.md

Discussion about how to implement the proposal happened in this issue:

https://github.com/WebAssembly/branch-hinting/issues/1

And some more discussion and feedback on the custom section format was done in the CG-01-05:

https://github.com/WebAssembly/meetings/blob/master/main/2021/CG-01-05.md

After that, a tentative spec was written and a poll for phase 2 scheduled for the CG-02-16:

https://github.com/WebAssembly/meetings/blob/master/main/2021/CG-02-16.md


### Design

The *branch hints section* is a custom section whose name string is "branchHints".
The branch hints section should appear only once in a module, and only before the code section.

The purpose of this section is to aid the compilation of conditional branch instructions, by providing a hint that a branch is very likely (or unlikely) to be taken.

An implementation is not required to follow the hints, and this section can be entirely ignored.

The section contains a vector of *function hints* each representing the branch hints for a single function.

Each *function hints* structure consists of

* the index of the function the hints are referring to,
* a vector of *branch hints* for the function.

Each *branch hint* structure consists of

* the u32 byte offset of the hinted instruction from the first instruction of the function,
* a byte indicating the meaning of the hint:

| value | meaning           |
|-------|-------------------|
| 0     | likely not taken  |
| 1     | likely  taken     |


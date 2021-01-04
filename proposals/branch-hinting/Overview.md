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

Each element N of the list of hints implicitly refers to the Nth `br` or `br_if` 
instruction in the function. It is ok to list less hints than branches instruction
in the function;

Each element consists of a byte indicating what the hint for that particular branch
is:

| value | meaning      |
|-------|--------------|
| 0     | no hint      |
| 1     | likely false |
| 2     | likely true  |


### Open issues

Using the number of branch instructions as an implicit index has the advantage
of saving space and simplifying validation (compared to, say, an explicit byte index).

But it has the disadvantage that if in the future we want to expand the set of instructions
that are hintable, old programs may find themselves with an invalid or misleading
hinting section.

A middle ground could be using the number of total instructions.
While not as space-saving, and requiring more validation than the current approach, it
is still much better than using a byte offset, while being more future proof.

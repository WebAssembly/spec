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

After that, a tentative spec was written and there was further discussion in CG-02-16:

https://github.com/WebAssembly/meetings/blob/master/main/2021/CG-02-16.md

And in CG-03-02:

https://github.com/WebAssembly/meetings/blob/main/main/2021/CG-03-02.md

Finally after working on the feedback received, a poll for phase 2 was made, and passed, in CG-03-16:

https://github.com/WebAssembly/meetings/blob/main/main/2021/CG-03-16.md

The feature landed in V8 92 under an experimental flag, and the CheerpX virtual machine started using it,
with measurable performance improvements. The results were shown in CG-06-08, plus the start of
a discussion about testing requirements for phase 3:

https://github.com/WebAssembly/meetings/blob/main/main/2021/CG-06-08.md

After the Instrument and Tracing Proposal passed to phase 2 in CG-07-20, the CG felt the need to
have a framework for standardizing proposals that use custom section as a way to hint the code
without altering the semantics. Ongoing discussion is in a design issue:

https://github.com/WebAssembly/design/issues/1424

The result of that discussion prompted the design of Code Annotations, presented in CG-08-17:

https://github.com/WebAssembly/meetings/blob/main/main/2021/CG-08-17.md

and in CG-09-28:

https://github.com/WebAssembly/meetings/blob/main/main/2021/CG-09-28.md

Branch hinting adpoted the Code Annotation format and an update about the new format
and the current status of the proposal, as well as a poll for phase 3 (which passed)
 was held on CG-11-09:

https://github.com/WebAssembly/meetings/blob/main/main/2021/CG-11-09.md



### Design

The *branch hint section* is a **custom section** whose name string is `metadata.code.branch_hint`.
The branch hints section should appear only once in a module, and only before the code section.

The purpose of this section is to aid the compilation of conditional branch instructions, by providing a hint that a branch is very likely (or unlikely) to be taken.

The section contains a vector of *function branch hints* each representing the branch hints for a single function.

Each *function branch hints* structure consists of

* the function index of the function the hints are referring to,
* a vector of *branch hint* for the function.

Elements of the vector of *function branch hints* must appear in increasing function index order,
and a function index can appear at most once.

Each *branch hint* structure consists of

* the |U32| byte offset of the hinted instruction from the beginning of the function body,
* A |U32| with value `1`,
* a |U32| indicating the meaning of the hint:

| value | meaning           |
|-------|-------------------|
| 0     | likely not taken  |
| 1     | likely  taken     |

Elements of the vector of *branch hint* must appear in increasing byte offset order,
and a byte offset can appear at most once. A |BRIF| or |IF| instruction must be present
in the code section at the specified offset.

#### Annotations

*Branch Hint annotations* are the textual analogue to the branch hint section and provide a textual representation for it.
Consequently, their id is :math:`@metadata.code.branch_hint`.

Branch hint annotations are allowed only on |BRIF| and |IF| instructions,
and at most one branch hint annotation may be given per instruction.

Branch hint annotations have the following format:

```
(@metadata.code.branch_hint "\00" | "\01")
```

See the [the spec](/document/core/appendix/custom.rst) for the formal notation.

# WebAssembly Garbage Collection Subgroup Charter

The Garbage Collection Subgroup is a sub-organization of the
[WebAssembly Community Group](https://www.w3.org/community/webassembly/)
of the W3C.
As such, it is intended that its charter align with that of the CG. In particular, 
the sections of the [CG charter](https://webassembly.github.io/cg-charter/) relating to
[Community and Business Group Process](https://webassembly.github.io/cg-charter/#process),
[Contribution Mechanics](https://webassembly.github.io/cg-charter/#contrib),
[Transparency](https://webassembly.github.io/cg-charter/#transparency),
and
[Decision Process](https://webassembly.github.io/cg-charter/#decision)
also apply to the Subgroup.

## Goals

The mission of this subgroup is to provide a forum for collaboration on the standardisation of garbage collection support for WebAssembly.

## Scope

The Subgroup will consider topics related to garbage collection for Wasm, including:

- an instruction set for defining and manipulating managed data types,
- type system rules for validating such instructions,
- APIs for accessing managed data types outside Wasm or a Wasm engine,
- tool and language assists for user-space GC in linear memory,
- code generation for compilers targetting Wasm with GC extensions.

## Deliverables

### Specifications

The Subgroup may produce several kinds of specification-related work output:

- new specifications in standards bodies or working groups
  (e.g. W3C WebAssembly WG or Ecma TC39),

- new specifications outside of standards bodies
  (e.g. similar to the LLVM object file format documentation in Wasm tool conventions).

### Non-normative reports

The Subgroup may produce non-normative material such as requirements
documents, recommendations, and case studies.

### Software

The Subgroup may produce software related to garbage collection in Wasm
(either as standalone libraries, tooling, or integration of interface-related functionality in existing CG software).
These may include

- extensions to the Wasm reference interpreter,
- extensions to the Wasm test suite,
- compilers and tools for producing code that uses Wasm GC extensions,
- tools for implementing Wasm with GC,
- tools for debugging programs using Wasm GC extensions.

## Amendments to this Charter and Chair Selection

This charter may be amended, and Subgroup Chairs may be selected by vote of the full WebAssembly Community Group.

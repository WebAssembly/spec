# Multiple Memories for Wasm

## Summary

This proposal adds the ability to use multiple memories within a single Wasm module.
In the current version of Wasm, an application can already create multiple memories, but only by splitting things up into multiple modules.
A single module or function cannot refer to multiple memories at the same time.
Consequently, it is not possible to e.g. efficiently transfer data from one memory to another, since that necessarily involves an individual function call into a different module per value.

## Motivation

There are a number of use case scenarios for using multiple memories in a single application:

* *Security.* A module may want to separate public memory that is shared with the outside to exchange data, from private memory that is kept encapsulated inside the module.

* *Persistence.* An application may want to keep some of its memory state persistent between runs, e.g., by storing it in a file. But it may not want to do that for all its memory, so separating lifetimes via multiple memories is a natural setup.

* *Linking.* There are a number of tools out there that can merge multiple Wasm modules into one, as a form of static linking. This is possible in almost all cases, except when the set of modules defines more than one memory. Allowing multiple memories in a single module closes this unfortunate gap.

* *Scaling.* As long as Wasm memories are limited to 32 bit address space, there is no way to scale out of 4 GB memory efficiently. Multiple memories at least provide an efficient workaround until 64 bit memories become available (which may still take a while).

* *Polyfilling.* Some proposals, e.g., [garbage collection](https://github.com/WebAssembly/gc) or [interface types](https://github.com/WebAssembly/interface-types) could be emulated in current Wasm if they had the ability to add an auxiliary memory that is distinct from the module's own address space.


## Overview

The original Wasm design already anticipated the ability to define and reference multiple memories. In particular, there already is the notion of an index space for memories (which currently can contain at most one entry), and most memory constructs already leave space in the binary encoding for it.
This proposal fills in the holes accordingly.

This generalisation is fully symmetric to the extension to multiple tables in the [reference types](https://github.com/WebAssembly/reference-types) proposal.

The design of this extension is almost entirely canonical. Concretely:

* Allow multiple memory imports and definitions in a single module.

* Add a memory index to all memory-related instructions.
  - Loads and stores have the memop field, in which we can allocate a bit indicating a memory index immediate.
  - All other memory instruction already have a memory index immediate (which currently has to be 0).

* Data segments and exports already have a memory index as well.

* Extend the validation and execution semantics in the obvious manner.


### Instructions

#### Loads and Stores

TODO

#### Other Memory Instructions

TODO


### Modules

#### Data Segments

TODO

#### Exports

TODO

#### Modules

TODO


## Implementation

Engines already have to deal with multiple memories, but any given code so far can only address one.
Hence, in current engines, reserving one register for the base address is a common technique.
Multiple memories will typically require an extra indirection (which some engines already have).

Engines could conservatively continue to optimise access to memory index 0 via a dedicated register.
PResumably, we could also eventually add a future custom section with optimisation hints, which could e.g. mark the index of the "main" memory.

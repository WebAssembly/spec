[![CI for specs](https://github.com/WebAssembly/gc/actions/workflows/ci-spec.yml/badge.svg)](https://github.com/WebAssembly/gc/actions/workflows/ci-spec.yml)
[![CI for interpreter & tests](https://github.com/WebAssembly/gc/actions/workflows/ci-interpreter.yml/badge.svg)](https://github.com/WebAssembly/gc/actions/workflows/ci-interpreter.yml)

# GC Proposal for WebAssembly

This repository is a clone of [github.com/WebAssembly/spec/](https://github.com/WebAssembly/spec/).
It is meant for discussion, prototype specification and implementation of a proposal to add garbage collection (GC) support to WebAssembly.

* See the [overview](proposals/gc/Overview.md) for a summary and rationale of the proposal.

* See the [MVP](proposals/gc/MVP.md) for a draft specification of the concrete language extensions that are proposed for the first stage of GC support in Wasm.

* See the [Post-MVP](proposals/gc/Post-MVP.md) for possible future extensions in later stages.

<!--
* See the [modified spec](https://webassembly.github.io/gc/core) for details.
-->

This repository is based on the [function references proposal](proposals/function-references/Overview.md) as a baseline and includes all respective changes.

Original `README` from upstream repository follows...

# spec

This repository holds a prototypical reference implementation for WebAssembly,
which is currently serving as the official specification. Eventually, we expect
to produce a specification either written in human-readable prose or in a formal
specification language.

It also holds the WebAssembly testsuite, which tests numerous aspects of
conformance to the spec.

View the work-in-progress spec at [webassembly.github.io/spec](https://webassembly.github.io/spec/).

At this time, the contents of this repository are under development and known
to be "incomplet and inkorrect".

Participation is welcome. Discussions about new features, significant semantic
changes, or any specification change likely to generate substantial discussion
should take place in
[the WebAssembly design repository](https://github.com/WebAssembly/design)
first, so that this spec repository can remain focused. And please follow the
[guidelines for contributing](Contributing.md).

# citing

For citing WebAssembly in LaTeX, use [this bibtex file](wasm-specs.bib).

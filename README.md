![Spectec Status](https://github.com/Wasm-DSL/spectec/actions/workflows/ci-spectec.yml/badge.svg)
![Interpreter Status](https://github.com/Wasm-DSL/spectec/actions/workflows/ci-interpreter.yml/badge.svg)
![Spec doc Status](https://github.com/Wasm-DSL/spectec/actions/workflows/ci-spec.yml/badge.svg)

[![CI for specs](https://github.com/Wasm-DSL/spectec/actions/workflows/ci-spec.yml/badge.svg)](https://github.com/Wasm-DSL/spectec/actions/workflows/ci-spec.yml)
[![CI for interpreter & tests](https://github.com/Wasm-DSL/spectec/actions/workflows/ci-interpreter.yml/badge.svg)](https://github.com/Wasm-DSL/spectec/actions/workflows/ci-interpreter.yml)


# WebAssembly SpecTec

This repository is a clone of the `wasm-3.0` branch of [github.com/WebAssembly/spec/](https://github.com/WebAssembly/spec/).
It contains the prototype implementation of [SpecTec](spectec/README.md) and a version of the core spec document modified to be built with SpecTec.

This repository is based on the [function references proposal](proposals/function-references/Overview.md) as a baseline and includes all respective changes.

Original `README` from upstream repository follows...


# spec

This repository holds the sources for the WebAssembly draft specification
(to seed a future
[WebAssembly Working Group](https://lists.w3.org/Archives/Public/public-new-work/2017Jun/0005.html)),
a reference implementation, and the official testsuite.

A formatted version of the spec is available here:
[webassembly.github.io/spec](https://webassembly.github.io/spec/),

Participation is welcome. Discussions about new features, significant semantic
changes, or any specification change likely to generate substantial discussion
should take place in
[the WebAssembly design repository](https://github.com/WebAssembly/design)
first, so that this spec repository can remain focused. And please follow the
[guidelines for contributing](Contributing.md).

# citing

For citing WebAssembly in LaTeX, use [this bibtex file](wasm-specs.bib).

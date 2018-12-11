# SIMD proposal for WebAssembly

This repository holds a proposal for adding 128-bit SIMD support to
WebAssembly. It is a copy of the
[WebAssembly/spec](https://github.com/WebAssembly/spec) repository with the
addition of a [proposals/simd](proposals/simd) directory.
The proposal describes how 128-bit packed SIMD types and operations can be
added to WebAssembly. It is based on [previous work on SIMD.js in the Ecma TC39
ECMAScript committee](https://github.com/tc39/ecmascript_simd) and the
[portable SIMD specification](https://github.com/stoklund/portable-simd) that
resulted.

The [proposed specification](proposals/simd/SIMD.md) has the details.

[Design issue](https://github.com/WebAssembly/proposals/issues/1)


Original README from upstream repo follows...
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



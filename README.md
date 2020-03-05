[![Build Status](https://travis-ci.org/WebAssembly/spec.svg?branch=master)](https://travis-ci.org/WebAssembly/spec)

# Exception handling

This repository
holds a
[proposal](https://github.com/WebAssembly/exception-handling/blob/master/proposals/Exceptions.md) for
adding exception handling to WebAssembly.

The exception handling proposal depends on the [reference-types](https://github.com/WebAssembly/reference-types) proposal
and on the [multi-value](https://github.com/WebAssembly/multi-value) proposal.

The repository is a clone
of [WebAssembly/spec](https://github.com/WebAssembly/spec), first rebased on the spec of its dependency [reference-types](https://github.com/WebAssembly/reference-types), and then merged with the other dependency [multi-value](https://github.com/WebAssembly/multi-value). 

The remainder of the document has contents of the two README files of the dependencies: [reference-types/README.md](https://github.com/WebAssembly/reference-types/blob/master/README.md) and [multi-value/README.md](https://github.com/WebAssembly/multi-value/blob/master/README.md).

# Reference Types Proposal for WebAssembly

[![Build Status](https://travis-ci.org/WebAssembly/reference-types.svg?branch=master)](https://travis-ci.org/WebAssembly/reference-types)

This repository is a clone of [github.com/WebAssembly/spec/](https://github.com/WebAssembly/spec/).
It is meant for discussion, prototype specification and implementation of a proposal to add support for basic reference types to WebAssembly.

* See the [overview](https://github.com/WebAssembly/reference-types/blob/master/proposals/reference-types/Overview.md) for a summary of the proposal.

* See the [modified spec](https://webassembly.github.io/reference-types/) for details.

# Multi-value Proposal for WebAssembly

[![Build Status](https://travis-ci.org/WebAssembly/multi-value.svg?branch=master)](https://travis-ci.org/WebAssembly/multi-value)

This repository is a clone of [github.com/WebAssembly/spec/](https://github.com/WebAssembly/spec/).
It is meant for discussion, prototype specification and implementation of a proposal to add support for returning multiple values to WebAssembly.

* See the [overview](https://github.com/WebAssembly/multi-value/blob/master/proposals/multi-value/Overview.md) for a summary of the proposal.

* See the [modified spec](https://webassembly.github.io/multi-value/) for details.

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

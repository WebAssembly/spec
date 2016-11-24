Introduction
============

WebAssembly (abbreviated Wasm [#wasm]_) is a *safe, portable, low-level code format*
designed for efficient execution and compact representation.
Its main goal is to enable high performance applications on the Web, but it does not bake in any Web-specific assumptions or features, so can be employed in other environments as well.

WebAssembly is an open standard developed by a `W3C Community Group <https://www.w3.org/community/webassembly/>`_ that includes representatives of all major browser vendors.

This document describes version |release| of the standard.
It is intended that it will be superseded by new incremental releases with additional features in the future.


Design Goals
------------

.. index:: design goals, portability

The design goals of WebAssembly are the following:

* Fast, safe, and portable *semantics*:

  * **Fast**: executes with near native code performance, taking advantage of capabilities common to all contemporary hardware.

  * **Safe**: code is validated and executes in a memory-safe, sandboxed environment preventing data corruption or security breaches.

  * **Deterministic**: fully and precisely defines valid programs and their behavior in a way that is easy to reason about informally and formally.

  * **Hardware-independent**: can run on all modern hardware and CPUs, desktop or mobile devices and embedded systems alike.

  * **Language-independent**: does not privilege nor penalize any particular programming or object model.

  * **Platform-independent**: can be embedded in browsers, run as a stand-alone VM, or integrated in other environments.

  * **Open**: programs can interoperate with their environment in a simple and universal manner.

* Efficient, safe, and portable *representation*:

  * **Compact**: a binary format that is fast to transmit by being smaller than typical text or native code formats.

  * **Modular**: programs can be split up in smaller parts that can be transmitted, cached, and consumed separately.

  * **Efficient**: can be decoded, validated, and compiled to native code in a fast single pass, equally with either just-in-time (JIT) or ahead-of-time (AOT) compilation.

  * **Streamable**: allows decoding, validation, and compilation to begin as soon as possible, before all data has been seen.

  * **Parallelizable**: allows decoding, validation, and compilation to be split into many independent parallel tasks.

  * **Portable**: makes no architectural assumptions that are not broadly supported across modern hardware.

  * **Versatile**: can be targetted equally by both state-of-the-art optimizing compilers and single-pass baseline compilers

WebAssembly code is also intended to be easy to display and debug, especially in environments like web browsers, but such features are beyond the scope of this specification.


.. [#wasm] A contraction of "WebAssembly", not an acronym, hence not using all-caps.

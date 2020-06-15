Introduction
------------

WebAssembly (abbreviated Wasm [#wasm]_) is a *safe, portable, low-level code format*
designed for efficient execution and compact representation.
Its main goal is to enable high performance applications on the Web, but it does not make any Web-specific assumptions or provide Web-specific features, so can be employed in other environments as well.

WebAssembly is an open standard developed by a `W3C Community Group <https://www.w3.org/community/webassembly/>`_ that includes representatives of all major browser vendors.

This document describes version |release| of the :ref:`core <Scope>` WebAssembly standard.
It is intended that it will be superseded by new incremental releases with additional features in the future.


Design Goals
~~~~~~~~~~~~

.. index:: design goals, portability

The design goals of WebAssembly are the following:

* Fast, safe, and portable *semantics*:

  * **Fast**: executes with near native code performance, taking advantage of capabilities common to all contemporary hardware.

  * **Safe**: code is validated and executes in a memory-safe [#memorysafe]_, sandboxed environment preventing data corruption or security breaches.

  * **Well-defined**: fully and precisely defines valid programs and their behavior in a way that is easy to reason about informally and formally.

  * **Hardware-independent**: can be compiled on all modern architectures, desktop or mobile devices and embedded systems alike.

  * **Language-independent**: does not privilege any particular language, programming model, or object model.

  * **Platform-independent**: can be embedded in browsers, run as a stand-alone VM, or integrated in other environments.

  * **Open**: programs can interoperate with their environment in a simple and universal manner.

* Efficient and portable *representation*:

  * **Compact**: a binary format that is fast to transmit by being smaller than typical text or native code formats.

  * **Modular**: programs can be split up in smaller parts that can be transmitted, cached, and consumed separately.

  * **Efficient**: can be decoded, validated, and compiled in a fast single pass, equally with either just-in-time (JIT) or ahead-of-time (AOT) compilation.

  * **Streamable**: allows decoding, validation, and compilation to begin as soon as possible, before all data has been seen.

  * **Parallelizable**: allows decoding, validation, and compilation to be split into many independent parallel tasks.

  * **Portable**: makes no architectural assumptions that are not broadly supported across modern hardware.

WebAssembly code is also intended to be easy to inspect and debug, especially in environments like web browsers, but such features are beyond the scope of this specification.


.. [#wasm] A contraction of "WebAssembly", not an acronym, hence not using all-caps.

.. [#memorysafe] No program can break WebAssembly's memory model. Of course, it cannot guarantee that an unsafe language compiling to WebAssembly does not corrupt its own memory layout, e.g. inside WebAssembly's linear memory.


Scope
~~~~~

At its core, WebAssembly is a *virtual instruction set architecture (virtual ISA)*.
As such, it has many use cases and can be embedded in many different environments.
To encompass their variety and enable maximum reuse, the WebAssembly specification is split and layered into several documents.

This document is concerned with the core ISA layer of WebAssembly.
It defines the instruction set, binary encoding, validation, and execution semantics.
It does not, however, define how WebAssembly programs can interact with a specific environment they execute in, nor how they are invoked from such an environment.

Instead, this specification is complemented by additional documents defining interfaces to specific embedding environments such as the Web.
These will each define a WebAssembly *application programming interface (API)* suitable for a given environment.

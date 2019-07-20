Introduction
------------

WebAssembly (abbreviated Wasm [#wasm]_) is a *safe, portable, low-level code format*
designed for efficient execution and compact representation.
Its main goal is to enable high performance applications on the Web, but it does not make any Web-specific assumptions or provide Web-specific features, so it can be employed in other environments as well.

WebAssembly is an open standard developed by a `W3C Community Group <https://www.w3.org/community/webassembly/>`_.

This document describes version |release| of the :ref:`core <scope>` WebAssembly standard.
It is intended that it will be superseded by new incremental releases with additional features in the future.


.. _goals:

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

  * **Compact**: has a binary format that is fast to transmit by being smaller than typical text or native code formats.

  * **Modular**: programs can be split up in smaller parts that can be transmitted, cached, and consumed separately.

  * **Efficient**: can be decoded, validated, and compiled in a fast single pass, equally with either just-in-time (JIT) or ahead-of-time (AOT) compilation.

  * **Streamable**: allows decoding, validation, and compilation to begin as soon as possible, before all data has been seen.

  * **Parallelizable**: allows decoding, validation, and compilation to be split into many independent parallel tasks.

  * **Portable**: makes no architectural assumptions that are not broadly supported across modern hardware.

WebAssembly code is also intended to be easy to inspect and debug, especially in environments like web browsers, but such features are beyond the scope of this specification.


.. [#wasm] A contraction of "WebAssembly", not an acronym, hence not using all-caps.

.. [#memorysafe] No program can break WebAssembly's memory model. Of course, it cannot guarantee that an unsafe language compiling to WebAssembly does not corrupt its own memory layout, e.g. inside WebAssembly's linear memory.


.. _scope:

Scope
~~~~~

At its core, WebAssembly is a *virtual instruction set architecture (virtual ISA)*.
As such, it has many use cases and can be embedded in many different environments.
To encompass their variety and enable maximum reuse, the WebAssembly specification is split and layered into several documents.

This document is concerned with the core ISA layer of WebAssembly.
It defines the instruction set, binary encoding, validation, and execution semantics, as well as a textual representation.
It does not, however, define how WebAssembly programs can interact with a specific environment they execute in, nor how they are invoked from such an environment.

Instead, this specification is complemented by additional documents defining interfaces to specific embedding environments such as the Web.
These will each define a WebAssembly *application programming interface (API)* suitable for a given environment.


.. index:: ! security, host, embedder,  module, function, import
.. _security:

Security Considerations
~~~~~~~~~~~~~~~~~~~~~~~

WebAssembly provides no ambient access to the computing environment in which code is executed.
Any interaction with the environment, such as I/O, access to resources, or operating system calls, can only be performed by invoking :ref:`functions <function>` provided by the :ref:`embedder <embedder>` and imported into a WebAssembly :ref:`module <module>`.
An embedder can establish security policies suitable for a respective environment by controlling or limiting which functional capabilities it makes available for import.
Such considerations are an embedder’s responsibility and the subject of :ref:`API definitions <scope>` for a specific environment.

Because WebAssembly is designed to be translated into machine code running directly on the host's hardware, it is potentially vulnerable to side channel attacks on the hardware level.
In environments where this is a concern, an embedder may have to put suitable mitigations into place to isolate WebAssembly computations.


.. index:: IEEE 754, floating point, Unicode, name, text format, UTF-8, character
.. _dependencies:

Dependencies
~~~~~~~~~~~~

WebAssembly depends on two existing standards:

* |IEEE754|_, for the representation of :ref:`floating-point data <syntax-float>` and the semantics of respective :ref:`numeric operations <float-ops>`.

* |Unicode|_, for the representation of import/export :ref:`names <syntax-name>` and the :ref:`text format <text>`.

However, to make this specification self-contained, relevant aspects of the aforementioned standards are defined and formalized as part of this specification,
such as the :ref:`binary representation <aux-fbits>` and :ref:`rounding <aux-ieee>` of floating-point values, and the :ref:`value range <syntax-char>` and :ref:`UTF-8 encoding <binary-utf8>` of Unicode characters.

.. note::
   The aforementioned standards are the authoritative source of all respective definitions.
   Formalizations given in this specification are intended to match these definitions.
   Any discrepancy in the syntax or semantics described is to be considered an error.

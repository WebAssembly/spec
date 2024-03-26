.. _intro:

Introduction
============

This document defines a generic mechanism for attaching arbitrary metadata to WebAssembly instructions.
Additionally, it defines specific metadata formats using this mechanism.

Such metadata do not contribute to, or otherwise affect, the WebAssembly semantics, and may be ignored by an implementation.

However, it can provides useful information that implementations can make use of to improve user experience or take compilation hints.

Dependencies
~~~~~~~~~~~~

This document is based on the WebAssembly core specification (|WasmDraft|), and makes use of
terms and definitions described there. These uses always link to the corresponding definition
in the core specification.

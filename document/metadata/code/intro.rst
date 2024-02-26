.. _intro:

Introduction
============

This document defines a generic mechanism for attaching arbitrary metadata to WebAssembly instructions.
Additionally, it defines specific metadata types using this mechanism.

Such metadata do not contribute to, or otherwise affect, the WebAssembly semantics, and may be ignored by an implementation.

However, it can provides useful information that implementations can make use of to improve user experience or take compilation hints.


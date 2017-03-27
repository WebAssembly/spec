.. index:: ! binary format

Conventions
-----------

The binary format for WebAssembly modules is a linear encoding of its :ref:`abstract syntax <sec-abstract-syntax>`.
The format is defined by an *attribute grammar*,
where the attribute of each production is the phrase of the abstract syntax that it decodes into.
Except for a few exceptions, the binary grammar closely mirrors the grammar of the abstract syntax,
but it only has :ref:`bytes <syntax-byte>` as terminal symbols.
Any byte sequence not covered by the specified grammar is malformed.
[#compression]_

.. Note::
   Some phrases of abstract syntax have multiple possible encodings in the binary format.
   For example, numbers may be encoded as if they had optional leading zeros.
   Implementations of encoders producing WebAssembly binaries can pick any encoding.

.. [#compression]
   Additional encoding layers -- for example, introducing compression -- may be defined on top of the basic representation defined here.
   However, such layers are outside the scope of the current specification.


.. _binary-grammar:
.. index:: grammar notation, notation, byte
   single: binary format; grammar
   pair: binary format; notation

Grammar
~~~~~~~

The following conventions are adopted in defining grammar rules for abstract syntax.
They mirror the conventions used for :ref:`abstract syntax <grammar>`, but are distinguished by a different font style for non-terminals.

* Terminal symbols are :ref:`bytes <syntax-byte>` expressed in hexadecimal notation or with the |BYTE| meta-function: :math:`\hex{0F}, \byte(n)`.

* Nonterminal symbols are written in teletype font: :math:`\B{valtype}, \B{instr}`.

* :math:`B^n` is a sequence of :math:`n\geq 0` iterations  of :math:`B`.

* :math:`B^\ast` is a possibly empty sequence of iterations of :math:`B`.
  (This is a shorthand for :math:`A^n` used where :math:`n` is not relevant.)

* :math:`B^?` is an optional occurrence of :math:`B`.
  (This is a shorthand for :math:`A^n` where :math:`n \leq 1`.)

* :math:`B\{x\}` denotes the same language as :math:`B`, but also binds the variable :math:`x` to the abstract syntax synthesized recursively for :math:`B`.

* Productions are written :math:`\B{B} ::= B \Rightarrow A`, where :math:`A` defines the abstract syntax synthesized for :math:`\B{B}`, usually fro atrribute variables bound in :math:`B`.

.. note::

   For example,
   
   TODO
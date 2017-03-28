.. _syntax:
.. index:: ! abstract syntax

Conventions
-----------

WebAssembly is a programming language that does not have a concrete textual syntax
(other than the auxiliary :ref:`text format <text-format>`).
For conciseness, however, its structure is described in the form of an *abstract syntax*.
All parts of this specification are defined in terms of this abstract syntax,
including the decoding of the :ref:`binary format <binary-format>`.


.. _grammar:
.. index:: ! grammar notation, notation
   single: abstract syntax; grammar
   pair: abstract syntax; notation

Grammar
~~~~~~~

The following conventions are adopted in defining grammar rules for abstract syntax.

* Terminal symbols (atoms) are written in sans-serif: :math:`\K{i32}, \K{end}`.

* Nonterminal symbols are written in italic: :math:`\X{valtype}, \X{instr}`.

* :math:`A^n` is a sequence of :math:`n\geq 0` iterations  of :math:`A`.

* :math:`A^\ast` is a possibly empty sequence of iterations of :math:`A`.
  (This is a shorthand for :math:`A^n` used where :math:`n` is not relevant.)

* :math:`A^?` is an optional occurrence of :math:`A`.
  (This is a shorthand for :math:`A^n` where :math:`n \leq 1`.)


.. _syntax-record:

Auxiliary Notation
~~~~~~~~~~~~~~~~~~

When dealing with syntactic constructs the following notation is also used:

* :math:`\epsilon` denotes the empty sequence.

* :math:`|s|` denotes the length of a sequence :math:`s`.

* :math:`s[i]` denotes the :math:`i`-th element of a sequence :math:`s`, starting from :math:`0`.

Productions of the following form are interpreted as *records* that map a fixed set of fields :math:`\K{field}_i` to values :math:`x_i`, respectively:

.. math::
   \X{r} ~::=~ \{ \K{field}_1~x_1, \K{field}_2~x_2, \dots \}

The following notation is adopted for manipulating such records:

* :math:`r.\K{field}` denotes the :math:`\K{field}` component of :math:`r`.

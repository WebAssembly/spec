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

* :math:`A^+` is a possibly empty sequence of iterations of :math:`A`.
  (This is a shorthand for :math:`A^n` where :math:`n \geq 1`.)

* :math:`A^?` is an optional occurrence of :math:`A`.
  (This is a shorthand for :math:`A^n` where :math:`n \leq 1`.)


.. _syntax-record:

Auxiliary Notation
~~~~~~~~~~~~~~~~~~

When dealing with syntactic constructs the following notation is also used:

* :math:`\epsilon` denotes the empty sequence.

* :math:`|s|` denotes the length of a sequence :math:`s`.

* :math:`s[i]` denotes the :math:`i`-th element of a sequence :math:`s`, starting from :math:`0`.

* :math:`s[i:n]` denotes the sub-sequence :math:`s[i]~\dots~s[i+n-1]` of a sequence :math:`s`.

* :math:`s \with [i] = A` denotes the same sequence as :math:`s`,
  except that the :math:`i`-the element is replaced with :math:`A`.

* :math:`s \with [i:n] = A^n` denotes the same sequence as :math:`s`,
  except that the sub-sequence :math:`s[i:n]` is replaced with :math:`A^n`.

Moreover, the following conventions are employed:

* The notation :math:`x^n`, where :math:`x` is a non-terminal symbol, is treated as a meta variable ranging over respective sequences of :math:`x` (similarly for :math:`x^\ast`, :math:`x^+`, :math:`x^?`).

* When given a sequence :math:`x^n`,
  then the occurrences of :math:`x` in a sequence written :math:`(A_1~x~A_2)^n` are assumed to be in point-wise correspondence with :math:`x^n`
  (similarly for :math:`x^\ast`, :math:`x^+`, :math:`x^?`).
  This implicitly expresses a form of mapping syntactic constructions over a sequence.

Productions of the following form are interpreted as *records* that map a fixed set of fields :math:`\K{field}_i` to "values" :math:`A_i`, respectively:

.. math::
   \X{r} ~::=~ \{ \K{field}_1~A_1, \K{field}_2~A_2, \dots \}

The following notation is adopted for manipulating such records:

* :math:`r.\K{field}` denotes the value of the :math:`\K{field}` component of :math:`r`.

* :math:`r \with \K{field} = A` denotes the same record as :math:`r`,
  except that the value of the :math:`\K{field}` component is replaced with :math:`A`.

The update notation for sequences and records generalizes recursively to nested components accessed by "paths" :math:`\X{pth} ::= ([\dots] \;| \;.\K{field})^+`:

* :math:`s \with [i]\,\X{pth} = A` is short for :math:`s \with [i] = (s[i] \with \X{pth} = A)`.

* :math:`r \with \K{field}\,\X{pth} = A` is short for :math:`r \with \K{field} = (r.\K{field} \with \X{pth} = A)`.

where :math:`r \with .\K{field} = A` is shortened to :math:`r \with \K{field} = A`.

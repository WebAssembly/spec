.. index:: ! abstract syntax

Conventions
-----------

WebAssembly is a programming language that has multiple concrete representations
(its :ref:`binary format <binary>` and the :ref:`text format <text>`).
Both map to a common structure.
For conciseness, this structure is described in the form of an *abstract syntax*.
All parts of this specification are defined in terms of this abstract syntax.


.. index:: ! grammar notation, notation
   single: abstract syntax; grammar
   pair: abstract syntax; notation
.. _grammar:

Grammar Notation
~~~~~~~~~~~~~~~~

The following conventions are adopted in defining grammar rules for abstract syntax.

* Terminal symbols (atoms) are written in sans-serif font or in symbolic form: :math:`\K{i32}, \K{end}, {\to}, [, ]`.

* Nonterminal symbols are written in italic font: :math:`\X{valtype}, \X{instr}`.

* :math:`A^n` is a sequence of :math:`n\geq 0` iterations  of :math:`A`.

* :math:`A^\ast` is a possibly empty sequence of iterations of :math:`A`.
  (This is a shorthand for :math:`A^n` used where :math:`n` is not relevant.)

* :math:`A^+` is a non-empty sequence of iterations of :math:`A`.
  (This is a shorthand for :math:`A^n` where :math:`n \geq 1`.)

* :math:`A^?` is an optional occurrence of :math:`A`.
  (This is a shorthand for :math:`A^n` where :math:`n \leq 1`.)

* Productions are written :math:`\X{sym} ::= A_1 ~|~ \dots ~|~ A_n`.

* Large productions may be split into multiple definitions, indicated by ending the first one with explicit ellipses, :math:`\X{sym} ::= A_1 ~|~ \dots`, and starting continuations with ellipses, :math:`\X{sym} ::= \dots ~|~ A_2`.

* Some productions are augmented with side conditions in parentheses, ":math:`(\iff \X{condition})`", that provide a shorthand for a combinatorial expansion of the production into many separate cases.

* If the same meta variable or non-terminal symbol appears multiple times in a production, then all those occurrences must have the same instantiation.
  (This is a shorthand for a side condition requiring multiple different variables to be equal.)


.. _notation-epsilon:
.. _notation-length:
.. _notation-index:
.. _notation-slice:
.. _notation-replace:
.. _notation-record:
.. _notation-project:
.. _notation-concat:
.. _notation-compose:

Auxiliary Notation
~~~~~~~~~~~~~~~~~~

When dealing with syntactic constructs the following notation is also used:

* :math:`\epsilon` denotes the empty sequence.

* :math:`|s|` denotes the length of a sequence :math:`s`.

* :math:`s[i]` denotes the :math:`i`-th element of a sequence :math:`s`, starting from :math:`0`.

* :math:`s[i \slice n]` denotes the sub-sequence :math:`s[i]~\dots~s[i+n-1]` of a sequence :math:`s`.

* :math:`s \with [i] = A` denotes the same sequence as :math:`s`,
  except that the :math:`i`-th element is replaced with :math:`A`.

* :math:`s \with [i \slice n] = A^n` denotes the same sequence as :math:`s`,
  except that the sub-sequence :math:`s[i \slice n]` is replaced with :math:`A^n`.

* :math:`\concat(s^\ast)` denotes the flat sequence formed by concatenating all sequences :math:`s_i` in :math:`s^\ast`.

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

* :math:`r.\K{field}` denotes the contents of the :math:`\K{field}` component of :math:`r`.

* :math:`r \with \K{field} = A` denotes the same record as :math:`r`,
  except that the contents of the :math:`\K{field}` component is replaced with :math:`A`.

* :math:`r_1 \compose r_2` denotes the composition of two records with the same fields of sequences by appending each sequence point-wise:

  .. math::
     \{ \K{field}_1\,A_1^\ast, \K{field}_2\,A_2^\ast, \dots \} \compose \{ \K{field}_1\,B_1^\ast, \K{field}_2\,B_2^\ast, \dots \} = \{ \K{field}_1\,A_1^\ast~B_1^\ast, \K{field}_2\,A_2^\ast~B_2^\ast, \dots \}

* :math:`\bigcompose r^\ast` denotes the composition of a sequence of records, respectively; if the sequence is empty, then all fields of the resulting record are empty.

The update notation for sequences and records generalizes recursively to nested components accessed by "paths" :math:`\X{pth} ::= ([\dots] \;| \;.\K{field})^+`:

* :math:`s \with [i]\,\X{pth} = A` is short for :math:`s \with [i] = (s[i] \with \X{pth} = A)`,

* :math:`r \with \K{field}\,\X{pth} = A` is short for :math:`r \with \K{field} = (r.\K{field} \with \X{pth} = A)`,

where :math:`r \with~.\K{field} = A` is shortened to :math:`r \with \K{field} = A`.


.. index:: ! vector
   pair: abstract syntax; vector
.. _syntax-vec:

Vectors
~~~~~~~

*Vectors* are bounded sequences of the form :math:`A^n` (or :math:`A^\ast`),
where the :math:`A` can either be values or complex constructions.
A vector can have at most :math:`2^{32}-1` elements.

.. math::
   \begin{array}{lllll}
   \production{vector} & \vec(A) &::=&
     A^n
     & (\iff n < 2^{32})\\
   \end{array}

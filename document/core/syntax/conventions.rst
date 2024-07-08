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

* Terminal symbols (atoms) are written in sans-serif font or in symbolic form: ${:I32}, ${:NOP}, ${:`->}, ${:`[`,]}.

* Nonterminal symbols are written in italic font: ${:valtype}, ${:instr}.

* ${:A^n} is a sequence of ${:n >= 0} iterations of ${:A}.

* ${:A*} is a possibly empty sequence of iterations of ${:A}.
  (This is a shorthand for ${:A^n} used where ${:n} is not relevant.)

* ${:A+}` is a non-empty sequence of iterations of ${:A}.
  (This is a shorthand for ${:A^n} where ${:n >= 1}.)

* ${:A?}` is an optional occurrence of ${:A}.
  (This is a shorthand for ${:A^n} where ${:n <= 1}.)

* Productions are written ${syntax-: sym}.

* Large productions may be split into multiple definitions, indicated by ending the first one with explicit ellipses, ${syntax: symsplit/1}, and starting continuations with ellipses, ${syntax: symsplit/2}.

* Some productions are augmented with side conditions, ":math:`(\iff \X{condition})`", that provide a shorthand for a combinatorial expansion of the production into many separate cases.

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

${syntax-ignore: A B}

When dealing with syntactic constructs the following notation is also used:

* ${:eps} denotes the empty sequence.

* ${:|s|} denotes the length of a sequence ${:s}.

* ${:s[i]} denotes the ${:i}-th element of a sequence ${:s}`, starting from ${:0}.

* ${:s[i : n]} denotes the sub-sequence ${:s[i]...s[i+n-1]} of a sequence ${:s}.

* ${:s[[i]=A]} denotes the same sequence as ${:s},
  except that the ${:i}-th element is replaced with ${-:A}.

* ${:s[[i : n] = A^n]} denotes the same sequence as ${:s},
  except that the sub-sequence ${:s[i : n]} is replaced with ${:A^n}.

* ${:s_1++s_2} denotes the sequence ${:s_1} concatenated with ${:s_2};
  this is equivalent to ${:s_1 s_2}, but sometimes used for clarity.

* ${:$concat(s*)} denotes the flat sequence formed by concatenating all sequences ${:s_i} in ${:s*}.

Moreover, the following conventions are employed:

* The notation ${:x^n}, where ${:x} is a non-terminal symbol, is treated as a meta variable ranging over respective sequences of ${:x} (similarly for ${:x*}, ${:x+}, ${:x?}).

* When given a sequence ${:x^n},
  then the occurrences of ${:x} in an iterated sequence ${:(!%...x...!%)^n} are assumed to be in point-wise correspondence with ${:x^n}
  (similarly for ${:x*}, ${:x+}, ${:x?}).
  This implicitly expresses a form of mapping syntactic constructions over a sequence.


Productions of the following form are interpreted as *records* that map a fixed set of fields ${:FIELD_ i} to "values" ${:A_i}, respectively:

$${syntax-: record}
${syntax-ignore: recorddots}

The following notation is adopted for manipulating such records:

* Where the type of a record is clear from context, empty fields with value ${:eps} are often omitted.

* ${:r.FIELD} denotes the contents of the ${:FIELD} component of ${:r}.

* ${:r[.FIELD = A]} denotes the same record as ${:r},
  except that the contents of the ${:FIELD} component is replaced with ${:A}.

* ${:r[.FIELD =.. A^n]} denotes the same record as ${:r},
  except that ${:A^n} is appended to the sequence of the ${:FIELD} component,
  i.e, it is short for ${:r[.FIELD = r.FIELD A^n]}.

* ${:r_1++r_2} denotes the composition of two identically shaped records by concatenating each field of sequences point-wise:

  $${:
    `{FIELD_ 1 A_1*, FIELD_ 2 A_2*, `...} ++ `{FIELD_ 1 B_1*, FIELD_ 2 B_2*, `...} = `{FIELD_ 1 A_1* B_1*, FIELD_ 2 A_2* B_2*, `...}
  }

* ${:(++) r*} denotes the composition of a sequence of records, respectively; if the sequence is empty, then all fields of the resulting record are empty.

The update notation for sequences and records generalizes recursively to nested components accessed by "paths" ${syntax-: pth}:

* ${:s[$(`[i]#pth = A)]} is short for ${:s[[i] = s[i][pth = A]]},

* ${:r[$(!%.FIELD pth = A)]} is short for ${:r[.FIELD = r.FIELD[pth = A]]}.



.. index:: ! list
   pair: abstract syntax; list
.. _syntax-list:

Lists
~~~~~

*Lists* are bounded sequences of the form ${:A^n} (or ${:A*}),
where the ${:A} can either be values or complex constructions.
A list can have at most ${:$(2^32-1)} elements.

$${syntax: list}

.. _syntax-instructions:

Instructions
------------

.. _syntax-instructions-numeric-instructions:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _syntax-inn:
.. _syntax-fnn:
.. _syntax-sx:
.. _syntax-instr-numeric:
.. _syntax-unopIXX:
.. _syntax-unopFXX:
.. _syntax-binopIXX:
.. _syntax-binopFXX:
.. _syntax-testopIXX:
.. _syntax-testopFXX:
.. _syntax-relopIXX:
.. _syntax-relopFXX:

$${syntax+: 
  {inn
  fnn}
  sx
  instr/numeric
  {unopIXX
  unopFXX
  binopIXX
  binopFXX
  testopIXX
  testopFXX
  relopIXX
  relopFXX}
}

\

Occasionally, it is convenient to group operators together according to the following grammar shorthands:

.. _syntax-unop_numtype:
.. _syntax-binop_numtype:
.. _syntax-testop-numtype:
.. _syntax-relop_numtype:
.. _syntax-cvtop:

$${syntax+:
  {unop_numtype
  binop_numtype
  testop_numtype
  relop_numtype
  cvtop}
}

.. _syntax-instr-reference:
.. _syntax-instructions-reference-instructions:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

$${syntax: instr/reference}

.. _syntax-instr-heap:
.. _syntax-instructions-aggregate-instructions:

Aggregate Instructions
~~~~~~~~~~~~~~~~~~~~~~

$${syntax: instr/heap}

.. _syntax-instr-local:
.. _syntax-instr-global:
.. _syntax-instructions-variable-instructions:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

$${syntax+: 
  instr/local
  instr/global
}

.. _syntax-instr-table:
.. _syntax-instructions-table-instructions:

Table Instructions
~~~~~~~~~~~~~~~~~~

$${syntax: instr/table}

.. _syntax-instructions-memory-instructions:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _syntax-instr-memory:
.. _syntax-memop:

$${syntax+: 
  instr/memory
  memop
}

.. _def-memop0:

%{prose-func: memop0}

\

$${definition: memop0}

.. _syntax-blocktype:
.. _syntax-instr-control:
.. _syntax-instructions-control-instructions:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

$${syntax+: 
  blocktype
  instr/control
}

.. _syntax-instr-expr:
.. _syntax-instructions-expressions:

Expressions
~~~~~~~~~~~

$${syntax: expr}

.. _syntax-instructions:

Instructions
------------

.. _syntax-instructions-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

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
.. _syntax-instructions-reference:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

$${syntax: instr/reference}

.. _syntax-instr-heap:
.. _syntax-instructions-heap:

Heap Instructions
~~~~~~~~~~~~~~~~~

$${syntax: instr/heap}

.. _syntax-instr-state:
.. _syntax-instructions-state:

State Instructions
~~~~~~~~~~~~~~~~~~

$${syntax: instr/state}

.. _syntax-blocktype:
.. _syntax-instr-control:
.. _syntax-instructions-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

$${syntax+: 
  blocktype
  instr/control
}

.. _syntax-instr-expr:
.. _syntax-instructions-expr:

Expressions
~~~~~~~~~~~

$${syntax: expr}

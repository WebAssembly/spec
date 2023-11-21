.. _syntax-instructions:

Instructions
------------

<<<<<<< HEAD
.. _syntax-instructions-numeric-instructions:
=======
.. _syntax-sx:
.. _syntax-instr-numeric:
.. _syntax-unop_IXX:
.. _syntax-unop_FXX:
.. _syntax-binop_IXX:
.. _syntax-binop_FXX:
.. _syntax-testop_IXX:
.. _syntax-testop_FXX:
.. _syntax-relop_IXX:
.. _syntax-relop_FXX:
>>>>>>> al

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
<<<<<<< HEAD
  {unopIXX
  unopFXX
  binopIXX
  binopFXX
  testopIXX
  testopFXX
  relopIXX
  relopFXX}
=======
  {unop_IXX
  unop_FXX
  binop_IXX
  binop_FXX
  testop_IXX
  testop_FXX
  relop_IXX
  relop_FXX}
>>>>>>> al
}

\

Occasionally, it is convenient to group operators together according to the following grammar shorthands:

.. _syntax-unop_numtype:
.. _syntax-binop_numtype:
<<<<<<< HEAD
.. _syntax-testop-numtype:
=======
.. _syntax-testop_numtype:
>>>>>>> al
.. _syntax-relop_numtype:
.. _syntax-cvtop:

$${syntax+:
  unop_numtype
  binop_numtype
  testop_numtype
  relop_numtype
  cvtop
}

.. _syntax-instr-reference:
<<<<<<< HEAD
.. _syntax-instructions-reference-instructions:
=======
>>>>>>> al

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

$${syntax: instr/reference}

<<<<<<< HEAD
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
=======
.. _syntax-instr-state:

Variable, Table, and Memory Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>> al

$${syntax: instr/table}

<<<<<<< HEAD
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
=======
.. _syntax-blocktype:
.. _syntax-instr-control:
>>>>>>> al

Control Instructions
~~~~~~~~~~~~~~~~~~~~

$${syntax+: 
  blocktype
  instr/control
}

.. _syntax-instr-expr:
<<<<<<< HEAD
.. _syntax-instructions-expressions:
=======
>>>>>>> al

Expressions
~~~~~~~~~~~

$${syntax: expr}

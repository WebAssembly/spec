.. _syntax-instructions:

Instructions
------------

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

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

$${syntax+: 
  sx
  instr/numeric
  {unop_IXX
  unop_FXX
  binop_IXX
  binop_FXX
  testop_IXX
  testop_FXX
  relop_IXX
  relop_FXX}
}

\

Occasionally, it is convenient to group operators together according to the following grammar shorthands:

.. _syntax-unop_numtype:
.. _syntax-binop_numtype:
.. _syntax-testop_numtype:
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

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

$${syntax: instr/reference}

.. _syntax-instr-state:

Variable, Table, and Memory Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

$${syntax: instr/state}

.. _syntax-blocktype:
.. _syntax-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

$${syntax+: 
  blocktype
  instr/control
}

.. _syntax-instr-expr:

Expressions
~~~~~~~~~~~

$${syntax: expr}

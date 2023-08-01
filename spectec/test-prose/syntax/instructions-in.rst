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
.. _syntax-unop_numtype:
.. _syntax-binop_numtype:
.. _syntax-relop_numtype:
.. _syntax-cvtop:
.. _syntax-instructions-numeric:

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
  relop_IXX}
}

\

Occasionally, it is convenient to group operators together according to the following grammar shorthands:

$${syntax+:
  {unop_numtype
  binop_numtype
  relop_numtype
  cvtop}
}

.. _syntax-instr-reference:
.. _syntax-instructions-reference:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

$${syntax: instr/reference}

.. _syntax-instr-state:
.. _syntax-instructions-state:

State Instructions
~~~~~~~~~~~~~~~~~~

$${syntax: instr/state}

.. _syntax-instr-control:
.. _syntax-instructions-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

$${syntax: instr/control}

.. _syntax-instr-expr:
.. _syntax-instructions-expr:

Expressions
~~~~~~~~~~~

$${syntax: expr}

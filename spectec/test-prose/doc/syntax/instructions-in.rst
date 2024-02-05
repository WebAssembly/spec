.. _syntax-instructions:

Instructions
------------

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _syntax-inn:
.. _syntax-fnn:
.. _syntax-sx:
.. _syntax-instr-numeric:
.. _syntax-iunop:
.. _syntax-funop:
.. _syntax-ibinop:
.. _syntax-fbinop:
.. _syntax-itestop:
.. _syntax-ftestop:
.. _syntax-irelop:
.. _syntax-frelop:

$${syntax+: 
  {inn
  fnn}
  sx
  instr/numeric
  {iunop
  funop
  ibinop
  fbinop
  itestop
  ftestop
  irelop
  frelop}
}

\

Occasionally, it is convenient to group operators together according to the following grammar shorthands:

.. _syntax-unop_numtype:
.. _syntax-binop_numtype:
.. _syntax-testop-numtype:
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

.. _syntax-instr-heap:

Aggregate Instructions
~~~~~~~~~~~~~~~~~~~~~~

$${syntax: instr/heap}

.. _syntax-instr-local:
.. _syntax-instr-global:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

$${syntax+: 
  instr/local
  instr/global
}

.. _syntax-instr-table:

Table Instructions
~~~~~~~~~~~~~~~~~~

$${syntax: instr/table}


Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _syntax-instr-memory:
.. _syntax-memop:

$${syntax+: 
  instr/memory
  memop
}

.. _def-memop0:

%{definition-prose: memop0}

\

$${definition: memop0}

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

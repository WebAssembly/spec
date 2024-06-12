.. _syntax-instructions:

Instructions
------------

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _syntax-Inn:
.. _syntax-Fnn:
.. _syntax-sx:
.. _syntax-instr-num:
.. _syntax-unop:
.. _syntax-binop:
.. _syntax-testop:
.. _syntax-relop:

$${syntax+: 
  {Inn
  Fnn}
  sx
  instr/num
  {unop_
  binop_
  testop_
  relop_
  cvtop_}
}


.. _syntax-instr-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

$${syntax: instr/ref}

.. _syntax-instr-heap:

Aggregate Instructions
~~~~~~~~~~~~~~~~~~~~~~

$${syntax: instr/struct instr/array instr/i31 instr/extern}

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

$${syntax: instr/table instr/elem}


Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _syntax-instr-memory:
.. _syntax-memarg:

$${syntax+: 
  instr/memory instr/data
  memarg loadop_ vloadop_
}

.. _def-memarg0:

%{definition-prose: memarg0}

\

$${definition: memarg0}

.. _syntax-blocktype:
.. _syntax-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

$${syntax+: 
  blocktype
  {instr/block instr/br instr/call}
}

.. _syntax-instr-expr:

Expressions
~~~~~~~~~~~

$${syntax: expr}

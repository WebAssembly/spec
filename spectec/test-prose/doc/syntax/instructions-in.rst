.. _syntax-instructions:

Instructions
------------

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _syntax-inn:
.. _syntax-fnn:
.. _syntax-sx:
.. _syntax-instr-num:
.. _syntax-unop:
.. _syntax-binop:
.. _syntax-testop:
.. _syntax-relop:

$${syntax+: 
  {inn
  fnn}
  sx
  instr/num
  {unop_
  binop_
  testop_
  relop_
  cvtop}
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
.. _syntax-memop:

$${syntax+: 
  instr/memory instr/data
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

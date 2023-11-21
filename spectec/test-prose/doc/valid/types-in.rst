.. _valid-types:

Types
-----

<<<<<<< HEAD
.. _valid-types-number-types:

Number Types
~~~~~~~~~~~~
=======
Limits
~~~~~~
>>>>>>> al

$${rule: Numtype_ok}

.. _valid-types-vector-types:

Vector Types
~~~~~~~~~~~~

$${rule: Vectype_ok}

.. _valid-types-heap-types:

Heap Types
~~~~~~~~~~

$${rule+: 
  Heaptype_ok/*
}

.. _valid-types-reference-types:

Reference Types
~~~~~~~~~~~~~~~

$${rule: Reftype_ok}

.. _valid-types-value-types:

Value Types
~~~~~~~~~~~

$${rule+:
  Valtype_ok/*
}

.. _valid-types-block-types:

Block Types
~~~~~~~~~~~

$${rule+: 
  Blocktype_ok/*
}

.. _valid-types-result-types:

Result Types
~~~~~~~~~~~~

$${rule: Resulttype_ok}

.. _valid-types-instruction-types:

Instruction Types
~~~~~~~~~~~~~~~~~

$${rule: Instrtype_ok}

<<<<<<< HEAD
.. _valid-types-function-types:
=======
Block Types
~~~~~~~~~~~

$${rule: Blocktype_ok}
>>>>>>> al

Function Types
~~~~~~~~~~~~~~

$${rule: Functype_ok}

<<<<<<< HEAD
.. _valid-types-composite-types:

Composite Types
~~~~~~~~~~~~~~~

$${rule+:
  Comptype_ok/*
}

.. _valid-types-field-types:

Field Types
~~~~~~~~~~~

$${rule+: 
  Packedtype_ok
  Storagetype_ok/*
  Fieldtype_ok
}

.. _valid-types-recursive-types:

Recursive Types
~~~~~~~~~~~~~~~

.. _def-before:

%{prose-func: before}

\

$${definition: before}

.. _syntax-oktypeidx:
.. _syntax-oktypeidxnat:

$${syntax+:
  oktypeidx
  oktypeidxnat
}

$${rule+:
  Rectype_ok/*
  Rectype_ok2/*
  Subtype_ok
  Subtype_ok2
}

.. _valid-types-defined-types:

Defined Types
~~~~~~~~~~~~~

$${rule: Deftype_ok}

.. _valid-types-limits:

Limits
~~~~~~

$${rule: Limits_ok}

.. _valid-types-table-types:

=======
>>>>>>> al
Table Types
~~~~~~~~~~~

$${rule: Tabletype_ok}

<<<<<<< HEAD
.. _valid-types-memory-types:

=======
>>>>>>> al
Memory Types
~~~~~~~~~~~~

$${rule: Memtype_ok}

<<<<<<< HEAD
.. _valid-types-global-types:

=======
>>>>>>> al
Global Types
~~~~~~~~~~~~

$${rule: Globaltype_ok}

<<<<<<< HEAD
.. _valid-types-external-types:

=======
>>>>>>> al
External Types
~~~~~~~~~~~~~~

$${rule+:
  Externtype_ok/*
<<<<<<< HEAD
=======
}

Import Subtyping
~~~~~~~~~~~~~~~~

$${rule+:
  Limits_sub
  Functype_sub
  Tabletype_sub
  Memtype_sub
  Globaltype_sub
  Externtype_sub/*
>>>>>>> al
}

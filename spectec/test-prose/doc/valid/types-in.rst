.. _valid-types:

Types
-----

.. _valid-Numtype_ok:
.. _valid-types-number-types:

Number Types
~~~~~~~~~~~~

$${rule: Numtype_ok}

.. _valid-Vectype_ok:
.. _valid-types-vector-types:

Vector Types
~~~~~~~~~~~~

$${rule: Vectype_ok}

.. _valid-Heaptype_ok:
.. _valid-types-heap-types:

Heap Types
~~~~~~~~~~

$${rule+: 
  Heaptype_ok/*
}

.. _valid-Reftype_ok:
.. _valid-types-reference-types:

Reference Types
~~~~~~~~~~~~~~~

$${rule: Reftype_ok}

.. _valid-Valtype_ok:
.. _valid-types-value-types:

Value Types
~~~~~~~~~~~

$${rule+:
  Valtype_ok/*
}

.. _valid-Blocktype_ok:
.. _valid-types-block-types:

Block Types
~~~~~~~~~~~

$${rule: Blocktype_ok}

.. _valid-Resulttype_ok:
.. _valid-types-result-types:

Result Types
~~~~~~~~~~~~

$${rule: Resulttype_ok}

.. _valid-Instrtype_ok:
.. _valid-types-instruction-types:

Instruction Types
~~~~~~~~~~~~~~~~~

$${rule: Instrtype_ok}

.. _valid-Functype_ok:
.. _valid-types-function-types:

Function Types
~~~~~~~~~~~~~~

$${rule: Functype_ok}

.. _valid-Comptype_ok:
.. _valid-types-composite-types:

Composite Types
~~~~~~~~~~~~~~~

$${rule+:
  Comptype_ok/*
}

.. _valid-Packedtype_ok:
.. _valid-Storagetype_ok:
.. _valid-Fieldtype_ok:
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

.. _valid-Rectype_ok:
.. _valid-Rectype_ok2:
.. _valid-Subtype_ok:
.. _valid-Subtype_ok2:

$${rule+:
  Rectype_ok/*
  Rectype_ok2/*
  Subtype_ok
  Subtype_ok2
}

.. _valid-Deftype_ok:
.. _valid-types-defined-types:

Defined Types
~~~~~~~~~~~~~

$${rule: Deftype_ok}

.. _valid-Limits_ok:
.. _valid-types-limits:

Limits
~~~~~~

$${rule: Limits_ok}

.. _valid-Tabletype_ok:
.. _valid-types-table-types:

Table Types
~~~~~~~~~~~

$${rule: Tabletype_ok}

.. _valid-Memtype_ok:
.. _valid-types-memory-types:

Memory Types
~~~~~~~~~~~~

$${rule: Memtype_ok}

.. _valid-Globaltype_ok:
.. _valid-types-global-types:

Global Types
~~~~~~~~~~~~

$${rule: Globaltype_ok}

.. _valid-Externtype_ok:
.. _valid-types-external-types:

External Types
~~~~~~~~~~~~~~

$${rule+:
  Externtype_ok/*
}

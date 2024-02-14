.. _valid-matching:

Matching
--------

.. _valid-matching-number-types:

Number Types
~~~~~~~~~~~~

$${rule: Numtype_sub}

.. _valid-matching-vector-types:

Vector Types
~~~~~~~~~~~~

$${rule: Vectype_sub}

.. _valid-matching-heap-types:

Heap Types
~~~~~~~~~~

$${rule+:
  Heaptype_sub/*
}

.. _valid-matching-reference-types:

Reference Types
~~~~~~~~~~~~~~~

$${rule+:
  Reftype_sub/nonnull
  Reftype_sub/null
}

.. _valid-matching-value-types:

Value Types
~~~~~~~~~~~

$${rule+:
  Valtype_sub/*
}

.. _valid-matching-result-types:

Result Types
~~~~~~~~~~~~

$${rule: Resulttype_sub}

.. _valid-matching-instruction-types:

Instruction Types
~~~~~~~~~~~~~~~~~

$${rule: Instrtype_sub}

.. _valid-matching-function-types:

Function Types
~~~~~~~~~~~~~~

$${rule: Functype_sub}

.. _valid-matching-composite-types:

Composite Types
~~~~~~~~~~~~~~~

$${rule+: 
  Comptype_sub/*
}

.. _valid-matching-field-types:

Field Types
~~~~~~~~~~~

$${rule+:
  Fieldtype_sub/*
  Storagetype_sub/*
  Packtype_sub
}

.. _valid-matching-defined-types:

Defined Types
~~~~~~~~~~~~~

$${rule+:
  Deftype_sub/*
}

.. _valid-matching-limits:

Limits
~~~~~~

$${rule: Limits_sub}

.. _valid-matching-table-types:

Table Types
~~~~~~~~~~~

$${rule: Tabletype_sub}

.. _valid-matching-memory-types:

Memory Types
~~~~~~~~~~~~

$${rule: Memtype_sub}

.. _valid-matching-global-types:

Global Types
~~~~~~~~~~~~

$${rule+:
  Globaltype_sub/*
}

.. _valid-matching-external-types:

External Types
~~~~~~~~~~~~~~

$${rule+:
  Externtype_sub/*
}

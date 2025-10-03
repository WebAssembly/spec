Types
-----

Simple :ref:`types <syntax-type>`, such as :ref:`number types <syntax-numtype>` are universally valid.
However, restrictions apply to most other types, such as :ref:`reference types <syntax-reftype>`, :ref:`function types <syntax-functype>`, as well as the :ref:`limits <syntax-limits>` of :ref:`table types <syntax-tabletype>` and :ref:`memory types <syntax-memtype>`, which must be checked during validation.

Moreover, :ref:`block types <syntax-blocktype>` are converted to :ref:`instruction types <syntax-instrtype>` for ease of processing.


.. index:: number type
   pair: validation; number type
   single: abstract syntax; number type
.. _valid-numtype:

Number Types
~~~~~~~~~~~~

$${rule-prose: Numtype_ok}

$${rule: Numtype_ok}


.. index:: vector type
   pair: validation; vector type
   single: abstract syntax; vector type
.. _valid-vectype:

Vector Types
~~~~~~~~~~~~

$${rule-prose: Vectype_ok}

$${rule: Vectype_ok}


.. index:: type index, type use
   pair: validation; type use
   single: abstract syntax; type use
.. _valid-typeuse:

Type Uses
~~~~~~~~~

$${rule-prose: Typeuse_ok/typeidx}

$${rule: Typeuse_ok/typeidx}


.. index:: heap type, type use
   pair: validation; heap type
   single: abstract syntax; heap type
.. _valid-heaptype:

Heap Types
~~~~~~~~~~

$${rule-prose: Heaptype_ok/abs}

$${rule: Heaptype_ok/abs}


.. index:: reference type, heap type
   pair: validation; reference type
   single: abstract syntax; reference type
.. _valid-reftype:

Reference Types
~~~~~~~~~~~~~~~

$${rule-prose: Reftype_ok}

$${rule: Reftype_ok}


.. index:: value type, reference type, number type, vector type
   pair: validation; value type
   single: abstract syntax; value type
.. _valid-valtype:

Value Types
~~~~~~~~~~~

$${rule-prose: Valtype_ok}

$${rule: Valtype_ok/bot}


.. index:: result type, value type
   pair: validation; result type
   single: abstract syntax; result type
.. _valid-resulttype:

Result Types
~~~~~~~~~~~~

$${rule-prose: Resulttype_ok}

$${rule: Resulttype_ok}


.. index:: block type, instruction type
   pair: validation; block type
   single: abstract syntax; block type
.. _valid-blocktype:

Block Types
~~~~~~~~~~~

:ref:`Block types <syntax-blocktype>` may be expressed in one of two forms, both of which are converted to :ref:`instruction types <syntax-instrtype>` by the following rules.

$${rule-prose: Blocktype_ok/typeidx}

$${rule: Blocktype_ok/typeidx}


$${rule-prose: Blocktype_ok/valtype}

$${rule: Blocktype_ok/valtype}


.. index:: instruction type
   pair: validation; instruction type
   single: abstract syntax; instruction type
.. _valid-instrtype:

Instruction Types
~~~~~~~~~~~~~~~~~

$${rule-prose: Instrtype_ok}

$${rule: Instrtype_ok}


.. index:: composite type, function type, aggregate type, structure type, array type, field type, storage type, packed type, value type, mutability
   pair: validation; composite type
   pair: validation; aggregate type
   pair: validation; structure type
   pair: validation; array type
   pair: validation; function type
   pair: validation; field type
   pair: validation; storage type
   pair: validation; packed type
   single: abstract syntax; composite type
   single: abstract syntax; function type
   single: abstract syntax; structure type
   single: abstract syntax; array type
   single: abstract syntax; field type
   single: abstract syntax; storage type
   single: abstract syntax; packed type
   single: abstract syntax; value type
.. _valid-comptype:
.. _valid-aggrtype:
.. _valid-structtype:
.. _valid-arraytype:
.. _valid-functype:
.. _valid-fieldtype:
.. _valid-storagetype:
.. _valid-packtype:

Composite Types
~~~~~~~~~~~~~~~

$${rule-prose: Comptype_ok/struct}

$${rule: Comptype_ok/struct}


$${rule-prose: Comptype_ok/array}

$${rule: Comptype_ok/array}


$${rule-prose: Comptype_ok/func}

$${rule: Comptype_ok/func}


$${rule-prose: Fieldtype_ok}

$${rule: Fieldtype_ok}


$${rule-prose: Packtype_ok}

$${rule: Packtype_ok}


.. index:: recursive type, sub type, composite type, final, subtyping
   pair: abstract syntax; recursive type
   pair: abstract syntax; sub type
.. _valid-rectype:
.. _valid-subtype:

Recursive Types
~~~~~~~~~~~~~~~

:ref:`Recursive types <syntax-rectype>` are validated with respect to the first :ref:`type index <syntax-typeidx>` defined by the recursive group.

:math:`\TREC~\subtype^\ast`
...........................

$${rule-prose: Rectype_ok}

$${rule: {Rectype_ok/empty Rectype_ok/cons}}


:math:`\TSUB~\TFINAL^?~y^\ast~\comptype`
........................................

$${rule-prose: Subtype_ok}

$${rule: Subtype_ok}

.. note::
   The side condition on the index ensures that a declared supertype is a previously defined types,
   preventing cyclic subtype hierarchies.

   Future versions of WebAssembly may allow more than one supertype.


.. index:: limits
   pair: validation; limits
   single: abstract syntax; limits
.. _valid-limits:

Limits
~~~~~~

:ref:`Limits <syntax-limits>` must have meaningful bounds that are within a given range.

$${rule-prose: Limits_ok}

$${rule: Limits_ok}


.. index:: tag type, function type, exception tag
   pair: validation; tag type
   single: abstract syntax; tag type
.. _valid-tagtype:

Tag Types
~~~~~~~~~

$${rule-prose: Tagtype_ok}

$${rule: Tagtype_ok}


.. index:: global type, value type, mutability
   pair: validation; global type
   single: abstract syntax; global type
.. _valid-globaltype:

Global Types
~~~~~~~~~~~~

$${rule-prose: Globaltype_ok}

$${rule: Globaltype_ok}


.. index:: memory type, limits
   pair: validation; memory type
   single: abstract syntax; memory type
.. _valid-memtype:

Memory Types
~~~~~~~~~~~~

$${rule-prose: Memtype_ok}

$${rule: Memtype_ok}


.. index:: table type, reference type, limits
   pair: validation; table type
   single: abstract syntax; table type
.. _valid-tabletype:

Table Types
~~~~~~~~~~~

$${rule-prose: Tabletype_ok}

$${rule: Tabletype_ok}


.. index:: external type, function type, table type, memory type, global type
   pair: validation; external type
   single: abstract syntax; external type
.. _valid-externtype:

External Types
~~~~~~~~~~~~~~

$${rule-prose: Externtype_ok/tag}

$${rule: Externtype_ok/tag}


$${rule-prose: Externtype_ok/global}

$${rule: Externtype_ok/global}


$${rule-prose: Externtype_ok/mem}

$${rule: Externtype_ok/mem}


$${rule-prose: Externtype_ok/table}

$${rule: Externtype_ok/table}


$${rule-prose: Externtype_ok/func}

$${rule: Externtype_ok/func}

.. index:: value
.. exec-val:

Values
------

.. index:: value, value type, validation, structure, structure type, structure instance, array, array type, array instance, function, function type, function instance, null reference, scalar reference, store
.. _valid-val:

Value Typing
~~~~~~~~~~~~

For the purpose of checking argument :ref:`values <syntax-val>` against the parameter types of exported :ref:`functions <syntax-func>`,
values are classified by :ref:`value types <syntax-valtype>`.
The following auxiliary typing rules specify this typing relation relative to a :ref:`store <syntax-store>` :math:`S` in which possibly referenced :ref:`addresses <syntax-addr>` live.

${rule-ignore: Val_ok/*}


.. _valid-num:

Numeric Values
..............

$${rule-prose: Num_ok}

$${rule: Num_ok}


.. _valid-vec:

Vector Values
.............

$${rule-prose: Vec_ok}

$${rule: Vec_ok}


.. _valid-ref:

Null References
...............

$${rule-prose: Ref_ok/null}

$${rule: Ref_ok/null}

.. note::
   A null reference can be typed with any smaller type.
   In particular, that allows it to be typed with the least type in its respective hierarchy.
   That ensures that the value is compatible with any nullable type in that hierarchy.


.. _valid-ref.i31num:

Scalar References
.................

$${rule-prose: Ref_ok/i31}

$${rule: Ref_ok/i31}


.. _valid-ref.struct:

Structure References
....................

$${rule-prose: Ref_ok/struct}

$${rule: Ref_ok/struct}


.. _valid-ref.array:

Array References
................

$${rule-prose: Ref_ok/array}

$${rule: Ref_ok/array}


.. _valid-ref.exn:

Exception References
....................

$${rule-prose: Ref_ok/exn}

$${rule: Ref_ok/exn}


Function References
...................

$${rule-prose: Ref_ok/func}

$${rule: Ref_ok/func}


Host References
...............

$${rule-prose: Ref_ok/host}

$${rule: Ref_ok/host}

.. note::
   A bare host reference is considered internalized.


External References
...................

$${rule-prose: Ref_ok/extern}

$${rule: Ref_ok/extern}


Subsumption
...........

$${rule-prose: Ref_ok/sub}

$${rule: Ref_ok/sub}


.. index:: external address, external type, validation, import, store
.. _valid-externaddr:

External Typing
~~~~~~~~~~~~~~~

For the purpose of checking :ref:`external address <syntax-externaddr>` against :ref:`imports <syntax-import>`,
such values are classified by :ref:`external types <syntax-externtype>`.
The following auxiliary typing rules specify this typing relation relative to a :ref:`store <syntax-store>` :math:`S` in which the referenced instances live.


.. index:: function type, function address
.. _valid-externaddr-func:

Functions
.........

$${rule-prose: Externaddr_ok/func}

$${rule: Externaddr_ok/func}


.. index:: table type, table address
.. _valid-externaddr-table:

Tables
......

$${rule-prose: Externaddr_ok/table}

$${rule: Externaddr_ok/table}


.. index:: memory type, memory address
.. _valid-externaddr-mem:

Memories
........

$${rule-prose: Externaddr_ok/mem}

$${rule: Externaddr_ok/mem}


.. index:: global type, global address, value type, mutability
.. _valid-externaddr-global:

Globals
.......

$${rule-prose: Externaddr_ok/global}

$${rule: Externaddr_ok/global}


.. index:: tag type, tag address, exception tag, function type
.. _valid-externaddr-tag:

Tags
....

$${rule-prose: Externaddr_ok/tag}

$${rule: Externaddr_ok/tag}


Subsumption
...........

$${rule-prose: Externaddr_ok/sub}

$${rule: Externaddr_ok/sub}

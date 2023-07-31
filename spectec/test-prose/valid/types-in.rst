.. _valid-types:

Types
-----

.. _valid-Limits_ok:
.. _valid-types-limits:

Limits
~~~~~~

$${rule: Limits_ok}

.. _valid-Functype_ok:
.. _valid-types-function-types:

Function Types
~~~~~~~~~~~~~~

$${rule: Functype_ok}

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

.. _valid-Externtype_ok-func:
.. _valid-Externtype_ok-table:
.. _valid-Externtype_ok-mem:
.. _valid-Externtype_ok-global:
.. _valid-types-external-types:

External Types
~~~~~~~~~~~~~~

$${rule+:
  Externtype_ok/func
  Externtype_ok/table
  Externtype_ok/mem
  Externtype_ok/global
}

.. _valid-Limits_sub:
.. _valid-Functype_sub:
.. _valid-Externtype_sub/func:
.. _valid-Globaltype_sub:
.. _valid-Externtype_sub/global:
.. _valid-Tabletype_sub:
.. _valid-Externtype_sub/table:
.. _valid-Memtype_sub:
.. _valid-Externtype_sub/mem:
.. _valid-types-import-subtyping:

Import Subtyping
~~~~~~~~~~~~~~~~

$${rule+:
  Limits_sub
  Functype_sub
  Externtype_sub/func
  Globaltype_sub
  Externtype_sub/global
  Tabletype_sub
  Externtype_sub/table
  Memtype_sub
  Externtype_sub/mem
}

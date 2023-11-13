.. _valid-types:

Types
-----

Limits
~~~~~~

$${rule: Limits_ok}

Block Types
~~~~~~~~~~~

$${rule: Blocktype_ok}

Function Types
~~~~~~~~~~~~~~

$${rule: Functype_ok}

Table Types
~~~~~~~~~~~

$${rule: Tabletype_ok}

Memory Types
~~~~~~~~~~~~

$${rule: Memtype_ok}

Global Types
~~~~~~~~~~~~

$${rule: Globaltype_ok}

External Types
~~~~~~~~~~~~~~

$${rule+:
  Externtype_ok/*
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
}

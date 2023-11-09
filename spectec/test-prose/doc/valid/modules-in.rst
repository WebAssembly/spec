.. _valid-modules:

Modules
-------

.. _valid-Type_ok:
.. _valid-Types_ok:
.. _valid-modules-types:

Types
~~~~~

$${rule+: 
  Type_ok
  Types_ok/*
}

.. _valid-Func_ok:
.. _valid-modules-functions:

Functions
~~~~~~~~~

$${rule: Func_ok}

.. _valid-Local_ok:
.. _valid-modules-locals:

Locals
~~~~~~

$${rule+: 
  Local_ok/*
}

.. _valid-Table_ok:
.. _valid-modules-tables:

Tables
~~~~~~

$${rule: Table_ok}

.. _valid-Mem_ok:
.. _valid-modules-memories:

Memories
~~~~~~~~

$${rule: Mem_ok}

.. _valid-Global_ok:
.. _valid-Globals_ok:
.. _valid-modules-globals:

Globals
~~~~~~~

$${rule+: 
  Global_ok
  Globals_ok/*
}

.. _valid-Elem_ok:
.. _valid-Elemmode_ok:
.. _valid-modules-element-segments:

Element Segments
~~~~~~~~~~~~~~~~

$${rule+: 
  Elem_ok
  Elemmode_ok/*
}

.. _valid-Data_ok:
.. _valid-modules-data-segments:

Data Segments
~~~~~~~~~~~~~

$${rule+: 
  Data_ok
  Datamode_ok
}

.. _valid-Start_ok:
.. _valid-modules-start-function:

Start Function
~~~~~~~~~~~~~~

$${rule: Start_ok}

.. _valid-Export_ok:
.. _valid-Externuse_ok:
.. _valid-modules-exports:

Exports
~~~~~~~

$${rule+: 
  Export_ok
  Externuse_ok/*
}

.. _valid-Import_ok:
.. _valid-modules-imports:

Imports
~~~~~~~

$${rule: Import_ok}

.. _valid-Module_ok:
.. _valid-modules-modules:

Modules
~~~~~~~

$${rule: Module_ok}

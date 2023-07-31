.. _valid-modules:

Modules
-------

.. _valid-Func_ok:
.. _valid-modules-functions:

Functions
~~~~~~~~~

$${rule: Func_ok}

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
.. _valid-modules-globals:

Globals
~~~~~~~

$${rule: Global_ok}

.. _valid-Elem_ok:
.. _valid-Elemmode_ok/active:
.. _valid-Elemmode_ok/declare:
.. _valid-modules-element-segments:

Element Segments
~~~~~~~~~~~~~~~~

$${rule+: 
  Elem_ok
  Elemmode_ok/active
  Elemmode_ok/declare
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
.. _valid-Externuse_ok/func:
.. _valid-Externuse_ok/table:
.. _valid-Externuse_ok/mem:
.. _valid-Externuse_ok/global:
.. _valid-modules-exports:

Exports
~~~~~~~

$${rule+: 
  Export_ok
  Externuse_ok/func
  Externuse_ok/table
  Externuse_ok/mem
  Externuse_ok/global
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

.. _valid-modules:

Modules
-------

.. _valid-modules-types:

Types
~~~~~

$${rule+: 
  Type_ok
  Types_ok/*
}

.. _valid-modules-functions:

Functions
~~~~~~~~~

$${rule: Func_ok}

.. _valid-modules-locals:

Locals
~~~~~~

$${rule+: 
  Local_ok/*
}

.. _valid-modules-tables:

Tables
~~~~~~

$${rule: Table_ok}

.. _valid-modules-memories:

Memories
~~~~~~~~

$${rule: Mem_ok}

.. _valid-modules-globals:

Globals
~~~~~~~

$${rule+: 
  Global_ok
  Globals_ok/*
}

.. _valid-modules-element-segments:

Element Segments
~~~~~~~~~~~~~~~~

$${rule+: 
  Elem_ok
  Elemmode_ok/*
}

.. _valid-modules-data-segments:

Data Segments
~~~~~~~~~~~~~

$${rule+: 
  Data_ok
  Datamode_ok/*
}

.. _valid-modules-start-function:

Start Function
~~~~~~~~~~~~~~

$${rule: Start_ok}

.. _valid-modules-exports:

Exports
~~~~~~~

$${rule: Export_ok}

.. _valid-modules-imports:

Imports
~~~~~~~

$${rule: Import_ok}

.. _valid-modules-modules:

Modules
~~~~~~~

$${rule: Module_ok}

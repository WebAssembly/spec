.. _valid-modules:

Modules
-------

Functions
~~~~~~~~~

$${rule: Func_ok}

Tables
~~~~~~

$${rule: Table_ok}

Memories
~~~~~~~~

$${rule: Mem_ok}

Globals
~~~~~~~

$${rule: Global_ok}

Element Segments
~~~~~~~~~~~~~~~~

$${rule+: 
  Elem_ok
  Elemmode_ok/*
}

Data Segments
~~~~~~~~~~~~~

$${rule+: 
  Data_ok
  Datamode_ok
}

Start Function
~~~~~~~~~~~~~~

$${rule: Start_ok}

Exports
~~~~~~~

$${rule+: 
  Export_ok
  Externuse_ok/*
}

Imports
~~~~~~~

$${rule: Import_ok}

Modules
~~~~~~~

$${rule: Module_ok}

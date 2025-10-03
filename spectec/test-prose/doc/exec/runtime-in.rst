.. _exec-runtime:

Runtime Structure
-----------------

Values
~~~~~~

.. _syntax-num:
.. _syntax-addrref:
.. _syntax-ref:
.. _syntax-val:

$${syntax+:
  num
  {addrref
  ref}
  val
}

.. _def-default:

$${definition-prose: default_}

\

$${definition: default_}

Results
~~~~~~~

.. _syntax-result:

$${syntax: result}

.. _syntax-store:

Store
~~~~~

$${syntax: store}

.. _syntax-addr:
.. _syntax-funcaddr:
.. _syntax-tableaddr:
.. _syntax-memaddr:
.. _syntax-globaladdr:
.. _syntax-elemaddr:
.. _syntax-dataaddr:
.. _syntax-structaddr:
.. _syntax-arrayaddr:
.. _syntax-hostaddr:

Addresses
~~~~~~~~~

$${syntax+:
  addr
  funcaddr
  tableaddr
  memaddr
  globaladdr
  elemaddr
  dataaddr
  structaddr
  arrayaddr
  hostaddr
}

.. _syntax-moduleinst:

Module Instances
~~~~~~~~~~~~~~~~

$${syntax: moduleinst}

.. _def-moduleinst:

$${definition-prose: moduleinst}

\

$${definition: moduleinst}

.. _syntax-funcinst:

Function Instances
~~~~~~~~~~~~~~~~~~

$${syntax: funcinst}

.. _def-funcinst:

$${definition-prose: funcinst}

\

$${definition: funcinst}

.. _syntax-tableinst:

Table Instances
~~~~~~~~~~~~~~~

$${syntax: tableinst}

.. _def-tableinst:

$${definition-prose: tableinst}

\

$${definition: tableinst}

.. _syntax-meminst:

Memory Instances
~~~~~~~~~~~~~~~~

$${syntax: meminst}

.. _def-meminst:

$${definition-prose: meminst}

\

$${definition: meminst}

.. _syntax-globalinst:

Global Instances
~~~~~~~~~~~~~~~~

$${syntax: globalinst}

.. _def-globalinst:

$${definition-prose: globalinst}

\

$${definition: globalinst}

.. _syntax-eleminst:

Element Instances
~~~~~~~~~~~~~~~~~

$${syntax: eleminst}

.. _def-eleminst:

$${definition-prose: eleminst}

\

$${definition: eleminst}

.. _syntax-datainst:

Data Instances
~~~~~~~~~~~~~~

$${syntax: datainst}

.. _def-datainst:

$${definition-prose: datainst}

\

$${definition: datainst}

.. _syntax-exportinst:

Export Instances
~~~~~~~~~~~~~~~~

$${syntax: exportinst}

.. _syntax-externaddr:

External Addresses
~~~~~~~~~~~~~~~~~~

$${syntax: externaddr}

.. _def-funcsxa:

$${definition-prose: funcsxa}

\

$${definition: funcsxa}

.. _def-tablesxa:

$${definition-prose: tablesxa}

\

$${definition: tablesxa}

.. _def-memsxa:

$${definition-prose: memsxa}

\

$${definition: memsxa}

.. _def-globalsxa:

$${definition-prose: globalsxa}

\

$${definition: globalsxa}

.. _syntax-structinst:
.. _syntax-arrayinst:
.. _syntax-fieldval:
.. _syntax-packval:
.. _exec-runtime-aggregate-instances:

Aggregate Instances
~~~~~~~~~~~~~~~~~~~

$${syntax+:
  structinst
  arrayinst
  fieldval
  packval
}

.. _def-arrayinst:

$${definition-prose: arrayinst}

\

$${definition: arrayinst}

.. _def-structinst:

$${definition-prose: structinst}

\

$${definition: structinst}

.. _exec-runtime-stack:

Stack
~~~~~

.. _syntax-frame:

Activation Frames
.................

$${syntax: frame}

.. _syntax-admininstr:

Administrative Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~

$${syntax: instr/admin}

.. _syntax-state:
.. _syntax-config:
.. _exec-runtime-configurations:

Configurations
~~~~~~~~~~~~~~

$${syntax+:
  state
  config
}

.. _exec-runtime-typing:

Typing
~~~~~~

.. _def-store:

$${definition-prose: store}

\

$${definition: store}

.. _def-frame:

$${definition-prose: frame}

\

$${definition: frame}

$${rule+:
  Ref_ok/*
}

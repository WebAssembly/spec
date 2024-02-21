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

$${definition-prose: default}

\

$${definition: default}

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

.. _syntax-externval:

External Values
~~~~~~~~~~~~~~~

$${syntax: externval}

.. _def-funcsxv:

$${definition-prose: funcsxv}

\

$${definition: funcsxv}

.. _def-tablesxv:

$${definition-prose: tablesxv}

\

$${definition: tablesxv}

.. _def-memsxv:

$${definition-prose: memsxv}

\

$${definition: memsxv}

.. _def-globalsxv:

$${definition-prose: globalsxv}

\

$${definition: globalsxv}

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

$${syntax: admininstr}

.. _syntax-state:
.. _syntax-config:
.. _exec-runtime-configurations:

Configurations
~~~~~~~~~~~~~~

$${syntax+:
  state
  config
}

.. _syntax-E:
.. _exec-runtime-evaluation-contexts:

Evaluation Contexts
~~~~~~~~~~~~~~~~~~~

$${syntax: E}

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

.. _exec-runtime:

Runtime
-------

.. _exec-runtime-values:

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

%{prose-func: default}

\

$${definition: default}

.. _exec-runtime-results:

Results
~~~~~~~

.. _syntax-result:

$${syntax: result}

.. _syntax-store:
.. _exec-runtime-store:

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
.. _syntax-labeladdr:
.. _syntax-hostaddr:
.. _exec-runtime-addresses:

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
  labeladdr
  hostaddr
}

.. _syntax-moduleinst:
.. _exec-runtime-module-instances:

Module Instances
~~~~~~~~~~~~~~~~

$${syntax: moduleinst}

.. _syntax-funcinst:
.. _exec-runtime-function-instances:

Function Instances
~~~~~~~~~~~~~~~~~~

$${syntax: funcinst}

.. _syntax-tableinst:
.. _exec-runtime-table-instances:

Table Instances
~~~~~~~~~~~~~~~

$${syntax: tableinst}

.. _syntax-meminst:
.. _exec-runtime-memory-instances:

Memory Instances
~~~~~~~~~~~~~~~~

$${syntax: meminst}

.. _syntax-globalinst:
.. _exec-runtime-global-instances:

Global Instances
~~~~~~~~~~~~~~~~

$${syntax: globalinst}

.. _syntax-eleminst:
.. _exec-runtime-element-instances:

Element Instances
~~~~~~~~~~~~~~~~~

$${syntax: eleminst}

.. _syntax-datainst:
.. _exec-runtime-data-instances:

Data Instances
~~~~~~~~~~~~~~

$${syntax: datainst}

.. _syntax-exportinst:
.. _exec-runtime-export-instances:

Export Instances
~~~~~~~~~~~~~~~~

$${syntax: exportinst}

.. _syntax-externval:
.. _exec-runtime-external-values:

External Values
~~~~~~~~~~~~~~~

$${syntax: externval}

.. _def-funcsxv:

%{prose-func: funcsxv}

\

$${definition: funcsxv}

.. _def-tablesxv:

%{prose-func: tablesxv}

\

$${definition: tablesxv}

.. _def-memsxv:

%{prose-func: memsxv}

\

$${definition: memsxv}

.. _def-globalsxv:

%{prose-func: globalsxv}

\

$${definition: globalsxv}

.. _syntax-structinst:
.. _syntax-arrayinst:
.. _syntax-fieldval:
.. _syntax-packedval:
.. _exec-runtime-aggregate-instances:

Aggregate Instances
~~~~~~~~~~~~~~~~~~~

$${syntax+:
  structinst
  arrayinst
  fieldval
  packedval
}

.. _exec-runtime-stack:

Stack
~~~~~

.. _syntax-frame:

Activation Frames
.................

$${syntax: frame}

.. _syntax-admininstr:
.. _exec-runtime-administrative-instructions:

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

%{prose-func: store}

\

$${definition: store}

.. _def-frame:

%{prose-func: frame}

\

$${definition: frame}

$${rule+:
  Ref_ok/*
}

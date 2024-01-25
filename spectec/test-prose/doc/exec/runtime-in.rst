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

%{prose-func: default}

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

%{prose-func: moduleinst}

\

$${definition: moduleinst}

.. _syntax-funcinst:

Function Instances
~~~~~~~~~~~~~~~~~~

$${syntax: funcinst}

.. _def-funcinst:

%{prose-func: funcinst}

\

$${definition: funcinst}

.. _syntax-tableinst:

Table Instances
~~~~~~~~~~~~~~~

$${syntax: tableinst}

.. _def-tableinst:

%{prose-func: tableinst}

\

$${definition: tableinst}

.. _syntax-meminst:

Memory Instances
~~~~~~~~~~~~~~~~

$${syntax: meminst}

.. _def-meminst:

%{prose-func: meminst}

\

$${definition: meminst}

.. _syntax-globalinst:

Global Instances
~~~~~~~~~~~~~~~~

$${syntax: globalinst}

.. _def-globalinst:

%{prose-func: globalinst}

\

$${definition: globalinst}

.. _syntax-eleminst:

Element Instances
~~~~~~~~~~~~~~~~~

$${syntax: eleminst}

.. _def-eleminst:

%{prose-func: eleminst}

\

$${definition: eleminst}

.. _syntax-datainst:

Data Instances
~~~~~~~~~~~~~~

$${syntax: datainst}

.. _def-datainst:

%{prose-func: datainst}

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

.. _def-arrayinst:

%{prose-func: arrayinst}

\

$${definition: arrayinst}

.. _def-structinst:

%{prose-func: structinst}

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

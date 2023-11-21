.. _exec-runtime:

Runtime Structure
-----------------

Values
~~~~~~

.. _syntax-num:
<<<<<<< HEAD
.. _syntax-addrref:
.. _syntax-ref:
.. _syntax-val:
=======
.. _syntax-ref:
.. _syntax-val:

$${syntax+:
  num
  ref
  val
}

.. _def-default_:
>>>>>>> al

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

.. _def-size:

%{prose-func: size}

\

$${definition: size}

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
.. _syntax-labeladdr:
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
  labeladdr
  hostaddr
}

.. _syntax-moduleinst:

Module Instances
~~~~~~~~~~~~~~~~

$${syntax: moduleinst}

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

.. _def-Ki:

%{prose-func: Ki}

\

$${definition: Ki}

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

<<<<<<< HEAD
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
=======
.. _def-funcs:

%{prose-func: funcs}

\

$${definition: funcs}

.. _def-tables:

%{prose-func: tables}

\

$${definition: tables}

.. _def-mems:

%{prose-func: mems}

\

$${definition: mems}

.. _def-globals:

%{prose-func: globals}

\

$${definition: globals}
>>>>>>> al

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

<<<<<<< HEAD
.. _exec-runtime-typing:

Typing
~~~~~~
=======
Helper Functions
~~~~~~~~~~~~~~~~
>>>>>>> al

.. _def-store:

%{prose-func: store}

\

$${definition: store}

<<<<<<< HEAD
.. _def-frame:

%{prose-func: frame}

\

$${definition: frame}

$${rule+:
  Ref_ok/*
}
=======
.. _def-func:

%{prose-func: func}

\

$${definition: func}

.. _def-global:

%{prose-func: global}

\

$${definition: global}

.. _def-table:

%{prose-func: table}

\

$${definition: table}

.. _def-mem:

%{prose-func: mem}

\

$${definition: mem}

.. _def-elem:

%{prose-func: elem}

\

$${definition: elem}

.. _def-data:

%{prose-func: data}

\

$${definition: data}

.. _def-local:

%{prose-func: local}

\

$${definition: local}

.. _def-with_local:

%{prose-func: with_local}

\

$${definition: with_local}

.. _def-with_global:

%{prose-func: with_global}

\

$${definition: with_global}

.. _def-with_table:

%{prose-func: with_table}

\

$${definition: with_table}

.. _def-with_tableinst:

%{prose-func: with_tableinst}

\

$${definition: with_tableinst}

.. _def-with_mem:

%{prose-func: with_mem}

\

$${definition: with_mem}

.. _def-with_meminst:

%{prose-func: with_meminst}

\

$${definition: with_meminst}

.. _def-with_elem:

%{prose-func: with_elem}

\

$${definition: with_elem}

.. _def-with_data:

%{prose-func: with_data}

\

$${definition: with_data}
>>>>>>> al

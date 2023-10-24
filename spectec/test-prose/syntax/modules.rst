.. _syntax-modules:

Modules
-------

.. _syntax-module:

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{module} &::=& \mathsf{module}~{\mathit{import}^\ast}~{\mathit{func}^\ast}~{\mathit{global}^\ast}~{\mathit{table}^\ast}~{\mathit{mem}^\ast}~{\mathit{elem}^\ast}~{\mathit{data}^\ast}~{\mathit{start}^?}~{\mathit{export}^\ast} \\
   \end{array}

.. _syntax-idx:
.. _syntax-funcidx:
.. _syntax-globalidx:
.. _syntax-tableidx:
.. _syntax-memidx:
.. _syntax-elemidx:
.. _syntax-dataidx:
.. _syntax-labelidx:
.. _syntax-localidx:
.. _syntax-modules-indices:

Indices
~~~~~~~

.. math::
   \begin{array}{@{}lrrl@{}}
   \mbox{(index)} & \mathit{idx} &::=& \mathit{nat} \\[0.8ex]
   \mbox{(function index)} & \mathit{funcidx} &::=& \mathit{idx} \\[0.8ex]
   \mbox{(global index)} & \mathit{globalidx} &::=& \mathit{idx} \\[0.8ex]
   \mbox{(table index)} & \mathit{tableidx} &::=& \mathit{idx} \\[0.8ex]
   \mbox{(memory index)} & \mathit{memidx} &::=& \mathit{idx} \\[0.8ex]
   \mbox{(elem index)} & \mathit{elemidx} &::=& \mathit{idx} \\[0.8ex]
   \mbox{(data index)} & \mathit{dataidx} &::=& \mathit{idx} \\[0.8ex]
   \mbox{(label index)} & \mathit{labelidx} &::=& \mathit{idx} \\[0.8ex]
   \mbox{(local index)} & \mathit{localidx} &::=& \mathit{idx} \\
   \end{array}

.. _syntax-func:
.. _syntax-modules-functions:

Functions
~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{func} &::=& \mathsf{func}~\mathit{functype}~{\mathit{valtype}^\ast}~\mathit{expr} \\
   \end{array}

.. _syntax-table:
.. _syntax-modules-tables:

Tables
~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{table} &::=& \mathsf{table}~\mathit{tabletype} \\
   \end{array}

.. _syntax-mem:
.. _syntax-modules-memories:

Memories
~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{mem} &::=& \mathsf{memory}~\mathit{memtype} \\
   \end{array}

.. _syntax-global:
.. _syntax-modules-globals:

Globals
~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{global} &::=& \mathsf{global}~\mathit{globaltype}~\mathit{expr} \\
   \end{array}

.. _syntax-elem:
.. _syntax-modules-element-segments:

Element Segments
~~~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{elem} &::=& \mathsf{elem}~\mathit{reftype}~{\mathit{expr}^\ast}~{\mathit{elemmode}^?} \\
   \end{array}

.. _syntax-data:
.. _syntax-modules-data-segments:

Data Segments
~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{data} &::=& \mathsf{data}~{\mathit{byte}^\ast}~{\mathit{datamode}^?} \\
   \end{array}

.. _syntax-start:
.. _syntax-modules-start-function:

Start Function
~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{start} &::=& \mathsf{start}~\mathit{funcidx} \\
   \end{array}

.. _syntax-export:
.. _syntax-externuse:
.. _syntax-modules-exports:

Exports
~~~~~~~

.. math::
   \begin{array}{@{}lrrl@{}}
   \mbox{(export)} & \mathit{export} &::=& \mathsf{export}~\mathit{name}~\mathit{externuse} \\[0.8ex]
   \mbox{(external use)} & \mathit{externuse} &::=& \mathsf{func}~\mathit{funcidx} ~|~ \mathsf{global}~\mathit{globalidx} ~|~ \mathsf{table}~\mathit{tableidx} ~|~ \mathsf{mem}~\mathit{memidx} \\
   \end{array}

.. _syntax-import:
.. _syntax-modules-imports:

Imports
~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{import} &::=& \mathsf{import}~\mathit{name}~\mathit{name}~\mathit{externtype} \\
   \end{array}

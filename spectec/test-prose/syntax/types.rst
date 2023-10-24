.. _syntax-types:

Types
-----

.. _syntax-numtype:
.. _syntax-in:
.. _syntax-fn:
.. _syntax-types-number-types:

Number Types
~~~~~~~~~~~~

.. math::
   \begin{array}{@{}lrrl@{}}
   \mbox{(number type)} & \mathit{numtype} &::=& \mathsf{i{\scriptstyle32}} ~|~ \mathsf{i{\scriptstyle64}} ~|~ \mathsf{f{\scriptstyle32}} ~|~ \mathsf{f{\scriptstyle64}} \\[0.8ex]
   & {\mathsf{i}}{\mathit{n}} &::=& \mathsf{i{\scriptstyle32}} ~|~ \mathsf{i{\scriptstyle64}} \\
   & {\mathsf{f}}{\mathit{n}} &::=& \mathsf{f{\scriptstyle32}} ~|~ \mathsf{f{\scriptstyle64}} \\
   \end{array}

.. _syntax-vectype:
.. _syntax-types-vector-types:

Vector Types
~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{vectype} &::=& \mathsf{v{\scriptstyle128}} \\
   \end{array}

.. _syntax-reftype:
.. _syntax-types-reference-types:

Reference Types
~~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{reftype} &::=& \mathsf{funcref} ~|~ \mathsf{externref} \\
   \end{array}

.. _syntax-valtype:
.. _syntax-types-value-types:

Value Types
~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{valtype} &::=& \mathit{numtype} ~|~ \mathit{vectype} ~|~ \mathit{reftype} ~|~ \mathsf{bot} \\
   \end{array}

.. _syntax-resulttype:
.. _syntax-types-result-types:

Result Types
~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{resulttype} &::=& {\mathit{valtype}^\ast} \\
   \end{array}

.. _syntax-limits:
.. _syntax-types-limits:

Limits
~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{limits} &::=& [\mathit{u{\scriptstyle32}} .. \mathit{u{\scriptstyle32}}] \\
   \end{array}

.. _syntax-memtype:
.. _syntax-datatype:
.. _syntax-types-memory-types:

Memory Types
~~~~~~~~~~~~

.. math::
   \begin{array}{@{}lrrl@{}}
   \mbox{(memory type)} & \mathit{memtype} &::=& \mathit{limits}~\mathsf{i{\scriptstyle8}} \\[0.8ex]
   \mbox{(data type)} & \mathit{datatype} &::=& \mathsf{ok} \\
   \end{array}

.. _syntax-tabletype:
.. _syntax-elemtype:
.. _syntax-types-table-types:

Table Types
~~~~~~~~~~~

.. math::
   \begin{array}{@{}lrrl@{}}
   \mbox{(table type)} & \mathit{tabletype} &::=& \mathit{limits}~\mathit{reftype} \\[0.8ex]
   \mbox{(element type)} & \mathit{elemtype} &::=& \mathit{reftype} \\
   \end{array}

.. _syntax-globaltype:
.. _syntax-types-global-types:

Global Types
~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{globaltype} &::=& {\mathsf{mut}^?}~\mathit{valtype} \\
   \end{array}

.. _syntax-functype:
.. _syntax-types-function-types:

Function Types
~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{functype} &::=& \mathit{resulttype} \rightarrow \mathit{resulttype} \\
   \end{array}

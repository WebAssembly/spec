.. _binary-type:
.. index:: type
   pair: binary format; type
   single: abstract syntax; type

Types
-----

.. _binary-valtype:
.. index:: value type
   pair: binary format; value type
   single: abstract syntax; value type

Value Types
~~~~~~~~~~~

:ref:`Value types <syntax-valtype>` are encoded by a single byte.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{value types} & \Bvaltype &::=&
     \hex{7F} &\Rightarrow& \I32 \\ &&|&
     \hex{7E} &\Rightarrow& \I64 \\ &&|&
     \hex{7D} &\Rightarrow& \F32 \\ &&|&
     \hex{7C} &\Rightarrow& \F64 \\
   \end{array}

.. note::
   In future versions of WebAssembly, value types may include types denoted by :ref:`type indices <syntax-typeidx>`.
   Thus, the binary format for types corresponds to the encodings of small negative :math:`\xref{binary/values}{binary-sint}{\sX{}}` values, so that they can coexist with (positive) type indices.


.. _binary-resulttype:
.. index:: result type, value type
   pair: binary format; result type
   single: abstract syntax; result type

Result Types
~~~~~~~~~~~~

:ref:`Result types <syntax-resulttype>` are encoded by either the byte :math:`\hex{40}` indicating the empty type or as a single :ref:`value type <binary-valtype>`.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{result types} & \Bresulttype &::=&
     \hex{40} &\Rightarrow& [] \\ &&|&
     t{:}\Bvaltype &\Rightarrow& [t] \\
   \end{array}

.. note::
   In future versions of WebAssembly, this scheme may be extended to support multiple results.


.. _binary-functype:
.. index:: function type, value type, result type
   pair: binary format; function type
   single: abstract syntax; function type

Function Types
~~~~~~~~~~~~~~

:ref:`Function types <syntax-functype>` are encoded by the byte :math:`\hex{60}` followed by the respective :ref:`vectors <binary-vec>` of parameter and result types.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{function types} & \Bfunctype &::=&
     \hex{60}~~t_1^\ast{:\,}\Bvec(\Bvaltype)~~t_2^\ast{:\,}\Bvec(\Bvaltype)
       &\Rightarrow& [t_1^\ast] \to [t_2^\ast] \\
   \end{array}


.. _binary-limits:
.. index:: limits
   pair: binary format; limits
   single: abstract syntax; limits

Limits
~~~~~~

:ref:`Limits <syntax-limits>` are encoded with a preceding flag indicating whether a maximum is present.

.. math::
   \begin{array}{llclll}
   \production{limits} & \Blimits &::=&
     \hex{00}~~n{:}\Bu32 &\Rightarrow& \{ \MIN~n, \MAX~\epsilon \} \\ &&|&
     \hex{01}~~n{:}\Bu32~~m{:}\Bu32 &\Rightarrow& \{ \MIN~n, \MAX~m \} \\
   \end{array}


.. _binary-memtype:
.. index:: memory type, limits, page size
   single: binary format; memory type
   pair: abstract syntax; memory type

Memory Types
~~~~~~~~~~~~

:ref:`Memory types <syntax-memtype>` are encoded with their :ref:`limits <binary-limits>`.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{memory types} & \Bmemtype &::=&
     \X{lim}{:}\Blimits &\Rightarrow& \X{lim} \\
   \end{array}


.. _syntax-tabletype:
.. _syntax-elemtype:
.. index:: table type, element type, limits
   pair: binary format; table type
   pair: binary format; element type
   single: abstract syntax; table type
   single: abstract syntax; element type

Table Types
~~~~~~~~~~~

:ref:`Table types <syntax-tabletype>` are encoded with their :ref:`limits <binary-limits>` and a constant byte indicating their :ref:`element type <syntax-elemtype>`.

.. math::
   \begin{array}{llclll}
   \production{table types} & \Btabletype &::=&
     \X{et}{:}\Belemtype~~\X{lim}{:}\Blimits &\Rightarrow& \X{lim}~\X{et} \\
   \production{element types} & \Belemtype &::=&
     \hex{70} &\Rightarrow& \ANYFUNC \\
   \end{array}


.. _binary-globaltype:
.. index:: global type, mutability, value type
   pair: binary format; global type
   pair: binary format; mutability
   single: abstract syntax; global type
   single: abstract syntax; mutability

Global Types
~~~~~~~~~~~~

:ref:`Global types <syntax-globaltype>` are encoded by their :ref:`value type <binary-valtype>` and a flag for their :ref:`mutability <syntax-mut>`.

.. math::
   \begin{array}{llclll}
   \production{global types} & \Bglobaltype &::=&
     t{:}\Bvaltype~~m{:}\Bmut &\Rightarrow& m~t \\
   \production{mutability} & \Bmut &::=&
     \hex{00} &\Rightarrow& \CONST \\ &&|&
     \hex{01} &\Rightarrow& \MUT \\
   \end{array}

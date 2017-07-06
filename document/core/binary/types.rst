.. index:: type
   pair: binary format; type
.. _binary-type:

Types
-----

.. index:: value type
   pair: binary format; value type
.. _binary-valtype:

Value Types
~~~~~~~~~~~

:ref:`Value types <syntax-valtype>` are encoded by a single byte.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{value type} & \Bvaltype &::=&
     \hex{7F} &\Rightarrow& \I32 \\ &&|&
     \hex{7E} &\Rightarrow& \I64 \\ &&|&
     \hex{7D} &\Rightarrow& \F32 \\ &&|&
     \hex{7C} &\Rightarrow& \F64 \\
   \end{array}

.. note::
   In future versions of WebAssembly, value types may include types denoted by :ref:`type indices <syntax-typeidx>`.
   Thus, the binary format for types corresponds to the encodings of small negative :math:`\xref{binary/values}{binary-sint}{\sN}` values, so that they can coexist with (positive) type indices in the future.


.. index:: result type, value type
   pair: binary format; result type
.. _binary-blocktype:
.. _binary-resulttype:

Result Types
~~~~~~~~~~~~

The only :ref:`result types <syntax-resulttype>` occurring in the binary format are the types of blocks. These are encoded in special compressed form, by either the byte :math:`\hex{40}` indicating the empty type or as a single :ref:`value type <binary-valtype>`.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{result type} & \Bblocktype &::=&
     \hex{40} &\Rightarrow& [] \\ &&|&
     t{:}\Bvaltype &\Rightarrow& [t] \\
   \end{array}

.. note::
   In future versions of WebAssembly, this scheme may be extended to support multiple results or more general block types.


.. index:: function type, value type, result type
   pair: binary format; function type
.. _binary-functype:

Function Types
~~~~~~~~~~~~~~

:ref:`Function types <syntax-functype>` are encoded by the byte :math:`\hex{60}` followed by the respective :ref:`vectors <binary-vec>` of parameter and result types.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{function type} & \Bfunctype &::=&
     \hex{60}~~t_1^\ast{:\,}\Bvec(\Bvaltype)~~t_2^\ast{:\,}\Bvec(\Bvaltype)
       &\Rightarrow& [t_1^\ast] \to [t_2^\ast] \\
   \end{array}


.. index:: limits
   pair: binary format; limits
.. _binary-limits:

Limits
~~~~~~

:ref:`Limits <syntax-limits>` are encoded with a preceding flag indicating whether a maximum is present.

.. math::
   \begin{array}{llclll}
   \production{limits} & \Blimits &::=&
     \hex{00}~~n{:}\Bu32 &\Rightarrow& \{ \LMIN~n, \LMAX~\epsilon \} \\ &&|&
     \hex{01}~~n{:}\Bu32~~m{:}\Bu32 &\Rightarrow& \{ \LMIN~n, \LMAX~m \} \\
   \end{array}


.. index:: memory type, limits, page size
   pair: binary format; memory type
.. _binary-memtype:

Memory Types
~~~~~~~~~~~~

:ref:`Memory types <syntax-memtype>` are encoded with their :ref:`limits <binary-limits>`.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{memory type} & \Bmemtype &::=&
     \X{lim}{:}\Blimits &\Rightarrow& \X{lim} \\
   \end{array}


.. index:: table type, element type, limits
   pair: binary format; table type
   pair: binary format; element type
.. _binary-elemtype:
.. _binary-tabletype:

Table Types
~~~~~~~~~~~

:ref:`Table types <syntax-tabletype>` are encoded with their :ref:`limits <binary-limits>` and a constant byte indicating their :ref:`element type <syntax-elemtype>`.

.. math::
   \begin{array}{llclll}
   \production{table type} & \Btabletype &::=&
     \X{et}{:}\Belemtype~~\X{lim}{:}\Blimits &\Rightarrow& \X{lim}~\X{et} \\
   \production{element type} & \Belemtype &::=&
     \hex{70} &\Rightarrow& \ANYFUNC \\
   \end{array}


.. index:: global type, mutability, value type
   pair: binary format; global type
   pair: binary format; mutability
.. _binary-mut:
.. _binary-globaltype:

Global Types
~~~~~~~~~~~~

:ref:`Global types <syntax-globaltype>` are encoded by their :ref:`value type <binary-valtype>` and a flag for their :ref:`mutability <syntax-mut>`.

.. math::
   \begin{array}{llclll}
   \production{global type} & \Bglobaltype &::=&
     t{:}\Bvaltype~~m{:}\Bmut &\Rightarrow& m~t \\
   \production{mutability} & \Bmut &::=&
     \hex{00} &\Rightarrow& \MCONST \\ &&|&
     \hex{01} &\Rightarrow& \MVAR \\
   \end{array}

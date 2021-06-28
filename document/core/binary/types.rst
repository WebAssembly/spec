.. index:: type
   pair: binary format; type
.. _binary-type:

Types
-----

.. note::
   In some places, possible types include both type constructors or types denoted by :ref:`type indices <syntax-typeidx>`.
   Thus, the binary format for type constructors corresponds to the encodings of small negative :math:`\xref{binary/values}{binary-sint}{\sN}` values, such that they can unambiguously occur in the same place as (positive) type indices.


.. index:: number type
   pair: binary format; number type
.. _binary-numtype:

Number Types
~~~~~~~~~~~~

:ref:`Number types <syntax-numtype>` are encoded by a single byte.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{number type} & \Bnumtype &::=&
     \hex{7F} &\Rightarrow& \I32 \\ &&|&
     \hex{7E} &\Rightarrow& \I64 \\ &&|&
     \hex{7D} &\Rightarrow& \F32 \\ &&|&
     \hex{7C} &\Rightarrow& \F64 \\
   \end{array}


.. index:: reference type
   pair: binary format; reference type
.. _binary-reftype:

Reference Types
~~~~~~~~~~~~~~~

:ref:`Reference types <syntax-reftype>` are also encoded by a single byte.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{reference type} & \Breftype &::=&
     \hex{70} &\Rightarrow& \FUNCREF \\ &&|&
     \hex{6F} &\Rightarrow& \EXTERNREF \\
   \end{array}


.. index:: value type, number type, reference type
   pair: binary format; value type
.. _binary-valtype:

Value Types
~~~~~~~~~~~

:ref:`Value types <syntax-valtype>` are encoded with their respective encoding as a :ref:`number type <binary-numtype>` or :ref:`reference type <binary-reftype>`.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{value type} & \Bvaltype &::=&
     t{:}\Bnumtype &\Rightarrow& t \\ &&|&
     t{:}\Breftype &\Rightarrow& t \\
   \end{array}

.. note::
   Value types can occur in contexts where :ref:`type indices <syntax-typeidx>` are also allowed, such as in the case of :ref:`block types <binary-blocktype>`.
   Thus, the binary format for types corresponds to the |SignedLEB128|_ :ref:`encoding <binary-sint>` of small negative :math:`\sN` values, so that they can coexist with (positive) type indices in the future.


.. index:: result type, value type
   pair: binary format; result type
.. _binary-resulttype:

Result Types
~~~~~~~~~~~~

:ref:`Result types <syntax-resulttype>` are encoded by the respective :ref:`vectors <binary-vec>` of :ref:`value types `<binary-valtype>`.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{result type} & \Bresulttype &::=&
     t^\ast{:\,}\Bvec(\Bvaltype) &\Rightarrow& [t^\ast] \\
   \end{array}


.. index:: function type, value type, result type
   pair: binary format; function type
.. _binary-functype:

Function Types
~~~~~~~~~~~~~~

:ref:`Function types <syntax-functype>` are encoded by the byte :math:`\hex{60}` followed by the respective :ref:`vectors <binary-vec>` of parameter and result types.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{function type} & \Bfunctype &::=&
     \hex{60}~~\X{rt}_1{:\,}\Bresulttype~~\X{rt}_2{:\,}\Bresulttype
       &\Rightarrow& \X{rt}_1 \to \X{rt}_2 \\
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


.. index:: table type, reference type, limits
   pair: binary format; table type
.. _binary-tabletype:

Table Types
~~~~~~~~~~~

:ref:`Table types <syntax-tabletype>` are encoded with their :ref:`limits <binary-limits>` and the encoding of their element :ref:`reference type <syntax-reftype>`.

.. math::
   \begin{array}{llclll}
   \production{table type} & \Btabletype &::=&
     \X{et}{:}\Breftype~~\X{lim}{:}\Blimits &\Rightarrow& \X{lim}~\X{et} \\
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

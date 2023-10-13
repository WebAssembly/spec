.. index:: type
   pair: text format; type
.. _text-type:

Types
-----

.. index:: number type
   pair: text format; number type
.. _text-numtype:

Number Types
~~~~~~~~~~~~

.. math::
   \begin{array}{llcll@{\qquad\qquad}l}
   \production{number type} & \Tnumtype_I &::=&
     \text{i32} &\Rightarrow& \I32 \\ &&|&
     \text{i64} &\Rightarrow& \I64 \\ &&|&
     \text{f32} &\Rightarrow& \F32 \\ &&|&
     \text{f64} &\Rightarrow& \F64 \\
   \end{array}


.. index:: vector type
   pair: text format; vector type
.. _text-vectype:

Vector Types
~~~~~~~~~~~~

.. math::
   \begin{array}{llcll@{\qquad\qquad}l}
   \production{vector type} & \Tvectype_I &::=&
     \text{v128} &\Rightarrow& \V128 \\
   \end{array}


.. index:: heap type
   pair: text format; heap type
.. _text-heaptype:

Heap Types
~~~~~~~~~~

.. math::
   \begin{array}{llcll@{\qquad\qquad}l}
   \production{heap type} & \Theaptype_I &::=&
     \text{func} &\Rightarrow& \FUNC \\ &&|&
     \text{extern} &\Rightarrow& \EXTERN \\ &&|&
     x{:}\Ttypeidx_I &\Rightarrow& x \\
   \end{array}


.. index:: reference type
   pair: text format; reference type
.. _text-reftype:

Reference Types
~~~~~~~~~~~~~~~

.. math::
   \begin{array}{llcll@{\qquad\qquad}l}
   \production{reference type} & \Treftype_I &::=&
     \text{(}~\text{ref}~~\X{ht}{:}\Theaptype~\text{)}
       &\Rightarrow& \REF~\X{ht} \\ &&|&
     \text{(}~\text{ref}~~\text{null}~~\X{ht}{:}\Theaptype~\text{)}
       &\Rightarrow& \REF~\NULL~\X{ht} \\
   \end{array}

Abbreviations
.............

There are shorthands for references to abstract heap types.

.. math::
   \begin{array}{llclll}
   \production{reference type} &
     \text{funcref} &\equiv& \text{(}~\text{ref}~~\text{null}~~\text{func}~\text{)} \\
     \text{externref} &\equiv& \text{(}~\text{ref}~~\text{null}~~\text{extern}~\text{)} \\
   \end{array}


.. index:: value type, number type, vector type, reference type
   pair: text format; value type
.. _text-valtype:

Value Types
~~~~~~~~~~~

.. math::
   \begin{array}{llcll@{\qquad\qquad}l}
   \production{value type} & \Tvaltype_I &::=&
     t{:}\Tnumtype_I &\Rightarrow& t \\ &&|&
     t{:}\Tvectype_I &\Rightarrow& t \\ &&|&
     t{:}\Treftype_I &\Rightarrow& t \\
   \end{array}


.. index:: function type, value type, result type
   pair: text format; function type
.. _text-param:
.. _text-result:
.. _text-functype:

Function Types
~~~~~~~~~~~~~~

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{function type} & \Tfunctype_I &::=&
     \text{(}~\text{func}~~t_1^\ast{:\,}\Tvec(\Tparam_I)~~t_2^\ast{:\,}\Tvec(\Tresult_I)~\text{)}
       &\Rightarrow& [t_1^\ast] \to [t_2^\ast] \\
   \production{parameter} & \Tparam_I &::=&
     \text{(}~\text{param}~~\Tid^?~~t{:}\Tvaltype_I~\text{)}
       &\Rightarrow& t \\
   \production{result} & \Tresult_I &::=&
     \text{(}~\text{result}~~t{:}\Tvaltype_I~\text{)}
       &\Rightarrow& t \\
   \end{array}

.. note::
   The optional identifier names for parameters in a function type only have documentation purpose.
   They cannot be referenced from anywhere.


Abbreviations
.............

Multiple anonymous parameters or results may be combined into a single declaration:

.. math::
   \begin{array}{llclll}
   \production{parameter} &
     \text{(}~~\text{param}~~\Tvaltype^\ast~~\text{)} &\equiv&
     (\text{(}~~\text{param}~~\Tvaltype~~\text{)})^\ast \\
   \production{result} &
     \text{(}~~\text{result}~~\Tvaltype^\ast~~\text{)} &\equiv&
     (\text{(}~~\text{result}~~\Tvaltype~~\text{)})^\ast \\
   \end{array}


.. index:: limits
   pair: text format; limits
.. _text-limits:

Limits
~~~~~~

.. math::
    \begin{array}{llclll}
    \production{limits} & \Tlimits &::=&
      n{:}\Tu32 &\Rightarrow& \{ \LMIN~n, \LMAX~\epsilon \} \\ &&|&
      n{:}\Tu32~~m{:}\Tu32 &\Rightarrow& \{ \LMIN~n, \LMAX~m \} \\
    \end{array}


.. index:: memory type, limits, page size
   pair: text format; memory type
.. _text-memtype:

Memory Types
~~~~~~~~~~~~

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{memory type} & \Tmemtype_I &::=&
     \X{lim}{:}\Tlimits &\Rightarrow& \X{lim} \\
   \end{array}


.. index:: table type, reference type, limits
   pair: text format; table type
.. _text-tabletype:

Table Types
~~~~~~~~~~~

.. math::
   \begin{array}{llclll}
   \production{table type} & \Ttabletype_I &::=&
     \X{lim}{:}\Tlimits~~\X{et}{:}\Treftype_I &\Rightarrow& \X{lim}~\X{et} \\
   \end{array}


.. index:: global type, mutability, value type
   pair: text format; global type
   pair: text format; mutability
.. _text-globaltype:

Global Types
~~~~~~~~~~~~

.. math::
   \begin{array}{llclll}
   \production{global type} & \Tglobaltype_I &::=&
     t{:}\Tvaltype &\Rightarrow& \MCONST~t \\ &&|&
     \text{(}~\text{mut}~~t{:}\Tvaltype_I~\text{)} &\Rightarrow& \MVAR~t \\
   \end{array}

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
   \production{number type} & \Tnumtype &::=&
     \text{i32} &\Rightarrow& \I32 \\ &&|&
     \text{i64} &\Rightarrow& \I64 \\ &&|&
     \text{f32} &\Rightarrow& \F32 \\ &&|&
     \text{f64} &\Rightarrow& \F64 \\
   \end{array}


.. index:: reference type
   pair: text format; reference type
.. _text-reftype:
.. _text-heaptype:

Reference Types
~~~~~~~~~~~~~~~

.. math::
   \begin{array}{llcll@{\qquad\qquad}l}
   \production{reference type} & \Treftype &::=&
     \text{funcref} &\Rightarrow& \FUNCREF \\ &&|&
     \text{externref} &\Rightarrow& \EXTERNREF \\
   \production{heap type} & \Theaptype &::=&
     \text{func} &\Rightarrow& \FUNCREF \\ &&|&
     \text{extern} &\Rightarrow& \EXTERNREF \\
   \end{array}


.. index:: value type, number type, reference type
   pair: text format; value type
.. _text-valtype:

Value Types
~~~~~~~~~~~

.. math::
   \begin{array}{llcll@{\qquad\qquad}l}
   \production{value type} & \Tvaltype &::=&
     t{:}\Tnumtype &\Rightarrow& t \\ &&|&
     t{:}\Treftype &\Rightarrow& t \\
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
   \production{function type} & \Tfunctype &::=&
     \text{(}~\text{func}~~t_1^\ast{:\,}\Tvec(\Tparam)~~t_2^\ast{:\,}\Tvec(\Tresult)~\text{)}
       &\Rightarrow& [t_1^\ast] \to [t_2^\ast] \\
   \production{parameter} & \Tparam &::=&
     \text{(}~\text{param}~~\Tid^?~~t{:}\Tvaltype~\text{)}
       &\Rightarrow& t \\
   \production{result} & \Tresult &::=&
     \text{(}~\text{result}~~t{:}\Tvaltype~\text{)}
       &\Rightarrow& t \\
   \end{array}


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
   \production{memory type} & \Tmemtype &::=&
     \X{lim}{:}\Tlimits &\Rightarrow& \X{lim} \\
   \end{array}


.. index:: table type, reference type, limits
   pair: text format; table type
.. _text-tabletype:

Table Types
~~~~~~~~~~~

.. math::
   \begin{array}{llclll}
   \production{table type} & \Ttabletype &::=&
     \X{lim}{:}\Tlimits~~\X{et}{:}\Treftype &\Rightarrow& \X{lim}~\X{et} \\
   \end{array}


.. index:: global type, mutability, value type
   pair: text format; global type
   pair: text format; mutability
.. _text-globaltype:

Global Types
~~~~~~~~~~~~

.. math::
   \begin{array}{llclll}
   \production{global type} & \Tglobaltype &::=&
     t{:}\Tvaltype &\Rightarrow& \MCONST~t \\ &&|&
     \text{(}~\text{mut}~~t{:}\Tvaltype~\text{)} &\Rightarrow& \MVAR~t \\
   \end{array}

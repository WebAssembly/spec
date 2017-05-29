.. _text-type:
.. index:: type
   pair: text format; type

Types
-----

.. _text-valtype:
.. index:: value type
   pair: text format; value type

Value Types
~~~~~~~~~~~

.. math::
   \begin{array}{llcll@{\qquad\qquad}l}
   \production{value type} & \Tvaltype &::=&
     \text{i32} &\Rightarrow& \I32 \\ &&|&
     \text{i64} &\Rightarrow& \I64 \\ &&|&
     \text{f32} &\Rightarrow& \F32 \\ &&|&
     \text{f64} &\Rightarrow& \F64 \\
   \end{array}


.. _text-resulttype:
.. index:: result type, value type
   pair: text format; result type

Result Types
~~~~~~~~~~~~

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{result type} & \Tresulttype &::=&
     (t{:}\Tresult)^? &\Rightarrow& [t^?] \\
   \end{array}

.. note::
   In future versions of WebAssembly, this scheme may be extended to support multiple results or more general result types.


.. _text-functype:
.. _text-param:
.. _text-result:
.. index:: function type, value type, result type
   pair: text format; function type

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


.. _text-limits:
.. index:: limits
   pair: text format; limits

Limits
~~~~~~

.. math::
    \begin{array}{llclll}
    \production{limits} & \Tlimits &::=&
      n{:}\Tu32 &\Rightarrow& \{ \MIN~n, \MAX~\epsilon \} \\ &&|&
      n{:}\Tu32~~m{:}\Tu32 &\Rightarrow& \{ \MIN~n, \MAX~m \} \\
    \end{array}


.. _text-memtype:
.. index:: memory type, limits, page size
   pair: text format; memory type

Memory Types
~~~~~~~~~~~~

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{memory type} & \Tmemtype &::=&
     \X{lim}{:}\Tlimits &\Rightarrow& \X{lim} \\
   \end{array}


.. _text-tabletype:
.. _text-elemtype:
.. index:: table type, element type, limits
   pair: text format; table type
   pair: text format; element type

Table Types
~~~~~~~~~~~

.. math::
   \begin{array}{llclll}
   \production{table type} & \Ttabletype &::=&
     \X{lim}{:}\Tlimits~~\X{et}{:}\Telemtype &\Rightarrow& \X{lim}~\X{et} \\
   \production{element type} & \Telemtype &::=&
     \text{anyfunc} &\Rightarrow& \ANYFUNC \\
   \end{array}

.. note::
   Additional element types may be introduced in future versions of WebAssembly.


.. _text-globaltype:
.. index:: global type, mutability, value type
   pair: text format; global type
   pair: text format; mutability

Global Types
~~~~~~~~~~~~

.. math::
   \begin{array}{llclll}
   \production{global type} & \Tglobaltype &::=&
     t{:}\Tvaltype &\Rightarrow& \MCONST~t \\ &&|&
     \text{(}~\text{mut}~~t{:}\Tvaltype~\text{)} &\Rightarrow& \MVAR~t \\
   \end{array}

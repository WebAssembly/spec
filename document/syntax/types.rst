.. _syntax-type:
.. index:: ! type
   pair: abstract syntax; type

Types
-----


.. _syntax-valtype:
.. index:: ! value type
   pair: abstract syntax; value type
   pair: value; type

Value Types
~~~~~~~~~~~

*Value types* classify the individual values that WebAssembly code can compute with and the values that a variable accepts.

.. math::
   \begin{array}{llll}
   \production{value type} & \valtype &::=&
     \I32 ~|~ \I64 ~|~ \F32 ~|~ \F64 \\
   \end{array}

The types |I32| and |I64| classify 32 and 64 bit integers, respectively.
Integers are not inherently signed or unsigned, their interpretation is determined by individual operations.

The types |F32| and |F64| classify 32 and 64 bit floating points, respectively.
They correspond to single and double precision floating point types as defined by the `IEEE-754 <http://ieeexplore.ieee.org/document/4610935/>`_ standard

Conventions
...........

* The meta variable :math:`t` ranges over value types where clear from context.

* The notation :math:`|t|` denotes the *width* of a value type.
  (That is, :math:`|\I32| = |\F32| = 32` and :math:`|\I64| = |\F64| = 64`.)


.. _syntax-resulttype:
.. index:: ! result type, value type
   pair: abstract syntax; result type
   pair: result; type

Result Types
~~~~~~~~~~~~

*Result types* classify the results of functions or blocks,
which is a sequence of values.

.. math::
   \begin{array}{llll}
   \production{result type} & \resulttype &::=&
     [\valtype^?] \\
   \end{array}

.. note::
   In the current version of WebAssembly, at most one value is allowed as a result.
   However, this may be generalized to sequences of values in future versions.


.. _syntax-functype:
.. index:: ! function type, value type, result type
   pair: abstract syntax; function type
   pair: function; type

Function Types
~~~~~~~~~~~~~~

*Function types* classify the signature of functions,
mapping a vector of parameters to a vector of results.

.. math::
   \begin{array}{llll}
   \production{function type} & \functype &::=&
     [\vec(\valtype)] \to [\vec(\valtype)] \\
   \end{array}

.. note::
   In the current version of WebAssembly,
   the length of the result type vector of a :ref:`valid <valid-functype>` function type may be at most :math:`1`.
   This restriction may be removed in future versions.


.. _syntax-limits:
.. index:: ! limits, memory type, table type
   pair: abstract syntax; limits
   single: memory; limits
   single: table; limits

Limits
~~~~~~

*Limits* classify the size range of resizeable storage like associated with :ref:`memory types <syntax-memtype>` and :ref:`table types <syntax-tabletype>`.

.. math::
   \begin{array}{llll}
   \production{limits} & \limits &::=&
     \{ \MIN~\u32, \MAX~\u32^? \} \\
   \end{array}

If no maximum is given, the respective storage can grow to any size.


.. _syntax-memtype:
.. index:: ! memory type, limits, page size
   pair: abstract syntax; memory type
   pair: memory; type
   pair: memory; limits

Memory Types
~~~~~~~~~~~~

*Memory types* classify linear memories and their size range.

.. math::
   \begin{array}{llll}
   \production{memory type} & \memtype &::=&
     \limits \\
   \end{array}

The limits constrain the minimum and optionally the maximum size of a memory.
The limits are given in units of :ref:`page size <page-size>`.


.. _syntax-tabletype:
.. _syntax-elemtype:
.. index:: ! table type, ! element type, limits
   pair: abstract syntax; table type
   pair: abstract syntax; element type
   pair: table; type
   pair: table; limits
   pair: element; type

Table Types
~~~~~~~~~~~

*Table types* classify tables over elements of *element types* within a given size range.

.. math::
   \begin{array}{llll}
   \production{table type} & \tabletype &::=&
     \limits~\elemtype \\
   \production{element type} & \elemtype &::=&
     \ANYFUNC \\
   \end{array}

Like memories, tables are constrained by limits for their minimum and optionally maximum size.
The limits are given in numbers of entries.

The element type |ANYFUNC| is the infinite union of all `function types`.
A table of that type thus contains references to functions of heterogeneous type.

.. note::
   In future versions of WebAssembly, additional element types may be introduced.


.. _syntax-globaltype:
.. _syntax-mut:
.. index:: ! global type, ! mutability, value type
   pair: abstract syntax; global type
   pair: abstract syntax; mutability
   pair: global; type
   pair: global; mutability

Global Types
~~~~~~~~~~~~

*Global types* classify global variables, which hold a value and can either be mutable or immutable.

.. math::
   \begin{array}{llll}
   \production{global type} & \globaltype &::=&
     \mut^?~\valtype \\
   \production{mutability} & \mut &::=&
     \MCONST ~|~
     \MVAR \\
   \end{array}

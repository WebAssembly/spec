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
   \production{value types} & \valtype &::=&
     \I32 ~|~ \I64 ~|~ \F32 ~|~ \F64 \\
   \end{array}

The types |i32| and |i64| classify 32 and 64 bit integers, respectively.
Integers are not inherently signed or unsigned, their interpretation is determined by individual operations.

The types |f32| and |f64| classify 32 and 64 bit floating points, respectively.
They correspond to single and double precision floating point types as defined by the `IEEE-754 <http://ieeexplore.ieee.org/document/4610935/>`_ standard

Conventions
...........

* The meta variable :math:`t` ranges over value types where clear from context.


.. _syntax-resulttype:
.. index:: ! result type
   pair: abstract syntax; result type
   pair: result; type

Result Types
~~~~~~~~~~~~

*Result types* classify the results of functions or blocks,
which is a sequence of values.

.. math::
   \begin{array}{llll}
   \production{result types} & \resulttype &::=&
     \valtype^? \\
   \end{array}

.. note::
   In the current version of WebAssembly, at most one value is allowed as a result.
   However, this may be generalized to sequences of values in future versions.


.. _syntax-functype:
.. index:: ! function type
   pair: abstract syntax; function type
   pair: function; type

Function Types
~~~~~~~~~~~~~~

*Function types* classify the signature of functions,
mapping a sequence of parameters to a sequence of results.

.. math::
   \begin{array}{llll}
   \production{function types} & \functype &::=&
     \valtype^\ast \to \resulttype \\
   \end{array}


.. _syntax-memtype:
.. _syntax-limits:
.. index:: ! memory type; ! limits
   pair: abstract syntax; memory type
   pair: abstract syntax; limits
   pair: memory; type
   pair: memory; limits

Memory Types
~~~~~~~~~~~~

*Memory types* classify linear memories and their size range.

.. math::
   \begin{array}{llll}
   \production{memory types} & \memtype &::=&
     \limits \\
   \production{limits} & \limits &::=&
     \{ \MIN~\u32, \MAX~\u32^? \} \\
   \end{array}

The limits constrain the minimum and optionally the maximum size of a table.
If no maximum is given, the table can grow to any size.
Both values are given in units of :ref:`page size <page-size>`.


.. _syntax-tabletype:
.. _syntax-elemtype:
.. index:: ! table type; ! element type
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
   \production{table types} & \tabletype &::=&
     \limits~\elemtype \\
   \production{element types} & \elemtype &::=&
     \ANYFUNC \\
   \end{array}

Like memories, tables are constrained by limits for their minimum and optionally the maximum size.
These sizes are given in numbers of entries.

The element type |ANYFUNC| is the infinite union of all `function types`.
A table of that type thus contains references to functions of heterogeneous type.

.. note::
   In future versions of WebAssembly, additional element types may be introduced.


.. _syntax-globaltype:
.. index:: ! global type
   pair: abstract syntax; global type
   pair: abstract syntax; mutability
   pair: global; type
   pair: global; mutability

Global Types
~~~~~~~~~~~~

*Global types* classify global variables, which hold a value and can either be mutable or immutable.

.. math::
   \begin{array}{llll}
   \production{global types} & \globaltype &::=&
     \MUT^?~\valtype \\
   \end{array}


.. _syntax-externtype:
.. index:: ! external type
   pair: abstract syntax; external type
   pair: external; type

External Types
~~~~~~~~~~~~~~

*External types* classify imports and exports and their respective types.

.. math::
   \begin{array}{llll}
   \production{external types} & \externtype &::=&
     \FUNC~\functype ~|~ \\&&&
     \TABLE~\tabletype ~|~ \\&&&
     \MEM~\memtype ~|~ \\&&&
     \GLOBAL~\globaltype \\
   \end{array}

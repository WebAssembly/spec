.. index:: ! type, validation, instantiation, execution
   pair: abstract syntax; type
.. _syntax-type:

Types
-----

Various entitites in WebAssembly are classified by types.
Types are checked during :ref:`validation <valid>`, :ref:`instantiation <exec-instantiation>`, and possibly :ref:`execution <syntax-call_indirect>`.


.. index:: ! value type, integer, floating-point, IEEE 754, bit width
   pair: abstract syntax; value type
   pair: value; type
.. _syntax-valtype:

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

The types |F32| and |F64| classify 32 and 64 bit floating-point data, respectively.
They correspond to the respective binary floating-point representations, also known as *single* and *double* precision, as defined by the |IEEE754|_ standard (Section 3.3).

Conventions
...........

* The meta variable :math:`t` ranges over value types where clear from context.

* The notation :math:`|t|` denotes the *bit width* of a value type.
  That is, :math:`|\I32| = |\F32| = 32` and :math:`|\I64| = |\F64| = 64`.


.. index:: ! result type, value type, instruction, execution, block
   pair: abstract syntax; result type
   pair: result; type
.. _syntax-resulttype:

Result Types
~~~~~~~~~~~~

*Result types* classify the result of :ref:`executing <exec-instr>` :ref:`instructions <syntax-instr>` or :ref:`blocks <syntax-instr-control>`,
which is a sequence of values.

.. math::
   \begin{array}{llll}
   \production{result type} & \resulttype &::=&
     [\valtype^?] \\
   \end{array}

.. note::
   In the current version of WebAssembly, at most one value is allowed as a result.
   However, this may be generalized to sequences of values in future versions.


.. index:: ! function type, value type, vector, function, parameter, result
   pair: abstract syntax; function type
   pair: function; type
.. _syntax-functype:

Function Types
~~~~~~~~~~~~~~

*Function types* classify the signature of :ref:`functions <syntax-func>`,
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


.. index:: ! limits, memory type, table type
   pair: abstract syntax; limits
   single: memory; limits
   single: table; limits
.. _syntax-limits:

Limits
~~~~~~

*Limits* classify the size range of resizeable storage associated with :ref:`memory types <syntax-memtype>` and :ref:`table types <syntax-tabletype>`.

.. math::
   \begin{array}{llll}
   \production{limits} & \limits &::=&
     \{ \LMIN~\u32, \LMAX~\u32^? \} \\
   \end{array}

If no maximum is given, the respective storage can grow to any size.


.. index:: ! memory type, limits, page size, memory
   pair: abstract syntax; memory type
   pair: memory; type
   pair: memory; limits
.. _syntax-memtype:

Memory Types
~~~~~~~~~~~~

*Memory types* classify linear :ref:`memories <syntax-mem>` and their size range.

.. math::
   \begin{array}{llll}
   \production{memory type} & \memtype &::=&
     \limits \\
   \end{array}

The limits constrain the minimum and optionally the maximum size of a memory.
The limits are given in units of :ref:`page size <page-size>`.


.. index:: ! table type, ! element type, limits, table, element
   pair: abstract syntax; table type
   pair: abstract syntax; element type
   pair: table; type
   pair: table; limits
   pair: element; type
.. _syntax-elemtype:
.. _syntax-tabletype:

Table Types
~~~~~~~~~~~

*Table types* classify :ref:`tables <syntax-table>` over elements of *element types* within a size range.

.. math::
   \begin{array}{llll}
   \production{table type} & \tabletype &::=&
     \limits~\elemtype \\
   \production{element type} & \elemtype &::=&
     \ANYFUNC \\
   \end{array}

Like memories, tables are constrained by limits for their minimum and optionally maximum size.
The limits are given in numbers of entries.

The element type |ANYFUNC| is the infinite union of all :ref:`function types <syntax-functype>`.
A table of that type thus contains references to functions of heterogeneous type.

.. note::
   In future versions of WebAssembly, additional element types may be introduced.


.. index:: ! global type, ! mutability, value type, global, mutability
   pair: abstract syntax; global type
   pair: abstract syntax; mutability
   pair: global; type
   pair: global; mutability
.. _syntax-mut:
.. _syntax-globaltype:

Global Types
~~~~~~~~~~~~

*Global types* classify :ref:`global <syntax-global>` variables, which hold a value and can either be mutable or immutable.

.. math::
   \begin{array}{llll}
   \production{global type} & \globaltype &::=&
     \mut~\valtype \\
   \production{mutability} & \mut &::=&
     \MCONST ~|~
     \MVAR \\
   \end{array}


.. index:: ! external type, function type, table type, memory type, global type, import, external value
   pair: abstract syntax; external type
   pair: external; type
.. _syntax-externtype:

External Types
~~~~~~~~~~~~~~

*External types* classify :ref:`imports <syntax-import>` and :ref:`external values <syntax-externval>` with their respective types.

.. math::
   \begin{array}{llll}
   \production{external types} & \externtype &::=&
     \ETFUNC~\functype ~|~
     \ETTABLE~\tabletype ~|~
     \ETMEM~\memtype ~|~
     \ETGLOBAL~\globaltype \\
   \end{array}


Conventions
...........

The following auxiliary notation is defined for sequences of external types.
It filters out entries of a specific kind in an order-preserving fashion:

* :math:`\etfuncs(\externtype^\ast) = [\functype ~|~ (\ETFUNC~\functype) \in \externtype^\ast]`

* :math:`\ettables(\externtype^\ast) = [\tabletype ~|~ (\ETTABLE~\tabletype) \in \externtype^\ast]`

* :math:`\etmems(\externtype^\ast) = [\memtype ~|~ (\ETMEM~\memtype) \in \externtype^\ast]`

* :math:`\etglobals(\externtype^\ast) = [\globaltype ~|~ (\ETGLOBAL~\globaltype) \in \externtype^\ast]`

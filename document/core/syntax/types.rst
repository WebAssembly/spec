.. index:: ! type, validation, instantiation, execution
   pair: abstract syntax; type
.. _syntax-type:

Types
-----

Various entities in WebAssembly are classified by types.
Types are checked during :ref:`validation <valid>`, :ref:`instantiation <exec-instantiation>`, and possibly :ref:`execution <syntax-call_indirect>`.


.. index:: ! number type, integer, floating-point, IEEE 754, bit width, memory
   pair: abstract syntax; number type
   pair: number; type
.. _syntax-numtype:

Number Types
~~~~~~~~~~~~

*Number types* classify numeric values.

.. math::
   \begin{array}{llll}
   \production{number type} & \numtype &::=&
     \I32 ~|~ \I64 ~|~ \F32 ~|~ \F64 \\
   \end{array}

The types |I32| and |I64| classify 32 and 64 bit integers, respectively.
Integers are not inherently signed or unsigned, their interpretation is determined by individual operations.

The types |F32| and |F64| classify 32 and 64 bit floating-point data, respectively.
They correspond to the respective binary floating-point representations, also known as *single* and *double* precision, as defined by the |IEEE754|_ standard (Section 3.3).

Number types are *transparent*, meaning that their bit patterns can be observed.
Values of number type can be stored in :ref:`memories <syntax-mem>`.

.. _bitwidth:

Conventions
...........

* The notation :math:`|t|` denotes the *bit width* of a number type :math:`t`.
  That is, :math:`|\I32| = |\F32| = 32` and :math:`|\I64| = |\F64| = 64`.


.. index:: ! vector type, integer, floating-point, IEEE 754, bit width, memory, SIMD
   pair: abstract syntax; number type
   pair: number; type
.. _syntax-vectype:

Vector Types
~~~~~~~~~~~~

*Vector types* classify vectors of :ref:`numeric <syntax-numtype>` values processed by vector instructions (also known as *SIMD* instructions, single instruction multiple data).

.. math::
   \begin{array}{llll}
   \production{vector type} & \vectype &::=&
     \V128 \\
   \end{array}

The type |V128| corresponds to a 128 bit vector of packed integer or floating-point data. The packed data
can be interpreted as signed or unsigned integers, single or double precision floating-point
values, or a single 128 bit type. The interpretation is determined by individual operations.

Vector types, like :ref:`number types <syntax-numtype>` are *transparent*, meaning that their bit patterns can be observed.
Values of vector type can be stored in :ref:`memories <syntax-mem>`.

Conventions
...........

* The notation :math:`|t|` for :ref:`bit width <bitwidth>` extends to vector types as well, that is, :math:`|\V128| = 128`.



.. index:: ! heap type, store, type identifier, ! substitution, ! closed type
   pair: abstract syntax; heap type
.. _type-subst:
.. _type-closed:
.. _syntax-heaptype:

Heap Types
~~~~~~~~~~

*Heap types* classify objects in the runtime :ref:`store <store>`.

.. math::
   \begin{array}{llll}
   \production{heap type} & \heaptype &::=&
     \FUNC ~|~ \EXTERN ~|~ \typeidx ~|~ \functype ~|~ \BOT \\
   \end{array}

The type |FUNC| denotes the infinite union of all types of :ref:`functions <syntax-func>`, regardless of their concrete :ref:`function types <syntax-functype>`.

The type |EXTERN| denotes the infinite union of all objects owned by the :ref:`embedder <embedder>` and that can be passed into WebAssembly under this type.

A *concrete* heap type consists of a :ref:`type index <syntax-typeidx>` and classifies an object of the respective :ref:`type <syntax-type>` defined in some module.

A concrete heap type can also consist of a :ref:`function type <syntax-functype>` directly.
However, this form is representable in neither the :ref:`binary format <binary-valtype>` nor the :ref:`text format <text-valtype>`, such that it cannot be used in a program;
it only occurs during :ref:`validation <valid>` or :ref:`execution <exec>`, as the result of *substituting* a :ref:`type index <syntax-typeidx>` with its definition.

The type :math:`\BOT` is a :ref:`subtype <match-heaptype>` of all other heap types.
By virtue of being representable in neither the :ref:`binary format <binary-valtype>` nor the :ref:`text format <text-valtype>`, it cannot be used in a program;
it only occurs during :ref:`validation <valid>`, as a part of a possible operand type for instructions.

A type of any form is *closed* when it does not contain a heap type that is a :ref:`type index <syntax-typeidx>`,
i.e., all :ref:`type indices <syntax-typeidx>` have been :ref:`substituted <notation-subst>` with their :ref:`defined type <syntax-deftype>`.

.. _notation-subst:

Convention
..........

* :math:`t[x^\ast \subst \X{ft}^\ast]` denotes the parallel *substitution* of :ref:`type indices <syntax-typeidx>` :math:`x^\ast` with :ref:`function types <syntax-functype>` :math:`\X{ft}^\ast`, provided :math:`|x^\ast| = |\X{ft}^\ast|` in type :math:`t`.

* :math:`t[\subst \X{ft}^\ast]` is shorthand for the substitution :math:`t[x^\ast \subst \X{ft}^\ast]` where :math:`x^\ast = 0 \cdots (|\X{ft}^\ast| - 1)` in type :math:`t`.


.. index:: ! reference type, heap type, reference, table, function, function type, null
   pair: abstract syntax; reference type
   pair: reference; type
.. _syntax-reftype:
.. _syntax-nullable:

Reference Types
~~~~~~~~~~~~~~~

*Reference types* classify :ref:`values <syntax-value>` that are first-class references to objects in the runtime :ref:`store <store>`.

.. math::
   \begin{array}{llll}
   \production{reference type} & \reftype &::=&
     \REF~\NULL^?~\heaptype \\
   \end{array}

A reference type is characterised by the :ref:`heap type <syntax-heaptype>` it points to.

In addition, a reference type of the form :math:`\REF~\NULL~\X{ht}` is *nullable*, meaning that it can either be a proper reference to :math:`\X{ht}` or :ref:`null <syntax-null>`.
Other references are *non-null*.

Reference types are *opaque*, meaning that neither their size nor their bit pattern can be observed.
Values of reference type can be stored in :ref:`tables <syntax-table>`.

Conventions
...........

* The reference type |FUNCREF| is an abbreviation for :math:`\REF~\NULL~\FUNC`.

* The reference type |EXTERNREF| is an abbreviation for :math:`\REF~\NULL~\EXTERN`.


.. index:: ! value type, number type, vector type, reference type, ! bottom type
   pair: abstract syntax; value type
   pair: value; type
.. _syntax-valtype:
.. _syntax-bottype:

Value Types
~~~~~~~~~~~

*Value types* classify the individual values that WebAssembly code can compute with and the values that a variable accepts.
They are either :ref:`number types <syntax-numtype>`, :ref:`vector types <syntax-vectype>`, :ref:`reference types <syntax-reftype>`, or the unique *bottom type*, written :math:`\BOT`.

The type :math:`\BOT` is a :ref:`subtype <match-valtype>` of all other value types.
By virtue of being representable in neither the :ref:`binary format <binary-valtype>` nor the :ref:`text format <text-valtype>`, it cannot be used in a program;
it only occurs during :ref:`validation <valid>`, as a possible operand type for instructions.

.. math::
   \begin{array}{llll}
   \production{value type} & \valtype &::=&
     \numtype ~|~ \vectype ~|~ \reftype ~|~ \BOT \\
   \end{array}

Conventions
...........

* The meta variable :math:`t` ranges over value types or subclasses thereof where clear from context.


.. index:: ! result type, value type, instruction, execution, function
   pair: abstract syntax; result type
   pair: result; type
.. _syntax-resulttype:

Result Types
~~~~~~~~~~~~

*Result types* classify the result of :ref:`executing <exec-instr>` :ref:`instructions <syntax-instr>` or :ref:`functions <syntax-func>`,
which is a sequence of values, written with brackets.

.. math::
   \begin{array}{llll}
   \production{result type} & \resulttype &::=&
     [\vec(\valtype)] \\
   \end{array}


.. index:: ! instruction type, value type, result type, instruction, local, local index
   pair: abstract syntax; instruction type
   pair: instruction; type
.. _syntax-instrtype:

Instruction Types
~~~~~~~~~~~~~~~~~

*Instruction types* classify the behaviour of :ref:`instructions <syntax-instr>` or instruction sequences, by describing how they manipulate the :ref:`operand stack <stack>` and the initialization status of :ref:`locals <syntax-local>`:

.. math::
   \begin{array}{llll}
   \production{instruction type} & \instrtype &::=&
     \resulttype \toX{\localidx^\ast} \resulttype \\
   \end{array}

An instruction type :math:`[t_1^\ast] \toX{x^\ast} [t_2^\ast]` describes the required input stack with argument values of types :math:`t_1^\ast` that an instruction pops off
and the provided output stack with result values of types :math:`t_2^\ast` that it pushes back.
Moreover, it enumerates the :ref:`indices <syntax-localidx>` :math:`x^\ast` of locals that have been set by the instruction or sequence.

.. note::
   Instruction types are only used for :ref:`validation <valid>`,
   they do not occur in programs.


.. index:: ! local type, value type, local, local index
   pair: abstract syntax; local type
   pair: local; type
.. _syntax-init:
.. _syntax-localtype:

Local Types
~~~~~~~~~~~

*Local types* classify :ref:`locals <syntax-local>`, by describing their :ref:`value type <syntax-valtype>` as well as their *initialization status*:

.. math::
   \begin{array}{llll}
   \production{initialization status} & \init &::=&
     \SET ~|~ \UNSET \\
   \production{local type} & \localtype &::=&
     \init~\valtype \\
   \end{array}

.. note::
   Local types are only used for :ref:`validation <valid>`,
   they do not occur in programs.


.. index:: ! function type, value type, vector, function, parameter, result, result type
   pair: abstract syntax; function type
   pair: function; type
.. _syntax-functype:

Function Types
~~~~~~~~~~~~~~

*Function types* classify the signature of :ref:`functions <syntax-func>`,
mapping a vector of parameters to a vector of results.
They are also used to classify the inputs and outputs of :ref:`instructions <syntax-instr>`.

.. math::
   \begin{array}{llll}
   \production{function type} & \functype &::=&
     \resulttype \to \resulttype \\
   \end{array}


.. index:: ! defined type, function type
   pair: abstract syntax; defined type
.. _syntax-deftype:

Defined Types
~~~~~~~~~~~~~

*Defined types* are the ones that can be defined in a :ref:`module <syntax-module>`, assigning them a :ref:`type index <syntax-typeidx>`.

.. math::
   \begin{array}{llll}
   \production{defined type} & \deftype &::=&
     \functype \\
   \end{array}

.. note::
   Future versions of WebAssembly may introduce additional forms of defined types.


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


.. index:: ! table type, reference type, limits, table, element
   pair: abstract syntax; table type
   pair: table; type
   pair: table; limits
.. _syntax-tabletype:

Table Types
~~~~~~~~~~~

*Table types* classify :ref:`tables <syntax-table>` over elements of :ref:`reference type <syntax-reftype>` within a size range.

.. math::
   \begin{array}{llll}
   \production{table type} & \tabletype &::=&
     \limits~\reftype \\
   \end{array}

Like memories, tables are constrained by limits for their minimum and optionally maximum size.
The limits are given in numbers of entries.

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

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
   \begin{array}{llrl}
   \production{number type} & \numtype &::=&
     \I32 ~|~ \I64 ~|~ \F32 ~|~ \F64 \\
   \end{array}

The types |I32| and |I64| classify 32 and 64 bit integers, respectively.
Integers are not inherently signed or unsigned, their interpretation is determined by individual operations.

The types |F32| and |F64| classify 32 and 64 bit floating-point data, respectively.
They correspond to the respective binary floating-point representations, also known as *single* and *double* precision, as defined by the |IEEE754|_ standard (Section 3.3).

Number types are *transparent*, meaning that their bit patterns can be observed.
Values of number type can be stored in :ref:`memories <syntax-mem>`.

.. _bitwidth-numtype:
.. _bitwidth-valtype:

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
   \begin{array}{llrl}
   \production{vector type} & \vectype &::=&
     \V128 \\
   \end{array}

The type |V128| corresponds to a 128 bit vector of packed integer or floating-point data. The packed data
can be interpreted as signed or unsigned integers, single or double precision floating-point
values, or a single 128 bit type. The interpretation is determined by individual operations.

Vector types, like :ref:`number types <syntax-numtype>` are *transparent*, meaning that their bit patterns can be observed.
Values of vector type can be stored in :ref:`memories <syntax-mem>`.

.. _bitwidth-vectype:

Conventions
...........

* The notation :math:`|t|` for :ref:`bit width <bitwidth-numtype>` extends to vector types as well, that is, :math:`|\V128| = 128`.


.. index:: ! heap type, store, type index, ! abstract type, ! concrete type, ! unboxed scalar
   pair: abstract syntax; heap type
.. _type-abstract:
.. _type-concrete:
.. _syntax-i31:
.. _syntax-heaptype:
.. _syntax-absheaptype:

Heap Types
~~~~~~~~~~

*Heap types* classify objects in the runtime :ref:`store <store>`.
There are three disjoint hierarchies of heap types:

- *function types* classify :ref:`functions <syntax-func>`,
- *aggregate types* classify dynamically allocated *managed* data, such as *structures*, *arrays*, or *unboxed scalars*,
- *external types* classify *external* references possibly owned by the :ref:`embedder <embedder>`.

The values from the latter two hierarchies are interconvertible by ways of the |EXTERNCONVERTANY| and |ANYCONVERTEXTERN| instructions.
That is, both type hierarchies are inhabited by an isomorphic set of values, but may have different, incompatible representations in practice.

.. math::
   \begin{array}{llrl}
   \production{abstract heap type} & \absheaptype &::=&
     \FUNC ~|~ \NOFUNC \\&&|&
     \EXN ~|~ \NOEXN \\&&|&
     \EXTERN ~|~ \NOEXTERN \\&&|&
     \ANY ~|~ \EQT ~|~ \I31 ~|~ \STRUCT ~|~ \ARRAY ~|~ \NONE \\
   \production{heap type} & \heaptype &::=&
     \absheaptype ~|~ \typeidx \\
   \end{array}

A heap type is either *abstract* or *concrete*.

The abstract type |FUNC| denotes the common supertype of all :ref:`function types <syntax-functype>`, regardless of their concrete definition.
Dually, the type |NOFUNC| denotes the common subtype of all :ref:`function types <syntax-functype>`, regardless of their concrete definition.
This type has no values.

The abstract type |EXN| denotes the type of all :ref:`exception references <syntax-ref.exn>`.
Dually, the type |NOEXN| denotes the common subtype of all forms of exception references.
This type has no values.

The abstract type |EXTERN| denotes the common supertype of all external references received through the :ref:`embedder <embedder>`.
This type has no concrete subtypes.
Dually, the type |NOEXTERN| denotes the common subtype of all forms of external references.
This type has no values.

The abstract type |ANY| denotes the common supertype of all aggregate types, as well as possibly abstract values produced by *internalizing* an external reference of type |EXTERN|.
Dually, the type |NONE| denotes the common subtype of all forms of aggregate types.
This type has no values.

The abstract type |EQT| is a subtype of |ANY| that includes all types for which references can be compared, i.e., aggregate values and |I31|.

The abstract types |STRUCT| and |ARRAY| denote the common supertypes of all :ref:`structure <syntax-structtype>` and :ref:`array <syntax-arraytype>` aggregates, respectively.

The abstract type |I31| denotes *unboxed scalars*, that is, integers injected into references.
Their observable value range is limited to 31 bits.

.. note::
   An |I31| is not actually allocated in the store,
   but represented in a way that allows them to be mixed with actual references into the store without ambiguity.
   Engines need to perform some form of *pointer tagging* to achieve this,
   which is why 1 bit is reserved.

   Although the types |NONE|, |NOFUNC|, |NOEXN|, and |NOEXTERN| are not inhabited by any values,
   they can be used to form the types of all null :ref:`references <syntax-reftype>` in their respective hierarchy.
   For example, :math:`(\REF~\NULL~\NOFUNC)` is the generic type of a null reference compatible with all function reference types.

A concrete heap type consists of a :ref:`type index <syntax-typeidx>` and classifies an object of the respective :ref:`type <syntax-type>` defined in a module.

The syntax of heap types is :ref:`extended <syntax-heaptype-ext>` with additional forms for the purpose of specifying :ref:`validation <valid>` and :ref:`execution <exec>`.


.. index:: ! reference type, heap type, reference, table, function, function type, null
   pair: abstract syntax; reference type
   pair: reference; type
.. _syntax-reftype:
.. _syntax-nullable:

Reference Types
~~~~~~~~~~~~~~~

*Reference types* classify :ref:`values <syntax-value>` that are first-class references to objects in the runtime :ref:`store <store>`.

.. math::
   \begin{array}{llrl}
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

* The reference type |ANYREF| is an abbreviation for :math:`\REF~\NULL~\ANY`.

* The reference type |EQREF| is an abbreviation for :math:`\REF~\NULL~\EQT`.

* The reference type |I31REF| is an abbreviation for :math:`\REF~\NULL~\I31`.

* The reference type |STRUCTREF| is an abbreviation for :math:`\REF~\NULL~\STRUCT`.

* The reference type |ARRAYREF| is an abbreviation for :math:`\REF~\NULL~\ARRAY`.

* The reference type |FUNCREF| is an abbreviation for :math:`\REF~\NULL~\FUNC`.

* The reference type |EXNREF| is an abbreviation for :math:`\REF~\NULL~\EXN`.

* The reference type |EXTERNREF| is an abbreviation for :math:`\REF~\NULL~\EXTERN`.

* The reference type |NULLREF| is an abbreviation for :math:`\REF~\NULL~\NONE`.

* The reference type |NULLFUNCREF| is an abbreviation for :math:`\REF~\NULL~\NOFUNC`.

* The reference type |NULLEXNREF| is an abbreviation for :math:`\REF~\NULL~\NOEXN`.

* The reference type |NULLEXTERNREF| is an abbreviation for :math:`\REF~\NULL~\NOEXTERN`.


.. index:: ! value type, number type, vector type, reference type
   pair: abstract syntax; value type
   pair: value; type
.. _syntax-valtype:

Value Types
~~~~~~~~~~~

*Value types* classify the individual values that WebAssembly code can compute with and the values that a variable accepts.
They are either :ref:`number types <syntax-numtype>`, :ref:`vector types <syntax-vectype>`, or :ref:`reference types <syntax-reftype>`.

.. math::
   \begin{array}{llrl}
   \production{value type} & \valtype &::=&
     \numtype ~|~ \vectype ~|~ \reftype \\
   \end{array}

The syntax of value types is :ref:`extended <syntax-valtype-ext>` with additional forms for the purpose of specifying :ref:`validation <valid>`.

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
   \begin{array}{llrl}
   \production{result type} & \resulttype &::=&
     [\vec(\valtype)] \\
   \end{array}


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
   \begin{array}{llrl}
   \production{function type} & \functype &::=&
     \resulttype \toF \resulttype \\
   \end{array}


.. index:: ! aggregate type, ! structure type, ! array type, ! field type, ! storage type, ! packed type, bit width
   pair: abstract syntax; structure type
   pair: abstract syntax; array type
   pair: abstract syntax; field type
   pair: abstract syntax; storage type
   pair: abstract syntax; packed type
.. _syntax-aggrtype:
.. _syntax-structtype:
.. _syntax-arraytype:
.. _syntax-fieldtype:
.. _syntax-storagetype:
.. _syntax-packedtype:

Aggregate Types
~~~~~~~~~~~~~~~

*Aggregate types* describe compound objects consisting of multiple values.
These are either *structures* or *arrays*,
which both consist of a list of possibly mutable and possibly packed *fields*.
Structures are heterogeneous, but require static indexing, while arrays need to be homogeneous, but allow dynamic indexing.

.. math::
   \begin{array}{llrl}
   \production{structure type} & \structtype &::=&
     \fieldtype^\ast \\
   \production{array type} & \arraytype &::=&
     \fieldtype \\
   \production{field type} & \fieldtype &::=&
     \mut~\storagetype \\
   \production{storage type} & \storagetype &::=&
     \valtype ~|~ \packedtype \\
   \production{packed type} & \packedtype &::=&
     \I8 ~|~ \I16 \\
   \end{array}

.. _bitwidth-fieldtype:
.. _aux-unpacktype:

Conventions
...........

* The notation :math:`|t|` for :ref:`bit width <bitwidth-valtype>` extends to packed types as well, that is, :math:`|\I8| = 8` and :math:`|\I16| = 16`.

* The auxiliary function :math:`\unpacktype` maps a storage type to the :ref:`value type <syntax-valtype>` obtained when accessing a field:

  .. math::
     \begin{array}{lll}
     \unpacktype(\valtype) &=& \valtype \\
     \unpacktype(\packedtype) &=& \I32 \\
     \end{array}


.. index:: ! composite type, function type, aggreagate type, structure type, array type
   pair: abstract syntax; composite type
.. _syntax-comptype:

Composite Types
~~~~~~~~~~~~~~~

*Composite types* are all types composed from simpler types,
including :ref:`function types <syntax-functype>` and :ref:`aggregate types <syntax-aggrtype>`.

.. math::
   \begin{array}{llrl}
   \production{composite type} & \comptype &::=&
     \TFUNC~\functype ~|~ \TSTRUCT~\structtype ~|~ \TARRAY~\arraytype \\
   \end{array}


.. index:: ! recursive type, ! sub type, composite type, ! final, subtyping, ! roll, ! unroll, recursive type index
   pair: abstract syntax; recursive type
   pair: abstract syntax; sub type
.. _syntax-rectype:
.. _syntax-subtype:

Recursive Types
~~~~~~~~~~~~~~~

*Recursive types* denote a group of mutually recursive :ref:`composite types <syntax-comptype>`, each of which can optionally declare a list of :ref:`type indices <syntax-typeidx>` of supertypes that it :ref:`matches <match-comptype>`.
Each type can also be declared *final*, preventing further subtyping.

.. math::
   \begin{array}{llrl}
   \production{recursive type} & \rectype &::=&
     \TREC~\subtype^\ast \\
   \production{sub types} & \subtype &::=&
     \TSUB~\TFINAL^?~\typeidx^\ast~\comptype \\
   \end{array}

In a :ref:`module <syntax-module>`, each member of a recursive type is assigned a separate :ref:`type index <syntax-typeidx>`.

The syntax of sub types is :ref:`generalized <syntax-heaptype-ext>` for the purpose of specifying :ref:`validation <valid>` and :ref:`execution <exec>`.


.. _index:: ! index type
   pair: abstract syntax; index type
   single: memory; index type
   single: table; index type
.. _syntax-idxtype:

Index Type
~~~~~~~~~~

*Index types* classify the values that can be used to index into
:ref:`memories <syntax-mem>` and :ref:`tables <syntax-table>`.

.. math::
   \begin{array}{llll}
   \production{index type} & \idxtype &::=&
     \I32 ~|~ \I64 \\
   \end{array}

.. _aux-idxtype-min:

Conventions
...........

The *minimum* of two index types is defined as |I32| if either of the types are
|I32|, and |I64| otherwise.

.. math::
   \begin{array}{llll}
   \itmin(\I64, \I64) &=& \I64 \\
   \itmin(\X{it}_1, \X{it}_2) &=& \I32 & (\otherwise) \\
   \end{array}


.. index:: ! limits, memory type, table type
   pair: abstract syntax; limits
   single: memory; limits
   single: table; limits
.. _syntax-limits:

Limits
~~~~~~

*Limits* classify the size range of resizeable storage associated with :ref:`memory types <syntax-memtype>` and :ref:`table types <syntax-tabletype>`.

.. math::
   \begin{array}{llrl}
   \production{limits} & \limits &::=&
     \{ \LMIN~\u64, \LMAX~\u64^? \} \\
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
   \begin{array}{llrl}
   \production{memory type} & \memtype &::=&
     ~\idxtype~\limits \\
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
   \begin{array}{llrl}
   \production{table type} & \tabletype &::=&
     ~\idxtype~\limits ~\reftype \\
   \end{array}

Like memories, tables are constrained by limits for their minimum and optionally maximum size.
The limits are given in numbers of entries.


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
   \begin{array}{llrl}
   \production{global type} & \globaltype &::=&
     \mut~\valtype \\
   \production{mutability} & \mut &::=&
     \MCONST ~|~
     \MVAR \\
   \end{array}


.. index:: ! tag, tag type, function type, exception tag
   pair: abstract syntax; tag
   pair: tag; exception tag
   single: tag; type; exception
.. _syntax-tagtype:

Tag Types
~~~~~~~~~

*Tag types* classify the signature of :ref:`tags <syntax-tag>` with a function type.

.. math::
   \begin{array}{llll}
   \production{tag type} &\tagtype &::=& \functype \\
   \end{array}

Currently tags are only used for categorizing exceptions.
The parameters of |functype| define the list of values associated with the exception thrown with this tag.
Furthermore, it is an invariant of the semantics that every |functype| in a :ref:`valid <valid-tagtype>` tag type for an exception has an empty result type.

.. note::
   Future versions of WebAssembly may have additional uses for tags, and may allow non-empty result types in the function types of tags.


.. index:: ! external type, defined type, function type, table type, memory type, global type, tag type, import, external value
   pair: abstract syntax; external type
   pair: external; type
.. _syntax-externtype:

External Types
~~~~~~~~~~~~~~

*External types* classify :ref:`imports <syntax-import>` and :ref:`external values <syntax-externval>` with their respective types.

.. math::
   \begin{array}{llrl}
   \production{external types} & \externtype &::=&
     \ETFUNC~\deftype ~|~
     \ETTABLE~\tabletype ~|~
     \ETMEM~\memtype ~|~
     \ETGLOBAL~\globaltype ~|~
     \ETTAG~\tagtype \\
   \end{array}


Conventions
...........

The following auxiliary notation is defined for sequences of external types.
It filters out entries of a specific kind in an order-preserving fashion:

* :math:`\etfuncs(\externtype^\ast) = [\deftype ~|~ (\ETFUNC~\deftype) \in \externtype^\ast]`

* :math:`\ettables(\externtype^\ast) = [\tabletype ~|~ (\ETTABLE~\tabletype) \in \externtype^\ast]`

* :math:`\etmems(\externtype^\ast) = [\memtype ~|~ (\ETMEM~\memtype) \in \externtype^\ast]`

* :math:`\etglobals(\externtype^\ast) = [\globaltype ~|~ (\ETGLOBAL~\globaltype) \in \externtype^\ast]`

* :math:`\ettags(\externtype^\ast) = [\tagtype ~|~ (\ETTAG~\tagtype) \in \externtype^\ast]`

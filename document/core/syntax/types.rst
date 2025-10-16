.. index:: ! type, validation, instantiation, execution
   pair: abstract syntax; type

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

$${syntax: numtype}

The types ${:I32} and ${:I64} classify 32 and 64 bit integers, respectively.
Integers are not inherently signed or unsigned, their interpretation is determined by individual operations.

The types ${:F32} and ${:F64} classify 32 and 64 bit floating-point data, respectively.
They correspond to the respective binary floating-point representations, also known as *single* and *double* precision, as defined by the |IEEE754|_ standard (Section 3.3).

Number types are *transparent*, meaning that their bit patterns can be observed.
Values of number type can be stored in :ref:`memories <syntax-mem>`.

.. _bitwidth-numtype:
.. _bitwidth-valtype:

Conventions
...........

* The notation ${:$size(t)}` denotes the *bit width* of a number type ${:t}.
  That is, ${:$size(I32) = $size(F32) = 32} and ${:$size(I64) = $size(F64) = 64}.

$${definition-ignore: size}


.. index:: ! vector type, integer, floating-point, IEEE 754, bit width, memory, SIMD
   pair: abstract syntax; number type
   pair: number; type
.. _syntax-vectype:

Vector Types
~~~~~~~~~~~~

*Vector types* classify vectors of :ref:`numeric <syntax-numtype>` values processed by vector instructions (also known as *SIMD* instructions, single instruction multiple data).

$${syntax: vectype}

The type ${:V128} corresponds to a 128 bit vector of packed integer or floating-point data. The packed data
can be interpreted as signed or unsigned integers, single or double precision floating-point
values, or a single 128 bit type. The interpretation is determined by individual operations.

Vector types, like :ref:`number types <syntax-numtype>` are *transparent*, meaning that their bit patterns can be observed.
Values of vector type can be stored in :ref:`memories <syntax-mem>`.

.. _bitwidth-vectype:

Conventions
...........

* The notation ${:$vsize(t)} for :ref:`bit width <bitwidth-numtype>` extends to vector types as well, that is, ${:$vsize(V128) = 128}.

$${definition-ignore: vsize}


.. index:: ! type use, type index
   pair: abstract syntax; type use
.. _syntax-typeuse:

Type Uses
~~~~~~~~~

A *type use* is the use site of a :ref:`type index <syntax-typeidx>` referencing a :ref:`composite type <syntax-comptype>` :ref:`defined <syntax-type>` in a :ref:`module <syntax-module>`.
It classifies objects of the respective type.

$${syntax: {typeuse/syn}}

The syntax of type uses is :ref:`extended <syntax-typeuse-ext>` with additional forms for the purpose of specifying :ref:`validation <valid>` and :ref:`execution <exec>`.


.. index:: ! heap type, store, type use, ! abstract type, ! concrete type, ! unboxed scalar
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

The values from the latter two hierarchies are interconvertible by ways of the ${instr: EXTERN.CONVERT_ANY} and ${instr: ANY.CONVERT_EXTERN} instructions.
That is, both type hierarchies are inhabited by an isomorphic set of values, but may have different, incompatible representations in practice.

$${syntax: {absheaptype/syn heaptype}}

A heap type is either *abstract* or *concrete*.
A concrete heap type consists of a :ref:`type use <syntax-typeuse>` that classifies an object of the respective :ref:`type <syntax-type>` defined in a module.
Abstract types are denoted by individual keywords.

The type ${:FUNC} denotes the common supertype of all :ref:`function types <syntax-functype>`, regardless of their concrete definition.
Dually, the type ${:NOFUNC} denotes the common subtype of all :ref:`function types <syntax-functype>`, regardless of their concrete definition.
This type has no values.

The type ${:EXN} denotes the common supertype of all :ref:`exception references <syntax-ref.exn>`.
This type has no concrete subtypes.
Dually, the type ${:NOEXN} denotes the common subtype of all forms of exception references.
This type has no values.

The type ${:EXTERN} denotes the common supertype of all external references received through the :ref:`embedder <embedder>`.
This type has no concrete subtypes.
Dually, the type ${:NOEXTERN} denotes the common subtype of all forms of external references.
This type has no values.

The type ${:ANY} denotes the common supertype of all aggregate types, as well as possibly abstract values produced by *internalizing* an external reference of type ${:EXTERN}.
Dually, the type ${:NONE} denotes the common subtype of all forms of aggregate types.
This type has no values.

The type ${:EQ} is a subtype of ${:ANY} that includes all types for which references can be compared, i.e., aggregate values and ${:I31}.

The types ${:STRUCT} and ${:ARRAY} denote the common supertypes of all :ref:`structure <syntax-structtype>` and :ref:`array <syntax-arraytype>` aggregates, respectively.

The type ${:I31} denotes *unboxed scalars*, that is, integers injected into references.
Their observable value range is limited to 31 bits.

.. note::
   Values of type ${:I31} are not actually allocated in the store,
   but represented in a way that allows them to be mixed with actual references into the store without ambiguity.
   Engines need to perform some form of *pointer tagging* to achieve this,
   which is why one bit is reserved.
   Since this type is to be reliably unboxed on all hardware platforms supported by WebAssembly,
   it cannot be wider than 32 bits minus the tag bit.

   Although the types ${:NONE}, ${:NOFUNC}, ${:NOEXN}, and ${:NOEXTERN} are not inhabited by any values,
   they can be used to form the types of all null :ref:`references <syntax-reftype>` in their respective hierarchy.
   For example, ${:(REF NULL NOFUNC)} is the generic type of a null reference compatible with all function reference types.

The syntax of abstract heap types is :ref:`extended <syntax-heaptype-ext>` with additional forms for the purpose of specifying :ref:`validation <valid>` and :ref:`execution <exec>`.


.. index:: ! reference type, heap type, reference, table, function, function type, null
   pair: abstract syntax; reference type
   pair: reference; type
.. _syntax-reftype:
.. _syntax-null:

Reference Types
~~~~~~~~~~~~~~~

*Reference types* classify :ref:`values <syntax-value>` that are first-class references to objects in the runtime :ref:`store <store>`.

$${syntax: reftype}

A reference type is characterised by the :ref:`heap type <syntax-heaptype>` it points to.

In addition, a reference type of the form ${:REF NULL ht} is *nullable*, meaning that it can either be a proper reference to ${:ht} or :ref:`null <syntax-null>`.
Other references are *non-null*.

Reference types are *opaque*, meaning that neither their size nor their bit pattern can be observed.
Values of reference type can be stored in :ref:`tables <syntax-table>` but not in :ref:`memories <syntax-mem>`.

Conventions
...........

* The reference type ${:$ANYREF} is an abbreviation for ${reftype: (REF NULL ANY)}.

* The reference type ${:$EQREF} is an abbreviation for ${reftype: (REF NULL EQ)}.

* The reference type ${:$I31REF} is an abbreviation for ${reftype: (REF NULL I31)}.

* The reference type ${:$STRUCTREF} is an abbreviation for ${reftype: (REF NULL STRUCT)}.

* The reference type ${:$ARRAYREF} is an abbreviation for ${reftype: (REF NULL ARRAY)}.

* The reference type ${:$FUNCREF} is an abbreviation for ${reftype: (REF NULL FUNC)}.

* The reference type ${:$EXNREF} is an abbreviation for ${reftype: (REF NULL EXN)}.

* The reference type ${:$EXTERNREF} is an abbreviation for ${reftype: (REF NULL EXTERN)}.

* The reference type ${:$NULLREF} is an abbreviation for ${reftype: (REF NULL NONE)}.

* The reference type ${:$NULLFUNCREF} is an abbreviation for ${reftype: (REF NULL NOFUNC)}.

* The reference type ${:$NULLEXNREF} is an abbreviation for ${reftype: (REF NULL NOEXN)}.

* The reference type ${:$NULLEXTERNREF} is an abbreviation for ${reftype: (REF NULL NOEXTERN)}.


.. index:: ! value type, number type, vector type, reference type
   pair: abstract syntax; value type
   pair: value; type
.. _syntax-valtype:
.. _syntax-consttype:

Value Types
~~~~~~~~~~~

*Value types* classify the individual values that WebAssembly code can compute with and the values that a variable accepts.
They are either :ref:`number types <syntax-numtype>`, :ref:`vector types <syntax-vectype>`, or :ref:`reference types <syntax-reftype>`.

$${syntax: {consttype valtype/syn}}

The syntax of value types is :ref:`extended <syntax-valtype-ext>` with additional forms for the purpose of specifying :ref:`validation <valid>`.

Conventions
...........

* The meta variable ${:t} ranges over value types or subclasses thereof where clear from context.


.. index:: ! result type, value type, list, instruction, execution, function
   pair: abstract syntax; result type
   pair: result; type
.. _syntax-resulttype:

Result Types
~~~~~~~~~~~~

*Result types* classify the result of :ref:`executing <exec-instr>` :ref:`instructions <syntax-instr>` or :ref:`functions <syntax-func>`,
which is a sequence of values, written with brackets.

$${syntax: resulttype}


.. index:: ! block type, block, type index, function type, value type, type index
   pair: abstract syntax; block type
   pair: block; type
   pair: type; block
.. _syntax-blocktype:

Block Types
~~~~~~~~~~~

*Block types* classify the *input* and *output* of structured :ref:`control instructions <syntax-instr-control>` delimiting :ref:`blocks <syntax-block>` of instructions.

$${syntax: blocktype}

They are given either as a :ref:`type index <syntax-funcidx>` that refers to a suitable :ref:`function type <syntax-functype>` reinterpreted as an :ref:`instruction type <syntax-instrtype>`,
or as an optional :ref:`value type <syntax-valtype>` inline,
which is a shorthand for the instruction type ${instrtype: eps -> valtype?}.


.. index:: ! composite type, ! function type, result type, ! aggregate type, ! structure type, ! array type, ! field type, ! storage type, ! packed type, bit width, function, structure, array, parameter, result, list
   pair: abstract syntax; composite type
   pair: abstract syntax; function type
   pair: abstract syntax; structure type
   pair: abstract syntax; array type
   pair: abstract syntax; field type
   pair: abstract syntax; storage type
   pair: abstract syntax; packed type
   pair: function; type
   pair: structure; type
   pair: array; type
.. _syntax-comptype:
.. _syntax-functype:
.. _syntax-aggrtype:
.. _syntax-structtype:
.. _syntax-arraytype:
.. _syntax-fieldtype:
.. _syntax-storagetype:
.. _syntax-packtype:

Composite Types
~~~~~~~~~~~~~~~

*Composite types* are all types composed from simpler types,
including *function types*, *structure types* and *array types*.

$${syntax: comptype {fieldtype storagetype packtype}}

Function types classify the signature of :ref:`functions <syntax-func>`,
mapping a list of parameters to a list of results.
They are also used to classify the inputs and outputs of :ref:`instructions <syntax-instr>`.

*Aggregate types* like structure or array types consist of a list of possibly mutable, possibly packed *field types* describing their components.
Structures are heterogeneous, but require static indexing, while arrays need to be homogeneous, but allow dynamic indexing.

.. _bitwidth-fieldtype:
.. _aux-unpack:

Conventions
...........

* The notation ${:$psize(t)} for the :ref:`bit width <bitwidth-valtype>` of a :ref:`value type <syntax-valtype>` ${:t} extends to packed types as well, that is, ${:$psize(I8) = 8} and ${:$psize(I16) = 16}.

$${definition-ignore: psize}

* The auxiliary function :math:`\unpack` maps a storage type to the :ref:`value type <syntax-valtype>` obtained when accessing a field:

$${definition: unpack}


.. index:: ! recursive type, ! sub type, composite type, ! final, subtyping, ! roll, ! unroll, recursive type index
   pair: abstract syntax; recursive type
   pair: abstract syntax; sub type
.. _syntax-rectype:
.. _syntax-subtype:
.. _syntax-final:

Recursive Types
~~~~~~~~~~~~~~~

*Recursive types* denote a group of mutually recursive :ref:`composite types <syntax-comptype>`, each of which can optionally declare a list of :ref:`type uses <syntax-typeuse>` of supertypes that it :ref:`matches <match-comptype>`.
Each type can also be declared *final*, preventing further subtyping.

$${syntax: {rectype subtype}}

In a :ref:`module <syntax-module>`, each member of a recursive type is assigned a separate :ref:`type index <syntax-typeidx>`.


.. _index:: ! address type, number type, bit width
   pair: abstract syntax; address type
   single: memory; address type
   single: table; address type
.. _syntax-addrtype:

Address Types
~~~~~~~~~~~~~

*Address types* are a subset of :ref:`number types <syntax-numtype>` that classify the values that can be used as offsets into
:ref:`memories <syntax-mem>` and :ref:`tables <syntax-table>`.

$${syntax: {addrtype}}

.. _aux-addrtype-min:

Conventions
...........

The *minimum* of two address types is defined as the address type whose :ref:`bit width <bitwidth-numtype>` is the minimum of the two.

$${definition: minat}


.. index:: ! limits, memory type, table type
   pair: abstract syntax; limits
   single: memory; limits
   single: table; limits
.. _syntax-limits:

Limits
~~~~~~

*Limits* classify the size range of resizeable storage associated with :ref:`memory types <syntax-memtype>` and :ref:`table types <syntax-tabletype>`.

$${syntax: limits}

If no maximum is present,
then the respective storage can grow to any valid size.


.. index:: ! tag type, type use, tag, function type, exception tag
   pair: abstract syntax; tag type
   pair: tag; type
.. _syntax-tagtype:

Tag Types
~~~~~~~~~

*Tag types* classify the signature :ref:`tags <syntax-tag>`
with a :ref:`type use <syntax-typeuse>` referring to the definition of a :ref:`function type <syntax-functype>` that declares the types of parameter and result values associated with the tag.
The result type is empty for exception tags.

$${syntax: tagtype}


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

$${syntax: globaltype}


.. index:: ! memory type, limits, page size, memory
   pair: abstract syntax; memory type
   pair: memory; type
   pair: memory; limits
.. _syntax-memtype:

Memory Types
~~~~~~~~~~~~

*Memory types* classify linear :ref:`memories <syntax-mem>` and their size range.

$${syntax: memtype}

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

$${syntax: tabletype}

Like memories, tables are constrained by limits for their minimum and optionally maximum size.
The limits are given in numbers of entries.


.. index:: ! data type, memory
   pair: abstract syntax; data type
   pair: data; type
.. _syntax-datatype:

Data Types
~~~~~~~~~~

*Data types* classify :ref:`data segments <syntax-elem>`.
Since the contents of a data segment requires no further classification, they merely consist of a universal marker ${:OK} indicating well-formedness.

$${syntax: datatype}


.. index:: ! element type, reference type, table, element
   pair: abstract syntax; element type
   pair: element; type
.. _syntax-elemtype:

Element Types
~~~~~~~~~~~~~

*Element types* classify :ref:`element segments <syntax-elem>` by the :ref:`reference type <syntax-reftype>` of its elements.

$${syntax: elemtype}


.. index:: ! external type, defined type, function type, table type, memory type, global type, tag type, import, external address
   pair: abstract syntax; external type
   pair: external; type
.. _syntax-externtype:

External Types
~~~~~~~~~~~~~~

*External types* classify :ref:`imports <syntax-import>` and :ref:`external addresses <syntax-externaddr>` with their respective types.

$${syntax: externtype}

For functions, the :ref:`type use <syntax-typeuse>` has to refer to the definition of a :ref:`function type <syntax-functype>`.

.. note::
   Future versions of WebAssembly may have additional uses for tags, and may allow non-empty result types in the function types of tags.


Conventions
...........

The following auxiliary notation is defined for sequences of external types.
It filters out entries of a specific kind in an order-preserving fashion:

$${definition: funcsxt tablesxt memsxt globalsxt tagsxt}

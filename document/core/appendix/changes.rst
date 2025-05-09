.. index:: ! changes
.. _changes:

Change History
--------------

Since the original release 1.0 of the WebAssembly specification, a number of proposals for extensions have been integrated.
The following sections provide an overview of what has changed.

All present and future versions of WebAssembly are intended to be *backwards-compatible* with all previous versions.
Concretely:

1. All syntactically well-formed (in :ref:`binary <binary>` or :ref:`text <text>` format) and :ref:`valid <valid>` modules remain well-formed and valid with an equivalent :ref:`module type <syntax-moduletype>` (or a subtype).

  .. note::
     This allows previously malformed or invalid modules to become legal,
     e.g., by adding new features or by relaxing typing rules.

     It also allows reclassifying previously malformed modules as well-formed but invalid,
     or vice versa.

     And it allows refining the typing of :ref:`imports <syntax-import>` and :ref:`exports <syntax-export>`,
     such that previously unlinkable modules become linkable.

     Historically, minor breaking changes to the *text format* have been allowed
     that turned previously possible valid modules invalid,
     as long as they were unlikely to occur in practice.

2. All non-:ref:`trapping <trap>` :ref:`executions <exec>` of a valid program retain their behaviour with an equivalent set of possible :ref:`results <syntax-result>` (or a non-empty subset).

  .. note::
    This allows previously malformed or invalid programs to become executable.

    It also allows program executions that previously trapped to execute successfully,
    although the intention is to only exercise this where the possibility of such an extension has been previously noted.

    And it allows reducing the set of observable behaviours of a program execution,
    e.g., by reducing non-determinism.

    In a program linking prior modules with modules using new features,
    a prior module may encounter new behaviours,
    e.g., new forms of control flow or side effects when calling into a latter module.

In addition, future versions of WebAssembly will not allocate the :ref:`opcode <binary-instr>` :math:`\hex{FF}` to represent an instruction or instruction prefix.



Release 2.0
~~~~~~~~~~~

.. index:: instruction, integer

Sign Extension Instructions
...........................

Added new numeric instructions for performing sign extension within integer representations. [#proposal-signext]_

* New :ref:`numeric instructions <syntax-instr-numeric>`:

  - :math:`\K{i}\X{nn}\K{.}\EXTEND\X{N}\K{\_s}`


.. index:: instruction, trap, floating-point, integer

Non-trapping Float-to-Int Conversions
.....................................

Added new conversion instructions that avoid trapping when converting a floating-point number to an integer. [#proposal-cvtsat]_

* New :ref:`numeric instructions <syntax-instr-numeric>`:

  - :math:`\K{i}\X{nn}\K{.}\TRUNC\K{\_sat\_f}\X{mm}\K{\_}\sx`


.. index:: block, function, value type, result type

Multiple Values
...............

Generalized the result type of blocks and functions to allow for multiple values; in addition, introduced the ability to have block parameters. [#proposal-multivalue]_

* :ref:`Function types <syntax-functype>` allow more than one result

* :ref:`Block types <syntax-blocktype>` can be arbitrary function types


.. index:: value type, reference, reference type, instruction, element segment

Reference Types
...............

Added |FUNCREF| and |EXTERNREF| as new value types and respective instructions. [#proposal-reftype]_

* New :ref:`reference <syntax-reftype>` :ref:`value types <syntax-valtype>`:

  - |FUNCREF|
  - |EXTERNREF|

* New :ref:`reference instructions <syntax-instr-ref>`:

  - |REFNULL|
  - |REFFUNC|
  - |REFISNULL|

* Extended :ref:`parametric instruction <syntax-instr-parametric>`:

  - |SELECT| with optional type immediate

* New :ref:`declarative <syntax-elemmode>` form of :ref:`element segment <syntax-elem>`


.. index:: reference, instruction, table, table type

Table Instructions
..................

Added instructions to directly access and modify tables. [#proposal-reftype]_

* :ref:`Table types <syntax-tabletype>` allow any :ref:`reference type <syntax-reftype>` as element type

* New :ref:`table instructions <syntax-instr-table>`:

  - |TABLEGET|
  - |TABLESET|
  - |TABLESIZE|
  - |TABLEGROW|


.. index:: table, instruction, table index, element segment, import, export

Multiple Tables
...............

Added the ability to use multiple tables per module. [#proposal-reftype]_

* :ref:`Modules <syntax-module>` may

  - :ref:`define <syntax-table>` multiple tables
  - :ref:`import <syntax-import>` multiple tables
  - :ref:`export <syntax-export>` multiple tables

* :ref:`Table instructions <syntax-instr-table>` take a :ref:`table index <syntax-tableidx>` immediate:

  - |TABLEGET|
  - |TABLESET|
  - |TABLESIZE|
  - |TABLEGROW|
  - |CALLINDIRECT|

* :ref:`Element segments <syntax-elem>` take a :ref:`table index <syntax-tableidx>`


.. index:: instruction, table, memory, data segment, element segment

Bulk Memory and Table Instructions
..................................

Added instructions that modify ranges of memory or table entries. [#proposal-reftype]_ [#proposal-bulk]_

* New :ref:`memory instructions <syntax-instr-memory>`:

  - |MEMORYFILL|
  - |MEMORYINIT|
  - |MEMORYCOPY|
  - |DATADROP|

* New :ref:`table instructions <syntax-instr-table>`:

  - |TABLEFILL|
  - |TABLEINIT|
  - |TABLECOPY|
  - |ELEMDROP|

* New :ref:`passive <syntax-datamode>` form of :ref:`data segment <syntax-data>`

* New :ref:`passive <syntax-elemmode>` form of :ref:`element segment <syntax-elem>`

* New :ref:`data count section <binary-datacountsec>` in binary format

* Active data and element segments boundaries are no longer checked at compile time but may trap instead


.. index:: instructions, SIMD, value type, vector type

Vector Instructions
...................

Added vector type and instructions that manipulate multiple numeric values in parallel
(also known as *SIMD*, single instruction multiple data) [#proposal-vectype]_

* New :ref:`value type <syntax-valtype>`:

  - |V128|

* New :ref:`memory instructions <syntax-instr-memory>`:

  - :math:`\K{v128.}\LOAD`
  - :math:`\K{v128.}\LOAD{}\!N\!\K{x}\!M\!\K{\_}\sx`
  - :math:`\K{v128.}\LOAD{}N\K{\_zero}`
  - :math:`\K{v128.}\LOAD{}N\K{\_splat}`
  - :math:`\K{v128.}\LOAD{}N\K{\_lane}`
  - :math:`\K{v128.}\STORE`
  - :math:`\K{v128.}\STORE{}N\K{\_lane}`

* New constant :ref:`vector instruction <syntax-instr-vec>`:

  - :math:`\K{v128.}\VCONST`

* New unary :ref:`vector instructions <syntax-instr-vec>`:

  - :math:`\K{v128.not}`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.abs}`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.neg}`
  - :math:`\K{i8x16.popcnt}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.abs}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.neg}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.sqrt}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.ceil}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.floor}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.trunc}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.nearest}`

* New binary :ref:`vector instructions <syntax-instr-vec>`:

  - :math:`\K{v128.and}`
  - :math:`\K{v128.andnot}`
  - :math:`\K{v128.or}`
  - :math:`\K{v128.xor}`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.add}`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.sub}`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.mul}`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.add\_sat\_}\sx`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.sub\_sat\_}\sx`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.min\_}\sx`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.max\_}\sx`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.shl}`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.shr\_}\sx`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.add}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.sub}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.mul}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.div}`
  - :math:`\K{i16x8.extadd\_pairwise\_i8x16\_}\sx`
  - :math:`\K{i32x4.extadd\_pairwise\_i16x8\_}\sx`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.extmul\_}\half\K{\_i}\!N'\!\K{x}\!M'\!\K{\_}\sx`
  - :math:`\K{i16x8.q15mulr\_sat\_s}`
  - :math:`\K{i32x4.dot\_i16x8\_s}`
  - :math:`\K{i8x16.avgr\_u}`
  - :math:`\K{i16x8.avgr\_u}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.min}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.max}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.pmin}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.pmax}`

* New ternary :ref:`vector instruction <syntax-instr-vec>`:

  - :math:`\K{v128.bitselect}`

* New test :ref:`vector instructions <syntax-instr-vec>`:

  - :math:`\K{v128.any\_true}`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.all\_true}`

* New relational :ref:`vector instructions <syntax-instr-vec>`:

  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.eq}`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.ne}`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.lt\_}\sx`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.gt\_}\sx`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.le\_}\sx`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.ge\_}\sx`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.eq}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.ne}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.lt}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.gt}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.le}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.ge}`

* New conversion :ref:`vector instructions <syntax-instr-vec>`:

  - :math:`\K{i32x4.trunc\_sat\_f32x4\_}\sx`
  - :math:`\K{i32x4.trunc\_sat\_f64x2\_}\sx\K{\_zero}`
  - :math:`\K{f32x4.convert\_i32x4\_}\sx`
  - :math:`\K{f32x4.demote\_f64x2\_zero}`
  - :math:`\K{f64x2.convert\_low\_i32x4\_}\sx`
  - :math:`\K{f64x2.promote\_low\_f32x4}`

* New lane access :ref:`vector instructions <syntax-instr-vec>`:

  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.extract\_lane\_}\sx^?`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.replace\_lane}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.extract\_lane}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.replace\_lane}`

* New lane splitting/combining :ref:`vector instructions <syntax-instr-vec>`:

  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.extend\_}\half\K{\_i}\!N'\!\K{x}\!M'\!\K{\_}\sx`
  - :math:`\K{i8x16.narrow\_i16x8\_}\sx`
  - :math:`\K{i16x8.narrow\_i32x4\_}\sx`

* New byte reordering :ref:`vector instructions <syntax-instr-vec>`:

  - :math:`\K{i8x16.shuffle}`
  - :math:`\K{i8x16.swizzle}`

* New injection/projection :ref:`vector instructions <syntax-instr-vec>`:

  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.splat}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.splat}`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.bitmask}`


.. [#proposal-signext]
   https://github.com/WebAssembly/spec/tree/main/proposals/sign-extension-ops/

.. [#proposal-cvtsat]
   https://github.com/WebAssembly/spec/tree/main/proposals/nontrapping-float-to-int-conversion/

.. [#proposal-multivalue]
   https://github.com/WebAssembly/spec/tree/main/proposals/multi-value/

.. [#proposal-reftype]
   https://github.com/WebAssembly/spec/tree/main/proposals/reference-types/

.. [#proposal-bulk]
   https://github.com/WebAssembly/spec/tree/main/proposals/bulk-memory-operations/

.. [#proposal-vectype]
   https://github.com/WebAssembly/spec/tree/main/proposals/simd/


Release 3.0
~~~~~~~~~~~

.. index:: instruction, expression, constant

Extended Constant Expressions
.............................

Allowed basic numeric computations in constant expressions. [#proposal-extconst]_

* Extended set of :ref:`constant instructions <valid-const>` with:

  - :math:`\K{i}\X{nn}\K{.add}`
  - :math:`\K{i}\X{nn}\K{.sub}`
  - :math:`\K{i}\X{nn}\K{.mul}`
  - |GLOBALGET| for any previously declared immutable :ref:`global <syntax-global>`

.. note::
   The :ref:`garbage collection <extension-gc>` extension added further constant instructions.


.. index:: instruction, function, call

Tail Calls
..........

Added instructions to perform tail calls. [#proposal-tailcall]_

* New :ref:`control instructions <syntax-instr-control>`:

  - |RETURNCALL|
  - |RETURNCALLINDIRECT|


.. index:: instruction, exception, reference type, tag type, tag, handler

Exception Handling
..................

Added tag definitions, imports, and exports, and instructions to throw and catch exceptions [#proposal-exn]_

* :ref:`Modules <syntax-module>` may

  - :ref:`define <syntax-tag>` tags
  - :ref:`import <syntax-import>` tags
  - :ref:`export <syntax-export>` tags

* New :ref:`heap types <syntax-heaptype>`:

  - |EXN|
  - |NOEXN|

* New :ref:`reference type <syntax-reftype>` short-hands:

  - |EXNREF|
  - |NULLEXNREF|

* New :ref:`control instructions <syntax-instr-control>`:

  - |THROW|
  - |THROWREF|
  - |TRYTABLE|

* New :ref:`tag section <binary-tagsec>` in binary format.


.. index:: instruction, memory, memory index, data segment, import, export

Multiple Memories
.................

Added the ability to use multiple memories per module. [#proposal-multimem]_

* :ref:`Modules <syntax-module>` may

  - :ref:`define <syntax-mem>` multiple memories
  - :ref:`import <syntax-import>` multiple memories
  - :ref:`export <syntax-export>` multiple memories

* :ref:`Memory instructions <syntax-instr-memory>` take a :ref:`memory index <syntax-memidx>` immediate:

  - |MEMORYSIZE|
  - |MEMORYGROW|
  - |MEMORYFILL|
  - |MEMORYCOPY|
  - |MEMORYINIT|
  - :math:`t\K{.load}`
  - :math:`t\K{.store}`
  - :math:`t\K{.load}\!N\!\K{\_}\sx`
  - :math:`t\K{.store}\!N`
  - :math:`\K{v128.load}\!N\!\K{x}\!M\!\K{\_}\sx`
  - :math:`\K{v128.load}\!N\!\K{\_zero}`
  - :math:`\K{v128.load}\!N\!\K{\_splat}`
  - :math:`\K{v128.load}\!N\!\K{\_lane}`
  - :math:`\K{v128.store}\!N\!\K{\_lane}`

* :ref:`Data segments <syntax-elem>` take a :ref:`memory index <syntax-memidx>`


.. index:: address type, number type, table, memory, instruction

64-bit Address Space
....................

Added the ability to declare an :math:`\I64` :ref:`address type <syntax-addrtype>` for :ref:`tables <syntax-tabletype>` and :ref:`memories <syntax-memtype>`. [#proposal-addr64]_

* :ref:`Address types <syntax-addrtype>` denote a subset of the integral :ref:`number types <syntax-numtype>`

* :ref:`Table types <syntax-tabletype>` include an :ref:`address type <syntax-addrtype>`

* :ref:`Memory types <syntax-memtype>` include an :ref:`address type <syntax-addrtype>`

* Operand types of :ref:`table <syntax-instr-table>` and :ref:`memory <syntax-instr-memory>` instructions now depend on the subject's declared address type:

  - |TABLEGET|
  - |TABLESET|
  - |TABLESIZE|
  - |TABLEGROW|
  - |TABLEFILL|
  - |TABLECOPY|
  - |TABLEINIT|
  - |MEMORYSIZE|
  - |MEMORYGROW|
  - |MEMORYFILL|
  - |MEMORYCOPY|
  - |MEMORYINIT|
  - :math:`t\K{.load}`
  - :math:`t\K{.store}`
  - :math:`t\K{.load}\!N\!\K{\_}\sx`
  - :math:`t\K{.store}\!N`
  - :math:`\K{v128.load}\!N\!\K{x}\!M\!\K{\_}\sx`
  - :math:`\K{v128.load}\!N\!\K{\_zero}`
  - :math:`\K{v128.load}\!N\!\K{\_splat}`
  - :math:`\K{v128.load}\!N\!\K{\_lane}`
  - :math:`\K{v128.store}\!N\!\K{\_lane}`


.. index:: reference, reference type, heap type, value type, local, local type, instruction, instruction type, table, function, function type, matching, subtyping

Typeful References
..................

Added more precise types for references. [#proposal-typedref]_

* New generalised form of :ref:`reference types <syntax-reftype>`:

  - :math:`(\REF~\NULL^?~\heaptype)`

* New class of :ref:`heap types <syntax-heaptype>`:

  - |FUNC|
  - |EXTERN|
  - :math:`\typeidx`

* Basic :ref:`subtyping <match>` on :ref:`reference <match-reftype>` and :ref:`value <match-valtype>` types

* New :ref:`reference instructions <syntax-instr-ref>`:

  - |REFASNONNULL|
  - |BRONNULL|
  - |BRONNONNULL|

* New :ref:`control instruction <syntax-instr-control>`:

  - |CALLREF|

* Refined typing of :ref:`reference instruction <syntax-instr-ref>`:

  - |REFFUNC| with more precise result type

* Refined typing of :ref:`local instructions <valid-instr-variable>` and :ref:`instruction sequences <valid-instr-seq>` to track the :ref:`initialization status <syntax-init>` of :ref:`locals <syntax-local>` with non-:ref:`defaultable <valid-defaultable>` type

* Refined decoding of :ref:`active <syntax-elemmode>` :ref:`element segments <binary-elem>` with implicit element type and plain function indices (opcode :math:`0`) to produce :ref:`non-nullable <syntax-nullable>` :ref:`reference type <syntax-reftype>`.

* Extended :ref:`table definitions <syntax-table>` with optional initializer expression


.. index:: reference, reference type, heap type, field type, storage type, structure type, array type, composite type, sub type, recursive type
.. _extension-gc:

Garbage Collection
..................

Added managed reference types. [#proposal-gc]_

* New forms of :ref:`heap types <syntax-heaptype>`:

  - |ANY|
  - |EQT|
  - |I31|
  - |STRUCT|
  - |ARRAY|
  - |NONE|
  - |NOFUNC|
  - |NOEXTERN|

* New :ref:`reference type <syntax-reftype>` short-hands:

  - |ANYREF|
  - |EQREF|
  - |I31REF|
  - |STRUCTREF|
  - |ARRAYREF|
  - |NULLREF|
  - |NULLFUNCREF|
  - |NULLEXTERNREF|

* New forms of type definitions:

  - :ref:`structure <syntax-structtype>`
  - :ref:`array types <syntax-arraytype>`
  - :ref:`sub types <syntax-subtype>`
  - :ref:`recursive types <syntax-rectype>`

* Enriched :ref:`subtyping <match>` based on explicitly declared :ref:`sub types <syntax-subtype>` and the new heap types

* New generic :ref:`reference instructions <syntax-instr-ref>`:

  - |REFEQ|
  - |REFTEST|
  - |REFCAST|
  - |BRONCAST|
  - |BRONCASTFAIL|

* New :ref:`reference instructions <syntax-instr-ref>` for :ref:`unboxed scalars <syntax-i31>`:

  - |REFI31|
  - :math:`\I31GET\K{\_}\sx`

* New :ref:`reference instructions <syntax-instr-ref>` for :ref:`structure types <syntax-structtype>`:

  - |STRUCTNEW|
  - |STRUCTNEWDEFAULT|
  - :math:`\STRUCTGET\K{\_}\sx^?`
  - |STRUCTSET|

* New :ref:`reference instructions <syntax-instr-ref>` for :ref:`array types <syntax-structtype>`:

  - |ARRAYNEW|
  - |ARRAYNEWDEFAULT|
  - |ARRAYNEWFIXED|
  - |ARRAYNEWDATA|
  - |ARRAYNEWELEM|
  - :math:`\ARRAYGET\K{\_}\sx^?`
  - |ARRAYSET|
  - |ARRAYLEN|
  - |ARRAYFILL|
  - |ARRAYCOPY|
  - |ARRAYINITDATA|
  - |ARRAYINITELEM|

* New :ref:`reference instructions <syntax-instr-ref>` for converting :ref:`external types <syntax-externtype>`:

  - |ANYCONVERTEXTERN|
  - |EXTERNCONVERTANY|

* Extended set of :ref:`constant instructions <valid-const>` with:

  - |REFI31|
  - |STRUCTNEW|
  - |STRUCTNEWDEFAULT|
  - |ARRAYNEW|
  - |ARRAYNEWDEFAULT|
  - |ARRAYNEWFIXED|
  - |ANYCONVERTEXTERN|
  - |EXTERNCONVERTANY|


.. index:: instruction, vector instruction, SIMD

Relaxed Vector Instructions
...........................

Added new *relaxed* vector instructions,
whose behaviour is non-deterministic and implementation-dependent. [#proposal-relaxed]_

* New binary :ref:`vector instruction <syntax-instr-relaxed>`:

  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.relaxed\_min}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.relaxed\_max}`
  - :math:`\K{i16x8.relaxed\_q15mulr\_s}`
  - :math:`\K{i16x8.relaxed\_dot\_i8x16\_i7x16\_s}`

* New ternary :ref:`vector instruction <syntax-instr-relaxed>`:

  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.relaxed\_madd}`
  - :math:`\K{f}\!N\!\K{x}\!M\!\K{.relaxed\_nmadd}`
  - :math:`\K{i}\!N\!\K{x}\!M\!\K{.relaxed\_laneselect}`
  - :math:`\K{i32x4.relaxed\_dot\_i8x16\_i7x16\_add\_s}`

* New conversion :ref:`vector instructions <syntax-instr-relaxed>`:

  - :math:`\K{i32x4.relaxed\_trunc\_f32x4\_}\sx`
  - :math:`\K{i32x4.relaxed\_trunc\_f64x2\_}\sx\K{\_zero}`

* New byte reordering :ref:`vector instruction <syntax-instr-relaxed>`:

  - :math:`\K{i8x16.relaxed\_swizzle}`


.. index:: determinism, non-determinism, profiles

Profiles
........

Introduced the concept of :ref:`profile <profiles>` for specifying language subsets.

* A new profile defining a :ref:`deterministic <profile-deterministic>` mode of execution.


.. index:: text format, annotation, custom section, identifier, module, type, function, local, structure field

Custom Annotations
..................

Added generic syntax for custom annotations in the text format,
mirroring the role of custom sections in the binary format. [#proposal-annot]_

* :ref:`Annotations <text-annot>` of the form :math:`\text{(@id~\dots)}` are allowed anywhere in the :ref:`text format <text>`

* :ref:`Identifiers <text-id>` can be escaped as :math:`\text{@"\dots"}` with arbitrary :ref:`names <text-name>`

* Defined :ref:`name annotations <text-nameannot>` :math:`\text{(@name~"\dots")}` for:

  - :ref:`module names <text-modulenameannot>`
  - :ref:`type names <text-typenameannot>`
  - :ref:`function names <text-funcnameannot>`
  - :ref:`local names <text-localnameannot>`
  - :ref:`field names <text-fieldnameannot>`

* Defined :ref:`custom annotation <text-customannot>` :math:`\text{(@custom~"\dots")}` to represent arbitrary :ref:`custom sections <binary-customsec>` in the text format


.. [#proposal-extconst]
   https://github.com/WebAssembly/spec/tree/main/proposals/extended-const/

.. [#proposal-tailcall]
   https://github.com/WebAssembly/spec/tree/main/proposals/tail-call/

.. [#proposal-exn]
   https://github.com/WebAssembly/spec/tree/main/proposals/exception-handling/

.. [#proposal-multimem]
   https://github.com/WebAssembly/spec/tree/main/proposals/multi-memory/

.. [#proposal-addr64]
   https://github.com/WebAssembly/spec/tree/main/proposals/memory64/

.. [#proposal-typedref]
   https://github.com/WebAssembly/spec/tree/main/proposals/function-references/

.. [#proposal-gc]
   https://github.com/WebAssembly/spec/tree/main/proposals/gc/

.. [#proposal-relaxed]
   https://github.com/WebAssembly/spec/tree/main/proposals/relaxed-simd/

.. [#proposal-annot]
   https://github.com/WebAssembly/annotations/tree/main/proposals/annotations/

.. index:: ! module, type definition, function type, function, table, memory, global, element, data, start function, import, export
   pair: abstract syntax; module
.. _syntax-module:

Modules
-------

WebAssembly programs are organized into *modules*,
which are the unit of deployment, loading, and compilation.
A module collects definitions for :ref:`types <syntax-type>`, :ref:`functions <syntax-func>`, :ref:`tables <syntax-table>`, :ref:`memories <syntax-mem>`, and :ref:`globals <syntax-global>`.
In addition, it can declare :ref:`imports <syntax-import>` and :ref:`exports <syntax-export>`
and provide initialization in the form of :ref:`data <syntax-data>` and :ref:`element <syntax-elem>` segments, or a :ref:`start function <syntax-start>`.

.. math::
   \begin{array}{lllll}
   \production{module} & \module &::=& \{ &
     \MTYPES~\vec(\functype), \\&&&&
     \MFUNCS~\vec(\func), \\&&&&
     \MTABLES~\vec(\table), \\&&&&
     \MMEMS~\vec(\mem), \\&&&&
     \MGLOBALS~\vec(\global), \\&&&&
     \MELEMS~\vec(\elem), \\&&&&
     \MDATAS~\vec(\data), \\&&&&
     \MSTART~\start^?, \\&&&&
     \MIMPORTS~\vec(\import), \\&&&&
     \MEXPORTS~\vec(\export) \quad\} \\
   \end{array}

Each of the vectors -- and thus the entire module -- may be empty.


.. index:: ! index, ! index space, ! type index, ! function index, ! table index, ! memory index, ! global index, ! local index, ! label index, ! element index, ! data index, function, global, table, memory, element, data, local, parameter, import
   pair: abstract syntax; type index
   pair: abstract syntax; function index
   pair: abstract syntax; table index
   pair: abstract syntax; memory index
   pair: abstract syntax; global index
   pair: abstract syntax; element index
   pair: abstract syntax; data index
   pair: abstract syntax; local index
   pair: abstract syntax; label index
   pair: type; index
   pair: function; index
   pair: table; index
   pair: memory; index
   pair: global; index
   pair: element; index
   pair: data; index
   pair: local; index
   pair: label; index
.. _syntax-typeidx:
.. _syntax-funcidx:
.. _syntax-tableidx:
.. _syntax-memidx:
.. _syntax-globalidx:
.. _syntax-elemidx:
.. _syntax-dataidx:
.. _syntax-localidx:
.. _syntax-labelidx:
.. _syntax-index:

Indices
~~~~~~~

Definitions are referenced with zero-based *indices*.
Each class of definition has its own *index space*, as distinguished by the following classes.

.. math::
   \begin{array}{llll}
   \production{type index} & \typeidx &::=& \u32 \\
   \production{function index} & \funcidx &::=& \u32 \\
   \production{table index} & \tableidx &::=& \u32 \\
   \production{memory index} & \memidx &::=& \u32 \\
   \production{global index} & \globalidx &::=& \u32 \\
   \production{element index} & \elemidx &::=& \u32 \\
   \production{data index} & \dataidx &::=& \u32 \\
   \production{local index} & \localidx &::=& \u32 \\
   \production{label index} & \labelidx &::=& \u32 \\
   \end{array}

The index space for :ref:`functions <syntax-func>`, :ref:`tables <syntax-table>`, :ref:`memories <syntax-mem>` and :ref:`globals <syntax-global>` includes respective :ref:`imports <syntax-import>` declared in the same module.
The indices of these imports precede the indices of other definitions in the same index space.

Element indices reference :ref:`element segments <syntax-elem>` and data indices reference :ref:`data segments <syntax-data>`.

The index space for :ref:`locals <syntax-local>` is only accessible inside a :ref:`function <syntax-func>` and includes the parameters of that function, which precede the local variables.

Label indices reference :ref:`structured control instructions <syntax-instr-control>` inside an instruction sequence.


.. _free-typeidx:
.. _free-funcidx:
.. _free-tableidx:
.. _free-memidx:
.. _free-globalidx:
.. _free-elemidx:
.. _free-dataidx:
.. _free-localidx:
.. _free-labelidx:
.. _free-index:

Conventions
...........

* The meta variable :math:`l` ranges over label indices.

* The meta variables :math:`x, y` range over indices in any of the other index spaces.

* The notation :math:`\F{idx}(A)` denotes the set of indices from index space :math:`\X{idx}` occurring free in :math:`A`. We sometimes reinterpret this set as the :ref:`vector <syntax-vec>` of its elements.

.. note::
   For example, if :math:`\instr^\ast` is :math:`(\DATADROP~x) (\MEMORYINIT~y)`, then :math:`\freedataidx(\instr^\ast) = \{x, y\}`, or equivalently, the vector :math:`x~y`.


.. index:: ! type definition, type index, function type
   pair: abstract syntax; type definition
.. _syntax-typedef:

Types
~~~~~

The |MTYPES| component of a module defines a vector of :ref:`function types <syntax-functype>`.

All function types used in a module must be defined in this component.
They are referenced by :ref:`type indices <syntax-typeidx>`.

.. note::
   Future versions of WebAssembly may add additional forms of type definitions.


.. index:: ! function, ! local, function index, local index, type index, value type, expression, import
   pair: abstract syntax; function
   pair: abstract syntax; local
.. _syntax-local:
.. _syntax-func:

Functions
~~~~~~~~~

The |MFUNCS| component of a module defines a vector of *functions* with the following structure:

.. math::
   \begin{array}{llll}
   \production{function} & \func &::=&
     \{ \FTYPE~\typeidx, \FLOCALS~\vec(\valtype), \FBODY~\expr \} \\
   \end{array}

The |FTYPE| of a function declares its signature by reference to a :ref:`type <syntax-type>` defined in the module.
The parameters of the function are referenced through 0-based :ref:`local indices <syntax-localidx>` in the function's body; they are mutable.

The |FLOCALS| declare a vector of mutable local variables and their types.
These variables are referenced through :ref:`local indices <syntax-localidx>` in the function's body.
The index of the first local is the smallest index not referencing a parameter.

The |FBODY| is an :ref:`instruction <syntax-expr>` sequence that upon termination must produce a stack matching the function type's :ref:`result type <syntax-resulttype>`.

Functions are referenced through :ref:`function indices <syntax-funcidx>`,
starting with the smallest index not referencing a function :ref:`import <syntax-import>`.


.. index:: ! table, table index, table type, limits, element, import
   pair: abstract syntax; table
.. _syntax-table:

Tables
~~~~~~

The |MTABLES| component of a module defines a vector of *tables* described by their :ref:`table type <syntax-tabletype>`:

.. math::
   \begin{array}{llll}
   \production{table} & \table &::=&
     \{ \TTYPE~\tabletype \} \\
   \end{array}

A table is a vector of opaque values of a particular :ref:`reference type <syntax-reftype>`.
The |LMIN| size in the :ref:`limits <syntax-limits>` of the table type specifies the initial size of that table, while its |LMAX|, if present, restricts the size to which it can grow later.

Tables can be initialized through :ref:`element segments <syntax-elem>`.

Tables are referenced through :ref:`table indices <syntax-tableidx>`,
starting with the smallest index not referencing a table :ref:`import <syntax-import>`.
Most constructs implicitly reference table index :math:`0`.

.. index:: ! memory, memory index, memory type, limits, page size, data, import
   pair: abstract syntax; memory
.. _syntax-mem:

Memories
~~~~~~~~

The |MMEMS| component of a module defines a vector of *linear memories* (or *memories* for short) as described by their :ref:`memory type <syntax-memtype>`:

.. math::
   \begin{array}{llll}
   \production{memory} & \mem &::=&
     \{ \MTYPE~\memtype \} \\
   \end{array}

A memory is a vector of raw uninterpreted bytes.
The |LMIN| size in the :ref:`limits <syntax-limits>` of the memory type specifies the initial size of that memory, while its |LMAX|, if present, restricts the size to which it can grow later.
Both are in units of :ref:`page size <page-size>`.

Memories can be initialized through :ref:`data segments <syntax-data>`.

Memories are referenced through :ref:`memory indices <syntax-memidx>`,
starting with the smallest index not referencing a memory :ref:`import <syntax-import>`.
Most constructs implicitly reference memory index :math:`0`.

.. note::
   In the current version of WebAssembly, at most one memory may be defined or imported in a single module,
   and *all* constructs implicitly reference this memory :math:`0`.
   This restriction may be lifted in future versions.


.. index:: ! global, global index, global type, mutability, expression, constant, value, import
   pair: abstract syntax; global
.. _syntax-global:

Globals
~~~~~~~

The |MGLOBALS| component of a module defines a vector of *global variables* (or *globals* for short):

.. math::
   \begin{array}{llll}
   \production{global} & \global &::=&
     \{ \GTYPE~\globaltype, \GINIT~\expr \} \\
   \end{array}

Each global stores a single value of the given :ref:`global type <syntax-globaltype>`.
Its |GTYPE| also specifies whether a global is immutable or mutable.
Moreover, each global is initialized with an |GINIT| value given by a :ref:`constant <valid-constant>` initializer :ref:`expression <syntax-expr>`.

Globals are referenced through :ref:`global indices <syntax-globalidx>`,
starting with the smallest index not referencing a global :ref:`import <syntax-import>`.


.. index:: ! element, ! element mode, ! active, ! passive, ! declarative, element index, table, table index, expression, constant, function index, vector
   pair: abstract syntax; element
   pair: abstract syntax; element mode
   single: table; element
   single: element; segment
   single: element; mode
.. _syntax-elem:
.. _syntax-elemmode:

Element Segments
~~~~~~~~~~~~~~~~

The initial contents of a table is uninitialized. *Element segments* can be used to initialize a subrange of a table from a static :ref:`vector <syntax-vec>` of elements.

The |MELEMS| component of a module defines a vector of element segments.
Each element segment defines a :ref:`reference type <syntax-reftype>` and a corresponding list of :ref:`constant <valid-constant>` element :ref:`expressions <syntax-expr>`.

Element segments have a mode that identifies them as either *passive*, *active*, or *declarative*.
A passive element segment's elements can be copied to a table using the |TABLEINIT| instruction.
An active element segment copies its elements into a table during :ref:`instantiation <exec-instantiation>`, as specified by a :ref:`table index <syntax-tableidx>` and a :ref:`constant <valid-constant>` :ref:`expression <syntax-expr>` defining an offset into that table.
A declarative element segment is not available at runtime but merely serves to forward-declare references that are formed in code with instructions like :math:`\REFFUNC`.

.. math::
   \begin{array}{llll}
   \production{element segment} & \elem &::=&
     \{ \ETYPE~\reftype, \EINIT~\vec(\expr), \EMODE~\elemmode \} \\
   \production{element segment mode} & \elemmode &::=&
     \EPASSIVE \\&&|&
     \EACTIVE~\{ \ETABLE~\tableidx, \EOFFSET~\expr \} \\&&|&
     \EDECLARATIVE \\
   \end{array}

The |EOFFSET| is given by a :ref:`constant <valid-constant>` :ref:`expression <syntax-expr>`.

Element segments are referenced through :ref:`element indices <syntax-elemidx>`.

.. note::
   In the current version of WebAssembly, only tables of element type |FUNCREF| can be initialized with an element segment.
   This limitation may be lifted in the future.


.. index:: ! data, active, passive, data index, memory, memory index, expression, constant, byte, vector
   pair: abstract syntax; data
   single: memory; data
   single: data; segment
.. _syntax-data:
.. _syntax-datamode:

Data Segments
~~~~~~~~~~~~~

The initial contents of a :ref:`memory <syntax-mem>` are zero bytes. *Data segments* can be used to initialize a range of memory from a static :ref:`vector <syntax-vec>` of :ref:`bytes <syntax-byte>`.

The |MDATAS| component of a module defines a vector of data segments.

Like element segments, data segments have a mode that identifies them as either *passive* or *active*.
A passive data segment's contents can be copied into a memory using the |MEMORYINIT| instruction.
An active data segment copies its contents into a memory during :ref:`instantiation <exec-instantiation>`, as specified by a :ref:`memory index <syntax-memidx>` and a :ref:`constant <valid-constant>` :ref:`expression <syntax-expr>` defining an offset into that memory.

.. math::
   \begin{array}{llll}
   \production{data segment} & \data &::=&
     \{ \DINIT~\vec(\byte), \DMODE~\datamode \} \\
   \production{data segment mode} & \datamode &::=&
     \DPASSIVE \\&&|&
     \DACTIVE~\{ \DMEM~\memidx, \DOFFSET~\expr \} \\
   \end{array}

Data segments are referenced through :ref:`data indices <syntax-dataidx>`.

.. note::
   In the current version of WebAssembly, at most one memory is allowed in a module.
   Consequently, the only valid |memidx| is :math:`0`.


.. index:: ! start function, function, function index, table, memory, instantiation
   pair: abstract syntax; start function
.. _syntax-start:

Start Function
~~~~~~~~~~~~~~

The |MSTART| component of a module declares the :ref:`function index <syntax-funcidx>` of a *start function* that is automatically invoked when the module is :ref:`instantiated <exec-instantiation>`, after :ref:`tables <syntax-table>` and :ref:`memories <syntax-mem>` have been initialized.

.. math::
   \begin{array}{llll}
   \production{start function} & \start &::=&
     \{ \SFUNC~\funcidx \} \\
   \end{array}

.. note::
   The start function is intended for initializing the state of a module.
   The module and its exports are not accessible before this initialization has completed.


.. index:: ! export, name, index, function index, table index, memory index, global index, function, table, memory, global, instantiation
   pair: abstract syntax; export
   single: function; export
   single: table; export
   single: memory; export
   single: global; export
.. _syntax-exportdesc:
.. _syntax-export:

Exports
~~~~~~~

The |MEXPORTS| component of a module defines a set of *exports* that become accessible to the host environment once the module has been :ref:`instantiated <exec-instantiation>`.

.. math::
   \begin{array}{llcl}
   \production{export} & \export &::=&
     \{ \ENAME~\name, \EDESC~\exportdesc \} \\
   \production{export description} & \exportdesc &::=&
     \EDFUNC~\funcidx \\&&|&
     \EDTABLE~\tableidx \\&&|&
     \EDMEM~\memidx \\&&|&
     \EDGLOBAL~\globalidx \\
   \end{array}

Each export is labeled by a unique :ref:`name <syntax-name>`.
Exportable definitions are :ref:`functions <syntax-func>`, :ref:`tables <syntax-table>`, :ref:`memories <syntax-mem>`, and :ref:`globals <syntax-global>`,
which are referenced through a respective descriptor.


Conventions
...........

The following auxiliary notation is defined for sequences of exports, filtering out indices of a specific kind in an order-preserving fashion:

* :math:`\edfuncs(\export^\ast) = [\funcidx ~|~ \EDFUNC~\funcidx \in (\export.\EDESC)^\ast]`

* :math:`\edtables(\export^\ast) = [\tableidx ~|~ \EDTABLE~\tableidx \in (\export.\EDESC)^\ast]`

* :math:`\edmems(\export^\ast) = [\memidx ~|~ \EDMEM~\memidx \in (\export.\EDESC)^\ast]`

* :math:`\edglobals(\export^\ast) = [\globalidx ~|~ \EDGLOBAL~\globalidx \in (\export.\EDESC)^\ast]`


.. index:: ! import, name, function type, table type, memory type, global type, index, index space, type index, function index, table index, memory index, global index, function, table, memory, global, instantiation
   pair: abstract syntax; import
   single: function; import
   single: table; import
   single: memory; import
   single: global; import
.. _syntax-importdesc:
.. _syntax-import:

Imports
~~~~~~~

The |MIMPORTS| component of a module defines a set of *imports* that are required for :ref:`instantiation <exec-instantiation>`.

.. math::
   \begin{array}{llll}
   \production{import} & \import &::=&
     \{ \IMODULE~\name, \INAME~\name, \IDESC~\importdesc \} \\
   \production{import description} & \importdesc &::=&
     \IDFUNC~\typeidx \\&&|&
     \IDTABLE~\tabletype \\&&|&
     \IDMEM~\memtype \\&&|&
     \IDGLOBAL~\globaltype \\
   \end{array}

Each import is labeled by a two-level :ref:`name <syntax-name>` space, consisting of a |IMODULE| name and a |INAME| for an entity within that module.
Importable definitions are :ref:`functions <syntax-func>`, :ref:`tables <syntax-table>`, :ref:`memories <syntax-mem>`, and :ref:`globals <syntax-global>`.
Each import is specified by a descriptor with a respective type that a definition provided during instantiation is required to match.

Every import defines an index in the respective :ref:`index space <syntax-index>`.
In each index space, the indices of imports go before the first index of any definition contained in the module itself.

.. note::
   Unlike export names, import names are not necessarily unique.
   It is possible to import the same |IMODULE|/|INAME| pair multiple times;
   such imports may even have different type descriptions, including different kinds of entities.
   A module with such imports can still be instantiated depending on the specifics of how an :ref:`embedder <embedder>` allows resolving and supplying imports.
   However, embedders are not required to support such overloading,
   and a WebAssembly module itself cannot implement an overloaded name.

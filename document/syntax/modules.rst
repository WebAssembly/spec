.. _syntax-module:
.. index:: ! modules, type definition, function type, function, table, memory, global, element, data, start function, import, export
   pair: abstract syntax; module

Modules
-------

WebAssembly programs are organized into *modules*,
which are the unit of deployment, loading, and compilation.
A module collects definitions for :ref:`types <syntax-type>`, :ref:`functions <syntax-func>`, :ref:`tables <syntax-table>`, :ref:`memories <syntax-mem>`, and :ref:`globals <syntax-global>`.
In addition, it can declare :ref:`imports <syntax-import>` and :ref:`exports <syntax-export>`
and provide initialization logic in the form of :ref:`data <syntax-data>` and :ref:`element <syntax-elem>` segments or a :ref:`start function <syntax-start>`.

.. math::
   \begin{array}{lllll}
   \production{modules} & \module &::=& \{ &
     \TYPES~\vec(\functype), \\&&&&
     \FUNCS~\vec(\func), \\&&&&
     \TABLES~\vec(\table), \\&&&&
     \MEMS~\vec(\mem), \\&&&&
     \GLOBALS~\vec(\global), \\&&&&
     \ELEM~\vec(\elem), \\&&&&
     \DATA~\vec(\data), \\&&&&
     \START~\start^?, \\&&&&
     \IMPORTS~\vec(\import), \\&&&&
     \EXPORTS~\vec(\export) \quad\} \\
   \end{array}

Each of the vectors -- and thus the entire module -- may be empty.


.. _syntax-index:
.. _syntax-typeidx:
.. _syntax-funcidx:
.. _syntax-tableidx:
.. _syntax-memidx:
.. _syntax-globalidx:
.. _syntax-localidx:
.. _syntax-labelidx:
.. index:: ! index, ! index space, ! type index, ! function index, ! table index, ! memory index, ! global index, ! local index, ! label index
   pair: abstract syntax; type index
   pair: abstract syntax; function index
   pair: abstract syntax; table index
   pair: abstract syntax; memory index
   pair: abstract syntax; global index
   pair: abstract syntax; local index
   pair: abstract syntax; label index
   pair: type; index
   pair: function; index
   pair: table; index
   pair: memory; index
   pair: global; index
   pair: local; index
   pair: label; index

Indices
~~~~~~~

Definitions are referenced with zero-based *indices*.
Each class of definition has its own *index space*, as distinguished by the following classes.

.. math::
   \begin{array}{llll}
   \production{type indices} & \typeidx &::=& \u32 \\
   \production{function indices} & \funcidx &::=& \u32 \\
   \production{table indices} & \tableidx &::=& \u32 \\
   \production{memory indices} & \memidx &::=& \u32 \\
   \production{global indices} & \globalidx &::=& \u32 \\
   \production{local indices} & \localidx &::=& \u32 \\
   \production{label indices} & \labelidx &::=& \u32 \\
   \end{array}

The index space for functions, tables, memories and globals includes respective imports declared in the same module.
The indices of these imports precede the indices of other definitions in the same index space.

The index space for locals is only accessible inside a function and includes the parameters and local variables of that function, which precede the other locals.

Label indices reference block instructions inside an instruction sequence.


Conventions
...........

* The meta variable :math:`l` ranges over label indices.

* The meta variables :math:`x, y` ranges over indices in any of the other index spaces.


.. _syntax-expr:
.. index:: ! expression
   pair: abstract syntax; expression
   single: expression; constant

Expressions
~~~~~~~~~~~

:ref:`Function <syntax-func>` bodies, initialization values for :ref:`globals <syntax-global>` and offsets of :ref:`element <syntax-elem>` or :ref:`data <syntax-data>` segments are given as expressions, which are sequences of :ref:`instructions <syntax-instr>` terminated by an |END| marker.

.. math::
   \begin{array}{llll}
   \production{expressions} & \expr &::=&
     \instr^\ast~\END \\
   \end{array}

In some places, validation :ref:`restricts <valid-const>` expressions to be *constant*, which limits the set of allowable insructions.


.. _syntax-type:
.. index:: ! type definition, type index
   pair: abstract syntax; type definition
   single: type; definition

Types
~~~~~

The |TYPES| component of a module defines a vector of :ref:`function types <syntax-functype>`.

All function types used in a module must be defined in the type section.
They are referenced by :ref:`type indices <syntax-typeidx>`.

.. note::
   Future versions of WebAssembly may add additional forms of type definitions.


.. _syntax-func:
.. _syntax-local:
.. index:: ! function, ! local, function index, local index, type index, value type, expression, import
   pair: abstract syntax; function

Functions
~~~~~~~~~

The |FUNCS| component of a module defines a vector of *functions* with the following structure:

.. math::
   \begin{array}{llll}
   \production{functions} & \func &::=&
     \{ \TYPE~\typeidx, \LOCALS~\vec(\valtype), \BODY~\expr \} \\
   \end{array}

The |TYPE| of a function declares its signature by reference to a :ref:`type <syntax-type>` defined in the module.
The parameters of the function are referenced through 0-based :ref:`local indices <syntax-localidx>` in the function's body.

The |LOCALS| declare a vector of mutable local variables and their types.
These variables are referenced through :ref:`local indices <syntax-localidx>` in the function's body.
The index of the first local is the smallest index not referencing a parameter.

The |BODY| is an :ref:`instruction <syntax-expr>` sequence that upon termination must produce a stack matching the function type's :ref:`result type <syntax-resulttype>`.

Functions are referenced through :ref:`function indices <syntax-funcidx>`,
starting with the smallest index not referencing a function :ref:`import <syntax-import>`.


.. _syntax-table:
.. index:: ! table, table index, table type, limits, element, import
   pair: abstract syntax; table

Tables
~~~~~~

The |TABLES| component of a module defines a vector of *tables* described by their :ref:`table type <syntax-tabletype>`:

.. math::
   \begin{array}{llll}
   \production{tables} & \table &::=&
     \{ \TYPE~\tabletype \} \\
   \end{array}

A table is a vector of opaque values of a particular table :ref:`element type <syntax-elemtype>`.
The |MIN| size in the :ref:`limits <syntax-limits>` of the table type of a definition specifies the initial size of that table, while its |MAX|, if present, restricts the size to which it can grow later.

Tables can be initialized through :ref:`element segments <syntax-elem>`.

Tables are referenced through :ref:`table indices <syntax-tableidx>`,
starting with the smallest index not referencing a table :ref:`import <syntax-import>`.
Most constructs implicitly reference table index :math:`0`.

.. note::
   In the current version of WebAssembly, at most one table may be defined or imported in a single module,
   and *all* constructs implicitly reference this table :math:`0`.
   This restriction may be lifted in future versions.


.. _syntax-mem:
.. index:: ! memory, memory index, memory type, limits, page size, data, import
   pair: abstract syntax; memory

Memories
~~~~~~~~

The |MEMS| component of a module defines a vector of *linear memories* (or *memories* for short) as described by their :ref:`memory type <syntax-memtype>`:

.. math::
   \begin{array}{llll}
   \production{memories} & \mem &::=&
     \{ \TYPE~\memtype \} \\
   \end{array}

A memory is a vector of raw uninterpreted bytes.
The |MIN| size in the :ref:`limits <syntax-limits>` of the memory type of a definition specifies the initial size of that memory, while its |MAX|, if present, restricts the size to which it can grow later.
Both are in units of :ref:`page size <page-size>`.

Memories can be initialized through :ref:`data segments <syntax-data>`.

Memories are referenced through :ref:`memory indices <syntax-memidx>`,
starting with the smallest index not referencing a memory :ref:`import <syntax-import>`.
Most constructs implicitly reference memory index :math:`0`.

.. note::
   In the current version of WebAssembly, at most one memory may be defined or imported in a single module,
   and *all* constructs implicitly reference this memory :math:`0`.
   This restriction may be lifted in future versions.


.. _syntax-global:
.. index:: ! global, global index, global type, mutability, expression
   pair: abstract syntax; global

Globals
~~~~~~~

The |GLOBALS| component of a module defines a vector of *global variables* (or *globals* for short):

.. math::
   \begin{array}{llll}
   \production{globals} & \global &::=&
     \{ \TYPE~\globaltype, \INIT~\expr \} \\
   \end{array}

Each global stores a single value of the given :ref:`global type <syntax-globaltype>`.
Its |TYPE| also specifies whether a global is immutable or mutable.
Moreover, each global is initialized with an |INIT| value given by a :ref:`constant <valid-const>` initializer :ref:`expression <syntax-expr>`.

Globals are referenced through :ref:`global indices <syntax-globalidx>`,
starting with the smallest index not referencing a global :ref:`import <syntax-import>`.


.. _syntax-elem:
.. index:: ! element, table, table index, expression, function index, vector
   pair: abstract syntax; element
   single: table; element
   single: element; segment

Element Segments
~~~~~~~~~~~~~~~~

The initial contents of a table is uninitialized.
The |ELEM| component of a module defines a vector of *element segments* that initialize a subrange of a table at a given offset from a static vector of elements.

.. math::
   \begin{array}{llll}
   \production{element segments} & \elem &::=&
     \{ \TABLE~\tableidx, \OFFSET~\expr, \INIT~\vec(\funcidx) \} \\
   \end{array}

The |OFFSET| is given by a :ref:`constant <valid-const>` :ref:`expression <syntax-expr>`.

.. note::
   In the current version of WebAssembly, at most one table is allowed in a module.
   Consequently, the only valid |tableidx| is :math:`0`.


.. _syntax-data:
.. index:: ! data, memory, memory index, expression, byte, vector
   pair: abstract syntax; data
   single: memory; data
   single: data; segment

Data Segments
~~~~~~~~~~~~~

The initial contents of a :ref:`memory <syntax-memory>` are zero bytes.
The |DATA| component of a module defines a vector of *data segments* that initialize a range of memory at a given offset with a static vector of bytes.

.. math::
   \begin{array}{llll}
   \production{data segments} & \data &::=&
     \{ \MEM~\memidx, \OFFSET~\expr, \INIT~\vec(\by) \} \\
   \end{array}

The |OFFSET| is given by a :ref:`constant <valid-const>` :ref:`expression <syntax-expr>`.

.. note::
   In the current version of WebAssembly, at most one memory is allowed in a module.
   Consequently, the only valid |memidx| is :math:`0`.


.. _syntax-start:
.. index:: ! start function, function index, table, memory, instantiation
   pair: abstract syntax; start function

Start Function
~~~~~~~~~~~~~~

The |START| component of a module optionally declares the :ref:`function index <syntax-idx>` of a *start function* that is automatically invoked when the module is :ref:`instantiated <instantiation>`, after tables and memories have been initialized.

.. math::
   \begin{array}{llll}
   \production{start function} & \start &::=&
     \{ \FUNC~\funcidx \} \\
   \end{array}


.. _syntax-export:
.. index:: ! export, name, index, function index, table index, memory index, global index, function, table, memory, global, instantiation
   pair: abstract syntax; export
   single: function; export
   single: table; export
   single: memory; export
   single: global; export

Exports
~~~~~~~

The |EXPORTS| component of a module defines a set of *exports* that become accessible to the host environment once the module has been :ref:`instantiated <instantiation>`.

.. math::
   \begin{array}{llll}
   \production{exports} & \export &::=&
     \{ \NAME~\name, \DESC~\exportdesc \} \\
   \production{export descriptions} & \exportdesc &::=&
     \FUNC~\funcidx ~|~ \\&&&
     \TABLE~\tableidx ~|~ \\&&&
     \MEM~\memidx ~|~ \\&&&
     \GLOBAL~\globalidx \\
   \end{array}

Each export is identified by a unique :ref:`name <syntax-name>`.
Exportable definitions are :ref:`functions <syntax-func>`, :ref:`tables <syntax-table>`, :ref:`memories <syntax-mem>`, and :ref:`globals <syntax-global>`,
which are referenced through a respective descriptor.

.. note::
   In the current version of WebAssembly, only *immutable* globals may be exported.


.. _syntax-import:
.. index:: ! import, name, function type, table type, memory type, global type, index, index space, type index, function index, table index, memory index, global index, function, table, memory, global, instantiation
   pair: abstract syntax; import
   single: function; import
   single: table; import
   single: memory; import
   single: global; import

Imports
~~~~~~~

The |IMPORTS| component of a module defines a set of *imports* that are required for :ref:`instantiation <instantiation>`.

.. math::
   \begin{array}{llll}
   \production{imports} & \import &::=&
     \{ \MODULE~\name, \NAME~\name, \DESC~\importdesc \} \\
   \production{import descriptions} & \importdesc &::=&
     \FUNC~\typeidx ~|~ \\&&&
     \TABLE~\tabletype ~|~ \\&&&
     \MEM~\memtype ~|~ \\&&&
     \GLOBAL~\globaltype \\
   \end{array}

Each import is identified by a two-level :ref:`name <syntax-name>` space, consisting of a |MODULE| name and a unique |NAME| for an entity within that module.
Importable definitions are :ref:`functions <syntax-func>`, :ref:`tables <syntax-table>`, :ref:`memories <syntax-mem>`, and :ref:`globals <syntax-global>`.
Each import is specified by a descriptor with a respective type that a definition provided during instantiation is required to match.

Every import defines an index in the respective :ref:`index space <syntax-indices>`.
In each index space, the indices of imports go before the first index of any definition contained in the module itself.

.. note::
   In the current version of WebAssembly, only *immutable* globals may be imported.

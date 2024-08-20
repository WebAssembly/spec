.. index:: ! module, type definition, function type, tag type, function, table, memory, tag, global, element, data, start function, import, export
   pair: abstract syntax; module
.. _syntax-module:

Modules
-------

WebAssembly programs are organized into *modules*,
which are the unit of deployment, loading, and compilation.
A module collects definitions for
:ref:`types <syntax-type>`,
:ref:`functions <syntax-func>`,
:ref:`tables <syntax-table>`,
:ref:`memories <syntax-mem>`,
:ref:`tags <syntax-tag>`, and
:ref:`globals <syntax-global>`.
In addition, it can declare
:ref:`imports <syntax-import>` and :ref:`exports <syntax-export>`
and provide initialization in the form of
:ref:`data <syntax-data>` and :ref:`element <syntax-elem>` segments,
or a :ref:`start function <syntax-start>`.

$${syntax: module}

Each of the lists --- and thus the entire module --- may be empty.


.. index:: ! index, ! index space, ! type index, ! function index, ! table index, ! memory index, ! global index, ! tag index, ! local index, ! label index, ! element index, ! data index, ! field index, function, global, table, memory, tag, element, data, local, parameter, import, field
   pair: abstract syntax; type index
   pair: abstract syntax; function index
   pair: abstract syntax; table index
   pair: abstract syntax; memory index
   pair: abstract syntax; global index
   pair: abstract syntax; tag index
   pair: abstract syntax; element index
   pair: abstract syntax; data index
   pair: abstract syntax; local index
   pair: abstract syntax; label index
   pair: abstract syntax; field index
   pair: type; index
   pair: function; index
   pair: table; index
   pair: memory; index
   pair: global; index
   pair: tag; index
   pair: element; index
   pair: data; index
   pair: local; index
   pair: label; index
   pair: field; index
.. _syntax-idx:
.. _syntax-typeidx:
.. _syntax-funcidx:
.. _syntax-tableidx:
.. _syntax-memidx:
.. _syntax-globalidx:
.. _syntax-tagidx:
.. _syntax-elemidx:
.. _syntax-dataidx:
.. _syntax-localidx:
.. _syntax-labelidx:
.. _syntax-fieldidx:
.. _syntax-index:

Indices
~~~~~~~

Definitions are referenced with zero-based *indices*.
Each class of definition has its own *index space*, as distinguished by the following classes.

$${syntax: {typeidx funcidx globalidx tableidx memidx tagidx elemidx dataidx labelidx localidx fieldidx}}

The index space for
:ref:`functions <syntax-func>`,
:ref:`tables <syntax-table>`,
:ref:`memories <syntax-mem>`,
:ref:`globals <syntax-global>`, and
:ref:`tags <syntax-tag>`
includes respective :ref:`imports <syntax-import>` declared in the same module.
The indices of these imports precede the indices of other definitions in the same index space.

Element indices reference :ref:`element segments <syntax-elem>` and data indices reference :ref:`data segments <syntax-data>`.

The index space for :ref:`locals <syntax-local>` is only accessible inside a :ref:`function <syntax-func>` and includes the parameters of that function, which precede the local variables.

Label indices reference :ref:`structured control instructions <syntax-instr-control>` inside an instruction sequence.

Each :ref:`aggregate type <syntax-aggrtype>` provides an index space for its :ref:`fields <syntax-fieldtype>`.


Conventions
...........

* The meta variable ${:l} ranges over label indices.

* The meta variables ${:x}, ${:y} range over indices in any of the other index spaces.

.. _free-typeidx:
.. _free-funcidx:
.. _free-tableidx:
.. _free-memidx:
.. _free-globalidx:
.. _free-tagidx:
.. _free-elemidx:
.. _free-dataidx:
.. _free-localidx:
.. _free-labelidx:
.. _free-fieldidx:
.. _free-index:

* For every index space ${-:abcidx}, the notation ${-:$abcidx(A)} denotes the set of indices from that index space occurring free in ${:A}. Sometimes this set is reinterpreted as the :ref:`list <syntax-list>` of its elements.

.. note::
   For example, if ${:instr*} is ${instr*: (DATA.DROP 1) (MEMORY.INIT 2 3)}, then ${:$dataidx_instrs(instr*) = 1 3}, or equivalently, the set ${:`{1, 3}}.


.. index:: ! type definition, type index, function type, aggregate type
   pair: abstract syntax; type definition
.. _syntax-type:
.. _syntax-typedef:

Types
~~~~~

The ${:type} section of a module defines a list of :ref:`recursive types <syntax-rectype>`, each consisting of a list of :ref:`sub types <syntax-subtype>` referenced by individual :ref:`type indices <syntax-typeidx>`.
All :ref:`function <syntax-functype>` or :ref:`aggregate <syntax-aggrtype>` types used in a module must be defined in this section.

$${syntax: type}


.. index:: ! function, ! local, function index, local index, type index, value type, expression, import
   pair: abstract syntax; function
   pair: abstract syntax; local
.. _syntax-local:
.. _syntax-func:

Functions
~~~~~~~~~

The ${:func} section of a module defines a list of *functions* with the following structure:

$${syntax: {func local}}

The :ref:`type index <syntax-typeidx>` of a function declares its signature by reference to a :ref:`function type <syntax-functype>` defined in the module.
The parameters of the function are referenced through 0-based :ref:`local indices <syntax-localidx>` in the function's body; they are mutable.

The locals declare a list of mutable local variables and their types.
These variables are referenced through :ref:`local indices <syntax-localidx>` in the function's body.
The index of the first local is the smallest index not referencing a parameter.

A function's :ref:`expression <syntax-expr>` is an :ref:`instruction <syntax-instr>` sequence that represents the body of the function.
Upon termination it must produce a stack matching the function type's :ref:`result type <syntax-resulttype>`.

Functions are referenced through :ref:`function indices <syntax-funcidx>`,
starting with the smallest index not referencing a function :ref:`import <syntax-import>`.


.. index:: ! table, table index, table type, limits, element, import
   pair: abstract syntax; table
.. _syntax-table:

Tables
~~~~~~

The ${:table} section of a module defines a list of *tables* described by their :ref:`table type <syntax-tabletype>`:

$${syntax: table}

A table is an array of opaque values of a particular :ref:`reference type <syntax-reftype>` that is specified by the :ref:`table type <syntax-tabletype>`.
Each table slot is initialized with a value given by a :ref:`constant <valid-constant>` initializer :ref:`expression <syntax-expr>`.
Tables can further be initialized through :ref:`element segments <syntax-elem>`.

The minimum size in the :ref:`limits <syntax-limits>` of the table type specifies the initial size of that table, while its maximum restricts the size to which it can grow later.

Tables are referenced through :ref:`table indices <syntax-tableidx>`,
starting with the smallest index not referencing a table :ref:`import <syntax-import>`.
Most constructs implicitly reference table index ${:0}.

.. index:: ! memory, memory index, memory type, limits, page size, data, import
   pair: abstract syntax; memory
.. _syntax-mem:

Memories
~~~~~~~~

The ${:mem} section of a module defines a list of *linear memories* (or *memories* for short) as described by their :ref:`memory type <syntax-memtype>`:

$${syntax: mem}

A memory is a list of raw uninterpreted bytes.
The minimum size in the :ref:`limits <syntax-limits>` of its :ref:`memory type <syntax-memtype>` specifies the initial size of that memory, while its maximum, if present, restricts the size to which it can grow later.
Both are in units of :ref:`page size <page-size>`.

Memories can be initialized through :ref:`data segments <syntax-data>`.

Memories are referenced through :ref:`memory indices <syntax-memidx>`,
starting with the smallest index not referencing a memory :ref:`import <syntax-import>`.
Most constructs implicitly reference memory index ${:0}.


.. index:: ! global, global index, global type, mutability, expression, constant, value, import
   pair: abstract syntax; global
.. _syntax-global:

Globals
~~~~~~~

The ${:global} section of a module defines a list of *global variables* (or *globals* for short):

$${syntax: global}

Each global stores a single value of the type specified in the :ref:`global type <syntax-globaltype>`.
It also specifies whether a global is immutable or mutable.
Moreover, each global is initialized with a value given by a :ref:`constant <valid-constant>` initializer :ref:`expression <syntax-expr>`.

Globals are referenced through :ref:`global indices <syntax-globalidx>`,
starting with the smallest index not referencing a global :ref:`import <syntax-import>`.


.. index:: ! tag, type index, tag type
   pair: abstract syntax; tag
.. _syntax-tag:

Tags
~~~~

The ${:tag} section of a module defines a list of *tags*:

$${syntax: tag}

The :ref:`type index <syntax-typeidx>` of a tag must refer to a :ref:`function type <syntax-functype>` that declares its :ref:`tag type <syntax-tagtype>`.

Tags are referenced through :ref:`tag indices <syntax-tagidx>`,
starting with the smallest index not referencing a tag :ref:`import <syntax-import>`.


.. index:: ! element, ! element mode, ! active, ! passive, ! declarative, element index, table, table index, expression, constant, function index, list
   pair: abstract syntax; element
   pair: abstract syntax; element mode
   single: table; element
   single: element; segment
   single: element; mode
.. _syntax-elem:
.. _syntax-elemmode:

Element Segments
~~~~~~~~~~~~~~~~

The ${:elem} section of a module defines a list of *element segments*,
which can be used to initialize a subrange of a table from a static :ref:`list <syntax-list>` of elements.

$${syntax: {elem elemmode}}

Each element segment defines a :ref:`reference type <syntax-reftype>` and a corresponding list of :ref:`constant <valid-constant>` element :ref:`expressions <syntax-expr>`.

Element segments have a mode that identifies them as either *active*, *passive*, or *declarative*.
A passive element segment's elements can be copied to a table using the ${:TABLE.INIT} instruction.
An active element segment copies its elements into a table during :ref:`instantiation <exec-instantiation>`, as specified by a :ref:`table index <syntax-tableidx>` and a :ref:`constant <valid-constant>` :ref:`expression <syntax-expr>` defining an offset into that table.
A declarative element segment is not available at runtime but merely serves to forward-declare references that are formed in code with instructions like ${:REF.FUNC}.
The offset is given by another :ref:`constant <valid-constant>` :ref:`expression <syntax-expr>`.

Element segments are referenced through :ref:`element indices <syntax-elemidx>`.


.. index:: ! data, active, passive, data index, memory, memory index, expression, constant, byte, list
   pair: abstract syntax; data
   single: memory; data
   single: data; segment
.. _syntax-data:
.. _syntax-datamode:

Data Segments
~~~~~~~~~~~~~

The ${:data} section of a module defines a list of *data segments*,
which can be used to initialize a range of memory from a static :ref:`list <syntax-list>` of :ref:`bytes <syntax-byte>`.

$${syntax: {data datamode}}

Similar to element segments, data segments have a mode that identifies them as either *active* or *passive*.
A passive data segment's contents can be copied into a memory using the ${:MEMORY.INIT} instruction.
An active data segment copies its contents into a memory during :ref:`instantiation <exec-instantiation>`, as specified by a :ref:`memory index <syntax-memidx>` and a :ref:`constant <valid-constant>` :ref:`expression <syntax-expr>` defining an offset into that memory.

Data segments are referenced through :ref:`data indices <syntax-dataidx>`.


.. index:: ! start function, function, function index, table, memory, instantiation
   pair: abstract syntax; start function
.. _syntax-start:

Start Function
~~~~~~~~~~~~~~

The ${:start} section of a module declares the :ref:`function index <syntax-funcidx>` of a *start function* that is automatically invoked when the module is :ref:`instantiated <exec-instantiation>`, after :ref:`tables <syntax-table>` and :ref:`memories <syntax-mem>` have been initialized.

$${syntax: start}

.. note::
   The start function is intended for initializing the state of a module.
   The module and its exports are not accessible externally before this initialization has completed.


.. index:: ! export, name, index, external index, function index, table index, memory index, global index, tag index, function, table, memory, global, tag, instantiation
   pair: abstract syntax; export
   pair: abstract syntax; external index
   single: function; export
   single: table; export
   single: memory; export
   single: global; export
   single: tag; export
.. _syntax-exportdesc:
.. _syntax-export:
.. _syntax-externidx:

Exports
~~~~~~~

The ${:export} section of a module defines a set of *exports* that become accessible to the host environment once the module has been :ref:`instantiated <exec-instantiation>`.

$${syntax: export externidx}

Each export is labeled by a unique :ref:`name <syntax-name>`.
Exportable definitions are
:ref:`functions <syntax-func>`,
:ref:`tables <syntax-table>`,
:ref:`memories <syntax-mem>`,
:ref:`globals <syntax-global>`, and
:ref:`tags <syntax-tag>`,
which are referenced through a respective index.


Conventions
...........

The following auxiliary notation is defined for sequences of exports, filtering out indices of a specific kind in an order-preserving fashion:

$${definition: funcsxx tablesxx memsxx globalsxx tagsxx}


.. index:: ! import, name, function type, table type, memory type, global type, tag type, index, index space, type index, function index, table index, memory index, global index, tag index, function, table, memory, tag, global, instantiation
   pair: abstract syntax; import
   single: function; import
   single: table; import
   single: memory; import
   single: global; import
   single: tag; import
.. _syntax-importdesc:
.. _syntax-import:

Imports
~~~~~~~

The ${:import} section of a module defines a set of *imports* that are required for :ref:`instantiation <exec-instantiation>`.

$${syntax: import}

Each import is labeled by a two-level :ref:`name <syntax-name>` space, consisting of a *module name* and an *item name* for an entity within that module.
Importable definitions are
:ref:`functions <syntax-func>`,
:ref:`tables <syntax-table>`,
:ref:`memories <syntax-mem>`,
:ref:`globals <syntax-global>`, and
:ref:`tags <syntax-tag>`.
Each import is specified by a respective :ref:`external type <syntax-externtype>` that a definition provided during instantiation is required to match.

Every import defines an index in the respective :ref:`index space <syntax-index>`.
In each index space, the indices of imports go before the first index of any definition contained in the module itself.

.. note::
   Unlike export names, import names are not necessarily unique.
   It is possible to import the same module/item name pair multiple times;
   such imports may even have different type descriptions, including different kinds of entities.
   A module with such imports can still be instantiated depending on the specifics of how an :ref:`embedder <embedder>` allows resolving and supplying imports.
   However, embedders are not required to support such overloading,
   and a WebAssembly module itself cannot implement an overloaded name.

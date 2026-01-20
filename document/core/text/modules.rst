Modules
-------

Modules consist of a sequence of :ref:`declarations <text-decl>`.
The grammar rules for each declaration construct produce a pair,
consisting of not just the abstract syntax representing the respective declaration,
but also an :ref:`identifier context <text-context>` recording the new symbolic :ref:`identifiers <text-id>` bound by the construct,
for use in the remainder of the module.


.. index:: index, type index, tag index, global index, memory index, table index, function index, data index, element index, local index, label index
   pair: text format; type index
   pair: text format; tag index
   pair: text format; global index
   pair: text format; memory index
   pair: text format; table index
   pair: text format; function index
   pair: text format; data index
   pair: text format; element index
   pair: text format; local index
   pair: text format; label index
.. _text-idx:
.. _text-typeidx:
.. _text-tagidx:
.. _text-globalidx:
.. _text-memidx:
.. _text-tableidx:
.. _text-funcidx:
.. _text-dataidx:
.. _text-elemidx:
.. _text-localidx:
.. _text-labelidx:
.. _text-fieldidx:
.. _text-index:

Indices
~~~~~~~

:ref:`Indices <syntax-index>` can be given either in raw numeric form or as symbolic :ref:`identifiers <text-id>` when bound by a respective construct.
Such identifiers are looked up in the suitable space of the :ref:`identifier context <text-context>` ${idctxt: I}.

$${grammar: Tidx_ {
  Ttypeidx_
  Ttagidx_
  Tglobalidx_
  Tmemidx_
  Ttableidx_
  Tfuncidx_
  Tdataidx_
  Telemidx_
  Tlocalidx_
  Tlabelidx_
  Tfieldidx__
}}


.. index:: type, recursive type, identifier
   pair: text format; type
.. _text-types:

Types
~~~~~

A type definition consists of a :ref:`recursive type <text-rectype>`.
The :ref:`identifier context <text-context>` produced for the local bindings is further extended with the respective sequence of :ref:`defined types <syntax-deftype>` that the recursive type generates.

$${grammar: Ttype_}


.. index:: tag, tag type, identifier, function type, exception tag
   pair: text format; tag
.. _text-tag:

Tags
~~~~

A tag definition can bind a symbolic :ref:`tag identifier <text-id>`.

$${grammar: Ttag_}


.. index:: import, name
   pair: text format; import
.. index:: export, name, index, tag index
   pair: text format; export
.. index:: tag
.. _text-tag-abbrev:

Abbreviations
.............

Tags can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

$${grammar: Timport_/abbrev-tag Texporttag_}

.. note::
   The latter abbreviation can be applied repeatedly, if "${grammar-case: Texporttagdots_(I)}" contains additional export clauses.
   Consequently, a memory declaration can contain any number of exports, possibly followed by an import.


.. index:: global, global type, identifier, expression
   pair: text format; global
.. _text-global:

Globals
~~~~~~~

Global definitions can bind a symbolic :ref:`global identifier <text-id>`.

$${grammar: Tglobal_}


.. index:: import, name
   pair: text format; import
.. index:: export, name, index, global index
   pair: text format; export
.. _text-global-abbrev:

Abbreviations
.............

Globals can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

$${grammar: Timport_/abbrev-global Texportglobal_}

.. note::
   The latter abbreviation can be applied repeatedly, if "${grammar-case: Texportglobaldots_(I)}" contains additional export clauses.
   Consequently, a global declaration can contain any number of exports, possibly followed by an import.


.. index:: memory, memory type, identifier
   pair: text format; memory
.. _text-mem:

Memories
~~~~~~~~

Memory definitions can bind a symbolic :ref:`memory identifier <text-id>`.

$${grammar: Tmem_}


.. index:: import, name
   pair: text format; import
.. index:: export, name, index, memory index
   pair: text format; export
.. index:: data, memory, memory index, expression, byte, page size
   pair: text format; data
   single: memory; data
   single: data; segment
.. _text-mem-abbrev:

Abbreviations
.............

A :ref:`data segment <text-data>` can be given inline with a memory definition, in which case its offset is ${:0} and the :ref:`limits <text-limits>` of the :ref:`memory type <text-memtype>` are inferred from the length of the data, rounded up to :ref:`page size <page-size>`:

$${grammar: Tdatamem_}

Memories can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

$${grammar: Timport_/abbrev-mem Texportmem_}

.. note::
   The latter abbreviation can be applied repeatedly, if "${grammar-case: Texportmemdots_(I)}" contains additional export clauses.
   Consequently, a memory declaration can contain any number of exports, possibly followed by an import.


.. index:: table, table type, identifier, expression
   pair: text format; table
.. _text-table:

Tables
~~~~~~

Table definitions can bind a symbolic :ref:`table identifier <text-id>`.

$${grammar: Ttable_/plain}


.. index:: reference type, heap type
.. index:: import, name
   pair: text format; import
.. index:: export, name, index, table index
   pair: text format; export
.. index:: element, table index, function index
   pair: text format; element
   single: table; element
   single: element; segment
.. _text-table-abbrev:

Abbreviations
.............

A table's initialization :ref:`expression <text-expr>` can be omitted, in which case it defaults to ${:REF.NULL}:

$${grammar: Ttable_/abbrev}

An :ref:`element segment <text-elem>` can be given inline with a table definition, in which case its offset is ${:0} and the :ref:`limits <text-limits>` of the :ref:`table type <text-tabletype>` are inferred from the length of the given segment:

$${grammar: Telemtable_}

Tables can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

$${grammar: Timport_/abbrev-table Texporttable_}

.. note::
   The latter abbreviation can be applied repeatedly, if "${grammar-case: Texporttabledots_(I)}" contains additional export clauses.
   Consequently, a table declaration can contain any number of exports, possibly followed by an import.


.. index:: function, type index, function type, identifier, local
   pair: text format; function
   pair: text format; local
.. _text-local:
.. _text-func:

Functions
~~~~~~~~~

Function definitions can bind a symbolic :ref:`function identifier <text-id>`, and :ref:`local identifiers <text-id>` for its :ref:`parameters <text-typeuse>` and locals.

$${grammar: Tfunc_}

$${grammar: Tlocal_/plain}

.. note::
   The :ref:`well-formedness <text-context-wf>` condition on ${idctxt: I'} ensures that parameters and locals do not contain duplicate identifiers.


.. index:: import, name
   pair: text format; import
.. index:: export, name, index, function index
   pair: text format; export
.. _text-func-abbrev:

Abbreviations
.............

Multiple anonymous locals may be combined into a single declaration:

$${grammar: Tlocal_/abbrev}

Functions can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

$${grammar: Timport_/abbrev-func Texportfunc_}

.. note::
   The latter abbreviation can be applied repeatedly, if "${grammar-case: Texportfuncdots_(I)}" contains additional export clauses.
   Consequently, a function declaration can contain any number of exports, possibly followed by an import.


.. index:: data, memory, memory index, expression, byte
   pair: text format; data
   single: memory; data
   single: data; segment
.. _text-datastring:
.. _text-data:
.. _text-memuse:

Data Segments
~~~~~~~~~~~~~

Data segments allow for an optional :ref:`memory index <text-memidx>` to identify the memory to initialize.
The data is written as a :ref:`string <text-string>`, which may be split up into a possibly empty sequence of individual string literals.

$${grammar: Tdata_ Tdatastring {Tmemuse_/plain Toffset_/plain}}

.. note::
   In the current version of WebAssembly, the only valid memory index is 0
   or a symbolic :ref:`memory identifier <text-id>` resolving to the same value.


Abbreviations
.............

As an abbreviation, a single :ref:`folded instruction <text-foldedinstr>` may occur in place of the offset of an active segment:

$${grammar: Toffset_/abbrev}

Also, a memory use can be omitted, defaulting to ${:0}.

$${grammar: Tmemuse_/abbrev}

As another abbreviation, data segments may also be specified inline with :ref:`memory <text-mem>` definitions; see the respective section.


.. index:: element, table index, expression, function index
   pair: text format; element
   single: table; element
   single: element; segment
.. _text-elem:
.. _text-elemlist:
.. _text-elemexpr:
.. _text-tableuse:

Element Segments
~~~~~~~~~~~~~~~~

Element segments allow for an optional :ref:`table index <text-tableidx>` to identify the table to initialize.

$${grammar: Telem_/plain {Telemlist_/plain Telemexpr_/plain} Ttableuse_/plain}


Abbreviations
.............

As an abbreviation, a single :ref:`folded instruction <text-foldedinstr>` may occur in place of the offset of an active element segment or as an element expression:

$${grammar: Telemexpr_/abbrev}

Also, the element list may be written as just a sequence of :ref:`function indices <text-funcidx>`:

$${grammar: Telemlist_/abbrev}

A table use can be omitted, defaulting to ${:0}.

$${grammar: Ttableuse_/abbrev}

Furthermore, for backwards compatibility with earlier versions of WebAssembly, if the table use is omitted, the ${grammar-case: "func"} keyword can be omitted as well.

$${grammar: Telem_/abbrev}

As yet another abbreviation, element segments may also be specified inline with :ref:`table <text-table>` definitions; see the respective section.


.. index:: start function, function index
   pair: text format; start function
.. _text-start:

Start Function
~~~~~~~~~~~~~~

A :ref:`start function <syntax-start>` is defined in terms of its index.

$${grammar: Tstart_}

.. note::
   At most one start function may occur in a module,
   which is ensured by a suitable side condition on the ${grammar-case: Tmodule} grammar.



.. index:: import, name, tag type, global type, memory type, table type, function type
   pair: text format; import
.. _text-import:

Imports
~~~~~~~

The :ref:`external type <syntax-externtype>` in imports can bind a symbolic tag, global, memory, or function :ref:`identifier <text-id>`.

$${grammar: Timport_/plain}


Abbreviations
.............

As an abbreviation, imports may also be specified inline with
:ref:`tag <text-tag>`,
:ref:`global <text-global>`,
:ref:`memory <text-mem>`,
:ref:`table <text-table>`, or
:ref:`function <text-func>`
definitions; see the respective sections.


.. index:: export, name, index, external index, tag index, global index, memory index, table index, function index
   pair: text format; export
.. _text-externidx:
.. _text-export:

Exports
~~~~~~~

The syntax for exports mirrors their :ref:`abstract syntax <syntax-export>` directly.

$${grammar: Texport_ Texternidx_}


Abbreviations
.............

As an abbreviation, exports may also be specified inline with
:ref:`tag <text-tag>`,
:ref:`global <text-global>`,
:ref:`memory <text-mem>`,
:ref:`table <text-table>`, or
:ref:`function <text-func>`
definitions; see the respective sections.


.. index:: module, type definition, recursive type, tag, global, memory, table, function, data segment, element segment, start function, import, export, identifier context, identifier, name section, ! declaration
   pair: text format; module
   single: section; name
.. _syntax-decl:
.. _text-decl:
.. _text-module:

Modules
~~~~~~~

A module consists of a sequence of *declarations* that can occur in any order.

$${syntax: decl}

All declarations and their respective bound :ref:`identifiers <text-id>` scope over the entire module, including the text preceding them.
A module itself may optionally bind an :ref:`identifier <text-id>` that names the module.
The name serves a documentary role only.

.. note::
   Tools may include the module name in the :ref:`name section <binary-namesec>` of the :ref:`binary format <binary>`.

$${grammar: Tdecl_}

$${grammar: Tmodule/plain}

where ${:$types(decl*)}, ${:$imports(decl*)}, ${:$tags(decl*)}, etc., extract the sequence of :ref:`types <syntax-type>`, :ref:`imports <syntax-import>`, :ref:`tags <syntax-tag>`, etc., contained in ${:decl*}, respectively.
The auxiliary predicate ${:$ordered} checks that no imports occur after the first definition of a
:ref:`tag <syntax-tag>`,
:ref:`global <syntax-global>`,
:ref:`memory <syntax-mem>`,
:ref:`table <syntax-table>`, or
:ref:`function <syntax-func>`
in a sequence of declarations:

.. _aux-ordered:

$${definition: ordered}

$${definition-ignore: typesd importsd tagsd globalsd memsd tablesd funcsd datasd elemsd startsd exportsd}


Abbreviations
.............

In a source file, the toplevel ${grammar-case: "(" "module" Tdecldots ")"} surrounding the module body may be omitted.

$${grammar: Tmodule/abbrev}

Modules
-------

The binary encoding of modules is organized into *sections*.
Most sections correspond to one component of a :ref:`module <syntax-module>` record,
except that :ref:`function definitions <syntax-func>` are split into two sections, separating their type declarations in the :ref:`function section <binary-funcsec>` from their bodies in the :ref:`code section <binary-codesec>`.

.. note::
   This separation enables *parallel* and *streaming* compilation of the functions in a module.


.. index:: index, type index, function index, table index, memory index, global index, tag index, element index, data index, local index, label index, field index
   pair: binary format; type index
   pair: binary format; function index
   pair: binary format; table index
   pair: binary format; memory index
   pair: binary format; global index
   pair: binary format; tag index
   pair: binary format; element index
   pair: binary format; data index
   pair: binary format; local index
   pair: binary format; label index
   pair: binary format; field index
.. _binary-typeidx:
.. _binary-funcidx:
.. _binary-tableidx:
.. _binary-memidx:
.. _binary-globalidx:
.. _binary-tagidx:
.. _binary-elemidx:
.. _binary-dataidx:
.. _binary-localidx:
.. _binary-labelidx:
.. _binary-fieldidx:
.. _binary-externidx:
.. _binary-index:

Indices
~~~~~~~

All basic :ref:`indices <syntax-index>` are encoded with their respective value.

$${grammar: {
  Btypeidx Bfuncidx Btableidx Bmemidx Bglobalidx Btagidx Belemidx Bdataidx
  Blocalidx Blabelidx
}}

:ref:`External indices <syntax-externidx>` are encoded by a distiguishing byte followed by an encoding of their respective value.

$${grammar: Bexternidx}


.. index:: ! section
   pair: binary format; section
.. _binary-section:

Sections
~~~~~~~~

Each section consists of

* a one-byte section *id*,
* the ${:u32} *length* of the contents, in bytes,
* the actual *contents*, whose structure is dependent on the section id.

Every section is optional; an omitted section is equivalent to the section being present with empty contents.

The following parameterized grammar rule defines the generic structure of a section with id ${:N} and contents described by the grammar ${grammar-case: X}.

$${grammar: Bsection_}

For most sections, the contents ${grammar-case: X} encodes a :ref:`list <binary-list>`.
In these cases, the empty result ${:eps} is interpreted as the empty list.

.. note::
   Other than for unknown :ref:`custom sections <binary-customsec>`,
   the ${:size} is not required for decoding, but can be used to skip sections when navigating through a binary.
   The module is malformed if the size does not match the length of the binary contents ${grammar-case: X}.

The following section ids are used:

==  ===============================================
Id  Section                                        
==  ===============================================
 0  :ref:`custom section <binary-customsec>`       
 1  :ref:`type section <binary-typesec>`           
 2  :ref:`import section <binary-importsec>`       
 3  :ref:`function section <binary-funcsec>`       
 4  :ref:`table section <binary-tablesec>`         
 5  :ref:`memory section <binary-memsec>`          
 6  :ref:`global section <binary-globalsec>`       
 7  :ref:`export section <binary-exportsec>`       
 8  :ref:`start section <binary-startsec>`         
 9  :ref:`element section <binary-elemsec>`        
10  :ref:`code section <binary-codesec>`           
11  :ref:`data section <binary-datasec>`           
12  :ref:`data count section <binary-datacntsec>`
13  :ref:`tag section <binary-tagsec>`
==  ===============================================

.. note::
   Section ids do not always correspond to the :ref:`order of sections <binary-module>` in the encoding of a module.


.. index:: ! custom section
   pair: binary format; custom section
   single: section; custom
.. _binary-customsec:

Custom Section
~~~~~~~~~~~~~~

*Custom sections* have the id 0.
They are intended to be used for debugging information or third-party extensions, and are ignored by the WebAssembly semantics.
Their contents consist of a :ref:`name <syntax-name>` further identifying the custom section, followed by an uninterpreted sequence of bytes for custom use.

$${grammar: {Bcustomsec Bcustom}}

.. note::
   If an implementation interprets the data of a custom section, then errors in that data, or the placement of the section, must not invalidate the module.


.. index:: ! type section, type definition, recursive type
   pair: binary format; type section
   pair: section; type
.. _binary-type:
.. _binary-typesec:

Type Section
~~~~~~~~~~~~

The *type section* has the id 1.
It decodes into the list of :ref:`recursive types <syntax-rectype>` of a :ref:`module <syntax-module>`.

$${grammar: {Btypesec Btype}}


.. index:: ! import section, import, name, function type, table type, memory type, global type, tag type
   pair: binary format; import
   pair: section; import
.. _binary-import:
.. _binary-importdesc:
.. _binary-importsec:

Import Section
~~~~~~~~~~~~~~

The *import section* has the id 2.
It decodes into the list of :ref:`imports <syntax-import>` of a :ref:`module <syntax-module>`.

$${grammar: {Bimportsec Bimport}}


.. index:: ! function section, function, type index, function type
   pair: binary format; function
   pair: section; function
.. _binary-funcsec:

Function Section
~~~~~~~~~~~~~~~~

The *function section* has the id 3.
It decodes into a list of :ref:`type indices <syntax-typeidx>` that classify the :ref:`functions <syntax-func>` defined by a :ref:`module <syntax-module>`.
The bodies of the respective functions are encoded separately in the :ref:`code section <binary-codesec>`.

$${grammar: {Bfuncsec}}


.. index:: ! table section, table, table type
   pair: binary format; table
   pair: section; table
.. _binary-table:
.. _binary-tablesec:

Table Section
~~~~~~~~~~~~~

The *table section* has the id 4.
It decodes into the list of :ref:`tables <syntax-table>` defined by a :ref:`module <syntax-module>`.

$${grammar: {Btablesec Btable}}

.. note::
   The encoding of a table type cannot start with byte ${:0x40}`,
   hence decoding is unambiguous.
   The zero byte following it is reserved for future extensions.


.. index:: ! memory section, memory, memory type
   pair: binary format; memory
   pair: section; memory
.. _binary-mem:
.. _binary-memsec:

Memory Section
~~~~~~~~~~~~~~

The *memory section* has the id 5.
It decodes into the list of :ref:`memories <syntax-mem>` defined by a :ref:`module <syntax-module>`.

$${grammar: {Bmemsec Bmem}}


.. index:: ! global section, global, global type, expression
   pair: binary format; global
   pair: section; global
.. _binary-global:
.. _binary-globalsec:

Global Section
~~~~~~~~~~~~~~

The *global section* has the id 6.
It decodes into the list of :ref:`globals <syntax-global>` defined by a :ref:`module <syntax-module>`.

$${grammar: {Bglobalsec Bglobal}}


.. index:: ! export section, export, name, index, function index, table index, memory index, tag index, global index
   pair: binary format; export
   pair: section; export
.. _binary-export:
.. _binary-exportdesc:
.. _binary-exportsec:

Export Section
~~~~~~~~~~~~~~

The *export section* has the id 7.
It decodes into the list of :ref:`exports <syntax-export>` of a :ref:`module <syntax-module>`.

$${grammar: {Bexportsec Bexport}}


.. index:: ! start section, start function, function index
   pair: binary format; start function
   single: section; start
   single: start function; section
.. _binary-start:
.. _binary-startsec:

Start Section
~~~~~~~~~~~~~

The *start section* has the id 8.
It decodes into the optional :ref:`start function <syntax-start>` of a :ref:`module <syntax-module>`.

$${grammar: {Bstartsec Bstart}}


.. index:: ! element section, element, table index, expression, function index
   pair: binary format; element
   pair: section; element
   single: table; element
   single: element; segment
.. _binary-elem:
.. _binary-elemsec:
.. _binary-elemkind:

Element Section
~~~~~~~~~~~~~~~

The *element section* has the id 9.
It decodes into the list of :ref:`element segments <syntax-elem>` defined by a :ref:`module <syntax-module>`.

$${grammar: {Belemsec Belemkind Belem}}

.. note::
   The initial integer can be interpreted as a bitfield.
   Bit 0 distinguishes a passive or declarative segment from an active segment,
   bit 1 indicates the presence of an explicit table index for an active segment and otherwise distinguishes passive from declarative segments,
   bit 2 indicates the use of element type and element :ref:`expressions <binary-expr>` instead of element kind and element indices.

   Additional element kinds may be added in future versions of WebAssembly.


.. index:: ! code section, function, local, type index, function type
   pair: binary format; function
   pair: binary format; local
   pair: section; code
.. _binary-code:
.. _binary-func:
.. _binary-local:
.. _binary-codesec:

Code Section
~~~~~~~~~~~~

The *code section* has the id 10.
It decodes into the list of *code* entries that are pairs of lists of :ref:`locals <syntax-list>` and :ref:`expressions <syntax-expr>`.
They represent the body of the :ref:`functions <syntax-func>` defined by a :ref:`module <syntax-module>`.
The types of the respective functions are encoded separately in the :ref:`function section <binary-funcsec>`.

The encoding of each code entry consists of

* the ${:u32} *length* of the function code in bytes,
* the actual *function code*, which in turn consists of

  * the declaration of *locals*,
  * the function *body* as an :ref:`expression <binary-expr>`.

Local declarations are compressed into a list whose entries consist of

* a ${:u32} *count*,
* a :ref:`value type <binary-valtype>`,

denoting *count* locals of the same value type.

$${grammar: {Bcodesec Bcode Bfunc Blocals}}

Here, ${:code} ranges over pairs ${:(local*, expr)}.
Any code for which the length of the resulting sequence is out of bounds of the maximum size of a :ref:`list <syntax-list>` is malformed.

.. note::
   Like with :ref:`sections <binary-section>`, the code ${:size} is not needed for decoding, but can be used to skip functions when navigating through a binary.
   The module is malformed if a size does not match the length of the respective function code.


.. index:: ! data section, data, memory, memory index, expression, byte
   pair: binary format; data
   pair: section; data
   single: memory; data
   single: data; segment
.. _binary-data:
.. _binary-datasec:

Data Section
~~~~~~~~~~~~

The *data section* has the id 11.
It decodes into the list of :ref:`data segments <syntax-data>` defined by a :ref:`module <syntax-module>`.

$${grammar: {Bdatasec Bdata}}

.. note::
   The initial integer can be interpreted as a bitfield.
   Bit 0 indicates a passive segment,
   bit 1 indicates the presence of an explicit memory index for an active segment.


.. index:: ! data count section, data count, data segment
   pair: binary format; data count
   pair: section; data count
.. _binary-datacntsec:
.. _binary-datacnt:

Data Count Section
~~~~~~~~~~~~~~~~~~

The *data count section* has the id 12.
It decodes into an optional ${:u32} count that represents the number of :ref:`data segments <syntax-data>` in the :ref:`data section <binary-datasec>`.
If this count does not match the length of the data segment list, the module is malformed.

$${grammar: {Bdatacntsec Bdatacnt}}

.. note::
   The data count section is used to simplify single-pass validation. Since the
   data section occurs after the code section, the ${:MEMORY.INIT} and
   ${:DATA.DROP} instructions would not be able to check whether the data
   segment index is valid until the data section is read. The data count section
   occurs before the code section, so a single-pass validator can use this count
   instead of deferring validation.


.. index:: ! tag section, tag, tag type, function type index, exception tag
   pair: binary format; tag
   pair: section; tag
.. _binary-tag:
.. _binary-tagsec:

Tag Section
~~~~~~~~~~~

The *tag section* has the id 13.
It decodes into the list of :ref:`tags <syntax-tag>` defined by a :ref:`module <syntax-module>`.

$${grammar: {Btagsec Btag}}


.. index:: module, section, type definition, function type, function, table, memory, tag, global, element, data, start function, import, export, context, version
   pair: binary format; module
.. _binary-magic:
.. _binary-version:
.. _binary-module:

Modules
~~~~~~~

The encoding of a :ref:`module <syntax-module>` starts with a preamble containing a 4-byte magic number (the string :math:`\text{\backslash0asm}`) and a version field.
The current version of the WebAssembly binary format is 1.

The preamble is followed by a sequence of :ref:`sections <binary-section>`.
:ref:`Custom sections <binary-customsec>` may be inserted at any place in this sequence,
while other sections must occur at most once and in the prescribed order.
All sections can be empty.

The lengths of lists produced by the (possibly empty) :ref:`function <binary-funcsec>` and :ref:`code <binary-codesec>` section must match up.

Similarly, the optional data count must match the length of the :ref:`data segment <binary-datasec>` list.
Furthermore, it must be present if any :ref:`data index <syntax-dataidx>` occurs in the code section.

$${grammar: {Bmagic Bversion Bmodule}}

.. note::
   The version of the WebAssembly binary format may increase in the future
   if backward-incompatible changes have to be made to the format.
   However, such changes are expected to occur very infrequently, if ever.
   The binary format is intended to be forward-compatible,
   such that future extensions can be made without incrementing its version.

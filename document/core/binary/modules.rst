Modules
-------

The binary encoding of modules is organized into *sections*.
Most sections correspond to one component of a :ref:`module <syntax-module>` record,
except that :ref:`function definitions <syntax-func>` are split into two sections, separating their type declarations in the :ref:`function section <binary-funcsec>` from their bodies in the :ref:`code section <binary-codesec>`.

.. note::
   This separation enables *parallel* and *streaming* compilation of the functions in a module.


.. index:: index, type index, function index, table index, memory index, global index, local index, label index
   pair: binary format; type index
   pair: binary format; function index
   pair: binary format; table index
   pair: binary format; memory index
   pair: binary format; global index
   pair: binary format; local index
   pair: binary format; label index
.. _binary-typeidx:
.. _binary-funcidx:
.. _binary-tableidx:
.. _binary-memidx:
.. _binary-globalidx:
.. _binary-localidx:
.. _binary-labelidx:
.. _binary-index:

Indices
~~~~~~~

All :ref:`indices <syntax-index>` are encoded with their respective value.

.. math::
   \begin{array}{llclll}
   \production{type index} & \Btypeidx &::=& x{:}\Bu32 &\Rightarrow& x \\
   \production{function index} & \Bfuncidx &::=& x{:}\Bu32 &\Rightarrow& x \\
   \production{table index} & \Btableidx &::=& x{:}\Bu32 &\Rightarrow& x \\
   \production{memory index} & \Bmemidx &::=& x{:}\Bu32 &\Rightarrow& x \\
   \production{global index} & \Bglobalidx &::=& x{:}\Bu32 &\Rightarrow& x \\
   \production{local index} & \Blocalidx &::=& x{:}\Bu32 &\Rightarrow& x \\
   \production{label index} & \Blabelidx &::=& l{:}\Bu32 &\Rightarrow& l \\
   \end{array}


.. index:: ! section
   pair: binary format; section
.. _binary-section:

Sections
~~~~~~~~

Each section consists of

* a one-byte section *id*,
* the |U32| *size* of the contents, in bytes,
* the actual *contents*, whose structure is depended on the section id.

Every section is optional; an omitted section is equivalent to the section being present with empty contents.

The following parameterized grammar rule defines the generic structure of a section with id :math:`N` and contents described by the grammar :math:`\B{B}`.

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{section} & \Bsection_N(\B{B}) &::=&
     N{:}\Bbyte~~\X{size}{:}\Bu32~~\X{cont}{:}\B{B}
       &\Rightarrow& \X{cont} & (\iff \X{size} = ||\B{B}||) \\ &&|&
     \epsilon &\Rightarrow& \epsilon
   \end{array}

For most sections, the contents :math:`\B{B}` encodes a :ref:`vector <binary-vec>`.
In these cases, the empty result :math:`\epsilon` is interpreted as the empty vector.

.. note::
   Other than for unknown :ref:`custom sections <binary-customsec>`,
   the :math:`\X{size}` is not required for decoding, but can be used to skip sections when navigating through a binary.
   The module is malformed if the size does not match the length of the binary contents :math:`\B{B}`.

The following section ids are used:

==  ========================================
Id  Section                                 
==  ========================================
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
==  ========================================


.. index:: ! custom section
   pair: binary format; custom section
   single: section; custom
.. _binary-customsec:

Custom Section
~~~~~~~~~~~~~~

*Custom sections* have the id 0.
They are intended to be used for debugging information or third-party extensions, and are ignored by the WebAssembly semantics.
Their contents consist of a :ref:`name <syntax-name>` further identifying the custom section, followed by an uninterpreted sequence of bytes for custom use.

.. math::
   \begin{array}{llclll}
   \production{custom section} & \Bcustomsec &::=&
     \Bsection_0(\Bcustom) \\
   \production{custom data} & \Bcustom &::=&
     \Bname~~\Bbyte^\ast \\
   \end{array}

.. note::
   If an implementation interprets the contents of a custom section, then errors in that contents, or the placement of the section, must not invalidate the module.


.. index:: ! type section, type definition
   pair: binary format; type section
   pair: section; type
.. _binary-typedef:
.. _binary-typesec:

Type Section
~~~~~~~~~~~~

The *type section* has the id 1.
It decodes into a vector of :ref:`function types <syntax-functype>` that represent the |MTYPES| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{type section} & \Btypesec &::=&
     \X{ft}^\ast{:\,}\Bsection_1(\Bvec(\Bfunctype)) &\Rightarrow& \X{ft}^\ast \\
   \end{array}


.. index:: ! import section, import, name, function type, table type, memory type, global type
   pair: binary format; import
   pair: section; import
.. _binary-import:
.. _binary-importdesc:
.. _binary-importsec:

Import Section
~~~~~~~~~~~~~~

The *import section* has the id 2.
It decodes into a vector of :ref:`imports <syntax-import>` that represent the |MIMPORTS| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{import section} & \Bimportsec &::=&
     \X{im}^\ast{:}\Bsection_2(\Bvec(\Bimport)) &\Rightarrow& \X{im}^\ast \\
   \production{import} & \Bimport &::=&
     \X{mod}{:}\Bname~~\X{nm}{:}\Bname~~d{:}\Bimportdesc
       &\Rightarrow& \{ \IMODULE~\X{mod}, \INAME~\X{nm}, \IDESC~d \} \\
   \production{import description} & \Bimportdesc &::=&
     \hex{00}~~x{:}\Btypeidx &\Rightarrow& \IDFUNC~x \\ &&|&
     \hex{01}~~\X{tt}{:}\Btabletype &\Rightarrow& \IDTABLE~\X{tt} \\ &&|&
     \hex{02}~~\X{mt}{:}\Bmemtype &\Rightarrow& \IDMEM~\X{mt} \\ &&|&
     \hex{03}~~\X{gt}{:}\Bglobaltype &\Rightarrow& \IDGLOBAL~\X{gt} \\
   \end{array}


.. index:: ! function section, function, type index, function type
   pair: binary format; function
   pair: section; function
.. _binary-funcsec:

Function Section
~~~~~~~~~~~~~~~~

The *function section* has the id 3.
It decodes into a vector of :ref:`type indices <syntax-typeidx>` that represent the |FTYPE| fields of the :ref:`functions <syntax-func>` in the |MFUNCS| component of a :ref:`module <syntax-module>`.
The |FLOCALS| and |FBODY| fields of the respective functions are encoded separately in the :ref:`code section <binary-codesec>`.

.. math::
   \begin{array}{llclll}
   \production{function section} & \Bfuncsec &::=&
     x^\ast{:}\Bsection_3(\Bvec(\Btypeidx)) &\Rightarrow& x^\ast \\
   \end{array}


.. index:: ! table section, table, table type
   pair: binary format; table
   pair: section; table
.. _binary-table:
.. _binary-tablesec:

Table Section
~~~~~~~~~~~~~

The *table section* has the id 4.
It decodes into a vector of :ref:`tables <syntax-table>` that represent the |MTABLES| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{table section} & \Btablesec &::=&
     \X{tab}^\ast{:}\Bsection_4(\Bvec(\Btable)) &\Rightarrow& \X{tab}^\ast \\
   \production{table} & \Btable &::=&
     \X{tt}{:}\Btabletype &\Rightarrow& \{ \TTYPE~\X{tt} \} \\
   \end{array}


.. index:: ! memory section, memory, memory type
   pair: binary format; memory
   pair: section; memory
.. _binary-mem:
.. _binary-memsec:

Memory Section
~~~~~~~~~~~~~~

The *memory section* has the id 5.
It decodes into a vector of :ref:`memories <syntax-mem>` that represent the |MMEMS| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{memory section} & \Bmemsec &::=&
     \X{mem}^\ast{:}\Bsection_5(\Bvec(\Bmem)) &\Rightarrow& \X{mem}^\ast \\
   \production{memory} & \Bmem &::=&
     \X{mt}{:}\Bmemtype &\Rightarrow& \{ \MTYPE~\X{mt} \} \\
   \end{array}


.. index:: ! global section, global, global type, expression
   pair: binary format; global
   pair: section; global
.. _binary-global:
.. _binary-globalsec:

Global Section
~~~~~~~~~~~~~~

The *global section* has the id 6.
It decodes into a vector of :ref:`globals <syntax-global>` that represent the |MGLOBALS| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{global section} & \Bglobalsec &::=&
     \X{glob}^\ast{:}\Bsection_6(\Bvec(\Bglobal)) &\Rightarrow& \X{glob}^\ast \\
   \production{global} & \Bglobal &::=&
     \X{gt}{:}\Bglobaltype~~e{:}\Bexpr
       &\Rightarrow& \{ \GTYPE~\X{gt}, \GINIT~e \} \\
   \end{array}


.. index:: ! export section, export, name, index, function index, table index, memory index, global index
   pair: binary format; export
   pair: section; export
.. _binary-export:
.. _binary-exportdesc:
.. _binary-exportsec:

Export Section
~~~~~~~~~~~~~~

The *export section* has the id 7.
It decodes into a vector of :ref:`exports <syntax-export>` that represent the |MEXPORTS| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{export section} & \Bexportsec &::=&
     \X{ex}^\ast{:}\Bsection_7(\Bvec(\Bexport)) &\Rightarrow& \X{ex}^\ast \\
   \production{export} & \Bexport &::=&
     \X{nm}{:}\Bname~~d{:}\Bexportdesc
       &\Rightarrow& \{ \ENAME~\X{nm}, \EDESC~d \} \\
   \production{export description} & \Bexportdesc &::=&
     \hex{00}~~x{:}\Bfuncidx &\Rightarrow& \EDFUNC~x \\ &&|&
     \hex{01}~~x{:}\Btableidx &\Rightarrow& \EDTABLE~x \\ &&|&
     \hex{02}~~x{:}\Bmemidx &\Rightarrow& \EDMEM~x \\ &&|&
     \hex{03}~~x{:}\Bglobalidx &\Rightarrow& \EDGLOBAL~x \\
   \end{array}


.. index:: ! start section, start function, function index
   pair: binary format; start function
   single: section; start
   single: start function; section
.. _binary-start:
.. _binary-startsec:

Start Section
~~~~~~~~~~~~~

The *start section* has the id 8.
It decodes into an optional :ref:`start function <syntax-start>` that represents the |MSTART| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{start section} & \Bstartsec &::=&
     \X{st}^?{:}\Bsection_8(\Bstart) &\Rightarrow& \X{st}^? \\
   \production{start function} & \Bstart &::=&
     x{:}\Bfuncidx &\Rightarrow& \{ \SFUNC~x \} \\
   \end{array}


.. index:: ! element section, element, table index, expression, function index
   pair: binary format; element
   pair: section; element
   single: table; element
   single: element; segment
.. _binary-elem:
.. _binary-elemsec:

Element Section
~~~~~~~~~~~~~~~

The *element section* has the id 9.
It decodes into a vector of :ref:`element segments <syntax-elem>` that represent the |MELEM| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{element section} & \Belemsec &::=&
     \X{seg}^\ast{:}\Bsection_9(\Bvec(\Belem)) &\Rightarrow& \X{seg} \\
   \production{element segment} & \Belem &::=&
     x{:}\Btableidx~~e{:}\Bexpr~~y^\ast{:}\Bvec(\Bfuncidx)
       &\Rightarrow& \{ \ETABLE~x, \EOFFSET~e, \EINIT~y^\ast \} \\
   \end{array}


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
It decodes into a vector of *code* entries that are pairs of :ref:`value type <syntax-valtype>` vectors and :ref:`expressions <syntax-expr>`.
They represent the |FLOCALS| and |FBODY| field of the :ref:`functions <syntax-func>` in the |MFUNCS| component of a :ref:`module <syntax-module>`.
The |FTYPE| fields of the respective functions are encoded separately in the :ref:`function section <binary-funcsec>`.

The encoding of each code entry consists of

* the |U32| *size* of the function code in bytes,
* the actual *function code*, which in turn consists of

  * the declaration of *locals*,
  * the function *body* as an :ref:`expression <binary-expr>`.

Local declarations are compressed into a vector whose entries consist of

* a |U32| *count*,
* a :ref:`value type <binary-valtype>`,

denoting *count* locals of the same value type.

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{code section} & \Bcodesec &::=&
     \X{code}^\ast{:}\Bsection_{10}(\Bvec(\Bcode))
       &\Rightarrow& \X{code}^\ast \\
   \production{code} & \Bcode &::=&
     \X{size}{:}\Bu32~~\X{code}{:}\Bfunc
       &\Rightarrow& \X{code} & (\iff \X{size} = ||\Bfunc||) \\
   \production{function} & \Bfunc &::=&
     (t^\ast)^\ast{:}\Bvec(\Blocals)~~e{:}\Bexpr
       &\Rightarrow& \concat((t^\ast)^\ast), e^\ast
         & (\iff |\concat((t^\ast)^\ast)| < 2^{32}) \\
   \production{locals} & \Blocals &::=&
     n{:}\Bu32~~t{:}\Bvaltype &\Rightarrow& t^n \\
   \end{array}

Here, :math:`\X{code}` ranges over pairs :math:`(\valtype^\ast, \expr)`.
The meta function :math:`\concat((t^\ast)^\ast)` concatenates all sequences :math:`t_i^\ast` in :math:`(t^\ast)^\ast`.
Any code for which the length of the resulting sequence is out of bounds of the maximum size of a :ref:`vector <syntax-vec>` is malformed.

.. note::
   Like with :ref:`sections <binary-section>`, the code :math:`\X{size}` is not needed for decoding, but can be used to skip functions when navigating through a binary.
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
It decodes into a vector of :ref:`data segments <syntax-data>` that represent the |MDATA| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{data section} & \Bdatasec &::=&
     \X{seg}^\ast{:}\Bsection_{11}(\Bvec(\Bdata)) &\Rightarrow& \X{seg} \\
   \production{data segment} & \Bdata &::=&
     x{:}\Bmemidx~~e{:}\Bexpr~~b^\ast{:}\Bvec(\Bbyte)
       &\Rightarrow& \{ \DMEM~x, \DOFFSET~e, \DINIT~b^\ast \} \\
   \end{array}


.. index:: module, section, type definition, function type, function, table, memory, global, element, data, start function, import, export, context, version
   pair: binary format; module
.. _binary-magic:
.. _binary-version:
.. _binary-module:

Modules
~~~~~~~

The encoding of a :ref:`module <syntax-module>` starts with a preamble containing a 4-byte magic number and a version field.
The current version of the WebAssembly binary format is 1.

The preamble is followed by a sequence of :ref:`sections <binary-section>`.
:ref:`Custom sections <binary-customsec>` may be inserted at any place in this sequence,
while other sections must occur at most once and in the prescribed order.
All sections can be empty.
The lengths of vectors produced by the (possibly empty) :ref:`function <binary-funcsec>` and :ref:`code <binary-codesec>` section must match up.

.. math::
   \begin{array}{llcllll}
   \production{magic} & \Bmagic &::=&
     \hex{00}~\hex{61}~\hex{73}~\hex{6D} \\
   \production{version} & \Bversion &::=&
     \hex{01}~\hex{00}~\hex{00}~\hex{00} \\
   \production{module} & \Bmodule &::=&
     \Bmagic \\ &&&
     \Bversion \\ &&&
     \Bcustomsec^\ast \\ &&&
     \functype^\ast{:\,}\Btypesec \\ &&&
     \Bcustomsec^\ast \\ &&&
     \import^\ast{:\,}\Bimportsec \\ &&&
     \Bcustomsec^\ast \\ &&&
     \typeidx^n{:\,}\Bfuncsec \\ &&&
     \Bcustomsec^\ast \\ &&&
     \table^\ast{:\,}\Btablesec \\ &&&
     \Bcustomsec^\ast \\ &&&
     \mem^\ast{:\,}\Bmemsec \\ &&&
     \Bcustomsec^\ast \\ &&&
     \global^\ast{:\,}\Bglobalsec \\ &&&
     \Bcustomsec^\ast \\ &&&
     \export^\ast{:\,}\Bexportsec \\ &&&
     \Bcustomsec^\ast \\ &&&
     \start^?{:\,}\Bstartsec \\ &&&
     \Bcustomsec^\ast \\ &&&
     \elem^\ast{:\,}\Belemsec \\ &&&
     \Bcustomsec^\ast \\ &&&
     \X{code}^n{:\,}\Bcodesec \\ &&&
     \Bcustomsec^\ast \\ &&&
     \data^\ast{:\,}\Bdatasec \\ &&&
     \Bcustomsec^\ast
     \quad\Rightarrow\quad \{~
       \begin{array}[t]{@{}l@{}}
       \MTYPES~\functype^\ast, \\
       \MFUNCS~\func^n, \\
       \MTABLES~\table^\ast, \\
       \MMEMS~\mem^\ast, \\
       \MGLOBALS~\global^\ast, \\
       \MELEM~\elem^\ast, \\
       \MDATA~\data^\ast, \\
       \MSTART~\start^?, \\
       \MIMPORTS~\import^\ast, \\
       \MEXPORTS~\export^\ast ~\} \\
      \end{array} \\
   \end{array}

where for each :math:`t_i^\ast, e_i` in :math:`\X{code}^n`,

.. math::
   \func^n[i] = \{ \FTYPE~\typeidx^n[i], \FLOCALS~t_i^\ast, \FBODY~e_i \} ) \\

.. note::
   The version of the WebAssembly binary format may increase in the future
   if backward-incompatible changes have to be made to the format.
   However, such changes are expected to occur very infrequently, if ever.
   The binary format is intended to be forward-compatible,
   such that future extensions can be made without incrementing its version.

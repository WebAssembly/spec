Modules
-------

The binary encoding of modules is organized into *sections*.
These mostly correspond to the different components of a :ref:`module <syntax-module>` record,
except that :ref:`function definitions <syntax-func>` are split into two sections, separating their type declarations in the :ref:`function section <binary-funcsec>` from their bodies in the :ref:`code section <binary-codesec>`.

.. note::
   This separation enables *parallel* and *streaming* compilation of a the functions in a module.


.. _binary-index:
.. _binary-typeidx:
.. _binary-funcidx:
.. _binary-tableidx:
.. _binary-memidx:
.. _binary-globalidx:
.. _binary-localidx:
.. _binary-labelidx:
.. index:: index, index space, type index, function index, table index, memory index, global index, local index, label index
   pair: binary format; type index
   pair: binary format; function index
   pair: binary format; table index
   pair: binary format; memory index
   pair: binary format; global index
   pair: binary format; local index
   pair: binary format; label index
   single: abstract syntax; type index
   single: abstract syntax; function index
   single: abstract syntax; table index
   single: abstract syntax; memory index
   single: abstract syntax; global index
   single: abstract syntax; local index
   single: abstract syntax; label index

Indices
~~~~~~~

All :ref:`indices <syntax-index>` are encoded with their respective |U32| value.

.. math::
   \begin{array}{llclll}
   \production{type indices} & \Btypeidx &::=& x{:}\Bu32 &\Rightarrow& x \\
   \production{function indices} & \Bfuncidx &::=& x{:}\Bu32 &\Rightarrow& x \\
   \production{table indices} & \Btableidx &::=& x{:}\Bu32 &\Rightarrow& x \\
   \production{memory indices} & \Bmemidx &::=& x{:}\Bu32 &\Rightarrow& x \\
   \production{global indices} & \Bglobalidx &::=& x{:}\Bu32 &\Rightarrow& x \\
   \production{local indices} & \Blocalidx &::=& x{:}\Bu32 &\Rightarrow& x \\
   \production{label indices} & \Blabelidx &::=& l{:}\Bu32 &\Rightarrow& l \\
   \end{array}


.. _binary-section:
.. index:: ! section
   pair: binary format; section

Sections
~~~~~~~~

Each section consists of

* a one-byte section *id*,
* the |U32| *size* of the contents in bytes,
* the actual *contents*, whose structure is depended on the section id.

Every section is optional; an omitted section is equivalent to the section being present with empty contents.

The following parameterized grammar rule defines the generic structure of a section with id :math:`N` and contents described by grammar :math:`\B{B}`.

.. math::
   \begin{array}{llclll}
   \production{sections} & \Bsection_N(\B{B}) &::=&
     N{:}\Bbyte~~\X{size}{:}\Bu32~~\X{cont}{:}\B{B}
       &\Rightarrow& \X{cont} & (\X{size} = |\B{B}|) \\ &&|&
     \epsilon &\Rightarrow& \epsilon
   \end{array}

For most sections, the contents :math:`\B{B}` encodes a :ref:`vector <binary-vec>`.
In these cases, the empty result :math:`\epsilon` is interpreted as the empty vector.

.. note::
   Other than for unknown :ref:`custom sections <binary-customsec>`,
   the :math:`\X{size}` is not required for decoding, but can be used to skip sections when navigating through a binary.
   The module is malformed if the size does not match the length of the binary contents :math:`\B{B}`.


.. _binary-customsec:
.. index:: ! custom section
   pair: binary format; custom section
   single: section; custom

Custom Section
~~~~~~~~~~~~~~

*Custom sections* have the id 0.
They are intended to be used for debugging information or third-party extensions, and are ignored by the WebAssembly semantics.
Their contents consist of a :ref:`name <syntax-name>` further identifying the custom section, followed by an uninterpreted sequence of bytes for custom use.

.. math::
   \begin{array}{llclll}
   \production{custom sections} & \Bcustomsec &::=&
     \Bsection_0(\Bcustom) \\
   \production{custom data} & \Bcustom &::=&
     \Bname~~\Bbyte^\ast \\
   \end{array}

.. note::
   If an implementation interprets the contents of a custom section, then errors in that contents, or the placement of the section, must not invalidate the module.


.. _binary-typesec:
.. _binary-type:
.. index:: ! type section, type definition
   pair: binary format; type section
   single: abstract syntax; type definition
   pair: section; type

Type Section
~~~~~~~~~~~~

The *type section* has the id 1.
It decodes into a vector of :ref:`function types <syntax-functype>` that represent the |TYPES| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{type sections} & \Btypesec &::=&
     \X{ft}^\ast{:\,}\Bsection_1(\Bfunctype^\ast) &\Rightarrow& \X{ft}^\ast \\
   \end{array}


.. _binary-importsec:
.. _binary-import:
.. index:: ! import section, import, name, function type, table type, memory type, global type
   pair: binary format; import
   single: abstract syntax; import
   pair: section; import

Import Section
~~~~~~~~~~~~~~

The *import section* has the id 2.
It decodes into a vector of :ref:`imports <syntax-import>` that represent the |IMPORTS| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{import sections} & \Bimportsec &::=&
     \X{im}^\ast{:}\Bsection_2(\Bimport^\ast) &\Rightarrow& \X{im}^\ast \\
   \production{imports} & \Bimport &::=&
     \X{mod}{:}\Bname~~\X{nm}{:}\Bname~~d{:}\Bimportdesc
       &\Rightarrow& \{ \MODULE~\X{mod}, \NAME~\X{nm}, \DESC~d \} \\
   \production{import descriptions} & \Bimportdesc &::=&
     \hex{00}~~x{:}\Btypeidx &\Rightarrow& \FUNC~x \\ &&|&
     \hex{01}~~\X{tt}{:}\Btabletype &\Rightarrow& \TABLE~\X{tt} \\ &&|&
     \hex{02}~~\X{mt}{:}\Bmemtype &\Rightarrow& \MEM~\X{mt} \\ &&|&
     \hex{03}~~\X{gt}{:}\Bglobaltype &\Rightarrow& \GLOBAL~\X{gt} \\
   \end{array}


.. _binary-funcsec:
.. _binary-func:
.. index:: ! function section, function, type index, function type
   pair: binary format; function
   single: abstract syntax; function
   pair: section; function

Function Section
~~~~~~~~~~~~~~~~

The *function section* has the id 3.
It decodes into a vector of :ref:`type indices <syntax-typeidx>` that represent the |TYPE| fields of the :ref:`functions <syntax-func>` in the |FUNCS| component of a :ref:`module <syntax-module>`.
The |LOCALS| and |BODY| fields of the respective functions are encoded separately in the :ref:`code section <binary-codesec>`.

.. math::
   \begin{array}{llclll}
   \production{function sections} & \Bfuncsec &::=&
     x^\ast{:}\Bsection_3(\Btypeidx^\ast) &\Rightarrow& x^\ast \\
   \end{array}


.. _binary-tablesec:
.. _binary-table:
.. index:: ! table section, table, table type
   pair: binary format; table
   single: abstract syntax; table
   pair: section; table

Table Section
~~~~~~~~~~~~~

The *table section* has the id 4.
It decodes into a vector of :ref:`tables <syntax-table>` that represent the |TABLES| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{table sections} & \Btablesec &::=&
     \X{tab}^\ast{:}\Bsection_4(\Btable^\ast) &\Rightarrow& \X{tab}^\ast \\
   \production{tables} & \Btable &::=&
     \X{tt}{:}\Btabletype &\Rightarrow& \{ \TYPE~\X{tt} \} \\
   \end{array}


.. _binary-memsec:
.. _binary-mem:
.. index:: ! memory section, memory, memory type
   pair: binary format; memory
   single: abstract syntax; memory
   pair: section; memory

Memory Section
~~~~~~~~~~~~~~

The *memory section* has the id 5.
It decodes into a vector of :ref:`memories <syntax-mem>` that represent the |MEMS| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{memory sections} & \Bmemsec &::=&
     \X{mem}^\ast{:}\Bsection_5(\Bmem^\ast) &\Rightarrow& \X{mem}^\ast \\
   \production{memories} & \Bmem &::=&
     \X{mt}{:}\Bmemtype &\Rightarrow& \{ \TYPE~\X{mt} \} \\
   \end{array}


.. _binary-globalsec:
.. _binary-global:
.. index:: ! global section, global, global type, expression
   pair: binary format; global
   single: abstract syntax; global
   pair: section; global

Global Section
~~~~~~~~~~~~~~

The *global section* has the id 6.
It decodes into a vector of :ref:`globals <syntax-global>` that represent the |GLOBALS| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{global sections} & \Bglobalsec &::=&
     \X{glob}^\ast{:}\Bsection_6(\Bglobal^\ast) &\Rightarrow& \X{glob}^\ast \\
   \production{globals} & \Bglobal &::=&
     \X{gt}{:}\Bglobaltype~~e{:}\Bexpr
       &\Rightarrow& \{ \TYPE~\X{gt}, \INIT~e \} \\
   \end{array}


.. _binary-exportsec:
.. _binary-export:
.. index:: ! export section, export, name, index, function index, table index, memory index, global index
   pair: binary format; export
   single: abstract syntax; export
   pair: section; export

Export Section
~~~~~~~~~~~~~~

The *export section* has the id 7.
It decodes into a vector of :ref:`exports <syntax-export>` that represent the |EXPORTS| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{export sections} & \Bexportsec &::=&
     \X{ex}^\ast{:}\Bsection_7(\Bexport^\ast) &\Rightarrow& \X{ex}^\ast \\
   \production{exports} & \Bexport &::=&
     \X{nm}{:}\Bname~~d{:}\Bexportdesc
       &\Rightarrow& \{ \NAME~\X{nm}, \DESC~d \} \\
   \production{export descriptions} & \Bexportdesc &::=&
     \hex{00}~~x{:}\Bfuncidx &\Rightarrow& \FUNC~x \\ &&|&
     \hex{01}~~x{:}\Btableidx &\Rightarrow& \TABLE~x \\ &&|&
     \hex{02}~~x{:}\Bmemidx &\Rightarrow& \MEM~x \\ &&|&
     \hex{03}~~x{:}\Bglobalidx &\Rightarrow& \GLOBAL~x \\
   \end{array}


.. _binary-startsec:
.. _binary-start:
.. index:: ! start section, start function, function index
   pair: binary format; start function
   single: abstract syntax; start function
   single: section; start
   single: start function; section

Start Section
~~~~~~~~~~~~~

The *start section* has the id 8.
It decodes into an optional :ref:`start function <syntax-start>` that represent the |START| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{start sections} & \Bstartsec &::=&
     \X{st}^?{:}\Bsection_8(\Bstart) &\Rightarrow& \X{st}^? \\
   \production{start functions} & \Bstart &::=&
     x{:}\Bfuncidx &\Rightarrow& \{ \FUNC~x \} \\
   \end{array}


.. _binary-elemsec:
.. _binary-elem:
.. index:: ! element section, element, table index, expression, function index
   pair: binary format; element
   single: abstract syntax; element
   pair: section; element
   single: table; element
   single: element; segment

Element Section
~~~~~~~~~~~~~~~

The *element section* has the id 9.
It decodes into a vector of :ref:`element segments <syntax-elem>` that represent the |ELEM| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{element sections} & \Belemsec &::=&
     \X{seg}^\ast{:}\Bsection_9(\Belem^\ast) &\Rightarrow& \X{seg} \\
   \production{element segments} & \Belem &::=&
     x{:}\Btableidx~~e{:}\Bexpr~~y^\ast{:}\Bvec(\Bfuncidx)
       &\Rightarrow& \{ \TABLE~x, \OFFSET~e, \INIT~y^\ast \} \\
   \end{array}


.. _binary-codesec:
.. _binary-local:
.. index:: ! code section, function, local, type index, function type
   pair: binary format; function
   single: abstract syntax; function
   pair: section; code

Code Section
~~~~~~~~~~~~

The *code section* has the id 10.
It decodes into a vector of *code* entries that are pairs of :ref:`value type <syntax-valtype>` vectors and :ref:`expressions <syntax-expr>`.
They represent the |LOCALS| and |BODY| field of the :ref:`functions <syntax-func>` in the |FUNCS| component of a :ref:`module <syntax-module>`.
The |TYPE| fields of the respective functions are encoded separately in the :ref:`function section <binary-funcsec>`.

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
   \begin{array}{llclll}
   \production{code sections} & \Bcodesec &::=&
     \X{code}^\ast{:}\Bsection_{10}(\Bcode^\ast)
       &\Rightarrow& \X{code}^\ast \\
   \production{code} & \Bcode &::=&
     \X{size}{:}\Bu32~~\X{code}{:}\Bfunc
       &\Rightarrow& \X{code} & (\X{size} = |\Bfunc|) \\
   \production{functions} & \Bfunc &::=&
     (t^\ast)^\ast{:}\Bvec(\Blocals)~~e{:}\Bexpr
       &\Rightarrow& (\F{concat}((t^\ast)^\ast), e^\ast)
         & (|\F{concat}((t^\ast)^\ast)| < 2^{32}) \\
   \production{locals} & \Blocals &::=&
     n{:}\Bu32~~t{:}\Bvaltype &\Rightarrow& t^n \\
   \end{array}

.. math (commented out)
   \begin{array}{llclll}
   \production{code sections} & \Bcodesec_{\typeidx^n} &::=&
     \f^\ast{:}\Bsection_{10}(\Bcode_{\typeidx}^n)
       &\Rightarrow& \f^\ast \\
   \production{code} & \Bcode_{\typeidx} &::=&
     \X{size}{:}\Bu32~~f{:}\Bfunc_{\typeidx}
       &\Rightarrow& f \qquad\qquad (\X{size} = |\Bfunc|) \\
   \production{functions} & \Bfunc_{\typeidx} &::=&
     (t^\ast)^\ast{:}\Bvec(\Blocals)~~e{:}\Bexpr &\Rightarrow&
       \{ \TYPE~\typeidx, \LOCALS~\F{concat}((t^\ast)^\ast), \BODY~e^\ast \} \\
   \production{locals} & \Blocals &::=&
     n{:}\Bu32~~t{:}\Bvaltype &\Rightarrow& t^n \\
   \end{array}

Here, :math:`\X{code}` ranges over pairs :math:`(\valtype^\ast, \expr)`.

The meta function :math:`\F{concat}((t^\ast)^\ast)` denotes the sequence of types formed by concatenating all sequences :math:`t_i^\ast` in :math:`(t^\ast)^\ast`.
Any code for which the length of the resulting sequence is out of bounds of the maximum size of a :ref:`vector <syntax-vec>` is malformed.

.. note::
   The :math:`\X{size}` is not needed for decoding, but like with :ref:`sections <binary-section>`, can be used to skip functions when navigating through a binary.
   The module is malformed if a size does not match the length of the respective function code.


.. _binary-datasec:
.. _binary-data:
.. index:: ! data section, data, memory, memory index, expression, byte
   pair: binary format; data
   single: abstract syntax; data
   pair: section; data
   single: memory; data
   single: data; segment

Data Section
~~~~~~~~~~~~

The *data section* has the id 11.
It decodes into a vector of :ref:`data segments <syntax-data>` that represent the |DATA| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{data sections} & \Bdatasec &::=&
     \X{seg}^\ast{:}\Bsection_{11}(\Bdata^\ast) &\Rightarrow& \X{seg} \\
   \production{data segments} & \Bdata &::=&
     x{:}\Bmemidx~~e{:}\Bexpr~~b^\ast{:}\Bvec(\Bbyte)
       &\Rightarrow& \{ \MEM~x, \OFFSET~e, \INIT~b^\ast \} \\
   \end{array}


.. _binary-module:
.. index:: module, section, type definition, function type, function, table, memory, global, element, data, start function, import, export, context
   pair: binary format; module
   single: abstract syntax; module

Modules
~~~~~~~

The encoding of a :ref:`module <syntax-module>` starts with a preamble containing a magic number and a version field.
The current version of the WebAssembly binary format is 1.

The preamble is followed by a sequence of :ref:`sections <binary-section>`.
:ref:`Custom sections <binary-customsec>` may be inserted at any place in this sequence,
while other sections may occur at most once and in a fixed order.
All sections can be empty.
The length of vectors produced by the (possibly empty) :ref:`function <binary-funcsec>` and :ref:`code <binary-codesec>` section must match up.

.. math::
   \begin{array}{llcllll}
   \production{modules} & \Bmodule &::=&
     \hex{00}~\hex{61}~\hex{73}~\hex{6D}~~~ \\ &&&
     \hex{01}~\hex{00}~\hex{00}~\hex{00}~~~ \\ &&&
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
     &\Rightarrow& \{ &
       \TYPES~\functype^\ast, \\ &&&&&&
       \FUNCS~\func^n, \\ &&&&&&
       \TABLES~\table^\ast, \\ &&&&&&
       \MEMS~\mem^\ast, \\ &&&&&&
       \GLOBALS~\global^\ast, \\ &&&&&&
       \ELEM~\elem^\ast, \\ &&&&&&
       \DATA~\data^\ast, \\ &&&&&&
       \START~\start^?, \\ &&&&&&
       \IMPORTS~\import^\ast, \\ &&&&&&
       \EXPORTS~\export^\ast ~~\} \\
   \end{array}

where for each :math:`(t_i^\ast, e_i)` in :math:`\X{code}^n`,
:math:`\func^n[i] = \{ \TYPE~\typeidx^n[i], \LOCALS~t_i^\ast, \BODY~e_i \}`.

.. note::
   The version of the WebAssembly binary format may increase in the future
   if backwards-incompatible changes are made to the format.

Modules
-------

The binary encoding of modules is organized into *sections*
that mostly correspond to the different components of a :ref:`module <syntax-module>` record.
However, :ref:`function definitions <syntax-func>` are split into two sections, separating their type declarations in the :ref:`function section <binary-func-section>` from their bodies in the :ref:`code section <binary-code-section>`.

.. note::
   This separation enables *parallel* and *streaming* compilation of a the functions in a module.


.. _binary-section:
.. index:: ! section
   pair: binary format; section

Sections
~~~~~~~~

Each section is headed by a one-byte section *id* and a size value giving the number of bytes of the binary contents of the section.
Every section is optional; an omitted section is equivalent to the section being present with empty content.

The following parameterized grammar rule defines the generic structure of a section with id :math:`N` and contents described by grammar :math:`B`.

.. math::
   \begin{array}{llclll}
   \production{sections} & \Bsection_N(B) &::=&
     \byte(N)~~\X{size}{:}\Bu32~~x{:}B
     &\Rightarrow&
     x
     & (\X{size} = |B|) \\
   &&|&
     \epsilon
     &\Rightarrow&
     \epsilon
   \end{array}

.. math::
   \begin{array}{llclll}
   \production{sections} & \Bsection_N(B) &::=&
     \byte(N)~~\X{size}{=}\Bu32~~x{=}B
     &\Rightarrow&
     x
     & (\X{size} = |B|) \\
   &&|&
     \epsilon
     &\Rightarrow&
     \epsilon
   \end{array}

.. math::
   \begin{array}{llclll}
   \production{sections} & \Bsection_N(B) &::=&
     \byte(N)~~\Bu32\{\X{size}\}~~B\{x\}
     &\Rightarrow&
     x
     & (\X{size} = |B|) \\
   &&|&
     \epsilon
     &\Rightarrow&
     \epsilon
   \end{array}

.. note::
   The :math:`\X{size}` is not required for decoding, but can be used to skip sections when navigating through a binary.
   The module is invalid if the size does not match the length of the binary contents :math:`B`.


.. _binary-custom-section:
.. index:: ! custom section
   pair: binary format; custom section

Custom Section
~~~~~~~~~~~~~~

*Custom sections* have the id 0.
They are intended to be used for debugging information or third-party extensions, and are ignored by the WebAssembly semantics.
Their contents consist of a :ref:`name <syntax-name>` identifying the kind of custom section, followed by an uninterpreted sequence of bytes for custom use.

.. math::
   \begin{array}{llclll}
   \production{custom sections} & \Bcustomsec &::=&
     \Bsection_0(\Bname~~\by^\ast) \\
   \end{array}

.. note::
   If an implementation interprets the contents of a custom section, then errors in that contents, or the placement of the section, must not invalidate the module.


.. _binary-type-section:
.. _binary-type:
.. index:: ! type section, type definition
   pair: binary format; type section
   single: abstract syntax; type definition

Type Section
~~~~~~~~~~~~

The *type section* has the id 1.
It encodes the |TYPES| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{type sections} & \Btypesec &::=&
     \Bsection_1(\Bfunctype\{\X{ft}\}^\ast)
     &\Rightarrow&
     \X{ft}^\ast \\
   \end{array}


.. _binary-import-section:
.. _binary-import:
.. index:: import, name, function type, table type, memory type, global type
   pair: binary format; import
   single: abstract syntax; import

Import Section
~~~~~~~~~~~~~~

The *import section* has the id 2.
It encodes the |IMPORTS| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{import sections} & \Bimportsec &::=&
     \Bsection_2(\Bimport\{\X{im}\}^\ast)
     &\Rightarrow&
     \X{im}^\ast \\
   \production{imports} & \Bimport &::=&
     \Bname\{\X{mod}\}~~\Bname\{\X{name}\}~~\Bimportdesc\{\X{desc}\}
     &\Rightarrow&
     \{ \MODULE~\X{mod}, \NAME~\X{name}, \DESC~\X{desc} \} \\
   \production{import descriptions} & \Bimportdesc &::=&
     \hex{00}~~\Btypeidx\{x\} &\Rightarrow& \FUNC~x \\ &&|&
     \hex{01}~~\Btabletype\{\X{tt}\} &\Rightarrow& \TABLE~\X{tt} \\ &&|&
     \hex{02}~~\Bmemtype\{\X{mt}\} &\Rightarrow& \MEM~\X{mt} \\ &&|&
     \hex{03}~~\Bglobaltype\{\X{gt}\} &\Rightarrow& \GLOBAL~\X{gt} \\
   \end{array}


.. _binary-func-section:
.. _binary-func:
.. index:: ! function section, function, type index, function type
   pair: binary format; function
   single: abstract syntax; function

Function Section
~~~~~~~~~~~~~~~~

The *function section* has the id 3.
It encodes the :ref:`type indices <syntax-typeidx>` of the :ref:`functions <syntax-func>` in the |FUNCS| component of a :ref:`module <syntax-module>`.
The bodies of the functions are encoded separately in the :ref:`code section <binary-code-section>`.

.. math::
   \begin{array}{llclll}
   \production{function sections} & \Bfuncsec &::=&
     \Bsection_3(\Bfuncidx\{x\}^\ast)
     &\Rightarrow&
     x^\ast \\
   \end{array}


.. _binary-table-section:
.. _binary-table:
.. index:: table, table type
   pair: binary format; table
   single: abstract syntax; table

Table Section
~~~~~~~~~~~~~

The *table section* has the id 4.
It encodes the |TABLES| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{table sections} & \Btablesec &::=&
     \Bsection_4(\Btable\{\X{tab}\}^\ast)
     &\Rightarrow&
     \X{tab}^\ast \\
   \production{tables} & \Btable &::=&
     \Btabletype\{\X{tt}\}
     &\Rightarrow&
     \{ \TYPE~\X{tt} \} \\
   \end{array}


.. _binary-mem-section:
.. _binary-mem:
.. index:: ! memory section, memory, memory type
   pair: binary format; memory
   single: abstract syntax; memory

Memory Section
~~~~~~~~~~~~~~

The *memory section* has the id 5.
It encodes the |MEMS| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{memory sections} & \Bmemsec &::=&
     \Bsection_5(\Bmem\{\X{mem}\}^\ast)
     &\Rightarrow&
     \X{mem}^\ast \\
   \production{memories} & \Bmem &::=&
     \Bmemtype\{\X{mt}\}
     &\Rightarrow&
     \{ \TYPE~\X{mt} \} \\
   \end{array}


.. _binary-global-section:
.. _binary-global:
.. index:: ! global section, global, global type, expression
   pair: binary format; global
   single: abstract syntax; global

Global Section
~~~~~~~~~~~~~~

The *global section* has the id 6.
It encodes the |GLOBALS| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{global sections} & \Bglobalsec &::=&
     \Bsection_6(\Bglobal\{\X{glob}\}^\ast)
     &\Rightarrow&
     \X{glob}^\ast \\
   \production{globals} & \Bglobal &::=&
     \Bglobaltype\{\X{gt}\}~~\Bexpr\{e\}
     &\Rightarrow&
     \{ \TYPE~\X{gt}, \INIT~e \} \\
   \end{array}


.. _binary-export-section:
.. _binary-export:
.. index:: ! export section, export, name, index, function index, table index, memory index, global index
   pair: binary format; export
   single: abstract syntax; export

Export Section
~~~~~~~~~~~~~~

The *export section* has the id 7.
It encodes the |EXPORTS| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{export sections} & \Bexportsec &::=&
     \Bsection_7(\Bexport\{\X{ex}\}^\ast)
     &\Rightarrow&
     \X{ex}^\ast \\
   \production{exports} & \Bexport &::=&
     \Bname\{\X{name}\}~~\Bexportdesc\{\X{desc}\}
     &\Rightarrow&
     \{ \NAME~\X{name}, \DESC~\X{desc} \} \\
   \production{export descriptions} & \Bexportdesc &::=&
     \hex{00}~~\Bfuncidx\{x\} &\Rightarrow& \FUNC~x \\ &&|&
     \hex{01}~~\Btableidx\{x\} &\Rightarrow& \TABLE~x \\ &&|&
     \hex{02}~~\Bmemidx\{x\} &\Rightarrow& \MEM~x \\ &&|&
     \hex{03}~~\Bglobalidx\{x\} &\Rightarrow& \GLOBAL~x \\
   \end{array}


.. _binary-start-section:
.. _binary-start:
.. index:: ! start section, start function, function index
   pair: binary format; start function
   single: abstract syntax; start function

Start Section
~~~~~~~~~~~~~

The *start section* has the id 8.
It encodes the |START| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{start sections} & \Bstartsec &::=&
     \Bsection_8(\Bstart\{\X{st}\})
     &\Rightarrow&
     \X{st} \\
   \production{start functions} & \Bstart &::=&
     \Bfuncidx\{x\}
     &\Rightarrow&
     \{ \FUNC~x \} \\
   \end{array}


.. _binary-elem-section:
.. _binary-elem:
.. index:: ! element section, element, table index, expression, function index
   pair: binary format; element
   single: abstract syntax; element
   single: table; element
   single: element; segment

Element Section
~~~~~~~~~~~~~~~

The *element section* has the id 9.
It encodes the |ELEM| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{element sections} & \Belemsec &::=&
     \Bsection_9(\Belem\{\X{seg}\}^\ast)
     &\Rightarrow&
     \X{seg} \\
   \production{element segments} & \Belem &::=&
     \Btableidx\{x\}~~\Bexpr\{e\}~~\Bvec(\Bfuncidx)\{y^\ast\}
     &\Rightarrow&
     \{ \TABLE~x, \OFFSET~e, \INIT~y^\ast \} \\
   \end{array}


.. _binary-code-section:
.. _binary-local:
.. index:: ! code section, function, local, type index, function type
   pair: binary format; function
   single: abstract syntax; function

Code Section
~~~~~~~~~~~~

The *code section* has the id 10.
It encodes the code (locals and bodies) of the :ref:`functions <syntax-func>` in the |FUNCS| component of a :ref:`module <syntax-module>`.
The :ref:`type indices <syntax-typeidx>` are encoded separately in the :ref:`function section <binary-function-section>`.

Each code entry is preceded by a size value giving the number of bytes of the body.

.. math::
   \begin{array}{llclll}
   \production{code sections} & \Bcodesec &::=&
     \Bsection_{10}(\Bcode\{t^\ast, e\}^\ast)
     &\Rightarrow&
     (t^\ast, e)^\ast \\
   \production{code} & \Bcode &::=&
     \Bu32\{\X{size}\}~~\Bvec(\Blocal)\{(t^\ast, e)^\ast\}~~\Bexpr\{e\}
     &\Rightarrow&
     \F{flatten}((t^\ast)^\ast), e^\ast
     & (\X{size} = |\Bvec(\Blocal)~\Bexpr|) \\
   \production{locals} & \Blocal &::=&
     \Bvec(\Bvaltype)\{t^\ast\}~~\Bexpr\{e\}
     &\Rightarrow&
     t^\ast, e^\ast \\
   \end{array}

Here, :math:`\F{flatten}((t^\ast)^\ast)` denotes the sequence of types formed by concatenating all sequences :math:`t^\ast` in :math:`(t^\ast)^\ast`.

.. note::
   The :math:`\X{size}` is not needed for decoding, but like with :ref:`sections <binary-section>`, can be used to skip functions when navigating through a binary.
   The module is invalid if the size does not match the length of the binary sizes of the locals vector :math:`\Bvec(\Blocal)` plus the size of :math:`\Bexpr'.


.. _binary-data-section:
.. _binary-data:
.. index:: ! data section, data, memory, memory index, expression, byte
   pair: binary format; data
   single: abstract syntax; data
   single: memory; data
   single: data; segment

Data Section
~~~~~~~~~~~~

The *data section* has the id 11.
It encodes the |DATA| component of a :ref:`module <syntax-module>`.

.. math::
   \begin{array}{llclll}
   \production{data sections} & \Bdatasec &::=&
     \Bsection_{11}(\Bdata\{\X{seg}\}^\ast)
     &\Rightarrow&
     \X{seg} \\
   \production{data segments} & \Bdata &::=&
     \Bmemidx\{x\}~~\Bexpr\{e\}~~\Bvec(\by)\{b^\ast\}
     &\Rightarrow&
     \{ \MEM~x, \OFFSET~e, \INIT~b^\ast \} \\
   \end{array}


.. _binary-module:
.. index:: modules, type definition, function type, function, table, memory, global, element, data, start function, import, export, context
   pair: binary format; module
   single: abstract syntax; module

Modules
~~~~~~~

The encoding of a :ref:`module <syntax-module>` starts with a preamble containing a magic number and a version field.
The preamble is followed by a sequence of :ref:`sections <binary-section>`.
:ref:`Custom sections <binary-custom-section>` may be inserted at any place in this sequence,
while other sections may occur at most once and in a fixed order.
All sections are optional; an omitted section is equivalent to a section present with length 0.
The length of the :ref:`function <binary-func-section>` and the :ref:`code <binary-code-section>` section must match up.

.. math::
   \begin{array}{llcllll}
   \production{modules} & \Bmodule &::=&
     \hex{00}~\hex{61}~\hex{73}~\hex{6D}~~~ \\ &&&
     \hex{01}~\hex{00}~\hex{00}~\hex{00}~~~ \\ &&&
     \Bcustomsec^\ast \\ &&&
     \Btypesec\{\functype^\ast\} \\ &&&
     \Bcustomsec^\ast \\ &&&
     \Bimportsec\{\import^\ast\} \\ &&&
     \Bcustomsec^\ast \\ &&&
     \Bfuncsec\{\typeidx^n\} \\ &&&
     \Bcustomsec^\ast \\ &&&
     \Btablesec\{\table^\ast\} \\ &&&
     \Bcustomsec^\ast \\ &&&
     \Bmemsec\{\mem^\ast\} \\ &&&
     \Bcustomsec^\ast \\ &&&
     \Bglobalsec\{\global^\ast\} \\ &&&
     \Bcustomsec^\ast \\ &&&
     \Bexportsec\{\export^\ast\} \\ &&&
     \Bcustomsec^\ast \\ &&&
     \Bstartsec\{\start^?\} \\ &&&
     \Bcustomsec^\ast \\ &&&
     \Belemsec\{\elem^\ast\} \\ &&&
     \Bcustomsec^\ast \\ &&&
     \Bcodesec\{(\valtype^\ast, \expr)^n\} \\ &&&
     \Bcustomsec^\ast \\ &&&
     \Bdatasec\{\data^\ast\} \\ &&&
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

where for each :math:`\func_i` in :math:`\func^n`, :math:`\func_i = \{ \TYPE~\typeidx^n[i], \LOCALS~(\valtype^\ast)^n[i], \BODY~\expr^n[i] \}`.

.. note::
   The current version of the WebAssembly binary format is 1.
   This may change in the future.

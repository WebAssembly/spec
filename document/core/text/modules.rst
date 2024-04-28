Modules
-------


.. index:: index, type index, function index, table index, memory index, global index, element index, data index, local index, label index
   pair: text format; type index
   pair: text format; function index
   pair: text format; table index
   pair: text format; memory index
   pair: text format; global index
   pair: text format; element index
   pair: text format; data index
   pair: text format; local index
   pair: text format; label index
.. _text-typeidx:
.. _text-funcidx:
.. _text-tableidx:
.. _text-memidx:
.. _text-elemidx:
.. _text-dataidx:
.. _text-globalidx:
.. _text-localidx:
.. _text-labelidx:
.. _text-fieldidx:
.. _text-index:

Indices
~~~~~~~

:ref:`Indices <syntax-index>` can be given either in raw numeric form or as symbolic :ref:`identifiers <text-id>` when bound by a respective construct.
Such identifiers are looked up in the suitable space of the :ref:`identifier context <text-context>` :math:`I`.

.. math::
   \begin{array}{llcllllllll}
   \production{type index} & \Ttypeidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\&&|&
     v{:}\Tid &\Rightarrow& x & (\iff I.\ITYPES[x] = v) \\
   \production{function index} & \Tfuncidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\&&|&
     v{:}\Tid &\Rightarrow& x & (\iff I.\IFUNCS[x] = v) \\
   \production{table index} & \Ttableidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\&&|&
     v{:}\Tid &\Rightarrow& x & (\iff I.\ITABLES[x] = v) \\
   \production{memory index} & \Tmemidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\&&|&
     v{:}\Tid &\Rightarrow& x & (\iff I.\IMEMS[x] = v) \\
   \production{global index} & \Tglobalidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\&&|&
     v{:}\Tid &\Rightarrow& x & (\iff I.\IGLOBALS[x] = v) \\
   \production{element index} & \Telemidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\&&|&
     v{:}\Tid &\Rightarrow& x & (\iff I.\IELEM[x] = v) \\
   \production{data index} & \Tdataidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\&&|&
     v{:}\Tid &\Rightarrow& x & (\iff I.\IDATA[x] = v) \\
   \production{local index} & \Tlocalidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\&&|&
     v{:}\Tid &\Rightarrow& x & (\iff I.\ILOCALS[x] = v) \\
   \production{label index} & \Tlabelidx_I &::=&
     l{:}\Tu32 &\Rightarrow& l \\&&|&
     v{:}\Tid &\Rightarrow& l & (\iff I.\ILABELS[l] = v) \\
   \production{field index} & \Tfieldidx_{I,x} &::=&
     i{:}\Tu32 &\Rightarrow& i \\&&|&
     v{:}\Tid &\Rightarrow& i & (\iff I.\IFIELDS[x][i] = v) \\
   \end{array}


.. index:: type use
   pair: text format; type use
.. _text-typeuse:

Type Uses
~~~~~~~~~

A *type use* is a reference to a function :ref:`type definition <text-type>`.
It may optionally be augmented by explicit inlined :ref:`parameter <text-param>` and :ref:`result <text-result>` declarations.
That allows binding symbolic :ref:`identifiers <text-id>` to name the :ref:`local indices <text-localidx>` of parameters.
If inline declarations are given, then their types must match the referenced :ref:`function type <text-type>`.

.. math::
   \begin{array}{llcllll}
   \production{type use} & \Ttypeuse_I &::=&
     \text{(}~\text{type}~~x{:}\Ttypeidx_I~\text{)}
       \quad\Rightarrow\quad x, I' \\ &&& \qquad
       (\iff \begin{array}[t]{@{}l@{}}
        I.\ITYPEDEFS[x] = \TSUB~\TFINAL~(\TFUNC~[t_1^n] \toF [t_2^\ast]) \wedge
        I' = \{\ILOCALS~(\epsilon)^n\}) \\
        \end{array} \\[1ex] &&|&
     \text{(}~\text{type}~~x{:}\Ttypeidx_I~\text{)}
     ~~(t_1{:}\Tparam)^\ast~~(t_2{:}\Tresult)^\ast
       \quad\Rightarrow\quad x, I' \\ &&& \qquad
       (\iff \begin{array}[t]{@{}l@{}}
        I.\ITYPEDEFS[x] = \TSUB~\TFINAL~(\TFUNC~[t_1^\ast] \toF [t_2^\ast]) \wedge
        I' = \{\ILOCALS~\F{id}(\Tparam)^\ast\} \idcwellformed) \\
        \end{array} \\
   \end{array}

.. note::
   If inline declarations are given, their types must be *syntactically* equal to the types from the indexed definition;
   possible type :ref:`substitutions <notation-subst>` from other definitions that might make them equal are not taken into account.
   This is to simplify syntactic pre-processing.

The synthesized attribute of a |Ttypeuse| is a pair consisting of both the used :ref:`type index <syntax-typeidx>` and the local :ref:`identifier context <text-context>` containing possible parameter identifiers.
The following auxiliary function extracts optional identifiers from parameters:

.. math::
   \begin{array}{lcl@{\qquad\qquad}l}
   \F{id}(\text{(}~\text{param}~\Tid^?~\dots~\text{)}) &=& \Tid^? \\
   \end{array}

.. note::
   Both productions overlap for the case that the function type is :math:`[] \toF []`.
   However, in that case, they also produce the same results, so that the choice is immaterial.

   The :ref:`well-formedness <text-context-wf>` condition on :math:`I'` ensures that the parameters do not contain duplicate identifiers.


.. _text-typeuse-abbrev:

Abbreviations
.............

A |Ttypeuse| may also be replaced entirely by inline :ref:`parameter <text-param>` and :ref:`result <text-result>` declarations.
In that case, a :ref:`type index <syntax-typeidx>` is automatically inserted:

.. math::
   \begin{array}{llclll}
   \production{type use} &
     (t_1{:}\Tparam)^\ast~~(t_2{:}\Tresult)^\ast &\equiv&
     \text{(}~\text{type}~~x~\text{)}~~\Tparam^\ast~~\Tresult^\ast \\
   \end{array}

where :math:`x` is the smallest existing :ref:`type index <syntax-typeidx>` whose :ref:`recursive type <syntax-rectype>` definition in the current module is of the form

.. math::
   \text{(}~\text{rec}~\text{(}~\text{type}~\text{(}~\text{sub}~\text{final}~~\text{(}~\text{func}~~\Tparam^\ast~~\Tresult^\ast~\text{)}~\text{)}~\text{)}~\text{)}

If no such index exists, then a new :ref:`recursive type <text-rectype>` of the same form is inserted at the end of the module.

Abbreviations are expanded in the order they appear, such that previously inserted type definitions are reused by consecutive expansions.


.. index:: import, name, function type, table type, memory type, global type
   pair: text format; import
.. _text-importdesc:
.. _text-import:

Imports
~~~~~~~

The descriptors in imports can bind a symbolic function, table, memory, or global :ref:`identifier <text-id>`.

.. math::
   \begin{array}{llclll}
   \production{import} & \Timport_I &::=&
     \text{(}~\text{import}~~\X{mod}{:}\Tname~~\X{nm}{:}\Tname~~d{:}\Timportdesc_I~\text{)} \\ &&& \qquad
       \Rightarrow\quad \{ \IMODULE~\X{mod}, \INAME~\X{nm}, \IDESC~d \} \\[1ex]
   \production{import description} & \Timportdesc_I &::=&
     \text{(}~\text{func}~~\Tid^?~~x,I'{:}\Ttypeuse_I~\text{)}
       &\Rightarrow& \IDFUNC~x \\ &&|&
     \text{(}~\text{table}~~\Tid^?~~\X{tt}{:}\Ttabletype_I~\text{)}
       &\Rightarrow& \IDTABLE~\X{tt} \\ &&|&
     \text{(}~\text{memory}~~\Tid^?~~\X{mt}{:}\Tmemtype_I~\text{)}
       &\Rightarrow& \IDMEM~~\X{mt} \\ &&|&
     \text{(}~\text{global}~~\Tid^?~~\X{gt}{:}\Tglobaltype_I~\text{)}
       &\Rightarrow& \IDGLOBAL~\X{gt} \\
   \end{array}


Abbreviations
.............

As an abbreviation, imports may also be specified inline with :ref:`function <text-func>`, :ref:`table <text-table>`, :ref:`memory <text-mem>`, or :ref:`global <text-global>` definitions; see the respective sections.



.. index:: function, type index, function type, identifier, local
   pair: text format; function
   pair: text format; local
.. _text-local:
.. _text-func:

Functions
~~~~~~~~~

Function definitions can bind a symbolic :ref:`function identifier <text-id>`, and :ref:`local identifiers <text-id>` for its :ref:`parameters <text-typeuse>` and locals.

.. math::
   \begin{array}{llclll}
   \production{function} & \Tfunc_I &::=&
     \text{(}~\text{func}~~\Tid^?~~x,I'{:}\Ttypeuse_I~~
     (\X{loc}{:}\Tlocal_I)^\ast~~(\X{in}{:}\Tinstr_{I''})^\ast~\text{)} \\ &&& \qquad
       \Rightarrow\quad \{ \FTYPE~x, \FLOCALS~\X{loc}^\ast, \FBODY~\X{in}^\ast~\END \} \\ &&& \qquad\qquad\qquad
       (\iff I'' = I \compose I' \compose \{\ILOCALS~\F{id}(\Tlocal)^\ast\} \idcwellformed) \\[1ex]
   \production{local} & \Tlocal_I &::=&
     \text{(}~\text{local}~~\Tid^?~~t{:}\Tvaltype_I~\text{)}
       \quad\Rightarrow\quad \{ \LTYPE~t \} \\
   \end{array}

The definition of the local :ref:`identifier context <text-context>` :math:`I''` uses the following auxiliary function to extract optional identifiers from locals:

.. math::
   \begin{array}{lcl@{\qquad\qquad}l}
   \F{id}(\text{(}~\text{local}~\Tid^?~\dots~\text{)}) &=& \Tid^? \\
   \end{array}


.. note::
   The :ref:`well-formedness <text-context-wf>` condition on :math:`I''` ensures that parameters and locals do not contain duplicate identifiers.


.. index:: import, name
   pair: text format; import
.. index:: export, name, index, function index
   pair: text format; export
.. _text-func-abbrev:

Abbreviations
.............

Multiple anonymous locals may be combined into a single declaration:

.. math::
   \begin{array}{llclll}
   \production{local} &
     \text{(}~~\text{local}~~\Tvaltype^\ast~~\text{)} &\equiv&
     (\text{(}~~\text{local}~~\Tvaltype~~\text{)})^\ast \\
   \end{array}

Functions can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{func}~~\Tid^?~~\text{(}~\text{import}~~\Tname_1~~\Tname_2~\text{)}~~\Ttypeuse~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{import}~~\Tname_1~~\Tname_2~~\text{(}~\text{func}~~\Tid^?~~\Ttypeuse~\text{)}~\text{)} \\[1ex] &
     \text{(}~\text{func}~~\Tid^?~~\text{(}~\text{export}~~\Tname~\text{)}~~\dots~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{export}~~\Tname~~\text{(}~\text{func}~~\Tid'~\text{)}~\text{)}~~
       \text{(}~\text{func}~~\Tid'~~\dots~\text{)}
       \\ & \qquad\qquad
       (\iff \Tid^? \neq \epsilon \wedge \Tid' = \Tid^? \vee \Tid^? = \epsilon \wedge \Tid' \idfresh) \\
   \end{array}

.. note::
   The latter abbreviation can be applied repeatedly, if ":math:`\dots`" contains additional export clauses.
   Consequently, a function declaration can contain any number of exports, possibly followed by an import.


.. index:: table, table type, identifier, expression
   pair: text format; table
.. _text-table:

Tables
~~~~~~

Table definitions can bind a symbolic :ref:`table identifier <text-id>`.

.. math::
   \begin{array}{llclll}
   \production{table} & \Ttable_I &::=&
     \text{(}~\text{table}~~\Tid^?~~\X{tt}{:}\Ttabletype_I~~e{:}\Texpr_I~\text{)}
       &\Rightarrow& \{ \TTYPE~\X{tt}, \TINIT~e \} \\
   \end{array}


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

A table's initialization :ref:`expression <text-expr>` can be omitted, in which case it defaults to :math:`\REFNULL`:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{table}~~\Tid^?~~\Ttabletype~\text{)}
       &\equiv&
       \text{(}~\text{table}~~\Tid^?~~\Ttabletype~~\text{(}~\REFNULL~\X{ht}~\text{)}~\text{)}
       \\ &&& \qquad\qquad
       (\iff \Ttabletype = \Tlimits~\text{(}~\text{ref}~\text{null}^?~\X{ht}~\text{)}) \\
   \end{array}

An :ref:`element segment <text-elem>` can be given inline with a table definition, in which case its offset is :math:`0` and the :ref:`limits <text-limits>` of the :ref:`table type <text-tabletype>` are inferred from the length of the given segment:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{table}~~\Tid^?~~\Treftype~~\text{(}~\text{elem}~~\expr^n{:}\Tvec(\Telemexpr)~\text{)}~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{table}~~\Tid'~~n~~n~~\Treftype~\text{)} \\ & \qquad
       \text{(}~\text{elem}~~\text{(}~\text{table}~~\Tid'~\text{)}~~\text{(}~\text{i32.const}~~\text{0}~\text{)}~~\Treftype~~\Tvec(\Telemexpr)~\text{)}
       \\ & \qquad\qquad
       (\iff \Tid^? \neq \epsilon \wedge \Tid' = \Tid^? \vee \Tid^? = \epsilon \wedge \Tid' \idfresh) \\
   \end{array}

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{table}~~\Tid^?~~\Treftype~~\text{(}~\text{elem}~~x^n{:}\Tvec(\Tfuncidx)~\text{)}~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{table}~~\Tid'~~n~~n~~\Treftype~\text{)} \\ & \qquad
       \text{(}~\text{elem}~~\text{(}~\text{table}~~\Tid'~\text{)}~~\text{(}~\text{i32.const}~~\text{0}~\text{)}~~\Treftype~~\Tvec(\text{(}~\text{ref.func}~~\Tfuncidx~\text{)})~\text{)}
       \\ & \qquad\qquad
       (\iff \Tid^? \neq \epsilon \wedge \Tid' = \Tid^? \vee \Tid^? = \epsilon \wedge \Tid' \idfresh) \\
   \end{array}

Tables can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{table}~~\Tid^?~~\text{(}~\text{import}~~\Tname_1~~\Tname_2~\text{)}~~\Ttabletype~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{import}~~\Tname_1~~\Tname_2~~\text{(}~\text{table}~~\Tid^?~~\Ttabletype~\text{)}~\text{)} \\[1ex] &
     \text{(}~\text{table}~~\Tid^?~~\text{(}~\text{export}~~\Tname~\text{)}~~\dots~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{export}~~\Tname~~\text{(}~\text{table}~~\Tid'~\text{)}~\text{)}~~
       \text{(}~\text{table}~~\Tid'~~\dots~\text{)}
       \\ & \qquad\qquad
       (\iff \Tid^? \neq \epsilon \wedge \Tid' = \Tid^? \vee \Tid^? = \epsilon \wedge \Tid' \idfresh) \\
   \end{array}

.. note::
   The latter abbreviation can be applied repeatedly, if ":math:`\dots`" contains additional export clauses.
   Consequently, a table declaration can contain any number of exports, possibly followed by an import.


.. index:: memory, memory type, identifier
   pair: text format; memory
.. _text-mem:

Memories
~~~~~~~~

Memory definitions can bind a symbolic :ref:`memory identifier <text-id>`.

.. math::
   \begin{array}{llclll}
   \production{memory} & \Tmem_I &::=&
     \text{(}~\text{memory}~~\Tid^?~~\X{mt}{:}\Tmemtype_I~\text{)}
       &\Rightarrow& \{ \MTYPE~\X{mt} \} \\
   \end{array}


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

A :ref:`data segment <text-data>` can be given inline with a memory definition, in which case its offset is :math:`0` and the :ref:`limits <text-limits>` of the :ref:`memory type <text-memtype>` are inferred from the length of the data, rounded up to :ref:`page size <page-size>`:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{memory}~~\Tid^?~~\text{(}~\text{data}~~b^n{:}\Tdatastring~\text{)}~~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{memory}~~\Tid'~~m~~m~\text{)} \\ & \qquad
       \text{(}~\text{data}~~\text{(}~\text{memory}~~\Tid'~\text{)}~~\text{(}~\text{i32.const}~~\text{0}~\text{)}~~\Tdatastring~\text{)}
       \\ & \qquad\qquad
       (\iff \Tid^? \neq \epsilon \wedge \Tid' = \Tid^? \vee \Tid^? = \epsilon \wedge \Tid' \idfresh, m = \F{ceil}(n / 64\,\F{Ki})) \\
   \end{array}

Memories can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{memory}~~\Tid^?~~\text{(}~\text{import}~~\Tname_1~~\Tname_2~\text{)}~~\Tmemtype~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{import}~~\Tname_1~~\Tname_2~~\text{(}~\text{memory}~~\Tid^?~~\Tmemtype~\text{)}~\text{)}
       \\[1ex] &
     \text{(}~\text{memory}~~\Tid^?~~\text{(}~\text{export}~~\Tname~\text{)}~~\dots~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{export}~~\Tname~~\text{(}~\text{memory}~~\Tid'~\text{)}~\text{)}~~
       \text{(}~\text{memory}~~\Tid'~~\dots~\text{)}
       \\ & \qquad\qquad
       (\iff \Tid^? \neq \epsilon \wedge \Tid' = \Tid^? \vee \Tid^? = \epsilon \wedge \Tid' \idfresh) \\
   \end{array}

.. note::
   The latter abbreviation can be applied repeatedly, if ":math:`\dots`" contains additional export clauses.
   Consequently, a memory declaration can contain any number of exports, possibly followed by an import.


.. index:: global, global type, identifier, expression
   pair: text format; global
.. _text-global:

Globals
~~~~~~~

Global definitions can bind a symbolic :ref:`global identifier <text-id>`.

.. math::
   \begin{array}{llclll}
   \production{global} & \Tglobal_I &::=&
     \text{(}~\text{global}~~\Tid^?~~\X{gt}{:}\Tglobaltype_I~~e{:}\Texpr_I~\text{)}
       &\Rightarrow& \{ \GTYPE~\X{gt}, \GINIT~e \} \\
   \end{array}


.. index:: import, name
   pair: text format; import
.. index:: export, name, index, global index
   pair: text format; export
.. _text-global-abbrev:

Abbreviations
.............

Globals can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{global}~~\Tid^?~~\text{(}~\text{import}~~\Tname_1~~\Tname_2~\text{)}~~\Tglobaltype~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{import}~~\Tname_1~~\Tname_2~~\text{(}~\text{global}~~\Tid^?~~\Tglobaltype~\text{)}~\text{)}
       \\[1ex] &
     \text{(}~\text{global}~~\Tid^?~~\text{(}~\text{export}~~\Tname~\text{)}~~\dots~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{export}~~\Tname~~\text{(}~\text{global}~~\Tid'~\text{)}~\text{)}~~
       \text{(}~\text{global}~~\Tid'~~\dots~\text{)}
       \\ & \qquad\qquad
       (\iff \Tid^? \neq \epsilon \wedge \Tid' = \Tid^? \vee \Tid^? = \epsilon \wedge \Tid' \idfresh) \\
   \end{array}

.. note::
   The latter abbreviation can be applied repeatedly, if ":math:`\dots`" contains additional export clauses.
   Consequently, a global declaration can contain any number of exports, possibly followed by an import.


.. index:: export, name, index, function index, table index, memory index, global index
   pair: text format; export
.. _text-exportdesc:
.. _text-export:

Exports
~~~~~~~

The syntax for exports mirrors their :ref:`abstract syntax <syntax-export>` directly.

.. math::
   \begin{array}{llclll}
   \production{export} & \Texport_I &::=&
     \text{(}~\text{export}~~\X{nm}{:}\Tname~~d{:}\Texportdesc_I~\text{)}
       &\Rightarrow& \{ \ENAME~\X{nm}, \EDESC~d \} \\
   \production{export description} & \Texportdesc_I &::=&
     \text{(}~\text{func}~~x{:}\Tfuncidx_I~\text{)}
       &\Rightarrow& \EDFUNC~x \\ &&|&
     \text{(}~\text{table}~~x{:}\Ttableidx_I~\text{)}
       &\Rightarrow& \EDTABLE~x \\ &&|&
     \text{(}~\text{memory}~~x{:}\Tmemidx_I~\text{)}
       &\Rightarrow& \EDMEM~x \\ &&|&
     \text{(}~\text{global}~~x{:}\Tglobalidx_I~\text{)}
       &\Rightarrow& \EDGLOBAL~x \\
   \end{array}


Abbreviations
.............

As an abbreviation, exports may also be specified inline with :ref:`function <text-func>`, :ref:`table <text-table>`, :ref:`memory <text-mem>`, or :ref:`global <text-global>` definitions; see the respective sections.


.. index:: start function, function index
   pair: text format; start function
.. _text-start:

Start Function
~~~~~~~~~~~~~~

A :ref:`start function <syntax-start>` is defined in terms of its index.

.. math::
   \begin{array}{llclll}
   \production{start function} & \Tstart_I &::=&
     \text{(}~\text{start}~~x{:}\Tfuncidx_I~\text{)}
       &\Rightarrow& \{ \SFUNC~x \} \\
   \end{array}

.. note::
   At most one start function may occur in a module,
   which is ensured by a suitable side condition on the |Tmodule| grammar.



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

.. math::
   \begin{array}{llclll}
   \production{element segment} & \Telem_I &::=&
     \text{(}~\text{elem}~~\Tid^?~~(et, y^\ast){:}\Telemlist_I~\text{)} \\ &&& \qquad
       \Rightarrow\quad \{ \ETYPE~et, \EINIT~y^\ast, \EMODE~\EPASSIVE \} \\ &&|&
     \text{(}~\text{elem}~~\Tid^?~~x{:}\Ttableuse_I~~\text{(}~\text{offset}~~e{:}\Texpr_I~\text{)}~~(et, y^\ast){:}\Telemlist_I~\text{)} \\ &&& \qquad
       \Rightarrow\quad \{ \ETYPE~et, \EINIT~y^\ast, \EMODE~\EACTIVE~\{ \ETABLE~x, \EOFFSET~e \} \} \\ &&&
     \text{(}~\text{elem}~~\Tid^?~~\text{declare}~~(et, y^\ast){:}\Telemlist_I~\text{)} \\ &&& \qquad
       \Rightarrow\quad \{ \ETYPE~et, \EINIT~y^\ast, \EMODE~\EDECLARATIVE \} \\
   \production{element list} & \Telemlist_I &::=&
     t{:}\Treftype_I~~y^\ast{:}\Tvec(\Telemexpr_I) \qquad\Rightarrow\quad ( \ETYPE~t, \EINIT~y^\ast ) \\
   \production{element expression} & \Telemexpr_I &::=&
     \text{(}~\text{item}~~e{:}\Texpr_I~\text{)}
       \quad\Rightarrow\quad e \\
   \production{table use} & \Ttableuse_I &::=&
     \text{(}~\text{table}~~x{:}\Ttableidx_I ~\text{)}
       \quad\Rightarrow\quad x \\
   \end{array}


Abbreviations
.............

As an abbreviation, a single instruction may occur in place of the offset of an active element segment or as an element expression:

.. math::
   \begin{array}{llcll}
   \production{element offset} &
     \text{(}~\Tinstr~\text{)} &\equiv&
     \text{(}~\text{offset}~~\Tinstr~\text{)} \\
   \production{element item} &
     \text{(}~\Tinstr~\text{)} &\equiv&
     \text{(}~\text{item}~~\Tinstr~\text{)} \\
   \end{array}

Also, the element list may be written as just a sequence of :ref:`function indices <text-funcidx>`:

.. math::
   \begin{array}{llcll}
   \production{element list} &
     \text{func}~~\Tvec(\Tfuncidx_I) &\equiv&
     \text{(ref}~\text{func)}~~\Tvec(\text{(}~\text{ref.func}~~\Tfuncidx_I~\text{)})
   \end{array}

A table use can be omitted, defaulting to :math:`\T{0}`.
Furthermore, for backwards compatibility with earlier versions of WebAssembly, if the table use is omitted, the :math:`\text{func}` keyword can be omitted as well.

.. math::
   \begin{array}{llclll}
   \production{table use} &
     \epsilon &\equiv& \text{(}~\text{table}~~\text{0}~\text{)} \\
   \production{element segment} &
     \text{(}~\text{elem}~~\Tid^?~~\text{(}~\text{offset}~~\Texpr_I~\text{)}~~\Tvec(\Tfuncidx_I)~\text{)}
       &\equiv&
     \text{(}~\text{elem}~~\Tid^?~~\text{(}~\text{table}~~\text{0}~\text{)}~~\text{(}~\text{offset}~~\Texpr_I~\text{)}~~\text{func}~~\Tvec(\Tfuncidx_I)~\text{)}
   \end{array}

As another abbreviation, element segments may also be specified inline with :ref:`table <text-table>` definitions; see the respective section.


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

.. math::
   \begin{array}{llclll}
   \production{data segment} & \Tdata_I &::=&
     \text{(}~\text{data}~~\Tid^?~~b^\ast{:}\Tdatastring~\text{)} \\ &&& \qquad
       \Rightarrow\quad \{ \DINIT~b^\ast, \DMODE~\DPASSIVE \} \\ &&|&
     \text{(}~\text{data}~~\Tid^?~~x{:}\Tmemuse_I~~\text{(}~\text{offset}~~e{:}\Texpr_I~\text{)}~~b^\ast{:}\Tdatastring~\text{)} \\ &&& \qquad
       \Rightarrow\quad \{ \DINIT~b^\ast, \DMODE~\DACTIVE~\{ \DMEM~x', \DOFFSET~e \} \} \\
   \production{data string} & \Tdatastring &::=&
     (b^\ast{:}\Tstring)^\ast \quad\Rightarrow\quad \concat((b^\ast)^\ast) \\
   \production{memory use} & \Tmemuse_I &::=&
     \text{(}~\text{memory}~~x{:}\Tmemidx_I ~\text{)}
       \quad\Rightarrow\quad x \\
   \end{array}

.. note::
   In the current version of WebAssembly, the only valid memory index is 0
   or a symbolic :ref:`memory identifier <text-id>` resolving to the same value.


Abbreviations
.............

As an abbreviation, a single instruction may occur in place of the offset of an active data segment:

.. math::
   \begin{array}{llcll}
   \production{data offset} &
     \text{(}~\Tinstr~\text{)} &\equiv&
     \text{(}~\text{offset}~~\Tinstr~\text{)}
   \end{array}

Also, a memory use can be omitted, defaulting to :math:`\T{0}`.

.. math::
   \begin{array}{llclll}
   \production{memory use} &
     \epsilon &\equiv& \text{(}~\text{memory}~~\text{0}~\text{)} \\
   \end{array}

As another abbreviation, data segments may also be specified inline with :ref:`memory <text-mem>` definitions; see the respective section.


.. index:: module, type definition, function type, function, table, memory, global, element, data, start function, import, export, identifier context, identifier, name section
   pair: text format; module
   single: section; name
.. _text-modulefield:
.. _text-module:

Modules
~~~~~~~

A module consists of a sequence of fields that can occur in any order.
All definitions and their respective bound :ref:`identifiers <text-id>` scope over the entire module, including the text preceding them.

A module may optionally bind an :ref:`identifier <text-id>` that names the module.
The name serves a documentary role only.

.. note::
   Tools may include the module name in the :ref:`name section <binary-namesec>` of the :ref:`binary format <binary>`.

.. math::
   \begin{array}{lll}
   \production{module} & \Tmodule &
   \begin{array}[t]{@{}cllll}
   ::=&
     \text{(}~\text{module}~~\Tid^?~~(m{:}\Tmodulefield_I)^\ast~\text{)}
       \quad\Rightarrow\quad \bigcompose m^\ast \\
       &\qquad (\iff I = \bigcompose \F{idc}(\Tmodulefield)^\ast \idcwellformed) \\
   \end{array} \\[1ex]
   \production{module field} & \Tmodulefield_I &
   \begin{array}[t]{@{}clll}
   ::=&
     \X{ty}^\ast{:}\Trectype_I &\Rightarrow& \{\MTYPES~\X{ty}^\ast\} \\ |&
     \X{im}{:}\Timport_I &\Rightarrow& \{\MIMPORTS~\X{im}\} \\ |&
     \X{fn}{:}\Tfunc_I &\Rightarrow& \{\MFUNCS~\X{fn}\} \\ |&
     \X{ta}{:}\Ttable_I &\Rightarrow& \{\MTABLES~\X{ta}\} \\ |&
     \X{me}{:}\Tmem_I &\Rightarrow& \{\MMEMS~\X{me}\} \\ |&
     \X{gl}{:}\Tglobal_I &\Rightarrow& \{\MGLOBALS~\X{gl}\} \\ |&
     \X{ex}{:}\Texport_I &\Rightarrow& \{\MEXPORTS~\X{ex}\} \\ |&
     \X{st}{:}\Tstart_I &\Rightarrow& \{\MSTART~\X{st}\} \\ |&
     \X{el}{:}\Telem_I &\Rightarrow& \{\MELEMS~\X{el}\} \\ |&
     \X{da}{:}\Tdata_I &\Rightarrow& \{\MDATAS~\X{da}\} \\
   \end{array}
   \end{array}

The following restrictions are imposed on the composition of :ref:`modules <syntax-module>`: :math:`m_1 \compose m_2` is defined if and only if

* :math:`m_1.\MSTART = \epsilon \vee m_2.\MSTART = \epsilon`

* :math:`m_1.\MFUNCS = m_1.\MTABLES = m_1.\MMEMS = m_1.\MGLOBALS = \epsilon \vee m_2.\MIMPORTS = \epsilon`

.. note::
   The first condition ensures that there is at most one start function.
   The second condition enforces that all :ref:`imports <text-import>` must occur before any regular definition of a :ref:`function <text-func>`, :ref:`table <text-table>`, :ref:`memory <text-mem>`, or :ref:`global <text-global>`,
   thereby maintaining the ordering of the respective :ref:`index spaces <syntax-index>`.

   The :ref:`well-formedness <text-context-wf>` condition on :math:`I` in the grammar for |Tmodule| ensures that no namespace contains duplicate identifiers.

The definition of the initial :ref:`identifier context <text-context>` :math:`I` uses the following auxiliary definition which maps each relevant definition to a singular context with one (possibly empty) identifier:

.. math::
   \begin{array}{@{}lcl@{\qquad\qquad}l}
   \F{idc}(\text{(}~\text{rec}~~\Ttypedef^\ast~\text{)}) &=&
     \bigcompose \F{idc}(\Ttypedef)^\ast \\
   \F{idc}(\text{(}~\text{type}~\Tid^?~\Tsubtype~\text{)}) &=&
     \{\ITYPES~(\Tid^?), \IFIELDS~\F{idf}(\Tsubtype), \ITYPEDEFS~\X{st}\} \\
   \F{idc}(\text{(}~\text{func}~\Tid^?~\dots~\text{)}) &=&
     \{\IFUNCS~(\Tid^?)\} \\
   \F{idc}(\text{(}~\text{table}~\Tid^?~\dots~\text{)}) &=&
     \{\ITABLES~(\Tid^?)\} \\
   \F{idc}(\text{(}~\text{memory}~\Tid^?~\dots~\text{)}) &=&
     \{\IMEMS~(\Tid^?)\} \\
   \F{idc}(\text{(}~\text{global}~\Tid^?~\dots~\text{)}) &=&
     \{\IGLOBALS~(\Tid^?)\} \\
   \F{idc}(\text{(}~\text{elem}~\Tid^?~\dots~\text{)}) &=&
     \{\IELEM~(\Tid^?)\} \\
   \F{idc}(\text{(}~\text{data}~\Tid^?~\dots~\text{)}) &=&
     \{\IDATA~(\Tid^?)\} \\
   \F{idc}(\text{(}~\text{import}~\dots~\text{(}~\text{func}~\Tid^?~\dots~\text{)}~\text{)}) &=&
     \{\IFUNCS~(\Tid^?)\} \\
   \F{idc}(\text{(}~\text{import}~\dots~\text{(}~\text{table}~\Tid^?~\dots~\text{)}~\text{)}) &=&
     \{\ITABLES~(\Tid^?)\} \\
   \F{idc}(\text{(}~\text{import}~\dots~\text{(}~\text{memory}~\Tid^?~\dots~\text{)}~\text{)}) &=&
     \{\IMEMS~(\Tid^?)\} \\
   \F{idc}(\text{(}~\text{import}~\dots~\text{(}~\text{global}~\Tid^?~\dots~\text{)}~\text{)}) &=&
     \{\IGLOBALS~(\Tid^?)\} \\
   \F{idc}(\text{(}~\dots~\text{)}) &=&
     \{\} \\[2ex]
   \F{idf}(\text{(}~\text{sub}~\dots~\Tcomptype~\text{)}) &=&
     \F{idf}(\Tcomptype) \\
   \F{idf}(\text{(}~\text{struct}~\X{Tfield}^\ast~\text{)}) &=&
     \bigcompose \F{idf}(\Tfield)^\ast \\
   \F{idf}(\text{(}~\text{array}~\dots~\text{)}) &=&
     \epsilon \\
   \F{idf}(\text{(}~\text{func}~\dots~\text{)}) &=&
     \epsilon \\
   \F{idf}(\text{(}~\text{field}~\Tid^?~\dots~\text{)}) &=&
     \Tid^? \\
   \end{array}


Abbreviations
.............

In a source file, the toplevel :math:`\T{(module}~\dots\T{)}` surrounding the module body may be omitted.

.. math::
   \begin{array}{llcll}
   \production{module} &
     \Tmodulefield^\ast &\equiv&
     \text{(}~\text{module}~~\Tmodulefield^\ast~\text{)}
   \end{array}

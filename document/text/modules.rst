Modules
-------


.. _text-type:
.. index:: type definition, identifier
   pair: text format; type definition

Types
~~~~~

Type definitions can bind a symbolic :ref:`type identifier <text-id>`.

.. math::
   \begin{array}{llclll}
   \production{type definition} & \Ttype &::=&
     \text{(}~\text{type}~~\Tid^?~~\X{ft}{:}\Tfunctype~\text{)}
       &\Rightarrow& \X{ft} \\
   \end{array}


.. _text-typeuse:
.. index:: type use
   pair: text format; type use

Type Uses
~~~~~~~~~

A *type use* is a reference to a :ref:`type definition <text-type>`.
It may optionally be augmented by explicit inlined :ref:`parameter <text-param>` and :ref:`result <text-result>` declarations.
That allows binding symbolic :ref:`identifiers <text-id>` to name the :ref:`local indices <text-localidx>` of parameters.
If inline declarations are given, then their types must match the referenced :ref:`function type <text-type>`.

.. math::
   \begin{array}{llcllll}
   \production{type use} & \Ttypeuse_I &::=&
     \text{(}~\text{type}~~x{:}\Ttypeidx_I~\text{)}
       &\Rightarrow& x, I' &
       (\begin{array}[t]{@{}l@{}}
        I.\TYPEDEFS[x] = [t_1^n] \to [t_2^\ast] \wedge
        I' = \{\LOCALS~(\epsilon)^n\}) \\
        \end{array} \\ &&|&
     \text{(}~\text{type}~~x{:}\Ttypeidx_I~\text{)}
     ~~(t_1{:}\Tparam)^\ast~~(t_2{:}\Tresult)^\ast
       &\Rightarrow& x, I' &
       (\begin{array}[t]{@{}l@{}}
        I.\TYPEDEFS[x] = [t_1^\ast] \to [t_2^\ast] \wedge
        I' = \{\LOCALS~\F{id}(\Tparam)\}^\ast \idcwellformed) \\
        \end{array} \\
   \end{array}

The resulting attribute of a |Ttypeuse| is a pair consisting of both the used :ref:`type index <syntax-typeidx>` and the updated :ref:`identifier context <text-context>` including possible parameter identifiers.
The following auxiliary notation extracts optional identifiers from parameters:

.. math::
   \begin{array}{lcl@{\qquad\qquad}l}
   \F{id}(\text{(}~\text{param}~\Tid^?~\dots~\text{)}) &=& \Tid^? \\
   \end{array}

.. note::
   Both productions overlap for the case that the function type is :math:`[] \to []`.
   However, in that case, they also produce the same results, so that the choice is immaterial.

   The :ref:`well-formedness <text-context-wf>` condition on :math:`I'` ensures that the parameters do not contain duplicate identifier.


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

where :math:`x` is the smallest existing :ref:`type index <syntax-typeidx>` whose definition in the current module is the :ref:`function type <syntax-functype>` :math:`[t_1^\ast] \to [t_2^\ast]`.
If no such index exists, then a new :ref:`type definition <text-type>` of the form

.. math::
   \text{(}~\text{type}~~\text{(}~\text{func}~~\Tparam^\ast~~\Tresult~\text{)}~\text{)}

is first inserted at the end of the module.

.. note::
   Abbreviations are expanded in the order they appear, such that previously inserted type definitions are reused by consecutive expansions.


.. _text-import:
.. index:: import, name, function type, table type, memory type, global type
   pair: text format; import

Imports
~~~~~~~

The descriptors in imports can bind a symbolic function, table, memory, or global :ref:`identifier <text-id>`.

.. math::
   \begin{array}{llclll}
   \production{import} & \Timport_I &::=&
     \text{(}~\text{import}~~\X{mod}{:}\Tname~~\X{nm}{:}\Tname~~d{:}\Timportdesc_I~\text{)}
       &\Rightarrow& \{ \MODULE~\X{mod}, \NAME~\X{nm}, \DESC~d \} \\
   \production{import description} & \Timportdesc_I &::=&
     \text{(}~\text{func}~~\Tid^?~~x,I'{:}\Ttypeuse_I~\text{)}
       &\Rightarrow& \FUNC~x \\ &&|&
     \text{(}~\text{table}~~\Tid^?~~\X{tt}{:}\Ttabletype~\text{)}
       &\Rightarrow& \TABLE~\X{tt} \\ &&|&
     \text{(}~\text{memory}~~\Tid^?~~\X{mt}{:}\Tmemtype~\text{)}
       &\Rightarrow& \MEM~~\X{mt} \\ &&|&
     \text{(}~\text{global}~~\Tid^?~~\X{gt}{:}\Tglobaltype~\text{)}
       &\Rightarrow& \GLOBAL~\X{gt} \\
   \end{array}


Abbreviations
.............

As an abbreviation, imports may also be specified inline with :ref:`function <text-func>`, :ref:`table <text-table>`, :ref:`memory <text-mem>`, or :ref:`global <text-global>` definitions; see the respective sections.



.. _text-func:
.. _text-local:
.. index:: function, type index, function type, identifier, local
   pair: text format; function
   pair: text format; local

Functions
~~~~~~~~~

Function definitions can bind a symbolic :ref:`function identifier <text-id>`, and :ref:`local identifiers <text-id>` for its :ref:`parameters <text-typeuse>` and locals.

.. math::
   \begin{array}{llclll}
   \production{function} & \Tfunc_I &::=&
     \text{(}~\text{func}~~\Tid^?~~x,I'{:}\Ttypeuse_I~~
     (t{:}\Tlocal)^\ast~~(\X{in}{:}\Tinstr_{I''})^\ast~\text{)}
       &\Rightarrow& \{ \TYPE~x, \LOCALS~t^\ast, \BODY~\X{in}^\ast~\END \} \\ &&&&& \qquad
       (I'' = I' \compose \{\LOCALS~\F{id}(\Tlocal)^\ast\} \idcwellformed) \\
   \production{local} & \Tlocal &::=&
     \text{(}~\text{local}~~\Tid^?~~t{:}\Tvaltype~\text{)}
       &\Rightarrow& t \\
   \end{array}

The definition of the local :ref:`identifier context <text-context>` :math:`I''` uses the following auxiliary notation to extract optional identifiers from locals:

.. math::
   \begin{array}{lcl@{\qquad\qquad}l}
   \F{id}(\text{(}~\text{local}~\Tid^?~\dots~\text{)}) &=& \Tid^? \\
   \end{array}


.. note::
   The :ref:`well-formedness <text-context-wf>` condition on :math:`I''` ensures that parameters and locals do not contain duplicate identifiers.


.. _text-func-abbrev:
.. index:: import, name
   pair: text format; import
.. index:: export, name, index, function index
   pair: text format; export

Abbreviations
.............

Multiple anonymous locals may be combined into a single declaration:

.. math::
   \begin{array}{llclll}
   \production{local} &
     \text{(}~~\text{local}~~\Tvaltype^\ast~~\text{)} &\equiv&
     (\text{(}~~\text{local}~~\Tvaltype~~\text{)})^\ast \\
   \end{array}

Moreover, functions can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{func}~~\Tid^?~~\text{(}~\text{import}~~\Tname_1~~\Tname_2~\text{)}~~\Ttypeuse~\text{)} &\equiv&
       \text{(}~\text{import}~~\Tname_1~~\Tname_2~~\text{(}~\text{func}~~\Tid^?~~\Ttypeuse~\text{)}~\text{)} \\ &
     \text{(}~\text{func}~~\Tid^?~~\text{(}~\text{export}~~\Tname~\text{)}~~\dots~\text{)} &\equiv&
       \text{(}~\text{export}~~\Tname~~\text{(}~\text{func}~~\Tid'~\text{)}~\text{)}~~
       \text{(}~\text{func}~~\Tid'~~\dots~\text{)}
       \\&&& \qquad
       (\Tid' = \Tid^? \neq \epsilon \vee \Tid' \idfresh) \\
   \end{array}

The latter abbreviation can be applied repeatedly, with ":math:`\dots`" containing another import or export.


.. _text-table:
.. index:: table, table type, identifier
   pair: text format; table

Tables
~~~~~~

Table definitions can bind a symbolic :ref:`table identifier <text-id>`.

.. math::
   \begin{array}{llclll}
   \production{table} & \Ttable_I &::=&
     \text{(}~\text{table}~~\Tid^?~~\X{tt}{:}\Ttabletype~\text{)}
       &\Rightarrow& \{ \TYPE~\X{tt} \} \\
   \end{array}


.. _text-table-abbrev:
.. index:: import, name
   pair: text format; import
.. index:: export, name, index, table index
   pair: text format; export
.. index:: element, table index, function index
   pair: text format; element
   single: table; element
   single: element; segment

Abbreviations
.............

An :ref:`element segment <text-elem>` can be given inline with a table definition, in which case the :ref:`limits <text-limits>` of the :ref:`table type <text-tabletype>` are inferred from the length of the given segment:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{table}~~\Tid^?~~\Telemtype~~\text{(}~\text{elem}~~x^n{:}\Tvec(\Tfuncidx)~\text{)}~~\text{)} &\equiv&
       \text{(}~\text{table}~~\Tid'~~n~~n~~\Telemtype~\text{)}~~
       \text{(}~\text{elem}~~\Tid'~~\text{(}~\text{i32.const}~~\text{0}~\text{)}~~\Tvec(\Tfuncidx)~\text{)}
       \\&&& \qquad
       (\Tid' = \Tid^? \neq \epsilon \vee \Tid' \idfresh) \\
   \end{array}

Moreover, tables can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{table}~~\Tid^?~~\text{(}~\text{import}~~\Tname_1~~\Tname_2~\text{)}~~\Ttabletype~\text{)} &\equiv&
       \text{(}~\text{import}~~\Tname_1~~\Tname_2~~\text{(}~\text{table}~~\Tid^?~~\Ttabletype~\text{)}~\text{)} \\ &
     \text{(}~\text{table}~~\Tid^?~~\text{(}~\text{export}~~\Tname~\text{)}~~\dots~\text{)} &\equiv&
       \text{(}~\text{export}~~\Tname~~\text{(}~\text{table}~~\Tid'~\text{)}~\text{)}~~
       \text{(}~\text{table}~~\Tid'~~\dots~\text{)}
       \\&&& \qquad
       (\Tid' = \Tid^? \neq \epsilon \vee \Tid' \idfresh) \\
   \end{array}

The latter abbreviation can be applied repeatedly, with ":math:`\dots`" containing another import or export or an inline elements segment.


.. _text-mem:
.. index:: memory, memory type, identifier
   pair: text format; memory

Memories
~~~~~~~~

Memory definitions can bind a symbolic :ref:`memory identifier <text-id>`.

.. math::
   \begin{array}{llclll}
   \production{memory} & \Tmem_I &::=&
     \text{(}~\text{memory}~~\Tid^?~~\X{mt}{:}\Tmemtype~\text{)}
       &\Rightarrow& \{ \TYPE~\X{mt} \} \\
   \end{array}


.. _text-mem-abbrev:
.. index:: import, name
   pair: text format; import
.. index:: export, name, index, memory index
   pair: text format; export
.. index:: data, memory, memory index, expression, byte, page size
   pair: text format; data
   single: memory; data
   single: data; segment

Abbreviations
.............

A :ref:`data segment <text-data>` can be given inline with a memory definition, in which case the :ref:`limits <text-limits>` of the :ref:`memory type <text-memtype>` are inferred from the length of the data, rounded up to :ref:`page size <page-size>`:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{memory}~~\Tid^?~~\text{(}~\text{data}~~b^n{:}\Tdatastring~\text{)}~~\text{)} &\equiv&
       \text{(}~\text{memory}~~\Tid'~~m~~m~\text{)}~~
       \text{(}~\text{data}~~\Tid'~~\text{(}~\text{i32.const}~~\text{0}~\text{)}~~\Tdatastring~\text{)}
       \\&&& \qquad
       (\Tid' = \Tid^? \neq \epsilon \vee \Tid' \idfresh, m = \F{ceil}(n / 64\F{Ki})) \\
   \end{array}

Moreover, memories can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{memory}~~\Tid^?~~\text{(}~\text{import}~~\Tname_1~~\Tname_2~\text{)}~~\Tmemtype~\text{)} &\equiv&
       \text{(}~\text{import}~~\Tname_1~~\Tname_2~~\text{(}~\text{memory}~~\Tid^?~~\Tmemtype~\text{)}~\text{)}
       \\ &
     \text{(}~\text{memory}~~\Tid^?~~\text{(}~\text{export}~~\Tname~\text{)}~~\dots~\text{)} &\equiv&
       \text{(}~\text{export}~~\Tname~~\text{(}~\text{memory}~~\Tid'~\text{)}~\text{)}~~
       \text{(}~\text{memory}~~\Tid'~~\dots~\text{)}
       \\ &&& \qquad
       (\Tid' = \Tid^? \neq \epsilon \vee \Tid' \idfresh) \\
   \end{array}

The latter abbreviation can be applied repeatedly, with ":math:`\dots`" containing another import or export or an inline data segment.


.. _text-global:
.. index:: global, global type, identifier, expression
   pair: text format; global

Globals
~~~~~~~

Global definitions can bind a symbolic :ref:`global identifier <text-id>`.

.. math::
   \begin{array}{llclll}
   \production{global} & \Tglobal_I &::=&
     \text{(}~\text{global}~~\Tid^?~~\X{gt}{:}\Tglobaltype~~e{:}\Texpr_I~\text{)}
       &\Rightarrow& \{ \TYPE~\X{gt}, \INIT~e \} \\
   \end{array}


.. _text-global-abbrev:
.. index:: import, name
   pair: text format; import
.. index:: export, name, index, global index
   pair: text format; export

Abbreviations
.............

Globals can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{global}~~\Tid^?~~\text{(}~\text{import}~~\Tname_1~~\Tname_2~\text{)}~~\Tglobaltype~\text{)} &\equiv&
       \text{(}~\text{import}~~\Tname_1~~\Tname_2~~\text{(}~\text{global}~~\Tid^?~~\Tglobaltype~\text{)}~\text{)}
       \\ &
     \text{(}~\text{global}~~\Tid^?~~\text{(}~\text{export}~~\Tname~\text{)}~~\dots~\text{)} &\equiv&
       \text{(}~\text{export}~~\Tname~~\text{(}~\text{global}~~\Tid'~\text{)}~\text{)}~~
       \text{(}~\text{global}~~\Tid'~~\dots~\text{)}
       \\ &&& \qquad
       (\Tid' = \Tid^? \neq \epsilon \vee \Tid' \idfresh) \\
   \end{array}

The latter abbreviation can be applied repeatedly, with ":math:`\dots`" containing another import or export.


.. _text-export:
.. index:: export, name, index, function index, table index, memory index, global index
   pair: text format; export

Exports
~~~~~~~

The syntax for exports mirrors their :ref:`abstract syntax <syntax-export>` directly.

.. math::
   \begin{array}{llclll}
   \production{export} & \Texport_I &::=&
     \text{(}~\text{export}~~\X{nm}{:}\Tname~~d{:}\Texportdesc_I~\text{)}
       &\Rightarrow& \{ \NAME~\X{nm}, \DESC~d \} \\
   \production{export description} & \Texportdesc_I &::=&
     \text{(}~\text{func}~~x{:}\Bfuncidx_I~\text{)}
       &\Rightarrow& \FUNC~x \\ &&|&
     \text{(}~\text{table}~~x{:}\Btableidx_I~\text{)}
       &\Rightarrow& \TABLE~x \\ &&|&
     \text{(}~\text{memory}~~x{:}\Bmemidx_I~\text{)}
       &\Rightarrow& \MEM~x \\ &&|&
     \text{(}~\text{global}~~x{:}\Bglobalidx_I~\text{)}
       &\Rightarrow& \GLOBAL~x \\
   \end{array}


Abbreviations
.............

As an abbreviation, exports may also be specified inline with :ref:`function <text-func>`, :ref:`table <text-table>`, :ref:`memory <text-mem>`, or :ref:`global <text-global>` definitions; see the respective sections.


.. _text-start:
.. index:: start function, function index
   pair: text format; start function

Start Function
~~~~~~~~~~~~~~

A :ref:`start function <syntax-start>` is defined in terms of its index.

.. math::
   \begin{array}{llclll}
   \production{start function} & \Tstart_I &::=&
     \text{(}~\text{start}~~x{:}\Tfuncidx_I~\text{)}
       &\Rightarrow& \{ \FUNC~x \} \\
   \end{array}

.. note::
   At most one start function may occur in a module,
   which is ensured by a suitable side condition on the |Tmodule| grammar.



.. _text-elem:
.. index:: element, table index, expression, function index
   pair: text format; element
   single: table; element
   single: element; segment

Element Segments
~~~~~~~~~~~~~~~~

Element segments allow for an optional :ref:`table index <text-tableidx>` to identify the table to initialize.
When omitted, :math:`\T{0}` is assumed.

.. math::
   \begin{array}{llclll}
   \production{element segment} & \Telem_I &::=&
     \text{(}~\text{elem}~~(x{:}\Ttableidx_I)^?~~\text{(}~\text{offset}~~e{:}\Texpr_I~\text{)}~~y^\ast{:}\Tvec(\Tfuncidx_I)~\text{)}
       &\Rightarrow& \{ \TABLE~x', \OFFSET~e, \INIT~y^\ast \} \\
       &&&&& \qquad (x' = x^? \neq \epsilon \vee x' = 0) \\
   \end{array}

.. note::
   In the current version of WebAssembly, the only valid table index is 0
   or a symbolic :ref:`table identifier <text-id>` resolving to the same value.


Abbreviations
.............

As an abbreviation, element segments may also be specified inline with :ref:`table <text-table>` definitions; see the respective section.


.. _text-data:
.. _text-datastring:
.. index:: data, memory, memory index, expression, byte
   pair: text format; data
   single: memory; data
   single: data; segment

Data Segments
~~~~~~~~~~~~~

Data segments allow for an optional :ref:`memory index <text-memidx>` to identify the memory to initialize.
When omitted, :math:`\T{0}` is assumed.
The data is written as a :ref:`string <text-string>`, which may be split up into a possibly empty sequence of individual string literals.

.. math::
   \begin{array}{llclll}
   \production{data segment} & \Tdata_I &::=&
     \text{(}~\text{data}~~(x{:}\Tmemidx_I)^?~~\text{(}~\text{offset}~~e{:}\Texpr_I~\text{)}~~b^\ast{:}\Tdatastring~\text{)}
       &\Rightarrow& \{ \MEM~x', \OFFSET~e, \INIT~b^\ast \} \\
       &&&&& \qquad (x' = x^? \neq \epsilon \vee x' = 0) \\
   \production{data string} & \Tdatastring &::=&
     (b^\ast{:}\Tstring)^\ast &\Rightarrow& \concat((b^\ast)^\ast) \\
   \end{array}

.. note::
   In the current version of WebAssembly, the only valid memory index is 0
   or a symbolic :ref:`memory identifier <text-id>` resolving to the same value.


Abbreviations
.............

As an abbreviation, data segments may also be specified inline with :ref:`memory <text-mem>` definitions; see the respective section.


.. _text-module:
.. _text-modulebody:
.. _text-modulefield:
.. index:: module, type definition, function type, function, table, memory, global, element, data, start function, import, export, identifier context, identifier, name section
   pair: text format; module
   single: section; name

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
       &\Rightarrow& \bigcompose m^\ast
       & (I = \bigcompose \F{idc}(\Tmodulefield)^\ast \idcwellformed) \\
   \end{array} \\
   \production{module field} & \Tmodulefield_I &
   \begin{array}[t]{@{}clll}
   ::=&
     \X{ty}{:}\Ttype &\Rightarrow& \{\TYPES~\X{ty}\} \\ |&
     \X{im}{:}\Timport_I &\Rightarrow& \{\IMPORTS~\X{im}\} \\ |&
     \X{fn}{:}\Tfunc_I &\Rightarrow& \{\FUNCS~\X{fn}\} \\ |&
     \X{ta}{:}\Ttable_I &\Rightarrow& \{\TABLES~\X{ta}\} \\ |&
     \X{me}{:}\Tmem_I &\Rightarrow& \{\MEMS~\X{me}\} \\ |&
     \X{gl}{:}\Tglobal_I &\Rightarrow& \{\GLOBALS~\X{gl}\} \\ |&
     \X{ex}{:}\Texport_I &\Rightarrow& \{\EXPORTS~\X{ex}\} \\ |&
     \X{st}{:}\Tstart_I &\Rightarrow& \{\START~\X{st}\} \\ |&
     \X{el}{:}\Telem_I &\Rightarrow& \{\ELEM~\X{el}\} \\ |&
     \X{da}{:}\Tdata_I &\Rightarrow& \{\DATA~\X{da}\} \\
   \end{array}
   \end{array}

The following restrictions are imposed on the composition of :ref:`modules <syntax-module>`: :math:`m_1 \compose m_2` is defined if and only if

* :math:`m_1.\START = \epsilon \vee m_2.\START = \epsilon`

* :math:`m_2.\IMPORTS = \epsilon \vee m_1.\FUNCS = m_1.\TABLES = m_1.\MEMS = m_1.\GLOBALS = \epsilon`

.. note::
   The first condition ensures that there is at most one start function.
   The second condition enforces that all :ref:`imports <text-import>` must occur before any regular definition of a :ref:`function <text-func>`, :ref:`table <text-table>`, :ref:`memory <text-mem>`, or :ref:`global <text-global>`,
   thereby maintaining the ordering of the respective :ref:`index spaces <syntax-index>`.

   The :ref:`well-formedness <text-context-wf>` condition on :math:`I` in the grammar for |Tmodule| ensures that no namespace contains duplicate identifiers.

The definition of the initial :ref:`identifier context <text-context>` :math:`I` uses the following auxiliary definition which maps each relevant definition to a singular context with one (possibly empty) identifier:

.. math::
   \begin{array}{@{}lcl@{\qquad\qquad}l}
   \F{idc}(\text{(}~\text{type}~\Tid^?~\X{ft}{:}\Tfunctype~\text{)}) &=&
     \{\TYPES~(\Tid^?), \TYPEDEFS~\X{ft}\} \\
   \F{idc}(\text{(}~\text{func}~\Tid^?~\dots~\text{)}) &=&
     \{\FUNCS~(\Tid^?)\} \\
   \F{idc}(\text{(}~\text{table}~\Tid^?~\dots~\text{)}) &=&
     \{\TABLES~(\Tid^?)\} \\
   \F{idc}(\text{(}~\text{memory}~\Tid^?~\dots~\text{)}) &=&
     \{\MEMS~(\Tid^?)\} \\
   \F{idc}(\text{(}~\text{global}~\Tid^?~\dots~\text{)}) &=&
     \{\GLOBALS~(\Tid^?)\} \\
   \F{idc}(\text{(}~\text{import}~\dots~\text{(}~\text{func}~\Tid^?~\dots~\text{)}~\text{)}) &=&
     \{\FUNCS~(\Tid^?)\} \\
   \F{idc}(\text{(}~\text{import}~\dots~\text{(}~\text{table}~\Tid^?~\dots~\text{)}~\text{)}) &=&
     \{\TABLES~(\Tid^?)\} \\
   \F{idc}(\text{(}~\text{import}~\dots~\text{(}~\text{memory}~\Tid^?~\dots~\text{)}~\text{)}) &=&
     \{\MEMS~(\Tid^?)\} \\
   \F{idc}(\text{(}~\text{import}~\dots~\text{(}~\text{global}~\Tid^?~\dots~\text{)}~\text{)}) &=&
     \{\GLOBALS~(\Tid^?)\} \\
   \F{idc}(\text{(}~\dots~\text{)}) &=&
     \{\} \\
   \end{array}


.. math
   \F{idc}(\epsilon) &=&
     \{\} \\
   \F{idc}(\Tmodulebody~\Tmodulefield) &=&
     \F{idc}(\Tmodulebody) \compose \F{idc}(\Tmodulefield) \\[1ex]

   The definition of the :ref:`identifier context <text-context>` :math:`I` uses the following auxiliary notation to filters out optional identifiers from definitions and imports in an order-preserving fashion:

   \begin{array}{@{}l@{}}
   \begin{array}{@{}lcl@{\qquad\qquad}l}
   \F{id}(\text{(}~\text{type}~\Tid^?~\dots~\text{)}) &=& \Tid^? \\
   \F{id}(\text{(}~\text{func}~\Tid^?~\dots~\text{)}) &=& \Tid^? \\
   \F{id}(\text{(}~\text{table}~\Tid^?~\dots~\text{)}) &=& \Tid^? \\
   \F{id}(\text{(}~\text{memory}~\Tid^?~\dots~\text{)}) &=& \Tid^? \\
   \F{id}(\text{(}~\text{global}~\Tid^?~\dots~\text{)}) &=& \Tid^? \\[1ex]
   \F{funcids}(\Timport^\ast) &=& [\Tid^? ~|~ \text{(}~\text{func}~\Tid^?~\dots~\text{)} \in \F{desc}(\Timport)^\ast] \\
   \F{tableids}(\Timport^\ast) &=& [\Tid^? ~|~ \text{(}~\text{table}~\Tid^?~\dots~\text{)} \in \F{desc}(\Timport)^\ast] \\
   \F{memids}(\Timport^\ast) &=& [\Tid^? ~|~ \text{(}~\text{memory}~\Tid^?~\dots~\text{)} \in \F{desc}(\Timport)^\ast] \\
   \F{globalids}(\Timport^\ast) &=& [\Tid^? ~|~ \text{(}~\text{global}~\Tid^?~\dots~\text{)} \in \F{desc}(\Timport)^\ast] \\
   \end{array} \\
   \F{desc}(\text{(}~\text{import}~\dots~\Timportdesc~\text{)}) \quad=\quad \Timportdesc
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

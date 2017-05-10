Modules
-------


.. _text-index:
.. _text-typeidx:
.. _text-funcidx:
.. _text-tableidx:
.. _text-memidx:
.. _text-globalidx:
.. _text-localidx:
.. _text-labelidx:
.. _text-label:
.. index:: index, type index, function index, table index, memory index, global index, local index, label index
   pair: text format; type index
   pair: text format; function index
   pair: text format; table index
   pair: text format; memory index
   pair: text format; global index
   pair: text format; local index
   pair: text format; label index

Indices
~~~~~~~

All :ref:`indices <syntax-index>` can be given either in raw numeric form or as symbolic :ref:`identifiers <text-id>` when bound by a respective construct.
Identifiers are looked up in the suitable space of the :ref:`identifier context <text-context>`.

.. math::
   \begin{array}{llclllllll}
   \production{type index} & \Ttypeidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x &|&
     v{:}\Tid &\Rightarrow& x & (I.\TYPES[x] = v) \\
   \production{function index} & \Tfuncidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x &|&
     v{:}\Tid &\Rightarrow& x & (I.\FUNCS[x] = v) \\
   \production{table index} & \Ttableidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x &|&
     v{:}\Tid &\Rightarrow& x & (I.\TABLES[x] = v) \\
   \production{memory index} & \Tmemidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x &|&
     v{:}\Tid &\Rightarrow& x & (I.\MEMS[x] = v) \\
   \production{global index} & \Tglobalidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x &|&
     v{:}\Tid &\Rightarrow& x & (I.\GLOBALS[x] = v) \\
   \production{local index} & \Tlocalidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x &|&
     v{:}\Tid &\Rightarrow& x & (I.\LOCALS[x] = v) \\
   \production{label index} & \Tlabelidx_I &::=&
     l{:}\Tu32 &\Rightarrow& l &|&
     v{:}\Tid &\Rightarrow& l & (I.\LABELS[l] = v) \\
   \end{array}


.. _text-type:
.. index:: type definition
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
It may optionally be augmented by inline function :ref:`parameters <text-param>` and :ref:`result <text-result>` annotations.
That allows declaring symbolic :ref:`identifiers <text-id>` for the :ref:`local indices <text-localidx>` of parameters.
If any inline annotation is given, then it must be complete and match the referenced type.

.. math::
   \begin{array}{llclll}
   \production{type use} & \Ttypeuse_I &::=&
     \text{(}~\text{type}~~x{:}\Ttypeidx_I~\text{)}
       \quad\Rightarrow\quad x, I' \\ &&& \qquad
       (\begin{array}[t]{@{}l@{}}
        I.\TYPEDEFS[x] = [t_1^n] \to [t_2^\ast] \wedge
        I' = \{\LOCALS~(\epsilon)^n\}) \\
        \end{array} \\ &&|&
     \text{(}~\text{type}~~x{:}\Ttypeidx_I~\text{)}
     ~~(t_1{:}\Tparam)^\ast~~(t_2{:}\Tresult)^\ast
       \quad\Rightarrow\quad x, I' \\ &&&\qquad
       (\begin{array}[t]{@{}l@{}}
        I.\TYPEDEFS[x] = [t_1^\ast] \to [t_2^\ast] \wedge
        I' = \{\LOCALS~\F{id}(\Tparam)\}^\ast \idcwellformed) \\
        \end{array} \\
   \end{array}

The resulting attribute of a |Ttypeuse| is a pair consisting of both the referenced :ref:`type index <syntax-typeidx>` and the updated :ref:`identifier context <text-context>` including the parameter identifiers.
The following auxiliary notation filters out optional identifiers from parameters:

.. math::
   \begin{array}{lcl@{\qquad\qquad}l}
   \F{id}(\text{(}~\text{param}~\Tid^?~\dots~\text{)}) &=& \Tid^? \\
   \end{array}

.. note::
   Both productions overlap for the case that the function type is :math:`[] \to []`.
   However, in that case, they also produce the same results, so that the choice is immaterial.

   The :ref:`well-formedness <text-context-wf>` condition on :math:`I'` ensures that the parameters do not contain duplicate identifier.


Abbreviations
.............

A |Ttypeuse| may also be replaced entirely by inline function :ref:`parameters <text-param>` and :ref:`result <text-result>` annotations.
In that case, the :ref:`type index <syntax-typeidx>` of the first matching :ref:`type definition <text-type>` is automatically inserted.
If no matching definition exists

.. todo:: fix

.. math::
   \begin{array}{llclll}
   \production{type use} &
     \text{(}~\text{func}~~\Tid^?~~\Ttypeuse~~\Tparam^\ast~~\Tresult_I~~\dots~\text{)} &\equiv&
     \text{(}~\text{func}~~\Tid^?~~\Ttypeuse~~\Tparam^\ast~~\Tresult_I~~\dots~\text{)} \\ &
     \text{(}~\text{func}~~\Tid^?~~\Ttypeuse~~\Tparam^\ast~~\Tresult_I~~\dots~\text{)} &\equiv&
   \end{array}


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


.. _text-func:
.. index:: function, type index, function type
   pair: text format; function

Functions
~~~~~~~~~

.. todo:: inline type

Function definitions can bind a symbolic :ref:`function identifier <text-id>`.

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

The definition of the local :ref:`identifier context <text-context>` :math:`I''` uses the following auxiliary notation to filter out optional identifiers from locals:

.. math::
   \begin{array}{lcl@{\qquad\qquad}l}
   \F{id}(\text{(}~\text{local}~\Tid^?~\dots~\text{)}) &=& \Tid^? \\
   \end{array}


.. note::
   The :ref:`well-formedness <text-context-wf>` condition on :math:`I'` ensures that parameters and locals do not contain duplicate identifier.


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
     \text{(}~\text{func}~~\Tid^?~~\text{(}~\text{import}~~\Tname_1~~\Tname_2~\text{)}~~\Ttypeuse~\text{)} &\equiv&
       \text{(}~\text{import}~~\Tname_1~~\Tname_2~~\text{(}~\text{func}~~\Tid^?~~\Ttypeuse~\text{)}~\text{)} \\ &
     \text{(}~\text{func}~~\Tid^?~~\text{(}~\text{export}~~\Tname~\text{)}~~\Ttypeuse~~\dots~\text{)} &\equiv&
       \text{(}~\text{export}~~\Tname~~\text{(}~\text{func}~~\Tid'~\text{)}~\text{)}~~
       \text{(}~\text{func}~~\Tid'~~\Ttypeuse~~\dots~\text{)}
       \\&&& \qquad
       (\Tid' = \Tid^? \neq \epsilon \vee \Tid'~\mbox{fresh}) \\
   \end{array}


.. _text-table:
.. index:: table, table type
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


Abbreviations
.............

Tables can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{table}~~\Tid^?~~\text{(}~\text{import}~~\Tname_1~~\Tname_2~\text{)}~~\Ttabletype~\text{)} &\equiv&
       \text{(}~\text{import}~~\Tname_1~~\Tname_2~~\text{(}~\text{table}~~\Tid^?~~\Ttabletype~\text{)}~\text{)} \\ &
     \text{(}~\text{table}~~\Tid^?~~\text{(}~\text{export}~~\Tname~\text{)}~~\Ttabletype~\text{)} &\equiv&
       \text{(}~\text{export}~~\Tname~~\text{(}~\text{table}~~\Tid'~\text{)}~\text{)}~~
       \text{(}~\text{table}~~\Tid'~~\Ttabletype~\text{)}
       \\&&& \qquad
       (\Tid' = \Tid^? \neq \epsilon \vee \Tid'~\mbox{fresh}) \\
   \end{array}

Moreover, :ref:`elements <text-elem>` can be given inline, in which case the limits of the table type are inferred from the length of the given element vector:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{table}~~\Tid^?~~\text{(}~\text{export}~~\Tname~\text{)}^?~~\Telemtype~~\text{(}~\text{elem}~~\Tvec(\Tfuncidx)~\text{)}~~\text{)} &\equiv&
       \text{(}~\text{table}~~\Tid'~~\text{(}~\text{export}~~\Tname~\text{)}^?~~n~~n~~\Telemtype~\text{)}~~
       \text{(}~\text{elem}~~\Tid'~~\text{(}~\text{i32.const}~~\text{0}~\text{)}~~\Tvec(\Tfuncidx)~\text{)}
       \\&&& \qquad
       (n = |\Tvec(\Tfuncidx)|, \Tid' = \Tid^? \neq \epsilon \vee \Tid'~\mbox{fresh}) \\
   \end{array}


.. _text-mem:
.. index:: memory, memory type
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


Abbreviations
.............

Memories can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{memory}~~\Tid^?~~\text{(}~\text{import}~~\Tname_1~~\Tname_2~\text{)}~~\Tmemtype~\text{)} &\equiv&
       \text{(}~\text{import}~~\Tname_1~~\Tname_2~~\text{(}~\text{memory}~~\Tid^?~~\Tmemtype~\text{)}~\text{)} \\ &
     \text{(}~\text{memory}~~\Tid^?~~\text{(}~\text{export}~~\Tname~\text{)}~~\Tmemtype~\text{)} &\equiv&
       \text{(}~\text{export}~~\Tname~~\text{(}~\text{memory}~~\Tid'~\text{)}~\text{)}~~
       \text{(}~\text{memory}~~\Tid'~~\Tmemtype~\text{)}
       \\&&& \qquad
       (\Tid' = \Tid^? \neq \epsilon \vee \Tid'~\mbox{fresh}) \\
   \end{array}

Moreover, :ref:`data <text-data>` can be given inline, in which case the limits of the table type are inferred from the length of the given string, rounded up to :ref:`page size <page-size>`:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{memory}~~\Tid^?~~\text{(}~\text{export}~~\Tname~\text{)}^?~~\text{(}~\text{data}~~\Tstring~\text{)}~~\text{)} &\equiv&
       \text{(}~\text{memory}~~\Tid'~~\text{(}~\text{export}~~\Tname~\text{)}^?~~n~~n~\text{)}~~
       \text{(}~\text{data}~~\Tid'~~\text{(}~\text{i32.const}~~\text{0}~\text{)}~~\Tstring~\text{)}
       \\&&& \qquad
       (n = |\Tstring|, \Tid' = \Tid^? \neq \epsilon \vee \Tid'~\mbox{fresh}) \\
   \end{array}

.. todo:: length of data


.. _text-global:
.. index:: global, global type, expression
   pair: text format; global

Globals
~~~~~~~

Global definitions can bind a symbolic :ref:`global identifier <text-id>`.

.. math::
   \begin{array}{llclll}
   \production{global} & \Tglobal_I &::=&
     \text{(}~\text{global}~~\Tid^?~~\X{gt}{:}\Tglobaltype~~(\X{in}{:}\Tinstr_I)^\ast~\text{)}
       &\Rightarrow& \{ \TYPE~\X{gt}, \INIT~\X{in}^\ast~\END \} \\
   \end{array}


Abbreviations
.............

Globals can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{global}~~\Tid^?~~\text{(}~\text{import}~~\Tname_1~~\Tname_2~\text{)}~~\Tglobaltype~\text{)} &\equiv&
       \text{(}~\text{import}~~\Tname_1~~\Tname_2~~\text{(}~\text{global}~~\Tid^?~~\Tglobaltype~\text{)}~\text{)} \\ &
     \text{(}~\text{global}~~\Tid^?~~\text{(}~\text{export}~~\Tname~\text{)}~~\Tglobaltype~\text{)} &\equiv&
       \text{(}~\text{export}~~\Tname~~\text{(}~\text{global}~~\Tid'~\text{)}~\text{)}~~
       \text{(}~\text{global}~~\Tid'~~\Tglobaltype~\text{)}
       \\&&& \qquad
       (\Tid' = \Tid^? \neq \epsilon \vee \Tid'~\mbox{fresh}) \\
   \end{array}


.. _text-export:
.. index:: export, name, index, function index, table index, memory index, global index
   pair: text format; export

Exports
~~~~~~~

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


.. _text-start:
.. index:: start function, function index
   pair: text format; start function

Start Function
~~~~~~~~~~~~~~

.. math::
   \begin{array}{llclll}
   \production{start function} & \Tstart_I &::=&
     \text{(}~\text{start}~~x{:}\Tfuncidx_I~\text{)}
       &\Rightarrow& \{ \FUNC~x \} \\
   \end{array}


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
     \text{(}~\text{elem}~~(x{:}\Ttableidx_I)^?~~\text{(}~\text{offset}~~(\X{in}{:}\Tinstr_I)^\ast~\text{)}~~y^\ast{:}\Tvec(\Tfuncidx_I)~\text{)}
       &\Rightarrow& \{ \TABLE~x', \OFFSET~\X{in}^\ast~\END, \INIT~y^\ast \} \\
       &&&&& \qquad (x' = x^? \neq \epsilon \vee x' = 0) \\
   \end{array}

.. note::
   In the current version of WebAssembly, the only valid table index is 0
   or a symbolic :ref:`table identifier <text-id>` resolving to the same value.


.. _text-data:
.. index:: data, memory, memory index, expression, byte
   pair: text format; data
   single: memory; data
   single: data; segment

Data Segments
~~~~~~~~~~~~~

Data segments allow for an optional :ref:`memory index <text-memidx>` to identify the memory to initialize.
When omitted, :math:`\T{0}` is assumed.

.. math::
   \begin{array}{llclll}
   \production{data segment} & \Tdata_I &::=&
     \text{(}~\text{data}~~(x{:}\Tmemidx_I)^?~~\text{(}~\text{offset}~~(\X{in}{:}\Tinstr_I)^\ast~\text{)}~~b^\ast{:}\Tstring~\text{)}
       &\Rightarrow& \{ \MEM~x', \OFFSET~\X{in}^\ast~\END, \INIT~b^\ast \} \\
       &&&&& \qquad (x' = x^? \neq \epsilon \vee x' = 0) \\
   \end{array}

.. note::
   In the current version of WebAssembly, the only valid memory index is 0
   or a symbolic :ref:`memory identifier <text-id>` resolving to the same value.


.. _text-module:
.. _text-modulebody:
.. _text-modulefield:
.. index:: module, type definition, function type, function, table, memory, global, element, data, start function, import, export, context, version
   pair: text format; module

Modules
~~~~~~~

.. math::
   \begin{array}{lll}
   \production{module} & \Tmodule &
   \begin{array}[t]{@{}clll}
   ::=&
     \text{(}~\text{module}~~(m{:}\Tmodulefield_I)^\ast~\text{)}
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

.. math (commented out)
   \production{module} & \Tmodule &::=&
     \text{(}~\text{module}~~m{:}\Tmodulebody_I~\text{)}
       &\Rightarrow& m
       \qquad (I = \F{idc}(\Tmodulebody)~\mbox{well-formed}) \\ &&|&
     m{:}\Tmodulebody_I \phantom{\text{(}~\text{module}~~~\text{)}}
       &\Rightarrow& m
       \qquad (I = \F{idc}(\Tmodulebody)~\mbox{well-formed}) \\
   \production{module body} & \Tmodulebody_I &::=&
     (m{:}\Tmodulefield_I)^\ast &\Rightarrow& \{\}~(\compose~m)^\ast \\

   \begin{array}{llcllll}
   \production{module} & \Tmodule &::=&
     \text{(}~\text{module}~~m{:}\Tmodulebody~\text{)}
       \quad\Rightarrow\quad m \\ &&|&
     m{:}\Tmodulebody \phantom{\text{(}~\text{module}~~~\text{)}}
       \quad\Rightarrow\quad m \\
   \production{module body} & \Tmodulebody &::=&
     (\functype{:}\Ttype)^\ast \\ &&&
     (\import{:}\Timport_I)^\ast \\ &&&
     (\func{:}\Tfunc_I)^\ast \\ &&&
     (\table{:}\Ttable_I)^\ast \\ &&&
     (\mem{:}\Tmem_I)^\ast \\ &&&
     (\global{:}\Tglobal_I)^\ast \\ &&&
     (\export{:}\Texport_I)^\ast \\ &&&
     (\start{:}\Tstart_I)^? \\ &&&
     (\elem{:}\Telem_I)^\ast \\ &&&
     (\data{:}\Tdata_I)^\ast
     \quad\Rightarrow\quad \\ &&&\qquad \{~
       \begin{array}[t]{@{}l@{}}
       \TYPES~\functype^\ast, \\
       \FUNCS~\func^\ast, \\
       \TABLES~\table^\ast, \\
       \MEMS~\mem^\ast, \\
       \GLOBALS~\global^\ast, \\
       \ELEM~\elem^\ast, \\
       \DATA~\data^\ast, \\
       \START~\start^?, \\
       \IMPORTS~\import^\ast, \\
       \EXPORTS~\export^\ast ~\} \\
      \end{array} \\ &&&
   \qquad (I = \{~
     \begin{array}[t]{@{}l@{}}
     \TYPES~(\F{id}(\Ttype))^\ast, \\
     \FUNCS~\F{funcids}(\Timport^\ast)~(\F{id}(\Tfunc))^\ast, \\
     \TABLES~\F{tableids}(\Timport^\ast)~(\F{id}(\Ttable))^\ast, \\
     \MEMS~\F{memids}(\Timport^\ast)~(\F{id}(\Tmem))^\ast, \\
     \GLOBALS~\F{globalids}(\Timport^\ast)~(\F{id}(\Tglobal))^\ast, \\
     \LOCALS~\epsilon, \\
     \LABELS~\epsilon,
     \TYPEDEFS~\functype^\ast ~\}~\mbox{well-formed}) \\
     \end{array}
   \end{array}

Here, the notation :math:`\bigcompose r^\ast` is shorthand for :ref:`composing <syntax-record>` a sequence of :ref:`module <syntax-module>` or :ref:`identifier context <text-context>` records, respectively;
if the sequence is empty, then all fields of the resulting record are empty.
Moreover, the following restrictions are imposed on the composition of :ref:`modules <syntax-module>`: :math:`m_1 \compose m_2` is defined if and only if

* :math:`m_1.\START = \epsilon \vee m_2.\START = \epsilon`

* :math:`m_2.\IMPORTS = \epsilon \vee m_1.\FUNCS = m_1.\TABLES = m_1.\MEMS = m_1.\GLOBALS = \epsilon`

.. note::
   The first condition ensures that there is at most one start function.
   The second condition enforces that all :ref:`imports <text-import>` must occur before any regular definition of a :ref:`function <text-func>`, :ref:`table <text-table>`, :ref:`memory <text-mem>`, or :ref:`global <text-global>`,
   thereby maintaining the ordering of the respective :ref:`index spaces <syntax-index>`.

   The :ref:`well-formedness <text-context-wf>` condition on :math:`I` in the grammar for |Tmodule| ensures that no namespace contains duplicate identifiers.

The definition of the initial :ref:`identifier context <text-context>` :math:`I` uses the following auxiliary definition which maps each relevant definition to a singular context with one (possibly empty) identifier:

.. todo:: |TYPEDEFS|

.. math::
   \begin{array}{@{}lcl@{\qquad\qquad}l}
   \F{idc}(\text{(}~\text{type}~\Tid^?~\dots~\text{)}) &=&
     \{\TYPES~(\Tid^?)\} \\
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

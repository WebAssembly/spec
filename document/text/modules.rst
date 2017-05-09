Modules
-------

.. todo:: free ordering


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

All :ref:`indices <syntax-index>` can be given either in raw numeric or in symbolic form.
In the latter case, they are looked up in the suitable space of the :ref:`identifier context <text-context>`.

.. math::
   \begin{array}{llclll}
   \production{type index} & \Ttypeidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\ &&|&
     v{:}\Tid &\Rightarrow& x & (I.\TYPES[x] = v) \\
   \production{function index} & \Tfuncidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\ &&|&
     v{:}\Tid &\Rightarrow& x & (I.\FUNCS[x] = v) \\
   \production{table index} & \Ttableidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\ &&|&
     v{:}\Tid &\Rightarrow& x & (I.\TABLES[x] = v) \\
   \production{memory index} & \Tmemidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\ &&|&
     v{:}\Tid &\Rightarrow& x & (I.\MEMS[x] = v) \\
   \production{global index} & \Tglobalidx_I &::=&
     x{:}\Tid &\Rightarrow& x \\ &&|&
     v{:}\Tid &\Rightarrow& x & (I.\GLOBALS[x] = v) \\
   \production{local index} & \Tlocalidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\ &&|&
     v{:}\Tid &\Rightarrow& x & (I.\LOCALS[x] = v) \\
   \production{label index} & \Tlabelidx_I &::=&
     l{:}\Tu32 &\Rightarrow& l \\ &&|&
     v{:}\Tid &\Rightarrow& x & (I.\LABELS[x] = v) \\
   \end{array}


.. _text-type:
.. index:: type definition
   pair: text format; type definition

Types
~~~~~

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
        I' = I \with \LOCALS~(\epsilon)^n) \\
        \end{array} \\ &&|&
     \text{(}~\text{type}~~x{:}\Ttypeidx_I~\text{)}
     ~~(t_1{:}\Tparam)^\ast~~(t_2{:}\Tresult)^\ast
       \quad\Rightarrow\quad x, I' \\ &&&\qquad
       (\begin{array}[t]{@{}l@{}}
        I.\TYPEDEFS[x] = [t_1^\ast] \to [t_2^\ast] \wedge
        I' = I \with \LOCALS~\F{id}(\Tparam)^\ast) \\
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


Abbreviations
.............

A |Ttypeuse| may also be replaced entirely by inline function :ref:`parameters <text-param>` and :ref:`result <text-result>` annotations.
In that case, the :ref:`type index <syntax-typeidx>` of the first matching :ref:`type definition <text-type>` is automatically inserted.
If no matching definition exists

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

.. todo:: inline imports

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

.. todo:: inline type, inline import/export

.. math::
   \begin{array}{llclll}
   \production{function} & \Tfunc_I &::=&
     \text{(}~\text{func}~~\Tid^?~~x,I'{:}\Ttypeuse_I~~
     (t{:}\Tlocal)^\ast~~(\X{in}{:}\Tinstr_{I'})^\ast~\text{)}
       &\Rightarrow& \{ \TYPE~x, \LOCALS~t^\ast, \BODY~\X{in}^\ast~\END \} \\ &&& \qquad
         (\begin{array}[n]{@{}l@{}}
          I'' = I' \with \LOCALS~(I'.\LOCALS)~\F{id}(\Tlocal)^\ast) \\
          \end{array} \\
   \production{local} & \Tlocal &::=&
     \text{(}~\text{local}~~\Tid^?~~t{:}\Tvaltype~\text{)}
       &\Rightarrow& t \\
   \end{array}

The definition of the local :ref:`identifier context <text-context>` :math:`I''` uses the following auxiliary notation to filter out optional identifiers from locals:

.. math::
   \begin{array}{lcl@{\qquad\qquad}l}
   \F{id}(\text{(}~\text{local}~\Tid^?~\dots~\text{)}) &=& \Tid^? \\
   \end{array}


Abbreviations
.............

A number of abbreviations are defined for functions.

Multiple anonymous locals may be combined into a single declaration:

.. math::
   \begin{array}{llclll}
   \production{local} &
     \text{(}~~\text{local}~~\Tvaltype^\ast~~\text{)} &\equiv&
     (\text{(}~~\text{local}~~\Tvaltype~~\text{)})^\ast \\
   \end{array}


.. _text-table:
.. index:: table, table type
   pair: text format; table

Tables
~~~~~~

.. math::
   \begin{array}{llclll}
   \production{table} & \Ttable_I &::=&
     \text{(}~\text{table}~~\Tid^?~~\X{tt}{:}\Ttabletype~\text{)}
       &\Rightarrow& \{ \TYPE~\X{tt} \} \\
   \end{array}


.. _text-mem:
.. index:: memory, memory type
   pair: text format; memory

Memories
~~~~~~~~

.. math::
   \begin{array}{llclll}
   \production{memory} & \Tmem_I &::=&
     \text{(}~\text{memory}~~\Tid^?~~\X{mt}{:}\Tmemtype~\text{)}
       &\Rightarrow& \{ \TYPE~\X{mt} \} \\
   \end{array}


.. _text-global:
.. index:: global, global type, expression
   pair: text format; global

Globals
~~~~~~~

.. math::
   \begin{array}{llclll}
   \production{global} & \Tglobal_I &::=&
     \text{(}~\text{global}~~\Tid^?~~\X{gt}{:}\Tglobaltype~~(\X{in}{:}\Tinstr_I)^\ast~\text{)}
       &\Rightarrow& \{ \TYPE~\X{gt}, \INIT~\X{in}^\ast~\END \} \\
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

.. math::
   \begin{array}{llclll}
   \production{element segment} & \Telem_I &::=&
     \text{(}~\text{elem}~~x{:}\Ttableidx_I~~\text{(}~\text{offset}~~(\X{in}{:}\Tinstr_I)^\ast~\text{)}~~y^\ast{:}\Tvec(\Tfuncidx_I)~\text{)}
       &\Rightarrow& \{ \TABLE~x, \OFFSET~\X{in}^\ast~\END, \INIT~y^\ast \} \\
   \end{array}


.. _text-data:
.. index:: data, memory, memory index, expression, byte
   pair: text format; data
   single: memory; data
   single: data; segment

Data Segments
~~~~~~~~~~~~~

.. math::
   \begin{array}{llclll}
   \production{data segment} & \Tdata_I &::=&
     \text{(}~\text{data}~~x{:}\Tmemidx_I~~\text{(}~\text{offset}~~(\X{in}{:}\Tinstr_I)^\ast~\text{)}~~b^\ast{:}\Tstring~\text{)}
       &\Rightarrow& \{ \MEM~x, \OFFSET~\X{in}^\ast~\END, \INIT~b^\ast \} \\
   \end{array}


.. _text-module:
.. index:: module, type definition, function type, function, table, memory, global, element, data, start function, import, export, context, version
   pair: text format; module

Modules
~~~~~~~

.. todo:: free ordering

.. math::
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

The definition of the :ref:`identifier context <text-context>` :math:`I` uses the following auxiliary notation to filters out optional identifiers from definitions and imports in an order-preserving fashion:

.. math::
   \begin{array}{lcl@{\qquad\qquad}l}
   \F{id}(\text{(}~\text{type}~\Tid^?~\dots~\text{)}) &=& \Tid^? \\
   \F{id}(\text{(}~\text{func}~\Tid^?~\dots~\text{)}) &=& \Tid^? \\
   \F{id}(\text{(}~\text{table}~\Tid^?~\dots~\text{)}) &=& \Tid^? \\
   \F{id}(\text{(}~\text{memory}~\Tid^?~\dots~\text{)}) &=& \Tid^? \\
   \F{id}(\text{(}~\text{global}~\Tid^?~\dots~\text{)}) &=& \Tid^? \\[1ex]
   \F{desc}(\text{(}~\text{import}~\dots~\Timportdesc~\text{)}) &=& \Timportdesc \\[1ex]
   \F{funcids}(\Timport^\ast) &=& [\Tid^? ~|~ \text{(}~\text{func}~\Tid^?~\dots~\text{)} \in \F{desc}(\Timport)^\ast] \\
   \F{tableids}(\Timport^\ast) &=& [\Tid^? ~|~ \text{(}~\text{table}~\Tid^?~\dots~\text{)} \in \F{desc}(\Timport)^\ast] \\
   \F{memids}(\Timport^\ast) &=& [\Tid^? ~|~ \text{(}~\text{memory}~\Tid^?~\dots~\text{)} \in \F{desc}(\Timport)^\ast] \\
   \F{globalids}(\Timport^\ast) &=& [\Tid^? ~|~ \text{(}~\text{global}~\Tid^?~\dots~\text{)} \in \F{desc}(\Timport)^\ast] \\
   \end{array}

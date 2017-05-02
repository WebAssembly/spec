Modules
-------

.. todo:: symbolic indices; free ordering


.. _text-index:
.. _text-typeidx:
.. _text-funcidx:
.. _text-tableidx:
.. _text-memidx:
.. _text-globalidx:
.. _text-localidx:
.. _text-labelidx:
.. _text-typebind:
.. _text-funcbind:
.. _text-tablebind:
.. _text-membind:
.. _text-globalbind:
.. _text-localbind:
.. _text-labelbind:
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

.. math::
   \begin{array}{llclll}
   \production{type index} & \Ttypeidx_C &::=&
     x{:}\Tu32 &\Rightarrow& x \\ &&|&
     v{:}\Tvar &\Rightarrow& x & (C.\TYPES[x] = v) \\
   \production{function index} & \Tfuncidx_C &::=&
     x{:}\Tu32 &\Rightarrow& x \\ &&|&
     v{:}\Tvar &\Rightarrow& x & (C.\FUNCS[x] = v) \\
   \production{table index} & \Ttableidx_C &::=&
     x{:}\Tu32 &\Rightarrow& x \\ &&|&
     v{:}\Tvar &\Rightarrow& x & (C.\TABLES[x] = v) \\
   \production{memory index} & \Tmemidx_C &::=&
     x{:}\Tu32 &\Rightarrow& x \\ &&|&
     v{:}\Tvar &\Rightarrow& x & (C.\MEMS[x] = v) \\
   \production{global index} & \Tglobalidx_C &::=&
     x{:}\Tu32 &\Rightarrow& x \\ &&|&
     v{:}\Tvar &\Rightarrow& x & (C.\GLOBALS[x] = v) \\
   \production{local index} & \Tlocalidx_C &::=&
     x{:}\Tu32 &\Rightarrow& x \\ &&|&
     v{:}\Tvar &\Rightarrow& x & (C.\LOCALS[x] = v) \\
   \production{label index} & \Tlabelidx_C &::=&
     l{:}\Tu32 &\Rightarrow& l \\ &&|&
     v{:}\Tvar &\Rightarrow& x & (C.\LABELS[x] = v) \\
   \end{array}

.. math::
   \begin{array}{llclll}
   \production{type binder} & \Ttypebind_C &::=&
     \epsilon &\Rightarrow& C \with \TYPES = C.\TYPES~(\epsilon) \\ &&|&
     v{:}\Tvar &\Rightarrow& C \with \TYPES = C.\TYPES~v
       & (v \notin C.\TYPES) \\
   \production{function binder} & \Tfuncbind_C &::=&
     \epsilon &\Rightarrow& C \with \FUNCS = C.\FUNCS~(\epsilon) \\ &&|&
     v{:}\Tvar &\Rightarrow& C \with \FUNCS = C.\FUNCS~v
       & (v \notin C.\FUNCS) \\
   \production{table binder} & \Ttablebind_C &::=&
     \epsilon &\Rightarrow& C \with \TABLES = C.\TABLES~(\epsilon) \\ &&|&
     v{:}\Tvar &\Rightarrow& C \with \TABLES = C.\TABLES~v
       & (v \notin C.\TABLES) \\
   \production{memory binder} & \Tmembind_C &::=&
     \epsilon &\Rightarrow& C \with \MEMS = C.\MEMS~(\epsilon) \\ &&|&
     v{:}\Tvar &\Rightarrow& C \with \MEMS = C.\MEMS~v
       & (v \notin C.\MEMS) \\
   \production{global binder} & \Tglobalbind_C &::=&
     \epsilon &\Rightarrow& C \with \GLOBALS = C.\GLOBALS~(\epsilon) \\ &&|&
     v{:}\Tvar &\Rightarrow& C \with \GLOBALS = C.\GLOBALS~v
       & (v \notin C.\GLOBALS) \\
   \production{local binder} & \Tlocalbind_C &::=&
     \epsilon &\Rightarrow& C \with \LOCALS = C.\LOCALS~(\epsilon) \\ &&|&
     v{:}\Tvar &\Rightarrow& C \with \LOCALS = C.\LOCALS~v
       & (v \notin C.\LOCALS) \\
   \production{label binder} & \Tlabelbind_C &::=&
     \epsilon &\Rightarrow& C \with \LABELS = C.\LABELS~(\epsilon) \\ &&|&
     v{:}\Tvar &\Rightarrow& C \with \LABELS = v~C.\LABELS
       & (v \notin C.\LABELS) \\
   \end{array}


.. _text-type:
.. _text-typeuse:
.. index:: type definition
   pair: text format; type definition

Types
~~~~~

.. math::
   \begin{array}{llclll}
   \production{type definition} & \Ttype &::=&
     \text{(}~\text{type}~~\X{ft}{:}\Tfunctype~\text{)}
       &\Rightarrow& \X{ft} \\
   \end{array}

.. todo:: inline functypes

.. math::
   \begin{array}{llclll}
   \production{type use} & \Ttypeuse &::=&
     \text{(}~\text{type}~~x{:}\Ttypeidx~\text{)}
       &\Rightarrow& x \\
   \end{array}


.. _text-import:
.. index:: import, name, function type, table type, memory type, global type
   pair: text format; import

Imports
~~~~~~~

.. todo:: inline imports

.. math::
   \begin{array}{llclll}
   \production{import} & \Timport &::=&
     \text{(}~\text{import}~~\X{mod}{:}\Tname~~\X{nm}{:}\Tname~~d{:}\Timportdesc~\text{)}
       &\Rightarrow& \{ \MODULE~\X{mod}, \NAME~\X{nm}, \DESC~d \} \\
   \production{import description} & \Timportdesc &::=&
     \text{(}~\text{func}~~x{:}\Ttypeuse~\text{)}
       &\Rightarrow& \FUNC~x \\ &&|&
     \text{(}~\text{table}~~\X{tt}{:}\Ttabletype~\text{)}
       &\Rightarrow& \TABLE~\X{tt} \\ &&|&
     \text{(}~\text{memory}~~\X{mt}{:}\Tmemtype~\text{)}
       &\Rightarrow& \MEM~~\X{mt} \\ &&|&
     \text{(}~\text{global}~~\X{gt}{:}\Tglobaltype~\text{)}
       &\Rightarrow& \GLOBAL~\X{gt} \\
   \end{array}


.. _text-func:
.. index:: function, type index, function type
   pair: text format; function

Functions
~~~~~~~~~

.. todo:: inline type, inline import/export, multi-locals

.. math::
   \begin{array}{llclll}
   \production{function} & \Tfunc &::=&
     \text{(}~\text{func}~~x{:}\Ttypeuse~~(t{:}\Tlocal)^\ast~~(\X{in}{:}\Tinstr)^\ast~\text{)}
       &\Rightarrow& \{ \TYPE~x, \LOCALS~t^\ast, \BODY~\X{in}^\ast~\END \} \\
   \production{local} & \Tlocal &::=&
     \text{(}~\text{local}~~t{:}\Tvaltype~\text{)}
       &\Rightarrow& t \\
   \end{array}


.. _text-table:
.. index:: table, table type
   pair: text format; table

Tables
~~~~~~

.. math::
   \begin{array}{llclll}
   \production{table} & \Ttable &::=&
     \text{(}~\text{table}~~\X{tt}{:}\Ttabletype~\text{)}
       &\Rightarrow& \{ \TYPE~\X{tt} \} \\
   \end{array}


.. _text-mem:
.. index:: memory, memory type
   pair: text format; memory

Memories
~~~~~~~~

.. math::
   \begin{array}{llclll}
   \production{memory} & \Tmem &::=&
     \text{(}~\text{memory}~~\X{mt}{:}\Tmemtype~\text{)}
       &\Rightarrow& \{ \TYPE~\X{mt} \} \\
   \end{array}


.. _text-global:
.. index:: global, global type, expression
   pair: text format; global

Globals
~~~~~~~

.. math::
   \begin{array}{llclll}
   \production{global} & \Tglobal &::=&
     \text{(}~\text{global}~~\X{gt}{:}\Tglobaltype~~(\X{in}{:}\Tinstr)^\ast~\text{)}
       &\Rightarrow& \{ \TYPE~\X{gt}, \INIT~\X{in}^\ast~\END \} \\
   \end{array}


.. _text-export:
.. index:: export, name, index, function index, table index, memory index, global index
   pair: text format; export

Exports
~~~~~~~

.. math::
   \begin{array}{llclll}
   \production{export} & \Texport &::=&
     \text{(}~\text{export}~~\X{nm}{:}\Tname~~d{:}\Texportdesc~\text{)}
       &\Rightarrow& \{ \NAME~\X{nm}, \DESC~d \} \\
   \production{export description} & \Texportdesc &::=&
     \text{(}~\text{func}~~x{:}\Bfuncidx~\text{)}
       &\Rightarrow& \FUNC~x \\ &&|&
     \text{(}~\text{table}~~x{:}\Btableidx~\text{)}
       &\Rightarrow& \TABLE~x \\ &&|&
     \text{(}~\text{memory}~~x{:}\Bmemidx~\text{)}
       &\Rightarrow& \MEM~x \\ &&|&
     \text{(}~\text{global}~~x{:}\Bglobalidx~\text{)}
       &\Rightarrow& \GLOBAL~x \\
   \end{array}


.. _text-start:
.. index:: start function, function index
   pair: text format; start function

Start Function
~~~~~~~~~~~~~~

.. math::
   \begin{array}{llclll}
   \production{start function} & \Tstart &::=&
     \text{(}~\text{start}~~x{:}\Tfuncidx~\text{)}
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
   \production{element segment} & \Telem &::=&
     \text{(}~\text{elem}~~x{:}\Ttableidx~~\text{(}~\text{offset}~~(\X{in}{:}\Tinstr)^\ast~\text{)}~~y^\ast{:}\Tvec(\Tfuncidx)~\text{)}
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
   \production{data segment} & \Tdata &::=&
     \text{(}~\text{data}~~x{:}\Tmemidx~~\text{(}~\text{offset}~~(\X{in}{:}\Tinstr)^\ast~\text{)}~~b^\ast{:}\Tstring~\text{)}
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
       &\Rightarrow& m \\ &&|&
     m{:}\Tmodulebody
       &\Rightarrow& m \\
   \production{module body} & \Tmodulebody &::=&
     (\functype{:}\Ttype)^\ast \\ &&&
     (\import{:}\Timport)^\ast \\ &&&
     (\func{:}\Tfunc)^\ast \\ &&&
     (\table{:}\Ttable)^\ast \\ &&&
     (\mem{:}\Tmem)^\ast \\ &&&
     (\global{:}\Tglobal)^\ast \\ &&&
     (\export{:}\Texport)^\ast \\ &&&
     (\start{:}\Tstart)^? \\ &&&
     (\elem{:}\Telem)^\ast \\ &&&
     (\data{:}\Tdata)^\ast
     &\Rightarrow& \{~
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
      \end{array} \\
   \end{array}

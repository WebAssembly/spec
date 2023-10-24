.. _syntax-instructions:

Instructions
------------

.. _syntax-sx:
.. _syntax-instr-numeric:
.. _syntax-unop_IXX:
.. _syntax-unop_FXX:
.. _syntax-binop_IXX:
.. _syntax-binop_FXX:
.. _syntax-testop_IXX:
.. _syntax-testop_FXX:
.. _syntax-relop_IXX:
.. _syntax-unop_numtype:
.. _syntax-binop_numtype:
.. _syntax-relop_numtype:
.. _syntax-cvtop:
.. _syntax-instructions-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}lrrl@{}}
   \mbox{(signedness)} & \mathit{sx} &::=& \mathsf{u} ~|~ \mathsf{s} \\[0.8ex]
   \mbox{(instruction)} & \mathit{instr} &::=& ... \\ &&|&
   \mathit{numtype}.\mathsf{const}~\mathit{c}_{\mathit{numtype}} \\ &&|&
   \mathit{numtype} . \mathit{unop}_{\mathit{numtype}} \\ &&|&
   \mathit{numtype} . \mathit{binop}_{\mathit{numtype}} \\ &&|&
   \mathit{numtype} . \mathit{testop}_{\mathit{numtype}} \\ &&|&
   \mathit{numtype} . \mathit{relop}_{\mathit{numtype}} \\ &&|&
   {\mathit{numtype}.\mathsf{extend}}{\mathit{n}} \\ &&|&
   \mathit{numtype} . {{{{\mathit{cvtop}}{\mathsf{\_}}}{\mathit{numtype}}}{\mathsf{\_}}}{{\mathit{sx}^?}} \\ &&|&
   ... \\[0.8ex]
   & \mathit{unop}_{\mathsf{ixx}} &::=& \mathsf{clz} ~|~ \mathsf{ctz} ~|~ \mathsf{popcnt} \\
   & \mathit{unop}_{\mathsf{fxx}} &::=& \mathsf{abs} ~|~ \mathsf{neg} ~|~ \mathsf{sqrt} ~|~ \mathsf{ceil} ~|~ \mathsf{floor} ~|~ \mathsf{trunc} ~|~ \mathsf{nearest} \\
   & \mathit{binop}_{\mathsf{ixx}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{mul} ~|~ {\mathsf{div\_}}{\mathit{sx}} ~|~ {\mathsf{rem\_}}{\mathit{sx}} \\ &&|&
   \mathsf{and} ~|~ \mathsf{or} ~|~ \mathsf{xor} ~|~ \mathsf{shl} ~|~ {\mathsf{shr\_}}{\mathit{sx}} ~|~ \mathsf{rotl} ~|~ \mathsf{rotr} \\
   & \mathit{binop}_{\mathsf{fxx}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{mul} ~|~ \mathsf{div} ~|~ \mathsf{min} ~|~ \mathsf{max} ~|~ \mathsf{copysign} \\
   & \mathit{testop}_{\mathsf{ixx}} &::=& \mathsf{eqz} \\
   & \mathit{testop}_{\mathsf{fxx}} &::=&  \\
   & \mathit{relop}_{\mathsf{ixx}} &::=& \mathsf{eq} ~|~ \mathsf{ne} ~|~ {\mathsf{lt\_}}{\mathit{sx}} ~|~ {\mathsf{gt\_}}{\mathit{sx}} ~|~ {\mathsf{le\_}}{\mathit{sx}} ~|~ {\mathsf{ge\_}}{\mathit{sx}} \\
   \end{array}

\

Occasionally, it is convenient to group operators together according to the following grammar shorthands:

.. math::
   \begin{array}{@{}lrrl@{}}
   & \mathit{unop}_{\mathit{numtype}} &::=& \mathit{unop}_{\mathsf{ixx}} ~|~ \mathit{unop}_{\mathsf{fxx}} \\
   & \mathit{binop}_{\mathit{numtype}} &::=& \mathit{binop}_{\mathsf{ixx}} ~|~ \mathit{binop}_{\mathsf{fxx}} \\
   & \mathit{relop}_{\mathit{numtype}} &::=& \mathit{relop}_{\mathsf{ixx}} ~|~ \mathit{relop}_{\mathsf{fxx}} \\
   & \mathit{cvtop} &::=& \mathsf{convert} ~|~ \mathsf{reinterpret} \\
   \end{array}

.. _syntax-instr-reference:
.. _syntax-instructions-reference:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{instr} &::=& ... \\ &&|&
   \mathsf{ref.null}~\mathit{reftype} \\ &&|&
   \mathsf{ref.func}~\mathit{funcidx} \\ &&|&
   \mathsf{ref.is\_null} \\ &&|&
   ... \\
   \end{array}

.. _syntax-instr-state:
.. _syntax-instructions-state:

State Instructions
~~~~~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{instr} &::=& ... \\ &&|&
   \mathsf{local.get}~\mathit{localidx} \\ &&|&
   \mathsf{local.set}~\mathit{localidx} \\ &&|&
   \mathsf{local.tee}~\mathit{localidx} \\ &&|&
   \mathsf{global.get}~\mathit{globalidx} \\ &&|&
   \mathsf{global.set}~\mathit{globalidx} \\ &&|&
   \mathsf{table.get}~\mathit{tableidx} \\ &&|&
   \mathsf{table.set}~\mathit{tableidx} \\ &&|&
   \mathsf{table.size}~\mathit{tableidx} \\ &&|&
   \mathsf{table.grow}~\mathit{tableidx} \\ &&|&
   \mathsf{table.fill}~\mathit{tableidx} \\ &&|&
   \mathsf{table.copy}~\mathit{tableidx}~\mathit{tableidx} \\ &&|&
   \mathsf{table.init}~\mathit{tableidx}~\mathit{elemidx} \\ &&|&
   \mathsf{elem.drop}~\mathit{elemidx} \\ &&|&
   \mathsf{memory.size} \\ &&|&
   \mathsf{memory.grow} \\ &&|&
   \mathsf{memory.fill} \\ &&|&
   \mathsf{memory.copy} \\ &&|&
   \mathsf{memory.init}~\mathit{dataidx} \\ &&|&
   \mathsf{data.drop}~\mathit{dataidx} \\ &&|&
   {\mathit{numtype}.\mathsf{load}}{{({{\mathit{n}}{\mathsf{\_}}}{\mathit{sx}})^?}}~\mathit{u{\scriptstyle32}}~\mathit{u{\scriptstyle32}} \\ &&|&
   {\mathit{numtype}.\mathsf{store}}{{\mathit{n}^?}}~\mathit{u{\scriptstyle32}}~\mathit{u{\scriptstyle32}} \\
   \end{array}

.. _syntax-instr-control:
.. _syntax-instructions-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{instr} &::=& \mathsf{unreachable} \\ &&|&
   \mathsf{nop} \\ &&|&
   \mathsf{drop} \\ &&|&
   \mathsf{select}~{\mathit{valtype}^?} \\ &&|&
   \mathsf{block}~\mathit{blocktype}~{\mathit{instr}^\ast} \\ &&|&
   \mathsf{loop}~\mathit{blocktype}~{\mathit{instr}^\ast} \\ &&|&
   \mathsf{if}~\mathit{blocktype}~{\mathit{instr}^\ast}~\mathsf{else}~{\mathit{instr}^\ast} \\ &&|&
   \mathsf{br}~\mathit{labelidx} \\ &&|&
   \mathsf{br\_if}~\mathit{labelidx} \\ &&|&
   \mathsf{br\_table}~{\mathit{labelidx}^\ast}~\mathit{labelidx} \\ &&|&
   \mathsf{call}~\mathit{funcidx} \\ &&|&
   \mathsf{call\_indirect}~\mathit{tableidx}~\mathit{functype} \\ &&|&
   \mathsf{return} \\ &&|&
   ... \\
   \end{array}

.. _syntax-instr-expr:
.. _syntax-instructions-expr:

Expressions
~~~~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{expr} &::=& {\mathit{instr}^\ast} \\
   \end{array}

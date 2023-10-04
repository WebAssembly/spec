.. _exec-instructions:

Instructions
------------

.. _exec-instructions-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-UNOP:

%{prose-algo: UNOP}

\

$${rule+: Step_pure/unop-*}

.. _exec-BINOP:

%{prose-algo: BINOP}

\

$${rule+: Step_pure/binop-*}

.. _exec-TESTOP:

%{prose-algo: TESTOP}

\

$${rule+: Step_pure/testop}

.. _exec-RELOP:

%{prose-algo: RELOP}

\

$${rule+: Step_pure/relop}

.. _exec-CVTOP:

%{prose-algo: CVTOP}

\

$${rule+: Step_pure/cvtop-*}

.. _exec-instructions-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _exec-REF.IS_NULL:

%{prose-algo: REF.IS_NULL}

\

$${rule+: Step_pure/ref.is_null-*}

.. _exec-REF.FUNC:

%{prose-algo: REF.FUNC}

\

$${rule+: Step_read/ref.func}

.. _exec-instructions-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _exec-DROP:

%{prose-algo: DROP}

\

$${rule+: Step_pure/drop}

.. _exec-SELECT:

%{prose-algo: SELECT}

\

$${rule+: Step_pure/select-*}

.. _exec-INSTRUCTIONS-VARIABLE:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _exec-local.get:

%{prose-algo: LOCAL.GET}

\

$${rule+: Step_read/local.get}

.. _exec-local.set:

%{prose-algo: LOCAL.SET}

\

$${rule+: Step/local.set}

.. _exec-local.tee:

%{prose-algo: LOCAL.TEE}

\

$${rule+: Step_pure/local.tee}

.. _exec-global.get:

%{prose-algo: GLOBAL.GET}

\

$${rule+: Step_read/global.get}

.. _exec-global.set:

%{prose-algo: GLOBAL.SET}

\

$${rule+: Step/global.set}

.. _exec-instructions-table:

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _exec-TABLE.GET:

%{prose-algo: TABLE.GET}

\

$${rule+: Step_read/table.get-*}

.. _exec-TABLE.SET:

%{prose-algo: TABLE.SET}

\

$${rule+: Step/table.set-*}

.. _exec-TABLE.SIZE:

%{prose-algo: TABLE.SIZE}

\

$${rule+: Step_read/table.size}

.. _exec-TABLE.GROW:

%{prose-algo: TABLE.GROW}

\

$${rule+: Step/table.grow-*}

.. _exec-TABLE.FILL:

%{prose-algo: TABLE.FILL}

\

$${rule+: Step_read/table.fill-*}

.. _exec-TABLE.COPY:

%{prose-algo: TABLE.COPY}

\

$${rule+: Step_read/table.copy-*}

.. _exec-TABLE.INIT:

%{prose-algo: TABLE.INIT}

\

$${rule+: Step_read/table.init-*}

.. _exec-ELEM.DROP:

%{prose-algo: ELEM.DROP}

\

$${rule+: Step/elem.drop}

.. _exec-instructions-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _exec-LOAD:

%{prose-algo: LOAD}

\

$${rule+: Step_read/load-*}

.. _exec-STORE:

%{prose-algo: STORE}

\

$${rule+: Step/store-*}

.. _exec-MEMORY.SIZE:

%{prose-algo: MEMORY.SIZE}

\

$${rule+: Step_read/memory.size}

.. _exec-MEMORY.GROW:

%{prose-algo: MEMORY.GROW}

\

$${rule+: Step/memory.grow-*}

.. _exec-MEMORY.FILL:

%{prose-algo: MEMORY.FILL}

\

$${rule+: Step_read/memory.fill-*}

.. _exec-MEMORY.COPY:

%{prose-algo: MEMORY.COPY}

\

$${rule+: Step_read/memory.copy-*}

.. _exec-MEMORY.INIT:

%{prose-algo: MEMORY.INIT}

\

$${rule+: Step_read/memory.init-*}

.. _exec-DATA.DROP:

%{prose-algo: DATA.DROP}

\

$${rule+: Step/data.drop}

.. _exec-instructions-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-NOP:

%{prose-algo: NOP}

\

$${rule+: Step_pure/nop}

.. _exec-UNREACHABLE:

%{prose-algo: UNREACHABLE}

\

$${rule+: Step_pure/unreachable}

.. _exec-BLOCK:

%{prose-algo: BLOCK}

\

$${rule+: Step_pure/block}

.. _exec-LOOP:

%{prose-algo: LOOP}

\

$${rule+: Step_pure/loop}

.. _exec-IF:

%{prose-algo: IF}

\

$${rule+: Step_pure/if-*}

.. _exec-BR:

%{prose-algo: BR}

\

$${rule+: Step_pure/br-*}

.. _exec-BR_IF:

%{prose-algo: BR_IF}

\

$${rule+: Step_pure/br_if-*}

.. _exec-BR_TABLE:

%{prose-algo: BR_TABLE}

\

$${rule+: Step_pure/br_table-*}

.. _exec-RETURN:

%{prose-algo: RETURN}

\

$${rule+: Step_pure/return-*}

.. _exec-CALL:

%{prose-algo: CALL}

\

$${rule+: Step_read/call}

.. _exec-CALL_INDIRECT:

%{prose-algo: CALL_INDIRECT}

\

$${rule+: Step_read/call_indirect-*}

.. _exec-instructions-seq:

Blocks
~~~~~~

.. _exec-LABEL_:

%{prose-algo: LABEL_}

\

$${rule+: Step_pure/label-vals}

Function Calls
~~~~~~~~~~~~~~

.. _exec-CALL_ADDR:

%{prose-algo: CALL_ADDR}

\

$${rule+: Step_read/call_addr}

.. _exec-FRAME_:

%{prose-algo: FRAME_}

\

$${rule+: Step_pure/frame-vals}

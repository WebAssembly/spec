.. _exec-instructions:

Instructions
------------

.. _exec-instructions-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-unop:

%{prose-algo: UNOP}

\

$${rule+: Step_pure/unop-*}

.. _exec-binop:

%{prose-algo: BINOP}

\

$${rule+: Step_pure/binop-*}

.. _exec-testop:

%{prose-algo: TESTOP}

\

$${rule+: Step_pure/testop}

.. _exec-relop:

%{prose-algo: RELOP}

\

$${rule+: Step_pure/relop}

.. _exec-cvtop:

%{prose-algo: CVTOP}

\

$${rule+: Step_pure/cvtop-*}

.. _exec-instructions-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _exec-ref.is_null:

%{prose-algo: REF.IS_NULL}

\

$${rule+: Step_pure/ref.is_null-*}

.. _exec-ref.func:

%{prose-algo: REF.FUNC}

\

$${rule+: Step_read/ref.func}

.. _exec-instructions-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _exec-drop:

%{prose-algo: DROP}

\

$${rule+: Step_pure/drop}

.. _exec-select:

%{prose-algo: SELECT}

\

$${rule+: Step_pure/select-*}

.. _exec-instructions-variable:

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

.. _exec-table.get:

%{prose-algo: TABLE.GET}

\

$${rule+: Step_read/table.get-*}

.. _exec-table.set:

%{prose-algo: TABLE.SET}

\

$${rule+: Step/table.set-*}

.. _exec-table.size:

%{prose-algo: TABLE.SIZE}

\

$${rule+: Step_read/table.size}

.. _exec-table.grow:

%{prose-algo: TABLE.GROW}

\

$${rule+: Step/table.grow-*}

.. _exec-table.fill:

%{prose-algo: TABLE.FILL}

\

$${rule+: Step_read/table.fill-*}

.. _exec-table.copy:

%{prose-algo: TABLE.COPY}

\

$${rule+: Step_read/table.copy-*}

.. _exec-table.init:

%{prose-algo: TABLE.INIT}

\

$${rule+: Step_read/table.init-*}

.. _exec-elem.drop:

%{prose-algo: ELEM.DROP}

\

$${rule+: Step/elem.drop}

.. _exec-instructions-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _exec-load:

%{prose-algo: LOAD}

\

$${rule+: Step_read/load-*}

.. _exec-store:

%{prose-algo: STORE}

\

$${rule+: Step/store-*}

.. _exec-memory.size:

%{prose-algo: MEMORY.SIZE}

\

$${rule+: Step_read/memory.size}

.. _exec-memory.grow:

%{prose-algo: MEMORY.GROW}

\

$${rule+: Step/memory.grow-*}

.. _exec-memory.fill:

%{prose-algo: MEMORY.FILL}

\

$${rule+: Step_read/memory.fill-*}

.. _exec-memory.copy:

%{prose-algo: MEMORY.COPY}

\

$${rule+: Step_read/memory.copy-*}

.. _exec-memory.init:

%{prose-algo: MEMORY.INIT}

\

$${rule+: Step_read/memory.init-*}

.. _exec-data.drop:

%{prose-algo: DATA.DROP}

\

$${rule+: Step/data.drop}

.. _exec-instructions-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-nop:

%{prose-algo: NOP}

\

$${rule+: Step_pure/nop}

.. _exec-unreachable:

%{prose-algo: UNREACHABLE}

\

$${rule+: Step_pure/unreachable}

.. _exec-block:

%{prose-algo: BLOCK}

\

$${rule+: Step_pure/block}

.. _exec-loop:

%{prose-algo: LOOP}

\

$${rule+: Step_pure/loop}

.. _exec-if:

%{prose-algo: IF}

\

$${rule+: Step_pure/if-*}

.. _exec-br:

%{prose-algo: BR}

\

$${rule+: Step_pure/br-*}

.. _exec-br_if:

%{prose-algo: BR_IF}

\

$${rule+: Step_pure/br_if-*}

.. _exec-br_table:

%{prose-algo: BR_TABLE}

\

$${rule+: Step_pure/br_table-*}

.. _exec-return:

%{prose-algo: RETURN}

\

$${rule+: Step_pure/return-*}

.. _exec-call:

%{prose-algo: CALL}

\

$${rule+: Step_read/call}

.. _exec-call_indirect:

%{prose-algo: CALL_INDIRECT}

\

$${rule+: Step_read/call_indirect-*}

.. _exec-instructions-seq:

Blocks
~~~~~~

.. _exec-label-vals:

%{prose-algo: LABEL_}

\

$${rule+: Step_pure/label-vals}

Function Calls
~~~~~~~~~~~~~~

.. _exec-call_addr:

%{prose-algo: CALL_ADDR}

\

$${rule+: Step_read/call_addr}

.. _exec-frame-vals:

%{prose-algo: FRAME_}

\

$${rule+: Step_pure/frame-vals}

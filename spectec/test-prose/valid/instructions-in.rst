.. _valid-instructions:

Instructions
------------

.. _valid-instructions-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _valid-unop:

%{prose-pred: UNOP}

\

$${rule+: Instr_ok/unop}

.. _valid-binop:

%{prose-pred: BINOP}

\

$${rule+: Instr_ok/binop}

.. _valid-testop:

%{prose-pred: TESTOP}

\

$${rule+: Instr_ok/testop}

.. _valid-relop:

%{prose-pred: RELOP}

\

$${rule+: Instr_ok/relop}

.. _valid-reinterpret:

TODO (should change the rule name to cvtop-)

\

$${rule+: Instr_ok/reinterpret}

.. _valid-convert:

TODO (should change the rule name to cvtop-)

\

$${rule+: Instr_ok/convert-*}

.. _valid-instructions-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _valid-ref.is_null:

%{prose-pred: REF.IS_NULL}

\

$${rule+: Instr_ok/ref.is_null}

.. _valid-ref.func:

%{prose-pred: REF.FUNC}

\

$${rule+: Instr_ok/ref.func}

.. _valid-instructions-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-drop:

%{prose-pred: DROP}

\

$${rule+: Instr_ok/drop}

.. _valid-select:

%{prose-pred: SELECT}

\

$${rule+: Instr_ok/select-*}

.. _valid-instructions-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _valid-local.get:

%{prose-pred: LOCAL.GET}

\

$${rule+: Instr_ok/local.get}

.. _valid-local.set:

%{prose-pred: LOCAL.SET}

\

$${rule+: Instr_ok/local.set}

.. _valid-local.tee:

%{prose-pred: LOCAL.TEE}

\

$${rule+: Instr_ok/local.tee}

.. _valid-global.get:

%{prose-pred: GLOBAL.GET}

\

$${rule+: Instr_ok/global.get}

.. _valid-global.set:

%{prose-pred: GLOBAL.SET}

\

$${rule+: Instr_ok/global.set}

.. _valid-instructions-table:

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _valid-table.get:

%{prose-pred: TABLE.GET}

\

$${rule+: Instr_ok/table.get}

.. _valid-table.set:

%{prose-pred: TABLE.SET}

\

$${rule+: Instr_ok/table.set}

.. _valid-table.size:

%{prose-pred: TABLE.SIZE}

\

$${rule+: Instr_ok/table.size}

.. _valid-table.grow:

%{prose-pred: TABLE.GROW}

\

$${rule+: Instr_ok/table.grow}

.. _valid-table.fill:

%{prose-pred: TABLE.FILL}

\

$${rule+: Instr_ok/table.fill}

.. _valid-table.copy:

%{prose-pred: TABLE.COPY}

\

$${rule+: Instr_ok/table.copy}

.. _valid-table.init:

%{prose-pred: TABLE.INIT}

\

$${rule+: Instr_ok/table.init}

.. _valid-elem.drop:

%{prose-pred: ELEM.DROP}

\

$${rule+: Instr_ok/elem.drop}

.. _valid-instructions-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _valid-load:

%{prose-pred: LOAD}

\

$${rule+: Instr_ok/load}

.. _valid-store:

%{prose-pred: STORE}

\

$${rule+: Instr_ok/store}

.. _valid-memory.size:

%{prose-pred: MEMORY.SIZE}

\

$${rule+: Instr_ok/memory.size}

.. _valid-memory.grow:

%{prose-pred: MEMORY.GROW}

\

$${rule+: Instr_ok/memory.grow}

.. _valid-memory.fill:

%{prose-pred: MEMORY.FILL}

\

$${rule+: Instr_ok/memory.fill}

.. _valid-memory.copy:

%{prose-pred: MEMORY.COPY}

\

$${rule+: Instr_ok/memory.copy}

.. _valid-memory.init:

%{prose-pred: MEMORY.INIT}

\

$${rule+: Instr_ok/memory.init}

.. _valid-data.drop:

%{prose-pred: DATA.DROP}

\

$${rule+: Instr_ok/data.drop}

.. _valid-instructions-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _valid-nop:

%{prose-pred: NOP}

\

$${rule+: Instr_ok/nop}

.. _valid-unreachable:

%{prose-pred: UNREACHABLE}

\

$${rule+: Instr_ok/unreachable}

.. _valid-block:

%{prose-pred: BLOCK}

\

$${rule+: Instr_ok/block}

.. _valid-loop:

%{prose-pred: LOOP}

\

$${rule+: Instr_ok/loop}

.. _valid-if:

%{prose-pred: IF}

\

$${rule+: Instr_ok/if}

.. _valid-br:

%{prose-pred: BR}

\

$${rule+: Instr_ok/br}

.. _valid-br_if:

%{prose-pred: BR_IF}

\

$${rule+: Instr_ok/br_if}

.. _valid-br_table:

%{prose-pred: BR_TABLE}

\

$${rule+: Instr_ok/br_table}

.. _valid-return:

%{prose-pred: RETURN}

\

$${rule+: Instr_ok/return}

.. _valid-call:

%{prose-pred: CALL}

\

$${rule+: Instr_ok/call}

.. _valid-call_indirect:

%{prose-pred: CALL_INDIRECT}

\

$${rule+: Instr_ok/call_indirect}

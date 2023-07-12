.. _valid-instr:

Instructions
------------

WebAssembly computation is performed by validuting individual instructions.

.. _valid-instr-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _valid-unop:

%{prose-pred: unop}

\

$${rule+: Instr_ok/unop}

.. _valid-binop:

%{prose-pred: binop}

\

$${rule+: Instr_ok/binop}

.. _valid-testop:

%{prose-pred: testop}

\

$${rule+: Instr_ok/testop}

.. _valid-relop:

%{prose-pred: relop}

\

$${rule+: Instr_ok/relop}

.. _valid-reinterpret:

%{prose-pred: reinterpret}

\

$${rule+: Instr_ok/reinterpret}

.. _valid-cvtop:

%{prose-pred: convert}

\

$${rule+: Instr_ok/convert-*}

.. _valid-instr-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _valid-ref.is_null:

%{prose-pred: ref.is_null}

\

$${rule+: Instr_ok/ref.is_null}

.. _valid-ref.func:

%{prose-pred: ref.func}

\

$${rule+: Instr_ok/ref.func}

.. _valid-instr-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-drop:

%{prose-pred: drop}

\

$${rule+: Instr_ok/drop}

.. _valid-select:

%{prose-pred: select}

\

$${rule+: Instr_ok/select-*}

.. _valid-instr-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _valid-local.get:

%{prose-pred: local.get}

\

$${rule+: Instr_ok/local.get}

.. _valid-local.set:

%{prose-pred: local.set}

\

$${rule+: Instr_ok/local.set}

.. _valid-local.tee:

%{prose-pred: local.tee}

\

$${rule+: Instr_ok/local.tee}

.. _valid-global.get:

%{prose-pred: global.get}

\

$${rule+: Instr_ok/global.get}

.. _valid-global.set:

%{prose-pred: global.set}

\

$${rule+: Instr_ok/global.set}

.. _valid-instr-table:

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _valid-table.get:

%{prose-pred: table.get}

\

$${rule+: Instr_ok/table.get}

.. _valid-table.set:

%{prose-pred: table.set}

\

$${rule+: Instr_ok/table.set}

.. _valid-table.size:

%{prose-pred: table.size}

\

$${rule+: Instr_ok/table.size}

.. _valid-table.grow:

%{prose-pred: table.grow}

\

$${rule+: Instr_ok/table.grow}

.. _valid-table.fill:

%{prose-pred: table.fill}

\

$${rule+: Instr_ok/table.fill}

.. _valid-table.copy:

%{prose-pred: table.copy}

\

$${rule+: Instr_ok/table.copy}

.. _valid-table.init:

%{prose-pred: table.init}

\

$${rule+: Instr_ok/table.init}

.. _valid-elem.drop:

%{prose-pred: elem.drop}

\

$${rule+: Instr_ok/elem.drop}

.. _valid-instr-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _valid-load:

%{prose-pred: load}

\

$${rule+: Instr_ok/load}

.. _valid-store:

%{prose-pred: store}

\

$${rule+: Instr_ok/store}

.. _valid-memory.size:

%{prose-pred: memory.size}

\

$${rule+: Instr_ok/memory.size}

.. _valid-memory.grow:

%{prose-pred: memory.grow}

\

$${rule+: Instr_ok/memory.grow}

.. _valid-memory.fill:

%{prose-pred: memory.fill}

\

$${rule+: Instr_ok/memory.fill}

.. _valid-memory.copy:

%{prose-pred: memory.copy}

\

$${rule+: Instr_ok/memory.copy}

.. _valid-memory.init:

%{prose-pred: memory.init}

\

$${rule+: Instr_ok/memory.init}

.. _valid-data.drop:

%{prose-pred: data.drop}

\

$${rule+: Instr_ok/data.drop}

.. _valid-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _valid-nop:

%{prose-pred: nop}

\

$${rule+: Instr_ok/nop}

.. _valid-unreachable:

%{prose-pred: unreachable}

\

$${rule+: Instr_ok/unreachable}

.. _valid-block:

%{prose-pred: block}

\

$${rule+: Instr_ok/block}

.. _valid-loop:

%{prose-pred: loop}

\

$${rule+: Instr_ok/loop}

.. _valid-if:

%{prose-pred: if}

\

$${rule+: Instr_ok/if}

.. _valid-br:

%{prose-pred: br}

\

$${rule+: Instr_ok/br}

.. _valid-br_if:

%{prose-pred: br_if}

\

$${rule+: Instr_ok/br_if}

.. _valid-br_table:

%{prose-pred: br_table}

\

$${rule+: Instr_ok/br_table}

.. _valid-return:

%{prose-pred: return}

\

$${rule+: Instr_ok/return}

.. _valid-call:

%{prose-pred: call}

\

$${rule+: Instr_ok/call}

.. _valid-call_indirect:

%{prose-pred: call_indirect}

\

$${rule+: Instr_ok/call_indirect}

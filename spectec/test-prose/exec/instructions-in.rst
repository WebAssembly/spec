.. _exec-instructions:

Instructions
------------

.. _exec-instructions-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-unop:

%{prose-algo: unop}

\

$${rule+: Step_pure/unop-*}

.. _exec-binop:

%{prose-algo: binop}

\

$${rule+: Step_pure/binop-*}

.. _exec-testop:

%{prose-algo: testop}

\

$${rule+: Step_pure/testop}

.. _exec-relop:

%{prose-algo: relop}

\

$${rule+: Step_pure/relop}

.. _exec-cvtop:

%{prose-algo: cvtop}

\

$${rule+: Step_pure/cvtop-*}

.. _exec-instructions-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _exec-ref.is_null:

%{prose-algo: ref.is_null}

\

$${rule+: Step_pure/ref.is_null-*}

.. _exec-ref.func:

%{prose-algo: ref.func}

\

$${rule+: Step_read/ref.func}

.. _exec-instructions-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _exec-drop:

%{prose-algo: drop}

\

$${rule+: Step_pure/drop}

.. _exec-select:

%{prose-algo: select}

\

$${rule+: Step_pure/select-*}

.. _exec-instructions-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _exec-local.get:

%{prose-algo: local.get}

\

$${rule+: Step_read/local.get}

.. _exec-local.set:

%{prose-algo: local.set}

\

$${rule+: Step/local.set}

.. _exec-local.tee:

%{prose-algo: local.tee}

\

$${rule+: Step_pure/local.tee}

.. _exec-global.get:

%{prose-algo: global.get}

\

$${rule+: Step_read/global.get}

.. _exec-global.set:

%{prose-algo: global.set}

\

$${rule+: Step/global.set}

.. _exec-instructions-table:

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _exec-table.get:

%{prose-algo: table.get}

\

$${rule+: Step_read/table.get-*}

.. _exec-table.set:

%{prose-algo: table.set}

\

$${rule+: Step/table.set-*}

.. _exec-table.size:

%{prose-algo: table.size}

\

$${rule+: Step_read/table.size}

.. _exec-table.grow:

%{prose-algo: table.grow}

\

$${rule+: Step/table.grow-*}

.. _exec-table.fill:

%{prose-algo: table.fill}

\

$${rule+: Step_read/table.fill-*}

.. _exec-table.copy:

%{prose-algo: table.copy}

\

$${rule+: Step_read/table.copy-*}

.. _exec-table.init:

%{prose-algo: table.init}

\

$${rule+: Step_read/table.init-*}

.. _exec-elem.drop:

%{prose-algo: elem.drop}

\

$${rule+: Step/elem.drop}

.. _exec-instructions-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _exec-load:

%{prose-algo: load}

\

$${rule+: Step_read/load-*}

.. _exec-store:

%{prose-algo: store}

\

$${rule+: Step/store-*}

.. _exec-memory.size:

%{prose-algo: memory.size}

\

$${rule+: Step_read/memory.size}

.. _exec-memory.grow:

%{prose-algo: memory.grow}

\

$${rule+: Step/memory.grow-*}

.. _exec-memory.fill:

%{prose-algo: memory.fill}

\

$${rule+: Step_read/memory.fill-*}

.. _exec-memory.copy:

%{prose-algo: memory.copy}

\

$${rule+: Step_read/memory.copy-*}

.. _exec-memory.init:

%{prose-algo: memory.init}

\

$${rule+: Step_read/memory.init-*}

.. _exec-data.drop:

%{prose-algo: data.drop}

\

$${rule+: Step/data.drop}

.. _exec-instructions-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-nop:

%{prose-algo: nop}

\

$${rule+: Step_pure/nop}

.. _exec-unreachable:

%{prose-algo: unreachable}

\

$${rule+: Step_pure/unreachable}

.. _exec-block:

%{prose-algo: block}

\

$${rule+: Step_pure/block}

.. _exec-loop:

%{prose-algo: loop}

\

$${rule+: Step_pure/loop}

.. _exec-if:

%{prose-algo: if}

\

$${rule+: Step_pure/if-*}

.. _exec-br:

%{prose-algo: br}

\

$${rule+: Step_pure/br-*}

.. _exec-br_if:

%{prose-algo: br_if}

\

$${rule+: Step_pure/br_if-*}

.. _exec-br_table:

%{prose-algo: br_table}

\

$${rule+: Step_pure/br_table-*}

.. _exec-return:

%{prose-algo: return}

\

$${rule+: Step_pure/return-*}

.. _exec-call:

%{prose-algo: call}

\

$${rule+: Step_read/call}

.. _exec-call_indirect:

%{prose-algo: call_indirect}

\

$${rule+: Step_read/call_indirect-*}

.. _exec-instructions-seq:

Blocks
~~~~~~

.. _exec-label-vals:

%{prose-algo: label}

\

$${rule+: Step_pure/label-vals}

Function Calls
~~~~~~~~~~~~~~

.. _exec-call_addr:

%{prose-algo: call_addr}

\

$${rule+: Step_read/call_addr}

.. _exec-frame-vals:

%{prose-algo: frame}

\

$${rule+: Step_pure/frame-vals}

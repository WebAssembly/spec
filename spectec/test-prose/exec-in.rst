Wasm Execution Prose 
====================

.. _exec-instr:

Instructions
------------

WebAssembly computation is performed by executing individual instructions.

.. _exec-instr-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-unop:

%{prose-rule: unop}

\

$${rule+: Step_pure/unop-*}

.. _exec-binop:

%{prose-rule: binop}

\

$${rule+: Step_pure/binop-*}

.. _exec-testop:

%{prose-rule: testop}

\

$${rule+: Step_pure/testop}

.. _exec-relop:

%{prose-rule: relop}

\

$${rule+: Step_pure/relop}

.. _exec-cvtop:

%{prose-rule: cvtop}

\

$${rule+: Step_pure/cvtop-*}

.. _exec-instr-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _exec-ref.is_null:

%{prose-rule: ref.is_null}

\

$${rule+: Step_pure/ref.is_null-*}

.. _exec-ref.func:

%{prose-rule: ref.func}

\

$${rule+: Step_read/ref.func}

.. _exec-instr-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _exec-drop:

%{prose-rule: drop}

\

$${rule+: Step_pure/drop}

.. _exec-select:

%{prose-rule: select}

\

$${rule+: Step_pure/select-*}

.. _exec-instr-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _exec-local.get:

%{prose-rule: local.get}

\

$${rule+: Step_read/local.get}

.. _exec-local.set:

%{prose-rule: local.set}

\

$${rule+: Step/local.set}

.. _exec-local.tee:

%{prose-rule: local.tee}

\

$${rule+: Step_pure/local.tee}

.. _exec-global.get:

%{prose-rule: global.get}

\

$${rule+: Step_read/global.get}

.. _exec-global.set:

%{prose-rule: global.set}

\

$${rule+: Step/global.set}

.. _exec-instr-table:

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _exec-table.get:

%{prose-rule: table.get}

\

$${rule+: Step_read/table.get-*}

.. _exec-table.set:

%{prose-rule: table.set}

\

$${rule+: Step/table.set-*}

.. _exec-table.size:

%{prose-rule: table.size}

\

$${rule+: Step_read/table.size}

.. _exec-table.grow:

%{prose-rule: table.grow}

\

$${rule+: Step/table.grow-*}

.. _exec-table.fill:

%{prose-rule: table.fill}

\

$${rule+: Step_read/table.fill-*}

.. _exec-table.copy:

%{prose-rule: table.copy}

\

$${rule+: Step_read/table.copy-*}

.. _exec-table.init:

%{prose-rule: table.init}

\

$${rule+: Step_read/table.init-*}

.. _exec-elem.drop:

%{prose-rule: elem.drop}

\

$${rule+: Step/elem.drop}

.. _exec-instr-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _exec-load:

%{prose-rule: load}

\

$${rule+: Step_read/load-*}

.. _exec-store:

%{prose-rule: store}

\

$${rule+: Step/store-*}

.. _exec-memory.size:

%{prose-rule: memory.size}

\

$${rule+: Step_read/memory.size}

.. _exec-memory.grow:

%{prose-rule: memory.grow}

\

$${rule+: Step/memory.grow-*}

.. _exec-memory.fill:

%{prose-rule: memory.fill}

\

$${rule+: Step_read/memory.fill-*}

.. _exec-memory.copy:

%{prose-rule: memory.copy}

\

$${rule+: Step_read/memory.copy-*}

.. _exec-memory.init:

%{prose-rule: memory.init}

\

$${rule+: Step_read/memory.init-*}

.. _exec-data.drop:

%{prose-rule: data.drop}

\

$${rule+: Step/data.drop}

.. _exec-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-nop:

%{prose-rule: nop}

\

$${rule+: Step_pure/nop}

.. _exec-unreachable:

%{prose-rule: unreachable}

\

$${rule+: Step_pure/unreachable}

.. _exec-block:

%{prose-rule: block}

\

$${rule+: Step_pure/block}

.. _exec-loop:

%{prose-rule: loop}

\

$${rule+: Step_pure/loop}

.. _exec-if:

%{prose-rule: if}

\

$${rule+: Step_pure/if-*}

.. _exec-br:

%{prose-rule: br}

\

$${rule+: Step_pure/br-*}

.. _exec-br_if:

%{prose-rule: br_if}

\

$${rule+: Step_pure/br_if-*}

.. _exec-br_table:

%{prose-rule: br_table}

\

$${rule+: Step_pure/br_table-*}

.. _exec-return:

%{prose-rule: return}

\

$${rule+: Step_pure/return-*}

.. _exec-call:

%{prose-rule: call}

\

$${rule+: Step_read/call}

.. _exec-call_indirect:

TODO (the prose is too deeply nested)


\

$${rule+: Step_read/call_indirect-*}

.. _exec-instr-seq:

Blocks
~~~~~~

.. _exec-label-vals:

%{prose-rule: label}

\

$${rule+: Step_pure/label-vals}

Function Calls
~~~~~~~~~~~~~~

.. _exec-call_addr:

%{prose-rule: call_addr}

\

$${rule+: Step_read/call_addr}

.. _exec-frame-vals:

%{prose-rule: frame}

\

$${rule+: Step_pure/frame-vals}

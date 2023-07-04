Wasm Prose Semantics
=====================

.. _exec-instr:

Instructions
------------

WebAssembly computation is performed by executing individual instructions.

.. _exec-instr-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-unop:

$${rule+: Step_pure/unop-*}

.. _exec-binop:

$${rule+: Step_pure/binop-*}

.. _exec-testop:

$${rule+: Step_pure/testop}

.. _exec-relop:

$${rule+: Step_pure/relop}

.. _exec-cvtop:

$${rule+: Step_pure/cvtop-*}

.. _exec-instr-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _exec-ref.is_null:

$${rule+: Step_pure/ref.is_null-*}

.. _exec-ref.func:

$${rule+: Step_read/ref.func}

.. _exec-instr-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _exec-drop:

%{prose-rule: drop}

$${rule+: Step/elem.drop}

.. _exec-select:

%{prose-rule: select}

$${rule+: Step_pure/select-*}

.. _exec-instr-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _exec-local.get:

$${rule+: Step_read/local.get}

.. _exec-local.set:

$${rule+: Step/local.set}

.. _exec-local.tee:

$${rule+: Step_pure/local.tee}

.. _exec-global.get:

$${rule+: Step_read/global.get}

.. _exec-global.set:

$${rule+: Step/global.set}

.. _exec-instr-table:

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _exec-table.get:

$${rule+: Step_read/table.get-*}

.. _exec-table.set:

$${rule+: Step/table.set-*}

.. _exec-table.size:

$${rule+: Step_read/table.size}

.. _exec-table.grow:

$${rule+: Step/table.grow-*}

.. _exec-table.fill:

$${rule+: Step_read/table.fill-*}

.. _exec-table.copy:

$${rule+: Step_read/table.copy-*}

.. _exec-table.init:

$${rule+: Step_read/table.init-*}

.. _exec-elem.drop:

$${rule+: Step/elem.drop}

.. _exec-instr-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _exec-load:

$${rule+: Step_read/load-*}

.. _exec-store:

$${rule+: Step/store-*}

.. _exec-memory.size:

$${rule+: Step_read/memory.size}

.. _exec-memory.grow:

$${rule+: Step/memory.grow-*}

.. _exec-memory.fill:

$${rule+: Step_read/memory.fill-*}

.. _exec-memory.copy:

$${rule+: Step_read/memory.copy-*}

.. _exec-memory.init:

$${rule+: Step_read/memory.init-*}

.. _exec-data.drop:

$${rule+: Step/data.drop}

.. _exec-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-nop:

%{prose-rule: nop}

$${rule+: Step_pure/nop}

.. _exec-unreachable:

%{prose-rule: unreachable}

$${rule+: Step_pure/unreachable}

.. _exec-block:

$${rule+: Step_pure/block}

.. _exec-loop:

$${rule+: Step_pure/loop}

.. _exec-if:

%{prose-rule: if}

$${rule+: Step_pure/if-*}

.. _exec-br:

$${rule+: Step_pure/br-*}

.. _exec-br_if:

$${rule+: Step_pure/br_if-*}

.. _exec-br_table:

$${rule+: Step_pure/br_table-*}

.. _exec-return:

$${rule+: Step_pure/return-*}

.. _exec-call:

$${rule+: Step_read/call}

.. _exec-call_indirect:

$${rule+: Step_read/call_indirect-*}

.. _exec-instr-seq:

Blocks
~~~~~~

.. _exec-label-vals:

$${rule+: Step_pure/label-vals}

Function Calls
~~~~~~~~~~~~~~

.. _exec-call_addr:

$${rule+: Step_read/call_addr}

.. _exec-frame-vals:

$${rule+: Step_pure/frame-vals}

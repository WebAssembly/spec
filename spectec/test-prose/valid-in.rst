Wasm Validation Prose 
=====================

.. _valid-instr:

Instructions
------------

WebAssembly computation is performed by validuting individual instructions.

.. _valid-instr-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _valid-unop:



\

$${rule+: Instr_ok/unop}

.. _valid-binop:



\

$${rule+: Instr_ok/binop}

.. _valid-testop:



\

$${rule+: Instr_ok/testop}

.. _valid-relop:



\

$${rule+: Instr_ok/relop}

.. _valid-reinterpret:



\

$${rule+: Instr_ok/reinterpret}

.. _valid-cvtop:



\

$${rule+: Instr_ok/convert-*}

.. _valid-instr-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _valid-ref.is_null:



\

$${rule+: Instr_ok/ref.is_null}

.. _valid-ref.func:



\

$${rule+: Instr_ok/ref.func}

.. _valid-instr-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-drop:



\

$${rule+: Instr_ok/drop}

.. _valid-select:



\

$${rule+: Instr_ok/select-*}

.. _valid-instr-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _valid-local.get:



\

$${rule+: Instr_ok/local.get}

.. _valid-local.set:



\

$${rule+: Instr_ok/local.set}

.. _valid-local.tee:



\

$${rule+: Instr_ok/local.tee}

.. _valid-global.get:



\

$${rule+: Instr_ok/global.get}

.. _valid-global.set:



\

$${rule+: Instr_ok/global.set}

.. _valid-instr-table:

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _valid-table.get:



\

$${rule+: Instr_ok/table.get}

.. _valid-table.set:



\

$${rule+: Instr_ok/table.set}

.. _valid-table.size:



\

$${rule+: Instr_ok/table.size}

.. _valid-table.grow:



\

$${rule+: Instr_ok/table.grow}

.. _valid-table.fill:



\

$${rule+: Instr_ok/table.fill}

.. _valid-table.copy:



\

$${rule+: Instr_ok/table.copy}

.. _valid-table.init:



\

$${rule+: Instr_ok/table.init}

.. _valid-elem.drop:



\

$${rule+: Instr_ok/elem.drop}

.. _valid-instr-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _valid-load:



\

$${rule+: Instr_ok/load}

.. _valid-store:



\

$${rule+: Instr_ok/store}

.. _valid-memory.size:



\

$${rule+: Instr_ok/memory.size}

.. _valid-memory.grow:



\

$${rule+: Instr_ok/memory.grow}

.. _valid-memory.fill:



\

$${rule+: Instr_ok/memory.fill}

.. _valid-memory.copy:



\

$${rule+: Instr_ok/memory.copy}

.. _valid-memory.init:



\

$${rule+: Instr_ok/memory.init}

.. _valid-data.drop:



\

$${rule+: Instr_ok/data.drop}

.. _valid-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _valid-nop:



\

$${rule+: Instr_ok/nop}

.. _valid-unreachable:



\

$${rule+: Instr_ok/unreachable}

.. _valid-block:



\

$${rule+: Instr_ok/block}

.. _valid-loop:



\

$${rule+: Instr_ok/loop}

.. _valid-if:



\

$${rule+: Instr_ok/if}

.. _valid-br:



\

$${rule+: Instr_ok/br}

.. _valid-br_if:



\

$${rule+: Instr_ok/br_if}

.. _valid-br_table:



\

$${rule+: Instr_ok/br_table}

.. _valid-return:



\

$${rule+: Instr_ok/return}

.. _valid-call:



\

$${rule+: Instr_ok/call}

.. _valid-call_indirect:

TODO (the prose is too deeply nested)


\

$${rule+: Instr_ok/call_indirect}

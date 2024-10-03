.. _exec-instructions:

Instructions
------------

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-unop:

$${rule-prose: Step_pure/unop}

\

$${rule+: Step_pure/unop-*}

.. _exec-binop:

$${rule-prose: Step_pure/binop}

\

$${rule+: Step_pure/binop-*}

.. _exec-testop:

$${rule-prose: Step_pure/testop}

\

$${rule: Step_pure/testop}

.. _exec-relop:

$${rule-prose: Step_pure/relop}

\

$${rule: Step_pure/relop}

.. _exec-cvtop:

$${rule-prose: Step_pure/cvtop}

\

$${rule+: Step_pure/cvtop-*}

Vector Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-vvunop:

$${rule-prose: Step_pure/vvunop}

\

$${rule+: Step_pure/vvunop}

.. _exec-vvbinop:

$${rule-prose: Step_pure/vvbinop}

\

$${rule+: Step_pure/vvbinop}

.. _exec-vvternop:

$${rule-prose: Step_pure/vvternop}

\

$${rule+: Step_pure/vvternop}

.. _exec-vvtestop:

$${rule-prose: Step_pure/vvtestop}

\

$${rule+: Step_pure/vvtestop}

.. _exec-vshuffle:

$${rule-prose: Step_pure/vshuffle}

\

$${rule+: Step_pure/vshuffle}

.. _exec-vsplat:

$${rule-prose: Step_pure/vsplat}

\

$${rule+: Step_pure/vsplat}

.. _exec-vextract_lane:

$${rule-prose: Step_pure/vextract_lane}

\

$${rule+: Step_pure/vextract_lane-*}

.. _exec-vreplace_lane:

$${rule-prose: Step_pure/vreplace_lane}

\

$${rule+: Step_pure/vreplace_lane}

.. _exec-vunop:

$${rule-prose: Step_pure/vunop}

\

$${rule+: Step_pure/vunop-*}

.. _exec-vbinop:

$${rule-prose: Step_pure/vbinop}

\

$${rule+: Step_pure/vbinop-*}

.. _exec-vrelop:

$${rule-prose: Step_pure/vrelop}

\

$${rule+: Step_pure/vrelop}

.. _exec-vshiftop:

$${rule-prose: Step_pure/vshiftop}

\

$${rule+: Step_pure/vshiftop}

.. _exec-vtestop:

$${rule-prose: Step_pure/vtestop}

\

$${rule+: Step_pure/vtestop}

.. _exec-vbitmask:

$${rule-prose: Step_pure/vbitmask}

\

$${rule+: Step_pure/vbitmask}

.. _exec-vnarrow:

$${rule-prose: Step_pure/vnarrow}

\

$${rule+: Step_pure/vnarrow}

.. _exec-vcvtop:

$${rule-prose: Step_pure/vcvtop}

\

$${rule+: Step_pure/vcvtop-*}

.. _exec-vextunop:

$${rule-prose: Step_pure/vextunop}

\

$${rule+: Step_pure/vextunop}

.. _exec-vextbinop:

$${rule-prose: Step_pure/vextbinop}

\

$${rule+: Step_pure/vextbinop}

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _exec-ref.func:

$${rule-prose: Step_read/ref.func}

\

$${rule+: Step_read/ref.func}

.. _exec-ref.is_null:

$${rule-prose: Step_pure/ref.is_null}

\

$${rule+: Step_pure/ref.is_null-*}

.. _exec-ref.as_non_null:

$${rule-prose: Step_pure/ref.as_non_null}

\

$${rule+: Step_pure/ref.as_non_null-*}

.. _exec-ref.eq:

$${rule-prose: Step_pure/ref.eq}

\

$${rule+: Step_pure/ref.eq-*}

.. _exec-ref.test:

$${rule-prose: Step_read/ref.test}

\

$${rule+: Step_read/ref.test-*}

.. _exec-ref.cast:

$${rule-prose: Step_read/ref.cast}

\

$${rule: Step_read/ref.cast-*}

.. _exec-ref.i31:

$${rule-prose: Step_pure/ref.i31}

\

$${rule+: Step_pure/ref.i31}

.. _exec-i31.get:

$${rule-prose: Step_pure/i31.get}

\

$${rule+: Step_pure/i31.get-*}

.. _def-add_structinst:

$${definition-prose: add_structinst}

\

$${definition: add_structinst}

.. _exec-struct.new:

$${rule-prose: Step/struct.new}

\

$${rule+: Step/struct.new}

.. _exec-struct.new_default:

$${rule-prose: Step_read/struct.new_default}

\

$${rule+: Step_read/struct.new_default}

.. _exec-struct.get:

$${rule-prose: Step_read/struct.get}

\

$${rule+: Step_read/struct.get-*}

.. _exec-struct.set:

$${rule-prose: Step/struct.set}

\

$${rule+: Step/struct.set-*}

.. _exec-array.new:

$${rule-prose: Step_pure/array.new}

\

$${rule+: Step_pure/array.new}

.. _exec-array.new_default:

$${rule-prose: Step_read/array.new_default}

\

$${rule+: Step_read/array.new_default}

.. _def-add_arrayinst:

$${definition-prose: add_arrayinst}

\

$${definition: add_arrayinst}

.. _exec-array.new_fixed:

$${rule-prose: Step/array.new_fixed}

\

$${rule+: Step/array.new_fixed}

.. _exec-array.new_elem:

$${rule-prose: Step_read/array.new_elem}

\

$${rule+: Step_read/array.new_elem-*}

.. _exec-array.new_data:

$${rule-prose: Step_read/array.new_data}

\

$${rule+: Step_read/array.new_data-*}

.. _exec-array.get:

$${rule-prose: Step_read/array.get}

\

$${rule+: Step_read/array.get-*}

.. _exec-array.set:

$${rule-prose: Step/array.set}

\

$${rule+: Step/array.set-*}

.. _exec-array.len:

$${rule-prose: Step_read/array.len}

\

$${rule+: Step_read/array.len-*}

.. _exec-array.fill:

$${rule-prose: Step_read/array.fill}

\

$${rule+: Step_read/array.fill-*}

.. _exec-array.copy:

ARRAY.COPY
^^^^^^^^^^

$${rule-prose: Step_read/array.copy}

\

$${rule+: Step_read/array.copy-*}

.. _exec-array.init_elem:

$${rule-prose: Step_read/array.init_elem}

\

$${rule+: Step_read/array.init_elem-*}

.. _exec-array.init_data:

$${rule-prose: Step_read/array.init_data}

\

$${rule+: Step_read/array.init_data-*}

.. _exec-extern.convert_any:

$${rule-prose: Step_pure/extern.convert_any}

\

$${rule+: Step_pure/extern.convert_any-*}

.. _exec-any.convert_extern:

$${rule-prose: Step_pure/any.convert_extern}

\

$${rule+: Step_pure/any.convert_extern-*}

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _exec-drop:

$${rule-prose: Step_pure/drop}

\

$${rule: Step_pure/drop}

.. _exec-select:

$${rule-prose: Step_pure/select}

\

$${rule+: Step_pure/select-*}

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _exec-local.get:

$${rule-prose: Step_read/local.get}

\

$${rule: Step_read/local.get}

.. _exec-local.set:

$${rule-prose: Step/local.set}

\

$${rule: Step/local.set}

.. _exec-local.tee:

$${rule-prose: Step_pure/local.tee}

\

$${rule: Step_pure/local.tee}

.. _exec-global.get:

$${rule-prose: Step_read/global.get}

\

$${rule: Step_read/global.get}

.. _exec-global.set:

$${rule-prose: Step/global.set}

\

$${rule: Step/global.set}

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _exec-table.get:

$${rule-prose: Step_read/table.get}

\

$${rule+: Step_read/table.get-*}

.. _exec-table.set:

$${rule-prose: Step/table.set}

\

$${rule+: Step/table.set-*}

.. _exec-table.size:

$${rule-prose: Step_read/table.size}

\

$${rule: Step_read/table.size}

.. _exec-table.grow:

$${rule-prose: Step/table.grow}

\

$${rule: Step/table.grow-*}

.. _exec-table.fill:

$${rule-prose: Step_read/table.fill}

\

$${rule+: Step_read/table.fill-*}

.. _exec-table.copy:

$${rule-prose: Step_read/table.copy}

\

$${rule+: Step_read/table.copy-*}

.. _exec-table.init:

$${rule-prose: Step_read/table.init}

\

$${rule+: Step_read/table.init-*}

.. _exec-elem.drop:

$${rule-prose: Step/elem.drop}

\

$${rule: Step/elem.drop}

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _exec-load:

$${rule-prose: Step_read/load}

\

$${rule+: Step_read/load-*}

.. _exec-store:

$${rule-prose: Step/store}

\

$${rule+: Step/store-*}

.. _exec-vload:

$${rule-prose: Step_read/vload}

\

$${rule+: Step_read/vload-*}

.. _exec-vload_lane:

$${rule-prose: Step_read/vload_lane}

\

$${rule+: Step_read/vload_lane-*}

.. _exec-vstore:

$${rule-prose: Step/vstore}

\

$${rule+: Step/vstore-*}

.. _exec-vstore_lane:

$${rule-prose: Step/vstore_lane}

\

$${rule+: Step/vstore_lane-*}

.. _exec-memory.size:

$${rule-prose: Step_read/memory.size}

\

$${rule: Step_read/memory.size}

.. _exec-memory.grow:

$${rule-prose: Step/memory.grow}

\

$${rule+: Step/memory.grow-*}

.. _exec-memory.fill:

$${rule-prose: Step_read/memory.fill}

\

$${rule+: Step_read/memory.fill-*}

.. _exec-memory.copy:

$${rule-prose: Step_read/memory.copy}

\

$${rule+: Step_read/memory.copy-*}

.. _exec-memory.init:

$${rule-prose: Step_read/memory.init}

\

$${rule+: Step_read/memory.init-*}

.. _exec-data.drop:

$${rule-prose: Step/data.drop}

\

$${rule: Step/data.drop}

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-nop:

$${rule-prose: Step_pure/nop}

\

$${rule: Step_pure/nop}

.. _exec-unreachable:

$${rule-prose: Step_pure/unreachable}

\

$${rule: Step_pure/unreachable}

.. _def-blocktype:

$${definition-prose: blocktype_}

\

$${definition: blocktype_}

.. _exec-block:

$${rule-prose: Step_read/block}

\

$${rule+: Step_read/block}

.. _exec-loop:

$${rule-prose: Step_read/loop}

\

$${rule+: Step_read/loop}

.. _exec-if:

$${rule-prose: Step_pure/if}

\

$${rule+: Step_pure/if-*}

.. _exec-br:

$${rule-prose: Step_pure/br}

\

$${rule+: Step_pure/br-*}

.. _exec-br_if:

$${rule-prose: Step_pure/br_if}

\

$${rule+: Step_pure/br_if-*}

.. _exec-br_table:

$${rule-prose: Step_pure/br_table}

\

$${rule+: Step_pure/br_table-*}

.. _exec-br_on_null:

$${rule-prose: Step_pure/br_on_null}

\

$${rule+: Step_pure/br_on_null-*}

.. _exec-br_on_non_null:

$${rule-prose: Step_pure/br_on_non_null}

\

$${rule+: Step_pure/br_on_non_null-*}

.. _exec-br_on_cast:

$${rule-prose: Step_read/br_on_cast}

\

$${rule+: Step_read/br_on_cast-*}

.. _exec-br_on_cast_fail:

$${rule-prose: Step_read/br_on_cast_fail}

\

$${rule+: Step_read/br_on_cast_fail-*}

.. _exec-return:

$${rule-prose: Step_pure/return}

\

$${rule+: Step_pure/return-*}

.. _exec-call:

$${rule-prose: Step_read/call}

\

$${rule: Step_read/call}

.. _exec-call_ref:

$${rule-prose: Step_read/call_ref}

\

$${rule+: Step_read/call_ref-*}

.. _exec-call_indirect:

$${rule-prose: Step_pure/call_indirect}

\

$${rule+: Step_pure/call_indirect}

.. _exec-return_call:

$${rule-prose: Step_read/return_call}

\

$${rule+: Step_read/return_call}

.. _exec-return_call_ref:

$${rule-prose: Step_read/return_call_ref}

\

$${rule+: Step_read/return_call_ref-*}

.. _exec-return_call_indirect:

$${rule-prose: Step_pure/return_call_indirect}

\

$${rule+: Step_pure/return_call_indirect}

Blocks
~~~~~~

.. _exec-label:

$${rule-prose: Step_pure/label}

\

$${rule+: Step_pure/label-vals}

Function Calls
~~~~~~~~~~~~~~

.. _exec-frame:

$${rule-prose: Step_pure/frame}

\

$${rule+: Step_pure/frame-vals}

Expressions
~~~~~~~~~~~

$${rule: Eval_expr}

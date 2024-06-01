.. _exec-instructions:

Instructions
------------

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-unop:

$${rule-prose: exec/unop}

\

$${rule+: Step_pure/unop-*}

.. _exec-binop:

$${rule-prose: exec/binop}

\

$${rule+: Step_pure/binop-*}

.. _exec-testop:

$${rule-prose: exec/testop}

\

$${rule: Step_pure/testop}

.. _exec-relop:

$${rule-prose: exec/relop}

\

$${rule: Step_pure/relop}

.. _exec-cvtop:

$${rule-prose: exec/cvtop}

\

$${rule+: Step_pure/cvtop-*}

Vector Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-vvunop:

$${rule-prose: exec/vvunop}

\

$${rule+: Step_pure/vvunop}

.. _exec-vvbinop:

$${rule-prose: exec/vvbinop}

\

$${rule+: Step_pure/vvbinop}

.. _exec-vvternop:

$${rule-prose: exec/vvternop}

\

$${rule+: Step_pure/vvternop}

.. _exec-vvtestop:

$${rule-prose: exec/vvtestop}

\

$${rule+: Step_pure/vvtestop}

.. _exec-vshuffle:

$${rule-prose: exec/vshuffle}

\

$${rule+: Step_pure/vshuffle}

.. _exec-vsplat:

$${rule-prose: exec/vsplat}

\

$${rule+: Step_pure/vsplat}

.. _exec-vextract_lane:

$${rule-prose: exec/vextract_lane}

\

$${rule+: Step_pure/vextract_lane-*}

.. _exec-vreplace_lane:

$${rule-prose: exec/vreplace_lane}

\

$${rule+: Step_pure/vreplace_lane}

.. _exec-vunop:

$${rule-prose: exec/vunop}

\

$${rule+: Step_pure/vunop}

.. _exec-vbinop:

$${rule-prose: exec/vbinop}

\

$${rule+: Step_pure/vbinop-*}

.. _exec-vrelop:

$${rule-prose: exec/vrelop}

\

$${rule+: Step_pure/vrelop}

.. _exec-vshiftop:

$${rule-prose: exec/vshiftop}

\

$${rule+: Step_pure/vshiftop}

.. _exec-vtestop:

$${rule-prose: exec/vtestop}

\

$${rule+: Step_pure/vtestop-*}

.. _exec-vbitmask:

$${rule-prose: exec/vbitmask}

\

$${rule+: Step_pure/vbitmask}

.. _exec-vnarrow:

$${rule-prose: exec/vnarrow}

\

$${rule+: Step_pure/vnarrow}

.. _exec-vcvtop:

$${rule-prose: exec/vcvtop}

\

$${rule+: Step_pure/vcvtop-*}

.. _exec-vextunop:

$${rule-prose: exec/vextunop}

\

$${rule+: Step_pure/vextunop}

.. _exec-vextbinop:

$${rule-prose: exec/vextbinop}

\

$${rule+: Step_pure/vextbinop}

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _exec-ref.func:

$${rule-prose: exec/ref.func}

\

$${rule+: Step_read/ref.func}

.. _exec-ref.is_null:

$${rule-prose: exec/ref.is_null}

\

$${rule+: Step_pure/ref.is_null-*}

.. _exec-ref.as_non_null:

$${rule-prose: exec/ref.as_non_null}

\

$${rule+: Step_pure/ref.as_non_null-*}

.. _exec-ref.eq:

$${rule-prose: exec/ref.eq}

\

$${rule+: Step_pure/ref.eq-*}

.. _exec-ref.test:

$${rule-prose: exec/ref.test}

\

$${rule+: Step_read/ref.test-*}

.. _exec-ref.cast:

$${rule-prose: exec/ref.cast}

\

$${rule: Step_read/ref.cast-*}

.. _exec-ref.i31:

$${rule-prose: exec/ref.i31}

\

$${rule+: Step_pure/ref.i31}

.. _exec-i31.get:

$${rule-prose: exec/i31.get}

\

$${rule+: Step_pure/i31.get-*}

.. _def-ext_structinst:

$${definition-prose: ext_structinst}

\

$${definition: ext_structinst}

.. _exec-struct.new:

$${rule-prose: exec/struct.new}

\

$${rule+: Step/struct.new}

.. _exec-struct.new_default:

$${rule-prose: exec/struct.new_default}

\

$${rule+: Step_read/struct.new_default}

.. _exec-struct.get:

$${rule-prose: exec/struct.get}

\

$${rule+: Step_read/struct.get-*}

.. _exec-struct.set:

$${rule-prose: exec/struct.set}

\

$${rule+: Step/struct.set-*}

.. _exec-array.new:

$${rule-prose: exec/array.new}

\

$${rule+: Step_pure/array.new}

.. _exec-array.new_default:

$${rule-prose: exec/array.new_default}

\

$${rule+: Step_read/array.new_default}

.. _def-ext_arrayinst:

$${definition-prose: ext_arrayinst}

\

$${definition: ext_arrayinst}

.. _exec-array.new_fixed:

$${rule-prose: exec/array.new_fixed}

\

$${rule+: Step/array.new_fixed}

.. _exec-array.new_elem:

$${rule-prose: exec/array.new_elem}

\

$${rule+: Step_read/array.new_elem-*}

.. _exec-array.new_data:

$${rule-prose: exec/array.new_data}

\

$${rule+: Step_read/array.new_data-*}

.. _exec-array.get:

$${rule-prose: exec/array.get}

\

$${rule+: Step_read/array.get-*}

.. _exec-array.set:

$${rule-prose: exec/array.set}

\

$${rule+: Step/array.set-*}

.. _exec-array.len:

$${rule-prose: exec/array.len}

\

$${rule+: Step_read/array.len-*}

.. _exec-array.fill:

$${rule-prose: exec/array.fill}

\

$${rule+: Step_read/array.fill-*}

.. _exec-array.copy:

ARRAY.COPY
^^^^^^^^^^

$${rule-prose: exec/array.copy}

\

$${rule+: Step_read/array.copy-*}

.. _exec-array.init_elem:

$${rule-prose: exec/array.init_elem}

\

$${rule+: Step_read/array.init_elem-*}

.. _exec-array.init_data:

$${rule-prose: exec/array.init_data}

\

$${rule+: Step_read/array.init_data-*}

.. _exec-extern.convert_any:

$${rule-prose: exec/extern.convert_any}

\

$${rule+: Step_pure/extern.convert_any-*}

.. _exec-any.convert_extern:

$${rule-prose: exec/any.convert_extern}

\

$${rule+: Step_pure/any.convert_extern-*}

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _exec-drop:

$${rule-prose: exec/drop}

\

$${rule: Step_pure/drop}

.. _exec-select:

$${rule-prose: exec/select}

\

$${rule+: Step_pure/select-*}

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _exec-local.get:

$${rule-prose: exec/local.get}

\

$${rule: Step_read/local.get}

.. _exec-local.set:

$${rule-prose: exec/local.set}

\

$${rule: Step/local.set}

.. _exec-local.tee:

$${rule-prose: exec/local.tee}

\

$${rule: Step_pure/local.tee}

.. _exec-global.get:

$${rule-prose: exec/global.get}

\

$${rule: Step_read/global.get}

.. _exec-global.set:

$${rule-prose: exec/global.set}

\

$${rule: Step/global.set}

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _exec-table.get:

$${rule-prose: exec/table.get}

\

$${rule+: Step_read/table.get-*}

.. _exec-table.set:

$${rule-prose: exec/table.set}

\

$${rule+: Step/table.set-*}

.. _exec-table.size:

$${rule-prose: exec/table.size}

\

$${rule: Step_read/table.size}

.. _exec-table.grow:

$${rule-prose: exec/table.grow}

\

$${rule: Step/table.grow-*}

.. _exec-table.fill:

$${rule-prose: exec/table.fill}

\

$${rule+: Step_read/table.fill-*}

.. _exec-table.copy:

$${rule-prose: exec/table.copy}

\

$${rule+: Step_read/table.copy-*}

.. _exec-table.init:

$${rule-prose: exec/table.init}

\

$${rule+: Step_read/table.init-*}

.. _exec-elem.drop:

$${rule-prose: exec/elem.drop}

\

$${rule: Step/elem.drop}

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _exec-load:

$${rule-prose: exec/load}

\

$${rule+: Step_read/load-*}

.. _exec-store:

$${rule-prose: exec/store}

\

$${rule+: Step/store-*}

.. _exec-vload:

$${rule-prose: exec/vload}

\

$${rule+: Step_read/vload-*}

.. _exec-vload_lane:

$${rule-prose: exec/vload_lane}

\

$${rule+: Step_read/vload_lane-*}

.. _exec-vstore:

$${rule-prose: exec/vstore}

\

$${rule+: Step/vstore-*}

.. _exec-vstore_lane:

$${rule-prose: exec/vstore_lane}

\

$${rule+: Step/vstore_lane-*}

.. _exec-memory.size:

$${rule-prose: exec/memory.size}

\

$${rule: Step_read/memory.size}

.. _exec-memory.grow:

$${rule-prose: exec/memory.grow}

\

$${rule+: Step/memory.grow-*}

.. _exec-memory.fill:

$${rule-prose: exec/memory.fill}

\

$${rule+: Step_read/memory.fill-*}

.. _exec-memory.copy:

$${rule-prose: exec/memory.copy}

\

$${rule+: Step_read/memory.copy-*}

.. _exec-memory.init:

$${rule-prose: exec/memory.init}

\

$${rule+: Step_read/memory.init-*}

.. _exec-data.drop:

$${rule-prose: exec/data.drop}

\

$${rule: Step/data.drop}

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-nop:

$${rule-prose: exec/nop}

\

$${rule: Step_pure/nop}

.. _exec-unreachable:

$${rule-prose: exec/unreachable}

\

$${rule: Step_pure/unreachable}

.. _def-blocktype:

$${definition-prose: blocktype_}

\

$${definition: blocktype_}

.. _exec-block:

$${rule-prose: exec/block}

\

$${rule+: Step_read/block}

.. _exec-loop:

$${rule-prose: exec/loop}

\

$${rule+: Step_read/loop}

.. _exec-if:

$${rule-prose: exec/if}

\

$${rule+: Step_pure/if-*}

.. _exec-br:

$${rule-prose: exec/br}

\

$${rule+: Step_pure/br-*}

.. _exec-br_if:

$${rule-prose: exec/br_if}

\

$${rule+: Step_pure/br_if-*}

.. _exec-br_table:

$${rule-prose: exec/br_table}

\

$${rule+: Step_pure/br_table-*}

.. _exec-br_on_null:

$${rule-prose: exec/br_on_null}

\

$${rule+: Step_pure/br_on_null-*}

.. _exec-br_on_non_null:

$${rule-prose: exec/br_on_non_null}

\

$${rule+: Step_pure/br_on_non_null-*}

.. _exec-br_on_cast:

$${rule-prose: exec/br_on_cast}

\

$${rule+: Step_read/br_on_cast-*}

.. _exec-br_on_cast_fail:

$${rule-prose: exec/br_on_cast_fail}

\

$${rule+: Step_read/br_on_cast_fail-*}

.. _exec-return:

$${rule-prose: exec/return}

\

$${rule+: Step_pure/return-*}

.. _exec-call:

$${rule-prose: exec/call}

\

$${rule: Step_read/call}

.. _exec-call_ref:

$${rule-prose: exec/call_ref}

\

$${rule+: Step_read/call_ref-*}

.. _exec-call_indirect:

$${rule-prose: exec/call_indirect}

\

$${rule+: Step_pure/call_indirect}

.. _exec-return_call:

$${rule-prose: exec/return_call}

\

$${rule+: Step_read/return_call}

.. _exec-return_call_ref:

$${rule-prose: exec/return_call_ref}

\

$${rule+: Step_read/return_call_ref-*}

.. _exec-return_call_indirect:

$${rule-prose: exec/return_call_indirect}

\

$${rule+: Step_pure/return_call_indirect}

Blocks
~~~~~~

.. _exec-label:

$${rule-prose: exec/label}

\

$${rule+: Step_pure/label-vals}

Function Calls
~~~~~~~~~~~~~~

.. _exec-frame:

$${rule-prose: exec/frame}

\

$${rule+: Step_pure/frame-vals}

Expressions
~~~~~~~~~~~

$${rule: Eval_expr}

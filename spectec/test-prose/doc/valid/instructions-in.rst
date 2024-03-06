.. _valid-instructions:

Instructions
------------

$${rule+:
  Valtype_sub/*
  Resulttype_sub
}

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _valid-const:

$${rule-prose: valid/const}

\

$${rule: Instr_ok/const}

.. _valid-unop:

$${rule-prose: valid/unop}

\

$${rule: Instr_ok/unop}

.. _valid-binop:

$${rule-prose: valid/binop}

\

$${rule: Instr_ok/binop}

.. _valid-testop:

$${rule-prose: valid/testop}

\

$${rule: Instr_ok/testop}

.. _valid-relop:

$${rule-prose: valid/relop}

\

$${rule: Instr_ok/relop}

.. _valid-cvtop:

$${rule-prose: valid/cvtop}

\

$${rule+: 
  Instr_ok/cvtop-*
}

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _valid-ref.null:

$${rule-prose: valid/ref.null}

\

$${rule: Instr_ok/ref.null}

.. _valid-ref.func:

$${rule-prose: valid/ref.func}

\

$${rule: Instr_ok/ref.func}

.. _valid-ref.is_null:

$${rule-prose: valid/ref.is_null}

\

$${rule: Instr_ok/ref.is_null}

.. _valid-ref.as_non_null:

$${rule-prose: valid/ref.as_non_null}

\

$${rule: Instr_ok/ref.as_non_null}

.. _valid-ref.eq:

$${rule-prose: valid/ref.eq}

\

$${rule: Instr_ok/ref.eq}

.. _valid-ref.test:

$${rule-prose: valid/ref.test}

\

$${rule: Instr_ok/ref.test}

.. _valid-ref.cast:

$${rule-prose: valid/ref.cast}

\

$${rule: Instr_ok/ref.cast}

.. _valid-instructions-aggregate-reference:

Aggregate Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-struct.new:

$${rule-prose: valid/struct.new}

\

$${rule: Instr_ok/struct.new}

.. _valid-struct.new_default:

$${rule-prose: valid/struct.new_default}

\

$${rule: Instr_ok/struct.new_default}

.. _valid-struct.get:

$${rule-prose: valid/struct.get}

\

$${rule: Instr_ok/struct.get}

.. _valid-struct.set:

$${rule-prose: valid/struct.set}

\

$${rule: Instr_ok/struct.set}

.. _valid-array.new:

$${rule-prose: valid/array.new}

\

$${rule: Instr_ok/array.new}

.. _valid-array.new_default:

$${rule-prose: valid/array.new_default}

\

$${rule: Instr_ok/array.new_default}

.. _valid-array.new_fixed:

$${rule-prose: valid/array.new_fixed}

\

$${rule: Instr_ok/array.new_fixed}

.. _valid-array.new_elem:

$${rule-prose: valid/array.new_elem}

\

$${rule: Instr_ok/array.new_elem}

.. _valid-array.new_data:

$${rule-prose: valid/array.new_data}

\

$${rule: Instr_ok/array.new_data}

.. _valid-array.get:

$${rule-prose: valid/array.get}

\

$${rule: Instr_ok/array.get}

.. _valid-array.set:

$${rule-prose: valid/array.set}

\

$${rule: Instr_ok/array.set}

.. _valid-array.len:

$${rule-prose: valid/array.len}

\

$${rule: Instr_ok/array.len}

.. _valid-array.fill:

$${rule-prose: valid/array.fill}

\

$${rule: Instr_ok/array.fill}

.. _valid-array.copy:

$${rule-prose: valid/array.copy}

\

$${rule: Instr_ok/array.copy}

.. _valid-array.init_data:

$${rule-prose: valid/array.init_data}

\

$${rule: Instr_ok/array.init_data}

.. _valid-array.init_elem:

$${rule-prose: valid/array.init_elem}

\

$${rule: Instr_ok/array.init_elem}

.. _valid-instructions-scalar-reference:

Scalar Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-ref.i31:

$${rule-prose: valid/ref.i31}

\

$${rule: Instr_ok/ref.i31}

.. _valid-i31.get:

$${rule-prose: valid/i31.get}

\

$${rule: Instr_ok/i31.get}

.. _valid-instructions-vector:

Vector Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-vconst:

$${rule-prose: valid/vconst}

\

$${rule: Instr_ok/vconst}

.. _valid-vvunop:

$${rule-prose: valid/vvunop}

\

$${rule: Instr_ok/vvunop}

.. _valid-vvbinop:

$${rule-prose: valid/vvbinop}

\

$${rule: Instr_ok/vvbinop}

.. _valid-vvternop:

$${rule-prose: valid/vvternop}

\

$${rule: Instr_ok/vvternop}

.. _valid-vvtestop:

$${rule-prose: valid/vvtestop}

\

$${rule: Instr_ok/vvtestop}

.. _valid-vshuffle:

$${rule-prose: valid/vshuffle}

\

$${rule: Instr_ok/vshuffle}

.. _valid-vsplat:

$${rule-prose: valid/vsplat}

\

$${rule: Instr_ok/vsplat}

.. _valid-vextract_lane:

$${rule-prose: valid/vextract_lane}

\

$${rule: Instr_ok/vextract_lane}

.. _valid-vreplace_lane:

$${rule-prose: valid/vreplace_lane}

\

$${rule: Instr_ok/vreplace_lane}

.. _valid-vunop:

$${rule-prose: valid/vunop}

\

$${rule: Instr_ok/vunop}

.. _valid-vbinop:

$${rule-prose: valid/vbinop}

\

$${rule: Instr_ok/vbinop}

.. _valid-vrelop:

$${rule-prose: valid/vrelop}

\

$${rule: Instr_ok/vrelop}

.. _valid-vshiftop:

$${rule-prose: valid/vshiftop}

\

$${rule: Instr_ok/vshiftop}

.. _valid-vtestop:

$${rule-prose: valid/vtestop}

\

$${rule: Instr_ok/vtestop}

.. _valid-vcvtop:

$${rule-prose: valid/vcvtop}

\

$${rule: Instr_ok/vcvtop}

.. _valid-vnarrow:

$${rule-prose: valid/vnarrow}

\

$${rule: Instr_ok/vnarrow}

.. _valid-vbitmask:

$${rule-prose: valid/vbitmask}

\

$${rule: Instr_ok/vbitmask}

.. _valid-vextunop:

$${rule-prose: valid/vextunop}

\

$${rule: Instr_ok/vextunop}

.. _valid-vextbinop:

$${rule-prose: valid/vextbinop}

\

$${rule: Instr_ok/vextbinop}

.. _valid-instructions-external-reference:

External Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-extern.convert_any:

$${rule-prose: valid/extern.convert_any}

\

$${rule: Instr_ok/extern.convert_any}

.. _valid-any.convert_extern:

$${rule-prose: valid/any.convert_extern}

\

$${rule: Instr_ok/any.convert_extern}

.. _valid-instructions-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-drop:

$${rule-prose: valid/drop}

\

$${rule: Instr_ok/drop}

.. _valid-select:

$${rule-prose: valid/select}

\

$${rule+: Instr_ok/select-*}

.. _valid-instructions-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _valid-local.get:

$${rule-prose: valid/local.get}

\

$${rule: Instr_ok/local.get}

.. _valid-local.set:

LOCAL.SET
^^^^^^^^^

TODO (not found) 

\

$${rule+: Instr_ok/local.set}

.. _valid-local.tee:

LOCAL.TEE
^^^^^^^^^

TODO (not found)

\

$${rule+: Instr_ok/local.tee}

.. _valid-global.get:

$${rule-prose: valid/global.get}

\

$${rule: Instr_ok/global.get}

.. _valid-global.set:

$${rule-prose: valid/global.set}

\

$${rule: Instr_ok/global.set}

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _valid-table.get:

$${rule-prose: valid/table.get}

\

$${rule: Instr_ok/table.get}

.. _valid-table.set:

$${rule-prose: valid/table.set}

\

$${rule: Instr_ok/table.set}

.. _valid-table.size:

$${rule-prose: valid/table.size}

\

$${rule: Instr_ok/table.size}

.. _valid-table.grow:

$${rule-prose: valid/table.grow}

\

$${rule: Instr_ok/table.grow}

.. _valid-table.fill:

$${rule-prose: valid/table.fill}

\

$${rule: Instr_ok/table.fill}

.. _valid-table.copy:

$${rule-prose: valid/table.copy}

\

$${rule: Instr_ok/table.copy}

.. _valid-table.init:

$${rule-prose: valid/table.init}

\

$${rule: Instr_ok/table.init}

.. _valid-elem.drop:

$${rule-prose: valid/elem.drop}

\

$${rule: Instr_ok/elem.drop}

.. _valid-instructions-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _valid-load:

$${rule-prose: valid/load}

\

$${rule: Instr_ok/load}

.. _valid-store:

$${rule-prose: valid/store}

\

$${rule: Instr_ok/store}

.. _valid-vload:

$${rule-prose: valid/vload}

\

$${rule: Instr_ok/vload}
$${rule: Instr_ok/vload-splat}
$${rule: Instr_ok/vload-zero}

.. _valid-vload_lane:

$${rule-prose: valid/vload_lane}

\

$${rule: Instr_ok/vload_lane}

.. _valid-vstore:

$${rule-prose: valid/vstore}

\

$${rule: Instr_ok/vstore}

.. _valid-vstore_lane:

$${rule-prose: valid/vstore_lane}

\

$${rule: Instr_ok/vstore_lane}


.. _valid-memory.size:

$${rule-prose: valid/memory.size}

\

$${rule: Instr_ok/memory.size}

.. _valid-memory.grow:

$${rule-prose: valid/memory.grow}

\

$${rule: Instr_ok/memory.grow}

.. _valid-memory.fill:

$${rule-prose: valid/memory.fill}

\

$${rule: Instr_ok/memory.fill}

.. _valid-memory.copy:

$${rule-prose: valid/memory.copy}

\

$${rule: Instr_ok/memory.copy}

.. _valid-memory.init:

$${rule-prose: valid/memory.init}

\

$${rule: Instr_ok/memory.init}

.. _valid-data.drop:

$${rule-prose: valid/data.drop}

\

$${rule: Instr_ok/data.drop}

.. _valid-instructions-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _valid-nop:

$${rule-prose: valid/nop}

\

$${rule: Instr_ok/nop}

.. _valid-unreachable:

$${rule-prose: valid/unreachable}

\

$${rule: Instr_ok/unreachable}

.. _valid-block:

$${rule-prose: valid/block}

\

$${rule: Instr_ok/block}

.. _valid-loop:

$${rule-prose: valid/loop}

\

$${rule: Instr_ok/loop}

.. _valid-if:

$${rule-prose: valid/if}

\

$${rule: Instr_ok/if}

.. _valid-br:

$${rule-prose: valid/br}

\

$${rule: Instr_ok/br}

.. _valid-br_if:

$${rule-prose: valid/br_if}

\

$${rule: Instr_ok/br_if}

.. _valid-br_table:

$${rule-prose: valid/br_table}

\

$${rule: Instr_ok/br_table}

.. _valid-br_on_null:

$${rule-prose: valid/br_on_null}

\

$${rule: Instr_ok/br_on_null}

.. _valid-br_on_non_null:

$${rule-prose: valid/br_on_non_null}

\

$${rule: Instr_ok/br_on_non_null}

.. _valid-br_on_cast:

$${rule-prose: valid/br_on_cast}

\

$${rule: Instr_ok/br_on_cast}

.. _valid-br_on_cast_fail:

TODO (typo in DSL typing rule)

\

$${rule: Instr_ok/br_on_cast_fail}

.. _valid-return:

$${rule-prose: valid/return}

\

$${rule: Instr_ok/return}

.. _valid-call:

$${rule-prose: valid/call}

\

$${rule: Instr_ok/call}

.. _valid-call_ref:

$${rule-prose: valid/call_ref}

\

$${rule+: Instr_ok/call_ref}


.. _valid-call_indirect:

$${rule-prose: valid/call_indirect}

\

$${rule+: Instr_ok/call_indirect}

.. _valid-return_call:

$${rule-prose: valid/return_call}

\

$${rule+: Instr_ok/return_call}

.. _valid-return_call_ref:

$${rule-prose: valid/return_call_ref}

\

$${rule+: Instr_ok/return_call_ref}

.. _valid-return_call_indirect:

$${rule-prose: valid/return_call_indirect}

\

$${rule+: Instr_ok/return_call_indirect}

.. _valid-instructions-sequences:

Instruction Sequences
~~~~~~~~~~~~~~~~~~~~~

$${rule+:
  Instrs_ok/*
}

.. _valid-instructions-expressions:

Expressions
~~~~~~~~~~~

$${rule+: 
  Expr_ok
  Instr_const/*
  Expr_const
  Expr_ok_const
}

.. _def-in_binop:

$${definition-prose: in_binop}

\

$${definition: in_binop}

.. _def-in_numtype:

$${definition-prose: in_numtype}

\

$${definition: in_numtype}

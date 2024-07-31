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

$${rule-prose: Instr_ok/const}

\

$${rule: Instr_ok/const}

.. _valid-unop:

$${rule-prose: Instr_ok/unop}

\

$${rule: Instr_ok/unop}

.. _valid-binop:

$${rule-prose: Instr_ok/binop}

\

$${rule: Instr_ok/binop}

.. _valid-testop:

$${rule-prose: Instr_ok/testop}

\

$${rule: Instr_ok/testop}

.. _valid-relop:

$${rule-prose: Instr_ok/relop}

\

$${rule: Instr_ok/relop}

.. _valid-cvtop:

$${rule-prose: Instr_ok/cvtop}

\

$${rule+: 
  Instr_ok/cvtop
}

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _valid-ref.null:

$${rule-prose: Instr_ok/ref.null}

\

$${rule: Instr_ok/ref.null}

.. _valid-ref.func:

$${rule-prose: Instr_ok/ref.func}

\

$${rule: Instr_ok/ref.func}

.. _valid-ref.is_null:

$${rule-prose: Instr_ok/ref.is_null}

\

$${rule: Instr_ok/ref.is_null}

.. _valid-ref.as_non_null:

$${rule-prose: Instr_ok/ref.as_non_null}

\

$${rule: Instr_ok/ref.as_non_null}

.. _valid-ref.eq:

$${rule-prose: Instr_ok/ref.eq}

\

$${rule: Instr_ok/ref.eq}

.. _valid-ref.test:

$${rule-prose: Instr_ok/ref.test}

\

$${rule: Instr_ok/ref.test}

.. _valid-ref.cast:

$${rule-prose: Instr_ok/ref.cast}

\

$${rule: Instr_ok/ref.cast}

.. _valid-instructions-aggregate-reference:

Aggregate Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-struct.new:

$${rule-prose: Instr_ok/struct.new}

\

$${rule: Instr_ok/struct.new}

.. _valid-struct.new_default:

$${rule-prose: Instr_ok/struct.new_default}

\

$${rule: Instr_ok/struct.new_default}

.. _valid-struct.get:

$${rule-prose: Instr_ok/struct.get}

\

$${rule: Instr_ok/struct.get}

.. _valid-struct.set:

$${rule-prose: Instr_ok/struct.set}

\

$${rule: Instr_ok/struct.set}

.. _valid-array.new:

$${rule-prose: Instr_ok/array.new}

\

$${rule: Instr_ok/array.new}

.. _valid-array.new_default:

$${rule-prose: Instr_ok/array.new_default}

\

$${rule: Instr_ok/array.new_default}

.. _valid-array.new_fixed:

$${rule-prose: Instr_ok/array.new_fixed}

\

$${rule: Instr_ok/array.new_fixed}

.. _valid-array.new_elem:

$${rule-prose: Instr_ok/array.new_elem}

\

$${rule: Instr_ok/array.new_elem}

.. _valid-array.new_data:

$${rule-prose: Instr_ok/array.new_data}

\

$${rule: Instr_ok/array.new_data}

.. _valid-array.get:

$${rule-prose: Instr_ok/array.get}

\

$${rule: Instr_ok/array.get}

.. _valid-array.set:

$${rule-prose: Instr_ok/array.set}

\

$${rule: Instr_ok/array.set}

.. _valid-array.len:

$${rule-prose: Instr_ok/array.len}

\

$${rule: Instr_ok/array.len}

.. _valid-array.fill:

$${rule-prose: Instr_ok/array.fill}

\

$${rule: Instr_ok/array.fill}

.. _valid-array.copy:

$${rule-prose: Instr_ok/array.copy}

\

$${rule: Instr_ok/array.copy}

.. _valid-array.init_data:

$${rule-prose: Instr_ok/array.init_data}

\

$${rule: Instr_ok/array.init_data}

.. _valid-array.init_elem:

$${rule-prose: Instr_ok/array.init_elem}

\

$${rule: Instr_ok/array.init_elem}

.. _valid-instructions-scalar-reference:

Scalar Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-ref.i31:

$${rule-prose: Instr_ok/ref.i31}

\

$${rule: Instr_ok/ref.i31}

.. _valid-i31.get:

$${rule-prose: Instr_ok/i31.get}

\

$${rule: Instr_ok/i31.get}

.. _valid-instructions-vector:

Vector Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-vconst:

$${rule-prose: Instr_ok/vconst}

\

$${rule: Instr_ok/vconst}

.. _valid-vvunop:

$${rule-prose: Instr_ok/vvunop}

\

$${rule: Instr_ok/vvunop}

.. _valid-vvbinop:

$${rule-prose: Instr_ok/vvbinop}

\

$${rule: Instr_ok/vvbinop}

.. _valid-vvternop:

$${rule-prose: Instr_ok/vvternop}

\

$${rule: Instr_ok/vvternop}

.. _valid-vvtestop:

$${rule-prose: Instr_ok/vvtestop}

\

$${rule: Instr_ok/vvtestop}

.. _valid-vshuffle:

$${rule-prose: Instr_ok/vshuffle}

\

$${rule: Instr_ok/vshuffle}

.. _valid-vsplat:

$${rule-prose: Instr_ok/vsplat}

\

$${rule: Instr_ok/vsplat}

.. _valid-vextract_lane:

$${rule-prose: Instr_ok/vextract_lane}

\

$${rule: Instr_ok/vextract_lane}

.. _valid-vreplace_lane:

$${rule-prose: Instr_ok/vreplace_lane}

\

$${rule: Instr_ok/vreplace_lane}

.. _valid-vunop:

$${rule-prose: Instr_ok/vunop}

\

$${rule: Instr_ok/vunop}

.. _valid-vbinop:

$${rule-prose: Instr_ok/vbinop}

\

$${rule: Instr_ok/vbinop}

.. _valid-vrelop:

$${rule-prose: Instr_ok/vrelop}

\

$${rule: Instr_ok/vrelop}

.. _valid-vshiftop:

$${rule-prose: Instr_ok/vshiftop}

\

$${rule: Instr_ok/vshiftop}

.. _valid-vtestop:

$${rule-prose: Instr_ok/vtestop}

\

$${rule: Instr_ok/vtestop}

.. _valid-vcvtop:

$${rule-prose: Instr_ok/vcvtop}

\

$${rule: Instr_ok/vcvtop}

.. _valid-vnarrow:

$${rule-prose: Instr_ok/vnarrow}

\

$${rule: Instr_ok/vnarrow}

.. _valid-vbitmask:

$${rule-prose: Instr_ok/vbitmask}

\

$${rule: Instr_ok/vbitmask}

.. _valid-vextunop:

$${rule-prose: Instr_ok/vextunop}

\

$${rule: Instr_ok/vextunop}

.. _valid-vextbinop:

$${rule-prose: Instr_ok/vextbinop}

\

$${rule: Instr_ok/vextbinop}

.. _valid-instructions-external-reference:

External Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-extern.convert_any:

$${rule-prose: Instr_ok/extern.convert_any}

\

$${rule: Instr_ok/extern.convert_any}

.. _valid-any.convert_extern:

$${rule-prose: Instr_ok/any.convert_extern}

\

$${rule: Instr_ok/any.convert_extern}

.. _valid-instructions-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-drop:

$${rule-prose: Instr_ok/drop}

\

$${rule: Instr_ok/drop}

.. _valid-select:

$${rule-prose: Instr_ok/select}

\

$${rule+: Instr_ok/select-*}

.. _valid-instructions-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _valid-local.get:

$${rule-prose: Instr_ok/local.get}

\

$${rule: Instr_ok/local.get}

.. _valid-local.set:


$${rule-prose: Instr_ok/local.set}

\

$${rule+: Instr_ok/local.set}

.. _valid-local.tee:

$${rule-prose: Instr_ok/local.tee}

\

$${rule+: Instr_ok/local.tee}

.. _valid-global.get:

$${rule-prose: Instr_ok/global.get}

\

$${rule: Instr_ok/global.get}

.. _valid-global.set:

$${rule-prose: Instr_ok/global.set}

\

$${rule: Instr_ok/global.set}

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _valid-table.get:

$${rule-prose: Instr_ok/table.get}

\

$${rule: Instr_ok/table.get}

.. _valid-table.set:

$${rule-prose: Instr_ok/table.set}

\

$${rule: Instr_ok/table.set}

.. _valid-table.size:

$${rule-prose: Instr_ok/table.size}

\

$${rule: Instr_ok/table.size}

.. _valid-table.grow:

$${rule-prose: Instr_ok/table.grow}

\

$${rule: Instr_ok/table.grow}

.. _valid-table.fill:

$${rule-prose: Instr_ok/table.fill}

\

$${rule: Instr_ok/table.fill}

.. _valid-table.copy:

$${rule-prose: Instr_ok/table.copy}

\

$${rule: Instr_ok/table.copy}

.. _valid-table.init:

$${rule-prose: Instr_ok/table.init}

\

$${rule: Instr_ok/table.init}

.. _valid-elem.drop:

$${rule-prose: Instr_ok/elem.drop}

\

$${rule: Instr_ok/elem.drop}

.. _valid-instructions-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _valid-load:

$${rule-prose: Instr_ok/load}

\

$${rule: Instr_ok/load-val}
$${rule: Instr_ok/load-pack}

.. _valid-store:

$${rule-prose: Instr_ok/store}

\

$${rule: Instr_ok/store-val}
$${rule: Instr_ok/store-pack}

.. _valid-vload:

$${rule-prose: Instr_ok/vload}

\

$${rule: Instr_ok/vload-val}
$${rule: Instr_ok/vload-pack}
$${rule: Instr_ok/vload-splat}
$${rule: Instr_ok/vload-zero}

.. _valid-vload_lane:

$${rule-prose: Instr_ok/vload_lane}

\

$${rule: Instr_ok/vload_lane}

.. _valid-vstore:

$${rule-prose: Instr_ok/vstore}

\

$${rule: Instr_ok/vstore}

.. _valid-vstore_lane:

$${rule-prose: Instr_ok/vstore_lane}

\

$${rule: Instr_ok/vstore_lane}


.. _valid-memory.size:

$${rule-prose: Instr_ok/memory.size}

\

$${rule: Instr_ok/memory.size}

.. _valid-memory.grow:

$${rule-prose: Instr_ok/memory.grow}

\

$${rule: Instr_ok/memory.grow}

.. _valid-memory.fill:

$${rule-prose: Instr_ok/memory.fill}

\

$${rule: Instr_ok/memory.fill}

.. _valid-memory.copy:

$${rule-prose: Instr_ok/memory.copy}

\

$${rule: Instr_ok/memory.copy}

.. _valid-memory.init:

$${rule-prose: Instr_ok/memory.init}

\

$${rule: Instr_ok/memory.init}

.. _valid-data.drop:

$${rule-prose: Instr_ok/data.drop}

\

$${rule: Instr_ok/data.drop}

.. _valid-instructions-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _valid-nop:

$${rule-prose: Instr_ok/nop}

\

$${rule: Instr_ok/nop}

.. _valid-unreachable:

$${rule-prose: Instr_ok/unreachable}

\

$${rule: Instr_ok/unreachable}

.. _valid-block:

$${rule-prose: Instr_ok/block}

\

$${rule: Instr_ok/block}

.. _valid-loop:

$${rule-prose: Instr_ok/loop}

\

$${rule: Instr_ok/loop}

.. _valid-if:

$${rule-prose: Instr_ok/if}

\

$${rule: Instr_ok/if}

.. _valid-br:

$${rule-prose: Instr_ok/br}

\

$${rule: Instr_ok/br}

.. _valid-br_if:

$${rule-prose: Instr_ok/br_if}

\

$${rule: Instr_ok/br_if}

.. _valid-br_table:

$${rule-prose: Instr_ok/br_table}

\

$${rule: Instr_ok/br_table}

.. _valid-br_on_null:

$${rule-prose: Instr_ok/br_on_null}

\

$${rule: Instr_ok/br_on_null}

.. _valid-br_on_non_null:

$${rule-prose: Instr_ok/br_on_non_null}

\

$${rule: Instr_ok/br_on_non_null}

.. _valid-br_on_cast:

$${rule-prose: Instr_ok/br_on_cast}

\

$${rule: Instr_ok/br_on_cast}

.. _valid-br_on_cast_fail:

TODO (typo in DSL typing rule)

\

$${rule: Instr_ok/br_on_cast_fail}

.. _valid-return:

$${rule-prose: Instr_ok/return}

\

$${rule: Instr_ok/return}

.. _valid-call:

$${rule-prose: Instr_ok/call}

\

$${rule: Instr_ok/call}

.. _valid-call_ref:

$${rule-prose: Instr_ok/call_ref}

\

$${rule+: Instr_ok/call_ref}


.. _valid-call_indirect:

$${rule-prose: Instr_ok/call_indirect}

\

$${rule+: Instr_ok/call_indirect}

.. _valid-return_call:

$${rule-prose: Instr_ok/return_call}

\

$${rule+: Instr_ok/return_call}

.. _valid-return_call_ref:

$${rule-prose: Instr_ok/return_call_ref}

\

$${rule+: Instr_ok/return_call_ref}

.. _valid-return_call_indirect:

$${rule-prose: Instr_ok/return_call_indirect}

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

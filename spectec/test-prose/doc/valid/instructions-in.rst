.. _valid-instructions:

Instructions
------------

$${rule+:
  Valtype_sub/*
  Resulttype_sub
}

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _valid-CONST:

%{prose-pred: CONST}

\

$${rule: Instr_ok/const}

.. _valid-UNOP:

%{prose-pred: UNOP}

\

$${rule: Instr_ok/unop}

.. _valid-BINOP:

%{prose-pred: BINOP}

\

$${rule: Instr_ok/binop}

.. _valid-TESTOP:

%{prose-pred: TESTOP}

\

$${rule: Instr_ok/testop}

.. _valid-RELOP:

%{prose-pred: RELOP}

\

$${rule: Instr_ok/relop}

.. _valid-EXTEND:

%{prose-pred: EXTEND}

\

$${rule: Instr_ok/extend}

.. _valid-CVTOP:

%{prose-pred: CVTOP}

\

$${rule+: 
  Instr_ok/reinterpret
  Instr_ok/convert-*
}

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _valid-REF.NULL:

%{prose-pred: REF.NULL}

\

$${rule: Instr_ok/ref.null}

.. _valid-REF.FUNC:

%{prose-pred: REF.FUNC}

\

$${rule: Instr_ok/ref.func}

.. _valid-REF.IS_NULL:

%{prose-pred: REF.IS_NULL}

\

$${rule: Instr_ok/ref.is_null}

.. _valid-REF.AS_NON_NULL:

%{prose-pred: REF.AS_NON_NULL}

\

$${rule: Instr_ok/ref.as_non_null}

.. _valid-REF.EQ:

%{prose-pred: REF.EQ}

\

$${rule: Instr_ok/ref.eq}

.. _valid-REF.TEST:

%{prose-pred: REF.TEST}

\

$${rule: Instr_ok/ref.test}

.. _valid-REF.CAST:

%{prose-pred: REF.CAST}

\

$${rule: Instr_ok/ref.cast}

.. _valid-instructions-aggregate-reference:

Aggregate Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-STRUCT.NEW:

%{prose-pred: STRUCT.NEW}

\

$${rule: Instr_ok/struct.new}

.. _valid-STRUCT.NEW_DEFAULT:

%{prose-pred: STRUCT.NEW_DEFAULT}

\

$${rule: Instr_ok/struct.new_default}

.. _valid-STRUCT.GET:

%{prose-pred: STRUCT.GET}

\

$${rule: Instr_ok/struct.get}

.. _valid-STRUCT.SET:

%{prose-pred: STRUCT.SET}

\

$${rule: Instr_ok/struct.set}

.. _valid-ARRAY.NEW:

%{prose-pred: ARRAY.NEW}

\

$${rule: Instr_ok/array.new}

.. _valid-ARRAY.NEW_DEFAULT:

%{prose-pred: ARRAY.NEW_DEFAULT}

\

$${rule: Instr_ok/array.new_default}

.. _valid-ARRAY.NEW_FIXED:

%{prose-pred: ARRAY.NEW_FIXED}

\

$${rule: Instr_ok/array.new_fixed}

.. _valid-ARRAY.NEW_ELEM:

%{prose-pred: ARRAY.NEW_ELEM}

\

$${rule: Instr_ok/array.new_elem}

.. _valid-ARRAY.NEW_DATA:

%{prose-pred: ARRAY.NEW_DATA}

\

$${rule: Instr_ok/array.new_data}

.. _valid-ARRAY.GET:

%{prose-pred: ARRAY.GET}

\

$${rule: Instr_ok/array.get}

.. _valid-ARRAY.SET:

%{prose-pred: ARRAY.SET}

\

$${rule: Instr_ok/array.set}

.. _valid-ARRAY.LEN:

%{prose-pred: ARRAY.LEN}

\

$${rule: Instr_ok/array.len}

.. _valid-ARRAY.FILL:

%{prose-pred: ARRAY.FILL}

\

$${rule: Instr_ok/array.fill}

.. _valid-ARRAY.COPY:

%{prose-pred: ARRAY.COPY}

\

$${rule: Instr_ok/array.copy}

.. _valid-ARRAY.INIT_DATA:

%{prose-pred: ARRAY.INIT_DATA}

\

$${rule: Instr_ok/array.init_data}

.. _valid-ARRAY.INIT_ELEM:

%{prose-pred: ARRAY.INIT_ELEM}

\

$${rule: Instr_ok/array.init_elem}

.. _valid-instructions-scalar-reference:

Scalar Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-REF.I31:

%{prose-pred: REF.I31}

\

$${rule: Instr_ok/ref.i31}

.. _valid-I31.GET:

%{prose-pred: I31.GET}

\

$${rule: Instr_ok/i31.get}

.. _valid-instructions-vector:

Vector Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-VVCONST:

%{prose-pred: VVCONST}

\

$${rule: Instr_ok/vvconst}

.. _valid-VVUNOP:

%{prose-pred: VVUNOP}

\

$${rule: Instr_ok/vvunop}

.. _valid-VVBINOP:

%{prose-pred: VVBINOP}

\

$${rule: Instr_ok/vvbinop}

.. _valid-VVTERNOP:

%{prose-pred: VVTERNOP}

\

$${rule: Instr_ok/vvternop}

.. _valid-VVTESTOP:

%{prose-pred: VVTESTOP}

\

$${rule: Instr_ok/vvtestop}

.. _valid-SHUFFLE:

%{prose-pred: SHUFFLE}

\

$${rule: Instr_ok/shuffle}

.. _valid-SPLAT:

%{prose-pred: SPLAT}

\

$${rule: Instr_ok/splat}

.. _valid-EXTRACT_LANE:

%{prose-pred: EXTRACT_LANE}

\

$${rule: Instr_ok/extract_lane}

.. _valid-REPLACE_LANE:

%{prose-pred: REPLACE_LANE}

\

$${rule: Instr_ok/replace_lane}

.. _valid-VUNOP:

%{prose-pred: VUNOP}

\

$${rule: Instr_ok/vunop}

.. _valid-VBINOP:

%{prose-pred: VBINOP}

\

$${rule: Instr_ok/vbinop}

.. _valid-VRELOP:

%{prose-pred: VRELOP}

\

$${rule: Instr_ok/vrelop}

.. _valid-VISHIFTOP:

%{prose-pred: VISHIFTOP}

\

$${rule: Instr_ok/vishiftop}

.. _valid-VTESTOP:

%{prose-pred: ALL_TRUE}

\

$${rule: Instr_ok/vtestop}

.. _valid-VCVTOP:

%{prose-pred: VCVTOP}

\

$${rule: Instr_ok/vcvtop}

.. _valid-NARROW:

%{prose-pred: NARROW}

\

$${rule: Instr_ok/narrow}

.. _valid-BITMASK:

%{prose-pred: BITMASK}

\

$${rule: Instr_ok/bitmask}

.. _valid-DOT:

%{prose-pred: DOT}

\

$${rule: Instr_ok/dot}

.. _valid-EXTMUL_HALF:

%{prose-pred: EXTMUL_HALF}

\

$${rule: Instr_ok/extmul_half}

.. _valid-EXTADD_PAIRWISE:

%{prose-pred: EXTADD_PAIRWISE}

\

$${rule: Instr_ok/extadd_pairwise}

.. _valid-instructions-external-reference:

External Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-EXTERN.CONVERT_ANY:

%{prose-pred: EXTERN.CONVERT_ANY}

\

$${rule: Instr_ok/extern.convert_any}

.. _valid-ANY.CONVERT_EXTERN:

%{prose-pred: ANY.CONVERT_EXTERN}

\

$${rule: Instr_ok/any.convert_extern}

.. _valid-instructions-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-DROP:

%{prose-pred: DROP}

\

$${rule: Instr_ok/drop}

.. _valid-SELECT:

%{prose-pred: SELECT}

\

$${rule+: Instr_ok/select-*}

.. _valid-instructions-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _valid-LOCAL.GET:

%{prose-pred: LOCAL.GET}

\

$${rule: Instr_ok/local.get}

.. _valid-LOCAL.SET:

LOCAL.SET
^^^^^^^^^

TODO (not found) 

\

$${rule+: Instrf_ok/local.set}

.. _valid-LOCAL.TEE:

LOCAL.TEE
^^^^^^^^^

TODO (not found)

\

$${rule+: Instrf_ok/local.tee}

.. _valid-GLOBAL.GET:

%{prose-pred: GLOBAL.GET}

\

$${rule: Instr_ok/global.get}

.. _valid-GLOBAL.SET:

%{prose-pred: GLOBAL.SET}

\

$${rule: Instr_ok/global.set}

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _valid-TABLE.GET:

%{prose-pred: TABLE.GET}

\

$${rule: Instr_ok/table.get}

.. _valid-TABLE.SET:

%{prose-pred: TABLE.SET}

\

$${rule: Instr_ok/table.set}

.. _valid-TABLE.SIZE:

%{prose-pred: TABLE.SIZE}

\

$${rule: Instr_ok/table.size}

.. _valid-TABLE.GROW:

%{prose-pred: TABLE.GROW}

\

$${rule: Instr_ok/table.grow}

.. _valid-TABLE.FILL:

%{prose-pred: TABLE.FILL}

\

$${rule: Instr_ok/table.fill}

.. _valid-TABLE.COPY:

%{prose-pred: TABLE.COPY}

\

$${rule: Instr_ok/table.copy}

.. _valid-TABLE.INIT:

%{prose-pred: TABLE.INIT}

\

$${rule: Instr_ok/table.init}

.. _valid-ELEM.DROP:

%{prose-pred: ELEM.DROP}

\

$${rule: Instr_ok/elem.drop}

.. _valid-instructions-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _valid-LOAD:

%{prose-pred: LOAD}

\

$${rule: Instr_ok/load}

.. _valid-STORE:

%{prose-pred: STORE}

\

$${rule: Instr_ok/store}

.. _valid-VLOAD:

%{prose-pred: VLOAD}

\

$${rule: Instr_ok/vload}

.. _valid-VLOAD_SPLAT:

%{prose-pred: VLOAD_SPLAT}

\

$${rule: Instr_ok/vload_splat}

.. _valid-VLOAD_ZERO:

%{prose-pred: VLOAD_ZERO}

\

$${rule: Instr_ok/vload_zero}

.. _valid-VSTORE:

%{prose-pred: VSTORE}

\

$${rule: Instr_ok/vstore}

.. _valid-VLOAD_LANE:

%{prose-pred: VLOAD_LANE}

\

$${rule: Instr_ok/vload_lane}

.. _valid-MEMORY.SIZE:

%{prose-pred: MEMORY.SIZE}

\

$${rule: Instr_ok/memory.size}

.. _valid-MEMORY.GROW:

%{prose-pred: MEMORY.GROW}

\

$${rule: Instr_ok/memory.grow}

.. _valid-MEMORY.FILL:

%{prose-pred: MEMORY.FILL}

\

$${rule: Instr_ok/memory.fill}

.. _valid-MEMORY.COPY:

%{prose-pred: MEMORY.COPY}

\

$${rule: Instr_ok/memory.copy}

.. _valid-MEMORY.INIT:

%{prose-pred: MEMORY.INIT}

\

$${rule: Instr_ok/memory.init}

.. _valid-DATA.DROP:

%{prose-pred: DATA.DROP}

\

$${rule: Instr_ok/data.drop}

.. _valid-instructions-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _valid-NOP:

%{prose-pred: NOP}

\

$${rule: Instr_ok/nop}

.. _valid-UNREACHABLE:

%{prose-pred: UNREACHABLE}

\

$${rule: Instr_ok/unreachable}

.. _valid-BLOCK:

%{prose-pred: BLOCK}

\

$${rule: Instr_ok/block}

.. _valid-LOOP:

%{prose-pred: LOOP}

\

$${rule: Instr_ok/loop}

.. _valid-IF:

%{prose-pred: IF}

\

$${rule: Instr_ok/if}

.. _valid-BR:

%{prose-pred: BR}

\

$${rule: Instr_ok/br}

.. _valid-BR_IF:

%{prose-pred: BR_IF}

\

$${rule: Instr_ok/br_if}

.. _valid-BR_TABLE:

%{prose-pred: BR_TABLE}

\

$${rule: Instr_ok/br_table}

.. _valid-BR_ON_NULL:

%{prose-pred: BR_ON_NULL}

\

$${rule: Instr_ok/br_on_null}

.. _valid-BR_ON_NON_NULL:

%{prose-pred: BR_ON_NON_NULL}

\

$${rule: Instr_ok/br_on_non_null}

.. _valid-BR_ON_CAST:

%{prose-pred: BR_ON_CAST}

\

$${rule: Instr_ok/br_on_cast}

.. _valid-BR_ON_CAST_FAIL:

TODO (typo in DSL typing rule)

\

$${rule: Instr_ok/br_on_cast_fail}

.. _valid-RETURN:

%{prose-pred: RETURN}

\

$${rule: Instr_ok/return}

.. _valid-CALL:

%{prose-pred: CALL}

\

$${rule: Instr_ok/call}

.. _valid-CALL_REF:

%{prose-pred: CALL_REF}

\

$${rule+: Instr_ok/call_ref}


.. _valid-CALL_INDIRECT:

%{prose-pred: CALL_INDIRECT}

\

$${rule+: Instr_ok/call_indirect}

.. _valid-RETURN_CALL:

%{prose-pred: RETURN_CALL}

\

$${rule+: Instr_ok/return_call}

.. _valid-RETURN_CALL_REF:

%{prose-pred: RETURN_CALL_REF}

\

$${rule+: Instr_ok/return_call_ref}

.. _valid-RETURN_CALL_INDIRECT:

%{prose-pred: RETURN_CALL_INDIRECT}

\

$${rule+: Instr_ok/return_call_indirect}

.. _valid-instructions-sequences:

Instruction Sequences
~~~~~~~~~~~~~~~~~~~~~

$${rule+:
  Instrf_ok/instr
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

%{prose-func: in_binop}

\

$${definition: in_binop}

.. _def-in_numtype:

%{prose-func: in_numtype}

\

$${definition: in_numtype}

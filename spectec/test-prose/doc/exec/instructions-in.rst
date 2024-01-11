.. _exec-instructions:

Instructions
------------

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-UNOP:

%{prose-algo: UNOP}

\

$${rule+: Step_pure/unop-*}

.. _exec-BINOP:

%{prose-algo: BINOP}

\

$${rule+: Step_pure/binop-*}

.. _exec-TESTOP:

%{prose-algo: TESTOP}

\

$${rule: Step_pure/testop}

.. _exec-RELOP:

%{prose-algo: RELOP}

\

$${rule: Step_pure/relop}

.. _exec-EXTEND:

%{prose-algo: EXTEND}

\

$${rule: Step_pure/extend}

.. _exec-CVTOP:

%{prose-algo: CVTOP}

\

$${rule+: Step_pure/cvtop-*}

Vector Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-VVUNOP:

%{prose-algo: VVUNOP}

\

$${rule+: Step_pure/vvunop}

.. _exec-VVBINOP:

%{prose-algo: VVBINOP}

\

$${rule+: Step_pure/vvbinop}

.. _exec-VVTERNOP:

%{prose-algo: VVTERNOP}

\

$${rule+: Step_pure/vvternop}

.. _exec-VVTESTOP:

%{prose-algo: VVTESTOP}

\

$${rule+: Step_pure/vvtestop}

.. _exec-SHUFFLE:

%{prose-algo: SHUFFLE}

\

$${rule+: Step_pure/shuffle}

.. _exec-SPLAT:

%{prose-algo: SPLAT}

\

$${rule+: Step_pure/splat}

.. _exec-EXTRACT_LANE:

%{prose-algo: EXTRACT_LANE}

\

$${rule+: Step_pure/extract_lane-*}

.. _exec-REPLACE_LANE:

%{prose-algo: REPLACE_LANE}

\

$${rule+: Step_pure/replace_lane}

.. _exec-VUNOP:

%{prose-algo: VUNOP}

\

$${rule+: Step_pure/vunop}

.. _exec-VBINOP:

%{prose-algo: VBINOP}

\

$${rule+: Step_pure/vbinop-*}

.. _exec-VRELOP:

%{prose-algo: VRELOP}

\

$${rule+: Step_pure/vrelop}

.. _exec-VISHIFTOP:

%{prose-algo: VISHIFTOP}

\

$${rule+: Step_pure/vishiftop}

.. _exec-ALL_TRUE:

%{prose-algo: ALL_TRUE}

\

$${rule+: Step_pure/all_true-*}

.. _exec-BITMASK:

%{prose-algo: BITMASK}

\

$${rule+: Step_pure/bitmask}

.. _exec-NARROW:

%{prose-algo: NARROW}

\

$${rule+: Step_pure/narrow}

.. _exec-VCVTOP:

TODO (too deeply nested)

\

$${rule+: Step_pure/vcvtop-*}

.. _exec-DOT:

%{prose-algo: DOT}

\

$${rule+: Step_pure/dot}

.. _exec-EXTMUL_HALF:

%{prose-algo: EXTMUL_HALF}

\

$${rule+: Step_pure/extmul_half}

.. _exec-EXTADD_PAIRWISE:

%{prose-algo: EXTADD_PAIRWISE}

\

$${rule+: Step_pure/extadd_pairwise}

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _exec-REF.FUNC:

%{prose-algo: REF.FUNC}

\

$${rule+: Step_read/ref.func}

.. _exec-REF.IS_NULL:

%{prose-algo: REF.IS_NULL}

\

$${rule+: Step_pure/ref.is_null-*}

.. _exec-REF.AS_NON_NULL:

%{prose-algo: REF.AS_NON_NULL}

\

$${rule+: Step_pure/ref.as_non_null-*}

.. _exec-REF.EQ:

%{prose-algo: REF.EQ}

\

$${rule+: Step_pure/ref.eq-*}

.. _exec-REF.TEST:

%{prose-algo: REF.TEST}

\

$${rule+: Step_read/ref.test-*}

.. _exec-REF.CAST:

%{prose-algo: REF.CAST}

\

$${rule: Step_read/ref.cast-*}

.. _exec-REF.I31:

%{prose-algo: REF.I31}

\

$${rule+: Step_pure/ref.i31}

.. _exec-I31.GET:

%{prose-algo: I31.GET}

\

$${rule+: Step_pure/i31.get-*}

.. _def-ext_structinst:

%{prose-func: ext_structinst}

\

$${definition: ext_structinst}

.. _exec-STRUCT.NEW:

%{prose-algo: STRUCT.NEW}

\

$${rule+: Step/struct.new}

.. _exec-STRUCT.NEW_DEFAULT:

%{prose-algo: STRUCT.NEW_DEFAULT}

\

$${rule+: Step_read/struct.new_default}

.. _exec-STRUCT.GET:

STRUCT.GET
^^^^^^^^^^

TODO (too deeply nested)

\

$${rule+: Step_read/struct.get-*}

.. _exec-STRUCT.SET:

%{prose-algo: STRUCT.SET}

\

$${rule+: Step/struct.set-*}

.. _exec-ARRAY.NEW:

%{prose-algo: ARRAY.NEW}

\

$${rule+: Step_read/array.new}

.. _exec-ARRAY.NEW_DEFAULT:

%{prose-algo: ARRAY.NEW_DEFAULT}

\

$${rule+: Step_read/array.new_default}

.. _def-ext_arrayinst:

%{prose-func: ext_arrayinst}

\

$${definition: ext_arrayinst}

.. _exec-ARRAY.NEW_FIXED:

%{prose-algo: ARRAY.NEW_FIXED}

\

$${rule+: Step/array.new_fixed}

.. _exec-ARRAY.NEW_ELEM:

%{prose-algo: ARRAY.NEW_ELEM}

\

$${rule+: Step_read/array.new_elem-*}

.. _def-concat_bytes:

%{prose-func: concat_bytes}

\

$${definition: concat_bytes}

.. _exec-ARRAY.NEW_DATA:

%{prose-algo: ARRAY.NEW_DATA}

\

$${rule+: Step_read/array.new_data-*}

.. _exec-ARRAY.GET:

%{prose-algo: ARRAY.GET}

\

$${rule+: Step_read/array.get-*}

.. _exec-ARRAY.SET:

%{prose-algo: ARRAY.SET}

\

$${rule+: Step/array.set-*}

.. _exec-ARRAY.LEN:

%{prose-algo: ARRAY.LEN}

\

$${rule+: Step_read/array.len-*}

.. _exec-ARRAY.FILL:

%{prose-algo: ARRAY.FILL}

\

$${rule+: Step_read/array.fill-*}

.. _exec-ARRAY.COPY:

ARRAY.COPY
^^^^^^^^^^

TODO (too deeply nested)

\

$${rule+: Step_read/array.copy-*}

.. _exec-ARRAY.INIT_ELEM:

%{prose-algo: ARRAY.INIT_ELEM}

\

$${rule+: Step_read/array.init_elem-*}

.. _exec-ARRAY.INIT_DATA:

%{prose-algo: ARRAY.INIT_DATA}

\

$${rule+: Step_read/array.init_data-*}

.. _exec-EXTERN.CONVERT_ANY:

%{prose-algo: EXTERN.CONVERT_ANY}

\

$${rule+: Step_pure/extern.convert_any-*}

.. _exec-ANY.CONVERT_EXTERN:

%{prose-algo: ANY.CONVERT_EXTERN}

\

$${rule+: Step_pure/any.convert_extern-*}

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _exec-DROP:

%{prose-algo: DROP}

\

$${rule: Step_pure/drop}

.. _exec-SELECT:

%{prose-algo: SELECT}

\

$${rule+: Step_pure/select-*}

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _exec-LOCAL.GET:

%{prose-algo: LOCAL.GET}

\

$${rule: Step_read/local.get}

.. _exec-LOCAL.SET:

%{prose-algo: LOCAL.SET}

\

$${rule: Step/local.set}

.. _exec-LOCAL.TEE:

%{prose-algo: LOCAL.TEE}

\

$${rule: Step_pure/local.tee}

.. _exec-GLOBAL.GET:

%{prose-algo: GLOBAL.GET}

\

$${rule: Step_read/global.get}

.. _exec-GLOBAL.SET:

%{prose-algo: GLOBAL.SET}

\

$${rule: Step/global.set}

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _exec-TABLE.GET:

%{prose-algo: TABLE.GET}

\

$${rule+: Step_read/table.get-*}

.. _exec-TABLE.SET:

%{prose-algo: TABLE.SET}

\

$${rule+: Step/table.set-*}

.. _exec-TABLE.SIZE:

%{prose-algo: TABLE.SIZE}

\

$${rule: Step_read/table.size}

.. _exec-TABLE.GROW:

%{prose-algo: TABLE.GROW}

\

$${rule: Step/table.grow-*}

.. _exec-TABLE.FILL:

%{prose-algo: TABLE.FILL}

\

$${rule+: Step_read/table.fill-*}

.. _exec-TABLE.COPY:

%{prose-algo: TABLE.COPY}

\

$${rule+: Step_read/table.copy-*}

.. _exec-TABLE.INIT:

%{prose-algo: TABLE.INIT}

\

$${rule+: Step_read/table.init-*}

.. _exec-ELEM.DROP:

%{prose-algo: ELEM.DROP}

\

$${rule: Step/elem.drop}

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _exec-LOAD:

%{prose-algo: LOAD}

\

$${rule+: Step_read/load-*}

.. _exec-STORE:

%{prose-algo: STORE}

\

$${rule+: Step/store-*}

.. _exec-MEMORY.SIZE:

%{prose-algo: MEMORY.SIZE}

\

$${rule: Step_read/memory.size}

.. _exec-MEMORY.GROW:

%{prose-algo: MEMORY.GROW}

\

$${rule+: Step/memory.grow-*}

.. _exec-MEMORY.FILL:

%{prose-algo: MEMORY.FILL}

\

$${rule+: Step_read/memory.fill-*}

.. _exec-MEMORY.COPY:

%{prose-algo: MEMORY.COPY}

\

$${rule+: Step_read/memory.copy-*}

.. _exec-MEMORY.INIT:

%{prose-algo: MEMORY.INIT}

\

$${rule+: Step_read/memory.init-*}

.. _exec-DATA.DROP:

%{prose-algo: DATA.DROP}

\

$${rule: Step/data.drop}

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-NOP:

%{prose-algo: NOP}

\

$${rule: Step_pure/nop}

.. _exec-UNREACHABLE:

%{prose-algo: UNREACHABLE}

\

$${rule: Step_pure/unreachable}

.. _def-blocktype:

%{prose-func: blocktype}

\

$${definition: blocktype}

.. _exec-BLOCK:

%{prose-algo: BLOCK}

\

$${rule+: Step_read/block}

.. _exec-LOOP:

%{prose-algo: LOOP}

\

$${rule+: Step_read/loop}

.. _exec-IF:

%{prose-algo: IF}

\

$${rule+: Step_pure/if-*}

.. _exec-BR:

%{prose-algo: BR}

\

$${rule+: Step_pure/br-*}

.. _exec-BR_IF:

%{prose-algo: BR_IF}

\

$${rule+: Step_pure/br_if-*}

.. _exec-BR_TABLE:

%{prose-algo: BR_TABLE}

\

$${rule+: Step_pure/br_table-*}

.. _exec-BR_ON_NULL:

%{prose-algo: BR_ON_NULL}

\

$${rule+: Step_pure/br_on_null-*}

.. _exec-BR_ON_NON_NULL:

%{prose-algo: BR_ON_NON_NULL}

\

$${rule+: Step_pure/br_on_non_null-*}

.. _exec-BR_ON_CAST:

%{prose-algo: BR_ON_CAST}

\

$${rule+: Step_read/br_on_cast-*}

.. _exec-BR_ON_CAST_FAIL:

%{prose-algo: BR_ON_CAST_FAIL}

\

$${rule+: Step_read/br_on_cast_fail-*}

.. _exec-RETURN:

%{prose-algo: RETURN}

\

$${rule+: Step_pure/return-*}

.. _exec-CALL:

%{prose-algo: CALL}

\

$${rule: Step_read/call}

CALL_REF
^^^^^^^^

TODO (too deeply nested)

\

$${rule+: Step_read/call_ref-*}

.. _exec-CALL_INDIRECT:

%{prose-algo: CALL_INDIRECT}

\

$${rule+: Step_pure/call_indirect-*}

.. _exec-RETURN_CALL:

%{prose-algo: RETURN_CALL}

\

$${rule+: Step_read/return_call}

RETURN_CALL_REF
^^^^^^^^^^^^^^^

TODO (too deeply nested)

\

$${rule+: Step_read/return_call_ref-*}

.. _exec-RETURN_CALL_INDIRECT:

%{prose-algo: RETURN_CALL_INDIRECT}

\

$${rule+: Step_pure/return_call_indirect}

Blocks
~~~~~~

.. _exec-LABEL_:

%{prose-algo: LABEL_}

\

$${rule+: Step_pure/label-vals}

Function Calls
~~~~~~~~~~~~~~

.. _exec-FRAME_:

%{prose-algo: FRAME_}

\

$${rule+: Step_pure/frame-vals}

Expressions
~~~~~~~~~~~

$${rule: Eval_expr}

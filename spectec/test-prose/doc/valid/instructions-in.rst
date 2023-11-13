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

.. _valid-REF.IS_NULL:

%{prose-pred: REF.IS_NULL}

\

$${rule: Instr_ok/ref.is_null}

.. _valid-REF.FUNC:

%{prose-pred: REF.FUNC}

\

$${rule: Instr_ok/ref.func}

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

%{prose-pred: LOCAL.SET}

\

$${rule: Instr_ok/local.set}

.. _valid-LOCAL.TEE:

%{prose-pred: LOCAL.TEE}

\

$${rule: Instr_ok/local.tee}

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

.. _valid-RETURN:

%{prose-pred: RETURN}

\

$${rule: Instr_ok/return}

.. _valid-CALL:

%{prose-pred: CALL}

\

$${rule: Instr_ok/call}

.. _valid-CALL_INDIRECT:

%{prose-pred: CALL_INDIRECT}

\

$${rule: Instr_ok/call_indirect}

Instruction Sequences
~~~~~~~~~~~~~~~~~~~~~

$${rule+:
  InstrSeq_ok/*
}

Expressions
~~~~~~~~~~~

$${rule+: 
  Expr_ok
  Expr_const
  Expr_ok_const
  Instr_const/*
}

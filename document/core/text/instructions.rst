.. index:: instruction
.. _text-instr:
.. _text-instrs:

Instructions
------------

Instructions are syntactically distinguished into *plain* and *structured* instructions.

$${grammar: {Tinstr_ Tinstrs_/unfolded}}

In addition, as a syntactic abbreviation, instructions can be written as S-expressions in :ref:`folded <text-foldedinstr>` form, to group them visually.


.. index:: index, label index
   pair: text format; label index
.. _text-label:

Labels
~~~~~~

:ref:`Structured control instructions <text-instr-control>` can be annotated with a symbolic :ref:`label identifier <text-id>`.
They are the only :ref:`symbolic identifiers <text-index>` that can be bound locally in an instruction sequence.
The following grammar handles the corresponding update to the :ref:`identifier context <text-context>` by :ref:`composing <notation-compose>` the context with an additional label entry.

$${grammar: Tlabel_}

.. note::
   The new label entry is inserted at the *beginning* of the label list in the identifier context.
   This effectively shifts all existing labels up by one,
   mirroring the fact that control instructions are indexed relatively not absolutely.

   If a label with the same name already exists,
   then it is shadowed and the earlier label becomes inaccessible.


.. index:: parametric instruction, value type, polymorphism
   pair: text format; instruction
.. _text-instr-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _text-drop:
.. _text-select:

$${grammar: Tplaininstr_/parametric}


.. index:: control instructions, structured control, label, block, branch, result type, label index, function index, tag index, type index, list, polymorphism, reference
   pair: text format; instruction
.. _text-blockinstr:
.. _text-plaininstr:
.. _text-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _text-blocktype:
.. _text-block:
.. _text-loop:
.. _text-if:
.. _text-instr-block:
.. _text-try_table:
.. _text-catch:

:ref:`Structured control instructions <syntax-instr-control>` can bind an optional symbolic :ref:`label identifier <text-label>`.
The same label identifier may optionally be repeated after the corresponding ${grammar-case: "end"} or ${grammar-case: "else"} keywords, to indicate the matching delimiters.

Their :ref:`block type <syntax-blocktype>` is given as a :ref:`type use <text-typeuse>`, analogous to the type of :ref:`functions <text-func>`.
However, the special case of a type use that is syntactically empty or consists of only a single :ref:`result <text-result>` is not regarded as an :ref:`abbreviation <text-typeuse-abbrev>` for an inline :ref:`function type <syntax-functype>`, but is parsed directly into an optional :ref:`value type <syntax-valtype>`.

$${grammar: Tblocktype_ Tblockinstr_/plain Tcatch_}

.. note::
   The side condition stating that the :ref:`identifier context <text-context>` ${idctxt: I'} must only contain unnamed entries in the rule for ${grammar-case: Ttypeuse} block types enforces that no identifier can be bound in any ${grammar-case: Tparam} declaration for a block type.


.. _text-nop:
.. _text-unreachable:
.. _text-br:
.. _text-br_if:
.. _text-br_table:
.. _text-br_on_null:
.. _text-br_on_non_null:
.. _text-br_on_cast:
.. _text-br_on_cast_fail:
.. _text-return:
.. _text-call:
.. _text-call_ref:
.. _text-call_indirect:
.. _text-return_call:
.. _text-return_call_indirect:
.. _text-throw:
.. _text-throw_ref:

All other control instruction are represented verbatim.

.. note::
   The side condition stating that the :ref:`identifier context <text-context>` ${idctxt: I'} must only contain unnamed entries in the rule for |CALLINDIRECT| enforces that no identifier can be bound in any |Tparam| declaration appearing in the type annotation.


Abbreviations
.............

The ${grammar-case: "else"} keyword of an ${grammar-case: "if"} instruction can be omitted if the following instruction sequence is empty.

$${grammar: Tblockinstr_/abbrev}

Also, for backwards compatibility, the table index to ${grammar-case: "call_indirect"} and ${grammar-case: "return_call_indirect"} can be omitted, defaulting to ${:0}.

$${grammar: Tplaininstr_/func-abbrev}


.. index:: variable instructions, local index, global index
   pair: text format; instruction
.. _text-instr-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _text-local.get:
.. _text-local.set:
.. _text-local.tee:
.. _text-global.get:
.. _text-global.set:

$${grammar: {Tplaininstr_/local Tplaininstr_/global}}


.. index:: table instruction, table index
   pair: text format; instruction
.. _text-instr-table:

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _text-table.get:
.. _text-table.set:
.. _text-table.size:
.. _text-table.grow:
.. _text-table.fill:
.. _text-table.copy:
.. _text-table.init:
.. _text-elem.drop:

$${grammar: {Tplaininstr_/table-plain Tplaininstr_/elem}}


Abbreviations
.............

For backwards compatibility, all :ref:`table indices <syntax-tableidx>` may be omitted from table instructions, defaulting to ${:0}.

$${grammar: Tplaininstr_/table-abbrev}


.. index:: memory instruction, memory index
   pair: text format; instruction
.. _text-instr-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _text-memarg:
.. _text-laneidx:
.. _text-load:
.. _text-loadn:
.. _text-store:
.. _text-storen:
.. _text-memory.size:
.. _text-memory.grow:
.. _text-memory.fill:
.. _text-memory.copy:
.. _text-memory.init:
.. _text-data.drop:

The offset and alignment immediates to memory instructions are optional.
The offset defaults to ${:0}, the alignment to the storage size of the respective memory access, which is its *natural alignment*.
Lexically, an ${grammar-case: Toffset} or ${grammar-case: Talign_} phrase is considered a single :ref:`keyword token <text-keyword>`, so no :ref:`white space <text-space>` is allowed around the ${grammar-case: "="}.

$${grammar: {Tmemarg_ Toffset Talign_ Tlaneidx Tplaininstr_/memory-plain Tplaininstr_/data}}


Abbreviations
.............

As an abbreviation, the memory index can be omitted in all memory instructions, defaulting to ${:0}.

$${grammar: Tplaininstr_/memory-abbrev}


.. index:: reference instruction
   pair: text format; instruction
.. _text-instr-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _text-ref.null:
.. _text-ref.func:
.. _text-ref.is_null:
.. _text-ref.as_non_null:
.. _text-ref.test:
.. _text-ref.cast:

$${grammar: {Tplaininstr_/ref}}


.. index:: aggregate instruction
   pair: text format; instruction
.. _text-instr-aggr:

Aggregate Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _text-ref.i31:
.. _text-i31.get_s:
.. _text-i31.get_u:
.. _text-struct.new:
.. _text-struct.new_default:
.. _text-struct.get:
.. _text-struct.get_s:
.. _text-struct.get_u:
.. _text-struct.set:
.. _text-array.new:
.. _text-array.new_default:
.. _text-array.new_fixed:
.. _text-array.new_elem:
.. _text-array.new_data:
.. _text-array.get:
.. _text-array.get_s:
.. _text-array.get_u:
.. _text-array.set:
.. _text-array.len:
.. _text-array.fill:
.. _text-array.copy:
.. _text-array.init_data:
.. _text-array.init_elem:
.. _text-any.convert_extern:
.. _text-extern.convert_any:

$${grammar: {Tplaininstr_/i31 Tplaininstr_/struct Tplaininstr_/array Tplaininstr_/extern}}


.. index:: numeric instruction
   pair: text format; instruction
.. _text-instr-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _text-const:

$${grammar: Tplaininstr_/num-const}

.. _text-testop:
.. _text-relop:
.. _text-unop:
.. _text-binop:

$${grammar: {
  Tplaininstr_/num-test-i32
  Tplaininstr_/num-rel-i32
  Tplaininstr_/num-un-i32
  Tplaininstr_/num-bin-i32
}}

$${grammar: {
  Tplaininstr_/num-test-i64
  Tplaininstr_/num-rel-i64
  Tplaininstr_/num-un-i64
  Tplaininstr_/num-bin-i64
}}

$${grammar: {
  Tplaininstr_/num-rel-f32
  Tplaininstr_/num-un-f32
  Tplaininstr_/num-bin-f32
}}

$${grammar: {
  Tplaininstr_/num-rel-f64
  Tplaininstr_/num-un-f64
  Tplaininstr_/num-bin-f64
}}

.. _text-cvtop:

$${grammar: {
  Tplaininstr_/num-cvt-i32
  Tplaininstr_/num-cvt-i64
  Tplaininstr_/num-cvt-f32
  Tplaininstr_/num-cvt-f64
  Tplaininstr_/num-cvt-reinterpret
}}


.. index:: vector instruction
   pair: text format; instruction
.. _text-instr-vec:

Vector Instructions
~~~~~~~~~~~~~~~~~~~

Vector constant instructions have a mandatory :ref:`shape <syntax-shape>` descriptor, which determines how the following values are parsed.

$${grammar: Tplaininstr_/vec-const}

$${grammar: {
  Tplaininstr_/vec-shuffle
  Tplaininstr_/vec-splat
  Tplaininstr_/vec-lane
}}


.. _text-vvunop:
.. _text-vvbinop:
.. _text-vvternop:
.. _text-vitestop:
.. _text-virelop:
.. _text-vfrelop:
.. _text-viunop:
.. _text-vfunop:
.. _text-vibinop:
.. _text-vfbinop:
.. _text-vishiftop:

$${grammar: {
  Tplaininstr_/vec-test-v128
  Tplaininstr_/vec-un-v128
  Tplaininstr_/vec-bin-v128
  Tplaininstr_/vec-tern-v128
}}

$${grammar: {
  Tplaininstr_/vec-test-i8x16
  Tplaininstr_/vec-rel-i8x16
  Tplaininstr_/vec-un-i8x16
  Tplaininstr_/vec-bin-i8x16
  Tplaininstr_/vec-tern-i8x16
  Tplaininstr_/vec-shift-i8x16
  Tplaininstr_/vec-bitmask-i8x16
  Tplaininstr_/vec-narrow-i8x16
}}

$${grammar: {
  Tplaininstr_/vec-test-i16x8
  Tplaininstr_/vec-rel-i16x8
  Tplaininstr_/vec-un-i16x8
  Tplaininstr_/vec-bin-i16x8
  Tplaininstr_/vec-tern-i16x8
  Tplaininstr_/vec-shift-i16x8
  Tplaininstr_/vec-bitmask-i16x8
  Tplaininstr_/vec-narrow-i16x8
}}

$${grammar: {
  Tplaininstr_/vec-test-i32x4
  Tplaininstr_/vec-rel-i32x4
  Tplaininstr_/vec-un-i32x4
  Tplaininstr_/vec-bin-i32x4
  Tplaininstr_/vec-tern-i32x4
  Tplaininstr_/vec-shift-i32x4
  Tplaininstr_/vec-bitmask-i32x4
  Tplaininstr_/vec-narrow-i32x4
}}

$${grammar: {
  Tplaininstr_/vec-test-i64x2
  Tplaininstr_/vec-rel-i64x2
  Tplaininstr_/vec-un-i64x2
  Tplaininstr_/vec-bin-i64x2
  Tplaininstr_/vec-tern-i64x2
  Tplaininstr_/vec-shift-i64x2
  Tplaininstr_/vec-bitmask-i64x2
}}

$${grammar: {
  Tplaininstr_/vec-rel-f32x4
  Tplaininstr_/vec-un-f32x4
  Tplaininstr_/vec-bin-f32x4
  Tplaininstr_/vec-tern-f32x4
}}

$${grammar: {
  Tplaininstr_/vec-rel-f64x2
  Tplaininstr_/vec-un-f64x2
  Tplaininstr_/vec-bin-f64x2
  Tplaininstr_/vec-tern-f64x2
}}

$${grammar: {
  Tplaininstr_/vec-cvt-i16x8
  Tplaininstr_/vec-cvt-i32x4
  Tplaininstr_/vec-cvt-i64x2
  Tplaininstr_/vec-cvt-f32x4
  Tplaininstr_/vec-cvt-f64x2
}}

$${grammar: {
  Tplaininstr_/vec-extun-i16x8
  Tplaininstr_/vec-extbin-i16x8
  Tplaininstr_/vec-extun-i32x4
  Tplaininstr_/vec-extbin-i32x4
  Tplaininstr_/vec-extbin-i64x2
}}


.. index:: ! folded instruction, S-expression
.. _text-foldedinstr:

Folded Instructions
~~~~~~~~~~~~~~~~~~~

Instructions can be written as S-expressions by grouping them into *folded* form. In that notation, an instruction is wrapped in parentheses and optionally includes nested folded instructions to indicate its operands.

In the case of :ref:`block instructions <text-instr-block>`, the folded form omits the ${grammar-case: "end"} delimiter.
For ${:IF} instructions, both branches have to be wrapped into nested S-expressions, headed by the keywords ${grammar-case: "then"} and ${grammar-case: "else"}.

The set of all phrases defined by the following abbreviations recursively forms the auxiliary syntactic class ${grammar-case: Tfoldedinstr}.
Such a folded instruction can appear anywhere a regular instruction can.

.. MathJax doesn't handle LaTex multicolumns, thus the spacing hack in the following formula.

$${grammar: Tfoldedinstr_}

.. note::
   For example, the instruction sequence

   .. math::
      \mathtt{(local.get~\$x)~(i32.const~2)~i32.add~(i32.const~3)~i32.mul}

   can be folded into

   .. math::
      \mathtt{(i32.mul~(i32.add~(local.get~\$x)~(i32.const~2))~(i32.const~3))}

   Folded instructions are solely syntactic sugar,
   no additional syntactic or type-based checking is implied.


.. index:: expression
   pair: text format; expression
   single: expression; constant
.. _text-expr:

Expressions
~~~~~~~~~~~

Expressions are written as instruction sequences.

$${grammar: Texpr_}

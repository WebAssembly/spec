.. index:: instruction, ! opcode
.. _binary-instr:

Instructions
------------

:ref:`Instructions <syntax-instr>` are encoded by *opcodes*.
Each opcode is represented by a single byte,
and is followed by the instruction's immediate arguments, where present.
The only exception are :ref:`structured control instructions <binary-instr-control>`, which consist of several opcodes bracketing their nested instruction sequences.

.. note::
   Gaps in the byte code ranges for encoding instructions are reserved for future extensions.


.. index:: control instructions, structured control, exception handling, label, block, branch, result type, value type, block type, label index, function index, tag index, type index, list, polymorphism, LEB128
   pair: binary format; instruction
   pair: binary format; block type
.. _binary-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

:ref:`Control instructions <syntax-instr-control>` have varying encodings. For structured instructions, the instruction sequences forming nested blocks are delimited with explicit opcodes for ${:END} and ${:ELSE}.

:ref:`Block types <syntax-blocktype>` are encoded in special compressed form, by either the byte ${:0x40} indicating the empty type, as a single :ref:`value type <binary-valtype>`, or as a :ref:`type index <binary-typeidx>` encoded as a positive :ref:`signed integer <binary-sint>`.

.. _binary-blocktype:
.. _binary-nop:
.. _binary-unreachable:
.. _binary-block:
.. _binary-loop:
.. _binary-if:
.. _binary-br:
.. _binary-br_if:
.. _binary-br_table:
.. _binary-return:
.. _binary-call:
.. _binary-call_ref:
.. _binary-call_indirect:
.. _binary-return_call:
.. _binary-return_call_ref:
.. _binary-return_call_indirect:
.. _binary-throw:
.. _binary-throw_ref:
.. _binary-try_table:
.. _binary-catch:

$${grammar: Bblocktype Binstr/control Bcatch}

.. note::
   The ${:ELSE} opcode ${:0x05} in the encoding of an ${:IF} instruction can be omitted if the following instruction sequence is empty.

   Unlike any :ref:`other occurrence <binary-typeidx>`, the :ref:`type index <syntax-typeidx>` in a :ref:`block type <syntax-blocktype>` is encoded as a positive :ref:`signed integer <syntax-sint>`, so that its |SignedLEB128| bit pattern cannot collide with the encoding of :ref:`value types <binary-valtype>` or the special code ${:0x40}, which correspond to the LEB128 encoding of negative integers.
   To avoid any loss in the range of allowed indices, it is treated as a 33 bit signed integer.


.. index:: reference instruction
   pair: binary format; instruction
.. _binary-instr-ref:
.. _binary-br_on_null:
.. _binary-br_on_non_null:
.. _binary-br_on_cast:
.. _binary-br_on_cast_fail:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

Generic :ref:`reference instructions <syntax-instr-ref>` are represented by single byte codes, others use prefixes and type operands.

.. _binary-ref.null:
.. _binary-ref.func:
.. _binary-ref.is_null:
.. _binary-ref.as_non_null:
.. _binary-struct.new:
.. _binary-struct.new_default:
.. _binary-struct.get:
.. _binary-struct.get_s:
.. _binary-struct.get_u:
.. _binary-struct.set:
.. _binary-array.new:
.. _binary-array.new_default:
.. _binary-array.new_fixed:
.. _binary-array.new_elem:
.. _binary-array.new_data:
.. _binary-array.get:
.. _binary-array.get_s:
.. _binary-array.get_u:
.. _binary-array.set:
.. _binary-array.len:
.. _binary-array.fill:
.. _binary-array.copy:
.. _binary-array.init_data:
.. _binary-array.init_elem:
.. _binary-ref.i31:
.. _binary-i31.get_s:
.. _binary-i31.get_u:
.. _binary-ref.test:
.. _binary-ref.cast:
.. _binary-any.convert_extern:
.. _binary-extern.convert_any:
.. _binary-castop:

$${grammar: {Binstr/ref Binstr/struct Binstr/array Binstr/cast Binstr/extern Binstr/i31} Bcastop}
$${syntax-ignore: castop}

.. index:: parametric instruction, value type, polymorphism
   pair: binary format; instruction
.. _binary-instr-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

:ref:`Parametric instructions <syntax-instr-parametric>` are represented by single byte codes, possibly followed by a type annotation.

.. _binary-drop:
.. _binary-select:

$${grammar: Binstr/parametric}


.. index:: variable instructions, local index, global index
   pair: binary format; instruction
.. _binary-instr-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

:ref:`Variable instructions <syntax-instr-variable>` are represented by byte codes followed by the encoding of the respective :ref:`index <syntax-index>`.

.. _binary-local.get:
.. _binary-local.set:
.. _binary-local.tee:
.. _binary-global.get:
.. _binary-global.set:

$${grammar: {Binstr/local Binstr/global}}


.. index:: table instruction, table index
   pair: binary format; instruction
.. _binary-instr-table:
.. _binary-table.get:
.. _binary-table.set:
.. _binary-table.size:
.. _binary-table.grow:
.. _binary-table.fill:
.. _binary-table.copy:
.. _binary-table.init:
.. _binary-elem.drop:

Table Instructions
~~~~~~~~~~~~~~~~~~

:ref:`Table instructions <syntax-instr-table>` are represented either by a single byte or a one byte prefix followed by a variable-length :ref:`unsigned integer <binary-uint>`.

$${grammar: Binstr/table}


.. index:: memory instruction, memory index
   pair: binary format; instruction
.. _binary-instr-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

Each variant of :ref:`memory instruction <syntax-instr-memory>` is encoded with a different byte code. Loads and stores are followed by the encoding of their |memarg| immediate, which includes the :ref:`memory index <binary-memidx>` if bit 6 of the flags field containing alignment is set; the memory index defaults to 0 otherwise.

.. _binary-memarg:
.. _binary-load:
.. _binary-loadn:
.. _binary-store:
.. _binary-storen:
.. _binary-memory.size:
.. _binary-memory.grow:
.. _binary-memory.fill:
.. _binary-memory.copy:
.. _binary-memory.init:
.. _binary-data.drop:

$${grammar: Bmemarg Binstr/memory}


.. index:: numeric instruction
   pair: binary format; instruction
.. _binary-instr-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

All variants of :ref:`numeric instructions <syntax-instr-numeric>` are represented by separate byte codes.

The ${:CONST} instructions are followed by the respective literal.

.. _binary-const:

$${grammar: Binstr/num-const}

All other numeric instructions are plain opcodes without any immediates.

.. _binary-testop:
.. _binary-relop:

$${grammar: {
  Binstr/num-test-i32 Binstr/num-rel-i32
  Binstr/num-test-i64 Binstr/num-rel-i64
}}

$${grammar: {
  Binstr/num-rel-f32
  Binstr/num-rel-f64
}}

.. _binary-unop:
.. _binary-binop:

$${grammar: {
  Binstr/num-un-i32 Binstr/num-bin-i32
  Binstr/num-un-i64 Binstr/num-bin-i64
}}

$${grammar: {
  Binstr/num-un-f32 Binstr/num-bin-f32
  Binstr/num-un-f64 Binstr/num-bin-f64
}}

.. _binary-cvtop:

$${grammar: Binstr/num-cvt}

$${grammar: {Binstr/num-un-ext-i32 Binstr/num-un-ext-i64}}

.. _binary-cvtop-trunc-sat:

The saturating truncation instructions all have a one byte prefix,
whereas the actual opcode is encoded by a variable-length :ref:`unsigned integer <binary-uint>`.

$${grammar: Binstr/num-cvt-sat}


.. index:: vector instruction
   pair: binary format; instruction
.. _binary-instr-vec:

Vector Instructions
~~~~~~~~~~~~~~~~~~~

All variants of :ref:`vector instructions <syntax-instr-vec>` are represented by separate byte codes.
They all have a one byte prefix, whereas the actual opcode is encoded by a variable-length :ref:`unsigned integer <binary-uint>`.

Vector loads and stores are followed by the encoding of their ${:memarg} immediate.

.. _binary-laneidx:

$${grammar: Blaneidx Binstr/vec-memory}

The ${:CONST} instruction for vectors is followed by 16 immediate bytes, which are converted into an ${:u128} in |littleendian| byte order:

$${grammar: Binstr/vec-const}

.. _binary-vswizzlop:
.. _binary-vshuffle:

The ${:SHUFFLE} instruction is also followed by the encoding of 16 ${:laneidx} immediates.

$${grammar: Binstr/vec-shuffle}

Lane instructions are followed by the encoding of a ${:laneidx} immediate.

.. _binary-vextract_lane:
.. _binary-vreplace_lane:

$${grammar: Binstr/vec-lane}

All other vector instructions are plain opcodes without any immediates.

.. _binary-vsplat:

$${grammar: Binstr/vec-splat}

.. _binary-virelop:

$${grammar: {
  Binstr/vec-rel-i8x16
  Binstr/vec-rel-i16x8
  Binstr/vec-rel-i32x4
  Binstr/vec-rel-i64x2
}}

.. _binary-vfrelop:

$${grammar: {
  Binstr/vec-rel-f32x4
  Binstr/vec-rel-f64x2
}}

.. _binary-vvunop:
.. _binary-vvbinop:
.. _binary-vvternop:
.. _binary-vvtestop:

$${grammar: {
  Binstr/vec-un-v128
  Binstr/vec-bin-v128
  Binstr/vec-tern-v128
  Binstr/vec-test-v128
}}

.. _binary-vitestop:
.. _binary-vshiftop:
.. _binary-viunop:
.. _binary-vibinop:
.. _binary-viternop:
.. _binary-viextunop:
.. _binary-viextbinop:
.. _binary-viextternop:
.. _binary-viminmaxop:
.. _binary-vsatbinop:

$${grammar: {
  Binstr/vec-un-i8x16
  Binstr/vec-test-i8x16
  Binstr/vec-bitmask-i8x16
  Binstr/vec-narrow-i8x16
  Binstr/vec-shift-i8x16
  Binstr/vec-bin-i8x16
}}

$${grammar: {
  Binstr/vec-extun-i16x8
  Binstr/vec-un-i16x8
  Binstr/vec-test-i16x8
  Binstr/vec-bitmask-i16x8
  Binstr/vec-narrow-i16x8
  Binstr/vec-ext-i16x8
  Binstr/vec-shift-i16x8
  Binstr/vec-bin-i16x8
  Binstr/vec-extbin-i16x8
}}

$${grammar: {
  Binstr/vec-extun-i32x4
  Binstr/vec-un-i32x4
  Binstr/vec-test-i32x4
  Binstr/vec-bitmask-i32x4
  Binstr/vec-ext-i32x4
  Binstr/vec-shift-i32x4
  Binstr/vec-bin-i32x4
  Binstr/vec-extbin-i32x4
  Binstr/vec-exttern-i32x4
}}

$${grammar: {
  Binstr/vec-un-i64x2
  Binstr/vec-test-i64x2
  Binstr/vec-bitmask-i64x2
  Binstr/vec-ext-i64x2
  Binstr/vec-shift-i64x2
  Binstr/vec-bin-i64x2
  Binstr/vec-extbin-i64x2
}}

.. _binary-vfunop:
.. _binary-vfbinop:
.. _binary-vfternop:

$${grammar: {
  Binstr/vec-un-f32x4
  Binstr/vec-bin-f32x4
  Binstr/vec-tern-f32x4
}}

$${grammar: {
  Binstr/vec-un-f64x2
  Binstr/vec-bin-f64x2
  Binstr/vec-tern-f64x2
}}

$${grammar: {Binstr/vec-cvt}}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Binstr} &\phantom{::=}& \phantom{\dots} && \phantom{vechaslongerinstructionnames} \\[-2ex] &&|&
     \hex{FD}~~256{:}\Bu32 &\Rightarrow& \I16X8.\VRELAXEDSWIZZLE \\ &&|&
     \hex{FD}~~257{:}\Bu32 &\Rightarrow& \I32X4.\VRELAXEDTRUNC\K{\_f32x4\_s} \\ &&|&
     \hex{FD}~~258{:}\Bu32 &\Rightarrow& \I32X4.\VRELAXEDTRUNC\K{\_f32x4\_u} \\ &&|&
     \hex{FD}~~259{:}\Bu32 &\Rightarrow& \I32X4.\VRELAXEDTRUNC\K{\_f32x4\_s\_zero} \\ &&|&
     \hex{FD}~~260{:}\Bu32 &\Rightarrow& \I32X4.\VRELAXEDTRUNC\K{\_f32x4\_u\_zero} \\ &&|&
     \hex{FD}~~261{:}\Bu32 &\Rightarrow& \F32X4.\VRELAXEDMADD \\ &&|&
     \hex{FD}~~262{:}\Bu32 &\Rightarrow& \F32X4.\VRELAXEDNMADD \\ &&|&
     \hex{FD}~~263{:}\Bu32 &\Rightarrow& \F64X2.\VRELAXEDMADD \\ &&|&
     \hex{FD}~~264{:}\Bu32 &\Rightarrow& \F64X2.\VRELAXEDNMADD \\ &&|&
     \hex{FD}~~265{:}\Bu32 &\Rightarrow& \I8X16.\VRELAXEDLANESELECT \\ &&|&
     \hex{FD}~~266{:}\Bu32 &\Rightarrow& \I16X8.\VRELAXEDLANESELECT \\ &&|&
     \hex{FD}~~267{:}\Bu32 &\Rightarrow& \I32X4.\VRELAXEDLANESELECT \\ &&|&
     \hex{FD}~~268{:}\Bu32 &\Rightarrow& \I64X2.\VRELAXEDLANESELECT \\ &&|&
     \hex{FD}~~269{:}\Bu32 &\Rightarrow& \F32X4.\VRELAXEDMIN \\ &&|&
     \hex{FD}~~270{:}\Bu32 &\Rightarrow& \F32X4.\VRELAXEDMAX \\ &&|&
     \hex{FD}~~271{:}\Bu32 &\Rightarrow& \F64X2.\VRELAXEDMIN \\ &&|&
     \hex{FD}~~272{:}\Bu32 &\Rightarrow& \F64X2.\VRELAXEDMAX \\ &&|&
     \hex{FD}~~273{:}\Bu32 &\Rightarrow& \I16X8.\VRELAXEDQ15MULR\K{\_s} \\ &&|&
     \hex{FD}~~274{:}\Bu32 &\Rightarrow& \I16X8.\VRELAXEDDOT\K{\_i8x16\_i7x16\_s} \\ &&|&
     \hex{FD}~~275{:}\Bu32 &\Rightarrow& \I16X8.\VRELAXEDDOT\K{\_i8x16\_i7x16\_add\_s} \\
   \end{array}


.. index:: expression
   pair: binary format; expression
   single: expression; constant
.. _binary-expr:

Expressions
~~~~~~~~~~~

:ref:`Expressions <syntax-expr>` are encoded by their instruction sequence terminated with an explicit ${:0x0B} opcode for ${:END}.

$${grammar: Bexpr}

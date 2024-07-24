.. index:: ! instruction, code, stack machine, operand, operand stack
   pair: abstract syntax; instruction
.. _syntax-instr:

Instructions
------------

WebAssembly code consists of sequences of *instructions*.
Its computational model is based on a *stack machine* in that instructions manipulate values on an implicit *operand stack*,
consuming (popping) argument values and producing or returning (pushing) result values.

In addition to dynamic operands from the stack, some instructions also have static *immediate* arguments,
typically :ref:`indices <syntax-index>` or type annotations,
which are part of the instruction itself.

Some instructions are :ref:`structured <syntax-instr-control>` in that they contain nested sequences of instructions.

The following sections group instructions into a number of different categories.

The syntax of instruction is further :ref:`extended <syntax-instr-admin>` with additional forms for the purpose of specifying :ref:`execution <exec>`.


.. index:: ! parametric instruction, value type
   pair: abstract syntax; instruction
.. _syntax-instr-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

Instructions in this group can operate on operands of any :ref:`value type <syntax-valtype>`.

$${syntax: instr/parametric}

The ${:NOP} instruction does nothing.

The ${:UNREACHABLE} instruction causes an unconditional :ref:`trap <trap>`.

The ${:DROP} instruction simply throws away a single operand.

The ${:SELECT} instruction selects one of its first two operands based on whether its third operand is zero or not.
It may include a :ref:`value type <syntax-valtype>` determining the type of these operands. If missing, the operands must be of :ref:`numeric type <syntax-numtype>`.

.. note::
   In future versions of WebAssembly, the type annotation on ${:SELECT} may allow for more than a single value being selected at the same time.


.. index:: ! numeric instruction, value, value type, integer, floating-point, two's complement
   pair: abstract syntax; instruction
.. _syntax-sx:
.. _syntax-sz:
.. _syntax-num_:
.. _syntax-const:
.. _syntax-unop:
.. _syntax-binop:
.. _syntax-testop:
.. _syntax-relop:
.. _syntax-cvtop:
.. _syntax-instr-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

Numeric instructions provide basic operations over numeric :ref:`values <syntax-value>` of specific :ref:`type <syntax-numtype>`.
These operations closely match respective operations available in hardware.

$${syntax: {sz sx} num_ instr/num unop_ binop_ testop_ relop_ cvtop_}

Numeric instructions are divided by :ref:`number type <syntax-numtype>`.
For each type, several subcategories can be distinguished:

* *Constants*: return a static constant.

* *Unary Operations*: consume one operand and produce one result of the respective type.

* *Binary Operations*: consume two operands and produce one result of the respective type.

* *Tests*: consume one operand of the respective type and produce a Boolean integer result.

* *Comparisons*: consume two operands of the respective type and produce a Boolean integer result.

* *Conversions*: consume a value of one type and produce a result of another
  (the source type of the conversion is the one after the "${:_}").

Some integer instructions come in two flavors,
where a signedness annotation ${:sx} distinguishes whether the operands are to be :ref:`interpreted <aux-signed>` as :ref:`unsigned <syntax-uint>` or :ref:`signed <syntax-sint>` integers.
For the other integer instructions, the use of two's complement for the signed interpretation means that they behave the same regardless of signedness.


.. index:: ! vector instruction, numeric vector, number, value, value type, SIMD
   pair: abstract syntax; instruction
.. _syntax-laneidx:
.. _syntax-lanetype:
.. _syntax-dim:
.. _syntax-shape:
.. _syntax-half:
.. _syntax-zero:
.. _syntax-vvunop:
.. _syntax-vvbinop:
.. _syntax-vvternop:
.. _syntax-vvtestop:
.. _syntax-vtestop:
.. _syntax-vrelop:
.. _syntax-vshiftop:
.. _syntax-vunop:
.. _syntax-vbinop:
.. _syntax-vextunop:
.. _syntax-vextbinop:
.. _syntax-vcvtop:
.. _syntax-instr-vec:

Vector Instructions
~~~~~~~~~~~~~~~~~~~

Vector instructions (also known as *SIMD* instructions, *single instruction multiple data*) provide basic operations over :ref:`values <syntax-value>` of :ref:`vector type <syntax-vectype>`.

$${syntax: {lanetype dim shape ishape} half_ zero_ laneidx instr/vec}

$${syntax:
  vvunop vvbinop vvternop vvtestop
  vunop_ vbinop_ vtestop_ vrelop_ vshiftop_ vextunop_ vextbinop_ vcvtop_
}

Vector instructions have a naming convention involving a *shape* prefix that
determines how their operands will be interpreted,
written ${:t#X#N}, and consisting of a *lane type* ${:t}, a possibly *packed* :ref:`numeric type <syntax-numtype>`, and the number of *lanes* ${:N} of that type.
Operations are performed point-wise on the values of each lane.

.. note::
   For example, the shape ${shape: I32 X `4} interprets the operand
   as four ${:i32} values, packed into an ${:i128}.
   The bit width of the lane type ${:t} times ${:N} always is ${:128}.

Instructions prefixed with ${:V128} do not involve a specific interpretation, and treat the ${:V128} as either an ${:i128} value or a vector of ${:128} individual bits.

Vector instructions can be grouped into several subcategories:

* *Constants*: return a static constant.

* *Unary Operations*: consume one ${:V128} operand and produce one ${:V128} result.

* *Binary Operations*: consume two ${:V128} operands and produce one ${:V128} result.

* *Ternary Operations*: consume three ${:V128} operands and produce one ${:V128} result.

* *Tests*: consume one ${:V128} operand and produce a Boolean integer result.

* *Shifts*: consume a ${:V128} operand and an ${:I32} operand, producing one ${:V128} result.

* *Splats*: consume a value of numeric type and produce a ${:V128} result of a specified shape.

* *Extract lanes*: consume a ${:V128} operand and return the numeric value in a given lane.

* *Replace lanes*: consume a ${:V128} operand and a numeric value for a given lane, and produce a ${:V128} result.

Some vector instructions have a signedness annotation ${:sx} which distinguishes whether the elements in the operands are to be :ref:`interpreted <aux-signed>` as :ref:`unsigned <syntax-uint>` or :ref:`signed <syntax-sint>` integers.
For the other vector instructions, the use of two's complement for the signed interpretation means that they behave the same regardless of signedness.


.. _aux-lanetype:
.. _aux-dim:

Conventions
...........

* The function ${:$lanetype(shape)} extracts the lane type of a shape.  ${definition-ignore: lanetype}

* The function ${:$dim(shape)} extracts the dimension of a shape.  ${definition-ignore: dim}


.. index:: ! reference instruction, reference, null, cast, heap type, reference type
   pair: abstract syntax; instruction
.. _syntax-ref.null:
.. _syntax-ref.func:
.. _syntax-ref.is_null:
.. _syntax-ref.as_non_null:
.. _syntax-ref.eq:
.. _syntax-ref.test:
.. _syntax-ref.cast:
.. _syntax-instr-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

Instructions in this group are concerned with accessing :ref:`references <syntax-reftype>`.

$${syntax: {instr/func instr/ref}}

The ${:REF.NULL} and ${:REF.FUNC} instructions produce a :ref:`null <syntax-null>` value or a reference to a given function, respectively.

The instruction ${:REF.IS_NULL} checks for null,
while ${:REF.AS_NON_NULL} converts a :ref:`nullable <syntax-reftype>` to a non-null one, and :ref:`traps <trap>` if it encounters null.

The ${:REF.EQ} compares two references.

The instructions ${:REF.TEST} and ${:REF.CAST} test the :ref:`dynamic type <type-inst>` of a reference operand.
The former merely returns the result of the test,
while the latter performs a downcast and :ref:`traps <trap>` if the operand's type does not match.

.. note::
   The ${:BR_ON_NULL} and ${:BR_ON_NON_NULL} instructions provide versions of ${:REF.AS_NULL} that branch depending on the success of failure of a null test instead of trapping.
   Similarly, the ${:BR_ON_CAST} and ${:BR_ON_CAST_FAIL} instructions provides versions of ${:REF.CAST} that branch depending on the success of the downcast instead of trapping.

   An additional instruction operating on function references is the :ref:`control instruction <syntax-instr-control>` ${:CALL_REF}.


.. index:: reference instruction, reference, null, heap type, reference type
   pair: abstract syntax; instruction

.. _syntax-struct.new:
.. _syntax-struct.new_default:
.. _syntax-struct.get:
.. _syntax-struct.get_s:
.. _syntax-struct.get_u:
.. _syntax-struct.set:
.. _syntax-array.new:
.. _syntax-array.new_default:
.. _syntax-array.new_fixed:
.. _syntax-array.new_data:
.. _syntax-array.new_elem:
.. _syntax-array.get:
.. _syntax-array.get_s:
.. _syntax-array.get_u:
.. _syntax-array.set:
.. _syntax-array.len:
.. _syntax-array.fill:
.. _syntax-array.copy:
.. _syntax-array.init_data:
.. _syntax-array.init_elem:
.. _syntax-ref.i31:
.. _syntax-i31.get_s:
.. _syntax-i31.get_u:
.. _syntax-any.convert_extern:
.. _syntax-extern.convert_any:
.. _syntax-instr-struct:
.. _syntax-instr-array:
.. _syntax-instr-i31:
.. _syntax-instr-extern:

Aggregate Instructions
~~~~~~~~~~~~~~~~~~~~~~

Instructions in this group are concerned with creating and accessing :ref:`references <syntax-reftype>` to :ref:`aggregate <syntax-aggrtype>` types.

$${syntax: {instr/struct instr/array instr/i31 instr/extern}}

The instructions ${:STRUCT.NEW} and ${:STRUCT.NEW_DEFAULT} allocate a new :ref:`structure <syntax-structtype>`, initializing them either with operands or with default values.
The remaining instructions on structs access individual fields,
allowing for different sign extension modes in the case of :ref:`packed <syntax-packtype>` storage types.

Similarly, :ref:`arrays <syntax-arraytype>` can be allocated either with an explicit initialization operand or a default value.
Furthermore, ${:ARRAY.NEW_FIXED} allocates an array with statically fixed size,
and ${:ARRAY.NEW_DATA} and ${:ARRAY.NEW_ELEM} allocate an array and initialize it from a :ref:`data <syntax-data>` or :ref:`element <syntax-elem>` segment, respectively.
The instructions ${:ARRAY.GET}, ${:ARRAY.GET sx !%}, and ${:ARRAY.SET} access individual slots,
again allowing for different sign extension modes in the case of a :ref:`packed <syntax-packtype>` storage type;
${:ARRAY.LEN} produces the length of an array;
${:ARRAY.FILL} fills a specified slice of an array with a given value and ${:ARRAY.COPY}, ${:ARRAY.INIT_DATA}, and ${:ARRAY.INIT_ELEM} copy elements to a specified slice of an array from a given array, data segment, or element segment, respectively.

The instructions ${:REF.I31} and ${:I31.GET sx} convert between type ${:I32} and an unboxed :ref:`scalar <syntax-i31>`.

The instructions ${:ANY.CONVERT_EXTERN} and ${:EXTERN.CONVERT_ANY} allow lossless conversion between references represented as type ${reftype: (REF NULL EXTERN)} and as ${reftype: (REF NULL ANY)}.


.. index:: ! variable instruction, local, global, local index, global index
   pair: abstract syntax; instruction
.. _syntax-instr-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

Variable instructions are concerned with access to :ref:`local <syntax-local>` or :ref:`global <syntax-global>` variables.

$${syntax: {instr/local instr/global}}

These instructions get or set the values of respective variables.
The ${:LOCAL.TEE} instruction is like ${:LOCAL.SET} but also returns its argument.


.. index:: ! table instruction, table, table index, trap
   pair: abstract syntax; instruction
.. _syntax-instr-table:
.. _syntax-table.get:
.. _syntax-table.set:
.. _syntax-table.size:
.. _syntax-table.grow:
.. _syntax-table.fill:

Table Instructions
~~~~~~~~~~~~~~~~~~

Instructions in this group are concerned with tables :ref:`table <syntax-table>`.

$${syntax: {instr/table instr/elem}}

The ${:TABLE.GET} and ${:TABLE.SET} instructions load or store an element in a table, respectively.

The ${:TABLE.SIZE} instruction returns the current size of a table.
The ${:TABLE.GROW} instruction grows table by a given delta and returns the previous size, or ${:$(-1)} if enough space cannot be allocated.
It also takes an initialization value for the newly allocated entries.

The ${:TABLE.FILL} instruction sets all entries in a range to a given value.
The ${:TABLE.COPY} instruction copies elements from a source table region to a possibly overlapping destination region; the first index denotes the destination.
The ${:TABLE.INIT} instruction copies elements from a :ref:`passive element segment <syntax-elem>` into a table.

The ${:ELEM.DROP} instruction prevents further use of a passive element segment. This instruction is intended to be used as an optimization hint. After an element segment is dropped its elements can no longer be retrieved, so the memory used by this segment may be freed.

.. note::
   An additional instruction that accesses a table is the :ref:`control instruction <syntax-instr-control>` ${:CALL_INDIRECT}.


.. index:: ! memory instruction, memory, memory index, page size, little endian, trap
   pair: abstract syntax; instruction
.. _syntax-loadn:
.. _syntax-storen:
.. _syntax-memarg:
.. _syntax-loadop:
.. _syntax-vloadop:
.. _syntax-lanewidth:
.. _syntax-instr-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

Instructions in this group are concerned with linear :ref:`memory <syntax-mem>`.

$${syntax: memarg loadop_ vloadop_ {instr/memory instr/data}}

Memory is accessed with ${:LOAD} and ${:STORE} instructions for the different :ref:`number types <syntax-numtype>` and `vector types <syntax-vectype>`.
They all take a :ref:`memory index <syntax-memidx>` and a *memory argument* ${:memarg} that contains an address *offset* and the expected *alignment* (expressed as the exponent of a power of 2).

Integer loads and stores can optionally specify a *storage size* ${:sz} that is smaller than the :ref:`bit width <syntax-numtype>` of the respective value type.
In the case of loads, a sign extension mode ${:sx} is then required to select appropriate behavior.

Vector loads can specify a shape that is half the :ref:`bit width <syntax-valtype>` of ${:V128}. Each lane is half its usual size, and the sign extension mode ${:sx} then specifies how the smaller lane is extended to the larger lane.
Alternatively, vector loads can perform a *splat*, such that only a single lane of the specified storage size is loaded, and the result is duplicated to all lanes.

The static address offset is added to the dynamic address operand, yielding a 33 bit *effective address* that is the zero-based index at which the memory is accessed.
All values are read and written in |LittleEndian|_ byte order.
A :ref:`trap <trap>` results if any of the accessed memory bytes lies outside the address range implied by the memory's current size.

.. note::
   Future versions of WebAssembly might provide memory instructions with 64 bit address ranges.

The ${:MEMORY.SIZE} instruction returns the current size of a memory.
The ${:MEMORY.GROW} instruction grows a memory by a given delta and returns the previous size, or ${:$(-1)} if enough memory cannot be allocated.
Both instructions operate in units of :ref:`page size <page-size>`.

The ${:MEMORY.FILL} instruction sets all values in a regionof a memory to a given byte.
The ${:MEMORY.COPY} instruction copies data from a source memory region to a possibly overlapping destination region in another or the same memory; the first index denotes the destination
The ${:MEMORY.INIT} instruction copies data from a :ref:`passive data segment <syntax-data>` into a memory.

The ${:DATA.DROP} instruction prevents further use of a passive data segment. This instruction is intended to be used as an optimization hint. After a data segment is dropped its data can no longer be retrieved, so the memory used by this segment may be freed.

.. note::
   In the current version of WebAssembly,
   all memory instructions implicitly operate on :ref:`memory <syntax-mem>` :ref:`index <syntax-memidx>` ${:0}.
   This restriction may be lifted in future versions.


.. index:: ! control instruction, ! structured control, ! label, ! block, ! block type, ! branch, ! unwinding, stack type, label index, function index, type index, list, trap, function, table, function type, value type, type index
   pair: abstract syntax; instruction
   pair: abstract syntax; block type
   pair: block; type
.. _syntax-blocktype:
.. _syntax-nop:
.. _syntax-unreachable:
.. _syntax-block:
.. _syntax-loop:
.. _syntax-if:
.. _syntax-br:
.. _syntax-br_if:
.. _syntax-br_table:
.. _syntax-br_on_null:
.. _syntax-br_on_non_null:
.. _syntax-br_on_cast:
.. _syntax-br_on_cast_fail:
.. _syntax-return:
.. _syntax-call:
.. _syntax-call_indirect:
.. _syntax-instrs:
.. _syntax-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

Instructions in this group affect the flow of control.

$${syntax: blocktype {instr/block instr/br instr/call}}

The ${:BLOCK}, ${:LOOP} and ${:IF} instructions are *structured* instructions.
They bracket nested sequences of instructions, called *blocks*, terminated with, or separated by, ${:END} or ${:ELSE} pseudo-instructions.
As the grammar prescribes, they must be well-nested.

A structured instruction can consume *input* and produce *output* on the operand stack according to its annotated *block type*.
It is given either as a :ref:`type index <syntax-funcidx>` that refers to a suitable :ref:`function type <syntax-functype>` reinterpreted as an :ref:`instruction type <syntax-instrtype>`, or as an optional :ref:`value type <syntax-valtype>` inline, which is a shorthand for the instruction type ${instrtype: eps -> valtype?}.

Each structured control instruction introduces an implicit *label*.
Labels are targets for branch instructions that reference them with :ref:`label indices <syntax-labelidx>`.
Unlike with other :ref:`index spaces <syntax-index>`, indexing of labels is relative by nesting depth,
that is, label ${:0} refers to the innermost structured control instruction enclosing the referring branch instruction,
while increasing indices refer to those farther out.
Consequently, labels can only be referenced from *within* the associated structured control instruction.
This also implies that branches can only be directed outwards,
"breaking" from the block of the control construct they target.
The exact effect depends on that control construct.
In case of ${:BLOCK} or ${:IF} it is a *forward jump*,
resuming execution after the matching ${:END}.
In case of ${:LOOP} it is a *backward jump* to the beginning of the loop.

.. note::
   This enforces *structured control flow*.
   Intuitively, a branch targeting a ${:BLOCK} or ${:IF} behaves like a :math:`\K{break}` statement in most C-like languages,
   while a branch targeting a ${:LOOP} behaves like a :math:`\K{continue}` statement.

Branch instructions come in several flavors:
${:BR} performs an unconditional branch,
${:BR_IF} performs a conditional branch,
and ${:BR_TABLE} performs an indirect branch through an operand indexing into the label list that is an immediate to the instruction, or to a default target if the operand is out of bounds.
The ${:BR_ON_NULL} and ${:BR_ON_NON_NULL} instructions check whether a reference operand is :ref:`null <syntax-null>` and branch if that is the case or not the case, respectively.
Similarly, ${:BR_ON_CAST} and ${:BR_ON_CAST_FAIL} attempt a downcast on a reference operand and branch if that succeeds, or fails, respectively.

The ${:RETURN} instruction is a shortcut for an unconditional branch to the outermost block, which implicitly is the body of the current function.
Taking a branch *unwinds* the operand stack up to the height where the targeted structured control instruction was entered.
However, branches may additionally consume operands themselves, which they push back on the operand stack after unwinding.
Forward branches require operands according to the output of the targeted block's type, i.e., represent the values produced by the terminated block.
Backward branches require operands according to the input of the targeted block's type, i.e., represent the values consumed by the restarted block.

The ${:CALL} instruction invokes another :ref:`function <syntax-func>`, consuming the necessary arguments from the stack and returning the result values of the call.
The ${:CALL_REF} instruction invokes a function indirectly through a :ref:`function reference <syntax-reftype>` operand.
The ${:CALL_INDIRECT} instruction calls a function indirectly through an operand indexing into a :ref:`table <syntax-table>` that is denoted by a :ref:`table index <syntax-tableidx>` and must contain :ref:`function references <syntax-reftype>`.
Since it may contain functions of heterogeneous type,
the callee is dynamically checked against the :ref:`function type <syntax-functype>` indexed by the instruction's second immediate, and the call is aborted with a :ref:`trap <trap>` if it does not match.

The ${:RETURN_CALL}, ${:RETURN_CALL_REF}, and ${:RETURN_CALL_INDIRECT} instructions are *tail-call* variants of the previous ones.
That is, they first return from the current function before actually performing the respective call.
It is guaranteed that no sequence of nested calls using only these instructions can cause resource exhaustion due to hitting an :ref:`implementation's limit <impl-exec>` on the number of active calls.


.. index:: ! expression, constant, global, offset, element, data, instruction
   pair: abstract syntax; expression
   single: expression; constant
.. _syntax-expr:

Expressions
~~~~~~~~~~~

:ref:`Function <syntax-func>` bodies, initialization values for :ref:`globals <syntax-global>`, elements and offsets of :ref:`element <syntax-elem>` segments, and offsets of :ref:`data <syntax-data>` segments are given as expressions, which are sequences of :ref:`instructions <syntax-instr>`.

$${syntax: expr}

In some places, validation :ref:`restricts <valid-constant>` expressions to be *constant*, which limits the set of allowable instructions.

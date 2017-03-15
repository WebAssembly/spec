.. _syntax-instr:
.. index:: ! instruction, ! code, stack machine, operand, operand stack
   pair: abstract syntax; instruction

Instructions
------------

WebAssembly code consists of sequences of *instructions*.
Its computational model is based on a *stack machine* in that instructions manipulate values on an implicit *operand stack*,
*consuming* (popping) argument values and *returning* (pushing) result values.

.. note::
   In the current version of WebAssembly,
   at most one result value can be pushed by a single instruction.
   This restriction may be lifted in future versions.

In addition to dynamic operands from the stack, some instructions also have static *immediate* arguments,
typically :ref:`indices <syntax-index>` or type annotations,
which are part of the instruction itself.

Some instructions are :ref:`structured <syntax-instr-control>` in that they bracket nested sequences of instructions.

The following sections group instructions into a number of different categories.


.. _syntax-sx:
.. _syntax-instr-numeric:
.. index:: ! numeric instruction
   pair: abstract syntax; instruction

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

Numeric instructions provide basic operations over numeric values of specific type.
These operations closely match respective operations available in hardware.

.. math::
   \begin{array}{llll}
   \production{width} & \X{nn}, \X{mm} &::=&
     \K{32} ~|~ \K{64} \\
   \production{signedness} & \sx &::=&
     \K{u} ~|~ \K{s} \\
   \production{instructions} & \instr &::=&
     \K{i}\X{nn}\K{.const}~\href{../syntax/values.html#syntax-int}{\iX{\X{nn}}} ~|~
     \K{f}\X{nn}\K{.const}~\href{../syntax/values.html#syntax-float}{\fX{\X{nn}}} ~|~ \\&&&
     \K{i}\X{nn}\K{.eqz} ~|~ \\&&&
     \K{i}\X{nn}\K{.eq} ~|~
     \K{i}\X{nn}\K{.ne} ~|~
     \K{i}\X{nn}\K{.lt\_}\sx ~|~
     \K{i}\X{nn}\K{.gt\_}\sx ~|~
     \K{i}\X{nn}\K{.le\_}\sx ~|~
     \K{i}\X{nn}\K{.ge\_}\sx ~|~ \\&&&
     \K{f}\X{nn}\K{.eq} ~|~
     \K{f}\X{nn}\K{.ne} ~|~
     \K{f}\X{nn}\K{.lt} ~|~
     \K{f}\X{nn}\K{.gt} ~|~
     \K{f}\X{nn}\K{.le} ~|~
     \K{f}\X{nn}\K{.ge} ~|~ \\&&&
     \K{i}\X{nn}\K{.clz} ~|~
     \K{i}\X{nn}\K{.ctz} ~|~
     \K{i}\X{nn}\K{.popcnt} ~|~ \\&&&
     \K{i}\X{nn}\K{.add} ~|~
     \K{i}\X{nn}\K{.sub} ~|~
     \K{i}\X{nn}\K{.mul} ~|~
     \K{i}\X{nn}\K{.div\_}\sx ~|~
     \K{i}\X{nn}\K{.rem\_}\sx ~|~ \\&&&
     \K{i}\X{nn}\K{.and} ~|~
     \K{i}\X{nn}\K{.or} ~|~
     \K{i}\X{nn}\K{.xor} ~|~ \\&&&
     \K{i}\X{nn}\K{.shl} ~|~
     \K{i}\X{nn}\K{.shr\_}\sx ~|~
     \K{i}\X{nn}\K{.rotl} ~|~
     \K{i}\X{nn}\K{.rotr} ~|~ \\&&&
     \K{f}\X{nn}\K{.abs} ~|~
     \K{f}\X{nn}\K{.neg} ~|~
     \K{f}\X{nn}\K{.sqrt} ~|~ \\&&&
     \K{f}\X{nn}\K{.ceil} ~|~ 
     \K{f}\X{nn}\K{.floor} ~|~ 
     \K{f}\X{nn}\K{.trunc} ~|~ 
     \K{f}\X{nn}\K{.nearest} ~|~ \\&&&
     \K{f}\X{nn}\K{.add} ~|~
     \K{f}\X{nn}\K{.sub} ~|~
     \K{f}\X{nn}\K{.mul} ~|~
     \K{f}\X{nn}\K{.div} ~|~ \\&&&
     \K{f}\X{nn}\K{.min} ~|~
     \K{f}\X{nn}\K{.max} ~|~
     \K{f}\X{nn}\K{.copysign} ~|~ \\&&&
     \K{i32.wrap/i64} ~|~
     \K{i64.extend\_}\sx/\K{i32} ~|~
     \K{i}\X{nn}\K{.trunc\_}\sx/\K{f}\X{mm} ~|~ \\&&&
     \K{f32.demote/f64} ~|~
     \K{f64.promote/f32} ~|~
     \K{f}\X{nn}\K{.convert\_}\sx/\K{i}\X{mm} ~|~ \\&&&
     \K{i}\X{nn}\K{.reinterpret/f}\X{nn} ~|~
     \K{f}\X{nn}\K{.reinterpret/i}\X{nn} \\
   \end{array}

Numeric instructions are divided by :ref:`value type <syntax-valtype>`.
For each type, several subcategories can be distinguished:

* *Constants*: return a static constant.

* *Unary Operators*: consume one operand and produce one result of the respective type.

* *Binary Operators*: consume two operands and produce one result of the respective type.

* *Tests*: consume one operand of the respective type and produce a Boolean result.

* *Comparisons*: consume two operands of the respective type and produce a Boolean result.

* *Conversions*: consume a value of one type and produce a result of another
  (the source type of the conversion is the one after the ":math:`\K{/}`").

Some integer instructions come in two flavours,
where a signedness annotation |sx| distinguishes whether the operands are to be interpreted as :ref:`unsigned <syntax-uint>` or :ref:`signed <syntax-sint>` integers.
For the other integer instructions, the sign interpretation is irrelevant under a 2's complement interpretation.


.. _syntax-instr-parametric:
.. index:: ! parametric instruction
   pair: abstract syntax; instruction

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

Instructions in this group can operate on operands of any :ref:`value type <syntax-valtype>`.

.. math::
   \begin{array}{llll}
   \production{instructions} & \instr &::=&
     \dots ~|~ \\&&&
     \DROP ~|~ \\&&&
     \SELECT
   \end{array}

The |DROP| operator simply throws away a single operand.

The |SELECT| operator selects one of its first two operands based on whether its third operand is zero or not.


.. _syntax-instr-variable:
.. index:: ! variable instruction, local, global, local index, global index
   pair: abstract syntax; instruction

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

Variable instructions are concerned with the access to :ref:`local <syntax-local>` or :ref:`global <syntax-global>` variables.

.. math::
   \begin{array}{llll}
   \production{instructions} & \instr &::=&
     \dots ~|~ \\&&&
     \GETLOCAL~\localidx ~|~ \\&&&
     \SETLOCAL~\localidx ~|~ \\&&&
     \TEELOCAL~\localidx ~|~ \\&&&
     \GETGLOBAL~\globalidx ~|~ \\&&&
     \SETGLOBAL~\globalidx ~|~ \\
   \end{array}

These instructions get or set the values of variables, respectively.
The |TEELOCAL| instruction is like |SETLOCAL| but also returns its argument.


.. _syntax-instr-memory:
.. _syntax-memarg:
.. index:: ! memory instruction, memory index
   pair: abstract syntax; instruction

Memory Instructions
~~~~~~~~~~~~~~~~~~~

Instructions in this group are concerned with :ref:`linear memory <sec-memory>`.

.. math::
   \begin{array}{llll}
   \production{memory immediate} & \memarg &::=&
     \{ \OFFSET~\u32, \ALIGN~\u32 \} \\
   \production{instructions} & \instr &::=&
     \dots ~|~ \\&&&
     \K{i}\X{nn}\K{.load}~\memarg ~|~
     \K{f}\X{nn}\K{.load}~\memarg ~|~ \\&&&
     \K{i}\X{nn}\K{.store}~\memarg ~|~
     \K{f}\X{nn}\K{.store}~\memarg ~|~ \\&&&
     \K{i}\X{nn}\K{.load8\_}\sx~\memarg ~|~
     \K{i}\X{nn}\K{.load16\_}\sx~\memarg ~|~
     \K{i64.load32\_}\sx~\memarg ~|~ \\&&&
     \K{i}\X{nn}\K{.store8}~\memarg ~|~
     \K{i}\X{nn}\K{.store16}~\memarg ~|~
     \K{i64.store32}~\memarg ~|~ \\&&&
     \CURRENTMEMORY ~|~ \\&&&
     \GROWMEMORY \\
   \end{array}

Memory is accessed with :math:`\K{load}` and :math:`\K{store}` instructions for the different :ref:`value types <syntax-valtype>`.
They all take a *memory immediate* |memarg| that contains an address *offset* and an *alignment* hint.
Integer loads and stores can optionally specify a *storage size* that is smaller than the width of the respective value type.
In the case of loads, a sign extension mode |sx| is then required to select appropriate behavior.

The static address offset is added to the dynamic address operand, yielding a 33 bit *effective address* that is the zero-based index at which the memory is accessed.
All values are read and written in `little endian <https://en.wikipedia.org/wiki/Endianness#Little-endian>`_ byte order.
A :ref:`trap <trap>` results if any of the accessed memory bytes lies outside the address range implied by the memory's current size.

.. note::
   Future version of WebAssembly might provide memory instructions with 64 bit address ranges.

The |CURRENTMEMORY| instruction returns the current size of a memory.
The |GROWMEMORY| instruction grows memory by a given delta and returns the previous size, or :math:`-1` if enough memory cannot be allocated.
Both instructions operate in units of :ref:`page size <page-size>`.

.. note::
   In the current version of WebAssembly,
   all memory instructions implicitly operate on :ref:`memory <syntax-mem>` :ref:`index <syntax-memidx>` :math:`0`.
   This restriction may be lifted in future versions.

The precise semantics of memory instructions is :ref:`described <exec-instr-memory>` in the :ref:`Instruction <sec-instruction>` section.


.. _syntax-instr-control:
.. _syntax-label:
.. index:: ! control instruction, ! structured control, ! label, ! block, ! branch, ! unwinding, result type, label index, function index, type index, vector
   pair: abstract syntax; instruction

Control Instructions
~~~~~~~~~~~~~~~~~~~~

Instructions in this group affect the flow of control.

.. math::
   \begin{array}{llll}
   \production{instructions} & \instr &::=&
     \dots ~|~ \\&&&
     \NOP ~|~ \\&&&
     \UNREACHABLE ~|~ \\&&&
     \BLOCK~\resulttype~\instr^\ast~\END ~|~ \\&&&
     \LOOP~\resulttype~\instr^\ast~\END ~|~ \\&&&
     \IF~\resulttype~\instr^\ast~\ELSE~\instr^\ast~\END ~|~ \\&&&
     \BR~\labelidx ~|~ \\&&&
     \BRIF~\labelidx ~|~ \\&&&
     \BRTABLE~\vec(\labelidx)~\labelidx ~|~ \\&&&
     \RETURN ~|~ \\&&&
     \CALL~\funcidx ~|~ \\&&&
     \CALLINDIRECT~\typeidx \\
   \end{array}

The |NOP| instruction does nothing.

The |UNREACHABLE| instruction causes an unconditional :ref:`trap <trap>`.

The |BLOCK|, |LOOP| and |IF| instructions are *structured* instructions.
They bracket nested sequences of instructions, called *blocks*, terminated with, or separated by, |END| or |ELSE| pseudo-instructions.
As the grammar prescribes, they must be well-nested.
A structured instruction can produce a value as described by the annotated :ref:`result type <syntax-resulttype>`.

Each structured control instruction introduces an implicit *label*.
Labels are targets for branch instructions that reference them with :ref:`label indices <syntax-labelidx>`.
Unlike with other index spaces, indexing of labels is relative by nesting depth,
that is, label :math:`0` refers to the innermost structured control instruction enclosing the referring branch instruction,
while increasing indices refer to those farther out.
Consequently, labels can only be referenced from *within* the associated structured control instruction.
This also implies that branches can only be directed outwards,
"breaking" from the block of the control construct they target.
The exact effect depends on that control construct.
In case of |BLOCK| or |IF| it is a *forward jump*,
resuming execution after the matching |END|.
In case of |LOOP| it is a *backward jump* to the beginning of the loop.

.. note::
   This enforces *structured control flow*.
   Intuitively, a branch targeting a |BLOCK| or |IF| behaves like a :math:`\K{break}` statement,
   while a branch targeting a |LOOP| behaves like a :math:`\K{continue}` statement.

Branch instructions come in several flavors:
|BR| performs an unconditional branch,
|BRIF| performs a conditional branch,
and |BRTABLE| performs an indirect branch through an operand indexing into the label vector that is an immediate to the instruction, or to a default target if the operand is out of bounds.
The |RETURN| instruction is a shortcut for an unconditional branch to the outermost block, which implicitly is the body of the current function.
Taking a branch *unwinds* the operand stack up to the height where the targeted structured control instruction was entered.
However, forward branches that target a control instruction with a non-empty result type consume a matching operand first and push it back on the operand stack after unwinding, as a result for the terminated instruction.

The |CALL| instruction invokes another function, consuming the necessary arguments from the stack and returning the result values of the call.
The |CALLINDIRECT| instruction calls a function indirectly through an operand indexing into a :ref:`table <syntax-table>`.
Since tables may contain function elements of heterogeneous type |ANYFUNC|,
the callee is dynamically checked against the :ref:`function type <functype>` indexed by the instruction's immediate, and the call aborted with a :ref:`trap <trap>` if it does not match.

.. note::
   In the current version of WebAssembly,
   |CALLINDIRECT| implicitly operates on :ref:`table <syntax-table>` :ref:`index <syntax-tableidx>` :math:`0`.
   This restriction may be lifted in future versions.

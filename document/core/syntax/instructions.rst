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

Some instructions are :ref:`structured <syntax-instr-control>` in that they bracket nested sequences of instructions.

The following sections group instructions into a number of different categories.


.. index:: ! numeric instruction, value, value type, integer, floating-point, two's complement
   pair: abstract syntax; instruction
.. _syntax-sx:
.. _syntax-const:
.. _syntax-iunop:
.. _syntax-ibinop:
.. _syntax-itestop:
.. _syntax-irelop:
.. _syntax-funop:
.. _syntax-fbinop:
.. _syntax-ftestop:
.. _syntax-frelop:
.. _syntax-instr-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

Numeric instructions provide basic operations over numeric :ref:`values <syntax-value>` of specific :ref:`type <syntax-numtype>`.
These operations closely match respective operations available in hardware.

.. math::
   \begin{array}{llcl}
   \production{width} & \X{nn}, \X{mm} &::=&
     \K{32} ~|~ \K{64} \\
   \production{signedness} & \sx &::=&
     \K{u} ~|~ \K{s} \\
   \production{instruction} & \instr &::=&
     \K{i}\X{nn}\K{.}\CONST~\xref{syntax/values}{syntax-int}{\iX{\X{nn}}} ~|~
     \K{f}\X{nn}\K{.}\CONST~\xref{syntax/values}{syntax-float}{\fX{\X{nn}}} \\&&|&
     \K{i}\X{nn}\K{.}\iunop ~|~
     \K{f}\X{nn}\K{.}\funop \\&&|&
     \K{i}\X{nn}\K{.}\ibinop ~|~
     \K{f}\X{nn}\K{.}\fbinop \\&&|&
     \K{i}\X{nn}\K{.}\itestop \\&&|&
     \K{i}\X{nn}\K{.}\irelop ~|~
     \K{f}\X{nn}\K{.}\frelop \\&&|&
     \K{i}\X{nn}\K{.}\EXTEND\K{8\_s} ~|~
     \K{i}\X{nn}\K{.}\EXTEND\K{16\_s} ~|~
     \K{i64.}\EXTEND\K{32\_s} \\&&|&
     \K{i32.}\WRAP\K{\_i64} ~|~
     \K{i64.}\EXTEND\K{\_i32}\K{\_}\sx ~|~
     \K{i}\X{nn}\K{.}\TRUNC\K{\_f}\X{mm}\K{\_}\sx \\&&|&
     \K{i}\X{nn}\K{.}\TRUNC\K{\_sat\_f}\X{mm}\K{\_}\sx \\&&|&
     \K{f32.}\DEMOTE\K{\_f64} ~|~
     \K{f64.}\PROMOTE\K{\_f32} ~|~
     \K{f}\X{nn}\K{.}\CONVERT\K{\_i}\X{mm}\K{\_}\sx \\&&|&
     \K{i}\X{nn}\K{.}\REINTERPRET\K{\_f}\X{nn} ~|~
     \K{f}\X{nn}\K{.}\REINTERPRET\K{\_i}\X{nn} \\&&|&
     \dots \\
   \production{integer unary operator} & \iunop &::=&
     \K{clz} ~|~
     \K{ctz} ~|~
     \K{popcnt} \\
   \production{integer binary operator} & \ibinop &::=&
     \K{add} ~|~
     \K{sub} ~|~
     \K{mul} ~|~
     \K{div\_}\sx ~|~
     \K{rem\_}\sx \\&&|&
     \K{and} ~|~
     \K{or} ~|~
     \K{xor} ~|~
     \K{shl} ~|~
     \K{shr\_}\sx ~|~
     \K{rotl} ~|~
     \K{rotr} \\
   \production{floating-point unary operator} & \funop &::=&
     \K{abs} ~|~
     \K{neg} ~|~
     \K{sqrt} ~|~
     \K{ceil} ~|~ 
     \K{floor} ~|~ 
     \K{trunc} ~|~ 
     \K{nearest} \\
   \production{floating-point binary operator} & \fbinop &::=&
     \K{add} ~|~
     \K{sub} ~|~
     \K{mul} ~|~
     \K{div} ~|~
     \K{min} ~|~
     \K{max} ~|~
     \K{copysign} \\
   \production{integer test operator} & \itestop &::=&
     \K{eqz} \\
   \production{integer relational operator} & \irelop &::=&
     \K{eq} ~|~
     \K{ne} ~|~
     \K{lt\_}\sx ~|~
     \K{gt\_}\sx ~|~
     \K{le\_}\sx ~|~
     \K{ge\_}\sx \\
   \production{floating-point relational operator} & \frelop &::=&
     \K{eq} ~|~
     \K{ne} ~|~
     \K{lt} ~|~
     \K{gt} ~|~
     \K{le} ~|~
     \K{ge} \\
   \end{array}

Numeric instructions are divided by :ref:`number type <syntax-numtype>`.
For each type, several subcategories can be distinguished:

* *Constants*: return a static constant.

* *Unary Operations*: consume one operand and produce one result of the respective type.

* *Binary Operations*: consume two operands and produce one result of the respective type.

* *Tests*: consume one operand of the respective type and produce a Boolean integer result.

* *Comparisons*: consume two operands of the respective type and produce a Boolean integer result.

* *Conversions*: consume a value of one type and produce a result of another
  (the source type of the conversion is the one after the ":math:`\K{\_}`").

Some integer instructions come in two flavors,
where a signedness annotation |sx| distinguishes whether the operands are to be :ref:`interpreted <aux-signed>` as :ref:`unsigned <syntax-uint>` or :ref:`signed <syntax-sint>` integers.
For the other integer instructions, the use of two's complement for the signed interpretation means that they behave the same regardless of signedness.


.. _syntax-unop:
.. _syntax-binop:
.. _syntax-testop:
.. _syntax-relop:
.. _syntax-cvtop:

Conventions
...........

Occasionally, it is convenient to group operators together according to the following grammar shorthands:

.. math::
   \begin{array}{llll}
   \production{unary operator} & \unop &::=&
     \iunop ~|~
     \funop ~|~
     \EXTEND{N}\K{\_s} \\
   \production{binary operator} & \binop &::=& \ibinop ~|~ \fbinop \\
   \production{test operator} & \testop &::=& \itestop \\
   \production{relational operator} & \relop &::=& \irelop ~|~ \frelop \\
   \production{conversion operator} & \cvtop &::=&
     \WRAP ~|~
     \EXTEND ~|~
     \TRUNC ~|~
     \TRUNC\K{\_sat} ~|~
     \CONVERT ~|~
     \DEMOTE ~|~
     \PROMOTE ~|~
     \REINTERPRET \\
   \end{array}


.. index:: ! reference instruction, reference, null
   pair: abstract syntax; instruction
.. _syntax-ref.null:
.. _syntax-ref.is_null:
.. _syntax-ref.func:
.. _syntax-instr-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

Instructions in this group are concerned with accessing :ref:`references <syntax-reftype>`.

.. math::
   \begin{array}{llcl}
   \production{instruction} & \instr &::=&
     \dots \\&&|&
     \REFNULL~\reftype \\&&|&
     \REFISNULL \\&&|&
     \REFFUNC~\funcidx \\
   \end{array}

These instruction produce a null value, check for a null value, or produce a reference to a given function, respectively.


.. index:: ! parametric instruction, value type
   pair: abstract syntax; instruction
.. _syntax-instr-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

Instructions in this group can operate on operands of any :ref:`value type <syntax-valtype>`.

.. math::
   \begin{array}{llcl}
   \production{instruction} & \instr &::=&
     \dots \\&&|&
     \DROP \\&&|&
     \SELECT~(\valtype^\ast)^? \\
   \end{array}

The |DROP| instruction simply throws away a single operand.

The |SELECT| instruction selects one of its first two operands based on whether its third operand is zero or not.
It may include a :ref:`value type <syntax-valtype>` determining the type of these operands. If missing, the operands must be of :ref:`numeric type <syntax-numtype>`.

.. note::
   In future versions of WebAssembly, the type annotation on |SELECT| may allow for more than a single value being selected at the same time.


.. index:: ! variable instruction, local, global, local index, global index
   pair: abstract syntax; instruction
.. _syntax-instr-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

Variable instructions are concerned with access to :ref:`local <syntax-local>` or :ref:`global <syntax-global>` variables.

.. math::
   \begin{array}{llcl}
   \production{instruction} & \instr &::=&
     \dots \\&&|&
     \LOCALGET~\localidx \\&&|&
     \LOCALSET~\localidx \\&&|&
     \LOCALTEE~\localidx \\&&|&
     \GLOBALGET~\globalidx \\&&|&
     \GLOBALSET~\globalidx \\
   \end{array}

These instructions get or set the values of variables, respectively.
The |LOCALTEE| instruction is like |LOCALSET| but also returns its argument.


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

.. math::
   \begin{array}{llcl}
   \production{instruction} & \instr &::=&
     \dots \\&&|&
     \TABLEGET~\tableidx \\&&|&
     \TABLESET~\tableidx \\&&|&
     \TABLESIZE~\tableidx \\&&|&
     \TABLEGROW~\tableidx \\&&|&
     \TABLEFILL~\tableidx \\&&|&
     \TABLECOPY~\tableidx~\tableidx \\&&|&
     \TABLEINIT~\tableidx~\elemidx \\&&|&
     \ELEMDROP~\elemidx \\
   \end{array}

The |TABLEGET| and |TABLESET| instructions load or store an element in a table, respectively.

The |TABLESIZE| instruction returns the current size of a table.
The |TABLEGROW| instruction grows table by a given delta and returns the previous size, or :math:`-1` if enough space cannot be allocated.
It also takes an initialization value for the newly allocated entries.

The |TABLEFILL| instruction sets all entries in a range to a given value.

The |TABLECOPY| instruction copies elements from a source table region to a possibly overlapping destination region; the first index denotes the destination.
The |TABLEINIT| instruction copies elements from a :ref:`passive element segment <syntax-elem>` into a table.
The |ELEMDROP| instruction prevents further use of a passive element segment. This instruction is intended to be used as an optimization hint. After an element segment is dropped its elements can no longer be retrieved, so the memory used by this segment may be freed.

An additional instruction that accesses a table is the :ref:`control instruction <syntax-instr-control>` |CALLINDIRECT|.


.. index:: ! memory instruction, memory, memory index, page size, little endian, trap
   pair: abstract syntax; instruction
.. _syntax-loadn:
.. _syntax-storen:
.. _syntax-memarg:
.. _syntax-instr-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

Instructions in this group are concerned with linear :ref:`memory <syntax-mem>`.

.. math::
   \begin{array}{llcl}
   \production{memory immediate} & \memarg &::=&
     \{ \OFFSET~\u32, \ALIGN~\u32 \} \\
   \production{instruction} & \instr &::=&
     \dots \\&&|&
     \K{i}\X{nn}\K{.}\LOAD~\memarg ~|~
     \K{f}\X{nn}\K{.}\LOAD~\memarg \\&&|&
     \K{i}\X{nn}\K{.}\STORE~\memarg ~|~
     \K{f}\X{nn}\K{.}\STORE~\memarg \\&&|&
     \K{i}\X{nn}\K{.}\LOAD\K{8\_}\sx~\memarg ~|~
     \K{i}\X{nn}\K{.}\LOAD\K{16\_}\sx~\memarg ~|~
     \K{i64.}\LOAD\K{32\_}\sx~\memarg \\&&|&
     \K{i}\X{nn}\K{.}\STORE\K{8}~\memarg ~|~
     \K{i}\X{nn}\K{.}\STORE\K{16}~\memarg ~|~
     \K{i64.}\STORE\K{32}~\memarg \\&&|&
     \MEMORYSIZE \\&&|&
     \MEMORYGROW \\&&|&
     \MEMORYFILL \\&&|&
     \MEMORYCOPY \\&&|&
     \MEMORYINIT~\dataidx \\&&|&
     \DATADROP~\dataidx \\
   \end{array}

Memory is accessed with |LOAD| and |STORE| instructions for the different :ref:`number types <syntax-numtype>`.
They all take a *memory immediate* |memarg| that contains an address *offset* and the expected *alignment* (expressed as the exponent of a power of 2).
Integer loads and stores can optionally specify a *storage size* that is smaller than the :ref:`bit width <syntax-numtype>` of the respective value type.
In the case of loads, a sign extension mode |sx| is then required to select appropriate behavior.

The static address offset is added to the dynamic address operand, yielding a 33 bit *effective address* that is the zero-based index at which the memory is accessed.
All values are read and written in |LittleEndian|_ byte order.
A :ref:`trap <trap>` results if any of the accessed memory bytes lies outside the address range implied by the memory's current size.

.. note::
   Future version of WebAssembly might provide memory instructions with 64 bit address ranges.

The |MEMORYSIZE| instruction returns the current size of a memory.
The |MEMORYGROW| instruction grows memory by a given delta and returns the previous size, or :math:`-1` if enough memory cannot be allocated.
Both instructions operate in units of :ref:`page size <page-size>`.

The |MEMORYFILL| instruction sets all values in a region to a given byte.
The |MEMORYCOPY| instruction copies data from a source memory region to a possibly overlapping destination region.
The |MEMORYINIT| instruction copies data from a :ref:`passive data segment <syntax-data>` into a memory.
The |DATADROP| instruction prevents further use of a passive data segment. This instruction is intended to be used as an optimization hint. After a data segment is dropped its data can no longer be retrieved, so the memory used by this segment may be freed.

.. note::
   In the current version of WebAssembly,
   all memory instructions implicitly operate on :ref:`memory <syntax-mem>` :ref:`index <syntax-memidx>` :math:`0`.
   This restriction may be lifted in future versions.


.. index:: ! control instruction, ! structured control, ! label, ! block, ! block type, ! branch, ! unwinding, result type, label index, function index, type index, exception index, vector, trap, function, table, exception, function type, value type, type index, exception index
   pair: abstract syntax; instruction
   pair: abstract syntax; block type
   pair: block; type
.. _syntax-blocktype:
.. _syntax-nop:
.. _syntax-unreachable:
.. _syntax-block:
.. _syntax-loop:
.. _syntax-if:
.. _syntax-try:
.. _syntax-throw:
.. _syntax-rethrow:
.. _syntax-br_on_exn:
.. _syntax-br:
.. _syntax-br_if:
.. _syntax-br_table:
.. _syntax-return:
.. _syntax-call:
.. _syntax-call_indirect:
.. _syntax-instr-seq:
.. _syntax-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

Instructions in this group affect the flow of control.

.. math::
   \begin{array}{llcl}
   \production{block type} & \blocktype &::=&
     \typeidx ~|~ \valtype^? \\
   \production{instruction} & \instr &::=&
     \dots \\&&|&
     \NOP \\&&|&
     \UNREACHABLE \\&&|&
     \BLOCK~\blocktype~\instr^\ast~\END \\&&|&
     \LOOP~\blocktype~\instr^\ast~\END \\&&|&
     \IF~\blocktype~\instr^\ast~\ELSE~\instr^\ast~\END \\&&|&
     \TRY~\blocktype~instr^\ast~\CATCH~\instr^\ast~\END \\&&|&
     \THROW~\exnidx \\&&|&
     \RETHROW \\&&|&
     \BRONEXN~\labelidx~\exnidx \\&&|&
     \BR~\labelidx \\&&|&
     \BRIF~\labelidx \\&&|&
     \BRTABLE~\vec(\labelidx)~\labelidx \\&&|&
     \RETURN \\&&|&
     \CALL~\funcidx \\&&|&
     \CALLINDIRECT~\tableidx~\typeidx \\
   \end{array}

The |NOP| instruction does nothing.

The |UNREACHABLE| instruction causes an unconditional :ref:`trap <trap>`.

The |BLOCK|, |LOOP|, |IF|, and |TRY| instructions are *structured* instructions.
They bracket nested sequences of instructions, called *blocks*, terminated with, or separated by, either |END|, |ELSE|, or |CATCH| pseudo-instructions.
As the grammar prescribes, they must be well-nested.

The instructions |TRY|, |THROW|, |RETHROW|, and |BRONEXN| are concerned with handling exceptions.
The |THROW| and |RETHROW| instructions alter control flow by searching for the catching-try block, if any.

A structured instruction can consume *input* and produce *output* on the operand stack according to its annotated *block type*.
It is given either as a :ref:`type index <syntax-funcidx>` that refers to a suitable :ref:`function type <syntax-functype>`, or as an optional :ref:`value type <syntax-valtype>` inline, which is a shorthand for the function type :math:`[] \to [\valtype^?]`.

Each structured control instruction introduces an implicit *label*.
Labels are targets for branch instructions that reference them with :ref:`label indices <syntax-labelidx>`.
Unlike with other :ref:`index spaces <syntax-index>`, indexing of labels is relative by nesting depth,
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
   Intuitively, a branch targeting a |BLOCK| or |IF| behaves like a :math:`\K{break}` statement in most C-like languages,
   while a branch targeting a |LOOP| behaves like a :math:`\K{continue}` statement.

Branch instructions come in several flavors:
|BR| performs an unconditional branch,
|BRIF| performs a conditional branch,
|BRONEXN| performs a branch if the exception on the stack matches the specified exception index,
and |BRTABLE| performs an indirect branch through an operand indexing into the label vector that is an immediate to the instruction, or to a default target if the operand is out of bounds.
The |RETURN| instruction is a shortcut for an unconditional branch to the outermost block, which implicitly is the body of the current function.
Taking a branch *unwinds* the operand stack up to the height where the targeted structured control instruction was entered.
However, branches may additionally consume operands themselves, which they push back on the operand stack after unwinding.
Forward branches require operands according to the output of the targeted block's type, i.e., represent the values produced by the terminated block.
Backward branches require operands according to the input of the targeted block's type, i.e., represent the values consumed by the restarted block.

The |CALL| instruction invokes another :ref:`function <syntax-func>`, consuming the necessary arguments from the stack and returning the result values of the call.
The |CALLINDIRECT| instruction calls a function indirectly through an operand indexing into a :ref:`table <syntax-table>` that is denoted by a :ref:`table index <syntax-tableidx>` and must have type |FUNCREF|.
Since it may contain functions of heterogeneous type,
the callee is dynamically checked against the :ref:`function type <syntax-functype>` indexed by the instruction's second immediate, and the call is aborted with a :ref:`trap <trap>` if it does not match.


.. index:: ! expression, constant, global, offset, element, data, instruction
   pair: abstract syntax; expression
   single: expression; constant
.. _syntax-expr:

Expressions
~~~~~~~~~~~

:ref:`Function <syntax-func>` bodies, initialization values for :ref:`globals <syntax-global>`, and offsets of :ref:`element <syntax-elem>` or :ref:`data <syntax-data>` segments are given as expressions, which are sequences of :ref:`instructions <syntax-instr>` terminated by an |END| marker.

.. math::
   \begin{array}{llll}
   \production{expression} & \expr &::=&
     \instr^\ast~\END \\
   \end{array}

In some places, validation :ref:`restricts <valid-constant>` expressions to be *constant*, which limits the set of allowable instructions.

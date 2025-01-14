.. index:: instruction, ! instruction type, context, value, operand stack, ! polymorphism
.. _valid-instr:

Instructions
------------

:ref:`Instructions <syntax-instr>` are classified by :ref:`instruction types <syntax-instrtype>` that describe how they manipulate the :ref:`operand stack <stack>` and initialize :ref:`locals <syntax-local>`:
A type ${instrtype: t_1* ->_(x*) t_2*} describes the required input stack with argument values of types ${:t_1*}` that an instruction pops off
and the provided output stack with result values of types ${:t_2*} that it pushes back.
Moreover, it enumerates the :ref:`indices <syntax-localidx>` ${:x*} of locals that have been set by the instruction.
In most cases, this is empty.

.. note::
   For example, the instruction ${instr: $($(BINOP I32 ADD))} has type ${instrtype: I32 I32 -> I32},
   consuming two ${valtype: I32} values and producing one.
   The instruction ${instr: (LOCAL.SET x)} has type ${instrtype: t ->_(x) eps}, provided ${:t} is the type declared for the local ${:x}.

Typing extends to :ref:`instruction sequences <valid-instrs>` ${:instr*}.
Such a sequence has an instruction type ${instrtype: t_1* ->_(x*) t_2*} if the accumulative effect of executing the instructions is consuming values of types ${:t_1*} off the operand stack, pushing new values of types ${:t_2*}, and setting all locals ${:x*}.

.. _polymorphism:

For some instructions, the typing rules do not fully constrain the type,
and therefore allow for multiple types.
Such instructions are called *polymorphic*.
Two degrees of polymorphism can be distinguished:

* *value-polymorphic*:
  the :ref:`value type <syntax-valtype>` ${:t} of one or several individual operands is unconstrained.
  That is the case for all :ref:`parametric instructions <valid-instr-parametric>` like ${:DROP} and ${:SELECT}.

* *stack-polymorphic*:
  the entire (or most of the) :ref:`instruction type <syntax-instrtype>` ${instrtype: t_1* -> t_2*} of the instruction is unconstrained.
  That is the case for all :ref:`control instructions <valid-instr-control>` that perform an *unconditional control transfer*, such as ${:UNREACHABLE}, ${:BR}, or ${:RETURN}.

In both cases, the unconstrained types or type sequences can be chosen arbitrarily, as long as they meet the constraints imposed for the surrounding parts of the program.

.. note::
   For example, the ${:SELECT} instruction is valid with type ${instrtype: t t I32 -> t}, for any possible :ref:`number type <syntax-numtype>` ${:t}.
   Consequently, both instruction sequences

   $${instr*: (CONST I32 1) (CONST I32 2) (CONST I32 3) (SELECT)}

   and

   $${instr*: (CONST F64 $fnat(64, 1)) (CONST F64 $fnat(64, 2)) (CONST F64 $fnat(64, 3)) (SELECT)}

   are valid, with ${:t} in the typing of ${:SELECT} being instantiated to ${:I32} or ${:F64}, respectively.

   The ${:UNREACHABLE} instruction is stack-polymorphic,
   and hence valid with type ${instrtype: t_1* -> t_2*} for any possible sequences of value types ${:t_1*} and ${:t_2*}.
   Consequently,

   $${instr*: (UNREACHABLE) (BINOP I32 ADD)}

   is valid by assuming type ${instrtype: eps -> I32} for the ${:UNREACHABLE} instruction.
   In contrast,

   $${instr*: (UNREACHABLE) (CONST I64 0) (BINOP I32 ADD)}

   is invalid, because there is no possible type to pick for the ${:UNREACHABLE} instruction that would make the sequence well-typed.

The :ref:`Appendix <algo-valid>` describes a type checking :ref:`algorithm <algo-valid>` that efficiently implements validation of instruction sequences as prescribed by the rules given here.


.. index:: parametric instructions, value type, polymorphism
   pair: validation; instruction
   single: abstract syntax; instruction
.. _valid-instr-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-nop:

:math:`\NOP`
............

$${rule-prose: Instr_ok/nop}

$${rule: Instr_ok/nop}


.. _valid-unreachable:

:math:`\UNREACHABLE`
....................

$${rule-prose: Instr_ok/unreachable}

$${rule: Instr_ok/unreachable}

.. note::
   The ${:UNREACHABLE} instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-drop:

:math:`\DROP`
.............

$${rule-prose: Instr_ok/drop}

$${rule: Instr_ok/drop}

.. note::
   Both ${:DROP} and ${:SELECT} without annotation are :ref:`value-polymorphic <polymorphism>` instructions.


.. _valid-select:

:math:`\SELECT~(t^\ast)^?`
..........................

$${rule-prose: Instr_ok/select}

$${rule: {Instr_ok/select-*}}

.. note::
   In future versions of WebAssembly, ${:SELECT} may allow more than one value per choice.


.. index:: numeric instruction
   pair: validation; instruction
   single: abstract syntax; instruction
.. _valid-instr-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _valid-const:

:math:`t\K{.}\CONST~c`
......................

$${rule-prose: Instr_ok/const}

$${rule: Instr_ok/const}


.. _valid-unop:

:math:`t\K{.}\unop`
...................

$${rule-prose: Instr_ok/unop}

$${rule: Instr_ok/unop}


.. _valid-binop:

:math:`t\K{.}\binop`
....................

$${rule-prose: Instr_ok/binop}

$${rule: Instr_ok/binop}


.. _valid-testop:

:math:`t\K{.}\testop`
.....................

$${rule-prose: Instr_ok/testop}

$${rule: Instr_ok/testop}


.. _valid-relop:

:math:`t\K{.}\relop`
....................

$${rule-prose: Instr_ok/relop}

$${rule: Instr_ok/relop}


.. _valid-cvtop:

:math:`t_1\K{.}\cvtop\K{\_}t_2\K{\_}\sx^?`
..........................................

$${rule-prose: Instr_ok/cvtop}

$${rule: Instr_ok/cvtop}


.. index:: reference instructions, reference type
   pair: validation; instruction
   single: abstract syntax; instruction
.. _valid-instr-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _valid-ref.null:

:math:`\REFNULL~\X{ht}`
.......................

$${rule-prose: Instr_ok/ref.null}

$${rule: Instr_ok/ref.null}


.. _valid-ref.func:

:math:`\REFFUNC~x`
..................

$${rule-prose: Instr_ok/ref.func}

$${rule: Instr_ok/ref.func}


.. _valid-ref.is_null:

:math:`\REFISNULL`
..................

$${rule-prose: Instr_ok/ref.is_null}

$${rule: Instr_ok/ref.is_null}


.. _valid-ref.as_non_null:

:math:`\REFASNONNULL`
.....................

$${rule-prose: Instr_ok/ref.as_non_null}

$${rule: Instr_ok/ref.as_non_null}


.. _valid-ref.eq:

:math:`\REFEQ`
..............

$${rule-prose: Instr_ok/ref.eq}

$${rule: Instr_ok/ref.eq}


.. _valid-ref.test:

:math:`\REFTEST~\X{rt}`
.......................

$${rule-prose: Instr_ok/ref.test}

$${rule: Instr_ok/ref.test}

.. note::
   The liberty to pick a supertype ${:rt'} allows typing the instruction with the least precise super type of ${:rt} as input, that is, the top type in the corresponding heap subtyping hierarchy.


.. _valid-ref.cast:

:math:`\REFCAST~\X{rt}`
.......................

$${rule-prose: Instr_ok/ref.cast}

$${rule: Instr_ok/ref.cast}

.. note::
   The liberty to pick a supertype ${:rt'} allows typing the instruction with the least precise super type of ${:rt} as input, that is, the top type in the corresponding heap subtyping hierarchy.


.. index:: aggregate reference

Aggregate Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-struct.new:

:math:`\STRUCTNEW~x`
....................

$${rule-prose: Instr_ok/struct.new}

$${rule: Instr_ok/struct.new}


.. _valid-struct.new_default:

:math:`\STRUCTNEWDEFAULT~x`
...........................

$${rule-prose: Instr_ok/struct.new_default}

$${rule: Instr_ok/struct.new_default}


.. _valid-struct.get:
.. _valid-struct.get_u:
.. _valid-struct.get_s:

:math:`\STRUCTGET\K{\_}\sx^?~x~y`
.................................

$${rule-prose: Instr_ok/struct.get}

$${rule: Instr_ok/struct.get}


.. _valid-struct.set:

:math:`\STRUCTSET~x~y`
......................

$${rule-prose: Instr_ok/struct.set}

$${rule: Instr_ok/struct.set}


.. _valid-array.new:

:math:`\ARRAYNEW~x`
...................

$${rule-prose: Instr_ok/array.new}

$${rule: Instr_ok/array.new}


.. _valid-array.new_default:

:math:`\ARRAYNEWDEFAULT~x`
..........................

$${rule-prose: Instr_ok/array.new_default}

$${rule: Instr_ok/array.new_default}


.. _valid-array.new_fixed:

:math:`\ARRAYNEWFIXED~x~n`
..........................

$${rule-prose: Instr_ok/array.new_fixed}

$${rule: Instr_ok/array.new_fixed}


.. _valid-array.new_elem:

:math:`\ARRAYNEWELEM~x~y`
.........................

$${rule-prose: Instr_ok/array.new_elem}

$${rule: Instr_ok/array.new_elem}


.. _valid-array.new_data:

:math:`\ARRAYNEWDATA~x~y`
.........................

$${rule-prose: Instr_ok/array.new_data}

$${rule: Instr_ok/array.new_data}


.. _valid-array.get:
.. _valid-array.get_u:
.. _valid-array.get_s:

:math:`\ARRAYGET\K{\_}\sx^?~x`
..............................

$${rule-prose: Instr_ok/array.get}

$${rule: Instr_ok/array.get}


.. _valid-array.set:

:math:`\ARRAYSET~x`
...................

$${rule-prose: Instr_ok/array.set}

$${rule: Instr_ok/array.set}


.. _valid-array.len:

:math:`\ARRAYLEN`
.................

$${rule-prose: Instr_ok/array.len}

$${rule: Instr_ok/array.len}


.. _valid-array.fill:

:math:`\ARRAYFILL~x`
....................

$${rule-prose: Instr_ok/array.fill}

$${rule: Instr_ok/array.fill}


.. _valid-array.copy:

:math:`\ARRAYCOPY~x~y`
......................

$${rule-prose: Instr_ok/array.copy}

$${rule: Instr_ok/array.copy}


.. _valid-array.init_elem:

:math:`\ARRAYINITELEM~x~y`
..........................

$${rule-prose: Instr_ok/array.init_elem}

$${rule: Instr_ok/array.init_elem}


.. _valid-array.init_data:

:math:`\ARRAYINITDATA~x~y`
..........................

$${rule-prose: Instr_ok/array.init_data}

$${rule: Instr_ok/array.init_data}


.. index:: scalar reference

Scalar Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-ref.i31:

:math:`\REFI31`
...............

$${rule-prose: Instr_ok/ref.i31}

$${rule: Instr_ok/ref.i31}


.. _valid-i31.get_sx:

:math:`\I31GET\K{\_}\sx`
........................

$${rule-prose: Instr_ok/i31.get}

$${rule: Instr_ok/i31.get}



.. index:: external reference

External Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-any.convert_extern:

:math:`\ANYCONVERTEXTERN`
.........................

$${rule-prose: Instr_ok/any.convert_extern}

$${rule: Instr_ok/any.convert_extern}


.. _valid-extern.convert_any:

:math:`\EXTERNCONVERTANY`
.........................

$${rule-prose: Instr_ok/extern.convert_any}

$${rule: Instr_ok/extern.convert_any}


.. index:: vector instruction
   pair: validation; instruction
   single: abstract syntax; instruction

.. _valid-instr-vec:
.. _aux-unpackshape:

Vector Instructions
~~~~~~~~~~~~~~~~~~~
Vector instructions can have a prefix to describe the :ref:`shape <syntax-shape>` of the operand. Packed numeric types, ${packtype:I8} and ${packtype:I16}, are not :ref:`value types <syntax-valtype>`. An auxiliary function maps such packed type shapes to value types:

$${definition: unpackshape}


.. _valid-vconst:

:math:`\V128\K{.}\VCONST~c`
...........................

$${rule-prose: Instr_ok/vconst}

$${rule: Instr_ok/vconst}


.. _valid-vvunop:

:math:`\V128\K{.}\vvunop`
.........................

$${rule-prose: Instr_ok/vvunop}

$${rule: Instr_ok/vvunop}


.. _valid-vvbinop:

:math:`\V128\K{.}\vvbinop`
..........................

$${rule-prose: Instr_ok/vvbinop}

$${rule: Instr_ok/vvbinop}


.. _valid-vvternop:

:math:`\V128\K{.}\vvternop`
...........................

$${rule-prose: Instr_ok/vvternop}

$${rule: Instr_ok/vvternop}


.. _valid-vvtestop:

:math:`\V128\K{.}\vvtestop`
...........................

$${rule-prose: Instr_ok/vvtestop}

$${rule: Instr_ok/vvtestop}


.. _valid-vunop:

:math:`\shape\K{.}\vunop`
.........................

$${rule-prose: Instr_ok/vunop}

$${rule: Instr_ok/vunop}


.. _valid-vbinop:

:math:`\shape\K{.}\vbinop`
..........................

$${rule-prose: Instr_ok/vbinop}

$${rule: Instr_ok/vbinop}


.. _valid-vternop:

:math:`\shape\K{.}\vternop`
...........................

$${rule-prose: Instr_ok/vternop}

$${rule: Instr_ok/vternop}


.. _valid-vtestop:

:math:`\shape\K{.}\vtestop`
...........................

$${rule-prose: Instr_ok/vtestop}

$${rule: Instr_ok/vtestop}


.. _valid-vrelop:

:math:`\shape\K{.}\vrelop`
..........................

$${rule-prose: Instr_ok/vrelop}

$${rule: Instr_ok/vrelop}


.. _valid-vshiftop:

:math:`\ishape\K{.}\vishiftop`
..............................

$${rule-prose: Instr_ok/vshiftop}

$${rule: Instr_ok/vshiftop}


.. _valid-vbitmask:

:math:`\ishape\K{.}\VBITMASK`
.............................

$${rule-prose: Instr_ok/vbitmask}

$${rule: Instr_ok/vbitmask}


.. _valid-vswizzlop:

:math:`\K{i8x16.}\vswizzlop`
............................

$${rule-prose: Instr_ok/vswizzlop}

$${rule: Instr_ok/vswizzlop}


.. _valid-vshuffle:

:math:`\K{i8x16.}\VSHUFFLE~\laneidx^{16}`
.........................................

$${rule-prose: Instr_ok/vshuffle}

$${rule: Instr_ok/vshuffle}


.. _valid-vsplat:

:math:`\shape\K{.}\VSPLAT`
..........................

$${rule-prose: Instr_ok/vsplat}

$${rule: Instr_ok/vsplat}


.. _valid-vextract_lane:

:math:`\shape\K{.}\VEXTRACTLANE\K{\_}\sx^?~\laneidx`
....................................................

$${rule-prose: Instr_ok/vextract_lane}

$${rule: Instr_ok/vextract_lane}


.. _valid-vreplace_lane:

:math:`\shape\K{.}\VREPLACELANE~\laneidx`
.........................................

$${rule-prose: Instr_ok/vreplace_lane}

$${rule: Instr_ok/vreplace_lane}


.. _valid-vextunop:

:math:`\ishape_1\K{.}\vextunop\K{\_}\ishape_2`
..............................................

$${rule-prose: Instr_ok/vextunop}

$${rule: Instr_ok/vextunop}


.. _valid-vextbinop:

:math:`\ishape_1\K{.}\vextbinop\K{\_}\ishape_2`
...............................................

$${rule-prose: Instr_ok/vextbinop}

$${rule: Instr_ok/vextbinop}


.. _valid-vextternop:

:math:`\ishape_1\K{.}\vextternop\K{\_}\ishape_2`
................................................

$${rule-prose: Instr_ok/vextternop}

$${rule: Instr_ok/vextternop}


.. _valid-vnarrow:

:math:`\ishape_1\K{.}\VNARROW\K{\_}\ishape_2\K{\_}\sx`
......................................................

$${rule-prose: Instr_ok/vnarrow}

$${rule: Instr_ok/vnarrow}


.. _valid-vcvtop:

:math:`\shape\K{.}\vcvtop\K{\_}\half^?\K{\_}\shape\K{\_}\sx^?\K{\_zero}^?`
..........................................................................

$${rule-prose: Instr_ok/vcvtop}

$${rule: Instr_ok/vcvtop}


.. index:: variable instructions, local index, global index, context
   pair: validation; instruction
   single: abstract syntax; instruction
.. _valid-instr-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _valid-local.get:

:math:`\LOCALGET~x`
...................

$${rule-prose: Instr_ok/local.get}

$${rule: Instr_ok/local.get}


.. _valid-local.set:

:math:`\LOCALSET~x`
...................

$${rule-prose: Instr_ok/local.set}

$${rule: Instr_ok/local.set}


.. _valid-local.tee:

:math:`\LOCALTEE~x`
...................

$${rule-prose: Instr_ok/local.tee}

$${rule: Instr_ok/local.tee}


.. _valid-global.get:

:math:`\GLOBALGET~x`
....................

$${rule-prose: Instr_ok/global.get}

$${rule: Instr_ok/global.get}


.. _valid-global.set:

:math:`\GLOBALSET~x`
....................

$${rule-prose: Instr_ok/global.set}

$${rule: Instr_ok/global.set}


.. index:: table instruction, table index, context
   pair: validation; instruction
   single: abstract syntax; instruction
.. _valid-instr-table:

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _valid-table.get:

:math:`\TABLEGET~x`
...................

$${rule-prose: Instr_ok/table.get}

$${rule: Instr_ok/table.get}


.. _valid-table.set:

:math:`\TABLESET~x`
...................

$${rule-prose: Instr_ok/table.set}

$${rule: Instr_ok/table.set}


.. _valid-table.size:

:math:`\TABLESIZE~x`
....................

$${rule-prose: Instr_ok/table.size}

$${rule: Instr_ok/table.size}


.. _valid-table.grow:

:math:`\TABLEGROW~x`
....................

$${rule-prose: Instr_ok/table.grow}

$${rule: Instr_ok/table.grow}


.. _valid-table.fill:

:math:`\TABLEFILL~x`
....................

$${rule-prose: Instr_ok/table.fill}

$${rule: Instr_ok/table.fill}


.. _valid-table.copy:

:math:`\TABLECOPY~x~y`
......................

$${rule-prose: Instr_ok/table.copy}

$${rule: Instr_ok/table.copy}


.. _valid-table.init:

:math:`\TABLEINIT~x~y`
......................

$${rule-prose: Instr_ok/table.init}

$${rule: Instr_ok/table.init}


.. _valid-elem.drop:

:math:`\ELEMDROP~x`
...................

$${rule-prose: Instr_ok/elem.drop}

$${rule: Instr_ok/elem.drop}


.. index:: memory instruction, memory index, context
   pair: validation; instruction
   single: abstract syntax; instruction
.. _valid-memarg:
.. _valid-instr-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _valid-load-val:

:math:`t\K{.}\LOAD~x~\memarg`
.............................

$${rule-prose: Instr_ok/load-val}

$${rule: Instr_ok/load-val}


.. _valid-load-pack:

:math:`t\K{.}\LOAD{N}\K{\_}\sx~x~\memarg`
.........................................

$${rule-prose: Instr_ok/load-pack}

$${rule: Instr_ok/load-pack}


.. _valid-store-val:

:math:`t\K{.}\STORE~x~\memarg`
..............................

$${rule-prose: Instr_ok/store-val}

$${rule: Instr_ok/store-val}


.. _valid-store-pack:

:math:`t\K{.}\STORE{N}~x~\memarg`
.................................

$${rule-prose: Instr_ok/store-pack}

$${rule: Instr_ok/store-pack}


.. _valid-vload-val:

:math:`\K{v128.}\LOAD~x~\memarg`
.....................................

$${rule-prose: Instr_ok/vload-val}

$${rule: Instr_ok/vload-val}


.. _valid-vload-pack:

:math:`\K{v128.}\LOAD{N}\K{x}M\_\sx~x~\memarg`
..............................................

$${rule-prose: Instr_ok/vload-pack}

$${rule: Instr_ok/vload-pack}


.. _valid-vload-splat:

:math:`\K{v128.}\LOAD{N}\K{\_splat}~x~\memarg`
..............................................

$${rule-prose: Instr_ok/vload-splat}

$${rule: Instr_ok/vload-splat}


.. _valid-vload-zero:

:math:`\K{v128.}\LOAD{N}\K{\_zero}~x~\memarg`
.............................................

$${rule-prose: Instr_ok/vload-zero}

$${rule: Instr_ok/vload-zero}


.. _valid-vload_lane:

:math:`\K{v128.}\LOAD{N}\K{\_lane}~x~\memarg~\laneidx`
......................................................

$${rule-prose: Instr_ok/vload_lane}

$${rule: Instr_ok/vload_lane}


.. _valid-vstore:

:math:`\K{v128.}\STORE~x~\memarg`
.................................

$${rule-prose: Instr_ok/vstore}

$${rule: Instr_ok/vstore}


.. _valid-vstore_lane:

:math:`\K{v128.}\STORE{N}\K{\_lane}~x~\memarg~\laneidx`
.......................................................

$${rule-prose: Instr_ok/vstore_lane}

$${rule: Instr_ok/vstore_lane}


.. _valid-memory.size:

:math:`\MEMORYSIZE~x`
.....................

$${rule-prose: Instr_ok/memory.size}

$${rule: Instr_ok/memory.size}


.. _valid-memory.grow:

:math:`\MEMORYGROW~x`
.....................

$${rule-prose: Instr_ok/memory.grow}

$${rule: Instr_ok/memory.grow}


.. _valid-memory.fill:

:math:`\MEMORYFILL~x`
.....................

$${rule-prose: Instr_ok/memory.fill}

$${rule: Instr_ok/memory.fill}


.. _valid-memory.copy:

:math:`\MEMORYCOPY~x~y`
.......................

$${rule-prose: Instr_ok/memory.copy}

$${rule: Instr_ok/memory.copy}


.. _valid-memory.init:

:math:`\MEMORYINIT~x~y`
.......................

$${rule-prose: Instr_ok/memory.init}

$${rule: Instr_ok/memory.init}


.. _valid-data.drop:

:math:`\DATADROP~x`
...................

$${rule-prose: Instr_ok/data.drop}

$${rule: Instr_ok/data.drop}


.. index:: control instructions, structured control, label, block, branch, block type, label index, result type, function index, type index, tag index, list, polymorphism, context
   pair: validation; instruction
   single: abstract syntax; instruction
.. _valid-label:
.. _valid-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _valid-block:

:math:`\BLOCK~\blocktype~\instr^\ast~\END`
..........................................

$${rule-prose: Instr_ok/block}

$${rule: Instr_ok/block}

.. note::
   The :ref:`notation <notation-concat>` ${context: {LABELS (t*)} ++ C} inserts the new label type at index ${:0}, shifting all others.
   The same applies to all other block instructions.


.. _valid-loop:

:math:`\LOOP~\blocktype~\instr^\ast~\END`
.........................................

$${rule-prose: Instr_ok/loop}

$${rule: Instr_ok/loop}


.. _valid-if:

:math:`\IF~\blocktype~\instr_1^\ast~\ELSE~\instr_2^\ast~\END`
.............................................................

$${rule-prose: Instr_ok/if}

$${rule: Instr_ok/if}



.. _valid-try_table:

:math:`\TRYTABLE~\blocktype~\catch^\ast~\instr^\ast~\END`
.........................................................

$${rule-prose: Instr_ok/try_table}

$${rule: Instr_ok/try_table}


.. _valid-catch:

:math:`\CATCH~x~l`
..................

$${rule-prose: Catch_ok/catch}

$${rule: Catch_ok/catch}


:math:`\CATCHREF~x~l`
.....................

$${rule-prose: Catch_ok/catch_ref}

$${rule: Catch_ok/catch_ref}


:math:`\CATCHALL~l`
...................

$${rule-prose: Catch_ok/catch_all}

$${rule: Catch_ok/catch_all}


:math:`\CATCHALLREF~l`
......................

$${rule-prose: Catch_ok/catch_all_ref}

$${rule: Catch_ok/catch_all_ref}


.. _valid-br:

:math:`\BR~l`
.............

$${rule-prose: Instr_ok/br}

$${rule: Instr_ok/br}

.. note::
   The :ref:`label index <syntax-labelidx>` space in the :ref:`context <context>` ${:C} contains the most recent label first, so that ${:C.LABELS[l]} performs a relative lookup as expected.
   This applies to other branch instructions as well.

   The ${:BR} instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-br_if:

:math:`\BRIF~l`
...............

$${rule-prose: Instr_ok/br_if}

$${rule: Instr_ok/br_if}


.. _valid-br_table:

:math:`\BRTABLE~l^\ast~l_N`
...........................

$${rule-prose: Instr_ok/br_table}

$${rule: Instr_ok/br_table}

.. note::
   The ${:BR_TABLE} instruction is :ref:`stack-polymorphic <polymorphism>`.

   Furthermore, the :ref:`result type <syntax-resulttype>` ${:t*} is also chosen non-deterministically in this rule.
   Although it may seem necessary to compute ${:t*} as the greatest lower bound of all label types in practice,
   a simple :ref:`sequential algorithm <algo-valid>` does not require this.


.. _valid-br_on_null:

:math:`\BRONNULL~l`
...................

$${rule-prose: Instr_ok/br_on_null}

$${rule: Instr_ok/br_on_null}


.. _valid-br_on_non_null:

:math:`\BRONNONNULL~l`
......................

$${rule-prose: Instr_ok/br_on_non_null}

$${rule: Instr_ok/br_on_non_null}


.. _valid-br_on_cast:

:math:`\BRONCAST~l~\X{rt}_1~\X{rt}_2`
.....................................

$${rule-prose: Instr_ok/br_on_cast}

$${rule: Instr_ok/br_on_cast}


.. _valid-br_on_cast_fail:

:math:`\BRONCASTFAIL~l~\X{rt}_1~\X{rt}_2`
.........................................

$${rule-prose: Instr_ok/br_on_cast_fail}

$${rule: Instr_ok/br_on_cast_fail}


.. _valid-call:

:math:`\CALL~x`
...............

$${rule-prose: Instr_ok/call}

$${rule: Instr_ok/call}


.. _valid-call_ref:

:math:`\CALLREF~x`
..................

$${rule-prose: Instr_ok/call_ref}

$${rule: Instr_ok/call_ref}


.. _valid-call_indirect:

:math:`\CALLINDIRECT~x~y`
.........................

$${rule-prose: Instr_ok/call_indirect}

$${rule: Instr_ok/call_indirect}


.. _valid-return:

:math:`\RETURN`
...............

$${rule-prose: Instr_ok/return}

$${rule: Instr_ok/return}

.. note::
   The ${:RETURN} instruction is :ref:`stack-polymorphic <polymorphism>`.

   ${resulttype?: C.RETURN} is absent (set to ${:eps}) when validating an :ref:`expression <valid-expr>` that is not a function body.
   This differs from it being set to the empty result type ${:[eps]},
   which is the case for functions not returning anything.


.. _valid-return_call:

:math:`\RETURNCALL~x`
.....................

$${rule-prose: Instr_ok/return_call}

$${rule: Instr_ok/return_call}

.. note::
   The ${:RETURN_CALL} instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-return_call_ref:

:math:`\RETURNCALLREF~x`
........................

$${rule-prose: Instr_ok/return_call_ref}

$${rule: Instr_ok/return_call_ref}

.. note::
   The ${:RETURN_CALL_REF} instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-return_call_indirect:

:math:`\RETURNCALLINDIRECT~x~y`
...............................

$${rule-prose: Instr_ok/return_call_indirect}

$${rule: Instr_ok/return_call_indirect}

.. note::
   The ${:RETURN_CALL_INDIRECT} instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-throw:

:math:`\THROW~x`
................

$${rule-prose: Instr_ok/throw}

$${rule: Instr_ok/throw}

.. note::
   The ${:THROW} instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-throw_ref:

:math:`\THROWREF`
.................

$${rule-prose: Instr_ok/throw_ref}

$${rule: Instr_ok/throw_ref}

.. note::
   The ${:THROW_REF} instruction is :ref:`stack-polymorphic <polymorphism>`.


.. index:: instruction, instruction sequence, local type
.. _valid-instrs:

Instruction Sequences
~~~~~~~~~~~~~~~~~~~~~

Typing of instruction sequences is defined recursively.


Empty Instruction Sequence: :math:`\epsilon`
............................................

$${rule-prose: Instrs_ok}


$${rule: Instrs_ok/empty}

$${rule: Instrs_ok/seq}

$${rule: {Instrs_ok/sub Instrs_ok/frame}}

.. note::
   In combination with the previous rule,
   subsumption allows to compose instructions whose types would not directly fit otherwise.
   For example, consider the instruction sequence

   $${instr*: (CONST I32 1) (CONST I32 2) (BINOP I32 ADD)}

   To type this sequence, its subsequence ${instr*: (CONST I32 2) (BINOP I32 ADD)} needs to be valid with an intermediate type.
   But the direct type of ${instr: (CONST I32 2)} is ${instrtype: eps -> I32}, not matching the two inputs expected by ${instr: $($(BINOP I32 ADD))}.
   The subsumption rule allows to weaken the type of ${:(CONST I32 2)} to the supertype ${instrtype: I32 -> I32 I32}, such that it can be composed with ${instr: $($(BINOP I32 ADD))} and yields the intermediate type ${instrtype: I32 -> I32 I32} for the subsequence. That can in turn be composed with the first constant.

   Furthermore, subsumption allows to drop init variables ${:x*} from the instruction type in a context where they are not needed, for example, at the end of the body of a :ref:`block <valid-block>`.


.. index:: expression, result type
   pair: validation; expression
   single: abstract syntax; expression
   single: expression; constant
.. _valid-expr:

Expressions
~~~~~~~~~~~

Expressions ${:expr} are classified by :ref:`result types <syntax-resulttype>` ${:t*}.

$${rule-prose: Expr_ok}

$${rule: Expr_ok}


.. index:: ! constant
.. _valid-constant:

Constant Expressions
....................

In a *constant* expression, all instructions must be constant.

$${rule-prose: Expr_const}

$${rule-prose: Instr_const}


$${rule: Expr_const}

$${rule:
  {Instr_const/const Instr_const/vconst Instr_const/binop}
  {Instr_const/ref.null Instr_const/ref.i31 Instr_const/ref.func}
  {Instr_const/struct.new Instr_const/struct.new_default}
  {Instr_const/array.new Instr_const/array.new_default Instr_const/array.new_fixed}
  {Instr_const/any.convert_extern Instr_const/extern.convert_any}
  {Instr_const/global.get}
}

.. note::
   Currently, constant expressions occurring in :ref:`globals <syntax-global>` are further constrained in that contained ${:GLOBAL.GET} instructions are only allowed to refer to *imported* or *previously defined* globals. Constant expressions occurring in :ref:`tables <syntax-table>` may only have ${:GLOBAL.GET} instructions that refer to *imported* globals.
   This is enforced in the :ref:`validation rule for modules <valid-module>` by constraining the context ${:C} accordingly.

   The definition of constant expression may be extended in future versions of WebAssembly.

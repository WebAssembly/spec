.. _valid-instr:
.. index:: instruction, function type, context

Instructions
------------

:ref:`Instructions <syntax-instr>` are classified by :ref:`function types <syntax-functype>` :math:`[t_1^\ast] \to [t_2^\ast]`
that describe how they manipulate the :ref:`operand stack <stack>`.
The types describe the required input stack with argument values of types :math:`t_1^\ast` that an instruction pops off
and the provided output stack with result values of types :math:`t_2^\ast` that it pushes back.

.. note::
   For example, the instruction :math:`\I32.\ADD` has type :math:`[\I32~\I32] \to [\I32]`,
   consuming two |I32| values and producing one.

Typing extends to :ref:`instruction sequences <valid-instr-seq>` :math:`\instr^\ast`.
Such a sequence has a :ref:`function types <syntax-functype>` :math:`[t_1^\ast] \to [t_2^\ast]` if the accumulative effect of executing the instructions is consuming values of types :math:`t_1^\ast` off the operand stack and pushing new values of types :math:`t_2^\ast`.

.. _polymorphism:

For some instructions, the typing rules do not fully constrain the type,
and therefor allow for multiple types.
Such instructions are called *polymorphic*.
Two degrees of polymorphism can be distinguished:

* *value-polymorphic*:
  the :ref:`value type <syntax-valtype>` :math:`t` of one or several individual operands is unconstrained.
  That is the case for all :ref:`parametric instructions <valid-instr-parametric>` like |DROP| and |SELECT|.


* *stack-polymorphic*:
  the entire (or most of the) :ref:`function type <syntax-functype>` :math:`[t_1^\ast] \to [t_2^\ast]` of the instruction is unconstrained.
  That is the case for all :ref:`control instructions <valid-instr-control>` that perform an *unconditional control transfer*, such as |UNREACHABLE|, |BR|, |BRTABLE|, and |RETURN|.

In both cases, the unconstrained types or type sequences can be chosen arbitrarily, as long as they meet the constraints imposed for the surrounding parts of the program.

.. note::
   For example, the |SELECT| instruction is valid with type :math:`[t~t~\I32] \to [t]`, for any possible :ref:`value type <syntax-valtype>` :math:`t`.   Consequently, both instruction sequences

   .. math::
      (\I32.\CONST~1)~~(\I32.\CONST~2)~~(\I32.\CONST~3)~~\SELECT{}

   and

   .. math::
      (\F64.\CONST~1.0)~~(\F64.\CONST~2.0)~~(\I32.\CONST~3)~~\SELECT{}

   are valid, with :math:`t` in the typing of |SELECT| being instantiated to |I32| or |F64|, respectively.

   The |UNREACHABLE| instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]` for any possible sequences of value types :math:`t_1^\ast` and :math:`t_2^\ast`.
   Consequently,

   .. math::
      \UNREACHABLE~~\I32.\ADD

   is valid by assuming type :math:`[] \to [\I32~\I32]` for the |UNREACHABLE| instruction.
   In contrast,

   .. math::
      \UNREACHABLE~~(\I64.\CONST~0)~~\I32.\ADD

   is invalid, because there is no possible type to pick for the |UNREACHABLE| instruction that would make the sequence well-typed.


.. _valid-instr-numeric:
.. index:: numeric instruction
   pair: validation; instruction
   single: abstract syntax; instruction

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

In this section, the following grammar shorthands are adopted:

.. math::
   \begin{array}{llll}
   \production{unary operators} & \unop &::=&
     \CLZ ~|~
     \CTZ ~|~
     \POPCNT ~|~
     \ABS ~|~
     \NEG ~|~
     \SQRT ~|~
     \CEIL ~|~
     \FLOOR ~|~
     \TRUNC ~|~
     \NEAREST \\
   \production{binary operators} & \binop &::=&
     \ADD ~|~
     \SUB ~|~
     \MUL ~|~
     \DIV ~|~
     \DIV\K{\_}\sx ~|~
     \REM\K{\_}\sx ~|~
     \FMIN ~|~
     \FMAX ~|~
     \COPYSIGN ~|~ \\&&&
     \AND ~|~
     \OR ~|~
     \XOR ~|~
     \SHL ~|~
     \SHR\K{\_}\sx ~|~
     \ROTL ~|~
     \ROTR \\
   \production{test operators} & \testop &::=&
     \EQZ \\
   \production{relational operators} & \relop &::=&
     \EQ ~|~
     \NE ~|~
     \LT ~|~
     \GT ~|~
     \LE ~|~
     \GE ~|~
     \LT\K{\_}\sx ~|~
     \GT\K{\_}\sx ~|~
     \LE\K{\_}\sx ~|~
     \GE\K{\_}\sx \\
   \production{conversion operators} & \cvtop &::=&
     \WRAP ~|~
     \EXTEND\K{\_}\sx ~|~
     \TRUNC\K{\_}\sx ~|~
     \CONVERT\K{\_}\sx ~|~
     \DEMOTE ~|~
     \PROMOTE ~|~
     \REINTERPRET \\
   \end{array}


.. _valid-const:

:math:`t \K{.const}~c`
......................

* The instruction is valid with type :math:`[] \to [t]`.

.. math::
   \frac{
   }{
     C \vdash t\K{.const}~c : [] \to [t]
   }


.. _valid-unop:

:math:`t\K{.}\unop`
...................

* The instruction is valid with type :math:`[t] \to [t]`.

.. math::
   \frac{
   }{
     C \vdash t\K{.}\unop : [t] \to [t]
   }


.. _valid-binop:

:math:`t\K{.}\binop`
....................

* The instruction is valid with type :math:`[t~t] \to [t]`.

.. math::
   \frac{
   }{
     C \vdash t\K{.}\binop : [t~t] \to [t]
   }


.. _valid-testop:

:math:`t\K{.}\testop`
.....................

* The instruction is valid with type :math:`[t] \to [\I32]`.

.. math::
   \frac{
   }{
     C \vdash t\K{.}\testop : [t] \to [\I32]
   }


.. _valid-relop:

:math:`t\K{.}\relop`
....................

* The instruction is valid with type :math:`[t~t] \to [\I32]`.

.. math::
   \frac{
   }{
     C \vdash t\K{.}\relop : [t~t] \to [\I32]
   }


.. _valid-cvtop:

:math:`t_2\K{.}\cvtop/t_1`
..........................

* The instruction is valid with type :math:`[t_1] \to [t_2]`.

.. math::
   \frac{
   }{
     C \vdash t_2\K{.}\cvtop/t_1 : [t_1] \to [t_2]
   }


.. _valid-instr-parametric:
.. index:: parametric instructions, value type, polymorphism
   pair: validation; instruction
   single: abstract syntax; instruction

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-drop:

:math:`\DROP`
.............

* The instruction is valid with type :math:`[t] \to []`, for any :ref:`value type <syntax-valtype>` :math:`t`.

.. math::
   \frac{
   }{
     C \vdash \DROP : [t] \to []
   }


.. _valid-select:

:math:`\SELECT`
...............

* The instruction is valid with type :math:`[t~t~\I32] \to [t]`, for any :ref:`value type <syntax-valtype>` :math:`t`.

.. math::
   \frac{
   }{
     C \vdash \SELECT : [t~t~\I32] \to [t]
   }

.. note::
   Both |DROP| and |SELECT| are :ref:`value-polymorphic <polymorphism>` instructions.


.. _valid-instr-variable:
.. index:: variable instructions, local index, global index
   pair: validation; instruction
   single: abstract syntax; instruction

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _valid-get_local:

:math:`\GETLOCAL~x`
...................

* The local :math:`C.\LOCALS[x]` must be defined in the context.

* Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`C.\LOCALS[x]`.

* Then the instruction is valid with type :math:`[] \to [t]`.

.. math::
   \frac{
     C.\LOCALS[x] = t
   }{
     C \vdash \GETLOCAL~x : [] \to [t]
   }


.. _valid-set_local:

:math:`\SETLOCAL~x`
...................

* The local :math:`C.\LOCALS[x]` must be defined in the context.

* Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`C.\LOCALS[x]`.

* Then the instruction is valid with type :math:`[t] \to []`.

.. math::
   \frac{
     C.\LOCALS[x] = t
   }{
     C \vdash \SETLOCAL~x : [t] \to []
   }


.. _valid-tee_local:

:math:`\TEELOCAL~x`
...................

* The local :math:`C.\LOCALS[x]` must be defined in the context.

* Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`C.\LOCALS[x]`.

* Then the instruction is valid with type :math:`[t] \to [t]`.

.. math::
   \frac{
     C.\LOCALS[x] = t
   }{
     C \vdash \TEELOCAL~x : [t] \to [t]
   }


.. _valid-get_global:

:math:`\GETGLOBAL~x`
....................

* The global :math:`C.\GLOBALS[x]` must be defined in the context.

* Let :math:`\mut~t` be the :ref:`value type <syntax-globaltype>` :math:`C.\LOCALS[x]`.

* Then the instruction is valid with type :math:`[] \to [t]`.

.. math::
   \frac{
     C.\GLOBALS[x] = \mut~t
   }{
     C \vdash \GETGLOBAL~x : [] \to [t]
   }


.. _valid-set_global:

:math:`\SETGLOBAL~x`
....................

* The global :math:`C.\GLOBALS[x]` must be defined in the context.

* Let :math:`\mut~t` be the :ref:`global type <syntax-globaltype>` :math:`C.\GLOBALS[x]`.

* The mutability :math:`\mut` must be |MUT|.

* Then the instruction is valid with type :math:`[t] \to []`.

.. math::
   \frac{
     C.\GLOBALS[x] = \MUT~t
   }{
     C \vdash \SETGLOBAL~x : [t] \to []
   }


.. _valid-instr-memory:
.. _valid-memarg:
.. index:: memory instruction, memory index
   pair: validation; instruction
   single: abstract syntax; instruction

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _valid-load:

:math:`t\K{.load}~\memarg`
..........................

* The memory :math:`C.\MEMS[0]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than the :ref:`width <syntax-valtype>` of :math:`t`.

* Then the instruction is valid with type :math:`[\I32] \to [t]`.

.. math::
   \frac{
     C.\MEMS[0] = \memtype
     \qquad
     2^{\memarg.\ALIGN} \leq |t|
   }{
     C \vdash t\K{.load}~\memarg : [\I32] \to [t]
   }


.. _valid-loadn:

:math:`t\K{.load}N\K{\_}\sx~\memarg`
....................................

* The memory :math:`C.\MEMS[0]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than :math:`N`.

* Then the instruction is valid with type :math:`[\I32] \to [t]`.

.. math::
   \frac{
     C.\MEMS[0] = \memtype
     \qquad
     2^{\memarg.\ALIGN} \leq N
   }{
     C \vdash t\K{.load}N\K{\_}\sx~\memarg : [\I32] \to [t]
   }


.. _valid-store:

:math:`t\K{.store}~\memarg`
...........................

* The memory :math:`C.\MEMS[0]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than the :ref:`width <syntax-valtype>` of :math:`t`.

* Then the instruction is valid with type :math:`[\I32~t] \to []`.

.. math::
   \frac{
     C.\MEMS[0] = \memtype
     \qquad
     2^{\memarg.\ALIGN} \leq |t|
   }{
     C \vdash t\K{.store}~\memarg : [\I32~t] \to []
   }


.. _valid-storen:

:math:`t\K{.store}N~\memarg`
............................

* The memory :math:`C.\MEMS[0]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than :math:`N`.

* Then the instruction is valid with type :math:`[\I32~t] \to []`.

.. math::
   \frac{
     C.\MEMS[0] = \memtype
     \qquad
     2^{\memarg.\ALIGN} \leq N
   }{
     C \vdash t\K{.store}N~\memarg : [\I32~t] \to []
   }


.. _valid-current_memory:

:math:`\CURRENTMEMORY`
......................

* The memory :math:`C.\MEMS[0]` must be defined in the context.

* Then the instruction is valid with type :math:`[] \to [\I32]`.

.. math::
   \frac{
     C.\MEMS[0] = \memtype
   }{
     C \vdash \CURRENTMEMORY : [] \to [\I32]
   }


.. _valid-grow_memory:

:math:`\GROWMEMORY`
...................

* The memory :math:`C.\MEMS[0]` must be defined in the context.

* Then the instruction is valid with type :math:`[\I32] \to [\I32]`.

.. math::
   \frac{
     C.\MEMS[0] = \memtype
   }{
     C \vdash \GROWMEMORY : [\I32] \to [\I32]
   }


.. _valid-instr-control:
.. _valid-label:
.. index:: control instructions, structured control, label, block, branch, result type, label index, function index, type index, vector, polymorphism
   pair: validation; instruction
   single: abstract syntax; instruction

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _valid-nop:

:math:`\NOP`
............

* The instruction is valid with type :math:`[] \to []`.

.. math::
   \frac{
   }{
     C \vdash \NOP : [] \to []
   }


.. _valid-unreachable:

:math:`\UNREACHABLE`
....................

* The instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`, for any sequences of :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.

.. math::
   \frac{
   }{
     C \vdash \UNREACHABLE : [t_1^\ast] \to [t_2^\ast]
   }

.. note::
   The |UNREACHABLE| instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-block:

:math:`\BLOCK~[t^?]~\instr^\ast~\END`
.....................................

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`result type <syntax-resulttype>` :math:`[t^?]` prepended to the |LABELS| vector.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[] \to [t^?]`.

* Then the compound instruction is valid with type :math:`[] \to [t^?]`.

.. math::
   \frac{
     C,\LABELS\,[t^?] \vdash \instr^\ast : [] \to [t^?]
   }{
     C \vdash \BLOCK~[^?]~\instr^\ast~\END : [] \to [t^?]
   }

.. note::
   The fact that the nested instruction sequence :math:`\instr^\ast` must have type :math:`[] \to [t^?]` implies that it cannot access operands that have been pushed on the stack before the block was entered.
   This may be generalized in future versions of WebAssembly.


.. _valid-loop:

:math:`\LOOP~[t^?]~\instr^\ast~\END`
....................................

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the empty :ref:`result type <syntax-resulttype>` :math:`[]` prepended to the |LABELS| vector.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[] \to [t^?]`.

* Then the compound instruction is valid with type :math:`[] \to [t^?]`.

.. math::
   \frac{
     C,\LABELS\,[] \vdash \instr^\ast : [] \to [t^?]
   }{
     C \vdash \LOOP~[t^?]~\instr^\ast~\END : [] \to [t^?]
   }

.. note::
   The fact that the nested instruction sequence :math:`\instr^\ast` must have type :math:`[] \to [t^?]` implies that it cannot access operands that have been pushed on the stack before the loop was entered.
   This may be generalized in future versions of WebAssembly.


.. _valid-if:

:math:`\IF~[t^?]~\instr_1^\ast~\ELSE~\instr_2^\ast~\END`
........................................................

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the empty :ref:`result type <syntax-resulttype>` :math:`[t^?]` prepended to the |LABELS| vector.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr_1^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[] \to [t^?]`.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr_2^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[] \to [t^?]`.

* Then the compound instruction is valid with type :math:`[] \to [t^?]`.

.. math::
   \frac{
     C,\LABELS\,[t^?] \vdash \instr_1^\ast : [] \to [t^?]
     \qquad
     C,\LABELS\,[t^?] \vdash \instr_2^\ast : [] \to [t^?]
   }{
     C \vdash \IF~[t^?]~\instr_1^\ast~\ELSE~\instr_2^\ast~\END : [\I32] \to [t^?]
   }

.. note::
   The fact that the nested instruction sequence :math:`\instr^\ast` must have type :math:`[] \to [t^?]` implies that it cannot access operands that have been pushed on the stack before the conditional was entered.
   This may be generalized in future versions of WebAssembly.


.. _valid-br:

:math:`\BR~l`
.............

* The label :math:`C.\LABELS[l]` must be defined in the context.

* Let :math:`[t^?]` be the :ref:`result type <syntax-resulttype>` :math:`C.\LABELS[l]`.

* Then the instruction is valid with type :math:`[t_1^\ast~t^?] \to [t_2^\ast]`, for any sequences of :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.

.. math::
   \frac{
     C.\LABELS[l] = [t^?]
   }{
     C \vdash \BR~l : [t_1^\ast~t^?] \to [t_2^\ast]
   }

.. note::
   The |BR| instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-br_if:

:math:`\BRIF~l`
...............

* The label :math:`C.\LABELS[l]` must be defined in the context.

* Let :math:`[t^?]` be the :ref:`result type <syntax-resulttype>` :math:`C.\LABELS[l]`.

* Then the instruction is valid with type :math:`[t^?~\I32] \to [t^?]`.

.. math::
   \frac{
     C.\LABELS[l] = [t^?]
   }{
     C \vdash \BRIF~l : [t^?~\I32] \to [t^?]
   }


.. _valid-br_table:

:math:`\BRTABLE~l^\ast~l_N`
...........................

* The label :math:`C.\LABELS[l]` must be defined in the context.

* Let :math:`[t^?]` be the :ref:`result type <syntax-resulttype>` :math:`C.\LABELS[l_N]`.

* For all :math:`l_i` in :math:`l^\ast`,
  the label :math:`C.\LABELS[l_i]` must be defined in the context.

* For all :math:`l_i` in :math:`l^\ast`,
  :math:`C.\LABELS[l_i]` must be :math:`t^?`.

* Then the instruction is valid with type :math:`[t_1^\ast~t^?~\I32] \to [t_2^\ast]`, for any sequences of :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.

.. math::
   \frac{
     (C.\LABELS[l] = [t^?])^\ast
     \qquad
     C.\LABELS[l_N] = [t^?]
   }{
     C \vdash \BRTABLE~l^\ast~l_N : [t_1^\ast~t^?~\I32] \to [t_2^\ast]
   }

.. note::
   The |BRTABLE| instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-return:

:math:`\RETURN`
...............

* The label vector :math:`C.\LABELS` must not be empty in the context.

* Let :math:`[t^?]` be the :ref:`result type <syntax-resulttype>` that is the last element of :math:`C.\LABELS`.

* Then the instruction is valid with type :math:`[t_1^\ast~t^?] \to [t_2^\ast]`, for any sequences of :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.

.. math::
   \frac{
     C.\LABELS[|C.\LABELS|-1] = [t^?]
   }{
     C \vdash \RETURN : [t_1^\ast~t^?] \to [t_2^\ast]
   }

.. note::
   The |RETURN| instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-call:

:math:`\CALL~x`
...............

* The function :math:`C.\FUNCS[x]` must be defined in the context.

* Then the instruction is valid with type :math:`C.\FUNCS[x]`.

.. math::
   \frac{
     C.\FUNCS[x] = [t_1^\ast] \to [t_2^\ast]
   }{
     C \vdash \CALL~x : [t_1^\ast] \to [t_2^\ast]
   }


.. _valid-call_indirect:

:math:`\CALLINDIRECT~x`
.......................

* The table :math:`C.\TABLES[0]` must be defined in the context.

* Let :math:`\limits~\elemtype` be the :ref:`table type <syntax-tabletype>` :math:`C.\TABLES[0]`.

* The :ref:`element type <syntax-elemtype>` :math:`\elemtype` must be |ANYFUNC|.

* The type :math:`C.\TYPES[x]` must be defined in the context.

* Then the instruction is valid with type :math:`C.\TYPES[x]`.

.. math::
   \frac{
     C.\TABLES[0] = \limits~\ANYFUNC
     \qquad
     C.\TYPES[x] = [t_1^\ast] \to [t_2^\ast]
   }{
     C \vdash \CALLINDIRECT~x : [t_1^\ast] \to [t_2^\ast]
   }


.. _valid-instr-seq:
.. index:: instruction

Instruction Sequences
~~~~~~~~~~~~~~~~~~~~~

Typing of instruction sequences is defined recursively.


Empty Instruction Sequence: :math:`\epsilon`
............................................

* The empty instruction sequence is valid with type :math:`[t^\ast] \to [t^\ast]`,
  for any sequence of :ref:`value types <syntax-valtype>` :math:`t^\ast`.

.. math::
   \frac{
   }{
     C \vdash \epsilon : [t^\ast] \to [t^\ast]
   }


Non-empty Instruction Sequence: :math:`\instr^\ast~\instr_N`
............................................................

* The instruction sequence :math:`\instr^\ast` must be valid with type :math:`[t_1^\ast] \to [t_2^\ast]`,
  for some sequences of :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.

* The instruction :math:`\instr_N` must be valid with type :math:`[t^\ast] \to [t_3^\ast]`,
  for some sequences of :ref:`value types <syntax-valtype>` :math:`t^\ast` and :math:`t_3^\ast`.

* There must be a sequence of :ref:`value types <syntax-valtype>` :math:`t_0^\ast`,
  such that :math:`t_2^\ast = t_0^\ast~t^\ast`.

* Then the combined instruction sequence is valid with type :math:`[t_1^\ast] \to [t_0^\ast~t_3^\ast]`.

.. math::
   \frac{
     C \vdash \instr^\ast : [t_1^\ast] \to [t_0^\ast~t^\ast]
     \qquad
     C \vdash \instr_N : [t^\ast] \to [t_3^\ast]
   }{
     C \vdash \instr^\ast~\instr_N : [t_1^\ast] \to [t_0^\ast~t_3^\ast]
   }


.. _valid-expr:
.. index:: expression
   pair: validation; expression
   single: abstract syntax; expression
   single: expression; constant

Expressions
~~~~~~~~~~~

Expressions :math:`\expr` are classified by :ref:`result types <syntax-resulttype>` of the form :math:`[t^?]`.


:math:`\instr^\ast~\END`
........................

* The instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[] \to [t^?]`,
  for some optional :ref:`value type <syntax-valtype>` :math:`t^?`.

* Then the expression is valid with :ref:`result type <syntax-resulttype>` :math:`[t^?]`.

.. math::
   \frac{
     C \vdash \instr^\ast : [] \to [t^?]
   }{
     C \vdash \instr^\ast~\END : [t^?]
   }


.. _valid-constant:
.. index:: ! constant

Constant Expressions
....................

* In a *constant* expression :math:`\instr^\ast~\END` all instructions in :math:`\instr^\ast` must be constant.

* A constant instruction :math:`\instr` must be:

  * either of the form :math:`t.\CONST~c`,

  * or of the form :math:`\GETGLOBAL~x`, in which case :math:`C.\GLOBALS[x]` must be a :ref:`global type <syntax-globaltype>` of the form :math:`\CONST~t`.

.. math::
   \frac{
     (C \vdash \instr ~\F{const})^\ast
   }{
     C \vdash \instr~\END ~\F{const}
   }
   \qquad
   \frac{
   }{
     C \vdash t.\CONST~c ~\F{const}
   }
   \qquad
   \frac{
     C.\GLOBALS[x] = \CONST~t
   }{
     C \vdash \GETGLOBAL~x ~\F{const}
   }

.. note::
   The definition of constant expression may be extended in future versions of WebAssembly.

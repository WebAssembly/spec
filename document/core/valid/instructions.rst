.. index:: instruction, function type, context, value, operand stack, ! polymorphism
.. _valid-instr:

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
Such a sequence has a :ref:`function type <syntax-functype>` :math:`[t_1^\ast] \to [t_2^\ast]` if the accumulative effect of executing the instructions is consuming values of types :math:`t_1^\ast` off the operand stack and pushing new values of types :math:`t_2^\ast`.

.. _polymorphism:

For some instructions, the typing rules do not fully constrain the type,
and therefore allow for multiple types.
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
   For example, the |SELECT| instruction is valid with type :math:`[t~t~\I32] \to [t]`, for any possible :ref:`number type <syntax-numtype>` :math:`t`.   Consequently, both instruction sequences

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

The :ref:`Appendix <algo-valid>` describes a type checking :ref:`algorithm <algo-valid>` that efficiently implements validation of instruction sequences as prescribed by the rules given here.


.. index:: numeric instruction
   pair: validation; instruction
   single: abstract syntax; instruction
.. _valid-instr-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _valid-const:

:math:`t\K{.}\CONST~c`
......................

* The instruction is valid with type :math:`[] \to [t]`.

.. math::
   \frac{
   }{
     C \vdashinstr t\K{.}\CONST~c : [] \to [t]
   }


.. _valid-unop:

:math:`t\K{.}\unop`
...................

* The instruction is valid with type :math:`[t] \to [t]`.

.. math::
   \frac{
   }{
     C \vdashinstr t\K{.}\unop : [t] \to [t]
   }


.. _valid-binop:

:math:`t\K{.}\binop`
....................

* The instruction is valid with type :math:`[t~t] \to [t]`.

.. math::
   \frac{
   }{
     C \vdashinstr t\K{.}\binop : [t~t] \to [t]
   }


.. _valid-testop:

:math:`t\K{.}\testop`
.....................

* The instruction is valid with type :math:`[t] \to [\I32]`.

.. math::
   \frac{
   }{
     C \vdashinstr t\K{.}\testop : [t] \to [\I32]
   }


.. _valid-relop:

:math:`t\K{.}\relop`
....................

* The instruction is valid with type :math:`[t~t] \to [\I32]`.

.. math::
   \frac{
   }{
     C \vdashinstr t\K{.}\relop : [t~t] \to [\I32]
   }


.. _valid-cvtop:

:math:`t_2\K{.}\cvtop\K{\_}t_1\K{\_}\sx^?`
..........................................

* The instruction is valid with type :math:`[t_1] \to [t_2]`.

.. math::
   \frac{
   }{
     C \vdashinstr t_2\K{.}\cvtop\K{\_}t_1\K{\_}\sx^? : [t_1] \to [t_2]
   }


.. index:: reference instructions, reference type
   pair: validation; instruction
   single: abstract syntax; instruction
.. _valid-instr-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _valid-ref.null:

:math:`\REFNULL`
................

* The instruction is valid with type :math:`[] \to [\NULLREF]`.

.. math::
   \frac{
   }{
     C \vdashinstr \REFNULL : [] \to [\NULLREF]
   }


.. _valid-ref.is_null:

:math:`\REFISNULL`
..................

* The instruction is valid with type :math:`[\ANYREF] \to [\I32]`.

.. math::
   \frac{
   }{
     C \vdashinstr \REFISNULL : [\ANYREF] \to [\I32]
   }

.. _valid-ref.func:

:math:`\REFFUNC~x`
..................

* The function :math:`C.\CFUNCS[x]` must be defined in the context.

* The instruction is valid with type :math:`[] \to [\FUNCREF]`.

.. math::
   \frac{
     C.\CFUNCS[x] = \functype
   }{
     C \vdashinstr \REFFUNC~x : [] \to [\FUNCREF]
   }


.. index:: parametric instructions, value type, polymorphism
   pair: validation; instruction
   single: abstract syntax; instruction
.. _valid-instr-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-drop:

:math:`\DROP`
.............

* The instruction is valid with type :math:`[t] \to []`, for any :ref:`value type <syntax-valtype>` :math:`t`.

.. math::
   \frac{
   }{
     C \vdashinstr \DROP : [t] \to []
   }

.. note::
   Both |DROP| and |SELECT| without annotation are :ref:`value-polymorphic <polymorphism>` instructions.



.. _valid-select:

:math:`\SELECT~(t^\ast)^?`
..........................

* If :math:`t^\ast` is present, then:

  * The length of :math:`t^\ast` must be :math:`1`.

  * Then the instruction is valid with type :math:`[t^\ast~t^\ast~\I32] \to [t^\ast]`.

* Else:

  * The instruction is valid with type :math:`[t~t~\I32] \to [t]`, for any :ref:`value type <syntax-valtype>` :math:`t` that :ref:`matches <match-valtype>` some :ref:`number type <syntax-numtype>`.

.. math::
   \frac{
   }{
     C \vdashinstr \SELECT~t : [t~t~\I32] \to [t]
   }
   \qquad
   \frac{
     \vdashvaltypematch t \matchesvaltype \numtype
   }{
     C \vdashinstr \SELECT : [t~t~\I32] \to [t]
   }

.. note::
   In future versions of WebAssembly, |SELECT| may allow more than one value per choice.


.. index:: variable instructions, local index, global index, context
   pair: validation; instruction
   single: abstract syntax; instruction
.. _valid-instr-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _valid-local.get:

:math:`\LOCALGET~x`
...................

* The local :math:`C.\CLOCALS[x]` must be defined in the context.

* Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`C.\CLOCALS[x]`.

* Then the instruction is valid with type :math:`[] \to [t]`.

.. math::
   \frac{
     C.\CLOCALS[x] = t
   }{
     C \vdashinstr \LOCALGET~x : [] \to [t]
   }


.. _valid-local.set:

:math:`\LOCALSET~x`
...................

* The local :math:`C.\CLOCALS[x]` must be defined in the context.

* Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`C.\CLOCALS[x]`.

* Then the instruction is valid with type :math:`[t] \to []`.

.. math::
   \frac{
     C.\CLOCALS[x] = t
   }{
     C \vdashinstr \LOCALSET~x : [t] \to []
   }


.. _valid-local.tee:

:math:`\LOCALTEE~x`
...................

* The local :math:`C.\CLOCALS[x]` must be defined in the context.

* Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`C.\CLOCALS[x]`.

* Then the instruction is valid with type :math:`[t] \to [t]`.

.. math::
   \frac{
     C.\CLOCALS[x] = t
   }{
     C \vdashinstr \LOCALTEE~x : [t] \to [t]
   }


.. _valid-global.get:

:math:`\GLOBALGET~x`
....................

* The global :math:`C.\CGLOBALS[x]` must be defined in the context.

* Let :math:`\mut~t` be the :ref:`global type <syntax-globaltype>` :math:`C.\CGLOBALS[x]`.

* Then the instruction is valid with type :math:`[] \to [t]`.

.. math::
   \frac{
     C.\CGLOBALS[x] = \mut~t
   }{
     C \vdashinstr \GLOBALGET~x : [] \to [t]
   }


.. _valid-global.set:

:math:`\GLOBALSET~x`
....................

* The global :math:`C.\CGLOBALS[x]` must be defined in the context.

* Let :math:`\mut~t` be the :ref:`global type <syntax-globaltype>` :math:`C.\CGLOBALS[x]`.

* The mutability :math:`\mut` must be |MVAR|.

* Then the instruction is valid with type :math:`[t] \to []`.

.. math::
   \frac{
     C.\CGLOBALS[x] = \MVAR~t
   }{
     C \vdashinstr \GLOBALSET~x : [t] \to []
   }




.. index:: table instructions, table index, context
   pair: validation; instruction
   single: abstract syntax; instruction
.. _valid-instr-table:

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _valid-table.get:

:math:`\TABLEGET~x`
...................

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Let :math:`\limits~t` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[x]`.

* Then the instruction is valid with type :math:`[\I32] \to [t]`.

.. math::
   \frac{
     C.\CTABLES[x] = \limits~t
   }{
     C \vdashinstr \TABLEGET~x : [\I32] \to [t]
   }


.. _valid-table.set:

:math:`\TABLESET~x`
...................

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Let :math:`\limits~t` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[x]`.

* Then the instruction is valid with type :math:`[\I32~t] \to []`.

.. math::
   \frac{
     C.\CTABLES[x] = t
   }{
     C \vdashinstr \TABLESET~x : [\I32~t] \to []
   }


.. _valid-table.size:

:math:`\TABLESIZE~x`
....................

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Then the instruction is valid with type :math:`[] \to [\I32]`.

.. math::
   \frac{
     C.\CTABLES[x] = t
   }{
     C \vdashinstr \TABLESIZE~x : [] \to [\I32]
   }


.. _valid-table.grow:

:math:`\TABLEGROW~x`
....................

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Let :math:`\limits~t` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[x]`.

* Then the instruction is valid with type :math:`[t~\I32] \to [\I32]`.

.. math::
   \frac{
     C.\CTABLES[x] = t
   }{
     C \vdashinstr \TABLEGROW~x : [t~\I32] \to [\I32]
   }


.. _valid-table.fill:

:math:`\TABLEFILL~x`
....................

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Let :math:`\limits~t` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[x]`.

* Then the instruction is valid with type :math:`[\I32~t~\I32] \to []`.

.. math::
   \frac{
     C.\CTABLES[x] = t
   }{
     C \vdashinstr \TABLEFILL~x : [\I32~t~\I32] \to []
   }


.. index:: memory instruction, memory index, context
   pair: validation; instruction
   single: abstract syntax; instruction
.. _valid-memarg:
.. _valid-instr-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _valid-load:

:math:`t\K{.}\LOAD~\memarg`
...........................

* The memory :math:`C.\CMEMS[0]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than the :ref:`bit width <syntax-valtype>` of :math:`t` divided by :math:`8`.

* Then the instruction is valid with type :math:`[\I32] \to [t]`.

.. math::
   \frac{
     C.\CMEMS[0] = \memtype
     \qquad
     2^{\memarg.\ALIGN} \leq |t|/8
   }{
     C \vdashinstr t\K{.load}~\memarg : [\I32] \to [t]
   }


.. _valid-loadn:

:math:`t\K{.}\LOAD{N}\K{\_}\sx~\memarg`
.......................................

* The memory :math:`C.\CMEMS[0]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than :math:`N/8`.

* Then the instruction is valid with type :math:`[\I32] \to [t]`.

.. math::
   \frac{
     C.\CMEMS[0] = \memtype
     \qquad
     2^{\memarg.\ALIGN} \leq N/8
   }{
     C \vdashinstr t\K{.load}N\K{\_}\sx~\memarg : [\I32] \to [t]
   }


:math:`t\K{.}\STORE~\memarg`
............................

* The memory :math:`C.\CMEMS[0]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than the :ref:`bit width <syntax-valtype>` of :math:`t` divided by :math:`8`.

* Then the instruction is valid with type :math:`[\I32~t] \to []`.

.. math::
   \frac{
     C.\CMEMS[0] = \memtype
     \qquad
     2^{\memarg.\ALIGN} \leq |t|/8
   }{
     C \vdashinstr t\K{.store}~\memarg : [\I32~t] \to []
   }


.. _valid-storen:

:math:`t\K{.}\STORE{N}~\memarg`
...............................

* The memory :math:`C.\CMEMS[0]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than :math:`N/8`.

* Then the instruction is valid with type :math:`[\I32~t] \to []`.

.. math::
   \frac{
     C.\CMEMS[0] = \memtype
     \qquad
     2^{\memarg.\ALIGN} \leq N/8
   }{
     C \vdashinstr t\K{.store}N~\memarg : [\I32~t] \to []
   }


.. _valid-memory.size:

:math:`\MEMORYSIZE`
...................

* The memory :math:`C.\CMEMS[0]` must be defined in the context.

* Then the instruction is valid with type :math:`[] \to [\I32]`.

.. math::
   \frac{
     C.\CMEMS[0] = \memtype
   }{
     C \vdashinstr \MEMORYSIZE : [] \to [\I32]
   }


.. _valid-memory.grow:

:math:`\MEMORYGROW`
...................

* The memory :math:`C.\CMEMS[0]` must be defined in the context.

* Then the instruction is valid with type :math:`[\I32] \to [\I32]`.

.. math::
   \frac{
     C.\CMEMS[0] = \memtype
   }{
     C \vdashinstr \MEMORYGROW : [\I32] \to [\I32]
   }


.. index:: control instructions, structured control, label, block, branch, result type, label index, function index, type index, vector, polymorphism, context
   pair: validation; instruction
   single: abstract syntax; instruction
.. _valid-label:
.. _valid-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _valid-nop:

:math:`\NOP`
............

* The instruction is valid with type :math:`[] \to []`.

.. math::
   \frac{
   }{
     C \vdashinstr \NOP : [] \to []
   }


.. _valid-unreachable:

:math:`\UNREACHABLE`
....................

* The instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`, for any sequences of :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.

.. math::
   \frac{
   }{
     C \vdashinstr \UNREACHABLE : [t_1^\ast] \to [t_2^\ast]
   }

.. note::
   The |UNREACHABLE| instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-block:

:math:`\BLOCK~[t^?]~\instr^\ast~\END`
.....................................

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`result type <syntax-resulttype>` :math:`[t^?]` prepended to the |CLABELS| vector.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[] \to [t^?]`.

* Then the compound instruction is valid with type :math:`[] \to [t^?]`.

.. math::
   \frac{
     C,\CLABELS\,[t^?] \vdashinstrseq \instr^\ast : [] \to [t^?]
   }{
     C \vdashinstr \BLOCK~[t^?]~\instr^\ast~\END : [] \to [t^?]
   }

.. note::
   The :ref:`notation <notation-extend>` :math:`C,\CLABELS\,[t^?]` inserts the new label type at index :math:`0`, shifting all others.

   The fact that the nested instruction sequence :math:`\instr^\ast` must have type :math:`[] \to [t^?]` implies that it cannot access operands that have been pushed on the stack before the block was entered.
   This may be generalized in future versions of WebAssembly.


.. _valid-loop:

:math:`\LOOP~[t^?]~\instr^\ast~\END`
....................................

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the empty :ref:`result type <syntax-resulttype>` :math:`[]` prepended to the |CLABELS| vector.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[] \to [t^?]`.

* Then the compound instruction is valid with type :math:`[] \to [t^?]`.

.. math::
   \frac{
     C,\CLABELS\,[] \vdashinstrseq \instr^\ast : [] \to [t^?]
   }{
     C \vdashinstr \LOOP~[t^?]~\instr^\ast~\END : [] \to [t^?]
   }

.. note::
   The :ref:`notation <notation-extend>` :math:`C,\CLABELS\,[]` inserts the new label type at index :math:`0`, shifting all others.

   The fact that the nested instruction sequence :math:`\instr^\ast` must have type :math:`[] \to [t^?]` implies that it cannot access operands that have been pushed on the stack before the loop was entered.
   This may be generalized in future versions of WebAssembly.


.. _valid-if:

:math:`\IF~[t^?]~\instr_1^\ast~\ELSE~\instr_2^\ast~\END`
........................................................

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`result type <syntax-resulttype>` :math:`[t^?]` prepended to the |CLABELS| vector.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr_1^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[] \to [t^?]`.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr_2^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[] \to [t^?]`.

* Then the compound instruction is valid with type :math:`[\I32] \to [t^?]`.

.. math::
   \frac{
     C,\CLABELS\,[t^?] \vdashinstrseq \instr_1^\ast : [] \to [t^?]
     \qquad
     C,\CLABELS\,[t^?] \vdashinstrseq \instr_2^\ast : [] \to [t^?]
   }{
     C \vdashinstr \IF~[t^?]~\instr_1^\ast~\ELSE~\instr_2^\ast~\END : [\I32] \to [t^?]
   }

.. note::
   The :ref:`notation <notation-extend>` :math:`C,\CLABELS\,[t^?]` inserts the new label type at index :math:`0`, shifting all others.

   The fact that the nested instruction sequence :math:`\instr^\ast` must have type :math:`[] \to [t^?]` implies that it cannot access operands that have been pushed on the stack before the conditional was entered.
   This may be generalized in future versions of WebAssembly.


.. _valid-br:

:math:`\BR~l`
.............

* The label :math:`C.\CLABELS[l]` must be defined in the context.

* Let :math:`[t^?]` be the :ref:`result type <syntax-resulttype>` :math:`C.\CLABELS[l]`.

* Then the instruction is valid with type :math:`[t_1^\ast~t^?] \to [t_2^\ast]`, for any sequences of :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.

.. math::
   \frac{
     C.\CLABELS[l] = [t^?]
   }{
     C \vdashinstr \BR~l : [t_1^\ast~t^?] \to [t_2^\ast]
   }

.. note::
   The :ref:`label index <syntax-labelidx>` space in the :ref:`context <context>` :math:`C` contains the most recent label first, so that :math:`C.\CLABELS[l]` performs a relative lookup as expected.

   The |BR| instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-br_if:

:math:`\BRIF~l`
...............

* The label :math:`C.\CLABELS[l]` must be defined in the context.

* Let :math:`[t^?]` be the :ref:`result type <syntax-resulttype>` :math:`C.\CLABELS[l]`.

* Then the instruction is valid with type :math:`[t^?~\I32] \to [t^?]`.

.. math::
   \frac{
     C.\CLABELS[l] = [t^?]
   }{
     C \vdashinstr \BRIF~l : [t^?~\I32] \to [t^?]
   }

.. note::
   The :ref:`label index <syntax-labelidx>` space in the :ref:`context <context>` :math:`C` contains the most recent label first, so that :math:`C.\CLABELS[l]` performs a relative lookup as expected.


.. _valid-br_table:

:math:`\BRTABLE~l^\ast~l_N`
...........................

* The label :math:`C.\CLABELS[l_N]` must be defined in the context.

* For all :math:`l_i` in :math:`l^\ast`,
  the label :math:`C.\CLABELS[l_i]` must be defined in the context.

* There must be a :ref:`result type <syntax-resulttype>` :math:`[t^?]`, such that:

  * The result type :math:`[t^?]` :ref:`matches <match-resulttype>` :math:`C.\CLABELS[l_N]`.

  * For all :math:`l_i` in :math:`l^\ast`,
    the result type :math:`[t^?]` :ref:`matches <match-resulttype>` :math:`C.\CLABELS[l_i]`.

* Then the instruction is valid with type :math:`[t_1^\ast~t^?~\I32] \to [t_2^\ast]`, for any sequences of :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.

.. math::
   \frac{
     (\vdashresulttypematch [t^?] \matchesresulttype C.\CLABELS[l])^\ast
     \qquad
     \vdashresulttypematch [t^?] \matchesresulttype C.\CLABELS[l_N]
   }{
     C \vdashinstr \BRTABLE~l^\ast~l_N : [t_1^\ast~t^?~\I32] \to [t_2^\ast]
   }

.. note::
   The :ref:`label index <syntax-labelidx>` space in the :ref:`context <context>` :math:`C` contains the most recent label first, so that :math:`C.\CLABELS[l_i]` performs a relative lookup as expected.

   The |BRTABLE| instruction is :ref:`stack-polymorphic <polymorphism>`.

   Furthermore, the :ref:`result type <syntax-resulttype>` :math:`[t^?]` is also chosen non-deterministically in this rule.
   In a :ref:`type checking algorithm <algo-valid>`, the greatest lower bound of the involved label types can be picked as a principal type,
   and it is a type error if that bound does not exist.


.. _valid-return:

:math:`\RETURN`
...............

* The return type :math:`C.\CRETURN` must not be absent in the context.

* Let :math:`[t^?]` be the :ref:`result type <syntax-resulttype>` of :math:`C.\CRETURN`.

* Then the instruction is valid with type :math:`[t_1^\ast~t^?] \to [t_2^\ast]`, for any sequences of :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.

.. math::
   \frac{
     C.\CRETURN = [t^?]
   }{
     C \vdashinstr \RETURN : [t_1^\ast~t^?] \to [t_2^\ast]
   }

.. note::
   The |RETURN| instruction is :ref:`stack-polymorphic <polymorphism>`.

   :math:`C.\CRETURN` is absent (set to :math:`\epsilon`) when validating an :ref:`expression <valid-expr>` that is not a function body.
   This differs from it being set to the empty result type (:math:`[\epsilon]`),
   which is the case for functions not returning anything.


.. _valid-call:

:math:`\CALL~x`
...............

* The function :math:`C.\CFUNCS[x]` must be defined in the context.

* Then the instruction is valid with type :math:`C.\CFUNCS[x]`.

.. math::
   \frac{
     C.\CFUNCS[x] = [t_1^\ast] \to [t_2^\ast]
   }{
     C \vdashinstr \CALL~x : [t_1^\ast] \to [t_2^\ast]
   }


.. _valid-call_indirect:

:math:`\CALLINDIRECT~x~y`
.........................

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Let :math:`\limits~t` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[x]`.

* The :ref:`reference type <syntax-reftype>` :math:`t` must :ref:`match <match-reftype>` type |FUNCREF|.

* The type :math:`C.\CTYPES[y]` must be defined in the context.

* Let :math:`[t_1^\ast] \to [t_2^\ast]` be the :ref:`function type <syntax-functype>` :math:`C.\CTYPES[y]`.

* Then the instruction is valid with type :math:`[t_1^\ast~\I32] \to [t_2^\ast]`.

.. math::
   \frac{
     C.\CTABLES[x] = \limits~t
     \qquad
     \vdashvaltypematch t \leq \FUNCREF
     \qquad
     C.\CTYPES[y] = [t_1^\ast] \to [t_2^\ast]
   }{
     C \vdashinstr \CALLINDIRECT~x~y : [t_1^\ast~\I32] \to [t_2^\ast]
   }


.. index:: instruction, instruction sequence
.. _valid-instr-seq:

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
     C \vdashinstrseq \epsilon : [t^\ast] \to [t^\ast]
   }


Non-empty Instruction Sequence: :math:`\instr^\ast~\instr_N`
............................................................

* The instruction sequence :math:`\instr^\ast` must be valid with type :math:`[t_1^\ast] \to [t_2^\ast]`,
  for some sequences of :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.

* The instruction :math:`\instr_N` must be valid with type :math:`[t^\ast] \to [t_3^\ast]`,
  for some sequences of :ref:`value types <syntax-valtype>` :math:`t^\ast` and :math:`t_3^\ast`.

* There must be a sequence of :ref:`value types <syntax-valtype>` :math:`t_0^\ast`,
  such that :math:`t_2^\ast = t_0^\ast~{t'}^\ast` where the type sequence :math:`{t'}^\ast` is as long as :math:`t^\ast`.

* For each :ref:`value type <syntax-valtype>` :math:`t'_i` in :math:`{t'}^\ast` and corresponding type :math:`t_i` in :math:`t^\ast`, the type :math:`t'_i` must :ref:`match <match-valtype>` :math:`t_i`.

* Then the combined instruction sequence is valid with type :math:`[t_1^\ast] \to [t_0^\ast~t_3^\ast]`.

.. math::
   \frac{
     C \vdashinstrseq \instr^\ast : [t_1^\ast] \to [t_0^\ast~{t'}^\ast]
     \qquad
     (\vdashvaltypematch t' \matchesvaltype t)^\ast
     \qquad
     C \vdashinstr \instr_N : [t^\ast] \to [t_3^\ast]
   }{
     C \vdashinstrseq \instr^\ast~\instr_N : [t_1^\ast] \to [t_0^\ast~t_3^\ast]
   }


.. index:: expression
   pair: validation; expression
   single: abstract syntax; expression
   single: expression; constant
.. _valid-expr:

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
     C \vdashinstrseq \instr^\ast : [] \to [t^?]
   }{
     C \vdashexpr \instr^\ast~\END : [t^?]
   }


.. index:: ! constant
.. _valid-constant:

Constant Expressions
....................

* In a *constant* expression :math:`\instr^\ast~\END` all instructions in :math:`\instr^\ast` must be constant.

* A constant instruction :math:`\instr` must be:

  * either of the form :math:`t.\CONST~c`,

  * or of the form :math:`\REFNULL`,

  * or of the form :math:`\REFFUNC~x`,

  * or of the form :math:`\GLOBALGET~x`, in which case :math:`C.\CGLOBALS[x]` must be a :ref:`global type <syntax-globaltype>` of the form :math:`\CONST~t`.

.. math::
   \frac{
     (C \vdashinstrconst \instr \const)^\ast
   }{
     C \vdashexprconst \instr^\ast~\END \const
   }

.. math::
   \frac{
   }{
     C \vdashinstrconst t.\CONST~c \const
   }
   \qquad
   \frac{
   }{
     C \vdashinstrconst \REFNULL \const
   }
   \qquad
   \frac{
   }{
     C \vdashinstrconst \REFFUNC~x \const
   }

.. math::
   \frac{
     C.\CGLOBALS[x] = \CONST~t
   }{
     C \vdashinstrconst \GLOBALGET~x \const
   }

.. note::
   Currently, constant expressions occurring as initializers of :ref:`globals <syntax-global>` are further constrained in that contained |GLOBALGET| instructions are only allowed to refer to *imported* globals.
   This is enforced in the :ref:`validation rule for modules <valid-module>` by constraining the context :math:`C` accordingly.

   The definition of constant expression may be extended in future versions of WebAssembly.

.. _valid-instr
.. index:: function type, context

Instructions
------------

:ref:`Instructions <syntax-instr>` are classified by :ref:`function types <syntax-functype>` :math:`[t_1^\ast] \to [t_2^\ast]`.
The types describe which types :math:`t_1^\ast` of argument values an instruction pops off the operand stack and which types :math:`t_2^\ast` of result values it pushes back to it.

.. note::
   For example, the instruction :math:`\K{i32.add}` has type :math:`[\I32~\I32] \to [\I32]`,
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
      (\K{i32.const}~1)~~(\K{i32.const}~2)~~(\K{i32.const}~3)~~\SELECT{}

   and

   .. math::
      (\K{f64.const}~1.0)~~(\K{f64.const}~2.0)~~(\K{i32.const}~3)~~\SELECT{}

   are valid, with :math:`t` in the typing of |SELECT| being instantiated to |I32| or |F64|, respectively.

   The |UNREACHABLE| instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]` for any possible sequences of value types :math:`t_1^\ast` and :math:`t_2^\ast`.
   Consequently,

   .. math::
      \UNREACHABLE~~\K{i32.add}

   is valid by assuming type :math:`[] \to [\I32~\I32]` for the |UNREACHABLE| instruction.
   In contrast,

   .. math::
      \UNREACHABLE~~(\K{i64.const}~0)~~\K{i32.add}

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
     \K{clz} ~|~
     \K{ctz} ~|~
     \K{popcnt} ~|~
     \K{abs} ~|~
     \K{neg} ~|~
     \K{sqrt} ~|~
     \K{ceil} ~|~ 
     \K{floor} ~|~ 
     \K{trunc} ~|~ 
     \K{nearest} \\
   \production{binary operators} & \binop &::=&
     \K{add} ~|~
     \K{sub} ~|~
     \K{mul} ~|~
     \K{div} ~|~
     \K{div\_}\sx ~|~
     \K{rem\_}\sx ~|~
     \K{min} ~|~
     \K{max} ~|~
     \K{copysign} ~|~ \\&&&
     \K{and} ~|~
     \K{or} ~|~
     \K{xor} ~|~
     \K{shl} ~|~
     \K{shr\_}\sx ~|~
     \K{rotl} ~|~
     \K{rotr} \\
   \production{test operators} & \testop &::=&
     \K{eqz} \\
   \production{relational operators} & \relop &::=&
     \K{eq} ~|~
     \K{ne} ~|~
     \K{lt} ~|~
     \K{gt} ~|~
     \K{le} ~|~
     \K{ge} ~|~
     \K{lt\_}\sx ~|~
     \K{gt\_}\sx ~|~
     \K{le\_}\sx ~|~
     \K{ge\_}\sx \\
   \production{conversion operators} & \cvtop &::=&
     \K{wrap} ~|~
     \K{extend\_}\sx ~|~
     \K{trunc\_}\sx ~|~
     \K{convert\_}\sx ~|~
     \K{demote} ~|~
     \K{promote} ~|~
     \K{reinterpret} \\
   \end{array}


:math:`t \K{.const}~c`
......................

* The instruction is valid with type :math:`[] \to [t]`.

.. math::
   \frac{
   }{
     C \vdash t\K{.const}~c : [] \to [t]
   }


:math:`t\K{.}\unop`
...................

* The instruction is valid with type :math:`[t] \to [t]`.

.. math::
   \frac{
   }{
     C \vdash t\K{.}\unop : [t] \to [t]
   }


:math:`t\K{.}\binop`
....................

* The instruction is valid with type :math:`[t~t] \to [t]`.

.. math::
   \frac{
   }{
     C \vdash t\K{.}\binop : [t~t] \to [t]
   }


:math:`t\K{.}\testop`
.....................

* The instruction is valid with type :math:`[t] \to [\I32]`.

.. math::
   \frac{
   }{
     C \vdash t\K{.}\testop : [t] \to [\I32]
   }


:math:`t\K{.}\relop`
....................

* The instruction is valid with type :math:`[t~t] \to [\I32]`.

.. math::
   \frac{
   }{
     C \vdash t\K{.}\relop : [t~t] \to [\I32]
   }


:math:`t_2\K{.}\cvtop/t_1`
..........................

* The instruction is valid with type :math:`[t_1] \to [t_2]`.

.. math::
   \frac{
   }{
     C \vdash t_2\K{.}\cvtop/t_1 : [t_1] \to [t_2]
   }


.. _syntax-instr-parametric:
.. index:: ! parametric instructions
   pair: abstract syntax; instruction


.. _valid-parametric:
.. index:: value type, polymorphism

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

:math:`\DROP`
.............

* The instruction is valid with type :math:`[t] \to []`, for any :ref:`value type <syntax-valtype>` :math:`t`.

.. math::
   \frac{
   }{
     C \vdash \DROP : [t] \to []
   }


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

:math:`\NOP`
............

* The instruction is valid with type :math:`[] \to []`.

.. math::
   \frac{
   }{
     C \vdash \NOP : [] \to []
   }


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


:math:`\BLOCK~t^?~\instr^\ast~\END`
...................................

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`result type <syntax-resulttype>` :math:`t^?` prepended to the |LABELS| vector.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[] \to [t^?]`.

* Then the compound instruction is valid with type :math:`[] \to [t^?]`.

.. math::
   \frac{
     C,\LABELS\,(t^?) \vdash \instr^\ast : [] \to [t^?]
   }{
     C \vdash \BLOCK~t^?~\instr^\ast~\END : [] \to [t^?]
   }


:math:`\LOOP~t^?~\instr^\ast~\END`
..................................

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the empty :ref:`result type <syntax-resulttype>` :math:`\epsilon` prepended to the |LABELS| vector.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[] \to [t^?]`.

* Then the compound instruction is valid with type :math:`[] \to [t^?]`.

.. math::
   \frac{
     C,\LABELS\,(\epsilon) \vdash \instr^\ast : [] \to [t^?]
   }{
     C \vdash \LOOP~t^?~\instr^\ast~\END : [] \to [t^?]
   }


:math:`\IF~t^?~\instr_1^\ast~\ELSE~\instr_2^\ast~\END`
......................................................

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the empty :ref:`result type <syntax-resulttype>` :math:`\epsilon` prepended to the |LABELS| vector.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr_1^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[] \to [t^?]`.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr_2^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[] \to [t^?]`.

* Then the compound instruction is valid with type :math:`[] \to [t^?]`.

.. math::
   \frac{
     C,\LABELS\,(t^?) \vdash \instr_1^\ast : [] \to [t^?]
     \qquad
     C,\LABELS\,(t^?) \vdash \instr_2^\ast : [] \to [t^?]
   }{
     C \vdash \IF~t^?~\instr_1^\ast~\ELSE~\instr_2^\ast~\END : [\I32] \to [t^?]
   }


:math:`\BR~l`
.............

* The label :math:`C.\LABELS[l]` must be defined in the context.

* Let :math:`t^?` be the :ref:`result type <syntax-resulttype>` :math:`C.\LABELS[l]`.

* Then the instruction is valid with type :math:`[t_1^\ast~t^?] \to [t_2^\ast]`, for any sequences of :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.

.. math::
   \frac{
     C.\LABELS[l] = t^?
   }{
     C \vdash \BR~l : [t_1^\ast~t^?] \to [t_2^\ast]
   }

.. note::
   The |BR| instruction is :ref:`stack-polymorphic <polymorphism>`.


:math:`\BRIF~l`
...............

* The label :math:`C.\LABELS[l]` must be defined in the context.

* Let :math:`t^?` be the :ref:`result type <syntax-resulttype>` :math:`C.\LABELS[l]`.

* Then the instruction is valid with type :math:`[t^?~\I32] \to [t^?]`.

.. math::
   \frac{
     C.\LABELS[l] = t^?
   }{
     C \vdash \BRIF~l : [t^?~\I32] \to [t^?]
   }


:math:`\BRTABLE~l^\ast~l'`
..........................

* The label :math:`C.\LABELS[l]` must be defined in the context.

* Let :math:`t^?` be the :ref:`result type <syntax-resulttype>` :math:`C.\LABELS[l']`.

* For all :math:`l_i` in :math:`l^\ast`,
  the label :math:`C.\LABELS[l_i]` must be defined in the context.

* For all :math:`l_i` in :math:`l^\ast`,
  :math:`C.\LABELS[l_i]` must be :math:`t^?`.

* Then the instruction is valid with type :math:`[t_1^\ast~t^?] \to [t_2^\ast]`, for any sequences of :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.

.. math::
   \frac{
     (C.\LABELS[l] = t^?)^\ast
     \qquad
     C.\LABELS[l'] = t^?
   }{
     C \vdash \BRTABLE~l^\ast~l' : [t_1^\ast~t^?] \to [t_2^\ast]
   }

.. note::
   The |BRTABLE| instruction is :ref:`stack-polymorphic <polymorphism>`.


:math:`\RETURN`
...............

* The label vector :math:`C.\LABELS` must not be empty in the context.

* Let :math:`t^?` be the :ref:`result type <syntax-resulttype>` that is the last element of :math:`C.\LABELS`.

* Then the instruction is valid with type :math:`[t_1^\ast~t^?] \to [t_2^\ast]`, for any sequences of :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.

.. math::
   \frac{
     C.\LABELS[|C.\LABELS|-1] = t^?
   }{
     C \vdash \RETURN : [t_1^\ast~t^?] \to [t_2^\ast]
   }

.. note::
   The |RETURN| instruction is :ref:`stack-polymorphic <polymorphism>`.


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


Non-empty Instruction Sequence: :math:`\instr^\ast~\instr'`
...........................................................

* The instruction sequence :math:`\instr^\ast` must be valid with type :math:`[t_1^\ast] \to [t_2^\ast]`,
  for some sequences of :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.

* The instruction :math:`\instr'` must be valid with type :math:`[t^\ast] \to [t_3^\ast]`,
  for some sequences of :ref:`value types <syntax-valtype>` :math:`t^\ast` and :math:`t_3^\ast`.

* There must be a sequence of :ref:`value types <syntax-valtype>` :math:`t_0^\ast`,
  such that :math:`t_2^\ast = t_0^\ast~t^\ast`.

* Then the combined instruction sequence is valid with type :math:`[t_1^\ast] \to [t_0^\ast~t_3^\ast]`.

.. math::
   \frac{
     C \vdash \instr^\ast : [t_1^\ast] \to [t_0^\ast~t^\ast]
     \qquad
     C \vdash \instr' : [t^\ast] \to [t_3^\ast]
   }{
     C \vdash \instr^\ast~\instr' : [t_1^\ast] \to [t_0^\ast~t_3^\ast]
   }

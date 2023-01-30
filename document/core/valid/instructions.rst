.. index:: instruction, ! instruction type, context, value, operand stack, ! polymorphism
.. _valid-instr:

Instructions
------------

:ref:`Instructions <syntax-instr>` are classified by :ref:`instruction types <syntax-instrtype>` that describe how they manipulate the :ref:`operand stack <stack>` and initialize :ref:`locals <syntax-local>`:
A type :math:`[t_1^\ast] \to_{x^\ast} [t_2^\ast]` describes the required input stack with argument values of types :math:`t_1^\ast` that an instruction pops off
and the provided output stack with result values of types :math:`t_2^\ast` that it pushes back.
Moreover, it enumerates the :ref:`indices <syntax-localidx>` :math:`x^\ast` of locals that have been set by the instruction.
In most cases, this is empty.

.. note::
   For example, the instruction :math:`\I32.\ADD` has type :math:`[\I32~\I32] \to [\I32]`,
   consuming two |I32| values and producing one.
   The instruction :math:`\LOCALSET~x` has type :math:`[t] \to_x []`, provided :math:`t` is the type declared for the local :math:`x`.

Typing extends to :ref:`instruction sequences <valid-instr-seq>` :math:`\instr^\ast`.
Such a sequence has an instruction type :math:`[t_1^\ast] \to_{x^\ast} [t_2^\ast]` if the accumulative effect of executing the instructions is consuming values of types :math:`t_1^\ast` off the operand stack, pushing new values of types :math:`t_2^\ast`, and setting all locals :math:`x^\ast`.

.. _polymorphism:

For some instructions, the typing rules do not fully constrain the type,
and therefore allow for multiple types.
Such instructions are called *polymorphic*.
Two degrees of polymorphism can be distinguished:

* *value-polymorphic*:
  the :ref:`value type <syntax-valtype>` :math:`t` of one or several individual operands is unconstrained.
  That is the case for all :ref:`parametric instructions <valid-instr-parametric>` like |DROP| and |SELECT|.

* *stack-polymorphic*:
  the entire (or most of the) :ref:`instruction type <syntax-instrtype>` :math:`[t_1^\ast] \to [t_2^\ast]` of the instruction is unconstrained.
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

   The |UNREACHABLE| instruction is stack-polymorphic,
   and hence valid with type :math:`[t_1^\ast] \to [t_2^\ast]` for any possible sequences of value types :math:`t_1^\ast` and :math:`t_2^\ast`.
   Consequently,

   .. math::
      \UNREACHABLE~~\I32.\ADD

   is valid by assuming type :math:`[] \to [\I32]` for the |UNREACHABLE| instruction.
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

:math:`\REFNULL~\X{ht}`
.......................

* The :ref:`heap type <syntax-heaptype>` :math:`\X{ht}` must be :ref:`valid <valid-heaptype>`.

* Then the instruction is valid with type :math:`[] \to [(\REF~\NULL~\X{ht})]`.

.. math::
   \frac{
     C \vdashheaptype \X{ht} \ok
   }{
     C \vdashinstr \REFNULL~\X{ht} : [] \to [(\REF~\NULL~\X{ht})]
   }

.. _valid-ref.func:

:math:`\REFFUNC~x`
..................

* The function :math:`C.\CFUNCS[x]` must be defined in the context.

* Let :math:`y` be the :ref:`type index <syntax-typeidx>` :math:`C.\CFUNCS[x]`.

* The :ref:`function index <syntax-funcidx>` :math:`x` must be contained in :math:`C.\CREFS`.

* The instruction is valid with type :math:`[] \to [(\REF~y)]`.

.. math::
   \frac{
     C.\CFUNCS[x] = y
     \qquad
     x \in C.\CREFS
   }{
     C \vdashinstr \REFFUNC~x : [] \to [(\REF~y)]
   }

.. _valid-ref.is_null:

:math:`\REFISNULL`
..................

* The instruction is valid with type :math:`[(\REF~\NULL~\X{ht})] \to [\I32]`, for any :ref:`valid <valid-heaptype>` :ref:`heap type <syntax-heaptype>` :math:`\X{ht}`.

.. math::
   \frac{
     C \vdashheaptype \X{ht} \ok
   }{
     C \vdashinstr \REFISNULL : [(\REF~\NULL~\X{ht})] \to [\I32]
   }

.. _valid-ref.as_non_null:

:math:`\REFASNONNULL`
.....................

* The instruction is valid with type :math:`[(\REF~\NULL~\X{ht})] \to [(\REF~\X{ht})]`, for any :ref:`valid <valid-heaptype>` :ref:`heap type <syntax-heaptype>` :math:`\X{ht}`.

.. math::
   \frac{
     C \vdashheaptype \X{ht} \ok
   }{
     C \vdashinstr \REFASNONNULL : [(\REF~\NULL~\X{ht})] \to [(\REF~\X{ht})]
   }

.. index:: vector instruction
   pair: validation; instruction
   single: abstract syntax; instruction

.. _valid-instr-vec:
.. _aux-unpacked:

Vector Instructions
~~~~~~~~~~~~~~~~~~~

Vector instructions can have a prefix to describe the :ref:`shape <syntax-vec-shape>` of the operand. Packed numeric types, |I8| and |I16|, are not :ref:`value types <syntax-valtype>`. An auxiliary function maps such packed type shapes to value types:

.. math::
   \begin{array}{lll@{\qquad}l}
   \unpacked(\K{i8x16}) &=& \I32 \\
   \unpacked(\K{i16x8}) &=& \I32 \\
   \unpacked(t\K{x}N) &=& t
   \end{array}


The following auxiliary function denotes the number of lanes in a vector shape, i.e., its *dimension*:

.. _aux-dim:

.. math::
   \begin{array}{lll@{\qquad}l}
   \dim(t\K{x}N) &=& N
   \end{array}


.. _valid-vconst:

:math:`\V128\K{.}\VCONST~c`
...........................

* The instruction is valid with type :math:`[] \to [\V128]`.

.. math::
   \frac{
   }{
     C \vdashinstr \V128\K{.}\VCONST~c : [] \to [\V128]
   }


.. _valid-vvunop:

:math:`\V128\K{.}\vvunop`
.........................

* The instruction is valid with type :math:`[\V128] \to [\V128]`.

.. math::
   \frac{
   }{
     C \vdashinstr \V128\K{.}\vvunop : [\V128] \to [\V128]
   }


.. _valid-vvbinop:

:math:`\V128\K{.}\vvbinop`
..........................

* The instruction is valid with type :math:`[\V128~\V128] \to [\V128]`.

.. math::
   \frac{
   }{
     C \vdashinstr \V128\K{.}\vvbinop : [\V128~\V128] \to [\V128]
   }


.. _valid-vvternop:

:math:`\V128\K{.}\vvternop`
...........................

* The instruction is valid with type :math:`[\V128~\V128~\V128] \to [\V128]`.

.. math::
   \frac{
   }{
     C \vdashinstr \V128\K{.}\vvternop : [\V128~\V128~\V128] \to [\V128]
   }


.. _valid-vvtestop:

:math:`\V128\K{.}\vvtestop`
...........................

* The instruction is valid with type :math:`[\V128] \to [\I32]`.

.. math::
   \frac{
   }{
     C \vdashinstr \V128\K{.}\vvtestop : [\V128] \to [\I32]
   }


.. _valid-vec-swizzle:

:math:`\K{i8x16.}\SWIZZLE`
..........................

* The instruction is valid with type :math:`[\V128~\V128] \to [\V128]`.

.. math::
   \frac{
   }{
     C \vdashinstr \K{i8x16.}\SWIZZLE : [\V128~\V128] \to [\V128]
   }


.. _valid-vec-shuffle:

:math:`\K{i8x16.}\SHUFFLE~\laneidx^{16}`
........................................

* For all :math:`\laneidx_i`, in :math:`\laneidx^{16}`, :math:`\laneidx_i` must be smaller than :math:`32`.

* The instruction is valid with type :math:`[\V128~\V128] \to [\V128]`.

.. math::
   \frac{
     (\laneidx < 32)^{16}
   }{
     C \vdashinstr \K{i8x16.}\SHUFFLE~\laneidx^{16} : [\V128~\V128] \to [\V128]
   }


.. _valid-vec-splat:

:math:`\shape\K{.}\SPLAT`
.........................

* Let :math:`t` be :math:`\unpacked(\shape)`.

* The instruction is valid with type :math:`[t] \to [\V128]`.

.. math::
   \frac{
   }{
     C \vdashinstr \shape\K{.}\SPLAT : [\unpacked(\shape)] \to [\V128]
   }


.. _valid-vec-extract_lane:

:math:`\shape\K{.}\EXTRACTLANE\K{\_}\sx^?~\laneidx`
...................................................

* The lane index :math:`\laneidx` must be smaller than :math:`\dim(\shape)`.

* The instruction is valid with type :math:`[\V128] \to [\unpacked(\shape)]`.

.. math::
   \frac{
     \laneidx < \dim(\shape)
   }{
     C \vdashinstr t\K{x}N\K{.}\EXTRACTLANE\K{\_}\sx^?~\laneidx : [\V128] \to [\unpacked(\shape)]
   }


.. _valid-vec-replace_lane:

:math:`\shape\K{.}\REPLACELANE~\laneidx`
........................................

* The lane index :math:`\laneidx` must be smaller than :math:`\dim(\shape)`.

* Let :math:`t` be :math:`\unpacked(\shape)`.

* The instruction is valid with type :math:`[\V128~t] \to [\V128]`.

.. math::
   \frac{
     \laneidx < \dim(\shape)
   }{
     C \vdashinstr \shape\K{.}\REPLACELANE~\laneidx : [\V128~\unpacked(\shape)] \to [\V128]
   }


.. _valid-vunop:

:math:`\shape\K{.}\vunop`
.........................

* The instruction is valid with type :math:`[\V128] \to [\V128]`.

.. math::
   \frac{
   }{
     C \vdashinstr \shape\K{.}\vunop : [\V128] \to [\V128]
   }


.. _valid-vbinop:

:math:`\shape\K{.}\vbinop`
..........................

* The instruction is valid with type :math:`[\V128~\V128] \to [\V128]`.

.. math::
   \frac{
   }{
     C \vdashinstr \shape\K{.}\vbinop : [\V128~\V128] \to [\V128]
   }


.. _valid-vrelop:

:math:`\shape\K{.}\vrelop`
..........................

* The instruction is valid with type :math:`[\V128~\V128] \to [\V128]`.

.. math::
   \frac{
   }{
     C \vdashinstr \shape\K{.}\vrelop : [\V128~\V128] \to [\V128]
   }


.. _valid-vishiftop:

:math:`\ishape\K{.}\vishiftop`
..............................

* The instruction is valid with type :math:`[\V128~\I32] \to [\V128]`.

.. math::
   \frac{
   }{
     C \vdashinstr \ishape\K{.}\vishiftop : [\V128~\I32] \to [\V128]
   }


.. _valid-vtestop:

:math:`\shape\K{.}\vtestop`
...........................

* The instruction is valid with type :math:`[\V128] \to [\I32]`.

.. math::
   \frac{
   }{
     C \vdashinstr \shape\K{.}\vtestop : [\V128] \to [\I32]
   }


.. _valid-vcvtop:

:math:`\shape\K{.}\vcvtop\K{\_}\half^?\K{\_}\shape\K{\_}\sx^?\K{\_zero}^?`
..........................................................................

* The instruction is valid with type :math:`[\V128] \to [\V128]`.

.. math::
   \frac{
   }{
     C \vdashinstr \shape\K{.}\vcvtop\K{\_}\half^?\K{\_}\shape\K{\_}\sx^?\K{\_zero}^? : [\V128] \to [\V128]
   }


.. _valid-vec-narrow:

:math:`\ishape_1\K{.}\NARROW\K{\_}\ishape_2\K{\_}\sx`
.....................................................

* The instruction is valid with type :math:`[\V128~\V128] \to [\V128]`.

.. math::
   \frac{
   }{
     C \vdashinstr \ishape_1\K{.}\NARROW\K{\_}\ishape_2\K{\_}\sx : [\V128~\V128] \to [\V128]
   }


.. _valid-vec-bitmask:

:math:`\ishape\K{.}\BITMASK`
............................

* The instruction is valid with type :math:`[\V128] \to [\I32]`.

.. math::
   \frac{
   }{
     C \vdashinstr \ishape\K{.}\BITMASK : [\V128] \to [\I32]
   }


.. _valid-vec-dot:

:math:`\ishape_1\K{.}\DOT\K{\_}\ishape_2\K{\_s}`
................................................

* The instruction is valid with type :math:`[\V128~\V128] \to [\V128]`.

.. math::
   \frac{
   }{
     C \vdashinstr \ishape_1\K{.}\DOT\K{\_}\ishape_2\K{\_s} : [\V128~\V128] \to [\V128]
   }


.. _valid-vec-extmul:

:math:`\ishape_1\K{.}\EXTMUL\K{\_}\half\K{\_}\ishape_2\K{\_}\sx`
................................................................

* The instruction is valid with type :math:`[\V128~\V128] \to [\V128]`.

.. math::
   \frac{
   }{
     C \vdashinstr \ishape_1\K{.}\EXTMUL\K{\_}\half\K{\_}\ishape_2\K{\_}\sx : [\V128~\V128] \to [\V128]
   }


.. _valid-vec-extadd_pairwise:

:math:`\ishape_1\K{.}\EXTADDPAIRWISE\K{\_}\ishape_2\K{\_}\sx`
.............................................................

* The instruction is valid with type :math:`[\V128] \to [\V128]`.

.. math::
   \frac{
   }{
     C \vdashinstr \ishape_1\K{.}\EXTADDPAIRWISE\K{\_}\ishape_2\K{\_}\sx : [\V128] \to [\V128]
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

* The instruction is valid with type :math:`[t] \to []`, for any :ref:`valid <valid-valtype>` :ref:`value type <syntax-valtype>` :math:`t`.

.. math::
   \frac{
     C \vdashvaltype t \ok
   }{
     C \vdashinstr \DROP : [t] \to []
   }

.. note::
   Both |DROP| and |SELECT| without annotation are :ref:`value-polymorphic <polymorphism>` instructions.


.. _valid-select:

:math:`\SELECT~(t^\ast)^?`
..........................

* If :math:`t^\ast` is present, then:

  * The :ref:`result type <syntax-resulttype>` :math:`[t^\ast]` must be :ref:`valid <valid-resulttype>`.

  * The length of :math:`t^\ast` must be :math:`1`.

  * Then the instruction is valid with type :math:`[t^\ast~t^\ast~\I32] \to [t^\ast]`.

* Else:

  * The instruction is valid with type :math:`[t~t~\I32] \to [t]`, for any :ref:`valid <valid-valtype>` :ref:`value type <syntax-valtype>` :math:`t` that :ref:`matches <match-valtype>` some :ref:`number type <syntax-numtype>` or :ref:`vector type <syntax-vectype>`.

.. math::
   \frac{
     C \vdashresulttype [t] \ok
   }{
     C \vdashinstr \SELECT~t : [t~t~\I32] \to [t]
   }
   \qquad
   \frac{
     C \vdashresulttype [t] \ok
     \qquad
     C \vdashresulttypematch [t] \matchesresulttype [\numtype]
   }{
     C \vdashinstr \SELECT : [t~t~\I32] \to [t]
   }
   \qquad
   \frac{
     \vdash t \leq \vectype
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

* Let :math:`\init~t` be the :ref:`local type <syntax-localtype>` :math:`C.\CLOCALS[x]`.

* The :ref:`initialization status <syntax-init>` :math:`\init` must be :math:`\SET`.

* Then the instruction is valid with type :math:`[] \to [t]`.

.. math::
   \frac{
     C.\CLOCALS[x] = \SET~t
   }{
     C \vdashinstr \LOCALGET~x : [] \to [t]
   }


.. _valid-local.set:

:math:`\LOCALSET~x`
...................

* The local :math:`C.\CLOCALS[x]` must be defined in the context.

* Let :math:`\init~t` be the :ref:`local type <syntax-localtype>` :math:`C.\CLOCALS[x]`.

* Then the instruction is valid with type :math:`[t] \to_x []`.

.. math::
   \frac{
     C.\CLOCALS[x] = \init~t
   }{
     C \vdashinstr \LOCALSET~x : [t] \to_x []
   }


.. _valid-local.tee:

:math:`\LOCALTEE~x`
...................

* The local :math:`C.\CLOCALS[x]` must be defined in the context.

* Let :math:`\init~t` be the :ref:`local type <syntax-localtype>` :math:`C.\CLOCALS[x]`.

* Then the instruction is valid with type :math:`[t] \to_x [t]`.

.. math::
   \frac{
     C.\CLOCALS[x] = \init~t
   }{
     C \vdashinstr \LOCALTEE~x : [t] \to_x [t]
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


.. index:: table instruction, table index, context
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
     C.\CTABLES[x] = \limits~t
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
     C.\CTABLES[x] = \tabletype
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
     C.\CTABLES[x] = \limits~t
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
     C.\CTABLES[x] = \limits~t
   }{
     C \vdashinstr \TABLEFILL~x : [\I32~t~\I32] \to []
   }


.. _valid-table.copy:

:math:`\TABLECOPY~x~y`
......................

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Let :math:`\limits_1~t_1` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[x]`.

* The table :math:`C.\CTABLES[y]` must be defined in the context.

* Let :math:`\limits_2~t_2` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[y]`.

* The :ref:`reference type <syntax-reftype>` :math:`t_2` must :ref:`match <match-reftype>` :math:`t_1`.

* Then the instruction is valid with type :math:`[\I32~\I32~\I32] \to []`.

.. math::
   \frac{
     C.\CTABLES[x] = \limits_1~t_1
     \qquad
     C.\CTABLES[y] = \limits_2~t_2
     \qquad
     C \vdashreftypematch t_2 \matchesvaltype t_1
   }{
     C \vdashinstr \TABLECOPY~x~y : [\I32~\I32~\I32] \to []
   }


.. _valid-table.init:

:math:`\TABLEINIT~x~y`
......................

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Let :math:`\limits~t_1` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[x]`.

* The element segment :math:`C.\CELEMS[y]` must be defined in the context.

* Let :math:`t_2` be the :ref:`reference type <syntax-reftype>` :math:`C.\CELEMS[y]`.

* The :ref:`reference type <syntax-reftype>` :math:`t_2` must :ref:`match <match-reftype>` :math:`t_1`.

* Then the instruction is valid with type :math:`[\I32~\I32~\I32] \to []`.

.. math::
   \frac{
     C.\CTABLES[x] = \limits~t_1
     \qquad
     C.\CELEMS[y] = t_2
     \qquad
     C \vdashreftypematch t_2 \matchesvaltype t_1
   }{
     C \vdashinstr \TABLEINIT~x~y : [\I32~\I32~\I32] \to []
   }


.. _valid-elem.drop:

:math:`\ELEMDROP~x`
...................

* The element segment :math:`C.\CELEMS[x]` must be defined in the context.

* Then the instruction is valid with type :math:`[] \to []`.

.. math::
   \frac{
     C.\CELEMS[x] = t
   }{
     C \vdashinstr \ELEMDROP~x : [] \to []
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

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than the :ref:`bit width <syntax-numtype>` of :math:`t` divided by :math:`8`.

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

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than the :ref:`bit width <syntax-numtype>` of :math:`t` divided by :math:`8`.

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


.. _valid-load-extend:

:math:`\K{v128.}\LOAD{N}\K{x}M\_\sx~\memarg`
...............................................

* The memory :math:`C.\CMEMS[0]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than :math:`N/8 \cdot M`.

* Then the instruction is valid with type :math:`[\I32] \to [\V128]`.

.. math::
   \frac{
     C.\CMEMS[0] = \memtype
     \qquad
     2^{\memarg.\ALIGN} \leq N/8 \cdot M
   }{
     C \vdashinstr \K{v128.}\LOAD{N}\K{x}M\_\sx~\memarg : [\I32] \to [\V128]
   }


.. _valid-load-splat:

:math:`\K{v128.}\LOAD{N}\K{\_splat}~\memarg`
...............................................

* The memory :math:`C.\CMEMS[0]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than :math:`N/8`.

* Then the instruction is valid with type :math:`[\I32] \to [\V128]`.

.. math::
   \frac{
     C.\CMEMS[0] = \memtype
     \qquad
     2^{\memarg.\ALIGN} \leq N/8
   }{
     C \vdashinstr \K{v128.}\LOAD{N}\K{\_splat}~\memarg : [\I32] \to [\V128]
   }


.. _valid-load-zero:

:math:`\K{v128.}\LOAD{N}\K{\_zero}~\memarg`
...........................................

* The memory :math:`C.\CMEMS[0]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than :math:`N/8`.

* Then the instruction is valid with type :math:`[\I32] \to [\V128]`.

.. math::
   \frac{
     C.\CMEMS[0] = \memtype
     \qquad
     2^{\memarg.\ALIGN} \leq N/8
   }{
     C \vdashinstr \K{v128.}\LOAD{N}\K{\_zero}~\memarg : [\I32] \to [\V128]
   }


.. _valid-load-lane:

:math:`\K{v128.}\LOAD{N}\K{\_lane}~\memarg~\laneidx`
....................................................

* The lane index :math:`\laneidx` must be smaller than :math:`128/N`.

* The memory :math:`C.\CMEMS[0]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than :math:`N/8`.

* Then the instruction is valid with type :math:`[\I32~\V128] \to [\V128]`.

.. math::
   \frac{
     \laneidx < 128/N
     \qquad
     C.\CMEMS[0] = \memtype
     \qquad
     2^{\memarg.\ALIGN} < N/8
   }{
     C \vdashinstr \K{v128.}\LOAD{N}\K{\_lane}~\memarg~\laneidx : [\I32~\V128] \to [\V128]
   }

.. _valid-store-lane:

:math:`\K{v128.}\STORE{N}\K{\_lane}~\memarg~\laneidx`
.....................................................

* The lane index :math:`\laneidx` must be smaller than :math:`128/N`.

* The memory :math:`C.\CMEMS[0]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than :math:`N/8`.

* Then the instruction is valid with type :math:`[\I32~\V128] \to [\V128]`.

.. math::
   \frac{
     \laneidx < 128/N
     \qquad
     C.\CMEMS[0] = \memtype
     \qquad
     2^{\memarg.\ALIGN} < N/8
   }{
     C \vdashinstr \K{v128.}\STORE{N}\K{\_lane}~\memarg~\laneidx : [\I32~\V128] \to []
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


.. _valid-memory.fill:

:math:`\MEMORYFILL`
...................

* The memory :math:`C.\CMEMS[0]` must be defined in the context.

* Then the instruction is valid with type :math:`[\I32~\I32~\I32] \to []`.

.. math::
   \frac{
     C.\CMEMS[0] = \memtype
   }{
     C \vdashinstr \MEMORYFILL : [\I32~\I32~\I32] \to []
   }


.. _valid-memory.copy:

:math:`\MEMORYCOPY`
...................

* The memory :math:`C.\CMEMS[0]` must be defined in the context.

* Then the instruction is valid with type :math:`[\I32~\I32~\I32] \to []`.

.. math::
   \frac{
     C.\CMEMS[0] = \memtype
   }{
     C \vdashinstr \MEMORYCOPY : [\I32~\I32~\I32] \to []
   }


.. _valid-memory.init:

:math:`\MEMORYINIT~x`
.....................

* The memory :math:`C.\CMEMS[0]` must be defined in the context.

* The data segment :math:`C.\CDATAS[x]` must be defined in the context.

* Then the instruction is valid with type :math:`[\I32~\I32~\I32] \to []`.

.. math::
   \frac{
     C.\CMEMS[0] = \memtype
     \qquad
     C.\CDATAS[x] = {\ok}
   }{
     C \vdashinstr \MEMORYINIT~x : [\I32~\I32~\I32] \to []
   }


.. _valid-data.drop:

:math:`\DATADROP~x`
...................

* The data segment :math:`C.\CDATAS[x]` must be defined in the context.

* Then the instruction is valid with type :math:`[] \to []`.

.. math::
   \frac{
     C.\CDATAS[x] = {\ok}
   }{
     C \vdashinstr \DATADROP~x : [] \to []
   }


.. index:: control instructions, structured control, label, block, branch, block type, label index, function index, type index, vector, polymorphism, context
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

* The instruction is valid with any :ref:`valid <valid-instrtype>` type of the form :math:`[t_1^\ast] \to [t_2^\ast]`.

.. math::
   \frac{
     C \vdashinstrtype [t_1^\ast] \to [t_2^\ast] \ok
   }{
     C \vdashinstr \UNREACHABLE : [t_1^\ast] \to [t_2^\ast]
   }

.. note::
   The |UNREACHABLE| instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-block:

:math:`\BLOCK~\blocktype~\instr^\ast~\END`
..........................................

* The :ref:`block type <syntax-blocktype>` must be :ref:`valid <valid-blocktype>` as some :ref:`function type <syntax-functype>` :math:`[t_1^\ast] \to [t_2^\ast]`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`result type <syntax-resulttype>` :math:`[t_2^\ast]` prepended to the |CLABELS| vector.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[t_1^\ast] \to_{x^\ast} [t_2^\ast]`, for any sequence of :ref:`local indices <syntax-localidx>` :math:`x^\ast`.

* Then the compound instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`.

.. math::
   \frac{
     C \vdashblocktype \blocktype : [t_1^\ast] \to [t_2^\ast]
     \qquad
     C,\CLABELS\,[t_2^\ast] \vdashinstrseq \instr^\ast : [t_1^\ast] \to_{x^\ast} [t_2^\ast]
   }{
     C \vdashinstr \BLOCK~\blocktype~\instr^\ast~\END : [t_1^\ast] \to [t_2^\ast]
   }

.. note::
   The :ref:`notation <notation-extend>` :math:`C,\CLABELS\,[t^\ast]` inserts the new label type at index :math:`0`, shifting all others.


.. _valid-loop:

:math:`\LOOP~\blocktype~\instr^\ast~\END`
.........................................

* The :ref:`block type <syntax-blocktype>` must be :ref:`valid <valid-blocktype>` as some :ref:`instruction type <syntax-functype>` :math:`[t_1^\ast] \to_{x^\ast} [t_2^\ast]`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`result type <syntax-resulttype>` :math:`[t_1^\ast]` prepended to the |CLABELS| vector.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[t_1^\ast] \to_{x^\ast} [t_2^\ast]`, for any sequence of :ref:`local indices <syntax-localidx>` :math:`x^\ast`.

* Then the compound instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`.

.. math::
   \frac{
     C \vdashblocktype \blocktype : [t_1^\ast] \to [t_2^\ast]
     \qquad
     C,\CLABELS\,[t_1^\ast] \vdashinstrseq \instr^\ast : [t_1^\ast] \to_{x^\ast} [t_2^\ast]
   }{
     C \vdashinstr \LOOP~\blocktype~\instr^\ast~\END : [t_1^\ast] \to [t_2^\ast]
   }

.. note::
   The :ref:`notation <notation-extend>` :math:`C,\CLABELS\,[t^\ast]` inserts the new label type at index :math:`0`, shifting all others.


.. _valid-if:

:math:`\IF~\blocktype~\instr_1^\ast~\ELSE~\instr_2^\ast~\END`
.............................................................

* The :ref:`block type <syntax-blocktype>` must be :ref:`valid <valid-blocktype>` as some :ref:`function type <syntax-functype>` :math:`[t_1^\ast] \to [t_2^\ast]`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`result type <syntax-resulttype>` :math:`[t_2^\ast]` prepended to the |CLABELS| vector.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr_1^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[t_1^\ast] \to_{x_1^\ast} [t_2^\ast]`, for any sequence of :ref:`local indices <syntax-localidx>` :math:`x_1^\ast`.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr_2^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[t_1^\ast] \to_{x_2^\ast} [t_2^\ast]`, for any sequence of :ref:`local indices <syntax-localidx>` :math:`x_2^\ast`.

* Then the compound instruction is valid with type :math:`[t_1^\ast~\I32] \to [t_2^\ast]`.

.. math::
   \frac{
     C \vdashblocktype \blocktype : [t_1^\ast] \to [t_2^\ast]
     \qquad
     C,\CLABELS\,[t_2^\ast] \vdashinstrseq \instr_1^\ast : [t_1^\ast] \to_{x_1^\ast} [t_2^\ast]
     \qquad
     C,\CLABELS\,[t_2^\ast] \vdashinstrseq \instr_2^\ast : [t_1^\ast] \to_{x_2^\ast} [t_2^\ast]
   }{
     C \vdashinstr \IF~\blocktype~\instr_1^\ast~\ELSE~\instr_2^\ast~\END : [t_1^\ast~\I32] \to [t_2^\ast]
   }

.. note::
   The :ref:`notation <notation-extend>` :math:`C,\CLABELS\,[t^\ast]` inserts the new label type at index :math:`0`, shifting all others.


.. _valid-br:

:math:`\BR~l`
.............

* The label :math:`C.\CLABELS[l]` must be defined in the context.

* Let :math:`[t^\ast]` be the :ref:`result type <syntax-resulttype>` :math:`C.\CLABELS[l]`.

* Then the instruction is valid with any :ref:`valid <valid-instrtype>` type of the form :math:`[t_1^\ast~t^\ast] \to [t_2^\ast]`.

.. math::
   \frac{
     C.\CLABELS[l] = [t^\ast]
     \qquad
     C \vdashinstrtype [t_1^\ast~t^\ast] \to [t_2^\ast] \ok
   }{
     C \vdashinstr \BR~l : [t_1^\ast~t^\ast] \to [t_2^\ast]
   }

.. note::
   The :ref:`label index <syntax-labelidx>` space in the :ref:`context <context>` :math:`C` contains the most recent label first, so that :math:`C.\CLABELS[l]` performs a relative lookup as expected.

   The |BR| instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-br_if:

:math:`\BRIF~l`
...............

* The label :math:`C.\CLABELS[l]` must be defined in the context.

* Let :math:`[t^\ast]` be the :ref:`result type <syntax-resulttype>` :math:`C.\CLABELS[l]`.

* Then the instruction is valid with type :math:`[t^\ast~\I32] \to [t^\ast]`.

.. math::
   \frac{
     C.\CLABELS[l] = [t^\ast]
   }{
     C \vdashinstr \BRIF~l : [t^\ast~\I32] \to [t^\ast]
   }

.. note::
   The :ref:`label index <syntax-labelidx>` space in the :ref:`context <context>` :math:`C` contains the most recent label first, so that :math:`C.\CLABELS[l]` performs a relative lookup as expected.


.. _valid-br_table:

:math:`\BRTABLE~l^\ast~l_N`
...........................


* The label :math:`C.\CLABELS[l_N]` must be defined in the context.

* For all :math:`l_i` in :math:`l^\ast`,
  the label :math:`C.\CLABELS[l_i]` must be defined in the context.

* There must be a sequence :math:`t^\ast` of :ref:`value types <syntax-valtype>`, such that:

  * The result type :math:`[t^\ast]` :ref:`matches <match-resulttype>` :math:`C.\CLABELS[l_N]`.

  * For all :math:`l_i` in :math:`l^\ast`,
    the result type :math:`[t^\ast]` :ref:`matches <match-resulttype>` :math:`C.\CLABELS[l_i]`.

* Then the instruction is valid with any :ref:`valid <valid-instrtype>` type of the form :math:`[t_1^\ast~t^\ast~\I32] \to [t_2^\ast]`.

.. math::
   \frac{
     (C \vdashresulttypematch [t^\ast] \matchesresulttype C.\CLABELS[l])^\ast
     \qquad
     C \vdashresulttypematch [t^\ast] \matchesresulttype C.\CLABELS[l_N]
     \qquad
     C \vdashinstrtype [t_1^\ast~t^\ast~\I32] \to [t_2^\ast] \ok
   }{
     C \vdashinstr \BRTABLE~l^\ast~l_N : [t_1^\ast~t^\ast~\I32] \to [t_2^\ast]
   }

.. note::
   The :ref:`label index <syntax-labelidx>` space in the :ref:`context <context>` :math:`C` contains the most recent label first, so that :math:`C.\CLABELS[l_i]` performs a relative lookup as expected.

   The |BRTABLE| instruction is :ref:`stack-polymorphic <polymorphism>`.

   Furthermore, the :ref:`result type <syntax-resulttype>` :math:`[t^\ast]` is also chosen non-deterministically in this rule.
   Although it may seem necessary to compute :math:`[t^\ast]` as the greatest lower bound of all label types in practice,
   a simple :ref:`linear algorithm <algo-valid>` does not require this.


.. _valid-br_on_null:

:math:`\BRONNULL~l`
...................

* The label :math:`C.\CLABELS[l]` must be defined in the context.

* Let :math:`[t^\ast]` be the :ref:`result type <syntax-resulttype>` :math:`C.\CLABELS[l]`.

* Then the instruction is valid with type :math:`[t^\ast~(\REF~\NULL~\X{ht})] \to [t^\ast~(\REF~\X{ht})]` for any :ref:`valid <valid-heaptype>` :ref:`heap type <syntax-heaptype>` :math:`\X{ht}`.

.. math::
   \frac{
     C.\CLABELS[l] = [t^\ast]
     \qquad
     C \vdashheaptype \X{ht} \ok
   }{
     C \vdashinstr \BRONNULL~l : [t^\ast~(\REF~\NULL~\X{ht})] \to [t^\ast~(\REF~\X{ht})]
   }


.. _valid-br_on_non_null:

:math:`\BRONNONNULL~l`
......................

* The label :math:`C.\CLABELS[l]` must be defined in the context.

* Let :math:`[{t'}^\ast]` be the :ref:`result type <syntax-resulttype>` :math:`C.\CLABELS[l]`.

* The result type :math:`[{t'}^\ast]` must contain at least one type.

* Let the :ref:`value type <syntax-valtype>` :math:`t_l` be the last element in the sequence :math:`{t'}^\ast`, and :math:`[t^\ast]` the remainder of the sequence preceding it.

* The value type :math:`t_l` must be a reference type of the form :math:`\REF~\NULL^?~\X{ht}`.

* Then the instruction is valid with type :math:`[t^\ast~(\REF~\NULL~\X{ht})] \to [t^\ast]`.

.. math::
   \frac{
     C.\CLABELS[l] = [t^\ast~(\REF~\X{ht})]
   }{
     C \vdashinstr \BRONNONNULL~l : [t^\ast~(\REF~\NULL~\X{ht})] \to [t^\ast]
   }


.. _valid-return:

:math:`\RETURN`
...............

* The return type :math:`C.\CRETURN` must not be absent in the context.

* Let :math:`[t^\ast]` be the :ref:`result type <syntax-resulttype>` of :math:`C.\CRETURN`.

* Then the instruction is valid with any :ref:`valid <valid-instrtype>` type of the form :math:`[t_1^\ast] \to [t_2^\ast]`.

.. math::
   \frac{
     C.\CRETURN = [t^\ast]
     \qquad
     C \vdashinstrtype [t_1^\ast~t^\ast] \to [t_2^\ast] \ok
   }{
     C \vdashinstr \RETURN : [t_1^\ast~t^\ast] \to [t_2^\ast]
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

* Let :math:`y` be the :ref:`type index <syntax-typeidx>` :math:`C.\CFUNCS[x]`.

* Assert: The type :math:`C.\CTYPES[y]` is defined in the context.

* Let :math:`[t_1^\ast] \to [t_2^\ast]` be the :ref:`function type <syntax-functype>` :math:`C.\CTYPES[y]`.

* Then the instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`.

.. math::
   \frac{
     C.\CTYPES[C.\CFUNCS[x]] = [t_1^\ast] \to [t_2^\ast]
   }{
     C \vdashinstr \CALL~x : [t_1^\ast] \to [t_2^\ast]
   }


.. _valid-call_ref:

:math:`\CALLREF~x`
..................

* The type :math:`C.\CTYPES[x]` must be defined in the context.

* Let :math:`[t_1^\ast] \to [t_2^\ast]` be the :ref:`function type <syntax-functype>` :math:`C.\CTYPES[x]`.

* Then the instruction is valid with type :math:`[t_1^\ast~(\REF~\NULL~x)] \to [t_2^\ast]`.

.. math::
   \frac{
     C.\CTYPES[x] = [t_1^\ast] \to [t_2^\ast]
   }{
     C \vdashinstr \CALLREF~x : [t_1^\ast~(\REF~\NULL~x)] \to [t_2^\ast]
   }


.. _valid-call_indirect:

:math:`\CALLINDIRECT~x~y`
.........................

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Let :math:`\limits~t` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[x]`.

* The :ref:`reference type <syntax-reftype>` :math:`t` must :ref:`match <match-reftype>` type :math:`\REF~\NULL~\FUNC`.

* The type :math:`C.\CTYPES[y]` must be defined in the context.

* Let :math:`[t_1^\ast] \to [t_2^\ast]` be the :ref:`function type <syntax-functype>` :math:`C.\CTYPES[y]`.

* Then the instruction is valid with type :math:`[t_1^\ast~\I32] \to [t_2^\ast]`.

.. math::
   \frac{
     C.\CTABLES[x] = \limits~t
     \qquad
     C \vdashvaltypematch t \matchesreftype \REF~\NULL~\FUNC
     \qquad
     C.\CTYPES[y] = [t_1^\ast] \to [t_2^\ast]
   }{
     C \vdashinstr \CALLINDIRECT~x~y : [t_1^\ast~\I32] \to [t_2^\ast]
   }


.. _valid-return_call:

:math:`\RETURNCALL~x`
.....................

* The return type :math:`C.\CRETURN` must not be absent in the context.

* The function :math:`C.\CFUNCS[x]` must be defined in the context.

* Let :math:`[t_1^\ast] \to [t_2^?]` be the :ref:`function type <syntax-functype>` :math:`C.\CFUNCS[x]`.

* The :ref:`result type <syntax-resulttype>` :math:`[t_2^?]` must be the same as :math:`C.\CRETURN`.

* Then the instruction is valid with type :math:`[t_3^\ast~t_1^\ast] \to [t_4^\ast]`, for any sequences of :ref:`value types <syntax-valtype>` :math:`t_3^\ast` and :math:`t_4^\ast`.

.. math::
   \frac{
     C.\CFUNCS[x] = [t_1^\ast] \to [t_2^?]
     \qquad
     C.\CRETURN = [t_2^?]
   }{
     C \vdashinstr \RETURNCALL~x : [t_3^\ast~t_1^\ast] \to [t_4^\ast]
   }

.. note::
   The |RETURNCALL| instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-return_call_indirect:

:math:`\RETURNCALLINDIRECT~x~y`
...............................

* The return type :math:`C.\CRETURN` must not be empty in the context.

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Let :math:`\limits~\reftype` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[x]`.

* The :ref:`reference type <syntax-reftype>` :math:`\reftype` must be |FUNCREF|.

* The type :math:`C.\CTYPES[y]` must be defined in the context.

* Let :math:`[t_1^\ast] \to [t_2^?]` be the :ref:`function type <syntax-functype>` :math:`C.\CTYPES[y]`.

* The :ref:`result type <syntax-resulttype>` :math:`[t_2^?]` must be the same as :math:`C.\CRETURN`.

* Then the instruction is valid with type :math:`[t_3^\ast~t_1^\ast~\I32] \to [t_4^\ast]`, for any sequences of :ref:`value types <syntax-valtype>` :math:`t_3^\ast` and :math:`t_4^\ast`.


.. math::
   \frac{
     C.\CTABLES[x] = \limits~\FUNCREF
     \qquad
     C.\CTYPES[y] = [t_1^\ast] \to [t_2^?]
     \qquad
     C.\CRETURN = [t_2^?]
   }{
     C \vdashinstr \RETURNCALLINDIRECT~x~y : [t_3^\ast~t_1^\ast~\I32] \to [t_4^\ast]
   }

.. note::
   The |RETURNCALLINDIRECT| instruction is :ref:`stack-polymorphic <polymorphism>`.


.. index:: instruction, instruction sequence, local type
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


Non-empty Instruction Sequence: :math:`\instr~{\instr'}^\ast`
.............................................................

* The instruction :math:`\instr` must be valid with some type :math:`[t_1^\ast] \to_{x_1^\ast} [t_0^\ast]`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`,
  but with:

  * |CLOCALS| the same as in C, except that for every :ref:`local index <syntax-localidx>` :math:`x` in :math:`x_1^\ast`, the :ref:`local type <syntax-localtype>` :math:`\CLOCALS[x]` has been updated to :ref:`initialization status <syntax-init>` :math:`\SET`.

* The instruction sequence :math:`{\instr'}^\ast` must be valid with some type :math:`[{t'}^\ast] \to_{x_2^\ast} [t_3^\ast]`.

* There must be a sequence of :ref:`value types <syntax-valtype>` :math:`t_0^\ast`,
  such that :math:`t_0^\ast = t_2^\ast~t^\ast` where the type sequence :math:`t^\ast` is as long as :math:`{t'}^\ast`.

* For each :ref:`value type <syntax-valtype>` :math:`t'_i` in :math:`{t'}^\ast` and corresponding type :math:`t_i` in :math:`t^\ast`, the type :math:`t_i` must :ref:`match <match-valtype>` :math:`t'_i`.

* Then the combined instruction sequence is valid with type :math:`[t_1^\ast] \to_{x_1^\ast x_2^\ast} [t_2^\ast~t_3^\ast]`.

.. math::
   \frac{
     \begin{array}{@{}c@{}}
     C \vdashinstr \instr : [t_1^\ast] \to_{x_1^\ast} [t_2^\ast~t^\ast]
     \qquad
     (C \vdashvaltypematch t \matchesvaltype t')^\ast
     \qquad
     C' \vdashinstrseq {\instr'}^\ast : [{t'}^\ast] \to_{x_2^\ast} [t_3^\ast]
     \\
     (\init~t = C.\CLOCALS[x_1])^\ast
     \qquad
     C' = C~(\with C.\CLOCALS[x_1] = \SET~t)^\ast
     \end{array}
   }{
     C \vdashinstrseq \instr~{\instr'}^\ast : [t_1^\ast] \to_{x_1^\ast x_2^\ast} [t_2^\ast~t_3^\ast]
   }


.. index:: expression, result type
   pair: validation; expression
   single: abstract syntax; expression
   single: expression; constant
.. _valid-expr:

Expressions
~~~~~~~~~~~

Expressions :math:`\expr` are classified by :ref:`result types <syntax-resulttype>` of the form :math:`[t^\ast]`.


:math:`\instr^\ast~\END`
........................

* The instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instr-seq>` with some :ref:`type <syntax-instrtype>` :math:`[] \to_{x^\ast} [{t'}^\ast]`.

* For each :ref:`value type <syntax-valtype>` :math:`t'_i` in :math:`{t'}^\ast` and corresponding :ref:`valid <valid-valtype>` :ref:`value type <syntax-valtype>` type :math:`t_i` in :math:`t^\ast`, :math:`t'_i` :ref:`matches <match-valtype>` :math:`t_i`.

* Then the expression is valid with :ref:`result type <syntax-resulttype>` :math:`[t^\ast]`.

.. math::
   \frac{
     C \vdashinstrseq \instr^\ast : [] \to_{x^\ast} [{t'}^\ast]
     \qquad
     C \vdashresulttype [t^\ast] \ok
     \qquad
     (C \vdashvaltypematch t' \matchesvaltype t)^\ast
   }{
     C \vdashexpr \instr^\ast~\END : [t^\ast]
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
     C \vdashinstrconst \REFNULL~t \const
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
   Currently, constant expressions occurring in :ref:`globals <syntax-global>`, :ref:`element <syntax-elem>`, or :ref:`data <syntax-data>` segments are further constrained in that contained |GLOBALGET| instructions are only allowed to refer to *imported* globals.
   This is enforced in the :ref:`validation rule for modules <valid-module>` by constraining the context :math:`C` accordingly.

   The definition of constant expression may be extended in future versions of WebAssembly.

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
   For example, the instruction ${:BINOP I32 ADD} has type ${: I32 I32 -> I32},
   consuming two ${:I32} values and producing one.
   The instruction ${:LOCAL.SET x} has type ${instrtype: t ->_(x) eps}, provided ${:t} is the type declared for the local ${:x}.

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

   $${: (CONST I32 1) (CONST I32 2) (CONST I32 3) SELECT}

   and

   $${: (CONST F64 1.0) (CONST F64 2.0) (CONST F64 3.0) SELECT}

   are valid, with ${:t} in the typing of ${:SELECT} being instantiated to ${:I32} or ${:F64}, respectively.

   The ${:UNREACHABLE} instruction is stack-polymorphic,
   and hence valid with type ${instrtype: t_1* -> t_2*} for any possible sequences of value types ${:t_1*} and ${:t_2*}.
   Consequently,

   $${: UNREACHABLE $($(BINOP I32 ADD))}

   is valid by assuming type ${instrtype: eps -> I32} for the ${:UNREACHABLE} instruction.
   In contrast,

   $${: UNREACHABLE (CONST I64 0) $($(BINOP I32 ADD))}

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

* The instruction is valid with type :math:`[] \to []`.

$${rule: Instr_ok/nop}


.. _valid-unreachable:

:math:`\UNREACHABLE`
....................

* The instruction is valid with any :ref:`valid <valid-instrtype>` type of the form :math:`[t_1^\ast] \to [t_2^\ast]`.

$${rule: Instr_ok/unreachable}

.. note::
   The ${:UNREACHABLE} instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-drop:

:math:`\DROP`
.............

* The instruction is valid with type :math:`[t] \to []`, for any :ref:`valid <valid-valtype>` :ref:`value type <syntax-valtype>` :math:`t`.

$${rule: Instr_ok/drop}

.. note::
   Both ${:DROP} and ${:SELECT} without annotation are :ref:`value-polymorphic <polymorphism>` instructions.


.. _valid-select:

:math:`\SELECT~(t^\ast)^?`
..........................

* If :math:`t^\ast` is present, then:

  * The :ref:`result type <syntax-resulttype>` :math:`[t^\ast]` must be :ref:`valid <valid-resulttype>`.

  * The length of :math:`t^\ast` must be :math:`1`.

  * Then the instruction is valid with type :math:`[t^\ast~t^\ast~\I32] \to [t^\ast]`.

* Else:

  * The instruction is valid with type :math:`[t~t~\I32] \to [t]`, for any :ref:`valid <valid-valtype>` :ref:`value type <syntax-valtype>` :math:`t` that :ref:`matches <match-valtype>` some :ref:`number type <syntax-numtype>` or :ref:`vector type <syntax-vectype>`.

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

* The instruction is valid with type :math:`[] \to [t]`.

$${rule: Instr_ok/const}


.. _valid-unop:

:math:`t\K{.}\unop`
...................

* The instruction is valid with type :math:`[t] \to [t]`.

$${rule: Instr_ok/unop}


.. _valid-binop:

:math:`t\K{.}\binop`
....................

* The instruction is valid with type :math:`[t~t] \to [t]`.

$${rule: Instr_ok/binop}


.. _valid-testop:

:math:`t\K{.}\testop`
.....................

* The instruction is valid with type :math:`[t] \to [\I32]`.

$${rule: Instr_ok/testop}


.. _valid-relop:

:math:`t\K{.}\relop`
....................

* The instruction is valid with type :math:`[t~t] \to [\I32]`.

$${rule: Instr_ok/relop}


.. _valid-cvtop:

:math:`t_2\K{.}\cvtop\K{\_}t_1\K{\_}\sx^?`
..........................................

* The instruction is valid with type :math:`[t_1] \to [t_2]`.

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

* The :ref:`heap type <syntax-heaptype>` :math:`\X{ht}` must be :ref:`valid <valid-heaptype>`.

* Then the instruction is valid with type :math:`[] \to [(\REF~\NULL~\X{ht})]`.

$${rule: Instr_ok/ref.null}


.. _valid-ref.func:

:math:`\REFFUNC~x`
..................

* The function :math:`C.\CFUNCS[x]` must be defined in the context.

* Let :math:`\X{dt}` be the :ref:`defined type <syntax-deftype>` :math:`C.\CFUNCS[x]`.

* The :ref:`function index <syntax-funcidx>` :math:`x` must be contained in :math:`C.\CREFS`.

* The instruction is valid with type :math:`[] \to [(\REF~\X{dt})]`.

$${rule: Instr_ok/ref.func}


.. _valid-ref.is_null:

:math:`\REFISNULL`
..................

* The instruction is valid with type :math:`[(\REF~\NULL~\X{ht})] \to [\I32]`, for any :ref:`valid <valid-heaptype>` :ref:`heap type <syntax-heaptype>` :math:`\X{ht}`.

$${rule: Instr_ok/ref.is_null}


.. _valid-ref.as_non_null:

:math:`\REFASNONNULL`
.....................

* The instruction is valid with type :math:`[(\REF~\NULL~\X{ht})] \to [(\REF~\X{ht})]`, for any :ref:`valid <valid-heaptype>` :ref:`heap type <syntax-heaptype>` :math:`\X{ht}`.

$${rule: Instr_ok/ref.as_non_null}


.. _valid-ref.eq:

:math:`\REFEQ`
..............

* The instruction is valid with type :math:`[(\REF~\NULL~\EQT) (\REF~\NULL~\EQT)] \to [\I32]`.

$${rule: Instr_ok/ref.eq}


.. _valid-ref.test:

:math:`\REFTEST~\X{rt}`
.......................

* The :ref:`reference type <syntax-reftype>` :math:`\X{rt}` must be :ref:`valid <valid-reftype>`.

* Then the instruction is valid with type :math:`[\X{rt}'] \to [\I32]` for any :ref:`valid <valid-reftype>` :ref:`reference type <syntax-reftype>` :math:`\X{rt}'` for which :math:`\X{rt}` :ref:`matches <match-reftype>` :math:`\X{rt}'`.

$${rule: Instr_ok/ref.test}

.. note::
   The liberty to pick a supertype ${:rt'} allows typing the instruction with the least precise super type of ${:rt} as input, that is, the top type in the corresponding heap subtyping hierarchy.


.. _valid-ref.cast:

:math:`\REFCAST~\X{rt}`
.......................

* The :ref:`reference type <syntax-reftype>` :math:`\X{rt}` must be :ref:`valid <valid-reftype>`.

* Then the instruction is valid with type :math:`[\X{rt}'] \to [\X{rt}]` for any :ref:`valid <valid-reftype>` :ref:`reference type <syntax-reftype>` :math:`\X{rt}'` for which :math:`\X{rt}` :ref:`matches <match-reftype>` :math:`\X{rt}'`.

$${rule: Instr_ok/ref.cast}

.. note::
   The liberty to pick a supertype ${:rt'} allows typing the instruction with the least precise super type of ${:rt} as input, that is, the top type in the corresponding heap subtyping hierarchy.


.. index:: aggregate reference

Aggregate Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-struct.new:

:math:`\STRUCTNEW~x`
....................

* The :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]` must exist.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CTYPES[x]` must be a :ref:`structure type <syntax-structtype>` :math:`\TSTRUCT~\fieldtype^\ast`.

* For each :ref:`field type <syntax-fieldtype>` :math:`\fieldtype_i` in :math:`\fieldtype^\ast`:

  - Let :math:`\fieldtype_i` be :math:`\mut~\storagetype_i`.

  - Let :math:`t_i` be the :ref:`value type <syntax-valtype>` :math:`\unpack(\storagetype_i)`.

* Let :math:`t^\ast` be the concatenation of all :math:`t_i`.

* Then the instruction is valid with type :math:`[t^\ast] \to [(\REF~x)]`.

$${rule: Instr_ok/struct.new}


.. _valid-struct.new_default:

:math:`\STRUCTNEWDEFAULT~x`
...........................

* The :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]` must exist.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CTYPES[x]` must be a :ref:`structure type <syntax-structtype>` :math:`\TSTRUCT~\fieldtype^\ast`.

* For each :ref:`field type <syntax-fieldtype>` :math:`\fieldtype_i` in :math:`\fieldtype^\ast`:

  - Let :math:`\fieldtype_i` be :math:`\mut~\storagetype_i`.

  - Let :math:`t_i` be the :ref:`value type <syntax-valtype>` :math:`\unpack(\storagetype_i)`.

  - The type :math:`t_i` must be defaultable.

* Let :math:`t^\ast` be the concatenation of all :math:`t_i`.

* Then the instruction is valid with type :math:`[] \to [(\REF~x)]`.

$${rule: Instr_ok/struct.new_default}


.. _valid-struct.get:
.. _valid-struct.get_u:
.. _valid-struct.get_s:

:math:`\STRUCTGET\K{\_}\sx^?~x~y`
.................................

* The :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]` must exist.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CTYPES[x]` must be a :ref:`structure type <syntax-structtype>` :math:`\TSTRUCT~\fieldtype^\ast`.

* Let the :ref:`field type <syntax-fieldtype>` :math:`\mut~\storagetype` be :math:`\fieldtype^\ast[y]`.

* Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`\unpack(\storagetype)`.

* The extension :math:`\sx` must be present if and only if :math:`\storagetype` is a :ref:`packed type <syntax-packtype>`.

* Then the instruction is valid with type :math:`[(\REF~\NULL~x)] \to [t]`.

$${rule: Instr_ok/struct.get}


.. _valid-struct.set:

:math:`\STRUCTSET~x~y`
......................

* The :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]` must exist.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CTYPES[x]` must be a :ref:`structure type <syntax-structtype>` :math:`\TSTRUCT~\fieldtype^\ast`.

* Let the :ref:`field type <syntax-fieldtype>` :math:`\mut~\storagetype` be :math:`\fieldtype^\ast[y]`.

* The prefix :math:`\mut` must be :math:`\MVAR`.

* Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`\unpack(\storagetype)`.

* Then the instruction is valid with type :math:`[(\REF~\NULL~x)~t] \to []`.

$${rule: Instr_ok/struct.set}


.. _valid-array.new:

:math:`\ARRAYNEW~x`
...................

* The :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]` must exist.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CTYPES[x]` must be an :ref:`array type <syntax-arraytype>` :math:`\TARRAY~\fieldtype`.

* Let :math:`\fieldtype` be :math:`\mut~\storagetype`.

* Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`\unpack(\storagetype)`.

* Then the instruction is valid with type :math:`[t~\I32] \to [(\REF~x)]`.

$${rule: Instr_ok/array.new}


.. _valid-array.new_default:

:math:`\ARRAYNEWDEFAULT~x`
..........................

* The :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]` must exist.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CTYPES[x]` must be an :ref:`array type <syntax-arraytype>` :math:`\TARRAY~\fieldtype`.

* Let :math:`\fieldtype` be :math:`\mut~\storagetype`.

* Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`\unpack(\storagetype)`.

* The type :math:`t` must be defaultable.

* Then the instruction is valid with type :math:`[\I32] \to [(\REF~x)]`.

$${rule: Instr_ok/array.new_default}


.. _valid-array.new_fixed:

:math:`\ARRAYNEWFIXED~x~n`
..........................

* The :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]` must exist.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CTYPES[x]` must be an :ref:`array type <syntax-arraytype>` :math:`\TARRAY~\fieldtype`.

* Let :math:`\fieldtype` be :math:`\mut~\storagetype`.

* Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`\unpack(\storagetype)`.

* Then the instruction is valid with type :math:`[t^n] \to [(\REF~x)]`.

$${rule: Instr_ok/array.new_fixed}


.. _valid-array.new_elem:

:math:`\ARRAYNEWELEM~x~y`
.........................

* The :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]` must exist.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CTYPES[x]` must be an :ref:`array type <syntax-arraytype>` :math:`\TARRAY~\fieldtype`.

* Let :math:`\fieldtype` be :math:`\mut~\storagetype`.

* The :ref:`storage type <syntax-storagetype>` :math:`\storagetype` must be a :ref:`reference type <syntax-valtype>` :math:`\X{rt}`.

* The :ref:`element segment <syntax-elem>` :math:`C.\CELEMS[y]` must exist.

* Let :math:`\X{rt}'` be the :ref:`reference type <syntax-reftype>` :math:`C.\CELEMS[y]`.

* The :ref:`reference type <syntax-reftype>` :math:`\X{rt}'` must :ref:`match <match-reftype>` :math:`\X{rt}`.

* Then the instruction is valid with type :math:`[\I32~\I32] \to [(\REF~x)]`.

$${rule: Instr_ok/array.new_elem}


.. _valid-array.new_data:

:math:`\ARRAYNEWDATA~x~y`
.........................

* The :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]` must exist.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CTYPES[x]` must be an :ref:`array type <syntax-arraytype>` :math:`\TARRAY~\fieldtype`.

* Let :math:`\fieldtype` be :math:`\mut~\storagetype`.

* Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`\unpack(\storagetype)`.

* The type :math:`t` must be a :ref:`numeric type <syntax-numtype>` or a :ref:`vector type <syntax-vectype>`.

* The :ref:`data segment <syntax-data>` :math:`C.\CDATAS[y]` must exist.

* Then the instruction is valid with type :math:`[\I32~\I32] \to [(\REF~x)]`.

$${rule: Instr_ok/array.new_data}


.. _valid-array.get:
.. _valid-array.get_u:
.. _valid-array.get_s:

:math:`\ARRAYGET\K{\_}\sx^?~x`
..............................

* The :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]` must exist.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CTYPES[x]` must be an :ref:`array type <syntax-arraytype>` :math:`\TARRAY~\fieldtype`.

* Let the :ref:`field type <syntax-fieldtype>` :math:`\mut~\storagetype` be :math:`\fieldtype`.

* Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`\unpack(\storagetype)`.

* The extension :math:`\sx` must be present if and only if :math:`\storagetype` is a :ref:`packed type <syntax-packtype>`.

* Then the instruction is valid with type :math:`[(\REF~\NULL~x)~\I32] \to [t]`.

$${rule: Instr_ok/array.get}


.. _valid-array.set:

:math:`\ARRAYSET~x`
...................

* The :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]` must exist.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CTYPES[x]` must be an :ref:`array type <syntax-arraytype>` :math:`\TARRAY~\fieldtype`.

* Let the :ref:`field type <syntax-fieldtype>` :math:`\mut~\storagetype` be :math:`\fieldtype`.

* The prefix :math:`\mut` must be :math:`\MVAR`.

* Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`\unpack(\storagetype)`.

* Then the instruction is valid with type :math:`[(\REF~\NULL~x)~\I32~t] \to []`.

$${rule: Instr_ok/array.set}


.. _valid-array.len:

:math:`\ARRAYLEN`
.................

* The the instruction is valid with type :math:`[(\REF~\NULL~\ARRAY)] \to [\I32]`.

$${rule: Instr_ok/array.len}


.. _valid-array.fill:

:math:`\ARRAYFILL~x`
....................

* The :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]` must exist.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CTYPES[x]` must be an :ref:`array type <syntax-arraytype>` :math:`\TARRAY~\fieldtype`.

* Let the :ref:`field type <syntax-fieldtype>` :math:`\mut~\storagetype` be :math:`\fieldtype`.

* The prefix :math:`\mut` must be :math:`\MVAR`.

* Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`\unpack(\storagetype)`.

* Then the instruction is valid with type :math:`[(\REF~\NULL~x)~\I32~t~\I32] \to []`.

$${rule: Instr_ok/array.fill}


.. _valid-array.copy:

:math:`\ARRAYCOPY~x~y`
......................

* The :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]` must exist.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CTYPES[x]` must be an :ref:`array type <syntax-arraytype>` :math:`\TARRAY~\fieldtype_1`.

* Let the :ref:`field type <syntax-fieldtype>` :math:`\mut_1~\storagetype_1` be :math:`\fieldtype_1`.

* The prefix :math:`\mut_1` must be :math:`\MVAR`.

* The :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[y]` must exist.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CTYPES[y]` must be an :ref:`array type <syntax-arraytype>` :math:`\TARRAY~\fieldtype_2`.

* Let the :ref:`field type <syntax-fieldtype>` :math:`\mut_2~\storagetype_2` be :math:`\fieldtype_2`.

* The :ref:`storage type <syntax-storagetype>` :math:`\storagetype_2` must :ref:`match <match-storagetype>` :math:`\storagetype_1`.

* Then the instruction is valid with type :math:`[(\REF~\NULL~x)~\I32~(\REF~\NULL~y)~\I32~\I32] \to []`.

$${rule: Instr_ok/array.copy}


.. _valid-array.init_elem:

:math:`\ARRAYINITELEM~x~y`
..........................

* The :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]` must exist.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CTYPES[x]` must be an :ref:`array type <syntax-arraytype>` :math:`\TARRAY~\fieldtype`.

* Let the :ref:`field type <syntax-fieldtype>` :math:`\mut~\storagetype` be :math:`\fieldtype`.

* The prefix :math:`\mut` must be :math:`\MVAR`.

* The :ref:`storage type <syntax-storagetype>` :math:`\storagetype` must be a :ref:`reference type <syntax-valtype>` :math:`\X{rt}`.

* The :ref:`element segment <syntax-elem>` :math:`C.\CELEMS[y]` must exist.

* Let :math:`\X{rt}'` be the :ref:`reference type <syntax-reftype>` :math:`C.\CELEMS[y]`.

* The :ref:`reference type <syntax-reftype>` :math:`\X{rt}'` must :ref:`match <match-reftype>` :math:`\X{rt}`.

* Then the instruction is valid with type :math:`[(\REF~\NULL~x)~\I32~\I32~\I32] \to []`.

$${rule: Instr_ok/array.init_elem}


.. _valid-array.init_data:

:math:`\ARRAYINITDATA~x~y`
..........................

* The :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]` must exist.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CTYPES[x]` must be an :ref:`array type <syntax-arraytype>` :math:`\TARRAY~\fieldtype`.

* Let the :ref:`field type <syntax-fieldtype>` :math:`\mut~\storagetype` be :math:`\fieldtype`.

* The prefix :math:`\mut` must be :math:`\MVAR`.

* Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`\unpack(\storagetype)`.

* The :ref:`value type <syntax-valtype>` :math:`t` must be a :ref:`numeric type <syntax-numtype>` or a :ref:`vector type <syntax-vectype>`.

* The :ref:`data segment <syntax-data>` :math:`C.\CDATAS[y]` must exist.

* Then the instruction is valid with type :math:`[(\REF~\NULL~x)~\I32~\I32~\I32] \to []`.

$${rule: Instr_ok/array.init_data}


.. index:: scalar reference

Scalar Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-ref.i31:

:math:`\REFI31`
...............

* The instruction is valid with type :math:`[\I32] \to [(\REF~\I31)]`.

$${rule: Instr_ok/ref.i31}


.. _valid-i31.get_sx:

:math:`\I31GET\K{\_}\sx`
........................

* The instruction is valid with type :math:`[(\REF~\NULL~\I31)] \to [\I32]`.

$${rule: Instr_ok/i31.get}



.. index:: external reference

External Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _valid-any.convert_extern:

:math:`\ANYCONVERTEXTERN`
.........................

* The instruction is valid with type :math:`[(\REF~\NULL_1^?~\EXTERN)] \to [(\REF~\NULL_2^?~\ANY)]` for any :math:`\NULL_1^?` that equals :math:`\NULL_2^?`.

$${rule: Instr_ok/any.convert_extern}


.. _valid-extern.convert_any:

:math:`\EXTERNCONVERTANY`
.........................

* The instruction is valid with type :math:`[(\REF~\NULL_1^?~\ANY)] \to [(\REF~\NULL_2^?~\EXTERN)]` for any :math:`\NULL_1^?` that equals :math:`\NULL_2^?`.

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

* The instruction is valid with type :math:`[] \to [\V128]`.

$${rule: Instr_ok/vconst}


.. _valid-vvunop:

:math:`\V128\K{.}\vvunop`
.........................

* The instruction is valid with type :math:`[\V128] \to [\V128]`.

$${rule: Instr_ok/vvunop}


.. _valid-vvbinop:

:math:`\V128\K{.}\vvbinop`
..........................

* The instruction is valid with type :math:`[\V128~\V128] \to [\V128]`.


.. _valid-vvternop:

:math:`\V128\K{.}\vvternop`
...........................

* The instruction is valid with type :math:`[\V128~\V128~\V128] \to [\V128]`.

$${rule: Instr_ok/vvternop}


.. _valid-vvtestop:

:math:`\V128\K{.}\vvtestop`
...........................

* The instruction is valid with type :math:`[\V128] \to [\I32]`.

$${rule: Instr_ok/vvtestop}




.. _valid-vunop:

:math:`\shape\K{.}\vunop`
.........................

* The instruction is valid with type :math:`[\V128] \to [\V128]`.

$${rule: Instr_ok/vunop}


.. _valid-vbinop:

:math:`\shape\K{.}\vbinop`
..........................

* The instruction is valid with type :math:`[\V128~\V128] \to [\V128]`.

$${rule: Instr_ok/vbinop}


.. _valid-vtestop:

:math:`\shape\K{.}\vtestop`
...........................

* The instruction is valid with type :math:`[\V128] \to [\I32]`.

$${rule: Instr_ok/vtestop}


.. _valid-vrelop:

:math:`\shape\K{.}\vrelop`
..........................

* The instruction is valid with type :math:`[\V128~\V128] \to [\V128]`.

$${rule: Instr_ok/vrelop}


.. _valid-vshiftop:

:math:`\ishape\K{.}\vishiftop`
..............................

* The instruction is valid with type :math:`[\V128~\I32] \to [\V128]`.

$${rule: Instr_ok/vshiftop}


.. _valid-vbitmask:

:math:`\ishape\K{.}\VBITMASK`
.............................

* The instruction is valid with type :math:`[\V128] \to [\I32]`.

$${rule: Instr_ok/vbitmask}


.. _valid-vswizzle:

:math:`\K{i8x16.}\VSWIZZLE`
...........................

* The instruction is valid with type :math:`[\V128~\V128] \to [\V128]`.

$${rule: Instr_ok/vswizzle}


.. _valid-vshuffle:

:math:`\K{i8x16.}\VSHUFFLE~\laneidx^{16}`
.........................................

* For all :math:`\laneidx_i`, in :math:`\laneidx^{16}`, :math:`\laneidx_i` must be smaller than :math:`32`.

* The instruction is valid with type :math:`[\V128~\V128] \to [\V128]`.

$${rule: Instr_ok/vshuffle}


.. _valid-vsplat:

:math:`\shape\K{.}\VSPLAT`
..........................

* Let :math:`t` be :math:`\unpackshape(\shape)`.

* The instruction is valid with type :math:`[t] \to [\V128]`.

$${rule: Instr_ok/vsplat}


.. _valid-vextract_lane:

:math:`\shape\K{.}\VEXTRACTLANE\K{\_}\sx^?~\laneidx`
....................................................

* The lane index :math:`\laneidx` must be smaller than :math:`\shdim(\shape)`.

* Let :math:`t` be :math:`\unpackshape(\shape)`.

* The instruction is valid with type :math:`[\V128] \to [t]`.

$${rule: Instr_ok/vextract_lane}


.. _valid-vreplace_lane:

:math:`\shape\K{.}\VREPLACELANE~\laneidx`
.........................................

* The lane index :math:`\laneidx` must be smaller than :math:`\shdim(\shape)`.

* Let :math:`t` be :math:`\unpackshape(\shape)`.

* The instruction is valid with type :math:`[\V128~t] \to [\V128]`.

$${rule: Instr_ok/vreplace_lane}


.. _valid-vextunop:

:math:`\ishape_1\K{.}\VEXTADDPAIRWISE\K{\_}\ishape_2\K{\_}\sx`
..............................................................

* The instruction is valid with type :math:`[\V128] \to [\V128]`.

$${rule: Instr_ok/vextunop}


.. _valid-vextbinop:

:math:`\ishape_1\K{.}\VEXTMUL\K{\_}\half\K{\_}\ishape_2\K{\_}\sx`
.................................................................

* The instruction is valid with type :math:`[\V128~\V128] \to [\V128]`.

$${rule: Instr_ok/vextbinop}


.. _valid-vnarrow:

:math:`\ishape_1\K{.}\VNARROW\K{\_}\ishape_2\K{\_}\sx`
......................................................

* The instruction is valid with type :math:`[\V128~\V128] \to [\V128]`.

$${rule: Instr_ok/vnarrow}


.. _valid-vcvtop:

:math:`\shape\K{.}\vcvtop\K{\_}\half^?\K{\_}\shape\K{\_}\sx^?\K{\_zero}^?`
..........................................................................

* The instruction is valid with type :math:`[\V128] \to [\V128]`.

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

* The local :math:`C.\CLOCALS[x]` must be defined in the context.

* Let :math:`\init~t` be the :ref:`local type <syntax-localtype>` :math:`C.\CLOCALS[x]`.

* The :ref:`initialization status <syntax-init>` :math:`\init` must be :math:`\SET`.

* Then the instruction is valid with type :math:`[] \to [t]`.

$${rule: Instr_ok/local.get}


.. _valid-local.set:

:math:`\LOCALSET~x`
...................

* The local :math:`C.\CLOCALS[x]` must be defined in the context.

* Let :math:`\init~t` be the :ref:`local type <syntax-localtype>` :math:`C.\CLOCALS[x]`.

* Then the instruction is valid with type :math:`[t] \to_{x} []`.

$${rule: Instr_ok/local.set}


.. _valid-local.tee:

:math:`\LOCALTEE~x`
...................

* The local :math:`C.\CLOCALS[x]` must be defined in the context.

* Let :math:`\init~t` be the :ref:`local type <syntax-localtype>` :math:`C.\CLOCALS[x]`.

* Then the instruction is valid with type :math:`[t] \to_{x} [t]`.

$${rule: Instr_ok/local.tee}


.. _valid-global.get:

:math:`\GLOBALGET~x`
....................

* The global :math:`C.\CGLOBALS[x]` must be defined in the context.

* Let :math:`\mut~t` be the :ref:`global type <syntax-globaltype>` :math:`C.\CGLOBALS[x]`.

* Then the instruction is valid with type :math:`[] \to [t]`.

$${rule: Instr_ok/global.get}


.. _valid-global.set:

:math:`\GLOBALSET~x`
....................

* The global :math:`C.\CGLOBALS[x]` must be defined in the context.

* Let :math:`\mut~t` be the :ref:`global type <syntax-globaltype>` :math:`C.\CGLOBALS[x]`.

* The mutability :math:`\mut` must be |MVAR|.

* Then the instruction is valid with type :math:`[t] \to []`.

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

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Let :math:`\limits~t` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[x]`.

* Then the instruction is valid with type :math:`[\I32] \to [t]`.

$${rule: Instr_ok/table.get}


.. _valid-table.set:

:math:`\TABLESET~x`
...................

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Let :math:`\limits~t` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[x]`.

* Then the instruction is valid with type :math:`[\I32~t] \to []`.

$${rule: Instr_ok/table.set}


.. _valid-table.size:

:math:`\TABLESIZE~x`
....................

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Then the instruction is valid with type :math:`[] \to [\I32]`.

$${rule: Instr_ok/table.size}


.. _valid-table.grow:

:math:`\TABLEGROW~x`
....................

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Let :math:`\limits~t` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[x]`.

* Then the instruction is valid with type :math:`[t~\I32] \to [\I32]`.

$${rule: Instr_ok/table.grow}


.. _valid-table.fill:

:math:`\TABLEFILL~x`
....................

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Let :math:`\limits~t` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[x]`.

* Then the instruction is valid with type :math:`[\I32~t~\I32] \to []`.

$${rule: Instr_ok/table.fill}


.. _valid-table.copy:

:math:`\TABLECOPY~x~y`
......................

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Let :math:`\limits_1~t_1` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[x]`.

* The table :math:`C.\CTABLES[y]` must be defined in the context.

* Let :math:`\limits_2~t_2` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[y]`.

* The :ref:`reference type <syntax-reftype>` :math:`t_2` must :ref:`match <match-reftype>` :math:`t_1`.

* Then the instruction is valid with type :math:`[\I32~\I32~\I32] \to []`.

$${rule: Instr_ok/table.copy}


.. _valid-table.init:

:math:`\TABLEINIT~x~y`
......................

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Let :math:`\limits~t_1` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[x]`.

* The element segment :math:`C.\CELEMS[y]` must be defined in the context.

* Let :math:`t_2` be the :ref:`reference type <syntax-reftype>` :math:`C.\CELEMS[y]`.

* The :ref:`reference type <syntax-reftype>` :math:`t_2` must :ref:`match <match-reftype>` :math:`t_1`.

* Then the instruction is valid with type :math:`[\I32~\I32~\I32] \to []`.

$${rule: Instr_ok/table.init}


.. _valid-elem.drop:

:math:`\ELEMDROP~x`
...................

* The element segment :math:`C.\CELEMS[x]` must be defined in the context.

* Then the instruction is valid with type :math:`[] \to []`.

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

* The memory :math:`C.\CMEMS[x]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than the :ref:`bit width <syntax-numtype>` of :math:`t` divided by :math:`8`.

* Then the instruction is valid with type :math:`[\I32] \to [t]`.

$${rule: Instr_ok/load-val}


.. _valid-load-pack:

:math:`t\K{.}\LOAD{N}\K{\_}\sx~x~\memarg`
.........................................

* The memory :math:`C.\CMEMS[x]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than :math:`N/8`.

* Then the instruction is valid with type :math:`[\I32] \to [t]`.

$${rule: Instr_ok/load-pack}


.. _valid-store-val:

:math:`t\K{.}\STORE~x~\memarg`
..............................

* The memory :math:`C.\CMEMS[x]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than the :ref:`bit width <syntax-numtype>` of :math:`t` divided by :math:`8`.

* Then the instruction is valid with type :math:`[\I32~t] \to []`.

$${rule: Instr_ok/store-val}


.. _valid-store-pack:

:math:`t\K{.}\STORE{N}~x~\memarg`
.................................

* The memory :math:`C.\CMEMS[x]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than :math:`N/8`.

* Then the instruction is valid with type :math:`[\I32~t] \to []`.

$${rule: Instr_ok/store-pack}


.. _valid-vload-val:

:math:`\K{v128.}\K{.}\LOAD~x~\memarg`
.....................................

* The memory :math:`C.\CMEMS[x]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than the :ref:`bit width <syntax-numtype>` of :math:`t` divided by :math:`8`.

* Then the instruction is valid with type :math:`[\I32] \to [t]`.

$${rule: Instr_ok/vload-val}


.. _valid-vload-pack:

:math:`\K{v128.}\LOAD{N}\K{x}M\_\sx~x~\memarg`
..............................................

* The memory :math:`C.\CMEMS[x]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than :math:`N/8 \cdot M`.

* Then the instruction is valid with type :math:`[\I32] \to [\V128]`.

$${rule: Instr_ok/vload-pack}


.. _valid-vload-splat:

:math:`\K{v128.}\LOAD{N}\K{\_splat}~x~\memarg`
..............................................

* The memory :math:`C.\CMEMS[x]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than :math:`N/8`.

* Then the instruction is valid with type :math:`[\I32] \to [\V128]`.

$${rule: Instr_ok/vload-splat}


.. _valid-vload-zero:

:math:`\K{v128.}\LOAD{N}\K{\_zero}~x~\memarg`
.............................................

* The memory :math:`C.\CMEMS[x]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than :math:`N/8`.

* Then the instruction is valid with type :math:`[\I32] \to [\V128]`.

$${rule: Instr_ok/vload-zero}


.. _valid-vload_lane:

:math:`\K{v128.}\LOAD{N}\K{\_lane}~x~\memarg~\laneidx`
......................................................

* The memory :math:`C.\CMEMS[x]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than :math:`N/8`.

* The lane index :math:`\laneidx` must be smaller than :math:`128/N`.

* Then the instruction is valid with type :math:`[\I32~\V128] \to [\V128]`.

$${rule: Instr_ok/vload_lane}


.. _valid-vstore:

:math:`\K{v128.}\STORE~x~\memarg`
.................................

* The memory :math:`C.\CMEMS[x]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than the :ref:`bit width <syntax-numtype>` of :math:`t` divided by :math:`8`.

* Then the instruction is valid with type :math:`[\I32~t] \to []`.

$${rule: Instr_ok/vstore}


.. _valid-vstore_lane:

:math:`\K{v128.}\STORE{N}\K{\_lane}~x~\memarg~\laneidx`
.......................................................

* The memory :math:`C.\CMEMS[x]` must be defined in the context.

* The alignment :math:`2^{\memarg.\ALIGN}` must not be larger than :math:`N/8`.

* The lane index :math:`\laneidx` must be smaller than :math:`128/N`.

* Then the instruction is valid with type :math:`[\I32~\V128] \to [\V128]`.

$${rule: Instr_ok/vstore_lane}


.. _valid-memory.size:

:math:`\MEMORYSIZE~x`
.....................

* The memory :math:`C.\CMEMS[x]` must be defined in the context.

* Then the instruction is valid with type :math:`[] \to [\I32]`.

$${rule: Instr_ok/memory.size}


.. _valid-memory.grow:

:math:`\MEMORYGROW~x`
.....................

* The memory :math:`C.\CMEMS[x]` must be defined in the context.

* Then the instruction is valid with type :math:`[\I32] \to [\I32]`.

$${rule: Instr_ok/memory.grow}


.. _valid-memory.fill:

:math:`\MEMORYFILL~x`
.....................

* The memory :math:`C.\CMEMS[x]` must be defined in the context.

* Then the instruction is valid with type :math:`[\I32~\I32~\I32] \to []`.

$${rule: Instr_ok/memory.fill}


.. _valid-memory.copy:

:math:`\MEMORYCOPY~x~y`
.......................

* The memory :math:`C.\CMEMS[x]` must be defined in the context.

* The memory :math:`C.\CMEMS[y]` must be defined in the context.

* Then the instruction is valid with type :math:`[\I32~\I32~\I32] \to []`.

$${rule: Instr_ok/memory.copy}


.. _valid-memory.init:

:math:`\MEMORYINIT~x~y`
.......................

* The memory :math:`C.\CMEMS[x]` must be defined in the context.

* The data segment :math:`C.\CDATAS[y]` must be defined in the context.

* Then the instruction is valid with type :math:`[\I32~\I32~\I32] \to []`.

$${rule: Instr_ok/memory.init}


.. _valid-data.drop:

:math:`\DATADROP~x`
...................

* The data segment :math:`C.\CDATAS[x]` must be defined in the context.

* Then the instruction is valid with type :math:`[] \to []`.

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

* The :ref:`block type <syntax-blocktype>` must be :ref:`valid <valid-blocktype>` as some :ref:`instruction type <syntax-instrtype>` :math:`[t_1^\ast] \to [t_2^\ast]`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`result type <syntax-resulttype>` :math:`[t_2^\ast]` prepended to the |CLABELS| list.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instrs>` with type :math:`[t_1^\ast] \to [t_2^\ast]`.

* Then the compound instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`.

$${rule: Instr_ok/block}

.. note::
   The :ref:`notation <notation-concat>` ${context: {LABELS (t*)} ++ C} inserts the new label type at index ${:0}, shifting all others.
   The same applies to all other block instructions.


.. _valid-loop:

:math:`\LOOP~\blocktype~\instr^\ast~\END`
.........................................

* The :ref:`block type <syntax-blocktype>` must be :ref:`valid <valid-blocktype>` as some :ref:`instruction type <syntax-functype>` :math:`[t_1^\ast] \to_{x^\ast} [t_2^\ast]`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`result type <syntax-resulttype>` :math:`[t_1^\ast]` prepended to the |CLABELS| list.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instrs>` with type :math:`[t_1^\ast] \to [t_2^\ast]`.

* Then the compound instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`.

$${rule: Instr_ok/loop}


.. _valid-if:

:math:`\IF~\blocktype~\instr_1^\ast~\ELSE~\instr_2^\ast~\END`
.............................................................

* The :ref:`block type <syntax-blocktype>` must be :ref:`valid <valid-blocktype>` as some :ref:`instruction type <syntax-instrtype>` :math:`[t_1^\ast] \to [t_2^\ast]`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`result type <syntax-resulttype>` :math:`[t_2^\ast]` prepended to the |CLABELS| list.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr_1^\ast` must be :ref:`valid <valid-instrs>` with type :math:`[t_1^\ast] \to [t_2^\ast]`.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr_2^\ast` must be :ref:`valid <valid-instrs>` with type :math:`[t_1^\ast] \to [t_2^\ast]`.

* Then the compound instruction is valid with type :math:`[t_1^\ast~\I32] \to [t_2^\ast]`.

$${rule: Instr_ok/if}



.. _valid-try_table:

:math:`\TRYTABLE~\blocktype~\catch^\ast~\instr^\ast~\END`
.........................................................

* The :ref:`block type <syntax-blocktype>` must be :ref:`valid <valid-blocktype>` as some :ref:`function type <syntax-functype>` :math:`[t_1^\ast] \to [t_2^\ast]`.

* For every :ref:`catch clause <syntax-catch>` :math:`\catch_i` in :math:`\catch^\ast`, :math:`\catch_i` must be :ref:`valid <valid-catch>`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`result type <syntax-resulttype>` :math:`[t_2^\ast]` prepended to the |CLABELS| vector.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instrs>` with type :math:`[t_1^\ast] \to [t_2^\ast]`.

* Then the compound instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`.


.. _valid-catch:

:math:`\CATCH~x~l`
..................

* The tag :math:`C.\CTAGS[x]` must be defined in the context.

* Let :math:`[t^\ast] \to [{t'}^\ast]` be the :ref:`tag type <syntax-tagtype>` :math:`C.\CTAGS[x]`.

* The :ref:`result type <syntax-resulttype>` :math:`[{t'}^\ast]` must be empty.

* The label :math:`C.\CLABELS[l]` must be defined in the context.

* The :ref:`result type <syntax-resulttype>` :math:`[t^\ast]` must :ref:`match <match-resulttype>` :math:`C.\CLABELS[l]`.

* Then the catch clause is valid.

$${rule: Catch_ok/catch}


:math:`\CATCHREF~x~l`
.....................

* The tag :math:`C.\CTAGS[x]` must be defined in the context.

* Let :math:`[t^\ast] \to [{t'}^\ast]` be the :ref:`tag type <syntax-tagtype>` :math:`C.\CTAGS[x]`.

* The :ref:`result type <syntax-resulttype>` :math:`[{t'}^\ast]` must be empty.

* The label :math:`C.\CLABELS[l]` must be defined in the context.

* The :ref:`result type <syntax-resulttype>` :math:`[t^\ast (REF EXN)]` must :ref:`match <match-resulttype>` :math:`C.\CLABELS[l]`.

* Then the catch clause is valid.

$${rule: Catch_ok/catch_ref}


:math:`\CATCHALL~l`
...................

* The label :math:`C.\CLABELS[l]` must be defined in the context.

* The :ref:`result type <syntax-resulttype>` :math:`C.\CLABELS[l]` must be empty.

* Then the catch clause is valid.

$${rule: Catch_ok/catch_all}


:math:`\CATCHALLREF~l`
......................

* The label :math:`C.\CLABELS[l]` must be defined in the context.

* The :ref:`result type <syntax-resulttype>` :math:`[(REF EXN)]` must :ref:`match <match-resulttype>` :math:`C.\CLABELS[l]`.

* Then the catch clause is valid.

$${rule: Catch_ok/catch_all_ref}



.. _valid-br:

:math:`\BR~l`
.............

* The label :math:`C.\CLABELS[l]` must be defined in the context.

* Let :math:`[t^\ast]` be the :ref:`result type <syntax-resulttype>` :math:`C.\CLABELS[l]`.

* Then the instruction is valid with any :ref:`valid <valid-instrtype>` type of the form :math:`[t_1^\ast~t^\ast] \to [t_2^\ast]`.

$${rule: Instr_ok/br}

.. note::
   The :ref:`label index <syntax-labelidx>` space in the :ref:`context <context>` ${:C} contains the most recent label first, so that ${:C.LABELS[l]} performs a relative lookup as expected.
   This applies to other branch instructions as well.

   The ${:BR} instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-br_if:

:math:`\BRIF~l`
...............

* The label :math:`C.\CLABELS[l]` must be defined in the context.

* Let :math:`[t^\ast]` be the :ref:`result type <syntax-resulttype>` :math:`C.\CLABELS[l]`.

* Then the instruction is valid with type :math:`[t^\ast~\I32] \to [t^\ast]`.

$${rule: Instr_ok/br_if}


.. _valid-br_table:

:math:`\BRTABLE~l^\ast~l_N`
...........................

* The :ref:`label <syntax-label>` :math:`C.\CLABELS[l_N]` must be defined in the context.

* For each :ref:`label <syntax-label>` :math:`l_i` in :math:`l^\ast`,
  the label :math:`C.\CLABELS[l_i]` must be defined in the context.

* There must be a sequence :math:`t^\ast` of :ref:`value types <syntax-valtype>`, such that:

  * The result type :math:`[t^\ast]` :ref:`matches <match-resulttype>` :math:`C.\CLABELS[l_N]`.

  * For all :math:`l_i` in :math:`l^\ast`,
    the result type :math:`[t^\ast]` :ref:`matches <match-resulttype>` :math:`C.\CLABELS[l_i]`.

* Then the instruction is valid with any :ref:`valid <valid-instrtype>` type of the form :math:`[t_1^\ast~t^\ast~\I32] \to [t_2^\ast]`.

$${rule: Instr_ok/br_table}

.. note::
   The ${:BR_TABLE} instruction is :ref:`stack-polymorphic <polymorphism>`.

   Furthermore, the :ref:`result type <syntax-resulttype>` ${:t*} is also chosen non-deterministically in this rule.
   Although it may seem necessary to compute ${:t*} as the greatest lower bound of all label types in practice,
   a simple :ref:`linear algorithm <algo-valid>` does not require this.


.. _valid-br_on_null:

:math:`\BRONNULL~l`
...................

* The label :math:`C.\CLABELS[l]` must be defined in the context.

* Let :math:`[t^\ast]` be the :ref:`result type <syntax-resulttype>` :math:`C.\CLABELS[l]`.

* Then the instruction is valid with type :math:`[t^\ast~(\REF~\NULL~\X{ht})] \to [t^\ast~(\REF~\X{ht})]` for any :ref:`valid <valid-heaptype>` :ref:`heap type <syntax-heaptype>` :math:`\X{ht}`.

$${rule: Instr_ok/br_on_null}


.. _valid-br_on_non_null:

:math:`\BRONNONNULL~l`
......................

* The label :math:`C.\CLABELS[l]` must be defined in the context.

* Let :math:`[{t'}^\ast]` be the :ref:`result type <syntax-resulttype>` :math:`C.\CLABELS[l]`.

* The result type :math:`[{t'}^\ast]` must contain at least one type.

* Let the :ref:`value type <syntax-valtype>` :math:`t_l` be the last element in the sequence :math:`{t'}^\ast`, and :math:`[t^\ast]` the remainder of the sequence preceding it.

* The value type :math:`t_l` must be a reference type of the form :math:`\REF~\NULL^?~\X{ht}`.

* Then the instruction is valid with type :math:`[t^\ast~(\REF~\NULL~\X{ht})] \to [t^\ast]`.

$${rule: Instr_ok/br_on_non_null}


.. _valid-br_on_cast:

:math:`\BRONCAST~l~\X{rt}_1~\X{rt}_2`
.....................................

* The label :math:`C.\CLABELS[l]` must be defined in the context.

* Let :math:`[t_l^\ast]` be the :ref:`result type <syntax-resulttype>` :math:`C.\CLABELS[l]`.

* The type sequence :math:`t_l^\ast` must be of the form :math:`t^\ast~\X{rt}'`.

* The :ref:`reference type <syntax-reftype>` :math:`\X{rt}_1` must be :ref:`valid <valid-reftype>`.

* The :ref:`reference type <syntax-reftype>` :math:`\X{rt}_2` must be :ref:`valid <valid-reftype>`.

* The :ref:`reference type <syntax-reftype>` :math:`\X{rt}_2` must :ref:`match <match-reftype>` :math:`\X{rt}_1`.

* The :ref:`reference type <syntax-reftype>` :math:`\X{rt}_2` must :ref:`match <match-reftype>` :math:`\X{rt}'`.

* Let :math:`\X{rt}'_1` be the :ref:`type difference <aux-reftypediff>` between :math:`\X{rt}_1` and :math:`\X{rt}_2`.

* Then the instruction is valid with type :math:`[t^\ast~\X{rt}_1] \to [t^\ast~\X{rt}'_1]`.

$${rule: Instr_ok/br_on_cast}


.. _valid-br_on_cast_fail:

:math:`\BRONCASTFAIL~l~\X{rt}_1~\X{rt}_2`
.........................................

* The label :math:`C.\CLABELS[l]` must be defined in the context.

* Let :math:`[t_l^\ast]` be the :ref:`result type <syntax-resulttype>` :math:`C.\CLABELS[l]`.

* The type sequence :math:`t_l^\ast` must be of the form :math:`t^\ast~\X{rt}'`.

* The :ref:`reference type <syntax-reftype>` :math:`\X{rt}_1` must be :ref:`valid <valid-reftype>`.

* The :ref:`reference type <syntax-reftype>` :math:`\X{rt}_2` must be :ref:`valid <valid-reftype>`.

* The :ref:`reference type <syntax-reftype>` :math:`\X{rt}_2` must :ref:`match <match-reftype>` :math:`\X{rt}_1`.

* Let :math:`\X{rt}'_1` be the :ref:`type difference <aux-reftypediff>` between :math:`\X{rt}_1` and :math:`\X{rt}_2`.

* The :ref:`reference type <syntax-reftype>` :math:`\X{rt}'_1` must :ref:`match <match-reftype>` :math:`\X{rt}'`.

* Then the instruction is valid with type :math:`[t^\ast~\X{rt}_1] \to [t^\ast~\X{rt}_2]`.

$${rule: Instr_ok/br_on_cast_fail}


.. _valid-call:

:math:`\CALL~x`
...............

* The function :math:`C.\CFUNCS[x]` must be defined in the context.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CFUNCS[x]` must be a :ref:`function type <syntax-functype>` :math:`\TFUNC~[t_1^\ast] \toF [t_2^\ast]`.

* Then the instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`.

$${rule: Instr_ok/call}


.. _valid-call_ref:

:math:`\CALLREF~x`
..................

* The type :math:`C.\CTYPES[x]` must be defined in the context.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CFUNCS[x]` must be a :ref:`function type <syntax-functype>` :math:`\TFUNC~[t_1^\ast] \toF [t_2^\ast]`.

* Then the instruction is valid with type :math:`[t_1^\ast~(\REF~\NULL~x)] \to [t_2^\ast]`.

$${rule: Instr_ok/call_ref}


.. _valid-call_indirect:

:math:`\CALLINDIRECT~x~y`
.........................

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Let :math:`\limits~t` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[x]`.

* The :ref:`reference type <syntax-reftype>` :math:`t` must :ref:`match <match-reftype>` type :math:`\REF~\NULL~\FUNC`.

* The type :math:`C.\CTYPES[y]` must be defined in the context.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CTYPES[y]` must be a :ref:`function type <syntax-functype>` :math:`\TFUNC~[t_1^\ast] \toF [t_2^\ast]`.

* Then the instruction is valid with type :math:`[t_1^\ast~\I32] \to [t_2^\ast]`.

$${rule: Instr_ok/call_indirect}


.. _valid-return:

:math:`\RETURN`
...............

* The return type :math:`C.\CRETURN` must not be absent in the context.

* Let :math:`[t^\ast]` be the :ref:`result type <syntax-resulttype>` of :math:`C.\CRETURN`.

* Then the instruction is valid with any :ref:`valid <valid-instrtype>` type of the form :math:`[t_1^\ast] \to [t_2^\ast]`.

$${rule: Instr_ok/return}

.. note::
   The ${:RETURN} instruction is :ref:`stack-polymorphic <polymorphism>`.

   ${resulttype?: C.RETURN} is absent (set to ${:eps}) when validating an :ref:`expression <valid-expr>` that is not a function body.
   This differs from it being set to the empty result type ${:(eps)},
   which is the case for functions not returning anything.


.. _valid-return_call:

:math:`\RETURNCALL~x`
.....................

* The return type :math:`C.\CRETURN` must not be absent in the context.

* The function :math:`C.\CFUNCS[x]` must be defined in the context.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CFUNCS[x]` must be a :ref:`function type <syntax-functype>` :math:`\TFUNC~[t_1^\ast] \toF [t_2^\ast]`.

* The :ref:`result type <syntax-resulttype>` :math:`[t_2^\ast]` must :ref:`match <match-resulttype>` :math:`C.\CRETURN`.

* Then the instruction is valid with any :ref:`valid <valid-instrtype>` type :math:`[t_3^\ast~t_1^\ast] \to [t_4^\ast]`.

$${rule: Instr_ok/return_call}

.. note::
   The ${:RETURN_CALL} instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-return_call_ref:

:math:`\RETURNCALLREF~x`
........................

* The type :math:`C.\CTYPES[x]` must be defined in the context.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CTYPES[x]` must be a :ref:`function type <syntax-functype>` :math:`\TFUNC~[t_1^\ast] \toF [t_2^\ast]`.

* The :ref:`result type <syntax-resulttype>` :math:`[t_2^\ast]` must :ref:`match <match-resulttype>` :math:`C.\CRETURN`.

* Then the instruction is valid with any :ref:`valid <valid-instrtype>` type :math:`[t_3^\ast~t_1^\ast~(\REF~\NULL~x)] \to [t_4^\ast]`.

$${rule: Instr_ok/return_call_ref}

.. note::
   The ${:RETURN_CALL_REF} instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-return_call_indirect:

:math:`\RETURNCALLINDIRECT~x~y`
...............................

* The return type :math:`C.\CRETURN` must not be empty in the context.

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Let :math:`\limits~t` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[x]`.

* The :ref:`reference type <syntax-reftype>` :math:`t` must :ref:`match <match-reftype>` type :math:`\REF~\NULL~\FUNC`.

* The type :math:`C.\CTYPES[y]` must be defined in the context.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CTYPES[y]` must be a :ref:`function type <syntax-functype>` :math:`\TFUNC~[t_1^\ast] \toF [t_2^\ast]`.

* The :ref:`result type <syntax-resulttype>` :math:`[t_2^\ast]` must :ref:`match <match-resulttype>` :math:`C.\CRETURN`.

* Then the instruction is valid with type :math:`[t_3^\ast~t_1^\ast~\I32] \to [t_4^\ast]`, for any sequences of :ref:`value types <syntax-valtype>` :math:`t_3^\ast` and :math:`t_4^\ast`.

$${rule: Instr_ok/return_call_indirect}

.. note::
   The ${:RETURN_CALL_INDIRECT} instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-throw:

:math:`\THROW~x`
................

* The tag :math:`C.\CTAGS[x]` must be defined in the context.

* Let :math:`[t^\ast] \to [{t'}^\ast]` be the :ref:`tag type <syntax-tagtype>` :math:`C.\CTAGS[x]`.

* The :ref:`result type <syntax-resulttype>` :math:`[{t'}^\ast]` must be empty.

* Then the instruction is valid with type :math:`[t_1^\ast t^\ast] \to [t_2^\ast]`, for any sequences of  :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.

$${rule: Instr_ok/throw}

.. note::
   The ${:THROW} instruction is :ref:`stack-polymorphic <polymorphism>`.


.. _valid-throw_ref:

:math:`\THROWREF`
.................

* The instruction is valid with type :math:`[t_1^\ast~\EXNREF] \to [t_2^\ast]`, for any sequences of  :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.

$${rule: Instr_ok/throw}

.. note::
   The ${:THROW_REF} instruction is :ref:`stack-polymorphic <polymorphism>`.


.. index:: instruction, instruction sequence, local type
.. _valid-instrs:

Instruction Sequences
~~~~~~~~~~~~~~~~~~~~~

Typing of instruction sequences is defined recursively.


Empty Instruction Sequence: :math:`\epsilon`
............................................

* The empty instruction sequence is valid with type :math:`[] \to []`.

$${rule: Instrs_ok/empty}


Non-empty Instruction Sequence: :math:`\instr~{\instr'}^\ast`
.............................................................

* The instruction :math:`\instr` must be valid with some type :math:`[t_1^\ast] \to_{x_1^\ast} [t_2^\ast]`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`,
  but with:

  * |CLOCALS| the same as in C, except that for every :ref:`local index <syntax-localidx>` :math:`x` in :math:`x_1^\ast`, the :ref:`local type <syntax-localtype>` :math:`\CLOCALS[x]` has been updated to :ref:`initialization status <syntax-init>` :math:`\SET`.

* Under the context :math:`C'`, the instruction sequence :math:`{\instr'}^\ast` must be valid with some type :math:`[t_2^\ast] \to_{x_2^\ast} [t_3^\ast]`.

* Then the combined instruction sequence is valid with type :math:`[t_1^\ast] \to_{x_1^\ast x_2^\ast} [t_3^\ast]`.

$${rule: Instrs_ok/seq}


Subsumption for :math:`\instr^\ast`
...................................

* The instruction sequence :math:`\instr^\ast` must be valid with some type :math:`\instrtype`.

* The instruction type :math:`\instrtype'`: must be a :ref:`valid <valid-instrtype>`

* The instruction type :math:`\instrtype` must :ref:`match <match-instrtype>` the type :math:`\instrtype'`.

* Then the instruction sequence :math:`\instr^\ast` is also valid with type :math:`\instrtype'`.

$${rule: Instrs_ok/sub Instrs_ok/frame}

.. note::
   In combination with the previous rule,
   subsumption allows to compose instructions whose types would not directly fit otherwise.
   For example, consider the instruction sequence

   $${: (CONST I31 1) (CONST I32 2) $($(BINOP I32 ADD))}

   .. math::
      (\I32.\CONST~1)~(\I32.\CONST~2)~\I32.\ADD

   To type this sequence, its subsequence ${:(CONST I32 2) $($(BINOP I32 ADD))} needs to be valid with an intermediate type.
   But the direct type of ${:(CONST I32 2)} is ${instrtype: eps -> I32}, not matching the two inputs expected by ${:BINOP I32 ADD}.
   The subsumption rule allows to weaken the type of ${:(CONST I32 2)} to the supertype ${instrtype: I32 -> I32 I32}, such that it can be composed with ${:ADD I32} and yields the intermediate type ${instrtype: I32 -> I32 I32} for the subsequence. That can in turn be composed with the first constant.

   Furthermore, subsumption allows to drop init variables ${:x*} from the instruction type in a context where they are not needed, for example, at the end of the body of a :ref:`block <valid-block>`.


.. index:: expression, result type
   pair: validation; expression
   single: abstract syntax; expression
   single: expression; constant
.. _valid-expr:

Expressions
~~~~~~~~~~~

Expressions ${:expr} are classified by :ref:`result types <syntax-resulttype>` ${:t*}.


:math:`\instr^\ast~\END`
........................

* The instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instrs>` with :ref:`type <syntax-instrtype>` :math:`[] \to [t^\ast]`.

* Then the expression is valid with :ref:`result type <syntax-resulttype>` :math:`[t^\ast]`.

$${rule: Expr_ok}


.. index:: ! constant
.. _valid-constant:

Constant Expressions
....................

* In a *constant* expression :math:`\instr^\ast~\END` all instructions in :math:`\instr^\ast` must be constant.

* A constant instruction :math:`\instr` must be:

  * either of the form :math:`t.\CONST~c`,

  * or of the form :math:`\K{i}\X{nn}\K{.}\ibinop`, where :math:`\ibinop` is limited to :math:`\ADD`, :math:`\SUB`, or :math:`\MUL`.

  * or of the form :math:`\REFNULL`,

  * or of the form :math:`\REFI31`,

  * or of the form :math:`\REFFUNC~x`,

  * or of the form :math:`\STRUCTNEW~x`,

  * or of the form :math:`\STRUCTNEWDEFAULT~x`,

  * or of the form :math:`\ARRAYNEW~x`,

  * or of the form :math:`\ARRAYNEWDEFAULT~x`,

  * or of the form :math:`\ARRAYNEWFIXED~x`,

  * or of the form :math:`\ANYCONVERTEXTERN`,

  * or of the form :math:`\EXTERNCONVERTANY`,

  * or of the form :math:`\GLOBALGET~x`, in which case :math:`C.\CGLOBALS[x]` must be a :ref:`global type <syntax-globaltype>` of the form :math:`\CONST~t`.

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

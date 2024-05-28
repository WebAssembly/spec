.. index:: ! matching, ! subtyping
.. _subtyping:
.. _match:

Matching
--------

On most types, a notion of *subtyping* is defined that is applicable in :ref:`validation <valid>` rules, during :ref:`module instantiation <exec-instantiation>` when checking the types of imports, or during :ref:`execution <exec>`, when performing casts.


.. index:: number type
.. _match-numtype:

Number Types
~~~~~~~~~~~~

A :ref:`number type <syntax-numtype>` ${:numtype_1} matches a :ref:`number type <syntax-numtype>` ${:numtype_2} if and only if:

* Both :math:`\numtype_1` and :math:`\numtype_2` are the same.

$${rule: Numtype_sub}


.. index:: vector type
.. _match-vectype:

Vector Types
~~~~~~~~~~~~

A :ref:`vector type <syntax-vectype>` ${:vectype_1} matches a :ref:`vector type <syntax-vectype>` ${:vectype_2} if and only if:

* Both :math:`\vectype_1` and :math:`\vectype_2` are the same.

$${rule: Vectype_sub}


.. index:: heap type, defined type, structure type, array type, function type, unboxed scalar type
.. _match-heaptype:

Heap Types
~~~~~~~~~~

A :ref:`heap type <syntax-heaptype>` ${:heaptype_1} matches a :ref:`heap type <syntax-heaptype>` ${:heaptype_2} if and only if:

* Either both :math:`\heaptype_1` and :math:`\heaptype_2` are the same.

* Or there exists a :ref:`valid <valid-heaptype>` :ref:`heap type <syntax-heaptype>` :math:`\heaptype'`, such that :math:`\heaptype_1` :ref:`matches <match-heaptype>` :math:`\heaptype'` and :math:`\heaptype'` :ref:`matches <match-heaptype>` :math:`\heaptype_2`.

* Or :math:`heaptype_1` is :math:`\EQT` and :math:`\heaptype_2` is :math:`\ANY`.

* Or :math:`\heaptype_1` is one of :math:`\I31`, :math:`\STRUCT`, or :math:`\ARRAY` and :math:`heaptype_2` is :math:`\EQT`.

* Or :math:`\heaptype_1` is a :ref:`defined type <syntax-deftype>` which :ref:`expands <aux-expand-deftype>` to a :ref:`structure type <syntax-structtype>` and :math:`\heaptype_2` is :math:`\STRUCT`.

* Or :math:`\heaptype_1` is a :ref:`defined type <syntax-deftype>` which :ref:`expands <aux-expand-deftype>` to an :ref:`array type <syntax-arraytype>` and :math:`\heaptype_2` is :math:`\ARRAY`.

* Or :math:`\heaptype_1` is a :ref:`defined type <syntax-deftype>` which :ref:`expands <aux-expand-deftype>` to a :ref:`function type <syntax-functype>` and :math:`\heaptype_2` is :math:`\FUNC`.

* Or :math:`\heaptype_1` is a :ref:`defined type <syntax-deftype>` :math:`\deftype_1` and :math:`\heaptype_2` is a :ref:`defined type <syntax-deftype>` :math:`\deftype_2`, and :math:`\deftype_1` :ref:`matches <match-deftype>` :math:`\deftype_2`.

* Or :math:`\heaptype_1` is a :ref:`type index <syntax-typeidx>` :math:`x_1`, and the :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x_1]` :ref:`matches <match-heaptype>` :math:`\heaptype_2`.

* Or :math:`\heaptype_2` is a :ref:`type index <syntax-typeidx>` :math:`x_2`, and :math:`\heaptype_1` :ref:`matches <match-heaptype>` the :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x_2]`.

* Or :math:`\heaptype_1` is :math:`\NONE` and :math:`\heaptype_2` :ref:`matches <match-heaptype>` :math:`\ANY`.

* Or :math:`\heaptype_1` is :math:`\NOFUNC` and :math:`\heaptype_2` :ref:`matches <match-heaptype>` :math:`\FUNC`.

* Or :math:`\heaptype_1` is :math:`\NOEXTERN` and :math:`\heaptype_2` :ref:`matches <match-heaptype>` :math:`\EXTERN`.

* Or :math:`\heaptype_1` is :math:`\BOTH`.

$${rule:
  {Heaptype_sub/refl Heaptype_sub/trans}
  {Heaptype_sub/eq-any Heaptype_sub/i31-eq Heaptype_sub/struct-eq Heaptype_sub/array-eq}
  {Heaptype_sub/struct Heaptype_sub/array Heaptype_sub/func}
  {Heaptype_sub/typeidx-l Heaptype_sub/typeidx-r}
  {Heaptype_sub/rec}
  {Heaptype_sub/none Heaptype_sub/nofunc Heaptype_sub/noextern}
  {Heaptype_sub/bot}
}
$${rule-ignore: Heaptype_sub/def}


.. index:: reference type
.. _match-reftype:

Reference Types
~~~~~~~~~~~~~~~

A :ref:`reference type <syntax-reftype>` ${reftype: REF nul1 heaptype_1} matches a :ref:`reference type <syntax-reftype>` ${reftype: REF nul2 heaptype_2} if and only if:

* The :ref:`heap type <syntax-heaptype>` :math:`\heaptype_1` :ref:`matches <match-heaptype>` :math:`\heaptype_2`.

* :math:`\NULL_1` is absent or :math:`\NULL_2` is present.

$${rule: Reftype_sub/*}


.. index:: value type, number type, reference type
.. _match-valtype:

Value Types
~~~~~~~~~~~

A :ref:`value type <syntax-valtype>` ${:valtype_1} matches a :ref:`value type <syntax-valtype>` ${:valtype_2} if and only if:

* Either both :math:`\valtype_1` and :math:`\valtype_2` are :ref:`number types <syntax-numtype>` and :math:`\valtype_1` :ref:`matches <match-numtype>` :math:`\valtype_2`.

* Or both :math:`\valtype_1` and :math:`\valtype_2` are :ref:`reference types <syntax-reftype>` and :math:`\valtype_1` :ref:`matches <match-reftype>` :math:`\valtype_2`.

* Or :math:`\valtype_1` is :math:`\BOT`.

$${rule: Valtype_sub/bot}
$${rule-ignore: Valtype_sub/num Valtype_sub/vec Valtype_sub/ref}


.. index:: result type, value type
.. _match-resulttype:

Result Types
~~~~~~~~~~~~

Subtyping is lifted to :ref:`result types <syntax-resulttype>` in a pointwise manner.
That is, a :ref:`result type <syntax-resulttype>` ${:t_1*} matches a :ref:`result type <syntax-resulttype>` ${:t_2*} if and only if:

* Every :ref:`value type <syntax-valtype>` :math:`t_1` in :math:`[t_1^\ast]` :ref:`matches <match-valtype>` the corresponding :ref:`value type <syntax-valtype>` :math:`t_2` in :math:`[t_2^\ast]`.

$${rule: Resulttype_sub}


.. index:: instruction type, result type
.. _match-instrtype:

Instruction Types
~~~~~~~~~~~~~~~~~

Subtyping is further lifted to :ref:`instruction types <syntax-instrtype>`.
An :ref:`instruction type <syntax-instrtype>` ${instrtype: t_11* ->_(x_1*) t_12*} matches a type ${instrtype: t_21* ->_(x_2*) t_22*} if and only if:

* There is a common sequence of :ref:`value types <syntax-valtype>` :math:`t^\ast` such that :math:`t_{21}^\ast` equals :math:`t^\ast~{t'_{21}}^\ast` and :math:`t_{22}^\ast` equals :math:`t^\ast~{t'_{22}}^\ast`.

* The :ref:`result type <syntax-resulttype>` :math:`[{t'_{21}}^\ast]` :ref:`matches <match-resulttype>` :math:`[t_{11}^\ast]`.

* The :ref:`result type <syntax-resulttype>` :math:`[t_{12}^\ast]` :ref:`matches <match-resulttype>` :math:`[{t'_{22}}^\ast]`.

* For every :ref:`local index <syntax-localidx>` :math:`x` that is in :math:`x_2^\ast` but not in :math:`x_1^\ast`, the :ref:`local type <syntax-localtype>` :math:`C.\CLOCALS[x]` is :math:`\SET~t_x` for some :ref:`value type <syntax-valtype>` :math:`t_x`.

$${rule: Instrtype_sub}

.. note::
   Instruction types are contravariant in their input and covariant in their output.
   Subtyping also incorporates a sort of "frame" condition, which allows adding arbitrary invariant stack elements on both sides in the super type.

   Finally, the supertype may ignore variables from the init set ${:x_1*}.
   It may also *add* variables to the init set, provided these are already set in the context, i.e., are vacuously initialized.


.. index:: function type, result type
.. _match-functype:

Function Types
~~~~~~~~~~~~~~

A :ref:`function type <syntax-functype>` ${functype: t_11* -> t_12*} matches a type ${functype: t_21* -> t_22*} if and only if:

* The :ref:`result type <syntax-resulttype>` :math:`[t_{21}^\ast]` :ref:`matches <match-resulttype>` :math:`[t_{11}^\ast]`.

* The :ref:`result type <syntax-resulttype>` :math:`[t_{12}^\ast]` :ref:`matches <match-resulttype>` :math:`[t_{22}^\ast]`.

$${rule: Functype_sub}


.. index:: composite types, aggregate type, structure type, array type, field type
.. _match-comptype:
.. _match-structtype:
.. _match-arraytype:

Composite Types
~~~~~~~~~~~~~~~

A :ref:`composite type <syntax-comptype>` ${:comptype_1} matches a type ${:comptype_2} if and only if:

* Either the composite type :math:`\comptype_1` is :math:`\TFUNC~\functype_1` and :math:`\comptype_2` is :math:`\TFUNC~\functype_2` and:

  * The :ref:`function type <syntax-functype>` :math:`\functype_1` :ref:`matches <match-functype>` :math:`\functype_2`.

* Or the composite type :math:`\comptype_1` is :math:`\TSTRUCT~\fieldtype_1^{n_1}` and :math:`\comptype_2` is :math:`\TSTRUCT~\fieldtype_2` and:

  * The arity :math:`n_1` is greater than or equal to :math:`n_2`.

  * For every :ref:`field type <syntax-fieldtype>` :math:`\fieldtype_{2i}` in :math:`\fieldtype_2^{n_2}` and corresponding :math:`\fieldtype_{1i}` in :math:`\fieldtype_1^{n_1}`

    * The :ref:`field type <syntax-fieldtype>` :math:`\fieldtype_{1i}` :ref:`matches <match-fieldtype>` :math:`\fieldtype_{2i}`.

* Or the composite type :math:`\comptype_1` is :math:`\TARRAY~\fieldtype_1` and :math:`\comptype_2` is :math:`\TARRAY~\fieldtype_2` and:

  * The :ref:`field type <syntax-fieldtype>` :math:`\fieldtype_1` :ref:`matches <match-fieldtype>` :math:`\fieldtype_2`.

$${rule: Comptype_sub/*}


.. index:: field type, storage type, value type, packed type, mutability
.. _match-fieldtype:
.. _match-storagetype:
.. _match-packtype:

Field Types
~~~~~~~~~~~

A :ref:`field type <syntax-fieldtype>` ${fieldtype: (mut1 storagetype_1)} matches a type ${fieldtype: (mut2 storagetype_2)} if and only if:

* :ref:`Storage type <syntax-storagetype>` :math:`\storagetype_1` :ref:`matches <match-storagetype>` :math:`\storagetype_2`.

* Either both :math:`\mut_1` and :math:`\mut_2` are :math:`\MCONST`.

* Or both :math:`\mut_1` and :math:`\mut_2` are :math:`\MVAR` and :math:`\storagetype_2` :ref:`matches <match-storagetype>` :math:`\storagetype_1` as well.

$${rule: Fieldtype_sub/*}

A :ref:`storage type <syntax-storagetype>` :math:`\storagetype_1` matches a type :math:`\storagetype_2` if and only if:

* Either :math:`\storagetype_1` is a :ref:`value type <syntax-valtype>` :math:`\valtype_1` and :math:`\storagetype_2` is a :ref:`value type <syntax-valtype>` :math:`\valtype_2` and :math:`\valtype_1` :ref:`matches <match-valtype>` :math:`\valtype_2`.

* Or :math:`\storagetype_1` is a :ref:`packed type <syntax-packtype>` :math:`\packtype_1` and :math:`\storagetype_2` is a :ref:`packed type <syntax-packtype>` :math:`\packtype_2` and :math:`\packtype_1` :ref:`matches <match-packtype>` :math:`\packtype_2`.


A :ref:`packed type <syntax-packtype>` ${:packtype_1} matches a type ${:packtype_2} if and only if:

* The :ref:`packed type <syntax-packtype>` :math:`\packtype_1` is the same as :math:`\packtype_2`.

$${rule: Packtype_sub}


.. index:: defined type, recursive type, unroll, type equivalence
   pair: abstract syntax; defined type
.. _match-deftype:

Defined Types
~~~~~~~~~~~~~

A :ref:`defined type <syntax-deftype>` ${:deftype_1} matches a type ${:deftype_2} if and only if:

* Either :math:`\deftype_1` and :math:`\deftype_2` are equal when :ref:`closed <type-closure>` under context :math:`C`.

* Or:

  * Let the :ref:`sub type <syntax-subtype>` :math:`\TSUB~\TFINAL^?~\heaptype^\ast~\comptype` be the result of :ref:`unrolling <aux-unroll-deftype>` :math:`\deftype_1`.

  * Then there must exist a :ref:`heap type <syntax-heaptype>` :math:`\heaptype_i` in :math:`\heaptype^\ast` that :ref:`matches <match-heaptype>` :math:`\deftype_2`.

$${rule: Deftype_sub/refl Deftype_sub/super}

.. note::
   Note that there is no explicit definition of type *equivalence*,
   since it coincides with syntactic equality,
   as used in the premise of the fomer rule above.


.. index:: limits
.. _match-limits:

Limits
~~~~~~

:ref:`Limits <syntax-limits>` ${limits: `[n_1 .. m_1]} match limits ${limits: `[n_2 .. m_2]} if and only if:

* :math:`n_1` is larger than or equal to :math:`n_2`.

* Either:

  * :math:`m_2^?` is empty.

* Or:

  * Both :math:`m_1^?` and :math:`m_2^?` are non-empty.

  * :math:`m_1` is smaller than or equal to :math:`m_2`.

$${rule: Limits_sub}


.. index:: table type, limits, element type
.. _match-tabletype:

Table Types
~~~~~~~~~~~

A :ref:`table type <syntax-tabletype>` ${tabletype: (limits_1 reftype_1)} matches ${tabletype: (limits_1 reftype_1)} if and only if:

* Limits :math:`\limits_1` :ref:`match <match-limits>` :math:`\limits_2`.

* The :ref:`reference type <syntax-reftype>` :math:`\reftype_1` :ref:`matches <match-reftype>` :math:`\reftype_2`, and vice versa.

$${rule: Tabletype_sub}


.. index:: memory type, limits
.. _match-memtype:

Memory Types
~~~~~~~~~~~~

A :ref:`memory type <syntax-memtype>` ${memtype: (limits_1 PAGE)} matches ${memtype: (limits_2 PAGE)} if and only if:

* Limits :math:`\limits_1` :ref:`match <match-limits>` :math:`\limits_2`.

$${rule: Memtype_sub}


.. index:: global type, value type, mutability
.. _match-globaltype:

Global Types
~~~~~~~~~~~~

A :ref:`global type <syntax-globaltype>` ${globaltype: (mut1 valtype_1)} matches ${globaltype: (mut2 valtype_2)} if and only if:

* Either both :math:`\mut_1` and :math:`\mut_2` are |MVAR| and :math:`t_1` :ref:`matches <match-valtype>` :math:`t_2` and vice versa.

* Or both :math:`\mut_1` and :math:`\mut_2` are |MCONST| and :math:`t_1` :ref:`matches <match-valtype>` :math:`t_2`.

$${rule: Globaltype_sub/*}


.. index:: external type, function type, table type, memory type, global type
.. _match-externtype:

External Types
~~~~~~~~~~~~~~

Functions
.........

An :ref:`external type <syntax-externtype>` ${externtype: FUNC deftype_1} matches ${externtype: FUNC deftype_2} if and only if:

* The :ref:`defined type <syntax-deftype>` :math:`\deftype_1` :ref:`matches <match-deftype>` :math:`\deftype_2`.

$${rule: Externtype_sub/func}


Tables
......

An :ref:`external type <syntax-externtype>` ${externtype: TABLE tabletype_1} matches ${externtype: TABLE tabletype_2} if and only if:

* Table type :math:`\tabletype_1` :ref:`matches <match-tabletype>` :math:`\tabletype_2`.

$${rule: Externtype_sub/table}


Memories
........

An :ref:`external type <syntax-externtype>` ${externtype: MEM memtype_1} matches ${externtype: MEM memtype_2} if and only if:

* Memory type :math:`\memtype_1` :ref:`matches <match-memtype>` :math:`\memtype_2`.

$${rule: Externtype_sub/mem}


Globals
.......

An :ref:`external type <syntax-externtype>` ${externtype: GLOBAL globaltype_1} matches ${externtype: GLOBAL globaltype_2} if and only if:

* Global type :math:`\globaltype_1` :ref:`matches <match-globaltype>` :math:`\globaltype_2`.

$${rule: Externtype_sub/global}

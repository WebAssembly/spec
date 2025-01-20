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

$${rule-prose: Numtype_sub}

$${rule: Numtype_sub}


.. index:: vector type
.. _match-vectype:

Vector Types
~~~~~~~~~~~~

$${rule-prose: Vectype_sub}

$${rule: Vectype_sub}


.. index:: heap type, defined type, structure type, array type, function type, unboxed scalar type
.. _match-heaptype:

Heap Types
~~~~~~~~~~

$${rule-prose: Heaptype_sub}

.. todo::
 below is the official specification

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

$${rule-prose: Reftype_sub}
.. todo::
 below is the official specification

A :ref:`reference type <syntax-reftype>` ${reftype: REF nul1 heaptype_1} matches a :ref:`reference type <syntax-reftype>` ${reftype: REF nul2 heaptype_2} if and only if:

* The :ref:`heap type <syntax-heaptype>` :math:`\heaptype_1` :ref:`matches <match-heaptype>` :math:`\heaptype_2`.

* :math:`\NULL_1` is absent or :math:`\NULL_2` is present.

$${rule: {Reftype_sub/*}}


.. index:: value type, number type, reference type
.. _match-valtype:

Value Types
~~~~~~~~~~~

$${rule-prose: Valtype_sub}

$${rule: Valtype_sub/bot}
$${rule-ignore: Valtype_sub/num Valtype_sub/vec Valtype_sub/ref}


.. index:: result type, value type
.. _match-resulttype:

Result Types
~~~~~~~~~~~~

Subtyping is lifted to :ref:`result types <syntax-resulttype>` in a pointwise manner.

$${rule-prose: Resulttype_sub}

$${rule: Resulttype_sub}


.. index:: instruction type, result type
.. _match-instrtype:

Instruction Types
~~~~~~~~~~~~~~~~~

Subtyping is further lifted to :ref:`instruction types <syntax-instrtype>`.

$${rule-prose: Instrtype_sub}

$${rule: Instrtype_sub}

.. note::
   Instruction types are contravariant in their input and covariant in their output.
   Moreover, the supertype may ignore variables from the init set ${:x_1*}.
   It may also *add* variables to the init set, provided these are already set in the context, i.e., are vacuously initialized.

.. scratch
   Subtyping also incorporates a sort of "frame" condition, which allows adding arbitrary invariant stack elements on both sides in the super type.


.. index:: function type, result type
.. _match-functype:

Function Types
~~~~~~~~~~~~~~

$${rule-prose: Functype_sub}

$${rule: Functype_sub}


.. index:: composite types, aggregate type, structure type, array type, field type
.. _match-comptype:
.. _match-structtype:
.. _match-arraytype:

Composite Types
~~~~~~~~~~~~~~~

$${rule-prose: Comptype_sub}

$${rule: {Comptype_sub/*}}


.. index:: field type, storage type, value type, packed type, mutability
.. _match-fieldtype:
.. _match-storagetype:
.. _match-packtype:

Field Types
~~~~~~~~~~~

$${rule-prose: Fieldtype_sub}

$${rule: {Fieldtype_sub/*}}


$${rule-prose: Storagetype_sub}


$${rule-prose: Packtype_sub}

$${rule: Packtype_sub}


.. index:: defined type, recursive type, unroll, type equivalence
   pair: abstract syntax; defined type
.. _match-deftype:

Defined Types
~~~~~~~~~~~~~

$${rule-prose: Deftype_sub}

$${rule: Deftype_sub/refl Deftype_sub/super}

.. note::
   Note that there is no explicit definition of type *equivalence*,
   since it coincides with syntactic equality,
   as used in the premise of the former rule above.


.. index:: limits
.. _match-limits:

Limits
~~~~~~

$${rule-prose: Limits_sub}

$${rule: Limits_sub}


.. index:: table type, limits, element type
.. _match-tabletype:

Table Types
~~~~~~~~~~~

$${rule-prose: Tabletype_sub}

$${rule: Tabletype_sub}


.. index:: memory type, limits
.. _match-memtype:

Memory Types
~~~~~~~~~~~~

$${rule-prose: Memtype_sub}

$${rule: Memtype_sub}


.. index:: global type, value type, mutability
.. _match-globaltype:

Global Types
~~~~~~~~~~~~

$${rule-prose: Globaltype_sub}

$${rule: {Globaltype_sub/*}}


.. index:: tag type
.. _match-tagtype:

Tag Types
~~~~~~~~~

$${rule-prose: Tagtype_sub}

$${rule: {Tagtype_sub}}

.. note::
   Although the conclusion of this rule looks identical to its premise,
   they in fact describe different relations:
   the premise invokes subtyping on defined types,
   while the conclusion defines it on tag types that happen to be expressed as defined types.


.. index:: external type, function type, table type, memory type, global type
.. _match-externtype:

External Types
~~~~~~~~~~~~~~

$${rule-prose: Externtype_sub/func}

$${rule: Externtype_sub/func}


$${rule-prose: Externtype_sub/table}

$${rule: Externtype_sub/table}


$${rule-prose: Externtype_sub/mem}

$${rule: Externtype_sub/mem}


$${rule-prose: Externtype_sub/global}

$${rule: Externtype_sub/global}


$${rule-prose: Externtype_sub/tag}

$${rule: Externtype_sub/tag}

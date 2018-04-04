Types
-----

Most :ref:`types <syntax-type>` are universally valid.
However, restrictions apply to :ref:`function types <syntax-functype>` as well as the :ref:`limits <syntax-limits>` of :ref:`table types <syntax-tabletype>` and :ref:`memory types <syntax-memtype>`, which must be checked during validation.

On :ref:`value types <syntax-valtype>`, a simple notion of subtyping is defined.


.. index:: limits
   pair: validation; limits
   single: abstract syntax; limits
.. _valid-limits:

Limits
~~~~~~

:ref:`Limits <syntax-limits>` must have meaningful bounds.

:math:`\{ \LMIN~n, \LMAX~m^? \}`
................................

* If the maximum :math:`m^?` is not empty, then its value must not be smaller than :math:`n`.

* Then the limit is valid.

.. math::
   \frac{
     (n \leq m)^?
   }{
     \vdashlimits \{ \LMIN~n, \LMAX~m^? \} \ok
   }


.. index:: function type
   pair: validation; function type
   single: abstract syntax; function type
.. _valid-functype:

Function Types
~~~~~~~~~~~~~~

:ref:`Function types <syntax-functype>` may not specify more than one result.

:math:`[t_1^n] \to [t_2^m]`
...........................

* The arity :math:`m` must not be larger than :math:`1`.

* Then the function type is valid.

.. math::
   \frac{
   }{
     \vdashfunctype [t_1^\ast] \to [t_2^?] \ok
   }

.. note::
   This restriction may be removed in future versions of WebAssembly.


.. index:: table type, reference type, limits
   pair: validation; table type
   single: abstract syntax; table type
.. _valid-tabletype:

Table Types
~~~~~~~~~~~

:math:`\limits~\reftype`
........................

* The limits :math:`\limits` must be :ref:`valid <valid-limits>`.

* Then the table type is valid.

.. math::
   \frac{
     \vdashlimits \limits \ok
   }{
     \vdashtabletype \limits~\reftype \ok
   }


.. index:: memory type, limits
   pair: validation; memory type
   single: abstract syntax; memory type
.. _valid-memtype:

Memory Types
~~~~~~~~~~~~

:math:`\limits`
...............

* The limits :math:`\limits` must be :ref:`valid <valid-limits>`.

* Then the memory type is valid.

.. math::
   \frac{
     \vdashlimits \limits \ok
   }{
     \vdashmemtype \limits \ok
   }


.. index:: global type, value type, mutability
   pair: validation; global type
   single: abstract syntax; global type
.. _valid-globaltype:

Global Types
~~~~~~~~~~~~

:math:`\mut~\valtype`
.....................

* The global type is valid.

.. math::
   \frac{
   }{
     \vdashglobaltype \mut~\valtype \ok
   }


.. index:: subtyping

Value Subtyping
~~~~~~~~~~~~~~~

.. index:: number type

.. _match-numtype:

Number Types
............

A :ref:`number type <syntax-numtype>` :math:`\numtype_1` matches a :ref:`number type <syntax-numtype>` :math:`\numtype_2` if and only if:

* Both :math:`\numtype_1` and :math:`\numtype_2` are the same.

.. math::
   ~\\[-1ex]
   \frac{
   }{
     \vdashnumtypematch \numtype \matchesvaltype \numtype
   }


.. index:: reference type

.. _match-reftype:

Reference Types
...............

A :ref:`reference type <syntax-reftype>` :math:`\reftype_1` matches a :ref:`number type <syntax-reftype>` :math:`\reftype_2` if and only if:

* Either both :math:`\reftype_1` and :math:`\reftype_2` are the same.

* Or :math:`\reftype_1` is |NULLREF|.

* Or :math:`\reftype_2` is |ANYREF|.

.. math::
   ~\\[-1ex]
   \frac{
   }{
     \vdashreftypematch \reftype \matchesvaltype \reftype
   }
   \qquad
   \frac{
   }{
     \vdashreftypematch \NULLREF \matchesvaltype \reftype
   }
   \qquad
   \frac{
   }{
     \vdashreftypematch \reftype \matchesvaltype \ANYREF
   }


.. index:: value type, number type, reference type

.. _match-valtype:

Value Types
...........

A :ref:`value type <syntax-valtype>` :math:`\valtype_1` matches a :ref:`value type <syntax-valtype>` :math:`\valtype_2` if and only if:

* Either both :math:`\valtype_1` and :math:`\valtype_2` are :ref:`number types <syntax-numtype>` and :math:`\valtype_1` :ref:`matches <match-numtype>` :math:`\valtype_2`.

* Or both :math:`\valtype_1` and :math:`\valtype_2` are :ref:`reference types <syntax-reftype>` and :math:`\valtype_1` :ref:`matches <match-reftype>` :math:`\valtype_2`.


.. _match-resulttype:

Result Types
............

Subtyping is lifted to :ref:`result types <syntax-resulttype>` in a pointwise manner.
That is, a :ref:`result type <syntax-resulttype>` :math:`[t_1^?]` matches a :ref:`result type <syntax-resulttype>` :math:`[t_2^?]` if and only if:

* Either both :math:`t_1^?` and :math:`t_2^?` are empty.

* Or :ref:`value type <syntax-valtype>` :math:`t_1` :ref:`matches <match-valtype>` :ref:`value type <syntax-valtype>` :math:`t_2`.

.. math::
   ~\\[-1ex]
   \frac{
     (\vdashvaltypematch t_1 \matchesvaltype t_2)^?
   }{
     \vdashresulttypematch [t_1^?] \matchesresulttype [t_2^?]
   }

Types
----

Most :ref:`types <syntax-type>` are universally valid.
However, restrictions apply to :ref:`function types <syntax-functype>` as well as the :ref:`limits <syntax-limits>` of :ref:`table types <syntax-tabletype>` and :ref:`memory types <syntax-memtype>`, which must be checked during validation.

On :ref:`value types <syntax-valtype>`, a simple notion of subtyping is defined.

Moreover, :ref:`block types <syntax-blocktype>` are converted to plain :ref:`function types <syntax-functype>` for ease of processing.


.. index:: limits
   pair: validation; limits
   single: abstract syntax; limits
.. _valid-limits:

Limits
~~~~~~

:ref:`Limits <syntax-limits>` must have meaningful bounds that are within a given range.

:math:`\{ \LMIN~n, \LMAX~m^? \}`
................................

* The value of :math:`n` must not be larger than :math:`k`.

* If the maximum :math:`m^?` is not empty, then:

  * Its value must not be larger than :math:`k`.

  * Its value must not be smaller than :math:`n`.

* Then the limit is valid within range :math:`k`.

.. math::
   \frac{
     n \leq k
     \qquad
     (m \leq k)^?
     \qquad
     (n \leq m)^?
   }{
     \vdashlimits \{ \LMIN~n, \LMAX~m^? \} : k
   }


.. index:: block type
   pair: validation; block type
   single: abstract syntax; block type
.. _valid-blocktype:

Block Types
~~~~~~~~~~~

:ref:`Block types <syntax-blocktype>` may be expressed in one of two forms, both of which are converted to plain :ref:`function types <syntax-functype>` by the following rules.

:math:`\typeidx`
................

* The type :math:`C.\CTYPES[\typeidx]` must be defined in the context.

* Then the block type is valid as :ref:`function type <syntax-functype>` :math:`C.\CTYPES[\typeidx]`.

.. math::
   \frac{
     C.\CTYPES[\typeidx] = \functype
   }{
     C \vdashblocktype \typeidx : \functype
   }


:math:`[\valtype^?]`
....................

* The block type is valid as :ref:`function type <syntax-functype>` :math:`[] \to [\valtype^?]`.

.. math::
   \frac{
   }{
     C \vdashblocktype [\valtype^?] : [] \to [\valtype^?]
   }


.. index:: function type
   pair: validation; function type
   single: abstract syntax; function type
.. _valid-functype:

Function Types
~~~~~~~~~~~~~~

:ref:`Function types <syntax-functype>` are always valid.

:math:`[t_1^n] \to [t_2^m]`
...........................

* The function type is valid.

.. math::
   \frac{
   }{
     \vdashfunctype [t_1^\ast] \to [t_2^\ast] \ok
   }


.. index:: table type, reference type, limits
   pair: validation; table type
   single: abstract syntax; table type
.. _valid-tabletype:

Table Types
~~~~~~~~~~~

:math:`\limits~\reftype`
........................

* The limits :math:`\limits` must be :ref:`valid <valid-limits>` within range :math:`2^{32}`.

* Then the table type is valid.

.. math::
   \frac{
     \vdashlimits \limits : 2^{32}
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

* The limits :math:`\limits` must be :ref:`valid <valid-limits>` within range :math:`2^{16}`.

* Then the memory type is valid.

.. math::
   \frac{
     \vdashlimits \limits : 2^{16}
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


.. index:: external type, function type, table type, memory type, global type
   pair: validation; external type
   single: abstract syntax; external type
.. _valid-externtype:

External Types
~~~~~~~~~~~~~~

:math:`\ETFUNC~\functype`
.........................

* The :ref:`function type <syntax-functype>` :math:`\functype` must be :ref:`valid <valid-functype>`.

* Then the external type is valid.

.. math::
   \frac{
     \vdashfunctype \functype \ok
   }{
     \vdashexterntype \ETFUNC~\functype \ok
   }

:math:`\ETTABLE~\tabletype`
...........................

* The :ref:`table type <syntax-tabletype>` :math:`\tabletype` must be :ref:`valid <valid-tabletype>`.

* Then the external type is valid.

.. math::
   \frac{
     \vdashtabletype \tabletype \ok
   }{
     \vdashexterntype \ETTABLE~\tabletype \ok
   }

:math:`\ETMEM~\memtype`
.......................

* The :ref:`memory type <syntax-memtype>` :math:`\memtype` must be :ref:`valid <valid-memtype>`.

* Then the external type is valid.

.. math::
   \frac{
     \vdashmemtype \memtype \ok
   }{
     \vdashexterntype \ETMEM~\memtype \ok
   }

:math:`\ETGLOBAL~\globaltype`
.............................

* The :ref:`global type <syntax-globaltype>` :math:`\globaltype` must be :ref:`valid <valid-globaltype>`.

* Then the external type is valid.

.. math::
   \frac{
     \vdashglobaltype \globaltype \ok
   }{
     \vdashexterntype \ETGLOBAL~\globaltype \ok
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

A :ref:`reference type <syntax-reftype>` :math:`\reftype_1` matches a :ref:`reference type <syntax-reftype>` :math:`\reftype_2` if and only if:

* Either both :math:`\reftype_1` and :math:`\reftype_2` are the same.

.. math::
   ~\\[-1ex]
   \frac{
   }{
     \vdashreftypematch \reftype \matchesvaltype \reftype
   }


.. index:: value type, number type, reference type

.. _match-valtype:

Value Types
...........

A :ref:`value type <syntax-valtype>` :math:`\valtype_1` matches a :ref:`value type <syntax-valtype>` :math:`\valtype_2` if and only if:

* Either both :math:`\valtype_1` and :math:`\valtype_2` are :ref:`number types <syntax-numtype>` and :math:`\valtype_1` :ref:`matches <match-numtype>` :math:`\valtype_2`.

* Or both :math:`\valtype_1` and :math:`\valtype_2` are :ref:`reference types <syntax-reftype>` and :math:`\valtype_1` :ref:`matches <match-reftype>` :math:`\valtype_2`.

* Or :math:`\valtype_1` is :math:`\BOT`.

.. math::
   ~\\[-1ex]
   \frac{
   }{
     \vdashvaltypematch \BOT \matchesvaltype \valtype
   }


.. _match-resulttype:

Result Types
............

Subtyping is lifted to :ref:`result types <syntax-resulttype>` in a pointwise manner.
That is, a :ref:`result type <syntax-resulttype>` :math:`[t_1^\ast]` matches a :ref:`result type <syntax-resulttype>` :math:`[t_2^\ast]` if and only if:

* Every :ref:`value type <syntax-valtype>` :math:`t_1` in :math:`[t_1^\ast]` :ref:`matches <match-valtype>` the corresponding :ref:`value type <syntax-valtype>` :math:`t_2` in :math:`[t_2^\ast]`.

.. math::
   ~\\[-1ex]
   \frac{
     (\vdashvaltypematch t_1 \matchesvaltype t_2)^\ast
   }{
     \vdashresulttypematch [t_1^\ast] \matchesresulttype [t_2^ast]
   }


.. index:: ! matching, external type
.. _exec-import:
.. _match:

Import Subtyping
~~~~~~~~~~~~~~~~

When :ref:`instantiating <exec-module>` a module,
:ref:`external values <syntax-externval>` must be provided whose :ref:`types <valid-externval>` are *matched* against the respective :ref:`external types <syntax-externtype>` classifying each import.
In some cases, this allows for a simple form of subtyping, as defined here.


.. index:: limits
.. _match-limits:

Limits
......

:ref:`Limits <syntax-limits>` :math:`\{ \LMIN~n_1, \LMAX~m_1^? \}` match limits :math:`\{ \LMIN~n_2, \LMAX~m_2^? \}` if and only if:

* :math:`n_1` is larger than or equal to :math:`n_2`.

* Either:

  * :math:`m_2^?` is empty.

* Or:

  * Both :math:`m_1^?` and :math:`m_2^?` are non-empty.

  * :math:`m_1` is smaller than or equal to :math:`m_2`.

.. math::
   ~\\[-1ex]
   \frac{
     n_1 \geq n_2
   }{
     \vdashlimitsmatch \{ \LMIN~n_1, \LMAX~m_1^? \} \matcheslimits \{ \LMIN~n_2, \LMAX~\epsilon \}
   }
   \quad
   \frac{
     n_1 \geq n_2
     \qquad
     m_1 \leq m_2
   }{
     \vdashlimitsmatch \{ \LMIN~n_1, \LMAX~m_1 \} \matcheslimits \{ \LMIN~n_2, \LMAX~m_2 \}
   }


.. _match-externtype:

.. index:: function type
.. _match-functype:

Functions
.........

An :ref:`external type <syntax-externtype>` :math:`\ETFUNC~\functype_1` matches :math:`\ETFUNC~\functype_2` if and only if:

* Both :math:`\functype_1` and :math:`\functype_2` are the same.

.. math::
   ~\\[-1ex]
   \frac{
   }{
     \vdashexterntypematch \ETFUNC~\functype \matchesexterntype \ETFUNC~\functype
   }


.. index:: table type, limits, element type
.. _match-tabletype:

Tables
......

An :ref:`external type <syntax-externtype>` :math:`\ETTABLE~(\limits_1~\reftype_1)` matches :math:`\ETTABLE~(\limits_2~\reftype_2)` if and only if:

* Limits :math:`\limits_1` :ref:`match <match-limits>` :math:`\limits_2`.

* Both :math:`\reftype_1` and :math:`\reftype_2` are the same.

.. math::
   \frac{
     \vdashlimitsmatch \limits_1 \matcheslimits \limits_2
   }{
     \vdashexterntypematch \ETTABLE~(\limits_1~\reftype) \matchesexterntype \ETTABLE~(\limits_2~\reftype)
   }


.. index:: memory type, limits
.. _match-memtype:

Memories
........

An :ref:`external type <syntax-externtype>` :math:`\ETMEM~\limits_1` matches :math:`\ETMEM~\limits_2` if and only if:

* Limits :math:`\limits_1` :ref:`match <match-limits>` :math:`\limits_2`.

.. math::
   \frac{
     \vdashlimitsmatch \limits_1 \matcheslimits \limits_2
   }{
     \vdashexterntypematch \ETMEM~\limits_1 \matchesexterntype \ETMEM~\limits_2
   }


.. index:: global type, value type, mutability
.. _match-globaltype:

Globals
.......

An :ref:`external type <syntax-externtype>` :math:`\ETGLOBAL~(\mut_1~t_1)` matches :math:`\ETGLOBAL~(\mut_2~t_2)` if and only if:

* Either both :math:`\mut_1` and :math:`\mut_2` are |MVAR| and :math:`t_1` and :math:`t_2` are the same.
 
* Or both :math:`\mut_1` and :math:`\mut_2` are |MCONST| and :math:`t_1` :ref:`matches <match-valtype>` :math:`t_2`.

.. math::
   ~\\[-1ex]
   \frac{
   }{
     \vdashexterntypematch \ETGLOBAL~(\MVAR~t) \matchesexterntype \ETGLOBAL~(\MVAR~t)
   }
   \qquad
   \frac{
     \vdashvaltypematch t_1 \matchesvaltype t_2
   }{
     \vdashexterntypematch \ETGLOBAL~(\MCONST~t_1) \matchesexterntype \ETGLOBAL~(\MCONST~t_2)
   }

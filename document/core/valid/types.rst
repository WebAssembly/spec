Types
-----

Most :ref:`types <syntax-type>` are universally valid.
However, restrictions apply to :ref:`limits <syntax-limits>`, which must be checked during validation.
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


.. index:: table type, element type, limits
   pair: validation; table type
   single: abstract syntax; table type
.. _valid-tabletype:

Table Types
~~~~~~~~~~~

:math:`\limits~\elemtype`
.........................

* The limits :math:`\limits` must be :ref:`valid <valid-limits>` within range :math:`2^{32}`.

* Then the table type is valid.

.. math::
   \frac{
     \vdashlimits \limits : 2^{32}
   }{
     \vdashtabletype \limits~\elemtype \ok
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

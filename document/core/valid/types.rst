Types
-----

Most :ref:`types <syntax-type>` are universally valid.
However, restrictions apply to :ref:`function types <syntax-functype>` as well as the :ref:`limits <syntax-limits>` of :ref:`table types <syntax-tabletype>` and :ref:`memory types <syntax-memtype>`, which must be checked during validation.


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
     \vdash [t_1^\ast] \to [t_2^?] \ok
   }

.. note::
   This restriction may be removed in future versions of WebAssembly.


.. index:: limits
   pair: validation; limits
   single: abstract syntax; limits
.. _valid-limits:

Limits
~~~~~~

:ref:`Limits <syntax-limits>` must have menaingful bounds.

:math:`\{ \LMIN~n, \LMAX~m^? \}`
................................

* If the maximum :math:`m^?` is not empty, then its value must not be smaller than :math:`n`.

* Then the limit is valid.

.. math::
   \frac{
     (n \leq m)^?
   }{
     \vdash \{ \LMIN~n, \LMAX~m^? \} \ok
   }


.. index:: table type, element type, limits
   pair: validation; table type
   single: abstract syntax; table type
.. _valid-tabletype:

:math:`\limits~\elemtype`
.........................

* The limits :math:`\limits` must be :ref:`valid <valid-limits>`.

* Then the table type is valid.

.. math::
   \frac{
     \vdash \limits \ok
   }{
     \vdash \limits~\elemtype \ok
   }


.. index:: memory type, limits
   pair: validation; memory type
   single: abstract syntax; memory type
.. _valid-memtype:

:math:`\limits`
...............

* The limits :math:`\limits` must be :ref:`valid <valid-limits>`.

* Then the memory type is valid.

.. math::
   \frac{
     \vdash \limits \ok
   }{
     \vdash \limits \ok
   }


.. index:: global type, value type, mutability
   pair: validation; global type
   single: abstract syntax; global type
.. _valid-globaltype:

:math:`\mut~\valtype`
.....................

* Then the global type is valid.

.. math::
   \frac{
   }{
     \vdash \mut~\valtype \ok
   }

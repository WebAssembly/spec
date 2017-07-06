Types
-----

Most :ref:`types <syntax-type>` are universally valid.
However, restrictions apply to :ref:`function types <syntax-functype>` and :ref:`limits <syntax-limits>`, which must be checked during validation.


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

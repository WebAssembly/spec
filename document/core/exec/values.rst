.. index:: value
.. exec-val:

Values
------

.. index:: value, value type, validation
.. _valid-val:

Value Typing
~~~~~~~~~~~~

For the purpose of checking argument :ref:`values <syntax-externval>` against the parameter types of exported :ref:`functions <syntax-func>`,
values are classified by :ref:`dynamic <syntax-type-dyn>` :ref:`value types <syntax-valtype>`.
The following auxiliary typing rules specify this typing relation relative to a :ref:`store <syntax-store>` :math:`S` in which possibly referenced addresses live.

.. _valid-num:

:ref:`Numeric Values <syntax-val>` :math:`t.\CONST~c`
.....................................................

* The value is valid with :ref:`number type <syntax-numtype>` :math:`t`.

.. math::
   \frac{
   }{
     S \vdashval t.\CONST~c : t
   }

.. _valid-vec:

:ref:`Vector Values <syntax-val>` :math:`t.\CONST~c`
....................................................

* The value is valid with :ref:`vector type <syntax-vectype>` :math:`t`.

.. math::
   \frac{
   }{
     S \vdashval t.\CONST~c : t
   }

.. _valid-ref:

:ref:`Null References <syntax-ref>` :math:`\REFNULL~t`
......................................................

* The :ref:`dynamic <syntax-type-dyn>` :ref:`heap type <syntax-heaptype>` must be :ref:`valid <valid-heaptype>`.

* Then value is valid with :ref:`reference type <syntax-reftype>` :math:`(\REF~\NULL~t)`.

.. math::
   \frac{
     S \vdashheaptype t \ok
   }{
     S \vdashval \REFNULL~t : (\REF~\NULL~t)
   }


:ref:`Function References <syntax-ref>` :math:`\REFFUNCADDR~a`
..............................................................

* The :ref:`external value <syntax-externval>` :math:`\EVFUNC~a` must be :ref:`valid <valid-externval>` with :ref:`dynamic <syntax-type-dyn>` :ref:`external type <syntax-externtype>` :math:`\ETFUNC~a'`.

* Then the value is valid with :ref:`dynamic <syntax-type-dyn>` :ref:`reference type <syntax-reftype>` :math:`(\REF~a')`.

.. math::
   \frac{
     S \vdashexternval \EVFUNC~a : \ETFUNC~a'
   }{
     S \vdashval \REFFUNCADDR~a : \REF~a'
   }


:ref:`External References <syntax-ref.extern>` :math:`\REFEXTERNADDR~a`
.......................................................................

* The value is valid with :ref:`reference type <syntax-reftype>` :math:`(\REF~\EXTERN)`.

.. math::
   \frac{
   }{
     S \vdashval \REFEXTERNADDR~a : (\REF~\EXTERN)
   }



.. index:: external value, external type, validation, import, store
.. _valid-externval:

External Typing
~~~~~~~~~~~~~~~

For the purpose of checking :ref:`external values <syntax-externval>` against :ref:`imports <syntax-import>`,
such values are classified by :ref:`dynamic <syntax-type-dyn>` :ref:`external types <syntax-externtype>`.
The following auxiliary typing rules specify this typing relation relative to a :ref:`store <syntax-store>` :math:`S` in which the referenced instances live.


.. index:: function type, function address
.. _valid-externval-func:

:math:`\EVFUNC~a`
.................

* The store entry :math:`S.\SFUNCS[a]` must exist.

* Then :math:`\EVFUNC~a` is valid with :ref:`external type <syntax-externtype>` :math:`\ETFUNC~S.\SFUNCS[a].\FITYPE`.

.. math::
   \frac{
   }{
     S \vdashexternval \EVFUNC~a : \ETFUNC~S.\SFUNCS[a].\FITYPE
   }


.. index:: table type, table address
.. _valid-externval-table:

:math:`\EVTABLE~a`
..................

* The store entry :math:`S.\STABLES[a]` must exist.

* Then :math:`\EVTABLE~a` is valid with :ref:`external type <syntax-externtype>` :math:`\ETTABLE~S.\STABLES[a].\TITYPE`.

.. math::
   \frac{
   }{
     S \vdashexternval \EVTABLE~a : \ETTABLE~S.\STABLES[a].\TITYPE
   }


.. index:: memory type, memory address
.. _valid-externval-mem:

:math:`\EVMEM~a`
................

* The store entry :math:`S.\SMEMS[a]` must exist.

* Then :math:`\EVMEM~a` is valid with :ref:`external type <syntax-externtype>` :math:`\ETMEM~S.\SMEMS[a].\MITYPE`.

.. math::
   \frac{
   }{
     S \vdashexternval \EVMEM~a : \ETMEM~S.\SMEMS[a].\MITYPE
   }


.. index:: global type, global address, value type, mutability
.. _valid-externval-global:

:math:`\EVGLOBAL~a`
...................

* The store entry :math:`S.\SGLOBALS[a]` must exist.

* Then :math:`\EVGLOBAL~a` is valid with :ref:`external type <syntax-externtype>` :math:`\ETGLOBAL~S.\SGLOBALS[a].\GITYPE`.

.. math::
   \frac{
   }{
     S \vdashexternval \EVGLOBAL~a : \ETGLOBAL~S.\SGLOBALS[a].\GITYPE
   }

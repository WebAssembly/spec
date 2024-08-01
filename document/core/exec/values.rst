.. index:: value
.. exec-val:

Values
------

.. index:: value, value type, validation, structure, structure type, structure instance, array, array type, array instance, function, function type, function instance, null reference, scalar reference, store
.. _valid-val:

Value Typing
~~~~~~~~~~~~

For the purpose of checking argument :ref:`values <syntax-externval>` against the parameter types of exported :ref:`functions <syntax-func>`,
values are classified by :ref:`value types <syntax-valtype>`.
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

* The :ref:`heap type <syntax-heaptype>` must be :ref:`valid <valid-heaptype>` under the empty :ref:`context <context>`.

* Then the value is valid with :ref:`reference type <syntax-reftype>` :math:`(\REF~\NULL~t')`, where the :ref:`heap type <syntax-heaptype>` :math:`t'` is the least type that :ref:`matches <match-heaptype>` :math:`t`.

.. math::
   \frac{
     \vdashheaptype t \ok
     \qquad
     t' \in \{\NONE, \NOFUNC, \NOEXTERN\}
     \qquad
     \vdashheaptypematch t' \matchesheaptype t
   }{
     S \vdashval \REFNULL~t : (\REF~\NULL~t')
   }

.. note::
   A null reference is typed with the least type in its respective hierarchy.
   That ensures that it is compatible with any nullable type in that hierarchy.


.. _valid-ref.i31num:

:ref:`Scalar References <syntax-ref>` :math:`\REFI31NUM~i`
..........................................................

* The value is valid with :ref:`reference type <syntax-reftype>` :math:`(\REF~\I31)`.

.. math::
   \frac{
   }{
     S \vdashval \REFI31NUM~i : \REF~\I31
   }


.. _valid-ref.struct:

:ref:`Structure References <syntax-ref>` :math:`\REFSTRUCTADDR~a`
.................................................................

* The :ref:`structure address <syntax-structaddr>` :math:`a` must exist in the store.

* Let :math:`\structinst` be the :ref:`structure instance <syntax-structinst>` :math:`S.\SSTRUCTS[a]`.

* Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`\structinst.\SITYPE`.

* The :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` must be a :ref:`struct type <syntax-structtype>`.

* Then the value is valid with :ref:`reference type <syntax-reftype>` :math:`(\REF~\deftype)`.

.. math::
   \frac{
     \deftype = S.\SSTRUCTS[a].\SITYPE
     \qquad
     \expanddt(\deftype) = \TSTRUCT~\structtype
   }{
     S \vdashval \REFSTRUCTADDR~a : \REF~\deftype
   }


.. _valid-ref.array:

:ref:`Array References <syntax-ref>` :math:`\REFARRAYADDR~a`
............................................................

* The :ref:`array address <syntax-arrayaddr>` :math:`a` must exist in the store.

* Let :math:`\arrayinst` be the :ref:`array instance <syntax-arrayinst>` :math:`S.\SARRAYS[a]`.

* Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`\arrayinst.\AITYPE`.

* The :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` must be an :ref:`array type <syntax-arraytype>`.

* Then the value is valid with :ref:`reference type <syntax-reftype>` :math:`(\REF~\arraytype)`.

.. math::
   \frac{
     \deftype = S.\SARRAYS[a].\AITYPE
     \qquad
     \expanddt(\deftype) = \TARRAY~\arraytype
   }{
     S \vdashval \REFARRAYADDR~a : \REF~\deftype
   }


.. _valid-ref.exn:

:ref:`Exception References <syntax-ref>` :math:`\REFEXNADDR~a`
..............................................................

* The store entry :math:`S.\SEXNS[a]` must exist.

* Then the value is valid with :ref:`reference type <syntax-reftype>` :math:`\EXNREF`.

.. math::
   \frac{
     S.\SEXNS[a] = \exninst
   }{
     S \vdashval \REFEXNADDR : \EXNREF
   }


:ref:`Function References <syntax-ref>` :math:`\REFFUNCADDR~a`
..............................................................

* The :ref:`function address <syntax-funcaddr>` :math:`a` must exist in the store.

* Let :math:`\funcinst` be the :ref:`function instance <syntax-funcinst>` :math:`S.\SFUNCS[a]`.

* Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`\funcinst.\FITYPE`.

* The :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` must be a :ref:`function type <syntax-functype>`.

* Then the value is valid with :ref:`reference type <syntax-reftype>` :math:`(\REF~\functype)`.

.. math::
   \frac{
     \deftype = S.\SFUNCS[a].\FITYPE
     \qquad
     \expanddt(\deftype) = \TFUNC~\functype
   }{
     S \vdashval \REFFUNCADDR~a : \REF~\deftype
   }


:ref:`Host References <syntax-ref.host>` :math:`\REFHOSTADDR~a`
...............................................................

* The value is valid with :ref:`reference type <syntax-reftype>` :math:`(\REF~\ANY)`.

.. math::
   \frac{
   }{
     S \vdashval \REFHOSTADDR~a : \REF~\ANY
   }

.. note::
   A host reference is considered internalized by this rule.


:ref:`External References <syntax-ref.extern>` :math:`\REFEXTERN~\reff`
.......................................................................

* The reference value :math:`\reff` must be valid with some :ref:`reference type <syntax-reftype>` :math:`(\REF~\NULL^?~t)`.

* The :ref:`heap type <syntax-heaptype>` :math:`t` must :ref:`match <match-heaptype>` the heap type |ANY|.

* Then the value is valid with :ref:`reference type <syntax-reftype>` :math:`(\REF~\NULL^?~\EXTERN)`.

.. math::
   \frac{
     S \vdashval \reff : \REF~\NULL^?~t
     \qquad
     \vdashheaptypematch t \matchesheaptype \ANY
   }{
     S \vdashval \REFEXTERN~\reff : \REF~\NULL^?~\EXTERN
   }

Subsumption
...........

* The value must be valid with some value type :math:`t`.

* The value type :math:`t` :ref:`matches <match-valtype>` another :ref:`valid <valid-valtype>` type :math:`t'`.

* Then the value is valid with type :math:`t'`.

.. math::
   \frac{
     S \vdashval \val : t
     \qquad
     \vdashvaltype t' \ok
     \qquad
     \vdashvaltypematch t \matchesvaltype t'
   }{
     S \vdashval \val : t'
   }


.. index:: external value, external type, validation, import, store
.. _valid-externval:

External Typing
~~~~~~~~~~~~~~~

For the purpose of checking :ref:`external values <syntax-externval>` against :ref:`imports <syntax-import>`,
such values are classified by :ref:`external types <syntax-externtype>`.
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


.. index:: tag type, tag address, exception tag, function type
.. _valid-externval-tag:

:math:`\EVTAG~a`
................

* The store entry :math:`S.\STAGS[a]` must exist.

* Let :math:`\tagtype` be the function type :math:`S.\STAGS[a].\TAGITYPE`.

* Then :math:`\EVTAG~a` is valid with :ref:`external type <syntax-externtype>` :math:`\ETTAG~\tagtype`.

.. math::
   \frac{
   }{
     S \vdashexternval \EVTAG~a : \ETTAG~S.\STAGS[a].\TAGITYPE
   }


Subsumption
...........

* The external value must be valid with some external type :math:`\X{et}`.

* The external type :math:`\X{et}` :ref:`matches <match-externtype>` another :ref:`valid <valid-externtype>` type :math:`\X{et'}`.

* Then the external value is valid with type :math:`\X{et'}`.

.. math::
   \frac{
     S \vdashexternval \externval : \X{et}
     \qquad
     \vdashexterntype \X{et'} \ok
     \qquad
     \vdashexterntypematch \X{et} \matchesexterntype \X{et'}
   }{
     S \vdashexternval \externval : \X{et'}
   }

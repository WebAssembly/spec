.. index:: value
.. exec-val:

Values
------

.. index:: value, value type, validation, structure, structure type, structure instance, array, array type, array instance, function, function type, function instance, null reference, scalar reference, store
.. _valid-val:

Value Typing
~~~~~~~~~~~~

For the purpose of checking argument :ref:`values <syntax-val>` against the parameter types of exported :ref:`functions <syntax-func>`,
values are classified by :ref:`value types <syntax-valtype>`.
The following auxiliary typing rules specify this typing relation relative to a :ref:`store <syntax-store>` :math:`S` in which possibly referenced :ref:`addresses <syntax-addr>` live.

${rule-ignore: Val_type/*}


.. _valid-num:

Numeric Values
..............

.. todo:: use generated prose

* The value is valid with :ref:`number type <syntax-numtype>` :math:`t`.

$${rule: Num_type}


.. _valid-vec:

Vector Values
.............

.. todo:: use generated prose

* The value is valid with :ref:`vector type <syntax-vectype>` :math:`t`.

$${rule: Vec_type}


.. _valid-ref:

Null References
...............

.. todo:: use generated prose

* The :ref:`heap type <syntax-heaptype>` must be :ref:`valid <valid-heaptype>` under the empty :ref:`context <context>`.

* Then the value is valid with :ref:`reference type <syntax-reftype>` :math:`(\REF~\NULL~t')`, where the :ref:`heap type <syntax-heaptype>` :math:`t'` is the least type that :ref:`matches <match-heaptype>` :math:`t`.

$${rule: Ref_type/null}

.. note::
   A null reference can be typed with any smaller type.
   In particular, that allows it to be typed with the least type in its respective hierarchy.
   That ensures that the value is compatible with any nullable type in that hierarchy.


.. _valid-ref.i31num:

Scalar References
.................

.. todo:: use generated prose

* The value is valid with :ref:`reference type <syntax-reftype>` :math:`(\REF~\I31)`.

$${rule: Ref_type/i31}


.. _valid-ref.struct:

Structure References
....................

.. todo:: use generated prose

* The :ref:`structure address <syntax-structaddr>` :math:`a` must exist in the store.

* Let :math:`\structinst` be the :ref:`structure instance <syntax-structinst>` :math:`S.\SSTRUCTS[a]`.

* Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`\structinst.\SITYPE`.

* The :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` must be a :ref:`struct type <syntax-structtype>`.

* Then the value is valid with :ref:`reference type <syntax-reftype>` :math:`(\REF~\deftype)`.

$${rule: Ref_type/struct}


.. _valid-ref.array:

Array References
................

.. todo:: use generated prose

* The :ref:`array address <syntax-arrayaddr>` :math:`a` must exist in the store.

* Let :math:`\arrayinst` be the :ref:`array instance <syntax-arrayinst>` :math:`S.\SARRAYS[a]`.

* Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`\arrayinst.\AITYPE`.

* The :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` must be an :ref:`array type <syntax-arraytype>`.

* Then the value is valid with :ref:`reference type <syntax-reftype>` :math:`(\REF~\arraytype)`.

$${rule: Ref_type/array}


.. _valid-ref.exn:

Exception References
....................

.. todo:: use generated prose

* The store entry :math:`S.\SEXNS[a]` must exist.

* Then the value is valid with :ref:`reference type <syntax-reftype>` :math:`\EXNREF`.

$${rule: Ref_type/exn}


Function References
...................

.. todo:: use generated prose

* The :ref:`function address <syntax-funcaddr>` :math:`a` must exist in the store.

* Let :math:`\funcinst` be the :ref:`function instance <syntax-funcinst>` :math:`S.\SFUNCS[a]`.

* Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`\funcinst.\FITYPE`.

* The :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` must be a :ref:`function type <syntax-functype>`.

* Then the value is valid with :ref:`reference type <syntax-reftype>` :math:`(\REF~\functype)`.

$${rule: Ref_type/func}


Host References
...............

.. todo:: use generated prose

* The value is valid with :ref:`reference type <syntax-reftype>` :math:`(\REF~\ANY)`.

$${rule: Ref_type/host}

.. note::
   A bare host reference is considered to be internalized.


External References
...................

.. todo:: use generated prose

* The reference value :math:`\reff` must be valid with some :ref:`reference type <syntax-reftype>` :math:`(\REF~\NULL^?~t)`.

* The :ref:`heap type <syntax-heaptype>` :math:`t` must :ref:`match <match-heaptype>` the heap type |ANY|.

* Then the value is valid with :ref:`reference type <syntax-reftype>` :math:`(\REF~\NULL^?~\EXTERN)`.

$${rule: Ref_type/extern}


Subsumption
...........

.. todo:: use generated prose

* The value must be valid with some value type :math:`t`.

* The value type :math:`t` :ref:`matches <match-valtype>` another :ref:`valid <valid-valtype>` type :math:`t'`.

* Then the value is valid with type :math:`t'`.

$${rule: Ref_type/sub}


.. index:: external address, external type, validation, import, store
.. _valid-externaddr:

External Typing
~~~~~~~~~~~~~~~

For the purpose of checking :ref:`external address <syntax-externaddr>` against :ref:`imports <syntax-import>`,
such values are classified by :ref:`external types <syntax-externtype>`.
The following auxiliary typing rules specify this typing relation relative to a :ref:`store <syntax-store>` :math:`S` in which the referenced instances live.


.. index:: function type, function address
.. _valid-externaddr-func:

Functions
.........

.. todo:: use generated prose

* The store entry :math:`S.\SFUNCS[a]` must exist.

* Then :math:`\XAFUNC~a` is valid with :ref:`external type <syntax-externtype>` :math:`\XTFUNC~S.\SFUNCS[a].\FITYPE`.

$${rule: Externaddr_type/func}


.. index:: table type, table address
.. _valid-externaddr-table:

Tables
......

.. todo:: use generated prose

* The store entry :math:`S.\STABLES[a]` must exist.

* Then :math:`\XATABLE~a` is valid with :ref:`external type <syntax-externtype>` :math:`\XTTABLE~S.\STABLES[a].\TITYPE`.

$${rule: Externaddr_type/table}


.. index:: memory type, memory address
.. _valid-externaddr-mem:

Memories
........

.. todo:: use generated prose

* The store entry :math:`S.\SMEMS[a]` must exist.

* Then :math:`\XAMEM~a` is valid with :ref:`external type <syntax-externtype>` :math:`\XTMEM~S.\SMEMS[a].\MITYPE`.

$${rule: Externaddr_type/mem}


.. index:: global type, global address, value type, mutability
.. _valid-externaddr-global:

Globals
.......

.. todo:: use generated prose

* The store entry :math:`S.\SGLOBALS[a]` must exist.

* Then :math:`\XAGLOBAL~a` is valid with :ref:`external type <syntax-externtype>` :math:`\XTGLOBAL~S.\SGLOBALS[a].\GITYPE`.

$${rule: Externaddr_type/global}


.. index:: tag type, tag address, exception tag, function type
.. _valid-externaddr-tag:

Tags
....

.. todo:: use generated prose

* The store entry :math:`S.\STAGS[a]` must exist.

* Let :math:`\tagtype` be the function type :math:`S.\STAGS[a].\HITYPE`.

* Then :math:`\XATAG~a` is valid with :ref:`external type <syntax-externtype>` :math:`\XTTAG~\tagtype`.

$${rule: Externaddr_type/tag}


Subsumption
...........

.. todo:: use generated prose

* The external address must be valid with some external type :math:`\X{et}`.

* The external type :math:`\X{et}` :ref:`matches <match-externtype>` another :ref:`valid <valid-externtype>` type :math:`\X{et'}`.

* Then the external address is valid with type :math:`\X{et'}`.

$${rule: Externaddr_type/sub}

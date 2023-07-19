.. _valid-type:

Types
-----

Simple :ref:`types <syntax-type>`, such as :ref:`number types <syntax-numtype>` are universally valid.
However, restrictions apply to most other types, such as :ref:`reference types <syntax-reftype>`, :ref:`function types <syntax-functype>`, as well as the :ref:`limits <syntax-limits>` of :ref:`table types <syntax-tabletype>` and :ref:`memory types <syntax-memtype>`, which must be checked during validation.

Moreover, :ref:`block types <syntax-blocktype>` are converted to plain :ref:`function types <syntax-functype>` for ease of processing.


.. index:: number type
   pair: validation; number type
   single: abstract syntax; number type
.. _valid-numtype:

Number Types
~~~~~~~~~~~~

:ref:`Number types <syntax-numtype>` are always valid.

.. math::
   \frac{
   }{
     C \vdashnumtype \numtype \ok
   }


.. index:: vector type
   pair: validation; vector type
   single: abstract syntax; vector type
.. _valid-vectype:

Vector Types
~~~~~~~~~~~~

:ref:`Vector types <syntax-vectype>` are always valid.

.. math::
   \frac{
   }{
     C \vdashvectype \vectype \ok
   }


.. index:: heap type, type identifier
   pair: validation; heap type
   single: abstract syntax; heap type
.. _valid-heaptype:

Heap Types
~~~~~~~~~~

Concrete :ref:`Heap types <syntax-heaptype>` are only valid when the :ref:`type index <syntax-typeidx>` is.

:math:`\absheaptype`
....................

* The heap type is valid.

.. math::
   \frac{
   }{
     C \vdashheaptype \absheaptype \ok
   }

:math:`\typeidx`
................

* The type :math:`C.\CTYPES[\typeidx]` must be defined in the context.

* Then the heap type is valid.

.. math::
   \frac{
     C.\CTYPES[\typeidx] = \deftype
   }{
     C \vdashheaptype \typeidx \ok
   }

:math:`\BOTH`
.............

* The heap type is valid.

.. math::
   \frac{
   }{
     C \vdashheaptype \BOTH \ok
   }


.. index:: reference type, heap type
   pair: validation; reference type
   single: abstract syntax; reference type
.. _valid-reftype:

Reference Types
~~~~~~~~~~~~~~~

:ref:`Reference types <syntax-reftype>` are valid when the referenced :ref:`heap type <syntax-heaptype>` is.

:math:`\REF~\NULL^?~\heaptype`
..............................

* The heap type :math:`\heaptype` must be :ref:`valid <valid-heaptype>`.

* Then the reference type is valid.

.. math::
   \frac{
     C \vdashreftype \heaptype \ok
   }{
     C \vdashreftype \REF~\NULL^?~\heaptype \ok
   }


.. index:: value type, reference type, heap type, bottom type
   pair: validation; value type
   single: abstract syntax; value type
.. _valid-valtype:
.. _valid-valtype-bot:

Value Types
~~~~~~~~~~~

Valid :ref:`value types <syntax-valtype>` are either valid :ref:`number type <valid-numtype>`,  :ref:`reference type <valid-reftype>`, or the :ref:`bottom type <syntax-valtype-ext>`.

:math:`\BOT`
............

* The value type is valid.

.. math::
   \frac{
   }{
     C \vdashvaltype \BOT \ok
   }


.. index:: block type, instruction type
   pair: validation; block type
   single: abstract syntax; block type
.. _valid-blocktype:

Block Types
~~~~~~~~~~~

:ref:`Block types <syntax-blocktype>` may be expressed in one of two forms, both of which are converted to :ref:`instruction types <syntax-instrtype>` by the following rules.

:math:`\typeidx`
................

* The type :math:`C.\CTYPES[\typeidx]` must be defined in the context.

* Let :math:`[t_1^\ast] \toF [t_2^\ast]` be the :ref:`function type <syntax-functype>` :math:`C.\CTYPES[\typeidx]`.

* Then the block type is valid as :ref:`instruction type <syntax-instrtype>` :math:`[t_1^\ast] \to [t_2^\ast]`.

.. math::
   \frac{
     C.\CTYPES[\typeidx] = \TFUNC~[t_1^\ast] \toF [t_2^\ast]
   }{
     C \vdashblocktype \typeidx : [t_1^\ast] \to [t_2^\ast]
   }


:math:`[\valtype^?]`
....................

* The value type :math:`\valtype` must either be absent, or :ref:`valid <valid-valtype>`.

* Then the block type is valid as :ref:`instruction type <syntax-instrtype>` :math:`[] \to [\valtype^?]`.

.. math::
   \frac{
     (C \vdashvaltype \valtype \ok)^?
   }{
     C \vdashblocktype [\valtype^?] : [] \to [\valtype^?]
   }


.. index:: result type, value type
   pair: validation; result type
   single: abstract syntax; result type
.. _valid-resulttype:

Result Types
~~~~~~~~~~~~

:math:`[t^\ast]`
................

* Each :ref:`value type <syntax-valtype>` :math:`t_i` in the type sequence :math:`t^\ast` must be :ref:`valid <valid-valtype>`.

* Then the result type is valid.

.. math::
   \frac{
     (C \vdashvaltype t \ok)^\ast
   }{
     C \vdashresulttype [t^\ast] \ok
   }


.. index:: instruction type
   pair: validation; instruction type
   single: abstract syntax; instruction type
.. _valid-instrtype:

Instruction Types
~~~~~~~~~~~~~~~~~

:math:`[t_1^\ast] \rightarrow_{x^\ast} [t_2^\ast]`
..................................................

* The :ref:`result type <syntax-resulttype>` :math:`[t_1^\ast]` must be :ref:`valid <valid-resulttype>`.

* The :ref:`result type <syntax-resulttype>` :math:`[t_2^\ast]` must be :ref:`valid <valid-resulttype>`.

* Each :ref:`local index <syntax-localidx>` :math:`x_i` in :math:`x^\ast` must be defined in the context.

* Then the instruction type is valid.

.. math::
   \frac{
     C \vdashvaltype [t_1^\ast] \ok
     \qquad
     C \vdashvaltype [t_2^\ast] \ok
     \qquad
     (C.\CLOCALS[x] = \localtype)^\ast
   }{
     C \vdashfunctype [t_1^\ast] \toX{x^\ast} [t_2^\ast] \ok
   }


.. index:: function type
   pair: validation; function type
   single: abstract syntax; function type
.. _valid-functype:

Function Types
~~~~~~~~~~~~~~

:math:`[t_1^\ast] \toF [t_2^\ast]`
..................................

* The :ref:`result type <syntax-resulttype>` :math:`[t_1^\ast]` must be :ref:`valid <valid-resulttype>`.

* The :ref:`result type <syntax-resulttype>` :math:`[t_2^\ast]` must be :ref:`valid <valid-resulttype>`.

* Then the function type is valid.

.. math::
   \frac{
     C \vdashvaltype [t_1^\ast] \ok
     \qquad
     C \vdashvaltype [t_2^\ast] \ok
   }{
     C \vdashfunctype [t_1^\ast] \toF [t_2^\ast] \ok
   }


.. index:: compound type, function type, aggregate type, structure type, array type, field type
   pair: validation; compound type
   pair: validation; aggregate type
   pair: validation; structure type
   pair: validation; array type
   single: abstract syntax; compound type
   single: abstract syntax; function type
   single: abstract syntax; structure type
   single: abstract syntax; array type
   single: abstract syntax; field type
.. _valid-comptype:
.. _valid-aggrtype:
.. _valid-structtype:
.. _valid-arraytype:

Compound Types
~~~~~~~~~~~~~~

:math:`\TFUNC~\functype`
........................

* The :ref:`function type <syntax-functype>` :math:`\functype` must be :ref:`valid <valid-functype>`.

* Then the compound type is valid.

.. math::
   \frac{
     C \vdashfunctype \functype \ok
   }{
     C \vdashcomptype \TFUNC~\functype \ok
   }

:math:`\TSTRUCT~\fieldtype^\ast`
................................

* For each :ref:`field type <syntax-fieldtype>` :math:`\fieldtype_i` in :math:`\fieldtype^\ast`:

  * The :ref:`field type <syntax-fieldtype>` :math:`\fieldtype_i` must be :ref:`valid <valid-fieldtype>`.

* Then the compound type is valid.

.. math::
   \frac{
     (C \vdashfieldtype \X{ft} \ok)^\ast
   }{
     C \vdashcomptype \TSTRUCT~\X{ft}^\ast \ok
   }

:math:`\TARRAY~\fieldtype`
..........................

* The :ref:`field type <syntax-fieldtype>` :math:`\fieldtype` must be :ref:`valid <valid-fieldtype>`.

* Then the compound type is valid.

.. math::
   \frac{
     C \vdashfieldtype \X{ft} \ok
   }{
     C \vdashcomptype \TARRAY~\X{ft} \ok
   }


.. index:: field type, storage type, packed type, value type, mutability
   pair: validation; field type
   pair: validation; storage type
   pair: validation; packed type
   single: abstract syntax; field type
   single: abstract syntax; storage type
   single: abstract syntax; packed type
   single: abstract syntax; value type
.. _valid-fieldtype:
.. _valid-storagetype:
.. _valid-packedtype:

Field Types
~~~~~~~~~~~

:math:`\mut~\storagetype`
.........................

* The :ref:`storage type <syntax-storagetype>` :math:`\storagetype` must be :ref:`valid <valid-storagetype>`.

* Then the field type is valid.

.. math::
   \frac{
     C \vdashstoragetype \X{st} \ok
   }{
     C \vdashfieldtype \mut~\X{st} \ok
   }

:math:`\packedtype`
...................

* The packed type is valid.

.. math::
   \frac{
   }{
     C \vdashpackedtype \packedtype \ok
   }


.. index:: recursive type, sub type, compound type, final, subtyping
   pair: abstract syntax; recursive type
   pair: abstract syntax; sub type
.. _valid-rectype:
.. _valid-subtype:

Recursive Types
~~~~~~~~~~~~~~~

:ref:`Recursive types <syntax-rectype>` are validated for a specific :ref:`type index <syntax-typeidx>` that denotes the index of the type defined by the recursive group.

:math:`\TREC~\subtype^\ast`
...........................

.. todo:: add version of this for extended type syntax to appendix

* Either the sequence :math:`\subtype^\ast` is empty.

* Or:

  * The first :ref:`sub type <syntax-subtype>` of the sequence :math:`\subtype^\ast` must be :ref:`valid <valid-subtype>` for the :ref:`type index <syntax-typeidx>` :math:`x`.

  * The remaining sequence :math:`\subtype^\ast` must be :ref:`valid <valid-rectype>` for the :ref:`type index <syntax-typeidx>` :math:`x + 1`.

* Then the recursive type is valid for the :ref:`type index <syntax-typeidx>` :math:`x`.

.. math::
   \frac{
   }{
     C \vdashrectype \TREC~\epsilon ~{\ok}(x)
   }
   \qquad
   \frac{
     C \vdashsubtype \subtype ~{\ok}(x)
     \qquad
     C \vdashrectype \TREC~{\subtype'}^\ast ~{\ok}(x + 1)
   }{
     C \vdashrectype \TREC~\subtype~{\subtype'}^\ast ~{\ok}(x)
   }

:math:`\TSUB~\TFINAL^?~y^\ast~\comptype`
........................................

* The :ref:`compound type <syntax-comptype>` :math:`\comptype` must be :ref:`valid <valid-comptype>`.

* The sequence :math:`y^\ast` may be no longer than :math:`1`.

* For every :ref:`type index <syntax-typeidx>` :math:`y_i` in :math:`y^\ast`:

  * The :ref:`type index <syntax-typeidx>` :math:`y_i` must be smaller than :math:`x`.

  * The :ref:`type index <syntax-typeidx>` :math:`y_i` must exist in the context :math:`C`.

  * Let :math:`\subtype_i` be the :ref:`unrolling <aux-unroll-deftype>` of the :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[y_i]`.

  * The :ref:`sub type <syntax-subtype>` :math:`\subtype_i` must not contain :math:`\TFINAL`.

  * Let :math:`\comptype'_i` be the :ref:`expansion <aux-expand-deftype>` of the :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[y_i]`.

  * The :ref:`compound type <syntax-comptype>` :math:`\comptype` must :ref:`match <match-comptype>` :math:`\comptype'_i`.

* Then the sub type is valid for the :ref:`type index <syntax-typeidx>` :math:`x`.

.. math::
   \frac{
     \begin{array}{@{}c@{}}
     |y^\ast| \leq 1
     \qquad
     (y < x)^\ast
     \qquad
     (\unrolldt(C.\CTYPES[y]) = \TSUB~{y'}^\ast~\comptype')^\ast
     \\
     C \vdashcomptype \comptype \ok
     \qquad
     (C \vdashcomptypematch \comptype \matchescomptype \comptype')^\ast
     \end{array}
   }{
     C \vdashsubtype \TSUB~\TFINAL^?~y^\ast~\comptype ~{\ok}(x)
   }

.. note::
   The side condition on the index ensures that a declared supertype is a previously defined types,
   preventing cyclic subtype hierarchies.

   Future versions of WebAssembly may allow more than one supertype.


.. index:: defined type, recursive type, unroll, expand
   pair: abstract syntax; defined type
.. _valid-deftype:

Defined Types
~~~~~~~~~~~~~

:math:`\rectype.i`
..................

* The :ref:`recursive type <syntax-rectype>` :math:`\rectype` must be :ref:`valid <valid-rectype>` for some :ref:`type index <syntax-typeidx>` :math:`x`.

* Let :math:`\TREC~\subtype^\ast` be the :ref:`defined type <syntax-rectype>` :math:`\rectype`.

* The number :math:`i` must be smaller than the length of the sequence :math:`\subtype^\ast` of :ref:`sub types <syntax-subtype>`.

* Then the defined type is valid.

.. math::
   \frac{
     C \vdashrectype \rectype ~{\ok}(x)
     \qquad
     \rectype = \TREC~\subtype^n
     \qquad
     i < n
   }{
     C \vdashdeftype \rectype.i \ok
   }


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
     C \vdashlimits \{ \LMIN~n, \LMAX~m^? \} : k
   }


.. index:: table type, reference type, limits
   pair: validation; table type
   single: abstract syntax; table type
.. _valid-tabletype:

Table Types
~~~~~~~~~~~

:math:`\limits~\reftype`
........................

* The limits :math:`\limits` must be :ref:`valid <valid-limits>` within range :math:`2^{32}-1`.

* The reference type :math:`\reftype` must be :ref:`valid <valid-reftype>`.

* Then the table type is valid.

.. math::
   \frac{
     C \vdashlimits \limits : 2^{32} - 1
     \qquad
     C \vdashreftype \reftype \ok
   }{
     C \vdashtabletype \limits~\reftype \ok
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
     C \vdashlimits \limits : 2^{16}
   }{
     C \vdashmemtype \limits \ok
   }


.. index:: global type, value type, mutability
   pair: validation; global type
   single: abstract syntax; global type
.. _valid-globaltype:

Global Types
~~~~~~~~~~~~

:math:`\mut~\valtype`
.....................

* The value type :math:`\valtype` must be :ref:`valid <valid-valtype>`.

* Then the global type is valid.

.. math::
   \frac{
     C \vdashreftype \valtype \ok
   }{
     C \vdashglobaltype \mut~\valtype \ok
   }


.. index:: external type, function type, table type, memory type, global type
   pair: validation; external type
   single: abstract syntax; external type
.. _valid-externtype:

External Types
~~~~~~~~~~~~~~

:math:`\ETFUNC~\deftype`
........................

* The :ref:`defined type <syntax-deftype>` :math:`\deftype` must be :ref:`valid <valid-deftype>`.

* The :ref:`defined type <syntax-deftype>` :math:`\deftype` must be a :ref:`function type <syntax-functype>`.

* Then the external type is valid.

.. math::
   \frac{
     C \vdashdeftype \deftype \ok
     \qquad
     \expanddt(\deftype) = \TFUNC~\functype
   }{
     C \vdashexterntype \ETFUNC~\deftype
   }

:math:`\ETTABLE~\tabletype`
...........................

* The :ref:`table type <syntax-tabletype>` :math:`\tabletype` must be :ref:`valid <valid-tabletype>`.

* Then the external type is valid.

.. math::
   \frac{
     C \vdashtabletype \tabletype \ok
   }{
     C \vdashexterntype \ETTABLE~\tabletype \ok
   }

:math:`\ETMEM~\memtype`
.......................

* The :ref:`memory type <syntax-memtype>` :math:`\memtype` must be :ref:`valid <valid-memtype>`.

* Then the external type is valid.

.. math::
   \frac{
     C \vdashmemtype \memtype \ok
   }{
     C \vdashexterntype \ETMEM~\memtype \ok
   }

:math:`\ETGLOBAL~\globaltype`
.............................

* The :ref:`global type <syntax-globaltype>` :math:`\globaltype` must be :ref:`valid <valid-globaltype>`.

* Then the external type is valid.

.. math::
   \frac{
     C \vdashglobaltype \globaltype \ok
   }{
     C \vdashexterntype \ETGLOBAL~\globaltype \ok
   }


.. index:: value type, ! defaultable, number type, vector type, reference type, table type
.. _valid-defaultable:

Defaultable Types
~~~~~~~~~~~~~~~~~

A type is *defaultable* if it has a :ref:`default value <default-val>` for initialization.

Value Types
...........

* A defaultable :ref:`value type <syntax-valtype>` :math:`t` must be:

  - either a :ref:`number type <syntax-numtype>`,

  - or a :ref:`vector type <syntax-vectype>`,

  - or a :ref:`nullable reference type <syntax-numtype>`.


.. math::
   \frac{
   }{
     C \vdashvaltypedefaultable \numtype \defaultable
   }

.. math::
   \frac{
   }{
     C \vdashvaltypedefaultable \vectype \defaultable
   }

.. math::
   \frac{
   }{
     C \vdashvaltypedefaultable (\REF~\NULL~\heaptype) \defaultable
   }

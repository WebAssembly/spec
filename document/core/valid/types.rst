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

:math:`\FUNC`
.............

* The heap type is valid.

.. math::
   \frac{
   }{
     C \vdashheaptype \FUNC \ok
   }

:math:`\EXTERN`
...............

* The heap type is valid.

.. math::
   \frac{
   }{
     C \vdashheaptype \EXTERN \ok
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

:math:`\BOT`
............

* The heap type is valid.

.. math::
   \frac{
   }{
     C \vdashheaptype \BOT \ok
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
.. _valid-bottype:

Value Types
~~~~~~~~~~~

Valid :ref:`value types <syntax-valtype>` are either valid :ref:`number type <valid-numtype>`,  :ref:`reference type <valid-reftype>`, or the :ref:`bottom type <syntax-bottype>`.

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
     \expand(C.\CTYPES[\typeidx]) = \TFUNC~[t_1^\ast] \toF [t_2^\ast]
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
.. _valid-deftype:

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
     \expand(\deftype) = \TFUNC~\functype
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

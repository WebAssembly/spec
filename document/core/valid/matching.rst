.. index:: ! matching, ! subtyping
.. _subtyping:
.. _match:

Matching
--------

On most types, a simple notion of *subtyping* is defined that is applicable in validation rules or during :ref:`module instantiation <exec-instantiation>` when checking the types of imports.


.. index:: number type
.. _match-numtype:

Number Types
~~~~~~~~~~~~

A :ref:`number type <syntax-numtype>` :math:`\numtype_1` matches a :ref:`number type <syntax-numtype>` :math:`\numtype_2` if and only if:

* Both :math:`\numtype_1` and :math:`\numtype_2` are the same.

.. math::
   ~\\[-1ex]
   \frac{
   }{
     C \vdashnumtypematch \numtype \matchesvaltype \numtype
   }


.. index:: vector type
.. _match-vectype:

Vector Types
~~~~~~~~~~~~

A :ref:`vector type <syntax-vectype>` :math:`\vectype_1` matches a :ref:`vector type <syntax-vectype>` :math:`\vectype_2` if and only if:

* Both :math:`\vectype_1` and :math:`\vectype_2` are the same.

.. math::
   ~\\[-1ex]
   \frac{
   }{
     C \vdashvectypematch \vectype \matchesvaltype \vectype
   }


.. index:: heap type
.. _match-heaptype:

Heap Types
~~~~~~~~~~

A :ref:`heap type <syntax-heaptype>` :math:`\heaptype_1` matches a :ref:`heap type <syntax-heaptype>` :math:`\heaptype_2` if and only if:

* Either both :math:`\heaptype_1` and :math:`\heaptype_2` are the same.

* Or :math:`\heaptype_1` is a :ref:`function type <syntax-functype>` and :math:`\heaptype_2` is :math:`\FUNC`.

* Or :math:`\heaptype_1` is a :ref:`function type <syntax-functype>` :math:`\functype_1` and :math:`\heaptype_2` is a :ref:`function type <syntax-functype>` :math:`\functype_2`, and :math:`\functype_1` :ref:`matches <match-functype>` :math:`\functype_2`.

* Or :math:`\heaptype_1` is a :ref:`type index <syntax-typeidx>` :math:`x_1`, and :math:`C.\CTYPES[x_1]` :ref:`matches <match-heaptype>` :math:`\heaptype_2`.

* Or :math:`\heaptype_2` is a :ref:`type index <syntax-typeidx>` :math:`x_2`, and :math:`\heaptype_1` :ref:`matches <match-heaptype>` :math:`C.\CTYPES[x_2]`.

.. math::
   ~\\[-1ex]
   \frac{
   }{
     C \vdashheaptypematch \heaptype \matchesheaptype \heaptype
   }
   \qquad
   \frac{
   }{
     C \vdashheaptypematch \functype \matchesheaptype \FUNC
   }

.. math::
   ~\\[-1ex]
   \frac{
     C \vdashfunctypematch \functype_1 \matchesfunctype \functype_2
   }{
     C \vdashheaptypematch \functype_1 \matchesheaptype \functype_2
   }

.. math::
   ~\\[-1ex]
   \frac{
     C \vdashheaptypematch C.\CTYPES[\typeidx_1] \matchesheaptype \heaptype_2
   }{
     C \vdashheaptypematch \typeidx_1 \matchesheaptype \heaptype_2
   }
   \qquad
   \frac{
     C \vdashheaptypematch \heaptype_1 \matchesheaptype C.\CTYPES[\typeidx_2]
   }{
     C \vdashheaptypematch \heaptype_1 \matchesheaptype \typeidx_2
   }



.. index:: reference type
.. _match-reftype:

Reference Types
~~~~~~~~~~~~~~~

A :ref:`reference type <syntax-reftype>` :math:`\REF~\NULL_1^?~heaptype_1` matches a :ref:`reference type <syntax-reftype>` :math:`\REF~\NULL_2^?~heaptype_2` if and only if:

* The :ref:`heap type <syntax-heaptype>` :math:`\heaptype_1` :ref:`matches <match-heaptype>` :math:`\heaptype_2`.

* :math:`\NULL_1` is absent or :math:`\NULL_2` is present.

.. math::
   ~\\[-1ex]
   \frac{
     C \vdashheaptypematch \heaptype_1 \matchesheaptype \heaptype_2
   }{
     C \vdashreftypematch \REF~\heaptype_1 \matchesreftype \REF~\heaptype_2
   }
   \qquad
   \frac{
     C \vdashheaptypematch \heaptype_1 \matchesheaptype \heaptype_2
   }{
     C \vdashreftypematch \REF~\NULL^?~\heaptype_1 \matchesreftype \REF~\NULL~\heaptype_2
   }


.. index:: value type, number type, reference type
.. _match-valtype:

Value Types
~~~~~~~~~~~

A :ref:`value type <syntax-valtype>` :math:`\valtype_1` matches a :ref:`value type <syntax-valtype>` :math:`\valtype_2` if and only if:

* Either both :math:`\valtype_1` and :math:`\valtype_2` are :ref:`number types <syntax-numtype>` and :math:`\valtype_1` :ref:`matches <match-numtype>` :math:`\valtype_2`.

* Or both :math:`\valtype_1` and :math:`\valtype_2` are :ref:`reference types <syntax-reftype>` and :math:`\valtype_1` :ref:`matches <match-reftype>` :math:`\valtype_2`.

* Or :math:`\valtype_1` is :math:`\BOT`.

.. math::
   ~\\[-1ex]
   \frac{
   }{
     C \vdashvaltypematch \BOT \matchesvaltype \valtype
   }


.. index:: result type, value type
.. _match-resulttype:

Result Types
~~~~~~~~~~~~

Subtyping is lifted to :ref:`result types <syntax-resulttype>` in a pointwise manner.
That is, a :ref:`result type <syntax-resulttype>` :math:`[t_1^\ast]` matches a :ref:`result type <syntax-resulttype>` :math:`[t_2^\ast]` if and only if:

* Every :ref:`value type <syntax-valtype>` :math:`t_1` in :math:`[t_1^\ast]` :ref:`matches <match-valtype>` the corresponding :ref:`value type <syntax-valtype>` :math:`t_2` in :math:`[t_2^\ast]`.

.. math::
   ~\\[-1ex]
   \frac{
     (C \vdashvaltypematch t_1 \matchesvaltype t_2)^\ast
   }{
     C \vdashresulttypematch [t_1^\ast] \matchesresulttype [t_2^\ast]
   }


.. index:: instruction type, result type
.. _match-instrtype:

Instruction Types
~~~~~~~~~~~~~~~~~

Subtyping is further lifted to :ref:`instruction types <syntax-instrtype>`.
An :ref:`instruction type <syntax-instrtype>` :math:`[t_{11}^\ast] \toX{x_1^\ast} [t_{12}^\ast]` matches a type :math:`[t_{21}^ast] \toX{x_2^\ast} [t_{22}^\ast]` if and only if:

* There is a common sequence of :ref:`value types <syntax-valtype>` :math:`t^\ast` such that :math:`t_{21}^\ast` equals :math:`t^\ast~{t'_{21}}^\ast` and :math:`t_{22}^\ast` equals :math:`t^\ast~{t'_{22}}^\ast`.

* The :ref:`result type <syntax-resulttype>` :math:`[{t'_{21}}^\ast]` :ref:`matches <match-resulttype>` :math:`[t_{11}^\ast]`.

* The :ref:`result type <syntax-resulttype>` :math:`[t_{12}^\ast]` :ref:`matches <match-resulttype>` :math:`[{t'_{22}}^\ast]`.

* For every :ref:`local index <syntax-localidx>` :math:`x` that is in :math:`x_2^\ast` but not in :math:`x_1^\ast`, the :ref:`local type <syntax-localtype>` :math:`C.\CLOCALS[x]` is :math:`\SET~t_x` for some :ref:`value type <syntax-valtype>` :math:`t_x`.

.. math::
   ~\\[-1ex]
   \frac{
     \begin{array}{@{}c@{\qquad}l@{}}
     C \vdashresulttypematch [t_{21}^\ast] \matchesresulttype [t_{11}^\ast]
     &
     \{ x^\ast \} = \{ x_2^\ast \} \setminus \{ x_1^\ast \}
     \\
     C \vdashresulttypematch [t_{12}^\ast] \matchesresulttype [t_{22}^\ast]
     &
     (C.\CLOCALS[x] = \SET~t_x)^\ast
     \end{array}
   }{
     C \vdashinstrtypematch [t_{11}^\ast] \toX{x_1^\ast} [t_{12}^\ast] \matchesinstrtype [t^\ast~t_{21}^\ast] \toX{x_2^\ast} [t^\ast~t_{22}^\ast]
   }

.. note::
   Instruction types are contravariant in their input and covariant in their output.
   Subtyping also incorporates a sort of "frame" condition, which allows adding arbitrary invariant stack elements on both sides in the super type.

   Finally, the supertype may ignore variables from the init set :math:`x_1^\ast`.
   It may also *add* variables to the init set, provided these are already set in the context, i.e., are vacuously initialized.


.. index:: function type, result type
.. _match-functype:

Function Types
~~~~~~~~~~~~~~

Subtyping is also defined for :ref:`function types <syntax-functype>`.
However, it is required that they match in both directions, effectively demanding type equivalence.
That is, a :ref:`function type <syntax-functype>` :math:`[t_{11}^\ast] \toF [t_{12}^\ast]` matches a type :math:`[t_{21}^ast] \toF [t_{22}^\ast]` if and only if:

* The :ref:`result type <syntax-resulttype>` :math:`[t_{11}^\ast]` :ref:`matches <match-resulttype>` :math:`[t_{21}^\ast]`, and vice versa.

* The :ref:`result type <syntax-resulttype>` :math:`[t_{12}^\ast]` :ref:`matches <match-resulttype>` :math:`[t_{22}^\ast]`, and vice versa.

.. math::
   ~\\[-1ex]
   \frac{
     \begin{array}{@{}c@{}}
     C \vdashresulttypematch [t_{11}^\ast] \matchesresulttype [t_{21}^\ast]
     \qquad
     C \vdashresulttypematch [t_{12}^\ast] \matchesresulttype [t_{22}^\ast]
     \\
     C \vdashresulttypematch [t_{21}^\ast] \matchesresulttype [t_{11}^\ast]
     \qquad
     C \vdashresulttypematch [t_{22}^\ast] \matchesresulttype [t_{12}^\ast]
     \end{array}
   }{
     C \vdashfunctypematch [t_{11}^\ast] \toF [t_{12}^\ast] \matchesfunctype [t_{21}^\ast] \toF [t_{22}^\ast]
   }

.. note::
   In future versions of WebAssembly, subtyping on function types may be relaxed to support co- and contra-variance.


.. index:: limits
.. _match-limits:

Limits
~~~~~~

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
     C \vdashlimitsmatch \{ \LMIN~n_1, \LMAX~m_1^? \} \matcheslimits \{ \LMIN~n_2, \LMAX~\epsilon \}
   }
   \quad
   \frac{
     n_1 \geq n_2
     \qquad
     m_1 \leq m_2
   }{
     C \vdashlimitsmatch \{ \LMIN~n_1, \LMAX~m_1 \} \matcheslimits \{ \LMIN~n_2, \LMAX~m_2 \}
   }


.. index:: table type, limits, element type
.. _match-tabletype:

Table Types
~~~~~~~~~~~

A :ref:`table type <syntax-tabletype>` :math:`(\limits_1~\reftype_1)` matches :math:`(\limits_2~\reftype_2)` if and only if:

* Limits :math:`\limits_1` :ref:`match <match-limits>` :math:`\limits_2`.

* The :ref:`reference type <syntax-reftype>` :math:`\reftype_1` :ref:`matches <match-reftype>` :math:`\reftype_2`, and vice versa.

.. math::
   ~\\[-1ex]
   \frac{
     C \vdashlimitsmatch \limits_1 \matcheslimits \limits_2
     \qquad
     C \vdashreftypematch \reftype_1 \matchesreftype \reftype_2
     \qquad
     C \vdashreftypematch \reftype_2 \matchesreftype \reftype_1
   }{
     C \vdashtabletypematch \limits_1~\reftype_1 \matchestabletype \limits_2~\reftype_2
   }


.. index:: memory type, limits
.. _match-memtype:

Memory Types
~~~~~~~~~~~~

A :ref:`memory type <syntax-memtype>` :math:`\limits_1` matches :math:`\limits_2` if and only if:

* Limits :math:`\limits_1` :ref:`match <match-limits>` :math:`\limits_2`.


.. math::
   ~\\[-1ex]
   \frac{
     C \vdashlimitsmatch \limits_1 \matcheslimits \limits_2
   }{
     C \vdashmemtypematch \limits_1 \matchesmemtype \limits_2
   }


.. index:: global type, value type, mutability
.. _match-globaltype:

Global Types
~~~~~~~~~~~~

A :ref:`global type <syntax-globaltype>` :math:`(\mut_1~t_1)` matches :math:`(\mut_2~t_2)` if and only if:

* Either both :math:`\mut_1` and :math:`\mut_2` are |MVAR| and :math:`t_1` :ref:`matches <match-valtype>` :math:`t_2` and vice versa.

* Or both :math:`\mut_1` and :math:`\mut_2` are |MCONST| and :math:`t_1` :ref:`matches <match-valtype>` :math:`t_2`.

.. math::
   ~\\[-1ex]
   \frac{
     C \vdashvaltypematch t_1 \matchesvaltype t_2
     \qquad
     C \vdashvaltypematch t_2 \matchesvaltype t_1
   }{
     C \vdashglobaltypematch \MVAR~t_1 \matchesglobaltype \MVAR~t_2
   }
   \qquad
   \frac{
     C \vdashvaltypematch t_1 \matchesvaltype t_2
   }{
     C \vdashglobaltypematch \MCONST~t_1 \matchesglobaltype \MCONST~t_2
   }


.. index:: external type, function type, table type, memory type, global type
.. _match-externtype:

External Types
~~~~~~~~~~~~~~

Functions
.........

An :ref:`external type <syntax-externtype>` :math:`\ETFUNC~\functype_1` matches :math:`\ETFUNC~\functype_2` if and only if:

* The :ref:`function type <syntax-functype>` :math:`\functype_1` :ref:`matches <match-functype>` :math:`\functype_2`.

.. math::
   ~\\[-1ex]
   \frac{
     C \vdashfunctypematch \functype_1 \matchesfunctype \functype_2
   }{
     C \vdashexterntypematch \ETFUNC~\functype_1 \matchesexterntype \ETFUNC~\functype_2
   }


Tables
......

An :ref:`external type <syntax-externtype>` :math:`\ETTABLE~\tabletype_1` matches :math:`\ETTABLE~\tabletype_2` if and only if:

* Table type :math:`\tabletype_1` :ref:`matches <match-tabletype>` :math:`\tabletype_2`.

.. math::
   ~\\[-1ex]
   \frac{
     C \vdashtabletypematch \tabletype_1 \matchestabletype \tabletype_2
   }{
     C \vdashexterntypematch \ETTABLE~\tabletype_1 \matchesexterntype \ETTABLE~\tabletype_2
   }


Memories
........

An :ref:`external type <syntax-externtype>` :math:`\ETMEM~\memtype_1` matches :math:`\ETMEM~\memtype_2` if and only if:

* Memory type :math:`\memtype_1` :ref:`matches <match-memtype>` :math:`\memtype_2`.

.. math::
   ~\\[-1ex]
   \frac{
     C \vdashmemtypematch \memtype_1 \matchesmemtype \memtype_2
   }{
     C \vdashexterntypematch \ETMEM~\memtype_1 \matchesexterntype \ETMEM~\memtype_2
   }


Globals
.......

An :ref:`external type <syntax-externtype>` :math:`\ETGLOBAL~\globaltype_1` matches :math:`\ETGLOBAL~\globaltype_2` if and only if:

* Global type :math:`\globaltype_1` :ref:`matches <match-globaltype>` :math:`\globaltype_2`.

.. math::
   ~\\[-1ex]
   \frac{
     C \vdashglobaltypematch \globaltype_1 \matchesglobaltype \globaltype_2
   }{
     C \vdashexterntypematch \ETGLOBAL~\globaltype_1 \matchesexterntype \ETGLOBAL~\globaltype_2
   }

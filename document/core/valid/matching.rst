.. index:: ! matching, ! subtyping
.. _subtyping:
.. _match:

Matching
--------

On most types, a notion of *subtyping* is defined that is applicable in :ref:`validation <valid>` rules, during :ref:`module instantiation <exec-instantiation>` when checking the types of imports, or during :ref:`execution <exec>`, when performing casts.


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
     C \vdashnumtypematch \numtype \matchesnumtype \numtype
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
     C \vdashvectypematch \vectype \matchesvectype \vectype
   }


.. index:: heap type, defined type, structure type, array type, function type, unboxed scalar type
.. _match-heaptype:

Heap Types
~~~~~~~~~~

A :ref:`heap type <syntax-heaptype>` :math:`\heaptype_1` matches a :ref:`heap type <syntax-heaptype>` :math:`\heaptype_2` if and only if:

* Either both :math:`\heaptype_1` and :math:`\heaptype_2` are the same.

* Or there exists a :ref:`valid <valid-heaptype>` :ref:`heap type <syntax-heaptype>` :math:`\heaptype'`, such that :math:`\heaptype_1` :ref:`matches <match-heaptype>` :math:`\heaptype'` and :math:`\heaptype'` :ref:`matches <match-heaptype>` :math:`\heaptype_2`.

* Or :math:`heaptype_1` is :math:`\EQT` and :math:`\heaptype_2` is :math:`\ANY`.

* Or :math:`\heaptype_1` is one of :math:`\I31`, :math:`\STRUCT`, or :math:`\ARRAY` and :math:`heaptype_2` is :math:`\EQT`.

* Or :math:`\heaptype_1` is a :ref:`defined type <syntax-deftype>` which :ref:`expands <aux-expand-deftype>` to a :ref:`structure type <syntax-structtype>` and :math:`\heaptype_2` is :math:`\STRUCT`.

* Or :math:`\heaptype_1` is a :ref:`defined type <syntax-deftype>` which :ref:`expands <aux-expand-deftype>` to an :ref:`array type <syntax-arraytype>` and :math:`\heaptype_2` is :math:`\ARRAY`.

* Or :math:`\heaptype_1` is a :ref:`defined type <syntax-deftype>` which :ref:`expands <aux-expand-deftype>` to a :ref:`function type <syntax-functype>` and :math:`\heaptype_2` is :math:`\FUNC`.

* Or :math:`\heaptype_1` is a :ref:`defined type <syntax-deftype>` :math:`\deftype_1` and :math:`\heaptype_2` is a :ref:`defined type <syntax-deftype>` :math:`\deftype_2`, and :math:`\deftype_1` :ref:`matches <match-deftype>` :math:`\deftype_2`.

* Or :math:`\heaptype_1` is a :ref:`type index <syntax-typeidx>` :math:`x_1`, and the :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x_1]` :ref:`matches <match-heaptype>` :math:`\heaptype_2`.

* Or :math:`\heaptype_2` is a :ref:`type index <syntax-typeidx>` :math:`x_2`, and :math:`\heaptype_1` :ref:`matches <match-heaptype>` the :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x_2]`.

* Or :math:`\heaptype_1` is :math:`\NONE` and :math:`\heaptype_2` :ref:`matches <match-heaptype>` :math:`\ANY`.

* Or :math:`\heaptype_1` is :math:`\NOFUNC` and :math:`\heaptype_2` :ref:`matches <match-heaptype>` :math:`\FUNC`.

* Or :math:`\heaptype_1` is :math:`\NOEXTERN` and :math:`\heaptype_2` :ref:`matches <match-heaptype>` :math:`\EXTERN`.

* Or :math:`\heaptype_1` is :math:`\BOTH`.

.. math::
   ~\\[-1ex]
   \frac{
   }{
     C \vdashheaptypematch \heaptype \matchesheaptype \heaptype
   }
   \qquad
   \frac{
     C \vdashheaptype \heaptype' \ok
     \qquad
     C \vdashheaptypematch \heaptype_1 \matchesheaptype \heaptype'
     \qquad
     C \vdashheaptypematch \heaptype' \matchesheaptype \heaptype_2
   }{
     C \vdashheaptypematch \heaptype_1 \matchesheaptype \heaptype_2
   }

.. math::
   ~\\[-1ex]
   \frac{
   }{
     C \vdashheaptypematch \EQT \matchesheaptype \ANY
   }
   \qquad
   \frac{
   }{
     C \vdashheaptypematch \I31 \matchesheaptype \EQT
   }
   \qquad
   \frac{
   }{
     C \vdashheaptypematch \STRUCT \matchesheaptype \EQT
   }
   \qquad
   \frac{
   }{
     C \vdashheaptypematch \ARRAY \matchesheaptype \EQT
   }

.. math::
   ~\\[-1ex]
   \frac{
     \expanddt(\deftype) = \TSTRUCT~\X{st}
   }{
     C \vdashheaptypematch \deftype \matchesheaptype \STRUCT
   }
   \qquad
   \frac{
     \expanddt(\deftype) = \TARRAY~\X{at}
   }{
     C \vdashheaptypematch \deftype \matchesheaptype \ARRAY
   }
   \qquad
   \frac{
     \expanddt(\deftype) = \TFUNC~\X{ft}
   }{
     C \vdashheaptypematch \deftype \matchesheaptype \FUNC
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

.. math::
   ~\\[-1ex]
   \frac{
     C \vdashheaptypematch \X{ht} \matchesheaptype \ANY
   }{
     C \vdashheaptypematch \NONE \matchesheaptype \X{ht}
   }
   \qquad
   \frac{
     C \vdashheaptypematch \X{ht} \matchesheaptype \FUNC
   }{
     C \vdashheaptypematch \NOFUNC \matchesheaptype \X{ht}
   }
   \qquad
   \frac{
     C \vdashheaptypematch \X{ht} \matchesheaptype \EXTERN
   }{
     C \vdashheaptypematch \NOEXTERN \matchesheaptype \X{ht}
   }

.. math::
   ~\\[-1ex]
   \frac{
   }{
     C \vdashheaptypematch \BOTH \matchesheaptype \heaptype
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
An :ref:`instruction type <syntax-instrtype>` :math:`[t_{11}^\ast] \to_{x_1^\ast} [t_{12}^\ast]` matches a type :math:`[t_{21}^ast] \to_{x_2^\ast} [t_{22}^\ast]` if and only if:

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
     C \vdashinstrtypematch [t_{11}^\ast] \to_{x_1^\ast} [t_{12}^\ast] \matchesinstrtype [t^\ast~t_{21}^\ast] \to_{x_2^\ast} [t^\ast~t_{22}^\ast]
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

A :ref:`function type <syntax-functype>` :math:`[t_{11}^\ast] \toF [t_{12}^\ast]` matches a type :math:`[t_{21}^ast] \toF [t_{22}^\ast]` if and only if:

* The :ref:`result type <syntax-resulttype>` :math:`[t_{21}^\ast]` :ref:`matches <match-resulttype>` :math:`[t_{11}^\ast]`.

* The :ref:`result type <syntax-resulttype>` :math:`[t_{12}^\ast]` :ref:`matches <match-resulttype>` :math:`[t_{22}^\ast]`.

.. math::
   ~\\[-1ex]
   \frac{
     C \vdashresulttypematch [t_{21}^\ast] \matchesresulttype [t_{11}^\ast]
     \qquad
     C \vdashresulttypematch [t_{12}^\ast] \matchesresulttype [t_{22}^\ast]
   }{
     C \vdashfunctypematch [t_{11}^\ast] \toF [t_{12}^\ast] \matchesfunctype [t_{21}^\ast] \toF [t_{22}^\ast]
   }


.. index:: composite types, aggregate type, structure type, array type, field type
.. _match-comptype:
.. _match-structtype:
.. _match-arraytype:

Composite Types
~~~~~~~~~~~~~~~

A :ref:`composite type <syntax-comptype>` :math:`\comptype_1` matches a type :math:`\comptype_2` if and only if:

* Either the composite type :math:`\comptype_1` is :math:`\TFUNC~\functype_1` and :math:`\comptype_2` is :math:`\TFUNC~\functype_2` and:

  * The :ref:`function type <syntax-functype>` :math:`\functype_1` :ref:`matches <match-functype>` :math:`\functype_2`.

* Or the composite type :math:`\comptype_1` is :math:`\TSTRUCT~\fieldtype_1^{n_1}` and :math:`\comptype_2` is :math:`\TSTRUCT~\fieldtype_2` and:

  * The arity :math:`n_1` is greater than or equal to :math:`n_2`.

  * For every :ref:`field type <syntax-fieldtype>` :math:`\fieldtype_{2i}` in :math:`\fieldtype_2^{n_2}` and corresponding :math:`\fieldtype_{1i}` in :math:`\fieldtype_1^{n_1}`

    * The :ref:`field type <syntax-fieldtype>` :math:`\fieldtype_{1i}` :ref:`matches <match-fieldtype>` :math:`\fieldtype_{2i}`.

* Or the composite type :math:`\comptype_1` is :math:`\TARRAY~\fieldtype_1` and :math:`\comptype_2` is :math:`\TARRAY~\fieldtype_2` and:

  * The :ref:`field type <syntax-fieldtype>` :math:`\fieldtype_1` :ref:`matches <match-fieldtype>` :math:`\fieldtype_2`.

.. math::
   ~\\[-1ex]
   \frac{
     C \vdashfunctypematch \functype_1 \matchesfunctype \functype_2
   }{
     C \vdashcomptypematch \TFUNC~\functype_1 \matchescomptype \TFUNC~\functype_2
   }

.. math::
   ~\\[-1ex]
   \frac{
     (C \vdashfieldtypematch \fieldtype_1 \matchesfieldtype \fieldtype_2)^\ast
   }{
     C \vdashcomptypematch \TSTRUCT~\fieldtype_1^\ast~{\fieldtype'}_1^\ast \matchescomptype \TSTRUCT~\fieldtype_2^\ast
   }

.. math::
   ~\\[-1ex]
   \frac{
     C \vdashfieldtypematch \fieldtype_1 \matchesfieldtype \fieldtype_2
   }{
     C \vdashcomptypematch \TARRAY~\fieldtype_1 \matchescomptype \TARRAY~\fieldtype_2
   }


.. index:: field type, storage type, value type, packed type, mutability
.. _match-fieldtype:
.. _match-storagetype:
.. _match-packedtype:

Field Types
~~~~~~~~~~~

A :ref:`field type <syntax-fieldtype>` :math:`\mut_1~\storagetype_1` matches a type :math:`\mut_2~\storagetype_2` if and only if:

* :ref:`Storage type <syntax-storagetype>` :math:`\storagetype_1` :ref:`matches <match-storagetype>` :math:`\storagetype_2`.

* Either both :math:`\mut_1` and :math:`\mut_2` are :math:`\MCONST`.

* Or both :math:`\mut_1` and :math:`\mut_2` are :math:`\MVAR` and :math:`\storagetype_2` :ref:`matches <match-storagetype>` :math:`\storagetype_1` as well.

.. math::
   ~\\[-1ex]
   \frac{
     C \vdashstoragetypematch \storagetype_1 \matchesstoragetype \storagetype_2
   }{
     C \vdashfieldtypematch \MCONST~\storagetype_1 \matchescomptype \MCONST~\storagetype_2
   }
   \qquad
   \frac{
     \begin{array}[b]{@{}c@{}}
     C \vdashstoragetypematch \storagetype_1 \matchesstoragetype \storagetype_2
     \\
     C \vdashstoragetypematch \storagetype_2 \matchesstoragetype \storagetype_1
     \end{array}
   }{
     C \vdashfieldtypematch \MVAR~\storagetype_1 \matchescomptype \MVAR~\storagetype_2
   }

A :ref:`storage type <syntax-storagetype>` :math:`\storagetype_1` matches a type :math:`\storagetype_2` if and only if:

* Either :math:`\storagetype_1` is a :ref:`value type <syntax-valtype>` :math:`\valtype_1` and :math:`\storagetype_2` is a :ref:`value type <syntax-valtype>` :math:`\valtype_2` and :math:`\valtype_1` :ref:`matches <match-valtype>` :math:`\valtype_2`.

* Or :math:`\storagetype_1` is a :ref:`packed type <syntax-packedtype>` :math:`\packedtype_1` and :math:`\storagetype_2` is a :ref:`packed type <syntax-packedtype>` :math:`\packedtype_2` and :math:`\packedtype_1` :ref:`matches <match-packedtype>` :math:`\packedtype_2`.

A :ref:`packed type <syntax-packedtype>` :math:`\packedtype_1` matches a type :math:`\packedtype_2` if and only if:

* The :ref:`packed type <syntax-packedtype>` :math:`\packedtype_1` is the same as :math:`\packedtype_2`.

.. math::
   ~\\[-1ex]
   \frac{
   }{
     C \vdashpackedtypematch \packedtype \matchespackedtype \packedtype
   }


.. index:: defined type, recursive type, unroll, type equivalence
   pair: abstract syntax; defined type
.. _match-deftype:

Defined Types
~~~~~~~~~~~~~

A :ref:`defined type <syntax-deftype>` :math:`\deftype_1` matches a type :math:`\deftype_2` if and only if:

* Either :math:`\deftype_1` and :math:`\deftype_2` are equal when :ref:`closed <type-closure>` under context :math:`C`.

* Or:

  * Let the :ref:`sub type <syntax-subtype>` :math:`\TSUB~\TFINAL^?~\heaptype^\ast~\comptype` be the result of :ref:`unrolling <aux-unroll-deftype>` :math:`\deftype_1`.

  * Then there must exist a :ref:`heap type <syntax-heaptype>` :math:`\heaptype_i` in :math:`\heaptype^\ast` that :ref:`matches <match-heaptype>` :math:`\deftype_2`.

.. math::
   ~\\[-1ex]
   \frac{
     \clostype_C(\deftype_1) = \clostype_C(\deftype_2)
   }{
     C \vdashdeftypematch \deftype_1 \matchesdeftype \deftype_2
   }

.. math::
   ~\\[-1ex]
   \frac{
     \unrolldt(\deftype_1) = \TSUB~\TFINAL^?~\heaptype^\ast~\comptype
     \qquad
     C \vdashheaptypematch \heaptype^\ast[i] \matchesheaptype \deftype_2
   }{
     C \vdashdeftypematch \deftype_1 \matchesdeftype \deftype_2
   }

.. note::
   Note that there is no explicit definition of type _equivalence_,
   since it coincides with syntactic equality,
   as used in the premise of the former rule above.


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

A :ref:`table type <syntax-tabletype>` :math:`(\addrtype_1~\limits_1~\reftype_1)` matches :math:`(\addrtype_2~\limits_2~\reftype_2)` if and only if:

* Address types :math:`\addrtype_1` and :math:`\addrtype_2` are the same.

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
     C \vdashtabletypematch \addrtype~\limits_1~\reftype_1 \matchestabletype \addrtype~\limits_2~\reftype_2
   }


.. index:: memory type, limits
.. _match-memtype:

Memory Types
~~~~~~~~~~~~

A :ref:`memory type <syntax-memtype>` :math:`(\addrtype_1~\limits_1)` matches :math:`(\addrtype_2~\limits_2)` if and only if:

* Address types :math:`\addrtype_1` and :math:`\addrtype_2` are the same.

* Limits :math:`\limits_1` :ref:`match <match-limits>` :math:`\limits_2`.


.. math::
   ~\\[-1ex]
   \frac{
     C \vdashlimitsmatch \limits_1 \matcheslimits \limits_2
   }{
     C \vdashmemtypematch \addrtype~\limits_1 \matchesmemtype \addrtype~\limits_2
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


.. index:: tag type
.. _match-tagtype:

Tag Types
~~~~~~~~~

A :ref:`tag type <syntax-tagtype>` :math:`\deftype_1` matches :math:`\deftype_2` if and only if the :ref:`defined type <syntax-deftype>` :math:`\deftype_1` :ref:`matches <match-deftype>` :math:`\deftype_2`, and vice versa.

.. math::
   \frac{
     C \vdashdeftypematch \deftype_1 \matchesdeftype \deftype_2
     \qquad
     C \vdashdeftypematch \deftype_2 \matchesdeftype \deftype_1
   }{
     C \vdashtagtypematch \deftype_1 \matchestagtype \deftype_2
   }

.. note::
   Although the conclusion of this rule looks identical to its premise,
   they in fact describe different relations:
   the premise invokes subtyping on defined types,
   while the conclusion defines it on tag types that happen to be expressed as defined types.

.. index:: external type, function type, table type, memory type, global type
.. _match-externtype:

External Types
~~~~~~~~~~~~~~

Functions
.........

An :ref:`external type <syntax-externtype>` :math:`\ETFUNC~\deftype_1` matches :math:`\ETFUNC~\deftype_2` if and only if:

* The :ref:`defined type <syntax-deftype>` :math:`\deftype_1` :ref:`matches <match-deftype>` :math:`\deftype_2`.

.. math::
   ~\\[-1ex]
   \frac{
     C \vdashdeftypematch \deftype_1 \matchesfunctype \deftype_2
   }{
     C \vdashexterntypematch \ETFUNC~\deftype_1 \matchesexterntype \ETFUNC~\deftype_2
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


Tags
....

An :ref:`external type <syntax-externtype>` :math:`\ETTAG~\tagtype_1` matches :math:`\ETTAG~\tagtype_2`  if and only if:

* Tag type :math:`\tagtype_1` :ref:`matches <match-tagtype>` :math:`\tagtype_2`.

.. math::
   \frac{
     C \vdashtagtypematch \tagtype_1 \matchestagtype \tagtype_2
   }{
     C \vdashexterntypematch \ETTAG~\tagtype_1 \matchesexterntype \ETTAG~\tagtype_2
   }

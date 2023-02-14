.. index:: value, integer, floating-point, bit width, determinism, non-determinism, NaN
.. _exec-op-partial:
.. _exec-numeric:

Numerics
--------

Numeric primitives are defined in a generic manner, by operators indexed over a bit width :math:`N`.

Some operators are *non-deterministic*, because they can return one of several possible results (such as different :ref:`NaN <syntax-nan>` values).
Technically, each operator thus returns a *set* of allowed values.
For convenience, deterministic results are expressed as plain values, which are assumed to be identified with a respective singleton set.

Some operators are *partial*, because they are not defined on certain inputs.
Technically, an empty set of results is returned for these inputs.

In formal notation, each operator is defined by equational clauses that apply in decreasing order of precedence.
That is, the first clause that is applicable to the given arguments defines the result.
In some cases, similar clauses are combined into one by using the notation :math:`\pm` or :math:`\mp`.
When several of these placeholders occur in a single clause, then they must be resolved consistently: either the upper sign is chosen for all of them or the lower sign.

.. note::
   For example, the |fcopysign| operator is defined as follows:

   .. math::
      \begin{array}{@{}lcll}
      \fcopysign_N(\pm p_1, \pm p_2) &=& \pm p_1 \\
      \fcopysign_N(\pm p_1, \mp p_2) &=& \mp p_1 \\
      \end{array}

   This definition is to be read as a shorthand for the following expansion of each clause into two separate ones:

   .. math::
      \begin{array}{@{}lcll}
      \fcopysign_N(+ p_1, + p_2) &=& + p_1 \\
      \fcopysign_N(- p_1, - p_2) &=& - p_1 \\
      \fcopysign_N(+ p_1, - p_2) &=& - p_1 \\
      \fcopysign_N(- p_1, + p_2) &=& + p_1 \\
      \end{array}

Numeric operators are lifted to input sequences by applying the operator element-wise, returning a sequence of results. When there are multiple inputs, they must be of equal length.

.. math::
   \begin{array}{lll@{\qquad}l}
   op(c_1^n, \dots, c_k^n) &=& op(c_1^n[0], \dots, c_k^n[0])~\dots~op(c_1^n[n-1], \dots, c_k^n[n-1])
   \end{array}

.. note::
   For example, the unary operator |fabs|, when given a sequence of floating-point values, return a sequence of floating-point results:

   .. math::
      \begin{array}{lll@{\qquad}l}
      \fabs_N(z^n) &=& \fabs_N(z[0])~\dots~\fabs_N(z[n])
      \end{array}

   The binary operator |iadd|, when given two sequences of integers of the same length, :math:`n`, return a sequence of integer results:

   .. math::
      \begin{array}{lll@{\qquad}l}
      \iadd_N(i_1^n, i_2^n) &=& \iadd_N(i_1[0], i_2[0])~\dots~\iadd_N(i_1[n], i_2[n])
      \end{array}

.. _aux-trunc:

Conventions:

* The meta variable :math:`d` is used to range over single bits.

* The meta variable :math:`p` is used to range over (signless) :ref:`magnitudes <syntax-float>` of floating-point values, including |NAN| and :math:`\infty`.

* The meta variable :math:`q` is used to range over (signless) *rational* :ref:`magnitudes <syntax-float>`, excluding |NAN| or :math:`\infty`.

* The notation :math:`f^{-1}` denotes the inverse of a bijective function :math:`f`.

* Truncation of rational values is written :math:`\trunc(\pm q)`, with the usual mathematical definition:

  .. math::
     \begin{array}{lll@{\qquad}l}
     \trunc(\pm q) &=& \pm i & (\iff i \in \mathbb{N} \wedge +q - 1 < i \leq +q) \\
     \end{array}

.. _aux-sat_u:
.. _aux-sat_s:

* Saturation of integers is written :math:`\satu_N(i)` and :math:`\sats_N(i)`. The arguments to these two functions range over arbitrary signed integers.

  * Unsigned saturation, :math:`\satu_N(i)` clamps :math:`i` to between :math:`0` and :math:`2^N-1`:

    .. math::
       \begin{array}{lll@{\qquad}l}
       \satu_N(i) &=& 2^N-1 & (\iff i > 2^N-1)\\
       \satu_N(i) &=& 0 & (\iff i < 0) \\
       \satu_N(i) &=& i & (\otherwise) \\
       \end{array}

  * Signed saturation, :math:`\sats_N(i)` clamps :math:`i` to between :math:`-2^{N-1}` and :math:`2^{N-1}-1`:

  .. math::
     \begin{array}{lll@{\qquad}l}
     \sats_N(i) &=& \signed_N^{-1}(-2^{N-1}) & (\iff i < -2^{N-1})\\
     \sats_N(i) &=& \signed_N^{-1}(2^{N-1}-1) & (\iff i > 2^{N-1}-1)\\
     \sats_N(i) &=& i & (\otherwise)
     \end{array}



.. index:: bit, integer, floating-point
.. _aux-bits:

Representations
~~~~~~~~~~~~~~~

Numbers have an underlying binary representation as a sequence of bits:

.. math::
   \begin{array}{lll@{\qquad}l}
   \bits_{\K{i}N}(i) &=& \ibits_N(i) \\
   \bits_{\K{f}N}(z) &=& \fbits_N(z) \\
   \end{array}

Each of these functions is a bijection, hence they are invertible.


.. index:: Boolean
.. _aux-ibits:

Integers
........

:ref:`Integers <syntax-int>` are represented as base two unsigned numbers:

.. math::
   \begin{array}{lll@{\qquad}l}
   \ibits_N(i) &=& d_{N-1}~\dots~d_0 & (i = 2^{N-1}\cdot d_{N-1} + \dots + 2^0\cdot d_0) \\
   \end{array}

Boolean operators like :math:`\wedge`, :math:`\vee`, or :math:`\veebar` are lifted to bit sequences of equal length by applying them pointwise.


.. index:: IEEE 754, significand, exponent
.. _aux-fbias:
.. _aux-fsign:
.. _aux-fbits:

Floating-Point
..............

:ref:`Floating-point values <syntax-float>` are represented in the respective binary format defined by |IEEE754|_ (Section 3.4):

.. math::
   \begin{array}{lll@{\qquad}l}
   \fbits_N(\pm (1+m\cdot 2^{-M})\cdot 2^e) &=& \fsign({\pm})~\ibits_E(e+\fbias_N)~\ibits_M(m) \\
   \fbits_N(\pm (0+m\cdot 2^{-M})\cdot 2^e) &=& \fsign({\pm})~(0)^E~\ibits_M(m) \\
   \fbits_N(\pm \infty) &=& \fsign({\pm})~(1)^E~(0)^M \\
   \fbits_N(\pm \NAN(n)) &=& \fsign({\pm})~(1)^E~\ibits_M(n) \\[1ex]
   \fbias_N &=& 2^{E-1}-1 \\
   \fsign({+}) &=& 0 \\
   \fsign({-}) &=& 1 \\
   \end{array}

where :math:`M = \significand(N)` and :math:`E = \exponent(N)`.


.. index:: byte, little endian, memory
.. _aux-littleendian:
.. _aux-bytes:

Storage
.......

When a number is stored into :ref:`memory <syntax-mem>`, it is converted into a sequence of :ref:`bytes <syntax-byte>` in |LittleEndian|_ byte order:

.. math::
   \begin{array}{lll@{\qquad}l}
   \bytes_t(i) &=& \littleendian(\bits_t(i)) \\[1ex]
   \littleendian(\epsilon) &=& \epsilon \\
   \littleendian(d^8~{d'}^\ast~) &=& \littleendian({d'}^\ast)~\ibits_8^{-1}(d^8) \\
   \end{array}

Again these functions are invertible bijections.


.. index:: numeric vectors, shape
.. _aux-lanes:

Vectors
.......

Numeric vectors have the same underlying representation as an |i128|. They can also be interpreted as a sequence of numeric values packed into a |V128| with a particular |shape|.

.. math::
   \begin{array}{l}
   \begin{array}{lll@{\qquad}l}
   \lanes_{t\K{x}N}(c) &=&
     c_0~\dots~c_{N-1} \\
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\where & B = |t| / 8 \\
     \wedge & b^{16} = \bytes_{\i128}(c) \\
     \wedge & c_i = \bytes_{t}^{-1}(b^{16}[i \cdot B \slice B]))
     \end{array}
   \end{array}

These functions are bijections, so they are invertible.


.. index:: integer
.. _int-ops:

Integer Operations
~~~~~~~~~~~~~~~~~~

.. index:: sign, signed integer, unsigned integer, uninterpreted integer, two's complement
.. _aux-signed:

Sign Interpretation
...................

Integer operators are defined on |iN| values.
Operators that use a signed interpretation convert the value using the following definition, which takes the two's complement when the value lies in the upper half of the value range (i.e., its most significant bit is :math:`1`):

.. math::
   \begin{array}{lll@{\qquad}l}
   \signed_N(i) &=& i & (0 \leq i < 2^{N-1}) \\
   \signed_N(i) &=& i - 2^N & (2^{N-1} \leq i < 2^N) \\
   \end{array}

This function is bijective, and hence invertible.


.. index:: Boolean
.. _aux-bool:

Boolean Interpretation
......................

The integer result of predicates -- i.e., :ref:`tests <syntax-testop>` and :ref:`relational <syntax-relop>` operators -- is defined with the help of the following auxiliary function producing the value :math:`1` or :math:`0` depending on a condition.

.. math::
   \begin{array}{lll@{\qquad}l}
   \bool(C) &=& 1 & (\iff C) \\
   \bool(C) &=& 0 & (\otherwise) \\
   \end{array}


.. _op-iadd:

:math:`\iadd_N(i_1, i_2)`
.........................

* Return the result of adding :math:`i_1` and :math:`i_2` modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \iadd_N(i_1, i_2) &=& (i_1 + i_2) \mod 2^N
   \end{array}

.. _op-isub:

:math:`\isub_N(i_1, i_2)`
.........................

* Return the result of subtracting :math:`i_2` from :math:`i_1` modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \isub_N(i_1, i_2) &=& (i_1 - i_2 + 2^N) \mod 2^N
   \end{array}

.. _op-imul:

:math:`\imul_N(i_1, i_2)`
.........................

* Return the result of multiplying :math:`i_1` and :math:`i_2` modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \imul_N(i_1, i_2) &=& (i_1 \cdot i_2) \mod 2^N
   \end{array}

.. _op-idiv_u:

:math:`\idivu_N(i_1, i_2)`
..........................

* If :math:`i_2` is :math:`0`, then the result is undefined.

* Else, return the result of dividing :math:`i_1` by :math:`i_2`, truncated toward zero.

.. math::
   \begin{array}{@{}lcll}
   \idivu_N(i_1, 0) &=& \{\} \\
   \idivu_N(i_1, i_2) &=& \trunc(i_1 / i_2) \\
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.

.. _op-idiv_s:

:math:`\idivs_N(i_1, i_2)`
..........................

* Let :math:`j_1` be the :ref:`signed interpretation <aux-signed>` of :math:`i_1`.

* Let :math:`j_2` be the :ref:`signed interpretation <aux-signed>` of :math:`i_2`.

* If :math:`j_2` is :math:`0`, then the result is undefined.

* Else if :math:`j_1` divided by :math:`j_2` is :math:`2^{N-1}`, then the result is undefined.

* Else, return the result of dividing :math:`j_1` by :math:`j_2`, truncated toward zero.

.. math::
   \begin{array}{@{}lcll}
   \idivs_N(i_1, 0) &=& \{\} \\
   \idivs_N(i_1, i_2) &=& \{\} \qquad\qquad (\iff \signed_N(i_1) / \signed_N(i_2) = 2^{N-1}) \\
   \idivs_N(i_1, i_2) &=& \signed_N^{-1}(\trunc(\signed_N(i_1) / \signed_N(i_2))) \\
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.
   Besides division by :math:`0`, the result of :math:`(-2^{N-1})/(-1) = +2^{N-1}` is not representable as an :math:`N`-bit signed integer.


.. _op-irem_u:

:math:`\iremu_N(i_1, i_2)`
..........................

* If :math:`i_2` is :math:`0`, then the result is undefined.

* Else, return the remainder of dividing :math:`i_1` by :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \iremu_N(i_1, 0) &=& \{\} \\
   \iremu_N(i_1, i_2) &=& i_1 - i_2 \cdot \trunc(i_1 / i_2) \\
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.

   As long as both operators are defined,
   it holds that :math:`i_1 = i_2\cdot\idivu(i_1, i_2) + \iremu(i_1, i_2)`.

.. _op-irem_s:

:math:`\irems_N(i_1, i_2)`
..........................

* Let :math:`j_1` be the :ref:`signed interpretation <aux-signed>` of :math:`i_1`.

* Let :math:`j_2` be the :ref:`signed interpretation <aux-signed>` of :math:`i_2`.

* If :math:`i_2` is :math:`0`, then the result is undefined.

* Else, return the remainder of dividing :math:`j_1` by :math:`j_2`, with the sign of the dividend :math:`j_1`.

.. math::
   \begin{array}{@{}lcll}
   \irems_N(i_1, 0) &=& \{\} \\
   \irems_N(i_1, i_2) &=& \signed_N^{-1}(j_1 - j_2 \cdot \trunc(j_1 / j_2)) \\
     && (\where j_1 = \signed_N(i_1) \wedge j_2 = \signed_N(i_2)) \\
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.

   As long as both operators are defined,
   it holds that :math:`i_1 = i_2\cdot\idivs(i_1, i_2) + \irems(i_1, i_2)`.


.. _op-inot:

:math:`\inot_N(i)`
..................

* Return the bitwise negation of :math:`i`.

.. math::
   \begin{array}{@{}lcll}
   \inot_N(i) &=& \ibits_N^{-1}(\ibits_N(i) \veebar \ibits_N(2^N-1))
   \end{array}

.. _op-iand:

:math:`\iand_N(i_1, i_2)`
.........................

* Return the bitwise conjunction of :math:`i_1` and :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \iand_N(i_1, i_2) &=& \ibits_N^{-1}(\ibits_N(i_1) \wedge \ibits_N(i_2))
   \end{array}

.. _op-iandnot:

:math:`\iandnot_N(i_1, i_2)`
............................

* Return the bitwise conjunction of :math:`i_1` and the bitwise negation of :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \iandnot_N(i_1, i_2) &=& \iand_N(i_1, \inot_N(i_2))
   \end{array}

.. _op-ior:

:math:`\ior_N(i_1, i_2)`
........................

* Return the bitwise disjunction of :math:`i_1` and :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \ior_N(i_1, i_2) &=& \ibits_N^{-1}(\ibits_N(i_1) \vee \ibits_N(i_2))
   \end{array}

.. _op-ixor:

:math:`\ixor_N(i_1, i_2)`
.........................

* Return the bitwise exclusive disjunction of :math:`i_1` and :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \ixor_N(i_1, i_2) &=& \ibits_N^{-1}(\ibits_N(i_1) \veebar \ibits_N(i_2))
   \end{array}

.. _op-ishl:

:math:`\ishl_N(i_1, i_2)`
.........................

* Let :math:`k` be :math:`i_2` modulo :math:`N`.

* Return the result of shifting :math:`i_1` left by :math:`k` bits, modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \ishl_N(i_1, i_2) &=& \ibits_N^{-1}(d_2^{N-k}~0^k)
     & (\iff \ibits_N(i_1) = d_1^k~d_2^{N-k} \wedge k = i_2 \mod N)
   \end{array}

.. _op-ishr_u:

:math:`\ishru_N(i_1, i_2)`
..........................

* Let :math:`k` be :math:`i_2` modulo :math:`N`.

* Return the result of shifting :math:`i_1` right by :math:`k` bits, extended with :math:`0` bits.

.. math::
   \begin{array}{@{}lcll}
   \ishru_N(i_1, i_2) &=& \ibits_N^{-1}(0^k~d_1^{N-k})
     & (\iff \ibits_N(i_1) = d_1^{N-k}~d_2^k \wedge k = i_2 \mod N)
   \end{array}

.. _op-ishr_s:

:math:`\ishrs_N(i_1, i_2)`
..........................

* Let :math:`k` be :math:`i_2` modulo :math:`N`.

* Return the result of shifting :math:`i_1` right by :math:`k` bits, extended with the most significant bit of the original value.

.. math::
   \begin{array}{@{}lcll}
   \ishrs_N(i_1, i_2) &=& \ibits_N^{-1}(d_0^{k+1}~d_1^{N-k-1})
     & (\iff \ibits_N(i_1) = d_0~d_1^{N-k-1}~d_2^k \wedge k = i_2 \mod N)
   \end{array}

.. _op-irotl:

:math:`\irotl_N(i_1, i_2)`
..........................

* Let :math:`k` be :math:`i_2` modulo :math:`N`.

* Return the result of rotating :math:`i_1` left by :math:`k` bits.

.. math::
   \begin{array}{@{}lcll}
   \irotl_N(i_1, i_2) &=& \ibits_N^{-1}(d_2^{N-k}~d_1^k)
     & (\iff \ibits_N(i_1) = d_1^k~d_2^{N-k} \wedge k = i_2 \mod N)
   \end{array}

.. _op-irotr:

:math:`\irotr_N(i_1, i_2)`
..........................

* Let :math:`k` be :math:`i_2` modulo :math:`N`.

* Return the result of rotating :math:`i_1` right by :math:`k` bits.

.. math::
   \begin{array}{@{}lcll}
   \irotr_N(i_1, i_2) &=& \ibits_N^{-1}(d_2^k~d_1^{N-k})
     & (\iff \ibits_N(i_1) = d_1^{N-k}~d_2^k \wedge k = i_2 \mod N)
   \end{array}


.. _op-iclz:

:math:`\iclz_N(i)`
..................

* Return the count of leading zero bits in :math:`i`; all bits are considered leading zeros if :math:`i` is :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \iclz_N(i) &=& k & (\iff \ibits_N(i) = 0^k~(1~d^\ast)^?)
   \end{array}


.. _op-ictz:

:math:`\ictz_N(i)`
..................

* Return the count of trailing zero bits in :math:`i`; all bits are considered trailing zeros if :math:`i` is :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \ictz_N(i) &=& k & (\iff \ibits_N(i) = (d^\ast~1)^?~0^k)
   \end{array}


.. _op-ipopcnt:

:math:`\ipopcnt_N(i)`
.....................

* Return the count of non-zero bits in :math:`i`.

.. math::
   \begin{array}{@{}lcll}
   \ipopcnt_N(i) &=& k & (\iff \ibits_N(i) = (0^\ast~1)^k~0^\ast)
   \end{array}


.. _op-ieqz:

:math:`\ieqz_N(i)`
..................

* Return :math:`1` if :math:`i` is zero, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \ieqz_N(i) &=& \bool(i = 0)
   \end{array}


.. _op-ieq:

:math:`\ieq_N(i_1, i_2)`
........................

* Return :math:`1` if :math:`i_1` equals :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \ieq_N(i_1, i_2) &=& \bool(i_1 = i_2)
   \end{array}


.. _op-ine:

:math:`\ine_N(i_1, i_2)`
........................

* Return :math:`1` if :math:`i_1` does not equal :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \ine_N(i_1, i_2) &=& \bool(i_1 \neq i_2)
   \end{array}


.. _op-ilt_u:

:math:`\iltu_N(i_1, i_2)`
.........................

* Return :math:`1` if :math:`i_1` is less than :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \iltu_N(i_1, i_2) &=& \bool(i_1 < i_2)
   \end{array}


.. _op-ilt_s:

:math:`\ilts_N(i_1, i_2)`
.........................

* Let :math:`j_1` be the :ref:`signed interpretation <aux-signed>` of :math:`i_1`.

* Let :math:`j_2` be the :ref:`signed interpretation <aux-signed>` of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is less than :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \ilts_N(i_1, i_2) &=& \bool(\signed_N(i_1) < \signed_N(i_2))
   \end{array}


.. _op-igt_u:

:math:`\igtu_N(i_1, i_2)`
.........................

* Return :math:`1` if :math:`i_1` is greater than :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \igtu_N(i_1, i_2) &=& \bool(i_1 > i_2)
   \end{array}


.. _op-igt_s:

:math:`\igts_N(i_1, i_2)`
.........................

* Let :math:`j_1` be the :ref:`signed interpretation <aux-signed>` of :math:`i_1`.

* Let :math:`j_2` be the :ref:`signed interpretation <aux-signed>` of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is greater than :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \igts_N(i_1, i_2) &=& \bool(\signed_N(i_1) > \signed_N(i_2))
   \end{array}


.. _op-ile_u:

:math:`\ileu_N(i_1, i_2)`
.........................

* Return :math:`1` if :math:`i_1` is less than or equal to :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \ileu_N(i_1, i_2) &=& \bool(i_1 \leq i_2)
   \end{array}


.. _op-ile_s:

:math:`\iles_N(i_1, i_2)`
.........................

* Let :math:`j_1` be the :ref:`signed interpretation <aux-signed>` of :math:`i_1`.

* Let :math:`j_2` be the :ref:`signed interpretation <aux-signed>` of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is less than or equal to :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \iles_N(i_1, i_2) &=& \bool(\signed_N(i_1) \leq \signed_N(i_2))
   \end{array}


.. _op-ige_u:

:math:`\igeu_N(i_1, i_2)`
.........................

* Return :math:`1` if :math:`i_1` is greater than or equal to :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \igeu_N(i_1, i_2) &=& \bool(i_1 \geq i_2)
   \end{array}


.. _op-ige_s:

:math:`\iges_N(i_1, i_2)`
.........................

* Let :math:`j_1` be the :ref:`signed interpretation <aux-signed>` of :math:`i_1`.

* Let :math:`j_2` be the :ref:`signed interpretation <aux-signed>` of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is greater than or equal to :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \iges_N(i_1, i_2) &=& \bool(\signed_N(i_1) \geq \signed_N(i_2))
   \end{array}


.. _op-iextendn_s:

:math:`\iextendMs_N(i)`
.......................

* Return :math:`\extends_{M,N}(i)`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \iextendMs_{N}(i) &=& \extends_{M,N}(i) \\
   \end{array}


.. _op-ibitselect:

:math:`\ibitselect_N(i_1, i_2, i_3)`
....................................

* Let :math:`j_1` be the bitwise conjunction of :math:`i_1` and :math:`i_3`.

* Let :math:`j_3'` be the bitwise negation of :math:`i_3`.

* Let :math:`j_2` be the bitwise conjunction of :math:`i_2` and :math:`j_3'`.

* Return the bitwise disjunction of :math:`j_1` and :math:`j_2`.

.. math::
   \begin{array}{@{}lcll}
   \ibitselect_N(i_1, i_2, i_3) &=& \ior_N(\iand_N(i_1, i_3), \iand_N(i_2, \inot_N(i_3)))
   \end{array}


.. _op-iabs:

:math:`\iabs_N(i)`
..................

* Let :math:`j` be the :ref:`signed interpretation <aux-signed>` of :math:`i`.

* If :math:`j` is greater than or equal to :math:`0`, then return :math:`i`.

* Else return the negation of `j`, modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \iabs_N(i) &=& i & (\iff \signed_N(i) \ge 0) \\
   \iabs_N(i) &=& -\signed_N(i) \mod 2^N & (\otherwise) \\
   \end{array}


.. _op-ineg:

:math:`\ineg_N(i)`
..................

* Return the result of negating :math:`i`, modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \ineg_N(i) &=& (2^N - i) \mod 2^N
   \end{array}


.. _op-imin_u:

:math:`\iminu_N(i_1, i_2)`
..........................

* Return :math:`i_1` if :math:`\iltu_N(i_1, i_2)` is :math:`1`, return :math:`i_2` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \iminu_N(i_1, i_2) &=& i_1 & (\iff \iltu_N(i_1, i_2) = 1)\\
   \iminu_N(i_1, i_2) &=& i_2 & (\otherwise)
   \end{array}


.. _op-imin_s:

:math:`\imins_N(i_1, i_2)`
..........................

* Return :math:`i_1` if :math:`\ilts_N(i_1, i_2)` is :math:`1`, return :math:`i_2` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \imins_N(i_1, i_2) &=& i_1 & (\iff \ilts_N(i_1, i_2) = 1)\\
   \imins_N(i_1, i_2) &=& i_2 & (\otherwise)
   \end{array}


.. _op-imax_u:

:math:`\imaxu_N(i_1, i_2)`
..........................

* Return :math:`i_1` if :math:`\igtu_N(i_1, i_2)` is :math:`1`, return :math:`i_2` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \imaxu_N(i_1, i_2) &=& i_1 & (\iff \igtu_N(i_1, i_2) = 1)\\
   \imaxu_N(i_1, i_2) &=& i_2 & (\otherwise)
   \end{array}


.. _op-imax_s:

:math:`\imaxs_N(i_1, i_2)`
..........................

* Return :math:`i_1` if :math:`\igts_N(i_1, i_2)` is :math:`1`, return :math:`i_2` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \imaxs_N(i_1, i_2) &=& i_1 & (\iff \igts_N(i_1, i_2) = 1)\\
   \imaxs_N(i_1, i_2) &=& i_2 & (\otherwise)
   \end{array}


.. _op-iadd_sat_u:

:math:`\iaddsatu_N(i_1, i_2)`
.............................

* Let :math:`i` be the result of adding :math:`i_1` and :math:`i_2`.

* Return :math:`\satu_N(i)`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \iaddsatu_N(i_1, i_2) &=& \satu_N(i_1 + i_2)
   \end{array}


.. _op-iadd_sat_s:

:math:`\iaddsats_N(i_1, i_2)`
.............................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`

* Let :math:`j_2` be the signed interpretation of :math:`i_2`

* Let :math:`j` be the result of adding :math:`j_1` and :math:`j_2`.

* Return :math:`\sats_N(j)`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \iaddsats_N(i_1, i_2) &=& \sats_N(\signed_N(i_1) + \signed_N(i_2))
   \end{array}


.. _op-isub_sat_u:

:math:`\isubsatu_N(i_1, i_2)`
.............................

* Let :math:`i` be the result of subtracting :math:`i_2` from :math:`i_1`.

* Return :math:`\satu_N(i)`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \isubsatu_N(i_1, i_2) &=& \satu_N(i_1 - i_2)
   \end{array}


.. _op-isub_sat_s:

:math:`\isubsats_N(i_1, i_2)`
.............................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`

* Let :math:`j_2` be the signed interpretation of :math:`i_2`

* Let :math:`j` be the result of subtracting :math:`j_2` from :math:`j_1`.

* Return :math:`\sats_N(j)`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \isubsats_N(i_1, i_2) &=& \sats_N(\signed_N(i_1) - \signed_N(i_2))
   \end{array}


.. _op-iavgr_u:

:math:`\iavgru_N(i_1, i_2)`
...........................

* Let :math:`j` be the result of adding :math:`i_1`, :math:`i_2`, and :math:`1`.

* Return the result of dividing :math:`j` by :math:`2`, truncated toward zero.

.. math::
   \begin{array}{lll@{\qquad}l}
   \iavgru_N(i_1, i_2) &=& \trunc((i_1 + i_2 + 1) / 2)
   \end{array}


.. _op-iq15mulrsat_s:

:math:`\iq15mulrsats_N(i_1, i_2)`
.................................

* Return the result of :math:`\sats_N(\ishrs_N(i_1 \cdot i_2 + 2^{14}, 15))`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \iq15mulrsats_N(i_1, i_2) &=& \sats_N(\ishrs_N(i_1 \cdot i_2 + 2^{14}, 15))
   \end{array}


.. index:: floating-point, IEEE 754
.. _float-ops:

Floating-Point Operations
~~~~~~~~~~~~~~~~~~~~~~~~~

Floating-point arithmetic follows the |IEEE754|_ standard,
with the following qualifications:

* All operators use round-to-nearest ties-to-even, except where otherwise specified.
  Non-default directed rounding attributes are not supported.

* Following the recommendation that operators propagate :ref:`NaN <syntax-nan>` payloads from their operands is permitted but not required.

* All operators use "non-stop" mode, and floating-point exceptions are not otherwise observable.
  In particular, neither alternate floating-point exception handling attributes nor operators on status flags are supported.
  There is no observable difference between quiet and signalling NaNs.

.. note::
   Some of these limitations may be lifted in future versions of WebAssembly.


.. index:: rounding
.. _aux-ieee:

Rounding
........

Rounding always is round-to-nearest ties-to-even, in correspondence with |IEEE754|_ (Section 4.3.1).

An *exact* floating-point number is a rational number that is exactly representable as a :ref:`floating-point number <syntax-float>` of given bit width :math:`N`.

A *limit* number for a given floating-point bit width :math:`N` is a positive or negative number whose magnitude is the smallest power of :math:`2` that is not exactly representable as a floating-point number of width :math:`N` (that magnitude is :math:`2^{128}` for :math:`N = 32` and :math:`2^{1024}` for :math:`N = 64`).

A *candidate* number is either an exact floating-point number or a positive or negative limit number for the given bit width :math:`N`.

A *candidate pair* is a pair :math:`z_1,z_2` of candidate numbers, such that no candidate number exists that lies between the two.

A real number :math:`r` is converted to a floating-point value of bit width :math:`N` as follows:

* If :math:`r` is :math:`0`, then return :math:`+0`.

* Else if :math:`r` is an exact floating-point number, then return :math:`r`.

* Else if :math:`r` greater than or equal to the positive limit, then return :math:`+\infty`.

* Else if :math:`r` is less than or equal to the negative limit, then return :math:`-\infty`.

* Else if :math:`z_1` and :math:`z_2` are a candidate pair such that :math:`z_1 < r < z_2`, then:

  * If :math:`|r - z_1| < |r - z_2|`, then let :math:`z` be :math:`z_1`.

  * Else if :math:`|r - z_1| > |r - z_2|`, then let :math:`z` be :math:`z_2`.

  * Else if :math:`|r - z_1| = |r - z_2|` and the :ref:`significand <syntax-float>` of :math:`z_1` is even, then let :math:`z` be :math:`z_1`.

  * Else, let :math:`z` be :math:`z_2`.

* If :math:`z` is :math:`0`, then:

  * If :math:`r < 0`, then return :math:`-0`.

  * Else, return :math:`+0`.

* Else if :math:`z` is a limit number, then:

  * If :math:`r < 0`, then return :math:`-\infty`.

  * Else, return :math:`+\infty`.

* Else, return :math:`z`.


.. math::
   \begin{array}{lll@{\qquad}l}
   \ieee_N(0) &=& +0 \\
   \ieee_N(r) &=& r & (\iff r \in \F{exact}_N) \\
   \ieee_N(r) &=& +\infty & (\iff r \geq +\F{limit}_N) \\
   \ieee_N(r) &=& -\infty & (\iff r \leq -\F{limit}_N) \\
   \ieee_N(r) &=& \F{closest}_N(r, z_1, z_2) & (\iff z_1 < r < z_2 \wedge (z_1,z_2) \in \F{candidatepair}_N) \\[1ex]
   \F{closest}_N(r, z_1, z_2) &=& \F{rectify}_N(r, z_1) & (\iff |r-z_1|<|r-z_2|) \\
   \F{closest}_N(r, z_1, z_2) &=& \F{rectify}_N(r, z_2) & (\iff |r-z_1|>|r-z_2|) \\
   \F{closest}_N(r, z_1, z_2) &=& \F{rectify}_N(r, z_1) & (\iff |r-z_1|=|r-z_2| \wedge \F{even}_N(z_1)) \\
   \F{closest}_N(r, z_1, z_2) &=& \F{rectify}_N(r, z_2) & (\iff |r-z_1|=|r-z_2| \wedge \F{even}_N(z_2)) \\[1ex]
   \F{rectify}_N(r, \pm \F{limit}_N) &=& \pm \infty \\
   \F{rectify}_N(r, 0) &=& +0 \qquad (r \geq 0) \\
   \F{rectify}_N(r, 0) &=& -0 \qquad (r < 0) \\
   \F{rectify}_N(r, z) &=& z \\
   \end{array}

where:

.. math::
   \begin{array}{lll@{\qquad}l}
   \F{exact}_N &=& \fN \cap \mathbb{Q} \\
   \F{limit}_N &=& 2^{2^{\exponent(N)-1}} \\
   \F{candidate}_N &=& \F{exact}_N \cup \{+\F{limit}_N, -\F{limit}_N\} \\
   \F{candidatepair}_N &=& \{ (z_1, z_2) \in \F{candidate}_N^2 ~|~ z_1 < z_2 \wedge \forall z \in \F{candidate}_N, z \leq z_1 \vee z \geq z_2\} \\[1ex]
   \F{even}_N((d + m\cdot 2^{-M}) \cdot 2^e) &\Leftrightarrow& m \mod 2 = 0 \\
   \F{even}_N(\pm \F{limit}_N) &\Leftrightarrow& \F{true} \\
   \end{array}


.. index:: NaN, determinism, non-determinism
.. _aux-nans:

NaN Propagation
...............

When the result of a floating-point operator other than |fneg|, |fabs|, or |fcopysign| is a :ref:`NaN <syntax-nan>`,
then its sign is non-deterministic and the :ref:`payload <syntax-payload>` is computed as follows:

* If the payload of all NaN inputs to the operator is :ref:`canonical <canonical-nan>` (including the case that there are no NaN inputs), then the payload of the output is canonical as well.

* Otherwise the payload is picked non-deterministically among all :ref:`arithmetic NaNs <arithmetic-nan>`; that is, its most significant bit is :math:`1` and all others are unspecified.

* In the :ref:`deterministic profile <profile-deterministic>`, only positive canonical NaN outputs are produced.

This non-deterministic result is expressed by the following auxiliary function producing a set of allowed outputs from a set of inputs:

.. math::
   \begin{array}{llcl@{\qquad}l}
   & \nans_N\{z^\ast\} &=& \{ + \NAN(\canon_N) \} \\
   \exprofiles{\PROFDET} & \nans_N\{z^\ast\} &=& \{ + \NAN(n), - \NAN(n) ~|~ n = \canon_N \}
     & (\iff \forall \,{\pm \NAN(n)} \in z^\ast,~ n = \canon_N) \\
   \exprofiles{\PROFDET} & \nans_N\{z^\ast\} &=& \{ + \NAN(n), - \NAN(n) ~|~ n \geq \canon_N \}
     & (\iff \exists \,{\pm \NAN(n)} \in z^\ast,~ n \neq \canon_N) \\
   \end{array}


.. _op-fadd:

:math:`\fadd_N(z_1, z_2)`
.........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return an element of :math:`\nans_N\{z_1, z_2\}`.

* Else if both :math:`z_1` and :math:`z_2` are infinities of opposite signs, then return an element of :math:`\nans_N\{\}`.

* Else if both :math:`z_1` and :math:`z_2` are infinities of equal sign, then return that infinity.

* Else if either :math:`z_1` or :math:`z_2` is an infinity, then return that infinity.

* Else if both :math:`z_1` and :math:`z_2` are zeroes of opposite sign, then return positive zero.

* Else if both :math:`z_1` and :math:`z_2` are zeroes of equal sign, then return that zero.

* Else if either :math:`z_1` or :math:`z_2` is a zero, then return the other operand.

* Else if both :math:`z_1` and :math:`z_2` are values with the same magnitude but opposite signs, then return positive zero.

* Else return the result of adding :math:`z_1` and :math:`z_2`, :ref:`rounded <aux-ieee>` to the nearest representable value.

.. math::
   \begin{array}{@{}lcll}
   \fadd_N(\pm \NAN(n), z_2) &=& \nans_N\{\pm \NAN(n), z_2\} \\
   \fadd_N(z_1, \pm \NAN(n)) &=& \nans_N\{\pm \NAN(n), z_1\} \\
   \fadd_N(\pm \infty, \mp \infty) &=& \nans_N\{\} \\
   \fadd_N(\pm \infty, \pm \infty) &=& \pm \infty \\
   \fadd_N(z_1, \pm \infty) &=& \pm \infty \\
   \fadd_N(\pm \infty, z_2) &=& \pm \infty \\
   \fadd_N(\pm 0, \mp 0) &=& +0 \\
   \fadd_N(\pm 0, \pm 0) &=& \pm 0 \\
   \fadd_N(z_1, \pm 0) &=& z_1 \\
   \fadd_N(\pm 0, z_2) &=& z_2 \\
   \fadd_N(\pm q, \mp q) &=& +0 \\
   \fadd_N(z_1, z_2) &=& \ieee_N(z_1 + z_2) \\
   \end{array}


.. _op-fsub:

:math:`\fsub_N(z_1, z_2)`
.........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return an element of :math:`\nans_N\{z_1, z_2\}`.

* Else if both :math:`z_1` and :math:`z_2` are infinities of equal signs, then return an element of :math:`\nans_N\{\}`.

* Else if both :math:`z_1` and :math:`z_2` are infinities of opposite sign, then return :math:`z_1`.

* Else if :math:`z_1` is an infinity, then return that infinity.

* Else if :math:`z_2` is an infinity, then return that infinity negated.

* Else if both :math:`z_1` and :math:`z_2` are zeroes of equal sign, then return positive zero.

* Else if both :math:`z_1` and :math:`z_2` are zeroes of opposite sign, then return :math:`z_1`.

* Else if :math:`z_2` is a zero, then return :math:`z_1`.

* Else if :math:`z_1` is a zero, then return :math:`z_2` negated.

* Else if both :math:`z_1` and :math:`z_2` are the same value, then return positive zero.

* Else return the result of subtracting :math:`z_2` from :math:`z_1`, :ref:`rounded <aux-ieee>` to the nearest representable value.

.. math::
   \begin{array}{@{}lcll}
   \fsub_N(\pm \NAN(n), z_2) &=& \nans_N\{\pm \NAN(n), z_2\} \\
   \fsub_N(z_1, \pm \NAN(n)) &=& \nans_N\{\pm \NAN(n), z_1\} \\
   \fsub_N(\pm \infty, \pm \infty) &=& \nans_N\{\} \\
   \fsub_N(\pm \infty, \mp \infty) &=& \pm \infty \\
   \fsub_N(z_1, \pm \infty) &=& \mp \infty \\
   \fsub_N(\pm \infty, z_2) &=& \pm \infty \\
   \fsub_N(\pm 0, \pm 0) &=& +0 \\
   \fsub_N(\pm 0, \mp 0) &=& \pm 0 \\
   \fsub_N(z_1, \pm 0) &=& z_1 \\
   \fsub_N(\pm 0, \pm q_2) &=& \mp q_2 \\
   \fsub_N(\pm q, \pm q) &=& +0 \\
   \fsub_N(z_1, z_2) &=& \ieee_N(z_1 - z_2) \\
   \end{array}

.. note::
   Up to the non-determinism regarding NaNs, it always holds that :math:`\fsub_N(z_1, z_2) = \fadd_N(z_1, \fneg_N(z_2))`.


.. _op-fmul:

:math:`\fmul_N(z_1, z_2)`
.........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return an element of :math:`\nans_N\{z_1, z_2\}`.

* Else if one of :math:`z_1` and :math:`z_2` is a zero and the other an infinity, then return an element of :math:`\nans_N\{\}`.

* Else if both :math:`z_1` and :math:`z_2` are infinities of equal sign, then return positive infinity.

* Else if both :math:`z_1` and :math:`z_2` are infinities of opposite sign, then return negative infinity.

* Else if either :math:`z_1` or :math:`z_2` is an infinity and the other a value with equal sign, then return positive infinity.

* Else if either :math:`z_1` or :math:`z_2` is an infinity and the other a value with opposite sign, then return negative infinity.

* Else if both :math:`z_1` and :math:`z_2` are zeroes of equal sign, then return positive zero.

* Else if both :math:`z_1` and :math:`z_2` are zeroes of opposite sign, then return negative zero.

* Else return the result of multiplying :math:`z_1` and :math:`z_2`, :ref:`rounded <aux-ieee>` to the nearest representable value.

.. math::
   \begin{array}{@{}lcll}
   \fmul_N(\pm \NAN(n), z_2) &=& \nans_N\{\pm \NAN(n), z_2\} \\
   \fmul_N(z_1, \pm \NAN(n)) &=& \nans_N\{\pm \NAN(n), z_1\} \\
   \fmul_N(\pm \infty, \pm 0) &=& \nans_N\{\} \\
   \fmul_N(\pm \infty, \mp 0) &=& \nans_N\{\} \\
   \fmul_N(\pm 0, \pm \infty) &=& \nans_N\{\} \\
   \fmul_N(\pm 0, \mp \infty) &=& \nans_N\{\} \\
   \fmul_N(\pm \infty, \pm \infty) &=& +\infty \\
   \fmul_N(\pm \infty, \mp \infty) &=& -\infty \\
   \fmul_N(\pm q_1, \pm \infty) &=& +\infty \\
   \fmul_N(\pm q_1, \mp \infty) &=& -\infty \\
   \fmul_N(\pm \infty, \pm q_2) &=& +\infty \\
   \fmul_N(\pm \infty, \mp q_2) &=& -\infty \\
   \fmul_N(\pm 0, \pm 0) &=& + 0 \\
   \fmul_N(\pm 0, \mp 0) &=& - 0 \\
   \fmul_N(z_1, z_2) &=& \ieee_N(z_1 \cdot z_2) \\
   \end{array}


.. _op-fdiv:

:math:`\fdiv_N(z_1, z_2)`
.........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return an element of :math:`\nans_N\{z_1, z_2\}`.

* Else if both :math:`z_1` and :math:`z_2` are infinities, then return an element of :math:`\nans_N\{\}`.

* Else if both :math:`z_1` and :math:`z_2` are zeroes, then return an element of :math:`\nans_N\{z_1, z_2\}`.

* Else if :math:`z_1` is an infinity and :math:`z_2` a value with equal sign, then return positive infinity.

* Else if :math:`z_1` is an infinity and :math:`z_2` a value with opposite sign, then return negative infinity.

* Else if :math:`z_2` is an infinity and :math:`z_1` a value with equal sign, then return positive zero.

* Else if :math:`z_2` is an infinity and :math:`z_1` a value with opposite sign, then return negative zero.

* Else if :math:`z_1` is a zero and :math:`z_2` a value with equal sign, then return positive zero.

* Else if :math:`z_1` is a zero and :math:`z_2` a value with opposite sign, then return negative zero.

* Else if :math:`z_2` is a zero and :math:`z_1` a value with equal sign, then return positive infinity.

* Else if :math:`z_2` is a zero and :math:`z_1` a value with opposite sign, then return negative infinity.

* Else return the result of dividing :math:`z_1` by :math:`z_2`, :ref:`rounded <aux-ieee>` to the nearest representable value.

.. math::
   \begin{array}{@{}lcll}
   \fdiv_N(\pm \NAN(n), z_2) &=& \nans_N\{\pm \NAN(n), z_2\} \\
   \fdiv_N(z_1, \pm \NAN(n)) &=& \nans_N\{\pm \NAN(n), z_1\} \\
   \fdiv_N(\pm \infty, \pm \infty) &=& \nans_N\{\} \\
   \fdiv_N(\pm \infty, \mp \infty) &=& \nans_N\{\} \\
   \fdiv_N(\pm 0, \pm 0) &=& \nans_N\{\} \\
   \fdiv_N(\pm 0, \mp 0) &=& \nans_N\{\} \\
   \fdiv_N(\pm \infty, \pm q_2) &=& +\infty \\
   \fdiv_N(\pm \infty, \mp q_2) &=& -\infty \\
   \fdiv_N(\pm q_1, \pm \infty) &=& +0 \\
   \fdiv_N(\pm q_1, \mp \infty) &=& -0 \\
   \fdiv_N(\pm 0, \pm q_2) &=& +0 \\
   \fdiv_N(\pm 0, \mp q_2) &=& -0 \\
   \fdiv_N(\pm q_1, \pm 0) &=& +\infty \\
   \fdiv_N(\pm q_1, \mp 0) &=& -\infty \\
   \fdiv_N(z_1, z_2) &=& \ieee_N(z_1 / z_2) \\
   \end{array}


.. _op-fmin:

:math:`\fmin_N(z_1, z_2)`
.........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return an element of :math:`\nans_N\{z_1, z_2\}`.

* Else if either :math:`z_1` or :math:`z_2` is a negative infinity, then return negative infinity.

* Else if either :math:`z_1` or :math:`z_2` is a positive infinity, then return the other value.

* Else if both :math:`z_1` and :math:`z_2` are zeroes of opposite signs, then return negative zero.

* Else return the smaller value of :math:`z_1` and :math:`z_2`.

.. math::
   \begin{array}{@{}lcll}
   \fmin_N(\pm \NAN(n), z_2) &=& \nans_N\{\pm \NAN(n), z_2\} \\
   \fmin_N(z_1, \pm \NAN(n)) &=& \nans_N\{\pm \NAN(n), z_1\} \\
   \fmin_N(+ \infty, z_2) &=& z_2 \\
   \fmin_N(- \infty, z_2) &=& - \infty \\
   \fmin_N(z_1, + \infty) &=& z_1 \\
   \fmin_N(z_1, - \infty) &=& - \infty \\
   \fmin_N(\pm 0, \mp 0) &=& -0 \\
   \fmin_N(z_1, z_2) &=& z_1 & (\iff z_1 \leq z_2) \\
   \fmin_N(z_1, z_2) &=& z_2 & (\iff z_2 \leq z_1) \\
   \end{array}


.. _op-fmax:

:math:`\fmax_N(z_1, z_2)`
.........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return an element of :math:`\nans_N\{z_1, z_2\}`.

* Else if either :math:`z_1` or :math:`z_2` is a positive infinity, then return positive infinity.

* Else if either :math:`z_1` or :math:`z_2` is a negative infinity, then return the other value.

* Else if both :math:`z_1` and :math:`z_2` are zeroes of opposite signs, then return positive zero.

* Else return the larger value of :math:`z_1` and :math:`z_2`.

.. math::
   \begin{array}{@{}lcll}
   \fmax_N(\pm \NAN(n), z_2) &=& \nans_N\{\pm \NAN(n), z_2\} \\
   \fmax_N(z_1, \pm \NAN(n)) &=& \nans_N\{\pm \NAN(n), z_1\} \\
   \fmax_N(+ \infty, z_2) &=& + \infty \\
   \fmax_N(- \infty, z_2) &=& z_2 \\
   \fmax_N(z_1, + \infty) &=& + \infty \\
   \fmax_N(z_1, - \infty) &=& z_1 \\
   \fmax_N(\pm 0, \mp 0) &=& +0 \\
   \fmax_N(z_1, z_2) &=& z_1 & (\iff z_1 \geq z_2) \\
   \fmax_N(z_1, z_2) &=& z_2 & (\iff z_2 \geq z_1) \\
   \end{array}


.. _op-fcopysign:

:math:`\fcopysign_N(z_1, z_2)`
..............................

* If :math:`z_1` and :math:`z_2` have the same sign, then return :math:`z_1`.

* Else return :math:`z_1` with negated sign.

.. math::
   \begin{array}{@{}lcll}
   \fcopysign_N(\pm p_1, \pm p_2) &=& \pm p_1 \\
   \fcopysign_N(\pm p_1, \mp p_2) &=& \mp p_1 \\
   \end{array}


.. _op-fabs:

:math:`\fabs_N(z)`
..................

* If :math:`z` is a NaN, then return :math:`z` with positive sign.

* Else if :math:`z` is an infinity, then return positive infinity.

* Else if :math:`z` is a zero, then return positive zero.

* Else if :math:`z` is a positive value, then :math:`z`.

* Else return :math:`z` negated.

.. math::
   \begin{array}{@{}lcll}
   \fabs_N(\pm \NAN(n)) &=& +\NAN(n) \\
   \fabs_N(\pm \infty) &=& +\infty \\
   \fabs_N(\pm 0) &=& +0 \\
   \fabs_N(\pm q) &=& +q \\
   \end{array}


.. _op-fneg:

:math:`\fneg_N(z)`
..................

* If :math:`z` is a NaN, then return :math:`z` with negated sign.

* Else if :math:`z` is an infinity, then return that infinity negated.

* Else if :math:`z` is a zero, then return that zero negated.

* Else return :math:`z` negated.

.. math::
   \begin{array}{@{}lcll}
   \fneg_N(\pm \NAN(n)) &=& \mp \NAN(n) \\
   \fneg_N(\pm \infty) &=& \mp \infty \\
   \fneg_N(\pm 0) &=& \mp 0 \\
   \fneg_N(\pm q) &=& \mp q \\
   \end{array}


.. _op-fsqrt:

:math:`\fsqrt_N(z)`
...................

* If :math:`z` is a NaN, then return an element of :math:`\nans_N\{z\}`.

* Else if :math:`z` is negative infinity, then return an element of :math:`\nans_N\{\}`.

* Else if :math:`z` is positive infinity, then return positive infinity.

* Else if :math:`z` is a zero, then return that zero.

* Else if :math:`z` has a negative sign, then return an element of :math:`\nans_N\{\}`.

* Else return the square root of :math:`z`.

.. math::
   \begin{array}{@{}lcll}
   \fsqrt_N(\pm \NAN(n)) &=& \nans_N\{\pm \NAN(n)\} \\
   \fsqrt_N(- \infty) &=& \nans_N\{\} \\
   \fsqrt_N(+ \infty) &=& + \infty \\
   \fsqrt_N(\pm 0) &=& \pm 0 \\
   \fsqrt_N(- q) &=& \nans_N\{\} \\
   \fsqrt_N(+ q) &=& \ieee_N\left(\sqrt{q}\right) \\
   \end{array}


.. _op-fceil:

:math:`\fceil_N(z)`
...................

* If :math:`z` is a NaN, then return an element of :math:`\nans_N\{z\}`.

* Else if :math:`z` is an infinity, then return :math:`z`.

* Else if :math:`z` is a zero, then return :math:`z`.

* Else if :math:`z` is smaller than :math:`0` but greater than :math:`-1`, then return negative zero.

* Else return the smallest integral value that is not smaller than :math:`z`.

.. math::
   \begin{array}{@{}lcll}
   \fceil_N(\pm \NAN(n)) &=& \nans_N\{\pm \NAN(n)\} \\
   \fceil_N(\pm \infty) &=& \pm \infty \\
   \fceil_N(\pm 0) &=& \pm 0 \\
   \fceil_N(- q) &=& -0 & (\iff -1 < -q < 0) \\
   \fceil_N(\pm q) &=& \ieee_N(i) & (\iff \pm q \leq i < \pm q + 1) \\
   \end{array}


.. _op-ffloor:

:math:`\ffloor_N(z)`
....................

* If :math:`z` is a NaN, then return an element of :math:`\nans_N\{z\}`.

* Else if :math:`z` is an infinity, then return :math:`z`.

* Else if :math:`z` is a zero, then return :math:`z`.

* Else if :math:`z` is greater than :math:`0` but smaller than :math:`1`, then return positive zero.

* Else return the largest integral value that is not larger than :math:`z`.

.. math::
   \begin{array}{@{}lcll}
   \ffloor_N(\pm \NAN(n)) &=& \nans_N\{\pm \NAN(n)\} \\
   \ffloor_N(\pm \infty) &=& \pm \infty \\
   \ffloor_N(\pm 0) &=& \pm 0 \\
   \ffloor_N(+ q) &=& +0 & (\iff 0 < +q < 1) \\
   \ffloor_N(\pm q) &=& \ieee_N(i) & (\iff \pm q - 1 < i \leq \pm q) \\
   \end{array}


.. _op-ftrunc:

:math:`\ftrunc_N(z)`
....................

* If :math:`z` is a NaN, then return an element of :math:`\nans_N\{z\}`.

* Else if :math:`z` is an infinity, then return :math:`z`.

* Else if :math:`z` is a zero, then return :math:`z`.

* Else if :math:`z` is greater than :math:`0` but smaller than :math:`1`, then return positive zero.

* Else if :math:`z` is smaller than :math:`0` but greater than :math:`-1`, then return negative zero.

* Else return the integral value with the same sign as :math:`z` and the largest magnitude that is not larger than the magnitude of :math:`z`.

.. math::
   \begin{array}{@{}lcll}
   \ftrunc_N(\pm \NAN(n)) &=& \nans_N\{\pm \NAN(n)\} \\
   \ftrunc_N(\pm \infty) &=& \pm \infty \\
   \ftrunc_N(\pm 0) &=& \pm 0 \\
   \ftrunc_N(+ q) &=& +0 & (\iff 0 < +q < 1) \\
   \ftrunc_N(- q) &=& -0 & (\iff -1 < -q < 0) \\
   \ftrunc_N(\pm q) &=& \ieee_N(\pm i) & (\iff +q - 1 < i \leq +q) \\
   \end{array}


.. _op-fnearest:

:math:`\fnearest_N(z)`
......................

* If :math:`z` is a NaN, then return an element of :math:`\nans_N\{z\}`.

* Else if :math:`z` is an infinity, then return :math:`z`.

* Else if :math:`z` is a zero, then return :math:`z`.

* Else if :math:`z` is greater than :math:`0` but smaller than or equal to :math:`0.5`, then return positive zero.

* Else if :math:`z` is smaller than :math:`0` but greater than or equal to :math:`-0.5`, then return negative zero.

* Else return the integral value that is nearest to :math:`z`; if two values are equally near, return the even one.

.. math::
   \begin{array}{@{}lcll}
   \fnearest_N(\pm \NAN(n)) &=& \nans_N\{\pm \NAN(n)\} \\
   \fnearest_N(\pm \infty) &=& \pm \infty \\
   \fnearest_N(\pm 0) &=& \pm 0 \\
   \fnearest_N(+ q) &=& +0 & (\iff 0 < +q \leq 0.5) \\
   \fnearest_N(- q) &=& -0 & (\iff -0.5 \leq -q < 0) \\
   \fnearest_N(\pm q) &=& \ieee_N(\pm i) & (\iff |i - q| < 0.5) \\
   \fnearest_N(\pm q) &=& \ieee_N(\pm i) & (\iff |i - q| = 0.5 \wedge i~\mbox{even}) \\
   \end{array}


.. _op-feq:

:math:`\feq_N(z_1, z_2)`
........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return :math:`0`.

* Else if both :math:`z_1` and :math:`z_2` are zeroes, then return :math:`1`.

* Else if both :math:`z_1` and :math:`z_2` are the same value, then return :math:`1`.

* Else return :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \feq_N(\pm \NAN(n), z_2) &=& 0 \\
   \feq_N(z_1, \pm \NAN(n)) &=& 0 \\
   \feq_N(\pm 0, \mp 0) &=& 1 \\
   \feq_N(z_1, z_2) &=& \bool(z_1 = z_2) \\
   \end{array}


.. _op-fne:

:math:`\fne_N(z_1, z_2)`
........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return :math:`1`.

* Else if both :math:`z_1` and :math:`z_2` are zeroes, then return :math:`0`.

* Else if both :math:`z_1` and :math:`z_2` are the same value, then return :math:`0`.

* Else return :math:`1`.

.. math::
   \begin{array}{@{}lcll}
   \fne_N(\pm \NAN(n), z_2) &=& 1 \\
   \fne_N(z_1, \pm \NAN(n)) &=& 1 \\
   \fne_N(\pm 0, \mp 0) &=& 0 \\
   \fne_N(z_1, z_2) &=& \bool(z_1 \neq z_2) \\
   \end{array}


.. _op-flt:

:math:`\flt_N(z_1, z_2)`
........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return :math:`0`.

* Else if :math:`z_1` and :math:`z_2` are the same value, then return :math:`0`.

* Else if :math:`z_1` is positive infinity, then return :math:`0`.

* Else if :math:`z_1` is negative infinity, then return :math:`1`.

* Else if :math:`z_2` is positive infinity, then return :math:`1`.

* Else if :math:`z_2` is negative infinity, then return :math:`0`.

* Else if both :math:`z_1` and :math:`z_2` are zeroes, then return :math:`0`.

* Else if :math:`z_1` is smaller than :math:`z_2`, then return :math:`1`.

* Else return :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \flt_N(\pm \NAN(n), z_2) &=& 0 \\
   \flt_N(z_1, \pm \NAN(n)) &=& 0 \\
   \flt_N(z, z) &=& 0 \\
   \flt_N(+ \infty, z_2) &=& 0 \\
   \flt_N(- \infty, z_2) &=& 1 \\
   \flt_N(z_1, + \infty) &=& 1 \\
   \flt_N(z_1, - \infty) &=& 0 \\
   \flt_N(\pm 0, \mp 0) &=& 0 \\
   \flt_N(z_1, z_2) &=& \bool(z_1 < z_2) \\
   \end{array}


.. _op-fgt:

:math:`\fgt_N(z_1, z_2)`
........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return :math:`0`.

* Else if :math:`z_1` and :math:`z_2` are the same value, then return :math:`0`.

* Else if :math:`z_1` is positive infinity, then return :math:`1`.

* Else if :math:`z_1` is negative infinity, then return :math:`0`.

* Else if :math:`z_2` is positive infinity, then return :math:`0`.

* Else if :math:`z_2` is negative infinity, then return :math:`1`.

* Else if both :math:`z_1` and :math:`z_2` are zeroes, then return :math:`0`.

* Else if :math:`z_1` is larger than :math:`z_2`, then return :math:`1`.

* Else return :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \fgt_N(\pm \NAN(n), z_2) &=& 0 \\
   \fgt_N(z_1, \pm \NAN(n)) &=& 0 \\
   \fgt_N(z, z) &=& 0 \\
   \fgt_N(+ \infty, z_2) &=& 1 \\
   \fgt_N(- \infty, z_2) &=& 0 \\
   \fgt_N(z_1, + \infty) &=& 0 \\
   \fgt_N(z_1, - \infty) &=& 1 \\
   \fgt_N(\pm 0, \mp 0) &=& 0 \\
   \fgt_N(z_1, z_2) &=& \bool(z_1 > z_2) \\
   \end{array}


.. _op-fle:

:math:`\fle_N(z_1, z_2)`
........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return :math:`0`.

* Else if :math:`z_1` and :math:`z_2` are the same value, then return :math:`1`.

* Else if :math:`z_1` is positive infinity, then return :math:`0`.

* Else if :math:`z_1` is negative infinity, then return :math:`1`.

* Else if :math:`z_2` is positive infinity, then return :math:`1`.

* Else if :math:`z_2` is negative infinity, then return :math:`0`.

* Else if both :math:`z_1` and :math:`z_2` are zeroes, then return :math:`1`.

* Else if :math:`z_1` is smaller than or equal to :math:`z_2`, then return :math:`1`.

* Else return :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \fle_N(\pm \NAN(n), z_2) &=& 0 \\
   \fle_N(z_1, \pm \NAN(n)) &=& 0 \\
   \fle_N(z, z) &=& 1 \\
   \fle_N(+ \infty, z_2) &=& 0 \\
   \fle_N(- \infty, z_2) &=& 1 \\
   \fle_N(z_1, + \infty) &=& 1 \\
   \fle_N(z_1, - \infty) &=& 0 \\
   \fle_N(\pm 0, \mp 0) &=& 1 \\
   \fle_N(z_1, z_2) &=& \bool(z_1 \leq z_2) \\
   \end{array}


.. _op-fge:

:math:`\fge_N(z_1, z_2)`
........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return :math:`0`.

* Else if :math:`z_1` and :math:`z_2` are the same value, then return :math:`1`.

* Else if :math:`z_1` is positive infinity, then return :math:`1`.

* Else if :math:`z_1` is negative infinity, then return :math:`0`.

* Else if :math:`z_2` is positive infinity, then return :math:`0`.

* Else if :math:`z_2` is negative infinity, then return :math:`1`.

* Else if both :math:`z_1` and :math:`z_2` are zeroes, then return :math:`1`.

* Else if :math:`z_1` is smaller than or equal to :math:`z_2`, then return :math:`1`.

* Else return :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \fge_N(\pm \NAN(n), z_2) &=& 0 \\
   \fge_N(z_1, \pm \NAN(n)) &=& 0 \\
   \fge_N(z, z) &=& 1 \\
   \fge_N(+ \infty, z_2) &=& 1 \\
   \fge_N(- \infty, z_2) &=& 0 \\
   \fge_N(z_1, + \infty) &=& 0 \\
   \fge_N(z_1, - \infty) &=& 1 \\
   \fge_N(\pm 0, \mp 0) &=& 1 \\
   \fge_N(z_1, z_2) &=& \bool(z_1 \geq z_2) \\
   \end{array}


.. _op-fpmin:

:math:`\fpmin_N(z_1, z_2)`
..........................

* If :math:`z_2` is less than :math:`z_1` then return :math:`z_2`.

* Else return :math:`z_1`.

.. math::
   \begin{array}{@{}lcll}
   \fpmin_N(z_1, z_2) &=& z_2 & (\iff \flt_N(z_2, z_1) = 1) \\
   \fpmin_N(z_1, z_2) &=& z_1 & (\otherwise)
   \end{array}


.. _op-fpmax:

:math:`\fpmax_N(z_1, z_2)`
..........................

* If :math:`z_1` is less than :math:`z_2` then return :math:`z_2`.

* Else return :math:`z_1`.

.. math::
   \begin{array}{@{}lcll}
   \fpmax_N(z_1, z_2) &=& z_2 & (\iff \flt_N(z_1, z_2) = 1) \\
   \fpmax_N(z_1, z_2) &=& z_1 & (\otherwise)
   \end{array}


.. _convert-ops:

Conversions
~~~~~~~~~~~

.. _op-extend_u:

:math:`\extendu_{M,N}(i)`
.........................

* Return :math:`i`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \extendu_{M,N}(i) &=& i \\
   \end{array}

.. note::
   In the abstract syntax, unsigned extension just reinterprets the same value.


.. _op-extend_s:

:math:`\extends_{M,N}(i)`
.........................

* Let :math:`j` be the :ref:`signed interpretation <aux-signed>` of :math:`i` of size :math:`M`.

* Return the two's complement of :math:`j` relative to size :math:`N`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \extends_{M,N}(i) &=& \signed_N^{-1}(\signed_M(i)) \\
   \end{array}


.. _op-wrap:

:math:`\wrap_{M,N}(i)`
......................

* Return :math:`i` modulo :math:`2^N`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \wrap_{M,N}(i) &=& i \mod 2^N \\
   \end{array}


.. _op-trunc_u:

:math:`\truncu_{M,N}(z)`
........................

* If :math:`z` is a NaN, then the result is undefined. 

* Else if :math:`z` is an infinity, then the result is undefined. 

* Else if :math:`z` is a number and :math:`\trunc(z)` is a value within range of the target type, then return that value.

* Else the result is undefined.

.. math::
   \begin{array}{lll@{\qquad}l}
   \truncu_{M,N}(\pm \NAN(n)) &=& \{\} \\
   \truncu_{M,N}(\pm \infty) &=& \{\} \\
   \truncu_{M,N}(\pm q) &=& \trunc(\pm q) & (\iff -1 < \trunc(\pm q) < 2^N) \\
   \truncu_{M,N}(\pm q) &=& \{\} & (\otherwise) \\
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.
   It is not defined for NaNs, infinities, or values for which the result is out of range.


.. _op-trunc_s:

:math:`\truncs_{M,N}(z)`
........................

* If :math:`z` is a NaN, then the result is undefined. 

* Else if :math:`z` is an infinity, then the result is undefined. 

* If :math:`z` is a number and :math:`\trunc(z)` is a value within range of the target type, then return that value.

* Else the result is undefined.

.. math::
   \begin{array}{lll@{\qquad}l}
   \truncs_{M,N}(\pm \NAN(n)) &=& \{\} \\
   \truncs_{M,N}(\pm \infty) &=& \{\} \\
   \truncs_{M,N}(\pm q) &=& \trunc(\pm q) & (\iff -2^{N-1} - 1 < \trunc(\pm q) < 2^{N-1}) \\
   \truncs_{M,N}(\pm q) &=& \{\} & (\otherwise) \\
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.
   It is not defined for NaNs, infinities, or values for which the result is out of range.


.. _op-trunc_sat_u:

:math:`\truncsatu_{M,N}(z)`
...........................

* If :math:`z` is a NaN, then return :math:`0`.

* Else if :math:`z` is negative infinity, then return :math:`0`.

* Else if :math:`z` is positive infinity, then return :math:`2^N - 1`.

* Else, return :math:`\satu_N(\trunc(z))`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \truncsatu_{M,N}(\pm \NAN(n)) &=& 0 \\
   \truncsatu_{M,N}(- \infty) &=& 0 \\
   \truncsatu_{M,N}(+ \infty) &=& 2^N - 1 \\
   \truncsatu_{M,N}(z) &=& \satu_N(\trunc(z)) \\
   \end{array}


.. _op-trunc_sat_s:

:math:`\truncsats_{M,N}(z)`
...........................

* If :math:`z` is a NaN, then return :math:`0`.

* Else if :math:`z` is negative infinity, then return :math:`-2^{N-1}`.

* Else if :math:`z` is positive infinity, then return :math:`2^{N-1} - 1`.

* Else, return :math:`\sats_N(\trunc(z))`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \truncsats_{M,N}(\pm \NAN(n)) &=& 0 \\
   \truncsats_{M,N}(- \infty) &=& -2^{N-1} \\
   \truncsats_{M,N}(+ \infty) &=& 2^{N-1}-1 \\
   \truncsats_{M,N}(z) &=& \sats_N(\trunc(z)) \\
   \end{array}


.. _op-promote:

:math:`\promote_{M,N}(z)`
.........................

* If :math:`z` is a :ref:`canonical NaN <canonical-nan>`, then return an element of :math:`\nans_N\{\}` (i.e., a canonical NaN of size :math:`N`).

* Else if :math:`z` is a NaN, then return an element of :math:`\nans_N\{\pm \NAN(1)\}` (i.e., any :ref:`arithmetic NaN <arithmetic-nan>` of size :math:`N`).

* Else, return :math:`z`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \promote_{M,N}(\pm \NAN(n)) &=& \nans_N\{\} & (\iff n = \canon_N) \\
   \promote_{M,N}(\pm \NAN(n)) &=& \nans_N\{+ \NAN(1)\} & (\otherwise) \\
   \promote_{M,N}(z) &=& z \\
   \end{array}


.. _op-demote:

:math:`\demote_{M,N}(z)`
........................

* If :math:`z` is a :ref:`canonical NaN <canonical-nan>`, then return an element of :math:`\nans_N\{\}` (i.e., a canonical NaN of size :math:`N`).

* Else if :math:`z` is a NaN, then return an element of :math:`\nans_N\{\pm \NAN(1)\}` (i.e., any NaN of size :math:`N`).

* Else if :math:`z` is an infinity, then return that infinity.

* Else if :math:`z` is a zero, then return that zero.

* Else, return :math:`\ieee_N(z)`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \demote_{M,N}(\pm \NAN(n)) &=& \nans_N\{\} & (\iff n = \canon_N) \\
   \demote_{M,N}(\pm \NAN(n)) &=& \nans_N\{+ \NAN(1)\} & (\otherwise) \\
   \demote_{M,N}(\pm \infty) &=& \pm \infty \\
   \demote_{M,N}(\pm 0) &=& \pm 0 \\
   \demote_{M,N}(\pm q) &=& \ieee_N(\pm q) \\
   \end{array}


.. _op-convert_u:

:math:`\convertu_{M,N}(i)`
..........................

* Return :math:`\ieee_N(i)`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \convertu_{M,N}(i) &=& \ieee_N(i) \\
   \end{array}


.. _op-convert_s:

:math:`\converts_{M,N}(i)`
..........................

* Let :math:`j` be the :ref:`signed interpretation <aux-signed>` of :math:`i`.

* Return :math:`\ieee_N(j)`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \converts_{M,N}(i) &=& \ieee_N(\signed_M(i)) \\
   \end{array}


.. _op-reinterpret:

:math:`\reinterpret_{t_1,t_2}(c)`
.................................

* Let :math:`d^\ast` be the bit sequence :math:`\bits_{t_1}(c)`.

* Return the constant :math:`c'` for which :math:`\bits_{t_2}(c') = d^\ast`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \reinterpret_{t_1,t_2}(c) &=& \bits_{t_2}^{-1}(\bits_{t_1}(c)) \\
   \end{array}


.. _op-narrow_s:

:math:`\narrows_{M,N}(i)`
.........................

* Let :math:`j` be the :ref:`signed interpretation <aux-signed>` of :math:`i` of size :math:`M`.

* Return :math:`\sats_N(j)`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \narrows_{M,N}(i) &=& \sats_N(\signed_M(i))
   \end{array}


.. _op-narrow_u:

:math:`\narrowu_{M,N}(i)`
.........................

* Let :math:`j` be the :ref:`signed interpretation <aux-signed>` of :math:`i` of size :math:`M`.

* Return :math:`\satu_N(j)`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \narrowu_{M,N}(i) &=& \satu_N(\signed_M(i))
   \end{array}

.. _relaxed-ops:

Relaxed operators
~~~~~~~~~~~~~~~~~

The result of *relaxed* operators are *host-dependent*, because the set of
possible results may depend on properties of the host environment (such as
hardware). Technically, each such operator produces a fixed-size *list of sets*
of allowed values.  For each execution of the operator in the same environment,
only values from the set at the same position in the list are returned, i.e.,
each environment globally chooses a fixed projection for each operator.

.. note::
   Each operator can be thought of as a family of operations that is fixed to
   one particular choice by the execution environment. The fixed operation
   itself can still be non-deterministic or partial.


.. _op-frmadd:

:math:`\frmadd_N(z_1, z_2, z_3)`
................................

Relaxed Multiply Add (madd) allows for fused or unfused results. :math:`fma` is
defined by |IEEE754|_ (Section 5.4.1) as *fusedMultiplyAdd*.

.. math::
   \begin{array}{@{}llcll}
   \EXPROFDET & \frmadd_N(z_1, z_2, z_3) &=& [ \fadd_N(\fmul_N(z_1, z_2), z_3), fma_N(z_1, z_2, z_3) ] \\
   & \frmadd_N(z_1, z_2, z_3) &=& \fadd_N(\fmul_N(z_1, z_2), z_3) \\
   \end{array}


.. _op-frnmadd:

:math:`\frnmadd_N(z_1, z_2, z_3)`
.................................

Relaxed Negative Multiply Add (nmadd) allows for fused or unfused results.

.. math::
   \begin{array}{@{}llcll}
   & \frnmadd_N(z_1, z_2, z_3) &=& \frmadd_N(-z_1, z_2, z_3) \\
   \end{array}


.. _op-rswizzle:

:math:`\rswizzle(a^n, s^n)`
...........................

Relaxed swizzle lane is deterministic
if the signed interpretation of the index is less than 16 (including negative values).
:math:`j` is a 8-bit int.

.. math::
   \begin{array}{@{}llcll}
   & relaxed\_swizzle\_lane(i^n, j) &=& i[j] & (\iff j < 16) \\
   & relaxed\_swizzle\_lane(i^n, j) &=& 0 & (\iff \signed_8(j) < 0) \\
   \EXPROFDET & relaxed\_swizzle\_lane(i^n, j) &=& [ 0, i[j \mod n] ] & (\otherwise) \\
   & relaxed\_swizzle\_lane(i^n, j) &=& 0 & (\otherwise) \\
   \\
   & \rswizzle(a^n, s^n) &=& rsl_0 \dots rsl_{n-1} \\
   & \qquad \where rsl_i &=& relaxed\_swizzle\_lane(a^n, s^n[i])
   \end{array}


.. _op-rtrunc:
.. _op-rtrunc_u:

:math:`\rtrunc^u_{M,N}(z)`
..........................

Relaxed truncate converts float to int, NaN and out of range values are
hardware dependent.

.. math::
   \begin{array}{@{}llcll}
   \EXPROFDET & \rtrunc^u_{M,N}(\pm \NAN(n)) &=& [ 0, 2^{N}-1 ] \\
   \EXPROFDET & \rtrunc^u_{M,N}(\pm q) &=& \truncu_{M,N}(\pm q) & (\iff -1 < \trunc(\pm q) < 2^N) \\
   \EXPROFDET & \rtrunc^u_{M,N}(\pm p) &=& [ \truncsatu_{M,N}(\pm p), 2^{N}-1 ] & (\otherwise) \\
   & \rtrunc^u_{M,N}(\pm p) &=& \truncsatu_{M,N}(\pm p) & (\otherwise) \\
   \end{array}


.. _op-rtrunc_s:

:math:`\rtrunc^s_{M,N}(z)`
..........................

Relaxed truncate converts float to int, NaN and out of range values are
hardware dependent.

.. math::
   \begin{array}{@{}llcll}
   \EXPROFDET & \rtrunc^s_{M,N}(\pm \NAN(n)) &=& [ 0, -2^{N-1} ] \\
   \EXPROFDET & \rtrunc^s_{M,N}(\pm q) &=& \truncs_{M,N}(\pm q) & (\iff -2^{N-1} - 1 < \trunc(\pm q) < 2^{N-1}) \\
   \EXPROFDET & \rtrunc^s_{M,N}(\pm p) &=& [ \truncsats_{M,N}(\pm p), -2^{N-1} ] & (\otherwise) \\
   & \rtrunc^s_{M,N}(\pm p) &=& \truncsats_{M,N}(\pm p) & (\otherwise) \\
   \end{array}


.. _op-rlaneselect:

:math:`\rlaneselect_B(a^n, b^n, c^n)`
.....................................

Relaxed lane select is deterministic where all bits are set or unset in the
mask. Otherwise depending on hardware, either only the top bit is examined, or
all bits are examined (becomes a bitselect).

.. math::
   \begin{array}{@{}llcll}
   & relaxed\_lane_N(i_1, i_2, 2^N-1) &=& i_1 \\
   & relaxed\_lane_N(i_1, i_2, 0) &=& i_2 \\
   \EXPROFDET & relaxed\_lane_N(i_1, i_2, i_3) &=& [ \ibitselect_N(i_1, i_2, i_3), i_1 ] & (\iff \signed_N(i_3) < 0) \\
   \EXPROFDET & relaxed\_lane_N(i_1, i_2, i_3) &=& [ \ibitselect_N(i_1, i_2, i_3), i_2 ] & (\otherwise) \\
   & relaxed\_lane_N(i_1, i_2, i_3) &=& \ibitselect_N(i_1, i_2, i_3) & (\otherwise) \\
   \\
   & \rlaneselect_B(a^n, b^n, c^n) &=& rll_0 \dots rll_{n-1} \\
   & \qquad \where rll_i &=& relaxed\_lane_B(a^n[i], b^n[i], c^n[i]) \\
   \end{array}


.. _op-frmin:

:math:`\frmin_N(z_1, z_2)`
..........................

Relaxed min differs from min when inputs are NaNs or different
signs of 0. It allows for implementation to return the first or second input
when either input is a NaN.

.. math::
   \begin{array}{@{}llcll}
   \EXPROFDET & \frmin_N(\pm \NAN(n), z_2) &=& [ \nans_N\{\pm \NAN(n), z_2\}, \NAN(n), z_2, z_2 ] \\
   \EXPROFDET & \frmin_N(z_1, \pm \NAN(n)) &=& [ \nans_N\{\pm \NAN(n), z_1\}, z_1, \NAN(n), z_1 ] \\
   \EXPROFDET & \frmin_N(\pm 0, \mp 0) &=& [ -0, \pm 0, \mp 0, -0 ] \\
   & \frmin_N(z_1, z_2) &=& \fmin_N(z_1, z_2) & (\otherwise) \\
   \end{array}


.. _op-frmax:

:math:`\frmax_N(z_1, z_2)`
..........................

Relaxed max differs from max when inputs are NaNs or different
signs of 0. It allows for implementation to return the first or second input
when either input is a NaN.

.. math::
   \begin{array}{@{}llcll}
   \EXPROFDET & \frmax_N(\pm \NAN(n), z_2) &=& [ \nans_N\{\pm \NAN(n), z_2\}, \NAN(n), z_2, z_2 ] \\
   \EXPROFDET & \frmax_N(z_1, \pm \NAN(n)) &=& [ \nans_N\{\pm \NAN(n), z_1\}, z_1, \NAN(n), z_1 ] \\
   \EXPROFDET & \frmax_N(\pm 0, \mp 0) &=& [ +0, \pm 0, \mp 0, +0 ] \\
   & \frmax_N(z_1, z_2) &=& \fmax_N(z_1, z_2) & (\otherwise) \\
   \end{array}


.. _op-irq15mulr_s:

:math:`\irq15mulrs_N(i_1, i_2)`
...............................

.. math::
   \begin{array}{@{}llcll}
   \EXPROFDET & \irq15mulrs_N(i_1, i_2) &=& [ \sats_N(i), i \mod 2^N ] & (\iff i = \ishrs_N(i_1 \cdot i_2 + 2^{14}, 15)) \\
   & \irq15mulrs_N(i_1, i_2) &=& \iq15mulrsats(i_1, i_2)
   \end{array}


.. _op-ridotmul:

:math:`\ridotmul_{M,N}(i_1, i_2)`
.................................

Relaxed integer dot product differs from integer dot product when the elements of the input have top bit set.

.. math::
   \begin{array}{@{}llcll}
   \EXPROFDET & \ridotmul_{M,N}(i_1, i_2) &=& [ \imul_N(\signed_M(i_1), i_2), \imul_N(\signed_M(i_1), \signed_M(i_2)) ] \\
   & \ridotmul_{M,N}(i_1, i_2) &=& \imul_N(\extends_{M,N}(i_1), \extends_{M,N}(i_2)) \\
   \end{array}

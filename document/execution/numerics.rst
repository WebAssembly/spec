.. _exec-numeric:

Numerics
--------

Auxiliary Operations
~~~~~~~~~~~~~~~~~~~~

.. todo::
   Describe; IEEE bytes

.. _aux-bytes:

.. math::
   \begin{array}{lll@{\qquad}l}
   \bytes_N(i) &=& \epsilon & (N = 0 \wedge i = 0) \\
   \bytes_N(i) &=& b~\bytes_{N-8}(j) & (N \geq 8 \wedge i = 2^8\cdot j + b) \\
   ~ \\
   \bytes_{\K{i}N}(i) &=& \bytes_N(i) \\
   \bytes_{\K{f}N}(z) &=& \F{reverse}(\dots) \\
   \end{array}

Note that |bytes| is a bijection, hence the function is invertible.

.. _aux-signed:

.. math::
   \begin{array}{lll@{\qquad}l}
   \signed_N(i) &=& i & (0 \leq i < 2^{N-1}) \\
   \signed_N(i) &=& i - 2^N & (2^{N-1} \leq i < 2^N) \\
   \end{array}

.. Note::
   The index :math:`N` of the |extend| function is the size extending *from*,
   where as the index of the |wrap| function is the size wrapping *to*.

.. _aux-truncate:

.. math::
   \begin{array}{lll@{\qquad}l}
   \truncate(\pm q) &=& \pm i & (q - 1 < i \leq q) \\
   \end{array}

.. _aux-bits:
.. _aux-bool:

.. math::
   \begin{array}{lll@{\qquad}l}
   \bits_N(i) &=& b_{N-1}~\dots~b_0 & (i = 2^{N-1}\cdot b_{N-1} + \dots + 2^0\cdot b_0) \\
   \bool(C) &=& (\mbox{if}~C) \\
   \bool(C) &=& (\mbox{otherwise}) \\
   \end{array}


.. math::
   \begin{array}{lll@{\qquad}l}
   \X{op}_{\K{i}N}(i) &=& \X{op}_N(i) \\
   \X{op}_{\K{f}N}(i) &=& \F{f}\X{op}_N(i) \\
   \end{array}

.. _aux-ieee:

.. math::
   \begin{array}{lll@{\qquad}l}
   \ieee_N(i) &=& \dots \\
   \end{array}

.. _aux-nan:

.. math::
   \begin{array}{lll@{\qquad}l}
   \nan_N\{z^\ast\} &=& \{ + \NAN(n), - \NAN(n) ~|~ n = \F{can}_N \} & (\forall \NAN(n) \in z^\ast,~ n = \F{can}_N) \\
   \nan_N\{z^\ast\} &=& \{ + \NAN(n), - \NAN(n) ~|~ n > \F{can}_N \} & (\mbox{otherwise}) \\
   \end{array}

where :math:`\F{can}_N = 2^{\payloadsize(N)-1}` is the :ref:`payload <syntax-payload>` of a *canonical* NaN, whose most significant bit is :math:`1` while all others are :math:`0`.


Integer Operations
~~~~~~~~~~~~~~~~~~

.. _op-add:

:math:`\addop_N(i_1, i_2)`
..........................

* Return the result of adding :math:`i_1` and :math:`i_2` modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \addop_N(i_1, i_2) &=& (i_1 + i_2) \mod 2^N
   \end{array}

.. _op-sub:

:math:`\subop_N(i_1, i_2)`
..........................

* Return the result of subtracting :math:`i_2` from :math:`i_1` modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \subop_N(i_1, i_2) &=& (i_1 - i_2 + 2^N) \mod 2^N
   \end{array}

.. _op-mul:

:math:`\mulop_N(i_1, i_2)`
..........................

* Return the result of multiplying :math:`i_1` and :math:`i_2` modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \mulop_N(i_1, i_2) &=& (i_1 \cdot i_2) \mod 2^N
   \end{array}

.. _op-div_u:

:math:`\divuop_N(i_1, i_2)`
...........................

* If :math:`i_2` is not :math:`0`, then:

  * Return the result of dividing :math:`i_1` by :math:`i_2`, truncated toward zero.

.. math::
   \begin{array}{@{}lcll}
   \divuop_N(i_1, i_2) &=& \truncate(i_1 / i_2) & (i_2 \neq 0)
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.

.. _op-div_s:

:math:`\divsop_N(i_1, i_2)`
...........................

* If :math:`i_2` is not :math:`0`, then:

  * Let :math:`j_1` be the signed interpretation of :math:`i_1`.

  * Let :math:`j_2` be the signed interpretation of :math:`i_2`.

  * Return the result of dividing :math:`j_1` by :math:`j_2`, truncated toward zero.

.. math::
   \begin{array}{@{}lcll}
   \divsop_N(i_1, i_2) &=& \signed_N^{-1}(\truncate(\signed_N(i_1) / \signed_N(i_2))) & (i_2 \neq 0)
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.

.. _op-rem_u:

:math:`\remuop_N(i_1, i_2)`
...........................

* If :math:`i_2` is not :math:`0`, then:

  * Return the remainder of dividing :math:`i_1` by :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \remuop_N(i_1, i_2) &=& i_1 - i_2 \cdot \truncate(i_1 / i_2) & (i_2 \neq 0)
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.

   As long as :math:`i_2 \neq 0` it holds that
   :math:`i_1 = i_2\cdot\divuop(i_1, i_2) + \remuop(i_1, i_2)`.

.. _op-rem_s:

:math:`\remsop_N(i_1, i_2)`
...........................

* If :math:`i_2` is not :math:`0`, then:

  * Let :math:`j_1` be the signed interpretation of :math:`i_1`.

  * Let :math:`j_2` be the signed interpretation of :math:`i_2`.

  * Return the remainder of dividing :math:`j_1` by :math:`j_2`, with the sign of the dividend :math:`j_1`.

.. math::
   \begin{array}{@{}lcll}
   \remsop_N(i_1, i_2) &=& \signed_N^{-1}(i_1 - i_2 \cdot \truncate(\signed_N(i_1) / \signed_N(i_2))) & (i_2 \neq 0)
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.

   As long as :math:`i_2 \neq 0` it holds that
   :math:`i_1 = i_2\cdot\divsop(i_1, i_2) + \remsop(i_1, i_2)`.


.. _op-and:

:math:`\andop_N(i_1, i_2)`
..........................

* Return the bitwise conjunction of :math:`i_1` and :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \andop_N(i_1, i_2) &=& \bits_N^{-1}(\bits_N(i_1) \wedge \bits_N(i_2))
   \end{array}

.. _op-or:

:math:`\orop_N(i_1, i_2)`
.........................

* Return the bitwise disjunction of :math:`i_1` and :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \orop_N(i_1, i_2) &=& \bits_N^{-1}(\bits_N(i_1) \vee \bits_N(i_2))
   \end{array}

.. _op-xor:

:math:`\xorop_N(i_1, i_2)`
..........................

* Return the bitwise exclusive disjunction of :math:`i_1` and :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \xorop_N(i_1, i_2) &=& \bits_N^{-1}(\bits_N(i_1) \veebar \bits_N(i_2))
   \end{array}

.. _op-shl:

:math:`\shlop_N(i_1, i_2)`
..........................

* Let :math:`k` be :math:`i_2` modulo :math:`N`.

* Return the result of shifting :math:`i_1` left by :math:`k` bits, modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \shlop_N(i_1, i_2) &=& \bits_N^{-1}(b_2^{N-k}~0^k) & (\bits_N(i_1) = b_1^k~b_2^{N-k} \wedge k = i_2 \mod N)
   \end{array}

.. _op-shr_u:

:math:`\shruop_N(i_1, i_2)`
...........................

* Let :math:`j_2` be :math:`i_2` modulo :math:`N`.

* Return the result of shifting :math:`i_1` right by :math:`j_2` bits, extended with :math:`0` bits.

.. math::
   \begin{array}{@{}lcll}
   \shruop_N(i_1, i_2) &=& \bits_N^{-1}(0^k~b_1^{N-k}) & (\bits_N(i_1) = b_1^{N-k}~b_2^k \wedge k = i_2 \mod N)
   \end{array}

.. _op-shr_s:

:math:`\shrsop_N(i_1, i_2)`
...........................

* Let :math:`j_2` be :math:`i_2` modulo :math:`N`.

* Return the result of shifting :math:`i_1` right by :math:`j_2` bits, extended with the most significant bit of the original value.

.. math::
   \begin{array}{@{}lcll}
   \shrsop_N(i_1, i_2) &=& \bits_N^{-1}(b_0^{k+1}~b_1^{N-k-1}) & (\bits_N(i_1) = b_0~b_1^{N-k-1}~b_2^k \wedge k = i_2 \mod N)
   \end{array}

.. _op-rotl:

:math:`\rotlop_N(i_1, i_2)`
...........................

* Let :math:`j_2` be :math:`i_2` modulo :math:`N`.

* Return the result of rotating :math:`i_1` left by :math:`j_2` bits.

.. math::
   \begin{array}{@{}lcll}
   \rotlop_N(i_1, i_2) &=& \bits_N^{-1}(b_2^{N-k}~b_1^k) & (\bits_N(i_1) = b_1^k~b_2^{N-k} \wedge k = i_2 \mod N)
   \end{array}

.. _op-rotr:

:math:`\rotrop_N(i_1, i_2)`
...........................

* Let :math:`j_2` be :math:`i_2` modulo :math:`N`.

* Return the result of rotating :math:`i_1` right by :math:`j_2` bits.

.. math::
   \begin{array}{@{}lcll}
   \rotrop_N(i_1, i_2) &=& \bits_N^{-1}(b_2^k~b_1^{N-k}) & (\bits_N(i_1) = b_1^{N-k}~b_2^k \wedge k = i_2 \mod N)
   \end{array}


.. _op-clz:

:math:`\clzop_N(i)`
...................

* Return the count of leading zero bits in :math:`i`; all bits are considered leading zeros if :math:`i` is :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \clzop_N(i) &=& k & (\bits_N(i) = 0^k~(1~b^\ast)^?)
   \end{array}


.. _op-ctz:

:math:`\ctzop_N(i)`
...................

* Return the count of trailing zero bits in :math:`i`; all bits are considered trailing zeros if :math:`i` is :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \ctzop_N(i) &=& k & (\bits_N(i) = (b^\ast~1)^?~0^k)
   \end{array}


.. _op-popcnt:

:math:`\popcntop_N(i)`
......................

* Return the count of non-zero bits in :math:`i`.

.. math::
   \begin{array}{@{}lcll}
   \popcntop_N(i) &=& k & (\bits_N(i) = (0^\ast~1)^k~0^\ast)
   \end{array}


.. _op-eqz:

:math:`\eqzop_N(i)`
...................

* Return :math:`1` if :math:`i` is zero, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \eqzop_N(i) &=& \bool(i = 0)
   \end{array}


.. _op-eq:

:math:`\eqop_N(i_!, i_2)`
.........................

* Return :math:`1` if :math:`i_1` equals :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \eqop_N(i_1, i_2) &=& \bool(i_1 = i_2)
   \end{array}


.. _op-ne:

:math:`\neop_N(i_!, i_2)`
.........................

* Return :math:`1` if :math:`i_1` does not equal :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \neop_N(i_1, i_2) &=& \bool(i_1 \neq i_2)
   \end{array}


.. _op-lt_u:

:math:`\ltuop_N(i_!, i_2)`
..........................

* Return :math:`1` if :math:`i_1` is less than :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \ltuop_N(i_1, i_2) &=& \bool(i_1 < i_2)
   \end{array}


.. _op-lt_s:

:math:`\ltsop_N(i_!, i_2)`
..........................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`.

* Let :math:`j_2` be the signed interpretation of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is less than :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \ltsop_N(i_1, i_2) &=& \bool(\signed_N(i_1) < \signed_N(i_2))
   \end{array}


.. _op-gt_u:

:math:`\gtuop_N(i_!, i_2)`
..........................

* Return :math:`1` if :math:`i_1` is greater than :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \gtuop_N(i_1, i_2) &=& \bool(i_1 > i_2)
   \end{array}


.. _op-gt_s:

:math:`\gtsop_N(i_!, i_2)`
..........................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`.

* Let :math:`j_2` be the signed interpretation of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is greater than :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \gtsop_N(i_1, i_2) &=& \bool(\signed_N(i_1) > \signed_N(i_2))
   \end{array}


.. _op-le_u:

:math:`\leuop_N(i_!, i_2)`
..........................

* Return :math:`1` if :math:`i_1` is less than or equal to :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \leuop_N(i_1, i_2) &=& \bool(i_1 \leq i_2)
   \end{array}


.. _op-le_s:

:math:`\lesop_N(i_!, i_2)`
..........................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`.

* Let :math:`j_2` be the signed interpretation of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is less than or equal to :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \lesop_N(i_1, i_2) &=& \bool(\signed_N(i_1) \leq \signed_N(i_2))
   \end{array}


.. _op-ge_u:

:math:`\geuop_N(i_!, i_2)`
..........................

* Return :math:`1` if :math:`i_1` is greater than or equal to :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \geuop_N(i_1, i_2) &=& \bool(i_1 \geq i_2)
   \end{array}


.. _op-ge_s:

:math:`\gesop_N(i_!, i_2)`
..........................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`.

* Let :math:`j_2` be the signed interpretation of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is greater than or equal to :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \gesop_N(i_1, i_2) &=& \bool(\signed_N(i_1) \geq \signed_N(i_2))
   \end{array}


Floating-Point Operations
~~~~~~~~~~~~~~~~~~~~~~~~~

Floating-point arithmetic follows the `IEEE 754-2008 <http://ieeexplore.ieee.org/document/4610935/>`_ standard,
with the following qualifications:

* Following the recommendation that operations propagate NaN bits from their operands is permitted but not required.

* WebAssembly uses "non-stop" mode, and floating-point exceptions are not otherwise observable.
  In particular, neither alternate floating-point exception handling attributes nor operators on status flags are supported.
  There is no observable difference between quiet and signalling NaN.

* All operations use the round-to-nearest ties-to-even rounding,
  except where otherwise specified.
  Non-default directed rounding attributes are not supported.

.. note::
   Some of these limitations may be lifted in future versions of WebAssembly.

When the result of any arithmetic operation other than |fnegop|, |fabsop|, or |fcopysignop| is a NaN, the sign bit and the fraction field (which does not include the implicit leading digit of the significand) of the NaN are computed as follows:

* If the fraction fields of all NaN inputs to the operation all consist of 1 in the most significant bit and 0 in the remaining bits, or if there are no NaN inputs, the result is a NaN with a nondeterministic sign bit, 1 in the most significant bit of the fraction field, and all zeros in the remaining bits of the fraction field.

* Otherwise the result is a NaN with a nondeterministic sign bit, 1 in the most significant bit of the fraction field, and nondeterminsitic values in the remaining bits of the fraction field.


.. _op-fadd:

:math:`\faddop_N(z_1, z_2)`
...........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return an element of :math:`\nan_N\{z_1, z_2\}`.

* Else if both :math:`z_1` and :math:`z_2` are infinities of opposite signs, then return an element of :math:`\nan_N\{z_1, z_2\}`.

* Else if both :math:`z_1` and :math:`z_2` are infinities of equal sign, then return that infinity.

* Else if one of :math:`z_1` or :math:`z_2` is an infinity, then return that infinity.

* Else if both :math:`z_1` and :math:`z_2` are zeroes of opposite sign, then return positive zero.

* Else if both :math:`z_1` and :math:`z_2` are zeroes of equal sign, then return that zero.

* Else if one of :math:`z_1` or :math:`z_2` is a zero, then return the other operand.

* Else if both :math:`z_1` and :math:`z_2` are values with the same magnitude but opposite signs, then return positive zero.

* Else return the result of adding :math:`z_1` and :math:`z_2`, rounded to the nearest representable value using round to nearest, ties to even mode; if the magnitude is too large to represent, return an infinity of appropriate sign.

.. math::
   \begin{array}{@{}lcll}
   \faddop_N(\pm \NAN(n), z_2) &\in& \nan_N\{\pm \NAN(n), z_2\} \\
   \faddop_N(z_1, \pm \NAN(n)) &\in& \nan_N\{\pm \NAN(n), z_1\} \\
   \faddop_N(\pm \infty, \mp \infty) &\in& \nan_N\{\} \\
   \faddop_N(\pm \infty, \pm \infty) &=& \pm \infty \\
   \faddop_N(z_1, \pm \infty) &=& \pm \infty \\
   \faddop_N(\pm \infty, z_2) &=& \pm \infty \\
   \faddop_N(\pm 0, \mp 0) &=& +0 \\
   \faddop_N(\pm 0, \pm 0) &=& \pm 0 \\
   \faddop_N(z_1, \pm 0) &=& z_1 \\
   \faddop_N(\pm 0, z_2) &=& z_2 \\
   \faddop_N(\pm q, \mp q) &=& +0 \\
   \faddop_N(z_1, z_2) &=& \ieee_N(z_1 + z_2) \\
   \end{array}


.. _op-fsub:

:math:`\fsubop_N(z_1, z_2)`
...........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return an element of :math:`\nan_N\{z_1, z_2\}`.

* Else if both :math:`z_1` and :math:`z_2` are infinities of equal signs, then return an element of :math:`\nan_N\{z_1, z_2\}`.

* Else if both :math:`z_1` and :math:`z_2` are infinities of opposite sign, then return :math:`z_1`.

* Else if :math:`z_1` is an infinity, then return that infinity.

* Else if :math:`z_2` is an infinity, then return that infinity negated.

* Else if both :math:`z_1` and :math:`z_2` are zeroes of equal sign, then return positive zero.

* Else if both :math:`z_1` and :math:`z_2` are zeroes of opposite sign, then return :math:`z_1`.

* Else if :math:`z_2` is a zero, then return :math:`z_1`.

* Else if :math:`z_1` is a zero, then return :math:`z_2` negated.

* Else if both :math:`z_1` and :math:`z_2` are the same value, then return positive zero.

* Else return the result of subtracting :math:`z_2` from :math:`z_1`, rounded to the nearest representable value using round to nearest, ties to even mode; if the magnitude is too large to represent, return an infinity of appropriate sign.

.. math::
   \begin{array}{@{}lcll}
   \fsubop_N(\pm \NAN(n), z_2) &\in& \nan_N\{\pm \NAN(n), z_2\} \\
   \fsubop_N(z_1, \pm \NAN(n)) &\in& \nan_N\{\pm \NAN(n), z_1\} \\
   \fsubop_N(\pm \infty, \pm \infty) &\in& \nan_N\{\} \\
   \fsubop_N(\pm \infty, \mp \infty) &=& \pm \infty \\
   \fsubop_N(z_1, \pm \infty) &=& \mp \infty \\
   \fsubop_N(\pm \infty, z_2) &=& \pm \infty \\
   \fsubop_N(\pm 0, \pm 0) &=& +0 \\
   \fsubop_N(\pm 0, \mp 0) &=& \pm 0 \\
   \fsubop_N(z_1, \pm 0) &=& z_1 \\
   \fsubop_N(\pm 0, \pm q_2) &=& \mp q_2 \\
   \fsubop_N(\pm q, \pm q) &=& +0 \\
   \fsubop_N(z_1, z_2) &=& \ieee_N(z_1 - z_2) \\
   \end{array}

.. note::
   Up to the non-determinism regarding NaNs, it always holds that :math:`\fsubop_N(z_1, z_2) = \faddop_N(z_1, \fnegop_N(z_2))`.


.. _op-fmul:

:math:`\fmulop_N(z_1, z_2)`
...........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return an element of :math:`\nan_N\{z_1, z_2\}`.

* Else if one of :math:`z_1` and :math:`z_2` is a zero and the other an infinity, then return an element of :math:`\nan_N\{z_1, z_2\}`.

* Else if both :math:`z_1` and :math:`z_2` are infinities of equal sign, then return positive infinity.

* Else if both :math:`z_1` and :math:`z_2` are infinities of opposite sign, then return negative infinity.

* Else if one of :math:`z_1` or :math:`z_2` is an infinity and the other a value with equal sign, then return positive infinity.

* Else if one of :math:`z_1` or :math:`z_2` is an infinity and the other a value with opposite sign, then return negative infinity.

* Else return the result of multiplying :math:`z_1` and :math:`z_2`, rounded to the nearest representable value using round to nearest, ties to even mode; if the magnitude is too large to represent, return an infinity of appropriate sign.

.. math::
   \begin{array}{@{}lcll}
   \fmulop_N(\pm \NAN(n), z_2) &\in& \nan_N\{\pm \NAN(n), z_2\} \\
   \fmulop_N(z_1, \pm \NAN(n)) &\in& \nan_N\{\pm \NAN(n), z_1\} \\
   \fmulop_N(\pm \infty, \pm 0) &\in& \nan_N\{\} \\
   \fmulop_N(\pm \infty, \mp 0) &\in& \nan_N\{\} \\
   \fmulop_N(\pm 0, \pm \infty) &\in& \nan_N\{\} \\
   \fmulop_N(\pm 0, \mp \infty) &\in& \nan_N\{\} \\
   \fmulop_N(\pm \infty, \pm \infty) &=& +\infty \\
   \fmulop_N(\pm \infty, \mp \infty) &=& -\infty \\
   \fmulop_N(\pm q_1, \pm \infty) &=& +\infty \\
   \fmulop_N(\pm q_1, \mp \infty) &=& -\infty \\
   \fmulop_N(\pm \infty, \pm q_2) &=& +\infty \\
   \fmulop_N(\pm \infty, \mp q_2) &=& -\infty \\
   \fmulop_N(z_1, z_2) &=& \ieee_N(z_1 \cdot z_2) \\
   \end{array}


.. _op-fdiv:

:math:`\fdivop_N(z_1, z_2)`
...........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return an element of :math:`\nan_N\{z_1, z_2\}`.

* Else if both :math:`z_1` and :math:`z_2` are infinities, then return an element of :math:`\nan_N\{z_1, z_2\}`.

* Else if both :math:`z_1` and :math:`z_2` are zeroes, then return an element of :math:`\nan_N\{z_1, z_2\}`.

* Else if :math:`z_1` is an infinity and :math:`z_2` a value with equal sign, then return positive infinity.

* Else if :math:`z_1` is an infinity and :math:`z_2` a value with opposite sign, then return negative infinity.

* Else if :math:`z_2` is an infinity and :math:`z_1` a value with equal sign, then return positive zero.

* Else if :math:`z_2` is an infinity and :math:`z_1` a value with opposite sign, then return negative zero.

* Else if :math:`z_2` is a zero and :math:`z_1` a value with equal sign, then return positive infinity.

* Else if :math:`z_2` is a zero and :math:`z_1` a value with opposite sign, then return negative infinity.

* Else return the result of dividing :math:`z_2` by :math:`z_1`, rounded to the nearest representable value using round to nearest, ties to even mode; if the magnitude is too large to represent, return an infinity of appropriate sign.

.. math::
   \begin{array}{@{}lcll}
   \fdivop_N(\pm \NAN(n), z_2) &\in& \nan_N\{\pm \NAN(n), z_2\} \\
   \fdivop_N(z_1, \pm \NAN(n)) &\in& \nan_N\{\pm \NAN(n), z_1\} \\
   \fdivop_N(\pm \infty, \pm \infty) &\in& \nan_N\{\} \\
   \fdivop_N(\pm \infty, \mp \infty) &\in& \nan_N\{\} \\
   \fdivop_N(\pm 0, \pm 0) &\in& \nan_N\{\} \\
   \fdivop_N(\pm 0, \mp 0) &\in& \nan_N\{\} \\
   \fdivop_N(\pm \infty, \pm q_2) &=& +\infty \\
   \fdivop_N(\pm \infty, \mp q_2) &=& -\infty \\
   \fdivop_N(\pm q_1, \pm \infty) &=& +0 \\
   \fdivop_N(\pm q_1, \mp \infty) &=& -0 \\
   \fdivop_N(\pm q_1, \pm 0) &=& +\infty \\
   \fdivop_N(\pm q_1, \mp 0) &=& -\infty \\
   \fdivop_N(z_1, z_2) &=& \ieee_N(z_1 / z_2) \\
   \end{array}


.. _op-fmin:

:math:`\fminop_N(z_1, z_2)`
...........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return an element of :math:`\nan_N\{z_1, z_2\}`.

* Else if one of :math:`z_1` or :math:`z_2` is a negative infinity, then return negative infinity.

* Else if one of :math:`z_1` or :math:`z_2` is a positive infinity, then return the other value.

* Else if both :math:`z_1` and :math:`z_2` are zeroes of opposite signs, then return negative zero.

* Else return the smaller value of :math:`z_1` and :math:`z_2`.

.. math::
   \begin{array}{@{}lcll}
   \fminop_N(\pm \NAN(n), z_2) &\in& \nan_N\{\pm \NAN(n), z_2\} \\
   \fminop_N(z_1, \pm \NAN(n)) &\in& \nan_N\{\pm \NAN(n), z_1\} \\
   \fminop_N(- \infty, z_2) &=& - \infty \\
   \fminop_N(z_1, - \infty) &=& - \infty \\
   \fminop_N(+ \infty, z_2) &=& z_2 \\
   \fminop_N(z_1, + \infty) &=& z_1 \\
   \fminop_N(\pm 0, \mp 0) &=& -0 \\
   \fminop_N(z_1, z_2) &=& z_1 & (z_1 \leq z_2) \\
   \fminop_N(z_1, z_2) &=& z_2 & (z_2 \leq z_1) \\
   \end{array}


.. _op-fmax:

:math:`\fmaxop_N(z_1, z_2)`
...........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return an element of :math:`\nan_N\{z_1, z_2\}`.

* Else if one of :math:`z_1` or :math:`z_2` is a positive infinity, then return positive infinity.

* Else if one of :math:`z_1` or :math:`z_2` is a negative infinity, then return the other value.

* Else if both :math:`z_1` and :math:`z_2` are zeroes of opposite signs, then return positive zero.

* Else return the larger value of :math:`z_1` and :math:`z_2`.

.. math::
   \begin{array}{@{}lcll}
   \fmaxop_N(\pm \NAN(n), z_2) &\in& \nan_N\{\pm \NAN(n), z_2\} \\
   \fmaxop_N(z_1, \pm \NAN(n)) &\in& \nan_N\{\pm \NAN(n), z_1\} \\
   \fmaxop_N(+ \infty, z_2) &=& + \infty \\
   \fmaxop_N(z_1, + \infty) &=& + \infty \\
   \fmaxop_N(- \infty, z_2) &=& z_2 \\
   \fmaxop_N(z_1, - \infty) &=& z_1 \\
   \fmaxop_N(\pm 0, \mp 0) &=& +0 \\
   \fmaxop_N(z_1, z_2) &=& z_1 & (z_1 \geq z_2) \\
   \fmaxop_N(z_1, z_2) &=& z_2 & (z_2 \geq z_1) \\
   \end{array}


.. _op-fcopysign:

:math:`\fcopysignop_N(z_1, z_2)`
................................

* If :math:`z_1` and :math:`z_2` have the same sign, then return :math:`z_1`.

* Else return :math:`z_1` with negated sign.

.. math::
   \begin{array}{@{}lcll}
   \fcopysignop_N(\pm p_1, \pm p_2) &=& \pm p_1 \\
   \fcopysignop_N(\pm p_1, \mp p_2) &=& \mp p_1 \\
   \end{array}


.. _op-fabs:

:math:`\fabsop_N(z)`
....................

* If :math:`z` is a NaN, then return :math:`z` with positive sign.

* Else if :math:`z` is an infinity, then return positive infinity.

* Else if :math:`z` is a zero, then return positive zero.

* Else if :math:`z` is a positive value, then :math:`z`.

* Else return :math:`z` negated.

.. math::
   \begin{array}{@{}lcll}
   \fabsop_N(\pm \NAN(n)) &=& +\NAN(n) \\
   \fabsop_N(\pm \infty) &=& +\infty \\
   \fabsop_N(\pm 0) &=& +0 \\
   \fabsop_N(\pm q) &=& +q \\
   \end{array}


.. _op-fneg:

:math:`\fnegop_N(z)`
....................

* If :math:`z` is a NaN, then return :math:`z` with negated sign.

* Else if :math:`z` is an infinity, then return that infinity negated.

* Else if :math:`z` is a zero, then return that zero negated.

* Else return :math:`z` negated.

.. math::
   \begin{array}{@{}lcll}
   \fnegop_N(\pm \NAN(n)) &=& \mp \NAN(n) \\
   \fnegop_N(\pm \infty) &=& \mp \infty \\
   \fnegop_N(\pm 0) &=& \mp 0 \\
   \fnegop_N(\pm z) &=& \mp z \\
   \end{array}


.. _op-fsqrt:

:math:`\fsqrtop_N(z)`
.....................

* If :math:`z` is a NaN, then return an element of :math:`\nan_N\{z\}`.

* Else if :math:`z` has a negative sign, then return an element of :math:`\nan_N\{z\}`.

* Else if :math:`z` is positive infinity, then return positive infinity.

* Else if :math:`z` is a zero, then return that zero.

* Else return the square root of :math:`z`.

.. math::
   \begin{array}{@{}lcll}
   \fsqrtop_N(\pm \NAN(n)) &\in& \nan_N\{\pm \NAN(n)\} \\
   \fsqrtop_N(- \infty) &\in& \nan_N\{\} \\
   \fsqrtop_N(+ \infty) &=& + \infty \\
   \fsqrtop_N(\pm 0) &=& \pm 0 \\
   \fsqrtop_N(- q) &\in& \nan_N\{\} \\
   \fsqrtop_N(+ q) &=& \ieee_N\left(\sqrt{z}\right) \\
   \end{array}


.. _op-fceil:

:math:`\fceilop_N(z)`
.....................

* If :math:`z` is a NaN, then return an element of :math:`\nan_N\{z\}`.

* Else if :math:`z` is an infinity, then return :math:`z`.

* Else if :math:`z` is a zero, then return :math:`z`.

* Else if :math:`z` is smaller than :math:`0` but greater than :math:`-1`, then return negative zero.

* Else return the smallest integral value that is not smaller than :math:`z`.

.. math::
   \begin{array}{@{}lcll}
   \fceilop_N(\pm \NAN(n)) &\in& \nan_N\{\pm \NAN(n)\} \\
   \fceilop_N(\pm \infty) &=& \pm \infty \\
   \fceilop_N(\pm 0) &=& \pm 0 \\
   \fceilop_N(- q) &=& -0 & (-1 < -q < 0) \\
   \fceilop_N(\pm q) &=& \ieee_N(i) & (\pm q \leq i < \pm q + 1) \\
   \end{array}


.. _op-ffloor:

:math:`\ffloorop_N(z)`
......................

* If :math:`z` is a NaN, then return an element of :math:`\nan_N\{z\}`.

* Else if :math:`z` is an infinity, then return :math:`z`.

* Else if :math:`z` is a zero, then return :math:`z`.

* Else if :math:`z` is greater than :math:`0` but smaller than :math:`1`, then return positive zero.

* Else return the largest integral value that is not larger than :math:`z`.

.. math::
   \begin{array}{@{}lcll}
   \ffloorop_N(\pm \NAN(n)) &\in& \nan_N\{\pm \NAN(n)\} \\
   \ffloorop_N(\pm \infty) &=& \pm \infty \\
   \ffloorop_N(\pm 0) &=& \pm 0 \\
   \ffloorop_N(+ q) &=& +0 & (0 < +q < 1) \\
   \ffloorop_N(\pm q) &=& \ieee_N(i) & (\pm q - 1 < i \leq \pm q) \\
   \end{array}


.. _op-ftrunc:

:math:`\ftruncop_N(z)`
......................

* If :math:`z` is a NaN, then return an element of :math:`\nan_N\{z\}`.

* Else if :math:`z` is an infinity, then return :math:`z`.

* Else if :math:`z` is a zero, then return :math:`z`.

* Else if :math:`z` is greater than :math:`0` but smaller than :math:`1`, then return positive zero.

* Else if :math:`z` is smaller than :math:`0` but greater than :math:`-1`, then return negative zero.

* Else return the integral value with the same sign as :math:`z` and the largest magnitude that is not larger than the magnitude of :math:`z`.

.. math::
   \begin{array}{@{}lcll}
   \ftruncop_N(\pm \NAN(n)) &\in& \nan_N\{\pm \NAN(n)\} \\
   \ftruncop_N(\pm \infty) &=& \pm \infty \\
   \ftruncop_N(\pm 0) &=& \pm 0 \\
   \ftruncop_N(+ q) &=& +0 & (0 < +q < 1) \\
   \ftruncop_N(- q) &=& -0 & (-1 < -q < 0) \\
   \ftruncop_N(\pm q) &=& \ieee_N(\pm i) & (+q - 1 < i \leq +q) \\
   \end{array}


.. _op-fnearest:

:math:`\fnearestop_N(z)`
........................

* If :math:`z` is a NaN, then return an element of :math:`\nan_N\{z\}`.

* Else if :math:`z` is an infinity, then return :math:`z`.

* Else if :math:`z` is a zero, then return :math:`z`.

* Else if :math:`z` is greater than :math:`0` but smaller than :math:`0.5`, then return positive zero.

* Else if :math:`z` is smaller than :math:`0` but greater than or equal to :math:`-0.5`, then return negative zero.

* Else return the integral value that is nearest to :math:`z`; if two values are equally near, return the even one.

.. math::
   \begin{array}{@{}lcll}
   \fnearestop_N(\pm \NAN(n)) &\in& \nan_N\{\pm \NAN(n)\} \\
   \fnearestop_N(\pm \infty) &=& \pm \infty \\
   \fnearestop_N(\pm 0) &=& \pm 0 \\
   \fnearestop_N(+ q) &=& +0 & (0 < +q \leq 0.5) \\
   \fnearestop_N(- q) &=& -0 & (-0.5 \leq -q < 0) \\
   \fnearestop_N(\pm q) &=& \ieee_N(\pm i) & (|i - q| < 0.5) \\
   \fnearestop_N(\pm q) &=& \ieee_N(\pm i) & (|i - q| = 0.5 \wedge i~\mbox{even}) \\
   \end{array}


.. _op-feq:

:math:`\feqop_N(z_1, z_2)`
..........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return :math:`0`.

* Else if both :math:`z_1` and :math:`z_2` are zeroes, then return :math:`1`.

* Else if both :math:`z_1` and :math:`z_2` are the same value, then return :math:`1`.

* Else return :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \feqop_N(\pm \NAN(n), z_2) &=& 0 \\
   \feqop_N(z_1, \pm \NAN(n)) &=& 0 \\
   \feqop_N(\pm 0, \mp 0) &=& 1 \\
   \feqop_N(z, z) &=& 1 \\
   \feqop_N(z_1, z_2) &=& 0 \\
   \end{array}


.. _op-fne:

:math:`\fneop_N(z_1, z_2)`
..........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return :math:`0`.

* Else if both :math:`z_1` and :math:`z_2` are zeroes, then return :math:`0`.

* Else if both :math:`z_1` and :math:`z_2` are the same value, then return :math:`0`.

* Else return :math:`1`.

.. math::
   \begin{array}{@{}lcll}
   \fneop_N(\pm \NAN(n), z_2) &=& 0 \\
   \fneop_N(z_1, \pm \NAN(n)) &=& 0 \\
   \fneop_N(\pm 0, \mp 0) &=& 0 \\
   \fneop_N(z, z) &=& 0 \\
   \fneop_N(z_1, z_2) &=& 1 \\
   \end{array}


.. _op-flt:

:math:`\fltop_N(z_1, z_2)`
..........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return :math:`0`.

* Else if :math:`z_1` and :math:`z_2` are the same value, then return :math:`0`.

* Else if :math:`z_1` is negative infinity, then return :math:`1`.

* Else if :math:`z_2` is positive infinity, then return :math:`1`.

* Else if both :math:`z_1` and :math:`z_2` are zeroes, then return :math:`0`.

* Else if :math:`z_1` is smaller than :math:`z_2`, then return :math:`1`.

* Else return :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \fltop_N(\pm \NAN(n), z_2) &=& 0 \\
   \fltop_N(z_1, \pm \NAN(n)) &=& 0 \\
   \fltop_N(z, z) &=& 0 \\
   \fltop_N(- \infty, z_2) &=& 1 \\
   \fltop_N(z_1, + \infty) &=& 1 \\
   \fltop_N(\pm 0, \mp 0) &=& 0 \\
   \fltop_N(z_1, z_2) &=& \bool(z_1 < z_2) \\
   \end{array}


.. _op-fgt:

:math:`\fgtop_N(z_1, z_2)`
..........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return :math:`0`.

* Else if :math:`z_1` and :math:`z_2` are the same value, then return :math:`0`.

* Else if :math:`z_1` is positive infinity, then return :math:`1`.

* Else if :math:`z_2` is negative infinity, then return :math:`1`.

* Else if both :math:`z_1` and :math:`z_2` are zeroes, then return :math:`0`.

* Else if :math:`z_1` is larger than :math:`z_2`, then return :math:`1`.

* Else return :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \fgtop_N(\pm \NAN(n), z_2) &=& 0 \\
   \fgtop_N(z_1, \pm \NAN(n)) &=& 0 \\
   \fgtop_N(z, z) &=& 0 \\
   \fgtop_N(+ \infty, z_2) &=& 1 \\
   \fgtop_N(z_1, - \infty) &=& 1 \\
   \fgtop_N(\pm 0, \mp 0) &=& 0 \\
   \fgtop_N(z_1, z_2) &=& \bool(z_1 > z_2) \\
   \end{array}


.. _op-fle:

:math:`\fleop_N(z_1, z_2)`
..........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return :math:`0`.

* Else if :math:`z_1` and :math:`z_2` are the same value, then return :math:`1`.

* Else if :math:`z_1` is negative infinity, then return :math:`1`.

* Else if :math:`z_2` is positive infinity, then return :math:`1`.

* Else if both :math:`z_1` and :math:`z_2` are zeroes, then return :math:`1`.

* Else if :math:`z_1` is smaller than or equal to :math:`z_2`, then return :math:`1`.

* Else return :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \fleop_N(\pm \NAN(n), z_2) &=& 0 \\
   \fleop_N(z_1, \pm \NAN(n)) &=& 0 \\
   \fleop_N(z, z) &=& 1 \\
   \fleop_N(- \infty, z_2) &=& 1 \\
   \fleop_N(z_1, + \infty) &=& 1 \\
   \fleop_N(\pm 0, \mp 0) &=& 1 \\
   \fleop_N(z_1, z_2) &=& \bool(z_1 \leq z_2) \\
   \end{array}


.. _op-fge:

:math:`\fgeop_N(z_1, z_2)`
..........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return :math:`0`.

* Else if :math:`z_1` and :math:`z_2` are the same value, then return :math:`1`.

* Else if :math:`z_1` is positive infinity, then return :math:`1`.

* Else if :math:`z_2` is negative infinity, then return :math:`1`.

* Else if both :math:`z_1` and :math:`z_2` are zeroes, then return :math:`1`.

* Else if :math:`z_1` is smaller than or equal to :math:`z_2`, then return :math:`1`.

* Else return :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \fgeop_N(\pm \NAN(n), z_2) &=& 0 \\
   \fgeop_N(z_1, \pm \NAN(n)) &=& 0 \\
   \fgeop_N(z, z) &=& 1 \\
   \fgeop_N(+ \infty, z_2) &=& 1 \\
   \fgeop_N(z_1, - \infty) &=& 1 \\
   \fgeop_N(\pm 0, \mp 0) &=& 1 \\
   \fgeop_N(z_1, z_2) &=& \bool(z_1 \geq z_2) \\
   \end{array}


Conversions
~~~~~~~~~~~

.. _op-extendu:

:math:`\extendu_{M,N}(i)`
.........................

* Return :math:`i`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \extendu_{M,N}(i) &=& i \\
   \end{array}

.. note::
   In the abstract syntax, unsigned extension just reinterprets the same value.


.. _op-extends:

:math:`\extends_{M,N}(i)`
.........................

* Let :math:`j` be the signed interpretation of :math:`i` of size :math:`M`.

* Return the 2's complement of :math:`j` relative to size :math:`N`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \extends_{M,N}(i) &=& \signed_N^{-1}(\signed_M(i)) \\
   \end{array}


.. _op-wrap:

:math:`\wrap_{M,N}(i)`
......................

* Return :math:`i` modulo :math:`N`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \wrap_{M,N}(i) &=& i \mod 2^N \\
   \end{array}


.. _op-truncu:

:math:`\truncu_{M,N}(z)`
........................

* If :math:`z` is a number and :math:`\truncate(z)` is a value within range of the target type, return that value.

.. math::
   \begin{array}{lll@{\qquad}l}
   \truncu_{M,N}(\pm 0) &=& 0 \\
   \truncu_{M,N}(\pm q) &=& \truncate(\pm q) & (0 \leq \truncate(\pm q) < 2^N) \\
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.
   It is not defined for NaNs, infinities, or values for which the result is out of range.


.. _op-truncs:

:math:`\truncs_{M,N}(z)`
........................

* If :math:`z` is a number and :math:`\truncate(z)` is a value within range of the target type, return that value.

.. math::
   \begin{array}{lll@{\qquad}l}
   \truncs_{M,N}(\pm 0) &=& 0 \\
   \truncs_{M,N}(\pm q) &=& \truncate(\pm q) & (2^{N-1} \leq \truncate(\pm q) < 2^{N-1}) \\
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.
   It is not defined for NaNs, infinities, or values for which the result is out of range.


.. _op-promote:

:math:`\promote_{M,N}(z)`
.........................

* If :math:`z` is a :ref:`canonical NaN <canonical-nan>`, then return a element of :math:`\nan_N\{\}` (i.e., a canonical NaN of size :math:`N`).

* Else if :math:`z` is a NaN, then return a element of :math:`\nan_N\{\pm \NAN(1)\}` (i.e., any NaN of size :math:`N`).

* Else, return :math:`z`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \promote_{M,N}(\pm \NAN(n)) &=& \nan_N\{\} & (n = \F{can}_N) \\
   \promote_{M,N}(\pm \NAN(n)) &=& \nan_N\{\pm \NAN(1)\} & (\mbox{otherwise}) \\
   \promote_{M,N}(z) &=& z \\
   \end{array}


.. _op-demote:

:math:`\demote_{M,N}(z)`
........................

* If :math:`z` is a :ref:`canonical NaN <canonical-nan>`, then return a element of :math:`\nan_N\{\}` (i.e., a canonical NaN of size :math:`N`).

* Else if :math:`z` is a NaN, then return a element of :math:`\nan_N\{\pm \NAN(1)\}` (i.e., any NaN of size :math:`N`).

* Else if :math:`z` is an infinity, then return that infinity.

* Else if :math:`z` is a zero, then return that zero.

* Else, return :math:`\ieee_N(z)`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \demote_{M,N}(\pm \NAN(n)) &=& \nan_N\{\} & (n = \F{can}_N) \\
   \demote_{M,N}(\pm \NAN(n)) &=& \nan_N\{\pm \NAN(1)\} & (\mbox{otherwise}) \\
   \demote_{M,N}(\pm \infty) &=& \pm \infty \\
   \demote_{M,N}(\pm 0) &=& \pm 0 \\
   \demote_{M,N}(\pm q) &=& \ieee_N(\pm q) \\
   \end{array}


.. _op-convertu:

:math:`\convertu_{M,N}(i)`
..........................

* Return :math:`\ieee_N(i)`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \convertu_{M,N}(i) &=& \ieee_N(i) \\
   \end{array}


.. _op-converts:

:math:`\converts_{M,N}(i)`
..........................

* Let :math:`j` be the signed interpretation of :math:`i`.

* Return :math:`\ieee_N(j)`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \convertu_{M,N}(i) &=& \ieee_N(\signed_M(i)) \\
   \end{array}


.. _op-reinterpret:

:math:`\reinterpret_{t_1,t_2}(c)`
.................................

* Let :math:`b^\ast` be the byte sequence :math:`\bytes_{t_1}(c)`.

* Return the constant :math:`c'` for which :math:`\bytes_{t_2}(c') = b^\ast`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \reinterpret_{t_1,t_2}(c) &=& \bytes_{t_2}^{-1}(\bytes_{t_1}(c)) \\
   \end{array}

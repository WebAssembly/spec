.. _exec-numeric:
.. _exec-op-partial:

Numerics
--------

Numeric primitives are defined in a generic manner, by oeprators indexed over a width :math:`N`.

Some operators are *non-deterministic*, because they can return more than one possible result (such as different possible :ref:`NaN <syntax-nan>` values).
Conceptually, each operator thus returns a *set* of allowed values.
For convenience, deterministic results are expressed as plain values, which are assumed to be identified with a respective singleton set.

Some operator are *partial*, because they are not defined on certain inputs.
Conceptually, an empty set of results is returned in such a case.

In formal notation, each operator is defined by equational clauses that apply in order.
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
      \fcopysign_N(- p_1, - p_2) &=& + p_1 \\
      \fcopysign_N(+ p_1, - p_2) &=& - p_1 \\
      \fcopysign_N(- p_1, + p_2) &=& - p_1 \\
      \end{array}

.. _aux-trunc:

Some definitions use *truncation* of rational values, with the usual mathematical definition:

.. math::
   \begin{array}{lll@{\qquad}l}
   \trunc(\pm q) &=& \pm i & (q - 1 < i \leq q) \\
   \end{array}


Integer Operations
~~~~~~~~~~~~~~~~~~

.. _aux-signed:

Sign Interpretation
...................

Integer operators are defined on |iN| values.
Operators that use a signed interpretation convert the value using the following definition, which takes the 2's complement when the value lies in the upper half of the value range (i.e., its most significant bit is :math:`1`):

.. math::
   \begin{array}{lll@{\qquad}l}
   \signed_N(i) &=& i & (0 \leq i < 2^{N-1}) \\
   \signed_N(i) &=& i - 2^N & (2^{N-1} \leq i < 2^N) \\
   \end{array}

This function is bijective, and hence invertible.

.. _aux-bits:

Bitwise Interpretation
......................

Bitwise operators are defined by converting the number into a sequence of binary digits representing the bits of its binary representation:

.. math::
   \begin{array}{lll@{\qquad}l}
   \bits_N(i) &=& b_{N-1}~\dots~b_0 & (i = 2^{N-1}\cdot b_{N-1} + \dots + 2^0\cdot b_0) \\
   \end{array}

This function also is bijective and invertible.

Boolean operators like :math:`\wedge`, :math:`\vee`, or :math:`\veebar` are lifted to bit sequences of equal length by applying them pointwise.

.. _aux-bool:

Boolean Interpretation
......................

The integer result of predicates -- i.e., tests and relational operators -- is defined with the help of the following auxiliary function producing the value :math:`1` or :math:`0` depending on a condition.

.. math::
   \begin{array}{lll@{\qquad}l}
   \bool(C) &=& 1 & (\mbox{if}~C) \\
   \bool(C) &=& 0 & (\mbox{otherwise}) \\
   \end{array}


.. _op-add:

:math:`\iadd_N(i_1, i_2)`
.........................

* Return the result of adding :math:`i_1` and :math:`i_2` modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \iadd_N(i_1, i_2) &=& (i_1 + i_2) \mod 2^N
   \end{array}

.. _op-sub:

:math:`\isub_N(i_1, i_2)`
.........................

* Return the result of subtracting :math:`i_2` from :math:`i_1` modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \isub_N(i_1, i_2) &=& (i_1 - i_2 + 2^N) \mod 2^N
   \end{array}

.. _op-mul:

:math:`\imul_N(i_1, i_2)`
.........................

* Return the result of multiplying :math:`i_1` and :math:`i_2` modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \imul_N(i_1, i_2) &=& (i_1 \cdot i_2) \mod 2^N
   \end{array}

.. _op-div_u:

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

.. _op-div_s:

:math:`\idivs_N(i_1, i_2)`
..........................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`.

* Let :math:`j_2` be the signed interpretation of :math:`i_2`.

* If :math:`i_2` is :math:`0`, then the result is undefined.

* Else, return the result of dividing :math:`j_1` by :math:`j_2`, truncated toward zero.

.. math::
   \begin{array}{@{}lcll}
   \idivs_N(i_1, 0) &=& \{\} \\
   \idivs_N(i_1, i_2) &=& \signed_N^{-1}(\trunc(\signed_N(i_1) / \signed_N(i_2))) \\
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.

.. _op-rem_u:

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

   As long as :math:`i_2 \neq 0` it holds that
   :math:`i_1 = i_2\cdot\divuop(i_1, i_2) + \remuop(i_1, i_2)`.

.. _op-rem_s:

:math:`\irems_N(i_1, i_2)`
..........................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`.

* Let :math:`j_2` be the signed interpretation of :math:`i_2`.

* If :math:`i_2` is :math:`0`, then the result is undefined.

* Else, return the remainder of dividing :math:`j_1` by :math:`j_2`, with the sign of the dividend :math:`j_1`.

.. math::
   \begin{array}{@{}lcll}
   \irems_N(i_1, 0) &=& \{\} \\
   \irems_N(i_1, i_2) &=& \signed_N^{-1}(i_1 - i_2 \cdot \trunc(\signed_N(i_1) / \signed_N(i_2))) \\
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.

   As long as :math:`i_2 \neq 0` it holds that
   :math:`i_1 = i_2\cdot\divsop(i_1, i_2) + \remsop(i_1, i_2)`.


.. _op-and:

:math:`\iand_N(i_1, i_2)`
.........................

* Return the bitwise conjunction of :math:`i_1` and :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \iand_N(i_1, i_2) &=& \bits_N^{-1}(\bits_N(i_1) \wedge \bits_N(i_2))
   \end{array}

.. _op-or:

:math:`\ior_N(i_1, i_2)`
........................

* Return the bitwise disjunction of :math:`i_1` and :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \ior_N(i_1, i_2) &=& \bits_N^{-1}(\bits_N(i_1) \vee \bits_N(i_2))
   \end{array}

.. _op-xor:

:math:`\ixor_N(i_1, i_2)`
.........................

* Return the bitwise exclusive disjunction of :math:`i_1` and :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \ixor_N(i_1, i_2) &=& \bits_N^{-1}(\bits_N(i_1) \veebar \bits_N(i_2))
   \end{array}

.. _op-shl:

:math:`\ishl_N(i_1, i_2)`
.........................

* Let :math:`k` be :math:`i_2` modulo :math:`N`.

* Return the result of shifting :math:`i_1` left by :math:`k` bits, modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \ishl_N(i_1, i_2) &=& \bits_N^{-1}(b_2^{N-k}~0^k) & (\bits_N(i_1) = b_1^k~b_2^{N-k} \wedge k = i_2 \mod N)
   \end{array}

.. _op-shr_u:

:math:`\ishru_N(i_1, i_2)`
..........................

* Let :math:`j_2` be :math:`i_2` modulo :math:`N`.

* Return the result of shifting :math:`i_1` right by :math:`j_2` bits, extended with :math:`0` bits.

.. math::
   \begin{array}{@{}lcll}
   \ishru_N(i_1, i_2) &=& \bits_N^{-1}(0^k~b_1^{N-k}) & (\bits_N(i_1) = b_1^{N-k}~b_2^k \wedge k = i_2 \mod N)
   \end{array}

.. _op-shr_s:

:math:`\ishrs_N(i_1, i_2)`
..........................

* Let :math:`j_2` be :math:`i_2` modulo :math:`N`.

* Return the result of shifting :math:`i_1` right by :math:`j_2` bits, extended with the most significant bit of the original value.

.. math::
   \begin{array}{@{}lcll}
   \ishrs_N(i_1, i_2) &=& \bits_N^{-1}(b_0^{k+1}~b_1^{N-k-1}) & (\bits_N(i_1) = b_0~b_1^{N-k-1}~b_2^k \wedge k = i_2 \mod N)
   \end{array}

.. _op-rotl:

:math:`\irotl_N(i_1, i_2)`
..........................

* Let :math:`j_2` be :math:`i_2` modulo :math:`N`.

* Return the result of rotating :math:`i_1` left by :math:`j_2` bits.

.. math::
   \begin{array}{@{}lcll}
   \irotl_N(i_1, i_2) &=& \bits_N^{-1}(b_2^{N-k}~b_1^k) & (\bits_N(i_1) = b_1^k~b_2^{N-k} \wedge k = i_2 \mod N)
   \end{array}

.. _op-rotr:

:math:`\irotr_N(i_1, i_2)`
..........................

* Let :math:`j_2` be :math:`i_2` modulo :math:`N`.

* Return the result of rotating :math:`i_1` right by :math:`j_2` bits.

.. math::
   \begin{array}{@{}lcll}
   \irotr_N(i_1, i_2) &=& \bits_N^{-1}(b_2^k~b_1^{N-k}) & (\bits_N(i_1) = b_1^{N-k}~b_2^k \wedge k = i_2 \mod N)
   \end{array}


.. _op-clz:

:math:`\iclz_N(i)`
..................

* Return the count of leading zero bits in :math:`i`; all bits are considered leading zeros if :math:`i` is :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \iclz_N(i) &=& k & (\bits_N(i) = 0^k~(1~b^\ast)^?)
   \end{array}


.. _op-ctz:

:math:`\ictz_N(i)`
..................

* Return the count of trailing zero bits in :math:`i`; all bits are considered trailing zeros if :math:`i` is :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \ictz_N(i) &=& k & (\bits_N(i) = (b^\ast~1)^?~0^k)
   \end{array}


.. _op-popcnt:

:math:`\ipopcnt_N(i)`
.....................

* Return the count of non-zero bits in :math:`i`.

.. math::
   \begin{array}{@{}lcll}
   \ipopcnt_N(i) &=& k & (\bits_N(i) = (0^\ast~1)^k~0^\ast)
   \end{array}


.. _op-eqz:

:math:`\ieqz_N(i)`
..................

* Return :math:`1` if :math:`i` is zero, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \ieqz_N(i) &=& \bool(i = 0)
   \end{array}


.. _op-eq:

:math:`\ieq_N(i_!, i_2)`
........................

* Return :math:`1` if :math:`i_1` equals :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \ieq_N(i_1, i_2) &=& \bool(i_1 = i_2)
   \end{array}


.. _op-ne:

:math:`\ine_N(i_!, i_2)`
........................

* Return :math:`1` if :math:`i_1` does not equal :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \ine_N(i_1, i_2) &=& \bool(i_1 \neq i_2)
   \end{array}


.. _op-lt_u:

:math:`\iltu_N(i_!, i_2)`
.........................

* Return :math:`1` if :math:`i_1` is less than :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \iltu_N(i_1, i_2) &=& \bool(i_1 < i_2)
   \end{array}


.. _op-lt_s:

:math:`\ilts_N(i_!, i_2)`
.........................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`.

* Let :math:`j_2` be the signed interpretation of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is less than :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \ilts_N(i_1, i_2) &=& \bool(\signed_N(i_1) < \signed_N(i_2))
   \end{array}


.. _op-gt_u:

:math:`\igtu_N(i_!, i_2)`
.........................

* Return :math:`1` if :math:`i_1` is greater than :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \igtu_N(i_1, i_2) &=& \bool(i_1 > i_2)
   \end{array}


.. _op-gt_s:

:math:`\igts_N(i_!, i_2)`
.........................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`.

* Let :math:`j_2` be the signed interpretation of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is greater than :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \igts_N(i_1, i_2) &=& \bool(\signed_N(i_1) > \signed_N(i_2))
   \end{array}


.. _op-le_u:

:math:`\ileu_N(i_!, i_2)`
.........................

* Return :math:`1` if :math:`i_1` is less than or equal to :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \ileu_N(i_1, i_2) &=& \bool(i_1 \leq i_2)
   \end{array}


.. _op-le_s:

:math:`\iles_N(i_!, i_2)`
.........................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`.

* Let :math:`j_2` be the signed interpretation of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is less than or equal to :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \iles_N(i_1, i_2) &=& \bool(\signed_N(i_1) \leq \signed_N(i_2))
   \end{array}


.. _op-ge_u:

:math:`\igeu_N(i_!, i_2)`
.........................

* Return :math:`1` if :math:`i_1` is greater than or equal to :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \igeu_N(i_1, i_2) &=& \bool(i_1 \geq i_2)
   \end{array}


.. _op-ge_s:

:math:`\iges_N(i_!, i_2)`
.........................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`.

* Let :math:`j_2` be the signed interpretation of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is greater than or equal to :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \iges_N(i_1, i_2) &=& \bool(\signed_N(i_1) \geq \signed_N(i_2))
   \end{array}


Floating-Point Operations
~~~~~~~~~~~~~~~~~~~~~~~~~

Floating-point arithmetic follows the `IEEE 754-2008 <http://ieeexplore.ieee.org/document/4610935/>`_ standard,
with the following qualifications:

* All operators use round-to-nearest ties-to-even, except where otherwise specified.
  Non-default directed rounding attributes are not supported.

* Following the recommendation that operators propagate NaN bits from their operands is permitted but not required.

* All operators use "non-stop" mode, and floating-point exceptions are not otherwise observable.
  In particular, neither alternate floating-point exception handling attributes nor operators on status flags are supported.
  There is no observable difference between quiet and signalling NaNs.

.. note::
   Some of these limitations may be lifted in future versions of WebAssembly.


.. _aux-ieee:

IEEE Rounding
.............

A floating-point number of bit width :math:`N` can be represented in the form :math:`\pm m \cdot 2^e`, where :math:`m` is the *significand* drawn from |uM|, with :math:`M = \payloadsize(N)`, and :math:`e` the *exponent*.

An *exact* floating-point number is a rational number that is exactly representable as an IEEE 754 value of given bit width :math:`N`.

A *limit* number for a given bit width :math:`N` is one of the values :math:`2^{128}` and :math:`-2^{128}` if :math:`N` is 32, or :math:`2^{1024}` and :math:`-2^{1024}` if :math:`N` is 64.

A *candidate* number is either an exact floating-point number or one of the two limit numbers for the given bit width :math:`N`.

A *candidate pair* is a pair :math:`z_1,z_2` of candidate numbers, such that no candidate number exists that lies between the two.

A real number :math:`z` is converted to a floating-point value of bit width :math:`N` using round-to-nearest ties-to-even as follows:

* If :math:`z` is :math:`0`, then return :math:`+0`.

* Else if :math:`z` is an exact floating-point number, then return :math:`z`.

* Else if :math:`z` greater than or equal to the positive limit, then return :math:`+\infty`.

* Else if :math:`z` is less than or equal to the negative limit, then return :math:`-\infty`.

* Else if :math:`z_1` and :math:`z_2` that are a candidate pair such that :math:`z_1 < z < z_2`, then:

  * If :math:`|z - z_1| < |z - z_2|`, then let :math:`z'` be :math:`z_1`.

  * Else if :math:`|z - z_1| > |z - z_2|`, then let :math:`z'` be :math:`z_2`.

  * Else if :math:`|z - z_1| = |z - z_2|` and the significand of :math:`z_1` is even, then let :math:`z'` be :math:`z_1`.

  * Else, let :math:`z'` be :math:`z_2`.

* If :math:`z`` is :math:`0`, then:

  * If :math:`z < 0`, then return :math:`-0`.

  * Else, return :math:`+0`.

* Else if :math:`z'` is a limit number, then:

  * If :math:`z < 0`, then return :math:`-\infty`.

  * Else, return :math:`+\infty`.

* Else, return :math:`z'`.


.. math::
   \begin{array}{lll@{\qquad}l}
   \ieee_N(0) &=& +0 \\
   \ieee_N(z) &=& z & (z \in \F{exact}_N) \\
   \ieee_N(z) &=& +\infty & (z \geq \F{max}(\F{limit}_n)) \\
   \ieee_N(z) &=& -\infty & (z \leq \F{min}(\F{limit}_n)) \\
   \ieee_N(z) &=& \F{closest}_N(z, z_1, z_2) & (z_1 < z < z_2 \wedge (z_1,z_2) \in \F{candidatepair}_N) \\[1ex]
   \F{closest}_N(z, z_1, z_2) &=& \F{rectify}_N(z, z_1) & (|z-z_1|<|z-z_2|) \\
   \F{closest}_N(z, z_1, z_2) &=& \F{rectify}_N(z, z_2) & (|z-z_1|>|z-z_2|) \\
   \F{closest}_N(z, z_1, z_2) &=& \F{rectify}_N(z, z_1) & (|z-z_1|=|z-z_2| \wedge z_1~\mbox{has even significand}) \\
   \F{closest}_N(z, z_1, z_2) &=& \F{rectify}_N(z, z_2) & (|z-z_1|=|z-z_2| \wedge z_2~\mbox{has even significand}) \\[1ex]
   \F{rectify}_N(\pm z, 0) &=& \pm 0 \\
   \F{rectify}_N(z, \pm z') &=& \pm \infty & (\pm z' \in \F{limit}_N) \\
   \F{rectify}_N(z, z') &=& z' \\
   \end{array}

where:

.. math::
   \begin{array}{lll@{\qquad}l}
   \F{exact}_N &=& \{q \in \mathbb{Q} ~|~ q~\mbox{is exactly representable in IEEE 754 with bit width}~N\} \\
   \F{limit}_{32} &=& \{-2^{128}, +2^{128}\} \\
   \F{limit}_{64} &=& \{-2^{1024}, +2^{1024}\} \\
   \F{candidate}_N &=& \F{exact}_N \cup \F{limit}_N \\
   \F{candidatepair}_N &=& \{ (z_1, z_2) \in \F{candidate}_N^2 ~|~ z1 < z2 \wedge \forall z \in \F{candidate}, z \leq z_1 \vee z \geq z_2\} \\[1ex]
   \end{array}


.. _aux-nan:

NaN Propagation
...............

When the result of a floating-poin operator other than |fneg|, |fabs|, or |fcopysign| is a :ref:`NaN <syntax-nan>`, its sign is non-deterministic and the :ref:`payload <syntax-payload>` computed as follows:

* If the payload of all NaN inputs to the operator is :ref:`canonical <canonical-nan>` (including the case that there are no NaN inputs), then the payload of the output is canonical as well.

* Otherwise the payload is picked non-determinsitically among all :ref:`arithmetic NaNs <arithmetic-nan>`; that is, its most significant bit is :math:`1` and all others are unspecified.

This non-deterministic result is expressed by the following auxiliary function producing a set of allowed outputs from a set of inputs:

.. math::
   \begin{array}{lll@{\qquad}l}
   \nan_N\{z^\ast\} &=& \{ + \NAN(n), - \NAN(n) ~|~ n = \canon_N \} & (\forall \NAN(n) \in z^\ast,~ n = \canon_N) \\
   \nan_N\{z^\ast\} &=& \{ + \NAN(n), - \NAN(n) ~|~ n > \canon_N \} & (\mbox{otherwise}) \\
   \end{array}


.. _op-fadd:

:math:`\fadd_N(z_1, z_2)`
.........................

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
   \fadd_N(\pm \NAN(n), z_2) &=& \nan_N\{\pm \NAN(n), z_2\} \\
   \fadd_N(z_1, \pm \NAN(n)) &=& \nan_N\{\pm \NAN(n), z_1\} \\
   \fadd_N(\pm \infty, \mp \infty) &=& \nan_N\{\} \\
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
   \fsub_N(\pm \NAN(n), z_2) &=& \nan_N\{\pm \NAN(n), z_2\} \\
   \fsub_N(z_1, \pm \NAN(n)) &=& \nan_N\{\pm \NAN(n), z_1\} \\
   \fsub_N(\pm \infty, \pm \infty) &=& \nan_N\{\} \\
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

* If either :math:`z_1` or :math:`z_2` is a NaN, then return an element of :math:`\nan_N\{z_1, z_2\}`.

* Else if one of :math:`z_1` and :math:`z_2` is a zero and the other an infinity, then return an element of :math:`\nan_N\{z_1, z_2\}`.

* Else if both :math:`z_1` and :math:`z_2` are infinities of equal sign, then return positive infinity.

* Else if both :math:`z_1` and :math:`z_2` are infinities of opposite sign, then return negative infinity.

* Else if one of :math:`z_1` or :math:`z_2` is an infinity and the other a value with equal sign, then return positive infinity.

* Else if one of :math:`z_1` or :math:`z_2` is an infinity and the other a value with opposite sign, then return negative infinity.

* Else return the result of multiplying :math:`z_1` and :math:`z_2`, rounded to the nearest representable value using round to nearest, ties to even mode; if the magnitude is too large to represent, return an infinity of appropriate sign.

.. math::
   \begin{array}{@{}lcll}
   \fmul_N(\pm \NAN(n), z_2) &=& \nan_N\{\pm \NAN(n), z_2\} \\
   \fmul_N(z_1, \pm \NAN(n)) &=& \nan_N\{\pm \NAN(n), z_1\} \\
   \fmul_N(\pm \infty, \pm 0) &=& \nan_N\{\} \\
   \fmul_N(\pm \infty, \mp 0) &=& \nan_N\{\} \\
   \fmul_N(\pm 0, \pm \infty) &=& \nan_N\{\} \\
   \fmul_N(\pm 0, \mp \infty) &=& \nan_N\{\} \\
   \fmul_N(\pm \infty, \pm \infty) &=& +\infty \\
   \fmul_N(\pm \infty, \mp \infty) &=& -\infty \\
   \fmul_N(\pm q_1, \pm \infty) &=& +\infty \\
   \fmul_N(\pm q_1, \mp \infty) &=& -\infty \\
   \fmul_N(\pm \infty, \pm q_2) &=& +\infty \\
   \fmul_N(\pm \infty, \mp q_2) &=& -\infty \\
   \fmul_N(z_1, z_2) &=& \ieee_N(z_1 \cdot z_2) \\
   \end{array}


.. _op-fdiv:

:math:`\fdiv_N(z_1, z_2)`
.........................

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
   \fdiv_N(\pm \NAN(n), z_2) &=& \nan_N\{\pm \NAN(n), z_2\} \\
   \fdiv_N(z_1, \pm \NAN(n)) &=& \nan_N\{\pm \NAN(n), z_1\} \\
   \fdiv_N(\pm \infty, \pm \infty) &=& \nan_N\{\} \\
   \fdiv_N(\pm \infty, \mp \infty) &=& \nan_N\{\} \\
   \fdiv_N(\pm 0, \pm 0) &=& \nan_N\{\} \\
   \fdiv_N(\pm 0, \mp 0) &=& \nan_N\{\} \\
   \fdiv_N(\pm \infty, \pm q_2) &=& +\infty \\
   \fdiv_N(\pm \infty, \mp q_2) &=& -\infty \\
   \fdiv_N(\pm q_1, \pm \infty) &=& +0 \\
   \fdiv_N(\pm q_1, \mp \infty) &=& -0 \\
   \fdiv_N(\pm q_1, \pm 0) &=& +\infty \\
   \fdiv_N(\pm q_1, \mp 0) &=& -\infty \\
   \fdiv_N(z_1, z_2) &=& \ieee_N(z_1 / z_2) \\
   \end{array}


.. _op-fmin:

:math:`\fmin_N(z_1, z_2)`
.........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return an element of :math:`\nan_N\{z_1, z_2\}`.

* Else if one of :math:`z_1` or :math:`z_2` is a negative infinity, then return negative infinity.

* Else if one of :math:`z_1` or :math:`z_2` is a positive infinity, then return the other value.

* Else if both :math:`z_1` and :math:`z_2` are zeroes of opposite signs, then return negative zero.

* Else return the smaller value of :math:`z_1` and :math:`z_2`.

.. math::
   \begin{array}{@{}lcll}
   \fmin_N(\pm \NAN(n), z_2) &=& \nan_N\{\pm \NAN(n), z_2\} \\
   \fmin_N(z_1, \pm \NAN(n)) &=& \nan_N\{\pm \NAN(n), z_1\} \\
   \fmin_N(- \infty, z_2) &=& - \infty \\
   \fmin_N(z_1, - \infty) &=& - \infty \\
   \fmin_N(+ \infty, z_2) &=& z_2 \\
   \fmin_N(z_1, + \infty) &=& z_1 \\
   \fmin_N(\pm 0, \mp 0) &=& -0 \\
   \fmin_N(z_1, z_2) &=& z_1 & (z_1 \leq z_2) \\
   \fmin_N(z_1, z_2) &=& z_2 & (z_2 \leq z_1) \\
   \end{array}


.. _op-fmax:

:math:`\fmax_N(z_1, z_2)`
.........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return an element of :math:`\nan_N\{z_1, z_2\}`.

* Else if one of :math:`z_1` or :math:`z_2` is a positive infinity, then return positive infinity.

* Else if one of :math:`z_1` or :math:`z_2` is a negative infinity, then return the other value.

* Else if both :math:`z_1` and :math:`z_2` are zeroes of opposite signs, then return positive zero.

* Else return the larger value of :math:`z_1` and :math:`z_2`.

.. math::
   \begin{array}{@{}lcll}
   \fmax_N(\pm \NAN(n), z_2) &=& \nan_N\{\pm \NAN(n), z_2\} \\
   \fmax_N(z_1, \pm \NAN(n)) &=& \nan_N\{\pm \NAN(n), z_1\} \\
   \fmax_N(+ \infty, z_2) &=& + \infty \\
   \fmax_N(z_1, + \infty) &=& + \infty \\
   \fmax_N(- \infty, z_2) &=& z_2 \\
   \fmax_N(z_1, - \infty) &=& z_1 \\
   \fmax_N(\pm 0, \mp 0) &=& +0 \\
   \fmax_N(z_1, z_2) &=& z_1 & (z_1 \geq z_2) \\
   \fmax_N(z_1, z_2) &=& z_2 & (z_2 \geq z_1) \\
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
   \fneg_N(\pm z) &=& \mp z \\
   \end{array}


.. _op-fsqrt:

:math:`\fsqrt_N(z)`
...................

* If :math:`z` is a NaN, then return an element of :math:`\nan_N\{z\}`.

* Else if :math:`z` has a negative sign, then return an element of :math:`\nan_N\{z\}`.

* Else if :math:`z` is positive infinity, then return positive infinity.

* Else if :math:`z` is a zero, then return that zero.

* Else return the square root of :math:`z`.

.. math::
   \begin{array}{@{}lcll}
   \fsqrt_N(\pm \NAN(n)) &=& \nan_N\{\pm \NAN(n)\} \\
   \fsqrt_N(- \infty) &=& \nan_N\{\} \\
   \fsqrt_N(+ \infty) &=& + \infty \\
   \fsqrt_N(\pm 0) &=& \pm 0 \\
   \fsqrt_N(- q) &=& \nan_N\{\} \\
   \fsqrt_N(+ q) &=& \ieee_N\left(\sqrt{z}\right) \\
   \end{array}


.. _op-fceil:

:math:`\fceil_N(z)`
...................

* If :math:`z` is a NaN, then return an element of :math:`\nan_N\{z\}`.

* Else if :math:`z` is an infinity, then return :math:`z`.

* Else if :math:`z` is a zero, then return :math:`z`.

* Else if :math:`z` is smaller than :math:`0` but greater than :math:`-1`, then return negative zero.

* Else return the smallest integral value that is not smaller than :math:`z`.

.. math::
   \begin{array}{@{}lcll}
   \fceil_N(\pm \NAN(n)) &=& \nan_N\{\pm \NAN(n)\} \\
   \fceil_N(\pm \infty) &=& \pm \infty \\
   \fceil_N(\pm 0) &=& \pm 0 \\
   \fceil_N(- q) &=& -0 & (-1 < -q < 0) \\
   \fceil_N(\pm q) &=& \ieee_N(i) & (\pm q \leq i < \pm q + 1) \\
   \end{array}


.. _op-ffloor:

:math:`\ffloor_N(z)`
....................

* If :math:`z` is a NaN, then return an element of :math:`\nan_N\{z\}`.

* Else if :math:`z` is an infinity, then return :math:`z`.

* Else if :math:`z` is a zero, then return :math:`z`.

* Else if :math:`z` is greater than :math:`0` but smaller than :math:`1`, then return positive zero.

* Else return the largest integral value that is not larger than :math:`z`.

.. math::
   \begin{array}{@{}lcll}
   \ffloor_N(\pm \NAN(n)) &=& \nan_N\{\pm \NAN(n)\} \\
   \ffloor_N(\pm \infty) &=& \pm \infty \\
   \ffloor_N(\pm 0) &=& \pm 0 \\
   \ffloor_N(+ q) &=& +0 & (0 < +q < 1) \\
   \ffloor_N(\pm q) &=& \ieee_N(i) & (\pm q - 1 < i \leq \pm q) \\
   \end{array}


.. _op-ftrunc:

:math:`\ftrunc_N(z)`
....................

* If :math:`z` is a NaN, then return an element of :math:`\nan_N\{z\}`.

* Else if :math:`z` is an infinity, then return :math:`z`.

* Else if :math:`z` is a zero, then return :math:`z`.

* Else if :math:`z` is greater than :math:`0` but smaller than :math:`1`, then return positive zero.

* Else if :math:`z` is smaller than :math:`0` but greater than :math:`-1`, then return negative zero.

* Else return the integral value with the same sign as :math:`z` and the largest magnitude that is not larger than the magnitude of :math:`z`.

.. math::
   \begin{array}{@{}lcll}
   \ftrunc_N(\pm \NAN(n)) &=& \nan_N\{\pm \NAN(n)\} \\
   \ftrunc_N(\pm \infty) &=& \pm \infty \\
   \ftrunc_N(\pm 0) &=& \pm 0 \\
   \ftrunc_N(+ q) &=& +0 & (0 < +q < 1) \\
   \ftrunc_N(- q) &=& -0 & (-1 < -q < 0) \\
   \ftrunc_N(\pm q) &=& \ieee_N(\pm i) & (+q - 1 < i \leq +q) \\
   \end{array}


.. _op-fnearest:

:math:`\fnearest_N(z)`
......................

* If :math:`z` is a NaN, then return an element of :math:`\nan_N\{z\}`.

* Else if :math:`z` is an infinity, then return :math:`z`.

* Else if :math:`z` is a zero, then return :math:`z`.

* Else if :math:`z` is greater than :math:`0` but smaller than :math:`0.5`, then return positive zero.

* Else if :math:`z` is smaller than :math:`0` but greater than or equal to :math:`-0.5`, then return negative zero.

* Else return the integral value that is nearest to :math:`z`; if two values are equally near, return the even one.

.. math::
   \begin{array}{@{}lcll}
   \fnearest_N(\pm \NAN(n)) &=& \nan_N\{\pm \NAN(n)\} \\
   \fnearest_N(\pm \infty) &=& \pm \infty \\
   \fnearest_N(\pm 0) &=& \pm 0 \\
   \fnearest_N(+ q) &=& +0 & (0 < +q \leq 0.5) \\
   \fnearest_N(- q) &=& -0 & (-0.5 \leq -q < 0) \\
   \fnearest_N(\pm q) &=& \ieee_N(\pm i) & (|i - q| < 0.5) \\
   \fnearest_N(\pm q) &=& \ieee_N(\pm i) & (|i - q| = 0.5 \wedge i~\mbox{even}) \\
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
   \feq_N(z, z) &=& 1 \\
   \feq_N(z_1, z_2) &=& 0 \\
   \end{array}


.. _op-fne:

:math:`\fne_N(z_1, z_2)`
........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return :math:`0`.

* Else if both :math:`z_1` and :math:`z_2` are zeroes, then return :math:`0`.

* Else if both :math:`z_1` and :math:`z_2` are the same value, then return :math:`0`.

* Else return :math:`1`.

.. math::
   \begin{array}{@{}lcll}
   \fne_N(\pm \NAN(n), z_2) &=& 0 \\
   \fne_N(z_1, \pm \NAN(n)) &=& 0 \\
   \fne_N(\pm 0, \mp 0) &=& 0 \\
   \fne_N(z, z) &=& 0 \\
   \fne_N(z_1, z_2) &=& 1 \\
   \end{array}


.. _op-flt:

:math:`\flt_N(z_1, z_2)`
........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return :math:`0`.

* Else if :math:`z_1` and :math:`z_2` are the same value, then return :math:`0`.

* Else if :math:`z_1` is negative infinity, then return :math:`1`.

* Else if :math:`z_2` is positive infinity, then return :math:`1`.

* Else if both :math:`z_1` and :math:`z_2` are zeroes, then return :math:`0`.

* Else if :math:`z_1` is smaller than :math:`z_2`, then return :math:`1`.

* Else return :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \flt_N(\pm \NAN(n), z_2) &=& 0 \\
   \flt_N(z_1, \pm \NAN(n)) &=& 0 \\
   \flt_N(z, z) &=& 0 \\
   \flt_N(- \infty, z_2) &=& 1 \\
   \flt_N(z_1, + \infty) &=& 1 \\
   \flt_N(\pm 0, \mp 0) &=& 0 \\
   \flt_N(z_1, z_2) &=& \bool(z_1 < z_2) \\
   \end{array}


.. _op-fgt:

:math:`\fgt_N(z_1, z_2)`
........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return :math:`0`.

* Else if :math:`z_1` and :math:`z_2` are the same value, then return :math:`0`.

* Else if :math:`z_1` is positive infinity, then return :math:`1`.

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
   \fgt_N(z_1, - \infty) &=& 1 \\
   \fgt_N(\pm 0, \mp 0) &=& 0 \\
   \fgt_N(z_1, z_2) &=& \bool(z_1 > z_2) \\
   \end{array}


.. _op-fle:

:math:`\fle_N(z_1, z_2)`
........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return :math:`0`.

* Else if :math:`z_1` and :math:`z_2` are the same value, then return :math:`1`.

* Else if :math:`z_1` is negative infinity, then return :math:`1`.

* Else if :math:`z_2` is positive infinity, then return :math:`1`.

* Else if both :math:`z_1` and :math:`z_2` are zeroes, then return :math:`1`.

* Else if :math:`z_1` is smaller than or equal to :math:`z_2`, then return :math:`1`.

* Else return :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \fle_N(\pm \NAN(n), z_2) &=& 0 \\
   \fle_N(z_1, \pm \NAN(n)) &=& 0 \\
   \fle_N(z, z) &=& 1 \\
   \fle_N(- \infty, z_2) &=& 1 \\
   \fle_N(z_1, + \infty) &=& 1 \\
   \fle_N(\pm 0, \mp 0) &=& 1 \\
   \fle_N(z_1, z_2) &=& \bool(z_1 \leq z_2) \\
   \end{array}


.. _op-fge:

:math:`\fge_N(z_1, z_2)`
........................

* If either :math:`z_1` or :math:`z_2` is a NaN, then return :math:`0`.

* Else if :math:`z_1` and :math:`z_2` are the same value, then return :math:`1`.

* Else if :math:`z_1` is positive infinity, then return :math:`1`.

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
   \fge_N(z_1, - \infty) &=& 1 \\
   \fge_N(\pm 0, \mp 0) &=& 1 \\
   \fge_N(z_1, z_2) &=& \bool(z_1 \geq z_2) \\
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

* If :math:`z` is a NaN, then the result is undefined. 

* Else if :math:`z` is an infinity, then the result is undefined. 

* Else if :math:`z` is a number and :math:`\trunc(z)` is a value within range of the target type, then return that value.

* Else the result is undefined.

.. math::
   \begin{array}{lll@{\qquad}l}
   \truncu_{M,N}(\pm \NAN(n)) &=& \{\} \\
   \truncu_{M,N}(\pm \infty) &=& \{\} \\
   \truncu_{M,N}(\pm 0) &=& 0 \\
   \truncu_{M,N}(\pm q) &=& \trunc(\pm q) & (0 \leq \trunc(\pm q) < 2^N) \\
   \truncu_{M,N}(\pm q) &=& \{\} & (\mbox{otherwise}) \\
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.
   It is not defined for NaNs, infinities, or values for which the result is out of range.


.. _op-truncs:

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
   \truncs_{M,N}(\pm 0) &=& 0 \\
   \truncs_{M,N}(\pm q) &=& \trunc(\pm q) & (- 2^{N-1} \leq \trunc(\pm q) < 2^{N-1}) \\
   \truncs_{M,N}(\pm q) &=& \{\} & (\mbox{otherwise}) \\
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
   \promote_{M,N}(\pm \NAN(n)) &=& \nan_N\{\} & (n = \canon_N) \\
   \promote_{M,N}(\pm \NAN(n)) &=& \nan_N\{+ \NAN(1)\} & (\mbox{otherwise}) \\
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
   \demote_{M,N}(\pm \NAN(n)) &=& \nan_N\{\} & (n = \canon_N) \\
   \demote_{M,N}(\pm \NAN(n)) &=& \nan_N\{+ \NAN(1)\} & (\mbox{otherwise}) \\
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


.. _aux-bytes:
.. _aux-ibytes:
.. _aux-fbytes:

Storage Conversion
~~~~~~~~~~~~~~~~~~

When a number is stored in :ref:`memory <syntax-mem>`, it is converted into a sequence of :ref:`bytes <syntax-byte>`.

.. math::
   \begin{array}{lll@{\qquad}l}
   \bytes_{\K{i}N}(i) &=& \ibytes_N(i) \\
   \bytes_{\K{f}N}(z) &=& \fbytes_N(z) \\
   \end{array}

Integers are represented in `little endian <https://en.wikipedia.org/wiki/Endianness#Little-endian>`_ byte order:

.. math::
   \begin{array}{lll@{\qquad}l}
   \ibytes_N(i) &=& \epsilon & (N = 0 \wedge i = 0) \\
   \ibytes_N(i) &=& b~\bytes_{N-8}(j) & (N \geq 8 \wedge i = 2^8\cdot j + b) \\
   \end{array}

Floating-point values are represented in the respective binary format defined by `IEEE 754 <http://ieeexplore.ieee.org/document/4610935/>`_, and also stored in little endian byte order:

.. math::
   \begin{array}{lll@{\qquad}l}
   \fbytes_N(z) &=& \F{reverse}(\mbox{IEEE 754 $N$-bit binary representation of $z$})  \\
   \end{array}

Each of these functions is a bijection, hence they are invertible.

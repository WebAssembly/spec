.. _exec-numeric:

Numerics
--------

.. todo::
   Describe


.. _aux-bytes:
.. _aux-signed:
.. _aux-extend:
.. _aux-wrap:

Auxiliary Operations
~~~~~~~~~~~~~~~~~~~~

.. math::
   \begin{array}{lll@{\qquad}l}
   \bytes_N(i) &=& \epsilon & (N = 0 \wedge i = 0) \\
   \bytes_N(i) &=& b~\bytes_{N-8}(j) & (N \geq 8 \wedge i = 2^8\cdot j + b) \\
   ~ \\
   \bytes_{\K{i}N}(i) &=& \bytes_N(i) \\
   \bytes_{\K{f}N}(b^N) &=& \F{reverse}(b^N) \\
   \end{array}

Note that |bytes| is a bijection, hence the function is invertible.

.. math::
   \begin{array}{lll@{\qquad}l}
   \signed_N(i) &=& i & (0 \leq i < 2^{N-1}) \\
   \signed_N(i) &=& i - 2^N & (2^{N-1} \leq i < 2^N) \\
   ~ \\
   \extend_{\B{U},N}(i) &=& i \\
   \extend_{\B{S},N}(i) &=& \signed_N(i) \\
   \wrap_N(i) &=& i \mod 2^N \\
   \end{array}

.. Note::
   The index :math:`N` of the |extend| function is the size extending *from*,
   where as the index of the |wrap| function is the size wrapping *to*.

.. _aux-floor:
.. _aux-ceil:
.. _aux-trunc:

.. math::
   \begin{array}{lll@{\qquad}l}
   \floor(\pm z) &=& i & (\pm z - 1 < i \leq \pm z) \\
   \ceil(\pm z) &=& i & (\pm z \leq i < \pm z + 1) \\
   \trunc(\pm z) &=& \pm i & (z - 1 < i \leq z) \\
   \end{array}

.. _aux-bits:
.. _aux-bool:

.. math::
   \begin{array}{lll@{\qquad}l}
   \bits_N(i) &=& b_{N-1}~\dots~b_0 & (i = 2^{N-1}\cdot b_{N-1} + \dots + 2^0\cdot b_0) \\
   \bool(C) &=& (\mbox{if}~C) \\
   \bool(C) &=& (\mbox{otherwise}) \\
   \end{array}


Integer Operations
~~~~~~~~~~~~~~~~~~

.. _op-add:

:math:`\addop_{\K{i}N}(i_1, i_2)`
.................................

* Return the result of adding :math:`i_1` and :math:`i_2` modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \addop_{\K{i}N}(i_1, i_2) &=& (i_1 + i_2) \mod 2^N
   \end{array}

.. _op-sub:

:math:`\subop_{\K{i}N}(i_1, i_2)`
.................................

* Return the result of subtracting :math:`i_2` from :math:`i_1` modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \subop_{\K{i}N}(i_1, i_2) &=& (i_1 - i_2 + 2^N) \mod 2^N
   \end{array}

.. _op-mul:

:math:`\mulop_{\K{i}N}(i_1, i_2)`
.................................

* Return the result of multiplying :math:`i_1` and :math:`i_2` modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \mulop_{\K{i}N}(i_1, i_2) &=& (i_1 \cdot i_2) \mod 2^N
   \end{array}

.. _op-div_u:

:math:`\divuop_{\K{i}N}(i_1, i_2)`
..................................

* If :math:`i_2` is not :math:`0`, then:

  * Return the result of dividing :math:`i_1` by :math:`i_2`, truncated toward zero.

.. math::
   \begin{array}{@{}lcll}
   \divuop_{\K{i}N}(i_1, i_2) &=& \floor(i_1 / i_2) & (i_2 \neq 0)
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.

.. _op-div_s:

:math:`\divsop_{\K{i}N}(i_1, i_2)`
..................................

* If :math:`i_2` is not :math:`0`, then:

  * Let :math:`j_1` be the signed interpretation of :math:`i_1`.

  * Let :math:`j_2` be the signed interpretation of :math:`i_2`.

  * Return the result of dividing :math:`j_1` by :math:`j_2`, truncated toward zero.

.. math::
   \begin{array}{@{}lcll}
   \divsop_{\K{i}N}(i_1, i_2) &=& \signed_N^{-1}(\trunc(\signed_N(i_1) / \signed_N(i_2))) & (i_2 \neq 0)
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.

.. _op-rem_u:

:math:`\remuop_{\K{i}N}(i_1, i_2)`
..................................

* If :math:`i_2` is not :math:`0`, then:

  * Return the remainder of dividing :math:`i_1` by :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \remuop_{\K{i}N}(i_1, i_2) &=& i_1 - i_2 \cdot \floor(i_1 / i_2) & (i_2 \neq 0)
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.

   As long as :math:`i_2 \neq 0` it holds that
   :math:`i_1 = i_2\cdot\divuop(i_1, i_2) + \remuop(i_1, i_2)`.

.. _op-rem_s:

:math:`\remsop_{\K{i}N}(i_1, i_2)`
..................................

* If :math:`i_2` is not :math:`0`, then:

  * Let :math:`j_1` be the signed interpretation of :math:`i_1`.

  * Let :math:`j_2` be the signed interpretation of :math:`i_2`.

  * Return the remainder of dividing :math:`j_1` by :math:`j_2`, with the sign of the dividend :math:`j_1`.

.. math::
   \begin{array}{@{}lcll}
   \remsop_{\K{i}N}(i_1, i_2) &=& \signed_N^{-1}(i_1 - i_2 \cdot \trunc(\signed_N(i_1) / \signed_N(i_2))) & (i_2 \neq 0)
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.

   As long as :math:`i_2 \neq 0` it holds that
   :math:`i_1 = i_2\cdot\divsop(i_1, i_2) + \remsop(i_1, i_2)`.


.. _op-and:

:math:`\andop_{\K{i}N}(i_1, i_2)`
.................................

* Return the bitwise conjunction of :math:`i_1` and :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \andop_{\K{i}N}(i_1, i_2) &=& \bits_N^{-1}(\bits_N(i_1) \wedge \bits_N(i_2))
   \end{array}

.. _op-or:

:math:`\orop_{\K{i}N}(i_1, i_2)`
................................

* Return the bitwise disjunction of :math:`i_1` and :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \orop_{\K{i}N}(i_1, i_2) &=& \bits_N^{-1}(\bits_N(i_1) \vee \bits_N(i_2))
   \end{array}

.. _op-xor:

:math:`\xorop_{\K{i}N}(i_1, i_2)`
.................................

* Return the bitwise exclusive disjunction of :math:`i_1` and :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \xorop_{\K{i}N}(i_1, i_2) &=& \bits_N^{-1}(\bits_N(i_1) \veebar \bits_N(i_2))
   \end{array}

.. _op-shl:

:math:`\shlop_{\K{i}N}(i_1, i_2)`
.................................

* Let :math:`k` be :math:`i_2` modulo :math:`N`.

* Return the result of shifting :math:`i_1` left by :math:`k` bits, modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \shlop_{\K{i}N}(i_1, i_2) &=& (i_1 \cdot 2^{i_2 \mod N}) \mod 2^N \\
   \shlop_{\K{i}N}(i_1, i_2) &=& \bits_N^{-1}(b_2^{N-k}~0^k) & (\bits_N(i_1) = b_1^k~b_2^{N-k} \wedge k = i_2 \mod N)
   \end{array}

.. _op-shr_u:

:math:`\shruop_{\K{i}N}(i_1, i_2)`
..................................

* Let :math:`j_2` be :math:`i_2` modulo :math:`N`.

* Return the result of shifting :math:`i_1` right by :math:`j_2` bits, extended with :math:`0` bits.

.. math::
   \begin{array}{@{}lcll}
   \shruop_{\K{i}N}(i_1, i_2) &=& \floor_N(i_1 / 2^{i_2 \mod N}) \\
   \shruop_{\K{i}N}(i_1, i_2) &=& \bits_N^{-1}(0^k~b_1^{N-k}) & (\bits_N(i_1) = b_1^{N-k}~b_2^k \wedge k = i_2 \mod N)
   \end{array}

.. _op-shr_s:

:math:`\shrsop_{\K{i}N}(i_1, i_2)`
..................................

* Let :math:`j_2` be :math:`i_2` modulo :math:`N`.

* Return the result of shifting :math:`i_1` right by :math:`j_2` bits, extended with the most significant bit of the original value.

.. math::
   \begin{array}{@{}lcll}
   \shrsop_{\K{i}N}(i_1, i_2) &=& \signed_N^{-1}(\floor_N(\signed_N(i_1) / 2^{i_2 \mod N})) \\
   \shrsop_{\K{i}N}(i_1, i_2) &=& \bits_N^{-1}(b_0^{k+1}~b_1^{N-k-1}) & (\bits_N(i_1) = b_0~b_1^{N-k-1}~b_2^k \wedge k = i_2 \mod N)
   \end{array}

.. _op-rotl:

:math:`\rotlop_{\K{i}N}(i_1, i_2)`
..................................

* Let :math:`j_2` be :math:`i_2` modulo :math:`N`.

* Return the result of rotating :math:`i_1` left by :math:`j_2` bits.

.. math::
   \begin{array}{@{}lcll}
   \rotlop_{\K{i}N}(i_1, i_2) &=& (i_1 \cdot 2^{i_2 \mod N} \mod 2^N) + \floor_N(i_1 / 2^{N - (i_2 \mod N)}) \\
   \rotlop_{\K{i}N}(i_1, i_2) &=& \bits_N^{-1}(b_2^{N-k}~b_1^k) & (\bits_N(i_1) = b_1^k~b_2^{N-k} \wedge k = i_2 \mod N)
   \end{array}

.. _op-rotr:

:math:`\rotrop_{\K{i}N}(i_1, i_2)`
..................................

* Let :math:`j_2` be :math:`i_2` modulo :math:`N`.

* Return the result of rotating :math:`i_1` right by :math:`j_2` bits.

.. math::
   \begin{array}{@{}lcll}
   \rotrop_{\K{i}N}(i_1, i_2) &=& (i_1 \cdot 2^{N - (i_2 \mod N)} \mod 2^N) + \floor_N(i_1 / 2^{i_2 \mod N}) \\
   \rotruop_{\K{i}N}(i_1, i_2) &=& \bits_N^{-1}(b_2^k~b_1^{N-k}) & (\bits_N(i_1) = b_1^{N-k}~b_2^k \wedge k = i_2 \mod N)
   \end{array}


.. _op-clz:

:math:`\clzop_{\K{i}N}(i)`
..........................

* Return the count of leading zero bits in :math:`i`; all bits are considered leading zeros if :math:`i` is :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \clzop_{\K{i}N}(i) &=& k & (\bits_N(i) = 0^k~(1~b^\ast)^?)
   \end{array}


.. _op-ctz:

:math:`\ctzop_{\K{i}N}(i)`
..........................

* Return the count of trailing zero bits in :math:`i`; all bits are considered trailing zeros if :math:`i` is :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \ctzop_{\K{i}N}(i) &=& k & (\bits_N(i) = (b^\ast~1)^?~0^k)
   \end{array}


.. _op-popcnt:

:math:`\popcntop_{\K{i}N}(i)`
.............................

* Return the count of non-zero bits in :math:`i`.

.. math::
   \begin{array}{@{}lcll}
   \popcntop_{\K{i}N}(i) &=& k & (\bits_N(i) = (0^\ast~1)^k~0^\ast)
   \end{array}


.. _op-eqz:

:math:`\eqzop_{\K{i}N}(i)`
..........................

* Return :math:`1` if :math:`i` is zero, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \eqzop_{\K{i}N}(i) &=& \bool(i = 0)
   \end{array}


.. _op-eq:

:math:`\eqop_{\K{i}N}(i_!, i_2)`
................................

* Return :math:`1` if :math:`i_1` equals :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \eqop_{\K{i}N}(i_1, i_2) &=& \bool(i_1 = i_2)
   \end{array}


.. _op-ne:

:math:`\neop_{\K{i}N}(i_!, i_2)`
................................

* Return :math:`1` if :math:`i_1` does not equal :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \neop_{\K{i}N}(i_1, i_2) &=& \bool(i_1 \neq i_2)
   \end{array}


.. _op-lt_u:

:math:`\ltuop_{\K{i}N}(i_!, i_2)`
.................................

* Return :math:`1` if :math:`i_1` is less than :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \ltuop_{\K{i}N}(i_1, i_2) &=& \bool(i_1 < i_2)
   \end{array}


.. _op-lt_s:

:math:`\ltsop_{\K{i}N}(i_!, i_2)`
.................................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`.

* Let :math:`j_2` be the signed interpretation of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is less than :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \ltsop_{\K{i}N}(i_1, i_2) &=& \bool(\signed_N(i_1) < \signed_N(i_2))
   \end{array}


.. _op-gt_u:

:math:`\gtuop_{\K{i}N}(i_!, i_2)`
.................................

* Return :math:`1` if :math:`i_1` is greater than :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \gtuop_{\K{i}N}(i_1, i_2) &=& \bool(i_1 > i_2)
   \end{array}


.. _op-gt_s:

:math:`\gtsop_{\K{i}N}(i_!, i_2)`
.................................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`.

* Let :math:`j_2` be the signed interpretation of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is greater than :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \gtsop_{\K{i}N}(i_1, i_2) &=& \bool(\signed_N(i_1) > \signed_N(i_2))
   \end{array}


.. _op-le_u:

:math:`\leuop_{\K{i}N}(i_!, i_2)`
.................................

* Return :math:`1` if :math:`i_1` is less than or equal to :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \leuop_{\K{i}N}(i_1, i_2) &=& \bool(i_1 \leq i_2)
   \end{array}


.. _op-le_s:

:math:`\lesop_{\K{i}N}(i_!, i_2)`
.................................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`.

* Let :math:`j_2` be the signed interpretation of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is less than or equal to :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \lesop_{\K{i}N}(i_1, i_2) &=& \bool(\signed_N(i_1) \leq \signed_N(i_2))
   \end{array}


.. _op-ge_u:

:math:`\geuop_{\K{i}N}(i_!, i_2)`
.................................

* Return :math:`1` if :math:`i_1` is greater than or equal to :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \geuop_{\K{i}N}(i_1, i_2) &=& \bool(i_1 \geq i_2)
   \end{array}


.. _op-ge_s:

:math:`\gesop_{\K{i}N}(i_!, i_2)`
.................................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`.

* Let :math:`j_2` be the signed interpretation of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is greater than or equal to :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \gesop_{\K{i}N}(i_1, i_2) &=& \bool(\signed_N(i_1) \geq \signed_N(i_2))
   \end{array}


Floating-Point Operations
~~~~~~~~~~~~~~~~~~~~~~~~~


Conversions
~~~~~~~~~~~

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

.. _exec-add:

:math:`\F{add}_{\K{i}N}(i_1, i_2)`
..................................

* Return the result of adding :math:`i_1` and :math:`i_2` modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \F{add}_{\K{i}N}(i_1, i_2) &=& (i_1 + i_2) \mod 2^N
   \end{array}

.. _exec-sub:

:math:`\F{sub}_{\K{i}N}(i_1, i_2)`
..................................

* Return the result of subtracting :math:`i_2` from :math:`i_1` modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \F{sub}_{\K{i}N}(i_1, i_2) &=& (i_1 - i_2 + 2^N) \mod 2^N
   \end{array}

.. _exec-mul:

:math:`\F{mul}_{\K{i}N}(i_1, i_2)`
..................................

* Return the result of multiplying :math:`i_1` and :math:`i_2` modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \F{mul}_{\K{i}N}(i_1, i_2) &=& (i_1 \cdot i_2) \mod 2^N
   \end{array}

.. _exec-div_u:

:math:`\F{div\_u}_{\K{i}N}(i_1, i_2)`
.....................................

* If :math:`i_2` is not :math:`0`, then:

  * Return the result of dividing :math:`i_1` by :math:`i_2`, truncated toward zero.

.. math::
   \begin{array}{@{}lcll}
   \F{div\_u}_{\K{i}N}(i_1, i_2) &=& \F{floor}(i_1 / i_2) & (i_2 \neq 0)
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.

.. _exec-div_s:

:math:`\F{div\_s}_{\K{i}N}(i_1, i_2)`
.....................................

* If :math:`i_2` is not :math:`0`, then:

  * Let :math:`j_1` be the signed interpretation of :math:`i_1`.

  * Let :math:`j_2` be the signed interpretation of :math:`i_2`.

  * Return the result of dividing :math:`j_1` by :math:`j_2`, truncated toward zero.

.. math::
   \begin{array}{@{}lcll}
   \F{div\_s}_{\K{i}N}(i_1, i_2) &=& \signed_N^{-1}(\F{trunc}(\signed_N(i_1) / \signed_N(i_2))) & (i_2 \neq 0)
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.

.. _exec-rem_u:

:math:`\F{rem\_u}_{\K{i}N}(i_1, i_2)`
.....................................

* If :math:`i_2` is not :math:`0`, then:

  * Return the remainder of dividing :math:`i_1` by :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \F{rem\_u}_{\K{i}N}(i_1, i_2) &=& i_1 - i_2 \cdot \F{floor}(i_1 / i_2) & (i_2 \neq 0)
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.

   As long as :math:`i_2 \neq 0` it holds that
   :math:`i_1 = i_2\cdot\F{div\_u}(i_1, i_2) + \F{rem\_u}(i_1, i_2)`.

.. _exec-rem_s:

:math:`\F{rem\_s}_{\K{i}N}(i_1, i_2)`
.....................................

* If :math:`i_2` is not :math:`0`, then:

  * Let :math:`j_1` be the signed interpretation of :math:`i_1`.

  * Let :math:`j_2` be the signed interpretation of :math:`i_2`.

  * Return the remainder of dividing :math:`j_1` by :math:`j_2`, with the sign of the dividend :math:`j_1`.

.. math::
   \begin{array}{@{}lcll}
   \F{rem\_s}_{\K{i}N}(i_1, i_2) &=& \signed_N^{-1}(i_1 - i_2 \cdot \F{trunc}(\signed_N(i_1) / \signed_N(i_2))) & (i_2 \neq 0)
   \end{array}

.. note::
   This operator is :ref:`partial <exec-op-partial>`.

   As long as :math:`i_2 \neq 0` it holds that
   :math:`i_1 = i_2\cdot\F{div\_s}(i_1, i_2) + \F{rem\_s}(i_1, i_2)`.


.. _exec-and:

:math:`\F{and}_{\K{i}N}(i_1, i_2)`
..................................

* Return the bitwise conjunction of :math:`i_1` and :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \F{and}_{\K{i}N}(i_1, i_2) &=& \bits_N^{-1}(\bits_N(i_1) \wedge \bits_N(i_2))
   \end{array}

.. _exec-or:

:math:`\F{or}_{\K{i}N}(i_1, i_2)`
.................................

* Return the bitwise disjunction of :math:`i_1` and :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \F{or}_{\K{i}N}(i_1, i_2) &=& \bits_N^{-1}(\bits_N(i_1) \vee \bits_N(i_2))
   \end{array}

.. _exec-xor:

:math:`\F{xor}_{\K{i}N}(i_1, i_2)`
..................................

* Return the bitwise exclusive disjunction of :math:`i_1` and :math:`i_2`.

.. math::
   \begin{array}{@{}lcll}
   \F{xor}_{\K{i}N}(i_1, i_2) &=& \bits_N^{-1}(\bits_N(i_1) \veebar \bits_N(i_2))
   \end{array}

.. _exec-shl:

:math:`\F{shl}_{\K{i}N}(i_1, i_2)`
..................................

* Let :math:`k` be :math:`i_2` modulo :math:`N`.

* Return the result of shifting :math:`i_1` left by :math:`k` bits, modulo :math:`2^N`.

.. math::
   \begin{array}{@{}lcll}
   \F{shl}_{\K{i}N}(i_1, i_2) &=& (i_1 \cdot 2^{i_2 \mod N}) \mod 2^N \\
   \F{shl}_{\K{i}N}(i_1, i_2) &=& \bits_N^{-1}(b_2^{N-k}~0^k) & (\bits_N(i_1) = b_1^k~b_2^{N-k} \wedge k = i_2 \mod N)
   \end{array}

.. _exec-shr_u:

:math:`\F{shr\_u}_{\K{i}N}(i_1, i_2)`
.....................................

* Let :math:`j_2` be :math:`i_2` modulo :math:`N`.

* Return the result of shifting :math:`i_1` right by :math:`j_2` bits, extended with :math:`0` bits.

.. math::
   \begin{array}{@{}lcll}
   \F{shr\_u}_{\K{i}N}(i_1, i_2) &=& \floor_N(i_1 / 2^{i_2 \mod N}) \\
   \F{shr\_u}_{\K{i}N}(i_1, i_2) &=& \bits_N^{-1}(0^k~b_1^{N-k}) & (\bits_N(i_1) = b_1^{N-k}~b_2^k \wedge k = i_2 \mod N)
   \end{array}

.. _exec-shr_s:

:math:`\F{shr\_s}_{\K{i}N}(i_1, i_2)`
.....................................

* Let :math:`j_2` be :math:`i_2` modulo :math:`N`.

* Return the result of shifting :math:`i_1` right by :math:`j_2` bits, extended with the most significant bit of the original value.

.. math::
   \begin{array}{@{}lcll}
   \F{shr\_s}_{\K{i}N}(i_1, i_2) &=& \signed_N^{-1}(\floor_N(\signed_N(i_1) / 2^{i_2 \mod N})) \\
   \F{shr\_s}_{\K{i}N}(i_1, i_2) &=& \bits_N^{-1}(b_0^{k+1}~b_1^{N-k-1}) & (\bits_N(i_1) = b_0~b_1^{N-k-1}~b_2^k \wedge k = i_2 \mod N)
   \end{array}

.. _exec-rotl:

:math:`\F{rotl}_{\K{i}N}(i_1, i_2)`
...................................

* Let :math:`j_2` be :math:`i_2` modulo :math:`N`.

* Return the result of rotating :math:`i_1` left by :math:`j_2` bits.

.. math::
   \begin{array}{@{}lcll}
   \F{rotl}_{\K{i}N}(i_1, i_2) &=& (i_1 \cdot 2^{i_2 \mod N} \mod 2^N) + \floor_N(i_1 / 2^{N - (i_2 \mod N)}) \\
   \F{rotl}_{\K{i}N}(i_1, i_2) &=& \bits_N^{-1}(b_2^{N-k}~b_1^k) & (\bits_N(i_1) = b_1^k~b_2^{N-k} \wedge k = i_2 \mod N)
   \end{array}

.. _exec-rotr:

:math:`\F{rotr}_{\K{i}N}(i_1, i_2)`
...................................

* Let :math:`j_2` be :math:`i_2` modulo :math:`N`.

* Return the result of rotating :math:`i_1` right by :math:`j_2` bits.

.. math::
   \begin{array}{@{}lcll}
   \F{rotr}_{\K{i}N}(i_1, i_2) &=& (i_1 \cdot 2^{N - (i_2 \mod N)} \mod 2^N) + \floor_N(i_1 / 2^{i_2 \mod N}) \\
   \F{rotr\_u}_{\K{i}N}(i_1, i_2) &=& \bits_N^{-1}(b_2^k~b_1^{N-k}) & (\bits_N(i_1) = b_1^{N-k}~b_2^k \wedge k = i_2 \mod N)
   \end{array}


.. _exec-clz:

:math:`\F{clz}_{\K{i}N}(i)`
...........................

* Return the count of leading zero bits in :math:`i`; all bits are considered leading zeros if :math:`i` is :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \F{clz}_{\K{i}N}(i) &=& k & (\bits_N(i) = 0^k~(1~b^\ast)^?)
   \end{array}


.. _exec-ctz:

:math:`\F{ctz}_{\K{i}N}(i)`
...........................

* Return the count of trailing zero bits in :math:`i`; all bits are considered trailing zeros if :math:`i` is :math:`0`.

.. math::
   \begin{array}{@{}lcll}
   \F{ctz}_{\K{i}N}(i) &=& k & (\bits_N(i) = (b^\ast~1)^?~0^k)
   \end{array}


.. _exec-popcnt:

:math:`\F{popcnt}_{\K{i}N}(i)`
..............................

* Return the count of non-zero bits in :math:`i`.

.. math::
   \begin{array}{@{}lcll}
   \F{popcnt}_{\K{i}N}(i) &=& k & (\bits_N(i) = (0^\ast~1)^k~0^\ast)
   \end{array}


.. _exec-eqz:

:math:`\F{eqz}_{\K{i}N}(i)`
...........................

* Return :math:`1` if :math:`i` is zero, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \F{eqz}_{\K{i}N}(i) &=& \bool(i = 0)
   \end{array}


.. _exec-eq:

:math:`\F{eq}_{\K{i}N}(i_!, i_2)`
.................................

* Return :math:`1` if :math:`i_1` equals :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \F{eq}_{\K{i}N}(i_1, i_2) &=& \bool(i_1 = i_2)
   \end{array}


.. _exec-ne:

:math:`\F{ne}_{\K{i}N}(i_!, i_2)`
.................................

* Return :math:`1` if :math:`i_1` does not equal :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \F{ne}_{\K{i}N}(i_1, i_2) &=& \bool(i_1 \neq i_2)
   \end{array}


.. _exec-lt_u:

:math:`\F{lt\_u}_{\K{i}N}(i_!, i_2)`
....................................

* Return :math:`1` if :math:`i_1` is less than :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \F{lt\_u}_{\K{i}N}(i_1, i_2) &=& \bool(i_1 < i_2)
   \end{array}


.. _exec-lt_s:

:math:`\F{lt\_s}_{\K{i}N}(i_!, i_2)`
....................................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`.

* Let :math:`j_2` be the signed interpretation of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is less than :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \F{lt\_s}_{\K{i}N}(i_1, i_2) &=& \bool(\signed_N(i_1) < \signed_N(i_2))
   \end{array}


.. _exec-gt_u:

:math:`\F{gt\_u}_{\K{i}N}(i_!, i_2)`
....................................

* Return :math:`1` if :math:`i_1` is greater than :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \F{gt\_u}_{\K{i}N}(i_1, i_2) &=& \bool(i_1 > i_2)
   \end{array}


.. _exec-gt_s:

:math:`\F{gt\_s}_{\K{i}N}(i_!, i_2)`
....................................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`.

* Let :math:`j_2` be the signed interpretation of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is greater than :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \F{gt\_s}_{\K{i}N}(i_1, i_2) &=& \bool(\signed_N(i_1) > \signed_N(i_2))
   \end{array}


.. _exec-le_u:

:math:`\F{le\_u}_{\K{i}N}(i_!, i_2)`
....................................

* Return :math:`1` if :math:`i_1` is less than or equal to :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \F{le\_u}_{\K{i}N}(i_1, i_2) &=& \bool(i_1 \leq i_2)
   \end{array}


.. _exec-le_s:

:math:`\F{le\_s}_{\K{i}N}(i_!, i_2)`
....................................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`.

* Let :math:`j_2` be the signed interpretation of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is less than or equal to :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \F{le\_s}_{\K{i}N}(i_1, i_2) &=& \bool(\signed_N(i_1) \leq \signed_N(i_2))
   \end{array}


.. _exec-ge_u:

:math:`\F{ge\_u}_{\K{i}N}(i_!, i_2)`
....................................

* Return :math:`1` if :math:`i_1` is greater than or equal to :math:`i_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \F{ge\_u}_{\K{i}N}(i_1, i_2) &=& \bool(i_1 \geq i_2)
   \end{array}


.. _exec-ge_s:

:math:`\F{ge\_s}_{\K{i}N}(i_!, i_2)`
....................................

* Let :math:`j_1` be the signed interpretation of :math:`i_1`.

* Let :math:`j_2` be the signed interpretation of :math:`i_2`.

* Return :math:`1` if :math:`j_1` is greater than or equal to :math:`j_2`, :math:`0` otherwise.

.. math::
   \begin{array}{@{}lcll}
   \F{ge\_s}_{\K{i}N}(i_1, i_2) &=& \bool(\signed_N(i_1) \geq \signed_N(i_2))
   \end{array}


Floating-Point Operations
~~~~~~~~~~~~~~~~~~~~~~~~~


Conversions
~~~~~~~~~~~

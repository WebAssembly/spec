.. _syntax-value:
.. index:: ! value
   pair: abstract syntax; value

Values
------


.. _syntax-byte:
.. index:: ! byte
   pair: abstract syntax; byte

Bytes
~~~~~

The simplest form of value are raw uninterpreted *bytes*.
In the abstract syntax they are represented as hexadecimal literals.

.. math::
   \begin{array}{llll}
   \production{byte} & \byte &::=&
     \hex{00} ~|~ \dots ~|~ \hex{FF} \\
   \end{array}


Conventions
...........

* The meta variable :math:`b` range over bytes.

* Bytes are sometimes interpreted as natural numbers :math:`n < 256`.


.. _syntax-int:
.. _syntax-sint:
.. _syntax-uint:
.. index:: ! integer, ! unsigned integer, ! signed integer, ! uninterpreted integer
   pair: abstract syntax; integer
   pair: abstract syntax; unsigned integer
   pair: abstract syntax; signed integer
   pair: abstract syntax; uninterpreted integer
   single: integer; unsigned
   single: integer; signed
   single: integer; uninterpreted

Integers
~~~~~~~~

Different classes of *integers* with different value ranges are distinguished by their *size* and their *signedness*.

.. math::
   \begin{array}{llll}
   \production{unsigned integer} & \uN &::=&
     0 ~|~ 1 ~|~ \dots ~|~ 2^N{-}1 \\
   \production{signed integer} & \sN &::=&
     -2^{N-1} ~|~ \dots ~|~ {-}1 ~|~ 0 ~|~ 1 ~|~ \dots ~|~ 2^{N-1}{-}1 \\
   \production{uninterpreted integer} & \iN &::=&
     \uN \\
   \end{array}

The latter class defines *uninterpreted* integers, whose signedness interpretation can vary depending on context.
In the abstract syntax, they are represented as unsigned.
However, some operations :ref:`convert <aux-signed>` them to signed based on a 2's complement interpretation.


Conventions
...........

* The meta variables :math:`m, n, i` range over integers.

* Numbers may be denoted by simple arithmetics, as in the grammar above.


.. _syntax-float:
.. _syntax-nan:
.. _syntax-payload:
.. index:: ! floating-point number, ! NaN, payload, canonical NaN, arithmetic NaN
   pair: abstract syntax; floating-point number
   single: NaN; payload
   single: NaN; canonical
   single: NaN; arithmetic

Floating-Point
~~~~~~~~~~~~~~

*Floating-point* data consists of values according to the `IEEE 754 <http://ieeexplore.ieee.org/document/4610935/>`_ standard.
Every value has a *sign* and a *magnitude*.
Magnitudes include the special value :math:`\infty` (infinity) and |NAN| (*NaN*, not a number).
Furthermore, NaN values have a *payload* value that describes the mantissa bits in the underlying representation.
No distinction is being made between signalling and silent NaNs.

.. math::
   \begin{array}{llcll}
   \production{floating-point number} & \fN &::=&
     + \fNmag ~|~ - \fNmag \\
   \production{floating-point magnitude} & \fNmag &::=&
     0 \\ &&|&
     q & (\ieee_N(q) = q \in \mathbb{Q}_+) \\ &&|&
     \infty \\ &&|&
     \NAN(\uM) & (M = \payloadsize(N) \wedge \uM \neq 0) \\
   \end{array}

where

.. _aux-payloadsize:

.. math::
   \begin{array}{lcl}
   \payloadsize(32) &=& 23 \\
   \payloadsize(64) &=& 52 \\
   \end{array}

The two possible sizes :math:`N` are 32 and 64.

.. note::
   The auxiliary function :math:`\ieee_N` rounds a rational value to the nearest value representable in IEEE 754.
   The respective side condition ensures that only representable floating-point values are part of the abstract syntax.

.. _canonical-nan:
.. _arithmetic-nan:
.. _aux-canon:

A *canonical NaN* is a floating-point value :math:`\pm\NAN(\canon_N)` where :math:`\canon_N` is a payload whose most significant bit is :math:`1` while all others are :math:`0`:

.. math::
   \canon_N = 2^{\payloadsize(N)-1}

An *arithmetic NaN*  is a floating-point value :math:`\pm\NAN(n)` with :math:`n > \canon_N`, such that the most significant bit is :math:`1` while all others are arbitrary.


.. _syntax-vec:
.. index:: ! vector
   pair: abstract syntax; vector

Vectors
~~~~~~~

*Vectors* are bounded sequences of the form :math:`A^n` (or :math:`A^\ast`),
where the :math:`A`-s can either be values or complex constructions.
A vector can have at most :math:`2^{32}-1` elements.

.. math::
   \begin{array}{lllll}
   \production{vector} & \vec(A) &::=&
     A^n
     & (n < 2^{32})\\
   \end{array}


.. _syntax-name:
.. _syntax-utf8:
.. index:: ! name, byte, Unicode, UTF-8, code point
   pair: abstract syntax; name

Names
~~~~~

*Names* are sequences of *scalar* `Unicode <http://www.unicode.org/versions/latest/>`_ *code points*.

.. math::
   \begin{array}{llclll}
   \production{name} & \name &::=&
     \codepoint^\ast & (|\utf8(\codepoint^\ast)| < 2^{32}) \\
   \production{code point} & \codepoint &::=&
     \unicode{0000} ~|~ \dots ~|~ \unicode{D7FF} ~|~
     \unicode{E000} ~|~ \dots ~|~ \unicode{10FFFF} \\
   \end{array}

Due to the limitations of the :ref:`binary format <binary-name>`,
the lengths of a name is bounded by the length of its `UTF-8 <http://www.unicode.org/versions/latest/>`_ encoding.
The auxiliary |utf8| function expressing this encoding is defined as follows:

.. math::
   \begin{array}{lcl@{\qquad}l}
   \utf8(c^\ast) &=& (\utf8(c))^\ast \\[1ex]
   \utf8(c) &=& b & (c < \unicode{80} \wedge c = b) \\
   \utf8(c) &=& b_1~b_2 & (\unicode{80} \leq c < \unicode{800} \wedge c = 2^6\cdot(b_1-\hex{C0})+(b_2-\hex{80})) \\
   \utf8(c) &=& b_1~b_2~b_3 & (\unicode{800} \leq c < \unicode{10000} \wedge c = 2^{12}\cdot(b_1-\hex{C0})+2^6\cdot(b_2-\hex{80})+(b_3-\hex{80})) \\
   \utf8(c) &=& b_1~b_2~b_3~b_4 & (\unicode{10000} \leq c < \unicode{110000} \wedge c = 2^{18}\cdot(b_1-\hex{C0})+2^{12}\cdot(b_2-\hex{80})+2^6\cdot(b_3-\hex{80})+(b_4-\hex{80})) \\
   \end{array}


Convention
..........

* Code points are sometimes used interchangeably with natural numbers :math:`n < 1114112`.

.. index:: ! value
   pair: abstract syntax; value
.. _syntax-value:

Values
------


.. index:: ! byte
   pair: abstract syntax; byte
.. _syntax-byte:

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

* The meta variable :math:`b` ranges over bytes.

* Bytes are sometimes interpreted as natural numbers :math:`n < 256`.


.. index:: ! integer, ! unsigned integer, ! signed integer, ! uninterpreted integer
   pair: abstract syntax; integer
   pair: abstract syntax; unsigned integer
   pair: abstract syntax; signed integer
   pair: abstract syntax; uninterpreted integer
   single: integer; unsigned
   single: integer; signed
   single: integer; uninterpreted
.. _syntax-sint:
.. _syntax-uint:
.. _syntax-int:

Integers
~~~~~~~~

Different classes of *integers* with different value ranges are distinguished by their bit *width* :math:`N` and by whether they are *unsigned* or *signed*.

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
However, some operations :ref:`convert <aux-signed>` them to signed based on a two's complement interpretation.

.. note::
   The only integer types currently occurring in this specification are |u32|, |u64|, |s32|, and |s64|.


Conventions
...........

* The meta variables :math:`m, n, i` range over integers.

* Numbers may be denoted by simple arithmetics, as in the grammar above.


.. index:: ! floating-point number, ! NaN, payload, canonical NaN, arithmetic NaN
   pair: abstract syntax; floating-point number
   single: NaN; payload
   single: NaN; canonical
   single: NaN; arithmetic
.. _syntax-nan:
.. _syntax-payload:
.. _syntax-float:

Floating-Point
~~~~~~~~~~~~~~

*Floating-point* data consists of 32 or 64 bit values according to the `IEEE 754 <http://ieeexplore.ieee.org/document/4610935/>`_ standard.
Every value has a *sign* and a *magnitude*.

Magnitudes can either be expressed as *normal* numbers of the form :math:`m_0.m_1m_2\dots m_M \cdot2^e`, where :math:`e` is the exponent and :math:`m` is the *significand* whose most signifcant bit :math:`m_0` is :math:`1`,
or as a *subnormal* number where the exponent is fixed to the smallest possible value and :math:`m_0` is :math:`0`; among the subnormals are positive and negative zero values.
Since the significands are binary values, normals are represented in the form :math:`(1 + m\cdot 2^{-M})`, where :math:`M` is the bit width of :math:`m`; similarly for subnormals.

Possible magnitudes also include the special values :math:`\infty` (infinity) and |NAN| (*NaN*, not a number).
NaN values have a *payload* that describes the mantissa bits in the underlying :ref:`binary representation <aux-fbits>`.
No distinction is made between signalling and quiet NaNs.

.. math::
   \begin{array}{llcll}
   \production{floating-point number} & \fN &::=&
     {+} \fNmag ~|~ {-} \fNmag \\
   \production{floating-point magnitude} & \fNmag &::=&
     (1 + \uM\cdot 2^{-M}) \cdot 2^e & (\iff -2^{E-1}+2 \leq e \leq 2^{E-1}-1) \\ &&|&
     (0 + \uM\cdot 2^{-M}) \cdot 2^e & (\iff e = -2^{E-1}+2) \\ &&|&
     \infty \\ &&|&
     \NAN(n) & (\iff 1 \leq n < 2^M) \\
   \end{array}

where :math:`M = \significand(N)` and :math:`E = \exponent(N)` with

.. _aux-significand:
.. _aux-exponent:

.. math::
   \begin{array}{lclllllcl}
   \significand(32) &=& 23 &&&&
   \exponent(32) &=& 8 \\
   \significand(64) &=& 52 &&&&
   \exponent(64) &=& 11 \\
   \end{array}

.. _canonical-nan:
.. _arithmetic-nan:
.. _aux-canon:

A *canonical NaN* is a floating-point value :math:`\pm\NAN(\canon_N)` where :math:`\canon_N` is a payload whose most significant bit is :math:`1` while all others are :math:`0`:

.. math::
   \canon_N = 2^{\significand(N)-1}

An *arithmetic NaN*  is a floating-point value :math:`\pm\NAN(n)` with :math:`n \geq \canon_N`, such that the most significant bit is :math:`1` while all others are arbitrary.


Conventions
...........

* The meta variable :math:`z` ranges over floating-point values where clear from context.

* Floating-point numbers, in normal or subnormal form, are sometimes interpreted as rational numbers :math:`q \in \mathbb{Q}`.


.. index:: ! vector
   pair: abstract syntax; vector
.. _syntax-vec:

Vectors
~~~~~~~

*Vectors* are bounded sequences of the form :math:`A^n` (or :math:`A^\ast`),
where the :math:`A`s can either be values or complex constructions.
A vector can have at most :math:`2^{32}-1` elements.

.. math::
   \begin{array}{lllll}
   \production{vector} & \vec(A) &::=&
     A^n
     & (\iff n < 2^{32})\\
   \end{array}


.. index:: ! name, byte, Unicode, UTF-8, code point
   pair: abstract syntax; name
.. _syntax-utf8:
.. _syntax-codepoint:
.. _syntax-name:

Names
~~~~~

*Names* are sequences of *scalar* `Unicode <http://www.unicode.org/versions/latest/>`_ *code points*.

.. math::
   \begin{array}{llclll}
   \production{name} & \name &::=&
     \codepoint^\ast \qquad\qquad (\iff |\utf8(\codepoint^\ast)| < 2^{32}) \\
   \production{code point} & \codepoint &::=&
     \unicode{00} ~|~ \dots ~|~ \unicode{D7FF} ~|~
     \unicode{E000} ~|~ \dots ~|~ \unicode{10FFFF} \\
   \end{array}

Due to the limitations of the :ref:`binary format <binary-name>`,
the lengths of a name is bounded by the length of its `UTF-8 <http://www.unicode.org/versions/latest/>`_ encoding.
The auxiliary |utf8| function expressing this encoding is defined as follows:

.. math::
   \begin{array}{lcl@{\qquad}l}
   \utf8(c^\ast) &=& (\utf8(c))^\ast \\[1ex]
   \utf8(c) &=& b & (\iff c < \unicode{80} \wedge c = b) \\
   \utf8(c) &=& b_1~b_2 & (\iff \unicode{80} \leq c < \unicode{800} \wedge c = 2^6\cdot(b_1-\hex{C0})+(b_2-\hex{80})) \\
   \utf8(c) &=& b_1~b_2~b_3 & (\iff \unicode{800} \leq c < \unicode{10000} \wedge c = 2^{12}\cdot(b_1-\hex{C0})+2^6\cdot(b_2-\hex{80})+(b_3-\hex{80})) \\
   \utf8(c) &=& b_1~b_2~b_3~b_4 & (\iff \unicode{10000} \leq c < \unicode{110000} \wedge c = 2^{18}\cdot(b_1-\hex{C0})+2^{12}\cdot(b_2-\hex{80})+2^6\cdot(b_3-\hex{80})+(b_4-\hex{80})) \\
   \end{array}


Convention
..........

* Code points are sometimes used interchangeably with natural numbers :math:`n < 1114112`.

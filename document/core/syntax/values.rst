.. index:: ! value
   pair: abstract syntax; value
.. _syntax-value:

Values
------

WebAssembly programs operate on primitive numeric *values*.
Moreover, in the definition of programs, immutable sequences of values occur to represent more complex data, such as text strings or other vectors.


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


.. index:: ! integer, ! unsigned integer, ! signed integer, ! uninterpreted integer, bit width, two's complement
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

Different classes of *integers* with different value ranges are distinguished by their *bit width* :math:`N` and by whether they are *unsigned* or *signed*.

.. math::
   \begin{array}{llll}
   \production{unsigned integer} & \uN &::=&
     0 ~|~ 1 ~|~ \dots ~|~ 2^N{-}1 \\
   \production{signed integer} & \sN &::=&
     -2^{N-1} ~|~ \dots ~|~ {-}1 ~|~ 0 ~|~ 1 ~|~ \dots ~|~ 2^{N-1}{-}1 \\
   \production{uninterpreted integer} & \iN &::=&
     \uN \\
   \end{array}

The class |iN| defines *uninterpreted* integers, whose signedness interpretation can vary depending on context.
In the abstract syntax, they are represented as unsigned values.
However, some operations :ref:`convert <aux-signed>` them to signed based on a two's complement interpretation.

.. note::
   The main integer types occurring in this specification are |u32|, |u64|, |s32|, |s64|, |i8|, |i16|, |i32|, |i64|.
   However, other sizes occur as auxiliary constructions, e.g., in the definition of :ref:`floating-point <syntax-float>` numbers.


Conventions
...........

* The meta variables :math:`m, n, i` range over integers.

* Numbers may be denoted by simple arithmetics, as in the grammar above.
  In order to distinguish arithmetics like :math:`2^N` from sequences like :math:`(1)^N`, the latter is distinguished with parentheses.


.. index:: ! floating-point, ! NaN, payload, significand, exponent, magnitude, canonical NaN, arithmetic NaN, bit width, IEEE 754
   pair: abstract syntax; floating-point number
   single: NaN; payload
   single: NaN; canonical
   single: NaN; arithmetic
.. _syntax-nan:
.. _syntax-payload:
.. _syntax-float:

Floating-Point
~~~~~~~~~~~~~~

*Floating-point* data represents 32 or 64 bit values that correspond to the respective binary formats of the |IEEE754|_ standard (Section 3.3).

Every value has a *sign* and a *magnitude*.
Magnitudes can either be expressed as *normal* numbers of the form :math:`m_0.m_1m_2\dots m_M \cdot2^e`, where :math:`e` is the exponent and :math:`m` is the *significand* whose most significant bit :math:`m_0` is :math:`1`,
or as a *subnormal* number where the exponent is fixed to the smallest possible value and :math:`m_0` is :math:`0`; among the subnormals are positive and negative zero values.
Since the significands are binary values, normals are represented in the form :math:`(1 + m\cdot 2^{-M}) \cdot 2^e`, where :math:`M` is the bit width of :math:`m`; similarly for subnormals.

Possible magnitudes also include the special values :math:`\infty` (infinity) and |NAN| (*NaN*, not a number).
NaN values have a *payload* that describes the mantissa bits in the underlying :ref:`binary representation <aux-fbits>`.
No distinction is made between signalling and quiet NaNs.

.. math::
   \begin{array}{llcll}
   \production{floating-point value} & \fN &::=&
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

.. note::
   In the abstract syntax, subnormals are distinguished by the leading 0 of the significand. The exponent of subnormals has the same value as the smallest possible exponent of a normal number. Only in the :ref:`binary representation <binary-float>` the exponent of a subnormal is encoded differently than the exponent of any normal number.

   The notion of canonical NaN defined here is unrelated to the notion of canonical NaN that the |IEEE754|_ standard (Section 3.5.2) defines for decimal interchange formats.

Conventions
...........

* The meta variable :math:`z` ranges over floating-point values where clear from context.


.. index:: ! numeric vector, integer, floating-point, lane, SIMD
   pair: abstract syntax; vector
.. _syntax-vecnum:

Vectors
~~~~~~~

*Numeric vectors* are 128-bit values that are processed by vector instructions (also known as *SIMD* instructions, single instruction multiple data).
They are represented in the abstract syntax using |i128|. The interpretation of lane types (:ref:`integer <syntax-int>` or :ref:`floating-point <syntax-float>` numbers) and lane sizes are determined by the specific instruction operating on them.


.. index:: ! name, byte, Unicode, UTF-8, character, binary format
   pair: abstract syntax; name
.. _syntax-char:
.. _syntax-name:

Names
~~~~~

*Names* are sequences of *characters*, which are *scalar values* as defined by |Unicode|_ (Section 2.4).

.. math::
   \begin{array}{llclll}
   \production{name} & \name &::=&
     \char^\ast \qquad\qquad (\iff |\utf8(\char^\ast)| < 2^{32}) \\
   \production{character} & \char &::=&
     \unicode{00} ~|~ \dots ~|~ \unicode{D7FF} ~|~
     \unicode{E000} ~|~ \dots ~|~ \unicode{10FFFF} \\
   \end{array}

Due to the limitations of the :ref:`binary format <binary-name>`,
the length of a name is bounded by the length of its :ref:`UTF-8 <binary-utf8>` encoding.


Convention
..........

* Characters (Unicode scalar values) are sometimes used interchangeably with natural numbers :math:`n < 1114112`.

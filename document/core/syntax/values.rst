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

$${syntax: byte}


Conventions
...........

* The meta variable ${:b} ranges over bytes.

* Bytes are sometimes interpreted as natural numbers ${:n < 256}`.


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

Different classes of *integers* with different value ranges are distinguished by their *bit width* ${:N} and by whether they are *unsigned* or *signed*.

$${syntax: {uN sN iN}}

The class ${:iN} defines *uninterpreted* integers, whose signedness interpretation can vary depending on context.
In the abstract syntax, they are represented as unsigned values.
However, some operations :ref:`convert <aux-signed>` them to signed based on a two's complement interpretation.

.. note::
   The main integer types occurring in this specification are ${:u32}, ${:u64}, ${:s32}, ${:s64}, ${:i8}, ${:i16}, ${:i32}, ${:i64}.
   However, other sizes occur as auxiliary constructions, e.g., in the definition of :ref:`floating-point <syntax-float>` numbers.

${syntax-ignore: u8 u16 u31 u32 u64 u128 s33}


Conventions
...........

* The meta variables ${:m}, ${:n}, ${:i}, ${:j} range over integers.

* Numbers may be denoted by simple arithmetics, as in the grammar above.
  In order to distinguish arithmetics like ${:2^N} from sequences like ${:(1)^N}, the latter is distinguished with parentheses.


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
Magnitudes can either be expressed as *normal* numbers of the form ${:m_0`. m_1 m_2`... $(m_M *2^e)}, where ${:e} is the exponent and ${:m} is the *significand* whose most significant bit ${:m_0} is ${:1}`,
or as a *subnormal* number where the exponent is fixed to the smallest possible value and ${:m_0} is ${:0}; among the subnormals are positive and negative zero values.
Since the significands are binary values, normals are represented in the form ${:$((1 + m*2^(-M)) * 2^e)}, where ${:M} is the bit width of ${:m}; similarly for subnormals.

Possible magnitudes also include the special values ${:infinity}` (infinity) and ${:NAN} (*NaN*, not a number).
NaN values have a *payload* that describes the mantissa bits in the underlying :ref:`binary representation <aux-fbits>`.
No distinction is made between signalling and quiet NaNs.

$${syntax: {fN fNmag}}

.. _aux-significand:
.. _aux-exponent:

where ${definition: M} and ${definition: E} with

$${definition: {signif} {expon}}

${syntax-ignore: f32 f64}

.. _canonical-nan:
.. _arithmetic-nan:
.. _aux-canon:

A *canonical NaN* is a floating-point value ${:+-NAN($canon_(N))} where ${:$canon_(N)} is a payload whose most significant bit is ${:1} while all others are ${:0}:

$${definition: canon_}

An *arithmetic NaN* is a floating-point value ${:+-NAN(m)} with ${:m >= $canon_(N)}, such that the most significant bit is ${:1} while all others are arbitrary.

.. note::
   In the abstract syntax, subnormals are distinguished by the leading ${:0} of the significand. The exponent of subnormals has the same value as the smallest possible exponent of a normal number. Only in the :ref:`binary representation <binary-float>` the exponent of a subnormal is encoded differently than the exponent of any normal number.

   The notion of canonical NaN defined here is unrelated to the notion of canonical NaN that the |IEEE754|_ standard (Section 3.5.2) defines for decimal interchange formats.

Conventions
...........

* The meta variable ${:z} ranges over floating-point values where clear from context.

* Where clear from context, shorthands like ${:$fone} or ${:$fzero} denote floating point values like ${:POS $($(NORM 1 0))} or ${:POS $($(SUBNORM 0))}.


.. index:: ! numeric vector, integer, floating-point, lane, SIMD
   pair: abstract syntax; vector
.. _syntax-vecnum:

Vectors
~~~~~~~

*Numeric vectors* are 128-bit values that are processed by vector instructions (also known as *SIMD* instructions, single instruction multiple data).
They are represented in the abstract syntax using ${:i128}. The interpretation of lane types (:ref:`integer <syntax-int>` or :ref:`floating-point <syntax-float>` numbers) and lane sizes are determined by the specific instruction operating on them.


.. index:: ! name, byte, Unicode, UTF-8, character, binary format
   pair: abstract syntax; name
.. _syntax-char:
.. _syntax-name:

Names
~~~~~

*Names* are sequences of *characters*, which are *scalar values* as defined by |Unicode|_ (Section 2.4).

$${syntax: {name char}}

Due to the limitations of the :ref:`binary format <binary-name>`,
the length of a name is bounded by the length of its :ref:`UTF-8 <binary-utf8>` encoding.


Convention
..........

* Characters (Unicode scalar values) are sometimes used interchangeably with natural numbers ${:n < 1114112}.

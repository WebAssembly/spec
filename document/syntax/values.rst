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
   \production{bytes} & \by &::=&
     \hex{00} ~|~ \dots ~|~ \hex{FF} \\
   \end{array}


Conventions
...........

* The meta variable :math:`b` range over bytes.

* The meta function :math:`\byte(n)` denotes the byte representing the natural number :math:`n < 256`.


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
   \production{unsigned integers} & \uN &::=&
     0 ~|~ 1 ~|~ \dots ~|~ 2^N{-}1 \\
   \production{signed integers} & \sN &::=&
     -2^{N-1} ~|~ \dots ~|~ {-}1 ~|~ 0 ~|~ 1 ~|~ \dots ~|~ 2^{N-1}{-}1 \\
   \production{uninterpreted integers} & \iN &::=&
     \uN ~|~ \sN \\
   \end{array}

The latter class defines *uninterpreted* integers, whose signedness interpretation can vary depending on context.
In those contexts, a conversion based on 2's complement will be applied for values that are out-of-range for a chosen interpretation.
That is, semantically, when interpreted as unsigned, negative values :math:`-n` convert to :math:`2^N-n`,
and when interpreted as signed, positive values :math:`n \geq 2^{N-1}` convert to :math:`n-2^N`.

.. todo:: once there, link to definition of conversion


Conventions
...........

* The meta variables :math:`m, n` range over unsigned integers.

* Numbers may be denoted by simple arithmetics, as in the grammar above.


.. _syntax-float:
.. index:: ! floating-point number
   pair: abstract syntax; floating-point number

Floating-Point
~~~~~~~~~~~~~~

*Floating-point* data consists of values in binary floating-point format according to the `IEEE 754 <http://ieeexplore.ieee.org/document/4610935/>`_ standard.

.. math::
   \begin{array}{llll}
   \production{floating-point numbers} & \fN &::=&
     \by^{N/8} \\
   \end{array}

The two possible sizes :math:`N` are 32 and 64.


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
   \production{vectors} & \vec(A) &::=&
     A^n
     & (n < 2^{32})\\
   \end{array}


.. _syntax-name:
.. index:: ! name, byte
   pair: abstract syntax; name

Names
~~~~~

*Names* are vectors of bytes interpreted as character strings.

.. math::
   \begin{array}{llll}
   \production{names} & \name &::=&
     \vec(\by) \\
   \end{array}

.. todo::
   Unicode?

.. _binary-value:
.. index:: value
   binary: binary format; value
   single: abstract syntax; value

Values
------


.. _binary-int:
.. _binary-sint:
.. _binary-uint:
.. index:: integer, unsigned integer, signed integer, uninterpreted integer
   pair: binary format; integer
   pair: binary format; unsigned integer
   pair: binary format; signed integer
   pair: binary format; uninterpreted integer
   single: abstract syntax; integer
   single: abstract syntax; unsigned integer
   single: abstract syntax; signed integer
   single: abstract syntax; uninterpreted integer

Integers
~~~~~~~~

All integers are encoded using the `LEB128 <https://en.wikipedia.org/wiki/LEB128>`_ variable-length integer encoding, in either unsigned or signed variant.

Unsigned integers are encoded in `unsigned LEB128 <https://en.wikipedia.org/wiki/LEB128#Unsigned_LEB128>`_ format.
As an additional constraint, the total number of bytes encoding a value of type :math:`\uX{N}` must not exceed :math:`\F{ceil}(N/7)` bytes.

.. math::
   \begin{array}{llcll@{\qquad\qquad}l}
   \production{unsigned integers} & \BuX{N} &::=&
     \byte(n)
     &\Rightarrow&
     n
     & (n < 128) \\
   &&|&
     \byte(n)~~
     \BuX{N-7}\{m\}
     &\Rightarrow&
     128\cdot m + (n-128)
     & (n \geq 128 \wedge N > 7) \\
   \end{array}

Signed integers are encoded in `signed LEB128 <https://en.wikipedia.org/wiki/LEB128#Signed_LEB128>`_ format, which uses a 2's complement representation.
As an additional constraint, the total number of bytes encoding a value of type :math:`\sX{N}` must not exceed :math:`\F{ceil}(N/7)` bytes.

.. math::
   \begin{array}{llcll@{\qquad\qquad}l}
   \production{signed integers} & \BsX{N} &::=&
     \byte(n)
     &\Rightarrow&
     n
     & (0 \leq n < 64) \\
   &&|&
     \byte(n)
     &\Rightarrow&
     128-n
     & (64 \leq n < 128) \\
   &&|&
     \byte(n)~~
     \BsX{N-7}\{\pm m\}
     &\Rightarrow&
     \pm 128\cdot m + (n-128)
     & (n \geq 128 \wedge N > 7) \\
   \end{array}

Uninterpreted integers are encoded as signed, assuming a 2's complement interpretation.

.. math::
   \begin{array}{llcll@{\qquad\qquad}l}
   \production{uninterpreted integers} & \BiX{N} &::=&
     \BsX{N}\{n\}
     &\Rightarrow&
     n
   \end{array}


.. _binary-float:
.. index:: floating-point number
   pair: binary format; floating-point number
   single: abstract syntax; floating-point number

Floating-Point
~~~~~~~~~~~~~~

Floating point values are encoded directly by their IEEE bit pattern in `little endian <https://en.wikipedia.org/wiki/Endianness#Little-endian>`_ byte order:

.. math::
   \begin{array}{llcll@{\qquad\qquad}l}
   \production{floating-point numbers} & \BfX{N} &::=&
     b^{N/8}
     &\Rightarrow&
     b^{N/8} \\
   \end{array}


.. _binary-vec:
.. index:: vector
   pair: binary format; vector
   single: abstract syntax; vector

Vectors
~~~~~~~

Vectors are encoded with their length followed by the encoding of their element sequence.

.. math::
   \begin{array}{llcll@{\qquad\qquad}l}
   \production{vectors} & \Bvec(A) &::=&
     \Bu32\{n\}~~
     (A\{x\})^n
     &\Rightarrow&
     x^n \\
   \end{array}


.. _binary-name:
.. index:: name, byte
   pair: binary format; name
   single: abstract syntax; name

Names
~~~~~

Names are encoded directly as a vector of bytes.

.. math::
   \begin{array}{llcll}
   \production{names} & \Bname &::=&
     \Bvec(\by)\{b^\ast\}
     &\Rightarrow&
     b^\ast \\
   \end{array}

.. todo::
   UTF-8?

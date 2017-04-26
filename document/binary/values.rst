.. _binary-value:
.. index:: value
   binary: binary format; value
   single: abstract syntax; value

Values
------


.. _binary-byte:
.. index:: byte
   pair: binary encoding; byte
   single: abstract syntax; byte

Bytes
~~~~~

:ref:`Bytes <syntax-int>` encode themselves.

.. math::
   \begin{array}{llcll@{\qquad}l}
   \production{byte} & \Bbyte &::=&
     \hex{00} &\Rightarrow& \hex{00} \\ &&|&&
     \dots \\ &&|&
     \hex{FF} &\Rightarrow& \hex{FF} \\
   \end{array}


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

All :ref:`integers <syntax-int>` are encoded using the `LEB128 <https://en.wikipedia.org/wiki/LEB128>`_ variable-length integer encoding, in either unsigned or signed variant.

:ref:`Unsigned integers <syntax-uint>` are encoded in `unsigned LEB128 <https://en.wikipedia.org/wiki/LEB128#Unsigned_LEB128>`_ format.
As an additional constraint, the total number of bytes encoding a value of type :math:`\uX{N}` must not exceed :math:`\F{ceil}(N/7)` bytes.

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{unsigned integer} & \BuX{N} &::=&
     n{:}\Bbyte &\Rightarrow& n & (n < 2^7 \wedge n < 2^N) \\ &&|&
     n{:}\Bbyte~~m{:}\BuX{(N\B{-7})} &\Rightarrow&
       2^7\cdot m + (n-2^7) & (n \geq 2^7 \wedge N > 7) \\
   \end{array}

:ref:`Signed integers <syntax-sint>` are encoded in `signed LEB128 <https://en.wikipedia.org/wiki/LEB128#Signed_LEB128>`_ format, which uses a 2's complement representation.
As an additional constraint, the total number of bytes encoding a value of type :math:`\sX{N}` must not exceed :math:`\F{ceil}(N/7)` bytes.

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{signed integer} & \BsX{N} &::=&
     n{:}\Bbyte &\Rightarrow& n & (n < 2^6 \wedge n < 2^{N-1}) \\ &&|&
     n{:}\Bbyte &\Rightarrow& n-2^7 & (2^6 \leq n < 2^7 \wedge n \geq 2^7-2^{N-1}) \\ &&|&
     n{:}\Bbyte~~m{:}\BsX{(N\B{-7})} &\Rightarrow&
       2^7\cdot m + (n-2^7) & (n \geq 2^7 \wedge N > 7) \\
   \end{array}

:ref:`Uninterpreted integers <syntax-int>` are always encoded as signed integers.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{uninterpreted integer} & \BiX{N} &::=&
     n{:}\BsX{N} &\Rightarrow& n
   \end{array}

.. note::
   While the side conditions :math:`N > 7` in the productions for *non-terminating* bytes restrict the length of the :math:`\uX{}` and :math:`\sX{}` encodings,
   "trailing zeros" are still allowed within these bounds.
   For example, :math:`\hex{03}` and :math:`\hex{83}~\hex{00}` are both well-formed encodings for the value :math:`3` as a |u8|.
   Similarly, either of :math:`\hex{7e}` and :math:`\hex{FE}~\hex{7F}` and :math:`\hex{FE}~\hex{FF}~\hex{7F}` are well-formed encodings of the value :math:`-2` as a |s16|.

   The side conditions on the value :math:`n` of *terminating* bytes further enforce that
   any unused bits in these bytes must be :math:`0` for positive values and :math:`1` for negative ones.
   For example, :math:`\hex{83}~\hex{10}` is malformed as a |u8| encoding.
   Similarly, both :math:`\hex{83}~\hex{3E}` and :math:`\hex{FF}~\hex{7B}` are malformed as |s8| encodings.


.. _binary-float:
.. index:: floating-point number
   pair: binary format; floating-point number
   single: abstract syntax; floating-point number

Floating-Point
~~~~~~~~~~~~~~

:ref:`Floating point <syntax-float>` values are encoded directly by their IEEE bit pattern in `little endian <https://en.wikipedia.org/wiki/Endianness#Little-endian>`_ byte order:

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{floating-point number} & \BfX{N} &::=&
     b^\ast{:\,}\Bbyte^{N/8} &\Rightarrow& \F{reverse}(b^\ast) \\
   \end{array}

Here, :math:`\F{reverse}(b^\ast)` denotes the byte sequence :math:`b^\ast` in reversed order.


.. _binary-vec:
.. index:: vector
   pair: binary format; vector
   single: abstract syntax; vector

Vectors
~~~~~~~

:ref:`Vectors <syntax-vec>` are encoded with their length followed by the encoding of their element sequence.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{vector} & \Bvec(\B{B}) &::=&
     n{:}\Bu32~~(x{:}\B{B})^n &\Rightarrow& x^n \\
   \end{array}


.. _binary-name:
.. index:: name, byte
   pair: binary format; name
   single: abstract syntax; name

Names
~~~~~

:ref:`Names <syntax-name>` are encoded like a :ref:`vector <binary-vector>` of bytes containing the `UTF-8 <http://www.unicode.org/versions/latest/>`_ encoding of the name's code point sequence.

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{name} & \Bname &::=&
     n{:}\Bu32~~(\X{uc}{:}\Bcodepoint)^\ast &\Rightarrow& \X{uc}^\ast
       & (|\Bcodepoint^\ast| = n) \\
   \production{code point} & \Bcodepoint &::=&
     \X{uv}{:}\Bcodeval_N &\Rightarrow& \X{uv}
       & (\X{uv} \geq N \wedge (\X{uv} < \unicode{D800} \vee \unicode{E000} \leq \X{uv} < \unicode{110000})) \\
   \production{code value} & \Bcodeval_N &::=&
     b_1{:}\Bbyte &\Rightarrow&
       b_1
       & (b_1 < \hex{80} \wedge N = \unicode{00}) \\ &&|&
     b_1{:}\Bbyte~~b_2{:}\Bcodecont &\Rightarrow&
       2^6\cdot(b_1-\hex{c0}) + b_2
       & (\hex{c0} \leq b_1 < \hex{e0} \wedge N = \unicode{80}) \\ &&|&
     b_1{:}\Bbyte~~b_2{:}\Bcodecont~~b_3{:}\Bcodecont &\Rightarrow&
       2^{12}\cdot(b_1-\hex{e0}) + 2^6\cdot b_2 + b_3
       & (\hex{e0} \leq b_1 < \hex{f0} \wedge N = \unicode{800}) \\ &&|&
     b_1{:}\Bbyte~~b_2{:}\Bcodecont~~b_3{:}\Bcodecont~~b_4{:}\Bcodecont
       &\Rightarrow&
       2^{18}\cdot(b_1-\hex{f0}) + 2^{12}\cdot b_2 + 2^6\cdot b_3 + b_4
       & (\hex{f0} \leq b_1 < \hex{f8} \wedge N = \unicode{10000}) \\
   \production{code continuation} & \Bcodecont &::=&
     b{:}\Bbyte &\Rightarrow& b - \hex{80} & (b \geq \hex{80}) \\
   \end{array}

.. note::
   The :ref:`size <binary-notation>`, :math:`||\Bcodepoint^\ast||` denotes the number of bytes in the encoding of the sequence, not the number of code points.

   The index :math:`N` to |Bcodeval| is the minimum value that a given byte sequence may decode into.
   The respective side conditions on it exclude encodings using more than the minimal number of bytes to represent a code point.

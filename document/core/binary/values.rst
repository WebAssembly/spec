.. index:: value
   pair: binary format; value
.. _binary-value:

Values
------


.. index:: byte
   pair: binary format; byte
.. _binary-byte:

Bytes
~~~~~

:ref:`Bytes <syntax-byte>` encode themselves.

.. math::
   \begin{array}{llcll@{\qquad}l}
   \production{byte} & \Bbyte &::=&
     \hex{00} &\Rightarrow& \hex{00} \\ &&|&&
     \dots \\ &&|&
     \hex{FF} &\Rightarrow& \hex{FF} \\
   \end{array}


.. index:: integer, unsigned integer, signed integer, uninterpreted integer, LEB128, two's complement
   pair: binary format; integer
   pair: binary format; unsigned integer
   pair: binary format; signed integer
   pair: binary format; uninterpreted integer
.. _binary-sint:
.. _binary-uint:
.. _binary-int:

Integers
~~~~~~~~

All :ref:`integers <syntax-int>` are encoded using the |LEB128|_ variable-length integer encoding, in either unsigned or signed variant.

:ref:`Unsigned integers <syntax-uint>` are encoded in |UnsignedLEB128|_ format.
As an additional constraint, the total number of bytes encoding a value of type :math:`\uN` must not exceed :math:`\F{ceil}(N/7)` bytes.

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{unsigned integer} & \BuN &::=&
     n{:}\Bbyte &\Rightarrow& n & (\iff n < 2^7 \wedge n < 2^N) \\ &&|&
     n{:}\Bbyte~~m{:}\BuX{(N\B{-7})} &\Rightarrow&
       2^7\cdot m + (n-2^7) & (\iff n \geq 2^7 \wedge N > 7) \\
   \end{array}

:ref:`Signed integers <syntax-sint>` are encoded in |SignedLEB128|_ format, which uses a two's complement representation.
As an additional constraint, the total number of bytes encoding a value of type :math:`\sN` must not exceed :math:`\F{ceil}(N/7)` bytes.

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{signed integer} & \BsN &::=&
     n{:}\Bbyte &\Rightarrow& n & (\iff n < 2^6 \wedge n < 2^{N-1}) \\ &&|&
     n{:}\Bbyte &\Rightarrow& n-2^7 & (\iff 2^6 \leq n < 2^7 \wedge n \geq 2^7-2^{N-1}) \\ &&|&
     n{:}\Bbyte~~m{:}\BsX{(N\B{-7})} &\Rightarrow&
       2^7\cdot m + (n-2^7) & (\iff n \geq 2^7 \wedge N > 7) \\
   \end{array}

:ref:`Uninterpreted integers <syntax-int>` are encoded as signed integers.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{uninterpreted integer} & \BiN &::=&
     n{:}\BsN &\Rightarrow& i & (\iff n = \signed_N(i))
   \end{array}

.. note::
   The side conditions :math:`N > 7` in the productions for non-terminal bytes of the :math:`\uX{}` and :math:`\sX{}` encodings restrict the encoding's length.
   However, "trailing zeros" are still allowed within these bounds.
   For example, :math:`\hex{03}` and :math:`\hex{83}~\hex{00}` are both well-formed encodings for the value :math:`3` as a |u8|.
   Similarly, either of :math:`\hex{7e}` and :math:`\hex{FE}~\hex{7F}` and :math:`\hex{FE}~\hex{FF}~\hex{7F}` are well-formed encodings of the value :math:`-2` as a |s16|.

   The side conditions on the value :math:`n` of terminal bytes further enforce that
   any unused bits in these bytes must be :math:`0` for positive values and :math:`1` for negative ones.
   For example, :math:`\hex{83}~\hex{10}` is malformed as a |u8| encoding.
   Similarly, both :math:`\hex{83}~\hex{3E}` and :math:`\hex{FF}~\hex{7B}` are malformed as |s8| encodings.


.. index:: floating-point number, little endian
   pair: binary format; floating-point number
.. _binary-float:

Floating-Point
~~~~~~~~~~~~~~

:ref:`Floating-point <syntax-float>` values are encoded directly by their |IEEE754|_ (Section 3.4) bit pattern in |LittleEndian|_ byte order:

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{floating-point value} & \BfN &::=&
     b^\ast{:\,}\Bbyte^{N/8} &\Rightarrow& \bytes_{\fN}^{-1}(b^\ast) \\
   \end{array}


.. index:: name, byte, Unicode, ! UTF-8
   pair: binary format; name
.. _binary-utf8:
.. _binary-name:

Names
~~~~~

:ref:`Names <syntax-name>` are encoded as a :ref:`vector <binary-vec>` of bytes containing the |Unicode|_ (Section 3.9) UTF-8 encoding of the name's character sequence.

.. math::
   \begin{array}{llclllll}
   \production{name} & \Bname &::=&
     b^\ast{:}\Bvec(\Bbyte) &\Rightarrow& \name
       && (\iff \utf8(\name) = b^\ast) \\
   \end{array}

The auxiliary |utf8| function expressing this encoding is defined as follows:

.. math::
   \begin{array}{@{}l@{}}
   \begin{array}{@{}lcl@{\qquad}l@{}}
   \utf8(c^\ast) &=& (\utf8(c))^\ast \\[1ex]
   \utf8(c) &=& b &
     (\begin{array}[t]{@{}c@{~}l@{}}
      \iff & c < \unicode{80} \\
      \wedge & c = b) \\
      \end{array} \\
   \utf8(c) &=& b_1~b_2 &
     (\begin{array}[t]{@{}c@{~}l@{}}
      \iff & \unicode{80} \leq c < \unicode{800} \\
      \wedge & c = 2^6(b_1-\hex{C0})+(b_2-\hex{80})) \\
      \end{array} \\
   \utf8(c) &=& b_1~b_2~b_3 &
     (\begin{array}[t]{@{}c@{~}l@{}}
      \iff & \unicode{800} \leq c < \unicode{D800} \vee \unicode{E000} \leq c < \unicode{10000} \\
      \wedge & c = 2^{12}(b_1-\hex{E0})+2^6(b_2-\hex{80})+(b_3-\hex{80})) \\
      \end{array} \\
   \utf8(c) &=& b_1~b_2~b_3~b_4 &
     (\begin{array}[t]{@{}c@{~}l@{}}
      \iff & \unicode{10000} \leq c < \unicode{110000} \\
      \wedge & c = 2^{18}(b_1-\hex{F0})+2^{12}(b_2-\hex{80})+2^6(b_3-\hex{80})+(b_4-\hex{80})) \\
      \end{array} \\
   \end{array} \\
   \where b_2, b_3, b_4 < \hex{C0} \\
   \end{array}

.. note::
   Unlike in some other formats, name strings are not 0-terminated.

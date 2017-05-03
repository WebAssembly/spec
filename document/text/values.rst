.. _text-value:
.. index:: value
   pair: text format; value

Values
------

The grammar produtions in this section define *lexical syntax*,
hence no :ref:`white space <text-whitespace>` is allowed.


.. _text-sign:
.. _text-digit:
.. _text-hexdigit:
.. _text-int:
.. _text-sint:
.. _text-uint:
.. index:: integer, unsigned integer, signed integer, uninterpreted integer
   pair: text format; integer
   pair: text format; unsigned integer
   pair: text format; signed integer
   pair: text format; uninterpreted integer

Integers
~~~~~~~~

All :ref:`integers <syntax-int>` can be written in either decimal or hexadecimal notation.

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{sign} & \Tsign &::=&
     \epsilon \Rightarrow {+}1 ~|~
     \text{+} \Rightarrow {+}1 ~|~
     \text{-} \Rightarrow {-}1 \\
   \production{decimal digit} & \Tdigit &::=&
     \text{0} \Rightarrow 0 ~|~ \dots ~|~ \text{9} \Rightarrow 9 \\
   \production{hexadecimal digit} & \Thexdigit &::=&
     d{:}\Tdigit \Rightarrow d \\ &&|&
     \text{A} \Rightarrow 10 ~|~ \dots ~|~ \text{F} \Rightarrow 15 \\ &&|&
     \text{a} \Rightarrow 10 ~|~ \dots ~|~ \text{f} \Rightarrow 15 \\
   \production{decimal number} & \Tnum &::=&
     d{:}\Tdigit &\Rightarrow& d \\ &&|&
     n{:}\Tnum~~d{:}\Tdigit &\Rightarrow& 10\cdot n + d \\
   \production{hexadecimal number} & \Thexnum &::=&
     \text{0x}~~h{:}\Thexdigit &\Rightarrow& h \\ &&|&
     n{:}\Thexnum~~h{:}\Thexdigit &\Rightarrow& 16\cdot n + h \\
   \end{array}

Integer literals are distinguished by size and signedness.
Their value must lie within the range of the respective type.

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{unsigned integer} & \TuX{N} &::=&
     n{:}\Tnum &\Rightarrow& n & (n < 2^N) \\ &&|&
     n{:}\Thexnum &\Rightarrow& n & (n < 2^N) \\
   \production{signed integer} & \TsX{N} &::=&
     s{:}\Tsign~~n{:}\Tnum &\Rightarrow& s\cdot n & (-2^{N-1} \leq s\cdot n < 2^{N-1}) \\ &&|&
     s{:}\Tsign~~n{:}\Thexnum &\Rightarrow& s\cdot n & (-2^{N-1} \leq s\cdot n < 2^{N-1}) \\
   \end{array}

:ref:`Uninterpreted integers <syntax-int>` can be written as either signed or unsigned, and are normalized to unsigned in the abstract syntax.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{uninterpreted integers} & \TiX{N} &::=&
     n{:}\TuX{N} &\Rightarrow& n \\ &&|&
     i{:}\TsX{N} &\Rightarrow& n & (i = \signed(n)) \\
   \end{array}


.. _text-frac:
.. _text-hexfrac:
.. _text-float:
.. _text-hexfloat:
.. index:: floating-point number
   pair: text format; floating-point number

Floating-Point
~~~~~~~~~~~~~~

:ref:`Floating point <syntax-float>` values can be represented in either decimal or hexadecimal notation.
The value must not be outside the representable range of the corresponding `IEEE 754 <http://ieeexplore.ieee.org/document/4610935/>`_ type
(that is, it must not overflow to infinity),
but it may be rounded to the nearest representable value.

.. note::
   Rounding can be avoided by using hexadecimal notation with no more significant bits than supported by the desired type.

Floating-point values may also be written as constants for *infinity* or *canonical NaN* (*not a number*).
Furthermore, arbitrary NaN values may be expressed by providing an explicit payload value.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{decimal floating-point fraction} & \Tfrac &::=&
     \epsilon &\Rightarrow& 0 \\ &&|&
     d{:}\Tdigit~q{:}\Tfrac &\Rightarrow& (d+q)/10 \\
   \production{hexadecimal floating-point fraction} & \Thexfrac &::=&
     \epsilon &\Rightarrow& 0 \\ &&|&
     h{:}\Thexdigit~q{:}\Thexfrac &\Rightarrow& (h+q)/16 \\
   \production{decimal floating-point number} & \Tfloat &::=&
     s{:}\Tsign~p{:}\Tnum~\text{.}~q{:}\Tfrac
       &\Rightarrow& s\cdot(p+q) \\ &&|&
     s{:}\Tsign~p{:}\Tnum~(\text{E}~|~\text{e})~t{:}\Tsign~e{:}\Tnum
       &\Rightarrow& s\cdot p\cdot 10^{t\cdot e} \\ &&|&
     s{:}\Tsign~p{:}\Tnum~\text{.}~q{:}\Tfrac~(\text{E}~|~\text{e})~t{:}\Tsign~e{:}\Tnum
       &\Rightarrow& s\cdot(p+q)\cdot 10^{t\cdot e} \\
   \production{hexadecimal floating-point number} & \Thexfloat &::=&
     s{:}\Tsign~p{:}\Thexnum~\text{.}~q{:}\Thexfrac
       &\Rightarrow& s\cdot(p+q) \\ &&|&
     s{:}\Tsign~p{:}\Thexnum~(\text{P}~|~\text{p})~t{:}\Tsign~e{:}\Tnum
       &\Rightarrow& s\cdot p\cdot 2^{t\cdot e} \\ &&|&
     s{:}\Tsign~p{:}\Thexnum~\text{.}~q{:}\Thexfrac~(\text{P}~|~\text{p})~t{:}\Tsign~e{:}\Tnum
       &\Rightarrow& s\cdot(p+q)\cdot 2^{t\cdot e} \\
   \production{floating-point value} & \TfX{N} &::=&
     z{:}\Tfloat &\Rightarrow& b^\ast & (\ieee_N(z) = b^\ast) \\ &&|&
     z{:}\Thexfloat &\Rightarrow& b^\ast & (\ieee_N(z) = b^\ast) \\ &&|&
     s{:}\Tsign~\text{inf} &\Rightarrow& b^\ast & (\ieeeinf_N(s) = b^\ast) \\ &&|&
     s{:}\Tsign~\text{nan} &\Rightarrow& b^\ast & (\ieeenan_N(s, 0) = b^\ast) \\ &&|&
     s{:}\Tsign~\text{nan\!:}~n{:}\Thexnum &\Rightarrow& b^\ast & (\ieeenan_N(s, n) = b^\ast) \\
   \end{array}


.. _text-vec:
.. index:: vector
   pair: text format; vector

Vectors
~~~~~~~

:ref:`Vectors <syntax-vec>` are written as ordinary sequences, but with restricted length.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{vector} & \Tvec(\T{A}) &::=&
     (x{:}\T{A})^n &\Rightarrow& x^n & (n < 2^{32}) \\
   \end{array}


.. _text-byte:
.. _text-string:
.. index:: byte, string
   pair: text format; byte
   pair: text format; string

Strings
~~~~~~~

*Strings* are sequences of bytes that can represent both textual and binary data.
They are enclosed in `ASCII <http://webstore.ansi.org/RecordDetail.aspx?sku=INCITS+4-1986%5bR2012%5d>`_ *quotation marks* (bytes of value \hex{22})
and may contain any byte that is not an ASCII control character, ASCII *quotation marks* (\hex{22}), or ASCII *reverse slant* (backslash, \hex{5C}),
except when expressed with an *escape sequence* started by an ASCII *reverse slant* (\hex{5C}).

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{byte} & \Tbyte &::=&
     b &\Rightarrow& b & (\hex{20} \leq b < \hex{7F} \wedge b \neq \text{"} \wedge b \neq \text{\backslash}) \\ &&|&
     \text{\backslash}~n{:}\Thexdigit~m{:}\Thexdigit &\Rightarrow& 16\cdot n+m \\ &&|&
     \text{\backslash{}t} &\Rightarrow& \hex{09} \\ &&|&
     \text{\backslash{}n} &\Rightarrow& \hex{0A} \\ &&|&
     \text{\backslash{}r} &\Rightarrow& \hex{0D} \\ &&|&
     \text{\backslash{}"} &\Rightarrow& \hex{22} \\ &&|&
     \text{\backslash{}'} &\Rightarrow& \hex{27} \\ &&|&
     \text{\backslash\backslash} &\Rightarrow& \hex{5C} \\
   \production{string} & \Tstring &::=&
     \text{"}~(b{:}\Tbyte)^\ast~\text{"}
       &\Rightarrow& b^\ast \\
   \end{array}

.. note::
   The bytes in a string are not interpreted in any specific way,
   except when the string appears as a :ref:`name <text-name>`.


.. _text-name:
.. index:: name, byte
   pair: text format; name

Names
~~~~~

:ref:`Names <syntax-name>` are strings denoting a byte sequence that must form a valid `Unicode <http://www.unicode.org/versions/latest/>`_ UTF-8 encoding.

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{name} & \Tname &::=&
     b^\ast{:}\Tstring &\Rightarrow& \X{uc}^n
       & (\utf8(\X{uc}^n) = b^\ast \wedge n < 2^{32}) \\
   \end{array}

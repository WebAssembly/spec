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
     \epsilon \Rightarrow {+}1 ~~|~~
     \text{+} \Rightarrow {+}1 ~~|~~
     \text{-} \Rightarrow {-}1 \\
   \production{decimal digit} & \Tdigit &::=&
     \text{0} \Rightarrow 0 ~~|~~ \dots ~~|~~ \text{9} \Rightarrow 9 \\
   \production{hexadecimal digit} & \Thexdigit &::=&
     d{:}\Tdigit \Rightarrow d \\ &&|&
     \text{A} \Rightarrow 10 ~~|~~ \dots ~~|~~ \text{F} \Rightarrow 15 \\ &&|&
     \text{a} \Rightarrow 10 ~~|~~ \dots ~~|~~ \text{f} \Rightarrow 15 \\
   \end{array}

.. math::
   \begin{array}{llclll@{\qquad}l}
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
The value of a literal must not lie outside the representable range of the corresponding `IEEE 754 <http://ieeexplore.ieee.org/document/4610935/>`_ type
(that is, it must not overflow to :math:`\pm`infinity),
but it may be rounded to the nearest representable value.

.. note::
   Rounding can be prevented by using hexadecimal notation with no more significant bits than supported by the required type.

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

.. todo:: IEEE encoding


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

*Strings* denote sequences of characters that can represent both textual and binary data.
They are enclosed in quotation marks
and may contain any character other than `ASCII <http://webstore.ansi.org/RecordDetail.aspx?sku=INCITS+4-1986%5bR2012%5d>`_ control characters, quotation marks (:math:`\text{"}`), or backslash (:math:`\text{\verb|\|}`),
except when expressed with an *escape sequence* started by a backslash.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{string} & \Tstring &::=&
     \text{"}~(c{:}\Tstringchar)^\ast~\text{"}
       &\Rightarrow& c^\ast \\
   \production{string character} & \Tstringchar &::=&
     c{:}\Tchar &\Rightarrow& c \qquad
       & (c \geq \unicode{20} \wedge c \neq \unicode{7F} \wedge c \neq \text{"} c \neq \text{\verb|\|}) \\ &&|&
     \text{\verb|\t|} &\Rightarrow& \unicode{09} \\ &&|&
     \text{\verb|\n|} &\Rightarrow& \unicode{0A} \\ &&|&
     \text{\verb|\r|} &\Rightarrow& \unicode{0D} \\ &&|&
     \text{\verb|\"|} &\Rightarrow& \unicode{22} \\ &&|&
     \text{\verb|\'|} &\Rightarrow& \unicode{27} \\ &&|&
     \text{\verb|\\|} &\Rightarrow& \unicode{5C} \\ &&|&
     \text{\verb|\|}~n{:}\Thexdigit~m{:}\Thexdigit
       &\Rightarrow& \unicode{(16\cdot n+m)} \\ &&|&
     \text{\verb|\u|\{}~n{:}\Thexnum~\text{\}}
       &\Rightarrow& \unicode{(n)} & (n < \hex{110000}) \\
   \end{array}

.. commented out
     \text{~~} ~~\Rightarrow~~ \hex{20} ~~~|~~~
     \text{!} ~~\Rightarrow~~ \hex{21} \\ &&|&
     \text{\#} ~~\Rightarrow~~ \hex{23} ~~~|~~~
     \cdots ~~~|~~~
     \text{[} ~~\Rightarrow~~ \hex{5B} \\ &&|&
     \text{]} ~~\Rightarrow~~ \hex{5D} ~~~|~~~
     \cdots ~~~|~~~
     \text{\verb|~|} ~~\Rightarrow~~ \hex{7E} \\ &&|&

   Due to the limitations of the :ref:`binary format <binary-name>`, the length of strings is limited by the length of their `Unicode <http://www.unicode.org/versions/latest/>`_ UTF-8 encoding.

   The auxiliary |utf8| function is defined as follows:

   .. math::
   \begin{array}{lcl@{\qquad}l}
   \utf8(c^\ast) &=& (\utf8(c))^\ast \\[1ex]
   \utf8(c) &=& b & (c < \unicode{80} \wedge c = b) \\
   \utf8(c) &=& b_1~b_2 & (\unicode{80} \leq c < \unicode{800} \wedge c = 2^6\cdot(b_1-\hex{C0})+(b_2-\hex{80})) \\
   \utf8(c) &=& b_1~b_2~b_3 & (\unicode{800} \leq c < \unicode{10000} \wedge c = 2^{12}\cdot(b_1-\hex{C0})+2^6\cdot(b_2-\hex{80})+(b_3-\hex{80})) \\
   \utf8(c) &=& b_1~b_2~b_3~b_4 & (\unicode{10000} \leq c < \unicode{110000} \wedge c = 2^{18}\cdot(b_1-\hex{C0})+2^{12}\cdot(b_2-\hex{80})+2^6\cdot(b_3-\hex{80})+(b_4-\hex{80})) \\
   \end{array}


.. _text-bytes:
.. index:: bytes, byte
   pair: text format; bytes

Bytes
~~~~~

:ref:`Bytes <syntax-name>` are strings denoting a sequence of raw :ref:`bytes <syntax-bytes>`.
They may contain only code points that are within range for a byte.

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{bytes} & \Tbytes &::=&
     c^\ast{:}\Tstring &\Rightarrow& b^\ast
       & ((\unicode{(b)} = c \leq \unicode{FF})^\ast) \\
   \end{array}


.. _text-name:
.. index:: name, byte
   pair: text format; name

Names
~~~~~

:ref:`Names <syntax-name>` are strings denoting a literal character sequence. 

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{name} & \Tname &::=&
     c^\ast{:}\Tstring &\Rightarrow& c^\ast \\
   \end{array}


.. _text-id:
.. index:: ! identifiers
   pair: text format; identifiers

Identifiers
~~~~~~~~~~~

:ref:`Indices <syntax-index>` can be given in both numeric and symbolic form.
Symbolic *identifiers* standing for indices start with :math:`\text{$}`, followed by any sequence of printable `ASCII <http://webstore.ansi.org/RecordDetail.aspx?sku=INCITS+4-1986%5bR2012%5d>`_ characters that does not contain a space, quotation mark, comma, semicolon, or bracket (parentheses, square brackets, or braces).

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{identifier} & \Tid &::=&
     \text{$}~(c{:}\Tidchar)^+ \\
   \production{identifier character} & \Tidchar &::=&
     \text{0} ~~|~~ \dots ~~|~~ \text{9} \\ &&|&
     \text{A} ~~|~~ \dots ~~|~~ \text{Z} \\ &&|&
     \text{a} ~~|~~ \dots ~~|~~ \text{z} \\ &&|&
     \text{!} ~~|~~
     \text{\#} ~~|~~
     \text{\$} ~~|~~
     \text{\%} ~~|~~
     \text{\&} ~~|~~
     \text{\verb|'|} ~~|~~
     \text{*} ~~|~~
     \text{+} ~~|~~
     \text{-} ~~|~~
     \text{.} ~~|~~
     \text{/} \\ &&|&
     \text{:} ~~|~~
     \text{<} ~~|~~
     \text{=} ~~|~~
     \text{>} ~~|~~
     \text{?} ~~|~~
     \text{@} ~~|~~
     \text{\verb|\|} ~~|~~
     \text{\verb|^|} ~~|~~
     \text{\verb|_|} ~~|~~
     \text{\verb|`|} ~~|~~
     \text{|} ~~|~~
     \text{\verb|~|} \\
   \end{array}

.. math (commented out)
     b \Rightarrow b
       && (\hex{21} \leq b \leq \hex{7E} \wedge
           b \notin \{\text{,}, \text{;}, \text{(}, \text{)}, \text{[}, \text{]}, \text{\{}, \text{\}}\}) \\

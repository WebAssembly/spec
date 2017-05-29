.. _text-value:
.. index:: value
   pair: text format; value

Values
------

The grammar productions in this section define *lexical syntax*,
hence no :ref:`white space <text-space>` is allowed.


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
     h{:}\Thexdigit &\Rightarrow& h \\ &&|&
     n{:}\Thexnum~~h{:}\Thexdigit &\Rightarrow& 16\cdot n + h \\
   \end{array}

The allowed syntax for integer literals depends on size and signedness.
Moreover, their value must lie within the range of the respective type.

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{unsigned integer} & \TuN &::=&
     n{:}\Tnum &\Rightarrow& n & (n < 2^N) \\ &&|&
     \text{0x}~~n{:}\Thexnum &\Rightarrow& n & (n < 2^N) \\
   \production{signed integer} & \TsN &::=&
     s{:}\Tsign~~n{:}\Tnum &\Rightarrow& s\cdot n & (-2^{N-1} \leq s\cdot n < 2^{N-1}) \\ &&|&
     s{:}\Tsign~~\text{0x}~~n{:}\Thexnum &\Rightarrow& s\cdot n & (-2^{N-1} \leq s\cdot n < 2^{N-1}) \\
   \end{array}

:ref:`Uninterpreted integers <syntax-int>` can be written as either signed or unsigned, and are normalized to unsigned in the abstract syntax.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{uninterpreted integers} & \TiN &::=&
     n{:}\TuN &\Rightarrow& n \\ &&|&
     i{:}\TsN &\Rightarrow& n & (i = \signed(n)) \\
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
(that is, a numeric value must not overflow to :math:`\pm\mbox{infinity}`),
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
     s{:}\Tsign~\text{0x}~p{:}\Thexnum~\text{.}~q{:}\Thexfrac
       &\Rightarrow& s\cdot(p+q) \\ &&|&
     s{:}\Tsign~\text{0x}~p{:}\Thexnum~(\text{P}~|~\text{p})~t{:}\Tsign~e{:}\Tnum
       &\Rightarrow& s\cdot p\cdot 2^{t\cdot e} \\ &&|&
     s{:}\Tsign~\text{0x}~p{:}\Thexnum~\text{.}~q{:}\Thexfrac~(\text{P}~|~\text{p})~t{:}\Tsign~e{:}\Tnum
       &\Rightarrow& s\cdot(p+q)\cdot 2^{t\cdot e} \\
   \production{floating-point value} & \TfN &::=&
     z{:}\Tfloat &\Rightarrow& b^\ast & (\ieee_N(z) = b^\ast) \\ &&|&
     z{:}\Thexfloat &\Rightarrow& b^\ast & (\ieee_N(z) = b^\ast) \\ &&|&
     s{:}\Tsign~\text{inf} &\Rightarrow& b^\ast & (\ieeeinf_N(s) = b^\ast) \\ &&|&
     s{:}\Tsign~\text{nan} &\Rightarrow& b^\ast & (\ieeenan_N(s, 0) = b^\ast) \\ &&|&
     s{:}\Tsign~\text{nan{:}}~\text{0x}~n{:}\Thexnum &\Rightarrow& b^\ast & (\ieeenan_N(s, n) = b^\ast) \\
   \end{array}

.. todo:: IEEE encoding


.. _text-vec:
.. index:: vector
   pair: text format; vector

Vectors
~~~~~~~

:ref:`Vectors <syntax-vec>` are written as plain sequences, but with restricted length.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{vector} & \Tvec(\T{A}) &::=&
     (x{:}\T{A})^n &\Rightarrow& x^n & (n < 2^{32}) \\
   \end{array}


.. _text-byte:
.. _text-string:
.. index:: ! string, byte, character, ASCII, Unicode, UTF-8
   pair: text format; byte
   pair: text format; string

Strings
~~~~~~~

*Strings* denote sequences of bytes that can represent both textual and binary data.
They are enclosed in quotation marks
and may contain any character other than `ASCII <http://webstore.ansi.org/RecordDetail.aspx?sku=INCITS+4-1986%5bR2012%5d>`_ control characters, quotation marks (:math:`\text{"}`), or backslash (:math:`\text{\verb|\|}`),
except when expressed with an *escape sequence*.

Each character in a string literal represents the byte sequence corresponding to its `Unicode <http://www.unicode.org/versions/latest/>`_ UTF-8 encoding,
except for hexadecimal escape sequences :math:`\text{\verb|\|}hh`, which represent raw bytes of the respective value.

.. todo - find replacement for the use of \verb, which isn't actually allowed in math mode, nor can be put into an \mbox

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{string} & \Tstring &::=&
     \text{"}~(b^\ast{:}\Tstringelem)^\ast~\text{"}
       &\Rightarrow& \concat((b^\ast)^\ast)
       & (|\concat((b^\ast)^\ast)| < 2^{32}) \\
   \production{string element} & \Tstringelem &::=&
     c{:}\Tstringchar &\Rightarrow& \utf8(c) \\ &&|&
     \text{\verb|\|}~n{:}\Thexdigit~m{:}\Thexdigit
       &\Rightarrow& 16\cdot n+m \\
   \production{string character} & \Tstringchar &::=&
     c{:}\Tchar &\Rightarrow& c \qquad
       & (c \geq \unicode{20} \wedge c \neq \unicode{7F} \wedge c \neq \text{"} c \neq \text{\verb|\|}) \\ &&|&
     \text{\verb|\t|} &\Rightarrow& \unicode{09} \\ &&|&
     \text{\verb|\n|} &\Rightarrow& \unicode{0A} \\ &&|&
     \text{\verb|\r|} &\Rightarrow& \unicode{0D} \\ &&|&
     \text{\verb|\"|} &\Rightarrow& \unicode{22} \\ &&|&
     \text{\verb|\'|} &\Rightarrow& \unicode{27} \\ &&|&
     \text{\verb|\\|} &\Rightarrow& \unicode{5C} \\ &&|&
     \text{\verb|\u|\{}~n{:}\Thexnum~\text{\}}
       &\Rightarrow& \unicode{(n)} & (n < \hex{D800} \vee \hex{E000} \leq n < \hex{110000}) \\
   \end{array}


.. _text-name:
.. index:: name, byte, character, code point
   pair: text format; name

Names
~~~~~

:ref:`Names <syntax-name>` are strings denoting a literal character sequence. 
A name string must form a valid `UTF-8 <http://www.unicode.org/versions/latest/>`_ encoding that is interpreted as a string of Unicode code points.

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{name} & \Tname &::=&
     b^\ast{:}\Tstring &\Rightarrow& c^\ast & (b^\ast = \utf8(c^\ast)) \\
   \end{array}

.. note::
   Presuming the source text is itself encoded correctly,
   strings that do not contain any uses of hexadecimal byte escapes are always valid names.


.. _text-id:
.. index:: ! identifiers
   pair: text format; identifiers

Identifiers
~~~~~~~~~~~

:ref:`Indices <syntax-index>` can be given in both numeric and symbolic form.
Symbolic *identifiers* that stand in lieu of indices start with :math:`\text{$}`, followed by any sequence of printable `ASCII <http://webstore.ansi.org/RecordDetail.aspx?sku=INCITS+4-1986%5bR2012%5d>`_ characters that does not contain a space, quotation mark, comma, semicolon, or bracket.

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{identifier} & \Tid &::=&
     \text{$}~\Tidchar^+ \\
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


.. _text-id-fresh:

Conventions
...........

The expansion rules of some abbreviations require insertion of a *fresh* identifier.
That may be any syntactically valid identifier that does not already occur in the given source text.

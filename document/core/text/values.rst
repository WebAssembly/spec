.. index:: value
   pair: text format; value
.. _text-value:

Values
------

The grammar productions in this section define *lexical syntax*,
hence no :ref:`white space <text-space>` is allowed.


.. index:: integer, unsigned integer, signed integer, uninterpreted integer
   pair: text format; integer
   pair: text format; unsigned integer
   pair: text format; signed integer
   pair: text format; uninterpreted integer
.. _text-sign:
.. _text-digit:
.. _text-hexdigit:
.. _text-num:
.. _text-hexnum:
.. _text-sint:
.. _text-uint:
.. _text-int:

Integers
~~~~~~~~

All :ref:`integers <syntax-int>` can be written in either decimal or hexadecimal notation.
In both cases, digits can optionally be separated by underscores.

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{sign} & \Tsign &::=&
     \epsilon \Rightarrow {+} ~~|~~
     \text{+} \Rightarrow {+} ~~|~~
     \text{-} \Rightarrow {-} \\
   \production{decimal digit} & \Tdigit &::=&
     \text{0} \Rightarrow 0 ~~|~~ \dots ~~|~~ \text{9} \Rightarrow 9 \\
   \production{hexadecimal digit} & \Thexdigit &::=&
     d{:}\Tdigit \Rightarrow d \\ &&|&
     \text{A} \Rightarrow 10 ~~|~~ \dots ~~|~~ \text{F} \Rightarrow 15 \\ &&|&
     \text{a} \Rightarrow 10 ~~|~~ \dots ~~|~~ \text{f} \Rightarrow 15
   \\[1ex]
   \production{decimal number} & \Tnum &::=&
     d{:}\Tdigit &\Rightarrow& d \\ &&|&
     n{:}\Tnum~~\text{\_}^?~~d{:}\Tdigit &\Rightarrow& 10\cdot n + d \\
   \production{hexadecimal number} & \Thexnum &::=&
     h{:}\Thexdigit &\Rightarrow& h \\ &&|&
     n{:}\Thexnum~~\text{\_}^?~~h{:}\Thexdigit &\Rightarrow& 16\cdot n + h \\
   \end{array}

The allowed syntax for integer literals depends on size and signedness.
Moreover, their value must lie within the range of the respective type.

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{unsigned integer} & \TuN &::=&
     n{:}\Tnum &\Rightarrow& n & (\iff n < 2^N) \\ &&|&
     \text{0x}~~n{:}\Thexnum &\Rightarrow& n & (\iff n < 2^N) \\
   \production{signed integer} & \TsN &::=&
     {\pm}{:}\Tsign~~n{:}\Tnum &\Rightarrow& \pm n & (\iff -2^{N-1} \leq \pm n < 2^{N-1}) \\ &&|&
     {\pm}{:}\Tsign~~\text{0x}~~n{:}\Thexnum &\Rightarrow& \pm n & (\iff -2^{N-1} \leq \pm n < 2^{N-1}) \\
   \end{array}

:ref:`Uninterpreted integers <syntax-int>` can be written as either signed or unsigned, and are normalized to unsigned in the abstract syntax.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{uninterpreted integers} & \TiN &::=&
     n{:}\TuN &\Rightarrow& n \\ &&|&
     i{:}\TsN &\Rightarrow& n & (\iff i = \signed(n)) \\
   \end{array}


.. index:: floating-point number
   pair: text format; floating-point number
.. _text-frac:
.. _text-hexfrac:
.. _text-hexfloat:
.. _text-float:

Floating-Point
~~~~~~~~~~~~~~

:ref:`Floating-point <syntax-float>` values can be represented in either decimal or hexadecimal notation.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{decimal floating-point fraction} & \Tfrac &::=&
     d{:}\Tdigit &\Rightarrow& d/10 \\ &&|&
     d{:}\Tdigit~~\text{\_}^?~~p{:}\Tfrac &\Rightarrow& (d+p/10)/10 \\
   \production{hexadecimal floating-point fraction} & \Thexfrac &::=&
     h{:}\Thexdigit &\Rightarrow& h/16 \\ &&|&
     h{:}\Thexdigit~~\text{\_}^?~~p{:}\Thexfrac &\Rightarrow& (h+p/16)/16 \\
   \production{decimal floating-point number} & \Tfloat &::=&
     p{:}\Tnum~\text{.}^?
       &\Rightarrow& p \\ &&|&
     p{:}\Tnum~\text{.}~q{:}\Tfrac
       &\Rightarrow& p+q \\ &&|&
     p{:}\Tnum~\text{.}^?~(\text{E}~|~\text{e})~{\pm}{:}\Tsign~e{:}\Tnum
       &\Rightarrow& p\cdot 10^{\pm e} \\ &&|&
     p{:}\Tnum~\text{.}~q{:}\Tfrac~(\text{E}~|~\text{e})~{\pm}{:}\Tsign~e{:}\Tnum
       &\Rightarrow& (p+q)\cdot 10^{\pm e} \\
   \production{hexadecimal floating-point number} & \Thexfloat &::=&
     \text{0x}~p{:}\Thexnum~\text{.}^?
       &\Rightarrow& p \\ &&|&
     \text{0x}~p{:}\Thexnum~\text{.}~q{:}\Thexfrac
       &\Rightarrow& p+q \\ &&|&
     \text{0x}~p{:}\Thexnum~\text{.}^?~(\text{P}~|~\text{p})~{\pm}{:}\Tsign~e{:}\Tnum
       &\Rightarrow& p\cdot 2^{\pm e} \\ &&|&
     \text{0x}~p{:}\Thexnum~\text{.}~q{:}\Thexfrac~(\text{P}~|~\text{p})~{\pm}{:}\Tsign~e{:}\Tnum
       &\Rightarrow& (p+q)\cdot 2^{\pm e}
   \end{array}

The value of a literal must not lie outside the representable range of the corresponding |IEEE754|_ type
(that is, a numeric value must not overflow to :math:`\pm\mbox{infinity}`),
but it may be :ref:`rounded <aux-ieee>` to the nearest representable value.

.. note::
   Rounding can be prevented by using hexadecimal notation with no more significant bits than supported by the required type.

Floating-point values may also be written as constants for *infinity* or *canonical NaN* (*not a number*).
Furthermore, arbitrary NaN values may be expressed by providing an explicit payload value.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{floating-point value} & \TfN &::=&
     {\pm}{:}\Tsign~z{:}\TfNmag &\Rightarrow& \pm z \\
   \production{floating-point magnitude} & \TfNmag &::=&
     z{:}\Tfloat &\Rightarrow& \ieee_N(z) & (\iff \ieee_N(z) \neq \pm \infty) \\ &&|&
     z{:}\Thexfloat &\Rightarrow& \ieee_N(z) & (\iff \ieee_N(z) \neq \pm \infty) \\ &&|&
     \text{inf} &\Rightarrow& \infty \\ &&|&
     \text{nan} &\Rightarrow& \NAN(\canon_N) \\ &&|&
     \text{nan{:}0x}~n{:}\Thexnum &\Rightarrow& \NAN(n) & (\iff 1 \leq n < 2^{\signif(N)}) \\
   \end{array}


.. index:: ! string, byte, character, ASCII, Unicode, UTF-8
   pair: text format; byte
   pair: text format; string
.. _text-byte:
.. _text-string:

Strings
~~~~~~~

*Strings* denote sequences of bytes that can represent both textual and binary data.
They are enclosed in quotation marks
and may contain any character other than |ASCII|_ control characters, quotation marks (:math:`\text{"}`), or backslash (:math:`\text{\backslash}`),
except when expressed with an *escape sequence*.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{string} & \Tstring &::=&
     \text{"}~(b^\ast{:}\Tstringelem)^\ast~\text{"}
       &\Rightarrow& \concat((b^\ast)^\ast)
       & (\iff |\concat((b^\ast)^\ast)| < 2^{32}) \\
   \production{string element} & \Tstringelem &::=&
     c{:}\Tstringchar &\Rightarrow& \utf8(c) \\ &&|&
     \text{\backslash}~n{:}\Thexdigit~m{:}\Thexdigit
       &\Rightarrow& 16\cdot n+m \\
   \end{array}

Each character in a string literal represents the byte sequence corresponding to its UTF-8 |Unicode|_ (Section 2.5) encoding,
except for hexadecimal escape sequences :math:`\textl\backslash hh\textr`, which represent raw bytes of the respective value.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{string character} & \Tstringchar &::=&
     c{:}\Tchar &\Rightarrow& c \qquad
       & (\iff c \geq \unicode{20} \wedge c \neq \unicode{7F} \wedge c \neq \text{"} \wedge c \neq \text{\backslash}) \\ &&|&
     \text{\backslash t} &\Rightarrow& \unicode{09} \\ &&|&
     \text{\backslash n} &\Rightarrow& \unicode{0A} \\ &&|&
     \text{\backslash r} &\Rightarrow& \unicode{0D} \\ &&|&
     \text{\backslash{"}} &\Rightarrow& \unicode{22} \\ &&|&
     \text{\backslash{'}} &\Rightarrow& \unicode{27} \\ &&|&
     \text{\backslash\backslash} &\Rightarrow& \unicode{5C} \\ &&|&
     \text{\backslash u\{}~n{:}\Thexnum~\text{\}}
       &\Rightarrow& \unicode{(n)} & (\iff n < \hex{D800} \vee \hex{E000} \leq n < \hex{110000}) \\
   \end{array}


.. index:: name, byte, character, character
   pair: text format; name
.. _text-name:

Names
~~~~~

:ref:`Names <syntax-name>` are strings denoting a literal character sequence. 
A name string must form a valid UTF-8 encoding as defined by |Unicode|_ (Section 2.5) and is interpreted as a string of Unicode scalar values.

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{name} & \Tname &::=&
     b^\ast{:}\Tstring &\Rightarrow& c^\ast & (\iff b^\ast = \utf8(c^\ast)) \\
   \end{array}

.. note::
   Presuming the source text is itself encoded correctly,
   strings that do not contain any uses of hexadecimal byte escapes are always valid names.


.. index:: ! identifiers
   pair: text format; identifiers
.. _text-idchar:
.. _text-id:

Identifiers
~~~~~~~~~~~

:ref:`Indices <syntax-index>` can be given in both numeric and symbolic form.
Symbolic *identifiers* that stand in lieu of indices start with :math:`\text{\$}`, followed by any sequence of printable |ASCII|_ characters that does not contain a space, quotation mark, comma, semicolon, or bracket.

.. math::
   \begin{array}{llclll@{\qquad}l}
   \production{identifier} & \Tid &::=&
     \text{\$}~\Tidchar^+ \\
   \production{identifier character} & \Tidchar &::=&
     \text{0} ~~|~~ \dots ~~|~~ \text{9} \\ &&|&
     \text{A} ~~|~~ \dots ~~|~~ \text{Z} \\ &&|&
     \text{a} ~~|~~ \dots ~~|~~ \text{z} \\ &&|&
     \text{!} ~~|~~
     \text{\#} ~~|~~
     \text{\$} ~~|~~
     \text{\%} ~~|~~
     \text{\&} ~~|~~
     \text{'} ~~|~~
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
     \text{\backslash} ~~|~~
     \text{\hat{~~}} ~~|~~
     \text{\_} ~~|~~
     \text{\grave{~~}} ~~|~~
     \text{|} ~~|~~
     \text{\tilde{~~}} \\
   \end{array}

.. _text-id-fresh:

Conventions
...........

The expansion rules of some abbreviations require insertion of a *fresh* identifier.
That may be any syntactically valid identifier that does not already occur in the given source text.

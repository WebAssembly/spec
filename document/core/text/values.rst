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

$${grammar: Tsign {Tdigit Thexdigit} {Tnum Thexnum}}

The allowed syntax for integer literals depends on size and signedness.
Moreover, their value must lie within the range of the respective type.

$${grammar: {TuN TsN}}

:ref:`Uninterpreted integers <syntax-int>` can be written as either signed or unsigned, and are normalized to unsigned in the abstract syntax.

$${grammar: TiN}


.. index:: floating-point number, mantissa
   pair: text format; floating-point number
.. _text-frac:
.. _text-hexfrac:
.. _text-mant:
.. _text-hexmant:
.. _text-float:
.. _text-hexfloat:

Floating-Point
~~~~~~~~~~~~~~

:ref:`Floating-point <syntax-float>` values can be represented in either decimal or hexadecimal notation.

$${grammar: {Tfrac Thexfrac} {Tmant Thexmant} {Tfloat Thexfloat}}

The value of a literal must not lie outside the representable range of the corresponding |IEEE754|_ type
(that is, a numeric value must not overflow to ${:+-infinity}),
but it may be :ref:`rounded <aux-ieee>` to the nearest representable value.

.. note::
   Rounding can be prevented by using hexadecimal notation with no more significant bits than supported by the required type.

Floating-point values may also be written as constants for *infinity* or *canonical NaN* (*not a number*).
Furthermore, arbitrary NaN values may be expressed by providing an explicit payload value.

$${grammar: {TfN TfNmag}}


.. index:: ! string, byte, character, ASCII, Unicode, UTF-8
   pair: text format; byte
   pair: text format; string
.. _text-byte:
.. _text-string:

Strings
~~~~~~~

*Strings* denote sequences of bytes that can represent both textual and binary data.
They are enclosed in quotation marks
and may contain any character other than |ASCII|_ control characters, quotation marks (${:"\""}), or backslash (${:"\\"}),
except when expressed with an *escape sequence*.

$${grammar: Tstring Tstringelem}

Each character in a string literal represents the byte sequence corresponding to its UTF-8 |Unicode|_ (Section 2.5) encoding,
except for hexadecimal escape sequences ${:"\\hh"}, which represent raw bytes of the respective value.

$${grammar: Tstringchar}


.. index:: name, byte, character, character
   pair: text format; name
.. _text-name:

Names
~~~~~

:ref:`Names <syntax-name>` are strings denoting a literal character sequence. 
A name string must form a valid UTF-8 encoding as defined by |Unicode|_ (Section 2.5) and is interpreted as a string of Unicode scalar values.

$${grammar: Tname}

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
Symbolic *identifiers* that stand in lieu of indices start with ${:"$"}, followed by either a sequence of printable |ASCII|_ characters that does not contain a space, quotation mark, comma, semicolon, or bracket, or by a quoted :ref:`name <text-name>`.

$${grammar: {Tid Tidchar}}

.. note::
   The value of an identifier character is the Unicode codepoint denoting it.

.. _text-id-fresh:

Conventions
...........

The expansion rules of some abbreviations require insertion of a *fresh* identifier.
That may be any syntactically valid identifier that does not already occur in the given source text.

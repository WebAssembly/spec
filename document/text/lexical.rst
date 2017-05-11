.. index:: lexical format

Lexical Format
--------------


.. _text-char:
.. index:: ! character, Unicode, ASCII, code point, ! source text
   pair: text format; character

Characters
~~~~~~~~~~

The text format assigns meaning to *source text*, which consists of a sequence of *characters*.
Characters are assumed to be represented as valid `Unicode <http://www.unicode.org/versions/latest/>`_ *code points*.

.. math::
   \begin{array}{llll}
   \production{character} & \Tchar &::=&
     \unicode{00} ~|~ \dots ~|~ \unicode{D800} ~|~ \unicode{E000} ~|~ \dots ~|~ \unicode{10FFFF} \\
   \end{array}

.. note::
   The set of characters interpreted in the text format is a subset of the characters supported by `7-bit ASCII <http://webstore.ansi.org/RecordDetail.aspx?sku=INCITS+4-1986%5bR2012%5d>`_,
   but a source text may contain other characters in :ref:`comments <text-comment>` or :ref:`string <text-string>` literals.


.. _text-stoken:
.. index:: ! token, character, white space, comment, source text
   single: text format; token

Tokens
~~~~~~

The character stream in the source text is divided, from left to right, into a sequence of *tokens*.
In this specification, tokens are either defined explicitly by lexical grammar rules,
such as the lexical syntax of :ref:`values <text-value>`,
or implicitly, by the occurrence of terminal symbols in literal form in the non-lexical grammar. 

Tokens are formed from the input character stream according to the *longest match* rule.
That is, the next token always consists of the longest possible sequence of characters that is recognized as a token.

Tokens may explicitly be separated by space, formatting characters or :ref:`comments <text-comment>`,
collectively called :ref:`white space <text-space>`.
Except for :ref:`string <text-string>` literals, white space cannot appear inside a token.


.. _text-space:
.. index:: ! white space, character, ASCII
   single: text format; white space

White Space
~~~~~~~~~~~

*White space* is any sequence of literal space characters, formatting characters, or :ref:`comments <text-comment>`.
The allowed formatting characters correspond to a subset of the `ASCII <http://webstore.ansi.org/RecordDetail.aspx?sku=INCITS+4-1986%5bR2012%5d>`_ *format effectors*, namely, *horizontal tabulation* (:math:`\unicode{09}`), *line feed* (:math:`\unicode{0A}`), and *carriage return* (:math:`\unicode{0D}`).

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{white space} & \Tspace &::=&
     (\text{~~} ~|~ \Tformat ~|~ \Tcomment)^\ast \\
   \production{format} & \Tformat &::=&
     \unicode{09} ~|~ \unicode{0A} ~|~ \unicode{0D} \\
   \end{array}


.. text-comment:
.. index:: ! comment, character
   single: text format; comment

Comments
~~~~~~~~

A *comment* can either be a *line comment*, started with a double semicolon :math:`\text{\verb|;;|}` and extending to the end of the line,
or a *block comment*, enclosed in delimiters :math:`\text{\verb|(;|} \dots \text{\verb|;)|}`.
Block comments can be nested.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{comment} & \Tcomment &::=&
     \Tlinecomment ~|~ \Tblockcomment \\
   \production{line comment} & \Tlinecomment &::=&
     \text{\verb|;;|}~~\Tlinechar^\ast~~(\unicode{0A} ~|~ \T{eof}) \\
   \production{line character} & \Tlinechar &::=&
     c{:}\Tchar & (c \neq \unicode{0A}) \\
   \production{block comment} & \Tblockcomment &::=&
     \text{\verb|(;|}~~\Tblockchar^\ast~~\text{\verb|;)|} \\
   \production{block character} & \Tblockchar &::=&
     c{:}\Tchar & (c \neq \text{;} \wedge c \neq \text{(}) \\ &&|&
     \text{;} & (\mbox{the next character is not}~\text{)}) \\ &&|&
     \text{(} & (\mbox{the next character is not}~\text{;}) \\ &&|&
     \Tblockcomment \\
   \end{array}

Here, the pseudo token :math:`\T{eof}` indicates the end of the input.
The *look-ahead* restrictions on the productions for |Tblockchar| disambiguate the grammar such that only well-bracketed uses of block comment delimiters are allowed.

.. note::
   Any formatting and control characters are allowed inside comments.

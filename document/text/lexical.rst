.. index:: lexical format

Lexical Format
--------------


.. _text-char:
.. index:: ! character
   pair: text format; character

Characters
~~~~~~~~~~

The text format assigns meaning to *source text*, which consists of a sequence of *characters*.
The set of significant characters interpreted in the text format is a subset of the characters supported by `7-bit ASCII <http://webstore.ansi.org/RecordDetail.aspx?sku=INCITS+4-1986%5bR2012%5d>`_,
but a source text may contain additional characters,
such as other `Unicode <http://www.unicode.org/versions/latest/>`_ *code points*.

.. math::
   \begin{array}{llll}
   \production{character} & \Tchar &::=&
     \dots (\mbox{any character}) \\
   \end{array}

.. note::
   Non-ASCII characters or ASCII control characters other than format characters can only occur in :ref:`comments <text-comments>`,
   where they have no effect on the meaning of the source text.


.. _text-stoken:
.. index:: ! token
   single: text format; token

Tokens
~~~~~~

The character stream in the source text is divided, from left to right, into a sequence of *tokens*.
In this specification, tokens are either defined explicitly by lexical grammar rules,
such as the lexical syntax of :ref:`values <text-value>`,
or implicitly, by the occurrence of terminal symbols in literal form in the non-lexical grammar. 

Tokens are formed from the input character stream according to the *longest match* rule.
That is, the next token always consists of the longest possible sequence of characters that is recognized as a token.

Tokens may explicitly be separated by space and formatting characters or :ref:`comments <text-comment>`,
collectively called :ref:`white space <text-space>`.
Except for :ref:`string <text-string>` literals, white space cannot appear inside a token.


.. _text-space:
.. index:: ! white space

White Space
~~~~~~~~~~~

*White space* is any sequence of literal space characters, formatting characters, or :ref:`comments <text-comment>`.

A format character corresponds to an `ASCII <http://webstore.ansi.org/RecordDetail.aspx?sku=INCITS+4-1986%5bR2012%5d>`_ *format effector*, that is, *backspace* (ASCII :math:`\hex{08}`), *horizontal tabulation* (:math:`\hex{09}`), *line feed* (:math:`\hex{0A}`), *vertical tabulation* (:math:`\hex{0B}`), *form feed* (:math:`\hex{0C}`), or *carriage return* (:math:`\hex{0D}`).

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{white space} & \Tspace &::=&
     (\text{~~} ~|~ \Tformat ~|~ \Tcomment)^\ast \\
   \production{format} & \Tformat &::=&
     \hex{08} ~|~ \hex{09} ~|~ \hex{0A} ~|~ \hex{0B} ~|~ \hex{0C} ~|~ \hex{0D} \\
   \end{array}

Here, its binary code in ASCII is used to denote the respective control character.


.. text-comment:
.. index:: ! comments

Comments
~~~~~~~~

A *comment* can either be a *line comment*, started with a double semicolon :math:`\text{;\!;}` and extending to the end of the line,
or a *block comment*, enclosed in delimiters :math:`\text{\verb|(;|} \dots \text{\verb|;)|}`.
Block comments can be nested.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{comment} & \Tcomment &::=&
     \Tlinecomment ~|~ \Tblockcomment \\
   \production{line comment} & \Tlinecomment &::=&
     \text{\verb|;;|}~~\Tlinechar^\ast~~(\hex{0A} ~|~ \T{eof}) \\
   \production{line character} & \Tlinechar &::=&
     c{:}\Tchar & (c \neq \hex{0A}) \\
   \production{block comment} & \Tblockcomment &::=&
     \text{\verb|(;|}~~\Tblockchar^\ast~~\text{\verb|;)|} \\
   \production{block character} & \Tblockchar &::=&
     c{:}\Tchar & (c \neq \text{;} \wedge c \neq \text{(}) \\ &&|&
     \text{;} & (\mbox{the next character is not}~\text{)}) \\ &&|&
     \text{(} & (\mbox{the next character is not}~\text{;}) \\ &&|&
     \Tblockcomment \\
   \end{array}

Here, the binary ASCII code :math:`\text{0A}` is used to denote the end-of-line character and the pseudo token :math:`\T{eof}` indicates the end of the input.
The *look-ahead* restrictions on |Tblockchar| disambiguate the grammar such that only well-bracketted uses of block comment delimiters are allowed.

.. index:: lexical format

Lexical Format
--------------

The text format is assumed to be represented in a superset of `7-bit ASCII <http://webstore.ansi.org/RecordDetail.aspx?sku=INCITS+4-1986%5bR2012%5d>`_.
Only printable 7-bit ASCII characters are interpreted in this format,
hence any compatible character encoding, such as `Unicode UTF-8 <http://www.unicode.org/versions/latest/>`_ is applicable.


.. _text-stoken:
.. index:: ! token

Tokens
~~~~~~

The character stream in the source text is divided into a sequence of *tokens*.
In this specification, tokens are either defined explicitly by grammar rules,
such as the lexical syntax of :ref:`values <text-value>`,
or implicitly, by the occurrence of terminal symbols in string form in the non-lexical grammar. 

Tokens are consumed from the input character stream according to the *longest match* rule.
That is, the next token always consists of the longest possible sequence of characters that is recognized as a token.

Tokens may explicitly be separated by :ref:`space <text-space>` characters or :ref:`comments <text-comment>`,
collectively called :ref:`white space <text-whitespace>`.
White space cannot appear inside a token.



.. _text-space:
.. _text-whitespace:
.. index:: ! white space

White Space
~~~~~~~~~~~

*White space* is any sequence of *space* characters or :ref:`comments <text-comment>`.

A space character either is the `ASCII <http://webstore.ansi.org/RecordDetail.aspx?sku=INCITS+4-1986%5bR2012%5d>`_ *space* (byte :math:`\hex{20}`) or an ASCII *format effector*, that is, *backspace* (:math:`\hex{08}`), *horizontal tabulation* (:math:`\hex{09}`), *line feed* (:math:`\hex{0A}`), *vertical tabulation* (:math:`\hex{0B}`), *form feed* (:math:`\hex{0C}`), or *carriage return* (:math:`\hex{0D}`).

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{white space} & \T{whitespace} &::=&
     (\T{space} ~|~ \T{comment})^\ast \\
   \production{space} & \T{space} &::=&
     \hex{20} ~|~ \hex{08} ~|~ \hex{09} ~|~ \hex{0A} ~|~ \hex{0B} ~|~ \hex{0C} ~|~ \hex{0D} \\
   \end{array}


.. text-comment:
.. index:: ! comments

Comments
~~~~~~~~

A *comment* can either be a *line comment*, started with a double semicolon :math:`\text{;\!;}` and extending to the end of the line,
or a *block comment*, enclosed in :math:`\text{(\!;} \dots \text{;\!)}`.
Block comments can be nested.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{comment} & \T{comment} &::=&
     \T{linecomment} ~|~ \T{blockcomment} \\
   \production{line comment} & \T{linecomment} &::=&
     \text{;\!;}~~\T{linecontent}^\ast~~(\hex{0A} ~|~ \T{eof}) \\
   \production{line content} & \T{linecontent} &::=&
     b & (b \neq \hex{0A}) \\
   \production{block comment} & \T{blockcomment} &::=&
     \text{(\!;}~~\T{blockcontent}^\ast~~\text{;\!)} \\
   \production{block content} & \T{blockcontent} &::=&
     b & (b \neq \text{;} \wedge b \neq \text{(}) \\ &&|&
     \text{;}~b & (b \neq \text{)}) \\ &&|&
     \text{(}~b & (b \neq \text{;}) \\ &&|&
     \T{blockcomment} \\
   \end{array}

Here, the pseudo token :math:`\T{eof}` indicates the end of the input.

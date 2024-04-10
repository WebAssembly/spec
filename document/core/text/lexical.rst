.. index:: lexical format
.. _text-lexical:

Lexical Format
--------------


.. index:: ! character, Unicode, ASCII, character, ! source text
   pair: text format; character
.. _source:
.. _text-source:
.. _text-char:

Characters
~~~~~~~~~~

The text format assigns meaning to *source text*, which consists of a sequence of *characters*.
Characters are assumed to be represented as valid |Unicode|_ (Section 2.4) *scalar values*.

.. math::
   \begin{array}{llll}
   \production{source} & \Tsource &::=&
     \Tchar^\ast \\
   \production{character} & \Tchar &::=&
     \unicode{00} ~|~ \dots ~|~ \unicode{D7FF} ~|~ \unicode{E000} ~|~ \dots ~|~ \unicode{10FFFF} \\
   \end{array}

.. note::
   While source text may contain any Unicode character in :ref:`comments <text-comment>` or :ref:`string <text-string>` literals,
   the rest of the grammar is formed exclusively from the characters supported by the 7-bit |ASCII|_ subset of Unicode.


.. index:: ! token, ! keyword, character, white space, comment, source text
   single: text format; token
.. _text-keyword:
.. _text-reserved:
.. _text-token:

Tokens
~~~~~~

The character stream in the source text is divided, from left to right, into a sequence of *tokens*, as defined by the following grammar.

.. math::
   \begin{array}{llll}
   \production{token} & \Ttoken &::=&
     \Tkeyword ~|~ \TuN ~|~ \TsN ~|~ \TfN ~|~ \Tstring ~|~ \Tid ~|~
     \text{(} ~|~ \text{)} ~|~ \Treserved \\
   \production{keyword} & \Tkeyword &::=&
     (\text{a} ~|~ \dots ~|~ \text{z})~\Tidchar^\ast
     \qquad (\iff~\mbox{occurring as a literal terminal in the grammar}) \\
   \production{reserved} & \Treserved &::=&
     (\Tidchar ~|~ \Tstring ~|~ \text{,} ~|~ \text{;} ~|~ \text{[} ~|~ \text{]} ~|~ \text{\{} ~|~ \text{\}})^+ \\
   \end{array}

Tokens are formed from the input character stream according to the *longest match* rule.
That is, the next token always consists of the longest possible sequence of characters that is recognized by the above lexical grammar.
Tokens can be separated by :ref:`white space <text-space>`,
but except for strings, they cannot themselves contain whitespace.

*Keyword* tokens are defined either implicitly by an occurrence of a :ref:`terminal symbol <text-grammar>` in literal form, such as :math:`\text{keyword}`, in a :ref:`syntactic <text-syntactic>` production of this chapter, or explicitly where they arise in this chapter.

Any token that does not fall into any of the other categories is considered *reserved*, and cannot occur in source text.

.. note::
   The effect of defining the set of reserved tokens is that all tokens must be separated by either parentheses, :ref:`white space <text-space>`, or :ref:`comments <text-comment>`.
   For example, :math:`\text{0\$x}` is a single reserved token, as is :math:`\text{"a""b"}`.
   Consequently, they are not recognized as two separate tokens :math:`\text{0}` and :math:`\text{\$x}`, or :math:`"a"` and :math:`"b"`, respectively, but instead disallowed.
   This property of tokenization is not affected by the fact that the definition of reserved tokens overlaps with other token classes.


.. index:: ! white space, character, ASCII
   single: text format; white space
.. _text-format:
.. _text-space:

White Space
~~~~~~~~~~~

*White space* is any sequence of literal space characters, formatting characters, :ref:`comments <text-comment>`, or :ref:`annotations <text-annot>`.
The allowed formatting characters correspond to a subset of the |ASCII|_ *format effectors*, namely, *horizontal tabulation* (:math:`\unicode{09}`), *line feed* (:math:`\unicode{0A}`), and *carriage return* (:math:`\unicode{0D}`).

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{white space} & \Tspace &::=&
     (\text{~~} ~|~ \Tformat ~|~ \Tcomment)^\ast \\
   \production{format} & \Tformat &::=&
     \Tnewline ~|~ \unicode{09} \\
   \production{newline} & \Tnewline &::=&
     \unicode{0A} ~|~ \unicode{0D} ~|~ \unicode{0D}~\unicode{0A} \\
   \end{array}

The only relevance of white space is to separate :ref:`tokens <text-token>`. It is otherwise ignored.


.. index:: ! comment, character
   single: text format; comment
.. _text-comment:

Comments
~~~~~~~~

A *comment* can either be a *line comment*, started with a double semicolon :math:`\Tcommentd` and extending to the end of the line,
or a *block comment*, enclosed in delimiters :math:`\Tcommentl \dots \Tcommentr`.
Block comments can be nested.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{comment} & \Tcomment &::=&
     \Tlinecomment ~|~ \Tblockcomment \\
   \production{line comment} & \Tlinecomment &::=&
     \Tcommentd~~\Tlinechar^\ast~~(\Tnewline ~|~ \T{eof}) \\
   \production{line character} & \Tlinechar &::=&
     c{:}\Tchar & (\iff c \neq \unicode{0A} \land c \neq \unicode{0D}) \\
   \production{block comment} & \Tblockcomment &::=&
     \Tcommentl~~\Tblockchar^\ast~~\Tcommentr \\
   \production{block character} & \Tblockchar &::=&
     c{:}\Tchar & (\iff c \neq \text{;} \land c \neq \text{(}) \\ &&|&
     \text{;} & (\iff~\mbox{the next character is not}~\text{)}) \\ &&|&
     \text{(} & (\iff~\mbox{the next character is not}~\text{;}) \\ &&|&
     \Tblockcomment \\
   \end{array}

Here, the pseudo token :math:`\T{eof}` indicates the end of the input.
The *look-ahead* restrictions on the productions for |Tblockchar| disambiguate the grammar such that only well-bracketed uses of block comment delimiters are allowed.

.. note::
   Any formatting and control characters are allowed inside comments.


.. index:: ! annotation
   single: text format; annotation
.. _text-annot:

Annotations
~~~~~~~~~~~

An *annotation* is a bracketed token sequence headed by an *annotation id* of the form :math:`\T{@id}`.
No :ref:`space <text-space>` is allowed between the opening parenthesis and this id.
Annotations are intended to be used for third-party extensions;
they can appear anywhere in a program but are ignored by the WebAssembly semantics itself, which treats them as :ref:`white space <text-space>`.

Annotations can contain other parenthesized token sequences (including nested annotations), as long as they are well-nested.
:ref:`String literals <text-string>` and :ref:`comments <text-comment>` occurring in an annotation must also be properly nested and closed.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{annot} & \Tannot &::=&
     \text{(@}~\Tidchar^+ ~(\Tspace ~|~ \Ttoken)^\ast~\text{)} \\
   \end{array}

.. note::
   The annotation id is meant to be an identifier categorising the extension, and plays a role similar to the name of a :ref:`custom section <binary-customsec>`.
   By convention, annotations corresponding to a custom section should use the custom section's name as an id.

   Implementations are expected to ignore annotations with ids that they do not recognize.
   On the other hand, they may impose restrictions on annotations that they do recognize, e.g., requiring a specific structure by superimposing a more concrete grammar.
   It is up to an implementation how it deals with errors in such annotations.

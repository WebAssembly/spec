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

$${grammar: Tsource Tchar}

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

$${grammar: Ttoken Tkeyword Treserved}

Tokens are formed from the input character stream according to the *longest match* rule.
That is, the next token always consists of the longest possible sequence of characters that is recognized by the above lexical grammar.
Tokens can be separated by :ref:`white space <text-space>`,
but except for strings, they cannot themselves contain whitespace.

*Keyword* tokens always start with a lower-case letter.
The set of keywords is defined implicitly:
only those tokens are defined to be keywords that occur as a :ref:`terminal symbol <text-grammar>` in literal form, such as ${:"keyword"}, in a :ref:`syntactic <text-syntactic>` production of this chapter.

Any token that does not fall into any of the other categories is considered *reserved*, and cannot occur in source text.

.. note::
   The effect of defining the set of reserved tokens is that all tokens must be separated by either parentheses, :ref:`white space <text-space>`, or :ref:`comments <text-comment>`.
   For example, ${:"0$x"} is a single reserved token, as is ${:"\"a\"\"b\""}.
   Consequently, they are not recognized as two separate tokens ${:"0"} and ${:"$x"}, or ${:"\"a\""} and ${:"\"b\""}, respectively, but instead disallowed.
   This property of tokenization is not affected by the fact that the definition of reserved tokens overlaps with other token classes.


.. index:: ! white space, character, ASCII
   single: text format; white space
.. _text-space:
.. _text-format:
.. _text-newline:

White Space
~~~~~~~~~~~

*White space* is any sequence of literal space characters, formatting characters, :ref:`comments <text-comment>`, or :ref:`annotations <text-annot>`.
The allowed formatting characters correspond to a subset of the |ASCII|_ *format effectors*, namely, *horizontal tabulation* (${:U+09}), *line feed* (${:U+0A}), and *carriage return* (${:U+0D}).

$${grammar: Tspace Tformat Tnewline}

The only relevance of white space is to separate :ref:`tokens <text-token>`. It is otherwise ignored.


.. index:: ! comment, character
   single: text format; comment
.. _text-comment:
.. _text-eof:

Comments
~~~~~~~~

A *comment* can either be a *line comment*, started with a double semicolon ${:";;"} and extending to the end of the line,
or a *block comment*, enclosed in delimiters ${:"(;"...";)"}.
Block comments can be nested.

$${grammar: Tcomment {Tlinecomment Tlinechar} {Tblockcomment Tblockchar}}

Here, the pseudo token ${grammar-case: Teof} indicates the end of the input.
The *look-ahead* restrictions on the productions for ${grammar-case: Tblockchar} disambiguate the grammar such that only well-bracketed uses of block comment delimiters are allowed.

.. note::
   Any formatting and control characters are allowed inside comments.


.. index:: ! annotation
   single: text format; annotation
.. _text-annot:

Annotations
~~~~~~~~~~~

An *annotation* is a bracketed token sequence headed by an *annotation id* of the form ${:"@id"} or ${:"@\"...\""}.
No :ref:`space <text-space>` is allowed between the opening parenthesis and this id.
Annotations are intended to be used for third-party extensions;
they can appear anywhere in a program but are ignored by the WebAssembly semantics itself, which treats them as :ref:`white space <text-space>`.

Annotations can contain other parenthesized token sequences (including nested annotations), as long as they are well-nested.
:ref:`String literals <text-string>` and :ref:`comments <text-comment>` occurring in an annotation must also be properly nested and closed.

$${grammar: Tannot Tannotid}

.. note::
   The annotation id is meant to be an identifier categorising the extension, and plays a role similar to the name of a :ref:`custom section <binary-customsec>`.
   By convention, annotations corresponding to a custom section should use the custom section's name as an id.

   Implementations are expected to ignore annotations with ids that they do not recognize.
   On the other hand, they may impose restrictions on annotations that they do recognize, e.g., requiring a specific structure by superimposing a more concrete grammar.
   It is up to an implementation how it deals with errors in such annotations.

# Splicing

One of the main functions of SpecTec is the ability to pre-process a set of document files.
These files are expected to contain an arbitrary number of *splice anchors*,
which are then replaced by embedded Latex formulas or prose.
The anchors specify where and what to insert during pre-processing.

See [Usage](Usage.md) for details on invoking SpecTec for splicing.


### Syntax

The general syntax of splice anchors is as follows:
```
tag ::= ...

splice ::=
  tag"{" desc "}"

desc ::=
  relid ":" exp                         typed relation expression splice
  typ ":" exp                           typed expression splice
  ":" exp                               untyped expression splice
  sort ":" group*                       definition splice

group ::=
  name                                  individual definition
  "{" name* "}"                         grouped definitions

name ::=
  id                                    flat or singleton definition
  id "/" regexp                         set definition

id ::=
  (letter | digit | "_" | "-" | "'" | "`")+

regexp ::=
  (id | '*' | '?')+
```

The `tag` can be configured differently for different file formats. Currently, two formats are supported:

* _Latex._ Tags are `#` and `##`, generating `$...$` and `$$...$$`, respectively.

* _Sphinx._ Tags are `$` and `$$`, generating `:math:'...'` and `.. math:: ...`, respectively.

There are two forms of splices:

1. _Expression splices_ (`tag{typ: exp }`). The body of this splice is a SpecTec [expression](Language.md#expressions). The effect is to render this expression and insert it. These splices may be prefixed with a relation identifier or a type. These can be omitted if the type can be inferred from the expression, but are necessary if it contains user-defined notation or atoms _and_ is supposed to be type-set with macros (type information is needed to generate the right macro names for atoms).

2. _Definition splices_ (`tag{sort: group* }`). This splice renders and inserts (a set of) SpecTec [definitions](Language.md#definitions) from the input, identified by the _names_ in the `group`. The following `sort`s are recognised:

   * `syntax`: the identifiers refer to (possibly a fragment of a) [syntax definition](Language.md#type-definitions), whose grammar is rendered,

   * `relation`: the identifiers refer to definitions of [relations](Language.md#relations-and-rules), whose schema is rendered,

   * `rule`: the identifiers refer to definitions of [rules](Language.md#relations-and-rules), which are rendered depending on the hints attached to the relation:
     * by default, rules are rendered as inference rules,
     * if the definition has a `tabular` hint, its reuls are rendered as an array of one-line rules,

   * `definition`: the identifiers refer to [function definitions](Language.md#functions), whose clauses are rendered.

   * `grammar`: the identifiers refer to (possibly a fragment of a) [grammar definitions](Language.md#grammars), which are rendered.

   * `rule-prose`: similar to `rule`, but the rule is rendered as a [prose](Prose.md) algorithm,

   * `definition-prose`: similar to `definition`, but its computation is rendered as a [prose](Prose.md) algorithm,

All of the above except for the prose anchors allow appending a `-` to the sort name.
That locally suppresses the effect of the `--latex-macros` option.

The `syntax` and `rule` sorts alternatively allow appending a `+`,
which causes them to be decorated:
in the case of syntax,
the definition is annotated with their description hint (`hint(desc "...")`);
in the case of rules,
it is annotated with their [name](#definition-names).

Finally, all of the above sorts can be negated by appending `-ignore`.
That causes them to be ignored,
while also suppressing a warning when the [`-w` option](Usage.md#splicing-mode) was given.


Each splice may contain a list of identifiers, whose definitions will be arranged and aligned together in a single array in the case of math, with multiple definitions separated by (`0.8ex`) vertical space.

In addition, definitions can be grouped together by using braces `{ name* }`, which removes the vertical space between them. In the case of typing rules, the rules are placed on a single line.

In the case of `syntax` or `grammar`, grouping together multiple *fragments* of the same [variant type](Language.md#variant-types) or [grammar](Language.md#grammars) also _merges_ these fragments, removing trailing and leading dots in the middle.


### Definition names

The names in a definition splice refer to definitions according to the indicated sort.

* Relations and definitions have a _flat_ namespace, and are hence named by a single identifier.

* Syntax fragments and rules have a _nested_ namespace, and are hence named by a pair of identifiers, `id1/id2`. If only one element exists in the nested namespace, `/id2` can be omitted, in case it was also omitted in the respective syntax or rule definition.

* Nested namespaces can also be named by a regular expression, which expands to all `id2` matching it in the given namespace.


### Examples

```
;; insert definitions of types
$${syntax: numtype vectype valtype}

;; insert grammar for control and reference instructions together
$${syntax: {instr/control instr/reference}}

;; insert grammar for all instructions in a single grammar
$${syntax: {instr/*}}

;; insert typing rules for `unreachable`, `nop` and `drop`,
;; putting the first on its own, the latter two on the same line
$${rule: Instr_ok/unreachable {Instr_ok/nop Instr_ok/drop}}

;; insert reduction rules for `block`, `loop` and all the ones for `if`,
;; as well as `br` and `br_if`, but with small vertical space
$${rule: {Step/block Step/loop Step/if-*} {Step/br Step/br_if}}
```


### Coverage warnings

By setting the `-w` option, SpecTec will invoke warnings for any definition name from the spec sources that either has not been inserted, or was inserted multiple times.


### Customisation and Limitations

The format of the math and prose generated by SpecTec can be controlled and customised in various ways.
See the documentation for the [Latex backend](Latex.md) and the [Prose backend](Prose.md).

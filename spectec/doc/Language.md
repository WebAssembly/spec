# Language

The DSL is a typed notation language with a domain-specific _syntax_ and _type system_.


## Syntax

### Comments

Comments are either block (`(;...;)`) or line (`;;...\n`) comments.


### Lists

```
list(x, sep) ::=
  eps
  x
  x sep list(x, sep)
```


### Literals

```
digit ::= "0" | ... | "9"
hex ::= digit | "A" | ... | "F"

num ::= digit+ | "0x" hex+ | "U+" hex+ | "`" digit+
text ::= """ utf8* """
```


### Identifiers and Atoms

```
upletter ::= "A" | ... | "Z"
loletter ::= "a" | ... | "z"

upid ::= (upletter | "_") (upletter | digit | "_" | "." | "'")*
loid ::= (loletter | "`") (loletter | digit | "_" | "'")*
id ::= upid | loid

atomid ::= upid
varid ::= loid
gramid ::= id
defid ::= id
relid ::= id
ruleid ::= id
subid ::= ("/" | "-") ruleid

atom ::=
  atomid
  "infinity"
  "_|_"

atomop ::=
  "in" | :" | ";" | "\" | <:"
  "<<" | ">>"
  "|-" | "-|"
  ":=" | "~~"
  "->" | "~>" | "~>*" | "=>"
  "`." | ".." | "..."
  "?" | "*"
```


### Types

```
numtyp ::=
  "nat"                                natural numbers
  "int"                                integer numbers
  "rat"                                rational numbers
  "real"                               real numbers

typ ::=
  varid args                           type name
  "bool"                               booleans
  "text"                               text strings
  numtyp                               numbers
  typ iter                             iteration
  "(" list(typ, ",") ")"               parentheses or tupling

iter ::=
  "?"                                  optional
  "*"                                  list
  "+"                                  non-empty list
  "^" arith                            list of specific length
  "^" "(" id "<" arith ")"             list of specific length with index (only in expressions)
```
Iterated types essentially describe options or lists of phrases.

In addition to type expressions, custom _notation_ types can be defined:

```
deftyp ::=
  nottyp                                                              free notation
  "{" list(atom typ hint* premise*, ",") "}"                          record
  "..."? "|" list(varid | nottyp hint* premise*, "|") "|" "..."       variant
  list1(arith | arith "|" "..." "|" arith, "|")                       range / enumeration

nottyp ::=
  typ                                       plain type
  atom                                      atom
  atomop nottyp                             infix atom
  nottyp atomop nottyp                      infix atom
  nottyp nottyp                             sequencing
  "(" nottyp ")"                            parentheses
  "`" "(" nottyp ")"                        custom brackets
  "`" "[" nottyp "]"
  "`" "{" nottyp "}"
  nottyp iter                               iteration
```

Atoms, atom operators and brackets are uninterpreted by the DSL semantics itself and can be used to define symbolic syntax for abstract syntax or relations.
(Currently, most operators have hard-coded "natural" precedences. But these should be sufficient to emulate the kind of mixfix notation used for most relations.)


### Expressions

```
notop ::= "~"
logop ::= "/\" | "\/" | "=>"
cmpop ::= "=" | "=/=" | "<" | ">" | "<=" | ">="
exp ::=
  varid                                meta variable
  num                                  natural number literal
  text                                 text literal
  notop exp                            logical negation
  exp logop exp                        logical connective
  exp cmpop exp                        comparison
  "eps"                                empty sequence
  exp exp                              sequencing
  exp iter                             iteration
  "[" exp* "]"                         list
  exp "[" arith "]"                    list indexing
  exp "[" arith ":" arith "]"          list slicing
  exp "[" path "=" exp "]"             list update
  exp "[" path "=++" exp "]"           list extension
  "{" list(atom exp, ",") "}"          record
  exp "." atom                         record access
  exp "," exp                          record extension
  exp "++" exp                         list and record composition
  exp "<-" exp                         list membership
  "|" exp "|"                          list length
  "||" gramid "||"                     expansion length
  "(" list(exp, ",") ")"               parentheses or tupling
  "$" defid exp?                       function invocation
  atom                                 custom token
  atomop exp                           custom operator
  exp atomop exp
  "`" "(" list(exp, ",") ")"           custom brackets
  "`" "[" list(exp, ",") "]"
  "`" "{" list(exp, ",") "}"
  "$" "(" arith ")"                    escape to arithmetic syntax
  "$" numtyp "$" "(" arith ")"         numeric conversion
  hole                                 hole (for syntax rewrites in hints)
  exp "#" exp                          token concatenation (for syntax rewrites in hints)
  "##" exp                             remove possible parentheses (for syntax rewrites in hints)

unop  ::= notop | "+" | "-"
binop ::= logop | "+" | "-" | "*" | "/" | "\" | "^"
arith ::=
  varid                                meta variable
  atom                                 token
  num                                  natural number literal
  unop arith                           unary operator
  arith binop arith                    binary operator
  arith cmpop arith                    comparison
  exp "[" arith "]"                    list indexing
  "(" arith ")"                        parentheses
  "(" arith iter ")"                   iteration (must not be "^exp")
  "|" exp "|"                          list length
  "$" defid exp?                       function invocation
  "$" "(" exp ")"                      escape back to general expression syntax
  "$" numtyp "$" "(" arith ")"         numeric conversion

path ::=
  path? "[" arith "]"                  list element
  path? "[" arith ":" arith "]"        list slice
  path? "." atom                       record element


hole ::=
  "%"                                  use next operand
  "%"digit*                            use numbered operand
  "%%"                                 use all operands
  "!%"                                 empty expression
  "%latex" "(" text* ")"               literal latex
```

The various meta notations for lists, records, and tuples mirror the syntactic conventions defined in the Wasm spec.

Arithmetic expressions are a subset of general expressions, but with different parsing and interpretation of `+`, `*`, and `^` operators.
To use arithmetic operators in a place that is not naturally arithmetic, the subexpression must be escaped as `$( ... )`.


### Grammars

```
sym ::=
  gramid args
  num
  text
  "eps"
  "(" list(sym, ",") ")"
  "$" "(" arith ")"
  sym iter
  exp ":" sym
  sym sym
  sym "|" sym
  sym "|" "..." "|" sym

prod ::=
  sym "=>" exp ("--" premise)*

prod_list :
  | (* empty *) { [], NoDots }
  | DOTDOTDOT { [], Dots }
  | prod { (Elem $1)::[], NoDots }
  | prod BAR prod_list { let x, y = $3 in (Elem $1)::x, y }
  | prod NL_BAR prod_list { let x, y = $3 in (Elem $1)::Nl::x, y }

gram ::=
  "..."? ("|" prod)+ ("|" "...")?
```


### Definitions

```
args ::= ("(" list(arg ",") ")")?
arg ::=
  exp
  "syntax" typ
  "grammar" sym
  "def" defid

params ::= ("(" list(param ",") ")")?
param ::=
  (varid ":") typ
  "syntax" synid
  "grammar" gramid ":" typ
  "def" "$" defid params ":" typ

def ::=
  "syntax" varid params hint*                               syntax declaration
  "syntax" varid params subid* hint* "=" deftyp             syntax definition
  "grammar" gramid params subid* ":" typ hint* "=" gram     grammar definition
  "relation" relid hint* ":" typ                            relation declaration
  "rule" relid subid* hint* ":" exp ("--" premise)*  rule
  "var" varid ":" typ hint*                                 variable declaration
  "def" "$" defid params ":" typ hint*                      function declaration
  "def" "$" defid args "=" exp ("--" premise)*              function clause
  "syntax" varid subid* atom? hint+                         outlined hints
  "grammar" gramid subid* hint*
  "relation" relid hint+
  "rule" relid subid* hint+
  "var" varid hint+
  "def" "$" defid hint+

premise ::=
  "var" id ":" typ                                          local variable declaration
  relid ":" exp                                             relational premise
  "if" exp                                                  side condition
  "otherwise"                                               fallback side condition
  "(" premise ")" iter*                                     iterated relational premise
  "--"                                                      separator

hint ::=
  "hint" "(" hintid exp ")"                                 hint
```

Syntax defines an abstract syntax type.
Grammars define an attribute grammar for parsing input into abstract syntax.
Relations define the notation and type template for typing or reduction relations.
Rules define rules for the refered relation.
Variable declarations specify the type (globally) of uses of meta-variables of the respective name.
Function definitions enable the definition of auxiliary constants or functions.

Syntax and variable declarations can also change the status of an uppercase identifier from `atom` to `varid` when used as their declared name.

Variants can be defined in terms of previously defined variants, by including their identifiers in the list of cases. Definitions of syntax variants can also be split into multiple _fragments_: a variant with dots "..." at the end can be extended further by later variant definitions of the same name. This definition must start with dots, accordingly. A variant is completed by a fragment without trailing dots.

Hints are free-form annotations that are interpreted by individual backends. For example, the [Latex backend](Latex.md) recognises `hint(show ...)` on various definitions to customise their appearance.


### Scripts

```
script ::=
  def*
```


## Type System

The frontend checks that all definitions are consistent. Among other things, this involves inferring and type-checking that:

* all identifiers are declared,
* all expressions are well-typed,
* all rules and premises match the notation template of their respective relations,
* no definiton or variant case is defined multiple times,
* use of variables under iterators like `?` and `*` (multiplicity) is consistent,
* there is no invalid recursion between definitions of different sort.

The type system uses a simple form of bidrectional typing to resolve and disambiguate uses of free-form notation.

While type-checking, the frontend _elaborates_ (lowers) the _external language_ ([EL](EL.md)) representing the input into a more rigidly type _internal language_ ([IL](IL.md)) suitable for consumption by code-generating backends. This can be viewed as a form of desugaring. The IL is unambiguous and makes all relevant information explicit, such as recursion groups, depedency order, local variable binders and their types, uses of subtype injection, list construction, etc.

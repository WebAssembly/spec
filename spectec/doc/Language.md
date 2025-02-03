# Language

SpecTec is a typed notation language with a domain-specific _syntax_ and _type system_.

## Concepts

### Syntax Types

All SpecTec definitions operate on *abstract syntax*,
which describes the syntactic shape of expressions and values appearing in definitions.
Essentially, abstract syntax defines the *types* of the SpecTec language.
We hence call them *syntax types*.

#### Type Expressions

Simple syntax types can be given inline,
by means of the following type expressions
that can be nested and composed freely:
```
typ ::=
  "bool"                               booleans
  "nat"                                natural numbers
  "int"                                integer numbers
  "rat"                                rational numbers
  "real"                               real numbers
  "text"                               text strings
  "(" list(typ, ",") ")"               tuples
  typ iter                             iteration
  varid args                           type name with possible parameters

iter ::=
  "?"                                  optional
  "*"                                  list

args ::= ("(" list(arg ",") ")")?
arg ::=
  exp
  "syntax"? typ
  "grammar" sym
  "def" defid
```
The primitive types should be self-explanatory.

Tuple types are expressed by a comma-separated list of types
(`list(x, sep)` is a sequences of `x`'s separated by `sep`).

*Iterated types* essentially describe options or lists of elements.
Non-empty or fixed-length lists are not currently allowed in types,
only in expressions.

Named types can have *arguments* corresponding to the type's parameters.
We discuss the various forms of parameterisation later,
but the two relevant ones for types are either other types
(indicated by the keyword `syntax`, that usually can be omitted),
or values of a certain type, denoted by an expression.
The latter gives rise to *dependent types*.

**Example:**
The following syntax type describes a list of triples,
each consisting of a natural number, a type named `foo` with parameter `nat`, and an optional Boolean:
```
(nat, foo(nat), bool?)*
```

#### Type Definitions

In addition to type expressions, custom _notation_ types can be defined:
```
def ::=
  "syntax" varid params              syntax type declaration
  "syntax" varid params "=" deftyp   syntax type definition
  "syntax" varid args "=" deftyp     syntax type case definition

params ::= ("(" list(param ",") ")")?
param ::=
  (varid ":") typ
  "syntax" synid
  "grammar" gramid ":" typ
  "def" "$" defid params ":" typ
```
Type definitions can have parameters,
typically abstracting over another syntax type or a value of specific type.

In the most general form,
a type is first declared,
specifying its parameters.
Then, one or several definitions for different instantiations of the parameters can be provided.
Each case is given as clausal equation with argument expressions on the left,
which are treated as *patterns*.
The instantiation of a type is determined by the equation whose pattern is matched by the concrete argument.
This gives rise to *type families*.

When a type's definition is *parametric* in its parameters,
then declaration and definition can be merged.
Syntactically, this works because the SpecTec syntax for parameters is a subset of that for arguments.

**Example:**
The following defines a simple type synonym:
```
syntax idx = nat
```
**Example:**
We can define a generic type of 2D matrices as nested sequences:
```
syntax matrix(syntax x) = x**
```
**Example:**
A type of numeric tuple with an arity parameter could be defined as:
```
syntax tuple(nat)
syntax tuple(0) = ()
syntax tuple(1) = (nat)
syntax tuple(2) = (nat, nat)
syntax tuple(3) = (nat, nat, nat)
```
(This is a contrived example.
We will see more useful examples of type families in a short while.)

The right-hand side of a type definition can take one of several forms:
```
deftyp ::=
  typ                                       alias
  contyp                                    constructor
  list(casetyp, "|")                        variant
  list(rangetyp, "|")                       range / enumeration
  "{" list(fieldtyp, ",") "}"               record

contyp   ::= nottyp premise*
casetyp  ::= nottyp premise*
fieldtyp ::= atom typ premise*
rangetyp ::= exp | "..."

nottyp ::=
  typ                                       plain type
  atom                                      atom
  atomop nottyp                             prefix atom
  nottyp atomop nottyp                      infix atom
  "`" atomop                                escaped infix atom
  "`" "(" nottyp ")"                        custom brackets
  "`" "[" nottyp "]"
  "`" "{" nottyp "}"
```

##### Type Aliases

The simplest form of a type definition is a *type alias*,
where the right-hand side consists of a simple type expression.
(Syntactically, this is a special case of a constructor type
consisting of just a plain type and no premises.)

We already so a few examples above.


##### Constructor Types

A *constructor type* essentially introduces mixfix custom notation.
It's right-hand side is a *notation type*,
which roughly is a mixture of type expressions
interspersed with custom syntax elements in the form of *atoms*,
which are syntactic markers uninterpreted by the SpecTec semantics.

In a first approximation,
an atom is either an uppercase identifier,
or one of various recognised *symbolic* atoms,
such as `|-`, `:`, or `->`,
or pairs of brackets escaped with `` ` ``.
Some symbolic atoms have infix operator status
(with hard-coded "natural" precedences),
affecting the way they are parsed;
this status can be escaped with `` ` `` as well.

An expression of constructor type must use atoms and intermittent expressions in the exact same sequence that the type definition declares.

**Example:**
The following type could be used to define the abstract syntax of function types over some base type:
```
syntax basetype = text
syntax functiontype = basetype* -> basetype
```


##### Variant Types

A *variant type* consists of multiple alternative constructor types separated by `|`.
To be syntactically distinguishable,
every alternative must contain at least one atom,
and the first atom of each case must be disjoint from the first atom of every other case in the same variant.

**Example:**
Consider a type for representing some of Wasm's instructions:
```
syntax instr = DROP | CONST numtyp const | BR labelidx | BLOCK instr*
```

Variants can be defined in terms of previously defined variants,
by including their identifiers in the list of cases.

**Example:**
The previous type can be extended with new cases:
```
syntax admininstr = instr | TRAP | LABEL `{ instr* } admininstr*
```

Note that extending a [recursive](#type-recursion) type does not affect its recursive references,
that is, SpecTec does not provide "open" recursion.

**Example:** 
In the type `admininstr` above, blocks can only contain regular instructions,
not administrative ones.

Definitions of syntax variants can also be split into multiple _fragments_:
a variant with dots "..." at the end can be extended further by later variant definitions of the same name.
This definition must start with dots, accordingly.
A variant is completed by a fragment without trailing dots.
Fragment names can be amended with a hierarchical sub-name of the form `x/y`,
which can be used to refer to a fragment from splices.

**Example:**
The instruction syntax above could be defined in two fragments:
```
syntax instr/arith = DROP | CONST numtyp const | ...
syntax instr/control = ... | BR labelidx | BLOCK instr*
```

Semantically, a type definition split into fragments is equivalent to a combined one.
Splitting a definition only has organisational purpose.


##### Range Types

A *range type* is a special kind ov variant over cases of natural or integral numbers.
It enumerates the values allowed,
with the possiblity of specifiying subranges with `...`.

**Example:**
Types for representing bytes or finite integer types are always handy:
```
syntax byte = 0x00 | ... | 0xFF
syntax int32 = -2^31 | ... | -1 | 0 | +1 | ... | +2^31-1
```

Semantically, range types are mostly treated like constructor types for `nat` or `int`,
with a [premise](#premises) restricting their value range.
That implies that SpecTec performs no actual range checks.
Rather, the showing that side conditions are preserved is left to proofs in theorem provers.


##### Record Types

A *record type* defines special notation for forming record-like structures with named fields.
The definition encloses a sequence of field declarations in braces.
Each field's notation has to consist of a leading atom and the plain type of the field's contents.

**Example:**
Record types are not that different from those in regular programming languages:
```
syntax person = {NAME text, AGE nat, ADDRESS text}
```

SpecTec provides special syntax for accessing values of record type,
in particular, dot notation for field access.


##### Premises

All forms of type notation except plain type aliases can have *premises* on each of their cases or fields.
A premise expresses a side condition,
that is, a constraint on the values of these types.
```
premise ::=
  "var" id ":" typ                                          local variable declaration
  "if" exp                                                  side condition
  "otherwise"                                               fallback side condition
  relid ":" exp                                             relational premise
  "(" premise ")" iter*                                     iterated relational premise
```

Premises are not checked by SpecTec when forming values of respective types.
Since premises can express arbitrary conditions,
it is generally impossible to perform such checks automatically.
Instead, the philosophy is that the conditions express additional invariants on a type
that have to be proved separately about a semantics defined in SpecTec,
e.g., using a theorem prover.

**Example:** An alternative way to specify a finite integer type would be this:
```
syntax int32 = int  -- if int >= $(-2^31) /\ int < $(+2^31)
``` 
(This example makes use of the fact that the occurrence of the type name `int` also implicitly binds a term variable of the same name that can be used on the right-hand side.)

Most of the other forms of premises are more useful in rules or functions definitions,
described later.


##### Type Recursion

Type definitions can be recursive.
However, the semantic interpretation of such recursion is left to backends.
SpecTec does not currently perform any checks to ensure that its own meta-level type checking terminates when recursive type expansion is involved.

**Example:** Consider a type for representing the expressions of the lambda calculus:
```
syntax exp = VAR text | LAMBDA text `( exp ) | APP exp exp
```


#### Relations between Types

##### Type Equivalence

All types in SpecTec are structural.
Hence, two type definitions are equal
if they reduce
(after substituting type arguments, expanding type aliases, and modulo alpha-renaming)
to the same shape.

Variant and record types are only deemed equivalent, respectively,
if they define the same cases or fields in the same order.

Premises are only considered equivalent if they are syntactically identical.


##### Subtyping

SpecTec also employs a weak form of shallow subtyping:

* Tuple types are in a subtype relation if they have the same arity,
  and their component types are in a pairwise subtype relation.

* Constructed types are in a subtype relation if their definition is equivalent,
  except that the larger type may drop some premises.

* Variant types are in a subtype relation if the smaller type has fewer or the same number of cases,
  and for each of its cases there is an equivalent case in the larger type,
  except that the case in the larger type may drop some premises.

* Record types are in a subtype relation if the larger type has fewer or the same number of fields,
  and for each of its fields there is an equivalent case in the smaller type,
  except that the field in the larger type may drop some premises.


### Expressions

The objects of SpecTec expressions are Booleans, numbers, tuples, sequences, and abstract syntax.
The latter may in turn consist of records or variants.
For all these kinds of values,
SpecTec provides certain expression forms
that can be regarded the *meta-notation* of a specification written *with* SpecTec.

Expressions come in various forms that we introduce incrementally in this section.
```
exp ::= ...
```


#### Variables

The first form of expression references a variable in scope:
```
exp ::= ...
  varid                                meta variable
```
Variables must either have a declared type,
or their type must otherwise be determined by context.


#### Literals

The most primitive expression form are literals:
```
exp ::= ...
  bool                                 Boolean literal
  num                                  number literal
  text                                 text literal

num ::= digit+ | "0x" hex+ | "U+" hex+ | "`" digit+
bool ::= "true" | "false"
text ::= """ utf8* """

digit ::= "0" | ... | "9"
hex ::= digit | "A" | ... | "F"
```
These should come at no surprise.


#### Boolean Operators

The usual operators are provided to produce or connect Booleans:
```
exp ::= ...
  notop exp                            logical negation
  exp logop exp                        logical connective
  exp cmpop exp                        comparison

notop ::= "~"
logop ::= "/\" | "\/" | "=>"
cmpop ::= "=" | "=/=" | "<" | ">" | "<=" | ">="
```


#### Arithmetic Expressions

SpecTec parses `*`, `+`, and `^` as regular-expression-like [iterations](#iterations) by default,
and therefore cannot allow the direct use of these symbols as arithmetic operators.
Instead, arithmetic expressions are a separate syntactic class
that must explicitly be enclosed by `$(...)`.
```
exp ::= ...
  "$" "(" arith ")"                    escape to arithmetic syntax
  "$" numtyp "$" "(" arith ")"         numeric conversion

arith ::=
  unop arith                           unary operator
  arith binop arith                    binary operator
  arith cmpop arith                    comparison
  varid                                meta variable
  bool                                 Boolean literal
  num                                  number literal
  exp "[" arith "]"                    list indexing
  "(" arith ")"                        parentheses
  "(" arith iter ")"                   iteration (must not be "^exp")
  "|" exp "|"                          list length
  "$" defid args                       function invocation
  "$" "(" exp ")"                      escape back to general expression syntax
  "$" numtyp "$" "(" arith ")"         numeric conversion

unop  ::= notop | "+" | "-"
binop ::= logop | "+" | "-" | "*" | "/" | "\" | "^"
```
Except for the addition of unary and binary arithmetic operators,
arithmetic expressions are a syntactic subset of general expressions,
whose meanings are explained below.

Using the escape `$(...)` inside an arithmetic expression inversely escapes back to regular expressions.

Values can be converted explicitly between different numeric types,
using the form `$numtyp$(...)`.
This is a partial operation,
it is undefined when the operand value is not representable in the target type.
(Conversely, all safe numeric conversions are applied implicitly by SpecTec,
and do not need to be written out.)


#### Tuples

Tuples can be formed as expected:
```
exp ::= ...
  "(" list(exp, ",") ")"               parentheses or tupling
```

There are no expressions for accessing tuples.
Instead, they are decomposed by pattern matching.


#### Sequences and Lists

Sequences or lists of values of homogeneous type can be manipulated with various expression forms:
```
exp ::= ...
  "eps"                                empty sequence
  exp exp                              sequencing
  exp "++" exp                         list concatenation
  "[" exp* "]"                         list formation
  exp "[" arith "]"                    list indexing
  exp "[" arith ":" arith "]"          list slicing
  exp "[" path "=" exp "]"             list update
  exp "[" path "=++" exp "]"           list extension
  "|" exp "|"                          list length
  exp "<-" exp                         list membership

path ::=
  path? "[" arith "]"                  list element
  path? "[" arith ":" arith "]"        list slice
  path? "." atom                       record element
```
In general, sequences can be formed simply by juxtaposition of several values.
Depending on their types,
this can be interpreted as concatenation,
or as injection into a singleton sequence followed by concatenation.

Sequences of *homogeneous* syntax type are also called *lists*.
Various operators are available to manipulate them.

In contexts where juxtaposition becomes ambiguous or hard to read,
the explicit operator `++` can be used for concatenation.
Similarly, a list can be formed more explicitly by enclosing it in brackets.
In that case, all constituent expressions are typed as elements.

Indexing into a list is expressed by postfix brackets enclosing an [arithmetic expression](#arithmetic-expressions).
Indices are always zero-based.

Postfix brackets can also be used to extract a *slice* of a list.
In this case, the first arithmetic expression identifies the start offset of the slice to extract,
while the second determines its length.

Bracket notation can also be used to modify a list.
In the first form, the path denotes a subcomponent of the list that is replaced with the right-hand side expression's value.
In the second form, that value is appended to the existing one instead.
A path can recursively identify more deeply nested components in a list,
and may also identify record components.
If the the initial component of the path is a record access,
then the left-hand side expression must have a suitable record type instead of being a list.

The last two operators return the length of a list,
and check for membership.
With the latter operator,
sequences can be used as sets.

Lists can also be formed by [iterations](#iterations).


#### Records

Values of [record type](#record-types) can be formed and eliminated:
```
exp ::= ...
  "{" list(fieldexp, ",") "}"          record
  exp "." atom                         record access
  exp "++" exp                         record composition
  exp "," atom exp*                    record extension

fieldexp ::= atom exp
```
Records can only be formed in a context where their expected type can be determined.
They are accessed using dot notation.

Records can also be composed using the `++` operator,
generalising its use on lists.
This requires both records to be of the same type,
and all their fields must in turn either be of composable record types
or compatible sequence types `t*`.
The operation recursively composes the records,
concatenating fields of sequence type.

The final form is a short-hand for the latter.
It is equivalent to `exp ++ {atom exp*}`,
but is rendered in the familiar style of context extension.

In addition to these expression forms,
update `exp[path = exp]` can be applied to records
if the path's initial projection is a record access.


#### Constants and Function Invocations

User-defined functions are invoked by their name and a suitable argument list:
```
exp ::= ...
  "$" defid args                       function invocation
```
The argument list can be omitted if it is empty.
This way, definitions can also be used to global constants.


#### Notation

Type definitions introducing custom notation require expressions of analogous form:
```
exp ::= ...
  exp exp                              sequencing
  atom                                 atom
  atomop exp                           prefix atom
  exp atomop exp                       infix atom
  "`" "(" list(exp, ",") ")"           bracket atoms
  "`" "[" list(exp, ",") "]"
  "`" "{" list(exp, ",") "}"
```
Sequencing can be interpreted as both a list,
as custom notation,
or as a mixture of both.
Custom notation can only occur where the expected type is known from the context.


#### Iteration

The most powerful construct in SpecTec is iteration:
```
exp ::= ...
  exp iter                             iteration

iter ::=
  "?"                                  optional
  "*"                                  list
  "+"                                  non-empty list (only in expressions)
  "^" arith                            list of specific length (only in expressions)
  "^" "(" id "<" arith ")"             list of specific length with index (only in expressions)
```
When applied to a single variable,
an iteration essentially just denotes the *dimension* of that variable:

- `n*` denotes a (possibly empty) sequence of values `n`,
- `n+` denotes a non-empty sequence of values `n`,
- `n^k` denotes a sequence of `k` values `n`,
- `n?` denotes a value `n`, or the empty sequence `eps`,

This notation generalises to arbitrary expressions.
When a variable occurs as part of a larger expression under an iteration,
then this can be read as *mapping* over that variable
and corresponds to the use of overbars in formal notation.

For example, given a list `x*`,
the expression `{A x, B 1}*` denotes a list of records
whose field `A` is drawn from the respective element of `x*`.
The dimension of the expression must mach that of the variable.

Multiple variables can occur in an iteration,
which expresses *parallel iteration* over all the variables.
For this to be well-formed, they must all have the same dimension.

Moreover, an iteration must contain at least one variable to be well-formed.

An iteration can also contain variables not participating in the iteration.
For example, if `x*` is given and a scalar `y`,
then `{A x, B y}*` inserts the same `y` for each field `B` in the resulting list of records.

Like overbars, iterations can nest freely,
leading to variables of higher dimension.
For example, `z**` is a list of lists,
whereas `(z^3)*` (usually) implies that `z` is a list of triples.
The nested dimensions of a variable form a *dimension vector*.

SpecTec infers the dimension vector of each variable
and checks that its is used with consistent dimensions for every occurrence.
A variable can appear under nested iterations with different accumulated dimension vectors,
as long as the _shortest_ (possibly empty) dimension vector is a _prefix_ of all others.
That shortest common prefix is then inferred to be the actual dimension vector of the variable.
For example, the expression
```
l = {A x, B y, C z}** /\ (x < 100)** /\ z <- y*
```
is inferred with dimensions `x**`, `y*`, and scalar `z` and `l`.


##### Type Inference

TODO

The frontend checks that all definitions are consistent. Among other things, this involves inferring and type-checking that:

* all identifiers are declared,
* all expressions are well-typed,
* all rules and premises match the notation template of their respective relations,
* no definiton or variant case is defined multiple times,
* use of variables under iterators like `?` and `*` (multiplicity) is consistent,
* there is no invalid recursion between definitions of different sort.

The type system uses a simple form of bidrectional typing to resolve and disambiguate uses of free-form notation.

While type-checking, the frontend _elaborates_ (lowers) the _external language_ ([EL](EL.md)) representing the input into a more rigidly type _internal language_ ([IL](IL.md)) suitable for consumption by code-generating backends.
This can be viewed as a form of desugaring.
The IL is unambiguous and makes all relevant information explicit,
such as recursion groups, depedency order, local variable binders and their types, uses of subtype injection, list construction, etc.


##### Reduction

SpecTec does not by itself perform any computation on expressions.
There is one exception:
due to the presence of dependent types,
i.e., expression arguments to type names,
the SpecTec type checker sometimes has to *reduce* these expressions
in order to check the equivalence of types,
or to simplify the use of a type name defining a type family.

If reduction does not yield a specific enough term to decide equivalence or reduce a family constructor where necessary,
then type checking may fail.


### Variable Declarations

TODO

Variable declarations allow to globally declare the type implicitly associated with each use of a meta-variable.

SpecTec recognizes suffixes as in `x_1` or `x'`` as variations with the same type.

In addition to explicit variable declarations,
syntax definitions implicitly declare a variable of the same name as the type.

Syntax and variable declarations can also change the status of an uppercase identifier from `atom` to `varid` when used as their declared name.


### Functions

TODO

Function definitions are given by a declaration of their type and then individual equational clauses.
The clauses express a (sequential) pattern match,
with their left-hand side argument expression being the pattern and possible premises acting as pattern guards.

Like syntax, relations and functions are all interpreted as inductive definitions.


### Relations and Rules

TODO

Relations are declared with a type that specifies their notation,
which will typically consist of a sequence of syntax types separated by atoms.

Each corresponding rule then consists of an expression of the respective type,
possibly accompanied by a sequence of *premises*.

In its basic form, a premise can either invoke another relation,
in which case the name of that relation has to be given along with an expression of a suitable type,
or it is a Boolean side condition.

A special premise is `otherwise`,
which represents the negation of all premises previously used for the same left-hand side.
Premises can also be iterated.

All rules must be uniquely named,
and these names can be hierarchical;
the names have no semantic relevance, but allow referring to individual rules in splices.


### Grammars

TODO

Grammars define an attribute grammar for parsing input into abstract syntax.


### Hints

TODO

Hints are free-form annotations that are interpreted by individual backends. For example, the [Latex backend](Latex.md) recognises `hint(show ...)` on various definitions to customise their appearance.


## Syntax Summary

### Comments

Comments are either block (`(;...;)`) or line (`;;...\n`) comments.


### Item Lists

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
bool ::= "true" | "false"
text ::= """ utf8* """
```


### Identifiers and Atoms

```
upletter ::= "A" | ... | "Z"
loletter ::= "a" | ... | "z"

upid ::= (upletter | "`" loletter | "_") (upletter | digit | "_" | "." | "'")*
loid ::= (loletter | "`" upletter | "`_") (loletter | digit | "_" | "'")*
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


### Type Definitions

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


### Expressions

```
notop ::= "~"
logop ::= "/\" | "\/" | "=>"
cmpop ::= "=" | "=/=" | "<" | ">" | "<=" | ">="
exp ::=
  varid                                meta variable
  bool                                 Boolean literal
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
  "$" defid args                       function invocation
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


### Scripts

```
script ::=
  def*
```

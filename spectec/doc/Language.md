# Language

SpecTec is a typed notation language with a domain-specific _syntax_ and _type system_.

In the BNF grammars shown in this document,
we use `x?`, `x*`, `x+` to describe optional, sequences and non-empty sequences of symbols, respectively.
Furthermore, a bit less standard,
we write `x*sep` or `x+sep` to describe respective sequences of `x`'s that are separated by `sep`.


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
  "(" typ*"," ")"                      tuples
  typ iter                             iteration
  varid args                           type name with possible parameters

iter ::=
  "?"                                  optional
  "*"                                  list

args ::= ("(" arg*"," ")")?
arg ::=
  exp
  "syntax"? typ
  "grammar" sym
  "def" defid
```
The set of *primitive types* should be self-explanatory.

*Tuple types* are expressed by a comma-separated list of types.

*Iterated types* essentially describe options or lists of elements.
Non-empty or fixed-length lists are not currently allowed in types,
only in expressions.

*Named types* can have *arguments* corresponding to the type's parameters.
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

params ::= ("(" param*"," ")")?
param ::=
  (varid ":")? typ
  "syntax" synid
  "grammar" gramid ":" typ
  "def" "$" defid params ":" typ
```
Type definitions can have *parameters*,
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
  typ                                      alias
  contyp                                   constructor
  "|"? casetyp*"|"                         variant
  rangetyp*"|"                             range / enumeration
  "{" fieldtyp*"," ","? "}"                record

contyp   ::= nottyp ("--" premise)*
casetyp  ::= nottyp ("--" premise)*
fieldtyp ::= atom typ ("--" premise)*
rangetyp ::= exp | "..."

nottyp ::=
  typ                                       plain type
  atomid                                    atom
  atomop nottyp                             prefix atom
  nottyp atomop nottyp                      infix atom
  "`" atomop                                escaped infix atom
  "`" "(" nottyp ")"                        custom brackets
  "`" "[" nottyp "]"
  "`" "{" nottyp "}"

atomid ::=
  (upletter | "`" loletter | "_") (upletter | digit | "_" | "." | "'")*
  "infinity"
  "_|_" | "^|^"

atomop ::=
  ":" | ";" | "\" | <:"
  "<<" | ">>"
  "|-" | "-|"
  ":=" | "~~"
  "->" | "~>" | "~>*" | "=>"
  "`." | ".." | "..."
  "?" | "*"
```

##### Type Aliases

The simplest form of a type definition is a *type alias*,
where the right-hand side consists of a simple type expression.
(Syntactically, this is a special case of a constructor type
consisting of just a plain type and no premises.)

We already saw a few examples above.


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
or pairs of maching brackets escaped with `` ` ``.
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
A definition can extend multiple other types.
Overlapping cases between them are merged together,
and hence only allowed if they are syntactically identical.

Note that extending a [recursive](#type-recursion) type does not affect its recursive references,
that is, SpecTec does not provide "open" recursion.

**Example:** 
In the type `admininstr` above, blocks can only contain regular instructions,
not administrative ones.

In addition to the basic grammar shown above,
definitions of syntax variants can also be split into multiple _fragments_:
```
def ::=
  "syntax" varid subid* "=" deftyp-frag        syntax fragment definition

deftyp-frag ::=
  "..."
  ("..." "|")? casetyp*"|" ("|" "...")?        variant fragment
```
A variant with dots "..." at the end can be extended further by later variant definitions of the same name.
This definition must start with dots, accordingly.
A variant is completed by a fragment without trailing dots.
Each fragment must be named uniquely by amending the type name with a (possibly empty) list of hierarchical sub-identifiers of the form `x/y`,
which can be used to refer to a fragment from splices.
Currently, variant types defined in fragments cannot have parameters.

**Example:**
The instruction syntax above could be defined in two fragments:
```
syntax instr/stack = DROP | ...
syntax instr/arith = ... | CONST numtyp const | ...
syntax instr/control = ... | BR labelidx | BLOCK instr*
```

Semantically, a type definition split into fragments is equivalent to a combined one.
Splitting a definition only has organisational purpose.


##### Range Types

A *range type* is a special kind of variant over cases of natural or integral numbers.
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
Each field's notation has to consist of a unique leading atom as its name
and the plain type of the field's contents.

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

**Example:**
An alternative way to specify a finite integer type would be this:
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

**Example:**
Consider a type for representing the expressions of the lambda calculus:
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

varid ::= (loletter | "`" upletter | "`_") (loletter | digit | "_" | "'")*
upletter ::= "A" | ... | "Z"
loletter ::= "a" | ... | "z"
```
Variables are alpha-numeric identifiers starting with a lower-case letter.
They can be upper-case when escaped with `` ` ``.

Variables must either have a [declared type](#variable-declarations),
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
These should come as no surprise.


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

Numeric values can be *converted implicitly* to types of larger value range.
All such safe numeric conversions are applied implicitly by SpecTec.

Values can also be *converted explicitly* between different numeric types,
using the form `$numtyp$(...)`.
This is a partial operation,
it is undefined when the operand value is not representable in the target type.


#### Tuples

Tuples can be formed as expected:
```
exp ::= ...
  "(" exp*"," ")"                      parentheses or tupling
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

**Example:**
If `l` is the list `a b c d e f`,
then `l[2 : 3]` would be the sublist `c d e`.

Bracket notation can also be used to modify a list.
In the first form, the path denotes a subcomponent of the list that is replaced with the right-hand side expression's value.
In the second form, that value is appended to the existing one instead.
A path can recursively identify more deeply nested components in a list,
and may also identify record components.
If the the initial component of the path is a record access,
then the left-hand side expression must have a suitable record type instead of being a list.

**Example:**
If `l` was the list `a b c d e f`,
then `l[[2] = x]` would be the list `a b x d e f`,
and `l[2 : 3] = x y z]` would be `a b x y z e f`.
More interestingly, if `ll` was the list `a b (c d) e f`,
then `ll[[2][0] = x]` would b `a b (x d) e f`
and `ll[[2] =++ x y]` would be `a b (c d x y) e f`.

The remaining two operators return the length of a list,
and check for membership.
With the latter operator,
sequences can be used as sets.

Lists can also be formed by [iterations](#iterations).

The value of an expression using out-of-bounds indexing or slicing is undefined.
Technically, this means that it cannot be [reduced](#reduction),
even when both list and index have known values.


#### Records

Values of [record type](#record-types) can be formed and eliminated:
```
exp ::= ...
  "{" fieldexp*"," "}"                 record
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

**Example:**
If `r1` was the record `{P a b, Q eps, R {S c d}}`
and `r2` was `{P e, Q f g, R {S h}}`,
then `r1 ++ r2` would be `{P a b e, Q f g, R {S c d h}}`.

The final form is a short-hand for the latter.
It is equivalent to `exp ++ {atom exp*}`,
but is rendered in the familiar style of context extension.

In addition to these expression forms,
update `exp[path = exp]` can be applied to records
if the path's initial projection is a record access.

**Example:**
If `sr` was the record `{P a b, Q c d}`,
then `sr[.P[1] = x]` would become `{P a x, Q c d}`.
Conversely, if `rs` is the record list `{P a, Q b} {P c, Q d}`,
then `rs[[1].P = x]` would be the modified list `{P a, Q b} {P x, Q d}`.


#### Constants and Function Invocations

User-defined functions are invoked by their name and a suitable argument list:
```
exp ::= ...
  "$" defid args                       function invocation
```
The argument list can be omitted if it is empty.
This way, definitions can also be used to global constants.

**Example:**
Suppose a function `$f` was [declared](#functions) with type:
```
def $f(nat, bool) : nat
```
Then `$f(3, false)` would be an expression of type `nat`.
Similarly, the declaration
```
def $c : nat
```
allows using `$c` as a constant of type `nat`.


#### Notation

Type definitions introducing custom *notation* require expressions of analogous form:
```
exp ::= ...
  exp exp                              sequencing
  atomid                               atom
  atomop exp                           prefix atom
  exp atomop exp                       infix atom
  "`" "(" exp ")"                      bracket atoms
  "`" "[" exp "]"
  "`" "{" exp "}"
```
Sequencing can be interpreted as both a list,
as custom notation,
or as a mixture of both.

Custom notation,
which includes the use of [atoms](#constructor-types),
can only occur where the expected type is known from the context.


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
  "^" "(" varid "<" arith ")"          list of specific length with index (only in expressions)
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

**Example:**
Given a list `x*`,
the expression `{A x, B 1}*` denotes a list of records
whose field `A` is drawn from the respective element of `x*`.
The dimension of the expression must mach that of the variable.

Multiple variables can occur in an iteration,
which expresses *parallel iteration* over all the variables.
For this to be well-formed, they must all have the same dimension.
Moreover, an iteration must contain at least one variable to be well-formed.

An iteration can also contain variables not participating in the iteration.

**Example:**
If `x*` is given and a scalar `y`,
then `{A x, B y}*` inserts the same `y` for each field `B` in the resulting list of records.

The final form of iterator introduces an additional iteration variable.
Inside the iteration,
`varid` ranges from `0` to the length of the sequence minus 1.

**Example:**
Assuming a variable `x^n`,
the following example computes `$f(x, i)` for each `x` and its respective position `i` in the sequence:
```
$f(x, i)^(i<n)
```

Like overbars, iterations can nest freely,
leading to variables of higher dimension.
The nested dimensions of a variable form a *dimension vector*.

**Example:**
For example, `z**` is a list of lists, its dimension vector being `**`,
whereas `(z^3)*` (usually) implies that `z` is a list of triples, expressed as dimensions `(^3)*`.

SpecTec infers the dimension vector of each variable
and checks that its is used with consistent dimensions for every occurrence.
A variable can appear under nested iterations with different accumulated dimension vectors,
as long as the _shortest_ (possibly empty) dimension vector is a _prefix_ of all others.
That shortest common prefix is then inferred to be the actual dimension vector of the variable.

**Example:**
The expression
```
l = {A x, B y, C z}** /\ (x < 100)** /\ z <- y*
```
is inferred with dimensions `x**`, `y*`, and scalar `z` and `l`.


##### Type Checking and Inference

SpecTec checks that all expressions and definitions are consistent.
Among other things, this involves inferring and type-checking that:

* all expressions are well-typed,
* all definitions and uses of [rules](#rules) match the notation type of their respective relations,
* variable types and [dimensions](#iteration) are consistent,
* no definiton or variant case is defined multiple times,
* there is no invalid recursion between definitions of different sort.

The type system uses _bidrectional_ typing to resolve and disambiguate uses of free-form notation.
As a result, expressions with custom notation can only be used in places where the expected type is known from the surrounding context.
In some cases, SpecTec also uses _backtracking_ to find a valid typing,
especially for bare [sequence](#sequences-and-lists) expressions.

As part of this process,
SpecTec also attempts to infer the types of local variables,
if their types are not [pre-declared](#variable-declarations).

This approach to typing necessarily is incomplete,
and SpecTec may sometimes reject scripts for which it fails to find a typing.
Adding additional variable declarations often helps.

Furthermore, the type checker sometimes has to [reduce](#reduction) the arguments to [parameterised types](#type-definitions),
as well as parameterised [type aliases](#type-aliases) themselves,
in order to decide type equivalence.
This may fail to terminate due to careless use of type or function recursion.

*Note:* While type-checking, the frontend _elaborates_ (lowers) the _external language_ ([EL](EL.md)) representing the input into a more rigidly typed _internal language_ ([IL](IL.md)) suitable for consumption by code-generating backends.
This can be viewed as a form of desugaring.
The IL is unambiguous and makes all relevant information explicit,
such as recursion groups, depedency order, local variable binders and their types, uses of subtype injection, list construction, etc.


##### Reduction

SpecTec does not by itself perform any computation on expressions.
There is one exception:
due to the presence of dependent types,
i.e., expression arguments to type names,
the SpecTec [type checker](#type-checking-and-inference) sometimes has to *reduce* these expressions
in order to check the equivalence of types,
or to simplify the use of a type name defining a type family.

If reduction does not yield a specific enough term to decide equivalence or reduce a family constructor where necessary,
then type checking may fail.

Reduction also includes the application of possibly recursive [functions](#functions),
which is not guaranteed to terminate.


### Variable Declarations

Variable declarations allow to globally declare the type implicitly associated with each use of a meta-variable of that name:
```
def ::=
  "var" varid ":" typ
```

After such a declaration,
occurrences of that variable name forego [type inference](#type-checking-and-inference)
and instead are immediately resolved to the declared type.

Furthermore, SpecTec recognizes suffixes as in `x_1` or `x'`` as variations of the variable with the same type.

**Example:**
After declaring
```
var foo : nat
```
all of `foo`, `foo_1`, `foo_V`, `foo'`, and `foo''_2` will be taken to have type `nat`.

In addition to explicit variable declarations,
syntax definitions implicitly declare a variable of the same name as the type.

**Example:**
The syntax definition
```
syntax color = RED | GREEN | BLUE
```
acts as if
```
var color : color
```
had also been declared.

Syntax and variable declarations also change the status of an uppercase identifier from `atom` to `varid` when used as their declared name.

**Example:**
Declaring
```
var C : context
```
causes `C` to be treated as a variable in the rest of the script.
Similarly,
```
syntax N = nat
```
not just introduce `N` as a type synonym for `nat`,
but also allows using `N` as a variable.


### Functions

Function definitions are given by a declaration of their type and then individual equational clauses:
```
def ::=
  "def" "$" defid params ":" typ                   function declaration
  "def" "$" defid args "=" exp ("--" premise)*     function clause
```

The declaration must come first,
and before any use of the function.
The definitional clauses can follow later in the script.
Separating declarations and definitions e.g. allows expressing mutual recursion.

**Example:**
The following two functions are mutually recursive:
```
def $tik(nat) : bool
def $tok(nat) : bool

def $tik(0) = false
def $tik(n) = $tok(n - 1)

def $tok(0) = true
def $tok(n) = $tik(n - 1)
```

The clauses of a function express a (sequential) pattern match.
Their left-hand side argument expressions are interpreted as patterns
and therefore restricted in shape.
In addition, each clause can have [premises](#premises) acting as pattern guards.

The value of a function application is determined by the pattern that is matched by the argument and whose clauses all evaluate to `true`.
SpecTec assumes that the clauses of a function are *coherent*,
i.e., in case of any possible overlap in their patterns,
each choice does produce the same result.
This is not checked, however,
and the user must make sure that this property holds.

*Note:* When [reducing](#reduction) a function application itself,
The SpecTec frontend makes use of this assumption by picking the first clause that matches successfully,
even if the argument expression cannot be reduced to determine if an earlier clause matches.

**Example:**
The following function definition,
```
def $f(nat) : nat
def $f(0) = 0
def $f(n) = 1
```
violates this assumption.
The function should be reformulated as
```
def $f(nat) : nat
def $f(n) = 0  -- if n = 0
def $f(n) = 1  -- otherwise
```
to ensure that the clauses are disjoint.

The use of a [declared variable or type](#variable-declarations) in a pattern
is only matched by values included in that type.
This is relevant in the case of subtyping,
as the names of subtypes can be used as cumulative patterns denoting all possible values.

**Example:**
Assume the following syntax definitions:
```
syntax inttype = I32 | I64
syntax floattype = F32 | F64
syntax numtype = inttype | floattype
```
Both `inttype` and `floattype` are (disjoint) subtypes of `numtype`.
Then the following function can check for float types:
```
def $isfloat(numtype) : bool
def $isfloat(inttype) = false
def $isfloat(floattype) = true
```

**Recursion.**
Function definitions can be liberally *recursive*.
As is the case with recursive [type definitions](#type-definitions),
interpreting the precise semantics of such recursion is left to backends.
SpecTec itself assumes that all recursive definitions are well-founded,
but does not have any form of termination checker.
It is recommended to define recursive functions such that they can be interpreted as inductive definitions.

**Higher Order.**
Functions can take other functions as parameters,
giving rise to *higher-order* functions.
Note, however, that functions are still second-class,
that is, they can not be embedded as values.

**Example:**
The following defines a mapping function over lists of natural numbers:
```
def $map(def $f(nat) : nat, nat*) : nat*
def $map($f, eps) = eps
def $map($f, n n'*) = $f(n) $map($f, n'*)
```
(Note that such a map isn't typically needed,
since it can be expressed more succinctly using [iteration](#iterations).)

**Polymorphism.**
Functions can also take syntax types as parameters,
which allows expressing polymorphic functions.

**Example:**
The previous map function can be made polymorphic as follows:
```
def $map(syntax X, def $f(X) : X, X*) : X*
def $map(syntax X, $f, eps) = eps
def $map(syntax X, $f, x y*) = $f(x) $map(X, $f, y*)
```


### Relations and Rules

While functions are used to algorithmically compute on a meta-level,
*relations* are provided as a means for declaratively specifying semantics.

```
def ::=
  "relation" relid ":" nottyp                   relation declaration
  "rule" relid subid* ":" exp ("--" premise)*   rule
```

Relations are declared with a type that specifies their notation,
which will typically consist of a sequence of syntax types separated by atoms.
This can be used to mirror typical paper notation and drive Latex generation.

**Example:**
A typical example for declaring a typing relation could look like this:
```
relation Type_exp: ctxt |- exp : typ
```
where `ctxt`, `exp`, and `typ` are user-defined types
defining the abstract syntax of contexts, expressions, and types of the object language, respectively
(not to be confused with the `exp` and `typ` of SpecTec's meta language,
which occur in this document!).

Essentially, a relation declaration represents the definition of a judgment form,
and is then populated by *rules*.
Each corresponding rule consists of a syntactic expression of the relation's respective type,
possibly accompanied by a sequence of *premises*.

In its basic form, a premise can either be  a Boolean side condition,
or invoke another relation,
in which case the name of that relation has to be given along with an expression of a suitable type.
The use of relational judgements as premises gives rise to inductive definitions of relations.

A special premise is `otherwise`,
which represents the negation of all premises previously used for the same left-hand side.
Premises can also be iterated.

Each rule definition is headed by the name of the relation it refers to.
Furthermore, all rules must be uniquely named by a hierarchical list of sub-identifiers;
the empty list counts as a unique name itself,
that is, sub-identifiers can be omitted if, e.g., a relation only has single rule.
The sub-identifiers have no semantic relevance, but allow referring to individual rules in splices.

**Example:**
Rules for the above typing relation could take the following form,
provided `exp` and `typ` are defined as suitable variant types:
```
rule Type_exp/var:
  C |- VAR x : t
  -- if (x, t) <- C

rule Type_exp/lam:
  C |- LAMBDA x `( e ) : t_1 -> t_2
  -- Type_exp: C ++ (x, t_1) |- e : t_2

rule Type_exp/app:
  C |- APP e_1 e_2 : t
  -- Type_exp: C |- e_1 : t_2 -> t
  -- Type_exp: C |- e_2 : t_2
```

Other than checking their meta-level syntax and types,
SpecTec does not interpret the definitions of relations and their rules in any way.
*SpecTec is not a theorem prover*,
it merely is a possible *frontend* for writing definitions
from which scripts for actual theorem provers can be *generated*
(among other backends).
Any actual meta-theoretical continues to happen in such theorem provers.


### Grammars

To specify concrete syntax of a language,
SpecTec allows the definition of *attribute grammars*:

```
def ::=
  "grammar" gramid params ":" typ "=" gram      grammar definition

gram ::=
  "|"? prod+"|"

prod ::=
  sym "=>" exp ("--" premise)*

sym ::=
  gramid args
  text
  num
  "$" "(" arith ")"
  "eps"
  "(" sym ")"
  sym iter
  exp ":" sym
  sym sym
  sym "|" sym
  sym "|" "..." "|" sym
```

Each grammar declaration specifies one non-terminal of concrete syntax,
given by a list of *productions*.
Each production in turn is defined by a left-hand side,
which is the symbol sequence to parse,
and a right-hand side that computes the attribute synthesised by this production.
The type of this attribute has to be declared with the grammar.

Possible symbols include basic terminal *tokens*,
which are either text literals (for textual grammars),
or numeric values (for binary grammars).
The latter can be given either as literals,
or as arithmetic expressions escaped by `$(...)`.

Other non-terminals can be referenced by their grammar identifier.

Providing a variant of EBNF,
symbols and symbol sequences can also be iterated by one of the iterators `?`, `*`, or `+`.
Furthermore, they may contain nested alternatives separated by `|`.
A special form of alternation defines a numeric range using the notation `n | ... | m`;
in that case, both limit symbols must be numeric tokens.

Grammars can be parameterised.
Accordingly, grammar identifiers may have corresponding arguments.

Finally, a symbol may be prefixed by an *attribute pattern*.
Such a pattern takes the form of an [expression](#expressions)
that is interpreted as a pattern,
in the same way as the left-hand side of [function clauses](#functions).
This pattern is matched by the attribute synthesised by parsing the respective symbol.
Any variables occurring in the pattern are instantiated accordingly and can be used on the right.
However, bindings occurring inside a nested alternative are ignored.

**Example:**
Consider the following grammar for formulas over binary numbers
```
grammar digit : nat =
  | "0" => 0
  | "1" => 1

grammar number : nat =
  | d:digit => d
  | n:number d:digit => $(2*n + d)

grammar formula : nat =
  | n:number => n
  | n_1:formula "+" n_2:formula => $(n_1 + n_2)
  | n_1:formula "*" n_2:formula => $(n_1 * n_2)
```
The synthesised attribute is the value of the expression.

The attribute synthesised by a piece of grammar is defined as follows:
* Non-terminals produce the attribute as specified by their definion.
* Numeric tokens produce the respective natural number.
* Textual tokens produce the respective text value.
* Iterations produce the respective iteration of values.
* All other forms produce the empty tuple value.

Like with [variant types](#variant-types),
the list of productions can be split into fragments.
The individual fragments must be named uniquely using hierarchical sub-identifiers:
```
def ::=
  "grammar" gramid subid* ":" typ "=" gram-frag     grammar fragment definition

gram-frag ::=
  "..."
  ("..."? "|")? prod+"|" ("|" "...")?
```
Fragmented grammars are not currently allowed to have parameters.


### Hints

Hints are free-form annotations to SpecTec definitions of the following form:
```
hint ::=
  "hint" "(" hintid exp ")"                                 hint
```
Hints are ignored by the SpecTec frontend,
but passed on to individual backends,
which may interpret the hint identifier and the accompanying expression in any way they see fit.
For example, the [Latex backend](Latex.md) recognises `hint(show ...)` on various definitions to customise their appearance by rewriting occurrences of the respective phrase.

Expressions inside hints are enriched with the following syntax:
```
exp ::= ...
  hole                                 hole
  exp "#" exp                          textual concatenation
  "##" exp                             remove possible parentheses

hole ::=
  "%"                                  use next operand
  "%"digit*                            use numbered operand
  "%%"                                 use all operands
  "!%"                                 empty expression
  "%latex" "(" text* ")"               literal latex
```
These forms are not interpreted by the frontend,
but can be used by backends to express additional behaviour,
such as inserting argument or operand values.


## Syntax Summary

### Comments

Comments are either block (`(;...;)`) or line (`;;...\n`) comments.


### Item Lists

```
x*sep ::=
  eps
  x
  x sep x*sep
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

atomid ::= upid | "infinity" | "_|_" | "^|^"
varid ::= loid
gramid ::= id
defid ::= id
relid ::= id
ruleid ::= id
subid ::= ("/" | "-") ruleid

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
  "(" typ*"," ")"                      parentheses or tupling

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
  typ                                       alias
  contyp                                    constructor
  ("..."? "|")? casetyp+"|" ("|" "...")?    variant
  rangetyp+"|"                              range / enumeration
  "{" fieldtyp+"," ","? "}"                 record

contyp   ::= nottyp hint* ("--" premise)*
casetyp  ::= nottyp hint* ("--" premise)*
fieldtyp ::= atom typ hint* ("--" premise)*
rangetyp ::= exp | "..."

nottyp ::=
  typ                                       plain type
  atomid                                    atom
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
  "{" (atom exp)*"," "}"               record
  exp "." atom                         record access
  exp "," exp                          record extension
  exp "++" exp                         list and record composition
  exp "<-" exp                         list membership
  "|" exp "|"                          list length
  "||" gramid "||"                     expansion length
  "(" exp*"," ")"                      parentheses or tupling
  "$" defid exp?                       function invocation
  atom                                 custom token
  atomop exp                           custom operator
  exp atomop exp
  "`" "(" exp ")"                      custom brackets
  "`" "[" exp "]"
  "`" "{" exp "}"
  "$" "(" arith ")"                    escape to arithmetic syntax
  "$" numtyp "$" "(" arith ")"         numeric conversion
  hole                                 hole (for syntax rewrites in hints)
  exp "#" exp                          textual concatenation (for syntax rewrites in hints)
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
  text
  num
  "$" "(" arith ")"
  "eps"
  "(" sym*"," ")"
  sym iter
  exp ":" sym
  sym sym
  sym "|" sym
  sym "|" "..." "|" sym

prod ::=
  sym "=>" exp ("--" premise)*

gram ::=
  ("..."? "|")? prod+"|" ("|" "...")?
```


### Definitions

```
args ::= ("(" arg*"," ")")?
arg ::=
  exp
  "syntax" typ
  "grammar" sym
  "def" defid

params ::= ("(" param*"," ")")?
param ::=
  (varid ":") typ
  "syntax" synid
  "grammar" gramid ":" typ
  "def" "$" defid params ":" typ

def ::=
  "syntax" varid params hint*                               syntax declaration
  "syntax" varid subid* params hint* "=" deftyp             syntax definition
  "grammar" gramid subid* params ":" typ hint* "=" gram     grammar definition
  "relation" relid hint* ":" nottyp                         relation declaration
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

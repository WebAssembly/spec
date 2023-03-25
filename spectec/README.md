# Wasm SpecTec

Defines and implements a domain specific language (DSL) for the formal specification of Wasm.
The goal is to have a unified source that is simple to

* _read_, _write_, and code-review (simpler than Latex anyway),

* _check_ for first-level consistency,

* _process_ to generate other formats from.

Because this DSL can transport sufficient domain knowledge, various artefacts could be generated through dedicated backends:

* the _Latex_ for the formal specification for the spec document,

* the _prose_ specification pseudo-algorithms for the spec document,

* the _Coq_ and _Isabelle_ definitions for mechanisation,

* a reference _interpreter_, or parts thereof,

* a _test suite_ exercising individual rules.

Every such backend may need occasional extra guidance, so the language also includes generic syntax for uninterpreted hint annotations that each backend can hook into.


## Structure

The language consists of few generic concepts:

* _Syntax definitions_, describing the grammar of the input language or auxiliary constructs.
  These are essentially type definitions for the object language.
  For example:
  ```
  syntax valtype = | I32 | I64 | F32 | F64
  syntax functype = valtype* -> valtype*
  syntax instr = | NOP | BLOCK instr* | LOOP instr* | IF instr* ELSE instr*
  syntax context = { FUNC functype*, LABEL (valtype*)* }
  syntax config = state; instr*
  ```

* _Variable declarations_, ascribing the syntactic class (i.e., type) that meta variables used in rules range over.
  For example:
  ```
  var t : valtype
  var ft : functype
  var `C : context
  ```
  (Also, every type name is implicitly usable as a variable of the respective type.)

* _Relation declarations_, defining the shape of judgement forms, such as typing or reduction relations. These are essentially type declarations for the meta language. For example:
  ```
  relation Instr_ok: context |- instr : functype
  relation Step: config ~> config
  ```

* _Rule definitions_, expressing the individual rules defining relations. For example:
  ```
  rule Instr_ok/nop:
    `C |- NOP : epsilon -> epsilon

  rule Instr_ok/if:
    `C |- IF instr_1* ELSE instr_2* : t_1* -> t_2
    -- InstrSeq_ok: `C, LABEL t_2* |- instr_1* : t_1* -> t_2*
    -- InstrSeq_ok: `C, LABEL t_2* |- instr_2* : t_1* -> t_2*

  rule Step/nop:
    z; NOP ~> z; epsilon

  rule Step/if-true:
    z; (I32.CONST c) (IF instr_1* ELSE instr_2*) ~> z; (BLOCK instr_1*)
    -- iff c =/= 0
  rule Step/if-false:
    z; (I32.CONST c) (IF instr_1* ELSE instr_2*) ~> z; (BLOCK instr_2*)
    -- iff c = 0
  ```
  Every rule is named, so that it can be referenced.
  Each premise is introduced by a dash and includes the name of the relation it is referencing, easing checking and processing.

* _Auxiliary Functions_, allowing to abstract complex conditions into separate definitions.
  For example:
  ```
  def $size(numtype) : nat
  def $size(I32) = 32
  def $size(I64) = 64
  def $size(F32) = 32
  def $size(F64) = 64
  ```

Larger examples can be found in the [`spec` subdirectory](https://github.com/Wasm-DSL/spectec/tree/main/spectec/spec).


## Syntax

### Lists

```
list(x, sep) ::=
  epsilon
  x
  x sep list(x, sep)
```

### Literals

```
nat ::= digit+
text ::= """ utf8* """
```


### Identifiers and Atoms

```
digit ::= "0" | ... | "9"
upletter ::= "A" | ... | "Z"
loletter ::= "a" | ... | "z"

nat ::= digit+

upid ::= (upletter | "_") (upletter | digit | "_" | "." | "'")*
loid ::= (loletter | "`") (loletter | digit | "_" | "'")*
id ::= upid | loid

atomid ::= upid
varid ::= loid
defid ::= id
relid ::= id
ruleid ::= id

atom ::=
  atomid
  "_|_"

atomop ::=
  ":" | ";" | "<:"
  "|-" | "-|"
  "->" | "~>"| "=>"
  "`." | ".." | "..."
```


### Types

```
typ ::=
  varid                                type name
  "bool"                               booleans
  "nat"                                natural numbers
  "text"                               text strings
  typ iter                             iteration
  "(" list(typ, ",") ")"               parentheses or tupling

iter ::=
  "?"                                  optional
  "*"                                  list
  "+"                                  non-empty list
  "^" arith                            list of specific length
```

In addition to type expressions, custom _notation_ types can be defined:

```
deftyp ::=
  nottyp                                    free notation
  "{" list(atom typ hint*, ",") "}"         records
  "|" list(varid | atom nottyp hint*, "|")  variant

nottyp ::=
  typ                                       plain type
  atom                                      atom
  atomop nottyp                             infix atom
  nottyp atomop nottyp                      infix atom
  nottyp nottyp                             sequencing
  "(" nottyp ")"                            parenthess
  "`" "(" nottyp ")"                        custom brackets
  "`" "[" nottyp "]"
  "`" "{" nottyp "}"
  nottyp iter                               iteration
```

Custom atoms, operators and brackets are uninterpreted by the DSL semantics itself and can be used to define symbolic syntax for language or relations.
(Currently, most operators have hard-coded "natural" precedences. But these should be sufficient to emulate the kind of mixfix notation used for most relations.)


### Expressions

```
notop ::= "~"
logop ::= "/\" | "\/" | "=>"
cmpop ::= "=" | "=/=" | "<" | ">" | "<=" | ">="
exp ::=
  varid                                meta variable
  nat                                  natural number literal
  text                                 text literal
  notop exp                            logical negation
  exp logop exp                        logical connective
  exp cmpop exp                        comparison
  "epsilon"                            empty sequence
  exp exp                              sequencing
  exp iter                             iteration
  exp "[" arith "]"                    list indexing
  exp "[" arith ":" arith "]"          list slicing
  exp "[" path "=" exp "]"             list update
  exp "[" path "=.." exp "]"           list extension
  "{" list(atom exp, ",") "}"          record
  exp "." atom                         record access
  exp "," exp                          record extension
  exp "++" exp                         record composition
  "|" exp "|"                          list length
  "(" list(exp, ",") ")"               parentheses or tupling
  "$" defid exp?                       function invocation
  atom                                 custom token
  atomop exp                           custom operator
  exp atomop exp
  "`" "(" list(exp, ",") ")"           custom brackets
  "`" "[" list(exp, ",") "]"
  "`" "{" list(exp, ",") "}"
  "$" "(" arith ")"                    escape to arithmetic syntax
  "%"                                  hole (for syntax rewrites in hints)
  exp "#" exp                          token concatenation (for syntax rewrites in hints)

unop  ::= notop | "+" | "-"
binop ::= logop | "+" | "-" | "*" | "/" | "^"
arith ::=
  varid                                meta variable
  atom                                 token
  nat                                  natural number literal
  unop arith                           unary operator
  arith binop arith                    binary operator
  arith cmpop arith                    comparison
  exp "[" arith "]"                    list indexing
  "(" arith ")"                        parentheses
  "|" exp "|"                          list length
  "$" defid exp?                       function invocation

path ::=
  path? "[" arith "]"                  list element
  path? "." atom                       record element
```

The various meta notations for lists, records, and tuples mirror the syntactic conventions defined in the Wasm spec.

Arithmetic expressions are a subset of general expressions, but with different parsing and interpretation of `+`, `*`, and `^` operators.
To use arithmetic operators in a place that is not naturally arithmetic, the subexpression must be escaped as `$( ... )`.


### Definitions

```
def ::=
  "syntax" varid hint* "=" deftyp                             syntax definition
  "relation" relid hint* ":" typ                              relation declaration
  "rule" relid (("/" | "-") ruleid)* ":" exp ("--" premise)*  rule
  "var" varid ":" typ hint*                                   variable declaration
  "def" "$" defid exp? ":" typ hint*                          function declaration
  "def" "$" defid exp? "=" exp ("--" premise)?                function clause

premise ::=
  relid ":" exp                                               relational premise
  "iff" exp                                                   side condition
  "otherwise"                                                 fallback side condition
  "(" relid ":" exp ")" iter                                  iterated relational premise
  "(" "iff" exp ")" iter                                      iterated side condition

hint ::=
  "(" "hint" hintid exp ")"                                   hint
```

Syntax and variable declarations can also change the status of an uppercase identifier from `atom` to `varid` when used on the left-hand side.


### Scripts

```
script ::=
  def*
```


## Status

The implementation defines two AST representations:

* an external language (EL), suitable for backends generating latex,
* an internal language (IL), suitable for backends generating programs. 

Currently, the implementation consists of merely the frontend, which performs:

* parsing,
* multiplicity checking,
* recursion analysis,
* type checking for the EL,
* elaboration from EL into IL,
* type checking for the EL.

Lowering from EL into IL infers additional information and makes it explicit in the representation:

* resolve notational overloading and mixfix applications,
* insert injections from variant subtypes into supertypes,
* insert injections from singletons into options/lists,
* insert binders and types for local variables in rules and functions,
* mark recursion groups and group definitions with rules, ordering everything by dependency.


## Building and Running

* You will need `ocaml` and `dune` installed.

* Invoke `make` to build the executable.

* In the same place, invoke `make test` to run it on the demo files from the `spec` directory:

# Internal Language

After type-checking, SpecTec converts the input specification into a more explicit internal representation called the *IL* (internal language).
The abstract syntax tree of the IL can be printed in an easily machine-readable S-expression format by invoking SpecTec in [AST mode](Usage.md#ast-mode).

The structure of the IL is described by the following grammar.
See the description of the SpecTec [language](Language.md) for details on the constructs.

#### Literals
```
bool ::= "true" | "false"
text ::= """ char* """
id   ::= text
mixop ::= text

sign ::= "+" | "-"
nat  ::= digit+
int  ::= sign nat
rat  ::= sign? nat "/" nat
real ::= sign? nat "." nat
num  ::= "nat" nat | "int" int | "rat" rat | "real" real
```
Mixfix operators (mixop) are constructed by the frontend from the notation used in definitions of types or relations.
Essentially, they are a concatenation of the atom names occurring,
with interleaving `%` indicating the position of operands or nested expressions.
For example, the notation defined by the relation
```
relation Expr_ok: context |- exp : typ
```
will be represented by the mixfix operator `"%|-%:%"`,
applied to a triple of arguments.


#### Operators
```
unop  ::= "not" | "plus" | "minus" | "plusminus" | "minusplus"
binop ::= "and" | "or" | "impl" | "equiv" | "add" | "sub" | "mul" | "div" | "mod" | "pow"
cmpop ::= "eq" | "ne" | "lt" | "gt" | "le" | "ge"
```

#### Iterations
```
iter ::=
  "opt"                           ;; ?
  "list"                          ;; *
  "list1"                         ;; +
  "listn" exp id?                 ;; ^n, ^(i<n)
```

#### Types
```
booltyp ::= "bool"
numtyp  ::= "nat" | "int" | "rat" | "real"
texttyp ::= "text"
optyp   ::= booltyp | numtyp

typ ::=
  "var" id                        ;; t
  booltyp                         ;; bool
  numtyp                          ;; nat, int, ...
  texttyp                         ;; text
  "tup" typbind*                  ;; ( typ , ... , typ )
  "iter" typ iter                 ;; typ*, typ+, ...

deftyp ::=
  "alias" typ                     ;; typ
  "struct" typfield*              ;; { field , ... , field }
  "variant" typcase*              ;; case | ... | case

typbind  ::= "bind" exp typ
typfield ::= "field" mixop bind* typ prem*
typcase  ::= "case" mixop bind* typ prem*
```

#### Expressions
```
exp ::=
  "var" id                        ;; x
  "bool" bool                     ;; true, false
  "num"  num                      ;; 0, -2
  "text" text                     ;; "text"
  "un" unop optyp exp             ;; <op> exp
  "bin" binop optyp exp exp       ;; exp <op> exp
  "cmp" cmpop optyp exp exp       ;; exp <cmp> exp
  "idx" exp exp                   ;; exp[exp]
  "slice" exp exp exp             ;; exp[exp : exp]
  "upd" exp path exp              ;; exp[path = exp]
  "ext" exp path exp              ;; exp[path =++ exp]
  "struct" expfield*              ;; { atom exp, ... , atom exp }
  "dot" exp mixop                 ;; exp.atom
  "comp" exp exp                  ;; exp ++ exp  (on records)
  "mem" exp exp                   ;; exp <- exp
  "len" exp                       ;; |exp|
  "tup" exp*                      ;; (exp, ..., exp)
  "call" id arg*                  ;; $x(arg, ..., arg)?
  "iter" exp iter dom*            ;; exp?, exp*, ...
  "case" mixop exp                ;; atom exp
  "list" exp?                     ;; exp ... exp or [exp ... exp]
  "cat" exp exp                   ;; exp ++ exp  (on lists)

expfield ::= "field" mixop exp e

path ::=
  "root"                          ;; .
  "idx" path exp                  ;; path[exp]
  "slice" path exp exp            ;; path[exp : exp]
  "dot" path mixop                ;; path.atom

```
In addition to these explicit expressions,
the IL also contains internal expressions that are inserted by the type checker:
```
exp ::= ...
  "proj" exp nat                  ;; tuple projection exp.i
  "uncase" exp mixop              ;; inverse of "case"
  "opt" exp?                      ;; option value (eps or singletong value)
  "unopt" exp                     ;; inverse of "opt"
  "lift" exp                      ;; conversion from t? to t*
  "cvt" numtyp numtyp exp         ;; conversion from first to second numeric type
  "sub" typ typ exp               ;; subsumption from first to second type
```

Moreover, the IL explicitly annotates the variables iterated over by an iteration (its domain),
and expressions denoting the values they are drawn from:
```
dom ::= "dom" id exp              ;; x <- exp
```
For the source input, these will typically take the form `x' <- x`,
where `x'` is an auxiliary introduced by the SpecTec frontend.
However, the upshot of this representation is that it is closed under substitution:
that is, `x'` is locally bound,
while the r.h.s. can be substituted by arbitrary expressions,
for example, when rewriting or reducing a term.


#### Grammars
```
sym ::=
  "var" id arg*                   ;; x(arg, ..., arg)
  "num" nat                       ;; 0x12
  "text" text                     ;; "text"
  "eps"                           ;; eps
  "seq" sym*                      ;; sym ... sym
  "alt" sym*                      ;; sym | ... | sym
  "range" sym sym                 ;; sym | "..." | sym
  "iter" sym iter dom             ;; sym?, sym+, ...
  "attr" exp sym                  ;; exp:sym
```

#### Premises
```
prem ::=
  "rule" id mixop exp             ;; -- id: mixop-exp
  "if" exp                        ;; -- if exp
  "else"                          ;; -- otherwise
  "let" exp exp                   ;; -- if exp = exp (when one side introduces variables)
  "iter" prem iter dom            ;; -- prem*
```

#### Definitions
```
def ::=
  "typ" id param* inst*           ;; syntax x(param*) with instance definitions
  "rel" id mixop typ rule*        ;; relation x: mixop-typ with rules
  "def" id param* typ clause*     ;; def $x(param*) : typ with clauses
  "gram" id param* typ prod*      ;; grammar x(param*) : typ with productions
  "rec" def*                      ;; inferred recursion group

inst   ::= "inst" bind* arg* deftyp dt       ;; syntax _(arg*) = deftyp
rule   ::= "rule" id bind* mixop exp prem*   ;; rule _/x mixop-exp -- prem*
clause ::= "clause" bind* arg* exp* prem*    ;; def $_(arg*) = exp -- prem*
prod   ::= "prod" bind* sym exp prem*        ;; | sym => exp -- prem*

param ::=
  "exp", id typ                   ;; x : typ
  "typ", id                       ;; syntax x
  "def", id param* typ            ;; def $x(param*) : typ
  "gram", id typ                  ;; grammar x : typ

arg ::=
  "exp" exp                       ;; exp
  "typ" typ                       ;; syntax typ
  "def" id                        ;; def $x
  "gram" sym                      ;; grammar sym

bind ::=
  "exp" id typ
  "typ" id
  "def" id param* typ
  "gram" id param* typ
```
The `bind`s are binders for the free variables in a definition and are inferred by the SpecTec frontend.


#### Scripts
```
script ::= def*
```

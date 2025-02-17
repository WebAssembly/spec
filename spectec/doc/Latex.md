# Latex Generation

The SpecTec language is designed to look relatively similar to the math formulas that the Latex renderer ultimately generates,
albeit written in plain ASCII.
So in general, the outcome should be fairly predictable.
But there are a few points of note that we discuss in this document.


### Fonts

The Latex render uses 4 different font families for rendering identifiers:

* Variables and type names are rendered in italic (`mathit`).

  When an upper-case identifier is [declared](#variable-declarations) as a variable,
  it will be rendered as a variable accordingly.

* Atoms are converted to lower-case and rendered in sans-serif (`mathsf`).

* Function names are stripped of their leading `$` and rendered in serif (`mathsf`).

* Grammar names (and grammar literals) are rendered in type-writer (`mathtt`),
  after removing the first character from the name.
  (This is a hack to allow multiple grammars for the same phrase to coexist in a script
  without having to invent multiple names;
  e.g., the Wasm spec uses `Bvaltype` vs `Tvaltype`
  for binary and text format, respectively.)

* Numbers are normally rendered in the default math font.

* Numbers prefixed by `` ` `` are instead rendered like atoms.


### Subscripting

Somewhat mimicking Latex,
SpecTec interprets underscores as subscripting in a few places:

* In variable or function identifiers,
  an inner underscore (e.g., `t_1`) causes the following fragment of the identifier to be typeset as subscript —
  additional underscores (e.g., `t_i_1`) produce nested subscripts.

  Moreover, the font of the subscript may be controlled by using lower or upper case afterwards
  (e.g., `t_i` vs `t_EX`),
  rendered in variable style or atom style (after lower-casing), accordingly.

* This behaviour can be escaped by using a double underscore (`__`),
  which will then render as a single underscore.

* Atoms are an exception, where inner underscores are just rendered as underscores (e.g., `ADD_SAT`).

* In an atom,
  a *trailing* underscore causes the consecutive expression in a sequence to be type-set as a subscript
  (e.g., `LABEL_ n`).

* In addition, certain [infix operator atoms](Language.md#identifiers-and-atoms) can be suffixed with an underscore,
  which causes the consecutive expression to their right to be set as a subscript
  (e.g., `x ->_ y z`).

  The outermost parentheses around the subscripted expression will be removed.
  Add an extra layer of parentheses to force them to appear
  (e.g., `x ->_((a, b)) z` to produce `x \to_{(a, b)} z`.

* In a function identifier,
  trailing underscores cause the leading arguments to be set as a subscript,
  specifcally, as many arguments as trailing underscores
  (e.g., `$f_(i, x, y)` becomes `f_i(x, y)` in Latex,
  while `$f__(i, j, x)` becomes `f_{i, j}(x)`).

  To emulate multiple (comma-separated) subscripts,
  a tuple type can also be used as the first argument
  (e.g., `$f_((i, j), x)` to produce `f_{i, j}(x)` in Latex).

  The outermost parentheses around the subscripted argument will be removed
  (e.g., the ones enclosing the tuple).
  Add an extra layer of parentheses to force them to appear
  (e.g., `$f_((x + y))` to produce `f_{(x + y)}`).

  If there are further arguments,
  they are type-set as an argument list as usual.

* Using [show hints](#show-hints),
  more flexible customisation is possible.
  In particular, the function name `$_` that only consists of an underscore
  (and which hence renders as empty),
  can be abused to subscript arbitrary expressions.
  For example, `hint(show %#$_%)` effectively type-sets the second argument as a subscript of the first.

* As a special case, atoms with a *leading* underscore
  (e.g., `_IDX`)
  are suppressed, i.e., not rendered at all.
  This is a convenient shorthand for variant types,
  whose cases SpecTec requires to start with an atom,
  but in some cases you don't want to see that on paper.



### Line Breaks

Whitespace generally is insignificant in SpecTec,
except for line breaks in certain places:

* A line break after the comma of a record causes a line break in the rendering.

* A line break before a bar in a variant definition causes a line break in the rendering.

* A line break in an expression sequence causes a line break and some indentation in the rendering.

Additional line breaks can be forced in the layout of premises of function clauses or [clausal rules](#rules):

* The pseudo premise `----` as the first premise
  causes the all premises to be placed below the right-hand side.
  (By default, premises are placed to the right of the right-hand,
  which can take up more horizontal space than may be available.)

* A double pseudo premise `---- ----` as the first premise
  even causes all premises to be placed below the left-hand side,
  saving even more space.

  (Note: Unfortunately, this depends on the use of Latex `multicolumn`,
  which are still not available in MathJax.
  Hence, on web pages as opposed to PDF,
  the use of this feature causes some of the surrounding alignment to be lost.)

* The pseudo premise `----` between two regular premises
  causes separating vertical space to be inserted between the two.
  This can be used to group long premise lists.

In [inference rules](#rules) the layout can also be modified:

* The pseudo premise `----` between two regular premises
  causes the following premises to be placed below the preceding ones,
  allowing to arrange premises in an array of two or more rows.


### Rules

[Rules](#relations-and-rules) can be rendered in one of two ways:

* As *inference rules*,
  with the premises above the bar and the conclusion below.
  This is the default.

  The placing of premises can be controlled further via [line breaks](#line-breaks).

  **Note:** This mode of rendering is rejected if an `otherwise` premise is present!

* As *clausal rules*,
  with the conclusion on the left and the premises as side conditions on right to it.
  This is opted into by placing `hint(tabular)` on the declaration of the corresponding relation.

  The placing of the side conditions can be controlled further via [line breaks](#line-breaks).


### Hints

Some aspects of rendering can be customised by [hints](Language.md#hints).


#### Description hints (`desc`)

Hints of the form `hint(desc "text")` are recognised on syntax definitions
and define a description of the production.
The expression must be a text literal.
When rendering the respective syntax defininition with `syntax+`,
this description will show up on the left.
For example,
```
syntax valtype hint(desc "value type") =
  | numtype
  | vectype
  | reftype
```
will render as
```
(value type)  valtype ::= numtype
                        | vectype
                        | reftype
```

The description is also used in [prose](Prose.md) geenration.


#### Name hints (`name`)

Hints of the form `hint(name "text")` are recognised on relation declarations
and control how the rule names are rendered.
The expression must again be a text literal.
```
relation Instr_ok: context |- instr : functype   hint(name "T")
rule Instr_ok: C |- DROP : t -> eps

relation Step: instr* ~> instr*                  hint(name "S")
rule Step/drop: val DROP ~> eps
```
After this, the [splice](Splicing.md) `$${rule+: Instr_ok/nop}` will generate (in proper Latex)
```
------------------------ [T-drop]
C |- DROP : t -> eps
```
Similarly, the splice `$${rule+: Step/nop}` will generate
```
[S-nop]  val DROP ~> eps
```


#### Show hints (`show`)

Hints of the form `hint(show <exp>)` are recognised on a number of constructs and change how the respective definition and all its uses are rendered:

* For syntax definitions or variable declarations,
  show hints control how the variable is printed;
  in that case `<exp>` will typically be another variable name:
  ```
  syntax admininstr  hint(show instr) = ...
  ```
  If the syntax has parameters,
  show hints also control how the arguments are displayed.

  Instead of the standard form of an argument list,
  they e.g. allow printing them as sub- or superscripts or in some other form:
  ```
  syntax u(N)  hint(show u#%)
  ```
  Here, `%` represents a *hole*,
  which will be substituted by the actual argument,
  while, the operator `#` represents textual concatenation;
  see below for details.

* For a variant case or a function declaration,
  show hints control how the case is rendered;
  the expression will typically contain holes `%`,
  which are substituted by the arguments in order of appearance:
  ```
  syntax instr =
    CONST valtype c  hint(show %.CONST %)

  def $size(valtype) : nat   hint(show |%|)
  ```

  Hints on variant cases are inherited when the corresponding type is included by name in another variant type definition.

* For a record field,
  show hints control how the atom is rendered;
  the expression typically is some other replacement atom.

* For a relation declaration,
  show hints control how its rules are rendered.


##### Special Operators in Show Hints

The expression of a show int can contain additional operators:

Show hints for variant cases or function definition are expressions with two additional pieces of syntax:

* *Fuses* `exp#exp` remove spacing between two expressions.

* *Unwrap* `##exp` removes the outermost parentheses of exp, if present.

* *Holes* `%`, `%i`, `%%` are placeholders for the arguments of a definition:

  * `%0` stands for the name of the defined entity.

  * `%i` stands for the i-th argument in order of appearance,
    and starting with 1.

  * `%` is a shorthand for the *next* argument that follows the previously used hole,
    or `%1` if it is the first.

  * `%%` stands for the expression [sequence](Language.md#sequences-and-lists) consisting of the *remaining* arguments,
    starting with the one that would be `%`.

  The list of arguments is defined as follows:

  * For a syntax type, it is the list of type parameters;
    `%0` is the name of the type.

  * For a function, it is the list of function parameters;
    `%0` is the name of the function.

  * For a variant case, it is the sequence of types following the initial atom;
    `%0` is the initial atom.
    Exception: If there is no initial atom
    (e.g., because the case is defined by an infix operator atom),
    then `%0` is the initial element of the sequence.
    Moreover, if the initial atom is an infix operator,
    then a nested empty sequence is implicitly assumed to its left,
    which becomes `%0`.

  * For a relation, it works analoguously to variant cases.

* *Empty Space* `!%` stands for zero-width space,
  and is sometimes useful to provide an expression where one is required syntactically,
  but nothing should be printed.

* *Literal Latex* `%latex("text")` inserts the text as Latex source code unmodified.
  **Use with care!**
  This is considered a last resort that shoul dbe avoided if possible,
  since it may not work with future rendering backends.

**Example:**
Consider the following hints:
```
syntax instr = ...
  | CONST numtype c    hint(show %.CONST %)
  | EXTEND numtype n   hint(show %.EXTEND#%)
```
With those, the expressions `CONST f64 5` and `EXTEND i32 8` will be rendered as `f64.const 5` and `i32.extend8`, respectively.


#### Macro Hints (`macro`)

Macro hints can be used to control the names of macros generated with the [`--latex-macros` ](Usage.md#splicing-mode) option,
see the next section.


### Macros

By default, SpecTec generates plain Latex for any form of identifier,
as described [above](#fonts).
In order to allow generating cross-references or using other outside functionality,
[splicing](Usage.md#splicing-mode) can be run with the `--latex-macros` option.
In that mode, identifiers are instead rendered as Latex macro invocations `\name`.

The macro names used are derived from the identifiers:

* For syntax and variable identifiers,
  the name of the macro is the identifier
  after stripping possible suffixes like `_1`, `'`, or trailing underscores.

* For function identifiers,
  the name of the macro is the identifier
  after stripping the initial `$` and any (inner or trailing) underscores.

* For grammar identifiers,
  the name of the macro is the identifier.

* For alphanumeric atoms,
  the name of the macro is the atom identifiers
  after stripping it of any (inner or trailing) underscores and dots.

* Symbolic operator atoms are always macrofied,
  independently of the `--latex-macros` option.
  The macro name simply is respective Latex operator macro.
  An exception are punctuation atoms like commas or brackets,
  or the escaped `?`, `+`, and `*` operators,
  which do not require a macro in Latex.

The generated macros have to be defined by the user
and be included in the spliced input documents by suitable means
(which depend on whether the target of splicing is Latex or Sphinx).


**Example:**
Consider the following definitions:
```
syntax instr = NOP | LOCAL.GET | CALL_INDIRECT

def $f(nat, nat) : nat
def $f(n_1, n_2) = n_1 + n_2
```
The default macro invocations produced for this
will be `\instr`, `\NOP`, `\LOCALGET`, `\CALLINDIRECT`, `\f`, and `\n`.



#### Macro Hints

The default macro names can be overridden by macro hints.

* `hint(macro "text")` choses an alternative macro name,
  and is recognised for all definitions that bind identifiers.

  The text in the hint defines the name of the macro to produce.
  This text may contain a placeholder `%`,
  which is substituted by the default macro name.
  Hence, `hint(macro "%")` is equivalent to no hint,
  but, e.g., `hint(macro "%suffix)` appends `suffix` to the name.

* `hint(macro none)` selectively suppresses macro generation for an individual identifier,
  and is likewise recognised for all definitions that bind identifiers.

* `hint(macro "text1" "text2")` is avaliable for type definitions,
  and choses alternative macro names for both the type identifier (`text1`)
  and for all atoms in its definition (`text2`).
  The latter typically uses `%` to adapt to each case.

**Example:**
Consider the following macro hint:
```
syntax comptype hint(macro "%" "T%") =
  | STRUCT structtype
  | ARRAY arraytype
  | FUNC functype
```
It causes the declared identifiers to generate the macro names
`\comptype`, `\TSTRUCT`, `\TARRAY`, and `\TFUNC`, respectively.
This is equivalent to, but shorter than, the following option:
```
syntax comptype =
  | STRUCT structtype hint(macro "TSTRUCT")
  | ARRAY arraytype   hint(macro "TARRAY")
  | FUNC functype     hint(macro "TFUNC")
```

Macro hints also apply to symbolic operator atoms.
This way, such operators can alo be customised,
for example, to produce cross-references.

**Example:**
Consider the following:
```
syntax functype = resulttype -> resulttype hint(macro "funcarrow")

syntax limits = `[u64 .. u64] hint(macro "LIM%")
```
This will cause the arrow to generate the macro invocation `\funcarrow`
instead of the standard `\rightarrow`.
Similarly, the brackets will produce `\LIMlbrack` and `\LIMrbrack`.

For operator atoms that do not have Latex command names
(like the brackets for the `limits` type in the example),
SpecTec defines default names as follows:

* `..` — `\dotdot`
* `...` — `\dots`
* `,` — `\comma`
* `:` — `\colon`
* `;` — `\semicolon`
* `<:` — `\sub`
* `:>` — `\sup`
* `:=` — `\assign`
* ` ``?` — `\quest`
* ` ``+` — `\plus`
* ` ``*` — `\ast`
* `++` — `\cat`
* ` ``|` — `\bar`
* `(/\)` — `\bigand`
* `(\/)` — `\bigor`
* `(+)` — `\bigadd`
* `(*)` — `\bigmul`
* `(++)` — `\bigcat`
* ` ``(`, `)` — `\lparen`, `\rparen`
* ` ``[`, `]` — `\lbrack`, `\rbrack`
* ` ``{`, `}` — `\lbrace`, `\rbrace`


#### Interaction with Show Hints

Macrofication is performed *after* expanding possible [show hints](#show-hints-show).
That means that the macros generated are derived from the identifiers and atoms occurring in the expansion.

**Example:**
Consider:
```
def $lunpack(lanetype) : numtype  hint(show $unpack(%))

def $subst_all(deftype*, heaptype*) : deftype*  hint(show %#`[:=%])
```
This function sytnax will produce macro invocations for
`\unpack`, `\lbrack`, `\assign`, and `\rbrack`, respectively.

Macro hints likewise apply to the contents of the show hints.

**Example:**
Consider:
```
def $subst_all(deftype*, heaptype*) : deftype*  hint(show %#`[:=%]) hint(macro "%subst")
```
This will generate macro invocations for
`\lbracksubst`, `\assignsubst`, and `\rbracksubst`.

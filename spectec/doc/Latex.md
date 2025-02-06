# Generating Latex

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

* Grammar names and literals are rendered in type-writer (`mathtt`).

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

* Atoms are an exception, where *inner* underscores are just rendered as underscores (e.g., `ADD_SAT`).

* In an atom,
  a *trailing* underscore causes the consecutive expression in a sequence to be type-set as a subscript
  (e.g., `LABEL_ n`).

* In addition, certain infix operator atoms (currently, `->` and `=>`) can be suffixed with an underscore,
  which causes the consecutive expression to their right to be set as a subscript
  (e.g., `x ->_ y z`).

* In a function identifier,
  a trailing underscore causes the first argument to be set as a subscript
  (e.g., `$f_(i, x, y)` becomes `f_i(x, y)` in Latex).
  To emulate multiple (comma-separated) subscripts,
  use a tuple type as the first argument
  (e.g., `$f_((i, j), x)` to produce `f_{i, j}(x)` in Latex).
  The outermost parentheses around the subscripted argument will be removed
  (e.g., the ones enclosing the tuple).
  Add an extra layer of parentheses to force them to appear
  (e.g., `$f_((x + y))` to produce `f_{(x + y)}`.

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

Some aspects of rendering can be custimised by [hints](Language.md#hints).

TODO: update & extend

#### Display hints (`show`)

Hints of the form `hint(show <exp>)` are recognised on a number of constructs and change how the respective definition and all its uses are rendered:

* On a syntax definition or variable declaration they control how the variable is printed;
  in that case `<exp>` will typically be another variable name:
  ```
  syntax admininstr  hint(show instr) = ...
  ```

* On a variant case or function declaration they control how the case is rendered;
  the expression will typically be a _pattern_ containing _holes_ `%`,
  which are substituted by the arguments in order of appearance:
  ```
  syntax instr = | CONST valtype c  hint(show %.CONST %)

  def $size(valtype) : nat   hint(show |valtype|)
  ```

* on a record field they control how the atom is rendered; the expression typically is some other atom,

* on a relation declaration they control how the rule names are rendered; the expression must be a text literal:
  ```
  relation Instr_ok: context |- instr : functype   hint(show "T")
  rule Instr_ok: C |- DROP : t -> eps

  relation Step: instr* ~> instr*                  hint(show "S")
  rule Step/drop: val DROP ~> eps
  ```
  After this, the splice `$${rule+: Instr_ok/nop}` will generate (in proper Latex)
  ```
  ------------------------ [T-drop]
  C |- DROP : t -> eps
  ```
  Similarly, the splice `$${rule+: Step/nop}` will generate
  ```
  [S-nop]  val DROP ~> eps
  ```

Show hints for variant cases or function definition are expressions with two additional pieces of syntax:

* _holes_ `%` are placeholders for the real arguments of the identifier at uses sites, substituted in order of appearance,

  Arguments can also be placed out of order

* _fuses_ `exp#exp` remove spacing between two expressions.

For example, with
```
syntax instr = ...
  | CONST numtype c    hint(show %.CONST %)
  | EXTEND numtype n   hint(show %.EXTEND#%)
```
  the expressions `CONST f64 5` and `EXTEND i32 8` will be rendered as `f64.const 5` and `i32.extend8`, respectively (in proper Latex).


#### Description hints (`desc`)

Hints of the form `hint(desc <exp>)` are recognised on syntax definitions and define a description of the production. The expression must be a text literal. When rendering the respective syntax defininition with `syntax+`, this description will show up on the left. For example,
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


### Macros

TODO

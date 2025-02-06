# Generating Latex

## Rendering

The rendering of the DSL should be mostly intuitive. A few points of note:

* The use of underscores in identifiers activates rendering as subscripts (e.g. `t_1`), except in atoms, where they render as underscores -- to support Wasm keywords containing underscores. In particular, a trailing underscore in an atom or function identifier will render the first argument to this as a subscript (e.g., `LABEL_ n`, or `default_(t)`).

* Variant names with a _leading_ underscore are hidden, i.e., not rendered.

* Premises on typing rules are rendered as premises; premises on reduction rules and definitions are rendered as side conditions.

* Whitespace is insignificant except for line breaks in a few places:

  - a line break after the comma of a record causes a line break in the redering,

  - a line break before a bar in a variant definition causes a line break in the rendering,

  - an empty line between two premises in a typing rule causes a line break in the premise of the inference rule.


### Hints

Some aspects of rendering can be custimised by [hints](Language.md#definitions).


#### Display hints (`show`)

Hints of the form `hint(show <exp>)` are recognised on a number of constructs and change how the repsective definition is rendered:

* on a syntax definition or variable declaration they control how the variable is printed; `<exp>` will typically be another variable name:
  ```
  syntax admininstr  hint(show instr) = ...
  ```

* on a variant case or function declaration they control how the case is rendered; the expression will typically be a _pattern_ containing _holes_ `%`, which are substituted by the arguments in order of appearance:
  ```
  syntax instr = | CONST valtype c  hint(show %.CONST %)

  definition $size(valtype) : nat   hint(show |valtype|)
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

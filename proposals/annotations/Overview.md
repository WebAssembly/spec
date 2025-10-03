# Custom Annotation Syntax for the Wasm Text Format

## Motivation

Problem

* The Wasm binary format supports custom sections to enable associating arbitrary meta data with a Wasm module.

* No equivalent exists for the text format. In particular, there is no way to
  - represent custom sections themselves in the text format, cf. WebAssembly/design#1153 and https://gist.github.com/binji/d1cfff7faaebb2aa4f8b1c995234e5a0
  - reflect arbitrary names in the text format, cf. WebAssembly/spec#617
  - express information like for Web IDL bindings, cf. https://github.com/WebAssembly/webidl-bindings/blob/master/proposals/webidl-bindings/Explainer.md

Solution

* This proposal adds the ability to decorate a module in textual notarion with arbitrary annotations of the form `(@id ...)`.

* Neither the syntactic shape nor the semantics is prescribed by the Wasm specification, though the Appendix might include a description of optional support for name section annotations and generic custom sections.

* As an aside, the syntax of symbolic identifiers is extended to allow arbitrary strings in the form `$"..."`.

* This proposal only affects the text format, nothing else.


## Details

Extend the Text Format as follows:

* Anywhere where white space is allowed, allow *annotations* of the following form:
  ```
  annot ::= "(@"annotid  annotelem* ")"
  annotid ::= idchar+ | name
  annotelem ::= keyword | reserved | uN | sN | fN | string | id | "(" annotelem* ")"
  ```
  In other words, an annotation can contain any sequence of tokens, as long as it is well-bracketed.
  No white space is allowed as part of the initial `(@annotid` delimiter.

* The initial `annotid` is meant to be an identifier categorising the extension, and plays a role similar to the name of a custom section.
  By convention, annotations corresponding to a custom section should use the same id.

* Extend the grammar of identifiers as follows:
  ```
  id ::= "$"idchar+ | "$"name
  ```

* Elaborate identifiers to their denotation as a name, treating the unquoted form as a shorthand for the name `"idchar+"`. In all places where identifiers are compared, compare the denotated names instead. In particular, change the identifier environment `I` to record names instead of identifiers.

Extend the Appendix on the Custom Sections:

* Define annotations reflecting the Name section, which take the form of annotations `(@name "name")`.
  They may be placed after the binder for any construct that can be named by the name section.

* Define annotation syntax expressing arbitrary custom sections; cf. https://gist.github.com/binji/d1cfff7faaebb2aa4f8b1c995234e5a0

  With that, a custom section annotation is specified as follows:
  ```
  custom ::= '(' '@custom' string place? datastring ')'
  place ::=
    | '(' 'before' section ')'
    | '(' 'after' section ')'
    | '(' 'before' 'first' ')'
    | '(' 'after' 'last' ')'
  section ::=
    | 'type'
    | 'import'
    | 'func'
    | 'table'
    | 'memory'
    | 'global'
    | 'export'
    | 'start'
    | 'elem'
    | 'code'
    | 'data'
    | 'datacount'
  ```
  If placement relative to an explicit section is used, then that section must exist in the encoding of the annotated module.

  Custom section annotations that appear within module fields rather than as siblings of module fields may be ignored.

  As with any matter concerning annotations, it is up to implementations how they handle the case where an explicit custom section overlaps with individual annotations that are associated with the same custom section.


## Examples

Expressing generic custom sections (cf. https://gist.github.com/binji/d1cfff7faaebb2aa4f8b1c995234e5a0)
```wasm
(module
  (@custom "my-fancy-section" (after func) "contents-bytes")
)
```

Expressing names
```wasm
(module (@name "Gümüsü")
  (func $lambda (@name "λ") (param $x (@name "α βγ δ") i32) (result i32) (local.get $x))
)
```

Web IDL bindings (cf. https://github.com/WebAssembly/webidl-bindings/blob/master/proposals/webidl-bindings/Explainer.md)
```wasm
(module
  (func (export "f") (param i32 (@js unsigned)) ...)                        ;; argument converted as unsigned
  (func (export "method") (param $x anyref (@js this)) (param $y i32) ...)  ;; maps this to first arg
  (func (import "m" "constructor") (@js new) (param i32) (result anyref)    ;; is called as a constructor
)
```

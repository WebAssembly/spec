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

Larger examples can be found in the [`spec`](spec) subdirectory.


## Documentation

Documentation can be found in the [`doc`](doc) subdirectory.

Regarding the use of the language:

* [Source Language](doc/Language.md)
* [Latex Backend](doc/Latex.md)

Regarding the internal representations usable by backends:

* [External Language](doc/EL.md)
* [Internal Language](doc/IL.md)


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
* type checking for the EL,
* splicing expressions and definitions into files.

Lowering from EL into IL infers additional information and makes it explicit in the representation:

* resolve notational overloading and mixfix applications,
* resolve overloading of variant constructors and annotate them with their type,
* insert injections from variant subtypes into supertypes,
* insert injections from singletons into options/lists,
* insert binders and types for local variables in rules and functions,
* mark recursion groups and group definitions with rules, ordering everything by dependency.


## Building

* You will need `ocaml` and `dune` installed.

* To run tests, you will also need `pdflatex` and `sphinx-build`.

* Invoke `make` to build the executable.

* In the same place, invoke `make test` to run it on the demo files from the `spec` directory.


## Running Latex Backend

The tool can splice Latex formulas generated from, or expressed in terms of, the DSL into files. For example, invoking
```
watsup <source-files ...> -p <patch-files ...>
```
where `source-files` are the DSL files, and `patch-files` is a set of files to process (Latex, Sphinx, or other text formats), will splice Latex formulas or displaystyle definitions into the latter files.

Consider a Latex file like the following:
```
[...]
\subsection*{Syntax}

@@@{syntax: numtype vectype reftype valtype resulttype}

@@@{syntax: instr expr}


\subsection*{Typing @@{relation: Instr_ok}}

An instruction sequence @@{:instr*} is well-typed with an instruction type @@{:t_1* -> t_2*} according to the following rules:

@@@{rule: InstrSeq_ok/empty InstrSeq_ok/seq}

@@@{rule: InstrSeq_ok/weak InstrSeq_ok/frame}
[...]
```
The places to splice in formulas are indicated by _anchors_. For Latex, the two possible anchors are currently `@@` or `@@@`, which expand to `$...$` and `$$...$$`, respectively (for Sphinx, replace the anchor tokens with `$` and `$$`).

There are two forms of splices:

1. _expression splice_ (`@@{: exp }`): simply renders a DSL expression,
2. _definition splice_ (`@@{sort: id id ...}`): inserts the named definitions or rules of the indicated sort `sort` as defined in the DSL sources.

See the [documentation](doc/Latex.md) for more details.

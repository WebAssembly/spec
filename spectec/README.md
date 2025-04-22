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
    -- if c =/= 0
  rule Step/if-false:
    z; (I32.CONST c) (IF instr_1* ELSE instr_2*) ~> z; (BLOCK instr_2*)
    -- if c = 0
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


## Building

### Prerequisites

You will need `ocaml` installed with `dune`, `menhir`, `mdx`, and the `zarith` library using `opam`.

* Install `opam` version 2.0.5 or higher.
  ```
  $ apt-get install opam
  $ opam init
  ```

* Set `ocaml` as version 5.0.0 or higher.
  ```
  $ opam switch create 5.0.0
  ```
  
* Install `dune` version 3.11.0, `menhir` version 20230608, `mdx` version 2.3.1, and `zarith` version 1.13, via `opam` (default versions)
  ```
  $ opam install dune menhir mdx zarith
  ```

### Building the Project

* Invoke `make` to build the `spectec` executable.

* In the same place, invoke `make test` to run it on the demo files from the `spec` directory.


### Prerequisites for Latex and Sphinx Backends

To generate a specification document in Latex or Sphinx (to be built into pdf or html), you will also need `pdflatex` and `sphinx-build`.

* Have `python3` version 3.7 or higher with `pip3` installed.

* Install `sphinx` version 8.1.3 or higher and `six` version 1.16.0 via `pip3` (default versions).
  ```
  $ pip3 install sphinx six
  ```

* Install `texlive-full` via your package manager.
  ```
  $ apt-get install texlive-full
  ```


### Building the Spec

The core spec document in this repo is build using SpecTec by default. To build:
```
$ cd ../document/core
$ make main
```


### Example

A smaller, self-contained example for a SpecTec specification, a small document with splices, and a suitable Makefile can be found in the [example](doc/example/) directory.


### Running Interpreter Backend

To run a wast file,
```
spectec spec/* --interpreter test-interpreter/sample.wast
```

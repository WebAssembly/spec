# WebAssembly Interpreter

This repository implements a prototypical reference interpreter for WebAssembly. It is written for clarity and simplicity, _not_ speed (although it should be reasonably fast). Hopefully, it can be useful as a playground for trying out ideas and a device for nailing down the exact semantics. For that purpose, the code is written in a fairly declarative, "speccy" way.

Currently, it can

* *parse* a simple S-expression format,
* *validate* modules defined in it,
* *execute* invocations to functions exported by a module.

The file format is a (very dumb) form of *script* that cannot just define a module, but also batch a sequence of invocations.

The interpreter can also be run as a REPL, allowing to enter pieces of scripts interactively.


## Building

You'll need OCaml 4.02. The best way to get this is to download the [source tarball from our mirror of the ocaml website](https://wasm.storage.googleapis.com/ocaml-4.02.2.tar.gz) and do the configure / make dance.  On OSX, with [Homebrew](http://brew.sh/) installed, simply `brew install ocaml`.

Once you have OCaml, simply do

```
make
```
You'll get an executable named `./wasm`. This is a byte code executable. If you want a (faster) native code executable, do
```
make opt
```
To run the test suite,
```
make test
```
To do everything (advisable before committing changes),
```
make all
```
Be sure to run the latter before you upload a patch.


#### Building on Windows

We recommend a pre-built installer. With [this one](https://protz.github.io/ocaml-installer/) you have two options:

1. Bare OCaml. If you just want to build the interpreter and don't care about modifying it, you don't need to install the Cygwin core that comes with the installer. Just install OCaml itself and run
```
winmake.bat
```
in a Windows shell, which creates a program named `wasm`. Note that this will be a byte code executable only, i.e., somewhat slower.

2. OCaml + Cygwin. If you want to build a native code executable, or want to hack on the interpreter (i.e., use incremental compilation), then you need to install the Cygwin core that is included with the OCaml installer. Then you can build the interpreter using `make` in the Cygwin terminal, as described above.

Either way, in order to run the test suite you'll need to have Python installed. If you used Option 1, you can invoke the test runner `runtests.py` directly instead of doing it through `make`.


## Synopsis

You can call the executable with

```
wasm [option] [file ...]
```

where `file` is a script file (see below) to be run. If no file is given, you'll get into the REPL and can enter script commands interactively. You can also get into the REPL by explicitly passing `-` as a file name. You can do that in combination to giving a module file, so that you can then invoke its exports interactively, e.g.:

```
./wasm module.wast -
```
Note however that the REPL currently is too dumb to allow multi-line input. :)

See `wasm -h` for (the few) options.


## S-Expression Syntax

The implementation consumes a WebAssemlby AST given in S-expression syntax. Here is an overview of the grammar of types, expressions, functions, and modules, mirroring what's described in the [design doc](https://github.com/WebAssembly/design/blob/master/AstSemantics.md):

```
type: i32 | i64 | f32 | f64

value: <int> | <float>
var: <int> | $<name>

unop:  ctz | clz | popcnt | ...
binop: add | sub | mul | ...
selop: select
relop: eq | ne | lt | ...
sign: s|u
offset: offset=<uint>
align: align=(1|2|4|8|...)
cvtop: trunc_s | trunc_u | extend_s | extend_u | ...

expr:
  ( nop )
  ( block <name>? <expr>+ )
  ( if_else <expr> <expr> <expr> )
  ( if <expr> <expr> )                           ;; = (if_else <expr> <expr> (nop))
  ( br_if <expr> <var> <expr>?)                  ;; = (if_else <expr> (br <var> <expr>?) (block <expr>? (nop)))
  ( loop <name1>? <name2>? <expr>* )             ;; = (block <name1>? (loop <name2>? (block <expr>*)))
  ( br <var> <expr>? )
  ( return <expr>? )                             ;; = (br <current_depth> <expr>?)
  ( tableswitch <name>? <expr> ( table <target>* ) <target> <case>* )
  ( call <var> <expr>* )
  ( call_import <var> <expr>* )
  ( call_indirect <var> <expr> <expr>* )
  ( get_local <var> )
  ( set_local <var> <expr> )
  ( <type>.load((8|16|32)_<sign>)? <offset>? <align>? <expr> )
  ( <type>.store(8|16|32)? <offset>? <align>? <expr> <expr> )
  ( <type>.const <value> )
  ( <type>.<unop> <expr> )
  ( <type>.<binop> <expr> <expr> )
  ( <type>.<selop> <expr> <expr> <expr> )
  ( <type>.<relop> <expr> <expr> )
  ( <type>.<cvtop>/<type> <expr> )
  ( unreachable )
  ( memory_size )
  ( grow_memory <expr> )

target:
  ( case <var> )
  ( br <var> )                                   ;; = (case <name>) with (case <name> (br <var>))

case:
  ( case <name>? <expr>* )                       ;; = (case <var>? (block <expr>*))

func:   ( func <name>? <type>? <param>* <result>? <local>* <expr>* )
type:   ( type <var> )
param:  ( param <type>* ) | ( param <name> <type> )
result: ( result <type> )
local:  ( local <type>* ) | ( local <name> <type> )

module:  ( module <type>* <func>* <import>* <export>* <table>* <memory>? )
type:    ( type <name>? ( func <param>* <result>? ) )
import:  ( import <name>? "<module_name>" "<func_name>" (param <type>* ) (result <type>)* )
export:  ( export "<char>*" <var> )
table:   ( table <var>* )
memory:  ( memory <int> <int>? <segment>* )
segment: ( segment <int> "<char>*" )
```

Here, productions marked with respective comments are abbreviation forms for equivalent expansions (see the explanation of the kernel AST below).

Any form of naming via `<name>` and `<var>` (including expression labels) is merely notational convenience of this text format. The actual AST has no names, and all bindings are referred to via ordered numeric indices; consequently, names are immediately resolved in the parser and replaced by indices. Indices can also be used directly in the text format.

The segment string in the memory field is used to initialize the memory at the given offset.

Comments can be written in one of two ways:

```
comment:
  ;; <character>* <eol>
  (; (<character> | <comment>)* ;)
```

In particular, comments of the latter form nest properly.


## Scripts

In order to be able to check and run modules for testing purposes, the S-expression format is interpreted as a very simple and dumb notion of "script", with commands as follows:

```
script: <cmd>*

cmd:
  <module>                                             ;; define, validate, and initialize module
  ( invoke <name> <expr>* )                            ;; invoke export and print result
  ( assert_return (invoke <name> <expr>* ) <expr> )    ;; assert return with expected result of invocation
  ( assert_return_nan (invoke <name> <expr>* ))        ;; assert return with floating point nan result of invocation
  ( assert_trap (invoke <name> <expr>* ) <failure> )   ;; assert invocation traps with given failure string
  ( assert_invalid <module> <failure> )                ;; assert invalid module with given failure string
```

Invocation is only possible after a module has been defined.

Again, this is only a meta-level for testing, and not a part of the language proper.

The interpreter also supports a "dry" mode (flag `-d`), in which modules are only validated. In this mode, `invoke` commands are ignored (and not needed).


## Abstract Syntax and Kernel Syntax

The abstract WebAssembly syntax, as described above and in the [design doc](https://github.com/WebAssembly/design/blob/master/AstSemantics.md), is defined in [ast.ml](https://github.com/WebAssembly/spec/blob/master/ml-proto/spec/ast.ml).

However, to simplify the implementation, this AST representation is first "desugared" into a more minimal <i>kernel</i> language that is a subset of the full language. For example, conditionals with no else-branch are desugared into conditionals with `nop` for their else-branch, such that in the kernel language, all conditionals have two branches. The desugaring rules are sketched in the comments of the S-expression grammar given above.

The representation for that kernel language AST is defined in [kernel.ml](https://github.com/WebAssembly/spec/blob/master/ml-proto/spec/kernel.ml). Besides having fewer constructs, it also raises the level of abstraction further, e.g., by grouping related operators, or decomposing the syntactic structure of operators themselves.


## Implementation

The implementation consists of the following parts:

* *Abstract Syntax* (`ast.ml`, `kernel.ml`, `types.ml`, `source.ml[i]`). Notably, the `phrase` wrapper type around each AST node carries the source position information.

* *Parser* (`lexer.mll`, `parser.mly`, `desguar.ml[i]`). Generated with ocamllex and ocamlyacc. The lexer does the opcode encoding (non-trivial tokens carry e.g. type information as semantic values, as declared in `parser.mly`), the parser the actual S-expression parsing. The parser generates a full AST that is desugared into the kernel AST in a separate pass.

* *Validator* (`check.ml[i]`). Does a recursive walk of the kernel AST, passing down the *expected* type for expressions, and checking each expression against that. An expected empty type can be matched by any result, corresponding to implicit dropping of unused values (e.g. in a block).

* *Evaluator* (`eval.ml[i]`, `values.ml`, `arithmetic.ml[i]`, `int.ml`, `float.ml`, `memory.ml[i]`, and a few more). Evaluation of control transfer (`br` and `return`) is implemented using local exceptions as "labels". While these are allocated dynamically in the code and addressed via a stack, that is merely to simplify the code. In reality, these would be static jumps.

* *Driver* (`main.ml`, `script.ml[i]`, `error.ml`, `print.ml[i]`, `flags.ml`). Executes scripts, reports results or errors, etc.

The most relevant pieces are probably the validator (`check.ml`) and the evaluator (`eval.ml`). They are written to look as much like a "specification" as possible. Hopefully, the code is fairly self-explanatory, at least for those with a passing familiarity with functional programming.

In typical FP convention (and for better readability), the code tends to use single-character names for local variables where consistent naming conventions are applicable (e.g., `e` for expressions, `v` for values, `xs` for lists of `x`s, etc.). See `check.ml` and `eval.ml` for explicit comments.


## What Next?

* Binary format as input and output.

* Compilation to JS/asm.js.

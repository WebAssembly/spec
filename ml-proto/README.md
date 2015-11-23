# WebAssembly Interpreter

This repository implements a prototypical reference interpreter for WebAssembly. It is written for clarity and simplicity, _not_ speed (although it should be reasonably fast). Hopefully, it can be useful as a playground for trying out ideas and a device for nailing down the exact semantics. For that purpose, the code is written in a fairly declarative, "speccy" way.

Currently, it can

* *parse* a simple S-expression format,
* *validate* modules defined in it,
* *execute* invocations to functions exported by a module.

The file format is a (very dumb) form of *script* that cannot just define a module, but also batch a sequence of invocations.

The interpreter can also be run as a REPL, allowing to enter pieces of scripts interactively.


## Building

You'll need OCaml 4.02. The best way to get this is to download the source tarball from our mirror of the ocaml website ( https://wasm.storage.googleapis.com/ocaml-4.02.2.tar.gz ) and do the configure / make dance.  On OSX, with [Homebrew](http://brew.sh/) installed, simply `brew install ocaml`.

Once you have ocaml, simply do

```
make
```

You'll get an executable named `./wasm`.

Alternatively, you can also say:

```
ocamlbuild -Is "given, spec, host" -libs "bigarray, str" main.native
```

and get an executable named `./main.native`.


### Building on Windows

Install OCaml for Windows from the github page: https://protz.github.io/ocaml-installer/

The installer will automatically install core cygwin packages. Contrary to the directions, however, you need a set of additional packages for ocaml & ocamlbuild to work, so select them in the cygwin installer (or run cygwinsetup manually to add them after the fact):

```
make

mingw64-i686-binutils
            -gcc-core
            -gcc-g++
            -headers
            -runtime
            -windows-default-manifest
            -winpthreads

mingw64-x86_64-binutils
              -gcc-core
              -gcc-g++
              -headers
              -runtime
              -windows-default-manifest
              -winpthreads
```

The set of packages may be different on 32-bit Windows. 

The current set of prototypes does not rely on opam or ocaml packages, but be aware that opam does not work on Windows.

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
  ( block <var>? <expr>+ )
  ( if_else <expr> <expr> <expr> )
  ( if <expr> <expr> )                           ;; = (if_else <expr> <expr> (nop))
  ( br_if <expr> <var> <expr>?)                  ;; = (if_else <expr> (br <var> <expr>?) (block <expr>? (nop)))
  ( loop <var>? <var>? <expr>* )                 ;; = (block <var>? (loop <var>? (block <expr>*)))
  ( br <var> <expr>? )
  ( return <expr>? )                             ;; = (br <current_depth> <expr>?)
  ( tableswitch <var>? <expr> <switch> ( table <target>* ) <case>* )
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
  ( br <var> )                                   ;; = (case <var'>) with (case <var'> (br <var>))

case:
  ( case <var>? <expr>* )                        ;; = (case <var>? (block <expr>*))

func:   ( func <name>? <type>? <param>* <result>? <local>* <expr>* )
type:   ( type <var> )
param:  ( param <type>* ) | ( param <name> <type> )
result: ( result <type> )
local:  ( local <type>* ) | ( local <name> <type> )

module:  ( module <type>* <func>* <global>* <import>* <export>* <table>* <memory>? )
type:    ( type <name>? ( func <param>* <result>? ) )
import:  ( import <name>? "<module_name>" "<func_name>" (param <type>* ) (result <type>)* )
export:  ( export "<char>*" <var> )
global:  ( global <type>* ) | ( global <name> <type> )
table:   ( table <var>* )
memory:  ( memory <int> <int>? <segment>* )
segment: ( segment <int> "<char>*" )
```

Here, productions marked with respective comments are abbreviation forms for equivalent expansions.

The segment string is used to initialize the memory at the given offset.

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

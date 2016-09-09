# WebAssembly Interpreter

This repository implements a prototypical reference interpreter for WebAssembly. It is written for clarity and simplicity, _not_ speed (although it should be reasonably fast). Hopefully, it can be useful as a playground for trying out ideas and a device for nailing down the exact semantics. For that purpose, the code is written in a fairly declarative, "speccy" way.

Currently, it can

* *parse* a simple S-expression format,
* *decode* the binary format,
* *validate* modules defined in it,
* *execute* invocations to functions exported by a module,
* *encode* the binary format,
* *prettyprint* the S-expression format.

The S-expression format is a (very dumb) form of *script* that cannot just define a module, but in fact a sequence of them, and a batch of invocations, assertions, and conversions to each one. As such it is different from the binary format, with the additional functionality purely intended as testing infrastructure. (See [below](#scripts) for details.)

The interpreter can also be run as a REPL, allowing to enter pieces of scripts interactively.


## Building

You'll need OCaml 4.02. The best way to get this is to download the [source tarball from our mirror of the ocaml website](https://wasm.storage.googleapis.com/ocaml-4.02.2.tar.gz) and do the configure / make dance.  On OSX, with [Homebrew](http://brew.sh/) installed, simply `brew install ocaml ocamlbuild`.

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
To do everything:
```
make all
```
Before committing changes, you should do
```
make land
```
That builds `all`, plus updates `winmake.bat`.


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
wasm [option | file ...]
```

where `file`, depending on its extension, either should be an S-expression script file (see below) to be run, or a binary module file to be loaded.

By default, the interpreter validates all modules.
The `-u` option selects "unchecked mode", which skips validation and runs code as is.
Runtime type errors will be captured and reported appropriately.

A file prefixed by `-o` is taken to be an output file. Depending on its extension, this will write out the preceding module definition in either S-expression or binary format. This option can be used to convert between the two in both directions, e.g.:

```
wasm -d module.wast -o module.wasm
wasm -d module.wasm -o module.wast
```

In the second case, the produced script contains exactly one module definition.
The `-d` option selects "dry mode" and ensures that the input module is not run, even if it has a start section.
In addition, the `-u` option for "unchecked mode" can be used to convert even modules that do not validate.

Finally, the option `-e` allows to provide arbitrary script commands directly on the command line. For example:

```
wasm module.wasm -e '(invoke "foo")'
```

If neither a file nor any of the previous options is given, you'll land in the REPL and can enter script commands interactively. You can also get into the REPL by explicitly passing `-` as a file name. You can do that in combination to giving a module file, so that you can then invoke its exports interactively, e.g.:

```
wasm module.wast -
```

See `wasm -h` for (the few) additional options.


## S-Expression Syntax

The implementation consumes a WebAssembly AST given in S-expression syntax. Here is an overview of the grammar of types, expressions, functions, and modules, mirroring what's described in the [design doc](https://github.com/WebAssembly/design/blob/master/AstSemantics.md):

```
value: <int> | <float>
var: <int> | $<name>
name: (<letter> | <digit> | _ | . | + | - | * | / | \ | ^ | ~ | = | < | > | ! | ? | @ | # | $ | % | & | | | : | ' | `)+
string: "(<char> | \n | \t | \\ | \' | \" | \<hex><hex>)*"

type: i32 | i64 | f32 | f64
elem_type: anyfunc

unop:  ctz | clz | popcnt | ...
binop: add | sub | mul | ...
relop: eq | ne | lt | ...
sign: s|u
offset: offset=<nat>
align: align=(1|2|4|8|...)
cvtop: trunc_s | trunc_u | extend_s | extend_u | ...

expr:
  ( <op> )
  ( <op> <expr>+ )                                                   ;; = <expr>+ (<op>)
  ( block <name>? <instr>* )
  ( loop <name>? <instr>* )
  ( if ( then <name>? <instr>* ) ( else <name>? <instr>* )? )
  ( if <expr> ( then <name>? <instr>* ) ( else <name>? <instr>* )? ) ;; = (if <expr> (then <name>? <instr>*) (else <name>? <instr>*)?)
  ( if <expr> <expr> <expr>? )                                       ;; = (if <expr> (then <expr>) (else <expr>?))

instr:
  <expr>
  <op>                                                               ;; = (<op>)
  block <name>? <instr>* end                                         ;; = (block <name>? <instr>*)
  loop <name>? <instr>* end                                          ;; = (loop <name>? <instr>*)
  if <name>? <instr>* end                                            ;; = (if (then <name>? <instr>*))
  if <name>? <instr>* else <name>? <instr>* end                      ;; = (if (then <name>? instr>*) (else <name>? <instr>*))

op:
  unreachable
  nop
  drop
  select
  br <var>
  br_if <var>
  br_table <var>+
  return
  call <var>
  call_indirect <var>
  get_local <var>
  set_local <var>
  tee_local <var>
  <type>.const <value>
  <type>.<unop>
  <type>.<binop>
  <type>.<testop>
  <type>.<relop>
  <type>.<cvtop>/<type>
  <type>.load((8|16|32)_<sign>)? <offset>? <align>?
  <type>.store(8|16|32)? <offset>? <align>?
  current_memory
  grow_memory

func:    ( func <name>? <func_sig> <local>* <instr>* )
         ( func <name>? ( export <string> ) <func_sig> <local>* <instrr>* ) ;; = (export <string> (func <N>) (func <name>? <func_sig> <local>* <instr>*)
         ( func <name>? ( import <string> <string> ) <func_sig>)            ;; = (import <name>? <string> <string> (func <func_sig>))
param:   ( param <type>* ) | ( param <name> <type> )
result:  ( result <type> )
local:   ( local <type>* ) | ( local <name> <type> )

func_sig:   ( type <var> ) | <param>* <result>?
global_sig: <type> | ( mut <type> )
table_sig:  <nat> <nat>? <elem_type>
memory_sig: <nat> <nat>?

global:  ( global <name>? <global_sig> )
         ( global <name>? ( export <string> ) <global_sig> )                ;; = (export <string> (global <N>)) (global <name>? <global_sig>)
         ( global <name>? ( import <string> <string> ) <global_sig> )       ;; = (import <name>? <string> <string> (global <global_sig>))
table:   ( table <name>? <table_sig> )
         ( table <name>? ( export <string> ) <table_sig> )                  ;; = (export <string> (table <N>)) (table <name>? <table_sig>)
         ( table <name>? ( import <string> <string> ) <table_sig> )         ;; = (import <name>? <string> <string> (table <table_sig>))
         ( table <name>? ( export <string> )? <elem_type> ( elem <var>* ) ) ;; = (table <name>? ( export <string> )? <size> <size> <elem_type>) (elem (i32.const 0) <var>*)
elem:    ( elem (offset <instr>* ) <var>* )
         ( elem <expr> <var>* )                                             ;; = (elem (offset <expr>) <var>*)
memory:  ( memory <name>? <memory_sig> )
         ( memory <name>? ( export <string> ) <memory_sig> )                ;; = (export <string> (memory <N>)) (memory <name>? <memory_sig>)
         ( memory <name>? ( import <string> <string> ) <memory_sig> )       ;; = (import <name>? <string> <string> (memory <memory_sig>))
         ( memory <name>? ( export <string> )? ( data <string>* )           ;; = (memory <name>? ( export <string> )? <size> <size>) (data (i32.const 0) <string>*)
data:    ( data ( offset <instr>* ) <string>* )
         ( data <expr> <string>* )                                          ;; = (data (offset <expr>) <string>*)

start:   ( start <var> )

typedef: ( type <name>? ( func <funcsig> ) )

import:  ( import <string> <string> <imkind> )
imkind:  ( func <name>? <func_sig> )
         ( global <name>? <global_sig> )
         ( table <name>? <table_sig> )
         ( memory <name>? <memory_sig> )
export:  ( export <string> <exkind> )
exkind:  ( func <var> )
         ( global <var> )
         ( table <var> )
         ( memory <var> )

module:  ( module <name>? <typedef>* <func>* <import>* <export>* <table>? <memory>? <elem>* <data>* <start>? )
         ( module <name>? <string>+ )
```

Here, productions marked with respective comments are abbreviation forms for equivalent expansions (see the explanation of the AST below).
In particular, WebAssembly is a stack machine, so that all expressions of the form `(<op> <expr>+)` are merely abbreviations of a corresponding post-order sequence of instructions.
For raw instructions, the syntax allows omitting the parentheses around the operator name and its immediate operands. In the case of control operators (`block`, `loop`, `if`), this requires marking the end of the nested sequence with an explicit `end` keyword.

Any form of naming via `<name>` and `<var>` (including expression labels) is merely notational convenience of this text format. The actual AST has no names, and all bindings are referred to via ordered numeric indices; consequently, names are immediately resolved in the parser and replaced by indices. Indices can also be used directly in the text format.

A module of the form `(module <string>+)` is given in binary form and will be decoded from the (concatenation of the) strings.

The segment strings in the memory field are used to initialize the consecutive memory at the given offset.
The `<size>` in the expansion of the two short-hand forms for `table` and `memory` is the minimal size that can hold the segment: the number of `<var>`s for tables, and the accumulative length of the strings rounded up to page size for memories.

Comments can be written in one of two ways:

```
comment:
  ;; <char>* <eol>
  (; (<char> | <comment>)* ;)
```

In particular, comments of the latter form nest properly.


## Scripts

In order to be able to check and run modules for testing purposes, the S-expression format is interpreted as a very simple and dumb notion of "script", with commands as follows:

```
script: <cmd>*

cmd:
  <module>                                  ;; define, validate, and initialize module
  <action>                                  ;; perform action and print results
  ( register <string> <name>? )             ;; register module for imports
  ( assert_return <action> <expr>* )        ;; assert action has expected results
  ( assert_return_nan <action> )            ;; assert action results in NaN
  ( assert_trap <action> <failure> )        ;; assert action traps with given failure string
  ( assert_invalid <module> <failure> )     ;; assert module is invalid with given failure string
  ( assert_unlinkable <module> <failure> )  ;; assert module fails to link module with given failure string
  ( input <string> )                        ;; read script or module from file
  ( output <name>? <string>? )              ;; output module to stout or file

action:
  ( invoke <name>? <string> <expr>* )       ;; invoke function export
  ( get <name>? <string> )                  ;; get global export
```

Commands are executed in sequence. Commands taking an optional module name refer to the most recently defined module if no name is given. They are only possible after a module has been defined.

After a module is _registered_ under a string name it is available for importing in other modules.

The input and output commands determine the requested file format from the file name extension. They can handle both `.wast` and `.wasm` files. In the case of input, a `.wast` script will be recursively executed.

Again, this is only a meta-level for testing, and not a part of the language proper.

The interpreter also supports a "dry" mode (flag `-d`), in which modules are only validated. In this mode, `invoke` commands are ignored (and not needed).


## Abstract Syntax

The abstract WebAssembly syntax, as described above and in the [design doc](https://github.com/WebAssembly/design/blob/master/AstSemantics.md), is defined in [ast.ml](https://github.com/WebAssembly/spec/blob/master/ml-proto/spec/ast.ml).

However, to simplify the implementation, this AST representation represents some of the inner structure of the operators more explicitly. The mapping from the operators as given in the design doc to their structured form is defined in [operators.ml](https://github.com/WebAssembly/spec/blob/master/ml-proto/spec/operators.ml).


## Implementation

The implementation is split into three directories:

* `spec`: the part of the implementation that corresponds to the actual language specification.

* `host`: infrastructure for loading and running scripts, parsing S-expressions, and defining host environment modules.

* `given`: auxiliary libraries.

The implementation consists of the following parts:

* *Abstract Syntax* (`ast.ml`, `operators.ml`, `types.ml`, `source.ml[i]`). Notably, the `phrase` wrapper type around each AST node carries the source position information.

* *Parser* (`lexer.mll`, `parser.mly`). Generated with ocamllex and ocamlyacc. The lexer does the opcode encoding (non-trivial tokens carry e.g. type information as semantic values, as declared in `parser.mly`), the parser the actual S-expression parsing.

* *Pretty Printer* (`arrange.ml[i]`, `sexpr.ml[i]`). Turns a module AST back into the textual S-expression format.

* *Decoder*/*Encoder* (`decode.ml[i]`, `encode.ml[i]`). The former parses the binary format and turns it into an AST, the latter does the inverse.

* *Validator* (`check.ml[i]`). Does a recursive walk of the AST, passing down the *expected* type for expressions, and checking each expression against that. An expected empty type can be matched by any result, corresponding to implicit dropping of unused values (e.g. in a block).

* *Evaluator* (`eval.ml[i]`, `values.ml`, `eval_numeric.ml[i]`, `int.ml`, `float.ml`, `memory.ml[i]`, and a few more). Evaluation of control transfer (`br` and `return`) is implemented using local exceptions as "labels". While these are allocated dynamically in the code and addressed via a stack, that is merely to simplify the code. In reality, these would be static jumps.

* *Driver* (`main.ml`, `run.ml[i]`, `script.ml[i]`, `error.ml`, `print.ml[i]`, `flags.ml`). Executes scripts, reports results or errors, etc.

The most relevant pieces are probably the validator (`check.ml`) and the evaluator (`eval.ml`). They are written to look as much like a "specification" as possible. Hopefully, the code is fairly self-explanatory, at least for those with a passing familiarity with functional programming.

In typical FP convention (and for better readability), the code tends to use single-character names for local variables where consistent naming conventions are applicable (e.g., `e` for expressions, `v` for values, `xs` for lists of `x`s, etc.). See `check.ml` and `eval.ml` for explicit comments.


## What Next?

* Clean-ups.

* More tests.

* Compilation to JS/asm.js?

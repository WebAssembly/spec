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

Once you have ocaml, go to the `src` directory and simply do

```
make
```

You'll get an executable named `src/wasm`.

Alternatively, you can also say (in `src`):

```
ocamlbuild -Is "given, spec, host" -libs "bigarray, str" main.native
```

and get an executable named `src/main.native`.


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
./wasm module.wasm -
```
Note however that the REPL currently is too dumb to allow multi-line input. :)

See `wasm -h` for (the few) options.


## Language

For most part, the language understood by the interpreter is based on Ben's V8 prototype, but I took the liberty to try out a few simplifications and generalisations:

* *Expression Language.* There is no distinction between statements and expressions, everything is an expression. Some have an empty return type. Consequently, there is no need for a comma operator or ternary operator.

* *Simple Loops*. Like in Ben's prototype, there is only one sort of loop, the infinite one, which can only be terminated by an explicit `break`. In such a language, a `continue` statement actually is completely redundant, because it equivalent to a `break` to a label on the loop's *body*. So I dropped `continue`.

* *Break with Arguments.* In the spirit of a true expression language, `break` can carry arguments, which then become the result of the labelled expression it cuts to.

* *Switch with Explicit Fallthru*. By default, a switch arm is well-behaved in that it does *not* fall through to the next case. However, it can be marked as fallthru explicitly.


## Core Language vs External Language

The implementation tries to separate the concern of what is the language (and its semantics) from what is its external encoding. In that spirit, the actual AST is regular and minimal, while certain abbreviations are considered "syntactic sugar" of an external representation optimised for compactness.

For example, `if` always has an else-branch in the AST, but in the external format an else-less conditional is allowed as an abbreviation for one with `nop`. Similarly, blocks can sometimes be left implicit in sub-expressions. Furthermore, fallthru is a flag on each `switch` arm in the AST, but an explicit "opcode" in the external form.

Here, the external format is S-expressions, but similar considerations would apply to a binary encoding. That is, there would be codes for certain abbreviations, but these are just a matter of the encoding.


## Internal Syntax

The core language is defined in `ast.ml`, and looks as follows:

```
type var = int

type expr =
  | Nop                                     (* do nothing
  | Block of expr list                      (* execute in sequence
  | If of expr * expr * expr                (* conditional
  | Loop of expr                            (* infinite loop
  | Label of expr                           (* labelled expression
  | Break of int * expr option              (* break to n-th surrounding label
  | Switch of expr * arm list * expr        (* switch, latter expr is default
  | Call of var * expr list                 (* call function
  | CallImport of var * expr list           (* call imported function
  | CallIndirect of var * expr * expr list  (* call function through table
  | Return of expr option                   (* return 0 to many value
  | GetParam of var                         (* read parameter
  | GetLocal of var                         (* read local variable
  | SetLocal of var * expr                  (* write local variable
  | LoadGlobal of var                       (* read global variable
  | StoreGlobal of var * expr               (* write global variable
  | Load of loadop * expr                   (* read memory address
  | Store of storeop * expr * expr          (* write memory address
  | Const of value                          (* constant
  | Unary of unop * expr                    (* unary arithmetic operator
  | Binary of binop * expr * expr           (* binary arithmetic operator
  | Compare of relop * expr * expr          (* arithmetic comparison
  | Convert of cvt * expr                   (* conversion
  | PageSize                                (* return host-defined page_size
  | MemorySize                              (* return current size of linear memory
  | ResizeMemory                            (* resize linear memory

and arm = {value : value; expr : expr; fallthru : bool}
```

See the code for more details on the auxiliary types. It also contains ASTs for functions and modules.


## External Syntax

The S-expression syntax is defined in `parser.mly`, the opcodes in `lexer.mll`. Here is an overview of the grammar of types, expressions, functions, and modules:

```
type: i32 | i64 | f32 | f64

value: <int> | <float>
var: <int> | $<name>

unop:  ctz | clz | popcnt | ...
binop: add | sub | mul | ...
relop: eq | ne | lt | ...
sign: s|u
align: 1|2|4|8|...
cvtop: trunc_s | trunc_u | extend_s | extend_u | ...

expr:
  ( nop )
  ( block <expr>+ )
  ( if <expr> <expr> <expr> )
  ( if <expr> <expr> )                     ;; = (if <expr> <expr> (nop))
  ( loop <expr>* )                         ;; = (loop (block <expr>*))
  ( label <name>? <expr>* )                ;; = (label (block <expr>*))
  ( break <var> <expr>? )
  ( break )                                ;; = (break 0)
  ( <type>.switch <expr> <case>* <expr> )
  ( call <var> <expr>* )
  ( call_import <var> <expr>* )
  ( call_indirect <var> <expr> <expr>* )
  ( return <expr>? )
  ( get_local <var> )
  ( set_local <var> <expr> )
  ( load_global <var> )
  ( store_global <var> <expr> )
  ( <type>.load((8|16)_<sign>)?(/<align>)? <expr> )
  ( <type>.store(/<align>)? <expr> <expr> )
  ( <type>.const <value> )
  ( <type>.<unop> <expr> )
  ( <type>.<binop> <expr> <expr> )
  ( <type>.<relop> <expr> <expr> )
  ( <type>.<cvtop>/<type> <expr> )
  ( page_size )
  ( memory_size )
  ( resize_memory <expr> )

case:
  ( case <value> <expr>* fallthrough? )  ;; = (case <int> (block <expr>*) fallthrough?)
  ( case <value> )                       ;; = (case <int> (nop) fallthrough)

func:   ( func <name>? <param>* <result>? <local>* <expr>* )
param:  ( param <type>* ) | ( param <name> <type> )
result: ( result <type> )
local:  ( local <type>* ) | ( local <name> <type> )

module:  ( module <func>* <global>* <import>* <export>* <table>* <memory>? )
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
  ( assert_eq (invoke <name> <expr>* ) <expr> )        ;; assert expected results of invocation
  ( assert_trap (invoke <name> <expr>* ) <failure> )   ;; assert invocation traps with given failure string
  ( assert_invalid <module> <failure> )                ;; assert invalid module with given failure string
```

Invocation is only possible after a module has been defined.

Again, this is only a meta-level for testing, and not a part of the language proper.

The interpreter also supports a "dry" mode (flag `-d`), in which modules are only validated. In this mode, `invoke` commands are ignored (and not needed).


## Implementation

The implementation consists of the following parts:

* *Abstract Syntax* (`ast.ml`, `types.ml`, `source.ml[i]`). Notably, the `phrase` wrapper type around each AST node carries the source position information.

* *Parser* (`lexer.mll`, `parser.mly`). Generated with ocamllex and ocamlyacc. The lexer does the opcode encoding (non-trivial tokens carry e.g. type information as semantic values, as declared in `parser.mly`), the parser the actual S-expression parsing.

* *Validator* (`check.ml[i]`). Does a recursive walk of the AST, passing down the *expected* type for expressions (or rather, a list thereof, because of multi-values), and checking each expression against that. An expected empty list of types can be matched by any result, corresponding to implicit dropping of unused values (e.g. in a block).

* *Evaluator* (`eval.ml[i]`, `values.ml`, `arithmetic.ml[i]`, `memory.ml[i]`). Evaluation of control transfer (`break` and `return`) is implemented using local exceptions as "labels". While these are allocated dynamically in the code and addressed via a stack, that is merely to simplify the code. In reality, these would be static jumps.

* *Driver* (`main.ml`, `script.ml[i]`, `error.ml`, `print.ml[i]`, `flags.ml`). Executes scripts, reports results or errors, etc.

The most relevant pieces are probably the validator (`check.ml`) and the evaluator (`eval.ml`). They are written to look as much like a "specification" as possible. Hopefully, the code is fairly self-explanatory, at least for those with a passing familiarity with functional programming.

In typical FP convention (and for better readability), the code tends to use single-character names for local variables where consistent naming conventions are applicable (e.g., `e` for expressions, `v` for values, `xs` for lists of `x`s, etc.). See `check.ml` and `eval.ml` for explicit comments.


## What Next?

* TODOs: unsigned and accurate float32 arithmetics.

* Tests.

* Growable memory.

* Module imports.

* Compilation to JS/asm.js.

* Binary format as input or output?

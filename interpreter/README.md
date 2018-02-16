# WebAssembly Interpreter

This repository implements a reference interpreter for WebAssembly. It is written for clarity and simplicity, _not_ speed. It is intended as a playground for trying out ideas and a device for nailing down the exact semantics, and as a proxy for the (yet to be produced) formal specification of WebAssembly. For that purpose, the code is written in a fairly declarative, "speccy" way.

The interpreter can

* *decode*/*parse* and *validate* modules in binary or text format
* *execute* scripts with module definitions, invocations, and assertions
* *convert* between binary and text format (both directions)
* *export* test scripts to self-contained JavaScript test cases
* *run* as an interactive interpreter

The text format defines modules in S-expression syntax. Moreover, it is generalised to a (very dumb) form of *script* that can define multiples module and a batch of invocations, assertions, and conversions between them. As such it is richer than the binary format, with the additional functionality purely intended as testing infrastructure. (See [below](#scripts) for details.)


## Building

You'll need OCaml 4.02 or higher. An easy way to get this on Linux is to download the [source tarball from our mirror of the ocaml website](https://wasm.storage.googleapis.com/ocaml-4.02.2.tar.gz) and do the configure / make dance.  On macOS, with [Homebrew](http://brew.sh/) installed, simply `brew install ocaml ocamlbuild`.

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


#### Cross-compiling the Interpreter to JavaScript ####

The Makefile also provides a target to compile (parts of) the interpreter into a (Javacript library)[javascript-library]:
```
make wast.js
```
Building this target requires node.js and BuckleScript.


## Synopsis

#### Running Modules or Scripts

You can call the executable with

```
wasm [option | file ...]
```

where `file`, depending on its extension, either should be a binary (`.wasm`) or textual (`.wat`) module file to be loaded, or a script file (`.wast`, see below) to be run.

By default, the interpreter validates all modules.
The `-u` option selects "unchecked mode", which skips validation and runs code as is.
Runtime type errors will be captured and reported appropriately.

#### Converting Modules or Scripts

A file prefixed by `-o` is taken to be an output file. Depending on its extension, this will write out the preceding module definition in either S-expression or binary format. This option can be used to convert between the two in both directions, e.g.:

```
wasm -d module.wat -o module.wasm
wasm -d module.wasm -o module.wat
```

In the second case, the produced script contains exactly one module definition.
The `-d` option selects "dry mode" and ensures that the input module is not run, even if it has a start section.
In addition, the `-u` option for "unchecked mode" can be used to convert even modules that do not validate.

The interpreter can also convert entire test scripts:

```
wasm -d script.wast -o script.bin.wast
wasm -d script.wast -o script2.wast
wasm -d script.wast -o script.js
```

The first creates a new test scripts where all embedded modules are converted to binary, the second one where all are converted to textual.

The last invocation produces an equivalent, self-contained JavaScript test file.
The flag `-h` can be used to omit the test harness from the converted file;
it then is the client's responsibility to provide versions of the necessary functions.

#### Command Line Expressions

Finally, the option `-e` allows to provide arbitrary script commands directly on the command line. For example:

```
wasm module.wasm -e '(invoke "foo")'
```

#### Interactive Mode

If neither a file nor any of the previous options is given, you'll land in the REPL and can enter script commands interactively. You can also get into the REPL by explicitly passing `-` as a file name. You can do that in combination to giving a module or script file, so that you can then invoke its exports interactively, e.g.:

```
wasm module.wat -
```

See `wasm -h` for (the few) additional options.


#### JavaScript Library ####

The file `wast.js` generated by the respective (Makefile target)[cross-compiling-the-interpreter-to-javascript] is a self-contained JavaScript library for making the [S-expression syntax](s-expression-syntax) available directly within JavaScript.
It provides a global object named `WebAssemblyText` that currently provides two methods,
```
WebAssemblyText.encode(source)
```
which turns a module in S-expression syntax into a WebAssembly binary, and
```
WebAssemblyText.decode(binary, width = 80)
```
which pretty-prints a binary back into a canonicalised S-expression string.

For example:
```
let source = '(module (func (export "f") (param i32 i32) (result i32) (i32.add (get_local 0) (get_local 1))))'
let binary = WebAssemblyText.encode(source)

(new WebAssembly.Instance(new WebAssembly.Module(binary))).exports.f(3, 4)
// => 7

WebAssemblyText.decode(binary)
// =>
// (module
//   (type $0 (func (param i32 i32) (result i32)))
//   (func $0 (type 0) (get_local 0) (get_local 1) (i32.add))
//   (export "f" (func 0))
// )
```


## S-Expression Syntax

The implementation consumes a WebAssembly AST given in S-expression syntax. Here is an overview of the grammar of types, expressions, functions, and modules, mirroring what's described in the [design doc](https://github.com/WebAssembly/design/blob/master/Semantics.md).

Note: The grammar is shown here for convenience, the definite source is the [specification of the text format](https://webassembly.github.io/spec/text/).
```
num:    <digit> (_? <digit>)*
hexnum: <hexdigit> (_? <hexdigit>)*
nat:    <num> | 0x<hexnum>
int:    <nat> | +<nat> | -<nat>
float:  <num>.<num>?(e|E <num>)? | 0x<hexnum>.<hexnum>?(p|P <num>)?
name:   $(<letter> | <digit> | _ | . | + | - | * | / | \ | ^ | ~ | = | < | > | ! | ? | @ | # | $ | % | & | | | : | ' | `)+
string: "(<char> | \n | \t | \\ | \' | \" | \<hex><hex> | \u{<hex>+})*"

value:  <int> | <float>
var:    <nat> | <name>

unop:  ctz | clz | popcnt | ...
binop: add | sub | mul | ...
relop: eq | ne | lt | ...
sign:  s|u
offset: offset=<nat>
align: align=(1|2|4|8|...)
cvtop: trunc_s | trunc_u | extend_s | extend_u | ...

val_type: i32 | i64 | f32 | f64
elem_type: anyfunc
block_type : ( result <val_type>* )*
func_type:   ( type <var> )? <param>* <result>*
global_type: <val_type> | ( mut <val_type> )
table_type:  <nat> <nat>? <elem_type>
memory_type: <nat> <nat>?

expr:
  ( <op> )
  ( <op> <expr>+ )                                                   ;; = <expr>+ (<op>)
  ( block <name>? <block_type> <instr>* )
  ( loop <name>? <block_type> <instr>* )
  ( if <name>? <block_type> ( then <instr>* ) ( else <instr>* )? )
  ( if <name>? <block_tyoe> <expr>+ ( then <instr>* ) ( else <instr>* )? ) ;; = <expr>+ (if <name>? <block_type> (then <instr>*) (else <instr>*)?)

instr:
  <expr>
  <op>                                                               ;; = (<op>)
  block <name>? <block_type> <instr>* end <name>?                    ;; = (block <name>? <block_type> <instr>*)
  loop <name>? <block_type> <instr>* end <name>?                     ;; = (loop <name>? <block_type> <instr>*)
  if <name>? <block_type> <instr>* end <name>?                       ;; = (if <name>? <block_type> (then <instr>*))
  if <name>? <block_type> <instr>* else <name>? <instr>* end <name>? ;; = (if <name>? <block_type> (then <instr>*) (else <instr>*))

op:
  unreachable
  nop
  br <var>
  br_if <var>
  br_table <var>+
  return
  call <var>
  call_indirect <func_type>
  drop
  select
  get_local <var>
  set_local <var>
  tee_local <var>
  get_global <var>
  set_global <var>
  <val_type>.load((8|16|32)_<sign>)? <offset>? <align>?
  <val_type>.store(8|16|32)? <offset>? <align>?
  current_memory
  grow_memory
  <val_type>.const <value>
  <val_type>.<unop>
  <val_type>.<binop>
  <val_type>.<testop>
  <val_type>.<relop>
  <val_type>.<cvtop>/<val_type>

func:    ( func <name>? <func_type> <local>* <instr>* )
         ( func <name>? ( export <string> ) <...> )                         ;; = (export <string> (func <N>)) (func <name>? <...>)
         ( func <name>? ( import <string> <string> ) <func_type>)           ;; = (import <name>? <string> <string> (func <func_type>))
param:   ( param <val_type>* ) | ( param <name> <val_type> )
result:  ( result <val_type>* )
local:   ( local <val_type>* ) | ( local <name> <val_type> )

global:  ( global <name>? <global_type> <instr>* )
         ( global <name>? ( export <string> ) <...> )                       ;; = (export <string> (global <N>)) (global <name>? <...>)
         ( global <name>? ( import <string> <string> ) <global_type> )      ;; = (import <name>? <string> <string> (global <global_type>))
table:   ( table <name>? <table_type> )
         ( table <name>? ( export <string> ) <...> )                        ;; = (export <string> (table <N>)) (table <name>? <...>)
         ( table <name>? ( import <string> <string> ) <table_type> )        ;; = (import <name>? <string> <string> (table <table_type>))
         ( table <name>? ( export <string> )* <elem_type> ( elem <var>* ) ) ;; = (table <name>? ( export <string> )* <size> <size> <elem_type>) (elem (i32.const 0) <var>*)
elem:    ( elem <var>? (offset <instr>* ) <var>* )
         ( elem <var>? <expr> <var>* )                                      ;; = (elem <var>? (offset <expr>) <var>*)
memory:  ( memory <name>? <memory_type> )
         ( memory <name>? ( export <string> ) <...> )                       ;; = (export <string> (memory <N>))+ (memory <name>? <...>)
         ( memory <name>? ( import <string> <string> ) <memory_type> )      ;; = (import <name>? <string> <string> (memory <memory_type>))
         ( memory <name>? ( export <string> )* ( data <string>* )           ;; = (memory <name>? ( export <string> )* <size> <size>) (data (i32.const 0) <string>*)
data:    ( data <var>? ( offset <instr>* ) <string>* )
         ( data <var>? <expr> <string>* )                                   ;; = (data <var>? (offset <expr>) <string>*)

start:   ( start <var> )

typedef: ( type <name>? ( func <param>* <result>* ) )

import:  ( import <string> <string> <imkind> )
imkind:  ( func <name>? <func_type> )
         ( global <name>? <global_type> )
         ( table <name>? <table_type> )
         ( memory <name>? <memory_type> )
export:  ( export <string> <exkind> )
exkind:  ( func <var> )
         ( global <var> )
         ( table <var> )
         ( memory <var> )

module:  ( module <name>? <typedef>* <func>* <import>* <export>* <table>? <memory>? <global>* <elem>* <data>* <start>? )
         <typedef>* <func>* <import>* <export>* <table>? <memory>? <global>* <elem>* <data>* <start>?  ;; =
         ( module <typedef>* <func>* <import>* <export>* <table>? <memory>? <global>* <elem>* <data>* <start>? )
```

Here, productions marked with respective comments are abbreviation forms for equivalent expansions (see the explanation of the AST below).
In particular, WebAssembly is a stack machine, so that all expressions of the form `(<op> <expr>+)` are merely abbreviations of a corresponding post-order sequence of instructions.
For raw instructions, the syntax allows omitting the parentheses around the operator name and its immediate operands. In the case of control operators (`block`, `loop`, `if`), this requires marking the end of the nested sequence with an explicit `end` keyword.

Any form of naming via `<name>` and `<var>` (including expression labels) is merely notational convenience of this text format. The actual AST has no names, and all bindings are referred to via ordered numeric indices; consequently, names are immediately resolved in the parser and replaced by indices. Indices can also be used directly in the text format.

The segment strings in the memory field are used to initialize the consecutive memory at the given offset.
The `<size>` in the expansion of the two short-hand forms for `table` and `memory` is the minimal size that can hold the segment: the number of `<var>`s for tables, and the accumulative length of the strings rounded up to page size for memories.

In addition to the grammar rules above, the fields of a module may appear in any order, except that all imports must occur before the first proper definition of a function, table, memory, or global.

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
  <module>                                   ;; define, validate, and initialize module
  ( register <string> <name>? )              ;; register module for imports
module with given failure string
  <action>                                   ;; perform action and print results
  <assertion>                                ;; assert result of an action
  <meta>                                     ;; meta command

module:
  ...
  ( module <name>? binary <string>* )        ;; module in binary format (may be malformed)
  ( module <name>? quote <string>* )         ;; module quoted in text (may be malformed)

action:
  ( invoke <name>? <string> <expr>* )        ;; invoke function export
  ( get <name>? <string> )                   ;; get global export

assertion:
  ( assert_return <action> <expr>* )         ;; assert action has expected results
  ( assert_return_canonical_nan <action> )   ;; assert action results in NaN in a canonical form
  ( assert_return_arithmetic_nan <action> )  ;; assert action results in NaN with 1 in MSB of fraction field
  ( assert_trap <action> <failure> )         ;; assert action traps with given failure string
  ( assert_malformed <module> <failure> )    ;; assert module cannot be decoded with given failure string
  ( assert_invalid <module> <failure> )      ;; assert module is invalid with given failure string
  ( assert_unlinkable <module> <failure> )   ;; assert module fails to link
  ( assert_trap <module> <failure> )         ;; assert module traps on instantiation

meta:
  ( script <name>? <script> )                ;; name a subscript
  ( input <name>? <string> )                 ;; read script or module from file
  ( output <name>? <string>? )               ;; output module to stout or file
```
Commands are executed in sequence. Commands taking an optional module name refer to the most recently defined module if no name is given. They are only possible after a module has been defined.

After a module is _registered_ under a string name it is available for importing in other modules.

The script format supports additional syntax for defining modules.
A module of the form `(module binary <string>*)` is given in binary form and will be decoded from the (concatenation of the) strings.
A module of the form `(module quote <string>*)` is given in textual form and will be parsed from the (concatenation of the) strings. In both cases, decoding/parsing happens when the command is executed, not when the script is parsed, so that meta commands like `assert_malformed` can be used to check expected errors.

There are also a number of meta commands.
The `script` command is a simple mechanism to name sub-scripts themselves. This is mainly useful for converting scripts with the `output` command. Commands inside a `script` will be executed normally, but nested meta are expanded in place (`input`, recursively) or elided (`output`) in the named script.

The `input` and `output` meta commands determine the requested file format from the file name extension. They can handle both `.wasm`, `.wat`, and `.wast` files. In the case of input, a `.wast` script will be recursively executed. Output additionally handles `.js` as a target, which will convert the referenced script to an equivalent, self-contained JavaScript runner. It also recognises `.bin.wast` specially, which creates a script where module definitions are in binary.

The interpreter supports a "dry" mode (flag `-d`), in which modules are only validated. In this mode, all actions and assertions are ignored.
It also supports an "unchecked" mode (flag `-u`), in which module definitions are not validated before use.

## Abstract Syntax

The abstract WebAssembly syntax, as described above and in the [design doc](https://github.com/WebAssembly/design/blob/master/Semantics.md), is defined in [ast.ml](syntax/ast.ml).

However, to simplify the implementation, this AST representation represents some of the inner structure of the operators more explicitly. The mapping from the operators as given in the design doc to their structured form is defined in [operators.ml](syntax/operators.ml).


## Implementation

The implementation is split into several directories:

* `syntax`: the definition of abstract syntax; corresponds to the "Structure" section of the language specification

* `valid`: validation of code and modules; corresponds to the "Validation" section of the language specification

* `runtime`: the definition of runtime structures; corresponds to the "Execution/Runtime" section of the language specification

* `exec`: execution and module instantiation; corresponds to the "Execution" section of the language specification

* `binary`: encoding and decoding of the binary format; corresponds to the "Binary Format" section of the language specification

* `text`: parsing and printing the S-expressions text format; corresponds to the "Text Format" section of the language specification

* `script`: abstract syntax and execution of the extended script language

* `host`: definition of host environment modules

* `main`: main program

* `util`: utility libraries.

The implementation consists of the following parts:

* *Abstract Syntax* (`ast.ml`, `operators.ml`, `types.ml`, `source.ml[i]`, `script.ml`). Notably, the `phrase` wrapper type around each AST node carries the source position information.

* *Parser* (`lexer.mll`, `parser.mly`, `parse.ml[i]`). Generated with ocamllex and ocamlyacc. The lexer does the opcode encoding (non-trivial tokens carry e.g. type information as semantic values, as declared in `parser.mly`), the parser the actual S-expression parsing.

* *Pretty Printer* (`print.ml[i]`, `arrange.ml[i]`, `sexpr.ml[i]`). Turns a module or script AST back into the textual S-expression format.

* *Decoder*/*Encoder* (`decode.ml[i]`, `encode.ml[i]`). The former parses the binary format and turns it into an AST, the latter does the inverse.

* *Validator* (`valid.ml[i]`). Does a recursive walk of the AST, passing down the *expected* type for expressions, and checking each expression against that. An expected empty type can be matched by any result, corresponding to implicit dropping of unused values (e.g. in a block).

* *Evaluator* (`eval.ml[i]`, `values.ml`, `func.ml[i]`, `table.ml[i]`, `memory.ml[i]`, `global.ml[i]`, `instance.ml`, `eval_numeric.ml[i]`, `int.ml`, `float.ml`, and a few more). Implements evaluation as a small-step semantics that rewrites a program one computation step at a time.

* *JS Generator* (`js.ml[i]`). Converts a script to equivalent JavaScript.

* *Driver* (`main.ml`, `run.ml[i]`, `import.ml[i]`, `error.ml`, `flags.ml`). Executes scripts, reports results or errors, etc.

The most relevant pieces are probably the validator (`valid.ml`) and the evaluator (`eval.ml`). They are written to look as much like a "specification" as possible. Hopefully, the code is fairly self-explanatory, at least for those with a passing familiarity with functional programming.

In typical FP convention (and for better readability), the code tends to use single-character names for local variables where consistent naming conventions are applicable (e.g., `e` for expressions, `v` for values, `xs` for lists of `x`s, etc.). See `ast.ml`, `eval.ml` and `eval.ml` for more comments.

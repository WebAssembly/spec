# WebAssembly Reference Interpreter

This repository implements an interpreter for WebAssembly. It is written for clarity and simplicity, _not_ speed. It is intended as a playground for trying out ideas and a device for nailing down their exact semantics. For that purpose, the code is written in a fairly declarative, "speccy" way.

The interpreter can

* *decode*/*parse* and *validate* modules in binary or text format
* *execute* scripts with module definitions, invocations, and assertions
* *convert* between binary and text format (both directions)
* *export* test scripts to self-contained JavaScript test cases
* *run* as an interactive interpreter

The text format defines modules in S-expression syntax. Moreover, it is generalised to a form of *script* that can define multiples module and a batch of invocations, assertions, and conversions between them. As such it is richer than the binary format, with the additional functionality purely intended as testing infrastructure. (See [below](#scripts) for details.)


## Building

You'll need OCaml 4.12 or higher. Instructions for installing a recent version of OCaml on multiple platforms are available [here](https://ocaml.org/docs/install.html). On most platforms, the recommended way is through [OPAM](https://ocaml.org/docs/install.html#OPAM).

You'll also need to install the dune build system. See the [installation instructions](https://github.com/ocaml/dune#installation-1).

Once you have OCaml, simply do

```
make
```
You'll get an executable named `./wasm`.
To run the test suite,
```
make test
```
To do everything:
```
make all
```

#### Building on Windows

The instructions depend on how you [installed OCaml on Windows](https://ocaml.org/docs/install.html#Windows).

1. *Cygwin*: If you want to build a native code executable, or want to hack on the interpreter (i.e., use incremental compilation), then you need to install the Cygwin core that is included with the OCaml installer. Then you can build the interpreter using `make` in the Cygwin terminal, as described above.

2. *Windows Subsystem for Linux* (WSL): You can build the interpreter using `make`, as described above.

In any way, in order to run the test suite you'll need to have Python installed. If you used Option 3, you can invoke the test runner `runtests.py` directly instead of doing it through `make`.



#### Cross-compiling the Interpreter to JavaScript ####

The Makefile also provides a target to compile (parts of) the interpreter into a [JavaScript library](#javascript-library):
```
make wast.js
```
Building this target requires `js_of_ocaml`, which can be installed with OPAM:
```
opam install js_of_ocaml js_of_ocaml-ppx
```


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

The file `wast.js` generated by the respective [Makefile target](#cross-compiling-the-interpreter-to-javascript) is a self-contained JavaScript library for making the [S-expression syntax](#s-expression-syntax) available directly within JavaScript.
It provides a global object named `WebAssemblyText` that currently provides two methods,
```
WebAssemblyText.encode(source)
```
which turns a module in S-expression syntax into a WebAssembly binary, and
```
WebAssemblyText.decode(binary, width)
```
which pretty-prints a binary back into a canonicalised S-expression string.

For example:
```
let source = '(module (func (export "f") (param i32 i32) (result i32) (i32.add (local.get 0) (local.get 1))))'
let binary = WebAssemblyText.encode(source)

(new WebAssembly.Instance(new WebAssembly.Module(binary))).exports.f(3, 4)
// => 7

WebAssemblyText.decode(binary, 80)
// =>
// (module
//   (type $0 (func (param i32 i32) (result i32)))
//   (func $0 (type 0) (local.get 0) (local.get 1) (i32.add))
//   (export "f" (func 0))
// )
```

Depending on how you load the library, the object may be accessed in different ways. For example, using `require` in node.js:

```
let wast = require("./wast.js");
let binary = wast.WebAssemblyText.encode("(module)");
```

Or using `load` from a JavaScript shell:

```
load("./wast.js");
let binary = WebAssemblyText.encode("(module)");
```


## S-Expression Syntax

The implementation consumes a WebAssembly AST given in S-expression syntax. Here is an overview of the grammar of types, expressions, functions, and modules, mirroring what's described in the [design doc](https://github.com/WebAssembly/design/blob/main/Semantics.md).

Note: The grammar is shown here for convenience, the definite source is the [specification of the text format](https://webassembly.github.io/spec/core/text/).
```
num:    <digit>(_? <digit>)*
hexnum: <hexdigit>(_? <hexdigit>)*
nat:    <num> | 0x<hexnum>
int:    <nat> | +<nat> | -<nat>
float:  <num>.<num>?(e|E <num>)? | 0x<hexnum>.<hexnum>?(p|P <num>)?
name:   $(<letter> | <digit> | _ | . | + | - | * | / | \ | ^ | ~ | = | < | > | ! | ? | @ | # | $ | % | & | | | : | ' | `)+
string: "(<char> | \n | \t | \\ | \' | \" | \<hex><hex> | \u{<hex>+})*"

num_type: i32 | i64 | f32 | f64
vec_type: v128
vec_shape: i8x16 | i16x8 | i32x4 | i64x2 | f32x4 | f64x2 | v128
heap_type: func | extern | (type <var>)
ref_type:
  ( ref null? <heap_type> )
  ( ref null? <var> )         ;; = (ref null (type <var>))
  funcref                     ;; = (ref null func)
  externref                   ;; = (ref null extern)
val_type: <num_type> | <vec_type> | <ref_type>
block_type : ( result <val_type>* )*
func_type:   ( type <var> )? <param>* <result>*
global_type: <val_type> | ( mut <val_type> )
table_type:  <nat> <nat>? <ref_type>
memory_type: <nat> <nat>?

num: <int> | <float>
var: <nat> | <name>

unop:  ctz | clz | popcnt | ...
binop: add | sub | mul | ...
testop: eqz
relop: eq | ne | lt | ...
sign:  s | u
offset: offset=<nat>
align: align=(1|2|4|8|...)
cvtop: trunc | extend | wrap | ...
vecunop: abs | neg | ...
vecbinop: add | sub | min_<sign> | ...
vecternop: bitselect
vectestop: all_true | any_true
vecrelop: eq | ne | lt | ...
veccvtop: extend_low | extend_high | trunc_sat | ...
vecshiftop: shl | shr_<sign>

expr:
  ( <op> )
  ( <op> <expr>+ )                                                   ;; = <expr>+ (<op>)
  ( block <name>? <block_type> <instr>* )
  ( loop <name>? <block_type> <instr>* )
  ( if <name>? <block_type> ( then <instr>* ) ( else <instr>* )? )
  ( if <name>? <block_type> <expr>+ ( then <instr>* ) ( else <instr>* )? ) ;; = <expr>+ (if <name>? <block_type> (then <instr>*) (else <instr>*)?)

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
  drop
  select
  br <var>
  br_if <var>
  br_table <var>+
  br_on_null <var>
  br_on_non_null <var>
  call <var>
  call_ref <var>
  call_indirect <var>? (type <var>)? <func_type>
  return
  return_call <var>
  return_call_ref <var>
  return_call_indirect <var>? (type <var>)? <func_type>
  local.get <var>
  local.set <var>
  local.tee <var>
  global.get <var>
  global.set <var>
  table.get <var>?
  table.set <var>?
  table.size <var>?
  table.grow <var>?
  table.fill <var>?
  table.copy <var>? <var>?
  table.init <var>? <var>
  elem.drop <var>
  <num_type>.load((8|16|32)_<sign>)? <offset>? <align>?
  <num_type>.store(8|16|32)? <offset>? <align>?
  <vec_type>.load((8x8|16x4|32x2)_<sign>)? <offset>? <align>?
  <vec_type>.store <offset>? <align>?
  <vec_type>.load(8|16|32|64)_(lane|splat|zero) <offset>? <align>?
  <vec_type>.store(8|16|32|64)_lane <offset>? <align>?
  memory.size
  memory.grow
  memory.fill
  memory.copy
  memory.init <var>
  data.drop <var>
  ref.null <heap_type>
  ref.is_null
  ref_as_non_null
  ref.func <var>
  <num_type>.const <num>
  <num_type>.<unop>
  <num_type>.<binop>
  <num_type>.<testop>
  <num_type>.<relop>
  <num_type>.<cvtop>_<num_type>(_<sign>)?
  <vec_type>.const <vec_shape> <num>+
  <vec_shape>.<vecunop>
  <vec_shape>.<vecbinop>
  <vec_shape>.<vecternop>
  <vec_shape>.<vectestop>
  <vec_shape>.<vecrelop>
  <vec_shape>.<veccvtop>_<vec_shape>(_<sign>)?(_<zero>)?
  <vec_shape>.<vecshiftop>
  <vec_shape>.bitmask
  <vec_shape>.splat
  <vec_shape>.extract_lane(_<sign>)? <nat>
  <vec_shape>.replace_lane <nat>

func:    ( func <name>? <func_type> <local>* <instr>* )
         ( func <name>? ( export <string> ) <...> )                         ;; = (export <string> (func <N>)) (func <name>? <...>)
         ( func <name>? ( import <string> <string> ) <func_type>)           ;; = (import <string> <string> (func <name>? <func_type>))
param:   ( param <val_type>* ) | ( param <name> <val_type> )
result:  ( result <val_type>* )
local:   ( local <val_type>* ) | ( local <name> <val_type> )

global:  ( global <name>? <global_type> <instr>* )
         ( global <name>? ( export <string> ) <...> )                       ;; = (export <string> (global <N>)) (global <name>? <...>)
         ( global <name>? ( import <string> <string> ) <global_type> )      ;; = (import <string> <string> (global <name>? <global_type>))
table:   ( table <name>? <table_type> )
         ( table <name>? ( export <string> ) <...> )                        ;; = (export <string> (table <N>)) (table <name>? <...>)
         ( table <name>? ( import <string> <string> ) <table_type> )        ;; = (import <string> <string> (table <name>? <table_type>))
         ( table <name>? ( export <string> )* <ref_type> ( elem <var>* ) )  ;; = (table <name>? ( export <string> )* <size> <size> <ref_type>) (elem (i32.const 0) <var>*)
elem:    ( elem <var>? (offset <instr>* ) <var>* )
         ( elem <var>? <expr> <var>* )                                      ;; = (elem <var>? (offset <expr>) <var>*)
         ( elem <var>? declare <ref_type> <var>* )
elem:    ( elem <name>? ( table <var> )? <offset> <ref_type> <item>* )
         ( elem <name>? ( table <var> )? <offset> func <var>* )             ;; = (elem <name>? ( table <var> )? <offset> funcref (ref.func <var>)*)
         ( elem <var>? declare? <ref_type> <var>* )
         ( elem <name>? declare? func <var>* )                               ;; = (elem <name>? declare? funcref (ref.func <var>)*)
offset:  ( offset <instr>* )
         <expr>                                                             ;; = ( offset <expr> )
item:    ( item <instr>* )
         <expr>                                                             ;; = ( item <expr> )
memory:  ( memory <name>? <memory_type> )
         ( memory <name>? ( export <string> ) <...> )                       ;; = (export <string> (memory <N>))+ (memory <name>? <...>)
         ( memory <name>? ( import <string> <string> ) <memory_type> )      ;; = (import <string> <string> (memory <name>? <memory_type>))
         ( memory <name>? ( export <string> )* ( data <string>* ) )         ;; = (memory <name>? ( export <string> )* <size> <size>) (data (i32.const 0) <string>*)
data:    ( data <name>? ( memory <var> )? <offset> <string>* )

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

module:  ( module <name>? <typedef>* <func>* <import>* <export>* <table>* <memory>? <global>* <elem>* <data>* <start>? )
         <typedef>* <func>* <import>* <export>* <table>* <memory>? <global>* <elem>* <data>* <start>?  ;; =
         ( module <typedef>* <func>* <import>* <export>* <table>* <memory>? <global>* <elem>* <data>* <start>? )
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

In order to be able to check and run modules for testing purposes, the S-expression format is interpreted as a very simple notion of "script", with commands as follows:

```
script: <cmd>*

cmd:
  <module>                                   ;; define, validate, and initialize module
  ( register <string> <name>? )              ;; register module for imports
  <action>                                   ;; perform action and print results
  <assertion>                                ;; assert result of an action
  <meta>                                     ;; meta command

module:
  ...
  ( module <name>? binary <string>* )        ;; module in binary format (may be malformed)
  ( module <name>? quote <string>* )         ;; module quoted in text (may be malformed)

action:
  ( invoke <name>? <string> <const>* )       ;; invoke function export
  ( get <name>? <string> )                   ;; get global export

const:
  ( <num_type>.const <num> )                 ;; number value
  ( <vec_type> <vec_shape> <num>+ )          ;; vector value
  ( ref.null <ref_kind> )                    ;; null reference
  ( ref.extern <nat> )                       ;; host reference

assertion:
  ( assert_return <action> <result_pat>* )   ;; assert action has expected results
  ( assert_trap <action> <failure> )         ;; assert action traps with given failure string
  ( assert_exhaustion <action> <failure> )   ;; assert action exhausts system resources
  ( assert_malformed <module> <failure> )    ;; assert module cannot be decoded with given failure string
  ( assert_invalid <module> <failure> )      ;; assert module is invalid with given failure string
  ( assert_unlinkable <module> <failure> )   ;; assert module fails to link
  ( assert_trap <module> <failure> )         ;; assert module traps on instantiation

result_pat:
  ( <num_type>.const <num_pat> )
  ( <vec_type>.const <vec_shape> <num_pat>+ )
  ( ref.extern )
  ( ref.func )
  ( ref.null )

num_pat:
  <num>                                      ;; literal result
  nan:canonical                              ;; NaN in canonical form
  nan:arithmetic                             ;; NaN with 1 in MSB of payload

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

The `input` and `output` meta commands determine the requested file format from the file name extension. They can handle both `.wasm`, `.wat`, and `.wast` files. In the case of input, a `.wast` script will be recursively executed. Output additionally handles `.js` as a target, which will convert the referenced script to an equivalent, self-contained JavaScript runner. It also recognises `.bin.wast` specially, which creates a _binary script_ where module definitions are in binary, as defined below.

The interpreter supports a "dry" mode (flag `-d`), in which modules are only validated. In this mode, all actions and assertions are ignored.
It also supports an "unchecked" mode (flag `-u`), in which module definitions are not validated before use.


### Spectest host module

When running scripts, the interpreter predefines a simple host module named `"spectest"` that has the following module type:
```
(module
  (global (export "global_i32") i32)
  (global (export "global_i64") i64)
  (global (export "global_f32") f32)
  (global (export "global_f64") f64)

  (table (export "table") 10 20 funcref)

  (memory (export "memory") 1 2)

  (func (export "print"))
  (func (export "print_i32") (param i32))
  (func (export "print_i64") (param i64))
  (func (export "print_f32") (param f32))
  (func (export "print_f64") (param f64))
  (func (export "print_i32_f32") (param i32 f32))
  (func (export "print_f64_f64") (param f64 f64))
)
```
The `print` functions are assumed to print their respective argument values to stdout (followed by a newline) and can be used to produce observable output.

Note: This module predates the `register` command and should no longer be needed for new tests.
We might remove it in the future, so consider it deprecated.


### Binary Scripts

The grammar of binary scripts is a subset of the grammar for general scripts:
```
binscript: <cmd>*

cmd:
  <module>                                   ;; define, validate, and initialize module
  ( register <string> <name>? )              ;; register module for imports
  <action>                                   ;; perform action and print results
  <assertion>                                ;; assert result of an action

module:
  ( module <name>? binary <string>* )        ;; module in binary format (may be malformed)

action:
  ( invoke <name>? <string> <expr>* )        ;; invoke function export
  ( get <name>? <string> )                   ;; get global export

assertion:
  ( assert_return <action> <result_pat>* )   ;; assert action has expected results
  ( assert_trap <action> <failure> )         ;; assert action traps with given failure string
  ( assert_exhaustion <action> <failure> )   ;; assert action exhausts system resources
  ( assert_malformed <module> <failure> )    ;; assert module cannot be decoded with given failure string
  ( assert_invalid <module> <failure> )      ;; assert module is invalid with given failure string
  ( assert_unlinkable <module> <failure> )   ;; assert module fails to link
  ( assert_trap <module> <failure> )         ;; assert module traps on instantiation

result_pat:
  ( <num_type>.const <num_pat> )
  ( ref.extern )
  ( ref.func )
  ( ref.null )

num_pat:
  <value>                                    ;; literal result
  nan:canonical                              ;; NaN in canonical form
  nan:arithmetic                             ;; NaN with 1 in MSB of payload

value:  <int> | <float>
int:    0x<hexnum>
float:  0x<hexnum>.<hexnum>?(p|P <num>)?
hexnum: <hexdigit>(_? <hexdigit>)*

name:   $(<letter> | <digit> | _ | . | + | - | * | / | \ | ^ | ~ | = | < | > | ! | ? | @ | # | $ | % | & | | | : | ' | `)+
string: "(<char> | \n | \t | \\ | \' | \" | \<hex><hex> | \u{<hex>+})*"
```
This grammar removes meta commands, textual and quoted modules.
All numbers are in hex notation.

Moreover, float values are required to be precise, that is, they may not contain bits that would lead to rounding.


## Abstract Syntax

The abstract WebAssembly syntax, as described above and in the [design doc](https://github.com/WebAssembly/design/blob/main/Semantics.md), is defined in [ast.ml](syntax/ast.ml).

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

# Typed Function References for WebAssembly

## Introduction

This proposal adds function references that are typed and can be called directly. Unlike `funcref` and the existing `call_indirect` instruction, typed function references need not be stored into a table to be called (though they can). A typed function reference can be formed from any function index.

The proposal distinguished regular and nullable function reference. The former cannot be null, and a call through them does not require any runtime check.

The proposal has instructions for producing and consuming (calling) function references. It also includes instruction for testing and converting between regular and nullable references.

Typed references have no canonical default value, because they cannot be null. To enable storing them in locals, which so far depend on default values for initialisation, the proposal also introduces a new instruction `let` for block-scoped locals whose initialisation values are taken from the operand stack.

In addition to the above, we could also decide to include an instruction for forming a *closure* from a function reference, which takes a prefix of the function's arguments and returns a new function reference with those parameters bound. (Hence, conceptually, all function references would be closures of 0 or more parameters.)

Note: In a Wasm engine, function references (whether first-class or as table entries) are already a form of closure since they must close over a specific module instance (its globals, tables, memory, etc) while their code is shared across multiple instances of the same module. It is hence expected that the ability to form language-level closures is not an observable extra cost.


### Motivation

* Enable efficient indirect function calls without runtime checks

* Represent first-class function pointers without the need for tables

* Easier and more efficient exchange of function references between modules and with host environment

* Optionally, support for safe closures

* Separate independently useful features from [GC proposal](https://github.com/WebAssembly/gc/blob/master/proposals/gc/Overview.md)


### Summary

* This proposal is based on the [reference types proposal](https://github.com/WebAssembly/reference-types))

* Add a new form of *typed reference type* `ref $t` and a nullable variant `ref (null $t)`, where `$t` is a type index; can be used as both a value type or an element type for tables

* Add an instruction `ref.as_non_null` that converts a nullable reference to a non-nullable one or traps if null

* Add an instruction `br_on_null` that converts a nullable reference to a non-nullable one or branches if null

* Add an instruction `call_ref` for calling a function through a `ref $t`

* Refine the instruction `ref.func $f` to return a typed function reference

* Optionally add an instruction `func.bind` to create a closure

* Add a block instruction `let (local t*) ... end` for introducing locals with block scope, in order to handle reference types without default initialisation values

* Add an optional initialiser expression to table definitions, for element types that do not have an implicit default value.


### Examples

The function `$hof` takes a function pointer as parameter, and is invoked by `$caller`, passing `$inc` as argument:
```wasm
(type $i32-i32 (func (param i32) (result i32)))

(func $hof (param $f (ref $i32-i32)) (result i32)
  (i32.add (i32.const 10) (call_ref (i32.const 42) (local.get $f)))
)

(func $inc (param $x i32) (result i32)
  (i32.add (local.get $i) (i32.const 1))
)

(func $caller (result i32)
  (call $hof (ref.func $inc))
)
```

The function `$mk-adder` returns a closure of another function:
```wasm
(func $add (param i32 i32) (result i32) (i32.add (local.get 0) (local.get 1)))

(func $mk-adder (param $i i32) (result (ref $i32-i32))
  (func.bind $i32-i32 (local.get $i) (ref.func $add))
)
```

The following function calls it and then applies the result twice:
```wasm
(func $main (result i32)
  (call $mk-adder (i32.const 7))
  (let (result i32) (local $f (ref $i32-i32))  ;; binds $f to top of stack
    (i32.mul
      (call_ref (i32.const 10) (local.get $f))
      (call_ref (i32.const 12) (local.get $f))
    )
  )
)
```
Note that we could not have used a function-level local for `$f` in this example, since the type `(ref $i32-i32)` is non-nullable and thus does not contain any default value to initialise the local with at the beginning of the function. By using `let` we can define a local that is initialised with values from the operand stack.

It is also possible to create a typed function table:
```wasm
(table 0 (ref $i32-i32))
```
Such a table can neither contain `null` entries nor functions of another type. Any use of `call_indirect` on this table does hence avoid all runtime checks beyond the basic bounds check. By using multiple tables, each one can be given a homogeneous type. The table can be initialised by growing it (provding an explicit initialiser value. (Open Question: we could also extend table definitions to provide an explicit initialiser.)

Typed references are a subtype of `funcref`, so they can also be used as untyped references. All previous uses of `ref.func` remain valid:
```wasm
(func $f (param i32))
(func $g)
(func $h (result i64))

(table 10 funcref)

(func $init
  (table.set (i32.const 0) (ref.func $f))
  (table.set (i32.const 1) (ref.func $g))
  (table.set (i32.const 2) (ref.func $h))
)
```


## Language

Based on [reference types proposal](https://github.com/WebAssembly/reference-types/blob/master/proposals/reference-types/Overview.md), which introduces types `funcref` and `externref`.


### Types

#### Heap Types

A *heap type* denotes a user-defined or pre-defined data type that is not a primitive scalar:

* `heaptype ::= (type <typeidx>) | func | extern`
  - `(type $t) ok` iff `$t` is defined in the context
  - `func ok` and `extern ok`, always

* In the binary encoding,
  - the `<typeidx>` type is encoded as a (positive) signed LEB
  - the others use the same (negative) opcodes as the existing `funcref`, `externref`, respectively


#### Reference Types

A *reference type* denotes the type of a reference to some data. It may either include or exclude null:

* `(ref null? <heaptype>)` is a new form of reference type
  - `reftype ::= ref null? <heaptype>`
  - `ref null? <heaptype> ok` iff `<heaptype> ok`

* Reference types now *all* take the form `ref null? <heaptype>`
  - `funcref` and `externref` are reinterpreted as abbreviations (in both binary and text format) for `(ref null func)` and `(ref null extern)`, respectively
  - Note: this refactoring allows using `func` and `extern` as heap types, which is relevant for future extensions such as [type imports](https://github.com/WebAssembly/proposal-type-imports/proposals/type-imports/Overview.md)
  - `(ref null? (type $t))` can be abbreviated to `(ref null? $t)` in the text format

* In the binary encoding,
  - null and non-null variant are distinguished by two new (negative) type opcodes
  - the opcodes for `funcref` and `externref` continue to exist as shorthands as described above


#### Subtyping

Greatest fixpoint (co-inductive interpretation) of the given rules (implying reflexivity and transitivity).

The following rules, now defined in terms of heap types, replace and extend the rules for [basic reference types](https://github.com/WebAssembly/reference-types/proposals/reference-types/Overview.md#subtyping).

##### Reference Types

* Reference types are covariant in the referenced heap type
  - `(ref null <heaptype1>) <: (ref null <heaptype2>)`
    - iff `<heaptype1> <: <heaptype2>`
  - `(ref <heaptype1>) <: (ref <heaptype2>)`
    - iff `<heaptype1> <: <heaptype2>`

* Non-null types are subtypes of possibly-null types
  - `(ref <heaptype1>) <: (ref null <heaptype2>)`
    - iff `<heaptype1> <: <heaptype2>`

##### Constructed Types

* Any function type is a subtype of `func`
  - `(type $t) <: func`
     - iff `$t = <functype>`

* Note: Function types themselves are invariant for now. This may be relaxed in future extensions.


#### Defaultability

* Any numeric value type is defaultable (to 0)

* A reference value type is defaultable (to `null`) iff it is of the form `ref null $t`

* Function-level locals must have a type that is defaultable.

* TODO: Table definitions with a type that is not defaultable must have an initialiser value. (Imports are not affected.)


### Instructions

#### Functions

* `ref.func` creates a function reference from a function index
  - `ref.func $f : [] -> [(ref $t)]`
     - iff `$f : $t`
  - this is a *constant instruction*

* `call_ref` calls a function through a reference
  - `call_ref : [t1* (ref null $t)] -> [t2*]`
     - iff `$t = [t1*] -> [t2*]`
  - traps on `null`

* With the [tail call proposal](https://github.com/WebAssembly/tail-call/blob/master/proposals/tail-call/Overview.md), there will also be `return_call_ref`:
  - `return_call_ref : [t1* (ref null $t)] -> [t2*]`
     - iff `$t = [t1*] -> [t2*]`
     - and `t2* <: C.result`
  - traps on `null`

* Optional extension: `func.bind` creates or extends a closure by binding one or several parameters
  - `func.bind $t' : [t0* (ref null $t)] -> [(ref $t')]`
    - iff `$t = [t0* t1*] -> [t2*]`
    - and `$t' = [t1'*] -> [t2'*]`
    - and `t1'* <: t1*`
    - and `t2* <: t2'*`
  - traps on `null`


#### Optional References

* `ref.null` is generalised to take a `<heaptype>` immediate
  - `ref.null ht: [] -> [(ref null ht)]`
    - iff `ht ok`

* `ref.as_non_null <heaptype>` converts a nullable reference to a non-null one
  - `ref.as_non_null ht: [(ref null ht)] -> [(ref ht)]`
    - iff `ht ok`
  - traps on `null`

* `br_on_null $l <heaptype>` checks for null and branches
  - `br_on_null $l ht : [t* (ref null ht)] -> [t* (ref ht)]`
    - iff `$l : [t*]`
    - and `ht ok`
  - branches to `$l` on `null`, otherwise returns operand as non-null

* Note: `ref.is_null` already exists via the [reference types proposal](https://github.com/WebAssembly/reference-types)


#### Local Bindings

* `let <blocktype> (local <valtype>)* <instr>* end` locally binds operands to variables
  - `let bt (local t)* instr* end : [t1* t*] -> [t2*]`
    - iff `bt = [t1*] -> [t2*]`
    - and `instr* : bt` under a context with `locals` extended with `t*` and `labels` extended with `[t2*]`

Note: The latter condition implies that inside the body of the `let`, its locals are prepended to the list of locals. Nesting multiple `let` blocks hence addresses them relatively, similar to labels. Function-level local declarations can be viewed as syntactic sugar for a bunch of zero constant instructions and a `let` wrapping the function body. That is,
```
(func ... (local t)* ...)
```
is equivalent to
```
(func ... (t.default)* (let (local t)* ...))
```
where `(t.default)` is `(t.const 0)` for numeric types `t`, and `(ref.null)` for reference types.

The rule also implies that let-bound locals are mutable.

Like all other block instructions, `let` binds a label


### Tables

* TODO: Table definitions have an initialiser value: `(table <tabletype> <constexpr>)`
  - `(table <limits> <reftype> <constexpr>) ok` iff `<limits> <reftype> ok` and `<constexpr> : <reftype>`
  - `(table <tabletype>)` is shorthand for `(table <tabletype> (ref.null))`


## Binary Format

### Types

#### Reference Types

| Opcode | Type            | Parameters |
| ------ | --------------- | ---------- |
| -0x10  | `funcref`       |            |
| -0x11  | `externref`     |            |
| -0x14  | `(ref null ht)` | `$t : heaptype` |
| -0x15  | `(ref ht)`      | `$t : heaptype` |

#### Heap Types

The opcode for heap types is encoded as an `s33`.

| Opcode | Type            | Parameters |
| ------ | --------------- | ---------- |
| i >= 0 | `(type i)`      |            |
| -0x10  | `func`          |            |
| -0x11  | `extern`        |            |

### Instructions

| Opcode | Instruction              | Immediates |
| ------ | ------------------------ | ---------- |
| 0x14   | `call_ref`               |            |
| 0x15   | `return_call_ref`        |            |
| 0x16   | `func.bind (type $t)`    | `$t : u32` |
| 0x17   | `let <bt> <locals>`      | `bt : blocktype, locals : (as in functions)` |
| 0xd3   | `ref.as_non_null ht`     |  ht : heaptype |
| 0xd4   | `br_on_null $l ht`       | `$l : u32`, ht : heaptype |

### Tables

TODO.


## JS API

Based on the [JS type reflection proposal](https://github.com/WebAssembly/js-types).

### Type Representation

* A `ValueType` can be described by an object of the form `{ref: ConsType, ...}`
  - `type ValueType = ... | {ref: ConsType, nullable: bool}`

* A `ConsType` can be described by a suitable union type
  - `type ConsType = "func" | "extern" | DefType`


### Value Conversions

#### Reference Types

In addition to the rules for basic reference types:

* Any function that is an instance of `WebAssembly.Function` with type `<functype>` is allowed as `ref <functype>` or `ref null <functype>`.

* Any non-null external reference is allowed as `ref extern`.

* The `null` value is allowed as `ref null ht`.


### Constructors

#### `Global`

* `TypeError` is produced if the `Global` constructor is invoked without a value argument but a type that is not defaultable.

#### `Table`

* The `Table` constructor gets an additional optional argument `init` that is used to initialise the table slots. It defaults to `null`. A `TypeError` is produced if the argument is omitted and the table's element type is not defaultable.

* The `Table` method `grow` gets an additional optional argument `init` that is used to initialise the new table slots. It defaults to `null`. A `TypeError` is produced if the argument is omitted and the table's element type is not defaultable.

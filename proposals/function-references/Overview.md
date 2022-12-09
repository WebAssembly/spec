# Typed Function References for WebAssembly

## Introduction

This proposal adds function references that are typed and can be called directly. Unlike `funcref` and the existing `call_indirect` instruction, typed function references need not be stored into a table to be called (though they can). A typed function reference can be formed from any function index.

The proposal distinguished regular and nullable function reference. The former cannot be null, and a call through them does not require any runtime check.

The proposal has instructions for producing and consuming (calling) function references. It also includes instruction for testing and converting between regular and nullable references.

Typed references have no canonical default value, because they cannot be null. To enable storing them in locals, which so far depend on default values for initialisation, the proposal also tracks the initialisation status of locals during validation.


### Motivation

* Enable efficient indirect function calls without runtime checks

* Represent first-class function pointers without the need for tables

* Easier and more efficient exchange of function references between modules and with host environment

* Separate independently useful features from [GC proposal](https://github.com/WebAssembly/gc/blob/master/proposals/gc/Overview.md)


### Summary

* This proposal is based on the [reference types proposal](https://github.com/WebAssembly/reference-types))

* Add a new form of *typed reference type* `ref $t` and a nullable variant `(ref null $t)`, where `$t` is a type index; can be used as both a value type or an element type for tables

* Add an instruction `ref.as_non_null` that converts a nullable reference to a non-nullable one or traps if null

* Add an instruction `br_on_null` that converts a nullable reference to a non-nullable one or branches if null, as well as the inverted `br_on_non_null`

* Add an instruction `call_ref` for calling a function through a `ref $t`

* Refine the instruction `ref.func $f` to return a typed function reference

* Track initialisation status of locals during validation and only allow `local.get` after a `local.set/tee` in the same or a surrounding block.

* Add an optional initialiser expression to table definitions, for element types that do not have an implicit default value.


### Examples

The function `$hof` takes a function pointer as parameter, and is invoked by `$caller`, passing `$inc` as argument:
```wasm
(type $i32-i32 (func (param i32) (result i32)))

(func $hof (param $f (ref $i32-i32)) (result i32)
  (i32.add (i32.const 10) (call_ref $i32-i32 (i32.const 42) (local.get $f)))
)

(func $inc (param $i i32) (result i32)
  (i32.add (local.get $i) (i32.const 1))
)

(func $caller (result i32)
  (call $hof (ref.func $inc))
)
```

It is also possible to create a typed function table:
```wasm
(table 0 (ref $i32-i32))
```
Such a table can neither contain `null` entries nor functions of another type. Any use of `call_indirect` on this table does hence avoid all runtime checks beyond the basic bounds check. By using multiple tables, each one can be given a homogeneous type. The table can be initialised by growing it (provding an explicit initialiser value. (Open Question: we could also extend table definitions to provide an explicit initialiser.)

Typed function references are a subtype of `funcref`, so they can also be used as untyped references. All previous uses of `ref.func` remain valid:
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

* `heaptype ::= <typeidx> | func | extern`
  - `$t ok` iff `$t` is defined in the context
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

* In the binary encoding,
  - null and non-null variant are distinguished by two new (negative) type opcodes
  - the opcodes for `funcref` and `externref` continue to exist as shorthands as described above


#### Type Definitions

* Type definitions are validated in sequence and without allowing recursion
  - `functype* ok`
    - iff `functype* = epsilon`
    - or `functype* = functype'* functype''`and `functype'* ok` and `functype'' ok` using only type indices up to `|functype'*|-1`


#### Subtyping

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

##### Heap Types

* Any function type is a subtype of `func`
  - `$t <: func`
     - iff `$t = <functype>`

##### Type Indices

* Type indices are subtypes only if they define equivalent types
  - `$t <: $t'`
    - iff `$t = <functype>` and `$t' = <functype'>` and `<functype> == <functype'>`
  - Note: Function types are invariant for now. This may be relaxed in future extensions.


#### Defaultability

* Any numeric value type is defaultable (to 0)

* A reference value type is defaultable (to `null`) iff it is of the form `ref null $t`

* Function-level locals must have a type that is defaultable.

* Table definitions with a type that is not defaultable must have an initialiser value. (Imports are not affected.)


#### Local Types

* Locals are now recorded in the context with types of the following form:
  - `localtype ::= set? <valtype>`
  - the flag `set` records that the local has been initialized
  - all locals with non-defaultable type start out unset


#### Instruction Types

* Instructions and instruction sequences are now typed with types of the following form:
  - `instrtype ::= <functype> <localidx>*`
  - the local indices record which locals have been set by the instructions
  - most typing rules except those for locals and for instruction sequences remain unchanged, since the index list is empty

* There is a natural notion of subtyping on instruction types:
  - `[t1*] -> [t2*] x1*  <:  [t3*] -> [t4*] x2*`
    - iff `t1* = t0* t1'*`
    - and `t2* = t0* t2'*`
    - and `[t1'*] -> [t2'*] <: [t3*] -> [t4*]*`
    - and `{x2*} subset {x1*}`

* Block types are instruction types with empty index set.

Note: Extending block types with index sets to allow initialization status to last beyond a block's end is a possible extension.


### Instructions

#### Functions

* `ref.func` creates a function reference from a function index
  - `ref.func $f : [] -> [(ref $t)]`
     - iff `$f : $t`
  - this is a *constant instruction*

* `call_ref <typeidx>` calls a function through a reference
  - `call_ref $t : [t1* (ref null $t)] -> [t2*]`
     - iff `$t = [t1*] -> [t2*]`
  - traps on `null`

* With the [tail call proposal](https://github.com/WebAssembly/tail-call/blob/master/proposals/tail-call/Overview.md), there will also be `return_call_ref`:
  - `return_call_ref $t : [t1* (ref null $t)] -> [t2*]`
     - iff `$t = [t1*] -> [t2*]`
     - and `t2* <: C.result`
  - traps on `null`


#### Optional References

* `ref.null <heaptype>` is generalised to take a `<heaptype>` immediate
  - `ref.null ht: [] -> [(ref null ht)]`
    - iff `ht ok`

* `ref.as_non_null` converts a nullable reference to a non-null one
  - `ref.as_non_null : [(ref null ht)] -> [(ref ht)]`
    - iff `ht ok`
  - traps on `null`

* `br_on_null <labelidx>` checks for null and branches if present
  - `br_on_null $l : [t* (ref null ht)] -> [t* (ref ht)]`
    - iff `$l : [t*]`
    - and `ht ok`
  - branches to `$l` on `null`, otherwise returns operand as non-null

* `br_on_non_null <labelidx>` checks for null and branches if not present
  - `br_on_non_null $l : [t* (ref null ht)] -> [t*]`
    - iff `$l : [t* (ref ht)]`
    - and `ht ok`
  - branches to `$l` if operand is not `null`, passing the operand itself under non-null type (along with potential additional operands)

* Note: `ref.is_null` already exists via the [reference types proposal](https://github.com/WebAssembly/reference-types)


#### Locals

Typing of local instructions is updated to account for the initialization status of locals.

* `local.get <localidx>`
  - `local.get $x : [] -> [t]`
    - iff `$x : set t`

* `local.set <localidx>`
  - `local.set $x : [t] -> [] $x`
    - iff `$x : set? t`

* `local.tee <localidx>`
  - `local.tee $x : [t] -> [t] $x`
    - iff `$x : set? t`

Note: These typing rules do not try to exclude indices for locals that have already been set, but an implementation could.


#### Instruction Sequences

Typing of instruction sequences is updated to account for initialization of locals.

* `instr*`
  - `instr1 instr* : [t1*] -> [t3*] x1* x2*`
    - iff `instr1 : [t1*] -> [t2*] x1*`
    - and `instr* : [t2*] -> [t3*] x2*` under a context where `x1*` are changed to `set`
  - `epsilon : [] -> [] epsilon`

Note: These typing rules do not try to eliminate duplicate indices, but an implementation could.
 
A subsumption rule allows to go to a supertype for any instruction:

* `instr`
  - `instr : [t1*] -> [t2*] x*`
    - iff `instr : [t1'*] -> [t2'*] x'*`
    - and `[t1'*] -> [t2'*] x'*  <:  [t1*] -> [t2*] x*`


### Tables

Table definitions have an initialiser value:

* `(table <tabletype> <constexpr>)` is an extended form of table definition
  - `(table <limits> <reftype> <constexpr>) ok` iff `<limits> <reftype> ok` and `<constexpr> : <reftype>`

* `(table <tabletype>)` is shorthand for `(table <tabletype> (ref.null <heaptype>))`, where `<heaptype>` is the element heap type contained in `<tabletype>`
  - note: the typing rule above implies that this only validates if the table's reference type is nullable


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
| i >= 0 | i               |            |
| -0x10  | `func`          |            |
| -0x11  | `extern`        |            |

### Instructions

| Opcode | Instruction              | Immediates |
| ------ | ------------------------ | ---------- |
| 0x14   | `call_ref $t`            | `$t : u32` |
| 0x15   | `return_call_ref $t`     | `$t : u32` |
| 0xd3   | `ref.as_non_null`        |            |
| 0xd4   | `br_on_null $l`          | `$l : u32` |
| 0xd6   | `br_on_non_null $l`      | `$l : u32` |

### Tables

Entries to the table section are extended as follows:

| Table Definition | Note |
|------------------|------|
| tabletype        | null-initialized table (as before) |
| 0x40 0x00 tabletype constexpr | explicitly initialized table |

The encoding of a table type starts with the encoding of a reference type, which cannot be 0x40 (since this is a pseudo type code otherwise only used in block types). Consequently, both forms can be distinguished by the first byte.
The second byte is reserved for possible future extensions.


## JS API

The group decided to go with the "no-frills" approach for the JS API for the time being.
In the context of this proposal, that means that conversions (or type reflection) at concrete reference type throws a `TypeError` exception.


### Value Conversions

#### Reference Types

In addition to the rules for basic reference types:

* If the target type of a ToWebAssemblyValue is a concrete reference type, then throw `TypeError`.

* If the source type of a ToJSValue is a concrete reference type, then throw `TypeError`.


### Constructors

#### `Global`

* `TypeError` is produced if the `Global` constructor is invoked without a value argument but a type that is not defaultable.

#### `Table`

* The `Table` constructor gets an additional optional argument `init` that is used to initialise the table slots. It defaults to `null`. A `TypeError` is produced if the argument is omitted and the table's element type is not defaultable.

* The `Table` method `grow` gets an additional optional argument `init` that is used to initialise the new table slots. It defaults to `null`. A `TypeError` is produced if the argument is omitted and the table's element type is not defaultable.


### Type Reflection

In the presence of the [JS type reflection proposal](https://github.com/WebAssembly/js-types):

* `Global.type` throws `TypeError` when encountering a concrete reference type.

* `Table.type` throws `TypeError` when encountering a concrete reference type as element type.

* `Function.type` throws `TypeError` when encountering a concrete reference type as parameter or result type.

* `Module.imports` throws `TypeError` when encountering a concrete reference type in any of the global, table or function types of imports.

* `Module.exports` throws `TypeError` when encountering a concrete reference type in any of the global, table or function types of exports.

Note: The [GC proposal](https://github.com/WebAssembly/gc) is expected to at least add `anyref` as a recognised `RefType`, but possibly throw on other abstract reference types.


### Possible Extension: Full Type Reflection

Post-MVP, the type reflection abilities of the JS API could be refined based on the [JS type reflection proposal](https://github.com/WebAssembly/js-types).

### Type Representation

* A `RefType` can be described by an object of the form `{ref: HeapType, ...}`
  - `type RefType = ... | {ref: HeapType, nullable: bool}`

* A `HeapType` can be described by a suitable union type
  - `type HeapType = "func" | "extern" | DefType`

Note: The [GC proposal](https://github.com/WebAssembly/gc) adds additional heap types.


### Value Conversions

#### Reference Types

In addition to the rules for basic reference types:

* Any function that is an instance of `WebAssembly.Function` with type `<functype>` is allowed as `ref <functype>` or `ref null <functype>`.

* Any non-null external reference is allowed as `ref extern`.

* The `null` value is allowed as `ref null ht`.

Note: The [GC proposal](https://github.com/WebAssembly/gc) is expected to allow additional conversions for `anyref`.


## Possible Extension: Function Subtyping

In the future (especially with the [GC proposal](https://github.com/WebAssembly/gc/blob/master/proposals/gc/Overview.md)) it will be desirable to allow the usual subtyping rules on function types.
This is relevant, for example, to encode [method tables](https://github.com/WebAssembly/gc/blob/master/proposals/gc/Overview.md#objects-and-method-tables).

While doing so, the semantics of static and dynamic type checks need to remain coherent.
That is, both static and dynamic type checking (as well as link-time checks) must use the same subtype relation.
Otherwise, values of a subtype would not always be substitutable for values of a supertype, thereby breaking a fundemental property of subtyping and various transformations and optimisations relying on substitutability.

At the same time, care has to be taken to not damage the performance of existing instructions.
In particular, `call_indirect` performs a runtime type check over (structural) function types that is expected to be no more expensive than a single pointer comparison.
That effectively rules out allowing any form of subtyping to kick in for this check.


### Exact Types

This tension with `call_indirect` can be resolved by distinguishing function types that have further subtypes and those that don't.
The latter are sometimes called _exact_ types.

Exact types might come in handy in a few other circumstances,
so we could distinguish the two forms in a generic manner by enriching heap types with a flag as follows:

* `heaptype ::= exact? <typeidx> | func | extern`

Exact types are themselves subtypes of corresponding non-exact types,
but the crucial difference is that they do not have further subtypes themselves.
That is, the following subtype rules would be defined on heap types:

* `exact? $t <: $t'`
  - iff `$t = <functype>` and `$t' = <functype'>`
  - and `<functype> <: <functype'>`

* `exact $t <: exact $t'`
  - iff `$t = <functype>` and `$t' = <functype'>`
  - and `<functype> == <functype'>`

in combination with the canonical rules for function subtyping itself:

* `[t1*]->[t2*] <: [t1'*]->[t2'*]`
  - iff `(t1' <: t1)*`
  - and `(t2 <: t2')*`

(and appropriate rules for other types that may be added to the type section in the future).

With this:

* The type of each function definition is interpreted as its exact type.

* The type annotation on `call_indirect` is interpreted as an exact type.
  (It would also be possible to extend `call_indirect` to allow either choice, leaving it to to the producer to make the trade-off between performance and flexibility.)

* For imports and references, every module can decide individually where it requires an exact type.

For any import or reference in a module's interface that flows into a function table on which it invokes `call_indirect`, the module can thereby enforce exact types that are guaranteed to succeed the signature check.


### Example

Consider:
```
(module $A
  (type $proc (func))
  (func (export "f") (result funcref) ...)
  (func (export "g") (result (ref $proc)) ...)
)

(module $B
  (type $th (func (result funcref)))
  (func $h (import "..." "h") (type exact $th))

  (table $tab funcref (elem $h))

  (func $call
    ...
    (call_indirect $th (i32.const 0))
    ...
  )

  (func $update (param $f (ref exact $th))
    (table.set (local.get $f) (i32.const 0))
  )
)
```
In module `$B`, the imported function `$h` requires an exact type match.
That ensures that a client cannot supply a function of a subtype,
such as `A.g`,
which would break the use of `call_indirect` in `$call`.
An attempt to do so will fail at link time.
Passing `A.f` would be accepted, however.

Similarly, `$update` can only be passed a reference with exact type,
again ensuring that `$call` will not fail unexpectedly subsequently.

If a function import (or reference) never interferes with `call_indirect`, however, then the import can have a more flexible type:
```
(module $C
  (type $th (func (result funcref)))
  (func $h (import "..." "h") (type $th))

  (func $k (result (ref $th))
    (call $h)
  )
)
```
Here, the laxer import type is okay: for `$h`, any function that returns a subtype of `funcref` is fine, since all choices will satisfy the result type `(ref $th)` of function `$k` performing the call.

More generally, the following imports are well-typed:
```
(module
  (type $proc (func))
  (type $tf (func (result funcref)))
  (type $tg (func (result (ref $proc))))

  (func $h1 (import "A" "g") (type $tg))
  (func $h2 (import "A" "g") (type exact $tg))
  (func $h3 (import "A" "g") (type $tf))
  ;; (func $h4 (import "A" "g") (type exact $tf))   ;; fails to link!
)
```

Note that the use of exact types for imports or references flowing into a function table is not _enforced_ by the type system.
It is the producer's responsibility to protect its interface with suitably narrow types.


### Backwards Compatibility and Textual Syntax

For exposition, we assumed above that exact types are a new construct,
denoted by an explicit flag.
However, such a design would still change the meaning of existing type expressions (by suddenly allowing subtyping) and would hence not be backwards compatible, for the reasons stated above.

To avoid breaking existing modules when operating in new environments that support subtyping, we must preserve the current subtype-less, i.e. exact, meaning of the pre-existing function types -- at least in the binary format.
Subtypable function references/imports must be introduced as the new construct.

It's a slightly different question what to do for the text format, however.
To maintain full backwards compatibility, the flag would likewise need to be inverted:
instead of an optional `exact` flag we'd have an optional `sub` flag with the opposite meaning:

* `heaptype ::= sub? <typeidx> | func | extern`

In the binary format it doesn't really matter which way both alternatives are encoded.
But for the text format, this inversion will be rather annoying:
the normal use case is to allow subtyping;
but to express that, every import or reference type will have to explicitly state `sub`.

One possibility might be to keep the `exact` syntax above for the text format,
and effectively change the interpretation of the existing syntax.
That means that existing text format programs using e.g. function imports would change their meaning, and running wasm/wat converters would produce different results.
In particular, rebuilding a binary from a pre-existing text file may produce a binary with weaker interface requirements.

Is the risk involved in that worth taking? How much of a problem do we think this would be?

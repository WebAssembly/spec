# Typed Function References for WebAssembly

## Introduction

This proposal adds function references that are typed and can be called directly. Unlike `funcref` and the existing `call_indirect` instruction, typed function references need not be stored into a table to be called (though they can). A typed function reference can be formed from any function index.

The proposal distinguished regular and optional (nullable) function reference. The former cannot be null, and a call through them does not require any runtime check.

The proposal has instructions for producing and consuming (calling) function references. It also includes instruction for testing and converting between regular and optional references.

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

* Add a new form of *typed reference type* `ref $t` and a nullable variant `optref $t`, where `$t` is a type index; can be used as both a value type or an element type for tables

* Add an instruction `ref.as_non_null` that converts an optional reference to a non-optional one or traps if null

* Add an instruction `br_on_null` that converts an optional reference to a non-optional one or branches if null

* Add an instruction `call_ref` for calling a function through a `ref $t`

* Refine the instruction `func.ref $f` to return a typed function reference

* Optionally add an instruction `func.bind` to create a closure

* Add a block instruction `let (local t*) ... end` for introducing locals with block scope, in order to handle reference types without default initialisation values


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
  (call $hof (func.ref $inc))
)
```

The function `$mk-adder` returns a closure of another function:
```wasm
(func $add (param i32 i32) (result i32) (i32.add (local.get 0) (local.get 1)))

(func $mk-adder (param $i i32) (result (ref $i32-i32))
  (func.bind $i32-i32 (local.get $i) (func.ref $add))
)
```

The following function calls it and then applies the result twice:
```wasm
(func $main (result i32)
  (call $mk-adder (i32.const 7))
  (let (local $f (ref $i32-i32)) (result i32)  ;; binds $f to top of stack
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

Typed references are a subtype of `funcref`, so they can also be used as untyped references. All previous uses of `func.ref` remain valid:
```wasm
(func $f (param i32))
(func $g)
(func $h (result i64))

(table 10 funcref)

(func $init
  (table.set (i32.const 0) (func.ref $f))
  (table.set (i32.const 1) (func.ref $g))
  (table.set (i32.const 2) (func.ref $h))
)
```


## Language

Based on [reference types proposal](https://github.com/WebAssembly/reference-types/blob/master/proposals/reference-types/Overview.md), which introduces type `anyref` and `funcref`.


### Types

#### Value Types

* `ref <typeidx>` is a new reference type
  - `reftype ::= ... | ref <typeidx>`
  - `ref $t ok` iff `$t` is defined in the context

* `optref <typeidx>` is a new reference type
  - `reftype ::= ... | optref <typeidx>`
  - `optref $t ok` iff `$t` is defined in the context


#### Subtyping

The following new subtyping rules are added:

* Concrete and optional reference types are covariant
  - `ref $t1 <: ref $t2`
     - iff `$t1 = $t2`
  - `optref $t1 <: optref $t2`
     - iff `$t1 = $t2`
  - Note: no structural subtyping yet, deferred to GC proposal

* Any nullable reference type is a subtype of `anyref` and a supertype of `nullref`
  - `optref $t <: anyref`
  - `nullref <: optref $t`

* Any concrete reference type is a subtype of the respective nullable reference type (and thereby of `anyref`)
  - `ref $t <: optref $t`
  - Note: concrete reference types are *not* supertypes of `nullref`, i.e., not nullable

* Any nullable function reference type (and thereby any function reference type) is a subtype of `funcref`
  - `optref $t <: funcref`
     - iff `$t = <functype>`


#### Defaultability

* Any numeric value type is defaultable (to 0)

* A reference value type is defaultable (to `null`) if it is not of the form `ref $t`

* Function-level locals must have a type that is defaultable.

* Table definitions with non-zero minimum size must have an element type that is defaultable. (Imports are not affected.)

Question:
- Should we introduce a variant of table definition with explicit default initialiser?


### Instructions

#### Functions

* `func.ref` creates a function reference from a function index
  - `func.ref $f : [] -> [(ref $t)]`
     - iff `$f : $t`
  - this is a *constant instruction*

* `call_ref` calls a function through a reference
  - `call_ref : [t1* (ref $t)] -> [t2*]`
     - iff `$t = [t1*] -> [t2*]`

* With the [tail call proposal](https://github.com/WebAssembly/tail-call/blob/master/proposals/tail-call/Overview.md), there will also be `return_call_ref`:
  - `return_call_ref : [t1* (ref $t)] -> [t2*]`
     - iff `$t = [t1*] -> [t2*]`
     - and `t2* <: C.result`

* Optional extension: `func.bind` creates or extends a closure by binding one or several parameters
  - `func.bind $t' : [t1^n (ref $t)] -> [(ref $t')]`
    - iff `$t = [t1^n t1'*] -> [t2*]`
    - and `$t' = [t1'*] -> [t2*]`

Questions:
- Should `call_ref` be named `func.call`?
- The requirement to provide type `$t'` for `func.bind` instead of just a number side-steps the issue of expressing an anonymous function type. Should we try better?


#### Optional References

* `ref.as_non_null` converts an optional reference to a non-optional one
  - `ref.as_non_null : [(optref $t)] -> [(ref $t)]`
    - iff `$t` is defined
  - traps on `null`

* `br_on_null` checks for null and branches
  - `br_on_null $l : [(optref $t)] -> [(ref $t)]`
    - iff `$t` is defined
  - branches to `$l` on `null`, otherwise returns operand as non-optional

* Note: `ref.is_null` already exists via the [reference types proposal](https://github.com/WebAssembly/reference-types)


#### Local Bindings

* `let <blocktype> (local <valtype>)* <instr>* end` locally binds operands to variables
  - `let bt (local t)* instr* end : [t* t1*] -> [t2*]`
    - iff `bt = [t1*] -> [t2*]`
    - and `instr* : bt` under a context with `locals` extended by `t*` and `labels` extended by `[t2*]`

Note: The lattter condition implies that inside the body of the `let`, its locals are prepended to the list of locals. Nesting multiple `let` blocks hence addresses them relatively, similar to labels. Function-level local declarations can be viewed as syntactic sugar for a bunch of zero constant instructions and a `let`.


## Binary Format

TODO.


## JS API

Based on the JS type reflection proposal.

### Type Representation

* A `ValueType` can be described by an object of the form `{ref: DefType}` and `{optref: DefType}`
  - `type ValueType = ... | {ref: DefType} | {optref: DefType}`


### Value Conversions

#### Reference Types

In addition to the rules for basic reference types:

* Any function that is an instance of `WebAssembly.Function` with type `<functype>` is allowed as `ref <functype>`.

* The `null` value is allowed as `optref $t`.


### Constructors

#### `Global`

* `TypeError` is produced if the `Global` constructor is invoked without a value argument but a type that is not defaultable.

#### `Table`

* The `Table` constructor gets an additional optional argument `init` that is used to initialise the table slots. It defaults to `null`. A `TypeError` is produced if the argument is omitted and the table's element type is not defaultable.

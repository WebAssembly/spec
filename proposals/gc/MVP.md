# GC v1 Extensions


## Language

Based on reference types proposal.

### Types

#### Value Types

* `eqref` is a new reference type
  - `reftype ::= ... | eqref`

* `ref <typeidx>` is a new reference type
  - `reftype ::= ... | ref <typeidx>`
  - `ref $t ok` iff `$t` is defined in the context

* `int31ref` is a new reference type
  - `reftype ::= ... | int31ref`


#### Type Definitions

* `deftype` is the new category of types that can occur as type definitions
  - `deftype ::= <functype> | <structtype> | <arraytype>`
  - `module ::= {..., types vec(<deftype>)}`

* `structtype` describes a structure with statically indexed fields
  - `structtype ::= struct <fieldtype>*`

* `arraytype` describes an array with dynamically indexed fields
  - `arraytype ::= array <fieldtype>`

* `fieldtype` describes a struct or array field and whether it is mutable
  - `fieldtype ::= <mutability> <storagetype>`
  - `storagetype ::= <valtype> | <packedtype>`
  - `packedtype ::= i8 | i16`

* Unpacking a storage type yields `i32` for packed types, otherwise the type itself
  - `unpacked(t) = t`
  - `unpacked(pt) = i32`


#### Imports

* `type <typetype>` is an import description with an upper bound
  - `importdesc ::= ... | type <reftype>`
  - Note: `type` may get additional parameters in the future


#### Exports

* `type <typeidx>` is an export description
  - `exportdesc ::= ... | type <typeidx>`
  - `type $t ok` iff `$t` is defined in the context


#### Subtyping

Greatest fixpoint (co-inductive interpretation) of the given rules (implying reflexivity and transitivity).

* `eqref` is a subtype of `anyref`
  - `eqref <: anyref`
  - Note: `int31ref` and `anyfunc` are *not* a subtypes of `eqref`, i.e., those types do not expose reference equality

* `nullref` is a subtype of `eqref`
  - `nullref <: eqref`
  - Note: `nullref` is *not* a subtype of `anyfunc`, `int31ref`or any concrete reference type, i.e., those types are not nullable

* `int31ref` is a subtype of `anyref`
  - `int31ref <: anyref`

* Any concrete reference type is a subtype of `anyref`
  - `ref $t <: anyref`
  - Note: concrete reference types are *not* a supertypes of `nullref`, i.e., nut nullable

* Any function reference type is a subtype of `anyfunc`
  - `ref $t <: anyfunc`
     - iff `$t = <functype>`

* Any concrete reference type is a subtype of `eqref` if its not a function
  - `ref $t <: eqref`
     - if `$t = <structtype>` or `$t = <arraytype>`
     - or `$t = type rt` and `rt <: eqref`
  - TODO: provide a way to make data types non-eq, especially immutable ones

* Concrete reference types are covariant
  - `ref $t1 <: ref $t2`
     - iff `$t1 <: $t2`

* Structure types support width and depth subtyping
  - `struct <fieldtype1>* <fieldtype1'>* <: struct <fieldtype2>*`
    - iff `(<fieldtype1> <: <fieldtype2>)*`

* Array types support depth subtyping
  - `array <fieldtype1> <: array <fieldtype2>`
    - iff `<fieldtype1> <: <fieldtype2>`

* Field types are covariant if they are immutable, invariant otherwise
  - `const <valtype1> <: const <valtype2>`
    - iff `<valtype1> <: <valtype2>`
  - `var <valtype> <: var <valtype>`
  - Note: mutable fields are *not* subtypes of immutable ones, so `const` really means constant, not read-only


#### Defaultability

* Any numeric value type is defaultable

* A reference value type is defaultable if it is not of the form `ref $t`

* Locals must have a type that is defaultable.


### Instructions

#### Equality

* `ref.eq` compares two references whose types support equality
  - `ref.eq : [eqref eqref] -> [i32]`


#### Functions

* `ref.func` creates a function reference from a function index
  - `ref.func $f : [] -> (ref $t)`
     - iff `$f : $t`

* `call_ref` calls a function through a reference
  - `call_ref : [t1* (ref $t)] -> [t2*]`
     - iff `$t = [t1*] -> [t2*]`


#### Structures

* `struct.new <typeidx>` allocates a structure of type `$t` and initialises its fields with given values
  - `struct.new $t : [t*] -> [(ref $t)]`
    - iff `$t = struct (mut t)*`

* `struct.new_default <typeidx>` allocates a structure of type `$t` and initialises its fields with default values
  - `struct.new_default $t : [] -> [(ref $t)]`
    - iff `$t = struct (mut t)*`
    - and all `t*` are defaultable

* `struct.get <typeidx> <fieldidx>` reads field `$x` from a structure
  - `struct.get $t i : [(ref $t)] -> [t]`
    - iff `$t = struct (mut1 t1)^i (mut ti) (mut2 t2)*`
    - and `t = unpacked(ti)`

* `struct.set <typeidx> <fieldidx>` writes field `$x` of a structure
  - `struct.set $t i : [(ref $t) ti] -> []`
    - iff `$t = struct (mut1 t1)^i (var ti) (mut2 t2)*`
    - and `t = unpacked(ti)`


#### Arrays

* `array.new <typeidx>` allocates an array of type `$t` and initialises its fields with a given value
  - `array.new $t : [t i32] -> [(ref $t)]`
    - iff `$t = array (mut t)`

* `array.new_default <typeidx>` allocates an array of type `$t` and initialises its fields with the default value
  - `array.new_default $t : [i32] -> [(ref $t)]`
    - iff `$t = array (mut t)`
    - and `t` is defaultable

* `array.get <typeidx>` reads an element from an array
  - `array.get $t : [(ref $t) i32] -> [t]`
    - iff `$t = array (mut t')`
    - and `t = unpacked(t')`

* `array.set <typeidx>` writes an element to an array
  - `array.set $t : [(ref $t) i32 t] -> []`
    - iff `$t = array (var t')`
    - and `t = unpacked(t')`

* `array.len <typeidx>` inquires the length of an array
  - `array.len $t : [(ref $t)] -> [i32]`
    - iff `$t = array (mut t)`


#### Integer references

* `int31ref.new` creates an `int31ref` from a 32 bit value, truncating high bit
  - `int31ref : [i32] -> [int31ref]`

* `int31ref.get_u` extracts the value, zero-extending
  - `int31ref.get_u : [int31ref] -> [i32]`

* `int31ref.get_s` extracts the value, sign-extending
  - `int31ref.get_s : [int31ref] -> [i32]`


#### Casts

* `ref.cast <reftype>` casts a value down to a given reference type
  - `ref.cast t : [t'] -> [t]`
     - iff `t <: t' <: anyref`
  - traps if the operand is not of type `t` at runtime

Question: Have explicit runtime type representations as cast operands?


#### Local Bindings

* `let <valtype>* <blocktype> <instr>* end` locally binds operands to variables
  - `let t* bt instr* end : [t* t1*] -> [t2*]`
    - iff `bt = [t1*] -> [t2*]`
    - and `instr* : bt` under a context with `locals` extended by `t*` and `labels` extended by `[t2*]`


## Binary Format

TODO.


## JS API

Based on the JS type reflection proposal.

### Type Representation

* A `ValueType` can be described by an object of the form `{ref: DefType}`
  - `type ValueType = ... | {ref: DefType}`

* A `ValueType` can be described by the string `eqref`
  - `type ValueType = ... | "eqref"`

* A `DefType` is described by a kind and a definition
  - `type DefKind = "func" | "struct" | "array"`
  - `type DefType = {kind: DefKind, definition: FuncType | StructType | ArrayType}`

* TODO: ...`StructType` and `ArrayType`...


### Value Conversions

#### Reference Types

* Any function that is an instance of `WebAssembly.Function` with type `<functype>` is a subtype of `ref <functype>`.

* TODO: ...rules for structure and array types.


#### Equality Types

* Any JS object (non-primitive value) or symbol or `null` can be passed as `eqref` to a Wasm function, stored in a global, or in a table.


### Constructors

#### `Global`

* `TypeError` is produced if the `Global` constructor is invoked without a value argument but a type that is not defaultable.

#### `Table`

* The `Table` constructor gets an additional optional argument `init` that is used to initialise the table slots. It defaults to `null`. A `TypeError` is produced if the argument is omitted and the table's element type is not defaultable.

#### `Type`

TODO.


## Questions

* Have explicit runtime type representations?

* Distinguish reference types that are castable (and therefore have RTTI)?

* Provide a way to make data types non-eq, especially immutable ones?

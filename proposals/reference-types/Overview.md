# Reference Types for WebAssembly

TODO: more text, motivation, explanation

## Introduction

Motivation:

* Easier and more efficient interop with host environment (see e.g. the [Interface Types proposal](https://github.com/WebAssembly/interface-types/blob/master/proposals/interface-types/Explainer.md))
  - allow host references to be represented directly by type `anyref` (see [here](https://github.com/WebAssembly/interface-types/issues/9))
  - without having to go through tables, allocating slots, and maintaining index bijections at the boundaries

* Basic manipulation of tables inside Wasm
  - allow representing data structures containing references
by repurposing tables as a general memory for opaque data types
  - allow manipulating function tables from within Wasm.
  - add instructions missing from [bulk operations proposal](https://github.com/WebAssembly/bulk-memory-operations/blob/master/proposals/bulk-memory-operations/Overview.md)

* Set the stage for later additions:

  - Typed function references (see [below](#typed-function-references))
  - Exception references (see the [exception handling proposal](https://github.com/WebAssembly/exception-handling/blob/master/proposals/Exceptions.md) and [here](https://github.com/WebAssembly/interface-types/issues/10))
  - A smoother transition path to GC (see the [GC proposal](https://github.com/WebAssembly/gc/blob/master/proposals/gc/Overview.md))

Get the most important parts soon!

Summary:

* Add new types `anyref` and `nullref` that can be used as both a value types and a table element types.

* Also allow `funcref` as a value type.

* Introduce instructions to get and set table slots.

* Add missing table size, grow, fill instructions.

* Allow multiple tables.

Notes:

* This extension does not imply GC by itself, only if host refs are GCed pointers!

* Reference types are *opaque*, i.e., their value is abstract and they cannot be stored into linear memory. Tables are used as the equivalent.


## Language Extensions

Typing extensions:

* Introduce `anyref`, `funcref`, and `nullref` as a new class of *reference types*.
  - `reftype ::= anyref | funcref | nullref`

* Value types (of locals, globals, function parameters and results) can now be either numeric types or reference types.
  - `numtype ::= i32 | i64 | f32 | f64`
  - `valtype ::= <numtype> | <reftype>`
  - locals with reference type are initialised with `null`

* Element types (of tables) are equated with reference types.
  - `elemtype ::= <reftype>`

* Introduce a simple subtype relation between reference types.
  - reflexive transitive closure of the following rules
  - `t <: anyref` for all reftypes `t`
  - `nullref <: anyref` and `nullref <: funcref`
  - Note: No rule `nullref <: t` for all reftypes `t` -- while that is derivable from the above given the current set of types it might not hold for future reference types which don't allow null.


New/extended instructions:

* The new instruction `ref.null` evaluates to the null reference constant.
  - `ref.null : [] -> [nullref]`
  - allowed in constant expressions

* The new instruction `ref.is_null` checks for null.
  - `ref.is_null : [anyref] -> [i32]`

* The new instruction `ref.func` creates a reference to a given function.
  - `ref.func $x : [] -> [funcref]`
    - iff `$x : func $t`
  - allowed in constant expressions
  - Note: the result type of this instruction may be refined by future proposals (e.g., to `[(ref $t)]`)

* The new instructions `table.get` and `table.set` access tables.
  - `table.get $x : [i32] -> [t]`
    - iff `$x : table t`
  - `table.set $x : [i32 t] -> []`
    - iff `$x : table t`

* The new instructions `table.size`and `table.grow` manipulate the size of a table.
  - `table.size $x : [] -> [i32]`
    - iff `$x : table t`
  - `table.grow $x : [t i32] -> [i32]`
    - iff `$x : table t`
  - the first operand of `table.grow` is an initialisation value (for compatibility with future extensions to the type system, such as non-nullable references)

* The new instruction `table.fill` fills a range in a table with a value.
  - `table.fill $x : [i32 t i32] -> []`
    - iff `$x : table t`
  - the first operand is the start index of the range, the third operand its length (analoguous to `memory.fill`)
  - traps when range+length > size of the table, but only after filling range up to size (analoguous to `memory.fill`)

* The `table.init` instruction takes an additional table index as immediate.
  - `table.init $x $y : [i32 i32 i32] -> []`
    - iff `$x : table t`
    - and `$y : elem t'`
    - and `t' <: t`

* The `table.copy` instruction takes two additional table indices as immediate.
  - `table.copy $x $y : [i32 i32 i32] -> []`
    - iff `$x : table t`
    - and `$y : table t'`
    - and `t' <: t`

* The `call_indirect` instruction takes a table index as immediate.
  - `call_indirect $x (type $t) : [t1* i32] -> [t2*]`
    - iff `$t = [t1*] -> [t2*]`
    - and `$x : table t'`
    - and `t' <: funcref`

* In all instructions, table indices can be omitted and default to 0.

Note:
- In the binary format, space for the additional table indices is already reserved.
- For backwards compatibility, all table indices may be omitted in the text format, in which case they default to 0 (for `table.copy`, both indices must be either present or absent).


Table extensions:

* A module may define, import, and export multiple tables.
  - As usual, the imports come first in the index space.
  - This is already representable in the binary format.

* Element segments take a table index as immediate that identifies the table they apply to.
  - In the binary format, space for the index is already reserved.
  - For backwards compatibility, the index may be omitted in the text format, in which case it defaults to 0.


API extensions:

* Any JS value can be passed as `anyref` to a Wasm function, stored in a global, or in a table.

* Any Wasm exported function object or `null` can be passed as `funcref` to a Wasm function, stored in a global, or in a table.


## Possible Future Extensions


### Equality on references

Motivation:

* Allow references to be compared by identity.
* However, not all reference types should be comparable, since that may make implementation details observable in a non-deterministic fashion (consider e.g. host JavaScript strings).


Additions:

* Add `eqref` as the type of comparable references
  - `reftype ::= ... | eqref`
* It is a subtype of `anyref`
  - `eqref < anyref`
  - `nullref < eqref`
* Add `ref.eq` instruction.
  - `ref.eq : [eqref eqref] -> [i32]`

API changes:

* Any JS object (non-primitive value) or symbol or `null` can be passed as `eqref` to a Wasm function, stored in a global, or in a table.


Questions:

* Interaction with type imports/exports: do they need to distinguish equality types from non-equality now?

* Similarly, the JS API for `WebAssembly.Type` below would need to enable the distinction.


### Typed function references

See the [typed function references proposal](https://github.com/WebAssembly/function-references/blob/master/proposals/function-references/Overview.md)

Motivation:

* Allow function pointers to be expressed directly without going through table and dynamic type check.
* Enable functions to be passed to other modules easily.

Additions:

* Add `(ref $t)` as a reference type
  - `reftype ::= ... | ref <typeidx>`
* Refine `(ref.func $f)` instruction
  - `ref.func $f : [] -> (ref $t)` iff `$f : $t`
* Add `(call_ref)` instruction
  - `call_ref : [ts1 (ref $t)] -> [ts2]` iff `$t = [ts1] -> [ts2]`
* Introduce subtyping `ref <functype> < funcref`
* Subtying between concrete and universal reference types
  - `ref $t < anyref`
  - `ref <functype> < funcref`
  - Note: reference types are not necessarily subtypes of `eqref`, including functions

* Typed function references cannot be null!

* The `table.grow` instruction (see the [bulk operation proposal](https://github.com/WebAssembly/bulk-memory-operations/blob/master/proposals/bulk-memory-operations/Overview.md)) needs to take an initialisation argument.

* Likewise `WebAssembly.Table#grow` takes an additional initialisation argument.
  - optional for backwards compatibility, defaults to `null`


### Type Import/Export

Motivation:

* Allow the host (or Wasm modules) to distinguish different reference types.

Additions:

* Add `(type)` external type, enables types to be imported and exported
  - `externtype ::= ... | type`
  - `(ref $t)` can now denote an abstract type or a function reference
  - imported types have index starting from 0.
  - reserve byte in binary format to allow refinements later

* Add abstract type definitions in type section
  - `deftype ::= <functype> | new`
  - creates unique abstract type

* Add `WebAssembly.Type` class to JS API
  - constructor `new WebAssembly.Type(name)` creates unique abstract type

* Subtyping `ref <abstype>` < `anyref`


Questions:

* Do we need to impose constraints on the order of imports, to stratify section dependencies? Should type import and export be separate sections instead?

* Do we need a nullable `(optref $t)` type to allow use with locals etc.? Could a `(nullable T)` type constructor work instead?
  - Unclear how `nullable` constructor would integrate exactly. Would it only allow (non-nullable) reference types as argument? Does this require a kind system? Should `anyref` be different from `(nullable anyref)`, or the latter disallowed? What about `funcref`?
  - Semantically, thinking of `(nullable T)` as `T | nullref` could answer these questions, but we cannot support arbitrary unions in Wasm.

* Should we add `(new)` definitional type to enable Wasm modules to define new types, too?

* Do `new` definition types and the `WebAssembly.Type` constructor need to take a "comparable" flag controlling whether references to a type can be compared?

* Should JS API allow specifying subtyping between new types?


### Down Casts

Motivation:

* Allow to implement generics by using `anyref` as a top type.

Addition:

* Add a `cast` instruction that checks whether its operand can be cast to a lower type and converts its type accordingly if so; otherwise, goes to an else branch.
  - `cast <resulttype> <reftype1> <reftype2> <instr1>* else <instr2>* end: [<reftypet1>] -> <resulttype>` iff `<reftype2> < <reftype1>` and `<instr1>* : [<reftype2>] -> <resulttype>` and `<instr2>* : [<reftype1>] -> <resulttype>`
  - could later be generalised to non-reference types?

Note:

* Can decompose `call_indirect` (assuming multi-value proposal):
  - `(call_indirect $x (type $t))` reduces to `(table.get $x) (cast $t anyref (ref $t) (then (call_ref (ref $t))) (else (unreachable)))`


### GC Types

See [GC proposal](https://github.com/WebAssembly/gc/blob/master/proposals/gc/Overview.md).


### Further possible generalisations

* Introduce reference types pointing to tables, memories, or globals.
  - `deftype ::= ... | global <globaltype> | table <tabletype> | memory <memtype>`
  - `ref.global $g : [] -> (ref $t)` iff `$g : $t`
  - `ref.table $x : [] -> (ref $t)` iff `$x : $t`
  - `ref.mem $m : [] -> (ref $t)` iff `$m : $t`
  - yields first-class tables, memories, globals
  - would requires duplicating all respective instructions

* Allow all value types as element types.
  - `deftype := ... | globaltype | tabletype | memtype`
  - would unify element types with value types

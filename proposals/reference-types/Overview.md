# Reference Types for WebAssembly

TODO: more text, motivation, explanation

## Introduction

Motivation:

* Easier and more efficient interop with host environment
  - allow host references to be represented directly by type `anyref`
  - without having to go through tables, allocating slots, and maintaining index bijections at the boundaries

* Basic manipulation of tables inside Wasm
  - allow representing data structures containing references
by repurposing tables as a general memory for opaque data types
  - allow manipulating function tables from within Wasm.

* Set the stage for later additions:

  - Typed function references (see below)
  - Exception references (see exception handling proposal)
  - A smoother transition path to GC (see GC proposal)

Get the most important parts soon!

Summary:

* Add a new type `anyref` that can be used as both a value type and a table element type.

* Also allow `anyfunc` as a value type.

* Introduce instructions to get and set table slots.

* Allow multiple tables.

Notes:

* This extension does not imply GC by itself, only if host refs are GCed pointers!

* Reference types are *opaque*, i.e., their value is abstract and they cannot be stored into linear memory. Tables are used as the equivalent.


## Language Extensions

Typing extensions:

* Introduce `anyref`, `anyfunc`, and `nullref` as a new class of *reference types*.
  - `reftype ::= anyref | anyfunc | nullref`
  - `nullref` is merely an internal type and is neither expressible in the binary format, nor the text format, nor the JS API.
  - Question: should it be?

* Value types (of locals, globals, function parameters and results) can now be either numeric types or reference types.
  - `numtype ::= i32 | i64 | f32 | f64`
  - `valtype ::= <numtype> | <reftype>`
  - locals with reference type are initialised with `null`

* Element types (of tables) are equated with reference types.
  - `elemtype ::= <reftype>`

* Introduce a simple subtype relation between reference types.
  - reflexive transitive closure of the following rules
  - `n < anyref` for all reftypes `t`
  - `anyfunc < anyref`
  - Note: No rule `nullref < t` for all reftypes `t` -- while that is derivable from the above given the current set of types it might not hold for future reference types which don't allow null.


New/extended instructions:

* The new instruction `ref.null` evaluates to the null reference constant.
  - `ref.null : [] -> [nullref]`
  - allowed in constant expressions

* The new instruction `ref.is_null` checks for null.
  - `ref.is_null : [anyref] -> [i32]`

* The new instructions `table.get` and `table.set` access tables.
  - `table.get $x : [i32] -> [t]` iff `t` is the element type of table `$x`
  - `table.set $x : [i32 t] -> []` iff `t` is the element type of table `$x`
  - `table.fill $x : [i32 i32 t] -> []` iff `t` is the element type of table `$x`

* The `call_indirect` instruction takes a table index as immediate that identifies the table it calls through.
  - `call_indirect (type $t) $x : [t1* i32] -> [t2*]` iff `$t` denotes the function type `[t1*] -> [t2*]` and the element type of table `$x` is a subtype of `anyfunc`.
  - In the binary format, space for the index is already reserved.
  - For backwards compatibility, the index may be omitted in the text format, in which case it defaults to 0.


Table extensions:

* A module may define, import, and export multiple tables.
  - As usual, the imports come first in the index space.
  - This is already representable in the binary format.

* Element segments take a table index as immediate that identifies the table they apply to.
  - In the binary format, space for the index is already reserved.
  - For backwards compatibility, the index may be omitted in the text format, in which case it defaults to 0.


API extensions:

* Any JS object (non-primitive value) or `null` can be passed as `anyref` to a Wasm function, stored in a global, or in a table.

* Any JS function object or `null` can be passed as `anyfunc` to a Wasm function, stored in a global, or in a table.

* Only `null` can be passed as a `nullref` to a Wasm function, stored in a global, or in a table.


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


Questions:

* Interaction with type imports/exports: do they need to distinguish equality types from non-equality now?

* Similarly, the JS API for `WebAssembly.Type` below would need to enable the distinction.


### Typed function references

Motivation:

* Allow function pointers to be expressed directly without going through table and dynamic type check.
* Enable functions to be passed to other modules easily.

Additions:

* Add `(ref $t)` as a reference type
  - `reftype ::= ... | ref <typeidx>`
* Add `(ref.func $f)` and `(call_ref)` instructions
  - `ref.func $f : [] -> (ref $t)  iff $f : $t`
  - `call_ref : [ts1 (ref $t)] -> [ts2]` iff `$t = [ts1] -> [ts2]`
* Introduce subtyping `ref <functype> < anyfunc`
* Subtying between concrete and universal reference types
  - `ref $t < anyref`
  - `ref <functype> < anyfunc`
  - Note: reference types are not necessarily subtypes of `eqref`, including functions

* Typed function references cannot be null!

* The `table.grow` instruction (see bulk operation proposal) needs to take an initialisation argument.

* Likewise `WebAssembly.Table#grow` takes an additional initialisation argument.
  - optional for backwards compatibility, defaults to `null`


Question:

* General function have no reasonable default, do we need scoped variables like `let`?
* Should there be a down cast instruction?
* Should there be depth subtyping for function types?


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

* Do we need a nullable `(ref opt $t)` type to allow use with locals etc.? Could a `(nullable T)` type constructor work instead?
  - Unclear how `nullable` constructor would integrate exactly. Would it only allow (non-nullable) reference types as argument? Does this require a kind system? Should `anyref` be different from `(nullable anyref)`, or the latter disallowed? What about `anyfunc`?
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
  - `(call_indirect $t $x)` reduces to `(table.get $x) (cast $t anyref (ref $t) (then (call_ref (ref $t))) (else (unreachable)))`


### GC Types

See GC proposal.


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

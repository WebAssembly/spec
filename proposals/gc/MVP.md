# GC v1 Extensions

*Note: This design is still in flux!*

See [overview](Overview.md) for background.

The functionality provided with this first version of GC support for Wasm is intentionally limited in the spirit of a "a minimal viable product" (MVP).
As a rough guideline, it includes only essential functionality and avoids features that may provide better performance in some cases, but whose lack can be worked around in a reasonable manner.

In particular, it is expected that compiling to this minimal functionality will require a substantial number of runtime casts that may be eliminated by future extensions.
A range of such extensions are discussed in the [Post-MVP](Post-MVP.md) document.
Most of them are expected to be added before GC support can be considered reasonably "complete".


## Language

Based on the following proposals:

* [reference types](https://github.com/WebAssembly/reference-types), which introduces reference types

* [typed function references](https://github.com/WebAssembly/function-references), which introduces typed references `(ref null? $t)` etc.

* [type imports](https://github.com/WebAssembly/proposal-type-imports), which allows type definitions to be imported and exported

All three proposals are prerequisites.


### Types

#### Heap Types

[Heap types](https://github.com/WebAssembly/function-references/blob/master/proposals/function-references/Overview.md#types) classify reference types and are extended:

* `eq` is a new heap type
  - `heaptype ::= ... | eq`
  - the common supertype of all referenceable types on which comparison (`ref.eq`) is allowed

* `data` is a new heap type
  - `heaptype ::= ... | data`
  - the common supertype of all compound data types, like struct and array types and possibly host-defined types, for which casts are allowed

* `array` is a new heap type
  - `heaptype ::= ... | array`
  - the common supertype of all array types

* `i31` is a new heap type
  - `heaptype ::= ... | i31`
  - the type of unboxed scalars

* `rtt <n>? <typeidx>` is a new heap type that is a runtime representation of the static type `<typeidx>`
  - `heaptype ::= ... | rtt <n>? <typeidx>`
  - `rtt n? t ok` iff `t ok`
  - the constant `n`, if present, encodes the static knowledge that this type has `n` dynamic supertypes (see [Runtime types](#runtime-types))

* `extern` is renamed back to `any`
  - the common supertype of all referenceable types
  - the name `extern` is kept as an alias in the text format for backwards compatibility

* Note: heap types `func` and `extern` already exist via [reference types proposal](https://github.com/WebAssembly/reference-types), and `(ref null? $t)` via [typed references](https://github.com/WebAssembly/function-references)

We distinguish these *abstract* heap types from *concrete* heap types `(type $t)`.
Each abstract heap type is a supertype of a class of concrete heap types.
Moreover, they form a small [subtype hierarchy](#subtyping).


#### Reference Types

New abbreviations are introduced for reference types in binary and text format, corresponding to `funcref` and `externref`:

* `eqref` is a new reference type
  - `eqref == (ref null eq)`

* `dataref` is a new reference type
  - `dataref == (ref data)`

* `arrayref` is a new reference type
  - `arrayref == (ref array)`

* `i31ref` is a new reference type
  - `i31ref == (ref i31)`

* `rtt <n>? <typeidx>` is a new reference type
  - `(rtt <n>? $t) == (ref (rtt <n>? $t))`

* `externref` is renamed to `anyref`
  - `anyref == (ref null any)`
  - the name `externref` is kept as an alias in the text format for backwards compatibility


#### Type Definitions

* `deftype` is a new category of types that generalises the existing type definitions in the type section
  - `deftype ::= <functype> | <structtype> | <arraytype>`
  - `module ::= {..., types vec(<deftype>)}`

* `structtype` describes a structure with statically indexed fields
  - `structtype ::= struct <fieldtype>*`

* `arraytype` describes an array with dynamically indexed fields
  - `arraytype ::= array <fieldtype>`
  - Note: in the MVP, all arrays must be defined as mutable

* `fieldtype` describes a struct or array field and whether it is mutable
  - `fieldtype ::= <mutability> <storagetype>`
  - `storagetype ::= <valtype> | <packedtype>`
  - `packedtype ::= i8 | i16`

* Unpacking a storage type yields `i32` for packed types, otherwise the type itself
  - `unpacked(t) = t`
  - `unpacked(pt) = i32`

TODO: Need to be able to use `i31` as a type definition.


#### Subtyping

Greatest fixpoint (co-inductive interpretation) of the given rules (implying reflexivity and transitivity).

##### Heap Types

In addition to the [existing rules](https://github.com/WebAssembly/function-references/proposals/function-references/Overview.md#subtyping) for heap types:

* every type is a subtype of `any`
  - `t <: any`

* `dataref` is a subtype of `eqref`
  - `data <: eq`
  - TODO: provide a way to make data types non-eq, especially immutable ones?

* `arrayref` is a subtype of `dataref`
  - `array <: data`

* `i31ref` is a subtype of `eqref`
  - `i31 <: eq`

* Any concrete type is a subtype of either `data` or `func`
  - `(type $t) <: data`
     - if `$t = <structtype>` or `$t = <arraytype>`
     - or `$t = type ht` and `rt <: data` (imports)
  - `(type $t) <: func`
     - if `$t = <functype>`
     - or `$t = type ht` and `rt <: func` (imports)

* Any concrete array type is a subtype of `array`
  - `(type $t) <: array`
     - if `$t = <arraytype>`
     - or `$t = type ht` and `rt <: array` (imports)

* `rtt n? $t` is a subtype of `eq`
  - `rtt n? $t <: eq`

* `rtt n $t` is a subtype of `rtt $t`
  - `rtt n $t1 <: rtt $t2`
    - if `$t1 == $t2`
  - Note: `rtt n? $t1` is *not* a subtype of `rtt n? $t2`, if `$t1` is merely a subtype of `$t2`; such covariant subtyping would be unsound, since RTTs are used in both co- and contravariant roles (e.g., both when constructing and consuming a reference)

Note: This creates a hierarchy of *abstract* Wasm heap types that looks as follows.
```
      any
     /   \
   eq    func
  /  \
i31  data
       \
       array
```
All *concrete* heap types (of the form `(type $t)`) are situated below either `data` or `func`.
RTTs are below `eq`.

In addition, a host environment may introduce additional inhabitants of type `any` that are are in neither of the above three leaf type categories.
The interpretation of such values is defined by the host environment.

Note: In the future, this hierarchy could be refined, e.g., to distinguish compound data types that are not subtypes of `eq`.


##### Defined Types

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


### Runtime

#### Runtime Types

* Runtime types (RTTs) are explicit values representing concrete types at runtime; a value of type `rtt <n>? <typeidx>` is a dynamic representative of the static type `<typeidx>`.

* All RTTs are explicitly created and all operations involving dynamic type information (like casts) operate on explicit RTT operands. This allows maximum flexibility and custom choices wrt which RTTs to represent a source type.

* There is a runtime subtyping hierarchy on RTTs; creating an RTT allows providing a *parent type* in the form of an existing RTT.

* An RTT value r1 is *equal* to another RTT value r2 iff they both represent the same static type and either of the following holds:
  - r1 and r2 both have no parents, or
  - r1 and r2 both have equal RTT values as parents.

* An RTT value r1 is a *sub-RTT* of another RTT value r2 iff either of the following holds:
  - r1 and r2 are equal RTT values, or
  - r1 has a parent that is a sub-RTT of r2.

* The count `<n>` in the static type of an RTT value, if present, denotes the length of the supertype chain, i.e., its "inheritance depth" of _concrete types_ (not counting abstract supertypes like `dataref` or `anyref`, which are always at the top of the hierarchy). If this information is present, it enables more efficient implementation of runtime casts in an engine; if it is absent (e.g., to abstract the depth of a subtype graph), then the engine has to read it from the dynamic RTT value.

* Validation requires that each RTT's parent type is a representative of a static supertype; runtime subtyping hence is a sub-relation of static subtyping (a graph with fewer nodes and edges).

* At the same time, runtime subtyping forms a linear hierarchy such that the relation can be checked efficiently using standard implementation techniques (the runtime subtype hierarchy is a tree-shaped graph).

Note: RTT values correspond to type descriptors or "shape" objects as they exist in various engines. RTT equality can be implemented as a single pointer test by memoising RTT values. More interestingly, runtime casts along the hierachy encoded in these values can be implemented in an engine efficiently by using well-known techniques such as including a vector of its (direct and indirect) super-RTTs in each RTT value (with itself as the last entry). The value `<n>` then denotes the length of this vector. A subtype check between two RTT values can be implemented as follows using such a representation. Assume RTT value v1 has static type `(rtt n1? $t1)` and v2 has type `(rtt n2? $t2)`. To check whether v1 denotes a sub-RTT of v2, first verify that `n1 >= n2` -- if both `n1` and `n2` are known statically, this can be performed at compile time; if either is not statically known, it has to be read from the respective RTT value dynamically, and `n1 >= n2` becomes a dynamic check. Then compare v2 to the n2-th entry in v1's supertype vector. If they are equal, v1 is a sub-RTT.
In the case of actual casts, the static type of RTT v1 (obtained from the value to cast) is not known at compile time, so `n1` is dynamic as well.
(Note that `$t1` and `$t2` are not relevant for the dynamic semantics, but merely for validation.)

Example: Consider three types and corresponding RTTs:
```
(type $A (struct))
(type $B (struct (field i32)))
(type $C (struct (field i32 i64)))

(global $rttA (rtt 0 $A) (rtt.canon $A))
(global $rttB (rtt 1 $B) (rtt.sub $B (global.get $rttA)))
(global $rttC (rtt 2 $C) (rtt.sub $C (global.get $rttB)))
```
Here, `$rttA` would carry supertype vector `[$rttA]`, `$rttB` has `[$rttA, $rttB]`, and `$rttC` has `[$rttA, $rttB, $rttC]`.

Now consider a function that casts a `$B` to a `$C`:
```
(func $castBtoC (param $x (ref $B)) (result (ref $C))
  (ref.cast (local.get $x) (global.get $rttC))
)
```
This can compile to machine code that (1) reads the RTT from `$x`, (2) checks that the length of its supertype table is >= 3, and (3) pointer-compares table[2] against `$rttC`.


#### Values

* Creating a structure or array requires supplying a suitable RTT value to represent its runtime type.

* Reference values of data or function type have an associated runtime type:
  - for structures or arrays, it is the RTT value provided upon creation,
  - for functions, it is the RTT value for the function's type.

* Note: as a future extension, we could allow a value's RTT to be a supertype of the value's actual type. For example, a structure or array with RTT `any` would become fully opaque to runtime type checks, and an implementation may choose to optimize away its RTT.


### Instructions

#### Equality

* `ref.eq` compares two references whose types support equality
  - `ref.eq : [eqref eqref] -> [i32]`


#### Structures

* `struct.new_with_rtt <typeidx>` allocates a structure with RTT information determining its [runtime type](#values) and initialises its fields with given values
  - `struct.new_with_rtt $t : [t'* (rtt n $t)] -> [(ref $t)]`
    - iff `$t = struct (mut t')*`

* `struct.new_default_with_rtt <typeidx>` allocates a structure of type `$t` and initialises its fields with default values
  - `struct.new_default_with_rtt $t : [(rtt n $t)] -> [(ref $t)]`
    - iff `$t = struct (mut t')*`
    - and all `t'*` are defaultable

* `struct.get_<sx>? <typeidx> <fieldidx>` reads field `i` from a structure
  - `struct.get_<sx>? $t i : [(ref null $t)] -> [t]`
    - iff `$t = struct (mut1 t1)^i (mut ti) (mut2 t2)*`
    - and `t = unpacked(ti)`
    - and `_<sx>` present iff `t =/= ti`
  - traps on `null`

* `struct.set <typeidx> <fieldidx>` writes field `i` of a structure
  - `struct.set $t i : [(ref null $t) ti] -> []`
    - iff `$t = struct (mut1 t1)^i (var ti) (mut2 t2)*`
    - and `t = unpacked(ti)`
  - traps on `null`


#### Arrays

* `array.new_with_rtt <typeidx>` allocates an array with RTT information determining its [runtime type](#values)
  - `array.new_with_rtt $t : [t' i32 (rtt n $t)] -> [(ref $t)]`
    - iff `$t = array (var t')`

* `array.new_default_with_rtt <typeidx>` allocates an array and initialises its fields with the default value
  - `array.new_default_with_rtt $t : [i32 (rtt n $t)] -> [(ref $t)]`
    - iff `$t = array (var t')`
    - and `t'` is defaultable

* `array.get_<sx>? <typeidx>` reads an element from an array
  - `array.get_<sx>? $t : [(ref null $t) i32] -> [t]`
    - iff `$t = array (mut t')`
    - and `t = unpacked(t')`
    - and `_<sx>` present iff `t =/= t'`
  - traps on `null` or if the dynamic index is out of bounds

* `array.set <typeidx>` writes an element to an array
  - `array.set $t : [(ref null $t) i32 t] -> []`
    - iff `$t = array (var t')`
    - and `t = unpacked(t')`
  - traps on `null` or if the dynamic index is out of bounds

* `array.len` inquires the length of an array
  - `array.len : [(ref null array)] -> [i32]`
  - traps on `null`


#### Unboxed Scalars

Tentatively, support a type of guaranteed unboxed scalars.

* `i31.new` creates an `i31ref` from a 32 bit value, truncating high bit
  - `i31.new : [i32] -> [i31ref]`
  - this is a *constant instruction*

* `i31.get_<sx>` extracts the value, zero- or sign-extending
  - `i31.get_<sx> : [i31ref] -> [i32]`


#### Classification

* `ref.is_func` checks whether a reference is a function
  - `ref.is_func : [anyref] -> [i32]`

* `ref.is_data` checks whether a reference is compound data
  - `ref.is_data : [anyref] -> [i32]`

* `ref.is_i31` checks whether a reference is an i31
  - `ref.is_i31 : [anyref] -> [i32]`

* `br_on_func <labelidx>` branches if a reference is a function
  - `br_on_func $l : [t0* t] -> [t0* t]`
    - iff `$l : [t0* t']`
    - and `t <: anyref`
    - and `(ref func) <: t'`
  - passes operand along with branch as a function, plus possible extra args

* `br_on_non_func <labelidx>` branches if a reference is not a function
  - `br_on_non_func $l : [t0* t] -> [t0* (ref func)]`
    - iff `$l : [t0* t']`
    - and `t <: anyref`
    - and `t <: t'`
  - passes operand along with branch, plus possible extra args

* `br_on_data <labelidx>` branches if a reference is compound data
  - `br_on_data $l : [t0* t] -> [t0* t]`
    - iff `$l : [t0* t']`
    - and `t <: anyref`
    - and `(ref data) <: t'`
  - passes operand along with branch as data, plus possible extra args

* `br_on_non_data <labelidx>` branches if a reference is not compound data
  - `br_on_non_data $l : [t0* t] -> [t0* (ref data)]`
    - iff `$l : [t0* t']`
    - and `t <: anyref`
    - and `t <: t'`
  - passes operand along with branch, plus possible extra args

* `br_on_i31 <labelidx>` branches if a reference is an integer
  - `br_on_i31 $l : [t0* t] -> [t0* t]`
    - iff `$l : [t0* t']`
    - and `t <: anyref`
    - and `(ref i31) <: t'`
  - passes operand along with branch as a scalar, plus possible extra args

* `br_on_non_i31 <labelidx>` branches if a reference is not an integer
  - `br_on_non_i31 $l : [t0* t] -> [t0* (ref i31)]`
    - iff `$l : [t0* t']`
    - and `t <: anyref`
    - and `t <: t'`
  - passes operand along with branch, plus possible extra args

* `ref.as_func` converts to a function reference
  - `ref.as_func : [anyref] -> [(ref func)]`
  - traps if reference is not a function
  - equivalent to `(block $l (param anyref) (result funcref) (br_on_func $l) (unreachable))`

* `ref.as_data` converts to a data reference
  - `ref.as_data : [anyref] -> [(ref data)]`
  - traps if reference is not compound data
  - equivalent to `(block $l (param anyref) (result dataref) (br_on_data $l) (unreachable))`

* `ref.as_i31` converts to an integer reference
  - `ref.as_i31 : [anyref] -> [(ref i31)]`
  - traps if reference is not an integer
  - equivalent to `(block $l (param anyref) (result i31ref) (br_on_i31 $l) (unreachable))`

Note: The [reference types](https://github.com/WebAssembly/reference-types) and [typed function references](https://github.com/WebAssembly/function-references)already introduce similar `ref.is_null`, `br_on_null`, and `br_on_non_null` instructions.

Note: The `br_on_*` instructions allow an operand of unrelated reference type, even though this cannot possibly succeed. That's because subtyping allows to forget that information, so by the subtype substitutibility property, it would be accepted in any case. The given typing rules merely allow this type to also propagate to the result, which avoids the need to compute a least upper bound between the operand type and the target type in the typing algorithm.


#### Runtime Types

* `rtt.canon <typeidx>` returns the RTT of the specified type
  - `rtt.canon $t : [] -> [(rtt 0 $t)]`
  - multiple invocations of this instruction yield the same observable RTTs
  - this is a *constant instruction*

* `rtt.sub <typeidx>` returns an RTT for `typeidx` as a sub-RTT of a the parent RTT operand
  - `rtt.sub $t : [(rtt n? $t')] -> [(rtt (n+1)? $t)]`
    - iff `(type $t) <: (type $t')`
  - multiple invocations of this instruction with the same operand yield the same observable RTTs
  - this is a *constant instruction*

TODO: Add the ability to generate new (non-canonical) RTT values to implement casting in nominal type hierarchies?


#### Casts

RTT-based casts can only be performed with respect to concrete types, and require a data or function reference as input, which are known to carry an RTT.

* `ref.test` tests whether a reference value's [runtime type](#values) is a [runtime subtype](#runtime) of a given RTT
  - `ref.test : [t' (rtt n? $t)] -> [i32]`
    - iff `t' <: (ref null data)` or `t' <: (ref null func)`
  - returns 1 if the first operand is not null and its runtime type is a sub-RTT of the RTT operand, 0 otherwise

* `ref.cast` casts a reference value down to a type given by a RTT representation
  - `ref.cast : [(ref null1? ht) (rtt n? $t)] -> [(ref null2? $t)]`
    - iff `ht <: data` or `ht <: func`
    - and `null1? = null2?`
  - returns null if the first operand is null
  - traps if the first operand is not null and its runtime type is not a sub-RTT of the RTT operand

* `br_on_cast <labelidx>` branches if a value can be cast down to a given reference type
  - `br_on_cast $l : [t0* t (rtt n? $t')] -> [t0* t]`
    - iff `$l : [t0* t']`
    - and `t <: (ref null data)` or `t <: (ref null func)`
    - and `(ref $t') <: t'`
  - branches iff the first operand is not null and its runtime type is a sub-RTT of the RTT operand
  - passes cast operand along with branch, plus possible extra args

* `br_on_cast_fail <labelidx>` branches if a value can not be cast down to a given reference type
  - `br_on_cast_fail $l : [t0* t (rtt n? $t')] -> [t0* (ref $t')]`
    - iff `$l : [t0* t']`
    - and `t <: (ref null data)` or `t <: (ref null func)`
    - and `t <: t'`
  - branches iff the first operand is null or its runtime type is not a sub-RTT of the RTT operand
  - passes operand along with branch, plus possible extra args

Note: These instructions allow an operand of unrelated reference type, even though this cannot possibly succeed. The reasoning is the same as for classification instructions.


#### Constant Expressions

In order to allow RTTs to be initialised as globals, the following extensions are made to the definition of *constant expressions*:

* `rtt.canon` is a constant instruction
* `rtt.sub` is a constant instruction
* `global.get` is a constant instruction and can access preceding (immutable) global definitions, not just imports as in the MVP


## Binary Format

### Types

This extends the [encodings](https://github.com/WebAssembly/function-references/blob/master/proposals/function-references/Overview.md#types-1) from the typed function references proposal.

#### Storage Types

| Opcode | Type            |
| ------ | --------------- |
| -0x06  | `i8`            |
| -0x07  | `i16`           |

#### Reference Types

| Opcode | Type            | Parameters | Note |
| ------ | --------------- | ---------- | ---- |
| -0x10  | `funcref`       |            | shorthand, from reftype proposal |
| -0x11  | `anyref`        |            | shorthand, from reftype proposal |
| -0x13  | `eqref`         |            | shorthand |
| -0x14  | `(ref null ht)` | `ht : heaptype (s33)` | from funcref proposal |
| -0x15  | `(ref ht)`      | `ht : heaptype (s33)` | from funcref proposal |
| -0x16  | `i31ref`        |            | shorthand |
| -0x17  | `(rtt n $t)`    | `n : u32`, `i : typeidx` | shorthand |
| -0x18  | `(rtt $t)`      | `i : typeidx` | shorthand |
| -0x19  | `dataref`       |            | shorthand |
| -0x1a  | `arrayref`      |            | shorthand |

#### Heap Types

The opcode for heap types is encoded as an `s33`.

| Opcode | Type            | Parameters | Note |
| ------ | --------------- | ---------- | ---- |
| i >= 0 | `(type i)`      |            | from funcref proposal |
| -0x10  | `func`          |            | from funcref proposal |
| -0x11  | `any`           |            | from funcref proposal |
| -0x13  | `eq`            |            | |
| -0x16  | `i31`           |            | |
| -0x17  | `(rtt n i)`     | `n : u32`, `i : typeidx` | |
| -0x18  | `(rtt i)`       | `i : typeidx` | |
| -0x19  | `data`          |            | |
| -0x1a  | `array`         |            | |

#### Defined Types

| Opcode | Type            | Parameters |
| ------ | --------------- | ---------- |
| -0x21  | `struct ft*`    | `ft* : vec(fieldtype)` |
| -0x22  | `array ft`      | `ft : fieldtype`       |

#### Field Types

| Type            | Parameters |
| --------------- | ---------- |
| `field t mut`   | `t : storagetype`, `mut : mutability` |


### Instructions

| Opcode | Type            | Parameters |
| ------ | --------------- | ---------- |
| 0xd5   | `ref.eq`        |            |
| 0xd6   | `br_on_non_null` | |
| 0xfb01 | `struct.new_with_rtt $t` | `$t : typeidx` |
| 0xfb02 | `struct.new_default_with_rtt $t` | `$t : typeidx` |
| 0xfb03 | `struct.get $t i` | `$t : typeidx`, `i : fieldidx` |
| 0xfb04 | `struct.get_s $t i` | `$t : typeidx`, `i : fieldidx` |
| 0xfb05 | `struct.get_u $t i` | `$t : typeidx`, `i : fieldidx` |
| 0xfb06 | `struct.set $t i` | `$t : typeidx`, `i : fieldidx` |
| 0xfb11 | `array.new_with_rtt $t` | `$t : typeidx` |
| 0xfb12 | `array.new_default_with_rtt $t` | `$t : typeidx` |
| 0xfb13 | `array.get $t` | `$t : typeidx` |
| 0xfb14 | `array.get_s $t` | `$t : typeidx` |
| 0xfb15 | `array.get_u $t` | `$t : typeidx` |
| 0xfb16 | `array.set $t` | `$t : typeidx` |
| 0xfb17 | `array.len` | `_ : u32` (TODO: remove, was typeidx) |
| 0xfb20 | `i31.new` |  |
| 0xfb21 | `i31.get_s` |  |
| 0xfb22 | `i31.get_u` |  |
| 0xfb30 | `rtt.canon $t` | `$t : typeidx` |
| 0xfb31 | `rtt.sub $t` | `$t : typeidx` |
| 0xfb40 | `ref.test $t` | `$t : typeidx` |
| 0xfb41 | `ref.cast $t` | `$t : typeidx` |
| 0xfb42 | `br_on_cast $l` | `$l : labelidx` |
| 0xfb43 | `br_on_cast_fail $l` | `$l : labelidx` |
| 0xfb50 | `ref.is_func` | |
| 0xfb51 | `ref.is_data` | |
| 0xfb52 | `ref.is_i31` | |
| 0xfb58 | `ref.as_func` | |
| 0xfb59 | `ref.as_data` | |
| 0xfb5a | `ref.as_i31` | |
| 0xfb60 | `br_on_func` | |
| 0xfb61 | `br_on_data` | |
| 0xfb62 | `br_on_i31` | |
| 0xfb63 | `br_on_non_func` | |
| 0xfb64 | `br_on_non_data` | |
| 0xfb65 | `br_on_non_i31` | |



## JS API

See [GC JS API document](MVP-JS.md) .


## Questions

* Make rtt operands nullable?

* Make `i31.new` a constant instruction. Others too?

* Enable `i31` as a type definition.

* Should reference types be generalised to *unions*, e.g., of the form `(ref null? i31? data? func? extern? $t?)`? Perhaps even allowing multiple concrete types?

* Provide functionality to generate fresh, non-canonical RTTs?

* Provide a way to make data types non-eq, especially immutable ones?

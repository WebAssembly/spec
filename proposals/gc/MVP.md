# GC v1 Extensions

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

Both proposals are prerequisites.


### Types

#### Heap Types

[Heap types](https://github.com/WebAssembly/function-references/blob/master/proposals/function-references/Overview.md#types) classify reference types and are extended. There now are 3 disjoint hierarchies of heap types:

1. _Internal_ (values in Wasm representation)
2. _External_ (values in a host-specific representation)
3. _Functions_

Heap types `extern` and `func` already exist via [reference types proposal](https://github.com/WebAssembly/reference-types), and `(ref null? $t)` via [typed references](https://github.com/WebAssembly/function-references); `extern` and `func` are the common supertypes (a.k.a. top) of all external and function types, respectively.

The following additions are made to the hierarchies of heap types:

* `any` is a new heap type
  - `heaptype ::= ... | any`
  - the common supertype (a.k.a. top) of all internal types

* `none` is a new heap type
  - `heaptype ::= ... | none`
  - the common subtype (a.k.a. bottom) of all internal types

* `noextern` is a new heap type
  - `heaptype ::= ... | noextern`
  - the common subtype (a.k.a. bottom) of all external types

* `nofunc` is a new heap type
  - `heaptype ::= ... | nofunc`
  - the common subtype (a.k.a. bottom) of all function types

* `eq` is a new heap type
  - `heaptype ::= ... | eq`
  - the common supertype of all referenceable types on which comparison (`ref.eq`) is allowed (this may include host-defined external types)

* `struct` is a new heap type
  - `heaptype ::= ... | struct`
  - the common supertype of all struct types

* `array` is a new heap type
  - `heaptype ::= ... | array`
  - the common supertype of all array types

* `i31` is a new heap type
  - `heaptype ::= ... | i31`
  - the type of unboxed scalars

We distinguish these *abstract* heap types from *concrete* heap types `$t` that reference actual definitions in the type section.
Most abstract heap types are a supertype of a class of concrete heap types.
Moreover, they form several small [subtype hierarchies](#subtyping) among themselves.


#### Reference Types

New abbreviations are introduced for reference types in binary and text format, corresponding to `funcref` and `externref`:

* `anyref` is a new reference type
  - `anyref == (ref null any)`

* `nullref` is a new reference type
  - `nullref == (ref null none)`

* `nullexternref` is a new reference type
  - `nullexternref == (ref null noextern)`

* `nullfuncref` is a new reference type
  - `nullfuncref == (ref null nofunc)`

* `eqref` is a new reference type
  - `eqref == (ref null eq)`

* `structref` is a new reference type
  - `structref == (ref null struct)`

* `arrayref` is a new reference type
  - `arrayref == (ref null array)`

* `i31ref` is a new reference type
  - `i31ref == (ref null i31)`


#### Type Definitions

* `deftype` is the syntax for an entry in the type section, generalising the existing syntax
  - `deftype ::= rec <subtype>*`
  - `module ::= {..., types vec(<deftype>)}`
  - a `rec` definition defines a group of mutually recursive types that can refer to each other; it thereby defines several type indices at a time
  - a single type definition, as in Wasm before this proposal, is reinterpreted as a short-hand for a recursive group containing just one type
  - Note that the number of type section entries is now the number of recursion groups rather than the number of individual types. 

* `subtype` is a new category of type defining a single type, as a subtype of possible other types
  - `subtype ::= sub <typeidx>* <strtype>`
  - the preexisting syntax with no `sub` clause is redefined to be a shorthand for a `sub` clause with empty `typeidx` list: `<strtype> == sub () <strtype>`
  - Note: This allows multiple supertypes. For the MVP, it is restricted to at most one supertype.

* `strtype` is a new category of types covering the different forms of concrete structural reference types
  - `strtype ::= <functype> | <structtype> | <arraytype>`

* `structtype` describes a structure with statically indexed fields
  - `structtype ::= struct <fieldtype>*`

* `arraytype` describes an array with dynamically indexed fields
  - `arraytype ::= array <fieldtype>`

* `fieldtype` describes a struct or array field and whether it is mutable
  - `fieldtype ::= <mutability> <storagetype>`
  - `storagetype ::= <valtype> | <packedtype>`
  - `packedtype ::= i8 | i16`

TODO: Need to be able to use `i31` as a type definition.


#### Type Contexts

Validity of a module is checked under a context storing the definitions for each type. In the case of recursive types, this definition is given by a respective projection from the full type:
```
ctxtype ::= <deftype>.<i>
```

Both `C.types` and `C.funcs` in typing contexts `C` as defined by the spec now carry `ctxtype`s as opposed to `functype`s like before.
In the case of `C.funcs`, it is an invariant that all types [expand](#auxiliary-definitions) to a function type.


#### Auxiliary Definitions

* Unpacking a storage type yields `i32` for packed types, otherwise the type itself
  - `unpacked(t) = t`
  - `unpacked(pt) = i32`

* Unrolling a possibly recursive context type projects the respective item
  - `unroll($t)                 = unroll(<ctxtype>)`  iff `$t = <ctxtype>`
  - `unroll((rec <subtype>*).i) = (<subtype>*)[i]`

* Expanding a type definition unrolls it and returns its plain definition
  - `expand($t)                 = expand(<ctxtype>)`  iff `$t = <ctxtype>`
  - `expand(<ctxtype>) = <strtype>`
    - where `unroll(<ctxttype>) = sub x* <strtype>`


#### External Types

Unlike in the current spec, external function types need to be represented by a type index/address, in order to preserve the structure and equivalence of iso-recursive types:
```
externtype ::= func <typeidx> | ...
```
The type is then looked up and expanded as needed. (This was `func <functype>` before.)


#### Type Validity

Some of the rules define a type as `ok` for a certain index, written `ok(x)`. This controls uses of type indices as supertypes inside a recursive group: the subtype hierarchy must not be cyclic, and hence any type index used for a supertype is required to be smaller than the index `x` of the current type.

* a sequence of type definitions is valid if each item is valid within the context containing the prior items
  - `<deftype0> <deftype>* ok`
    - iff `<deftype0> ok` and extends the context accordingly
    - and `<deftype>* ok` under the extended context

* a group of recursive type definitions is valid if its types are valid under the context containing all of them
  - `rec <subtype>* ok` and extends the context with `<ctxtype>*`
    - iff `<subtype>* ok($t)` under the extended context(!)
    - where `$t` is the next unused (i.e., current) type index
    - and `N = |<subtype>*|-1`
    - and `<ctxtype>*  = (rec <subtype>*).0, ..., (rec <subtype>*).N`

* a sequence of subtype's is valid if each of them is valid for their respective index
  - `<subtype0> <subtype>* ok($t)`
    - iff `<subtype0> ok($t)`
    - and `<subtype>* ok($t+1)`

* an individual subtype is valid if its definition is valid, matches every supertype, and no supertype has an index higher than its own
  - `sub $t* <strtype> ok($t')`
    - iff `<strtype> ok`
    - and `(<strtype> <: expand($t))*`
    - and `($t < $t')*`
  - Note: the upper bound on the supertype indices ensures that subtyping hierarchies are never circular, because definitions need to be ordered.

* as [before](https://github.com/WebAssembly/function-references/proposals/function-references/Overview.md#types), a strtype is valid if all the occurring value types are valid
  - specifically, a concrete reference type `(ref $t)` is valid when `$t` is defined in the context

Example: Consider two mutually recursive types:
```
(rec
  (type $t1 (struct (field i32 (ref $t2))))
  (type $t2 (struct (field i64 (ref $t1))))
)
```
In the context, these will be recorded as:
```
$t1 = rect1t2.0
$t2 = rect1t2.1

where

rect1t2 = (rec
  (struct (field i32 (ref $t2)))
  (struct (field i64 (ref $t1)))
)
```
That is, the types are defined as projections from their respective recursion group, using their relative inner indices `0` and `1`.


#### Equivalence

Type equivalence, written `t == t'` here, is essentially defined inductively. All rules are simply the canonical congruences, with the exception of the rule for recursive types.

For the purpose of defining recursive type equivalence, type indices are extended with a special form that distinguishes regular from recursive type uses.

* `rec.<i>` is a new form of type index
  - `typeidx ::= ... | rec.<i>`

This form is only used during equivalence checking, to identify and represent "back edges" inside a recursive type. It is merely a technical device for formulating the rules and cannot appear in source code. It is introduced by the following auxiliary meta-function:

* Rolling a context type produces an _iso-recursive_ representation of its underlying recursion group
  - `tie($t)                    = tie_$t(<ctxtype>)`  iff `$t = <ctxtype>`
  - `tie_$t((rec <subtype>*).i) = (rec <subtype>*).i[$t':=rec.0, ..., $t'+N:=rec.N]` iff `$t' = $t-i` and `N = |<subtype>*|-1`
  - Note: This definition assumes that all projections of the recursive type are bound to consecutive type indices, so that `$t-i` is the first of them.
  - Note: If a type is not recursive, `tie` is just the identity.

With that:

* two regular type indices are equivalent if they define equivalent tied context types:
  - `$t == $t'`
    - iff `tie($t) == tie($t')`

* two recursive type indices are equivalent if they project the same index
  - `rec.i == rec.i'`
    - iff `i = i'`

* two recursive types are equivalent if they are equivalent pointwise
  - `(rec <subtype>*) == (rec <subtype'>*)`
    - iff `(<subtype> == <subtype'>)*`
  - Note: This rule is only used on types that have been tied, which prevents looping.

* notably, two subtypes are equivalent if their structure is equivalent and they have equivalent supertypes
  - `(sub $t* <strtype>) == (sub $t'* <strtype'>)`
    - iff `<strtype> == <strtype'>`
    - and `($t == $t')*`

Example: As explained above, the mutually recursive types
```
(rec
  (type $t1 (struct (field i32 (ref $t2))))
  (type $t2 (struct (field i64 (ref $t1))))
)
```
would be recorded in the context as
```
$t1 = (rec (struct (field i32 (ref $t2))) (struct (field i64 (ref $t1)))).0
$t2 = (rec (struct (field i32 (ref $t2))) (struct (field i64 (ref $t1)))).1
```
Consequently, if there was an equivalent pair of types,
```
(rec
  (type $u1 (struct (field i32 (ref $u2))))
  (type $u2 (struct (field i64 (ref $u1))))
)
```
recorded in the context as
```
$u1 = (rec (struct (field i32 (ref $u2))) (struct (field i64 (ref $u1)))).0
$u2 = (rec (struct (field i32 (ref $u2))) (struct (field i64 (ref $u1)))).1
```
then to check the equivalence `$t1 == $u1`, both types are tied into iso-recursive types first:
```
tie($t1) = (rec (struct (field i32 (ref rec.1))) (struct (field i64 (ref rec.0)))).0
tie($u1) = (rec (struct (field i32 (ref rec.1))) (struct (field i64 (ref rec.0)))).0
```
In this case, it is immediately apparent that these are equivalent types.

Note: In type-theoretic terms, these are higher-kinded iso-recursive types:
```
tie($t1) ~ (mu a. <(struct (field i32 (ref a.1))), (struct i64 (field (ref a.0)))>).0
tie($t2) ~ (mu a. <(struct (field i32 (ref a.1))), (struct i64 (field (ref a.0)))>).1
```
where `<...>` denotes a type tuple. However, in our case, a single syntactic type variable `rec` is enough for all types, because recursive types cannot nest by construction.

Note 2: This semantics implies that type equivalence checks can be implemented in constant-time by representing all types as trees in tied form and canonicalising them bottom-up in linear time upfront.

Note 3: It's worth noting that the only observable difference to the rules for a nominal type system is the equivalence rule on (non-recursive) type indices: instead of comparing the definitions of their recursive groups, a nominal system would require `$t = $t'` syntactically (at least as long as we ignore things like checking imports, where type indices become meaningless).
Consequently, using a single big recursion group in this system makes it behave like a nominal system.


#### Subtyping

##### Type Indices

In the [existing rules](https://github.com/WebAssembly/function-references/proposals/function-references/Overview.md#subtyping), subtyping on type indices required equivalence. Now it can take declared supertypes into account.

* Type indices are subtypes if they either define [equivalent](#type-equivalence) types or a suitable (direct or indirect) subtype relation has been declared
  - `$t <: $t'`
    - if `$t = <ctxtype>` and `$t' = <ctxtype'>` and `<ctxtype> == <ctxtype'>`
    - or `unroll($t) = sub $t1* $t'' $t2* strtype` and `$t'' <: $t'`
  - Note: This rule climbs the supertype hierarchy until an equivalent type has been found. Effectively, this means that subtyping is "nominal" modulo type canonicalisation.


##### Heap Types

In addition to the [existing rules](https://github.com/WebAssembly/function-references/proposals/function-references/Overview.md#subtyping) for heap types, the following are added:

* every internal type is a subtype of `any`
  - `t <: any`
    - if `t = any/eq/struct/array/i31` or `t = $t` and `$t = <structtype>` or `$t = <arraytype>`

* every internal type is a supertype of `none`
  - `none <: t`
    - if `t <: any`

* every external type is a subtype of `extern`
  - `t <: extern`
    - if `t = extern`
  - note: there may be other subtypes of `extern` in the future

* every external type is a supertype of `noextern`
  - `noextern <: t`
    - if `t <: extern`

* every function type is a subtype of `func`
  - `t <: func`
    - if `t = func` or `t = $t` and `$t = <functype>`

* every function type is a supertype of `nofunc`
  - `nofunc <: t`
    - if `t <: func`

* `structref` is a subtype of `eqref`
  - `struct <: eq`
  - TODO: provide a way to make aggregate types non-eq, especially immutable ones?

* `arrayref` is a subtype of `eqref`
  - `array <: eq`

* `i31ref` is a subtype of `eqref`
  - `i31 <: eq`

* Any concrete struct type is a subtype of `struct`
  - `$t <: struct`
     - if `$t = <structtype>`

* Any concrete array type is a subtype of `array`
  - `$t <: struct`
     - if `$t = <arraytype>`

* Any concrete function type is a subtype of `func`
  - `$t <: func`
     - if `$t = <functype>`

Note: This creates a hierarchy of *abstract* Wasm heap types that looks as follows.
```
      any  extern  func
       |
       eq
    /  |   \
i31  struct  array
```
The hierarchy consists of several disjoint sub hierarchies, each starting from one of the *top* heap types `any`, `extern`, or `func`.

All *concrete* types (of the form `$t`) are situated below either `struct`, `array`, or `func`.
Not shown in the graph are `none`, `noextern`, and `nofunc`, which are below the other "leaf" types.

A host environment may introduce additional inhabitants of type `any`
that are are in neither of the above leaf type categories.
The interpretation of such values is defined by the host environment, they are opaque within Wasm code.

Note: In the future, this hierarchy could be refined, e.g., to distinguish aggregate types that are not subtypes of `eq`.


##### Structural Types

The subtyping rules for structural types are only invoked during validation of a `sub` [type definition](#type-definitions).

* Function types are covariant on their results and contravariant on their parameters
  - `func <valtype11>* -> <valtype12>* <: func <valtype21>* -> <valtype22>*`
    - iff `(<valtype21> <: <valtype11>)*`
    - and `(<valtype12> <: <valtype22>)*`

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


##### Type Definitions

Subtyping is not defined on type definitions.


### Runtime

#### Runtime Types

* Runtime types (RTTs) are values representing concrete types at runtime. In the MVP, *canonical* RTTs are implicitly created by all instructions depending on runtime type information (recognisable by the suffix `_canon` in their mnemonics). In future versions, RTTs may become explicit values, and non-canonical versions of these instructions will be introduced.

* An RTT value r1 is *equal* to another RTT value r2 iff they both represent the same static type.

* An RTT value r1 is a *subtype* of another RTT value r2 iff they represent static types that are in a respective subtype relation.

Note: RTT values correspond to type descriptors or "shape" objects as they exist in various engines.
RTT equality can be implemented as a single pointer test by memoising RTT values.
More interestingly, runtime casts along the hierarchy encoded in these values can be implemented in an engine efficiently
by using well-known techniques such as including a vector of its (direct and indirect) super-RTTs in each RTT value (with itself as the last entry).
A subtype check between two RTT values can be implemented as follows using such a representation.
Assume RTT value v1 represents static type `$t1` and v2 type `$t2`.
Let `n1` and `n2` be the lengths of the respective supertype vectors.
To check whether v1 denotes a subtype RTT of v2, first verify that `n1 >= n2` --
if both `n1` and `n2` are known statically, this can be performed at compile time;
if either is not statically known (`$t1` and `n1` are typically unknown during a cast),
it has to be read from the respective RTT value dynamically, and `n1 >= n2` becomes a dynamic check.
Then compare v2 to the n2-th entry in v1's supertype vector.
If they are equal, v1 is a subtype RTT.
In the case of actual casts, the static type of RTT v1 (obtained from the value to cast) is not known at compile time, so `n1` is dynamic as well.
(Note that `$t1` and `$t2` are not relevant for the dynamic semantics,
but merely for validation.)

Note: This assumes that there is at most one supertype. For hierarchies with multiple supertypes, more complex tests would be necessary.

Example: Consider three types and corresponding RTTs:
```
(type $A (struct))
(type $B (sub $A (struct (field i32))))
(type $C (sub $B (struct (field i32 i64))))
```
Assume the respective RTTs for types `$A`, `$B`, and `$C` are called `$rttA`, `$rttB`, and `$rttC`.
Then, `$rttA` would carry supertype vector `[$rttA]`, `$rttB` has `[$rttA, $rttB]`, and `$rttC` has `[$rttA, $rttB, $rttC]`.

Now consider a function that casts a `$B` to a `$C`:
```
(func $castBtoC (param $x (ref $B)) (result (ref $C))
  (ref.cast_canon $C (local.get $x))
)
```
This can compile to machine code that (1) reads the RTT from `$x`, (2) checks that the length of its supertype table is >= 3, and (3) pointer-compares table[2] against `$rttC`.


#### Values

* Reference values of aggregate or function type have an associated runtime type:
  - for structures or arrays, it is the RTT value implictly produced upon creation,
  - for functions, it is the RTT value for the function's type (which may be recursive).


### Instructions

Note: Instructions not mentioned here remain the same.
In particular, `ref.null` is typed as before, despite the introduction of `none`/`nofunc`/`noextern`.


#### Equality

* `ref.eq` compares two references whose types support equality
  - `ref.eq : [eqref eqref] -> [i32]`


#### Structures

* `struct.new_canon <typeidx>` allocates a structure with canonical [RTT](#values) and initialises its fields with given values
  - `struct.new_canon $t : [t'*] -> [(ref $t)]`
    - iff `expand($t) = struct (mut t'')*`
    - and `(t' = unpacked(t''))*`
  - this is a *constant instruction*

* `struct.new_canon_default <typeidx>` allocates a structure of type `$t` with canonical [RTT](#values) and initialises its fields with default values
  - `struct.new_canon_default $t : [] -> [(ref $t)]`
    - iff `expand($t) = struct (mut t')*`
    - and all `t'*` are defaultable
  - this is a *constant instruction*

* `struct.get_<sx>? <typeidx> <fieldidx>` reads field `i` from a structure
  - `struct.get_<sx>? $t i : [(ref null $t)] -> [t]`
    - iff `expand($t) = struct (mut1 t1)^i (mut ti) (mut2 t2)*`
    - and `t = unpacked(ti)`
    - and `_<sx>` present iff `t =/= ti`
  - traps on `null`

* `struct.set <typeidx> <fieldidx>` writes field `i` of a structure
  - `struct.set $t i : [(ref null $t) ti] -> []`
    - iff `expand($t) = struct (mut1 t1)^i (var ti) (mut2 t2)*`
    - and `t = unpacked(ti)`
  - traps on `null`


#### Arrays

* `array.new_canon <typeidx>` allocates an array with canonical [RTT](#values)
  - `array.new_canon $t : [t' i32] -> [(ref $t)]`
    - iff `expand($t) = array (mut t'')`
    - and `t' = unpacked(t'')`
  - this is a *constant instruction*

* `array.new_canon_default <typeidx>` allocates an array with canonical [RTT](#values) and initialises its fields with the default value
  - `array.new_canon_default $t : [i32] -> [(ref $t)]`
    - iff `expand($t) = array (mut t')`
    - and `t'` is defaultable
  - this is a *constant instruction*

* `array.new_canon_fixed <typeidx> <N>` allocates an array with canonical [RTT](#values) of fixed size and initialises it from operands
  - `array.new_canon_fixed $t N : [t^N] -> [(ref $t)]`
    - iff `expand($t) = array (mut t'')`
    - and `t' = unpacked(t'')`
  - this is a *constant instruction*

* `array.new_canon_data <typeidx> <dataidx>` allocates an array with canonical [RTT](#values) and initialises it from a data segment
  - `array.new_canon_data $t $d : [i32 i32] -> [(ref $t)]`
    - iff `expand($t) = array (mut t')`
    - and `t'` is numeric, vector, or packed
    - and `$d` is a defined data segment
  - the 1st operand is the `offset` into the segment
  - the 2nd operand is the `size` of the array
  - traps if `offset + |t'|*size > len($d)`
  - note: for now, this is _not_ a constant instruction, in order to side-step issues of recursion between binary sections; this restriction will be lifted later

* `array.new_canon_elem <typeidx> <elemidx>` allocates an array with canonical [RTT](#values) and initialises it from an element segment
  - `array.new_canon_elem $t $e : [i32 i32] -> [(ref $t)]`
    - iff `expand($t) = array (mut t')`
    - and `$e : rt`
    - and `rt <: t'`
  - the 1st operand is the `offset` into the segment
  - the 2nd operand is the `size` of the array
  - traps if `offset + size > len($e)`
  - note: for now, this is _not_ a constant instruction, in order to side-step issues of recursion between binary sections; this restriction will be lifted later

* `array.get_<sx>? <typeidx>` reads an element from an array
  - `array.get_<sx>? $t : [(ref null $t) i32] -> [t]`
    - iff `expand($t) = array (mut t')`
    - and `t = unpacked(t')`
    - and `_<sx>` present iff `t =/= t'`
  - traps on `null` or if the dynamic index is out of bounds

* `array.set <typeidx>` writes an element to an array
  - `array.set $t : [(ref null $t) i32 t] -> []`
    - iff `expand($t) = array (var t')`
    - and `t = unpacked(t')`
  - traps on `null` or if the dynamic index is out of bounds

* `array.len` inquires the length of an array
  - `array.len : [(ref null array)] -> [i32]`
  - traps on `null`


#### Unboxed Scalars

* `i31.new` creates an `i31ref` from a 32 bit value, truncating high bit
  - `i31.new : [i32] -> [(ref i31)]`
  - this is a *constant instruction*

* `i31.get_<sx>` extracts the value, zero- or sign-extending
  - `i31.get_<sx> : [(ref null i31)] -> [i32]`
  - traps if the operand is null


#### External conversion

* `extern.internalize` converts an external value into the internal representation
  - `extern.internalize : [(ref null1? extern)] -> [(ref null2? any)]`
    - iff `null1? = null2?`
  - this is a *constant instruction*
  - note: this succeeds for all values, composing this with `extern.externalize` (in either order) yields the original value

* `extern.externalize` converts an internal value into the external representation
  - `extern.externalize : [(ref null1? any)] -> [(ref null2? extern)]`
    - iff `null1? = null2?`
  - this is a *constant instruction*
  - note: this succeeds for all values; moreover, composing this with `extern.internalize` (in either order) yields the original value


#### Casts

Casts work for both abstract and concrete types. In the latter case, they test if the operand's RTT is a sub-RTT of the target type.

* `ref.test null? <heaptype>` checks whether a reference has a given heap type
  - `ref.test rt : [(ref rt')] -> [i32]`
    - iff `rt <: trt` and `rt' <: trt` for some `trt`
  - if `rt` contains `null`, returns 1 for null, otherwise 0

* `ref.cast null? <heaptype>` tries to convert to a given heap type
  - `ref.cast rt : [(ref rt')] -> [(ref rt)]`
    - iff `rt <: trt` and `rt' <: trt` for some `tht`
  - traps if reference is not of requested type
  - if `rt` contains `null`, a null operand is passed through, otherwise traps on null
  - equivalent to `(block $l (param anyref) (result (ref rt)) (br_on_cast rt $l) (unreachable))`

* `br_on_cast <labelidx> null? <heaptype>` branches if a reference has a given heap type
  - `br_on_cast $l rt : [t0* (ref rt')] -> [t0* (ref rt')]`
    - iff `$l : [t0* t']`
    - and `(ref rt) <: t'`
    - and `rt <: trt` and `rt' <: trt` for some `trt`
  - passes operand along with branch under target type, plus possible extra args
  - if `rt` contains `null`, branches on null, otherwise does not

* `br_on_cast_fail <labelidx> null? <heaptype>` branches if a reference does not have a given heap type
  - `br_on_cast_fail $l rt : [t0* (ref rt')] -> [t0* (ref rt)]`
    - iff `$l : [t0* t']`
    - and `(ref rt') <: t'`
    - and `rt <: trt` and `rt' <: trt` for some `trt`
  - passes operand along with branch, plus possible extra args
  - if `rt` contains `null`, does not branch on null, otherwise does

Note: Cast instructions do _not_ require the operand's source type to be a supertype of the target type. It can also be a "sibling" in the same hierarchy, i.e., they only need to have a common supertype (in practice, it is sufficient to test that both types share the same top heap type.). Allowing so is necessary to maintain subtype substitutability, i.e., the ability to maintain well-typedness when operands are replaced by subtypes.

Note: The [reference types](https://github.com/WebAssembly/reference-types) and [typed function references](https://github.com/WebAssembly/function-references)already introduce similar `ref.is_null`, `br_on_null`, and `br_on_non_null` instructions. These can now be interpreted as syntactic sugar:

* `ref.is_null` is equivalent to `ref.test null ht`, where `ht` is the suitable bottom type (`none`, `nofunc`, or `noextern`)

* `br_on_null` is equivalent to `br_on_cast null ht`, where `ht` is the suitable bottom type, except that it does not forward the null value

* `br_on_non_null` is equivalent to `(br_on_cast_fail null ht) (drop)`, where `ht` is the suitable bottom type

* finally, `ref.as_non_null` is equivalent to `ref.cast ht`, where `ht` is the heap type of the operand

TODO: Should we remove the latter 3 from the typed function references proposal?


#### Constant Expressions

In order to allow RTTs to be initialised as globals, the following extensions are made to the definition of *constant expressions*:

* `i31.new` is a constant instruction
* `struct.new_canon` and `struct.new_canon_default` are constant instructions
* `array.new_canon`, `array.new_canon_default`, and `array.new_canon_fixed` are constant instructions
  - Note: `array.new_canon_data` and `array.new_canon_elem` are not for the time being, see above
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
| -0x11  | `externref`     |            | shorthand, from reftype proposal |
| -0x12  | `anyref`        |            | shorthand |
| -0x13  | `eqref`         |            | shorthand |
| -0x14  | `(ref null ht)` | `ht : heaptype (s33)` | from funcref proposal |
| -0x15  | `(ref ht)`      | `ht : heaptype (s33)` | from funcref proposal |
| -0x16  | `i31ref`        |            | shorthand |
| -0x17  | `nullfuncref`   |            | shorthand |
| -0x18  | `nullexternref` |            | shorthand |
| -0x19  | `structref`     |            | shorthand |
| -0x1a  | `arrayref`      |            | shorthand |
| -0x1b  | `nullref`       |            | shorthand |

#### Heap Types

The opcode for heap types is encoded as an `s33`.

| Opcode | Type            | Parameters | Note |
| ------ | --------------- | ---------- | ---- |
| i >= 0 | `(type i)`      |            | from funcref proposal |
| -0x10  | `func`          |            | from funcref proposal |
| -0x11  | `extern`        |            | from funcref proposal |
| -0x12  | `any`           |            | |
| -0x13  | `eq`            |            | |
| -0x16  | `i31`           |            | |
| -0x17  | `nofunc`        |            | |
| -0x18  | `noextern`      |            | |
| -0x19  | `struct`        |            | |
| -0x1a  | `array`         |            | |
| -0x1b  | `none`          |            | |

#### Structured Types

| Opcode | Type            | Parameters |
| ------ | --------------- | ---------- |
| -0x21  | `struct ft*`    | `ft* : vec(fieldtype)` |
| -0x22  | `array ft`      | `ft : fieldtype`       |

#### Subtypes

| Opcode | Type            | Parameters | Note |
| ------ | --------------- | ---------- | ---- |
| -0x21  | `struct ft*`    | `ft* : vec(fieldtype)` | shorthand |
| -0x22  | `array ft`      | `ft : fieldtype`       | shorthand |
| -0x30  | `sub $t* st`    | `$t* : vec(typeidx)`, `st : strtype` | |

#### Defined Types

| Opcode | Type            | Parameters | Note |
| ------ | --------------- | ---------- | ---- |
| -0x21  | `struct ft*`    | `ft* : vec(fieldtype)` | shorthand |
| -0x22  | `array ft`      | `ft : fieldtype`       | shorthand |
| -0x30  | `sub $t* st`    | `$t* : vec(typeidx)`, `st : strtype` | shorthand |
| -0x31  | `rec dt*`       | `dt* : vec(subtype)` | |

#### Field Types

| Type            | Parameters |
| --------------- | ---------- |
| `field t mut`   | `t : storagetype`, `mut : mutability` |


### Instructions

| Opcode | Type            | Parameters |
| ------ | --------------- | ---------- |
| 0xd5   | `ref.eq`        |            |
| 0xd6   | `br_on_non_null` | |
| 0xfb01 | `struct.new_canon $t` | `$t : typeidx` |
| 0xfb02 | `struct.new_canon_default $t` | `$t : typeidx` |
| 0xfb03 | `struct.get $t i` | `$t : typeidx`, `i : fieldidx` |
| 0xfb04 | `struct.get_s $t i` | `$t : typeidx`, `i : fieldidx` |
| 0xfb05 | `struct.get_u $t i` | `$t : typeidx`, `i : fieldidx` |
| 0xfb06 | `struct.set $t i` | `$t : typeidx`, `i : fieldidx` |
| 0xfb11 | `array.new_canon $t` | `$t : typeidx` |
| 0xfb12 | `array.new_canon_default $t` | `$t : typeidx` |
| 0xfb13 | `array.get $t` | `$t : typeidx` |
| 0xfb14 | `array.get_s $t` | `$t : typeidx` |
| 0xfb15 | `array.get_u $t` | `$t : typeidx` |
| 0xfb16 | `array.set $t` | `$t : typeidx` |
| 0xfb17 | `array.len` | |
| 0xfb19 | `array.new_canon_fixed $t N` | `$t : typeidx`, `N : u32` |
| 0xfb1b | `array.new_canon_data $t $d` | `$t : typeidx`, `$d : dataidx` |
| 0xfb1c | `array.new_canon_elem $t $e` | `$t : typeidx`, `$e : elemidx` |
| 0xfb20 | `i31.new` |  |
| 0xfb21 | `i31.get_s` |  |
| 0xfb22 | `i31.get_u` |  |
| 0xfb40 | `ref.test ht` | `ht : heaptype` |
| 0xfb41 | `ref.cast ht` | `ht : heaptype` |
| 0xfb42 | `br_on_cast $l ht` | `$l : labelidx`, `ht : heaptype` |
| 0xfb43 | `br_on_cast_fail $l ht` | `$l : labelidx`, `ht : heaptype` |
| 0xfb48 | `ref.test null ht` | `ht : heaptype` |
| 0xfb49 | `ref.cast null ht` | `ht : heaptype` |
| 0xfb4a | `br_on_cast $l null ht` | `$l : labelidx`, `ht : heaptype` |
| 0xfb4b | `br_on_cast_fail $l null ht` | `$l : labelidx`, `ht : heaptype` |
| 0xfb70 | `extern.internalize` | |
| 0xfb71 | `extern.externalize` | |


## JS API

See [GC JS API document](MVP-JS.md) .


## Questions

* Enable `i31` as a type definition.

* Should reference types be generalised to *unions*, e.g., of the form `(ref null? i31? struct? array? func? extern? $t?)`? Perhaps even allowing multiple concrete types?

* Provide a way to make aggregate types non-eq, especially immutable ones?



## Appendix: Formal Rules

### Validity

#### Type Indices (`C |- <typeidx> ok`)

```
C(x) = ct
---------
C |- x ok
```

#### Value Types (`C |- <valtype> ok`)

```

-----------
C |- i32 ok

C |- x ok
-------------
C |- ref x ok
```

...and so on.


#### Structural Types (`C |- <strtype> ok`)
```
(C |- t1 ok)*
(C |- t2 ok)*
--------------------
C |- func t1* t2* ok

(C |- ft ok)*
------------------
C |- struct ft* ok

C |- ft ok
----------------
C |- array ft ok
```

#### Sub Types (`C |- <subtype>* ok(x)`)

```
C |- st ok
(C |- st <: expand(C(x)))*
(x < x')*
--------------------------
C |- sub x* st ok(x')

C |- st ok(x)
C |- st'* ok(x+1)
-------------------
C |- st st'* ok(x)
```

#### Defined Types (`C |- <deftype>* -| C'`)

```
x = |C|    N = |st*|-1
C' = C,(rec st*).0,...,(rec st*).N
C' |- st* ok(x)
-------------------------------------
C |- rec st* -| C'

C |- dt -| C'
C' |- dt'* ok
---------------
C |- dt dt'* ok
```

#### Instructions (`C |- <instr> : [t1*] -> [t2*]`)

```
expand(C(x)) = func t1* t2*
---------------------------------------
C |- func.call : [t1* (ref x)] -> [t2*]

expand(C(x)) = struct t1^i t t2*
------------------------------------
C |- struct.get i : [(ref x)] -> [t]
```

...and so on


### Type Equivalence

#### Type Indices (`C |- <typeidx> == <typeidx'>`)

```
C |- tie(x) == tie(x')
----------------------
C |- x == x'


--------------------
C |- rec.i == rec.i
```

#### Value Types (`C |- <valtype> == <valtype'>`)

```

---------------
C |- i32 == i32

C |- x == x'
null? = null'?
---------------------------------
C |- ref null? x == ref null'? x'
```

...and so on.

#### Field Types (`C |- <fldtype> == <fldtype'>`)

```
C |- t == t'
--------------------
C |- mut t == mut t'
```

#### Structural Types (`C |- <strtype> == <strtype'>`)

```
(C |- t1 == t1')*
(C |- t2 == t2')*
------------------------------------
C |- func t1* t2* == func t1'* t2'*

(C |- ft == ft')*
----------------------------
C |- struct ft* == struct ft'*

C |- ft == ft'
--------------------------
C |- array ft == array ft'
```

#### Defined Types (`C |- <subtype> == <subtype'>`)

```
(C |- x == x')*
C |- st == st'
-----------------------------
C |- sub x* st == sub x'* st'
```

### Subtyping

#### Type Indices (`C |- <typeidx> <: <typeidx'>`)

```
C |- x == x'
------------
C |- x <: x'

unroll(C(x)) = sub (x1* x'' x2*) st
C |- x'' <: x'
-----------------------------------
C |- x <: x'
```

#### Value Types (`C |- <valtype> <: <valtype'>`)

```

---------------
C |- i32 <: i32

C |- x <: x'
null? = epsilon \/ null'? = null
---------------------------------
C |- ref null? x <: ref null'? x'
```

...and so on.

#### Field Types (`C |- <fldtype> <: <fldtype'>`)

```
C |- t == t'
--------------------
C |- mut t <: mut t'
```

#### Structural Types (`C |- <strtype> <: <strtype'>`)

```
(C |- t1' <: t1)*
(C |- t2 <: t2')*
-----------------------------------
C |- func t1* t2* <: func t1'* t2'*

(C |- ft1 <: ft1')*
-------------------------------------
C |- struct ft1* ft2* <: struct ft1'*

C |- ft <: ft'
--------------------------
C |- array ft <: array ft'
```

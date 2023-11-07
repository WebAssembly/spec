# GC Extension

## Introduction

Note: Basic support for simple [reference types](https://github.com/WebAssembly/reference-types/blob/master/proposals/reference-types/Overview.md), for [typed function references proposal](https://github.com/WebAssembly/function-references/blob/master/proposals/function-references/Overview.md), and for [type imports](https://github.com/WebAssembly/proposal-type-imports/blob/master/proposals/type-imports/Overview.md) have been carved out into separate proposals which should become the future basis for this proposal.

See [MVP](MVP.md) for a concrete v1 proposal and [Post-MVP](Post-MVP.md) for possible future features.

WARNING: Some contents of this document may have gotten out of sync with the [MVP](MVP.md) design, which is more up-to-date.


### Motivation

* Efficient support for high-level languages
  - faster execution
  - smaller modules
  - the vast majority of modern languages need it

* Provide access to industrial-strength GCs
  - at least on the web, VMs already have high performance GCs

* Non-goal: seamless interoperability between multiple languages


### Requirements

* Allocation of data structures that are garbage collected
* Allocation of byte arrays that are garbage collected
* Allow heap values from the embedder (e.g. JavaScript objects) that are garbage collected
* Unboxing of small scalar values
* Down casts as an escape hatch for the low-level type system
* Explicit low-level control over all runtime behaviour (no implicit allocation, no implicit runtime types)
* Modular (no need for shared type definitions etc.)


### Challenges

* Fast but type-safe
* Lean but sufficiently universal
* Language-independent
* Trade-off triangle between simplicity, expressiveness and performance
* Interaction with threads


### Approach

* Independent from linear memory
* Low-level *data representation types*, not high-level language types or object model
* Basic but general structure: tuples (structs), arrays, unboxed scalars
* Accept minimal amount of dynamic overhead (checked casts) as price for simplicity/universality
* Pay as you go; in particular, no effect on code not using GC, no runtime type information unless requested
* Don't introduce dependencies on GC for other features (e.g., using resources through tables)
* Make runtime type information explicit
* Extend the design iteratively, ship a minimal set of functionality fast


### Types

The sole purpose of the Wasm type system is to describe low-level data layout, in order to aid the engine compiling its access efficiently. It is *not* designed or intended to catch errors in a producer or reflect richer semantic behaviours of a source language's type system, such as distinguishing the types of data structures that have the same layout but are intended to be distinguished in the source language (e.g., different classes).

This is true for the types in this proposal as well. The introduction of managed data adds new forms of types that describe the layout of memory blocks on the heap, so that the engine knows, for example, the type of a struct being accessed, avoiding any runtime check or dispatch. Likewise, it knows the result type of this access, such that consecutive uses of the result are equally check-free. For that purpose, the type system does little more than describing the *shape* of such data.


### Potential Extensions

* Safe interaction with threads (sharing, atomic access)
* Forming unions of different types, as value types?
* Direct support for strings?
* Defining, allocating, and indexing structures as extensions to imported types?


### Efficiency Considerations

GC support should maintain Wasm's efficiency properties as much as possible, namely:

* all operations are reliably cheap, ideally constant time
* structures are contiguous, dense chunks of memory
* field accesses are single-indirection loads and stores
* allocation is fast
* no implicit allocation on the heap (e.g. boxing)
* primitive values should not need to be boxed to be stored in managed data structures
* unboxed scalars are interchangeable with references
* allows ahead-of-time compilation and code caching


### Evaluation

Example languages from three categories should be successfully implemented:

* an object-oriented language with nominal subtyping (e.g., a subset of Java, with classes, inheritance, interfaces)
* a typed functional language (e.g., a subset of ML, with closures, polymorphism, variant types)
* an untyped language (e.g., a subset of Scheme or Python or something else)


## Use Cases

### Structs and Arrays

* Want to represent first-class tuples/records/structs with static indexing
* Want to represent arrays with dynamic indexing
* Possibly want to create arrays with either fixed or dynamic length

Examples (fictional language):
```
type tup = (int, int, bool)
type vec3d = float[3]
type buf = {var pos : int, chars : char[]}

function f() {
  let t : tup = (1, 2, true)
  t.1
}

function g() {
  let v : vec3d = [1, 1, 5]
  v[1]
}

function h() {
  let b : nullable buf = {pos = 0, chars = "AAAA"}
  b.chars[b.pos]
}
```

Needs:

* user-defined structures and arrays as heap objects
* references to those as first-class values
* let

The above could map to
```
(type $tup (struct i64 i64 i32))
(type $vec3d (array (mut f64)))
(type $char-array (array (mut i8)))
(type $buf (struct (field $pos (mut i64)) (field $chars (ref $char-array))))

(func $f
  (struct.new $tup (i64.const 1) (i64.const 2) (i64.const 1))
  (let (local $t (ref $tup))
    (struct.get $tup 1 (local.get $t))
    (drop)
  )
)

(func $g
  (array.new $vec3d (f64.const 1) (i32.const 3))
  (let (local $v (ref $vec3d))
    (array.set $vec3d (local.get $v) (i32.const 2) (i32.const 5))
    (array.get $vec3d (local.get $v) (i32.const 1))
    (drop)
  )
)

(func $h
  (local $b (ref null $buf))
  (local.set $b
    (struct.new $buf
      (i64.const 0)
      (array.new $char-array (i32.const 0x41) (i32.const 4))
    )
  )
  (array.get $buf
    (struct.get $buf $chars (local.get $b))
    (struct.get $buf $pos (local.get $b))
  )
  (drop)
)
```
These functions `$f` and `$g` code introduces local with the `let` instruction (see the [typed function references proposal](https://github.com/WebAssembly/function-references/blob/master/proposals/function-references/Overview.md)) because the defined types cannot be null, such that locals of these types cannot be default-initialised.
In the case of `$h` the local is declared as nullable, however, mapping to an optional reference.
The respective access via `struct.get` may hence trap.


### Objects and Method Tables

* Want to represent objects as structures, whose first field is the method table
* Want to represent method tables themselves as structures, whose fields are function pointers
* Subtyping is relevant, both on instance types and method table types

Example (Java-ish):
```
class C {
  int a;
  void f(int i);
  int g();
}
class D extends C {
  double b;
  override int g();
  int h();
}
```

```
(type $f-sig (func (param (ref $C)) (param i32)))   ;; first param is `this`
(type $g-sig (func (param (ref $C)) (result i32)))
(type $h-sig (func (param (ref $D)) (result i32)))

(type $C (struct (ref $C-vt) (mut i32))
(type $C-vt (struct (ref $f-sig) (ref $g-sig)))    ;; all immutable
(type $D (struct (ref $D-vt) (mut i32) (mut f64))) ;; subtype of $C
(type $D-vt (struct (extend $C-vt) (ref $h-sig)))  ;; immutable, subtype of $C-vt
```

(Note: the use of `extend` in this example and others is assumed to be simple syntactic sugar for expanding the referenced structure type in place; there may be no `extend` construct in the abstract syntax or binary format; subtyping is meant to defined [structurally](#subtyping).)

Needs:

* (structural) subtyping
* immutable fields (for sound subtyping)
* universal type of references
* down casts
* dynamic linking might add a whole new dimension

To emulate the covariance of the `this` parameter, one down cast on `this` is needed in the compilation of each method that overrides a method from a base class.
For example, `D.g`:
```
(func $D.g (param $Cthis (ref $C))
  (ref.cast (local.get $Cthis) (rtt.get (ref $D)))
  (let (local $this (ref $D))
    ...
  )
)
```
The addition of [type fields](Post-MVP.md#type-parameters) may later avoid this cast.


### Closures

* Want to associate a code pointer and its environment in a GC-managed object
* Want to allow compiler of source language to choose appropriate environment representation

Example:
```
function outer(x : float) : float -> float {
  let a = x + 1.0
  function inner(y : float) {
    return y + a + x
  }
  return inner
}

function caller() {
  return outer(1.0)(2.0)
}
```

```
(type $code-f64-f64 (func (param $env (ref $clos-f64-f64)) (param $y f64) (result f64)))
(type $clos-f64-f64 (struct (field $code (ref $code-f64-f64)))
(type $inner-clos (struct (extend $clos-f64-f64) (field $x f64) (field $a f64))

(func $outer (param $x f64) (result (ref $clos-f64-f64))
  (struct.new $inner-clos
    (ref.func $inner)                       ;; code
    (local.get $x)                          ;; x
    (f64.add (local.get $x) (f64.const 1))  ;; a
  )  ;; (ref $clos-f64-f64) by subtyping
)

(func $inner (param $clos (ref $clos-f64-f64)) (param $y f64) (result f64)
  (ref.cast (local.get $clos) (rtt.get (ref $inner-clos)))
  (let (result f64) (local $env (ref $inner-clos))
    (local.get $y)
    (struct.get $inner-clos $a (local.get $env))
    (f64.add)
    (struct.get $inner-clos $x (local.get $env))
    (f64.add)
  )
)

(func $caller (result f64)
  (call $outer (f64.const 1))
  (let (result f64) (local $clos (ref $clos-f64-f64))
    (call_ref
      (local.get $clos)
      (f64.const 2)
      (struct.get $clos-f64-f64 $code (local.get $clos))
    )
  )
)
```

Needs:
* function pointers
* (mutually) recursive function types
* down casts

The down cast for the closure environment is necessary to go from the abstract closure type to the concrete.
Statically type checking this would require (first-class) [type fields](Post-MVP.md#type-parameters), a.k.a. existential types.

Note that this example shows just one way to represent closures (with flattened closure environment).
The proposal provides all necessary primitives allowing high-level language compilers to choose other representations.

An alternative is to provide [primitive support](#closures) for closures, e.g. a partial application operator.


### Parametric Polymorphism

* Dynamic languages or static languages with sufficiently expressive parametric polymorphism (generics) often require a *uniform representation*, where all its data types are represented in a single word.
* Typically, pointer tagging is used to unbox small scalars.
* Want to be able to represent this with type `anyref`.

Contrived example (fictional language):
```
function make_pair<A, B>(a : A, b : B) : (A, B) {
  return (a, b);
}

class C {...};
function f() {
  ...
  make_pair<Bool, Bool>(true, false)
  ...
  make_pair<C, C>(new C, new C)
  ...
}

function fst<A>(p : (A, A)) : A { let (a, _) = p; return a }
function snd<A>(p : (A, A)) : A { let (_, a) = p; return a }

function g(p1 : (Bool, Bool), p2 : (C, C), pick : <A> ((A, A)) -> A) : C {
  if (pick<Bool>(p1))
    return pick<C>(p2);
  else
    return new C;
}
```

Here, `make_pair` as well as `fst` and `snd` need to be able to operate on any type of pair. Furthermore, `fst` and `snd` cannot simply be type-specialised at compile time, because that would be insufficient to compile `g`, which takes a polymorphic function as an argument and instantiates it with multiple different types. Such *first-class* polymorphism is not expressible with compile time techniques such as C++ templates, but common-place in many languages (including OO ones like Java or C#, where it can be emulated via generic methods). Untyped languages like JavaScript or Scheme trivially allow such programs as well.

The problem is that the compilation of `fst` and `snd` must not depend on the type they are instantiated with because with first-class polymorphism it is not generally possible to tell, at compile time, the set of all such types (static analysis can do that in many cases but not all).
Unless willing to implement runtime code specialisation (like C# / .NET) a type-agnostic compilation scheme is necessary.

The usual implementation technique is a uniform representation, potentially refined with local unboxing and type specialisation optimisations.

The MVP proposal does not directly support parametric polymorphism (see the discussion of [type parameters](Post-MVP.md#type-parameters)).
However, compilation with a uniform representation can still be achieved in this proposal by consistently using the type  `anyref`, which is the super type of all references, and then down-cast from there:
```
(type $pair (struct anyref anyref))

(func $make_pair (param $a anyref) (param $b anyref) (result (ref $pair))
  (struct.new $pair (local.get $a) (local.get $b))
)


(type $C (struct ...))

(func $new_C (result (ref $C)) ...)
(func $f
  ...
  (call $make_pair (ref.i31 1) (ref.i31 0))
  ...
  (call $make_pair (call $new_C) (call $new_C))
  ...
)

(func $fst (param $p (ref $pair)) (result anyref)
  (struct.get $pair 0 (get_local $p))
)
(func $snd (param $p (ref $pair)) (result anyref)
  (struct.get $pair 1 (get_local $p))
)

(type $pick (func (param $pair) (result anyref)))
(func $g
  (param $p1 (ref $pair)) (param $p2 (ref $pair)) (param $pick (ref $pick))
  (result (ref $C))
  (if (i31.get_u (ref.cast (call_ref $pick (local.get $p1))) (rtt.get i31ref))
    (then (ref.cast (call_ref $pick (local.get $p2)) (rtt.get (ref $C))))
    (else (call $new_C))
  )
)
```
Note how type [`i31ref`](#tagged-integers) avoids Boolean values to be heap-allocated.
Also note how a down cast is necessary to recover the original type after a value has been passed through (the compiled form of) a polymorphic function like `g` -- the compiler knows the type but Wasm does not.

(Future versions of Wasm should support [type parameters](Post-MVP.md#type-parameters) to make such use cases more efficient and avoid the excessive use of runtime types to compile source language polymorphism, but for the GC MVP this provides the necessary expressiveness.)

Needs:
* `anyref`
* `i31ref`
* down casts


## Basic Functionality: Simple Aggregates

* Extend the Wasm type section with type constructors to express aggregate types
* Extend the value types with new constructors for references (split out into [reference types](https://github.com/WebAssembly/reference-types/blob/master/proposals/reference-types/Overview.md) and [typed function references proposal](https://github.com/WebAssembly/function-references/blob/master/proposals/function-references/Overview.md) proposals)


### Structures

*Structure* types define aggregates with _heterogeneous fields_ that are _statically indexed_:
```
(type $time (struct (field i32) (field f64)))
(type $point (struct (field $x f64) (field $y f64) (field $z f64)))
```
Such types can be used by forming [typed reference types](https://github.com/WebAssembly/function-references/blob/master/proposals/function-references/Overview.md), which are a new form of value type.
Fields are *accessed* with generic load/store instructions that take a reference to a structure.
For example:
```
(func $f (param $p (ref $point))
  (struct.set $point $y (local.get $p)
    (struct.get $point $x (local.get $p))
  )
)
```
All accesses are type-checked at validation time.
The structure operand of `struct.get/set` may either be a `ref` or an `ref null` for a structure type
In the latter case, the access involves a runtime null check that will trap upon failure.

Structures are *allocated* with the `struct.new` instruction that accepts initialization values for each field.
The operator yields a reference to the respective type:
```
(func $g
  (call $f (struct.new $point (i32.const 1) (i32.const 2) (i32.const 3)))
)
```
Structures are *managed* -- i.e., garbage-collected -- so manual deallocation is neither required nor possible.


### Arrays

*Array* types define aggregates with _homogeneous elements_ that are _dynamically indexed_:
```
(type $vector (array (mut f64)))
(type $matrix (array (mut (ref $vector))))
```
Array types are used by forming reference types.
For now, we assume that all array types have a ([flexible](#flexible-aggregates)) length dynamically computed at allocation time.

Elements are accessed with generic load/store instructions that take a reference to an array:
```
(func $f (param $v (ref $vector))
  (array.get $vector (local.get $v) (i32.const 1)
    (array.set $vector (local.get $v) (i32.const 2))
  )
)
```
The element type of every access is checked at validation time.
The array operand of `array.get/set` may either be a `ref` or an `ref null` for an array type
In the latter case, the access involves a runtime null check that will trap upon failure.
The index is checked against the array's length at execution time.
A trap occurs if the index is out of bounds.

Arrays are *allocated* with the `array.new` instruction that takes an initialization value and a length as operands, yielding a reference:
```
(func $g
  (call $f (array.new $vector (f64.const 3.14) (i32.const 1)))
)
```

The *length* of an array, i.e., the number of elements, can be inquired via the `array.len` instruction:
```
(array.len $vector (local.get $v))
```

Like structures, arrays are garbage-collected.


### Packed Fields

Structure and array fields can have a packed *storage type* `i8` or `i16`:
```
(type $s (struct (field $a i8) (field $b i16)))
(type $buf (array (mut i8)))
```
Loads of packed fields require a sign extension mode:
```
(struct.get_s $s $a (...))
(struct.get_u $s $a (...))
(array.get_s $s $a (...))
(array.get_u $s $a (...))
```


### Mutability

Fields can either be immutable or *mutable*:
```
(type $s (struct (field $a (mut i32)) (field $b i32)))
(type $a (array (mut i32)))
```
Store operators are only valid when targeting a mutable field or element.
Immutable fields can only be stored to as part of an allocation.

Immutability needs to be distinguished in order to enable safe and efficient [subtyping](#subtyping), especially as needed for the [objects](#objects-and-method-tables) use case.


### Reference Equality

References can be compared for identity:
```
(ref.eq (struct.new $point ...) (struct.new $point ...))  ;; false
```
The `ref.eq` instruction expects two operands of type `eqref`, which is a subtype of `anyref` and the supertype of all reference types that support equality checks.
That includes structure and array references as well as [tagged integers](#tagged-integers), but not function references.


### Nullability & Defaultability

These notions are already introduced by [typed function references](https://github.com/WebAssembly/function-references/blob/master/proposals/function-references/Overview.md) and carry over to the new forms of reference types in this proposal.

Plain references cannot be null,
avoiding any runtime overhead for null checks when accessing a struct or array.
Nullable references are available as separate types called `ref null`, as per the .

Most value types, including all numeric types and nullable references are *defaultable*, which means that they have 0 or null as a default value.
Other reference types are not defaultable.

Allocations of aggregates with non-defaultable fields or elements must have initializers.

Objects whose members all have _mutable_ and _defaultable_ type may be allocated without initializers:
```
(type $s (struct (field $a (mut i32)) (field (mut (ref $s)))))
(type $a (array (mut f32)))

(struct.new_default $s)
(array.new_default $a (i32.const 100))
```

TODO (post-MVP): How to create interesting immutable arrays?


## Other Reference Types

### Universal Type

This type is already introduced by the [reference types proposal](https://github.com/WebAssembly/reference-types/blob/master/proposals/reference-types/Overview.md).

The type `anyref` can hold references of any reference type.
It can be formed via [up casts](#casting),
and the original type can be recovered via [down casts](#casting).


### Imported Types

These are available through the [type imports proposal](https://github.com/WebAssembly/proposal-type-imports/blob/master/proposals/type-imports/Overview.md).

Types can be exported from and imported into a module:
```
(type (export "T") (type (struct ...)))
(type (import "env" "T"))
```

Imported types are essentially parameters to the module.
If no further constraints are given, they are entirely abstract, as far as compile-time validation is concerned.
The only operations possible with them are those that do not require knowledge of their actual definition or size: primarily, passing and storing references to such types.

Type imports can also specify constraints that (partially) reveal their definition, such that operations are enables, e.g., field accesses to a struct type.

Imported types can participate as the source in casts if associated RTTs are imported that enable revealing a subtype.

Imported types are not per se abstract at runtime. They can participate in casts if associated RTTs are constructed or imported (including implicitly, as in `call_indirect`).


### Host Types

These are enabled by the [type imports proposal](https://github.com/WebAssembly/proposal-type-imports/blob/master/proposals/type-imports/Overview.md).

The embedder may define its own set of types (such as DOM objects) or allow the user to create their own types using the embedder API (including a subtype relation between them).
Such *host types* can be [imported](import-and-export) into a module, where they are treated as opaque data types.

There are no operations to manipulate such types, but a WebAssembly program can receive references to them as parameters or results of imported/exported Wasm functions. Such "foreign" references may point to objects on the _embedder_'s heap. Yet, they can safely be stored in or round-trip through Wasm code.
```
(type $Foreign (import "env" "Foreign"))
(type $s (struct (field $a i32) (field $x (ref $Foreign)))

(func (export "f") (param $x (ref $Foreign))
  ...
)
```

### Function References

Function references are already introduced by the [typed function references proposal](https://github.com/WebAssembly/function-references/blob/master/proposals/function-references/Overview.md).

References can also be formed to function types, thereby introducing the notion of _typed function pointer_.

Function references can be called through `call_ref` instruction:
```
(type $t (func (param i32))

(func $f (param $x (ref $t))
  (call_ref (i32.const 5) (local.get $x))
)
```
Unlike `call_indirect`, this instruction is statically typed and does not involve any runtime check.

Values of function reference type are formed with the `ref.func` operator:
```
(func $g (param $x (ref $t))
  (call $f (ref.func $h))
)

(func $h (param i32) ...)
```

### Unboxed Scalars

Efficient implementations of untyped languages or languages with [polymorphism](#parametric-polymorphism) often rely on a _uniform representation_, meaning that all values are represented in a single machine word -- usually a pointer.
At the same time, they want to avoid the cost of boxing as much as possible, by passing around small scalar values (such as bools, enums, characters, small integer types) unboxed and using a tagging scheme to distinguish them from pointers in the GC.

To implement any such language efficiently, Wasm needs to provide such a mechanism. This proposal therefor introduces a built-in reference type `i31ref` that can be implemented in an engine via tagged integers. Producers may use this type to request unboxing for scalars. With this type a producer can convey to an engine that the value range is sufficiently limited that it _only_ needs to handle unboxed values, and no hidden branches or allocations need to be generated to handle overflow into a boxed representation, as would potentially be necessary for larger value ranges.

There are only three instructions for converting from and to this reference type:
```
ref.i31 : [i32] -> [i31ref]
i31.get_u : [i31ref] -> [i32]
i31.get_s : [i31ref] -> [i32]
```
The first is essentially a "tag" instruction, while the other two are two variants of the inverse "untag" operation, either with or without sign extension to 32 bits.

Being reference types, unboxed scalars can be cast into `anyref`, and can participate in runtime type checks and dispatch with `ref.cast` or `br_on_cast`.

To avoid portability hazards, the value range of `i31ref` has to be restricted to at most 31 bits, since that is the widest range that can be guaranteed to be efficiently representable on all platforms.

Note: As a future extension, Wasm could also introduce wider integer references, such as `i32ref`. However, these sometimes will have to be boxed on some platforms, introducing the unpredictable cost of possible "hidden" allocation upon creation or branching upon access. They hence serve a different use case.


## Type Structure

### Type Grammar

The overall type syntax can be captured in the following grammar:
```
num_type       ::=  i32 | i64 | f32 | f64
ref_type       ::=  (ref <cons_type>)
cons_type      ::=  opt? <typeidx> | i31 | func | eq | any | null
value_type     ::=  <num_type> | <ref_type>

packed_type    ::=  i8 | i16
storage_type   ::=  <value_type> | <packed_type>
field_type     ::=  <storage_type> | (mut <storage_type>)

data_type      ::=  (struct <field_type>*) | (array <field_type>)
func_type      ::=  (func <value_type>* <value_type>*)
def_type       ::=  <data_type> | <func_type>
```
where `value_type` is the type usable for parameters, local variables and the operand stack, and `def_type` describes the types that can be defined in the type section.

Note that for the MVP, an additional restriction on the above grammar is that array fields must be mutable.

### Type Recursion

Through references, aggregate types can be *recursive*:
```
(type $list (struct (field i32) (field (ref $list))))
```
Mutual recursion is possible as well:
```
(type $tree (struct (field i32) (field (ref $forest))))
(type $forest (struct (field (ref $tree)) (field (ref $forest))))
```

The [type grammar](#type-grammar) does not make recursion explicit. Semantically, it is assumed that types can be infinite regular trees by expanding all references in the type section, as is standard.
Folding that into a finite representation (such as a graph) is an implementation concern.


### Type Equivalence

In order to avoid type incompatibilities at module boundaries,
all types are structural.
Aggregate types are considered equivalent when the unfoldings of their definitions are (note that field names are not part of the actual types, so are irrelevant):
```
(type $pt (struct (i32) (i32) (i32)))
(type $vec (struct (i32) (i32) (i32)))  ;; vec = pt
```
This extends to nested and recursive types:
```
(type $t1 (struct (type $pt) (ptr $t2)))
(type $t2 (struct (type $pt) (ptr $t1)))  ;; t2 = t1
(type $u (struct (type $vec) (ptr $u)))   ;; u = t1 = t2
```
Note: This is the standard definition of recursive structural equivalence for "equi-recursive" types.
Checking it is computationally equivalent to checking whether two DFAs are equivalent, i.e., it is a non-trivial algorithm (even though most practical cases will be trivial).
This may be a problem, in which case we need to fall back to a more restrictive definition, although it is unclear what exactly that would be.


### Subtyping

Subtyping is designed to be _non-coercive_, i.e., never requires any underlying value conversion.

The subtyping relation is the reflexive transitive closure of a few basic rules:

1. The `anyref` type is a supertype of every reference type (top reference type).
2. The `funcref` type is a supertype of every function type.
3. A structure type is a supertype of another structure type if its field list is a prefix of the other (width subtyping).
4. A structure type also is a supertype of another structure type if they have the same fields and for each field type:
   - The field is mutable in both types and the storage types are the same.
   - The field is immutable in both types and their storage types are in (covariant) subtype relation (depth subtyping).
5. An array type is a supertype of another array type if:
   - Both element types are mutable and the storage types are the same.
   - Both element types are immutable and their storage types are in
(covariant) subtype relation (depth subtyping).
6. A function type is a supertype of another function type if they have the same number of parameters and results, and:
   - For each parameter, the supertype's parameter type is a subtype of the subtype's parameter type (contravariance).
   - For each result, the supertype's parameter type is a supertype of the subtype's parameter type (covariance).

Note: Like [type equivalence](#type-equivalence), (static) subtyping is *structural*.
The above is the standard (co-inductive) definition, which is the most general definition that is sound.
Checking it is computationally equivalent to checking whether one DFA recognises a sublanguage of another DFA, i.e., it is a non-trivial algorithm (even though most practical cases will be trivial).
Like with type equivalence, this may be a problem, in which case a more restrictive definition might be needed.

Subtyping could be relaxed such that mutable fields and elements could be subtypes of immutable ones.
That would simplify creation of immutable objects, by first creating them as mutable, initialize them, and then cast away their constness.
On the other hand, it means that immutable fields can still change, preventing various access optimizations.
Another alternative would be a three-point mutability lattice with readonly as a top value and mutable and immutable as two incomparable smaller values.


### Casting and Runtime Types

The Wasm type system is intentionally simple.
That implies that it cannot be expressive enough to track all type information that is available in a source program.
To allow producers to work around the inevitable limitations of the type system, down casts have to provided as an "escape hatch".
For example, that allows the use of type `anyref` to represent reference values whose type is not locally known.
When such a value is used in a context where the producer knows its real type, it can use a down cast to recover it.

For safety, down casts have to be checked at runtime by the engine. Down casts hence need a runtime representation of Wasm types: runtime types (RTT). To avoid hidden cost and make RTTs optional when not needed, all runtime types are explicit operand values (*witnesses*). For example:
```
(ref.cast (<operand>) (<rtt>))
```
This instruction checks whether the runtime type stored in `<operand>` is a runtime subtype of the runtime type represented by the second operand.

In order to cast down the type of a struct or array, the aggregate itself must be equipped with a suitable RTT. Attaching runtime type information to aggregates happens at allocation time.
A runtime type is an expression of type `rtt <type>`, which is another form of opaque value type. It represents the static type `<type>` at runtime.
In its plain form, a runtime type is obtained using the instruction `rtt.get`
```
(rtt.canon <type>)
```
For example, this can be used to cast down from `dataref` to a concrete type:
```
(ref.cast (<operand>) (rtt.canon <type>))
```

More generally, runtime type checks can verify a subtype relation between runtime types.
In order to make these checks cheap, runtime subtyping follows a *nominal* semantics. To that end, every RTT value may not only represents a given type, it can also record a subtype relation to another (runtime) type (possibly `anyref`) defined when constructing the RTT value:
```
(rtt.sub <type> (<rtt>))
```
This creates a new witness for `<type>` and defines it to be a subtype of the runtime type expressed by `<rtt>`.
Validation ensures that `<type>` is a static subtype of the type denoted by `<rtt>`. Consequently, runtime subtyping is always a subrelation of static subtyping, as required for soundness.

The above form of cast traps in case of a type mismatch. This form is useful when using casts to work around limitations of the Wasm type system, in cases where the producer knows that it will succeed.

Another variant of down cast avoids the trap:
```
(br_on_cast $label (<operand>) (<rtt>))
```
This branches to `$label` if the check is successful, with the operand as an argument, but using its refined type. Otherwise, the operand remains on the stack. By chaining multiple of these instructions, runtime type analysis ("typecase") can be implemented:
```
(block $l1 (result (ref $t1))
  (block $l2 (result (ref $t2))
    (block $l3 (result (ref $t3))
      (local.get $operand)  ;; has type (ref $t)
      (br_on_cast $l1 (ref $t) (ref $t1) (rtt.get (ref $t1)))
      (br_on_cast $l2 (ref $t) (ref $t2) (rtt.get (ref $t2)))
      (br_on_cast $l3 (ref $t) (ref $t3) (rtt.get (ref $t3)))
      ... ;; (ref $t) still on stack here
    )
    ... ;; (ref $t3) on stack here
  )
  ... ;; (ref $t2) on stack here
)
... ;; (ref $t1) on stack here
```

There are a number of reasons to make RTTs explicit:

* It makes all data and cost (in space and time) involved in casting explicit, which is a desirable property for an "assembly" language.

* It allows more choice in producers' use of RTT information, including making it optional (post-MVP), in accordance with the pay-as-you-go principle: for example, structs that are not involved in any casts do not need to pay the overhead of carrying runtime type information (depending on specifics of the GC implementation strategy). Some languages may never need to introduce any RTTs at all.

* Most importantly, making RTTs explicit separates the concerns of casting from Wasm-level polymorphism, i.e., [type parameters](Post-MVP.md#type-parameters). Type parameters can thus be treated as purely a validation artifact with no bearing on runtime. This property, known as parametricity, drastically simplifies the implementation of such type parameterisation and avoids the substantial hidden costs of reified generics that would otherwise hvae to be paid for every single use of type parameters (short of non-trivial cross-procedural dataflow analysis in the engine).


## Future Extensions

In the spirit of an MVP (minimal viable product), the features discussed so far are intentionally limited to a minimum of functionality.
Many [additional extensions](Post-MVP.md) are expected before GC support can be considered "complete".

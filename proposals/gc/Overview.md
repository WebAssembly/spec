# GC Extension

## Introduction

Note: Basic support for simple [reference types](https://github.com/WebAssembly/reference-types/blob/master/proposals/reference-types/Overview.md) and for [typed function references proposal](https://github.com/WebAssembly/function-references/blob/master/proposals/function-references/Overview.md) have been carved out into separate proposals which should become the future basis for this proposal.


See [MVP](MVP.md) for a concrete v1 proposal.


### Motivation

* Efficient support for high-level languages
  - faster execution
  - smaller modules
  - the vast majority of modern languages need it

* Efficient interoperability with embedder
  - for example, DOM objects on the web
  - no space leaks from mapping bidirectional tables

* Provide access to industrial-strength GCs
  - at least on the web, VMs already have high performance GCs

* Non-goal: seamless interoperability between multiple languages


### Challenges

* Fast but type-safe
* Lean but sufficiently universal
* Language-independent
* Trade-off triangle between simplicity, expressiveness and performance
* Interaction with threads


### Approach

* Only basic but general structure: tuples (structs) and arrays
* No heavyweight object model
* Independent from linear memory
* Accept minimal amount of dynamic overhead (checked casts) as price for simplicity/universality
* Pay as you go; in particular, no effect on code not using GC, no runtime type information unless requested
* Don't introduce dependencies on GC for other features (e.g., using resources through tables)
* Avoid generics or other complex type structure _if possible_
* Make runtime type information explicit
* Extend the design iteratively, ship a minimal set of functionality fast


### Requirements

* Allocation of data structures that are garbage collected
* Allocation of byte arrays that are garbage collected
* Allow heap values from the embedder (e.g. JavaScript objects) that are garbage collected
* Manipulating references to these as value types
* Down casts as an escape hatch
* Forming unions of different types, as value types? (future extension?)
* Defining, allocating, and indexing structures as extensions to imported types? (future extension)
* Exceptions (separate proposal)
* Safe interaction with threads (sharing, atomic access)

### Potential Extensions

* Forming unions of different types, as value types (future extension?)
* Direct support for strings (separate proposal)


### Efficiency Considerations

GC support should maintain Wasm's efficiency properties as much as possible, namely:

* all operations are very cheap, ideally constant time
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

Example (fictional language):
```
type tup = (int, int, bool)
type vec3d = float[3]
type buf = {pos : int, buf : char[]}
```

Needs:

* user-defined structures and arrays as heap objects
* references to those as first-class values

The above could map to
```
(type $tup (struct i64 i64 i32))
(type $vec3d (array f64))
(type $buf (struct (field $pos i64) (field $buf (array $char))))
```


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

(Note: the use of `extend` in this example and others is assumed to be simple syntactic sugar for expanding the referenced structure type in place; there may be no `extend` construct in the abstract syntax or binary format; subtyping still is meant to defined [structurally](#subtyping).)

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
  (local $this (ref $D))
  (set_local $this (ref.cast (ref $Cthis) (ref $D) (get_local $Cthis)))
  ...
)
```


### Closures

* Want to associate a code pointer and its "environment" in a GC-managed object
* Want to be able to allow compiler of source language to choose appropriate environment representation

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
  (ref_func $inner)
  (get_local $x)
  (f64.add (get_local $x) (f64.const 1))
  (new $inner-clos)
  (cast_up $clos-f64-f64)
)

(func $inner (param $clos (ref $clos-f64-f64)) (param $y f64) (result f64)
  (local $env (ref $inner-clos))
  (block $fail (result (ref $clos-f64-f64))
    (set_local $env (cast_down (ref $clos-f64-f64) (ref $inner-clos) $fail (get_local $clos)))
    (get_local $y)
    (get_field $env $a (get_local $inner-clos))
    (f64.add)
    (get_field $env $x (get_local $inner-clos))
    (f64.add)
    (return)
  )
  (unreachable)
)

(func $caller (result f64)
  (local $clos (ref $clos-f64-f64))
  (set_local $clos (call $outer (f64.const 1)))
  (call_ref
    (get_local $clos)
    (f64.const 2)
    (get_field $clos-f64-f64 $code (get_local $clos))
  )
)
```

Needs:
* function pointers
* (mutually) recursive function types
* up & down casts

The down cast for the closure environment is necessary because statically type checking it would require first-class generics and existential types.

Note that this example shows just one way to represent closures ("display closures").
WebAssembly should provide primitives that allow high-level language compilers to choose specific, efficient representations for closures in their source programs.
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
  make_pair<Bool, Bool>(true, false);
  make_pair<C, C>(new C, new C);
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
Unless willing to implement runtime compilation and type specialisation (like C# / .NET) a type-agnostic compilation scheme is necessary.

The usual implementation technique is a uniform representation, potentially refined with local unboxing and type specialisation optimisations.

The MVP proposal does not directly support parametric polymorphism (yet).
However, compilation with a uniform representation can still be achieved in this proposal by consistently using the type  `anyref`, which is the super type of all references, and then down-cast from there:
```
(type $pair (struct anyref anyref))

(func $make_pair (param $a anyref) (param $b anyref) (result (ref $pair))
  (struct.new $pair (get_local $a) (get_local $b))
)

(type $C (struct ...))
(func $new_C (result (ref $C)) ...)
(func $f
  (drop (call $make_pair (i31ref.new 1) (i32ref.new 0)))
  (drop (call $make_pair (call $new_C) (call $new_C)))
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
  (if (i31ref.get_u (cast_down i31ref (call_ref $pick (get_local $p1))))
    (then (cast_down (ref $C) (call_ref $pick (get_local $p2))))
    (else (call $new_C))
  )
)
```
Note how type [`i31ref`](#tagged-integers) avoids Boolean values to be heap-allocated.
Also note how a down cast is necessary to recover the original type after a value has been passed through (the compiled form of) a polymorphic function like `g` -- the compiler knows the type but Wasm does not.

(Future versions of Wasm should support simple polymorphism to make such use cases more efficient and avoid the excessive use of runtime types to express polymorphism, but for the GC MVP this provides the necessary expressiveness.)

Needs:
* `anyref`
* `i31ref`
* down casts


### Type Export/Import

* Want to allow type definitions to be imported from other modules
* As much as possible of the above constructions should be allowed with abstract types
* More complicated linking patterns might require user-space linking hooks
* Possibly: allow abstract type exports (encapsulation)?
* Lots of tricky details here, mostly ignore for now...


## Basic Functionality: Simple Aggregates

* Extend the Wasm type section with type constructors to express aggregate types
* Extend the value types with new constructors for references and interior references
* Aggregate types are not value types, only references to them are
* References are never null; nullable reference types are separate


### Structures

*Structure* types define aggregates with heterogeneous fields that are _statically indexed_:
```
(type $time (struct (field i32) (field f64)))
(type $point (struct (field $x f64) (field $y f64) (field $z f64)))
```
Such types can be used by forming *reference types*, which are a new type of value type:
```
(local $var (ref $point))
```

Fields are *accessed* with generic load/store instructions that take a reference to a structure:
```
(func $f (param $p (ref $point))
  (store_field $point $y (get_local $p)
    (load_field $point $x (get_local $p))
  )
)
```
All accesses are type-checked at validation time.

Structures are *allocated* with a `new` instruction that accepts initialization values for each field.
The operator yields a reference to the respective type:
```
(func $g
  (call $g (new $point (i32.const 1) (i32.const 2) (i32.const 3)))
)
```
Structures are garbage-collected.

Structures can be compared for identity:
```
(same (new $point ...) (new $point ...))  ;; false
```
TODO: Could even allow equality comparisons between operands of different type, but that might lead to some discontinuities or even prevent some potential optimizations?


### Arrays

*Array* types define aggregates with _homogeneous elements_ that are _dynamically indexed_:
```
(type $vector (array f64))
(type $matrix (array (type $vector)))
```
Array types again can be used by forming reference types.
For now, we assume that all array types have a ([flexible](#flexible-aggregates)) length computed at allocation time.

Elements are accessed with generic load/store instructions that take a reference to an array:
```
(func $f (param $v (ref $vector))
  (store_elem $vector (get_local $v) (i32.const 1)
    (load_elem $vector (get_local $v) (i32.const 2))
  )
)
```
The element type of every access is checked at validation time.
The index is checked against the array's length at execution time.
A trap occurs if the index is out of bounds.

Arrays are *allocated* with a `new` instruction that takes a length and an initialization value as operands, yielding a reference:
```
(func $g
  (call $f (new $vector (i32.const 0) (f64.const 3.14)))
)
```

The *length* of an array, i.e., the number of elements, can be inquired via the `load_array_length` instruction:
```
(load_array_length $vector (get_local $v))
```

Like structures, arrays can be compared for identity.


### Packed Fields

Fields and elements can have a packed *storage type* `i8` or `i16`:
```
(type $s (struct (field $a i8) (field $b i16)))
(type $buf (array i8))
```
The order of fields is not observable, so implementations are free to reorganize the underlying storage, e.g. for alignment.

Packed fields require special load/store instructions:
```
(load_field_packed_s $s $a (...))
(load_field_packed_u $s $a (...))
(store_field_packed $s $a (...) (...))
(load_elem_packed_s $s $a (...))
(load_elem_packed_u $s $a (...))
(store_elem_packed $s $a (...) (...))
```


### Mutability

Fields and elements can either be immutable or *mutable*:
```
(type $s (struct (field $a (mut i32)) (field $b i32)))
(type $a (array (mut i32)))
```
Store operators are only valid when targeting a mutable field or element.
Immutable fields can only be stored to as part of an allocation.

Immutability is needed to enable the safe and efficient [subtyping](#subtyping), especially as needed for the [objects](#objects-and-method-tables) use case.


### Nullability

By default references cannot be null,
avoiding any runtime overhead for null checks when using them.

Nullable references are available as separate types called `optref`.

TODO: Design a casting operator that avoids the need for control-flow sensitive typing.


### Defaultability

Most value types, including all numeric types and nullable references are *defaultable*, which means that they have 0/null as a default value.
Other reference types are not defaultable.

Certain restrictions apply to non-defaultable types:

* Local declarations of non-defaultable type must have an initializer.
* Allocations of aggregates with non-defaultable fields or elements must have initializers.

Objects whose members all have _mutable_ and _defaultable_ type may be allocated without initializers:
```
(type $s (struct (field $a (mut i32)) (field (mut (ref $s)))))
(type $a (array (mut f32)))

(new_default_struct $s)
(new_default_array $a (i32.const 100))
```


### Sharing

TODO: Distinguish types safe to share between threads in the type system.


## Other Reference Types

### Universal Type

The type `anyref` can hold references of any reference type.
It can be formed via [up casts](#casting),
and the original type can be recovered via [down casts](#casting).


### Host Types

The embedder may define its own set of types (such as DOM objects) or allow the user to create their own types using the embedder API (including a subtype relation between them).
Such *host types* can be [imported](import-and-export) into a module, where they are treated as opaque data types.

TODO: we might need to declare whether an imported type is an anyref to allow an engine to compile code ahead of time.

There are no operations to manipulate such types, but a WebAssembly program can receive references to them as parameters or results of imported/exported Wasm functions. Such "foreign" references may point to objects on the _embedder_'s heap. Yet, they can safely be stored in or round-trip through Wasm code.

(type $Foreign (import "env" "Foreign"))
(type $s (struct (field $a i32) (field $x (ref Foreign)))

(func (export "f") (param $x (ref Foreign))
  ...
)


### Function References

References can also be formed to function types, thereby introducing the notion of _typed function pointer_.

Function references can be called through `call_ref` instruction:
```
(type $t (func (param i32))

(func $f (param $x (ref $t))
  (call_ref (i32.const 5) (get_local $x))
)
```
Unlike `call_indirect`, this instruction is statically typed and does not involve any runtime check.

Values of function reference type are formed with the `ref_func` operator:
```
(func $g (param $x (ref $t))
  (call $f (ref_func $h))
)

(func $h (param i32) ...)
```

### Tagged Integers

Efficient implementations of untyped languages or languages with [parametric polymorphism](#parametric-polymorphism) often rely on a _uniform representation_, meaning that all values are represented in a single machine word -- usually a pointer.
At the same time, they want to avoid the cost of boxing as much as possible, by passing around small scalar values unboxed and using a tagging scheme to distinguish them from pointers in the GC.

To implement any such language efficiently, Wasm needs to provide such a mechanism by introducing a built-in reference type `i31ref` that represents tagged integers.
There are only three instructions for converting from and to such reference types:
```
i31ref.new : [i32] -> [i31ref]
i31ref.get_u : [i31ref] -> [i32]
i31ref.get_s : [i31ref] -> [i32]
```
The first is essentially a "tag" instruction, while the other two are two variants of the inverse "untag" operation, either with or without sign extension to 32 bits.

Being reference types, tagged integers can be cast into `anyref`, and can participate in runtime type checks and dispatch with `cast` or `br_on_cast`.

To avoid portability hazards, the value range of `i31ref` has to be restricted to at most 31 bits, since that is the widest range that can be guaranteed to be efficiently representable on all platforms.

Note: As a future extension, Wasm could also introduce wider integer references, such as `i32ref`. However, these sometimes will have to be boxed on some platforms, introducing the unpredictable cost of possible "hidden" allocation upon creation or branching upon access. They hence serve a different use case. Note also that such values can already equivalently be expressed in this proposal as structs with a single `i32` field, which implementations may choose to optimise accordingly (singleton structs that have no [runtime type information](#casting-and-runtime-types) can be flattened by engines).


## Type Structure

### Type Grammar

The type syntax can be captured in the following grammar:
```
num_type       ::=  i32 | i64 | f32 | f64
ref_type       ::=  (ref <def_type>) | i31ref | anyref | anyfunc
value_type     ::=  <num_type> | <ref_type>

packed_type    ::=  i8 | i16
storage_type   ::=  <value_type> | <packed_type>
field_type     ::=  <storage_type> | (mut <storage_type>)

data_type      ::=  (struct <field_type>*) | (array <field_type>)
func_type      ::=  (func <value_type>* <value_type>*)
def_type       ::=  <data_type> | <func_type>
```
where `value_type` is the type usable for parameters, local variables and the operand stack, and `def_type` describes the types that can be defined in the type section.


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

In order to avoid spurious type incompatibilities at module boundaries,
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
2. The `anyfunc` type is a supertype of every function type.
3. A structure type is a supertype of another structure type if its field list is a prefix of the other (width subtyping).
4. A structure type is a supertype of another structure type if they have the same fields and for each field type:
   - The field is mutable in both types and the storage types are the same.
   - The field is immutable in both types and their storage types are in (covariant) subtype relation (depth subtyping).
5. An array type is a supertype of another array type if:
   - Both element types are mutable and the storage types are the same.
   - Both element types are immutable and their storage types are in
(covariant) subtype relation (depth subtyping).
6. A function type is a supertype of another function type if they have the same number of parameters and results, and:
   - For each parameter, the supertype's parameter type is a subtype of the subtype's parameter type (contravariance).
   - For each result, the supertype's parameter type is a supertype of the subtype's parameter type (covariance).

Note: Like [type equivalence](#type-equivalence), subtyping is *structural*.
The above is the standard (co-inductive) definition, which is the most general definition that is sound.
Checking it is computationally equivalent to checking whether one DFA recognises a sublanguage of another DFA, i.e., it is a non-trivial algorithm (even though most practical cases will be trivial).
Like with type equivalence, this may be a problem, in which case a more restrictive definition might be needed.

Subtyping could be relaxed such that mutable fields/elements could be subtypes of immutable ones.
That would simplify creation of immutable objects, by first creating them as mutable, initialize them, and then cast away their constness.
On the other hand, it means that immutable fields can still change, preventing various access optimizations.
(Another alternative would be a three-state mutability algebra.)


### Casting and Runtime Types

In order to allow the use of type `anyref` to represent values of [polymorphic type](#parametric-polymorphism), the ability to down cast to a concrete type is provided. For safety, down casts are checked at runtime.

Down casts hence require runtime types (RTT). To avoid hidden cost and make RTTs optional, all runtime types are explicit operand values (*witnesses*). For example:
```
(cast <type1> <type2> (<operand>) (<rtt>))
```
This checks whether the runtime type stored in `<operand>` (which has static type `<type1>`) is a runtime subtype of the runtime type represented by the second operand (which must be a runtime representation of `<type2>`).

In order to cast down the type of a struct or array, the aggregate itself must also be equipped with a suitable RTT. Attaching runtime type information to aggregates happens at allocation time but is optional. If no RTT is attached then their runtime type is treated as if it was `anyref` and a down cast to a more specific type will fail. Such aggregates can prevent client code from rediscovering their real type, enforcing a form of parametricity. They can also be optimised more aggressively (e.g., via flattening optimisations), since the VM knows that any possible additional fields forgotten via subtyping can never be rediscovered.

A runtime type is an expression of type `rtt <type>`, which is another form of opaque reference type. It denotes the static type `<type>`.

Runtime type checks verify the subtype relation between runtime types.
In order to make these checks cheap, runtime subtyping follows a *nominal* semantics. To that end, every RTT value not only represents a given type, it also records a subtype relation to another (runtime) type (possibly `anyref`) defined when constructing the RTT value:
```
(rtt.new <type1> <type2> (<rtt>))
```
This creates a new witness for `<type1>` and defines it to be a subtype of the runtime type expressed by `<rtt>` representing `<type2>`.
Validation ensures that `<type1>` is a static subtype of the type `<type2>`. Consequently, runtime subtyping is always a subrelation of static subtyping, as required for soundness.

The above form of cast traps in case of a type mismatch. This form is useful when using casts to work around limitations of the Wasm type system, in cases where the producer knows that it will succeed.

Another variant of down cast avoids the trap:
```
(br_on_cast $label <type1> <type2> (<operand>) (<rtt>))
```
This branches to `$label` if the check is successful, with the operand as an argument, but using its refined type. Otherwise, the operand remains on the stack. By chaining multiple of these instructions, runtime type analysis ("typecase") can be implemented:
```
(block $l1 (result (ref $t1))
  (block $l2 (result (ref $t2))
    (block $l3 (result (ref $t3))
      (get_local $operand)  ;; has type (ref $t)
      (br_on_cast $l1 (ref $t) (ref $t1) (get_global $rtt-t1))
      (br_on_cast $l2 (ref $t) (ref $t2) (get_global $rtt-t2))
      (br_on_cast $l3 (ref $t) (ref $t3) (get_global $rtt-t3))
      ... ;; (ref $t) still on stack here
    )
    ... ;; (ref $t3) on stack here
  )
  ... ;; (ref $t2) on stack here
)
... ;; (ref $t1) on stack here
```


### Import and Export

Types can be exported from and imported into a module:
```
(type (export "T") (type (struct ...)))
(type (import "env" "T"))
```

Imported types are essentially parameters to the module.
As such, they are entirely abstract, as far as compile-time validation is concerned.
The only operations possible with them are those that do not require knowledge of their actual definition or size: primarily, passing and storing references to such types.

TODO: The ability to import types makes the type and import sections interdependent. We may also need to express constraints on an imported type's representation in order to be able to generate code without knowledge of the imported types.


## Possible Extension: Variants

Many language implementations use *pointer tagging* in one form or the other, in order to efficiently distinguish different classes of values or store additional information in pointer values without requiring extra space.
Other languages provide user-defined tags as an explicit language feature (e.g., variants or algebraic data types).

Unfortunately, hardware differs in how many tagging bits a pointer can support, and different VMs might have additional constraints on how many of these bits they can make available to user code.
In order to provide tagging in a way that is portable but maximally efficient on any given hardware, a somewhat higher level of abstraction is useful.

Such a more high-level solution would be to support a form of sum types (a.k.a. variants a.k.a. disjoint unions) in the type system:
in addition to structs and arrays, the type section could define variant types, which are also used as reference types.
Additional instructions would allow constructing and inspecting variant references.
It is left to the engine to pick an efficient representation for the required tags, and depending on the hardware's word size, the number of tags in a defined type, and other design decisions in the engine, these tags could either be stored as bits in the pointer, in a shared per-type data structure (hidden class), or in an explicit per-value slot within the heap object.
These decisions can be made by the engine on a per-type basis; validation ensures that all uses are coherent.


## Possible Extension: Nesting

* Want to represent structures embedding arrays contiguously.
* Want to represent arrays of structures contiguously (and maintaining locality).
* Access to nested data structures needs to be decomposable.
* Too much implementation complexity should be avoided.

Examples are e.g. the value types in C#, where structures can be unboxed members of arrays, or a language like Go.

Example (C-ish syntax with GC):
```
struct A {
  char x;
  int y[30];
  float z;
}

// Iterating over an (inner) array
A aa[20];
for (int i = 0..19) {
  A* a = aa[i];
  print(a->x);
  for (int j = 0..29) {
    print(a->y[j]);
  }
}
```

Needs:

* incremental access to substructures,
* interior references.

Two main challenges arise:

* Interior pointers, in full generality, introduce significant complications to GC. This can be avoided by distinguishing interior references from regular ones. That way, interior pointers can be represented as _fat pointers_ without complicating the GC, and their use is mostly pay-as-you-go.

* Aggregate objects, especially arrays, can nest arbitrarily. At each nesting level, they may introduce arbitrary mixes of pointer and non-pointer representations that the GC must know about. An efficient solution essentially requires that the GC traverses (an abstraction of) the type structure.


### Basic Nesting

* Aggregate types can be field types.
* They are unboxed, i.e., nesting them describes one flat value in memory; references enforce boxing.

```
(type $colored-point (struct (type $point) (i16)))
```
Here, `type $point` refers to the previously defined `$point` structure type.


### Interior References

Interior References are another new form of value type:
```
(local $ip (inref $point))
```
Interior references can point to unboxed aggregates, while regular ones cannot.
Every regular reference can be converted into an interior reference (but not vice versa) [details TBD].


### Access

* All access operators are also valid on interior references.

* If a loaded structure field or array element has aggregate type itself, it yields an interior reference to the respective aggregate type, which can be used to access the nested aggregate:
  ```
  (load_field (load_field (new $colored-point) 0) 0)
  ```

* It is not possible to store to a field or elements that have aggregate type.
  Writing to a nested structure or array requires combined uses of `load_field`/`load_elem` to acquire the interior reference and `store_field`/`store_elem` to its contents:
  ```
  (store_field (load_field (new $color-point) 0) 0 (f64.const 1.2))
  ```

TODO: What is the form of the allocation instruction for aggregates that nest others, especially wrt field initializers?


### Fixed Arrays

Arrays can only be nested into other aggregates if they have a *fixed* length.
Fixed arrays are a second version of array type that has a length (expressed as a constant expression) in addition to an element type:
```
(type $a (array i32 (i32.const 100)))
```

TODO: The ability to use constant expressions makes the type, global, and import sections interdependent.


### Flexible Aggregates

Arrays without a static length are called *flexible*.
Flexible aggregates cannot be used as field or element types.

However, it is a common pattern wanting to define structs that end in an array of dynamic length.
To support this, flexible arrays could be allowed for the _last_ field of a structure:
```
(type $flex-array (array i32))
(type $file (struct (field i32) (field (type $flex-array))))
```
Such a structure is itself called *flexible*.
This notion can be generalized recursively: flexible aggregates cannot be used as field or member types, except for the last field of a structure.

Like a flexible array, allocating a flexible structure would require giving a dynamic length operand for its flexible tail array (which is a direct or indirect last field).


### Type Structure

With nesting and flexible aggregates, the type grammar generalizes as follows:
```
fix_field_type   ::=  <storage_type> | (mut <storage_type>) | <fix_data_type>
flex_field_type  ::=  <flex_data_type>

fix_data_type    ::=  (struct <fix_field_type>*) | (array <fix_field_type> <expr>)
flex_data_type   ::=  (struct <fix_field_type>* <flex_field_type>) | (array <fix_field_type>)
data_type        ::=  <fix_data_type> | <flex_data_type>
```
However, additional checks need to apply to (mutually) recursive type definitions in order to ensure well-foundedness of the recursion.
For example,
```
(type $t (struct (type $t)))
```
is not valid.
For example, well-foundedness can be ensured by requiring that the *nesting height* of any `data_type`, derivable by the following inductive definition, is finite:
```
|<storage_type>|               = 0
|(mut <storage_type>)|         = 0
|(struct <field_type>*)|       = 1 + max{|<field_type>|*}
|(array <field_type> <expr>?)| = 1 + |<field_type>|
```


## Possible Extension: Weak References and Finalisation

Binding to external libraries sometimes requires the use of *weak references* or *finalizers*.
They also exist in the libraries of various languages in myriads of forms.
Consequently, it would be beneficial if Wasm could support them.

The main challenge is the large variety of different semantics that existing languages provide.
Clearly, Wasm cannot built in all of them, so we are looking for a mechanism that can emulate most of them with acceptable performance loss. Unfortunately, it is not clear at this point what a sufficiently simple and efficient account could be.

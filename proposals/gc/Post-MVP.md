# GC Post-v1 Extensions

This document discusses various extensions which seem desirable for comprehensive support of GC types, but are intentionally left out of the [MVP](MVP.md), in order to keep its scope manageable.
Over the course of implementing and validating the MVP, it is possible that features in this list may be promoted to the MVP if experience shows that MVP performance would not otherwise be viable.

See [overview](Overview.md) for addition background.

* [Bulk operations](#bulk-operations)
* [Arrays with fields](#arrays-with-fields)
* [Readonly field](#readonly-fields)
* [Field references](#field-references) (a.k.a. member pointers)
* [Fixed-size arrays](#fixed-sized-arrays)
* [Nested data structures](#nested-data-structures) (flattening)
* [Type parameters](#type-parameters) (polymorphism, generics)
* [Variants](#variants) (a.k.a. disjoint unions or tagging)
* [Static fields](#static-fields) (meta structures)
* [Closures](#closures)
* [Custom function RTTs](#custom-function-RTTs)
* [Threads and shared references](#threads-and-shared-references)
* [Weak references](#weak-references)


## Bulk Operations

In the MVP, aggregate data like structs and arrays can only be accessed one field or element at a time.
More compact code and more efficient code generation might be enabled if they could be copied in one piece.

To that end, _bulk copying_ instructions could be added, similar to the [bulk instructions for tables and memories](https://github.com/WebAssembly/bulk-memory-operations).

**Why Post-MVP:** These operators do not provide any additional expressiveness, so are not essential for the MVP.


### Sketch

* An instruction for bulk copying a struct:
  - `struct.copy $d : [(ref $d) (ref $s)] -> []` where both `$d` and `$s` are struct types, `$d` has only mutable fields, and `$s <: $d` modulo mutability

* An instruction for bulk copying an array range:
  - `array.copy $d $s : [(ref null $d) i32 (ref null $s) i32 i32] -> []`
    - iff `expand($d) = array (var t1)`
    - and `expand($s) = array (mut t2)`
    - and `t2 <: t1`
  - the 1st i32 operand is the `destination` offset in the first array
  - the 2nd i32 operand is the `source` offset in the second array
  - the 3rd i32 operand is the `length` of the array subrange
  - traps if either array is null
  - traps if `destination + length > len(array1)`
  - traps if `source + length > len(array2)`

* An instruction for bulk setting an array range:
  - `array.fill $t : [(ref null $t) i32 t i32] -> []`
    - iff `expand($t) = array (var t')`
    - and `t = unpacked(t')`
  - the 1st operand is the `offset` in the array
  - the 2nd operand is the `length` of the array subrange
  - traps if the array is null
  - traps if `offset + length > len(array)`

* An instruction to (re)initialise an array range from a data segment
  - `array.init_data $t $d : [(ref null $t) i32 i32 i32] -> []`
    - iff `expand($t) = array (var t')`
    - and `t'` is numeric or packed numeric
    - and `$d` is a defined data segment
  - the 1st operand is the `destination` offset in the array
  - the 2nd operand is the `source` offset in the segment
  - the 3rd operand is the `length` of the array subrange
  - traps if the array is null
  - traps if `destination + length > len(array)`
  - traps if `source + |t'|*length > len($d)`

* An instruction to (re)initialise an array range from an element segment
  - `array.init_elem $t $e : [(ref null $t) i32 i32 i32] -> []`
    - iff `expand($t) = array (var t')`
    - and `t'` is a reference type
    - and `$e` is a defined element segment
  - the 1st operand is the `destination` offset in the array
  - the 2nd operand is the `source` offset in the segment
  - the 3rd operand is the `length` of the array subrange
  - traps if the array is null
  - traps if `destination + length > len(array)`
  - traps if `source + length > len($e)`



## Array with Fields

One common suggestion is to merge structs and arrays into a single construct with both struct-like fields and a array-like elements.

However, this is merely a special case of [nested data structures](#nested-data-structures), which some languages will need in a more general form.
So instead of adding an ad-hoc construct for it (which would actually complicate nesting), the idea is to defer to the general mechanism.

**Why Post-MVP:** For the MVP, all that the lack of arrays with fields entails is the need to represent objects with both fields and elements (e.g., Java arrays) with one extra indirection to the array. That cost seems acceptable for the MVP.


## Readonly Fields

One problem with immutable data structures sometimes is initialisation.
The MVP requires all field values for a struct to be available at allocation time (and lacks a way to construct immutable arrays with individual field values, see [below](#fixed-size-arrays)).

However, this only allows bottom-up initialisation, which can't handle cases where initialisation is recursive, e.g., because two mutually recursive but immutable structs ought to reference each other.

In the MVP, such structs need to be defined as mutable and remain so throughout their lifetime.
That prevents depth subtyping to be applied to them (because subtyping mutable fields is unsound).

In order to prevent mutation after the fact, a third kind of mutability can be added: `readonly`.
Unlike `const`, a `readonly` field or element can still be mutated, but only through another alias where it has `var` type.
At the same time, `readonly` is a supertype of `var` (and also of `const`).

The upshot is that a struct or array can be allocated with `var` type and be initialised via mutation.
Once done, it can be effectively "frozen" by forgetting the mutable type and upcasting to a reference with a type where fields or elements are `readonly`, preventing any further mutation.

Note: The notion of `const` in languages like C corresponds to `readonly`, not `const` as currently specified in Wasm.

**Why Post-MVP:** This is not included in the MVP because it is not entirely clear how important it is in practice.

### Sketch

* Introduce a new `<mutability>` attribute, `readonly`:
  - `mutability ::= ... | readonly`

* Both `var` and `const` are subtypes of `readonly`:
  - `var <: readonly`
  - `const <: readonly`

* A `<fieldtype>` is a subtype of another `<fieldtype>` iff both mutability and storage type are in respective subtype relation:
  - `<mutability1> <storagetype1> <: <mutability2> <storagetype2>`
    - iff `<mutability1> <: <mutability2>`
    - and `<storagetype1> <: <storagetype2>`

### Alternative Design

Alternatively, one could also extend the MVP with subtyping between `var` and `const` fields, thereby effectively reinterpreting `const` as `readonly`.
True immutability allows more aggressive optimisations, so it might have merits to distinguish it; OTOH it's not clear how much such optimisations matters on the Wasm level, where the producer can apply beforehand in most cases.


## Field References

Some compilation schemes, such as for abstracting over the position or order of fields in an object, require a notion of first-class _field offsets_.
These can be modeled as _field references_ akin to member pointers in C++.

Such references can also be used to implement *interior pointers* as *fat pointers*.

**Why Post-MVP:** This is not included in the MVP for the sake of simplicity and because it addresses a more advanced use case. There usually are ways to work around it at some extra cost with extra reference indirections, e.g., two-level object layout. For the MVP, that seems acceptable.

### Sketch

* Add a new form of field reference type:
  - `reftype ::= ... | fieldref null? <typeidx> <fieldtype>`
  - denotes the offset of a field of type `<fieldtype>` in the struct defined at `<typeidx>`
  - conservatively, a field reference is not a subtype of `anyref`

* An instruction `ref.field <typeidx> <fieldidx>` that creates a reference to a struct field:
  - `ref.field $t i : [] -> [(fieldref $t ft)]`
    - iff `$t = (struct ft1^i ft ft2*)`
  - this instruction is a constant expression

* Instructions for accessing fields through field references:
  - `struct.get_ref_<sx>? : [(ref null? $t) (fieldref null? $t ft)] -> [t]`
    - iff `$t = (struct ft1^i ft ft2*)`
    - and `ft = (mut? st)`
    - and `t = unpacked(st)`
    - and `<sx>` present iff `st` is a packed type
  - `struct.set_ref : [t (ref null? $t) (fieldref null? $t ft)] -> []`
    - iff `$t = (struct ft1^i (mut st) ft2*)`
    - and `t = unpacked(st)`
  - trap if either the value reference or the field reference is null


## Fixed-Size Arrays

The MVP only supports dynamically-sized arrays.
In some scenarios, a static size is sufficient, and may allow for slightly more efficient compilation, e.g., by eliding some bounds checks.

Fixed-size array types can also be used to support initialisation of immutable arrays: if the size of the array is statically known, it can take the appropriate number of initialisation values from the stack.

Most importantly, fixed-size array types are a prerequisite for allowing [nested data structures](#nested-data-structures).

**Why Post-MVP:** This is not included in the MVP for the sake of simplicity and because without [nested data structures](#nested-data-structures), it mostly provides minor performance gains.


### Sketch

* Add a new form of statically-sized array type:
  - `arraytype ::= ... | array N <fieldtype>`

* Such an array type is a subtype of a smaller statically-sized array:
  - `array N1 ft1 <: array N2 ft2`
    - iff `N1 < N2`
    - and `ft1 <: ft2`

* Such an array type also is a subtype of a dynamically-sized array:
  - `array N ft1 <: array ft2`
    - iff `ft1 <: ft2`

* An instruction for allocating a statically-sized array:
  - `array.new_static $t : [t^N] -> [(ref $t)]`
    - iff `$t = (array N ft)`
    - and `ft = (mut? st)`
    - and `t = unpacked(st)`


## Nested Data Structures

The MVP only supports "flat" data structures, i.e., structs or arrays whose field types are simple values.
Ultimately, Wasm should support more of the C data model, where structs and arrays can be nested in an unboxed fashion, i.e., flattened into a single heap object.

With the extension sketched below, it is possible, for example, to represent [arrays with fields](#arrays-with-fields), by nesting a dynamically-sized array at the end of the struct.
For example:
```
(type $Array (array i32))
(type $ArrayObject (struct f32 i64 (type $Array))
```

More generally, nested data structures also enables representing "arrays of structs" compactly (and deeper nestings).

Examples naturally mapping to nested structs are e.g. the value types in C#, where structures can be unboxed members of arrays, or a language like Go.
The sketched data model also has a close correspondance to the [Typed Objects](http://smallcultfollowing.com/babysteps/pubs/2014.04.01-TypedObjects.pdf) that are [proposed](https://github.com/tschneidereit/proposal-typed-objects/blob/master/explainer.md#) for JavaScript.

Under the sketched extension, such that inner structures can be stored in contiguous heap ranges. That avoids the need to split and _transpose_ representations, i.e., turning an array of structs into a struct of arrays, which would be necessary otherwise.
Such a transformation of the data format destroys composability and memory locality. Access can become much more expensive; for example, copying a struct into or out of an array in this representation is not a single memcpy but requires an arbitrary number of individual reads/writes at distant memory locations.

For example, consider this source-level pseudo code (C-ish syntax with GC):
```
struct A {
  char x;
  int y[30];
  float z;
}

A aa[20];

// Copying inner structs
A aa2[10];
for (int i = 0..9) {
  aa2[i] = aa[i];  // should expect a single bulk copy
}

// Iterating over an (inner) array
for (int i = 0..19) {
  A* a = aa[i];  // should point to a contiguous struct representation
  print(a->x);
  for (int j = 0..29) {
    print(a->y[j]);  // should expect contiguous memory access
  }
}
```

Two main challenges arise:

* _Interior pointers_ are required to reference inner structures. True inner pointers introduce significant complications to GC that are probably an infeasible requirement to impose on all Wasm engines. This can be avoided by distinguishing interior references from regular ones. That way, engines can choose to represent interior pointers as _fat pointers_ (essentially, a pair of a an object reference and a [field reference](#field-references)) without complicating the GC, and their use is mostly pay-as-you-go.

* Aggregate objects, especially arrays, can nest arbitrarily. At each nesting level, they may introduce arbitrary mixes of pointer and non-pointer representations that the GC must know about. An efficient solution requires that the GC interprets (an abstraction of) the type structure. More advanced optimisations involve dynamic code generation.


**Why Post-MVP:** Due to their obvious added complexity, nested data structures are not included in the MVP.


### Sketch

Nested Types:

* Aggregate types can be used as field types:
  - `fieldtype ::= ... | <typeuse>`
  - valid if the type use denotes a _fixed_ struct or array type, or if it is the last field and denotes a _flexible_ data type (see below)

  For example:
  ```
  (type $point (struct (field i32 i32)))
  (type $colored-point (struct (field $p (type $point)) (field $col (i16))))
  ```
  Here, `type $point` refers to a previously defined `$point` structure type.

* A data type is called _flexible_ if it does not have a static size, i.e., either is a dynamically-sized array, or a struct whose last field recursively is a flexible data type.

  Flexible aggregates cannot be used as a (direct flattened) field or element type.
  However, it is a common pattern to define structs that end in an array of dynamic length.
  To support this, flexible arrays can be allowed for the _last_ field of a structure:
  ```
  (type $flex-array (array i32))
  (type $file (struct (field i32) (field (type $flex-array))))
  ```
  This notion of flexibility can be generalized recursively, i.e., the last field of a flexible struct may be a flexible array _or_ a nested flexible struct (this always bottoms out with a flexible array).

  (Note: This notion of "flexible" only considers extension at the end of an object. In principle, it would be possible to introduce a similar notion that allows extension at the beginning of an object, giving rise to a generalised notion of "butterfly object". However, such a generalisation would have substantial repercussions on the implementation strategy of Wasm GC.)

* A data type is _fixed_ if it is a struct or array that is not flexible.

* With nesting and flexible aggregates, the type grammar generalizes as follows:
  ```
  datatype        ::=  <fix_datatype> | <flex_datatype>
  fix_datatype    ::=  (struct <fix_fieldtype>*) | (array N <fix_fieldtype>)
  flex_datatype   ::=  (struct <fix_fieldtype>* <flex_fieldtype>) | (array <fix_fieldtype>)

  fix_fieldtype   ::=  (<mut> <storagetype>) | <fix_datatype>
  flex_fieldtype  ::=  <flex_datatype>
  ```
  However, additional constraints apply to (mutually) recursive type definitions in order to ensure well-foundedness of the recursion (a data type cannot contain itself in flat form).
  For example,
  ```
  (type $t (struct (type $t)))
  ```
  is not valid.
  For example, well-foundedness can be ensured by requiring that the *nesting depth* of any `datatype`, derivable by the following inductive definition, is finite:
  ```
  |(<mut> <storagetype>)|  = 0
  |(struct <fieldtype>*)|  = 1 + max{|<fieldtype>|*}
  |(array N? <fieldtype>)| = 1 + |<fieldtype>|
  ```

Allocation:

* Allocation instructions like `struct.new` expect initialiser operands for nested aggregates: each individual field for a nested struct, and one initialiser for a nested array (which may itself be a list of initialisers, if the array's element type is again a struct). Details TBD.

* Like a dynamically-sized array, allocating a flexible struct requires giving a dynamic length operand for its flexible tail array (which is a direct or indirect last field). Details TBD.


Interior references:

* Interior References are another form of reference type that can point to inner aggregates:
  - `reftype ::= ... | (inref null? <typeidx>)`
  - to allow their implementation as fat pointers, interior references are neither subtypes of regular references nor of `anyref`; however, they can be obtained from regular ones (see below)

  For example:
  ```
  (local $ip (inref $point))
  ```

* Existing access instructions on structs and arrays are generalied to accept both regular or inner references. For example:
  - `struct.set $t i : [([in]ref null? $t) ti] -> []`
  - `array.get $t : [([in]ref null? $t) i32] -> [t]`
  - etc.
  - it is not valid to get or set a struct field or array element that has aggregate type


* New instructions to obtain an inner reference:
  - `struct.inner $t i : [([in]ref null? $t)] -> [(inref ft)]`
    - iff `$t = (struct ft1^i ft ft2*)`
  - `array.inner $t : [([in]ref null? $t) i32] -> [(inref ft)]`
    - iff `$t = (array N? ft)`
  - the source reference may either be a regular or itself interior
  - traps if the source reference is null

  For example:
  ```
  (struct.get $point $y (struct.inner $colored-point $p (<some colored point>)))
  ```

* Instructions to obtain an inner reference from a [field reference](#field-references):
  - `struct.inner_ref : [([in]ref null? $t) (fieldref null? $t ft)] -> [(inref ft)]`
    - iff `$t = (struct ft1^* ft ft2*)`
    - and `ft = (type $t')`
  - traps if either of the references is null

* It is not valid to get or set a field or element that has aggregate type.
  Writing to a nested structure or array requires combined uses of `struct.inner`/`array.inner` to acquire the interior reference and `struct.set`/`array.set` to its contents:
  ```
  (struct.set $color-point $x
    (struct.inner $color-point $p (...some $color-point...))
    (f64.const 1.2)
  )
  ```

  An engine should be able to optimise away intermediate interior pointers very easily.

* TBD: As sketched here, interior references can only point to nested aggregates. Should there also be interior references to plain fields?


## Type Parameters

The MVP does not support any type parameters for types or functions (also known as _parametric polymorphism_ or _generics_).
The only feasible ways to compile source-level polymorphism to the MVP are:

1. via type specialisation and code duplication (also known as _monomorphisation_),
2. by using a _uniform representation_ (e.g., `anyref`) for all values passed to polymorphic definitions

Both methods have severe limitations:

1. Monomorphisation is only feasible for 2nd-class polymorphism, where use-def relations are statically known. That excludes features like polymorphic methods, polymorphic closures, existential types, GADTs, first-class modules, and other type system features present in many languages. Monomorphisation with such features would require a whole-program analysis and defunctionalisation of polymorphism, which is both complex, more costly at runtime, and giving up on separate compilation and linking. Furthermore, there are features like polymorphic recursion for which even that isn't possible.

  For example, the visitor pattern in object-oriented programming requires an `accept` method in every traversable object. In order to enable traversals with varying result types, a visitor, and hence the corresponding`accept` methods, ought to be generic:
  ```
  accept<T>(visitor : Visitor<T>) : T
  ```
  In languages limited by monomorphisation, such as C++, this pattern typically cannot be expressed and requires cumbersome workarounds (in C++ terminology, template virtual methods are not allowed).

  To demonstrate polymorphic recursion, here is a (contrived but simple) OCaml example due to @gasche, tweaked to show that such recursion can imply instantiating other functions and concrete data types at a statically unbounded number of types:
  ```
  type 'a tree = {lft : 'a; rgt : 'a}

  let sum : 'a . ('a -> int) -> 'a tree -> int =
    fun f {lft; rgt} -> f lft + f rgt

  (* a fairly inefficient way to compute 2^n,
     by creating a full tree of depth n and counting its leaves *)
  let rec loop : 'a . int -> 'a -> ('a -> int) -> int =
    fun n v count ->
      if n = 0 then count v else
      (* call ourselves on values of type ('a tree) *)
      loop (n - 1) {lft = v; rgt = v} (fun t -> sum count t)

  let pow2 n = loop n () (fun _ -> 1)
  ```
  Due to `tree` being nested to arbitrary depth `n` (which may be an input to the program), it is not possible to monomorphise this code. Instead, a compiler would have to detect this case and fall back to a uniform representation for the different instantiations of the type `tree` in the loop -- and all other code it is passed to, such as `sum` (in the limit, this could be almost all of the program).

2. A uniform representation cannot be expressed in the MVP without losing all static type information and thereby requiring costly runtime checks at every use site. For example, if `anyref` is used as the uniform type of all values, passing a value through a polymorphic function will require forgetting its static type on the way in (because the function only takes `anyref`) and recovering it with a downcast on the way out (because the function only returns `anyref`). Worse, any composite type, like tuples, arrays, records, or lists, must be implemented with field and element type `anyref` throughout, because their values could not be passed to a function that is polymorphic in their field or element type otherwise.

  For example, consider another piece of code in OCaml, which modifies each element of an array by applying a function `f` to it:
  ```
  (* modify : ('a -> 'a) -> 'a array -> unit *
  let modify f a =
    for i = 0 to Array.length a - 1 do
      a.(i) <- f (a.(i))
    done  
  ```
  Since the function is polymorphic in the element type of the array, the given array has to be represented as an array of universal element type, e.g. `(array (mut anyref))`.
  At the same time, it must be compatible with any concrete array type.
  For example, passing an array of integers and a suitable function on ints must compose:
  ```
  modify ((+) 1) [1; 2; 3]
  ```
  The implication is that even the integer array has to be represented using the universal element type, such as `(array (mut anyref))`, and every single read requires a cast.

To address this shortcoming, it seems necessary to enrich the Wasm type system with a form of type parameters, which allows more accurate tracking of type information for such definitions, avoiding the need to fallback to a universal type.
However, there are a number of challenges:

1. It is _highly_ desirable to avoid the rabbit hole of _reified generics_, where every type parameter has to be backed by runtime type information. That approach is both highly complex and has a substantial overhead, even where that information isn't needed.

  Instead, type parameters should adhere to the don't-pay-what-you-don't-use principle, which would be violated if _every_ parameter had to be backed by runtime types.

  That can be achieved by a design where type parameters are a purely static mechanism (a property known as _parametricity_), and all operational behaviour and cost of runtime typing, both in terms of space and time, is made explicit in terms of explicit values and instructions, whose use is optional.
  In other words, reification is implemented in user space, by inserting explicit RTT parameters where desired.
  The design of RTTs in the MVP has been chosen to make such an approach possible.

2. Type parameters have to remain compatible with Wasm's existing model for separate, ahead-of-time compilation and linking. Hence it should avoid a dependency on code specialisation. That implies that, like with [type imports](https://github.com/WebAssembly/proposal-type-imports/blob/master/proposals/type-imports/Overview.md), instantiation has to be restricted (for now) to a set of types that has the same representation in an engine, such as reference types.

   A generalisation to other types would be possible in the future, but would depend on other features like compile-time imports, which are not available yet.

In general, the semantics and implementation of type parameters should be analogous to that of type imports. Ideally, in the presence of the [module linking proposal](https://github.com/WebAssembly/module-linking), it should even be possible to explain definitions with type parameters as shorthands for nested modules (well, at least for 2nd-class cases).

### Sketch

* Allow type parameters on function types:
  - `functype  ::= (func <typeparam>* <valtype>* <valtype>*)`
  - `typeparam ::= (typeparam $x <typeuse>?)`
  - like with type imports, the `<typeuse>` describes a bound, contraining instantiation to a subtype; they are likewise instantiated with heap types

* Allow type parameters on type definitions:
  - `typedef ::= (type <typeparam>* <deftype>)`
  - recursive type definitions with parameters must _uniformly recursive_, i.e., not expand to infinitely large types (details TBD)

* Possibly, also allow type _fields_ in structs, which would technically amount to existential types:
  - `datatype  ::= ... | (struct <typefield>* <fieldtype>*)`
  - `typefield ::= (typefield $x <typeuse>?)`
  - again, the `<typeuse>` describes a bound
  - consecutive field types can refer to type fields in the same way as to type parameters

* Add a way to reference a type parameter as a heap type:
  - `heaptype ::= ... | (typeparam $x)`
  - a type parameter is a subtype of its bound

* Add a way to supply type arguments in a type use:
  - `typeuse ::= (type $t <heaptype>*)`
  - type uses in a heap type must instantiate all parameters

* Generalise all call instructions (and `func.bind`) with a way to supply type arguments:
  - e.g., `call $f <heaptype>*`

* Generalise the instruction for creating an RTT value with a way to supply type arguments and additional RTT operands for backing them up:
  - `rtt.canon (type $t <heaptype>^n) : [(rtt <heaptype>)^n] -> [(rtt $t <heaptype>^n)]`
    - iff `$t = (type <typeparam>^n ...)`
    - and `<heaptype>^n` matches the bounds of `<typeparam>^n`, respectively
  - similarly for `rtt.sub`

  This instruction allows a function with type parameters to construct runtime types that involve those parameters. For example,
  ```
  (type $Pair (typeparam $X)
    (struct (field (ref (typeparam $X)) (field (ref (typeparam $X)))))
  )

  (func
    (typeparam $T)
    (param $rttT (rtt (typeparam $T)))
    (param $x (ref $T))
    (result (ref $Pair (typeparam $T)))

    ;; allocate a pair with full RTT information
    (struct.new_with_rtt
      (rtt.canon $Pair (typeparam $T) (local.get $rttT))
      (local.get $x) (local.gt $x)
    )
  )
  ```


## Variants

The MVP supports the most basic form of _pointer tagging_ via the `i31ref` type.
That type allows injecting and distinguishing unboxed integers and pointers in the same type space, such that unboxing can be guaranteed on all platforms.

However, many language implementations use more elaborate tagging schemes in one form or the other. For example, they want to efficiently distinguish different classes of values without dereferencing, or to store additional information in pointer values without requiring extra space (e.g., Lisp or Prolog often introduce a special tag bit for cons cells).
Other languages provide user-defined tags as an explicit language feature (e.g., _variants_ or _algebraic data types_).

Unfortunately, hardware differs widely in how many tagging bits a pointer can conveniently support, and different VMs might have additional constraints on how many of these bits they can make available to user code.
In order to provide tagging in a way that is portable but maximally efficient on any given hardware and engine, a somewhat higher level of abstraction is useful.

Such a higher-level solution would be to support a form of _variant types_ (a.k.a. disjoint unions or sum types) in the type system.
In addition to structs and arrays, a module could define a variant type that is a closed union of multiple different cases.
Dedicated instructions allow allocating and inspecting references of variant type.

It is left to the engine to pick an efficient representation for the required tags, and depending on the hardware's word size, the number of tags in a defined type, the presence of parameters to a given tag, and other design decisions in the engine, these tags could either be stored as bits in the pointer, in a shared per-type data structure (a.k. hidden class or shape), or in an explicit per-value slot within the heap object.
These decisions can be made by the engine on a per-type basis; validation ensures that all uses are coherent.

**Why Post-MVP:** Variants allow for more compact representations and potentially more precise types, thereby possibly saving a certain number of runtime checks and downcasts over the use of a common supertype, as necessary in the MVP. However, they are not strictly necessary in the presence of the latter. Nor can they replace it, since they necessarily define a _closed_ set of values, whereas the ability to import an arbitrary number of abstract types requires a way to include an _open_ set of types. To handle that, yet another form of _extensible union types_ (with generative tags) would be required in addition.


### Sketch

* Add a new form of `deftype` for variants:
  - `deftype ::= ... | (variant (case $x <fieldtype>?)*)`
  - along with [nested-types](#nested-data-structures), the fieldtype can itself be a struct
  - references to such a type can be formed as usual
  - cases with no `<fieldtype>` can typically be represented as an unboxed integer in an engine

* An instruction for allocating a variant value:
  - `variant.new $t i : [t] -> [(ref $t)]`
    - iff `$t = (variant ft^i (mut? st) ft*)`
    - and `t = unpacked(st)`

* An instruction for testing a variant value:
  - `variant.test $t i : [(ref null? $t)] -> [i32]`
    - iff `$t = (variant ft1^i ft ft2*)`
  - returns 1 if the value is case `i`, 0 otherwise; traps if the reference is null

* An instruction for branching on a case:
  - `br_on_case $l i : [(ref null? $t)] -> [(ref $t)]`
    - iff `$t = (variant ft1^i ft ft2*)`
    - and `ft = (mut? st)` and `t = unpacked(st)` and `$l : [t]`
    - or `ft = (type $t')` and `$l : [(inref $t')]`
  - i.e., if the field type is a scalar, pass its value to the label, otherwise an interior reference
  - TBD: the typing rule could synthesise a more precise result type without the tested case; alternatively, this could be replaced with a multi-branch instruction, but that may be cumbersome in many cases

* TBD: how this integrates with RTTs


## Static Fields

In various object models and value representations, heap values share certain meta information -- for example, the method table in an object, the tag in a union type, or other "static" meta information about a value.

Since a Wasm engine already has to store its own meta information in heap values, such as GC type descriptor or RTTs, that may double the space usage for meta data in every heap object (e.g., two memory words instead of just one). It would hence be desirable if GC type definitions could piggy-back on the meta object that the engine already has to implement.

The basic idea would be introducing a notion of _static fields_ in a form of immutable meta object that is shared between multiple instances of the same type.
There are various ways in which this could be modelled, details are TBD.

**Why Post-MVP:** Such a feature only saves space, so isn't critical for the MVP. Furthermore, there isn't much precedent for exposing such a mechanism to user code in low-level form, so no obvious design philosophy to follow.


## Closures

Function references could be generalised to represent closures by means of an instruction that takes a prefix of the function's arguments and returns a new function reference with those parameters bound.

* `func.bind` creates or extends a closure by binding several parameters
  - `func.bind $t' : [t0* (ref null $t)] -> [(ref $t')]`
    - iff `$t = [t0* t1*] -> [t2*]`
    - and `$t' = [t1'*] -> [t2'*]`
    - and `t1'* <: t1*`
    - and `t2* <: t2'*`
  - traps on `null`

With this extension, closures are interchangeable with regular function references. That is, conceptually, all function references would be closures of 0 or more parameters.

An alternative design would be to distinguish closures from raw functions. In such a design, we would introduce:

* `closure $t` is a new heap type
  - `heaptype ::= ... | closure $t`
  - `(closure $t) ok` iff `$t = [t1*] -> [t2*]`

* `closure $t` also is a new reference type shorthand
  - `reftype ::= ... | closure $t`
   - shorthand for `(ref (closure $t))`

There would be two bind instructions, both returning a closure:

* `closure.new` creates a closure from a function
  - `closure.new : [(ref null $t)] -> [(ref (closure $t))]`
    - iff `$t = [t1*] -> [t2*]`
  - traps on `null`

* `closure.bind` creates a new closure by binding (additional) parameters of an existing closure
  - `closure.bind $t' : [t0* (ref null (closure $t))] -> [(ref (closure $t'))]`
    - iff `$t = [t0* t1*] -> [t2*]`
    - and `$t' = [t1'*] -> [t2'*]`
    - and `t1'* <: t1*`
    - and `t2* <: t2'*`
  - traps on `null`

As a variant, `closure.new` could be generalised to `func.bind` like above, but returning a closure.


## Custom Function RTTs

For backwards compatibility, the RTT embedded in a function behaves as if it was created by `rtt.canon`.
It might be useful to customise this semantics and allow programs to pick other RTTs, e.g., ones that have dynamic supertypes.

To this end, the syntax of function definitions could be extended to include an initialiser expression denoting the desired RTT.
The current form omitting it would be a shorthand for the canonical choice.


## Threads and Shared References

In conjunction with [threads](https://github.com/WebAssembly/threads/blob/master/proposals/threads/Overview.md), GC support ultimately isn't complete until references can also be shared across threads.
For example, this would be necessary to fully implement a JVM with threading using GC types.
In order to support this, the type system must track which references can be *shared* across threads.

The basic idea for enriching Wasm with shared references has already been laid out in our [OOPSLA'19 paper](https://github.com/WebAssembly/spec/blob/master/papers/oopsla2019.pdf).

**Why Post-MVP:** Shared references have not been included in the GC MVP, because they will require engines to implement *concurrent garbage collection*.
That requires major changes to most existing Web implementation, that will probably take a long time to implement, let alone optimise.
It seems highly preferable not to gate GC support on that.

### Sketch

* Add the *sharability* attribute introduced for memory types by the threads proposal to function, global, and table types. Like with memories, shared definitions are incompatible with non-shared ones.

* Reference types are extended with a *sharability* attributes as well. That is, the basic form of reference type becomes something like `(ref null? shared? $t)`.

* Instructions for accessing globals and tables are enriched with sibling *atomic* versions, such as `atomic.global.{get,set}`, `atomic.table.{get,set}`, `atomic.call_indirect`, which have to be used to access shared ones (we may allow non-atomic access as well, but that may be tricky to implement safely on some platforms).

* Similarly, the accessors in the GC MVP proposal need to be complemented with atomic variants, such as `atomic.struct.{get,set}` etc., and allocation instructions must include shared variants such as `atomic.struct.new`.

* Validation has to enforce consistency for sharedness, such that only shared definitions and objects must be reachable from shared reference. For example,

  - a value type is *sharable* if it is either numeric or a shared reference;
  - a defined type is *sharable* if all its constituent types are sharable;
  - a shared global must have a sharable content type;
  - a shared table must have a sharable element type;
  - a shared function must have sharable parameter and result types; furthermore, it can only access other shared definitions;
  - a shared reference can only be formed to a sharable defined type;
  - `ref.func` on a shared function produces a shared reference;
  - `atomic.struct.new` produces a shared reference, but is only applicable to sharable struct types;
  - and so on.


## Weak References

Binding to external libraries sometimes requires the use of *weak references* or *finalizers*.
They also exist in the libraries of various languages in myriads of forms.
Consequently, it would be desirable for Wasm to support them.

The main challenge is the large variety of different semantics that existing languages provide.
Clearly, Wasm cannot build in all of them, so we need to be looking for a mechanism that can emulate most of them with acceptable performance loss.

**Why Post-MVP:** Unfortunately, it is not clear at this point what a sufficiently simple and efficient set of primitives for weak references and finalisation could be. This requires more investigation, and should not block basic GC functionality.

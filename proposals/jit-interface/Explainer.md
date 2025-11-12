# JIT interface

This proposal adds safe, programmably-constrained dynamic code generation to WebAssembly.
We propose a new `func.new` instruction and a new kind of section called a "scope", which declares the elements of the surrounding module that new code may legally access.

# Problem

Core WebAssembly has no mechanism for dynamically generating code.
Yet generating new code at runtime is important in a number of important use cases, such as guest language virtual machines that otherwise must use relatively slow interpretation.

### Harvard architecture, no JIT

Core WebAssembly's separates code (functions) and data (memories, tables, and managed data) as a fundamental design principle.
This important property of Wasm allows efficient validation of all code in a module and establishes other important security properties.
Further, this restriction allows static analysis of modules; state declared in a module but not exported admits sound closed-world optimizations, which is common in tooling today.

### Guest runtimes want to JIT new code

However, some programs running on top of Wasm, such as guest language runtimes like Python or Lua, and hardware emulators, such as QEMU, can benefit tremendously by generating specialized code at runtime.
The performance benefit of dynamic code generation can be extreme; as much as *10 to 100 times* faster than running in interpreted mode. Today, these runtimes can run *only* in interpreted mode and are prohibitively slow.

### Inconsistent host support for new modules

To date, generating new Wasm code has been an optional host capability provided by the embedder.
On the web, this is done through JavaScript APIs for creating new modules directly from bytes.
The [wasm-c-api](https://github.com/WebAssembly/wasm-c-api) allows embedding a Wasm engine in a C/C++ program and creating new modules dynamically.
Other host platforms may offer the ability to create new modules from bytes.
Generally, the granularity of generation is Wasm modules. Some experiments have been done with function-at-a-time mechanisms, but no standard mechanism has been proposed and nothing is portable across platforms.

Today, guest runtimes that generate new code are few, and they make a number of compromises, such as batching generated functions, in order to workaround limitations and cost of new modules on host platforms.

# Proposing a lightweight core-Wasm mechanism

To address this problem, we propose to add a new mechanism to core Wasm. Doing so exposes the mechanism to security features/mitigations, makes behavior explicit and documented, allows sound toolchain analysis and transformations, and exposes it to engine optimizations.

## A new instruction: `func.new`

The main component of this idea is a new core Wasm bytecode, `func.new`, which creates a new function at runtime from bytecode stored in Wasm memory.

```
  func.new $mt $ft $scope: [at at] -> [(ref $ft)]
  where:
  - $mt = memory at limits
  - $ft = func [t1*] -> [t2*]
  - $scope = export*

```

This bytecode has immediates:
  - a memory index, indicating the memory which contains the code for the new function
  - a function type, indicating the signature of the new function
  - a scope, indicating a list of functions, tables, globals, tags, and memories that new code may legally access

At runtime, this instruction takes operands:
  - start, an integer indicating the start offset within the memory of the code
  - length, an integer indicating the length of the code

The memory index and function type are straightforward.
The `$scope` immediate is an explicit enumeration of the module contents the new code may reference.
In particular, `$scope` produces a new index space for types, globals, functions, memories, etc. For compactness of the bytecode, and to reuse the same scope for multiple different `func.new` instructions, `$scope` will be factored out to its own section rather than inline as immediates.

To execute the instruction, the engine first copies the bytes of code from the Wasm memory, then validates the bytecode under a module context corresponding to `$scope` and a function context corresponding to the expected function signature `$ft`.
Upon out of bounds memory access or validation error, the instruction traps.
If validation of the code is successful, the engine creates an internal representation of a new function and pushes a non-null reference to it onto the operand stack.
The function's *store* is derived from the store under which the instruction was executed; i.e. the new function's instance is (a subset of) the caller's instance.

## A new section: JIT scope

A scope defines what declarations are accessible to new code passed to a `func.new` instruction.
We introduce a new "scope" section to factor out the list of accessible declarations so that `func.new` may refer to a scope by index rather than listing declarations individually. A scope section allows declaring multiple scopes to allow different `func.new` instructions different accessibility.
A scope consists of a list of declarations (similar to export declarations, but without names).
The order of declarations in a scope creates new index spaces, i.e. it *renumbers* the declarations from the surrounding module, starting each respective index space over from 0.

## An example

Putting the pieces together, we can write an example that uses a memory and a scope and creates new functions at runtime.

```
(module
   (type $t1 (func))  ;; the type for new functions
   (func $f1 ...)
   (func $f2 ...)
   (func $f3 ...)
   (memory $m1 1 1)  ;; the memory used to temporarily store code for func.new
   (memory $m2 1 1)       ;; a memory accessible to new code

   (scope $s1             ;; the scope a new function may use
     (func $f1 $f2)       ;; expose $f1 and $f2 to new code
     (memory $m2))        ;; expose only $m2 to new code

   (func $gen
     (local $n (ref $t1)) ;; a variable to hold the new funcref
     ...
     (local.set $n 
       (func.new $m1 $t1 $s1                ;; code lives in $m1, result sig is $t1, scope is $s1
          (i32.const 1024) (i32.const 10))) ;; code is stored at address 1024 and is 10 bytes long
     ...
     (call_ref $t1 (local.get $n))     ;; call the new function!!
   )
)
```

### Sound static analysis

Sound static analysis of Wasm code is vital for offline transformations such as `wasm-opt`.
This proposal preserves reasoning about a module's internals and transformations of them by making its interactions with runtime-generated code explicit.
Since runtime generated code can only access the declarations explicitly provided by its scope, analysis can soundly treat declarations mentioned in scopes similarly to exported functions.
However, unlike exported functions, scopes cannot be accessed outside a module.
Thus a module's public interface is not polluted with its internal use of dynamically-generated code.

### Toolchain transformations

Sound static analysis implies that toolchains making closed-world assumptions for optimization (e.g. dead-code elimination) can account for all potential future uses by dynamically-generated code by simply considering scopes.
Reorganization of modules resulting from DCE is sound, as scopes can be rewritten for updated indices.
Since dynamically-generated code must use scoped indices, it is not affected by the renumbering of the containing module.
Thus DCE and other aggressive transformations can be made sound and not affect dynamically-generated code.

### Engine optimizations

The possibility of dynamically-generated code implies that an engine has runtime capability to parse function bodies and perform code validation. However, the `func.new` bytecode doesn't require parsing and validating sections, so the runtime system doesn't need a fully-featured Wasm module parser.

New code implies the need for at least one execution tier, such as interpreter or compiler.
This implies AOT scenarios need to either disable the feature, e.g. reject code memories, trap on `func.new`, or integrate a new tier. Note that since a scope defines a module context, the execution tier only needs to support runtime features that could be legally used under that context--basically, no memories implies no load/store instructions, no GC types implies no GC instructions.

In the future, we could consider additional restrictions, such as an explicit list of allowable bytecodes for new functions. That could allow a module to limit language features for new functions and greatly reduce the runtime system requirement. Since this is a restriction a module imposes on itself, it need not be standardized. As an example of the usefulness of this, a module could limit its `func.new` capabilities to only allow `i32` arithmetic and control flow. An AOT implementation could then provide a runtime execution tier that *only* supported that restricted set, keeping it both simple and optimized for the use case.



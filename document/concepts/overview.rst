Overview
--------

WebAssembly encodes a low-level, assembly-like programming language.
This language is structured around the following main concepts.

* **Values**.
  WebAssembly provides only four basic *value types*.
  These are integers and :ref:`IEEE-754 floating point <http://ieeexplore.ieee.org/document/4610935/>` numbers,
  each in 32 and 64 bit width.
  32 bit integers also function as Booleans and as memory addresses.
  The usual basic operations on these types are available,
  including the full matrix of conversions between them.
  There is no distinction between signed and unsigned integer types.
  Instead, different signedness is handled by different operations,
  selecting either unsigned or 2’s complement signed interpretation.

* **Instructions**.
  The computational model of WebAssembly is based on a *stack machine*.
  Code consists of sequences of *instructions* that are executed in order.
  They manipulate values on an implicit *operand stack*. [#stackmachine]_
  Instructions fall into two main categories.
  *Simple* instructions perform basic operations on data.
  They pop argument values from the operand stack and push result values back to it.
  *Control* instructions alter control flow.
  They are either sources or targets of *branches*.
  Control flow is *structured*, i.e., it is expressed with well-nested constructs such as blocks, loops, and conditionals.
  Branches can only target such constructs.

* **Traps**.
  Some instructions may produce a *trap* under some conditions,
  which immediately aborts excecution.
  Traps cannot be handled by WebAssembly code,
  but are reported to the outside environment,
  where they typically can be caught.

* **Functions**.
  Code is organized into separate *functions*.
  Each function takes a sequence of values as parameters
  and returns zero or one values as a result.
  Functions can call each other, including recursively.
  The call stack is implicit and cannot be accessed directly.
  Nor is the address of a function accessible.
  Functions may also declare mutable *local variables* that are usable as virtual registers.

* **Tables**.
  A *table* is an array of opaque values of a particular *element type*.
  It allows programs to select such values indirectly through a dynamic index operand.
  Currently, the only available element type is an untyped function reference.
  Thereby, code can perform an indirect call to a function indexed through a table.
  For example, this allows emulating function pointers with table indices.

* **Linear Memory**.
  A *linear memory* is a contiguous, mutable array of untyped bytes.
  Such a memory is created with an initial size but can be dynamically grown.
  A program can load and store values from/to a linear memory at any byte address (including unaligned) in little endian format.
  Integer access can specify a *storage size* which is smaller than the size of the respective value type.
  A trap occurs if access is not within the bounds of the current memory size.

* **Modules**.
  A WebAssembly binary takes the form of a *module*
  that contains definitions for functions, tables, and linear memories.
  It can also define mutable or immutable *global variables*.
  Each definition can optionally be *exported* under one or more names.
  Definitions can also be *imported*, specifying a module/name pair and a suitable type.

  To use it, a module must first be *instantiated*.
  An *instance* is the dynamic representation of a module,
  complete with its own state and execution stack.
  Instantiation requires providing definitions for all imports,
  which may be exports from previously created instances.
  WebAssembly computations can be initiated by invoking an exported function of an instance.
  In addition to definitions, a module can define initialization data for its memory or table
  that takes the form of *segments* copied to given offsets upon instantiation.
  It can also define a *start function* that is automatically executed after instantiation.

* **Validation**.
  To be instantiated, a module must be *valid*.
  Validation performs *type-checking* of functions and their bodies,
  as well as checking of other well-formedness conditions,
  e.g., that a module has no duplicate export names.

* **Embedder**.
  A WebAssembly implementation will typically be *embedded* into a *host* environment.
  Instantiation of modules and invocation of exports is controlled from this environment.
  An embedder can also provide external means to create and initialize memories or tables imported by a module.
  Furthermore, it may allow to supply functions from the host environment as imports to WebAssembly modules.
  However, form and semantics of such functionality are outside the scope of this specification, and will instead be provided by complementary, environment-specific API definitions.


.. [#stackmachine] In practice, implementations need not maintain an actual operand stack. Instead, the stack can be viewed as a set of anonymous registers that are implicitly referenced by instructions. The :ref:`type system <validation>` ensures that the stack height, and thus any referenced register, is always known statically.
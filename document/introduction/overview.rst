Overview
--------

.. index:: concepts, value, instruction, trap, function, table, memory, linear memory, module, !embedder

Concepts
~~~~~~~~

WebAssembly encodes a low-level, assembly-like programming language.
This language is structured around the following main concepts.

**Values**
  WebAssembly provides only four basic *value types*.
  These are integers and `IEEE-754 floating point <http://ieeexplore.ieee.org/document/4610935/>`_ numbers,
  each in 32 and 64 bit width.
  32 bit integers also serve as Booleans and as memory addresses.
  The usual operations on these types are available,
  including the full matrix of conversions between them.
  There is no distinction between signed and unsigned integer types.
  Instead, integers are interpreted by respective operations
  as either unsigned or signed in 2’s complement representation.

**Instructions**
  The computational model of WebAssembly is based on a *stack machine*.
  Code consists of sequences of *instructions* that are executed in order.
  Instructions manipulate values on an implicit *operand stack* [#stackmachine]_
  and fall into two main categories.
  Simple instructions perform basic operations on data.
  They pop arguments from the operand stack and push results back to it.
  *Control* instructions alter control flow.
  Control flow is *structured*, meaning it is expressed with well-nested constructs such as blocks, loops, and conditionals.
  Branches can only target such constructs.

**Traps**
  Under some conditions, certain instructions may produce a *trap*,
  which immediately aborts excecution.
  Traps cannot be handled by WebAssembly code,
  but are reported to the outside environment,
  where they typically can be caught.

**Functions**
  Code is organized into separate *functions*.
  Each function takes a sequence of values as parameters
  and returns a sequence of values as results. [#arity]_
  Functions can call each other, including recursively,
  resulting in an implicit call stack that cannot be accessed directly.
  Functions may also declare mutable *local variables* that are usable as virtual registers.

**Tables**
  A *table* is an array of opaque values of a particular *element type*.
  It allows programs to select such values indirectly through a dynamic index operand.
  Currently, the only available element type is an untyped function reference.
  Thereby, a program can call functions indirectly through a dynamic index into a table.
  For example, this allows emulating function pointers with table indices.

**Linear Memory**
  A *linear memory* is a contiguous, mutable array of untyped bytes.
  Such a memory is created with an initial size but can be dynamically grown.
  A program can load and store values from/to a linear memory at any byte address (including unaligned).
  Integer loads and stores can specify a *storage size* which is smaller than the size of the respective value type.
  A trap occurs if access is not within the bounds of the current memory size.

**Modules**
  A WebAssembly binary takes the form of a *module*
  that contains definitions for functions, tables, and linear memories,
  as well as mutable or immutable *global variables*.
  Definitions can also be *imported*, specifying a module/name pair and a suitable type.
  Each definition can optionally be *exported* under one or more names.
  In addition to definitions, a module can define initialization data for its memory or table
  that takes the form of *segments* copied to given offsets.
  It can also define a *start function* that is automatically executed.

**Embedder**
  A WebAssembly implementation will typically be *embedded* into a *host* environment.
  This environment defines how loading of modules is initiated,
  how imports are provided (including host-side definitions), and how exports can be accessed.
  However, the details of any particular embedding are beyond the scope of this specification, and will instead be provided by complementary, environment-specific API definitions.


.. [#stackmachine] In practice, implementations need not maintain an actual operand stack. Instead, the stack can be viewed as a set of anonymous registers that are implicitly referenced by instructions. The :ref:`type system <validation>` ensures that the stack height, and thus any referenced register, is always known statically.

.. [#arity] In the current version of WebAssembly, there may be at most one result value.


.. index:: phases, decoding, validation, execution, instantiation, invocation

Semantic Phases
~~~~~~~~~~~~~~~

Conceptually, the semantics of WebAssembly is divided into three phases.
For each part of the language, the specification specifies each of them.

**Decoding**
  WebAssembly modules are distributed in a *binary format*.
  *Decoding* processes that format and converts it into an internal representation of a module.
  In this specification, this representation is modelled by *abstract syntax*, but a real implementation could compile directly to machine code instead.

**Validation**
  A decoded module has to be *valid*.
  Validation checks a number of well-formedness conditions to guarantee that the module is meaningful and safe.
  In particular, it performs *type checking* of functions and the instruction sequences in their bodies, ensuring for example that the operand stack is used consistently.

**Execution**
  Finally, a valid module can be *executed*.
  Execution can be further divided into two phases:

  **Instantiation**.
  An *instance* is the dynamic representation of a module,
  complete with its own state and execution stack.
  Instantiation executes the module body itself given definitions for all its imports.
  It initializes globals, memories and tables and invokes the module's start function if defined.
  It returns the instances of the module's exports.

  **Invocation**.
  Once instantiated, further WebAssembly computations can be initiated by *invoking* an exported function of an instance.
  Given the required arguments, that executes the respective function and returns its results.

  Instantiation and invocation are operations within the embedding environment.

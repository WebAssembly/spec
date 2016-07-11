WebAssembly Specification
================================================================================

0. [Introduction](#introduction)
0. [Basics](#basics)
0. [Module](#module)
0. [Binary Format](#binary-format)
0. [Text Format](#text-format)
0. [Validation](#validation)
0. [Execution](#execution)
0. [Instruction Descriptions](#instruction-descriptions)
0. [Instructions](#instructions)


Introduction
--------------------------------------------------------------------------------

WebAssembly is a general-purpose virtual [ISA] designed to be a compilation
target for a wide variety of programming languages. Much of its distinct
personality derives from its security, code compression, and decoding
optimization features.

The unit of WebAssembly code is the *module*. Modules primarily consist of a
collection of sections. There are sections describing a WebAssembly's
interactions with other modules ([imports] and [exports]), sections declaring
[data](#data-section) and other implements used by the module, and sections
defining [*functions*]. For more information, see the [Module section].

WebAssembly modules can be encoded either in [binary format] for size and
decoding efficiency or in [text format] for readability, and can be translated
from either format to the other.

WebAssembly code must be validated before it can be instantiated and executed.
WebAssembly is designed to allow validation to be performed in a single linear
pass through a WebAssembly module. In particular, control flow within each
function is *structured*, and [loops are explicitly identified](#loop), which,
for example, allows decoders to ensure that program state is consistent at all
control flow merge points without having to see the entire function body first.
For more information, see the [Validation section](#validation).

A WebAssembly module can be [*instantiated*] to produce a WebAssembly instance,
which contains all the data structures required by the module's code for
execution. Instances can include [linear memory](#linear-memory-section), which
can serve the purpose of an address space for program data. For security and
determinism, linear memory is *sandboxed*, and the other data structures in an
instance, including the call stack, are allocated outside of linear memory so
that they cannot be corrupted by errant linear-memory accesses. An instance can
then be executed, either by execution of its [start function](#start-section) or
by calls to its exported functions.

Along with the other contents, each function contains a sequence of
*instructions*. WebAssembly instructions conceptually communicate with each
other primarily via pushing and popping values on a virtual stack, which allows
them to have a very compact encoding. For more information, see the
[Execution section](#execution).

WebAssembly has instructions for performing integer and floating-point
arithmetic, directing control flow, loading and storing to linear memory (as a
[load-store architecture]), calling functions, and more. For more information,
see the [Instructions section]. The [Instruction Descriptions section] provides
more information on how instructions are described.

Implementations of WebAssembly [validation] and [execution] need not perform all
the steps literally as described here; they need only behave ["as if"] they did
so in all observable respects.

[ISA]: https://en.wikipedia.org/wiki/Instruction_set
[imports]: #import-section
[exports]: #export-section
[*functions*]: https://en.wikipedia.org/wiki/Subroutine
[Module section]: #module
[*instantiated*]: #module-instantiation
[load-store architecture]: https://en.wikipedia.org/wiki/Load/store_architecture
[Instructions section]: #instructions
[Instruction Descriptions section]: #instruction-descriptions
[validation]: #validation
[execution]: #execution
["as if"]: https://en.wikipedia.org/wiki/As-if_rule


Basics
--------------------------------------------------------------------------------

0. [Bytes](#bytes)
0. [Pages](#pages)
0. [Types](#types)
0. [Nondeterminism](#nondeterminism)

### Bytes

[*Bytes*] in WebAssembly are 8-[bit], and are the addressing unit of
linear-memory accesses.

[*Bytes*]: https://en.wikipedia.org/wiki/Byte

### Pages

[*Pages*] in WebAssembly are 64 [KiB], and are the units used in linear-memory
size declarations and size operations.

[*Pages*]: https://en.wikipedia.org/wiki/Page_(computer_memory)

### Types

0. [Integer Types](#integer-types)
0. [Floating-Point Types](#floating-point-types)

#### Integer Types

| Name  | Bits |
| ----- | ---- |
| `i32` | 32   |
| `i64` | 64   |

Integer types in WebAssembly aren't inherently signed or unsigned. They may be
interpreted as signed or unsigned by individual operations. When interpreted as
signed, a [two's complement] interpretation is used.

> The [minimum signed integer value] is supported; consequently, two's
complement signed integers aren't symmetric around zero.

> When used as linear-memory indices or function table indices, integer types
may play the role of "pointers".

##### Booleans

[Boolean][actual boolean] values in WebAssembly are represented as values of
type `i32`. In a boolean context, such as a `br_if` condition, any non-zero
value is interpreted as true and `0` is interpreted as false.

Any operation that produces a boolean value, such as a comparison, produces the
values `0` and `1` for false and true.

[actual boolean]: https://en.wikipedia.org/wiki/Boolean_data_type

> The [binary format] often uses alternate encodings for integers and boolean
values, rather than using the literal encodings described here.

#### Floating-Point Types

| Name  | Bits |
| ----- | ---- |
| `f32` | 32   |
| `f64` | 64   |

`f32` in WebAssembly uses the IEEE 754-2008 [binary32] format, commonly known as
"single precision".

`f64` in WebAssembly uses the IEEE 754-2008 [binary64] format, commonly known as
"double precision".

> Unlike with [Numbers in ECMAScript], [NaN] values in WebAssembly have sign
bits and significand fields which may be observed and manipulated (though they
are usually unimportant).

[binary32]: https://en.wikipedia.org/wiki/Single-precision_floating-point_format
[binary64]: https://en.wikipedia.org/wiki/Double-precision_floating-point_format
[Numbers in ECMAScript]: https://tc39.github.io/ecma262/#sec-ecmascript-language-types-number-type
[NaN]: https://en.wikipedia.org/wiki/NaN

### Nondeterminism

When semantics are specified as *nondeterministic*, a WebAssembly implementation
may perform any one of the specified alternatives.

> All instances of nondeterminism in WebAssembly are explicitly described as
such with a link to this section.

> There is no "undefined behavior" in WebAssembly where the semantics become
completely unspecified.

> There is no requirement that a given implementation make the same choice every
time, even for successive executions of the same instruction within the same
instance of a module.


Module
--------------------------------------------------------------------------------

0. [Module Types](#module-types)
0. [Instantiation-Time Initializers](#instantiation-time-initializers)
0. [Module Contents](#module-contents)
0. [Known Sections](#known-sections)
0. [Module Index Spaces](#module-index-spaces)

### Module Types

These types describe various data structures present in WebAssembly modules:

0. [Index](#index)
0. [Array](#array)
0. [String](#string)

> These types aren't used to describe values at runtime.

#### Index

An *index* is a 32-bit unsigned integer value.

> Indices may be represented in compressed form in some representations.

#### Array

An *array* is an [index] indicating a number of elements, plus a sequence of
that many elements.

> Array elements needn't all be the same size in some representations.

#### String

A *string* is an [array] of bytes.

> Strings in this context may contain arbitrary bytes and aren't required to be
valid UTF-8 or any other format, and aren't required to be NUL-terminated.

### Instantiation-Time Initializers

An *instantiation-time initializer* is a single [instruction](#instructions),
which must be one of the following:
 - [`const`](#constant) (with any type prefix).
 - [`get_global`](#get-global).

The value produced by a module initializer is the value that such an instruction
would produce if it were executed within a function body.

**Validation:**
 - If the instruction is a `get_global`, the global index is required to be
   within the bounds of the [global index space], and the indexed global
   declaration is required to have the immutable flag set.

> In the future, more instructions may be permitted as instantiation-time
initializers.

### Module Contents

Modules contain a version [index].

Modules also contain a sequence of sections. Each section has a [string] *name*
and associated data.

**Validation:**
 - The version index is required to be equal to `0xc`.
 - For each present [known section](#known-sections), the requirements of its
   **Validation** clause are required, if one is specified for the section kind.
 - The requirements of the **Validation** clauses of every
   [index space](#module-index-spaces) are required, if one is specified for the
   index space.
 - Present known sections are required to be ordered in the section sequence as
   they are ordered in the [enumeration of the Known Sections](#known-sections).

> Some representations don't represent some of the known sections literally;
they may be combined with other sections or implied by specialized syntax.

> The initial release of WebAssembly will use an expected version of `0x0`.

### Known Sections

There are several *known sections*:

0. [Type Section]
0. [Import Section]
0. [Function Section]
0. [Table Section]
0. [Linear-Memory Section]
0. [Export Section]
0. [Start Section]
0. [Code Section]
0. [Data Section]
0. [Global Section]
0. [Element Section]
0. [Name Section]

TODO: What should the names and positions of the Global and Element sections be?

TODO: Reorder the known sections strategically?

TODO: Rename "Element Section" to "Elements Section"? Most of the other sections
use the singular, though "Data" is plural.

#### Type Section

**Name:** `type`.

The Type Section consists of an [array] of function signatures.

Each *function signature* consists of:
 - a *parameter list*, which is an [array] of [types].
 - a *return list*, which is also an [array] of [types].

**Validation:**
 - Each return list is required to contain at most one element.

> In the future, this section may contain other forms of type entries as well,
and support for function signatures with multiple return types.

#### Import Section

**Name:** `import`

The Import Section consists of an [array] of imports.

An *import* is one of the following:
 - a function import.
 - a linear-memory import.
 - a global import.
 - a table import.

All imports contain:
 - a *module [string]*, identifying a module to import from.
 - a *name [string]*, identifying an export in that module to import.

A *function import* additionally contains:
 - a function declaration, as described in the [Function Section].

A *linear-memory import* additionally contains:
 - a linear-memory declaration, as described in the [Linear-Memory Section].

A *global import* additionally contains:
 - a global declaration, as described in the [Global Section].

A *table import* additionally contains:
 - a table declaration, as described in the [Table Section].

The meaning of the module string and name string are determined by the embedding
environment.

Imports provide access to constructs, defined and allocated by external entities
outside the scope of this specification (though they may be other WebAssembly
modules), but which have behavior consistent with their corresponding concepts
defined in this spec.

**Validation:**
 - All global imports must be immutable.
 - Each global import with an initializer is required to be mutable.
 - Each import is required to be resolved by the embedder.
 - Embedding-specific validation may be performed on each import.

> Global imports may be permitted to be mutable in the future.

#### Function Section

**Name:** `function`

The Function Section consists of an [array] of function declarations. Its
elements directly correspond to elements in the [Code Section] array.

A *function declaration* consists of:
 - an index in the [Type Section] of the signature of the function.

**Validation:**
 - The array is required to be the same length as the [Code Section] array.

#### Table Section

**Name:** `table`

The Table Section consists of an [array] of table declarations.

A *table declaration* consists of:
 - A *default* flag.
 - An *element type*, for which the only valid value is `"anyfunc"`.
 - An *initial length*.
 - A *maximum length*.

Tables with an element type of "anyfunc" hold function references of any type.

> Additional elements types may be added in the future.

#### Linear-Memory Section

**Name:** `memory`

The Memory Section consists of an array of linear-memory declarations.

A *linear-memory declaration* contains:
 - An *index bitwidth* [index]. Within the context of this linear memory, `iPTR`
   refers to an integer type with this bitwidth.
 - An *initial size*, which is an unsigned `iPTR` value, in units of [pages].
 - An optional *maximum size*, which if present is an unsigned `iPTR` value, in
   units of [pages]. See the [`grow_memory`](#grow-memory) instruction for
   further information on this field.
 - A *default* flag, which is a boolean value indicating whether the
   linear-memory space is to be the default linear-memory space for the module.

TODO: The index bitwidth field anticipates a proposal to add this flag.

TODO: Change the **Name** to be "linear-memory"?

> When a maximum size value is present, implementations are encouraged to
attempt to reserve enough resources for allocating up to the maximum size up
front. Otherwise, implementations are encouraged to allocate only enough for
the initial size up front.

#### Export Section

**Name:** `export`

The Export Section consists of an [array] of exports.

An *export* is one of the following:
 - a function export.
 - a linear-memory export.
 - a global export.
 - a table export.

All exports contain:
 - a *name [string]*.

An *function export* additionally contains:
 - an [index] of a function in the [function index space] to export.

A *linear-memory export* additionally contains:
 - an [index] of a linear-memory space in the [linear-memory index space] to
   export.

A *global export* additionally contains:
 - an [index] of a global in the [global index space] to export.

A *table export* additionally contains:
 - an [index] of a table in the [table index space] to export.

The meaning of the module string and name string are determined by the embedding
environment.

Exports provide access to an instance's constructs to external entities outside
the scope of this specification (though they may be other WebAssembly modules),
but which have behavior consistent with their corresponding concepts defined in
this spec.

**Validation:**
 - Each export's name is required to be unique among all the exports' names.
 - Each export's index is required to be within the bounds of its associated
   index space.

> Because exports reference index spaces which include imports, modules can
re-export their imports.

#### Start Section

**Name:** `start`

The Start Section consists of a function [index]. See
[Instance Execution](#instance-execution) for further information.

**Validation:**
 - The index is required to be within the bounds of the [Code Section] array.
 - The function signature indexed in the [Type Section] is required to have an
   empty parameter list and an empty return list.

#### Code Section

**Name:** `code`

The Code Section consists of an [array] of function bodies.

A *function body* consists of:
 - an [array] of [types], which declare the number and types of locals.
 - a sequence of [instructions](#instructions).

> Validation of function bodies is described
[separately](#function-body-validation).

##### Positions Within A Function Body

A *position* within a function refers to an element of the instruction sequence.

> In the [binary format], positions are represented as byte offsets; in the
[text format], positions are represented with a special syntax.

#### Data Section

**Name:** `data`

The Data Section consists of an [array] of data initializers.

A *data initializer* consists of:
 - a linear-memory index.
 - a *start offset* which is an
   [instantiation-time initializer](#instantiation-time-initializers).
 - a [string] of data.

It describes data to be loaded into the linear memory identified by the index in
the [linear-memory index space] during
[linear-memory instantiation](#linear-memory-instantiation).

**Validation:**
 - For each element of the array:
    - The linear-memory index is required to be within the bounds of the
      linear-memory index space.
    - A linear-memory space is identified by the linear-memory index in the
      linear-memory index space and:
       - The sum of the start offset and the length of the string is required to
         be less than the initial size declared for the linear-memory space.
       - The start offset is required to be greater than the index of any byte
         in the linear-memory space that will be initialized by a prior
         initializer.

#### Global Section

**Name:** `global`

The Global Section consists of an [array] of global declarations.

A *global declaration* consists of:
 - A [type].
 - An *immutable* flag.
 - An optional *initializer*, which is an
   [instantiation-time initializer](#instantiation-time-initializers).

#### Element Section

**Name:** `element`

The Element Section consists of an [array] of table initializers.

A *table initializer* consists of:
 - a table index.
 - a *start offset* which is an
   [instantiation-time initializer](#instantiation-time-initializers).
 - an [array] of table element initializers.

A *table element initializer* consists of:
 - an index-space selector, which conceptually identifies an index space and for
   which the only valid value is "the function index Space".
 - an index into the selected space.

**Validation:**
 - For each element of the array:
    - The table index is required to be within the bounds of the table index
      space.
    - A table is identified by the table index in the table space and:
       - The sum of the start offset and the length of
         the element initializer array is required to be less than the initial
         size declared for the table.
       - The start offset is required to be greater than the index of any
         element in the table that will be initialized by a prior initializer.
       - For each element of the indexed table element initializer:
          - The type of the elements of the selected index space are required to
            be compatible with the type of the table to be initialized.
          - The index is required to be within the bounds of the selected index
            space.

> The Element Sections is to the [Table Section] as the [Data Section] is to the
[Linear-Memory Section].

> Initializers may be able to reference other index spaces in the future.

TODO: Rename this to the Table Initializer Section?

#### Name Section

**Name:** `name`

The Names Section consists of an [array] of function name descriptors, which
each describe names for the function with the corresponding index in the module,
and which consist of:
 - the function name, a [string].
 - the names of the locals in the function, an [array] of [strings].

The Names Section doesn't change execution semantics and malformed constructs,
such as out-of-bounds indices, in this section cause the section to be ignored,
and don't trigger validation failures.

> Name data is represented as an explicit section in the [binary format],
however in the [text format] it may be represented as an integrated part of the
syntax for functions rather than as a discrete section.

> The expectation is that, when a binary WebAssembly module is presented in a
human-readable format in a browser or other development environment, the names
in this section are to be used as the names of functions and locals in the
[text format].

TODO: Should the names in this section be required to be valid UTF-8 strings?
This section isn't used during normal validation or execution, so it's off the
"hot path" and is only used during debugging, to present strings to humans, so
it might make sense.

### Module Index Spaces

0. [Function Index Space]
0. [Global Index Space]
0. [Linear-Memory Index Space]
0. [Table Index Space]

#### Function Index Space

The *function index space* begins with an index for each function in the
[Function Section], if present, in the order of that section, followed by an
index for each imported function, in the order the imports appear in the
[Import Section].

**Validation:**
 - For each element in the index space, the type index is required to be within
   the bounds of the [Type Section] array.

> The function index space is used by [`call`](#call) instructions to identify
the callee of a direct call.

#### Global Index Space

The *global index space* begins with an index for each global in the
[Global Section], if present, in the order of that section, followed by an index
for each imported global, in the order the imports appear in the
[Import Section].

> The global index space is used by:
 - the [`get_global`](#get-global) and [`set_global`](#set-global) instructions.
 - the [Data Section], to define the offset of a data segment (in linear memory)
   as the value of a global variable.

#### Linear-Memory Index Space

The *linear-memory index space* begins with an index for each linear-memory
space defined in the [Linear-Memory Section], if present, in the order of that
section, followed by an index for each imported linear memory, in the order the
imports appear in the [Import Section].

**Validation:**
 - The index space is required to have at most one element.
 - For each linear-memory declaration in the index space:
    - If a maximum size is present, it is required to be at least the initial
      size.
    - The index of every byte in a linear memory with the initial size is
      required to be representable in an unsigned `iPTR`.
    - If a maximum size is present, the index of every byte in a linear memory
      with the maximum size is required to be representable in an unsigned
      `iPTR`.
    - The index bitwidth is required to be `32`.
    - The default flag is required to be true.

> The validation rules here specifically avoid requiring the size in bytes of
linear memory to be representable as an unsigned `iPTR`. For example a 32-bit
linear-memory address space could theoretically be resized to 4 GiB if the
implementation has sufficient resources; the index of every byte would be
addressable, even though the total number of bytes would not be.

> Multiple linear-memory spaces may be permitted in the future.

> 64-bit linear-memory spaces may be permitted in the future.

#### Table Index Space

The *table index space* begins with an index for each table defined in the
[Table Section], in the order of that section, if present, followed by an index
for each imported table, in the order the imports appear in the
[Import Section].

**Validation:**
 - The index space is required to contain at most one table.
 - Exactly one table is required to have the default flag set to true.
 - Each table's maximum length is required to be at least its initial length.

> The table index space is currently only used by the [Element Section].


Binary Format
--------------------------------------------------------------------------------

TODO: Describe the binary format. The high-level ideas are:
 - A module starts with a *magic cookie*, consisting of the 4-byte sequence
   0x00, 0x61, 0x73, 0x6d, followed by the [version](#module-contents) [index],
   followed by the encodings of the sections.
 - Most module [indices] values are typically encoded with [LEB128].
 - Module [arrays] values are encoded as the length [index] followed by the
   encodings of the elements.
 - Every [instruction](#instructions) is encoded as its Opcode value, followed
   by its immediate operand values.
 - Most immediate operand values are encoded with [LEB128], though there are
   several special cases.
 - Function bodies end with an implicit [`end`](#end) instruction.

[LEB128]: https://en.wikipedia.org/wiki/LEB128

> The magic cookie bytes begin with a NUL, indicating to tools that the ensuing
contents are not generally "text", followed by the UTF-8 encoding of the string
"asm".

TODO: Renumber the opcodes strategically?

TODO: Will the `end` be made explicit? Monitor
https://github.com/WebAssembly/design/pull/666


Text Format
--------------------------------------------------------------------------------

TODO: What will the text format look like? Monitor at least
https://github.com/WebAssembly/design/pull/704


Validation
--------------------------------------------------------------------------------

0. [Module Validation](#module-validation)
0. [Function Body Validation](#function-body-validation)

### Module Validation

Validation of a module requires the requirements of the **Validation** clause of
the [top-level module description](#module-contents).

Then, if the module contains a [Code Section], each function body in the section
is [validated](#function-body-validation).

### Function Body Validation

0. [Function Body Validation Requirements](#function-body-validation-requirements)
0. [Function Body Validation Algorithm](#function-body-validation-algorithm)

#### Function Body Validation Requirements

The requirements for function body validation are:
 - The instruction sequence is required to be non-empty, and the last
   instruction in the sequence is required to be an [`end`](#end).
 - Control-flow constructs are required to form properly nested *regions*. Each
   [`loop`](#loop), [`block`](#block), and the function entry begin a region
   required to be terminated with an [`end`](#end). Each [`if`](#if) begins a
   region terminated with either an [`end`](#end) or an [`else`](#else). Each
   [`else`](#else) begins a region terminated with an [`end`](#end). Each `end`
   and each `else` terminates exactly one region.
 - Branches to labels must be from within the region bounded by the instruction
   that binds the label.
 - The sequence of values that would be on the value stack at execution of each
   instruction is required be the same for all possible control-flow paths to
   that instruction.
 - The [types] of the operands passed to each instruction are required to
   conform to the instruction's signature's operands.
 - At each instruction, all values that will be popped from the value stack at
   that instruction are required to have been pushed within the same region (or
   within an region nested inside it).
 - For each instruction, the requirements of the **Validation** clause in the
   associated instruction description are required.

> The final [`end`](#end) instruction may be implicit in some representations.

> These requirements are sufficient to ensure that WebAssembly has
*reducible control flow*, which essentially means that all loops have exactly
one entry point.

> There are no implicit type conversions in WebAssembly.

#### Function Body Validation Algorithm

Function body validation can be performed in a single linear pass as follows:

The following data structures are created:
 - A *type stack*, with entries each containing a [type], for tracking the
   sequence of values that will be on the value stack at execution time.
 - A *control-flow stack*, with entries each containing:
    - A *limit* integer value, which is an index into the type stack indicating
      the boundary between values pushed before the current region and values
      pushed inside the current region.
    - An optional [type] sequence, which is used to check that all exits from
      the current region leave the same sequence of types on the type stack.

The following invariants are required to be preserved:
 - Whenever an element of either stack is to be popped, that stack is required
   to be non-empty.
 - Whenever an element of either stack is to be accessed by index, the index is
   required to be within the bounds of that stack.
 - Whenever the control-flow stack is non-empty, as it is everywhere except
   after the `end` at the end of the function, the type stack must be longer
   than the control-flow stack top's limit value.

The type stack begins empty. The control-flow stack begins with one entry, with
the [type] sequence consisting of the return types of the function, and with the
limit value being zero.

For each instruction in the body, in sequence order:
 - For each construct in the instruction's signature's operands in reverse
   order:
    - If the construct is a [type], a type is popped from the type stack and
      required to be the same.
    - If the construct is a list of type parameters:
        - If the parameters are not yet bound, a type for each type parameter in
          the list in reverse order is popped from the type stack and bound to
          it.
        - Otherwise, a type for each type in the list in reverse order is popped
          from the type stack and required to be the same.
   The popped types in reverse (again) order form the *operand sequence*.
 - Unless the instruction is a [control-flow barrier][Q], then for each
   construct in the instruction's signature's returns:
    - If the construct is a [type], a type is pushed onto the type stack.
    - If the construct is a list of type parameters, they are required to be
      bound, and the type bound to each type parameter is pushed onto the type
      stack.
 - If the instruction has a **Validation** clause, its requirements are
   required.
 - If the instruction has a **Validation Algorithm** clause, its contents are
   performed.
 - If the instruction's signature has no return types, or it is a
   [control-flow barrier][Q], the new length of the type stack is required to be
   at most the control-flow stack top's limit value.

Finally, for each type in the function's return list, a type is popped from the
type stack and required be the same. The type stack and the control-flow stack
are then both required to be empty. If all requirements were met, function body
validation is successful.

> Implementations need not perform this exact algorithm; they need only validate
that the [requirements](#function-body-validation-requirements) are met.

> The control-flow stack's limit values effectively mark region boundaries in
the type stack. Regions are required to be nested, and each region's limit value
is greater than those of the regions that enclose it. Types pushed onto the type
stack outside a region cannot be popped from within the region.

##### Type-Sequence Merge

To merge a new type sequence into a control flow stack entry:
 - If the entry's optional type sequence is absent, it is set to be the new
   sequence.
 - Otherwise, the entry's type sequence is required to be the same as the new
   sequence.


Execution
--------------------------------------------------------------------------------

### Module Instantiation

WebAssembly code execution requires an *instance* of a module, which contains a
reference to the module plus additional information added during instantiation,
which consists of the following steps:
 - The entire module is first [validated](#validation). If there are any
   failures, instantiation aborts and doesn't produce an instance.
 - If a [Linear-Memory Section] is present, each linear-memory space is
   [instantiated](#linear-memory-instantiation).
 - If a [Table Section] is present, each table is
   [instantiated](#table-instantiation).
 - A finite quantity of [call-stack resources] is allocated.
 - A *globals array* is allocated, which is a heterogeneous array of globals
   corresponding to the entries in the module's [Global Section]. The initial
   value of each global is the value of its
   [instantiation-time initializer](#instantiation-time-initializers), if it has
   one, or an all-zeros bit-pattern otherwise.

> The contents of an instance, including functions and their bodies, are outside
any linear address space and not any accessible to applications. WebAssembly is
therefore conceptually a [Harvard Architecture].

TODO: Will validation of the entire module be required? Monitor
https://github.com/WebAssembly/design/pull/719

[Harvard Architecture]: https://en.wikipedia.org/wiki/Harvard_architecture

#### Linear-Memory Instantiation

A linear-memory declaration in the [Linear-Memory Section] may be instantiated
as follows:

An array of [bytes] with the length being the value of the linear-memory space's
initial size field is created and added to the instance. Any byte not
initialized by any data initializer is initialized to zero.

The contents of the [Data Section] are loaded into this array. Each [string] is
loaded into linear memory at its associated start offset.

**Trap:** Dynamic Resource Exhaustion, if dynamic resources are insufficient to
support creation of the array.

#### Table Instantiation

For each table in the [Table Section]:
 - An array of elements is created with the table's initial length, with
   elements of the table's element type.

For each table initializer in the [Element Section], for the table identified by
the table index in the [table index space]:
 - A contiguous of elements in the table starting at the table initializer's
   start offset is initialized according to the elements of the table element
   initializers array, which specify an indexed element in their selected index
   space.

Any element not initialized by any table initializer is initialized to a special
"null" value.

**Trap:** Dynamic Resource Exhaustion, if dynamic resources are insufficient to
support creation of any of the tables.

#### Call-Stack Resources

Call-stack resources are an abstract quantity, with discrete units, of which a
[nondeterministic] amount is allocated during instantiation, belonging to an
instance.

> These resources is used by [call instructions][L].

> The specific resource limit serves as an upper bound only; implementations may
[nondeterministically] perform a trap sooner if they exhaust other dynamic
resources.

### Instance Execution

If the module contains a [Start Section], the referenced function is
[executed](#function-execution).

### Function Execution

Function execution can be prompted by a [call-family instruction][L], by
[instance execution](#instance-execution), or by the embedding environment.

The input to execution of a function consists of:
 - the function to be executed.
 - the incoming argument values, one for each parameter [type] of the function.

For the duration of the execution of a function body, several data structures
are created:
 - A *control-flow stack*, which holds [labels] for reference from branch
   instructions.
 - A *value stack*, which carries values between instructions.
 - A *locals* array, a heterogeneous array of values containing an element for
   each type in the function's parameter list, followed by an element for each
   local declaration in the function.
 - A *current position*.

> Implementations needn't create a literal array to store the locals, or literal
stacks to manage values at runtime.

> These data structures are all allocated outside any linear-address space and
are not any accessible to applications.

#### Function Execution Initialization

The current position starts at the first instruction in the function body. The
value stack begins empty. The control-flow stack begins with an entry holding a
[label] bound to the last instruction in the instruction sequence.

The value of each incoming argument is copied to the local with the
corresponding index, and the rest of the locals are initialized to all-zeros
bit-pattern values.

#### Function Body Execution

The instruction at the current position is remembered, and the current position
is incremented to point to the position following it. Then the remembered
instruction is executed as follows:

For each operand [type] in the instruction's signature in reverse order, a value
is popped from the value stack and provided as the corresponding operand value.
The instruction is then executed as described in the
[Instructions Section](#instructions) entry describing it. Each of the
instruction's return values are then pushed onto the value stack.

If the current position is now past the end of the sequence,
[function return execution](#function-return-execution) is initiated and
execution of the function is thereafter complete.

Otherwise, [execution](#function-body-execution) is restarted with the new
current position.

**Trap:** Dynamic Resource Exhaustion, if any dynamic resource used by the
implementation is exhausted, at any point during function body execution.

#### Labels

A label is a value which is either *unbound*, or *bound* to a specific position.

#### Instruction Traps

Instructions may *trap*, in which case execution of the current instance is
immediately terminated and abnormal termination is reported to the embedding
environment.

> Except for the call stack and the state of any executing functions, the
contents of an instance, including the linear memory, are left intact after a
trap. This allows inspection by debugging tools and crash reporters. It is also
valid to call exported functions in an instance that has trapped.

#### Function Return Execution

One value for each return [type] in the function signature in reverse order is
popped from the value stack. If the function execution was prompted by a
[call instruction][L], these values are provided as the call's return values.
Otherwise, they are provided to the embedding environment.


Instruction Descriptions
--------------------------------------------------------------------------------

Instructions in the [Instructions](#instructions) section are introduced with
tables giving a concise description of several of their attributes, followed by
additional content.

0. [Instruction Mnemonic Field](#instruction-mnemonic-field)
0. [Instruction Immediates Field](#instruction-immediates-field)
0. [Instruction Signature Field](#instruction-signature-field)
0. [Instruction Families Field](#instruction-families-field)
0. [Instruction Opcode Field](#instruction-opcode-field)
0. [Instruction Syntax Field](#instruction-syntax-field)
0. [Instruction Description](#instruction-description)

### Instruction Mnemonic Field

Instruction [mnemonics] are short names identifying specific instructions.

Many instructions have type-specific behavior, in which case there is a unique
mnemonic for each type, formed by prepending a *type prefix*, such as `i32.` or
`f64.`, to the base instruction mnemonic.

Conversion instructions have additional type-specific behavior; their mnemonic
additionally has a *type suffix* appended, such as `/i32` or `/f64`, indicating
the input type.

The base mnemonics for [signed][S] and [unsigned][U] instructions have the
convention of ending in "_s" and "_u" respectively.

[mnemonics]: https://en.wikipedia.org/wiki/Assembly_language#Opcode_mnemonics_and_extended_mnemonics

### Instruction Immediates Field

Immediates, if present, is a list of [typed] value names, representing values
provided by the module itself as input to an instruction.

As a special case, an immediate field can also contain `TABLE`, which signifies
a branch table, which is a sequence of immediate integer values. This is for use
in the [`br_table`](#table-branch) instruction.

### Instruction Signature Field

Instruction signatures describe the explicit inputs and outputs to an
instruction. They are described in the following form:

`(` *operands* `)` `:` `(` *returns* `)`

*Operands* describes a list of [types] for values provided by program execution
as input to an instruction. *returns* describes a list of [types] for values
computed by the instruction that are provided back to the program execution.

Within the signature for a [linear-memory access instruction][M], `iPTR` refers
an integer [type] with the index bitwidth of the accessed linear-memory space.

Besides literal [types], descriptions of [types] can be from the following
mechanisms:
 - A [typed] value name of the form

   *name*`:` *type*

   where *name* just provides an identifier for use in
   [instruction descriptions](#instruction-description). It is replaced by
   *type*.
 - A type parameter list of the form

   *name*`[` *length* `]`

   where *name* identifies the list, and *length* gives the length of the list.
   The length may be a literal value, an immediate operand value, or one of the
   named values defined below. Each type parameter in the list may be *bound* to
   a type as described in the instruction's description, or it may be inferred
   from the type of a corresponding operand value. The parameter list is
   replaced by the types bound to its parameters. If the list appears multiple
   times in a signature, it is replaced by the same types at each appearance.

The following named values are defined:
 - `$args` is defined in [call instructions][L] and indicates the length of the
   callee signature parameter list.
 - `$returns` is also defined in [call instructions][L] and indicates the length
   of callee signature return list.
 - `$any` indicates the number of values on the value stack pushed within the
   enclosing region. Within the validation algorithm, this is the difference
   between the length of the type stack and the control-flow stack top's limit
   value.

### Instruction Families Field

WebAssembly instructions may belong to several families, indicated in the tables
by their family letter:

0. [B: Branch Instruction Family][B]
0. [Q: Control-Flow Barrier Instruction Family][Q]
0. [L: Call Instruction Family][L]
0. [G: Generic Integer Instruction Family][G]
0. [S: Signed Integer Instruction Family][S]
0. [U: Unsigned Integer Instruction Family][U]
0. [T: Shift Instruction Family][T]
0. [F: Floating-Point Instruction Family][F]
0. [Z: Floating-Point Bitwise Instruction Family][Z]
0. [C: Comparison Instruction Family][C]
0. [M: Linear-Memory Access Instruction Family][M]
0. [R: Linear-Memory Size Instruction Family][R]

#### B: Branch Instruction Family

##### Branching

In a branch according to a given control-flow stack entry, first the value stack
is resized down to the entry's limit value.

Then, if the entry's [label] is bound, the current position is set to the bound
position. Otherwise, the position to bind the label to is found by scanning
forward through the instructions, as if executing just [`block`](#block),
[`loop`](#loop), and [`end`](#end) instructions, until the label is bound. Then
the current position is set to that position.

Then, control-flow stack entries are popped until the given control-flow stack
entry is popped.

> In practice, implementations may precompute the destinations of branches so
that they don't literally need to scan in this manner.

> Branching is sometimes called "jumping" in other languages.

#### Q: Control-Flow Barrier Instruction Family

These instructions either trap or reassign the current position, such that
execution does not proceed to the instruction that lexically follows them.

#### L: Call Instruction Family

##### Calling

If the called function&mdash;the *callee*&mdash;is a function in the module, it
is [executed](#function-execution). Otherwise the callee is an imported function
which is executed according to its own semantics. The `$args` operands,
excluding `$callee` when present, are passed as the incoming arguments. The
return value of the call is defined by the execution.

At least one unit of [call-stack resources] is consumed during the execution of
the callee, and released when it completes.

**Trap:** Call Stack Exhausted, if the instance has insufficient
[call-stack resources].

> This means that implementations aren't permitted to perform implicit
opportunistic tail-call elimination.

> The execution state of the function currently being executed remains live
during the call, and the execution of the called function is performed
independently. In this way, calls form a stack-like data structure called the
*call stack*.

> Data associated with the call stack is stored outside any linear address space
and is not directly accessible to applications.

##### Call Validation

 - The members of `$T[$args]` are bound to the operand types of the callee
   signature, and the members of `$T[$returns]` are bound to the return types of
   the callee signature.
 - `$arity` is required to be equal to `$args`.

> The `$arity` immediate operand provides no semantic content other than its
validation requirement.

#### G: Generic Integer Instruction Family

Except where otherwise specified, these instructions don't specifically
interpret their operands as explicitly signed or unsigned, and therefore don't
have an inherent concept of overflow.

#### S: Signed Integer Instruction Family

Except where otherwise specified, these instructions interpret their operand
values as signed, return result values interpreted as signed, and [trap] when
the result value can't be represented as such.

#### U: Unsigned Integer Instruction Family

Except where otherwise specified, these instructions interpret their operand
values as unsigned, return result values interpreted as unsigned, and [trap]
when the result value can't be represented as such.

#### T: Shift Instruction Family

In the shift and rotate instructions, *left* means in the direction of greater
significance, and *right* means in the direction of lesser significance.

##### Shift Count

The second operand in shift and rotate instructions specifies a *shift count*,
which is interpreted as an unsigned quantity modulo the number of bits in the
first operand.

> As a result of the modulo, in `i32.` instructions, only the least-significant
5 bits of the second operand affect the result, and in `i64.` instructions only
the least-significant 6 bits of the second operand affect the result.

> The shift count is interpreted as unsigned even in otherwise signed
instructions such as [`shr_s`](#integer-shift-right-signed).

#### F: Floating-Point Instruction Family

Instructions in this family follow the [IEEE 754-2008] standard, except that:

 - They support only "non-stop" mode, and floating-point exceptions aren't
   otherwise observable. In particular, neither alternate floating-point
   exception handling attributes nor the non-computational operations on status
   flags are supported.

 - They use the IEEE 754-2008 `roundTiesToEven` rounding attribute, except where
   otherwise specified. Non-default directed rounding attributes aren't
   supported.

When the result of any instruction in this family (which excludes `neg`, `abs`,
and `copysign`) is a NaN, the sign bit and the significand field (which doesn't
include the implicit leading digit of the significand) of the NaN are computed
by one of the following rules, selected [nondeterministically]:

 - If the instructions has any NaN non-immediate operand values, implementations
   may [nondeterministically] select any of them to be the result value, but
   with the most significant bit of the significand field overwritten to be `1`.

 - If the implementation doesn't choose to use an input NaN as a result value,
   or if there are no input NaNs, the result value has a [nondeterministic] sign
   bit, a significand field with `1` in the most significant bit and `0` in the
   remaining bits.

TODO: How does NaN propagation work? Monitor
https://github.com/WebAssembly/design/pull/713

Implementations are permitted to further implement the IEEE 754-2008 section
"Operations with NaNs" recommendation that operations propagate NaN bits from
their operands, however it isn't required.

> The exception and rounding behavior specified here are the default behavior on
most contemporary software environments.

> All computations are correctly rounded, subnormal values are fully supported,
and negative zero, NaNs, and infinities are all produced as result values to
indicate overflow, invalid, and divide-by-zero exceptional conditions, and
interpreted appropriately when they appear as operands. Compiler optimizations
that introduce changes to the effective precision, rounding, or range of any
computation are not permitted. All numeric results are deterministic, as are the
rules for how NaNs are handled as operands and for when NaNs are to be generated
as results. The only floating-point nondeterminism is in the specific
bit-patterns of NaN result values.

> In IEEE 754-1985, ["subnormal numbers"] are called "denormal numbers";
WebAssembly follows IEEE 754-2008, which calls them "subnormal numbers".

> There is no observable difference between quiet and signaling NaN other than
the difference in the bit pattern.

[IEEE 754-2008]: https://en.wikipedia.org/wiki/IEEE_floating_point
["subnormal numbers"]: https://en.wikipedia.org/wiki/Subnormal_number

#### Z: Floating-Point Bitwise Instruction Family

These instructions operate on floating-point values, but do so in purely bitwise
ways, including in how they operate on NaN and zero values.

They correspond to the "Sign bit operations" in IEEE 754-2008.

#### C: Comparison Instruction Family

WebAssembly comparison instructions compare two values and return a [boolean]
result value.

> In accordance with IEEE 754-2008, for the comparison instructions, negative
zero is considered equal to zero, and NaN values aren't less than, greater than,
or equal to any other values, including themselves.

#### M: Linear-Memory Access Instruction Family

These instructions load from and store to a linear-memory space.

##### Effective Address

The *effective address* of a linear-memory access is computed by adding `$base`
and `$offset`, both interpreted as unsigned, at infinite range and precision, so
that there is no overflow.

##### Alignment

**Slow:** If the effective address isn't a multiple of `$align`, the access is
*misaligned*, and the instruction may execute very slowly.

> When `$align` is at least the size of the access, the access is
*naturally aligned*. When it's less, the access is *unaligned*. Naturally
aligned accesses may be faster than unaligned accesses, though both may be much
faster than misaligned accesses.

> There is no other semantic effect associated with `$align`; misaligned and
unaligned loads and stores still behave normally.

##### Accessed Bytes

The *accessed bytes* consist of a contiguous sequence of [bytes] starting at the
[effective address], with a length implied by the accessing instruction.

**Trap:** Out Of Bounds, if any of the accessed bytes are beyond the end of the
accessed linear-memory space.

##### Loading

For a load access, a value is read from the [accessed bytes], in
[little-endian byte order], and returned.

##### Storing

For a store access, the value to store is written to the [accessed bytes], in
[little-endian byte order].

> If any of the bytes are out of bounds, the Out Of Bounds trap is triggered
before any of the bytes are written to.

##### Linear-Memory Access Validation

 - `$align` is required to be a [power of 2].
 - `$align` is required to be at most the number of [accessed bytes].
 - The module is required to contain a default linear-memory space.

TODO: Will offsets be encoded as signed? Monitor
https://github.com/WebAssembly/design/issues/584

TODO: Should linear-memory accesses have a linear-memory-space immediate?

[power of 2]: https://en.wikipedia.org/wiki/Power_of_two

#### R: Linear-Memory Size Instruction Family

##### Linear-Memory Size Validation

 - The module is required to contain a default linear-memory space.

TODO: Should linear-memory size instructions have a linear-memory-space
immediate?

### Instruction Opcode Field

These values are used in the [binary format](#binary-format) to encode
instruction [opcodes].

[opcodes]: https://en.wikipedia.org/wiki/Opcode

### Instruction Syntax Field

TODO: These are suggested operator names for use in the [text format]. A
parenthesized number is given for each operator name giving a suggested operator
[precedence] value when binary operators use infix notation and unary operators
use prefix notation.

[precedence]: https://en.wikipedia.org/wiki/Order_of_operations

### Instruction Description

Instruction semantics are described for use in the context of
[function body execution](#function-body-execution). Some instructions also have
a special validation clause, introduced by "**Validation:**", which are for use
in the context of [function body validation](#function-body-validation), and
special validation algorithm clauses, introduced by "**Validation Algorithm:**",
for use by the [function body validation algorithm].

[function body validation algorithm]: #function-body-validation-algorithm


Instructions
--------------------------------------------------------------------------------

0. [Control Flow Instructions](#control-flow-instructions)
0. [Basic Instructions](#basic-instructions)
0. [Integer Arithmetic Instructions](#integer-arithmetic-instructions)
0. [Floating-Point Arithmetic Instructions](#floating-point-arithmetic-instructions)
0. [Integer Comparison Instructions](#integer-comparison-instructions)
0. [Floating-Point Comparison Instructions](#floating-point-comparison-instructions)
0. [Conversion Instructions](#conversion-instructions)
0. [Load And Store Instructions](#load-and-store-instructions)
0. [Additional Memory-Related Instructions](#additional-memory-related-instructions)

### Control Flow Instructions

0. [Block](#block)
0. [Loop](#loop)
0. [Unconditional Branch](#unconditional-branch)
0. [Conditional Branch](#conditional-branch)
0. [Table Branch](#table-branch)
0. [If](#if)
0. [Else](#else)
0. [End](#end)
0. [Return](#return)
0. [Unreachable](#unreachable)

#### Block

| Mnemonic    | Signature                   | Families | Opcode |
| ----------- | --------------------------- | -------- | ------ |
| `block`     | `() : ()`                   |          | 0x01   |

The `block` instruction pushes an unbound [label] onto the control-flow stack.

**Validation Algorithm:**
 - An entry is pushed onto the control-flow stack containing no type sequence,
   and a limit value of the current length of the type stack.

> Each `block` needs a corresponding [`end`](#end) to pop its label from the
stack.

#### Loop

| Mnemonic    | Signature                   | Families | Opcode |
| ----------- | --------------------------- | -------- | ------ |
| `loop`      | `() : ()`                   |          | 0x02   |

The `loop` instruction binds a [label] to the current position and pushes it
onto the control-flow stack.

**Validation Algorithm:**
 - An entry is pushed onto the control-flow stack containing an empty type
   sequence, and a limit value of the current length of the type stack.

> The `loop` instruction does not perform a loop by itself. It merely introduces
a label that may be used by a branch to form an actual loop.

> Since `loop`'s control-flow stack entry starts with an empty type sequence,
branches to the top of the loop must not have any result values.

> Each `loop` needs a corresponding [`end`](#end) to pop its label from the
stack.

> There is no requirement that loops eventually terminate or contain observable
side effects.

TODO: Does loop have an exit label? Monitor
https://github.com/WebAssembly/design/pull/710

#### Unconditional Branch

| Mnemonic    | Immediates                 | Signature                     | Families | Opcode |
| ----------- | -------------------------- | ----------------------------- | -------- | ------ |
| `br`        | `$arity: i32, $depth: i32` | `($T[$arity]) : ($T[$arity])` | [B] [Q]  | 0x06   |

The `br` instruction [branches](#branching) according to the control flow stack
entry `$depth` from the top. It returns the values of its operands.

**Validation:**
 - `$arity` is required to be at most 1.

**Validation Algorithm:**
 - The operand sequence is [merged] into the control-flow stack entry `$depth`
   from the top.

TODO: This anticipates a proposal to make `br`, `br_table`, `return`, and
`unreachable` return "void" rather than "any".

#### Conditional Branch

| Mnemonic    | Immediates                 | Signature                                      | Families | Opcode |
| ----------- | -------------------------- | ---------------------------------------------- | -------- | ------ |
| `br_if`     | `$arity: i32, $depth: i32` | `($T[$arity], $condition: i32) : ($T[$arity])` | [B]      | 0x07   |

If `$condition` is [true], the `br_if` instruction [branches](#branching)
according to the control flow stack entry `$depth` from the top. Otherwise, it
does nothing. It returns the values of its operands, except `$condition`.

**Validation:**
 - `$arity` is required to be at most 0.

**Validation Algorithm:**
 - The sequence of the all but the last type in the operand sequence is [merged]
   into the control-flow stack entry `$depth` from the top.

> This instruction's `$arity` has a different constraint than others; this is
intentional and possibly temporary.

TODO: Will `br_if`'s `$arity` be changed? Monitor
https://github.com/WebAssembly/design/pull/709

#### Table Branch

| Mnemonic    | Immediates                          | Signature                                  | Families | Opcode |
| ----------- | ----------------------------------- | ------------------------------------------ | -------- | ------ |
| `br_table`  | `$arity: i32, TABLE, $default: i32` | `($T[$arity], $index: i32) : ($T[$arity])` | [B] [Q]  | 0x08   |

First, the `br_table` instruction selects a depth to use. If `$index` is within
the bounds of the table, the depth is the value of the indexed table element.
Otherwise, the depth is `$default`.

Then, it [branches](#branching) according to the control-flow stack entry that
depth from the top. It returns the values of its operands, except `$index`.

**Validation:**
 - `$arity` is required to be at most 1.

**Validation Algorithm:**
 - For each depth in the table and `$default`, the sequence of all but the last
   type in the operand sequence is [merged] into the control-flow stack entry
   that depth from the top.

> This instruction serves the role of what is sometimes called a ["jump table"]
in other languages. "Branch" is used here instead to emphasize the commonality
with the other branch instructions.

["jump table"]: https://en.wikipedia.org/w/index.php?title=Jump_table

#### If

| Mnemonic    | Signature                   | Families | Opcode |
| ----------- | --------------------------- | -------- | ------ |
| `if`        | `($condition: i32) : ()`    | [B]      | 0x03   |

The `if` instruction pushes an unbound [label] onto the control-flow stack. If
`$condition` is [false], it then [branches](#branching) to this label.

**Validation Algorithm:**
 - An entry is pushed onto the control-flow stack containing no type sequence,
   and a limit value of the current length of the type stack.

TODO: Do `if` and `else` have labels? Monitor at least
https://github.com/WebAssembly/design/pull/710

> Each `if` needs either a corresponding [`else`](#else) or [`end`](#end).

#### Else

| Mnemonic    | Signature                     | Families | Opcode |
| ----------- | ----------------------------- | -------- | ------ |
| `else`      | `($T[$any]) : ($T[$any])`     | [B]      | 0x04   |

The `else` instruction binds the control-flow stack top's [label] to the current
position, pops an entry from the control-flow stack, pushes a new unbound
[label] onto the control-flow stack, and then [branches](#branching) to the new
label. It returns the values of its operands.

**Validation Algorithm:**
 - The operand sequence is [merged] into the control-flow stack entry `$depth`
   from the top.
 - An entry is popped off the control-flow stack.
 - A new entry is pushed onto the control-flow stack containing the operand
   sequence as its type sequence, and a limit value of the current length of the
   type stack.

> Each `else` needs a corresponding [`end`](#end).

#### End

| Mnemonic    | Signature                     | Families | Opcode |
| ----------- | ----------------------------- | -------- | ------ |
| `end`       | `($T[$any]) : ($T[$any])`     |          | 0x0f   |

The `end` instruction pops an entry from the control-flow stack. If the entry's
[label] is unbound, the label is bound to the current position. It returns the
values of its operands.

**Validation:**
 - `$any` is required to be at most 1.

**Validation Algorithm:**
 - The operand sequence is [merged] into the control-flow stack top.
 - The control-flow stack top entry is popped.

> Each `end` ends a region begun by a corresponding `block`, `loop`, `if`,
`else`, or the function entry.

#### Return

| Mnemonic    | Immediates    | Signature                     | Families | Opcode |
| ----------- | ------------- | ----------------------------- | -------- | ------ |
| `return`    | `$arity: i32` | `($T[$arity]) : ($T[$arity])` | [B] [Q]  | 0x09   |

The `return` instruction [branches](#branching) according to the control-flow
stack bottom. It returns the values of its operands.

**Validation:**
 - `$arity` is required to be at most 1.

**Validation Algorithm:**
 - The operand sequence is [merged] into the control-flow stack bottom.

> `return` is semantically equivalent to a `br` to the outermost control region.

> Implementations needn't literally perform a branch before performing the
actual function return.

#### Unreachable

| Mnemonic      | Signature                 | Families | Opcode |
| ------------- | ------------------------- | -------- | ------ |
| `unreachable` | `() : ()`                 | [Q]      | 0x0a   |

**Trap:** Unreachable reached, always.

> The `unreachable` instruction is meant to represent code that isn't meant to
be executed except in the case of a bug in the application.

### Basic Instructions

0. [Nop](#nop)
0. [Drop](#drop)
0. [Constant](#constant)
0. [Get Local](#get-local)
0. [Set Local](#set-local)
0. [Tee Local](#tee-local)
0. [Get Global](#get-global)
0. [Set Global](#set-global)
0. [Select](#select)
0. [Call](#call)
0. [Indirect Call](#indirect-call)

#### Nop

| Mnemonic    | Signature                   | Families | Opcode |
| ----------- | --------------------------- | -------- | ------ |
| `nop`       | `() : ()`                   |          | 0x00   |

The `nop` instruction does nothing.

#### Drop

| Mnemonic    | Signature                    | Families | Opcode |
| ----------- | ---------------------------- | -------- | ------ |
| `drop`      | `($T[1]) : ()`               |          | 0x0b   |

The `drop` instruction does nothing.

> This differs from `nop` in that it has an operand, so it can be used to
discard unneeded values from the value stack.

#### Constant

| Mnemonic    | Immediates    | Signature    | Families | Opcode |
| ----------- | ------------- | ------------ | -------- | ------ |
| `i32.const` | `$value: i32` | `() : (i32)` |          | 0x10   |
| `i64.const` | `$value: i64` | `() : (i64)` |          | 0x11   |
| `f32.const` | `$value: f32` | `() : (f32)` |          | 0x12   |
| `f64.const` | `$value: f64` | `() : (f64)` |          | 0x13   |

The `const` instruction returns the value of `$value`.

> Floating-point constants can be created with arbitrary bit-patterns.

TODO: This anticipates sanitizing `f32.const`'s opcode. Monitor
https://github.com/WebAssembly/design/pull/696

#### Get Local

| Mnemonic    | Immediates | Signature      | Families | Opcode |
| ----------- | ---------- | -------------- | -------- | ------ |
| `get_local` | `$id: i32` | `() : ($T[1])` |          | 0x14   |

The `get_local` instruction returns the value of the local at index `$id` in the
locals array. The type parameter is bound to the type of the local.

**Validation:**
 - `$id` is required to be within the bounds of the locals array.

#### Set Local

| Mnemonic    | Immediates | Signature      | Families | Opcode |
| ----------- | ---------- | -------------- | -------- | ------ |
| `set_local` | `$id: i32` | `($T[1]) : ()` |          | 0x15   |

The `set_local` instruction sets the value of the local at index `$id` in the
locals array to the value given in the operand. The type parameter is bound to
the type of the local.

**Validation:**
 - `$id` is required to be within the bounds of the locals array.

> `set_local` is semantically equivalent to a similar `tee_local` followed by a
`drop`.

#### Tee Local

| Mnemonic    | Immediates | Signature           | Families | Opcode |
| ----------- | ---------- | ------------------- | -------- | ------ |
| `tee_local` | `$id: i32` | `($T[1]) : ($T[1])` |          | 0x19   |

The `tee_local` instruction sets the value of the locals at index `$id` in the
locals array to the value given in the operand. Its return value is the value of
its operand. The type parameter is bound to the type of the local.

**Validation:**
 - `$id` is required to be within the bounds of the locals array.

> This instruction's name is inspired by the ["tee" command] in other languages,
since it forwards the value of its operand to two places, the local and the
return value.

["tee" command]: https://en.wikipedia.org/wiki/Tee_(command)

#### Get Global

| Mnemonic     | Immediates | Signature      | Families | Opcode |
| ------------ | ---------- | -------------- | -------- | ------ |
| `get_global` | `$id: i32` | `() : ($T[1])` |          | TODO   |

The `get_global` instruction returns the value of the global identified by index
`$id` in the [global index space]. The type parameter is bound to the type of
the global.

**Validation:**
 - `$id` is required to be within the bounds of the global index space.

#### Set Global

| Mnemonic     | Immediates | Signature      | Families | Opcode |
| ------------ | ---------- | -------------- | -------- | ------ |
| `set_global` | `$id: i32` | `($T[1]) : ()` |          | TODO   |

The `set_global` instruction sets the value of the global identified by index
`$id` in the [global index space] to the value given in the operand. The type
parameter is bound to the type of the global.

**Validation:**
 - `$id` is required to be within the bounds of the global index space.
 - The indexed global is required to be declared not immutable.

#### Select

| Mnemonic    | Signature                                   | Families | Opcode |
| ----------- | ------------------------------------------- | -------- | ------ |
| `select`    | `($T[1], $T[1], $condition: i32) : ($T[1])` |          | 0x16   |

The `select` instruction returns its first operand if `$condition` is [true], or
its second operand otherwise.

> This instruction differs from the conditional or ternary operator, eg.
`x?y:z`, in some languages, in that it's not short-circuiting.

TODO: This anticipates sanitizing `select`'s opcode. Monitor
https://github.com/WebAssembly/design/pull/695

#### Call

| Mnemonic    | Immediates                  | Signature                      | Families | Opcode |
| ----------- | --------------------------- | ------------------------------ | -------- | ------ |
| `call`      | `$arity: i32, $callee: i32` | `($T[$args]) : ($T[$returns])` | [L]      | 0x17   |

The `call` instruction performs a [call](#calling) to the function with index
`$callee` in the [function index space].

**Validation:**
 - `$callee` is required to be within the bounds of the function index space.
 - [Call validation](#call-validation) is required; the callee signature is the
   signature of the indexed function.

TODO: This anticipates sanitizing `select`'s opcode. Monitor
https://github.com/WebAssembly/design/pull/695

#### Indirect Call

| Mnemonic        | Immediates                     | Signature                                    | Families | Opcode |
| --------------- | ------------------------------ | -------------------------------------------- | -------- | ------ |
| `call_indirect` | `$arity: i32, $signature: i32` | `($callee: i32, $T[$args]) : ($T[$returns])` | [L]      | 0x18   |

The `call_indirect` instruction performs a [call](#calling) to the function in
the default table with index `$callee`.

**Trap:** Indirect Callee Absent, if the indexed table element is the special
"null" value.

**Trap:** Indirect Call Type Mismatch, if the signature of the function with
index `$callee` differs from the signature in the [Type Section] with index
`$signature`.

**Validation:**
 - [Call validation](#call-validation) is required; the callee signature is the
   signature with index `$signature` in the [Type Section].

> The dynamic caller/callee signature match is structural rather than nominal.

> Indices in the default table can provide applications with the functionality
of function pointers.

TODO: This anticipates sanitizing `select`'s opcode. Monitor
https://github.com/WebAssembly/design/pull/695

### Integer Arithmetic Instructions

0. [Integer Add](#integer-add)
0. [Integer Subtract](#integer-subtract)
0. [Integer Multiply](#integer-multiply)
0. [Integer Divide, Signed](#integer-divide-signed)
0. [Integer Divide, Unsigned](#integer-divide-unsigned)
0. [Integer Remainder, Signed](#integer-remainder-signed)
0. [Integer Remainder, Unsigned](#integer-remainder-unsigned)
0. [Integer Bitwise And](#integer-bitwise-and)
0. [Integer Bitwise Or](#integer-bitwise-or)
0. [Integer Bitwise Exclusive-Or](#integer-exclusive-bitwise-or)
0. [Integer Shift Left](#integer-shift-left)
0. [Integer Shift Right, Signed](#integer-shift-right-signed)
0. [Integer Shift Right, Unsigned](#integer-shift-right-unsigned)
0. [Integer Rotate Left](#integer-rotate-left)
0. [Integer Rotate Right](#integer-rotate-right)
0. [Integer Count Leading Zeros](#integer-count-leading-zeros)
0. [Integer Count Trailing Zeros](#integer-count-trailing-zeros)
0. [Integer Population Count](#integer-population-count)
0. [Integer Equal To Zero](#integer-equal-to-zero)

#### Integer Add

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.add`   | `(i32, i32) : (i32)`        | [G]      | 0x40   | `+` (13)    |
| `i64.add`   | `(i64, i64) : (i64)`        | [G]      | 0x5b   | `+` (13)    |

The integer `add` instruction returns the [two's complement sum] of its
operands. The carry bit is silently discarded.

> Due to WebAssembly's use of [two's complement] to represent signed values,
this instruction can be used to add either signed or unsigned values.

#### Integer Subtract

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.sub`   | `(i32, i32) : (i32)`        | [G]      | 0x41   | `-` (13)    |
| `i64.sub`   | `(i64, i64) : (i64)`        | [G]      | 0x5c   | `-` (13)    |

The integer `sub` instruction returns the [two's complement difference] of its
operands. The borrow bit is silently discarded.

> Due to WebAssembly's use of [two's complement] to represent signed values,
this instruction can be used to subtract either signed or unsigned values.

> An integer negate operation can be performed by a `sub` instruction with zero
as the first operand.

#### Integer Multiply

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.mul`   | `(i32, i32) : (i32)`        | [G]      | 0x42   | `*` (14)    |
| `i64.mul`   | `(i64, i64) : (i64)`        | [G]      | 0x5d   | `*` (14)    |

The integer `mul` instruction returns the low half of the
[two's complement product] its operands.

> Due to WebAssembly's use of [two's complement] to represent signed values,
this instruction can be used to multiply either signed or unsigned values.

#### Integer Divide, Signed

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.div_s` | `(i32, i32) : (i32)`        | [S]      | 0x43   | `/s` (14)   |
| `i64.div_s` | `(i64, i64) : (i64)`        | [S]      | 0x5e   | `/s` (14)   |

The `div_s` instruction returns the signed quotient of its operands, interpreted
as signed. The quotient is silently rounded to the nearest integer toward zero.

**Trap:** Signed Integer Overflow, when the [minimum signed integer value] is
divided by `-1`.

**Trap:** Integer Division By Zero, when the second operand (the divisor) is
zero.

#### Integer Divide, Unsigned

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.div_u` | `(i32, i32) : (i32)`        | [U]      | 0x44   | `/u` (14)   |
| `i64.div_u` | `(i64, i64) : (i64)`        | [U]      | 0x5f   | `/u` (14)   |

The `div_u` instruction returns the unsigned quotient of its operands,
interpreted as unsigned. The quotient is silently rounded to the nearest integer
toward zero.

**Trap:** Integer Division By Zero, when the second operand (the divisor) is
zero.

#### Integer Remainder, Signed

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.rem_s` | `(i32, i32) : (i32)`        | [S]      | 0x45   | `%s` (14)   |
| `i64.rem_s` | `(i64, i64) : (i64)`        | [S]      | 0x60   | `%s` (14)   |

The `rem_s` instruction returns the signed remainder from a division of its
operand values interpreted as signed, with the result having the same sign as
the first operand (the dividend).

**Trap:** Integer Division By Zero, when the second operand (the divisor) is
zero.

> This instruction doesn't trap when the [minimum signed integer value] is
divided by `-1`; it returns `0` which is the correct remainder (even though the
same operands to `div_s` do cause a trap).

> This instruction differs from what is often called a ["modulo" operation] in
its handling of negative numbers.

> This instruction has some [common pitfalls] to avoid.

["modulo" operation]: https://en.wikipedia.org/wiki/Modulo_operation
[common pitfalls]: https://en.wikipedia.org/wiki/Modulo_operation#Common_pitfalls

#### Integer Remainder, Unsigned

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.rem_u` | `(i32, i32) : (i32)`        | [U]      | 0x46   | `%u` (14)   |
| `i64.rem_u` | `(i64, i64) : (i64)`        | [U]      | 0x61   | `%u` (14)   |

The `rem_u` instruction returns the unsigned remainder from a division of its
operand values interpreted as unsigned.

**Trap:** Integer Division By Zero, when the second operand (the divisor) is
zero.

> This instruction corresponds to what is sometimes called "modulo" in other
languages.

#### Integer Bitwise And

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.and`   | `(i32, i32) : (i32)`        | [G]      | 0x47   | `&` (9)     |
| `i64.and`   | `(i64, i64) : (i64)`        | [G]      | 0x62   | `&` (9)     |

The `and` instruction returns the [bitwise and] of its operands.

[bitwise and]: https://en.wikipedia.org/wiki/Bitwise_operation#AND

#### Integer Bitwise Or

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.or`    | `(i32, i32) : (i32)`        | [G]      | 0x48   | `|` (7)     |
| `i64.or`    | `(i64, i64) : (i64)`        | [G]      | 0x63   | `|` (7)     |

The `or` instruction returns the [bitwise inclusive-or] of its operands.

[bitwise inclusive-or]: https://en.wikipedia.org/wiki/Bitwise_operation#OR

#### Integer Bitwise Exclusive-Or

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.xor`   | `(i32, i32) : (i32)`        | [G]      | 0x49   | `^` (8)     |
| `i64.xor`   | `(i64, i64) : (i64)`        | [G]      | 0x64   | `^` (8)     |

The `xor` instruction returns the [bitwise exclusive-or] of its operands.

> A [bitwise negate] operation can be performed by a `xor` instruction with
negative one as the first operand, an operation sometimes called
"one's complement" in other languages.

[bitwise exclusive-or]: https://en.wikipedia.org/wiki/Bitwise_operation#XOR
[bitwise negate]: https://en.wikipedia.org/wiki/Bitwise_operation#NOT

#### Integer Shift Left

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.shl`   | `(i32, i32) : (i32)`        | [T], [G] | 0x4a   | `<<` (12)   |
| `i64.shl`   | `(i64, i64) : (i64)`        | [T], [G] | 0x65   | `<<` (12)   |

The `shl` instruction returns the value of the first operand [shifted] to the
left by the [shift count].

> This instruction effectively performs a multiplication by two to the power of
the shift count.

#### Integer Shift Right, Signed

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.shr_s` | `(i32, i32) : (i32)`        | [T], [S] | 0x4c   | `>>s` (12)  |
| `i64.shr_s` | `(i64, i64) : (i64)`        | [T], [S] | 0x67   | `>>s` (12)  |

The `shr_s` instruction returns the value of the first operand
[shifted](https://en.wikipedia.org/wiki/Arithmetic_shift) to the right by the
[shift count].

> This instruction corresponds to what is sometimes called
"arithmetic right shift" in other languages.

> `shr_s` is similar to `div_s` when the divisor is a power of two, however the
rounding of negative values is different. `shr_s` effectively rounds down, while
`div_s` rounds toward zero.

#### Integer Shift Right, Unsigned

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.shr_u` | `(i32, i32) : (i32)`        | [T], [U] | 0x4b   | `>>u` (12)  |
| `i64.shr_u` | `(i64, i64) : (i64)`        | [T], [U] | 0x66   | `>>u` (12)  |

The `shr_u` instruction returns the value of the first operand [shifted] to the
right by the [shift count].

> This instruction corresponds to what is sometimes called
"logical right shift" in other languages.

> This instruction effectively performs an unsigned division by two to the power
of the shift count.

#### Integer Rotate Left

| Mnemonic    | Signature                   | Families | Opcode |
| ----------- | --------------------------- | -------- | ------ |
| `i32.rotl`  | `(i32, i32) : (i32)`        | [T], [G] | 0xb7   |
| `i64.rotl`  | `(i64, i64) : (i64)`        | [T], [G] | 0xb9   |

The `rotl` instruction returns the value of the first operand [rotated] to the
left by the [shift count].

> Rotating left is similar to shifting left, however vacated bits are set to the
values of the bits which would otherwise be discarded by the shift, so the bits
conceptually "rotate back around".

#### Integer Rotate Right

| Mnemonic    | Signature                   | Families | Opcode |
| ----------- | --------------------------- | -------- | ------ |
| `i32.rotr`  | `(i32, i32) : (i32)`        | [T], [G] | 0xb6   |
| `i64.rotr`  | `(i64, i64) : (i64)`        | [T], [G] | 0xb8   |

The `rotr` instruction returns the value of the first operand [rotated] to the
right by the [shift count].

> Rotating right is similar to shifting right, however vacated bits are set to
the values of the bits which would otherwise be discarded by the shift, so the
bits conceptually "rotate back around".

#### Integer Count Leading Zeros

| Mnemonic    | Signature                   | Families | Opcode |
| ----------- | --------------------------- | -------- | ------ |
| `i32.clz`   | `(i32) : (i32)`             | [G]      | 0x57   |
| `i64.clz`   | `(i64) : (i64)`             | [G]      | 0x72   |

The `clz` instruction returns the number of leading zeros in its operand. The
*leading zeros* are the longest contiguous sequence of zero-bits starting at the
most significant bit and extending downward.

> This instruction is fully defined when all bits are zero; it returns the
number of bits in the operand type.

#### Integer Count Trailing Zeros

| Mnemonic    | Signature                   | Families | Opcode |
| ----------- | --------------------------- | -------- | ------ |
| `i32.ctz`   | `(i32) : (i32)`             | [G]      | 0x58   |
| `i64.ctz`   | `(i64) : (i64)`             | [G]      | 0x73   |

The `ctz` instruction returns the number of trailing zeros in its operand. The
*trailing zeros* are the longest contiguous sequence of zero-bits starting at
the least significant bit and extending upward.

> This instruction is fully defined when all bits are zero; it returns the
number of bits in the operand type.

#### Integer Population Count

| Mnemonic     | Signature                  | Families | Opcode |
| ------------ | -------------------------- | -------- | ------ |
| `i32.popcnt` | `(i32) : (i32)`            | [G]      | 0x59   |
| `i64.popcnt` | `(i64) : (i64)`            | [G]      | 0x74   |

The `popcnt` instruction returns the number of 1-bits in its operand.

> This instruction is fully defined when all bits are zero; it returns `0`.

> This instruction corresponds to what is sometimes called a ["hamming weight"]
in other languages.

["hamming weight"]: https://en.wikipedia.org/wiki/Hamming_weight

#### Integer Equal To Zero

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.eqz`   | `(i32) : (i32)`             | [G]      | 0x5a   | `!` (15)    |
| `i64.eqz`   | `(i64) : (i32)`             | [G]      | 0xba   | `!` (15)    |

The `eqz` instruction returns [true] if the operand is equal to zero, or [false]
otherwise.

> This serves as a form of "logical not" operation which can be used to invert
[boolean] values.

### Floating-Point Arithmetic Instructions

0. [Floating-Point Add](#floating-point-add)
0. [Floating-Point Subtract](#floating-point-subtract)
0. [Floating-Point Multiply](#floating-point-multiply)
0. [Floating-Point Divide](#floating-point-divide)
0. [Floating-Point Square Root](#floating-point-square-root)
0. [Floating-Point Minimum](#floating-point-minimum)
0. [Floating-Point Maximum](#floating-point-maximum)
0. [Floating-Point Ceiling](#floating-point-ceiling)
0. [Floating-Point Floor](#floating-point-floor)
0. [Floating-Point Truncate](#floating-point-truncate)
0. [Floating-Point Nearest Integer](#floating-point-nearest-integer)
0. [Floating-Point Absolute Value](#floating-point-absolute-value)
0. [Floating-Point Negate](#floating-point-negate)
0. [Floating-Point CopySign](#floating-point-copysign)

#### Floating-Point Add

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `f32.add`   | `(f32, f32) : (f32)`        | [F]      | 0x75   | `+` (13)    |
| `f64.add`   | `(f64, f64) : (f64)`        | [F]      | 0x89   | `+` (13)    |

The floating-point `add` instruction performs the IEEE 754-2008 `addition`
operation according to the [general floating-point rules][F].

#### Floating-Point Subtract

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `f32.sub`   | `(f32, f32) : (f32)`        | [F]      | 0x76   | `-` (13)    |
| `f64.sub`   | `(f64, f64) : (f64)`        | [F]      | 0x8a   | `-` (13)    |

The floating-point `sub` instruction performs the IEEE 754-2008 `subtraction`
operation according to the [general floating-point rules][F].

#### Floating-Point Multiply

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `f32.mul`   | `(f32, f32) : (f32)`        | [F]      | 0x77   | `*` (14)    |
| `f64.mul`   | `(f64, f64) : (f64)`        | [F]      | 0x8b   | `*` (14)    |

The floating-point `mul` instruction performs the IEEE 754-2008 `multiplication`
operation according to the [general floating-point rules][F].

#### Floating-Point Divide

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `f32.div`   | `(f32, f32) : (f32)`        | [F]      | 0x78   | `/` (14)    |
| `f64.div`   | `(f64, f64) : (f64)`        | [F]      | 0x8c   | `/` (14)    |

The `div` instruction performs the IEEE 754-2008 `division` operation according
to the [general floating-point rules][F].

#### Floating-Point Square Root

| Mnemonic    | Signature                   | Families | Opcode |
| ----------- | --------------------------- | -------- | ------ |
| `f32.sqrt`  | `(f32) : (f32)`             | [F]      | 0x82   |
| `f64.sqrt`  | `(f64) : (f64)`             | [F]      | 0x96   |

The `sqrt` instruction performs the IEEE 754-2008 `squareRoot` operation
according to the [general floating-point rules][F].

#### Floating-Point Minimum

| Mnemonic    | Signature                   | Families | Opcode |
| ----------- | --------------------------- | -------- | ------ |
| `f32.min`   | `(f32, f32) : (f32)`        | [F]      | 0x79   |
| `f64.min`   | `(f64, f64) : (f64)`        | [F]      | 0x8d   |

The `min` instruction returns the minimum value among its operands. For this
instruction, negative zero is considered less than zero. If either operand is a
NaN, the result is a NaN determined by the [general floating-point rules][F].

> This differs from the IEEE 754-2008 `minNum` operation in that it returns a
NaN if either operand is a NaN, and in that the behavior when the operands are
zeros of differing signs is fully specified.

> This differs from the common `x<y?x:y` expansion in its handling of
negative zero and NaN values.

#### Floating-Point Maximum

| Mnemonic    | Signature                   | Families | Opcode |
| ----------- | --------------------------- | -------- | ------ |
| `f32.max`   | `(f32, f32) : (f32)`        | [F]      | 0x7a   |
| `f64.max`   | `(f64, f64) : (f64)`        | [F]      | 0x8e   |

The `max` instruction returns the maximum value among its operands. For this
instruction, negative zero is considered less than zero. If either operand is a
NaN, the result is a NaN determined by the [general floating-point rules][F].

> This differs from the IEEE 754-2008 `maxNum` operation in that it returns a
NaN if either operand is a NaN, and in that the behavior when the operands are
zeros of differing signs is fully specified.

> This differs from the common `x>y?x:y` expansion in its handling of negative
zero and NaN values.

#### Floating-Point Ceiling

| Mnemonic    | Signature                   | Families | Opcode |
| ----------- | --------------------------- | -------- | ------ |
| `f32.ceil`  | `(f32) : (f32)`             | [F]      | 0x7e   |
| `f64.ceil`  | `(f64) : (f64)`             | [F]      | 0x92   |

The `ceil` instruction performs the IEEE 754-2008
`roundToIntegralTowardPositive` operation according to the
[general floating-point rules][F].

> ["Ceiling"][Floor and Ceiling Functions] describes the rounding method used
here; the value is rounded up to the nearest integer.

#### Floating-Point Floor

| Mnemonic    | Signature                   | Families | Opcode |
| ----------- | --------------------------- | -------- | ------ |
| `f32.floor` | `(f32) : (f32)`             | [F]      | 0x7f   |
| `f64.floor` | `(f64) : (f64)`             | [F]      | 0x93   |

The `floor` instruction performs the IEEE 754-2008
`roundToIntegralTowardNegative` operation according to the
[general floating-point rules][F].

> ["Floor"][Floor and Ceiling Functions] describes the rounding method used
here; the value is rounded down to the nearest integer.

#### Floating-Point Truncate

| Mnemonic    | Signature                   | Families | Opcode |
| ----------- | --------------------------- | -------- | ------ |
| `f32.trunc` | `(f32) : (f32)`             | [F]      | 0x80   |
| `f64.trunc` | `(f64) : (f64)`             | [F]      | 0x94   |

The `trunc` instruction performs the IEEE 754-2008
`roundToIntegralTowardZero` operation according to the
[general floating-point rules][F].

> ["Truncate"] describes the rounding method used here; the fractional part of
the value is discarded, effectively rounding to the nearest integer toward zero.

["Truncate"]: https://en.wikipedia.org/wiki/Truncation

#### Floating-Point Nearest Integer

| Mnemonic      | Signature                 | Families | Opcode |
| ------------- | ------------------------- | -------- | ------ |
| `f32.nearest` | `(f32) : (f32)`           | [F]      | 0x81   |
| `f64.nearest` | `(f64) : (f64)`           | [F]      | 0x95   |

The `nearest` instruction performs the IEEE 754-2008
`roundToIntegralTiesToEven` operation according to the
[general floating-point rules][F].

> "Nearest" describes the rounding method used here; the value is
[rounded to the nearest integer], with
[ties rounded toward the value with an even least-significant digit].

> This instruction differs from [`Math.round` in ECMAScript] which rounds ties
up, and it differs from [`round` in C] which rounds ties away from zero.

[rounded to the nearest integer]: https://en.wikipedia.org/wiki/Nearest_integer_function
[ties rounded toward the value with an even least-significant digit]: https://en.wikipedia.org/wiki/Rounding#Round_half_to_even
[`Math.round` in ECMAScript]: https://tc39.github.io/ecma262/#sec-math.round
[`round` in C]: http://en.cppreference.com/w/c/numeric/math/round

#### Floating-Point Absolute Value

| Mnemonic    | Signature                   | Families | Opcode |
| ----------- | --------------------------- | -------- | ------ |
| `f32.abs`   | `(f32) : (f32)`             | [Z]      | 0x7b   |
| `f64.abs`   | `(f64) : (f64)`             | [Z]      | 0x8f   |

The `abs` instruction performs the IEEE 754-2008 `abs` operation.

> This is a bitwise instruction; it sets the sign bit to zero and preserves all
other bits, even when the operand is a NaN or a zero.

> This differs from comparing whether the operand value is less than zero and
negating it, because comparisons treat negative zero as equal to zero, and NaN
values as not less than zero.

#### Floating-Point Negate

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `f32.neg`   | `(f32) : (f32)`             | [Z]      | 0x7c   | `-` (15)    |
| `f64.neg`   | `(f64) : (f64)`             | [Z]      | 0x90   | `-` (15)    |

The `neg` instruction performs the IEEE 754-2008 `negate` operation.

> This is a bitwise instruction; it inverts the sign bit and preserves all other
bits, even when the operand is a NaN or a zero.

> This differs from subtracting the operand value from negative zero or
multiplying it by negative one, because subtraction and multiplication follow
the [general floating-point rules][F] and may not preserve the bits of NaN
values.

#### Floating-Point CopySign

| Mnemonic       | Signature                | Families | Opcode |
| -------------- | ------------------------ | -------- | ------ |
| `f32.copysign` | `(f32, f32) : (f32)`     | [Z]      | 0x7d   |
| `f64.copysign` | `(f64, f64) : (f64)`     | [Z]      | 0x91   |

The `copysign` instruction performs the IEEE 754-2008 `copySign` operation.

> This is a bitwise instruction; it combines the sign bit from the second
operand with all bits other than the sign bit from the first operand, even if
either operand is a NaN or a zero.

### Integer Comparison Instructions

0. [Integer Equality](#integer-equality)
0. [Integer Inequality](#integer-inequality)
0. [Integer Less Than, Signed](#integer-less-than-signed)
0. [Integer Less Than, Unsigned](#integer-less-than-unsigned)
0. [Integer Less Than Or Equal To, Signed](#integer-less-than-or-equal-to-signed)
0. [Integer Less Than Or Equal To, Unsigned](#integer-less-than-or-equal-to-unsigned)
0. [Integer Greater Than, Signed](#integer-greater-than-signed)
0. [Integer Greater Than, Unsigned](#integer-greater-than-unsigned)
0. [Integer Greater Than Or Equal To, Signed](#integer-greater-than-or-equal-to-signed)
0. [Integer Greater Than Or Equal To, Unsigned](#integer-greater-than-or-equal-to-unsigned)

#### Integer Equality

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.eq`    | `(i32, i32) : (i32)`        | [C], [G] | 0x4d   | `==` (10)   |
| `i64.eq`    | `(i64, i64) : (i32)`        | [C], [G] | 0x68   | `==` (10)   |

The integer `eq` instruction tests whether the operands are equal.

#### Integer Inequality

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.ne`    | `(i32, i32) : (i32)`        | [C], [G] | 0x4e   | `!=` (10)   |
| `i64.ne`    | `(i64, i64) : (i32)`        | [C], [G] | 0x69   | `!=` (10)   |

The integer `ne` instruction tests whether the operands are not equal.

> This instruction corresponds to what is sometimes called "differs" in other
languages.

#### Integer Less Than, Signed

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.lt_s`  | `(i32, i32) : (i32)`        | [C], [S] | 0x4f   | `<s` (11)   |
| `i64.lt_s`  | `(i64, i64) : (i32)`        | [C], [S] | 0x6a   | `<s` (11)   |

The `lt_s` instruction tests whether the first operand is less than the second
operand, interpreting the operands as signed.

#### Integer Less Than, Unsigned

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.lt_u`  | `(i32, i32) : (i32)`        | [C], [U] | 0x51   | `<u` (11)   |
| `i64.lt_u`  | `(i64, i64) : (i32)`        | [C], [U] | 0x6c   | `<u` (11)   |

The `lt_u` instruction tests whether the first operand is less than the second
operand, interpreting the operands as unsigned.

#### Integer Less Than Or Equal To, Signed

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.le_s`  | `(i32, i32) : (i32)`        | [C], [S] | 0x50   | `<=s` (11)  |
| `i64.le_s`  | `(i64, i64) : (i32)`        | [C], [S] | 0x6b   | `<=s` (11)  |

The `le_s` instruction tests whether the first operand is less than or equal to
the second operand, interpreting the operands as signed.

> This instruction corresponds to what is sometimes called "at most" in other
languages.

#### Integer Less Than Or Equal To, Unsigned

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.le_u`  | `(i32, i32) : (i32)`        | [C], [U] | 0x52   | `<=u` (11)  |
| `i64.le_u`  | `(i64, i64) : (i32)`        | [C], [U] | 0x6d   | `<=u` (11)  |

The `le_u` instruction tests whether the first operand is less than or equal to
the second operand, interpreting the operands as unsigned.

> This instruction corresponds to what is sometimes called "at most" in other
languages.

#### Integer Greater Than, Signed

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.gt_s`  | `(i32, i32) : (i32)`        | [C], [S] | 0x53   | `>s` (11)   |
| `i64.gt_s`  | `(i64, i64) : (i32)`        | [C], [S] | 0x6e   | `>s` (11)   |

The `gt_s` instruction tests whether the first operand is greater than the
second operand, interpreting the operands as signed.

#### Integer Greater Than, Unsigned

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.gt_u`  | `(i32, i32) : (i32)`        | [C], [U] | 0x55   | `>u` (11)   |
| `i64.gt_u`  | `(i64, i64) : (i32)`        | [C], [U] | 0x70   | `>u` (11)   |

The `gt_u` instruction tests whether the first operand is greater than the
second operand, interpreting the operands as unsigned.

#### Integer Greater Than Or Equal To, Signed

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.ge_s`  | `(i32, i32) : (i32)`        | [C], [S] | 0x54   | `>=s` (11)  |
| `i64.ge_s`  | `(i64, i64) : (i32)`        | [C], [S] | 0x6f   | `>=s` (11)  |

The `ge_s` instruction tests whether the first operand is greater than or equal
to the second operand, interpreting the operands as signed.

> This instruction corresponds to what is sometimes called "at least" in other
languages.

#### Integer Greater Than Or Equal To, Unsigned

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `i32.ge_u`  | `(i32, i32) : (i32)`        | [C], [U] | 0x56   | `>=u` (11)  |
| `i64.ge_u`  | `(i64, i64) : (i32)`        | [C], [U] | 0x71   | `>=u` (11)  |

The `ge_u` instruction tests whether the first operand is greater than or equal
to the second operand, interpreting the operands as unsigned.

> This instruction corresponds to what is sometimes called "at least" in other
languages.

### Floating-Point Comparison Instructions

0. [Floating-Point Equality](#floating-point-equality)
0. [Floating-Point Inequality](#floating-point-inequality)
0. [Floating-Point Less Than](#floating-point-less-than)
0. [Floating-Point Less Than Or Equal To](#floating-point-less-than-or-equal-to)
0. [Floating-Point Greater Than](#floating-point-greater-than)
0. [Floating-Point Greater Than Or Equal To](#floating-point-greater-than-or-equal-to)

#### Floating-Point Equality

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `f32.eq`    | `(f32, f32) : (i32)`        | [C], [F] | 0x83   | `==` (10)   |
| `f64.eq`    | `(f64, f64) : (i32)`        | [C], [F] | 0x97   | `==` (10)   |

The floating-point `eq` instruction performs the IEEE 754-2008
`compareQuietEqual` operation according to the
[general floating-point rules][F].

#### Floating-Point Inequality

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `f32.ne`    | `(f32, f32) : (i32)`        | [C], [F] | 0x84   | `!=` (10)   |
| `f64.ne`    | `(f64, f64) : (i32)`        | [C], [F] | 0x98   | `!=` (10)   |

The floating-point `ne` instruction performs the IEEE 754-2008
`compareQuietNotEqual` operation according to the
[general floating-point rules][F].

> Unlike the other floating-point comparison instructions, this instruction
returns [true] if either operand is a NaN. It is the logical inverse of the `eq`
instruction.

#### Floating-Point Less Than

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `f32.lt`    | `(f32, f32) : (i32)`        | [C], [F] | 0x85   | `<` (11)    |
| `f64.lt`    | `(f64, f64) : (i32)`        | [C], [F] | 0x99   | `<` (11)    |

The `lt` instruction performs the IEEE 754-2008 `compareQuietLess` operation
according to the [general floating-point rules][F].

#### Floating-Point Less Than Or Equal To

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `f32.le`    | `(f32, f32) : (i32)`        | [C], [F] | 0x86   | `<=` (11)   |
| `f64.le`    | `(f64, f64) : (i32)`        | [C], [F] | 0x9a   | `<=` (11)   |

The `le` instruction performs the IEEE 754-2008 `compareQuietLessEqual`
operation according to the [general floating-point rules][F].

#### Floating-Point Greater Than

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `f32.gt`    | `(f32, f32) : (i32)`        | [C], [F] | 0x87   | `>` (11)    |
| `f64.gt`    | `(f64, f64) : (i32)`        | [C], [F] | 0x9b   | `>` (11)    |

The `gt` instruction performs the IEEE 754-2008 `compareQuietGreater` operation
according to the [general floating-point rules][F].

#### Floating-Point Greater Than Or Equal To

| Mnemonic    | Signature                   | Families | Opcode | Syntax      |
| ----------- | --------------------------- | -------- | ------ | ----------- |
| `f32.ge`    | `(f32, f32) : (i32)`        | [C], [F] | 0x88   | `>=` (11)   |
| `f64.ge`    | `(f64, f64) : (i32)`        | [C], [F] | 0x9c   | `>=` (11)   |

The `ge` instruction performs the IEEE 754-2008 `compareQuietGreaterEqual`
operation according to the [general floating-point rules][F].

### Conversion Instructions

0. [Integer Wrap](#integer-wrap)
0. [Integer Extend, Signed](#integer-extend-signed)
0. [Integer Extend, Unsigned](#integer-extend-unsigned)
0. [Truncate Floating-Point to Integer, Signed](#truncate-floating-point-to-integer-signed)
0. [Truncate Floating-Point to Integer, Unsigned](#truncate-floating-point-to-integer-unsigned)
0. [Floating-Point Demote](#floating-point demote)
0. [Floating-Point Promote](#floating-point promote)
0. [Convert Integer To Floating-Point, Signed](#convert-integer-to-floating-point-signed)
0. [Convert Integer To Floating-Point, Unsigned](#convert-integer-to-floating-point-unsigned)
0. [Reinterpret](#reinterpret)

#### Integer Wrap

| Mnemonic       | Signature                | Families | Opcode |
| -------------- | ------------------------ | -------- | ------ |
| `i32.wrap/i64` | `(i64) : (i32)`          | [G]      | 0xa1   |

The `wrap` instruction returns the value of its operand silently wrapped to its
result type. Wrapping means reducing the value modulo the number of unique
values in the result type.

> This instruction corresponds to what is sometimes called an integer "truncate"
in other languages, however WebAssembly uses the word "truncate" to mean
effectively discarding the least significant digits, and the word "wrap" to mean
effectively discarding the most significant digits.

#### Integer Extend, Signed

| Mnemonic           | Signature            | Families | Opcode |
| ------------------ | -------------------- | -------- | ------ |
| `i64.extend_s/i32` | `(i32) : (i64)`      | [S]      | 0xa6   |

The `extend_s` instruction returns the value of its operand [sign-extended] to
its result type.

#### Integer Extend, Unsigned

| Mnemonic           | Signature            | Families | Opcode |
| ------------------ | -------------------- | -------- | ------ |
| `i64.extend_u/i32` | `(i32) : (i64)`      | [U]      | 0xa7   |

The `extend_u` instruction returns the value of its operand zero-extended to its
result type.

#### Truncate Floating-Point to Integer, Signed

| Mnemonic          | Signature             | Families | Opcode |
| ----------------- | --------------------- | -------- | ------ |
| `i32.trunc_s/f32` | `(f32) : (i32)`       | [F], [S] | 0x9d   |
| `i32.trunc_s/f64` | `(f64) : (i32)`       | [F], [S] | 0x9e   |
| `i64.trunc_s/f32` | `(f32) : (i64)`       | [F], [S] | 0xa2   |
| `i64.trunc_s/f64` | `(f64) : (i64)`       | [F], [S] | 0xa3   |

The `trunc_s` instruction performs the IEEE 754-2008
`convertToIntegerTowardZero` operation, with the result value interpreted as
signed, according to the [general floating-point rules][F].

**Trap:** Invalid Conversion To Integer, when a floating-point Invalid condition
occurs, due to the operand being outside the range that can be converted
(including NaN values and infinities).

#### Truncate Floating-Point to Integer, Unsigned

| Mnemonic          | Signature             | Families | Opcode |
| ----------------- | --------------------- | -------- | ------ |
| `i32.trunc_u/f32` | `(f32) : (i32)`       | [F], [U] | 0x9f   |
| `i32.trunc_u/f64` | `(f64) : (i32)`       | [F], [U] | 0xa0   |
| `i64.trunc_u/f32` | `(f32) : (i64)`       | [F], [U] | 0xa4   |
| `i64.trunc_u/f64` | `(f64) : (i64)`       | [F], [U] | 0xa5   |

The `trunc_u` instruction performs the IEEE 754-2008
`convertToIntegerTowardZero` operation, with the result value interpreted as
unsigned, according to the [general floating-point rules][F].

**Trap:** Invalid Conversion To Integer, when an Invalid condition occurs, due
to the operand being outside the range that can be converted (including NaN
values and infinities).

> This instruction's result is unsigned, so it almost always rounds down,
however it does round up in one place: negative values greater than negative one
truncate up to zero.

#### Floating-Point Demote

| Mnemonic         | Signature              | Families | Opcode |
| ---------------- | ---------------------- | -------- | ------ |
| `f32.demote/f64` | `(f64) : (f32)`        | [F]      | 0xac   |

The `demote` instruction performs the IEEE 754-2008 `convertFormat` operation,
converting from its operand type to its result type, according to the
[general floating-point rules][F].

> This is a narrowing conversion which may round or overflow to infinity.

#### Floating-Point Promote

| Mnemonic          | Signature             | Families | Opcode |
| ----------------- | --------------------- | -------- | ------ |
| `f64.promote/f32` | `(f32) : (f64)`       | [F]      | 0xb2   |

The `promote` instruction performs the IEEE 754-2008 `convertFormat` operation,
converting from its operand type to its result type, according to the
[general floating-point rules][F].

> This is a widening conversion and is always exact.

#### Convert Integer To Floating-Point, Signed

| Mnemonic            | Signature           | Families | Opcode |
| ------------------- | ------------------- | -------- | ------ |
| `f32.convert_s/i32` | `(i32) : (f32)`     | [F], [S] | 0xa8   |
| `f32.convert_s/i64` | `(i64) : (f32)`     | [F], [S] | 0xaa   |
| `f64.convert_s/i32` | `(i32) : (f64)`     | [F], [S] | 0xae   |
| `f64.convert_s/i64` | `(i64) : (f64)`     | [F], [S] | 0xb0   |

The `convert_s` instruction performs the IEEE 754-2008 `convertFromInt`
operation, with its operand value interpreted as signed, according to the
[general floating-point rules][F].

> `f64.convert_s/i32` is always exact; the other instructions here may round.

#### Convert Integer To Floating-Point, Unsigned

| Mnemonic            | Signature           | Families | Opcode |
| ------------------- | ------------------- | -------- | ------ |
| `f32.convert_u/i32` | `(i32) : (f32)`     | [F], [U] | 0xa9   |
| `f32.convert_u/i64` | `(i64) : (f32)`     | [F], [U] | 0xab   |
| `f64.convert_u/i32` | `(i32) : (f64)`     | [F], [U] | 0xaf   |
| `f64.convert_u/i64` | `(i64) : (f64)`     | [F], [U] | 0xb1   |

The `convert_u` instruction performs the IEEE 754-2008 `convertFromInt`
operation, with its operand value interpreted as unsigned, according to the
[general floating-point rules][F].

> `f64.convert_u/i32` is always exact; the other instructions here may round.

#### Reinterpret

| Mnemonic              | Signature         | Families | Opcode |
| --------------------- | ----------------- | -------- | ------ |
| `i32.reinterpret/f32` | `(f32) : (i32)`   |          | 0xb4   |
| `i64.reinterpret/f64` | `(f64) : (i64)`   |          | 0xb5   |
| `f32.reinterpret/i32` | `(i32) : (f32)`   |          | 0xad   |
| `f64.reinterpret/i64` | `(i64) : (f64)`   |          | 0xb3   |

The `reinterpret` instruction returns a value which has the same bit-pattern as
its operand value, in its result type.

> The operand type is always the same width as the result type, so this
instruction is always exact.

### Load And Store Instructions

0. [Load](#load)
0. [Store](#store)
0. [Extending Load, Signed](#extending-load-signed)
0. [Extending Load, Unsigned](#extending-load-unsigned)
0. [Wrapping Store](#wrapping-store)

#### Load

| Mnemonic    | Immediates                    | Signature               | Families | Opcode |
| ----------- | ----------------------------- | ----------------------- | -------- | ------ |
| `i32.load`  | `$offset: iPTR, $align: iPTR` | `($base: iPTR) : (i32)` | [M], [G] | 0x2a   |
| `i64.load`  | `$offset: iPTR, $align: iPTR` | `($base: iPTR) : (i64)` | [M], [G] | 0x2b   |
| `f32.load`  | `$offset: iPTR, $align: iPTR` | `($base: iPTR) : (f32)` | [M], [Z] | 0x2c   |
| `f64.load`  | `$offset: iPTR, $align: iPTR` | `($base: iPTR) : (f64)` | [M], [Z] | 0x2d   |

The `load` instruction performs a [load](#loading) of the same size as its type.

Floating-point loads preserve all the bits of the value, performing an
IEEE 754-2008 `copy` operation.

**Validation:**
 - [Linear-memory access validation] is required.

#### Store

| Mnemonic    | Immediates                    | Signature                         | Families | Opcode |
| ----------- | ----------------------------- | --------------------------------- | -------- | ------ |
| `i32.store` | `$offset: iPTR, $align: iPTR` | `($base: iPTR, $value: i32) : ()` | [M], [G] | 0x33   |
| `i64.store` | `$offset: iPTR, $align: iPTR` | `($base: iPTR, $value: i64) : ()` | [M], [G] | 0x34   |
| `f32.store` | `$offset: iPTR, $align: iPTR` | `($base: iPTR, $value: f32) : ()` | [M], [F] | 0x35   |
| `f64.store` | `$offset: iPTR, $align: iPTR` | `($base: iPTR, $value: f64) : ()` | [M], [F] | 0x36   |

The `store` instruction performs a [store](#storing) of `$value` of the same
size as its type.

Floating-point stores preserve all the bits of the value, performing an
IEEE 754-2008 `copy` operation.

**Validation:**
 - [Linear-memory access validation] is required.

#### Extending Load, Signed

| Mnemonic       | Immediates                    | Signature               | Families | Opcode |
| -------------- | ----------------------------- | ----------------------- | -------- | ------ |
| `i32.load8_s`  | `$offset: iPTR, $align: iPTR` | `($base: iPTR) : (i32)` | [M], [S] | 0x20   |
| `i32.load16_s` | `$offset: iPTR, $align: iPTR` | `($base: iPTR) : (i32)` | [M], [S] | 0x22   |
|                |                               |                         |          |        |
| `i64.load8_s`  | `$offset: iPTR, $align: iPTR` | `($base: iPTR) : (i64)` | [M], [S] | 0x24   |
| `i64.load16_s` | `$offset: iPTR, $align: iPTR` | `($base: iPTR) : (i64)` | [M], [S] | 0x26   |
| `i64.load32_s` | `$offset: iPTR, $align: iPTR` | `($base: iPTR) : (i64)` | [M], [S] | 0x28   |

The signed extending load instructions perform a [load](#loading) of narrower
width than their type, and return the value [sign-extended] to their type.
 - `load8_s` loads an 8-bit value.
 - `load16_s` loads a 16-bit value.
 - `load32_s` loads a 32-bit value.

**Validation:**
 - [Linear-memory access validation] is required.

#### Extending Load, Unsigned

| Mnemonic       | Immediates                    | Signature               | Families | Opcode |
| -------------- | ----------------------------- | ----------------------- | -------- | ------ |
| `i32.load8_u`  | `$offset: iPTR, $align: iPTR` | `($base: iPTR) : (i32)` | [M], [U] | 0x21   |
| `i32.load16_u` | `$offset: iPTR, $align: iPTR` | `($base: iPTR) : (i32)` | [M], [U] | 0x23   |
|                |                               |                         |          |        |
| `i64.load8_u`  | `$offset: iPTR, $align: iPTR` | `($base: iPTR) : (i64)` | [M], [U] | 0x25   |
| `i64.load16_u` | `$offset: iPTR, $align: iPTR` | `($base: iPTR) : (i64)` | [M], [U] | 0x27   |
| `i64.load32_u` | `$offset: iPTR, $align: iPTR` | `($base: iPTR) : (i64)` | [M], [U] | 0x29   |

The unsigned extending load instructions perform a [load](#loading) of narrower
width than their type, and return the value zero-extended to their type.
 - `load8_u` loads an 8-bit value.
 - `load16_u` loads a 16-bit value.
 - `load32_u` loads a 32-bit value.

**Validation:**
 - [Linear-memory access validation] is required.

#### Wrapping Store

| Mnemonic      | Immediates                    | Signature                         | Families | Opcode |
| ------------- | ----------------------------- | --------------------------------- | -------- | ------ |
| `i32.store8`  | `$offset: iPTR, $align: iPTR` | `($base: iPTR, $value: i32) : ()` | [M], [G] | 0x2e   |
| `i32.store16` | `$offset: iPTR, $align: iPTR` | `($base: iPTR, $value: i32) : ()` | [M], [G] | 0x2f   |
|               |                               |                                   |          |        |
| `i64.store8`  | `$offset: iPTR, $align: iPTR` | `($base: iPTR, $value: i64) : ()` | [M], [G] | 0x30   |
| `i64.store16` | `$offset: iPTR, $align: iPTR` | `($base: iPTR, $value: i64) : ()` | [M], [G] | 0x31   |
| `i64.store32` | `$offset: iPTR, $align: iPTR` | `($base: iPTR, $value: i64) : ()` | [M], [G] | 0x32   |

The wrapping store instructions performs a [store](#storing) of `$value`
silently wrapped to a narrower width.
 - `store8` stores an 8-bit value.
 - `store16` stores a 16-bit value.
 - `store32` stores a 32-bit value.

**Validation:**
 - [Linear-memory access validation] is required.

> See the comment in the [wrap instruction](#integer-wrap) about the meaning of
the name "wrap".

### Additional Memory-Related Instructions

0. [Grow Linear-Memory Size](#grow-linear-memory-size)
0. [Current Linear-Memory Size](#current-linear-memory-size)

#### Grow Linear-Memory Size

| Mnemonic      | Signature                 | Families | Opcode |
| ------------- | ------------------------- | -------- | ------ |
| `grow_memory` | `(iPTR) : (iPTR)`         | [R]      | 0x39   |

The `grow_memory` instruction increases the size of the referenced linear-memory
space by a given unsigned amount, in units of [pages]. If the index of any byte
of the referenced linear-memory space would be unrepresentable in an unsigned
`iPTR`, or if allocation fails due to insufficient dynamic resources, or if the
referenced linear-memory space has a maximum size that the linear-memory size
would exceed, it returns `-1`; otherwise it returns the previous linear-memory
size, also as an unsigned value in units of [pages].

**Validation**:
 - [Linear-memory size validation](#linear-memory-size-validation) is required.

> This instruction can fail even when a maximum size is present and not yet
reached.

> Since the return value is in units of pages, `-1` isn't otherwise a valid
linear-memory size.

TODO: Rename this and `current_memory` to have "linear" in the mnemonic?

#### Current Linear-Memory Size

| Mnemonic         | Signature              | Families | Opcode |
| ---------------- | ---------------------- | -------- | ------ |
| `current_memory` | `() : (iPTR)`          | [R]      | 0x3b   |

The `current_memory` instruction returns the size of the referenced
linear-memory space, as an unsigned value in units of [pages].

**Validation**:
 - [Linear-memory size validation](#linear-memory-size-validation) is required.

[B]: #b-branch-instruction-family
[Q]: #q-control-flow-barrier-instruction-family
[L]: #l-call-instruction-family
[G]: #g-generic-integer-instruction-family
[S]: #s-signed-integer-instruction-family
[U]: #u-unsigned-integer-instruction-family
[T]: #t-shift-instruction-family
[F]: #f-floating-point-instruction-family
[Z]: #z-floating-point-bitwise-instruction-family
[C]: #c-comparison-instruction-family
[M]: #m-linear-memory-access-instruction-family
[R]: #r-linear-memory-size-instruction-family
[Type Section]: #type-section
[Import Section]: #import-section
[Function Section]: #function-section
[Table Section]: #table-section
[Linear-Memory Section]: #linear-memory-section
[Export Section]: #export-section
[Start Section]: #start-section
[Code Section]: #code-section
[Data Section]: #data-section
[Global Section]: #global-section
[Element Section]: #element-section
[Name Section]: #name-section
[function Index space]: #function-index-space
[global index space]: #global-index-space
[linear-memory index space]: #linear-memory-index-space
[table index space]: #table-index-space
[accessed bytes]: #accessed-bytes
[array]: #array
[arrays]: #array
[binary format]: #binary-format
[bit]: https://en.wikipedia.org/wiki/Bit
[boolean]: #booleans
[bytes]: #bytes
[call-stack resources]: #call-stack-resources
[effective address]: #effective-address
[false]: #booleans
[Floor and Ceiling Functions]: https://en.wikipedia.org/wiki/Floor_and_ceiling_functions
[index]: #index
[indices]: #index
[KiB]: https://en.wikipedia.org/wiki/Kibibyte
[label]: #labels
[labels]: #labels
[linear-memory access validation]: #linear-memory-access-validation
[little-endian byte order]: https://en.wikipedia.org/wiki/Endianness#Little
[merged]: #type-sequence-merge
[minimum signed integer value]: https://en.wikipedia.org/wiki/Two%27s_complement#Most_negative_number
[nondeterministic]: #nondeterminism
[nondeterministically]: #nondeterminism
[pages]: #pages
[rotated]: https://en.wikipedia.org/wiki/Bitwise_operation#Rotate_no_carry
[shift count]: #shift-count
[shifted]: https://en.wikipedia.org/wiki/Logical_shift
[sign-extended]: https://en.wikipedia.org/wiki/Sign_extension
[string]: #string
[strings]: #string
[text format]: #text-format
[true]: #booleans
[type]: #types
[types]: #types
[typed]: #types
[trap]: #instruction-traps
[two's complement]: https://en.wikipedia.org/wiki/Two%27s_complement
[two's complement difference]: https://en.wikipedia.org/wiki/Two%27s_complement#Subtraction
[two's complement product]: https://en.wikipedia.org/wiki/Two%27s_complement#Multiplication
[two's complement sum]: https://en.wikipedia.org/wiki/Two%27s_complement#Addition

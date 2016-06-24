WebAssembly Specification
================================================================================

0. [Module](#module)
0. [Validation](#validation)
0. [Execution](#execution)
0. [Types](#types)
0. [Instruction Signatures](#instruction-signatures)
0. [Instruction Families](#instruction-families)
0. [Instructions](#instructions)


Module
--------------------------------------------------------------------------------

0. [Module Types](#module-types)
0. [Module Contents](#module-contents)

### Module Types

These types describe various data structures present in WebAssembly modules:

0. [Index](#index)
0. [Array](#array)
0. [String](#string)

> These types are not used to describe values at runtime.

#### Index

An *index* is a 32-bit unsigned integer value.

> Indices may be represented in compressed form in some representations.

#### Array

An *array* is an [index] indicating a number of elements, plus a sequence of
that many elements.

> Array elements need not all be the same size in some representations.

#### String

A *string* is an [array] of bytes.

> Strings in this context may contain arbitrary bytes and are not required to be
valid UTF-8 or any other format.

### Module Contents

Modules contain a version [index]. Currently this number is `0xb`. The initial
stable release of WebAssembly will set it to `0x0`.

Modules also contain a sequence of sections. Each section has a [string] *name*
and associated data.

There are several *known sections*:

0. [Type Section](#type-section)
0. [Import Section](#import-section)
0. [Function Section](#function-section)
0. [Memory Section](#memory-section)
0. [Export Section](#export-section)
0. [Start Section](#start-section)
0. [Code Section](#code-section)
0. [Data Section](#data-section)
0. [Name Section](#name-section)

#### Type Section

**Name:** `type`.

The Type Section contains an [array] of all function signatures that will be
used in the module.

Each function signature contains a *parameter list*, an [array] of [types], and
a *return list*, also an [array] of [types].

The return list must have at most one element.

> In the future, this section may contain other forms of type entries as well,
and support for signatures with multiple return types.

#### Import Section

**Name:** `import`

The Import Section contains an [array] of all imports that will be used in the
module.

Each import contains:
 - a *signature index*, identifying a signature in the
   [Type Section](#type-section).
 - a *module string*, identifying a module to import from.
 - a *function string*, identifying a function inside that module to import.

#### Function Section

**Name:** `function`

The Function Section contains an [array] with elements directly corresponding to
functions defined in the [Code Section](#code-section)), each containing the
index in the [Type Section](#type-section) of the signature of the function.

#### Memory Section

**Name:** `memory`

The Memory Section contains:
 - An *initial size*, which is an unsigned `iPTR` value, in units of [pages].
 - A *maximum size*, which is an unsigned `iPTR` value, in units of [pages]. See
   the [`grow_memory`](#grow-memory) instruction for further information on this
   field.
 - An *exported* flag, which is a boolean value indicating whether the memory is
   visible outside the module.

#### Export Section

**Name:** `export`

The Export Section contains an [array] of exports from the module.

An export contains:
 - the [index] of a function to export
 - a *function string*, which is the [string] name to export the indexed
   function as.

#### Start Section

**Name:** `start`

The Start Section contains a function [index]. See
[Module Execution](#module-execution) for further information.

#### Code Section

**Name:** `code`

The Code Section contains an [array] of [function bodies](#function-bodies).

#### Data Section

**Name:** `data`

The Data Section contains an [array] of [string] and offset pairs describing
data to be loaded into linear memory before [Execution](#execution).

#### Name Section

**Name:** `name`

The Names Section does not change execution semantics and a validation failure
in this section does not cause validation for the whole module to fail and is
instead treated as if the section was absent.

The Names Section contains an [array] of function name descriptors, which each
describe names for the function with the corresponding index in the module, and
which contain:
 - The function name, a [string].
 - The names of the locals in the function, an [array] of [strings].

> Name data is represented as an explicit section in the binary format, however
in the text format it may be represented as an integrated part of the syntax for
functions rather than as a discrete section.

> The expectation is that, when a binary WebAssembly module is viewed in a
browser or other development environment, the names in this section will be used
as the names of functions and locals in the [text format](TextFormat.md).

### Unknown Sections

Modules may also contain unknown sections, with names other than those
corresponding to known sections above. They have no semantic effect.

### Function Bodies

Function bodies contain an [array] of [types], which are declarations for
locals, and a sequence of instructions.

##### Positions Within A Function Body

A *position* within a function refers to an element of the instruction sequence.

> In the binary encoding, positions are represented as byte offsets; in the text
format, positions are represented with a special syntax.


Validation
--------------------------------------------------------------------------------

### Module Validation

TODO: Describe module validation.

### Function Validation

For the duration of the validation of a function body, several data structures
are created:
 - A *control-flow stack*, with entries each containing
    - A [control-flow type](#control-flow-type).
    - A *limit* value.
 - A *[type] stack*.
 - A *current position*.

During validation, if either stack is empty when an element is to be popped from
it, or an element is accessed by index less than zero or not less than the
stack's length, validation fails. If a value is popped from the type stack such
that the length of the type stack becomes less than the control-flow stack top's
limit value, validation fails.

#### Control Flow Type

A *control-flow type* is either a [type](#types), `any`, which satisfies any
type check, or `void`, which satisfies no check.

> `any` is effectively serving as a kind of bottom type, and `void` is
effectively serving as a kind of top type. Note that in some type theory
contexts, it's common to use these names for exactly opposite purposes.

#### Control Flow Type Merge

To merge two [control-flow types]:
 - If either control-flow type is `any`, the result is the other control flow
   type.
 - Otherwise, if the control-flow types are the same, the result is that control
   flow type.
 - Otherwise, validation fails.

#### Function Validation Initialization

If the instruction sequence is empty, or if the last instruction in the sequence
is not an `end`, validation fails.

The current position starts at the first position. The type stack begins empty.
The control-flow stack starts with one entry. This entry's control-flow type is
the first return type of the function, if it has any, or `void` otherwise. Its
limit value is zero.

> The final `end` instruction may be implicit in some representations.

#### Function Body Validation

The instruction at the current position is remembered, and the current position
is incremented to point to the position following it. Then the remembered
instruction is validated as follows.

If the instruction has a **Validation** clause, that clause describes its
validation. Otherwise, [generic validation](#generic-instruction-validation) is
performed.

If the current position is now past the end of the sequence,
[function return validation](#function-return-validation) is initiated and
validation of the function is thereafter complete.

Otherwise, [validation](#function-body-validation) is resumed.

TODO: `unreachable`, `br`, `return`, and `br_table` return type validation.

#### Generic Instruction Validation

For each operand [type] in the instruction's signature in reverse order, a
type is popped from the type stack and checked to match it. Each return type of
the instruction's signature is then pushed onto the type stack.

Then, if the instruction's signature has no return types, and the length of the
type stack is greater than the control-flow stack top's limit value, validation
fails.

#### Function Return Validation

If the function signature has any return types, a type is popped from the type
stack and checked to match the first return type. The type stack and the
control-flow stack are then both checked to be empty. If no failures were
detected anywhere in the function, function validation is successful.


Execution
--------------------------------------------------------------------------------

Before any code in a module can be executed, the whole module must first be
[validated](#validation).

The contents of the [Data Section](#data-section) are loaded into linear memory.
Each [string] is loaded into linear memory at its associated offset.

Then, the [recursion limit](#recursion-limits) values are chosen,
[nondeterministically].

TODO: Describe module versus instance, and describe instantiation.

TODO: Implementations can, nondeterministically, trap at any time, due to
insufficient resources.

### Recursion Limits

The following two values are chosen before any functions are executed:

 - A *recursion increment*.
 - A *recursion limit*.

> These values are used by [call instructions][L].

### Module Execution

If the module contains a [Start Section](#start-section), the referenced
function is [executed](#function-execution).

### Function Execution

Function execution can be prompted by a [call-family instruction][L], by
[module execution](#module-execution), or by the embedding environment.

The input to execution of a function consists of:
 - The function to be executed.
 - The incoming argument values, one for each argument [type] of the function.
 - A *recursion depth* value.

For the duration of the execution of a function body, several data structures
are created:
 - A *control-flow stack*, which holds [labels] for reference from branch
   instructions.
 - A *value stack*, which carries values between instructions.
 - A *locals* array, containing an element for each argument of the function in
   the argument's [type], as well as an element for each local declaration in
   the function.
 - A *current position*.

> Implementations need not create a literal array to store the locals, or
literal stacks to manage values at runtime.

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
instruction is executed as follows.

For each operand [type] in the instruction's signature in reverse order, a value
is popped from the value stack and provided as the corresponding operand value.
The instruction is then executed as described in the
[Instructions Section](#instructions) entry describing it. Each of the
instruction's return values are then pushed onto the value stack.

If the current position is now past the end of the sequence,
[function return execution](#function-return-execution) is initiated and
execution of the function is thereafter complete.

Otherwise, [execution](#function-body-execution) is resumed.

#### Labels

A label is a value which is either *unbound*, or *bound* to a specific position.

#### Nondeterminism

When semantics are specified as *nondeterministic*, a WebAssembly implementation
may perform any one of the specified alternatives.

> There is no requirement that a given implementation make the same choice every
time, even within the same program.

#### Instruction Traps

Instructions may *trap*, in which case execution of the current module is
immediately terminated and abnormal termination is reported to the embedding
environment.

#### Function Return Execution

One value for each return [type] in the function signature in reverse order is
popped from the value stack. If the function execution was prompted by a call
instruction, these values are provided as the call's return value. Otherwise,
they are provided to the embedding environment.


Types
--------------------------------------------------------------------------------

0. [Integer Types](#integer-types)
0. [Floating-Point Types](#floating-point-types)

### Integer Types

| Name  | Bits
| ----  | ----
| `i32` | 32
| `i64` | 64

Integer types are not inherently signed or unsigned. They may be interpreted as
signed or unsigned by individual instructions. When interpreted as signed, a
[two's complement] interpretation is used.

> The [minimum signed integer value] is supported; consequently, two's
complement signed integers are not symmetric around zero.

#### Booleans

[Boolean](https://en.wikipedia.org/wiki/Boolean_data_type) values are
represented as values of type `i32`. In a boolean context, any non-zero value is
interpreted as true and `0` is interpreted as false.

Any instruction that produces a boolean value, such as a comparison, produces
the values `0` and `1` for false and true.

### Floating-Point Types

| Name  | Bits
| ----  | ----
| `f32` | 32
| `f64` | 64

`f32` uses the IEEE 754-2008
[binary32](https://en.wikipedia.org/wiki/Single-precision_floating-point_format)
format, commonly known as "Single Precision".

`f64` uses the IEEE 754-2008
[binary64](https://en.wikipedia.org/wiki/Double-precision_floating-point_format)
format, commonly known as "Double Precision".

> Unlike with
[Numbers in ECMAScript](https://tc39.github.io/ecma262/#sec-ecmascript-language-types-number-type),
[NaN](https://en.wikipedia.org/wiki/NaN) values in WebAssembly have sign bits
and significand fields which may be observed and manipulated (though they are
usually unimportant).


Instruction Signatures
--------------------------------------------------------------------------------

Instruction signatures describe the explicit inputs and outputs to an
instruction. They are described in either of the following forms:

 - `(` *arguments* `)` `:` `(` *returns* `)`
 - `<` *immediates* `>` `(` *arguments* `)` `:` `(` *returns* `)`

*Immediates*, if present, is a list of [typed] value names, representing values
provided by the module itself as input to an instruction. *Arguments* is a list
of [typed] value names representing values provided by program execution as
input to an instruction. *Returns* is a list of [types], representing values
computed by an instruction that are provided back to the program execution.

A few special constructs are used for special purposes:
 - `iPTR` is for use with a linear memory access, and signifies the integer type
   associated with addresses within the accessed linear memory space.
 - `TABLE` indicates a branch table, which is a sequence of immediate integer
   values for use in the [table branch](#table-branch) instruction.
 - `T` is used in type-generic instructions to denote a type parameter.
 - `T?` is used in type-generic instructions to denote either a type parameter
   or no type.
 - `*args*` is used in [call instructions][L] and indicates a sequence of typed
   value names providing the values for the arguments in the call.
 - `*returns*` is also used in [call instructions][L] and indicates a sequence
   of types, describing the function's return types.


Instruction Families
--------------------------------------------------------------------------------

WebAssembly instructions may belong to several families:

0. [M: Memory-Access Instruction Family][M]
0. [R: Memory-Resize Instruction Family][R]
0. [B: Branch Instruction Family][B]
0. [L: Call Instruction Family][L]
0. [C: Comparison Instruction Family][C]
0. [T: Shift Instruction Family][T]
0. [G: Generic Integer Instruction Family][G]
0. [S: Signed Integer Instruction Family][S]
0. [U: Unsigned Integer Instruction Family][U]
0. [F: Floating-Point Instruction Family][F]
0. [Z: Floating-Point Bitwise Instruction Family][Z]

### M: Memory-Access Instruction Family

These instructions load from and store to a linear memory space.

#### Bytes

[*Bytes*](https://en.wikipedia.org/wiki/Byte) in WebAssembly are 8-[bit], and
are the addressing unit of linear memory spaces.

#### Effective Address

The *effective address* of a linear memory access is computed by adding `$base`
and `$offset` at infinite precision, so that there is no overflow.

#### Alignment

**Slow:** If the effective address is not a multiple of `$align`, the access is
*misaligned*, and the instruction may execute very slowly.

> When `$align` is greater than or equal to the size of the access, the access
is *naturally aligned*. When it is less, the access is *unaligned*.

> There is no other semantic effect associated with `$align`; misaligned and
unaligned loads and stores still function normally.

#### Accessed Bytes

The *accessed bytes* consist of a contiguous sequence of [bytes] starting at the
[effective address], with a length implied by the accessing instruction.

**Trap:** Out Of Bounds, if any of the accessed bytes are beyond the end of the
accessed linear memory space.

#### Loading

For a load access, a value is read from the [accessed bytes], in
[little-endian byte order], and returned.

#### Storing

For a store access, the value to store is written to the [accessed bytes], in
[little-endian byte order].

#### Linear Memory Access Validation

`$align` is checked to be a power of 2.

[Generic validation](#generic-instruction-validation) is also performed.

### R: Memory-Resize Instruction Family

#### Pages

*Pages* in WebAssembly are 64 [KiB], and are the units used in linear memory
resizing.

### B: Branch Instruction Family

#### Branching

In a branch according to a given control-flow stack entry, first the value stack
is resized to the entry's limit value.

Then, if the entry's [label] is bound, the current position is set to the bound
position. Otherwise, the position to bind the label to is found by scanning
forward through the instructions, executing just `block`, `loop`, and `end`
instructions, until the label is bound. Then the current position is set to that
position.

Then, control-flow stack entries are popped until the given control-flow stack
entry is popped.

> In practice, implementations may precompute the destinations of branches so
that they don't literally need to scan in this manner.

#### Forwarding Control-Flow Type

To obtain the *forwarding control-flow type*:
 - If the type stack's length is one greater than the control-flow stack top's
   limit value, pop a type from the type stack.
 - If the type stack's length is equal to the control-flow stack top's limit
   value, use `void`.
 - Otherwise, validation fails.

> Validation fails if there are unused entries left on the stack. The
[`drop` instruction](#drop) can be used to discard unused values.

### L: Call Instruction Family

#### Calling

The called function &mdash; the *callee* &mdash; is
[executed](#function-execution), with the `*args*` operands passed to it as its
incoming arguments, and the current recursion depth value plus the value of the
[recursion increment](#recursion-limits) as its recursion depth value. The
return value of the call is defined by the execution.

**Trap:** Call stack overflow, if the recursion depth value is greater than the
[recursion limit](#recursion-limits).

> This means that implementations are not permitted to perform implicit
opportunistic tail-call elimination.

> The execution state of the function currently being executed remains live
during the call, and the execution of the called function is performed
independently. In this way, calls form a stack-like data structure called the
*call stack*.

> Implementations need not pass a literal argument to represent the recursion
depth.

### C: Comparison Instruction Family

WebAssembly comparison instructions compare two values and return a [boolean]
result value.

> In accordance with IEEE 754-2008, for the comparison instructions, negative
zero is considered equal to zero, and NaN values are not less than, greater
than, or equal to any other values, including themselves.

### T: Shift Instruction Family

In the shift and rotate instructions, *left* means in the direction of greater
significance, and *right* means in the direction of lesser significance.

#### Shift Count

The second operand in shift and rotate instructions specifies a *shift count*,
which is interpreted as an unsigned quantity modulo the number of bits in the
first operand.

> As a result of the modulo, in `i32` instructions, only the least-significant 5
bits of the second operand affect the result, and in `i64` instructions only the
least-significant 6 bits of the second operand affect the result.

> The shift count is interpreted as unsigned even in otherwise signed
instructions such as [`shr_s`](#integer-shift-right-signed).

### G: Generic Integer Instruction Family

Except where otherwise specified, these instructions do not specifically
interpret their operands as explicitly signed or unsigned, and therefore do not
have an inherent concept of overflow.

### S: Signed Integer Instruction Family

Except where otherwise specified, these instructions interpret their operand
values as signed, return result values interpreted as signed, and [trap] when
the result value can not be represented as such.

### U: Unsigned Integer Instruction Family

Except where otherwise specified, these instructions interpret their operand
values as unsigned, return result values interpreted as unsigned, and [trap]
when the result value can not be represented as such.

### F: Floating-Point Instruction Family

Instructions in this family follow the [IEEE 754-2008] standard, except that:

 - They support only "non-stop" mode, and floating-point exceptions are not
   otherwise observable. In particular, neither alternate floating-point
   exception handling attributes nor the non-computational operations on status
   flags are supported.

 - They use the IEEE 754-2008 `roundTiesToEven` rounding attribute, except where
   otherwise specified. Non-default directed rounding attributes are not
   supported.

When the result of any instruction in this family (which excludes `neg`, `abs`,
and `copysign`) is a NaN, the sign bit and the significand field (which does not
include the implicit leading digit of the significand) of the NaN are computed
by one of the following rules, selected [nondeterministically]:

 - If the instructions has any NaN non-immediate operand values, implementations
   may [nondeterministically] select any of them to be the result value, but
   with the most significant bit of the significand field overwritten to be `1`.

 - If the implementation does not choose to use an input NaN as a result value,
   or if there are no input NaNs, the result value has a [nondeterministic] sign
   bit, a significand field with `1` in the most significant bit and `0` in the
   remaining bits.

Implementations are permitted to further implement the IEEE 754-2008 section
"Operations with NaNs" recommendation that operations propagate NaN bits from
their operands, however it is not required.

> All computations are correctly rounded, subnormal values are fully supported,
and negative zero, NaNs, and infinities are all produced as result values to
indicate overflow, invalid, and divide-by-zero exceptional conditions, and
interpreted appropriately when they appear as operands. All numeric results are
deterministic.

> There is no observable difference between quiet and signaling NaN other than
the difference in the bit pattern.

### Z: Floating-Point Bitwise Instruction Family

These instructions operate on floating-point values, but do so in purely bitwise
ways, including in how they operate on NaN and zero values.

They correspond to the "Sign bit operations" in IEEE 754-2008.


Instructions
--------------------------------------------------------------------------------

0. [Control Flow Instructions](#control-flow-instructions)
0. [Basic Instructions](#basic-instructions)
0. [Integer Instructions](#integer-instructions)
0. [Floating-Point Instructions](#floating-point-instructions)
0. [Integer Comparison Instructions](#integer-comparison-instructions)
0. [Floating-Point Comparison Instructions](#floating-point-comparison-instructions)
0. [Conversion Instructions](#conversion-instructions)
0. [Load And Store Instructions](#load-and-store-instructions)
0. [Additional Memory-Related Instructions](#additional-memory-related-instructions)

### Control Flow Instructions

0. [Block](#block)
0. [Loop](#loop)
0. [If](#if)
0. [Else](#else)
0. [Unconditional Branch](#unconditional-branch)
0. [Conditional Branch](#conditional-branch)
0. [Table Branch](#table-branch)
0. [Return](#return)
0. [Unreachable](#unreachable)
0. [End](#end)

#### Block

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `block`     | `() : ()`                   |          | 0x01

The `block` instruction pushes an unbound [label] onto the control-flow stack.

**Validation:**
 - An entry is pushed onto the control-flow stack containing `any` and a limit
   value of the current length of the type stack.

#### Loop

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `loop`      | `() : ()`                   |          | 0x02

The `loop` instruction binds a [label] to the current position and pushes it
onto the control-flow stack.

**Validation:**
 - An entry is pushed onto the control-flow stack containing `any` and a limit
   value of the current length of the type stack.

#### If

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `if`        | `(i32) : ()`                |          | 0x03

TODO: Describe `if`.

#### Else

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `else`      | `() : ()`                   |          | 0x04

TODO: Describe `else`.

#### Unconditional Branch

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `br`        | `<$depth: i32> (T?) : (T?)` | [B]      | 0x06

The `br` instruction [branches](#branching) according to the control flow stack
entry `$depth` from the top. Its return value is the value of its operand, if it
has one.

TODO: Branch arity immediates.

**Validation:**
 - [Merge] the [forwarding control-flow type] into the control-flow type of the
   control-flow stack entry `$depth` from the top.

#### Conditional Branch

| Name        | Signature                                    | Families | Opcode
| ----        | ---------                                    | -------- | ------
| `br_if`     | `<$depth: i32> (T?, $condition: i32) : (T?)` | [B]      | 0x07

If `$condition` is [true], the `br_if` instruction [branches](#branching)
according to the control flow stack entry `$depth` from the top. Otherwise, it
does nothing. Its return value is the value of its first operand, if it has more
than one.

**Validation:**
 - Pop a type from the type stack and check that it is `i32`.
 - Determine the [forwarding control-flow type].
 - [Merge] it into the control-flow type of the control-flow stack entry
   `$depth` from the top.
 - If it is not `void`, push it onto the type stack.
 - If it is `void`, and the length of the type stack is greater than the
   control-flow stack top's limit value, validation fails.

#### Table Branch

| Name        | Signature                                         | Families | Opcode
| ----        | ---------                                         | -------- | ------
| `br_table`  | `<TABLE, $default: i32> (T?, $index: i32) : (T?)` | [B]      | 0x08

First, the `br_table` instruction selects a depth to use. If `$index` is within
the bounds of the table, the depth is the value of the indexed table element.
Otherwise, the depth is `$default`.

Then, it [branches](#branching) according to the control-flow stack entry that
depth from the top. Its return value is the value of its first operand, if it
has more than one.

**Validation:**
 - Pop a type from the type stack and check that it is `i32`.
 - For each depth in the table and `$default`, [merge] the
   [forwarding control-flow type] control-flow type into the control-flow type
   of the control-flow stack entry that depth from the top.

> This instruction serves the role of what is sometimes called a
["jump table"](https://en.wikipedia.org/w/index.php?title=Jump_table) in other
languages. "Branch" is used here instead to emphasize the commonality with the
other branch instructions.

#### Return

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `return`    | `(T?) : (T?)`               | [B]      | 0x09

The `return` instruction [branches](#branching) according to the control-flow
stack bottom. Its return value is the value of its operand, if it has one.

**Validation:**
 - [Merge] the [forwarding control-flow type] into the control-flow type of the
   control-flow stack bottom.

> Implementations need not literally perform a branch before performing the
actual function return.

#### Unreachable

| Name          | Signature                 | Families | Opcode
| ----          | ---------                 | -------- | ------
| `unreachable` | `() : ()`                 |          | 0x0a

**Trap:** Unreachable, always.

> The `unreachable` instruction is meant to represent code that is not meant to
be executed except in the case of a bug in the application.

#### End

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `end`       | `(T?) : (T?)`               | [B]      | 0x0f

The `end` instruction pops an entry from the control-flow stack. If the entry's
[label] is unbound, the label is bound to the current position. Its return value
is the value of its operand, if it has one.

**Validation:**
 - Determine the [forwarding control-flow type].
 - [Merge] it into the control-flow type of the control-flow stack top, and then
   pop the control-flow stack top.
 - If it is not `void`, push it onto the type stack.
 - If it is `void`, and the length of the type stack is greater than the (new)
   control-flow stack top's limit value, validation fails.

### Basic Instructions

0. [Nop](#nop)
0. [Drop](#drop)
0. [Constant](#constant)
0. [Get Local](#get-local)
0. [Set Local](#set-local)
0. [Tee Local](#tee-local)
0. [Select](#select)
0. [Call](#call)
0. [Indirect Call](#indirect-call)

TODO: `call_table`

#### Nop

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `nop`       | `() : ()`                   |          | 0x00

The `nop` instruction does nothing.

#### Drop

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `drop`      | `(T) : ()`                  |          | 0x0b

The `drop` instruction does nothing.

> This differs from `nop` in that it has an operand, so it can be used to
discard unneeded values from the value stack.

#### Constant

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `i32.const` | `<i32> () : (i32)`          | [G]      | 0x10
| `i64.const` | `<i64> () : (i64)`          | [G]      | 0x11
| `f32.const` | `<f32> () : (f32)`          | [F]      | 0x12
| `f64.const` | `<f64> () : (f64)`          | [F]      | 0x13

The `const` instruction returns the value of its immediate.

#### Get Local

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `get_local` | `<$id: i32> () : (T)`       |          | 0x14

The `get_local` instruction returns the value in the locals array at index
`$id`.

#### Set Local

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `set_local` | `<$id: i32> (T) : ()`       |          | 0x15

The `set_local` instruction sets the value in the locals array at index `$id` to
the value given in the operand.

#### Tee Local

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `tee_local` | `<$id: i32> (T) : (T)`      |          | 0x19

The `tee_local` instruction sets the value in the locals array at index `$id` to
to the value given in the operand. Its return value is the value of its operand.

#### Select

| Name        | Signature                       | Families | Opcode
| ----        | ---------                       | -------- | ------
| `select`    | `(T, T, $condition: i32) : (T)` |          | 0x05

The `select` instruction returns its first operand if `$condition` is [true], or
its second operand otherwise.

#### Call

| Name        | Signature                               | Families | Opcode
| ----        | ---------                               | -------- | ------
| `call`      | `<$callee: i32> (*args*) : (*returns*)` | [L]      | 0x16

The `call` instruction performs a [call](#calling) to the function with index
`$callee`.

#### Indirect Call

| Name            | Signature                              | Families | Opcode
| ----            | ---------                              | -------- | ------
| `call_indirect` | `($callee: i32, *args*) : (*returns*)` | [L]      | 0x17

The `call_indirect` instruction performs a [call](#calling) to the function with
index `$callee`.

### Integer Instructions

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

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.add`   | `(i32, i32) : (i32)`        | [G]      | 0x40   | `+` (13)
| `i64.add`   | `(i64, i64) : (i64)`        | [G]      | 0x5b   | `+` (13)

The integer `add` instruction returns the [two's complement sum] of its
operands. The carry bit is silently discarded.

> Due to WebAssembly's use of [two's complement] to represent signed values,
this instruction can be used to add either signed or unsigned values.

#### Integer Subtract

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.sub`   | `(i32, i32) : (i32)`        | [G]      | 0x41   | `-` (13)
| `i64.sub`   | `(i64, i64) : (i64)`        | [G]      | 0x5c   | `-` (13)

The integer `sub` instruction returns the [two's complement difference] of its
operands. The borrow bit is silently discarded.

> Due to WebAssembly's use of [two's complement] to represent signed values,
this instruction can be used to subtract either signed or unsigned values.

> An integer negate operation can be performed by a `sub` instruction with zero
as the first operand.

#### Integer Multiply

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.mul`   | `(i32, i32) : (i32)`        | [G]      | 0x42   | `*` (14)
| `i64.mul`   | `(i64, i64) : (i64)`        | [G]      | 0x5d   | `*` (14)

The integer `mul` instruction returns the low half of the
[two's complement product] its operands.

> Due to WebAssembly's use of [two's complement] to represent signed values,
this instruction can be used to multiply either signed or unsigned values.

#### Integer Divide, Signed

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.div_s` | `(i32, i32) : (i32)`        | [S]      | 0x43   | `/s` (14)
| `i64.div_s` | `(i64, i64) : (i64)`        | [S]      | 0x5e   | `/s` (14)

The `div_s` instruction returns the signed quotient of its operands, interpreted
as signed. The quotient is silently rounded to the nearest integer toward zero.

**Trap:** Signed overflow, when the [minimum signed integer value] is divided by
`-1`.

**Trap:** Division by zero, when the second operand (the divisor) is zero.

#### Integer Divide, Unsigned

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.div_u` | `(i32, i32) : (i32)`        | [U]      | 0x44   | `/u` (14)
| `i64.div_u` | `(i64, i64) : (i64)`        | [U]      | 0x5f   | `/u` (14)

The `div_u` instruction returns the unsigned quotient of its operands,
interpreted as unsigned. The quotient is silently rounded to the nearest integer
toward zero.

**Trap:** Division by zero, when the second operand (the divisor) is zero.

#### Integer Remainder, Signed

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.rem_s` | `(i32, i32) : (i32)`        | [S]      | 0x45   | `%s` (14)
| `i64.rem_s` | `(i64, i64) : (i64)`        | [S]      | 0x60   | `%s` (14)

The `rem_s` instruction returns the signed remainder from a division of its
operand values interpreted as signed, with the result having the same sign as
the first operand (the dividend).

**Trap:** Division by zero, when the second operand (the divisor) is zero.

> This instruction does not trap when the [minimum signed integer value] is
divided by `-1`; it returns `0` which is the correct remainder (even though the
same operands to `div_s` do cause a trap).

> This instruction differs from what is often called a
["modulo" operation](https://en.wikipedia.org/wiki/Modulo_operation) in its
handling of negative numbers.

#### Integer Remainder, Unsigned

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.rem_u` | `(i32, i32) : (i32)`        | [U]      | 0x46   | `%u` (14)
| `i64.rem_u` | `(i64, i64) : (i64)`        | [U]      | 0x61   | `%u` (14)

The `rem_u` instruction returns the unsigned remainder from a division of its
operand values interpreted as unsigned.

**Trap:** Division by zero, when the second operand (the divisor) is zero.

> This instruction corresponds to what is sometimes called "modulo" in other
languages.

#### Integer Bitwise And

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.and`   | `(i32, i32) : (i32)`        | [G]      | 0x47   | `&` (9)
| `i64.and`   | `(i64, i64) : (i64)`        | [G]      | 0x62   | `&` (9)

The `and` instruction returns the [bitwise and] of its operands.

#### Integer Bitwise Or

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.or`    | `(i32, i32) : (i32)`        | [G]      | 0x48   | `|` (7)
| `i64.or`    | `(i64, i64) : (i64)`        | [G]      | 0x63   | `|` (7)

The `or` instruction returns the [bitwise inclusive-or] of its operands.

#### Integer Bitwise Exclusive-Or

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.xor`   | `(i32, i32) : (i32)`        | [G]      | 0x49   | `^` (8)
| `i64.xor`   | `(i64, i64) : (i64)`        | [G]      | 0x64   | `^` (8)

The `xor` instruction returns the [bitwise exclusive-or] of its operands.

> A [bitwise negate](https://en.wikipedia.org/wiki/Bitwise_operation#NOT)
operation can be performed by a `xor` instruction with negative one as the first
operand, an operation sometimes called "one's complement" in other languages.

#### Integer Shift Left

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.shl`   | `(i32, i32) : (i32)`        | [T], [G] | 0x4a   | `<<` (12)
| `i64.shl`   | `(i64, i64) : (i64)`        | [T], [G] | 0x65   | `<<` (12)

The `shl` instruction returns the value of the first operand [shifted] to the
left by the [shift count].

> This instruction effectively performs a multiplication by two to the power of
the shift count.

#### Integer Shift Right, Signed

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.shr_s` | `(i32, i32) : (i32)`        | [T], [S] | 0x4c   | `>>s` (12)
| `i64.shr_s` | `(i64, i64) : (i64)`        | [T], [S] | 0x67   | `>>s` (12)

The `shr_s` instruction returns the value of the first operand
[shifted](https://en.wikipedia.org/wiki/Arithmetic_shift) to the right by the
[shift count].

> This instruction corresponds to what is sometimes called
"arithmetic right shift" in other languages.

> `shr_s` is similar to `div_s` when the divisor is a power of two, however the
rounding of negative values is different. `shr_s` effectively rounds down, while
`div_s` rounds toward zero.

#### Integer Shift Right, Unsigned

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.shr_u` | `(i32, i32) : (i32)`        | [T], [U] | 0x4b   | `>>u` (12)
| `i64.shr_u` | `(i64, i64) : (i64)`        | [T], [U] | 0x66   | `>>u` (12)

The `shr_u` instruction returns the value of the first operand [shifted] to the
right by the [shift count].

> This instruction corresponds to what is sometimes called
"logical right shift" in other languages.

> This instruction effectively performs an unsigned division by two to the power
of the shift count.

#### Integer Rotate Left

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `i32.rotl`  | `(i32, i32) : (i32)`        | [T], [G] | 0xb7
| `i64.rotl`  | `(i64, i64) : (i64)`        | [T], [G] | 0xb9

The `rotl` instruction returns the value of the first operand [rotated] to the
left by the [shift count].

> Rotating left is similar to shifting left, however vacated bits are set to the
values of the bits which would otherwise be discarded by the shift, so the bits
conceptually "rotate back around".

#### Integer Rotate Right

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `i32.rotr`  | `(i32, i32) : (i32)`        | [T], [G] | 0xb6
| `i64.rotr`  | `(i64, i64) : (i64)`        | [T], [G] | 0xb8

The `rotr` instruction returns the value of the first operand [rotated] to the
right by the [shift count].

> Rotating right is similar to shifting right, however vacated bits are set to
the values of the bits which would otherwise be discarded by the shift, so the
bits conceptually "rotate back around".

#### Integer Count Leading Zeros

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `i32.clz`   | `(i32) : (i32)`             | [G]      | 0x57
| `i64.clz`   | `(i64) : (i64)`             | [G]      | 0x72

The `clz` instruction returns the number of leading zeros in its operand. The
*leading zeros* are the longest contiguous sequence of zero-bits starting at the
most significant bit and extending downward.

> This instruction is fully defined when all bits are zero; it returns the
number of bits in the operand type.

#### Integer Count Trailing Zeros

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `i32.ctz`   | `(i32) : (i32)`             | [G]      | 0x58
| `i64.ctz`   | `(i64) : (i64)`             | [G]      | 0x73

The `ctz` instruction returns the number of trailing zeros in its operand. The
*trailing zeros* are the longest contiguous sequence of zero-bits starting at
the least significant bit and extending upward.

> This instruction is fully defined when all bits are zero; it returns the
number of bits in the operand type.

#### Integer Population Count

| Name         | Signature                  | Families | Opcode
| ----         | ---------                  | -------- | ------
| `i32.popcnt` | `(i32) : (i32)`            | [G]      | 0x59
| `i64.popcnt` | `(i64) : (i64)`            | [G]      | 0x74

The `popcnt` instruction returns the number of 1-bits in its operand.

> This instruction is fully defined when all bits are zero; it returns `0`.

> This instruction corresponds to what is sometimes called a
["hamming weight"][hamming weight] in other languages.

#### Integer Equal To Zero

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.eqz`   | `(i32) : (i32)`             | [G]      | 0x5a   | `!` (15)
| `i64.eqz`   | `(i64) : (i32)`             | [G]      | 0xba   | `!` (15)

The `eqz` instruction returns [true] if the operand is equal to zero, or [false]
otherwise.

> This serves as a form of "logical not" operation which can be used to invert
[boolean] values.

### Floating-Point Instructions

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

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `f32.add`   | `(f32, f32) : (f32)`        | [F]      | 0x75   | `+` (13)
| `f64.add`   | `(f64, f64) : (f64)`        | [F]      | 0x89   | `+` (13)

The floating-point `add` instruction performs the IEEE 754-2008 `addition`
operation according to [the general floating-point rules][F].

#### Floating-Point Subtract

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `f32.sub`   | `(f32, f32) : (f32)`        | [F]      | 0x76   | `-` (13)
| `f64.sub`   | `(f64, f64) : (f64)`        | [F]      | 0x8a   | `-` (13)

The floating-point `sub` instruction performs the IEEE 754-2008 `subtraction`
operation according to [the general floating-point rules][F].

#### Floating-Point Multiply

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `f32.mul`   | `(f32, f32) : (f32)`        | [F]      | 0x77   | `*` (14)
| `f64.mul`   | `(f64, f64) : (f64)`        | [F]      | 0x8b   | `*` (14)

The floating-point `mul` instruction performs the IEEE 754-2008 `multiplication`
operation according to [the general floating-point rules][F].

#### Floating-Point Divide

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `f32.div`   | `(f32, f32) : (f32)`        | [F]      | 0x78   | `/` (14)
| `f64.div`   | `(f64, f64) : (f64)`        | [F]      | 0x8c   | `/` (14)

The `div` instruction performs the IEEE 754-2008 `division` operation according
to [the general floating-point rules][F].

#### Floating-Point Square Root

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `f32.sqrt`  | `(f32) : (f32)`             | [F]      | 0x82
| `f64.sqrt`  | `(f64) : (f64)`             | [F]      | 0x96

The `sqrt` instruction performs the IEEE 754-2008 `squareRoot` operation
according to [the general floating-point rules][F].

#### Floating-Point Minimum

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `f32.min`   | `(f32, f32) : (f32)`        | [F]      | 0x79
| `f64.min`   | `(f64, f64) : (f64)`        | [F]      | 0x8d

The `min` instruction returns the minimum value among its operands. For this
instruction, negative zero is considered less than zero. If either operand is a
NaN, the result is a NaN determined by [the general floating-point rules][F].

> This differs from the IEEE 754-2008 `minNum` operation in that it returns a
NaN if either operand is a NaN, and in that the behavior on negative zero is
fully specified.

> This differs from the common `x<y?x:y` expansion in its handling of
negative zero and NaN values.

#### Floating-Point Maximum

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `f32.max`   | `(f32, f32) : (f32)`        | [F]      | 0x7a
| `f64.max`   | `(f64, f64) : (f64)`        | [F]      | 0x8e

The `max` instruction returns the maximum value among its operands. For this
instruction, negative zero is considered less than zero. If either operand is a
NaN, the result is a NaN determined by [the general floating-point rules][F].

> This differs from the IEEE 754-2008 `maxNum` operation in that it returns a
NaN if either operand is a NaN, and in that the behavior on negative zero is
fully specified.

> This differs from the common `x>y?x:y` expansion in its handling of negative
zero and NaN values.

#### Floating-Point Ceiling

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `f32.ceil`  | `(f32) : (f32)`             | [F]      | 0x7e
| `f64.ceil`  | `(f64) : (f64)`             | [F]      | 0x92

The `ceil` instruction performs the IEEE 754-2008
`roundToIntegralTowardPositive` operation according to
[the general floating-point rules][F].

> ["Ceiling"][Floor and Ceiling Functions] describes the rounding method used
here; the value is rounded up to the nearest integer.

#### Floating-Point Floor

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `f32.floor` | `(f32) : (f32)`             | [F]      | 0x7f
| `f64.floor` | `(f64) : (f64)`             | [F]      | 0x93

The `floor` instruction performs the IEEE 754-2008
`roundToIntegralTowardNegative` operation according to
[the general floating-point rules][F].

> ["Floor"][Floor and Ceiling Functions] describes the rounding method used
here; the value is rounded down to the nearest integer.

#### Floating-Point Truncate

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `f32.trunc` | `(f32) : (f32)`             | [F]      | 0x80
| `f64.trunc` | `(f64) : (f64)`             | [F]      | 0x94

The `trunc` instruction performs the IEEE 754-2008
`roundToIntegralTowardZero` operation according to
[the general floating-point rules][F].

> ["Truncate"](https://en.wikipedia.org/wiki/Truncation) describes the rounding
method used here; the fractional part of the value is discarded, effectively
rounding to the nearest integer toward zero.

#### Floating-Point Nearest Integer

| Name          | Signature                 | Families | Opcode
| ----          | ---------                 | -------- | ------
| `f32.nearest` | `(f32) : (f32)`           | [F]      | 0x81
| `f64.nearest` | `(f64) : (f64)`           | [F]      | 0x95

The `nearest` instruction performs the IEEE 754-2008
`roundToIntegralTiesToEven` operation according to
[the general floating-point rules][F].

> "Nearest" describes the rounding method used here; the value is
[rounded to the nearest integer](https://en.wikipedia.org/wiki/Nearest_integer_function).

> This instruction differs from
[`Math.round` in ECMAScript](https://tc39.github.io/ecma262/#sec-math.round)
which rounds ties up.

> This instruction differs from
[`round` in C](http://en.cppreference.com/w/c/numeric/math/round) which rounds
ties away from zero.

#### Floating-Point Absolute Value

| Name        | Signature                   | Families | Opcode
| ----        | ---------                   | -------- | ------
| `f32.abs`   | `(f32) : (f32)`             | [Z]      | 0x7b
| `f64.abs`   | `(f64) : (f64)`             | [Z]      | 0x8f

The `abs` instruction performs the IEEE 754-2008 `abs` operation.

> This is a bitwise instruction; it just sets the sign bit to zero and preserves
all other bits, even when the operand is a NaN or a zero.

> This differs from comparing whether the operand value is less than zero and
negating it, because comparisons treat negative zero as equal to zero, and NaN
values as not less than zero.

#### Floating-Point Negate

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `f32.neg`   | `(f32) : (f32)`             | [Z]      | 0x7c   | `-` (15)
| `f64.neg`   | `(f64) : (f64)`             | [Z]      | 0x90   | `-` (15)

The `neg` instruction performs the IEEE 754-2008 `negate` operation.

> This is a bitwise instruction; it just inverts the sign bit and preserves all
other bits, even when the operand is a NaN or a zero.

> This differs from subtracting the operand value from negative zero or
multiplying it by negative one, because subtraction and multiplication follow
the [general floating-point rules][F] and may not preserve the bits of NaN
values.

#### Floating-Point CopySign

| Name           | Signature                | Families | Opcode
| ----           | ---------                | -------- | ------
| `f32.copysign` | `(f32, f32) : (f32)`     | [Z]      | 0x7d
| `f64.copysign` | `(f64, f64) : (f64)`     | [Z]      | 0x91

The `copysign` instruction performs the IEEE 754-2008 `copySign` operation.

> This is a bitwise instruction; it just takes the sign bit from the second
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

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.eq`    | `(i32, i32) : (i32)`        | [C], [G] | 0x4d   | `==` (10)
| `i64.eq`    | `(i64, i64) : (i32)`        | [C], [G] | 0x68   | `==` (10)

The integer `eq` instruction tests whether the operands are equal.

#### Integer Inequality

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.ne`    | `(i32, i32) : (i32)`        | [C], [G] | 0x4e   | `!=` (10)
| `i64.ne`    | `(i64, i64) : (i32)`        | [C], [G] | 0x69   | `!=` (10)

The integer `ne` instruction tests whether the operands are not equal.

> This instruction corresponds to what is sometimes called "differs" in other
languages.

#### Integer Less Than, Signed

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.lt_s`  | `(i32, i32) : (i32)`        | [C], [S] | 0x4f   | `<s` (11)
| `i64.lt_s`  | `(i64, i64) : (i32)`        | [C], [S] | 0x6a   | `<s` (11)

The `lt_s` instruction tests whether the first operand is less than the second
operand, interpreting the operands as signed.

#### Integer Less Than, Unsigned

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.lt_u`  | `(i32, i32) : (i32)`        | [C], [U] | 0x51   | `<u` (11)
| `i64.lt_u`  | `(i64, i64) : (i32)`        | [C], [U] | 0x6c   | `<u` (11)

The `lt_u` instruction tests whether the first operand is less than the second
operand, interpreting the operands as unsigned.

#### Integer Less Than Or Equal To, Signed

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.le_s`  | `(i32, i32) : (i32)`        | [C], [S] | 0x50   | `<=s` (11)
| `i64.le_s`  | `(i64, i64) : (i32)`        | [C], [S] | 0x6b   | `<=s` (11)

The `le_s` instruction tests whether the first operand is less than or equal to
the second operand, interpreting the operands as signed.

> This instruction corresponds to what is sometimes called "at most" in other
languages.

#### Integer Less Than Or Equal To, Unsigned

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.le_u`  | `(i32, i32) : (i32)`        | [C], [U] | 0x52   | `<=u` (11)
| `i64.le_u`  | `(i64, i64) : (i32)`        | [C], [U] | 0x6d   | `<=u` (11)

The `le_u` instruction tests whether the first operand is less than or equal to
the second operand, interpreting the operands as unsigned.

> This instruction corresponds to what is sometimes called "at most" in other
languages.

#### Integer Greater Than, Signed

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.gt_s`  | `(i32, i32) : (i32)`        | [C], [S] | 0x53   | `>s` (11)
| `i64.gt_s`  | `(i64, i64) : (i32)`        | [C], [S] | 0x6e   | `>s` (11)

The `gt_s` instruction tests whether the first operand is greater than the
second operand, interpreting the operands as signed.

#### Integer Greater Than, Unsigned

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.gt_u`  | `(i32, i32) : (i32)`        | [C], [U] | 0x55   | `>u` (11)
| `i64.gt_u`  | `(i64, i64) : (i32)`        | [C], [U] | 0x70   | `>u` (11)

The `gt_u` instruction tests whether the first operand is greater than the
second operand, interpreting the operands as unsigned.

#### Integer Greater Than Or Equal To, Signed

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.ge_s`  | `(i32, i32) : (i32)`        | [C], [S] | 0x54   | `>=s` (11)
| `i64.ge_s`  | `(i64, i64) : (i32)`        | [C], [S] | 0x6f   | `>=s` (11)

The `ge_s` instruction tests whether the first operand is greater than or equal
to the second operand, interpreting the operands as signed.

> This instruction corresponds to what is sometimes called "at least" in other
languages.

#### Integer Greater Than Or Equal To, Unsigned

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `i32.ge_u`  | `(i32, i32) : (i32)`        | [C], [U] | 0x56   | `>=u` (11)
| `i64.ge_u`  | `(i64, i64) : (i32)`        | [C], [U] | 0x71   | `>=u` (11)

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

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `f32.eq`    | `(f32, f32) : (i32)`        | [C], [F] | 0x83   | `==` (10)
| `f64.eq`    | `(f64, f64) : (i32)`        | [C], [F] | 0x97   | `==` (10)

The floating-point `eq` instruction performs the IEEE 754-2008
`compareQuietEqual` operation according to
[the general floating-point rules][F].

#### Floating-Point Inequality

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `f32.ne`    | `(f32, f32) : (i32)`        | [C], [F] | 0x84   | `!=` (10)
| `f64.ne`    | `(f64, f64) : (i32)`        | [C], [F] | 0x98   | `!=` (10)

The floating-point `ne` instruction performs the IEEE 754-2008
`compareQuietNotEqual` operation according to
[the general floating-point rules][F].

> Unlike the other floating-point comparison instructions, this instruction
returns [true] if either operand is a NaN. It is the logical inverse of the `eq`
instruction.

#### Floating-Point Less Than

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `f32.lt`    | `(f32, f32) : (i32)`        | [C], [F] | 0x85   | `<` (11)
| `f64.lt`    | `(f64, f64) : (i32)`        | [C], [F] | 0x99   | `<` (11)

The `lt` instruction performs the IEEE 754-2008 `compareQuietLess` operation
according to [the general floating-point rules][F].

#### Floating-Point Less Than Or Equal To

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `f32.le`    | `(f32, f32) : (i32)`        | [C], [F] | 0x86   | `<=` (11)
| `f64.le`    | `(f64, f64) : (i32)`        | [C], [F] | 0x9a   | `<=` (11)

The `le` instruction performs the IEEE 754-2008 `compareQuietLessEqual`
operation according to [the general floating-point rules][F].

#### Floating-Point Greater Than

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `f32.gt`    | `(f32, f32) : (i32)`        | [C], [F] | 0x87   | `>` (11)
| `f64.gt`    | `(f64, f64) : (i32)`        | [C], [F] | 0x9b   | `>` (11)

The `gt` instruction performs the IEEE 754-2008 `compareQuietGreater` operation
according to [the general floating-point rules][F].

#### Floating-Point Greater Than Or Equal To

| Name        | Signature                   | Families | Opcode | Syntax
| ----        | ---------                   | -------- | ------ | ------
| `f32.ge`    | `(f32, f32) : (i32)`        | [C], [F] | 0x88   | `>=` (11)
| `f64.ge`    | `(f64, f64) : (i32)`        | [C], [F] | 0x9c   | `>=` (11)

The `ge` instruction performs the IEEE 754-2008 `compareQuietGreaterEqual`
operation according to [the general floating-point rules][F].

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

| Name           | Signature                | Families | Opcode
| ----           | ---------                | -------- | ------
| `i32.wrap/i64` | `(i64) : (i32)`          | [G]      | 0xa1

The `wrap` instruction returns the value of its operand silently wrapped to its
result type. Wrapping means reducing the value modulo the number of unique
values in the result type.

> This instruction corresponds to what is sometimes called an integer "truncate"
in other languages, however WebAssembly uses "truncate" to mean effectively
discarding the least significant bits, while "wrap" means effectively discarding
the most significant bits.

#### Integer Extend, Signed

| Name               | Signature            | Families | Opcode
| ----               | ---------            | -------- | ------
| `i64.extend_s/i32` | `(i32) : (i64)`      | [S]      | 0xa6

The `extend_s` instruction returns the value of its operand [sign-extended] to
its result type.

#### Integer Extend, Unsigned

| Name               | Signature            | Families | Opcode
| ----               | ---------            | -------- | ------
| `i64.extend_u/i32` | `(i32) : (i64)`      | [U]      | 0xa7

The `extend_u` instruction returns the value of its operand zero-extended to its
result type.

#### Truncate Floating-Point to Integer, Signed

| Name              | Signature             | Families | Opcode
| ----              | ---------             | -------- | ------
| `i32.trunc_s/f32` | `(f32) : (i32)`       | [F], [S] | 0x9d
| `i32.trunc_s/f64` | `(f64) : (i32)`       | [F], [S] | 0x9e
| `i64.trunc_s/f32` | `(f32) : (i64)`       | [F], [S] | 0xa2
| `i64.trunc_s/f64` | `(f64) : (i64)`       | [F], [S] | 0xa3

The `trunc_s` instruction performs the IEEE 754-2008
`convertToIntegerTowardZero` operation, with the result value interpreted as
signed, according to [the general floating-point rules][F].

**Trap:** Invalid Conversion, when a floating-point Invalid condition occurs,
due to the operand being outside the range that can be converted (including NaN
values and infinities).

#### Truncate Floating-Point to Integer, Unsigned

| Name              | Signature             | Families | Opcode
| ----              | ---------             | -------- | ------
| `i32.trunc_u/f32` | `(f32) : (i32)`       | [F], [U] | 0x9f
| `i32.trunc_u/f64` | `(f64) : (i32)`       | [F], [U] | 0xa0
| `i64.trunc_u/f32` | `(f32) : (i64)`       | [F], [U] | 0xa4
| `i64.trunc_u/f64` | `(f64) : (i64)`       | [F], [U] | 0xa5

The `trunc_u` instruction performs the IEEE 754-2008
`convertToIntegerTowardZero` operation, with the result value interpreted as
unsigned, according to [the general floating-point rules][F].

**Trap:** Invalid Conversion, when an Invalid condition occurs, due to the
operand being outside the range that can be converted (including NaN values and
infinities).

> This instruction's result is unsigned, so it almost always rounds down,
however it does round up in one place: negative values greater than negative one
truncate up to zero.

#### Floating-Point Demote

| Name             | Signature              | Families | Opcode
| ----             | ---------              | -------- | ------
| `f32.demote/f64` | `(f64) : (f32)`        | [F]      | 0xac

The `demote` instruction performs the IEEE 754-2008 `convertFormat` operation,
converting from its operand type to its result type, according to
[the general floating-point rules][F].

> This is a narrowing conversion which may round or overflow to infinity.

#### Floating-Point Promote

| Name              | Signature             | Families | Opcode
| ----              | ---------             | -------- | ------
| `f64.promote/f32` | `(f32) : (f64)`       | [F]      | 0xb2

The `promote` instruction performs the IEEE 754-2008 `convertFormat` operation,
converting from its operand type to its result type, according to
[the general floating-point rules][F].

> This is a widening conversion and is always exact.

#### Convert Integer To Floating-Point, Signed

| Name                | Signature           | Families | Opcode
| ----                | ---------           | -------- | ------
| `f32.convert_s/i32` | `(i32) : (f32)`     | [F], [S] | 0xa8
| `f32.convert_s/i64` | `(i64) : (f32)`     | [F], [S] | 0xaa
| `f64.convert_s/i32` | `(i32) : (f64)`     | [F], [S] | 0xae
| `f64.convert_s/i64` | `(i64) : (f64)`     | [F], [S] | 0xb0

The `convert_s` instruction performs the IEEE 754-2008 `convertFromInt`
operation, with its operand value interpreted as signed, according to
[the general floating-point rules][F].

#### Convert Integer To Floating-Point, Unsigned

| Name                | Signature           | Families | Opcode
| ----                | ---------           | -------- | ------
| `f32.convert_u/i32` | `(i32) : (f32)`     | [F], [U] | 0xa9
| `f32.convert_u/i64` | `(i64) : (f32)`     | [F], [U] | 0xab
| `f64.convert_u/i32` | `(i32) : (f64)`     | [F], [U] | 0xaf
| `f64.convert_u/i64` | `(i64) : (f64)`     | [F], [U] | 0xb1

The `convert_u` instruction performs the IEEE 754-2008 `convertFromInt`
operation, with its operand value interpreted as unsigned, according to
[the general floating-point rules][F].

#### Reinterpret

| Name                  | Signature         | Families | Opcode
| ----                  | ---------         | -------- | ------
| `i32.reinterpret/f32` | `(f32) : (i32)`   |          | 0xb4
| `i64.reinterpret/f64` | `(f64) : (i64)`   |          | 0xb5
| `f32.reinterpret/i32` | `(i32) : (f32)`   |          | 0xad
| `f64.reinterpret/i64` | `(i64) : (f64)`   |          | 0xb3

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

| Name        | Signature                                             | Families | Opcode
| ----        | ---------                                             | -------- | ------
| `i32.load`  | `<$offset: iPTR, $align: iPTR> ($base: iPTR) : (i32)` | [M], [G] | 0x2a
| `i64.load`  | `<$offset: iPTR, $align: iPTR> ($base: iPTR) : (i64)` | [M], [G] | 0x2b
| `f32.load`  | `<$offset: iPTR, $align: iPTR> ($base: iPTR) : (i32)` | [M], [Z] | 0x2c
| `f64.load`  | `<$offset: iPTR, $align: iPTR> ($base: iPTR) : (i64)` | [M], [Z] | 0x2d

The `load` instruction performs a [load](#loading) of the same size as its type.

Floating-point loads preserve all the bits of the value, performing an
IEEE 754-2008 `copy` operation.

**Validation:**
 - [Linear memory access validation](#linear-memory-access-validation)
   is performed.

#### Store

| Name        | Signature                                                       | Families | Opcode
| ----        | ---------                                                       | -------- | ------
| `i32.store` | `<$offset: iPTR, $align: iPTR> ($base: iPTR, $value: i32) : ()` | [M], [G] | 0x33
| `i64.store` | `<$offset: iPTR, $align: iPTR> ($base: iPTR, $value: i64) : ()` | [M], [G] | 0x34
| `f32.store` | `<$offset: iPTR, $align: iPTR> ($base: iPTR, $value: f32) : ()` | [M], [F] | 0x35
| `f64.store` | `<$offset: iPTR, $align: iPTR> ($base: iPTR, $value: f64) : ()` | [M], [F] | 0x36

The `store` instruction performs a [store](#storing) of `$value` of the same
size as its type.

Floating-point stores preserve all the bits of the value, performing an
IEEE 754-2008 `copy` operation.

**Validation:**
 - [Linear memory access validation](#linear-memory-access-validation)
   is performed.

#### Extending Load, Signed

| Name           | Signature                                             | Families | Opcode
| ----           | ---------                                             | -------- | ------
| `i32.load8_s`  | `<$offset: iPTR, $align: iPTR> ($base: iPTR) : (i32)` | [M], [S] | 0x20
| `i32.load16_s` | `<$offset: iPTR, $align: iPTR> ($base: iPTR) : (i32)` | [M], [S] | 0x22
|                |                                                       |          |
| `i64.load8_s`  | `<$offset: iPTR, $align: iPTR> ($base: iPTR) : (i64)` | [M], [S] | 0x24
| `i64.load16_s` | `<$offset: iPTR, $align: iPTR> ($base: iPTR) : (i64)` | [M], [S] | 0x26
| `i64.load32_s` | `<$offset: iPTR, $align: iPTR> ($base: iPTR) : (i64)` | [M], [S] | 0x28

The signed extending load instructions perform a [load](#loading) of narrower
width than their type, and return the value [sign-extended] to their type.
 - `load8_s` loads an 8-bit value.
 - `load16_s` loads a 16-bit value.
 - `load32_s` loads a 32-bit value.

**Validation:**
 - [Linear memory access validation](#linear-memory-access-validation)
   is performed.

#### Extending Load, Unsigned

| Name           | Signature                                             | Families | Opcode
| ----           | ---------                                             | -------- | ------
| `i32.load8_u`  | `<$offset: iPTR, $align: iPTR> ($base: iPTR) : (i32)` | [M], [U] | 0x21
| `i32.load16_u` | `<$offset: iPTR, $align: iPTR> ($base: iPTR) : (i32)` | [M], [U] | 0x23
|                |                                                       |          |
| `i64.load8_u`  | `<$offset: iPTR, $align: iPTR> ($base: iPTR) : (i64)` | [M], [U] | 0x25
| `i64.load16_u` | `<$offset: iPTR, $align: iPTR> ($base: iPTR) : (i64)` | [M], [U] | 0x27
| `i64.load32_u` | `<$offset: iPTR, $align: iPTR> ($base: iPTR) : (i64)` | [M], [U] | 0x29

The unsigned extending load instructions perform a [load](#loading) of narrower
width than their type, and return the value zero-extended to their type.
 - `load8_u` loads an 8-bit value.
 - `load16_u` loads a 16-bit value.
 - `load32_u` loads a 32-bit value.

**Validation:**
 - [Linear memory access validation](#linear-memory-access-validation)
   is performed.

#### Wrapping Store

| Name          | Signature                                                       | Families | Opcode
| ----          | ---------                                                       | -------- | ------
| `i32.store8`  | `<$offset: iPTR, $align: iPTR> ($base: iPTR, $value: i32) : ()` | [M], [G] | 0x2e
| `i32.store16` | `<$offset: iPTR, $align: iPTR> ($base: iPTR, $value: i32) : ()` | [M], [G] | 0x2f
|               |                                                                 |          |
| `i64.store8`  | `<$offset: iPTR, $align: iPTR> ($base: iPTR, $value: i64) : ()` | [M], [G] | 0x30
| `i64.store16` | `<$offset: iPTR, $align: iPTR> ($base: iPTR, $value: i64) : ()` | [M], [G] | 0x31
| `i64.store32` | `<$offset: iPTR, $align: iPTR> ($base: iPTR, $value: i64) : ()` | [M], [G] | 0x32

The wrapping store instructions performs a [store](#storing) of `$value`
silently wrapped to a narrower width.
 - `store8` stores an 8-bit value.
 - `store16` stores a 16-bit value.
 - `store32` stores a 32-bit value.

**Validation:**
 - [Linear memory access validation](#linear-memory-access-validation)
   is performed.

> See the note in the [wrap instruction](#integer-wrap) about the meaning of the
name "wrap".

### Additional Memory-Related Instructions

0. [Grow Memory](#grow-memory)
0. [Current Memory](#current-memory)

#### Grow Memory

| Name          | Signature                 | Families | Opcode
| ----          | ---------                 | -------- | ------
| `grow_memory` | `(iPTR) : (iPTR)`         | [R]      | 0x39

The `grow_memory` instruction increases the size of the referenced linear memory
space by a given unsigned delta, in units of [pages]. It returns the previous
linear memory size, also as an unsigned value in units of pages, or `-1` on
failure.

When a maximum memory size is declared in the referenced linear memory space,
`grow_memory` fails if it would grow past the maximum. However, `grow_memory`
may still fail before the maximum if it was not possible to reserve the space up
front or if enabling the reserved memory fails.

> Since the return value is in units of pages, `-1` is not otherwise a valid
memory size.

#### Current Memory

| Name             | Signature              | Families | Opcode
| ----             | ---------              | -------- | ------
| `current_memory` | `() : (iPTR)`          | [R]      | 0x3b

The `current_memory` instruction returns the size of the referenced linear
memory space, as an unsigned value in units of [pages].

[M]: #m-memory-access-instruction-family
[R]: #r-memory-resize-instruction-family
[B]: #b-branch-instruction-family
[L]: #l-call-instruction-family
[C]: #c-comparison-instruction-family
[T]: #t-shift-instruction-family
[G]: #g-generic-integer-instruction-family
[S]: #s-signed-integer-instruction-family
[U]: #u-unsigned-integer-instruction-family
[F]: #f-floating-point-instruction-family
[Z]: #z-floating-point-bitwise-instruction-family
[hamming weight]: https://en.wikipedia.org/wiki/Hamming_weight
[shifted]: https://en.wikipedia.org/wiki/Logical_shift
[shift count]: #shift-count
[two's complement sum]: https://en.wikipedia.org/wiki/Two%27s_complement#Addition
[two's complement difference]: https://en.wikipedia.org/wiki/Two%27s_complement#Subtraction
[two's complement product]: https://en.wikipedia.org/wiki/Two%27s_complement#Multiplication
[bitwise and]: https://en.wikipedia.org/wiki/Bitwise_operation#AND
[bitwise inclusive-or]: https://en.wikipedia.org/wiki/Bitwise_operation#OR
[bitwise exclusive-or]: https://en.wikipedia.org/wiki/Bitwise_operation#XOR
[Floor and Ceiling Functions]: https://en.wikipedia.org/wiki/Floor_and_ceiling_functions
[IEEE 754-2008]: https://en.wikipedia.org/wiki/IEEE_floating_point
[two's complement]: https://en.wikipedia.org/wiki/Two%27s_complement
[minimum signed integer value]: https://en.wikipedia.org/wiki/Two%27s_complement#Most_negative_number
[KiB]: https://en.wikipedia.org/wiki/Kibibyte
[bit]: https://en.wikipedia.org/wiki/Bit
[boolean]: #booleans
[true]: #booleans
[false]: #booleans
[sign-extend]: https://en.wikipedia.org/wiki/Sign_extension
[sign-extended]: https://en.wikipedia.org/wiki/Sign_extension
[bytes]: #bytes
[pages]: #pages
[effective address]: #effective-address
[little-endian byte order]: https://en.wikipedia.org/wiki/Endianness#Little.
[accessed bytes]: #accessed-bytes
[pop]: #type-stack-pop
[merge]: #control-flow-type-merge
[index]: #index
[array]: #array
[string]: #string
[strings]: #string
[type]: #types
[types]: #types
[typed]: #types
[control-flow type]: #control-flow-types
[control-flow types]: #control-flow-types
[forwarding control-flow type]: #forwarding-control-flow-type
[trap]: #instruction-traps
[rotated]: https://en.wikipedia.org/wiki/Bitwise_operation#Rotate_no_carry
[nondeterministic]: #nondeterminism
[nondeterministically]: #nondeterminism
[label]: #labels
[labels]: #labels

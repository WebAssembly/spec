# Exception handling

There are three sections to this proposal

1. A overview of the proposed extension to WebAssembly

2. Changes of the WebAssembly Binary Design document needed to include this
   proposal.

The proposal here is also meant to be a minimal proposal that may be further
extended sometime in the future.

## Overview

Exception handling allows code to break control flow when an exception is
thrown. The exception can be an exception known by the WebAssembly module, or it
may be an unknown exception thrown by an imported call.

Thrown exceptions are handled as follows:

a) They can be caught by a catch in an enclosing try block of a function body.

b) Throws not caught within a function body continue up the call chain until an
   enclosing try block is found.
   
c) If the call stack is exhausted without any enclosing try blocks, it terminates
   the application.

This proposal looks at the changes needed to incorporate these concepts into the
portable binary encoding of WebAssembly modules.

At the specification level, these changes do not infer whether an implementation
must implement lightweight or heavyweight exceptions. Rather, it defers that
choice to the runtime implementation.

Exception handling is defined using *exceptions*, *try blocks*, *catch blocks*,
and the instructions *throw* and *rethrow*.

### Exceptions

An _exception_ is an internal construct in WebAssembly.  Exceptions are
categorized into _exception types_. Each _exception type_ defines a unique kind
of exception. An exception is defined by its _exception type_, and a sequence of
values (i.e. integers and floats) that define the data fields of the exception.
The exception _type signature_ of an exception defines the value types of the
exception's data fields.

Exception types are defined in a new _exception type_ section of a WebAssembly
module. The _exception type_ section is a table of exception _type
signatures_. Each element in the table defines a different exception type, and
the corresponding exception type signature defines the corresponding data that
can be thrown for that exception type.

Exception types, in the exception type section, are referenced by both catch blocks
and throw instructions. The reference is an exception type _index_ that refers to
the corresponding exception type in the exception type section.

Note that multiple exception types can have the same exception _type
signature_. However, because they are separate entries in the exception type
section, they none the less represent different exception types.

Like functions, exception types can be imported and exported. In such cases, the
exceptions must be named, and also appear in the corresponding import/export
sections of the WebAssembly module. The runtime is responsible for connecting
exception types between WebAssembly modules, and the external environment (i.e.
Javascript).

Exceptions can also be thrown by called, imported functions. If it corresponds
to an imported exception, it can be caught in try blocks, as well as access the
data of the thrown exception. If the exception is not imported, it still can be
caught to allow code clean-up, but the data of the exception can't be accessed.

### Try and catch blocks.

A _try_ block defines a block of code that may need to catch exceptions and/or
clean up state when an exception is thrown. Each try block must end with one or
more _catch_ blocks. No instructions (in the try block) can appear between catch
blocks, or after the last catch block.

A try block may define more than one catch block, and all but the last catch block
must define an *exception type*. The exception type defines the type of
exception it catches. Catch blocks with an *exception type* are _typed_ catch
blocks. Each typed catch block, within a try block, must reference a different
exception type. The last catch block can either be typed, or it can be a
_default_ catch block. The default catch block has no exception type, and is
used to catch all exceptions not defined by any of the other catch blocks.

Try blocks, like a control-flow blocks, have a *block type*. The block type of a
try block defines the value yielded by the evaluation the try block when
either no exception is thrown, or the exception is successfully caught and the
code can recover and continue. The catch blocks, within a try block also have a
block type, and must be the same as the enclosing try block.

In the initial implementation, try and catch blocks may only yield 0 or 1
values.

Instruction validation checks that each catch block within a try block refer to
a different exception type (they must have different exception type indices), and
the exception types are defined in the exception type section of the module. It
also checks that the block type of the catch blocks is the same as the enclosing
try block. Further, it verifies that there aren't any instructions between the
catch blocks of the try block, and the last catch block is at the end of the try
block.

### Throws

The _throw_ instruction has a single immediate argument containing an
exception type index. This index defines the type of exception to throw. The
arguments to the thrown exception must be on top of the value stack, and must
correspond to the exception type signature of the exception.

**TODO** Define the order that the data fields of the exception should appear on
the value stack.

When an exception is thrown, the corresponding values are popped off the value
stack, and stored internally for access when the exception is caught.

If the throw appears within a try block, the value stack is popped back to
the size the value stack had when the try block was initially entered.

If a throw occurs within a function body, and it doesn't have an enclosing try
block, the throw continues up the call stack until either an enclosing try block
is found, or the call stack is flushed. If the call stack is flushed, execution
is terminated.

Otherwise, the call stack is wound back to the function with the nearest
enclosing try block. The value stack is then popped back to the size the value
stack had when that try block was initially entered.

If the throw appears within a catch block, it is treated as being outside the
corresponding try block of the catch (i.e. just after the end of corresponding
try block). Therefore, throws within the catch block can't be caught by their
enclosing try block. Rather, execution is thrown to the next enclosing try
block.

Once the value stack has been popped back to the size of the enclosing try block
(whether local or across function calls), control is then passed to the
appropriate catch block.

If there is a typed catch block with the same exception type _index_ as the
throw, the thrown values (stored internally at the throw) are copied back on the
value stack. Then, the corresponding typed catch block is entered. This allows
the values of the exception to be accessed by the catch block.

On the other hand, if there isn't a corresponding typed catch block, and there
is a default catch block, the default catch block is entered without pushing the
values of the exception onto the value stack. This allows the default catch
block to clean up state, but it can't look at the thrown value.

Finally, if there isn't a corresponding typed catch block, and there isn't a
default catch block, the except is automatically rethrown to the next enclosing
try block.

Also note that when the thrown exception is caught by a catch block, it is not
destroyed until the catch block is exited. This is done so that the catch block
can rethrow the exception.

If the selected catch block does not rethrow an exception, it must yield the
value(s) expected by the enclosing try block. For typed catch blocks, they must
also be sure to also pop off the caught exception values.

### Rethrows

The _rethrow_ instruction has no arguments, and can only appear in catch
blocks. It always re-throws the exception caught by the catch block. This allows
the catch block to clean up state before the exception is passed back to the
next enclosing try block.

### Debugging

Earlier discussion implied that when an exception is thrown, the runtime will
pop the value stack across function calls until a corresponding, enclosing try
block is found. The implementation may actually not do this. Rather, it may
first search up the call stack to see if there is an enclosing try. If none are
found, it could terminate the thread at that point of the throw. This would
allow better debugging capability, since the corresponding call stack is still
there to query.

## Changes to the binary model

This section describes changes in the binary encoding design document (ref?).

### Language types

A new type constructor '0x50' for exception types will be added.

All types are distinguished by a negative `varint7` values that is the first
byte of their encoding (representing a type constructor):

| Opcode | Type constructor |
|--------|------------------|
| `-0x01` (i.e., the byte `0x7f`) | `i32` |
| `-0x02` (i.e., the byte `0x7e`) | `i64` |
| `-0x03` (i.e., the byte `0x7d`) | `f32` |
| `-0x04` (i.e., the byte `0x7c`) | `f64` |
| `-0x10` (i.e., the byte `0x70`) | `anyfunc` |
| `-0x20` (i.e., the byte `0x60`) | `func` |
| `-0x30` (i.e., the byte `0x50`) | `except` |
| `-0x40` (i.e., the byte `0x40`) | pseudo type for representing an empty `block_type` |

### Exception type signatures

An exception type is described by its exception type signature as follows:

`except_type`

| Field | Type | Description |
|-------|------|-------------|
| count | `varuint32` | The number of arguments to the exception |
| value_types | `value_type*` | The type of each argument to the exception |

### External kind

`external_kind`

A single-byte unsigned integer indicating the kind of definition being imported or defined:

* `0` indicating a `Function` [import](Modules.md#imports) or [definition](Modules.md#function-and-code-sections)
* `1` indicating a `Table` [import](Modules.md#imports) or [definition](Modules.md#table-section)
* `2` indicating a `Memory` [import](Modules.md#imports) or [definition](Modules.md#linear-memory-section)
* `3` indicating a `Global` [import](Modules.md#imports) or [definition](Modules.md#global-section)
* `4` indicating an `Exception` *import* or *definition*

### Exception type section

The exception type section is the named section 'exception'. The exception type
section declares exception types using exception type signatures.

| Field | Type | Description |
|-------|------|-------------|
| count | `varuint32` | Count of the number of exception types to follow |
| entries | `except_type` | Repeated exception type signatures as described *above* |

### Import section

The import section is extended to include exception types by extending an
`import_entry` as follows:

If the `kind` is `Exception`:

| Field | Type | Description |
|-------|------|-------------|
| type  | `varuint32` | exception index to table in the *exception type section* |

### Export section

The export section is extended to include exception types by extending an
`export_entry` as follows:

* If the `kind` is `Exception`, then the `index` is into the corresponding
   exception type in the *exception type section*.

### Name section

The set of known values for `name_type` of a name section is extended as follows:


| Name Type | Code | Description |
| --------- | ---- | ----------- |
| [Function](#function-names) | `1` | Assigns names to functions |
| [Local](#local-names) | `2` | Assigns names to locals in functions |
| [Exception](#(exception-names) | `3` | Assigns names to exception types |

### Exception names

The exception names subsection is a `name_map` which assigns names to a subset
of the *exception type index* (both imports and module-defined).

### Control flow operators

The control flow operators are extended to define try blocks, catch blocks,
throws, and rethrows as follows:

| Name | Opcode | Immediates | Description |
| ---- | ---- | ---- | ---- |
| `unreachable` | `0x00` | | trap immediately |
| `nop` | `0x01` | | no operation |
| `block` | `0x02` | sig : `block_type` | begin a sequence of expressions, yielding 0 or 1 values |
| `loop` | `0x03` |  sig : `block_type` | begin a block which can also form control flow loops |
| `if` | `0x04` | sig : `block_type` | begin if expression |
| `else` | `0x05` | | begin else expression of if |
| `end` | `0x0b` | | end a block, loop, if, try, catch, and catch_default |
| `br` | `0x0c` | relative_depth : `varuint32` | break that targets an outer nested block |
| `br_if` | `0x0d` | relative_depth : `varuint32` | conditional break that targets an outer nested block |
| `br_table` | `0x0e` | see below | branch table control flow construct |
| `return` | `0x0f` | | return zero or one value from this function |
| `try` | 0x?? | sig : `block_type` | begins a block which can handle thrown exceptions |
| `catch` | 0x?? | sig : `block_type` , index : `varuint32` | begins a block when the exception type `index` is thrown |
| `catch_default` | 0x?? | sig : block_type | begins a block when an unknown exception is thrown |
| `throw` | 0x?? | index : `varuint32` | Throws an exception defined by the exception type `index` |
| `rethrow` | 0x?? | | re-throws the exception caught by the enclosing catch block |

The *sig* fields of `block', 'if`, `try`, `catch`, and `catch_default` operators
are block signatures which describe their use of the operand stack.

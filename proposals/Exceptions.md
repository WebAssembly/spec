# Exception handling

There are two sections to this proposal

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

a) They can be caught by a catch block in an enclosing try block of a function
   body.

b) Throws not caught within a function body continue up the call stack until an
   enclosing try block is found.
   
c) If the call stack is exhausted without any enclosing try blocks, it
   terminates the application.

This proposal looks at the changes needed to incorporate these concepts into the
portable binary encoding of WebAssembly modules.

At the specification level, these changes do not infer whether an implementation
must implement lightweight or heavyweight exceptions. Rather, it defers that
choice to the runtime implementation.

Exception handling is defined using *exceptions*, *try blocks*, *catch blocks*,
and the instructions *throw* and *rethrow*.

### Exceptions

An _exception_ is an internal construct in WebAssembly. Exceptions are defined
by a new _exception_ section of a WebAssembly module. The exception section is a
list of exceptions. Each exception has a _type signature_. The type signature
defines the list of values associated with an exception.

Within the module, exceptions are identified by an index into the exception
section.  This index is referred to as the _exception tag_.

Exceptions can be imported and exported by adding the appropriate entries to the
import and export sections of the module. All imported/exported exceptions must
be named to reconcile exception tags between modules.

Exception tags are used by throw and catch instructions. The throw instruction
uses the tag to allocate the exception with the corresponding data fields
defined by the exception's type signature. The catch instruction uses the tag to
identify if the thrown exception is one it can catch.

Exceptions can also be thrown by called, imported functions. If it corresponds
to an imported exception, it can be caught by an appropriate catch instruction.
If the exception is not imported, it still can be caught to allow code clean-up,
but the data of the exception can't be accessed.

### Try and catch blocks.

A _try_ block defines a list of instruction that may need to catch exceptions
and/or clean up state when an exception is thrown.  Like other higher-level
constructs, a try block begins with a `try` instruction, and ends with an `end`
instruction. That is, a try block is sequence of instructions having the
following form:

```
try
  instruction*
catch i
  instruction*
catch j
  instruction*
...
catch n
  instruction*
else
    instruction*
end
```

A try block may contain one or more catch blocks, and all but the last catch
block must begin with a`catch` instruction. The last catch block can begin with
either a `catch` or `else` instruction. The `catch`/`else` instructions (within
the try construct) are called the _catching_ instructions.

The _body_ of the try block is the list of instructions before the first
catching instruction. The _body_ of each catch block is the sequence of
instructions following the corresponding catching instruction, and the next
catching instruction (or the `end` instruction if it is the last catching
block).

The `catch` instruction has an exception tag associated with it. The tag
identifies what exceptions it can catch. That is, any exception created with the
corresponding exception tag. Catch blocks that begin with a `catch` instruction
are considered a _tagged_ catch block.

The last catch block of an exception can be a tagged catch block. Alternatively,
it can begin with the `else` instruction. If it begins with the `else`
instruction, it defines the _default_ catch block. The default catch block has
no exception type, and is used to catch all exceptions not caught by any of the
tagged catch blocks.

Try blocks, like a control-flow blocks, have a _block type_. The block type of a
try block defines the values yielded by the evaluation the try block when either
no exception is thrown, or the exception is successfully caught by one of its
catch blocks, and the instructions within the catch block can recover from the
throw.

In the initial implementation, try blocks may only yield 0 or 1 values.

### Throws

The _throw_ instruction has a single immediate argument, an exception tag.  The
exception tag is used to define the data fields of the allocated exception. The
values for the data fields must be on top of the value stack, and must
correspond to the exception type signature for the exception.

When an exception is thrown, the exception is allocated and the values on the
stack (corresponding to the type signature) are popped off and assigned to the
allocated exception.  The exception is stored internally for access when the
exception is caught. The runtime then searches for nearest enclosing try block
body that execution is in. That try block is called the _catching_ try block.

If the throw appears within the body of a try block, it is the catching try
block.

If a throw occurs within a function body, and it doesn't appear inside the body
of a try block, the throw continues up the call stack until it is in the body of
an an enclosing try block, or the call stack is flushed. If the call stack is
flushed, execution is terminated. Otherwise, the found enclosing try block is
the catching try block.

A throw inside a the body of a catch block is never caught by the corresponding
try block of the catch block, since instructions in the body of the catch block
are not in the body of the try block.

Once a catching try block is found for the throw, the value stack is popped back
to the size the value stack had when the try block was entered. Then, tagged
catch blocks are tried in the order they appear in the catching try block, until
one matches.

If a matched tagged catch block is found, control is transferred to the body of
the catch block, and the data fields of the exception are pushed back onto the
stack.

Otherwise, control is transferred to the body of the default catch
block. However, unlike tagged catch blocks, the constructor arguments are not
copied back onto the value stack.

If no tagged catch blocks were matched, and the catching try block doesn't have
a default catch block, the exception is re-thrown to the next enclosing try
block.

If control is transferred to the body of a catch block, and the last instruction
in the body is executed, control then exits the try block.

Also note that when the thrown exception is caught by a catch block, it is not
destroyed until the catch block is exited. This is done so that the catch block
can rethrow the exception.

If the selected catch block does not rethrow an exception, it must yield the
value(s) expected by the enclosing try block. For tagged catch blocks, they must
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

This section describes changes in
the
[binary encoding design document](https://github.com/WebAssembly/design/blob/master/BinaryEncoding.md).

### Exception type signatures

An exception is described by its exception type signature, which corresponds to
the function signature of the exception constructor. Hence, an exception _type
signature_ is a `func_type` that returns zero values.

Exception type signatures must appear in the type section.

### External kind

`external_kind`

A single-byte unsigned integer indicating the kind of definition being imported
or defined:

* `0` indicating a `Function` [import](Modules.md#imports) or [definition](Modules.md#function-and-code-sections)
* `1` indicating a `Table` [import](Modules.md#imports) or [definition](Modules.md#table-section)
* `2` indicating a `Memory` [import](Modules.md#imports) or [definition](Modules.md#linear-memory-section)
* `3` indicating a `Global` [import](Modules.md#imports) or [definition](Modules.md#global-section)
* `4` indicating an `Exception` [import](#import-section) or [definition](#exception-sectio)

### Exception section

The `exception` section is the named section 'exception'. The exception section
declares exception types using exception type signatures.

| Field | Type | Description |
|-------|------|-------------|
| count | `varuint32` | count of the number of exception types to follow |
| entries | `func_type` | sequence of indices into the type section |

### Import section

The import section is extended to include exception types by extending an
`import_entry` as follows:

If the `kind` is `Exception`:

| Field | Type | Description |
|-------|------|-------------|
| tag   | varuint32 | index into exception section |
| type  | `varuint32` | type index of the function signature |

### Export section

The export section is extended to include exception types by extending an
`export_entry` as follows:

If the `kind` is `Exception`, then the `index` is into the corresponding
exception in the _exception section_ index space.

### Name section

The set of known values for `name_type` of a name section is extended as
follows:


| Name Type | Code | Description |
| --------- | ---- | ----------- |
| [Function](#function-names) | `1` | Assigns names to functions |
| [Local](#local-names) | `2` | Assigns names to locals in functions |
| [Exception](#(exception-names) | `3` | Assigns names to exception types |

### Exception names

The exception names subsection is a `name_map` which assigns names to a subset
of the _exception_ indices from the exception section. (Used for both imports
and module-defined).

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
| `catch` | 0x?? | tag : `varuint32` | begins a block when the exception `tag` is thrown |
| `catch_default` | 0x?? | | begins a block when an unknown exception is thrown |
| `throw` | 0x?? | tag : `varuint32` | Throws an exception defined by the exception `tag` |
| `rethrow` | 0x?? | | re-throws the exception caught by the enclosing catch block |

The *sig* fields of `block', 'if`, and `try` operators are block signatures
which describe their use of the operand stack.

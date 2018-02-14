# Level 1 exception handling

Level 1 of exception handling is the MVP (minimal viable proposal) for
implementing exceptions in WebAssembly. As such, it doesn't include higher-level
concepts and structures. These concept and structures are introduced in later
levels, and either:

1. Improves readability by combining concepts in Level 1 into higher-level
   constructs, thereby reducing code size.
2. Allow performance improvements in the VM.
3. Introduce additional new functionality not available in Level 1.

This document supersedes the original [Exceptions Proposal].

[Exceptions Proposal]: https://github.com/WebAssembly/exception-handling/blob/master/proposals/Exceptions.md

## Overview

Exception handling allows code to break control flow when an exception is
thrown.  The exception can be any exception known by the WebAssembly module, or
it may an unknown exception that was thrown by a called imported function.

One of the problems with exception handling is that both WebAssembly and the
host VM probably have different notions of what exceptions are, but both must be
aware of the other.

It is difficult to define exceptions in WebAssembly because (in general)
it doesn't have knowledge of the host VM. Further, adding such knowledge to
WebAssembly would limit the ability for other host VMs to support WebAssembly
exceptions.

One issue is that both sides need to know if an exception was thrown by the
other, because cleanup may need to be performed.

Another problem is that WebAssembly doesn't have direct access to the host VM's
memory.  As a result, WebAssembly defers the handling of exceptions to the host
VM.

To access exceptions, WebAssembly provides instructions to check if the
exception is one that WebAssembly understands. If so, the data of the
WebAssembly exceptions's data is extracted and copied onto the stack, allowing
succeeding instructions to process the data.

Lastly, exception lifetimes must be maintained by the host VM, so that it can
collect and reuse the memory used by exceptions. This implies that the host must
know where exceptions are stored, so that it can determine when an exception can
be garbage collected.

This also implies that the host VM must provide a garbage collector for
exceptions.  For host VMs that have garbage collection (such as JavaScript),
this is not a problem.

However, not all host VMs may have a garbage collector. For this reason,
WebAssembly exceptions are designed to allow the use of reference counters to
perform the the garbage collection in the host VM.

To do this, WebAssembly exceptions are immutable once created, to avoid cyclic
data structures that can't be garbage collected. It also means that exceptions
can't be stored into linear memory. The rationale for this is twofold:

* For security. Loads
  and stores do not guarantee that the data read was of the same type as
  stored. This allows spoofing of exception references that may allow a
  WebAssembly module to access data it should not know in the host VM.
  
* The host VM does not know the layout of data in linear memory, so it can't
  find places where exception references are stored.

Hence, while an exception reference is a new first class type, this proposal
disallows their usage in linear memory.

A WebAssembly exception is created when you throw it with the `throw`
instruction. Thrown exceptions are handled as follows:

1. They can be caught by a catch block in an enclosing try block of a function
   body. The caught exception is pushed onto the stack.

1. Throws not caught within a function body continue up the call stack, popping
   call frames, until an enclosing try block is found.
   
1. If the call stack is exhausted without any enclosing try blocks, the host VM
   defines how to handle the uncaught exception.

### Exceptions

An `exception` is an internal construct in WebAssembly that is maintained by the
host. WebAssembly exceptions (as opposed to host exceptions) are defined by a
new `exception section` of a WebAssembly module. The exception section is a list
of exception definitions, from which exceptions can be created.

Each exception definition describe the structure of corresponding exception
values that can be generated from it. Exception definitions may also appear in
the import section of a module.

Each exception definition has a `type signature`. The type signature defines the
list of values associated with corresponding thrown exception values.

Within the module, exception definitions are identified by an index into the
[exception index space](#exception-index-space). This static index refers to the
corresponding runtime tag that uniquely identifies exception values created
using the exception definition, and is called the `exception tag`.

Each exception definition within a module (i.e. in the exception and import
section) are associated with unique exception tags.

Exception tags can also be exported by adding the appropriate descriptors in the
export section of the module. All imported/exported indices must be named to
reconcile the corresponding exception tag referenced by exception indices
between modules.

Exception indices are used by:

1. The `throw` instruction which creates a WebAssembly exception value
   with the corresponding exception tag, and then throws it.

2. The `if_except` instruction that queries an exception value to see if the
   exception tag corresponding to the module's exception index. If true it
   pushes the corresponding values of the exception onto the stack.
   
### The exception reference data type

Data types are extended to have a new `except_ref` type. The representation of
an exception value is left to the host VM.

### Try and catch blocks

A _try block_ defines a list of instructions that may need to process exceptions
and/or clean up state when an exception is thrown. Like other higher-level
constructs, a try block begins with a `try` instruction, and ends with an `end`
instruction. That is, a try block is sequence of instructions having the
following form:

```
try block_type
  instruction*
catch
  instruction*
end
```

A try block ends with a `catch block` that is defined by the list of
instructions after the `catch` instruction.

Try blocks, like control-flow blocks, have a _block type_. The block type of a
try block defines the values yielded by the evaluation the try block when either
no exception is thrown, or the exception is successfully caught by the catch
block.

In the initial implementation, try blocks may only yield 0 or 1 values.

### Throwing an exception

The `throw` instruction takes an exception index as an immediate argument.  That
index is used to identify the exception tag to use to create and throw the
corresponding exception value.

The values on top of the stack must correspond to the the type signature
associated with the exception index. These values are popped of the stack and
are used (along with the corresponding exception tag) to create the
corresponding exception value. That exception value is then thrown.

When an exception value is thrown, the host VM searches for nearest enclosing
try block body that execution is in. That try block is called the _catching_ try
block.

If the throw appears within the body of a try block, it is the catching try
block.

If a throw occurs within a function body, and it doesn't appear inside the body
of a try block, the throw continues up the call stack until it is in the body of
an an enclosing try block, or the call stack is flushed. If the call stack is
flushed, the host VM defines how to handle uncaught exceptions.  Otherwise, the
found enclosing try block is the catching try block.

A throw inside the body of a catch block is never caught by the corresponding
try block of the catch block, since instructions in the body of the catch block
are not in the body of the try block.

Once a catching try block is found for the thrown exception value, the operand
stack is popped back to the size the operand stack had when the try block was
entered, and then the values of the caught exception value is pushed onto the
stack.

If control is transferred to the body of a catch block, and the last instruction
in the body is executed, control then exits the try block.

If the selected catch block does not throw an exception, it must yield the
value(s) expected by the corresponding catching try block. This includes popping
the caught exception.

Note that a caught exception value can be rethrown using the `throw`
instruction.

### Rethrowing an exception

The `rethrow` instruction takes the exception value associated with the
`except_ref` on top of the stack, and rethrows the exception. A rethrow has the
same effect as a throw, other than an exception is not created. Rather, the
referenced exception value on top of the stack is popped and then thrown.

### Exception data extraction

The `if_except block` defines a conditional query of the exception value on top
of the stack. The exception value is not popped when queried. The if_except
block has two subblocks, the `then` and `else` subblocks, like that of an `if`
block. The then block is a sequence of instructions following the `if_except`
instruction. The else block is optional, and if it appears, it begins with the
`else` instruction.  The scope of the if_except block is from the `if_except`
instruction to the corresponding `end` instruction.

That is, the forms of an if_except block is:

```
if_except block_type except_index
  Instruction*
end

if_except block_type except_index
  Instruction*
else
  Instruction*
end
```

The conditional query of an exception succeeds when the exception value on the
top of the stack has the corresponding exception tag (defined by `except_index`).

If the query succeeds, the values (associated with the exception value) are
extracted and pushed onto the stack, and control transfers to the instructions
in the then block.

If the query fails, it either enters the else block, or transfer control to the
end of the if_except block if there is no else block.

### Debugging

Earlier discussion implied that when an exception is thrown, the runtime will
pop the operand stack across function calls until a corresponding, enclosing try
block is found. The implementation may actually not do this. Rather, it may
first search up the call stack to see if there is an enclosing try. If none are
found, it could terminate the thread at the point of the throw. This would
allow better debugging capability, since the corresponding call stack is still
there to query.

## Changes to the text format.

This section describes change in the
[instruction syntax document](https://github.com/WebAssembly/spec/blob/master/document/core/instructions.rst).

### New instructions

The following rules are added to *instructions*:

```
  try resulttype instruction* catch instruction* end |
  except except_index |
  throw except_index |
  rethrow |
  if_except resulttype except_index then instruction* end |
  if_except resulttype except_index then instruction* else instruction* end
```

Like the `block`, `loop`, and `if` instructions, the `try` and `if_except`
instructions are *structured* control flow instructions, and can be
labeled. This allows branch instructions to exit try and `if_except` blocks.

The `except_index` of the `throw` and `if_except` instructions defines the
exception value (and hence, exception tag) to create/extract form. See
[exception index space](#exception-index-space) for further clarification of
exception tags.

## Changes to Modules document.

This section describes change in the
[Modules document](https://github.com/WebAssembly/design/blob/master/Modules.md).

### Exception index space

The _exception index space_ indexes all imported and internally-defined
exceptions, assigning monotonically-increasing indices based on the order
defined in the import and exception sections. Thus, the index space starts at
zero with imported exceptions followed by internally-defined exceptions in
the [exception section](#exception-section).

The exception index space defines the (module) static version of runtine
exception tags. For exception indicies that are not imported/exported, the
corresponding exception tag is guaranteed to be unique over all loaded
modules.

For exception indices imported/exported, unique exception tags are created for
each unique name imported/exported, and are aliased to the corresponding
exception index defined in each module.

## Changes to the binary model

This section describes changes in
the
[binary encoding design document](https://github.com/WebAssembly/design/blob/master/BinaryEncoding.md).


### Data Types

#### except_ref

An exception reference points to an exception value. The size
is fixed, but unknown in WebAssembly (the host defines the size in bytes).

### Language Types

| Opcode | Type constructor |
|--------|------------------|
| -0x41  |  `except_ref`    |

#### value_type

A `varint7` indicating a `value_type` is extended to include `except_ref` as
encoded above.

#### Other Types

##### except_type

Each exception definition (defining an exception tag) has a type signature,
which corresponds to the data fields of the exception.

| Field | Type | Description |
|-------|------|-------------|
| `count` | `varuint32` | The number of types in the signature |
| `type` | `value_type*` | The type of each element in the signature |

Note: An `except_type` is not actually a type, just an exception definition that
corresponds to an exception tag. It is listed under `Other types` for
simplicity.

##### external_kind

A single-byte unsigned integer indicating the kind of definition being imported
or defined:

* `0` indicating a `Function` [import](Modules.md#imports) or [definition](Modules.md#function-and-code-sections)
* `1` indicating a `Table` [import](Modules.md#imports) or [definition](Modules.md#table-section)
* `2` indicating a `Memory` [import](Modules.md#imports) or [definition](Modules.md#linear-memory-section)
* `3` indicating a `Global` [import](Modules.md#imports) or [definition](Modules.md#global-section)
* `4` indicating an `Exception` [import](#import-section) or [definition](#exception-section)

### Module structure

#### High-level structure

A new `exception` section is introduced and is named `exception`. If included,
it must appear after immediately after the global section.

##### Exception section

The `exception` section is the named section 'exception'. The exception section
declares a list of exception definitions, defining corresponding exception tags.

| Field | Type | Description |
|-------|------|-------------|
| count | `varuint32` | count of the number of exceptions to follow |
| sig | `except_type*` | The type signature of the data fields for the tagged exception value |


##### Import section

The import section is extended to include exception definitions by extending an
`import_entry` as follows:

If the `kind` is `Exception`:

| Field | Type | Description |
|-------|------|-------------|
| `sig`  | `except_type` | the type signature of the exception |

##### Export section

The export section is extended to reference exception definitions by by
extending an `export_entry` as follows:

If the `kind` is `Exception`, then the `index` is into the corresponding
exception index in the [exception index space](#exception-index-space).


##### Name section

The set of known values for `name_type` of a name section is extended as
follows:

| Name Type | Code | Description |
| --------- | ---- | ----------- |
| [Function](#function-names) | `1` | Assigns names to functions |
| [Local](#local-names) | `2` | Assigns names to locals in functions |
| [Exception](#exception-names) | `3` | Assigns names to exception types |

###### Exception names

The exception names subsection is a `name_map` which assigns names to a subset
of the _exception_ indices from the exception section. (Used for both imports
and module-defined).

### Control flow operators

The control flow operators are extended to define try blocks, catch blocks,
throws, and rethrows as follows:

| Name | Opcode | Immediates | Description |
| ---- | ---- | ---- | ---- |
| `try` | `0x06` | sig : `block_type` | begins a block which can handle thrown exceptions |
| `catch` | `0x07` | | begins the catch block of the try block |
| `throw` | `0x08` | index : `varint32` | Creates an exception defined by the exception `index`and then throws it |
| `rethrow` | `0x09` | | Pops the `except_ref` on top of the stack and throws it |
| `if_except` | `0x0a` | sig : `block_type` , index : `varuint32` | Begin exception data extraction if exception on stack was created using the corresponding exception `index` |

The *sig* fields of `block`, `if`, `try` and `if_except` operators are block
signatures which describe their use of the operand stack.

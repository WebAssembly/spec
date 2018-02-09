# Layer 1 exception handling

Layer 1 of exception handling is the MVP (minimal viable proposal) for
implementing exceptions in WebAssembly. As such, it doesn't include higher-level
concepts and structures. These concept and structures are introduced in later
layers, and either:

1. Improves readability by combining concepts in layer 1 into higher-level
   constructs, thereby reducing code size.

2. Allow performance improvements in the VM.

3. Introduce additional new functionality not available in layer 1.
   
## Overview

Exception handling allows code to break control flow when an exception is
thrown.  The exeception can be any exception known by the WebAssembly module, or
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

A WebAssembly exception is created by the `except` instruction. Once an
exception is created, you can throw it with the `throw` instruction. Thrown
exceptions are handled as follows:

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
of exception types, from which exceptions can be created.

Each exception type has a `type signature`. The type signature defines the list
of values associated with the exception.

Within the module, exception types are identified by an index into the
[exception index space](#exception-index-space). This index is referred to as
the `exception tag`. The `tagged exception type` is the corresponding
exception type refered to by the exception tag.

Exception types can be imported and exported by adding the appropriate entries
to the import and export sections of the module. All imported/exported exception
types must be named to reconcile exception tags between modules.

Exception tags are used by:

1. The `except` instruction which creates a WebAssembly instance of the
   corresponding tagged exception type, and pushes a reference to it onto the
   stack.

2. The `if_except` instruction that queries an exception to see if it is an
   instance of the corresponding tagged exception class, and if true it pushes
   the corresponding values of the exception onto the stack.
   
### The exception refernce data type

Data types are extended to have a new `except_ref` type. The representation of
an exception type is left to the host VM, but its size must be fixed. The actual
number of bytes it takes to represent any `except_ref` is left to the host VM.

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

### Exception creation

A `except` instruction has a single immediate argument, an exception tag.  The
corresponding tagged exception type is used to define the data fields of the
created exception. The values for the data fields must be on top of the operand
stack, and must correspond to the exception's type signature.  These values are
popped off the stack and an instance of the exception is then created. A
reference to the created exception is then pushed onto the stack.

### Throws

The `throw` throws the exception on top of the stack. The exception is popped
off the top of the stack before throwing.

When an exception is thrown, the host VM searches for nearest enclosing try
block body that execution is in. That try block is called the _catching_ try
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

Once a catching try block is found for the throw, the operand stack is popped back
to the size the operand stack had when the try block was entered, and then
the caught exception is pushed onto the stack.

If control is transferred to the body of a catch block, and the last instruction
in the body is executed, control then exits the try block.

If the selected catch block does not throw an exception, it must yield the
value(s) expected by the corresponding catching try block. This includes popping
the caught exception.

Note that a caught exception can be rethrown using the `throw` instruction.

### Exception data extraction

The `if_except block` defines a conditional query of the exception on top of the
stack. The exception is not popped when queried. The if_except block has two
subblocks, the `then` and `else` subblocks, like that of an `if` block. The then
block is a sequence of instructions following the `if_except` instruction. The
else block is optional, and if it appears, it begins with the `else`
instruction.  The scope of the if_except block is from the `if_except`
instruction to the corresponding `end` instruction.

That is, the forms of an if_except block is:

```
if_except block_type except_index
  Instruction*
end

if_except block_type except_index
  Instruction*
else
  Instructions*
end
```

The conditional query of an exception succeeds when the exception on the top of
the stack is an instance of the corresponding tagged exception type (defined by
`except_index`).

If the query succeeds, the data values (associated with the type signature of
the exception class) are extracted and pushed onto the stack, and control
transfers to the instructions in the then block.

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
  try resulttype instructions* catch instructions* end |
  except except_index |
  throw |
  if_except resulttype except_index then Instructions* end |
  if_except resulttype except_index then Instructions* else Instructions* end
```

Like the `block`, `loop`, and `if` instructions, the `try` and `if_except`
instructions are *structured* control flow instructions, and can be
labeled. This allows branch instructions to exit try and `if_except` blocks.

The `except_index` of the `except` and `if_except` instructions defines the
exception type to create/extract form. See [exception index
space](#exception-index-space) for further clarification of exception tags.

## Changes to Modules document.

This section describes change in the
[Modules document](https://github.com/WebAssembly/design/blob/master/Modules.md).

### Exception index space

The _exception index space_ indexes all imported and internally-defined
exceptions, assigning monotonically-increasing indices based on the order
defined in the import and exception sections. Thus, the index space starts at
zero with imported exceptions followed by internally-defined exceptions in
the [exception section](#exception-section).

## Changes to the binary model

This section describes changes in
the
[binary encoding design document](https://github.com/WebAssembly/design/blob/master/BinaryEncoding.md).


### Data Types

#### except_ref

An exception reference pointing to an instance of an exception. The size
is fixed, but unknown in WebAssembly (the host defines the size in bytes).

### Language Types

| Opcode | Type constructor |
|--------|------------------|
| -0x41  |  `except_ref`    |

#### value_type

A `varint7` indicating a a `value type` is extended to include `except_ref` as
encoded above.

#### Other Types

##### except_type

An exception is described by its exception type signature, which corresponds to
the data fields of the exception.

| Field | Type | Description |
|-------|------|-------------|
| `count` | `varuint32` | The number of types in the signature |
| `type` | `value_type*` | The type of each element in the signature |


##### external_kind

A single-byte unsigned integer indicating the kind of definition being imported
or defined:

* `0` indicating a `Function` [import](Modules.md#imports) or [definition](Modules.md#function-and-code-sections)
* `1` indicating a `Table` [import](Modules.md#imports) or [definition](Modules.md#table-section)
* `2` indicating a `Memory` [import](Modules.md#imports) or [definition](Modules.md#linear-memory-section)
* `3` indicating a `Global` [import](Modules.md#imports) or [definition](Modules.md#global-section)
* `4` indicating an `Exception` [import](#import-section) or [definition](#exception-sectio)

### Module structure

#### High-level structure

A new `exception` section is introduced and is named `exception`. If included,
it must appear between the `Export` and `Start` sections of the module.


##### Exception section

The `exception` section is the named section 'exception'. The exception section
declares exception types using exception type signatures.

| Field | Type | Description |
|-------|------|-------------|
| count | `varuint32` | count of the number of exceptions to follow |
| sig | `except_type*` | The type signature of the data fields for each exception |


##### Import section

The import section is extended to include exception types by extending an
`import_entry` as follows:

If the `kind` is `Exception`:

| Field | Type | Description |
|-------|------|-------------|
| `sig`  | `except_type` | the type signature of the exception |

##### Export section

The export section is extended to include exception types by extending an
`export_entry` as follows:

If the `kind` is `Exception`, then the `index` is into the corresponding
exception in the [exception index space](#exception-index-space).


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
| `throw` | `0x08` | |Throws the exception on top of the stack |
| `except` | `0x09` | tag : varuint32 | Creates an exception defined by the exception tag and pushes reference on stack |
| `if_except` | `0x0a` | sig : `block_type` , tag : `varuint32` | Begin exception data extraction if exception on stack was created using the corresponding exception tag |

The *sig* fields of `block`, `if`, `try` and `if_except` operators are block
signatures which describe their use of the operand stack.

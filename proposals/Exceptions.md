# Exception handling

So far there have been two proposals ([first proposal](old/Exceptions.md),
[second proposal](old/Level-1.md)) proposed. We are going to use the second
proposal for the binary section spec, but we have not decided on which one to
use for the instruction part of the spec. This document describes status quo of
the exception handling proposal: for some parts we present both candidate
options until we fully decide.

---

## First Proposal - Instruction Part

Exception handling allows code to break control flow when an exception is
thrown. The exception can be an exception known by the WebAssembly module, or it
may be an unknown exception thrown by an imported call.

Thrown exceptions are handled as follows:

1. They can be caught by a catch block in an enclosing try block of a function
   body.

1. Throws not caught within a function body continue up the call stack until an
   enclosing try block is found.

1. If the call stack is exhausted without any enclosing try blocks, it
   terminates the application.

This proposal looks at the changes needed to incorporate these concepts into the
portable binary encoding of WebAssembly modules.

At the specification level, these changes do not infer whether an implementation
must implement lightweight or heavyweight exceptions. Rather, it defers that
choice to the runtime implementation.

Exception handling is defined using *exceptions*, *try blocks*, *catch blocks*,
and the instructions `throw` and `rethrow`.

### Exceptions

An _exception_ is an internal construct in WebAssembly. Exceptions are defined
by a new _exception_ section of a WebAssembly module. The exception section is a
list of exceptions. Each exception has a _type signature_. The type signature
defines the list of values associated with an exception.

Within the module, exceptions are identified by an index into the [exception
index space](#exception-index-space). This index references an _exception tag_.

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

A _try_ block defines a list of instructions that may need to catch exceptions
and/or clean up state when an exception is thrown. Like other higher-level
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
catch_all
    instruction*
end
```

A try block also contains one or more catch blocks, and all but the last catch
block must begin with a`catch` instruction. The last catch block can begin with
either a `catch` or `catch_all` instruction. The `catch`/`catch_all`
instructions (within the try construct) are called the _catching_ instructions.

The _body_ of the try block is the list of instructions before the first
catching instruction. The _body_ of each catch block is the sequence of
instructions following the corresponding catching instruction, and the next
catching instruction (or the `end` instruction if it is the last catching
block).

The `catch` instruction has an exception tag associated with it. The tag
identifies what exceptions it can catch. That is, any exception created with the
corresponding exception tag. Catch blocks that begin with a `catch` instruction
are considered _tagged_ catch blocks.

The last catch block of an exception can be a tagged catch block. Alternatively,
it can begin with the `catch_all` instruction. If it begins with the `catch_all`
instruction, it defines the _default_ catch block. The default catch block has
no exception type, and is used to catch all exceptions not caught by any of the
tagged catch blocks.

Try blocks, like control-flow blocks, have a _block type_. The block type of a
try block defines the values yielded by the evaluation the try block when either
no exception is thrown, or the exception is successfully caught by one of its
catch blocks, and the instructions within the catch block can recover from the
throw. Because `try` and `end` instructions define a control-flow block, they
can be targets for branches (`br` and `br_if`) as well.

In the initial implementation, try blocks may only yield 0 or 1 values.

### Throws

The `throw` instruction has a single immediate argument, an exception tag. The
exception tag is used to define the data fields of the allocated exception. The
values for the data fields must be on top of the operand stack, and must
correspond to the exception type signature for the exception.

When an exception is thrown, the exception is allocated and the values on the
stack (corresponding to the type signature) are popped off and assigned to the
allocated exception. The exception is stored internally for access when the
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

Once a catching try block is found for the throw, the operand stack is popped
back to the size the operand stack had when the try block was entered. Then,
tagged catch blocks are tried in the order they appear in the catching try
block, until one matches.

If a matched tagged catch block is found, control is transferred to the body of
the catch block, and the data fields of the exception are pushed back onto the
stack.

Otherwise, control is transferred to the body of the default catch block.
However, unlike tagged catch blocks, the constructor arguments are not copied
back onto the operand stack.

If no tagged catch blocks were matched, and the catching try block doesn't have
a default catch block, the exception is rethrown to the next enclosing try
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

The `rethrow` instruction can only appear in the body of a catch block. The
`rethrow` instruction always re-throws the exception caught by an enclosing
catch block. This allows the catch block to clean up state before the exception
is passed back to the next enclosing try block.

Associated with the `rethrow` instruction is a _label_. The label is used to
disambiguate which exception is to be rethrown, when inside nested catch blocks.

The label is the relative block depth to the corresponding try block for which
the catching block appears.

For example consider the following:

```
try
  ...
catch 1
  ...
  block
    ...
    try
      ...
    catch 2
      ...
      try
        ...
      catch 3
        ...
        rethrow N
      end
    end
  end
  ...
end
```

In this example, `N` is used to disambiguate which caught exception is being
rethrown. It could rethrow any of the three caught expceptions. Hence, `rethrow
0` corresponds to the exception caught by `catch 3`, `rethrow 1` corresponds to
the exception caught by `catch 2`, and `rethrow 3` corresponds to the exception
caught by `catch 1`.

Note that `rethrow 2` is not allowed because it does not reference a `try`
instruction. Rather, it references a `block` instruction.

### Debugging

Earlier discussion implied that when an exception is thrown, the runtime will
pop the operand stack across function calls until a corresponding, enclosing try
block is found. The implementation may actually not do this. Rather, it may
first search up the call stack to see if there is an enclosing try. If none are
found, it could terminate the thread at the point of the throw. This would allow
better debugging capability, since the corresponding call stack is still there
to query.

## Changes to the text format.

This section describes change in the [instruction syntax
document](https://github.com/WebAssembly/spec/blob/master/document/text/instructions.rst).

### Control Instructions

The following rule is added to *instructions*:

```
instructions ::=
  ...
  try resulttype instr* catch+ end |
  throw except_index |
  rethrow label

catch ::=
  catch except_index inst* |
  catch_all inst*
```

Like the `block`, `loop`, and `if` instructions, the `try` instruction is a
*structured* instruction, and is implicitly labeled. This allows branch
instructions to exit try blocks.

The `except_index` of the `catch` instruction denotes the exception tag for the
caught exception. Similarly, the `except_index` of the `throw` instruction
denotes the tag for the constructed exception. See [exception index
space](#exception-index-space) for further clarification of exception tags.

The `label` of the `rethrow` instruction is the label to the corresponding try
block, defining the catch to rethrow.

## Changes to the binary model

This section describes changes in the [binary encoding design
document](https://github.com/WebAssembly/design/blob/master/BinaryEncoding.md).

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
| `else` | `0x05` | | begin else expression of if or try  |
| `try` | `0x06` | sig : `block_type` | begins a block which can handle thrown exceptions |
| `catch` | `0x07` | tag : `varuint32` | begins a block when the exception `tag` is caught |
| `throw` | `0x08` | tag : `varuint32` | Throws an exception defined by the exception `tag` |
| `rethrow` | `0x09` | relative_depth : `varuint32` | re-throws the exception caught by the corresponding try block |
| `end` | `0x0b` | | end a block, loop, if, and try |
| `br` | `0x0c` | relative_depth : `varuint32` | break that targets an outer nested block |
| `br_if` | `0x0d` | relative_depth : `varuint32` | conditional break that targets an outer nested block |
| `br_table` | `0x0e` | see below | branch table control flow construct |
| `return` | `0x0f` | | return zero or one value from this function |

The *sig* fields of `block`, `if`, and `try` operators are block signatures
which describe their use of the operand stack.

Note that the textual `catch_all` instruction is implemented using the `else`
operator. Since the `else` operator is always unambiguous in the binary format,
there is no need to tie up a separate opcode for the `catch_all` instruction.


---

## Second Proposal - Instruction Part

Exception handling allows code to break control flow when an exception is
thrown. The exception can be any exception known by the WebAssembly module, or
it may an unknown exception that was thrown by a called imported function.

One of the problems with exception handling is that both WebAssembly and an
embedder have different notions of what exceptions are, but both must be aware
of the other.

It is difficult to define exceptions in WebAssembly because (in general) it
doesn't have knowledge of any embedder. Further, adding such knowledge to
WebAssembly would limit the ability for other embedders to support WebAssembly
exceptions.

One issue is that both sides need to know if an exception was thrown by the
other, because cleanup may need to be performed.

Another problem is that WebAssembly doesn't have direct access to an embedder's
memory. As a result, WebAssembly defers the handling of exceptions to the host
VM.

To access exceptions, WebAssembly provides instructions to check if the
exception is one that WebAssembly understands. If so, the data of the
WebAssembly exception is extracted and copied onto the stack, allowing
succeeding instructions to process the data.

Lastly, exception lifetimes may be maintained by the embedder, so that it can
collect and reuse the memory used by exceptions. This implies that an embedder
needs to know where exceptions are stored, so that it can determine when an
exception can be garbage collected.

This also implies that that embedders must provide a garbage collector for
exceptions. For embedders that have garbage collection (such as JavaScript),
this is not a problem.

However, not all embedders may have a garbage collector. For this reason,
WebAssembly exceptions are designed to allow other storage management methods,
such as reference counting, to perform the garbage collection in the embedder.

To do this, WebAssembly exceptions are immutable once created, to avoid cyclic
data structures that cannot easily be reference-counted. It also means that
exceptions can't be stored into linear memory. The rationale for this is
twofold:

* For security. Loads and stores do not guarantee that the data read was of the
  same type as stored. This allows spoofing of exception references that may
  allow a WebAssembly module to access data it should not know in the host VM.

* The embedder does not know the layout of data in linear memory, so it can't
  find places where exception references are stored.

Hence, while an exception reference is a new first class type, this proposal
disallows their usage in linear memory. The exception reference type can be
represented as a subtype of `anyref` type introduced in [WebAssembly reference
type
proposal](https://github.com/WebAssembly/reference-types/blob/master/proposals/reference-types/Overview.md).

A WebAssembly exception is created when you throw it with the `throw`
instruction. Thrown exceptions are handled as follows:

1. They can be caught by a catch block in an enclosing try block of a function
   body. The caught exception is pushed onto the stack.

1. Throws not caught within a function body continue up the call stack, popping
   call frames, until an enclosing try block is found.

1. If the call stack is exhausted without any enclosing try blocks, the embedder
   defines how to handle the uncaught exception.

### Event handling

This proposal adds exception handling to WebAssembly. Part of this proposal is
to define a new section to declare exceptions. However, rather than limiting
this new section to just defining exceptions, it defines a more general format
that allows the declaration of other forms of events.

In general, an event handler allows one to process an event generated by a block
of code. Events suspend the current execution and look for a corresponding event
handler. If found, the corresponding event handler is run. Some event handlers
may send values back to the suspended instruction, allowing the originating code
to resume.

Exceptions are a special case of an event in that they never resume. Similarly,
a throw instruction is the suspending event of an exception. The catch block
associated with a try block defines how to handle the throw.

WebAssembly events (i.e. exceptions) are defined by a new `event` section of a
WebAssembly module. The event section is a list of declared events associated
with the module.

Each event has an `attribute` and a `type`. Currently, the attribute can only
specify that the event is an exception. In the future, additional attribute
values may be added when other events are added to WebAssembly.

The type of an event is denoted by an index to a function signature defined in
the `type` section. The parameters of the function signature defines the list of
values associated with the exception event. The result type must be 'void'.

An `event tag` is a value to distinguish different events, while an `event
index` is a numeric name to refer to an (imported or defined) event tag within a
module (see [event index space](#event-index-space) for details).

### Exceptions

An `exception` is an internal construct in WebAssembly . WebAssembly exceptions
are defined in the `event` and import sections of a module. Each event (with an
exception attribute) defines an `exception`. The event index is also called the
`exception index`. Similarly, the corresponding event tag is called an
`exception tag`.

Exception indices are used by:

1. The `throw` instruction which creates a WebAssembly exception with the
   corresponding exception tag, and then throws it.

2. The `if_except` instruction queries an exception to see if the corresponding
   exception tag denoted by the exception index. If true it pushes the
   corresponding values of the exception onto the stack.

### The exception reference data type

Data types are extended to have a new `except_ref` type, that refers to an
exception. The representation of an exception is left to the implementation.

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
Try blocks, like control-flow blocks, have a _block type_. The block type of a
try block defines the values yielded by the evaluation the try block when either
no exception is thrown, or the exception is successfully caught by the catch
block. Because `try` and `end` instructions define a control-flow block, they
can be targets for branches (`br` and `br_if`) as well.

In the initial implementation, try blocks may only yield 0 or 1 values.

### Throwing an exception

The `throw` instruction takes an exception index as an immediate argument. That
index is used to identify the exception tag to use to create and throw the
corresponding exception.

The values on top of the stack must correspond to the type associated with the
exception. These values are popped of the stack and are used (along with the
corresponding exception tag) to create the corresponding exception. That
exception is then thrown.

When an exception is thrown, the embedder searches for the nearest enclosing try
block body that execution is in. That try block is called the _catching_ try
block.

If the throw appears within the body of a try block, it is the catching try
block.

If a throw occurs within a function body, and it doesn't appear inside the body
of a try block, the throw continues up the call stack until it is in the body of
an an enclosing try block, or the call stack is flushed. If the call stack is
flushed, the embedder defines how to handle uncaught exceptions. Otherwise, the
found enclosing try block is the catching try block.

A throw inside the body of a catch block is never caught by the corresponding
try block of the catch block, since instructions in the body of the catch block
are not in the body of the try block.

Once a catching try block is found for the thrown exception, the operand stack
is popped back to the size the operand stack had when the try block was entered,
and then an except_ref referring to the caught exception is pushed back onto the
operand stack.

If control is transferred to the body of a catch block, and the last instruction
in the body is executed, control then exits the try block.

If the selected catch block does not throw an exception, it must yield the
value(s) expected by the corresponding catching try block. This includes popping
the caught exception.

Note that a caught exception can be rethrown using the `rethrow` instruction.

### Rethrowing an exception

The `rethrow` instruction takes the exception associated with the `except_ref`
on top of the stack, and rethrows the exception. A rethrow has the same effect
as a throw, other than an exception is not created. Rather, the referenced
exception on top of the stack is popped and then thrown.

### Exception data extraction

The `if_except` block begins with an `if_except` instruction, and has two
instruction blocks,

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

In the first form, the instructions between the `if_except` and 'end' define the
`then block`. In the second form, the instructions between the `if_except` and
`else` define the `then block`, while the instructions between the `else` and
the `end` define the `else block`.

The conditional query of an exception checks the exception tag of exception on
top of the stack. It succeeds only if the exception index of the instruction
matches the corresponding exception tag. Once the query completes, the exception
is popped off the stack.

If the query succeeds the values (associated with the popped exception) are
extracted and pushed onto the stack, and control transfers to the instructions
in the then block.

If the query fails, it either enters the else block, or transfer control to the
end of the if_except block if there is no else block.

### Stack traces

When an exception is thrown, the runtime will pop the stack across function
calls until a corresponding, enclosing try block is found. It may also associate
a stack trace that can be used to report uncaught exceptions. However, the
details of this is left to the embedder.

## Changes to the text format.

This section describes change in the [instruction syntax
document](https://github.com/WebAssembly/spec/blob/master/document/core/instructions.rst).

### New instructions

The following rules are added to *instructions*:

```
  try resulttype instruction* catch instruction* end |
  throw except_index |
  rethrow |
  if_except resulttype except_index then instruction* end |
  if_except resulttype except_index then instruction* else instruction* end
```

Like the `block`, `loop`, and `if` instructions, the `try` and `if_except`
instructions are *structured* control flow instructions, and can be labeled.
This allows branch instructions to exit try and `if_except` blocks.

The `except_index` of the `throw` and `if_except` instructions defines the
exception (and hence, exception tag) to create/extract from. See [exception
index space](#exception-index-space) for further clarification of exception
tags.

## Changes to the binary model

This section describes changes in the [binary encoding design
document](https://github.com/WebAssembly/design/blob/master/BinaryEncoding.md).

### Data Types

#### except_ref

An exception reference points to an exception.

### Language Types

| Opcode | Type constructor |
|--------|------------------|
| -0x18  |  `except_ref`    |

#### value_type

A `varint7` indicating a `value_type` is extended to include `except_ref` as
encoded above.

### Control flow operators

The control flow operators are extended to define try blocks, catch blocks,
throws, and rethrows as follows:

| Name | Opcode | Immediates | Description |
| ---- | ---- | ---- | ---- |
| `try` | `0x06` | sig : `block_type` | begins a block which can handle thrown exceptions |
| `catch` | `0x07` | | begins the catch block of the try block |
| `throw` | `0x08` | index : `varint32` | Creates an exception defined by the exception `index`and then throws it |
| `rethrow` | `0x09` | | Pops the `except_ref` on top of the stack and throws it |
| `if_except` | `0x0a` |  index : `varuint32`, sig : `block_type` | Begin exception data extraction if exception on stack was created using the corresponding exception `index` |

The *sig* fields of `block`, `if`, `try` and `if_except` operators are block
signatures which describe their use of the operand stack.


---

## Common part

This part describes changes to the module and binary model. This part comes from
the [second proposal](old/Level-1.md) and we are going to use it for this part.

## Changes to Modules document.

This section describes change in the [Modules
document](https://github.com/WebAssembly/design/blob/master/Modules.md).

### Event index space

The `event index space` indexes all imported and internally-defined events,
assigning monotonically-increasing indices based on the order defined in the
import and event sections. Thus, the index space starts at zero with imported
events, followed by internally-defined events in the [event
section](#event-section).

The event index space defines the (module) static version of runtine event tags.
For event indices that are not imported/exported, the corresponding event tag is
guaranteed to be unique over all loaded modules. Events that are imported or
exported alias the respective events defined elsewhere, and use the same tag.

## Changes to the binary model

This section describes changes in the [binary encoding design
document](https://github.com/WebAssembly/design/blob/master/BinaryEncoding.md).

#### Other Types

##### event_type

The set of event attributes are:

| Name      | Value |
|-----------|-------|
| Exception | 0     |

Each event type has the fields:

| Field | Type | Description |
|-------|------|-------------|
| `attribute` | `varuint32` | The attribute of the event. |
| `type` | `varuint32` | The type index for its corresponding type signature |

##### external_kind

A single-byte unsigned integer indicating the kind of definition being imported
or defined:

* `0` indicating a `Function` [import](Modules.md#imports) or
[definition](Modules.md#function-and-code-sections)
* `1` indicating a `Table` [import](Modules.md#imports) or
[definition](Modules.md#table-section)
* `2` indicating a `Memory` [import](Modules.md#imports) or
[definition](Modules.md#linear-memory-section)
* `3` indicating a `Global` [import](Modules.md#imports) or
[definition](Modules.md#global-section)
* `4` indicating an `Event` [import](#import-section) or
[definition](#event-section)

### Module structure

#### High-level structure

A new `event` section is introduced and is named `event`. If included, it must
appear immediately after the global section.

##### Event section

The `event` section is the named section 'event'. For ease of validation, this
section comes after the [import
section](https://github.com/WebAssembly/design/blob/master/BinaryEncoding.md#import-section)
and before the [export
section](https://github.com/WebAssembly/design/blob/master/BinaryEncoding.md#export-section).
The event section declares a list of event types as follows:

| Field | Type | Description |
|-------|------|-------------|
| count | `varuint32` | count of the number of events to follow |
| type | `except_type*` | The definitions of the event types |

##### Import section

The import section is extended to include event definitions by extending an
`import_entry` as follows:

If the `kind` is `Event`:

| Field | Type | Description |
|-------|------|-------------|
| `type` | `event_type` | the event being imported |

##### Export section

The export section is extended to reference event types by extending an
`export_entry` as follows:

If the `kind` is `Event`:

| Field | Type | Description |
|-------|------|-------------|
| `index` | `varuint32` | the index into the corresponding event index space |

##### Name section

The set of known values for `name_type` of a name section is extended as
follows:

| Name Type | Code | Description |
| --------- | ---- | ----------- |
| [Function](#function-names) | `1` | Assigns names to functions |
| [Local](#local-names) | `2` | Assigns names to locals in functions |
| [Event](#event-names) | `3` | Assigns names to event types |

###### Event names

The event names subsection is a `name_map` which assigns names to a subset of
the event indices (Used for both imports and module-defined).


---

## Comparisons of the two proposals

- Proposal 2 introduces a first-class exception reference type. This raises several
  questions about exception lifetime management:
  - How do we manage exception objects' lifetime in non-GC embeddings? Do we
    make reference counting mandatory?
  - Who is responsible for deleting exception objects?
  - What should we do for except_ref values of invalid exception objects already
    deleted?
  - How should exception reference type be related to the existing reference
    type or GC proposal?
   
  Consequently, Proposal 1 would be simpler to implement for VMs which do not need
  reference types or related functionality such as GC objects.
  
- The first-class exception type makes Proposal 2 more expressive, possibly providing
  more flexibility for frontend developers for non-C langauges. In particular, allowing
  exception objects to escape catch blocks may simplify control flow translation.
  Conversely, it is slightly more complex for languages which do not have convenient ways to model
  reference types.

- In Proposal 2, the unwinder must stop at every call stack frame with `catch`
  instruction because the tag matching happens within a `catch` block, whereas
  in Proposal 1 the unwinder does not need to stop at call stack frames that
  do not contain `catch`s with the current exception's tag. Stopping at every
  call frame might degrade performance.

- It is suggested that Proposal 2 may be more compatible with effect handlers,
  which can be might be added to wasm in the future.

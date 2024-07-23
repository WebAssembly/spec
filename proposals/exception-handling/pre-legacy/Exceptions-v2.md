This V2 proposal was developed from [Level 1 Proposal](Exceptions-v2-Level-1.md)
and superseded [V1 proposal](Exceptions-v1.md). We decided to adopt this
proposal in [Oct 2018 CG
meeting](https://github.com/WebAssembly/meetings/blob/main/main/2018/TPAC.md#exception-handling-ben-titzer),
recognizing the need for a first-class exception type, based on the reasoning
that it is more expressive and also more extendible to other kinds of events.

This proposal was active from Oct 2018 to Sep 2020 and superseded by [V3
proposal](https://github.com/WebAssembly/exception-handling/blob/main/proposals/exception-handling/legacy/Exceptions.md).

---

# Exception handling

This proposal requires the following proposals as prerequisites.

- The [reference types proposal](https://github.com/WebAssembly/reference-types/blob/master/proposals/reference-types/Overview.md),
  since the [`exnref`](#the-exception-reference-data-type) type should be
  represented as a subtype of `anyref`.

- The [multi-value proposal](https://github.com/WebAssembly/multi-value/blob/master/proposals/multi-value/Overview.md),
  since otherwise the [`br_on_exn`](#exception-data-extraction) instruction
  would only work with exceptions that contain one value. Moreover, by using
  [multi-value](https://github.com/WebAssembly/multi-value/blob/master/proposals/multi-value/Overview.md),
  the [`try` blocks](#try-and-catch-blocks) may use values already in the stack,
  and also push multiple values onto the stack.

---

## Overview

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

This also implies that embedders must provide a garbage collector for
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

To allow for such a future extension possibility, we reserve a byte in the
binary format of an exception definition, set to 0 to denote an exception
attribute, but for the moment we won't use the term event in the formal spec.

### Exceptions

An `exception` is an internal construct in WebAssembly. WebAssembly exceptions
are defined in the event and import sections of a module.

The type of an exception is denoted by an index to a function signature defined
in the `type` section. The parameters of the function signature define the list
of values associated with the exception. The result type must be empty.

An `exception tag` is a value to distinguish different exceptions, while an
`exception index` is a numeric name to refer to an (imported or defined)
exception tag within a module (see [exception index
space](#exception-index-space) for details).

Exception indices are used by:

1. The `throw` instruction which creates a WebAssembly exception with the
   corresponding exception tag, and then throws it.

2. The `br_on_exn` instruction queries an exception to see if it matches the
   corresponding exception tag denoted by the exception index. If true it
   branches to the given label and pushes the corresponding argument values of
   the exception onto the stack.

### The exception reference data type

Data types are extended to have a new `exnref` type, that refers to an
exception. The representation of an exception is left to the implementation.

### Try and catch blocks

A _try block_ defines a list of instructions that may need to process exceptions
and/or clean up state when an exception is thrown. Like other higher-level
constructs, a try block begins with a `try` instruction, and ends with an `end`
instruction. That is, a try block is sequence of instructions having the
following form:

```
try blocktype
  instruction*
catch
  instruction*
end
```

A try block ends with a `catch block` that is defined by the list of
instructions after the `catch` instruction.

Try blocks, like control-flow blocks, have a _block type_. The block type of a
try block defines the values yielded by evaluating the try block when either no
exception is thrown, or the exception is successfully caught by the catch block.
Because `try` and `end` instructions define a control-flow block, they can be
targets for branches (`br` and `br_if`) as well.

In the initial implementation, try blocks may only yield 0 or 1 values.

### Throwing an exception

The `throw` instruction takes an exception index as an immediate argument. That
index is used to identify the exception tag to use to create and throw the
corresponding exception.

The values on top of the stack must correspond to the type associated with the
exception. These values are popped off the stack and are used (along with the
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
and then an `exnref` referring to the caught exception is pushed back onto the
operand stack.

If control is transferred to the body of a catch block, and the last instruction
in the body is executed, control then exits the try block.

If the selected catch block does not throw an exception, it must yield the
value(s) expected by the corresponding catching try block. This includes popping
the caught exception.

Note that a caught exception can be rethrown using the `rethrow` instruction.

### Rethrowing an exception

The `rethrow` instruction takes the exception associated with the `exnref` on
top of the stack, and rethrows the exception. A rethrow has the same effect as a
throw, other than an exception is not created. Rather, the referenced exception
on top of the stack is popped and then thrown. The `rethrow` instruction traps
if the value on the top of the stack is null.

### Exception data extraction

The `br_on_exn` instruction is a conditional branch that checks the exception
tag of an exception on top of the stack, in the form of:

```
br_on_exn label except_index
```

The `br_on_exn` instruction checks the exception tag of an `exnref` on top of
the stack if it matches the given exception index. If it does, it branches out
to the label referenced by the instruction (In the binary form, the label will
be converted to a relative depth immediate, like other branch instructions), and
while doing that, pops the `exnref` value from the stack and instead pushes the
exception's argument values on top of the stack. In order to use these popped
values, the block signature of the branch target has to match the exception
types - because it receives the exception arguments as branch operands. If the
exception tag does not match, the `exnref` value remains on the stack. For
example, when an `exnref` contains an exception of type (i32 i64), the target
block signature should be (i32 i64) as well, as in the following example:

```
block $l (result i32 i64)
  ...
  ;; exnref $e is on the stack at this point
  br_on_exn $l ;; branch to $l with $e's arguments
  ...
end
```

This can now be used to construct handler switches in the same way `br_table`
is used to construct regular switch:

```
block $end
  block $l1
    ...
      block $lN
        br_on_exn $l1
        ...
        br_on_exn $lN
        rethrow
      end $lN
      ;; handler for $eN here
      br $end
    ...
  end $l1
  ;; handler for $e1
end $end
```

If the query fails, the control flow falls through, and no values are pushed
onto the stack. The `br_on_exn` instruction traps if the value on the top of the
stack is null.

### Stack traces

When an exception is thrown, the runtime will pop the stack across function
calls until a corresponding, enclosing try block is found. It may also associate
a stack trace that can be used to report uncaught exceptions. However, the
details of this is left to the embedder.

### Traps and JS API

The `catch` instruction catches exceptions generated by the `throw` instruction,
but does not catch traps. The rationale for this is that in general traps are
not locally recoverable and are not needed to be handled in local scopes like
try-catch.

The `catch` instruction catches foreign exceptions generated from calls to
function imports as well, including JavaScript exceptions, with a few
exceptions:
1. In order to be consistent before and after a trap reaches a JavaScript frame,
   the `catch` instruction does not catch exceptions generated from traps.
1. The `catch` instruction does not catch JavaScript exceptions generated from
   stack overflow and out of memory.

Filtering these exceptions should be based on a predicate that is not observable
by JavaScript. Traps currently generate instances of
[`WebAssembly.RuntimeError`](https://webassembly.github.io/reference-types/js-api/#exceptiondef-runtimeerror),
but this detail is not used to decide type. Implementations are supposed to
specially mark non-catchable exceptions.
([`instanceof`](https://tc39.es/ecma262/#sec-instanceofoperator) predicate can
be intercepted in JS, and types of exceptions generated from stack overflow and
out of memory are implementation-defined.)

## Changes to the text format

This section describes change in the [instruction syntax
document](https://github.com/WebAssembly/spec/blob/master/document/core/text/instructions.rst).

### New instructions

The following rules are added to *instructions*:

```
  try blocktype instruction* catch instruction* end |
  throw (exception except_index) |
  rethrow |
  br_on_exn label (exception except_index)
```

Like the `block`, `loop`, and `if` instructions, the `try` instruction is
*structured* control flow instruction, and can be labeled. This allows branch
instructions to exit try blocks.

The `except_index` of the `throw` and `br_on_exn` instructions defines the
exception (and hence, exception tag) to create/extract from. See [exception
index space](#exception-index-space) for further clarification of exception
tags.

## Changes to Modules document

This section describes change in the [Modules
document](https://github.com/WebAssembly/design/blob/master/Modules.md).

### Exception index space

The `exception index space` indexes all imported and internally-defined
exceptions, assigning monotonically-increasing indices based on the order
defined in the import and exception sections. Thus, the index space starts at
zero with imported exceptions, followed by internally-defined exceptions in the
[exception section](#exception-section).

The exception index space defines the (module) static version of runtime
exception tags. For exception indices that are not imported/exported, the
corresponding exception tag is guaranteed to be unique over all loaded modules.
Exceptions that are imported or exported alias the respective exceptions defined
elsewhere, and use the same tag.

## Changes to the binary model

This section describes changes in the [binary encoding design
document](https://github.com/WebAssembly/design/blob/master/BinaryEncoding.md).

### Data Types

#### exnref

An exception reference points to an exception.

### Language Types

| Opcode | Type constructor |
|--------|------------------|
| -0x18  |  `exnref`        |

#### value_type

A `varint7` indicating a `value_type` is extended to include `exnref` as encoded
above.

#### Other Types

##### exception_type

We reserve a bit to denote the exception attribute:

| Name      | Value |
|-----------|-------|
| Exception | 0     |

Each exception type has the fields:

| Field | Type | Description |
|-------|------|-------------|
| `attribute` | `varuint32` | The attribute of an exception. |
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
* `4` indicating an `Exception` [import](#import-section) or
[definition](#exception-section)

### Module structure

#### High-level structure

A new `exception` section is introduced and is named `exception`. If included,
it must appear immediately after the memory section.

##### Exception section

The `exception` section is the named section 'exception'. For ease of
validation, this section comes after the [memory
section](https://github.com/WebAssembly/design/blob/master/BinaryEncoding.md#memory-section)
and before the [global
section](https://github.com/WebAssembly/design/blob/master/BinaryEncoding.md#global-section).
So the list of all sections will be:

| Section Name | Code | Description |
| ------------ | ---- | ----------- |
| Type | `1` | Function signature declarations |
| Import | `2` | Import declarations |
| Function | `3` | Function declarations |
| Table | `4` | Indirect function table and other tables |
| Memory | `5` | Memory attributes |
| Exception | `13` | Exception declarations |
| Global | `6` | Global declarations |
| Export | `7` | Exports |
| Start | `8` | Start function declaration |
| Element | `9` | Elements section |
| Code | `10` | Function bodies (code) |
| Data | `11` | Data segments |

The exception section declares a list of exception types as follows:

| Field | Type | Description |
|-------|------|-------------|
| count | `varuint32` | count of the number of exceptions to follow |
| type | `exception_type*` | The definitions of the exception types |

##### Import section

The import section is extended to include exception definitions by extending an
`import_entry` as follows:

If the `kind` is `Exception`:

| Field | Type | Description |
|-------|------|-------------|
| `type` | `exception_type` | the exception being imported |

##### Export section

The export section is extended to reference exception types by extending an
`export_entry` as follows:

If the `kind` is `Exception`:

| Field | Type | Description |
|-------|------|-------------|
| `index` | `varuint32` | the index into the corresponding exception index space |

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
of the exception indices (Used for both imports and module-defined).

### Control flow operators

The control flow operators are extended to define try blocks, catch blocks,
throws, and rethrows as follows:

| Name | Opcode | Immediates | Description |
| ---- | ---- | ---- | ---- |
| `try` | `0x06` | sig : `blocktype` | begins a block which can handle thrown exceptions |
| `catch` | `0x07` | | begins the catch block of the try block |
| `throw` | `0x08` | index : `varint32` | Creates an exception defined by the exception `index`and then throws it |
| `rethrow` | `0x09` | | Pops the `exnref` on top of the stack and throws it |
| `br_on_exn` | `0x0a` |  relative_depth : `varuint32`, index : `varuint32` | Branches to the given label and extracts data within `exnref` on top of stack if it was created using the corresponding exception `index` |

The *sig* fields of `block`, `if`, and `try` operators are block signatures
which describe their use of the operand stack.

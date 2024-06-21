# Exception handling

This explainer reflects the up-to-date version of the exception handling
proposal agreed on [Oct 2023 CG
meeting](https://github.com/WebAssembly/meetings/blob/main/main/2023/CG-10.md#exception-handling-vote-on-proposal-to-re-introduce-exnref).

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

A WebAssembly exception is created when you throw it with the `throw`
instruction. Thrown exceptions are handled as follows:

1. They can be caught by one of the *catch clauses* in an enclosing try block of
   a function body.

1. Throws not caught within a function body continue up the call stack, popping
   call frames, until an enclosing try block is found.

1. If the call stack is exhausted without any enclosing try blocks, the embedder
   defines how to handle the uncaught exception.

### Exception handling

This proposal adds exception handling to WebAssembly. Part of this proposal is
to define a new section to declare exceptions. However, rather than limiting
this new section to just defining exceptions, it defines a more general format
`tag` that allows the declaration of other forms of typed tags in future.

WebAssembly tags are defined in a new `tag` section of a WebAssembly module. The
tag section is a list of declared tags that are created fresh each time the
module is instantiated.

Each tag has an `attribute` and a `type`. Currently, the attribute can only
specify that the tag is for an exception. In the future, additional attribute
values may be added when other kinds of tags are added to WebAssembly.

To allow for such a future extension possibility, we reserve a byte in the
binary format of an exception definition, set to 0 to denote an exception
attribute.

### Exceptions

An `exception tag` is a value to distinguish different exceptions, while an
`exception tag index` is a numeric name to refer to an (imported or defined)
exception tag within a module (see [tag index space](#tag-index-space) for
details). Exception tags are declared in the tag and import sections of a
module.

An `exception` is an internal construct in WebAssembly that represents a runtime
object that can be thrown. A WebAssembly exception consists of an exception tag
and its runtime arguments.

The type of an exception tag is denoted by an index to a function signature
defined in the `type` section. The parameters of the function signature define
the list of argument values associated with the tag. The result type must be
empty.

Exception tag indices are used by:

1. The `throw` instruction which creates a WebAssembly exception with the
   corresponding exception tag, and then throws it.

2. Catch clauses use a tag to identify the thrown exception it can catch. If it
   matches, it pushes the corresponding argument values of the exception onto
   the stack.

### Exception references

When caught, an exception is reified into an _exception reference_, a value of
the new type `exnref`. Exception references can be used to rethrow the caught
exception.

### Try blocks

A _try block_ defines a list of instructions that may need to process exceptions
and/or clean up state when an exception is thrown. Like other higher-level
constructs, a try block begins with a `try_table` instruction, and ends with an
`end` instruction. That is, a try block is sequence of instructions having the
following form:

```
try_table blocktype catch*
  instruction*
end
```

A try block contains zero or more _catch clauses_. If there are no catch
clauses, then the try block does not catch any exceptions.

The _body_ of the try block is the list of instructions after the last catch
clause, if any.

Each `catch` clause can be in one of 4 forms:
```
catch tag label
catch_ref tag label
catch_all label
catch_all_ref label
```
All forms have a label which is branched to when an exception is caught (see
below). The former two forms have an exception tag associated with it that
identifies what exceptions it will catch. The latter two forms catch any
exception, so that they can be used to define a _default_ handler.

Try blocks, like control-flow blocks, have a _block type_. The block type of a
try block defines the values yielded by evaluating the try block when either no
exception is thrown, or the exception is successfully caught by the catch
clause. Because `try_table` defines a control-flow block, it can be targets for
branches (`br` and `br_if`) as well.

### Throwing an exception

The `throw` instruction takes an exception tag index as an immediate argument.
That index is used to identify the exception tag to use to create and throw the
corresponding exception.

The values on top of the stack must correspond to the type associated with the
exception tag. These values are popped off the stack and are used (along with
the corresponding exception tag) to create the corresponding exception. That
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

Once a catching try block is found for the thrown exception, the operand stack
is popped back to the size the operand stack had when the try block was entered
after possible block parameters were popped.

Then catch clauses are tried in the order they appear in the catching try block,
until one matches. If a matching catch clause is found, control is transferred
to the label of that catch clause. In case of `catch` or `catch_ref`, the
arguments of the exception are pushed back onto the stack. For `catch_ref` and
`catch_all_ref`, an exception reference is then pushed to the stack, which
represents the caught exception.

If no catch clauses were matched, the exception is implicitly rethrown.

Note that a caught exception can be rethrown explicitly using the `exnref` and
the `throw_ref` instruction.

### Rethrowing an exception

The `throw_ref` takes an operand of type `exnref` and re-throws the
corresponding caught exception. If the operand is null, a trap occurs.

### JS API

#### Traps

Catch clauses handle exceptions generated by the `throw` instruction, but do not
catch traps. The rationale for this is that in general traps are not locally
recoverable and are not needed to be handled in local scopes like try blocks.

The `try_table` instruction catches foreign exceptions generated from calls to
function imports as well, including JavaScript exceptions, with a few
exceptions:
1. In order to be consistent before and after a trap reaches a JavaScript frame,
   the `try_table` instruction does not catch exceptions generated from traps.
1. The `try_table` instruction does not catch JavaScript exceptions generated
   from stack overflow and out of memory.

Filtering these exceptions should be based on a predicate that is not observable
by JavaScript. Traps currently generate instances of
[`WebAssembly.RuntimeError`](https://webassembly.github.io/reference-types/js-api/#exceptiondef-runtimeerror),
but this detail is not used to decide type. Implementations are supposed to
specially mark non-catchable exceptions.
([`instanceof`](https://tc39.es/ecma262/#sec-instanceofoperator) predicate can
be intercepted in JS, and types of exceptions generated from stack overflow and
out of memory are implementation-defined.)

#### API additions

The following additional classes are added to the JS API in order to allow
JavaScript to interact with WebAssembly exceptions:

  * `WebAssembly.Tag`
  * `WebAssembly.Exception`

The `WebAssembly.Tag` class represents a typed tag defined in the tag section
and exported from a WebAssembly module. It allows querying the type of a tag
following the [JS type reflection
proposal](https://github.com/WebAssembly/js-types/blob/master/proposals/js-types/Overview.md).
Constructing an instance of `Tag` creates a fresh tag, and the new tag can be
passed to a WebAssembly module as a tag import.

In the future, `WebAssembly.Tag` may be used for other proposals that require a
typed tag and its constructor may be extended to accept other types and/or a tag
attribute to differentiate them from tags used for exceptions.

The `WebAssembly.Exception` class represents an exception thrown from
WebAssembly, or an exception that is constructed in JavaScript and is to be
thrown to a WebAssembly exception handler. The `Exception` constructor accepts a
`Tag` argument and a sequence of arguments for the exception's data fields. The
`Tag` argument determines the exception tag to use. The data field arguments
must match the types specified by the `Tag`'s type. The `is` method can be used
to query if the `Exception` matches a given tag. The `getArg` method allows
access to the data fields of a `Exception` if a matching tag is given. This last
check ensures that without access to a WebAssembly module's exported exception
tag, the associated data fields cannot be read.

The `Exception` constructor can take an optional `ExceptionOptions` argument,
which can optionally contain `traceStack` entry. When `traceStack` is `true`,
JavaScript VMs are permitted to attach a stack trace string to `Exception.stack`
field, as in JavaScript's `Error` class. `traceStack` serves as a request to the
WebAssembly engine to attach a stack trace; it is not necessary to honour if
`true`, but `trace` may not be populated if `traceStack` is `false`. While
`Exception` is not a subclass of JavaScript's `Error` and it can be used to
represent normal control flow constructs, `traceStack` field can be set when we
use it to represent errors. The format of stack trace strings conform to the
[WebAssembly stack trace
conventions](https://webassembly.github.io/spec/web-api/index.html#conventions).
When `ExceptionOption` is not provided or it does not contain `traceStack`
entry, `traceStack` is considered `false` by default.

To preserve stack trace info when crossing the JS to Wasm boundary, exceptions
can internally contain a stack trace, which is propagated when caught by a
`catch[_all]_ref` clause and rethrown by `throw_ref`.

More formally, the added interfaces look like the following:

```WebIDL
dictionary TagType {
  required sequence<ValueType> parameters;
};

[LegacyNamespace=WebAssembly, Exposed=(Window,Worker,Worklet)]
interface Tag {
  constructor(TagType type);
  TagType type();
};

dictionary ExceptionOptions {
  boolean traceStack = false;
};

[LegacyNamespace=WebAssembly, Exposed=(Window,Worker,Worklet)]
interface Exception {
  constructor(Tag tag, sequence<any> payload, optional ExceptionOptions options);
  any getArg(Tag tag, unsigned long index);
  boolean is(Tag tag);
  readonly attribute (DOMString or undefined) stack;
};
```

`TagType` corresponds to a `FunctionType` in [the type reflection
proposal](https://github.com/WebAssembly/js-types/blob/main/proposals/js-types/Overview.md),
without a `results` property). `TagType` could be extended in the future for
other proposals that require a richer type specification.

## Changes to the text format

This section describes change in the [instruction syntax
document](https://github.com/WebAssembly/spec/blob/master/document/core/text/instructions.rst).

### New instructions

The following rules are added to *instructions*:

```
  try_table blocktype catch* instruction* end |
  throw tag_index |
  throw_ref label |
```

Like the `block`, `loop`, and `if` instructions, the `try_table` instruction is
*structured* control flow instruction, and can be labeled. This allows branch
instructions to exit try blocks.

The `tag_index` of the `throw` and `catch[_ref]` clauses denotes the exception
tag to use when creating/extract from an exception. See [tag index
space](#tag-index-space) for further clarification of exception tags.

## Changes to Modules document

This section describes change in the [Modules
document](https://github.com/WebAssembly/design/blob/master/Modules.md).

### Tag index space

The `tag index space` indexes all imported and internally-defined exception
tags, assigning monotonically-increasing indices based on the order defined in
the import and tag sections. Thus, the index space starts at zero with imported
tags, followed by internally-defined tags in the [tag section](#tag-section).

For tag indices that are not imported/exported, the corresponding exception tag
is guaranteed to be unique over all loaded modules. Exceptions that are imported
or exported alias the respective exceptions defined elsewhere, and use the same
tag.

## Changes to the binary model

This section describes changes in the [binary encoding design
document](https://github.com/WebAssembly/design/blob/master/BinaryEncoding.md).

#### Other Types

##### exnref

The type `exnref` is represented by the type opcode `-0x17`.

When combined with the [GC
proposal](https://github.com/WebAssembly/gc/blob/main/proposals/gc/MVP.md),
there also is a value type `nullexnref` with opcode `-0x0c`. Furthermore, these
opcodes also function as heap type, i.e., `exn` is a new heap type with opcode
`-0x17`, and `noexn` is a new heap type with opcode `-0x0c`; `exnref` and
`nullexnref` are shorthands for `(ref null exn)` and `(ref null noexn)`,
respectively.

The heap type `noexn` is a subtype of `exn`. They are not in a subtype relation
with any other type (except bottom), such that they form a new disjoint
hierarchy of heap types.


##### tag_type

We reserve a bit to denote the exception attribute:

| Name      | Value |
|-----------|-------|
| Exception | 0     |

Each tag type has the fields:

| Field | Type | Description |
|-------|------|-------------|
| `attribute` | `uint8` | The attribute of a tag. |
| `type` | `varuint32` | The type index for its corresponding type signature |

##### external_kind

A single-byte unsigned integer indicating the kind of definition being imported
or defined:

* `4` indicating a `Tag`
[import](https://github.com/WebAssembly/design/blob/main/BinaryEncoding.md#import-section) or
[definition](#tag-section)

### Module structure

#### High-level structure

A new `tag` section is introduced.

##### Tag section

The `tag` section comes after the [memory
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
| Tag | `13` | Tag declarations |
| Global | `6` | Global declarations |
| Export | `7` | Exports |
| Start | `8` | Start function declaration |
| Element | `9` | Elements section |
| Data count | `12` | Data count section |
| Code | `10` | Function bodies (code) |
| Data | `11` | Data segments |

The tag section declares a list of tag types as follows:

| Field | Type | Description |
|-------|------|-------------|
| count | `varuint32` | count of the number of tags to follow |
| type | `tag_type*` | The definitions of the tag types |

##### Import section

The import section is extended to include tag definitions by extending an
`import_entry` as follows:

If the `kind` is `Tag`:

| Field | Type | Description |
|-------|------|-------------|
| `type` | `tag_type` | the tag being imported |

##### Export section

The export section is extended to reference tag types by extending an
`export_entry` as follows:

If the `kind` is `Tag`:

| Field | Type | Description |
|-------|------|-------------|
| `index` | `varuint32` | the index into the corresponding tag index space |

##### Name section

The set of known values for `name_type` of a name section is extended as
follows:

| Name Type | Code | Description |
| --------- | ---- | ----------- |
| [Function](#function-names) | `1` | Assigns names to functions |
| [Local](#local-names) | `2` | Assigns names to locals in functions |
| [Tag](#tag-names) | `11` | Assigns names to tags |

###### Tag names

The tag names subsection is a `name_map` which assigns names to a subset of the
tag indices (Used for both imports and module-defined).

### Control flow instructions

The control flow instructions are extended to define try blocks and throws as
follows:

| Name | Opcode | Immediates | Description |
| ---- | ---- | ---- | ---- |
| `try_table` | `0x1f` | sig : `blocktype`, n : `varuint32`, catch : `catch^n` | begins a block which can handle thrown exceptions |
| `throw` | `0x08` | index : `varuint32` | Creates an exception defined by the tag and then throws it |
| `throw_ref` | `0x0a` | | Pops an `exnref` from the stack and throws it |

The *sig* fields of `block`, `if`, and `try_table` instructions are block types
which describe their use of the operand stack.

A `catch` handler is a pair of tag and label index:

| Name    | Opcode | Immediates |
| ------- | ------ | ----------- |
| `catch` | `0x00` | tag : `varuint32`, label : `varuint32` |
| `catch_ref` | `0x01` | tag : `varuint32`, label : `varuint32` |
| `catch_all` | `0x02` | label : `varuint32` |
| `catch_all_ref` | `0x03` | label : `varuint32` |

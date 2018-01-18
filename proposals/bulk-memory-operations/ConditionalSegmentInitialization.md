# Proposal to conditionally initialize segments

This page describes a proposal for providing a mechanism to skip data or
element segment initialization when instantiating a module.

Although the following rationale applies only to data segments, this proposal
suggests that the proposed solutions apply to element segments as well for
consistency.

## Rationale

Under the current threading proposal, to share a module between multiple
agents, the module must be instantiated multiple times: once per agent.
Instantiation initializes linear memory with the contents in the module's data
segments. If the memory is shared between multiple agents, it will be
initialized multiple times, potentially overwriting stores that occurred after
the previous initializations.

For example:

```webassembly
;; The module.
(module
  (memory (export "memory") 1)

  ;; Some value used as a counter.
  (data (i32.const 0) "\0")

  ;; Add one to the counter.
  (func (export "addOne")
    (i32.store8
      (i32.const 0)
      (i32.add
        (i32.load8_u (i32.const 0))
        (i32.const 1)))
  )
)
```

```javascript
// main.js
let moduleBytes = ...;

WebAssembly.instantiate(moduleBytes).then(
  ({module, instance}) => {
    // Increment our counter.
    instance.exports.addOne();

    // Spawn a new Worker.
    let worker = new Worker('worker.js');

    // Send the module to the new Worker.
    worker.postMessage(module);
  });

// worker.js

function onmessage(event) {
  let module = event.data;

  // Use the module to create another instance.
  WebAssembly.instantiate(module).then(
    (instance) => {
      // Oops, our counter has been clobbered.
    });
}

```

This can be worked around by storing the data segments in a separate module
which is only instantiated once, then exporting this memory to be used by
another module that contains only code. This works, but it cumbersome since it
requires two modules where one should be enough.

## Proposal: New instructions to initialize data and element segments

The [binary format for the data section](https://webassembly.github.io/spec/binary/modules.html#data-section)
currently has a collection of segments, each of which has a memory index, an
initializer expression for its offset, and its raw data.

Since WebAssembly currently does not allow for multiple memories, the memory
index must be zero. We can repurpose this field as a flags field.

When the least-significant bit of the flags field is `1`, this segment is
_passive_. A passive segment will not be automatically copied into the
memory or table on instantiation, and must instead be applied manually using
the following new instructions:

* `mem.init`: copy a region from a data segment
* `table.init`: copy an region from an element segment

An passive segment has no initializer expression, since it will be specified
as an operand to `mem.init` or `table.init`.

Passive segments can also be discarded by using the following new instructions:

* `mem.drop`: prevent further use of a data segment
* `table.drop`: prevent further use of an element segment

Attempting to drop an active segment is a validation error.

The data section is encoded as follows:

```
datasec ::= seg*:section_11(vec(data))   => seg
data    ::= 0x00 e:expr b*:vec(byte)     => {data 0, offset e, init b*, active true}
data    ::= 0x01 b*:vec(byte)            => {data 0, offset empty, init b*, active false}
```

The element section is encoded similarly.

### `mem.init` instruction

The `mem.init` instruction copies data from a given passive segment into a target
memory. The source segment and target memory are given as immediates. The
instruction also has three i32 operands: an offset into the source segment, an
offset into the target memory, and a length to copy.

When `mem.init` is executed, its behavior matches the steps described in
step 11 of
[instantiation](https://webassembly.github.io/spec/exec/modules.html#instantiation),
but it behaves as though the segment were specified with the source offset,
target offset, and length as given by the `mem.init` operands.

A trap occurs if:
* the segment is passive
* the segment is used after it has been dropped via `mem.drop`
* any of the accessed bytes lies outside the source data segment or the target memory

Note that it is allowed to use `mem.init` on the same data segment more than
once.

### `mem.drop` instruction

The `mem.drop` instruction prevents further use of a given segment. After a
data segment has been dropped, it is no longer valid to use it in a `mem.init`
instruction. This instruction is intended to be used as an optimization hint to
the WebAssembly implementation. After a memory segment is dropped its data can
no longer be retrieved, so the memory used by this segment may be freed.

### `table.init` and `table.drop` instructions

The `table.init` and `table.drop` instructions behave similary to the
`mem.init` and `mem.drop` instructions, with the difference that they operate
on element segments and tables, instead of data segments and memories. The
offset and length operands of `table.init` have element units instead of bytes
as well.

### Example

Consider if there are two data sections, the first is always active and the
second is conditionally active if global 0 has a non-zero value. This could be
implemented as follows:

```webassembly
(import "a" "global" (global i32))  ;; global 0
(memory 1)
(data (i32.const 0) "hello")   ;; data segment 0, is active so always copied
(data passive "goodbye")       ;; data segment 1, is passive

(func $start
  (if (get_global 0)

    ;; copy data segment 1 into memory
    (mem.init 1
      (i32.const 0)     ;; source offset
      (i32.const 16)    ;; target offset
      (i32.const 7))    ;; length

    ;; The memory used by this segment is no longer needed, so this segment can
    ;; be dropped.
    (mem.drop 1))
)
```

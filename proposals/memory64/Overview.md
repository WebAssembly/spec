# Memory64

## Summary

This page describes a proposal to support linear memory of sizes larger than
2<sup>32</sup> bits. It provides no new instructions, but instead extends the
currently existing instructions to allow 64-bit indexes.

In addition, in order to support source languages with 64-bit pointer width,
this proposal also extends tables to allow 64-bit indexes.  This addition was
made during phase 3 of the proposal and we refer to this addition as "table64".

### Implementation Status

- spec interpreter: Done
- v8/chrome: [Done](https://chromium-review.googlesource.com/c/v8/v8/+/2679683)
- Firefox: Done
- Safari: ?
- wabt: [Done](https://github.com/WebAssembly/wabt/pull/1500)
- binaryen: [Done](https://github.com/WebAssembly/binaryen/pull/3202)
- emscripten: [Done](https://github.com/emscripten-core/emscripten/pull/17803)

### Implementation Status (table64)

- spec interpreter: [Done](https://github.com/WebAssembly/table64/53)
- v8/chrome: [WIP](https://issues.chromium.org/issues/338024338)
- Firefox: [WIP](https://bugzilla.mozilla.org/show_bug.cgi?id=1893643)
- Safari: -
- wabt: Done
- binaryen: Done
- emscripten: Done

## Motivation

[WebAssembly linear memory objects][memory object] have sizes measured in
[pages][memory page]. Each page is 65536 (2<sup>16</sup>) bytes. In WebAssembly
version 1, a linear memory can have at most 65536 pages, for a total of
2<sup>32</sup> bytes (4 [gibibytes][gibibyte]).

In addition to this page limit, all [memory instructions][] currently use the
[`i32` type][i32] as a memory index. This means they can address at most
2<sup>32</sup> bytes as well.

For many applications, 4 gibibytes of memory is enough. Using 32-bit memory
indexes is sufficient in this case, and has the additional benefit that
pointers in the producer language are smaller, which can yield memory savings.
However, for applications that need more memory than this, there are no easy
workarounds given the current WebAssembly feature set. Allowing the WebAssembly
module to choose between 32-bit and 64-bit memory indexes addresses both
concerns.

Similarly, since WebAssembly is a Virtual [Instruction Set Architecture][ISA]
(ISA), some hosts may want to use the WebAssembly binary format as a portable
executable format, in addition to supporting other non-virtual ISAs. Nearly all
ISAs have support for 64-bit memory addresses now, and a host may not want to
have to support 32-bit memory addresses in their ABI.

## Overview

### Structure

* The [limits][syntax limits] structure is changed to use `u64`
￼  - `limits ::= {min u64, max u64?}`

* A new `addrtype` can be either `i32` or `i64`
  - `addrtype ::= i32 | i64`

* The [memory type][syntax memtype] and [table type][syntax tabletype]
  structures are extended to include an address type
  - `memtype ::= addrtype limits`
  - `tabletype ::= addrtype limits reftype`

* The [memarg][syntax memarg] immediate is changed to allow a 64-bit offset
  - `memarg ::= {offset u64, align u32}`

### Validation

* Address types are classified by their value range:
  - ```
    ----------------
    ⊦ i32 : 2**16
    ```
  - ```
    ----------------
    ⊦ i64 : 2**48
    ```

* [Memory page limits][valid limits] and [Table entry limits][valid limits] are
  classified by their respective address types
  - ```
    ⊦ it : k    n <= k    (m <= k)?    (n < m)?
    -------------------------------------------
    ⊦ { min n, max m? } : it
    ```

* Memory and Table types are validated accordingly:
  - ```
    ⊦ limits : it
    --------------
    ⊦ it limits ok
    ```

* All [memory instructions][valid meminst] are changed to use the address type,
  and the offset must also be in range of the address type
  - t.load memarg
    - ```
      C.mems[0] = at limits   2**memarg.align <= |t|/8   memarg.offset < 2**|at|
      --------------------------------------------------------------------------
                          C ⊦ t.load memarg : [at] → [t]
      ```
  - t.loadN_sx memarg
    - ```
      C.mems[0] = at limits   2**memarg.align <= N/8   memarg.offset < 2**|at|
      ------------------------------------------------------------------------
                        C ⊦ t.loadN_sx memarg : [at] → [t]
      ```
  - t.store memarg
    - ```
      C.mems[0] = at limits   2**memarg.align <= |t|/8   memarg.offset < 2**|at|
      --------------------------------------------------------------------------
                         C ⊦ t.store memarg : [at t] → []
      ```
  - t.storeN_sx memarg
    - ```
      C.mems[0] = at limits   2**memarg.align <= N/8   memarg.offset < 2**|t|
      ------------------------------------------------------------------------
                       C ⊦ t.storeN_sx memarg : [at t] → []
      ```
  - memory.size
    - ```
         C.mems[0] = at limits
      ---------------------------
      C ⊦ memory.size : [] → [at]
      ```
  - memory.grow
    - ```
          C.mems[0] = at limits
      -----------------------------
      C ⊦ memory.grow : [at] → [at]
      ```
  - memory.fill
    - ```
          C.mems[0] = at limits
      -----------------------------
      C ⊦ memory.fill : [at i32 at] → []
      ```
  - memory.copy
    - ```
          C.mems[0] = at limits
      -----------------------------
      C ⊦ memory.copy : [at at at] → []
      ```
  - memory.init x
    - ```
          C.mems[0] = at limits   C.datas[x] = ok
      -------------------------------------------
          C ⊦ memory.init : [at i32 i32] → []
      ```
  - (and similar for memory instructions from other proposals)

* [Table instructions][valid tableinst] are changed to use the address type
  - call_indirect x y
    - ```
        C.tables[x] = at limits t  C.types[y] = [t1*] → [t2*]
      -------------------------------------------------------
      C ⊦ call_indirect x y : [t1* at] → [t2*]
      ```
  - table.get x
    - ```
        C.tables[x] = at limits t
      ------------------------------
      C ⊦ table.get x : [at] → [t]
      ```
  - table.set x
    - ```
        C.tables[x] = at limits t
      ------------------------------
      C ⊦ table.set x : [at t] → []
      ```
  - table.size x
    - ```
        C.tables[x] = at limits t
      ------------------------------
      C ⊦ table.size x : [] → [at]
      ```
  - table.grow x
    - ```
        C.tables[x] = at limits t
      -------------------------------
      C ⊦ table.grow x : [t at] → [at]
      ```
  - table.fill x
    - ```
        C.tables[x] = at limits t
      ----------------------------------
      C ⊦ tables.fill x : [at t at] → []
      ```
  - table.copy x y
    - ```
        C.tables[d] = aN limits t   C.tables[s] = aM limits t    K = min {aN, AM}
      -----------------------------------------------------------------------------
      C ⊦ table.copy d s : [aN aM aK] → []
      ```
  - table.init x y
    - ```
          C.tables[x] = at limits t   C.elems[y] = ok
      -----------------------------------------------
          C ⊦ table.init x y : [at i32 i32] → []
      ```

* The [SIMD proposal][simd] extends `t.load memarg` and `t.store memarg`
  above such that `t` may now also be `v128`, which accesses a 16-byte quantity
  in memory that is also 16-byte aligned.

  In addition to this, it also has these SIMD specific memory operations (see
  [SIMD proposal][simd] for full semantics):
  - `v128.loadN_zero memarg` (where N = 32/64):
    Load a single 32-bit or 64-bit element into the lowest bits of a `v128`
    vector, and initialize all other bits of the `v128` vector to zero.
  - `v128.loadN_splat memarg` (where N = 8/16/32/64):
    Load a single element and splat to all lanes of a `v128` vector. The natural
    alignment is the size of the element loaded.
  - `v128.loadN_lane memarg v128 immlaneidx` (where N = 8/16/32/64):
    Load a single element from `memarg` into the lane of the `v128` specified in
    the immediate mode operand `immlaneidx`. The values of all other lanes of
    the `v128` are bypassed as is.
  - `v128.storeN_lane memarg v128 immlaneidx` (where N = 8/16/32/64):
    Store into `memarg` the lane of `v128` specified in the immediate mode
    operand `immlaneidx`.
  - `v128.loadL_sx memarg` (where L is `8x8`/`16x4`/`32x2`, and sx is `s`/`u`):
    Fetch consecutive integers up to 32-bit wide and produce a vector with lanes
    up to 64 bits. The natural alignment is 8 bytes.

  All these operations now take 64-bit address operands when used with a
  64-bit memory.

* The [Threads proposal][threads] has `atomic` versions of `t.load`, `t.store`,
  (and `t.loadN_u` / `t.storeN_u`, no sign-extend) specified above, except with
  `.` replaced by `.atomic.`, and the guarantee of ordering of accesses being
  sequentially consistent.

  In addition to this, it has the following memory operations (see
  [Threads proposal][threads] for full semantics):
  - `t.atomic.rmwN.op_u memarg` (where t = 32/64, N = 8/16/32 when < t or empty
    otherwise, op is `add`/`sub`/`and`/`or`/`xor`/`xchg`/`cmpxchg`, and `_u`
    only present when N is not empty):
    The first 6 operations atomically read a value from an address, modify the
    value, and store the resulting value to the same address. They then return
    the value read from memory before the modify operation was performed.
    In the case of `cmpxchg`, the operands are an address, an expected value,
    and a replacement value. If the loaded value is equal to the expected value,
    the replacement value is stored to the same memory address. If the values
    are not equal, no value is stored. In either case, the loaded value is
    returned.
  - `memory.atomic.waitN` (where N = 32/64):
    The wait operator take three operands: an address operand, an expected
    value, and a relative timeout in nanoseconds as an `i64`. The return value
    is `0`, `1`, or `2`, returned as an `i32`.
  - `memory.atomic.notify`:
    The notify operator takes two operands: an address operand and a count as an
    unsigned `i32`. The operation will notify as many waiters as are waiting on
    the same effective address, up to the maximum as specified by count. The
    operator returns the number of waiters that were woken as an unsigned `i32`.

  All these operations now take 64-bit address operands when used with a
  64-bit memory.

* The [Multi-memory proposal][multi memory] extends each of these instructions
  with one or two memory index immediates. The address type for that memory will
  be used. For example,
  - memory.size x
    - ```
         C.mems[x] = at limits
      ---------------------------
      C ⊦ memory.size x : [] → [at]
      ```

  `memory.copy` has two memory index immediates, so will have multiple possible
  signatures:
  - memory.copy d s
    - ```
      C.mems[d] = aN limits   C.mems[s] = aM limits    K = min {aN, aM}
      ---------------------------------------------------------------
          C ⊦ memory.copy d s : [aN aM aK] → []
      ```

* [Data segment validation][valid data] uses the address type
  - ```
    C.mems[0] = at limits   C ⊦ expr: [at]   C ⊦ expr const
    -------------------------------------------------------
          C ⊦ {data x, offset expr, init b*} ok
    ```


### Execution

* [Memory instances][exec mem] are extended to have 64-bit vectors and a `u64`
  max size
  - `meminst ::= { data vec64(byte), max u64? }`

* [Memory instructions][exec meminst] use the address type instead of `i32`
  - `t.load memarg`
  - `t.loadN_sx  memarg`
  - `t.store memarg`
  - `t.storeN memarg`
  - `memory.size`
  - `memory.grow`
  - (spec text omitted)

* [memory.grow][exec memgrow] has behavior that depends on the address type:
  - for `i32`: no change
  - for `i64`: check for a size greater than 2<sup>64</sup> - 1, and return
    2<sup>64</sup> - 1 when `memory.grow` fails.

* [Memory import matching][exec memmatch] requires that the address type matches
  - ```
      at_1 = at_2   ⊦ limits_1 <= limits_2
    ----------------------------------------
    ⊦ mem at_1 limits_1 <= mem at_2 limits_2
    ```

* Bounds checking is required to be the same as for 32-bit memories, that is,
  the address + offset (a `u65`) of a load or store operation is required to be
  checked against the current memory size and trap if out of range.

  It is expected that the cost of this check remains low, if an implementation
  can implement the address check with a branch, and the offset separately using a
  guard page for all smaller offsets. Repeated accesses over the same address and
  different offsets allow simple elimination of subsequent checks.

### Binary format

* The [limits][binary limits] structure also encodes an additional value to
  indicate the address type
  - ```
    limits ::= 0x00 n:u32        ⇒ i32, {min n, max ϵ}, 0
            |  0x01 n:u32 m:u32  ⇒ i32, {min n, max m}, 0
            |  0x02 n:u32        ⇒ i32, {min n, max ϵ}, 1  ;; from threads proposal
            |  0x03 n:u32 m:u32  ⇒ i32, {min n, max m}, 1  ;; from threads proposal
            |  0x04 n:u64        ⇒ i64, {min n, max ϵ}, 0
            |  0x05 n:u64 m:u64  ⇒ i64, {min n, max m}, 0
            |  0x06 n:u64        ⇒ i64, {min n, max ϵ}, 1  ;; from threads proposal
            |  0x07 n:u64 m:u64  ⇒ i64, {min n, max m}, 1  ;; from threads proposal
    ```

* The [memory type][binary memtype] structure is extended to use this limits
  encoding
  - ```
    memtype ::= (at, lim, _):limits ⇒ at lim
    ```

* The [memarg][binary memarg]'s offset is read as `u64`
  - `memarg ::= a:u32 o:u64`

### Text format

*  There is a new address type:
   - ```
     addrtype ::= 'i32' ⇒ i32
               |  'i64' ⇒ i64
     ```

*  The [memory type][text memtype] definition is extended to allow an optional
   address type, which must be either `i32` or `i64`
   - ```
     memtype ::= lim:limits             ⇒ i32 lim
              |  at:addrtype lim:limits  ⇒ at lim
     ```

* The [memory abbreviation][text memabbrev] definition is extended to allow an
  optional address type too, which must be either `i32` or `i64`
  - ```
    '(' 'memory' id? address_type? '(' 'data' b_n:datastring ')' ')' === ...
    ```


[memory object]: https://webassembly.github.io/spec/core/syntax/modules.html#memories
[memory page]: https://webassembly.github.io/spec/core/exec/runtime.html#page-size
[gibibyte]: https://en.wikipedia.org/wiki/Gibibyte
[i32]: https://webassembly.github.io/spec/core/syntax/types.html#syntax-valtype
[memory instructions]: https://webassembly.github.io/spec/core/syntax/instructions.html#memory-instructions
[ISA]: https://en.wikipedia.org/wiki/Instruction_set_architecture
[syntax limits]: https://webassembly.github.io/spec/core/syntax/types.html#syntax-limits
[syntax tabletype]: https://webassembly.github.io/spec/core/syntax/types.html#table-types
[syntax memtype]: https://webassembly.github.io/spec/core/syntax/types.html#memory-types
[syntax memarg]: https://webassembly.github.io/spec/core/syntax/instructions.html#syntax-memarg
[valid limits]: https://webassembly.github.io/spec/core/valid/types.html#limits
[valid meminst]: https://webassembly.github.io/spec/core/valid/instructions.html#memory-instructions
[valid tableinst]: https://webassembly.github.io/spec/core/valid/instructions.html#table-instructions
[valid data]: https://webassembly.github.io/spec/core/valid/modules.html#data-segments
[exec mem]: https://webassembly.github.io/spec/core/exec/runtime.html#memory-instances
[exec meminst]: https://webassembly.github.io/spec/core/exec/instructions.html#memory-instructions
[exec memgrow]: https://webassembly.github.io/spec/core/exec/instructions.html#exec-memory-grow
[exec memmatch]: https://webassembly.github.io/spec/core/exec/modules.html#memories
[binary limits]: https://webassembly.github.io/spec/core/binary/types.html#limits
[binary memtype]: https://webassembly.github.io/spec/core/binary/types.html#memory-types
[binary memarg]: https://webassembly.github.io/spec/core/binary/instructions.html#binary-memarg
[text memtype]: https://webassembly.github.io/spec/core/text/types.html#text-memtype
[text memabbrev]: https://webassembly.github.io/spec/core/text/modules.html#text-mem-abbrev
[multi memory]: https://github.com/webassembly/multi-memory
[simd]: https://github.com/webassembly/simd
[threads]: https://github.com/webassembly/threads

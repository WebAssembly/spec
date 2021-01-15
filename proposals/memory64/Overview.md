# Memory64

## Summary

This page describes a proposal to support linear memory of sizes larger than
2<sup>32</sup> bits. It provides no new instructions, but instead extends the
currently existing instructions to allow 64-bit indexes.

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

* A new `idxtype` can be either `i32` or `i64`
  - `idxtype ::= i32 | i64`

* The [limits][syntax limits] structure is parameterised by index syntax
  - `limits_iv ::= {min iv, max iv?}`
  The parameter is omitted where it is immaterial.

* The [table type][syntax tabletype] continues to use i32 indices
  - `tabletype ::= limits_i32 elemtype`

* The [memory type][syntax memtype] structure is extended to have an index type
  - `memtype ::= idxtype limits_iv  (iff idxtype = type(iv))`
  - where
    ```
    type(\i32) = \I32
    type(\i64) = \I64
    ```

* The [memarg][syntax memarg] immediate is changed to allow a 64-bit offset
  - `memarg ::= {offset u64, align u32}`


### Validation

* Index types are classified by their value range:
  - ```
    ----------------
    ⊦ i32 : 2**16
    ```
  - ```
    ----------------
    ⊦ i64 : 2**48
    ```

* [Memory page limits][valid limits] are classified by their index types
  - ```
    ⊦ it : k    n <= k    (m <= k)?    (n < m)?
    -------------------------------------------
    ⊦ { min n, max m? } : it
    ```

* Memory types are validated accordingly:
  - ```
    ⊦ limits : it
    --------------
    ⊦ it limits ok
    ```

* All [memory instructions][valid meminst] are changed to use the index type,
  and the offset must also be in range of the index type
  - t.load memarg
    - ```
      C.mems[0] = it limits   2**memarg.align <= |t|/8   memarg.offset < 2**|it|
      --------------------------------------------------------------------------
                          C ⊦ t.load memarg : [it] → [t]
      ```
  - t.loadN_sx memarg
    - ```
      C.mems[0] = it limits   2**memarg.align <= N/8   memarg.offset < 2**|it|
      ------------------------------------------------------------------------
                        C ⊦ t.loadN_sx memarg : [it] → [t]
      ```
  - t.store memarg
    - ```
      C.mems[0] = it limits   2**memarg.align <= |t|/8   memarg.offset < 2**|it|
      --------------------------------------------------------------------------
                         C ⊦ t.store memarg : [it t] → []
      ```
  - t.storeN_sx memarg
    - ```
      C.mems[0] = it limits   2**memarg.align <= N/8   memarg.offset < 2**|it|
      ------------------------------------------------------------------------
                       C ⊦ t.storeN_sx memarg : [it t] → []
      ```
  - memory.size
    - ```
         C.mems[0] = it limits
      ---------------------------
      C ⊦ memory.size : [] → [it]
      ```
  - memory.grow
    - ```
          C.mems[0] = it limits
      -----------------------------
      C ⊦ memory.grow : [it] → [it]
      ```
  - memory.fill
    - ```
          C.mems[0] = it limits
      -----------------------------
      C ⊦ memory.fill : [it i32 it] → []
      ```
  - memory.copy
    - ```
          C.mems[0] = it limits
      -----------------------------
      C ⊦ memory.copy : [it it it] → []
      ```
  - memory.init x
    - ```
          C.mems[0] = it limits   C.datas[x] = ok
      -------------------------------------------
          C ⊦ memory.init : [it i32 i32] → []
      ```
  - (and similar for memory instructions from other proposals)

* The [Multi-memory proposal][multi memory] extends each of these instructions
  with one or two memory index immediates. The index type for that memory will
  be used. For example,
  - memory.size x
    - ```
         C.mems[x] = it limits
      ---------------------------
      C ⊦ memory.size x : [] → [it]
      ```

  `memory.copy` has two memory index immediates, so will have multiple possible
  signatures:
  - memory.copy d s
    - ```
      C.mems[d] = iN limits   C.mems[s] = iM limits    K = min {N, M}
      ---------------------------------------------------------------
          C ⊦ memory.copy d s : [iN iM iK] → []
      ```

* [Data segment validation][valid data] uses the index type
  - ```
    C.mems[0] = it limits   C ⊦ expr: [it]   C ⊦ expr const
    -------------------------------------------------------
          C ⊦ {data x, offset expr, init b*} ok
    ```


### Execution

* [Memory instances][exec mem] are extended to have 64-bit vectors and a `u64`
  max size
  - `meminst ::= { data vec64(byte), max u64? }`

* [Memory instructions][exec meminst] use the index type instead of `i32`
  - `t.load memarg`
  - `t.loadN_sx  memarg`
  - `t.store memarg`
  - `t.storeN memarg`
  - `memory.size`
  - `memory.grow`
  - (spec text omitted)

* [memory.grow][exec memgrow] has behavior that depends on the index type:
  - for `i32`: no change
  - for `i64`: check for a size greater than 2<sup>64</sup> - 1, and return
    2<sup>64</sup> - 1 when `memory.grow` fails.

* [Memory import matching][exec memmatch] requires that the index type matches
  - ```
      it_1 = it_2   ⊦ limits_1 <= limits_2
    ----------------------------------------
    ⊦ mem it_1 limits_1 <= mem it_2 limits_2
    ```


### Binary format

* The [limits][binary limits] structure also encodes an additional value to
  indicate the index type
  - ```
    limits ::= 0x00 n:u32        ⇒ i32, {min n, max ϵ}, 0
            |  0x01 n:u32 m:u32  ⇒ i32, {min n, max m}, 0
            |  0x02 n:u32        ⇒ i32, {min n, max ϵ}, 1  ;; from threads proposal
            |  0x03 n:u32 m:u32  ⇒ i32, {min n, max m}, 1  ;; from threads proposal
            |  0x04 n:u64        ⇒ i64, {min n, max ϵ}, 0
            |  0x05 n:u64 m:u64  ⇒ i64, {min n, max m}, 0
            |  0x06 n:u32        ⇒ i64, {min n, max ϵ}, 1  ;; from threads proposal
            |  0x07 n:u32 m:u32  ⇒ i64, {min n, max m}, 1  ;; from threads proposal
    ```

* The [memory type][binary memtype] structure is extended to use this limits
  encoding
  - ```
    memtype ::= (it, lim, _):limits ⇒ it lim
    ```

* The [memarg][binary memarg]'s offset is read as `u64`
  - `memarg ::= a:u32 o:u64`

### Text format

*  There is a new index type:
   - ```
     idxtype ::= 'i32' ⇒ i32
              |  'i64' ⇒ i64
     ```

*  The [memory type][text memtype] definition is extended to allow an optional
   index type, which must be either `i32` or `i64`
   - ```
     memtype ::= lim:limits             ⇒ i32 lim
              |  it:idxtype lim:limits  ⇒ it lim
     ```

* The [memory abbreviation][text memabbrev] definition is extended to allow an
  optional index type too, which must be either `i32` or `i64`
  - ```
    '(' 'memory' id? index_type? '(' 'data' b_n:datastring ')' ')' === ...
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

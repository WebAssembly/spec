# Sign-extension operators proposal for WebAssembly

This page describes a proposal for the post-MVP
[sign-extension operator feature][future sext].

This proposal adds five new integer instructions for sign-extending 8-bit,
16-bit, and 32-bit values.

## New Sign-extending Operators

To support sign-extending, five new sign-extension operators are added:

  * `i32.extend8_s`: extend a signed 8-bit integer to a 32-bit integer
  * `i32.extend16_s`: extend a signed 16-bit integer to a 32-bit integer
  * `i64.extend8_s`: extend a signed 8-bit integer to a 64-bit integer
  * `i64.extend16_s`: extend a signed 16-bit integer to a 64-bit integer
  * `i64.extend32_s`: extend a signed 32-bit integer to a 64-bit integer
  
Note that `i64.extend32_s` was not originally included when this proposal was
discussed in the May 2017 CG meeting. The reason given was that 
the behavior matches `i64.extend_s/i32`. It was later discovered that this is
not correct, as `i64.extend_s/i32` sign-extends an `i32` value to `i64`,
whereas `i64.extend32_s` sign-extends an `i64` value to `i64`. The behavior
of `i64.extend32_s` can be emulated with `i32.wrap/i64` followed by
`i64.extend_s/i32`, but the same can be said of the sign-extending load
operations. Therefore, `i64.extend32_s` has been added for consistency.

## [Spec Changes][spec]

The [instruction syntax][] is modified as follows:

```
instr ::= ... |
          inn.extend8_s | inn.extend16_s | i64.extend32_s
```

The [instruction binary format][] is modified as follows:

```
instr ::= ...
        | 0xC0                  =>  i32.extend8_s
        | 0xC1                  =>  i32.extend16_s
        | 0xC2                  =>  i64.extend8_s
        | 0xC3                  =>  i64.extend16_s
        | 0xC4                  =>  i64.extend32_s
```

[future sext]: https://github.com/WebAssembly/design/blob/main/FutureFeatures.md#additional-integer-operators
[instruction syntax]: https://webassembly.github.io/spec/syntax/instructions.html
[instruction binary format]: https://webassembly.github.io/spec/binary/instructions.html
[spec]: https://webassembly.github.io/sign-extension-ops/

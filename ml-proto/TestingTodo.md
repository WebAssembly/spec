This is a rough list of "tests to write". Everything here should either be
specified in
[AstSemantics.md](https://github.com/WebAssembly/design/blob/master/AstSemantics.md),
have a link to an open issue/PR, or be obvious. Comments/corrections/additions
welcome.

Misc semantics:
 - test that linear memory is little-endian for all integers and floats
 - test that unaligned and misaligned accesses work, even if slow
 - test that runaway recursion traps
 - test that too-big linear memory resize fails appropriately
 - test that too-big linear memory initial allocation fails
 - test that function addresses are monotonic indices, and not actual addresses.
 - test that one can clobber the entire contents of the linear memory without corrupting: call stack, global variables, local variables, program execution.

Operator semantics:
 - test that promote/demote, sext/trunc, zext/trunc is bit-preserving if not NaN
 - ~~test that clz/ctz handle zero~~
 - test that numbers slightly outside of the int32 range round into the int32 range in floating-to-int32 conversion
 - ~~test that neg, abs, copysign, reinterpretcast, store+load, set+get, preserve the sign bit and significand bits of NaN and don't canonicalize~~
 - ~~test that shifts don't mask their shift count. 32 is particularly nice to test.~~
 - test that `page_size` returns something sane [(power of 2?)](https://github.com/WebAssembly/design/pull/296)
 - test that arithmetic operands are evaluated left-to-right
 - ~~test that add/sub/mul/wrap/wrapping-store silently wrap on overflow~~
 - ~~test that sdiv/udiv/srem/urem trap on divide-by-zero~~
 - ~~test that sdiv traps on overflow~~
 - ~~test that srem doesn't trap when the corresponding sdiv would overflow~~
 - ~~test that float-to-integer conversion traps on overflow and invalid~~
 - ~~test that unsigned operations are properly unsigned~~

Floating point semantics:
 - ~~test for round-to-nearest rounding~~
 - ~~test for ties-to-even rounding~~
 - ~~test that all operations with floating point inputs correctly handle all their NaN, -0, 0, Infinity, and -Infinity special cases~~
 - ~~test that all operations that can overflow produce Infinity and with the correct sign~~
 - ~~test that all operations that can divide by zero produce Infinity with the correct sign~~
 - ~~test that all operations that can have an invalid produce NaN~~
 - test that all operations that can have underflow behave [correctly](https://github.com/WebAssembly/design/issues/148)
 - ~~test that nearestint doesn't do JS-style Math.round or C-style round(3) rounding~~
 - ~~test that signalling NaN doesn't cause weirdness~~
 - ~~test that signalling/quiet NaNs can have sign bits and payloads in literals~~
 - test that conversion from int32/int64 to float32 rounds correctly

Linear memory semantics:
 - test that loading from null works
 - test that loading from constant OOB traps and is not DCE'd or folded (pending [discussion](https://github.com/WebAssembly/design/blob/master/AstSemantics.md#out-of-bounds))
 - test that loading from "beyond the STACKPTR" succeeds
 - test that "stackptr + (linearmemptr - stackptr)" loads from linearmemptr.
 - test loading "uninitialized" things from aliased stack frames return what's there
 - test that loadwithoffset traps in overflow cases
 - test that newly allocated memory is zeroed
 - test that resize_memory does a full 32-bit unsigned check for page_size divisibility

Function pointer semantics:
 - test that function pointers work [correctly](https://github.com/WebAssembly/design/issues/89)

Expression optimizer bait:
 - test that `a+1<b+1` isn't folded to `a<b`
 - test that that demote-promote, wrap+sext, wrap+zext, shl+ashr, shl+lshr, div+mul, mul+div aren't folded away
 - test that converting int32 to float and back isn't folded away
 - test that converting int64 to double and back isn't folded away
 - test that `float(double(float(x))+double(y))` is not `float(x)+float(y)` (and so on for other operators)
 - test that `x*0.0` is not folded to `0.0`
 - test that `0.0/x` is not folded to `0.0`
 - test that signed integer div by negative constant is not ashr
 - test that signed integer div rounds toward zero
 - test that signed integer mod has the sign of the dividend
 - test unsigned and signed division by 3, 5, 7
 - test that floating-point division by immediate 0 and -0 is defined
 - test that ueq/one/etc aren't folded to oeq/une/etc.
 - test that floating point add/mul aren't reassociated even when tempting
 - test that floating point mul+add isn't folded to fma even when tempting
 - test that 1/x isn't translated into reciprocal-approximate
 - test that 1/sqrt(x) isn't approximated either
 - test that fp division by non-power-2 constant gets full precision (isn't a multiply-by-reciprocal deal)?

Misc optimizer bait:
 - test that the impl doesn't constant-fold away or DCE away or speculate operations that should trap, such as `1/0u`, `1/0`, `1%0u`, `1%0, convertToInt(NaN)`, `INT_MIN/-1` and so on.
 - test that likely constant folding uses the correct rounding mode
 - test that the scheduler doesn't move a trapping div past a call which may not return
 - test that redundant-load elimination, dead-store elimination, and/or store+load forwarding correctly respect interfering stores of different types (aka no TBAA)
 - test that linearized multidimensional array accesses can have overindexing in interesting ways
 - test that 32-bit loop induction variables that wrap aren't promoted to 64-bit

Misc x86 optimizer bait:
 - test that oeq handles NaN right in if, if-else, and setcc cases

Misc x87-isms:
 - ~~test for invalid Precision-Control-style x87 math~~
 - ~~test for invalid -ffloat-store-style x87 math~~
 - test for evaluating intermediate results at greater precision
 - test for loading and storing NaNs

Control flow:
 - test that continue goes to the right place in `do_while` and `forever`
 - test that break goes to the right place in all cases where it can appear
 - test devious switch case patterns

Validation errors:
 - load/store or variables with type void/bool/funcptr/etc.
 - sign-extend load from int64 to int32 etc.
 - fp-promote load and fp-demote store

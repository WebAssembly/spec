# Multi-value Extension

## Introduction

### Background

* Currently, functions and instructions consume multiple operands but can produce at most one result
  - functions: `value* -> value?`
  - instructions: `value* -> value?`
  - blocks: `[] -> value?`

* In a stack machine, these asymmetries are artificial restrictions
  - were imposed to simplify the initial WebAssembly release (multiple results deferred to post-MVP)
  - can easily be lifted by generalising to value* -> value*

* Generalised semantics is well-understood
  - https://github.com/WebAssembly/spec/tree/main/papers/pldi2017.pdf

* Semi-complete implementation of multiple results in V8


### Motivation

* Multiple return values for functions:
  - enable unboxing of tuples or structs returned by value
  - efficient compilation of multiple return values

* Multiple results for instructions:
  - enable instructions producing several results (divmod, arithmetics with carry)

* Inputs to blocks:
  - loop labels can have arguments
  - can represent phis on backward edges
  - enable future `pick` operator to cross block boundary
  - macro definability of instructions with inputs
    * `i32.select3` = `dup if ... else ... end`


## Examples

### Functions with multiple return Values

A simple swap function.
```wasm
(func $swap (param i32 i32) (result i32 i32)
	(local.get 1) (local.get 0)
)
```

An addition function returning an additional carry bit.
```wasm
(func $add64_u_with_carry (param $i i64) (param $j i64) (param $c i32) (result i64 i32)
	(local $k i64)
	(local.set $k
		(i64.add (i64.add (local.get $i) (local.get $j)) (i64.extend_i32_u (local.get $c)))
	)
	(return (local.get $k) (i64.lt_u (local.get $k) (local.get $i)))
)
```

### Instructions with multiple results

* `iNN.divrem` : \[iNN iNN\] -> \[iNN iNN\]
* `iNN.add_carry` : \[iNN iNN i32\] -> \[iNN i32\]
* `iNN.sub_carry` : \[iNN iNN i32\] -> \[iNN i32\]
* etc.


### Blocks with inputs

Conditionally manipulating a stack operand without using a local.
```wasm
(func $add64_u_saturated (param i64 i64) (result i64)
	(call $add64_u_with_carry (local.get 0) (local.get 1) (i32.const 0))
	(if (param i64) (result i64)
		(then (drop) (i64.const 0xffff_ffff_ffff_ffff))
	)
)
```

An iterative factorial function whose loop doesn't use locals, but uses arguments like phis.
```wasm
(func $pick0 (param i64) (result i64 i64)
	(local.get 0) (local.get 0)
)

(func $pick1 (param i64 i64) (result i64 i64 i64)
	(local.get 0) (local.get 1) (local.get 0)
)

(func $fac (param i64) (result i64)
	(i64.const 1) (local.get 0)
	(loop $l (param i64 i64) (result i64)
		(call $pick1) (call $pick1) (i64.mul)
		(call $pick1) (i64.const 1) (i64.sub)
		(call $pick0) (i64.const 0) (i64.gt_u)
		(br_if $l)
		(call $pick1) (return)
	)
)
```

Macro definition of an instruction expanding into an `if`.
```
i64.select3  =
     dup if (param i64 i64 i64 i32) (result i64) … select ... else … end
```

Macro expansion of `if` itself.
```
if (param t*) (result u*) A else B end  =
      block (param t* i32) (result u*)
          block (param t* i32) (result t*) (br_if 0)  B  (br 1) end  A
      end
```


## Spec Changes

### Structure

The structure of the language is mostly unaffected. The only changes are to the type syntax:

* *resulttype* is generalised from \[*valtype*?\] to \[*valtype*\*\]
* block types (in `block`, `loop`, `if` instructions) are generalised from *resulttype* to *functype*


### Validation

Arity restrictions are removed:

* no arity check is imposed for valid *functype*
* all occurrences of superscript "?" are replaced with superscript "\*" (e.g. blocks, calls, return)

Validation for block instructions is generalised:

* The type of `block`, `loop`, and `if` is the *functype* \[t1\*\] -> \[t2\*\] given as the block type
* The type of the label of `block` and `if` is \[t2\*\]
* The type of the label of `loop` is \[t1\*\]


### Execution

Nothing much needs to be done for multiple results:

* replace all occurrences of superscript "?" with superscript "\*".

The only non-mechanical change involves entering blocks with operands:

* The operand values are popped of the stack, and pushed right back after the label.
* See paper for formulation of formal reduction rules


### Binary Format

The binary requires a change to allow function types as block types. That requires extending the current ad-hoc encoding to allow references to function types.

* `blocktype` is extended to the following format:
  ```
  blocktype ::= 0x40       => [] -> []
             |  t:valtype  => [] -> [t]
             |  ft:typeidx => ft
  ```

### Text Format

The text format is mostly unaffected, except that the syntax for block types is generalised:

* `resulttype` is replaced with `blocktype`, whose syntax is
  ```
  blocktype ::= vec(param) vec(result)
  ```

* `block`, `loop`, and `if` instructions contain a `blocktype` instead of `resulttype`.

* The existing abbreviations for functions apply to block types.


### Soundness Proof

The typing of administrative instructions need to be generalised, see the paper.


## Possible Alternatives and Extensions

### More Flexible Block and Function Types

* Instead of inline function types, could use references to the type section
  - more bureaucracy in the semantics, but otherwise no problem

* Could also allow both
  - inline function types are slightly more compact for one-off uses

* Could even unify the encoding of block types with function types everywhere
  - allow inline types even for functions, for the same benefits


## Open Questions

* Destructuring or reshuffling multiple values requires locals, is that enough?
  - could add `pick` instruction (generalised `dup`)
  - could add `let` instruction (if you squint, a generalised `swap`)
  - different use cases?


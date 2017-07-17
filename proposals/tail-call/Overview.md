# Tail Call Extension

## Introduction

### Motivation

* Currently, the Wasm design explicitly forbids tail call optimisations

* Want support to enable
  - the correct and efficient implementations of languages that require tail call elimination
  - the compilation of control constructs that can be implemented with it (e.g., forms of coroutines, continuations)
  - compilation and optimization techniques that require it (e.g., dynamic recompilation, tracing, CPS)
  - other sorts of computation being expressed as Wasm functions, e.g., FSMs


### Semantics

Conceptually, tail-calling a function unwinds the current call frame before performing the actual call.
This can be applied to any form of call, that is:

* Caller and callee can differ
* Caller and callee type can differ
* Callee may be dynamic (e.g., `call_indirect`)


## Design Space

### Instructions

* Tail calls should be explicit instructions (current instructions explicitly disallow TCE)

* Two possible schemes:
  1. introduce tail version of every call instruction
  2. introduce single prefix instruction that can be applied to every call instruction

Note: WebAssembly will likely get more call instructions in the future, e.g., `call_ptr`.


### Typing

* Two options:
  1. All functions are tail-callable
  2. Tail-callable functions are distinguished by type

Option 2 allows different calling conventions for non-tail-callable functions, which may be reduce constraints on ABIs.
On the other hand, it creates a bifurcated function space, which might lead to difficulties e.g. when using function tables or other forms of dynamic indirection.


## Examples

A simple boring example of a tail-recursive factorial funciton.
```
(func $fac (param $x i64) (result i64)
	(return_call $fac-aux (get_local $x) (i64.const 1))
)

(func $fac-aux (param $x i64) (param $r i64) (result i64)
	(if (i64.eqz (get_local $x))
		(then (return (get_local $r)))
		(else
			(return_call $fac-aux
				(i64.sub (get_local $x) (i64.const 1))
				(i64.mul (get_local $x) (get_local $r))
			)
		)
	)
)

```


## Spec Changes

For now, we assume that separate instructions are introduced.
It is not difficult to adapt the rules to an alternative design with instruction prefixes.

### Structure

Add two instructions (for now):

* `return_call x`, the tail-call version of `call`
* `return_call_indirect x`, the tail-call version of `call_indirect`


### Validation

Validation of the new instructions is simply a combination of the typing rules for `return` and those for basic calls (and thus is stack-polymorphic).

* If `x` refers to a function of type \[t1\*\] -> \[t2\*\],
  then the instruction `return_call x` has type \[t3\* t1\*\] -> \[t4\* t2\*\],
  for any t3\* and t4\*.

* If `x` refers to a function type \[t1\*\] -> \[t2\*\],
  then the instruction `return_call_indirect x` has type \[t3\* t1\* i32\] -> \[t4\* t2\*\],
  for any t3\* and t4\*.

Note that caller and callee type do not need to match.


### Execution

Execution semantics of the new instructions would

1. pop the call operands
2. clear and pop the topmost stack frame in the same way `return` does
3. push back the operands
4. delegate to the semantics of the respective plain call instructions


### Binary Format

Need to assign opcodes for the new instructions.
Fortunately (and not just coincidentally), there is reserved opcode space next to the existing call instructions.


### Text Format

The text format is extended with two new instructions in the obvious manner.


## Open Questions

* Differentiate tail-callable functions by type?

* What about tail calls to host functions?
  - treat as tail-calling a wrapper, use type distinction, or trap?
  - note: cannot distinguish statically without type system support, e.g. with indirect calls

* Which instruction scheme should be picked?

* Instruction name bikeshedding


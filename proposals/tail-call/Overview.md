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

* Tail calls are performed via separate, explicit call instructions (existing call instructions explicitly disallow TCE)

* The proposal thus introduces a tail version of every call instruction

* An alternative scheme introducing a single instruction prefix applicable to every call instruction was considered but rejected by the CG
  - WebAssembly will likely get a few more call instructions in the future, e.g., `call_ref`
  - otoh, instruction prefixes as modifiers are not used anywhere else in Wasm


### Execution

* Tail calls behave like a combination of `return` followed by a respective call

* Hence they unwind the operand stack like `return` does

* Only keeps the necessary call arguments

* Tail calls to host functions cannot guarantee tail behaviour (outside the scope of the spec)

* Tail calls across WebAssembly module boundaries *do* guarantee tail behavior


### Typing

* Typing rule for tail call instruction is derived by their nature of merging call and return

* Because tail calls transfer control and unwind the stack they are stack-polymorphic

* Previously open question: should tail calls induce different function types? Possibilities:
  1. Distinguish tail-callees by type
  2. Distinguish tail-callers by type
  3. Both
  4. Neither

* Considerations:
  - Option 1 (and 3) allows different calling conventions for non-tail-callable functions, which may reduce constraints on ABIs.
  - On the other hand, it creates a bifurcated function space, which can lead to difficulties e.g. when using function tables or other forms of dynamic indirection.
  - Benefit of option 2 (and thus 3) unclear.
  - Experimental validation revealed that there isn't a notable performance benefit to option 1 either.

* CG resolution was to go with option 4 as the conceptually simplest.


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

### Structure

Add two instructions:

* `return_call <funcidx>`, the tail-call version of `call`
* `return_call_indirect <tableidx> <typeidx>`, the tail-call version of `call_indirect`

Other language extensions like [typed function refereces](https://github.com/WebAssembly/function-references/blob/master/proposals/function-references/Overview.md) that introduce new call instructions will also introduce tail versions of these new instructions.


### Validation

Validation of the new instructions is simply a combination of the typing rules for `return` and those for basic calls (and thus is stack-polymorphic).

* If `x` refers to a function of type \[t1\*\] -> \[t2\*\],
  then the instruction `return_call x` has type \[t3\* t1\*\] -> \[t4\*\],
  for any t3\* and t4\*,
  provided that the current function has return type \[t2\*\].

* If `x` refers to a function type \[t1\*\] -> \[t2\*\],
  then the instruction `return_call_indirect x` has type \[t3\* t1\* i32\] -> \[t4\*\],
  for any t3\* and t4\*,
  provided that the current function has return type \[t2\*\].

Note that caller's and callee's parameter types do not need to match.


### Execution

Execution semantics of the new instructions would

1. pop the call operands
2. clear and pop the topmost stack frame in the same way `return` does
3. push back the operands
4. delegate to the semantics of the respective plain call instructions


### Binary Format

Use the reserved opcodes after existing call instructions, i.e.:

* `return_call` is 0x12
* `return_call_indirect` is 0x13


### Text Format

The text format is extended with two new instructions in the obvious manner.

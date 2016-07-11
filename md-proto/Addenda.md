WebAssembly Addenda
================================================================================

0. [Introduction](#introduction)
0. [Stack-Based Function-Body Validation Algorithm](#stack-based-function-body-validation-algorithm)


Introduction
--------------------------------------------------------------------------------

A WebAssembly module can be validated in a single linear pass. This is fairly
straightforward for most sections, but things get interesting in function
bodies. The [stack-based function-body validation algorithm] describes one
approach by which this can be accomplished.


Stack-Based Function-Body Validation Algorithm
--------------------------------------------------------------------------------

Function-body validation can be performed in a single linear pass as follows:

The following data structures are created:
 - A *type stack*, with entries each containing a [type], for tracking the
   sequence of values that will be on the value stack at execution time.
 - A *control-flow stack*, with entries each containing:
    - A *limit* integer value, which is an index into the type stack indicating
      the boundary between values pushed before the current region and values
      pushed inside the current region.
    - An optional [type] sequence, which is used to check that all exits from
      the current region leave the same sequence of types on the type stack.
    - An *isThisAnIf* flag, indicating whether the entry was pushed for an `if`.

The following invariants are required to be preserved:
 - Whenever an element of either stack is to be popped, that stack is required
   to be non-empty.
 - Whenever an element of either stack is to be accessed by index, the index is
   required to be within the bounds of that stack.
 - Whenever the control-flow stack is non-empty, as it is everywhere except
   after the `end` at the end of the function, the type stack must be longer
   than the control-flow stack top's limit value.

The type stack begins empty. The control-flow stack begins with one entry, with
the [type] sequence consisting of the return types of the function, with the
limit value being zero, and the isThisAnIf flag being false.

For each instruction in the body, in sequence order:
 - For each construct in the instruction's signature's operands in reverse
   order:
    - If the construct is a [type], a type is popped from the type stack and
      required to be the same.
    - If the construct is a list of type parameters:
        - If the parameters are not yet bound, a type for each type parameter in
          the list in reverse order is popped from the type stack and bound to
          it.
        - Otherwise, a type for each type in the list in reverse order is popped
          from the type stack and required to be the same.
        - References to `$any` in the signature are resolved to the difference
          between the length of the type stack and the control-flow stack top's
          limit value.
   The popped types in reverse (again) order form the *operand sequence*.
 - Unless the instruction is a [control-flow barrier][Q], then for each
   construct in the instruction's signature's returns:
    - If the construct is a [type], a type is pushed onto the type stack.
    - If the construct is a list of type parameters, they are required to be
      bound, and the type bound to each type parameter is pushed onto the type
      stack.
 - If the instruction has a **Validation** clause, its requirements are
   required.
 - If the instruction has an associated
   [validation algorithm)[#instruction-specific-validation-algorithm], its
   contents are performed.
 - If the instruction's signature has no return types, or it is a
   [control-flow barrier][Q], the new length of the type stack is required to be
   at most the control-flow stack top's limit value.

Finally, for each type in the function's return list, a type is popped from the
type stack and required be the same. The type stack and the control-flow stack
are then both required to be empty. If all requirements were met, function-body
validation is successful.

> Implementations need not perform this exact algorithm; they need only validate
that the [requirements](WebAssembly.md#function-body-validation-requirements)
are met.

> The control-flow stack's limit values effectively mark region boundaries in
the type stack. Regions are required to be nested, and each region's limit value
is greater than those of the regions that enclose it. Types pushed onto the type
stack outside a region cannot be popped from within the region.

### Type-Sequence Merge

To merge a new type sequence into a control flow stack entry:
 - If the entry's optional type sequence is absent, it is set to be the new
   sequence.
 - Otherwise, the entry's type sequence is required to be the same as the new
   sequence.

### Instruction-Specific Validation Algorithm

0. [Block Validation Algorithm](#block-validation-algorithm)
0. [Loop Validation Algorithm](#loop-validation-algorithm)
0. [Unconditional-Branch Validation Algorithm](#unconditional-branch-validation-algorithm)
0. [Conditional-Branch Validation Algorithm](#conditional-branch-validation-algorithm)
0. [Table-Branch Validation Algorithm](#table-branch-validation-algorithm)
0. [If Validation Algorithm](#if-validation-algorithm)
0. [Else Validation Algorithm](#else-validation-algorithm)
0. [End Validation Algorithm](#end-validation-algorithm)
0. [Return Validation Algorithm](#return-validation-algorithm)

#### Block Validation Algorithm

An entry is pushed onto the control-flow stack containing no type sequence, a
limit value of the current length of the type stack, and an isThisAnIf value of
false.

#### Loop Validation Algorithm

An entry is pushed onto the control-flow stack containing an empty type
sequence, a limit value of the current length of the type stack, and an
isThisAnIf value of false.

#### Unconditional-Branch Validation Algorithm

The operand sequence is [merged] into the control-flow stack entry `$depth` from
the top.

#### Conditional-Branch Validation Algorithm

The sequence of the all but the last type in the operand sequence is [merged]
into the control-flow stack entry `$depth` from the top.

#### Table-Branch Validation Algorithm

For each depth in the table and `$default`, the sequence of all but the last
type in the operand sequence is [merged] into the control-flow stack entry that
depth from the top.

#### If Validation Algorithm

An entry is pushed onto the control-flow stack containing no type sequence, a
limit value of the current length of the type stack, and an isThisAnIf value of
true.

#### Else Validation Algorithm

The operand sequence is [merged] into the control-flow stack top. The
control-flow stack top's isThisAnIf value is required to be true. An entry is
popped off the control-flow stack. A new entry is pushed onto the control-flow
stack containing the operand sequence as its type sequence, a limit value of the
current length of the type stack, and an isThisAnIf value of true.

#### End Validation Algorithm

The operand sequence is [merged] into the control-flow stack top. The
control-flow stack top entry is popped.

#### Return Validation Algorithm

The operand sequence is [merged] into the control-flow stack bottom.


[Q]: #q-control-flow-barrier-instruction-family
[type]: WebAssembly.md#types

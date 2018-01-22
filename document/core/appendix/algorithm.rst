.. index:: validation, algorithm, instruction, module, binary format, opcode
.. _algo-valid:

Validation Algorithm
--------------------

The specification of WebAssembly :ref:`validation <valid>` is purely *declarative*.
It describes the constraints that must be met by a :ref:`module <valid-module>` or :ref:`instruction <valid-instr>` sequence to be valid.

This section sketches the skeleton of a sound and complete *algorithm* for effectively validating code, i.e., sequences of :ref:`instructions <syntax-instr>`.
(Other aspects of validation are straightforward to implement.)

In fact, the algorithm is expressed over the flat sequence of opcodes as occurring in the :ref:`binary format <binary>`, and performs only a single pass over it.
Consequently, it can be integrated directly into a decoder.

The algorithm is expressed in typed pseudo code whose semantics is intended to be self-explanatory.


.. index:: value type, stack, label, frame, instruction

Data Structures
~~~~~~~~~~~~~~~

The algorithm uses two separate stacks: the *operand stack* and the *control stack*.
The former tracks the :ref:`types <syntax-valtype>` of operand values on the :ref:`stack <stack>`,
the latter surrounding :ref:`structured control instructions <syntax-instr-control>` and their associated :ref:`blocks <syntax-instr-control>`.

.. code-block:: pseudo

   type val_type = I32 | I64 | F32 | F64

   type opd_stack = stack(val_type | Unknown)

   type ctrl_stack = stack(ctrl_frame)
   type ctrl_frame = {
     label_types : list(val_type)
     end_types : list(val_type)
     height : nat
     unreachable : bool
   }

For each value, the operand stack records its :ref:`value type <syntax-valtype>`, or :code:`Unknown` when the type is not known.

For each entered block, the control stack records a *control frame* with the type of the associated :ref:`label <syntax-label>` (used to type-check branches), the result type of the block (used to check its result), the height of the operand stack at the start of the block (used to check that operands do not underflow the current block), and a flag recording whether the remainder of the block is unreachable (used to handle :ref:`stack-polymorphic <polymorphism>` typing after branches).

.. note::
   In the presentation of this algorithm, multiple values are supported for the :ref:`result types <syntax-resulttype>` classifying blocks and labels.
   With the current version of WebAssembly, the :code:`list` could be simplified to an optional value.

For the purpose of presenting the algorithm, the operand and control stacks are simply maintained as global variables:

.. code-block:: pseudo

   var opds : opd_stack
   var ctrls : ctrl_stack

However, these variables are not manipulated directly by the main checking function, but through a set of auxiliary functions:

.. code-block:: pseudo

   func push_opd(type : val_type | Unknown) =
     opds.push(type)

   func pop_opd() : val_type | Unknown =
     if (opds.size() = ctrls[0].height && ctrls[0].unreachable) return Unknown
     error_if(opds.size() = ctrls[0].height)
     return opds.pop()

   func pop_opd(expect : val_type | Unknown) : val_type | Unknown =
     let actual = pop_opd()
     if (actual = Unknown) return expect
     if (expect = Unknown) return actual
     error_if(actual =/= expect)
     return actual

   func push_opds(types : list(val_type)) = foreach (t in types) push_opd(t)
   func pop_opds(types : list(val_type)) = foreach (t in reverse(types)) pop_opd(t)

Pushing an operand simply pushes the respective type to the operand stack.

Popping an operand checks that the operand stack does not underflow the current block and then removes one type.
But first, a special case is handled where the block contains no known operands, but has been marked as unreachable.
That can occur after an unconditional branch, when the stack is typed :ref:`polymorphically <polymorphism>`.
In that case, an unknown type is returned.

A second function for popping an operand takes an expected type, which the actual operand type is checked against.
The types may differ in case one of them is Unknown.
The more specific type is returned.

Finally, there are accumulative functions for pushing or popping multiple operand types.

.. note::
   The notation :code:`stack[i]` is meant to index the stack from the top,
   so that :code:`ctrls[0]` accesses the element pushed last.


The control stack is likewise manipulated through auxiliary functions:

.. code-block:: pseudo

   func push_ctrl(label : list(val_type), out : list(val_type)) =
     let frame = ctrl_frame(label, out, opds.size(), false)
     ctrls.push(frame)

   func pop_ctrl() : list(val_type) =
     error_if(ctrls.is_empty())
     let frame = ctrls.pop()
     pop_opds(frame.end_types)
     error_if(opds.size() =/= frame.height)
     return frame.end_types

   func unreachable() =
     opds.resize(ctrls[0].height)
     ctrls[0].unreachable := true

Pushing a control frame takes the types of the label and result values.
It allocates a new frame record recording them along with the current height of the operand stack and marks the block as reachable.

Popping a frame first checks that the control stack is not empty.
It then verifies that the operand stack contains the right types of values expected at the end of the exited block and pops them off the operand stack.
Afterwards, it checks that the stack has shrunk back to its initial height.

Finally, the current frame can be marked as unreachable.
In that case, all existing operand types are purged from the operand stack, in order to allow for the :ref:`stack-polymorphism <polymorphism>` logic in :code:`pop_opd` to take effect.

.. note::
   Even with the unreachable flag set, consecutive operands are still pushed to and popped from the operand stack.
   That is necessary to detect invalid :ref:`examples <polymorphism>` like :math:`(\UNREACHABLE~(\I32.\CONST)~\I64.\ADD)`.
   However, a polymorphic stack cannot underflow, but instead generates :code:`Unknown` types as needed.


.. index:: opcode

Validation of Opcode Sequences
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following function shows the validation of a number of representative instructions that manipulate the stack.
Other instructions are checked in a similar manner.

.. note::
   Various instructions not shown here will additionally require the presence of a validation :ref:`context <context>` for checking uses of :ref:`indices <syntax-index>`.
   That is an easy addition and therefore omitted from this presentation.

.. code-block:: pseudo

   func validate(opcode) =
     switch (opcode)
       case (i32.add)
         pop_opd(I32)
         pop_opd(I32)
         push_opd(I32)

       case (drop)
         pop_opd()

       case (select)
         pop_opd(I32)
         let t1 = pop_opd()
         let t2 = pop_opd(t1)
         push_opd(t2)

       case (unreachable)
         unreachable()

       case (block t*)
         push_ctrl([t*], [t*])

       case (loop t*)
         push_ctrl([], [t*])

       case (if t*)
         push_ctrl([t*], [t*])

       case (end)
         let results = pop_ctrl()
         push_opds(results)

       case (else)
         let results = pop_ctrl()
         push_ctrl(results, results)

       case (br n)
         error_if(ctrls.size() < n)
         pop_opds(ctrls[n].label_types)
         unreachable()

       case (br_if n)
         error_if(ctrls.size() < n)
         pop_opd(I32)
         pop_opds(ctrls[n].label_types)
         push_opds(ctrls[n].label_types)

       case (br_table n* m)
         error_if(ctrls.size() < m)
         foreach (n in n*)
           error_if(ctrls.size() < n || ctrls[n].label_types =/= ctrls[m].label_types)
         pop_opd(I32)
         pop_opds(ctrls[m].label_types)
         unreachable()

.. note::
   It is an invariant under the current WebAssembly instruction set that an operand of :code:`Unknown` type is never duplicated on the stack.
   This would change if the language were extended with stack operators like :code:`dup`.
   Under such an extension, the above algorithm would need to be refined by replacing the :code:`Unknown` type with proper *type variables* to ensure that all uses are consistent.

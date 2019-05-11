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

Types are representable as an enumeration.
A simple subtyping check can be defined on these types.

.. code-block:: pseudo

   type val_type = I32 | I64 | F32 | F64 | Anyref | Funcref | Nullref | Bot

   func is_num(t : val_type) : bool =
     return t = I32 || t = I64 || t = F32 || t = F64 || t = Bot

   func is_ref(t : val_type) : bool =
     return t = Anyref || t = Funcref || t = Nullref || t = Bot

   func matches(t1 : val_type, t2 : val_type) : bool =
     return t1 = t2 || t1 = Bot ||
       (t1 = Nullref && is_ref(t2)) || (is_ref(t1) && t2 = Anyref)

The algorithm uses two separate stacks: the *value stack* and the *control stack*.
The former tracks the :ref:`types <syntax-valtype>` of operand values on the :ref:`stack <stack>`,
the latter surrounding :ref:`structured control instructions <syntax-instr-control>` and their associated :ref:`blocks <syntax-instr-control>`.

.. code-block:: pseudo

   type val_stack = stack(val_type)

   type ctrl_stack = stack(ctrl_frame)
   type ctrl_frame = {
     label_types : list(val_type)
     end_types : list(val_type)
     height : nat
     unreachable : bool
   }

For each value, the value stack records its :ref:`value type <syntax-valtype>`.

For each entered block, the control stack records a *control frame* with the type of the associated :ref:`label <syntax-label>` (used to type-check branches), the result type of the block (used to check its result), the height of the operand stack at the start of the block (used to check that operands do not underflow the current block), and a flag recording whether the remainder of the block is unreachable (used to handle :ref:`stack-polymorphic <polymorphism>` typing after branches).

.. note::
   In the presentation of this algorithm, multiple values are supported for the :ref:`result types <syntax-resulttype>` classifying blocks and labels.
   With the current version of WebAssembly, the :code:`list` could be simplified to an optional value.

For the purpose of presenting the algorithm, the operand and control stacks are simply maintained as global variables:

.. code-block:: pseudo

   var vals : val_stack
   var ctrls : ctrl_stack

However, these variables are not manipulated directly by the main checking function, but through a set of auxiliary functions:

.. code-block:: pseudo

   func push_val(type : val_type) =
     vals.push(type)

   func pop_val() : val_type =
     if (vals.size() = ctrls[0].height && ctrls[0].unreachable) return Bot
     error_if(vals.size() = ctrls[0].height)
     return vals.pop()

   func pop_val(expect : val_type) : val_type =
     let actual = pop_val()
     error_if(not matches(actual, expect))
     return actual

   func push_vals(types : list(val_type)) = foreach (t in types) push_val(t)
   func pop_vals(types : list(val_type)) : list(val_type) =
     var popped := []
     foreach (t in reverse(types)) popped.append(pop_val(t))
     return popped

Pushing an operand value simply pushes the respective type to the value stack.

Popping an operand value checks that the value stack does not underflow the current block and then removes one type.
But first, a special case is handled where the block contains no known values, but has been marked as unreachable.
That can occur after an unconditional branch, when the stack is typed :ref:`polymorphically <polymorphism>`.
In that case, the :code:`Bot` type is returned, because that is a *principal* choice trivially satisfying all use constraints.

A second function for popping an operand value takes an expected type, which the actual operand type is checked against.
The types may differ by subtyping, including the case where the actual type is :code:`Bot`, and thereby matches unconditionally.
The function returns the actual type popped from the stack.

Finally, there are accumulative functions for pushing or popping multiple operand types.

.. note::
   The notation :code:`stack[i]` is meant to index the stack from the top,
   so that, e.g., :code:`ctrls[0]` accesses the element pushed last.


The control stack is likewise manipulated through auxiliary functions:

.. code-block:: pseudo

   func push_ctrl(label : list(val_type), out : list(val_type)) =
     let frame = ctrl_frame(label, out, vals.size(), false)
     ctrls.push(frame)

   func pop_ctrl() : list(val_type) =
     error_if(ctrls.is_empty())
     let frame = ctrls[0]
     pop_vals(frame.end_types)
     error_if(vals.size() =/= frame.height)
     ctrls.pop()
     return frame.end_types

   func unreachable() =
     vals.resize(ctrls[0].height)
     ctrls[0].unreachable := true

Pushing a control frame takes the types of the label and result values.
It allocates a new frame record recording them along with the current height of the operand stack and marks the block as reachable.

Popping a frame first checks that the control stack is not empty.
It then verifies that the operand stack contains the right types of values expected at the end of the exited block and pops them off the operand stack.
Afterwards, it checks that the stack has shrunk back to its initial height.

Finally, the current frame can be marked as unreachable.
In that case, all existing operand types are purged from the value stack, in order to allow for the :ref:`stack-polymorphism <polymorphism>` logic in :code:`pop_val` to take effect.

.. note::
   Even with the unreachable flag set, consecutive operands are still pushed to and popped from the operand stack.
   That is necessary to detect invalid :ref:`examples <polymorphism>` like :math:`(\UNREACHABLE~(\I32.\CONST)~\I64.\ADD)`.
   However, a polymorphic stack cannot underflow, but instead generates :code:`Bot` types as needed.


.. index:: opcode

Validation of Instruction Sequences
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following function shows the validation of a number of representative instructions that manipulate the stack.
Other instructions are checked in a similar manner.

.. note::
   Various instructions not shown here will additionally require the presence of a validation :ref:`context <context>` for checking uses of :ref:`indices <syntax-index>`.
   That is an easy addition and therefore omitted from this presentation.

.. code-block:: pseudo

   func validate(opcode) =
     switch (opcode)
       case (i32.add)
         pop_val(I32)
         pop_val(I32)
         push_val(I32)

       case (drop)
         pop_val()

       case (select)
         pop_val(I32)
         let t1 = pop_val()
         let t2 = pop_val()
         error_if(not (is_num(t1) && is_num(t2)))
         error_if(t1 =/= t2 && t1 =/= Bot && t2 =/= Bot)
         push_val(if (t1 = Bot) t2 else t1)

       case (select t)
         pop_val(I32)
         pop_val(t)
         pop_val(t)
         push_val(t)

       case (unreachable)
         unreachable()

       case (block t*)
         push_ctrl([t*], [t*])

       case (loop t*)
         push_ctrl([], [t*])

       case (if t*)
         pop_val(I32)
         push_ctrl([t*], [t*])

       case (end)
         let results = pop_ctrl()
         push_vals(results)

       case (else)
         let results = pop_ctrl()
         push_ctrl(results, results)

       case (br n)
         error_if(ctrls.size() < n)
         pop_vals(ctrls[n].label_types)
         unreachable()

       case (br_if n)
         error_if(ctrls.size() < n)
         pop_val(I32)
         pop_vals(ctrls[n].label_types)
         push_vals(ctrls[n].label_types)

       case (br_table n* m)
         pop_val(I32)
         error_if(ctrls.size() < m)
         let arity = ctrls[m].label_types.size()
         foreach (n in n*)
           error_if(ctrls.size() < n)
           error_if(ctrls[n].label_types.size() =/= arity)
           push_vals(pop_vals(ctrls[n].label_types))
         pop_vals(ctrls[m].label_types)
         unreachable()

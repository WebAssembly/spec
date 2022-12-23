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

.. code-block:: pseudo

   type val_type = I32 | I64 | F32 | F64 | V128 | Funcref | Externref

   func is_num(t : val_type | Unknown) : bool =
     return t = I32 || t = I64 || t = F32 || t = F64 || t = Unknown

   func is_vec(t : val_type | Unknown) : bool =
     return t = V128 || t = Unknown

   func is_ref(t : val_type | Unknown) : bool =
     return t = Funcref || t = Externref || t = Unknown

The algorithm uses two separate stacks: the *value stack* and the *control stack*.
The former tracks the :ref:`types <syntax-valtype>` of operand values on the :ref:`stack <stack>`,
the latter surrounding :ref:`structured control instructions <syntax-instr-control>` and their associated :ref:`blocks <syntax-instr-control>`.

.. code-block:: pseudo

   type val_stack = stack(val_type | Unknown)

   type ctrl_stack = stack(ctrl_frame)
   type ctrl_frame = {
     opcode : opcode
     start_types : list(val_type)
     end_types : list(val_type)
     height : nat
     unreachable : bool
   }

For each value, the value stack records its :ref:`value type <syntax-valtype>`, or :code:`Unknown` when the type is not known.

For each entered block, the control stack records a *control frame* with the originating opcode, the types on the top of the operand stack at the start and end of the block (used to check its result as well as branches), the height of the operand stack at the start of the block (used to check that operands do not underflow the current block), and a flag recording whether the remainder of the block is unreachable (used to handle :ref:`stack-polymorphic <polymorphism>` typing after branches).

For the purpose of presenting the algorithm, the operand and control stacks are simply maintained as global variables:

.. code-block:: pseudo

   var vals : val_stack
   var ctrls : ctrl_stack

However, these variables are not manipulated directly by the main checking function, but through a set of auxiliary functions:

.. code-block:: pseudo

   func push_val(type : val_type | Unknown) =
     vals.push(type)

   func pop_val() : val_type | Unknown =
     if (vals.size() = ctrls[0].height && ctrls[0].unreachable) return Unknown
     error_if(vals.size() = ctrls[0].height)
     return vals.pop()

   func pop_val(expect : val_type | Unknown) : val_type | Unknown =
     let actual = pop_val()
     error_if(actual =/= expect && actual =/= Unknown && expect =/= Unknown)
     return actual

   func push_vals(types : list(val_type)) = foreach (t in types) push_val(t)
   func pop_vals(types : list(val_type)) : list(val_type) =
     var popped := []
     foreach (t in reverse(types)) popped.prepend(pop_val(t))
     return popped

Pushing an operand value simply pushes the respective type to the value stack.

Popping an operand value checks that the value stack does not underflow the current block and then removes one type.
But first, a special case is handled where the block contains no known values, but has been marked as unreachable.
That can occur after an unconditional branch, when the stack is typed :ref:`polymorphically <polymorphism>`.
In that case, an unknown type is returned.

A second function for popping an operand value takes an expected type, which the actual operand type is checked against.
The types may differ in case one of them is Unknown.
The function returns the actual type popped from the stack.

Finally, there are accumulative functions for pushing or popping multiple operand types.

.. note::
   The notation :code:`stack[i]` is meant to index the stack from the top,
   so that, e.g., :code:`ctrls[0]` accesses the element pushed last.


The control stack is likewise manipulated through auxiliary functions:

.. code-block:: pseudo

   func push_ctrl(opcode : opcode, in : list(val_type), out : list(val_type)) =
     let frame = ctrl_frame(opcode, in, out, vals.size(), false)
     ctrls.push(frame)
     push_vals(in)

   func pop_ctrl() : ctrl_frame =
     error_if(ctrls.is_empty())
     let frame = ctrls[0]
     pop_vals(frame.end_types)
     error_if(vals.size() =/= frame.height)
     ctrls.pop()
     return frame

   func label_types(frame : ctrl_frame) : list(val_type) =
     return (if frame.opcode == loop then frame.start_types else frame.end_types)

   func unreachable() =
     vals.resize(ctrls[0].height)
     ctrls[0].unreachable := true

Pushing a control frame takes the types of the label and result values.
It allocates a new frame record recording them along with the current height of the operand stack and marks the block as reachable.

Popping a frame first checks that the control stack is not empty.
It then verifies that the operand stack contains the right types of values expected at the end of the exited block and pops them off the operand stack.
Afterwards, it checks that the stack has shrunk back to its initial height.

The type of the :ref:`label <syntax-label>` associated with a control frame is either that of the stack at the start or the end of the frame, determined by the opcode that it originates from.

Finally, the current frame can be marked as unreachable.
In that case, all existing operand types are purged from the value stack, in order to allow for the :ref:`stack-polymorphism <polymorphism>` logic in :code:`pop_val` to take effect.

.. note::
   Even with the unreachable flag set, consecutive operands are still pushed to and popped from the operand stack.
   That is necessary to detect invalid :ref:`examples <polymorphism>` like :math:`(\UNREACHABLE~(\I32.\CONST)~\I64.\ADD)`.
   However, a polymorphic stack cannot underflow, but instead generates :code:`Unknown` types as needed.


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
         error_if(not ((is_num(t1) && is_num(t2)) || (is_vec(t1) && is_vec(t2))))
         error_if(t1 =/= t2 && t1 =/= Unknown && t2 =/= Unknown)
         push_val(if (t1 = Unknown) t2 else t1)

       case (select t)
         pop_val(I32)
         pop_val(t)
         pop_val(t)
         push_val(t)

       case (unreachable)
         unreachable()

       case (block t1*->t2*)
         pop_vals([t1*])
         push_ctrl(block, [t1*], [t2*])

       case (loop t1*->t2*)
         pop_vals([t1*])
         push_ctrl(loop, [t1*], [t2*])

       case (if t1*->t2*)
         pop_val(I32)
         pop_vals([t1*])
         push_ctrl(if, [t1*], [t2*])

       case (end)
         let frame = pop_ctrl()
         push_vals(frame.end_types)

       case (else)
         let frame = pop_ctrl()
         error_if(frame.opcode =/= if)
         push_ctrl(else, frame.start_types, frame.end_types)

       case (try t1*->t2*)
         pop_vals([t1*])
         push_ctrl(try, [t1*], [t2*])

       case (catch)
         let frame = pop_ctrl()
         error_if(frame.opcode =/= try || frame.opcode =/= catch)
         let params = tags[x].type.params
         push_ctrl(catch, params , frame.end_types)

       case (catch_all)
         let frame = pop_ctrl()
         error_if(frame.opcode =/= try || frame.opcode =/= catch)
         push_ctrl(catch_all, [], frame.end_types)

       case (br n)
         error_if(ctrls.size() < n)
         pop_vals(label_types(ctrls[n]))
         unreachable()

       case (br_if n)
         error_if(ctrls.size() < n)
         pop_val(I32)
         pop_vals(label_types(ctrls[n]))
         push_vals(label_types(ctrls[n]))

       case (br_table n* m)
         pop_val(I32)
         error_if(ctrls.size() < m)
         let arity = label_types(ctrls[m]).size()
         foreach (n in n*)
           error_if(ctrls.size() < n)
           error_if(label_types(ctrls[n]).size() =/= arity)
           push_vals(pop_vals(label_types(ctrls[n])))
         pop_vals(label_types(ctrls[m]))
         unreachable()

.. todo::
   Add a case for :code:`throw`.

.. note::
   It is an invariant under the current WebAssembly instruction set that an operand of :code:`Unknown` type is never duplicated on the stack.
   This would change if the language were extended with stack instructions like :code:`dup`.
   Under such an extension, the above algorithm would need to be refined by replacing the :code:`Unknown` type with proper *type variables* to ensure that all uses are consistent.

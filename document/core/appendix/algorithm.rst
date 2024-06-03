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


.. index:: value type, reference type, vector type, number type, packed type, field type, structure type, array type, function type, composite type, sub type, recursive type, defined type, stack, label, frame, instruction

Data Structures
~~~~~~~~~~~~~~~

Types
.....

Value types are representable as sets of enumerations:

.. code-block:: pseudo

   type num_type = I32 | I64 | F32 | F64
   type vec_type = V128
   type heap_type =
     Any | Eq | I31 | Struct | Array | None |
     Func | Nofunc | Extern | Noextern | Bot |
     Def(def : def_type)
   type ref_type = Ref(heap : heap_type, null : bool)
   type val_type = num_type | vec_type | ref_type | Bot

   func is_num(t : val_type) : bool =
     return t = I32 || t = I64 || t = F32 || t = F64 || t = Bot

   func is_vec(t : val_type) : bool =
     return t = V128 || t = Bot

   func is_ref(t : val_type) : bool =
     return not (is_num t || is_vec t) || t = Bot

Similarly, :ref:`defined types <syntax-deftype>` :code:`def_type` can be represented:

.. code-block:: pseudo

   type packed_type = I8 | I16
   type field_type = Field(val : val_type | packed_type, mut : bool)

   type struct_type = Struct(fields : list(field_type))
   type array_type = Array(fields : field_type)
   type func_type = Func(params : list(val_type), results : list(val_type))
   type comp_type = struct_type | array_type | func_type

   type sub_type = Sub(super : list(def_type), body : comp_type, final : bool)
   type rec_type = Rec(types : list(sub_type))

   type def_type = Def(rec : rec_type, proj : int32)

   func unpack_field(t : field_type) : val_type =
     if (it = I8 || t = I16) return I32
     return t

   func expand_def(t : def_type) : comp_type =
     return t.rec.types[t.proj].body

These representations assume that all types have been :ref:`closed <type-closed>` by :ref:`substituting <type-subst>` all :ref:`type indices <syntax-typeidx>` (in :ref:`concrete heap types <syntax-heaptype>` and in :ref:`sub types <syntax-subtype>`) with their respective :ref:`defined types <syntax-deftype>`.
This includes *recursive* references to enclosing :ref:`defined types <syntax-deftype>`,
such that type representations form graphs and may be *cyclic* for :ref:`recursive types <syntax-rectype>`.

We assume that all types have been *canonicalized*, such that equality on two type representations holds if and only if their :ref:`closures <type-closure>` are syntactically equivalent, making it a constant-time check.

.. note::
   For the purpose of type canonicalization, recursive references from a :ref:`heap type <syntax-heaptype>` to an enclosing :ref:`recursive type <syntax-reftype>` (i.e., forward edges in the graph that form a cycle) need to be distinguished from references to previously defined types.
   However, this distinction does not otherwise affect validation, so is ignored here.
   In the graph representation, all recursive types are effectively infinitely :ref:`unrolled <aux-unroll-rectype>`.

We further assume that :ref:`validation <valid-valtype>` and :ref:`subtyping <match-valtype>` checks are defined on value types, as well as a few auxiliary functions on composite types:

.. code-block:: pseudo

   func validate_val_type(t : val_type)
   func validate_ref_type(t : ref_type)

   func matches_val(t1 : val_type, t2 : val_type) : bool
   func matches_ref(t1 : val_type, t2 : val_type) : bool

   func is_func(t : comp_type) : bool
   func is_struct(t : comp_type) : bool
   func is_array(t : comp_type) : bool

Finally, the following function computes the least precise supertype of a given :ref:`heap type <syntax-heaptype>` (its corresponding top type):

.. code-block:: pseudo

   func top_heap_type(t : heap_type) : heap_type =
     switch (t)
       case (Any | Eq | I31 | Struct | Array | None)
         return Any
       case (Func | Nofunc)
         return Func
       case (Extern | Noextern)
         return Extern
       case (Def(dt))
         switch (dt.rec.types[dt.proj].body)
           case (Struct(_) | Array(_))
             return Any
           case (Func(_))
             return Func
       case (Bot)
         raise CannotOccurInSource


Context
.......

Validation requires a :ref:`context <context>` for checking uses of :ref:`indices <syntax-index>`.
For the purpose of presenting the algorithm, it is maintained in a set of global variables:

.. code-block:: pseudo

   var return_type : list(val_type)
   var types : array(def_type)
   var locals : array(val_type)
   var locals_init : array(bool)
   var globals : array(global_type)
   var funcs : array(func_type)
   var tables : array(table_type)
   var mems : array(mem_type)

This assumes suitable representations for the various :ref:`types <syntax-type>` besides :code:`val_type`, which are omitted here.

For locals, there is an additional array recording the initialization status of each local.

Stacks
......

The algorithm uses three separate stacks: the *value stack*, the *control stack*, and the *initialization stack*.
The value stack tracks the :ref:`types <syntax-valtype>` of operand values on the :ref:`stack <stack>`.
The control stack tracks surrounding :ref:`structured control instructions <syntax-instr-control>` and their associated :ref:`blocks <syntax-instr-control>`.
The initialization stack records all :ref:`locals <syntax-local>` that have been initialized since the beginning of the function.

.. code-block:: pseudo

   type val_stack = stack(val_type)
   type init_stack = stack(u32)

   type ctrl_stack = stack(ctrl_frame)
   type ctrl_frame = {
     opcode : opcode
     start_types : list(val_type)
     end_types : list(val_type)
     val_height : nat
     init_height : nat
     unreachable : bool
   }

For each entered block, the control stack records a *control frame* with the originating opcode, the types on the top of the operand stack at the start and end of the block (used to check its result as well as branches), the height of the operand stack at the start of the block (used to check that operands do not underflow the current block), the height of the initialization stack at the start of the block (used to reset initialization status at the end of the block), and a flag recording whether the remainder of the block is unreachable (used to handle :ref:`stack-polymorphic <polymorphism>` typing after branches).

For the purpose of presenting the algorithm, these stacks are simply maintained as global variables:

.. code-block:: pseudo

   var vals : val_stack
   var inits : init_stack
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
     error_if(not matches_val(actual, expect))
     return actual

   func pop_num() : num_type | Bot =
     let actual = pop_val()
     error_if(not is_num(actual))
     return actual

   func pop_ref() : ref_type =
     let actual = pop_val()
     error_if(not is_ref(actual))
     if (actual = Bot) return Ref(Bot, false)
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
In that case, the :code:`Bot` type is returned, because that is a *principal* choice trivially satisfying all use constraints.

A second function for popping an operand value takes an expected type, which the actual operand type is checked against.
The types may differ by subtyping, including the case where the actual type is :code:`Bot`, and thereby matches unconditionally.
The function returns the actual type popped from the stack.

Finally, there are accumulative functions for pushing or popping multiple operand types.

.. note::
   The notation :code:`stack[i]` is meant to index the stack from the top,
   so that, e.g., :code:`ctrls[0]` accesses the element pushed last.


The initialization stack and the initialization status of locals is manipulated through the following functions:

.. code-block:: pseudo

   func get_local(idx : u32) =
     error_if(not locals_init[idx])

   func set_local(idx : u32) =
     if (not locals_init[idx])
       inits.push(idx)
       locals_init[idx] := true

   func reset_locals(height : nat) =
     while (inits.size() > height)
       locals_init[inits.pop()] := false

Getting a local verifies that it is known to be initialized.
When a local is set that was not set already,
then its initialization status is updated and the change is recorded in the initialization stack.
Thus, the initialization status of all locals can be reset to a previous state by denoting a specific height in the initialization stack.

The size of the initialization stack is bounded by the number of (non-defaultable) locals in a function, so can be preallocated by an algorithm.

The control stack is likewise manipulated through auxiliary functions:

.. code-block:: pseudo

   func push_ctrl(opcode : opcode, in : list(val_type), out : list(val_type)) =
     let frame = ctrl_frame(opcode, in, out, vals.size(), inits.size(), false)
     ctrls.push(frame)
     push_vals(in)

   func pop_ctrl() : ctrl_frame =
     error_if(ctrls.is_empty())
     let frame = ctrls[0]
     pop_vals(frame.end_types)
     error_if(vals.size() =/= frame.val_height)
     reset_locals(frame.init_height)
     ctrls.pop()
     return frame

   func label_types(frame : ctrl_frame) : list(val_types) =
     return (if (frame.opcode = loop) frame.start_types else frame.end_types)

   func unreachable() =
     vals.resize(ctrls[0].height)
     ctrls[0].unreachable := true

Pushing a control frame takes the types of the label and result values.
It allocates a new frame record recording them along with the current height of the operand stack and marks the block as reachable.

Popping a frame first checks that the control stack is not empty.
It then verifies that the operand stack contains the right types of values expected at the end of the exited block and pops them off the operand stack.
Afterwards, it checks that the stack has shrunk back to its initial height.
Finally, it undoes all changes to the initialization status of locals that happend inside the block.

The type of the :ref:`label <syntax-label>` associated with a control frame is either that of the stack at the start or the end of the frame, determined by the opcode that it originates from.

Finally, the current frame can be marked as unreachable.
In that case, all existing operand types are purged from the value stack, in order to allow for the :ref:`stack-polymorphism <polymorphism>` logic in :code:`pop_val` to take effect.
Because every function has an implicit outermost label that corresponds to an implicit block frame,
it is an invariant of the validation algorithm that there always is at least one frame on the control stack when validating an instruction, and hence, `ctrls[0]` is always defined.

.. note::
   Even with the unreachable flag set, consecutive operands are still pushed to and popped from the operand stack.
   That is necessary to detect invalid :ref:`examples <polymorphism>` like :math:`(\UNREACHABLE~(\I32.\CONST)~\I64.\ADD)`.
   However, a polymorphic stack cannot underflow, but instead generates :code:`Bot` types as needed.


.. index:: opcode

Validation of Opcode Sequences
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following function shows the validation of a number of representative instructions that manipulate the stack.
Other instructions are checked in a similar manner.

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
         error_if(not (is_num(t1) && is_num(t2) || is_vec(t1) && is_vec(t2)))
         error_if(t1 =/= t2 && t1 =/= Bot && t2 =/= Bot)
         push_val(if (t1 = Bot) t2 else t1)

       case (select t)
         pop_val(I32)
         pop_val(t)
         pop_val(t)
         push_val(t)

       case (ref.is_null)
         pop_ref()
         push_val(I32)

       case (ref.as_non_null)
         let rt = pop_ref()
         push_val(Ref(rt.heap, false))

       case (ref.test rt)
         validate_ref_type(rt)
         pop_val(Ref(top_heap_type(rt), true))
         push_val(I32)

       case (local.get x)
         get_local(x)
         push_val(locals[x])

       case (local.set x)
         pop_val(locals[x])
         set_local(x)

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

       case (br_on_null n)
         error_if(ctrls.size() < n)
         let rt = pop_ref()
         pop_vals(label_types(ctrls[n]))
         push_vals(label_types(ctrls[n]))
         push_val(Ref(rt.heap, false))

       case (br_on_cast n rt1 rt2)
         validate_ref_type(rt1)
         validate_ref_type(rt2)
         pop_val(rt1)
         push_val(rt2)
         pop_vals(label_types(ctrls[n]))
         push_vals(label_types(ctrls[n]))
         pop_val(rt2)
         push_val(diff_ref_type(rt2, rt1))

       case (return)
         pop_vals(return_types)
         unreachable()

       case (call_ref x)
         let t = expand_def(types[x])
         error_if(not is_func(t))
         pop_vals(t.params)
         pop_val(Ref(Def(types[x])))
         push_vals(t.results)

       case (return_call_ref x)
         let t = expand_def(types[x])
         error_if(not is_func(t))
         pop_vals(t.params)
         pop_val(Ref(Def(types[x])))
         error_if(t.results.len() =/= return_types.len())
         push_vals(t.results)
         pop_vals(return_types)
         unreachable()

       case (struct.new x)
         let t = expand_def(types[x])
         error_if(not is_struct(t))
         for (ti in reverse(t.fields))
           pop_val(unpack_field(ti))
         push_val(Ref(Def(types[x])))

       case (struct.set x n)
         let t = expand_def(types[x])
         error_if(not is_struct(t) || n >= t.fields.len())
         pop_val(Ref(Def(types[x])))
         pop_val(unpack_field(st.fields[n]))

.. note::
   It is an invariant under the current WebAssembly instruction set that an operand of :code:`Bot` type is never duplicated on the stack.
   This would change if the language were extended with stack instructions like :code:`dup`.
   Under such an extension, the above algorithm would need to be refined by replacing the :code:`Bot` type with proper *type variables* to ensure that all uses are consistent.

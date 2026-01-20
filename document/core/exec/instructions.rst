.. index:: instruction, function type, store, validation
.. _exec-instr:

Instructions
------------

WebAssembly computation is performed by executing individual :ref:`instructions <syntax-instr>`.


.. index:: parametric instruction, value
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _exec-nop:

$${rule-prose: Step_pure/nop}

$${rule: {Step_pure/nop}}


.. _exec-unreachable:

$${rule-prose: Step_pure/unreachable}

$${rule: {Step_pure/unreachable}}


.. _exec-drop:

$${rule-prose: Step_pure/drop}

$${rule: Step_pure/drop}


.. _exec-select:

$${rule-prose: Step_pure/select}

$${rule: {Step_pure/select-*}}

.. note::
   In future versions of WebAssembly, ${:SELECT} may allow more than one value per choice.


.. index:: control instructions, structured control, label, block, branch, result type, label index, function index, type index, list, address, table address, table instance, store, frame
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-label:
.. _exec-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-block:

$${rule-prose: Step_read/block}

$${rule: {Step_read/block}}


.. _exec-loop:

$${rule-prose: Step_read/loop}

$${rule: {Step_read/loop}}


.. _exec-if:

$${rule-prose: Step_pure/if}

$${rule: {Step_pure/if-*}}


.. _exec-br:

$${rule-prose: Step_pure/br}

$${rule: {Step_pure/br-*}}


.. _exec-br_if:

$${rule-prose: Step_pure/br_if}

$${rule: {Step_pure/br_if-*}}


.. _exec-br_table:

$${rule-prose: Step_pure/br_table}

$${rule: {Step_pure/br_table-*}}


.. _exec-br_on_null:

$${rule-prose: Step_pure/br_on_null}

$${rule: {Step_pure/br_on_null-*}}


.. _exec-br_on_non_null:

$${rule-prose: Step_pure/br_on_non_null}

$${rule: {Step_pure/br_on_non_null-*}}


.. _exec-br_on_cast:

$${rule-prose: Step_read/br_on_cast}

$${rule: {Step_read/br_on_cast-*}}


.. _exec-br_on_cast_fail:

$${rule-prose: Step_read/br_on_cast_fail}

$${rule: {Step_read/br_on_cast_fail-*}}


.. _exec-return:

$${rule-prose: Step_pure/return}

$${rule: {Step_pure/return-*}}


.. _exec-call:

$${rule-prose: Step_read/call}

$${rule: {Step_read/call}}


.. _exec-call_ref:

:math:`\CALLREF~x`
..................

.. todo:: (*) Prose not spliced, for the prose merges the two cases of null and non-null references.

1. Assert: due to :ref:`validation <valid-call_ref>`, a null or :ref:`function reference <syntax-ref>` is on the top of the stack.

2. Pop the reference value :math:`r` from the stack.

3. If :math:`r` is :math:`\REFNULL~\X{ht}`, then:

    a. Trap.

4. Assert: due to :ref:`validation <valid-call_ref>`, :math:`r` is a :ref:`function reference <syntax-ref>`.

5. Let :math:`\REFFUNCADDR~a` be the reference :math:`r`.

6. :ref:`Invoke <exec-invoke>` the function instance at address :math:`a`.

$${rule: {Step_read/call_ref-null}}

.. note::
   The formal rule for calling a non-null function reference is described :ref:`below <exec-invoke>`.


.. _exec-call_indirect:

$${rule-prose: Step_pure/call_indirect}

$${rule: {Step_pure/call_indirect}}


.. _exec-return_call:

$${rule-prose: Step_read/return_call}

$${rule: {Step_read/return_call}}


.. _exec-return_call_ref:

$${rule-prose: Step_read/return_call_ref}

$${rule: {Step_read/return_call_ref-*}}


.. _exec-return_call_indirect:

$${rule-prose: Step_pure/return_call_indirect}

$${rule: {Step_pure/return_call_indirect}}


.. _exec-throw:

$${rule-prose: Step/throw}

$${rule: Step/throw}


.. _exec-throw_ref:

$${rule-prose: Step_read/throw_ref}

$${rule: Step_read/throw_ref-*}


.. _exec-try_table:

$${rule-prose: Step_read/try_table}

$${rule: Step_read/try_table}


.. index:: instruction, instruction sequence, block, exception, trap
.. _exec-instrs:

Blocks
~~~~~~

The following auxiliary rules define the semantics of executing an :ref:`instruction sequence <syntax-instrs>`
that forms a :ref:`block <exec-instr-control>`.


.. _exec-instrs-enter:

Entering :math:`\instr^\ast` with label :math:`L` and values :math:`\val^\ast`
..............................................................................

1. Push :math:`L` to the stack.

2. Push the values :math:`\val^\ast` to the stack.

3. Jump to the start of the instruction sequence :math:`\instr^\ast`.

.. note::
   No formal reduction rule is needed for entering an instruction sequence,
   because the label :math:`L` is embedded in the :ref:`administrative instruction <syntax-instr-admin>` that structured control instructions reduce to directly.


.. _exec-instrs-exit:

Exiting :math:`\instr^\ast` with label :math:`L`
................................................

When the end of a block is reached without a jump, :ref:`exception <exception>`, or :ref:`trap <trap>` aborting it, then the following steps are performed.

1. Pop all values :math:`\val^\ast` from the top of the stack.

2. Assert: due to :ref:`validation <valid-instrs>`, the label :math:`L` is now on the top of the stack.

3. Pop the label from the stack.

4. Push :math:`\val^\ast` back to the stack.

5. Jump to the position after the end of the :ref:`structured control instruction <syntax-instr-control>` associated with the label :math:`L`.

$${rule: Step_pure/label-vals}

.. note::
   This semantics also applies to the instruction sequence contained in a ${:LOOP} instruction.
   Therefore, execution of a loop falls off the end, unless a backwards branch is performed explicitly.


.. index:: exception, handler, throw context, tag, exception tag

.. _exec-handler:

Exception Handling
~~~~~~~~~~~~~~~~~~

The following auxiliary rules define the semantics of entering and exiting ${:TRY_TABLE} blocks.

.. _exec-handler-enter:

Entering :math:`\instr^\ast` with label :math:`L` and exception handler :math:`H`
.................................................................................

1. Push :math:`H` to the stack.

2. Push :math:`L` onto the stack.

3. Jump to the start of the instruction sequence :math:`\instr^\ast`.

.. note::
   No formal reduction rule is needed for entering an exception :ref:`handler <syntax-handler>`
   because it is an :ref:`administrative instruction <syntax-instr-admin>`
   that the ${:TRY_TABLE} instruction reduces to directly.


.. _exec-handler-exit:

Exiting an exception handler
............................

When the end of a ${:TRY_TABLE} block is reached without a jump, :ref:`exception <exception>`, or :ref:`trap <trap>`, then the following steps are performed.

1. Let :math:`m` be the number of values on the top of the stack.

2. Pop the values :math:`\val^m` from the stack.

3. Assert: due to :ref:`validation <valid-instrs>`, a handler and a label are now on the top of the stack.

4. Pop the label from the stack.

5. Pop the handler :math:`H` from the stack.

6. Push :math:`\val^m` back to the stack.

7. Jump to the position after the end of the administrative instruction associated with the handler :math:`H`.

$${rule: Step_pure/handler-vals}


.. index:: ! call, function, function instance, label, frame

Function Calls
~~~~~~~~~~~~~~

The following auxiliary rules define the semantics of invoking a :ref:`function instance <syntax-funcinst>`
through one of the :ref:`call instructions <exec-instr-control>`
and returning from it.


.. _exec-invoke:

Invocation of :ref:`function reference <syntax-ref.func>` :math:`(\REFFUNCADDR~a)`
..................................................................................

1. Assert: due to :ref:`validation <valid-call>`, :math:`S.\SFUNCS[a]` exists.

2. Let :math:`f` be the :ref:`function instance <syntax-funcinst>`, :math:`S.\SFUNCS[a]`.

3. Let :math:`\TFUNC~[t_1^n] \Tarrow [t_2^m]` be the :ref:`composite type <syntax-comptype>` :math:`\expanddt(\X{f}.\FITYPE)`.

4. Let :math:`\FUNC~x~\local^\ast~\instr^\ast` be the :ref:`function <syntax-func>` :math:`f.\FICODE`.

5. Assert: due to :ref:`validation <valid-call>`, :math:`n` values are on the top of the stack.

6. Pop the values :math:`\val^n` from the stack.

7. Let :math:`F` be the :ref:`frame <syntax-frame>` :math:`\{ \AMODULE~F.\FIMODULE, \ALOCALS~\val^n~(\default_t)^\ast \}`.

8. Push the activation of :math:`f` with arity :math:`m` to the stack.

9. Let :math:`L` be the :ref:`label <syntax-label>` whose arity is :math:`m` and whose continuation is the end of the function.

10. :ref:`Enter <exec-instrs-enter>` the instruction sequence :math:`\instr^\ast` with label :math:`L` and no values.

$${rule: {Step_read/call_ref-func}}

.. note::
   For non-defaultable types, the respective local is left uninitialized by these rules.


.. _exec-invoke-exit:

Returning from a function
.........................

When the end of a function is reached without a jump (including through |RETURN|), or an :ref:`exception <exception>` or :ref:`trap <trap>` aborting it, then the following steps are performed.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Let :math:`n` be the arity of the activation of :math:`F`.

3. Assert: due to :ref:`validation <valid-instrs>`, there are :math:`n` values on the top of the stack.

4. Pop the results :math:`\val^n` from the stack.

5. Assert: due to :ref:`validation <valid-func>`, the frame :math:`F` is now on the top of the stack.

6. Pop the frame from the stack.

7. Push :math:`\val^n` back to the stack.

8. Jump to the instruction after the original call.

$${rule: Step_pure/frame-vals}


.. index:: host function, store
.. _exec-invoke-host:

Host Functions
..............

Invoking a :ref:`host function <syntax-hostfunc>` has non-deterministic behavior.
It may either terminate with a :ref:`trap <trap>`, an :ref:`exception <exception>`, or return regularly.
However, in the latter case, it must consume and produce the right number and types of WebAssembly :ref:`values <syntax-val>` on the stack,
according to its :ref:`function type <syntax-functype>`.

A host function may also modify the :ref:`store <syntax-store>`.
However, all store modifications must result in an :ref:`extension <extend-store>` of the original store, i.e., they must only modify mutable contents and must not have instances removed.
Furthermore, the resulting store must be :ref:`valid <valid-store>`, i.e., all data and code in it is well-typed.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; \val^n~(\REFFUNCADDR~a)~\CALLREF &\stepto& S'; \result
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     \iff & S.\SFUNCS[a] = \{ \FITYPE~\deftype, \FIHOSTFUNC~\X{hf} \} \\
     \wedge & \deftype \approx \TFUNC~[t_1^n] \Tarrow [t_2^m] \\
     \wedge & (S'; \result) \in \X{hf}(S; \val^n) \\
     \end{array} \\
   \begin{array}{lcl@{\qquad}l}
   S; \val^n~(\REFFUNCADDR~a)~\CALLREF &\stepto& S; \val^n~(\REFFUNCADDR~a)~\CALLREF
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     \iff & S.\SFUNCS[a] = \{ \FITYPE~\deftype, \FIHOSTFUNC~\X{hf} \} \\
     \wedge & \deftype \approx \TFUNC~[t_1^n] \Tarrow [t_2^m] \\
     \wedge & \bot \in \X{hf}(S; \val^n) \\
     \end{array} \\
   \end{array}

Here, :math:`\X{hf}(S; \val^n)` denotes the implementation-defined execution of host function :math:`\X{hf}` in current store :math:`S` with arguments :math:`\val^n`.
It yields a set of possible outcomes, where each element is either a pair of a modified store :math:`S'` and a :ref:`result <syntax-result>`
or the special value :math:`\bot` indicating divergence.
A host function is non-deterministic if there is at least one argument for which the set of outcomes is not singular.

For a WebAssembly implementation to be :ref:`sound <soundness>` in the presence of host functions,
every :ref:`host function instance <syntax-funcinst>` must be :ref:`valid <valid-hostfuncinst>`,
which means that it adheres to suitable pre- and post-conditions:
under a :ref:`valid store <valid-store>` :math:`S`, and given arguments :math:`\val^n` matching the ascribed parameter types :math:`t_1^n`,
executing the host function must yield a non-empty set of possible outcomes each of which is either divergence or consists of a valid store :math:`S'` that is an :ref:`extension <extend-store>` of :math:`S` and a result matching the ascribed return types :math:`t_2^m`.
All these notions are made precise in the :ref:`Appendix <soundness>`.

.. note::
   A host function can call back into WebAssembly by :ref:`invoking <exec-invocation>` a function :ref:`exported <syntax-export>` from a :ref:`module <syntax-module>`.
   However, the effects of any such call are subsumed by the non-deterministic behavior allowed for the host function.


.. index:: variable instructions, local index, global index, address, global address, global instance, store, frame, value
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _exec-local.get:

$${rule-prose: Step_read/local.get}

$${rule: Step_read/local.get}


.. _exec-local.set:

$${rule-prose: Step/local.set}

$${rule: Step/local.set}


.. _exec-local.tee:

$${rule-prose: Step_pure/local.tee}

$${rule: Step_pure/local.tee}


.. _exec-global.get:

$${rule-prose: Step_read/global.get}

$${rule: Step_read/global.get}


.. _exec-global.set:

$${rule-prose: Step/global.set}

$${rule: Step/global.set}


.. index:: table instruction, table index, store, frame, address, table address, table instance, element address, element instance, value, integer, limits, reference, reference type
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-table:

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _exec-table.get:

$${rule-prose: Step_read/table.get}

$${rule: {Step_read/table.get-*}}


.. _exec-table.set:

$${rule-prose: Step/table.set}

$${rule: {Step/table.set-*}}


.. _exec-table.size:

$${rule-prose: Step_read/table.size}

$${rule: Step_read/table.size}


.. index:: determinism, non-determinism
.. _exec-table.grow:

$${rule-prose: Step/table.grow}

$${rule: {Step/table.grow-*}}

.. note::
   The |TABLEGROW| instruction is non-deterministic.
   It may either succeed, returning the old table size :math:`\X{sz}`,
   or fail, returning :math:`{-1}`.
   Failure *must* occur if the referenced table instance has a maximum size defined that would be exceeded.
   However, failure *can* occur in other cases as well.
   In practice, the choice depends on the :ref:`resources <impl-exec>` available to the :ref:`embedder <embedder>`.


.. _exec-table.fill:

$${rule-prose: Step_read/table.fill}

$${rule: {Step_read/table.fill-*}}


.. _exec-table.copy:

$${rule-prose: Step_read/table.copy}

$${rule: {Step_read/table.copy-*}}


.. _exec-table.init:

$${rule-prose: Step_read/table.init}

$${rule: {Step_read/table.init-*}}


.. _exec-elem.drop:

$${rule-prose: Step/elem.drop}

$${rule: Step/elem.drop}


.. index:: memory instruction, memory index, store, frame, address, memory address, memory instance, value, integer, limits, value type, bit width
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-memarg:
.. _exec-instr-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. note::
   The alignment :math:`\memarg.\ALIGN` in load and store instructions does not affect the semantics.
   It is a hint that the offset :math:`\X{ea}` at which the memory is accessed is intended to satisfy the property :math:`\X{ea} \mod 2^{\memarg.\ALIGN} = 0`.
   A WebAssembly implementation can use this hint to optimize for the intended use.
   Unaligned access violating that property is still allowed and must succeed regardless of the annotation.
   However, it may be substantially slower on some hardware.


.. _exec-load-val:
.. _exec-load-pack:
.. _exec-vload-val:

$${rule-prose: Step_read/load}

$${rule: {Step_read/load-*}}


.. _exec-vload-pack:

$${rule-prose: Step_read/vload-pack-*}

$${rule: {Step_read/vload-pack-*}}


.. _exec-vload-splat:

$${rule-prose: Step_read/vload-splat-*}

$${rule: {Step_read/vload-splat-*}}


.. _exec-vload-zero:

$${rule-prose: Step_read/vload-zero-*}

$${rule: {Step_read/vload-zero-*}}


.. _exec-vload_lane:

$${rule-prose: Step_read/vload_lane}

$${rule: {Step_read/vload_lane-*}}


.. _exec-store-val:
.. _exec-store-pack:
.. _exec-vstore:

$${rule-prose: Step/store}

$${rule: {Step/store-* Step/vstore-*}}


.. _exec-vstore_lane:

$${rule-prose: Step/vstore_lane}

$${rule: {Step/vstore_lane-*}}


.. _exec-memory.size:

$${rule-prose: Step_read/memory.size}

$${rule: {Step_read/memory.size}}


.. index:: determinism, non-determinism
.. _exec-memory.grow:

$${rule-prose: Step/memory.grow}

$${rule: {Step/memory.grow-*}}

.. note::
   The |MEMORYGROW| instruction is non-deterministic.
   It may either succeed, returning the old memory size :math:`\X{sz}`,
   or fail, returning :math:`{-1}`.
   Failure *must* occur if the referenced memory instance has a maximum size defined that would be exceeded.
   However, failure *can* occur in other cases as well.
   In practice, the choice depends on the :ref:`resources <impl-exec>` available to the :ref:`embedder <embedder>`.


.. _exec-memory.fill:

$${rule-prose: Step_read/memory.fill}

$${rule: {Step_read/memory.fill-*}}


.. _exec-memory.copy:

$${rule-prose: Step_read/memory.copy}

$${rule: {Step_read/memory.copy-*}}


.. _exec-memory.init:

$${rule-prose: Step_read/memory.init}

$${rule: {Step_read/memory.init-*}}


.. _exec-data.drop:

$${rule-prose: Step/data.drop}

$${rule: {Step/data.drop}}


.. index:: reference instructions, reference
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _exec-ref.null:

:math:`\REFNULL~x`
.......................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-ref.null>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Push the value :math:`\REFNULL~\deftype` to the stack.

$${rule: {Step_read/ref.null-*}}

.. note::
   No formal reduction rule is required for the case |REFNULL| |ABSHEAPTYPE|,
   since the instruction form is already a :ref:`value <syntax-val>`.


.. _exec-ref.func:

$${rule-prose: Step_read/ref.func}

$${rule: Step_read/ref.func}


.. _exec-ref.is_null:

$${rule-prose: Step_pure/ref.is_null}

$${rule: {Step_pure/ref.is_null-*}}


.. _exec-ref.as_non_null:

$${rule-prose: Step_pure/ref.as_non_null}

$${rule: {Step_pure/ref.as_non_null-*}}


.. _exec-ref.eq:

$${rule-prose: Step_pure/ref.eq}

$${rule: {Step_pure/ref.eq-*}}


.. _exec-ref.test:

$${rule-prose: Step_read/ref.test}

$${rule: {Step_read/ref.test-*}}


.. _exec-ref.cast:

$${rule-prose: Step_read/ref.cast}

$${rule: {Step_read/ref.cast-*}}


.. _exec-ref.i31:

$${rule-prose: Step_pure/ref.i31}

$${rule: {Step_pure/ref.i31}}


.. _exec-i31.get:

$${rule-prose: Step_pure/i31.get}

$${rule: {Step_pure/i31.get-*}}


.. _exec-struct.new:

$${rule-prose: Step/struct.new}

$${rule: {Step/struct.new}}


.. _exec-struct.new_default:

$${rule-prose: Step_read/struct.new_default}

$${rule: {Step_read/struct.new_default}}


.. _exec-struct.get:
.. _exec-struct.get_sx:

$${rule-prose: Step_read/struct.get}

$${rule: {Step_read/struct.get-*}}


.. _exec-struct.set:

$${rule-prose: Step/struct.set}

$${rule: {Step/struct.set-*}}
   

.. _exec-array.new:

$${rule-prose: Step_pure/array.new}

$${rule: {Step_pure/array.new}}


.. _exec-array.new_default:

$${rule-prose: Step_read/array.new_default}

$${rule: {Step_read/array.new_default}}


.. _exec-array.new_fixed:

$${rule-prose: Step/array.new_fixed}

$${rule: {Step/array.new_fixed}}


.. _exec-array.new_data:

$${rule-prose: Step_read/array.new_data}

$${rule: {Step_read/array.new_data-*}}


.. _exec-array.new_elem:

$${rule-prose: Step_read/array.new_elem}

$${rule: {Step_read/array.new_elem-*}}


.. _exec-array.get:
.. _exec-array.get_sx:

$${rule-prose: Step_read/array.get}

$${rule: {Step_read/array.get-*}}


.. _exec-array.set:

$${rule-prose: Step/array.set}

$${rule: {Step/array.set-*}}


.. _exec-array.len:

$${rule-prose: Step_read/array.len}

$${rule: {Step_read/array.len-*}}


.. _exec-array.fill:

$${rule-prose: Step_read/array.fill}

$${rule: {Step_read/array.fill-*}}


.. _exec-array.copy:

$${rule-prose: Step_read/array.copy}

$${rule: {Step_read/array.copy-*}}

Where:

.. _aux-sx:

$${definition: sx}

.. _exec-array.init_data:

$${rule-prose: Step_read/array.init_data}

$${rule: {Step_read/array.init_data-*}}


.. _exec-array.init_elem:

$${rule-prose: Step_read/array.init_elem}

$${rule: {Step_read/array.init_elem-*}}


.. _exec-any.convert_extern:

$${rule-prose: Step_pure/any.convert_extern}

$${rule: {Step_pure/any.convert_extern-*}}


.. _exec-extern.convert_any:

$${rule-prose: Step_pure/extern.convert_any}

$${rule: {Step_pure/extern.convert_any-*}}


.. index:: numeric instruction, determinism, non-determinism, trap, NaN, value, value type
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

Numeric instructions are defined in terms of the generic :ref:`numeric operators <exec-numeric>`.
The mapping of numeric instructions to their underlying operators is expressed by the following definition:

.. math::
   \begin{array}{lll@{\qquad}l}
   \X{op}_{\IN}(i_1,\dots,i_k) &=& \xref{Step_pure/numerics}{int-ops}{\F{i}\X{op}}_N(i_1,\dots,i_k) \\
   \X{op}_{\FN}(z_1,\dots,z_k) &=& \xref{Step_pure/numerics}{float-ops}{\F{f}\X{op}}_N(z_1,\dots,z_k) \\
   \end{array}

And for :ref:`conversion operators <exec-cvtop>`:

.. math::
   \begin{array}{lll@{\qquad}l}
   \cvtop^{\sx^?}_{t_1,t_2}(c) &=& \xref{Step_pure/numerics}{convert-ops}{\X{cvtop}}^{\sx^?}_{|t_1|,|t_2|}(c) \\
   \end{array}

Where the underlying operators are partial, the corresponding instruction will :ref:`trap <trap>` when the result is not defined.
Where the underlying operators are non-deterministic, because they may return one of multiple possible :ref:`NaN <syntax-nan>` values, so are the corresponding instructions.

.. note::
   For example, the result of instruction :math:`\I32.\ADD` applied to operands :math:`i_1, i_2`
   invokes :math:`\ADD_{\I32}(i_1, i_2)`,
   which maps to the generic :math:`\iadd_{32}(i_1, i_2)` via the above definition.
   Similarly, :math:`\I64.\TRUNC\K{\_}\F32\K{\_s}` applied to :math:`z`
   invokes :math:`\TRUNC^{\K{s}}_{\F32,\I64}(z)`,
   which maps to the generic :math:`\truncs_{32,64}(z)`.


.. _exec-const:

:math:`\X{nt}\K{.}\CONST~c`
...........................

1. Push the value ${instr: (CONST nt c)} to the stack.

.. note::
   No formal reduction rule is required for this instruction, since ${:CONST} instructions already are :ref:`values <syntax-val>`.


.. _exec-unop:

$${rule-prose: Step_pure/unop}

$${rule: {Step_pure/unop-*}}


.. _exec-binop:

$${rule-prose: Step_pure/binop}

$${rule: {Step_pure/binop-*}}


.. _exec-testop:

$${rule-prose: Step_pure/testop}

$${rule: Step_pure/testop}


.. _exec-relop:

$${rule-prose: Step_pure/relop}

$${rule: Step_pure/relop}


.. _exec-cvtop:

$${rule-prose: Step_pure/cvtop}

$${rule: {Step_pure/cvtop-*}}


.. index:: vector instruction
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-vec:

Vector Instructions
~~~~~~~~~~~~~~~~~~~

Vector instructions that operate bitwise are handled as integer operations of respective bit width.

.. math::
   \begin{array}{lll@{\qquad}l}
   \X{op}_{\VN}(i_1,\dots,i_k) &=& \xref{Step_pure/numerics}{int-ops}{\F{i}\X{op}}_N(i_1,\dots,i_k) \\
   \end{array}

Most other vector instructions are defined in terms of :ref:`numeric operators <exec-numeric>` that are applied lane-wise according to the given :ref:`shape <syntax-shape>`.

.. math::
   \begin{array}{llll}
   \X{op}_{t\K{x}N}(n_1,\dots,n_k) &=&
     \lanes^{-1}_{t\K{x}N}(\xref{Step_pure/instructions}{exec-instr-numeric}{\X{op}}_t(i_1,\dots,i_k)^\ast) & \qquad(\iff i_1^\ast = \lanes_{t\K{x}N}(n_1) \land \dots \land i_k^\ast = \lanes_{t\K{x}N}(n_k) \\
   \end{array}

.. note::
   For example, the result of instruction :math:`\K{i32x4}.\ADD` applied to operands :math:`v_1, v_2`
   invokes :math:`\ADD_{\K{i32x4}}(v_1, v_2)`, which maps to
   :math:`\lanes^{-1}_{\K{i32x4}}(\ADD_{\I32}(i_1, i_2)^\ast)`,
   where :math:`i_1^\ast` and :math:`i_2^\ast` are sequences resulting from invoking
   :math:`\lanes_{\K{i32x4}}(v_1)` and :math:`\lanes_{\K{i32x4}}(v_2)`
   respectively.

For non-deterministic operators this definition is generalized to sets:

.. math::
   \begin{array}{lll}
   \X{op}_{t\K{x}N}(n_1,\dots,n_k) &=&
     \{ \lanes^{-1}_{t\K{x}N}(i^\ast) ~|~ i^\ast \in {\Large\times}(\xref{Step_pure/instructions}{exec-instr-numeric}{\X{op}}_t(i_1,\dots,i_k)^\ast) \land i_1^\ast = \lanes_{t\K{x}N}(n_1) \land \dots \land i_k^\ast = \lanes_{t\K{x}N}(n_k) \} \\
   \end{array}

where :math:`{\Large\times} \{x^\ast\}^N` transforms a sequence of :math:`N` sets of values into a set of sequences of :math:`N` values by computing the set product:

.. math::
   \begin{array}{lll}
   {\Large\times} (S_1 \dots S_N) &=& \{ x_1 \dots x_N ~|~ x_1 \in S_1 \land \dots \land x_N \in S_N \}
   \end{array}

The remaining vector operators use :ref:`individual definitions <op-vec>`.


.. _exec-vconst:

:math:`\V128\K{.}\VCONST~c`
...........................

1. Push the value ${instr: (VCONST V128 c)} to the stack.

.. note::
   No formal reduction rule is required for this instruction, since ${:CONST} instructions are already :ref:`values <syntax-val>`.


.. _exec-vvunop:

$${rule-prose: Step_pure/vvunop}

$${rule: {Step_pure/vvunop}}


.. _exec-vvbinop:

$${rule-prose: Step_pure/vvbinop}

$${rule: {Step_pure/vvbinop}}


.. _exec-vvternop:

$${rule-prose: Step_pure/vvternop}

$${rule: {Step_pure/vvternop}}


.. _exec-vvtestop:

$${rule-prose: Step_pure/vvtestop}

$${rule: {Step_pure/vvtestop}}


.. _exec-vunop:

$${rule-prose: Step_pure/vunop}

$${rule: {Step_pure/vunop-*}}


.. _exec-vbinop:

$${rule-prose: Step_pure/vbinop}

$${rule: {Step_pure/vbinop-*}}


.. _exec-vternop:

$${rule-prose: Step_pure/vternop}

$${rule: {Step_pure/vternop-*}}


.. _exec-vtestop:

$${rule-prose: Step_pure/vtestop}

$${rule: {Step_pure/vtestop}}


.. _exec-vrelop:

$${rule-prose: Step_pure/vrelop}

$${rule: {Step_pure/vrelop}}


.. _exec-vshiftop:

$${rule-prose: Step_pure/vshiftop}

$${rule: {Step_pure/vshiftop}}


.. _exec-vbitmask:

$${rule-prose: Step_pure/vbitmask}

$${rule: {Step_pure/vbitmask}}


.. _exec-vswizzlop:

$${rule-prose: Step_pure/vswizzlop}

$${rule: {Step_pure/vswizzlop}}


.. _exec-vshuffle:

$${rule-prose: Step_pure/vshuffle}

$${rule: {Step_pure/vshuffle}}


.. _exec-vsplat:

$${rule-prose: Step_pure/vsplat}

$${rule: {Step_pure/vsplat}}


.. _exec-vextract_lane:

$${rule-prose: Step_pure/vextract_lane}

$${rule: {Step_pure/vextract_lane-*}}


.. _exec-vreplace_lane:

$${rule-prose: Step_pure/vreplace_lane}

$${rule: {Step_pure/vreplace_lane}}


.. _exec-vextunop:

$${rule-prose: Step_pure/vextunop}

$${rule: {Step_pure/vextunop}}


.. _exec-vextbinop:

$${rule-prose: Step_pure/vextbinop}

$${rule: {Step_pure/vextbinop}}


.. _exec-vextternop:

$${rule-prose: Step_pure/vextternop}

$${rule: {Step_pure/vextternop}}


.. _exec-vnarrow:

$${rule-prose: Step_pure/vnarrow}

$${rule: {Step_pure/vnarrow}}


.. _exec-vcvtop:

$${rule-prose: Step_pure/vcvtop}

$${rule: {Step_pure/vcvtop}}


.. index:: expression
   pair: execution; expression
   single: abstract syntax; expression
.. _exec-expr:

Expressions
~~~~~~~~~~~

An :ref:`expression <syntax-expr>` is *evaluated* relative to a :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>` pointing to its containing :ref:`module instance <syntax-moduleinst>`.

$${rule-prose: Eval_expr}

$${rule: Eval_expr}

.. note::
   Evaluation iterates this reduction rule until reaching a value.
   Expressions constituting :ref:`function <syntax-func>` bodies are executed during function :ref:`invocation <exec-invoke>`.

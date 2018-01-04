.. index:: ! runtime
.. _syntax-runtime:

Runtime Structure
-----------------

:ref:`Store <store>`, :ref:`stack <stack>`, and other *runtime structure* forming the WebAssembly abstract machine, such as :ref:`values <syntax-val>` or :ref:`module instances <syntax-moduleinst>`, are made precise in terms of additional auxiliary syntax.


.. index:: ! value, constant, value type, integer, floating-point
   pair: abstract syntax; value
.. _syntax-val:

Values
~~~~~~

WebAssembly computations manipulate *values* of the four basic :ref:`value types <syntax-valtype>`: :ref:`integers <syntax-int>` and :ref:`floating-point data <syntax-float>` of 32 or 64 bit width each, respectively.

In most places of the semantics, values of different types can occur.
In order to avoid ambiguities, values are therefore represented with an abstract syntax that makes their type explicit.
It is convenient to reuse the same notation as for the |CONST| :ref:`instructions <syntax-const>` producing them:

.. math::
   \begin{array}{llcl}
   \production{(value)} & \val &::=&
     \I32.\CONST~\i32 \\&&|&
     \I64.\CONST~\i64 \\&&|&
     \F32.\CONST~\f32 \\&&|&
     \F64.\CONST~\f64
   \end{array}


.. index:: ! result, value, trap
   pair: abstract syntax; result
.. _syntax-result:

Results
~~~~~~~

A *result* is the outcome of a computation.
It is either a sequence of :ref:`values <syntax-val>` or a :ref:`trap <syntax-trap>`.

.. math::
   \begin{array}{llcl}
   \production{(result)} & \result &::=&
     \val^\ast \\&&|&
     \TRAP
   \end{array}

.. note::
   In the current version of WebAssembly, a result can consist of at most one value.


.. index:: ! store, function instance, table instance, memory instance, global instance, module, allocation
   pair: abstract syntax; store
.. _syntax-store:
.. _store:

Store
~~~~~

The *store* represents all global state that can be manipulated by WebAssembly programs.
It consists of the runtime representation of all *instances* of :ref:`functions <syntax-funcinst>`, :ref:`tables <syntax-tableinst>`, :ref:`memories <syntax-meminst>`, and :ref:`globals <syntax-globalinst>` that have been :ref:`allocated <alloc>` during the life time of the abstract machine. [#gc]_

Syntactically, the store is defined as a :ref:`record <notation-record>` listing the existing instances of each category:

.. math::
   \begin{array}{llll}
   \production{(store)} & \store &::=& \{~
     \begin{array}[t]{l@{~}ll}
     \SFUNCS & \funcinst^\ast, \\
     \STABLES & \tableinst^\ast, \\
     \SMEMS & \meminst^\ast, \\
     \SGLOBALS & \globalinst^\ast ~\} \\
     \end{array}
   \end{array}

.. [#gc]
   In practice, implementations may apply techniques like garbage collection to remove objects from the store that are no longer referenced.
   However, such techniques are not semantically observable,
   and hence outside the scope of this specification.


Convention
..........

* The meta variable :math:`S` ranges over stores where clear from context.


.. index:: ! address, store, function instance, table instance, memory instance, global instance, embedder
   pair: abstract syntax; function address
   pair: abstract syntax; table address
   pair: abstract syntax; memory address
   pair: abstract syntax; global address
   pair: function; address
   pair: table; address
   pair: memory; address
   pair: global; address
.. _syntax-funcaddr:
.. _syntax-tableaddr:
.. _syntax-memaddr:
.. _syntax-globaladdr:
.. _syntax-addr:

Addresses
~~~~~~~~~

:ref:`Function instances <syntax-funcinst>`, :ref:`table instances <syntax-tableinst>`, :ref:`memory instances <syntax-meminst>`, and :ref:`global instances <syntax-globalinst>` in the :ref:`store <syntax-store>` are referenced with abstract *addresses*.
These are simply indices into the respective store component.

.. math::
   \begin{array}{llll}
   \production{(address)} & \addr &::=&
     0 ~|~ 1 ~|~ 2 ~|~ \dots \\
   \production{(function address)} & \funcaddr &::=&
     \addr \\
   \production{(table address)} & \tableaddr &::=&
     \addr \\
   \production{(memory address)} & \memaddr &::=&
     \addr \\
   \production{(global address)} & \globaladdr &::=&
     \addr \\
   \end{array}

An :ref:`embedder <embedder>` may assign identity to :ref:`exported <syntax-export>` store objects corresponding to their addresses,
even where this identity is not observable from within WebAssembly code itself
(such as for :ref:`function instances <syntax-funcinst>` or immutable :ref:`globals <syntax-globalinst>`).

.. note::
   Addresses are *dynamic*, globally unique references to runtime objects,
   in contrast to :ref:`indices <syntax-index>`,
   which are *static*, module-local references to their original definitions.
   A *memory address* |memaddr| denotes the abstract address *of* a memory *instance* in the store,
   not an offset *inside* a memory instance.

   There is no specific limit on the number of allocations of store objects,
   hence logical addresses can be arbitrarily large natural numbers.


.. index:: ! instance, function type, function instance, table instance, memory instance, global instance, export instance, table address, memory address, global address, index, name
   pair: abstract syntax; module instance
   pair: module; instance
.. _syntax-moduleinst:

Module Instances
~~~~~~~~~~~~~~~~

A *module instance* is the runtime representation of a :ref:`module <syntax-module>`.
It is created by :ref:`instantiating <exec-instantiation>` a module,
and collects runtime representations of all entities that are imported, defined, or exported by the module.

.. math::
   \begin{array}{llll}
   \production{(module instance)} & \moduleinst &::=& \{
     \begin{array}[t]{l@{~}ll}
     \MITYPES & \functype^\ast, \\
     \MIFUNCS & \funcaddr^\ast, \\
     \MITABLES & \tableaddr^\ast, \\
     \MIMEMS & \memaddr^\ast, \\
     \MIGLOBALS & \globaladdr^\ast, \\
     \MIEXPORTS & \exportinst^\ast ~\} \\
     \end{array}
   \end{array}

Each component references runtime instances corresponding to respective declarations from the original module -- whether imported or defined -- in the order of their static :ref:`indices <syntax-index>`.
:ref:`Function instances <syntax-funcinst>`, :ref:`table instances <syntax-tableinst>`, :ref:`memory instances <syntax-meminst>`, and :ref:`global instances <syntax-globalinst>` are referenced with an indirection through their respective :ref:`addresses <syntax-addr>` in the :ref:`store <syntax-store>`.

It is an invariant of the semantics that all :ref:`export instances <syntax-exportinst>` in a given module instance have different :ref:`names <syntax-name>`.


.. index:: ! function instance, module instance, function, closure, module, ! host function, invocation
   pair: abstract syntax; function instance
   pair: function; instance
.. _syntax-hostfunc:
.. _syntax-funcinst:

Function Instances
~~~~~~~~~~~~~~~~~~

A *function instance* is the runtime representation of a :ref:`function <syntax-func>`.
It effectively is a *closure* of the original function over the runtime :ref:`module instance <syntax-moduleinst>` of its originating :ref:`module <syntax-module>`.
The module instance is used to resolve references to other definitions during execution of the function.

.. math::
   \begin{array}{llll}
   \production{(function instance)} & \funcinst &::=&
     \{ \FITYPE~\functype, \FIMODULE~\moduleinst, \FICODE~\func \} \\ &&|&
     \{ \FITYPE~\functype, \FIHOSTCODE~\hostfunc \} \\
   \production{(host function)} & \hostfunc &::=& \dots \\
   \end{array}

A *host function* is a function expressed outside WebAssembly but passed to a :ref:`module <syntax-module>` as an :ref:`import <syntax-import>`.
The definition and behavior of host functions are outside the scope of this specification.
For the purpose of this specification, it is assumed that when :ref:`invoked <exec-invoke-host>`,
a host function behaves non-deterministically,
but within certain :ref:`constraints <exec-invoke-host>` that ensure the integrity of the runtime.

.. note::
   Function instances are immutable, and their identity is not observable by WebAssembly code.
   However, the :ref:`embedder <embedder>` might provide implicit or explicit means for distinguishing their :ref:`addresses <syntax-funcaddr>`.


.. index:: ! table instance, table, function address, table type, embedder, element segment
   pair: abstract syntax; table instance
   pair: table; instance
.. _syntax-funcelem:
.. _syntax-tableinst:

Table Instances
~~~~~~~~~~~~~~~

A *table instance* is the runtime representation of a :ref:`table <syntax-table>`.
It holds a vector of *function elements* and an optional maximum size, if one was specified in the :ref:`table type <syntax-tabletype>` at the table's definition site.

Each function element is either empty, representing an uninitialized table entry, or a :ref:`function address <syntax-funcaddr>`.
Function elements can be mutated through the execution of an :ref:`element segment <syntax-elem>` or by external means provided by the :ref:`embedder <embedder>`.

.. math::
   \begin{array}{llll}
   \production{(table instance)} & \tableinst &::=&
     \{ \TIELEM~\vec(\funcelem), \TIMAX~\u32^? \} \\
   \production{(function element)} & \funcelem &::=&
     \funcaddr^? \\
   \end{array}

It is an invariant of the semantics that the length of the element vector never exceeds the maximum size, if present.

.. note::
   Other table elements may be added in future versions of WebAssembly.


.. index:: ! memory instance, memory, byte, ! page size, memory type, embedder, data segment, instruction
   pair: abstract syntax; memory instance
   pair: memory; instance
.. _page-size:
.. _syntax-meminst:

Memory Instances
~~~~~~~~~~~~~~~~

A *memory instance* is the runtime representation of a linear :ref:`memory <syntax-mem>`.
It holds a vector of :ref:`bytes <syntax-byte>` and an optional maximum size, if one was specified at the definition site of the memory.

.. math::
   \begin{array}{llll}
   \production{(memory instance)} & \meminst &::=&
     \{ \MIDATA~\vec(\byte), \MIMAX~\u32^? \} \\
   \end{array}

The length of the vector always is a multiple of the WebAssembly *page size*, which is defined to be the constant :math:`65536` -- abbreviated :math:`64\,\F{Ki}`.
Like in a :ref:`memory type <syntax-memtype>`, the maximum size in a memory instance is given in units of this page size.

The bytes can be mutated through :ref:`memory instructions <syntax-instr-memory>`, the execution of a :ref:`data segment <syntax-data>`, or by external means provided by the :ref:`embedder <embedder>`.

It is an invariant of the semantics that the length of the byte vector, divided by page size, never exceeds the maximum size, if present.


.. index:: ! global instance, global, value, mutability, instruction, embedder
   pair: abstract syntax; global instance
   pair: global; instance
.. _syntax-globalinst:

Global Instances
~~~~~~~~~~~~~~~~

A *global instance* is the runtime representation of a :ref:`global <syntax-global>` variable.
It holds an individual :ref:`value <syntax-val>` and a flag indicating whether it is mutable.

.. math::
   \begin{array}{llll}
   \production{(global instance)} & \globalinst &::=&
     \{ \GIVALUE~\val, \GIMUT~\mut \} \\
   \end{array}

The value of mutable globals can be mutated through :ref:`variable instructions <syntax-instr-variable>` or by external means provided by the :ref:`embedder <embedder>`.


.. index:: ! export instance, export, name, external value
   pair: abstract syntax; export instance
   pair: export; instance
.. _syntax-exportinst:

Export Instances
~~~~~~~~~~~~~~~~

An *export instance* is the runtime representation of an :ref:`export <syntax-export>`.
It defines the export's :ref:`name <syntax-name>` and the associated :ref:`external value <syntax-externval>`.

.. math::
   \begin{array}{llll}
   \production{(export instance)} & \exportinst &::=&
     \{ \EINAME~\name, \EIVALUE~\externval \} \\
   \end{array}


.. index:: ! external value, function address, table address, memory address, global address, store, function, table, memory, global
   pair: abstract syntax; external value
   pair: external; value
.. _syntax-externval:

External Values
~~~~~~~~~~~~~~~

An *external value* is the runtime representation of an entity that can be imported or exported.
It is an :ref:`address <syntax-addr>` denoting either a :ref:`function instance <syntax-funcinst>`, :ref:`table instance <syntax-tableinst>`, :ref:`memory instance <syntax-meminst>`, or :ref:`global instances <syntax-globalinst>` in the shared :ref:`store <syntax-store>`.

.. math::
   \begin{array}{llcl}
   \production{(external value)} & \externval &::=&
     \EVFUNC~\funcaddr \\&&|&
     \EVTABLE~\tableaddr \\&&|&
     \EVMEM~\memaddr \\&&|&
     \EVGLOBAL~\globaladdr \\
   \end{array}


Conventions
...........

The following auxiliary notation is defined for sequences of external values.
It filters out entries of a specific kind in an order-preserving fashion:

* :math:`\evfuncs(\externval^\ast) = [\funcaddr ~|~ (\EVFUNC~\funcaddr) \in \externval^\ast]`

* :math:`\evtables(\externval^\ast) = [\tableaddr ~|~ (\EVTABLE~\tableaddr) \in \externval^\ast]`

* :math:`\evmems(\externval^\ast) = [\memaddr ~|~ (\EVMEM~\memaddr) \in \externval^\ast]`

* :math:`\evglobals(\externval^\ast) = [\globaladdr ~|~ (\EVGLOBAL~\globaladdr) \in \externval^\ast]`



.. index:: ! stack, ! frame, ! label, instruction, store, activation, function, call, local, module instance
   pair: abstract syntax; frame
   pair: abstract syntax; label
.. _syntax-frame:
.. _syntax-label:
.. _frame:
.. _label:
.. _stack:

Stack
~~~~~

Besides the :ref:`store <store>`, most :ref:`instructions <syntax-instr>` interact with an implicit *stack*.
The stack contains three kinds of entries:

* *Values*: the *operands* of instructions.

* *Labels*: active :ref:`structured control instructions <syntax-instr-control>` that can be targeted by branches.

* *Activations*: the *call frames* of active :ref:`function <syntax-func>` calls.

These entries can occur on the stack in any order during the execution of a program.
Stack entries are described by abstract syntax as follows.

.. note::
   It is possible to model the WebAssebmly semantics using separate stacks for operands, control constructs, and calls.
   However, because the stacks are interdependent, additional book keeping about associated stack heights would be required.
   For the purpose of this specification, an interleaved representation is simpler.


Values
......

Values are represented by :ref:`themselves <syntax-val>`.

Labels
......

Labels carry an argument arity :math:`n` and their associated branch *target*, which is expressed syntactically as an :ref:`instruction <syntax-instr>` sequence:

.. math::
   \begin{array}{llll}
   \production{(label)} & \label &::=&
     \LABEL_n\{\instr^\ast\} \\
   \end{array}

Intuitively, :math:`\instr^\ast` is the *continuation* to execute when the branch is taken, in place of the original control construct.

.. note::
   For example, a loop label has the form

   .. math::
      \LABEL_n\{\LOOP~[t^?]~\dots~\END\}

   When performing a branch to this label, this executes the loop, effectively restarting it from the beginning.
   Conversely, a simple block label has the form

   .. math::
      \LABEL_n\{\epsilon\}

   When branching, the empty continuation ends the targeted block, such that execution can proceed with consecutive instructions.

Frames
......

Activation frames carry the return arity of the respective function,
hold the values of its :ref:`locals <syntax-local>` (including arguments) in the order corresponding to their static :ref:`local indices <syntax-localidx>`,
and a reference to the function's own :ref:`module instance <syntax-moduleinst>`:

.. math::
   \begin{array}{llll}
   \production{(activation)} & \X{activation} &::=&
     \FRAME_n\{\frame\} \\
   \production{(frame)} & \frame &::=&
     \{ \ALOCALS~\val^\ast, \AMODULE~\moduleinst \} \\
   \end{array}

The values of the locals are mutated by respective :ref:`variable instructions <syntax-instr-variable>`.


Conventions
...........

* The meta variable :math:`L` ranges over labels where clear from context.

* The meta variable :math:`F` ranges over frames where clear from context.

.. note::
   In the current version of WebAssembly, the arities of labels and frames cannot be larger than :math:`1`.
   This may be generalized in future versions.


.. index:: ! administrative instructions, function, function instance, function address, label, frame, instruction, trap, call, memory, memory instance, table, table instance, element, data, segment
   pair:: abstract syntax; administrative instruction
.. _syntax-trap:
.. _syntax-invoke:
.. _syntax-init_elem:
.. _syntax-init_data:
.. _syntax-instr-admin:

Administrative Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note::
   This section is only relevant for the :ref:`formal notation <exec-notation>`.

In order to express the reduction of :ref:`traps <trap>`, :ref:`calls <syntax-call>`, and :ref:`control instructions <syntax-instr-control>`, the syntax of instructions is extended to include the following *administrative instructions*:

.. math::
   \begin{array}{llcl}
   \production{(administrative instruction)} & \instr &::=&
     \dots \\ &&|&
     \TRAP \\ &&|&
     \INVOKE~\funcaddr \\ &&|&
     \INITELEM~\tableaddr~\u32~\funcidx^\ast \\ &&|&
     \INITDATA~\memaddr~\u32~\byte^\ast \\ &&|&
     \LABEL_n\{\instr^\ast\}~\instr^\ast~\END \\ &&|&
     \FRAME_n\{\frame\}~\instr^\ast~\END \\
   \end{array}

The |TRAP| instruction represents the occurrence of a trap.
Traps are bubbled up through nested instruction sequences, ultimately reducing the entire program to a single |TRAP| instruction, signalling abrupt termination.

The |INVOKE| instruction represents the imminent invocation of a :ref:`function instance <syntax-funcinst>`, identified by its :ref:`address <syntax-funcaddr>`.
It unifies the handling of different forms of calls.

The |INITELEM| and |INITDATA| instructions perform initialization of :ref:`element <syntax-elem>` and :ref:`data <syntax-data>` segments during module :ref:`instantiation <exec-instantiation>`.

.. note::
   The reason for splitting instantiation into individual reduction steps is to provide a semantics that is compatible with future extensions like threads.

The |LABEL| and |FRAME| instructions model :ref:`labels <syntax-label>` and :ref:`frames <syntax-frame>` :ref:`"on the stack" <exec-notation>`.
Moreover, the administrative syntax maintains the nesting structure of the original :ref:`structured control instruction <syntax-instr-control>` or :ref:`function body <syntax-func>` and their :ref:`instruction sequences <syntax-instr-seq>` with an |END| marker.
That way, the end of the inner instruction sequence is known when part of an outer sequence.

.. note::
   For example, the :ref:`reduction rule <exec-block>` for |BLOCK| is:

   .. math::
      \BLOCK~[t^n]~\instr^\ast~\END \quad\stepto\quad
      \LABEL_n\{\epsilon\}~\instr^\ast~\END

   This replaces the block with a label instruction,
   which can be interpreted as "pushing" the label on the stack.
   When |END| is reached, i.e., the inner instruction sequence has been reduced to the empty sequence -- or rather, a sequence of :math:`n` |CONST| instructions representing the resulting values -- then the |LABEL| instruction is eliminated courtesy of its own :ref:`reduction rule <exec-label>`:

   .. math::
      \LABEL_n\{\instr^n\}~\val^\ast~\END \quad\stepto\quad \val^n

   This can be interpreted as removing the label from the stack and only leaving the locally accumulated operand values.

.. commented out
   Both rules can be seen in concert in the following example:

   .. math::
      \begin{array}{@{}ll}
      & (\F32.\CONST~1)~\BLOCK~[]~(\F32.\CONST~2)~\F32.\NEG~\END~\F32.\ADD \\
      \stepto & (\F32.\CONST~1)~\LABEL_0\{\}~(\F32.\CONST~2)~\F32.\NEG~\END~\F32.\ADD \\
      \stepto & (\F32.\CONST~1)~\LABEL_0\{\}~(\F32.\CONST~{-}2)~\END~\F32.\ADD \\
      \stepto & (\F32.\CONST~1)~(\F32.\CONST~{-}2)~\F32.\ADD \\
      \stepto & (\F32.\CONST~{-}1) \\
      \end{array}


.. index:: ! block context, instruction, branch
.. _syntax-ctxt-block:

Block Contexts
..............

In order to specify the reduction of :ref:`branches <syntax-instr-control>`, the following syntax of *block contexts* is defined, indexed by the count :math:`k` of labels surrounding the hole:

.. math::
   \begin{array}{llll}
   \production{(block contexts)} & \XB^0 &::=&
     \val^\ast~[\_]~\instr^\ast \\
   \production{(block contexts)} & \XB^{k+1} &::=&
     \val^\ast~\LABEL_n\{\instr^\ast\}~\XB^k~\END~\instr^\ast \\
   \end{array}

This definition allows to index active labels surrounding a :ref:`branch <syntax-br>` or :ref:`return <syntax-return>` instruction.

.. note::
   For example, the :ref:`reduction <exec-br>` of a simple branch can be defined as follows:

   .. math::
      \LABEL_0\{\instr^\ast\}~\XB^l[\BR~l]~\END \quad\stepto\quad \instr^\ast

   Here, the hole :math:`[\_]` of the context is instantiated with a branch instruction.
   When a branch occurs,
   this rule replaces the targeted label and associated instruction sequence with the label's continuation.
   The selected label is identified through the :ref:`label index <syntax-labelidx>` :math:`l`, which corresponds to the number of surrounding |LABEL| instructions that must be hopped over -- which is exactly the count encoded in the index of a block context.


.. index:: ! configuration, ! thread, store, frame, instruction, module instruction
.. _syntax-thread:
.. _syntax-config:

Configurations
..............

A *configuration* consists of the current :ref:`store <syntax-store>` and an executing *thread*.

A thread is a computation over :ref:`instructions <syntax-instr>`
that operates relative to a current :ref:`frame <syntax-frame>` referring to the home :ref:`module instance <syntax-moduleinst>` that the computation runs in.

.. math::
   \begin{array}{llcl}
   \production{(configuration)} & \config &::=&
     \store; \thread \\
   \production{(thread)} & \thread &::=&
     \frame; \instr^\ast \\
   \end{array}

.. note::
   The current version of WebAssembly is single-threaded,
   but configurations with multiple threads may be supported in the future.


.. index:: ! evaluation context, instruction, trap, label, frame, value
.. _syntax-ctxt-eval:

Evaluation Contexts
...................

Finally, the following definition of *evaluation context* and associated structural rules enable reduction inside instruction sequences and administrative forms as well as the propagation of traps:

.. math::
   \begin{array}{llll}
   \production{(evaluation contexts)} & E &::=&
     [\_] ~|~
     \val^\ast~E~\instr^\ast ~|~
     \LABEL_n\{\instr^\ast\}~E~\END \\
   \end{array}

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; E[\instr^\ast] &\stepto& S'; F'; E[{\instr'}^\ast]
   \end{array}
   \\ \qquad
     (\iff S; F; \instr^\ast \stepto S'; F'; {\instr'}^\ast) \\
   \begin{array}{lcl@{\qquad}l}
   S; F; \FRAME_n\{F'\}~\instr^\ast~\END &\stepto& S'; F; \FRAME_n\{F''\}~\instr'^\ast~\END
   \end{array}
   \\ \qquad
     (\iff S; F'; \instr^\ast \stepto S'; F''; {\instr'}^\ast) \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; E[\TRAP] &\stepto& S; F; \TRAP
     &(\iff E \neq [\_]) \\
   S; F; \FRAME_n\{F'\}~\TRAP~\END &\stepto& S; F; \TRAP
   \end{array} \\
   \end{array}

Reduction terminates when a thread's instruction sequence has been reduced to a :ref:`result <syntax-result>`,
that is, either a sequence of :ref:`values <syntax-val>` or to a |TRAP|.

.. note::
   The restriction on evaluation contexts rules out contexts like :math:`[\_]` and :math:`\epsilon~[\_]~\epsilon` for which :math:`E[\TRAP] = \TRAP`.

   For an example of reduction under evaluation contexts, consider the following instruction sequence.

   .. math::
       (\F64.\CONST~x_1)~(\F64.\CONST~x_2)~\F64.\NEG~(\F64.\CONST~x_3)~\F64.\ADD~\F64.\MUL

   This can be decomposed into :math:`E[(\F64.\CONST~x_2)~\F64.\NEG]` where

   .. math::
      E = (\F64.\CONST~x_1)~[\_]~(\F64.\CONST~x_3)~\F64.\ADD~\F64.\MUL

   Moreover, this is the *only* possible choice of evaluation context where the contents of the hole matches the left-hand side of a reduction rule.

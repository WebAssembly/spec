.. index:: ! runtime
.. _syntax-runtime:

Runtime Structure
-----------------

:ref:`Store <store>`, :ref:`stack <stack>`, and other *runtime structure* forming the WebAssembly abstract machine, such as :ref:`values <syntax-val>` or :ref:`module instances <syntax-moduleinst>`, are made precise in terms of additional auxiliary syntax.


.. index:: ! value, number, reference, constant, number type, vector type, reference type, ! host address, value type, integer, floating-point, vector number, ! default value, unboxed scalar, structure, array, external reference
   pair: abstract syntax; value
.. _syntax-num:
.. _syntax-vec:
.. _syntax-ref:
.. _syntax-addrref:
.. _syntax-ref.i31num:
.. _syntax-ref.struct:
.. _syntax-ref.array:
.. _syntax-ref.exn:
.. _syntax-ref.host:
.. _syntax-ref.extern:
.. _syntax-val:
.. _syntax-null:
.. _syntax-pack:

Values
~~~~~~

WebAssembly computations manipulate *values* of either the four basic :ref:`number types <syntax-numtype>`, i.e., :ref:`integers <syntax-int>` and :ref:`floating-point data <syntax-float>` of 32 or 64 bit width each, or :ref:`vectors <syntax-vecnum>` of 128 bit width, or of :ref:`reference type <syntax-reftype>`.

In most places of the semantics, values of different types can occur.
In order to avoid ambiguities, values are therefore represented with an abstract syntax that makes their type explicit.
It is convenient to reuse the same notation as for the ${:CONST} :ref:`instructions <syntax-const>` and ${:REF.NULL} producing them.

References other than null are represented with additional :ref:`administrative instructions <syntax-instr-admin>`.
They either are *scalar references*, containing a 31-bit :ref:`integer <syntax-int>`,
*structure references*, pointing to a specific :ref:`structure address <syntax-structaddr>`,
*array references*, pointing to a specific :ref:`array address <syntax-arrayaddr>`,
*function references*, pointing to a specific :ref:`function address <syntax-funcaddr>`,
*exception references*, pointing to a specific :ref:`exception address <syntax-exnaddr>`,
or *host references* pointing to an uninterpreted form of :ref:`host address <syntax-hostaddr>` defined by the :ref:`embedder <embedder>`.
Any of the aformentioned references can furthermore be wrapped up as an *external reference*.

$${syntax: val num vec ref addrref}

.. note::
   Future versions of WebAssembly may add additional forms of values.

.. _default-val:

:ref:`Value types <syntax-valtype>` can have an associated *default value*;
it is the respective value ${:0} for :ref:`number types <syntax-numtype>`, ${:0} for :ref:`vector types <syntax-vectype>`, and null for nullable :ref:`reference types <syntax-reftype>`.
For other references, no default value is defined, ${:$default_(t)} hence is an optional value ${:val?}.

$${definition: default_}


Convention
..........

* The meta variable ${ref: r} ranges over reference values where clear from context.


.. index:: ! result, value, trap, exception, exception address
   pair: abstract syntax; result
.. _syntax-result:

Results
~~~~~~~

A *result* is the outcome of a computation.
It is either a sequence of :ref:`values <syntax-val>`, an :ref:`exception <exec-throw_ref>`, or a :ref:`trap <syntax-trap>`.

$${syntax: result}


.. index:: ! store, type instance, function instance, table instance, memory instance, global instance, tag instance, module, allocation, structure instance, array instance, exception instance
   pair: abstract syntax; store
.. _syntax-store:
.. _store:

Store
~~~~~

The *store* represents all global state that can be manipulated by WebAssembly programs.
It consists of the runtime representation of all *instances* of
:ref:`functions <syntax-funcinst>`,
:ref:`tables <syntax-tableinst>`,
:ref:`memories <syntax-meminst>`,
:ref:`globals <syntax-globalinst>`,
:ref:`tags <syntax-taginst>`,
:ref:`element segments <syntax-eleminst>`,
:ref:`data segments <syntax-datainst>`,
and
:ref:`structures <syntax-structinst>`,
:ref:`arrays <syntax-arrayinst>` or
:ref:`exceptions <syntax-exninst>`
that have been :ref:`allocated <alloc>` during the life time of the abstract machine. [#gc]_

It is an invariant of the semantics that no element or data instance is :ref:`addressed <syntax-addr>` from anywhere else but the owning module instances.

Syntactically, the store is defined as a :ref:`record <notation-record>` listing the existing instances of each category:

$${syntax: store}

.. [#gc]
   In practice, implementations may apply techniques like garbage collection or reference counting to remove objects from the store that are no longer referenced.
   However, such techniques are not semantically observable,
   and hence outside the scope of this specification.


Convention
..........

* The meta variable ${store: s} ranges over stores where clear from context.


.. index:: ! address, store, function instance, table instance, memory instance, global instance, tag instance, element instance, data instance, structure instance, array instance, exception instance, embedder, host
   pair: abstract syntax; function address
   pair: abstract syntax; table address
   pair: abstract syntax; memory address
   pair: abstract syntax; global address
   pair: abstract syntax; tag address
   pair: abstract syntax; element address
   pair: abstract syntax; data address
   pair: abstract syntax; structure address
   pair: abstract syntax; array address
   pair: abstract syntax; exception address
   pair: abstract syntax; host address
   pair: function; address
   pair: table; address
   pair: memory; address
   pair: global; address
   pair: tag; address
   pair: element; address
   pair: data; address
   pair: structure; address
   pair: array; address
   pair: exception; address
   pair: host; address
.. _syntax-funcaddr:
.. _syntax-tableaddr:
.. _syntax-memaddr:
.. _syntax-globaladdr:
.. _syntax-tagaddr:
.. _syntax-elemaddr:
.. _syntax-dataaddr:
.. _syntax-structaddr:
.. _syntax-exnaddr:
.. _syntax-arrayaddr:
.. _syntax-hostaddr:
.. _syntax-addr:

Addresses
~~~~~~~~~

:ref:`Function instances <syntax-funcinst>`,
:ref:`table instances <syntax-tableinst>`,
:ref:`memory instances <syntax-meminst>`,
:ref:`global instances <syntax-globalinst>`,
:ref:`tag instances <syntax-taginst>`,
:ref:`element instances <syntax-eleminst>`,
:ref:`data instances <syntax-datainst>`
and
:ref:`structure <syntax-structinst>`,
:ref:`array instances <syntax-arrayinst>` or
:ref:`exception instances <syntax-exninst>`
in the :ref:`store <syntax-store>` are referenced with abstract *addresses*.
These are simply indices into the respective store component.
In addition, an :ref:`embedder <embedder>` may supply an uninterpreted set of *host addresses*.

$${syntax: {addr funcaddr tableaddr memaddr globaladdr tagaddr elemaddr dataaddr structaddr arrayaddr hostaddr}}

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


.. _free-funcaddr:
.. _free-tableaddr:
.. _free-memaddr:
.. _free-globaladdr:
.. _free-tagaddr:
.. _free-elemaddr:
.. _free-dataaddr:
.. _free-structaddr:
.. _free-arrayaddr:
.. _free-localaddr:
.. _free-labeladdr:
.. _free-addr:

Conventions
...........

* The notation ${:$addr(A)} denotes the set of addresses from address space ${:addr} occurring free in ${:A}. We sometimes reinterpret this set as the :ref:`list <syntax-list>` of its elements.



.. index:: ! instance, function type, type instance, function instance, table instance, memory instance, global instance, tag instance, element instance, data instance, export instance, table address, memory address, global address, tag address, element address, data address, index, name
   pair: abstract syntax; module instance
   pair: module; instance
.. _syntax-moduleinst:

Module Instances
~~~~~~~~~~~~~~~~

A *module instance* is the runtime representation of a :ref:`module <syntax-module>`.
It is created by :ref:`instantiating <exec-instantiation>` a module,
and collects runtime representations of all entities that are imported, defined, or exported by the module.

$${syntax: moduleinst}

Each component references runtime instances corresponding to respective declarations from the original module -- whether imported or defined -- in the order of their static :ref:`indices <syntax-index>`.
:ref:`Function instances <syntax-funcinst>`,
:ref:`table instances <syntax-tableinst>`,
:ref:`memory instances <syntax-meminst>`,
:ref:`global instances <syntax-globalinst>`, and
:ref:`tag instances <syntax-taginst>`
are referenced with an indirection through their respective :ref:`addresses <syntax-addr>` in the :ref:`store <syntax-store>`.

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

$${syntax: {funcinst funccode}}

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
.. _syntax-tableinst:

Table Instances
~~~~~~~~~~~~~~~

A *table instance* is the runtime representation of a :ref:`table <syntax-table>`.
It records its :ref:`type <syntax-tabletype>` and holds a list of :ref:`reference values <syntax-ref>`.

$${syntax: tableinst}

Table elements can be mutated through :ref:`table instructions <syntax-instr-table>`, the execution of an active :ref:`element segment <syntax-elem>`, or by external means provided by the :ref:`embedder <embedder>`.

It is an invariant of the semantics that all table elements have a type :ref:`matching <match-reftype>` the element type of ${:tabletype}.
It also is an invariant that the length of the element list never exceeds the maximum size of ${:tabletype}, if present.


.. index:: ! memory instance, memory, byte, ! page size, memory type, embedder, data segment, instruction
   pair: abstract syntax; memory instance
   pair: memory; instance
.. _page-size:
.. _syntax-meminst:

Memory Instances
~~~~~~~~~~~~~~~~

A *memory instance* is the runtime representation of a linear :ref:`memory <syntax-mem>`.
It records its :ref:`type <syntax-memtype>` and holds a list of :ref:`bytes <syntax-byte>`.

$${syntax: meminst}

The length of the list always is a multiple of the WebAssembly *page size*, which is defined to be the constant ${:65536} -- abbreviated ${:64*$Ki}.

The bytes can be mutated through :ref:`memory instructions <syntax-instr-memory>`, the execution of an active :ref:`data segment <syntax-data>`, or by external means provided by the :ref:`embedder <embedder>`.

It is an invariant of the semantics that the length of the byte list, divided by page size, never exceeds the maximum size of ${:memtype}.


.. index:: ! global instance, global, value, mutability, instruction, embedder
   pair: abstract syntax; global instance
   pair: global; instance
.. _syntax-globalinst:

Global Instances
~~~~~~~~~~~~~~~~

A *global instance* is the runtime representation of a :ref:`global <syntax-global>` variable.
It records its :ref:`type <syntax-globaltype>` and holds an individual :ref:`value <syntax-val>`.

$${syntax: globalinst}

The value of mutable globals can be mutated through :ref:`variable instructions <syntax-instr-variable>` or by external means provided by the :ref:`embedder <embedder>`.

It is an invariant of the semantics that the value has a type :ref:`matching <match-valtype>` the :ref:`value type <syntax-valtype>` of ${:globaltype}.


.. index:: ! tag instance, tag, exception tag, tag type
   pair: abstract syntax; tag instance
   pair: tag; instance
.. _syntax-taginst:

Tag Instances
~~~~~~~~~~~~~

A *tag instance* is the runtime representation of a :ref:`tag <syntax-tag>` definition.
It records the :ref:`defined type <syntax-deftype>` of the tag.

$${syntax: taginst}


.. index:: ! element instance, element segment, embedder, element expression
   pair: abstract syntax; element instance
   pair: element; instance
.. _syntax-eleminst:

Element Instances
~~~~~~~~~~~~~~~~~

An *element instance* is the runtime representation of an :ref:`element segment <syntax-elem>`.
It holds a list of references and their common :ref:`type <syntax-reftype>`.

$${syntax: eleminst}


.. index:: ! data instance, data segment, embedder, byte
  pair: abstract syntax; data instance
  pair: data; instance
.. _syntax-datainst:

Data Instances
~~~~~~~~~~~~~~

An *data instance* is the runtime representation of a :ref:`data segment <syntax-data>`.
It holds a list of :ref:`bytes <syntax-byte>`.

$${syntax: datainst}


.. index:: ! export instance, export, name, external value
   pair: abstract syntax; export instance
   pair: export; instance
.. _syntax-exportinst:

Export Instances
~~~~~~~~~~~~~~~~

An *export instance* is the runtime representation of an :ref:`export <syntax-export>`.
It defines the export's :ref:`name <syntax-name>` and the associated :ref:`external value <syntax-externval>`.

$${syntax: exportinst}


.. index:: ! external value, function address, table address, memory address, global address, tag address, store, function, table, memory, global, tag, instruction type
   pair: abstract syntax; external value
   pair: external; value
.. _syntax-externval:

External Values
~~~~~~~~~~~~~~~

An *external value* is the runtime representation of an entity that can be imported or exported.
It is an :ref:`address <syntax-addr>` denoting either a
:ref:`function instance <syntax-funcinst>`,
:ref:`global instances <syntax-globalinst>`,
:ref:`table instance <syntax-tableinst>`,
:ref:`memory instance <syntax-meminst>`, or
:ref:`tag instances <syntax-taginst>`
in the shared :ref:`store <syntax-store>`.

$${syntax: externval}


Conventions
...........

The following auxiliary notation is defined for sequences of external values.
It filters out entries of a specific kind in an order-preserving fashion:

$${definition: funcsxv tablesxv memsxv globalsxv}

* :math:`\evtags(\externval^\ast) = [\tagaddr ~|~ (\EVTAG~\tagaddr) \in \externval^\ast]`


.. index:: ! structure instance, ! array instance, structure type, array type, defined type, ! field value, ! packed value
   pair: abstract syntax; field value
   pair: abstract syntax; packed value
   pair: abstract syntax; structure instance
   pair: abstract syntax; array instance
   pair: structure; instance
   pair: array; instance
.. _syntax-fieldval:
.. _syntax-packval:
.. _syntax-structinst:
.. _syntax-arrayinst:
.. _syntax-aggrinst:

Aggregate Instances
~~~~~~~~~~~~~~~~~~~

A *structure instance* is the runtime representation of a heap object allocated from a :ref:`structure type <syntax-structtype>`.
Likewise, an *array instance* is the runtime representation of a heap object allocated from an :ref:`array type <syntax-arraytype>`.
Both record their respective :ref:`defined type <syntax-deftype>` and hold a list of the values of their *fields*.

$${syntax: {structinst arrayinst fieldval packval}}


.. _aux-packfield:
.. _aux-unpackfield:

Conventions
...........

* Conversion of a regular :ref:`value <syntax-val>` to a :ref:`field value <syntax-fieldval>` is defined as follows:

  $${definition: packfield}

* The inverse conversion of a :ref:`field value <syntax-fieldval>` to a regular :ref:`value <syntax-val>` is defined as follows:

  $${definition: unpackfield}


.. index:: ! exception instance, tag, tag address, value
   pair: abstract syntax; exception instance
   pair: exception; instance
.. _syntax-exninst:

Exception Instances
~~~~~~~~~~~~~~~~~~~

An *exception instance* is the runtime representation of an :ref:`exception <exception>` produced by a ${:THROW} instruction.
It holds the :ref:`address <syntax-tagaddr>` of the respective :ref:`tag <syntax-tag>` and the argument :ref:`values <syntax-val>`.

$${syntax: exninst}


.. index:: ! stack, ! frame, ! label, ! handler, instruction, store, activation, function, call, ! call frame, local, exception, module instance
   pair: abstract syntax; frame
   pair: abstract syntax; label
   pair: abstract syntax; handler
.. _syntax-frame:
.. _syntax-callframe:
.. _syntax-label:
.. _syntax-handler:
.. _frame:
.. _label:
.. _handler:
.. _stack:

Stack
~~~~~

Besides the :ref:`store <store>`, most :ref:`instructions <syntax-instr>` interact with an implicit *stack*.
The stack contains the following kinds of entries:

* *Values*: the *operands* of instructions.

* *Labels*: active :ref:`structured control instructions <syntax-instr-control>` that can be targeted by branches.

* *Frames*: the *call frames* of active :ref:`function <syntax-func>` calls.

* *Handlers*: active exception handlers.

These entries can occur on the stack in any order during the execution of a program.
Stack entries are described by abstract syntax as follows.

.. note::
   It is possible to model the WebAssembly semantics using separate stacks for operands, control constructs, and calls.
   However, because the stacks are interdependent, additional book keeping about associated stack heights would be required.
   For the purpose of this specification, an interleaved representation is simpler.

Values
......

Values are represented by :ref:`themselves <syntax-val>`.

Labels
......

Labels carry an argument arity ${:n} and their associated branch *target*, which is expressed syntactically as an :ref:`instruction <syntax-instr>` sequence:

$${syntax: label}

Intuitively, ${:instr*} is the *continuation* to execute when the branch is taken, in place of the original control construct.

.. note::
   For example, a loop label has the form

   $${label: LABEL_ n `{(LOOP bt $instrdots)}}

   When performing a branch to this label, this executes the loop, effectively restarting it from the beginning.
   Conversely, a simple block label has the form

   $${label: LABEL_ n `{eps}}

   When branching, the empty continuation ends the targeted block, such that execution can proceed with consecutive instructions.

Call Frames
...........

Call frames carry the return arity ${:n} of the respective function,
hold the values of its :ref:`locals <syntax-local>` (including arguments) in the order corresponding to their static :ref:`local indices <syntax-localidx>`,
and a reference to the function's own :ref:`module instance <syntax-moduleinst>`:

$${syntax: {callframe frame}}

Locals may be uninitialized, in which case they are empty.
Locals are mutated by respective :ref:`variable instructions <syntax-instr-variable>`.

Exception Handlers
..................

Exception handlers are installed by |TRYTABLE| instructions and record the corresponding list of :ref:`catch clauses <syntax-catch>`:

.. math::
   \begin{array}{llllll}
     \production{handler} & \handler &::=&
       \HANDLER_n\{\catch^\ast\}
   \end{array}

The handlers on the stack are searched when an exception is :ref:`thrown <syntax-throw>`.


.. _aux-blocktype:

Conventions
...........

* The meta variable ${:L} ranges over labels where clear from context.

* The meta variable ${:f} ranges over frame states where clear from context.

* The meta variable :math:`H` ranges over exception handlers where clear from context.

* The following auxiliary definition takes a :ref:`block type <syntax-blocktype>` and looks up the :ref:`instruction type <syntax-instrtype>` that it denotes in the current frame:

  $${definition: blocktype_}


.. index:: ! administrative instructions, function, function instance, function address, label, frame, instruction, trap, call, memory, memory instance, table, table instance, element, data, segment, tag, tag instance, tag address, exception, reftype, handler, caught, caught exception
   pair:: abstract syntax; administrative instruction
.. _syntax-trap:
.. _syntax-instr-admin:

Administrative Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note::
   This section is only relevant for the :ref:`formal notation <exec-notation>`.

In order to express the reduction of :ref:`traps <trap>`, :ref:`calls <syntax-call>`, :ref:`exception handling <syntax-handler>`, and :ref:`control instructions <syntax-instr-control>`, the syntax of instructions is extended to include the following *administrative instructions*:

$${syntax: {instr/admin}}

An :ref:`address reference <syntax-addrref>` represents an allocated :ref:`reference <syntax-ref>` value of respective form :ref:`"on the stack" <exec-notation>`.

The ${:LABEL}, ${:FRAME}, and ${:HANDLER} instructions model :ref:`labels <syntax-label>`, :ref:`frames <syntax-frame>`, and active :ref:`exception handlers <syntax-handler>`, respectively, :ref:`"on the stack" <exec-notation>`.
Moreover, the administrative syntax maintains the nesting structure of the original :ref:`structured control instruction <syntax-instr-control>` or :ref:`function body <syntax-func>` and their :ref:`instruction sequences <syntax-instrs>`.

The ${:TRAP} instruction represents the occurrence of a trap.
Traps are bubbled up through nested instruction sequences, ultimately reducing the entire program to a single ${:TRAP} instruction, signalling abrupt termination.

.. note::
   For example, the :ref:`reduction rule <exec-block>` for ${:BLOCK} is:

   $${Step_pure: (BLOCK bt instr*) ~> (LABEL_ n `{eps} instr*)}

   if the :ref:`block type <syntax-blocktype>` ${:bt} denotes a :ref:`function type <syntax-functype>` ${functype: t_1^m -> t_2^n},
   such that ${:n} is the block's result arity.
   This rule replaces the block with a label instruction,
   which can be interpreted as "pushing" the label on the stack.
   When its end is reached, i.e., the inner instruction sequence has been reduced to the empty sequence -- or rather, a sequence of ${:n} :ref:`values <syntax-val>` representing the results -- then the ${:LABEL} instruction is eliminated courtesy of its own :ref:`reduction rule <exec-label>`:

   $${Step_pure: (LABEL_ n `{instr*} val*) ~> val*}

   This can be interpreted as removing the label from the stack and only leaving the locally accumulated operand values.
   Validation guarantees that ${:n} matches the number ${:|val*|} of resulting values at this point.


.. index:: ! configuration, ! state, ! thread, store, frame, instruction, module instruction
.. _syntax-state:
.. _syntax-thread:
.. _syntax-config:

Configurations
..............

A *configuration* describes the current computation.
It consists of the computations's *state* and the sequence of :ref:`instructions <syntax-instr>` left to execute.
The state in turn consists of a global :ref:`store <syntax-store>` and a current :ref:`frame <syntax-frame>` referring to the :ref:`module instance <syntax-moduleinst>` in which the computation runs, i.e., where the current function originates from.

$${syntax: config state}

.. old
   A *configuration* consists of the current :ref:`store <syntax-store>` and an executing *thread*.

   A thread is a computation over :ref:`instructions <syntax-instr>`
   that operates relative to the state of a current :ref:`frame <syntax-frame>` referring to the :ref:`module instance <syntax-moduleinst>` in which the computation runs, i.e., where the current function originates from.

   .. math::
      \begin{array}{llcl}
      \production{configuration} & \config &::=&
        \store; \thread \\
      \production{thread} & \thread &::=&
        \frame; \instr^\ast \\
      \end{array}

.. note::
   The current version of WebAssembly is single-threaded,
   but configurations with multiple threads may be supported in the future.

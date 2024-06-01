.. index:: ! execution, stack, store

Conventions
-----------

WebAssembly code is *executed* when :ref:`instantiating <exec-instantiation>` a module or :ref:`invoking <exec-invocation>` an :ref:`exported <syntax-export>` function on the resulting module :ref:`instance <syntax-moduleinst>`.

Execution behavior is defined in terms of an *abstract machine* that models the *program state*.
It includes a *stack*, which records operand values and control constructs, and an abstract *store* containing global state.

For each instruction, there is a rule that specifies the effect of its execution on the program state.
Furthermore, there are rules describing the instantiation of a module.
As with :ref:`validation <validation>`, all rules are given in two *equivalent* forms:

1. In *prose*, describing the execution in intuitive form.
2. In *formal notation*, describing the rule in mathematical form. [#cite-pldi2017]_

.. note::
   As with validation, the prose and formal rules are equivalent,
   so that understanding of the formal notation is *not* required to read this specification.
   The formalism offers a more concise description in notation that is used widely in programming languages semantics and is readily amenable to mathematical proof.


.. _exec-notation-textual:

Prose Notation
~~~~~~~~~~~~~~

Execution is specified by stylised, step-wise rules for each :ref:`instruction <syntax-instr>` of the :ref:`abstract syntax <syntax>`.
The following conventions are adopted in stating these rules.

* The execution rules implicitly assume a given :ref:`store <store>` :math:`S`.

* The execution rules also assume the presence of an implicit :ref:`stack <stack>`
  that is modified by *pushing* or *popping*
  :ref:`values <syntax-value>`, :ref:`labels <syntax-label>`, and :ref:`frames <syntax-frame>`.

* Certain rules require the stack to contain at least one frame.
  The most recent frame is referred to as the *current* frame.

* Both the store and the current frame are mutated by *replacing* some of their components.
  Such replacement is assumed to apply globally.

* The execution of an instruction may *trap*,
  in which case the entire computation is aborted and no further modifications to the store are performed by it. (Other computations can still be initiated afterwards.)

* The execution of an instruction may also end in a *jump* to a designated target,
  which defines the next instruction to execute.

* Execution can *enter* and *exit* :ref:`instruction sequences <syntax-instrs>` that form :ref:`blocks <syntax-instr-control>`.

* :ref:`Instruction sequences <syntax-instrs>` are implicitly executed in order, unless a trap or jump occurs.

* In various places the rules contain *assertions* expressing crucial invariants about the program state.


.. index:: ! reduction rules, configuration, evaluation context
.. _exec-notation:

Formal Notation
~~~~~~~~~~~~~~~

.. note::
   This section gives a brief explanation of the notation for specifying execution formally.
   For the interested reader, a more thorough introduction can be found in respective text books. [#cite-tapl]_

The formal execution rules use a standard approach for specifying operational semantics, rendering them into *reduction rules*.
Every rule has the following general form:

$${: configuration ~> configuration}

A *configuration* is a syntactic description of a program state.
Each rule specifies one *step* of execution.
As long as there is at most one reduction rule applicable to a given configuration, reduction -- and thereby execution -- is *deterministic*.
WebAssembly has only very few exceptions to this, which are noted explicitly in this specification.

For WebAssembly, a configuration typically is a tuple ${:(s; f; instr*)} consisting of the current :ref:`store <store>` ${:s}, the :ref:`call frame <frame>` ${:f} of the current function, and the sequence of :ref:`instructions <syntax-instr>` that is to be executed.
(A more precise definition is given :ref:`later <syntax-config>`.)

To avoid unnecessary clutter, the store ${:s} and the frame ${:f} are often combined into a *state* ${:z}, which is a pair ${:(s; f)}.
Moreover, ${:z} is omitted from reduction rules that do not touch them.

There is no separate representation of the :ref:`stack <stack>`.
Instead, it is conveniently represented as part of the configuration's instruction sequence.
In particular, :ref:`values <syntax-val>` are defined to coincide with ${:CONST} instructions,
and a sequence of ${:CONST} instructions can be interpreted as an operand "stack" that grows to the right.

.. note::
   For example, the :ref:`reduction rule <exec-binop>` for the ${instr: BINOP I32 ADD} instruction can be given as follows:

   $${Step_pure: (CONST I32 n_1) (CONST I32 n_2) $($(BINOP I32 ADD)) ~> (CONST I32 $((n_1 + n_2) \ 2^32))}

   Per this rule, two ${:CONST} instructions and the ${:ADD} instruction itself are removed from the instruction stream and replaced with one new ${:CONST} instruction.
   This can be interpreted as popping two values off the stack and pushing the result.

   When no result is produced, an instruction reduces to the empty sequence:

   $${Step_pure: NOP ~> eps}

:ref:`Labels <label>` and :ref:`frames <frame>` are similarly :ref:`defined <syntax-instr-admin>` to be part of an instruction sequence.

The order of reduction is determined by the details of the reduction rules.
Usually, the left-most instruction that is not a constant will be the subject of the next reduction *step*.

Reduction *terminates* when no more reduction rules are applicable.
:ref:`Soundness <soundness>` of the WebAssembly :ref:`type system <type-system>` guarantees that this is only the case when the original instruction sequence has either been reduced to a sequence of ${:CONST} instructions, which can be interpreted as the :ref:`values <syntax-val>` of the resulting operand stack,
or if a :ref:`trap <syntax-trap>` occurred.

.. note::
   For example, the following instruction sequence,

   $${instr*: (CONST F64 q_1) (CONST F64 q_2) $($(UNOP F64 NEG)) (CONST F64 q_3) $($(BINOP F64 ADD)) $($(BINOP F64 MUL))}

   terminates after three steps:

   $${rule: {NotationReduct/*}}
   $${relation-ignore: NotationReduct}

   where ${:q_4 = $(-q_2)} and ${:q_5 = $(-q_2 + q_3)} and ${:q_6 = $(q_1 * (-q_2 + q_3))}.


.. [#cite-pldi2017]
   The semantics is derived from the following article:
   Andreas Haas, Andreas Rossberg, Derek Schuff, Ben Titzer, Dan Gohman, Luke Wagner, Alon Zakai, JF Bastien, Michael Holman. |PLDI2017|_. Proceedings of the 38th ACM SIGPLAN Conference on Programming Language Design and Implementation (PLDI 2017). ACM 2017.

.. [#cite-tapl]
   For example: Benjamin Pierce. |TAPL|_. The MIT Press 2002

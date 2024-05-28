.. index:: ! validation, ! type system, function type, table type, memory type, globaltype, valtype, resulttype, index space, instantiation. module
.. _type-system:

Conventions
-----------

Validation checks that a WebAssembly module is well-formed.
Only valid modules can be :ref:`instantiated <exec-instantiation>`.

Validity is defined by a *type system* over the :ref:`abstract syntax <syntax>` of a :ref:`module <syntax-module>` and its contents.
For each piece of abstract syntax, there is a typing rule that specifies the constraints that apply to it.
All rules are given in two *equivalent* forms:

1. In *prose*, describing the meaning in intuitive form.
2. In *formal notation*, describing the rule in mathematical form. [#cite-pldi2017]_

.. note::
   The prose and formal rules are equivalent,
   so that understanding of the formal notation is *not* required to read this specification.
   The formalism offers a more concise description in notation that is used widely in programming languages semantics and is readily amenable to mathematical proof.

In both cases, the rules are formulated in a *declarative* manner.
That is, they only formulate the constraints, they do not define an algorithm.
The skeleton of a sound and complete algorithm for type-checking instruction sequences according to this specification is provided in the :ref:`appendix <algo-valid>`.


.. index:: heap type, abstract type, concrete type, type index, ! recursive type index, ! closed type, rolling, unrolling, sub type, subtyping, ! bottom type
   pair: abstract syntax; value type
   pair: abstract syntax; heap type
   pair: abstract syntax; sub type
   pair: abstract syntax; recursive type index
.. _syntax-rectypeidx:
.. _syntax-valtype-ext:
.. _syntax-heaptype-ext:
.. _syntax-subtype-ext:
.. _type-ext:
.. _type-closed:

Types
~~~~~

To define the semantics, the definition of some sorts of types is extended to include additional forms.
By virtue of not being representable in either the :ref:`binary format <binary-valtype>` or the :ref:`text format <text-valtype>`,
these forms cannot be used in a program;
they only occur during :ref:`validation <valid>` or :ref:`execution <exec>`.

$${syntax: {valtype/sem absheaptype/sem typeuse/sem}}

The unique :ref:`value type <syntax-valtype>` ${valtype:BOT} is a *bottom type* that :ref:`matches <match-valtype>` all value types.
Similarly, ${heaptype:BOT} is also used as a bottom type of all :ref:`heap types <syntax-heaptype>`.

.. note::
   No validation rule uses bottom types explicitly,
   but various rules can pick any value or heap type, including bottom.
   This ensures the existence of :ref:`principal types <principality>`,
   and thus a :ref:`validation algorithm <algo-valid>` without back tracking.

A :ref:`type use <syntax-typeuse>` can consist directly of a :ref:`defined type <syntax-deftype>`.
This occurs as the result of :ref:`substituting <notation-subst>` a :ref:`type index <syntax-typeidx>` with its definition.

A type use may also be a *recursive type index*.
Such an index refers to the ${:i}-th component of a surrounding :ref:`recursive type <syntax-rectype>`.
It occurs as the result of :ref:`rolling up <aux-roll-rectype>` the definition of a :ref:`recursive type <syntax-rectype>`.

Both extensions affect the occurrence of type uses in concrete :ref:`heap types <syntax-heaptype>`, in :ref:`sub types <syntax-subtype>` and in :ref:`instructions <syntax-instr>`.

.. note::
   It is an invariant of the semantics that sub types occur only in one of two forms:
   either as "syntactic" types as in a source module, where all supertypes are type indices,
   or as "semantic" types, where all supertypes are resolved to either defined types or recursive type indices.

A type of any form is *closed* when it does not contain a heap type that is a :ref:`type index <syntax-typeidx>` or a recursive type index without a surrounding :ref:`recursive type <syntax-reftype>`,
i.e., all :ref:`type indices <syntax-typeidx>` have been :ref:`substituted <notation-subst>` with their :ref:`defined type <syntax-deftype>` and all free recursive type indices have been :ref:`unrolled <aux-unroll-rectype>`.

.. note::
   Recursive type indices are internal to a recursive type.
   They are distinguished from regular type indices and represented such that two closed types are syntactically equal if and only if they have the same recursive structure.

.. _aux-reftypediff:

Convention
..........

* The *difference* ${:$diffrt(rt_1, rt_2)} between two :ref:`reference types <syntax-reftype>` is defined as follows:

  $${definition: diffrt}

.. note::
   This definition computes an approximation of the reference type that is inhabited by all values from ${:rt_1} except those from ${:rt_2}.
   Since the type system does not have general union types,
   the defnition only affects the presence of null and cannot express the absence of other values.


.. index:: ! defined type, recursive type
   pair: abstract syntax; defined type
.. _syntax-deftype:

Defined Types
~~~~~~~~~~~~~

*Defined types* denote the individual types defined in a :ref:`module <syntax-module>`.
Each such type is represented as a projection from the :ref:`recursive type <syntax-rectype>` group it originates from, indexed by its position in that group.

$${syntax: deftype}

Defined types do not occur in the :ref:`binary <binary>` or :ref:`text <text>` format,
but are formed by :ref:`rolling up <aux-roll-deftype>` the :ref:`recursive types <syntax-reftype>` defined in a module.

It is hence an invariant of the semantics that all :ref:`recursive types <syntax-rectype>` occurring in defined types are :ref:`rolled up <aux-roll-rectype>`.


.. index:: ! substitution
.. _type-subst:
.. _notation-subst:

Conventions
...........

* ${:$subst_valtype(t, x*, dt*)} denotes the parallel *substitution* of :ref:`type indices <syntax-typeidx>` ${:x*} with :ref:`defined types <syntax-deftype>` ${:dt*} in type ${:t}, provided ${:|x*| = |dt*|}.

* ${:$subst_valtype(t, (REC i)*, dt*)} denotes the parallel substitution of :ref:`recursive type indices <syntax-rectypeidx>` ${:(REC i)*} with :ref:`defined types <syntax-deftype>` ${:dt*} in type ${:t}, provided ${:|(REC i)*| = |dt*|}.

* ${:$subst_all_valtype(t, dt*)} is shorthand for the substitution ${:$subst_valtype(t, x*, dt*)}, where ${:x* = 0 `... $((|dt*| - 1))}.


.. index:: recursive type, defined type, sub type, ! rolling, ! unrolling, ! expansion, type equivalence
.. _aux-roll-rectype:
.. _aux-unroll-rectype:
.. _aux-roll-deftype:
.. _aux-unroll-deftype:
.. _aux-expand-deftype:

Rolling and Unrolling
~~~~~~~~~~~~~~~~~~~~~

In order to allow comparing :ref:`recursive types <syntax-rectype>` for :ref:`equivalence <match-deftype>`, their representation is changed such that all :ref:`type indices <syntax-typeidx>` internal to the same recursive type are replaced by :ref:`recursive type indices <syntax-rectypeidx>`.

.. note::
   This representation is independent of the type index space,
   so that it is meaningful across module boundaries.
   Moreover, this representation ensures that types with equivalent recursive structure are also syntactically equal,
   hence allowing a simple equality check on (closed) types.
   It gives rise to an *iso-recursive* interpretation of types.

The representation change is performed by two auxiliary operations on the syntax of :ref:`recursive types <syntax-rectype>`:

* *Rolling up* a recursive type :ref:`substitutes <notation-subst>` its internal :ref:`type indices <syntax-typeidx>` with corresponding :ref:`recursive type indices <syntax-rectypeidx>`.

* *Unrolling* a recursive type :ref:`substitutes <notation-subst>` its :ref:`recursive type indices <syntax-rectypeidx>` with the corresponding :ref:`defined types <syntax-deftype>`.

These operations are extended to :ref:`defined types <syntax-deftype>` and defined as follows:

$${definition: rollrt unrollrt rolldt unrolldt}

In addition, the following auxiliary relation denotes the *expansion* of a :ref:`defined type <syntax-deftype>`:

$${rule: Expand}

$${relation-ignore: Expand}
$${definition-ignore: expanddt}


.. index:: ! instruction type, value type, result type, instruction, local, local index
   pair: abstract syntax; instruction type
   pair: instruction; type
.. _syntax-instrtype:

Instruction Types
~~~~~~~~~~~~~~~~~

*Instruction types* classify the behaviour of :ref:`instructions <syntax-instr>` or instruction sequences, by describing how they manipulate the :ref:`operand stack <stack>` and the initialization status of :ref:`locals <syntax-local>`:

$${syntax: instrtype}

An instruction type ${instrtype: t_1* ->_(x*) t_2*} describes the required input stack with argument values of types ${:t_1*} that an instruction pops off
and the provided output stack with result values of types ${:t_2*} that it pushes back.
Moreover, it enumerates the :ref:`indices <syntax-localidx>` ${:x*} of locals that have been set by the instruction or sequence.

.. note::
   Instruction types are only used for :ref:`validation <valid>`,
   they do not occur in programs.


.. index:: ! local type, value type, local, local index
   pair: abstract syntax; local type
   pair: local; type
.. _syntax-init:
.. _syntax-localtype:

Local Types
~~~~~~~~~~~

*Local types* classify :ref:`locals <syntax-local>`, by describing their :ref:`value type <syntax-valtype>` as well as their *initialization status*:

$${syntax: {localtype init}}

.. note::
   Local types are only used for :ref:`validation <valid>`,
   they do not occur in programs.


.. index:: ! context, local type, function type, table type, memory type, global type, value type, result type, index space, module, function, local type
.. _context:

Contexts
~~~~~~~~

Validity of an individual definition is specified relative to a *context*,
which collects relevant information about the surrounding :ref:`module <syntax-module>` and the definitions in scope:

* *Types*: the list of :ref:`types <syntax-type>` defined in the current module.
* *Recursive Types*: the list of :ref:`sub types <syntax-subtype>` in the current group of recursive types.
* *Functions*: the list of :ref:`functions <syntax-func>` declared in the current module, represented by a :ref:`defined type <syntax-deftype>` that :ref:`expands <aux-expand-deftype>` to their :ref:`function type <syntax-functype>`.
* *Tables*: the list of :ref:`tables <syntax-table>` declared in the current module, represented by their :ref:`table type <syntax-tabletype>`.
* *Memories*: the list of :ref:`memories <syntax-mem>` declared in the current module, represented by their :ref:`memory type <syntax-memtype>`.
* *Globals*: the list of :ref:`globals <syntax-global>` declared in the current module, represented by their :ref:`global type <syntax-globaltype>`.
* *Element Segments*: the list of :ref:`element segments <syntax-elem>` declared in the current module, represented by the elements' :ref:`reference type <syntax-reftype>`.
* *Data Segments*: the list of :ref:`data segments <syntax-data>` declared in the current module, each represented by an ${datatype: OK} entry.
* *Locals*: the list of :ref:`locals <syntax-local>` declared in the current :ref:`function <syntax-func>` (including parameters), represented by their :ref:`local type <syntax-localtype>`.
* *Labels*: the stack of :ref:`labels <syntax-label>` accessible from the current position, represented by their :ref:`result type <syntax-resulttype>`.
* *Return*: the return type of the current :ref:`function <syntax-func>`, represented as an optional :ref:`result type <syntax-resulttype>` that is absent when no return is allowed, as in free-standing expressions.
* *References*: the list of :ref:`function indices <syntax-funcidx>` that occur in the module outside functions and can hence be used to form references inside them.

In other words, a context contains a sequence of suitable :ref:`types <syntax-type>` for each :ref:`index space <syntax-index>`,
describing each defined entry in that space.
Locals, labels and return type are only used for validating :ref:`instructions <syntax-instr>` in :ref:`function bodies <syntax-func>`, and are left empty elsewhere.
The label stack is the only part of the context that changes as validation of an instruction sequence proceeds.

More concretely, contexts are defined as :ref:`records <notation-record>` ${:C} with abstract syntax:

$${syntax: context}

.. _notation-extend:

In addition to field access written ${:C.FIELD}, the following notation is adopted for manipulating contexts:

* When spelling out a context, empty fields are omitted.

* ${:C, FIELD A*} denotes the same context as ${:C} but with the elements ${:A*} prepended to its ${:FIELD} component sequence.

.. note::
   :ref:`Indexing notation <notation-index>` like ${resulttype: C.LABELS[i]} is used to look up indices in their respective :ref:`index space <syntax-index>` in the context.
   Context extension notation ${:C, FIELD A} is primarily used to locally extend *relative* index spaces, such as :ref:`label indices <syntax-labelidx>`.
   Accordingly, the notation is defined to append at the *front* of the respective sequence, introducing a new relative index ${:0} and shifting the existing ones.


.. index:: ! type closure
.. _type-closure:
.. _aux-clostype:

Convention
..........

A :ref:`defined type <syntax-deftype>` can be *closed* to bring it into :ref:`closed <type-closed>` form relative to a :ref:`context <context>` it is :ref:`valid <valid-type>` in by :ref:`substituting <notation-subst>` each :ref:`type index <syntax-typeidx>` ${:x} occurring in it with its own corresponding :ref:`defined type <syntax-deftype>` ${deftype: C.TYPES[x]}, after first closing the the types in ${deftype*: C.TYPES} themselves.

$${definition: clostype clostypes}


.. _valid-notation-textual:

Prose Notation
~~~~~~~~~~~~~~

Validation is specified by stylised rules for each relevant part of the :ref:`abstract syntax <syntax>`.
The rules not only state constraints defining when a phrase is valid,
they also classify it with a type.
The following conventions are adopted in stating these rules.

* A phrase ${:A} is said to be "valid with type ${:T}"
  if and only if all constraints expressed by the respective rules are met.
  The form of ${:T} depends on the syntactic class of ${:A}.

  .. note::
     For example, if ${:A} is a :ref:`function <syntax-func>`,
     then ${:T} is a :ref:`function type <syntax-functype>`;
     for an ${:A} that is a :ref:`global <syntax-global>`,
     ${:T} is a :ref:`global type <syntax-globaltype>`;
     and so on.

* The rules implicitly assume a given :ref:`context <context>` ${:C}.

* In some places, this context is locally extended to a context ${:C'} with additional entries.
  The formulation "Under context ${:C'}, ... *statement* ..." is adopted to express that the following statement must apply under the assumptions embodied in the extended context.


.. index:: ! typing rules
.. _valid-notation:

Formal Notation
~~~~~~~~~~~~~~~

.. note::
   This section gives a brief explanation of the notation for specifying typing rules formally.
   For the interested reader, a more thorough introduction can be found in respective text books. [#cite-tapl]_

The proposition that a phrase ${:A} has a respective type ${:T} is written ${:A `: T}.
In general, however, typing is dependent on a context ${:C}.
To express this explicitly, the complete form is a *judgement* ${:C `|- A `: T},
which says that ${:A `: T} holds under the assumptions encoded in ${:C}.

The formal typing rules use a standard approach for specifying type systems, rendering them into *deduction rules*.
Every rule has the following general form:

$${rule: Scheme}
$${relation-ignore: Scheme}

Such a rule is read as a big implication: if all premises hold, then the conclusion holds.
Some rules have no premises; they are *axioms* whose conclusion holds unconditionally.
The conclusion always is a judgment ${:C `|- A `: T},
and there is one respective rule for each relevant construct ${:A} of the abstract syntax.

.. note::
   For example, the typing rule for the ${instr: BINOP I32 ADD} instruction can be given as an axiom:

   $${rule: InstrScheme/i32.add}

   The instruction is always valid with type ${instrtype: I32 I32 -> I32}
   (saying that it consumes two ${numtype: I32} values and produces one),
   independent of any side conditions.

   An instruction like ${:GLOBAL.GET} can be typed as follows:

   $${rule: InstrScheme/global.get}

   Here, the premise enforces that the immediate :ref:`global index <syntax-globalidx>` ${:x} exists in the context.
   The instruction produces a value of its respective type ${:t}
   (and does not consume any values).
   If ${globaltype: C.GLOBALS[x]} does not exist then the premise does not hold,
   and the instruction is ill-typed.

   Finally, a :ref:`structured <syntax-instr-control>` instruction requires
   a recursive rule, where the premise is itself a typing judgement:

   $${rule: InstrScheme/block}

   A ${:BLOCK} instruction is only valid when the instruction sequence in its body is.
   Moreover, the result type must match the block's annotation ${:blocktype}.
   If so, then the ${:BLOCK} instruction has the same type as the body.
   Inside the body an additional label of the corresponding result type is available,
   which is expressed by extending the context ${:C} with the additional label information for the premise.

$${relation-ignore: InstrScheme}


.. [#cite-pldi2017]
   The semantics is derived from the following article:
   Andreas Haas, Andreas Rossberg, Derek Schuff, Ben Titzer, Dan Gohman, Luke Wagner, Alon Zakai, JF Bastien, Michael Holman. |PLDI2017|_. Proceedings of the 38th ACM SIGPLAN Conference on Programming Language Design and Implementation (PLDI 2017). ACM 2017.

.. [#cite-tapl]
   For example: Benjamin Pierce. |TAPL|_. The MIT Press 2002

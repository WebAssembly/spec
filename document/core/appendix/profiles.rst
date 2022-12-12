.. index:: ! profile, abstract syntax, validation, execution, binary format, text format
.. _profiles:

Profiles
--------

To enable the use of WebAssembly in as many environments as possible, *profiles* specify coherent language subsets that fit constraints imposed by common classes of host environments.
A host platform can thereby decide to support the language only under a restricted profile, or even the intersection of multiple profiles.


Conventions
~~~~~~~~~~~

A profile modification is specified by decorating selected rules in the main body of this specification with a *profile annotation* that defines them as "conditional" on the choice of profile.

For that purpose, every profile defines a *profile marker*, an alphanumeric short-hand like :math:`\profilename{ABC}`.
A profile annotation of the form :math:`\exprofiles{\profile{ABC}~\profile{XYZ}}` on a rule indicates that this rule is *excluded* for either of the profiles whose marker is :math:`\profilename{ABC}` or :math:`\profilename{XYZ}`.

There are two ways of subsetting the language in a profile:

* *Syntactic*, by *omitting* a feature, in which case certain constructs are removed from the syntax altogether.

* *Semantic*, by *restricting* a feature, in which case certain constructs are still present but some behaviours are ruled out.


Syntax Annotations
..................

To omit a construct from a profile syntactically, respective productions in the grammar of the :ref:`abstract syntax <syntax>` are annotated with an associated profile marker.
This is defined to have the following implications:

1. Any production in the :ref:`binary <binary>` or :ref:`textual <text>` syntax that produces abstract syntax with a marked construct is omitted by extension.

2. Any :ref:`validation <valid>` or :ref:`execution <exec>` rule that handles a marked construct is omitted by extension.

The overall effect is that the respective construct is no longer part of the language under a respective profile.

.. note::
   For example, a "busy" profile marked :math:`\profilename{BUSY}` could rule out the |NOP| instruction by marking the production for it in the abstract syntax as follows:

   .. math::
      \begin{array}{llcl}
      \production{instruction} & \instr &::=&
        \dots \\
      & \exprofiles{\profile{BUSY}} &|& \NOP \\
      &                           &|& \UNREACHABLE \\
      \end{array}

   A rule may be annotated by multiple markers, which might be the case if a construct is in the intersection of multiple features.


Semantics Annotations
.....................

To restrict certain behaviours in a profile, individual :ref:`validation <valid>` or :ref:`reduction <exec>` rules or auxiliary definitions are annotated with an associated marker.

This has the simple consequence that the respective rule is no longer applicable under the given profile.

.. note::
   For example, an "infinite" profile marked :math:`\profilename{INF}` could define that growing memory never fails:

   .. math::
	   \begin{array}{llcl@{\qquad}l}
	   & S; F; (\I32.\CONST~n)~\MEMORYGROW &\stepto& S'; F; (\I32.\CONST~\X{sz})
	   \\&&&
	     \begin{array}[t]{@{}r@{~}l@{}}
	     (\iff & F.\AMODULE.\MIMEMS[0] = a \\
	     \wedge & \X{sz} = |S.\SMEMS[a].\MIDATA|/64\,\F{Ki} \\
	     \wedge & S' = S \with \SMEMS[a] = \growmem(S.\SMEMS[a], n)) \\[1ex]
	     \end{array}
	   \\[1ex]
	   \exprofiles{\profile{INF}} & S; F; (\I32.\CONST~n)~\MEMORYGROW &\stepto& S; F; (\I32.\CONST~\signed_{32}^{-1}(-1))
	   \end{array}


Properties
..........

All profiles are defined such that the following properties are preserved:

* All profiles represent syntactic and semantic subsets of the :ref:`full profile <profile-full>`, i.e., they do not *add* syntax or *alter* behaviour.

* All profiles are mutually compatible, i.e., no two profiles subset semantic behaviour in inconsistent ways, and any intersection of profiles preserves the properties described here.

* Profiles that restrict execution do not violate :ref:`soundness <soundness>`, i.e., all :ref:`configurations <syntax-config>` valid under that profile still have well-defined execution behaviour.

.. note::
   Tools are generally expected to handle and produce code for the full profile by default.
   In particular, producers should not generate code that *depends* on specific profiles. Instead, all code should preserve correctness when executed under the full profile.

   Moreover, profiles should be considered static and fixed for a given platform or ecosystem. Runtime conditioning on the "current" profile should especially be avoided.



Defined Profiles
~~~~~~~~~~~~~~~~

.. note::
   The number of defined profiles is expected to remain small in the future. Profiles are intended for broad and permanent use cases only. In particular, profiles are not intended for language versioning.


.. index:: full profile
   single: profile; full
.. _profile-full:

Full Profile (:math:`{\small{\mathrm{FUL}}}`)
.............................................

The *full* profile contains the complete language and all possible behaviours.
It imposes no restrictions, i.e., all rules and definitions are active.
All other profiles define sub-languages of this profile.


.. index:: determinism, non-determinism, deterministic profile
   single: profile; deterministic
.. _profile-deterministic:

Deterministic Profile (:math:`{\small{\mathrm{DET}}}`)
......................................................

The *deterministic* profile excludes all rules marked :math:`\exprofiles{\PROFDET}`.
It defines a sub-language that does not exhibit any incidental non-deterministic behaviour:

* All :ref:`NaN <syntax-nan>` values :ref:`generated <aux-nans>` by :ref:`floating-point instructions <syntax-instr-numeric>` are canonical and positive.

Even under this profile, the |MEMORYGROW| and |TABLEGROW| instructions technically remain :ref:`non-deterministic <exec-memory.grow>`, in order to be able to indicate resource exhaustion.

.. note::
   In future versions of WebAssembly, new non-deterministic behaviour may be added to the language, such that the deterministic profile will induce additional restrictions.

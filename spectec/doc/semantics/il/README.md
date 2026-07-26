This directory specifies the SpecTec IL in SpecTec itself.

There are a number of remaining TODOs:

* Variable freshness. Cannot yet be expressed in SpecTec, hence the definition of substitution currently fails to avoid capture.

* Let-premises. In their current form, let-premises cannot be given a proper semantics. In particular, the identifier list they carry causes them to be not closed under substitution on a syntactic level already. At the moment, the semantics given here hence ignores that list and treats let-premises simply as equality constraints.

  A possible fix is to turn the identifier list into a proper list of local quantifiers, but that requires further changes, especially to the semantics of iterated premises.

* Subtyping. To properly handle recursive types, the subtyping relation needs to be refined to carry a set of subtype assumptions, thereby emulating a co-inductive formulation.

* Computational fragment. The operational semantics is defined by ordinary small-step reduction, plus one non-deterministic rule that eliminates quantifiers by guessing the right substitution. Obviously, that means that the semantics isn't actually executable in general.

  We would like to define an executable fragment of SpecTec — e.g., as the target for animation. This should have a semantics identical to the full semantics, but without using the guessing rule.

  As currently formulated, guessing the substitution serves two purposes:

  1. To find an assignment for the variables in a l.h.s. pattern-expression, i.e., defining pattern matching without actually defining it, and just reducing it to equality.

  2. To find witnesses for existentially quantified locals.

  Pattern matching is still needed in a computational fragment. Hence, it should be defined operationally. Then the computational fragment would be those programs whose only quantifiers are resolvable by pattern matches, such that their execution never needs to guess a witness.

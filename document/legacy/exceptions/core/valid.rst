.. _valid:

Validation
==========

.. _type-system:

Conventions
-----------

.. _context:
.. _syntax-labeltype:

Contexts
~~~~~~~~

The context is enriched with an additional flag on label types:

.. math::
   \begin{array}{llll}
   \production{labeltype} & \labeltype & ::= & \LCATCH^?~\resulttype \\
   \production{context} & C &::=&
     \{ \dots, \CLABELS~\labeltype^\ast, \dots \}
   \end{array}

Existing typing rules are adjusted as follows:

* All rules that extend the context with new labels use an absent |LCATCH| flag.

* All rules that inspect the context for a label ignore the presence of a |LCATCH| flag.

.. note::
   This flag is used to distinguish labels bound by catch clauses, which can be targeted by |RETHROW|.
.. _valid-instr:

Instructions
------------

.. _valid-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _valid-try-catch:

:math:`\TRY~\blocktype~\instr_1^\ast~(\CATCH~x~\instr_2^\ast)^\ast~(\CATCHALL~\instr_3^\ast)^?~\END`
....................................................................................................

* The :ref:`block type <syntax-blocktype>` must be :ref:`valid <valid-blocktype>` as some :ref:`function type <syntax-functype>` :math:`[t_1^\ast] \to [t_2^\ast]`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`label type <syntax-labeltype>` :math:`[t_2^\ast]` prepended to the |CLABELS| vector.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr_1^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[t_1^\ast] \to [t_2^\ast]`.

* Let :math:`C''` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`label type <syntax-labeltype>` :math:`\LCATCH~[t_2^\ast]` prepended to the |CLABELS| vector.

* For every :math:`x_i` and :math:`\instr_{2i}^\ast` in :math:`(\CATCH~x~\instr_2^\ast)^\ast`:

  * The tag :math:`C.\CTAGS[x_i]` must be defined in the context :math:`C`.

  * Let :math:`[t_{3i}^\ast] \to [t_{4i}^\ast]` be the :ref:`tag type <syntax-tagtype>` :math:`C.\CTAGS[x_i]`.

  * The :ref:`result type <syntax-resulttype>` :math:`[t_{4i}^\ast]` must be empty.

  * Under context :math:`C''`,
    the instruction sequence :math:`\instr_{2i}^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[t_{3i}^\ast] \to [t_2^\ast]`.

* If :math:`(\CATCHALL~\instr_3^\ast)^?` is not empty, then:

  * Under context :math:`C''`,
    the instruction sequence :math:`\instr_3^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[] \to [t_2^\ast]`.

* Then the compound instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`.

.. math::
   ~\\
   \frac{
   \begin{array}{c}
     C \vdashblocktype \blocktype : [t_1^\ast] \to [t_2^\ast]
     \qquad
     C,\CLABELS\,[t_2^\ast] \vdashinstrseq \instr_1^\ast : [t_1^\ast] \to [t_2^\ast] \\
     (C.\CTAGS[x] = [t^\ast] \to [])^\ast \\
     C,\CLABELS\,(\LCATCH~[t_2^\ast]) \vdashinstrseq \instr_2^\ast : [t^\ast] \to [t_2^\ast])^\ast \\
     (C,\CLABELS\,(\LCATCH~[t_2^\ast]) \vdashinstrseq \instr_3^\ast : [] \to [t_2^\ast])^?
   \end{array}
   }{
   C \vdashinstr \TRY~\blocktype~\instr_1^\ast~(\CATCH~x~\instr_2^\ast)^\ast~(\CATCHALL~\instr_3^\ast)^?~\END : [t_1^\ast] \to [t_2^\ast]
   }


.. note::
   The :ref:`notation <notation-extend>` :math:`C,\CLABELS\,(\LCATCH~[t^\ast])` inserts the new label type at index :math:`0`, shifting all others.


.. _valid-try-delegate:

:math:`\TRY~\blocktype~\instr^\ast~\DELEGATE~l`
...............................................

* The label :math:`C.\CLABELS[l]` must be defined in the context.

* The :ref:`block type <syntax-blocktype>` must be :ref:`valid <valid-blocktype>` as some :ref:`function type <syntax-functype>` :math:`[t_1^\ast] \to [t_2^\ast]`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`result type <syntax-resulttype>` :math:`[t_2^\ast]` prepended to the |CLABELS| vector.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[t_1^\ast] \to [t_2^\ast]`.

* Then the compound instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`.

.. math::
   ~\\
   \frac{
     C \vdashblocktype \blocktype : [t_1^\ast] \to [t_2^\ast]
     \qquad
     C,\CLABELS\,[t_2^\ast] \vdashinstrseq \instr^\ast : [t_1^\ast]\to[t_2^\ast]
     \qquad
     C.\CLABELS[l] = [t_0^\ast]
   }{
   C \vdashinstrseq \TRY~\blocktype~\instr^\ast~\DELEGATE~l : [t_1^\ast]\to[t_2^\ast]
   }

.. note::
   The :ref:`label index <syntax-labelidx>` space in the :ref:`context <context>` :math:`C` contains the most recent label first, so that :math:`C.\CLABELS[l]` performs a relative lookup as expected.


.. _valid-rethrow:

:math:`\RETHROW~l`
..................

* The label :math:`C.\CLABELS[l]` must be defined in the context.

* Let :math:`(\LCATCH^?~[t^\ast])` be the :ref:`label type <syntax-labeltype>` :math:`C.\CLABELS[l]`.

* The |LCATCH| must be present in the :ref:`label type <syntax-labeltype>` :math:`C.\CLABELS[l]`.

* Then the instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`, for any sequences of  :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.


.. math::
   ~\\
   \frac{
     C.\CLABELS[l] = \LCATCH~[t^\ast]
   }{
     C \vdashinstr \RETHROW~l : [t_1^\ast] \to [t_2^\ast]
   }


.. note::
   The |RETHROW| instruction is stack-polymorphic.

.. _exec:

Execution
=========

.. _syntax-runtime:

Runtime Structure
-----------------

.. _handler:
.. _stack:

Stack
~~~~~

.. _syntax-handler:

**Exception Handlers**

Legacy exception handlers are installed by |TRY| instructions.
Instead of branch labels, their catch clauses have instruction blocks associated with them.
Furthermore, a |DELEGATE| handler is associated with a label index to implicitly rewthrow to:

.. math::
   \begin{array}{llllll}
     \production{catch} & \catch &::=& \dots \\ &&|&
       \CATCH~\tagidx~\instr^\ast \\ &&|&
       \CATCHALL~\tagidx~\instr^\ast \\ &&|&
       \DELEGATE~\labelidx \\
   \end{array}


.. _syntax-caught:
.. _syntax-instr-admin:

Administrative Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Administrative instructions are extended with the |CAUGHT| instruction that models exceptions caught by legacy exception handlers.

.. math::
   \begin{array}{llcl}
   \production{administrative instruction} & \instr &::=& \dots \\ &&|&
     \CAUGHT_n\{\exnaddr\}~\instr^\ast~\END \\
   \end{array}


.. _syntax-ctxt-block:

Block Contexts
..............

Block contexts are extended to include |CAUGHT| instructions:

.. math::
   \begin{array}{llll}
   \production{block contexts} & \XB^k &::=& \dots \\ &&|&
     \CAUGHT_n~\{\exnaddr\}~\XB^k~\END \\
   \end{array}


.. _syntax-ctxt-throw:

Throw Contexts
..............

Throw contexts are also extended to include |CAUGHT| instructions:

.. math::
   \begin{array}{llll}
   \production{throw contexts} & \XT &::=& \dots \\ &&|&
     \CAUGHT_n\{\exnaddr\}~\XT~\END \\
   \end{array}


.. _exec-instr:

Instructions
------------

.. _exec-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-try-catch:

:math:`\TRY~\blocktype~\instr_1^\ast~(\CATCH~x~\instr_2^\ast)^\ast~(\CATCHALL~\instr_3^\ast)^?~\END`
....................................................................................................

1. Assert: due to :ref:`validation <valid-blocktype>`, :math:`\expand_F(\blocktype)` is defined.

2. Let :math:`[t_1^m] \to [t_2^n]` be the :ref:`function type <syntax-functype>` :math:`\expand_F(\blocktype)`.

3. Let :math:`L` be the label whose arity is :math:`n` and whose continuation is the end of the |TRY| instruction.

4. Assert: due to :ref:`validation <valid-try-catch>`, there are at least :math:`m` values on the top of the stack.

5. Pop the values :math:`\val^m` from the stack.

6. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

7. For each catch clause :math:`(\CATCH~x_i~\instr_{2i}^\ast)` do:

   a. Assert: due to :ref:`validation <valid-try-catch>`, :math:`F.\AMODULE.\MITAGS[x_i]` exists.

   b. Let :math:`a_i` be the tag address :math:`F.\AMODULE.\MITAGS[x_i]`.

   c. Let :math:`\catch_i` be the catch clause :math:`(\CATCH~a_i~\instr_{2i}^\ast)`.

8. If there is a catch-all clause :math:`(\CATCHALL~\instr_3^\ast)`, then:

    a. Let :math:`\catch'^?` be the handler :math:`(\CATCHALL~\instr_3^\ast)`.

9. Else:

    a. Let :math:`\catch'^?` be empty.

10. Let :math:`\catch^\ast` be the concatenation of :math:`\catch_i` and :math:`\catch'^?`.

11. :ref:`Enter <exec-handler-enter>` the block :math:`\val^m~\instr_1^\ast` with label :math:`L` and exception handler :math:`\HANDLER_n\{\catch^\ast\}^\ast`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   F; \val^m~(\TRY~\X{bt}~\instr_1^\ast~(\CATCH~x~\instr_2^\ast)^\ast~(\CATCHALL~\instr_3^\ast)^?~\END
   \quad \stepto \\
   \qquad F; \LABEL_n\{\epsilon\}~(\HANDLER_n\{(\CATCH~a_x~\instr_2^\ast)^\ast~(\CATCHALL~\instr_3^\ast)^?\}~\val^m~\instr_1^\ast~\END)~\END \\
   (\iff \expand_F(\X{bt}) = [t_1^m] \to [t_2^n] \land (F.\AMODULE.\MITAGS[x]=a_x)^\ast)
   \end{array}


.. _exec-try-delegate:

:math:`\TRY~\blocktype~\instr^\ast~\DELEGATE~l`
...............................................

1. Assert: due to :ref:`validation <valid-blocktype>`, :math:`\expand_F(\blocktype)` is defined.

2. Let :math:`[t_1^m] \to [t_2^n]` be the :ref:`function type <syntax-functype>` :math:`\expand_F(\blocktype)`.

3. Let :math:`L` be the label whose arity is :math:`n` and whose continuation is the end of the |TRY| instruction.

4. Let :math:`H` be the :ref:`exception handler <syntax-handler>` :math:`l`, targeting the :math:`l`-th surrounding block.

5. Assert: due to :ref:`validation <valid-try-delegate>`, there are at least :math:`m` values on the top of the stack.

6. Pop the values :math:`\val^m` from the stack.

7. :ref:`Enter <exec-handler-enter>` the block :math:`\val^m~\instr^\ast` with label :math:`L` and  exception handler `\HANDLER_n\{\DELEGATE~l\}`.

.. math::
   ~\\[-1ex]
   \begin{array}{lcl}
   F; \val^m~(\TRY~\X{bt}~\instr^\ast~\DELEGATE~l) &\stepto&
   F; \LABEL_n\{\epsilon\}~(\HANDLER_n\{\DELEGATE~l\}~\val^m~\instr^\ast~\END)~\END \\
   && (\iff \expand_F(\X{bt}) = [t_1^m] \to [t_2^n])
   \end{array}


.. _exec-throw_ref:

:math:`\THROWREF`
.................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-throw_ref>`, a :ref:`reference <syntax-ref>` is on the top of the stack.

3. Pop the reference :math:`\reff` from the stack.

4. If :math:`\reff` is :math:`\REFNULL~\X{ht}`, then:

   a. Trap.

5. Assert: due to :ref:`validation <valid-throw_ref>`, :math:`\reff` is an :ref:`exception reference <syntax-ref.exn-addr>`.

6. Let :math:`\REFEXNADDR~\X{ea}` be :math:`\reff`.

7. Assert: due to :ref:`validation <valid-throw_ref>`, :math:`S.\SEXNS[\X{ea}]` exists.

8. Let :math:`\X{exn}` be the :ref:`exception instance <syntax-exninst>` :math:`S.\SEXNS[\X{ea}]`.

9. Let :math:`a` be the :ref:`tag address <syntax-tagaddr>` :math:`\X{exn}.\EITAG`.

10. While the stack is not empty and the top of the stack is not an :ref:`exception handler <syntax-handler>`, do:

   a. Pop the top element from the stack.

11. Assert: the stack is now either empty, or there is an exception handler on the top of the stack.

12. If the stack is empty, then:

   a. Return the exception :math:`(\REFEXNADDR~a)` as a :ref:`result <syntax-result>`.

13. Assert: there is an :ref:`exception handler <syntax-handler>` on the top of the stack.

14. Pop the exception handler  :math:`\HANDLER_n\{\catch^\ast\}` from the stack.

15. If :math:`\catch^\ast` is empty, then:

    a. Push the exception reference :math:`\REFEXNADDR~\X{ea}` back to the stack.

    b. Execute the instruction |THROWREF| again.

16. Else:

    a. Let :math:`\catch_1` be the first :ref:`catch clause <syntax-catch>` in :math:`\catch^\ast` and :math:`{\catch'}^\ast` the remaining clauses.

    b. If :math:`\catch_1` is of the form :math:`\CATCH~x~l` and the :ref:`exception address <syntax-exnaddr>` :math:`a` equals :math:`F.\AMODULE.\MITAGS[x]`, then:

       i. Push the values :math:`\X{exn}.\EIFIELDS` to the stack.

       ii. Execute the instruction :math:`\BR~l`.

    c. Else if :math:`\catch_1` is of the form :math:`\CATCHREF~x~l` and the :ref:`exception address <syntax-exnaddr>` :math:`a` equals :math:`F.\AMODULE.\MITAGS[x]`, then:

       i. Push the values :math:`\X{exn}.\EIFIELDS` to the stack.

       ii. Push the exception reference :math:`\REFEXNADDR~\X{ea}` to the stack.

       iii. Execute the instruction :math:`\BR~l`.

    d. Else if :math:`\catch_1` is of the form :math:`\CATCHALL~l`, then:

       i. Execute the instruction :math:`\BR~l`.

    e. Else if :math:`\catch_1` is of the form :math:`\CATCHALLREF~l`, then:

       i. Push the exception reference :math:`\REFEXNADDR~\X{ea}` to the stack.

       ii. Execute the instruction :math:`\BR~l`.

    f. Else if :math:`\catch_1` is of the form :math:`\CATCH~x~\instr^\ast` and the :ref:`exception address <syntax-exnaddr>` :math:`a` equals :math:`F.\AMODULE.\MITAGS[x]`, then:

       i. Push the caught exception :math:`\CAUGHT_n\{\X{ea}\}` to the stack.

       ii. Push the values :math:`\X{exn}.\EIFIELDS` to the stack.

       iii. :ref:`Enter <exec-caught-enter>` the catch block :math:`\instr^\ast`.

    g. Else if :math:`\catch_1` is of the form :math:`\CATCHALL~\instr^\ast`, then:

       i. Push the caught exception :math:`\CAUGHT_n\{\X{ea}\}` to the stack.

       ii. :ref:`Enter <exec-caught-enter>` the catch block :math:`\instr^\ast`.

    h. Else if :math:`\catch_1` is of the form :math:`\DELEGATE~l`, then:

       i. Assert: due to :ref:`validation <valid-handleradm>`, the stack contains at least :math:`l` labels.

       ii. Repeat :math:`l` times:

           * While the top of the stack is not a label, do:

              - Pop the top element from the stack.

       iii. Assert: due to :ref:`validation <valid-handleradm>`, the top of the stack now is a label.

       iv. Pop the label from the stack.

       v. Push the exception reference :math:`\REFEXNADDR~\X{ea}` back to the stack.

       vi. Execute the instruction :math:`\THROWREF` again.

    i. Else:

       1. Push the modified handler  :math:`\HANDLER_n\{{\catch'}^\ast\}` back to the stack.

       2. Push the exception reference :math:`\REFEXNADDR~\X{ea}` back to the stack.

       3. Execute the instruction :math:`\THROWREF` again.

.. math::
   ~\\[-1ex]
   \begin{array}{rcl}
   \dots \\
   \HANDLER_n\{(\CATCH~x~\instr^\ast)~\catch^\ast\}~\XT[(\REFEXNADDR~a)~\THROWREF]~\END &\stepto&
     \CAUGHT_n\{a\}~\X{exn}.\EIFIELDS~\instr^\ast~\END \\ &&
     (\begin{array}[t]{@{}r@{~}l@{}}
      \iff & \X{exn} = S.\SEXNS[a] \\
      \land & \X{exn}.\EITAG = F.\AMODULE.\MITAGS[x]) \\
      \end{array} \\
   \HANDLER_n\{(\CATCHALL~\instr^\ast)~\catch^\ast\}~\XT[(\REFEXNADDR~a)~\THROWREF]~\END &\stepto&
     \CAUGHT_n\{a\}~\instr^\ast~\END \\
   \XB^l[\HANDLER_n\{(\DELEGATE~l)~\catch^\ast\}~\XT[(\REFEXNADDR~a)~\THROWREF]~\END] &\stepto&
     (\REFEXNADDR~a)~\THROWREF \\
   \end{array}


.. _exec-rethrow:

:math:`\RETHROW~l`
..................

1. Assert: due to :ref:`validation <valid-rethrow>`, the stack contains at least :math:`l+1` labels.

2. Let :math:`L` be the :math:`l`-th label appearing on the stack, starting from the top and counting from zero.

3. Assert: due to :ref:`validation <valid-rethrow>`, :math:`L` is a catch label, i.e., a label of the form :math:`(\LCATCH~[t^\ast])`, which is a label followed by a caught exception in an active catch clause.

4. Let :math:`a` be the caught exception address.

5. Push the value :math:`\REFEXNADDR~a` onto the stack.

6. Execute the instruction |THROWREF|.

.. math::
   ~\\[-1ex]
   \begin{array}{lclr@{\qquad}}
   \CAUGHT_n\{a\}~\XB^l[\RETHROW~l]~\END &\stepto&
   \CAUGHT_n\{a\}~\XB^l[(\REFEXNADDR~a)~\THROWREF]~\END \\
   \end{array}


.. _exec-caught-enter:

Entering a catch block
......................

1. Jump to the start of the instruction sequence :math:`\instr^\ast`.


.. _exec-caught-exit:

Exiting a catch block
.....................

When the |END| of a catch block is reached without a jump, thrown exception, or trap, then the following steps are performed.

1. Let :math:`\val^m` be the values on the top of the stack.

2. Pop the values :math:`\val^m` from the stack.

3. Assert: due to :ref:`validation <valid-caught>`, a caught exception is now on the top of the stack.

4. Pop the caught exception from the stack.

5. Push :math:`\val^m` back to the stack.

6. Jump to the position after the |END| of the administrative instruction associated with the caught exception.

.. math::
   \begin{array}{rcl}
   \CAUGHT_n\{a\}~\val^m~\END  &\stepto& \val^m
   \end{array}

.. note::
   A caught exception can only be rethrown from the scope of the administrative instruction associated with it, i.e., from the scope of the |CATCH| or |CATCHALL| block of a legacy |TRY| instruction. Upon exit from that block, the caught exception is discarded.

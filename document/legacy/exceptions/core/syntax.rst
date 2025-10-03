.. _syntax:

Structure
=========

.. _syntax-instr:

Instructions
------------

.. _syntax-try:
.. _syntax-try-catch:
.. _syntax-try-delegate:
.. _syntax-rethrow:
.. _syntax-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

The set of recognised instructions is extended with the following:

.. math::
   \begin{array}{llcl}
   \production{instruction} & \instr &::=&
     \dots \\&&|&
     \TRY~\blocktype~\instr^\ast~(\CATCH~\tagidx~\instr^\ast)^\ast~(\CATCHALL~\instr^\ast)^?~\END \\ &&|&
     \TRY~\blocktype~\instr^\ast~\DELEGATE~\labelidx \\ &&|&
     \RETHROW~\labelidx \\
   \end{array}

The instructions |TRY| and |RETHROW|, are concerned with exceptions.
The |TRY| instruction installs an exception handler, and may either handle exceptions in the case of |CATCH| and |CATCHALL|,
or rethrow them in an outer block in the case of |DELEGATE|.

The |RETHROW| instruction is only allowed inside a |CATCH| or |CATCHALL| clause and allows rethrowing the caught exception by lexically referring to a the corresponding |TRY|.

When |TRY|-|DELEGATE| handles an exception, it also behaves similar to a forward jump,
effectively rethrowing the caught exception right before the matching |END|.

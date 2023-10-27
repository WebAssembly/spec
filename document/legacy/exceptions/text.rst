.. _text:

Text Format
===========

.. _text-instr:

Instructions
------------

.. _text-blockinstr:
.. _text-plaininstr:
.. _text-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _text-try:

The label identifier on a structured control instruction may optionally be repeated after the corresponding :math:`\T{end}`, :math:`\T{else}`, :math:`\T{catch}`, :math:`\T{catch\_all}`, and :math:`\T{delegate}`
pseudo instructions, to indicate the matching delimiters.

.. math::
   \begin{array}{llclll}
   \production{block instruction} & \Tblockinstr_I &::=& \dots \\ &&|&
     \text{try}~~I'{:}\Tlabel_I~~\X{bt}{:}\Tblocktype~~(\X{in}_1{:}\Tinstr_{I'})^\ast~~
       (\text{catch}~~\Tid_1^?~~x{:}\Ttagidx_I~~(\X{in}_2{:}\Tinstr_{I'})^\ast)^\ast~~
       \\ &&&\qquad\qquad (\text{catch\_all}~~\Tid_1^?~~(\X{in}_3{:}\Tinstr_{I'})^\ast)^?~~\text{end}~~\Tid_2^?
       \\ &&&\qquad \Rightarrow\quad \TRY~\X{bt}~\X{in}_1^\ast~(\CATCH~x~\X{in}_2^\ast)^\ast~(\CATCHALL~\X{in}_3^\ast)^?~\END
       \\ &&&\qquad\qquad (\iff \Tid_1^? = \epsilon \vee \Tid_1^? = \Tlabel, \Tid_2^? = \epsilon \vee \Tid_2^? = \Tlabel) \\ &&|&
     \text{try}~~I'{:}\Tlabel_I~~\X{bt}{:}\Tblocktype~~(\X{in}_1{:}\Tinstr_{I'})^\ast
       ~~\text{delegate}~~l{:}\Tlabelidx_I~~\X{l}{:}\Tlabelidx_I
       \\ &&&\qquad \Rightarrow\quad \TRY~\X{bt}~\X{in}_1^\ast~\DELEGATE~l
       \qquad\quad~~ (\iff \Tid^? = \epsilon \vee \Tid^? = \Tlabel) \\
   \production{plain instruction} & \Tplaininstr_I &::=& \dots \\ &&|&
     \text{rethrow}~~l{:}\Tlabelidx_I \quad\Rightarrow\quad \RETHROW~l \\
   \end{array}

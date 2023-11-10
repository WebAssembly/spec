.. _binary:

Binary Format
=============

.. _binary-instr:

Instructions
------------

.. _binary-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _binary-try:
.. _binary-rethrow:

.. math::
   \begin{array}{llcllll}
   \production{instruction} & \Binstr &::=& \dots \\ &&|&
     \hex{06}~~\X{bt}{:}\Bblocktype~~(\X{in}_1{:}\Binstr)^\ast~~
       (\hex{07}~~x{:}\Btagidx~~(\X{in}_2{:}\Binstr)^\ast)^\ast~~
       (\hex{19}~~(\X{in}_3{:}\Binstr)^\ast)^?~~\hex{0B}
       &\Rightarrow& \TRY~\X{bt}~\X{in}_1^\ast~(\CATCH~x~\X{in}_2^\ast)^\ast~
       (\CATCHALL~\X{in}_3^\ast)^?\END \\ &&|&
     \hex{06}~~\X{bt}{:}\Bblocktype~~(\X{in}{:}\Binstr)^\ast~~\hex{18}~~l{:}\Blabelidx
       &\Rightarrow& \TRY~\X{bt}~\X{in}^\ast~\DELEGATE~l \\ &&|&
     \hex{09}~~l{:}\Blabelidx &\Rightarrow& \RETHROW~l \\
   \end{array}

.. _valid-conventions:

Conventions
-----------

.. _syntax-context:
.. _valid-conventions-contexts:

Contexts
~~~~~~~~

.. math::
   \begin{array}{@{}l@{}rrl@{}}
   & \mathit{context} &::=& \{\; \begin{array}[t]{@{}l@{}}
   \mathsf{func}~{\mathit{functype}^\ast},\; \mathsf{global}~{\mathit{globaltype}^\ast},\; \mathsf{table}~{\mathit{tabletype}^\ast},\; \mathsf{mem}~{\mathit{memtype}^\ast},\; \\
     \mathsf{elem}~{\mathit{elemtype}^\ast},\; \mathsf{data}~{\mathit{datatype}^\ast},\; \\
     \mathsf{local}~{\mathit{valtype}^\ast},\; \mathsf{label}~{\mathit{resulttype}^\ast},\; \mathsf{return}~{\mathit{resulttype}^?} \;\}\end{array} \\
   \end{array}

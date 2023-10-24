.. _exec-auxiliary:

Auxiliary
---------

.. _exec-auxiliary-general-constants:

General Constants
~~~~~~~~~~~~~~~~~

.. _def-Ki:


:math:`\Ki-()`
..............


1. Return :math:`1024`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{Ki} &=& 1024 &  \\
   \end{array}

.. _exec-auxiliary-general-functions:

General Functions
~~~~~~~~~~~~~~~~~

.. _def-min:


:math:`\min-(x_{0}, x_{1})`
...........................


1. If :math:`x_{0}` is :math:`0`, then:

   a. Return :math:`0`.

2. If :math:`x_{1}` is :math:`0`, then:

   a. Return :math:`0`.

3. Assert: Due to validation, :math:`x_{0}` is greater than or equal to :math:`1`.

4. Let :math:`i` be :math:`{x_{0}} - {1}`.

5. Assert: Due to validation, :math:`x_{1}` is greater than or equal to :math:`1`.

6. Let :math:`j` be :math:`{x_{1}} - {1}`.

7. Return :math:`\min-(i, j)`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   \mathrm{min}(0,\, \mathit{j}) &=& 0 &  \\[0.8ex]
   \mathrm{min}(\mathit{i},\, 0) &=& 0 &  \\[0.8ex]
   \mathrm{min}(\mathit{i} + 1,\, \mathit{j} + 1) &=& \mathrm{min}(\mathit{i},\, \mathit{j}) &  \\
   \end{array}

.. _exec-auxiliary-types:

Auxiliary Definitions on Types
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _def-size:


:math:`\size-(x_{0})`
.....................


1. If :math:`x_{0}` is :math:`\I32-numtype`, then:

   a. Return :math:`32`.

2. If :math:`x_{0}` is :math:`\I64-numtype`, then:

   a. Return :math:`64`.

3. If :math:`x_{0}` is :math:`\F32-numtype`, then:

   a. Return :math:`32`.

4. If :math:`x_{0}` is :math:`\F64-numtype`, then:

   a. Return :math:`64`.

5. If :math:`x_{0}` is :math:`\V128-vectype`, then:

   a. Return :math:`128`.



\

.. math::
   \begin{array}{@{}lcl@{}l@{}}
   {|\mathsf{i{\scriptstyle32}}|} &=& 32 &  \\[0.8ex]
   {|\mathsf{i{\scriptstyle64}}|} &=& 64 &  \\[0.8ex]
   {|\mathsf{f{\scriptstyle32}}|} &=& 32 &  \\[0.8ex]
   {|\mathsf{f{\scriptstyle64}}|} &=& 64 &  \\[0.8ex]
   {|\mathsf{v{\scriptstyle128}}|} &=& 128 &  \\
   \end{array}

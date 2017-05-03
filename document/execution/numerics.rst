.. _exec-numeric:

Numerics
--------

.. todo::
   Describe


.. _aux-bytes:
.. _aux-signed:
.. _aux-extend:
.. _aux-wrap:

Auxiliary Operations
~~~~~~~~~~~~~~~~~~~~

.. math::
   \begin{array}{lll@{\qquad}l}
   \bytes_N(i) &=& \epsilon & (N = 0 \wedge i = 0) \\
   \bytes_N(i) &=& b~\bytes_{N-8}(j) & (N \geq 8 \wedge i = 2^8\cdot j + b) \\
   ~ \\
   \bytes_{\K{i}N}(i) &=& \bytes_N(i) \\
   \bytes_{\K{f}N}(b^N) &=& \F{reverse}(b^N) \\
   \end{array}

Note that |bytes| is a bijection, hence the function is invertible.

.. math::
   \begin{array}{lll@{\qquad}l}
   \signed_N(i) &=& i & (0 \leq i < 2^{N-1}) \\
   \signed_N(i) &=& i - 2^N & (2^{N-1} \leq i < 2^N) \\
   \signed_N(-i) &=& -i & (0 < i \geq 2^{N-1}) \\
   ~ \\
   \extend_{\B{U},N}(i) &=& i \\
   \extend_{\B{S},N}(i) &=& \signed_N(i) \\
   \wrap_N(i) &=& i \mod 2^N \\
   \end{array}

.. Note::
   The index :math:`N` of the |extend| function is the size extending *from*,
   where as the index of the |wrap| function is the size wrapping *to*.


Integer Operations
~~~~~~~~~~~~~~~~~~


Floating-Point Operations
~~~~~~~~~~~~~~~~~~~~~~~~~


Conversions
~~~~~~~~~~~

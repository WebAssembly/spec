.. _valid-types:

Types
-----

.. _valid-Limits_ok:
.. _valid-types-limits:

Limits
~~~~~~

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{n}_{1} \leq \mathit{n}_{2} \leq \mathit{k}
   }{
   { \vdash }\;[\mathit{n}_{1} .. \mathit{n}_{2}] : \mathit{k}
   }
   \qquad
   \end{array}

.. _valid-Functype_ok:
.. _valid-types-function-types:

Function Types
~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   }{
   { \vdash }\;\mathit{ft} : \mathsf{ok}
   }
   \qquad
   \end{array}

.. _valid-Tabletype_ok:
.. _valid-types-table-types:

Table Types
~~~~~~~~~~~

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   { \vdash }\;\mathit{lim} : {2^{32}} - 1
   }{
   { \vdash }\;\mathit{lim}~\mathit{rt} : \mathsf{ok}
   }
   \qquad
   \end{array}

.. _valid-Memtype_ok:
.. _valid-types-memory-types:

Memory Types
~~~~~~~~~~~~

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   { \vdash }\;\mathit{lim} : {2^{16}}
   }{
   { \vdash }\;\mathit{lim}~\mathsf{i{\scriptstyle8}} : \mathsf{ok}
   }
   \qquad
   \end{array}

.. _valid-Globaltype_ok:
.. _valid-types-global-types:

Global Types
~~~~~~~~~~~~

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   }{
   { \vdash }\;\mathit{gt} : \mathsf{ok}
   }
   \qquad
   \end{array}

.. _valid-Externtype_ok-func:
.. _valid-Externtype_ok-table:
.. _valid-Externtype_ok-mem:
.. _valid-Externtype_ok-global:
.. _valid-types-external-types:

External Types
~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   { \vdash }\;\mathit{functype} : \mathsf{ok}
   }{
   { \vdash }\;\mathsf{func}~\mathit{functype} : \mathsf{ok}
   } \, {[\textsc{\scriptsize K{-}extern{-}func}]}
   \\[3ex]\displaystyle
   \frac{
   { \vdash }\;\mathit{tabletype} : \mathsf{ok}
   }{
   { \vdash }\;\mathsf{table}~\mathit{tabletype} : \mathsf{ok}
   } \, {[\textsc{\scriptsize K{-}extern{-}table}]}
   \\[3ex]\displaystyle
   \frac{
   { \vdash }\;\mathit{memtype} : \mathsf{ok}
   }{
   { \vdash }\;\mathsf{mem}~\mathit{memtype} : \mathsf{ok}
   } \, {[\textsc{\scriptsize K{-}extern{-}mem}]}
   \\[3ex]\displaystyle
   \frac{
   { \vdash }\;\mathit{globaltype} : \mathsf{ok}
   }{
   { \vdash }\;\mathsf{global}~\mathit{globaltype} : \mathsf{ok}
   } \, {[\textsc{\scriptsize K{-}extern{-}global}]}
   \qquad
   \end{array}

.. _valid-Limits_sub:
.. _valid-Functype_sub:
.. _valid-Externtype_sub/func:
.. _valid-Globaltype_sub:
.. _valid-Externtype_sub/global:
.. _valid-Tabletype_sub:
.. _valid-Externtype_sub/table:
.. _valid-Memtype_sub:
.. _valid-Externtype_sub/mem:
.. _valid-types-import-subtyping:

Import Subtyping
~~~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{n}_{11} \geq \mathit{n}_{21}
    \qquad
   \mathit{n}_{12} \leq \mathit{n}_{22}
   }{
   { \vdash }\;[\mathit{n}_{11} .. \mathit{n}_{12}] \leq [\mathit{n}_{21} .. \mathit{n}_{22}]
   } \, {[\textsc{\scriptsize S{-}limits}]}
   \\[3ex]\displaystyle
   \frac{
   }{
   { \vdash }\;\mathit{ft} \leq \mathit{ft}
   } \, {[\textsc{\scriptsize S{-}func}]}
   \\[3ex]\displaystyle
   \frac{
   { \vdash }\;\mathit{ft}_{1} \leq \mathit{ft}_{2}
   }{
   { \vdash }\;\mathsf{func}~\mathit{ft}_{1} \leq \mathsf{func}~\mathit{ft}_{2}
   } \, {[\textsc{\scriptsize S{-}extern{-}func}]}
   \\[3ex]\displaystyle
   \frac{
   }{
   { \vdash }\;\mathit{gt} \leq \mathit{gt}
   } \, {[\textsc{\scriptsize S{-}global}]}
   \\[3ex]\displaystyle
   \frac{
   { \vdash }\;\mathit{gt}_{1} \leq \mathit{gt}_{2}
   }{
   { \vdash }\;\mathsf{global}~\mathit{gt}_{1} \leq \mathsf{global}~\mathit{gt}_{2}
   } \, {[\textsc{\scriptsize S{-}extern{-}global}]}
   \\[3ex]\displaystyle
   \frac{
   { \vdash }\;\mathit{lim}_{1} \leq \mathit{lim}_{2}
   }{
   { \vdash }\;\mathit{lim}_{1}~\mathit{rt} \leq \mathit{lim}_{2}~\mathit{rt}
   } \, {[\textsc{\scriptsize S{-}table}]}
   \\[3ex]\displaystyle
   \frac{
   { \vdash }\;\mathit{tt}_{1} \leq \mathit{tt}_{2}
   }{
   { \vdash }\;\mathsf{table}~\mathit{tt}_{1} \leq \mathsf{table}~\mathit{tt}_{2}
   } \, {[\textsc{\scriptsize S{-}extern{-}table}]}
   \\[3ex]\displaystyle
   \frac{
   { \vdash }\;\mathit{lim}_{1} \leq \mathit{lim}_{2}
   }{
   { \vdash }\;\mathit{lim}_{1}~\mathsf{i{\scriptstyle8}} \leq \mathit{lim}_{2}~\mathsf{i{\scriptstyle8}}
   } \, {[\textsc{\scriptsize S{-}mem}]}
   \\[3ex]\displaystyle
   \frac{
   { \vdash }\;\mathit{mt}_{1} \leq \mathit{mt}_{2}
   }{
   { \vdash }\;\mathsf{mem}~\mathit{mt}_{1} \leq \mathsf{mem}~\mathit{mt}_{2}
   } \, {[\textsc{\scriptsize S{-}extern{-}mem}]}
   \qquad
   \end{array}

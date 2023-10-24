.. _valid-modules:

Modules
-------

.. _valid-Func_ok:
.. _valid-modules-functions:

Functions
~~~~~~~~~

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{ft} = {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
    \qquad
   { \vdash }\;\mathit{ft} : \mathsf{ok}
    \qquad
   \mathit{C}, \mathsf{local}~{\mathit{t}_{1}^\ast}~{\mathit{t}^\ast}, \mathsf{label}~({\mathit{t}_{2}^\ast}), \mathsf{return}~({\mathit{t}_{2}^\ast}) \vdash \mathit{expr} : {\mathit{t}_{2}^\ast}
   }{
   \mathit{C} \vdash \mathsf{func}~\mathit{ft}~{\mathit{t}^\ast}~\mathit{expr} : \mathit{ft}
   }
   \qquad
   \end{array}

.. _valid-Table_ok:
.. _valid-modules-tables:

Tables
~~~~~~

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   { \vdash }\;\mathit{tt} : \mathsf{ok}
   }{
   \mathit{C} \vdash \mathsf{table}~\mathit{tt} : \mathit{tt}
   }
   \qquad
   \end{array}

.. _valid-Mem_ok:
.. _valid-modules-memories:

Memories
~~~~~~~~

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   { \vdash }\;\mathit{mt} : \mathsf{ok}
   }{
   \mathit{C} \vdash \mathsf{memory}~\mathit{mt} : \mathit{mt}
   }
   \qquad
   \end{array}

.. _valid-Global_ok:
.. _valid-modules-globals:

Globals
~~~~~~~

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   { \vdash }\;\mathit{gt} : \mathsf{ok}
    \qquad
   \mathit{gt} = {\mathsf{mut}^?}~\mathit{t}
    \qquad
   \mathit{C} \vdash \mathit{expr} : \mathit{t}~\mathsf{const}
   }{
   \mathit{C} \vdash \mathsf{global}~\mathit{gt}~\mathit{expr} : \mathit{gt}
   }
   \qquad
   \end{array}

.. _valid-Elem_ok:
.. _valid-Elemmode_ok/active:
.. _valid-Elemmode_ok/declare:
.. _valid-modules-element-segments:

Element Segments
~~~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   (\mathit{C} \vdash \mathit{expr} : \mathit{rt})^\ast
    \qquad
   (\mathit{C} \vdash \mathit{elemmode} : \mathit{rt})^?
   }{
   \mathit{C} \vdash \mathsf{elem}~\mathit{rt}~{\mathit{expr}^\ast}~{\mathit{elemmode}^?} : \mathit{rt}
   } \, {[\textsc{\scriptsize T{-}elem}]}
   \\[3ex]\displaystyle
   \frac{
   \mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{lim}~\mathit{rt}
    \qquad
   (\mathit{C} \vdash \mathit{expr} : \mathsf{i{\scriptstyle32}}~\mathsf{const})^\ast
   }{
   \mathit{C} \vdash \mathsf{table}~\mathit{x}~\mathit{expr} : \mathit{rt}
   } \, {[\textsc{\scriptsize T{-}elemmode{-}active}]}
   \\[3ex]\displaystyle
   \frac{
   }{
   \mathit{C} \vdash \mathsf{declare} : \mathit{rt}
   } \, {[\textsc{\scriptsize T{-}elemmode{-}declare}]}
   \qquad
   \end{array}

.. _valid-Data_ok:
.. _valid-modules-data-segments:

Data Segments
~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   (\mathit{C} \vdash \mathit{datamode} : \mathsf{ok})^?
   }{
   \mathit{C} \vdash \mathsf{data}~{\mathit{b}^\ast}~{\mathit{datamode}^?} : \mathsf{ok}
   } \, {[\textsc{\scriptsize T{-}data}]}
   \\[3ex]\displaystyle
   \frac{
   \mathit{C}.\mathsf{mem}[0] = \mathit{mt}
    \qquad
   (\mathit{C} \vdash \mathit{expr} : \mathsf{i{\scriptstyle32}}~\mathsf{const})^\ast
   }{
   \mathit{C} \vdash \mathsf{memory}~0~\mathit{expr} : \mathsf{ok}
   } \, {[\textsc{\scriptsize T{-}datamode}]}
   \qquad
   \end{array}

.. _valid-Start_ok:
.. _valid-modules-start-function:

Start Function
~~~~~~~~~~~~~~

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C}.\mathsf{func}[\mathit{x}] = \epsilon \rightarrow \epsilon
   }{
   \mathit{C} \vdash \mathsf{start}~\mathit{x} : \mathsf{ok}
   }
   \qquad
   \end{array}

.. _valid-Export_ok:
.. _valid-Externuse_ok/func:
.. _valid-Externuse_ok/table:
.. _valid-Externuse_ok/mem:
.. _valid-Externuse_ok/global:
.. _valid-modules-exports:

Exports
~~~~~~~

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \mathit{C} \vdash \mathit{externuse} : \mathit{xt}
   }{
   \mathit{C} \vdash \mathsf{export}~\mathit{name}~\mathit{externuse} : \mathit{xt}
   } \, {[\textsc{\scriptsize T{-}export}]}
   \\[3ex]\displaystyle
   \frac{
   \mathit{C}.\mathsf{func}[\mathit{x}] = \mathit{ft}
   }{
   \mathit{C} \vdash \mathsf{func}~\mathit{x} : \mathsf{func}~\mathit{ft}
   } \, {[\textsc{\scriptsize T{-}externuse{-}func}]}
   \\[3ex]\displaystyle
   \frac{
   \mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{tt}
   }{
   \mathit{C} \vdash \mathsf{table}~\mathit{x} : \mathsf{table}~\mathit{tt}
   } \, {[\textsc{\scriptsize T{-}externuse{-}table}]}
   \\[3ex]\displaystyle
   \frac{
   \mathit{C}.\mathsf{mem}[\mathit{x}] = \mathit{mt}
   }{
   \mathit{C} \vdash \mathsf{mem}~\mathit{x} : \mathsf{mem}~\mathit{mt}
   } \, {[\textsc{\scriptsize T{-}externuse{-}mem}]}
   \\[3ex]\displaystyle
   \frac{
   \mathit{C}.\mathsf{global}[\mathit{x}] = \mathit{gt}
   }{
   \mathit{C} \vdash \mathsf{global}~\mathit{x} : \mathsf{global}~\mathit{gt}
   } \, {[\textsc{\scriptsize T{-}externuse{-}global}]}
   \qquad
   \end{array}

.. _valid-Import_ok:
.. _valid-modules-imports:

Imports
~~~~~~~

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   { \vdash }\;\mathit{xt} : \mathsf{ok}
   }{
   \mathit{C} \vdash \mathsf{import}~\mathit{name}_{1}~\mathit{name}_{2}~\mathit{xt} : \mathit{xt}
   }
   \qquad
   \end{array}

.. _valid-Module_ok:
.. _valid-modules-modules:

Modules
~~~~~~~

.. math::
   \begin{array}{@{}c@{}}\displaystyle
   \frac{
   \begin{array}{@{}c@{}}
   \mathit{C} = \{ \begin{array}[t]{@{}l@{}}
   \mathsf{func}~{\mathit{ft}^\ast},\; \mathsf{global}~{\mathit{gt}^\ast},\; \mathsf{table}~{\mathit{tt}^\ast},\; \mathsf{mem}~{\mathit{mt}^\ast},\; \mathsf{elem}~{\mathit{rt}^\ast},\; \mathsf{data}~{\mathsf{ok}^{\mathit{n}}} \}\end{array}
    \\
   (\mathit{C} \vdash \mathit{func} : \mathit{ft})^\ast
    \qquad
   (\mathit{C} \vdash \mathit{global} : \mathit{gt})^\ast
    \qquad
   (\mathit{C} \vdash \mathit{table} : \mathit{tt})^\ast
    \qquad
   (\mathit{C} \vdash \mathit{mem} : \mathit{mt})^\ast
    \\
   (\mathit{C} \vdash \mathit{elem} : \mathit{rt})^\ast
    \qquad
   (\mathit{C} \vdash \mathit{data} : \mathsf{ok})^{\mathit{n}}
    \qquad
   (\mathit{C} \vdash \mathit{start} : \mathsf{ok})^?
    \\
   {|{\mathit{mem}^\ast}|} \leq 1
   \end{array}
   }{
   { \vdash }\;\mathsf{module}~{\mathit{import}^\ast}~{\mathit{func}^\ast}~{\mathit{global}^\ast}~{\mathit{table}^\ast}~{\mathit{mem}^\ast}~{\mathit{elem}^\ast}~{\mathit{data}^{\mathit{n}}}~{\mathit{start}^?}~{\mathit{export}^\ast} : \mathsf{ok}
   }
   \qquad
   \end{array}

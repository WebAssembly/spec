Modules
-------


.. _valid-externval:

External Typing
~~~~~~~~~~~~~~~

For the purpose of checking :ref:`external values <syntax-externval>` against :ref:`imports <syntax-import>`,
such values are classified by :ref:`external types <syntax-externtype>`.
The following auxiliary typing rules specify this typing relation relative to a :ref:`store <syntax-store>` :math:`S` in which the external value lives.

:math:`\FUNC~a`
...............

* The store entry :math:`S.\FUNCS[a]` must be a :ref:`function instance <syntax-funcinst>` :math:`\{\MODULE~m, \CODE~f\}`.

* Then :math:`\FUNC~a` is valid with :ref:`external type <syntax-externtype>` :math:`\FUNC~(m.\TYPES[f.\TYPE])`.

.. math::
   \frac{
     S.\FUNCS[a] = \{\MODULE~m, \CODE~f\}
   }{
     S \vdash \FUNC~a : \FUNC~(m.\TYPES[f.\TYPE])
   }


:math:`\TABLE~a`
................

* The store entry :math:`S.\TABLES[a]` must be a :ref:`table instance <syntax-tableinst>` :math:`\{\ELEM~(\X{fa}^?)^n, \MAX~m^?\}`.

* Then :math:`\TABLE~a` is valid with :ref:`external type <syntax-externtype>` :math:`\TABLE~(\{\MIN~n, \MAX~m^?\}~\ANYFUNC)`.

.. math::
   \frac{
     S.\TABLES[a] = \{ \ELEM~(\X{fa}^?)^n, \MAX~m^? \}
   }{
     S \vdash \TABLE~a : \TABLE~(\{\MIN~n, \MAX~m^?\}~\ANYFUNC)
   }


:math:`\MEM~a`
..............

* The store entry :math:`S.\MEMS[a]` must be a :ref:`memory instance <syntax-meminst>` :math:`\{\DATA~b^{n\cdot64\,\F{Ki}}, \MAX~m^?\}`, for some :math:`n`.

* Then :math:`\MEM~a` is valid with :ref:`external type <syntax-externtype>` :math:`\MEM~(\{\MIN~n, \MAX~m^?\})`.

.. math::
   \frac{
     S.\MEMS[a] = \{ \DATA~b^{n\cdot64\,\F{Ki}}, \MAX~m^? \}
   }{
     S \vdash \MEM~a : \MEM~\{\MIN~n, \MAX~m^?\}
   }


:math:`\GLOBAL~a`
.................

* The store entry :math:`S.\GLOBALS[a]` must be a :ref:`global instance <syntax-globalinst>` :math:`\{\VALUE~(t.\CONST~c), \MUT~\mut\}`.

* Then :math:`\GLOBAL~a` is valid with :ref:`external type <syntax-externtype>` :math:`\GLOBAL~(\mut~t)`.

.. math::
   \frac{
     S.\GLOBALS[a] = \{ \VALUE~(t.\CONST~c), \MUT~\mut \}
   }{
     S \vdash \GLOBAL~a : \GLOBAL~(\mut~t)
   }



.. _exec-import:
.. _match-externtype:

Import Matching
~~~~~~~~~~~~~~~

When :ref:`instantiating <exec-module>` a module,
:ref:`external values <syntax-externval>` must be provided whose :ref:`types <valid-externval>` are *matched* against the respective :ref:`external types <syntax-externtype>` classifying each import.
In some cases, this allows for a simple form of subtyping, as defined below.

.. _match-limits:

Limits
......

:ref:`Limits <syntax-limits>` :math:`\{ \MIN~n_1, \MAX~m_1^? \}` match limits :math:`\{ \MIN~n_2, \MAX~m_2^? \}` if and only if:

* :math:`n_1` is not smaller than :math:`n_2`.

* Either:

  * :math:`m_2^?` is empty.

* Or:

  * Both :math:`m_1^?` and :math:`m_2^?` are non-empty.

  * :math:`m_1` is not larger than :math:`m_2`.

.. math::
   \frac{
     n_1 \geq n_2
   }{
     \vdash \{ \MIN~n_1, \MAX~m_1^? \} \leq \{ \MIN~n_2, \MAX~\epsilon \}
   }
   \quad
   \frac{
     n_1 \geq n_2
     \qquad
     m_1 \leq m_2
   }{
     \vdash \{ \MIN~n_1, \MAX~m_1 \} \leq \{ \MIN~n_2, \MAX~m_2 \}
   }


Functions
.........

An :ref:`external type <syntax-externtype>` :math:`\FUNC~\functype_1` matches :math:`\FUNC~\functype_2` if and only if:

* Both :math:`\functype_1` and :math:`\functype_2` are the same.

.. math::
   \frac{
   }{
     \vdash \FUNC~\functype \leq \FUNC~\functype
   }


Tables
......

An :ref:`external type <syntax-externtype>` :math:`\TABLE~(\limits_1~\elemtype_1)` matches :math:`\TABLE~(\limits_2~\elemtype_2)` if and only if:

* Limits :math:`\limits_1` :ref:`match <match-limits>` :math:`\limits_2`.

* Both :math:`\elemtype_1` and :math:`\elemtype_2` are the same.

.. math::
   \frac{
     \vdash \limits_1 \leq \limits_2
   }{
     \vdash \TABLE~(\limits_1~\elemtype) \leq \TABLE~(\limits_2~\elemtype)
   }


Memories
........

An :ref:`external type <syntax-externtype>` :math:`\MEM~\limits_1` matches :math:`\MEM~\limits_2` if and only if:

* Limits :math:`\limits_1` :ref:`match <match-limits>` :math:`\limits_2`.

.. math::
   \frac{
     \vdash \limits_1 \leq \limits_2
   }{
     \vdash \MEM~\limits_1 \leq \MEM~\limits_2
   }


Globals
.......

An :ref:`external type <syntax-externtype>` :math:`\GLOBAL~\globaltype_1` matches :math:`\GLOBAL~\globaltype_2` if and only if:

* Both :math:`\globaltype_1` and :math:`\globaltype_2` are the same.

.. math::
   \frac{
   }{
     \vdash \GLOBAL~\globaltype \leq \GLOBAL~\globaltype
   }


.. _alloc:

Allocation
~~~~~~~~~~

New instances of :ref:`functions <syntax-funcinst>`, :ref:`tables <syntax-tableinst>`, :ref:`memories <syntax-meminst>`, :ref:`globals <syntax-globalinst>`, and :ref:`modules <syntax-moduleinst>` are *allocated* in a :ref:`store <syntax-store>` :math:`S`, as defined by the following auxiliary functions.


.. _alloc-func:

:ref:`Functions <syntax-funcinst>`
..................................

1. Let :math:`\func` be the :ref:`function <syntax-func>` to allocate and :math:`\moduleinst` its :ref:`module instance <syntax-moduleinst>`.

2. Let :math:`a` be the first free :ref:`function address <syntax-funcaddr>` in :math:`S`.

3. Let :math:`\funcinst` be the :ref:`function instance <syntax-funcinst>` :math:`\{ \MODULE~\moduleinst, \CODE~\func \}`.

4. Append :math:`\funcinst` to the |FUNCS| of :math:`S`.

5. Return :math:`a`.

.. math::
   \begin{array}{rlll}
   \allocfunc(S, \func, \moduleinst) &=& S', \funcaddr \\[1ex]
   \mbox{where:} \hfill \\
   \funcaddr &=& |S.\FUNCS| \\
   \funcinst &=& \{ \MODULE~\moduleinst, \CODE~\func \} \\
   S' &=& S \compose \{\FUNCS~\tableinst\} \\
   \end{array}

.. _alloc-table:

:ref:`Tables <syntax-tableinst>`
................................

1. Let :math:`\table` be the :ref:`table <syntax-table>` to allocate.

2. Let :math:`(\{\MIN~n, \MAX~m^?\}~\elemtype)` be the :ref:`table type <syntax-tabletype>` :math:`\table.\TYPE`.

3. Let :math:`a` be the first free :ref:`table address <syntax-tableaddr>` in :math:`S`.

4. Let :math:`\tableinst` be the :ref:`table instance <syntax-tableinst>` :math:`\{ \ELEM~(\epsilon)^n, \MAX~m^? \}` with :math:`n` empty elements.

5. Append :math:`\tableinst` to the |TABLES| of :math:`S`.

6. Return :math:`a`.

.. math::
   \begin{array}{rlll}
   \alloctable(S, \table) &=& S', \tableaddr \\[1ex]
   \mbox{where:} \hfill \\
   \table.\TYPE &=& \{\MIN~n, \MAX~m^?\}~\elemtype \\
   \tableaddr &=& |S.\TABLES| \\
   \tableinst &=& \{ \ELEM~(\epsilon)^n, \MAX~m^? \} \\
   S' &=& S \compose \{\TABLES~\tableinst\} \\
   \end{array}

.. _alloc-mem:

:ref:`Memories <syntax-meminst>`
................................

1. Let :math:`\mem` be the :ref:`memory <syntax-mem>` to allocate.

2. Let :math:`\{\MIN~n, \MAX~m^?\}` be the :ref:`table type <syntax-memtype>` :math:`\mem.\TYPE`.

3. Let :math:`a` be the first free :ref:`memory address <syntax-memaddr>` in :math:`S`.

4. Let :math:`\meminst` be the :ref:`memory instance <syntax-meminst>` :math:`\{ \DATA~(\hex{00})^{n \cdot 64\,\F{Ki}}, \MAX~m^? \}` that contains :math:`n` pages of zeroed bytes.

5. Append :math:`\meminst` to the |MEMS| of :math:`S`.

6. Return :math:`a`.

.. math::
   \begin{array}{rlll}
   \allocmem(S, \mem) &=& S', \memaddr \\[1ex]
   \mbox{where:} \hfill \\
   \mem.\TYPE &=& \{\MIN~n, \MAX~m^?\} \\
   \memaddr &=& |S.\MEMS| \\
   \meminst &=& \{ \DATA~(\hex{00})^{n \cdot 64\,\F{Ki}}, \MAX~m^? \} \\
   S' &=& S \compose \{\MEMS~\meminst\} \\
   \end{array}

.. _alloc-global:

:ref:`Globals <syntax-globalinst>`
..................................

1. Let :math:`\global` be the :ref:`global <syntax-global>` to allocate.

2. Let :math:`\mut~t` be the :ref:`global type <syntax-globaltype>` :math:`\global.\TYPE`.

3. Let :math:`a` be the first free :ref:`global address <syntax-globaladdr>` in :math:`S`.

4. Let :math:`\globalinst` be the :ref:`global instance <syntax-globalinst>` :math:`\{ \VALUE~(t.\CONST~0), \MUT~\mut \}` whose contents is a zero :ref:`value <syntax-val>` of :ref:`value type <syntax-valtype>` :math:`t`.

5. Append :math:`\globalinst` to the |GLOBALS| of :math:`S`.

6. Return :math:`a`.

.. math::
   \begin{array}{rlll}
   \allocglobal(S, \global) &=& S', \globaladdr \\[1ex]
   \mbox{where:} \hfill \\
   \global.\TYPE &=& \mut~t \\
   \globaladdr &=& |S.\GLOBALS| \\
   \globalinst &=& \{ \VALUE~(t.\CONST~0), \MUT~\mut \} \\
   S' &=& S \compose \{\GLOBALS~\globalinst\} \\
   \end{array}

.. _alloc-module:

:ref:`Modules <syntax-moduleinst>`
..................................

The allocation function for :ref:`modules <syntax-module>` requires a suitable list of :ref:`external values <syntax-externval>` that are assumed to match the :ref:`import <syntax-import>` vector of the module.

1. Let :math:`\module` be the :ref:`module <syntax-module>` to allocate and :math:`\externval_{\F{im}}^\ast` the vector of :ref:`external values <syntax-externval>` providing the module's imports.

2. For each :ref:`function <syntax-func>` :math:`\func_i` in :math:`\module.\FUNCS`, do:

   a. Let :math:`\funcaddr_i` be the :ref:`function address <syntax-funcaddr>` resulting from :ref:`allocating <alloc-func>` :math:`\func_i` for the :ref:`\module instance <syntax-moduleinst>` :math:`\moduleinst` defined below.

3. For each :ref:`table <syntax-table>` :math:`\table_i` in :math:`\module.\TABLES`, do:

   a. Let :math:`\tableaddr_i` be the :ref:`table address <syntax-tableaddr>` resulting from :ref:`allocating <alloc-table>` :math:`\table_i`.

4. For each :ref:`memory <syntax-mem>` :math:`\mem_i` in :math:`\module.\MEMS`, do:

   a. Let :math:`\memaddr_i` be the :ref:`memory address <syntax-memaddr>` resulting from :ref:`allocating <alloc-mem>` :math:`\mem_i`.

5. For each :ref:`global <syntax-global>` :math:`\global_i` in :math:`\module.\GLOBALS`, do:

   a. Let :math:`\globaladdr_i` be the :ref:`global address <syntax-globaladdr>` resulting from :ref:`allocating <alloc-global>` :math:`\global_i`.

6. Let :math:`\funcaddr^\ast` be the the concatenation of the :ref:`function addresses <syntax-funcaddr>` :math:`\funcaddr_i` in index order.

7. Let :math:`\tableaddr^\ast` be the the concatenation of the :ref:`table addresses <syntax-tableaddr>` :math:`\tableaddr_i` in index order.

8. Let :math:`\memaddr^\ast` be the the concatenation of the :ref:`memory addresses <syntax-memaddr>` :math:`\memaddr_i` in index order.

9. Let :math:`\globaladdr^\ast` be the the concatenation of the :ref:`global addresses <syntax-globaladdr>` :math:`\globaladdr_i` in index order.

10. Let :math:`\funcaddr_{\F{mod}}^\ast` be the list of :ref:`function addresses <syntax-funcaddr>` extracted from :math:`\externval_{\F{im}}^\ast`, concatenated with :math:`\funcaddr^\ast`.

11. Let :math:`\tableaddr_{\F{mod}}^\ast` be the list of :ref:`table addresses <syntax-tableaddr>` extracted from :math:`\externval_{\F{im}}^\ast`, concatenated with :math:`\tableaddr^\ast`.

12. Let :math:`\memaddr_{\F{mod}}^\ast` be the list of :ref:`memory addresses <syntax-memaddr>` extracted from :math:`\externval_{\F{im}}^\ast`, concatenated with :math:`\memaddr^\ast`.

13. Let :math:`\globaladdr_{\F{mod}}^\ast` be the list of :ref:`global addresses <syntax-globaladdr>` extracted from :math:`\externval_{\F{im}}^\ast`, concatenated with :math:`\globaladdr^\ast`.

14. For each :ref:`export <syntax-export>` :math:`\export_i` in :math:`\module.\EXPORTS`, do:

    a. If :math:`\export_i` is a function export for :ref:`function index <syntax-funcidx>` :math:`x`, then let :math:`\externval_i` be the :ref:`external value <syntax-externval>` :math:`\FUNC~(\funcaddr_{\F{mod}}^\ast[x])`.

    b. Else, if :math:`\export_i` is a table export for :ref:`table index <syntax-tableidx>` :math:`x`, then let :math:`\externval_i` be the :ref:`external value <syntax-externval>` :math:`\TABLE~(\tableaddr_{\F{mod}}^\ast[x])`.

    c. Else, if :math:`\export_i` is a memory export for :ref:`memory index <syntax-memidx>` :math:`x`, then let :math:`\externval_i` be the :ref:`external value <syntax-externval>` :math:`\MEM~(\memaddr_{\F{mod}}^\ast[x])`.

    d. Else, if :math:`\export_i` is a global export for :ref:`global index <syntax-globalidx>` :math:`x`, then let :math:`\externval_i` be the :ref:`external value <syntax-externval>` :math:`\GLOBAL~(\globaladdr_{\F{mod}}^\ast[x])`.

    e. Let :math:`\exportinst_i` be the :ref:`export instance <syntax-exportinst>` :math:`\{\NAME~(\export_i.\NAME), \VALUE~\externval_i\}`.

15. Let :math:`\exportinst^\ast` be the the concatenation of the :ref:`export instances <syntax-exportinst>` :math:`\exportinst_i` in index order.

16. Let :math:`\moduleinst` be the :ref:`module instance <syntax-moduleinst>` :math:`\{\TYPES~(\module.\TYPES),` :math:`\FUNCS~\funcaddr_{\F{mod}}^\ast,` :math:`\TABLES~\tableaddr_{\F{mod}}^\ast,` :math:`\MEMS~\memaddr_{\F{mod}}^\ast,` :math:`\GLOBALS~\globaladdr_{\F{mod}}^\ast,` :math:`\EXPORTS~\exportinst^\ast\}`.

17. Return :math:`\moduleinst`.


.. math::
   \begin{array}{rlll}
   \allocmodule(S, \module, \externval_{\F{im}}^\ast) &=& S', \moduleinst \\[1ex]
   \mbox{where:} \hfill \\
   \end{array}

.. math::
   \begin{array}{rlll}
   \moduleinst &=& \{~
     \begin{array}[t]{@{}l@{}}
     \TYPES~\module.\TYPES, \\
     \FUNCS~\funcs(\externval_{\F{im}}^\ast)~\funcaddr^\ast, \\
     \TABLES~\tables(\externval_{\F{im}}^\ast)~\tableaddr^\ast, \\
     \MEMS~\mems(\externval_{\F{im}}^\ast)~\memaddr^\ast, \\
     \GLOBALS~\globals(\externval_{\F{im}}^\ast)~\globaladdr^\ast, \\
     \EXPORTS~\exportinst^\ast ~\}
     \end{array} \\[1ex]
   S_1, \funcaddr^\ast &=& \allocfunc^\ast(S, \module.\FUNCS, \moduleinst) \\
   S_2, \tableaddr^\ast &=& \alloctable^\ast(S_1, \module.\TABLES) \\
   S_3, \memaddr^\ast &=& \allocmem^\ast(S_2, \module.\MEMS) \\
   S', \globaladdr^\ast &=& \allocglobal^\ast(S_3, \module.\GLOBALS) \\[1ex]
   \exportinst^\ast &=& \{ \NAME~(\export.\NAME), \VALUE~\externval_{\F{ex}} \}^\ast
     & (\export^\ast = \module.\EXPORTS) \\
   \funcs(\externval_{\F{ex}}^\ast) &=& (\moduleinst.\FUNCS[x])^\ast
     & (x^\ast = \funcs(\module.\EXPORTS)) \\
   \tables(\externval_{\F{ex}}^\ast) &=& (\moduleinst.\TABLES[x])^\ast
     & (x^\ast = \tables(\module.\EXPORTS)) \\
   \mems(\externval_{\F{ex}}^\ast) &=& (\moduleinst.\MEMS[x])^\ast
     & (x^\ast = \mems(\module.\EXPORTS)) \\
   \globals(\externval_{\F{ex}}^\ast) &=& (\moduleinst.\GLOBALS[x])^\ast
     & (x^\ast = \globals(\module.\EXPORTS)) \\
   \end{array}

Here, the notation :math:`\F{allocX}^\ast` is shorthand for multiple :ref:`allocations <alloc>` of object kind :math:`X`, defined as follows:

.. math::
   \begin{array}{rlll}
   \F{allocX}^\ast(S_0, X^n, \dots) &=& S_n, a^n \\[1ex]
   \mbox{where for all $i < n$:} \hfill \\
   S_{i+1}, a^n[i] &=& \F{allocX}(S_i, X^n[i], \dots)
   \end{array}

.. note::
   The definition of module allocation is mutually recursive with the allocation of its associated functions, because the resulting module instance :math:`\moduleinst` is passed to the function allocator as an argument, in order to form the necessary closures.
   In an implementation, this recursion is easily unraveled by mutating one or the other in a secondary step.

   The export instances in the formal definition are also formed by reference to the resulting module instance :math:`\moduleinst`.
   However, that is merely a convenient device to succinctly look up the external values by :ref:`index <syntax-index>` relative to their respective :ref:`index space <syntax-index>`.


.. _instantiation:
.. _exec-module:
.. index:: ! instantiation, module, instance, store

Instantiation
~~~~~~~~~~~~~

Given a :ref:`store <syntax-store>` :math:`S`, a :ref:`module <syntax-module>` :math:`\module` is instantiated with a list of :ref:`external values <syntax-externval>` :math:`\externval^n` supplying the required imports as follows.
Instantiation may *fail* with an error.

1. If :math:`\module` is not :ref:`valid <valid-module>`, then:

   a. Fail.

2. Assert: :math:`\module` is :ref:`valid <valid-module>` with :ref:`external types <syntax-externtype>` :math:`\externtype^m` classifying its :ref:`imports <syntax-import>`.

3. If the number :math:`m` of :ref:`imports <syntax-import>` is not equal to the number :math:`n` of provided :ref:`external values <syntax-externval>`, then:

   a. Fail.

4. For each :ref:`external value <syntax-externval>` :math:`\externval_i` in :math:`\externval^n` and :ref:`external type <syntax-externtype>` :math:`\externtype_i` in :math:`\externtype^n`, do:

   a. If :math:`\externval_i` does not :ref:`have type <valid-externval>` :math:`\externtype_i` in store :math:`S`, then:

      i. Fail.

5. Let :math:`\moduleinst` be a new module instance :ref:`allocated <alloc-module>` from :math:`\module` in store :math:`S`.

6. For each :ref:`element segment <syntax-elem>` :math:`\elem_i` in :math:`\module.\ELEM`, do:

   a. Let :math:`\X{eoval}_i` be the result of :ref:`evaluating <exec-expr>` the expression :math:`\elem_i.\OFFSET`.

   b. Assert: due to :ref:`validation <valid-elem>`, :math:`\X{eoval}_i` is of the form :math:`\I32.\CONST~\X{eo}_i`.

   c. Let :math:`\tableidx_i` be the :ref:`table index <syntax-tableidx>` :math:`\elem_i.\TABLE`.

   d. Assert: due to :ref:`validation <valid-elem>`, :math:`\moduleinst.\TABLES[\tableidx_i]` exists.

   e. Let :math:`\tableaddr_i` be the :ref:`table address <syntax-tableaddr>` :math:`\moduleinst.\TABLES[\tableidx_i]`.

   f. Assert: due to :ref:`validation <valid-elem>`, :math:`S.\TABLES[\tableaddr_i]` exists.

   g. Let :math:`\tableinst_i` be the :ref:`table instance <syntax-tableinst>` :math:`S.\TABLES[\tableaddr_i]`.

   h. Let :math:`\X{elen}_i` be :math:`\X{eo}_i` plus the length of :math:`\elem_i.\INIT`.

   i. If :math:`\X{elen}_i` is larger than the length of :math:`\tableinst_i.\ELEM`, then:

      i. Fail.

7. For each :ref:`data segment <syntax-data>` :math:`\data_i` in :math:`\module.\DATA`, do:

   a. Let :math:`\X{doval}_i` be the result of :ref:`evaluating <exec-expr>` the expression :math:`\data_i.\OFFSET`.

   b. Assert: due to :ref:`validation <valid-data>`, :math:`\X{doval}_i` is of the form :math:`\I32.\CONST~\X{do}_i`.

   c. Let :math:`\memidx_i` be the :ref:`memory index <syntax-memidx>` :math:`\data_i.\MEM`.

   d. Assert: due to :ref:`validation <valid-data>`, :math:`\moduleinst.\MEMS[\memidx_i]` exists.

   e. Let :math:`\memaddr_i` be the :ref:`memory address <syntax-memaddr>` :math:`\moduleinst.\MEMS[\memidx_i]`.

   f. Assert: due to :ref:`validation <valid-data>`, :math:`S.\MEMS[\memaddr_i]` exists.

   g. Let :math:`\meminst_i` be the :ref:`memory instance <syntax-meminst>` :math:`S.\MEMS[\memaddr_i]`.

   h. Let :math:`\X{dlen}_i` be :math:`\X{do}_i` plus the length of :math:`\data_i.\INIT`.

   i. If :math:`\X{dlen}_i` is larger than the length of :math:`\meminst_i.\DATA`, then:

      i. Fail.

8. Let :math:`\globalidx_{\F{new}}` be the :ref:`global index <syntax-globalidx>` that corresponds to the number of global :ref:`imports <syntax-import>` in :math:`\module.\IMPORTS` (i.e., the index of the first non-imported global).

9. For each :ref:`global <syntax-global>` :math:`\global_i` in :math:`\module.\GLOBALS`, do:

   a. Let :math:`\val_i` be the result of :ref:`evaluating <exec-expr>` the initializer expression :math:`\global_i.\INIT`.

   b. Let :math:`\globalidx_i` be the :ref:`global index <syntax-globalidx>` :math:`\globalidx_{\F{new}} + i`.

   c. Assert: due to :ref:`validation <valid-global>`, :math:`\moduleinst.\GLOBALS[\globalidx_i]` exists.

   d. Let :math:`\globaladdr_i` be the :ref:`global address <syntax-globaladdr>` :math:`\moduleinst.\GLOBALS[\globalidx_i]`.

   e. Assert: due to :ref:`validation <valid-global>`, :math:`S.\GLOBALS[\globaladdr_i]` exists.

   f. Let :math:`\globalinst_i` be the :ref:`global instance <syntax-globalinst>` :math:`S.\GLOBALS[\globaladdr_i]`.

10. For each :ref:`element segment <syntax-elem>` :math:`\elem_i` in :math:`\module.\ELEM`, do:

    a. For each :ref:`function index <syntax-funcidx>` :math:`\funcidx_{ij}` in :math:`\elem_i.\INIT` (starting with :math:`j = 0`), do:

       i. Assert: due to :ref:`validation <valid-elem>`, :math:`\moduleinst.\FUNCS[\funcidx_{ij}]` exists.

       ii. Let :math:`\funcaddr_{ij}` be the :ref:`function address <func-addr>` :math:`\moduleinst.\FUNCS[\funcidx_{ij}]`.

       iii. Replace :math:`\tableinst_i.\ELEM[\X{eo}_i + j]` with :math:`\funcaddr_{ij}`.

11. For each :ref:`data segment <syntax-data>` :math:`\data_i` in :math:`\module.\DATA`, do:

    a. For each :ref:`byte <syntax-byte>` :math:`b_{ij}` in :math:`\data_i.\INIT` (starting with :math:`j = 0`), do:

       i. Replace :math:`\meminst_i.\DATA[\X{do}_i + j]` with :math:`b_{ij}`.

12. For each :ref:`global <syntax-global>` :math:`\global_i` in :math:`\module.\GLOBALS`, do:

    a. Replace :math:`\globalinst_i.\VALUE` with :math:`\val_i`.

13. If the :ref:`start function <sytnax-start>` :math:`\module.\START` is not empty, then:

    a. Assert: due to :ref:`validation <valid-start>`, :math:`\moduleinst.\FUNCS[\module.\START]` exists.

    b. Let :math:`\funcaddr` be the :ref:`function address <func-addr>` :math:`\moduleinst.\FUNCS[\module.\START]`.

    c. :ref:`Invoke <exec-invoke>` the function instance at :math:`\funcaddr`.

.. math::
   \begin{array}{@{}rcll}
   S; \INSTANTIATE~\module~\externval^n &\stepto& S';
     \begin{array}[t]{@{}l@{}}
     (\INITTABLE~\tableaddr~\X{eo}~\moduleinst~\elem.\INIT)^\ast \\
     (\INITMEM~\memaddr~\X{do}~\data.\INIT)^\ast \\
     (\INITGLOBAL~\globaladdr~v)^\ast \\
     (\INVOKE~\funcaddr)^? \\
     \moduleinst \\
     \end{array} \\
   &\mbox{if}
     & S \vdash \module : \externtype^n \\
     && (\vdash \externval : \externtype)^n \\[1ex]
     && \module.\GLOBALS = \global^k \\
     && \module.\ELEM = \elem^\ast \\
     && \module.\DATA = \data^\ast \\
     && \module.\START = \start^? \\
     && \globalidx^\ast = 0~\dots~(k-1) \\[1ex]
     && S', \moduleinst = \F{allocmodule}(S, \module, \externval^n) \\
     && F = \{ \MODULE~\moduleinst, \LOCALS~\epsilon \} \\[1ex]
     && (S'; F; \elem.\OFFSET \stepto^\ast S'; F; \I32.\CONST~\X{eo})^\ast \\
     && (S'; F; \data.\OFFSET \stepto^\ast S'; F; \I32.\CONST~\X{do})^\ast \\
     && (S'; F; \global.\INIT \stepto^\ast S'; F; v)^\ast \\[1ex]
     && (\tableaddr = \moduleinst.\TABLES[\elem.\TABLE])^\ast \\
     && (\memaddr = \moduleinst.\MEMS[\data.\MEM])^\ast \\
     && (\globaladdr = \moduleinst.\GLOBALS[\globalidx])^\ast \\
     && (\funcaddr = \moduleinst.\FUNCS[\start.\FUNC])^? \\[1ex]
     && (\X{eo} + |\elem.\INIT| \leq |S'.\TABLES[\tableaddr].\ELEM|)^\ast \\
     && (\X{do} + |\data.\INIT| \leq |S'.\MEMS[\memaddr].\DATA|)^\ast \\[1ex]
   S; \INSTANTIATE~\module~\externval^n &\stepto&
     S'; \TRAP  \qquad (\mbox{otherwise}) \\[1ex]
   S; \INITTABLE~a~i~\moduleinst~\epsilon &\stepto&
     S; \epsilon \\
   S; \INITTABLE~a~i~\moduleinst~(x_0~x^\ast) &\stepto&
     S'; \INITTABLE~a~(i+1)~\moduleinst~x^\ast \\ &&
     (S' = S \with \TABLES[a].\ELEM[i] = \moduleinst.\FUNCS[x_0]) \\[1ex]
   S; \INITMEM~a~i~\epsilon &\stepto&
     S; \epsilon \\
   S; \INITMEM~a~i~(b_0~b^\ast) &\stepto&
     S'; \INITMEM~a~(i+1)~b^\ast \\ &&
     (S' = S \with \MEMS[a].\DATA[i] = b_0) \\[1ex]
   S; \INITGLOBAL~a~v &\stepto&
     S'; \epsilon \\ &&
     (S' = S \with \GLOBALS[a] = v) \\
   \end{array}

.. note::
   All failure conditions are checked before any observable mutation of the store takes place.
   Mutation is not atomic but happens in individual steps that may be interleaved with other threads.

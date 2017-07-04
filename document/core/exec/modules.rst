Modules
-------


.. _valid-externval:

External Typing
~~~~~~~~~~~~~~~

For the purpose of checking :ref:`external values <syntax-externval>` against :ref:`imports <syntax-import>`,
such values are classified by :ref:`external types <syntax-externtype>`.
The following auxiliary typing rules specify this typing relation relative to a :ref:`store <syntax-store>` :math:`S` in which the external value lives.

:math:`\EVFUNC~a`
.................

* The store entry :math:`S.\SFUNCS[a]` must be a :ref:`function instance <syntax-funcinst>` :math:`\{\FITYPE~\functype, \dots\}`.

* Then :math:`\EVFUNC~a` is valid with :ref:`external type <syntax-externtype>` :math:`\ETFUNC~\functype`.

.. math::
   \frac{
     S.\SFUNCS[a] = \{\FITYPE~\functype, \dots\}
   }{
     S \vdash \EVFUNC~a : \ETFUNC~\functype
   }


:math:`\EVTABLE~a`
..................

* The store entry :math:`S.\STABLES[a]` must be a :ref:`table instance <syntax-tableinst>` :math:`\{\TIELEM~(\X{fa}^?)^n, \TIMAX~m^?\}`.

* Then :math:`\EVTABLE~a` is valid with :ref:`external type <syntax-externtype>` :math:`\ETTABLE~(\{\LMIN~n, \LMAX~m^?\}~\ANYFUNC)`.

.. math::
   \frac{
     S.\STABLES[a] = \{ \TIELEM~(\X{fa}^?)^n, \TIMAX~m^? \}
   }{
     S \vdash \EVTABLE~a : \ETTABLE~(\{\LMIN~n, \LMAX~m^?\}~\ANYFUNC)
   }


:math:`\EVMEM~a`
................

* The store entry :math:`S.\SMEMS[a]` must be a :ref:`memory instance <syntax-meminst>` :math:`\{\MIDATA~b^{n\cdot64\,\F{Ki}}, \MIMAX~m^?\}`, for some :math:`n`.

* Then :math:`\EVMEM~a` is valid with :ref:`external type <syntax-externtype>` :math:`\ETMEM~(\{\LMIN~n, \LMAX~m^?\})`.

.. math::
   \frac{
     S.\SMEMS[a] = \{ \MIDATA~b^{n\cdot64\,\F{Ki}}, \MIMAX~m^? \}
   }{
     S \vdash \EVMEM~a : \ETMEM~\{\LMIN~n, \LMAX~m^?\}
   }


:math:`\EVGLOBAL~a`
...................

* The store entry :math:`S.\SGLOBALS[a]` must be a :ref:`global instance <syntax-globalinst>` :math:`\{\GIVALUE~(t.\CONST~c), \GIMUT~\mut\}`.

* Then :math:`\EVGLOBAL~a` is valid with :ref:`external type <syntax-externtype>` :math:`\ETGLOBAL~(\mut~t)`.

.. math::
   \frac{
     S.\SGLOBALS[a] = \{ \GIVALUE~(t.\CONST~c), \GIMUT~\mut \}
   }{
     S \vdash \EVGLOBAL~a : \ETGLOBAL~(\mut~t)
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

:ref:`Limits <syntax-limits>` :math:`\{ \LMIN~n_1, \LMAX~m_1^? \}` match limits :math:`\{ \LMIN~n_2, \LMAX~m_2^? \}` if and only if:

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
     \vdash \{ \LMIN~n_1, \LMAX~m_1^? \} \leq \{ \LMIN~n_2, \LMAX~\epsilon \}
   }
   \quad
   \frac{
     n_1 \geq n_2
     \qquad
     m_1 \leq m_2
   }{
     \vdash \{ \LMIN~n_1, \LMAX~m_1 \} \leq \{ \LMIN~n_2, \LMAX~m_2 \}
   }


Functions
.........

An :ref:`external type <syntax-externtype>` :math:`\ETFUNC~\functype_1` matches :math:`\ETFUNC~\functype_2` if and only if:

* Both :math:`\functype_1` and :math:`\functype_2` are the same.

.. math::
   \frac{
   }{
     \vdash \ETFUNC~\functype \leq \ETFUNC~\functype
   }


Tables
......

An :ref:`external type <syntax-externtype>` :math:`\ETTABLE~(\limits_1~\elemtype_1)` matches :math:`\ETTABLE~(\limits_2~\elemtype_2)` if and only if:

* Limits :math:`\limits_1` :ref:`match <match-limits>` :math:`\limits_2`.

* Both :math:`\elemtype_1` and :math:`\elemtype_2` are the same.

.. math::
   \frac{
     \vdash \limits_1 \leq \limits_2
   }{
     \vdash \ETTABLE~(\limits_1~\elemtype) \leq \ETTABLE~(\limits_2~\elemtype)
   }


Memories
........

An :ref:`external type <syntax-externtype>` :math:`\ETMEM~\limits_1` matches :math:`\ETMEM~\limits_2` if and only if:

* Limits :math:`\limits_1` :ref:`match <match-limits>` :math:`\limits_2`.

.. math::
   \frac{
     \vdash \limits_1 \leq \limits_2
   }{
     \vdash \ETMEM~\limits_1 \leq \ETMEM~\limits_2
   }


Globals
.......

An :ref:`external type <syntax-externtype>` :math:`\ETGLOBAL~\globaltype_1` matches :math:`\ETGLOBAL~\globaltype_2` if and only if:

* Both :math:`\globaltype_1` and :math:`\globaltype_2` are the same.

.. math::
   \frac{
   }{
     \vdash \ETGLOBAL~\globaltype \leq \ETGLOBAL~\globaltype
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

3. Let :math:`\functype` be the :ref:`function type <syntax-functype>` :math:`\moduleinst.\MITYPES[\func.\FTYPE]`.

4. Let :math:`\funcinst` be the :ref:`function instance <syntax-funcinst>` :math:`\{ \FITYPE~\functype, \FIMODULE~\moduleinst, \FICODE~\func \}`.

5. Append :math:`\funcinst` to the |SFUNCS| of :math:`S`.

6. Return :math:`a`.

.. math::
   \begin{array}{rlll}
   \allocfunc(S, \func, \moduleinst) &=& S', \funcaddr \\[1ex]
   \mbox{where:} \hfill \\
   \funcaddr &=& |S.\SFUNCS| \\
   \functype &=& \moduleinst.\MITYPES[\func.\FTYPE] \\
   \funcinst &=& \{ \FITYPE~\functype, \FIMODULE~\moduleinst, \FICODE~\func \} \\
   S' &=& S \compose \{\SFUNCS~\funcinst\} \\
   \end{array}

.. _alloc-hostfunc:

:ref:`Host Functions <syntax-hostfunc>`
.......................................

1. Let :math:`\hostfunc` be the :ref:`host function <syntax-hostfunc>` to allocate and :math:`\functype` its :ref:`function type <syntax-functype>`.

2. Let :math:`a` be the first free :ref:`function address <syntax-funcaddr>` in :math:`S`.

4. Let :math:`\funcinst` be the :ref:`function instance <syntax-funcinst>` :math:`\{ \FITYPE~\functype, \FICODE~\hostfunc \}`.

5. Append :math:`\funcinst` to the |SFUNCS| of :math:`S`.

6. Return :math:`a`.

.. math::
   \begin{array}{rlll}
   \allochostfunc(S, \hostfunc, \functype) &=& S', \funcaddr \\[1ex]
   \mbox{where:} \hfill \\
   \funcaddr &=& |S.\SFUNCS| \\
   \funcinst &=& \{ \FITYPE~\functype, \FICODE~\hostfunc \} \\
   S' &=& S \compose \{\SFUNCS~\tableinst\} \\
   \end{array}

.. note::
   Host functions are never allocated by the WebAssembly semantics itself,
   but may be allocated by the embedder.


.. _alloc-table:

:ref:`Tables <syntax-tableinst>`
................................

1. Let :math:`\table` be the :ref:`table <syntax-table>` to allocate.

2. Let :math:`(\{\LMIN~n, \LMAX~m^?\}~\elemtype)` be the :ref:`table type <syntax-tabletype>` :math:`\table.\TTYPE`.

3. Let :math:`a` be the first free :ref:`table address <syntax-tableaddr>` in :math:`S`.

4. Let :math:`\tableinst` be the :ref:`table instance <syntax-tableinst>` :math:`\{ \TIELEM~(\epsilon)^n, \TIMAX~m^? \}` with :math:`n` empty elements.

5. Append :math:`\tableinst` to the |STABLES| of :math:`S`.

6. Return :math:`a`.

.. math::
   \begin{array}{rlll}
   \alloctable(S, \table) &=& S', \tableaddr \\[1ex]
   \mbox{where:} \hfill \\
   \table.\TTYPE &=& \{\LMIN~n, \LMAX~m^?\}~\elemtype \\
   \tableaddr &=& |S.\STABLES| \\
   \tableinst &=& \{ \TIELEM~(\epsilon)^n, \TIMAX~m^? \} \\
   S' &=& S \compose \{\STABLES~\tableinst\} \\
   \end{array}

.. _alloc-mem:

:ref:`Memories <syntax-meminst>`
................................

1. Let :math:`\mem` be the :ref:`memory <syntax-mem>` to allocate.

2. Let :math:`\{\LMIN~n, \LMAX~m^?\}` be the :ref:`table type <syntax-memtype>` :math:`\mem.\MTYPE`.

3. Let :math:`a` be the first free :ref:`memory address <syntax-memaddr>` in :math:`S`.

4. Let :math:`\meminst` be the :ref:`memory instance <syntax-meminst>` :math:`\{ \MIDATA~(\hex{00})^{n \cdot 64\,\F{Ki}}, \MIMAX~m^? \}` that contains :math:`n` pages of zeroed bytes.

5. Append :math:`\meminst` to the |SMEMS| of :math:`S`.

6. Return :math:`a`.

.. math::
   \begin{array}{rlll}
   \allocmem(S, \mem) &=& S', \memaddr \\[1ex]
   \mbox{where:} \hfill \\
   \mem.\MTYPE &=& \{\LMIN~n, \LMAX~m^?\} \\
   \memaddr &=& |S.\SMEMS| \\
   \meminst &=& \{ \MIDATA~(\hex{00})^{n \cdot 64\,\F{Ki}}, \MIMAX~m^? \} \\
   S' &=& S \compose \{\SMEMS~\meminst\} \\
   \end{array}

.. _alloc-global:

:ref:`Globals <syntax-globalinst>`
..................................

1. Let :math:`\global` be the :ref:`global <syntax-global>` to allocate.

2. Let :math:`\mut~t` be the :ref:`global type <syntax-globaltype>` :math:`\global.\GTYPE`.

3. Let :math:`a` be the first free :ref:`global address <syntax-globaladdr>` in :math:`S`.

4. Let :math:`\globalinst` be the :ref:`global instance <syntax-globalinst>` :math:`\{ \GIVALUE~(t.\CONST~0), \GIMUT~\mut \}` whose contents is a zero :ref:`value <syntax-val>` of :ref:`value type <syntax-valtype>` :math:`t`.

5. Append :math:`\globalinst` to the |SGLOBALS| of :math:`S`.

6. Return :math:`a`.

.. math::
   \begin{array}{rlll}
   \allocglobal(S, \global) &=& S', \globaladdr \\[1ex]
   \mbox{where:} \hfill \\
   \global.\GTYPE &=& \mut~t \\
   \globaladdr &=& |S.\SGLOBALS| \\
   \globalinst &=& \{ \GIVALUE~(t.\CONST~0), \GIMUT~\mut \} \\
   S' &=& S \compose \{\SGLOBALS~\globalinst\} \\
   \end{array}

.. _alloc-module:

:ref:`Modules <syntax-moduleinst>`
..................................

The allocation function for :ref:`modules <syntax-module>` requires a suitable list of :ref:`external values <syntax-externval>` that are assumed to :ref:`match <match-externtype>` the :ref:`import <syntax-import>` vector of the module.

1. Let :math:`\module` be the :ref:`module <syntax-module>` to allocate and :math:`\externval_{\F{im}}^\ast` the vector of :ref:`external values <syntax-externval>` providing the module's imports.

2. For each :ref:`function <syntax-func>` :math:`\func_i` in :math:`\module.\MFUNCS`, do:

   a. Let :math:`\funcaddr_i` be the :ref:`function address <syntax-funcaddr>` resulting from :ref:`allocating <alloc-func>` :math:`\func_i` for the :ref:`\module instance <syntax-moduleinst>` :math:`\moduleinst` defined below.

3. For each :ref:`table <syntax-table>` :math:`\table_i` in :math:`\module.\MTABLES`, do:

   a. Let :math:`\tableaddr_i` be the :ref:`table address <syntax-tableaddr>` resulting from :ref:`allocating <alloc-table>` :math:`\table_i`.

4. For each :ref:`memory <syntax-mem>` :math:`\mem_i` in :math:`\module.\MMEMS`, do:

   a. Let :math:`\memaddr_i` be the :ref:`memory address <syntax-memaddr>` resulting from :ref:`allocating <alloc-mem>` :math:`\mem_i`.

5. For each :ref:`global <syntax-global>` :math:`\global_i` in :math:`\module.\MGLOBALS`, do:

   a. Let :math:`\globaladdr_i` be the :ref:`global address <syntax-globaladdr>` resulting from :ref:`allocating <alloc-global>` :math:`\global_i`.

6. Let :math:`\funcaddr^\ast` be the the concatenation of the :ref:`function addresses <syntax-funcaddr>` :math:`\funcaddr_i` in index order.

7. Let :math:`\tableaddr^\ast` be the the concatenation of the :ref:`table addresses <syntax-tableaddr>` :math:`\tableaddr_i` in index order.

8. Let :math:`\memaddr^\ast` be the the concatenation of the :ref:`memory addresses <syntax-memaddr>` :math:`\memaddr_i` in index order.

9. Let :math:`\globaladdr^\ast` be the the concatenation of the :ref:`global addresses <syntax-globaladdr>` :math:`\globaladdr_i` in index order.

10. Let :math:`\funcaddr_{\F{mod}}^\ast` be the list of :ref:`function addresses <syntax-funcaddr>` extracted from :math:`\externval_{\F{im}}^\ast`, concatenated with :math:`\funcaddr^\ast`.

11. Let :math:`\tableaddr_{\F{mod}}^\ast` be the list of :ref:`table addresses <syntax-tableaddr>` extracted from :math:`\externval_{\F{im}}^\ast`, concatenated with :math:`\tableaddr^\ast`.

12. Let :math:`\memaddr_{\F{mod}}^\ast` be the list of :ref:`memory addresses <syntax-memaddr>` extracted from :math:`\externval_{\F{im}}^\ast`, concatenated with :math:`\memaddr^\ast`.

13. Let :math:`\globaladdr_{\F{mod}}^\ast` be the list of :ref:`global addresses <syntax-globaladdr>` extracted from :math:`\externval_{\F{im}}^\ast`, concatenated with :math:`\globaladdr^\ast`.

14. For each :ref:`export <syntax-export>` :math:`\export_i` in :math:`\module.\MEXPORTS`, do:

    a. If :math:`\export_i` is a function export for :ref:`function index <syntax-funcidx>` :math:`x`, then let :math:`\externval_i` be the :ref:`external value <syntax-externval>` :math:`\EVFUNC~(\funcaddr_{\F{mod}}^\ast[x])`.

    b. Else, if :math:`\export_i` is a table export for :ref:`table index <syntax-tableidx>` :math:`x`, then let :math:`\externval_i` be the :ref:`external value <syntax-externval>` :math:`\EVTABLE~(\tableaddr_{\F{mod}}^\ast[x])`.

    c. Else, if :math:`\export_i` is a memory export for :ref:`memory index <syntax-memidx>` :math:`x`, then let :math:`\externval_i` be the :ref:`external value <syntax-externval>` :math:`\EVMEM~(\memaddr_{\F{mod}}^\ast[x])`.

    d. Else, if :math:`\export_i` is a global export for :ref:`global index <syntax-globalidx>` :math:`x`, then let :math:`\externval_i` be the :ref:`external value <syntax-externval>` :math:`\EVGLOBAL~(\globaladdr_{\F{mod}}^\ast[x])`.

    e. Let :math:`\exportinst_i` be the :ref:`export instance <syntax-exportinst>` :math:`\{\EINAME~(\export_i.\ENAME), \EIVALUE~\externval_i\}`.

15. Let :math:`\exportinst^\ast` be the the concatenation of the :ref:`export instances <syntax-exportinst>` :math:`\exportinst_i` in index order.

16. Let :math:`\moduleinst` be the :ref:`module instance <syntax-moduleinst>` :math:`\{\MITYPES~(\module.\MTYPES),` :math:`\MIFUNCS~\funcaddr_{\F{mod}}^\ast,` :math:`\MITABLES~\tableaddr_{\F{mod}}^\ast,` :math:`\MIMEMS~\memaddr_{\F{mod}}^\ast,` :math:`\MIGLOBALS~\globaladdr_{\F{mod}}^\ast,` :math:`\MIEXPORTS~\exportinst^\ast\}`.

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
     \MITYPES~\module.\MTYPES, \\
     \MIFUNCS~\evfuncs(\externval_{\F{im}}^\ast)~\funcaddr^\ast, \\
     \MITABLES~\evtables(\externval_{\F{im}}^\ast)~\tableaddr^\ast, \\
     \MIMEMS~\evmems(\externval_{\F{im}}^\ast)~\memaddr^\ast, \\
     \MIGLOBALS~\evglobals(\externval_{\F{im}}^\ast)~\globaladdr^\ast, \\
     \MIEXPORTS~\exportinst^\ast ~\}
     \end{array} \\[1ex]
   S_1, \funcaddr^\ast &=& \allocfunc^\ast(S, \module.\MFUNCS, \moduleinst) \\
   S_2, \tableaddr^\ast &=& \alloctable^\ast(S_1, \module.\MTABLES) \\
   S_3, \memaddr^\ast &=& \allocmem^\ast(S_2, \module.\MMEMS) \\
   S', \globaladdr^\ast &=& \allocglobal^\ast(S_3, \module.\MGLOBALS) \\[1ex]
   \exportinst^\ast &=& \{ \EINAME~(\export.\ENAME), \EIVALUE~\externval_{\F{ex}} \}^\ast
     & (\export^\ast = \module.\MEXPORTS) \\
   \evfuncs(\externval_{\F{ex}}^\ast) &=& (\moduleinst.\MIFUNCS[x])^\ast
     & (x^\ast = \edfuncs(\module.\MEXPORTS)) \\
   \evtables(\externval_{\F{ex}}^\ast) &=& (\moduleinst.\MITABLES[x])^\ast
     & (x^\ast = \edtables(\module.\MEXPORTS)) \\
   \evmems(\externval_{\F{ex}}^\ast) &=& (\moduleinst.\MIMEMS[x])^\ast
     & (x^\ast = \edmems(\module.\MEXPORTS)) \\
   \evglobals(\externval_{\F{ex}}^\ast) &=& (\moduleinst.\MIGLOBALS[x])^\ast
     & (x^\ast = \edglobals(\module.\MEXPORTS)) \\
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


.. index:: ! instantiation, module, instance, store
.. _exec-module:
.. _exec-instantiation:

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

   a. Assert: :math:`\externval_i` is :ref:`valid <valid-externval>` with :ref:`external type <syntax-externtype>` :math:`\externtype'_i` in store :math:`S`.

   b. If :math:`\externtype'_i` does not :ref:`match <match-externtype>` :math:`\externtype_i`, then:

      i. Fail.

5. Let :math:`\moduleinst` be a new module instance :ref:`allocated <alloc-module>` from :math:`\module` in store :math:`S`.

6. Let :math:`F` be the :ref:`frame <syntax-frame>` :math:`\{ \AMODULE~\moduleinst, \ALOCALS~\epsilon \}`.

7. Push the frame :math:`F` to the stack.

8. For each :ref:`element segment <syntax-elem>` :math:`\elem_i` in :math:`\module.\MELEM`, do:

   a. Let :math:`\X{eoval}_i` be the result of :ref:`evaluating <exec-expr>` the expression :math:`\elem_i.\EOFFSET`.

   b. Assert: due to :ref:`validation <valid-elem>`, :math:`\X{eoval}_i` is of the form :math:`\I32.\CONST~\X{eo}_i`.

   c. Let :math:`\tableidx_i` be the :ref:`table index <syntax-tableidx>` :math:`\elem_i.\ETABLE`.

   d. Assert: due to :ref:`validation <valid-elem>`, :math:`\moduleinst.\MITABLES[\tableidx_i]` exists.

   e. Let :math:`\tableaddr_i` be the :ref:`table address <syntax-tableaddr>` :math:`\moduleinst.\MITABLES[\tableidx_i]`.

   f. Assert: due to :ref:`validation <valid-elem>`, :math:`S.\STABLES[\tableaddr_i]` exists.

   g. Let :math:`\tableinst_i` be the :ref:`table instance <syntax-tableinst>` :math:`S.\STABLES[\tableaddr_i]`.

   h. Let :math:`\X{eend}_i` be :math:`\X{eo}_i` plus the length of :math:`\elem_i.\EINIT`.

   i. If :math:`\X{eend}_i` is larger than the length of :math:`\tableinst_i.\TIELEM`, then:

      i. Fail.

9. For each :ref:`data segment <syntax-data>` :math:`\data_i` in :math:`\module.\MDATA`, do:

   a. Let :math:`\X{doval}_i` be the result of :ref:`evaluating <exec-expr>` the expression :math:`\data_i.\DOFFSET`.

   b. Assert: due to :ref:`validation <valid-data>`, :math:`\X{doval}_i` is of the form :math:`\I32.\CONST~\X{do}_i`.

   c. Let :math:`\memidx_i` be the :ref:`memory index <syntax-memidx>` :math:`\data_i.\DMEM`.

   d. Assert: due to :ref:`validation <valid-data>`, :math:`\moduleinst.\MIMEMS[\memidx_i]` exists.

   e. Let :math:`\memaddr_i` be the :ref:`memory address <syntax-memaddr>` :math:`\moduleinst.\MIMEMS[\memidx_i]`.

   f. Assert: due to :ref:`validation <valid-data>`, :math:`S.\SMEMS[\memaddr_i]` exists.

   g. Let :math:`\meminst_i` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[\memaddr_i]`.

   h. Let :math:`\X{dend}_i` be :math:`\X{do}_i` plus the length of :math:`\data_i.\DINIT`.

   i. If :math:`\X{dend}_i` is larger than the length of :math:`\meminst_i.\MIDATA`, then:

      i. Fail.

10. Let :math:`\globalidx_{\F{new}}` be the :ref:`global index <syntax-globalidx>` that corresponds to the number of global :ref:`imports <syntax-import>` in :math:`\module.\MIMPORTS` (i.e., the index of the first non-imported global).

11. For each :ref:`global <syntax-global>` :math:`\global_i` in :math:`\module.\MGLOBALS`, do:

    a. Let :math:`\val_i` be the result of :ref:`evaluating <exec-expr>` the initializer expression :math:`\global_i.\GINIT`.

    b. Let :math:`\globalidx_i` be the :ref:`global index <syntax-globalidx>` :math:`\globalidx_{\F{new}} + i`.

    c. Assert: due to :ref:`validation <valid-global>`, :math:`\moduleinst.\MIGLOBALS[\globalidx_i]` exists.

    d. Let :math:`\globaladdr_i` be the :ref:`global address <syntax-globaladdr>` :math:`\moduleinst.\MIGLOBALS[\globalidx_i]`.

    e. Assert: due to :ref:`validation <valid-global>`, :math:`S.\SGLOBALS[\globaladdr_i]` exists.

    f. Let :math:`\globalinst_i` be the :ref:`global instance <syntax-globalinst>` :math:`S.\SGLOBALS[\globaladdr_i]`.

12. Assert: due to :ref:`validation <valid-module>`, the frame :math:`F` is now on the top of the stack.

13. Pop the frame from the stack.

14. For each :ref:`element segment <syntax-elem>` :math:`\elem_i` in :math:`\module.\MELEM`, do:

    a. For each :ref:`function index <syntax-funcidx>` :math:`\funcidx_{ij}` in :math:`\elem_i.\EINIT` (starting with :math:`j = 0`), do:

       i. Assert: due to :ref:`validation <valid-elem>`, :math:`\moduleinst.\MIFUNCS[\funcidx_{ij}]` exists.

       ii. Let :math:`\funcaddr_{ij}` be the :ref:`function address <syntax-funcaddr>` :math:`\moduleinst.\MIFUNCS[\funcidx_{ij}]`.

       iii. Replace :math:`\tableinst_i.\TIELEM[\X{eo}_i + j]` with :math:`\funcaddr_{ij}`.

15. For each :ref:`data segment <syntax-data>` :math:`\data_i` in :math:`\module.\MDATA`, do:

    a. For each :ref:`byte <syntax-byte>` :math:`b_{ij}` in :math:`\data_i.\DINIT` (starting with :math:`j = 0`), do:

       i. Replace :math:`\meminst_i.\MIDATA[\X{do}_i + j]` with :math:`b_{ij}`.

16. For each :ref:`global <syntax-global>` :math:`\global_i` in :math:`\module.\MGLOBALS`, do:

    a. Replace :math:`\globalinst_i.\GIVALUE` with :math:`\val_i`.

17. If the :ref:`start function <syntax-start>` :math:`\module.\MSTART` is not empty, then:

    a. Assert: due to :ref:`validation <valid-start>`, :math:`\moduleinst.\MIFUNCS[\module.\MSTART.\SFUNC]` exists.

    b. Let :math:`\funcaddr` be the :ref:`function address <syntax-funcaddr>` :math:`\moduleinst.\MIFUNCS[\module.\MSTART.\SFUNC]`.

    c. :ref:`Invoke <exec-invoke>` the function instance at :math:`\funcaddr`.

.. math::
   \begin{array}{@{}rcll}
   S; \INSTANTIATE~\module~\externval^n &\stepto& S';
     \begin{array}[t]{@{}l@{}}
     (\INITTABLE~\tableaddr~\X{eo}~\moduleinst~\elem.\EINIT)^\ast \\
     (\INITMEM~\memaddr~\X{do}~\data.\DINIT)^\ast \\
     (\INITGLOBAL~\globaladdr~v)^\ast \\
     (\INVOKE~\funcaddr)^? \\
     \moduleinst \\
     \end{array} \\
   &\mbox{if}
     & \vdash \module : \externtype^n \\
     &\wedge& (\vdash \externval : \externtype')^n \\
     &\wedge& (\vdash \externtype' \leq \externtype)^n \\[1ex]
     &\wedge& \module.\MGLOBALS = \global^k \\
     &\wedge& \module.\MELEM = \elem^\ast \\
     &\wedge& \module.\MDATA = \data^\ast \\
     &\wedge& \module.\MSTART = \start^? \\[1ex]
     &\wedge& S', \moduleinst = \F{allocmodule}(S, \module, \externval^n) \\
     &\wedge& F = \{ \AMODULE~\moduleinst, \ALOCALS~\epsilon \} \\[1ex]
     &\wedge& (S'; F; \elem.\EOFFSET \stepto^\ast S'; F; \I32.\CONST~\X{eo})^\ast \\
     &\wedge& (S'; F; \data.\DOFFSET \stepto^\ast S'; F; \I32.\CONST~\X{do})^\ast \\
     &\wedge& (S'; F; \global.\GINIT \stepto^\ast S'; F; v)^\ast \\[1ex]
     &\wedge& (\tableaddr = \moduleinst.\MITABLES[\elem.\ETABLE])^\ast \\
     &\wedge& (\memaddr = \moduleinst.\MIMEMS[\data.\DMEM])^\ast \\
     &\wedge& \globaladdr^\ast = \moduleinst.\MIGLOBALS[|\moduleinst.\MIGLOBALS|-k:k] \\
     &\wedge& (\funcaddr = \moduleinst.\MIFUNCS[\start.\SFUNC])^? \\[1ex]
     &\wedge& (\X{eo} + |\elem.\EINIT| \leq |S'.\STABLES[\tableaddr].\TIELEM|)^\ast \\
     &\wedge& (\X{do} + |\data.\DINIT| \leq |S'.\SMEMS[\memaddr].\MIDATA|)^\ast \\[1ex]
   S; \INSTANTIATE~\module~\externval^n &\stepto&
     S'; \TRAP  \qquad (\otherwise) \\[1ex]
   S; \INITTABLE~a~i~m~\epsilon &\stepto&
     S; \epsilon \\
   S; \INITTABLE~a~i~m~(x_0~x^\ast) &\stepto&
     S'; \INITTABLE~a~(i+1)~m~x^\ast \\ &&
     (\iff S' = S \with \STABLES[a].\TIELEM[i] = m.\MIFUNCS[x_0]) \\[1ex]
   S; \INITMEM~a~i~\epsilon &\stepto&
     S; \epsilon \\
   S; \INITMEM~a~i~(b_0~b^\ast) &\stepto&
     S'; \INITMEM~a~(i+1)~b^\ast \\ &&
     (\iff S' = S \with \SMEMS[a].\MIDATA[i] = b_0) \\[1ex]
   S; \INITGLOBAL~a~v &\stepto&
     S'; \epsilon \\ &&
     (\iff S' = S \with \SGLOBALS[a] = v) \\
   \end{array}

.. note::
   All failure conditions are checked before any observable mutation of the store takes place.
   Store mutation is not atomic;
   it happens in individual steps that may be interleaved with other threads.


.. index:: ! invocation, module, instance, function, export, function address
.. _exec-invocation:

Invocation
~~~~~~~~~~

Once a :ref:`module <syntax-module>` has been :ref:`instantiated <exec-instantiation>`, any exported function can be *invoked* externally via its :ref:`function address <syntax-funcaddr>` :math:`\funcaddr` in the :ref:`store <syntax-store>` :math:`S` and an appropriate list :math:`\val^\ast` of argument :ref:`values <syntax-val>`.
If successful, the invocation returns the function's result values :math:`\val_{\F{res}}^\ast`.

The following steps are performed:

1. Assert: :math:`S.\SFUNCS[\funcaddr]` exists.

2. Let :math:`\funcinst` be the :ref:`function instance <syntax-funcinst>` :math:`S.\SFUNCS[\funcaddr]`.

3. Let :math:`[t_1^n] \to [t_2^m]` be the :ref:`function type <syntax-functype>` :math:`\funcinst.\FITYPE`.

4. If the length :math:`|\val^\ast|` of the provided argument values is different from the number :math:`n` of expected arguments, then:

   a. Fail.

5. For each :ref:`value type <syntax-valtype>` :math:`t_i` in :math:`t_1^n` and corresponding :ref:`value <syntax-val>` :math:`val_i` in :math:`\val^\ast`, do:

   a. If :math:`\val_i` is not :math:`t_i.\CONST~c_i` for some :math:`c_i`, then:

      i. Fail.

6. Push the values :math:`\val^\ast` to the stack.

7. :ref:`Invoke <exec-invoke>` the function instance at address :math:`\funcaddr`.

.. note::
   If the embedder performs type checks itself, either statically or dynamically, no failure can occur.

Once the function has returned, the following steps are executed:

1. Assert: due to :ref:`validation <valid-func>`, :math:`m` :ref:`values <syntax-val>` are on the top of the stack.

2. Pop :math:`\val_{\F{res}}^m` from the stack.

The values :math:`\val_{\F{res}}^m` are the results of the call.

If the function terminates with a :ref:`trap <trap>`, the error is propagated to the caller in a manner specified by the :ref:`embedder <embedder>`.

.. math::
   \begin{array}{@{}lcl}
   \F{invoke}(S, \funcaddr, \val^n) &=& \val_{\F{res}}^m / \TRAP \\
     &\mbox{if}& S.\SFUNCS[\funcaddr].\FITYPE = [t_1^n] \to [t_2^m] \\
     &\wedge& \val^n = (t_1.\CONST~c)^n \\
     &\wedge& S; \val^n~(\INVOKE~\funcaddr) \stepto^\ast S'; \val_{\F{res}}^m / \TRAP \\
   \end{array}

Modules
-------

For modules, the execution semantics primarily defines :ref:`instantiation <exec-instantiation>`, which :ref:`allocates <alloc>` instances for a module and its contained definitions, inititializes :ref:`tables <syntax-table>` and :ref:`memories <syntax-mem>` from contained :ref:`element <syntax-elem>` and :ref:`data <syntax-data>` segments, and invokes the :ref:`start function <syntax-start>` if present. It also includes :ref:`invocation <exec-invocation>` of exported functions.

Instantiation depends on a number of auxiliary notions for :ref:`type-checking imports <exec-import>` and :ref:`allocating <alloc>` instances.


.. index:: external value, external type, validation, import, store
.. _valid-externval:

External Typing
~~~~~~~~~~~~~~~

For the purpose of checking :ref:`external values <syntax-externval>` against :ref:`imports <syntax-import>`,
such values are classified by :ref:`external types <syntax-externtype>`.
The following auxiliary typing rules specify this typing relation relative to a :ref:`store <syntax-store>` :math:`S` in which the referenced instances live.


.. index:: function type, function address
.. _valid-externval-func:

:math:`\EVFUNC~a`
.................

* The store entry :math:`S.\SFUNCS[a]` must be a :ref:`function instance <syntax-funcinst>` :math:`\{\FITYPE~\functype, \dots\}`.

* Then :math:`\EVFUNC~a` is valid with :ref:`external type <syntax-externtype>` :math:`\ETFUNC~\functype`.

.. math::
   \frac{
     S.\SFUNCS[a] = \{\FITYPE~\functype, \dots\}
   }{
     S \vdashexternval \EVFUNC~a : \ETFUNC~\functype
   }


.. index:: table type, table address, limits
.. _valid-externval-table:

:math:`\EVTABLE~a`
..................

* The store entry :math:`S.\STABLES[a]` must be a :ref:`table instance <syntax-tableinst>` :math:`\{\TIELEM~(\X{fa}^?)^n, \TIMAX~m^?\}`.

* Then :math:`\EVTABLE~a` is valid with :ref:`external type <syntax-externtype>` :math:`\ETTABLE~(\{\LMIN~n, \LMAX~m^?\}~\ANYFUNC)`.

.. math::
   \frac{
     S.\STABLES[a] = \{ \TIELEM~(\X{fa}^?)^n, \TIMAX~m^? \}
   }{
     S \vdashexternval \EVTABLE~a : \ETTABLE~(\{\LMIN~n, \LMAX~m^?\}~\ANYFUNC)
   }


.. index:: memory type, memory address, limits
.. _valid-externval-mem:

:math:`\EVMEM~a`
................

* The store entry :math:`S.\SMEMS[a]` must be a :ref:`memory instance <syntax-meminst>` :math:`\{\MIDATA~b^{n\cdot64\,\F{Ki}}, \MIMAX~m^?\}`, for some :math:`n`.

* Then :math:`\EVMEM~a` is valid with :ref:`external type <syntax-externtype>` :math:`\ETMEM~(\{\LMIN~n, \LMAX~m^?\})`.

.. math::
   \frac{
     S.\SMEMS[a] = \{ \MIDATA~b^{n\cdot64\,\F{Ki}}, \MIMAX~m^? \}
   }{
     S \vdashexternval \EVMEM~a : \ETMEM~\{\LMIN~n, \LMAX~m^?\}
   }


.. index:: global type, global address, value type, mutability
.. _valid-externval-global:

:math:`\EVGLOBAL~a`
...................

* The store entry :math:`S.\SGLOBALS[a]` must be a :ref:`global instance <syntax-globalinst>` :math:`\{\GIVALUE~(t.\CONST~c), \GIMUT~\mut\}`.

* Then :math:`\EVGLOBAL~a` is valid with :ref:`external type <syntax-externtype>` :math:`\ETGLOBAL~(\mut~t)`.

.. math::
   \frac{
     S.\SGLOBALS[a] = \{ \GIVALUE~(t.\CONST~c), \GIMUT~\mut \}
   }{
     S \vdashexternval \EVGLOBAL~a : \ETGLOBAL~(\mut~t)
   }


.. index:: ! matching, external type
.. _exec-import:
.. _match:

Import Matching
~~~~~~~~~~~~~~~

When :ref:`instantiating <exec-module>` a module,
:ref:`external values <syntax-externval>` must be provided whose :ref:`types <valid-externval>` are *matched* against the respective :ref:`external types <syntax-externtype>` classifying each import.
In some cases, this allows for a simple form of subtyping, as defined below.


.. index:: limits
.. _match-limits:

Limits
......

:ref:`Limits <syntax-limits>` :math:`\{ \LMIN~n_1, \LMAX~m_1^? \}` match limits :math:`\{ \LMIN~n_2, \LMAX~m_2^? \}` if and only if:

* :math:`n_1` is larger than or equal to :math:`n_2`.

* Either:

  * :math:`m_2^?` is empty.

* Or:

  * Both :math:`m_1^?` and :math:`m_2^?` are non-empty.

  * :math:`m_1` is smaller than or equal to :math:`m_2`.

.. math::
   ~\\[-1ex]
   \frac{
     n_1 \geq n_2
   }{
     \vdashlimitsmatch \{ \LMIN~n_1, \LMAX~m_1^? \} \matches \{ \LMIN~n_2, \LMAX~\epsilon \}
   }
   \quad
   \frac{
     n_1 \geq n_2
     \qquad
     m_1 \leq m_2
   }{
     \vdashlimitsmatch \{ \LMIN~n_1, \LMAX~m_1 \} \matches \{ \LMIN~n_2, \LMAX~m_2 \}
   }


.. _match-externtype:

.. index:: function type
.. _match-functype:

Functions
.........

An :ref:`external type <syntax-externtype>` :math:`\ETFUNC~\functype_1` matches :math:`\ETFUNC~\functype_2` if and only if:

* Both :math:`\functype_1` and :math:`\functype_2` are the same.

.. math::
   ~\\[-1ex]
   \frac{
   }{
     \vdashexterntypematch \ETFUNC~\functype \matches \ETFUNC~\functype
   }


.. index:: table type, limits, element type
.. _match-tabletype:

Tables
......

An :ref:`external type <syntax-externtype>` :math:`\ETTABLE~(\limits_1~\elemtype_1)` matches :math:`\ETTABLE~(\limits_2~\elemtype_2)` if and only if:

* Limits :math:`\limits_1` :ref:`match <match-limits>` :math:`\limits_2`.

* Both :math:`\elemtype_1` and :math:`\elemtype_2` are the same.

.. math::
   \frac{
     \vdashlimitsmatch \limits_1 \matches \limits_2
   }{
     \vdashexterntypematch \ETTABLE~(\limits_1~\elemtype) \matches \ETTABLE~(\limits_2~\elemtype)
   }


.. index:: memory type, limits
.. _match-memtype:

Memories
........

An :ref:`external type <syntax-externtype>` :math:`\ETMEM~\limits_1` matches :math:`\ETMEM~\limits_2` if and only if:

* Limits :math:`\limits_1` :ref:`match <match-limits>` :math:`\limits_2`.

.. math::
   \frac{
     \vdashlimitsmatch \limits_1 \matches \limits_2
   }{
     \vdashexterntypematch \ETMEM~\limits_1 \matches \ETMEM~\limits_2
   }


.. index:: global type, value type, mutability
.. _match-globaltype:

Globals
.......

An :ref:`external type <syntax-externtype>` :math:`\ETGLOBAL~\globaltype_1` matches :math:`\ETGLOBAL~\globaltype_2` if and only if:

* Both :math:`\globaltype_1` and :math:`\globaltype_2` are the same.

.. math::
   ~\\[-1ex]
   \frac{
   }{
     \vdashexterntypematch \ETGLOBAL~\globaltype \matches \ETGLOBAL~\globaltype
   }


.. index:: ! allocation, store, address
.. _alloc:

Allocation
~~~~~~~~~~

New instances of :ref:`functions <syntax-funcinst>`, :ref:`tables <syntax-tableinst>`, :ref:`memories <syntax-meminst>`, and :ref:`globals <syntax-globalinst>` are *allocated* in a :ref:`store <syntax-store>` :math:`S`, as defined by the following auxiliary functions.


.. index:: function, function instance, function address, module instance, function type
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
   ~\\[-1ex]
   \begin{array}{rlll}
   \allocfunc(S, \func, \moduleinst) &=& S', \funcaddr \\[1ex]
   \mbox{where:} \hfill \\
   \funcaddr &=& |S.\SFUNCS| \\
   \functype &=& \moduleinst.\MITYPES[\func.\FTYPE] \\
   \funcinst &=& \{ \FITYPE~\functype, \FIMODULE~\moduleinst, \FICODE~\func \} \\
   S' &=& S \compose \{\SFUNCS~\funcinst\} \\
   \end{array}


.. index:: host function, function instance, function address, function type
.. _alloc-hostfunc:

:ref:`Host Functions <syntax-hostfunc>`
.......................................

1. Let :math:`\hostfunc` be the :ref:`host function <syntax-hostfunc>` to allocate and :math:`\functype` its :ref:`function type <syntax-functype>`.

2. Let :math:`a` be the first free :ref:`function address <syntax-funcaddr>` in :math:`S`.

3. Let :math:`\funcinst` be the :ref:`function instance <syntax-funcinst>` :math:`\{ \FITYPE~\functype, \FIHOSTCODE~\hostfunc \}`.

4. Append :math:`\funcinst` to the |SFUNCS| of :math:`S`.

5. Return :math:`a`.

.. math::
   ~\\[-1ex]
   \begin{array}{rlll}
   \allochostfunc(S, \functype, \hostfunc) &=& S', \funcaddr \\[1ex]
   \mbox{where:} \hfill \\
   \funcaddr &=& |S.\SFUNCS| \\
   \funcinst &=& \{ \FITYPE~\functype, \FIHOSTCODE~\hostfunc \} \\
   S' &=& S \compose \{\SFUNCS~\tableinst\} \\
   \end{array}

.. note::
   Host functions are never allocated by the WebAssembly semantics itself,
   but may be allocated by the :ref:`embedder <embedder>`.


.. index:: table, table instance, table address, table type, limits
.. _alloc-table:

:ref:`Tables <syntax-tableinst>`
................................

1. Let :math:`\tabletype` be the :ref:`table type <syntax-tabletype>` to allocate.

2. Let :math:`(\{\LMIN~n, \LMAX~m^?\}~\elemtype)` be the structure of :ref:`table type <syntax-tabletype>` :math:`\tabletype`.

3. Let :math:`a` be the first free :ref:`table address <syntax-tableaddr>` in :math:`S`.

4. Let :math:`\tableinst` be the :ref:`table instance <syntax-tableinst>` :math:`\{ \TIELEM~(\epsilon)^n, \TIMAX~m^? \}` with :math:`n` empty elements.

5. Append :math:`\tableinst` to the |STABLES| of :math:`S`.

6. Return :math:`a`.

.. math::
   \begin{array}{rlll}
   \alloctable(S, \tabletype) &=& S', \tableaddr \\[1ex]
   \mbox{where:} \hfill \\
   \tabletype &=& \{\LMIN~n, \LMAX~m^?\}~\elemtype \\
   \tableaddr &=& |S.\STABLES| \\
   \tableinst &=& \{ \TIELEM~(\epsilon)^n, \TIMAX~m^? \} \\
   S' &=& S \compose \{\STABLES~\tableinst\} \\
   \end{array}


.. index:: memory, memory instance, memory address, memory type, limits, byte
.. _alloc-mem:

:ref:`Memories <syntax-meminst>`
................................

1. Let :math:`\memtype` be the :ref:`memory type <syntax-memtype>` to allocate.

2. Let :math:`\{\LMIN~n, \LMAX~m^?\}` be the structure of :ref:`memory type <syntax-memtype>` :math:`\memtype`.

3. Let :math:`a` be the first free :ref:`memory address <syntax-memaddr>` in :math:`S`.

4. Let :math:`\meminst` be the :ref:`memory instance <syntax-meminst>` :math:`\{ \MIDATA~(\hex{00})^{n \cdot 64\,\F{Ki}}, \MIMAX~m^? \}` that contains :math:`n` pages of zeroed :ref:`bytes <syntax-byte>`.

5. Append :math:`\meminst` to the |SMEMS| of :math:`S`.

6. Return :math:`a`.

.. math::
   \begin{array}{rlll}
   \allocmem(S, \memtype) &=& S', \memaddr \\[1ex]
   \mbox{where:} \hfill \\
   \memtype &=& \{\LMIN~n, \LMAX~m^?\} \\
   \memaddr &=& |S.\SMEMS| \\
   \meminst &=& \{ \MIDATA~(\hex{00})^{n \cdot 64\,\F{Ki}}, \MIMAX~m^? \} \\
   S' &=& S \compose \{\SMEMS~\meminst\} \\
   \end{array}


.. index:: global, global instance, global address, global type, value type, mutability, value
.. _alloc-global:

:ref:`Globals <syntax-globalinst>`
..................................

1. Let :math:`\globaltype` be the :ref:`global type <syntax-globaltype>` to allocate and :math:`\val` the :ref:`value <syntax-val>` to initialize the global with.

2. Let :math:`\mut~t` be the structure of :ref:`global type <syntax-globaltype>` :math:`\globaltype`.

3. Let :math:`a` be the first free :ref:`global address <syntax-globaladdr>` in :math:`S`.

4. Let :math:`\globalinst` be the :ref:`global instance <syntax-globalinst>` :math:`\{ \GIVALUE~\val, \GIMUT~\mut \}`.

5. Append :math:`\globalinst` to the |SGLOBALS| of :math:`S`.

6. Return :math:`a`.

.. math::
   \begin{array}{rlll}
   \allocglobal(S, \globaltype, \val) &=& S', \globaladdr \\[1ex]
   \mbox{where:} \hfill \\
   \globaltype &=& \mut~t \\
   \globaladdr &=& |S.\SGLOBALS| \\
   \globalinst &=& \{ \GIVALUE~\val, \GIMUT~\mut \} \\
   S' &=& S \compose \{\SGLOBALS~\globalinst\} \\
   \end{array}


.. index:: table, table instance, table address, grow, limits
.. _grow-table:

Growing :ref:`tables <syntax-tableinst>`
........................................

1. Let :math:`\tableinst` be the :ref:`table instance <syntax-tableinst>` to grow and :math:`n` the number of elements by which to grow it.

2. If :math:`\tableinst.\TIMAX` is not empty and smaller than :math:`n` added to the length of :math:`\tableinst.\TIELEM`, then fail.

3. Append :math:`n` empty elements to :math:`\tableinst.\TIELEM`.

.. math::
   \begin{array}{rllll}
   \growtable(\tableinst, n) &=& \tableinst \with \TIELEM = \tableinst.\TIELEM~(\epsilon)^n \\
     && (\iff \tableinst.\TIMAX = \epsilon \vee |\tableinst.\TIELEM| + n \leq \tableinst.\TIMAX) \\
   \end{array}


.. index:: memory, memory instance, memory address, grow, limits
.. _grow-mem:

Growing :ref:`memories <syntax-meminst>`
........................................

1. Let :math:`\meminst` be the :ref:`memory instance <syntax-meminst>` to grow and :math:`n` the number of :ref:`pages <page-size>` by which to grow it.

2. Let :math:`\X{len}` be :math:`n` multiplied by the :ref:`page size <page-size>` :math:`64\,\F{Ki}`.

3. If :math:`\meminst.\MIMAX` is not empty and its value multiplied by the :ref:`page size <page-size>` :math:`64\,\F{Ki}` is smaller than :math:`\X{len}` added to the length of :math:`\meminst.\MIDATA`, then fail.

4. Append :math:`\X{len}` :ref:`bytes <syntax-byte>` with value :math:`\hex{00}` to :math:`\meminst.\MIDATA`.

.. math::
   \begin{array}{rllll}
   \growmem(\meminst, n) &=& \meminst \with \MIDATA = \meminst.\MIDATA~(\hex{00})^{n \cdot 64\,\F{Ki}} \\
     && (\iff \meminst.\MIMAX = \epsilon \vee |\meminst.\MIDATA| + n \cdot 64\,\F{Ki} \leq \meminst.\MIMAX \cdot 64\,\F{Ki}) \\
   \end{array}


.. index:: module, module instance, function instance, table instance, memory instance, global instance, export instance, function address, table address, memory address, global address, function index, table index, memory index, global index, type, function, table, memory, global, import, export, external value, external type, matching
.. _alloc-module:

:ref:`Modules <syntax-moduleinst>`
..................................

The allocation function for :ref:`modules <syntax-module>` requires a suitable list of :ref:`external values <syntax-externval>` that are assumed to :ref:`match <match-externtype>` the :ref:`import <syntax-import>` vector of the module,
and a list of initialization :ref:`values <syntax-val>` for the module's :ref:`globals <syntax-global>`.

1. Let :math:`\module` be the :ref:`module <syntax-module>` to allocate and :math:`\externval_{\F{im}}^\ast` the vector of :ref:`external values <syntax-externval>` providing the module's imports,
and :math:`\val^\ast` the initialization :ref:`values <syntax-val>` of the module's :ref:`globals <syntax-global>`.

2. For each :ref:`function <syntax-func>` :math:`\func_i` in :math:`\module.\MFUNCS`, do:

   a. Let :math:`\funcaddr_i` be the :ref:`function address <syntax-funcaddr>` resulting from :ref:`allocating <alloc-func>` :math:`\func_i` for the :ref:`\module instance <syntax-moduleinst>` :math:`\moduleinst` defined below.

3. For each :ref:`table <syntax-table>` :math:`\table_i` in :math:`\module.\MTABLES`, do:

   a. Let :math:`\tableaddr_i` be the :ref:`table address <syntax-tableaddr>` resulting from :ref:`allocating <alloc-table>` :math:`\table_i.\TTYPE`.

4. For each :ref:`memory <syntax-mem>` :math:`\mem_i` in :math:`\module.\MMEMS`, do:

   a. Let :math:`\memaddr_i` be the :ref:`memory address <syntax-memaddr>` resulting from :ref:`allocating <alloc-mem>` :math:`\mem_i.\MTYPE`.

5. For each :ref:`global <syntax-global>` :math:`\global_i` in :math:`\module.\MGLOBALS`, do:

   a. Let :math:`\globaladdr_i` be the :ref:`global address <syntax-globaladdr>` resulting from :ref:`allocating <alloc-global>` :math:`\global_i.\GTYPE` with initializer value :math:`\val^\ast[i]`.

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
   ~\\
   \begin{array}{rlll}
   \allocmodule(S, \module, \externval_{\F{im}}^\ast, \val^\ast) &=& S', \moduleinst    \end{array}

where:

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
   S_2, \tableaddr^\ast &=& \alloctable^\ast(S_1, (\table.\TTYPE)^\ast)
     \qquad\qquad\qquad~ (\where \table^\ast = \module.\MTABLES) \\
   S_3, \memaddr^\ast &=& \allocmem^\ast(S_2, (\mem.\MTYPE)^\ast)
     \qquad\qquad\qquad~ (\where \mem^\ast = \module.\MMEMS) \\
   S', \globaladdr^\ast &=& \allocglobal^\ast(S_3, (\global.\GTYPE)^\ast, \val^\ast)
     \qquad\quad~ (\where \global^\ast = \module.\MGLOBALS) \\
   \exportinst^\ast &=& \{ \EINAME~(\export.\ENAME), \EIVALUE~\externval_{\F{ex}} \}^\ast
     \quad (\where \export^\ast = \module.\MEXPORTS) \\[1ex]
   \evfuncs(\externval_{\F{ex}}^\ast) &=& (\moduleinst.\MIFUNCS[x])^\ast
     \qquad~ (\where x^\ast = \edfuncs(\module.\MEXPORTS)) \\
   \evtables(\externval_{\F{ex}}^\ast) &=& (\moduleinst.\MITABLES[x])^\ast
     \qquad (\where x^\ast = \edtables(\module.\MEXPORTS)) \\
   \evmems(\externval_{\F{ex}}^\ast) &=& (\moduleinst.\MIMEMS[x])^\ast
     \qquad (\where x^\ast = \edmems(\module.\MEXPORTS)) \\
   \evglobals(\externval_{\F{ex}}^\ast) &=& (\moduleinst.\MIGLOBALS[x])^\ast
     \qquad\!\!\! (\where x^\ast = \edglobals(\module.\MEXPORTS)) \\
   \end{array}

.. scratch
   Here, in slight abuse of notation, :math:(`\F{allocxyz}(S, \dots))^\ast` is taken to express multiple allocations with the updates to the store :math:`S` being threaded through, i.e.,

  .. math::
   \begin{array}{rlll}
   (\F{allocxyz}^\ast(S_0, \dots))^n &=& S_n, a^n \\[1ex]
   \mbox{where for all $i < n$:} \hfill \\
   S_{i+1}, a^n[i] &=& \F{allocxyz}(S_i, \dots)
   \end{array}

Here, the notation :math:`\F{allocx}^\ast` is shorthand for multiple :ref:`allocations <alloc>` of object kind :math:`X`, defined as follows:

.. math::
   \begin{array}{rlll}
   \F{allocx}^\ast(S_0, X^n, \dots) &=& S_n, a^n \\[1ex]
   \mbox{where for all $i < n$:} \hfill \\
   S_{i+1}, a^n[i] &=& \F{allocx}(S_i, X^n[i], \dots)
   \end{array}

Moreover, if the dots :math:`\dots` are a sequence :math:`A^n` (as for globals), then the elements of this sequence are passed to the allocation function pointwise.

.. note::
   The definition of module allocation is mutually recursive with the allocation of its associated functions, because the resulting module instance :math:`\moduleinst` is passed to the function allocator as an argument, in order to form the necessary closures.
   In an implementation, this recursion is easily unraveled by mutating one or the other in a secondary step.


.. index:: ! instantiation, module, instance, store, trap
.. _exec-module:
.. _exec-instantiation:

Instantiation
~~~~~~~~~~~~~

Given a :ref:`store <syntax-store>` :math:`S`, a :ref:`module <syntax-module>` :math:`\module` is instantiated with a list of :ref:`external values <syntax-externval>` :math:`\externval^n` supplying the required imports as follows.

Instantiation checks that the module is :ref:`valid <valid>` and the provided imports :ref:`match <match-externtype>` the declared types,
and may *fail* with an error otherwise.
Instantiation can also result in a :ref:`trap <trap>` from executing the start function.
It is up to the :ref:`embedder <embedder>` to define how such conditions are reported.

1. If :math:`\module` is not :ref:`valid <valid-module>`, then:

   a. Fail.

2. Assert: :math:`\module` is :ref:`valid <valid-module>` with :ref:`external types <syntax-externtype>` :math:`\externtype_{\F{im}}^m` classifying its :ref:`imports <syntax-import>`.

3. If the number :math:`m` of :ref:`imports <syntax-import>` is not equal to the number :math:`n` of provided :ref:`external values <syntax-externval>`, then:

   a. Fail.

4. For each :ref:`external value <syntax-externval>` :math:`\externval_i` in :math:`\externval^n` and :ref:`external type <syntax-externtype>` :math:`\externtype'_i` in :math:`\externtype_{\F{im}}^n`, do:

   a. Assert: :math:`\externval_i` is :ref:`valid <valid-externval>` with :ref:`external type <syntax-externtype>` :math:`\externtype_i` in store :math:`S`.

   b. If :math:`\externtype_i` does not :ref:`match <match-externtype>` :math:`\externtype'_i`, then:

      i. Fail.

5. Let :math:`\moduleinst_{\F{im}}` be the auxiliary module instance :math:`\{\MIGLOBALS~\evglobals(\externval^\ast)\}` that only consists of the imported globals.

6. Let :math:`F` be the :ref:`frame <syntax-frame>` :math:`\{ \AMODULE~\moduleinst_{\F{im}}, \ALOCALS~\epsilon \}`.

7. Push the frame :math:`F` to the stack.

8. Let :math:`\globalidx_{\F{new}}` be the :ref:`global index <syntax-globalidx>` that corresponds to the number of global :ref:`imports <syntax-import>` in :math:`\module.\MIMPORTS` (i.e., the index of the first non-imported global).

9. For each :ref:`global <syntax-global>` :math:`\global_i` in :math:`\module.\MGLOBALS`, do:

   a. Let :math:`\val_i` be the result of :ref:`evaluating <exec-expr>` the initializer expression :math:`\global_i.\GINIT`.

   b. Let :math:`\globalidx_i` be the :ref:`global index <syntax-globalidx>` :math:`\globalidx_{\F{new}} + i`.

   c. Assert: due to :ref:`validation <valid-global>`, :math:`\moduleinst.\MIGLOBALS[\globalidx_i]` exists.

   d. Let :math:`\globaladdr_i` be the :ref:`global address <syntax-globaladdr>` :math:`\moduleinst.\MIGLOBALS[\globalidx_i]`.

   e. Assert: due to :ref:`validation <valid-global>`, :math:`S.\SGLOBALS[\globaladdr_i]` exists.

   f. Let :math:`\globalinst_i` be the :ref:`global instance <syntax-globalinst>` :math:`S.\SGLOBALS[\globaladdr_i]`.

10. For each :ref:`element segment <syntax-elem>` :math:`\elem_i` in :math:`\module.\MELEM`, do:

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

11. For each :ref:`data segment <syntax-data>` :math:`\data_i` in :math:`\module.\MDATA`, do:

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

12. Assert: due to :ref:`validation <valid-module>`, the frame :math:`F` is now on the top of the stack.

13. Pop the frame from the stack.

14. Let :math:`\moduleinst` be a new module instance :ref:`allocated <alloc-module>` from :math:`\module` in store :math:`S` with imports :math:`\externval^\ast` and global initializer values :math:`\val^\ast`.

15. For each :ref:`element segment <syntax-elem>` :math:`\elem_i` in :math:`\module.\MELEM`, do:

    a. For each :ref:`function index <syntax-funcidx>` :math:`\funcidx_{ij}` in :math:`\elem_i.\EINIT` (starting with :math:`j = 0`), do:

       i. Assert: due to :ref:`validation <valid-elem>`, :math:`\moduleinst.\MIFUNCS[\funcidx_{ij}]` exists.

       ii. Let :math:`\funcaddr_{ij}` be the :ref:`function address <syntax-funcaddr>` :math:`\moduleinst.\MIFUNCS[\funcidx_{ij}]`.

       iii. Replace :math:`\tableinst_i.\TIELEM[\X{eo}_i + j]` with :math:`\funcaddr_{ij}`.

16. For each :ref:`data segment <syntax-data>` :math:`\data_i` in :math:`\module.\MDATA`, do:

    a. For each :ref:`byte <syntax-byte>` :math:`b_{ij}` in :math:`\data_i.\DINIT` (starting with :math:`j = 0`), do:

       i. Replace :math:`\meminst_i.\MIDATA[\X{do}_i + j]` with :math:`b_{ij}`.

17. If the :ref:`start function <syntax-start>` :math:`\module.\MSTART` is not empty, then:

    a. Assert: due to :ref:`validation <valid-start>`, :math:`\moduleinst.\MIFUNCS[\module.\MSTART.\SFUNC]` exists.

    b. Let :math:`\funcaddr` be the :ref:`function address <syntax-funcaddr>` :math:`\moduleinst.\MIFUNCS[\module.\MSTART.\SFUNC]`.

    c. :ref:`Invoke <exec-invoke>` the function instance at :math:`\funcaddr`.


.. math::
   ~\\
   \begin{array}{@{}rcll}
   \instantiate(S, \module, \externval^n) &=& S'; F;
     \begin{array}[t]{@{}l@{}}
     (\INITELEM~\tableaddr~\X{eo}~\elem.\EINIT)^\ast \\
     (\INITDATA~\memaddr~\X{do}~\data.\DINIT)^\ast \\
     (\INVOKE~\funcaddr)^? \\
     \end{array} \\
   &(\iff
     & \vdashmodule \module : \externtype_{\F{im}}^n \to \externtype_{\F{ex}}^\ast \\
     &\wedge& (S \vdashexternval \externval : \externtype)^n \\
     &\wedge& (\vdashexterntypematch \externtype \matches \externtype_{\F{im}})^n \\[1ex]
     &\wedge& \module.\MGLOBALS = \global^k \\
     &\wedge& \module.\MELEM = \elem^\ast \\
     &\wedge& \module.\MDATA = \data^\ast \\
     &\wedge& \module.\MSTART = \start^? \\[1ex]
     &\wedge& S', \moduleinst = \allocmodule(S, \module, \externval^n, v^\ast) \\
     &\wedge& F = \{ \AMODULE~\moduleinst, \ALOCALS~\epsilon \} \\[1ex]
     &\wedge& (S'; F; \global.\GINIT \stepto^\ast S'; F; v)^\ast \\
     &\wedge& (S'; F; \elem.\EOFFSET \stepto^\ast S'; F; \I32.\CONST~\X{eo})^\ast \\
     &\wedge& (S'; F; \data.\DOFFSET \stepto^\ast S'; F; \I32.\CONST~\X{do})^\ast \\[1ex]
     &\wedge& (\X{eo} + |\elem.\EINIT| \leq |S'.\STABLES[\tableaddr].\TIELEM|)^\ast \\
     &\wedge& (\X{do} + |\data.\DINIT| \leq |S'.\SMEMS[\memaddr].\MIDATA|)^\ast
   \\[1ex]
     &\wedge& \globaladdr^\ast = \moduleinst.\MIGLOBALS[|\moduleinst.\MIGLOBALS|-k \slice k] \\
     &\wedge& (\tableaddr = \moduleinst.\MITABLES[\elem.\ETABLE])^\ast \\
     &\wedge& (\memaddr = \moduleinst.\MIMEMS[\data.\DMEM])^\ast \\
     &\wedge& (\funcaddr = \moduleinst.\MIFUNCS[\start.\SFUNC])^?)
   \\[1ex]
   \instantiate(S, \module, \externval^n) &=& S; \{\AMODULE~\{\}, \ALOCALS~\epsilon\}; \TRAP
     \qquad (\otherwise)
   \\[2ex]
   S; F; \INITELEM~a~i~\epsilon &\stepto&
     S; F; \epsilon \\
   S; F; \INITELEM~a~i~(x_0~x^\ast) &\stepto&
     S'; F; \INITELEM~a~(i+1)~x^\ast \\ &&
     (\iff S' = S \with \STABLES[a].\TIELEM[i] = F.\AMODULE.\MIFUNCS[x_0])
   \\[1ex]
   S; F; \INITDATA~a~i~\epsilon &\stepto&
     S; F; \epsilon \\
   S; F; \INITDATA~a~i~(b_0~b^\ast) &\stepto&
     S'; F; \INITDATA~a~(i+1)~b^\ast \\ &&
     (\iff S' = S \with \SMEMS[a].\MIDATA[i] = b_0)
   \end{array}

.. note::
   All failure conditions are checked before any observable mutation of the store takes place.
   Store mutation is not atomic;
   it happens in individual steps that may be interleaved with other threads.

   Evaluation of :ref:`constant expressions <valid-constant>` does not affect the store.


.. index:: ! invocation, module, module instance, function, export, function address, function instance, function type, value, stack, trap, store
.. _exec-invocation:

Invocation
~~~~~~~~~~

Once a :ref:`module <syntax-module>` has been :ref:`instantiated <exec-instantiation>`, any exported function can be *invoked* externally via its :ref:`function address <syntax-funcaddr>` :math:`\funcaddr` in the :ref:`store <syntax-store>` :math:`S` and an appropriate list :math:`\val^\ast` of argument :ref:`values <syntax-val>`.

Invocation may *fail* with an error if the arguments do not fit the :ref:`function type <syntax-functype>`.
Invocation can also result in a :ref:`trap <trap>`.
It is up to the :ref:`embedder <embedder>` to define how such conditions are reported.

.. note::
   If the :ref:`embedder <embedder>` API performs type checks itself, either statically or dynamically, before performing an invocation, then no failure other than traps can occur.

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

Once the function has returned, the following steps are executed:

1. Assert: due to :ref:`validation <valid-func>`, :math:`m` :ref:`values <syntax-val>` are on the top of the stack.

2. Pop :math:`\val_{\F{res}}^m` from the stack.

The values :math:`\val_{\F{res}}^m` are returned as the results of the invocation.

.. math::
   ~\\[-1ex]
   \begin{array}{@{}lcl}
   \invoke(S, \funcaddr, \val^n) &=& S; F; \val^n~(\INVOKE~\funcaddr) \\
     &(\iff & S.\SFUNCS[\funcaddr].\FITYPE = [t_1^n] \to [t_2^m] \\
     &\wedge& \val^n = (t_1.\CONST~c)^n) \\
     &\wedge& F = \{ \AMODULE~\{\}, \ALOCALS~\epsilon \} \\
   \end{array}

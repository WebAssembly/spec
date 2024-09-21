Modules
-------

For modules, the execution semantics primarily defines :ref:`instantiation <exec-instantiation>`, which :ref:`allocates <alloc>` instances for a module and its contained definitions, initializes :ref:`tables <syntax-table>` and :ref:`memories <syntax-mem>` from contained :ref:`element <syntax-elem>` and :ref:`data <syntax-data>` segments, and invokes the :ref:`start function <syntax-start>` if present. It also includes :ref:`invocation <exec-invocation>` of exported functions.


.. index:: ! allocation, store, address
.. _alloc:

Allocation
~~~~~~~~~~

New instances of
:ref:`functions <syntax-funcinst>`,
:ref:`tables <syntax-tableinst>`,
:ref:`memories <syntax-meminst>`,
:ref:`globals <syntax-globalinst>`,
:ref:`tags <syntax-taginst>`,
:ref:`element segments <syntax-eleminst>`, and
:ref:`data segments <syntax-datainst>`,
as well as of dynamic data types like
:ref:`structures <syntax-structinst>`,
:ref:`arrays <syntax-arrayinst>`, or
:ref:`exceptions <syntax-exninst>`,
are *allocated* in a :ref:`store <syntax-store>` ${:s}, as defined by the following auxiliary functions.


.. index:: function, function instance, function address, module instance, function type
.. _alloc-func:

:ref:`Functions <syntax-funcinst>`
..................................

$${definition-prose: allocfunc}

.. todo:: (1) Arity difference between generated prose and LaTex expression(parameter 's'), (3) Actual prose uses 'func' for function variable name while LaTex expression uses 'code', (4) Number 5 doesn't exist in the actual prose

1. Let :math:`\func` be the :ref:`function <syntax-func>` to allocate and :math:`\moduleinst` its :ref:`module instance <syntax-moduleinst>`.

2. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`\moduleinst.\MITYPES[\func.\FTYPE]`.

3. Let :math:`a` be the first free :ref:`function address <syntax-funcaddr>` in :math:`S`.

4. Let :math:`\funcinst` be the :ref:`function instance <syntax-funcinst>` :math:`\{ \FITYPE~\deftype, \FIMODULE~\moduleinst, \FICODE~\func \}`.

6. Append :math:`\funcinst` to the |SFUNCS| of :math:`S`.

7. Return :math:`a`.

$${definition: allocfunc}

.. note::
   Host functions are never allocated by the WebAssembly semantics itself,
   but may be allocated by the :ref:`embedder <embedder>`.


.. index:: table, table instance, table address, table type, limits
.. _alloc-table:

:ref:`Tables <syntax-tableinst>`
................................

$${definition-prose: alloctable}

.. todo:: (1) Arity difference between generated prose and LaTex expression(parameter 's')

1. Let :math:`\tabletype` be the :ref:`table type <syntax-tabletype>` of the table to allocate and :math:`\reff` the initialization value.

2. Let :math:`(\{\LMIN~n, \LMAX~m^?\}~\reftype)` be the structure of :ref:`table type <syntax-tabletype>` :math:`\tabletype`.
                                                                                                      3. Let :math:`a` be the first free :ref:`table address <syntax-tableaddr>` in :math:`S`.

4. Let :math:`\tableinst` be the :ref:`table instance <syntax-tableinst>` :math:`\{ \TITYPE~\tabletype', \TIREFS~\reff^n \}` with :math:`n` elements set to :math:`\reff`.

5. Append :math:`\tableinst` to the |STABLES| of :math:`S`.

6. Return :math:`a`.

$${definition: alloctable}


.. index:: memory, memory instance, memory address, memory type, limits, byte
.. _alloc-mem:

:ref:`Memories <syntax-meminst>`
................................

$${definition-prose: allocmem}

.. todo:: (1) Arity difference between generated prose and LaTex expression(parameter 's')

1. Let :math:`\memtype` be the :ref:`memory type <syntax-memtype>` of the memory to allocate.

2. Let :math:`\{\LMIN~n, \LMAX~m^?\}` be the structure of :ref:`memory type <syntax-memtype>` :math:`\memtype`.

3. Let :math:`a` be the first free :ref:`memory address <syntax-memaddr>` in :math:`S`.

4. Let :math:`\meminst` be the :ref:`memory instance <syntax-meminst>` :math:`\{ \MITYPE~\memtype, \MIBYTES~(\hex{00})^{n \cdot 64\,\F{Ki}} \}` that contains :math:`n` pages of zeroed :ref:`bytes <syntax-byte>`.

5. Append :math:`\meminst` to the |SMEMS| of :math:`S`.

6. Return :math:`a`.

$${definition: allocmem}


.. index:: tag, tag instance, tag address, tag type
.. _alloc-tag:

:ref:`Tags <syntax-taginst>`
............................

1. Let :math:`\tagtype` be the :ref:`tag type <syntax-tagtype>` to allocate.

2. Let :math:`a` be the first free :ref:`tag address <syntax-tagaddr>` in :math:`S`.

3. Let :math:`\taginst` be the :ref:`tag instance <syntax-taginst>` :math:`\{ \HITYPE~\tagtype \}`.

4. Append :math:`\taginst` to the |STAGS| of :math:`S`.

5. Return :math:`a`.

.. math::
   \begin{array}{rlll}
   \alloctag(S, \tagtype) &=& S', \tagaddr \\[1ex]
   \mbox{where:} \hfill \\
   \tagaddr &=& |S.\STAGS| \\
   \taginst &=& \{\HITYPE~\tagtype\} \\
   S' &=& S \compose \{\STAGS~\taginst\} \\
   \end{array}


.. index:: exception, exception instance, exception address, tag address
.. _alloc-exception:

:ref:`Exceptions <syntax-exninst>`
..................................

1. Let :math:`ta` be the :ref:`tag address <syntax-tagaddr>` associated with the exception to allocate and :math:`\EIFIELDS~\val^\ast` be the values to initialize the exception with.

2. Let :math:`a` be the first free :ref:`exception address <syntax-exnaddr>` in :math:`S`.

3. Let :math:`\exninst` be the :ref:`exception instance <syntax-exninst>` :math:`\{ \EITAG~ta, \EIFIELDS~\val^\ast \}`.

4. Append :math:`\exninst` to the |SEXNS| of :math:`S`.

5. Return :math:`a`.

.. math::
   \begin{array}{rlll}
   \allocexn(S, \tagaddr, \val^\ast) &=& S', \exnaddr \\[1ex]
   \mbox{where:} \hfill \\
   \exnaddr &=& |S.\SEXNS| \\
   \exninst &=& \{ \EITAG~\tagaddr, \EIFIELDS~\val^\ast \} \\
   S' &=& S \compose \{\SEXNS~\exninst\} \\
   \end{array}


.. index:: global, global instance, global address, global type, value type, mutability, value
.. _alloc-global:

:ref:`Globals <syntax-globalinst>`
..................................

$${definition-prose: allocglobal}

.. todo:: (1) Arity difference between generated prose and LaTex expression(parameter 's')

1. Let :math:`\globaltype` be the :ref:`global type <syntax-globaltype>` of the global to allocate and :math:`\val` its initialization :ref:`value <syntax-val>`.

2. Let :math:`a` be the first free :ref:`global address <syntax-globaladdr>` in :math:`S`.

3. Let :math:`\globalinst` be the :ref:`global instance <syntax-globalinst>` :math:`\{ \GITYPE~\globaltype, \GIVALUE~\val \}`.

4. Append :math:`\globalinst` to the |SGLOBALS| of :math:`S`.

5. Return :math:`a`.

$${definition: allocglobal}


.. index:: element, element instance, element address
.. _alloc-elem:

:ref:`Element segments <syntax-eleminst>`
.........................................

$${definition-prose: allocelem}

.. todo:: (1) Arity difference between generated prose and LaTex expression(parameter 's')

1. Let :math:`\reftype` be the elements' type and :math:`\reff^\ast` the list of :ref:`references <syntax-ref>` to allocate.

2. Let :math:`a` be the first free :ref:`element address <syntax-elemaddr>` in :math:`S`.

3. Let :math:`\eleminst` be the :ref:`element instance <syntax-eleminst>` :math:`\{ \EITYPE~\reftype, \EIREFS~\reff^\ast \}`.

4. Append :math:`\eleminst` to the |SELEMS| of :math:`S`.

5. Return :math:`a`.

$${definition: allocelem}


.. index:: data, data instance, data address
.. _alloc-data:

:ref:`Data segments <syntax-datainst>`
......................................

$${definition-prose: allocdata}

.. todo:: (1) Arity difference between generated prose and LaTex expression(parameter 's')

1. Let :math:`b^\ast` be the list of :ref:`bytes <syntax-byte>` to allocate.

2. Let :math:`a` be the first free :ref:`data address <syntax-dataaddr>` in :math:`S`.

3. Let :math:`\datainst` be the :ref:`data instance <syntax-datainst>` :math:`\{ \DIBYTES~b^\ast \}`.

4. Append :math:`\datainst` to the |SDATAS| of :math:`S`.

5. Return :math:`a`.

$${definition: allocdata}


.. index:: table, table instance, table address, grow, limits
.. _grow-table:

Growing :ref:`tables <syntax-tableinst>`
........................................

$${definition-prose: growtable}

1. Let :math:`\tableinst` be the :ref:`table instance <syntax-tableinst>` to grow, :math:`n` the number of elements by which to grow it, and :math:`\reff` the initialization value.

2. Let :math:`\X{len}` be :math:`n` added to the length of :math:`\tableinst.\TIREFS`.

3. If :math:`\X{len}` is larger than or equal to :math:`2^{32}`, then fail.

4. Let :math:`\limits~t` be the structure of :ref:`table type <syntax-tabletype>` :math:`\tableinst.\TITYPE`.

5. Let :math:`\limits'` be :math:`\limits` with :math:`\LMIN` updated to :math:`\X{len}`.

6. If :math:`\limits'` is not :ref:`valid <valid-limits>`, then fail.

7. Append :math:`\reff^n` to :math:`\tableinst.\TIREFS`.

8. Set :math:`\tableinst.\TITYPE` to the :ref:`table type <syntax-tabletype>` :math:`\limits'~t`.

$${definition: growtable}


.. index:: memory, memory instance, memory address, grow, limits
.. _grow-mem:

Growing :ref:`memories <syntax-meminst>`
........................................

$${definition-prose: growmem}

1. Let :math:`\meminst` be the :ref:`memory instance <syntax-meminst>` to grow and :math:`n` the number of :ref:`pages <page-size>` by which to grow it.

2. Assert: The length of :math:`\meminst.\MIBYTES` is divisible by the :ref:`page size <page-size>` :math:`64\,\F{Ki}`.

3. Let :math:`\X{len}` be :math:`n` added to the length of :math:`\meminst.\MIBYTES` divided by the :ref:`page size <page-size>` :math:`64\,\F{Ki}`.

4. If :math:`\X{len}` is larger than :math:`2^{16}`, then fail.

5. Let :math:`\limits` be the structure of :ref:`memory type <syntax-memtype>` :math:`\meminst.\MITYPE`.

6. Let :math:`\limits'` be :math:`\limits` with :math:`\LMIN` updated to :math:`\X{len}`.

7. If :math:`\limits'` is not :ref:`valid <valid-limits>`, then fail.

8. Append :math:`n` times :math:`64\,\F{Ki}` :ref:`bytes <syntax-byte>` with value :math:`\hex{00}` to :math:`\meminst.\MIBYTES`.

9. Set :math:`\meminst.\MITYPE` to the :ref:`memory type <syntax-memtype>` :math:`\limits'`.

$${definition: growmem}


.. index:: module, module instance, function instance, table instance, memory instance, tag instance, global instance, export instance, function address, table address, memory address, tag address, global address, function index, table index, memory index, tag index, global index, type, function, table, memory, tag, global, import, export, external address, external type, matching
.. _alloc-module:

:ref:`Modules <syntax-moduleinst>`
..................................

.. todo:: (0) Allocmodule is skipped due to an unexpected error

.. todo:: (0) update prose for types

The allocation function for :ref:`modules <syntax-module>` requires a suitable list of :ref:`external addresses <syntax-externaddr>` that are assumed to :ref:`match <match-externtype>` the :ref:`import <syntax-import>` list of the module,
a list of initialization :ref:`values <syntax-val>` for the module's :ref:`globals <syntax-global>`,
and list of :ref:`reference <syntax-ref>` lists for the module's :ref:`element segments <syntax-elem>`.

1. Let :math:`\module` be the :ref:`module <syntax-module>` to allocate and :math:`\externaddr_{\F{im}}^\ast` the list of :ref:`external addresses <syntax-externaddr>` providing the module's imports, :math:`\val_{\F{g}}^\ast` the initialization :ref:`values <syntax-val>` of the module's :ref:`globals <syntax-global>`, :math:`\reff_{\F{t}}^\ast` the initializer :ref:`reference <syntax-ref>` of the module's :ref:`tables <syntax-table>`, and :math:`(\reff_{\F{e}}^\ast)^\ast` the :ref:`reference <syntax-ref>` lists of the module's :ref:`element segments <syntax-elem>`.

2. For each :ref:`defined type <syntax-deftype>` :math:`\deftype'_i` in :math:`\module.\MTYPES`, do:

   a. Let :math:`\deftype_i` be the :ref:`instantiation <type-inst>` :math:`\deftype'_i` in :math:`\moduleinst` defined below.

3. For each :ref:`function <syntax-func>` :math:`\func_i` in :math:`\module.\MFUNCS`, do:

   a. Let :math:`\funcaddr_i` be the :ref:`function address <syntax-funcaddr>` resulting from :ref:`allocating <alloc-func>` :math:`\func_i` for the :ref:`\module instance <syntax-moduleinst>` :math:`\moduleinst` defined below.

4. For each :ref:`table <syntax-table>` :math:`\table_i` in :math:`\module.\MTABLES`, do:

   a. Let :math:`\limits_i~t_i` be the :ref:`table type <syntax-tabletype>` obtained by :ref:`instantiating <type-inst>` :math:`\table_i.\TTYPE` in :math:`\moduleinst` defined below.

   b. Let :math:`\tableaddr_i` be the :ref:`table address <syntax-tableaddr>` resulting from :ref:`allocating <alloc-table>` :math:`\table_i.\TTYPE` with initialization value :math:`\reff_{\F{t}}^\ast[i]`.

5. For each :ref:`memory <syntax-mem>` :math:`\mem_i` in :math:`\module.\MMEMS`, do:

   a. Let :math:`\memtype_i` be the :ref:`memory type <syntax-memtype>` obtained by :ref:`insantiating <type-inst>` :math:`\mem_i.\MTYPE` in :math:`\moduleinst` defined below.

   b. Let :math:`\memaddr_i` be the :ref:`memory address <syntax-memaddr>` resulting from :ref:`allocating <alloc-mem>` :math:`\memtype_i`.

6. For each :ref:`global <syntax-global>` :math:`\global_i` in :math:`\module.\MGLOBALS`, do:

   a. Let :math:`\globaltype_i` be the :ref:`global type <syntax-globaltype>` obtained by :ref:`instantiating <type-inst>` :math:`\global_i.\GTYPE` in :math:`\moduleinst` defined below.

   b. Let :math:`\globaladdr_i` be the :ref:`global address <syntax-globaladdr>` resulting from :ref:`allocating <alloc-global>` :math:`\globaltype_i` with initializer value :math:`\val_{\F{g}}^\ast[i]`.

7. For each :ref:`tag <syntax-tag>` :math:`\tag_i` in :math:`\module.\MTAGS`, do:

   a. Let :math:`\tagtype` be the :ref:`tag type <syntax-tagtype>` :math:`\module.\MTYPES[\tag_i.\TAGTYPE]`.

   b. Let :math:`\tagaddr_i` be the :ref:`tag address <syntax-tagaddr>` resulting from :ref:`allocating <alloc-tag>` :math:`\tagtype`.

8. For each :ref:`element segment <syntax-elem>` :math:`\elem_i` in :math:`\module.\MELEMS`, do:

   a. Let :math:`\reftype_i` be the element :ref:`reference type <syntax-reftype>` obtained by `instantiating <type-inst>` :math:`\elem_i.\ETYPE` in :math:`\moduleinst` defined below.

   b. Let :math:`\elemaddr_i` be the :ref:`element address <syntax-elemaddr>` resulting from :ref:`allocating <alloc-elem>` a :ref:`element instance <syntax-eleminst>` of :ref:`reference type <syntax-reftype>` :math:`\reftype_i` with contents :math:`(\reff_{\F{e}}^\ast)^\ast[i]`.


9. For each :ref:`data segment <syntax-data>` :math:`\data_i` in :math:`\module.\MDATAS`, do:

   a. Let :math:`\dataaddr_i` be the :ref:`data address <syntax-dataaddr>` resulting from :ref:`allocating <alloc-data>` a :ref:`data instance <syntax-datainst>` with contents :math:`\data_i.\DINIT`.

10. Let :math:`\deftype^\ast` be the concatenation of the :ref:`defined types <syntax-deftype>` :math:`\deftype_i` in index order.

11. Let :math:`\funcaddr^\ast` be the concatenation of the :ref:`function addresses <syntax-funcaddr>` :math:`\funcaddr_i` in index order.

12. Let :math:`\tableaddr^\ast` be the concatenation of the :ref:`table addresses <syntax-tableaddr>` :math:`\tableaddr_i` in index order.

13. Let :math:`\memaddr^\ast` be the concatenation of the :ref:`memory addresses <syntax-memaddr>` :math:`\memaddr_i` in index order.

14. Let :math:`\globaladdr^\ast` be the concatenation of the :ref:`global addresses <syntax-globaladdr>` :math:`\globaladdr_i` in index order.

15. Let :math:`\tagaddr^\ast` be the concatenation of the :ref:`tag addresses <syntax-tagaddr>` :math:`\tagaddr_i` in index order.

16. Let :math:`\elemaddr^\ast` be the concatenation of the :ref:`element addresses <syntax-elemaddr>` :math:`\elemaddr_i` in index order.

17. Let :math:`\dataaddr^\ast` be the concatenation of the :ref:`data addresses <syntax-dataaddr>` :math:`\dataaddr_i` in index order.

18. Let :math:`\funcaddr_{\F{mod}}^\ast` be the list of :ref:`function addresses <syntax-funcaddr>` extracted from :math:`\externaddr_{\F{im}}^\ast`, concatenated with :math:`\funcaddr^\ast`.

19. Let :math:`\tableaddr_{\F{mod}}^\ast` be the list of :ref:`table addresses <syntax-tableaddr>` extracted from :math:`\externaddr_{\F{im}}^\ast`, concatenated with :math:`\tableaddr^\ast`.

20. Let :math:`\memaddr_{\F{mod}}^\ast` be the list of :ref:`memory addresses <syntax-memaddr>` extracted from :math:`\externaddr_{\F{im}}^\ast`, concatenated with :math:`\memaddr^\ast`.

21. Let :math:`\globaladdr_{\F{mod}}^\ast` be the list of :ref:`global addresses <syntax-globaladdr>` extracted from :math:`\externaddr_{\F{im}}^\ast`, concatenated with :math:`\globaladdr^\ast`.

22. Let :math:`\tagaddr_{\F{mod}}^\ast` be the list of :ref:`tag addresses <syntax-tagaddr>` extracted from :math:`\externaddr_{\F{im}}^\ast`, concatenated with :math:`\tagaddr^\ast`.

23. For each :ref:`export <syntax-export>` :math:`\export_i` in :math:`\module.\MEXPORTS`, do:

    a. If :math:`\export_i` is a function export for :ref:`function index <syntax-funcidx>` :math:`x`, then let :math:`\externaddr_i` be the :ref:`external address <syntax-externaddr>` :math:`\XAFUNC~(\funcaddr_{\F{mod}}^\ast[x])`.

    b. Else, if :math:`\export_i` is a table export for :ref:`table index <syntax-tableidx>` :math:`x`, then let :math:`\externaddr_i` be the :ref:`external address <syntax-externaddr>` :math:`\XATABLE~(\tableaddr_{\F{mod}}^\ast[x])`.

    c. Else, if :math:`\export_i` is a memory export for :ref:`memory index <syntax-memidx>` :math:`x`, then let :math:`\externaddr_i` be the :ref:`external address <syntax-externaddr>` :math:`\XAMEM~(\memaddr_{\F{mod}}^\ast[x])`.

    d. Else, if :math:`\export_i` is a global export for :ref:`global index <syntax-globalidx>` :math:`x`, then let :math:`\externaddr_i` be the :ref:`external address <syntax-externaddr>` :math:`\XAGLOBAL~(\globaladdr_{\F{mod}}^\ast[x])`.

    e. Else, if :math:`\export_i` is a tag export for :ref:`tag index <syntax-tagidx>` :math:`x`, then let :math:`\externaddr_i` be the :ref:`external address <syntax-externaddr>` :math:`\XATAG~(\tagaddr_{\F{mod}}^\ast[x])`.

    f. Let :math:`\exportinst_i` be the :ref:`export instance <syntax-exportinst>` :math:`\{\XINAME~(\export_i.\XNAME), \XIADDR~\externaddr_i\}`.

24. Let :math:`\exportinst^\ast` be the concatenation of the :ref:`export instances <syntax-exportinst>` :math:`\exportinst_i` in index order.

25. Let :math:`\moduleinst` be the :ref:`module instance <syntax-moduleinst>` :math:`\{\MITYPES~\deftype^\ast,` :math:`\MIFUNCS~\funcaddr_{\F{mod}}^\ast,` :math:`\MITABLES~\tableaddr_{\F{mod}}^\ast,` :math:`\MIMEMS~\memaddr_{\F{mod}}^\ast,` :math:`\MIGLOBALS~\globaladdr_{\F{mod}}^\ast,` :math:`\MITAGS~\tagaddr_{\F{mod}}^\ast`, :math:`\MIEXPORTS~\exportinst^\ast\}`.

26. Return :math:`\moduleinst`.

$${definition: allocmodule}

Here, the notation :math:`\F{allocx}^\ast` is shorthand for multiple :ref:`allocations <alloc>` of object kind :math:`X`, defined as follows:

$${definition-prose: allocXs}

.. todo:: (0) Update prose for TODOs

$${definition: allocXs}
$${definition-ignore: allocfuncs allocglobals alloctables allocmems allocelems allocdatas}

For types, however, allocation is defined in terms of :ref:`rolling <aux-roll-rectype>` and :ref:`substitution <notation-subst>` of all preceding types to produce a list of :ref:`closed <type-closed>` :ref:`defined types <syntax-deftype>`:

.. _alloc-type:

$${definition-prose: alloctypes}

$${definition: alloctypes}

Finally, export instances are produced with the help of the following definition:

.. _alloc-export:

$${definition-prose: allocexports}

$${definition-prose: allocexport}

$${definition: {allocexports allocexport}}

.. note::
   The definition of module allocation is mutually recursive with the allocation of its associated functions, because the resulting module instance is passed to the allocators as an argument, in order to form the necessary closures.
   In an implementation, this recursion is easily unraveled by mutating one or the other in a secondary step.



.. index:: ! instantiation, module, instance, store, trap, exception
.. _exec-module:
.. _exec-instantiation:

Instantiation
~~~~~~~~~~~~~

Given a :ref:`store <syntax-store>` ${:s}, a ${:module} is instantiated with a list of :ref:`external addresses <syntax-externaddr>` ${:externaddr*} supplying the required imports as follows.

Instantiation checks that the module is :ref:`valid <valid>` and the provided imports :ref:`match <match-externtype>` the declared types,
and may *fail* with an error otherwise.
Instantiation can also result in an :ref:`exception <exception>` or :ref:`trap <trap>` when initializing a :ref:`table <syntax-table>` or :ref:`memory <syntax-mem>` from an :ref:`active segment <syntax-data>` or when executing the :ref:`start <syntax-start>` function.
It is up to the :ref:`embedder <embedder>` to define how such conditions are reported.

$${definition-prose: instantiate}

.. todo:: (2) At line 24 and 27, f is popped instead of z'

1. If :math:`\module` is not :ref:`valid <valid-module>`, then:

   a. Fail.

2. Assert: :math:`\module` is :ref:`valid <valid-module>` with :ref:`external types <syntax-externtype>` :math:`\externtype_{\F{im}}^m` classifying its :ref:`imports <syntax-import>`.

3. If the number :math:`m` of :ref:`imports <syntax-import>` is not equal to the number :math:`n` of provided :ref:`external addresses <syntax-externaddr>`, then:

   a. Fail.

4. For each :ref:`external address <syntax-externaddr>` :math:`\externaddr_i` in :math:`\externaddr^n` and :ref:`external type <syntax-externtype>` :math:`\externtype'_i` in :math:`\externtype_{\F{im}}^n`, do:

   a. If :math:`\externaddr_i` is not :ref:`valid <valid-externaddr>` with an :ref:`external type <syntax-externtype>` :math:`\externtype_i` in store :math:`S`, then:

      i. Fail.

   b. Let :math:`\externtype''_i` be the :ref:`external type <syntax-externtype>` obtained by :ref:`instantiating <type-inst>` :math:`\externtype'_i` in :math:`\moduleinst` defined below.

   c. If :math:`\externtype_i` does not :ref:`match <match-externtype>` :math:`\externtype''_i`, then:

      i. Fail.

.. _exec-initvals:

6. Let :math:`F` be the auxiliary :ref:`frame <syntax-frame>` :math:`\{ \AMODULE~\moduleinst, \ALOCALS~\epsilon \}`, that consists of the final module instance :math:`\moduleinst`, defined below.

7. Push the frame :math:`F` to the stack.

8. Let :math:`\val_{\F{g}}^\ast` be the list of :ref:`global <syntax-global>` initialization :ref:`values <syntax-val>` determined by :math:`\module` and :math:`\externaddr^n`. These may be calculated as follows.

   a. For each :ref:`global <syntax-global>` :math:`\global_i` in :math:`\module.\MGLOBALS`, do:

      i. Let :math:`\val_{\F{g}i}` be the result of :ref:`evaluating <exec-expr>` the initializer expression :math:`\global_i.\GINIT`.

   b. Assert: due to :ref:`validation <valid-module>`, the frame :math:`F` is now on the top of the stack.

   c. Let :math:`\val_{\F{g}}^\ast` be the concatenation of :math:`\val_{\F{g}i}` in index order.

9. Let :math:`\reff_{\F{t}}^\ast` be the list of :ref:`table <syntax-table>` initialization :ref:`references <syntax-ref>` determined by :math:`\module` and :math:`\externaddr^n`. These may be calculated as follows.

   a. For each :ref:`table <syntax-table>` :math:`\table_i` in :math:`\module.\MTABLES`, do:

      i. Let :math:`\val_{\F{t}i}` be the result of :ref:`evaluating <exec-expr>` the initializer expression :math:`\table_i.\TINIT`.

      ii. Assert: due to :ref:`validation <valid-table>`, :math:`\val_{\F{t}i}` is a :ref:`reference <syntax-ref>`.

      iii. Let :math:`\reff_{\F{t}i}` be the reference :math:`\val_{\F{t}i}`.

   b. Assert: due to :ref:`validation <valid-module>`, the frame :math:`F` is now on the top of the stack.

   c. Let :math:`\reff_{\F{t}}^\ast` be the concatenation of :math:`\reff_{ti}` in index order.

10. Let :math:`(\reff_{\F{e}}^\ast)^\ast` be the list of :ref:`reference <syntax-ref>` lists determined by the :ref:`element segments <syntax-elem>` in :math:`\module`. These may be calculated as follows.

    a. For each :ref:`element segment <syntax-elem>` :math:`\elem_i` in :math:`\module.\MELEMS`, and for each element :ref:`expression <syntax-expr>` :math:`\expr_{ij}` in :math:`\elem_i.\EINIT`, do:

       i. Let :math:`\reff_{ij}` be the result of :ref:`evaluating <exec-expr>` the initializer expression :math:`\expr_{ij}`.

    b. Let :math:`\reff^\ast_i` be the concatenation of function elements :math:`\reff_{ij}` in order of index :math:`j`.

    c. Let :math:`(\reff_{\F{e}}^\ast)^\ast` be the concatenation of function element lists :math:`\reff^\ast_i` in order of index :math:`i`.

11. Let :math:`\moduleinst` be a new module instance :ref:`allocated <alloc-module>` from :math:`\module` in store :math:`S` with imports :math:`\externaddr^n`, global initializer values :math:`\val_{\F{g}}^\ast`, table initializer values :math:`\reff_{\F{t}}^\ast`, and element segment contents :math:`(\reff_{\F{e}}^\ast)^\ast`, and let :math:`S'` be the extended store produced by module allocation.

12. For each :ref:`element segment <syntax-elem>` :math:`\elem_i` in :math:`\module.\MELEMS` whose :ref:`mode <syntax-elemmode>` is of the form :math:`\EACTIVE~\{ \ETABLE~\tableidx_i, \EOFFSET~\X{einstr}^\ast_i~\END \}`, do:

    a. Let :math:`n` be the length of the list :math:`\elem_i.\EINIT`.

    b. :ref:`Execute <exec-instrs>` the instruction sequence :math:`\X{einstr}^\ast_i`.

    c. :ref:`Execute <exec-const>` the instruction :math:`\I32.\CONST~0`.

    d. :ref:`Execute <exec-const>` the instruction :math:`\I32.\CONST~n`.

    e. :ref:`Execute <exec-table.init>` the instruction :math:`\TABLEINIT~\tableidx_i~i`.

    f. :ref:`Execute <exec-elem.drop>` the instruction :math:`\ELEMDROP~i`.

13. For each :ref:`element segment <syntax-elem>` :math:`\elem_i` in :math:`\module.\MELEMS` whose :ref:`mode <syntax-elemmode>` is of the form :math:`\EDECLARE`, do:

    a. :ref:`Execute <exec-elem.drop>` the instruction :math:`\ELEMDROP~i`.

14. For each :ref:`data segment <syntax-data>` :math:`\data_i` in :math:`\module.\MDATAS` whose :ref:`mode <syntax-datamode>` is of the form :math:`\DACTIVE~\{ \DMEM~\memidx_i, \DOFFSET~\X{dinstr}^\ast_i~\END \}`, do:

    a. Let :math:`n` be the length of the list :math:`\data_i.\DINIT`.

    b. :ref:`Execute <exec-instrs>` the instruction sequence :math:`\X{dinstr}^\ast_i`.

    c. :ref:`Execute <exec-const>` the instruction :math:`\I32.\CONST~0`.

    d. :ref:`Execute <exec-const>` the instruction :math:`\I32.\CONST~n`.

    e. :ref:`Execute <exec-memory.init>` the instruction :math:`\MEMORYINIT~i`.

    f. :ref:`Execute <exec-data.drop>` the instruction :math:`\DATADROP~i`.

15. If the :ref:`start function <syntax-start>` :math:`\module.\MSTART` is not empty, then:

    a. Let :math:`\start` be the :ref:`start function <syntax-start>` :math:`\module.\MSTART`.

    b. :ref:`Execute <exec-call>` the instruction :math:`\CALL~\start.\SFUNC`.

16. Assert: due to :ref:`validation <valid-module>`, the frame :math:`F` is now on the top of the stack.

17. Pop the frame :math:`F` from the stack.


$${definition: instantiate}

where:

.. _eval-globals:

$${definition-prose: evalglobals}

$${definition: evalglobals}

.. _aux-runelem:
.. _aux-rundata:

$${definition-prose: runelem_}

$${definition-prose: rundata_}

$${definition: runelem_ rundata_}

.. note::
   Checking import types assumes that the :ref:`module instance <syntax-moduleinst>` has already been :ref:`allocated <alloc-module>` to compute the respective :ref:`closed <type-closed>` :ref:`defined types <syntax-deftype>`.
   However, this forward reference merely is a way to simplify the specification.
   In practice, implementations will likely allocate or canonicalize types beforehand, when *compiling* a module, in a stage before instantiation and before imports are checked.

   Similarly, module :ref:`allocation <alloc-module>` and the :ref:`evaluation <exec-expr>` of :ref:`global <syntax-global>` and :ref:`table <syntax-table>` initializers as well as :ref:`element segments <syntax-elem>` are mutually recursive because the global initialization :ref:`values <syntax-val>` ${:val_G*}, ${:ref_T}, and element segment contents ${:ref_E**} are passed to the module allocator while depending on the module instance ${:moduleinst} and store ${:s'} returned by allocation.
   Again, this recursion is just a specification device.
   In practice, the initialization values can :ref:`be determined <exec-initvals>` beforehand by staging module allocation such that first, the module's own :ref:`function instances <syntax-funcinst>` are pre-allocated in the store, then the initializer expressions are evaluated in order, allocating globals on the way, then the rest of the module instance is allocated, and finally the new function instances' ${:MODULE} fields are set to that module instance.
   This is possible because :ref:`validation <valid-module>` ensures that initialization expressions cannot actually call a function, only take their reference.

   All failure conditions are checked before any observable mutation of the store takes place.
   Store mutation is not atomic;
   it happens in individual steps that may be interleaved with other threads.

   :ref:`Evaluation <exec-expr>` of :ref:`constant expressions <valid-constant>` does not affect the store.


.. index:: ! invocation, module, module instance, function, export, function address, function instance, function type, value, stack, trap, exception, store
.. _exec-invocation:

Invocation
~~~~~~~~~~

$${definition-prose: invoke}

.. todo:: (1) Arity difference between generated prose and LaTex expression(parameter 's')

Once a :ref:`module <syntax-module>` has been :ref:`instantiated <exec-instantiation>`, any exported function can be *invoked* externally via its :ref:`function address <syntax-funcaddr>` ${:funcaddr} in the :ref:`store <syntax-store>` ${:s} and an appropriate list ${:val*} of argument :ref:`values <syntax-val>`.

Invocation may *fail* with an error if the arguments do not fit the :ref:`function type <syntax-functype>`.
Invocation can also result in an :ref:`exception <exception>` or :ref:`trap <trap>`.
It is up to the :ref:`embedder <embedder>` to define how such conditions are reported.

.. note::
   If the :ref:`embedder <embedder>` API performs type checks itself, either statically or dynamically, before performing an invocation, then no failure other than traps or exceptions can occur.

The following steps are performed:

1. Assert: :math:`S.\SFUNCS[\funcaddr]` exists.

2. Let :math:`\funcinst` be the :ref:`function instance <syntax-funcinst>` :math:`S.\SFUNCS[\funcaddr]`.

3. Let :math:`\TFUNC~[t_1^n] \toF [t_2^m]` be the :ref:`composite type <syntax-comptype>` :math:`\expanddt(\funcinst.\FITYPE)`.

4. If the length :math:`|\val^\ast|` of the provided argument values is different from the number :math:`n` of expected arguments, then:

   a. Fail.

5. For each :ref:`value type <syntax-valtype>` :math:`t_i` in :math:`t_1^n` and corresponding :ref:`value <syntax-val>` :math:`val_i` in :math:`\val^\ast`, do:

   a. If :math:`\val_i` is not :ref:`valid <valid-val>` with value type :math:`t_i`, then:

      i. Fail.

6. Let :math:`F` be the dummy :ref:`frame <syntax-frame>` :math:`\{ \AMODULE~\{\}, \ALOCALS~\epsilon \}`.

7. Push the frame :math:`F` to the stack.

8. Push the values :math:`\val^\ast` to the stack.

9. :ref:`Invoke <exec-invoke>` the function instance at address :math:`\funcaddr`.

Once the function has returned, the following steps are executed:

1. Assert: due to :ref:`validation <valid-func>`, :math:`m` :ref:`values <syntax-val>` are on the top of the stack.

2. Pop :math:`\val_{\F{res}}^m` from the stack.

3. Assert: due to :ref:`validation <valid-module>`, the frame :math:`F` is now on the top of the stack.

4. Pop the frame :math:`F` from the stack.

The values ${:val_RES^m} are returned as the results of the invocation.

$${definition: invoke}

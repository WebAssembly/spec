Modules
-------

For modules, the execution semantics primarily defines :ref:`instantiation <exec-instantiation>`, which :ref:`allocates <alloc>` instances for a module and its contained definitions, initializes :ref:`memories <syntax-mem>` and :ref:`tables <syntax-table>` from contained :ref:`data <syntax-data>` and :ref:`element <syntax-elem>` segments, and invokes the :ref:`start function <syntax-start>` if present. It also includes :ref:`invocation <exec-invocation>` of exported functions.


.. index:: ! allocation, store, address
.. _alloc:

Allocation
~~~~~~~~~~

New instances of
:ref:`tags <syntax-taginst>`,
:ref:`globals <syntax-globalinst>`,
:ref:`memories <syntax-meminst>`,
:ref:`tables <syntax-tableinst>`,
:ref:`functions <syntax-funcinst>`,
:ref:`data segments <syntax-datainst>`, and
:ref:`element segments <syntax-eleminst>`
are *allocated* in a :ref:`store <syntax-store>` ${:s}, as defined by the following auxiliary functions.


.. index:: tag, tag instance, tag address, tag type
.. _alloc-tag:

:ref:`Tags <syntax-taginst>`
............................

$${definition-prose: alloctag}

$${definition: alloctag}


.. index:: global, global instance, global address, global type, value type, mutability, value
.. _alloc-global:

:ref:`Globals <syntax-globalinst>`
..................................

$${definition-prose: allocglobal}

$${definition: allocglobal}


.. index:: memory, memory instance, memory address, memory type, limits, byte
.. _alloc-mem:

:ref:`Memories <syntax-meminst>`
................................

$${definition-prose: allocmem}

$${definition: allocmem}


.. index:: table, table instance, table address, table type, limits
.. _alloc-table:

:ref:`Tables <syntax-tableinst>`
................................

$${definition-prose: alloctable}

$${definition: alloctable}


.. index:: function, function instance, function address, module instance, function type
.. _alloc-func:

:ref:`Functions <syntax-funcinst>`
..................................

$${definition-prose: allocfunc}

$${definition: allocfunc}


.. index:: data, data instance, data address
.. _alloc-data:

:ref:`Data segments <syntax-datainst>`
......................................

$${definition-prose: allocdata}

$${definition: allocdata}


.. index:: element, element instance, element address
.. _alloc-elem:

:ref:`Element segments <syntax-eleminst>`
.........................................

$${definition-prose: allocelem}

$${definition: allocelem}


.. index:: memory, memory instance, memory address, grow, limits
.. _grow-mem:

Growing :ref:`memories <syntax-meminst>`
........................................

$${definition-prose: growmem}

$${definition: growmem}


.. index:: table, table instance, table address, grow, limits
.. _grow-table:

Growing :ref:`tables <syntax-tableinst>`
........................................

$${definition-prose: growtable}

$${definition: growtable}


.. index:: module, module instance, tag instance, global instance, memory instance, table instance, function instance, data instance, element instance, export instance, tag address, global address, memory address, table address, function address, data address, element address, tag index, global index, memory index, table index, function index, type, tag, global, memory, table, function, data segment, element segment, import, export, external address, external type, matching
.. _alloc-module:

:ref:`Modules <syntax-moduleinst>`
..................................

$${definition-prose: allocmodule}

$${definition: allocmodule}

Here, the notation :math:`\F{allocx}^\ast` is shorthand for multiple :ref:`allocations <alloc>` of object kind :math:`X`, defined as follows:

$${definition: allocXs}
$${definition-ignore: alloctags allocglobals allocmems alloctables allocfuncs allocdatas allocelems}

For types, however, allocation is defined in terms of :ref:`rolling <aux-roll-rectype>` and :ref:`substitution <notation-subst>` of all preceding types to produce a list of :ref:`closed <type-closed>` :ref:`defined types <syntax-deftype>`:

.. _alloc-type:

$${definition-prose: alloctypes}

$${definition: alloctypes}

Finally, export instances are produced with the help of the following definition:

.. _alloc-export:

$${definition-prose-ignore: allocexports}
$${definition-ignore: allocexports}

$${definition-prose: allocexport}

$${definition: allocexport}

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

.. _aux-rundata:
.. _aux-runelem:

$${definition-prose: rundata_}

$${definition-prose: runelem_}

$${definition: rundata_ runelem_}

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

Once a :ref:`module <syntax-module>` has been :ref:`instantiated <exec-instantiation>`, any exported function can be *invoked* externally via its :ref:`function address <syntax-funcaddr>` ${:funcaddr} in the :ref:`store <syntax-store>` ${:s} and an appropriate list ${:val*} of argument :ref:`values <syntax-val>`.

Invocation may *fail* with an error if the arguments do not fit the :ref:`function type <syntax-functype>`.
Invocation can also result in an :ref:`exception <exception>` or :ref:`trap <trap>`.
It is up to the :ref:`embedder <embedder>` to define how such conditions are reported.

.. note::
   If the :ref:`embedder <embedder>` API performs type checks itself, either statically or dynamically, before performing an invocation, then no failure other than traps or exceptions can occur.

The following steps are performed:

1. Assert: :math:`S.\SFUNCS[\funcaddr]` exists.

2. Let :math:`\funcinst` be the :ref:`function instance <syntax-funcinst>` :math:`S.\SFUNCS[\funcaddr]`.

3. Let :math:`\TFUNC~[t_1^n] \Tarrow [t_2^m]` be the :ref:`composite type <syntax-comptype>` :math:`\expanddt(\funcinst.\FITYPE)`.

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

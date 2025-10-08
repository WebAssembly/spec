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

.. _exec-initvals:

$${definition-prose: instantiate}

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

Once a :ref:`module <syntax-module>` has been :ref:`instantiated <exec-instantiation>`, any exported function can be *invoked* externally via its :ref:`function address <syntax-funcaddr>` ${:funcaddr} in the :ref:`store <syntax-store>` ${:s} and an appropriate list ${:val*} of argument :ref:`values <syntax-val>`.

Invocation may *fail* with an error if the arguments do not fit the :ref:`function type <syntax-functype>`.
Invocation can also result in an :ref:`exception <exception>` or :ref:`trap <trap>`.
It is up to the :ref:`embedder <embedder>` to define how such conditions are reported.

.. note::
   If the :ref:`embedder <embedder>` API performs type checks itself, either statically or dynamically, before performing an invocation, then no failure other than traps or exceptions can occur.

$${definition-prose: invoke}

$${definition: invoke}

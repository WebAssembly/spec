.. index:: ! embedding, embedder, implementation, host
.. _embed:

Embedding
---------

A WebAssembly implementation will typically be *embedded* into a *host* environment.
An *embedder* implements the connection between such a host environment and the WebAssembly semantics as defined in the main body of this specification.
An embedder is expected to interact with the semantics in well-defined ways.

This section defines a suitable interface to the WebAssembly semantics in the form of entry points through which an embedder can access it.
The interface is intended to be complete, in the sense that an embedder does not need to reference other functional parts of the WebAssembly specification directly.

.. note::
   On the other hand, an embedder does not need to provide the host environment with access to all functionality defined in this interface.
   For example, an implementation may not support :ref:`parsing <embed-module-parse>` of the :ref:`text format <text>`.

Types
~~~~~

In the description of the embedder interface, syntactic classes from the :ref:`abstract syntax <syntax>` and the :ref:`runtime's abstract machine <syntax-runtime>` are used as names for variables that range over the possible objects from that class.
Hence, these syntactic classes can also be interpreted as types.

For numeric parameters, notation like :math:`n:\u32` is used to specify a symbolic name in addition to the respective value range.


.. _embed-error:

Errors
~~~~~~

Failure of an interface operation is indicated by an auxiliary syntactic class:

.. math::
   \begin{array}{llll}
   \production{(error)} & \error &::=& \ERROR \\
   \end{array}

In addition to the error conditions specified explicitly in this section, implementations may also return errors when specific :ref:`implementation limitations <impl>` are reached.

.. note::
   Errors are abstract and unspecific with this definition.
   Implementations can refine it to carry suitable classifications and diagnostic messages.


Pre- and Post-Conditions
~~~~~~~~~~~~~~~~~~~~~~~~

Some operations state *pre-conditions* about their arguments or *post-conditions* about their results.
It is the embedder's responsibility to meet the pre-conditions.
If it does, the post conditions are guaranteed by the semantics.

In addition to pre- and post-conditions explicitly stated with each operation, the specification adopts the following conventions for :ref:`runtime objects <syntax-runtime>` (:math:`\store`, :math:`\moduleinst`, :math:`\externval`, :ref:`addresses <syntax-addr>`):

* Every runtime object passed as a parameter must be :ref:`valid <valid-store>` per an implicit pre-condition.

* Every runtime object returned as a result is :ref:`valid <valid-store>` per an implicit post-condition.

.. note::
   As long as an embedder treats runtime objects as abstract and only creates and manipulates them through the interface defined here, all implicit pre-conditions are automatically met.



.. index:: allocation, store
.. _embed-store:

.. todo:: Update alloc functions to semantic types.


Store
~~~~~

.. _embed-store-init:

:math:`\F{store\_init}() : \store`
..................................

1. Return the empty :ref:`store <syntax-store>`.

.. math::
   \begin{array}{lclll}
   \F{store\_init}() &=& \{ \SFUNCS~\epsilon,~ \SMEMS~\epsilon,~ \STABLES~\epsilon,~ \SGLOBALS~\epsilon \} \\
   \end{array}



.. index:: module
.. _embed-module:

Modules
~~~~~~~

.. index:: binary format
.. _embed-module-decode:

:math:`\F{module\_decode}(\byte^\ast) : \module ~|~ \error`
...........................................................

1. If there exists a derivation for the :ref:`byte <syntax-byte>` sequence :math:`\byte^\ast` as a :math:`\Bmodule` according to the :ref:`binary grammar for modules <binary-module>`, yielding a :ref:`module <syntax-module>` :math:`m`, then return :math:`m`.

2. Else, return :math:`\ERROR`.

.. math::
   \begin{array}{lclll}
   \F{module\_decode}(b^\ast) &=& m && (\iff \Bmodule \stackrel\ast\Longrightarrow m{:}b^\ast) \\
   \F{module\_decode}(b^\ast) &=& \ERROR && (\otherwise) \\
   \end{array}


.. index:: text format
.. _embed-module-parse:

:math:`\F{module\_parse}(\char^\ast) : \module ~|~ \error`
..........................................................

1. If there exists a derivation for the :ref:`source <text-source>` :math:`\char^\ast` as a :math:`\Tmodule` according to the :ref:`text grammar for modules <text-module>`, yielding a :ref:`module <syntax-module>` :math:`m`, then return :math:`m`.

2. Else, return :math:`\ERROR`.

.. math::
   \begin{array}{lclll}
   \F{module\_parse}(c^\ast) &=& m && (\iff \Tmodule \stackrel\ast\Longrightarrow m{:}c^\ast) \\
   \F{module\_parse}(c^\ast) &=& \ERROR && (\otherwise) \\
   \end{array}


.. index:: validation
.. _embed-module-validate:

:math:`\F{module\_validate}(\module) : \error^?`
................................................

1. If :math:`\module` is :ref:`valid <valid-module>`, then return nothing.

2. Else, return :math:`\ERROR`.

.. math::
   \begin{array}{lclll}
   \F{module\_validate}(m) &=& \epsilon && (\iff {} \vdashmodule m : \externtype^\ast \to {\externtype'}^\ast) \\
   \F{module\_validate}(m) &=& \ERROR && (\otherwise) \\
   \end{array}


.. index:: instantiation, module instance
.. _embed-module-instantiate:

:math:`\F{module\_instantiate}(\store, \module, \externval^\ast) : (\store, \moduleinst ~|~ \error)`
....................................................................................................

1. Try :ref:`instantiating <exec-instantiation>` :math:`\module` in :math:`\store` with :ref:`external values <syntax-externval>` :math:`\externval^\ast` as imports:

  a. If it succeeds with a :ref:`module instance <syntax-moduleinst>` :math:`\moduleinst`, then let :math:`\X{result}` be :math:`\moduleinst`.

  b. Else, let :math:`\X{result}` be :math:`\ERROR`.

2. Return the new store paired with :math:`\X{result}`.

.. math::
   \begin{array}{lclll}
   \F{module\_instantiate}(S, m, \X{ev}^\ast) &=& (S', F.\AMODULE) && (\iff \instantiate(S, m, \X{ev}^\ast) \stepto^\ast S'; F; \epsilon) \\
   \F{module\_instantiate}(S, m, \X{ev}^\ast) &=& (S', \ERROR) && (\iff \instantiate(S, m, \X{ev}^\ast) \stepto^\ast S'; F; \TRAP) \\
   \end{array}

.. note::
   The store may be modified even in case of an error.


.. index:: import
.. _embed-module-imports:

:math:`\F{module\_imports}(\module) : (\name, \name, \externtype)^\ast`
.......................................................................

1. Pre-condition: :math:`\module` is :ref:`valid <valid-module>` with external import types :math:`\externtype^\ast` and external export types :math:`{\externtype'}^\ast`.

2. Let :math:`\import^\ast` be the :ref:`imports <syntax-import>` :math:`\module.\MIMPORTS`.

3. Assert: the length of :math:`\import^\ast` equals the length of :math:`\externtype^\ast`.

4. For each :math:`\import_i` in :math:`\import^\ast` and corresponding :math:`\externtype_i` in :math:`\externtype^\ast`, do:

  a. Let :math:`\X{result}_i` be the triple :math:`(\import_i.\IMODULE, \import_i.\INAME, \externtype_i)`.

5. Return the concatenation of all :math:`\X{result}_i`, in index order.

6. Post-condition: each :math:`\externtype_i` is :ref:`valid <valid-externtype>`.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{module\_imports}(m) &=& (\X{im}.\IMODULE, \X{im}.\INAME, \externtype)^\ast \\
     && \qquad (\iff \X{im}^\ast = m.\MIMPORTS \wedge {} \vdashmodule m : \externtype^\ast \to {\externtype'}^\ast) \\
   \end{array}


.. index:: export
.. _embed-module-exports:

:math:`\F{module\_exports}(\module) : (\name, \externtype)^\ast`
................................................................

1. Pre-condition: :math:`\module` is :ref:`valid <valid-module>` with external import types :math:`\externtype^\ast` and external export types :math:`{\externtype'}^\ast`.

2. Let :math:`\export^\ast` be the :ref:`exports <syntax-export>` :math:`\module.\MEXPORTS`.

3. Assert: the length of :math:`\export^\ast` equals the length of :math:`{\externtype'}^\ast`.

4. For each :math:`\export_i` in :math:`\export^\ast` and corresponding :math:`\externtype'_i` in :math:`{\externtype'}^\ast`, do:

  a. Let :math:`\X{result}_i` be the pair :math:`(\export_i.\ENAME, \externtype'_i)`.

5. Return the concatenation of all :math:`\X{result}_i`, in index order.

6. Post-condition: each :math:`\externtype'_i` is :ref:`valid <valid-externtype>`.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{module\_exports}(m) &=& (\X{ex}.\ENAME, \externtype')^\ast \\
     && \qquad (\iff \X{ex}^\ast = m.\MEXPORTS \wedge {} \vdashmodule m : \externtype^\ast \to {\externtype'}^\ast) \\
   \end{array}


.. index:: module, module instance
.. _embed-instance:

Module Instances
~~~~~~~~~~~~~~~~

.. index:: export, export instance

.. _embed-instance-export:

:math:`\F{instance\_export}(\moduleinst, \name) : \externval ~|~ \error`
........................................................................

1. Assert: due to :ref:`validity <valid-moduleinst>` of the :ref:`module instance <syntax-moduleinst>` :math:`\moduleinst`, all its :ref:`export names <syntax-exportinst>` are different.

2. If there exists an :math:`\exportinst_i` in :math:`\moduleinst.\MIEXPORTS` such that :ref:`name <syntax-name>` :math:`\exportinst_i.\EINAME` equals :math:`\name`, then:

   a. Return the :ref:`external value <syntax-externval>` :math:`\exportinst_i.\EIVALUE`.

3. Else, return :math:`\ERROR`.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{instance\_export}(m, \name) &=& m.\MIEXPORTS[i].\EIVALUE && (\iff m.\MEXPORTS[i].\EINAME = \name) \\
   \F{instance\_export}(m, \name) &=& \ERROR && (\otherwise) \\
   \end{array}


.. index:: function, host function, function address, function instance, function type, store
.. _embed-func:

Functions
~~~~~~~~~

.. _embed-func-alloc:

:math:`\F{func\_alloc}(\store, \functype, \hostfunc) : (\store, \funcaddr)`
...........................................................................

1. Pre-condition: :math:`\functype` is :ref:`valid <valid-functype>`.

2. Let :math:`\funcaddr` be the result of :ref:`allocating a host function <alloc-func>` in :math:`\store` with :ref:`function type <syntax-functype>` :math:`\functype` and host function code :math:`\hostfunc`.

3. Return the new store paired with :math:`\funcaddr`.

.. math::
   \begin{array}{lclll}
   \F{func\_alloc}(S, \X{ft}, \X{code}) &=& (S', \X{a}) && (\iff \allochostfunc(S, \X{ft}, \X{code}) = S', \X{a}) \\
   \end{array}

.. note::
   This operation assumes that :math:`\hostfunc` satisfies the :ref:`pre- and post-conditions <exec-invoke-host>` required for a function instance with type :math:`\functype`.

   Regular (non-host) function instances can only be created indirectly through :ref:`module instantiation <embed-module-instantiate>`.


.. _embed-func-type:

:math:`\F{func\_type}(\store, \funcaddr) : \functype`
.....................................................

1. Return :math:`S.\SFUNCS[a].\FITYPE`.

2. Post-condition: the returned :ref:`function type <syntax-functype>` is :ref:`valid <valid-functype>`.

.. math::
   \begin{array}{lclll}
   \F{func\_type}(S, a) &=& S.\SFUNCS[a].\FITYPE \\
   \end{array}


.. index:: invocation, value, result
.. _embed-func-invoke:

:math:`\F{func\_invoke}(\store, \funcaddr, \val^\ast) : (\store, \val^\ast ~|~ \error)`
........................................................................................

1. Try :ref:`invoking <exec-invocation>` the function :math:`\funcaddr` in :math:`\store` with :ref:`values <syntax-val>` :math:`\val^\ast` as arguments:

  a. If it succeeds with :ref:`values <syntax-val>` :math:`{\val'}^\ast` as results, then let :math:`\X{result}` be :math:`{\val'}^\ast`.

  b. Else it has trapped, hence let :math:`\X{result}` be :math:`\ERROR`.

2. Return the new store paired with :math:`\X{result}`.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{func\_invoke}(S, a, v^\ast) &=& (S', {v'}^\ast) && (\iff \invoke(S, a, v^\ast) \stepto^\ast S'; F; {v'}^\ast) \\
   \F{func\_invoke}(S, a, v^\ast) &=& (S', \ERROR) && (\iff \invoke(S, a, v^\ast) \stepto^\ast S'; F; \TRAP) \\
   \end{array}

.. note::
   The store may be modified even in case of an error.


.. index:: table, table address, store, table instance, table type, element, function address
.. _embed-table:

Tables
~~~~~~

.. _embed-table-alloc:

:math:`\F{table\_alloc}(\store, \tabletype) : (\store, \tableaddr, \reff)`
..........................................................................

1. Pre-condition: :math:`\tabletype` is :ref:`valid <valid-tabletype>`.

2. Let :math:`\tableaddr` be the result of :ref:`allocating a table <alloc-table>` in :math:`\store` with :ref:`table type <syntax-tabletype>` :math:`\tabletype` and initialization value :math:`\reff`.

3. Return the new store paired with :math:`\tableaddr`.

.. math::
   \begin{array}{lclll}
   \F{table\_alloc}(S, \X{tt}, r) &=& (S', \X{a}) && (\iff \alloctable(S, \X{tt}, r) = S', \X{a}) \\
   \end{array}


.. _embed-table-type:

:math:`\F{table\_type}(\store, \tableaddr) : \tabletype`
........................................................

1. Return :math:`S.\STABLES[a].\TITYPE`.

2. Post-condition: the returned :ref:`table type <syntax-tabletype>` is :ref:`valid <valid-tabletype>`.

.. math::
   \begin{array}{lclll}
   \F{table\_type}(S, a) &=& S.\STABLES[a].\TITYPE \\
   \end{array}


.. _embed-table-read:

:math:`\F{table\_read}(\store, \tableaddr, i:\u32) : \reff ~|~ \error`
......................................................................

1. Let :math:`\X{ti}` be the :ref:`table instance <syntax-tableinst>` :math:`\store.\STABLES[\tableaddr]`.

2. If :math:`i` is larger than or equal to the length of :math:`\X{ti}.\TIELEM`, then return :math:`\ERROR`.

3. Else, return the :ref:`reference value <syntax-ref>` :math:`\X{ti}.\TIELEM[i]`.

.. math::
   \begin{array}{lclll}
   \F{table\_read}(S, a, i) &=& r && (\iff S.\STABLES[a].\TIELEM[i] = r) \\
   \F{table\_read}(S, a, i) &=& \ERROR && (\otherwise) \\
   \end{array}


.. _embed-table-write:

:math:`\F{table\_write}(\store, \tableaddr, i:\u32, \reff) : \store ~|~ \error`
...............................................................................

1. Let :math:`\X{ti}` be the :ref:`table instance <syntax-tableinst>` :math:`\store.\STABLES[\tableaddr]`.

2. If :math:`i` is larger than or equal to the length of :math:`\X{ti}.\TIELEM`, then return :math:`\ERROR`.

3. Replace :math:`\X{ti}.\TIELEM[i]` with the :ref:`reference value <syntax-ref>` :math:`\reff`.

4. Return the updated store.

.. math::
   \begin{array}{lclll}
   \F{table\_write}(S, a, i, r) &=& S' && (\iff S' = S \with \STABLES[a].\TIELEM[i] = r) \\
   \F{table\_write}(S, a, i, r) &=& \ERROR && (\otherwise) \\
   \end{array}


.. _embed-table-size:

:math:`\F{table\_size}(\store, \tableaddr) : \u32`
..................................................

1. Return the length of :math:`\store.\STABLES[\tableaddr].\TIELEM`.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{table\_size}(S, a) &=& n &&
     (\iff |S.\STABLES[a].\TIELEM| = n) \\
   \end{array}



.. _embed-table-grow:

:math:`\F{table\_grow}(\store, \tableaddr, n:\u32, \reff) : \store ~|~ \error`
..............................................................................

1. Try :ref:`growing <grow-table>` the :ref:`table instance <syntax-tableinst>` :math:`\store.\STABLES[\tableaddr]` by :math:`n` elements with initialization value :math:`\reff`:

   a. If it succeeds, return the updated store.

   b. Else, return :math:`\ERROR`.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{table\_grow}(S, a, n, r) &=& S' &&
     (\iff S' = S \with \STABLES[a] = \growtable(S.\STABLES[a], n, r)) \\
   \F{table\_grow}(S, a, n, r) &=& \ERROR && (\otherwise) \\
   \end{array}


.. index:: memory, memory address, store, memory instance, memory type, byte
.. _embed-mem:

Memories
~~~~~~~~

.. _embed-mem-alloc:

:math:`\F{mem\_alloc}(\store, \memtype) : (\store, \memaddr)`
................................................................

1. Pre-condition: :math:`\memtype` is :ref:`valid <valid-memtype>`.

2. Let :math:`\memaddr` be the result of :ref:`allocating a memory <alloc-mem>` in :math:`\store` with :ref:`memory type <syntax-memtype>` :math:`\memtype`.

3. Return the new store paired with :math:`\memaddr`.

.. math::
   \begin{array}{lclll}
   \F{mem\_alloc}(S, \X{mt}) &=& (S', \X{a}) && (\iff \allocmem(S, \X{mt}) = S', \X{a}) \\
   \end{array}


.. _embed-mem-type:

:math:`\F{mem\_type}(\store, \memaddr) : \memtype`
..................................................

1. Return :math:`S.\SMEMS[a].\MITYPE`.

2. Post-condition: the returned :ref:`memory type <syntax-memtype>` is :ref:`valid <valid-memtype>`.

.. math::
   \begin{array}{lclll}
   \F{mem\_type}(S, a) &=& S.\SMEMS[a].\MITYPE \\
   \end{array}


.. _embed-mem-read:

:math:`\F{mem\_read}(\store, \memaddr, i:\u32) : \byte ~|~ \error`
..................................................................

1. Let :math:`\X{mi}` be the :ref:`memory instance <syntax-meminst>` :math:`\store.\SMEMS[\memaddr]`.

2. If :math:`i` is larger than or equal to the length of :math:`\X{mi}.\MIDATA`, then return :math:`\ERROR`.

3. Else, return the  :ref:`byte <syntax-byte>` :math:`\X{mi}.\MIDATA[i]`.

.. math::
   \begin{array}{lclll}
   \F{mem\_read}(S, a, i) &=& b && (\iff S.\SMEMS[a].\MIDATA[i] = b) \\
   \F{mem\_read}(S, a, i) &=& \ERROR && (\otherwise) \\
   \end{array}


.. _embed-mem-write:

:math:`\F{mem\_write}(\store, \memaddr, i:\u32, \byte) : \store ~|~ \error`
...........................................................................

1. Let :math:`\X{mi}` be the :ref:`memory instance <syntax-meminst>` :math:`\store.\SMEMS[\memaddr]`.

2. If :math:`\u32` is larger than or equal to the length of :math:`\X{mi}.\MIDATA`, then return :math:`\ERROR`.

3. Replace :math:`\X{mi}.\MIDATA[i]` with :math:`\byte`.

4. Return the updated store.

.. math::
   \begin{array}{lclll}
   \F{mem\_write}(S, a, i, b) &=& S' && (\iff S' = S \with \SMEMS[a].\MIDATA[i] = b) \\
   \F{mem\_write}(S, a, i, b) &=& \ERROR && (\otherwise) \\
   \end{array}


.. _embed-mem-size:

:math:`\F{mem\_size}(\store, \memaddr) : \u32`
..............................................

1. Return the length of :math:`\store.\SMEMS[\memaddr].\MIDATA` divided by the :ref:`page size <page-size>`.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{mem\_size}(S, a) &=& n &&
     (\iff |S.\SMEMS[a].\MIDATA| = n \cdot 64\,\F{Ki}) \\
   \end{array}



.. _embed-mem-grow:

:math:`\F{mem\_grow}(\store, \memaddr, n:\u32) : \store ~|~ \error`
...................................................................

1. Try :ref:`growing <grow-mem>` the :ref:`memory instance <syntax-meminst>` :math:`\store.\SMEMS[\memaddr]` by :math:`n` :ref:`pages <page-size>`:

   a. If it succeeds, return the updated store.

   b. Else, return :math:`\ERROR`.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{mem\_grow}(S, a, n) &=& S' &&
     (\iff S' = S \with \SMEMS[a] = \growmem(S.\SMEMS[a], n)) \\
   \F{mem\_grow}(S, a, n) &=& \ERROR && (\otherwise) \\
   \end{array}



.. index:: global, global address, store, global instance, global type, value
.. _embed-global:

Globals
~~~~~~~

.. _embed-global-alloc:

:math:`\F{global\_alloc}(\store, \globaltype, \val) : (\store, \globaladdr)`
............................................................................

1. Pre-condition: :math:`\globaltype` is :ref:`valid <valid-globaltype>`.

2. Let :math:`\globaladdr` be the result of :ref:`allocating a global <alloc-global>` in :math:`\store` with :ref:`global type <syntax-globaltype>` :math:`\globaltype` and initialization value :math:`\val`.

3. Return the new store paired with :math:`\globaladdr`.

.. math::
   \begin{array}{lclll}
   \F{global\_alloc}(S, \X{gt}, v) &=& (S', \X{a}) && (\iff \allocglobal(S, \X{gt}, v) = S', \X{a}) \\
   \end{array}


.. _embed-global-type:

:math:`\F{global\_type}(\store, \globaladdr) : \globaltype`
...........................................................

1. Return :math:`S.\SGLOBALS[a].\GITYPE`.

2. Post-condition: the returned :ref:`global type <syntax-globaltype>` is :ref:`valid <valid-globaltype>`.

.. math::
   \begin{array}{lclll}
   \F{global\_type}(S, a) &=& S.\SGLOBALS[a].\GITYPE \\
   \end{array}


.. _embed-global-read:

:math:`\F{global\_read}(\store, \globaladdr) : \val`
....................................................

1. Let :math:`\X{gi}` be the :ref:`global instance <syntax-globalinst>` :math:`\store.\SGLOBALS[\globaladdr]`.

2. Return the :ref:`value <syntax-val>` :math:`\X{gi}.\GIVALUE`.

.. math::
   \begin{array}{lclll}
   \F{global\_read}(S, a) &=& v && (\iff S.\SGLOBALS[a].\GIVALUE = v) \\
   \end{array}


.. _embed-global-write:

:math:`\F{global\_write}(\store, \globaladdr, \val) : \store ~|~ \error`
........................................................................

1. Let :math:`\X{gi}` be the :ref:`global instance <syntax-globalinst>` :math:`\store.\SGLOBALS[\globaladdr]`.

2. Let :math:`\mut~t` be the structure of the :ref:`global type <syntax-globaltype>` :math:`\X{gi}.\GITYPE`.

3. If :math:`\mut` is not :math:`\MVAR`, then return :math:`\ERROR`.

4. Replace :math:`\X{gi}.\GIVALUE` with the :ref:`value <syntax-val>` :math:`\val`.

5. Return the updated store.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{global\_write}(S, a, v) &=& S' && (\iff S.\SGLOBALS[a].\GITYPE = \MVAR~t \wedge S' = S \with \SGLOBALS[a].\GIVALUE = v) \\
   \F{global\_write}(S, a, v) &=& \ERROR && (\otherwise) \\
   \end{array}

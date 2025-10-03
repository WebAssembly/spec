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

For numeric parameters, notation like :math:`i:\u64` is used to specify a symbolic name in addition to the respective value range.


.. _embed-bool:

Booleans
~~~~~~~~

Interface operation that are predicates return Boolean values:

.. math::
   \begin{array}{llll}
   \production{Boolean} & \bool &::=& \FALSE ~|~ \TRUE \\
   \end{array}


.. _embed-error:

Exceptions and Errors
~~~~~~~~~~~~~~~~~~~~~

Invoking an exported function may throw or propagate exceptions, expressed by an auxiliary syntactic class:

.. math::
   \begin{array}{llll}
   \production{exception} & \exception &::=& \EXCEPTION~\exnaddr \\
   \end{array}

The exception address :math:`exnaddr` identifies the exception thrown.

Failure of an interface operation is also indicated by an auxiliary syntactic class:

.. math::
   \begin{array}{llll}
   \production{error} & \error &::=& \ERROR \\
   \end{array}

In addition to the error conditions specified explicitly in this section, such as invalid arguments or :ref:`exceptions <exception>` and :ref:`traps <trap>` resulting from :ref:`execution <exec>`, implementations may also return errors when specific :ref:`implementation limitations <impl>` are reached.

.. note::
   Errors are abstract and unspecific with this definition.
   Implementations can refine it to carry suitable classifications and diagnostic messages.




Pre- and Post-Conditions
~~~~~~~~~~~~~~~~~~~~~~~~

Some operations state *pre-conditions* about their arguments or *post-conditions* about their results.
It is the embedder's responsibility to meet the pre-conditions.
If it does, the post conditions are guaranteed by the semantics.

In addition to pre- and post-conditions explicitly stated with each operation, the specification adopts the following conventions for :ref:`runtime objects <syntax-runtime>` (:math:`\store`, :math:`\moduleinst`, :ref:`addresses <syntax-addr>`):

* Every runtime object passed as a parameter must be :ref:`valid <valid-store>` per an implicit pre-condition.

* Every runtime object returned as a result is :ref:`valid <valid-store>` per an implicit post-condition.

.. note::
   As long as an embedder treats runtime objects as abstract and only creates and manipulates them through the interface defined here, all implicit pre-conditions are automatically met.



.. index:: allocation, store
.. _embed-store:

Store
~~~~~

.. _embed-store-init:

:math:`\F{store\_init}() : \store`
..................................

1. Return the empty :ref:`store <syntax-store>`.

.. math::
   \begin{array}{lclll}
   \F{store\_init}() &=& \{ \} \\
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
   \F{module\_validate}(m) &=& \epsilon && (\iff {} \vdashmodule m : \externtype^\ast \rightarrow {\externtype'}^\ast) \\
   \F{module\_validate}(m) &=& \ERROR && (\otherwise) \\
   \end{array}


.. index:: instantiation, module instance
.. _embed-module-instantiate:

:math:`\F{module\_instantiate}(\store, \module, \externaddr^\ast) : (\store, \moduleinst ~|~ \exception ~|~ \error)`
....................................................................................................................

1. Try :ref:`instantiating <exec-instantiation>` :math:`\module` in :math:`\store` with :ref:`external addresses <syntax-externaddr>` :math:`\externaddr^\ast` as imports:

  a. If it succeeds with a :ref:`module instance <syntax-moduleinst>` :math:`\moduleinst`, then let :math:`\X{result}` be :math:`\moduleinst`.

  b. Else, let :math:`\X{result}` be :math:`\ERROR`.

2. Return the new store paired with :math:`\X{result}`.

.. math::
   \begin{array}{lclll}
   \F{module\_instantiate}(S, m, \X{ev}^\ast) &=& (S', F.\AMODULE) && (\iff \instantiate(S, m, \X{ev}^\ast) \stepto^\ast S'; F; \epsilon) \\
   \F{module\_instantiate}(S, m, \X{ev}^\ast) &=& (S', \ERROR) && (\otherwise, \iff \instantiate(S, m, \X{ev}^\ast) \stepto^\ast S'; F; \result) \\
   \end{array}

.. note::
   The store may be modified even in case of an error.


.. index:: import
.. _embed-module-imports:

:math:`\F{module\_imports}(\module) : (\name, \name, \externtype)^\ast`
.......................................................................

1. Pre-condition: :math:`\module` is :ref:`valid <valid-module>` with the external import types :math:`\externtype^\ast` and external export types :math:`{\externtype'}^\ast`.

2. Let :math:`\import^\ast` be the :ref:`imports <syntax-import>` of :math:`\module`.

3. Assert: the length of :math:`\import^\ast` equals the length of :math:`\externtype^\ast`.

4. For each :math:`\import_i` in :math:`\import^\ast` and corresponding :math:`\externtype_i` in :math:`\externtype^\ast`, do:

  a. Let :math:`\IMPORT~\X{nm}_{i1}~\X{nm}_{i2}~\X{xt}_i` be the deconstruction of :math:`\import_i`.

  b. Let :math:`\X{result}_i` be the triple :math:`(\X{nm}_{i1}, \X{nm}_{i2}, \externtype_i)`.

5. Return the concatenation of all :math:`\X{result}_i`, in index order.

6. Post-condition: each :math:`\externtype_i` is :ref:`valid <valid-externtype>` under the empty :ref:`context <context>`.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{module\_imports}(m) &=& (\X{nm}_1, \X{nm}_2, \externtype)^\ast \\
     && \qquad (\iff (\IMPORT~\X{nm}_1~\X{nm}_2~\X{xt}^\ast)^\ast \in m \wedge {} \vdashmodule m : \externtype^\ast \rightarrow {\externtype'}^\ast) \\
   \end{array}


.. index:: export
.. _embed-module-exports:

:math:`\F{module\_exports}(\module) : (\name, \externtype)^\ast`
................................................................

1. Pre-condition: :math:`\module` is :ref:`valid <valid-module>` with the external import types :math:`\externtype^\ast` and external export types :math:`{\externtype'}^\ast`.

2. Let :math:`\export^\ast` be the :ref:`exports <syntax-export>` of :math:`\module`.

3. Assert: the length of :math:`\export^\ast` equals the length of :math:`{\externtype'}^\ast`.

4. For each :math:`\export_i` in :math:`\export^\ast` and corresponding :math:`\externtype'_i` in :math:`{\externtype'}^\ast`, do:

  a. Let :math:`\EXPORT~\X{nm}_i~\externidx_i` be the deconstruction of :math:`\export_i`.

  b. Let :math:`\X{result}_i` be the pair :math:`(\X{nm}_i, \externtype'_i)`.

5. Return the concatenation of all :math:`\X{result}_i`, in index order.

6. Post-condition: each :math:`\externtype'_i` is :ref:`valid <valid-externtype>` under the empty :ref:`context <context>`.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{module\_exports}(m) &=& (\\X{nm}, \externtype')^\ast \\
     && \qquad (\iff (\EXPORT~\X{nm}~\X{xt}^\ast)^\ast \in m \wedge {} \vdashmodule m : \externtype^\ast \rightarrow {\externtype'}^\ast) \\
   \end{array}


.. index:: module, module instance
.. _embed-instance:

Module Instances
~~~~~~~~~~~~~~~~

.. index:: export, export instance

.. _embed-instance-export:

:math:`\F{instance\_export}(\moduleinst, \name) : \externaddr ~|~ \error`
.........................................................................

1. Assert: due to :ref:`validity <valid-moduleinst>` of the :ref:`module instance <syntax-moduleinst>` :math:`\moduleinst`, all its :ref:`export names <syntax-exportinst>` are different.

2. If there exists an :math:`\exportinst_i` in :math:`\moduleinst.\MIEXPORTS` such that :ref:`name <syntax-name>` :math:`\exportinst_i.\XINAME` equals :math:`\name`, then:

   a. Return the :ref:`external address <syntax-externaddr>` :math:`\exportinst_i.\XIADDR`.

3. Else, return :math:`\ERROR`.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{instance\_export}(m, \name) &=& m.\MIEXPORTS[i].\XIADDR && (\iff m.\MIEXPORTS[i].\XINAME = \name) \\
   \F{instance\_export}(m, \name) &=& \ERROR && (\otherwise) \\
   \end{array}


.. index:: function, host function, function address, function instance, function type, store
.. _embed-func:

Functions
~~~~~~~~~

.. _embed-func-alloc:

:math:`\F{func\_alloc}(\store, \deftype, \hostfunc) : (\store, \funcaddr)`
..........................................................................

1. Pre-condition: the :ref:`defined type <syntax-deftype>` :math:`\deftype` is :ref:`valid <valid-deftype>` under the empty :ref:`context <context>` and :ref:`expands <aux-expand-deftype>` to a :ref:`function type <syntax-functype>`.

2. Let :math:`\funcaddr` be the result of :ref:`allocating a host function <alloc-func>` in :math:`\store` with :ref:`defined type <syntax-deftype>` :math:`\deftype`, host function code :math:`\hostfunc` and an empty :ref:`module instance <syntax-moduleinst>`.

3. Return the new store paired with :math:`\funcaddr`.

.. math::
   \begin{array}{lclll}
   \F{func\_alloc}(S, \X{dt}, \X{code}) &=& (S', \X{a})
     && (\begin{array}{@{}l@{}}
       \iff \allocfunc(S, \X{dt}, \X{code}, \{\}) = S', \X{a}) \\
       \end{array} \\
   \end{array}

.. note::
   This operation assumes that :math:`\hostfunc` satisfies the :ref:`pre- and post-conditions <exec-invoke-host>` required for a function instance with type :math:`\deftype`.

   Regular (non-host) function instances can only be created indirectly through :ref:`module instantiation <embed-module-instantiate>`.


.. _embed-func-type:

:math:`\F{func\_type}(\store, \funcaddr) : \deftype`
....................................................

1. Let :math:`\deftype` be the :ref:`definedn type <syntax-deftype>` :math:`S.\SFUNCS[a].\FITYPE`.

2. Return :math:`\deftype`.

3. Post-condition: the returned :ref:`defined type <syntax-deftype>` is :ref:`valid <valid-deftype>` and :ref:`expands <aux-expand-deftype>` to a :ref:`function type <syntax-functype>`.

.. math::
   \begin{array}{lclll}
   \F{func\_type}(S, a) &=& S.\SFUNCS[a].\FITYPE \\
   \end{array}


.. index:: invocation, value, result
.. _embed-func-invoke:

:math:`\F{func\_invoke}(\store, \funcaddr, \val^\ast) : (\store, \val^\ast ~|~ \exception ~|~ \error)`
......................................................................................................

1. Try :ref:`invoking <exec-invocation>` the function :math:`\funcaddr` in :math:`\store` with :ref:`values <syntax-val>` :math:`\val^\ast` as arguments:

  a. If it succeeds with :ref:`values <syntax-val>` :math:`{\val'}^\ast` as results, then let :math:`\X{result}` be :math:`{\val'}^\ast`.

  b. Else if the outcome is an exception with a thrown :ref:`exception <exec-throw_ref>` :math:`\REFEXNADDR~\exnaddr` as the result, then let :math:`\X{result}` be :math:`\EXCEPTION~\exnaddr`

  c. Else it has trapped, hence let :math:`\X{result}` be :math:`\ERROR`.

2. Return the new store paired with :math:`\X{result}`.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{func\_invoke}(S, a, v^\ast) &=& (S', {v'}^\ast) && (\iff \invoke(S, a, v^\ast) \stepto^\ast S'; F; {v'}^\ast) \\
   \F{func\_invoke}(S, a, v^\ast) &=& (S', \EXCEPTION~a') && (\iff \invoke(S, a, v^\ast) \stepto^\ast S'; F; (\REFEXNADDR~a')~\THROWREF \\
   \F{func\_invoke}(S, a, v^\ast) &=& (S', \ERROR) && (\iff \invoke(S, a, v^\ast) \stepto^\ast S'; F; \TRAP) \\
   \end{array}

.. note::
   The store may be modified even in case of an error.


.. index:: table, table address, store, table instance, table type, element, function address
.. _embed-table:

Tables
~~~~~~

.. _embed-table-alloc:

:math:`\F{table\_alloc}(\store, \tabletype, \reff) : (\store, \tableaddr)`
..........................................................................

1. Pre-condition: the :math:`\tabletype` is :ref:`valid <valid-tabletype>` under the empty :ref:`context <context>`.

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

2. Post-condition: the returned :ref:`table type <syntax-tabletype>` is :ref:`valid <valid-tabletype>` under the empty :ref:`context <context>`.

.. math::
   \begin{array}{lclll}
   \F{table\_type}(S, a) &=& S.\STABLES[a].\TITYPE \\
   \end{array}


.. _embed-table-read:

:math:`\F{table\_read}(\store, \tableaddr, i:\u64) : \reff ~|~ \error`
......................................................................

1. Let :math:`\X{ti}` be the :ref:`table instance <syntax-tableinst>` :math:`\store.\STABLES[\tableaddr]`.

2. If :math:`i` is larger than or equal to the length of :math:`\X{ti}.\TIREFS`, then return :math:`\ERROR`.

3. Else, return the :ref:`reference value <syntax-ref>` :math:`\X{ti}.\TIREFS[i]`.

.. math::
   \begin{array}{lclll}
   \F{table\_read}(S, a, i) &=& r && (\iff S.\STABLES[a].\TIREFS[i] = r) \\
   \F{table\_read}(S, a, i) &=& \ERROR && (\otherwise) \\
   \end{array}


.. _embed-table-write:

:math:`\F{table\_write}(\store, \tableaddr, i:\u64, \reff) : \store ~|~ \error`
...............................................................................

1. Let :math:`\X{ti}` be the :ref:`table instance <syntax-tableinst>` :math:`\store.\STABLES[\tableaddr]`.

2. If :math:`i` is larger than or equal to the length of :math:`\X{ti}.\TIREFS`, then return :math:`\ERROR`.

3. Replace :math:`\X{ti}.\TIREFS[i]` with the :ref:`reference value <syntax-ref>` :math:`\reff`.

4. Return the updated store.

.. math::
   \begin{array}{lclll}
   \F{table\_write}(S, a, i, r) &=& S' && (\iff S' = S \with \STABLES[a].\TIREFS[i] = r) \\
   \F{table\_write}(S, a, i, r) &=& \ERROR && (\otherwise) \\
   \end{array}


.. _embed-table-size:

:math:`\F{table\_size}(\store, \tableaddr) : \u64`
..................................................

1. Return the length of :math:`\store.\STABLES[\tableaddr].\TIREFS`.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{table\_size}(S, a) &=& n &&
     (\iff |S.\STABLES[a].\TIREFS| = n) \\
   \end{array}



.. _embed-table-grow:

:math:`\F{table\_grow}(\store, \tableaddr, n:\u64, \reff) : \store ~|~ \error`
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

1. Pre-condition: the :math:`\memtype` is :ref:`valid <valid-memtype>` under the empty :ref:`context <context>`.

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

2. Post-condition: the returned :ref:`memory type <syntax-memtype>` is :ref:`valid <valid-memtype>` under the empty :ref:`context <context>`.

.. math::
   \begin{array}{lclll}
   \F{mem\_type}(S, a) &=& S.\SMEMS[a].\MITYPE \\
   \end{array}


.. _embed-mem-read:

:math:`\F{mem\_read}(\store, \memaddr, i:\u64) : \byte ~|~ \error`
..................................................................

1. Let :math:`\X{mi}` be the :ref:`memory instance <syntax-meminst>` :math:`\store.\SMEMS[\memaddr]`.

2. If :math:`i` is larger than or equal to the length of :math:`\X{mi}.\MIBYTES`, then return :math:`\ERROR`.

3. Else, return the  :ref:`byte <syntax-byte>` :math:`\X{mi}.\MIBYTES[i]`.

.. math::
   \begin{array}{lclll}
   \F{mem\_read}(S, a, i) &=& b && (\iff S.\SMEMS[a].\MIBYTES[i] = b) \\
   \F{mem\_read}(S, a, i) &=& \ERROR && (\otherwise) \\
   \end{array}


.. _embed-mem-write:

:math:`\F{mem\_write}(\store, \memaddr, i:\u64, \byte) : \store ~|~ \error`
...........................................................................

1. Let :math:`\X{mi}` be the :ref:`memory instance <syntax-meminst>` :math:`\store.\SMEMS[\memaddr]`.

2. If :math:`i` is larger than or equal to the length of :math:`\X{mi}.\MIBYTES`, then return :math:`\ERROR`.

3. Replace :math:`\X{mi}.\MIBYTES[i]` with :math:`\byte`.

4. Return the updated store.

.. math::
   \begin{array}{lclll}
   \F{mem\_write}(S, a, i, b) &=& S' && (\iff S' = S \with \SMEMS[a].\MIBYTES[i] = b) \\
   \F{mem\_write}(S, a, i, b) &=& \ERROR && (\otherwise) \\
   \end{array}


.. _embed-mem-size:

:math:`\F{mem\_size}(\store, \memaddr) : \u64`
..............................................

1. Return the length of :math:`\store.\SMEMS[\memaddr].\MIBYTES` divided by the :ref:`page size <page-size>`.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{mem\_size}(S, a) &=& n &&
     (\iff |S.\SMEMS[a].\MIBYTES| = n \cdot 64\,\F{Ki}) \\
   \end{array}



.. _embed-mem-grow:

:math:`\F{mem\_grow}(\store, \memaddr, n:\u64) : \store ~|~ \error`
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


.. index:: tag, tag address, store, tag instance, tag type, function type
.. _embed-tag:

Tags
~~~~

.. _embedd-tag-alloc:

:math:`\F{tag\_alloc}(\store, \tagtype) : (\store, \tagaddr)`
.............................................................

1. Pre-condition: :math:`tagtype` is :ref:`valid <valid-tagtype>`.

2. Let :math:`\tagaddr` be the result of :ref:`allocating a tag <alloc-tag>` in :math:`\store` with :ref:`tag type <syntax-tagtype>` :math:`\tagtype`.

3. Return the new store paired with :math:`\tagaddr`.

.. math::
   \begin{array}{lclll}
   \F{tag\_alloc}(S, \X{tt}) &=& (S', \X{a}) && (\iff \alloctag(S, \X{tt}) = S', \X{a}) \\
   \end{array}


.. _embed-tag-type:

:math:`\F{tag\_type}(\store, \tagaddr) : \tagtype`
..................................................

1. Return :math:`S.\STAGS[a].\HITYPE`.

2. Post-condition: the returned :ref:`tag type <syntax-tagtype>` is :ref:`valid  <valid-tagtype>`.

.. math::
   \begin{array}{lclll}
   \F{tag\_type}(S, a) &=& S.\STAGS[a].\HITYPE \\
   \end{array}


.. index:: exception, exception address, store, exception instance, exception type
.. _embed-exception:

Exceptions
~~~~~~~~~~

.. _embed-exn-alloc:

:math:`\F{exn\_alloc}(\store, \tagaddr, \val^\ast) : (\store, \exnaddr)`
........................................................................

1. Pre-condition: :math:`\tagaddr` is an allocated :ref:`tag address <syntax-tagaddr>`.

2. Let :math:`\exnaddr` be the result of :ref:`allocating an exception instance <syntax-exninst>` in :math:`\store` with :ref:`tag address <syntax-tagaddr>` :math:`\tagaddr` and initialization values :math:`\val^\ast`.

3. Return the new store paired with :math:`\exnaddr`.

.. math::
   \begin{array}{lcll}
   \F{exn\_alloc}(S, \tagaddr, \val^\ast) &=& (S \compose \{\SEXNS~\exninst\}, |S.\SEXNS|) &
     (\iff \exninst = \{\EITAG~\tagaddr, \EIFIELDS~\val^\ast\} \\
   \end{array}


.. _embed-exn-tag:

:math:`\F{exn\_tag}(\store, \exnaddr) : \tagaddr`
.................................................

1. Let :math:`\exninst` be the :ref:`exception instance <syntax-exninst>` :math:`\store.\SEXNS[\exnaddr]`.

2. Return the :ref:`tag address <syntax-tagaddr>` :math:`\exninst.\EITAG`.

.. math::
   \begin{array}{lcll}
   \F{exn\_tag}(S, a) &=& \exninst.\EITAG &
     (\iff \exninst = S.\SEXNS[a]) \\
   \end{array}


.. _embed-exn-read:

:math:`\F{exn\_read}(\store, \exnaddr) : \val^\ast`
...................................................

1. Let :math:`\exninst` be the :ref:`exception instance <syntax-exninst>` :math:`\store.\SEXNS[\exnaddr]`.

2. Return the :ref:`values <syntax-val>` :math:`\exninst.\EIFIELDS`.

.. math::
   \begin{array}{lcll}
   \F{exn\_read}(S, a) &=& \exninst.\EIFIELDS &
     (\iff \exninst = S.\SEXNS[a]) \\
   \end{array}


.. index:: global, global address, store, global instance, global type, value
.. _embed-global:

Globals
~~~~~~~

.. _embed-global-alloc:

:math:`\F{global\_alloc}(\store, \globaltype, \val) : (\store, \globaladdr)`
............................................................................

1. Pre-condition: the :math:`\globaltype` is :ref:`valid <valid-globaltype>` under the empty :ref:`context <context>`.

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

2. Post-condition: the returned :ref:`global type <syntax-globaltype>` is :ref:`valid <valid-globaltype>` under the empty :ref:`context <context>`.

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

3. If :math:`\mut` is empty, then return :math:`\ERROR`.

4. Replace :math:`\X{gi}.\GIVALUE` with the :ref:`value <syntax-val>` :math:`\val`.

5. Return the updated store.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{global\_write}(S, a, v) &=& S' && (\iff S.\SGLOBALS[a].\GITYPE = \TMUT~t \wedge S' = S \with \SGLOBALS[a].\GIVALUE = v) \\
   \F{global\_write}(S, a, v) &=& \ERROR && (\otherwise) \\
   \end{array}


.. index:: reference, reference type, value type, value
.. _embed-ref-type:
.. _embed-val-default:

Values
~~~~~~

:math:`\F{ref\_type}(\store, \reff) : \reftype`
...............................................

1. Pre-condition: the :ref:`reference <syntax-ref>` :math:`\reff` is :ref:`valid <valid-val>` under store :math:`S`.

2. Return the :ref:`reference type <syntax-reftype>` :math:`t` with which :math:`\reff` is valid.

3. Post-condition: the returned :ref:`reference type <syntax-reftype>` is :ref:`valid <valid-reftype>` under the empty :ref:`context <context>`.

.. math::
   \begin{array}{lclll}
   \F{ref\_type}(S, r) &=& t && (\iff S \vdashval r : t) \\
   \end{array}

.. note::
   In future versions of WebAssembly,
   not all references may carry precise type information at run time.
   In such cases, this function may return a less precise supertype.


:math:`\F{val\_default}(\valtype) : \val`
...............................................

1. If :math:`\default_{valtype}` is not defined, then return :math:`\ERROR`.

1. Else, return the :ref:`value <syntax-val>` :math:`\default_{valtype}`.

.. math::
   \begin{array}{lclll}
   \F{val\_default}(t) &=& v && (\iff \default_t = v) \\
   \F{val\_default}(t) &=& \ERROR && (\iff \default_t = \epsilon) \\
   \end{array}


.. index:: value type, external type, subtyping
.. _embed-match-valtype:
.. _embed-match-externtype:

Matching
~~~~~~~~

:math:`\F{match\_valtype}(\valtype_1, \valtype_2) : \bool`
..........................................................

1. Pre-condition: the :ref:`value types <syntax-valtype>` :math:`\valtype_1` and :math:`\valtype_2` are :ref:`valid <valid-valtype>` under the empty :ref:`context <context>`.

2. If :math:`\valtype_1` :ref:`matches <match-valtype>` :math:`\valtype_2`, then return :math:`\TRUE`.

3. Else, return :math:`\FALSE`.

.. math::
   \begin{array}{lclll}
   \F{match\_reftype}(t_1, t_2) &=& \TRUE && (\iff {} \vdashvaltypematch t_1 \subvaltypematch t_2) \\
   \F{match\_reftype}(t_1, t_2) &=& \FALSE && (\otherwise) \\
   \end{array}


:math:`\F{match\_externtype}(\externtype_1, \externtype_2) : \bool`
...................................................................

1. Pre-condition: the :ref:`extern types <syntax-externtype>` :math:`\externtype_1` and :math:`\externtype_2` are :ref:`valid <valid-externtype>` under the empty :ref:`context <context>`.

2. If :math:`\externtype_1` :ref:`matches <match-externtype>` :math:`\externtype_2`, then return :math:`\TRUE`.

3. Else, return :math:`\FALSE`.

.. math::
   \begin{array}{lclll}
   \F{match\_externtype}(\X{et}_1, \X{et}_2) &=& \TRUE && (\iff {} \vdashexterntypematch \X{et}_1 \subexterntypematch \X{et}_2) \\
   \F{match\_externtype}(\X{et}_1, \X{et}_2) &=& \FALSE && (\otherwise) \\
   \end{array}

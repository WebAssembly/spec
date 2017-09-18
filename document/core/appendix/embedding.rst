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
   For example, an implementation may not support :ref:`parsing <embed-parse-module>` of the :ref:`text format <text>`.

In the description of the embedder interface, syntactic classes from the :ref:`abstract syntax <syntax>` and the :ref:`runtime's abstract machine <syntax-runtime>` are used as names for variables that range over the possible objects from that class.
Hence, these syntactic classes can also be interpreted as types.

.. _embed-error:

Failure of an interface operation is indicated by an auxiliary syntactic class:

.. math::
   \begin{array}{llll}
   \production{(error)} & \error &::=& \ERROR \\
   \end{array}

In addition to the error conditions specified explicitly in this section, implementations may also return errors when specific :ref:`implementation limitations <impl>` are reached.


.. note::
   Errors are abstract and unspecific with this definition.
   Implementations can refine it to carry suitable classifications and diagnostic messages.



.. index:: allocation, store
.. _embed-store:

Store
~~~~~

.. _embed-init-store:

:math:`\F{init\_store}() : \store`
..................................

* Return the empty :ref:`store <syntax-store>`.

.. math::
   \begin{array}{lclll}
   \F{init\_store}() &=& \{ \SFUNCS~\epsilon,~ \SMEMS~\epsilon,~ \STABLES~\epsilon,~ \SGLOBALS~\epsilon \} \\
   \end{array}



.. index:: module
.. _embed-module:

Modules
~~~~~~~

.. index:: binary format
.. _embed-decode-module:

:math:`\F{decode\_module}(\byte^\ast) : \module ~|~ \error`
...........................................................

* If there exists a derivation for the :ref:`byte <syntax-byte>` sequence :math:`\byte^\ast` as a :math:`\Bmodule` according to the :ref:`binary grammar for modules <binary-module>`, yielding a :ref:`module <syntax-module>` :math:`m`, then return :math:`m`.

* Else, return :math:`\ERROR`.

.. math::
   \begin{array}{lclll}
   \F{decode\_module}(b^\ast) &=& m && (\iff \Bmodule \longrightarrow m{:}b^\ast) \\
   \F{decode\_module}(b^\ast) &=& \ERROR && (\otherwise) \\
   \end{array}


.. index:: text format
.. _embed-parse-module:

:math:`\F{parse\_module}(\codepoint^\ast) : \module ~|~ \error`
...............................................................

* If there exists a derivation for the :ref:`source <syntax-source>` :math:`\codepoint^\ast` as a :math:`\Tmodule` according to the :ref:`text grammar for modules <text-module>`, yielding a :ref:`module <syntax-module>` :math:`m`, then return :math:`m`.

* Else, return :math:`\ERROR`.

.. math::
   \begin{array}{lclll}
   \F{parse\_module}(c^\ast) &=& m && (\iff \Tmodule \longrightarrow m{:}c^\ast) \\
   \F{parse\_module}(c^\ast) &=& \ERROR && (\otherwise) \\
   \end{array}


.. index:: validation
.. _embed-validate-module:

:math:`\F{validate\_module}(\module) : \error^?`
................................................

* If :math:`\module` is :ref:`valid <valid-module>`, then return nothing.

* Else, return :math:`\ERROR`.

.. math::
   \begin{array}{lclll}
   \F{validate\_module}(m) &=& \epsilon && (\iff {} \vdashmodule m : \externtype^\ast) \\
   \F{validate\_module}(m) &=& \ERROR && (\otherwise) \\
   \end{array}


.. index:: instantiation, module instance
.. _embed-instantiate-module:

:math:`\F{instantiate\_module}(\store, \module, \externval^\ast) : (\store, \moduleinst ~|~ \error)`
....................................................................................................

* :ref:`Instantiate <exec-instantiation>` :math:`\module` in :math:`\store` with :ref:`external values <syntax-externval>` :math:`\externval^\ast` as imports:

  * If it succeeds with a :ref:`module instance <syntax-moduleinst>` :math:`\moduleinst`, then let :math:`\X{result}` be :math:`\moduleinst`.

  * Else, let :math:`\X{result}` be :math:`\ERROR`.

* Return the new store paired with :math:`\X{result}`.

.. math::
   \begin{array}{lclll}
   \F{instantiate\_module}(S, m, \X{ev}^\ast) &=& (S', \X{mi}) && (\iff S; \INSTANTIATE~m~\X{ev}^\ast \stepto^\ast S'; \epsilon) \\
   \F{instantiate\_module}(S, m, \X{ev}^\ast) &=& (S', \ERROR) && (\iff S; \INSTANTIATE~m~\X{ev}^\ast \stepto^\ast S'; \TRAP) \\
   \end{array}

.. note::
   The store may be modified even in case of an error.


.. index:: import
.. _embed-imports:

:math:`\F{module\_imports}(\module) : (\name, \name, \externtype)^\ast`
.......................................................................

* Assert: :math:`\module` is :ref:`valid <valid-module>` with external import types :math:`\externtype^\ast` and external export types :math:`{\externtype'}^\ast`.

* Let :math:`\import^\ast` be the :ref:`imports <syntax-import>` :math:`\module.\MIMPORTS`.

* Assert: the length of :math:`\import^\ast` equals the length of :math:`\externtype^\ast`.

* For each :math:`\import_i` in :math:`\import^\ast` and corresponding :math:`\externtype_i` in :math:`\externtype^\ast`, do:

  * Let :math:`\X{result}_i` be the triple :math:`(\import_i.\IMODULE, \import_i.\INAME, \externtype_i)`.

* Return the concatenation of all :math:`\X{result}_i`, in index order.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{module\_imports}(m) &=& (\X{im}.\IMODULE, \X{im}.\INAME, \externtype)^\ast \\
     && \qquad (\iff \X{im}^\ast = m.\MIMPORTS \wedge {} \vdashmodule m : \externtype^\ast \to {\externtype'}^\ast) \\
   \end{array}


.. index:: export
.. _embed-exports:

:math:`\F{module\_exports}(\module) : (\name, \externtype)^\ast`
................................................................

* Assert: :math:`\module` is :ref:`valid <valid-module>` with external import types :math:`\externtype^\ast` and external export types :math:`{\externtype'}^\ast`.

* Let :math:`\export^\ast` be the :ref:`exports <syntax-export>` :math:`\module.\MEXPORTS`.

* Assert: the length of :math:`\export^\ast` equals the length of :math:`\externtype^\ast`.

* For each :math:`\export_i` in :math:`\export^\ast` and corresponding :math:`\externtype'_i` in :math:`{\externtype'}^\ast`, do:

  * Let :math:`\X{result}_i` be the pair :math:`(\export_i.\ENAME, \externtype'_i)`.

* Return the concatenation of all :math:`\X{result}_i`, in index order.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{module\_exports}(m) &=& (\X{ex}.\ENAME, \externtype')^\ast \\
     && \qquad (\iff \X{ex}^\ast = m.\MEXPORTS \wedge {} \vdashmodule m : \externtype^\ast \to {\externtype'}^\ast) \\
   \end{array}


.. index:: module, store, module instance, export instance
.. _embed-export:

Exports
~~~~~~~

.. _embed-get-export:

:math:`\F{get\_export}(\moduleinst, \name) : \externval ~|~ \error`
...................................................................

* For each :math:`\exportinst_i` in :math:`\moduleinst.\MIEXPORTS`, do:

  * If the :ref:`name <syntax-name>` :math:`\exportinst_i.\EINAME` equals :math:`\name`, then:

    * Return the :ref:`external value <syntax-externval>` :math:`\exportinst_i.\EIVALUE`.

* Return :math:`\ERROR`.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{get\_export}(m, \name) &=& m.\MIEXPORTS[i].\EIVALUE && (\iff m.\MEXPORTS[i].\EINAME = \name) \\
   \F{get\_export}(m, \name) &=& \ERROR && (\otherwise) \\
   \end{array}


.. index:: function, host function, function address, function instance, function type, store
.. _embed-func:

Functions
~~~~~~~~~

.. _embed-alloc-func:

:math:`\F{alloc\_func}(\store, \functype, \hostfunc) : (\store, \funcaddr)`
...........................................................................

* Let :math:`\funcaddr` be the result of :ref:`allocating a host function <alloc-func>` in :math:`\store` with :ref:`function type <syntax-functype>` :math:`\functype` and host function code :math:`\hostfunc`.

* Return the new store paired with :math:`\funcaddr`.

.. math::
   \begin{array}{lclll}
   \F{alloc\_func}(S, \X{ft}, \X{code}) &=& (S', \X{a}) && (\iff \alloctable(S, \X{ft}, \X{code}) = S', \X{a}) \\
   \end{array}

.. note::
   This operation assumes that :math:`\hostfunc` satisfies the :ref:`pre- and post-conditions <exec-invoke-host>` required for a function instance with type :math:`\functype`.

   Regular (non-host) function instances can only be created indirectly through :ref:`module instantiation <embed-instantiate-module>`.


.. index:: invocation, value, result
.. _embed-invoke-func:

:math:`\F{invoke\_func}(\store, \funcaddr, \val^\ast) : (\store, \val^\ast ~|~ \error`)
.......................................................................................

* Assert: :math:`\store.\SFUNCS[\funcaddr]` exists.

* :ref:`Invoke <exec-invocation>` the function :math:`\funcaddr` in :math:`\store` with :ref:`values <syntax-val>` :math:`\val^\ast` as arguments:

  * If it succeeds with :ref:`values <syntax-val>` :math:`{\val'}^\ast` as results, then let :math:`\X{result}` be :math:`{\val'}^\ast`.

  * Else it has trapped, hence let :math:`\X{result}` be :math:`\ERROR`.

* Return the new store paired with :math:`\X{result}`.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{invoke\_func}(S, a, v^\ast) &=& (S', {v'}^\ast) && (\iff \invoke(S, a, v^\ast) = S', {v'}^\ast) \\
   \F{invoke\_func}(S, a, v^\ast) &=& (S', \ERROR) && (\iff \invoke(S, a, v^\ast) = S', \TRAP) \\
   \end{array}

.. note::
   The store may be modified even in case of an error.


.. index:: table, table address, store, table instance, table type, element, function address
.. _embed-table:

Tables
~~~~~~

.. _embed-alloc-table:

:math:`\F{alloc\_table}(\store, \tabletype) : (\store, \tableaddr)`
...................................................................

* Let :math:`\tableaddr` be the result of :ref:`allocating a table <alloc-table>` in :math:`\store` with :ref:`table type <syntax-tabletype>` :math:`\tabletype`.

* Return the new store paired with :math:`\tableaddr`.

.. math::
   \begin{array}{lclll}
   \F{alloc\_table}(S, \X{tt}) &=& (S', \X{a}) && (\iff \alloctable(S, \X{tt}) = S', \X{a}) \\
   \end{array}


.. _embed-read-table:

:math:`\F{read\_table}(\store, \tableaddr, i) : \funcaddr ~|~ \error`
.....................................................................

* Assert: :math:`\store.\STABLES[\tableaddr]` exists.

* Assert: :math:`i` is a non-negative integer.

* Let :math:`\X{ti}` be the :ref:`table instance <syntax-tableinst>` :math:`\store.\STABLES[\tableaddr]`.

* If :math:`i` is larger than or equal to the length if :math:`\X{ti}.\TIELEM`, then return :math:`\ERROR`.

* If :math:`\X{ti}.\TIELEM[i]` contains a :ref:`function address <syntax-funcaddr>` :math:`\X{fa}`, then return :math:`\X{fa}`.

* Else :math:`\X{ti}.\TIELEM[i]` is empty, hence return :math:`\ERROR`.

.. math::
   \begin{array}{lclll}
   \F{read\_table}(S, a, i) &=& \X{fa} && (\iff S.\STABLES[a].\TIELEM[i] = \X{fa}) \\
   \F{read\_table}(S, a, i) &=& \ERROR && (\otherwise) \\
   \end{array}


.. _embed-write-table:

:math:`\F{write\_table}(\store, \tableaddr, i, \funcaddr) : \store ~|~ \error`
..............................................................................

* Assert: :math:`\store.\STABLES[\tableaddr]` exists.

* Assert: :math:`i` is a non-negative integer.

* Let :math:`\X{ti}` be the :ref:`table instance <syntax-tableinst>` :math:`\store.\STABLES[\tableaddr]`.

* If :math:`i` is larger than or equal to the length if :math:`\X{ti}.\TIELEM`, then return :math:`\ERROR`.

* Replace :math:`\X{ti}.\TIELEM[i]` with the :ref:`function address <syntax-funcaddr>` :math:`\X{fa}`.

* Return the updated store.

.. math::
   \begin{array}{lclll}
   \F{write\_table}(S, a, i, \X{fa}) &=& S' && (\iff S' = S \with \STABLES[a].\TIELEM[i] = \X{fa}) \\
   \F{write\_table}(S, a, i, \X{fa}) &=& \ERROR && (\otherwise) \\
   \end{array}


.. _embed-grow-table:

:math:`\F{grow\_table}(\store, \tableaddr, n) : \store ~|~ \error`
..................................................................

* Assert: :math:`\store.\STABLES[\tableaddr]` exists.

* Assert: :math:`n` is a non-negative integer.

* Let :math:`\X{ti}` be the :ref:`table instance <syntax-tableinst>` :math:`\store.\STABLES[\tableaddr]`.

* If :math:`\X{ti}.\TIMAX` is non-empty and smaller than :math:`n` added to the length of :math:`\X{ti}.\TIELEM`, then return :math:`\ERROR`.

* Append :math:`n` empty elements to :math:`\X{ti}.\TIELEM`.

* Return the updated store.

.. math::
   \begin{array}{lclll}
   \F{grow\_table}(S, a, n) &=& S' && (
     \begin{array}[t]{@{}r@{~}l@{}}
     \iff & \X{ti} = S.\STABLES[a] \\
     \wedge & (\X{ti}.\TIMAX = \epsilon \vee |\X{ti}.\TIELEM| + n \leq \X{ti}.\TIMAX) \\
     \wedge & S' = S \with \STABLES[a].\TIELEM = \X{ti}.\TIELEM~(\epsilon)^n) \\
     \end{array} \\
   \F{grow\_table}(S, a, n) &=& \ERROR && (\otherwise) \\
   \end{array}


.. index:: memory, memory address, store, memory instance, memory type, byte
.. _embed-mem:

Memories
~~~~~~~~

.. _embed-alloc-mem:

:math:`\F{alloc\_mem}(\store, \memtype) : (\store, \memaddr)`
................................................................

* Let :math:`\memaddr` be the result of :ref:`allocating a memory <alloc-mem>` in :math:`\store` with :ref:`memory type <syntax-memtype>` :math:`\memtype`.

* Return the new store paired with :math:`\memaddr`.

.. math::
   \begin{array}{lclll}
   \F{alloc\_mem}(S, \X{mt}) &=& (S', \X{a}) && (\iff \allocmem(S, \X{mt}) = S', \X{a}) \\
   \end{array}


.. _embed-read-mem:

:math:`\F{read\_mem}(\store, \memaddr, i) : \byte ~|~ \error`
.............................................................

* Assert: :math:`\store.\SMEMS[\memaddr]` exists.

* Assert: :math:`i` is a non-negative integer.

* Let :math:`\X{mi}` be the :ref:`memory instance <syntax-meminst>` :math:`\store.\SMEMS[\memaddr]`.

* If :math:`i` is larger than or equal to the length if :math:`\X{mi}.\MIDATA`, then return :math:`\ERROR`.

* Else, return the  :ref:`byte <syntax-byte>` :math:`\X{mi}.\MIDATA[i]`.

.. math::
   \begin{array}{lclll}
   \F{read\_mem}(S, a, i) &=& b && (\iff S.\SMEMS[a].\MIDATA[i] = b) \\
   \F{read\_mem}(S, a, i) &=& \ERROR && (\otherwise) \\
   \end{array}


.. _embed-write-mem:

:math:`\F{write\_mem}(\store, \memaddr, i, \byte) : \store ~|~ \error`
......................................................................

* Assert: :math:`\store.\SMEMS[\memaddr]` exists.

* Assert: :math:`i` is a non-negative integer.

* Let :math:`\X{mi}` be the :ref:`memory instance <syntax-meminst>` :math:`\store.\SMEMS[\memaddr]`.

* If :math:`i` is larger than or equal to the length if :math:`\X{mi}.\MIDATA`, then return :math:`\ERROR`.

* Replace :math:`\X{mi}.\MIDATA[i]` with :math:`\byte`.

* Return the updated store.

.. math::
   \begin{array}{lclll}
   \F{write\_mem}(S, a, i, b) &=& S' && (\iff S' = S \with \SMEMS[a].\MIDATA[i] = b) \\
   \F{write\_mem}(S, a, i, b) &=& \ERROR && (\otherwise) \\
   \end{array}


.. _embed-grow-mem:

:math:`\F{grow\_mem}(\store, \memaddr, n) : \store ~|~ \error`
..............................................................

* Assert: :math:`\store.\SMEMS[\memaddr]` exists.

* Assert: :math:`n` is a non-negative integer.

* Let :math:`\X{mi}` be the :ref:`memory instance <syntax-meminst>` :math:`\store.\SMEMS[\memaddr]`.

* If :math:`\X{mi}.\MIMAX` is non-empty and smaller than :math:`n` added to the length of :math:`\X{mi}.\MIDATA` divided by the :ref:`page size <page-size>` :math:`64\,\F{Ki}`, then return :math:`\ERROR`.

* Append :math:`n` times the :ref:`page size <page-size>` :math:`64\,\F{Ki}` zero :ref:`bytes <syntax-byte>` to :math:`\X{mi}.\MIDATA`.

* Return the updated store.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{grow\_mem}(S, a, n) &=& S' && (
     \begin{array}[t]{@{}r@{~}l@{}}
     \iff & \X{mi} = S.\SMEMS[a] \\
     \wedge & (\X{mi}.\MIMAX = \epsilon \vee |\X{mi}.\MIDATA|/64\,\F{Ki} + n \leq \X{mi}.\TIMAX) \\
     \wedge & S' = S \with \SMEMS[a].\MIDATA = \X{mi}.\MIDATA~(\hex{00})^{n \cdot 64\,\F{Ki}}) \\
     \end{array} \\
   \F{grow\_mem}(S, a, n) &=& \ERROR && (\otherwise) \\
   \end{array}



.. index:: global, global address, store, global instance, global type, value
.. _embed-global:

Globals
~~~~~~~

.. _embed-alloc-global:

:math:`\F{alloc\_global}(\store, \globaltype, \val) : (\store, \globaladdr)`
............................................................................

* Let :math:`\globaladdr` be the result of :ref:`allocating a global <alloc-global>` in :math:`\store` with :ref:`global type <syntax-globaltype>` :math:`\globaltype` and initialization value :math:`\val`.

* Return the new store paired with :math:`\globaladdr`.

.. math::
   \begin{array}{lclll}
   \F{alloc\_global}(S, \X{gt}, v) &=& (S', \X{a}) && (\iff \allocglobal(S, \X{gt}, v) = S', \X{a}) \\
   \end{array}


.. _embed-read-global:

:math:`\F{read\_global}(\store, \globaladdr) : \val`
....................................................

* Assert: :math:`\store.\SGLOBALS[\globaladdr]` exists.

* Let :math:`\X{gi}` be the :ref:`global instance <syntax-globalinst>` :math:`\store.\SGLOBALS[\globaladdr]`.

* Return the :ref:`value <syntax-val>` :math:`\X{gi}.\GIVALUE`.

.. math::
   \begin{array}{lclll}
   \F{read\_global}(S, a) &=& v && (\iff S.\SGLOBALS[a].\GIVALUE = v) \\
   \end{array}


.. _embed-write-global:

:math:`\F{write\_global}(\store, \globaladdr, \val) : \store ~|~ \error`
........................................................................

* Assert: :math:`\store.\SGLOBALS[a]` exists.

* Let :math:`\X{gi}` be the :ref:`global instance <syntax-globalinst>` :math:`\store.\SGLOBALS[\globaladdr]`.

* If :math:`\X{gi}.\GIMUT` is not :math:`\MVAR`, then return :math:`\ERROR`.

* Replace :math:`\X{gi}.\GIVALUE` with the :ref:`value <syntax-val>` :math:`\val`.

* Return the updated store.

.. math::
   ~ \\
   \begin{array}{lclll}
   \F{write\_global}(S, a, v) &=& S' && (\iff S.\SGLOBALS[a].\GIMUT = \MVAR \wedge S' = S \with \SGLOBALS[a].\GIVALUE = v) \\
   \F{write\_global}(S, a, v) &=& \ERROR && (\otherwise) \\
   \end{array}

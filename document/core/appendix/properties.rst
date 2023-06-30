.. index:: ! soundness, type system
.. _soundness:

Soundness
---------

The :ref:`type system <type-system>` of WebAssembly is *sound*, implying both *type safety* and *memory safety* with respect to the WebAssembly semantics. For example:

* All types declared and derived during validation are respected at run time;
  e.g., every :ref:`local <syntax-local>` or :ref:`global <syntax-global>` variable will only contain type-correct values, every :ref:`instruction <syntax-instr>` will only be applied to operands of the expected type, and every :ref:`function <syntax-func>` :ref:`invocation <exec-invocation>` always evaluates to a result of the right type (if it does not :ref:`trap <trap>` or diverge).

* No memory location will be read or written except those explicitly defined by the program, i.e., as a :ref:`local <syntax-local>`, a :ref:`global <syntax-global>`, an element in a :ref:`table <syntax-table>`, or a location within a linear :ref:`memory <syntax-mem>`.

* There is no undefined behavior,
  i.e., the :ref:`execution rules <exec>` cover all possible cases that can occur in a :ref:`valid <valid>` program, and the rules are mutually consistent.

Soundness also is instrumental in ensuring additional properties, most notably, *encapsulation* of function and module scopes: no :ref:`locals <syntax-local>` can be accessed outside their own function and no :ref:`module <syntax-module>` components can be accessed outside their own module unless they are explicitly :ref:`exported <syntax-export>` or :ref:`imported <syntax-import>`.

The typing rules defining WebAssembly :ref:`validation <valid>` only cover the *static* components of a WebAssembly program.
In order to state and prove soundness precisely, the typing rules must be extended to the *dynamic* components of the abstract :ref:`runtime <syntax-runtime>`, that is, the :ref:`store <syntax-store>`, :ref:`configurations <syntax-config>`, and :ref:`administrative instructions <syntax-instr-admin>`. [#cite-pldi2017]_


.. index:: value, value type, result, result type, trap
.. _valid-result:

Results
~~~~~~~

:ref:`Results <syntax-result>` can be classified by :ref:`result types <syntax-resulttype>` as follows.

:ref:`Results <syntax-result>` :math:`\val^\ast`
................................................

* For each :ref:`value <syntax-val>` :math:`\val_i` in :math:`\val^\ast`:

  * The value :math:`\val_i` is :ref:`valid <valid-val>` with some :ref:`value type <syntax-valtype>` :math:`t_i`.

* Let :math:`t^\ast` be the concatenation of all :math:`t_i`.

* Then the result is valid with :ref:`result type <syntax-resulttype>` :math:`[t^\ast]`.

.. math::
   \frac{
     (S \vdashval \val : t)^\ast
   }{
     S \vdashresult \val^\ast : [t^\ast]
   }


:ref:`Results <syntax-result>` :math:`\TRAP`
............................................

* The result is valid with :ref:`result type <syntax-resulttype>` :math:`[t^\ast]`, for any sequence :math:`t^\ast` of :ref:`value types <syntax-valtype>`.

.. math::
   \frac{
   }{
     S \vdashresult \TRAP : [t^\ast]
   }


.. _module-context:
.. _valid-store:

Store Validity
~~~~~~~~~~~~~~

The following typing rules specify when a runtime :ref:`store <syntax-store>` :math:`S` is *valid*.
A valid store must consist of
:ref:`function <syntax-funcinst>`, :ref:`table <syntax-tableinst>`, :ref:`memory <syntax-meminst>`, :ref:`global <syntax-globalinst>`, and :ref:`module <syntax-moduleinst>` instances that are themselves valid, relative to :math:`S`.

To that end, each kind of instance is classified by a respective :ref:`function <syntax-functype>`, :ref:`table <syntax-tabletype>`, :ref:`memory <syntax-memtype>`, or :ref:`global <syntax-globaltype>` type.
Module instances are classified by *module contexts*, which are regular :ref:`contexts <context>` repurposed as module types describing the :ref:`index spaces <syntax-index>` defined by a module.



.. index:: store, function instance, table instance, memory instance, global instance, function type, table type, memory type, global type

:ref:`Store <syntax-store>` :math:`S`
.....................................

* Each :ref:`function instance <syntax-funcinst>` :math:`\funcinst_i` in :math:`S.\SFUNCS` must be :ref:`valid <valid-funcinst>` with some :ref:`function type <syntax-functype>` :math:`\functype_i`.

* Each :ref:`table instance <syntax-tableinst>` :math:`\tableinst_i` in :math:`S.\STABLES` must be :ref:`valid <valid-tableinst>` with some :ref:`table type <syntax-tabletype>` :math:`\tabletype_i`.

* Each :ref:`memory instance <syntax-meminst>` :math:`\meminst_i` in :math:`S.\SMEMS` must be :ref:`valid <valid-meminst>` with some :ref:`memory type <syntax-memtype>` :math:`\memtype_i`.

* Each :ref:`global instance <syntax-globalinst>` :math:`\globalinst_i` in :math:`S.\SGLOBALS` must be :ref:`valid <valid-globalinst>` with some  :ref:`global type <syntax-globaltype>` :math:`\globaltype_i`.

* Each :ref:`element instance <syntax-eleminst>` :math:`\eleminst_i` in :math:`S.\SELEMS` must be :ref:`valid <valid-eleminst>` with some :ref:`reference type <syntax-reftype>` :math:`\reftype_i`.

* Each :ref:`data instance <syntax-datainst>` :math:`\datainst_i` in :math:`S.\SDATAS` must be :ref:`valid <valid-datainst>`.

* Then the store is valid.

.. math::
   ~\\[-1ex]
   \frac{
     \begin{array}{@{}c@{}}
     (S \vdashfuncinst \funcinst : \functype)^\ast
     \qquad
     (S \vdashtableinst \tableinst : \tabletype)^\ast
     \\
     (S \vdashmeminst \meminst : \memtype)^\ast
     \qquad
     (S \vdashglobalinst \globalinst : \globaltype)^\ast
     \\
     (S \vdasheleminst \eleminst : \reftype)^\ast
     \qquad
     (S \vdashdatainst \datainst \ok)^\ast
     \\
     S = \{
       \SFUNCS~\funcinst^\ast,
       \STABLES~\tableinst^\ast,
       \SMEMS~\meminst^\ast,
       \SGLOBALS~\globalinst^\ast,
       \SELEMS~\eleminst^\ast,
       \SDATAS~\datainst^\ast \}
     \end{array}
   }{
     \vdashstore S \ok
   }


.. index:: function type, function instance
.. _valid-funcinst:

:ref:`Function Instances <syntax-funcinst>` :math:`\{\FITYPE~\functype, \FIMODULE~\moduleinst, \FICODE~\func\}`
.......................................................................................................................

* The :ref:`function type <syntax-functype>` :math:`\functype` must be :ref:`valid <valid-functype>`.

* The :ref:`module instance <syntax-moduleinst>` :math:`\moduleinst` must be :ref:`valid <valid-moduleinst>` with some :ref:`context <context>` :math:`C`.

* Under :ref:`context <context>` :math:`C`, the :ref:`function <syntax-func>` :math:`\func` must be :ref:`valid <valid-func>` with :ref:`function type <syntax-functype>` :math:`\functype`.

* Then the function instance is valid with :ref:`function type <syntax-functype>` :math:`\functype`.

.. math::
   \frac{
     \vdashfunctype \functype \ok
     \qquad
     S \vdashmoduleinst \moduleinst : C
     \qquad
     C \vdashfunc \func : \functype
   }{
     S \vdashfuncinst \{\FITYPE~\functype, \FIMODULE~\moduleinst, \FICODE~\func\} : \functype
   }


.. index:: function type, function instance, host function
.. _valid-hostfuncinst:

:ref:`Host Function Instances <syntax-funcinst>` :math:`\{\FITYPE~\functype, \FIHOSTCODE~\X{hf}\}`
..................................................................................................

* The :ref:`function type <syntax-functype>` :math:`\functype` must be :ref:`valid <valid-functype>`.

* Let :math:`[t_1^\ast] \to [t_2^\ast]` be the :ref:`function type <syntax-functype>` :math:`\functype`.

* For every :ref:`valid <valid-store>` :ref:`store <syntax-store>` :math:`S_1` :ref:`extending <extend-store>` :math:`S` and every sequence :math:`\val^\ast` of :ref:`values <syntax-val>` whose :ref:`types <valid-val>` coincide with :math:`t_1^\ast`:

  * :ref:`Executing <exec-invoke-host>` :math:`\X{hf}` in store :math:`S_1` with arguments :math:`\val^\ast` has a non-empty set of possible outcomes.

  * For every element :math:`R` of this set:

    * Either :math:`R` must be :math:`\bot` (i.e., divergence).

    * Or :math:`R` consists of a :ref:`valid <valid-store>` :ref:`store <syntax-store>` :math:`S_2` :ref:`extending <extend-store>` :math:`S_1` and a :ref:`result <syntax-result>` :math:`\result` whose :ref:`type <valid-result>` coincides with :math:`[t_2^\ast]`.

* Then the function instance is valid with :ref:`function type <syntax-functype>` :math:`\functype`.

.. math::
   \frac{
     \begin{array}[b]{@{}l@{}}
     \vdashfunctype [t_1^\ast] \to [t_2^\ast] \ok \\
     \end{array}
     \quad
     \begin{array}[b]{@{}l@{}}
     \forall S_1, \val^\ast,~
       {\vdashstore S_1 \ok} \wedge
       {\vdashstoreextends S \extendsto S_1} \wedge
       {S_1 \vdashresult \val^\ast : [t_1^\ast]}
       \Longrightarrow {} \\ \qquad
       \X{hf}(S_1; \val^\ast) \supset \emptyset \wedge {} \\ \qquad
     \forall R \in \X{hf}(S_1; \val^\ast),~
       R = \bot \vee {} \\ \qquad\qquad
       \exists S_2, \result,~
       {\vdashstore S_2 \ok} \wedge
       {\vdashstoreextends S_1 \extendsto S_2} \wedge
       {S_2 \vdashresult \result : [t_2^\ast]} \wedge
       R = (S_2; \result)
     \end{array}
   }{
     S \vdashfuncinst \{\FITYPE~[t_1^\ast] \to [t_2^\ast], \FIHOSTCODE~\X{hf}\} : [t_1^\ast] \to [t_2^\ast]
   }

.. note::
   This rule states that, if appropriate pre-conditions about store and arguments are satisfied, then executing the host function must satisfy appropriate post-conditions about store and results.
   The post-conditions match the ones in the :ref:`execution rule <exec-invoke-host>` for invoking host functions.

   Any store under which the function is invoked is assumed to be an extension of the current store.
   That way, the function itself is able to make sufficient assumptions about future stores.


.. index:: table type, table instance, limits, function address
.. _valid-tableinst:

:ref:`Table Instances <syntax-tableinst>` :math:`\{ \TITYPE~(\limits~t), \TIELEM~\reff^\ast \}`
...............................................................................................

* The :ref:`table type <syntax-tabletype>` :math:`\limits~t` must be :ref:`valid <valid-tabletype>`.

* The length of :math:`\reff^\ast` must equal :math:`\limits.\LMIN`.

* For each :ref:`reference <syntax-ref>` :math:`\reff_i` in the table's elements :math:`\reff^n`:

  * The :ref:`reference <syntax-ref>` :math:`\reff_i` must be :ref:`valid <valid-ref>` with :ref:`reference type <syntax-reftype>` :math:`t`.

* Then the table instance is valid with :ref:`table type <syntax-tabletype>` :math:`\limits~t`.

.. math::
   \frac{
     \vdashtabletype \limits~t \ok
     \qquad
     n = \limits.\LMIN
     \qquad
     (S \vdash \reff : t)^n
   }{
     S \vdashtableinst \{ \TITYPE~(\limits~t), \TIELEM~\reff^n \} : \limits~t
   }


.. index:: memory type, memory instance, limits, byte
.. _valid-meminst:

:ref:`Memory Instances <syntax-meminst>` :math:`\{ \MITYPE~\limits, \MIDATA~b^\ast \}`
......................................................................................

* The :ref:`memory type <syntax-memtype>` :math:`\limits` must be :ref:`valid <valid-memtype>`.

* The length of :math:`b^\ast` must equal :math:`\limits.\LMIN` multiplied by the :ref:`page size <page-size>` :math:`64\,\F{Ki}`.

* Then the memory instance is valid with :ref:`memory type <syntax-memtype>` :math:`\limits`.

.. math::
   \frac{
     \vdashmemtype \limits \ok
     \qquad
     n = \limits.\LMIN \cdot 64\,\F{Ki}
   }{
     S \vdashmeminst \{ \MITYPE~\limits, \MIDATA~b^n \} : \limits
   }


.. index:: global type, global instance, value, mutability
.. _valid-globalinst:

:ref:`Global Instances <syntax-globalinst>` :math:`\{ \GITYPE~(\mut~t), \GIVALUE~\val \}`
.........................................................................................

* The :ref:`global type <syntax-globaltype>` :math:`\mut~t` must be :ref:`valid <valid-globaltype>`.

* The :ref:`value <syntax-val>` :math:`\val` must be :ref:`valid <valid-val>` with :ref:`value type <syntax-valtype>` :math:`t`.

* Then the global instance is valid with :ref:`global type <syntax-globaltype>` :math:`\mut~t`.

.. math::
   \frac{
     \vdashglobaltype \mut~t \ok
     \qquad
     S \vdashval \val : t
   }{
     S \vdashglobalinst \{ \GITYPE~(\mut~t), \GIVALUE~\val \} : \mut~t
   }


.. index:: element instance, reference
.. _valid-eleminst:

:ref:`Element Instances <syntax-eleminst>` :math:`\{ \EITYPE~t, \EIELEM~\reff^\ast \}`
......................................................................................

* For each :ref:`reference <syntax-ref>` :math:`\reff_i` in the elements :math:`\reff^n`:

  * The :ref:`reference <syntax-ref>` :math:`\reff_i` must be :ref:`valid <valid-ref>` with :ref:`reference type <syntax-reftype>` :math:`t`.

* Then the element instance is valid with :ref:`reference type <syntax-reftype>` :math:`t`.

.. math::
   \frac{
     (S \vdash \reff : t)^\ast
   }{
     S \vdasheleminst \{ \EITYPE~t, \EIELEM~\reff^\ast \} : t
   }


.. index:: data instance, byte
.. _valid-datainst:

:ref:`Data Instances <syntax-eleminst>` :math:`\{ \DIDATA~b^\ast \}`
....................................................................

* The data instance is valid.

.. math::
   \frac{
   }{
     S \vdashdatainst \{ \DIDATA~b^\ast \} \ok
   }


.. index:: external type, export instance, name, external value
.. _valid-exportinst:

:ref:`Export Instances <syntax-exportinst>` :math:`\{ \EINAME~\name, \EIVALUE~\externval \}`
.......................................................................................................

* The :ref:`external value <syntax-externval>` :math:`\externval` must be :ref:`valid <valid-externval>` with some :ref:`external type <syntax-externtype>` :math:`\externtype`.

* Then the export instance is valid.

.. math::
   \frac{
     S \vdashexternval \externval : \externtype
   }{
     S \vdashexportinst \{ \EINAME~\name, \EIVALUE~\externval \} \ok
   }


.. index:: module instance, context
.. _valid-moduleinst:

:ref:`Module Instances <syntax-moduleinst>` :math:`\moduleinst`
...............................................................

* Each :ref:`function type <syntax-functype>` :math:`\functype_i` in :math:`\moduleinst.\MITYPES` must be :ref:`valid <valid-functype>`.

* For each :ref:`function address <syntax-funcaddr>` :math:`\funcaddr_i` in :math:`\moduleinst.\MIFUNCS`, the :ref:`external value <syntax-externval>` :math:`\EVFUNC~\funcaddr_i` must be :ref:`valid <valid-externval-func>` with some :ref:`external type <syntax-externtype>` :math:`\ETFUNC~\functype'_i`.

* For each :ref:`table address <syntax-tableaddr>` :math:`\tableaddr_i` in :math:`\moduleinst.\MITABLES`, the :ref:`external value <syntax-externval>` :math:`\EVTABLE~\tableaddr_i` must be :ref:`valid <valid-externval-table>` with some :ref:`external type <syntax-externtype>` :math:`\ETTABLE~\tabletype_i`.

* For each :ref:`memory address <syntax-memaddr>` :math:`\memaddr_i` in :math:`\moduleinst.\MIMEMS`, the :ref:`external value <syntax-externval>` :math:`\EVMEM~\memaddr_i` must be :ref:`valid <valid-externval-mem>` with some :ref:`external type <syntax-externtype>` :math:`\ETMEM~\memtype_i`.

* For each :ref:`global address <syntax-globaladdr>` :math:`\globaladdr_i` in :math:`\moduleinst.\MIGLOBALS`, the :ref:`external value <syntax-externval>` :math:`\EVGLOBAL~\globaladdr_i` must be :ref:`valid <valid-externval-global>` with some :ref:`external type <syntax-externtype>` :math:`\ETGLOBAL~\globaltype_i`.

* For each :ref:`element address <syntax-elemaddr>` :math:`\elemaddr_i` in :math:`\moduleinst.\MIELEMS`, the :ref:`element instance <syntax-eleminst>` :math:`S.\SELEMS[\elemaddr_i]` must be :ref:`valid <valid-eleminst>` with some :ref:`reference type <syntax-reftype>` :math:`\reftype_i`.

* For each :ref:`data address <syntax-dataaddr>` :math:`\dataaddr_i` in :math:`\moduleinst.\MIDATAS`, the :ref:`data instance <syntax-datainst>` :math:`S.\SDATAS[\dataaddr_i]` must be :ref:`valid <valid-datainst>`.

* Each :ref:`export instance <syntax-exportinst>` :math:`\exportinst_i` in :math:`\moduleinst.\MIEXPORTS` must be :ref:`valid <valid-exportinst>`.

* For each :ref:`export instance <syntax-exportinst>` :math:`\exportinst_i` in :math:`\moduleinst.\MIEXPORTS`, the :ref:`name <syntax-name>` :math:`\exportinst_i.\EINAME` must be different from any other name occurring in :math:`\moduleinst.\MIEXPORTS`.

* Let :math:`{\functype'}^\ast` be the concatenation of all :math:`\functype'_i` in order.

* Let :math:`\tabletype^\ast` be the concatenation of all :math:`\tabletype_i` in order.

* Let :math:`\memtype^\ast` be the concatenation of all :math:`\memtype_i` in order.

* Let :math:`\globaltype^\ast` be the concatenation of all :math:`\globaltype_i` in order.

* Let :math:`\reftype^\ast` be the concatenation of all :math:`\reftype_i` in order.

* Let :math:`n` be the length of :math:`\moduleinst.\MIDATAS`.

* Then the module instance is valid with :ref:`context <context>`
  :math:`\{\CTYPES~\functype^\ast,` :math:`\CFUNCS~{\functype'}^\ast,` :math:`\CTABLES~\tabletype^\ast,` :math:`\CMEMS~\memtype^\ast,` :math:`\CGLOBALS~\globaltype^\ast,` :math:`\CELEMS~\reftype^\ast,` :math:`\CDATAS~{\ok}^n\}`.

.. math::
   ~\\[-1ex]
   \frac{
     \begin{array}{@{}c@{}}
     (\vdashfunctype \functype \ok)^\ast
     \\
     (S \vdashexternval \EVFUNC~\funcaddr : \ETFUNC~\functype')^\ast
     \qquad
     (S \vdashexternval \EVTABLE~\tableaddr : \ETTABLE~\tabletype)^\ast
     \\
     (S \vdashexternval \EVMEM~\memaddr : \ETMEM~\memtype)^\ast
     \qquad
     (S \vdashexternval \EVGLOBAL~\globaladdr : \ETGLOBAL~\globaltype)^\ast
     \\
     (S \vdasheleminst S.\SELEMS[\elemaddr] : \reftype)^\ast
     \qquad
     (S \vdashdatainst S.\SDATAS[\dataaddr] \ok)^n
     \\
     (S \vdashexportinst \exportinst \ok)^\ast
     \qquad
     (\exportinst.\EINAME)^\ast ~\mbox{disjoint}
     \end{array}
   }{
     S \vdashmoduleinst \{
       \begin{array}[t]{@{}l@{~}l@{}}
       \MITYPES & \functype^\ast, \\
       \MIFUNCS & \funcaddr^\ast, \\
       \MITABLES & \tableaddr^\ast, \\
       \MIMEMS & \memaddr^\ast, \\
       \MIGLOBALS & \globaladdr^\ast, \\
       \MIELEMS & \elemaddr^\ast, \\
       \MIDATAS & \dataaddr^n, \\
       \MIEXPORTS & \exportinst^\ast ~\} : \{
         \begin{array}[t]{@{}l@{~}l@{}}
         \CTYPES & \functype^\ast, \\
         \CFUNCS & {\functype'}^\ast, \\
         \CTABLES & \tabletype^\ast, \\
         \CMEMS & \memtype^\ast, \\
         \CGLOBALS & \globaltype^\ast, \\
         \CELEMS & \reftype^\ast, \\
         \CDATAS & {\ok}^n ~\}
         \end{array}
       \end{array}
   }


.. index:: configuration, administrative instruction, store, frame
.. _frame-context:
.. _valid-config:

Configuration Validity
~~~~~~~~~~~~~~~~~~~~~~

To relate the WebAssembly :ref:`type system <valid>` to its :ref:`execution semantics <exec>`, the :ref:`typing rules for instructions <valid-instr>` must be extended to :ref:`configurations <syntax-config>` :math:`S;T`,
which relates the :ref:`store <syntax-store>` to execution :ref:`threads <syntax-thread>`.

Configurations and threads are classified by their :ref:`result type <syntax-resulttype>`.
In addition to the store :math:`S`, threads are typed under a *return type* :math:`\resulttype^?`, which controls whether and with which type a |return| instruction is allowed.
This type is absent (:math:`\epsilon`) except for instruction sequences inside an administrative |FRAME| instruction.

Finally, :ref:`frames <syntax-frame>` are classified with *frame contexts*, which extend the :ref:`module contexts <module-context>` of a frame's associated :ref:`module instance <syntax-moduleinst>` with the :ref:`locals <syntax-local>` that the frame contains.


.. index:: result type, thread

:ref:`Configurations <syntax-config>` :math:`S;T`
.................................................

* The :ref:`store <syntax-store>` :math:`S` must be :ref:`valid <valid-store>`.

* Under no allowed return type,
  the :ref:`thread <syntax-thread>` :math:`T` must be :ref:`valid <valid-thread>` with some :ref:`result type <syntax-resulttype>` :math:`[t^\ast]`.

* Then the configuration is valid with the :ref:`result type <syntax-resulttype>` :math:`[t^\ast]`.

.. math::
   \frac{
     \vdashstore S \ok
     \qquad
     S; \epsilon \vdashthread T : [t^\ast]
   }{
     \vdashconfig S; T : [t^\ast]
   }


.. index:: thread, frame, instruction, result type, context
.. _valid-thread:

:ref:`Threads <syntax-thread>` :math:`F;\instr^\ast`
....................................................

* Let :math:`\resulttype^?` be the current allowed return type.

* The :ref:`frame <syntax-frame>` :math:`F` must be :ref:`valid <valid-frame>` with a :ref:`context <context>` :math:`C`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with |CRETURN| set to :math:`\resulttype^?`.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instr-seq>` with some type :math:`[] \to [t^\ast]`.

* Then the thread is valid with the :ref:`result type <syntax-resulttype>` :math:`[t^\ast]`.

.. math::
   \frac{
     S \vdashframe F : C
     \qquad
     S; C,\CRETURN~\resulttype^? \vdashinstrseq \instr^\ast : [] \to [t^\ast]
   }{
     S; \resulttype^? \vdashthread F; \instr^\ast : [t^\ast]
   }


.. index:: frame, local, module instance, value, value type, context
.. _valid-frame:

:ref:`Frames <syntax-frame>` :math:`\{\ALOCALS~\val^\ast, \AMODULE~\moduleinst\}`
.................................................................................

* The :ref:`module instance <syntax-moduleinst>` :math:`\moduleinst` must be :ref:`valid <valid-moduleinst>` with some :ref:`module context <module-context>` :math:`C`.

* Each :ref:`value <syntax-val>` :math:`\val_i` in :math:`\val^\ast` must be :ref:`valid <valid-val>` with some :ref:`value type <syntax-valtype>` :math:`t_i`.

* Let :math:`t^\ast` be the concatenation of all :math:`t_i` in order.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`value types <syntax-valtype>` :math:`t^\ast` prepended to the |CLOCALS| vector.

* Then the frame is valid with :ref:`frame context <frame-context>` :math:`C'`.

.. math::
   \frac{
     S \vdashmoduleinst \moduleinst : C
     \qquad
     (S \vdashval \val : t)^\ast
   }{
     S \vdashframe \{\ALOCALS~\val^\ast, \AMODULE~\moduleinst\} : (C, \CLOCALS~t^\ast)
   }


.. index:: administrative instruction, value type, context, store
.. _valid-instr-admin:

Administrative Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Typing rules for :ref:`administrative instructions <syntax-instr-admin>` are specified as follows.
In addition to the :ref:`context <context>` :math:`C`, typing of these instructions is defined under a given :ref:`store <syntax-store>` :math:`S`.
To that end, all previous typing judgements :math:`C \vdash \X{prop}` are generalized to include the store, as in :math:`S; C \vdash \X{prop}`, by implicitly adding :math:`S` to all rules -- :math:`S` is never modified by the pre-existing rules, but it is accessed in the extra rules for :ref:`administrative instructions <valid-instr-admin>` given below.


.. index:: trap

:math:`\TRAP`
.............

* The instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`, for any sequences of :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.

.. math::
   \frac{
   }{
     S; C \vdashadmininstr \TRAP : [t_1^\ast] \to [t_2^\ast]
   }


.. index:: extern address

:math:`\REFEXTERNADDR~\externaddr`
..................................

* The instruction is valid with type :math:`[] \to [\EXTERNREF]`.

.. math::
   \frac{
   }{
     S; C \vdashadmininstr \REFEXTERNADDR~\externaddr : [] \to [\EXTERNREF]
   }


.. index:: function address, extern value, extern type, function type

:math:`\REFFUNCADDR~\funcaddr`
..............................

* The :ref:`external function value <syntax-externval>` :math:`\EVFUNC~\funcaddr` must be :ref:`valid <valid-externval-func>` with :ref:`external function type <syntax-externtype>` :math:`\ETFUNC~\functype`.

* Then the instruction is valid with type :math:`[] \to [\FUNCREF]`.

.. math::
   \frac{
     S \vdashexternval \EVFUNC~\funcaddr : \ETFUNC~\functype
   }{
     S; C \vdashadmininstr \REFFUNCADDR~\funcaddr : [] \to [\FUNCREF]
   }


.. index:: function address, extern value, extern type, function type

:math:`\INVOKE~\funcaddr`
.........................

* The :ref:`external function value <syntax-externval>` :math:`\EVFUNC~\funcaddr` must be :ref:`valid <valid-externval-func>` with :ref:`external function type <syntax-externtype>` :math:`\ETFUNC ([t_1^\ast] \to [t_2^\ast])`.

* Then the instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`.

.. math::
   \frac{
     S \vdashexternval \EVFUNC~\funcaddr : \ETFUNC~[t_1^\ast] \to [t_2^\ast]
   }{
     S; C \vdashadmininstr \INVOKE~\funcaddr : [t_1^\ast] \to [t_2^\ast]
   }


.. index:: label, instruction, result type

:math:`\LABEL_n\{\instr_0^\ast\}~\instr^\ast~\END`
..................................................

* The instruction sequence :math:`\instr_0^\ast` must be :ref:`valid <valid-instr-seq>` with some type :math:`[t_1^n] \to [t_2^*]`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`result type <syntax-resulttype>` :math:`[t_1^n]` prepended to the |CLABELS| vector.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[] \to [t_2^*]`.

* Then the compound instruction is valid with type :math:`[] \to [t_2^*]`.

.. math::
   \frac{
     S; C \vdashinstrseq \instr_0^\ast : [t_1^n] \to [t_2^*]
     \qquad
     S; C,\CLABELS\,[t_1^n] \vdashinstrseq \instr^\ast : [] \to [t_2^*]
   }{
     S; C \vdashadmininstr \LABEL_n\{\instr_0^\ast\}~\instr^\ast~\END : [] \to [t_2^*]
   }


.. index:: frame, instruction, result type

:math:`\FRAME_n\{F\}~\instr^\ast~\END`
...........................................

* Under the return type :math:`[t^n]`,
  the :ref:`thread <syntax-frame>` :math:`F; \instr^\ast` must be :ref:`valid <valid-frame>` with :ref:`result type <syntax-resulttype>` :math:`[t^n]`.

* Then the compound instruction is valid with type :math:`[] \to [t^n]`.

.. math::
   \frac{
     S; [t^n] \vdashinstrseq F; \instr^\ast : [t^n]
   }{
     S; C \vdashadmininstr \FRAME_n\{F\}~\instr^\ast~\END : [] \to [t^n]
   }


.. index:: ! store extension, store
.. _extend:

Store Extension
~~~~~~~~~~~~~~~

Programs can mutate the :ref:`store <syntax-store>` and its contained instances.
Any such modification must respect certain invariants, such as not removing allocated instances or changing immutable definitions.
While these invariants are inherent to the execution semantics of WebAssembly :ref:`instructions <exec-instr>` and :ref:`modules <exec-instantiation>`,
:ref:`host functions <syntax-hostfunc>` do not automatically adhere to them. Consequently, the required invariants must be stated as explicit constraints on the :ref:`invocation <exec-invoke-host>` of host functions.
Soundness only holds when the :ref:`embedder <embedder>` ensures these constraints.

The necessary constraints are codified by the notion of store *extension*:
a store state :math:`S'` extends state :math:`S`, written :math:`S \extendsto S'`, when the following rules hold.

.. note::
   Extension does not imply that the new store is valid, which is defined separately :ref:`above <valid-store>`.


.. index:: store, function instance, table instance, memory instance, global instance
.. _extend-store:

:ref:`Store <syntax-store>` :math:`S`
.....................................

* The length of :math:`S.\SFUNCS` must not shrink.

* The length of :math:`S.\STABLES` must not shrink.

* The length of :math:`S.\SMEMS` must not shrink.

* The length of :math:`S.\SGLOBALS` must not shrink.

* The length of :math:`S.\SELEMS` must not shrink.

* The length of :math:`S.\SDATAS` must not shrink.

* For each :ref:`function instance <syntax-funcinst>` :math:`\funcinst_i` in the original :math:`S.\SFUNCS`, the new function instance must be an :ref:`extension <extend-funcinst>` of the old.

* For each :ref:`table instance <syntax-tableinst>` :math:`\tableinst_i` in the original :math:`S.\STABLES`, the new table instance must be an :ref:`extension <extend-tableinst>` of the old.

* For each :ref:`memory instance <syntax-meminst>` :math:`\meminst_i` in the original :math:`S.\SMEMS`, the new memory instance must be an :ref:`extension <extend-meminst>` of the old.

* For each :ref:`global instance <syntax-globalinst>` :math:`\globalinst_i` in the original :math:`S.\SGLOBALS`, the new global instance must be an :ref:`extension <extend-globalinst>` of the old.

* For each :ref:`element instance <syntax-eleminst>` :math:`\eleminst_i` in the original :math:`S.\SELEMS`, the new global instance must be an :ref:`extension <extend-eleminst>` of the old.

* For each :ref:`data instance <syntax-datainst>` :math:`\datainst_i` in the original :math:`S.\SDATAS`, the new global instance must be an :ref:`extension <extend-datainst>` of the old.

.. math::
   \frac{
     \begin{array}{@{}ccc@{}}
     S_1.\SFUNCS = \funcinst_1^\ast &
     S_2.\SFUNCS = {\funcinst'_1}^\ast~\funcinst_2^\ast &
     (\vdashfuncinstextends \funcinst_1 \extendsto \funcinst'_1)^\ast \\
     S_1.\STABLES = \tableinst_1^\ast &
     S_2.\STABLES = {\tableinst'_1}^\ast~\tableinst_2^\ast &
     (\vdashtableinstextends \tableinst_1 \extendsto \tableinst'_1)^\ast \\
     S_1.\SMEMS = \meminst_1^\ast &
     S_2.\SMEMS = {\meminst'_1}^\ast~\meminst_2^\ast &
     (\vdashmeminstextends \meminst_1 \extendsto \meminst'_1)^\ast \\
     S_1.\SGLOBALS = \globalinst_1^\ast &
     S_2.\SGLOBALS = {\globalinst'_1}^\ast~\globalinst_2^\ast &
     (\vdashglobalinstextends \globalinst_1 \extendsto \globalinst'_1)^\ast \\
     S_1.\SELEMS = \eleminst_1^\ast &
     S_2.\SELEMS = {\eleminst'_1}^\ast~\eleminst_2^\ast &
     (\vdasheleminstextends \eleminst_1 \extendsto \eleminst'_1)^\ast \\
     S_1.\SDATAS = \datainst_1^\ast &
     S_2.\SDATAS = {\datainst'_1}^\ast~\datainst_2^\ast &
     (\vdashdatainstextends \datainst_1 \extendsto \datainst'_1)^\ast \\
     \end{array}
   }{
     \vdashstoreextends S_1 \extendsto S_2
   }


.. index:: function instance
.. _extend-funcinst:

:ref:`Function Instance <syntax-funcinst>` :math:`\funcinst`
............................................................

* A function instance must remain unchanged.

.. math::
   \frac{
   }{
     \vdashfuncinstextends \funcinst \extendsto \funcinst
   }


.. index:: table instance
.. _extend-tableinst:

:ref:`Table Instance <syntax-tableinst>` :math:`\tableinst`
...........................................................

* The :ref:`table type <syntax-tabletype>` :math:`\tableinst.\TITYPE` must remain unchanged.

* The length of :math:`\tableinst.\TIELEM` must not shrink.

.. math::
   \frac{
     n_1 \leq n_2
   }{
     \vdashtableinstextends \{\TITYPE~\X{tt}, \TIELEM~(\X{fa}_1^?)^{n_1}\} \extendsto \{\TITYPE~\X{tt}, \TIELEM~(\X{fa}_2^?)^{n_2}\}
   }


.. index:: memory instance
.. _extend-meminst:

:ref:`Memory Instance <syntax-meminst>` :math:`\meminst`
........................................................

* The :ref:`memory type <syntax-memtype>` :math:`\meminst.\MITYPE` must remain unchanged.

* The length of :math:`\meminst.\MIDATA` must not shrink.

.. math::
   \frac{
     n_1 \leq n_2
   }{
     \vdashmeminstextends \{\MITYPE~\X{mt}, \MIDATA~b_1^{n_1}\} \extendsto \{\MITYPE~\X{mt}, \MIDATA~b_2^{n_2}\}
   }


.. index:: global instance, value, mutability
.. _extend-globalinst:

:ref:`Global Instance <syntax-globalinst>` :math:`\globalinst`
..............................................................

* The :ref:`global type <syntax-globaltype>` :math:`\globalinst.\GITYPE` must remain unchanged.

* Let :math:`\mut~t` be the structure of :math:`\globalinst.\GITYPE`.

* If :math:`\mut` is |MCONST|, then the :ref:`value <syntax-val>` :math:`\globalinst.\GIVALUE` must remain unchanged.

.. math::
   \frac{
     \mut = \MVAR \vee \val_1 = \val_2
   }{
     \vdashglobalinstextends \{\GITYPE~(\mut~t), \GIVALUE~\val_1\} \extendsto \{\GITYPE~(\mut~t), \GIVALUE~\val_2\}
   }


.. index:: element instance
.. _extend-eleminst:

:ref:`Element Instance <syntax-eleminst>` :math:`\eleminst`
...........................................................

* The vector :math:`\eleminst.\EIELEM` must either remain unchanged or shrink to length :math:`0`.

.. math::
   \frac{
     \X{fa}_1^\ast = \X{fa}_2^\ast \vee \X{fa}_2^\ast = \epsilon
   }{
     \vdasheleminstextends \{\EIELEM~\X{fa}_1^\ast\} \extendsto \{\EIELEM~\X{fa}_2^\ast\}
   }


.. index:: data instance
.. _extend-datainst:

:ref:`Data Instance <syntax-datainst>` :math:`\datainst`
........................................................

* The vector :math:`\datainst.\DIDATA` must either remain unchanged or shrink to length :math:`0`.

.. math::
   \frac{
     b_1^\ast = b_2^\ast \vee b_2^\ast = \epsilon
   }{
     \vdashdatainstextends \{\DIDATA~b_1^\ast\} \extendsto \{\DIDATA~b_2^\ast\}
   }



.. index:: ! preservation, ! progress, soundness, configuration, thread, terminal configuration, instantiation, invocation, validity, module
.. _soundness-statement:

Theorems
~~~~~~~~

Given the definition of :ref:`valid configurations <valid-config>`,
the standard soundness theorems hold. [#cite-cpp2018]_ [#cite-fm2021]_

**Theorem (Preservation).**
If a :ref:`configuration <syntax-config>` :math:`S;T` is :ref:`valid <valid-config>` with :ref:`result type <syntax-resulttype>` :math:`[t^\ast]` (i.e., :math:`\vdashconfig S;T : [t^\ast]`),
and steps to :math:`S';T'` (i.e., :math:`S;T \stepto S';T'`),
then :math:`S';T'` is a valid configuration with the same result type (i.e., :math:`\vdashconfig S';T' : [t^\ast]`).
Furthermore, :math:`S'` is an :ref:`extension <extend-store>` of :math:`S` (i.e., :math:`\vdashstoreextends S \extendsto S'`).

A *terminal* :ref:`thread <syntax-thread>` is one whose sequence of :ref:`instructions <syntax-instr>` is a :ref:`result <syntax-result>`.
A terminal configuration is a configuration whose thread is terminal.

**Theorem (Progress).**
If a :ref:`configuration <syntax-config>` :math:`S;T` is :ref:`valid <valid-config>` (i.e., :math:`\vdashconfig S;T : [t^\ast]` for some :ref:`result type <syntax-resulttype>` :math:`[t^\ast]`),
then either it is terminal,
or it can step to some configuration :math:`S';T'` (i.e., :math:`S;T \stepto S';T'`).

From Preservation and Progress the soundness of the WebAssembly type system follows directly.

**Corollary (Soundness).**
If a :ref:`configuration <syntax-config>` :math:`S;T` is :ref:`valid <valid-config>` (i.e., :math:`\vdashconfig S;T : [t^\ast]` for some :ref:`result type <syntax-resulttype>` :math:`[t^\ast]`),
then it either diverges or takes a finite number of steps to reach a terminal configuration :math:`S';T'` (i.e., :math:`S;T \stepto^\ast S';T'`) that is valid with the same result type (i.e., :math:`\vdashconfig S';T' : [t^\ast]`)
and where :math:`S'` is an :ref:`extension <extend-store>` of :math:`S` (i.e., :math:`\vdashstoreextends S \extendsto S'`).

In other words, every thread in a valid configuration either runs forever, traps, or terminates with a result that has the expected type.
Consequently, given a :ref:`valid store <valid-store>`, no computation defined by :ref:`instantiation <exec-instantiation>` or :ref:`invocation <exec-invocation>` of a valid module can "crash" or otherwise (mis)behave in ways not covered by the :ref:`execution <exec>` semantics given in this specification.


.. [#cite-pldi2017]
   The formalization and theorems are derived from the following article:
   Andreas Haas, Andreas Rossberg, Derek Schuff, Ben Titzer, Dan Gohman, Luke Wagner, Alon Zakai, JF Bastien, Michael Holman. |PLDI2017|_. Proceedings of the 38th ACM SIGPLAN Conference on Programming Language Design and Implementation (PLDI 2017). ACM 2017.

.. [#cite-cpp2018]
   A machine-verified version of the formalization and soundness proof of the PLDI 2017 paper is described in the following article:
   Conrad Watt. |CPP2018|_. Proceedings of the 7th ACM SIGPLAN Conference on Certified Programs and Proofs (CPP 2018). ACM 2018.

.. [#cite-fm2021]
   Machine-verified formalizations and soundness proofs of the semantics from the official specification are described in the following article:
   Conrad Watt, Xiaojia Rao, Jean Pichon-Pharabod, Martin Bodin, Philippa Gardner. |FM2021|_. Proceedings of the 24th International Symposium on Formal Methods (FM 2021). Springer 2021.

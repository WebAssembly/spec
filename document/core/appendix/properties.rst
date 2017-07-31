.. index:: ! soundness, type system
.. _soundness:

Soundness
---------

The :ref:`type system <type-system>` of WebAssembly is *sound*, implying both *type safety* and *memory safety* with respect to the WebAssembly semantics. For example:

* All types declared and derived during validation are respected at run time;
  e.g., every :ref:`local <syntax-local>` or :ref:`global <syntax-global>` variable will only contain type-correct values, every :ref:`instruction <syntax-instr>` will only be applied to operands of the expected type, and every :ref:`function <syntax-func>` :ref:`invocation <exec-invocation>` always evaluates to a result of the right type.

* No memory location will be read or written except those explicitly defined by the program, i.e., as a :ref:`local <syntax-local>`, a :ref:`global <syntax-global>`, an element in a :ref:`table <syntax-table>`, or a location within a linear :ref:`memory <syntax-mem>`.

* There is no undefined behaviour,
  i.e., the :ref:`execution rules <exec>` cover all possible cases that can occur in a :ref:`valid <valid>` program, and the rules are mutually consistent.

Soundness also is instrumental in ensuring additional properties, most notably, *encapsulation* of function and module scopes: no :ref:`locals <syntax-local>` can be accessed outside their own function and no :ref:`module <syntax-module>` components can be accessed outside their own module unless they are explicitly :ref:`exported <syntax-export>` or :ref:`imported <syntax-import>`.

The typing rules defining WebAssembly :ref:`validation <valid>` only cover the *static* components of a WebAssembly program.
In order to state and prove soundness precisely, the typing rules must be extended to the *dynamic* components of the abstract :ref:`runtime <syntax-runtime>`, that is, the :ref:`store <syntax-store>`, :ref:`configurations <syntax-config>`, and :ref:`administrative instructions <syntax-instr-admin>` as well as :ref:`module instructions <valid-moduleinstr>`. [#pldi2017]_


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

* Each :ref:`global instance <syntax-globalinst>` :math:`\globalinst_i` in :math:`S.\SGLOBALS` must be :ref:`valid <valid-globalinst>` with some optional  :ref:`global type <syntax-globaltype>` :math:`\globaltype_i^?`.

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
     (S \vdashglobalinst \globalinst : \globaltype^?)^\ast
     \\
     S = \{
       \SFUNCS~\funcinst^\ast,
       \STABLES~\tableinst^\ast,
       \SMEMS~\meminst^\ast,
       \SGLOBALS~\globalinst^\ast \}
     \end{array}
   }{
     \vdashstore S \ok
   }


.. index:: function type, function instance
.. _valid-funcinst:

:ref:`Function Instance <syntax-funcinst>` :math:`\{\FITYPE~\functype, \FIMODULE~\moduleinst, \FICODE~\func\}`
......................................................................................................................

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


.. index:: table type, table instance, limits, function address
.. _valid-tableinst:

:ref:`Table Instance <syntax-tableinst>` :math:`\{ \TIELEM~(\X{fa}^?)^n, \TIMAX~m^? \}`
.............................................................................................

* For each optional :ref:`function address <syntax-funcaddr>` :math:`\X{fa}^?_i` in the table elements :math:`(\X{fa}^?)^n`:

  * Either :math:`\X{fa}^?_i` is empty.

  * Or the :ref:`external value <syntax-externval>` :math:`\EVFUNC~\X{fa}` must be :ref:`valid <valid-externval-func>` with some :ref:`external type <syntax-externtype>` :math:`\ETFUNC~\X{ft}`.

* The :ref:`limits <syntax-limits>` :math:`\{\LMIN~n, \LMAX~m^?\}` must be :ref:`valid <valid-limits>`.

* Then the table instance is valid with :ref:`table type <syntax-tabletype>` :math:`\{\LMIN~n, \LMAX~m^?\}~\ANYFUNC`.

.. math::
   \frac{
     ((S \vdash \EVFUNC~\X{fa} : \ETFUNC~\functype)^?)^n
     \qquad
     \vdashlimits \{\LMIN~n, \LMAX~m^?\} \ok
   }{
     S \vdashtableinst \{ \TIELEM~(\X{fa}^?)^n, \TIMAX~m^? \} : \{\LMIN~n, \LMAX~m^?\}~\ANYFUNC
   }


.. index:: memory type, memory instance, limits, byte
.. _valid-meminst:

:ref:`Memory Instance <syntax-meminst>` :math:`\{ \MIDATA~b^n, \MIMAX~m^? \}`
.............................................................................

* The :ref:`limits <syntax-limits>` :math:`\{\LMIN~n, \LMAX~m^?\}` must be :ref:`valid <valid-limits>`.

* Then the memory instance is valid with :ref:`memory type <syntax-memtype>` :math:`\{\LMIN~n, \LMAX~m^?\}`.

.. math::
   \frac{
     \vdashlimits \{\LMIN~n, \LMAX~m^?\} \ok
   }{
     S \vdashmeminst \{ \MIDATA~b^n, \MIMAX~m^? \} : \{\LMIN~n, \LMAX~m^?\}
   }


.. index:: global type, global instance, value, mutability
.. _valid-globalinst:

:ref:`Global Instance <syntax-globalinst>` :math:`\{ \GIVALUE~(t.\CONST~c), \GIMUT~\mut \}`
...........................................................................................

* The global instance is valid with :ref:`global type <syntax-globaltype>` :math:`\mut~t`.

.. math::
   \frac{
   }{
     S \vdashglobalinst \{ \GIVALUE~(t.\CONST~c), \GIMUT~\mut \} : \mut~t
   }


.. index:: external type, export instance, name, external value
.. _valid-exportinst:

:ref:`Export Instance <syntax-exportinst>` :math:`\{ \EINAME~\name, \EIVALUE~\externval \}`
......................................................................................................

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

:ref:`Module Instance <syntax-moduleinst>` :math:`\moduleinst`
..............................................................

* Each :ref:`function type <syntax-functype>` :math:`\functype_i` in :math:`\moduleinst.\MITYPES` must be :ref:`valid <valid-functype>`.

* For each :ref:`function address <syntax-funcaddr>` :math:`\funcaddr_i` in :math:`\moduleinst.\MIFUNCS`, the :ref:`external value <syntax-externval>` :math:`\EVFUNC~\funcaddr_i` must be :ref:`valid <valid-externval-func>` with some :ref:`external type <syntax-externtype>` :math:`\ETFUNC~\functype'_i`.

* For each :ref:`table address <syntax-tableaddr>` :math:`\tableaddr_i` in :math:`\moduleinst.\MITABLES`, the :ref:`external value <syntax-externval>` :math:`\EVTABLE~\tableaddr_i` must be :ref:`valid <valid-externval-table>` with some :ref:`external type <syntax-externtype>` :math:`\ETTABLE~\tabletype_i`.

* For each :ref:`memory address <syntax-memaddr>` :math:`\memaddr_i` in :math:`\moduleinst.\MIMEMS`, the :ref:`external value <syntax-externval>` :math:`\EVMEM~\memaddr_i` must be :ref:`valid <valid-externval-mem>` with some :ref:`external type <syntax-externtype>` :math:`\ETMEM~\memtype_i`.

* For each :ref:`global address <syntax-globaladdr>` :math:`\globaladdr_i` in :math:`\moduleinst.\MIGLOBALS`, the :ref:`external value <syntax-externval>` :math:`\EVGLOBAL~\globaladdr_i` must be :ref:`valid <valid-externval-global>` with some :ref:`external type <syntax-externtype>` :math:`\ETGLOBAL~\globaltype_i`.

* Each :ref:`export instance <syntax-exportinst>` :math:`\exportinst_i` in :math:`\moduleinst.\MIEXPORTS` must be :ref:`valid <valid-exportinst>`.

* For each :ref:`export instance <syntax-exportinst>` :math:`\exportinst_i` in :math:`\moduleinst.\MIEXPORTS`, the :ref:`name <syntax-name>` :math:`\exportinst_i.\EINAME` must be different from any other name occurring in :math:`\moduleinst.\MIEXPORTS`.

* Let :math:`{\functype'}^\ast` be the concatenation of all :math:`\functype'_i` in order.

* Let :math:`\tabletype^\ast` be the concatenation of all :math:`\tabletype_i` in order.

* Let :math:`\memtype^\ast` be the concatenation of all :math:`\memtype_i` in order.

* Let :math:`\globaltype^\ast` be the concatenation of all :math:`\globaltype_i` in order.

* Then the module instance is valid with :ref:`context <context>` :math:`\{\CTYPES~\functype^\ast, \CFUNCS~{\functype'}^\ast, \CTABLES~\tabletype^\ast, \CMEMS~\memtype^\ast, \CGLOBALS~\globaltype^\ast\}`.

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
       \MIGLOBALS & \globaladdr^\ast \\
       \MIEXPORTS & \exportinst^\ast ~\} : \{
         \begin{array}[t]{@{}l@{~}l@{}}
         \CTYPES & \functype^\ast, \\
         \CFUNCS & {\functype'}^\ast, \\
         \CTABLES & \tabletype^\ast, \\
         \CMEMS & \memtype^\ast, \\
         \CGLOBALS & \globaltype^\ast ~\}
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

Threads may either be regular threads executing sequences of :ref:`instructions <syntax-instr>`, or module threads executing :ref:`module instructions <synax-moduleinstr>` that represent an ongoing module instantiation.
Regular threads are classified by their :ref:`result type <syntax-resulttype>`.
Module threads on the other hand have no result, not even an empty one.
Consequently, threads and configurations are cumutavily classified by an *optional* result type, where :math:`\epsilon` classifies the thread as a module computation.

In addition to the store :math:`S`, threads are typed under a *return type* :math:`\resulttype^?`, which controls whether and with which type a |return| instruction is allowed.
This type is :math:`\epsilon`, except for instruction sequences inside an administrative |FRAME| instruction.

Finally, :ref:`frames <syntax-frame>` are classified with *frame contexts*, which extend the :ref:`module contexts <module-context>` of a frame's associated :ref:`module instance <syntax-moduleinst>` with the :ref:`locals <syntax-local>` that the frame contains.


.. index:: result type, thread

:ref:`Configurations <syntax-config>` :math:`S;T`
.................................................

* The :ref:`store <syntax-store>` :math:`S` must be :ref:`valid <valid-store>`.

* Under no allowed return type,
  the :ref:`thread <syntax-thread>` :math:`T` must be :ref:`valid <valid-thread>` with some optional :ref:`result type <syntax-resulttype>` :math:`[t^?]^?`.

* Then the configuration is valid with the optional :ref:`result type <syntax-resulttype>` :math:`[t^?]^?`.

.. math::
   \frac{
     \vdashstore S \ok
     \qquad
     S; \epsilon \vdashthread T : [t^?]^?
   }{
     \vdashconfig S; T : [t^?]^?
   }


.. index:: thread, frame, instruction, result type, context
.. _valid-thread:

:ref:`Threads <syntax-thread>` :math:`F;\instr^\ast`
....................................................

* Let :math:`\resulttype^?` be the current allowed return type.

* The :ref:`frame <syntax-frame>` :math:`F` must be :ref:`valid <valid-frame>` with a :ref:`context <context>` :math:`C`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with |CRETURN| set to :math:`\resulttype^?`.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instr-seq>` with some type :math:`[] \to [t^?]`.

* Then the thread is valid with the :ref:`result type <syntax-resulttype>` :math:`[t^?]`.

.. math::
   \frac{
     S \vdashframe F : C
     \qquad
     S; C,\CRETURN~\resulttype^? \vdashinstrseq \instr^\ast : [] \to [t^?]
   }{
     S; \resulttype^? \vdashthread F; \instr^\ast : [t^?]
   }


.. index:: thread, module instruction

:ref:`Threads <syntax-thread>` :math:`\moduleinstr^\ast`
........................................................

* The current allowed return type must be empty.

* Each :ref:`module instruction <syntax-moduleinstr>` :math:`\moduleinstr_i` in :math:`\moduleinstr^\ast` must be :ref:`valid <valid-moduleinstr>`.

* Then the thread is valid with no :ref:`result type <syntax-resulttype>`.

.. math::
   \frac{
     (S \vdashmoduleinstr \moduleinstr \ok)^\ast
   }{
     S; \epsilon \vdashthread \moduleinstr^\ast : \epsilon
   }


.. index:: frame, local, module instance, value, value type, context
.. _valid-frame:

:ref:`Frames <syntax-frame>` :math:`\{\ALOCALS~\val^\ast, \AMODULE~\moduleinst\}`
.................................................................................

* The :ref:`module instance <syntax-moduleinst>` :math:`\moduleinst` must be :ref:`valid <valid-moduleinst>` with some :ref:`module context <module context>` :math:`C`.

* Each :ref:`value <syntax-val>` :math:`\val_i` in :math:`\val^\ast` must be :ref:`valid <valid-val>` with some :ref:`value type <syntax-valtype>` :math:`t_i`.

* Let :math:`t^\ast` the concatenation of all :math:`t_i` in order.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`value types <syntax-valtype>` :math:`t^\ast` prepended to the |CLOCALS| vector.

* Then the frame is valid with :ref:`frame context <frame-context>` :math:`C'`.

.. math::
   \frac{
     S \vdashmoduleinst \moduleinst : C
     \qquad
     (\vdashval \val : t)^\ast
   }{
     S \vdashframe \{\ALOCALS~\val^\ast, \AMODULE~\moduleinst\} : (C, \CLOCALS~t^\ast)
   }


.. index:: value, value type
.. _valid-val:

:ref:`Values <syntax-val>` :math:`t.\CONST~c`
.............................................

* The value is valid with :ref:`value type <syntax-valtype>` :math:`t`.

.. math::
   \frac{
   }{
     \vdashval t.\CONST~c : t
   }


.. index:: administrative instruction, value type, context, store
.. _valid-instr-admin:

Administrative Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Typing rules for :ref:`administrative instructions <syntax-instr-admin>` are specified as follows.
In addition to the :ref:`context <contxt>` :math:`C`, typing of these instructions is defined under a given :ref:`store <syntax-store>` :math:`S`.
To that end, all previous typing judgements :math:`C \vdash \X{prop}` are generalized to include the store, as in :math:`S; C \vdash \X{prop}`, by implicitly adding :math:`S` to all rules -- :math:`S` is never modified by the pre-existing rules, but it is accessed in the new rules for :ref:`administrative instructions <valid-instr-admin>` and  :ref:`module instructions <valid-moduleinstr>` given below.


.. index:: trap

:math:`\TRAP`
.............

* The instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`, for any sequences of :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.

.. math::
   \frac{
   }{
     S; C \vdashadmininstr \TRAP : [t_1^\ast] \to [t_2^\ast]
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

* The instruction sequence :math:`\instr_0^\ast` must be :ref:`valid <valid-instr-seq>` with some type :math:`[t_1^n] \to [t_2^?]`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`result type <syntax-resulttype>` :math:`[t_1^n]` prepended to the |CLABELS| vector.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[] \to [t_2^?]`.

* Then the compound instruction is valid with type :math:`[] \to [t_2^?]`.

.. math::
   \frac{
     S; C \vdashinstrseq \instr_0^\ast : [t_1^n] \to [t_2^?]
     \qquad
     S; C,\CLABELS\,[t_1^n] \vdashinstrseq \instr^\ast : [] \to [t_2^?]
   }{
     S; C \vdashadmininstr \LABEL_n\{\instr_0^\ast\}~\instr^\ast~\END : [] \to [t_2^?]
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


.. index:: module instruction, store
.. _valid-moduleinstr:

Module Instructions
~~~~~~~~~~~~~~~~~~~

Typing rules for :ref:`module instructions <valid-moduleinstr>` are specified as follows.
Unlike regular instructions, module instructions do not use the operand stack, and consequently, are not classified by a type.


.. index:: instantiation, external value, external type

:math:`\INSTANTIATE~\module~\externval^\ast`
............................................

* Each :ref:`external value <syntax-externval>` :math:`\externval_i` in :math:`\externval^\ast` must be :ref:`valid <valid-externval>` with some :ref:`external type <syntax-externtype>` :math:`\externtype_i`.

* Then the module instruction is valid.

.. math::
   \frac{
     (S \vdashexternval \externval : \externtype)^\ast
   }{
     S \vdashmoduleinstr \INSTANTIATE~\module~\externval^\ast \ok
   }


.. index:: element, table, table address, module instance, function index

:math:`\INITELEM~\tableaddr~o~\moduleinst~x^n`
..............................................

* The :ref:`external table value <syntax-externval>` :math:`\EVTABLE~\tableaddr` must be :ref:`valid <valid-externval-table>` with some :ref:`external table type <syntax-externtype>` :math:`\ETTABLE~\limits~\ANYFUNC`.

* The index :math:`o + n` must be smaller than or equal to :math:`\limits.\LMIN`.

* The :ref:`module instance <syntax-moduleinst>` :math:`\moduleinst` must be :ref:`valid <valid-moduleinst>` with some :ref:`context <context>` :math:`C`.

* Each :ref:`function index <syntax-funcidx>` :math:`x_i` in :math:`x^n` must be defined in the context :math:`C`.

* Then the module instruction is valid.

.. math::
   \frac{
     \begin{array}{@{}rl@{}}
     S \vdashexternval \EVTABLE~\tableaddr : \ETTABLE~\limits~\ANYFUNC
     \qquad&
     o + n \leq \limits.\LMIN
     \\
     S \vdashmoduleinst \moduleinst : C
     \qquad&
     (C.\CFUNCS[x] = \functype)^n
     \end{array}
   }{
     S \vdashmoduleinstr \INITELEM~\tableaddr~o~\moduleinst~x^n \ok
   }


.. index:: data, memory, memory address, byte

:math:`\INITDATA~\memaddr~o~b^n`
................................

* The :ref:`external memory value <syntax-externval>` :math:`\EVMEM~\memaddr` must be :ref:`valid <valid-externval-mem>` with some :ref:`external memory type <syntax-externtype>` :math:`\ETMEM~\limits`.

* The index :math:`o + n` must be smaller than or equal to :math:`\limits.\LMIN` divided by the :ref:`page size <page-size>` :math:`64\,\F{Ki}`.

* Then the module instruction is valid.

.. math::
   \frac{
     S \vdashexternval \EVMEM~\memaddr : \ETMEM~\limits
     \qquad
     o + n \leq \limits.\LMIN \cdot 64\,\F{Ki}
   }{
     S \vdashmoduleinstr \INITDATA~\memaddr~o~b^n \ok
   }


.. index:: instruction, context

:math:`\instr`
..............

* Under an empty :ref:`context <context>`,
  the :ref:`instruction <syntax-instr>` :math:`\instr` must be valid with type :math:`[] \to []`.

* Then the instruction is valid as a module instruction.

.. math::
   \frac{
     S; \{\} \vdashinstr \instr : [] \to []
   }{
     S \vdashmoduleinstr \instr \ok
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
   Extension does not imply that the new store is valid, which is defined :ref:separately `above <valid-store>`.


.. index:: store, function instance, table instance, memory instance, global instance
.. _extend-store:

:ref:`Store <syntax-store>` :math:`S`
.....................................

* The length of :math:`S.\SFUNCS` must not shrink.

* The length of :math:`S.\STABLES` must not shrink.

* The length of :math:`S.\SMEMS` must not shrink.

* The length of :math:`S.\SGLOBALS` must not shrink.

* For each :ref:`function instance <syntax-funcinst>` :math:`\funcinst_i` in the original :math:`S.\SFUNCS`, the new function instance must be an :ref:`extension <extend-funcinst>` of the old.

* For each :ref:`table instance <syntax-tableinst>` :math:`\tableinst_i` in the original :math:`S.\STABLES`, the new table instance must be an :ref:`extension <extend-tableinst>` of the old.

* For each :ref:`memory instance <syntax-meminst>` :math:`\meminst_i` in the original :math:`S.\SMEMS`, the new memory instance must be an :ref:`extension <extend-meminst>` of the old.

* For each :ref:`global instance <syntax-globalinst>` :math:`\globalinst_i` in the original :math:`S.\SGLOBALS`, the new global instance must be an :ref:`extension <extend-globalinst>` of the old.

.. math::
   \frac{
     \begin{array}{@{}ccc@{}}
     S_1.\SFUNCS = \funcinst_1^\ast &
     S_2.\SFUNCS = {\funcinst'_1}^\ast~\funcinst_2^\ast &
     (\funcinst_1 \extendsto \funcinst'_1)^\ast \\
     S_1.\STABLES = \tableinst_1^\ast &
     S_2.\STABLES = {\tableinst'_1}^\ast~\tableinst_2^\ast &
     (\tableinst_1 \extendsto \tableinst'_1)^\ast \\
     S_1.\SMEMS = \meminst_1^\ast &
     S_2.\SMEMS = {\meminst'_1}^\ast~\meminst_2^\ast &
     (\meminst_1 \extendsto \meminst'_1)^\ast \\
     S_1.\SGLOBALS = \globalinst_1^\ast &
     S_2.\SGLOBALS = {\globalinst'_1}^\ast~\globalinst_2^\ast &
     (\globalinst_1 \extendsto \globalinst'_1)^\ast \\
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

* The length of :math:`\tableinst.\TIELEM` must not shrink.

* The value of :math:`\tableinst.\TIMAX` must remain unchanged.

.. math::
   \frac{
     n_1 \leq n_2
   }{
     \vdashtableinstextends \{\TIELEM~(\X{fa}_1^?)^{n_1}, \TIMAX~m\} \extendsto \{\TIELEM~(\X{fa}_2^?)^{n_2}, \TIMAX~m\}
   }


.. index:: memory instance
.. _extend-meminst:

:ref:`Memory Instance <syntax-meminst>` :math:`\meminst`
........................................................

* The length of :math:`\meminst.\MIDATA` must not shrink.

* The value of :math:`\meminst.\MIMAX` must remain unchanged.

.. math::
   \frac{
     n_1 \leq n_2
   }{
     \vdashmeminstextends \{\MIDATA~b_1^{n_1}, \MIMAX~m\} \extendsto \{\MIDATA~b_2^{n_2}, \MIMAX~m\}
   }


.. index:: global instance, value, mutability
.. _extend-globalinst:

:ref:`Global Instance <syntax-globalinst>` :math:`\globalinst`
..............................................................

* The :ref:`mutability <syntax-mut>` :math:`\globalinst.\GIMUT` must remain unchanged.

* The :ref:`value type <syntax-valtype>` of the :ref:`value <syntax-val>` :math:`\globalinst.\GIVALUE` must remain unchanged.

* If :math:`\globalinst.\GIMUT` is |MCONST|, then the :ref:`value <syntax-val>` :math:`\globalinst.\GIVALUE` must remain unchanged.

.. math::
   \frac{
     \mut = \MVAR \vee c_1 = c_2
   }{
     \vdashglobalinstextends \{\GIVALUE~(t.\CONST~c_1), \GIMUT~\mut\} \extendsto \{\GIVALUE~(t.\CONST~c_2), \GIMUT~\mut\}
   }



.. index:: ! preservation, ! progress, soundness, configuration, thread, terminal configuration, instantiation, invocation, validity, module
.. _soundness-statement:

Theorems
~~~~~~~~

Given the definition of :ref:`valid configurations <valid-config>`,
the standard soundness theorems hold.

**Theorem (Preservation).**
If the :ref:`configuration <syntax-config>` :math:`S;T` is :ref:`valid <valid-config>` with optional :ref:`result type <syntax-resulttype>` :math:`[t^\ast]^?` (i.e., :math:`\vdashconfig S;T : [t^\ast]^?`),
and steps to :math:`S';T'` (i.e., :math:`S;T \stepto S';T'`),
then :math:`S';T'` is a valid configuration with the same optional resulttype (i.e., :math:`\vdashconfig S';T' : [t^\ast]^?`).
Furthermore, :math:`S'` is an :ref:`extension <extend-store>` of :math:`S` (i.e., :math:`\vdashstoreextends S \extendsto S'`).

A *terminal* :ref:`thread <syntax-thread>` is either an empty sequence of :ref:`module instructions <syntax-moduleinstr>`, a |TRAP| instruction, or a sequence :math:`\val^\ast` of :ref:`values <syntax-val>` (paired with a :ref:`frame <syntax-frame>`).
A terminal configuration is a configuration whose thread is terminal.

**Theorem (Progress).**
If the :ref:`configuration <syntax-config>` :math:`S;T` is :ref:`valid <valid-config>` (i.e., :math:`\vdashconfig S;T : [t^\ast]^?` with some optional :ref:`result type <syntax-resulttype>` :math:`[t^\ast]^?`),
then either it is terminal,
or it can step to some configuration :math:`S';T'` (i.e., :math:`S;T \stepto S';T'`).

From Preservation and Progress the soundness of the WebAssembly type system follows directly.

**Corollary (Soundness).**
Every thread in a valid configuration either runs forever, traps, or terminates with a result that has the expected type.

Consequently, given a :ref:`valid store <valid-store>`, no computation defined by :ref:`instantiation <exec-instantiation>` or :ref:`invocation <exec-invocation>` of a valid module can "crash" or otherwise (mis)behave in ways not covered by the :ref:`execution <exec>` semantics given in this specification.


.. [#pldi2017]
   The formalization and theorems are derived from the following article:
   Andreas Haas, Andreas Rossberg, Derek Schuff, Ben Titzer, Dan Gohman, Luke Wagner, Alon Zakai, JF Bastien, Michael Holman. `Bringing the Web up to Speed with WebAssembly <https://dl.acm.org/citation.cfm?doid=3062341.3062363>`_. Proceedings of the 38th ACM SIGPLAN Conference on Programming Language Design and Implementation (PLDI 2017). ACM 2017.

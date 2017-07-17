.. _soundness:

Soundness
---------

The :ref:`type system <type-system>` of WebAssembly is *sound*, implying both *type safety* and *memory safety* with respect to the WebAssembly semantics. For example:

* All types declared and derived during validation are respected at run time;
  e.g., every :ref:`local <syntax-local>` or :ref:`global <syntax-global>` variable will only contain type-correct values, every :ref:`instruction <syntax-instr>` will only see operands of the expected type, and every :ref:`function <syntax-func>` :ref:`invocation <exec-invocation>` always evaluates to a result of the right type.

* No memory location can be read or written except those explicitly defined by the program, i.e., as a :ref:`local <syntax-local>`, a :ref:`global <syntax-global>`, an element in a :ref:`table <syntax-table>`, or a location within a linear :ref:`memory <syntax-mem>`.

* There is no undefined behaviour;
  i.e., the :ref:`execution rules <exec>` cover all possible cases that can occur in a :ref:`valid <valid>` program, and define them consistently.

Soundness also is instrumental in ensuring additional properties, most notably, *encapsulation* at function and module boundaries: no :ref:`locals <syntax-local>` can be accessed outside their own function, and no :ref:`module <syntax-module>` components can be accessed outside their own module, unless they are explicitly :ref:`exported <syntax-export>` or :ref:`imported <syntax-import>`.

To state and prove soundness precisely, a few additional definitions concerning the abstract :ref:`runtime <syntax-runtime>` are required.


.. index:: ! store extension, store
.. _extend:

Store Extension
~~~~~~~~~~~~~~~

The :ref:`store <syntax-store>` and its contained instances can be mutated by programs.
Any such modification has to respect certain invariants.
These invariants are inherent to the WebAssembly execution semantics,
but :ref:`host functions <syntax-hostfunc>` do not automatically adhere to them, so they need to be required explicitly when :ref:`invoking <exec-invoke-host>` a host function.

These restrictions are codified by the notion of store *extension*:
a store state :math:`S'` extends state :math:`S`, written :math:`S \extendsto S'`, when the rules defined below hold.

.. note::
   Extension does not imply that the new store is valid, which is defined :ref:`separately <valid-store>`.


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
     \vdash S_1 \extendsto S_2
   }


.. index:: function instance
.. _extend-funcinst:

:ref:`Function Instance <syntax-funcinst>` :math:`\funcinst`
............................................................

* A function instance must remain unchanged.

.. math::
   \frac{
   }{
     \vdash \funcinst \extendsto \funcinst
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
     \vdash \{\TIELEM~(\X{fa}_1^?)^{n_1}, \TIMAX~m\} \extendsto \{\TIELEM~(\X{fa}_2^?)^{n_2}, \TIMAX~m\}
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
     \vdash \{\MIDATA~b_1^{n_1}, \MIMAX~m\} \extendsto \{\MIDATA~b_2^{n_2}, \MIMAX~m\}
   }


.. index:: global instance, value, mutability
.. _extend-globalinst:

:ref:`Global Instance <syntax-globalinst>` :math:`\globalinst`
..............................................................

* The :ref:`mutability <syntax-mut>` :math:`\globalinst.\GIMUT` must remain unchanged.

* The :ref:`value type <syntax-valtype>` of the :ref:`value <syntax-val>` :math:`\globalinst.\GIVALUE` must remain unchanged.

* If :math:`\globalinst.\GIMUT` is |MCONST| and :math:`\globalinst.\GIVALUE` is not empty, then the :ref:`value <syntax-val>` :math:`\globalinst.\GIVALUE` must remain unchanged.

.. math::
   \frac{
     \mut = \MVAR \vee c_1 = c_2
   }{
     \vdash \{\GIVALUE~(t.\CONST~c_1), \GIMUT~\mut\} \extendsto \{\GIVALUE~(t.\CONST~c_2), \GIMUT~\mut\}
   }

.. math::
   ~\\[1ex]
   \frac{
   }{
     \vdash \{\GIVALUE~\epsilon, \GIMUT~\mut\} \extendsto \{\GIVALUE~(t.\CONST~c), \GIMUT~\mut\}
   }


.. _valid-store:

Store Validity
~~~~~~~~~~~~~~

The following typing rules specify when a runtime :ref:`store <syntax-store>` :math:`S` is *valid*.
A valid store must consist of
:ref:`function <syntax-funcinst>`, :ref:`table <syntax-tableinst>`, :ref:`memory <syntax-meminst>`, :ref:`global <syntax-globalinst>`, and :ref:`module <syntax-moduleinst>` instances that are themselves valid, relative to :math:`S`.


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
     (S \vdash \funcinst : \functype)^\ast
     \qquad
     (S \vdash \tableinst : \tabletype)^\ast
     \\
     (S \vdash \meminst : \memtype)^\ast
     \qquad
     (S \vdash \globalinst : \globaltype^?)^\ast
     \\
     S = \{
       \SFUNCS~\funcinst^\ast,
       \STABLES~\tableinst^\ast,
       \SMEMS~\meminst^\ast,
       \SGLOBALS~\globalinst^\ast \}
     \end{array}
   }{
     \vdash S \ok
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
     \vdash \functype \ok
     \qquad
     S \vdash \moduleinst : C
     \qquad
     C \vdash \func : \functype
   }{
     S \vdash \{\FITYPE~\functype, \FIMODULE~\moduleinst, \FICODE~\func\} : \functype
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
     (S \vdash \X{fa}^? \ok)^n
     \qquad
     \vdash \{\LMIN~n, \LMAX~m^?\} \ok
   }{
     S \vdash \{ \TIELEM~(\X{fa}^?)^n, \TIMAX~m^? \} : \{\LMIN~n, \LMAX~m^?\}~\ANYFUNC
   }

.. math::
   \frac{
   }{
     S \vdash \epsilon \ok
   }
   \qquad
   \frac{
     S \vdash \EVFUNC~\funcaddr : \ETFUNC~\functype
   }{
     S \vdash \funcaddr \ok
   }


.. index:: memory type, memory instance, limits, byte
.. _valid-meminst:

:ref:`Memory Instance <syntax-meminst>` :math:`\{ \MIDATA~b^n, \MIMAX~m^? \}`
.............................................................................

* The :ref:`limits <syntax-limits>` :math:`\{\LMIN~n, \LMAX~m^?\}` must be :ref:`valid <valid-limits>`.

* Then the memory instance is valid with :ref:`memory type <syntax-memtype>` :math:`\{\LMIN~n, \LMAX~m^?\}`.

.. math::
   \frac{
     \vdash \{\LMIN~n, \LMAX~m^?\} \ok
   }{
     S \vdash \{ \MIDATA~b^n, \MIMAX~m^? \} : \{\LMIN~n, \LMAX~m^?\}
   }


.. index:: global type, global instance, value, mutability
.. _valid-globalinst:

:ref:`Global Instance <syntax-globalinst>` :math:`\{ \GIVALUE~\val^?, \GIMUT~\mut \}`
.....................................................................................

* If :math:`\val^?` is a :ref:`value <syntax-val>` :math:`(t.\CONST~c)`, then:

  * The global instance is valid with :ref:`global type <syntax-globaltype>` :math:`\mut~t`.

* Else :math:`\val^?` is empty, and then:

  * The global instance is valid with empty type.

.. math::
   \frac{
   }{
     S \vdash \{ \GIVALUE~(t.\CONST~c), \GIMUT~\mut \} : \mut~t
   }
   \qquad
   \frac{
   }{
     S \vdash \{ \GIVALUE~\epsilon, \GIMUT~\mut \} : \epsilon
   }

.. note::
   An empty type indicates an uninitialized global.


.. index:: external type, export instance, name, external value
.. _valid-exportinst:

:ref:`Export Instance <syntax-exportinst>` :math:`\{ \EINAME~\name, \EIVALUE~\externval \}`
......................................................................................................

* The :ref:`external value <syntax-externval>` :math:`\externval` must be :ref:`valid <valid-externval>` with some :ref:`external type <syntax-externtype>` :math:`\externtype`.

* Then the export instance is valid.

.. math::
   \frac{
     S \vdash \externval : \externtype
   }{
     S \vdash \{ \EINAME~\name, \EIVALUE~\externval \} \ok
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
     (\vdash \functype \ok)^\ast
     \\
     (S \vdash \EVFUNC~\funcaddr : \ETFUNC~\functype')^\ast
     \qquad
     (S \vdash \EVTABLE~\tableaddr : \ETTABLE~\tabletype)^\ast
     \\
     (S \vdash \EVMEM~\memaddr : \ETMEM~\memtype)^\ast
     \qquad
     (S \vdash \EVGLOBAL~\globaladdr : \ETGLOBAL~\globaltype)^\ast
     \\
     (S \vdash \exportinst \ok)^\ast
     \qquad
     (\exportinst.\EINAME)^\ast ~\mbox{disjoint}
     \end{array}
   }{
     S \vdash \{
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


.. _valid-config:

Configuration Validity
~~~~~~~~~~~~~~~~~~~~~~

To state soundness theorems that relate the WebAssembly :ref:`type system <valid>` to its :ref:`execution semantics <exec>`, the :ref:`typing rules <valid-instr>` must be extended to :ref:`configurations <syntax-config>` :math:`S;T`,
which includes :ref:`runtime structures <syntax-runtime>` like the :ref:`store <syntax-store>` as well as :ref:`administrative instructions <syntax-instr-admin>` and  :ref:`module instructions <valid-moduleinstr>`.

To that end, all previous typing judgements :math:`C \vdash \X{prop}` are generalized to include the store, as in :math:`S; C \vdash \X{prop}`, by implicitly adding :math:`S` to all rules -- it is never modified by the pre-existing rules, but is accessed in new rules for :ref:`administrative instructions <valid-instr-admin>` and  :ref:`module instructions <valid-moduleinstr>`.

:ref:`Configurations <syntax-config>` :math:`S;T`
.................................................

* The :ref:`store <syntax-store>` :math:`S` must be :ref:`valid <valid-store>`.

* The :ref:`thread <syntax-thread>` :math:`T` must be :ref:`valid <valid-thread>` under no return type with some optional :ref:`result type <syntax-resulttype>` :math:`[t^?]^?`.

* Then the configuration is valid with the optional :ref:`result type <syntax-resulttype>` :math:`[t^?]^?`.

.. math::
   \frac{
     \vdash S \ok
     \qquad
     S; \epsilon \vdash T : [t^?]^?
   }{
     \vdash S; T : [t^?]^?
   }


.. _valid-thread:

:ref:`Threads <syntax-thread>` :math:`F;\instr^\ast` under return type :math:`\resulttype^?`
............................................................................................

* The :ref:`frame <syntax-frame>` :math:`F` must be :ref:`valid <valid-frame>` with :ref:`context <syntax-context>` :math:`C`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with |CRETURN| set to the optional :ref:`result type <syntax-resulttype>` :math:`\resulttype^?`.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instr-seq>` with some type :math:`[] \to [t^?]`.

* Then the thread is valid with the :ref:`result type <syntax-resulttype>` :math:`[t^?]`.

.. math::
   \frac{
     S \vdash F : C
     \qquad
     S; C,\CRETURN~\resulttype^? \vdash \instr^\ast : [] \to [t^?]
   }{
     S; \resulttype^? \vdash F; \instr^\ast : [t^?]
   }


:ref:`Threads <syntax-thread>` :math:`\moduleinstr^\ast` under return type :math:`\resulttype^?`
................................................................................................

* The optional :ref:`result type <syntax-resulttype>` :math:`\resulttype^?` must be empty.

* Each :ref:`module instruction <syntax-moduleinstr>` :math:`\moduleinstr_i` in :math:`\moduleinstr^\ast` must be :ref:`valid <valid-moduleinstr>`.

* Then the thread is valid with no :ref:`result type <syntax-resulttype>`.

.. math::
   \frac{
     (S \vdash \moduleinstr \ok)^\ast
   }{
     S; \epsilon \vdash \moduleinstr^\ast : \epsilon
   }


.. _valid-frame:

:ref:`Frame <syntax-frame>` :math:`\{\ALOCALS~\val^\ast, \AMODULE~\moduleinst\}`
................................................................................

* The :ref:`module instance <syntax-moduleinst>` :math:`\moduleinst` must be :ref:`valid <valid-moduleinst>` with some :ref:`context <context>` :math:`C`.

* Each :ref:`value <syntax-val>` :math:`\val_i` in :math:`\val^\ast` must be :ref:`valid <valid-val>` with some :ref:`value type <syntax-valtype>` :math:`t_i`.

* Let :math:`t^\ast` the concatenation of all :math:`t_i` in order.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`value types <syntax-valtype>` :math:`t^\ast` prepended to the |CLOCALS| vector.

* Then the frame is valid with context :math:`C'`.

.. math::
   \frac{
     S \vdash \moduleinst : C
     \qquad
     (\vdash \val : t)^\ast
   }{
     S \vdash \{\ALOCALS~\val^\ast, \AMODULE~\moduleinst\} : C, \CLOCALS~t^\ast
   }


.. _valid-val:

:ref:`Value <syntax-val>` :math:`t.\CONST~c`
............................................

* The value is valid with :ref:`value type <syntax-valtype>` :math:`t`.

.. math::
   \frac{
   }{
     \vdash t.\CONST~c : t
   }



.. _valid-instr-admin:

Administrative Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Typing rules for :ref:`administrative instructions <syntax-instr-admin>` are specified as follows.


:math:`\TRAP`
.............

* The instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`, for any sequences of :ref:`value types <syntax-valtype>` :math:`t_1^\ast` and :math:`t_2^\ast`.

.. math::
   \frac{
   }{
     S; C \vdash \TRAP : [t_1^\ast] \to [t_2^\ast]
   }


:math:`\INVOKE~\funcaddr`
.........................

* The :ref:`external function value <syntax-externval>` :math:`\EVFUNC~\funcaddr` must be :ref:`valid <valid-externval-func>` with :ref:`external function type <syntax-externtype>` :math:`\ETFUNC ([t_1^\ast] \to [t_2^\ast])`.

* Then the instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`.

.. math::
   \frac{
     S \vdash \EVFUNC~\funcaddr : \ETFUNC~[t_1^\ast] \to [t_2^\ast]
   }{
     S; C \vdash \INVOKE~\funcaddr : [t_1^\ast] \to [t_2^\ast]
   }


:math:`\LABEL_n\{\instr_0^\ast\}~\instr^\ast~\END`
..................................................

* The instruction sequence :math:`\instr_0^\ast` must be :ref:`valid <valid-instr-seq>` with some type :math:`[t_1^n] \to [t_2^?]`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`result type <syntax-resulttype>` :math:`[t_1^n]` prepended to the |CLABELS| vector.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[] \to [t_2^?]`.

* Then the compound instruction is valid with type :math:`[] \to [t_2^?]`.

.. math::
   \frac{
     S; C \vdash \instr_0^\ast : [t_1^n] \to [t_2^?]
     \qquad
     S; C,\CLABELS\,[t_1^n] \vdash \instr^\ast : [] \to [t_2^?]
   }{
     S; C \vdash \LABEL_n\{\instr_0^\ast\}~\instr^\ast~\END : [] \to [t_2^?]
   }


:math:`\FRAME_n\{F\}~\instr^\ast~\END`
...........................................

* Under the return type :math:`[t^n]`,
  the :ref:`thread <syntax-frame>` :math:`F; \instr^\ast` must be :ref:`valid <valid-frame>` with type :math:`[t^n]`.

* Then the compound instruction is valid with type :math:`[] \to [t^n]`.

.. math::
   \frac{
     S; [t^n] \vdash F; \instr^\ast : [t^n]
   }{
     S; C \vdash \FRAME_n\{F\}~\instr^\ast~\END : [] \to [t^n]
   }


.. _valid-moduleinstr:

Module Instructions
~~~~~~~~~~~~~~~~~~~

Typing rules for :ref:`module instructions <valid-moduleinstr>` are specified as follows.
Unlike regular instructions, module instructions do not use the operand stack, and consequently, are not classified by a type.


:math:`\INSTANTIATE~\module~\externval^\ast`
............................................

* Each :ref:`external value <syntax-externval>` :math:`\externval_i` in :math:`\externval^\ast` must be :ref:`valid <valid-externval>` with some :ref:`external type <syntax-externtype>` :math:`\externtype_i`.

* Then the module instruction is valid.

.. math::
   \frac{
     (S \vdash \externval : \externtype)^\ast
   }{
     S \vdash \INSTANTIATE~\module~\externval^\ast \ok
   }


:math:`\INITTABLE~\tableaddr~o~\moduleinst~x^n`
...............................................

* The :ref:`external table value <syntax-externval>` :math:`\EVTABLE~\tableaddr` must be :ref:`valid <valid-externval-table>` with some :ref:`external table type <syntax-externtype>` :math:`\ETTABLE~\limits~\ANYFUNC`.

* The index :math:`o + n` must be smaller than or equal to :math:`\limits.\LMIN`.

* The :ref:`module instance <syntax-moduleinst>` :math:`\moduleinst` must be :ref:`valid <valid-moduleinst>` with some :ref:`context <context>` :math:`C`.

* Each :ref:`function index <syntax-funcidx>` :math:`x_i` in :math:`x^n` must be defined in the context :math:`C`.

* Then the module instruction is valid.

.. math::
   \frac{
     S \vdash \EVTABLE~\tableaddr : \ETTABLE~\limits~\ANYFUNC
     \qquad
     o + n \leq \limits.\LMIN
     \qquad
     S \vdash \moduleinst : C
     \qquad
     (C.\CFUNCS[x] = \functype)^n
   }{
     S \vdash \INITTABLE~\tableaddr~o~\moduleinst~x^n \ok
   }


:math:`\INITMEM~\memaddr~o~b^n`
...............................

* The :ref:`external memory value <syntax-externval>` :math:`\EVMEM~\memaddr` must be :ref:`valid <valid-externval-mem>` with some :ref:`external memory type <syntax-externtype>` :math:`\ETMEM~\limits`.

* The index :math:`o + n` must be smaller than or equal to :math:`\limits.\LMIN` divided by the :ref:`page size <page-size>` :math:`64\,\F{Ki}`.

* Then the module instruction is valid.

.. math::
   \frac{
     S \vdash \EVMEM~\memaddr : \ETMEM~\limits
     \qquad
     o + n \leq \limits.\LMIN \cdot 64\,\F{Ki}
   }{
     S \vdash \INITMEM~\memaddr~o~b^n \ok
   }


:math:`\INITGLOBAL~\globaladdr~\val`
.........................................

* The :ref:`external global value <syntax-externval>` :math:`\EVGLOBAL~\globaladdr` must be :ref:`valid <valid-externval-global>` with some :ref:`external global type <syntax-externtype>` :math:`\ETGLOBAL~\mut~t`.

* The :ref:`value <syntax-val>` must be :ref:`valid <valid-val>` with :ref:`value type <syntax-valtype>` :math:`t`.

* Then the module instruction is valid.

.. math::
   \frac{
     S \vdash \EVGLOBAL~\globaladdr : \ETGLOBAL~\mut~t
     \qquad
     \vdash \val : t
   }{
     S \vdash \INITGLOBAL~\globaladdr~\val \ok
   }


:math:`\instr`
..............

* Under an empty :ref:`context <context>`,
  the :ref:`instruction <syntax-instr>` :math:`\instr` must be valid with type :math:`[] \to []`.

* Then the module instruction is valid.

.. math::
   \frac{
     S; \{\} \vdash \instr : [] \to []
   }{
     S \vdash \instr : \epsilon
   }




.. _soundness-statement:

Validation
~~~~~~~~~~

.. todo:: progress, preservation

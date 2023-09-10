.. index:: ! soundness, type system
.. _soundness:

Type Soundness
--------------

The :ref:`type system <type-system>` of WebAssembly is *sound*, implying both *type safety* and *memory safety* with respect to the WebAssembly semantics. For example:

* All types declared and derived during validation are respected at run time;
  e.g., every :ref:`local <syntax-local>` or :ref:`global <syntax-global>` variable will only contain type-correct values, every :ref:`instruction <syntax-instr>` will only be applied to operands of the expected type, and every :ref:`function <syntax-func>` :ref:`invocation <exec-invocation>` always evaluates to a result of the right type (if it does not :ref:`trap <trap>` or diverge).

* No memory location will be read or written except those explicitly defined by the program, i.e., as a :ref:`local <syntax-local>`, a :ref:`global <syntax-global>`, an element in a :ref:`table <syntax-table>`, or a location within a linear :ref:`memory <syntax-mem>`.

* There is no undefined behavior,
  i.e., the :ref:`execution rules <exec>` cover all possible cases that can occur in a :ref:`valid <valid>` program, and the rules are mutually consistent.

Soundness also is instrumental in ensuring additional properties, most notably, *encapsulation* of function and module scopes: no :ref:`locals <syntax-local>` can be accessed outside their own function and no :ref:`module <syntax-module>` components can be accessed outside their own module unless they are explicitly :ref:`exported <syntax-export>` or :ref:`imported <syntax-import>`.

The typing rules defining WebAssembly :ref:`validation <valid>` only cover the *static* components of a WebAssembly program.
In order to state and prove soundness precisely, the typing rules must be extended to the *dynamic* components of the abstract :ref:`runtime <syntax-runtime>`, that is, the :ref:`store <syntax-store>`, :ref:`configurations <syntax-config>`, and :ref:`administrative instructions <syntax-instr-admin>`. [#cite-pldi2017]_


.. index:: context, recursive type, recursive type index
.. context-rec:

Contexts
~~~~~~~~

In order to check :ref:`rolled up <aux-roll-rectype>` recursive types,
the :ref:`context <context>` is locally extended with an additional component that records the :ref:`sub type <syntax-subtype>` corresponding to each :ref:`recursive type index <syntax-rectypeidx>` within the current :ref:`recursive type <syntax-rectype>`:

.. math::
   \begin{array}{llll}
   \production{context} & C &::=&
     \{~ \dots, \CRECS ~ \subtype^\ast ~\} \\
   \end{array}


.. index:: value type, reference type, heap type, bottom type, sub type, recursive type, recursive type index
.. _valid-types-ext:

Types
~~~~~

Well-formedness for :ref:`extended type forms <type-ext>` is defined as follows.


.. _valid-heaptype-ext:

:ref:`Heap Type <syntax-heaptype-ext>` :math:`\BOTH`
....................................................

* The heap type is valid.

.. math::
   \frac{
   }{
     C \vdashheaptype \BOTH \ok
   }

:ref:`Heap Type <syntax-heaptype-ext>` :math:`\REC~i`
.....................................................

* The recursive type index :math:`i` must exist in :math:`C.\CRECS`.

* Then the heap type is valid.

.. math::
   \frac{
     C.\CRECS[i] = \subtype^\ast
   }{
     C \vdashheaptype \REC~i \ok
   }


.. _valid-valtype-ext:

:ref:`Value Type <syntax-valtype-ext>` :math:`\BOT`
...................................................

* The value type is valid.

.. math::
   \frac{
   }{
     C \vdashvaltype \BOT \ok
   }


.. _valid-rectype-ext:

:ref:`Recursive Types <syntax-rectype>` :math:`\TREC~\subtype^\ast`
...................................................................

* Let :math:`C'` be the current :ref:`context <context>` :math:`C`, but where |CRECS| is :math:`\subtype^\ast`.

* There must be a :ref:`type index <syntax-typeidx>` :math:`x`, such that for each :ref:`sub type <syntax-subtype>` :math:`\subtype_i` in :math:`\subtype^\ast`:

  * Under the context :math:`C'`, the :ref:`sub type <syntax-subtype>` :math:`\subtype_i` must be :ref:`valid <valid-subtype>` for :ref:`type index <syntax-typeidx>` :math:`x+i` and :ref:`recursive type index <syntax-rectypeidx>` :math:`i`.

* Then the recursive type is valid for the :ref:`type index <syntax-typeidx>` :math:`x`.

.. math::
   \frac{
     C,\CRECS~\subtype^\ast \vdashrectype \TREC~\subtype^\ast ~{\ok}(x,0)
   }{
     C \vdashrectype \TREC~\subtype^\ast ~{\ok}(x)
   }

.. math::
   \frac{
   }{
     C \vdashrectype \TREC~\epsilon ~{\ok}(x,i)
   }
   \qquad
   \frac{
     C \vdashsubtype \subtype ~{\ok}(x,i)
     \qquad
     C \vdashrectype \TREC~{\subtype'}^\ast ~{\ok}(x+1,i+1)
   }{
     C \vdashrectype \TREC~\subtype~{\subtype'}^\ast ~{\ok}(x,i)
   }

.. note::
   These rules are a generalisation of the ones :ref:`previously given <valid-rectype>`.


.. _valid-subtype-ext:

:ref:`Sub types <syntax-subtype>` :math:`\TSUB~\TFINAL^?~\X{ht}^\ast~\comptype`
...............................................................................

* The :ref:`composite type <syntax-comptype>` :math:`\comptype` must be :ref:`valid <valid-comptype>`.

* The sequence :math:`\X{ht}^\ast` may be no longer than :math:`1`.

* For every :ref:`heap type <syntax-heaptype>` :math:`\X{ht}_k` in :math:`\X{ht}^\ast`:

  * The :ref:`heap type <syntax-heaptype>` :math:`\X{ht}_k` must be ordered before a :ref:`type index <syntax-typeidx>` :math:`x` and :ref:`recursive type index <syntax-rectypeidx>` a :math:`i`, meaning:

    - Either :math:`\X{ht}_k` is a :ref:`defined type <syntax-deftype>`.

    - Or :math:`\X{ht}_k` is a :ref:`type index <syntax-typeidx>` :math:`y_k` that is smaller than :math:`x`.

    - Or :math:`\X{ht}_k` is a :ref:`recursive type index <syntax-rectypeidx>` :math:`\REC~j_k` where :math:`j_k` is smaller than :math:`i`.

  * Let :ref:`sub type <syntax-subtype>` :math:`\subtype_k` be the :ref:`unrolling <aux-unroll-heaptype>` of the :ref:`heap type <syntax-heaptype>` :math:`\X{ht}_k`, meaning:

    - Either :math:`\X{ht}_k` is a :ref:`defined type <syntax-deftype>` :math:`\deftype_k`, then :math:`\subtype_k` must be the :ref:`unrolling <aux-unroll-deftype>` of :math:`\deftype_k`.

    - Or :math:`\X{ht}_k` is a :ref:`type index <syntax-typeidx>` :math:`y_k`, then :math:`\subtype_k` must be the :ref:`unrolling <aux-unroll-deftype>` of the :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[y_k]`.

    - Or :math:`\X{ht}_k` is a :ref:`recursive type index <syntax-rectypeidx>` :math:`\REC~j_k`, then :math:`\subtype_k` must be :math:`C.\CRECS[j_k]`.

  * The :ref:`sub type <syntax-subtype>` :math:`\subtype_k` must not contain :math:`\TFINAL`.

  * Let :math:`\comptype'_k` be the :ref:`composite type <syntax-comptype>` in :math:`\subtype_k`.

  * The :ref:`composite type <syntax-comptype>` :math:`\comptype` must :ref:`match <match-comptype>` :math:`\comptype'_k`.

* Then the sub type is valid for the :ref:`type index <syntax-typeidx>` :math:`x` and :ref:`recursive type index <syntax-rectypeidx>` :math:`i`.

.. math::
   \frac{
     \begin{array}{@{}c@{}}
     |\X{ht}^\ast| \leq 1
     \qquad
     (\X{ht} \prec x,i)^\ast
     \qquad
     (\unrollht{C}(\X{ht}) = \TSUB~{\X{ht}'}^\ast~\comptype')^\ast
     \\
     C \vdashcomptype \comptype \ok
     \qquad
     (C \vdashcomptypematch \comptype \matchescomptype \comptype')^\ast
     \end{array}
   }{
     C \vdashsubtype \TSUB~\TFINAL^?~\X{ht}^\ast~\comptype ~{\ok}(x,i)
   }

.. _aux-unroll-heaptype:

where:

.. math::
   \begin{array}{@{}lll@{}}
   (\deftype \prec x,i) &=& {\F{true}} \\
   (y \prec x,i) &=& y < x \\
   (\REC~j \prec x,i) &=& j < i \\
   [2ex]
   \unrollht{C}(\deftype) &=& \unrolldt(\deftype) \\
   \unrollht{C}(y) &=& \unrolldt(C.\CTYPES[y]) \\
   \unrollht{C}(\REC~j) &=& C.\CRECS[j] \\
   \end{array}

.. note::
   This rule is a generalisation of the ones :ref:`previously given <valid-subtype>`, which only allowed type indices as supertypes.


.. index:: heap type, recursive type, recursive type index
.. _match-heaptype-ext:

Subtyping
~~~~~~~~~

In a :ref:`rolled-up <aux-roll-rectype>` :ref:`recursive type <syntax-rectype>`, a :ref:`recursive type indices <syntax-rectypeidx>` :math:`\REC~i` :ref:`matches <match-heaptype>` another :ref:`heap type <syntax-heaptype>` :math:`\X{ht}` if:

* Let :math:`\TSUB~\TFINAL^?~{\X{ht}'}^\ast~\comptype` be the :ref:`sub type <syntax-subtype>` :math:`C.\CRECS[i]`.

* The heap type :math:`\X{ht}` is contained in :math:`{\X{ht}'}^\ast`.

.. math::
   \frac{
     C.\CRECS[i] = \TSUB~\TFINAL^?~\X{ht}_1^\ast~\X{ht}~\X{ht}_2^\ast~\comptype
   }{
     C \vdashheaptypematch \REC~i \matchesheaptype \X{ht}
   }

.. note::
   This rule is only invoked when checking :ref:`validity <valid-rectype-ext>` of :ref:`rolled-up <aux-roll-rectype>` :ref:`recursive types <syntax-rectype>`.


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

* The result is valid with :ref:`result type <syntax-resulttype>` :math:`[t^\ast]`, for any :ref:`valid <valid-resulttype>` :ref:`closed <type-closed>` :ref:`result types <syntax-resulttype>`.

.. math::
   \frac{
     \vdashresulttype [t^\ast] \ok
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



.. index:: store, function instance, table instance, memory instance, structure instance, array instance, global instance, function type, table type, memory type, global type, defined type, structure type, array type

:ref:`Store <syntax-store>` :math:`S`
.....................................

* Each :ref:`function instance <syntax-funcinst>` :math:`\funcinst_i` in :math:`S.\SFUNCS` must be :ref:`valid <valid-funcinst>` with some :ref:`function type <syntax-functype>` :math:`\functype_i`.

* Each :ref:`table instance <syntax-tableinst>` :math:`\tableinst_i` in :math:`S.\STABLES` must be :ref:`valid <valid-tableinst>` with some :ref:`table type <syntax-tabletype>` :math:`\tabletype_i`.

* Each :ref:`memory instance <syntax-meminst>` :math:`\meminst_i` in :math:`S.\SMEMS` must be :ref:`valid <valid-meminst>` with some :ref:`memory type <syntax-memtype>` :math:`\memtype_i`.

* Each :ref:`global instance <syntax-globalinst>` :math:`\globalinst_i` in :math:`S.\SGLOBALS` must be :ref:`valid <valid-globalinst>` with some  :ref:`global type <syntax-globaltype>` :math:`\globaltype_i`.

* Each :ref:`element instance <syntax-eleminst>` :math:`\eleminst_i` in :math:`S.\SELEMS` must be :ref:`valid <valid-eleminst>` with some :ref:`reference type <syntax-reftype>` :math:`\reftype_i`.

* Each :ref:`data instance <syntax-datainst>` :math:`\datainst_i` in :math:`S.\SDATAS` must be :ref:`valid <valid-datainst>`.

* Each :ref:`structure instance <syntax-structinst>` :math:`\structinst_i` in :math:`S.\SSTRUCTS` must be :ref:`valid <valid-structinst>`.

* Each :ref:`array instance <syntax-arrayinst>` :math:`\arrayinst_i` in :math:`S.\SARRAYS` must be :ref:`valid <valid-arrayinst>`.

* No :ref:`reference <syntax-ref>` to a bound :ref:`structure address <syntax-structaddr>` must be reachable from itself through a path consisting only of indirections through immutable structure or array :ref:`fields <syntax-fieldtype>`.

* No :ref:`reference <syntax-ref>` to a bound :ref:`array address <syntax-arrayaddr>` must be reachable from itself through a path consisting only of indirections through immutable structure or array :ref:`fields <syntax-fieldtype>`.

* Then the store is valid.

.. math::
   ~\\[-1ex]
   \frac{
     \begin{array}{@{}c@{}}
     (S \vdashfuncinst \funcinst : \deftype)^\ast
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
     (S \vdashstructinst \structinst \ok)^\ast
     \qquad
     (S \vdasharrayinst \arrayinst \ok)^\ast
     \\
     S = \{
       \begin{array}[t]{@{}l@{}}
       \SFUNCS~\funcinst^\ast,
       \SGLOBALS~\globalinst^\ast,
       \STABLES~\tableinst^\ast,
       \SMEMS~\meminst^\ast, \\
       \SELEMS~\eleminst^\ast,
       \SDATAS~\datainst^\ast,
       \SSTRUCTS~\structinst^\ast,
       \SARRAYS~\arrayinst^\ast \}
       \end{array}
     \\
     (S.\SSTRUCTS[a_{\F{s}}] = \structinst)^\ast
     \qquad
     ((\REFSTRUCTADDR~a_{\F{s}}) \not\gg^+_S (\REFSTRUCTADDR~a_{\F{s}}))^\ast
     \\
     (S.\SARRAYS[a_{\F{a}}] = \arrayinst)^\ast
     \qquad
     ((\REFARRAYADDR~a_{\F{a}}) \not\gg^+_S (\REFARRAYADDR~a_{\F{a}}))^\ast
     \end{array}
   }{
     \vdashstore S \ok
   }

.. index:: reachability

where :math:`\val_1 \gg^+_S \val_2` denotes the transitive closure of the following *reachability* relation on :ref:`values <syntax-val>`:

.. math::
   \begin{array}{@{}lcll@{}}
   (\REFSTRUCTADDR~a) &\gg_S& S.\SSTRUCTS[a].\SIFIELDS[i]
     & \iff \expanddt(S.\SSTRUCTS[a].\SITYPE) = \TSTRUCT~\X{ft}_1^i~(\MCONST~\X{st})~\X{ft}_2^\ast \\
   (\REFARRAYADDR~a) &\gg_S& S.\SARRAYS[a].\AIFIELDS[i]
     & \iff \expanddt(S.\SARRAYS[a].\AITYPE) = \TARRAY~(\MCONST~\X{st}) \\
   (\REFEXTERN~\reff) &\gg_S& \reff \\
   \end{array}

.. note::
   The constraint on reachability through immutable fields prevents the presence of cyclic data structures that can not be constructed in the language.
   Cycles can only be formed using mutation.


.. index:: function type, function instance
.. _valid-funcinst:

:ref:`Function Instances <syntax-funcinst>` :math:`\{\FITYPE~\functype, \FIMODULE~\moduleinst, \FICODE~\func\}`
.......................................................................................................................

* The :ref:`function type <syntax-functype>` :math:`\functype` must be :ref:`valid <valid-functype>` under an empty :ref:`context <context>`.

* The :ref:`module instance <syntax-moduleinst>` :math:`\moduleinst` must be :ref:`valid <valid-moduleinst>` with some :ref:`context <context>` :math:`C`.

* Under :ref:`context <context>` :math:`C`:

  * The :ref:`function <syntax-func>` :math:`\func` must be :ref:`valid <valid-func>` with some :ref:`function type <syntax-functype>` :math:`\functype'`.

  * The :ref:`function type <syntax-functype>` :math:`\functype'` must :ref:`match <match-functype>` :math:`\functype`.

* Then the function instance is valid with :ref:`function type <syntax-functype>` :math:`\functype`.

.. math::
   \frac{
     \begin{array}{@{}c@{}}
     \vdashfunctype \functype \ok
     \qquad
     S \vdashmoduleinst \moduleinst : C
     \\
     C \vdashfunc \func : \functype'
     \qquad
     C \vdashfunctypematch \functype' \matchesfunctype \functype
     \end{array}
   }{
     S \vdashfuncinst \{\FITYPE~\functype, \FIMODULE~\moduleinst, \FICODE~\func\} : \functype
   }


.. index:: function type, function instance, host function
.. _valid-hostfuncinst:

:ref:`Host Function Instances <syntax-funcinst>` :math:`\{\FITYPE~\functype, \FIHOSTCODE~\X{hf}\}`
..................................................................................................

* The :ref:`function type <syntax-functype>` :math:`\functype` must be :ref:`valid <valid-functype>` under an empty :ref:`context <context>`.

* Let :math:`[t_1^\ast] \toF [t_2^\ast]` be the :ref:`function type <syntax-functype>` :math:`\functype`.

* For every :ref:`valid <valid-store>` :ref:`store <syntax-store>` :math:`S_1` :ref:`extending <extend-store>` :math:`S` and every sequence :math:`\val^\ast` of :ref:`values <syntax-val>` whose :ref:`types <valid-val>` coincide with :math:`t_1^\ast`:

  * :ref:`Executing <exec-invoke-host>` :math:`\X{hf}` in store :math:`S_1` with arguments :math:`\val^\ast` has a non-empty set of possible outcomes.

  * For every element :math:`R` of this set:

    * Either :math:`R` must be :math:`\bot` (i.e., divergence).

    * Or :math:`R` consists of a :ref:`valid <valid-store>` :ref:`store <syntax-store>` :math:`S_2` :ref:`extending <extend-store>` :math:`S_1` and a :ref:`result <syntax-result>` :math:`\result` whose :ref:`type <valid-result>` coincides with :math:`[t_2^\ast]`.

* Then the function instance is valid with :ref:`function type <syntax-functype>` :math:`\functype`.

.. math::
   \frac{
     \begin{array}[b]{@{}l@{}}
     \vdashfunctype [t_1^\ast] \toF [t_2^\ast] \ok \\
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

* The :ref:`table type <syntax-tabletype>` :math:`\limits~t` must be :ref:`valid <valid-tabletype>` under the empty :ref:`context <context>`.

* The length of :math:`\reff^\ast` must equal :math:`\limits.\LMIN`.

* For each :ref:`reference <syntax-ref>` :math:`\reff_i` in the table's elements :math:`\reff^n`:

  * The :ref:`reference <syntax-ref>` :math:`\reff_i` must be :ref:`valid <valid-ref>` with some :ref:`reference type <syntax-reftype>` :math:`t'_i`.

  * The :ref:`reference type <syntax-reftype>` :math:`t'_i` must :ref:`match <match-reftype>` the :ref:`reference type <syntax-reftype>` :math:`t`.

* Then the table instance is valid with :ref:`table type <syntax-tabletype>` :math:`\limits~t`.

.. math::
   \frac{
     \vdashtabletype \limits~t \ok
     \qquad
     n = \limits.\LMIN
     \qquad
     (S \vdash \reff : t')^n
     \qquad
     (\vdashreftypematch t' \matchesvaltype t)^n
   }{
     S \vdashtableinst \{ \TITYPE~(\limits~t), \TIELEM~\reff^n \} : \limits~t
   }


.. index:: memory type, memory instance, limits, byte
.. _valid-meminst:

:ref:`Memory Instances <syntax-meminst>` :math:`\{ \MITYPE~\limits, \MIDATA~b^\ast \}`
......................................................................................

* The :ref:`memory type <syntax-memtype>` :math:`\limits` must be :ref:`valid <valid-memtype>` under the empty :ref:`context <context>`.

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

* The :ref:`global type <syntax-globaltype>` :math:`\mut~t` must be :ref:`valid <valid-globaltype>` under the empty :ref:`context <context>`.

* The :ref:`value <syntax-val>` :math:`\val` must be :ref:`valid <valid-val>` with some :ref:`value type <syntax-valtype>` :math:`t'`.

* The :ref:`value type <syntax-valtype>` :math:`t'` must :ref:`match <match-valtype>` the :ref:`value type <syntax-valtype>` :math:`t`.

* Then the global instance is valid with :ref:`global type <syntax-globaltype>` :math:`\mut~t`.

.. math::
   \frac{
     \vdashglobaltype \mut~t \ok
     \qquad
     S \vdashval \val : t'
     \qquad
     \vdashvaltypematch t' \matchesvaltype t
   }{
     S \vdashglobalinst \{ \GITYPE~(\mut~t), \GIVALUE~\val \} : \mut~t
   }


.. index:: element instance, reference
.. _valid-eleminst:

:ref:`Element Instances <syntax-eleminst>` :math:`\{ \EIELEM~\X{fa}^\ast \}`
............................................................................

* The :ref:`reference type <syntax-reftype>` :math:`t` must be :ref:`valid <valid-reftype>` under the empty :ref:`context <context>`.

* For each :ref:`reference <syntax-ref>` :math:`\reff_i` in the elements :math:`\reff^n`:

  * The :ref:`reference <syntax-ref>` :math:`\reff_i` must be :ref:`valid <valid-ref>` with some :ref:`reference type <syntax-reftype>` :math:`t'_i`.

  * The :ref:`reference type <syntax-reftype>` :math:`t'_i` must :ref:`match <match-reftype>` the :ref:`reference type <syntax-reftype>` :math:`t`.

* Then the element instance is valid with :ref:`reference type <syntax-reftype>` :math:`t`.

.. math::
   \frac{
     \vdashreftype t \ok
     \qquad
     (S \vdashval \reff : t')^\ast
     \qquad
     (\vdashreftypematch t' \matchesvaltype t)^\ast
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


.. index:: structure instance, field value, field type, storage type, defined type
.. _valid-structinst:

:ref:`Structure Instances <syntax-structinst>` :math:`\{ \SITYPE~\deftype, \SIFIELDS~\fieldval^\ast \}`
.......................................................................................................

* The :ref:`defined type <syntax-deftype>` :math:`\deftype` must be :ref:`valid <valid-deftype>`.

* The :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` must be a :ref:`structure type <syntax-structtype>` :math:`\TSTRUCT~\fieldtype^\ast`.

* The length of the sequence of :ref:`field values <syntax-fieldval>` :math:`\fieldval^\ast` must be the same as the length of the sequence of :ref:`field types <syntax-fieldtype>` :math:`\fieldtype^\ast`.

* For each :ref:`field value <syntax-fieldval>` :math:`\fieldval_i` in :math:`\fieldval^\ast` and corresponding :ref:`field type <syntax-fieldtype>` :math:`\fieldtype_i` in :math:`\fieldtype^\ast`:

  - Let :math:`\fieldtype_i` be :math:`\mut~\storagetype_i`.

  - The :ref:`field value <syntax-fieldval>` :math:`\fieldval_i` must be :ref:`valid <valid-fieldval>` with :ref:`storage type <syntax-storagetype>` :math:`\storagetype_i`.

* Then the structure instance is valid.

.. math::
   \frac{
     \vdashdeftype \X{dt} \ok
     \qquad
     \expanddt(\X{dt}) = \TSTRUCT~(\mut~\X{st})^\ast
     \qquad
     (S \vdashfieldval \X{fv} : \X{st})^\ast
   }{
     S \vdashstructinst \{ \SITYPE~\X{dt}, \SIFIELDS~\X{fv}^\ast \} \ok
   }


.. index:: array instance, field value, field type, storage type, defined type
.. _valid-arrayinst:

:ref:`Array Instances <syntax-arrayinst>` :math:`\{ \AITYPE~\deftype, \AIFIELDS~\fieldval^\ast \}`
..................................................................................................

* The :ref:`defined type <syntax-deftype>` :math:`\deftype` must be :ref:`valid <valid-deftype>`.

* The :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` must be an :ref:`array type <syntax-arraytype>` :math:`\TARRAY~\fieldtype`.

* Let :math:`\fieldtype` be :math:`\mut~\storagetype`.

* For each :ref:`field value <syntax-fieldval>` :math:`\fieldval_i` in :math:`\fieldval^\ast`:

  - The :ref:`field value <syntax-fieldval>` :math:`\fieldval_i` must be :ref:`valid <valid-fieldval>` with :ref:`storage type <syntax-storagetype>` :math:`\storagetype`.

* Then the array instance is valid.

.. math::
   \frac{
     \vdashdeftype \X{dt} \ok
     \qquad
     \expanddt(\X{dt}) = \TARRAY~(\mut~\X{st})
     \qquad
     (S \vdashfieldval \X{fv} : \X{st})^\ast
   }{
     S \vdasharrayinst \{ \AITYPE~\X{dt}, \AIFIELDS~\X{fv}^\ast \} \ok
   }


.. index:: field value, field type, validation, store, packed value, packed type
.. _valid-fieldval:
.. _valid-packedval:

:ref:`Field Values <syntax-fieldval>` :math:`\fieldval`
.......................................................

* If :math:`\fieldval` is a :ref:`value <syntax-val>` :math:`\val`, then:

  - The value :math:`\val` must be :ref:`valid <valid-val>` with :ref:`value type <syntax-valtype>` :math:`t`.

  - Then the field value is valid with :ref:`value type <syntax-valtype>` :math:`t`.

* Else, :math:`\fieldval` is a :ref:`packed value <syntax-packedval>` :math:`\packedval`:

  - Let :math:`\packedtype.\PACK~i` be the field value :math:`\fieldval`.

  - Then the field value is valid with :ref:`packed type <syntax-packedtype>` :math:`\packedtype`.

.. math::
   \frac{
   }{
     S \vdashpackedval \X{pt}.\PACK~i : \X{pt}
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

* Each :ref:`defined type <syntax-deftype>` :math:`\deftype_i` in :math:`\moduleinst.\MITYPES` must be :ref:`valid <valid-deftype>` under the empty :ref:`context <context>`.

* For each :ref:`function address <syntax-funcaddr>` :math:`\funcaddr_i` in :math:`\moduleinst.\MIFUNCS`, the :ref:`external value <syntax-externval>` :math:`\EVFUNC~\funcaddr_i` must be :ref:`valid <valid-externval-func>` with some :ref:`external type <syntax-externtype>` :math:`\ETFUNC~\functype_i`.

* For each :ref:`table address <syntax-tableaddr>` :math:`\tableaddr_i` in :math:`\moduleinst.\MITABLES`, the :ref:`external value <syntax-externval>` :math:`\EVTABLE~\tableaddr_i` must be :ref:`valid <valid-externval-table>` with some :ref:`external type <syntax-externtype>` :math:`\ETTABLE~\tabletype_i`.

* For each :ref:`memory address <syntax-memaddr>` :math:`\memaddr_i` in :math:`\moduleinst.\MIMEMS`, the :ref:`external value <syntax-externval>` :math:`\EVMEM~\memaddr_i` must be :ref:`valid <valid-externval-mem>` with some :ref:`external type <syntax-externtype>` :math:`\ETMEM~\memtype_i`.

* For each :ref:`global address <syntax-globaladdr>` :math:`\globaladdr_i` in :math:`\moduleinst.\MIGLOBALS`, the :ref:`external value <syntax-externval>` :math:`\EVGLOBAL~\globaladdr_i` must be :ref:`valid <valid-externval-global>` with some :ref:`external type <syntax-externtype>` :math:`\ETGLOBAL~\globaltype_i`.

* For each :ref:`element address <syntax-elemaddr>` :math:`\elemaddr_i` in :math:`\moduleinst.\MIELEMS`, the :ref:`element instance <syntax-eleminst>` :math:`S.\SELEMS[\elemaddr_i]` must be :ref:`valid <valid-eleminst>` with some :ref:`reference type <syntax-reftype>` :math:`\reftype_i`.

* For each :ref:`data address <syntax-dataaddr>` :math:`\dataaddr_i` in :math:`\moduleinst.\MIDATAS`, the :ref:`data instance <syntax-datainst>` :math:`S.\SDATAS[\dataaddr_i]` must be :ref:`valid <valid-datainst>`.

* Each :ref:`export instance <syntax-exportinst>` :math:`\exportinst_i` in :math:`\moduleinst.\MIEXPORTS` must be :ref:`valid <valid-exportinst>`.

* For each :ref:`export instance <syntax-exportinst>` :math:`\exportinst_i` in :math:`\moduleinst.\MIEXPORTS`, the :ref:`name <syntax-name>` :math:`\exportinst_i.\EINAME` must be different from any other name occurring in :math:`\moduleinst.\MIEXPORTS`.

* Let :math:`\deftype^\ast` be the concatenation of all :math:`\deftype_i` in order.

* Let :math:`\functype^\ast` be the concatenation of all :math:`\functype_i` in order.

* Let :math:`\tabletype^\ast` be the concatenation of all :math:`\tabletype_i` in order.

* Let :math:`\memtype^\ast` be the concatenation of all :math:`\memtype_i` in order.

* Let :math:`\globaltype^\ast` be the concatenation of all :math:`\globaltype_i` in order.

* Let :math:`\reftype^\ast` be the concatenation of all :math:`\reftype_i` in order.

* Let :math:`n` be the length of :math:`\moduleinst.\MIDATAS`.

* Then the module instance is valid with :ref:`context <context>`
  :math:`\{\CTYPES~\deftype^\ast,` :math:`\CFUNCS~\functype^\ast,` :math:`\CTABLES~\tabletype^\ast,` :math:`\CMEMS~\memtype^\ast,` :math:`\CGLOBALS~\globaltype^\ast,` :math:`\CELEMS~\reftype^\ast,` :math:`\CDATAS~{\ok}^n\}`.

.. math::
   ~\\[-1ex]
   \frac{
     \begin{array}{@{}c@{}}
     (\vdashdeftype \deftype \ok)^\ast
     \\
     (S \vdashexternval \EVFUNC~\funcaddr : \ETFUNC~\functype)^\ast
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
       \MITYPES & \deftype^\ast, \\
       \MIFUNCS & \funcaddr^\ast, \\
       \MITABLES & \tableaddr^\ast, \\
       \MIMEMS & \memaddr^\ast, \\
       \MIGLOBALS & \globaladdr^\ast, \\
       \MIELEMS & \elemaddr^\ast, \\
       \MIDATAS & \dataaddr^n, \\
       \MIEXPORTS & \exportinst^\ast ~\} : \{
         \begin{array}[t]{@{}l@{~}l@{}}
         \CTYPES & \deftype^\ast, \\
         \CFUNCS & \functype^\ast, \\
         \CTABLES & \tabletype^\ast, \\
         \CMEMS & \memtype^\ast, \\
         \CGLOBALS & \globaltype^\ast, \\
         \CELEMS & \reftype^\ast, \\
         \CDATAS & {\ok}^n ~\}
         \end{array}
       \end{array}
   }


.. scratch
  .. index:: context, store, frame
  .. _valid-context:

  Context Validity
  ~~~~~~~~~~~~~~~~

  A :ref:`context <context>` :math:`C` is valid when every type occurring in it is valid.

  .. math::
     \frac{
       \begin{array}{@{}c@{}}
       x^n = 0 \dots (n-1)
       \qquad
       (S; \{CTYPES~\functype^n[0 \slice x]\} \vdashfunctype \functype \ok)^n
       \\
       (S; C \vdashfunctype \functype' \ok)^\ast
       \qquad
       (S; C \vdashtabletype \tabletype \ok)^\ast
       \\
       (S; C \vdashmemtype \memtype \ok)^\ast
       \qquad
       (S; C \vdashglobaltype \globaltype \ok)^\ast
       \qquad
       (S; C \vdashreftype \reftype \ok)^\ast
       \\
       C = \{
         \begin{array}[t]{@{}l@{~}l@{}}
         \CTYPES & \functype^n, \\
         \CFUNCS & {\functype'}^\ast, \\
         \CTABLES & \tabletype^\ast, \\
         \CMEMS & \memtype^\ast, \\
         \CGLOBALS & \globaltype^\ast, \\
         \CELEMS & \reftype^\ast, \\
         \CDATAS & {\ok}^\ast ~\}
         \end{array}
       \end{array}
     }{
       S \vdashcontext C \ok
     }

  .. note::
     It is an invariant of the semantics that every context either consists of only static types or only dynamic types.


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

* The instruction is valid with any :ref:`valid <valid-instrtype>` :ref:`instruction type <syntax-instrtype>` of the form :math:`[t_1^\ast] \to [t_2^\ast]`.

.. math::
   \frac{
     C \vdashinstrtype [t_1^\ast] \to [t_2^\ast] \ok
   }{
     S; C \vdashadmininstr \TRAP : [t_1^\ast] \to [t_2^\ast]
   }


.. index:: value, value type

:math:`\val`
............

* The value :math:`\val` must be valid with :ref:`value type <syntax-valtype>` :math:`t`.

* Then it is valid as an instruction with type :math:`[] \to [t]`.

.. math::
   \frac{
     S \vdashval \val : t
   }{
     S; C \vdashadmininstr \val : [] \to [t]
   }


.. index:: function address, extern value, extern type, function type

:math:`\INVOKE~\funcaddr`
.........................

* The :ref:`external function value <syntax-externval>` :math:`\EVFUNC~\funcaddr` must be :ref:`valid <valid-externval-func>` with :ref:`external function type <syntax-externtype>` :math:`\ETFUNC \functype'`.

* Let :math:`[t_1^\ast] \toF [t_2^\ast])` be the :ref:`function type <syntax-functype>` :math:`\functype`.

* Then the instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`.

.. math::
   \frac{
     S \vdashexternval \EVFUNC~\funcaddr : \ETFUNC~[t_1^\ast] \toF [t_2^\ast]
   }{
     S; C \vdashadmininstr \INVOKE~\funcaddr : [t_1^\ast] \to [t_2^\ast]
   }


.. index:: label, instruction, result type

:math:`\LABEL_n\{\instr_0^\ast\}~\instr^\ast~\END`
..................................................

* The instruction sequence :math:`\instr_0^\ast` must be :ref:`valid <valid-instr-seq>` with some type :math:`[t_1^n] \toX{x^\ast} [t_2^*]`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`result type <syntax-resulttype>` :math:`[t_1^n]` prepended to the |CLABELS| vector.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instr-seq>` with type :math:`[] \toX{{x'}^\ast} [t_2^*]`.

* Then the compound instruction is valid with type :math:`[] \to [t_2^*]`.

.. math::
   \frac{
     S; C \vdashinstrseq \instr_0^\ast : [t_1^n] \toX{x^\ast} [t_2^*]
     \qquad
     S; C,\CLABELS\,[t_1^n] \vdashinstrseq \instr^\ast : [] \toX{{x'}^\ast} [t_2^*]
   }{
     S; C \vdashadmininstr \LABEL_n\{\instr_0^\ast\}~\instr^\ast~\END : [] \to [t_2^*]
   }


.. index:: frame, instruction, result type

:math:`\FRAME_n\{F\}~\instr^\ast~\END`
...........................................

* Under the :ref:`valid <valid-resulttype>` return type :math:`[t^n]`,
  the :ref:`thread <syntax-frame>` :math:`F; \instr^\ast` must be :ref:`valid <valid-frame>` with :ref:`result type <syntax-resulttype>` :math:`[t^n]`.

* Then the compound instruction is valid with type :math:`[] \to [t^n]`.

.. math::
   \frac{
     C \vdashresulttype [t^n] \ok
     \qquad
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

* The length of :math:`S.\SSTRUCTS` must not shrink.

* The length of :math:`S.\SARRAYS` must not shrink.

* For each :ref:`function instance <syntax-funcinst>` :math:`\funcinst_i` in the original :math:`S.\SFUNCS`, the new function instance must be an :ref:`extension <extend-funcinst>` of the old.

* For each :ref:`table instance <syntax-tableinst>` :math:`\tableinst_i` in the original :math:`S.\STABLES`, the new table instance must be an :ref:`extension <extend-tableinst>` of the old.

* For each :ref:`memory instance <syntax-meminst>` :math:`\meminst_i` in the original :math:`S.\SMEMS`, the new memory instance must be an :ref:`extension <extend-meminst>` of the old.

* For each :ref:`global instance <syntax-globalinst>` :math:`\globalinst_i` in the original :math:`S.\SGLOBALS`, the new global instance must be an :ref:`extension <extend-globalinst>` of the old.

* For each :ref:`element instance <syntax-eleminst>` :math:`\eleminst_i` in the original :math:`S.\SELEMS`, the new element instance must be an :ref:`extension <extend-eleminst>` of the old.

* For each :ref:`data instance <syntax-datainst>` :math:`\datainst_i` in the original :math:`S.\SDATAS`, the new data instance must be an :ref:`extension <extend-datainst>` of the old.

* For each :ref:`structure instance <syntax-structinst>` :math:`\structinst_i` in the original :math:`S.\SSTRUCTS`, the new structure instance must be an :ref:`extension <extend-structinst>` of the old.

* For each :ref:`array instance <syntax-arrayinst>` :math:`\arrayinst_i` in the original :math:`S.\SARRAYS`, the new array instance must be an :ref:`extension <extend-arrayinst>` of the old.

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
     S_1.\SSTRUCTS = \structinst_1^\ast &
     S_2.\SSTRUCTS = {\structinst'_1}^\ast~\structinst_2^\ast &
     (\vdashstructinstextends \structinst_1 \extendsto \structinst'_1)^\ast \\
     S_1.\SARRAYS = \arrayinst_1^\ast &
     S_2.\SARRAYS = {\arrayinst'_1}^\ast~\arrayinst_2^\ast &
     (\vdasharrayinstextends \arrayinst_1 \extendsto \arrayinst'_1)^\ast \\
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

* The :ref:`reference type <syntax-reftype>` :math:`\eleminst.\EITYPE` must remain unchanged.

* The vector :math:`\eleminst.\EIELEM` must:

  * either remain unchanged,

  * or shrink to length :math:`0`.

.. math::
   \frac{
   }{
     \vdasheleminstextends \{\EITYPE~t, \EIELEM~a^\ast\} \extendsto \{\EITYPE~t, \EIELEM~a^\ast\}
   }

.. math::
   \frac{
   }{
     \vdasheleminstextends \{\EITYPE~t, \EIELEM~a^\ast\} \extendsto \{\EITYPE~t, \EIELEM~\epsilon\}
   }


.. index:: data instance
.. _extend-datainst:

:ref:`Data Instance <syntax-datainst>` :math:`\datainst`
........................................................

* The vector :math:`\datainst.\DIDATA` must:

  * either remain unchanged,

  * or shrink to length :math:`0`.

.. math::
   \frac{
   }{
     \vdashdatainstextends \{\DIDATA~b^\ast\} \extendsto \{\DIDATA~b^\ast\}
   }

.. math::
   \frac{
   }{
     \vdashdatainstextends \{\DIDATA~b^\ast\} \extendsto \{\DIDATA~\epsilon\}
   }


.. index:: structure instance, field value, field type
.. _extend-structinst:

:ref:`Structure Instance <syntax-structinst>` :math:`\structinst`
.................................................................

* The :ref:`defined type <syntax-deftype>` :math:`\structinst.\SITYPE` must remain unchanged.

* Assert: due to :ref:`store well-formedness <valid-structinst>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\structinst.\SITYPE` is a :ref:`structure type <syntax-structtype>`.

* Let :math:`\TSTRUCT~\fieldtype^\ast` be the :ref:`expansion <aux-expand-deftype>` of :math:`\structinst.\SITYPE`.

* The length of the vector :math:`\structinst.\SIFIELDS` must remain unchanged.

* Assert: due to :ref:`store well-formedness <valid-structinst>`, the length of :math:`\structinst.\SIFIELDS` is the same as the length of :math:`\fieldtype^\ast`.

* For each :ref:`field value <syntax-fieldval>` :math:`\fieldval_i` in :math:`\structinst.\SIFIELDS` and corresponding :ref:`field type <syntax-fieldtype>` :math:`\fieldtype_i` in :math:`\fieldtype^\ast`:

  * Let :math:`\mut_i~\X{st}_i` be the structure of :math:`\fieldtype_i`.

  * If :math:`\mut_i` is |MCONST|, then the :ref:`field value <syntax-fieldval>` :math:`\fieldval_i` must remain unchanged.

.. math::
   \frac{
     (\mut = \MVAR \vee \fieldval_1 = \fieldval_2)^\ast
   }{
     \vdashstructinstextends \{\SITYPE~(\mut~\X{st})^\ast, \SIFIELDS~\fieldval_1^\ast\} \extendsto \{\SITYPE~(\mut~\X{st})^\ast, \SIFIELDS~\fieldval_2^\ast\}
   }


.. index:: array instance, field value, field type
.. _extend-arrayinst:

:ref:`Array Instance <syntax-arrayinst>` :math:`\arrayinst`
...........................................................

* The :ref:`defined type <syntax-deftype>` :math:`\arrayinst.\AITYPE` must remain unchanged.

* Assert: due to :ref:`store well-formedness <valid-arrayinst>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\arrayinst.\AITYPE` is an :ref:`array type <syntax-arraytype>`.

* Let :math:`\TARRAY~\fieldtype` be the :ref:`expansion <aux-expand-deftype>` of :math:`\arrayinst.\AITYPE`.

* The length of the vector :math:`\arrayinst.\AIFIELDS` must remain unchanged.

* Let :math:`\mut~\X{st}` be the structure of :math:`\fieldtype`.

* If :math:`\mut` is |MCONST|, then the sequence of :ref:`field values <syntax-fieldval>` :math:`\arrayinst.\AIFIELDS` must remain unchanged.

.. math::
   \frac{
     \mut = \MVAR \vee \fieldval_1^\ast = \fieldval_2^\ast
   }{
     \vdasharrayinstextends \{\AITYPE~(\mut~\X{st}), \AIFIELDS~\fieldval_1^\ast\} \extendsto \{\AITYPE~(\mut~\X{st}), \AIFIELDS~\fieldval_2^\ast\}
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


.. index:: type system

Type System Properties
----------------------

.. index:: ! principal types, type system, subtyping, polymorphism, instruction, syntax, instruction type
.. _principality:

Principal Types
~~~~~~~~~~~~~~~

The :ref:`type system <type-system>` of WebAssembly features both :ref:`subtyping <match>` and simple forms of :ref:`polymorphism <polymorphism>` for :ref:`instruction types <syntax-instrtype>`.
That has the effect that every instruction or instruction sequence can be classified with multiple different instruction types.

However, the typing rules still allow deriving *principal types* for instruction sequences.
That is, every valid instruction sequence has one particular type scheme, possibly containing some unconstrained place holder *type variables*, that is a subtype of all its valid instruction types, after substituting its type variables with suitable specific types.

Moreover, when deriving an instruction type in a "forward" manner, i.e., the *input* of the instruction sequence is already fixed to specific types,
then it has a principal *output* type expressible without type variables, up to a possibly :ref:`polymorphic stack <polymorphism>` bottom representable with one single variable.
In other words, "forward" principal types are effectively *closed*.

.. note::
   For example, in isolation, the instruction :math:`\REFASNONNULL` has the type :math:`[(\REF~\NULL~\X{ht})] \to [(\REF~\X{ht})]` for any choice of valid :ref:`heap type <syntax-type>` :math:`\X{ht}`.
   Moreover, if the input type :math:`[(\REF~\NULL~\X{ht})]` is already determined, i.e., a specific :math:`\X{ht}` is given, then the output type :math:`[(\REF~\X{ht})]` is fully determined as well.

   The implication of the latter property is that a validator for *complete* instruction sequences (as they occur in valid modules) can be implemented with a simple left-to-right :ref:`algorithm <algo-valid>` that does not require the introduction of type variables.

   A typing algorithm capable of handling *partial* instruction sequences (as might be considered for program analysis or program manipulation)
   needs to introduce type variables and perform substitutions,
   but it does not need to perform backtracking or record any non-syntactic constraints on these type variables.

Technically, the :ref:`syntax <syntax-type>` of :ref:`heap <syntax-heaptype>`, :ref:`value <syntax-valtype>`, and :ref:`result <syntax-resulttype>` types can be enriched with type variables as follows:

.. math::
   \begin{array}{llll}
   \production{nullability} & \X{null} &::=&
     \NULL^? ~|~ \alpha_{\X{null}} \\
   \production{heap type} & \heaptype &::=&
     \dots ~|~ \alpha_{\heaptype} \\
   \production{reference type} & \reftype &::=&
     \REF~\X{null}~\heaptype \\
   \production{value type} & \valtype &::=&
     \dots ~|~ \alpha_{\valtype} ~|~ \alpha_{\X{numvectype}} \\
   \production{result type} & \resulttype &::=&
     [\alpha_{\valtype^\ast}^?~\valtype^\ast] \\
   \end{array}

where each :math:`\alpha_{\X{xyz}}` ranges over a set of type variables for syntactic class :math:`\X{xyz}`, respectively.
The special class :math:`\X{numvectype}` is defined as :math:`\numtype ~|~ \vectype ~|~ \BOT`,
and is only needed to handle unannotated |SELECT| instructions.

A type is *closed* when it does not contain any type variables, and *open* otherwise.
A *type substitution* :math:`\sigma` is a finite mapping from type variables to closed types of the respective syntactic class.
When applied to an open type, it replaces the type variables :math:`\alpha` from its domain with the respective :math:`\sigma(\alpha)`.

**Theorem (Principal Types).**
If an instruction sequence :math:`\instr^\ast` is :ref:`valid <valid-config>` with some closed :ref:`instruction type <syntax-instrtype>` :math:`\instrtype` (i.e., :math:`C \vdashinstrseq \instr^\ast : \instrtype`),
then it is also valid with a possibly open instruction type :math:`\instrtype_{\min}` (i.e., :math:`C \vdashinstrseq \instr^\ast : \instrtype_{\min}`),
such that for *every* closed type :math:`\instrtype'` with which :math:`\instr^\ast` is valid (i.e., for all :math:`C \vdashinstrseq \instr^\ast : \instrtype'`),
there exists a substitution :math:`\sigma`,
such that :math:`\sigma(\instrtype_{\min})` is a subtype of :math:`\instrtype'` (i.e., :math:`C \vdashinstrtypematch \sigma(\instrtype_{\min}) \matchesinstrtype \instrtype'`).
Furthermore, :math:`\instrtype_{\min}` is unique up to the choice of type variables.

**Theorem (Closed Principal Forward Types).**
If closed input type :math:`[t_1^\ast]` is given and the instruction sequence :math:`\instr^\ast` is :ref:`valid <valid-config>` with :ref:`instruction type <syntax-instrtype>` :math:`[t_1^\ast] \toX{x^\ast} [t_2^\ast]` (i.e., :math:`C \vdashinstrseq \instr^\ast : [t_1^\ast] \toX{x^\ast} [t_2^\ast]`),
then it is also valid with instruction type :math:`[t_1^\ast] \toX{x^\ast} [\alpha_{\valtype^\ast}~t^\ast]` (i.e., :math:`C \vdashinstrseq \instr^\ast : [t_1^\ast] \toX{x^\ast} [\alpha_{\valtype^\ast}~t^\ast]`),
where all :math:`t^\ast` are closed,
such that for *every* closed result type :math:`[{t'_2}^\ast]` with which :math:`\instr^\ast` is valid (i.e., for all :math:`C \vdashinstrseq \instr^\ast : [t_1^\ast] \toX{x^\ast} [{t'_2}^\ast]`),
there exists a substitution :math:`\sigma`,
such that :math:`[{t'_2}^\ast] = [\sigma(\alpha_{\valtype^\ast})~t^\ast]`.


.. index:: ! type lattice, subtyping, least upper bound, greatest lower bound, instruction type

Type Lattice
~~~~~~~~~~~~

The :ref:`Principal Types <principality>` property depends on the existence of a *greatest lower bound* for any pair of types.

**Theorem (Greatest Lower Bounds for Value Types).**
For any two value types :math:`t_1` and :math:`t_2` that are :ref:`valid <valid-valtype>`
(i.e., :math:`C \vdashvaltype t_1 \ok` and :math:`C \vdashvaltype t_2 \ok`),
there exists a valid value type :math:`t` that is a subtype of both :math:`t_1` and :math:`t_2`
(i.e., :math:`C \vdashvaltype t \ok` and :math:`C \vdashvaltypematch t \matchesvaltype t_1` and :math:`C \vdashvaltypematch t \matchesvaltype t_2`),
such that *every* valid value type :math:`t'` that also is a subtype of both :math:`t_1` and :math:`t_2`
(i.e., for all :math:`C \vdashvaltype t' \ok` and :math:`C \vdashvaltypematch t' \matchesvaltype t_1` and :math:`C \vdashvaltypematch t' \matchesvaltype t_2`),
is a subtype of :math:`t`
(i.e., :math:`C \vdashvaltypematch t' \matchesvaltype t`).

.. note::
   The greatest lower bound of two types may be |BOT|.

**Theorem (Conditional Least Upper Bounds for Value Types).**
Any two value types :math:`t_1` and :math:`t_2` that are :ref:`valid <valid-valtype>`
(i.e., :math:`C \vdashvaltype t_1 \ok` and :math:`C \vdashvaltype t_2 \ok`)
either have no common supertype,
or there exists a valid value type :math:`t` that is a supertype of both :math:`t_1` and :math:`t_2`
(i.e., :math:`C \vdashvaltype t \ok` and :math:`C \vdashvaltypematch t_1 \matchesvaltype t` and :math:`C \vdashvaltypematch t_2 \matchesvaltype t`),
such that *every* valid value type :math:`t'` that also is a supertype of both :math:`t_1` and :math:`t_2`
(i.e., for all :math:`C \vdashvaltype t' \ok` and :math:`C \vdashvaltypematch t_1 \matchesvaltype t'` and :math:`C \vdashvaltypematch t_2 \matchesvaltype t'`),
is a supertype of :math:`t`
(i.e., :math:`C \vdashvaltypematch t \matchesvaltype t'`).

.. note::
   If a top type was added to the type system,
   a least upper bound would exist for any two types.

**Corollary (Type Lattice).**
Assuming the addition of a provisional top type,
:ref:`value types <syntax-valtype>` form a lattice with respect to their :ref:`subtype <match-valtype>` relation.

Finally, value types can be partitioned into multiple disjoint hierarchies that are not related by subtyping, except through |BOT|.

**Theorem (Disjoint Subtype Hierarchies).**
The greatest lower bound of two :ref:`value types <syntax-valtype>` is :math:`\BOT` or :math:`\REF~\BOT`
if and only if they do not have a least upper bound.

In other words, types that do not have common supertypes,
do not have common subtypes either (other than :math:`\BOT` or :math:`\REF~\BOT`), and vice versa.

.. note::
   Types from disjoint hierarchies can safely be represented in mutually incompatible ways in an implementation,
   because their values can never flow to the same place.


.. index:: ! compositionality, instruction type, subtyping

Compositionality
~~~~~~~~~~~~~~~~

:ref:`Valid <valid-instr-seq>` :ref:`instruction sequences <syntax-instr>` can be freely *composed*, as long as their types match up.

**Theorem (Composition).**
If two instruction sequences :math:`\instr_1^\ast` and :math:`\instr_2^\ast` are valid with types :math:`[t_1^\ast] \toX{x_1^\ast} [t^\ast]` and  :math:`[t^\ast] \toX{x_2^\ast} [t_2^\ast]`, respectively (i.e., :math:`C \vdashinstrseq \instr_1^\ast : [t_1^\ast] \toX{x_1^\ast} [t^\ast]` and :math:`C \vdashinstrseq \instr_1^\ast : [t^\ast] \toX{x_2^\ast} [t_2^\ast]`),
then the concatenated instruction sequence :math:`(\instr_1^\ast\;\instr_2^\ast)` is valid with type :math:`[t_1^\ast] \toX{x_1^\ast\,x_2^\ast} [t_2^\ast]` (i.e., :math:`C \vdashinstrseq \instr_1^\ast\;\instr_2^\ast : [t_1^\ast] \toX{x_1^\ast\,x_2^\ast} [t_2^\ast]`).

.. note::
   More generally, instead of a shared type :math:`[t^\ast]`, it suffices if the output type of :math:`\instr_1^\ast` is a :ref:`subtype <match-resulttype>` of the input type of  :math:`\instr_1^\ast`,
   since the subtype can always be weakened to its supertype by subsumption.

Inversely, valid instruction sequences can also freely be *decomposed*, that is, splitting them anywhere produces two instruction sequences that are both :ref:`valid <valid-instr-seq>`.

**Theorem (Decomposition).**
If an instruction sequence :math:`\instr^\ast` that is valid with type :math:`[t_1^\ast] \toX{x^\ast} [t_2^\ast]` (i.e., :math:`C \vdashinstrseq \instr^\ast : [t_1^\ast] \toX{x^\ast} [t_2^\ast]`)
is split into two instruction sequences :math:`\instr_1^\ast` and :math:`\instr_2^\ast` at any point (i.e., :math:`\instr^\ast = \instr_1^\ast\;\instr_2^\ast`),
then these are separately valid with some types :math:`[t_1^\ast] \toX{x_1^\ast} [t^\ast]` and  :math:`[t^\ast] \toX{x_2^\ast} [t_2^\ast]`, respectively (i.e., :math:`C \vdashinstrseq \instr_1^\ast : [t_1^\ast] \toX{x_1^\ast} [t^\ast]` and :math:`C \vdashinstrseq \instr_1^\ast : [t^\ast] \toX{x_2^\ast} [t_2^\ast]`),
where :math:`x^\ast = x_1^\ast\;x_2^\ast`.

.. note::
   This property holds because validation is required even for unreachable code.
   Without that, :math:`\instr_2^\ast` might not be valid in isolation.

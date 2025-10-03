.. index:: ! soundness, type system
.. _soundness:

Type Soundness
--------------

The :ref:`type system <type-system>` of WebAssembly is *sound*, implying both *type safety* and *memory safety* with respect to the WebAssembly semantics. For example:

* All types declared and derived during validation are respected at run time;
  e.g., every :ref:`local <syntax-local>` or :ref:`global <syntax-global>` variable will only contain type-correct values, every :ref:`instruction <syntax-instr>` will only be applied to operands of the expected type, and every :ref:`function <syntax-func>` :ref:`invocation <exec-invocation>` always evaluates to a result of the right type (if it does not diverge, throw an exception, or :ref:`trap <trap>`).

* No memory location will be read or written except those explicitly defined by the program, i.e., as a :ref:`local <syntax-local>`, a :ref:`global <syntax-global>`, an element in a :ref:`table <syntax-table>`, or a location within a linear :ref:`memory <syntax-mem>`.

* There is no undefined behavior,
  i.e., the :ref:`execution rules <exec>` cover all possible cases that can occur in a :ref:`valid <valid>` program, and the rules are mutually consistent.

Soundness also is instrumental in ensuring additional properties, most notably, *encapsulation* of function and module scopes: no :ref:`locals <syntax-local>` can be accessed outside their own function and no :ref:`module <syntax-module>` components can be accessed outside their own module unless they are explicitly :ref:`exported <syntax-export>` or :ref:`imported <syntax-import>`.

The typing rules defining WebAssembly :ref:`validation <valid>` only cover the *static* components of a WebAssembly program.
In order to state and prove soundness precisely, the typing rules must be extended to the *dynamic* components of the abstract :ref:`runtime <syntax-runtime>`, that is, the :ref:`store <syntax-store>`, :ref:`configurations <syntax-config>`, and :ref:`administrative instructions <syntax-instr-admin>`. [#cite-pldi2017]_


.. index:: context, recursive type, recursive type index
.. _context-ext:

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
     C \vdashheaptype \BOTH : \OKheaptype
   }

:ref:`Heap Type <syntax-heaptype-ext>` :math:`\REC~i`
.....................................................

* The recursive type index :math:`i` must exist in :math:`C.\CRECS`.

* Then the heap type is valid.

.. math::
   \frac{
     C.\CRECS[i] = \subtype
   }{
     C \vdashheaptype \REC~i : \OKheaptype
   }


.. _valid-valtype-ext:

:ref:`Value Type <syntax-valtype-ext>` :math:`\BOT`
...................................................

* The value type is valid.

.. math::
   \frac{
   }{
     C \vdashvaltype \BOT : \OKvaltype
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
     C,\CRECS~\subtype^\ast \vdashrectype \TREC~\subtype^\ast : {\OKrectype}(x,0)
   }{
     C \vdashrectype \TREC~\subtype^\ast : {\OKrectype}(x)
   }

.. math::
   \frac{
   }{
     C \vdashrectype \TREC~\epsilon : {\OKrectype}(x,i)
   }
   \qquad
   \frac{
     C \vdashsubtype \subtype : {\OKsubtype}(x,i)
     \qquad
     C \vdashrectype \TREC~{\subtype'}^\ast : {\OKrectype}(x+1,i+1)
   }{
     C \vdashrectype \TREC~\subtype~{\subtype'}^\ast : {\OKrectype}(x,i)
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
     (\unrollht_{C}(\X{ht}) = \TSUB~{\X{ht}'}^\ast~\comptype')^\ast
     \\
     C \vdashcomptype \comptype : \OKcomptype
     \qquad
     (C \vdashcomptypematch \comptype \subcomptypematch \comptype')^\ast
     \end{array}
   }{
     C \vdashsubtype \TSUB~\TFINAL^?~\X{ht}^\ast~\comptype : {\OKsubtype}(x,i)
   }

.. _aux-unroll-heaptype:

where:

.. math::
   \begin{array}{@{}lll@{}}
   (\deftype \prec x,i) &=& {\F{true}} \\
   (y \prec x,i) &=& y < x \\
   (\REC~j \prec x,i) &=& j < i \\
   [2ex]
   \unrollht_{C}(\deftype) &=& \unrolldt(\deftype) \\
   \unrollht_{C}(y) &=& \unrolldt(C.\CTYPES[y]) \\
   \unrollht_{C}(\REC~j) &=& C.\CRECS[j] \\
   \end{array}

.. note::
   This rule is a generalisation of the ones :ref:`previously given <valid-subtype>`, which only allowed type indices as supertypes.


.. index:: defined type, recursive type, unroll, expand
.. _valid-deftype:

:ref:`Defined types <syntax-deftype>` :math:`\rectype.i`
........................................................

$${rule-prose: Deftype_ok}

$${rule: Deftype_ok}


.. index:: heap type, recursive type, recursive type index
.. _match-heaptype-ext:

Subtyping
~~~~~~~~~

In a :ref:`rolled-up <aux-roll-rectype>` :ref:`recursive type <syntax-rectype>`, a :ref:`recursive type indices <syntax-rectypeidx>` :math:`\REC~i` :ref:`matches <match-heaptype>` another :ref:`heap type <syntax-heaptype>` :math:`\X{ht}` if:

* Let :math:`\TSUB~\TFINAL^?~{\X{ht}'}^\ast~\comptype` be the :ref:`sub type <syntax-subtype>` :math:`C.\CRECS[i]`.

* The heap type :math:`\X{ht}` is contained in :math:`{\X{ht}'}^\ast`.

.. math::
   \frac{
     C.\CRECS[i] = \TSUB~\TFINAL^?~(\X{ht}_1^\ast~\X{ht}~\X{ht}_2^\ast)~\comptype
   }{
     C \vdashheaptypematch \REC~i \subheaptypematch \X{ht}
   }

.. note::
   This rule is only invoked when checking :ref:`validity <valid-rectype-ext>` of :ref:`rolled-up <aux-roll-rectype>` :ref:`recursive types <syntax-rectype>`.


.. index:: value, value type, result, result type, trap, exception, throw
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


:ref:`Results <syntax-result>` :math:`(\REFEXNADDR~a)~\THROWREF`
................................................................

* The value :math:`\REFEXNADDR~a` must be :ref:`valid <valid-val>`.

* Then the result is valid with :ref:`result type <syntax-resulttype>` :math:`[t^\ast]`, for any :ref:`valid <valid-resulttype>` :ref:`closed <type-closed>` :ref:`result types <syntax-resulttype>`.

.. math::
   \frac{
     S \vdashval \REFEXNADDR~a : \REF~\EXN
     \qquad
     \vdashresulttype [t^\ast] : \OKresulttype
   }{
     S \vdashresult (\REFEXNADDR~a)~\THROWREF : [{t'}^\ast]
   }


:ref:`Results <syntax-result>` :math:`\TRAP`
............................................

* The result is valid with :ref:`result type <syntax-resulttype>` :math:`[t^\ast]`, for any :ref:`valid <valid-resulttype>` :ref:`closed <type-closed>` :ref:`result types <syntax-resulttype>`.

.. math::
   \frac{
     \vdashresulttype [t^\ast] : \OKresulttype
   }{
     S \vdashresult \TRAP : [t^\ast]
   }


.. _module-context:
.. _valid-store:

Store Validity
~~~~~~~~~~~~~~

The following typing rules specify when a runtime :ref:`store <syntax-store>` :math:`S` is *valid*.
A valid store must consist of
:ref:`tag <syntax-taginst>`,
:ref:`global <syntax-globalinst>`,
:ref:`memory <syntax-meminst>`,
:ref:`table <syntax-tableinst>`,
:ref:`function <syntax-funcinst>`,
:ref:`data <syntax-datainst>`,
:ref:`element <syntax-eleminst>`,
:ref:`structure <syntax-structinst>`,
:ref:`array <syntax-arrayinst>`,
:ref:`exception <syntax-exninst>`,
and
:ref:`module <syntax-moduleinst>`
instances that are themselves valid, relative to :math:`S`.

To that end, each kind of instance is classified by a respective
:ref:`tag <syntax-tagtype>`,
:ref:`global <syntax-globaltype>`,
:ref:`memory <syntax-memtype>`,
:ref:`table <syntax-tabletype>`,
:ref:`function <syntax-functype>`, or
:ref:`element <syntax-eleminst>`,
type, or just ${:OK} in the case of
:ref:`data <syntax-datainst>`
:ref:`structures <syntax-structinst>`,
:ref:`arrays <syntax-arrayinst>`, or
:ref:`exceptions <syntax-exninst>`.
Module instances are classified by *module contexts*, which are regular :ref:`contexts <context>` repurposed as module types describing the :ref:`index spaces <syntax-index>` defined by a module.



.. index:: store, tag instance, global instance, memory instance, table instance, function instance, data instance, element instance, structure instance, array instance, tag type, global type, memory type, table type, function type, defined type, structure type, array type

:ref:`Store <syntax-store>` :math:`S`
.....................................

* Each :ref:`tag instance <syntax-taginst>` :math:`\taginst_i` in :math:`S.\STAGS` must be :ref:`valid <valid-taginst>` with some :ref:`tag type <syntax-tagtype>` :math:`\tagtype_i`.

* Each :ref:`global instance <syntax-globalinst>` :math:`\globalinst_i` in :math:`S.\SGLOBALS` must be :ref:`valid <valid-globalinst>` with some  :ref:`global type <syntax-globaltype>` :math:`\globaltype_i`.

* Each :ref:`memory instance <syntax-meminst>` :math:`\meminst_i` in :math:`S.\SMEMS` must be :ref:`valid <valid-meminst>` with some :ref:`memory type <syntax-memtype>` :math:`\memtype_i`.

* Each :ref:`table instance <syntax-tableinst>` :math:`\tableinst_i` in :math:`S.\STABLES` must be :ref:`valid <valid-tableinst>` with some :ref:`table type <syntax-tabletype>` :math:`\tabletype_i`.

* Each :ref:`function instance <syntax-funcinst>` :math:`\funcinst_i` in :math:`S.\SFUNCS` must be :ref:`valid <valid-funcinst>` with some :ref:`defined type <syntax-deftype>` :math:`\deftype_i`.

* Each :ref:`data instance <syntax-datainst>` :math:`\datainst_i` in :math:`S.\SDATAS` must be :ref:`valid <valid-datainst>`.

* Each :ref:`element instance <syntax-eleminst>` :math:`\eleminst_i` in :math:`S.\SELEMS` must be :ref:`valid <valid-eleminst>` with some :ref:`reference type <syntax-reftype>` :math:`\reftype_i`.

* Each :ref:`structure instance <syntax-structinst>` :math:`\structinst_i` in :math:`S.\SSTRUCTS` must be :ref:`valid <valid-structinst>`.

* Each :ref:`array instance <syntax-arrayinst>` :math:`\arrayinst_i` in :math:`S.\SARRAYS` must be :ref:`valid <valid-arrayinst>`.

* Each :ref:`exception instance <syntax-exninst>` :math:`\exninst_i` in :math:`S.\SEXNS` must be :ref:`valid <valid-exninst>`.

* No :ref:`reference <syntax-ref>` to a bound :ref:`structure address <syntax-structaddr>` must be reachable from itself through a path consisting only of indirections through immutable structure, or array :ref:`fields <syntax-fieldtype>` or fields of :ref:`exception instances <syntax-exninst>`.

* No :ref:`reference <syntax-ref>` to a bound :ref:`array address <syntax-arrayaddr>` must be reachable from itself through a path consisting only of indirections through immutable structure or array :ref:`fields <syntax-fieldtype>` or fields of :ref:`exception instances <syntax-exninst>`.

* No :ref:`reference <syntax-ref>` to a bound :ref:`exception address <syntax-exnaddr>` must be reachable from itself through a path consisting only of indirections through immutable structure or array :ref:`fields <syntax-fieldtype>` or fields of :ref:`exception instances <syntax-exninst>`.

* Then the store is valid.

.. math::
   ~\\[-1ex]
   \frac{
     \begin{array}{@{}c@{}}
     (S \vdashtaginst \taginst : \tagtype)^\ast
     \qquad
     (S \vdashglobalinst \globalinst : \globaltype)^\ast
     \\
     (S \vdashmeminst \meminst : \memtype)^\ast
     \qquad
     (S \vdashtableinst \tableinst : \tabletype)^\ast
     \\
     (S \vdashfuncinst \funcinst : \deftype)^\ast
     \qquad
     (S \vdashdatainst \datainst : \OKdatainst)^\ast
     \qquad
     (S \vdasheleminst \eleminst : \reftype)^\ast
     \\
     (S \vdashstructinst \structinst : \OKstructinst)^\ast
     \qquad
     (S \vdasharrayinst \arrayinst : \OKarrayinst)^\ast
     \qquad
     (S \vdashexninst \exninst : \OKexninst)^\ast
     \\
     S = \{
       \begin{array}[t]{@{}l@{}}
       \STAGS~\taginst^\ast,
       \SGLOBALS~\globalinst^\ast,
       \SMEMS~\meminst^\ast,
       \STABLES~\tableinst^\ast,
       \SFUNCS~\funcinst^\ast, \\
       \SDATAS~\datainst^\ast,
       \SELEMS~\eleminst^\ast,
       \SSTRUCTS~\structinst^\ast,
       \SARRAYS~\arrayinst^\ast,
       \SEXNS~\exninst^\ast \}
       \end{array}
     \\
     (S.\SSTRUCTS[a_{\F{s}}] = \structinst)^\ast
     \qquad
     ((\REFSTRUCTADDR~a_{\F{s}}) \not\gg^+_S (\REFSTRUCTADDR~a_{\F{s}}))^\ast
     \\
     (S.\SARRAYS[a_{\F{a}}] = \arrayinst)^\ast
     \qquad
     ((\REFARRAYADDR~a_{\F{a}}) \not\gg^+_S (\REFARRAYADDR~a_{\F{a}}))^\ast
     \\
     (S.\SEXNS[a_{\F{e}}] = \exninst)^\ast
     \qquad
     ((\REFEXNADDR~a_{\F{e}}) \not\gg^+_S (\REFEXNADDR~a_{\F{e}}))^\ast
     \end{array}
   }{
     \vdashstore S : \OKstore
   }

.. index:: reachability

where :math:`\val_1 \gg^+_S \val_2` denotes the transitive closure of the following *immutable reachability* relation on :ref:`values <syntax-val>`:

.. math::
   \begin{array}{@{}lcll@{}}
   (\REFSTRUCTADDR~a) &\gg_S& S.\SSTRUCTS[a].\SIFIELDS[i]
     & \iff \expanddt(S.\SSTRUCTS[a].\SITYPE) = \TSTRUCT~\X{ft}_1^i~\X{st}~\X{ft}_2^\ast \\
   (\REFARRAYADDR~a) &\gg_S& S.\SARRAYS[a].\AIFIELDS[i]
     & \iff \expanddt(S.\SARRAYS[a].\AITYPE) = \TARRAY~\X{st} \\
   (\REFEXNADDR~a) &\gg_S& S.\SEXNS[a].\EIFIELDS[i] \\
   (\REFEXTERN~\reff) &\gg_S& \reff \\
   \end{array}

.. note::
   The constraint on reachability through immutable fields prevents the presence of cyclic data structures that can not be constructed in the language.
   Cycles can only be formed using mutation.


.. index:: tag type, tag instance
.. _valid-taginst:

:ref:`Tag Instances <syntax-taginst>` :math:`\{ \HITYPE~\tagtype \}`
....................................................................

* The :ref:`tag type <syntax-tagtype>` :math:`\tagtype` must be :ref:`valid <valid-tagtype>` under the empty :ref:`context <context>`.

* Then the tag instance is valid with :ref:`tag type <syntax-tagtype>` :math:`\tagtype`.

.. math::
   \frac{
     \vdashtagtype \tagtype : \OKtagtype
   }{
     S \vdashtaginst \{ \HITYPE~\tagtype \} : \tagtype
   }


.. index:: global type, global instance, value, mutability
.. _valid-globalinst:

:ref:`Global Instances <syntax-globalinst>` :math:`\{ \GITYPE~\mut~t, \GIVALUE~\val \}`
.......................................................................................

* The :ref:`global type <syntax-globaltype>` :math:`\mut~t` must be :ref:`valid <valid-globaltype>` under the empty :ref:`context <context>`.

* The :ref:`value <syntax-val>` :math:`\val` must be :ref:`valid <valid-val>` with some :ref:`value type <syntax-valtype>` :math:`t'`.

* The :ref:`value type <syntax-valtype>` :math:`t'` must :ref:`match <match-valtype>` the :ref:`value type <syntax-valtype>` :math:`t`.

* Then the global instance is valid with :ref:`global type <syntax-globaltype>` :math:`\mut~t`.

.. math::
   \frac{
     \vdashglobaltype \mut~t : \OKglobaltype
     \qquad
     S \vdashval \val : t'
     \qquad
     \vdashvaltypematch t' \subvaltypematch t
   }{
     S \vdashglobalinst \{ \GITYPE~\mut~t, \GIVALUE~\val \} : \mut~t
   }


.. index:: memory type, memory instance, limits, byte
.. _valid-meminst:

:ref:`Memory Instances <syntax-meminst>` :math:`\{ \MITYPE~(\addrtype~\limits), \MIBYTES~b^\ast \}`
...................................................................................................

* The :ref:`memory type <syntax-memtype>` :math:`\addrtype~\limits` must be :ref:`valid <valid-memtype>` under the empty :ref:`context <context>`.

* Let :math:`\limits` be :math:`[n\,{..}\,m]`.

* The length of :math:`b^\ast` must equal :math:`m` multiplied by the :ref:`page size <page-size>` :math:`64\,\F{Ki}`.

* Then the memory instance is valid with :ref:`memory type <syntax-memtype>` :math:`\addrtype~\limits`.

.. math::
   \frac{
     \vdashmemtype \addrtype~[n\,{..}\,m] : \OKmemtype
     \qquad
     |b^\ast| = n \cdot 64\,\F{Ki}
   }{
     S \vdashmeminst \{ \MITYPE~(\addrtype~[n\,{..}\,m]), \MIBYTES~b^\ast \} : \addrtype~[n\,{..}\,m]
   }


.. index:: table type, table instance, limits, function address
.. _valid-tableinst:

:ref:`Table Instances <syntax-tableinst>` :math:`\{ \TITYPE~(\addrtype~\limits~t), \TIREFS~\reff^\ast \}`
.........................................................................................................

* The :ref:`table type <syntax-tabletype>` :math:`\addrtype~\limits~t` must be :ref:`valid <valid-tabletype>` under the empty :ref:`context <context>`.

* Let :math:`\limits` be :math:`[n\,{..}\,m]`.

* The length of :math:`\reff^\ast` must equal :math:`n`.

* For each :ref:`reference <syntax-ref>` :math:`\reff_i` in the table's elements :math:`\reff^n`:

  * The :ref:`reference <syntax-ref>` :math:`\reff_i` must be :ref:`valid <valid-ref>` with some :ref:`reference type <syntax-reftype>` :math:`t'_i`.

  * The :ref:`reference type <syntax-reftype>` :math:`t'_i` must :ref:`match <match-reftype>` the :ref:`reference type <syntax-reftype>` :math:`t`.

* Then the table instance is valid with :ref:`table type <syntax-tabletype>` :math:`\addrtype~\limits~t`.

.. math::
   \frac{
     \vdashtabletype \addrtype~[n\,{..}\,m]~t : \OKtabletype
     \qquad
     |\reff^\ast| = n
     \qquad
     (S \vdash \reff : t')^\ast
     \qquad
     (\vdashreftypematch t' \subvaltypematch t)^\ast
   }{
     S \vdashtableinst \{ \TITYPE~(\addrtype~[n\,{..}\,m]~t), \TIREFS~\reff^\ast \} : \addrtype~[n\,{..}\,m]~t
   }


.. index:: function type, defined type, function instance
.. _valid-funcinst:

:ref:`Function Instances <syntax-funcinst>` :math:`\{\FITYPE~\deftype, \FIMODULE~\moduleinst, \FICODE~\func\}`
......................................................................................................................

* The :ref:`defined type <syntax-deftype>` :math:`\deftype` must be :ref:`valid <valid-deftype>` under an empty :ref:`context <context>`.

* The :ref:`module instance <syntax-moduleinst>` :math:`\moduleinst` must be :ref:`valid <valid-moduleinst>` with some :ref:`context <context>` :math:`C`.

* Under :ref:`context <context>` :math:`C`:

  * The :ref:`function <syntax-func>` :math:`\func` must be :ref:`valid <valid-func>` with some :ref:`defined type <syntax-deftype>` :math:`\deftype'`.

  * The :ref:`defined type <syntax-deftype>` :math:`\deftype'` must :ref:`match <match-deftype>` :math:`\deftype`.

* Then the function instance is valid with :ref:`defined type <syntax-deftype>` :math:`\deftype`.

.. math::
   \frac{
     \begin{array}{@{}c@{}}
     \vdashdeftype \deftype : \OKdeftype
     \qquad
     S \vdashmoduleinst \moduleinst : C
     \\
     C \vdashfunc \func : \deftype'
     \qquad
     C \vdashdeftypematch \deftype' \subdeftypematch \deftype
     \end{array}
   }{
     S \vdashfuncinst \{\FITYPE~\deftype, \FIMODULE~\moduleinst, \FICODE~\func\} : \deftype
   }


.. index:: function type, defined type, function instance, host function
.. _valid-hostfuncinst:

:ref:`Host Function Instances <syntax-funcinst>` :math:`\{\FITYPE~\deftype, \FIHOSTFUNC~\X{hf}\}`
.................................................................................................

* The :ref:`defined type <syntax-deftype>` :math:`\deftype` must be :ref:`valid <valid-deftype>` under an empty :ref:`context <context>`.

*  The :ref:`expansion <aux-expand-deftype>` of :ref:`defined type <syntax-deftype>` :math:`\deftype` must be some :ref:`function type <syntax-functype>` :math:`\TFUNC~[t_1^\ast] \Tarrow [t_2^\ast]`.

* For every :ref:`valid <valid-store>` :ref:`store <syntax-store>` :math:`S_1` :ref:`extending <extend-store>` :math:`S` and every sequence :math:`\val^\ast` of :ref:`values <syntax-val>` whose :ref:`types <valid-val>` coincide with :math:`t_1^\ast`:

  * :ref:`Executing <exec-invoke-host>` :math:`\X{hf}` in store :math:`S_1` with arguments :math:`\val^\ast` has a non-empty set of possible outcomes.

  * For every element :math:`R` of this set:

    * Either :math:`R` must be :math:`\bot` (i.e., divergence).

    * Or :math:`R` consists of a :ref:`valid <valid-store>` :ref:`store <syntax-store>` :math:`S_2` :ref:`extending <extend-store>` :math:`S_1` and a :ref:`result <syntax-result>` :math:`\result` whose :ref:`type <valid-result>` coincides with :math:`[t_2^\ast]`.

* Then the function instance is valid with :ref:`defined type <syntax-deftype>` :math:`\deftype`.

.. math::
   \frac{
     \begin{array}[b]{@{}r@{}}
     \vdashdeftype \deftype : \OKdeftype
     \\
     \deftype \approx \TFUNC~ [t_1^\ast] \Tarrow [t_2^\ast]
     \end{array}
     \quad
     \begin{array}[b]{@{}l@{}}
     \forall S_1, \val^\ast,~
       {\vdashstore S_1 : \OKstore} \wedge
       {\vdashstoreextends S \extendsto S_1} \wedge
       {S_1 \vdashresult \val^\ast : [t_1^\ast]}
       \Longrightarrow {} \\ \qquad
       \X{hf}(S_1; \val^\ast) \supset \emptyset \wedge {} \\ \qquad
     \forall R \in \X{hf}(S_1; \val^\ast),~
       R = \bot \vee {} \\ \qquad\qquad
       \exists S_2, \result,~
       {\vdashstore S_2 : \OKstore} \wedge
       {\vdashstoreextends S_1 \extendsto S_2} \wedge
       {S_2 \vdashresult \result : [t_2^\ast]} \wedge
       R = (S_2; \result)
     \end{array}
   }{
     S \vdashfuncinst \{\FITYPE~\deftype, \FIHOSTFUNC~\X{hf}\} : \deftype
   }

.. note::
   This rule states that, if appropriate pre-conditions about store and arguments are satisfied, then executing the host function must satisfy appropriate post-conditions about store and results.
   The post-conditions match the ones in the :ref:`execution rule <exec-invoke-host>` for invoking host functions.

   Any store under which the function is invoked is assumed to be an extension of the current store.
   That way, the function itself is able to make sufficient assumptions about future stores.


.. index:: data instance, byte
.. _valid-datainst:

:ref:`Data Instances <syntax-eleminst>` :math:`\{ \DIBYTES~b^\ast \}`
.....................................................................

* The data instance is valid.

.. math::
   \frac{
   }{
     S \vdashdatainst \{ \DIBYTES~b^\ast \} : \OKdatainst
   }


.. index:: element instance, reference
.. _valid-eleminst:

:ref:`Element Instances <syntax-eleminst>` :math:`\{ \EITYPE~t, \EIREFS~\reff^\ast \}`
......................................................................................

* The :ref:`reference type <syntax-reftype>` :math:`t` must be :ref:`valid <valid-reftype>` under the empty :ref:`context <context>`.

* For each :ref:`reference <syntax-ref>` :math:`\reff_i` in the elements :math:`\reff^n`:

  * The :ref:`reference <syntax-ref>` :math:`\reff_i` must be :ref:`valid <valid-ref>` with some :ref:`reference type <syntax-reftype>` :math:`t'_i`.

  * The :ref:`reference type <syntax-reftype>` :math:`t'_i` must :ref:`match <match-reftype>` the :ref:`reference type <syntax-reftype>` :math:`t`.

* Then the element instance is valid with :ref:`reference type <syntax-reftype>` :math:`t`.

.. math::
   \frac{
     \vdashreftype t : \OKreftype
     \qquad
     (S \vdashval \reff : t')^\ast
     \qquad
     (\vdashreftypematch t' \subvaltypematch t)^\ast
   }{
     S \vdasheleminst \{ \EITYPE~t, \EIREFS~\reff^\ast \} : t
   }


.. index:: structure instance, field value, field type, storage type, defined type
.. _valid-structinst:

:ref:`Structure Instances <syntax-structinst>` :math:`\{ \SITYPE~\deftype, \SIFIELDS~\fieldval^\ast \}`
.......................................................................................................

* The :ref:`defined type <syntax-deftype>` :math:`\deftype` must be :ref:`valid <valid-deftype>` under the empty :ref:`context <context>`.

* The :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` must be a :ref:`structure type <syntax-structtype>` :math:`\TSTRUCT~\fieldtype^\ast`.

* The length of the sequence of :ref:`field values <syntax-fieldval>` :math:`\fieldval^\ast` must be the same as the length of the sequence of :ref:`field types <syntax-fieldtype>` :math:`\fieldtype^\ast`.

* For each :ref:`field value <syntax-fieldval>` :math:`\fieldval_i` in :math:`\fieldval^\ast` and corresponding :ref:`field type <syntax-fieldtype>` :math:`\fieldtype_i` in :math:`\fieldtype^\ast`:

  - Let :math:`\fieldtype_i` be :math:`\mut~\storagetype_i`.

  - The :ref:`field value <syntax-fieldval>` :math:`\fieldval_i` must be :ref:`valid <valid-fieldval>` with :ref:`storage type <syntax-storagetype>` :math:`\storagetype_i`.

* Then the structure instance is valid.

.. math::
   \frac{
     \vdashdeftype \X{dt} : \OKdeftype
     \qquad
     \expanddt(\X{dt}) = \TSTRUCT~(\mut~\X{st})^\ast
     \qquad
     (S \vdashfieldval \X{fv} : \X{st})^\ast
   }{
     S \vdashstructinst \{ \SITYPE~\X{dt}, \SIFIELDS~\X{fv}^\ast \} : \OKstructinst
   }


.. index:: array instance, field value, field type, storage type, defined type
.. _valid-arrayinst:

:ref:`Array Instances <syntax-arrayinst>` :math:`\{ \AITYPE~\deftype, \AIFIELDS~\fieldval^\ast \}`
..................................................................................................

* The :ref:`defined type <syntax-deftype>` :math:`\deftype` must be :ref:`valid <valid-deftype>` under the empty :ref:`context <context>`.

* The :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` must be an :ref:`array type <syntax-arraytype>` :math:`\TARRAY~\fieldtype`.

* Let :math:`\fieldtype` be :math:`\mut~\storagetype`.

* For each :ref:`field value <syntax-fieldval>` :math:`\fieldval_i` in :math:`\fieldval^\ast`:

  - The :ref:`field value <syntax-fieldval>` :math:`\fieldval_i` must be :ref:`valid <valid-fieldval>` with :ref:`storage type <syntax-storagetype>` :math:`\storagetype`.

* Then the array instance is valid.

.. math::
   \frac{
     \vdashdeftype \X{dt} : \OKdeftype
     \qquad
     \expanddt(\X{dt}) = \TARRAY~(\mut~\X{st})
     \qquad
     (S \vdashfieldval \X{fv} : \X{st})^\ast
   }{
     S \vdasharrayinst \{ \AITYPE~\X{dt}, \AIFIELDS~\X{fv}^\ast \} : \OKarrayinst
   }


.. index:: field value, field type, validation, store, packed value, packed type
.. _valid-fieldval:
.. _valid-packval:

:ref:`Field Values <syntax-fieldval>` :math:`\fieldval`
.......................................................

* If :math:`\fieldval` is a :ref:`value <syntax-val>` :math:`\val`, then:

  - The value :math:`\val` must be :ref:`valid <valid-val>` with :ref:`value type <syntax-valtype>` :math:`t`.

  - Then the field value is valid with :ref:`value type <syntax-valtype>` :math:`t`.

* Else, :math:`\fieldval` is a :ref:`packed value <syntax-packval>` :math:`\packval`:

  - Let :math:`\packtype.\PACK~i` be the field value :math:`\fieldval`.

  - Then the field value is valid with :ref:`packed type <syntax-packtype>` :math:`\packtype`.

.. math::
   \frac{
   }{
     S \vdashpackval \X{pt}.\PACK~i : \X{pt}
   }


.. index:: exception instance, tag, tag address
.. _valid-exninst:

:ref:`Exception Instances <syntax-exninst>` :math:`\{ \EITAG~a, \EIFIELDS~\val^\ast \}`
.......................................................................................

* The store entry :math:`S.\STAGS[a]` must exist.

* The :ref:`expansion <aux-expand-deftype>` of the :ref:`tag type <syntax-tagtype>` :math:`S.\STAGS[a].\HITYPE` must be some :ref:`function type <syntax-functype>` :math:`\TFUNC~[t^\ast] \Tarrow [{t'}^\ast]`.

* The :ref:`result type <syntax-resulttype>` :math:`[{t'}^\ast]` must be empty.

* The sequence :math:`\val^ast` of :ref:`values <syntax-val>` must have the same length as the sequence :math:`t^\ast` of :ref:`value types <syntax-valtype>`.

* For each value :math:`\val_i` in :math:`\val^ast` and corresponding value type :math:`t_i` in :math:`t^\ast`, the value :math:`\val_i` must be valid with type :math:`t_i`.

* Then the exception instance is valid.

.. math::
   \frac{
     S.\STAGS[a].\HITYPE \approx \TFUNC~ [t^\ast] \Tarrow []
     \qquad
     (S \vdashval \val : t)^\ast
   }{
     S \vdashexninst \{ \EITAG~a, \EIFIELDS~\val^\ast \} : \OKexninst
   }


.. index:: external type, export instance, name, external address
.. _valid-exportinst:

:ref:`Export Instances <syntax-exportinst>` :math:`\{ \XINAME~\name, \XIADDR~\externaddr \}`
............................................................................................

* The :ref:`external address <syntax-externaddr>` :math:`\externaddr` must be :ref:`valid <valid-externaddr>` with some :ref:`external type <syntax-externtype>` :math:`\externtype`.

* Then the export instance is valid.

.. math::
   \frac{
     S \vdashexternaddr \externaddr : \externtype
   }{
     S \vdashexportinst \{ \XINAME~\name, \XIADDR~\externaddr \} : \OKexportinst
   }


.. index:: module instance, context
.. _valid-moduleinst:

:ref:`Module Instances <syntax-moduleinst>` :math:`\moduleinst`
...............................................................

* Each :ref:`defined type <syntax-deftype>` :math:`\deftype_i` in :math:`\moduleinst.\MITYPES` must be :ref:`valid <valid-deftype>` under the empty :ref:`context <context>`.

* For each :ref:`tag address <syntax-tagaddr>` :math:`\tagaddr_i` in :math:`\moduleinst.\MITAGS`, the :ref:`external address <syntax-externaddr>` :math:`\XATAG~\tagaddr_i` must be :ref:`valid <valid-externaddr-tag>` with some :ref:`external type <syntax-externtype>` :math:`\XTTAG~\tagtype_i`.

* For each :ref:`global address <syntax-globaladdr>` :math:`\globaladdr_i` in :math:`\moduleinst.\MIGLOBALS`, the :ref:`external address <syntax-externaddr>` :math:`\XAGLOBAL~\globaladdr_i` must be :ref:`valid <valid-externaddr-global>` with some :ref:`external type <syntax-externtype>` :math:`\XTGLOBAL~\globaltype_i`.

* For each :ref:`memory address <syntax-memaddr>` :math:`\memaddr_i` in :math:`\moduleinst.\MIMEMS`, the :ref:`external address <syntax-externaddr>` :math:`\XAMEM~\memaddr_i` must be :ref:`valid <valid-externaddr-mem>` with some :ref:`external type <syntax-externtype>` :math:`\XTMEM~\memtype_i`.

* For each :ref:`table address <syntax-tableaddr>` :math:`\tableaddr_i` in :math:`\moduleinst.\MITABLES`, the :ref:`external address <syntax-externaddr>` :math:`\XATABLE~\tableaddr_i` must be :ref:`valid <valid-externaddr-table>` with some :ref:`external type <syntax-externtype>` :math:`\XTTABLE~\tabletype_i`.

* For each :ref:`function address <syntax-funcaddr>` :math:`\funcaddr_i` in :math:`\moduleinst.\MIFUNCS`, the :ref:`external address <syntax-externaddr>` :math:`\XAFUNC~\funcaddr_i` must be :ref:`valid <valid-externaddr-func>` with some :ref:`external type <syntax-externtype>` :math:`\XTFUNC~\deftype_{\K{F}i}`.

* For each :ref:`data address <syntax-dataaddr>` :math:`\dataaddr_i` in :math:`\moduleinst.\MIDATAS`, the :ref:`data instance <syntax-datainst>` :math:`S.\SDATAS[\dataaddr_i]` must be :ref:`valid <valid-datainst>` with :math:`\X{ok}_i`.

* For each :ref:`element address <syntax-elemaddr>` :math:`\elemaddr_i` in :math:`\moduleinst.\MIELEMS`, the :ref:`element instance <syntax-eleminst>` :math:`S.\SELEMS[\elemaddr_i]` must be :ref:`valid <valid-eleminst>` with some :ref:`reference type <syntax-reftype>` :math:`\reftype_i`.

* Each :ref:`export instance <syntax-exportinst>` :math:`\exportinst_i` in :math:`\moduleinst.\MIEXPORTS` must be :ref:`valid <valid-exportinst>`.

* For each :ref:`export instance <syntax-exportinst>` :math:`\exportinst_i` in :math:`\moduleinst.\MIEXPORTS`, the :ref:`name <syntax-name>` :math:`\exportinst_i.\XINAME` must be different from any other name occurring in :math:`\moduleinst.\MIEXPORTS`.

* Let :math:`\deftype^\ast` be the concatenation of all :math:`\deftype_i` in order.

* Let :math:`\tagtype^\ast` be the concatenation of all :math:`\tagtype_i` in order.

* Let :math:`\globaltype^\ast` be the concatenation of all :math:`\globaltype_i` in order.

* Let :math:`\memtype^\ast` be the concatenation of all :math:`\memtype_i` in order.

* Let :math:`\tabletype^\ast` be the concatenation of all :math:`\tabletype_i` in order.

* Let :math:`\deftype_{\K{F}}^\ast` be the concatenation of all :math:`\deftype_{\K{F}i}` in order.

* Let :math:`\reftype^\ast` be the concatenation of all :math:`\reftype_i` in order.

* Let :math:`\X{ok}^\ast` be the concatenation of all :math:`\X{ok}_i` in order.

* Let :math:`m` be the length of :math:`\moduleinst.\MIFUNCS`.

* Let :math:`x^\ast` be the sequence of :ref:`function indices <syntax-funcidx>` from :math:`0` to :math:`m-1`.

* Then the module instance is valid with :ref:`context <context>`
  :math:`\{\CTYPES~\deftype^\ast,` :math:`\CTAGS~\tagtype^\ast,` :math:`\CGLOBALS~\globaltype^\ast,` :math:`\CMEMS~\memtype^\ast,` :math:`\CTABLES~\tabletype^\ast,` :math:`\CFUNCS~\deftype_{\K{F}}^\ast,` :math:`\CDATAS~\X{ok}^\ast,` :math:`\CELEMS~\reftype^\ast,` :math:`\CREFS~x^\ast\}`.

.. math::
   ~\\[-1ex]
   \frac{
     \begin{array}{@{}c@{}}
     (\vdashdeftype \deftype : \OKdeftype)^\ast
     \qquad
     (S \vdashexternaddr \XATAG~\tagaddr : \XTTAG~\tagtype)^\ast
     \\
     (S \vdashexternaddr \XAGLOBAL~\globaladdr : \XTGLOBAL~\globaltype)^\ast
     \qquad
     (S \vdashexternaddr \XAFUNC~\funcaddr : \XTFUNC~\deftype_{\K{F}})^\ast
     \\
     (S \vdashexternaddr \XAMEM~\memaddr : \XTMEM~\memtype)^\ast
     \qquad
     (S \vdashexternaddr \XATABLE~\tableaddr : \XTTABLE~\tabletype)^\ast
     \\
     (S \vdashdatainst S.\SDATAS[\dataaddr] : \X{ok})^\ast
     \qquad
     (S \vdasheleminst S.\SELEMS[\elemaddr] : \reftype)^\ast
     \\
     (S \vdashexportinst \exportinst : \OKexportinst)^\ast
     \qquad
     (\exportinst.\XINAME)^\ast ~\mbox{disjoint}
     \end{array}
   }{
     S \vdashmoduleinst \{
       \begin{array}[t]{@{}l@{~}l@{}}
       \MITYPES & \deftype^\ast, \\
       \MITAGS & \tagaddr^\ast, \\
       \MIGLOBALS & \globaladdr^\ast, \\
       \MIMEMS & \memaddr^\ast, \\
       \MITABLES & \tableaddr^\ast, \\
       \MIFUNCS & \funcaddr^\ast, \\
       \MIDATAS & \dataaddr^\ast, \\
       \MIELEMS & \elemaddr^\ast, \\
       \MIEXPORTS & \exportinst^\ast ~\} : \{
         \begin{array}[t]{@{}l@{~}l@{}}
         \CTYPES & \deftype^\ast, \\
         \CTAGS & \tagtype^\ast, \\
         \CGLOBALS & \globaltype^\ast, \\
         \CMEMS & \memtype^\ast, \\
         \CTABLES & \tabletype^\ast, \\
         \CFUNCS & \deftype_{\K{F}}^\ast, \\
         \CDATAS & \X{ok}^\ast, \\
         \CELEMS & \reftype^\ast, \\
         \CREFS & 0 \dots (|\funcaddr^\ast|-1) ~\}
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
       (S; \{CTYPES~\deftype^n[0 \slice x]\} \vdashdeftype \deftype \OKdeftype)^n
       \\
       (S; C \vdashdeftype \deftype \OKdeftype)^\ast
       \qquad
       (S; C \vdashtagtype \tagtype \OKtagtype)^\ast
       \\\
       (S; C \vdashglobaltype \globaltype \OKglobaltype)^\ast
       \qquad
       (S; C \vdashdeftype \deftype' \OKdeftype)^\ast
       \\
       (S; C \vdashmemtype \memtype \OKmemtype)^\ast
       \qquad
       (S; C \vdashtabletype \tabletype \OKtabletype)^\ast
       \qquad
       (S; C \vdashreftype \reftype \OKreftype)^\ast
       \\
       C = \{
         \begin{array}[t]{@{}l@{~}l@{}}
         \CTYPES & \deftype^n, \\
         \CTAGS & \tagtype^\ast, \\
         \CGLOBALS & \globaltype^\ast, \\
         \CMEMS & \memtype^\ast, \\
         \CTABLES & \tabletype^\ast, \\
         \CFUNCS & {\deftype'}^\ast, \\
         \CELEMS & \reftype^\ast, \\
         \CDATAS & {\X{ok}}^\ast ~\}
         \end{array}
       \end{array}
     }{
       S \vdashcontext C \OKcontext
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
     \vdashstore S : \OKstore
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
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instrs>` with some type :math:`[] \to [t^\ast]`.

* Then the thread is valid with the :ref:`result type <syntax-resulttype>` :math:`[t^\ast]`.

.. math::
   \frac{
     S \vdashframe F : C
     \qquad
     S; C,\CRETURN~\resulttype^? \vdashinstrs \instr^\ast : [] \to [t^\ast]
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

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`value types <syntax-valtype>` :math:`t^\ast` prepended to the |CLOCALS| list.

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
     C \vdashinstrtype [t_1^\ast] \to [t_2^\ast] : \OKinstrtype
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


.. index:: label, instruction, result type

:math:`\LABEL_n\{\instr_0^\ast\}~\instr^\ast`
.............................................

* The instruction sequence :math:`\instr_0^\ast` must be :ref:`valid <valid-instrs>` with some type :math:`[t_1^n] \to_{x^\ast} [t_2^*]`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`result type <syntax-resulttype>` :math:`[t_1^n]` prepended to the |CLABELS| list.

* Under context :math:`C'`,
  the instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instrs>` with type :math:`[] \to_{{x'}^\ast} [t_2^*]`.

* Then the compound instruction is valid with type :math:`[] \to [t_2^*]`.

.. math::
   \frac{
     S; C \vdashinstrs \instr_0^\ast : [t_1^n] \to_{x^\ast} [t_2^*]
     \qquad
     S; C,\CLABELS\,[t_1^n] \vdashinstrs \instr^\ast : [] \to_{{x'}^\ast} [t_2^*]
   }{
     S; C \vdashadmininstr \LABEL_n\{\instr_0^\ast\}~\instr^\ast : [] \to [t_2^*]
   }


.. index:: frame, instruction, result type

:math:`\FRAME_n\{F\}~\instr^\ast`
.................................

* Under the :ref:`valid <valid-resulttype>` return type :math:`[t^n]`,
  the :ref:`thread <syntax-frame>` :math:`F; \instr^\ast` must be :ref:`valid <valid-frame>` with :ref:`result type <syntax-resulttype>` :math:`[t^n]`.

* Then the compound instruction is valid with type :math:`[] \to [t^n]`.

.. math::
   \frac{
     C \vdashresulttype [t^n] : \OKresulttype
     \qquad
     S; [t^n] \vdashinstrs F; \instr^\ast : [t^n]
   }{
     S; C \vdashadmininstr \FRAME_n\{F\}~\instr^\ast : [] \to [t^n]
   }


.. index:: handler, throw context

:math:`\HANDLER_n\{\catch^\ast\}~\instr^\ast`
.............................................

* For every :ref:`catch clause <syntax-catch>` :math:`\catch_i` in :math:`\catch^\ast`, :math:`\catch_i` must be :ref:`valid <valid-catch>`.

* The instruction sequence :math:`\instr^\ast` must be :ref:`valid <valid-instrs>` with some type :math:`[t_1^\ast] \to [t_2^\ast]`.

* Then the compound instruction is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`.

.. math::
   \frac{
     \begin{array}{c}
     (C \vdashcatch \catch : \OKcatch)^\ast
     \qquad
     S; C \vdashinstrs \instr^\ast : [t_1^\ast] \to [t_2^\ast] \\
     \end{array}
   }{
     S; C \vdashadmininstr \HANDLER_n\{\catch^\ast\}~\instr^\ast : [t_1^\ast] \to [t_2^\ast]
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

* The length of :math:`S.\STAGS` must not shrink.

* The length of :math:`S.\SGLOBALS` must not shrink.

* The length of :math:`S.\SMEMS` must not shrink.

* The length of :math:`S.\STABLES` must not shrink.

* The length of :math:`S.\SFUNCS` must not shrink.

* The length of :math:`S.\SDATAS` must not shrink.

* The length of :math:`S.\SELEMS` must not shrink.

* The length of :math:`S.\SSTRUCTS` must not shrink.

* The length of :math:`S.\SARRAYS` must not shrink.

* The length of :math:`S.\SEXNS` must not shrink.

* For each :ref:`tag instance <syntax-taginst>` :math:`\taginst_i` in the original :math:`S.\STAGS`, the new tag instance must be an :ref:`extension <extend-taginst>` of the old.

* For each :ref:`global instance <syntax-globalinst>` :math:`\globalinst_i` in the original :math:`S.\SGLOBALS`, the new global instance must be an :ref:`extension <extend-globalinst>` of the old.

* For each :ref:`memory instance <syntax-meminst>` :math:`\meminst_i` in the original :math:`S.\SMEMS`, the new memory instance must be an :ref:`extension <extend-meminst>` of the old.

* For each :ref:`table instance <syntax-tableinst>` :math:`\tableinst_i` in the original :math:`S.\STABLES`, the new table instance must be an :ref:`extension <extend-tableinst>` of the old.

* For each :ref:`function instance <syntax-funcinst>` :math:`\funcinst_i` in the original :math:`S.\SFUNCS`, the new function instance must be an :ref:`extension <extend-funcinst>` of the old.

* For each :ref:`data instance <syntax-datainst>` :math:`\datainst_i` in the original :math:`S.\SDATAS`, the new data instance must be an :ref:`extension <extend-datainst>` of the old.

* For each :ref:`element instance <syntax-eleminst>` :math:`\eleminst_i` in the original :math:`S.\SELEMS`, the new element instance must be an :ref:`extension <extend-eleminst>` of the old.

* For each :ref:`structure instance <syntax-structinst>` :math:`\structinst_i` in the original :math:`S.\SSTRUCTS`, the new structure instance must be an :ref:`extension <extend-structinst>` of the old.

* For each :ref:`array instance <syntax-arrayinst>` :math:`\arrayinst_i` in the original :math:`S.\SARRAYS`, the new array instance must be an :ref:`extension <extend-arrayinst>` of the old.

* For each :ref:`exception instance <syntax-exninst>` :math:`\exninst_i` in the original :math:`S.\SEXNS`, the new exception instance must be an :ref:`extension <extend-datainst>` of the old.

.. math::
   \frac{
     \begin{array}{@{}ccc@{}}
     S_1.\STAGS = \taginst_1^\ast &
     S_2.\STAGS = {\taginst'_1}^\ast~\taginst_2^\ast &
     (\vdashtaginstextends \taginst_1 \extendsto \taginst'_1)^\ast
     \\
     S_1.\SGLOBALS = \globalinst_1^\ast &
     S_2.\SGLOBALS = {\globalinst'_1}^\ast~\globalinst_2^\ast &
     (\vdashglobalinstextends \globalinst_1 \extendsto \globalinst'_1)^\ast
     \\
     S_1.\SMEMS = \meminst_1^\ast &
     S_2.\SMEMS = {\meminst'_1}^\ast~\meminst_2^\ast &
     (\vdashmeminstextends \meminst_1 \extendsto \meminst'_1)^\ast
     \\
     S_1.\STABLES = \tableinst_1^\ast &
     S_2.\STABLES = {\tableinst'_1}^\ast~\tableinst_2^\ast &
     (\vdashtableinstextends \tableinst_1 \extendsto \tableinst'_1)^\ast \\
     S_1.\SFUNCS = \funcinst_1^\ast &
     S_2.\SFUNCS = {\funcinst'_1}^\ast~\funcinst_2^\ast &
     (\vdashfuncinstextends \funcinst_1 \extendsto \funcinst'_1)^\ast
     \\
     S_1.\SDATAS = \datainst_1^\ast &
     S_2.\SDATAS = {\datainst'_1}^\ast~\datainst_2^\ast &
     (\vdashdatainstextends \datainst_1 \extendsto \datainst'_1)^\ast
     \\
     S_1.\SELEMS = \eleminst_1^\ast &
     S_2.\SELEMS = {\eleminst'_1}^\ast~\eleminst_2^\ast &
     (\vdasheleminstextends \eleminst_1 \extendsto \eleminst'_1)^\ast
     \\
     S_1.\SSTRUCTS = \structinst_1^\ast &
     S_2.\SSTRUCTS = {\structinst'_1}^\ast~\structinst_2^\ast &
     (\vdashstructinstextends \structinst_1 \extendsto \structinst'_1)^\ast
     \\
     S_1.\SARRAYS = \arrayinst_1^\ast &
     S_2.\SARRAYS = {\arrayinst'_1}^\ast~\arrayinst_2^\ast &
     (\vdasharrayinstextends \arrayinst_1 \extendsto \arrayinst'_1)^\ast
     \\
     S_1.\SEXNS = \exninst_1^\ast &
     S_2.\SEXNS = {\exninst'_1}^\ast~\exninst_2^\ast &
     (\vdashexninstextends \exninst_1 \extendsto \exninst'_1)^\ast
     \\
     \end{array}
   }{
     \vdashstoreextends S_1 \extendsto S_2
   }


.. index:: tag instance
.. _extend-taginst:

:ref:`Tag Instance <syntax-taginst>` :math:`\taginst`
.....................................................

* A tag instance must remain unchanged.

.. math::
   \frac{
   }{
     \vdashtaginstextends \taginst \extendsto \taginst
   }


.. index:: global instance, value, mutability
.. _extend-globalinst:

:ref:`Global Instance <syntax-globalinst>` :math:`\globalinst`
..............................................................

* The :ref:`global type <syntax-globaltype>` :math:`\globalinst.\GITYPE` must remain unchanged.

* Let :math:`\mut~t` be the structure of :math:`\globalinst.\GITYPE`.

* If :math:`\mut` is empty, then the :ref:`value <syntax-val>` :math:`\globalinst.\GIVALUE` must remain unchanged.

.. math::
   \frac{
     \mut = \TMUT \vee \val_1 = \val_2
   }{
     \vdashglobalinstextends \{\GITYPE~(\mut~t), \GIVALUE~\val_1\} \extendsto \{\GITYPE~(\mut~t), \GIVALUE~\val_2\}
   }


.. index:: memory instance
.. _extend-meminst:

:ref:`Memory Instance <syntax-meminst>` :math:`\meminst`
........................................................

* The :ref:`memory type <syntax-memtype>` :math:`\meminst.\MITYPE` must remain unchanged.

* The length of :math:`\meminst.\MIBYTES` must not shrink.

.. math::
   \frac{
     n_1 \leq n_2
   }{
     \vdashmeminstextends \{\MITYPE~\X{mt}, \MIBYTES~b_1^{n_1}\} \extendsto \{\MITYPE~\X{mt}, \MIBYTES~b_2^{n_2}\}
   }


.. index:: table instance
.. _extend-tableinst:

:ref:`Table Instance <syntax-tableinst>` :math:`\tableinst`
...........................................................

* The :ref:`table type <syntax-tabletype>` :math:`\tableinst.\TITYPE` must remain unchanged.

* The length of :math:`\tableinst.\TIREFS` must not shrink.

.. math::
   \frac{
     n_1 \leq n_2
   }{
     \vdashtableinstextends \{\TITYPE~\X{tt}, \TIREFS~(\X{fa}_1^?)^{n_1}\} \extendsto \{\TITYPE~\X{tt}, \TIREFS~(\X{fa}_2^?)^{n_2}\}
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


.. index:: data instance
.. _extend-datainst:

:ref:`Data Instance <syntax-datainst>` :math:`\datainst`
........................................................

* The list :math:`\datainst.\DIBYTES` must:

  * either remain unchanged,

  * or shrink to length :math:`0`.

.. math::
   \frac{
   }{
     \vdashdatainstextends \{\DIBYTES~b^\ast\} \extendsto \{\DIBYTES~b^\ast\}
   }

.. math::
   \frac{
   }{
     \vdashdatainstextends \{\DIBYTES~b^\ast\} \extendsto \{\DIBYTES~\epsilon\}
   }


.. index:: element instance
.. _extend-eleminst:

:ref:`Element Instance <syntax-eleminst>` :math:`\eleminst`
...........................................................

* The :ref:`reference type <syntax-reftype>` :math:`\eleminst.\EITYPE` must remain unchanged.

* The list :math:`\eleminst.\EIREFS` must:

  * either remain unchanged,

  * or shrink to length :math:`0`.

.. math::
   \frac{
   }{
     \vdasheleminstextends \{\EITYPE~t, \EIREFS~a^\ast\} \extendsto \{\EITYPE~t, \EIREFS~a^\ast\}
   }

.. math::
   \frac{
   }{
     \vdasheleminstextends \{\EITYPE~t, \EIREFS~a^\ast\} \extendsto \{\EITYPE~t, \EIREFS~\epsilon\}
   }


.. index:: structure instance, field value, field type
.. _extend-structinst:

:ref:`Structure Instance <syntax-structinst>` :math:`\structinst`
.................................................................

* The :ref:`defined type <syntax-deftype>` :math:`\structinst.\SITYPE` must remain unchanged.

* Assert: due to :ref:`store well-formedness <valid-structinst>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\structinst.\SITYPE` is a :ref:`structure type <syntax-structtype>`.

* Let :math:`\TSTRUCT~\fieldtype^\ast` be the :ref:`expansion <aux-expand-deftype>` of :math:`\structinst.\SITYPE`.

* The length of the list :math:`\structinst.\SIFIELDS` must remain unchanged.

* Assert: due to :ref:`store well-formedness <valid-structinst>`, the length of :math:`\structinst.\SIFIELDS` is the same as the length of :math:`\fieldtype^\ast`.

* For each :ref:`field value <syntax-fieldval>` :math:`\fieldval_i` in :math:`\structinst.\SIFIELDS` and corresponding :ref:`field type <syntax-fieldtype>` :math:`\fieldtype_i` in :math:`\fieldtype^\ast`:

  * Let :math:`\mut_i~\X{st}_i` be the structure of :math:`\fieldtype_i`.

  * If :math:`\mut_i` is empty, then the :ref:`field value <syntax-fieldval>` :math:`\fieldval_i` must remain unchanged.

.. math::
   \frac{
     (\mut = \TMUT \vee \fieldval_1 = \fieldval_2)^\ast
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

* The length of the list :math:`\arrayinst.\AIFIELDS` must remain unchanged.

* Let :math:`\mut~\X{st}` be the structure of :math:`\fieldtype`.

* If :math:`\mut` is empty, then the sequence of :ref:`field values <syntax-fieldval>` :math:`\arrayinst.\AIFIELDS` must remain unchanged.

.. math::
   \frac{
     \mut = \TMUT \vee \fieldval_1^\ast = \fieldval_2^\ast
   }{
     \vdasharrayinstextends \{\AITYPE~(\mut~\X{st}), \AIFIELDS~\fieldval_1^\ast\} \extendsto \{\AITYPE~(\mut~\X{st}), \AIFIELDS~\fieldval_2^\ast\}
   }


.. index:: exception instance
.. _extend-exninst:

:ref:`Exception Instance <syntax-exninst>` :math:`\exninst`
...........................................................

* An exception instance must remain unchanged.

.. math::
   \frac{
   }{
     \vdashexninstextends \exninst \extendsto \exninst
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

In other words, every thread in a valid configuration either runs forever, traps, throws an exception, or terminates with a result that has the expected type.
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
If an instruction sequence :math:`\instr^\ast` is :ref:`valid <valid-config>` with some closed :ref:`instruction type <syntax-instrtype>` :math:`\instrtype` (i.e., :math:`C \vdashinstrs \instr^\ast : \instrtype`),
then it is also valid with a possibly open instruction type :math:`\instrtype_{\min}` (i.e., :math:`C \vdashinstrs \instr^\ast : \instrtype_{\min}`),
such that for *every* closed type :math:`\instrtype'` with which :math:`\instr^\ast` is valid (i.e., for all :math:`C \vdashinstrs \instr^\ast : \instrtype'`),
there exists a substitution :math:`\sigma`,
such that :math:`\sigma(\instrtype_{\min})` is a subtype of :math:`\instrtype'` (i.e., :math:`C \vdashinstrtypematch \sigma(\instrtype_{\min}) \subinstrtypematch \instrtype'`).
Furthermore, :math:`\instrtype_{\min}` is unique up to the choice of type variables.

**Theorem (Closed Principal Forward Types).**
If closed input type :math:`[t_1^\ast]` is given and the instruction sequence :math:`\instr^\ast` is :ref:`valid <valid-config>` with :ref:`instruction type <syntax-instrtype>` :math:`[t_1^\ast] \to_{x^\ast} [t_2^\ast]` (i.e., :math:`C \vdashinstrs \instr^\ast : [t_1^\ast] \to_{x^\ast} [t_2^\ast]`),
then it is also valid with instruction type :math:`[t_1^\ast] \to_{x^\ast} [\alpha_{\valtype^\ast}~t^\ast]` (i.e., :math:`C \vdashinstrs \instr^\ast : [t_1^\ast] \to_{x^\ast} [\alpha_{\valtype^\ast}~t^\ast]`),
where all :math:`t^\ast` are closed,
such that for *every* closed result type :math:`[{t'_2}^\ast]` with which :math:`\instr^\ast` is valid (i.e., for all :math:`C \vdashinstrs \instr^\ast : [t_1^\ast] \to_{x^\ast} [{t'_2}^\ast]`),
there exists a substitution :math:`\sigma`,
such that :math:`[{t'_2}^\ast] = [\sigma(\alpha_{\valtype^\ast})~t^\ast]`.


.. index:: ! type lattice, subtyping, least upper bound, greatest lower bound, instruction type

Type Lattice
~~~~~~~~~~~~

The :ref:`Principal Types <principality>` property depends on the existence of a *greatest lower bound* for any pair of types.

**Theorem (Greatest Lower Bounds for Value Types).**
For any two value types :math:`t_1` and :math:`t_2` that are :ref:`valid <valid-valtype>`
(i.e., :math:`C \vdashvaltype t_1 : \OKvaltype` and :math:`C \vdashvaltype t_2 : \OKvaltype`),
there exists a valid value type :math:`t` that is a subtype of both :math:`t_1` and :math:`t_2`
(i.e., :math:`C \vdashvaltype t : \OKvaltype` and :math:`C \vdashvaltypematch t \subvaltypematch t_1` and :math:`C \vdashvaltypematch t \subvaltypematch t_2`),
such that *every* valid value type :math:`t'` that also is a subtype of both :math:`t_1` and :math:`t_2`
(i.e., for all :math:`C \vdashvaltype t' : \OKvaltype` and :math:`C \vdashvaltypematch t' \subvaltypematch t_1` and :math:`C \vdashvaltypematch t' \subvaltypematch t_2`),
is a subtype of :math:`t`
(i.e., :math:`C \vdashvaltypematch t' \subvaltypematch t`).

.. note::
   The greatest lower bound of two types may be |BOT|.

**Theorem (Conditional Least Upper Bounds for Value Types).**
Any two value types :math:`t_1` and :math:`t_2` that are :ref:`valid <valid-valtype>`
(i.e., :math:`C \vdashvaltype t_1 : \OKvaltype` and :math:`C \vdashvaltype t_2 : \OKvaltype`)
either have no common supertype,
or there exists a valid value type :math:`t` that is a supertype of both :math:`t_1` and :math:`t_2`
(i.e., :math:`C \vdashvaltype t : \OKvaltype` and :math:`C \vdashvaltypematch t_1 \subvaltypematch t` and :math:`C \vdashvaltypematch t_2 \subvaltypematch t`),
such that *every* valid value type :math:`t'` that also is a supertype of both :math:`t_1` and :math:`t_2`
(i.e., for all :math:`C \vdashvaltype t' : \OKvaltype` and :math:`C \vdashvaltypematch t_1 \subvaltypematch t'` and :math:`C \vdashvaltypematch t_2 \subvaltypematch t'`),
is a supertype of :math:`t`
(i.e., :math:`C \vdashvaltypematch t \subvaltypematch t'`).

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

:ref:`Valid <valid-instrs>` :ref:`instruction sequences <syntax-instr>` can be freely *composed*, as long as their types match up.

**Theorem (Composition).**
If two instruction sequences :math:`\instr_1^\ast` and :math:`\instr_2^\ast` are valid with types :math:`[t_1^\ast] \to_{x_1^\ast} [t^\ast]` and  :math:`[t^\ast] \to_{x_2^\ast} [t_2^\ast]`, respectively (i.e., :math:`C \vdashinstrs \instr_1^\ast : [t_1^\ast] \to_{x_1^\ast} [t^\ast]` and :math:`C \vdashinstrs \instr_1^\ast : [t^\ast] \to_{x_2^\ast} [t_2^\ast]`),
then the concatenated instruction sequence :math:`(\instr_1^\ast\;\instr_2^\ast)` is valid with type :math:`[t_1^\ast] \to_{x_1^\ast\,x_2^\ast} [t_2^\ast]` (i.e., :math:`C \vdashinstrs \instr_1^\ast\;\instr_2^\ast : [t_1^\ast] \to_{x_1^\ast\,x_2^\ast} [t_2^\ast]`).

.. note::
   More generally, instead of a shared type :math:`[t^\ast]`, it suffices if the output type of :math:`\instr_1^\ast` is a :ref:`subtype <match-resulttype>` of the input type of  :math:`\instr_1^\ast`,
   since the subtype can always be weakened to its supertype by subsumption.

Inversely, valid instruction sequences can also freely be *decomposed*, that is, splitting them anywhere produces two instruction sequences that are both :ref:`valid <valid-instrs>`.

**Theorem (Decomposition).**
If an instruction sequence :math:`\instr^\ast` that is valid with type :math:`[t_1^\ast] \to_{x^\ast} [t_2^\ast]` (i.e., :math:`C \vdashinstrs \instr^\ast : [t_1^\ast] \to_{x^\ast} [t_2^\ast]`)
is split into two instruction sequences :math:`\instr_1^\ast` and :math:`\instr_2^\ast` at any point (i.e., :math:`\instr^\ast = \instr_1^\ast\;\instr_2^\ast`),
then these are separately valid with some types :math:`[t_1^\ast] \to_{x_1^\ast} [t^\ast]` and  :math:`[t^\ast] \to_{x_2^\ast} [t_2^\ast]`, respectively (i.e., :math:`C \vdashinstrs \instr_1^\ast : [t_1^\ast] \to_{x_1^\ast} [t^\ast]` and :math:`C \vdashinstrs \instr_1^\ast : [t^\ast] \to_{x_2^\ast} [t_2^\ast]`),
where :math:`x^\ast = x_1^\ast\;x_2^\ast`.

.. note::
   This property holds because validation is required even for unreachable code.
   Without that, :math:`\instr_2^\ast` might not be valid in isolation.

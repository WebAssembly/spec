.. _index-rules:

Index of Semantic Rules
-----------------------


.. index:: validation
.. _index-valid:

Typing of Static Constructs
~~~~~~~~~~~~~~~~~~~~~~~~~~~

===============================================  ===============================================================================
Construct                                        Judgement
===============================================  ===============================================================================
:ref:`Limits <valid-limits>`                     :math:`C \vdashlimits \limits : k`
:ref:`Numeric type <valid-numtype>`              :math:`C \vdashnumtype \numtype \ok`
:ref:`Vector type <valid-vectype>`               :math:`C \vdashvectype \vectype \ok`
:ref:`Heap type <valid-heaptype>`                :math:`C \vdashheaptype \heaptype \ok`
:ref:`Reference type <valid-reftype>`            :math:`C \vdashreftype \reftype \ok`
:ref:`Value type <valid-valtype>`                :math:`C \vdashvaltype \valtype \ok`
:ref:`Function type <valid-functype>`            :math:`C \vdashfunctype \functype \ok`
:ref:`Block type <valid-blocktype>`              :math:`C \vdashblocktype \blocktype : \instrtype`
:ref:`Instruction type <valid-instrtype>`        :math:`C \vdashinstrtype \instrtype \ok`
:ref:`Table type <valid-tabletype>`              :math:`C \vdashtabletype \tabletype \ok`
:ref:`Memory type <valid-memtype>`               :math:`C \vdashmemtype \memtype \ok`
:ref:`Global type <valid-globaltype>`            :math:`C \vdashglobaltype \globaltype \ok`
:ref:`External type <valid-externtype>`          :math:`C \vdashexterntype \externtype \ok`
:ref:`Instruction <valid-instr>`                 :math:`S;C \vdashinstr \instr : \functype`
:ref:`Instruction sequence <valid-instr-seq>`    :math:`S;C \vdashinstrseq \instr^\ast : \functype`
:ref:`Expression <valid-expr>`                   :math:`C \vdashexpr \expr : \resulttype`
:ref:`Function <valid-func>`                     :math:`C \vdashfunc \func : \functype`
:ref:`Local <valid-local>`                       :math:`C \vdashlocal \local : \localtype`
:ref:`Table <valid-table>`                       :math:`C \vdashtable \table : \tabletype`
:ref:`Memory <valid-mem>`                        :math:`C \vdashmem \mem : \memtype`
:ref:`Global <valid-global>`                     :math:`C \vdashglobal \global : \globaltype`
:ref:`Element segment <valid-elem>`              :math:`C \vdashelem \elem : \reftype`
:ref:`Element mode <valid-elemmode>`             :math:`C \vdashelemmode \elemmode : \reftype`
:ref:`Data segment <valid-data>`                 :math:`C \vdashdata \data \ok`
:ref:`Data mode <valid-datamode>`                :math:`C \vdashdatamode \datamode \ok`
:ref:`Start function <valid-start>`              :math:`C \vdashstart \start \ok`
:ref:`Export <valid-export>`                     :math:`C \vdashexport \export : \externtype`
:ref:`Export description <valid-exportdesc>`     :math:`C \vdashexportdesc \exportdesc : \externtype`
:ref:`Import <valid-import>`                     :math:`C \vdashimport \import : \externtype`
:ref:`Import description <valid-importdesc>`     :math:`C \vdashimportdesc \importdesc : \externtype`
:ref:`Module <valid-module>`                     :math:`\vdashmodule \module : \externtype^\ast \rightarrow \externtype^\ast`
===============================================  ===============================================================================


.. index:: runtime

Typing of Runtime Constructs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

===============================================  ===============================================================================
Construct                                        Judgement
===============================================  ===============================================================================
:ref:`Value <valid-val>`                         :math:`S \vdashval \val : \valtype`
:ref:`Result <valid-result>`                     :math:`S \vdashresult \result : \resulttype`
:ref:`External value <valid-externval>`          :math:`S \vdashexternval \externval : \externtype`
:ref:`Function instance <valid-funcinst>`        :math:`S \vdashfuncinst \funcinst : \functype`
:ref:`Table instance <valid-tableinst>`          :math:`S \vdashtableinst \tableinst : \tabletype`
:ref:`Memory instance <valid-meminst>`           :math:`S \vdashmeminst \meminst : \memtype`
:ref:`Global instance <valid-globalinst>`        :math:`S \vdashglobalinst \globalinst : \globaltype`
:ref:`Element instance <valid-eleminst>`         :math:`S \vdasheleminst \eleminst : t`
:ref:`Data instance <valid-datainst>`            :math:`S \vdashdatainst \datainst \ok`
:ref:`Export instance <valid-exportinst>`        :math:`S \vdashexportinst \exportinst \ok`
:ref:`Module instance <valid-moduleinst>`        :math:`S \vdashmoduleinst \moduleinst : C`
:ref:`Store <valid-store>`                       :math:`\vdashstore \store \ok`
:ref:`Configuration <valid-config>`              :math:`\vdashconfig \config \ok`
:ref:`Thread <valid-thread>`                     :math:`S;\resulttype^? \vdashthread \thread : \resulttype`
:ref:`Frame <valid-frame>`                       :math:`S \vdashframe \frame : C`
===============================================  ===============================================================================


Defaultability
~~~~~~~~~~~~~~

=================================================  ===============================================================================
Construct                                          Judgement
=================================================  ===============================================================================
:ref:`Defaultable value type <valid-defaultable>`  :math:`C \vdashvaltypedefaultable \valtype \defaultable`
=================================================  ===============================================================================


Constantness
~~~~~~~~~~~~

===============================================  ===============================================================================
Construct                                        Judgement
===============================================  ===============================================================================
:ref:`Constant expression <valid-constant>`      :math:`C \vdashexprconst \expr \const`
:ref:`Constant instruction <valid-constant>`     :math:`C \vdashinstrconst \instr \const`
===============================================  ===============================================================================


Matching
~~~~~~~~

===============================================  ===============================================================================
Construct                                        Judgement
===============================================  ===============================================================================
:ref:`Number type <match-numtype>`               :math:`C \vdashnumtypematch \numtype_1 \matchesnumtype \numtype_2`
:ref:`Heap type <match-heaptype>`                :math:`C \vdashheaptypematch \heaptype_1 \matchesheaptype \heaptype_2`
:ref:`Reference type <match-reftype>`            :math:`C \vdashreftypematch \reftype_1 \matchesreftype \reftype_2`
:ref:`Value type <match-valtype>`                :math:`C \vdashvaltypematch \valtype_1 \matchesvaltype \valtype_2`
:ref:`Result type <match-resulttype>`            :math:`C \vdashresulttypematch \resulttype_1 \matchesresulttype \resulttype_2`
:ref:`Instruction type <match-instrtype>`        :math:`C \vdashinstrtypematch \instrtype_1 \matchesinstrtype \instrtype_2`
:ref:`Function type <match-functype>`            :math:`C \vdashfunctypematch \functype_1 \matchesfunctype \functype_2`
:ref:`Table type <match-tabletype>`              :math:`C \vdashtabletypematch \tabletype_1 \matchestabletype \tabletype_2`
:ref:`Memory type <match-memtype>`               :math:`C \vdashmemtypematch \memtype_1 \matchesmemtype \memtype_2`
:ref:`Global type <match-globaltype>`            :math:`C \vdashglobaltypematch \globaltype_1 \matchesglobaltype \globaltype_2`
:ref:`External type <match-externtype>`          :math:`C \vdashexterntypematch \externtype_1 \matchesexterntype \externtype_2`
:ref:`Limits <match-limits>`                     :math:`C \vdashlimitsmatch \limits_1 \matcheslimits \limits_2`
===============================================  ===============================================================================


Store Extension
~~~~~~~~~~~~~~~

===============================================  ===============================================================================
Construct                                        Judgement
===============================================  ===============================================================================
:ref:`Function instance <extend-funcinst>`       :math:`\vdashfuncinstextends \funcinst_1 \extendsto \funcinst_2`
:ref:`Table instance <extend-tableinst>`         :math:`\vdashtableinstextends \tableinst_1 \extendsto \tableinst_2`
:ref:`Memory instance <extend-meminst>`          :math:`\vdashmeminstextends \meminst_1 \extendsto \meminst_2`
:ref:`Global instance <extend-globalinst>`       :math:`\vdashglobalinstextends \globalinst_1 \extendsto \globalinst_2`
:ref:`Element instance <extend-eleminst>`         :math:`\vdasheleminstextends \eleminst_1 \extendsto \eleminst_2`
:ref:`Data instance <extend-datainst>`           :math:`\vdashdatainstextends \datainst_1 \extendsto \datainst_2`
:ref:`Store <extend-store>`                      :math:`\vdashstoreextends \store_1 \extendsto \store_2`
===============================================  ===============================================================================


Execution
~~~~~~~~~

===============================================  ===============================================================================
Construct                                        Judgement
===============================================  ===============================================================================
:ref:`Instruction <exec-instr>`                  :math:`S;F;\instr^\ast \stepto S';F';{\instr'}^\ast`
:ref:`Expression <exec-expr>`                    :math:`S;F;\expr \stepto  S';F';\expr'`
===============================================  ===============================================================================

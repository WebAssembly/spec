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
:ref:`Limits <valid-limits>`                     :math:`\vdashlimits \limits \ok`
:ref:`Function type <valid-functype>`            :math:`\vdashfunctype \functype \ok`
:ref:`Table type <valid-tabletype>`              :math:`\vdashtabletype \tabletype \ok`
:ref:`Memory type <valid-memtype>`               :math:`\vdashmemtype \memtype \ok`
:ref:`Global type <valid-globaltype>`            :math:`\vdashglobaltype \globaltype \ok`
:ref:`Instruction <valid-instr>`                 :math:`S;C \vdashinstr \instr : \functype`
:ref:`Instruction sequence <valid-instr-seq>`    :math:`S;C \vdashinstrseq \instr^\ast : \functype`
:ref:`Expression <valid-expr>`                   :math:`C \vdashexpr \expr : \resulttype`
:ref:`Function <valid-func>`                     :math:`C \vdashfunc \func : \functype`
:ref:`Table <valid-table>`                       :math:`C \vdashtable \table : \tabletype`
:ref:`Memory <valid-mem>`                        :math:`C \vdashmem \mem : \memtype`
:ref:`Global <valid-global>`                     :math:`C \vdashglobal \global : \globaltype`
:ref:`Element segment <valid-elem>`              :math:`C \vdashelem \elem \ok`
:ref:`Data segment <valid-data>`                 :math:`C \vdashdata \data \ok`
:ref:`Start function <valid-start>`              :math:`C \vdashstart \start \ok`
:ref:`Export <valid-export>`                     :math:`C \vdashexport \export : \externtype`
:ref:`Export description <valid-exportdesc>`     :math:`C \vdashexportdesc \exportdesc : \externtype`
:ref:`Import <valid-import>`                     :math:`C \vdashimport \import : \externtype`
:ref:`Import description <valid-importdesc>`     :math:`C \vdashimportdesc \importdesc : \externtype`
:ref:`Module <valid-module>`                     :math:`\vdashmodule \module : \externtype^\ast \to \externtype^\ast`
===============================================  ===============================================================================


.. index:: runtime

Typing of Runtime Constructs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

===============================================  ===============================================================================
Construct                                        Judgement
===============================================  ===============================================================================
:ref:`Value <valid-val>`                         :math:`\vdashval \val : \valtype`
:ref:`Result <valid-result>`                     :math:`\vdashresult \result : \resulttype`
:ref:`External value <valid-externval>`          :math:`S \vdashexternval \externval : \externtype`
:ref:`Function instance <valid-funcinst>`        :math:`S \vdashfuncinst \funcinst : \functype`
:ref:`Table instance <valid-tableinst>`          :math:`S \vdashtableinst \tableinst : \tabletype`
:ref:`Memory instance <valid-meminst>`           :math:`S \vdashmeminst \meminst : \memtype`
:ref:`Global instance <valid-globalinst>`        :math:`S \vdashglobalinst \globalinst : \globaltype`
:ref:`Export instance <valid-exportinst>`        :math:`S \vdashexportinst \exportinst \ok`
:ref:`Module instance <valid-moduleinst>`        :math:`S \vdashmoduleinst \moduleinst : C`
:ref:`Store <valid-store>`                       :math:`\vdashstore \store \ok`
:ref:`Configuration <valid-config>`              :math:`\vdashconfig \config \ok`
:ref:`Thread <valid-thread>`                     :math:`S;\resulttype^? \vdashthread \thread : \resulttype`
:ref:`Frame <valid-frame>`                       :math:`S \vdashframe \frame : C`
===============================================  ===============================================================================


Constantness
~~~~~~~~~~~~

===============================================  ===============================================================================
Construct                                        Judgement
===============================================  ===============================================================================
:ref:`Constant expression <valid-constant>`      :math:`C \vdashexprconst \expr \const`
:ref:`Constant instruction <valid-constant>`     :math:`C \vdashinstrconst \instr \const`
===============================================  ===============================================================================


Import Matching
~~~~~~~~~~~~~~~

===============================================  ===============================================================================
Construct                                        Judgement
===============================================  ===============================================================================
:ref:`Limits <match-limits>`                     :math:`\vdashlimitsmatch \limits_1 \matches \limits_2`
:ref:`External type <match-externtype>`          :math:`\vdashexterntypematch \externtype_1 \matches \externtype_2`
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
:ref:`Store <extend-store>`                      :math:`\vdashstoreextends \store_1 \extendsto \store_2`
===============================================  ===============================================================================


Execution
~~~~~~~~~

===============================================  ===============================================================================
Construct                                        Judgement
===============================================  ===============================================================================
:ref:`Instruction <exec-instr>`                  :math:`S;F;\instr \stepto S';F';{\instr'}^\ast`
:ref:`Expression <exec-expr>`                    :math:`S;F;\expr \stepto^\ast S';F';\val^\ast`
===============================================  ===============================================================================

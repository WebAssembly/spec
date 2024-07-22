.. _index-rules:

Index of Semantic Rules
-----------------------


.. index:: validation, type
.. _index-valid:

Well-formedness of Types
~~~~~~~~~~~~~~~~~~~~~~~~

===============================================  =================================================================================
Construct                                        Judgement
===============================================  =================================================================================
:ref:`Numeric type <valid-numtype>`              :math:`C \vdashnumtype \numtype : \OKnumtype`
:ref:`Vector type <valid-vectype>`               :math:`C \vdashvectype \vectype : \OKvectype`
:ref:`Heap type <valid-heaptype>`                :math:`C \vdashheaptype \heaptype : \OKheaptype`
:ref:`Reference type <valid-reftype>`            :math:`C \vdashreftype \reftype : \OKreftype`
:ref:`Value type <valid-valtype>`                :math:`C \vdashvaltype \valtype : \OKvaltype`
:ref:`Packed type <valid-packtype>`              :math:`C \vdashpacktype \packtype : \OKpacktype`
:ref:`Storage type <valid-storagetype>`          :math:`C \vdashstoragetype \storagetype : \OKstoragetype`
:ref:`Field type <valid-fieldtype>`              :math:`C \vdashfieldtype \fieldtype : \OKfieldtype`
:ref:`Result type <valid-resulttype>`            :math:`C \vdashresulttype \resulttype : \OKresulttype`
:ref:`Instruction type <valid-instrtype>`        :math:`C \vdashinstrtype \instrtype : \OKinstrtype`
:ref:`Function type <valid-functype>`            :math:`C \vdashfunctype \functype : \OKfunctype`
:ref:`Structure type <valid-structtype>`         :math:`C \vdashstructtype \structtype : \OKstructtype`
:ref:`Array type <valid-arraytype>`              :math:`C \vdasharraytype \arraytype : \OKarraytype`
:ref:`Composite type <valid-comptype>`           :math:`C \vdashcomptype \comptype : \OKcomptype`
:ref:`Sub type <valid-subtype>`                  :math:`C \vdashsubtype \subtype : \OKsubtype`
:ref:`Recursive type <valid-rectype>`            :math:`C \vdashrectype \rectype : \OKrectype`
:ref:`Defined type <valid-deftype>`              :math:`C \vdashdeftype \deftype : \OKdeftype`
:ref:`Block type <valid-blocktype>`              :math:`C \vdashblocktype \blocktype : \instrtype`
:ref:`Table type <valid-tabletype>`              :math:`C \vdashtabletype \tabletype : \OKtabletype`
:ref:`Memory type <valid-memtype>`               :math:`C \vdashmemtype \memtype : \OKmemtype`
:ref:`Global type <valid-globaltype>`            :math:`C \vdashglobaltype \globaltype : \OKglobaltype`
:ref:`Tag type <valid-tagtype>`                  :math:`C \vdashtagtype \tagtype : \OKtagtype`
:ref:`External type <valid-externtype>`          :math:`C \vdashexterntype \externtype : \OKexterntype`
:ref:`Type definitions <valid-type>`             :math:`C \vdashtypes \type^\ast : \OKtypes`
===============================================  =================================================================================


Typing of Static Constructs
~~~~~~~~~~~~~~~~~~~~~~~~~~~

===============================================  =================================================================================
Construct                                        Judgement
===============================================  =================================================================================
:ref:`Instruction <valid-instr>`                 :math:`S;C \vdashinstr \instr : \instrtype`
:ref:`Instruction sequence <valid-instrs>`       :math:`S;C \vdashinstrs \instr^\ast : \instrtype`
:ref:`Catch clause <valid-catch>`                :math:`C \vdashcatch \catch : \OKcatch`
:ref:`Expression <valid-expr>`                   :math:`C \vdashexpr \expr : \resulttype`
:ref:`Function <valid-func>`                     :math:`C \vdashfunc \func : \functype`
:ref:`Local <valid-local>`                       :math:`C \vdashlocal \local : \localtype`
:ref:`Table <valid-table>`                       :math:`C \vdashtable \table : \tabletype`
:ref:`Memory <valid-mem>`                        :math:`C \vdashmem \mem : \memtype`
:ref:`Limits <valid-limits>`                     :math:`C \vdashlimits \limits : k`
:ref:`Global <valid-global>`                     :math:`C \vdashglobal \global : \globaltype`
:ref:`Tag <valid-tag>`                           :math:`C \vdashtag \tag : \tagtype`
:ref:`Element segment <valid-elem>`              :math:`C \vdashelem \elem : \reftype`
:ref:`Element mode <valid-elemmode>`             :math:`C \vdashelemmode \elemmode : \reftype`
:ref:`Data segment <valid-data>`                 :math:`C \vdashdata \data : \OKdata`
:ref:`Data mode <valid-datamode>`                :math:`C \vdashdatamode \datamode : \OKdatamode`
:ref:`Start function <valid-start>`              :math:`C \vdashstart \start : \OKstart`
:ref:`Export <valid-export>`                     :math:`C \vdashexport \export : \externtype`
:ref:`Export description <valid-exportdesc>`     :math:`C \vdashexportdesc \exportdesc : \externtype`
:ref:`Import <valid-import>`                     :math:`C \vdashimport \import : \externtype`
:ref:`Import description <valid-importdesc>`     :math:`C \vdashimportdesc \importdesc : \externtype`
:ref:`Module <valid-module>`                     :math:`\vdashmodule \module : \externtype^\ast \rightarrow \externtype^\ast`
===============================================  =================================================================================


.. index:: runtime

Typing of Runtime Constructs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

===============================================  ===============================================================================
Construct                                        Judgement
===============================================  ===============================================================================
:ref:`Value <valid-val>`                         :math:`S \vdashval \val : \valtype`
:ref:`Result <valid-result>`                     :math:`S \vdashresult \result : \resulttype`
:ref:`Packed value <valid-packval>`              :math:`S \vdashpackval \packval : \packtype`
:ref:`Field value <valid-fieldval>`              :math:`S \vdashfieldval \fieldval : \storagetype`
:ref:`External value <valid-externval>`          :math:`S \vdashexternval \externval : \externtype`
:ref:`Function instance <valid-funcinst>`        :math:`S \vdashfuncinst \funcinst : \functype`
:ref:`Table instance <valid-tableinst>`          :math:`S \vdashtableinst \tableinst : \tabletype`
:ref:`Memory instance <valid-meminst>`           :math:`S \vdashmeminst \meminst : \memtype`
:ref:`Global instance <valid-globalinst>`        :math:`S \vdashglobalinst \globalinst : \globaltype`
:ref:`Tag instance <valid-taginst>`              :math:`S \vdashtaginst \taginst : \tagtype`
:ref:`Element instance <valid-eleminst>`         :math:`S \vdasheleminst \eleminst : t`
:ref:`Data instance <valid-datainst>`            :math:`S \vdashdatainst \datainst : \OKdatainst`
:ref:`Structure instance <valid-structinst>`     :math:`S \vdashstructinst \structinst : \OKstructinst`
:ref:`Array instance <valid-arrayinst>`          :math:`S \vdasharrayinst \arrayinst : \OKarrayinst`
:ref:`Export instance <valid-exportinst>`        :math:`S \vdashexportinst \exportinst : \OKexportinst`
:ref:`Module instance <valid-moduleinst>`        :math:`S \vdashmoduleinst \moduleinst : C`
:ref:`Store <valid-store>`                       :math:`\vdashstore \store : \OKstore`
:ref:`Configuration <valid-config>`              :math:`\vdashconfig \config : [t^\ast]`
:ref:`Thread <valid-thread>`                     :math:`S;\resulttype^? \vdashthread \thread : \resulttype`
:ref:`Frame <valid-frame>`                       :math:`S \vdashframe \frame : C`
===============================================  ===============================================================================


Constantness
~~~~~~~~~~~~

===============================================  ===============================================================================
Construct                                        Judgement
===============================================  ===============================================================================
:ref:`Constant expression <valid-constant>`      :math:`C \vdashexprconst \expr \CONSTexprconst`
:ref:`Constant instruction <valid-constant>`     :math:`C \vdashinstrconst \instr \CONSTinstrconst`
===============================================  ===============================================================================


Matching
~~~~~~~~

===============================================  ===================================================================================
Construct                                        Judgement
===============================================  ===================================================================================
:ref:`Number type <match-numtype>`               :math:`C \vdashnumtypematch \numtype_1 \subnumtypematch \numtype_2`
:ref:`Vector type <match-vectype>`               :math:`C \vdashvectypematch \vectype_1 \subvectypematch \vectype_2`
:ref:`Heap type <match-heaptype>`                :math:`C \vdashheaptypematch \heaptype_1 \subheaptypematch \heaptype_2`
:ref:`Reference type <match-reftype>`            :math:`C \vdashreftypematch \reftype_1 \subreftypematch \reftype_2`
:ref:`Value type <match-valtype>`                :math:`C \vdashvaltypematch \valtype_1 \subvaltypematch \valtype_2`
:ref:`Packed type <match-packtype>`              :math:`C \vdashpacktypematch \packtype_1 \subpacktypematch \packtype_2`
:ref:`Storage type <match-storagetype>`          :math:`C \vdashstoragetypematch \storagetype_1 \substoragetypematch \storagetype_2`
:ref:`Field type <match-fieldtype>`              :math:`C \vdashfieldtypematch \fieldtype_1 \subfieldtypematch \fieldtype_2`
:ref:`Result type <match-resulttype>`            :math:`C \vdashresulttypematch \resulttype_1 \subresulttypematch \resulttype_2`
:ref:`Instruction type <match-instrtype>`        :math:`C \vdashinstrtypematch \instrtype_1 \subinstrtypematch \instrtype_2`
:ref:`Function type <match-functype>`            :math:`C \vdashfunctypematch \functype_1 \subfunctypematch \functype_2`
:ref:`Structure type <match-structtype>`         :math:`C \vdashstructtypematch \structtype_1 \substructtypematch \structtype_2`
:ref:`Array type <match-arraytype>`              :math:`C \vdasharraytypematch \arraytype_1 \subarraytypematch \arraytype_2`
:ref:`Composite type <match-comptype>`           :math:`C \vdashcomptypematch \comptype_1 \subcomptypematch \comptype_2`
:ref:`Defined type <match-deftype>`              :math:`C \vdashdeftypematch \deftype_1 \subdeftypematch \deftype_2`
:ref:`Table type <match-tabletype>`              :math:`C \vdashtabletypematch \tabletype_1 \subtabletypematch \tabletype_2`
:ref:`Memory type <match-memtype>`               :math:`C \vdashmemtypematch \memtype_1 \submemtypematch \memtype_2`
:ref:`Global type <match-globaltype>`            :math:`C \vdashglobaltypematch \globaltype_1 \subglobaltypematch \globaltype_2`
:ref:`Tag type <match-tagtype>`                  :math:`C \vdashtagtypematch \tagtype_1 \subtagtype \tagtype_2`
:ref:`External type <match-externtype>`          :math:`C \vdashexterntypematch \externtype_1 \subexterntypematch \externtype_2`
:ref:`Limits <match-limits>`                     :math:`C \vdashlimitsmatch \limits_1 \sublimitsmatch \limits_2`
===============================================  ===================================================================================


Store Extension
~~~~~~~~~~~~~~~

===============================================  ===============================================================================
Construct                                        Judgement
===============================================  ===============================================================================
:ref:`Function instance <extend-funcinst>`       :math:`\vdashfuncinstextends \funcinst_1 \extendsto \funcinst_2`
:ref:`Table instance <extend-tableinst>`         :math:`\vdashtableinstextends \tableinst_1 \extendsto \tableinst_2`
:ref:`Memory instance <extend-meminst>`          :math:`\vdashmeminstextends \meminst_1 \extendsto \meminst_2`
:ref:`Global instance <extend-globalinst>`       :math:`\vdashglobalinstextends \globalinst_1 \extendsto \globalinst_2`
:ref:`Tag instance <extend-taginst>`             :math:`\vdashtaginstextends \taginst_1 \extendsto \taginst_2`
:ref:`Element instance <extend-eleminst>`        :math:`\vdasheleminstextends \eleminst_1 \extendsto \eleminst_2`
:ref:`Data instance <extend-datainst>`           :math:`\vdashdatainstextends \datainst_1 \extendsto \datainst_2`
:ref:`Structure instance <extend-structinst>`    :math:`\vdashstructinstextends \structinst_1 \extendsto \structinst_2`
:ref:`Array instance <extend-arrayinst>`         :math:`\vdasharrayinstextends \arrayinst_1 \extendsto \arrayinst_2`
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

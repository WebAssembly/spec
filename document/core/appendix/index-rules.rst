.. _index-rules:

Index of Semantic Rules
-----------------------


.. index:: validation
.. _index-valid:

Typing
~~~~~~

===============================================  ===============================================================================
Construct                                        Judgement
===============================================  ===============================================================================
:ref:`Limits <valid-limits>`                     :math:`\vdash \limits \ok`
:ref:`Function type <valid-functype>`            :math:`\vdash \functype \ok`
:ref:`Table type <valid-tabletype>`              :math:`\vdash \tabletype \ok`
:ref:`Memory type <valid-memtype>`               :math:`\vdash \memtype \ok`
:ref:`Global type <valid-globaltype>`            :math:`\vdash \globaltype \ok`
:ref:`Instruction <valid-instr>`                 :math:`S;C \vdash \instr : \functype`
:ref:`Instruction sequence <valid-instr-seq>`    :math:`S;C \vdash \instr^\ast : \functype`
:ref:`Expression <valid-expr>`                   :math:`C \vdash \expr : \resulttype`
:ref:`Function <valid-func>`                     :math:`C \vdash \func : \resulttype`
:ref:`Table <valid-table>`                       :math:`C \vdash \table : \tabletype`
:ref:`Memory <valid-mem>`                        :math:`C \vdash \mem : \memtype`
:ref:`Global <valid-global>`                     :math:`C \vdash \global : \globaltype`
:ref:`Element segment <valid-elem>`              :math:`C \vdash \elem \ok`
:ref:`Data segment <valid-data>`                 :math:`C \vdash \data \ok`
:ref:`Start function <valid-start>`              :math:`C \vdash \start \ok`
:ref:`Export <valid-export>`                     :math:`C \vdash \export : \name`
:ref:`Export description <valid-exportdesc>`     :math:`C \vdash \exportdesc \ok`
:ref:`Import <valid-import>`                     :math:`C \vdash \import : \externtype`
:ref:`Import description <valid-importdesc>`     :math:`C \vdash \importdesc : \externtype`
:ref:`Module <valid-module>`                     :math:`\vdash \module : \externtype^\ast`
:ref:`Module instruction <valid-moduleinstr>`    :math:`S \vdash \moduleinstr \ok`
:ref:`Function instance <valid-funcinst>`        :math:`S \vdash \funcinst : \resulttype`
:ref:`Table instance <valid-tableinst>`          :math:`S \vdash \tableinst : \tabletype`
:ref:`Memory instance <valid-meminst>`           :math:`S \vdash \meminst : \memtype`
:ref:`Global instance <valid-globalinst>`        :math:`S \vdash \globalinst : \globaltype`
:ref:`Export instance <valid-exportinst>`        :math:`S \vdash \exportinst \ok`
:ref:`Module instance <valid-moduleinst>`        :math:`S \vdash \moduleinst : C`
:ref:`Store <valid-store>`                       :math:`\vdash \store \ok`
:ref:`Configuration <valid-config>`              :math:`\vdash \config \ok`
:ref:`Thread <valid-thread>`                     :math:`S;\resulttype^? \vdash \thread : \resulttype^?`
:ref:`Frame <valid-frame>`                       :math:`S \vdash \frame : C`
:ref:`Value <valid-val>`                         :math:`\vdash \val : \valtype`
:ref:`External value <valid-externval>`          :math:`S \vdash \externval : \externtype`
===============================================  ===============================================================================


Constantness
~~~~~~~~~~~~

===============================================  ===============================================================================
Construct                                        Judgement
===============================================  ===============================================================================
:ref:`Constant expression <valid-constant>`      :math:`C \vdash \expr ~\mbox{const}`
:ref:`Constant instruction <valid-constant>`     :math:`C \vdash \instr ~\mbox{const}`
===============================================  ===============================================================================


Import Matching
~~~~~~~~~~~~~~~

===============================================  ===============================================================================
Construct                                        Judgement
===============================================  ===============================================================================
:ref:`Limits <match-limits>`                     :math:`\vdash \limits_1 \leq \limits_2`
:ref:`External type <match-externtype>`          :math:`\vdash \externtype_1 \leq \externtype_2`
===============================================  ===============================================================================


Store Extension
~~~~~~~~~~~~~~~

===============================================  ===============================================================================
Construct                                        Judgement
===============================================  ===============================================================================
:ref:`Function instance <extend-funcinst>`       :math:`\vdash \funcinst_1 \extendsto \funcinst_2`
:ref:`Table instance <extend-tableinst>`         :math:`\vdash \tableinst_1 \extendsto \tableinst_2`
:ref:`Memory instance <extend-meminst>`          :math:`\vdash \meminst_1 \extendsto \meminst_2`
:ref:`Global instance <extend-globalinst>`       :math:`\vdash \globalinst_1 \extendsto \globalinst_2`
:ref:`Store <extend-store>`                      :math:`\vdash \store_1 \extendsto \store_2`
===============================================  ===============================================================================


Execution
~~~~~~~~~

===============================================  ===============================================================================
Construct                                        Judgement
===============================================  ===============================================================================
:ref:`Instruction <exec-instr>`                  :math:`S;F;\instr \stepto S';F';{\instr'}^\ast`
:ref:`Expression <exec-expr>`                    :math:`S;F;\expr \stepto^\ast S';F';\val^\ast`
:ref:`Module instruction <exec-moduleinstr>`     :math:`S;\moduleinstr \stepto S';{\moduleinstr'}^\ast`
===============================================  ===============================================================================

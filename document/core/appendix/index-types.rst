.. index:: type
.. _index-type:

Index of Types
--------------

========================================  ==================================================  ===============================================================
Category                                  Constructor                                         Binary Opcode
========================================  ==================================================  ===============================================================
:ref:`Type index <syntax-typeidx>`        :math:`x`                                           (positive number as |Bs32| or |Bu32|)
:ref:`Number type <syntax-numtype>`       |I32|                                               :math:`\hex{7F}` (-1 as |Bs7|)
:ref:`Number type <syntax-numtype>`       |I64|                                               :math:`\hex{7E}` (-2 as |Bs7|)
:ref:`Number type <syntax-numtype>`       |F32|                                               :math:`\hex{7D}` (-3 as |Bs7|)
:ref:`Number type <syntax-numtype>`       |F64|                                               :math:`\hex{7C}` (-4 as |Bs7|)
:ref:`Vector type <syntax-vectype>`       |V128|                                              :math:`\hex{7B}` (-5 as |Bs7|)
(reserved)                                                                                    :math:`\hex{7A}` .. :math:`\hex{79}`
:ref:`Packed type <syntax-packtype>`      |I8|                                                :math:`\hex{78}` (-8 as |Bs7|)
:ref:`Packed type <syntax-packtype>`      |I16|                                               :math:`\hex{77}` (-9 as |Bs7|)
(reserved)                                                                                    :math:`\hex{78}` .. :math:`\hex{74}`
:ref:`Heap type <syntax-heaptype>`        |NOFUNC|                                            :math:`\hex{73}` (-13 as |Bs7|)
:ref:`Heap type <syntax-heaptype>`        |NOEXTERN|                                          :math:`\hex{72}` (-14 as |Bs7|)
:ref:`Heap type <syntax-heaptype>`        |NONE|                                              :math:`\hex{71}` (-15 as |Bs7|)
:ref:`Heap type <syntax-heaptype>`        |FUNC|                                              :math:`\hex{70}` (-16 as |Bs7|)
:ref:`Heap type <syntax-heaptype>`        |EXTERN|                                            :math:`\hex{6F}` (-17 as |Bs7|)
:ref:`Heap type <syntax-heaptype>`        |ANY|                                               :math:`\hex{6E}` (-18 as |Bs7|)
:ref:`Heap type <syntax-heaptype>`        |EQT|                                               :math:`\hex{6D}` (-19 as |Bs7|)
:ref:`Heap type <syntax-heaptype>`        |I31|                                               :math:`\hex{6C}` (-20 as |Bs7|)
:ref:`Heap type <syntax-heaptype>`        |STRUCT|                                            :math:`\hex{6B}` (-21 as |Bs7|)
:ref:`Heap type <syntax-heaptype>`        |ARRAY|                                             :math:`\hex{6A}` (-22 as |Bs7|)
(reserved)                                                                                    :math:`\hex{69}` .. :math:`\hex{65}`
:ref:`Reference type <syntax-reftype>`    |REF|                                               :math:`\hex{64}` (-28 as |Bs7|)
:ref:`Reference type <syntax-reftype>`    |REF| |NULL|                                        :math:`\hex{63}` (-29 as |Bs7|)
(reserved)                                                                                    :math:`\hex{62}` .. :math:`\hex{61}`
:ref:`Composite type <syntax-comptype>`   :math:`\TFUNC~[\valtype^\ast] \toF[\valtype^\ast]`  :math:`\hex{60}` (-32 as |Bs7|)
:ref:`Composite type <syntax-comptype>`   :math:`\TSTRUCT~\fieldtype^\ast`                    :math:`\hex{5F}` (-33 as |Bs7|)
:ref:`Composite type <syntax-comptype>`   :math:`\TARRAY~\fieldtype`                          :math:`\hex{5E}` (-34 as |Bs7|)
(reserved)                                                                                    :math:`\hex{5D}` .. :math:`\hex{51}`
:ref:`Sub type <syntax-subtype>`          :math:`\TSUB~\typeidx^\ast~\comptype`               :math:`\hex{50}` (-48 as |Bs7|)
:ref:`Sub type <syntax-subtype>`          :math:`\TSUB~\TFINAL~\typeidx^\ast~\comptype`       :math:`\hex{4F}` (-49 as |Bs7|)
:ref:`Recursive type <syntax-rectype>`    :math:`\TREC~\subtype^\ast`                         :math:`\hex{4E}` (-50 as |Bs7|)
(reserved)                                                                                    :math:`\hex{4D}` .. :math:`\hex{41}`
:ref:`Result type <syntax-resulttype>`    :math:`[\epsilon]`                                  :math:`\hex{40}` (-64 as |Bs7|)
:ref:`Table type <syntax-tabletype>`      :math:`\limits~\reftype`                            (none)
:ref:`Memory type <syntax-memtype>`       :math:`\limits`                                     (none)
:ref:`Global type <syntax-globaltype>`    :math:`\mut~\valtype`                               (none)
========================================  ==================================================  ===============================================================

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
:ref:`Packed type <syntax-packedtype>`    |I8|                                                :math:`\hex{7A}` (-6 as |Bs7|)
:ref:`Packed type <syntax-packedtype>`    |I16|                                               :math:`\hex{79}` (-7 as |Bs7|)
(reserved)                                                                                    :math:`\hex{78}` .. :math:`\hex{71}`
:ref:`Heap type <syntax-heaptype>`        |FUNC|                                              :math:`\hex{70}` (-16 as |Bs7|)
:ref:`Heap type <syntax-heaptype>`        |EXTERN|                                            :math:`\hex{6F}` (-17 as |Bs7|)
:ref:`Heap type <syntax-heaptype>`        |ANY|                                               :math:`\hex{6E}` (-18 as |Bs7|)
:ref:`Heap type <syntax-heaptype>`        |EQT|                                               :math:`\hex{6D}` (-19 as |Bs7|)
:ref:`Reference type <syntax-reftype>`    |REF| |NULL|                                        :math:`\hex{6C}` (-20 as |Bs7|)
:ref:`Reference type <syntax-reftype>`    |REF|                                               :math:`\hex{6B}` (-21 as |Bs7|)
:ref:`Heap type <syntax-heaptype>`        |I31|                                               :math:`\hex{6A}` (-22 as |Bs7|)
:ref:`Heap type <syntax-heaptype>`        |NOFUNC|                                            :math:`\hex{69}` (-23 as |Bs7|)
:ref:`Heap type <syntax-heaptype>`        |NOEXTERN|                                          :math:`\hex{68}` (-24 as |Bs7|)
:ref:`Heap type <syntax-heaptype>`        |STRUCT|                                            :math:`\hex{67}` (-25 as |Bs7|)
:ref:`Heap type <syntax-heaptype>`        |ARRAY|                                             :math:`\hex{66}` (-26 as |Bs7|)
:ref:`Heap type <syntax-heaptype>`        |NONE|                                              :math:`\hex{65}` (-27 as |Bs7|)
(reserved)                                                                                    :math:`\hex{64}` .. :math:`\hex{61}`
:ref:`Compound type <syntax-comptype>`    :math:`\TFUNC~[\valtype^\ast] \toF[\valtype^\ast]`  :math:`\hex{60}` (-32 as |Bs7|)
:ref:`Compound type <syntax-comptype>`    :math:`\TSTRUCT~\fieldtype^\ast`                    :math:`\hex{5F}` (-33 as |Bs7|)
:ref:`Compound type <syntax-comptype>`    :math:`\TARRAY~\fieldtype`                          :math:`\hex{5E}` (-34 as |Bs7|)
(reserved)                                                                                    :math:`\hex{5D}` .. :math:`\hex{51}`
:ref:`Sub type <syntax-subtype>`          :math:`\TSUB~\typeidx^\ast~\comptype`               :math:`\hex{50}` (-48 as |Bs7|)
:ref:`Recursive type <syntax-rectype>`    :math:`\TREC~\subtype^\ast`                         :math:`\hex{4F}` (-49 as |Bs7|)
:ref:`Sub type <syntax-subtype>`          :math:`\TSUB~\TFINAL~\typeidx^\ast~\comptype`       :math:`\hex{4E}` (-50 as |Bs7|)
(reserved)                                                                                    :math:`\hex{4D}` .. :math:`\hex{41}`
:ref:`Result type <syntax-resulttype>`    :math:`[\epsilon]`                                  :math:`\hex{40}` (-64 as |Bs7|)
:ref:`Table type <syntax-tabletype>`      :math:`\limits~\reftype`                            (none)
:ref:`Memory type <syntax-memtype>`       :math:`\limits`                                     (none)
:ref:`Global type <syntax-globaltype>`    :math:`\mut~\valtype`                               (none)
========================================  ==================================================  ===============================================================

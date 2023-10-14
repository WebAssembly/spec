.. index:: type
.. _index-type:

Index of Types
--------------

========================================  ===========================================  ===============================================================================
Category                                  Constructor                                         Binary Opcode
========================================  ===========================================  ===============================================================================
:ref:`Type index <syntax-typeidx>`        :math:`x`                                    (positive number as |Bs32| or |Bu32|)
:ref:`Number type <syntax-numtype>`       |I32|                                        :math:`\hex{7F}` (-1 as |Bs7|)
:ref:`Number type <syntax-numtype>`       |I64|                                        :math:`\hex{7E}` (-2 as |Bs7|)
:ref:`Number type <syntax-numtype>`       |F32|                                        :math:`\hex{7D}` (-3 as |Bs7|)
:ref:`Number type <syntax-numtype>`       |F64|                                        :math:`\hex{7C}` (-4 as |Bs7|)
:ref:`Vector type <syntax-vectype>`       |V128|                                       :math:`\hex{7B}` (-5 as |Bs7|)
(reserved)                                                                             :math:`\hex{7A}` .. :math:`\hex{71}`
:ref:`Heap type <syntax-heaptype>`        |FUNC|                                       :math:`\hex{70}` (-16 as |Bs7|)
:ref:`Heap type <syntax-heaptype>`        |EXTERN|                                     :math:`\hex{6F}` (-17 as |Bs7|)
(reserved)                                                                             :math:`\hex{6E}` .. :math:`\hex{65}`
:ref:`Reference type <syntax-reftype>`    |REF|                                        :math:`\hex{64}` (-28 as |Bs7|)
:ref:`Reference type <syntax-reftype>`    |REF| |NULL|                                 :math:`\hex{63}` (-29 as |Bs7|)
(reserved)                                                                             :math:`\hex{62}` .. :math:`\hex{61}`
:ref:`Function type <syntax-functype>`    :math:`[\valtype^\ast] \toF[\valtype^\ast]`  :math:`\hex{60}` (-32 as |Bs7|)
(reserved)                                                                             :math:`\hex{5F}` .. :math:`\hex{41}`
:ref:`Result type <syntax-resulttype>`    :math:`[\epsilon]`                           :math:`\hex{40}` (-64 as |Bs7|)
:ref:`Table type <syntax-tabletype>`      :math:`\limits~\reftype`                     (none)
:ref:`Memory type <syntax-memtype>`       :math:`\limits`                              (none)
:ref:`Global type <syntax-globaltype>`    :math:`\mut~\valtype`                        (none)
========================================  ===========================================  ===============================================================================

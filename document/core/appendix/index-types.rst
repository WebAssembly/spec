.. index:: type
.. _index-type:

Index of Types
--------------

========================================  ===========================================  ===============================================================================
Category                                  Constructor                                         Binary Opcode
========================================  ===========================================  ===============================================================================
:ref:`Type index <syntax-typeidx>`        :math:`x`                                    (positive number as |Bs32| or |Bu32|)
:ref:`Value type <syntax-valtype>`        |I32|                                        :math:`\hex{7F}` (-1 as |Bs7|)
:ref:`Value type <syntax-valtype>`        |I64|                                        :math:`\hex{7E}` (-2 as |Bs7|)
:ref:`Value type <syntax-valtype>`        |F32|                                        :math:`\hex{7D}` (-3 as |Bs7|)
:ref:`Value type <syntax-valtype>`        |F64|                                        :math:`\hex{7C}` (-4 as |Bs7|)
(reserved)                                                                             :math:`\hex{7C}` .. :math:`\hex{71}`
:ref:`Element type <syntax-elemtype>`     |ANYFUNC|                                    :math:`\hex{70}` (-16 as |Bs7|)
(reserved)                                                                             :math:`\hex{6F}` .. :math:`\hex{61}`
:ref:`Function type <syntax-functype>`    :math:`[\valtype^\ast] \to [\valtype^\ast]`  :math:`\hex{60}` (-32 as |Bs7|)
(reserved)                                                                             :math:`\hex{5F}` .. :math:`\hex{41}`
:ref:`Result type <syntax-resulttype>`    :math:`\epsilon`                             :math:`\hex{40}` (-64 as |Bs7|)
:ref:`Table type <syntax-tabletype>`      :math:`\limits~\elemtype`                    (none)
:ref:`Memory type <syntax-memtype>`       :math:`\limits`                              (none)
:ref:`Global type <syntax-globaltype>`    :math:`\mut~\valtype`                        (none)
========================================  ===========================================  ===============================================================================

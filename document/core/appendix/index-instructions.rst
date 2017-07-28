.. index:: instruction
.. _index-instr:

Index of Instructions
---------------------

===================================  ================  ==========================================  ========================================  ===============================================================
Instruction                          Binary Opcode     Type                                        Validation                                Execution
===================================  ================  ==========================================  ========================================  ===============================================================
:math:`\UNREACHABLE`                 :math:`\hex{00}`  :math:`[t_1^\ast] \to [t_2^\ast]`           :ref:`validation <valid-unreachable>`     :ref:`execution <exec-unreachable>`
:math:`\NOP`                         :math:`\hex{01}`  :math:`[] \to []`                           :ref:`validation <valid-nop>`             :ref:`execution <exec-nop>`
:math:`\BLOCK~[t^?]`                 :math:`\hex{02}`  :math:`[] \to [t^\ast]`                     :ref:`validation <valid-block>`           :ref:`execution <exec-block>`
:math:`\LOOP~[t^?]`                  :math:`\hex{03}`  :math:`[] \to [t^\ast]`                     :ref:`validation <valid-loop>`            :ref:`execution <exec-loop>`
:math:`\IF~[t^?]`                    :math:`\hex{04}`  :math:`[] \to [t^\ast]`                     :ref:`validation <valid-if>`              :ref:`execution <exec-if>`
:math:`\ELSE`                        :math:`\hex{05}`                                                
(reserved)                           :math:`\hex{06}`                                                  
(reserved)                           :math:`\hex{07}`                                                  
(reserved)                           :math:`\hex{08}`                                                  
(reserved)                           :math:`\hex{09}`                                                  
(reserved)                           :math:`\hex{0A}`                                                  
:math:`\END`                         :math:`\hex{0B}`                                                  
:math:`\BR~l`                        :math:`\hex{0C}`  :math:`[t_1^\ast~t^?] \to [t_2^\ast]`       :ref:`validation <valid-br>`              :ref:`execution <exec-br>`
:math:`\BRIF~l`                      :math:`\hex{0D}`  :math:`[t^?~\I32] \to [t^?]`                :ref:`validation <valid-br_if>`           :ref:`execution <exec-br_if>`
:math:`\BRTABLE~l^\ast~l`            :math:`\hex{0E}`  :math:`[t_1^\ast~t^?~\I32] \to [t_2^\ast]`  :ref:`validation <valid-br_table>`        :ref:`execution <exec-br_table>`
:math:`\RETURN`                      :math:`\hex{0F}`  :math:`[t_1^\ast~t^?] \to [t_2^\ast]`       :ref:`validation <valid-return>`          :ref:`execution <exec-return>`
:math:`\CALL~x`                      :math:`\hex{10}`  :math:`[t_1^\ast] \to [t_2^\ast]`           :ref:`validation <valid-call>`            :ref:`execution <exec-call>`
:math:`\CALLINDIRECT~x`              :math:`\hex{11}`  :math:`[t_1^\ast~\I32] \to [t_2^\ast]`      :ref:`validation <valid-call_indirect>`   :ref:`execution <exec-call_indirect>`
(reserved)                           :math:`\hex{12}`                                                  
(reserved)                           :math:`\hex{13}`                                                  
(reserved)                           :math:`\hex{14}`                                                  
(reserved)                           :math:`\hex{15}`                                                  
(reserved)                           :math:`\hex{16}`                                                  
(reserved)                           :math:`\hex{17}`                                                  
(reserved)                           :math:`\hex{18}`                                                  
(reserved)                           :math:`\hex{19}`                                                  
:math:`\DROP`                        :math:`\hex{1A}`  :math:`[t] \to []`                          :ref:`validation <valid-drop>`            :ref:`execution <exec-drop>`
:math:`\SELECT`                      :math:`\hex{1B}`  :math:`[t~t~\I32] \to [t]`                  :ref:`validation <valid-select>`          :ref:`execution <exec-select>`
(reserved)                           :math:`\hex{1C}`                                                  
(reserved)                           :math:`\hex{1D}`                                                  
(reserved)                           :math:`\hex{1E}`                                                  
(reserved)                           :math:`\hex{1F}`                                                  
:math:`\GETLOCAL~x`                  :math:`\hex{20}`  :math:`[] \to [t]`                          :ref:`validation <valid-get_local>`       :ref:`execution <exec-get_local>`
:math:`\SETLOCAL~x`                  :math:`\hex{21}`  :math:`[t] \to []`                          :ref:`validation <valid-set_local>`       :ref:`execution <exec-set_local>`
:math:`\TEELOCAL~x`                  :math:`\hex{22}`  :math:`[t] \to [t]`                         :ref:`validation <valid-tee_local>`       :ref:`execution <exec-tee_local>`
:math:`\GETGLOBAL~x`                 :math:`\hex{23}`  :math:`[] \to [t]`                          :ref:`validation <valid-get_global>`      :ref:`execution <exec-get_global>`
:math:`\SETGLOBAL~x`                 :math:`\hex{24}`  :math:`[t] \to []`                          :ref:`validation <valid-set_global>`      :ref:`execution <exec-set_global>`
(reserved)                           :math:`\hex{25}`                                                  
(reserved)                           :math:`\hex{26}`                                                  
(reserved)                           :math:`\hex{27}`                                                  
:math:`\I32.\LOAD~\memarg`           :math:`\hex{28}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-load>`            :ref:`execution <exec-load>`
:math:`\I64.\LOAD~\memarg`           :math:`\hex{29}`  :math:`[\I32] \to [\I64]`                   :ref:`validation <valid-load>`            :ref:`execution <exec-load>`
:math:`\F32.\LOAD~\memarg`           :math:`\hex{2A}`  :math:`[\I32] \to [\F32]`                   :ref:`validation <valid-load>`            :ref:`execution <exec-load>`
:math:`\F64.\LOAD~\memarg`           :math:`\hex{2B}`  :math:`[\I32] \to [\F64]`                   :ref:`validation <valid-load>`            :ref:`execution <exec-load>`
:math:`\I32.\LOAD\K{8\_s}~\memarg`   :math:`\hex{2C}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-loadn>`           :ref:`execution <exec-loadn>`
:math:`\I32.\LOAD\K{8\_u}~\memarg`   :math:`\hex{2D}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-loadn>`           :ref:`execution <exec-loadn>`
:math:`\I32.\LOAD\K{16\_s}~\memarg`  :math:`\hex{2E}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-loadn>`           :ref:`execution <exec-loadn>`
:math:`\I32.\LOAD\K{16\_u}~\memarg`  :math:`\hex{2F}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-loadn>`           :ref:`execution <exec-loadn>`
:math:`\I64.\LOAD\K{8\_s}~\memarg`   :math:`\hex{30}`  :math:`[\I32] \to [\I64]`                   :ref:`validation <valid-loadn>`           :ref:`execution <exec-loadn>`
:math:`\I64.\LOAD\K{8\_u}~\memarg`   :math:`\hex{31}`  :math:`[\I32] \to [\I64]`                   :ref:`validation <valid-loadn>`           :ref:`execution <exec-loadn>`
:math:`\I64.\LOAD\K{16\_s}~\memarg`  :math:`\hex{32}`  :math:`[\I32] \to [\I64]`                   :ref:`validation <valid-loadn>`           :ref:`execution <exec-loadn>`
:math:`\I64.\LOAD\K{16\_u}~\memarg`  :math:`\hex{33}`  :math:`[\I32] \to [\I64]`                   :ref:`validation <valid-loadn>`           :ref:`execution <exec-loadn>`
:math:`\I64.\LOAD\K{32\_s}~\memarg`  :math:`\hex{34}`  :math:`[\I32] \to [\I64]`                   :ref:`validation <valid-loadn>`           :ref:`execution <exec-loadn>`
:math:`\I64.\LOAD\K{32\_u}~\memarg`  :math:`\hex{35}`  :math:`[\I32] \to [\I64]`                   :ref:`validation <valid-loadn>`           :ref:`execution <exec-loadn>`
:math:`\I32.\STORE~\memarg`          :math:`\hex{36}`  :math:`[\I32~\I32] \to []`                  :ref:`validation <valid-store>`           :ref:`execution <exec-store>`
:math:`\I64.\STORE~\memarg`          :math:`\hex{37}`  :math:`[\I32~\I64] \to []`                  :ref:`validation <valid-store>`           :ref:`execution <exec-store>`
:math:`\F32.\STORE~\memarg`          :math:`\hex{38}`  :math:`[\I32~\F32] \to []`                  :ref:`validation <valid-store>`           :ref:`execution <exec-store>`
:math:`\F64.\STORE~\memarg`          :math:`\hex{39}`  :math:`[\I32~\F64] \to []`                  :ref:`validation <valid-store>`           :ref:`execution <exec-store>`
:math:`\I32.\STORE\K{8}~\memarg`     :math:`\hex{3A}`  :math:`[\I32~\I32] \to []`                  :ref:`validation <valid-storen>`          :ref:`execution <exec-storen>`
:math:`\I32.\STORE\K{16}~\memarg`    :math:`\hex{3B}`  :math:`[\I32~\I32] \to []`                  :ref:`validation <valid-storen>`          :ref:`execution <exec-storen>`
:math:`\I64.\STORE\K{8}~\memarg`     :math:`\hex{3C}`  :math:`[\I32~\I64] \to []`                  :ref:`validation <valid-storen>`          :ref:`execution <exec-storen>`
:math:`\I64.\STORE\K{16}~\memarg`    :math:`\hex{3D}`  :math:`[\I32~\I64] \to []`                  :ref:`validation <valid-storen>`          :ref:`execution <exec-storen>`
:math:`\I64.\STORE\K{32}~\memarg`    :math:`\hex{3E}`  :math:`[\I32~\I64] \to []`                  :ref:`validation <valid-storen>`          :ref:`execution <exec-storen>`
:math:`\CURRENTMEMORY`               :math:`\hex{3F}`  :math:`[] \to [\I32]`                       :ref:`validation <valid-current_memory>`  :ref:`execution <exec-current_memory>`
:math:`\GROWMEMORY`                  :math:`\hex{40}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-grow_memory>`     :ref:`execution <exec-grow_memory>`
:math:`\I32.\CONST~\i32`             :math:`\hex{41}`  :math:`[] \to [\I32]`                       :ref:`validation <valid-const>`           :ref:`execution <exec-const>`
:math:`\I64.\CONST~\i64`             :math:`\hex{42}`  :math:`[] \to [\I64]`                       :ref:`validation <valid-const>`           :ref:`execution <exec-const>`
:math:`\F32.\CONST~\f32`             :math:`\hex{43}`  :math:`[] \to [\F32]`                       :ref:`validation <valid-const>`           :ref:`execution <exec-const>`
:math:`\F64.\CONST~\f64`             :math:`\hex{44}`  :math:`[] \to [\F64]`                       :ref:`validation <valid-const>`           :ref:`execution <exec-const>`
:math:`\I32.\EQZ`                    :math:`\hex{45}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-testop>`          :ref:`execution <exec-testop>`, :ref:`operator <op-ieqz>`
:math:`\I32.\EQ`                     :math:`\hex{46}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-ieq>`
:math:`\I32.\NE`                     :math:`\hex{47}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-ine>`
:math:`\I32.\LT\K{\_s}`              :math:`\hex{48}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-ilt_s>`
:math:`\I32.\LT\K{\_u}`              :math:`\hex{49}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-ilt_u>`
:math:`\I32.\GT\K{\_s}`              :math:`\hex{4A}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-igt_s>`
:math:`\I32.\GT\K{\_u}`              :math:`\hex{4B}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-igt_u>`
:math:`\I32.\LE\K{\_s}`              :math:`\hex{4C}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-ile_s>`
:math:`\I32.\LE\K{\_u}`              :math:`\hex{4D}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-ile_u>`
:math:`\I32.\GE\K{\_s}`              :math:`\hex{4E}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-ige_s>`
:math:`\I32.\GE\K{\_u}`              :math:`\hex{4F}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-ige_u>`
:math:`\I64.\EQZ`                    :math:`\hex{50}`  :math:`[\I64] \to [\I32]`                   :ref:`validation <valid-testop>`          :ref:`execution <exec-testop>`, :ref:`operator <op-ieqz>`
:math:`\I64.\EQ`                     :math:`\hex{51}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-ieq>`
:math:`\I64.\NE`                     :math:`\hex{52}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-ine>`
:math:`\I64.\LT\K{\_s}`              :math:`\hex{53}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-ilt_s>`
:math:`\I64.\LT\K{\_u}`              :math:`\hex{54}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-ilt_u>`
:math:`\I64.\GT\K{\_s}`              :math:`\hex{55}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-igt_s>`
:math:`\I64.\GT\K{\_u}`              :math:`\hex{56}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-igt_u>`
:math:`\I64.\LE\K{\_s}`              :math:`\hex{57}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-ile_s>`
:math:`\I64.\LE\K{\_u}`              :math:`\hex{58}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-ile_u>`
:math:`\I64.\GE\K{\_s}`              :math:`\hex{59}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-ige_s>`
:math:`\I64.\GE\K{\_u}`              :math:`\hex{5A}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-ige_u>`
:math:`\F32.\EQ`                     :math:`\hex{5B}`  :math:`[\F32~\F32] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-feq>`
:math:`\F32.\NE`                     :math:`\hex{5C}`  :math:`[\F32~\F32] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-fne>`
:math:`\F32.\LT`                     :math:`\hex{5D}`  :math:`[\F32~\F32] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-flt>`
:math:`\F32.\GT`                     :math:`\hex{5E}`  :math:`[\F32~\F32] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-fgt>`
:math:`\F32.\LE`                     :math:`\hex{5F}`  :math:`[\F32~\F32] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-fle>`
:math:`\F32.\GE`                     :math:`\hex{60}`  :math:`[\F32~\F32] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-fge>`
:math:`\F64.\EQ`                     :math:`\hex{61}`  :math:`[\F64~\F64] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-feq>`
:math:`\F64.\NE`                     :math:`\hex{62}`  :math:`[\F64~\F64] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-fne>`
:math:`\F64.\LT`                     :math:`\hex{63}`  :math:`[\F64~\F64] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-flt>`
:math:`\F64.\GT`                     :math:`\hex{64}`  :math:`[\F64~\F64] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-fgt>`
:math:`\F64.\LE`                     :math:`\hex{65}`  :math:`[\F64~\F64] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-fle>`
:math:`\F64.\GE`                     :math:`\hex{66}`  :math:`[\F64~\F64] \to [\I32]`              :ref:`validation <valid-relop>`           :ref:`execution <exec-relop>`, :ref:`operator <op-fge>`
:math:`\I32.\CLZ`                    :math:`\hex{67}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-iclz>`
:math:`\I32.\CTZ`                    :math:`\hex{68}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-ictz>`
:math:`\I32.\POPCNT`                 :math:`\hex{69}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-ipopcnt>`
:math:`\I32.\ADD`                    :math:`\hex{6A}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-iadd>`
:math:`\I32.\SUB`                    :math:`\hex{6B}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-isub>`
:math:`\I32.\MUL`                    :math:`\hex{6C}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-imul>`
:math:`\I32.\DIV\K{\_s}`             :math:`\hex{6D}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-idiv_s>`
:math:`\I32.\DIV\K{\_u}`             :math:`\hex{6E}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-idiv_u>`
:math:`\I32.\REM\K{\_s}`             :math:`\hex{6F}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-irem_s>`
:math:`\I32.\REM\K{\_u}`             :math:`\hex{70}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-irem_u>`
:math:`\I32.\AND`                    :math:`\hex{71}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-iand>`
:math:`\I32.\OR`                     :math:`\hex{72}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-ior>`
:math:`\I32.\XOR`                    :math:`\hex{73}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-ixor>`
:math:`\I32.\SHL`                    :math:`\hex{74}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-ishl>`
:math:`\I32.\SHR\K{\_s}`             :math:`\hex{75}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-ishr_s>`
:math:`\I32.\SHR\K{\_u}`             :math:`\hex{76}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-ishr_u>`
:math:`\I32.\ROTL`                   :math:`\hex{77}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-irotl>`
:math:`\I32.\ROTR`                   :math:`\hex{78}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-irotr>`
:math:`\I64.\CLZ`                    :math:`\hex{79}`  :math:`[\I64] \to [\I64]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-iclz>`
:math:`\I64.\CTZ`                    :math:`\hex{7A}`  :math:`[\I64] \to [\I64]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-ictz>`
:math:`\I64.\POPCNT`                 :math:`\hex{7B}`  :math:`[\I64] \to [\I64]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-ipopcnt>`
:math:`\I64.\ADD`                    :math:`\hex{7C}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-iadd>`
:math:`\I64.\SUB`                    :math:`\hex{7D}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-isub>`
:math:`\I64.\MUL`                    :math:`\hex{7E}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-imul>`
:math:`\I64.\DIV\K{\_s}`             :math:`\hex{7F}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-idiv_s>`
:math:`\I64.\DIV\K{\_u}`             :math:`\hex{80}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-idiv_u>`
:math:`\I64.\REM\K{\_s}`             :math:`\hex{81}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-irem_s>`
:math:`\I64.\REM\K{\_u}`             :math:`\hex{82}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-irem_u>`
:math:`\I64.\AND`                    :math:`\hex{83}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-iand>`
:math:`\I64.\OR`                     :math:`\hex{84}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-ior>`
:math:`\I64.\XOR`                    :math:`\hex{85}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-ixor>`
:math:`\I64.\SHL`                    :math:`\hex{86}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-ishl>`
:math:`\I64.\SHR\K{\_s}`             :math:`\hex{87}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-ishr_s>`
:math:`\I64.\SHR\K{\_u}`             :math:`\hex{88}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-ishr_u>`
:math:`\I64.\ROTL`                   :math:`\hex{89}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-irotl>`
:math:`\I64.\ROTR`                   :math:`\hex{8A}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-irotr>`
:math:`\F32.\ABS`                    :math:`\hex{8B}`  :math:`[\F32] \to [\F32]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-fabs>`
:math:`\F32.\NEG`                    :math:`\hex{8C}`  :math:`[\F32] \to [\F32]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-fneg>`
:math:`\F32.\CEIL`                   :math:`\hex{8D}`  :math:`[\F32] \to [\F32]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-fceil>`
:math:`\F32.\FLOOR`                  :math:`\hex{8E}`  :math:`[\F32] \to [\F32]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-ffloor>`
:math:`\F32.\TRUNC`                  :math:`\hex{8F}`  :math:`[\F32] \to [\F32]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-ftrunc>`
:math:`\F32.\NEAREST`                :math:`\hex{90}`  :math:`[\F32] \to [\F32]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-fnearest>`
:math:`\F32.\SQRT`                   :math:`\hex{91}`  :math:`[\F32] \to [\F32]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-fsqrt>`
:math:`\F32.\ADD`                    :math:`\hex{92}`  :math:`[\F32~\F32] \to [\F32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-fadd>`
:math:`\F32.\SUB`                    :math:`\hex{93}`  :math:`[\F32~\F32] \to [\F32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-fsub>`
:math:`\F32.\MUL`                    :math:`\hex{94}`  :math:`[\F32~\F32] \to [\F32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-fmul>`
:math:`\F32.\DIV`                    :math:`\hex{95}`  :math:`[\F32~\F32] \to [\F32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-fdiv>`
:math:`\F32.\FMIN`                   :math:`\hex{96}`  :math:`[\F32~\F32] \to [\F32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-fmin>`
:math:`\F32.\FMAX`                   :math:`\hex{97}`  :math:`[\F32~\F32] \to [\F32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-fmax>`
:math:`\F32.\COPYSIGN`               :math:`\hex{98}`  :math:`[\F32~\F32] \to [\F32]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-fcopysign>`
:math:`\F64.\ABS`                    :math:`\hex{99}`  :math:`[\F64] \to [\F64]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-fabs>`
:math:`\F64.\NEG`                    :math:`\hex{9A}`  :math:`[\F64] \to [\F64]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-fneg>`
:math:`\F64.\CEIL`                   :math:`\hex{9B}`  :math:`[\F64] \to [\F64]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-fceil>`
:math:`\F64.\FLOOR`                  :math:`\hex{9C}`  :math:`[\F64] \to [\F64]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-ffloor>`
:math:`\F64.\TRUNC`                  :math:`\hex{9D}`  :math:`[\F64] \to [\F64]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-ftrunc>`
:math:`\F64.\NEAREST`                :math:`\hex{9E}`  :math:`[\F64] \to [\F64]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-fnearest>`
:math:`\F64.\SQRT`                   :math:`\hex{9F}`  :math:`[\F64] \to [\F64]`                   :ref:`validation <valid-unop>`            :ref:`execution <exec-unop>`, :ref:`operator <op-fsqrt>`
:math:`\F64.\ADD`                    :math:`\hex{A0}`  :math:`[\F64~\F64] \to [\F64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-fadd>`
:math:`\F64.\SUB`                    :math:`\hex{A1}`  :math:`[\F64~\F64] \to [\F64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-fsub>`
:math:`\F64.\MUL`                    :math:`\hex{A2}`  :math:`[\F64~\F64] \to [\F64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-fmul>`
:math:`\F64.\DIV`                    :math:`\hex{A3}`  :math:`[\F64~\F64] \to [\F64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-fdiv>`
:math:`\F64.\FMIN`                   :math:`\hex{A4}`  :math:`[\F64~\F64] \to [\F64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-fmin>`
:math:`\F64.\FMAX`                   :math:`\hex{A5}`  :math:`[\F64~\F64] \to [\F64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-fmax>`
:math:`\F64.\COPYSIGN`               :math:`\hex{A6}`  :math:`[\F64~\F64] \to [\F64]`              :ref:`validation <valid-binop>`           :ref:`execution <exec-binop>`, :ref:`operator <op-fcopysign>`
:math:`\I32.\WRAP\K{/}\I64`          :math:`\hex{A7}`  :math:`[\I64] \to [\I32]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-wrap>`
:math:`\I32.\TRUNC\K{\_s/}\F32`      :math:`\hex{A8}`  :math:`[\F32] \to [\I32]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-trunc_s>`
:math:`\I32.\TRUNC\K{\_u/}\F32`      :math:`\hex{A9}`  :math:`[\F32] \to [\I32]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-trunc_u>`
:math:`\I32.\TRUNC\K{\_s/}\F64`      :math:`\hex{AA}`  :math:`[\F64] \to [\I32]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-trunc_s>`
:math:`\I32.\TRUNC\K{\_u/}\F64`      :math:`\hex{AB}`  :math:`[\F64] \to [\I32]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-trunc_u>`
:math:`\I64.\EXTEND\K{\_s/}\I32`     :math:`\hex{AC}`  :math:`[\I32] \to [\I64]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-extend_s>`
:math:`\I64.\EXTEND\K{\_u/}\I32`     :math:`\hex{AD}`  :math:`[\I32] \to [\I64]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-extend_u>`
:math:`\I64.\TRUNC\K{\_s/}\F32`      :math:`\hex{AE}`  :math:`[\F32] \to [\I64]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-trunc_s>`
:math:`\I64.\TRUNC\K{\_u/}\F32`      :math:`\hex{AF}`  :math:`[\F32] \to [\I64]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-trunc_u>`
:math:`\I64.\TRUNC\K{\_s/}\F64`      :math:`\hex{B0}`  :math:`[\F64] \to [\I64]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-trunc_s>`
:math:`\I64.\TRUNC\K{\_u/}\F64`      :math:`\hex{B1}`  :math:`[\F64] \to [\I64]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-trunc_u>`
:math:`\F32.\CONVERT\K{\_s/}\I32`    :math:`\hex{B2}`  :math:`[\I32] \to [\F32]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-convert_s>`
:math:`\F32.\CONVERT\K{\_u/}\I32`    :math:`\hex{B3}`  :math:`[\I32] \to [\F32]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-convert_u>`
:math:`\F32.\CONVERT\K{\_s/}\I64`    :math:`\hex{B4}`  :math:`[\I64] \to [\F32]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-convert_s>`
:math:`\F32.\CONVERT\K{\_u/}\I64`    :math:`\hex{B5}`  :math:`[\I64] \to [\F32]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-convert_u>`
:math:`\F32.\DEMOTE\K{/}\F64`        :math:`\hex{B6}`  :math:`[\F64] \to [\F32]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-demote>`
:math:`\F64.\CONVERT\K{\_s/}\I32`    :math:`\hex{B7}`  :math:`[\I32] \to [\F64]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-convert_s>`
:math:`\F64.\CONVERT\K{\_u/}\I32`    :math:`\hex{B8}`  :math:`[\I32] \to [\F64]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-convert_u>`
:math:`\F64.\CONVERT\K{\_s/}\I64`    :math:`\hex{B9}`  :math:`[\I64] \to [\F64]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-convert_s>`
:math:`\F64.\CONVERT\K{\_u/}\I64`    :math:`\hex{BA}`  :math:`[\I64] \to [\F64]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-convert_u>`
:math:`\F64.\PROMOTE\K{/}\F32`       :math:`\hex{BB}`  :math:`[\F32] \to [\F64]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-promote>`
:math:`\I32.\REINTERPRET\K{/}\F32`   :math:`\hex{BC}`  :math:`[\F32] \to [\I32]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-reinterpret>`
:math:`\I64.\REINTERPRET\K{/}\F64`   :math:`\hex{BD}`  :math:`[\F64] \to [\I64]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-reinterpret>`
:math:`\F32.\REINTERPRET\K{/}\I32`   :math:`\hex{BE}`  :math:`[\I32] \to [\F32]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-reinterpret>`
:math:`\F64.\REINTERPRET\K{/}\I64`   :math:`\hex{BF}`  :math:`[\I64] \to [\F64]`                   :ref:`validation <valid-cvtop>`           :ref:`execution <exec-cvtop>`, :ref:`operator <op-reinterpret>`
===================================  ================  ==========================================  ========================================  ===============================================================


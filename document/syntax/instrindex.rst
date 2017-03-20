.. _instrindex:

Index of Instructions
---------------------

===================================  ================  ==========================================  ========================================  ================
Instruction                          Opcode            Type                                        Validation                                Execution
===================================  ================  ==========================================  ========================================  ================
:math:`\UNREACHABLE`                 :math:`\hex{00}`  :math:`[t_1^\ast] \to [t_2^\ast]`           :ref:`validation <valid-unreachable>`
:math:`\NOP`                         :math:`\hex{01}`  :math:`[] \to []`                           :ref:`validation <valid-nop>`
:math:`\BLOCK~[t^?]`                 :math:`\hex{02}`  :math:`[] \to [t^\ast]`                     :ref:`validation <valid-block>`
:math:`\LOOP~[t^?]`                  :math:`\hex{03}`  :math:`[] \to [t^\ast]`                     :ref:`validation <valid-loop>`
:math:`\IF~[t^?]`                    :math:`\hex{04}`  :math:`[] \to [t^\ast]`                     :ref:`validation <valid-if>`
:math:`\ELSE`                        :math:`\hex{05}`                                                
(reserved)                           :math:`\hex{06}`                                                  
(reserved)                           :math:`\hex{07}`                                                  
(reserved)                           :math:`\hex{08}`                                                  
(reserved)                           :math:`\hex{09}`                                                  
(reserved)                           :math:`\hex{0A}`                                                  
:math:`\END`                         :math:`\hex{0B}`                                                  
:math:`\BR~l`                        :math:`\hex{0C}`  :math:`[t_1^\ast~t^?] \to [t_2^\ast]`       :ref:`validation <valid-br>`
:math:`\BRIF~l`                      :math:`\hex{0D}`  :math:`[t^?~\I32] \to [t^?]`                :ref:`validation <valid-br_if>`
:math:`\BRTABLE~l^\ast~l`            :math:`\hex{0E}`  :math:`[t_1^\ast~t^?~\I32] \to [t_2^\ast]`  :ref:`validation <valid-br_table>`
:math:`\RETURN`                      :math:`\hex{0F}`  :math:`[t_1^\ast~t^?] \to [t_2^\ast]`       :ref:`validation <valid-return>`
:math:`\CALL~x`                      :math:`\hex{10}`  :math:`[t_1^\ast] \to [t_2^\ast]`           :ref:`validation <valid-call>`
:math:`\CALLINDIRECT~x`              :math:`\hex{11}`  :math:`[t_1^\ast~\I32] \to [t_2^\ast]`      :ref:`validation <valid-call_indirect>`
(reserved)                           :math:`\hex{12}`                                                  
(reserved)                           :math:`\hex{13}`                                                  
(reserved)                           :math:`\hex{14}`                                                  
(reserved)                           :math:`\hex{15}`                                                  
(reserved)                           :math:`\hex{16}`                                                  
(reserved)                           :math:`\hex{17}`                                                  
(reserved)                           :math:`\hex{18}`                                                  
(reserved)                           :math:`\hex{19}`                                                  
:math:`\DROP`                        :math:`\hex{1A}`  :math:`[t] \to []`                          :ref:`validation <valid-drop>`
:math:`\SELECT`                      :math:`\hex{1B}`  :math:`[t~t~\I32] \to [t]`                  :ref:`validation <valid-select>`
(reserved)                           :math:`\hex{1C}`                                                  
(reserved)                           :math:`\hex{1D}`                                                  
(reserved)                           :math:`\hex{1E}`                                                  
(reserved)                           :math:`\hex{1F}`                                                  
:math:`\GETLOCAL~x`                  :math:`\hex{20}`  :math:`[] \to [t]`                          :ref:`validation <valid-get_local>`
:math:`\SETLOCAL~x`                  :math:`\hex{21}`  :math:`[t] \to []`                          :ref:`validation <valid-set_local>`
:math:`\TEELOCAL~x`                  :math:`\hex{22}`  :math:`[t] \to [t]`                         :ref:`validation <valid-tee_local>`
:math:`\GETGLOBAL~x`                 :math:`\hex{23}`  :math:`[\I32] \to [t]`                      :ref:`validation <valid-get_global>`
:math:`\SETGLOBAL~x`                 :math:`\hex{24}`  :math:`[\I32~t] \to []`                     :ref:`validation <valid-set_global>`
(reserved)                           :math:`\hex{25}`                                                  
(reserved)                           :math:`\hex{26}`                                                  
(reserved)                           :math:`\hex{27}`                                                  
:math:`\I32.\LOAD~\memarg`           :math:`\hex{28}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-load>`
:math:`\I64.\LOAD~\memarg`           :math:`\hex{29}`  :math:`[\I32] \to [\I64]`                   :ref:`validation <valid-load>`
:math:`\F32.\LOAD~\memarg`           :math:`\hex{2A}`  :math:`[\I32] \to [\F32]`                   :ref:`validation <valid-load>`
:math:`\F64.\LOAD~\memarg`           :math:`\hex{2B}`  :math:`[\I32] \to [\F64]`                   :ref:`validation <valid-load>`
:math:`\I32.\LOAD\K{8\_s}~\memarg`   :math:`\hex{2C}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-loadn>`
:math:`\I32.\LOAD\K{8\_u}~\memarg`   :math:`\hex{2D}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-loadn>`
:math:`\I32.\LOAD\K{16\_s}~\memarg`  :math:`\hex{2E}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-loadn>`
:math:`\I32.\LOAD\K{16\_u}~\memarg`  :math:`\hex{2F}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-loadn>`
:math:`\I64.\LOAD\K{8\_s}~\memarg`   :math:`\hex{30}`  :math:`[\I32] \to [\I64]`                   :ref:`validation <valid-loadn>`
:math:`\I64.\LOAD\K{8\_u}~\memarg`   :math:`\hex{31}`  :math:`[\I32] \to [\I64]`                   :ref:`validation <valid-loadn>`
:math:`\I64.\LOAD\K{16\_s}~\memarg`  :math:`\hex{32}`  :math:`[\I32] \to [\I64]`                   :ref:`validation <valid-loadn>`
:math:`\I64.\LOAD\K{16\_u}~\memarg`  :math:`\hex{33}`  :math:`[\I32] \to [\I64]`                   :ref:`validation <valid-loadn>`
:math:`\I64.\LOAD\K{32\_s}~\memarg`  :math:`\hex{34}`  :math:`[\I32] \to [\I64]`                   :ref:`validation <valid-loadn>`
:math:`\I64.\LOAD\K{32\_u}~\memarg`  :math:`\hex{35}`  :math:`[\I32] \to [\I64]`                   :ref:`validation <valid-loadn>`
:math:`\I32.\STORE~\memarg`          :math:`\hex{36}`  :math:`[\I32~\I32] \to []`                  :ref:`validation <valid-store>`
:math:`\I64.\STORE~\memarg`          :math:`\hex{37}`  :math:`[\I32~\I64] \to []`                  :ref:`validation <valid-store>`
:math:`\F32.\STORE~\memarg`          :math:`\hex{38}`  :math:`[\I32~\F32] \to []`                  :ref:`validation <valid-store>`
:math:`\F64.\STORE~\memarg`          :math:`\hex{39}`  :math:`[\I32~\F64] \to []`                  :ref:`validation <valid-store>`
:math:`\I32.\STORE\K{8}~\memarg`     :math:`\hex{3A}`  :math:`[\I32~\I32] \to []`                  :ref:`validation <valid-storen>`
:math:`\I32.\STORE\K{16}~\memarg`    :math:`\hex{3B}`  :math:`[\I32~\I32] \to []`                  :ref:`validation <valid-storen>`
:math:`\I64.\STORE\K{8}~\memarg`     :math:`\hex{3C}`  :math:`[\I32~\I64] \to []`                  :ref:`validation <valid-storen>`
:math:`\I64.\STORE\K{16}~\memarg`    :math:`\hex{3D}`  :math:`[\I32~\I64] \to []`                  :ref:`validation <valid-storen>`
:math:`\I64.\STORE\K{32}~\memarg`    :math:`\hex{3E}`  :math:`[\I32~\I64] \to []`                  :ref:`validation <valid-storen>`
:math:`\CURRENTMEMORY`               :math:`\hex{3F}`  :math:`[] \to [\I32]`                       :ref:`validation <valid-current_memory>`
:math:`\GROWMEMORY`                  :math:`\hex{40}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-grow_memory>`
:math:`\I32.\CONST~\i32`             :math:`\hex{41}`  :math:`[] \to [\I32]`                       :ref:`validation <valid-const>`
:math:`\I64.\CONST~\i64`             :math:`\hex{42}`  :math:`[] \to [\I64]`                       :ref:`validation <valid-const>`
:math:`\F32.\CONST~\f32`             :math:`\hex{43}`  :math:`[] \to [\F32]`                       :ref:`validation <valid-const>`
:math:`\F64.\CONST~\f64`             :math:`\hex{44}`  :math:`[] \to [\F64]`                       :ref:`validation <valid-const>`
:math:`\I32.\K{eqz}`                 :math:`\hex{45}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-testop>`
:math:`\I32.\K{eq}`                  :math:`\hex{46}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I32.\K{ne}`                  :math:`\hex{47}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I32.\K{lt\_s}`               :math:`\hex{48}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I32.\K{lt\_u}`               :math:`\hex{49}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I32.\K{gt\_s}`               :math:`\hex{4A}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I32.\K{gt\_u}`               :math:`\hex{4B}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I32.\K{le\_s}`               :math:`\hex{4C}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I32.\K{le\_u}`               :math:`\hex{4D}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I32.\K{ge\_s}`               :math:`\hex{4E}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I32.\K{ge\_u}`               :math:`\hex{4F}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I64.\K{eqz}`                 :math:`\hex{50}`  :math:`[\I64] \to [\I32]`                   :ref:`validation <valid-testop>`
:math:`\I64.\K{eq}`                  :math:`\hex{51}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I64.\K{ne}`                  :math:`\hex{52}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I64.\K{lt\_s}`               :math:`\hex{53}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I64.\K{lt\_u}`               :math:`\hex{54}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I64.\K{gt\_s}`               :math:`\hex{55}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I64.\K{gt\_u}`               :math:`\hex{56}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I64.\K{le\_s}`               :math:`\hex{57}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I64.\K{le\_u}`               :math:`\hex{58}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I64.\K{ge\_s}`               :math:`\hex{59}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I64.\K{ge\_u}`               :math:`\hex{5A}`  :math:`[\I64~\I64] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\F32.\K{eq}`                  :math:`\hex{5B}`  :math:`[\F32~\F32] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\F32.\K{ne}`                  :math:`\hex{5C}`  :math:`[\F32~\F32] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\F32.\K{lt}`                  :math:`\hex{5D}`  :math:`[\F32~\F32] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\F32.\K{gt}`                  :math:`\hex{5E}`  :math:`[\F32~\F32] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\F32.\K{le}`                  :math:`\hex{5F}`  :math:`[\F32~\F32] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\F32.\K{ge}`                  :math:`\hex{60}`  :math:`[\F32~\F32] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\F64.\K{eq}`                  :math:`\hex{61}`  :math:`[\F64~\F64] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\F64.\K{ne}`                  :math:`\hex{62}`  :math:`[\F64~\F64] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\F64.\K{lt}`                  :math:`\hex{63}`  :math:`[\F64~\F64] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\F64.\K{gt}`                  :math:`\hex{64}`  :math:`[\F64~\F64] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\F64.\K{le}`                  :math:`\hex{65}`  :math:`[\F64~\F64] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\F64.\K{ge}`                  :math:`\hex{66}`  :math:`[\F64~\F64] \to [\I32]`              :ref:`validation <valid-relop>`
:math:`\I32.\K{clz}`                 :math:`\hex{67}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-unop>`
:math:`\I32.\K{ctz}`                 :math:`\hex{68}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-unop>`
:math:`\I32.\K{popcnt}`              :math:`\hex{69}`  :math:`[\I32] \to [\I32]`                   :ref:`validation <valid-unop>`
:math:`\I32.\K{add}`                 :math:`\hex{6A}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`
:math:`\I32.\K{sub}`                 :math:`\hex{6B}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`
:math:`\I32.\K{mul}`                 :math:`\hex{6C}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`
:math:`\I32.\K{div\_s}`              :math:`\hex{6D}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`
:math:`\I32.\K{div\_u}`              :math:`\hex{6E}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`
:math:`\I32.\K{rem\_s}`              :math:`\hex{6F}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`
:math:`\I32.\K{rem\_u}`              :math:`\hex{70}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`
:math:`\I32.\K{and}`                 :math:`\hex{71}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`
:math:`\I32.\K{or}`                  :math:`\hex{72}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`
:math:`\I32.\K{xor}`                 :math:`\hex{73}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`
:math:`\I32.\K{shl}`                 :math:`\hex{74}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`
:math:`\I32.\K{shr\_s}`              :math:`\hex{75}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`
:math:`\I32.\K{shr\_u}`              :math:`\hex{76}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`
:math:`\I32.\K{rotl}`                :math:`\hex{77}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`
:math:`\I32.\K{rotr}`                :math:`\hex{78}`  :math:`[\I32~\I32] \to [\I32]`              :ref:`validation <valid-binop>`
:math:`\I64.\K{clz}`                 :math:`\hex{79}`  :math:`[\I64] \to [\I64]`                   :ref:`validation <valid-unop>`
:math:`\I64.\K{ctz}`                 :math:`\hex{7A}`  :math:`[\I64] \to [\I64]`                   :ref:`validation <valid-unop>`
:math:`\I64.\K{popcnt}`              :math:`\hex{7B}`  :math:`[\I64] \to [\I64]`                   :ref:`validation <valid-unop>`
:math:`\I64.\K{add}`                 :math:`\hex{7C}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`
:math:`\I64.\K{sub}`                 :math:`\hex{7D}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`
:math:`\I64.\K{mul}`                 :math:`\hex{7E}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`
:math:`\I64.\K{div\_s}`              :math:`\hex{7F}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`
:math:`\I64.\K{div\_u}`              :math:`\hex{80}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`
:math:`\I64.\K{rem\_s}`              :math:`\hex{81}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`
:math:`\I64.\K{rem\_u}`              :math:`\hex{82}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`
:math:`\I64.\K{and}`                 :math:`\hex{83}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`
:math:`\I64.\K{or}`                  :math:`\hex{84}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`
:math:`\I64.\K{xor}`                 :math:`\hex{85}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`
:math:`\I64.\K{shl}`                 :math:`\hex{86}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`
:math:`\I64.\K{shr\_s}`              :math:`\hex{87}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`
:math:`\I64.\K{shr\_u}`              :math:`\hex{88}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`
:math:`\I64.\K{rotl}`                :math:`\hex{89}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`
:math:`\I64.\K{rotr}`                :math:`\hex{8A}`  :math:`[\I64~\I64] \to [\I64]`              :ref:`validation <valid-binop>`
:math:`\F32.\K{abs}`                 :math:`\hex{8B}`  :math:`[\F32] \to [\F32]`                   :ref:`validation <valid-unop>`
:math:`\F32.\K{neg}`                 :math:`\hex{8C}`  :math:`[\F32] \to [\F32]`                   :ref:`validation <valid-unop>`
:math:`\F32.\K{ceil}`                :math:`\hex{8D}`  :math:`[\F32] \to [\F32]`                   :ref:`validation <valid-unop>`
:math:`\F32.\K{floor}`               :math:`\hex{8E}`  :math:`[\F32] \to [\F32]`                   :ref:`validation <valid-unop>`
:math:`\F32.\K{trunc}`               :math:`\hex{8F}`  :math:`[\F32] \to [\F32]`                   :ref:`validation <valid-unop>`
:math:`\F32.\K{nearest}`             :math:`\hex{90}`  :math:`[\F32] \to [\F32]`                   :ref:`validation <valid-unop>`
:math:`\F32.\K{sqrt}`                :math:`\hex{91}`  :math:`[\F32] \to [\F32]`                   :ref:`validation <valid-unop>`
:math:`\F32.\K{add}`                 :math:`\hex{92}`  :math:`[\F32~\F32] \to [\F32]`              :ref:`validation <valid-binop>`
:math:`\F32.\K{sub}`                 :math:`\hex{93}`  :math:`[\F32~\F32] \to [\F32]`              :ref:`validation <valid-binop>`
:math:`\F32.\K{mul}`                 :math:`\hex{94}`  :math:`[\F32~\F32] \to [\F32]`              :ref:`validation <valid-binop>`
:math:`\F32.\K{div}`                 :math:`\hex{95}`  :math:`[\F32~\F32] \to [\F32]`              :ref:`validation <valid-binop>`
:math:`\F32.\K{min}`                 :math:`\hex{96}`  :math:`[\F32~\F32] \to [\F32]`              :ref:`validation <valid-binop>`
:math:`\F32.\K{max}`                 :math:`\hex{97}`  :math:`[\F32~\F32] \to [\F32]`              :ref:`validation <valid-binop>`
:math:`\F32.\K{copysign}`            :math:`\hex{98}`  :math:`[\F32~\F32] \to [\F32]`              :ref:`validation <valid-binop>`
:math:`\F64.\K{abs}`                 :math:`\hex{99}`  :math:`[\F64] \to [\F64]`                   :ref:`validation <valid-unop>`
:math:`\F64.\K{neg}`                 :math:`\hex{9A}`  :math:`[\F64] \to [\F64]`                   :ref:`validation <valid-unop>`
:math:`\F64.\K{ceil}`                :math:`\hex{9B}`  :math:`[\F64] \to [\F64]`                   :ref:`validation <valid-unop>`
:math:`\F64.\K{floor}`               :math:`\hex{9C}`  :math:`[\F64] \to [\F64]`                   :ref:`validation <valid-unop>`
:math:`\F64.\K{trunc}`               :math:`\hex{9D}`  :math:`[\F64] \to [\F64]`                   :ref:`validation <valid-unop>`
:math:`\F64.\K{nearest}`             :math:`\hex{9E}`  :math:`[\F64] \to [\F64]`                   :ref:`validation <valid-unop>`
:math:`\F64.\K{sqrt}`                :math:`\hex{9F}`  :math:`[\F64] \to [\F64]`                   :ref:`validation <valid-unop>`
:math:`\F64.\K{add}`                 :math:`\hex{A0}`  :math:`[\F64~\F64] \to [\F64]`              :ref:`validation <valid-binop>`
:math:`\F64.\K{sub}`                 :math:`\hex{A1}`  :math:`[\F64~\F64] \to [\F64]`              :ref:`validation <valid-binop>`
:math:`\F64.\K{mul}`                 :math:`\hex{A2}`  :math:`[\F64~\F64] \to [\F64]`              :ref:`validation <valid-binop>`
:math:`\F64.\K{div}`                 :math:`\hex{A3}`  :math:`[\F64~\F64] \to [\F64]`              :ref:`validation <valid-binop>`
:math:`\F64.\K{min}`                 :math:`\hex{A4}`  :math:`[\F64~\F64] \to [\F64]`              :ref:`validation <valid-binop>`
:math:`\F64.\K{max}`                 :math:`\hex{A5}`  :math:`[\F64~\F64] \to [\F64]`              :ref:`validation <valid-binop>`
:math:`\F64.\K{copysign}`            :math:`\hex{A6}`  :math:`[\F64~\F64] \to [\F64]`              :ref:`validation <valid-binop>`
:math:`\I32.\K{wrap/i64}`            :math:`\hex{A7}`  :math:`[\I64] \to [\I32]`                   :ref:`validation <valid-cvtop>`
:math:`\I32.\K{trunc\_s/f32}`        :math:`\hex{A8}`  :math:`[\F32] \to [\I32]`                   :ref:`validation <valid-cvtop>`
:math:`\I32.\K{trunc\_u/f32}`        :math:`\hex{A9}`  :math:`[\F32] \to [\I32]`                   :ref:`validation <valid-cvtop>`
:math:`\I32.\K{trunc\_s/f64}`        :math:`\hex{AA}`  :math:`[\F64] \to [\I32]`                   :ref:`validation <valid-cvtop>`
:math:`\I32.\K{trunc\_u/f64}`        :math:`\hex{AB}`  :math:`[\F64] \to [\I32]`                   :ref:`validation <valid-cvtop>`
:math:`\I64.\K{extend\_s/i32}`       :math:`\hex{AC}`  :math:`[\I32] \to [\I64]`                   :ref:`validation <valid-cvtop>`
:math:`\I64.\K{extend\_u/i32}`       :math:`\hex{AD}`  :math:`[\I32] \to [\I64]`                   :ref:`validation <valid-cvtop>`
:math:`\I64.\K{trunc\_s/f32}`        :math:`\hex{AE}`  :math:`[\F32] \to [\I64]`                   :ref:`validation <valid-cvtop>`
:math:`\I64.\K{trunc\_u/f32}`        :math:`\hex{AF}`  :math:`[\F32] \to [\I64]`                   :ref:`validation <valid-cvtop>`
:math:`\I64.\K{trunc\_s/f64}`        :math:`\hex{B0}`  :math:`[\F64] \to [\I64]`                   :ref:`validation <valid-cvtop>`
:math:`\I64.\K{trunc\_u/f64}`        :math:`\hex{B1}`  :math:`[\F64] \to [\I64]`                   :ref:`validation <valid-cvtop>`
:math:`\F32.\K{convert\_s/i32}`      :math:`\hex{B2}`  :math:`[\I32] \to [\F32]`                   :ref:`validation <valid-cvtop>`
:math:`\F32.\K{convert\_u/i32}`      :math:`\hex{B3}`  :math:`[\I32] \to [\F32]`                   :ref:`validation <valid-cvtop>`
:math:`\F32.\K{convert\_s/i64}`      :math:`\hex{B4}`  :math:`[\I64] \to [\F32]`                   :ref:`validation <valid-cvtop>`
:math:`\F32.\K{convert\_u/i64}`      :math:`\hex{B5}`  :math:`[\I64] \to [\F32]`                   :ref:`validation <valid-cvtop>`
:math:`\F32.\K{demote/f64}`          :math:`\hex{B6}`  :math:`[\F64] \to [\F32]`                   :ref:`validation <valid-cvtop>`
:math:`\F64.\K{convert\_s/i32}`      :math:`\hex{B7}`  :math:`[\I32] \to [\F64]`                   :ref:`validation <valid-cvtop>`
:math:`\F64.\K{convert\_u/i32}`      :math:`\hex{B8}`  :math:`[\I32] \to [\F64]`                   :ref:`validation <valid-cvtop>`
:math:`\F64.\K{convert\_s/i64}`      :math:`\hex{B9}`  :math:`[\I64] \to [\F64]`                   :ref:`validation <valid-cvtop>`
:math:`\F64.\K{convert\_u/i64}`      :math:`\hex{BA}`  :math:`[\I64] \to [\F64]`                   :ref:`validation <valid-cvtop>`
:math:`\F64.\K{promote/f32}`         :math:`\hex{BB}`  :math:`[\F32] \to [\F64]`                   :ref:`validation <valid-cvtop>`
:math:`\I32.\K{reinterpret/f32}`     :math:`\hex{BC}`  :math:`[\F32] \to [\I32]`                   :ref:`validation <valid-cvtop>`
:math:`\I64.\K{reinterpret/f64}`     :math:`\hex{BD}`  :math:`[\F64] \to [\I64]`                   :ref:`validation <valid-cvtop>`
:math:`\F32.\K{reinterpret/i32}`     :math:`\hex{BE}`  :math:`[\I32] \to [\F32]`                   :ref:`validation <valid-cvtop>`
:math:`\F64.\K{reinterpret/i64}`     :math:`\hex{BF}`  :math:`[\I64] \to [\F64]`                   :ref:`validation <valid-cvtop>`
===================================  ================  ==========================================  ========================================  ================

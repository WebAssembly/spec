.. index:: instruction, ! opcode
.. _binary-instr:

Instructions
------------

:ref:`Instructions <syntax-instr>` are encoded by *opcodes*.
Each opcode is represented by a single byte,
and is followed by the instruction's immediate arguments, where present.
The only exception are :ref:`structured control instructions <binary-instr-control>`, which consist of several opcodes bracketing their nested instruction sequences.

.. note::
   Gaps in the byte code ranges for encoding instructions are reserved for future extensions.


.. index:: control instructions, structured control, label, block, branch, result type, value type, block type, label index, function index, exception index, type index, vector, polymorphism, LEB128
   pair: binary format; instruction
   pair: binary format; block type
.. _binary-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

:ref:`Control instructions <syntax-instr-control>` have varying encodings. For structured instructions, the instruction sequences forming nested blocks are terminated with explicit opcodes for |END|, |ELSE|, and |CATCH|.

:ref:`Block types <syntax-blocktype>` are encoded in special compressed form, by either the byte :math:`\hex{40}` indicating the empty type, as a single :ref:`value type <binary-valtype>`, or as a :ref:`type index <binary-typeidx>` encoded as a positive :ref:`signed integer <binary-sint>`.

.. _binary-blocktype:
.. _binary-nop:
.. _binary-unreachable:
.. _binary-block:
.. _binary-loop:
.. _binary-if:
.. _binary-try:
.. _binary-throw:
.. _binary-rethrow:
.. _binary-br_on_exn:
.. _binary-br:
.. _binary-br_if:
.. _binary-br_table:
.. _binary-return:
.. _binary-call:
.. _binary-call_indirect:

.. math::
   \begin{array}{llcllll}
   \production{block type} & \Bblocktype &::=&
     \hex{40} &\Rightarrow& \epsilon \\ &&|&
     t{:}\Bvaltype &\Rightarrow& t \\ &&|&
     x{:}\Bs33 &\Rightarrow& x & (\iff x \geq 0) \\
   \production{instruction} & \Binstr &::=&
     \hex{00} &\Rightarrow& \UNREACHABLE \\ &&|&
     \hex{01} &\Rightarrow& \NOP \\ &&|&
     \hex{02}~~\X{bt}{:}\Bblocktype~~(\X{in}{:}\Binstr)^\ast~~\hex{0B}
       &\Rightarrow& \BLOCK~\X{bt}~\X{in}^\ast~\END \\ &&|&
     \hex{03}~~\X{bt}{:}\Bblocktype~~(\X{in}{:}\Binstr)^\ast~~\hex{0B}
       &\Rightarrow& \LOOP~\X{bt}~\X{in}^\ast~\END \\ &&|&
     \hex{04}~~\X{bt}{:}\Bblocktype~~(\X{in}{:}\Binstr)^\ast~~\hex{0B}
       &\Rightarrow& \IF~\X{bt}~\X{in}^\ast~\ELSE~\epsilon~\END \\ &&|&
     \hex{04}~~\X{bt}{:}\Bblocktype~~(\X{in}_1{:}\Binstr)^\ast~~
       \hex{05}~~(\X{in}_2{:}\Binstr)^\ast~~\hex{0B}
       &\Rightarrow& \IF~\X{bt}~\X{in}_1^\ast~\ELSE~\X{in}_2^\ast~\END \\ &&|&
     \hex{06}~~\X{bt}{:}\Bblocktype~~(\X{in}_1{:}\Binstr)^\ast~~
       \hex{07}~~(\X{in}_2{:}\Binstr)^\ast~~\hex{0B}
       &\Rightarrow& \TRY~\X{bt}~\X{in}_1^\ast~\CATCH~\X{in}_2^\ast~\END \\ &&|&
     \hex{08}~~x{:}\Bexnidx &\Rightarrow& \THROW~x \\ &&|&
     \hex{09} &\Rightarrow& \RETHROW \\ &&|&
     \hex{0A}~~l{:}\Blabelidx~~x{:}\Bexnidx &\Rightarrow& \BRONEXN~l~x \\ &&|&
     \hex{0C}~~l{:}\Blabelidx &\Rightarrow& \BR~l \\ &&|&
     \hex{0D}~~l{:}\Blabelidx &\Rightarrow& \BRIF~l \\ &&|&
     \hex{0E}~~l^\ast{:}\Bvec(\Blabelidx)~~l_N{:}\Blabelidx
       &\Rightarrow& \BRTABLE~l^\ast~l_N \\ &&|&
     \hex{0F} &\Rightarrow& \RETURN \\ &&|&
     \hex{10}~~x{:}\Bfuncidx &\Rightarrow& \CALL~x \\ &&|&
     \hex{11}~~y{:}\Btypeidx~~x{:}\Btableidx &\Rightarrow& \CALLINDIRECT~x~y \\
   \end{array}

.. note::
   The |ELSE| opcode :math:`\hex{05}` in the encoding of an |IF| instruction can be omitted if the following instruction sequence is empty.

   Unlike any :ref:`other occurrence <binary-typeidx>`, the :ref:`type index <syntax-typeidx>` in a :ref:`block type <syntax-blocktype>` is encoded as a positive :ref:`signed integer <syntax-sint>`, so that its |SignedLEB128| bit pattern cannot collide with the encoding of :ref:`value types <binary-valtype>` or the special code :math:`\hex{40}`, which correspond to the LEB128 encoding of negative integers.
   To avoid any loss in the range of allowed indices, it is treated as a 33 bit signed integer. 


.. index:: reference instruction
   pair: binary format; instruction
.. _binary-instr-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

:ref:`Reference instructions <syntax-instr-ref>` are represented by single byte codes.

.. _binary-ref.null:
.. _binary-ref.func:
.. _binary-ref.is_null:

.. math::
   \begin{array}{llclll}
   \production{instruction} & \Binstr &::=& \dots \\ &&|&
     \hex{D0}~~t{:}\Breftype &\Rightarrow& \REFNULL~t \\ &&|&
     \hex{D1} &\Rightarrow& \REFISNULL \\ &&|&
     \hex{D2}~~x{:}\Bfuncidx &\Rightarrow& \REFFUNC~x \\
   \end{array}


.. index:: parametric instruction, value type, polymorphism
   pair: binary format; instruction
.. _binary-instr-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

:ref:`Parametric instructions <syntax-instr-parametric>` are represented by single byte codes, possibly followed by a type annotation.

.. _binary-drop:
.. _binary-select:

.. math::
   \begin{array}{llclll}
   \production{instruction} & \Binstr &::=& \dots \\ &&|&
     \hex{1A} &\Rightarrow& \DROP \\ &&|&
     \hex{1B} &\Rightarrow& \SELECT \\ &&|&
     \hex{1C}~~t^\ast{:}\Bvec(\Bvaltype) &\Rightarrow& \SELECT~t^\ast \\
   \end{array}


.. index:: variable instructions, local index, global index
   pair: binary format; instruction
.. _binary-instr-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

:ref:`Variable instructions <syntax-instr-variable>` are represented by byte codes followed by the encoding of the respective :ref:`index <syntax-index>`.

.. _binary-local.get:
.. _binary-local.set:
.. _binary-local.tee:
.. _binary-global.get:
.. _binary-global.set:

.. math::
   \begin{array}{llclll}
   \production{instruction} & \Binstr &::=& \dots \\ &&|&
     \hex{20}~~x{:}\Blocalidx &\Rightarrow& \LOCALGET~x \\ &&|&
     \hex{21}~~x{:}\Blocalidx &\Rightarrow& \LOCALSET~x \\ &&|&
     \hex{22}~~x{:}\Blocalidx &\Rightarrow& \LOCALTEE~x \\ &&|&
     \hex{23}~~x{:}\Bglobalidx &\Rightarrow& \GLOBALGET~x \\ &&|&
     \hex{24}~~x{:}\Bglobalidx &\Rightarrow& \GLOBALSET~x \\
   \end{array}


.. index:: table instruction, table index
   pair: binary format; instruction
.. _binary-instr-table:
.. _binary-table.get:
.. _binary-table.set:
.. _binary-table.size:
.. _binary-table.grow:
.. _binary-table.fill:
.. _binary-table.copy:
.. _binary-table.init:
.. _binary-elem.drop:

Table Instructions
~~~~~~~~~~~~~~~~~~

:ref:`Table instructions <syntax-instr-table>` are represented either by a single byte or a one byte prefix followed by a variable-length :ref:`unsigned integer <binary-uint>`.

.. math::
   \begin{array}{llclll}
   \production{instruction} & \Binstr &::=& \dots \\ &&|&
     \hex{25}~~x{:}\Btableidx &\Rightarrow& \TABLEGET~x \\ &&|&
     \hex{26}~~x{:}\Btableidx &\Rightarrow& \TABLESET~x \\ &&|&
     \hex{FC}~~12{:}\Bu32~~y{:}\Belemidx~~x{:}\Btableidx &\Rightarrow& \TABLEINIT~x~y \\ &&|&
     \hex{FC}~~13{:}\Bu32~~x{:}\Belemidx &\Rightarrow& \ELEMDROP~x \\ &&|&
     \hex{FC}~~14{:}\Bu32~~x{:}\Btableidx~~y{:}\Btableidx &\Rightarrow& \TABLECOPY~x~y \\ &&|&
     \hex{FC}~~15{:}\Bu32~~x{:}\Btableidx &\Rightarrow& \TABLEGROW~x \\ &&|&
     \hex{FC}~~16{:}\Bu32~~x{:}\Btableidx &\Rightarrow& \TABLESIZE~x \\ &&|&
     \hex{FC}~~17{:}\Bu32~~x{:}\Btableidx &\Rightarrow& \TABLEFILL~x \\
   \end{array}


.. index:: memory instruction, memory index
   pair: binary format; instruction
.. _binary-instr-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

Each variant of :ref:`memory instruction <syntax-instr-memory>` is encoded with a different byte code. Loads and stores are followed by the encoding of their |memarg| immediate.

.. _binary-memarg:
.. _binary-load:
.. _binary-loadn:
.. _binary-store:
.. _binary-storen:
.. _binary-memory.size:
.. _binary-memory.grow:
.. _binary-memory.fill:
.. _binary-memory.copy:
.. _binary-memory.init:
.. _binary-data.drop:

.. math::
   \begin{array}{llclll}
   \production{memory argument} & \Bmemarg &::=&
     a{:}\Bu32~~o{:}\Bu32 &\Rightarrow& \{ \ALIGN~a,~\OFFSET~o \} \\
   \production{instruction} & \Binstr &::=& \dots \\ &&|&
     \hex{28}~~m{:}\Bmemarg &\Rightarrow& \I32.\LOAD~m \\ &&|&
     \hex{29}~~m{:}\Bmemarg &\Rightarrow& \I64.\LOAD~m \\ &&|&
     \hex{2A}~~m{:}\Bmemarg &\Rightarrow& \F32.\LOAD~m \\ &&|&
     \hex{2B}~~m{:}\Bmemarg &\Rightarrow& \F64.\LOAD~m \\ &&|&
     \hex{2C}~~m{:}\Bmemarg &\Rightarrow& \I32.\LOAD\K{8\_s}~m \\ &&|&
     \hex{2D}~~m{:}\Bmemarg &\Rightarrow& \I32.\LOAD\K{8\_u}~m \\ &&|&
     \hex{2E}~~m{:}\Bmemarg &\Rightarrow& \I32.\LOAD\K{16\_s}~m \\ &&|&
     \hex{2F}~~m{:}\Bmemarg &\Rightarrow& \I32.\LOAD\K{16\_u}~m \\ &&|&
     \hex{30}~~m{:}\Bmemarg &\Rightarrow& \I64.\LOAD\K{8\_s}~m \\ &&|&
     \hex{31}~~m{:}\Bmemarg &\Rightarrow& \I64.\LOAD\K{8\_u}~m \\ &&|&
     \hex{32}~~m{:}\Bmemarg &\Rightarrow& \I64.\LOAD\K{16\_s}~m \\ &&|&
     \hex{33}~~m{:}\Bmemarg &\Rightarrow& \I64.\LOAD\K{16\_u}~m \\ &&|&
     \hex{34}~~m{:}\Bmemarg &\Rightarrow& \I64.\LOAD\K{32\_s}~m \\ &&|&
     \hex{35}~~m{:}\Bmemarg &\Rightarrow& \I64.\LOAD\K{32\_u}~m \\ &&|&
     \hex{36}~~m{:}\Bmemarg &\Rightarrow& \I32.\STORE~m \\ &&|&
     \hex{37}~~m{:}\Bmemarg &\Rightarrow& \I64.\STORE~m \\ &&|&
     \hex{38}~~m{:}\Bmemarg &\Rightarrow& \F32.\STORE~m \\ &&|&
     \hex{39}~~m{:}\Bmemarg &\Rightarrow& \F64.\STORE~m \\ &&|&
     \hex{3A}~~m{:}\Bmemarg &\Rightarrow& \I32.\STORE\K{8}~m \\ &&|&
     \hex{3B}~~m{:}\Bmemarg &\Rightarrow& \I32.\STORE\K{16}~m \\ &&|&
     \hex{3C}~~m{:}\Bmemarg &\Rightarrow& \I64.\STORE\K{8}~m \\ &&|&
     \hex{3D}~~m{:}\Bmemarg &\Rightarrow& \I64.\STORE\K{16}~m \\ &&|&
     \hex{3E}~~m{:}\Bmemarg &\Rightarrow& \I64.\STORE\K{32}~m \\ &&|&
     \hex{3F}~~\hex{00} &\Rightarrow& \MEMORYSIZE \\ &&|&
     \hex{40}~~\hex{00} &\Rightarrow& \MEMORYGROW \\ &&|&
     \hex{FC}~~8{:}\Bu32~~x{:}\Bdataidx~\hex{00} &\Rightarrow& \MEMORYINIT~x \\ &&|&
     \hex{FC}~~9{:}\Bu32~~x{:}\Bdataidx &\Rightarrow& \DATADROP~x \\ &&|&
     \hex{FC}~~10{:}\Bu32~~\hex{00}~~\hex{00} &\Rightarrow& \MEMORYCOPY \\ &&|&
     \hex{FC}~~11{:}\Bu32~~\hex{00} &\Rightarrow& \MEMORYFILL \\
   \end{array}

.. note::
   In future versions of WebAssembly, the additional zero bytes occurring in the encoding of the |MEMORYSIZE|, |MEMORYGROW|, |MEMORYCOPY|, and |MEMORYFILL| instructions may be used to index additional memories.


.. index:: numeric instruction
   pair: binary format; instruction
.. _binary-instr-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

All variants of :ref:`numeric instructions <syntax-instr-numeric>` are represented by separate byte codes.

The |CONST| instructions are followed by the respective literal.

.. _binary-const:

.. math::
   \begin{array}{llclll}
   \production{instruction} & \Binstr &::=& \dots \\&&|&
     \hex{41}~~n{:}\Bi32 &\Rightarrow& \I32.\CONST~n \\ &&|&
     \hex{42}~~n{:}\Bi64 &\Rightarrow& \I64.\CONST~n \\ &&|&
     \hex{43}~~z{:}\Bf32 &\Rightarrow& \F32.\CONST~z \\ &&|&
     \hex{44}~~z{:}\Bf64 &\Rightarrow& \F64.\CONST~z \\
   \end{array}

All other numeric instructions are plain opcodes without any immediates.

.. _binary-testop:
.. _binary-relop:

.. math::
   \begin{array}{llclll}
   \production{instruction} & \Binstr &::=& \dots && \phantom{thisshouldbeenough} \\&&|&
     \hex{45} &\Rightarrow& \I32.\EQZ \\ &&|&
     \hex{46} &\Rightarrow& \I32.\EQ \\ &&|&
     \hex{47} &\Rightarrow& \I32.\NE \\ &&|&
     \hex{48} &\Rightarrow& \I32.\LT\K{\_s} \\ &&|&
     \hex{49} &\Rightarrow& \I32.\LT\K{\_u} \\ &&|&
     \hex{4A} &\Rightarrow& \I32.\GT\K{\_s} \\ &&|&
     \hex{4B} &\Rightarrow& \I32.\GT\K{\_u} \\ &&|&
     \hex{4C} &\Rightarrow& \I32.\LE\K{\_s} \\ &&|&
     \hex{4D} &\Rightarrow& \I32.\LE\K{\_u} \\ &&|&
     \hex{4E} &\Rightarrow& \I32.\GE\K{\_s} \\ &&|&
     \hex{4F} &\Rightarrow& \I32.\GE\K{\_u} \\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Binstr} &\phantom{::=}& \phantom{\dots} && \phantom{thisshouldbeenough} \\[-2ex] &&|&
     \hex{50} &\Rightarrow& \I64.\EQZ \\ &&|&
     \hex{51} &\Rightarrow& \I64.\EQ \\ &&|&
     \hex{52} &\Rightarrow& \I64.\NE \\ &&|&
     \hex{53} &\Rightarrow& \I64.\LT\K{\_s} \\ &&|&
     \hex{54} &\Rightarrow& \I64.\LT\K{\_u} \\ &&|&
     \hex{55} &\Rightarrow& \I64.\GT\K{\_s} \\ &&|&
     \hex{56} &\Rightarrow& \I64.\GT\K{\_u} \\ &&|&
     \hex{57} &\Rightarrow& \I64.\LE\K{\_s} \\ &&|&
     \hex{58} &\Rightarrow& \I64.\LE\K{\_u} \\ &&|&
     \hex{59} &\Rightarrow& \I64.\GE\K{\_s} \\ &&|&
     \hex{5A} &\Rightarrow& \I64.\GE\K{\_u} \\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Binstr} &\phantom{::=}& \phantom{\dots} && \phantom{thisshouldbeenough} \\[-2ex] &&|&
     \hex{5B} &\Rightarrow& \F32.\EQ \\ &&|&
     \hex{5C} &\Rightarrow& \F32.\NE \\ &&|&
     \hex{5D} &\Rightarrow& \F32.\LT \\ &&|&
     \hex{5E} &\Rightarrow& \F32.\GT \\ &&|&
     \hex{5F} &\Rightarrow& \F32.\LE \\ &&|&
     \hex{60} &\Rightarrow& \F32.\GE \\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Binstr} &\phantom{::=}& \phantom{\dots} && \phantom{thisshouldbeenough} \\[-2ex] &&|&
     \hex{61} &\Rightarrow& \F64.\EQ \\ &&|&
     \hex{62} &\Rightarrow& \F64.\NE \\ &&|&
     \hex{63} &\Rightarrow& \F64.\LT \\ &&|&
     \hex{64} &\Rightarrow& \F64.\GT \\ &&|&
     \hex{65} &\Rightarrow& \F64.\LE \\ &&|&
     \hex{66} &\Rightarrow& \F64.\GE \\
   \end{array}

.. _binary-unop:
.. _binary-binop:

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Binstr} &\phantom{::=}& \phantom{\dots} && \phantom{thisshouldbeenough} \\[-2ex] &&|&
     \hex{67} &\Rightarrow& \I32.\CLZ \\ &&|&
     \hex{68} &\Rightarrow& \I32.\CTZ \\ &&|&
     \hex{69} &\Rightarrow& \I32.\POPCNT \\ &&|&
     \hex{6A} &\Rightarrow& \I32.\ADD \\ &&|&
     \hex{6B} &\Rightarrow& \I32.\SUB \\ &&|&
     \hex{6C} &\Rightarrow& \I32.\MUL \\ &&|&
     \hex{6D} &\Rightarrow& \I32.\DIV\K{\_s} \\ &&|&
     \hex{6E} &\Rightarrow& \I32.\DIV\K{\_u} \\ &&|&
     \hex{6F} &\Rightarrow& \I32.\REM\K{\_s} \\ &&|&
     \hex{70} &\Rightarrow& \I32.\REM\K{\_u} \\ &&|&
     \hex{71} &\Rightarrow& \I32.\AND \\ &&|&
     \hex{72} &\Rightarrow& \I32.\OR \\ &&|&
     \hex{73} &\Rightarrow& \I32.\XOR \\ &&|&
     \hex{74} &\Rightarrow& \I32.\SHL \\ &&|&
     \hex{75} &\Rightarrow& \I32.\SHR\K{\_s} \\ &&|&
     \hex{76} &\Rightarrow& \I32.\SHR\K{\_u} \\ &&|&
     \hex{77} &\Rightarrow& \I32.\ROTL \\ &&|&
     \hex{78} &\Rightarrow& \I32.\ROTR \\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Binstr} &\phantom{::=}& \phantom{\dots} && \phantom{thisshouldbeenough} \\[-2ex] &&|&
     \hex{79} &\Rightarrow& \I64.\CLZ \\ &&|&
     \hex{7A} &\Rightarrow& \I64.\CTZ \\ &&|&
     \hex{7B} &\Rightarrow& \I64.\POPCNT \\ &&|&
     \hex{7C} &\Rightarrow& \I64.\ADD \\ &&|&
     \hex{7D} &\Rightarrow& \I64.\SUB \\ &&|&
     \hex{7E} &\Rightarrow& \I64.\MUL \\ &&|&
     \hex{7F} &\Rightarrow& \I64.\DIV\K{\_s} \\ &&|&
     \hex{80} &\Rightarrow& \I64.\DIV\K{\_u} \\ &&|&
     \hex{81} &\Rightarrow& \I64.\REM\K{\_s} \\ &&|&
     \hex{82} &\Rightarrow& \I64.\REM\K{\_u} \\ &&|&
     \hex{83} &\Rightarrow& \I64.\AND \\ &&|&
     \hex{84} &\Rightarrow& \I64.\OR \\ &&|&
     \hex{85} &\Rightarrow& \I64.\XOR \\ &&|&
     \hex{86} &\Rightarrow& \I64.\SHL \\ &&|&
     \hex{87} &\Rightarrow& \I64.\SHR\K{\_s} \\ &&|&
     \hex{88} &\Rightarrow& \I64.\SHR\K{\_u} \\ &&|&
     \hex{89} &\Rightarrow& \I64.\ROTL \\ &&|&
     \hex{8A} &\Rightarrow& \I64.\ROTR \\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Binstr} &\phantom{::=}& \phantom{\dots} && \phantom{thisshouldbeenough} \\[-2ex] &&|&
     \hex{8B} &\Rightarrow& \F32.\ABS \\ &&|&
     \hex{8C} &\Rightarrow& \F32.\NEG \\ &&|&
     \hex{8D} &\Rightarrow& \F32.\CEIL \\ &&|&
     \hex{8E} &\Rightarrow& \F32.\FLOOR \\ &&|&
     \hex{8F} &\Rightarrow& \F32.\TRUNC \\ &&|&
     \hex{90} &\Rightarrow& \F32.\NEAREST \\ &&|&
     \hex{91} &\Rightarrow& \F32.\SQRT \\ &&|&
     \hex{92} &\Rightarrow& \F32.\ADD \\ &&|&
     \hex{93} &\Rightarrow& \F32.\SUB \\ &&|&
     \hex{94} &\Rightarrow& \F32.\MUL \\ &&|&
     \hex{95} &\Rightarrow& \F32.\DIV \\ &&|&
     \hex{96} &\Rightarrow& \F32.\FMIN \\ &&|&
     \hex{97} &\Rightarrow& \F32.\FMAX \\ &&|&
     \hex{98} &\Rightarrow& \F32.\COPYSIGN \\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Binstr} &\phantom{::=}& \phantom{\dots} && \phantom{thisshouldbeenough} \\[-2ex] &&|&
     \hex{99} &\Rightarrow& \F64.\ABS \\ &&|&
     \hex{9A} &\Rightarrow& \F64.\NEG \\ &&|&
     \hex{9B} &\Rightarrow& \F64.\CEIL \\ &&|&
     \hex{9C} &\Rightarrow& \F64.\FLOOR \\ &&|&
     \hex{9D} &\Rightarrow& \F64.\TRUNC \\ &&|&
     \hex{9E} &\Rightarrow& \F64.\NEAREST \\ &&|&
     \hex{9F} &\Rightarrow& \F64.\SQRT \\ &&|&
     \hex{A0} &\Rightarrow& \F64.\ADD \\ &&|&
     \hex{A1} &\Rightarrow& \F64.\SUB \\ &&|&
     \hex{A2} &\Rightarrow& \F64.\MUL \\ &&|&
     \hex{A3} &\Rightarrow& \F64.\DIV \\ &&|&
     \hex{A4} &\Rightarrow& \F64.\FMIN \\ &&|&
     \hex{A5} &\Rightarrow& \F64.\FMAX \\ &&|&
     \hex{A6} &\Rightarrow& \F64.\COPYSIGN \\
   \end{array}

.. _binary-cvtop:

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Binstr} &\phantom{::=}& \phantom{\dots} && \phantom{thisshouldbeenough} \\[-2ex] &&|&
     \hex{A7} &\Rightarrow& \I32.\WRAP\K{\_}\I64 \\ &&|&
     \hex{A8} &\Rightarrow& \I32.\TRUNC\K{\_}\F32\K{\_s} \\ &&|&
     \hex{A9} &\Rightarrow& \I32.\TRUNC\K{\_}\F32\K{\_u} \\ &&|&
     \hex{AA} &\Rightarrow& \I32.\TRUNC\K{\_}\F64\K{\_s} \\ &&|&
     \hex{AB} &\Rightarrow& \I32.\TRUNC\K{\_}\F64\K{\_u} \\ &&|&
     \hex{AC} &\Rightarrow& \I64.\EXTEND\K{\_}\I32\K{\_s} \\ &&|&
     \hex{AD} &\Rightarrow& \I64.\EXTEND\K{\_}\I32\K{\_u} \\ &&|&
     \hex{AE} &\Rightarrow& \I64.\TRUNC\K{\_}\F32\K{\_s} \\ &&|&
     \hex{AF} &\Rightarrow& \I64.\TRUNC\K{\_}\F32\K{\_u} \\ &&|&
     \hex{B0} &\Rightarrow& \I64.\TRUNC\K{\_}\F64\K{\_s} \\ &&|&
     \hex{B1} &\Rightarrow& \I64.\TRUNC\K{\_}\F64\K{\_u} \\ &&|&
     \hex{B2} &\Rightarrow& \F32.\CONVERT\K{\_}\I32\K{\_s} \\ &&|&
     \hex{B3} &\Rightarrow& \F32.\CONVERT\K{\_}\I32\K{\_u} \\ &&|&
     \hex{B4} &\Rightarrow& \F32.\CONVERT\K{\_}\I64\K{\_s} \\ &&|&
     \hex{B5} &\Rightarrow& \F32.\CONVERT\K{\_}\I64\K{\_u} \\ &&|&
     \hex{B6} &\Rightarrow& \F32.\DEMOTE\K{\_}\F64 \\ &&|&
     \hex{B7} &\Rightarrow& \F64.\CONVERT\K{\_}\I32\K{\_s} \\ &&|&
     \hex{B8} &\Rightarrow& \F64.\CONVERT\K{\_}\I32\K{\_u} \\ &&|&
     \hex{B9} &\Rightarrow& \F64.\CONVERT\K{\_}\I64\K{\_s} \\ &&|&
     \hex{BA} &\Rightarrow& \F64.\CONVERT\K{\_}\I64\K{\_u} \\ &&|&
     \hex{BB} &\Rightarrow& \F64.\PROMOTE\K{\_}\F32 \\ &&|&
     \hex{BC} &\Rightarrow& \I32.\REINTERPRET\K{\_}\F32 \\ &&|&
     \hex{BD} &\Rightarrow& \I64.\REINTERPRET\K{\_}\F64 \\ &&|&
     \hex{BE} &\Rightarrow& \F32.\REINTERPRET\K{\_}\I32 \\ &&|&
     \hex{BF} &\Rightarrow& \F64.\REINTERPRET\K{\_}\I64 \\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Binstr} &\phantom{::=}& \phantom{\dots} && \phantom{thisshouldbeenough} \\[-2ex] &&|&
     \hex{C0} &\Rightarrow& \I32.\EXTEND\K{8\_s} \\ &&|&
     \hex{C1} &\Rightarrow& \I32.\EXTEND\K{16\_s} \\ &&|&
     \hex{C2} &\Rightarrow& \I64.\EXTEND\K{8\_s} \\ &&|&
     \hex{C3} &\Rightarrow& \I64.\EXTEND\K{16\_s} \\ &&|&
     \hex{C4} &\Rightarrow& \I64.\EXTEND\K{32\_s} \\
   \end{array}

.. _binary-cvtop-trunc-sat:

The saturating truncation instructions all have a one byte prefix,
whereas the actual opcode is encoded by a variable-length :ref:`unsigned integer <binary-uint>`.

.. math::
   \begin{array}{llclll}
   \production{instruction} & \Binstr &::=& \dots && \phantom{thisshouldbeenough} \\&&|&
     \hex{FC}~~0{:}\Bu32 &\Rightarrow& \I32.\TRUNC\K{\_sat\_}\F32\K{\_s} \\ &&|&
     \hex{FC}~~1{:}\Bu32 &\Rightarrow& \I32.\TRUNC\K{\_sat\_}\F32\K{\_u} \\ &&|&
     \hex{FC}~~2{:}\Bu32 &\Rightarrow& \I32.\TRUNC\K{\_sat\_}\F64\K{\_s} \\ &&|&
     \hex{FC}~~3{:}\Bu32 &\Rightarrow& \I32.\TRUNC\K{\_sat\_}\F64\K{\_u} \\ &&|&
     \hex{FC}~~4{:}\Bu32 &\Rightarrow& \I64.\TRUNC\K{\_sat\_}\F32\K{\_s} \\ &&|&
     \hex{FC}~~5{:}\Bu32 &\Rightarrow& \I64.\TRUNC\K{\_sat\_}\F32\K{\_u} \\ &&|&
     \hex{FC}~~6{:}\Bu32 &\Rightarrow& \I64.\TRUNC\K{\_sat\_}\F64\K{\_s} \\ &&|&
     \hex{FC}~~7{:}\Bu32 &\Rightarrow& \I64.\TRUNC\K{\_sat\_}\F64\K{\_u} \\
   \end{array}


.. index:: expression
   pair: binary format; expression
   single: expression; constant
.. _binary-expr:

Expressions
~~~~~~~~~~~

:ref:`Expressions <syntax-expr>` are encoded by their instruction sequence terminated with an explicit :math:`\hex{0B}` opcode for |END|.

.. math::
   \begin{array}{llclll}
   \production{expression} & \Bexpr &::=&
     (\X{in}{:}\Binstr)^\ast~~\hex{0B} &\Rightarrow& \X{in}^\ast~\END \\
   \end{array}

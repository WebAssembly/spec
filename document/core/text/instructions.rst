.. index:: instruction
.. _text-instr:

Instructions
------------

Instructions are syntactically distinguished into *plain* and *structured* instructions.

.. math::
   \begin{array}{llclll}
   \production{instruction} & \Tinstr_I &::=&
     \X{in}{:}\Tplaininstr_I
       &\Rightarrow& \X{in} \\ &&|&
     \X{in}{:}\Tblockinstr_I
       &\Rightarrow& \X{in} \\
   \end{array}

In addition, as a syntactic abbreviation, instructions can be written as S-expressions in :ref:`folded <text-foldedinstr>` form, to group them visually.


.. index:: index, label index
   pair: text format; label index
.. _text-label:

Labels
~~~~~~

:ref:`Structured control instructions <text-instr-control>` can be annotated with a symbolic :ref:`label identifier <text-id>`.
They are the only :ref:`symbolic identifiers <text-index>` that can be bound locally in an instruction sequence.
The following grammar handles the corresponding update to the :ref:`identifier context <text-context>` by :ref:`composing <notation-compose>` the context with an additional label entry.

.. math::
   \begin{array}{llcllll}
   \production{label} & \Tlabel_I &::=&
     v{:}\Tid &\Rightarrow& \{\ILABELS~v\} \compose I
       & (\iff v \notin I.\ILABELS) \\ &&|&
     \epsilon &\Rightarrow& \{\ILABELS~(\epsilon)\} \compose I \\
   \end{array}

.. note::
   The new label entry is inserted at the *beginning* of the label list in the identifier context.
   This effectively shifts all existing labels up by one,
   mirroring the fact that control instructions are indexed relatively not absolutely.


.. index:: control instructions, structured control, label, block, branch, result type, label index, function index, type index, vector, polymorphism, exception index, exception instructions
   pair: text format; instruction
.. _text-blockinstr:
.. _text-plaininstr:
.. _text-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _text-blocktype:
.. _text-block:
.. _text-loop:
.. _text-if:
.. _text-instr-block:
.. _text-try:

:ref:`Structured control instructions <syntax-instr-control>` can bind an optional symbolic :ref:`label identifier <text-label>`.
The same label identifier may optionally be repeated after the corresponding :math:`\T{end}`, :math:`\T{else}`, and :math:`\T{catch}`
pseudo instructions, to indicate the matching delimiters.

Their :ref:`block type <syntax-blocktype>` is given as a :ref:`type use <text-typeuse>`, analogous to the type of :ref:`functions <text-func>`.
However, the special case of a type use that is syntactically empty or consists of only a single :ref:`result <text-result>` is not regarded as an :ref:`abbreviation <text-typeuse-abbrev>` for an inline :ref:`function type <syntax-functype>`, but is parsed directly into an optional :ref:`value type <syntax-valtype>`.

.. math::
   \begin{array}{llclll}
   \production{block type} & \Tblocktype_I &
   \begin{array}[t]{@{}c@{}} ::= \\ | \\ \end{array}
   &
   \begin{array}[t]{@{}lcll@{}}
     (t{:}\Tresult)^? &\Rightarrow& t^? \\
     x,I'{:}\Ttypeuse_I &\Rightarrow& x & (\iff I' = \{\ILOCALS~(\epsilon)^\ast\}) \\
   \end{array} \\
   \production{block instruction} & \Tblockinstr_I &::=&
     \text{block}~~I'{:}\Tlabel_I~~\X{bt}{:}\Tblocktype_I~~(\X{in}{:}\Tinstr_{I'})^\ast~~\text{end}~~\Tid^?
       \\ &&&\qquad \Rightarrow\quad \BLOCK~\X{bt}~\X{in}^\ast~\END
       \qquad\quad~~ (\iff \Tid^? = \epsilon \vee \Tid^? = \Tlabel) \\ &&|&
     \text{loop}~~I'{:}\Tlabel_I~~\X{bt}{:}\Tblocktype_I~~(\X{in}{:}\Tinstr_{I'})^\ast~~\text{end}~~\Tid^?
       \\ &&&\qquad \Rightarrow\quad \LOOP~\X{bt}~\X{in}^\ast~\END
       \qquad\qquad (\iff \Tid^? = \epsilon \vee \Tid^? = \Tlabel) \\ &&|&
     \text{if}~~I'{:}\Tlabel_I~~\X{bt}{:}\Tblocktype_I~~(\X{in}_1{:}\Tinstr_{I'})^\ast~~
       \text{else}~~\Tid_1^?~~(\X{in}_2{:}\Tinstr_{I'})^\ast~~\text{end}~~\Tid_2^?
       \\ &&&\qquad \Rightarrow\quad \IF~\X{bt}~\X{in}_1^\ast~\ELSE~\X{in}_2^\ast~\END
       \qquad (\iff \Tid_1^? = \epsilon \vee \Tid_1^? = \Tlabel, \Tid_2^? = \epsilon \vee \Tid_2^? = \Tlabel) \\ &&|&
    \text{try}~~I'{:}\Tlabel_I~~\X{bt}{:}\Tblocktype~~(\X{in}_1{:}\Tinstr_{I'})^\ast~~
       \text{catch}~~\Tid_1^?~~(\X{in}_2{:}\Tinstr_{I'})^\ast~~\text{end}~~\Tid_2^?
       \\ &&&\qquad \Rightarrow\quad \TRY~\X{rt}~\X{in}_1^\ast~\CATCH~\X{in}_2^\ast~\END
       \quad (\iff \Tid_1^? = \epsilon \vee \Tid_1^? = \Tlabel, \Tid_2^? = \epsilon \vee \Tid_2^? = \Tlabel) \\
   \end{array}

.. note::
   The side condition stating that the :ref:`identifier context <text-context>` :math:`I'` must only contain unnamed entries in the rule for |Ttypeuse| block types enforces that no identifier can be bound in any |Tparam| declaration for a block type.


.. _text-nop:
.. _text-unreachable:
.. _text-throw:
.. _text-rethrow:
.. _text-br_on_exn:
.. _text-br:
.. _text-br_if:
.. _text-br_table:
.. _text-return:
.. _text-call:
.. _text-call_indirect:

All other control instruction are represented verbatim.

.. math::
   \begin{array}{llcllll}
   \production{plain instruction} & \Tplaininstr_I &::=&
     \text{unreachable} &\Rightarrow& \UNREACHABLE \\ &&|&
     \text{nop} &\Rightarrow& \NOP \\ &&|&
     \text{throw}~~\text{(}\text{exception}~x{:}\Texnidx_I\text{)} &\Rightarrow& \THROW~x \\ &&|&
     \text{rethrow} &\Rightarrow& \RETHROW \\ &&|&
     \text{br\_on\_exn}~~l{:}\Tlabelidx_I~~\text{(}\text{exception}~x{:}\Texnidx_I~\text{)} &\Rightarrow& \BRONEXN~l~x \\ &&|&
     \text{br}~~l{:}\Tlabelidx_I &\Rightarrow& \BR~l \\ &&|&
     \text{br\_if}~~l{:}\Tlabelidx_I &\Rightarrow& \BRIF~l \\ &&|&
     \text{br\_table}~~l^\ast{:}\Tvec(\Tlabelidx_I)~~l_N{:}\Tlabelidx_I
       &\Rightarrow& \BRTABLE~l^\ast~l_N \\ &&|&
     \text{return} &\Rightarrow& \RETURN \\ &&|&
     \text{call}~~x{:}\Tfuncidx_I &\Rightarrow& \CALL~x \\ &&|&
     \text{call\_indirect}~~x{:}\Ttableidx~~y,I'{:}\Ttypeuse_I &\Rightarrow& \CALLINDIRECT~x~y
       & (\iff I' = \{\ILOCALS~(\epsilon)^\ast\}) \\
   \end{array}

.. note::
   The side condition stating that the :ref:`identifier context <text-context>` :math:`I'` must only contain unnamed entries in the rule for |CALLINDIRECT| enforces that no identifier can be bound in any |Tparam| declaration appearing in the type annotation.


Abbreviations
.............

The :math:`\text{else}` keyword of an :math:`\text{if}` instruction can be omitted if the following instruction sequence is empty.

.. math::
   \begin{array}{llclll}
   \production{block instruction} &
     \text{if}~~\Tlabel~~\Tblocktype~~\Tinstr^\ast~~\text{end}
       &\equiv&
     \text{if}~~\Tlabel~~\Tblocktype~~\Tinstr^\ast~~\text{else}~~\text{end}
   \end{array}

Also, for backwards compatibility, the table index to :math:`\text{call\_indirect}` can be omitted, defaulting to :math:`0`.

.. math::
   \begin{array}{llclll}
   \production{plain instruction} &
     \text{call\_indirect}~~\Ttypeuse
       &\equiv&
     \text{call\_indirect}~~0~~\Ttypeuse
   \end{array}


.. index:: reference instruction
   pair: text format; instruction
.. _text-instr-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _text-ref.null:
.. _text-ref.is_null:
.. _text-ref.func:

.. math::
   \begin{array}{llclll}
   \production{instruction} & \Tplaininstr_I &::=& \dots \\ &&|&
     \text{ref.null}~~t{:}\Theaptype &\Rightarrow& \REFNULL~t \\ &&|&
     \text{ref.is\_null} &\Rightarrow& \REFISNULL \\ &&|&
     \text{ref.func}~~x{:}\Tfuncidx &\Rightarrow& \REFFUNC~x \\ &&|&
   \end{array}


.. index:: parametric instruction, value type, polymorphism
   pair: text format; instruction
.. _text-instr-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _text-drop:
.. _text-select:

.. math::
   \begin{array}{llclll}
   \production{instruction} & \Tplaininstr_I &::=& \dots \\ &&|&
     \text{drop} &\Rightarrow& \DROP \\ &&|&
     \text{select}~((t{:}\Tresult)^\ast)^? &\Rightarrow& \SELECT~(t^\ast)^? \\
   \end{array}


.. index:: variable instructions, local index, global index
   pair: text format; instruction
.. _text-instr-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _text-local.get:
.. _text-local.set:
.. _text-local.tee:
.. _text-global.get:
.. _text-global.set:

.. math::
   \begin{array}{llclll}
   \production{instruction} & \Tplaininstr_I &::=& \dots \\ &&|&
     \text{local.get}~~x{:}\Tlocalidx_I &\Rightarrow& \LOCALGET~x \\ &&|&
     \text{local.set}~~x{:}\Tlocalidx_I &\Rightarrow& \LOCALSET~x \\ &&|&
     \text{local.tee}~~x{:}\Tlocalidx_I &\Rightarrow& \LOCALTEE~x \\ &&|&
     \text{global.get}~~x{:}\Tglobalidx_I &\Rightarrow& \GLOBALGET~x \\ &&|&
     \text{global.set}~~x{:}\Tglobalidx_I &\Rightarrow& \GLOBALSET~x \\
   \end{array}


.. index:: table instruction, table index
   pair: text format; instruction
.. _text-instr-table:

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _text-table.get:
.. _text-table.set:
.. _text-table.size:
.. _text-table.grow:
.. _text-table.fill:
.. _text-table.copy:
.. _text-table.init:
.. _text-elem.drop:

.. math::
   \begin{array}{llclll}
   \production{instruction} & \Tplaininstr_I &::=& \dots \\ &&|&
     \text{table.get}~~x{:}\Ttableidx_I &\Rightarrow& \TABLEGET~x \\ &&|&
     \text{table.set}~~x{:}\Ttableidx_I &\Rightarrow& \TABLESET~x \\ &&|&
     \text{table.size}~~x{:}\Ttableidx_I &\Rightarrow& \TABLESIZE~x \\ &&|&
     \text{table.grow}~~x{:}\Ttableidx_I &\Rightarrow& \TABLEGROW~x \\ &&|&
     \text{table.fill}~~x{:}\Ttableidx_I &\Rightarrow& \TABLEFILL~x \\ &&|&
     \text{table.copy}~~x{:}\Ttableidx_I~~y{:}\Ttableidx_I &\Rightarrow& \TABLECOPY~x~y \\ &&|&
     \text{table.init}~~x{:}\Ttableidx_I~~y{:}\Telemidx_I &\Rightarrow& \TABLEINIT~x~y \\ &&|&
     \text{elem.drop}~~x{:}\Telemidx_I &\Rightarrow& \ELEMDROP~x \\
   \end{array}


Abbreviations
.............

For backwards compatibility, all :math:`table indices <syntax-tableidx>` may be omitted from table instructions, defaulting to :math:`0`.

.. math::
   \begin{array}{llclll}
   \production{instruction} &
     \text{table.get} &\equiv& \text{table.get}~~\text{0} \\ &&|&
     \text{table.set} &\equiv& \text{table.set}~~\text{0} \\ &&|&
     \text{table.size} &\equiv& \text{table.size}~~\text{0} \\ &&|&
     \text{table.grow} &\equiv& \text{table.grow}~~\text{0} \\ &&|&
     \text{table.fill} &\equiv& \text{table.fill}~~\text{0} \\ &&|&
     \text{table.copy} &\equiv& \text{table.copy}~~\text{0}~~\text{0} \\ &&|&
     \text{table.init}~~x{:}\Telemidx_I &\equiv& \text{table.init}~~\text{0}~~x{:}\Telemidx_I \\ &&|&
   \end{array}


.. index:: memory instruction, memory index
   pair: text format; instruction
.. _text-instr-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _text-memarg:
.. _text-load:
.. _text-loadn:
.. _text-store:
.. _text-storen:
.. _text-memory.size:
.. _text-memory.grow:
.. _text-memory.fill:
.. _text-memory.copy:
.. _text-memory.init:
.. _text-data.drop:

The offset and alignment immediates to memory instructions are optional.
The offset defaults to :math:`\T{0}`, the alignment to the storage size of the respective memory access, which is its *natural alignment*.
Lexically, an |Toffset| or |Talign| phrase is considered a single :ref:`keyword token <text-keyword>`, so no :ref:`white space <text-space>` is allowed around the :math:`\text{=}`.

.. math::
   \begin{array}{llcllll}
   \production{memory argument} & \Tmemarg_N &::=&
     o{:}\Toffset~~a{:}\Talign_N &\Rightarrow& \{ \ALIGN~n,~\OFFSET~o \} & (\iff a = 2^n) \\
   \production{memory offset} & \Toffset &::=&
     \text{offset{=}}o{:}\Tu32 &\Rightarrow& o \\ &&|&
     \epsilon &\Rightarrow& 0 \\
   \production{memory alignment} & \Talign_N &::=&
     \text{align{=}}a{:}\Tu32 &\Rightarrow& a \\ &&|&
     \epsilon &\Rightarrow& N \\
   \production{instruction} & \Tplaininstr_I &::=& \dots \\ &&|&
     \text{i32.load}~~m{:}\Tmemarg_4 &\Rightarrow& \I32.\LOAD~m \\ &&|&
     \text{i64.load}~~m{:}\Tmemarg_8 &\Rightarrow& \I64.\LOAD~m \\ &&|&
     \text{f32.load}~~m{:}\Tmemarg_4 &\Rightarrow& \F32.\LOAD~m \\ &&|&
     \text{f64.load}~~m{:}\Tmemarg_8 &\Rightarrow& \F64.\LOAD~m \\ &&|&
     \text{i32.load8\_s}~~m{:}\Tmemarg_1 &\Rightarrow& \I32.\LOAD\K{8\_s}~m \\ &&|&
     \text{i32.load8\_u}~~m{:}\Tmemarg_1 &\Rightarrow& \I32.\LOAD\K{8\_u}~m \\ &&|&
     \text{i32.load16\_s}~~m{:}\Tmemarg_2 &\Rightarrow& \I32.\LOAD\K{16\_s}~m \\ &&|&
     \text{i32.load16\_u}~~m{:}\Tmemarg_2 &\Rightarrow& \I32.\LOAD\K{16\_u}~m \\ &&|&
     \text{i64.load8\_s}~~m{:}\Tmemarg_1 &\Rightarrow& \I64.\LOAD\K{8\_s}~m \\ &&|&
     \text{i64.load8\_u}~~m{:}\Tmemarg_1 &\Rightarrow& \I64.\LOAD\K{8\_u}~m \\ &&|&
     \text{i64.load16\_s}~~m{:}\Tmemarg_2 &\Rightarrow& \I64.\LOAD\K{16\_s}~m \\ &&|&
     \text{i64.load16\_u}~~m{:}\Tmemarg_2 &\Rightarrow& \I64.\LOAD\K{16\_u}~m \\ &&|&
     \text{i64.load32\_s}~~m{:}\Tmemarg_4 &\Rightarrow& \I64.\LOAD\K{32\_s}~m \\ &&|&
     \text{i64.load32\_u}~~m{:}\Tmemarg_4 &\Rightarrow& \I64.\LOAD\K{32\_u}~m \\ &&|&
     \text{i32.store}~~m{:}\Tmemarg_4 &\Rightarrow& \I32.\STORE~m \\ &&|&
     \text{i64.store}~~m{:}\Tmemarg_8 &\Rightarrow& \I64.\STORE~m \\ &&|&
     \text{f32.store}~~m{:}\Tmemarg_4 &\Rightarrow& \F32.\STORE~m \\ &&|&
     \text{f64.store}~~m{:}\Tmemarg_8 &\Rightarrow& \F64.\STORE~m \\ &&|&
     \text{i32.store8}~~m{:}\Tmemarg_1 &\Rightarrow& \I32.\STORE\K{8}~m \\ &&|&
     \text{i32.store16}~~m{:}\Tmemarg_2 &\Rightarrow& \I32.\STORE\K{16}~m \\ &&|&
     \text{i64.store8}~~m{:}\Tmemarg_1 &\Rightarrow& \I64.\STORE\K{8}~m \\ &&|&
     \text{i64.store16}~~m{:}\Tmemarg_2 &\Rightarrow& \I64.\STORE\K{16}~m \\ &&|&
     \text{i64.store32}~~m{:}\Tmemarg_4 &\Rightarrow& \I64.\STORE\K{32}~m \\ &&|&
     \text{memory.size} &\Rightarrow& \MEMORYSIZE \\ &&|&
     \text{memory.grow} &\Rightarrow& \MEMORYGROW \\ &&|&
     \text{memory.fill} &\Rightarrow& \MEMORYFILL \\ &&|&
     \text{memory.copy} &\Rightarrow& \MEMORYCOPY \\ &&|&
     \text{memory.init}~~x{:}\Tdataidx_I &\Rightarrow& \MEMORYINIT~x \\ &&|&
     \text{data.drop}~~x{:}\Tdataidx_I &\Rightarrow& \DATADROP~x \\
   \end{array}


.. index:: numeric instruction
   pair: text format; instruction
.. _text-instr-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

.. _text-const:

.. math::
   \begin{array}{llclll}
   \production{instruction} & \Tplaininstr_I &::=& \dots \\&&|&
     \text{i32.const}~~n{:}\Ti32 &\Rightarrow& \I32.\CONST~n \\ &&|&
     \text{i64.const}~~n{:}\Ti64 &\Rightarrow& \I64.\CONST~n \\ &&|&
     \text{f32.const}~~z{:}\Tf32 &\Rightarrow& \F32.\CONST~z \\ &&|&
     \text{f64.const}~~z{:}\Tf64 &\Rightarrow& \F64.\CONST~z \\
   \end{array}

.. _text-unop:
.. _text-binop:

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{thisisenough} && \phantom{thisshouldbeenough} \\[-2ex] &&|&
     \text{i32.clz} &\Rightarrow& \I32.\CLZ \\ &&|&
     \text{i32.ctz} &\Rightarrow& \I32.\CTZ \\ &&|&
     \text{i32.popcnt} &\Rightarrow& \I32.\POPCNT \\ &&|&
     \text{i32.add} &\Rightarrow& \I32.\ADD \\ &&|&
     \text{i32.sub} &\Rightarrow& \I32.\SUB \\ &&|&
     \text{i32.mul} &\Rightarrow& \I32.\MUL \\ &&|&
     \text{i32.div\_s} &\Rightarrow& \I32.\DIV\K{\_s} \\ &&|&
     \text{i32.div\_u} &\Rightarrow& \I32.\DIV\K{\_u} \\ &&|&
     \text{i32.rem\_s} &\Rightarrow& \I32.\REM\K{\_s} \\ &&|&
     \text{i32.rem\_u} &\Rightarrow& \I32.\REM\K{\_u} \\ &&|&
     \text{i32.and} &\Rightarrow& \I32.\AND \\ &&|&
     \text{i32.or} &\Rightarrow& \I32.\OR \\ &&|&
     \text{i32.xor} &\Rightarrow& \I32.\XOR \\ &&|&
     \text{i32.shl} &\Rightarrow& \I32.\SHL \\ &&|&
     \text{i32.shr\_s} &\Rightarrow& \I32.\SHR\K{\_s} \\ &&|&
     \text{i32.shr\_u} &\Rightarrow& \I32.\SHR\K{\_u} \\ &&|&
     \text{i32.rotl} &\Rightarrow& \I32.\ROTL \\ &&|&
     \text{i32.rotr} &\Rightarrow& \I32.\ROTR \\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{thisisenough} && \phantom{thisshouldbeenough} \\[-2ex] &&|&
     \text{i64.clz} &\Rightarrow& \I64.\CLZ \\ &&|&
     \text{i64.ctz} &\Rightarrow& \I64.\CTZ \\ &&|&
     \text{i64.popcnt} &\Rightarrow& \I64.\POPCNT \\ &&|&
     \text{i64.add} &\Rightarrow& \I64.\ADD \\ &&|&
     \text{i64.sub} &\Rightarrow& \I64.\SUB \\ &&|&
     \text{i64.mul} &\Rightarrow& \I64.\MUL \\ &&|&
     \text{i64.div\_s} &\Rightarrow& \I64.\DIV\K{\_s} \\ &&|&
     \text{i64.div\_u} &\Rightarrow& \I64.\DIV\K{\_u} \\ &&|&
     \text{i64.rem\_s} &\Rightarrow& \I64.\REM\K{\_s} \\ &&|&
     \text{i64.rem\_u} &\Rightarrow& \I64.\REM\K{\_u} \\ &&|&
     \text{i64.and} &\Rightarrow& \I64.\AND \\ &&|&
     \text{i64.or} &\Rightarrow& \I64.\OR \\ &&|&
     \text{i64.xor} &\Rightarrow& \I64.\XOR \\ &&|&
     \text{i64.shl} &\Rightarrow& \I64.\SHL \\ &&|&
     \text{i64.shr\_s} &\Rightarrow& \I64.\SHR\K{\_s} \\ &&|&
     \text{i64.shr\_u} &\Rightarrow& \I64.\SHR\K{\_u} \\ &&|&
     \text{i64.rotl} &\Rightarrow& \I64.\ROTL \\ &&|&
     \text{i64.rotr} &\Rightarrow& \I64.\ROTR \\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{thisisenough} && \phantom{thisshouldbeenough} \\[-2ex] &&|&
     \text{f32.abs} &\Rightarrow& \F32.\ABS \\ &&|&
     \text{f32.neg} &\Rightarrow& \F32.\NEG \\ &&|&
     \text{f32.ceil} &\Rightarrow& \F32.\CEIL \\ &&|&
     \text{f32.floor} &\Rightarrow& \F32.\FLOOR \\ &&|&
     \text{f32.trunc} &\Rightarrow& \F32.\TRUNC \\ &&|&
     \text{f32.nearest} &\Rightarrow& \F32.\NEAREST \\ &&|&
     \text{f32.sqrt} &\Rightarrow& \F32.\SQRT \\ &&|&
     \text{f32.add} &\Rightarrow& \F32.\ADD \\ &&|&
     \text{f32.sub} &\Rightarrow& \F32.\SUB \\ &&|&
     \text{f32.mul} &\Rightarrow& \F32.\MUL \\ &&|&
     \text{f32.div} &\Rightarrow& \F32.\DIV \\ &&|&
     \text{f32.min} &\Rightarrow& \F32.\FMIN \\ &&|&
     \text{f32.max} &\Rightarrow& \F32.\FMAX \\ &&|&
     \text{f32.copysign} &\Rightarrow& \F32.\COPYSIGN \\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{thisisenough} && \phantom{thisshouldbeenough} \\[-2ex] &&|&
     \text{f64.abs} &\Rightarrow& \F64.\ABS \\ &&|&
     \text{f64.neg} &\Rightarrow& \F64.\NEG \\ &&|&
     \text{f64.ceil} &\Rightarrow& \F64.\CEIL \\ &&|&
     \text{f64.floor} &\Rightarrow& \F64.\FLOOR \\ &&|&
     \text{f64.trunc} &\Rightarrow& \F64.\TRUNC \\ &&|&
     \text{f64.nearest} &\Rightarrow& \F64.\NEAREST \\ &&|&
     \text{f64.sqrt} &\Rightarrow& \F64.\SQRT \\ &&|&
     \text{f64.add} &\Rightarrow& \F64.\ADD \\ &&|&
     \text{f64.sub} &\Rightarrow& \F64.\SUB \\ &&|&
     \text{f64.mul} &\Rightarrow& \F64.\MUL \\ &&|&
     \text{f64.div} &\Rightarrow& \F64.\DIV \\ &&|&
     \text{f64.min} &\Rightarrow& \F64.\FMIN \\ &&|&
     \text{f64.max} &\Rightarrow& \F64.\FMAX \\ &&|&
     \text{f64.copysign} &\Rightarrow& \F64.\COPYSIGN \\
   \end{array}

.. _text-testop:
.. _text-relop:

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{thisisenough} && \phantom{thisshouldbeenough} \\[-2ex] &&|&
     \text{i32.eqz} &\Rightarrow& \I32.\EQZ \\ &&|&
     \text{i32.eq} &\Rightarrow& \I32.\EQ \\ &&|&
     \text{i32.ne} &\Rightarrow& \I32.\NE \\ &&|&
     \text{i32.lt\_s} &\Rightarrow& \I32.\LT\K{\_s} \\ &&|&
     \text{i32.lt\_u} &\Rightarrow& \I32.\LT\K{\_u} \\ &&|&
     \text{i32.gt\_s} &\Rightarrow& \I32.\GT\K{\_s} \\ &&|&
     \text{i32.gt\_u} &\Rightarrow& \I32.\GT\K{\_u} \\ &&|&
     \text{i32.le\_s} &\Rightarrow& \I32.\LE\K{\_s} \\ &&|&
     \text{i32.le\_u} &\Rightarrow& \I32.\LE\K{\_u} \\ &&|&
     \text{i32.ge\_s} &\Rightarrow& \I32.\GE\K{\_s} \\ &&|&
     \text{i32.ge\_u} &\Rightarrow& \I32.\GE\K{\_u} \\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{thisisenough} && \phantom{thisshouldbeenough} \\[-2ex] &&|&
     \text{i64.eqz} &\Rightarrow& \I64.\EQZ \\ &&|&
     \text{i64.eq} &\Rightarrow& \I64.\EQ \\ &&|&
     \text{i64.ne} &\Rightarrow& \I64.\NE \\ &&|&
     \text{i64.lt\_s} &\Rightarrow& \I64.\LT\K{\_s} \\ &&|&
     \text{i64.lt\_u} &\Rightarrow& \I64.\LT\K{\_u} \\ &&|&
     \text{i64.gt\_s} &\Rightarrow& \I64.\GT\K{\_s} \\ &&|&
     \text{i64.gt\_u} &\Rightarrow& \I64.\GT\K{\_u} \\ &&|&
     \text{i64.le\_s} &\Rightarrow& \I64.\LE\K{\_s} \\ &&|&
     \text{i64.le\_u} &\Rightarrow& \I64.\LE\K{\_u} \\ &&|&
     \text{i64.ge\_s} &\Rightarrow& \I64.\GE\K{\_s} \\ &&|&
     \text{i64.ge\_u} &\Rightarrow& \I64.\GE\K{\_u} \\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{thisisenough} && \phantom{thisshouldbeenough} \\[-2ex] &&|&
     \text{f32.eq} &\Rightarrow& \F32.\EQ \\ &&|&
     \text{f32.ne} &\Rightarrow& \F32.\NE \\ &&|&
     \text{f32.lt} &\Rightarrow& \F32.\LT \\ &&|&
     \text{f32.gt} &\Rightarrow& \F32.\GT \\ &&|&
     \text{f32.le} &\Rightarrow& \F32.\LE \\ &&|&
     \text{f32.ge} &\Rightarrow& \F32.\GE \\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{thisisenough} && \phantom{thisshouldbeenough} \\[-2ex] &&|&
     \text{f64.eq} &\Rightarrow& \F64.\EQ \\ &&|&
     \text{f64.ne} &\Rightarrow& \F64.\NE \\ &&|&
     \text{f64.lt} &\Rightarrow& \F64.\LT \\ &&|&
     \text{f64.gt} &\Rightarrow& \F64.\GT \\ &&|&
     \text{f64.le} &\Rightarrow& \F64.\LE \\ &&|&
     \text{f64.ge} &\Rightarrow& \F64.\GE \\
   \end{array}

.. _text-cvtop:

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{thisisenough} && \phantom{thisshouldbeenough} \\[-2ex] &&|&
     \text{i32.wrap\_i64} &\Rightarrow& \I32.\WRAP\K{\_}\I64 \\ &&|&
     \text{i32.trunc\_f32\_s} &\Rightarrow& \I32.\TRUNC\K{\_}\F32\K{\_s} \\ &&|&
     \text{i32.trunc\_f32\_u} &\Rightarrow& \I32.\TRUNC\K{\_}\F32\K{\_u} \\ &&|&
     \text{i32.trunc\_f64\_s} &\Rightarrow& \I32.\TRUNC\K{\_}\F64\K{\_s} \\ &&|&
     \text{i32.trunc\_f64\_u} &\Rightarrow& \I32.\TRUNC\K{\_}\F64\K{\_u} \\ &&|&
     \text{i32.trunc\_sat\_f32\_s} &\Rightarrow& \I32.\TRUNC\K{\_sat\_}\F32\K{\_s} \\ &&|&
     \text{i32.trunc\_sat\_f32\_u} &\Rightarrow& \I32.\TRUNC\K{\_sat\_}\F32\K{\_u} \\ &&|&
     \text{i32.trunc\_sat\_f64\_s} &\Rightarrow& \I32.\TRUNC\K{\_sat\_}\F64\K{\_s} \\ &&|&
     \text{i32.trunc\_sat\_f64\_u} &\Rightarrow& \I32.\TRUNC\K{\_sat\_}\F64\K{\_u} \\ &&|&
     \text{i64.extend\_i32\_s} &\Rightarrow& \I64.\EXTEND\K{\_}\I32\K{\_s} \\ &&|&
     \text{i64.extend\_i32\_u} &\Rightarrow& \I64.\EXTEND\K{\_}\I32\K{\_u} \\ &&|&
     \text{i64.trunc\_f32\_s} &\Rightarrow& \I64.\TRUNC\K{\_}\F32\K{\_s} \\ &&|&
     \text{i64.trunc\_f32\_u} &\Rightarrow& \I64.\TRUNC\K{\_}\F32\K{\_u} \\ &&|&
     \text{i64.trunc\_f64\_s} &\Rightarrow& \I64.\TRUNC\K{\_}\F64\K{\_s} \\ &&|&
     \text{i64.trunc\_f64\_u} &\Rightarrow& \I64.\TRUNC\K{\_}\F64\K{\_u} \\ &&|&
     \text{i64.trunc\_sat\_f32\_s} &\Rightarrow& \I64.\TRUNC\K{\_sat\_}\F32\K{\_s} \\ &&|&
     \text{i64.trunc\_sat\_f32\_u} &\Rightarrow& \I64.\TRUNC\K{\_sat\_}\F32\K{\_u} \\ &&|&
     \text{i64.trunc\_sat\_f64\_s} &\Rightarrow& \I64.\TRUNC\K{\_sat\_}\F64\K{\_s} \\ &&|&
     \text{i64.trunc\_sat\_f64\_u} &\Rightarrow& \I64.\TRUNC\K{\_sat\_}\F64\K{\_u} \\ &&|&
     \text{f32.convert\_i32\_s} &\Rightarrow& \F32.\CONVERT\K{\_}\I32\K{\_s} \\ &&|&
     \text{f32.convert\_i32\_u} &\Rightarrow& \F32.\CONVERT\K{\_}\I32\K{\_u} \\ &&|&
     \text{f32.convert\_i64\_s} &\Rightarrow& \F32.\CONVERT\K{\_}\I64\K{\_s} \\ &&|&
     \text{f32.convert\_i64\_u} &\Rightarrow& \F32.\CONVERT\K{\_}\I64\K{\_u} \\ &&|&
     \text{f32.demote\_f64} &\Rightarrow& \F32.\DEMOTE\K{\_}\F64 \\ &&|&
     \text{f64.convert\_i32\_s} &\Rightarrow& \F64.\CONVERT\K{\_}\I32\K{\_s} \\ &&|&
     \text{f64.convert\_i32\_u} &\Rightarrow& \F64.\CONVERT\K{\_}\I32\K{\_u} \\ &&|&
     \text{f64.convert\_i64\_s} &\Rightarrow& \F64.\CONVERT\K{\_}\I64\K{\_s} \\ &&|&
     \text{f64.convert\_i64\_u} &\Rightarrow& \F64.\CONVERT\K{\_}\I64\K{\_u} \\ &&|&
     \text{f64.promote\_f32} &\Rightarrow& \F64.\PROMOTE\K{\_}\F32 \\ &&|&
     \text{i32.reinterpret\_f32} &\Rightarrow& \I32.\REINTERPRET\K{\_}\F32 \\ &&|&
     \text{i64.reinterpret\_f64} &\Rightarrow& \I64.\REINTERPRET\K{\_}\F64 \\ &&|&
     \text{f32.reinterpret\_i32} &\Rightarrow& \F32.\REINTERPRET\K{\_}\I32 \\ &&|&
     \text{f64.reinterpret\_i64} &\Rightarrow& \F64.\REINTERPRET\K{\_}\I64 \\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{thisisenough} && \phantom{thisshouldbeenough} \\[-2ex] &&|&
     \text{i32.extend8\_s} &\Rightarrow& \I32.\EXTEND\K{8\_s} \\ &&|&
     \text{i32.extend16\_s} &\Rightarrow& \I32.\EXTEND\K{16\_s} \\ &&|&
     \text{i64.extend8\_s} &\Rightarrow& \I64.\EXTEND\K{8\_s} \\ &&|&
     \text{i64.extend16\_s} &\Rightarrow& \I64.\EXTEND\K{16\_s} \\ &&|&
     \text{i64.extend32\_s} &\Rightarrow& \I64.\EXTEND\K{32\_s} \\
   \end{array}


.. index:: ! folded instruction, S-expression
.. _text-foldedinstr:

Folded Instructions
~~~~~~~~~~~~~~~~~~~

Instructions can be written as S-expressions by grouping them into *folded* form. In that notation, an instruction is wrapped in parentheses and optionally includes nested folded instructions to indicate its operands.

In the case of :ref:`block instructions <text-instr-block>`, the folded form omits the :math:`\text{end}` delimiter.
For |IF| instructions, both branches have to be wrapped into nested S-expressions, headed by the keywords :math:`\text{then}` and :math:`\text{else}`.

The set of all phrases defined by the following abbreviations recursively forms the auxiliary syntactic class |Tfoldedinstr|.
Such a folded instruction can appear anywhere a regular instruction can.

.. MathJax doesn't handle LaTex multicolumns, thus the spacing hack in the following formula.

.. math::
   \begin{array}{lllll}
   \production{instruction} & 
     \text{(}~\Tplaininstr~~\Tfoldedinstr^\ast~\text{)}
       &\equiv\quad \Tfoldedinstr^\ast~~\Tplaininstr \\ &
     \text{(}~\text{block}~~\Tlabel~~\Tblocktype~~\Tinstr^\ast~\text{)}
       &\equiv\quad \text{block}~~\Tlabel~~\Tblocktype~~\Tinstr^\ast~~\text{end} \\ &
     \text{(}~\text{loop}~~\Tlabel~~\Tblocktype~~\Tinstr^\ast~\text{)}
       &\equiv\quad \text{loop}~~\Tlabel~~\Tblocktype~~\Tinstr^\ast~~\text{end} \\ &
     \text{(}~\text{if}~~\Tlabel~~\Tblocktype~~\Tfoldedinstr^\ast
       &\hspace{-3ex} \text{(}~\text{then}~~\Tinstr_1^\ast~\text{)}~~\text{(}~\text{else}~~\Tinstr_2^\ast~\text{)}^?~~\text{)}
       \quad\equiv \\ &\qquad
         \Tfoldedinstr^\ast~~\text{if}~~\Tlabel~~\Tblocktype &\hspace{-1ex} \Tinstr_1^\ast~~\text{else}~~(\Tinstr_2^\ast)^?~\text{end} \\ &
     \text{(}~\text{try}~~\Tlabel~~\Tblocktype~~\text{(}~\text{do}~~\Tinstr_1^\ast~~\text{)}
       &\hspace{-8ex} \text{(}~\text{catch}~~\Tinstr_2^\ast~\text{)}~\text{)} \quad\equiv \\ &\qquad
       \text{try}~~\Tlabel~~\Tblocktype~~\Tinstr_1^\ast & \hspace{-6ex} \text{catch}~~\Tinstr_2^\ast~\text{end} & \\
   \end{array}

.. note::
   For example, the instruction sequence

   .. math::
      \mathtt{(local.get~\$x)~(i32.const~2)~i32.add~(i32.const~3)~i32.mul}

   can be folded into

   .. math::
      \mathtt{(i32.mul~(i32.add~(local.get~\$x)~(i32.const~2))~(i32.const~3))}

   Folded instructions are solely syntactic sugar,
   no additional syntactic or type-based checking is implied.


.. index:: expression
   pair: text format; expression
   single: expression; constant
.. _text-expr:

Expressions
~~~~~~~~~~~

Expressions are written as instruction sequences.
No explicit :math:`\text{end}` keyword is included, since they only occur in bracketed positions.

.. math::
   \begin{array}{llclll}
   \production{expression} & \Texpr_I &::=&
     (\X{in}{:}\Tinstr_I)^\ast &\Rightarrow& \X{in}^\ast~\END \\
   \end{array}

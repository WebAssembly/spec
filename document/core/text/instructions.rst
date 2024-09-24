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
     v{:}\Tid &\Rightarrow& v, \{\ILABELS~v\} \compose I
       & (\iff v \notin I.\ILABELS) \\ &&|&
     v{:}\Tid &\Rightarrow& v, \{\ILABELS~v\} \compose (I \with \ILABELS[i] = \epsilon)
       & (\iff I.\ILABELS[i] = v) \\ &&|&
     \epsilon &\Rightarrow& \epsilon, \{\ILABELS~(\epsilon)\} \compose I \\
   \end{array}

.. note::
   The new label entry is inserted at the *beginning* of the label list in the identifier context.
   This effectively shifts all existing labels up by one,
   mirroring the fact that control instructions are indexed relatively not absolutely.

   If a label with the same name already exists,
   then it is shadowed and the earlier label becomes inaccessible.


.. index:: control instructions, structured control, label, block, branch, result type, label index, function index, tag index, type index, vector, polymorphism, reference
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
.. _text-try_table:
.. _text-catch:

:ref:`Structured control instructions <syntax-instr-control>` can bind an optional symbolic :ref:`label identifier <text-label>`.
The same label identifier may optionally be repeated after the corresponding :math:`\T{end}` or :math:`\T{else}` keywords, to indicate the matching delimiters.

Their :ref:`block type <syntax-blocktype>` is given as a :ref:`type use <text-typeuse>`, analogous to the type of :ref:`functions <text-func>`.
However, the special case of a type use that is syntactically empty or consists of only a single :ref:`result <text-result>` is not regarded as an :ref:`abbreviation <text-typeuse-abbrev>` for an inline :ref:`function type <syntax-functype>`, but is parsed directly into an optional :ref:`value type <syntax-valtype>`.

.. math::
   \begin{array}{llclll}
   \production{block type} & \Tblocktype_I &
   \begin{array}[t]{@{}c@{}} ::= \\ | \\ \end{array}
   &
   \begin{array}[t]{@{}lcll@{}}
     (t{:}\Tresult_I)^? &\Rightarrow& t^? \\
     x,I'{:}\Ttypeuse_I &\Rightarrow& x & (\iff I' = \{\ILOCALS~(\epsilon)^\ast\}) \\
   \end{array} \\
   \production{block instruction} & \Tblockinstr_I &::=&
     \text{block}~~(v^?,I'){:}\Tlabel_I~~\X{bt}{:}\Tblocktype_I~~(\X{in}{:}\Tinstr_{I'})^\ast~~\text{end}~~{v'}^?{:}\Tid^?
       \\ &&&\qquad \Rightarrow\quad \BLOCK~\X{bt}~\X{in}^\ast~\END
       \qquad\quad~~ (\iff {v'}^? = \epsilon \vee {v'}^? = v^?) \\ &&|&
     \text{loop}~~(v^?,I'){:}\Tlabel_I~~\X{bt}{:}\Tblocktype_I~~(\X{in}{:}\Tinstr_{I'})^\ast~~\text{end}~~{v'}^?{:}\Tid^?
       \\ &&&\qquad \Rightarrow\quad \LOOP~\X{bt}~\X{in}^\ast~\END
       \qquad\qquad (\iff {v'}^? = \epsilon \vee {v'}^? = v^?) \\ &&|&
     \text{if}~~(v^?,I'){:}\Tlabel_I~~\X{bt}{:}\Tblocktype_I~~(\X{in}_1{:}\Tinstr_{I'})^\ast~~
       \text{else}~~v_1^?{:}\Tid_1^?~~(\X{in}_2{:}\Tinstr_{I'})^\ast~~\text{end}~~v_2^?{:}\Tid_2^?
       \\ &&&\qquad \Rightarrow\quad \IF~\X{bt}~\X{in}_1^\ast~\ELSE~\X{in}_2^\ast~\END
       \qquad (\iff v_1^? = \epsilon \vee v_1^? = v^?, v_2^? = \epsilon \vee v_2^? = v^?) \\ &&|&
     \text{try\_table}~~I'{:}\Tlabel_I~~\X{bt}{:}\Tblocktype~~(c{:}\Tcatch_I)^\ast~~(\X{in}{:}\Tinstr_{I'})^\ast~~\text{end}~~\Tid^?
       \\ &&&\qquad \Rightarrow\quad \TRYTABLE~\X{bt}~c^\ast~\X{in}^\ast~~\END
       \qquad\qquad (\iff \Tid^? = \epsilon \vee \Tid^? = \Tlabel) \\
   \production{catch clause} & \Tcatch_I &
   \begin{array}[t]{@{}c@{}} ::= \\ | \\ | \\ | \\ \end{array}
   &
   \begin{array}[t]{@{}lcll@{}}
     \text{(}~\text{catch}~~x{:}\Ttagidx_I~~l{:}\Tlabelidx_I~\text{)}
       &\Rightarrow& \CATCH~x~l \\
     \text{(}~\text{catch\_ref}~~x{:}\Ttagidx_I~~l{:}\Tlabelidx_I~\text{)}
       &\Rightarrow& \CATCHREF~x~l \\
     \text{(}~\text{catch\_all}~~l{:}\Tlabelidx_I~\text{)}
       &\Rightarrow& \CATCHALL~l \\
     \text{(}~\text{catch\_all\_ref}~~l{:}\Tlabelidx_I~\text{)}
       &\Rightarrow& \CATCHALLREF~l \\
   \end{array} \\
   \end{array}

.. note::
   The side condition stating that the :ref:`identifier context <text-context>` :math:`I'` must only contain unnamed entries in the rule for |Ttypeuse| block types enforces that no identifier can be bound in any |Tparam| declaration for a block type.


.. _text-nop:
.. _text-unreachable:
.. _text-br:
.. _text-br_if:
.. _text-br_table:
.. _text-br_on_null:
.. _text-br_on_non_null:
.. _text-br_on_cast:
.. _text-br_on_cast_fail:
.. _text-return:
.. _text-call:
.. _text-call_ref:
.. _text-call_indirect:
.. _text-return_call:
.. _text-return_call_indirect:
.. _text-throw:
.. _text-throw_ref:

All other control instruction are represented verbatim.

.. math::
   \begin{array}{llcllll}
   \production{plain instruction} & \Tplaininstr_I &::=&
     \text{unreachable} &\Rightarrow& \UNREACHABLE \\ &&|&
     \text{nop} &\Rightarrow& \NOP \\ &&|&
     \text{br}~~l{:}\Tlabelidx_I &\Rightarrow& \BR~l \\ &&|&
     \text{br\_if}~~l{:}\Tlabelidx_I &\Rightarrow& \BRIF~l \\ &&|&
     \text{br\_table}~~l^\ast{:}\Tvec(\Tlabelidx_I)~~l_N{:}\Tlabelidx_I
       &\Rightarrow& \BRTABLE~l^\ast~l_N \\ &&|&
     \text{br\_on\_null}~~l{:}\Tlabelidx_I &\Rightarrow& \BRONNULL~l \\ &&|&
     \text{br\_on\_non\_null}~~l{:}\Tlabelidx_I &\Rightarrow& \BRONNONNULL~l \\ &&|&
     \text{br\_on\_cast}~~l{:}\Tlabelidx_I~~t_1{:}\Treftype~~t_2{:}\Treftype &\Rightarrow& \BRONCAST~l~t_1~t_2 \\ &&|&
     \text{br\_on\_cast\_fail}~~l{:}\Tlabelidx_I~~t_1{:}\Treftype~~t_2{:}\Treftype &\Rightarrow& \BRONCASTFAIL~l~t_1~t_2 \\ &&|&
     \text{return} &\Rightarrow& \RETURN \\ &&|&
     \text{call}~~x{:}\Tfuncidx_I &\Rightarrow& \CALL~x \\ &&|&
     \text{call\_ref}~~x{:}\Ttypeidx &\Rightarrow& \CALLREF~x \\ &&|&
     \text{call\_indirect}~~x{:}\Ttableidx~~y,I'{:}\Ttypeuse_I &\Rightarrow& \CALLINDIRECT~x~y
       & (\iff I' = \{\ILOCALS~(\epsilon)^\ast\}) \\&&|&
     \text{return\_call}~~x{:}\Tfuncidx_I &\Rightarrow& \RETURNCALL~x \\ &&|&
     \text{return\_call\_ref}~~x{:}\Ttypeidx &\Rightarrow& \RETURNCALLREF~x \\ &&|&
     \text{return\_call\_indirect}~~x{:}\Ttableidx~~y,I'{:}\Ttypeuse_I &\Rightarrow& \RETURNCALLINDIRECT~x~y
       & (\iff I' = \{\ILOCALS~(\epsilon)^\ast\}) \\ &&|&
     \text{throw}~~x{:}\Ttagidx_I &\Rightarrow& \THROW~x \\ &&|&
     \text{throw\_ref} &\Rightarrow& \THROWREF \\
   \end{array}

.. note::
   The side condition stating that the :ref:`identifier context <text-context>` :math:`I'` must only contain unnamed entries in the rule for |CALLINDIRECT| enforces that no identifier can be bound in any |Tparam| declaration appearing in the type annotation.


Abbreviations
.............

The :math:`\text{else}` keyword of an :math:`\text{if}` instruction can be omitted if the following instruction sequence is empty.

.. math::
   \begin{array}{llclll}
   \production{block instruction} &
     \text{if}~~\Tlabel~~\Tblocktype_I~~\Tinstr^\ast~~\text{end}
       &\equiv&
     \text{if}~~\Tlabel~~\Tblocktype_I~~\Tinstr^\ast~~\text{else}~~\text{end}
   \end{array}

Also, for backwards compatibility, the table index to :math:`\text{call\_indirect}` and :math:`\text{return\_call\_indirect}` can be omitted, defaulting to :math:`0`.

.. math::
   \begin{array}{llclll}
   \production{plain instruction} &
     \text{call\_indirect}~~\Ttypeuse
       &\equiv&
     \text{call\_indirect}~~0~~\Ttypeuse \\
     \text{return\_call\_indirect}~~\Ttypeuse
       &\equiv&
     \text{return\_call\_indirect}~~0~~\Ttypeuse \\
   \end{array}


.. index:: reference instruction
   pair: text format; instruction
.. _text-instr-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _text-ref.null:
.. _text-ref.func:
.. _text-ref.is_null:
.. _text-ref.as_non_null:
.. _text-struct.new:
.. _text-struct.new_default:
.. _text-struct.get:
.. _text-struct.get_s:
.. _text-struct.get_u:
.. _text-struct.set:
.. _text-array.new:
.. _text-array.new_default:
.. _text-array.new_fixed:
.. _text-array.new_elem:
.. _text-array.new_data:
.. _text-array.get:
.. _text-array.get_s:
.. _text-array.get_u:
.. _text-array.set:
.. _text-array.len:
.. _text-array.fill:
.. _text-array.copy:
.. _text-array.init_data:
.. _text-array.init_elem:
.. _text-ref.i31:
.. _text-i31.get_s:
.. _text-i31.get_u:
.. _text-ref.test:
.. _text-ref.cast:
.. _text-any.convert_extern:
.. _text-extern.convert_any:

.. math::
   \begin{array}{llclll}
   \production{instruction} & \Tplaininstr_I &::=& \dots \\ &&|&
     \text{ref.null}~~t{:}\Theaptype &\Rightarrow& \REFNULL~t \\ &&|&
     \text{ref.func}~~x{:}\Tfuncidx &\Rightarrow& \REFFUNC~x \\ &&|&
     \text{ref.is\_null} &\Rightarrow& \REFISNULL \\ &&|&
     \text{ref.as\_non\_null} &\Rightarrow& \REFASNONNULL \\ &&|&
     \text{ref.eq} &\Rightarrow& \REFEQ \\ &&|&
     \text{ref.test}~~t{:}\Treftype &\Rightarrow& \REFTEST~t \\ &&|&
     \text{ref.cast}~~t{:}\Treftype &\Rightarrow& \REFCAST~t \\ &&|&
     \text{struct.new}~~x{:}\Ttypeidx_I &\Rightarrow& \STRUCTNEW~x \\ &&|&
     \text{struct.new\_default}~~x{:}\Ttypeidx_I &\Rightarrow& \STRUCTNEWDEFAULT~x \\ &&|&
     \text{struct.get}~~x{:}\Ttypeidx_I~~y{:}\Tfieldidx_{I,x} &\Rightarrow& \STRUCTGET~x~y \\ &&|&
     \text{struct.get\_u}~~x{:}\Ttypeidx_I~~y{:}\Tfieldidx_{I,x} &\Rightarrow& \STRUCTGETU~x~y \\ &&|&
     \text{struct.get\_s}~~x{:}\Ttypeidx_I~~y{:}\Tfieldidx_{I,x} &\Rightarrow& \STRUCTGETS~x~y \\ &&|&
     \text{struct.set}~~x{:}\Ttypeidx_I~~y{:}\Tfieldidx_{I,x} &\Rightarrow& \STRUCTSET~x~y \\ &&|&
     \text{array.new}~~x{:}\Ttypeidx_I &\Rightarrow& \ARRAYNEW~x \\ &&|&
     \text{array.new\_default}~~x{:}\Ttypeidx_I &\Rightarrow& \ARRAYNEWDEFAULT~x \\ &&|&
     \text{array.new\_fixed}~~x{:}\Ttypeidx_I~~n{:}\Tu32 &\Rightarrow& \ARRAYNEWFIXED~x~n \\ &&|&
     \text{array.new\_data}~~x{:}\Ttypeidx_I~~y{:}\Tdataidx_I &\Rightarrow& \ARRAYNEWDATA~x~y \\ &&|&
     \text{array.new\_elem}~~x{:}\Ttypeidx_I~~y{:}\Telemidx_I &\Rightarrow& \ARRAYNEWELEM~x~y \\ &&|&
     \text{array.get}~~x{:}\Ttypeidx_I &\Rightarrow& \ARRAYGET~x \\ &&|&
     \text{array.get\_u}~~x{:}\Ttypeidx_I &\Rightarrow& \ARRAYGETU~x \\ &&|&
     \text{array.get\_s}~~x{:}\Ttypeidx_I &\Rightarrow& \ARRAYGETS~x \\ &&|&
     \text{array.set}~~x{:}\Ttypeidx_I &\Rightarrow& \ARRAYSET~x \\ &&|&
     \text{array.len} &\Rightarrow& \ARRAYLEN \\ &&|&
     \text{array.fill}~~x{:}\Ttypeidx_I &\Rightarrow& \ARRAYFILL~x \\ &&|&
     \text{array.copy}~~x{:}\Ttypeidx_I~~y{:}\Ttypeidx_I &\Rightarrow& \ARRAYCOPY~x~y \\ &&|&
     \text{array.init\_data}~~x{:}\Ttypeidx_I~~y{:}\Tdataidx_I &\Rightarrow& \ARRAYINITDATA~x~y \\ &&|&
     \text{array.init\_elem}~~x{:}\Ttypeidx_I~~y{:}\Telemidx_I &\Rightarrow& \ARRAYINITELEM~x~y \\ &&|&
     \text{ref.i31} &\Rightarrow& \REFI31 \\ &&|&
     \text{i31.get\_u} &\Rightarrow& \I31GETU \\ &&|&
     \text{i31.get\_s} &\Rightarrow& \I31GETS \\ &&|&
     \text{any.convert\_extern} &\Rightarrow& \ANYCONVERTEXTERN \\ &&|&
     \text{extern.convert\_any} &\Rightarrow& \EXTERNCONVERTANY \\
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
     \text{select}~((t{:}\Tresult_I)^\ast)^? &\Rightarrow& \SELECT~(t^\ast)^? \\
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

For backwards compatibility, all :ref:`table indices <syntax-tableidx>` may be omitted from table instructions, defaulting to :math:`0`.

.. math::
   \begin{array}{llcl}
   \production{instruction} &
     \text{table.get} &\equiv& \text{table.get}~~\text{0} \\ &
     \text{table.set} &\equiv& \text{table.set}~~\text{0} \\ &
     \text{table.size} &\equiv& \text{table.size}~~\text{0} \\ &
     \text{table.grow} &\equiv& \text{table.grow}~~\text{0} \\ &
     \text{table.fill} &\equiv& \text{table.fill}~~\text{0} \\ &
     \text{table.copy} &\equiv& \text{table.copy}~~\text{0}~~\text{0} \\ &
     \text{table.init}~~x{:}\Telemidx_I &\equiv& \text{table.init}~~\text{0}~~x{:}\Telemidx_I \\
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
   \production{instruction} & \Tplaininstr_I &::=& \dots \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallylonginstructionnames} \\ &&|&
     \text{i32.load}~~x{:}\Tmemidx~~m{:}\Tmemarg_4 &\Rightarrow& \I32.\LOAD~x~m \\ &&|&
     \text{i64.load}~~x{:}\Tmemidx~~m{:}\Tmemarg_8 &\Rightarrow& \I64.\LOAD~x~m \\ &&|&
     \text{f32.load}~~x{:}\Tmemidx~~m{:}\Tmemarg_4 &\Rightarrow& \F32.\LOAD~x~m \\ &&|&
     \text{f64.load}~~x{:}\Tmemidx~~m{:}\Tmemarg_8 &\Rightarrow& \F64.\LOAD~x~m \\ &&|&
     \text{v128.load}~~x{:}\Tmemidx~~m{:}\Tmemarg_{16} &\Rightarrow& \V128.\LOAD~x~m \\ &&|&
     \text{i32.load8\_s}~~x{:}\Tmemidx~~m{:}\Tmemarg_1 &\Rightarrow& \I32.\LOAD\K{8\_s}~x~m \\ &&|&
     \text{i32.load8\_u}~~x{:}\Tmemidx~~m{:}\Tmemarg_1 &\Rightarrow& \I32.\LOAD\K{8\_u}~x~m \\ &&|&
     \text{i32.load16\_s}~~x{:}\Tmemidx~~m{:}\Tmemarg_2 &\Rightarrow& \I32.\LOAD\K{16\_s}~x~m \\ &&|&
     \text{i32.load16\_u}~~x{:}\Tmemidx~~m{:}\Tmemarg_2 &\Rightarrow& \I32.\LOAD\K{16\_u}~x~m \\ &&|&
     \text{i64.load8\_s}~~x{:}\Tmemidx~~m{:}\Tmemarg_1 &\Rightarrow& \I64.\LOAD\K{8\_s}~x~m \\ &&|&
     \text{i64.load8\_u}~~x{:}\Tmemidx~~m{:}\Tmemarg_1 &\Rightarrow& \I64.\LOAD\K{8\_u}~x~m \\ &&|&
     \text{i64.load16\_s}~~x{:}\Tmemidx~~m{:}\Tmemarg_2 &\Rightarrow& \I64.\LOAD\K{16\_s}~x~m \\ &&|&
     \text{i64.load16\_u}~~x{:}\Tmemidx~~m{:}\Tmemarg_2 &\Rightarrow& \I64.\LOAD\K{16\_u}~x~m \\ &&|&
     \text{i64.load32\_s}~~x{:}\Tmemidx~~m{:}\Tmemarg_4 &\Rightarrow& \I64.\LOAD\K{32\_s}~x~m \\ &&|&
     \text{i64.load32\_u}~~x{:}\Tmemidx~~m{:}\Tmemarg_4 &\Rightarrow& \I64.\LOAD\K{32\_u}~x~m \\ &&|&
     \text{v128.load8x8\_s}~~x{:}\Tmemidx~~m{:}\Tmemarg_8 &\Rightarrow& \V128.\LOAD\K{8x8\_s}~x~m \\ &&|&
     \text{v128.load8x8\_u}~~x{:}\Tmemidx~~m{:}\Tmemarg_8 &\Rightarrow& \V128.\LOAD\K{8x8\_u}~x~m \\ &&|&
     \text{v128.load16x4\_s}~~x{:}\Tmemidx~~m{:}\Tmemarg_8 &\Rightarrow& \V128.\LOAD\K{16x4\_s}~x~m \\ &&|&
     \text{v128.load16x4\_u}~~x{:}\Tmemidx~~m{:}\Tmemarg_8 &\Rightarrow& \V128.\LOAD\K{16x4\_u}~x~m \\ &&|&
     \text{v128.load32x2\_s}~~x{:}\Tmemidx~~m{:}\Tmemarg_8 &\Rightarrow& \V128.\LOAD\K{32x2\_s}~x~m \\ &&|&
     \text{v128.load32x2\_u}~~x{:}\Tmemidx~~m{:}\Tmemarg_8 &\Rightarrow& \V128.\LOAD\K{32x2\_u}~x~m \\ &&|&
     \text{v128.load8\_splat}~~x{:}\Tmemidx~~m{:}\Tmemarg_1 &\Rightarrow& \V128.\LOAD\K{8\_splat}~x~m \\ &&|&
     \text{v128.load16\_splat}~~x{:}\Tmemidx~~m{:}\Tmemarg_2 &\Rightarrow& \V128.\LOAD\K{16\_splat}~x~m \\ &&|&
     \text{v128.load32\_splat}~~x{:}\Tmemidx~~m{:}\Tmemarg_4 &\Rightarrow& \V128.\LOAD\K{32\_splat}~x~m \\ &&|&
     \text{v128.load64\_splat}~~x{:}\Tmemidx~~m{:}\Tmemarg_8 &\Rightarrow& \V128.\LOAD\K{64\_splat}~x~m \\ &&|&
     \text{v128.load32\_zero}~~x{:}\Tmemidx~~m{:}\Tmemarg_4 &\Rightarrow& \V128.\LOAD\K{32\_zero}~x~m \\ &&|&
     \text{v128.load64\_zero}~~x{:}\Tmemidx~~m{:}\Tmemarg_8 &\Rightarrow& \V128.\LOAD\K{64\_zero}~x~m \\ &&|&
     \text{v128.load8\_lane}~~x{:}\Tmemidx~~m{:}\Tmemarg_1~~y{:}\Tu8 &\Rightarrow& \V128.\LOAD\K{8\_lane}~x~m~y \\ &&|&
     \text{v128.load16\_lane}~~x{:}\Tmemidx~~m{:}\Tmemarg_2~~y{:}\Tu8 &\Rightarrow& \V128.\LOAD\K{16\_lane}~x~m~y \\ &&|&
     \text{v128.load32\_lane}~~x{:}\Tmemidx~~m{:}\Tmemarg_4~~y{:}\Tu8 &\Rightarrow& \V128.\LOAD\K{32\_lane}~x~m~y \\ &&|&
     \text{v128.load64\_lane}~~x{:}\Tmemidx~~m{:}\Tmemarg_8~~y{:}\Tu8 &\Rightarrow& \V128.\LOAD\K{64\_lane}~x~m~y \\ &&|&
     \text{i32.store}~~x{:}\Tmemidx~~m{:}\Tmemarg_4 &\Rightarrow& \I32.\STORE~x~m \\ &&|&
     \text{i64.store}~~x{:}\Tmemidx~~m{:}\Tmemarg_8 &\Rightarrow& \I64.\STORE~x~m \\ &&|&
     \text{f32.store}~~x{:}\Tmemidx~~m{:}\Tmemarg_4 &\Rightarrow& \F32.\STORE~x~m \\ &&|&
     \text{f64.store}~~x{:}\Tmemidx~~m{:}\Tmemarg_8 &\Rightarrow& \F64.\STORE~x~m \\ &&|&
     \text{v128.store}~~x{:}\Tmemidx~~m{:}\Tmemarg_{16} &\Rightarrow& \V128.\STORE~x~m \\ &&|&
     \text{i32.store8}~~x{:}\Tmemidx~~m{:}\Tmemarg_1 &\Rightarrow& \I32.\STORE\K{8}~x~m \\ &&|&
     \text{i32.store16}~~x{:}\Tmemidx~~m{:}\Tmemarg_2 &\Rightarrow& \I32.\STORE\K{16}~x~m \\ &&|&
     \text{i64.store8}~~x{:}\Tmemidx~~m{:}\Tmemarg_1 &\Rightarrow& \I64.\STORE\K{8}~x~m \\ &&|&
     \text{i64.store16}~~x{:}\Tmemidx~~m{:}\Tmemarg_2 &\Rightarrow& \I64.\STORE\K{16}~x~m \\ &&|&
     \text{i64.store32}~~x{:}\Tmemidx~~m{:}\Tmemarg_4 &\Rightarrow& \I64.\STORE\K{32}~x~m \\ &&|&
     \text{v128.store8\_lane}~~x{:}\Tmemidx~~m{:}\Tmemarg_1~~y{:}\Tu8 &\Rightarrow& \V128.\STORE\K{8\_lane}~x~m~y \\ &&|&
     \text{v128.store16\_lane}~~x{:}\Tmemidx~~m{:}\Tmemarg_2~~y{:}\Tu8 &\Rightarrow& \V128.\STORE\K{16\_lane}~x~m~y \\ &&|&
     \text{v128.store32\_lane}~~x{:}\Tmemidx~~m{:}\Tmemarg_4~~y{:}\Tu8 &\Rightarrow& \V128.\STORE\K{32\_lane}~x~m~y \\ &&|&
     \text{v128.store64\_lane}~~x{:}\Tmemidx~~m{:}\Tmemarg_8~~y{:}\Tu8 &\Rightarrow& \V128.\STORE\K{64\_lane}~x~m~y \\
     \text{memory.size}~~x{:}\Tmemidx &\Rightarrow& \MEMORYSIZE~x \\ &&|&
     \text{memory.grow}~~x{:}\Tmemidx &\Rightarrow& \MEMORYGROW~x \\ &&|&
     \text{memory.fill}~~x{:}\Tmemidx &\Rightarrow& \MEMORYFILL~x \\ &&|&
     \text{memory.copy}~~x{:}\Tmemidx~~y{:}\Tmemidx &\Rightarrow& \MEMORYCOPY~x~y \\ &&|&
     \text{memory.init}~~x{:}\Tmemidx~~y{:}\Tdataidx_I &\Rightarrow& \MEMORYINIT~x~y \\ &&|&
     \text{data.drop}~~x{:}\Tdataidx_I &\Rightarrow& \DATADROP~x \\
   \end{array}


Abbreviations
.............

As an abbreviation, the memory index can be omitted in all memory instructions, defaulting to :math:`\T{0}`.

.. math::
   \begin{array}{llclll}
   \production{instruction} &
    \Tnumtype\text{.load}~~\Tmemarg
       &\equiv&
     \Tnumtype\text{.load}~~\text{0}~~\Tmemarg \\&
    \Tvectype\text{.load}~~\Tmemarg
       &\equiv&
     \Tvectype\text{.load}~~\text{0}~~\Tmemarg \\&
    \Tnumtype\text{.load}N\text{\_}\sx~~\Tmemarg
       &\equiv&
     \Tnumtype\text{.load}N\text{\_}\sx~~\text{0}~~\Tmemarg \\&
    \Tvectype\text{.load}{N}\K{x}M\text{\_}\sx~~\Tmemarg
       &\equiv&
     \Tvectype\text{.load}{N}\K{x}M\text{\_}\sx~~\text{0}~~\Tmemarg \\&
    \Tvectype\text{.load}N\text{\_splat}~~\Tmemarg
       &\equiv&
     \Tvectype\text{.load}N\text{\_splat}~~\text{0}~~\Tmemarg \\&
    \Tvectype\text{.load}N\text{\_zero}~~\Tmemarg
       &\equiv&
     \Tvectype\text{.load}N\text{\_zero}~~\text{0}~~\Tmemarg \\&
    \Tvectype\text{.load}N\text{\_lane}~~\Tmemarg~~\Tu8
       &\equiv&
     \Tvectype\text{.load}N\text{\_lane}~~\text{0}~~\Tmemarg~~\Tu8 \\&
    \Tnumtype\text{.store}~~\Tmemarg
       &\equiv&
     \Tnumtype\text{.store}~~\text{0}~~\Tmemarg \\&
    \Tvectype\text{.store}~~\Tmemarg
       &\equiv&
     \Tvectype\text{.store}~~\text{0}~~\Tmemarg \\&
    \Tnumtype\text{.store}N~~\Tmemarg
       &\equiv&
     \Tnumtype\text{.store}N~~\text{0}~~\Tmemarg \\&
    \Tvectype\text{.store}N\text{\_lane}~~\Tmemarg~~\Tu8
       &\equiv&
     \Tvectype\text{.store}N\text{\_lane}~~\text{0}~~\Tmemarg~~\Tu8 \\&
    \text{memory.size}
       &\equiv&
     \text{memory.size}~~\text{0} \\&
    \text{memory.grow}
       &\equiv&
     \text{memory.grow}~~\text{0} \\&
    \text{memory.fill}
       &\equiv&
     \text{memory.fill}~~\text{0} \\&
    \text{memory.copy}
       &\equiv&
     \text{memory.copy}~~\text{0}~~\text{0} \\&
    \text{memory.init}~~x{:}\Telemidx_I
       &\equiv&
     \text{memory.init}~~\text{0}~~x{:}\Telemidx_I
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


.. index:: vector instruction
   pair: text format; instruction
.. _text-instr-vec:

Vector Instructions
~~~~~~~~~~~~~~~~~~~

Vector constant instructions have a mandatory :ref:`shape <syntax-vec-shape>` descriptor, which determines how the following values are parsed.

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallylonginstructionnames} \\[-2ex] &&|&
     \text{v128.const}~~\text{i8x16}~~(n{:}\Ti8)^{16} &\Rightarrow& \V128.\VCONST~\bytes_{i128}^{-1}(\bytes_{i8}(n)^{16}) \\ &&|&
     \text{v128.const}~~\text{i16x8}~~(n{:}\Ti16)^{8} &\Rightarrow& \V128.\VCONST~\bytes_{i128}^{-1}(\bytes_{i16}(n)^8) \\ &&|&
     \text{v128.const}~~\text{i32x4}~~(n{:}\Ti32)^{4} &\Rightarrow& \V128.\VCONST~\bytes_{i128}^{-1}(\bytes_{i32}(n)^4) \\ &&|&
     \text{v128.const}~~\text{i64x2}~~(n{:}\Ti64)^{2} &\Rightarrow& \V128.\VCONST~\bytes_{i128}^{-1}(\bytes_{i64}(n)^2) \\ &&|&
     \text{v128.const}~~\text{f32x4}~~(z{:}\Tf32)^{4} &\Rightarrow& \V128.\VCONST~\bytes_{i128}^{-1}(\bytes_{f32}(z)^4) \\ &&|&
     \text{v128.const}~~\text{f64x2}~~(z{:}\Tf64)^{2} &\Rightarrow& \V128.\VCONST~\bytes_{i128}^{-1}(\bytes_{f64}(z)^2)
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallylonginstructionnames} \\[-2ex] &&|&
     \text{i8x16.shuffle}~~(laneidx{:}\Tu8)^{16} &\Rightarrow& \I8X16.\SHUFFLE~laneidx^{16} \\ &&|&
     \text{i8x16.swizzle} &\Rightarrow& \I8X16.\SWIZZLE
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallylonginstructionnames} \\[-2ex] &&|&
     \text{i8x16.splat} &\Rightarrow& \I8X16.\SPLAT\\ &&|&
     \text{i16x8.splat} &\Rightarrow& \I16X8.\SPLAT\\ &&|&
     \text{i32x4.splat} &\Rightarrow& \I32X4.\SPLAT\\ &&|&
     \text{i64x2.splat} &\Rightarrow& \I64X2.\SPLAT\\ &&|&
     \text{f32x4.splat} &\Rightarrow& \F32X4.\SPLAT\\ &&|&
     \text{f64x2.splat} &\Rightarrow& \F64X2.\SPLAT\\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallylonginstructionnames} \\[-2ex] &&|&
     \text{i8x16.extract\_lane\_s}~~laneidx{:}\Tu8 &\Rightarrow& \I8X16.\EXTRACTLANE\K{\_s}~laneidx \\ &&|&
     \text{i8x16.extract\_lane\_u}~~laneidx{:}\Tu8 &\Rightarrow& \I8X16.\EXTRACTLANE\K{\_u}~laneidx \\ &&|&
     \text{i8x16.replace\_lane}~~laneidx{:}\Tu8 &\Rightarrow& \I8X16.\REPLACELANE~laneidx \\ &&|&
     \text{i16x8.extract\_lane\_s}~~laneidx{:}\Tu8 &\Rightarrow& \I16X8.\EXTRACTLANE\K{\_s}~laneidx \\ &&|&
     \text{i16x8.extract\_lane\_u}~~laneidx{:}\Tu8 &\Rightarrow& \I16X8.\EXTRACTLANE\K{\_u}~laneidx \\ &&|&
     \text{i16x8.replace\_lane}~~laneidx{:}\Tu8 &\Rightarrow& \I16X8.\REPLACELANE~laneidx \\ &&|&
     \text{i32x4.extract\_lane}~~laneidx{:}\Tu8 &\Rightarrow& \I32X4.\EXTRACTLANE~laneidx \\ &&|&
     \text{i32x4.replace\_lane}~~laneidx{:}\Tu8 &\Rightarrow& \I32X4.\REPLACELANE~laneidx \\ &&|&
     \text{i64x2.extract\_lane}~~laneidx{:}\Tu8 &\Rightarrow& \I64X2.\EXTRACTLANE~laneidx \\ &&|&
     \text{i64x2.replace\_lane}~~laneidx{:}\Tu8 &\Rightarrow& \I64X2.\REPLACELANE~laneidx \\ &&|&
     \text{f32x4.extract\_lane}~~laneidx{:}\Tu8 &\Rightarrow& \F32X4.\EXTRACTLANE~laneidx \\ &&|&
     \text{f32x4.replace\_lane}~~laneidx{:}\Tu8 &\Rightarrow& \F32X4.\REPLACELANE~laneidx \\ &&|&
     \text{f64x2.extract\_lane}~~laneidx{:}\Tu8 &\Rightarrow& \F64X2.\EXTRACTLANE~laneidx \\ &&|&
     \text{f64x2.replace\_lane}~~laneidx{:}\Tu8 &\Rightarrow& \F64X2.\REPLACELANE~laneidx \\
   \end{array}

.. _text-virelop:

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallylonginstructionnames} \\[-2ex] &&|&
     \text{i8x16.eq} &\Rightarrow& \I8X16.\VEQ\\ &&|&
     \text{i8x16.ne} &\Rightarrow& \I8X16.\VNE\\ &&|&
     \text{i8x16.lt\_s} &\Rightarrow& \I8X16.\VLT\K{\_s}\\ &&|&
     \text{i8x16.lt\_u} &\Rightarrow& \I8X16.\VLT\K{\_u}\\ &&|&
     \text{i8x16.gt\_s} &\Rightarrow& \I8X16.\VGT\K{\_s}\\ &&|&
     \text{i8x16.gt\_u} &\Rightarrow& \I8X16.\VGT\K{\_u}\\ &&|&
     \text{i8x16.le\_s} &\Rightarrow& \I8X16.\VLE\K{\_s}\\ &&|&
     \text{i8x16.le\_u} &\Rightarrow& \I8X16.\VLE\K{\_u}\\ &&|&
     \text{i8x16.ge\_s} &\Rightarrow& \I8X16.\VGE\K{\_s}\\ &&|&
     \text{i8x16.ge\_u} &\Rightarrow& \I8X16.\VGE\K{\_u}\\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallylonginstructionnames} \\[-2ex] &&|&
     \text{i16x8.eq} &\Rightarrow& \I16X8.\VEQ\\ &&|&
     \text{i16x8.ne} &\Rightarrow& \I16X8.\VNE\\ &&|&
     \text{i16x8.lt\_s} &\Rightarrow& \I16X8.\VLT\K{\_s}\\ &&|&
     \text{i16x8.lt\_u} &\Rightarrow& \I16X8.\VLT\K{\_u}\\ &&|&
     \text{i16x8.gt\_s} &\Rightarrow& \I16X8.\VGT\K{\_s}\\ &&|&
     \text{i16x8.gt\_u} &\Rightarrow& \I16X8.\VGT\K{\_u}\\ &&|&
     \text{i16x8.le\_s} &\Rightarrow& \I16X8.\VLE\K{\_s}\\ &&|&
     \text{i16x8.le\_u} &\Rightarrow& \I16X8.\VLE\K{\_u}\\ &&|&
     \text{i16x8.ge\_s} &\Rightarrow& \I16X8.\VGE\K{\_s}\\ &&|&
     \text{i16x8.ge\_u} &\Rightarrow& \I16X8.\VGE\K{\_u}\\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallylonginstructionnames} \\[-2ex] &&|&
     \text{i32x4.eq} &\Rightarrow& \I32X4.\VEQ\\ &&|&
     \text{i32x4.ne} &\Rightarrow& \I32X4.\VNE\\ &&|&
     \text{i32x4.lt\_s} &\Rightarrow& \I32X4.\VLT\K{\_s}\\ &&|&
     \text{i32x4.lt\_u} &\Rightarrow& \I32X4.\VLT\K{\_u}\\ &&|&
     \text{i32x4.gt\_s} &\Rightarrow& \I32X4.\VGT\K{\_s}\\ &&|&
     \text{i32x4.gt\_u} &\Rightarrow& \I32X4.\VGT\K{\_u}\\ &&|&
     \text{i32x4.le\_s} &\Rightarrow& \I32X4.\VLE\K{\_s}\\ &&|&
     \text{i32x4.le\_u} &\Rightarrow& \I32X4.\VLE\K{\_u}\\ &&|&
     \text{i32x4.ge\_s} &\Rightarrow& \I32X4.\VGE\K{\_s}\\ &&|&
     \text{i32x4.ge\_u} &\Rightarrow& \I32X4.\VGE\K{\_u}\\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallylonginstructionnames} \\[-2ex] &&|&
     \text{i64x2.eq} &\Rightarrow& \I64X2.\VEQ\\ &&|&
     \text{i64x2.ne} &\Rightarrow& \I64X2.\VNE\\ &&|&
     \text{i64x2.lt\_s} &\Rightarrow& \I64X2.\VLT\K{\_s}\\ &&|&
     \text{i64x2.gt\_s} &\Rightarrow& \I64X2.\VGT\K{\_s}\\ &&|&
     \text{i64x2.le\_s} &\Rightarrow& \I64X2.\VLE\K{\_s}\\ &&|&
     \text{i64x2.ge\_s} &\Rightarrow& \I64X2.\VGE\K{\_s}\\ &&|&
   \end{array}

.. _text-vfrelop:

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallylonginstructionnames} \\[-2ex] &&|&
     \text{f32x4.eq} &\Rightarrow& \F32X4.\VEQ\\ &&|&
     \text{f32x4.ne} &\Rightarrow& \F32X4.\VNE\\ &&|&
     \text{f32x4.lt} &\Rightarrow& \F32X4.\VLT\\ &&|&
     \text{f32x4.gt} &\Rightarrow& \F32X4.\VGT\\ &&|&
     \text{f32x4.le} &\Rightarrow& \F32X4.\VLE\\ &&|&
     \text{f32x4.ge} &\Rightarrow& \F32X4.\VGE\\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallylonginstructionnames} \\[-2ex] &&|&
     \text{f64x2.eq} &\Rightarrow& \F64X2.\VEQ\\ &&|&
     \text{f64x2.ne} &\Rightarrow& \F64X2.\VNE\\ &&|&
     \text{f64x2.lt} &\Rightarrow& \F64X2.\VLT\\ &&|&
     \text{f64x2.gt} &\Rightarrow& \F64X2.\VGT\\ &&|&
     \text{f64x2.le} &\Rightarrow& \F64X2.\VLE\\ &&|&
     \text{f64x2.ge} &\Rightarrow& \F64X2.\VGE\\
   \end{array}

.. _text-vvunop:
.. _text-vvbinop:
.. _text-vvternop:

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallylonginstructionnames} \\[-2ex] &&|&
     \text{v128.not} &\Rightarrow& \V128.\VNOT\\ &&|&
     \text{v128.and} &\Rightarrow& \V128.\VAND\\ &&|&
     \text{v128.andnot} &\Rightarrow& \V128.\VANDNOT\\ &&|&
     \text{v128.or} &\Rightarrow& \V128.\VOR\\ &&|&
     \text{v128.xor} &\Rightarrow& \V128.\VXOR\\ &&|&
     \text{v128.bitselect} &\Rightarrow& \V128.\BITSELECT\\ &&|&
     \text{v128.any\_true} &\Rightarrow& \V128.\ANYTRUE
   \end{array}

.. _text-vitestop:
.. _text-vishiftop:
.. _text-viunop:
.. _text-vibinop:
.. _text-viminmaxop:
.. _text-visatbinop:

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallylonginstructionnames} \\[-2ex] &&|&
     \text{i8x16.abs} &\Rightarrow& \I8X16.\VABS\\ &&|&
     \text{i8x16.neg} &\Rightarrow& \I8X16.\VNEG\\ &&|&
     \text{i8x16.all\_true} &\Rightarrow& \I8X16.\ALLTRUE\\ &&|&
     \text{i8x16.bitmask} &\Rightarrow& \I8X16.\BITMASK\\ &&|&
     \text{i8x16.narrow\_i16x8\_s} &\Rightarrow& \I8X16.\NARROW\K{\_i16x8\_s}\\ &&|&
     \text{i8x16.narrow\_i16x8\_u} &\Rightarrow& \I8X16.\NARROW\K{\_i16x8\_u}\\ &&|&
     \text{i8x16.shl} &\Rightarrow& \I8X16.\VSHL\\ &&|&
     \text{i8x16.shr\_s} &\Rightarrow& \I8X16.\VSHR\K{\_s}\\ &&|&
     \text{i8x16.shr\_u} &\Rightarrow& \I8X16.\VSHR\K{\_u}\\ &&|&
     \text{i8x16.add} &\Rightarrow& \I8X16.\VADD\\ &&|&
     \text{i8x16.add\_sat\_s} &\Rightarrow& \I8X16.\VADD\K{\_sat\_s}\\ &&|&
     \text{i8x16.add\_sat\_u} &\Rightarrow& \I8X16.\VADD\K{\_sat\_u}\\ &&|&
     \text{i8x16.sub} &\Rightarrow& \I8X16.\VSUB\\ &&|&
     \text{i8x16.sub\_sat\_s} &\Rightarrow& \I8X16.\VSUB\K{\_sat\_s}\\ &&|&
     \text{i8x16.sub\_sat\_u} &\Rightarrow& \I8X16.\VSUB\K{\_sat\_u}\\ &&|&
     \text{i8x16.min\_s} &\Rightarrow& \I8X16.\VMIN\K{\_s}\\ &&|&
     \text{i8x16.min\_u} &\Rightarrow& \I8X16.\VMIN\K{\_u}\\ &&|&
     \text{i8x16.max\_s} &\Rightarrow& \I8X16.\VMAX\K{\_s}\\ &&|&
     \text{i8x16.max\_u} &\Rightarrow& \I8X16.\VMAX\K{\_u}\\ &&|&
     \text{i8x16.avgr\_u} &\Rightarrow& \I8X16.\AVGR\K{\_u}\\ &&|&
     \text{i8x16.popcnt} &\Rightarrow& \I8X16.\VPOPCNT\\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallylonginstructionnames} \\[-2ex] &&|&
     \text{i16x8.abs} &\Rightarrow& \I16X8.\VABS\\ &&|&
     \text{i16x8.neg} &\Rightarrow& \I16X8.\VNEG\\ &&|&
     \text{i16x8.all\_true} &\Rightarrow& \I16X8.\ALLTRUE\\ &&|&
     \text{i16x8.bitmask} &\Rightarrow& \I16X8.\BITMASK\\ &&|&
     \text{i16x8.narrow\_i32x4\_s} &\Rightarrow& \I16X8.\NARROW\K{\_i32x4\_s}\\ &&|&
     \text{i16x8.narrow\_i32x4\_u} &\Rightarrow& \I16X8.\NARROW\K{\_i32x4\_u}\\ &&|&
     \text{i16x8.extend\_low\_i8x16\_s} &\Rightarrow& \I16X8.\VEXTEND\K{\_low\_i8x16\_s}\\ &&|&
     \text{i16x8.extend\_high\_i8x16\_s} &\Rightarrow& \I16X8.\VEXTEND\K{\_high\_i8x16\_s}\\ &&|&
     \text{i16x8.extend\_low\_i8x16\_u} &\Rightarrow& \I16X8.\VEXTEND\K{\_low\_i8x16\_u}\\ &&|&
     \text{i16x8.extend\_high\_i8x16\_u} &\Rightarrow& \I16X8.\VEXTEND\K{\_high\_i8x16\_u}\\ &&|&
     \text{i16x8.shl} &\Rightarrow& \I16X8.\VSHL\\ &&|&
     \text{i16x8.shr\_s} &\Rightarrow& \I16X8.\VSHR\K{\_s}\\ &&|&
     \text{i16x8.shr\_u} &\Rightarrow& \I16X8.\VSHR\K{\_u}\\ &&|&
     \text{i16x8.add} &\Rightarrow& \I16X8.\VADD\\ &&|&
     \text{i16x8.add\_sat\_s} &\Rightarrow& \I16X8.\VADD\K{\_sat\_s}\\ &&|&
     \text{i16x8.add\_sat\_u} &\Rightarrow& \I16X8.\VADD\K{\_sat\_u}\\ &&|&
     \text{i16x8.sub} &\Rightarrow& \I16X8.\VSUB\\ &&|&
     \text{i16x8.sub\_sat\_s} &\Rightarrow& \I16X8.\VSUB\K{\_sat\_s}\\ &&|&
     \text{i16x8.sub\_sat\_u} &\Rightarrow& \I16X8.\VSUB\K{\_sat\_u}\\ &&|&
     \text{i16x8.mul} &\Rightarrow& \I16X8.\VMUL\\ &&|&
     \text{i16x8.min\_s} &\Rightarrow& \I16X8.\VMIN\K{\_s}\\ &&|&
     \text{i16x8.min\_u} &\Rightarrow& \I16X8.\VMIN\K{\_u}\\ &&|&
     \text{i16x8.max\_s} &\Rightarrow& \I16X8.\VMAX\K{\_s}\\ &&|&
     \text{i16x8.max\_u} &\Rightarrow& \I16X8.\VMAX\K{\_u}\\ &&|&
     \text{i16x8.avgr\_u} &\Rightarrow& \I16X8.\AVGR\K{\_u}\\ &&|&
     \text{i16x8.q15mulr\_sat\_s} &\Rightarrow& \I16X8.\Q15MULRSAT\K{\_s}\\ &&|&
     \text{i16x8.extmul\_low\_i8x16\_s} &\Rightarrow& \I16X8.\EXTMUL\K{\_low\_i8x16\_s}\\ &&|&
     \text{i16x8.extmul\_high\_i8x16\_s} &\Rightarrow& \I16X8.\EXTMUL\K{\_high\_i8x16\_s}\\ &&|&
     \text{i16x8.extmul\_low\_i8x16\_u} &\Rightarrow& \I16X8.\EXTMUL\K{\_low\_i8x16\_u}\\ &&|&
     \text{i16x8.extmul\_high\_i8x16\_u} &\Rightarrow& \I16X8.\EXTMUL\K{\_high\_i8x16\_u}\\ &&|&
     \text{i16x8.extadd\_pairwise\_i8x16\_s} &\Rightarrow& \I16X8.\EXTADDPAIRWISE\K{\_i8x16\_s}\\ &&|&
     \text{i16x8.extadd\_pairwise\_i8x16\_u} &\Rightarrow& \I16X8.\EXTADDPAIRWISE\K{\_i8x16\_u}\\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallylonginstructionnames} \\[-2ex] &&|&
     \text{i32x4.abs} &\Rightarrow& \I32X4.\VABS\\ &&|&
     \text{i32x4.neg} &\Rightarrow& \I32X4.\VNEG\\ &&|&
     \text{i32x4.all\_true} &\Rightarrow& \I32X4.\ALLTRUE\\ &&|&
     \text{i32x4.bitmask} &\Rightarrow& \I32X4.\BITMASK\\ &&|&
     \text{i32x4.extadd\_pairwise\_i16x8\_s} &\Rightarrow& \I32X4.\EXTADDPAIRWISE\K{\_i16x8\_s}\\ &&|&
     \text{i32x4.extadd\_pairwise\_i16x8\_u} &\Rightarrow& \I32X4.\EXTADDPAIRWISE\K{\_i16x8\_u}\\ &&|&
     \text{i32x4.extend\_low\_i16x8\_s} &\Rightarrow& \I32X4.\VEXTEND\K{\_low\_i16x8\_s}\\ &&|&
     \text{i32x4.extend\_high\_i16x8\_s} &\Rightarrow& \I32X4.\VEXTEND\K{\_high\_i16x8\_s}\\ &&|&
     \text{i32x4.extend\_low\_i16x8\_u} &\Rightarrow& \I32X4.\VEXTEND\K{\_low\_i16x8\_u}\\ &&|&
     \text{i32x4.extend\_high\_i16x8\_u} &\Rightarrow& \I32X4.\VEXTEND\K{\_high\_i16x8\_u}\\ &&|&
     \text{i32x4.shl} &\Rightarrow& \I32X4.\VSHL\\ &&|&
     \text{i32x4.shr\_s} &\Rightarrow& \I32X4.\VSHR\K{\_s}\\ &&|&
     \text{i32x4.shr\_u} &\Rightarrow& \I32X4.\VSHR\K{\_u}\\ &&|&
     \text{i32x4.add} &\Rightarrow& \I32X4.\VADD\\ &&|&
     \text{i32x4.sub} &\Rightarrow& \I32X4.\VSUB\\ &&|&
     \text{i32x4.mul} &\Rightarrow& \I32X4.\VMUL\\ &&|&
     \text{i32x4.min\_s} &\Rightarrow& \I32X4.\VMIN\K{\_s}\\ &&|&
     \text{i32x4.min\_u} &\Rightarrow& \I32X4.\VMIN\K{\_u}\\ &&|&
     \text{i32x4.max\_s} &\Rightarrow& \I32X4.\VMAX\K{\_s}\\ &&|&
     \text{i32x4.max\_u} &\Rightarrow& \I32X4.\VMAX\K{\_u}\\ &&|&
     \text{i32x4.dot\_i16x8\_s} &\Rightarrow& \I32X4.\DOT\K{\_i16x8\_s}\\ &&|&
     \text{i32x4.extmul\_low\_i16x8\_s} &\Rightarrow& \I32X4.\EXTMUL\K{\_low\_i16x8\_s}\\ &&|&
     \text{i32x4.extmul\_high\_i16x8\_s} &\Rightarrow& \I32X4.\EXTMUL\K{\_high\_i16x8\_s}\\ &&|&
     \text{i32x4.extmul\_low\_i16x8\_u} &\Rightarrow& \I32X4.\EXTMUL\K{\_low\_i16x8\_u}\\ &&|&
     \text{i32x4.extmul\_high\_i16x8\_u} &\Rightarrow& \I32X4.\EXTMUL\K{\_high\_i16x8\_u}\\
  \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallylonginstructionnames} \\[-2ex] &&|&
     \text{i64x2.abs} &\Rightarrow& \I64X2.\VABS\\ &&|&
     \text{i64x2.neg} &\Rightarrow& \I64X2.\VNEG\\ &&|&
     \text{i64x2.all\_true} &\Rightarrow& \I64X2.\ALLTRUE\\ &&|&
     \text{i64x2.bitmask} &\Rightarrow& \I64X2.\BITMASK\\ &&|&
     \text{i64x2.extend\_low\_i32x4\_s} &\Rightarrow& \I64X2.\VEXTEND\K{\_low\_i32x4\_s} \\ &&|&
     \text{i64x2.extend\_high\_i32x4\_s} &\Rightarrow& \I64X2.\VEXTEND\K{\_high\_i32x4\_s} \\ &&|&
     \text{i64x2.extend\_low\_i32x4\_u} &\Rightarrow& \I64X2.\VEXTEND\K{\_low\_i32x4\_u} \\ &&|&
     \text{i64x2.extend\_high\_i32x4\_u} &\Rightarrow& \I64X2.\VEXTEND\K{\_high\_i32x4\_u} \\ &&|&
     \text{i64x2.shl} &\Rightarrow& \I64X2.\VSHL\\ &&|&
     \text{i64x2.shr\_s} &\Rightarrow& \I64X2.\VSHR\K{\_s}\\ &&|&
     \text{i64x2.shr\_u} &\Rightarrow& \I64X2.\VSHR\K{\_u}\\ &&|&
     \text{i64x2.add} &\Rightarrow& \I64X2.\VADD\\ &&|&
     \text{i64x2.sub} &\Rightarrow& \I64X2.\VSUB\\ &&|&
     \text{i64x2.mul} &\Rightarrow& \I64X2.\VMUL\\ &&|&
     \text{i64x2.extmul\_low\_i32x4\_s} &\Rightarrow& \I64X2.\EXTMUL\K{\_low\_i32x4\_s}\\ &&|&
     \text{i64x2.extmul\_high\_i32x4\_s} &\Rightarrow& \I64X2.\EXTMUL\K{\_high\_i32x4\_s}\\ &&|&
     \text{i64x2.extmul\_low\_i32x4\_u} &\Rightarrow& \I64X2.\EXTMUL\K{\_low\_i32x4\_u}\\ &&|&
     \text{i64x2.extmul\_high\_i32x4\_u} &\Rightarrow& \I64X2.\EXTMUL\K{\_high\_i32x4\_u}\\
  \end{array}

.. _text-vfunop:
.. _text-vfbinop:

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallylonginstructionnames} \\[-2ex] &&|&
     \text{f32x4.abs} &\Rightarrow& \F32X4.\VABS\\ &&|&
     \text{f32x4.neg} &\Rightarrow& \F32X4.\VNEG\\ &&|&
     \text{f32x4.sqrt} &\Rightarrow& \F32X4.\VSQRT\\ &&|&
     \text{f32x4.ceil} &\Rightarrow& \F32X4.\VCEIL\\ &&|&
     \text{f32x4.floor} &\Rightarrow& \F32X4.\VFLOOR\\ &&|&
     \text{f32x4.trunc} &\Rightarrow& \F32X4.\VTRUNC\\ &&|&
     \text{f32x4.nearest} &\Rightarrow& \F32X4.\VNEAREST\\ &&|&
     \text{f32x4.add} &\Rightarrow& \F32X4.\VADD\\ &&|&
     \text{f32x4.sub} &\Rightarrow& \F32X4.\VSUB\\ &&|&
     \text{f32x4.mul} &\Rightarrow& \F32X4.\VMUL\\ &&|&
     \text{f32x4.div} &\Rightarrow& \F32X4.\VDIV\\ &&|&
     \text{f32x4.min} &\Rightarrow& \F32X4.\VMIN\\ &&|&
     \text{f32x4.max} &\Rightarrow& \F32X4.\VMAX\\ &&|&
     \text{f32x4.pmin} &\Rightarrow& \F32X4.\VPMIN\\ &&|&
     \text{f32x4.pmax} &\Rightarrow& \F32X4.\VPMAX\\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallylonginstructionnames} \\[-2ex] &&|&
     \text{f64x2.abs} &\Rightarrow& \F64X2.\VABS\\ &&|&
     \text{f64x2.neg} &\Rightarrow& \F64X2.\VNEG\\ &&|&
     \text{f64x2.sqrt} &\Rightarrow& \F64X2.\VSQRT\\ &&|&
     \text{f64x2.ceil} &\Rightarrow& \F64X2.\VCEIL\\ &&|&
     \text{f64x2.floor} &\Rightarrow& \F64X2.\VFLOOR\\ &&|&
     \text{f64x2.trunc} &\Rightarrow& \F64X2.\VTRUNC\\ &&|&
     \text{f64x2.nearest} &\Rightarrow& \F64X2.\VNEAREST\\ &&|&
     \text{f64x2.add} &\Rightarrow& \F64X2.\VADD\\ &&|&
     \text{f64x2.sub} &\Rightarrow& \F64X2.\VSUB\\ &&|&
     \text{f64x2.mul} &\Rightarrow& \F64X2.\VMUL\\ &&|&
     \text{f64x2.div} &\Rightarrow& \F64X2.\VDIV\\ &&|&
     \text{f64x2.min} &\Rightarrow& \F64X2.\VMIN\\ &&|&
     \text{f64x2.max} &\Rightarrow& \F64X2.\VMAX\\ &&|&
     \text{f64x2.pmin} &\Rightarrow& \F64X2.\VPMIN\\ &&|&
     \text{f64x2.pmax} &\Rightarrow& \F64X2.\VPMAX\\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallylonginstructionnames} \\[-2ex] &&|&
     \text{i32x4.trunc\_sat\_f32x4\_s} &\Rightarrow& \I32X4.\VTRUNC\K{\_sat\_f32x4\_s}\\ &&|&
     \text{i32x4.trunc\_sat\_f32x4\_u} &\Rightarrow& \I32X4.\VTRUNC\K{\_sat\_f32x4\_u}\\ &&|&
     \text{i32x4.trunc\_sat\_f64x2\_s\_zero} &\Rightarrow& \I32X4.\VTRUNC\K{\_sat\_f64x2\_s\_zero}\\ &&|&
     \text{i32x4.trunc\_sat\_f64x2\_u\_zero} &\Rightarrow& \I32X4.\VTRUNC\K{\_sat\_f64x2\_u\_zero}\\ &&|&
     \text{f32x4.convert\_i32x4\_s} &\Rightarrow& \F32X4.\CONVERT\K{\_i32x4\_s}\\ &&|&
     \text{f32x4.convert\_i32x4\_u} &\Rightarrow& \F32X4.\CONVERT\K{\_i32x4\_u}\\ &&|&
     \text{f64x2.convert\_low\_i32x4\_s} &\Rightarrow& \F64X2.\VCONVERT\K{\_low\_i32x4\_s}\\  &&|&
     \text{f64x2.convert\_low\_i32x4\_u} &\Rightarrow& \F64X2.\VCONVERT\K{\_low\_i32x4\_u}\\ &&|&
     \text{f32x4.demote\_f64x2\_zero} &\Rightarrow& \F32X4.\VDEMOTE\K{\_f64x2\_zero}\\ &&|&
     \text{f64x2.promote\_low\_f32x4} &\Rightarrow& \F64X2.\VPROMOTE\K{\_low\_f32x4}\\
   \end{array}

.. math::
   \begin{array}{llclll}
   \phantom{\production{instruction}} & \phantom{\Tplaininstr_I} &\phantom{::=}& \phantom{averylonginstructionnameforvectext} && \phantom{vechasreallyreallyreallylonginstructionnames} \\[-2ex] &&|&
     \text{i16x8.relaxed\_swizzle} &\Rightarrow& \I16X8.\RELAXEDSWIZZLE \\ &&|&
     \text{i32x4.relaxed\_trunc\_f32x4\_s} &\Rightarrow& \I32X4.\RELAXEDTRUNC\K{\_f32x4\_s} \\ &&|&
     \text{i32x4.relaxed\_trunc\_f32x4\_u} &\Rightarrow& \I32X4.\RELAXEDTRUNC\K{\_f32x4\_u} \\ &&|&
     \text{i32x4.relaxed\_trunc\_f32x4\_s\_zero} &\Rightarrow& \I32X4.\RELAXEDTRUNC\K{\_f32x4\_s\_zero} \\ &&|&
     \text{i32x4.relaxed\_trunc\_f32x4\_u\_zero} &\Rightarrow& \I32X4.\RELAXEDTRUNC\K{\_f32x4\_u\_zero} \\ &&|&
     \text{f32x4.relaxed\_madd} &\Rightarrow& \F32X4.\RELAXEDMADD \\ &&|&
     \text{f32x4.relaxed\_nmadd} &\Rightarrow& \F32X4.\RELAXEDNMADD \\ &&|&
     \text{f64x2.relaxed\_madd} &\Rightarrow& \F64X2.\RELAXEDMADD \\ &&|&
     \text{f64x2.relaxed\_nmadd} &\Rightarrow& \F64X2.\RELAXEDNMADD \\ &&|&
     \text{i8x16.relaxed\_laneselect} &\Rightarrow& \I8X16.\RELAXEDLANESELECT \\ &&|&
     \text{i16x8.relaxed\_laneselect} &\Rightarrow& \I16X8.\RELAXEDLANESELECT \\ &&|&
     \text{i32x4.relaxed\_laneselect} &\Rightarrow& \I32X4.\RELAXEDLANESELECT \\ &&|&
     \text{i64x2.relaxed\_laneselect} &\Rightarrow& \I64X2.\RELAXEDLANESELECT \\ &&|&
     \text{f32x4.relaxed\_min} &\Rightarrow& \F32X4.\RELAXEDMIN \\ &&|&
     \text{f32x4.relaxed\_max} &\Rightarrow& \F32X4.\RELAXEDMAX \\ &&|&
     \text{f64x2.relaxed\_min} &\Rightarrow& \F64X2.\RELAXEDMIN \\ &&|&
     \text{f64x2.relaxed\_max} &\Rightarrow& \F64X2.\RELAXEDMAX \\ &&|&
     \text{i16x8.relaxed\_q15mulr\_s} &\Rightarrow& \I16X8.\RELAXEDQ15MULRS \\ &&|&
     \text{i16x8.relaxed\_dot\_i8x16\_i7x16\_s} &\Rightarrow& \I16X8.\RELAXEDDOT\K{\_i8x16\_i7x16\_s} \\ &&|&
     \text{i16x8.relaxed\_dot\_i8x16\_i7x16\_add\_s} &\Rightarrow& \I16X8.\RELAXEDDOT\K{\_i8x16\_i7x16\_add\_s}
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
       &\hspace{-3ex} \text{(}~\text{then}~~\Tinstr_1^\ast~\text{)}~~(\text{(}~\text{else}~~\Tinstr_2^\ast~\text{)})^?~~\text{)}
       \quad\equiv \\ &\qquad
       \Tfoldedinstr^\ast~~\text{if}~~\Tlabel
       &\hspace{-12ex} \Tblocktype~~\Tinstr_1^\ast~~\text{else}~~(\Tinstr_2^\ast)^?~\text{end} \\ &
     \text{(}~\text{try\_table}~~\Tlabel~~\Tblocktype~~\Tcatch^\ast~~\Tinstr^\ast~\text{)}
       \quad\equiv \\ &\qquad
       \text{try\_table}~~\Tlabel~~\Tblocktype~~\Tcatch^\ast~~\Tinstr^\ast~~\text{end} \\
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

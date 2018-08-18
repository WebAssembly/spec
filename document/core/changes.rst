Changes
=======

Changes since the previous `Working Draft <https://www.w3.org/TR/2018/WD-wasm-core-1-20180215>`_:

* :ref:`2.4.4 <syntax-instr-memory>`: Renamed :math:`\K{current\_memory}` -> |MEMORYSIZE|.
* :ref:`2.4.4 <syntax-instr-memory>`: Renamed :math:`\K{grow\_memory}` -> |MEMORYGROW|.
* :ref:`2.5.10 <syntax-export>`: Mutable globals may be exported.
* :ref:`2.5.11 <syntax-import>`: Clarified that import names need not be unique.
* :ref:`3.3.4.5 <valid-memory.size>`: Renamed :math:`\K{current\_memory}` -> |MEMORYSIZE|.
* :ref:`3.3.4.6 <valid-memory.grow>`: Renamed :math:`\K{grow\_memory}` -> |MEMORYGROW|.
* :ref:`3.3.7.2 <valid-constant>`: Clarified that |GETGLOBAL| in a constant expression can only refer to imported globals.
* :ref:`3.4.8.5 <valid-export>`: An exported global can be mutable.
* :ref:`3.4.9.5 <valid-import>`: An imported global can be mutable.
* :ref:`3.4.10 <valid-module>`: Fixed some typos, and added some clarification.
* :ref:`4.3.2.9 <op-irem_s>`: Fixed typo in formal text of |irems|: ":math:`j_1 * j_2 - \trunc(j_1 / j_2)`".
* :ref:`4.3.3.6 <op-fdiv>`: Fixed typo in text of |fdiv|: "Else return the result of dividing :math:`z_1` by :math:`z_2`...".
* :ref:`4.3.3.18 <op-fne>`: Fixed typo: |fne| returns :math:`1` if either operand is :math:`\NAN`.
* :ref:`4.4.1.2 <exec-unop>`: Fixed typo: ":math:`unop_t`".
* :ref:`4.4.1.3 <exec-binop>`: Fixed typo: ":math:`binop_t(c_1, c_2)`".
* :ref:`4.4.1.6 <exec-cvtop>`: Fixed typo: ":math:`(t_1.const~c_1)`".
* :ref:`4.4.4.3 <exec-memory.size>`: Renamed :math:`\K{current\_memory}` -> |MEMORYSIZE|.
* :ref:`4.4.4.4 <exec-memory.grow>`: Renamed :math:`\K{grow\_memory}` -> |MEMORYGROW|.
* :ref:`4.4.7.3 <exec-invoke-host>`: Allowed for divergence in host function invocation.
* :ref:`4.5.3.2 <alloc-hostfunc>`: Fixed typo: ":math:`s \compose \{\SFUNCS~\funcinst\}`".
* :ref:`5.2.4 <binary-utf8>`: Fixed utf8 encoding/decoding for 3- and 4-byte cases (:math:`b_1 - \hex{E0}` and :math:`b_1 - \hex{F0}`, respectively).
* :ref:`5.4.4 <binary-memory.size>`: Renamed :math:`\K{current\_memory}` -> |MEMORYSIZE|, renamed :math:`\K{grow\_memory}` -> |MEMORYGROW|.

* :ref:`6.3.3 <text-string>`: Fixed typo: ":math:`c \neq \text{"} \wedge c \neq \text{\backslash}`".
* :ref:`6.5.5 <text-memory.size>`: Renamed :math:`\K{current\_memory}` -> |MEMORYSIZE|, renamed :math:`\K{grow\_memory}` -> |MEMORYGROW|.
* :ref:`6.6.3 <text-typeuse>`: Fixed typo: ":math:`\{\ILOCALS~\F{id}(\Tparam)^\ast\} \idcwellformed)`".
* :ref:`6.6.6.1 <text-table-abbrev>`: Clarified offset is set to 0 in abbreviation.
* :ref:`6.6.7.1 <text-mem-abbrev>`: Clarified offset is set to 0 in abbreviation.
* :ref:`6.6.11 <text-elem>`: Moved optional table index to abbreviation section (6.6.11.1).
* :ref:`6.6.12 <text-data>`: Moved optional memory index to abbreviation section (6.6.12.1).
* :ref:`A.1.module_exports <embed-exports>`: Fixed typo: "equals the length of :math:`{\externtype'}^\ast`".
* :ref:`A.3.pop_ctrl <algo-valid>`: Changed to pop ctrl stack after pop_opds (since pop_opd accesses ctrl[0]).
* :ref:`A.3.validate <algo-valid>`: Fixed typo: "case (if t*) pop_opd(I32) ..."
* :ref:`A.5 <soundness>`: "... every :ref:`function <syntax-func>` :ref:`invocation <exec-invocation>` always evaluates to a result of the right type (if it does not :ref:`trap <trap>` or diverge)"
* :ref:`A.5."Host Function Instances" <valid-hostfuncinst>`: Allowed for host function divergence.
* :ref:`A.6 <index-type>`: Added Index of Types.
* :ref:`A.7 <index-instr>`: Added Index of Instructions.
* :ref:`A.8 <index-rules>`: Added Index of Semantic Rules.

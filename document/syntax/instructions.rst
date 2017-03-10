.. _syntax-sx:
.. _syntax-memop:
.. _syntax-instr:
.. index:: ! instruction
   pair: abstract syntax; instruction

Instructions
------------

.. todo::
    Describe

.. math::
   \begin{array}{llll}
   \production{width} & \X{nn}, \X{mm} &::=&
     \K{32} ~|~ \K{64} \\
   \production{signedness} & \sx &::=&
     \K{u} ~|~ \K{s} \\
   \production{memory operators} & \memop &::=&
     \{ \ALIGN~\u32, \OFFSET~\u32 \} \\
   \end{array}

.. math::
   \begin{array}{llll}
   \production{instructions} & \instr &::=&
     \K{unreachable} ~|~ \\&&&
     \K{nop} ~|~ \\&&&
     \K{block}~\resulttype~\instr^\ast~\END ~|~ \\&&&
     \K{loop}~\resulttype~\instr^\ast~\END ~|~ \\&&&
     \K{if}~\resulttype~\instr^\ast~\K{else}~\instr^\ast~\END ~|~ \\&&&
     \K{br}~\labelidx ~|~ \\&&&
     \K{br\_if}~\labelidx ~|~ \\&&&
     \K{br\_table}~\vec(\labelidx)~\labelidx ~|~ \\&&&
     \K{return} ~|~ \\&&&
     \K{call}~\funcidx ~|~ \\&&&
     \K{call\_indirect}~\typeidx ~|~ \\&&&
     \K{drop} ~|~ \\&&&
     \K{select} ~|~ \\&&&
     \K{get\_local}~\localidx ~|~ \\&&&
     \K{set\_local}~\localidx ~|~ \\&&&
     \K{tee\_local}~\localidx ~|~ \\&&&
     \K{get\_global}~\globalidx ~|~ \\&&&
     \K{set\_global}~\globalidx ~|~ \\&&&
     \K{i}\X{nn}\K{.load}~\memop ~|~
     \K{f}\X{nn}\K{.load}~\memop ~|~ \\&&&
     \K{i}\X{nn}\K{.store}~\memop ~|~
     \K{f}\X{nn}\K{.store}~\memop ~|~ \\&&&
     \K{i}\X{nn}\K{.load8\_}\sx~\memop ~|~ \\&&&
     \K{i}\X{nn}\K{.load16\_}\sx~\memop ~|~ \\&&&
     \K{i64.load32\_}\sx~\memop ~|~ \\&&&
     \K{i}\X{nn}\K{.store8}~\memop ~|~ \\&&&
     \K{i}\X{nn}\K{.store16}~\memop ~|~ \\&&&
     \K{i64.store32}~\memop ~|~ \\&&&
   \end{array}

.. math::
   \begin{array}{llll}
   \production{instructions} & \instr &::=& \dots \\&&&
     \K{i}\X{nn}\K{.const}~\iX{\X{nn}} ~|~
     \K{f}\X{nn}\K{.const}~\fX{\X{nn}} ~|~ \\&&&
     \K{i}\X{nn}\K{.eqz} ~|~ \\&&&
     \K{i}\X{nn}\K{.eq} ~|~
     \K{i}\X{nn}\K{.ne} ~|~
     \K{i}\X{nn}\K{.lt\_}\sx ~|~
     \K{i}\X{nn}\K{.gt\_}\sx ~|~
     \K{i}\X{nn}\K{.le\_}\sx ~|~
     \K{i}\X{nn}\K{.ge\_}\sx ~|~ \\&&&
     \K{f}\X{nn}\K{.eq} ~|~
     \K{f}\X{nn}\K{.ne} ~|~
     \K{f}\X{nn}\K{.lt} ~|~
     \K{f}\X{nn}\K{.gt} ~|~
     \K{f}\X{nn}\K{.le} ~|~
     \K{f}\X{nn}\K{.ge} ~|~ \\&&&
     \K{i}\X{nn}\K{.clz} ~|~
     \K{i}\X{nn}\K{.ctz} ~|~
     \K{i}\X{nn}\K{.popcnt} ~|~ \\&&&
     \K{i}\X{nn}\K{.add} ~|~
     \K{i}\X{nn}\K{.sub} ~|~
     \K{i}\X{nn}\K{.mul} ~|~
     \K{i}\X{nn}\K{.div\_}\sx ~|~
     \K{i}\X{nn}\K{.rem\_}\sx ~|~ \\&&&
     \K{i}\X{nn}\K{.and} ~|~
     \K{i}\X{nn}\K{.or} ~|~
     \K{i}\X{nn}\K{.xor} ~|~ \\&&&
     \K{i}\X{nn}\K{.shl} ~|~
     \K{i}\X{nn}\K{.shr\_}\sx ~|~
     \K{i}\X{nn}\K{.rotl} ~|~
     \K{i}\X{nn}\K{.rotr} ~|~ \\&&&
     \K{f}\X{nn}\K{.abs} ~|~
     \K{f}\X{nn}\K{.neg} ~|~
     \K{f}\X{nn}\K{.sqrt} ~|~ \\&&&
     \K{f}\X{nn}\K{.ceil} ~|~ 
     \K{f}\X{nn}\K{.floor} ~|~ 
     \K{f}\X{nn}\K{.trunc} ~|~ 
     \K{f}\X{nn}\K{.nearest} ~|~ \\&&&
     \K{f}\X{nn}\K{.add} ~|~
     \K{f}\X{nn}\K{.sub} ~|~
     \K{f}\X{nn}\K{.mul} ~|~
     \K{f}\X{nn}\K{.div} ~|~ \\&&&
     \K{f}\X{nn}\K{.min} ~|~
     \K{f}\X{nn}\K{.max} ~|~
     \K{f}\X{nn}\K{.copysign} ~|~ \\&&&
     \K{i32.wrap/i64} ~|~
     \K{i64.extend\_}\sx/\K{i32} ~|~
     \K{i}\X{nn}\K{.trunc\_}\sx/\K{f}\X{mm} ~|~ \\&&&
     \K{f32.demote/f64} ~|~
     \K{f64.promote/f32} ~|~
     \K{f}\X{nn}\K{.convert\_}\sx/\K{i}\X{mm} ~|~ \\&&&
     \K{i}\X{nn}\K{.reinterpret/f}\X{nn} ~|~
     \K{f}\X{nn}\K{.reinterpret/i}\X{nn} \\
   \end{array}

Wasm Formal Semantics
=====================

**Syntax**

$${definition: size}

$${syntax+:
  limits
  {globaltype
  functype
  tabletype
  memtype}
  {}
  externtype
}

$${syntax: {instr/block}}

$${syntax: {instr/num instr/local instr/global instr/memory} expr}



**Typing** ${relation: Instr_ok}

An instruction sequence ${:instr*} is well-typed with an instruction type ${functype: t_1* -> t_2*}, written ${:instr*} :math:`:` ${functype: t_1* -> t_2*}, according to the following rules:

$${rule:
  {Instrs_ok/empty Instrs_ok/seq}
  {Instrs_ok/frame}
}


$${rule: {Instr_ok/unreachable Instr_ok/nop Instr_ok/drop}}

$${rule+: Instr_ok/block}

$${rule+: Instr_ok/loop}

$${rule+: Instr_ok/if}


$${rule-ignore: Instr_ok/cvtop-*}


**Runtime**

$${definition: default_}

$${definition: {funcinst} {func table}}


**Reduction** ${relation: Step_pure}

The relation ${Step: config ~> config} checks that a function type is well-formed.

$${rule: Step/pure Step/read}

$${rule+: {Step_read/block Step_read/loop} {Step_pure/if-*}}

$${rule+: Step_pure/if-*}

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

$${syntax: {instr/control}}

$${syntax: {instr/numeric instr/local instr/global instr/memory} expr}



**Typing** ${relation: Instr_ok}

An instruction sequence ${:instr*} is well-typed with an instruction type ${: t_1* -> t_2*}, written ${: instr* : t_1* -> t_2*}, according to the following rules:

$${rule:
  {Instrs_ok/empty Instrs_ok/seq}
  {Instrs_ok/frame}
}


$${rule: {Instr_ok/unreachable Instr_ok/nop Instr_ok/drop}}

$${rule+: Instr_ok/block}

$${rule+: Instr_ok/loop}

$${rule+: Instr_ok/if}


**Runtime**

$${definition: default}

$${definition: {funcaddr funcinst} {func table}}


**Reduction** ${relation: Step_pure}

$${rule: Step/pure Step/read}

$${rule+: {Step_read/block Step_read/loop} {Step_pure/if-*}}

$${rule+: Step_pure/if-*}

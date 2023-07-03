Wasm Formal Semantics
=====================
**Reduction** ${relation: Step_pure}

$${rule: Step/pure Step/read}

$${rule+: {Step_pure/block Step_pure/loop} {Step_pure/if-*}}

$${rule+: Step_pure/if-*}

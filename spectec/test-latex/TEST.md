# Preview

```sh
$ (dune exec ../src/exe-watsup/main.exe -- ../spec/*.watsup -l -p -d spec-splice-in.tex -w)
== Parsing...
== Multiplicity checking...
== Elaboration...
== IL Validation...
== Latex Generation...
warning: syntax `E` was never spliced
warning: syntax `addr` was never spliced
warning: syntax `admininstr` was never spliced
warning: syntax `binop_numtype` was never spliced
warning: syntax `blocktype` was never spliced
warning: syntax `byte` was never spliced
warning: syntax `c_numtype` was never spliced
warning: syntax `c_vectype` was never spliced
warning: syntax `config` was never spliced
warning: syntax `context` was never spliced
warning: syntax `cvtop` was never spliced
warning: syntax `data` was never spliced
warning: syntax `dataaddr` was never spliced
warning: syntax `dataidx` was never spliced
warning: syntax `datainst` was never spliced
warning: syntax `datamode` was never spliced
warning: syntax `datatype` was never spliced
warning: syntax `elem` was never spliced
warning: syntax `elemaddr` was never spliced
warning: syntax `elemidx` was never spliced
warning: syntax `eleminst` was never spliced
warning: syntax `elemmode` was never spliced
warning: syntax `elemtype` was never spliced
warning: syntax `export` was never spliced
warning: syntax `exportinst` was never spliced
warning: syntax `externuse` was never spliced
warning: syntax `externval` was never spliced
warning: syntax `frame` was never spliced
warning: syntax `func` was never spliced
warning: syntax `funcaddr` was never spliced
warning: syntax `funcidx` was never spliced
warning: syntax `funcinst` was never spliced
warning: syntax `global` was never spliced
warning: syntax `globaladdr` was never spliced
warning: syntax `globalidx` was never spliced
warning: syntax `globalinst` was never spliced
warning: syntax `hostaddr` was never spliced
warning: syntax `idx` was never spliced
warning: syntax `import` was never spliced
warning: syntax `labeladdr` was never spliced
warning: syntax `labelidx` was never spliced
warning: syntax `localidx` was never spliced
warning: syntax `mem` was never spliced
warning: syntax `memaddr` was never spliced
warning: syntax `memidx` was never spliced
warning: syntax `meminst` was never spliced
warning: syntax `module` was never spliced
warning: syntax `moduleinst` was never spliced
warning: syntax `n` was never spliced
warning: syntax `name` was never spliced
warning: syntax `num` was never spliced
warning: syntax `ref` was never spliced
warning: syntax `relop_numtype` was never spliced
warning: syntax `result` was never spliced
warning: syntax `start` was never spliced
warning: syntax `state` was never spliced
warning: syntax `store` was never spliced
warning: syntax `sx` was never spliced
warning: syntax `table` was never spliced
warning: syntax `tableaddr` was never spliced
warning: syntax `tableidx` was never spliced
warning: syntax `tableinst` was never spliced
warning: syntax `testop_numtype` was never spliced
warning: syntax `u32` was never spliced
warning: syntax `unop_numtype` was never spliced
warning: syntax `val` was never spliced
warning: rule `Blocktype_ok` was never spliced
warning: rule `Expr_const` was never spliced
warning: rule `Externtype_sub/func` was never spliced
warning: rule `Externtype_sub/global` was never spliced
warning: rule `Externtype_sub/table` was never spliced
warning: rule `Externtype_sub/mem` was never spliced
warning: rule `Functype_ok` was never spliced
warning: rule `Functype_sub` was never spliced
warning: rule `Globaltype_ok` was never spliced
warning: rule `Globaltype_sub` was never spliced
warning: rule `InstrSeq_ok/empty` was spliced more than once
warning: rule `InstrSeq_ok/frame` was spliced more than once
warning: rule `Instr_const/const` was never spliced
warning: rule `Instr_const/ref.null` was never spliced
warning: rule `Instr_const/ref.func` was never spliced
warning: rule `Instr_const/global.get` was never spliced
warning: rule `Instr_ok/select-expl` was never spliced
warning: rule `Instr_ok/select-impl` was never spliced
warning: rule `Instr_ok/br` was never spliced
warning: rule `Instr_ok/br_if` was never spliced
warning: rule `Instr_ok/br_table` was never spliced
warning: rule `Instr_ok/return` was never spliced
warning: rule `Instr_ok/call` was never spliced
warning: rule `Instr_ok/call_indirect` was never spliced
warning: rule `Instr_ok/const` was never spliced
warning: rule `Instr_ok/unop` was never spliced
warning: rule `Instr_ok/binop` was never spliced
warning: rule `Instr_ok/testop` was never spliced
warning: rule `Instr_ok/relop` was never spliced
warning: rule `Limits_ok` was never spliced
warning: rule `Limits_sub` was never spliced
warning: rule `Memtype_ok` was never spliced
warning: rule `Memtype_sub` was never spliced
warning: rule `Resulttype_sub` was never spliced
warning: rule `Step_pure/unreachable` was never spliced
warning: rule `Step_pure/nop` was never spliced
warning: rule `Step_pure/drop` was never spliced
warning: rule `Step_pure/select-true` was never spliced
warning: rule `Step_pure/select-false` was never spliced
warning: rule `Step_pure/if-true` was spliced more than once
warning: rule `Step_pure/if-false` was spliced more than once
warning: rule `Step_pure/br-zero` was never spliced
warning: rule `Step_pure/br-succ` was never spliced
warning: rule `Step_pure/br_if-true` was never spliced
warning: rule `Step_pure/br_if-false` was never spliced
warning: rule `Step_pure/br_table-lt` was never spliced
warning: rule `Step_pure/br_table-le` was never spliced
warning: rule `Step_read/call` was never spliced
warning: rule `Step_read/call_indirect-call` was never spliced
warning: rule `Step_read/call_indirect-trap` was never spliced
warning: rule `Step_read/call_addr` was never spliced
warning: rule `Tabletype_ok` was never spliced
warning: rule `Tabletype_sub` was never spliced
warning: rule `Valtype_sub/refl` was never spliced
warning: rule `Valtype_sub/bot` was never spliced
warning: definition `default` was never spliced
warning: definition `func` was never spliced
warning: definition `funcaddr` was never spliced
warning: definition `funcinst` was never spliced
warning: definition `table` was never spliced
== Complete.
```

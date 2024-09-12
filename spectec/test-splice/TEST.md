# Preview

```sh
$ (../src/exe-watsup/main.exe ../spec/wasm-3.0/*.watsup -l --splice-latex -p spec-latex.in.tex -w)
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Translating to AL...
== Prose Generation...
../spec/wasm-3.0/6-typing.watsup:195.10-195.32: if_expr_to_instrs: Yet `$before(typeuse, x, i)`
../spec/wasm-3.0/6-typing.watsup:1378.9-1378.30: if_expr_to_instrs: Yet `$disjoint_(syntax name, nm*{nm <- `nm*`})`
== Splicing...
\documentclass[a4paper]{scrartcl}

\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{color}

\hyphenation{Web-Assembly}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\title{Wasm Formal Semantics}

\begin{document}

\small

\maketitle


\subsection*{Syntax}

$$
\begin{array}{@{}lcl@{}l@{}}
{|\mathsf{i{\scriptstyle 32}}|} &=& 32 \\
{|\mathsf{i{\scriptstyle 64}}|} &=& 64 \\
{|\mathsf{f{\scriptstyle 32}}|} &=& 32 \\
{|\mathsf{f{\scriptstyle 64}}|} &=& 64 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(limits)} & {\mathit{limits}} &::=& {}[ {\mathit{u{\kern-0.1em\scriptstyle 32}}} .. {\mathit{u{\kern-0.1em\scriptstyle 32}}} ] \\[0.8ex]
\mbox{(global type)} & {\mathit{globaltype}} &::=& {\mathsf{mut}^?}~{\mathit{valtype}} \\
\mbox{(function type)} & {\mathit{functype}} &::=& {\mathit{resulttype}} \rightarrow {\mathit{resulttype}} \\
\mbox{(table type)} & {\mathit{tabletype}} &::=& {\mathit{limits}}~{\mathit{reftype}} \\
\mbox{(memory type)} & {\mathit{memtype}} &::=& {\mathit{limits}}~\mathsf{page} \\[0.8ex]
{} \\[-2ex]
\mbox{(external type)} & {\mathit{externtype}} &::=& \mathsf{func}~{\mathit{typeuse}} ~|~ \mathsf{global}~{\mathit{globaltype}} ~|~ \mathsf{table}~{\mathit{tabletype}} ~|~ \mathsf{mem}~{\mathit{memtype}} ~|~ \mathsf{tag}~{\mathit{typeuse}} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrl@{}l@{}}
& {\mathit{instr}} &::=& \ldots \\ &&|&
\mathsf{block}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast} \\ &&|&
\mathsf{loop}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast} \\ &&|&
\mathsf{if}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast}~\mathsf{else}~{{\mathit{instr}}^\ast} \\ &&|&
\ldots \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrl@{}l@{}}
& {\mathit{instr}} &::=& \ldots \\ &&|&
{\mathit{numtype}}{.}\mathsf{const}~{{\mathit{num}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} {.} {{\mathit{unop}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} {.} {{\mathit{binop}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} {.} {{\mathit{testop}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} {.} {{\mathit{relop}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}}_1 {.} {{{\mathit{cvtop}}}_{{\mathit{numtype}}_2, {\mathit{numtype}}_1}}{\mathsf{\_}}{{\mathit{numtype}}_2} \\ &&|&
\mathsf{local{.}get}~{\mathit{localidx}} \\ &&|&
\mathsf{local{.}set}~{\mathit{localidx}} \\ &&|&
\mathsf{local{.}tee}~{\mathit{localidx}} \\ &&|&
\mathsf{global{.}get}~{\mathit{globalidx}} \\ &&|&
\mathsf{global{.}set}~{\mathit{globalidx}} \\ &&|&
{{\mathit{numtype}}{.}\mathsf{load}}{{{{\mathit{loadop}}}_{{\mathit{numtype}}}^?}}~{\mathit{memidx}}~{\mathit{memarg}} \\ &&|&
{{\mathit{numtype}}{.}\mathsf{store}}{{{\mathit{sz}}^?}}~{\mathit{memidx}}~{\mathit{memarg}} \\ &&|&
{{\mathit{vectype}}{.}\mathsf{load}}{{{{\mathit{vloadop}}}_{{\mathit{vectype}}}^?}}~{\mathit{memidx}}~{\mathit{memarg}} \\ &&|&
{{\mathit{vectype}}{.}\mathsf{load}}{{\mathit{sz}}}{\mathsf{\_}}{\mathsf{lane}}~{\mathit{memidx}}~{\mathit{memarg}}~{\mathit{laneidx}} \\ &&|&
{\mathit{vectype}}{.}\mathsf{store}~{\mathit{memidx}}~{\mathit{memarg}} \\ &&|&
{{\mathit{vectype}}{.}\mathsf{store}}{{\mathit{sz}}}{\mathsf{\_}}{\mathsf{lane}}~{\mathit{memidx}}~{\mathit{memarg}}~{\mathit{laneidx}} \\ &&|&
\mathsf{memory{.}size}~{\mathit{memidx}} \\ &&|&
\mathsf{memory{.}grow}~{\mathit{memidx}} \\ &&|&
\mathsf{memory{.}fill}~{\mathit{memidx}} \\ &&|&
\mathsf{memory{.}copy}~{\mathit{memidx}}~{\mathit{memidx}} \\ &&|&
\mathsf{memory{.}init}~{\mathit{memidx}}~{\mathit{dataidx}} \\ &&|&
\ldots \\[0.8ex]
& {\mathit{expr}} &::=& {{\mathit{instr}}^\ast} \\
\end{array}
$$


\subsection*{Typing $\boxed{{\mathit{context}} \vdash {\mathit{instr}} : {\mathit{instrtype}}}$}

An instruction sequence ${{\mathit{instr}}^\ast}$ is well-typed with an instruction type ${t_1^\ast} \rightarrow {t_2^\ast}$, written ${{\mathit{instr}}^\ast}$ $:$ ${t_1^\ast} \rightarrow {t_2^\ast}$, according to the following rules:

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \epsilon : \epsilon \rightarrow \epsilon
}
\qquad
\frac{
C \vdash {\mathit{instr}}_1 : {t_1^\ast} \rightarrow_{{x_1^\ast}} {t_2^\ast}
 \qquad
(C{.}\mathsf{locals}{}[x_1] = {\mathit{init}}~t)^\ast
 \qquad
C{}[{.}\mathsf{local}{}[{x_1^\ast}] = {(\mathsf{set}~t)^\ast}] \vdash {{\mathit{instr}}_2^\ast} : {t_2^\ast} \rightarrow_{{x_2^\ast}} {t_3^\ast}
}{
C \vdash {\mathit{instr}}_1~{{\mathit{instr}}_2^\ast} : {t_1^\ast} \rightarrow_{{x_1^\ast}~{x_2^\ast}} {t_3^\ast}
}
\\[3ex]\displaystyle
\frac{
C \vdash {{\mathit{instr}}^\ast} : {t_1^\ast} \rightarrow_{{x^\ast}} {t_2^\ast}
 \qquad
C \vdash {t^\ast} : \mathsf{ok}
}{
C \vdash {{\mathit{instr}}^\ast} : ({t^\ast}~{t_1^\ast}) \rightarrow_{{x^\ast}} ({t^\ast}~{t_2^\ast})
}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \epsilon : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr*{-}empty}]}
\\[3ex]\displaystyle
\frac{
C \vdash {{\mathit{instr}}^\ast} : {t_1^\ast} \rightarrow_{{x^\ast}} {t_2^\ast}
 \qquad
C \vdash {t^\ast} : \mathsf{ok}
}{
C \vdash {{\mathit{instr}}^\ast} : ({t^\ast}~{t_1^\ast}) \rightarrow_{{x^\ast}} ({t^\ast}~{t_2^\ast})
} \, {[\textsc{\scriptsize T{-}instr*{-}frame}]}
\\[3ex]\displaystyle
\frac{
}{
C \vdash \epsilon : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr*{-}empty}]}
\qquad
\frac{
C \vdash {{\mathit{instr}}^\ast} : {t_1^\ast} \rightarrow_{{x^\ast}} {t_2^\ast}
 \qquad
C \vdash {t^\ast} : \mathsf{ok}
}{
C \vdash {{\mathit{instr}}^\ast} : ({t^\ast}~{t_1^\ast}) \rightarrow_{{x^\ast}} ({t^\ast}~{t_2^\ast})
} \, {[\textsc{\scriptsize T{-}instr*{-}frame}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {t_1^\ast} \rightarrow {t_2^\ast} : \mathsf{ok}
}{
C \vdash \mathsf{unreachable} : {t_1^\ast} \rightarrow {t_2^\ast}
}
\qquad
\frac{
}{
C \vdash \mathsf{nop} : \epsilon \rightarrow \epsilon
}
\qquad
\frac{
C \vdash t : \mathsf{ok}
}{
C \vdash \mathsf{drop} : t \rightarrow \epsilon
}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{bt}} : {t_1^\ast} \rightarrow {t_2^\ast}
 \qquad
\{ \begin{array}[t]{@{}l@{}}
\mathsf{labels}~({t_2^\ast}) \}\end{array} \oplus C \vdash {{\mathit{instr}}^\ast} : {t_1^\ast} \rightarrow_{{x^\ast}} {t_2^\ast}
}{
C \vdash \mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}^\ast} : {t_1^\ast} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}block}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{bt}} : {t_1^\ast} \rightarrow {t_2^\ast}
 \qquad
\{ \begin{array}[t]{@{}l@{}}
\mathsf{labels}~({t_1^\ast}) \}\end{array} \oplus C \vdash {{\mathit{instr}}^\ast} : {t_1^\ast} \rightarrow_{{x^\ast}} {t_2^\ast}
}{
C \vdash \mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast} : {t_1^\ast} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}loop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{bt}} : {t_1^\ast} \rightarrow {t_2^\ast}
 \qquad
\{ \begin{array}[t]{@{}l@{}}
\mathsf{labels}~({t_2^\ast}) \}\end{array} \oplus C \vdash {{\mathit{instr}}_1^\ast} : {t_1^\ast} \rightarrow_{{x_1^\ast}} {t_2^\ast}
 \qquad
\{ \begin{array}[t]{@{}l@{}}
\mathsf{labels}~({t_2^\ast}) \}\end{array} \oplus C \vdash {{\mathit{instr}}_2^\ast} : {t_1^\ast} \rightarrow_{{x_2^\ast}} {t_2^\ast}
}{
C \vdash \mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_1^\ast}~\mathsf{else}~{{\mathit{instr}}_2^\ast} : {t_1^\ast}~\mathsf{i{\scriptstyle 32}} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}if}]}
\qquad
\end{array}
$$





\subsection*{Runtime}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{default}}}_{{\mathsf{i}}{N}} &=& ({\mathsf{i}}{N}{.}\mathsf{const}~0) \\
{{\mathrm{default}}}_{{\mathsf{f}}{N}} &=& ({\mathsf{f}}{N}{.}\mathsf{const}~{+0}) \\
{{\mathrm{default}}}_{{\mathsf{v}}{N}} &=& ({\mathsf{v}}{N}{.}\mathsf{const}~0) \\
{{\mathrm{default}}}_{\mathsf{ref}~\mathsf{null}~{\mathit{ht}}} &=& (\mathsf{ref{.}null}~{\mathit{ht}}) \\
{{\mathrm{default}}}_{\mathsf{ref}~{\mathit{ht}}} &=& \epsilon \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{funcs} &=& s{.}\mathsf{funcs} \\[0.8ex]
(s ; f){.}\mathsf{funcs}{}[x] &=& s{.}\mathsf{funcs}{}[f{.}\mathsf{module}{.}\mathsf{funcs}{}[x]] \\
(s ; f){.}\mathsf{tables}{}[x] &=& s{.}\mathsf{tables}{}[f{.}\mathsf{module}{.}\mathsf{tables}{}[x]] \\
\end{array}
$$


\subsection*{Reduction $\boxed{{{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}}^\ast}}$}

The relation ${\mathit{config}} \hookrightarrow {\mathit{config}}$ checks that a function type is well-formed.

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
& z ; {{\mathit{instr}}^\ast} &\hookrightarrow& z ; {{\mathit{instr}'}^\ast}
  &\qquad \mbox{if}~{{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\[0.8ex]
& z ; {{\mathit{instr}}^\ast} &\hookrightarrow& z ; {{\mathit{instr}'}^\ast}
  &\qquad \mbox{if}~z ; {{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}block}]} \quad & z ; {{\mathit{val}}^{m}}~(\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{n}}{\{ \epsilon \}}~{{\mathit{val}}^{m}}~{{\mathit{instr}}^\ast})
  &\qquad \mbox{if}~{{\mathrm{blocktype}}}_{z}({\mathit{bt}}) = {t_1^{m}} \rightarrow {t_2^{n}} \\
{[\textsc{\scriptsize E{-}loop}]} \quad & z ; {{\mathit{val}}^{m}}~(\mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{m}}{\{ \mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast} \}}~{{\mathit{val}}^{m}}~{{\mathit{instr}}^\ast})
  &\qquad \mbox{if}~{{\mathrm{blocktype}}}_{z}({\mathit{bt}}) = {t_1^{m}} \rightarrow {t_2^{n}} \\[0.8ex]
{[\textsc{\scriptsize E{-}if{-}true}]} \quad & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)~(\mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_1^\ast}~\mathsf{else}~{{\mathit{instr}}_2^\ast}) &\hookrightarrow& (\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}_1^\ast})
  &\qquad \mbox{if}~c \neq 0 \\
{[\textsc{\scriptsize E{-}if{-}false}]} \quad & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)~(\mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_1^\ast}~\mathsf{else}~{{\mathit{instr}}_2^\ast}) &\hookrightarrow& (\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}_2^\ast})
  &\qquad \mbox{if}~c = 0 \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}if{-}true}]} \quad & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)~(\mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_1^\ast}~\mathsf{else}~{{\mathit{instr}}_2^\ast}) &\hookrightarrow& (\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}_1^\ast})
  &\qquad \mbox{if}~c \neq 0 \\[0.8ex]
{[\textsc{\scriptsize E{-}if{-}false}]} \quad & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)~(\mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_1^\ast}~\mathsf{else}~{{\mathit{instr}}_2^\ast}) &\hookrightarrow& (\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}_2^\ast})
  &\qquad \mbox{if}~c = 0 \\
\end{array}
$$

\end{document}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

warning: syntax `A` was never spliced
warning: syntax `B` was never spliced
warning: syntax `Cnn` was never spliced
warning: syntax `Fnn` was never spliced
warning: syntax `Inn` was never spliced
warning: syntax `Jnn` was never spliced
warning: syntax `K` was never spliced
warning: syntax `Lnn` was never spliced
warning: syntax `M` was never spliced
warning: syntax `N` was never spliced
warning: syntax `Pnn` was never spliced
warning: syntax `T` was never spliced
warning: syntax `Vnn` was never spliced
warning: syntax `absheaptype/syn` was never spliced
warning: syntax `absheaptype/sem` was never spliced
warning: syntax `addr` was never spliced
warning: syntax `addrref` was never spliced
warning: syntax `arrayaddr` was never spliced
warning: syntax `arrayinst` was never spliced
warning: syntax `arraytype` was never spliced
warning: syntax `binop_` was never spliced
warning: syntax `binop_` was never spliced
warning: syntax `bit` was never spliced
warning: syntax `blocktype` was never spliced
warning: syntax `byte` was never spliced
warning: syntax `callframe` was never spliced
warning: syntax `castop` was never spliced
warning: syntax `catch` was never spliced
warning: syntax `char` was never spliced
warning: syntax `code` was never spliced
warning: syntax `comptype` was never spliced
warning: syntax `config` was never spliced
warning: syntax `consttype` was never spliced
warning: syntax `context` was never spliced
warning: syntax `cvtop__` was never spliced
warning: syntax `cvtop__` was never spliced
warning: syntax `cvtop__` was never spliced
warning: syntax `cvtop__` was never spliced
warning: syntax `data` was never spliced
warning: syntax `dataaddr` was never spliced
warning: syntax `dataidx` was never spliced
warning: syntax `datainst` was never spliced
warning: syntax `datamode` was never spliced
warning: syntax `datatype` was never spliced
warning: syntax `deftype` was never spliced
warning: syntax `dim` was never spliced
warning: syntax `elem` was never spliced
warning: syntax `elemaddr` was never spliced
warning: syntax `elemidx` was never spliced
warning: syntax `eleminst` was never spliced
warning: syntax `elemmode` was never spliced
warning: syntax `elemtype` was never spliced
warning: syntax `exnaddr` was never spliced
warning: syntax `exninst` was never spliced
warning: syntax `export` was never spliced
warning: syntax `exportinst` was never spliced
warning: syntax `externaddr` was never spliced
warning: syntax `externidx` was never spliced
warning: syntax `f32` was never spliced
warning: syntax `f64` was never spliced
warning: syntax `fN` was never spliced
warning: syntax `fNmag` was never spliced
warning: syntax `fieldidx` was never spliced
warning: syntax `fieldtype` was never spliced
warning: syntax `fieldval` was never spliced
warning: syntax `fin` was never spliced
warning: syntax `frame` was never spliced
warning: syntax `free` was never spliced
warning: syntax `fshape` was never spliced
warning: syntax `func` was never spliced
warning: syntax `funcaddr` was never spliced
warning: syntax `funccode` was never spliced
warning: syntax `funcidx` was never spliced
warning: syntax `funcinst` was never spliced
warning: syntax `global` was never spliced
warning: syntax `globaladdr` was never spliced
warning: syntax `globalidx` was never spliced
warning: syntax `globalinst` was never spliced
warning: syntax `half__` was never spliced
warning: syntax `half__` was never spliced
warning: syntax `heaptype` was never spliced
warning: syntax `hostaddr` was never spliced
warning: syntax `hostfunc` was never spliced
warning: syntax `iN` was never spliced
warning: syntax `idx` was never spliced
warning: syntax `import` was never spliced
warning: syntax `init` was never spliced
warning: syntax `instr/parametric` was never spliced
warning: syntax `instr/br` was never spliced
warning: syntax `instr/call` was never spliced
warning: syntax `instr/exn` was never spliced
warning: syntax `instr/vec` was never spliced
warning: syntax `instr/ref` was never spliced
warning: syntax `instr/func` was never spliced
warning: syntax `instr/i31` was never spliced
warning: syntax `instr/struct` was never spliced
warning: syntax `instr/array` was never spliced
warning: syntax `instr/extern` was never spliced
warning: syntax `instr/table` was never spliced
warning: syntax `instr/elem` was never spliced
warning: syntax `instr/data` was never spliced
warning: syntax `instr/admin` was never spliced
warning: syntax `instrtype` was never spliced
warning: syntax `ishape` was never spliced
warning: syntax `label` was never spliced
warning: syntax `labelidx` was never spliced
warning: syntax `lane_` was never spliced
warning: syntax `lane_` was never spliced
warning: syntax `lane_` was never spliced
warning: syntax `laneidx` was never spliced
warning: syntax `lanetype` was never spliced
warning: syntax `list` was never spliced
warning: syntax `lit_` was never spliced
warning: syntax `lit_` was never spliced
warning: syntax `lit_` was never spliced
warning: syntax `loadop_` was never spliced
warning: syntax `local` was never spliced
warning: syntax `localidx` was never spliced
warning: syntax `localtype` was never spliced
warning: syntax `m` was never spliced
warning: syntax `mem` was never spliced
warning: syntax `memaddr` was never spliced
warning: syntax `memarg` was never spliced
warning: syntax `memidx` was never spliced
warning: syntax `memidxop` was never spliced
warning: syntax `meminst` was never spliced
warning: syntax `module` was never spliced
warning: syntax `moduleinst` was never spliced
warning: syntax `moduletype` was never spliced
warning: syntax `mut` was never spliced
warning: syntax `mut1` was never spliced
warning: syntax `mut2` was never spliced
warning: syntax `n` was never spliced
warning: syntax `name` was never spliced
warning: syntax `nonfuncs` was never spliced
warning: syntax `nopt` was never spliced
warning: syntax `nul` was never spliced
warning: syntax `nul1` was never spliced
warning: syntax `nul2` was never spliced
warning: syntax `num` was never spliced
warning: syntax `num_` was never spliced
warning: syntax `num_` was never spliced
warning: syntax `numtype` was never spliced
warning: syntax `oktypeidx` was never spliced
warning: syntax `oktypeidxnat` was never spliced
warning: syntax `pack_` was never spliced
warning: syntax `packtype` was never spliced
warning: syntax `packval` was never spliced
warning: syntax `pshape` was never spliced
warning: syntax `pth` was never spliced
warning: syntax `record` was never spliced
warning: syntax `recorddots` was never spliced
warning: syntax `rectype` was never spliced
warning: syntax `ref` was never spliced
warning: syntax `reftype` was never spliced
warning: syntax `relop_` was never spliced
warning: syntax `relop_` was never spliced
warning: syntax `result` was never spliced
warning: syntax `resulttype` was never spliced
warning: syntax `s33` was never spliced
warning: syntax `sN` was never spliced
warning: syntax `shape` was never spliced
warning: syntax `start` was never spliced
warning: syntax `startopt` was never spliced
warning: syntax `state` was never spliced
warning: syntax `storagetype` was never spliced
warning: syntax `store` was never spliced
warning: syntax `structaddr` was never spliced
warning: syntax `structinst` was never spliced
warning: syntax `structtype` was never spliced
warning: syntax `subtype` was never spliced
warning: syntax `sx` was never spliced
warning: syntax `sym` was never spliced
warning: syntax `symdots` was never spliced
warning: syntax `symsplit/1` was never spliced
warning: syntax `symsplit/2` was never spliced
warning: syntax `sz` was never spliced
warning: syntax `table` was never spliced
warning: syntax `tableaddr` was never spliced
warning: syntax `tableidx` was never spliced
warning: syntax `tableinst` was never spliced
warning: syntax `tag` was never spliced
warning: syntax `tagaddr` was never spliced
warning: syntax `tagidx` was never spliced
warning: syntax `taginst` was never spliced
warning: syntax `tagtype` was never spliced
warning: syntax `testop_` was never spliced
warning: syntax `type` was never spliced
warning: syntax `typeidx` was never spliced
warning: syntax `typeuse/syn` was never spliced
warning: syntax `typeuse/sem` was never spliced
warning: syntax `typevar` was never spliced
warning: syntax `u128` was never spliced
warning: syntax `u16` was never spliced
warning: syntax `u31` was never spliced
warning: syntax `u32` was never spliced
warning: syntax `u64` was never spliced
warning: syntax `u8` was never spliced
warning: syntax `uN` was never spliced
warning: syntax `unop_` was never spliced
warning: syntax `unop_` was never spliced
warning: syntax `vN` was never spliced
warning: syntax `val` was never spliced
warning: syntax `valtype/syn` was never spliced
warning: syntax `valtype/sem` was never spliced
warning: syntax `vbinop_` was never spliced
warning: syntax `vbinop_` was never spliced
warning: syntax `vcvtop__` was never spliced
warning: syntax `vcvtop__` was never spliced
warning: syntax `vcvtop__` was never spliced
warning: syntax `vcvtop__` was never spliced
warning: syntax `vec` was never spliced
warning: syntax `vec_` was never spliced
warning: syntax `vectype` was never spliced
warning: syntax `vextbinop__` was never spliced
warning: syntax `vextunop__` was never spliced
warning: syntax `vloadop_` was never spliced
warning: syntax `vrelop_` was never spliced
warning: syntax `vrelop_` was never spliced
warning: syntax `vshiftop_` was never spliced
warning: syntax `vtestop_` was never spliced
warning: syntax `vunop_` was never spliced
warning: syntax `vunop_` was never spliced
warning: syntax `vvbinop` was never spliced
warning: syntax `vvternop` was never spliced
warning: syntax `vvtestop` was never spliced
warning: syntax `vvunop` was never spliced
warning: syntax `zero__` was never spliced
warning: grammar `Babsheaptype` was never spliced
warning: grammar `Bblocktype` was never spliced
warning: grammar `Bbyte` was never spliced
warning: grammar `Bcastop` was never spliced
warning: grammar `Bcatch` was never spliced
warning: grammar `Bcode` was never spliced
warning: grammar `Bcodesec` was never spliced
warning: grammar `Bcomptype` was never spliced
warning: grammar `Bcustom` was never spliced
warning: grammar `Bcustomsec` was never spliced
warning: grammar `Bdata` was never spliced
warning: grammar `Bdatacnt` was never spliced
warning: grammar `Bdatacntsec` was never spliced
warning: grammar `Bdataidx` was never spliced
warning: grammar `Bdatasec` was never spliced
warning: grammar `Belem` was never spliced
warning: grammar `Belemidx` was never spliced
warning: grammar `Belemkind` was never spliced
warning: grammar `Belemsec` was never spliced
warning: grammar `Bexport` was never spliced
warning: grammar `Bexportsec` was never spliced
warning: grammar `Bexpr` was never spliced
warning: grammar `Bexternidx` was never spliced
warning: grammar `Bexterntype` was never spliced
warning: grammar `Bf32` was never spliced
warning: grammar `Bf64` was never spliced
warning: grammar `BfN` was never spliced
warning: grammar `Bfieldtype` was never spliced
warning: grammar `Bfunc` was never spliced
warning: grammar `Bfuncidx` was never spliced
warning: grammar `Bfuncsec` was never spliced
warning: grammar `Bglobal` was never spliced
warning: grammar `Bglobalidx` was never spliced
warning: grammar `Bglobalsec` was never spliced
warning: grammar `Bglobaltype` was never spliced
warning: grammar `Bheaptype` was never spliced
warning: grammar `BiN` was never spliced
warning: grammar `Bimport` was never spliced
warning: grammar `Bimportsec` was never spliced
warning: grammar `Binstr/control` was never spliced
warning: grammar `Binstr/ref` was never spliced
warning: grammar `Binstr/struct` was never spliced
warning: grammar `Binstr/array` was never spliced
warning: grammar `Binstr/cast` was never spliced
warning: grammar `Binstr/extern` was never spliced
warning: grammar `Binstr/i31` was never spliced
warning: grammar `Binstr/parametric` was never spliced
warning: grammar `Binstr/local` was never spliced
warning: grammar `Binstr/global` was never spliced
warning: grammar `Binstr/table` was never spliced
warning: grammar `Binstr/memory` was never spliced
warning: grammar `Binstr/num-const` was never spliced
warning: grammar `Binstr/num-test-i32` was never spliced
warning: grammar `Binstr/num-rel-i32` was never spliced
warning: grammar `Binstr/num-test-i64` was never spliced
warning: grammar `Binstr/num-rel-i64` was never spliced
warning: grammar `Binstr/num-rel-f32` was never spliced
warning: grammar `Binstr/num-rel-f64` was never spliced
warning: grammar `Binstr/num-un-i32` was never spliced
warning: grammar `Binstr/num-bin-i32` was never spliced
warning: grammar `Binstr/num-un-i64` was never spliced
warning: grammar `Binstr/num-un-ext-i32` was never spliced
warning: grammar `Binstr/num-un-ext-i64` was never spliced
warning: grammar `Binstr/num-bin-i64` was never spliced
warning: grammar `Binstr/num-un-f32` was never spliced
warning: grammar `Binstr/num-bin-f32` was never spliced
warning: grammar `Binstr/num-un-f64` was never spliced
warning: grammar `Binstr/num-bin-f64` was never spliced
warning: grammar `Binstr/num-cvt` was never spliced
warning: grammar `Binstr/num-cvt-sat` was never spliced
warning: grammar `Binstr/vec-memory` was never spliced
warning: grammar `Binstr/vec-const` was never spliced
warning: grammar `Binstr/vec-shuffle` was never spliced
warning: grammar `Binstr/vec-splat` was never spliced
warning: grammar `Binstr/vec-lane` was never spliced
warning: grammar `Binstr/vec-rel-i8x16` was never spliced
warning: grammar `Binstr/vec-rel-i16x8` was never spliced
warning: grammar `Binstr/vec-rel-i32x4` was never spliced
warning: grammar `Binstr/vec-rel-f32x4` was never spliced
warning: grammar `Binstr/vec-rel-f64x2` was never spliced
warning: grammar `Binstr/vec-un-v128` was never spliced
warning: grammar `Binstr/vec-bin-v128` was never spliced
warning: grammar `Binstr/vec-tern-v128` was never spliced
warning: grammar `Binstr/vec-test-v128` was never spliced
warning: grammar `Binstr/vec-un-i8x16` was never spliced
warning: grammar `Binstr/vec-test-i8x16` was never spliced
warning: grammar `Binstr/vec-bitmask-i8x16` was never spliced
warning: grammar `Binstr/vec-narrow-i8x16` was never spliced
warning: grammar `Binstr/vec-shift-i8x16` was never spliced
warning: grammar `Binstr/vec-bin-i8x16` was never spliced
warning: grammar `Binstr/vec-extun-i16x8` was never spliced
warning: grammar `Binstr/vec-un-i16x8` was never spliced
warning: grammar `Binstr/vec-bin-i16x8` was never spliced
warning: grammar `Binstr/vec-test-i16x8` was never spliced
warning: grammar `Binstr/vec-bitmask-i16x8` was never spliced
warning: grammar `Binstr/vec-narrow-i16x8` was never spliced
warning: grammar `Binstr/vec-ext-i16x8` was never spliced
warning: grammar `Binstr/vec-shift-i16x8` was never spliced
warning: grammar `Binstr/vec-bin-i16x8` was never spliced
warning: grammar `Binstr/vec-extbin-i16x8` was never spliced
warning: grammar `Binstr/vec-extun-i32x4` was never spliced
warning: grammar `Binstr/vec-un-i32x4` was never spliced
warning: grammar `Binstr/vec-test-i32x4` was never spliced
warning: grammar `Binstr/vec-bitmask-i32x4` was never spliced
warning: grammar `Binstr/vec-ext-i32x4` was never spliced
warning: grammar `Binstr/vec-shift-i32x4` was never spliced
warning: grammar `Binstr/vec-bin-i32x4` was never spliced
warning: grammar `Binstr/vec-extbin-i32x4` was never spliced
warning: grammar `Binstr/vec-un-i64x2` was never spliced
warning: grammar `Binstr/vec-test-i64x2` was never spliced
warning: grammar `Binstr/vec-bitmask-i64x2` was never spliced
warning: grammar `Binstr/vec-ext-i64x2` was never spliced
warning: grammar `Binstr/vec-shift-i64x2` was never spliced
warning: grammar `Binstr/vec-bin-i64x2` was never spliced
warning: grammar `Binstr/vec-rel-i64x2` was never spliced
warning: grammar `Binstr/vec-extbin-i64x2` was never spliced
warning: grammar `Binstr/vec-un-f32x4` was never spliced
warning: grammar `Binstr/vec-bin-f32x4` was never spliced
warning: grammar `Binstr/vec-un-f64x2` was never spliced
warning: grammar `Binstr/vec-bin-f64x2` was never spliced
warning: grammar `Binstr/vec-cvt` was never spliced
warning: grammar `Blabelidx` was never spliced
warning: grammar `Blaneidx` was never spliced
warning: grammar `Blimits` was never spliced
warning: grammar `Blist` was never spliced
warning: grammar `Blocalidx` was never spliced
warning: grammar `Blocals` was never spliced
warning: grammar `Bmagic` was never spliced
warning: grammar `Bmem` was never spliced
warning: grammar `Bmemarg` was never spliced
warning: grammar `Bmemidx` was never spliced
warning: grammar `Bmemsec` was never spliced
warning: grammar `Bmemtype` was never spliced
warning: grammar `Bmodule` was never spliced
warning: grammar `Bmut` was never spliced
warning: grammar `Bname` was never spliced
warning: grammar `Bnumtype` was never spliced
warning: grammar `Bpacktype` was never spliced
warning: grammar `Brectype` was never spliced
warning: grammar `Breftype` was never spliced
warning: grammar `Bresulttype` was never spliced
warning: grammar `Bs33` was never spliced
warning: grammar `BsN` was never spliced
warning: grammar `Bsection_` was never spliced
warning: grammar `Bstart` was never spliced
warning: grammar `Bstartsec` was never spliced
warning: grammar `Bstoragetype` was never spliced
warning: grammar `Bsubtype` was never spliced
warning: grammar `Bsym` was never spliced
warning: grammar `Btable` was never spliced
warning: grammar `Btableidx` was never spliced
warning: grammar `Btablesec` was never spliced
warning: grammar `Btabletype` was never spliced
warning: grammar `Btag` was never spliced
warning: grammar `Btagidx` was never spliced
warning: grammar `Btagsec` was never spliced
warning: grammar `Btagtype` was never spliced
warning: grammar `Btype` was never spliced
warning: grammar `Btypeidx` was never spliced
warning: grammar `Btypesec` was never spliced
warning: grammar `Btypewriter` was never spliced
warning: grammar `Bu32` was never spliced
warning: grammar `Bu64` was never spliced
warning: grammar `BuN` was never spliced
warning: grammar `Bvaltype` was never spliced
warning: grammar `Bvar` was never spliced
warning: grammar `Bvectype` was never spliced
warning: grammar `Bversion` was never spliced
warning: rule `Blocktype_ok/valtype` was never spliced
warning: rule `Blocktype_ok/typeidx` was never spliced
warning: rule `Catch_ok/catch` was never spliced
warning: rule `Catch_ok/catch_ref` was never spliced
warning: rule `Catch_ok/catch_all` was never spliced
warning: rule `Catch_ok/catch_all_ref` was never spliced
warning: rule `Comptype_ok/struct` was never spliced
warning: rule `Comptype_ok/array` was never spliced
warning: rule `Comptype_ok/func` was never spliced
warning: rule `Comptype_sub/struct` was never spliced
warning: rule `Comptype_sub/array` was never spliced
warning: rule `Comptype_sub/func` was never spliced
warning: rule `Data_ok` was never spliced
warning: rule `Datamode_ok/active` was never spliced
warning: rule `Datamode_ok/passive` was never spliced
warning: rule `Deftype_ok` was never spliced
warning: rule `Deftype_sub/refl` was never spliced
warning: rule `Deftype_sub/super` was never spliced
warning: rule `Elem_ok` was never spliced
warning: rule `Elemmode_ok/active` was never spliced
warning: rule `Elemmode_ok/passive` was never spliced
warning: rule `Elemmode_ok/declare` was never spliced
warning: rule `Eval_expr` was never spliced
warning: rule `Expand` was never spliced
warning: rule `Export_ok` was never spliced
warning: rule `Expr_const` was never spliced
warning: rule `Expr_ok` was never spliced
warning: rule `Expr_ok_const` was never spliced
warning: rule `Externaddr_type/func` was never spliced
warning: rule `Externaddr_type/global` was never spliced
warning: rule `Externaddr_type/table` was never spliced
warning: rule `Externaddr_type/mem` was never spliced
warning: rule `Externaddr_type/tag` was never spliced
warning: rule `Externaddr_type/sub` was never spliced
warning: rule `Externidx_ok/func` was never spliced
warning: rule `Externidx_ok/global` was never spliced
warning: rule `Externidx_ok/table` was never spliced
warning: rule `Externidx_ok/mem` was never spliced
warning: rule `Externidx_ok/tag` was never spliced
warning: rule `Externtype_ok/func` was never spliced
warning: rule `Externtype_ok/global` was never spliced
warning: rule `Externtype_ok/table` was never spliced
warning: rule `Externtype_ok/mem` was never spliced
warning: rule `Externtype_ok/tag` was never spliced
warning: rule `Externtype_sub/func` was never spliced
warning: rule `Externtype_sub/global` was never spliced
warning: rule `Externtype_sub/table` was never spliced
warning: rule `Externtype_sub/mem` was never spliced
warning: rule `Externtype_sub/tag` was never spliced
warning: rule `Fieldtype_ok` was never spliced
warning: rule `Fieldtype_sub/const` was never spliced
warning: rule `Fieldtype_sub/var` was never spliced
warning: rule `Func_ok` was never spliced
warning: rule `Functype_ok` was never spliced
warning: rule `Functype_sub` was never spliced
warning: rule `Global_ok` was never spliced
warning: rule `Globals_ok/empty` was never spliced
warning: rule `Globals_ok/cons` was never spliced
warning: rule `Globaltype_ok` was never spliced
warning: rule `Globaltype_sub/const` was never spliced
warning: rule `Globaltype_sub/var` was never spliced
warning: rule `Heaptype_ok/abs` was never spliced
warning: rule `Heaptype_ok/typeidx` was never spliced
warning: rule `Heaptype_ok/rec` was never spliced
warning: rule `Heaptype_sub/refl` was never spliced
warning: rule `Heaptype_sub/trans` was never spliced
warning: rule `Heaptype_sub/eq-any` was never spliced
warning: rule `Heaptype_sub/i31-eq` was never spliced
warning: rule `Heaptype_sub/struct-eq` was never spliced
warning: rule `Heaptype_sub/array-eq` was never spliced
warning: rule `Heaptype_sub/struct` was never spliced
warning: rule `Heaptype_sub/array` was never spliced
warning: rule `Heaptype_sub/func` was never spliced
warning: rule `Heaptype_sub/def` was never spliced
warning: rule `Heaptype_sub/typeidx-l` was never spliced
warning: rule `Heaptype_sub/typeidx-r` was never spliced
warning: rule `Heaptype_sub/rec` was never spliced
warning: rule `Heaptype_sub/none` was never spliced
warning: rule `Heaptype_sub/nofunc` was never spliced
warning: rule `Heaptype_sub/noextern` was never spliced
warning: rule `Heaptype_sub/bot` was never spliced
warning: rule `Import_ok` was never spliced
warning: rule `Instr_const/const` was never spliced
warning: rule `Instr_const/vconst` was never spliced
warning: rule `Instr_const/ref.null` was never spliced
warning: rule `Instr_const/ref.i31` was never spliced
warning: rule `Instr_const/ref.func` was never spliced
warning: rule `Instr_const/struct.new` was never spliced
warning: rule `Instr_const/struct.new_default` was never spliced
warning: rule `Instr_const/array.new` was never spliced
warning: rule `Instr_const/array.new_default` was never spliced
warning: rule `Instr_const/array.new_fixed` was never spliced
warning: rule `Instr_const/any.convert_extern` was never spliced
warning: rule `Instr_const/extern.convert_any` was never spliced
warning: rule `Instr_const/global.get` was never spliced
warning: rule `Instr_const/binop` was never spliced
warning: rule `Instr_ok/select-expl` was never spliced
warning: rule `Instr_ok/select-impl` was never spliced
warning: rule `Instr_ok/br` was never spliced
warning: rule `Instr_ok/br_if` was never spliced
warning: rule `Instr_ok/br_table` was never spliced
warning: rule `Instr_ok/br_on_null` was never spliced
warning: rule `Instr_ok/br_on_non_null` was never spliced
warning: rule `Instr_ok/br_on_cast` was never spliced
warning: rule `Instr_ok/br_on_cast_fail` was never spliced
warning: rule `Instr_ok/call` was never spliced
warning: rule `Instr_ok/call_ref` was never spliced
warning: rule `Instr_ok/call_indirect` was never spliced
warning: rule `Instr_ok/return` was never spliced
warning: rule `Instr_ok/return_call` was never spliced
warning: rule `Instr_ok/return_call_ref` was never spliced
warning: rule `Instr_ok/return_call_indirect` was never spliced
warning: rule `Instr_ok/throw` was never spliced
warning: rule `Instr_ok/throw_ref` was never spliced
warning: rule `Instr_ok/try_table` was never spliced
warning: rule `Instr_ok/const` was never spliced
warning: rule `Instr_ok/unop` was never spliced
warning: rule `Instr_ok/binop` was never spliced
warning: rule `Instr_ok/testop` was never spliced
warning: rule `Instr_ok/relop` was never spliced
warning: rule `Instr_ok/cvtop` was never spliced
warning: rule `Instr_ok/ref.null` was never spliced
warning: rule `Instr_ok/ref.func` was never spliced
warning: rule `Instr_ok/ref.i31` was never spliced
warning: rule `Instr_ok/ref.is_null` was never spliced
warning: rule `Instr_ok/ref.as_non_null` was never spliced
warning: rule `Instr_ok/ref.eq` was never spliced
warning: rule `Instr_ok/ref.test` was never spliced
warning: rule `Instr_ok/ref.cast` was never spliced
warning: rule `Instr_ok/i31.get` was never spliced
warning: rule `Instr_ok/struct.new` was never spliced
warning: rule `Instr_ok/struct.new_default` was never spliced
warning: rule `Instr_ok/struct.get` was never spliced
warning: rule `Instr_ok/struct.set` was never spliced
warning: rule `Instr_ok/array.new` was never spliced
warning: rule `Instr_ok/array.new_default` was never spliced
warning: rule `Instr_ok/array.new_fixed` was never spliced
warning: rule `Instr_ok/array.new_elem` was never spliced
warning: rule `Instr_ok/array.new_data` was never spliced
warning: rule `Instr_ok/array.get` was never spliced
warning: rule `Instr_ok/array.set` was never spliced
warning: rule `Instr_ok/array.len` was never spliced
warning: rule `Instr_ok/array.fill` was never spliced
warning: rule `Instr_ok/array.copy` was never spliced
warning: rule `Instr_ok/array.init_elem` was never spliced
warning: rule `Instr_ok/array.init_data` was never spliced
warning: rule `Instr_ok/extern.convert_any` was never spliced
warning: rule `Instr_ok/any.convert_extern` was never spliced
warning: rule `Instr_ok/vconst` was never spliced
warning: rule `Instr_ok/vvunop` was never spliced
warning: rule `Instr_ok/vvbinop` was never spliced
warning: rule `Instr_ok/vvternop` was never spliced
warning: rule `Instr_ok/vvtestop` was never spliced
warning: rule `Instr_ok/vunop` was never spliced
warning: rule `Instr_ok/vbinop` was never spliced
warning: rule `Instr_ok/vtestop` was never spliced
warning: rule `Instr_ok/vrelop` was never spliced
warning: rule `Instr_ok/vshiftop` was never spliced
warning: rule `Instr_ok/vbitmask` was never spliced
warning: rule `Instr_ok/vswizzle` was never spliced
warning: rule `Instr_ok/vshuffle` was never spliced
warning: rule `Instr_ok/vsplat` was never spliced
warning: rule `Instr_ok/vextract_lane` was never spliced
warning: rule `Instr_ok/vreplace_lane` was never spliced
warning: rule `Instr_ok/vextunop` was never spliced
warning: rule `Instr_ok/vextbinop` was never spliced
warning: rule `Instr_ok/vnarrow` was never spliced
warning: rule `Instr_ok/vcvtop` was never spliced
warning: rule `Instr_ok/local.get` was never spliced
warning: rule `Instr_ok/local.set` was never spliced
warning: rule `Instr_ok/local.tee` was never spliced
warning: rule `Instr_ok/global.get` was never spliced
warning: rule `Instr_ok/global.set` was never spliced
warning: rule `Instr_ok/table.get` was never spliced
warning: rule `Instr_ok/table.set` was never spliced
warning: rule `Instr_ok/table.size` was never spliced
warning: rule `Instr_ok/table.grow` was never spliced
warning: rule `Instr_ok/table.fill` was never spliced
warning: rule `Instr_ok/table.copy` was never spliced
warning: rule `Instr_ok/table.init` was never spliced
warning: rule `Instr_ok/elem.drop` was never spliced
warning: rule `Instr_ok/memory.size` was never spliced
warning: rule `Instr_ok/memory.fill` was never spliced
warning: rule `Instr_ok/memory.copy` was never spliced
warning: rule `Instr_ok/memory.init` was never spliced
warning: rule `Instr_ok/data.drop` was never spliced
warning: rule `Instr_ok/load-val` was never spliced
warning: rule `Instr_ok/load-pack` was never spliced
warning: rule `Instr_ok/store-val` was never spliced
warning: rule `Instr_ok/store-pack` was never spliced
warning: rule `Instr_ok/vload-val` was never spliced
warning: rule `Instr_ok/vload-pack` was never spliced
warning: rule `Instr_ok/vload-splat` was never spliced
warning: rule `Instr_ok/vload-zero` was never spliced
warning: rule `Instr_ok/vload_lane` was never spliced
warning: rule `Instr_ok/vstore` was never spliced
warning: rule `Instr_ok/vstore_lane` was never spliced
warning: rule `Instrs_ok/empty` was spliced more than once
warning: rule `Instrs_ok/sub` was never spliced
warning: rule `Instrs_ok/frame` was spliced more than once
warning: rule `Instrtype_ok` was never spliced
warning: rule `Instrtype_sub` was never spliced
warning: rule `Limits_ok` was never spliced
warning: rule `Limits_sub` was never spliced
warning: rule `Local_ok/set` was never spliced
warning: rule `Local_ok/unset` was never spliced
warning: rule `Mem_ok` was never spliced
warning: rule `Memtype_ok` was never spliced
warning: rule `Memtype_sub` was never spliced
warning: rule `Module_ok` was never spliced
warning: rule `NotationReduct/2` was never spliced
warning: rule `NotationReduct/3` was never spliced
warning: rule `NotationReduct/4` was never spliced
warning: rule `NotationTypingInstrScheme/i32.add` was never spliced
warning: rule `NotationTypingInstrScheme/global.get` was never spliced
warning: rule `NotationTypingInstrScheme/block` was never spliced
warning: rule `NotationTypingScheme` was never spliced
warning: rule `Num_type` was never spliced
warning: rule `Numtype_ok` was never spliced
warning: rule `Numtype_sub` was never spliced
warning: rule `Packtype_ok` was never spliced
warning: rule `Packtype_sub` was never spliced
warning: rule `Rectype_ok/empty` was never spliced
warning: rule `Rectype_ok/cons` was never spliced
warning: rule `Rectype_ok/rec2` was never spliced
warning: rule `Rectype_ok2/empty` was never spliced
warning: rule `Rectype_ok2/cons` was never spliced
warning: rule `Ref_type/null` was never spliced
warning: rule `Ref_type/i31` was never spliced
warning: rule `Ref_type/struct` was never spliced
warning: rule `Ref_type/array` was never spliced
warning: rule `Ref_type/func` was never spliced
warning: rule `Ref_type/exn` was never spliced
warning: rule `Ref_type/host` was never spliced
warning: rule `Ref_type/extern` was never spliced
warning: rule `Ref_type/sub` was never spliced
warning: rule `Reftype_ok` was never spliced
warning: rule `Reftype_sub/nonnull` was never spliced
warning: rule `Reftype_sub/null` was never spliced
warning: rule `Resulttype_ok` was never spliced
warning: rule `Resulttype_sub` was never spliced
warning: rule `Start_ok` was never spliced
warning: rule `Step/throw` was never spliced
warning: rule `Step/ctxt-label` was never spliced
warning: rule `Step/ctxt-frame` was never spliced
warning: rule `Step/struct.new` was never spliced
warning: rule `Step/struct.set-null` was never spliced
warning: rule `Step/struct.set-struct` was never spliced
warning: rule `Step/array.new_fixed` was never spliced
warning: rule `Step/array.set-null` was never spliced
warning: rule `Step/array.set-oob` was never spliced
warning: rule `Step/array.set-array` was never spliced
warning: rule `Step/local.set` was never spliced
warning: rule `Step/global.set` was never spliced
warning: rule `Step/table.set-oob` was never spliced
warning: rule `Step/table.set-val` was never spliced
warning: rule `Step/table.grow-succeed` was never spliced
warning: rule `Step/table.grow-fail` was never spliced
warning: rule `Step/elem.drop` was never spliced
warning: rule `Step/store-num-oob` was never spliced
warning: rule `Step/store-num-val` was never spliced
warning: rule `Step/store-pack-oob` was never spliced
warning: rule `Step/store-pack-val` was never spliced
warning: rule `Step/vstore-oob` was never spliced
warning: rule `Step/vstore-val` was never spliced
warning: rule `Step/vstore_lane-oob` was never spliced
warning: rule `Step/vstore_lane-val` was never spliced
warning: rule `Step/memory.grow-succeed` was never spliced
warning: rule `Step/memory.grow-fail` was never spliced
warning: rule `Step/data.drop` was never spliced
warning: rule `Step_pure/unreachable` was never spliced
warning: rule `Step_pure/nop` was never spliced
warning: rule `Step_pure/drop` was never spliced
warning: rule `Step_pure/select-true` was never spliced
warning: rule `Step_pure/select-false` was never spliced
warning: rule `Step_pure/if-true` was spliced more than once
warning: rule `Step_pure/if-false` was spliced more than once
warning: rule `Step_pure/label-vals` was never spliced
warning: rule `Step_pure/br-label-zero` was never spliced
warning: rule `Step_pure/br-label-succ` was never spliced
warning: rule `Step_pure/br-handler` was never spliced
warning: rule `Step_pure/br_if-true` was never spliced
warning: rule `Step_pure/br_if-false` was never spliced
warning: rule `Step_pure/br_table-lt` was never spliced
warning: rule `Step_pure/br_table-ge` was never spliced
warning: rule `Step_pure/br_on_null-null` was never spliced
warning: rule `Step_pure/br_on_null-addr` was never spliced
warning: rule `Step_pure/br_on_non_null-null` was never spliced
warning: rule `Step_pure/br_on_non_null-addr` was never spliced
warning: rule `Step_pure/call_indirect` was never spliced
warning: rule `Step_pure/return_call_indirect` was never spliced
warning: rule `Step_pure/frame-vals` was never spliced
warning: rule `Step_pure/return-frame` was never spliced
warning: rule `Step_pure/return-label` was never spliced
warning: rule `Step_pure/return-handler` was never spliced
warning: rule `Step_pure/handler-vals` was never spliced
warning: rule `Step_pure/trap-vals` was never spliced
warning: rule `Step_pure/trap-label` was never spliced
warning: rule `Step_pure/trap-frame` was never spliced
warning: rule `Step_pure/unop-val` was never spliced
warning: rule `Step_pure/unop-trap` was never spliced
warning: rule `Step_pure/binop-val` was never spliced
warning: rule `Step_pure/binop-trap` was never spliced
warning: rule `Step_pure/testop` was never spliced
warning: rule `Step_pure/relop` was never spliced
warning: rule `Step_pure/cvtop-val` was never spliced
warning: rule `Step_pure/cvtop-trap` was never spliced
warning: rule `Step_pure/ref.i31` was never spliced
warning: rule `Step_pure/ref.is_null-true` was never spliced
warning: rule `Step_pure/ref.is_null-false` was never spliced
warning: rule `Step_pure/ref.as_non_null-null` was never spliced
warning: rule `Step_pure/ref.as_non_null-addr` was never spliced
warning: rule `Step_pure/ref.eq-null` was never spliced
warning: rule `Step_pure/ref.eq-true` was never spliced
warning: rule `Step_pure/ref.eq-false` was never spliced
warning: rule `Step_pure/i31.get-null` was never spliced
warning: rule `Step_pure/i31.get-num` was never spliced
warning: rule `Step_pure/array.new` was never spliced
warning: rule `Step_pure/extern.convert_any-null` was never spliced
warning: rule `Step_pure/extern.convert_any-addr` was never spliced
warning: rule `Step_pure/any.convert_extern-null` was never spliced
warning: rule `Step_pure/any.convert_extern-addr` was never spliced
warning: rule `Step_pure/vvunop` was never spliced
warning: rule `Step_pure/vvbinop` was never spliced
warning: rule `Step_pure/vvternop` was never spliced
warning: rule `Step_pure/vvtestop` was never spliced
warning: rule `Step_pure/vunop-val` was never spliced
warning: rule `Step_pure/vunop-trap` was never spliced
warning: rule `Step_pure/vbinop-val` was never spliced
warning: rule `Step_pure/vbinop-trap` was never spliced
warning: rule `Step_pure/vtestop-true` was never spliced
warning: rule `Step_pure/vtestop-false` was never spliced
warning: rule `Step_pure/vrelop` was never spliced
warning: rule `Step_pure/vshiftop` was never spliced
warning: rule `Step_pure/vbitmask` was never spliced
warning: rule `Step_pure/vswizzle` was never spliced
warning: rule `Step_pure/vshuffle` was never spliced
warning: rule `Step_pure/vsplat` was never spliced
warning: rule `Step_pure/vextract_lane-num` was never spliced
warning: rule `Step_pure/vextract_lane-pack` was never spliced
warning: rule `Step_pure/vreplace_lane` was never spliced
warning: rule `Step_pure/vextunop` was never spliced
warning: rule `Step_pure/vextbinop` was never spliced
warning: rule `Step_pure/vnarrow` was never spliced
warning: rule `Step_pure/vcvtop-full` was never spliced
warning: rule `Step_pure/vcvtop-half` was never spliced
warning: rule `Step_pure/vcvtop-zero` was never spliced
warning: rule `Step_pure/local.tee` was never spliced
warning: rule `Step_read/br_on_cast-succeed` was never spliced
warning: rule `Step_read/br_on_cast-fail` was never spliced
warning: rule `Step_read/br_on_cast_fail-succeed` was never spliced
warning: rule `Step_read/br_on_cast_fail-fail` was never spliced
warning: rule `Step_read/call` was never spliced
warning: rule `Step_read/call_ref-null` was never spliced
warning: rule `Step_read/call_ref-func` was never spliced
warning: rule `Step_read/return_call` was never spliced
warning: rule `Step_read/return_call_ref-label` was never spliced
warning: rule `Step_read/return_call_ref-handler` was never spliced
warning: rule `Step_read/return_call_ref-frame-null` was never spliced
warning: rule `Step_read/return_call_ref-frame-addr` was never spliced
warning: rule `Step_read/throw_ref-null` was never spliced
warning: rule `Step_read/throw_ref-vals` was never spliced
warning: rule `Step_read/throw_ref-label` was never spliced
warning: rule `Step_read/throw_ref-frame` was never spliced
warning: rule `Step_read/throw_ref-handler-empty` was never spliced
warning: rule `Step_read/throw_ref-handler-catch` was never spliced
warning: rule `Step_read/throw_ref-handler-catch_ref` was never spliced
warning: rule `Step_read/throw_ref-handler-catch_all` was never spliced
warning: rule `Step_read/throw_ref-handler-catch_all_ref` was never spliced
warning: rule `Step_read/throw_ref-handler-next` was never spliced
warning: rule `Step_read/try_table` was never spliced
warning: rule `Step_read/ref.null-idx` was never spliced
warning: rule `Step_read/ref.func` was never spliced
warning: rule `Step_read/ref.test-true` was never spliced
warning: rule `Step_read/ref.test-false` was never spliced
warning: rule `Step_read/ref.cast-succeed` was never spliced
warning: rule `Step_read/ref.cast-fail` was never spliced
warning: rule `Step_read/struct.new_default` was never spliced
warning: rule `Step_read/struct.get-null` was never spliced
warning: rule `Step_read/struct.get-struct` was never spliced
warning: rule `Step_read/array.new_default` was never spliced
warning: rule `Step_read/array.new_elem-oob` was never spliced
warning: rule `Step_read/array.new_elem-alloc` was never spliced
warning: rule `Step_read/array.new_data-oob` was never spliced
warning: rule `Step_read/array.new_data-num` was never spliced
warning: rule `Step_read/array.get-null` was never spliced
warning: rule `Step_read/array.get-oob` was never spliced
warning: rule `Step_read/array.get-array` was never spliced
warning: rule `Step_read/array.len-null` was never spliced
warning: rule `Step_read/array.len-array` was never spliced
warning: rule `Step_read/array.fill-null` was never spliced
warning: rule `Step_read/array.fill-oob` was never spliced
warning: rule `Step_read/array.fill-zero` was never spliced
warning: rule `Step_read/array.fill-succ` was never spliced
warning: rule `Step_read/array.copy-null1` was never spliced
warning: rule `Step_read/array.copy-null2` was never spliced
warning: rule `Step_read/array.copy-oob1` was never spliced
warning: rule `Step_read/array.copy-oob2` was never spliced
warning: rule `Step_read/array.copy-zero` was never spliced
warning: rule `Step_read/array.copy-le` was never spliced
warning: rule `Step_read/array.copy-gt` was never spliced
warning: rule `Step_read/array.init_elem-null` was never spliced
warning: rule `Step_read/array.init_elem-oob1` was never spliced
warning: rule `Step_read/array.init_elem-oob2` was never spliced
warning: rule `Step_read/array.init_elem-zero` was never spliced
warning: rule `Step_read/array.init_elem-succ` was never spliced
warning: rule `Step_read/array.init_data-null` was never spliced
warning: rule `Step_read/array.init_data-oob1` was never spliced
warning: rule `Step_read/array.init_data-oob2` was never spliced
warning: rule `Step_read/array.init_data-zero` was never spliced
warning: rule `Step_read/array.init_data-num` was never spliced
warning: rule `Step_read/local.get` was never spliced
warning: rule `Step_read/global.get` was never spliced
warning: rule `Step_read/table.get-oob` was never spliced
warning: rule `Step_read/table.get-val` was never spliced
warning: rule `Step_read/table.size` was never spliced
warning: rule `Step_read/table.fill-oob` was never spliced
warning: rule `Step_read/table.fill-zero` was never spliced
warning: rule `Step_read/table.fill-succ` was never spliced
warning: rule `Step_read/table.copy-oob` was never spliced
warning: rule `Step_read/table.copy-zero` was never spliced
warning: rule `Step_read/table.copy-le` was never spliced
warning: rule `Step_read/table.copy-gt` was never spliced
warning: rule `Step_read/table.init-oob` was never spliced
warning: rule `Step_read/table.init-zero` was never spliced
warning: rule `Step_read/table.init-succ` was never spliced
warning: rule `Step_read/load-num-oob` was never spliced
warning: rule `Step_read/load-num-val` was never spliced
warning: rule `Step_read/load-pack-oob` was never spliced
warning: rule `Step_read/load-pack-val` was never spliced
warning: rule `Step_read/vload-oob` was never spliced
warning: rule `Step_read/vload-val` was never spliced
warning: rule `Step_read/vload-pack-oob` was never spliced
warning: rule `Step_read/vload-pack-val` was never spliced
warning: rule `Step_read/vload-splat-oob` was never spliced
warning: rule `Step_read/vload-splat-val` was never spliced
warning: rule `Step_read/vload-zero-oob` was never spliced
warning: rule `Step_read/vload-zero-val` was never spliced
warning: rule `Step_read/vload_lane-oob` was never spliced
warning: rule `Step_read/vload_lane-val` was never spliced
warning: rule `Step_read/memory.size` was never spliced
warning: rule `Step_read/memory.fill-oob` was never spliced
warning: rule `Step_read/memory.fill-zero` was never spliced
warning: rule `Step_read/memory.fill-succ` was never spliced
warning: rule `Step_read/memory.copy-oob` was never spliced
warning: rule `Step_read/memory.copy-zero` was never spliced
warning: rule `Step_read/memory.copy-le` was never spliced
warning: rule `Step_read/memory.copy-gt` was never spliced
warning: rule `Step_read/memory.init-oob` was never spliced
warning: rule `Step_read/memory.init-zero` was never spliced
warning: rule `Step_read/memory.init-succ` was never spliced
warning: rule `Steps/refl` was never spliced
warning: rule `Steps/trans` was never spliced
warning: rule `Storagetype_ok/val` was never spliced
warning: rule `Storagetype_ok/pack` was never spliced
warning: rule `Storagetype_sub/val` was never spliced
warning: rule `Storagetype_sub/pack` was never spliced
warning: rule `Subtype_ok` was never spliced
warning: rule `Subtype_ok2` was never spliced
warning: rule `Table_ok` was never spliced
warning: rule `Tabletype_ok` was never spliced
warning: rule `Tabletype_sub` was never spliced
warning: rule `Tag_ok` was never spliced
warning: rule `Tagtype_ok` was never spliced
warning: rule `Tagtype_sub` was never spliced
warning: rule `Type_ok` was never spliced
warning: rule `Types_ok/empty` was never spliced
warning: rule `Types_ok/cons` was never spliced
warning: rule `Val_type/num` was never spliced
warning: rule `Val_type/vec` was never spliced
warning: rule `Val_type/ref` was never spliced
warning: rule `Valtype_ok/num` was never spliced
warning: rule `Valtype_ok/vec` was never spliced
warning: rule `Valtype_ok/ref` was never spliced
warning: rule `Valtype_ok/bot` was never spliced
warning: rule `Valtype_sub/num` was never spliced
warning: rule `Valtype_sub/vec` was never spliced
warning: rule `Valtype_sub/ref` was never spliced
warning: rule `Valtype_sub/bot` was never spliced
warning: rule `Vec_type` was never spliced
warning: rule `Vectype_ok` was never spliced
warning: rule `Vectype_sub` was never spliced
warning: definition `ANYREF` was never spliced
warning: definition `ARRAYREF` was never spliced
warning: definition `E` was never spliced
warning: definition `EQREF` was never spliced
warning: definition `EXTERNREF` was never spliced
warning: definition `FN` was never spliced
warning: definition `FUNCREF` was never spliced
warning: definition `I31REF` was never spliced
warning: definition `IN` was never spliced
warning: definition `JN` was never spliced
warning: definition `Ki` was never spliced
warning: definition `M` was never spliced
warning: definition `NULLEXTERNREF` was never spliced
warning: definition `NULLFUNCREF` was never spliced
warning: definition `NULLREF` was never spliced
warning: definition `STRUCTREF` was never spliced
warning: definition `add_arrayinst` was never spliced
warning: definition `add_exninst` was never spliced
warning: definition `add_structinst` was never spliced
warning: definition `allocX` was never spliced
warning: definition `allocXs` was never spliced
warning: definition `allocdata` was never spliced
warning: definition `allocdatas` was never spliced
warning: definition `allocelem` was never spliced
warning: definition `allocelems` was never spliced
warning: definition `allocexport` was never spliced
warning: definition `allocexports` was never spliced
warning: definition `allocfunc` was never spliced
warning: definition `allocfuncs` was never spliced
warning: definition `allocglobal` was never spliced
warning: definition `allocglobals` was never spliced
warning: definition `allocmem` was never spliced
warning: definition `allocmems` was never spliced
warning: definition `allocmodule` was never spliced
warning: definition `alloctable` was never spliced
warning: definition `alloctables` was never spliced
warning: definition `alloctag` was never spliced
warning: definition `alloctags` was never spliced
warning: definition `alloctypes` was never spliced
warning: definition `arrayinst` was never spliced
warning: definition `before` was never spliced
warning: definition `binop_` was never spliced
warning: definition `blocktype_` was never spliced
warning: definition `canon_` was never spliced
warning: definition `cbytes_` was never spliced
warning: definition `clos_deftype` was never spliced
warning: definition `clos_deftypes` was never spliced
warning: definition `clos_moduletype` was never spliced
warning: definition `clos_valtype` was never spliced
warning: definition `concat_` was never spliced
warning: definition `concatn_` was never spliced
warning: definition `const` was never spliced
warning: definition `cont` was never spliced
warning: definition `convert__` was never spliced
warning: definition `cpacknum_` was never spliced
warning: definition `cunpack` was never spliced
warning: definition `cunpacknum_` was never spliced
warning: definition `cvtop__` was never spliced
warning: definition `data` was never spliced
warning: definition `dataidx_funcs` was never spliced
warning: definition `datainst` was never spliced
warning: definition `demote__` was never spliced
warning: definition `diffrt` was never spliced
warning: definition `dim` was never spliced
warning: definition `disjoint_` was never spliced
warning: definition `elem` was never spliced
warning: definition `eleminst` was never spliced
warning: definition `evalglobals` was never spliced
warning: definition `exninst` was never spliced
warning: definition `expanddt` was never spliced
warning: definition `expon` was never spliced
warning: definition `extend__` was never spliced
warning: definition `fabs_` was never spliced
warning: definition `fadd_` was never spliced
warning: definition `fbits_` was never spliced
warning: definition `fbytes_` was never spliced
warning: definition `fceil_` was never spliced
warning: definition `fcopysign_` was never spliced
warning: definition `fdiv_` was never spliced
warning: definition `feq_` was never spliced
warning: definition `ffloor_` was never spliced
warning: definition `fge_` was never spliced
warning: definition `fgt_` was never spliced
warning: definition `fle_` was never spliced
warning: definition `flt_` was never spliced
warning: definition `fmax_` was never spliced
warning: definition `fmin_` was never spliced
warning: definition `fmul_` was never spliced
warning: definition `fne_` was never spliced
warning: definition `fnearest_` was never spliced
warning: definition `fneg_` was never spliced
warning: definition `fone` was never spliced
warning: definition `fpmax_` was never spliced
warning: definition `fpmin_` was never spliced
warning: definition `frame` was never spliced
warning: definition `free_absheaptype` was never spliced
warning: definition `free_arraytype` was never spliced
warning: definition `free_block` was never spliced
warning: definition `free_blocktype` was never spliced
warning: definition `free_comptype` was never spliced
warning: definition `free_consttype` was never spliced
warning: definition `free_data` was never spliced
warning: definition `free_dataidx` was never spliced
warning: definition `free_datamode` was never spliced
warning: definition `free_datatype` was never spliced
warning: definition `free_deftype` was never spliced
warning: definition `free_elem` was never spliced
warning: definition `free_elemidx` was never spliced
warning: definition `free_elemmode` was never spliced
warning: definition `free_elemtype` was never spliced
warning: definition `free_export` was never spliced
warning: definition `free_expr` was never spliced
warning: definition `free_externidx` was never spliced
warning: definition `free_externtype` was never spliced
warning: definition `free_fieldtype` was never spliced
warning: definition `free_func` was never spliced
warning: definition `free_funcidx` was never spliced
warning: definition `free_functype` was never spliced
warning: definition `free_global` was never spliced
warning: definition `free_globalidx` was never spliced
warning: definition `free_globaltype` was never spliced
warning: definition `free_heaptype` was never spliced
warning: definition `free_import` was never spliced
warning: definition `free_instr` was never spliced
warning: definition `free_labelidx` was never spliced
warning: definition `free_lanetype` was never spliced
warning: definition `free_list` was never spliced
warning: definition `free_local` was never spliced
warning: definition `free_localidx` was never spliced
warning: definition `free_mem` was never spliced
warning: definition `free_memidx` was never spliced
warning: definition `free_memtype` was never spliced
warning: definition `free_module` was never spliced
warning: definition `free_moduletype` was never spliced
warning: definition `free_numtype` was never spliced
warning: definition `free_opt` was never spliced
warning: definition `free_packtype` was never spliced
warning: definition `free_rectype` was never spliced
warning: definition `free_reftype` was never spliced
warning: definition `free_resulttype` was never spliced
warning: definition `free_shape` was never spliced
warning: definition `free_start` was never spliced
warning: definition `free_storagetype` was never spliced
warning: definition `free_structtype` was never spliced
warning: definition `free_subtype` was never spliced
warning: definition `free_table` was never spliced
warning: definition `free_tableidx` was never spliced
warning: definition `free_tabletype` was never spliced
warning: definition `free_tag` was never spliced
warning: definition `free_type` was never spliced
warning: definition `free_typeidx` was never spliced
warning: definition `free_typeuse` was never spliced
warning: definition `free_valtype` was never spliced
warning: definition `free_vectype` was never spliced
warning: definition `fsqrt_` was never spliced
warning: definition `fsub_` was never spliced
warning: definition `ftrunc_` was never spliced
warning: definition `funcidx_module` was never spliced
warning: definition `funcidx_nonfuncs` was never spliced
warning: definition `funcsxa` was never spliced
warning: definition `funcsxt` was never spliced
warning: definition `funcsxx` was never spliced
warning: definition `fvbinop_` was never spliced
warning: definition `fvrelop_` was never spliced
warning: definition `fvunop_` was never spliced
warning: definition `fzero` was never spliced
warning: definition `global` was never spliced
warning: definition `globalinst` was never spliced
warning: definition `globalsxa` was never spliced
warning: definition `globalsxt` was never spliced
warning: definition `globalsxx` was never spliced
warning: definition `growmem` was never spliced
warning: definition `growtable` was never spliced
warning: definition `half__` was never spliced
warning: definition `iabs_` was never spliced
warning: definition `iadd_` was never spliced
warning: definition `iadd_sat_` was never spliced
warning: definition `iand_` was never spliced
warning: definition `iandnot_` was never spliced
warning: definition `iavgr_` was never spliced
warning: definition `ibits_` was never spliced
warning: definition `ibitselect_` was never spliced
warning: definition `ibytes_` was never spliced
warning: definition `iclz_` was never spliced
warning: definition `ictz_` was never spliced
warning: definition `idiv_` was never spliced
warning: definition `ieq_` was never spliced
warning: definition `ieqz_` was never spliced
warning: definition `ige_` was never spliced
warning: definition `igt_` was never spliced
warning: definition `ile_` was never spliced
warning: definition `ilt_` was never spliced
warning: definition `imax_` was never spliced
warning: definition `imin_` was never spliced
warning: definition `imul_` was never spliced
warning: definition `ine_` was never spliced
warning: definition `ineg_` was never spliced
warning: definition `inot_` was never spliced
warning: definition `inst_reftype` was never spliced
warning: definition `inst_valtype` was never spliced
warning: definition `instantiate` was never spliced
warning: definition `instrdots` was never spliced
warning: definition `invfbytes_` was never spliced
warning: definition `invibytes_` was never spliced
warning: definition `invlanes_` was never spliced
warning: definition `invoke` was never spliced
warning: definition `invsigned_` was never spliced
warning: definition `ior_` was never spliced
warning: definition `ipopcnt_` was never spliced
warning: definition `iq15mulr_sat_` was never spliced
warning: definition `irem_` was never spliced
warning: definition `irotl_` was never spliced
warning: definition `irotr_` was never spliced
warning: definition `ishl_` was never spliced
warning: definition `ishr_` was never spliced
warning: definition `isize` was never spliced
warning: definition `isub_` was never spliced
warning: definition `isub_sat_` was never spliced
warning: definition `ivbinop_` was never spliced
warning: definition `ivbinopsx_` was never spliced
warning: definition `ivrelop_` was never spliced
warning: definition `ivrelopsx_` was never spliced
warning: definition `ivunop_` was never spliced
warning: definition `ixor_` was never spliced
warning: definition `lanes_` was never spliced
warning: definition `lanetype` was never spliced
warning: definition `list_` was never spliced
warning: definition `local` was never spliced
warning: definition `lpacknum_` was never spliced
warning: definition `lsize` was never spliced
warning: definition `lsizenn` was never spliced
warning: definition `lsizenn1` was never spliced
warning: definition `lsizenn2` was never spliced
warning: definition `lunpack` was never spliced
warning: definition `lunpacknum_` was never spliced
warning: definition `mem` was never spliced
warning: definition `memarg0` was never spliced
warning: definition `meminst` was never spliced
warning: definition `memsxa` was never spliced
warning: definition `memsxt` was never spliced
warning: definition `memsxx` was never spliced
warning: definition `min` was never spliced
warning: definition `moduleinst` was never spliced
warning: definition `narrow__` was never spliced
warning: definition `nbytes_` was never spliced
warning: definition `nunpack` was never spliced
warning: definition `opt_` was never spliced
warning: definition `packfield_` was never spliced
warning: definition `promote__` was never spliced
warning: definition `psize` was never spliced
warning: definition `psizenn` was never spliced
warning: definition `reinterpret__` was never spliced
warning: definition `relop_` was never spliced
warning: definition `rolldt` was never spliced
warning: definition `rollrt` was never spliced
warning: definition `rundata_` was never spliced
warning: definition `runelem_` was never spliced
warning: definition `s33_to_u32` was never spliced
warning: definition `setminus1_` was never spliced
warning: definition `setminus_` was never spliced
warning: definition `setproduct1_` was never spliced
warning: definition `setproduct2_` was never spliced
warning: definition `setproduct_` was never spliced
warning: definition `shift_labelidxs` was never spliced
warning: definition `shsize` was never spliced
warning: definition `signed_` was never spliced
warning: definition `signif` was never spliced
warning: definition `sizenn` was never spliced
warning: definition `sizenn1` was never spliced
warning: definition `sizenn2` was never spliced
warning: definition `store` was never spliced
warning: definition `structinst` was never spliced
warning: definition `subst_all_deftype` was never spliced
warning: definition `subst_all_deftypes` was never spliced
warning: definition `subst_all_moduletype` was never spliced
warning: definition `subst_all_reftype` was never spliced
warning: definition `subst_all_valtype` was never spliced
warning: definition `subst_comptype` was never spliced
warning: definition `subst_deftype` was never spliced
warning: definition `subst_externtype` was never spliced
warning: definition `subst_fieldtype` was never spliced
warning: definition `subst_functype` was never spliced
warning: definition `subst_globaltype` was never spliced
warning: definition `subst_heaptype` was never spliced
warning: definition `subst_memtype` was never spliced
warning: definition `subst_moduletype` was never spliced
warning: definition `subst_numtype` was never spliced
warning: definition `subst_packtype` was never spliced
warning: definition `subst_rectype` was never spliced
warning: definition `subst_reftype` was never spliced
warning: definition `subst_storagetype` was never spliced
warning: definition `subst_subtype` was never spliced
warning: definition `subst_tabletype` was never spliced
warning: definition `subst_typeuse` was never spliced
warning: definition `subst_typevar` was never spliced
warning: definition `subst_valtype` was never spliced
warning: definition `subst_vectype` was never spliced
warning: definition `sum` was never spliced
warning: definition `sx` was never spliced
warning: definition `tableinst` was never spliced
warning: definition `tablesxa` was never spliced
warning: definition `tablesxt` was never spliced
warning: definition `tablesxx` was never spliced
warning: definition `tag` was never spliced
warning: definition `tagaddr` was never spliced
warning: definition `taginst` was never spliced
warning: definition `tagsxa` was never spliced
warning: definition `tagsxt` was never spliced
warning: definition `tagsxx` was never spliced
warning: definition `testop_` was never spliced
warning: definition `trunc__` was never spliced
warning: definition `trunc_sat__` was never spliced
warning: definition `type` was never spliced
warning: definition `unop_` was never spliced
warning: definition `unpack` was never spliced
warning: definition `unpackfield_` was never spliced
warning: definition `unpackshape` was never spliced
warning: definition `unrolldt` was never spliced
warning: definition `unrollht` was never spliced
warning: definition `unrollrt` was never spliced
warning: definition `utf8` was never spliced
warning: definition `var` was never spliced
warning: definition `vbinop_` was never spliced
warning: definition `vbytes_` was never spliced
warning: definition `vcvtop__` was never spliced
warning: definition `vextbinop__` was never spliced
warning: definition `vextunop__` was never spliced
warning: definition `vrelop_` was never spliced
warning: definition `vshiftop_` was never spliced
warning: definition `vsize` was never spliced
warning: definition `vunop_` was never spliced
warning: definition `vunpack` was never spliced
warning: definition `vvbinop_` was never spliced
warning: definition `vvternop_` was never spliced
warning: definition `vvunop_` was never spliced
warning: definition `with_array` was never spliced
warning: definition `with_data` was never spliced
warning: definition `with_elem` was never spliced
warning: definition `with_global` was never spliced
warning: definition `with_local` was never spliced
warning: definition `with_locals` was never spliced
warning: definition `with_mem` was never spliced
warning: definition `with_meminst` was never spliced
warning: definition `with_struct` was never spliced
warning: definition `with_table` was never spliced
warning: definition `with_tableinst` was never spliced
warning: definition `wrap__` was never spliced
warning: definition `zbytes_` was never spliced
warning: definition `zero` was never spliced
warning: definition `zsize` was never spliced
warning: rule prose `Blocktype_ok` was never spliced
warning: rule prose `Catch_ok` was never spliced
warning: rule prose `Comptype_ok` was never spliced
warning: rule prose `Comptype_sub` was never spliced
warning: rule prose `Data_ok` was never spliced
warning: rule prose `Datamode_ok` was never spliced
warning: rule prose `Deftype_ok` was never spliced
warning: rule prose `Deftype_sub` was never spliced
warning: rule prose `Elem_ok` was never spliced
warning: rule prose `Elemmode_ok` was never spliced
warning: rule prose `Export_ok` was never spliced
warning: rule prose `Expr_const` was never spliced
warning: rule prose `Expr_ok` was never spliced
warning: rule prose `Externidx_ok` was never spliced
warning: rule prose `Externtype_ok` was never spliced
warning: rule prose `Externtype_sub` was never spliced
warning: rule prose `Fieldtype_ok` was never spliced
warning: rule prose `Fieldtype_sub` was never spliced
warning: rule prose `Func_ok` was never spliced
warning: rule prose `Functype_ok` was never spliced
warning: rule prose `Functype_sub` was never spliced
warning: rule prose `Global_ok` was never spliced
warning: rule prose `Globals_ok` was never spliced
warning: rule prose `Globaltype_ok` was never spliced
warning: rule prose `Globaltype_sub` was never spliced
warning: rule prose `Heaptype_ok` was never spliced
warning: rule prose `Heaptype_sub` was never spliced
warning: rule prose `Import_ok` was never spliced
warning: rule prose `Instr_const` was never spliced
warning: rule prose `Instr_ok/any.convert_extern` was never spliced
warning: rule prose `Instr_ok/array.copy` was never spliced
warning: rule prose `Instr_ok/array.fill` was never spliced
warning: rule prose `Instr_ok/array.get` was never spliced
warning: rule prose `Instr_ok/array.init_data` was never spliced
warning: rule prose `Instr_ok/array.init_elem` was never spliced
warning: rule prose `Instr_ok/array.len` was never spliced
warning: rule prose `Instr_ok/array.new` was never spliced
warning: rule prose `Instr_ok/array.new_data` was never spliced
warning: rule prose `Instr_ok/array.new_default` was never spliced
warning: rule prose `Instr_ok/array.new_elem` was never spliced
warning: rule prose `Instr_ok/array.new_fixed` was never spliced
warning: rule prose `Instr_ok/array.set` was never spliced
warning: rule prose `Instr_ok/binop` was never spliced
warning: rule prose `Instr_ok/block` was never spliced
warning: rule prose `Instr_ok/br` was never spliced
warning: rule prose `Instr_ok/br_if` was never spliced
warning: rule prose `Instr_ok/br_on_cast` was never spliced
warning: rule prose `Instr_ok/br_on_cast_fail` was never spliced
warning: rule prose `Instr_ok/br_on_non_null` was never spliced
warning: rule prose `Instr_ok/br_on_null` was never spliced
warning: rule prose `Instr_ok/br_table` was never spliced
warning: rule prose `Instr_ok/call` was never spliced
warning: rule prose `Instr_ok/call_indirect` was never spliced
warning: rule prose `Instr_ok/call_ref` was never spliced
warning: rule prose `Instr_ok/const` was never spliced
warning: rule prose `Instr_ok/cvtop` was never spliced
warning: rule prose `Instr_ok/data.drop` was never spliced
warning: rule prose `Instr_ok/drop` was never spliced
warning: rule prose `Instr_ok/elem.drop` was never spliced
warning: rule prose `Instr_ok/extern.convert_any` was never spliced
warning: rule prose `Instr_ok/global.get` was never spliced
warning: rule prose `Instr_ok/global.set` was never spliced
warning: rule prose `Instr_ok/i31.get` was never spliced
warning: rule prose `Instr_ok/if` was never spliced
warning: rule prose `Instr_ok/load` was never spliced
warning: rule prose `Instr_ok/local.get` was never spliced
warning: rule prose `Instr_ok/local.set` was never spliced
warning: rule prose `Instr_ok/local.tee` was never spliced
warning: rule prose `Instr_ok/loop` was never spliced
warning: rule prose `Instr_ok/memory.copy` was never spliced
warning: rule prose `Instr_ok/memory.fill` was never spliced
warning: rule prose `Instr_ok/memory.grow` was never spliced
warning: rule prose `Instr_ok/memory.init` was never spliced
warning: rule prose `Instr_ok/memory.size` was never spliced
warning: rule prose `Instr_ok/nop` was never spliced
warning: rule prose `Instr_ok/ref.as_non_null` was never spliced
warning: rule prose `Instr_ok/ref.cast` was never spliced
warning: rule prose `Instr_ok/ref.eq` was never spliced
warning: rule prose `Instr_ok/ref.func` was never spliced
warning: rule prose `Instr_ok/ref.i31` was never spliced
warning: rule prose `Instr_ok/ref.is_null` was never spliced
warning: rule prose `Instr_ok/ref.null` was never spliced
warning: rule prose `Instr_ok/ref.test` was never spliced
warning: rule prose `Instr_ok/relop` was never spliced
warning: rule prose `Instr_ok/return` was never spliced
warning: rule prose `Instr_ok/return_call` was never spliced
warning: rule prose `Instr_ok/return_call_indirect` was never spliced
warning: rule prose `Instr_ok/return_call_ref` was never spliced
warning: rule prose `Instr_ok/select` was never spliced
warning: rule prose `Instr_ok/store` was never spliced
warning: rule prose `Instr_ok/struct.get` was never spliced
warning: rule prose `Instr_ok/struct.new` was never spliced
warning: rule prose `Instr_ok/struct.new_default` was never spliced
warning: rule prose `Instr_ok/struct.set` was never spliced
warning: rule prose `Instr_ok/table.copy` was never spliced
warning: rule prose `Instr_ok/table.fill` was never spliced
warning: rule prose `Instr_ok/table.get` was never spliced
warning: rule prose `Instr_ok/table.grow` was never spliced
warning: rule prose `Instr_ok/table.init` was never spliced
warning: rule prose `Instr_ok/table.set` was never spliced
warning: rule prose `Instr_ok/table.size` was never spliced
warning: rule prose `Instr_ok/testop` was never spliced
warning: rule prose `Instr_ok/throw` was never spliced
warning: rule prose `Instr_ok/throw_ref` was never spliced
warning: rule prose `Instr_ok/try_table` was never spliced
warning: rule prose `Instr_ok/unop` was never spliced
warning: rule prose `Instr_ok/unreachable` was never spliced
warning: rule prose `Instr_ok/vbinop` was never spliced
warning: rule prose `Instr_ok/vbitmask` was never spliced
warning: rule prose `Instr_ok/vconst` was never spliced
warning: rule prose `Instr_ok/vcvtop` was never spliced
warning: rule prose `Instr_ok/vextbinop` was never spliced
warning: rule prose `Instr_ok/vextract_lane` was never spliced
warning: rule prose `Instr_ok/vextunop` was never spliced
warning: rule prose `Instr_ok/vload` was never spliced
warning: rule prose `Instr_ok/vload_lane` was never spliced
warning: rule prose `Instr_ok/vnarrow` was never spliced
warning: rule prose `Instr_ok/vrelop` was never spliced
warning: rule prose `Instr_ok/vreplace_lane` was never spliced
warning: rule prose `Instr_ok/vshiftop` was never spliced
warning: rule prose `Instr_ok/vshuffle` was never spliced
warning: rule prose `Instr_ok/vsplat` was never spliced
warning: rule prose `Instr_ok/vstore` was never spliced
warning: rule prose `Instr_ok/vstore_lane` was never spliced
warning: rule prose `Instr_ok/vswizzle` was never spliced
warning: rule prose `Instr_ok/vtestop` was never spliced
warning: rule prose `Instr_ok/vunop` was never spliced
warning: rule prose `Instr_ok/vvbinop` was never spliced
warning: rule prose `Instr_ok/vvternop` was never spliced
warning: rule prose `Instr_ok/vvtestop` was never spliced
warning: rule prose `Instr_ok/vvunop` was never spliced
warning: rule prose `Instrs_ok` was never spliced
warning: rule prose `Instrtype_ok` was never spliced
warning: rule prose `Instrtype_sub` was never spliced
warning: rule prose `Limits_ok` was never spliced
warning: rule prose `Limits_sub` was never spliced
warning: rule prose `Local_ok` was never spliced
warning: rule prose `Mem_ok` was never spliced
warning: rule prose `Memtype_ok` was never spliced
warning: rule prose `Memtype_sub` was never spliced
warning: rule prose `Module_ok` was never spliced
warning: rule prose `NotationTypingInstrScheme` was never spliced
warning: rule prose `Numtype_ok` was never spliced
warning: rule prose `Numtype_sub` was never spliced
warning: rule prose `Packtype_ok` was never spliced
warning: rule prose `Packtype_sub` was never spliced
warning: rule prose `Rectype_ok` was never spliced
warning: rule prose `Rectype_ok2` was never spliced
warning: rule prose `Reftype_ok` was never spliced
warning: rule prose `Reftype_sub` was never spliced
warning: rule prose `Resulttype_ok` was never spliced
warning: rule prose `Resulttype_sub` was never spliced
warning: rule prose `Start_ok` was never spliced
warning: rule prose `Step/array.new_fixed` was never spliced
warning: rule prose `Step/array.set` was never spliced
warning: rule prose `Step/data.drop` was never spliced
warning: rule prose `Step/elem.drop` was never spliced
warning: rule prose `Step/global.set` was never spliced
warning: rule prose `Step/local.set` was never spliced
warning: rule prose `Step/memory.grow` was never spliced
warning: rule prose `Step/store` was never spliced
warning: rule prose `Step/struct.new` was never spliced
warning: rule prose `Step/struct.set` was never spliced
warning: rule prose `Step/table.grow` was never spliced
warning: rule prose `Step/table.set` was never spliced
warning: rule prose `Step/throw` was never spliced
warning: rule prose `Step/vstore` was never spliced
warning: rule prose `Step/vstore_lane` was never spliced
warning: rule prose `Step_pure/any.convert_extern` was never spliced
warning: rule prose `Step_pure/array.new` was never spliced
warning: rule prose `Step_pure/binop` was never spliced
warning: rule prose `Step_pure/br` was never spliced
warning: rule prose `Step_pure/br_if` was never spliced
warning: rule prose `Step_pure/br_on_non_null` was never spliced
warning: rule prose `Step_pure/br_on_null` was never spliced
warning: rule prose `Step_pure/br_table` was never spliced
warning: rule prose `Step_pure/call_indirect` was never spliced
warning: rule prose `Step_pure/cvtop` was never spliced
warning: rule prose `Step_pure/drop` was never spliced
warning: rule prose `Step_pure/extern.convert_any` was never spliced
warning: rule prose `Step_pure/frame` was never spliced
warning: rule prose `Step_pure/handler` was never spliced
warning: rule prose `Step_pure/i31.get` was never spliced
warning: rule prose `Step_pure/if` was never spliced
warning: rule prose `Step_pure/label` was never spliced
warning: rule prose `Step_pure/local.tee` was never spliced
warning: rule prose `Step_pure/nop` was never spliced
warning: rule prose `Step_pure/ref.as_non_null` was never spliced
warning: rule prose `Step_pure/ref.eq` was never spliced
warning: rule prose `Step_pure/ref.i31` was never spliced
warning: rule prose `Step_pure/ref.is_null` was never spliced
warning: rule prose `Step_pure/relop` was never spliced
warning: rule prose `Step_pure/return` was never spliced
warning: rule prose `Step_pure/return_call_indirect` was never spliced
warning: rule prose `Step_pure/select` was never spliced
warning: rule prose `Step_pure/testop` was never spliced
warning: rule prose `Step_pure/unop` was never spliced
warning: rule prose `Step_pure/unreachable` was never spliced
warning: rule prose `Step_pure/vbinop` was never spliced
warning: rule prose `Step_pure/vbitmask` was never spliced
warning: rule prose `Step_pure/vcvtop` was never spliced
warning: rule prose `Step_pure/vextbinop` was never spliced
warning: rule prose `Step_pure/vextract_lane` was never spliced
warning: rule prose `Step_pure/vextunop` was never spliced
warning: rule prose `Step_pure/vnarrow` was never spliced
warning: rule prose `Step_pure/vrelop` was never spliced
warning: rule prose `Step_pure/vreplace_lane` was never spliced
warning: rule prose `Step_pure/vshiftop` was never spliced
warning: rule prose `Step_pure/vshuffle` was never spliced
warning: rule prose `Step_pure/vsplat` was never spliced
warning: rule prose `Step_pure/vswizzle` was never spliced
warning: rule prose `Step_pure/vtestop` was never spliced
warning: rule prose `Step_pure/vunop` was never spliced
warning: rule prose `Step_pure/vvbinop` was never spliced
warning: rule prose `Step_pure/vvternop` was never spliced
warning: rule prose `Step_pure/vvtestop` was never spliced
warning: rule prose `Step_pure/vvunop` was never spliced
warning: rule prose `Step_read/array.copy` was never spliced
warning: rule prose `Step_read/array.fill` was never spliced
warning: rule prose `Step_read/array.get` was never spliced
warning: rule prose `Step_read/array.init_data` was never spliced
warning: rule prose `Step_read/array.init_elem` was never spliced
warning: rule prose `Step_read/array.len` was never spliced
warning: rule prose `Step_read/array.new_data` was never spliced
warning: rule prose `Step_read/array.new_default` was never spliced
warning: rule prose `Step_read/array.new_elem` was never spliced
warning: rule prose `Step_read/block` was never spliced
warning: rule prose `Step_read/br_on_cast` was never spliced
warning: rule prose `Step_read/br_on_cast_fail` was never spliced
warning: rule prose `Step_read/call` was never spliced
warning: rule prose `Step_read/call_ref` was never spliced
warning: rule prose `Step_read/global.get` was never spliced
warning: rule prose `Step_read/load` was never spliced
warning: rule prose `Step_read/local.get` was never spliced
warning: rule prose `Step_read/loop` was never spliced
warning: rule prose `Step_read/memory.copy` was never spliced
warning: rule prose `Step_read/memory.fill` was never spliced
warning: rule prose `Step_read/memory.init` was never spliced
warning: rule prose `Step_read/memory.size` was never spliced
warning: rule prose `Step_read/ref.cast` was never spliced
warning: rule prose `Step_read/ref.func` was never spliced
warning: rule prose `Step_read/ref.null` was never spliced
warning: rule prose `Step_read/ref.test` was never spliced
warning: rule prose `Step_read/return_call` was never spliced
warning: rule prose `Step_read/return_call_ref` was never spliced
warning: rule prose `Step_read/struct.get` was never spliced
warning: rule prose `Step_read/struct.new_default` was never spliced
warning: rule prose `Step_read/table.copy` was never spliced
warning: rule prose `Step_read/table.fill` was never spliced
warning: rule prose `Step_read/table.get` was never spliced
warning: rule prose `Step_read/table.init` was never spliced
warning: rule prose `Step_read/table.size` was never spliced
warning: rule prose `Step_read/throw_ref` was never spliced
warning: rule prose `Step_read/try_table` was never spliced
warning: rule prose `Step_read/vload` was never spliced
warning: rule prose `Step_read/vload_lane` was never spliced
warning: rule prose `Storagetype_ok` was never spliced
warning: rule prose `Storagetype_sub` was never spliced
warning: rule prose `Subtype_ok` was never spliced
warning: rule prose `Subtype_ok2` was never spliced
warning: rule prose `Table_ok` was never spliced
warning: rule prose `Tabletype_ok` was never spliced
warning: rule prose `Tabletype_sub` was never spliced
warning: rule prose `Tag_ok` was never spliced
warning: rule prose `Tagtype_ok` was never spliced
warning: rule prose `Tagtype_sub` was never spliced
warning: rule prose `Type_ok` was never spliced
warning: rule prose `Types_ok` was never spliced
warning: rule prose `Valtype_ok` was never spliced
warning: rule prose `Valtype_sub` was never spliced
warning: rule prose `Vectype_ok` was never spliced
warning: rule prose `Vectype_sub` was never spliced
warning: definition prose `ANYREF` was never spliced
warning: definition prose `ARRAYREF` was never spliced
warning: definition prose `E` was never spliced
warning: definition prose `EQREF` was never spliced
warning: definition prose `EXTERNREF` was never spliced
warning: definition prose `FN` was never spliced
warning: definition prose `FUNCREF` was never spliced
warning: definition prose `I31REF` was never spliced
warning: definition prose `IN` was never spliced
warning: definition prose `JN` was never spliced
warning: definition prose `Ki` was never spliced
warning: definition prose `M` was never spliced
warning: definition prose `NULLEXTERNREF` was never spliced
warning: definition prose `NULLFUNCREF` was never spliced
warning: definition prose `NULLREF` was never spliced
warning: definition prose `STRUCTREF` was never spliced
warning: definition prose `add_arrayinst` was never spliced
warning: definition prose `add_exninst` was never spliced
warning: definition prose `add_structinst` was never spliced
warning: definition prose `allocXs` was never spliced
warning: definition prose `allocdata` was never spliced
warning: definition prose `allocdatas` was never spliced
warning: definition prose `allocelem` was never spliced
warning: definition prose `allocelems` was never spliced
warning: definition prose `allocexport` was never spliced
warning: definition prose `allocexports` was never spliced
warning: definition prose `allocfunc` was never spliced
warning: definition prose `allocfuncs` was never spliced
warning: definition prose `allocglobal` was never spliced
warning: definition prose `allocglobals` was never spliced
warning: definition prose `allocmem` was never spliced
warning: definition prose `allocmems` was never spliced
warning: definition prose `allocmodule` was never spliced
warning: definition prose `alloctable` was never spliced
warning: definition prose `alloctables` was never spliced
warning: definition prose `alloctag` was never spliced
warning: definition prose `alloctags` was never spliced
warning: definition prose `alloctypes` was never spliced
warning: definition prose `arrayinst` was never spliced
warning: definition prose `binop_` was never spliced
warning: definition prose `blocktype_` was never spliced
warning: definition prose `canon_` was never spliced
warning: definition prose `concat_` was never spliced
warning: definition prose `concatn_` was never spliced
warning: definition prose `const` was never spliced
warning: definition prose `cont` was never spliced
warning: definition prose `cpacknum_` was never spliced
warning: definition prose `cunpack` was never spliced
warning: definition prose `cunpacknum_` was never spliced
warning: definition prose `cvtop__` was never spliced
warning: definition prose `data` was never spliced
warning: definition prose `dataidx_funcs` was never spliced
warning: definition prose `datainst` was never spliced
warning: definition prose `default_` was never spliced
warning: definition prose `diffrt` was never spliced
warning: definition prose `dim` was never spliced
warning: definition prose `disjoint_` was never spliced
warning: definition prose `elem` was never spliced
warning: definition prose `eleminst` was never spliced
warning: definition prose `eval_expr` was never spliced
warning: definition prose `evalglobals` was never spliced
warning: definition prose `exninst` was never spliced
warning: definition prose `expanddt` was never spliced
warning: definition prose `expon` was never spliced
warning: definition prose `fone` was never spliced
warning: definition prose `frame` was never spliced
warning: definition prose `free_absheaptype` was never spliced
warning: definition prose `free_arraytype` was never spliced
warning: definition prose `free_block` was never spliced
warning: definition prose `free_blocktype` was never spliced
warning: definition prose `free_comptype` was never spliced
warning: definition prose `free_consttype` was never spliced
warning: definition prose `free_data` was never spliced
warning: definition prose `free_dataidx` was never spliced
warning: definition prose `free_datamode` was never spliced
warning: definition prose `free_datatype` was never spliced
warning: definition prose `free_deftype` was never spliced
warning: definition prose `free_elem` was never spliced
warning: definition prose `free_elemidx` was never spliced
warning: definition prose `free_elemmode` was never spliced
warning: definition prose `free_elemtype` was never spliced
warning: definition prose `free_export` was never spliced
warning: definition prose `free_expr` was never spliced
warning: definition prose `free_externidx` was never spliced
warning: definition prose `free_externtype` was never spliced
warning: definition prose `free_fieldtype` was never spliced
warning: definition prose `free_func` was never spliced
warning: definition prose `free_funcidx` was never spliced
warning: definition prose `free_functype` was never spliced
warning: definition prose `free_global` was never spliced
warning: definition prose `free_globalidx` was never spliced
warning: definition prose `free_globaltype` was never spliced
warning: definition prose `free_heaptype` was never spliced
warning: definition prose `free_import` was never spliced
warning: definition prose `free_instr` was never spliced
warning: definition prose `free_labelidx` was never spliced
warning: definition prose `free_lanetype` was never spliced
warning: definition prose `free_list` was never spliced
warning: definition prose `free_local` was never spliced
warning: definition prose `free_localidx` was never spliced
warning: definition prose `free_mem` was never spliced
warning: definition prose `free_memidx` was never spliced
warning: definition prose `free_memtype` was never spliced
warning: definition prose `free_module` was never spliced
warning: definition prose `free_moduletype` was never spliced
warning: definition prose `free_numtype` was never spliced
warning: definition prose `free_opt` was never spliced
warning: definition prose `free_packtype` was never spliced
warning: definition prose `free_rectype` was never spliced
warning: definition prose `free_reftype` was never spliced
warning: definition prose `free_resulttype` was never spliced
warning: definition prose `free_shape` was never spliced
warning: definition prose `free_start` was never spliced
warning: definition prose `free_storagetype` was never spliced
warning: definition prose `free_structtype` was never spliced
warning: definition prose `free_subtype` was never spliced
warning: definition prose `free_table` was never spliced
warning: definition prose `free_tableidx` was never spliced
warning: definition prose `free_tabletype` was never spliced
warning: definition prose `free_tag` was never spliced
warning: definition prose `free_type` was never spliced
warning: definition prose `free_typeidx` was never spliced
warning: definition prose `free_typeuse` was never spliced
warning: definition prose `free_valtype` was never spliced
warning: definition prose `free_vectype` was never spliced
warning: definition prose `func` was never spliced
warning: definition prose `funcidx_module` was never spliced
warning: definition prose `funcinst` was never spliced
warning: definition prose `funcsxa` was never spliced
warning: definition prose `funcsxt` was never spliced
warning: definition prose `funcsxx` was never spliced
warning: definition prose `fvbinop_` was never spliced
warning: definition prose `fvrelop_` was never spliced
warning: definition prose `fvunop_` was never spliced
warning: definition prose `fzero` was never spliced
warning: definition prose `global` was never spliced
warning: definition prose `globalinst` was never spliced
warning: definition prose `globalsxa` was never spliced
warning: definition prose `globalsxt` was never spliced
warning: definition prose `globalsxx` was never spliced
warning: definition prose `growmem` was never spliced
warning: definition prose `growtable` was never spliced
warning: definition prose `half__` was never spliced
warning: definition prose `inst_reftype` was never spliced
warning: definition prose `inst_valtype` was never spliced
warning: definition prose `instantiate` was never spliced
warning: definition prose `invfbytes_` was never spliced
warning: definition prose `invibytes_` was never spliced
warning: definition prose `invlanes_` was never spliced
warning: definition prose `invoke` was never spliced
warning: definition prose `invsigned_` was never spliced
warning: definition prose `ivbinop_` was never spliced
warning: definition prose `ivbinopsx_` was never spliced
warning: definition prose `ivrelop_` was never spliced
warning: definition prose `ivrelopsx_` was never spliced
warning: definition prose `ivunop_` was never spliced
warning: definition prose `lanetype` was never spliced
warning: definition prose `list_` was never spliced
warning: definition prose `local` was never spliced
warning: definition prose `lpacknum_` was never spliced
warning: definition prose `lsize` was never spliced
warning: definition prose `lsizenn` was never spliced
warning: definition prose `lsizenn1` was never spliced
warning: definition prose `lsizenn2` was never spliced
warning: definition prose `lunpack` was never spliced
warning: definition prose `lunpacknum_` was never spliced
warning: definition prose `mem` was never spliced
warning: definition prose `memarg0` was never spliced
warning: definition prose `meminst` was never spliced
warning: definition prose `memsxa` was never spliced
warning: definition prose `memsxt` was never spliced
warning: definition prose `memsxx` was never spliced
warning: definition prose `min` was never spliced
warning: definition prose `moduleinst` was never spliced
warning: definition prose `nunpack` was never spliced
warning: definition prose `opt_` was never spliced
warning: definition prose `packfield_` was never spliced
warning: definition prose `psize` was never spliced
warning: definition prose `psizenn` was never spliced
warning: definition prose `relop_` was never spliced
warning: definition prose `rolldt` was never spliced
warning: definition prose `rollrt` was never spliced
warning: definition prose `rundata_` was never spliced
warning: definition prose `runelem_` was never spliced
warning: definition prose `setminus1_` was never spliced
warning: definition prose `setminus_` was never spliced
warning: definition prose `setproduct1_` was never spliced
warning: definition prose `setproduct2_` was never spliced
warning: definition prose `setproduct_` was never spliced
warning: definition prose `shift_labelidxs` was never spliced
warning: definition prose `shsize` was never spliced
warning: definition prose `signed_` was never spliced
warning: definition prose `signif` was never spliced
warning: definition prose `size` was never spliced
warning: definition prose `sizenn` was never spliced
warning: definition prose `sizenn1` was never spliced
warning: definition prose `sizenn2` was never spliced
warning: definition prose `store` was never spliced
warning: definition prose `structinst` was never spliced
warning: definition prose `subst_all_deftype` was never spliced
warning: definition prose `subst_all_deftypes` was never spliced
warning: definition prose `subst_all_moduletype` was never spliced
warning: definition prose `subst_all_reftype` was never spliced
warning: definition prose `subst_all_valtype` was never spliced
warning: definition prose `subst_comptype` was never spliced
warning: definition prose `subst_deftype` was never spliced
warning: definition prose `subst_externtype` was never spliced
warning: definition prose `subst_fieldtype` was never spliced
warning: definition prose `subst_functype` was never spliced
warning: definition prose `subst_globaltype` was never spliced
warning: definition prose `subst_heaptype` was never spliced
warning: definition prose `subst_memtype` was never spliced
warning: definition prose `subst_moduletype` was never spliced
warning: definition prose `subst_numtype` was never spliced
warning: definition prose `subst_packtype` was never spliced
warning: definition prose `subst_rectype` was never spliced
warning: definition prose `subst_reftype` was never spliced
warning: definition prose `subst_storagetype` was never spliced
warning: definition prose `subst_subtype` was never spliced
warning: definition prose `subst_tabletype` was never spliced
warning: definition prose `subst_typeuse` was never spliced
warning: definition prose `subst_typevar` was never spliced
warning: definition prose `subst_valtype` was never spliced
warning: definition prose `subst_vectype` was never spliced
warning: definition prose `sum` was never spliced
warning: definition prose `sx` was never spliced
warning: definition prose `table` was never spliced
warning: definition prose `tableinst` was never spliced
warning: definition prose `tablesxa` was never spliced
warning: definition prose `tablesxt` was never spliced
warning: definition prose `tablesxx` was never spliced
warning: definition prose `tag` was never spliced
warning: definition prose `tagaddr` was never spliced
warning: definition prose `taginst` was never spliced
warning: definition prose `tagsxa` was never spliced
warning: definition prose `tagsxt` was never spliced
warning: definition prose `tagsxx` was never spliced
warning: definition prose `testop_` was never spliced
warning: definition prose `type` was never spliced
warning: definition prose `unop_` was never spliced
warning: definition prose `unpack` was never spliced
warning: definition prose `unpackfield_` was never spliced
warning: definition prose `unpackshape` was never spliced
warning: definition prose `unrolldt` was never spliced
warning: definition prose `unrollrt` was never spliced
warning: definition prose `var` was never spliced
warning: definition prose `vbinop_` was never spliced
warning: definition prose `vcvtop__` was never spliced
warning: definition prose `vextbinop__` was never spliced
warning: definition prose `vextunop__` was never spliced
warning: definition prose `vrelop_` was never spliced
warning: definition prose `vshiftop_` was never spliced
warning: definition prose `vsize` was never spliced
warning: definition prose `vunop_` was never spliced
warning: definition prose `vunpack` was never spliced
warning: definition prose `vvbinop_` was never spliced
warning: definition prose `vvternop_` was never spliced
warning: definition prose `vvunop_` was never spliced
warning: definition prose `with_array` was never spliced
warning: definition prose `with_data` was never spliced
warning: definition prose `with_elem` was never spliced
warning: definition prose `with_global` was never spliced
warning: definition prose `with_local` was never spliced
warning: definition prose `with_mem` was never spliced
warning: definition prose `with_meminst` was never spliced
warning: definition prose `with_struct` was never spliced
warning: definition prose `with_table` was never spliced
warning: definition prose `with_tableinst` was never spliced
warning: definition prose `zero` was never spliced
warning: definition prose `zsize` was never spliced
== Complete.
```

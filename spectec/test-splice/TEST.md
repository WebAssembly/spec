# Preview

```sh
$ (../src/exe-watsup/main.exe ../spec/wasm-3.0/*.watsup -l --splice-latex -p spec-latex.in.tex -w)
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
== Prose Generation...
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 3
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
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
{|\mathsf{i{\scriptstyle32}}|} &=& 32 \\
{|\mathsf{i{\scriptstyle64}}|} &=& 64 \\
{|\mathsf{f{\scriptstyle32}}|} &=& 32 \\
{|\mathsf{f{\scriptstyle64}}|} &=& 64 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(limits)} & {\mathit{limits}} &::=& {}[{\mathit{u{\scriptstyle32}}} .. {\mathit{u{\scriptstyle32}}}] \\[0.8ex]
\mbox{(global type)} & {\mathit{globaltype}} &::=& {\mathit{mut}}~{\mathit{valtype}} \\
\mbox{(function type)} & {\mathit{functype}} &::=& {\mathit{resulttype}} \rightarrow {\mathit{resulttype}} \\
\mbox{(table type)} & {\mathit{tabletype}} &::=& {\mathit{limits}}~{\mathit{reftype}} \\
\mbox{(memory type)} & {\mathit{memtype}} &::=& {\mathit{limits}}~\mathsf{i{\scriptstyle8}} \\[0.8ex]
{} \\[-2ex]
\mbox{(external type)} & {\mathit{externtype}} &::=& \mathsf{func}~{\mathit{deftype}} ~|~ \mathsf{global}~{\mathit{globaltype}} ~|~ \mathsf{table}~{\mathit{tabletype}} ~|~ \mathsf{mem}~{\mathit{memtype}} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrl@{}l@{}}
& {\mathit{instr}} &::=& \dots \\ &&|&
\mathsf{block}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast} \\ &&|&
\mathsf{loop}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast} \\ &&|&
\mathsf{if}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast}~\mathsf{else}~{{\mathit{instr}}^\ast} \\ &&|&
\dots \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrl@{}l@{}}
& {\mathit{instr}} &::=& \dots \\ &&|&
{\mathit{numtype}}.\mathsf{const}~{{\mathit{num}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {{\mathit{unop}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {{\mathit{binop}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {{\mathit{testop}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {{\mathit{relop}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}}_{{1}} . {{{{{\mathit{cvtop}}}{\mathsf{\_}}}{{\mathit{numtype}}_{{2}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}} &\quad
  \mbox{if}~{\mathit{numtype}}_{{1}} \neq {\mathit{numtype}}_{{2}} \\ &&|&
{{{{\mathit{numtype}}.\mathsf{extend}}{{\mathit{n}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathsf{local.get}~{\mathit{localidx}} \\ &&|&
\mathsf{local.set}~{\mathit{localidx}} \\ &&|&
\mathsf{local.tee}~{\mathit{localidx}} \\ &&|&
\mathsf{global.get}~{\mathit{globalidx}} \\ &&|&
\mathsf{global.set}~{\mathit{globalidx}} \\ &&|&
{{\mathit{numtype}}.\mathsf{load}}{{({{{\mathit{w}}}{\mathsf{\_}}}{{\mathit{sx}}})^?}}~{\mathit{memidx}}~{\mathit{memop}} &\quad
  \mbox{if}~({\mathit{numtype}} = {\mathsf{i}}{{\mathit{n}}} \land {\mathit{w}} < {|{\mathsf{i}}{{\mathit{n}}}|})^? \\ &&|&
{{\mathit{numtype}}.\mathsf{store}}{{{\mathit{w}}^?}}~{\mathit{memidx}}~{\mathit{memop}} &\quad
  \mbox{if}~({\mathit{numtype}} = {\mathsf{i}}{{\mathit{n}}} \land {\mathit{w}} < {|{\mathsf{i}}{{\mathit{n}}}|})^? \\ &&|&
{\mathsf{v{\scriptstyle128}.load}}{{{\mathit{vloadop}}^?}}~{\mathit{memidx}}~{\mathit{memop}} \\ &&|&
{{{\mathsf{v{\scriptstyle128}.load}}{{\mathit{w}}}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{memidx}}~{\mathit{memop}}~{\mathit{laneidx}} \\ &&|&
\mathsf{v{\scriptstyle128}.store}~{\mathit{memidx}}~{\mathit{memop}} \\ &&|&
{{{\mathsf{v{\scriptstyle128}.store}}{{\mathit{w}}}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{memidx}}~{\mathit{memop}}~{\mathit{laneidx}} \\ &&|&
\mathsf{memory.size}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.grow}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.fill}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.copy}~{\mathit{memidx}}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.init}~{\mathit{memidx}}~{\mathit{dataidx}} \\ &&|&
\dots \\[0.8ex]
& {\mathit{expr}} &::=& {{\mathit{instr}}^\ast} \\
\end{array}
$$


\subsection*{Typing $\boxed{{\mathit{context}} \vdash {\mathit{instr}} : {\mathit{instrtype}}}$}

An instruction sequence ${{\mathit{instr}}^\ast}$ is well-typed with an instruction type ${{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}$, written ${{\mathit{instr}}^\ast}$ $:$ ${{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}$, according to the following rules:

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \epsilon : \epsilon \rightarrow \epsilon
}
\qquad
\frac{
{\mathit{C}} \vdash {\mathit{instr}}_{{1}} : {{\mathit{t}}_{{1}}^\ast}~{\rightarrow}_{{{\mathit{x}}_{{1}}^\ast}}\,{{\mathit{t}}_{{2}}^\ast}
 \qquad
({\mathit{C}}.\mathsf{local}{}[{\mathit{x}}_{{1}}] = {\mathit{init}}~{\mathit{t}})^\ast
 \qquad
{\mathit{C}}{}[\mathsf{local}{}[{{\mathit{x}}_{{1}}^\ast}] = {(\mathsf{set}~{\mathit{t}})^\ast}] \vdash {{\mathit{instr}}_{{2}}^\ast} : {{\mathit{t}}_{{2}}^\ast}~{\rightarrow}_{{{\mathit{x}}_{{2}}^\ast}}\,{{\mathit{t}}_{{3}}^\ast}
}{
{\mathit{C}} \vdash {\mathit{instr}}_{{1}}~{{\mathit{instr}}_{{2}}^\ast} : {{\mathit{t}}_{{1}}^\ast}~{\rightarrow}_{{{\mathit{x}}_{{1}}^\ast}~{{\mathit{x}}_{{2}}^\ast}}\,{{\mathit{t}}_{{3}}^\ast}
}
\\[3ex]\displaystyle
\frac{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : {{\mathit{t}}_{{1}}^\ast}~{\rightarrow}_{{{\mathit{x}}^\ast}}\,{{\mathit{t}}_{{2}}^\ast}
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}^\ast} : \mathsf{ok}
}{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : ({{\mathit{t}}^\ast}~{{\mathit{t}}_{{1}}^\ast})~{\rightarrow}_{{{\mathit{x}}^\ast}}\,({{\mathit{t}}^\ast}~{{\mathit{t}}_{{2}}^\ast})
}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \epsilon : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr*{-}empty}]}
\qquad
\frac{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : {{\mathit{t}}_{{1}}^\ast}~{\rightarrow}_{{{\mathit{x}}^\ast}}\,{{\mathit{t}}_{{2}}^\ast}
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}^\ast} : \mathsf{ok}
}{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : ({{\mathit{t}}^\ast}~{{\mathit{t}}_{{1}}^\ast})~{\rightarrow}_{{{\mathit{x}}^\ast}}\,({{\mathit{t}}^\ast}~{{\mathit{t}}_{{2}}^\ast})
} \, {[\textsc{\scriptsize T{-}instr*{-}frame}]}
\\[3ex]\displaystyle
\frac{
}{
{\mathit{C}} \vdash \epsilon : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr*{-}empty}]}
\qquad
\frac{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : {{\mathit{t}}_{{1}}^\ast}~{\rightarrow}_{{{\mathit{x}}^\ast}}\,{{\mathit{t}}_{{2}}^\ast}
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}^\ast} : \mathsf{ok}
}{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : ({{\mathit{t}}^\ast}~{{\mathit{t}}_{{1}}^\ast})~{\rightarrow}_{{{\mathit{x}}^\ast}}\,({{\mathit{t}}^\ast}~{{\mathit{t}}_{{2}}^\ast})
} \, {[\textsc{\scriptsize T{-}instr*{-}frame}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{unreachable} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
}
\qquad
\frac{
}{
{\mathit{C}} \vdash \mathsf{nop} : \epsilon \rightarrow \epsilon
}
\qquad
\frac{
{\mathit{C}} \vdash {\mathit{t}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{drop} : {\mathit{t}} \rightarrow \epsilon
}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{bt}} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
 \qquad
{\mathit{C}}, \mathsf{label}~({{\mathit{t}}_{{2}}^\ast}) \vdash {{\mathit{instr}}^\ast} : {{\mathit{t}}_{{1}}^\ast}~{\rightarrow}_{{{\mathit{x}}^\ast}}\,{{\mathit{t}}_{{2}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}^\ast} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}block}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{bt}} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
 \qquad
{\mathit{C}}, \mathsf{label}~({{\mathit{t}}_{{1}}^\ast}) \vdash {{\mathit{instr}}^\ast} : {{\mathit{t}}_{{1}}^\ast}~{\rightarrow}_{{{\mathit{x}}^\ast}}\,{{\mathit{t}}_{{2}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}loop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{bt}} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
 \qquad
{\mathit{C}}, \mathsf{label}~({{\mathit{t}}_{{2}}^\ast}) \vdash {{\mathit{instr}}_{{1}}^\ast} : {{\mathit{t}}_{{1}}^\ast}~{\rightarrow}_{{{\mathit{x}}_{{1}}^\ast}}\,{{\mathit{t}}_{{2}}^\ast}
 \qquad
{\mathit{C}}, \mathsf{label}~({{\mathit{t}}_{{2}}^\ast}) \vdash {{\mathit{instr}}_{{2}}^\ast} : {{\mathit{t}}_{{1}}^\ast}~{\rightarrow}_{{{\mathit{x}}_{{2}}^\ast}}\,{{\mathit{t}}_{{2}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_{{1}}^\ast}~\mathsf{else}~{{\mathit{instr}}_{{2}}^\ast} : {{\mathit{t}}_{{1}}^\ast}~\mathsf{i{\scriptstyle32}} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}if}]}
\qquad
\end{array}
$$





\subsection*{Runtime}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{default}}}_{\mathsf{i{\scriptstyle32}}} &=& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) \\
{{\mathrm{default}}}_{\mathsf{i{\scriptstyle64}}} &=& (\mathsf{i{\scriptstyle64}}.\mathsf{const}~0) \\
{{\mathrm{default}}}_{\mathsf{f{\scriptstyle32}}} &=& (\mathsf{f{\scriptstyle32}}.\mathsf{const}~{+0}) \\
{{\mathrm{default}}}_{\mathsf{f{\scriptstyle64}}} &=& (\mathsf{f{\scriptstyle64}}.\mathsf{const}~{+0}) \\
{{\mathrm{default}}}_{\mathsf{v{\scriptstyle128}}} &=& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~0) \\
{{\mathrm{default}}}_{\mathsf{ref}~\mathsf{null}~{\mathit{ht}}} &=& (\mathsf{ref.null}~{\mathit{ht}}) \\
{{\mathrm{default}}}_{\mathsf{ref}~\epsilon~{\mathit{ht}}} &=& \epsilon \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{module}.\mathsf{func} &=& {\mathit{f}}.\mathsf{module}.\mathsf{func} \\
({\mathit{s}} ; {\mathit{f}}).\mathsf{func} &=& {\mathit{s}}.\mathsf{func} \\[0.8ex]
({\mathit{s}} ; {\mathit{f}}).\mathsf{func}{}[{\mathit{x}}] &=& {\mathit{s}}.\mathsf{func}{}[{\mathit{f}}.\mathsf{module}.\mathsf{func}{}[{\mathit{x}}]] \\
({\mathit{s}} ; {\mathit{f}}).\mathsf{table}{}[{\mathit{x}}] &=& {\mathit{s}}.\mathsf{table}{}[{\mathit{f}}.\mathsf{module}.\mathsf{table}{}[{\mathit{x}}]] \\
\end{array}
$$


\subsection*{Reduction $\boxed{{{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}}^\ast}}$}

The relation ${\mathit{config}} \hookrightarrow {\mathit{config}}$ checks that a function type is well-formed.

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
& {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow& {\mathit{z}} ; {{\mathit{instr}'}^\ast} &\quad
  \mbox{if}~{{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\[0.8ex]
& {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow& {\mathit{z}} ; {{\mathit{instr}'}^\ast} &\quad
  \mbox{if}~{\mathit{z}} ; {{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}block}]} \quad & {\mathit{z}} ; {{\mathit{val}}^{{\mathit{k}}}}~(\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{{\mathit{n}}}}{\{\epsilon\}}~({{\mathit{val}}^{{\mathit{k}}}}, {{\mathit{instr}}^\ast})) &\quad
  \mbox{if}~{{\mathrm{blocktype}}}_{{\mathit{z}}}({\mathit{bt}}) = {{\mathit{t}}_{{1}}^{{\mathit{k}}}} \rightarrow {{\mathit{t}}_{{2}}^{{\mathit{n}}}} \\
{[\textsc{\scriptsize E{-}loop}]} \quad & {\mathit{z}} ; {{\mathit{val}}^{{\mathit{k}}}}~(\mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{{\mathit{k}}}}{\{\mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast}\}}~({{\mathit{val}}^{{\mathit{k}}}}, {{\mathit{instr}}^\ast})) &\quad
  \mbox{if}~{{\mathrm{blocktype}}}_{{\mathit{z}}}({\mathit{bt}}) = {{\mathit{t}}_{{1}}^{{\mathit{k}}}} \rightarrow {{\mathit{t}}_{{2}}^{{\mathit{n}}}} \\[0.8ex]
{[\textsc{\scriptsize E{-}if{-}true}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_{{1}}^\ast}~\mathsf{else}~{{\mathit{instr}}_{{2}}^\ast}) &\hookrightarrow& (\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}_{{1}}^\ast}) &\quad
  \mbox{if}~{\mathit{c}} \neq 0 \\
{[\textsc{\scriptsize E{-}if{-}false}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_{{1}}^\ast}~\mathsf{else}~{{\mathit{instr}}_{{2}}^\ast}) &\hookrightarrow& (\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}_{{2}}^\ast}) &\quad
  \mbox{if}~{\mathit{c}} = 0 \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}if{-}true}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_{{1}}^\ast}~\mathsf{else}~{{\mathit{instr}}_{{2}}^\ast}) &\hookrightarrow& (\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}_{{1}}^\ast}) &\quad
  \mbox{if}~{\mathit{c}} \neq 0 \\
{[\textsc{\scriptsize E{-}if{-}false}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_{{1}}^\ast}~\mathsf{else}~{{\mathit{instr}}_{{2}}^\ast}) &\hookrightarrow& (\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}_{{2}}^\ast}) &\quad
  \mbox{if}~{\mathit{c}} = 0 \\
\end{array}
$$

\end{document}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

warning: syntax `A` was never spliced
warning: syntax `B` was never spliced
warning: syntax `E` was never spliced
warning: syntax `M` was never spliced
warning: syntax `N` was never spliced
warning: syntax `absheaptype/syn` was never spliced
warning: syntax `absheaptype/sem` was never spliced
warning: syntax `addr` was never spliced
warning: syntax `addrref` was never spliced
warning: syntax `admininstr` was never spliced
warning: syntax `arrayaddr` was never spliced
warning: syntax `arrayinst` was never spliced
warning: syntax `arraytype` was never spliced
warning: syntax `binop_` was never spliced
warning: syntax `binop_` was never spliced
warning: syntax `bit` was never spliced
warning: syntax `blocktype` was never spliced
warning: syntax `byte` was never spliced
warning: syntax `castop` was never spliced
warning: syntax `char` was never spliced
warning: syntax `cnn` was never spliced
warning: syntax `code` was never spliced
warning: syntax `comptype` was never spliced
warning: syntax `config` was never spliced
warning: syntax `consttype` was never spliced
warning: syntax `context` was never spliced
warning: syntax `cvtop` was never spliced
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
warning: syntax `export` was never spliced
warning: syntax `exportinst` was never spliced
warning: syntax `externidx` was never spliced
warning: syntax `externval` was never spliced
warning: syntax `f32` was never spliced
warning: syntax `f64` was never spliced
warning: syntax `fN` was never spliced
warning: syntax `fNmag` was never spliced
warning: syntax `fieldtype` was never spliced
warning: syntax `fieldval` was never spliced
warning: syntax `fin` was never spliced
warning: syntax `fnn` was never spliced
warning: syntax `frame` was never spliced
warning: syntax `fshape` was never spliced
warning: syntax `func` was never spliced
warning: syntax `funcaddr` was never spliced
warning: syntax `funcidx` was never spliced
warning: syntax `funcinst` was never spliced
warning: syntax `global` was never spliced
warning: syntax `globaladdr` was never spliced
warning: syntax `globalidx` was never spliced
warning: syntax `globalinst` was never spliced
warning: syntax `half` was never spliced
warning: syntax `heaptype/syn` was never spliced
warning: syntax `heaptype/sem` was never spliced
warning: syntax `hostaddr` was never spliced
warning: syntax `iN` was never spliced
warning: syntax `idx` was never spliced
warning: syntax `imm` was never spliced
warning: syntax `import` was never spliced
warning: syntax `init` was never spliced
warning: syntax `inn` was never spliced
warning: syntax `instr/parametric` was never spliced
warning: syntax `instr/br` was never spliced
warning: syntax `instr/call` was never spliced
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
warning: syntax `instrtype` was never spliced
warning: syntax `ishape` was never spliced
warning: syntax `labelidx` was never spliced
warning: syntax `lane_` was never spliced
warning: syntax `lane_` was never spliced
warning: syntax `lane_` was never spliced
warning: syntax `laneidx` was never spliced
warning: syntax `lanetype` was never spliced
warning: syntax `list` was never spliced
warning: syntax `lnn` was never spliced
warning: syntax `local` was never spliced
warning: syntax `localidx` was never spliced
warning: syntax `localtype` was never spliced
warning: syntax `m` was never spliced
warning: syntax `mem` was never spliced
warning: syntax `memaddr` was never spliced
warning: syntax `memidx` was never spliced
warning: syntax `memidxop` was never spliced
warning: syntax `meminst` was never spliced
warning: syntax `memop` was never spliced
warning: syntax `module` was never spliced
warning: syntax `moduleinst` was never spliced
warning: syntax `mut` was never spliced
warning: syntax `n` was never spliced
warning: syntax `name` was never spliced
warning: syntax `nul` was never spliced
warning: syntax `num` was never spliced
warning: syntax `num_` was never spliced
warning: syntax `num_` was never spliced
warning: syntax `numtype` was never spliced
warning: syntax `oktypeidx` was never spliced
warning: syntax `oktypeidxnat` was never spliced
warning: syntax `pack_` was never spliced
warning: syntax `packsize` was never spliced
warning: syntax `packtype` was never spliced
warning: syntax `packval` was never spliced
warning: syntax `pnn` was never spliced
warning: syntax `pshape` was never spliced
warning: syntax `pth` was never spliced
warning: syntax `pthaux` was never spliced
warning: syntax `record` was never spliced
warning: syntax `recorddots` was never spliced
warning: syntax `recordeq` was never spliced
warning: syntax `recordstar` was never spliced
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
warning: syntax `state` was never spliced
warning: syntax `storagetype` was never spliced
warning: syntax `store` was never spliced
warning: syntax `structaddr` was never spliced
warning: syntax `structinst` was never spliced
warning: syntax `structtype` was never spliced
warning: syntax `subtype/syn` was never spliced
warning: syntax `subtype/sem` was never spliced
warning: syntax `sx` was never spliced
warning: syntax `sym` was never spliced
warning: syntax `symsplit/1` was never spliced
warning: syntax `symsplit/2` was never spliced
warning: syntax `table` was never spliced
warning: syntax `tableaddr` was never spliced
warning: syntax `tableidx` was never spliced
warning: syntax `tableinst` was never spliced
warning: syntax `testop_` was never spliced
warning: syntax `type` was never spliced
warning: syntax `typeidx` was never spliced
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
warning: syntax `vcvtop` was never spliced
warning: syntax `vec` was never spliced
warning: syntax `vec_` was never spliced
warning: syntax `vectype` was never spliced
warning: syntax `vextbinop_` was never spliced
warning: syntax `vextunop_` was never spliced
warning: syntax `vloadop` was never spliced
warning: syntax `vnn` was never spliced
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
warning: syntax `ww` was never spliced
warning: syntax `zero` was never spliced
warning: syntax `zval_` was never spliced
warning: syntax `zval_` was never spliced
warning: syntax `zval_` was never spliced
warning: grammar `Babsheaptype` was never spliced
warning: grammar `Bblocktype` was never spliced
warning: grammar `Bbyte` was never spliced
warning: grammar `Bcastop` was never spliced
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
warning: grammar `Binstr/reference` was never spliced
warning: grammar `Binstr/struct` was never spliced
warning: grammar `Binstr/parametric` was never spliced
warning: grammar `Binstr/variable` was never spliced
warning: grammar `Binstr/table` was never spliced
warning: grammar `Binstr/memory` was never spliced
warning: grammar `Binstr/numeric-const` was never spliced
warning: grammar `Binstr/numeric-test-i32` was never spliced
warning: grammar `Binstr/numeric-rel-i32` was never spliced
warning: grammar `Binstr/numeric-test-i64` was never spliced
warning: grammar `Binstr/numeric-rel-i64` was never spliced
warning: grammar `Binstr/numeric-rel-f32` was never spliced
warning: grammar `Binstr/numeric-rel-f64` was never spliced
warning: grammar `Binstr/numeric-un-i32` was never spliced
warning: grammar `Binstr/numeric-bin-i32` was never spliced
warning: grammar `Binstr/numeric-un-i64` was never spliced
warning: grammar `Binstr/numeric-bin-i64` was never spliced
warning: grammar `Binstr/numeric-un-f32` was never spliced
warning: grammar `Binstr/numeric-bin-f32` was never spliced
warning: grammar `Binstr/numeric-un-f64` was never spliced
warning: grammar `Binstr/numeric-bin-f64` was never spliced
warning: grammar `Binstr/numeric-cvt` was never spliced
warning: grammar `Binstr/numeric-extend` was never spliced
warning: grammar `Binstr/vector-memory` was never spliced
warning: grammar `Binstr/vector-const` was never spliced
warning: grammar `Binstr/vector-shuffle` was never spliced
warning: grammar `Binstr/vector-lanes` was never spliced
warning: grammar `Binstr/vector-swizzle` was never spliced
warning: grammar `Binstr/vector-splat` was never spliced
warning: grammar `Binstr/vector-rel-i8x16` was never spliced
warning: grammar `Binstr/vector-rel-i16x8` was never spliced
warning: grammar `Binstr/vector-rel-i32x4` was never spliced
warning: grammar `Binstr/vector-rel-i64x2` was never spliced
warning: grammar `Binstr/vector-rel-f32x4` was never spliced
warning: grammar `Binstr/vector-rel-f64x2` was never spliced
warning: grammar `Binstr/vector-vv` was never spliced
warning: grammar `Binstr/vector-v-i8x16` was never spliced
warning: grammar `Binstr/vector-v-i16x8` was never spliced
warning: grammar `Binstr/vector-v-i32x4` was never spliced
warning: grammar `Binstr/vector-v-i64x2` was never spliced
warning: grammar `Binstr/vector-v-f32x4` was never spliced
warning: grammar `Binstr/vector-v-f64x2` was never spliced
warning: grammar `Binstr/vector-cvt` was never spliced
warning: grammar `Blabelidx` was never spliced
warning: grammar `Blaneidx` was never spliced
warning: grammar `Blimits` was never spliced
warning: grammar `Blocalidx` was never spliced
warning: grammar `Blocals` was never spliced
warning: grammar `Bmem` was never spliced
warning: grammar `Bmemidx` was never spliced
warning: grammar `Bmemop` was never spliced
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
warning: grammar `Btable` was never spliced
warning: grammar `Btableidx` was never spliced
warning: grammar `Btablesec` was never spliced
warning: grammar `Btabletype` was never spliced
warning: grammar `Btype` was never spliced
warning: grammar `Btypeidx` was never spliced
warning: grammar `Btypesec` was never spliced
warning: grammar `Bu32` was never spliced
warning: grammar `Bu64` was never spliced
warning: grammar `BuN` was never spliced
warning: grammar `Bvaltype` was never spliced
warning: grammar `Bvec` was never spliced
warning: grammar `Bvectype` was never spliced
warning: rule `Blocktype_ok/valtype` was never spliced
warning: rule `Blocktype_ok/typeidx` was never spliced
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
warning: rule `Externidx_ok/func` was never spliced
warning: rule `Externidx_ok/global` was never spliced
warning: rule `Externidx_ok/table` was never spliced
warning: rule `Externidx_ok/mem` was never spliced
warning: rule `Externtype_ok/func` was never spliced
warning: rule `Externtype_ok/global` was never spliced
warning: rule `Externtype_ok/table` was never spliced
warning: rule `Externtype_ok/mem` was never spliced
warning: rule `Externtype_sub/func` was never spliced
warning: rule `Externtype_sub/global` was never spliced
warning: rule `Externtype_sub/table` was never spliced
warning: rule `Externtype_sub/mem` was never spliced
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
warning: rule `Instr_ok/const` was never spliced
warning: rule `Instr_ok/unop` was never spliced
warning: rule `Instr_ok/binop` was never spliced
warning: rule `Instr_ok/testop` was never spliced
warning: rule `Instr_ok/relop` was never spliced
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
warning: rule `Instr_ok/vbitmask` was never spliced
warning: rule `Instr_ok/vswizzle` was never spliced
warning: rule `Instr_ok/vshuffle` was never spliced
warning: rule `Instr_ok/vsplat` was never spliced
warning: rule `Instr_ok/vextract_lane` was never spliced
warning: rule `Instr_ok/vreplace_lane` was never spliced
warning: rule `Instr_ok/vunop` was never spliced
warning: rule `Instr_ok/vbinop` was never spliced
warning: rule `Instr_ok/vtestop` was never spliced
warning: rule `Instr_ok/vrelop` was never spliced
warning: rule `Instr_ok/vshiftop` was never spliced
warning: rule `Instr_ok/vcvtop` was never spliced
warning: rule `Instr_ok/vnarrow` was never spliced
warning: rule `Instr_ok/vextunop` was never spliced
warning: rule `Instr_ok/vextbinop` was never spliced
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
warning: rule `Instr_ok/memory.grow` was never spliced
warning: rule `Instr_ok/memory.fill` was never spliced
warning: rule `Instr_ok/memory.copy` was never spliced
warning: rule `Instr_ok/memory.init` was never spliced
warning: rule `Instr_ok/data.drop` was never spliced
warning: rule `Instr_ok/load` was never spliced
warning: rule `Instr_ok/store` was never spliced
warning: rule `Instr_ok/vload` was never spliced
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
warning: rule `Numtype_ok` was never spliced
warning: rule `Numtype_sub` was never spliced
warning: rule `Packtype_ok` was never spliced
warning: rule `Packtype_sub` was never spliced
warning: rule `Rectype_ok/empty` was never spliced
warning: rule `Rectype_ok/cons` was never spliced
warning: rule `Rectype_ok/rec2` was never spliced
warning: rule `Rectype_ok2/empty` was never spliced
warning: rule `Rectype_ok2/cons` was never spliced
warning: rule `Ref_ok/null` was never spliced
warning: rule `Ref_ok/i31` was never spliced
warning: rule `Ref_ok/struct` was never spliced
warning: rule `Ref_ok/array` was never spliced
warning: rule `Ref_ok/func` was never spliced
warning: rule `Ref_ok/host` was never spliced
warning: rule `Ref_ok/extern` was never spliced
warning: rule `Reftype_ok` was never spliced
warning: rule `Reftype_sub/nonnull` was never spliced
warning: rule `Reftype_sub/null` was never spliced
warning: rule `Resulttype_ok` was never spliced
warning: rule `Resulttype_sub` was never spliced
warning: rule `Start_ok` was never spliced
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
warning: rule `Step_pure/br-zero` was never spliced
warning: rule `Step_pure/br-succ` was never spliced
warning: rule `Step_pure/br_if-true` was never spliced
warning: rule `Step_pure/br_if-false` was never spliced
warning: rule `Step_pure/br_table-lt` was never spliced
warning: rule `Step_pure/br_table-ge` was never spliced
warning: rule `Step_pure/br_on_null-null` was never spliced
warning: rule `Step_pure/br_on_null-addr` was never spliced
warning: rule `Step_pure/br_on_non_null-null` was never spliced
warning: rule `Step_pure/br_on_non_null-addr` was never spliced
warning: rule `Step_pure/call_indirect-call` was never spliced
warning: rule `Step_pure/return_call_indirect` was never spliced
warning: rule `Step_pure/frame-vals` was never spliced
warning: rule `Step_pure/return-frame` was never spliced
warning: rule `Step_pure/return-label` was never spliced
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
warning: rule `Step_pure/vswizzle` was never spliced
warning: rule `Step_pure/vshuffle` was never spliced
warning: rule `Step_pure/vsplat` was never spliced
warning: rule `Step_pure/vextract_lane-num` was never spliced
warning: rule `Step_pure/vextract_lane-pack` was never spliced
warning: rule `Step_pure/vreplace_lane` was never spliced
warning: rule `Step_pure/vunop` was never spliced
warning: rule `Step_pure/vbinop-val` was never spliced
warning: rule `Step_pure/vbinop-trap` was never spliced
warning: rule `Step_pure/vrelop` was never spliced
warning: rule `Step_pure/vshiftop` was never spliced
warning: rule `Step_pure/vtestop-true` was never spliced
warning: rule `Step_pure/vtestop-false` was never spliced
warning: rule `Step_pure/vbitmask` was never spliced
warning: rule `Step_pure/vnarrow` was never spliced
warning: rule `Step_pure/vcvtop-normal` was never spliced
warning: rule `Step_pure/vcvtop-half` was never spliced
warning: rule `Step_pure/vcvtop-zero` was never spliced
warning: rule `Step_pure/vextunop` was never spliced
warning: rule `Step_pure/vextbinop` was never spliced
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
warning: rule `Step_read/return_call_ref-frame-addr` was never spliced
warning: rule `Step_read/return_call_ref-frame-null` was never spliced
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
warning: rule `Step_read/vload-shape-oob` was never spliced
warning: rule `Step_read/vload-shape-val` was never spliced
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
warning: rule `Type_ok` was never spliced
warning: rule `Types_ok/empty` was never spliced
warning: rule `Types_ok/cons` was never spliced
warning: rule `Valtype_ok/num` was never spliced
warning: rule `Valtype_ok/vec` was never spliced
warning: rule `Valtype_ok/ref` was never spliced
warning: rule `Valtype_ok/bot` was never spliced
warning: rule `Valtype_sub/num` was never spliced
warning: rule `Valtype_sub/vec` was never spliced
warning: rule `Valtype_sub/ref` was never spliced
warning: rule `Valtype_sub/bot` was never spliced
warning: rule `Vectype_ok` was never spliced
warning: rule `Vectype_sub` was never spliced
warning: definition `E` was never spliced
warning: definition `Ki` was never spliced
warning: definition `M` was never spliced
warning: definition `allocdata` was never spliced
warning: definition `allocdatas` was never spliced
warning: definition `allocelem` was never spliced
warning: definition `allocelems` was never spliced
warning: definition `allocfunc` was never spliced
warning: definition `allocfuncs` was never spliced
warning: definition `allocglobal` was never spliced
warning: definition `allocglobals` was never spliced
warning: definition `allocmem` was never spliced
warning: definition `allocmems` was never spliced
warning: definition `allocmodule` was never spliced
warning: definition `alloctable` was never spliced
warning: definition `alloctables` was never spliced
warning: definition `alloctypes` was never spliced
warning: definition `arrayinst` was never spliced
warning: definition `before` was never spliced
warning: definition `binop` was never spliced
warning: definition `blocktype` was never spliced
warning: definition `canon_` was never spliced
warning: definition `cbytes` was never spliced
warning: definition `clostype` was never spliced
warning: definition `clostypes` was never spliced
warning: definition `concat_` was never spliced
warning: definition `const` was never spliced
warning: definition `convert` was never spliced
warning: definition `cunpack` was never spliced
warning: definition `cvtop` was never spliced
warning: definition `data` was never spliced
warning: definition `datainst` was never spliced
warning: definition `demote` was never spliced
warning: definition `diffrt` was never spliced
warning: definition `dim` was never spliced
warning: definition `elem` was never spliced
warning: definition `eleminst` was never spliced
warning: definition `expanddt` was never spliced
warning: definition `expon` was never spliced
warning: definition `ext` was never spliced
warning: definition `ext_arrayinst` was never spliced
warning: definition `ext_structinst` was never spliced
warning: definition `fabs` was never spliced
warning: definition `fadd` was never spliced
warning: definition `fbits` was never spliced
warning: definition `fbytes` was never spliced
warning: definition `fceil` was never spliced
warning: definition `fcopysign` was never spliced
warning: definition `fdiv` was never spliced
warning: definition `feq` was never spliced
warning: definition `ffloor` was never spliced
warning: definition `fge` was never spliced
warning: definition `fgt` was never spliced
warning: definition `fle` was never spliced
warning: definition `flt` was never spliced
warning: definition `fmax` was never spliced
warning: definition `fmin` was never spliced
warning: definition `fmul` was never spliced
warning: definition `fne` was never spliced
warning: definition `fnearest` was never spliced
warning: definition `fneg` was never spliced
warning: definition `fone` was never spliced
warning: definition `fpmax` was never spliced
warning: definition `fpmin` was never spliced
warning: definition `frame` was never spliced
warning: definition `free_dataidx_expr` was never spliced
warning: definition `free_dataidx_func` was never spliced
warning: definition `free_dataidx_funcs` was never spliced
warning: definition `free_dataidx_instr` was never spliced
warning: definition `free_dataidx_instrs` was never spliced
warning: definition `fsqrt` was never spliced
warning: definition `fsub` was never spliced
warning: definition `ftrunc` was never spliced
warning: definition `funcsxt` was never spliced
warning: definition `funcsxv` was never spliced
warning: definition `fzero` was never spliced
warning: definition `global` was never spliced
warning: definition `globalinst` was never spliced
warning: definition `globalsxt` was never spliced
warning: definition `globalsxv` was never spliced
warning: definition `growmemory` was never spliced
warning: definition `growtable` was never spliced
warning: definition `halfop` was never spliced
warning: definition `iabs` was never spliced
warning: definition `iadd` was never spliced
warning: definition `iaddsat` was never spliced
warning: definition `iand` was never spliced
warning: definition `iandnot` was never spliced
warning: definition `iavgr_u` was never spliced
warning: definition `ibits` was never spliced
warning: definition `ibitselect` was never spliced
warning: definition `ibytes` was never spliced
warning: definition `iclz` was never spliced
warning: definition `ictz` was never spliced
warning: definition `idiv` was never spliced
warning: definition `idx` was never spliced
warning: definition `ieq` was never spliced
warning: definition `ieqz` was never spliced
warning: definition `ige` was never spliced
warning: definition `igt` was never spliced
warning: definition `ile` was never spliced
warning: definition `ilt` was never spliced
warning: definition `imax` was never spliced
warning: definition `imin` was never spliced
warning: definition `imul` was never spliced
warning: definition `in_binop` was never spliced
warning: definition `in_numtype` was never spliced
warning: definition `ine` was never spliced
warning: definition `ineg` was never spliced
warning: definition `inot` was never spliced
warning: definition `inst_reftype` was never spliced
warning: definition `instantiate` was never spliced
warning: definition `instexport` was never spliced
warning: definition `invfbytes` was never spliced
warning: definition `invibytes` was never spliced
warning: definition `invlanes_` was never spliced
warning: definition `invoke` was never spliced
warning: definition `invsigned` was never spliced
warning: definition `ior` was never spliced
warning: definition `ipopcnt` was never spliced
warning: definition `iq15mulrsat_s` was never spliced
warning: definition `irem` was never spliced
warning: definition `irotl` was never spliced
warning: definition `irotr` was never spliced
warning: definition `ishl` was never spliced
warning: definition `ishr` was never spliced
warning: definition `isize` was never spliced
warning: definition `isub` was never spliced
warning: definition `isubsat` was never spliced
warning: definition `ixor` was never spliced
warning: definition `lanes_` was never spliced
warning: definition `lanetype` was never spliced
warning: definition `local` was never spliced
warning: definition `lsize` was never spliced
warning: definition `lunpack` was never spliced
warning: definition `mem` was never spliced
warning: definition `meminst` was never spliced
warning: definition `memop0` was never spliced
warning: definition `memsxt` was never spliced
warning: definition `memsxv` was never spliced
warning: definition `min` was never spliced
warning: definition `moduleinst` was never spliced
warning: definition `narrow` was never spliced
warning: definition `nbytes` was never spliced
warning: definition `nunpack` was never spliced
warning: definition `packconst` was never spliced
warning: definition `packfield` was never spliced
warning: definition `packnum` was never spliced
warning: definition `promote` was never spliced
warning: definition `psize` was never spliced
warning: definition `reinterpret` was never spliced
warning: definition `relop` was never spliced
warning: definition `rolldt` was never spliced
warning: definition `rollrt` was never spliced
warning: definition `rundata` was never spliced
warning: definition `runelem` was never spliced
warning: definition `s33_to_u32` was never spliced
warning: definition `setminus` was never spliced
warning: definition `setminus1` was never spliced
warning: definition `shsize` was never spliced
warning: definition `signed` was never spliced
warning: definition `signif` was never spliced
warning: definition `sizenn` was never spliced
warning: definition `store` was never spliced
warning: definition `structinst` was never spliced
warning: definition `subst_all_deftype` was never spliced
warning: definition `subst_all_deftypes` was never spliced
warning: definition `subst_all_reftype` was never spliced
warning: definition `subst_comptype` was never spliced
warning: definition `subst_deftype` was never spliced
warning: definition `subst_externtype` was never spliced
warning: definition `subst_fieldtype` was never spliced
warning: definition `subst_functype` was never spliced
warning: definition `subst_globaltype` was never spliced
warning: definition `subst_heaptype` was never spliced
warning: definition `subst_memtype` was never spliced
warning: definition `subst_numtype` was never spliced
warning: definition `subst_packtype` was never spliced
warning: definition `subst_rectype` was never spliced
warning: definition `subst_reftype` was never spliced
warning: definition `subst_storagetype` was never spliced
warning: definition `subst_subtype` was never spliced
warning: definition `subst_tabletype` was never spliced
warning: definition `subst_typevar` was never spliced
warning: definition `subst_valtype` was never spliced
warning: definition `subst_vectype` was never spliced
warning: definition `sum` was never spliced
warning: definition `sx` was never spliced
warning: definition `tableinst` was never spliced
warning: definition `tablesxt` was never spliced
warning: definition `tablesxv` was never spliced
warning: definition `testop` was never spliced
warning: definition `trunc` was never spliced
warning: definition `trunc_sat` was never spliced
warning: definition `type` was never spliced
warning: definition `unop` was never spliced
warning: definition `unpack` was never spliced
warning: definition `unpackfield` was never spliced
warning: definition `unpacknum` was never spliced
warning: definition `unrolldt` was never spliced
warning: definition `unrollht` was never spliced
warning: definition `unrollrt` was never spliced
warning: definition `utf8` was never spliced
warning: definition `vbinop` was never spliced
warning: definition `vbytes` was never spliced
warning: definition `vcvtop` was never spliced
warning: definition `vextbinop` was never spliced
warning: definition `vextunop` was never spliced
warning: definition `vishiftop` was never spliced
warning: definition `vrelop` was never spliced
warning: definition `vsize` was never spliced
warning: definition `vunop` was never spliced
warning: definition `vunpack` was never spliced
warning: definition `vvbinop` was never spliced
warning: definition `vvternop` was never spliced
warning: definition `vvunop` was never spliced
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
warning: definition `wrap` was never spliced
warning: definition `zbytes` was never spliced
warning: definition `zero` was never spliced
warning: definition `zsize` was never spliced
warning: rule prose `exec/array.new_data` was never spliced
warning: rule prose `exec/call_ref` was never spliced
warning: rule prose `exec/data.drop` was never spliced
warning: rule prose `exec/memory.grow` was never spliced
warning: rule prose `exec/vstore_lane` was never spliced
warning: rule prose `exec/vstore` was never spliced
warning: rule prose `exec/store` was never spliced
warning: rule prose `exec/elem.drop` was never spliced
warning: rule prose `exec/table.grow` was never spliced
warning: rule prose `exec/table.set` was never spliced
warning: rule prose `exec/global.set` was never spliced
warning: rule prose `exec/local.set` was never spliced
warning: rule prose `exec/array.set` was never spliced
warning: rule prose `exec/array.new_fixed` was never spliced
warning: rule prose `exec/struct.set` was never spliced
warning: rule prose `exec/struct.new` was never spliced
warning: rule prose `exec/memory.init` was never spliced
warning: rule prose `exec/memory.copy` was never spliced
warning: rule prose `exec/memory.fill` was never spliced
warning: rule prose `exec/memory.size` was never spliced
warning: rule prose `exec/vload_lane` was never spliced
warning: rule prose `exec/vload` was never spliced
warning: rule prose `exec/load` was never spliced
warning: rule prose `exec/table.init` was never spliced
warning: rule prose `exec/table.copy` was never spliced
warning: rule prose `exec/table.fill` was never spliced
warning: rule prose `exec/table.size` was never spliced
warning: rule prose `exec/table.get` was never spliced
warning: rule prose `exec/global.get` was never spliced
warning: rule prose `exec/local.get` was never spliced
warning: rule prose `exec/array.init_data` was never spliced
warning: rule prose `exec/array.init_elem` was never spliced
warning: rule prose `exec/array.copy` was never spliced
warning: rule prose `exec/array.fill` was never spliced
warning: rule prose `exec/array.len` was never spliced
warning: rule prose `exec/array.get` was never spliced
warning: rule prose `exec/array.new_data` was never spliced
warning: rule prose `exec/array.new_elem` was never spliced
warning: rule prose `exec/array.new_default` was never spliced
warning: rule prose `exec/struct.get` was never spliced
warning: rule prose `exec/struct.new_default` was never spliced
warning: rule prose `exec/ref.cast` was never spliced
warning: rule prose `exec/ref.test` was never spliced
warning: rule prose `exec/ref.func` was never spliced
warning: rule prose `exec/ref.null` was never spliced
warning: rule prose `exec/return_call_ref` was never spliced
warning: rule prose `exec/return_call` was never spliced
warning: rule prose `exec/call_ref` was never spliced
warning: rule prose `exec/call` was never spliced
warning: rule prose `exec/br_on_cast_fail` was never spliced
warning: rule prose `exec/br_on_cast` was never spliced
warning: rule prose `exec/loop` was never spliced
warning: rule prose `exec/block` was never spliced
warning: rule prose `exec/local.tee` was never spliced
warning: rule prose `exec/vextbinop` was never spliced
warning: rule prose `exec/vextunop` was never spliced
warning: rule prose `exec/vcvtop` was never spliced
warning: rule prose `exec/vnarrow` was never spliced
warning: rule prose `exec/vbitmask` was never spliced
warning: rule prose `exec/vtestop` was never spliced
warning: rule prose `exec/vshiftop` was never spliced
warning: rule prose `exec/vrelop` was never spliced
warning: rule prose `exec/vbinop` was never spliced
warning: rule prose `exec/vunop` was never spliced
warning: rule prose `exec/vreplace_lane` was never spliced
warning: rule prose `exec/vextract_lane` was never spliced
warning: rule prose `exec/vsplat` was never spliced
warning: rule prose `exec/vshuffle` was never spliced
warning: rule prose `exec/vswizzle` was never spliced
warning: rule prose `exec/vvtestop` was never spliced
warning: rule prose `exec/vvternop` was never spliced
warning: rule prose `exec/vvbinop` was never spliced
warning: rule prose `exec/vvunop` was never spliced
warning: rule prose `exec/any.convert_extern` was never spliced
warning: rule prose `exec/extern.convert_any` was never spliced
warning: rule prose `exec/array.new` was never spliced
warning: rule prose `exec/i31.get` was never spliced
warning: rule prose `exec/ref.eq` was never spliced
warning: rule prose `exec/ref.as_non_null` was never spliced
warning: rule prose `exec/ref.is_null` was never spliced
warning: rule prose `exec/ref.i31` was never spliced
warning: rule prose `exec/cvtop` was never spliced
warning: rule prose `exec/relop` was never spliced
warning: rule prose `exec/testop` was never spliced
warning: rule prose `exec/binop` was never spliced
warning: rule prose `exec/unop` was never spliced
warning: rule prose `exec/return` was never spliced
warning: rule prose `exec/frame` was never spliced
warning: rule prose `exec/return_call_indirect` was never spliced
warning: rule prose `exec/call_indirect` was never spliced
warning: rule prose `exec/br_on_non_null` was never spliced
warning: rule prose `exec/br_on_null` was never spliced
warning: rule prose `exec/br_table` was never spliced
warning: rule prose `exec/br_if` was never spliced
warning: rule prose `exec/br` was never spliced
warning: rule prose `exec/label` was never spliced
warning: rule prose `exec/if` was never spliced
warning: rule prose `exec/select` was never spliced
warning: rule prose `exec/drop` was never spliced
warning: rule prose `exec/nop` was never spliced
warning: rule prose `exec/unreachable` was never spliced
warning: rule prose `valid/vstore_lane` was never spliced
warning: rule prose `valid/vstore` was never spliced
warning: rule prose `valid/vload_lane` was never spliced
warning: rule prose `valid/vload` was never spliced
warning: rule prose `valid/store` was never spliced
warning: rule prose `valid/load` was never spliced
warning: rule prose `valid/data.drop` was never spliced
warning: rule prose `valid/memory.init` was never spliced
warning: rule prose `valid/memory.copy` was never spliced
warning: rule prose `valid/memory.fill` was never spliced
warning: rule prose `valid/memory.grow` was never spliced
warning: rule prose `valid/memory.size` was never spliced
warning: rule prose `valid/elem.drop` was never spliced
warning: rule prose `valid/table.init` was never spliced
warning: rule prose `valid/table.copy` was never spliced
warning: rule prose `valid/table.fill` was never spliced
warning: rule prose `valid/table.grow` was never spliced
warning: rule prose `valid/table.size` was never spliced
warning: rule prose `valid/table.set` was never spliced
warning: rule prose `valid/table.get` was never spliced
warning: rule prose `valid/global.set` was never spliced
warning: rule prose `valid/global.get` was never spliced
warning: rule prose `valid/local.tee` was never spliced
warning: rule prose `valid/local.set` was never spliced
warning: rule prose `valid/local.get` was never spliced
warning: rule prose `valid/vextbinop` was never spliced
warning: rule prose `valid/vextunop` was never spliced
warning: rule prose `valid/vnarrow` was never spliced
warning: rule prose `valid/vcvtop` was never spliced
warning: rule prose `valid/vshiftop` was never spliced
warning: rule prose `valid/vrelop` was never spliced
warning: rule prose `valid/vtestop` was never spliced
warning: rule prose `valid/vbinop` was never spliced
warning: rule prose `valid/vunop` was never spliced
warning: rule prose `valid/vreplace_lane` was never spliced
warning: rule prose `valid/vextract_lane` was never spliced
warning: rule prose `valid/vsplat` was never spliced
warning: rule prose `valid/vshuffle` was never spliced
warning: rule prose `valid/vswizzle` was never spliced
warning: rule prose `valid/vbitmask` was never spliced
warning: rule prose `valid/vvtestop` was never spliced
warning: rule prose `valid/vvternop` was never spliced
warning: rule prose `valid/vvbinop` was never spliced
warning: rule prose `valid/vvunop` was never spliced
warning: rule prose `valid/vconst` was never spliced
warning: rule prose `valid/any.convert_extern` was never spliced
warning: rule prose `valid/extern.convert_any` was never spliced
warning: rule prose `valid/array.init_data` was never spliced
warning: rule prose `valid/array.init_elem` was never spliced
warning: rule prose `valid/array.copy` was never spliced
warning: rule prose `valid/array.fill` was never spliced
warning: rule prose `valid/array.len` was never spliced
warning: rule prose `valid/array.set` was never spliced
warning: rule prose `valid/array.get` was never spliced
warning: rule prose `valid/array.new_data` was never spliced
warning: rule prose `valid/array.new_elem` was never spliced
warning: rule prose `valid/array.new_fixed` was never spliced
warning: rule prose `valid/array.new_default` was never spliced
warning: rule prose `valid/array.new` was never spliced
warning: rule prose `valid/struct.set` was never spliced
warning: rule prose `valid/struct.get` was never spliced
warning: rule prose `valid/struct.new_default` was never spliced
warning: rule prose `valid/struct.new` was never spliced
warning: rule prose `valid/i31.get` was never spliced
warning: rule prose `valid/ref.cast` was never spliced
warning: rule prose `valid/ref.test` was never spliced
warning: rule prose `valid/ref.eq` was never spliced
warning: rule prose `valid/ref.as_non_null` was never spliced
warning: rule prose `valid/ref.is_null` was never spliced
warning: rule prose `valid/ref.i31` was never spliced
warning: rule prose `valid/ref.func` was never spliced
warning: rule prose `valid/ref.null` was never spliced
warning: rule prose `valid/cvtop` was never spliced
warning: rule prose `valid/relop` was never spliced
warning: rule prose `valid/testop` was never spliced
warning: rule prose `valid/binop` was never spliced
warning: rule prose `valid/unop` was never spliced
warning: rule prose `valid/const` was never spliced
warning: rule prose `valid/return_call_indirect` was never spliced
warning: rule prose `valid/return_call_ref` was never spliced
warning: rule prose `valid/return_call` was never spliced
warning: rule prose `valid/return` was never spliced
warning: rule prose `valid/call_indirect` was never spliced
warning: rule prose `valid/call_ref` was never spliced
warning: rule prose `valid/call` was never spliced
warning: rule prose `valid/br_on_cast_fail` was never spliced
warning: rule prose `valid/br_on_cast` was never spliced
warning: rule prose `valid/br_on_non_null` was never spliced
warning: rule prose `valid/br_on_null` was never spliced
warning: rule prose `valid/br_table` was never spliced
warning: rule prose `valid/br_if` was never spliced
warning: rule prose `valid/br` was never spliced
warning: rule prose `valid/if` was never spliced
warning: rule prose `valid/loop` was never spliced
warning: rule prose `valid/block` was never spliced
warning: rule prose `valid/select` was never spliced
warning: rule prose `valid/drop` was never spliced
warning: rule prose `valid/unreachable` was never spliced
warning: rule prose `valid/nop` was never spliced
warning: definition prose `E` was never spliced
warning: definition prose `Ki` was never spliced
warning: definition prose `M` was never spliced
warning: definition prose `allocdata` was never spliced
warning: definition prose `allocdatas` was never spliced
warning: definition prose `allocelem` was never spliced
warning: definition prose `allocelems` was never spliced
warning: definition prose `allocfunc` was never spliced
warning: definition prose `allocfuncs` was never spliced
warning: definition prose `allocglobal` was never spliced
warning: definition prose `allocglobals` was never spliced
warning: definition prose `allocmem` was never spliced
warning: definition prose `allocmems` was never spliced
warning: definition prose `allocmodule` was never spliced
warning: definition prose `alloctable` was never spliced
warning: definition prose `alloctables` was never spliced
warning: definition prose `alloctypes` was never spliced
warning: definition prose `arrayinst` was never spliced
warning: definition prose `before` was never spliced
warning: definition prose `binop` was never spliced
warning: definition prose `blocktype` was never spliced
warning: definition prose `canon_` was never spliced
warning: definition prose `clostype` was never spliced
warning: definition prose `clostypes` was never spliced
warning: definition prose `concat_` was never spliced
warning: definition prose `const` was never spliced
warning: definition prose `cunpack` was never spliced
warning: definition prose `cvtop` was never spliced
warning: definition prose `data` was never spliced
warning: definition prose `datainst` was never spliced
warning: definition prose `default_` was never spliced
warning: definition prose `diffrt` was never spliced
warning: definition prose `dim` was never spliced
warning: definition prose `elem` was never spliced
warning: definition prose `eleminst` was never spliced
warning: definition prose `eval_expr` was never spliced
warning: definition prose `expanddt` was never spliced
warning: definition prose `expon` was never spliced
warning: definition prose `ext_arrayinst` was never spliced
warning: definition prose `ext_structinst` was never spliced
warning: definition prose `fone` was never spliced
warning: definition prose `frame` was never spliced
warning: definition prose `free_dataidx_expr` was never spliced
warning: definition prose `free_dataidx_func` was never spliced
warning: definition prose `free_dataidx_funcs` was never spliced
warning: definition prose `free_dataidx_instr` was never spliced
warning: definition prose `free_dataidx_instrs` was never spliced
warning: definition prose `func` was never spliced
warning: definition prose `funcaddr` was never spliced
warning: definition prose `funcinst` was never spliced
warning: definition prose `funcsxt` was never spliced
warning: definition prose `funcsxv` was never spliced
warning: definition prose `fzero` was never spliced
warning: definition prose `global` was never spliced
warning: definition prose `globalinst` was never spliced
warning: definition prose `globalsxt` was never spliced
warning: definition prose `globalsxv` was never spliced
warning: definition prose `group_bytes_by` was never spliced
warning: definition prose `growmemory` was never spliced
warning: definition prose `growtable` was never spliced
warning: definition prose `halfop` was never spliced
warning: definition prose `idx` was never spliced
warning: definition prose `in_binop` was never spliced
warning: definition prose `in_numtype` was never spliced
warning: definition prose `inst_reftype` was never spliced
warning: definition prose `instantiate` was never spliced
warning: definition prose `instexport` was never spliced
warning: definition prose `invfbytes` was never spliced
warning: definition prose `invibytes` was never spliced
warning: definition prose `invlanes_` was never spliced
warning: definition prose `invoke` was never spliced
warning: definition prose `invsigned` was never spliced
warning: definition prose `isize` was never spliced
warning: definition prose `lanetype` was never spliced
warning: definition prose `local` was never spliced
warning: definition prose `lsize` was never spliced
warning: definition prose `lunpack` was never spliced
warning: definition prose `mem` was never spliced
warning: definition prose `meminst` was never spliced
warning: definition prose `memop0` was never spliced
warning: definition prose `memsxt` was never spliced
warning: definition prose `memsxv` was never spliced
warning: definition prose `min` was never spliced
warning: definition prose `moduleinst` was never spliced
warning: definition prose `nunpack` was never spliced
warning: definition prose `packconst` was never spliced
warning: definition prose `packfield` was never spliced
warning: definition prose `packnum` was never spliced
warning: definition prose `psize` was never spliced
warning: definition prose `relop` was never spliced
warning: definition prose `rolldt` was never spliced
warning: definition prose `rollrt` was never spliced
warning: definition prose `rundata` was never spliced
warning: definition prose `runelem` was never spliced
warning: definition prose `setminus` was never spliced
warning: definition prose `setminus1` was never spliced
warning: definition prose `shsize` was never spliced
warning: definition prose `signed` was never spliced
warning: definition prose `signif` was never spliced
warning: definition prose `size` was never spliced
warning: definition prose `sizenn` was never spliced
warning: definition prose `store` was never spliced
warning: definition prose `structinst` was never spliced
warning: definition prose `subst_all_deftype` was never spliced
warning: definition prose `subst_all_deftypes` was never spliced
warning: definition prose `subst_all_reftype` was never spliced
warning: definition prose `subst_comptype` was never spliced
warning: definition prose `subst_deftype` was never spliced
warning: definition prose `subst_externtype` was never spliced
warning: definition prose `subst_fieldtype` was never spliced
warning: definition prose `subst_functype` was never spliced
warning: definition prose `subst_globaltype` was never spliced
warning: definition prose `subst_heaptype` was never spliced
warning: definition prose `subst_memtype` was never spliced
warning: definition prose `subst_numtype` was never spliced
warning: definition prose `subst_packtype` was never spliced
warning: definition prose `subst_rectype` was never spliced
warning: definition prose `subst_reftype` was never spliced
warning: definition prose `subst_storagetype` was never spliced
warning: definition prose `subst_subtype` was never spliced
warning: definition prose `subst_tabletype` was never spliced
warning: definition prose `subst_typevar` was never spliced
warning: definition prose `subst_valtype` was never spliced
warning: definition prose `subst_vectype` was never spliced
warning: definition prose `sum` was never spliced
warning: definition prose `sx` was never spliced
warning: definition prose `table` was never spliced
warning: definition prose `tableinst` was never spliced
warning: definition prose `tablesxt` was never spliced
warning: definition prose `tablesxv` was never spliced
warning: definition prose `testop` was never spliced
warning: definition prose `type` was never spliced
warning: definition prose `unop` was never spliced
warning: definition prose `unpack` was never spliced
warning: definition prose `unpackfield` was never spliced
warning: definition prose `unpacknum` was never spliced
warning: definition prose `unrolldt` was never spliced
warning: definition prose `unrollht` was never spliced
warning: definition prose `unrollrt` was never spliced
warning: definition prose `utf8` was never spliced
warning: definition prose `vbinop` was never spliced
warning: definition prose `vcvtop` was never spliced
warning: definition prose `vextbinop` was never spliced
warning: definition prose `vextunop` was never spliced
warning: definition prose `vishiftop` was never spliced
warning: definition prose `vrelop` was never spliced
warning: definition prose `vsize` was never spliced
warning: definition prose `vunop` was never spliced
warning: definition prose `vunpack` was never spliced
warning: definition prose `vvbinop` was never spliced
warning: definition prose `vvternop` was never spliced
warning: definition prose `vvunop` was never spliced
warning: definition prose `with_array` was never spliced
warning: definition prose `with_data` was never spliced
warning: definition prose `with_elem` was never spliced
warning: definition prose `with_global` was never spliced
warning: definition prose `with_local` was never spliced
warning: definition prose `with_locals` was never spliced
warning: definition prose `with_mem` was never spliced
warning: definition prose `with_meminst` was never spliced
warning: definition prose `with_struct` was never spliced
warning: definition prose `with_table` was never spliced
warning: definition prose `with_tableinst` was never spliced
warning: definition prose `zero` was never spliced
warning: definition prose `zsize` was never spliced
== Complete.
```

# Preview

```sh
$ (dune exec ../src/exe-watsup/main.exe -- ../spec/*.watsup -l --splice-latex -p spec-splice-in.tex -w)
== Parsing...
== Elaboration...
== IL Validation...
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
\begin{array}{@{}lrrl@{}}
\mbox{(number type)} & \mathit{numtype} &::=& \mathsf{i{\scriptstyle32}} ~|~ \mathsf{i{\scriptstyle64}} ~|~ \mathsf{f{\scriptstyle32}} ~|~ \mathsf{f{\scriptstyle64}} \\
\mbox{(vector type)} & \mathit{vectype} &::=& \mathsf{v{\scriptstyle128}} \\
\mbox{(reference type)} & \mathit{reftype} &::=& \mathsf{funcref} ~|~ \mathsf{externref} \\
\mbox{(value type)} & \mathit{valtype} &::=& \mathit{numtype} ~|~ \mathit{vectype} ~|~ \mathit{reftype} ~|~ \mathsf{bot} \\[0.8ex]
\mbox{(result type)} & \mathit{resulttype} &::=& {\mathit{valtype}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{|\mathsf{i{\scriptstyle32}}|} &=& 32 &  \\[0.8ex]
{|\mathsf{i{\scriptstyle64}}|} &=& 64 &  \\[0.8ex]
{|\mathsf{f{\scriptstyle32}}|} &=& 32 &  \\[0.8ex]
{|\mathsf{f{\scriptstyle64}}|} &=& 64 &  \\[0.8ex]
{|\mathsf{v{\scriptstyle128}}|} &=& 128 &  \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}}
\mbox{(limits)} & \mathit{limits} &::=& [\mathit{u{\scriptstyle32}} .. \mathit{u{\scriptstyle32}}] \\[0.8ex]
\mbox{(global type)} & \mathit{globaltype} &::=& {\mathsf{mut}^?}~\mathit{valtype} \\
\mbox{(function type)} & \mathit{functype} &::=& \mathit{resulttype} \rightarrow \mathit{resulttype} \\
\mbox{(table type)} & \mathit{tabletype} &::=& \mathit{limits}~\mathit{reftype} \\
\mbox{(memory type)} & \mathit{memtype} &::=& \mathit{limits}~\mathsf{i{\scriptstyle8}} \\[0.8ex]
{} \\[-2ex]
\mbox{(external type)} & \mathit{externtype} &::=& \mathsf{global}~\mathit{globaltype} ~|~ \mathsf{func}~\mathit{functype} ~|~ \mathsf{table}~\mathit{tabletype} ~|~ \mathsf{mem}~\mathit{memtype} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrl@{}}
& \mathit{instr} &::=& \mathsf{unreachable} \\ &&|&
\mathsf{nop} \\ &&|&
\mathsf{drop} \\ &&|&
\mathsf{select}~{\mathit{valtype}^?} \\ &&|&
\mathsf{block}~\mathit{blocktype}~{\mathit{instr}^\ast} \\ &&|&
\mathsf{loop}~\mathit{blocktype}~{\mathit{instr}^\ast} \\ &&|&
\mathsf{if}~\mathit{blocktype}~{\mathit{instr}^\ast}~\mathsf{else}~{\mathit{instr}^\ast} \\ &&|&
\mathsf{br}~\mathit{labelidx} \\ &&|&
\mathsf{br\_if}~\mathit{labelidx} \\ &&|&
\mathsf{br\_table}~{\mathit{labelidx}^\ast}~\mathit{labelidx} \\ &&|&
\mathsf{call}~\mathit{funcidx} \\ &&|&
\mathsf{call\_indirect}~\mathit{tableidx}~\mathit{functype} \\ &&|&
\mathsf{return} \\ &&|&
\mathsf{ref.null}~\mathit{reftype} \\ &&|&
\mathsf{ref.func}~\mathit{funcidx} \\ &&|&
\mathsf{ref.is\_null} \\ &&|&
... \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrl@{}}
& \mathit{instr} &::=& ... \\ &&|&
\mathit{numtype}.\mathsf{const}~\mathit{c}_{\mathit{numtype}} \\ &&|&
\mathit{numtype} . \mathit{unop}_{\mathit{numtype}} \\ &&|&
\mathit{numtype} . \mathit{binop}_{\mathit{numtype}} \\ &&|&
\mathit{numtype} . \mathit{testop}_{\mathit{numtype}} \\ &&|&
\mathit{numtype} . \mathit{relop}_{\mathit{numtype}} \\ &&|&
{\mathit{numtype}.\mathsf{extend}}{\mathit{n}} \\ &&|&
\mathit{numtype} . {{{{\mathit{cvtop}}{\mathsf{\_}}}{\mathit{numtype}}}{\mathsf{\_}}}{{\mathit{sx}^?}} \\ &&|&
\mathsf{local.get}~\mathit{localidx} \\ &&|&
\mathsf{local.set}~\mathit{localidx} \\ &&|&
\mathsf{local.tee}~\mathit{localidx} \\ &&|&
\mathsf{global.get}~\mathit{globalidx} \\ &&|&
\mathsf{global.set}~\mathit{globalidx} \\ &&|&
\mathsf{table.get}~\mathit{tableidx} \\ &&|&
\mathsf{table.set}~\mathit{tableidx} \\ &&|&
\mathsf{table.size}~\mathit{tableidx} \\ &&|&
\mathsf{table.grow}~\mathit{tableidx} \\ &&|&
\mathsf{table.fill}~\mathit{tableidx} \\ &&|&
\mathsf{table.copy}~\mathit{tableidx}~\mathit{tableidx} \\ &&|&
\mathsf{table.init}~\mathit{tableidx}~\mathit{elemidx} \\ &&|&
\mathsf{elem.drop}~\mathit{elemidx} \\ &&|&
\mathsf{memory.size} \\ &&|&
\mathsf{memory.grow} \\ &&|&
\mathsf{memory.fill} \\ &&|&
\mathsf{memory.copy} \\ &&|&
\mathsf{memory.init}~\mathit{dataidx} \\ &&|&
\mathsf{data.drop}~\mathit{dataidx} \\ &&|&
{\mathit{numtype}.\mathsf{load}}{{({{\mathit{n}}{\mathsf{\_}}}{\mathit{sx}})^?}}~\mathit{u{\scriptstyle32}}~\mathit{u{\scriptstyle32}} \\ &&|&
{\mathit{numtype}.\mathsf{store}}{{\mathit{n}^?}}~\mathit{u{\scriptstyle32}}~\mathit{u{\scriptstyle32}} \\[0.8ex]
& \mathit{expr} &::=& {\mathit{instr}^\ast} \\
\end{array}
$$


\subsection*{Typing $\boxed{\mathit{context} \vdash \mathit{instr} : \mathit{functype}}$}

An instruction sequence ${\mathit{instr}^\ast}$ is well-typed with an instruction type ${\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}$, written ${\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}$, according to the following rules:

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \epsilon : \epsilon \rightarrow \epsilon
}
\qquad
\frac{
\mathit{C} \vdash \mathit{instr}_{1} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
 \qquad
\mathit{C} \vdash \mathit{instr}_{2} : {\mathit{t}_{2}^\ast} \rightarrow {\mathit{t}_{3}^\ast}
}{
\mathit{C} \vdash \mathit{instr}_{1}~{\mathit{instr}_{2}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{3}^\ast}
}
\\[3ex]\displaystyle
\frac{
\begin{array}{@{}c@{}}
\mathit{C} \vdash {\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
 \\
{ \vdash }\;{{\mathit{t}'}_{1}^\ast} \leq {\mathit{t}_{1}^\ast}
 \qquad
{ \vdash }\;{\mathit{t}_{2}^\ast} \leq {{\mathit{t}'}_{2}^\ast}
\end{array}
}{
\mathit{C} \vdash {\mathit{instr}^\ast} : {{\mathit{t}'}_{1}^\ast} \rightarrow {{\mathit{t}'}_{2}^\ast}
}
\qquad
\frac{
\mathit{C} \vdash {\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
}{
\mathit{C} \vdash {\mathit{instr}^\ast} : {\mathit{t}^\ast}~{\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}^\ast}~{\mathit{t}_{2}^\ast}
}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \epsilon : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T*{-}empty}]}
\\[3ex]\displaystyle
\frac{
\mathit{C} \vdash {\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
}{
\mathit{C} \vdash {\mathit{instr}^\ast} : {\mathit{t}^\ast}~{\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}^\ast}~{\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T*{-}frame}]}
\\[3ex]\displaystyle
\frac{
}{
\mathit{C} \vdash \epsilon : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T*{-}empty}]}
\qquad
\frac{
\mathit{C} \vdash {\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
}{
\mathit{C} \vdash {\mathit{instr}^\ast} : {\mathit{t}^\ast}~{\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}^\ast}~{\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T*{-}frame}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathsf{unreachable} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
}
\qquad
\frac{
}{
\mathit{C} \vdash \mathsf{nop} : \epsilon \rightarrow \epsilon
}
\qquad
\frac{
}{
\mathit{C} \vdash \mathsf{drop} : \mathit{t} \rightarrow \epsilon
}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C} \vdash \mathit{bt} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
 \qquad
\mathit{C}, \mathsf{label}~{\mathit{t}_{2}^\ast} \vdash {\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
}{
\mathit{C} \vdash \mathsf{block}~\mathit{bt}~{\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T{-}block}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C} \vdash \mathit{bt} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
 \qquad
\mathit{C}, \mathsf{label}~{\mathit{t}_{1}^\ast} \vdash {\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
}{
\mathit{C} \vdash \mathsf{loop}~\mathit{bt}~{\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T{-}loop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C} \vdash \mathit{bt} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
 \qquad
\mathit{C}, \mathsf{label}~{\mathit{t}_{2}^\ast} \vdash {\mathit{instr}_{1}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
 \qquad
\mathit{C}, \mathsf{label}~{\mathit{t}_{2}^\ast} \vdash {\mathit{instr}_{2}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
}{
\mathit{C} \vdash \mathsf{if}~\mathit{bt}~{\mathit{instr}_{1}^\ast}~\mathsf{else}~{\mathit{instr}_{2}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T{-}if}]}
\qquad
\end{array}
$$


\subsection*{Runtime}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{default}}_{\mathsf{i{\scriptstyle32}}} &=& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) &  \\[0.8ex]
{\mathrm{default}}_{\mathsf{i{\scriptstyle64}}} &=& (\mathsf{i{\scriptstyle64}}.\mathsf{const}~0) &  \\[0.8ex]
{\mathrm{default}}_{\mathsf{f{\scriptstyle32}}} &=& (\mathsf{f{\scriptstyle32}}.\mathsf{const}~0) &  \\[0.8ex]
{\mathrm{default}}_{\mathsf{f{\scriptstyle64}}} &=& (\mathsf{f{\scriptstyle64}}.\mathsf{const}~0) &  \\[0.8ex]
{\mathrm{default}}_{\mathsf{funcref}} &=& (\mathsf{ref.null}~\mathsf{funcref}) &  \\[0.8ex]
{\mathrm{default}}_{\mathsf{externref}} &=& (\mathsf{ref.null}~\mathsf{externref}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathit{s} ; \mathit{f}).\mathsf{module}.\mathsf{func} &=& \mathit{f}.\mathsf{module}.\mathsf{func} &  \\
(\mathit{s} ; \mathit{f}).\mathsf{func} &=& \mathit{s}.\mathsf{func} &  \\[0.8ex]
{(\mathit{s} ; \mathit{f}).\mathsf{func}}{[\mathit{x}]} &=& \mathit{s}.\mathsf{func}[\mathit{f}.\mathsf{module}.\mathsf{func}[\mathit{x}]] &  \\
{(\mathit{s} ; \mathit{f}).\mathsf{table}}{[\mathit{x}]} &=& \mathit{s}.\mathsf{table}[\mathit{f}.\mathsf{module}.\mathsf{table}[\mathit{x}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{test}_{\mathit{sub}_{\mathsf{atom}_{22}}}(\mathit{n}_{3_{\mathsf{atom}_{\mathit{y}}}}) &=& 0 &  \\
\end{array}
$$
$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{curried}}_{\mathit{n}_{1}}(\mathit{n}_{2}) &=& \mathit{n}_{1} + \mathit{n}_{2} &  \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrl@{}}
& \mathit{testfuse} &::=& {\mathsf{ab}}_{\mathit{nat}}\,\,\mathit{nat}~\mathit{nat} \\ &&|&
{\mathsf{cd}}_{\mathit{nat}}\,\mathit{nat}~\mathit{nat} \\ &&|&
{\mathsf{ef\_}}{\mathit{nat}}~\mathit{nat}~\mathit{nat} \\ &&|&
{{\mathsf{gh}}_{\mathit{nat}}}{\mathit{nat}}~\mathit{nat} \\ &&|&
{{\mathsf{ij}}_{\mathit{nat}}}{\mathit{nat}}~\mathit{nat} \\ &&|&
{\mathsf{kl\_ab}}{\mathit{nat}}~\mathit{nat}~\mathit{nat} \\ &&|&
{\mathsf{mn\_}}{\mathsf{ab}}~\mathit{nat}~\mathit{nat}~\mathit{nat} \\ &&|&
{{\mathsf{op\_}}{\mathsf{ab}}}{\mathit{nat}}~\mathit{nat}~\mathit{nat} \\ &&|&
{{\mathsf{qr}}_{\mathit{nat}}}{\mathsf{ab}}~\mathit{nat}~\mathit{nat} \\
\end{array}
$$


\subsection*{Reduction $\boxed{{\mathit{instr}^\ast} \hookrightarrow {\mathit{instr}^\ast}}$}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
& \mathit{z} ; {\mathit{instr}^\ast} &\hookrightarrow& \mathit{z} ; {{\mathit{instr}'}^\ast} &\quad
  \mbox{if}~{\mathit{instr}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\[0.8ex]
& \mathit{z} ; {\mathit{instr}^\ast} &\hookrightarrow& \mathit{z} ; {{\mathit{instr}'}^\ast} &\quad
  \mbox{if}~\mathit{z} ; {\mathit{instr}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}block}]} \quad & {\mathit{val}^{\mathit{k}}}~(\mathsf{block}~\mathit{bt}~{\mathit{instr}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{\mathit{n}}}{\{\epsilon\}}~{\mathit{val}^{\mathit{k}}}~{\mathit{instr}^\ast}) &\quad
  \mbox{if}~\mathit{bt} = {\mathit{t}_{1}^{\mathit{k}}} \rightarrow {\mathit{t}_{2}^{\mathit{n}}} \\
{[\textsc{\scriptsize E{-}loop}]} \quad & {\mathit{val}^{\mathit{k}}}~(\mathsf{loop}~\mathit{bt}~{\mathit{instr}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{\mathit{k}}}{\{\mathsf{loop}~\mathit{bt}~{\mathit{instr}^\ast}\}}~{\mathit{val}^{\mathit{k}}}~{\mathit{instr}^\ast}) &\quad
  \mbox{if}~\mathit{bt} = {\mathit{t}_{1}^{\mathit{k}}} \rightarrow {\mathit{t}_{2}^{\mathit{n}}} \\[0.8ex]
{[\textsc{\scriptsize E{-}if{-}true}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{if}~\mathit{bt}~{\mathit{instr}_{1}^\ast}~\mathsf{else}~{\mathit{instr}_{2}^\ast}) &\hookrightarrow& (\mathsf{block}~\mathit{bt}~{\mathit{instr}_{1}^\ast}) &\quad
  \mbox{if}~\mathit{c} \neq 0 \\
{[\textsc{\scriptsize E{-}if{-}false}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{if}~\mathit{bt}~{\mathit{instr}_{1}^\ast}~\mathsf{else}~{\mathit{instr}_{2}^\ast}) &\hookrightarrow& (\mathsf{block}~\mathit{bt}~{\mathit{instr}_{2}^\ast}) &\quad
  \mbox{if}~\mathit{c} = 0 \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}if{-}true}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{if}~\mathit{bt}~{\mathit{instr}_{1}^\ast}~\mathsf{else}~{\mathit{instr}_{2}^\ast}) &\hookrightarrow& (\mathsf{block}~\mathit{bt}~{\mathit{instr}_{1}^\ast}) &\quad
  \mbox{if}~\mathit{c} \neq 0 \\[0.8ex]
{[\textsc{\scriptsize E{-}if{-}false}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{if}~\mathit{bt}~{\mathit{instr}_{1}^\ast}~\mathsf{else}~{\mathit{instr}_{2}^\ast}) &\hookrightarrow& (\mathsf{block}~\mathit{bt}~{\mathit{instr}_{2}^\ast}) &\quad
  \mbox{if}~\mathit{c} = 0 \\
\end{array}
$$

\end{document}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

warning: syntax `E` was never spliced
warning: syntax `addr` was never spliced
warning: syntax `admininstr` was never spliced
warning: syntax `binop_FXX` was never spliced
warning: syntax `binop_IXX` was never spliced
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
warning: syntax `fn` was never spliced
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
warning: syntax `in` was never spliced
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
warning: syntax `relop_FXX` was never spliced
warning: syntax `relop_IXX` was never spliced
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
warning: syntax `testop_FXX` was never spliced
warning: syntax `testop_IXX` was never spliced
warning: syntax `testop_numtype` was never spliced
warning: syntax `u32` was never spliced
warning: syntax `unop_FXX` was never spliced
warning: syntax `unop_IXX` was never spliced
warning: syntax `unop_numtype` was never spliced
warning: syntax `val` was never spliced
warning: rule `Blocktype_ok` was never spliced
warning: rule `Data_ok` was never spliced
warning: rule `Datamode_ok` was never spliced
warning: rule `Elem_ok` was never spliced
warning: rule `Elemmode_ok/active` was never spliced
warning: rule `Elemmode_ok/declare` was never spliced
warning: rule `Export_ok` was never spliced
warning: rule `Expr_const` was never spliced
warning: rule `Expr_ok` was never spliced
warning: rule `Expr_ok_const` was never spliced
warning: rule `Externtype_ok/func` was never spliced
warning: rule `Externtype_ok/global` was never spliced
warning: rule `Externtype_ok/table` was never spliced
warning: rule `Externtype_ok/mem` was never spliced
warning: rule `Externtype_sub/func` was never spliced
warning: rule `Externtype_sub/global` was never spliced
warning: rule `Externtype_sub/table` was never spliced
warning: rule `Externtype_sub/mem` was never spliced
warning: rule `Externuse_ok/func` was never spliced
warning: rule `Externuse_ok/global` was never spliced
warning: rule `Externuse_ok/table` was never spliced
warning: rule `Externuse_ok/mem` was never spliced
warning: rule `Func_ok` was never spliced
warning: rule `Functype_ok` was never spliced
warning: rule `Functype_sub` was never spliced
warning: rule `Global_ok` was never spliced
warning: rule `Globaltype_ok` was never spliced
warning: rule `Globaltype_sub` was never spliced
warning: rule `Import_ok` was never spliced
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
warning: rule `Instr_ok/extend` was never spliced
warning: rule `Instr_ok/reinterpret` was never spliced
warning: rule `Instr_ok/convert-i` was never spliced
warning: rule `Instr_ok/convert-f` was never spliced
warning: rule `Instr_ok/ref.null` was never spliced
warning: rule `Instr_ok/ref.func` was never spliced
warning: rule `Instr_ok/ref.is_null` was never spliced
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
warning: rule `Limits_ok` was never spliced
warning: rule `Limits_sub` was never spliced
warning: rule `Mem_ok` was never spliced
warning: rule `Memtype_ok` was never spliced
warning: rule `Memtype_sub` was never spliced
warning: rule `Module_ok` was never spliced
warning: rule `Resulttype_sub` was never spliced
warning: rule `Start_ok` was never spliced
warning: rule `Step/local.set` was never spliced
warning: rule `Step/global.set` was never spliced
warning: rule `Step/table.set-trap` was never spliced
warning: rule `Step/table.set-val` was never spliced
warning: rule `Step/table.grow-succeed` was never spliced
warning: rule `Step/table.grow-fail` was never spliced
warning: rule `Step/elem.drop` was never spliced
warning: rule `Step/store-num-trap` was never spliced
warning: rule `Step/store-num-val` was never spliced
warning: rule `Step/store-pack-trap` was never spliced
warning: rule `Step/store-pack-val` was never spliced
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
warning: rule `Step_pure/frame-vals` was never spliced
warning: rule `Step_pure/return-frame` was never spliced
warning: rule `Step_pure/return-label` was never spliced
warning: rule `Step_pure/unop-val` was never spliced
warning: rule `Step_pure/unop-trap` was never spliced
warning: rule `Step_pure/binop-val` was never spliced
warning: rule `Step_pure/binop-trap` was never spliced
warning: rule `Step_pure/testop` was never spliced
warning: rule `Step_pure/relop` was never spliced
warning: rule `Step_pure/extend` was never spliced
warning: rule `Step_pure/cvtop-val` was never spliced
warning: rule `Step_pure/cvtop-trap` was never spliced
warning: rule `Step_pure/ref.is_null-true` was never spliced
warning: rule `Step_pure/ref.is_null-false` was never spliced
warning: rule `Step_pure/local.tee` was never spliced
warning: rule `Step_read/call` was never spliced
warning: rule `Step_read/call_indirect-call` was never spliced
warning: rule `Step_read/call_indirect-trap` was never spliced
warning: rule `Step_read/call_addr` was never spliced
warning: rule `Step_read/ref.func` was never spliced
warning: rule `Step_read/local.get` was never spliced
warning: rule `Step_read/global.get` was never spliced
warning: rule `Step_read/table.get-trap` was never spliced
warning: rule `Step_read/table.get-val` was never spliced
warning: rule `Step_read/table.size` was never spliced
warning: rule `Step_read/table.fill-trap` was never spliced
warning: rule `Step_read/table.fill-zero` was never spliced
warning: rule `Step_read/table.fill-succ` was never spliced
warning: rule `Step_read/table.copy-trap` was never spliced
warning: rule `Step_read/table.copy-zero` was never spliced
warning: rule `Step_read/table.copy-le` was never spliced
warning: rule `Step_read/table.copy-gt` was never spliced
warning: rule `Step_read/table.init-trap` was never spliced
warning: rule `Step_read/table.init-zero` was never spliced
warning: rule `Step_read/table.init-succ` was never spliced
warning: rule `Step_read/load-num-trap` was never spliced
warning: rule `Step_read/load-num-val` was never spliced
warning: rule `Step_read/load-pack-trap` was never spliced
warning: rule `Step_read/load-pack-val` was never spliced
warning: rule `Step_read/memory.size` was never spliced
warning: rule `Step_read/memory.fill-trap` was never spliced
warning: rule `Step_read/memory.fill-zero` was never spliced
warning: rule `Step_read/memory.fill-succ` was never spliced
warning: rule `Step_read/memory.copy-trap` was never spliced
warning: rule `Step_read/memory.copy-zero` was never spliced
warning: rule `Step_read/memory.copy-le` was never spliced
warning: rule `Step_read/memory.copy-gt` was never spliced
warning: rule `Step_read/memory.init-trap` was never spliced
warning: rule `Step_read/memory.init-zero` was never spliced
warning: rule `Step_read/memory.init-succ` was never spliced
warning: rule `Table_ok` was never spliced
warning: rule `Tabletype_ok` was never spliced
warning: rule `Tabletype_sub` was never spliced
warning: rule `Valtype_sub/refl` was never spliced
warning: rule `Valtype_sub/bot` was never spliced
warning: definition `Ki` was never spliced
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
warning: definition `binop` was never spliced
warning: definition `bytes_` was never spliced
warning: definition `concat_instr` was never spliced
warning: definition `cvtop` was never spliced
warning: definition `data` was never spliced
warning: definition `datainst` was never spliced
warning: definition `elem` was never spliced
warning: definition `eleminst` was never spliced
warning: definition `ext` was never spliced
warning: definition `funcs` was never spliced
warning: definition `global` was never spliced
warning: definition `globalinst` was never spliced
warning: definition `globals` was never spliced
warning: definition `grow_memory` was never spliced
warning: definition `grow_table` was never spliced
warning: definition `instantiation` was never spliced
warning: definition `instexport` was never spliced
warning: definition `inverse_of_bytes_` was never spliced
warning: definition `invocation` was never spliced
warning: definition `local` was never spliced
warning: definition `mem` was never spliced
warning: definition `meminst` was never spliced
warning: definition `mems` was never spliced
warning: definition `min` was never spliced
warning: definition `relop` was never spliced
warning: definition `rundata` was never spliced
warning: definition `runelem` was never spliced
warning: definition `tableinst` was never spliced
warning: definition `tables` was never spliced
warning: definition `testop` was never spliced
warning: definition `unop` was never spliced
warning: definition `with_data` was never spliced
warning: definition `with_elem` was never spliced
warning: definition `with_global` was never spliced
warning: definition `with_local` was never spliced
warning: definition `with_mem` was never spliced
warning: definition `with_meminst` was never spliced
warning: definition `with_table` was never spliced
warning: definition `with_tableinst` was never spliced
warning: definition `wrap_` was never spliced
== Complete.
```

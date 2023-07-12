# Preview

```sh
$ (dune exec ../src/exe-watsup/main.exe -- ../spec/*.watsup)
$$
\begin{array}{@{}lrrl@{}}
& \mathit{n} &::=& \mathit{nat} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}}
\mbox{(name)} & \mathit{name} &::=& \mathit{text} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(byte)} & \mathit{byte} &::=& \mathit{nat} \\
\mbox{(32-bit integer)} & \mathit{u{\scriptstyle32}} &::=& \mathit{nat} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(index)} & \mathit{idx} &::=& \mathit{nat} \\
\mbox{(function index)} & \mathit{funcidx} &::=& \mathit{idx} \\
\mbox{(global index)} & \mathit{globalidx} &::=& \mathit{idx} \\
\mbox{(table index)} & \mathit{tableidx} &::=& \mathit{idx} \\
\mbox{(memory index)} & \mathit{memidx} &::=& \mathit{idx} \\
\mbox{(elem index)} & \mathit{elemidx} &::=& \mathit{idx} \\
\mbox{(data index)} & \mathit{dataidx} &::=& \mathit{idx} \\
\mbox{(label index)} & \mathit{labelidx} &::=& \mathit{idx} \\
\mbox{(local index)} & \mathit{localidx} &::=& \mathit{idx} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(number type)} & \mathit{numtype} &::=& \mathsf{i{\scriptstyle32}} ~|~ \mathsf{i{\scriptstyle64}} ~|~ \mathsf{f{\scriptstyle32}} ~|~ \mathsf{f{\scriptstyle64}} \\
\mbox{(vector type)} & \mathit{vectype} &::=& \mathsf{v{\scriptstyle128}} \\
\mbox{(reference type)} & \mathit{reftype} &::=& \mathsf{funcref} ~|~ \mathsf{externref} \\
\mbox{(value type)} & \mathit{valtype} &::=& \mathit{numtype} ~|~ \mathit{vectype} ~|~ \mathit{reftype} ~|~ \mathsf{bot} \\
& {\mathsf{i}}{\mathit{n}} &::=& \mathsf{i{\scriptstyle32}} ~|~ \mathsf{i{\scriptstyle64}} \\
& {\mathsf{f}}{\mathit{n}} &::=& \mathsf{f{\scriptstyle32}} ~|~ \mathsf{f{\scriptstyle64}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}}
\mbox{(result type)} & \mathit{resulttype} &::=& {\mathit{valtype}^\ast} \\
\mbox{(limits)} & \mathit{limits} &::=& [\mathit{u{\scriptstyle32}} .. \mathit{u{\scriptstyle32}}] \\
\mbox{(global type)} & \mathit{globaltype} &::=& {\mathsf{mut}^?}~\mathit{valtype} \\
\mbox{(function type)} & \mathit{functype} &::=& \mathit{resulttype} \rightarrow \mathit{resulttype} \\
\mbox{(table type)} & \mathit{tabletype} &::=& \mathit{limits}~\mathit{reftype} \\
\mbox{(memory type)} & \mathit{memtype} &::=& \mathit{limits}~\mathsf{i{\scriptstyle8}} \\
\mbox{(element type)} & \mathit{elemtype} &::=& \mathit{reftype} \\
\mbox{(data type)} & \mathit{datatype} &::=& \mathsf{ok} \\
\mbox{(external type)} & \mathit{externtype} &::=& \mathsf{global}~\mathit{globaltype} ~|~ \mathsf{func}~\mathit{functype} ~|~ \mathsf{table}~\mathit{tabletype} ~|~ \mathsf{mem}~\mathit{memtype} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(signedness)} & \mathit{sx} &::=& \mathsf{u} ~|~ \mathsf{s} \\
& \mathit{unop}_{\mathsf{ixx}} &::=& \mathsf{clz} ~|~ \mathsf{ctz} ~|~ \mathsf{popcnt} \\
& \mathit{unop}_{\mathsf{fxx}} &::=& \mathsf{abs} ~|~ \mathsf{neg} ~|~ \mathsf{sqrt} ~|~ \mathsf{ceil} ~|~ \mathsf{floor} ~|~ \mathsf{trunc} ~|~ \mathsf{nearest} \\
& \mathit{binop}_{\mathsf{ixx}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{mul} ~|~ {\mathsf{div\_}}{\mathit{sx}} ~|~ {\mathsf{rem\_}}{\mathit{sx}} \\ &&|&
\mathsf{and} ~|~ \mathsf{or} ~|~ \mathsf{xor} ~|~ \mathsf{shl} ~|~ {\mathsf{shr\_}}{\mathit{sx}} ~|~ \mathsf{rotl} ~|~ \mathsf{rotr} \\
& \mathit{binop}_{\mathsf{fxx}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{mul} ~|~ \mathsf{div} ~|~ \mathsf{min} ~|~ \mathsf{max} ~|~ \mathsf{copysign} \\
& \mathit{testop}_{\mathsf{ixx}} &::=& \mathsf{eqz} \\
& \mathit{testop}_{\mathsf{fxx}} &::=&  \\
& \mathit{relop}_{\mathsf{ixx}} &::=& \mathsf{eq} ~|~ \mathsf{ne} ~|~ {\mathsf{lt\_}}{\mathit{sx}} ~|~ {\mathsf{gt\_}}{\mathit{sx}} ~|~ {\mathsf{le\_}}{\mathit{sx}} ~|~ {\mathsf{ge\_}}{\mathit{sx}} \\
& \mathit{relop}_{\mathsf{fxx}} &::=& \mathsf{eq} ~|~ \mathsf{ne} ~|~ \mathsf{lt} ~|~ \mathsf{gt} ~|~ \mathsf{le} ~|~ \mathsf{ge} \\
& \mathit{unop}_{\mathit{numtype}} &::=& \mathit{unop}_{\mathsf{ixx}} ~|~ \mathit{unop}_{\mathsf{fxx}} \\
& \mathit{binop}_{\mathit{numtype}} &::=& \mathit{binop}_{\mathsf{ixx}} ~|~ \mathit{binop}_{\mathsf{fxx}} \\
& \mathit{testop}_{\mathit{numtype}} &::=& \mathit{testop}_{\mathsf{ixx}} ~|~ \mathit{testop}_{\mathsf{fxx}} \\
& \mathit{relop}_{\mathit{numtype}} &::=& \mathit{relop}_{\mathsf{ixx}} ~|~ \mathit{relop}_{\mathsf{fxx}} \\
& \mathit{cvtop} &::=& \mathsf{convert} ~|~ \mathsf{reinterpret} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
& \mathit{c}_{\mathit{numtype}} &::=& \mathit{nat} \\
& \mathit{c}_{\mathit{vectype}} &::=& \mathit{nat} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}}
\mbox{(block type)} & \mathit{blocktype} &::=& \mathit{functype} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}}
\mbox{(instruction)} & \mathit{instr} &::=& \mathsf{unreachable} \\ &&|&
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
\mathit{numtype}.\mathsf{const}~\mathit{c}_{\mathit{numtype}} \\ &&|&
\mathit{numtype} . \mathit{unop}_{\mathit{numtype}} \\ &&|&
\mathit{numtype} . \mathit{binop}_{\mathit{numtype}} \\ &&|&
\mathit{numtype} . \mathit{testop}_{\mathit{numtype}} \\ &&|&
\mathit{numtype} . \mathit{relop}_{\mathit{numtype}} \\ &&|&
{\mathit{numtype}.\mathsf{extend}}{\mathit{n}} \\ &&|&
\mathit{numtype} . {{{{\mathit{cvtop}}{\mathsf{\_}}}{\mathit{numtype}}}{\mathsf{\_}}}{{\mathit{sx}^?}} \\ &&|&
\mathsf{ref.null}~\mathit{reftype} \\ &&|&
\mathsf{ref.func}~\mathit{funcidx} \\ &&|&
\mathsf{ref.is\_null} \\ &&|&
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
{\mathit{numtype}.\mathsf{store}}{{\mathit{n}^?}}~\mathit{u{\scriptstyle32}}~\mathit{u{\scriptstyle32}} \\
\mbox{(expression)} & \mathit{expr} &::=& {\mathit{instr}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
& \mathit{elemmode} &::=& \mathsf{table}~\mathit{tableidx}~\mathit{expr} ~|~ \mathsf{declare} \\
& \mathit{datamode} &::=& \mathsf{memory}~\mathit{memidx}~\mathit{expr} \\
\mbox{(function)} & \mathit{func} &::=& \mathsf{func}~\mathit{functype}~{\mathit{valtype}^\ast}~\mathit{expr} \\
\mbox{(global)} & \mathit{global} &::=& \mathsf{global}~\mathit{globaltype}~\mathit{expr} \\
\mbox{(table)} & \mathit{table} &::=& \mathsf{table}~\mathit{tabletype} \\
\mbox{(memory)} & \mathit{mem} &::=& \mathsf{memory}~\mathit{memtype} \\
\mbox{(table segment)} & \mathit{elem} &::=& \mathsf{elem}~\mathit{reftype}~{\mathit{expr}^\ast}~{\mathit{elemmode}^?} \\
\mbox{(memory segment)} & \mathit{data} &::=& \mathsf{data}~{\mathit{byte}^\ast}~{\mathit{datamode}^?} \\
\mbox{(start function)} & \mathit{start} &::=& \mathsf{start}~\mathit{funcidx} \\
\mbox{(external use)} & \mathit{externuse} &::=& \mathsf{func}~\mathit{funcidx} ~|~ \mathsf{global}~\mathit{globalidx} ~|~ \mathsf{table}~\mathit{tableidx} ~|~ \mathsf{mem}~\mathit{memidx} \\
\mbox{(export)} & \mathit{export} &::=& \mathsf{export}~\mathit{name}~\mathit{externuse} \\
\mbox{(import)} & \mathit{import} &::=& \mathsf{import}~\mathit{name}~\mathit{name}~\mathit{externtype} \\
\mbox{(module)} & \mathit{module} &::=& \mathsf{module}~{\mathit{import}^\ast}~{\mathit{func}^\ast}~{\mathit{global}^\ast}~{\mathit{table}^\ast}~{\mathit{mem}^\ast}~{\mathit{elem}^\ast}~{\mathit{data}^\ast}~{\mathit{start}^?}~{\mathit{export}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{Ki} &=& 1024 &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{min}(0,\, \mathit{j}) &=& 0 &  \\
\mathrm{min}(\mathit{i},\, 0) &=& 0 &  \\
\mathrm{min}(\mathit{i} + 1,\, \mathit{j} + 1) &=& \mathrm{min}(\mathit{i},\, \mathit{j}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{|\mathsf{i{\scriptstyle32}}|} &=& 32 &  \\
{|\mathsf{i{\scriptstyle64}}|} &=& 64 &  \\
{|\mathsf{f{\scriptstyle32}}|} &=& 32 &  \\
{|\mathsf{f{\scriptstyle64}}|} &=& 64 &  \\
{|\mathsf{v{\scriptstyle128}}|} &=& 128 &  \\
\end{array}
$$

\vspace{1ex}

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
\begin{array}{@{}lrrl@{}}
& \mathit{testfuse} &::=& {\mathsf{ab}}_{\mathit{nat}}\,\,\mathit{nat}~\mathit{nat} \\ &&|&
{\mathsf{cd}}_{\mathit{nat}}\,\mathit{nat}~\mathit{nat} \\ &&|&
{\mathsf{ef\_}}{\mathit{nat}}~\mathit{nat}~\mathit{nat} \\ &&|&
{{\mathsf{gh}}_{\mathit{nat}}}{\mathit{nat}}~\mathit{nat} \\ &&|&
{{\mathsf{ij}}_{\mathit{nat}}}{\mathit{nat}}~\mathit{nat} \\ &&|&
{\mathsf{kl\_ab}}{\mathit{nat}}~\mathit{nat}~\mathit{nat} \\ &&|&
{\mathsf{mn\_}}{\mathsf{ab}}~\mathit{nat}~\mathit{nat}~\mathit{nat} \\ &&|&
{{\mathsf{op\_}}{\mathsf{ab}}}{\mathit{nat}}~\mathit{nat}~\mathit{nat} \\ &&|&
{{\mathsf{qr}}_{\mathit{nat}}}{\mathsf{ab}}~\mathit{nat}~\mathit{nat} \\
\mbox{(context)} & \mathit{context} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{func}~{\mathit{functype}^\ast},\; \mathsf{global}~{\mathit{globaltype}^\ast},\; \mathsf{table}~{\mathit{tabletype}^\ast},\; \mathsf{mem}~{\mathit{memtype}^\ast},\; \\
  \mathsf{elem}~{\mathit{elemtype}^\ast},\; \mathsf{data}~{\mathit{datatype}^\ast},\; \\
  \mathsf{local}~{\mathit{valtype}^\ast},\; \mathsf{label}~{\mathit{resulttype}^\ast},\; \mathsf{return}~{\mathit{resulttype}^?} \;\}\end{array} \\
\end{array}
$$

\vspace{1ex}

$\boxed{{ \vdash }\;\mathit{limits} : \mathit{nat}}$

$\boxed{{ \vdash }\;\mathit{functype} : \mathsf{ok}}$

$\boxed{{ \vdash }\;\mathit{globaltype} : \mathsf{ok}}$

$\boxed{{ \vdash }\;\mathit{tabletype} : \mathsf{ok}}$

$\boxed{{ \vdash }\;\mathit{memtype} : \mathsf{ok}}$

$\boxed{{ \vdash }\;\mathit{externtype} : \mathsf{ok}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{n}_{1} \leq \mathit{n}_{2} \leq \mathit{k}
}{
{ \vdash }\;[\mathit{n}_{1} .. \mathit{n}_{2}] : \mathit{k}
} \, {[\textsc{\scriptsize K{-}limits}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{ \vdash }\;\mathit{ft} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{ \vdash }\;\mathit{gt} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{lim} : {2^{32}} - 1
}{
{ \vdash }\;\mathit{lim}~\mathit{rt} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{lim} : {2^{16}}
}{
{ \vdash }\;\mathit{lim}~\mathsf{i{\scriptstyle8}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{functype} : \mathsf{ok}
}{
{ \vdash }\;\mathsf{func}~\mathit{functype} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{globaltype} : \mathsf{ok}
}{
{ \vdash }\;\mathsf{global}~\mathit{globaltype} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{tabletype} : \mathsf{ok}
}{
{ \vdash }\;\mathsf{table}~\mathit{tabletype} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{memtype} : \mathsf{ok}
}{
{ \vdash }\;\mathsf{mem}~\mathit{memtype} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{ \vdash }\;\mathit{valtype} \leq \mathit{valtype}}$

$\boxed{{ \vdash }\;{\mathit{valtype}^\ast} \leq {\mathit{valtype}^\ast}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{ \vdash }\;\mathit{t} \leq \mathit{t}
} \, {[\textsc{\scriptsize S{-}refl}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{ \vdash }\;\mathsf{bot} \leq \mathit{t}
} \, {[\textsc{\scriptsize S{-}bot}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({ \vdash }\;\mathit{t}_{1} \leq \mathit{t}_{2})^\ast
}{
{ \vdash }\;{\mathit{t}_{1}^\ast} \leq {\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize S{-}result}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{ \vdash }\;\mathit{limits} \leq \mathit{limits}}$

$\boxed{{ \vdash }\;\mathit{functype} \leq \mathit{functype}}$

$\boxed{{ \vdash }\;\mathit{globaltype} \leq \mathit{globaltype}}$

$\boxed{{ \vdash }\;\mathit{tabletype} \leq \mathit{tabletype}}$

$\boxed{{ \vdash }\;\mathit{memtype} \leq \mathit{memtype}}$

$\boxed{{ \vdash }\;\mathit{externtype} \leq \mathit{externtype}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{n}_{11} \geq \mathit{n}_{21}
 \qquad
\mathit{n}_{12} \leq \mathit{n}_{22}
}{
{ \vdash }\;[\mathit{n}_{11} .. \mathit{n}_{12}] \leq [\mathit{n}_{21} .. \mathit{n}_{22}]
} \, {[\textsc{\scriptsize S{-}limits}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{ \vdash }\;\mathit{ft} \leq \mathit{ft}
} \, {[\textsc{\scriptsize S{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{ \vdash }\;\mathit{gt} \leq \mathit{gt}
} \, {[\textsc{\scriptsize S{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{lim}_{1} \leq \mathit{lim}_{2}
}{
{ \vdash }\;\mathit{lim}_{1}~\mathit{rt} \leq \mathit{lim}_{2}~\mathit{rt}
} \, {[\textsc{\scriptsize S{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{lim}_{1} \leq \mathit{lim}_{2}
}{
{ \vdash }\;\mathit{lim}_{1}~\mathsf{i{\scriptstyle8}} \leq \mathit{lim}_{2}~\mathsf{i{\scriptstyle8}}
} \, {[\textsc{\scriptsize S{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{ft}_{1} \leq \mathit{ft}_{2}
}{
{ \vdash }\;\mathsf{func}~\mathit{ft}_{1} \leq \mathsf{func}~\mathit{ft}_{2}
} \, {[\textsc{\scriptsize S{-}extern{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{gt}_{1} \leq \mathit{gt}_{2}
}{
{ \vdash }\;\mathsf{global}~\mathit{gt}_{1} \leq \mathsf{global}~\mathit{gt}_{2}
} \, {[\textsc{\scriptsize S{-}extern{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{tt}_{1} \leq \mathit{tt}_{2}
}{
{ \vdash }\;\mathsf{table}~\mathit{tt}_{1} \leq \mathsf{table}~\mathit{tt}_{2}
} \, {[\textsc{\scriptsize S{-}extern{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{mt}_{1} \leq \mathit{mt}_{2}
}{
{ \vdash }\;\mathsf{mem}~\mathit{mt}_{1} \leq \mathsf{mem}~\mathit{mt}_{2}
} \, {[\textsc{\scriptsize S{-}extern{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{\mathit{context} \vdash \mathit{instr} : \mathit{functype}}$

$\boxed{\mathit{context} \vdash {\mathit{instr}^\ast} : \mathit{functype}}$

$\boxed{\mathit{context} \vdash \mathit{expr} : \mathit{resulttype}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C} \vdash {\mathit{instr}^\ast} : \epsilon \rightarrow {\mathit{t}^\ast}
}{
\mathit{C} \vdash {\mathit{instr}^\ast} : {\mathit{t}^\ast}
} \, {[\textsc{\scriptsize T{-}expr}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \epsilon : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T*{-}empty}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C} \vdash \mathit{instr}_{1} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
 \qquad
\mathit{C} \vdash \mathit{instr}_{2} : {\mathit{t}_{2}^\ast} \rightarrow {\mathit{t}_{3}^\ast}
}{
\mathit{C} \vdash \mathit{instr}_{1}~{\mathit{instr}_{2}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{3}^\ast}
} \, {[\textsc{\scriptsize T*{-}seq}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
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
} \, {[\textsc{\scriptsize T*{-}weak}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C} \vdash {\mathit{instr}^\ast} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
}{
\mathit{C} \vdash {\mathit{instr}^\ast} : {\mathit{t}^\ast}~{\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}^\ast}~{\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T*{-}frame}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathsf{unreachable} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T{-}unreachable}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathsf{nop} : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}nop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathsf{drop} : \mathit{t} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}drop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathsf{select}~\mathit{t} : \mathit{t}~\mathit{t}~\mathsf{i{\scriptstyle32}} \rightarrow \mathit{t}
} \, {[\textsc{\scriptsize T{-}select{-}expl}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{t} \leq {\mathit{t}'}
 \qquad
{\mathit{t}'} = \mathit{numtype} \lor {\mathit{t}'} = \mathit{vectype}
}{
\mathit{C} \vdash \mathsf{select} : \mathit{t}~\mathit{t}~\mathsf{i{\scriptstyle32}} \rightarrow \mathit{t}
} \, {[\textsc{\scriptsize T{-}select{-}impl}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{\mathit{context} \vdash \mathit{blocktype} : \mathit{functype}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{ft} : \mathsf{ok}
}{
\mathit{C} \vdash \mathit{ft} : \mathit{ft}
} \, {[\textsc{\scriptsize K{-}block}]}
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

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{label}[\mathit{l}] = {\mathit{t}^\ast}
}{
\mathit{C} \vdash \mathsf{br}~\mathit{l} : {\mathit{t}_{1}^\ast}~{\mathit{t}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T{-}br}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{label}[\mathit{l}] = {\mathit{t}^\ast}
}{
\mathit{C} \vdash \mathsf{br\_if}~\mathit{l} : {\mathit{t}^\ast}~\mathsf{i{\scriptstyle32}} \rightarrow {\mathit{t}^\ast}
} \, {[\textsc{\scriptsize T{-}br\_if}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({ \vdash }\;{\mathit{t}^\ast} \leq \mathit{C}.\mathsf{label}[\mathit{l}])^\ast
 \qquad
{ \vdash }\;{\mathit{t}^\ast} \leq \mathit{C}.\mathsf{label}[{\mathit{l}'}]
}{
\mathit{C} \vdash \mathsf{br\_table}~{\mathit{l}^\ast}~{\mathit{l}'} : {\mathit{t}_{1}^\ast}~{\mathit{t}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T{-}br\_table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{return} = ({\mathit{t}^\ast})
}{
\mathit{C} \vdash \mathsf{return} : {\mathit{t}_{1}^\ast}~{\mathit{t}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T{-}return}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{func}[\mathit{x}] = {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
}{
\mathit{C} \vdash \mathsf{call}~\mathit{x} : {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T{-}call}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{lim}~\mathsf{funcref}
 \qquad
\mathit{ft} = {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
}{
\mathit{C} \vdash \mathsf{call\_indirect}~\mathit{x}~\mathit{ft} : {\mathit{t}_{1}^\ast}~\mathsf{i{\scriptstyle32}} \rightarrow {\mathit{t}_{2}^\ast}
} \, {[\textsc{\scriptsize T{-}call\_indirect}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathit{nt}.\mathsf{const}~\mathit{c}_{\mathit{nt}} : \epsilon \rightarrow \mathit{nt}
} \, {[\textsc{\scriptsize T{-}const}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathit{nt} . \mathit{unop} : \mathit{nt} \rightarrow \mathit{nt}
} \, {[\textsc{\scriptsize T{-}unop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathit{nt} . \mathit{binop} : \mathit{nt}~\mathit{nt} \rightarrow \mathit{nt}
} \, {[\textsc{\scriptsize T{-}binop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathit{nt} . \mathit{testop} : \mathit{nt} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}testop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathit{nt} . \mathit{relop} : \mathit{nt}~\mathit{nt} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}relop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{n} \leq {|\mathit{nt}|}
}{
\mathit{C} \vdash {\mathit{nt}.\mathsf{extend}}{\mathit{n}} : \mathit{nt} \rightarrow \mathit{nt}
} \, {[\textsc{\scriptsize T{-}extend}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{nt}_{1} \neq \mathit{nt}_{2}
 \qquad
{|\mathit{nt}_{1}|} = {|\mathit{nt}_{2}|}
}{
\mathit{C} \vdash \mathsf{cvtop}~\mathit{nt}_{1}~\mathsf{reinterpret}~\mathit{nt}_{2} : \mathit{nt}_{2} \rightarrow \mathit{nt}_{1}
} \, {[\textsc{\scriptsize T{-}reinterpret}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathsf{i}}{\mathit{n}}_{1} \neq {\mathsf{i}}{\mathit{n}}_{2}
 \qquad
{\mathit{sx}^?} = \epsilon \Leftrightarrow {|{\mathsf{i}}{\mathit{n}}_{1}|} > {|{\mathsf{i}}{\mathit{n}}_{2}|}
}{
\mathit{C} \vdash {\mathsf{i}}{\mathit{n}}_{1} . {{{{\mathsf{convert}}{\mathsf{\_}}}{{\mathsf{i}}{\mathit{n}}_{2}}}{\mathsf{\_}}}{{\mathit{sx}^?}} : {\mathsf{i}}{\mathit{n}}_{2} \rightarrow {\mathsf{i}}{\mathit{n}}_{1}
} \, {[\textsc{\scriptsize T{-}convert{-}i}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathsf{f}}{\mathit{n}}_{1} \neq {\mathsf{f}}{\mathit{n}}_{2}
}{
\mathit{C} \vdash \mathsf{cvtop}~{\mathsf{f}}{\mathit{n}}_{1}~\mathsf{convert}~{\mathsf{f}}{\mathit{n}}_{2} : {\mathsf{f}}{\mathit{n}}_{2} \rightarrow {\mathsf{f}}{\mathit{n}}_{1}
} \, {[\textsc{\scriptsize T{-}convert{-}f}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathsf{ref.null}~\mathit{rt} : \epsilon \rightarrow \mathit{rt}
} \, {[\textsc{\scriptsize T{-}ref.null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{func}[\mathit{x}] = \mathit{ft}
}{
\mathit{C} \vdash \mathsf{ref.func}~\mathit{x} : \epsilon \rightarrow \mathsf{funcref}
} \, {[\textsc{\scriptsize T{-}ref.func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathsf{ref.is\_null} : \mathit{rt} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}ref.is\_null}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{local}[\mathit{x}] = \mathit{t}
}{
\mathit{C} \vdash \mathsf{local.get}~\mathit{x} : \epsilon \rightarrow \mathit{t}
} \, {[\textsc{\scriptsize T{-}local.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{local}[\mathit{x}] = \mathit{t}
}{
\mathit{C} \vdash \mathsf{local.set}~\mathit{x} : \mathit{t} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}local.set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{local}[\mathit{x}] = \mathit{t}
}{
\mathit{C} \vdash \mathsf{local.tee}~\mathit{x} : \mathit{t} \rightarrow \mathit{t}
} \, {[\textsc{\scriptsize T{-}local.tee}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{global}[\mathit{x}] = {\mathsf{mut}^?}~\mathit{t}
}{
\mathit{C} \vdash \mathsf{global.get}~\mathit{x} : \epsilon \rightarrow \mathit{t}
} \, {[\textsc{\scriptsize T{-}global.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{global}[\mathit{x}] = \mathsf{mut}~\mathit{t}
}{
\mathit{C} \vdash \mathsf{global.set}~\mathit{x} : \mathit{t} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}global.set}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{lim}~\mathit{rt}
}{
\mathit{C} \vdash \mathsf{table.get}~\mathit{x} : \mathsf{i{\scriptstyle32}} \rightarrow \mathit{rt}
} \, {[\textsc{\scriptsize T{-}table.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{lim}~\mathit{rt}
}{
\mathit{C} \vdash \mathsf{table.set}~\mathit{x} : \mathsf{i{\scriptstyle32}}~\mathit{rt} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{tt}
}{
\mathit{C} \vdash \mathsf{table.size}~\mathit{x} : \epsilon \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}table.size}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{lim}~\mathit{rt}
}{
\mathit{C} \vdash \mathsf{table.grow}~\mathit{x} : \mathit{rt}~\mathsf{i{\scriptstyle32}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}table.grow}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{lim}~\mathit{rt}
}{
\mathit{C} \vdash \mathsf{table.fill}~\mathit{x} : \mathsf{i{\scriptstyle32}}~\mathit{rt}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.fill}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}_{1}] = \mathit{lim}_{1}~\mathit{rt}
 \qquad
\mathit{C}.\mathsf{table}[\mathit{x}_{2}] = \mathit{lim}_{2}~\mathit{rt}
}{
\mathit{C} \vdash \mathsf{table.copy}~\mathit{x}_{1}~\mathit{x}_{2} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.copy}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}_{1}] = \mathit{lim}~\mathit{rt}
 \qquad
\mathit{C}.\mathsf{elem}[\mathit{x}_{2}] = \mathit{rt}
}{
\mathit{C} \vdash \mathsf{table.init}~\mathit{x}_{1}~\mathit{x}_{2} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.init}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{elem}[\mathit{x}] = \mathit{rt}
}{
\mathit{C} \vdash \mathsf{elem.drop}~\mathit{x} : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}elem.drop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{mem}[0] = \mathit{mt}
}{
\mathit{C} \vdash \mathsf{memory.size} : \epsilon \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}memory.size}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{mem}[0] = \mathit{mt}
}{
\mathit{C} \vdash \mathsf{memory.grow} : \mathsf{i{\scriptstyle32}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}memory.grow}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{mem}[0] = \mathit{mt}
}{
\mathit{C} \vdash \mathsf{memory.fill} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}memory.fill}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{mem}[0] = \mathit{mt}
}{
\mathit{C} \vdash \mathsf{memory.copy} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}memory.copy}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{mem}[0] = \mathit{mt}
 \qquad
\mathit{C}.\mathsf{data}[\mathit{x}] = \mathsf{ok}
}{
\mathit{C} \vdash \mathsf{memory.init}~\mathit{x} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}memory.init}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{data}[\mathit{x}] = \mathsf{ok}
}{
\mathit{C} \vdash \mathsf{data.drop}~\mathit{x} : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}data.drop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{mem}[0] = \mathit{mt}
 \qquad
{2^{\mathit{n}_{\mathsf{a}}}} \leq {|\mathit{nt}|} / 8
 \qquad
({2^{\mathit{n}_{\mathsf{a}}}} \leq \mathit{n} / 8 < {|\mathit{nt}|} / 8)^?
 \qquad
{\mathit{n}^?} = \epsilon \lor \mathit{nt} = {\mathsf{i}}{\mathit{n}}
}{
\mathit{C} \vdash {\mathit{nt}.\mathsf{load}}{{({{\mathit{n}}{\mathsf{\_}}}{\mathit{sx}})^?}}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}} : \mathsf{i{\scriptstyle32}} \rightarrow \mathit{nt}
} \, {[\textsc{\scriptsize T{-}load}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{mem}[0] = \mathit{mt}
 \qquad
{2^{\mathit{n}_{\mathsf{a}}}} \leq {|\mathit{nt}|} / 8
 \qquad
({2^{\mathit{n}_{\mathsf{a}}}} \leq \mathit{n} / 8 < {|\mathit{nt}|} / 8)^?
 \qquad
{\mathit{n}^?} = \epsilon \lor \mathit{nt} = {\mathsf{i}}{\mathit{n}}
}{
\mathit{C} \vdash {\mathit{nt}.\mathsf{store}}{{\mathit{n}^?}}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}} : \mathsf{i{\scriptstyle32}}~\mathit{nt} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}store}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{\mathit{context} \vdash \mathit{instr}~\mathsf{const}}$

$\boxed{\mathit{context} \vdash \mathit{expr}~\mathsf{const}}$

$\boxed{\mathit{context} \vdash \mathit{expr} : \mathit{valtype}~\mathsf{const}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash (\mathit{nt}.\mathsf{const}~\mathit{c})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}const}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash (\mathsf{ref.null}~\mathit{rt})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}ref.null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash (\mathsf{ref.func}~\mathit{x})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}ref.func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{global}[\mathit{x}] = \epsilon~\mathit{t}
}{
\mathit{C} \vdash (\mathsf{global.get}~\mathit{x})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}global.get}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
(\mathit{C} \vdash \mathit{instr}~\mathsf{const})^\ast
}{
\mathit{C} \vdash {\mathit{instr}^\ast}~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}expr}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C} \vdash \mathit{expr} : \mathit{t}
 \qquad
\mathit{C} \vdash \mathit{expr}~\mathsf{const}
}{
\mathit{C} \vdash \mathit{expr} : \mathit{t}~\mathsf{const}
} \, {[\textsc{\scriptsize TC{-}expr}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{\mathit{context} \vdash \mathit{func} : \mathit{functype}}$

$\boxed{\mathit{context} \vdash \mathit{global} : \mathit{globaltype}}$

$\boxed{\mathit{context} \vdash \mathit{table} : \mathit{tabletype}}$

$\boxed{\mathit{context} \vdash \mathit{mem} : \mathit{memtype}}$

$\boxed{\mathit{context} \vdash \mathit{elem} : \mathit{reftype}}$

$\boxed{\mathit{context} \vdash \mathit{data} : \mathsf{ok}}$

$\boxed{\mathit{context} \vdash \mathit{elemmode} : \mathit{reftype}}$

$\boxed{\mathit{context} \vdash \mathit{datamode} : \mathsf{ok}}$

$\boxed{\mathit{context} \vdash \mathit{start} : \mathsf{ok}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{ft} = {\mathit{t}_{1}^\ast} \rightarrow {\mathit{t}_{2}^\ast}
 \qquad
{ \vdash }\;\mathit{ft} : \mathsf{ok}
 \qquad
\mathit{C}, \mathsf{local}~{\mathit{t}_{1}^\ast}~{\mathit{t}^\ast}, \mathsf{label}~({\mathit{t}_{2}^\ast}), \mathsf{return}~({\mathit{t}_{2}^\ast}) \vdash \mathit{expr} : {\mathit{t}_{2}^\ast}
}{
\mathit{C} \vdash \mathsf{func}~\mathit{ft}~{\mathit{t}^\ast}~\mathit{expr} : \mathit{ft}
} \, {[\textsc{\scriptsize T{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{gt} : \mathsf{ok}
 \qquad
\mathit{gt} = {\mathsf{mut}^?}~\mathit{t}
 \qquad
\mathit{C} \vdash \mathit{expr} : \mathit{t}~\mathsf{const}
}{
\mathit{C} \vdash \mathsf{global}~\mathit{gt}~\mathit{expr} : \mathit{gt}
} \, {[\textsc{\scriptsize T{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{tt} : \mathsf{ok}
}{
\mathit{C} \vdash \mathsf{table}~\mathit{tt} : \mathit{tt}
} \, {[\textsc{\scriptsize T{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{mt} : \mathsf{ok}
}{
\mathit{C} \vdash \mathsf{memory}~\mathit{mt} : \mathit{mt}
} \, {[\textsc{\scriptsize T{-}mem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
(\mathit{C} \vdash \mathit{expr} : \mathit{rt})^\ast
 \qquad
(\mathit{C} \vdash \mathit{elemmode} : \mathit{rt})^?
}{
\mathit{C} \vdash \mathsf{elem}~\mathit{rt}~{\mathit{expr}^\ast}~{\mathit{elemmode}^?} : \mathit{rt}
} \, {[\textsc{\scriptsize T{-}elem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
(\mathit{C} \vdash \mathit{datamode} : \mathsf{ok})^?
}{
\mathit{C} \vdash \mathsf{data}~{\mathit{b}^\ast}~{\mathit{datamode}^?} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}data}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{lim}~\mathit{rt}
 \qquad
(\mathit{C} \vdash \mathit{expr} : \mathsf{i{\scriptstyle32}}~\mathsf{const})^\ast
}{
\mathit{C} \vdash \mathsf{table}~\mathit{x}~\mathit{expr} : \mathit{rt}
} \, {[\textsc{\scriptsize T{-}elemmode{-}active}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
\mathit{C} \vdash \mathsf{declare} : \mathit{rt}
} \, {[\textsc{\scriptsize T{-}elemmode{-}declare}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{mem}[0] = \mathit{mt}
 \qquad
(\mathit{C} \vdash \mathit{expr} : \mathsf{i{\scriptstyle32}}~\mathsf{const})^\ast
}{
\mathit{C} \vdash \mathsf{memory}~0~\mathit{expr} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}datamode}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{func}[\mathit{x}] = \epsilon \rightarrow \epsilon
}{
\mathit{C} \vdash \mathsf{start}~\mathit{x} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}start}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{\mathit{context} \vdash \mathit{import} : \mathit{externtype}}$

$\boxed{\mathit{context} \vdash \mathit{export} : \mathit{externtype}}$

$\boxed{\mathit{context} \vdash \mathit{externuse} : \mathit{externtype}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{ \vdash }\;\mathit{xt} : \mathsf{ok}
}{
\mathit{C} \vdash \mathsf{import}~\mathit{name}_{1}~\mathit{name}_{2}~\mathit{xt} : \mathit{xt}
} \, {[\textsc{\scriptsize T{-}import}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C} \vdash \mathit{externuse} : \mathit{xt}
}{
\mathit{C} \vdash \mathsf{export}~\mathit{name}~\mathit{externuse} : \mathit{xt}
} \, {[\textsc{\scriptsize T{-}export}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{func}[\mathit{x}] = \mathit{ft}
}{
\mathit{C} \vdash \mathsf{func}~\mathit{x} : \mathsf{func}~\mathit{ft}
} \, {[\textsc{\scriptsize T{-}externuse{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{global}[\mathit{x}] = \mathit{gt}
}{
\mathit{C} \vdash \mathsf{global}~\mathit{x} : \mathsf{global}~\mathit{gt}
} \, {[\textsc{\scriptsize T{-}externuse{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{table}[\mathit{x}] = \mathit{tt}
}{
\mathit{C} \vdash \mathsf{table}~\mathit{x} : \mathsf{table}~\mathit{tt}
} \, {[\textsc{\scriptsize T{-}externuse{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\mathit{C}.\mathsf{mem}[\mathit{x}] = \mathit{mt}
}{
\mathit{C} \vdash \mathsf{mem}~\mathit{x} : \mathsf{mem}~\mathit{mt}
} \, {[\textsc{\scriptsize T{-}externuse{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{ \vdash }\;\mathit{module} : \mathsf{ok}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\begin{array}{@{}c@{}}
\mathit{C} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{func}~{\mathit{ft}^\ast},\; \mathsf{global}~{\mathit{gt}^\ast},\; \mathsf{table}~{\mathit{tt}^\ast},\; \mathsf{mem}~{\mathit{mt}^\ast},\; \mathsf{elem}~{\mathit{rt}^\ast},\; \mathsf{data}~{\mathsf{ok}^{\mathit{n}}} \}\end{array}
 \\
(\mathit{C} \vdash \mathit{func} : \mathit{ft})^\ast
 \qquad
(\mathit{C} \vdash \mathit{global} : \mathit{gt})^\ast
 \qquad
(\mathit{C} \vdash \mathit{table} : \mathit{tt})^\ast
 \qquad
(\mathit{C} \vdash \mathit{mem} : \mathit{mt})^\ast
 \\
(\mathit{C} \vdash \mathit{elem} : \mathit{rt})^\ast
 \qquad
(\mathit{C} \vdash \mathit{data} : \mathsf{ok})^{\mathit{n}}
 \qquad
(\mathit{C} \vdash \mathit{start} : \mathsf{ok})^?
 \\
{|{\mathit{mem}^\ast}|} \leq 1
\end{array}
}{
{ \vdash }\;\mathsf{module}~{\mathit{import}^\ast}~{\mathit{func}^\ast}~{\mathit{global}^\ast}~{\mathit{table}^\ast}~{\mathit{mem}^\ast}~{\mathit{elem}^\ast}~{\mathit{data}^{\mathit{n}}}~{\mathit{start}^?}~{\mathit{export}^\ast} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}module}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}}
\mbox{(address)} & \mathit{addr} &::=& \mathit{nat} \\
\mbox{(function address)} & \mathit{funcaddr} &::=& \mathit{addr} \\
\mbox{(global address)} & \mathit{globaladdr} &::=& \mathit{addr} \\
\mbox{(table address)} & \mathit{tableaddr} &::=& \mathit{addr} \\
\mbox{(memory address)} & \mathit{memaddr} &::=& \mathit{addr} \\
\mbox{(elem address)} & \mathit{elemaddr} &::=& \mathit{addr} \\
\mbox{(data address)} & \mathit{dataaddr} &::=& \mathit{addr} \\
\mbox{(label address)} & \mathit{labeladdr} &::=& \mathit{addr} \\
\mbox{(host address)} & \mathit{hostaddr} &::=& \mathit{addr} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(number)} & \mathit{num} &::=& \mathit{numtype}.\mathsf{const}~\mathit{c}_{\mathit{numtype}} \\
\mbox{(reference)} & \mathit{ref} &::=& \mathsf{ref.null}~\mathit{reftype} ~|~ \mathsf{ref.func}~\mathit{funcaddr} ~|~ \mathsf{ref.extern}~\mathit{hostaddr} \\
\mbox{(value)} & \mathit{val} &::=& \mathit{num} ~|~ \mathit{ref} \\
\mbox{(result)} & \mathit{result} &::=& {\mathit{val}^\ast} ~|~ \mathsf{trap} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}}
\mbox{(external value)} & \mathit{externval} &::=& \mathsf{func}~\mathit{funcaddr} ~|~ \mathsf{global}~\mathit{globaladdr} ~|~ \mathsf{table}~\mathit{tableaddr} ~|~ \mathsf{mem}~\mathit{memaddr} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{default}}_{\mathsf{i{\scriptstyle32}}} &=& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) &  \\
{\mathrm{default}}_{\mathsf{i{\scriptstyle64}}} &=& (\mathsf{i{\scriptstyle64}}.\mathsf{const}~0) &  \\
{\mathrm{default}}_{\mathsf{f{\scriptstyle32}}} &=& (\mathsf{f{\scriptstyle32}}.\mathsf{const}~0) &  \\
{\mathrm{default}}_{\mathsf{f{\scriptstyle64}}} &=& (\mathsf{f{\scriptstyle64}}.\mathsf{const}~0) &  \\
{\mathrm{default}}_{\mathsf{funcref}} &=& (\mathsf{ref.null}~\mathsf{funcref}) &  \\
{\mathrm{default}}_{\mathsf{externref}} &=& (\mathsf{ref.null}~\mathsf{externref}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(function instance)} & \mathit{funcinst} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{module}~\mathit{moduleinst},\; \\
  \mathsf{code}~\mathit{func} \;\}\end{array} \\
\mbox{(global instance)} & \mathit{globalinst} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{type}~\mathit{globaltype},\; \\
  \mathsf{value}~\mathit{val} \;\}\end{array} \\
\mbox{(table instance)} & \mathit{tableinst} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{type}~\mathit{tabletype},\; \\
  \mathsf{elem}~{\mathit{ref}^\ast} \;\}\end{array} \\
\mbox{(memory instance)} & \mathit{meminst} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{type}~\mathit{memtype},\; \\
  \mathsf{data}~{\mathit{byte}^\ast} \;\}\end{array} \\
\mbox{(element instance)} & \mathit{eleminst} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{type}~\mathit{elemtype},\; \\
  \mathsf{elem}~{\mathit{ref}^\ast} \;\}\end{array} \\
\mbox{(data instance)} & \mathit{datainst} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{data}~{\mathit{byte}^\ast} \;\}\end{array} \\
\mbox{(export instance)} & \mathit{exportinst} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{name}~\mathit{name},\; \\
  \mathsf{value}~\mathit{externval} \;\}\end{array} \\
\mbox{(store)} & \mathit{store} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{func}~{\mathit{funcinst}^\ast},\; \\
  \mathsf{global}~{\mathit{globalinst}^\ast},\; \\
  \mathsf{table}~{\mathit{tableinst}^\ast},\; \\
  \mathsf{mem}~{\mathit{meminst}^\ast},\; \\
  \mathsf{elem}~{\mathit{eleminst}^\ast},\; \\
  \mathsf{data}~{\mathit{datainst}^\ast} \;\}\end{array} \\
\mbox{(module instance)} & \mathit{moduleinst} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{func}~{\mathit{funcaddr}^\ast},\; \\
  \mathsf{global}~{\mathit{globaladdr}^\ast},\; \\
  \mathsf{table}~{\mathit{tableaddr}^\ast},\; \\
  \mathsf{mem}~{\mathit{memaddr}^\ast},\; \\
  \mathsf{elem}~{\mathit{elemaddr}^\ast},\; \\
  \mathsf{data}~{\mathit{dataaddr}^\ast},\; \\
  \mathsf{export}~{\mathit{exportinst}^\ast} \;\}\end{array} \\
\mbox{(frame)} & \mathit{frame} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{local}~{\mathit{val}^\ast},\; \\
  \mathsf{module}~\mathit{moduleinst} \;\}\end{array} \\
\mbox{(state)} & \mathit{state} &::=& \mathit{store} ; \mathit{frame} \\
\mbox{(configuration)} & \mathit{config} &::=& \mathit{state} ; {\mathit{instr}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathit{s} ; \mathit{f}).\mathsf{module}.\mathsf{func} &=& \mathit{f}.\mathsf{module}.\mathsf{func} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathit{s} ; \mathit{f}).\mathsf{func} &=& \mathit{s}.\mathsf{func} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathit{s} ; \mathit{f}).\mathsf{global} &=& \mathit{s}.\mathsf{global} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathit{s} ; \mathit{f}).\mathsf{table} &=& \mathit{s}.\mathsf{table} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathit{s} ; \mathit{f}).\mathsf{mem} &=& \mathit{s}.\mathsf{mem} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathit{s} ; \mathit{f}).\mathsf{elem} &=& \mathit{s}.\mathsf{elem} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathit{s} ; \mathit{f}).\mathsf{data} &=& \mathit{s}.\mathsf{data} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathit{s} ; \mathit{f}).\mathsf{func}}{[\mathit{x}]} &=& \mathit{s}.\mathsf{func}[\mathit{f}.\mathsf{module}.\mathsf{func}[\mathit{x}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathit{s} ; \mathit{f}).\mathsf{global}}{[\mathit{x}]} &=& \mathit{s}.\mathsf{global}[\mathit{f}.\mathsf{module}.\mathsf{global}[\mathit{x}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathit{s} ; \mathit{f}).\mathsf{table}}{[\mathit{x}]} &=& \mathit{s}.\mathsf{table}[\mathit{f}.\mathsf{module}.\mathsf{table}[\mathit{x}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathit{s} ; \mathit{f}).\mathsf{mem}}{[\mathit{x}]} &=& \mathit{s}.\mathsf{mem}[\mathit{f}.\mathsf{module}.\mathsf{mem}[\mathit{x}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathit{s} ; \mathit{f}).\mathsf{elem}}{[\mathit{x}]} &=& \mathit{s}.\mathsf{elem}[\mathit{f}.\mathsf{module}.\mathsf{elem}[\mathit{x}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathit{s} ; \mathit{f}).\mathsf{data}}{[\mathit{x}]} &=& \mathit{s}.\mathsf{data}[\mathit{f}.\mathsf{module}.\mathsf{data}[\mathit{x}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathit{s} ; \mathit{f}).\mathsf{local}}{[\mathit{x}]} &=& \mathit{f}.\mathsf{local}[\mathit{x}] &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathit{s} ; \mathit{f})[\mathsf{local}[\mathit{x}] = \mathit{v}] &=& \mathit{s} ; \mathit{f}[\mathsf{local}[\mathit{x}] = \mathit{v}] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathit{s} ; \mathit{f})[\mathsf{global}[\mathit{x}].\mathsf{value} = \mathit{v}] &=& \mathit{s}[\mathsf{global}[\mathit{f}.\mathsf{module}.\mathsf{global}[\mathit{x}]].\mathsf{value} = \mathit{v}] ; \mathit{f} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathit{s} ; \mathit{f})[\mathsf{table}[\mathit{x}].\mathsf{elem}[\mathit{i}] = \mathit{r}] &=& \mathit{s}[\mathsf{table}[\mathit{f}.\mathsf{module}.\mathsf{table}[\mathit{x}]].\mathsf{elem}[\mathit{i}] = \mathit{r}] ; \mathit{f} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathit{s} ; \mathit{f})[\mathsf{table}[\mathit{x}] = \mathit{ti}] &=& \mathit{s}[\mathsf{table}[\mathit{f}.\mathsf{module}.\mathsf{table}[\mathit{x}]] = \mathit{ti}] ; \mathit{f} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathit{s} ; \mathit{f})[\mathsf{mem}[\mathit{x}].\mathsf{data}[\mathit{i} : \mathit{j}] = {\mathit{b}^\ast}] &=& \mathit{s}[\mathsf{mem}[\mathit{f}.\mathsf{module}.\mathsf{mem}[\mathit{x}]].\mathsf{data}[\mathit{i} : \mathit{j}] = {\mathit{b}^\ast}] ; \mathit{f} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathit{s} ; \mathit{f})[\mathsf{mem}[\mathit{x}] = \mathit{mi}] &=& \mathit{s}[\mathsf{mem}[\mathit{f}.\mathsf{module}.\mathsf{mem}[\mathit{x}]] = \mathit{mi}] ; \mathit{f} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathit{s} ; \mathit{f})[\mathsf{elem}[\mathit{x}].\mathsf{elem} = {\mathit{r}^\ast}] &=& \mathit{s}[\mathsf{elem}[\mathit{f}.\mathsf{module}.\mathsf{elem}[\mathit{x}]].\mathsf{elem} = {\mathit{r}^\ast}] ; \mathit{f} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathit{s} ; \mathit{f})[\mathsf{data}[\mathit{x}].\mathsf{data} = {\mathit{b}^\ast}] &=& \mathit{s}[\mathsf{data}[\mathit{f}.\mathsf{module}.\mathsf{data}[\mathit{x}]].\mathsf{data} = {\mathit{b}^\ast}] ; \mathit{f} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{grow}_{\mathit{table}}(\mathit{ti},\, \mathit{n},\, \mathit{r}) &=& {\mathit{ti}'} &\quad
  \mbox{if}~\mathit{ti} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~[\mathit{i} .. \mathit{j}]~\mathit{rt},\; \mathsf{elem}~{{\mathit{r}'}^\ast} \}\end{array} \\
 &&&\quad {\land}~{\mathit{i}'} = {|{{\mathit{r}'}^\ast}|} + \mathit{n} \\
 &&&\quad {\land}~{\mathit{ti}'} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~[{\mathit{i}'} .. \mathit{j}]~\mathit{rt},\; \mathsf{elem}~{{\mathit{r}'}^\ast}~{\mathit{r}^{\mathit{n}}} \}\end{array} \\
 &&&\quad {\land}~{ \vdash }\;{\mathit{ti}'}.\mathsf{type} : \mathsf{ok} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{grow}_{\mathit{memory}}(\mathit{mi},\, \mathit{n}) &=& {\mathit{mi}'} &\quad
  \mbox{if}~\mathit{mi} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([\mathit{i} .. \mathit{j}]~\mathsf{i{\scriptstyle8}}),\; \mathsf{data}~{\mathit{b}^\ast} \}\end{array} \\
 &&&\quad {\land}~{\mathit{i}'} = {|{\mathit{b}^\ast}|} / (64 \cdot \mathrm{Ki}) + \mathit{n} \\
 &&&\quad {\land}~{\mathit{mi}'} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([{\mathit{i}'} .. \mathit{j}]~\mathsf{i{\scriptstyle8}}),\; \mathsf{data}~{\mathit{b}^\ast}~{0^{\mathit{n} \cdot 64 \cdot \mathrm{Ki}}} \}\end{array} \\
 &&&\quad {\land}~{ \vdash }\;{\mathit{mi}'}.\mathsf{type} : \mathsf{ok} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}}
\mbox{(administrative instruction)} & \mathit{instr} &::=& \mathit{instr} \\ &&|&
\mathsf{ref.func}~\mathit{funcaddr} \\ &&|&
\mathsf{ref.extern}~\mathit{hostaddr} \\ &&|&
\mathsf{call}~\mathit{funcaddr} \\ &&|&
{{\mathsf{label}}_{\mathit{n}}}{\{{\mathit{instr}^\ast}\}}~{\mathit{instr}^\ast} \\ &&|&
{{\mathsf{frame}}_{\mathit{n}}}{\{\mathit{frame}\}}~{\mathit{instr}^\ast} \\ &&|&
\mathsf{trap} \\
\mbox{(evaluation context)} & \mathit{E} &::=& [\mathsf{\_}] \\ &&|&
{\mathit{val}^\ast}~\mathit{E}~{\mathit{instr}^\ast} \\ &&|&
{{\mathsf{label}}_{\mathit{n}}}{\{{\mathit{instr}^\ast}\}}~\mathit{E} \\
\end{array}
$$

$\boxed{\mathit{config} \hookrightarrow \mathit{config}}$

$\boxed{{\mathit{instr}^\ast} \hookrightarrow {\mathit{instr}^\ast}}$

$\boxed{\mathit{config} \hookrightarrow {\mathit{instr}^\ast}}$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}pure}]} \quad & \mathit{z} ; {\mathit{instr}^\ast} &\hookrightarrow& \mathit{z} ; {{\mathit{instr}'}^\ast} &\quad
  \mbox{if}~{\mathit{instr}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\
{[\textsc{\scriptsize E{-}read}]} \quad & \mathit{z} ; {\mathit{instr}^\ast} &\hookrightarrow& \mathit{z} ; {{\mathit{instr}'}^\ast} &\quad
  \mbox{if}~\mathit{z} ; {\mathit{instr}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}unreachable}]} \quad & \mathsf{unreachable} &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}nop}]} \quad & \mathsf{nop} &\hookrightarrow& \epsilon &  \\
{[\textsc{\scriptsize E{-}drop}]} \quad & \mathit{val}~\mathsf{drop} &\hookrightarrow& \epsilon &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}select{-}true}]} \quad & \mathit{val}_{1}~\mathit{val}_{2}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{select}~{\mathit{t}^?}) &\hookrightarrow& \mathit{val}_{1} &\quad
  \mbox{if}~\mathit{c} \neq 0 \\
{[\textsc{\scriptsize E{-}select{-}false}]} \quad & \mathit{val}_{1}~\mathit{val}_{2}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{select}~{\mathit{t}^?}) &\hookrightarrow& \mathit{val}_{2} &\quad
  \mbox{if}~\mathit{c} = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}block}]} \quad & {\mathit{val}^{\mathit{k}}}~(\mathsf{block}~\mathit{bt}~{\mathit{instr}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{\mathit{n}}}{\{\epsilon\}}~{\mathit{val}^{\mathit{k}}}~{\mathit{instr}^\ast}) &\quad
  \mbox{if}~\mathit{bt} = {\mathit{t}_{1}^{\mathit{k}}} \rightarrow {\mathit{t}_{2}^{\mathit{n}}} \\
{[\textsc{\scriptsize E{-}loop}]} \quad & {\mathit{val}^{\mathit{k}}}~(\mathsf{loop}~\mathit{bt}~{\mathit{instr}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{\mathit{k}}}{\{\mathsf{loop}~\mathit{bt}~{\mathit{instr}^\ast}\}}~{\mathit{val}^{\mathit{k}}}~{\mathit{instr}^\ast}) &\quad
  \mbox{if}~\mathit{bt} = {\mathit{t}_{1}^{\mathit{k}}} \rightarrow {\mathit{t}_{2}^{\mathit{n}}} \\
{[\textsc{\scriptsize E{-}if{-}true}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{if}~\mathit{bt}~{\mathit{instr}_{1}^\ast}~\mathsf{else}~{\mathit{instr}_{2}^\ast}) &\hookrightarrow& (\mathsf{block}~\mathit{bt}~{\mathit{instr}_{1}^\ast}) &\quad
  \mbox{if}~\mathit{c} \neq 0 \\
{[\textsc{\scriptsize E{-}if{-}false}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{if}~\mathit{bt}~{\mathit{instr}_{1}^\ast}~\mathsf{else}~{\mathit{instr}_{2}^\ast}) &\hookrightarrow& (\mathsf{block}~\mathit{bt}~{\mathit{instr}_{2}^\ast}) &\quad
  \mbox{if}~\mathit{c} = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}label{-}vals}]} \quad & ({{\mathsf{label}}_{\mathit{n}}}{\{{\mathit{instr}^\ast}\}}~{\mathit{val}^\ast}) &\hookrightarrow& {\mathit{val}^\ast} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br{-}zero}]} \quad & ({{\mathsf{label}}_{\mathit{n}}}{\{{{\mathit{instr}'}^\ast}\}}~{{\mathit{val}'}^\ast}~{\mathit{val}^{\mathit{n}}}~(\mathsf{br}~0)~{\mathit{instr}^\ast}) &\hookrightarrow& {\mathit{val}^{\mathit{n}}}~{{\mathit{instr}'}^\ast} &  \\
{[\textsc{\scriptsize E{-}br{-}succ}]} \quad & ({{\mathsf{label}}_{\mathit{n}}}{\{{{\mathit{instr}'}^\ast}\}}~{\mathit{val}^\ast}~(\mathsf{br}~\mathit{l} + 1)~{\mathit{instr}^\ast}) &\hookrightarrow& {\mathit{val}^\ast}~(\mathsf{br}~\mathit{l}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_if{-}true}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{br\_if}~\mathit{l}) &\hookrightarrow& (\mathsf{br}~\mathit{l}) &\quad
  \mbox{if}~\mathit{c} \neq 0 \\
{[\textsc{\scriptsize E{-}br\_if{-}false}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c})~(\mathsf{br\_if}~\mathit{l}) &\hookrightarrow& \epsilon &\quad
  \mbox{if}~\mathit{c} = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_table{-}lt}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{br\_table}~{\mathit{l}^\ast}~{\mathit{l}'}) &\hookrightarrow& (\mathsf{br}~{\mathit{l}^\ast}[\mathit{i}]) &\quad
  \mbox{if}~\mathit{i} < {|{\mathit{l}^\ast}|} \\
{[\textsc{\scriptsize E{-}br\_table{-}ge}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{br\_table}~{\mathit{l}^\ast}~{\mathit{l}'}) &\hookrightarrow& (\mathsf{br}~{\mathit{l}'}) &\quad
  \mbox{if}~\mathit{i} \geq {|{\mathit{l}^\ast}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}call}]} \quad & \mathit{z} ; (\mathsf{call}~\mathit{x}) &\hookrightarrow& (\mathsf{call}~\mathit{z}.\mathsf{module}.\mathsf{func}[\mathit{x}]) &  \\
{[\textsc{\scriptsize E{-}call\_indirect{-}call}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{call\_indirect}~\mathit{x}~\mathit{ft}) &\hookrightarrow& (\mathsf{call}~\mathit{a}) &\quad
  \mbox{if}~{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}[\mathit{i}] = (\mathsf{ref.func}~\mathit{a}) \\
 &&&&\quad {\land}~\mathit{z}.\mathsf{func}[\mathit{a}].\mathsf{code} = \mathsf{func}~{\mathit{ft}'}~{\mathit{t}^\ast}~{\mathit{instr}^\ast} \\
 &&&&\quad {\land}~\mathit{ft} = {\mathit{ft}'} \\
{[\textsc{\scriptsize E{-}call\_indirect{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{call\_indirect}~\mathit{x}~\mathit{ft}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{otherwise} \\
{[\textsc{\scriptsize E{-}call\_addr}]} \quad & \mathit{z} ; {\mathit{val}^{\mathit{k}}}~(\mathsf{call}~\mathit{a}) &\hookrightarrow& ({{\mathsf{frame}}_{\mathit{n}}}{\{\mathit{f}\}}~({{\mathsf{label}}_{\mathit{n}}}{\{\epsilon\}}~{\mathit{instr}^\ast})) &\quad
  \mbox{if}~\mathit{z}.\mathsf{func}[\mathit{a}] = \{ \begin{array}[t]{@{}l@{}}
\mathsf{module}~\mathit{m},\; \mathsf{code}~\mathit{func} \}\end{array} \\
 &&&&\quad {\land}~\mathit{func} = \mathsf{func}~({\mathit{t}_{1}^{\mathit{k}}} \rightarrow {\mathit{t}_{2}^{\mathit{n}}})~{\mathit{t}^\ast}~{\mathit{instr}^\ast} \\
 &&&&\quad {\land}~\mathit{f} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{local}~{\mathit{val}^{\mathit{k}}}~{({\mathrm{default}}_{\mathit{t}})^\ast},\; \mathsf{module}~\mathit{m} \}\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}frame{-}vals}]} \quad & ({{\mathsf{frame}}_{\mathit{n}}}{\{\mathit{f}\}}~{\mathit{val}^{\mathit{n}}}) &\hookrightarrow& {\mathit{val}^{\mathit{n}}} &  \\
{[\textsc{\scriptsize E{-}return{-}frame}]} \quad & ({{\mathsf{frame}}_{\mathit{n}}}{\{\mathit{f}\}}~{{\mathit{val}'}^\ast}~{\mathit{val}^{\mathit{n}}}~\mathsf{return}~{\mathit{instr}^\ast}) &\hookrightarrow& {\mathit{val}^{\mathit{n}}} &  \\
{[\textsc{\scriptsize E{-}return{-}label}]} \quad & ({{\mathsf{label}}_{\mathit{k}}}{\{{{\mathit{instr}'}^\ast}\}}~{\mathit{val}^\ast}~\mathsf{return}~{\mathit{instr}^\ast}) &\hookrightarrow& {\mathit{val}^\ast}~\mathsf{return} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}unop{-}val}]} \quad & (\mathit{nt}.\mathsf{const}~\mathit{c}_{1})~(\mathit{nt} . \mathit{unop}) &\hookrightarrow& (\mathit{nt}.\mathsf{const}~\mathit{c}) &\quad
  \mbox{if}~{{{\mathit{unop}}{}}_{\mathit{nt}}}{(\mathit{c}_{1})} = \mathit{c} \\
{[\textsc{\scriptsize E{-}unop{-}trap}]} \quad & (\mathit{nt}.\mathsf{const}~\mathit{c}_{1})~(\mathit{nt} . \mathit{unop}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{{{\mathit{unop}}{}}_{\mathit{nt}}}{(\mathit{c}_{1})} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}binop{-}val}]} \quad & (\mathit{nt}.\mathsf{const}~\mathit{c}_{1})~(\mathit{nt}.\mathsf{const}~\mathit{c}_{2})~(\mathit{nt} . \mathit{binop}) &\hookrightarrow& (\mathit{nt}.\mathsf{const}~\mathit{c}) &\quad
  \mbox{if}~{{{\mathit{binop}}{}}_{\mathit{nt}}}{(\mathit{c}_{1},\, \mathit{c}_{2})} = \mathit{c} \\
{[\textsc{\scriptsize E{-}binop{-}trap}]} \quad & (\mathit{nt}.\mathsf{const}~\mathit{c}_{1})~(\mathit{nt}.\mathsf{const}~\mathit{c}_{2})~(\mathit{nt} . \mathit{binop}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{{{\mathit{binop}}{}}_{\mathit{nt}}}{(\mathit{c}_{1},\, \mathit{c}_{2})} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}testop}]} \quad & (\mathit{nt}.\mathsf{const}~\mathit{c}_{1})~(\mathit{nt} . \mathit{testop}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c}) &\quad
  \mbox{if}~\mathit{c} = {{{\mathit{testop}}{}}_{\mathit{nt}}}{(\mathit{c}_{1})} \\
{[\textsc{\scriptsize E{-}relop}]} \quad & (\mathit{nt}.\mathsf{const}~\mathit{c}_{1})~(\mathit{nt}.\mathsf{const}~\mathit{c}_{2})~(\mathit{nt} . \mathit{relop}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{c}) &\quad
  \mbox{if}~\mathit{c} = {{{\mathit{relop}}{}}_{\mathit{nt}}}{(\mathit{c}_{1},\, \mathit{c}_{2})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}extend}]} \quad & (\mathit{nt}.\mathsf{const}~\mathit{c})~({\mathit{nt}.\mathsf{extend}}{\mathit{n}}) &\hookrightarrow& (\mathit{nt}.\mathsf{const}~{{\mathrm{ext}}_{\mathit{n}}({|\mathit{nt}|})^{\mathsf{s}}}~(\mathit{c})) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}cvtop{-}val}]} \quad & (\mathit{nt}_{1}.\mathsf{const}~\mathit{c}_{1})~(\mathit{nt}_{2} . {{{{\mathit{cvtop}}{\mathsf{\_}}}{\mathit{nt}_{1}}}{\mathsf{\_}}}{{\mathit{sx}^?}}) &\hookrightarrow& (\mathit{nt}_{2}.\mathsf{const}~\mathit{c}) &\quad
  \mbox{if}~\mathrm{cvtop}(\mathit{nt}_{1},\, \mathit{cvtop},\, \mathit{nt}_{2},\, {\mathit{sx}^?},\, \mathit{c}_{1}) = \mathit{c} \\
{[\textsc{\scriptsize E{-}cvtop{-}trap}]} \quad & (\mathit{nt}_{1}.\mathsf{const}~\mathit{c}_{1})~(\mathit{nt}_{2} . {{{{\mathit{cvtop}}{\mathsf{\_}}}{\mathit{nt}_{1}}}{\mathsf{\_}}}{{\mathit{sx}^?}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~\mathrm{cvtop}(\mathit{nt}_{1},\, \mathit{cvtop},\, \mathit{nt}_{2},\, {\mathit{sx}^?},\, \mathit{c}_{1}) = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.func}]} \quad & \mathit{z} ; (\mathsf{ref.func}~\mathit{x}) &\hookrightarrow& (\mathsf{ref.func}~\mathit{z}.\mathsf{module}.\mathsf{func}[\mathit{x}]) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.is\_null{-}true}]} \quad & \mathit{val}~\mathsf{ref.is\_null} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1) &\quad
  \mbox{if}~\mathit{val} = (\mathsf{ref.null}~\mathit{rt}) \\
{[\textsc{\scriptsize E{-}ref.is\_null{-}false}]} \quad & \mathit{val}~\mathsf{ref.is\_null} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}local.get}]} \quad & \mathit{z} ; (\mathsf{local.get}~\mathit{x}) &\hookrightarrow& {\mathit{z}.\mathsf{local}}{[\mathit{x}]} &  \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}local.set}]} \quad & \mathit{z} ; \mathit{val}~(\mathsf{local.set}~\mathit{x}) &\hookrightarrow& \mathit{z}[\mathsf{local}[\mathit{x}] = \mathit{val}] ; \epsilon &  \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}local.tee}]} \quad & \mathit{val}~(\mathsf{local.tee}~\mathit{x}) &\hookrightarrow& \mathit{val}~\mathit{val}~(\mathsf{local.set}~\mathit{x}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}global.get}]} \quad & \mathit{z} ; (\mathsf{global.get}~\mathit{x}) &\hookrightarrow& {\mathit{z}.\mathsf{global}}{[\mathit{x}]}.\mathsf{value} &  \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}global.set}]} \quad & \mathit{z} ; \mathit{val}~(\mathsf{global.set}~\mathit{x}) &\hookrightarrow& \mathit{z}[\mathsf{global}[\mathit{x}].\mathsf{value} = \mathit{val}] ; \epsilon &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.get{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{table.get}~\mathit{x}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~\mathit{i} \geq {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}|} \\
{[\textsc{\scriptsize E{-}table.get{-}val}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{table.get}~\mathit{x}) &\hookrightarrow& {\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}[\mathit{i}] &\quad
  \mbox{if}~\mathit{i} < {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}|} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.set{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{ref}~(\mathsf{table.set}~\mathit{x}) &\hookrightarrow& \mathit{z} ; \mathsf{trap} &\quad
  \mbox{if}~\mathit{i} \geq {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}|} \\
{[\textsc{\scriptsize E{-}table.set{-}val}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{ref}~(\mathsf{table.set}~\mathit{x}) &\hookrightarrow& \mathit{z}[\mathsf{table}[\mathit{x}].\mathsf{elem}[\mathit{i}] = \mathit{ref}] ; \epsilon &\quad
  \mbox{if}~\mathit{i} < {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.size}]} \quad & \mathit{z} ; (\mathsf{table.size}~\mathit{x}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n}) &\quad
  \mbox{if}~{|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}|} = \mathit{n} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.grow{-}succeed}]} \quad & \mathit{z} ; \mathit{ref}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.grow}~\mathit{x}) &\hookrightarrow& \mathit{z}[\mathsf{table}[\mathit{x}] = \mathit{ti}] ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}|}) &\quad
  \mbox{if}~\mathrm{grow}_{\mathit{table}}({\mathit{z}.\mathsf{table}}{[\mathit{x}]},\, \mathit{n},\, \mathit{ref}) = \mathit{ti} \\
{[\textsc{\scriptsize E{-}table.grow{-}fail}]} \quad & \mathit{z} ; \mathit{ref}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.grow}~\mathit{x}) &\hookrightarrow& \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~-1) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.fill{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.fill}~\mathit{x}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~\mathit{i} + \mathit{n} > {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}|} \\
{[\textsc{\scriptsize E{-}table.fill{-}zero}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.fill}~\mathit{x}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~\mathit{n} = 0 \\
{[\textsc{\scriptsize E{-}table.fill{-}succ}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.fill}~\mathit{x}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~(\mathsf{table.set}~\mathit{x})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + 1)~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} - 1)~(\mathsf{table.fill}~\mathit{x}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.copy{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.copy}~\mathit{x}~\mathit{y}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~\mathit{i} + \mathit{n} > {|{\mathit{z}.\mathsf{table}}{[\mathit{y}]}.\mathsf{elem}|} \lor \mathit{j} + \mathit{n} > {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}|} \\
{[\textsc{\scriptsize E{-}table.copy{-}zero}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.copy}~\mathit{x}~\mathit{y}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~\mathit{n} = 0 \\
{[\textsc{\scriptsize E{-}table.copy{-}le}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.copy}~\mathit{x}~\mathit{y}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{table.get}~\mathit{y})~(\mathsf{table.set}~\mathit{x})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} - 1)~(\mathsf{table.copy}~\mathit{x}~\mathit{y}) &\quad
  \mbox{otherwise, if}~\mathit{j} \leq \mathit{i} \\
{[\textsc{\scriptsize E{-}table.copy{-}gt}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.copy}~\mathit{x}~\mathit{y}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j} + \mathit{n} - 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + \mathit{n} - 1)~(\mathsf{table.get}~\mathit{y})~(\mathsf{table.set}~\mathit{x})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} - 1)~(\mathsf{table.copy}~\mathit{x}~\mathit{y}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.init{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.init}~\mathit{x}~\mathit{y}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~\mathit{i} + \mathit{n} > {|{\mathit{z}.\mathsf{elem}}{[\mathit{y}]}.\mathsf{elem}|} \lor \mathit{j} + \mathit{n} > {|{\mathit{z}.\mathsf{table}}{[\mathit{x}]}.\mathsf{elem}|} \\
{[\textsc{\scriptsize E{-}table.init{-}zero}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.init}~\mathit{x}~\mathit{y}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~\mathit{n} = 0 \\
{[\textsc{\scriptsize E{-}table.init{-}succ}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.init}~\mathit{x}~\mathit{y}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~{\mathit{z}.\mathsf{elem}}{[\mathit{y}]}.\mathsf{elem}[\mathit{i}]~(\mathsf{table.set}~\mathit{x})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} - 1)~(\mathsf{table.init}~\mathit{x}~\mathit{y}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}elem.drop}]} \quad & \mathit{z} ; (\mathsf{elem.drop}~\mathit{x}) &\hookrightarrow& \mathit{z}[\mathsf{elem}[\mathit{x}].\mathsf{elem} = \epsilon] ; \epsilon &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}load{-}num{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathit{nt}.\mathsf{load}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~\mathit{i} + \mathit{n}_{\mathsf{o}} + {|\mathit{nt}|} / 8 > {|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}load{-}num{-}val}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathit{nt}.\mathsf{load}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}}) &\hookrightarrow& (\mathit{nt}.\mathsf{const}~\mathit{c}) &\quad
  \mbox{if}~{\mathrm{bytes}}_{{|\mathit{nt}|}}(\mathit{c}) = {\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}[\mathit{i} + \mathit{n}_{\mathsf{o}} : {|\mathit{nt}|} / 8] \\
{[\textsc{\scriptsize E{-}load{-}pack{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~({\mathit{nt}.\mathsf{load}}{{{\mathit{n}}{\mathsf{\_}}}{\mathit{sx}}}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~\mathit{i} + \mathit{n}_{\mathsf{o}} + \mathit{n} / 8 > {|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}load{-}pack{-}val}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~({\mathit{nt}.\mathsf{load}}{{{\mathit{n}}{\mathsf{\_}}}{\mathit{sx}}}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}}) &\hookrightarrow& (\mathit{nt}.\mathsf{const}~{{\mathrm{ext}}_{\mathit{n}}({|\mathit{nt}|})^{\mathit{sx}}}~(\mathit{c})) &\quad
  \mbox{if}~{\mathrm{bytes}}_{\mathit{n}}(\mathit{c}) = {\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}[\mathit{i} + \mathit{n}_{\mathsf{o}} : \mathit{n} / 8] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}store{-}num{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathit{nt}.\mathsf{const}~\mathit{c})~(\mathit{nt}.\mathsf{store}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}}) &\hookrightarrow& \mathit{z} ; \mathsf{trap} &\quad
  \mbox{if}~\mathit{i} + \mathit{n}_{\mathsf{o}} + {|\mathit{nt}|} / 8 > {|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}store{-}num{-}val}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathit{nt}.\mathsf{const}~\mathit{c})~(\mathit{nt}.\mathsf{store}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}}) &\hookrightarrow& \mathit{z}[\mathsf{mem}[0].\mathsf{data}[\mathit{i} + \mathit{n}_{\mathsf{o}} : {|\mathit{nt}|} / 8] = {\mathit{b}^\ast}] ; \epsilon &\quad
  \mbox{if}~{\mathit{b}^\ast} = {\mathrm{bytes}}_{{|\mathit{nt}|}}(\mathit{c}) \\
{[\textsc{\scriptsize E{-}store{-}pack{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathit{nt}.\mathsf{const}~\mathit{c})~({\mathit{nt}.\mathsf{store}}{\mathit{n}}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}}) &\hookrightarrow& \mathit{z} ; \mathsf{trap} &\quad
  \mbox{if}~\mathit{i} + \mathit{n}_{\mathsf{o}} + \mathit{n} / 8 > {|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}store{-}pack{-}val}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathit{nt}.\mathsf{const}~\mathit{c})~({\mathit{nt}.\mathsf{store}}{\mathit{n}}~\mathit{n}_{\mathsf{a}}~\mathit{n}_{\mathsf{o}}) &\hookrightarrow& \mathit{z}[\mathsf{mem}[0].\mathsf{data}[\mathit{i} + \mathit{n}_{\mathsf{o}} : \mathit{n} / 8] = {\mathit{b}^\ast}] ; \epsilon &\quad
  \mbox{if}~{\mathit{b}^\ast} = {\mathrm{bytes}}_{\mathit{n}}({\mathrm{wrap}}_{{|\mathit{nt}|},\mathit{n}}(\mathit{c})) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.size}]} \quad & \mathit{z} ; (\mathsf{memory.size}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n}) &\quad
  \mbox{if}~\mathit{n} \cdot 64 \cdot \mathrm{Ki} = {|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.grow{-}succeed}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.grow}) &\hookrightarrow& \mathit{z}[\mathsf{mem}[0] = \mathit{mi}] ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} / (64 \cdot \mathrm{Ki})) &\quad
  \mbox{if}~\mathrm{grow}_{\mathit{memory}}({\mathit{z}.\mathsf{mem}}{[0]},\, \mathit{n}) = \mathit{mi} \\
{[\textsc{\scriptsize E{-}memory.grow{-}fail}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.grow}) &\hookrightarrow& \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~-1) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.fill{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.fill}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~\mathit{i} + \mathit{n} > {|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}memory.fill{-}zero}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.fill}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~\mathit{n} = 0 \\
{[\textsc{\scriptsize E{-}memory.fill{-}succ}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.fill}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~\mathit{val}~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~0~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + 1)~\mathit{val}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} - 1)~(\mathsf{memory.fill}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.copy{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.copy}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~\mathit{i} + \mathit{n} > {|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} \lor \mathit{j} + \mathit{n} > {|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}memory.copy{-}zero}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.copy}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~\mathit{n} = 0 \\
{[\textsc{\scriptsize E{-}memory.copy{-}le}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.copy}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~({\mathsf{i{\scriptstyle32}}.\mathsf{load}}{{{8}{\mathsf{\_}}}{\mathsf{u}}}~0~0)~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~0~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} - 1)~(\mathsf{memory.copy}) &\quad
  \mbox{otherwise, if}~\mathit{j} \leq \mathit{i} \\
{[\textsc{\scriptsize E{-}memory.copy{-}gt}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.copy}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j} + \mathit{n} - 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + \mathit{n} - 1)~({\mathsf{i{\scriptstyle32}}.\mathsf{load}}{{{8}{\mathsf{\_}}}{\mathsf{u}}}~0~0)~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~0~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} - 1)~(\mathsf{memory.copy}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.init{-}trap}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.init}~\mathit{x}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~\mathit{i} + \mathit{n} > {|{\mathit{z}.\mathsf{data}}{[\mathit{x}]}.\mathsf{data}|} \lor \mathit{j} + \mathit{n} > {|{\mathit{z}.\mathsf{mem}}{[0]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}memory.init{-}zero}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.init}~\mathit{x}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~\mathit{n} = 0 \\
{[\textsc{\scriptsize E{-}memory.init{-}succ}]} \quad & \mathit{z} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.init}~\mathit{x}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{z}.\mathsf{data}}{[\mathit{x}]}.\mathsf{data}[\mathit{i}])~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~0~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{j} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{i} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n} - 1)~(\mathsf{memory.init}~\mathit{x}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}data.drop}]} \quad & \mathit{z} ; (\mathsf{data.drop}~\mathit{x}) &\hookrightarrow& \mathit{z}[\mathsf{data}[\mathit{x}].\mathsf{data} = \epsilon] ; \epsilon &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{funcs}(\epsilon) &=& \epsilon &  \\
\mathrm{funcs}((\mathsf{func}~\mathit{fa})~{{\mathit{externval}'}^\ast}) &=& \mathit{fa}~\mathrm{funcs}({{\mathit{externval}'}^\ast}) &  \\
\mathrm{funcs}(\mathit{externval}~{{\mathit{externval}'}^\ast}) &=& \mathrm{funcs}({{\mathit{externval}'}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{globals}(\epsilon) &=& \epsilon &  \\
\mathrm{globals}((\mathsf{global}~\mathit{ga})~{{\mathit{externval}'}^\ast}) &=& \mathit{ga}~\mathrm{globals}({{\mathit{externval}'}^\ast}) &  \\
\mathrm{globals}(\mathit{externval}~{{\mathit{externval}'}^\ast}) &=& \mathrm{globals}({{\mathit{externval}'}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{tables}(\epsilon) &=& \epsilon &  \\
\mathrm{tables}((\mathsf{table}~\mathit{ta})~{{\mathit{externval}'}^\ast}) &=& \mathit{ta}~\mathrm{tables}({{\mathit{externval}'}^\ast}) &  \\
\mathrm{tables}(\mathit{externval}~{{\mathit{externval}'}^\ast}) &=& \mathrm{tables}({{\mathit{externval}'}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{mems}(\epsilon) &=& \epsilon &  \\
\mathrm{mems}((\mathsf{mem}~\mathit{ma})~{{\mathit{externval}'}^\ast}) &=& \mathit{ma}~\mathrm{mems}({{\mathit{externval}'}^\ast}) &  \\
\mathrm{mems}(\mathit{externval}~{{\mathit{externval}'}^\ast}) &=& \mathrm{mems}({{\mathit{externval}'}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{instexport}({\mathit{fa}^\ast},\, {\mathit{ga}^\ast},\, {\mathit{ta}^\ast},\, {\mathit{ma}^\ast},\, \mathsf{export}~\mathit{name}~(\mathsf{func}~\mathit{x})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~\mathit{name},\; \mathsf{value}~(\mathsf{func}~{\mathit{fa}^\ast}[\mathit{x}]) \}\end{array} &  \\
\mathrm{instexport}({\mathit{fa}^\ast},\, {\mathit{ga}^\ast},\, {\mathit{ta}^\ast},\, {\mathit{ma}^\ast},\, \mathsf{export}~\mathit{name}~(\mathsf{global}~\mathit{x})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~\mathit{name},\; \mathsf{value}~(\mathsf{global}~{\mathit{ga}^\ast}[\mathit{x}]) \}\end{array} &  \\
\mathrm{instexport}({\mathit{fa}^\ast},\, {\mathit{ga}^\ast},\, {\mathit{ta}^\ast},\, {\mathit{ma}^\ast},\, \mathsf{export}~\mathit{name}~(\mathsf{table}~\mathit{x})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~\mathit{name},\; \mathsf{value}~(\mathsf{table}~{\mathit{ta}^\ast}[\mathit{x}]) \}\end{array} &  \\
\mathrm{instexport}({\mathit{fa}^\ast},\, {\mathit{ga}^\ast},\, {\mathit{ta}^\ast},\, {\mathit{ma}^\ast},\, \mathsf{export}~\mathit{name}~(\mathsf{mem}~\mathit{x})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~\mathit{name},\; \mathsf{value}~(\mathsf{mem}~{\mathit{ma}^\ast}[\mathit{x}]) \}\end{array} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{allocfunc}(\mathit{s},\, \mathit{m},\, \mathit{func}) &=& (\mathit{s}[\mathsf{func} = ..\mathit{fi}],\, {|\mathit{s}.\mathsf{func}|}) &\quad
  \mbox{if}~\mathit{fi} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{module}~\mathit{m},\; \mathsf{code}~\mathit{func} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{allocfuncs}(\mathit{s},\, \mathit{m},\, \epsilon) &=& (\mathit{s},\, \epsilon) &  \\
\mathrm{allocfuncs}(\mathit{s},\, \mathit{m},\, \mathit{func}~{{\mathit{func}'}^\ast}) &=& (\mathit{s}_{2},\, \mathit{fa}~{{\mathit{fa}'}^\ast}) &\quad
  \mbox{if}~(\mathit{s}_{1},\, \mathit{fa}) = \mathrm{allocfunc}(\mathit{s},\, \mathit{m},\, \mathit{func}) \\
 &&&\quad {\land}~(\mathit{s}_{2},\, {{\mathit{fa}'}^\ast}) = \mathrm{allocfuncs}(\mathit{s}_{1},\, \mathit{m},\, {{\mathit{func}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{allocglobal}(\mathit{s},\, \mathit{globaltype},\, \mathit{val}) &=& (\mathit{s}[\mathsf{global} = ..\mathit{gi}],\, {|\mathit{s}.\mathsf{global}|}) &\quad
  \mbox{if}~\mathit{gi} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~\mathit{globaltype},\; \mathsf{value}~\mathit{val} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{allocglobals}(\mathit{s},\, \epsilon,\, \epsilon) &=& (\mathit{s},\, \epsilon) &  \\
\mathrm{allocglobals}(\mathit{s},\, \mathit{globaltype}~{{\mathit{globaltype}'}^\ast},\, \mathit{val}~{{\mathit{val}'}^\ast}) &=& (\mathit{s}_{2},\, \mathit{ga}~{{\mathit{ga}'}^\ast}) &\quad
  \mbox{if}~(\mathit{s}_{1},\, \mathit{ga}) = \mathrm{allocglobal}(\mathit{s},\, \mathit{globaltype},\, \mathit{val}) \\
 &&&\quad {\land}~(\mathit{s}_{2},\, {{\mathit{ga}'}^\ast}) = \mathrm{allocglobals}(\mathit{s}_{1},\, {{\mathit{globaltype}'}^\ast},\, {{\mathit{val}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{alloctable}(\mathit{s},\, [\mathit{i} .. \mathit{j}]~\mathit{rt}) &=& (\mathit{s}[\mathsf{table} = ..\mathit{ti}],\, {|\mathit{s}.\mathsf{table}|}) &\quad
  \mbox{if}~\mathit{ti} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([\mathit{i} .. \mathit{j}]~\mathit{rt}),\; \mathsf{elem}~{(\mathsf{ref.null}~\mathit{rt})^{\mathit{i}}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{alloctables}(\mathit{s},\, \epsilon) &=& (\mathit{s},\, \epsilon) &  \\
\mathrm{alloctables}(\mathit{s},\, \mathit{tabletype}~{{\mathit{tabletype}'}^\ast}) &=& (\mathit{s}_{2},\, \mathit{ta}~{{\mathit{ta}'}^\ast}) &\quad
  \mbox{if}~(\mathit{s}_{1},\, \mathit{ta}) = \mathrm{alloctable}(\mathit{s},\, \mathit{tabletype}) \\
 &&&\quad {\land}~(\mathit{s}_{2},\, {{\mathit{ta}'}^\ast}) = \mathrm{alloctables}(\mathit{s}_{1},\, {{\mathit{tabletype}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{allocmem}(\mathit{s},\, [\mathit{i} .. \mathit{j}]~\mathsf{i{\scriptstyle8}}) &=& (\mathit{s}[\mathsf{mem} = ..\mathit{mi}],\, {|\mathit{s}.\mathsf{mem}|}) &\quad
  \mbox{if}~\mathit{mi} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([\mathit{i} .. \mathit{j}]~\mathsf{i{\scriptstyle8}}),\; \mathsf{data}~{0^{\mathit{i} \cdot 64 \cdot \mathrm{Ki}}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{allocmems}(\mathit{s},\, \epsilon) &=& (\mathit{s},\, \epsilon) &  \\
\mathrm{allocmems}(\mathit{s},\, \mathit{memtype}~{{\mathit{memtype}'}^\ast}) &=& (\mathit{s}_{2},\, \mathit{ma}~{{\mathit{ma}'}^\ast}) &\quad
  \mbox{if}~(\mathit{s}_{1},\, \mathit{ma}) = \mathrm{allocmem}(\mathit{s},\, \mathit{memtype}) \\
 &&&\quad {\land}~(\mathit{s}_{2},\, {{\mathit{ma}'}^\ast}) = \mathrm{allocmems}(\mathit{s}_{1},\, {{\mathit{memtype}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{allocelem}(\mathit{s},\, \mathit{rt},\, {\mathit{ref}^\ast}) &=& (\mathit{s}[\mathsf{elem} = ..\mathit{ei}],\, {|\mathit{s}.\mathsf{elem}|}) &\quad
  \mbox{if}~\mathit{ei} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~\mathit{rt},\; \mathsf{elem}~{\mathit{ref}^\ast} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{allocelems}(\mathit{s},\, \epsilon,\, \epsilon) &=& (\mathit{s},\, \epsilon) &  \\
\mathrm{allocelems}(\mathit{s},\, \mathit{rt}~{{\mathit{rt}'}^\ast},\, {\mathit{ref}^\ast}~{{{\mathit{ref}'}^\ast}^\ast}) &=& (\mathit{s}_{2},\, \mathit{ea}~{{\mathit{ea}'}^\ast}) &\quad
  \mbox{if}~(\mathit{s}_{1},\, \mathit{ea}) = \mathrm{allocelem}(\mathit{s},\, \mathit{rt},\, {\mathit{ref}^\ast}) \\
 &&&\quad {\land}~(\mathit{s}_{2},\, {{\mathit{ea}'}^\ast}) = \mathrm{allocelems}(\mathit{s}_{2},\, {{\mathit{rt}'}^\ast},\, {{{\mathit{ref}'}^\ast}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{allocdata}(\mathit{s},\, {\mathit{byte}^\ast}) &=& (\mathit{s}[\mathsf{data} = ..\mathit{di}],\, {|\mathit{s}.\mathsf{data}|}) &\quad
  \mbox{if}~\mathit{di} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{data}~{\mathit{byte}^\ast} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{allocdatas}(\mathit{s},\, \epsilon) &=& (\mathit{s},\, \epsilon) &  \\
\mathrm{allocdatas}(\mathit{s},\, {\mathit{byte}^\ast}~{{{\mathit{byte}'}^\ast}^\ast}) &=& (\mathit{s}_{2},\, \mathit{da}~{{\mathit{da}'}^\ast}) &\quad
  \mbox{if}~(\mathit{s}_{1},\, \mathit{da}) = \mathrm{allocdata}(\mathit{s},\, {\mathit{byte}^\ast}) \\
 &&&\quad {\land}~(\mathit{s}_{2},\, {{\mathit{da}'}^\ast}) = \mathrm{allocdatas}(\mathit{s}_{1},\, {{{\mathit{byte}'}^\ast}^\ast}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{allocmodule}(\mathit{s},\, \mathit{module},\, {\mathit{externval}^\ast},\, {\mathit{val}^\ast},\, {({\mathit{ref}^\ast})^\ast}) &=& (\mathit{s}_{6},\, \mathit{m}) &\quad
  \mbox{if}~\mathit{module} = \mathsf{module}~{\mathit{import}^\ast}~{\mathit{func}^{\mathit{n}_{\mathit{func}}}}~{(\mathsf{global}~\mathit{globaltype}~\mathit{expr}_{1})^{\mathit{n}_{\mathit{global}}}}~{(\mathsf{table}~\mathit{tabletype})^{\mathit{n}_{\mathit{table}}}}~{(\mathsf{memory}~\mathit{memtype})^{\mathit{n}_{\mathit{mem}}}}~{(\mathsf{elem}~\mathit{rt}~{\mathit{expr}_{2}^\ast}~{\mathit{elemmode}^?})^{\mathit{n}_{\mathit{elem}}}}~{(\mathsf{data}~{\mathit{byte}^\ast}~{\mathit{datamode}^?})^{\mathit{n}_{\mathit{data}}}}~{\mathit{start}^?}~{\mathit{export}^\ast} \\
 &&&\quad {\land}~{\mathit{fa}_{\mathit{ex}}^\ast} = \mathrm{funcs}({\mathit{externval}^\ast}) \\
 &&&\quad {\land}~{\mathit{ga}_{\mathit{ex}}^\ast} = \mathrm{globals}({\mathit{externval}^\ast}) \\
 &&&\quad {\land}~{\mathit{ta}_{\mathit{ex}}^\ast} = \mathrm{tables}({\mathit{externval}^\ast}) \\
 &&&\quad {\land}~{\mathit{ma}_{\mathit{ex}}^\ast} = \mathrm{mems}({\mathit{externval}^\ast}) \\
 &&&\quad {\land}~{\mathit{fa}^\ast} = {{|\mathit{s}.\mathsf{func}|} + \mathit{i}^{\mathit{i} < \mathit{n}_{\mathit{func}}}} \\
 &&&\quad {\land}~{\mathit{ga}^\ast} = {{|\mathit{s}.\mathsf{global}|} + \mathit{i}^{\mathit{i} < \mathit{n}_{\mathit{global}}}} \\
 &&&\quad {\land}~{\mathit{ta}^\ast} = {{|\mathit{s}.\mathsf{table}|} + \mathit{i}^{\mathit{i} < \mathit{n}_{\mathit{table}}}} \\
 &&&\quad {\land}~{\mathit{ma}^\ast} = {{|\mathit{s}.\mathsf{mem}|} + \mathit{i}^{\mathit{i} < \mathit{n}_{\mathit{mem}}}} \\
 &&&\quad {\land}~{\mathit{ea}^\ast} = {{|\mathit{s}.\mathsf{elem}|} + \mathit{i}^{\mathit{i} < \mathit{n}_{\mathit{elem}}}} \\
 &&&\quad {\land}~{\mathit{da}^\ast} = {{|\mathit{s}.\mathsf{data}|} + \mathit{i}^{\mathit{i} < \mathit{n}_{\mathit{data}}}} \\
 &&&\quad {\land}~{\mathit{xi}^\ast} = {\mathrm{instexport}({\mathit{fa}_{\mathit{ex}}^\ast}~{\mathit{fa}^\ast},\, {\mathit{ga}_{\mathit{ex}}^\ast}~{\mathit{ga}^\ast},\, {\mathit{ta}_{\mathit{ex}}^\ast}~{\mathit{ta}^\ast},\, {\mathit{ma}_{\mathit{ex}}^\ast}~{\mathit{ma}^\ast},\, \mathit{export})^\ast} \\
 &&&\quad {\land}~\mathit{m} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{func}~{\mathit{fa}_{\mathit{ex}}^\ast}~{\mathit{fa}^\ast},\; \\
  \mathsf{global}~{\mathit{ga}_{\mathit{ex}}^\ast}~{\mathit{ga}^\ast},\; \\
  \mathsf{table}~{\mathit{ta}_{\mathit{ex}}^\ast}~{\mathit{ta}^\ast},\; \\
  \mathsf{mem}~{\mathit{ma}_{\mathit{ex}}^\ast}~{\mathit{ma}^\ast},\; \\
  \mathsf{elem}~{\mathit{ea}^\ast},\; \\
  \mathsf{data}~{\mathit{da}^\ast},\; \\
  \mathsf{export}~{\mathit{xi}^\ast} \}\end{array} \\
 &&&\quad {\land}~(\mathit{s}_{1},\, {\mathit{fa}^\ast}) = \mathrm{allocfuncs}(\mathit{s},\, \mathit{m},\, {\mathit{func}^{\mathit{n}_{\mathit{func}}}}) \\
 &&&\quad {\land}~(\mathit{s}_{2},\, {\mathit{ga}^\ast}) = \mathrm{allocglobals}(\mathit{s}_{1},\, {\mathit{globaltype}^{\mathit{n}_{\mathit{global}}}},\, {\mathit{val}^\ast}) \\
 &&&\quad {\land}~(\mathit{s}_{3},\, {\mathit{ta}^\ast}) = \mathrm{alloctables}(\mathit{s}_{2},\, {\mathit{tabletype}^{\mathit{n}_{\mathit{table}}}}) \\
 &&&\quad {\land}~(\mathit{s}_{4},\, {\mathit{ma}^\ast}) = \mathrm{allocmems}(\mathit{s}_{3},\, {\mathit{memtype}^{\mathit{n}_{\mathit{mem}}}}) \\
 &&&\quad {\land}~(\mathit{s}_{5},\, {\mathit{ea}^\ast}) = \mathrm{allocelems}(\mathit{s}_{4},\, {\mathit{rt}^{\mathit{n}_{\mathit{elem}}}},\, {({\mathit{ref}^\ast})^\ast}) \\
 &&&\quad {\land}~(\mathit{s}_{6},\, {\mathit{da}^\ast}) = \mathrm{allocdatas}(\mathit{s}_{5},\, {({\mathit{byte}^\ast})^{\mathit{n}_{\mathit{data}}}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{runelem}(\mathsf{elem}~\mathit{reftype}~{\mathit{expr}^\ast},\, \mathit{i}) &=& \epsilon &  \\
\mathrm{runelem}(\mathsf{elem}~\mathit{reftype}~{\mathit{expr}^\ast}~(\mathsf{declare}),\, \mathit{i}) &=& (\mathsf{elem.drop}~\mathit{i}) &  \\
\mathrm{runelem}(\mathsf{elem}~\mathit{reftype}~{\mathit{expr}^\ast}~(\mathsf{table}~\mathit{x}~{\mathit{instr}^\ast}),\, \mathit{i}) &=& {\mathit{instr}^\ast}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{table.init}~\mathit{x}~\mathit{i})~(\mathsf{elem.drop}~\mathit{i}) &\quad
  \mbox{if}~\mathit{n} = {|{\mathit{expr}^\ast}|} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{rundata}(\mathsf{data}~{\mathit{byte}^\ast},\, \mathit{i}) &=& \epsilon &  \\
\mathrm{rundata}(\mathsf{data}~{\mathit{byte}^\ast}~(\mathsf{memory}~0~{\mathit{instr}^\ast}),\, \mathit{i}) &=& {\mathit{instr}^\ast}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~\mathit{n})~(\mathsf{memory.init}~\mathit{i})~(\mathsf{data.drop}~\mathit{i}) &\quad
  \mbox{if}~\mathit{n} = {|{\mathit{byte}^\ast}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{concat}_{\mathit{instr}}(\epsilon) &=& \epsilon &  \\
\mathrm{concat}_{\mathit{instr}}({\mathit{instr}^\ast}~{{{\mathit{instr}'}^\ast}^\ast}) &=& {\mathit{instr}^\ast}~\mathrm{concat}_{\mathit{instr}}({{{\mathit{instr}'}^\ast}^\ast}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{instantiation}(\mathit{s},\, \mathit{module},\, {\mathit{externval}^\ast}) &=& {\mathit{s}'} ; \mathit{f} ; \mathrm{concat}_{\mathit{instr}}({{\mathit{instr}_{\mathit{elem}}^\ast}^\ast})~\mathrm{concat}_{\mathit{instr}}({{\mathit{instr}_{\mathit{data}}^\ast}^\ast})~{(\mathsf{call}~\mathit{x})^?} &\quad
  \mbox{if}~\mathit{module} = \mathsf{module}~{\mathit{import}^\ast}~{\mathit{func}^\ast}~{\mathit{global}^\ast}~{\mathit{table}^\ast}~{\mathit{mem}^\ast}~{\mathit{elem}^\ast}~{\mathit{data}^\ast}~{\mathit{start}^?}~{\mathit{export}^\ast} \\
 &&&\quad {\land}~\mathit{m}_{\mathit{init}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{func}~\mathrm{funcs}({\mathit{externval}^\ast}),\; \\
  \mathsf{global}~\mathrm{globals}({\mathit{externval}^\ast}),\; \\
  \mathsf{table}~\epsilon,\; \\
  \mathsf{mem}~\epsilon,\; \\
  \mathsf{elem}~\epsilon,\; \\
  \mathsf{data}~\epsilon,\; \\
  \mathsf{export}~\epsilon \}\end{array} \\
 &&&\quad {\land}~\mathit{f}_{\mathit{init}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{local}~\epsilon,\; \mathsf{module}~\mathit{m}_{\mathit{init}} \}\end{array} \\
 &&&\quad {\land}~(\mathit{global} = \mathsf{global}~\mathit{globaltype}~{\mathit{instr}_{1}^\ast})^\ast \\
 &&&\quad {\land}~(\mathit{s} ; \mathit{f}_{\mathit{init}} ; {\mathit{instr}_{1}^\ast} \hookrightarrow \mathit{val})^\ast \\
 &&&\quad {\land}~(\mathit{elem} = \mathsf{elem}~\mathit{reftype}~{({\mathit{instr}_{2}^\ast})^\ast}~{\mathit{elemmode}^?})^\ast \\
 &&&\quad {\land}~{(\mathit{s} ; \mathit{f}_{\mathit{init}} ; {\mathit{instr}_{2}^\ast} \hookrightarrow \mathit{ref})^\ast}^\ast \\
 &&&\quad {\land}~({\mathit{s}'},\, \mathit{m}) = \mathrm{allocmodule}(\mathit{s},\, \mathit{module},\, {\mathit{externval}^\ast},\, {\mathit{val}^\ast},\, {({\mathit{ref}^\ast})^\ast}) \\
 &&&\quad {\land}~\mathit{f} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{local}~\epsilon,\; \mathsf{module}~\mathit{m} \}\end{array} \\
 &&&\quad {\land}~\mathit{n}_{\mathit{elem}} = {|{\mathit{elem}^\ast}|} \\
 &&&\quad {\land}~{{\mathit{instr}_{\mathit{elem}}^\ast}^\ast} = {\mathrm{runelem}({\mathit{elem}^\ast}[\mathit{i}],\, \mathit{i})^{\mathit{i} < \mathit{n}_{\mathit{elem}}}} \\
 &&&\quad {\land}~\mathit{n}_{\mathit{data}} = {|{\mathit{data}^\ast}|} \\
 &&&\quad {\land}~{{\mathit{instr}_{\mathit{data}}^\ast}^\ast} = {\mathrm{rundata}({\mathit{data}^\ast}[\mathit{j}],\, \mathit{j})^{\mathit{j} < \mathit{n}_{\mathit{data}}}} \\
 &&&\quad {\land}~{\mathit{start}^?} = {(\mathsf{start}~\mathit{x})^?} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
\mathrm{invocation}(\mathit{s},\, \mathit{fa},\, {\mathit{val}^{\mathit{n}}}) &=& \mathit{s} ; \mathit{f} ; {\mathit{val}^{\mathit{n}}}~(\mathsf{call}~\mathit{fa}) &\quad
  \mbox{if}~\mathit{m} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{func}~\epsilon,\; \\
  \mathsf{global}~\epsilon,\; \\
  \mathsf{table}~\epsilon,\; \\
  \mathsf{mem}~\epsilon,\; \\
  \mathsf{elem}~\epsilon,\; \\
  \mathsf{data}~\epsilon,\; \\
  \mathsf{export}~\epsilon \}\end{array} \\
 &&&\quad {\land}~\mathit{f} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{local}~\epsilon,\; \mathsf{module}~\mathit{m} \}\end{array} \\
 &&&\quad {\land}~(\mathit{s} ; \mathit{f}).\mathsf{func}[\mathit{fa}].\mathsf{code} = \mathsf{func}~\mathit{functype}~{\mathit{valtype}^\ast}~\mathit{expr} \\
 &&&\quad {\land}~\mathit{functype} = {\mathit{valtype}_{\mathit{param}}^{\mathit{n}}} \rightarrow {\mathit{valtype}_{\mathit{res}}^{\mathit{k}}} \\
\end{array}
$$


```

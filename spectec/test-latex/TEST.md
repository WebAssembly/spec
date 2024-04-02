# Test

```sh
$ (../src/exe-watsup/main.exe test.watsup --latex)
$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{test}}_{{\mathit{sub}}_{{\mathsf{atom}}_{{22}}}}({\mathit{n}}_{{3}_{{\mathsf{atom}}_{{\mathit{y}}}}}) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{curried}}}_{{\mathit{n}}_{{1}}}({\mathit{n}}_{{2}}) &=& {\mathit{n}}_{{1}} + {\mathit{n}}_{{2}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{testfuse}} &::=& {\mathsf{ab}}_{{\mathit{nat}}}\,{\mathit{nat}}~{\mathit{nat}} \\ &&|&
{\mathsf{cd}}_{{\mathit{nat}}}\,{\mathit{nat}}~{\mathit{nat}} \\ &&|&
{\mathsf{ef\_}}{{\mathit{nat}}}~{\mathit{nat}}~{\mathit{nat}} \\ &&|&
{{\mathsf{gh}}_{{\mathit{nat}}}}{{\mathit{nat}}}~{\mathit{nat}} \\ &&|&
{{\mathsf{ij}}_{{\mathit{nat}}}}{{\mathit{nat}}}~{\mathit{nat}} \\ &&|&
{\mathsf{kl\_ab}}{{\mathit{nat}}}~{\mathit{nat}}~{\mathit{nat}} \\ &&|&
{\mathsf{mn\_}}{\mathsf{ab}}~{\mathit{nat}}~{\mathit{nat}}~{\mathit{nat}} \\ &&|&
{{\mathsf{op\_}}{\mathsf{ab}}}{{\mathit{nat}}}~{\mathit{nat}}~{\mathit{nat}} \\ &&|&
{{\mathsf{qr}}_{{\mathit{nat}}}}{\mathsf{ab}}~{\mathit{nat}}~{\mathit{nat}} \\
\end{array}
$$


```


# Preview

```sh
$ (../src/exe-watsup/main.exe ../spec/wasm-3.0/*.watsup --latex)
\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{N}} &::=& {\mathit{nat}} \\
& {\mathit{M}} &::=& {\mathit{nat}} \\
& {\mathit{n}} &::=& {\mathit{nat}} \\
& {\mathit{m}} &::=& {\mathit{nat}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{Ki}} &=& 1024 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{min}}(0, {\mathit{j}}) &=& 0 \\
{\mathrm{min}}({\mathit{i}}, 0) &=& 0 \\
{\mathrm{min}}({\mathit{i}} + 1, {\mathit{j}} + 1) &=& {\mathrm{min}}({\mathit{i}}, {\mathit{j}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{sum}}(\epsilon) &=& 0 \\
{\mathrm{sum}}({\mathit{n}}~{{\mathit{n}'}^\ast}) &=& {\mathit{n}} + {\mathrm{sum}}({{\mathit{n}'}^\ast}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{concat}}(\epsilon) &=& \epsilon \\
{\mathrm{concat}}(({{\mathit{w}}^\ast})~{({{\mathit{w}'}^\ast})^\ast}) &=& {{\mathit{w}}^\ast}~{\mathrm{concat}}({({{\mathit{w}'}^\ast})^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{list}}({\mathit{X}}) &::=& {{\mathit{X}}^\ast}
  &\qquad \mbox{if}~{|{{\mathit{X}}^\ast}|} < {2^{32}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(bit)} & {\mathit{bit}} &::=& 0 ~|~ 1 \\
\mbox{(byte)} & {\mathit{byte}} &::=& \mathtt{0x00} ~|~ \dots ~|~ \mathtt{0xFF} \\
\mbox{(unsigned integer)} & {{\mathit{u}}}{{\mathit{N}}} &::=& 0 ~|~ \dots ~|~ {2^{{\mathit{N}}}} - 1 \\
\mbox{(signed integer)} & {{\mathit{s}}}{{\mathit{N}}} &::=& {-{2^{{\mathit{N}} - 1}}} ~|~ \dots ~|~ {-1} ~|~ 0 ~|~ {+1} ~|~ \dots ~|~ {2^{{\mathit{N}} - 1}} - 1 \\
\mbox{(integer)} & {{\mathit{i}}}{{\mathit{N}}} &::=& {{\mathit{u}}}{{\mathit{N}}} \\
& {\mathit{u{\scriptstyle8}}} &::=& {{\mathit{u}}}{8} \\
& {\mathit{u{\scriptstyle16}}} &::=& {{\mathit{u}}}{16} \\
& {\mathit{u{\scriptstyle31}}} &::=& {{\mathit{u}}}{31} \\
& {\mathit{u{\scriptstyle32}}} &::=& {{\mathit{u}}}{32} \\
& {\mathit{u{\scriptstyle64}}} &::=& {{\mathit{u}}}{64} \\
& {\mathit{u{\scriptstyle128}}} &::=& {{\mathit{u}}}{128} \\
& {\mathit{s{\scriptstyle33}}} &::=& {{\mathit{s}}}{33} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{signif}}(32) &=& 23 \\
{\mathrm{signif}}(64) &=& 52 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{expon}}(32) &=& 8 \\
{\mathrm{expon}}(64) &=& 11 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{M}} &=& {\mathrm{signif}}({\mathit{N}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{E}} &=& {\mathrm{expon}}({\mathit{N}}) \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(floating-point number)} & {{\mathit{f}}}{{\mathit{N}}} &::=& {+{{{\mathit{f}}}{{\mathit{N}}}}{{\mathit{mag}}}} ~|~ {-{{{\mathit{f}}}{{\mathit{N}}}}{{\mathit{mag}}}} \\
\mbox{(floating-point magnitude)} & {{{\mathit{f}}}{{\mathit{N}}}}{{\mathit{mag}}} &::=& (1 + {\mathit{m}} \cdot {2^{{-{\mathit{M}}}}}) \cdot {2^{{\mathit{n}}}}
  &\qquad \mbox{if}~{\mathit{m}} < {2^{{\mathit{M}}}} \land 2 - {2^{{\mathit{E}} - 1}} \leq {\mathit{n}} \leq {2^{{\mathit{E}} - 1}} - 1 \\ &&|&
(0 + {\mathit{m}} \cdot {2^{{-{\mathit{M}}}}}) \cdot {2^{{\mathit{n}}}}
  &\qquad \mbox{if}~{\mathit{m}} < {2^{{\mathit{M}}}} \land 2 - {2^{{\mathit{E}} - 1}} = {\mathit{n}} \\ &&|&
\infty \\ &&|&
{\mathsf{nan}}{{\mathit{m}}}
  &\qquad \mbox{if}~1 \leq {\mathit{m}} < {2^{{\mathit{M}}}} \\
& {\mathit{f{\scriptstyle32}}} &::=& {{\mathit{f}}}{32} \\
& {\mathit{f{\scriptstyle64}}} &::=& {{\mathit{f}}}{64} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{+0} &=& {+((0 + 0 \cdot {2^{{-{\mathit{M}}}}}) \cdot {2^{{\mathit{n}}}})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{+1} &=& {+((1 + 1 \cdot {2^{{-{\mathit{M}}}}}) \cdot {2^{0}})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{canon}}}_{{\mathit{N}}} &=& {2^{{\mathrm{signif}}({\mathit{N}}) - 1}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(vector)} & {{\mathit{v}}}{{\mathit{N}}} &::=& {{\mathit{i}}}{{\mathit{N}}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(character)} & {\mathit{char}} &::=& \mathrm{U{+}00} ~|~ \dots ~|~ \mathrm{U{+}D7FF} ~|~ \mathrm{U{+}E000} ~|~ \dots ~|~ \mathrm{U{+}10FFFF} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(name)} & {\mathit{name}} &::=& {{\mathit{char}}^\ast}
  &\qquad \mbox{if}~{|{\mathrm{utf{\scriptstyle8}}}({{\mathit{char}}^\ast})|} < {2^{32}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(index)} & {\mathit{idx}} &::=& {\mathit{u{\scriptstyle32}}} \\
\mbox{(lane index)} & {\mathit{laneidx}} &::=& {\mathit{u{\scriptstyle8}}} \\
\mbox{(type index)} & {\mathit{typeidx}} &::=& {\mathit{idx}} \\
\mbox{(function index)} & {\mathit{funcidx}} &::=& {\mathit{idx}} \\
\mbox{(global index)} & {\mathit{globalidx}} &::=& {\mathit{idx}} \\
\mbox{(table index)} & {\mathit{tableidx}} &::=& {\mathit{idx}} \\
\mbox{(memory index)} & {\mathit{memidx}} &::=& {\mathit{idx}} \\
\mbox{(elem index)} & {\mathit{elemidx}} &::=& {\mathit{idx}} \\
\mbox{(data index)} & {\mathit{dataidx}} &::=& {\mathit{idx}} \\
\mbox{(label index)} & {\mathit{labelidx}} &::=& {\mathit{idx}} \\
\mbox{(local index)} & {\mathit{localidx}} &::=& {\mathit{idx}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{nul}} &::=& {\mathsf{null}^?} \\
\mbox{(number type)} & {\mathit{numtype}} &::=& \mathsf{i{\scriptstyle32}} ~|~ \mathsf{i{\scriptstyle64}} ~|~ \mathsf{f{\scriptstyle32}} ~|~ \mathsf{f{\scriptstyle64}} \\
\mbox{(vector type)} & {\mathit{vectype}} &::=& \mathsf{v{\scriptstyle128}} \\
\mbox{(literal type)} & {\mathit{consttype}} &::=& {\mathit{numtype}} ~|~ {\mathit{vectype}} \\
& {\mathit{absheaptype}} &::=& \mathsf{any} ~|~ \mathsf{eq} ~|~ \mathsf{i{\scriptstyle31}} ~|~ \mathsf{struct} ~|~ \mathsf{array} ~|~ \mathsf{none} \\ &&|&
\mathsf{func} ~|~ \mathsf{nofunc} \\ &&|&
\mathsf{extern} ~|~ \mathsf{noextern} \\ &&|&
\mathsf{bot} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(defined type)} & {\mathit{deftype}} &::=& {\mathit{rectype}} . {\mathit{nat}} \\
& {\mathit{typeuse}} &::=& {\mathit{deftype}} ~|~ {\mathit{typeidx}} ~|~ \mathsf{rec}~{\mathit{n}} \\
\mbox{(heap type)} & {\mathit{heaptype}} &::=& {\mathit{absheaptype}} ~|~ {\mathit{typeuse}} \\
\mbox{(reference type)} & {\mathit{reftype}} &::=& \mathsf{ref}~{\mathit{nul}}~{\mathit{heaptype}} \\
& {\mathit{valtype}} &::=& {\mathit{numtype}} ~|~ {\mathit{vectype}} ~|~ {\mathit{reftype}} ~|~ \mathsf{bot} \\
& {\mathsf{i}}{{\mathit{n}}} &::=& \mathsf{i{\scriptstyle32}} ~|~ \mathsf{i{\scriptstyle64}} \\
& {\mathsf{f}}{{\mathit{n}}} &::=& \mathsf{f{\scriptstyle32}} ~|~ \mathsf{f{\scriptstyle64}} \\
& {\mathsf{v}}{{\mathit{n}}} &::=& \mathsf{v{\scriptstyle128}} \\
& {\mathit{t}} &::=& {\mathsf{i}}{{\mathit{n}}} ~|~ {\mathsf{f}}{{\mathit{n}}} ~|~ {\mathsf{v}}{{\mathit{n}}} \\
\mbox{(result type)} & {\mathit{resulttype}} &::=& {\mathit{list}}({\mathit{valtype}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(packed type)} & {\mathit{packtype}} &::=& \mathsf{i{\scriptstyle8}} ~|~ \mathsf{i{\scriptstyle16}} \\
\mbox{(lane type)} & {\mathit{lanetype}} &::=& {\mathit{numtype}} ~|~ {\mathit{packtype}} \\
\mbox{(storage type)} & {\mathit{storagetype}} &::=& {\mathit{valtype}} ~|~ {\mathit{packtype}} \\
& {\mathsf{i}}{{\mathit{n}}} &::=& \mathsf{i{\scriptstyle8}} ~|~ \mathsf{i{\scriptstyle16}} \\
& {\mathsf{i}}{{\mathit{n}}} &::=& {\mathsf{i}}{{\mathit{n}}} ~|~ {\mathsf{f}}{{\mathit{n}}} ~|~ {\mathsf{i}}{{\mathit{n}}} \\
& {\mathsf{i}}{{\mathit{n}}} &::=& {\mathsf{i}}{{\mathit{n}}} ~|~ {\mathsf{i}}{{\mathit{n}}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{mut}} &::=& {\mathsf{mut}^?} \\
& {\mathit{fin}} &::=& {\mathsf{final}^?} \\
\mbox{(field type)} & {\mathit{fieldtype}} &::=& {\mathit{mut}}~{\mathit{storagetype}} \\
\mbox{(function type)} & {\mathit{functype}} &::=& {\mathit{resulttype}} \rightarrow {\mathit{resulttype}} \\
\mbox{(structure type)} & {\mathit{structtype}} &::=& {\mathit{list}}({\mathit{fieldtype}}) \\
\mbox{(array type)} & {\mathit{arraytype}} &::=& {\mathit{fieldtype}} \\
\mbox{(composite type)} & {\mathit{comptype}} &::=& \mathsf{struct}~{\mathit{structtype}} \\ &&|&
\mathsf{array}~{\mathit{arraytype}} \\ &&|&
\mathsf{func}~{\mathit{functype}} \\
& {\mathit{subtype}} &::=& \mathsf{sub}~{\mathit{fin}}~{{\mathit{typeuse}}^\ast}~{\mathit{comptype}} \\
\mbox{(recursive type)} & {\mathit{rectype}} &::=& \mathsf{rec}~{\mathit{list}}({\mathit{subtype}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(limits)} & {\mathit{limits}} &::=& {}[{\mathit{u{\scriptstyle32}}} .. {\mathit{u{\scriptstyle32}}}] \\
\mbox{(global type)} & {\mathit{globaltype}} &::=& {\mathit{mut}}~{\mathit{valtype}} \\
\mbox{(table type)} & {\mathit{tabletype}} &::=& {\mathit{limits}}~{\mathit{reftype}} \\
\mbox{(memory type)} & {\mathit{memtype}} &::=& {\mathit{limits}}~\mathsf{i{\scriptstyle8}} \\
\mbox{(element type)} & {\mathit{elemtype}} &::=& {\mathit{reftype}} \\
\mbox{(data type)} & {\mathit{datatype}} &::=& \mathsf{ok} \\
\mbox{(external type)} & {\mathit{externtype}} &::=& \mathsf{func}~{\mathit{typeuse}} ~|~ \mathsf{global}~{\mathit{globaltype}} ~|~ \mathsf{table}~{\mathit{tabletype}} ~|~ \mathsf{mem}~{\mathit{memtype}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{n}} &=& {|{\mathit{nt}}|} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{n}} &=& {|{\mathit{lt}}|} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{num}}}_{{\mathsf{i}}{{\mathit{n}}}} &::=& {{\mathit{i}}}{{\mathit{n}}} \\
& {{\mathit{num}}}_{{\mathsf{f}}{{\mathit{n}}}} &::=& {{\mathit{f}}}{{\mathit{n}}} \\
& {{\mathit{pack}}}_{{\mathsf{i}}{{\mathit{n}}}} &::=& {{\mathit{i}}}{{|{\mathsf{i}}{{\mathit{n}}}|}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{lane}}}_{{\mathit{numtype}}} &::=& {{\mathit{num}}}_{{\mathit{numtype}}} \\
& {{\mathit{lane}}}_{{\mathit{packtype}}} &::=& {{\mathit{pack}}}_{{\mathit{packtype}}} \\
& {{\mathit{lane}}}_{{\mathsf{i}}{{\mathit{n}}}} &::=& {{\mathit{i}}}{{|{\mathsf{i}}{{\mathit{n}}}|}} \\
& {{\mathit{vec}}}_{{\mathsf{v}}{{\mathit{n}}}} &::=& {{\mathit{v}}}{{|{\mathsf{v}}{{\mathit{n}}}|}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{zval}}}_{{\mathit{numtype}}} &::=& {{\mathit{num}}}_{{\mathit{numtype}}} \\
& {{\mathit{zval}}}_{{\mathit{vectype}}} &::=& {{\mathit{vec}}}_{{\mathit{vectype}}} \\
& {{\mathit{zval}}}_{{\mathit{packtype}}} &::=& {{\mathit{pack}}}_{{\mathit{packtype}}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{zero}}({\mathsf{i}}{{\mathit{n}}}) &=& 0 \\
{\mathrm{zero}}({\mathsf{f}}{{\mathit{n}}}) &=& {+0} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(signedness)} & {\mathit{sx}} &::=& \mathsf{u} ~|~ \mathsf{s} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{unop}}}_{{\mathsf{i}}{{\mathit{n}}}} &::=& \mathsf{clz} ~|~ \mathsf{ctz} ~|~ \mathsf{popcnt} ~|~ \mathsf{extend}~{\mathit{n}} \\
& {{\mathit{unop}}}_{{\mathsf{f}}{{\mathit{n}}}} &::=& \mathsf{abs} ~|~ \mathsf{neg} ~|~ \mathsf{sqrt} ~|~ \mathsf{ceil} ~|~ \mathsf{floor} ~|~ \mathsf{trunc} ~|~ \mathsf{nearest} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{binop}}}_{{\mathsf{i}}{{\mathit{n}}}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{mul} ~|~ {\mathsf{div\_}}{{\mathit{sx}}} ~|~ {\mathsf{rem\_}}{{\mathit{sx}}} \\ &&|&
\mathsf{and} ~|~ \mathsf{or} ~|~ \mathsf{xor} ~|~ \mathsf{shl} ~|~ {\mathsf{shr\_}}{{\mathit{sx}}} ~|~ \mathsf{rotl} ~|~ \mathsf{rotr} \\
& {{\mathit{binop}}}_{{\mathsf{f}}{{\mathit{n}}}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{mul} ~|~ \mathsf{div} ~|~ \mathsf{min} ~|~ \mathsf{max} ~|~ \mathsf{copysign} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{testop}}}_{{\mathsf{i}}{{\mathit{n}}}} &::=& \mathsf{eqz} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{relop}}}_{{\mathsf{i}}{{\mathit{n}}}} &::=& \mathsf{eq} ~|~ \mathsf{ne} ~|~ {\mathsf{lt\_}}{{\mathit{sx}}} ~|~ {\mathsf{gt\_}}{{\mathit{sx}}} ~|~ {\mathsf{le\_}}{{\mathit{sx}}} ~|~ {\mathsf{ge\_}}{{\mathit{sx}}} \\
& {{\mathit{relop}}}_{{\mathsf{f}}{{\mathit{n}}}} &::=& \mathsf{eq} ~|~ \mathsf{ne} ~|~ \mathsf{lt} ~|~ \mathsf{gt} ~|~ \mathsf{le} ~|~ \mathsf{ge} \\
& {\mathit{cvtop}} &::=& \mathsf{convert} ~|~ \mathsf{convert\_sat} ~|~ \mathsf{reinterpret} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(dimension)} & {\mathit{dim}} &::=& \mathsf{{\scriptstyle1}} ~|~ \mathsf{{\scriptstyle2}} ~|~ \mathsf{{\scriptstyle4}} ~|~ \mathsf{{\scriptstyle8}} ~|~ \mathsf{{\scriptstyle16}} \\
\mbox{(shape)} & {\mathit{shape}} &::=& {{{\mathit{lanetype}}}{\mathsf{x}}}{{\mathit{dim}}} \\
\mbox{(shape)} & {\mathit{ishape}} &::=& {{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{dim}}} \\
\mbox{(shape)} & {\mathit{fshape}} &::=& {{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{dim}}} \\
\mbox{(shape)} & {\mathit{pshape}} &::=& {{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{dim}}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{vvunop}} &::=& \mathsf{not} \\
& {\mathit{vvbinop}} &::=& \mathsf{and} ~|~ \mathsf{andnot} ~|~ \mathsf{or} ~|~ \mathsf{xor} \\
& {\mathit{vvternop}} &::=& \mathsf{bitselect} \\
& {\mathit{vvtestop}} &::=& \mathsf{any\_true} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{vunop}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}} &::=& \mathsf{abs} ~|~ \mathsf{neg} \\ &&|&
\mathsf{popcnt}
  &\qquad \mbox{if}~{\mathsf{i}}{{\mathit{n}}} = \mathsf{i{\scriptstyle8}} \\
& {{\mathit{vunop}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}} &::=& \mathsf{abs} ~|~ \mathsf{neg} ~|~ \mathsf{sqrt} ~|~ \mathsf{ceil} ~|~ \mathsf{floor} ~|~ \mathsf{trunc} ~|~ \mathsf{nearest} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{vbinop}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}} &::=& \mathsf{add} \\ &&|&
\mathsf{sub} \\ &&|&
{{\mathsf{add\_sat}}{\mathsf{\_}}}{{\mathit{sx}}}
  &\qquad \mbox{if}~{\mathit{n}} \leq \mathsf{{\scriptstyle16}} \\ &&|&
{{\mathsf{sub\_sat}}{\mathsf{\_}}}{{\mathit{sx}}}
  &\qquad \mbox{if}~{\mathit{n}} \leq \mathsf{{\scriptstyle16}} \\ &&|&
\mathsf{mul}
  &\qquad \mbox{if}~{\mathit{n}} \geq \mathsf{{\scriptstyle16}} \\ &&|&
\mathsf{avgr\_u}
  &\qquad \mbox{if}~{\mathit{n}} \leq \mathsf{{\scriptstyle16}} \\ &&|&
\mathsf{q{\scriptstyle15}mulr\_sat\_s}
  &\qquad \mbox{if}~{\mathit{n}} = \mathsf{{\scriptstyle16}} \\ &&|&
{{\mathsf{min}}{\mathsf{\_}}}{{\mathit{sx}}}
  &\qquad \mbox{if}~{\mathit{n}} \leq \mathsf{{\scriptstyle32}} \\ &&|&
{{\mathsf{max}}{\mathsf{\_}}}{{\mathit{sx}}}
  &\qquad \mbox{if}~{\mathit{n}} \leq \mathsf{{\scriptstyle32}} \\
& {{\mathit{vbinop}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{mul} ~|~ \mathsf{div} ~|~ \mathsf{min} ~|~ \mathsf{max} ~|~ \mathsf{pmin} ~|~ \mathsf{pmax} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{vtestop}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}} &::=& \mathsf{all\_true} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{vrelop}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}} &::=& \mathsf{eq} ~|~ \mathsf{ne} \\ &&|&
{\mathsf{lt\_}}{{\mathit{sx}}}
  &\qquad \mbox{if}~{\mathit{n}} \neq \mathsf{{\scriptstyle64}} \lor {\mathit{sx}} = \mathsf{s} \\ &&|&
{\mathsf{gt\_}}{{\mathit{sx}}}
  &\qquad \mbox{if}~{\mathit{n}} \neq \mathsf{{\scriptstyle64}} \lor {\mathit{sx}} = \mathsf{s} \\ &&|&
{\mathsf{le\_}}{{\mathit{sx}}}
  &\qquad \mbox{if}~{\mathit{n}} \neq \mathsf{{\scriptstyle64}} \lor {\mathit{sx}} = \mathsf{s} \\ &&|&
{\mathsf{ge\_}}{{\mathit{sx}}}
  &\qquad \mbox{if}~{\mathit{n}} \neq \mathsf{{\scriptstyle64}} \lor {\mathit{sx}} = \mathsf{s} \\
& {{\mathit{vrelop}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}} &::=& \mathsf{eq} ~|~ \mathsf{ne} ~|~ \mathsf{lt} ~|~ \mathsf{gt} ~|~ \mathsf{le} ~|~ \mathsf{ge} \\
& {\mathit{vcvtop}} &::=& \mathsf{extend} ~|~ \mathsf{trunc\_sat} ~|~ \mathsf{convert} ~|~ \mathsf{demote} ~|~ \mathsf{promote} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{vshiftop}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}} &::=& \mathsf{shl} ~|~ {\mathsf{shr\_}}{{\mathit{sx}}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{vextunop}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}} &::=& \mathsf{extadd\_pairwise}
  &\qquad \mbox{if}~\mathsf{{\scriptstyle16}} \leq {\mathit{n}} \leq \mathsf{{\scriptstyle32}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{vextbinop}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}} &::=& {{\mathsf{extmul}}{\mathsf{\_}}}{{\mathit{half}}} \\ &&|&
\mathsf{dot}
  &\qquad \mbox{if}~{\mathit{n}} = \mathsf{{\scriptstyle32}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(memory operator)} & {\mathit{memop}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{align}~{\mathit{u{\scriptstyle32}}},\; \mathsf{offset}~{\mathit{u{\scriptstyle32}}} \}\end{array} \\
& {\mathit{vloadop}} &::=& {{{{{\mathit{nat}}}{\mathsf{x}}}{\mathsf{x}}}{\mathsf{\_}}}{{\mathit{nat}}} \\ &&|&
{{{\mathit{nat}}}{\mathsf{\_}}}{\mathsf{splat}} \\ &&|&
{{{\mathit{nat}}}{\mathsf{\_}}}{\mathsf{zero}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(block type)} & {\mathit{blocktype}} &::=& {{\mathit{valtype}}^?} \\ &&|&
{\mathit{funcidx}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(instruction)} & {\mathit{instr}} &::=& \mathsf{nop} \\ &&|&
\mathsf{unreachable} \\ &&|&
\mathsf{drop} \\ &&|&
\mathsf{select}~{({{\mathit{valtype}}^\ast})^?} \\ &&|&
\mathsf{block}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast} \\ &&|&
\mathsf{loop}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast} \\ &&|&
\mathsf{if}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast}~\mathsf{else}~{{\mathit{instr}}^\ast} \\ &&|&
\mathsf{br}~{\mathit{labelidx}} \\ &&|&
\mathsf{br\_if}~{\mathit{labelidx}} \\ &&|&
\mathsf{br\_table}~{{\mathit{labelidx}}^\ast}~{\mathit{labelidx}} \\ &&|&
\mathsf{br\_on\_null}~{\mathit{labelidx}} \\ &&|&
\mathsf{br\_on\_non\_null}~{\mathit{labelidx}} \\ &&|&
\mathsf{br\_on\_cast}~{\mathit{labelidx}}~{\mathit{reftype}}~{\mathit{reftype}} \\ &&|&
\mathsf{br\_on\_cast\_fail}~{\mathit{labelidx}}~{\mathit{reftype}}~{\mathit{reftype}} \\ &&|&
\mathsf{call}~{\mathit{funcidx}} \\ &&|&
\mathsf{call\_ref}~{\mathit{typeuse}} \\ &&|&
\mathsf{call\_indirect}~{\mathit{tableidx}}~{\mathit{typeuse}} \\ &&|&
\mathsf{return} \\ &&|&
\mathsf{return\_call}~{\mathit{funcidx}} \\ &&|&
\mathsf{return\_call\_ref}~{\mathit{typeuse}} \\ &&|&
\mathsf{return\_call\_indirect}~{\mathit{tableidx}}~{\mathit{typeuse}} \\ &&|&
{\mathit{numtype}}.\mathsf{const}~{{\mathit{num}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {{\mathit{unop}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {{\mathit{binop}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {{\mathit{testop}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {{\mathit{relop}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}}_{{1}} . {{{{{\mathit{cvtop}}}{\mathsf{\_}}}{{\mathit{numtype}}_{{2}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}
  &\qquad \mbox{if}~{\mathit{numtype}}_{{1}} \neq {\mathit{numtype}}_{{2}} \\ &&|&
{{{{\mathit{numtype}}.\mathsf{extend}}{{\mathit{n}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\dots \\
\mbox{(lane part)} & {\mathit{half}} &::=& \mathsf{low} ~|~ \mathsf{high} \\
& {\mathit{zero}} &::=& \mathsf{zero} \\
\mbox{(instruction)} & {\mathit{instr}} &::=& \dots \\ &&|&
{\mathit{vectype}}.\mathsf{const}~{{\mathit{vec}}}_{{\mathit{vectype}}} \\ &&|&
{\mathit{vectype}} . {\mathit{vvunop}} \\ &&|&
{\mathit{vectype}} . {\mathit{vvbinop}} \\ &&|&
{\mathit{vectype}} . {\mathit{vvternop}} \\ &&|&
{\mathit{vectype}} . {\mathit{vvtestop}} \\ &&|&
{\mathit{shape}} . {{\mathit{vunop}}}_{{\mathit{shape}}} \\ &&|&
{\mathit{shape}} . {{\mathit{vbinop}}}_{{\mathit{shape}}} \\ &&|&
{\mathit{shape}} . {{\mathit{vtestop}}}_{{\mathit{shape}}} \\ &&|&
{\mathit{shape}} . {{\mathit{vrelop}}}_{{\mathit{shape}}} \\ &&|&
{\mathit{ishape}} . {{\mathit{vshiftop}}}_{{\mathit{ishape}}} \\ &&|&
{\mathit{ishape}}.\mathsf{bitmask} \\ &&|&
{\mathit{ishape}}.\mathsf{swizzle}
  &\qquad \mbox{if}~{\mathit{ishape}} = {{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{\mathsf{{\scriptstyle16}}} \\ &&|&
{\mathit{ishape}}.\mathsf{shuffle}~{{\mathit{laneidx}}^\ast}
  &\qquad \mbox{if}~{\mathit{ishape}} = {{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{\mathsf{{\scriptstyle16}}} \land {|{{\mathit{laneidx}}^\ast}|} = 16 \\ &&|&
{\mathit{shape}}.\mathsf{splat} \\ &&|&
{{\mathit{shape}}.\mathsf{extract\_lane\_}}{{{\mathit{sx}}^?}}~{\mathit{laneidx}}
  &\qquad \mbox{if}~{\mathrm{lanetype}}({\mathit{shape}}) = {\mathit{numtype}} \Leftrightarrow {{\mathit{sx}}^?} = \epsilon \\ &&|&
{\mathit{shape}}.\mathsf{replace\_lane}~{\mathit{laneidx}} \\ &&|&
{\mathit{ishape}}_{{1}} . {{{{{{\mathit{vextunop}}}_{{\mathit{ishape}}_{{1}}}}{\mathsf{\_}}}{{\mathit{ishape}}_{{2}}}}{\mathsf{\_}}}{{\mathit{sx}}}
  &\qquad \mbox{if}~{|{\mathrm{lanetype}}({\mathit{ishape}}_{{1}})|} = 2 \cdot {|{\mathrm{lanetype}}({\mathit{ishape}}_{{2}})|} \\ &&|&
{\mathit{ishape}}_{{1}} . {{{{{{\mathit{vextbinop}}}_{{\mathit{ishape}}_{{1}}}}{\mathsf{\_}}}{{\mathit{ishape}}_{{2}}}}{\mathsf{\_}}}{{\mathit{sx}}}
  &\qquad \mbox{if}~{|{\mathrm{lanetype}}({\mathit{ishape}}_{{1}})|} = 2 \cdot {|{\mathrm{lanetype}}({\mathit{ishape}}_{{2}})|} \\ &&|&
{{{{{\mathit{ishape}}_{{1}}.\mathsf{narrow}}{\mathsf{\_}}}{{\mathit{ishape}}_{{2}}}}{\mathsf{\_}}}{{\mathit{sx}}}
  &\qquad \mbox{if}~{|{\mathrm{lanetype}}({\mathit{ishape}}_{{2}})|} = 2 \cdot {|{\mathrm{lanetype}}({\mathit{ishape}}_{{1}})|} \leq 32 \\ &&|&
{\mathit{shape}} . {{{{{{{{{\mathit{vcvtop}}}{\mathsf{\_}}}{{{\mathit{half}}^?}}}{\mathsf{\_}}}{{\mathit{shape}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}}{\mathsf{\_}}}{{{\mathit{zero}}^?}} \\ &&|&
\mathsf{ref.null}~{\mathit{heaptype}} \\ &&|&
\mathsf{ref.is\_null} \\ &&|&
\mathsf{ref.as\_non\_null} \\ &&|&
\mathsf{ref.eq} \\ &&|&
\mathsf{ref.test}~{\mathit{reftype}} \\ &&|&
\mathsf{ref.cast}~{\mathit{reftype}} \\ &&|&
\mathsf{ref.func}~{\mathit{funcidx}} \\ &&|&
\mathsf{ref.i{\scriptstyle31}} \\ &&|&
{{\mathsf{i{\scriptstyle31}.get}}{\mathsf{\_}}}{{\mathit{sx}}} \\ &&|&
\mathsf{struct.new}~{\mathit{typeidx}} \\ &&|&
\mathsf{struct.new\_default}~{\mathit{typeidx}} \\ &&|&
{{\mathsf{struct.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{typeidx}}~{\mathit{u{\scriptstyle32}}} \\ &&|&
\mathsf{struct.set}~{\mathit{typeidx}}~{\mathit{u{\scriptstyle32}}} \\ &&|&
\mathsf{array.new}~{\mathit{typeidx}} \\ &&|&
\mathsf{array.new\_default}~{\mathit{typeidx}} \\ &&|&
\mathsf{array.new\_fixed}~{\mathit{typeidx}}~{\mathit{u{\scriptstyle32}}} \\ &&|&
\mathsf{array.new\_data}~{\mathit{typeidx}}~{\mathit{dataidx}} \\ &&|&
\mathsf{array.new\_elem}~{\mathit{typeidx}}~{\mathit{elemidx}} \\ &&|&
{{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{typeidx}} \\ &&|&
\mathsf{array.set}~{\mathit{typeidx}} \\ &&|&
\mathsf{array.len} \\ &&|&
\mathsf{array.fill}~{\mathit{typeidx}} \\ &&|&
\mathsf{array.copy}~{\mathit{typeidx}}~{\mathit{typeidx}} \\ &&|&
\mathsf{array.init\_data}~{\mathit{typeidx}}~{\mathit{dataidx}} \\ &&|&
\mathsf{array.init\_elem}~{\mathit{typeidx}}~{\mathit{elemidx}} \\ &&|&
\mathsf{extern.convert\_any} \\ &&|&
\mathsf{any.convert\_extern} \\ &&|&
\mathsf{local.get}~{\mathit{localidx}} \\ &&|&
\mathsf{local.set}~{\mathit{localidx}} \\ &&|&
\mathsf{local.tee}~{\mathit{localidx}} \\ &&|&
\mathsf{global.get}~{\mathit{globalidx}} \\ &&|&
\mathsf{global.set}~{\mathit{globalidx}} \\ &&|&
\mathsf{table.get}~{\mathit{tableidx}} \\ &&|&
\mathsf{table.set}~{\mathit{tableidx}} \\ &&|&
\mathsf{table.size}~{\mathit{tableidx}} \\ &&|&
\mathsf{table.grow}~{\mathit{tableidx}} \\ &&|&
\mathsf{table.fill}~{\mathit{tableidx}} \\ &&|&
\mathsf{table.copy}~{\mathit{tableidx}}~{\mathit{tableidx}} \\ &&|&
\mathsf{table.init}~{\mathit{tableidx}}~{\mathit{elemidx}} \\ &&|&
\mathsf{elem.drop}~{\mathit{elemidx}} \\ &&|&
\dots \\
\mbox{(pack size)} & {\mathit{packsize}} &::=& \mathsf{{\scriptstyle8}} ~|~ \mathsf{{\scriptstyle16}} ~|~ \mathsf{{\scriptstyle32}} ~|~ \mathsf{{\scriptstyle64}} \\
& {\mathit{w}} &::=& {\mathit{packsize}} \\
\mbox{(instruction)} & {\mathit{instr}} &::=& \dots \\ &&|&
{{\mathit{numtype}}.\mathsf{load}}{{({{{\mathit{w}}}{\mathsf{\_}}}{{\mathit{sx}}})^?}}~{\mathit{memidx}}~{\mathit{memop}}
  &\qquad \mbox{if}~({\mathit{numtype}} = {\mathsf{i}}{{\mathit{n}}} \land {\mathit{w}} < {|{\mathsf{i}}{{\mathit{n}}}|})^? \\ &&|&
{{\mathit{numtype}}.\mathsf{store}}{{{\mathit{w}}^?}}~{\mathit{memidx}}~{\mathit{memop}}
  &\qquad \mbox{if}~({\mathit{numtype}} = {\mathsf{i}}{{\mathit{n}}} \land {\mathit{w}} < {|{\mathsf{i}}{{\mathit{n}}}|})^? \\ &&|&
{\mathsf{v{\scriptstyle128}.load}}{{{\mathit{vloadop}}^?}}~{\mathit{memidx}}~{\mathit{memop}} \\ &&|&
{{{\mathsf{v{\scriptstyle128}.load}}{{\mathit{w}}}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{memidx}}~{\mathit{memop}}~{\mathit{laneidx}} \\ &&|&
\mathsf{v{\scriptstyle128}.store}~{\mathit{memidx}}~{\mathit{memop}} \\ &&|&
{{{\mathsf{v{\scriptstyle128}.store}}{{\mathit{w}}}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{memidx}}~{\mathit{memop}}~{\mathit{laneidx}} \\ &&|&
\mathsf{memory.size}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.grow}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.fill}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.copy}~{\mathit{memidx}}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.init}~{\mathit{memidx}}~{\mathit{dataidx}} \\ &&|&
\mathsf{data.drop}~{\mathit{dataidx}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(expression)} & {\mathit{expr}} &::=& {{\mathit{instr}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{elemmode}} &::=& \mathsf{active}~{\mathit{tableidx}}~{\mathit{expr}} ~|~ \mathsf{passive} ~|~ \mathsf{declare} \\
& {\mathit{datamode}} &::=& \mathsf{active}~{\mathit{memidx}}~{\mathit{expr}} ~|~ \mathsf{passive} \\
\mbox{(type definition)} & {\mathit{type}} &::=& \mathsf{type}~{\mathit{rectype}} \\
\mbox{(local)} & {\mathit{local}} &::=& \mathsf{local}~{\mathit{valtype}} \\
\mbox{(function)} & {\mathit{func}} &::=& \mathsf{func}~{\mathit{typeidx}}~{{\mathit{local}}^\ast}~{\mathit{expr}} \\
\mbox{(global)} & {\mathit{global}} &::=& \mathsf{global}~{\mathit{globaltype}}~{\mathit{expr}} \\
\mbox{(table)} & {\mathit{table}} &::=& \mathsf{table}~{\mathit{tabletype}}~{\mathit{expr}} \\
\mbox{(memory)} & {\mathit{mem}} &::=& \mathsf{memory}~{\mathit{memtype}} \\
\mbox{(table segment)} & {\mathit{elem}} &::=& \mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}^\ast}~{\mathit{elemmode}} \\
\mbox{(memory segment)} & {\mathit{data}} &::=& \mathsf{data}~{{\mathit{byte}}^\ast}~{\mathit{datamode}} \\
\mbox{(start function)} & {\mathit{start}} &::=& \mathsf{start}~{\mathit{funcidx}} \\
\mbox{(external index)} & {\mathit{externidx}} &::=& \mathsf{func}~{\mathit{funcidx}} ~|~ \mathsf{global}~{\mathit{globalidx}} ~|~ \mathsf{table}~{\mathit{tableidx}} ~|~ \mathsf{mem}~{\mathit{memidx}} \\
\mbox{(export)} & {\mathit{export}} &::=& \mathsf{export}~{\mathit{name}}~{\mathit{externidx}} \\
\mbox{(import)} & {\mathit{import}} &::=& \mathsf{import}~{\mathit{name}}~{\mathit{name}}~{\mathit{externtype}} \\
\mbox{(module)} & {\mathit{module}} &::=& \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{start}}^\ast}~{{\mathit{export}}^\ast} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
\epsilon \setminus {{\mathit{y}}^\ast} &=& \epsilon \\
{\mathit{x}}_{{1}}~{{\mathit{x}}^\ast} \setminus {{\mathit{y}}^\ast} &=& {\mathrm{setminus{\scriptstyle1}}}({\mathit{x}}_{{1}}, {{\mathit{y}}^\ast})~{{\mathit{x}}^\ast} \setminus {{\mathit{y}}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{setminus{\scriptstyle1}}}({\mathit{x}}, \epsilon) &=& {\mathit{x}} \\
{\mathrm{setminus{\scriptstyle1}}}({\mathit{x}}, {\mathit{y}}_{{1}}~{{\mathit{y}}^\ast}) &=& \epsilon
  &\qquad \mbox{if}~{\mathit{x}} = {\mathit{y}}_{{1}} \\
{\mathrm{setminus{\scriptstyle1}}}({\mathit{x}}, {\mathit{y}}_{{1}}~{{\mathit{y}}^\ast}) &=& {\mathrm{setminus{\scriptstyle1}}}({\mathit{x}}, {{\mathit{y}}^\ast})
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{{\mathit{dataidx}}}(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}}) &=& {\mathit{y}} \\
{\mathrm{free}}_{{\mathit{dataidx}}}(\mathsf{data.drop}~{\mathit{x}}) &=& {\mathit{x}} \\
{\mathrm{free}}_{{\mathit{dataidx}}}({\mathit{in}}) &=& \epsilon \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{{\mathit{dataidx}}}(\epsilon) &=& \epsilon \\
{\mathrm{free}}_{{\mathit{dataidx}}}({\mathit{instr}}~{{\mathit{instr}'}^\ast}) &=& {\mathrm{free}}_{{\mathit{dataidx}}}({\mathit{instr}})~{\mathrm{free}}_{{\mathit{dataidx}}}({{\mathit{instr}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{{\mathit{dataidx}}}({{\mathit{in}}^\ast}) &=& {\mathrm{free}}_{{\mathit{dataidx}}}({{\mathit{in}}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{{\mathit{dataidx}}}(\mathsf{func}~{\mathit{x}}~{{\mathit{loc}}^\ast}~{\mathit{e}}) &=& {\mathrm{free}}_{{\mathit{dataidx}}}({\mathit{e}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{{\mathit{dataidx}}}(\epsilon) &=& \epsilon \\
{\mathrm{free}}_{{\mathit{dataidx}}}({\mathit{func}}~{{\mathit{func}'}^\ast}) &=& {\mathrm{free}}_{{\mathit{dataidx}}}({\mathit{func}})~{\mathrm{free}}_{{\mathit{dataidx}}}({{\mathit{func}'}^\ast}) \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{|\mathsf{i{\scriptstyle32}}|} &=& 32 \\
{|\mathsf{i{\scriptstyle64}}|} &=& 64 \\
{|\mathsf{f{\scriptstyle32}}|} &=& 32 \\
{|\mathsf{f{\scriptstyle64}}|} &=& 64 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{|{\mathsf{i}}{{\mathit{n}}}|} &=& {|{\mathsf{i}}{{\mathit{n}}}|} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{|\mathsf{v{\scriptstyle128}}|} &=& 128 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{|\mathsf{i{\scriptstyle8}}|} &=& 8 \\
{|\mathsf{i{\scriptstyle16}}|} &=& 16 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{|{\mathit{numtype}}|} &=& {|{\mathit{numtype}}|} \\
{|{\mathit{packtype}}|} &=& {|{\mathit{packtype}}|} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{|{\mathit{numtype}}|} &=& {|{\mathit{numtype}}|} \\
{|{\mathit{vectype}}|} &=& {|{\mathit{vectype}}|} \\
{|{\mathit{packtype}}|} &=& {|{\mathit{packtype}}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unpack}}({\mathit{numtype}}) &=& {\mathit{numtype}} \\
{\mathrm{unpack}}({\mathit{packtype}}) &=& \mathsf{i{\scriptstyle32}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unpack}}({\mathit{valtype}}) &=& {\mathit{valtype}} \\
{\mathrm{unpack}}({\mathit{packtype}}) &=& \mathsf{i{\scriptstyle32}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unpack}}({\mathit{numtype}}) &=& {\mathit{numtype}} \\
{\mathrm{unpack}}({\mathit{packtype}}) &=& \mathsf{i{\scriptstyle32}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unpack}}({\mathit{vectype}}) &=& {\mathit{vectype}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unpack}}({\mathit{consttype}}) &=& {\mathit{consttype}} \\
{\mathrm{unpack}}({\mathit{packtype}}) &=& \mathsf{i{\scriptstyle32}} \\
{\mathrm{unpack}}({\mathit{lanetype}}) &=& {\mathrm{unpack}}({\mathit{lanetype}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{sx}}({\mathit{consttype}}) &=& \epsilon \\
{\mathrm{sx}}({\mathit{packtype}}) &=& \mathsf{s} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{numtype}}.\mathsf{const}~{\mathit{c}} &=& ({\mathit{numtype}}.\mathsf{const}~{\mathit{c}}) \\
{\mathit{vectype}}.\mathsf{const}~{\mathit{c}} &=& ({\mathit{vectype}}.\mathsf{const}~{\mathit{c}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{lanetype}}({{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}) &=& {\mathsf{i}}{{\mathit{n}}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{dim}}({{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}) &=& {\mathit{N}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{|{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}|} &=& {|{\mathsf{i}}{{\mathit{n}}}|} \cdot {\mathit{N}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unpack}}({{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}) &=& {\mathrm{unpack}}({\mathsf{i}}{{\mathit{n}}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathsf{ref}~{\mathit{nul}}_{{1}}~{\mathit{ht}}_{{1}}) \setminus (\mathsf{ref}~\mathsf{null}~{\mathit{ht}}_{{2}}) &=& (\mathsf{ref}~\epsilon~{\mathit{ht}}_{{1}}) \\
(\mathsf{ref}~{\mathit{nul}}_{{1}}~{\mathit{ht}}_{{1}}) \setminus (\mathsf{ref}~\epsilon~{\mathit{ht}}_{{2}}) &=& (\mathsf{ref}~{\mathit{nul}}_{{1}}~{\mathit{ht}}_{{1}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{typevar}} &::=& {\mathit{typeidx}} ~|~ \mathsf{rec}~{\mathit{nat}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{x}} &=& {\mathit{x}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{xx}}}{{}[\epsilon := \epsilon]} &=& {\mathit{xx}} \\
{{\mathit{xx}}}{{}[{\mathit{xx}}_{{1}}~{{\mathit{xx}'}^\ast} := {\mathit{tu}}_{{1}}~{{\mathit{tu}'}^\ast}]} &=& {\mathit{tu}}_{{1}}
  &\qquad \mbox{if}~{\mathit{xx}} = {\mathit{xx}}_{{1}} \\
{{\mathit{xx}}}{{}[{\mathit{xx}}_{{1}}~{{\mathit{xx}'}^\ast} := {\mathit{tu}}_{{1}}~{{\mathit{tu}'}^\ast}]} &=& {{\mathit{xx}}}{{}[{{\mathit{xx}'}^\ast} := {{\mathit{tu}'}^\ast}]}
  &\qquad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{xx}'}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& {{\mathit{xx}'}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
{{\mathit{dt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& {{\mathit{dt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{nt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& {\mathit{nt}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{vt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& {\mathit{vt}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{xx}'}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& {{\mathit{xx}'}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
{{\mathit{dt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& {{\mathit{dt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
{{\mathit{ht}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& {\mathit{ht}}
  &\qquad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{ref}~{\mathit{nul}}~{\mathit{ht}})}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& \mathsf{ref}~{\mathit{nul}}~{{\mathit{ht}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{nt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& {{\mathit{nt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
{{\mathit{vt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& {{\mathit{vt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
{{\mathit{rt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& {{\mathit{rt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
{\mathsf{bot}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& \mathsf{bot} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{pt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& {\mathit{pt}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{t}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& {{\mathit{t}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
{{\mathit{pt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& {{\mathit{pt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{mut}}~{\mathit{zt}})}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& {\mathit{mut}}~{{\mathit{zt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{struct}~{{\mathit{yt}}^\ast})}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& \mathsf{struct}~{{{\mathit{yt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]}^\ast} \\
{(\mathsf{array}~{\mathit{yt}})}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& \mathsf{array}~{{\mathit{yt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
{(\mathsf{func}~{\mathit{ft}})}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& \mathsf{func}~{{\mathit{ft}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{sub}~{\mathit{fin}}~{{\mathit{tu}'}^\ast}~{\mathit{ct}})}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& \mathsf{sub}~{\mathit{fin}}~{{{\mathit{tu}'}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]}^\ast}~{{\mathit{ct}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{rec}~{{\mathit{st}}^\ast})}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& \mathsf{rec}~{{{\mathit{st}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{qt}} . {\mathit{i}})}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& {{\mathit{qt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} . {\mathit{i}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{mut}}~{\mathit{t}})}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& {\mathit{mut}}~{{\mathit{t}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& {{{\mathit{t}}_{{1}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]}^\ast} \rightarrow {{{\mathit{t}}_{{2}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{lim}}~\mathsf{i{\scriptstyle8}})}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& {\mathit{lim}}~\mathsf{i{\scriptstyle8}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{lim}}~{\mathit{rt}})}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& {\mathit{lim}}~{{\mathit{rt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{func}~{\mathit{dt}})}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& \mathsf{func}~{{\mathit{dt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
{(\mathsf{global}~{\mathit{gt}})}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& \mathsf{global}~{{\mathit{gt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
{(\mathsf{table}~{\mathit{tt}})}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& \mathsf{table}~{{\mathit{tt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
{(\mathsf{mem}~{\mathit{mt}})}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} &=& \mathsf{mem}~{{\mathit{mt}}}{{}[{{\mathit{xx}}^\ast} := {{\mathit{tu}}^\ast}]} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{rt}}}{{}[{ := }\;{{\mathit{tu}}^{{\mathit{n}}}}]} &=& {{\mathit{rt}}}{{}[{{\mathit{i}}^{{\mathit{i}}<{\mathit{n}}}} := {{\mathit{tu}}^{{\mathit{n}}}}]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{dt}}}{{}[{ := }\;{{\mathit{tu}}^{{\mathit{n}}}}]} &=& {{\mathit{dt}}}{{}[{{\mathit{i}}^{{\mathit{i}}<{\mathit{n}}}} := {{\mathit{tu}}^{{\mathit{n}}}}]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\epsilon}{{}[{ := }\;{{\mathit{tu}}^\ast}]} &=& \epsilon \\
{{\mathit{dt}}_{{1}}~{{\mathit{dt}}^\ast}}{{}[{ := }\;{{\mathit{tu}}^\ast}]} &=& {{\mathit{dt}}_{{1}}}{{}[{ := }\;{{\mathit{tu}}^\ast}]}~{{{\mathit{dt}}^\ast}}{{}[{ := }\;{{\mathit{tu}}^\ast}]} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{roll}}}_{{\mathit{x}}}(\mathsf{rec}~{{\mathit{st}}^{{\mathit{n}}}}) &=& \mathsf{rec}~{({{\mathit{st}}}{{}[{({\mathit{x}} + {\mathit{i}})^{{\mathit{i}}<{\mathit{n}}}} := {(\mathsf{rec}~{\mathit{i}})^{{\mathit{i}}<{\mathit{n}}}}]})^{{\mathit{n}}}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unroll}}(\mathsf{rec}~{{\mathit{st}}^{{\mathit{n}}}}) &=& \mathsf{rec}~{({{\mathit{st}}}{{}[{(\mathsf{rec}~{\mathit{i}})^{{\mathit{i}}<{\mathit{n}}}} := {({\mathit{qt}} . {\mathit{i}})^{{\mathit{i}}<{\mathit{n}}}}]})^{{\mathit{n}}}}
  &\qquad \mbox{if}~{\mathit{qt}} = \mathsf{rec}~{{\mathit{st}}^{{\mathit{n}}}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{roll}}}_{{\mathit{x}}}({\mathit{qt}}) &=& {((\mathsf{rec}~{{\mathit{st}}^{{\mathit{n}}}}) . {\mathit{i}})^{{\mathit{i}}<{\mathit{n}}}}
  &\qquad \mbox{if}~{{\mathrm{roll}}}_{{\mathit{x}}}({\mathit{qt}}) = \mathsf{rec}~{{\mathit{st}}^{{\mathit{n}}}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unroll}}({\mathit{qt}} . {\mathit{i}}) &=& {{\mathit{st}}^\ast}{}[{\mathit{i}}]
  &\qquad \mbox{if}~{\mathrm{unroll}}({\mathit{qt}}) = \mathsf{rec}~{{\mathit{st}}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{expand}}({\mathit{dt}}) &=& {\mathit{ct}}
  &\qquad \mbox{if}~{\mathrm{unroll}}({\mathit{dt}}) = \mathsf{sub}~{\mathit{fin}}~{{\mathit{tu}}^\ast}~{\mathit{ct}} \\
\end{array}
$$

$\boxed{{\mathit{deftype}} \approx {\mathit{comptype}}}$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize Expand}]} \quad & {\mathit{dt}} &\approx& {\mathit{ct}}
  &\qquad \mbox{if}~{\mathrm{expand}}({\mathit{dt}}) = {\mathit{ct}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{funcs}}(\epsilon) &=& \epsilon \\
{\mathrm{funcs}}((\mathsf{func}~{\mathit{dt}})~{{\mathit{xt}}^\ast}) &=& {\mathit{dt}}~{\mathrm{funcs}}({{\mathit{xt}}^\ast}) \\
{\mathrm{funcs}}({\mathit{externtype}}~{{\mathit{xt}}^\ast}) &=& {\mathrm{funcs}}({{\mathit{xt}}^\ast})
  &\qquad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{globals}}(\epsilon) &=& \epsilon \\
{\mathrm{globals}}((\mathsf{global}~{\mathit{gt}})~{{\mathit{xt}}^\ast}) &=& {\mathit{gt}}~{\mathrm{globals}}({{\mathit{xt}}^\ast}) \\
{\mathrm{globals}}({\mathit{externtype}}~{{\mathit{xt}}^\ast}) &=& {\mathrm{globals}}({{\mathit{xt}}^\ast})
  &\qquad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{tables}}(\epsilon) &=& \epsilon \\
{\mathrm{tables}}((\mathsf{table}~{\mathit{tt}})~{{\mathit{xt}}^\ast}) &=& {\mathit{tt}}~{\mathrm{tables}}({{\mathit{xt}}^\ast}) \\
{\mathrm{tables}}({\mathit{externtype}}~{{\mathit{xt}}^\ast}) &=& {\mathrm{tables}}({{\mathit{xt}}^\ast})
  &\qquad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{mems}}(\epsilon) &=& \epsilon \\
{\mathrm{mems}}((\mathsf{mem}~{\mathit{mt}})~{{\mathit{xt}}^\ast}) &=& {\mathit{mt}}~{\mathrm{mems}}({{\mathit{xt}}^\ast}) \\
{\mathrm{mems}}({\mathit{externtype}}~{{\mathit{xt}}^\ast}) &=& {\mathrm{mems}}({{\mathit{xt}}^\ast})
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
 &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~0,\; \mathsf{offset}~0 \}\end{array} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{signed}}}_{{\mathit{N}}}({\mathit{i}}) &=& {\mathit{i}}
  &\qquad \mbox{if}~0 \leq {2^{{\mathit{N}} - 1}} \\
{{\mathrm{signed}}}_{{\mathit{N}}}({\mathit{i}}) &=& {\mathit{i}} - {2^{{\mathit{N}}}}
  &\qquad \mbox{if}~{2^{{\mathit{N}} - 1}} \leq {\mathit{i}} < {2^{{\mathit{N}}}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{{\mathrm{signed}}}_{{\mathit{N}}}^{{-1}}}}{({\mathit{i}})} &=& {\mathit{j}}
  &\qquad \mbox{if}~{{\mathrm{signed}}}_{{\mathit{N}}}({\mathit{j}}) = {\mathit{i}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{invibytes}}({\mathit{N}}, {{\mathit{b}}^\ast}) &=& {\mathit{n}}
  &\qquad \mbox{if}~{{\mathrm{bytes}}}_{{\mathsf{i}}{{\mathit{N}}}}({\mathit{n}}) = {{\mathit{b}}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{invfbytes}}({\mathit{N}}, {{\mathit{b}}^\ast}) &=& {\mathit{p}}
  &\qquad \mbox{if}~{{\mathrm{bytes}}}_{{\mathsf{f}}{{\mathit{N}}}}({\mathit{p}}) = {{\mathit{b}}^\ast} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{add}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} &=& {{\mathrm{iadd}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{iN}}_{{1}}, {\mathit{iN}}_{{2}}) \\
{{\mathsf{sub}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} &=& {{\mathrm{isub}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{iN}}_{{1}}, {\mathit{iN}}_{{2}}) \\
{{\mathsf{mul}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} &=& {{\mathrm{imul}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{iN}}_{{1}}, {\mathit{iN}}_{{2}}) \\
{{{\mathsf{div\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} &=& {{{{\mathrm{idiv}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}^{{\mathit{sx}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} \\
{{{\mathsf{rem\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} &=& {{{{\mathrm{irem}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}^{{\mathit{sx}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} \\
{{\mathsf{and}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} &=& {{\mathrm{iand}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{iN}}_{{1}}, {\mathit{iN}}_{{2}}) \\
{{\mathsf{or}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} &=& {{\mathrm{ior}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{iN}}_{{1}}, {\mathit{iN}}_{{2}}) \\
{{\mathsf{xor}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} &=& {{\mathrm{ixor}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{iN}}_{{1}}, {\mathit{iN}}_{{2}}) \\
{{\mathsf{shl}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} &=& {{\mathrm{ishl}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{iN}}_{{1}}, {\mathit{iN}}_{{2}}) \\
{{{\mathsf{shr\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} &=& {{{{\mathrm{ishr}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}^{{\mathit{sx}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} \\
{{\mathsf{rotl}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} &=& {{\mathrm{irotl}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{iN}}_{{1}}, {\mathit{iN}}_{{2}}) \\
{{\mathsf{rotr}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} &=& {{\mathrm{irotr}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{iN}}_{{1}}, {\mathit{iN}}_{{2}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{clz}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}})} &=& {{\mathrm{iclz}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{iN}}) \\
{{\mathsf{ctz}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}})} &=& {{\mathrm{iclz}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{iN}}) \\
{{\mathsf{popcnt}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}})} &=& {{\mathrm{ipopcnt}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{iN}}) \\
{{\mathsf{extend}~{\mathit{N}}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}})} &=& {{{{\mathrm{ext}}}_{{\mathit{N}}, {|{\mathsf{i}}{{\mathit{n}}}|}}^{\mathsf{s}}}}{({{{\mathrm{wrap}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}, {\mathit{N}}}}{({\mathit{iN}})})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{eqz}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}})} &=& {{\mathrm{ieqz}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{iN}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{eq}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} &=& {{\mathrm{ieq}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{iN}}_{{1}}, {\mathit{iN}}_{{2}}) \\
{{\mathsf{ne}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} &=& {{\mathrm{ine}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{iN}}_{{1}}, {\mathit{iN}}_{{2}}) \\
{{{\mathsf{lt\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} &=& {{{{\mathrm{ilt}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}^{{\mathit{sx}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} \\
{{{\mathsf{gt\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} &=& {{{{\mathrm{igt}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}^{{\mathit{sx}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} \\
{{{\mathsf{le\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} &=& {{{{\mathrm{ile}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}^{{\mathit{sx}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} \\
{{{\mathsf{ge\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{{\mathit{n}}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} &=& {{{{\mathrm{ige}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}^{{\mathit{sx}}}}}{({\mathit{iN}}_{{1}},\, {\mathit{iN}}_{{2}})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{add}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}}_{{1}},\, {\mathit{fN}}_{{2}})} &=& {{\mathrm{fadd}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}_{{1}}, {\mathit{fN}}_{{2}}) \\
{{\mathsf{sub}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}}_{{1}},\, {\mathit{fN}}_{{2}})} &=& {{\mathrm{fsub}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}_{{1}}, {\mathit{fN}}_{{2}}) \\
{{\mathsf{mul}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}}_{{1}},\, {\mathit{fN}}_{{2}})} &=& {{\mathrm{fmul}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}_{{1}}, {\mathit{fN}}_{{2}}) \\
{{\mathsf{div}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}}_{{1}},\, {\mathit{fN}}_{{2}})} &=& {{\mathrm{fdiv}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}_{{1}}, {\mathit{fN}}_{{2}}) \\
{{\mathsf{min}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}}_{{1}},\, {\mathit{fN}}_{{2}})} &=& {{\mathrm{fmin}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}_{{1}}, {\mathit{fN}}_{{2}}) \\
{{\mathsf{max}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}}_{{1}},\, {\mathit{fN}}_{{2}})} &=& {{\mathrm{fmax}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}_{{1}}, {\mathit{fN}}_{{2}}) \\
{{\mathsf{copysign}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}}_{{1}},\, {\mathit{fN}}_{{2}})} &=& {{\mathrm{fcopysign}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}_{{1}}, {\mathit{fN}}_{{2}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{abs}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}})} &=& {{\mathrm{fabs}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}) \\
{{\mathsf{neg}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}})} &=& {{\mathrm{fneg}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}) \\
{{\mathsf{sqrt}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}})} &=& {{\mathrm{fsqrt}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}) \\
{{\mathsf{ceil}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}})} &=& {{\mathrm{fceil}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}) \\
{{\mathsf{floor}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}})} &=& {{\mathrm{ffloor}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}) \\
{{\mathsf{trunc}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}})} &=& {{\mathrm{ftrunc}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}) \\
{{\mathsf{nearest}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}})} &=& {{\mathrm{fnearest}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{eq}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}}_{{1}},\, {\mathit{fN}}_{{2}})} &=& {{\mathrm{feq}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}_{{1}}, {\mathit{fN}}_{{2}}) \\
{{\mathsf{ne}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}}_{{1}},\, {\mathit{fN}}_{{2}})} &=& {{\mathrm{fne}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}_{{1}}, {\mathit{fN}}_{{2}}) \\
{{\mathsf{lt}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}}_{{1}},\, {\mathit{fN}}_{{2}})} &=& {{\mathrm{flt}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}_{{1}}, {\mathit{fN}}_{{2}}) \\
{{\mathsf{gt}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}}_{{1}},\, {\mathit{fN}}_{{2}})} &=& {{\mathrm{fgt}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}_{{1}}, {\mathit{fN}}_{{2}}) \\
{{\mathsf{le}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}}_{{1}},\, {\mathit{fN}}_{{2}})} &=& {{\mathrm{fle}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}_{{1}}, {\mathit{fN}}_{{2}}) \\
{{\mathsf{ge}}{{}_{{\mathsf{f}}{{\mathit{n}}}}}}{({\mathit{fN}}_{{1}},\, {\mathit{fN}}_{{2}})} &=& {{\mathrm{fge}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{fN}}_{{1}}, {\mathit{fN}}_{{2}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{convert}}{{{}_{\mathsf{i{\scriptstyle32}}, \mathsf{i{\scriptstyle64}}}^{{\mathit{sx}}}}}}{({\mathit{iN}})} &=& {{{{\mathrm{ext}}}_{32, 64}^{{\mathit{sx}}}}}{({\mathit{iN}})} \\
{{\mathsf{convert}}{{{}_{\mathsf{i{\scriptstyle64}}, \mathsf{i{\scriptstyle32}}}^{{{\mathit{sx}}^?}}}}}{({\mathit{iN}})} &=& {{{\mathrm{wrap}}}_{64, 32}}{({\mathit{iN}})} \\
{{\mathsf{convert}}{{{}_{{\mathsf{f}}{{\mathit{n}}}, {\mathsf{i}}{{\mathit{n}}}}^{{\mathit{sx}}}}}}{({\mathit{fN}})} &=& {{{{\mathrm{trunc}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}, {|{\mathsf{i}}{{\mathit{n}}}|}}^{{\mathit{sx}}}}}{({\mathit{fN}})} \\
{{\mathsf{convert\_sat}}{{{}_{{\mathsf{f}}{{\mathit{n}}}, {\mathsf{i}}{{\mathit{n}}}}^{{\mathit{sx}}}}}}{({\mathit{fN}})} &=& {{{{\mathrm{trunc}}_{{\mathit{sat}}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}, {|{\mathsf{i}}{{\mathit{n}}}|}}^{{\mathit{sx}}}}}{({\mathit{fN}})} \\
{{\mathsf{convert}}{{{}_{\mathsf{f{\scriptstyle32}}, \mathsf{f{\scriptstyle64}}}^{{{\mathit{sx}}^?}}}}}{({\mathit{fN}})} &=& {{{\mathrm{promote}}}_{32, 64}}{({\mathit{fN}})} \\
{{\mathsf{convert}}{{{}_{\mathsf{f{\scriptstyle64}}, \mathsf{f{\scriptstyle32}}}^{{{\mathit{sx}}^?}}}}}{({\mathit{fN}})} &=& {{{\mathrm{demote}}}_{64, 32}}{({\mathit{fN}})} \\
{{\mathsf{convert}}{{{}_{{\mathsf{i}}{{\mathit{n}}}, {\mathsf{f}}{{\mathit{n}}}}^{{\mathit{sx}}}}}}{({\mathit{iN}})} &=& {{{{\mathrm{convert}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}, {|{\mathsf{f}}{{\mathit{n}}}|}}^{{\mathit{sx}}}}}{({\mathit{iN}})} \\
{{\mathsf{reinterpret}}{{{}_{{\mathsf{i}}{{\mathit{n}}}, {\mathsf{f}}{{\mathit{n}}}}^{{{\mathit{sx}}^?}}}}}{({\mathit{iN}})} &=& {{{\mathrm{reinterpret}}}_{{\mathsf{i}}{{\mathit{n}}}, {\mathsf{f}}{{\mathit{n}}}}}{{\mathit{iN}}}
  &\qquad \mbox{if}~{|{\mathsf{i}}{{\mathit{n}}}|} = {|{\mathsf{f}}{{\mathit{n}}}|} \\
{{\mathsf{reinterpret}}{{{}_{{\mathsf{f}}{{\mathit{n}}}, {\mathsf{i}}{{\mathit{n}}}}^{{{\mathit{sx}}^?}}}}}{({\mathit{fN}})} &=& {{{\mathrm{reinterpret}}}_{{\mathsf{f}}{{\mathit{n}}}, {\mathsf{i}}{{\mathit{n}}}}}{{\mathit{fN}}}
  &\qquad \mbox{if}~{|{\mathsf{i}}{{\mathit{n}}}|} = {|{\mathsf{f}}{{\mathit{n}}}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{pack}}}_{{\mathit{numtype}}}({\mathit{c}}) &=& {\mathit{c}} \\
{{\mathrm{pack}}}_{{\mathit{packtype}}}({\mathit{c}}) &=& {{{\mathrm{wrap}}}_{{|{\mathrm{unpack}}({\mathit{packtype}})|}, {|{\mathit{packtype}}|}}}{({\mathit{c}})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{unpack}}}_{{\mathit{numtype}}}({\mathit{c}}) &=& {\mathit{c}} \\
{{\mathrm{unpack}}}_{{\mathit{packtype}}}({\mathit{c}}) &=& {{{{\mathrm{ext}}}_{{|{\mathit{packtype}}|}, {|{\mathrm{unpack}}({\mathit{packtype}})|}}^{\mathsf{u}}}}{({\mathit{c}})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{packconst}}({\mathit{consttype}}, {\mathit{c}}) &=& {\mathit{c}} \\
{\mathrm{packconst}}({\mathit{packtype}}, {\mathit{c}}) &=& {{\mathrm{pack}}}_{{\mathit{packtype}}}({\mathit{c}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unpackconst}}({\mathit{consttype}}, {\mathit{c}}) &=& {\mathit{c}} \\
{\mathrm{unpackconst}}({\mathit{packtype}}, {\mathit{c}}) &=& {{\mathrm{unpack}}}_{{\mathit{packtype}}}({\mathit{c}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{{{\mathrm{lanes}}}_{{\mathit{sh}}}^{{-1}}}}{({{\mathit{c}}^\ast})} &=& {\mathit{vc}}
  &\qquad \mbox{if}~{{\mathit{c}}^\ast} = {{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{vc}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{halfop}}(\mathsf{low}, {\mathit{i}}, {\mathit{j}}) &=& {\mathit{i}} \\
{\mathrm{halfop}}(\mathsf{high}, {\mathit{i}}, {\mathit{j}}) &=& {\mathit{j}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{not}}{\mathsf{\_}}~\mathsf{v{\scriptstyle128}}}{({\mathit{v{\scriptstyle128}}})} &=& {{\mathrm{inot}}}_{{|\mathsf{v{\scriptstyle128}}|}}({\mathit{v{\scriptstyle128}}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{and}}{\mathsf{\_}}~\mathsf{v{\scriptstyle128}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {{\mathrm{iand}}}_{{|\mathsf{v{\scriptstyle128}}|}}({\mathit{v{\scriptstyle128}}}_{{1}}, {\mathit{v{\scriptstyle128}}}_{{2}}) \\
{{\mathsf{andnot}}{\mathsf{\_}}~\mathsf{v{\scriptstyle128}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {{\mathrm{inot}}}_{{|\mathsf{v{\scriptstyle128}}|}}({\mathit{v{\scriptstyle128}}}_{{1}}, {\mathit{v{\scriptstyle128}}}_{{2}}) \\
{{\mathsf{or}}{\mathsf{\_}}~\mathsf{v{\scriptstyle128}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {{\mathrm{ior}}}_{{|\mathsf{v{\scriptstyle128}}|}}({\mathit{v{\scriptstyle128}}}_{{1}}, {\mathit{v{\scriptstyle128}}}_{{2}}) \\
{{\mathsf{xor}}{\mathsf{\_}}~\mathsf{v{\scriptstyle128}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {{\mathrm{ixor}}}_{{|\mathsf{v{\scriptstyle128}}|}}({\mathit{v{\scriptstyle128}}}_{{1}}, {\mathit{v{\scriptstyle128}}}_{{2}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{bitselect}}{\mathsf{\_}}~\mathsf{v{\scriptstyle128}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}},\, {\mathit{v{\scriptstyle128}}}_{{3}})} &=& {{\mathrm{ibitselect}}}_{{|\mathsf{v{\scriptstyle128}}|}}({\mathit{v{\scriptstyle128}}}_{{1}}, {\mathit{v{\scriptstyle128}}}_{{2}}, {\mathit{v{\scriptstyle128}}}_{{3}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{abs}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{iabs}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}})^\ast})} \\
{{\mathsf{neg}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{ineg}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}})^\ast})} \\
{{\mathsf{popcnt}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{ipopcnt}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}})^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{add}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{iadd}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}})^\ast})} \\
{{\mathsf{sub}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{isub}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}})^\ast})} \\
{{{{\mathsf{min}}{\mathsf{\_}}}{{\mathit{sx}}}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{\mathrm{imin}}({|{\mathsf{i}}{{\mathit{n}}}|}, {\mathit{sx}}, {\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}})^\ast})} \\
{{{{\mathsf{max}}{\mathsf{\_}}}{{\mathit{sx}}}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{\mathrm{imax}}({|{\mathsf{i}}{{\mathit{n}}}|}, {\mathit{sx}}, {\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}})^\ast})} \\
{{{{\mathsf{add\_sat}}{\mathsf{\_}}}{{\mathit{sx}}}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{{{\mathrm{iaddsat}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}^{{\mathit{sx}}}}}{({\mathit{lane}}_{{1}},\, {\mathit{lane}}_{{2}})}^\ast})} \\
{{{{\mathsf{sub\_sat}}{\mathsf{\_}}}{{\mathit{sx}}}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{{{\mathrm{isubsat}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}^{{\mathit{sx}}}}}{({\mathit{lane}}_{{1}},\, {\mathit{lane}}_{{2}})}^\ast})} \\
{{\mathsf{mul}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{imul}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}})^\ast})} \\
{{\mathsf{avgr\_u}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{iavgr}}_{{\mathit{u}}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}})^\ast})} \\
{{\mathsf{q{\scriptstyle15}mulr\_sat\_s}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{iq{\scriptstyle15}mulrsat}}_{{\mathit{s}}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}})^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{eq}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{3}}^\ast} = {{{{{\mathrm{ext}}}_{1, {|{\mathsf{i}}{{\mathit{n}}}|}}^{\mathsf{s}}}}{({{\mathrm{ieq}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}}))}^\ast} \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{\mathit{lane}}_{{3}}^\ast})} \\
{{\mathsf{ne}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{3}}^\ast} = {{{{{\mathrm{ext}}}_{1, {|{\mathsf{i}}{{\mathit{n}}}|}}^{\mathsf{s}}}}{({{\mathrm{ine}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}}))}^\ast} \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{\mathit{lane}}_{{3}}^\ast})} \\
{{{\mathsf{lt\_}}{{\mathit{sx}}}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{3}}^\ast} = {{{{{\mathrm{ext}}}_{1, {|{\mathsf{i}}{{\mathit{n}}}|}}^{\mathsf{s}}}}{({{{{\mathrm{ilt}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}^{{\mathit{sx}}}}}{({\mathit{lane}}_{{1}},\, {\mathit{lane}}_{{2}})})}^\ast} \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{\mathit{lane}}_{{3}}^\ast})} \\
{{{\mathsf{gt\_}}{{\mathit{sx}}}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{3}}^\ast} = {{{{{\mathrm{ext}}}_{1, {|{\mathsf{i}}{{\mathit{n}}}|}}^{\mathsf{s}}}}{({{{{\mathrm{igt}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}^{{\mathit{sx}}}}}{({\mathit{lane}}_{{1}},\, {\mathit{lane}}_{{2}})})}^\ast} \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{\mathit{lane}}_{{3}}^\ast})} \\
{{{\mathsf{le\_}}{{\mathit{sx}}}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{3}}^\ast} = {{{{{\mathrm{ext}}}_{1, {|{\mathsf{i}}{{\mathit{n}}}|}}^{\mathsf{s}}}}{({{{{\mathrm{ile}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}^{{\mathit{sx}}}}}{({\mathit{lane}}_{{1}},\, {\mathit{lane}}_{{2}})})}^\ast} \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{\mathit{lane}}_{{3}}^\ast})} \\
{{{\mathsf{ge\_}}{{\mathit{sx}}}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{3}}^\ast} = {{{{{\mathrm{ext}}}_{1, {|{\mathsf{i}}{{\mathit{n}}}|}}^{\mathsf{s}}}}{({{{{\mathrm{ige}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}^{{\mathit{sx}}}}}{({\mathit{lane}}_{{1}},\, {\mathit{lane}}_{{2}})})}^\ast} \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{\mathit{lane}}_{{3}}^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{abs}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{fabs}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}})^\ast})} \\
{{\mathsf{neg}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{fneg}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}})^\ast})} \\
{{\mathsf{sqrt}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{fsqrt}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}})^\ast})} \\
{{\mathsf{ceil}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{fceil}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}})^\ast})} \\
{{\mathsf{floor}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{ffloor}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}})^\ast})} \\
{{\mathsf{trunc}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{ftrunc}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}})^\ast})} \\
{{\mathsf{nearest}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{fnearest}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}})^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{add}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{fadd}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}})^\ast})} \\
{{\mathsf{sub}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{fsub}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}})^\ast})} \\
{{\mathsf{mul}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{fmul}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}})^\ast})} \\
{{\mathsf{div}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{fdiv}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}})^\ast})} \\
{{\mathsf{min}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{fmin}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}})^\ast})} \\
{{\mathsf{max}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{fmax}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}})^\ast})} \\
{{\mathsf{pmin}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{fpmin}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}})^\ast})} \\
{{\mathsf{pmax}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{fpmax}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}})^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{eq}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{3}}^\ast} = {{{{{\mathrm{ext}}}_{1, {|{\mathsf{f}}{{\mathit{n}}}|}}^{\mathsf{s}}}}{({{\mathrm{feq}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}}))}^\ast} \\
  &&&\qquad {\land}~{|{\mathsf{i}}{{\mathit{n}}}|} = {|{\mathsf{f}}{{\mathit{n}}}|} \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{\mathit{lane}}_{{3}}^\ast})} \\
{{\mathsf{ne}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{3}}^\ast} = {{{{{\mathrm{ext}}}_{1, {|{\mathsf{f}}{{\mathit{n}}}|}}^{\mathsf{s}}}}{({{\mathrm{fne}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}}))}^\ast} \\
  &&&\qquad {\land}~{|{\mathsf{i}}{{\mathit{n}}}|} = {|{\mathsf{f}}{{\mathit{n}}}|} \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{\mathit{lane}}_{{3}}^\ast})} \\
{{\mathsf{lt}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{3}}^\ast} = {{{{{\mathrm{ext}}}_{1, {|{\mathsf{f}}{{\mathit{n}}}|}}^{\mathsf{s}}}}{({{\mathrm{flt}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}}))}^\ast} \\
  &&&\qquad {\land}~{|{\mathsf{i}}{{\mathit{n}}}|} = {|{\mathsf{f}}{{\mathit{n}}}|} \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{\mathit{lane}}_{{3}}^\ast})} \\
{{\mathsf{gt}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{3}}^\ast} = {{{{{\mathrm{ext}}}_{1, {|{\mathsf{f}}{{\mathit{n}}}|}}^{\mathsf{s}}}}{({{\mathrm{fgt}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}}))}^\ast} \\
  &&&\qquad {\land}~{|{\mathsf{i}}{{\mathit{n}}}|} = {|{\mathsf{f}}{{\mathit{n}}}|} \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{\mathit{lane}}_{{3}}^\ast})} \\
{{\mathsf{le}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{3}}^\ast} = {{{{{\mathrm{ext}}}_{1, {|{\mathsf{f}}{{\mathit{n}}}|}}^{\mathsf{s}}}}{({{\mathrm{fle}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}}))}^\ast} \\
  &&&\qquad {\land}~{|{\mathsf{i}}{{\mathit{n}}}|} = {|{\mathsf{f}}{{\mathit{n}}}|} \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{\mathit{lane}}_{{3}}^\ast})} \\
{{\mathsf{ge}}{\mathsf{\_}}~{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{v{\scriptstyle128}}}_{{1}},\, {\mathit{v{\scriptstyle128}}}_{{2}})} &=& {\mathit{v{\scriptstyle128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{f}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{v{\scriptstyle128}}}_{{2}}) \\
  &&&\qquad {\land}~{{\mathit{lane}}_{{3}}^\ast} = {{{{{\mathrm{ext}}}_{1, {|{\mathsf{f}}{{\mathit{n}}}|}}^{\mathsf{s}}}}{({{\mathrm{fge}}}_{{|{\mathsf{f}}{{\mathit{n}}}|}}({\mathit{lane}}_{{1}}, {\mathit{lane}}_{{2}}))}^\ast} \\
  &&&\qquad {\land}~{|{\mathsf{i}}{{\mathit{n}}}|} = {|{\mathsf{f}}{{\mathit{n}}}|} \\
  &&&\qquad {\land}~{\mathit{v{\scriptstyle128}}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{\mathit{lane}}_{{3}}^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{vcvtop}}({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}, {{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}, \mathsf{extend}, {\mathit{sx}}, {\mathit{i{\scriptstyle8}}}) &=& {\mathit{i{\scriptstyle16}}}
  &\qquad \mbox{if}~{\mathit{i{\scriptstyle16}}} = {{{{\mathrm{ext}}}_{8, 16}^{{\mathit{sx}}}}}{({\mathit{i{\scriptstyle8}}})} \\
{\mathrm{vcvtop}}({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}, {{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}, \mathsf{extend}, {\mathit{sx}}, {\mathit{i{\scriptstyle16}}}) &=& {\mathit{i{\scriptstyle32}}}
  &\qquad \mbox{if}~{\mathit{i{\scriptstyle32}}} = {{{{\mathrm{ext}}}_{16, 32}^{{\mathit{sx}}}}}{({\mathit{i{\scriptstyle16}}})} \\
{\mathrm{vcvtop}}({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}, {{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}, \mathsf{extend}, {\mathit{sx}}, {\mathit{i{\scriptstyle32}}}) &=& {\mathit{i{\scriptstyle64}}}
  &\qquad \mbox{if}~{\mathit{i{\scriptstyle64}}} = {{{{\mathrm{ext}}}_{32, 64}^{{\mathit{sx}}}}}{({\mathit{i{\scriptstyle32}}})} \\
{\mathrm{vcvtop}}({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}, {{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}, \mathsf{trunc\_sat}, {\mathit{sx}}, {\mathit{f{\scriptstyle32}}}) &=& {\mathit{i{\scriptstyle32}}}
  &\qquad \mbox{if}~{\mathit{i{\scriptstyle32}}} = {{{{\mathrm{trunc}}_{{\mathit{sat}}}}_{32, 32}^{{\mathit{sx}}}}}{({\mathit{f{\scriptstyle32}}})} \\
{\mathrm{vcvtop}}({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}, {{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}, \mathsf{trunc\_sat}, {\mathit{sx}}, {\mathit{f{\scriptstyle64}}}) &=& {\mathit{i{\scriptstyle32}}}
  &\qquad \mbox{if}~{\mathit{i{\scriptstyle32}}} = {{{{\mathrm{trunc}}_{{\mathit{sat}}}}_{64, 32}^{{\mathit{sx}}}}}{({\mathit{f{\scriptstyle64}}})} \\
{\mathrm{vcvtop}}({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}, {{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}, \mathsf{convert}, {\mathit{sx}}, {\mathit{i{\scriptstyle32}}}) &=& {\mathit{f{\scriptstyle32}}}
  &\qquad \mbox{if}~{\mathit{f{\scriptstyle32}}} = {{{{\mathrm{convert}}}_{32, 32}^{{\mathit{sx}}}}}{({\mathit{i{\scriptstyle32}}})} \\
{\mathrm{vcvtop}}({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}, {{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}, \mathsf{convert}, {\mathit{sx}}, {\mathit{i{\scriptstyle32}}}) &=& {\mathit{f{\scriptstyle64}}}
  &\qquad \mbox{if}~{\mathit{f{\scriptstyle64}}} = {{{{\mathrm{convert}}}_{32, 64}^{{\mathit{sx}}}}}{({\mathit{i{\scriptstyle32}}})} \\
{\mathrm{vcvtop}}({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}, {{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}, \mathsf{demote}, {{\mathit{sx}}^?}, {\mathit{f{\scriptstyle64}}}) &=& {\mathit{f{\scriptstyle32}}}
  &\qquad \mbox{if}~{\mathit{f{\scriptstyle32}}} = {{{\mathrm{demote}}}_{64, 32}}{({\mathit{f{\scriptstyle64}}})} \\
{\mathrm{vcvtop}}({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}, {{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}, \mathsf{promote}, {{\mathit{sx}}^?}, {\mathit{f{\scriptstyle32}}}) &=& {\mathit{f{\scriptstyle64}}}
  &\qquad \mbox{if}~{\mathit{f{\scriptstyle64}}} = {{{\mathrm{promote}}}_{32, 64}}{({\mathit{f{\scriptstyle32}}})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{vextunop}}({{{{\mathsf{i}}{{\mathit{n}}}}_{{1}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}, {{{{\mathsf{i}}{{\mathit{n}}}}_{{2}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}, \mathsf{extadd\_pairwise}, {\mathit{sx}}, {\mathit{c}}_{{1}}) &=& {\mathit{c}}
  &\qquad \mbox{if}~{{\mathit{ci}}^\ast} = {{\mathrm{lanes}}}_{{{{{\mathsf{i}}{{\mathit{n}}}}_{{2}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}}({\mathit{c}}_{{1}}) \\
  &&&\qquad {\land}~{\mathrm{concat}}({({\mathit{cj}}_{{1}}~{\mathit{cj}}_{{2}})^\ast}) = {{{{{\mathrm{ext}}}_{{|{{\mathsf{i}}{{\mathit{n}}}}_{{2}}|}, {|{{\mathsf{i}}{{\mathit{n}}}}_{{1}}|}}^{{\mathit{sx}}}}}{({\mathit{ci}})}^\ast} \\
  &&&\qquad {\land}~{\mathit{c}} = {{{{\mathrm{lanes}}}_{{{{{\mathsf{i}}{{\mathit{n}}}}_{{1}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}}^{{-1}}}}{({{{\mathrm{iadd}}}_{{|{{\mathsf{i}}{{\mathit{n}}}}_{{1}}|}}({\mathit{cj}}_{{1}}, {\mathit{cj}}_{{2}})^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{vextbinop}}({{{{\mathsf{i}}{{\mathit{n}}}}_{{1}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}, {{{{\mathsf{i}}{{\mathit{n}}}}_{{2}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}, {{\mathsf{extmul}}{\mathsf{\_}}}{{\mathit{hf}}}, {\mathit{sx}}, {\mathit{c}}_{{1}}, {\mathit{c}}_{{2}}) &=& {\mathit{c}}
  &\qquad \mbox{if}~{{\mathit{ci}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{{\mathsf{i}}{{\mathit{n}}}}_{{2}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}}({\mathit{c}}_{{1}}){}[{\mathrm{halfop}}({\mathit{hf}}, 0, {\mathit{N}}_{{1}}) : {\mathit{N}}_{{1}}] \\
  &&&\qquad {\land}~{{\mathit{ci}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{{\mathsf{i}}{{\mathit{n}}}}_{{2}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}}({\mathit{c}}_{{2}}){}[{\mathrm{halfop}}({\mathit{hf}}, 0, {\mathit{N}}_{{1}}) : {\mathit{N}}_{{1}}] \\
  &&&\qquad {\land}~{\mathit{c}} = {{{{\mathrm{lanes}}}_{{{{{\mathsf{i}}{{\mathit{n}}}}_{{1}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}}^{{-1}}}}{({{{\mathrm{imul}}}_{{|{{\mathsf{i}}{{\mathit{n}}}}_{{1}}|}}({{{{\mathrm{ext}}}_{{|{{\mathsf{i}}{{\mathit{n}}}}_{{2}}|}, {|{{\mathsf{i}}{{\mathit{n}}}}_{{1}}|}}^{{\mathit{sx}}}}}{({\mathit{ci}}_{{1}})}, {{{{\mathrm{ext}}}_{{|{{\mathsf{i}}{{\mathit{n}}}}_{{2}}|}, {|{{\mathsf{i}}{{\mathit{n}}}}_{{1}}|}}^{{\mathit{sx}}}}}{({\mathit{ci}}_{{2}})})^\ast})} \\
{\mathrm{vextbinop}}({{{{\mathsf{i}}{{\mathit{n}}}}_{{1}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}, {{{{\mathsf{i}}{{\mathit{n}}}}_{{2}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}, \mathsf{dot}, {\mathit{sx}}, {\mathit{c}}_{{1}}, {\mathit{c}}_{{2}}) &=& {\mathit{c}}
  &\qquad \mbox{if}~{{\mathit{ci}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{{\mathsf{i}}{{\mathit{n}}}}_{{2}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}}({\mathit{c}}_{{1}}) \\
  &&&\qquad {\land}~{{\mathit{ci}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{{\mathsf{i}}{{\mathit{n}}}}_{{2}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}}({\mathit{c}}_{{2}}) \\
  &&&\qquad {\land}~{\mathrm{concat}}({({\mathit{cj}}_{{1}}~{\mathit{cj}}_{{2}})^\ast}) = {{{\mathrm{imul}}}_{{|{{\mathsf{i}}{{\mathit{n}}}}_{{1}}|}}({{{{\mathrm{ext}}}_{{|{{\mathsf{i}}{{\mathit{n}}}}_{{2}}|}, {|{{\mathsf{i}}{{\mathit{n}}}}_{{1}}|}}^{\mathsf{s}}}}{({\mathit{ci}}_{{1}})}, {{{{\mathrm{ext}}}_{{|{{\mathsf{i}}{{\mathit{n}}}}_{{2}}|}, {|{{\mathsf{i}}{{\mathit{n}}}}_{{1}}|}}^{\mathsf{s}}}}{({\mathit{ci}}_{{2}})})^\ast} \\
  &&&\qquad {\land}~{\mathit{c}} = {{{{\mathrm{lanes}}}_{{{{{\mathsf{i}}{{\mathit{n}}}}_{{1}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}}^{{-1}}}}{({{{\mathrm{iadd}}}_{{|{{\mathsf{i}}{{\mathit{n}}}}_{{1}}|}}({\mathit{cj}}_{{1}}, {\mathit{cj}}_{{2}})^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{shl}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{lane}},\, {\mathit{n}})} &=& {{\mathrm{ishl}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}({\mathit{lane}}, {\mathit{n}}) \\
{{{\mathsf{shr\_}}{{\mathit{sx}}}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{lane}},\, {\mathit{n}})} &=& {{{{\mathrm{ishr}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}^{{\mathit{sx}}}}}{({\mathit{lane}},\, {\mathit{n}})} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(address)} & {\mathit{addr}} &::=& {\mathit{nat}} \\
\mbox{(function address)} & {\mathit{funcaddr}} &::=& {\mathit{addr}} \\
\mbox{(global address)} & {\mathit{globaladdr}} &::=& {\mathit{addr}} \\
\mbox{(table address)} & {\mathit{tableaddr}} &::=& {\mathit{addr}} \\
\mbox{(memory address)} & {\mathit{memaddr}} &::=& {\mathit{addr}} \\
\mbox{(elem address)} & {\mathit{elemaddr}} &::=& {\mathit{addr}} \\
\mbox{(data address)} & {\mathit{dataaddr}} &::=& {\mathit{addr}} \\
\mbox{(host address)} & {\mathit{hostaddr}} &::=& {\mathit{addr}} \\
\mbox{(structure address)} & {\mathit{structaddr}} &::=& {\mathit{addr}} \\
\mbox{(array address)} & {\mathit{arrayaddr}} &::=& {\mathit{addr}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(number)} & {\mathit{num}} &::=& {\mathit{numtype}}.\mathsf{const}~{{\mathit{num}}}_{{\mathit{numtype}}} \\
\mbox{(vector)} & {\mathit{vec}} &::=& {\mathit{vectype}}.\mathsf{const}~{{\mathit{vec}}}_{{\mathit{vectype}}} \\
\mbox{(address reference)} & {\mathit{addrref}} &::=& \mathsf{ref.i{\scriptstyle31}}~{\mathit{u{\scriptstyle31}}} \\ &&|&
\mathsf{ref.struct}~{\mathit{structaddr}} \\ &&|&
\mathsf{ref.array}~{\mathit{arrayaddr}} \\ &&|&
\mathsf{ref.func}~{\mathit{funcaddr}} \\ &&|&
\mathsf{ref.host}~{\mathit{hostaddr}} \\ &&|&
\mathsf{ref.extern}~{\mathit{addrref}} \\
\mbox{(reference)} & {\mathit{ref}} &::=& {\mathit{addrref}} \\ &&|&
\mathsf{ref.null}~{\mathit{heaptype}} \\
\mbox{(value)} & {\mathit{val}} &::=& {\mathit{num}} ~|~ {\mathit{vec}} ~|~ {\mathit{ref}} \\
\mbox{(result)} & {\mathit{result}} &::=& {{\mathit{val}}^\ast} ~|~ \mathsf{trap} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(external value)} & {\mathit{externval}} &::=& \mathsf{func}~{\mathit{funcaddr}} ~|~ \mathsf{global}~{\mathit{globaladdr}} ~|~ \mathsf{table}~{\mathit{tableaddr}} ~|~ \mathsf{mem}~{\mathit{memaddr}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(function instance)} & {\mathit{funcinst}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{deftype}},\; \\
  \mathsf{module}~{\mathit{moduleinst}},\; \\
  \mathsf{code}~{\mathit{func}} \}\end{array} \\
\mbox{(global instance)} & {\mathit{globalinst}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{globaltype}},\; \\
  \mathsf{value}~{\mathit{val}} \}\end{array} \\
\mbox{(table instance)} & {\mathit{tableinst}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{tabletype}},\; \\
  \mathsf{refs}~{{\mathit{ref}}^\ast} \}\end{array} \\
\mbox{(memory instance)} & {\mathit{meminst}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{memtype}},\; \\
  \mathsf{bytes}~{{\mathit{byte}}^\ast} \}\end{array} \\
\mbox{(element instance)} & {\mathit{eleminst}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{elemtype}},\; \\
  \mathsf{refs}~{{\mathit{ref}}^\ast} \}\end{array} \\
\mbox{(data instance)} & {\mathit{datainst}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{bytes}~{{\mathit{byte}}^\ast} \}\end{array} \\
\mbox{(export instance)} & {\mathit{exportinst}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \\
  \mathsf{value}~{\mathit{externval}} \}\end{array} \\
\mbox{(packed value)} & {\mathit{packval}} &::=& {\mathit{packtype}}.\mathsf{pack}~{{\mathit{pack}}}_{{\mathit{packtype}}} \\
\mbox{(field value)} & {\mathit{fieldval}} &::=& {\mathit{val}} ~|~ {\mathit{packval}} \\
\mbox{(structure instance)} & {\mathit{structinst}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{deftype}},\; \\
  \mathsf{fields}~{{\mathit{fieldval}}^\ast} \}\end{array} \\
\mbox{(array instance)} & {\mathit{arrayinst}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{deftype}},\; \\
  \mathsf{fields}~{{\mathit{fieldval}}^\ast} \}\end{array} \\
\mbox{(module instance)} & {\mathit{moduleinst}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{types}~{{\mathit{deftype}}^\ast},\; \\
  \mathsf{funcs}~{{\mathit{funcaddr}}^\ast},\; \\
  \mathsf{globals}~{{\mathit{globaladdr}}^\ast},\; \\
  \mathsf{tables}~{{\mathit{tableaddr}}^\ast},\; \\
  \mathsf{mems}~{{\mathit{memaddr}}^\ast},\; \\
  \mathsf{elems}~{{\mathit{elemaddr}}^\ast},\; \\
  \mathsf{datas}~{{\mathit{dataaddr}}^\ast},\; \\
  \mathsf{exports}~{{\mathit{exportinst}}^\ast} \}\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(store)} & {\mathit{store}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{funcs}~{{\mathit{funcinst}}^\ast},\; \\
  \mathsf{globals}~{{\mathit{globalinst}}^\ast},\; \\
  \mathsf{tables}~{{\mathit{tableinst}}^\ast},\; \\
  \mathsf{mems}~{{\mathit{meminst}}^\ast},\; \\
  \mathsf{elems}~{{\mathit{eleminst}}^\ast},\; \\
  \mathsf{datas}~{{\mathit{datainst}}^\ast},\; \\
  \mathsf{structs}~{{\mathit{structinst}}^\ast},\; \\
  \mathsf{arrays}~{{\mathit{arrayinst}}^\ast} \}\end{array} \\
\mbox{(frame)} & {\mathit{frame}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{locals}~{({{\mathit{val}}^?})^\ast},\; \\
  \mathsf{module}~{\mathit{moduleinst}} \}\end{array} \\
\mbox{(state)} & {\mathit{state}} &::=& {\mathit{store}} ; {\mathit{frame}} \\
\mbox{(configuration)} & {\mathit{config}} &::=& {\mathit{state}} ; {{\mathit{instr}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(administrative instruction)} & {\mathit{instr}} &::=& {\mathit{instr}} \\ &&|&
{\mathit{addrref}} \\ &&|&
{{\mathsf{label}}_{{\mathit{n}}}}{\{{{\mathit{instr}}^\ast}\}}~{{\mathit{instr}}^\ast} \\ &&|&
{{\mathsf{frame}}_{{\mathit{n}}}}{\{{\mathit{frame}}\}}~{{\mathit{instr}}^\ast} \\ &&|&
\mathsf{trap} \\
\mbox{(evaluation context)} & {\mathit{E}} &::=& {}[\mathsf{\_}] \\ &&|&
{{\mathit{val}}^\ast}~{\mathit{E}}~{{\mathit{instr}}^\ast} \\ &&|&
{{\mathsf{label}}_{{\mathit{n}}}}{\{{{\mathit{instr}}^\ast}\}}~{\mathit{E}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{inst}}}_{{\mathit{mm}}}({\mathit{rt}}) &=& {{\mathit{rt}}}{{}[{ := }\;{{\mathit{dt}}^\ast}]}
  &\qquad \mbox{if}~{{\mathit{dt}}^\ast} = {\mathit{mm}}.\mathsf{types} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

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

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{pack}}}_{{\mathit{t}}}({\mathit{val}}) &=& {\mathit{val}} \\
{{\mathrm{pack}}}_{{\mathit{pt}}}(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}) &=& {\mathit{pt}}.\mathsf{pack}~{{{\mathrm{wrap}}}_{32, {|{\mathit{pt}}|}}}{({\mathit{i}})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{{\mathrm{unpack}}}_{{\mathit{t}}}^{\epsilon}}}{({\mathit{val}})} &=& {\mathit{val}} \\
{{{{\mathrm{unpack}}}_{{\mathit{pt}}}^{{\mathit{sx}}}}}{({\mathit{pt}}.\mathsf{pack}~{\mathit{i}})} &=& \mathsf{i{\scriptstyle32}}.\mathsf{const}~{{{{\mathrm{ext}}}_{{|{\mathit{pt}}|}, 32}^{{\mathit{sx}}}}}{({\mathit{i}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{funcs}}(\epsilon) &=& \epsilon \\
{\mathrm{funcs}}((\mathsf{func}~{\mathit{fa}})~{{\mathit{xv}}^\ast}) &=& {\mathit{fa}}~{\mathrm{funcs}}({{\mathit{xv}}^\ast}) \\
{\mathrm{funcs}}({\mathit{externval}}~{{\mathit{xv}}^\ast}) &=& {\mathrm{funcs}}({{\mathit{xv}}^\ast})
  &\qquad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{globals}}(\epsilon) &=& \epsilon \\
{\mathrm{globals}}((\mathsf{global}~{\mathit{ga}})~{{\mathit{xv}}^\ast}) &=& {\mathit{ga}}~{\mathrm{globals}}({{\mathit{xv}}^\ast}) \\
{\mathrm{globals}}({\mathit{externval}}~{{\mathit{xv}}^\ast}) &=& {\mathrm{globals}}({{\mathit{xv}}^\ast})
  &\qquad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{tables}}(\epsilon) &=& \epsilon \\
{\mathrm{tables}}((\mathsf{table}~{\mathit{ta}})~{{\mathit{xv}}^\ast}) &=& {\mathit{ta}}~{\mathrm{tables}}({{\mathit{xv}}^\ast}) \\
{\mathrm{tables}}({\mathit{externval}}~{{\mathit{xv}}^\ast}) &=& {\mathrm{tables}}({{\mathit{xv}}^\ast})
  &\qquad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{mems}}(\epsilon) &=& \epsilon \\
{\mathrm{mems}}((\mathsf{mem}~{\mathit{ma}})~{{\mathit{xv}}^\ast}) &=& {\mathit{ma}}~{\mathrm{mems}}({{\mathit{xv}}^\ast}) \\
{\mathrm{mems}}({\mathit{externval}}~{{\mathit{xv}}^\ast}) &=& {\mathrm{mems}}({{\mathit{xv}}^\ast})
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{store} &=& {\mathit{s}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{frame} &=& {\mathit{f}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{module}.\mathsf{funcs} &=& {\mathit{f}}.\mathsf{module}.\mathsf{funcs} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{funcs} &=& {\mathit{s}}.\mathsf{funcs} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{globals} &=& {\mathit{s}}.\mathsf{globals} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{tables} &=& {\mathit{s}}.\mathsf{tables} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{mems} &=& {\mathit{s}}.\mathsf{mems} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{elems} &=& {\mathit{s}}.\mathsf{elems} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{datas} &=& {\mathit{s}}.\mathsf{datas} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{structs} &=& {\mathit{s}}.\mathsf{structs} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{arrays} &=& {\mathit{s}}.\mathsf{arrays} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{module} &=& {\mathit{f}}.\mathsf{module} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{types}{}[{\mathit{x}}] &=& {\mathit{f}}.\mathsf{module}.\mathsf{types}{}[{\mathit{x}}] \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{funcs}{}[{\mathit{x}}] &=& {\mathit{s}}.\mathsf{funcs}{}[{\mathit{f}}.\mathsf{module}.\mathsf{funcs}{}[{\mathit{x}}]] \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{globals}{}[{\mathit{x}}] &=& {\mathit{s}}.\mathsf{globals}{}[{\mathit{f}}.\mathsf{module}.\mathsf{globals}{}[{\mathit{x}}]] \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{tables}{}[{\mathit{x}}] &=& {\mathit{s}}.\mathsf{tables}{}[{\mathit{f}}.\mathsf{module}.\mathsf{tables}{}[{\mathit{x}}]] \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{mems}{}[{\mathit{x}}] &=& {\mathit{s}}.\mathsf{mems}{}[{\mathit{f}}.\mathsf{module}.\mathsf{mems}{}[{\mathit{x}}]] \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{elems}{}[{\mathit{x}}] &=& {\mathit{s}}.\mathsf{elems}{}[{\mathit{f}}.\mathsf{module}.\mathsf{elems}{}[{\mathit{x}}]] \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{datas}{}[{\mathit{x}}] &=& {\mathit{s}}.\mathsf{datas}{}[{\mathit{f}}.\mathsf{module}.\mathsf{datas}{}[{\mathit{x}}]] \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{locals}{}[{\mathit{x}}] &=& {\mathit{f}}.\mathsf{locals}{}[{\mathit{x}}] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}){}[\mathsf{locals}{}[{\mathit{x}}] = {\mathit{v}}] &=& {\mathit{s}} ; {\mathit{f}}{}[\mathsf{locals}{}[{\mathit{x}}] = {\mathit{v}}] \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}){}[\mathsf{globals}{}[{\mathit{x}}].\mathsf{value} = {\mathit{v}}] &=& {\mathit{s}}{}[\mathsf{globals}{}[{\mathit{f}}.\mathsf{module}.\mathsf{globals}{}[{\mathit{x}}]].\mathsf{value} = {\mathit{v}}] ; {\mathit{f}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}){}[\mathsf{tables}{}[{\mathit{x}}].\mathsf{refs}{}[{\mathit{i}}] = {\mathit{r}}] &=& {\mathit{s}}{}[\mathsf{tables}{}[{\mathit{f}}.\mathsf{module}.\mathsf{tables}{}[{\mathit{x}}]].\mathsf{refs}{}[{\mathit{i}}] = {\mathit{r}}] ; {\mathit{f}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}){}[\mathsf{tables}{}[{\mathit{x}}] = {\mathit{ti}}] &=& {\mathit{s}}{}[\mathsf{tables}{}[{\mathit{f}}.\mathsf{module}.\mathsf{tables}{}[{\mathit{x}}]] = {\mathit{ti}}] ; {\mathit{f}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}){}[\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}{}[{\mathit{i}} : {\mathit{j}}] = {{\mathit{b}}^\ast}] &=& {\mathit{s}}{}[\mathsf{mems}{}[{\mathit{f}}.\mathsf{module}.\mathsf{mems}{}[{\mathit{x}}]].\mathsf{bytes}{}[{\mathit{i}} : {\mathit{j}}] = {{\mathit{b}}^\ast}] ; {\mathit{f}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}){}[\mathsf{mems}{}[{\mathit{x}}] = {\mathit{mi}}] &=& {\mathit{s}}{}[\mathsf{mems}{}[{\mathit{f}}.\mathsf{module}.\mathsf{mems}{}[{\mathit{x}}]] = {\mathit{mi}}] ; {\mathit{f}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}){}[\mathsf{elems}{}[{\mathit{x}}].\mathsf{refs} = {{\mathit{r}}^\ast}] &=& {\mathit{s}}{}[\mathsf{elems}{}[{\mathit{f}}.\mathsf{module}.\mathsf{elems}{}[{\mathit{x}}]].\mathsf{refs} = {{\mathit{r}}^\ast}] ; {\mathit{f}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}){}[\mathsf{datas}{}[{\mathit{x}}].\mathsf{bytes} = {{\mathit{b}}^\ast}] &=& {\mathit{s}}{}[\mathsf{datas}{}[{\mathit{f}}.\mathsf{module}.\mathsf{datas}{}[{\mathit{x}}]].\mathsf{bytes} = {{\mathit{b}}^\ast}] ; {\mathit{f}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}){}[\mathsf{structs}{}[{\mathit{a}}].\mathsf{fields}{}[{\mathit{i}}] = {\mathit{fv}}] &=& {\mathit{s}}{}[\mathsf{structs}{}[{\mathit{a}}].\mathsf{fields}{}[{\mathit{i}}] = {\mathit{fv}}] ; {\mathit{f}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}){}[\mathsf{arrays}{}[{\mathit{a}}].\mathsf{fields}{}[{\mathit{i}}] = {\mathit{fv}}] &=& {\mathit{s}}{}[\mathsf{arrays}{}[{\mathit{a}}].\mathsf{fields}{}[{\mathit{i}}] = {\mathit{fv}}] ; {\mathit{f}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}){}[\mathsf{structs} = ..{{\mathit{si}}^\ast}] &=& {\mathit{s}}{}[\mathsf{structs} = ..{{\mathit{si}}^\ast}] ; {\mathit{f}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}){}[\mathsf{arrays} = ..{{\mathit{ai}}^\ast}] &=& {\mathit{s}}{}[\mathsf{arrays} = ..{{\mathit{ai}}^\ast}] ; {\mathit{f}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{growtable}}({\mathit{ti}}, {\mathit{n}}, {\mathit{r}}) &=& {\mathit{ti}'}
  &\qquad \mbox{if}~{\mathit{ti}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~({}[{\mathit{i}} .. {\mathit{j}}]~{\mathit{rt}}),\; \mathsf{refs}~{{\mathit{r}'}^\ast} \}\end{array} \\
  &&&\qquad {\land}~{\mathit{i}'} = {|{{\mathit{r}'}^\ast}|} + {\mathit{n}} \\
  &&&\qquad {\land}~{\mathit{ti}'} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~({}[{\mathit{i}'} .. {\mathit{j}}]~{\mathit{rt}}),\; \mathsf{refs}~{{\mathit{r}'}^\ast}~{{\mathit{r}}^{{\mathit{n}}}} \}\end{array} \\
  &&&\qquad {\land}~{\mathit{i}'} \leq {\mathit{j}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{growmemory}}({\mathit{mi}}, {\mathit{n}}) &=& {\mathit{mi}'}
  &\qquad \mbox{if}~{\mathit{mi}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~({}[{\mathit{i}} .. {\mathit{j}}]~\mathsf{i{\scriptstyle8}}),\; \mathsf{bytes}~{{\mathit{b}}^\ast} \}\end{array} \\
  &&&\qquad {\land}~{\mathit{i}'} = {|{{\mathit{b}}^\ast}|} / (64 \, {\mathrm{Ki}}) + {\mathit{n}} \\
  &&&\qquad {\land}~{\mathit{mi}'} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~({}[{\mathit{i}'} .. {\mathit{j}}]~\mathsf{i{\scriptstyle8}}),\; \mathsf{bytes}~{{\mathit{b}}^\ast}~{0^{{\mathit{n}} \cdot 64 \, {\mathrm{Ki}}}} \}\end{array} \\
  &&&\qquad {\land}~{\mathit{i}'} \leq {\mathit{j}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(initialization status)} & {\mathit{init}} &::=& \mathsf{set} ~|~ \mathsf{unset} \\
\mbox{(local type)} & {\mathit{localtype}} &::=& {\mathit{init}}~{\mathit{valtype}} \\
\mbox{(instruction type)} & {\mathit{instrtype}} &::=& {\mathit{resulttype}}~{\rightarrow}_{{{\mathit{localidx}}^\ast}}\,{\mathit{resulttype}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(context)} & {\mathit{context}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{types}~{{\mathit{deftype}}^\ast},\; \mathsf{rec}~{{\mathit{subtype}}^\ast},\; \\
  \mathsf{funcs}~{{\mathit{deftype}}^\ast},\; \mathsf{globals}~{{\mathit{globaltype}}^\ast},\; \mathsf{tables}~{{\mathit{tabletype}}^\ast},\; \mathsf{mems}~{{\mathit{memtype}}^\ast},\; \\
  \mathsf{elems}~{{\mathit{elemtype}}^\ast},\; \mathsf{datas}~{{\mathit{datatype}}^\ast},\; \\
  \mathsf{locals}~{{\mathit{localtype}}^\ast},\; \mathsf{labels}~{{\mathit{resulttype}}^\ast},\; \mathsf{return}~{{\mathit{resulttype}}^?} \}\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{C}}{}[\mathsf{local}{}[\epsilon] = \epsilon] &=& {\mathit{C}} \\
{\mathit{C}}{}[\mathsf{local}{}[{\mathit{x}}_{{1}}~{{\mathit{x}}^\ast}] = {{\mathit{lt}}}_{{1}}~{{{\mathit{lt}}}^\ast}] &=& {\mathit{C}}{}[\mathsf{locals}{}[{\mathit{x}}_{{1}}] = {{\mathit{lt}}}_{{1}}]{}[\mathsf{local}{}[{{\mathit{x}}^\ast}] = {{{\mathit{lt}}}^\ast}] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{clos}}~{\mathit{C}}~({\mathit{dt}}) &=& {{\mathit{dt}}}{{}[{ := }\;{{\mathit{dt}'}^\ast}]}
  &\qquad \mbox{if}~{{\mathit{dt}'}^\ast} = {\mathrm{clos}}~{}^\ast~({\mathit{C}}.\mathsf{types}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{clos}}~{}^\ast~(\epsilon) &=& \epsilon \\
{\mathrm{clos}}~{}^\ast~({{\mathit{dt}}^\ast}~{\mathit{dt}}_{{\mathit{N}}}) &=& {{\mathit{dt}'}^\ast}~{{\mathit{dt}}_{{\mathit{N}}}}{{}[{ := }\;{{\mathit{dt}'}^\ast}]}
  &\qquad \mbox{if}~{{\mathit{dt}'}^\ast} = {\mathrm{clos}}~{}^\ast~({{\mathit{dt}}^\ast}) \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{numtype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{vectype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{heaptype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{reftype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{valtype}} : \mathsf{ok}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{numtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}num}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{vectype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}vec}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{absheaptype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}heap{-}abs}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{typeidx}}] = {\mathit{dt}}
}{
{\mathit{C}} \vdash {\mathit{typeidx}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}heap{-}typeidx}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{rec}{}[{\mathit{i}}] = {\mathit{st}}
}{
{\mathit{C}} \vdash \mathsf{rec}~{\mathit{i}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}heap{-}rec}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{heaptype}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{ref}~{\mathsf{null}^?}~{\mathit{heaptype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{numtype}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathit{numtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}val{-}num}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{vectype}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathit{vectype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}val{-}vec}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{reftype}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathit{reftype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}val{-}ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{bot} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}val{-}bot}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{resulttype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{instrtype}} : \mathsf{ok}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{C}} \vdash {\mathit{t}} : \mathsf{ok})^\ast
}{
{\mathit{C}} \vdash {{\mathit{t}}^\ast} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}result}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {{\mathit{t}}_{{1}}^\ast} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{2}}^\ast} : \mathsf{ok}
 \qquad
({\mathit{C}}.\mathsf{locals}{}[{\mathit{x}}] = {{\mathit{lt}}})^\ast
}{
{\mathit{C}} \vdash {{\mathit{t}}_{{1}}^\ast}~{\rightarrow}_{{{\mathit{x}}^\ast}}\,{{\mathit{t}}_{{2}}^\ast} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}instr}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathsf{ok}}{({\mathit{typeidx}})} &::=& {\mathsf{ok}}{{\mathit{typeidx}}} \\
& {\mathsf{ok}}{({\mathit{typeidx}},\, {\mathit{n}})} &::=& {\mathsf{ok}}{({\mathit{typeidx}},\, {\mathit{nat}})} \\
\end{array}
$$

$\boxed{{\mathit{context}} \vdash {\mathit{packtype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{fieldtype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{storagetype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{comptype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{functype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{subtype}} : {\mathsf{ok}}{({\mathit{typeidx}})}}$

$\boxed{{\mathit{context}} \vdash {\mathit{rectype}} : {\mathsf{ok}}{({\mathit{typeidx}})}}$

$\boxed{{\mathit{context}} \vdash {\mathit{subtype}} : {\mathsf{ok}}{({\mathit{typeidx}},\, {\mathit{n}})}}$

$\boxed{{\mathit{context}} \vdash {\mathit{rectype}} : {\mathsf{ok}}{({\mathit{typeidx}},\, {\mathit{n}})}}$

$\boxed{{\mathit{context}} \vdash {\mathit{deftype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{comptype}} \leq {\mathit{comptype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{deftype}} \leq {\mathit{deftype}}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{packtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}pack}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{valtype}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathit{valtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}storage{-}val}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{packtype}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathit{packtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}storage{-}pack}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{storagetype}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathsf{mut}^?}~{\mathit{storagetype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}field}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{C}} \vdash {\mathit{fieldtype}} : \mathsf{ok})^\ast
}{
{\mathit{C}} \vdash \mathsf{struct}~{{\mathit{fieldtype}}^\ast} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}comp{-}struct}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{fieldtype}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{array}~{\mathit{fieldtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}comp{-}array}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{functype}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{func}~{\mathit{functype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}comp{-}func}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\begin{array}{@{}c@{}}
{|{{\mathit{x}}^\ast}|} \leq 1
 \qquad
({\mathit{x}} < {\mathit{x}}_{{0}})^\ast
 \qquad
({\mathrm{unroll}}({\mathit{C}}.\mathsf{types}{}[{\mathit{x}}]) = \mathsf{sub}~{{\mathit{x}'}^\ast}~{\mathit{comptype}'})^\ast
 \\
{\mathit{C}} \vdash {\mathit{comptype}} : \mathsf{ok}
 \qquad
({\mathit{C}} \vdash {\mathit{comptype}} \leq {\mathit{comptype}'})^\ast
\end{array}
}{
{\mathit{C}} \vdash \mathsf{sub}~{\mathsf{final}^?}~{{\mathit{typeidx}}^\ast}~{\mathit{comptype}} : {\mathsf{ok}}{({\mathit{x}}_{{0}})}
} \, {[\textsc{\scriptsize K{-}sub}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{deftype}} \prec {\mathit{x}}, {\mathit{i}} &=& \mathsf{true} \\
{\mathit{typeidx}} \prec {\mathit{x}}, {\mathit{i}} &=& {\mathit{typeidx}} < {\mathit{x}} \\
\mathsf{rec}~{\mathit{j}} \prec {\mathit{x}}, {\mathit{i}} &=& {\mathit{j}} < {\mathit{i}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{unroll}}}_{{\mathit{C}}}({\mathit{deftype}}) &=& {\mathrm{unroll}}({\mathit{deftype}}) \\
{{\mathrm{unroll}}}_{{\mathit{C}}}({\mathit{typeidx}}) &=& {\mathrm{unroll}}({\mathit{C}}.\mathsf{types}{}[{\mathit{typeidx}}]) \\
{{\mathrm{unroll}}}_{{\mathit{C}}}(\mathsf{rec}~{\mathit{i}}) &=& {\mathit{C}}.\mathsf{rec}{}[{\mathit{i}}] \\
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\begin{array}{@{}c@{}}
{|{{\mathit{typeuse}}^\ast}|} \leq 1
 \qquad
({\mathit{typeuse}} \prec {\mathit{x}}, {\mathit{i}})^\ast
 \qquad
({{\mathrm{unroll}}}_{{\mathit{C}}}({\mathit{typeuse}}) = \mathsf{sub}~{{\mathit{typeuse}'}^\ast}~{\mathit{comptype}'})^\ast
 \\
{\mathit{C}} \vdash {\mathit{comptype}} : \mathsf{ok}
 \qquad
({\mathit{C}} \vdash {\mathit{comptype}} \leq {\mathit{comptype}'})^\ast
\end{array}
}{
{\mathit{C}} \vdash \mathsf{sub}~{\mathsf{final}^?}~{{\mathit{typeuse}}^\ast}~{\mathit{compttype}} : {\mathsf{ok}}{({\mathit{x}},\, {\mathit{i}})}
} \, {[\textsc{\scriptsize K{-}sub2}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{rec}~\epsilon : {\mathsf{ok}}{({\mathit{x}})}
} \, {[\textsc{\scriptsize K{-}rect{-}empty}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{subtype}}_{{1}} : {\mathsf{ok}}{({\mathit{x}})}
 \qquad
{\mathit{C}} \vdash \mathsf{rec}~{{\mathit{subtype}}^\ast} : {\mathsf{ok}}{({\mathit{x}} + 1)}
}{
{\mathit{C}} \vdash \mathsf{rec}~({\mathit{subtype}}_{{1}}~{{\mathit{subtype}}^\ast}) : {\mathsf{ok}}{({\mathit{x}})}
} \, {[\textsc{\scriptsize K{-}rect{-}cons}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}, \mathsf{rec}~{{\mathit{subtype}}^\ast} \vdash \mathsf{rec}~{{\mathit{subtype}}^\ast} : {\mathsf{ok}}{({\mathit{x}},\, 0)}
}{
{\mathit{C}} \vdash \mathsf{rec}~{{\mathit{subtype}}^\ast} : {\mathsf{ok}}{({\mathit{x}})}
} \, {[\textsc{\scriptsize K{-}rect{-}rec2}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{rec}~\epsilon : {\mathsf{ok}}{({\mathit{x}},\, {\mathit{i}})}
} \, {[\textsc{\scriptsize K{-}rec2{-}empty}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{subtype}}_{{1}} : {\mathsf{ok}}{({\mathit{x}},\, {\mathit{i}})}
 \qquad
{\mathit{C}} \vdash \mathsf{rec}~{{\mathit{subtype}}^\ast} : {\mathsf{ok}}{({\mathit{x}} + 1,\, {\mathit{i}} + 1)}
}{
{\mathit{C}} \vdash \mathsf{rec}~({\mathit{subtype}}_{{1}}~{{\mathit{subtype}}^\ast}) : {\mathsf{ok}}{({\mathit{x}},\, {\mathit{i}})}
} \, {[\textsc{\scriptsize K{-}rec2{-}cons}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{rectype}} : {\mathsf{ok}}{({\mathit{x}})}
 \qquad
{\mathit{rectype}} = \mathsf{rec}~{{\mathit{subtype}}^{{\mathit{n}}}}
 \qquad
{\mathit{i}} < {\mathit{n}}
}{
{\mathit{C}} \vdash {\mathit{rectype}} . {\mathit{i}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}def}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{limits}} : {\mathit{nat}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{globaltype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{tabletype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{memtype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{externtype}} : \mathsf{ok}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{n}} \leq {\mathit{m}} \leq {\mathit{k}}
}{
{\mathit{C}} \vdash {}[{\mathit{n}} .. {\mathit{m}}] : {\mathit{k}}
} \, {[\textsc{\scriptsize K{-}limits}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {{\mathit{t}}_{{1}}^\ast} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{2}}^\ast} : \mathsf{ok}
}{
{\mathit{C}} \vdash {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{t}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathsf{mut}^?}~{\mathit{t}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{limits}} : {2^{32}} - 1
 \qquad
{\mathit{C}} \vdash {\mathit{reftype}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathit{limits}}~{\mathit{reftype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{limits}} : {2^{16}}
}{
{\mathit{C}} \vdash {\mathit{limits}}~\mathsf{i{\scriptstyle8}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{deftype}} : \mathsf{ok}
 \qquad
{\mathit{deftype}} \approx \mathsf{func}~{\mathit{functype}}
}{
{\mathit{C}} \vdash \mathsf{func}~{\mathit{deftype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{globaltype}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{global}~{\mathit{globaltype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{tabletype}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{table}~{\mathit{tabletype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{memtype}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{mem}~{\mathit{memtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{numtype}} \leq {\mathit{numtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{vectype}} \leq {\mathit{vectype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{heaptype}} \leq {\mathit{heaptype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{reftype}} \leq {\mathit{reftype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{valtype}} \leq {\mathit{valtype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{numtype}} \leq {\mathit{numtype}}
} \, {[\textsc{\scriptsize S{-}num}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{vectype}} \leq {\mathit{vectype}}
} \, {[\textsc{\scriptsize S{-}vec}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{heaptype}} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}refl}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{heaptype}'} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{heaptype}}_{{1}} \leq {\mathit{heaptype}'}
 \qquad
{\mathit{C}} \vdash {\mathit{heaptype}'} \leq {\mathit{heaptype}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{heaptype}}_{{1}} \leq {\mathit{heaptype}}_{{2}}
} \, {[\textsc{\scriptsize S{-}heap{-}trans}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{eq} \leq \mathsf{any}
} \, {[\textsc{\scriptsize S{-}heap{-}eq{-}any}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{i{\scriptstyle31}} \leq \mathsf{eq}
} \, {[\textsc{\scriptsize S{-}heap{-}i31{-}eq}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{struct} \leq \mathsf{eq}
} \, {[\textsc{\scriptsize S{-}heap{-}struct{-}eq}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{array} \leq \mathsf{eq}
} \, {[\textsc{\scriptsize S{-}heap{-}array{-}eq}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{deftype}} \approx \mathsf{struct}~{{\mathit{yt}}^\ast}
}{
{\mathit{C}} \vdash {\mathit{deftype}} \leq \mathsf{struct}
} \, {[\textsc{\scriptsize S{-}heap{-}struct}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{deftype}} \approx \mathsf{array}~{\mathit{yt}}
}{
{\mathit{C}} \vdash {\mathit{deftype}} \leq \mathsf{array}
} \, {[\textsc{\scriptsize S{-}heap{-}array}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{deftype}} \approx \mathsf{func}~{\mathit{ft}}
}{
{\mathit{C}} \vdash {\mathit{deftype}} \leq \mathsf{func}
} \, {[\textsc{\scriptsize S{-}heap{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{deftype}}_{{1}} \leq {\mathit{deftype}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{deftype}}_{{1}} \leq {\mathit{deftype}}_{{2}}
} \, {[\textsc{\scriptsize S{-}heap{-}def}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{C}}.\mathsf{types}{}[{\mathit{typeidx}}] \leq {\mathit{heaptype}}
}{
{\mathit{C}} \vdash {\mathit{typeidx}} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}typeidx{-}l}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{heaptype}} \leq {\mathit{C}}.\mathsf{types}{}[{\mathit{typeidx}}]
}{
{\mathit{C}} \vdash {\mathit{heaptype}} \leq {\mathit{typeidx}}
} \, {[\textsc{\scriptsize S{-}heap{-}typeidx{-}r}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{rec}{}[{\mathit{i}}] = \mathsf{sub}~{\mathit{fin}}~({{{\mathit{y}}}_{{1}}^\ast}~{{\mathit{y}}}~{{{\mathit{y}}}_{{2}}^\ast})~{\mathit{ct}}
}{
{\mathit{C}} \vdash \mathsf{rec}~{\mathit{i}} \leq {{\mathit{y}}}
} \, {[\textsc{\scriptsize S{-}heap{-}rec}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{heaptype}} \leq \mathsf{any}
}{
{\mathit{C}} \vdash \mathsf{none} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}none}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{heaptype}} \leq \mathsf{func}
}{
{\mathit{C}} \vdash \mathsf{nofunc} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}nofunc}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{heaptype}} \leq \mathsf{extern}
}{
{\mathit{C}} \vdash \mathsf{noextern} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}noextern}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{bot} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}bot}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{ht}}_{{1}} \leq {\mathit{ht}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{ref}~{\mathit{ht}}_{{1}} \leq \mathsf{ref}~{\mathit{ht}}_{{2}}
} \, {[\textsc{\scriptsize S{-}ref{-}nonnull}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{ht}}_{{1}} \leq {\mathit{ht}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{ref}~{\mathsf{null}^?}~{\mathit{ht}}_{{1}} \leq \mathsf{ref}~\mathsf{null}~{\mathit{ht}}_{{2}}
} \, {[\textsc{\scriptsize S{-}ref{-}null}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{numtype}}_{{1}} \leq {\mathit{numtype}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{numtype}}_{{1}} \leq {\mathit{numtype}}_{{2}}
} \, {[\textsc{\scriptsize S{-}val{-}num}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{vectype}}_{{1}} \leq {\mathit{vectype}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{vectype}}_{{1}} \leq {\mathit{vectype}}_{{2}}
} \, {[\textsc{\scriptsize S{-}val{-}vec}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{reftype}}_{{1}} \leq {\mathit{reftype}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{reftype}}_{{1}} \leq {\mathit{reftype}}_{{2}}
} \, {[\textsc{\scriptsize S{-}val{-}ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{bot} \leq {\mathit{valtype}}
} \, {[\textsc{\scriptsize S{-}val{-}bot}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {{\mathit{valtype}}^\ast} \leq {{\mathit{valtype}}^\ast}}$

$\boxed{{\mathit{context}} \vdash {\mathit{instrtype}} \leq {\mathit{instrtype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{C}} \vdash {\mathit{t}}_{{1}} \leq {\mathit{t}}_{{2}})^\ast
}{
{\mathit{C}} \vdash {{\mathit{t}}_{{1}}^\ast} \leq {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize S{-}result}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {{\mathit{t}}_{{21}}^\ast} \leq {{\mathit{t}}_{{11}}^\ast}
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{12}}^\ast} \leq {{\mathit{t}}_{{22}}^\ast}
 \qquad
{{\mathit{x}}^\ast} = {{\mathit{x}}_{{2}}^\ast} \setminus {{\mathit{x}}_{{1}}^\ast}
 \qquad
(({\mathit{C}}.\mathsf{locals}{}[{\mathit{x}}] = \mathsf{set}~{\mathit{t}}))^\ast
}{
{\mathit{C}} \vdash {{\mathit{t}}_{{11}}^\ast}~{\rightarrow}_{{{\mathit{x}}_{{1}}^\ast}}\,{{\mathit{t}}_{{12}}^\ast} \leq {{\mathit{t}}_{{21}}^\ast}~{\rightarrow}_{{{\mathit{x}}_{{2}}^\ast}}\,{{\mathit{t}}_{{22}}^\ast}
} \, {[\textsc{\scriptsize S{-}instr}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{packtype}} \leq {\mathit{packtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{storagetype}} \leq {\mathit{storagetype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{fieldtype}} \leq {\mathit{fieldtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{functype}} \leq {\mathit{functype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{packtype}} \leq {\mathit{packtype}}
} \, {[\textsc{\scriptsize S{-}pack}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{valtype}}_{{1}} \leq {\mathit{valtype}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{valtype}}_{{1}} \leq {\mathit{valtype}}_{{2}}
} \, {[\textsc{\scriptsize S{-}storage{-}val}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{packtype}}_{{1}} \leq {\mathit{packtype}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{packtype}}_{{1}} \leq {\mathit{packtype}}_{{2}}
} \, {[\textsc{\scriptsize S{-}storage{-}pack}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{zt}}_{{1}} \leq {\mathit{zt}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{zt}}_{{1}} \leq {\mathit{zt}}_{{2}}
} \, {[\textsc{\scriptsize S{-}field{-}const}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{zt}}_{{1}} \leq {\mathit{zt}}_{{2}}
 \qquad
{\mathit{C}} \vdash {\mathit{zt}}_{{2}} \leq {\mathit{zt}}_{{1}}
}{
{\mathit{C}} \vdash \mathsf{mut}~{\mathit{zt}}_{{1}} \leq \mathsf{mut}~{\mathit{zt}}_{{2}}
} \, {[\textsc{\scriptsize S{-}field{-}var}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{C}} \vdash {\mathit{yt}}_{{1}} \leq {\mathit{yt}}_{{2}})^\ast
}{
{\mathit{C}} \vdash \mathsf{struct}~({{\mathit{yt}}_{{1}}^\ast}~{\mathit{yt}'}_{{1}}) \leq \mathsf{struct}~{{\mathit{yt}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize S{-}comp{-}struct}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{yt}}_{{1}} \leq {\mathit{yt}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{array}~{\mathit{yt}}_{{1}} \leq \mathsf{array}~{\mathit{yt}}_{{2}}
} \, {[\textsc{\scriptsize S{-}comp{-}array}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{ft}}_{{1}} \leq {\mathit{ft}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{func}~{\mathit{ft}}_{{1}} \leq \mathsf{func}~{\mathit{ft}}_{{2}}
} \, {[\textsc{\scriptsize S{-}comp{-}func}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathrm{clos}}~{\mathit{C}}~({\mathit{deftype}}_{{1}}) = {\mathrm{clos}}~{\mathit{C}}~({\mathit{deftype}}_{{2}})
}{
{\mathit{C}} \vdash {\mathit{deftype}}_{{1}} \leq {\mathit{deftype}}_{{2}}
} \, {[\textsc{\scriptsize S{-}def{-}refl}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathrm{unroll}}({\mathit{deftype}}_{{1}}) = \mathsf{sub}~{\mathit{fin}}~({{{\mathit{y}}}_{{1}}^\ast}~{{\mathit{y}}}~{{{\mathit{y}}}_{{2}}^\ast})~{\mathit{ct}}
 \qquad
{\mathit{C}} \vdash {{\mathit{y}}} \leq {\mathit{deftype}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{deftype}}_{{1}} \leq {\mathit{deftype}}_{{2}}
} \, {[\textsc{\scriptsize S{-}def{-}super}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{limits}} \leq {\mathit{limits}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{globaltype}} \leq {\mathit{globaltype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{tabletype}} \leq {\mathit{tabletype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{memtype}} \leq {\mathit{memtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{externtype}} \leq {\mathit{externtype}}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{n}}_{{11}} \geq {\mathit{n}}_{{21}}
 \qquad
{\mathit{n}}_{{12}} \leq {\mathit{n}}_{{22}}
}{
{\mathit{C}} \vdash {}[{\mathit{n}}_{{11}} .. {\mathit{n}}_{{12}}] \leq {}[{\mathit{n}}_{{21}} .. {\mathit{n}}_{{22}}]
} \, {[\textsc{\scriptsize S{-}limits}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{ft}} \leq {\mathit{ft}}
} \, {[\textsc{\scriptsize S{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{t}}_{{1}} \leq {\mathit{t}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{t}}_{{1}} \leq {\mathit{t}}_{{2}}
} \, {[\textsc{\scriptsize S{-}global{-}const}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{t}}_{{1}} \leq {\mathit{t}}_{{2}}
 \qquad
{\mathit{C}} \vdash {\mathit{t}}_{{2}} \leq {\mathit{t}}_{{1}}
}{
{\mathit{C}} \vdash \mathsf{mut}~{\mathit{t}}_{{1}} \leq \mathsf{mut}~{\mathit{t}}_{{2}}
} \, {[\textsc{\scriptsize S{-}global{-}var}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{lim}}_{{1}} \leq {\mathit{lim}}_{{2}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{1}} \leq {\mathit{rt}}_{{2}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} \leq {\mathit{rt}}_{{1}}
}{
{\mathit{C}} \vdash {\mathit{lim}}_{{1}}~{\mathit{rt}}_{{1}} \leq {\mathit{lim}}_{{2}}~{\mathit{rt}}_{{2}}
} \, {[\textsc{\scriptsize S{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{lim}}_{{1}} \leq {\mathit{lim}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{lim}}_{{1}}~\mathsf{i{\scriptstyle8}} \leq {\mathit{lim}}_{{2}}~\mathsf{i{\scriptstyle8}}
} \, {[\textsc{\scriptsize S{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{dt}}_{{1}} \leq {\mathit{dt}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{func}~{\mathit{dt}}_{{1}} \leq \mathsf{func}~{\mathit{dt}}_{{2}}
} \, {[\textsc{\scriptsize S{-}extern{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{gt}}_{{1}} \leq {\mathit{gt}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{global}~{\mathit{gt}}_{{1}} \leq \mathsf{global}~{\mathit{gt}}_{{2}}
} \, {[\textsc{\scriptsize S{-}extern{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{tt}}_{{1}} \leq {\mathit{tt}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{table}~{\mathit{tt}}_{{1}} \leq \mathsf{table}~{\mathit{tt}}_{{2}}
} \, {[\textsc{\scriptsize S{-}extern{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{mt}}_{{1}} \leq {\mathit{mt}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{mem}~{\mathit{mt}}_{{1}} \leq \mathsf{mem}~{\mathit{mt}}_{{2}}
} \, {[\textsc{\scriptsize S{-}extern{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{instr}} : {\mathit{instrtype}}}$

$\boxed{{\mathit{context}} \vdash {{\mathit{instr}}^\ast} : {\mathit{instrtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{expr}} : {\mathit{resulttype}}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : \epsilon~{\rightarrow}_{\epsilon}\,{{\mathit{t}}^\ast}
}{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : {{\mathit{t}}^\ast}
} \, {[\textsc{\scriptsize T{-}expr}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \epsilon : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr*{-}empty}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{instr}}_{{1}} : {{\mathit{t}}_{{1}}^\ast}~{\rightarrow}_{{{\mathit{x}}_{{1}}^\ast}}\,{{\mathit{t}}_{{2}}^\ast}
 \qquad
({\mathit{C}}.\mathsf{locals}{}[{\mathit{x}}_{{1}}] = {\mathit{init}}~{\mathit{t}})^\ast
 \qquad
{\mathit{C}}{}[\mathsf{local}{}[{{\mathit{x}}_{{1}}^\ast}] = {(\mathsf{set}~{\mathit{t}})^\ast}] \vdash {{\mathit{instr}}_{{2}}^\ast} : {{\mathit{t}}_{{2}}^\ast}~{\rightarrow}_{{{\mathit{x}}_{{2}}^\ast}}\,{{\mathit{t}}_{{3}}^\ast}
}{
{\mathit{C}} \vdash {\mathit{instr}}_{{1}}~{{\mathit{instr}}_{{2}}^\ast} : {{\mathit{t}}_{{1}}^\ast}~{\rightarrow}_{{{\mathit{x}}_{{1}}^\ast}~{{\mathit{x}}_{{2}}^\ast}}\,{{\mathit{t}}_{{3}}^\ast}
} \, {[\textsc{\scriptsize T{-}instr*{-}seq}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : {\mathit{it}}
 \qquad
{\mathit{C}} \vdash {\mathit{it}} \leq {\mathit{it}'}
 \qquad
{\mathit{C}} \vdash {\mathit{it}'} : \mathsf{ok}
}{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : {\mathit{it}'}
} \, {[\textsc{\scriptsize T{-}instr*{-}sub}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
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

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{nop} : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}nop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{unreachable} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}unreachable}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{t}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{drop} : {\mathit{t}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}drop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{t}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{select}~{\mathit{t}} : {\mathit{t}}~{\mathit{t}}~\mathsf{i{\scriptstyle32}} \rightarrow {\mathit{t}}
} \, {[\textsc{\scriptsize T{-}select{-}expl}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{t}} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{t}} \leq {\mathit{t}'}
 \qquad
{\mathit{t}'} = {\mathit{numtype}} \lor {\mathit{t}'} = {\mathit{vectype}}
}{
{\mathit{C}} \vdash \mathsf{select} : {\mathit{t}}~{\mathit{t}}~\mathsf{i{\scriptstyle32}} \rightarrow {\mathit{t}}
} \, {[\textsc{\scriptsize T{-}select{-}impl}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{blocktype}} : {\mathit{instrtype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{C}} \vdash {\mathit{valtype}} : \mathsf{ok})^?
}{
{\mathit{C}} \vdash {{\mathit{valtype}}^?} : \epsilon \rightarrow {{\mathit{valtype}}^?}
} \, {[\textsc{\scriptsize K{-}block{-}valtype}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{typeidx}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
}{
{\mathit{C}} \vdash {\mathit{typeidx}} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize K{-}block{-}typeidx}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{bt}} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
 \qquad
{\mathit{C}}, \mathsf{labels}~({{\mathit{t}}_{{2}}^\ast}) \vdash {{\mathit{instr}}^\ast} : {{\mathit{t}}_{{1}}^\ast}~{\rightarrow}_{{{\mathit{x}}^\ast}}\,{{\mathit{t}}_{{2}}^\ast}
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
{\mathit{C}}, \mathsf{labels}~({{\mathit{t}}_{{1}}^\ast}) \vdash {{\mathit{instr}}^\ast} : {{\mathit{t}}_{{1}}^\ast}~{\rightarrow}_{{{\mathit{x}}^\ast}}\,{{\mathit{t}}_{{2}}^\ast}
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
{\mathit{C}}, \mathsf{labels}~({{\mathit{t}}_{{2}}^\ast}) \vdash {{\mathit{instr}}_{{1}}^\ast} : {{\mathit{t}}_{{1}}^\ast}~{\rightarrow}_{{{\mathit{x}}_{{1}}^\ast}}\,{{\mathit{t}}_{{2}}^\ast}
 \qquad
{\mathit{C}}, \mathsf{labels}~({{\mathit{t}}_{{2}}^\ast}) \vdash {{\mathit{instr}}_{{2}}^\ast} : {{\mathit{t}}_{{1}}^\ast}~{\rightarrow}_{{{\mathit{x}}_{{2}}^\ast}}\,{{\mathit{t}}_{{2}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_{{1}}^\ast}~\mathsf{else}~{{\mathit{instr}}_{{2}}^\ast} : {{\mathit{t}}_{{1}}^\ast}~\mathsf{i{\scriptstyle32}} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}if}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{labels}{}[{\mathit{l}}] = {{\mathit{t}}^\ast}
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{br}~{\mathit{l}} : {{\mathit{t}}_{{1}}^\ast}~{{\mathit{t}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}br}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{labels}{}[{\mathit{l}}] = {{\mathit{t}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{br\_if}~{\mathit{l}} : {{\mathit{t}}^\ast}~\mathsf{i{\scriptstyle32}} \rightarrow {{\mathit{t}}^\ast}
} \, {[\textsc{\scriptsize T{-}br\_if}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{C}} \vdash {{\mathit{t}}^\ast} \leq {\mathit{C}}.\mathsf{labels}{}[{\mathit{l}}])^\ast
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}^\ast} \leq {\mathit{C}}.\mathsf{labels}{}[{\mathit{l}'}]
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{br\_table}~{{\mathit{l}}^\ast}~{\mathit{l}'} : {{\mathit{t}}_{{1}}^\ast}~{{\mathit{t}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}br\_table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{labels}{}[{\mathit{l}}] = {{\mathit{t}}^\ast}
 \qquad
{\mathit{C}} \vdash {\mathit{ht}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{br\_on\_null}~{\mathit{l}} : {{\mathit{t}}^\ast}~(\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \rightarrow {{\mathit{t}}^\ast}~(\mathsf{ref}~{\mathit{ht}})
} \, {[\textsc{\scriptsize T{-}br\_on\_null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{labels}{}[{\mathit{l}}] = {{\mathit{t}}^\ast}~(\mathsf{ref}~{\mathit{ht}})
}{
{\mathit{C}} \vdash \mathsf{br\_on\_non\_null}~{\mathit{l}} : {{\mathit{t}}^\ast}~(\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \rightarrow {{\mathit{t}}^\ast}
} \, {[\textsc{\scriptsize T{-}br\_on\_non\_null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{labels}{}[{\mathit{l}}] = {{\mathit{t}}^\ast}~{\mathit{rt}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{1}} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} \leq {\mathit{rt}}_{{1}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} \leq {\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{br\_on\_cast}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}} : {{\mathit{t}}^\ast}~{\mathit{rt}}_{{1}} \rightarrow {{\mathit{t}}^\ast}~({\mathit{rt}}_{{1}} \setminus {\mathit{rt}}_{{2}})
} \, {[\textsc{\scriptsize T{-}br\_on\_cast}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{labels}{}[{\mathit{l}}] = {{\mathit{t}}^\ast}~{\mathit{rt}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{1}} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} \leq {\mathit{rt}}_{{1}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{1}} \setminus {\mathit{rt}}_{{2}} \leq {\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{br\_on\_cast\_fail}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}} : {{\mathit{t}}^\ast}~{\mathit{rt}}_{{1}} \rightarrow {{\mathit{t}}^\ast}~{\mathit{rt}}_{{2}}
} \, {[\textsc{\scriptsize T{-}br\_on\_cast\_fail}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{funcs}{}[{\mathit{x}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
}{
{\mathit{C}} \vdash \mathsf{call}~{\mathit{x}} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}call}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
}{
{\mathit{C}} \vdash \mathsf{call\_ref}~{\mathit{x}} : {{\mathit{t}}_{{1}}^\ast}~(\mathsf{ref}~\mathsf{null}~{\mathit{x}}) \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}call\_ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{tables}{}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}} \leq (\mathsf{ref}~\mathsf{null}~\mathsf{func})
 \qquad
{\mathit{C}}.\mathsf{types}{}[{\mathit{y}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
}{
{\mathit{C}} \vdash \mathsf{call\_indirect}~{\mathit{x}}~{\mathit{y}} : {{\mathit{t}}_{{1}}^\ast}~\mathsf{i{\scriptstyle32}} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}call\_indirect}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{return} = ({{\mathit{t}}^\ast})
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{return} : {{\mathit{t}}_{{1}}^\ast}~{{\mathit{t}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}return}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{funcs}{}[{\mathit{x}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
 \qquad
{\mathit{C}}.\mathsf{return} = ({{\mathit{t}'}_{{2}}^\ast})
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{2}}^\ast} \leq {{\mathit{t}'}_{{2}}^\ast}
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{3}}^\ast} \rightarrow {{\mathit{t}}_{{4}}^\ast} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{return\_call}~{\mathit{x}} : {{\mathit{t}}_{{3}}^\ast}~{{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{4}}^\ast}
} \, {[\textsc{\scriptsize T{-}return\_call}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
 \qquad
{\mathit{C}}.\mathsf{return} = ({{\mathit{t}'}_{{2}}^\ast})
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{2}}^\ast} \leq {{\mathit{t}'}_{{2}}^\ast}
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{3}}^\ast} \rightarrow {{\mathit{t}}_{{4}}^\ast} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{return\_call\_ref}~{\mathit{x}} : {{\mathit{t}}_{{3}}^\ast}~{{\mathit{t}}_{{1}}^\ast}~(\mathsf{ref}~\mathsf{null}~{\mathit{x}}) \rightarrow {{\mathit{t}}_{{4}}^\ast}
} \, {[\textsc{\scriptsize T{-}return\_call\_ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\begin{array}{@{}c@{}}
{\mathit{C}}.\mathsf{tables}{}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}} \leq (\mathsf{ref}~\mathsf{null}~\mathsf{func})
 \\
{\mathit{C}}.\mathsf{types}{}[{\mathit{y}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
 \qquad
{\mathit{C}}.\mathsf{return} = ({{\mathit{t}'}_{{2}}^\ast})
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{2}}^\ast} \leq {{\mathit{t}'}_{{2}}^\ast}
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{3}}^\ast} \rightarrow {{\mathit{t}}_{{4}}^\ast} : \mathsf{ok}
\end{array}
}{
{\mathit{C}} \vdash \mathsf{return\_call\_indirect}~{\mathit{x}}~{\mathit{y}} : {{\mathit{t}}_{{3}}^\ast}~{{\mathit{t}}_{{1}}^\ast}~\mathsf{i{\scriptstyle32}} \rightarrow {{\mathit{t}}_{{4}}^\ast}
} \, {[\textsc{\scriptsize T{-}return\_call\_indirect}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{\mathit{nt}}} : \epsilon \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}const}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{nt}} . {\mathit{unop}}_{{\mathit{nt}}} : {\mathit{nt}} \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}unop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{nt}} . {\mathit{binop}}_{{\mathit{nt}}} : {\mathit{nt}}~{\mathit{nt}} \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}binop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{nt}} . {\mathit{testop}}_{{\mathit{nt}}} : {\mathit{nt}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}testop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{nt}} . {\mathit{relop}}_{{\mathit{nt}}} : {\mathit{nt}}~{\mathit{nt}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}relop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{|{\mathit{nt}}_{{1}}|} = {|{\mathit{nt}}_{{2}}|}
}{
{\mathit{C}} \vdash {\mathit{nt}}_{{1}} . {{\mathsf{reinterpret}}{\mathsf{\_}}}{{\mathit{nt}}_{{2}}} : {\mathit{nt}}_{{2}} \rightarrow {\mathit{nt}}_{{1}}
} \, {[\textsc{\scriptsize T{-}cvtop{-}reinterpret}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{{\mathit{sx}}^?} = \epsilon \Leftrightarrow {|{{\mathsf{i}}{{\mathit{n}}}}_{{1}}|} > {|{{\mathsf{i}}{{\mathit{n}}}}_{{2}}|}
}{
{\mathit{C}} \vdash {{\mathsf{i}}{{\mathit{n}}}}_{{1}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{{{\mathsf{i}}{{\mathit{n}}}}_{{2}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}} : {{\mathsf{i}}{{\mathit{n}}}}_{{2}} \rightarrow {{\mathsf{i}}{{\mathit{n}}}}_{{1}}
} \, {[\textsc{\scriptsize T{-}cvtop{-}convert{-}i}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {{\mathsf{f}}{{\mathit{n}}}}_{{1}} . {{\mathsf{convert}}{\mathsf{\_}}}{{{\mathsf{f}}{{\mathit{n}}}}_{{2}}} : {{\mathsf{f}}{{\mathit{n}}}}_{{2}} \rightarrow {{\mathsf{f}}{{\mathit{n}}}}_{{1}}
} \, {[\textsc{\scriptsize T{-}cvtop{-}convert{-}f}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{ht}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{ref.null}~{\mathit{ht}} : \epsilon \rightarrow (\mathsf{ref}~\mathsf{null}~{\mathit{ht}})
} \, {[\textsc{\scriptsize T{-}ref.null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{funcs}{}[{\mathit{x}}] = {\mathit{dt}}
}{
{\mathit{C}} \vdash \mathsf{ref.func}~{\mathit{x}} : \epsilon \rightarrow (\mathsf{ref}~{\mathit{dt}})
} \, {[\textsc{\scriptsize T{-}ref.func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{ref.i{\scriptstyle31}} : \mathsf{i{\scriptstyle32}} \rightarrow (\mathsf{ref}~\mathsf{i{\scriptstyle31}})
} \, {[\textsc{\scriptsize T{-}ref.i31}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{ht}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{ref.is\_null} : (\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}ref.is\_null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{ht}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{ref.as\_non\_null} : (\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \rightarrow (\mathsf{ref}~{\mathit{ht}})
} \, {[\textsc{\scriptsize T{-}ref.as\_non\_null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{ref.eq} : (\mathsf{ref}~\mathsf{null}~\mathsf{eq})~(\mathsf{ref}~\mathsf{null}~\mathsf{eq}) \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}ref.eq}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{rt}} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}'} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}} \leq {\mathit{rt}'}
}{
{\mathit{C}} \vdash \mathsf{ref.test}~{\mathit{rt}} : {\mathit{rt}'} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}ref.test}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{rt}} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}'} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}} \leq {\mathit{rt}'}
}{
{\mathit{C}} \vdash \mathsf{ref.cast}~{\mathit{rt}} : {\mathit{rt}'} \rightarrow {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}ref.cast}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {{\mathsf{i{\scriptstyle31}.get}}{\mathsf{\_}}}{{\mathit{sx}}} : (\mathsf{ref}~\mathsf{null}~\mathsf{i{\scriptstyle31}}) \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}i31.get}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{struct}~{({\mathit{mut}}~{\mathit{zt}})^\ast}
}{
{\mathit{C}} \vdash \mathsf{struct.new}~{\mathit{x}} : {{\mathrm{unpack}}({\mathit{zt}})^\ast} \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}struct.new}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{struct}~{({\mathit{mut}}~{\mathit{zt}})^\ast}
 \qquad
({{\mathrm{default}}}_{{\mathrm{unpack}}({\mathit{zt}})} = {\mathit{val}})^\ast
}{
{\mathit{C}} \vdash \mathsf{struct.new\_default}~{\mathit{x}} : \epsilon \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}struct.new\_default}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{struct}~{{\mathit{yt}}^\ast}
 \qquad
{{\mathit{yt}}^\ast}{}[{\mathit{i}}] = {\mathit{mut}}~{\mathit{zt}}
 \qquad
{{\mathit{sx}}^?} = \epsilon \Leftrightarrow {\mathit{zt}} = {\mathrm{unpack}}({\mathit{zt}})
}{
{\mathit{C}} \vdash {{\mathsf{struct.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}~{\mathit{i}} : (\mathsf{ref}~\mathsf{null}~{\mathit{x}}) \rightarrow {\mathrm{unpack}}({\mathit{zt}})
} \, {[\textsc{\scriptsize T{-}struct.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{struct}~{{\mathit{yt}}^\ast}
 \qquad
{{\mathit{yt}}^\ast}{}[{\mathit{i}}] = \mathsf{mut}~{\mathit{zt}}
}{
{\mathit{C}} \vdash \mathsf{struct.set}~{\mathit{x}}~{\mathit{i}} : (\mathsf{ref}~\mathsf{null}~{\mathit{x}})~{\mathrm{unpack}}({\mathit{zt}}) \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}struct.set}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})
}{
{\mathit{C}} \vdash \mathsf{array.new}~{\mathit{x}} : {\mathrm{unpack}}({\mathit{zt}})~\mathsf{i{\scriptstyle32}} \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}array.new}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})
 \qquad
{{\mathrm{default}}}_{{\mathrm{unpack}}({\mathit{zt}})} = {\mathit{val}}
}{
{\mathit{C}} \vdash \mathsf{array.new\_default}~{\mathit{x}} : \mathsf{i{\scriptstyle32}} \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}array.new\_default}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})
}{
{\mathit{C}} \vdash \mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}} : {{\mathrm{unpack}}({\mathit{zt}})^{{\mathit{n}}}} \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}array.new\_fixed}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{rt}})
 \qquad
{\mathit{C}} \vdash {\mathit{C}}.\mathsf{elems}{}[{\mathit{y}}] \leq {\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{array.new\_elem}~{\mathit{x}}~{\mathit{y}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}array.new\_elem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})
 \qquad
{\mathrm{unpack}}({\mathit{zt}}) = {\mathit{numtype}} \lor {\mathrm{unpack}}({\mathit{zt}}) = {\mathit{vectype}}
 \qquad
{\mathit{C}}.\mathsf{datas}{}[{\mathit{y}}] = \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{array.new\_data}~{\mathit{x}}~{\mathit{y}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}array.new\_data}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})
 \qquad
{{\mathit{sx}}^?} = \epsilon \Leftrightarrow {\mathit{zt}} = {\mathrm{unpack}}({\mathit{zt}})
}{
{\mathit{C}} \vdash {{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}} : (\mathsf{ref}~\mathsf{null}~{\mathit{x}})~\mathsf{i{\scriptstyle32}} \rightarrow {\mathrm{unpack}}({\mathit{zt}})
} \, {[\textsc{\scriptsize T{-}array.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
}{
{\mathit{C}} \vdash \mathsf{array.set}~{\mathit{x}} : (\mathsf{ref}~\mathsf{null}~{\mathit{x}})~\mathsf{i{\scriptstyle32}}~{\mathrm{unpack}}({\mathit{zt}}) \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}array.set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
}{
{\mathit{C}} \vdash \mathsf{array.len} : (\mathsf{ref}~\mathsf{null}~\mathsf{array}) \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}array.len}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
}{
{\mathit{C}} \vdash \mathsf{array.fill}~{\mathit{x}} : (\mathsf{ref}~\mathsf{null}~{\mathit{x}})~\mathsf{i{\scriptstyle32}}~{\mathrm{unpack}}({\mathit{zt}})~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}array.fill}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}_{{1}}] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}}_{{1}})
 \qquad
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}_{{2}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}_{{2}})
 \qquad
{\mathit{C}} \vdash {\mathit{zt}}_{{2}} \leq {\mathit{zt}}_{{1}}
}{
{\mathit{C}} \vdash \mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}} : (\mathsf{ref}~\mathsf{null}~{\mathit{x}}_{{1}})~\mathsf{i{\scriptstyle32}}~(\mathsf{ref}~\mathsf{null}~{\mathit{x}}_{{2}})~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}array.copy}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
 \qquad
{\mathit{C}} \vdash {\mathit{C}}.\mathsf{elems}{}[{\mathit{y}}] \leq {\mathit{zt}}
}{
{\mathit{C}} \vdash \mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}} : (\mathsf{ref}~\mathsf{null}~{\mathit{x}})~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}array.init\_elem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
 \qquad
{\mathrm{unpack}}({\mathit{zt}}) = {\mathit{numtype}} \lor {\mathrm{unpack}}({\mathit{zt}}) = {\mathit{vectype}}
 \qquad
{\mathit{C}}.\mathsf{datas}{}[{\mathit{y}}] = \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}} : (\mathsf{ref}~\mathsf{null}~{\mathit{x}})~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}array.init\_data}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{extern.convert\_any} : (\mathsf{ref}~{\mathit{nul}}~\mathsf{any}) \rightarrow (\mathsf{ref}~{\mathit{nul}}~\mathsf{extern})
} \, {[\textsc{\scriptsize T{-}extern.convert\_any}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{any.convert\_extern} : (\mathsf{ref}~{\mathit{nul}}~\mathsf{extern}) \rightarrow (\mathsf{ref}~{\mathit{nul}}~\mathsf{any})
} \, {[\textsc{\scriptsize T{-}any.convert\_extern}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}} : \epsilon \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vconst}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{v{\scriptstyle128}} . {\mathit{vvunop}} : \mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vvunop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{v{\scriptstyle128}} . {\mathit{vvbinop}} : \mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vvbinop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{v{\scriptstyle128}} . {\mathit{vvternop}} : \mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vvternop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{v{\scriptstyle128}} . {\mathit{vvtestop}} : \mathsf{v{\scriptstyle128}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}vvtestop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}} . {\mathit{vunop}}_{{\mathit{sh}}} : \mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vunop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}} . {\mathit{vbinop}}_{{\mathit{sh}}} : \mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vbinop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}} . {\mathit{vtestop}}_{{\mathit{sh}}} : \mathsf{v{\scriptstyle128}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}vtestop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}} . {\mathit{vrelop}}_{{\mathit{sh}}} : \mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vrelop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}} . {\mathit{vshiftop}}_{{\mathit{sh}}} : \mathsf{v{\scriptstyle128}}~\mathsf{i{\scriptstyle32}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vshiftop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}}.\mathsf{bitmask} : \mathsf{v{\scriptstyle128}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}vbitmask}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}}.\mathsf{swizzle} : \mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vswizzle}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{i}} < 2 \cdot {\mathrm{dim}}({\mathit{sh}}))^\ast
}{
{\mathit{C}} \vdash {\mathit{sh}}.\mathsf{shuffle}~{{\mathit{i}}^\ast} : \mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vshuffle}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}}.\mathsf{splat} : {\mathrm{unpack}}({\mathit{sh}}) \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vsplat}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{i}} < {\mathrm{dim}}({\mathit{sh}})
}{
{\mathit{C}} \vdash {{\mathit{sh}}.\mathsf{extract\_lane\_}}{{{\mathit{sx}}^?}}~{\mathit{i}} : \mathsf{v{\scriptstyle128}} \rightarrow {\mathrm{unpack}}({\mathit{sh}})
} \, {[\textsc{\scriptsize T{-}vextract\_lane}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{i}} < {\mathrm{dim}}({\mathit{sh}})
}{
{\mathit{C}} \vdash {\mathit{sh}}.\mathsf{replace\_lane}~{\mathit{i}} : \mathsf{v{\scriptstyle128}}~{\mathrm{unpack}}({\mathit{sh}}) \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vreplace\_lane}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}}_{{1}} . {{{{{\mathit{vextunop}}}{\mathsf{\_}}}{{\mathit{sh}}_{{2}}}}{\mathsf{\_}}}{{\mathit{sx}}} : \mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vextunop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}}_{{1}} . {{{{{\mathit{vextbinop}}}{\mathsf{\_}}}{{\mathit{sh}}_{{2}}}}{\mathsf{\_}}}{{\mathit{sx}}} : \mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vextbinop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {{{{{\mathit{sh}}_{{1}}.\mathsf{narrow}}{\mathsf{\_}}}{{\mathit{sh}}_{{2}}}}{\mathsf{\_}}}{{\mathit{sx}}} : \mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vnarrow}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}}_{{1}} . {{{{{{{{{\mathit{vcvtop}}}{\mathsf{\_}}}{{{\mathit{hf}}^?}}}{\mathsf{\_}}}{{\mathit{sh}}_{{2}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}}{\mathsf{\_}}}{{{\mathit{zero}}^?}} : \mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vcvtop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{locals}{}[{\mathit{x}}] = \mathsf{set}~{\mathit{t}}
}{
{\mathit{C}} \vdash \mathsf{local.get}~{\mathit{x}} : \epsilon \rightarrow {\mathit{t}}
} \, {[\textsc{\scriptsize T{-}local.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{locals}{}[{\mathit{x}}] = {\mathit{init}}~{\mathit{t}}
}{
{\mathit{C}} \vdash \mathsf{local.set}~{\mathit{x}} : {\mathit{t}}~{\rightarrow}_{{\mathit{x}}}\,\epsilon
} \, {[\textsc{\scriptsize T{-}local.set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{locals}{}[{\mathit{x}}] = {\mathit{init}}~{\mathit{t}}
}{
{\mathit{C}} \vdash \mathsf{local.tee}~{\mathit{x}} : {\mathit{t}}~{\rightarrow}_{{\mathit{x}}}\,{\mathit{t}}
} \, {[\textsc{\scriptsize T{-}local.tee}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{globals}{}[{\mathit{x}}] = {\mathit{mut}}~{\mathit{t}}
}{
{\mathit{C}} \vdash \mathsf{global.get}~{\mathit{x}} : \epsilon \rightarrow {\mathit{t}}
} \, {[\textsc{\scriptsize T{-}global.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{globals}{}[{\mathit{x}}] = \mathsf{mut}~{\mathit{t}}
}{
{\mathit{C}} \vdash \mathsf{global.set}~{\mathit{x}} : {\mathit{t}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}global.set}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{tables}{}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{table.get}~{\mathit{x}} : \mathsf{i{\scriptstyle32}} \rightarrow {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}table.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{tables}{}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{table.set}~{\mathit{x}} : \mathsf{i{\scriptstyle32}}~{\mathit{rt}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{tables}{}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{table.size}~{\mathit{x}} : \epsilon \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}table.size}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{tables}{}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{table.grow}~{\mathit{x}} : {\mathit{rt}}~\mathsf{i{\scriptstyle32}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}table.grow}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{tables}{}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{table.fill}~{\mathit{x}} : \mathsf{i{\scriptstyle32}}~{\mathit{rt}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.fill}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{tables}{}[{\mathit{x}}_{{1}}] = {\mathit{lim}}_{{1}}~{\mathit{rt}}_{{1}}
 \qquad
{\mathit{C}}.\mathsf{tables}{}[{\mathit{x}}_{{2}}] = {\mathit{lim}}_{{2}}~{\mathit{rt}}_{{2}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} \leq {\mathit{rt}}_{{1}}
}{
{\mathit{C}} \vdash \mathsf{table.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.copy}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{tables}{}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}_{{1}}
 \qquad
{\mathit{C}}.\mathsf{elems}{}[{\mathit{y}}] = {\mathit{rt}}_{{2}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} \leq {\mathit{rt}}_{{1}}
}{
{\mathit{C}} \vdash \mathsf{table.init}~{\mathit{x}}~{\mathit{y}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.init}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{elems}{}[{\mathit{x}}] = {\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{elem.drop}~{\mathit{x}} : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}elem.drop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mems}{}[{\mathit{x}}] = {\mathit{mt}}
}{
{\mathit{C}} \vdash \mathsf{memory.size}~{\mathit{x}} : \epsilon \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}memory.size}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mems}{}[{\mathit{x}}] = {\mathit{mt}}
}{
{\mathit{C}} \vdash \mathsf{memory.grow}~{\mathit{x}} : \mathsf{i{\scriptstyle32}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}memory.grow}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mems}{}[{\mathit{x}}] = {\mathit{mt}}
}{
{\mathit{C}} \vdash \mathsf{memory.fill}~{\mathit{x}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}memory.fill}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mems}{}[{\mathit{x}}_{{1}}] = {\mathit{mt}}_{{1}}
 \qquad
{\mathit{C}}.\mathsf{mems}{}[{\mathit{x}}_{{2}}] = {\mathit{mt}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}memory.copy}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mems}{}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{\mathit{C}}.\mathsf{datas}{}[{\mathit{y}}] = \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{memory.init}~{\mathit{x}}~{\mathit{y}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}memory.init}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{datas}{}[{\mathit{x}}] = \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{data.drop}~{\mathit{x}} : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}data.drop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mems}{}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{2^{{\mathit{memop}}.\mathsf{align}}} \leq {|{\mathit{nt}}|} / 8
 \qquad
({2^{{\mathit{memop}}.\mathsf{align}}} \leq {\mathit{n}} / 8 < {|{\mathit{nt}}|} / 8)^?
 \qquad
{{\mathit{n}}^?} = \epsilon \lor {\mathit{nt}} = {\mathsf{i}}{{\mathit{n}}}
}{
{\mathit{C}} \vdash {{\mathit{nt}}.\mathsf{load}}{{({{{\mathit{n}}}{\mathsf{\_}}}{{\mathit{sx}}})^?}}~{\mathit{x}}~{\mathit{memop}} : \mathsf{i{\scriptstyle32}} \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}load}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mems}{}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{2^{{\mathit{memop}}.\mathsf{align}}} \leq {|{\mathit{nt}}|} / 8
 \qquad
({2^{{\mathit{memop}}.\mathsf{align}}} \leq {\mathit{n}} / 8 < {|{\mathit{nt}}|} / 8)^?
 \qquad
{{\mathit{n}}^?} = \epsilon \lor {\mathit{nt}} = {\mathsf{i}}{{\mathit{n}}}
}{
{\mathit{C}} \vdash {{\mathit{nt}}.\mathsf{store}}{{{\mathit{n}}^?}}~{\mathit{x}}~{\mathit{memop}} : \mathsf{i{\scriptstyle32}}~{\mathit{nt}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}store}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mems}{}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{2^{{\mathit{memop}}.\mathsf{align}}} \leq {\mathit{M}} / 8 \cdot {\mathit{N}}
}{
{\mathit{C}} \vdash {\mathsf{v{\scriptstyle128}.load}}{{{{{\mathsf{shape}}{{\mathit{M}}}}{\mathsf{x}}}{{\mathit{N}}}}{{\mathit{sx}}}}~{\mathit{x}}~{\mathit{memop}} : \mathsf{i{\scriptstyle32}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vload}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mems}{}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{2^{{\mathit{memop}}.\mathsf{align}}} \leq {\mathit{n}} / 8
}{
{\mathit{C}} \vdash {\mathsf{v{\scriptstyle128}.load}}{{\mathsf{splat}}{{\mathit{n}}}}~{\mathit{x}}~{\mathit{memop}} : \mathsf{i{\scriptstyle32}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vload{-}splat}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mems}{}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{2^{{\mathit{memop}}.\mathsf{align}}} < {\mathit{n}} / 8
}{
{\mathit{C}} \vdash {\mathsf{v{\scriptstyle128}.load}}{{\mathsf{zero}}{{\mathit{n}}}}~{\mathit{x}}~{\mathit{memop}} : \mathsf{i{\scriptstyle32}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vload{-}zero}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mems}{}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{2^{{\mathit{memop}}.\mathsf{align}}} < {\mathit{n}} / 8
 \qquad
{\mathit{laneidx}} < 128 / {\mathit{n}}
}{
{\mathit{C}} \vdash {{{\mathsf{v{\scriptstyle128}.load}}{{\mathit{n}}}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~{\mathit{memop}}~{\mathit{laneidx}} : \mathsf{i{\scriptstyle32}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vload\_lane}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mems}{}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{2^{{\mathit{memop}}.\mathsf{align}}} \leq {|\mathsf{v{\scriptstyle128}}|} / 8
}{
{\mathit{C}} \vdash \mathsf{v{\scriptstyle128}.store}~{\mathit{x}}~{\mathit{memop}} : \mathsf{i{\scriptstyle32}}~\mathsf{v{\scriptstyle128}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}vstore}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mems}{}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{2^{{\mathit{memop}}.\mathsf{align}}} < {\mathit{n}} / 8
 \qquad
{\mathit{laneidx}} < 128 / {\mathit{n}}
}{
{\mathit{C}} \vdash {{{\mathsf{v{\scriptstyle128}.store}}{{\mathit{n}}}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~{\mathit{memop}}~{\mathit{laneidx}} : \mathsf{i{\scriptstyle32}}~\mathsf{v{\scriptstyle128}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}vstore\_lane}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{instr}}~\mathsf{const}}$

$\boxed{{\mathit{context}} \vdash {\mathit{expr}}~\mathsf{const}}$

$\boxed{{\mathit{context}} \vdash {\mathit{expr}} : {\mathit{valtype}}~\mathsf{const}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{\mathit{nt}}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}const}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash ({\mathit{vt}}.\mathsf{const}~{\mathit{c}}_{{\mathit{vt}}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}vconst}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash (\mathsf{ref.null}~{\mathit{ht}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}ref.null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash (\mathsf{ref.i{\scriptstyle31}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}ref.i31}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash (\mathsf{ref.func}~{\mathit{x}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}ref.func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash (\mathsf{struct.new}~{\mathit{x}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}struct.new}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash (\mathsf{struct.new\_default}~{\mathit{x}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}struct.new\_default}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash (\mathsf{array.new}~{\mathit{x}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}array.new}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash (\mathsf{array.new\_default}~{\mathit{x}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}array.new\_default}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash (\mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}array.new\_fixed}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash (\mathsf{any.convert\_extern})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}any.convert\_extern}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash (\mathsf{extern.convert\_any})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}extern.convert\_any}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{globals}{}[{\mathit{x}}] = {\mathit{t}}
}{
{\mathit{C}} \vdash (\mathsf{global.get}~{\mathit{x}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}global.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{nt}} \in {\mathit{epsilon}} &=& \mathsf{false} \\
{\mathit{nt}} \in {\mathit{nt}}_{{1}}~{{\mathit{nt}'}^\ast} &=& {\mathit{nt}} = {\mathit{nt}}_{{1}} \lor {\mathit{nt}} \in {{\mathit{nt}'}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{binop}} \in {\mathit{epsilon}} &=& \mathsf{false} \\
{\mathit{binop}} \in ({\mathit{ibinop}}_{{1}})~{{\mathit{ibinop}'}^\ast} &=& {\mathit{binop}} = {\mathit{ibinop}}_{{1}} \lor {\mathit{binop}} \in {{\mathit{ibinop}'}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathsf{i}}{{\mathit{n}}} \in \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle64}}
 \qquad
{\mathit{binop}} \in \mathsf{add}~\mathsf{sub}~\mathsf{mul}
}{
{\mathit{C}} \vdash ({\mathsf{i}}{{\mathit{n}}} . {\mathit{binop}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}binop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{C}} \vdash {\mathit{instr}}~\mathsf{const})^\ast
}{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast}~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}expr}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{expr}} : {\mathit{t}}
 \qquad
{\mathit{C}} \vdash {\mathit{expr}}~\mathsf{const}
}{
{\mathit{C}} \vdash {\mathit{expr}} : {\mathit{t}}~\mathsf{const}
} \, {[\textsc{\scriptsize TC{-}expr}]}
\qquad
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{type}} : {{\mathit{deftype}}^\ast}}$

$\boxed{{\mathit{context}} \vdash {\mathit{func}} : {\mathit{deftype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{local}} : {\mathit{localtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{global}} : {\mathit{globaltype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{table}} : {\mathit{tabletype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{mem}} : {\mathit{memtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{elem}} : {\mathit{reftype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{data}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{elemmode}} : {\mathit{reftype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{datamode}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{start}} : \mathsf{ok}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{x}} = {|{\mathit{C}}.\mathsf{types}|}
 \qquad
{{\mathit{dt}}^\ast} = {{\mathrm{roll}}}_{{\mathit{x}}}({\mathit{rectype}})
 \qquad
{\mathit{C}}{}[\mathsf{types} = ..{{\mathit{dt}}^\ast}] \vdash {\mathit{rectype}} : {\mathsf{ok}}{({\mathit{x}})}
}{
{\mathit{C}} \vdash \mathsf{type}~{\mathit{rectype}} : {{\mathit{dt}}^\ast}
} \, {[\textsc{\scriptsize T{-}type}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{{\mathrm{default}}}_{{\mathit{t}}} \neq \epsilon
}{
{\mathit{C}} \vdash \mathsf{local}~{\mathit{t}} : \mathsf{set}~{\mathit{t}}
} \, {[\textsc{\scriptsize T{-}local{-}set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{{\mathrm{default}}}_{{\mathit{t}}} = \epsilon
}{
{\mathit{C}} \vdash \mathsf{local}~{\mathit{t}} : \mathsf{unset}~{\mathit{t}}
} \, {[\textsc{\scriptsize T{-}local{-}unset}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
 \qquad
({\mathit{C}} \vdash {\mathit{local}} : {{\mathit{lt}}})^\ast
 \qquad
{\mathit{C}}, \mathsf{locals}~{(\mathsf{set}~{\mathit{t}}_{{1}})^\ast}~{{{\mathit{lt}}}^\ast}, \mathsf{labels}~({{\mathit{t}}_{{2}}^\ast}), \mathsf{return}~({{\mathit{t}}_{{2}}^\ast}) \vdash {\mathit{expr}} : {{\mathit{t}}_{{2}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{func}~{\mathit{x}}~{{\mathit{local}}^\ast}~{\mathit{expr}} : {\mathit{C}}.\mathsf{types}{}[{\mathit{x}}]
} \, {[\textsc{\scriptsize T{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{gt}} : \mathsf{ok}
 \qquad
{\mathit{gt}} = {\mathit{mut}}~{\mathit{t}}
 \qquad
{\mathit{C}} \vdash {\mathit{expr}} : {\mathit{t}}~\mathsf{const}
}{
{\mathit{C}} \vdash \mathsf{global}~{\mathit{gt}}~{\mathit{expr}} : {\mathit{gt}}
} \, {[\textsc{\scriptsize T{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{tt}} : \mathsf{ok}
 \qquad
{\mathit{tt}} = {\mathit{limits}}~{\mathit{rt}}
 \qquad
{\mathit{C}} \vdash {\mathit{expr}} : {\mathit{rt}}~\mathsf{const}
}{
{\mathit{C}} \vdash \mathsf{table}~{\mathit{tt}}~{\mathit{expr}} : {\mathit{tt}}
} \, {[\textsc{\scriptsize T{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{mt}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{memory}~{\mathit{mt}} : {\mathit{mt}}
} \, {[\textsc{\scriptsize T{-}mem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{C}} \vdash {\mathit{expr}} : {\mathit{rt}}~\mathsf{const})^\ast
 \qquad
{\mathit{C}} \vdash {\mathit{elemmode}} : {\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{elem}~{\mathit{rt}}~{{\mathit{expr}}^\ast}~{\mathit{elemmode}} : {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}elem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{datamode}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{data}~{{\mathit{b}}^\ast}~{\mathit{datamode}} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}data}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{tables}{}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
 \qquad
({\mathit{C}} \vdash {\mathit{expr}} : \mathsf{i{\scriptstyle32}}~\mathsf{const})^\ast
}{
{\mathit{C}} \vdash \mathsf{active}~{\mathit{x}}~{\mathit{expr}} : {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}elemmode{-}active}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{passive} : {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}elemmode{-}passive}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{declare} : {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}elemmode{-}declare}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mems}{}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
({\mathit{C}} \vdash {\mathit{expr}} : \mathsf{i{\scriptstyle32}}~\mathsf{const})^\ast
}{
{\mathit{C}} \vdash \mathsf{active}~{\mathit{x}}~{\mathit{expr}} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}datamode{-}active}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{passive} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}datamode{-}passive}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{funcs}{}[{\mathit{x}}] \approx \mathsf{func}~(\epsilon \rightarrow \epsilon)
}{
{\mathit{C}} \vdash \mathsf{start}~{\mathit{x}} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}start}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{import}} : {\mathit{externtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{export}} : {\mathit{externtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{externidx}} : {\mathit{externtype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{xt}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{import}~{\mathit{name}}_{{1}}~{\mathit{name}}_{{2}}~{\mathit{xt}} : {\mathit{xt}}
} \, {[\textsc{\scriptsize T{-}import}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{externidx}} : {\mathit{xt}}
}{
{\mathit{C}} \vdash \mathsf{export}~{\mathit{name}}~{\mathit{externidx}} : {\mathit{xt}}
} \, {[\textsc{\scriptsize T{-}export}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{funcs}{}[{\mathit{x}}] = {\mathit{dt}}
}{
{\mathit{C}} \vdash \mathsf{func}~{\mathit{x}} : \mathsf{func}~{\mathit{dt}}
} \, {[\textsc{\scriptsize T{-}externidx{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{globals}{}[{\mathit{x}}] = {\mathit{gt}}
}{
{\mathit{C}} \vdash \mathsf{global}~{\mathit{x}} : \mathsf{global}~{\mathit{gt}}
} \, {[\textsc{\scriptsize T{-}externidx{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{tables}{}[{\mathit{x}}] = {\mathit{tt}}
}{
{\mathit{C}} \vdash \mathsf{table}~{\mathit{x}} : \mathsf{table}~{\mathit{tt}}
} \, {[\textsc{\scriptsize T{-}externidx{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mems}{}[{\mathit{x}}] = {\mathit{mt}}
}{
{\mathit{C}} \vdash \mathsf{mem}~{\mathit{x}} : \mathsf{mem}~{\mathit{mt}}
} \, {[\textsc{\scriptsize T{-}externidx{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{ \vdash }\;{\mathit{module}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {{\mathit{type}}^\ast} : {{\mathit{deftype}}^\ast}}$

$\boxed{{\mathit{context}} \vdash {{\mathit{global}}^\ast} : {{\mathit{globaltype}}^\ast}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\begin{array}{@{}c@{}}
\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {{\mathit{type}}^\ast} : {{\mathit{dt}'}^\ast}
 \qquad
(\{ \begin{array}[t]{@{}l@{}}
\mathsf{types}~{{\mathit{dt}'}^\ast} \}\end{array} \vdash {\mathit{import}} : {\mathit{ixt}})^\ast
 \\
{\mathit{C}'} \vdash {{\mathit{global}}^\ast} : {{\mathit{gt}}^\ast}
 \qquad
({\mathit{C}'} \vdash {\mathit{table}} : {\mathit{tt}})^\ast
 \qquad
({\mathit{C}'} \vdash {\mathit{mem}} : {\mathit{mt}})^\ast
 \qquad
({\mathit{C}} \vdash {\mathit{func}} : {\mathit{dt}})^\ast
 \\
({\mathit{C}} \vdash {\mathit{elem}} : {\mathit{rt}})^\ast
 \qquad
({\mathit{C}} \vdash {\mathit{data}} : \mathsf{ok})^{{\mathit{n}}}
 \qquad
({\mathit{C}} \vdash {\mathit{start}} : \mathsf{ok})^?
 \qquad
({\mathit{C}} \vdash {\mathit{export}} : {\mathit{xt}})^\ast
 \\
{\mathit{C}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{types}~{{\mathit{dt}'}^\ast},\; \mathsf{funcs}~{{\mathit{idt}}^\ast}~{{\mathit{dt}}^\ast},\; \mathsf{globals}~{{\mathit{igt}}^\ast}~{{\mathit{gt}}^\ast},\; \mathsf{tables}~{{\mathit{itt}}^\ast}~{{\mathit{tt}}^\ast},\; \mathsf{mems}~{{\mathit{imt}}^\ast}~{{\mathit{mt}}^\ast},\; \mathsf{elems}~{{\mathit{rt}}^\ast},\; \mathsf{datas}~{\mathsf{ok}^{{\mathit{n}}}} \}\end{array}
 \\
{\mathit{C}'} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{types}~{{\mathit{dt}'}^\ast},\; \mathsf{funcs}~{{\mathit{idt}}^\ast}~{{\mathit{dt}}^\ast},\; \mathsf{globals}~{{\mathit{igt}}^\ast} \}\end{array}
 \\
{{\mathit{idt}}^\ast} = {\mathrm{funcs}}({{\mathit{ixt}}^\ast})
 \qquad
{{\mathit{igt}}^\ast} = {\mathrm{globals}}({{\mathit{ixt}}^\ast})
 \qquad
{{\mathit{itt}}^\ast} = {\mathrm{tables}}({{\mathit{ixt}}^\ast})
 \qquad
{{\mathit{imt}}^\ast} = {\mathrm{mems}}({{\mathit{ixt}}^\ast})
\end{array}
}{
{ \vdash }\;\mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^{{\mathit{n}}}}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}module}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \epsilon : \epsilon
} \, {[\textsc{\scriptsize T{-}types{-}empty}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{type}}_{{1}} : {\mathit{dt}}_{{1}}
 \qquad
{\mathit{C}}{}[\mathsf{types} = ..{{\mathit{dt}}_{{1}}^\ast}] \vdash {{\mathit{type}}^\ast} : {{\mathit{dt}}^\ast}
}{
{\mathit{C}} \vdash {\mathit{type}}_{{1}}~{{\mathit{type}}^\ast} : {{\mathit{dt}}_{{1}}^\ast}~{{\mathit{dt}}^\ast}
} \, {[\textsc{\scriptsize T{-}types{-}cons}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \epsilon : \epsilon
} \, {[\textsc{\scriptsize T{-}globals{-}empty}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{global}} : {\mathit{gt}}_{{1}}
 \qquad
{\mathit{C}}{}[\mathsf{globals} = ..{\mathit{gt}}_{{1}}] \vdash {{\mathit{global}}^\ast} : {{\mathit{gt}}^\ast}
}{
{\mathit{C}} \vdash {\mathit{global}}_{{1}}~{{\mathit{global}}^\ast} : {\mathit{gt}}_{{1}}~{{\mathit{gt}}^\ast}
} \, {[\textsc{\scriptsize T{-}globals{-}cons}]}
\qquad
\end{array}
$$

$\boxed{{\mathit{store}} \vdash {\mathit{ref}} : {\mathit{reftype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{s}} \vdash \mathsf{ref.null}~{\mathit{ht}} : (\mathsf{ref}~\mathsf{null}~{\mathit{ht}})
} \, {[\textsc{\scriptsize Ref\_ok{-}null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{s}} \vdash \mathsf{ref.i{\scriptstyle31}}~{\mathit{i}} : (\mathsf{ref}~\epsilon~\mathsf{i{\scriptstyle31}})
} \, {[\textsc{\scriptsize Ref\_ok{-}i31}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{s}}.\mathsf{structs}{}[{\mathit{a}}].\mathsf{type} = {\mathit{dt}}
}{
{\mathit{s}} \vdash \mathsf{ref.struct}~{\mathit{a}} : (\mathsf{ref}~\epsilon~{\mathit{dt}})
} \, {[\textsc{\scriptsize Ref\_ok{-}struct}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{s}}.\mathsf{arrays}{}[{\mathit{a}}].\mathsf{type} = {\mathit{dt}}
}{
{\mathit{s}} \vdash \mathsf{ref.array}~{\mathit{a}} : (\mathsf{ref}~\epsilon~{\mathit{dt}})
} \, {[\textsc{\scriptsize Ref\_ok{-}array}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{s}}.\mathsf{funcs}{}[{\mathit{a}}].\mathsf{type} = {\mathit{dt}}
}{
{\mathit{s}} \vdash \mathsf{ref.func}~{\mathit{a}} : (\mathsf{ref}~\epsilon~{\mathit{dt}})
} \, {[\textsc{\scriptsize Ref\_ok{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{s}} \vdash \mathsf{ref.host}~{\mathit{a}} : (\mathsf{ref}~\epsilon~\mathsf{any})
} \, {[\textsc{\scriptsize Ref\_ok{-}host}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{s}} \vdash \mathsf{ref.extern}~{\mathit{addrref}} : (\mathsf{ref}~\epsilon~\mathsf{extern})
} \, {[\textsc{\scriptsize Ref\_ok{-}extern}]}
\qquad
\end{array}
$$

$\boxed{{\mathit{config}} \hookrightarrow {\mathit{config}}}$

$\boxed{{{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}}^\ast}}$

$\boxed{{\mathit{config}} \hookrightarrow {{\mathit{instr}}^\ast}}$

$\boxed{{\mathit{config}} \hookrightarrow^\ast {\mathit{config}}}$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}pure}]} \quad & {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow& {\mathit{z}} ; {{\mathit{instr}'}^\ast}
  &\qquad \mbox{if}~{{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\
{[\textsc{\scriptsize E{-}read}]} \quad & {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow& {\mathit{z}} ; {{\mathit{instr}'}^\ast}
  &\qquad \mbox{if}~{\mathit{z}} ; {{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}refl}]} \quad & {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow^\ast& {\mathit{z}} ; {{\mathit{instr}}^\ast} \\
{[\textsc{\scriptsize E{-}trans}]} \quad & {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow^\ast& {\mathit{z}''} ; {{{\mathit{instr}}''}^\ast}
  &\qquad \mbox{if}~{\mathit{z}} ; {{\mathit{instr}}^\ast} \hookrightarrow {\mathit{z}'} ; {{{\mathit{instr}}'}^\ast} \\
  &&&&\qquad {\land}~{\mathit{z}'} ; {{\mathit{instr}}'} \hookrightarrow^\ast {\mathit{z}''} ; {{{\mathit{instr}}''}^\ast} \\
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{state}} ; {\mathit{expr}} \hookrightarrow^\ast {\mathit{state}} ; {{\mathit{val}}^\ast}}$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}expr}]} \quad & {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow^\ast& {\mathit{z}'} ; {{\mathit{val}}^\ast}
  &\qquad \mbox{if}~{\mathit{z}} ; {{\mathit{instr}}^\ast} \hookrightarrow^\ast {\mathit{z}'} ; {{\mathit{val}}^\ast} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}unreachable}]} \quad & \mathsf{unreachable} &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}nop}]} \quad & \mathsf{nop} &\hookrightarrow& \epsilon \\
{[\textsc{\scriptsize E{-}drop}]} \quad & {\mathit{val}}~\mathsf{drop} &\hookrightarrow& \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}select{-}true}]} \quad & {\mathit{val}}_{{1}}~{\mathit{val}}_{{2}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{select}~{{{\mathit{t}}^\ast}^?}) &\hookrightarrow& {\mathit{val}}_{{1}}
  &\qquad \mbox{if}~{\mathit{c}} \neq 0 \\
{[\textsc{\scriptsize E{-}select{-}false}]} \quad & {\mathit{val}}_{{1}}~{\mathit{val}}_{{2}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{select}~{{{\mathit{t}}^\ast}^?}) &\hookrightarrow& {\mathit{val}}_{{2}}
  &\qquad \mbox{if}~{\mathit{c}} = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{blocktype}}}_{{\mathit{z}}}(\epsilon) &=& \epsilon \rightarrow \epsilon \\
{{\mathrm{blocktype}}}_{{\mathit{z}}}({\mathit{t}}) &=& \epsilon \rightarrow {\mathit{t}} \\
{{\mathrm{blocktype}}}_{{\mathit{z}}}({\mathit{x}}) &=& {\mathit{ft}}
  &\qquad \mbox{if}~{\mathit{z}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{func}~{\mathit{ft}} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}block}]} \quad & {\mathit{z}} ; {{\mathit{val}}^{{\mathit{m}}}}~(\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{{\mathit{n}}}}{\{\epsilon\}}~{{\mathit{val}}^{{\mathit{m}}}}~{{\mathit{instr}}^\ast})
  &\qquad \mbox{if}~{{\mathrm{blocktype}}}_{{\mathit{z}}}({\mathit{bt}}) = {{\mathit{t}}_{{1}}^{{\mathit{m}}}} \rightarrow {{\mathit{t}}_{{2}}^{{\mathit{n}}}} \\
{[\textsc{\scriptsize E{-}loop}]} \quad & {\mathit{z}} ; {{\mathit{val}}^{{\mathit{m}}}}~(\mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{{\mathit{m}}}}{\{\mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast}\}}~{{\mathit{val}}^{{\mathit{m}}}}~{{\mathit{instr}}^\ast})
  &\qquad \mbox{if}~{{\mathrm{blocktype}}}_{{\mathit{z}}}({\mathit{bt}}) = {{\mathit{t}}_{{1}}^{{\mathit{m}}}} \rightarrow {{\mathit{t}}_{{2}}^{{\mathit{n}}}} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}if{-}true}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_{{1}}^\ast}~\mathsf{else}~{{\mathit{instr}}_{{2}}^\ast}) &\hookrightarrow& (\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}_{{1}}^\ast})
  &\qquad \mbox{if}~{\mathit{c}} \neq 0 \\
{[\textsc{\scriptsize E{-}if{-}false}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_{{1}}^\ast}~\mathsf{else}~{{\mathit{instr}}_{{2}}^\ast}) &\hookrightarrow& (\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}_{{2}}^\ast})
  &\qquad \mbox{if}~{\mathit{c}} = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}label{-}vals}]} \quad & ({{\mathsf{label}}_{{\mathit{n}}}}{\{{{\mathit{instr}}^\ast}\}}~{{\mathit{val}}^\ast}) &\hookrightarrow& {{\mathit{val}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}br{-}zero}]} \quad & ({{\mathsf{label}}_{{\mathit{n}}}}{\{{{\mathit{instr}'}^\ast}\}}~{{\mathit{val}'}^\ast}~{{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{br}~{\mathit{l}})~{{\mathit{instr}}^\ast}) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}}~{{\mathit{instr}'}^\ast}
  &\qquad \mbox{if}~{\mathit{l}} = 0 \\
{[\textsc{\scriptsize E{-}br{-}succ}]} \quad & ({{\mathsf{label}}_{{\mathit{n}}}}{\{{{\mathit{instr}'}^\ast}\}}~{{\mathit{val}}^\ast}~(\mathsf{br}~{\mathit{l}})~{{\mathit{instr}}^\ast}) &\hookrightarrow& {{\mathit{val}}^\ast}~(\mathsf{br}~{\mathit{l}} - 1)
  &\qquad \mbox{if}~{\mathit{l}} > 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_if{-}true}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{br\_if}~{\mathit{l}}) &\hookrightarrow& (\mathsf{br}~{\mathit{l}})
  &\qquad \mbox{if}~{\mathit{c}} \neq 0 \\
{[\textsc{\scriptsize E{-}br\_if{-}false}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{br\_if}~{\mathit{l}}) &\hookrightarrow& \epsilon
  &\qquad \mbox{if}~{\mathit{c}} = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_table{-}lt}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{br\_table}~{{\mathit{l}}^\ast}~{\mathit{l}'}) &\hookrightarrow& (\mathsf{br}~{{\mathit{l}}^\ast}{}[{\mathit{i}}])
  &\qquad \mbox{if}~{\mathit{i}} < {|{{\mathit{l}}^\ast}|} \\
{[\textsc{\scriptsize E{-}br\_table{-}ge}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{br\_table}~{{\mathit{l}}^\ast}~{\mathit{l}'}) &\hookrightarrow& (\mathsf{br}~{\mathit{l}'})
  &\qquad \mbox{if}~{\mathit{i}} \geq {|{{\mathit{l}}^\ast}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_null{-}null}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_null}~{\mathit{l}}) &\hookrightarrow& (\mathsf{br}~{\mathit{l}})
  &\qquad \mbox{if}~{\mathit{val}} = \mathsf{ref.null}~{\mathit{ht}} \\
{[\textsc{\scriptsize E{-}br\_on\_null{-}addr}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_null}~{\mathit{l}}) &\hookrightarrow& {\mathit{val}}
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_non\_null{-}null}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_non\_null}~{\mathit{l}}) &\hookrightarrow& \epsilon
  &\qquad \mbox{if}~{\mathit{val}} = \mathsf{ref.null}~{\mathit{ht}} \\
{[\textsc{\scriptsize E{-}br\_on\_non\_null{-}addr}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_non\_null}~{\mathit{l}}) &\hookrightarrow& {\mathit{val}}~(\mathsf{br}~{\mathit{l}})
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_cast{-}succeed}]} \quad & {\mathit{s}} ; {\mathit{f}} ; {\mathit{ref}}~(\mathsf{br\_on\_cast}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}}) &\hookrightarrow& {\mathit{ref}}~(\mathsf{br}~{\mathit{l}})
  &\qquad \mbox{if}~{\mathit{s}} \vdash {\mathit{ref}} : {\mathit{rt}} \\
  &&&&\qquad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}} \leq {{\mathrm{inst}}}_{{\mathit{f}}.\mathsf{module}}({\mathit{rt}}_{{2}}) \\
{[\textsc{\scriptsize E{-}br\_on\_cast{-}fail}]} \quad & {\mathit{s}} ; {\mathit{f}} ; {\mathit{ref}}~(\mathsf{br\_on\_cast}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}}) &\hookrightarrow& {\mathit{ref}}
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_cast\_fail{-}succeed}]} \quad & {\mathit{s}} ; {\mathit{f}} ; {\mathit{ref}}~(\mathsf{br\_on\_cast\_fail}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}}) &\hookrightarrow& {\mathit{ref}}
  &\qquad \mbox{if}~{\mathit{s}} \vdash {\mathit{ref}} : {\mathit{rt}} \\
  &&&&\qquad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}} \leq {{\mathrm{inst}}}_{{\mathit{f}}.\mathsf{module}}({\mathit{rt}}_{{2}}) \\
{[\textsc{\scriptsize E{-}br\_on\_cast\_fail{-}fail}]} \quad & {\mathit{s}} ; {\mathit{f}} ; {\mathit{ref}}~(\mathsf{br\_on\_cast\_fail}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}}) &\hookrightarrow& {\mathit{ref}}~(\mathsf{br}~{\mathit{l}})
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}call}]} \quad & {\mathit{z}} ; (\mathsf{call}~{\mathit{x}}) &\hookrightarrow& (\mathsf{ref.func}~{\mathit{a}})~(\mathsf{call\_ref}~{\mathit{z}}.\mathsf{funcs}{}[{\mathit{a}}].\mathsf{type})
  &\qquad \mbox{if}~{\mathit{z}}.\mathsf{module}.\mathsf{funcs}{}[{\mathit{x}}] = {\mathit{a}} \\
{[\textsc{\scriptsize E{-}call\_ref{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{call\_ref}~{{\mathit{y}}}) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}call\_ref{-}func}]} \quad & {\mathit{z}} ; {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{ref.func}~{\mathit{a}})~(\mathsf{call\_ref}~{{\mathit{y}}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ ({{\mathsf{frame}}_{{\mathit{m}}}}{\{{\mathit{f}}\}}~({{\mathsf{label}}_{{\mathit{m}}}}{\{\epsilon\}}~{{\mathit{instr}}^\ast})) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{\mathit{z}}.\mathsf{funcs}{}[{\mathit{a}}] = {\mathit{fi}}} \\
  &&& \multicolumn{2}{l@{}}{\quad {\land}~{\mathit{fi}}.\mathsf{type} \approx \mathsf{func}~({{\mathit{t}}_{{1}}^{{\mathit{n}}}} \rightarrow {{\mathit{t}}_{{2}}^{{\mathit{m}}}})} \\
  &&& \multicolumn{2}{l@{}}{\quad {\land}~{\mathit{fi}}.\mathsf{code} = \mathsf{func}~{\mathit{x}}~{(\mathsf{local}~{\mathit{t}})^\ast}~({{\mathit{instr}}^\ast})} \\
  &&& \multicolumn{2}{l@{}}{\quad {\land}~{\mathit{f}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{locals}~{{\mathit{val}}^{{\mathit{n}}}}~{({{\mathrm{default}}}_{{\mathit{t}}})^\ast},\; \mathsf{module}~{\mathit{fi}}.\mathsf{module} \}\end{array}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}return\_call}]} \quad & {\mathit{z}} ; (\mathsf{return\_call}~{\mathit{x}}) &\hookrightarrow& (\mathsf{ref.func}~{\mathit{a}})~(\mathsf{return\_call\_ref}~{\mathit{z}}.\mathsf{funcs}{}[{\mathit{a}}].\mathsf{type})
  &\qquad \mbox{if}~{\mathit{z}}.\mathsf{module}.\mathsf{funcs}{}[{\mathit{x}}] = {\mathit{a}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}return\_call\_ref{-}label}]} \quad & {\mathit{z}} ; ({{\mathsf{label}}_{{\mathit{k}}}}{\{{{\mathit{instr}'}^\ast}\}}~{{\mathit{val}}^\ast}~(\mathsf{return\_call\_ref}~{{\mathit{y}}})~{{\mathit{instr}}^\ast}) &\hookrightarrow& {{\mathit{val}}^\ast}~(\mathsf{return\_call\_ref}~{{\mathit{y}}}) \\
{[\textsc{\scriptsize E{-}return\_call\_ref{-}frame{-}null}]} \quad & {\mathit{z}} ; ({{\mathsf{frame}}_{{\mathit{k}}}}{\{{\mathit{f}}\}}~{{\mathit{val}}^\ast}~(\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{return\_call\_ref}~{{\mathit{y}}})~{{\mathit{instr}}^\ast}) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}return\_call\_ref{-}frame{-}addr}]} \quad & {\mathit{z}} ; ({{\mathsf{frame}}_{{\mathit{k}}}}{\{{\mathit{f}}\}}~{{\mathit{val}'}^\ast}~{{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{ref.func}~{\mathit{a}})~(\mathsf{return\_call\_ref}~{{\mathit{y}}})~{{\mathit{instr}}^\ast}) &\hookrightarrow& \multicolumn{2}{l@{}}{ {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{ref.func}~{\mathit{a}})~(\mathsf{call\_ref}~{{\mathit{y}}}) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{\mathit{z}}.\mathsf{funcs}{}[{\mathit{a}}].\mathsf{type} \approx \mathsf{func}~({{\mathit{t}}_{{1}}^{{\mathit{n}}}} \rightarrow {{\mathit{t}}_{{2}}^{{\mathit{m}}}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}call\_indirect}]} \quad & (\mathsf{call\_indirect}~{\mathit{x}}~{{\mathit{y}}}) &\hookrightarrow& (\mathsf{table.get}~{\mathit{x}})~(\mathsf{ref.cast}~(\mathsf{ref}~\mathsf{null}~{{\mathit{y}}}))~(\mathsf{call\_ref}~{{\mathit{y}}}) \\
{[\textsc{\scriptsize E{-}return\_call\_indirect}]} \quad & (\mathsf{return\_call\_indirect}~{\mathit{x}}~{{\mathit{y}}}) &\hookrightarrow& (\mathsf{table.get}~{\mathit{x}})~(\mathsf{ref.cast}~(\mathsf{ref}~\mathsf{null}~{{\mathit{y}}}))~(\mathsf{return\_call\_ref}~{{\mathit{y}}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}frame{-}vals}]} \quad & ({{\mathsf{frame}}_{{\mathit{n}}}}{\{{\mathit{f}}\}}~{{\mathit{val}}^{{\mathit{n}}}}) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}} \\
{[\textsc{\scriptsize E{-}return{-}frame}]} \quad & ({{\mathsf{frame}}_{{\mathit{n}}}}{\{{\mathit{f}}\}}~{{\mathit{val}'}^\ast}~{{\mathit{val}}^{{\mathit{n}}}}~\mathsf{return}~{{\mathit{instr}}^\ast}) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}} \\
{[\textsc{\scriptsize E{-}return{-}label}]} \quad & ({{\mathsf{label}}_{{\mathit{n}}}}{\{{{\mathit{instr}'}^\ast}\}}~{{\mathit{val}}^\ast}~\mathsf{return}~{{\mathit{instr}}^\ast}) &\hookrightarrow& {{\mathit{val}}^\ast}~\mathsf{return} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}unop{-}val}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}} . {\mathit{unop}}) &\hookrightarrow& ({\mathit{nt}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{{{\mathit{unop}}}{{}_{{\mathit{nt}}}}}{({\mathit{c}}_{{1}})} = {\mathit{c}} \\
{[\textsc{\scriptsize E{-}unop{-}trap}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}} . {\mathit{unop}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{{{\mathit{unop}}}{{}_{{\mathit{nt}}}}}{({\mathit{c}}_{{1}})} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}binop{-}val}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{2}})~({\mathit{nt}} . {\mathit{binop}}) &\hookrightarrow& ({\mathit{nt}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{{{\mathit{binop}}}{{}_{{\mathit{nt}}}}}{({\mathit{c}}_{{1}},\, {\mathit{c}}_{{2}})} = {\mathit{c}} \\
{[\textsc{\scriptsize E{-}binop{-}trap}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{2}})~({\mathit{nt}} . {\mathit{binop}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{{{\mathit{binop}}}{{}_{{\mathit{nt}}}}}{({\mathit{c}}_{{1}},\, {\mathit{c}}_{{2}})} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}testop}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}} . {\mathit{testop}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{\mathit{c}} = {{{\mathit{testop}}}{{}_{{\mathit{nt}}}}}{({\mathit{c}}_{{1}})} \\
{[\textsc{\scriptsize E{-}relop}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{2}})~({\mathit{nt}} . {\mathit{relop}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{\mathit{c}} = {{{\mathit{relop}}}{{}_{{\mathit{nt}}}}}{({\mathit{c}}_{{1}},\, {\mathit{c}}_{{2}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}cvtop{-}val}]} \quad & ({\mathit{nt}}_{{1}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}}_{{2}} . {{{{{\mathit{cvtop}}}{\mathsf{\_}}}{{\mathit{nt}}_{{1}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}) &\hookrightarrow& ({\mathit{nt}}_{{2}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{{{\mathit{cvtop}}}{{{}_{{\mathit{nt}}_{{1}}, {\mathit{nt}}_{{2}}}^{{{\mathit{sx}}^?}}}}}{({\mathit{c}}_{{1}})} = {\mathit{c}} \\
{[\textsc{\scriptsize E{-}cvtop{-}trap}]} \quad & ({\mathit{nt}}_{{1}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}}_{{2}} . {{{{{\mathit{cvtop}}}{\mathsf{\_}}}{{\mathit{nt}}_{{1}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{{{\mathit{cvtop}}}{{{}_{{\mathit{nt}}_{{1}}, {\mathit{nt}}_{{2}}}^{{{\mathit{sx}}^?}}}}}{({\mathit{c}}_{{1}})} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.null{-}idx}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{x}}) &\hookrightarrow& (\mathsf{ref.null}~{\mathit{z}}.\mathsf{types}{}[{\mathit{x}}]) \\
{[\textsc{\scriptsize E{-}ref.func}]} \quad & {\mathit{z}} ; (\mathsf{ref.func}~{\mathit{x}}) &\hookrightarrow& (\mathsf{ref.func}~{\mathit{z}}.\mathsf{module}.\mathsf{funcs}{}[{\mathit{x}}]) \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.i31}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~\mathsf{ref.i{\scriptstyle31}} &\hookrightarrow& (\mathsf{ref.i{\scriptstyle31}}~{{{\mathrm{wrap}}}_{32, 31}}{({\mathit{i}})}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.is\_null{-}true}]} \quad & {\mathit{ref}}~\mathsf{ref.is\_null} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1)
  &\qquad \mbox{if}~{\mathit{ref}} = (\mathsf{ref.null}~{\mathit{ht}}) \\
{[\textsc{\scriptsize E{-}ref.is\_null{-}false}]} \quad & {\mathit{ref}}~\mathsf{ref.is\_null} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.as\_non\_null{-}null}]} \quad & {\mathit{ref}}~\mathsf{ref.as\_non\_null} &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{\mathit{ref}} = (\mathsf{ref.null}~{\mathit{ht}}) \\
{[\textsc{\scriptsize E{-}ref.as\_non\_null{-}addr}]} \quad & {\mathit{ref}}~\mathsf{ref.as\_non\_null} &\hookrightarrow& {\mathit{ref}}
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.eq{-}null}]} \quad & {\mathit{ref}}_{{1}}~{\mathit{ref}}_{{2}}~\mathsf{ref.eq} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1)
  &\qquad \mbox{if}~{\mathit{ref}}_{{1}} = (\mathsf{ref.null}~{\mathit{ht}}_{{1}}) \land {\mathit{ref}}_{{2}} = (\mathsf{ref.null}~{\mathit{ht}}_{{2}}) \\
{[\textsc{\scriptsize E{-}ref.eq{-}true}]} \quad & {\mathit{ref}}_{{1}}~{\mathit{ref}}_{{2}}~\mathsf{ref.eq} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1)
  &\qquad \mbox{otherwise, if}~{\mathit{ref}}_{{1}} = {\mathit{ref}}_{{2}} \\
{[\textsc{\scriptsize E{-}ref.eq{-}false}]} \quad & {\mathit{ref}}_{{1}}~{\mathit{ref}}_{{2}}~\mathsf{ref.eq} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.test{-}true}]} \quad & {\mathit{s}} ; {\mathit{f}} ; {\mathit{ref}}~(\mathsf{ref.test}~{\mathit{rt}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1)
  &\qquad \mbox{if}~{\mathit{s}} \vdash {\mathit{ref}} : {\mathit{rt}'} \\
  &&&&\qquad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}'} \leq {{\mathrm{inst}}}_{{\mathit{f}}.\mathsf{module}}({\mathit{rt}}) \\
{[\textsc{\scriptsize E{-}ref.test{-}false}]} \quad & {\mathit{s}} ; {\mathit{f}} ; {\mathit{ref}}~(\mathsf{ref.test}~{\mathit{rt}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.cast{-}succeed}]} \quad & {\mathit{s}} ; {\mathit{f}} ; {\mathit{ref}}~(\mathsf{ref.cast}~{\mathit{rt}}) &\hookrightarrow& {\mathit{ref}}
  &\qquad \mbox{if}~{\mathit{s}} \vdash {\mathit{ref}} : {\mathit{rt}'} \\
  &&&&\qquad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}'} \leq {{\mathrm{inst}}}_{{\mathit{f}}.\mathsf{module}}({\mathit{rt}}) \\
{[\textsc{\scriptsize E{-}ref.cast{-}fail}]} \quad & {\mathit{s}} ; {\mathit{f}} ; {\mathit{ref}}~(\mathsf{ref.cast}~{\mathit{rt}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}i31.get{-}null}]} \quad & (\mathsf{ref.null}~{\mathit{ht}})~({{\mathsf{i{\scriptstyle31}.get}}{\mathsf{\_}}}{{\mathit{sx}}}) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}i31.get{-}num}]} \quad & (\mathsf{ref.i{\scriptstyle31}}~{\mathit{i}})~({{\mathsf{i{\scriptstyle31}.get}}{\mathsf{\_}}}{{\mathit{sx}}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{{{{\mathrm{ext}}}_{31, 32}^{{\mathit{sx}}}}}{({\mathit{i}})}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.new}]} \quad & {\mathit{z}} ; {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{struct.new}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}{}[\mathsf{structs} = ..{\mathit{si}}] ; (\mathsf{ref.struct}~{\mathit{a}})
  &\qquad \mbox{if}~{\mathit{z}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{struct}~{({\mathit{mut}}~{\mathit{zt}})^{{\mathit{n}}}} \\
  &&&&\qquad {\land}~{\mathit{a}} = {|{\mathit{z}}.\mathsf{structs}|} \\
  &&&&\qquad {\land}~{\mathit{si}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{z}}.\mathsf{types}{}[{\mathit{x}}],\; \mathsf{fields}~{({{\mathrm{pack}}}_{{\mathit{zt}}}({\mathit{val}}))^{{\mathit{n}}}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.new\_default}]} \quad & {\mathit{z}} ; (\mathsf{struct.new\_default}~{\mathit{x}}) &\hookrightarrow& {{\mathit{val}}^\ast}~(\mathsf{struct.new}~{\mathit{x}})
  &\qquad \mbox{if}~{\mathit{z}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{struct}~{({\mathit{mut}}~{\mathit{zt}})^\ast} \\
  &&&&\qquad {\land}~({{\mathrm{default}}}_{{\mathrm{unpack}}({\mathit{zt}})} = {\mathit{val}})^\ast \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.get{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~({{\mathsf{struct.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}~{\mathit{i}}) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}struct.get{-}struct}]} \quad & {\mathit{z}} ; (\mathsf{ref.struct}~{\mathit{a}})~({{\mathsf{struct.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}~{\mathit{i}}) &\hookrightarrow& {{{{\mathrm{unpack}}}_{{{\mathit{zt}}^\ast}{}[{\mathit{i}}]}^{{{\mathit{sx}}^?}}}}{({\mathit{z}}.\mathsf{structs}{}[{\mathit{a}}].\mathsf{fields}{}[{\mathit{i}}])}
  &\qquad \mbox{if}~{\mathit{z}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{struct}~{({\mathit{mut}}~{\mathit{zt}})^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.set{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~{\mathit{val}}~(\mathsf{struct.set}~{\mathit{x}}~{\mathit{i}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap} \\
{[\textsc{\scriptsize E{-}struct.set{-}struct}]} \quad & {\mathit{z}} ; (\mathsf{ref.struct}~{\mathit{a}})~{\mathit{val}}~(\mathsf{struct.set}~{\mathit{x}}~{\mathit{i}}) &\hookrightarrow& {\mathit{z}}{}[\mathsf{structs}{}[{\mathit{a}}].\mathsf{fields}{}[{\mathit{i}}] = {{\mathrm{pack}}}_{{{\mathit{zt}}^\ast}{}[{\mathit{i}}]}({\mathit{val}})] ; \epsilon
  &\qquad \mbox{if}~{\mathit{z}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{struct}~{({\mathit{mut}}~{\mathit{zt}})^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new}]} \quad & {\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.new}~{\mathit{x}}) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}}) \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new\_default}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.new\_default}~{\mathit{x}}) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}})
  &\qquad \mbox{if}~{\mathit{z}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}) \\
  &&&&\qquad {\land}~{{\mathrm{default}}}_{{\mathrm{unpack}}({\mathit{zt}})} = {\mathit{val}} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new\_fixed}]} \quad & {\mathit{z}} ; {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ {\mathit{z}}{}[\mathsf{arrays} = ..{\mathit{ai}}] ; (\mathsf{ref.array}~{\mathit{a}}) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{\mathit{z}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})} \\
  &&& \multicolumn{2}{l@{}}{\quad {\land}~{\mathit{a}} = {|{\mathit{z}}.\mathsf{arrays}|} \land {\mathit{ai}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{z}}.\mathsf{types}{}[{\mathit{x}}],\; \mathsf{fields}~{({{\mathrm{pack}}}_{{\mathit{zt}}}({\mathit{val}}))^{{\mathit{n}}}} \}\end{array}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new\_elem{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.new\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{elems}{}[{\mathit{y}}].\mathsf{refs}|} \\
{[\textsc{\scriptsize E{-}array.new\_elem{-}alloc}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.new\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ {{\mathit{ref}}^{{\mathit{n}}}}~(\mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}}) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{{\mathit{ref}}^{{\mathit{n}}}} = {\mathit{z}}.\mathsf{elems}{}[{\mathit{y}}].\mathsf{refs}{}[{\mathit{i}} : {\mathit{n}}]} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new\_data{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.new\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{\mathit{z}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})} \\
  &&& \multicolumn{2}{l@{}}{\quad {\land}~{\mathit{i}} + {\mathit{n}} \cdot {|{\mathit{zt}}|} / 8 > {|{\mathit{z}}.\mathsf{datas}{}[{\mathit{y}}].\mathsf{bytes}|}} \\
{[\textsc{\scriptsize E{-}array.new\_data{-}num}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.new\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ {({\mathrm{unpack}}({\mathit{zt}}).\mathsf{const}~{\mathrm{unpackconst}}({\mathit{zt}}, {\mathit{c}}))^{{\mathit{n}}}}~(\mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}}) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{\mathit{z}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})} \\
  &&& \multicolumn{2}{l@{}}{\quad {\land}~{\mathrm{concat}}({{{\mathrm{bytes}}}_{{\mathit{zt}}}({\mathit{c}})^{{\mathit{n}}}}) = {\mathit{z}}.\mathsf{datas}{}[{\mathit{y}}].\mathsf{bytes}{}[{\mathit{i}} : {\mathit{n}} \cdot {|{\mathit{zt}}|} / 8]} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.get{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.get{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{\mathit{i}} \geq {|{\mathit{z}}.\mathsf{arrays}{}[{\mathit{a}}].\mathsf{fields}|} \\
{[\textsc{\scriptsize E{-}array.get{-}array}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ {{{{\mathrm{unpack}}}_{{\mathit{zt}}}^{{{\mathit{sx}}^?}}}}{({\mathit{z}}.\mathsf{arrays}{}[{\mathit{a}}].\mathsf{fields}{}[{\mathit{i}}])} } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{\mathit{z}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.set{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{array.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.set{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{array.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap}
  &\qquad \mbox{if}~{\mathit{i}} \geq {|{\mathit{z}}.\mathsf{arrays}{}[{\mathit{a}}].\mathsf{fields}|} \\
{[\textsc{\scriptsize E{-}array.set{-}array}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{array.set}~{\mathit{x}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ {\mathit{z}}{}[\mathsf{arrays}{}[{\mathit{a}}].\mathsf{fields}{}[{\mathit{i}}] = {{\mathrm{pack}}}_{{\mathit{zt}}}({\mathit{val}})] ; \epsilon } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{\mathit{z}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.len{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~\mathsf{array.len} &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.len{-}array}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~\mathsf{array.len} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{\mathit{z}}.\mathsf{arrays}{}[{\mathit{a}}].\mathsf{fields}|}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.fill{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.fill}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.fill{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.fill}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{arrays}{}[{\mathit{a}}].\mathsf{fields}|} \\
{[\textsc{\scriptsize E{-}array.fill{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.fill}~{\mathit{x}}) &\hookrightarrow& \epsilon
  &\qquad \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}array.fill{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.fill}~{\mathit{x}}) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{array.set}~{\mathit{x}}) \\ (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{array.fill}~{\mathit{x}}) \end{array} }
  &\qquad \mbox{otherwise} \\
{[\textsc{\scriptsize E{-}array.copy{-}null1}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~{\mathit{ref}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.copy{-}null2}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.null}~{\mathit{ht}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.copy{-}oob1}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~{\mathit{i}}_{{1}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{arrays}{}[{\mathit{a}}_{{1}}].\mathsf{fields}|}} \\
{[\textsc{\scriptsize E{-}array.copy{-}oob2}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~{\mathit{i}}_{{2}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{arrays}{}[{\mathit{a}}_{{2}}].\mathsf{fields}|}} \\
{[\textsc{\scriptsize E{-}array.copy{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ \epsilon } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{otherwise, if}~{\mathit{n}} = 0} \\
{[\textsc{\scriptsize E{-}array.copy{-}le}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}}) \\ (\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}}) \\ ({{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}_{{2}})~(\mathsf{array.set}~{\mathit{x}}_{{1}}) \\ (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}} + 1)~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) \end{array} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{otherwise, if}~{\mathit{z}}.\mathsf{types}{}[{\mathit{x}}_{{2}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}_{{2}})} \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{\mathit{i}}_{{1}} \leq {\mathit{i}}_{{2}} \land {{\mathit{sx}}^?} = {\mathrm{sx}}({\mathit{zt}}_{{2}})} \\
{[\textsc{\scriptsize E{-}array.copy{-}gt}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}} + {\mathit{n}} - 1) \\ (\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}} + {\mathit{n}} - 1) \\ ({{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}_{{2}})~(\mathsf{array.set}~{\mathit{x}}_{{1}}) \\ (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) \end{array} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{otherwise, if}~{\mathit{z}}.\mathsf{types}{}[{\mathit{x}}_{{2}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}_{{2}})} \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{sx}}^?} = {\mathrm{sx}}({\mathit{zt}}_{{2}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.init\_elem{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}oob1}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{arrays}{}[{\mathit{a}}].\mathsf{fields}|}} \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}oob2}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~{\mathit{j}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{elems}{}[{\mathit{y}}].\mathsf{refs}|}} \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ \epsilon } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{otherwise, if}~{\mathit{n}} = 0} \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{ref}}~(\mathsf{array.set}~{\mathit{x}}) \\ (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) \end{array} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{otherwise, if}~{\mathit{ref}} = {\mathit{z}}.\mathsf{elems}{}[{\mathit{y}}].\mathsf{refs}{}[{\mathit{j}}]} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.init\_data{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.init\_data{-}oob1}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{arrays}{}[{\mathit{a}}].\mathsf{fields}|}} \\
{[\textsc{\scriptsize E{-}array.init\_data{-}oob2}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~{\mathit{z}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})} \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{\mathit{j}} + {\mathit{n}} \cdot {|{\mathit{zt}}|} / 8 > {|{\mathit{z}}.\mathsf{datas}{}[{\mathit{y}}].\mathsf{bytes}|}} \\
{[\textsc{\scriptsize E{-}array.init\_data{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ \epsilon } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{otherwise, if}~{\mathit{n}} = 0} \\
{[\textsc{\scriptsize E{-}array.init\_data{-}num}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathrm{unpack}}({\mathit{zt}}).\mathsf{const}~{\mathrm{unpackconst}}({\mathit{zt}}, {\mathit{c}}))~(\mathsf{array.set}~{\mathit{x}}) \\ (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + {|{\mathit{zt}}|} / 8)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) \end{array} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{otherwise, if}~{\mathit{z}}.\mathsf{types}{}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})} \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathrm{bytes}}}_{{\mathit{zt}}}({\mathit{c}}) = {\mathit{z}}.\mathsf{datas}{}[{\mathit{y}}].\mathsf{bytes}{}[{\mathit{j}} : {|{\mathit{zt}}|} / 8]} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}extern.convert\_any{-}null}]} \quad & (\mathsf{ref.null}~{\mathit{ht}})~\mathsf{extern.convert\_any} &\hookrightarrow& (\mathsf{ref.null}~\mathsf{extern}) \\
{[\textsc{\scriptsize E{-}extern.convert\_any{-}addr}]} \quad & {\mathit{addrref}}~\mathsf{extern.convert\_any} &\hookrightarrow& (\mathsf{ref.extern}~{\mathit{addrref}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}any.convert\_extern{-}null}]} \quad & (\mathsf{ref.null}~{\mathit{ht}})~\mathsf{any.convert\_extern} &\hookrightarrow& (\mathsf{ref.null}~\mathsf{any}) \\
{[\textsc{\scriptsize E{-}any.convert\_extern{-}addr}]} \quad & (\mathsf{ref.extern}~{\mathit{addrref}})~\mathsf{any.convert\_extern} &\hookrightarrow& {\mathit{addrref}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vvunop}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~(\mathsf{v{\scriptstyle128}} . {\mathit{vvunop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{{{\mathit{vvunop}}}{\mathsf{\_}}~\mathsf{v{\scriptstyle128}}}{({\mathit{c}}_{{1}})} = {\mathit{c}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vvbinop}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{2}})~(\mathsf{v{\scriptstyle128}} . {\mathit{vvbinop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{{{\mathit{vvbinop}}}{\mathsf{\_}}~\mathsf{v{\scriptstyle128}}}{({\mathit{c}}_{{1}},\, {\mathit{c}}_{{2}})} = {\mathit{c}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vvternop}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{2}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{3}})~(\mathsf{v{\scriptstyle128}} . {\mathit{vvternop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{{{\mathit{vvternop}}}{\mathsf{\_}}~\mathsf{v{\scriptstyle128}}}{({\mathit{c}}_{{1}},\, {\mathit{c}}_{{2}},\, {\mathit{c}}_{{3}})} = {\mathit{c}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vvtestop}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~(\mathsf{v{\scriptstyle128}} . \mathsf{any\_true}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{\mathit{c}} = {{\mathrm{ine}}}_{{|\mathsf{v{\scriptstyle128}}|}}({\mathit{c}}_{{1}}, 0) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vswizzle}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{2}})~(({{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}).\mathsf{swizzle}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}'})
  &\qquad \mbox{if}~{{\mathit{ci}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{c}}_{{2}}) \\
  &&&&\qquad {\land}~{{\mathit{c}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{c}}_{{1}})~{0^{256 - {\mathit{N}}}} \\
  &&&&\qquad {\land}~{\mathit{c}'} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathit{c}}^\ast}{}[{{\mathit{ci}}^\ast}{}[{\mathit{k}}]]^{{\mathit{k}}<{\mathit{N}}}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vshuffle}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{2}})~(({{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}).\mathsf{shuffle}~{{\mathit{i}}^\ast}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{{\mathit{c}'}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{c}}_{{1}})~{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{c}}_{{2}}) \\
  &&&&\qquad {\land}~{\mathit{c}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathit{c}'}^\ast}{}[{{\mathit{i}}^\ast}{}[{\mathit{k}}]]^{{\mathit{k}}<{\mathit{N}}}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vsplat}]} \quad & ({\mathrm{unpack}}({\mathsf{i}}{{\mathit{n}}}).\mathsf{const}~{\mathit{c}}_{{1}})~(({{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}).\mathsf{splat}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{\mathit{c}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{\mathrm{pack}}}_{{\mathsf{i}}{{\mathit{n}}}}({\mathit{c}}_{{1}})^{{\mathit{N}}}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vextract\_lane{-}num}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~(\mathsf{vextract\_lane}~({{{\mathit{nt}}}{\mathsf{x}}}{{\mathit{N}}})~{\mathit{i}}) &\hookrightarrow& ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{2}})
  &\qquad \mbox{if}~{\mathit{c}}_{{2}} = {{\mathrm{lanes}}}_{{{{\mathit{nt}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{c}}_{{1}}){}[{\mathit{i}}] \\
{[\textsc{\scriptsize E{-}vextract\_lane{-}pack}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~({({{{\mathit{pt}}}{\mathsf{x}}}{{\mathit{N}}}).\mathsf{extract\_lane\_}}{{\mathit{sx}}}~{\mathit{i}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}}_{{2}})
  &\qquad \mbox{if}~{\mathit{c}}_{{2}} = {{{{\mathrm{ext}}}_{{|{\mathit{pt}}|}, 32}^{{\mathit{sx}}}}}{({{\mathrm{lanes}}}_{{{{\mathit{pt}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{c}}_{{1}}){}[{\mathit{i}}])} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vreplace\_lane}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathrm{unpack}}({\mathsf{i}}{{\mathit{n}}}).\mathsf{const}~{\mathit{c}}_{{2}})~(({{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}).\mathsf{replace\_lane}~{\mathit{i}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{\mathit{c}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{c}}_{{1}}){}[{}[{\mathit{i}}] = {{\mathrm{pack}}}_{{\mathsf{i}}{{\mathit{n}}}}({\mathit{c}}_{{2}})])} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vunop}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{sh}} . {\mathit{vunop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{\mathit{c}} = {{{\mathit{vunop}}}{\mathsf{\_}}~{\mathit{sh}}}{({\mathit{c}}_{{1}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vbinop{-}val}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{2}})~({\mathit{sh}} . {\mathit{vbinop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{{{\mathit{vbinop}}}{\mathsf{\_}}~{\mathit{sh}}}{({\mathit{c}}_{{1}},\, {\mathit{c}}_{{2}})} = {\mathit{c}} \\
{[\textsc{\scriptsize E{-}vbinop{-}trap}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{2}})~({\mathit{sh}} . {\mathit{vbinop}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{{{\mathit{vbinop}}}{\mathsf{\_}}~{\mathit{sh}}}{({\mathit{c}}_{{1}},\, {\mathit{c}}_{{2}})} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vrelop}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{2}})~({\mathit{sh}} . {\mathit{vrelop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{{{\mathit{vrelop}}}{\mathsf{\_}}~{\mathit{sh}}}{({\mathit{c}}_{{1}},\, {\mathit{c}}_{{2}})} = {\mathit{c}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vshiftop}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(({{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}) . {\mathit{vshiftop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{{\mathit{c}'}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{c}}_{{1}}) \\
  &&&&\qquad {\land}~{\mathit{c}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{{\mathit{vshiftop}}}{\mathsf{\_}}~{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}{({\mathit{c}'},\, {\mathit{n}})}^\ast})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vtestop{-}true}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})~(({{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}) . \mathsf{all\_true}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1)
  &\qquad \mbox{if}~{{\mathit{ci}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{c}}) \\
  &&&&\qquad {\land}~({\mathit{ci}}_{{1}} \neq 0)^\ast \\
{[\textsc{\scriptsize E{-}vtestop{-}false}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})~(({{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}) . \mathsf{all\_true}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vbitmask}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})~(({{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}).\mathsf{bitmask}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{ci}})
  &\qquad \mbox{if}~{{\mathit{ci}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}({\mathit{c}}) \\
  &&&&\qquad {\land}~{{\mathrm{bits}}}_{{\mathsf{i}}{32}}({\mathit{ci}}) = {{{{{\mathrm{ilt}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}}^{\mathsf{s}}}}{({\mathit{ci}}_{{1}},\, 0)}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vnarrow}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{2}})~({{{{({{{{\mathsf{i}}{{\mathit{n}}}}_{{2}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}).\mathsf{narrow}}{\mathsf{\_}}}{{{{{\mathsf{i}}{{\mathit{n}}}}_{{1}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}}}{\mathsf{\_}}}{{\mathit{sx}}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{{\mathit{ci}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{{{{\mathsf{i}}{{\mathit{n}}}}_{{1}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}}({\mathit{c}}_{{1}}) \\
  &&&&\qquad {\land}~{{\mathit{ci}}_{{2}}^\ast} = {{\mathrm{lanes}}}_{{{{{\mathsf{i}}{{\mathit{n}}}}_{{1}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}}({\mathit{c}}_{{2}}) \\
  &&&&\qquad {\land}~{{\mathit{cj}}_{{1}}^\ast} = {{{{{\mathrm{narrow}}}_{{|{{\mathsf{i}}{{\mathit{n}}}}_{{1}}|}, {|{{\mathsf{i}}{{\mathit{n}}}}_{{2}}|}}^{{\mathit{sx}}}}}{{\mathit{ci}}_{{1}}}^\ast} \\
  &&&&\qquad {\land}~{{\mathit{cj}}_{{2}}^\ast} = {{{{{\mathrm{narrow}}}_{{|{{\mathsf{i}}{{\mathit{n}}}}_{{1}}|}, {|{{\mathsf{i}}{{\mathit{n}}}}_{{2}}|}}^{{\mathit{sx}}}}}{{\mathit{ci}}_{{2}}}^\ast} \\
  &&&&\qquad {\land}~{\mathit{c}} = {{{{\mathrm{lanes}}}_{{{{{\mathsf{i}}{{\mathit{n}}}}_{{2}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}}^{{-1}}}}{({{\mathit{cj}}_{{1}}^\ast}~{{\mathit{cj}}_{{2}}^\ast})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vcvtop{-}normal}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~(({{{{\mathsf{i}}{{\mathit{n}}}}_{{2}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}) . {{{{{{{\mathit{vcvtop}}}{\mathsf{\_}}}{\epsilon}}{\mathsf{\_}}}{{{{{\mathsf{i}}{{\mathit{n}}}}_{{1}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{{\mathit{c}'}^\ast} = {{\mathrm{lanes}}}_{{{{{\mathsf{i}}{{\mathit{n}}}}_{{1}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}}({\mathit{c}}_{{1}}) \\
  &&&&\qquad {\land}~{\mathit{c}} = {{{{\mathrm{lanes}}}_{{{{{\mathsf{i}}{{\mathit{n}}}}_{{2}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}}^{{-1}}}}{({{\mathrm{vcvtop}}({{{{\mathsf{i}}{{\mathit{n}}}}_{{1}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}, {{{{\mathsf{i}}{{\mathit{n}}}}_{{2}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}, {\mathit{vcvtop}}, {{\mathit{sx}}^?}, {\mathit{c}'})^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vcvtop{-}half}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~(({{{{\mathsf{i}}{{\mathit{n}}}}_{{2}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}) . {{{{{{{\mathit{vcvtop}}}{\mathsf{\_}}}{{\mathit{hf}}}}{\mathsf{\_}}}{{{{{\mathsf{i}}{{\mathit{n}}}}_{{1}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{{\mathit{ci}}^\ast} = {{\mathrm{lanes}}}_{{{{{\mathsf{i}}{{\mathit{n}}}}_{{1}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}}({\mathit{c}}_{{1}}){}[{\mathrm{halfop}}({\mathit{hf}}, 0, {\mathit{N}}_{{2}}) : {\mathit{N}}_{{2}}] \\
  &&&&\qquad {\land}~{\mathit{c}} = {{{{\mathrm{lanes}}}_{{{{{\mathsf{i}}{{\mathit{n}}}}_{{2}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}}^{{-1}}}}{({{\mathrm{vcvtop}}({{{{\mathsf{i}}{{\mathit{n}}}}_{{1}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}, {{{{\mathsf{i}}{{\mathit{n}}}}_{{2}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}, {\mathit{vcvtop}}, {{\mathit{sx}}^?}, {\mathit{ci}})^\ast})} \\
{[\textsc{\scriptsize E{-}vcvtop{-}zero}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~(({{{\mathit{nt}}_{{2}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}) . {{{{{{{{{\mathit{vcvtop}}}{\mathsf{\_}}}{\epsilon}}{\mathsf{\_}}}{{{{\mathit{nt}}_{{1}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}}{\mathsf{\_}}}{\mathsf{zero}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{{\mathit{ci}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathit{nt}}_{{1}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}}({\mathit{c}}_{{1}}) \\
  &&&&\qquad {\land}~{\mathit{c}} = {{{{\mathrm{lanes}}}_{{{{\mathit{nt}}_{{2}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}}^{{-1}}}}{({{\mathrm{vcvtop}}({{{\mathit{nt}}_{{1}}}{\mathsf{x}}}{{\mathit{N}}_{{1}}}, {{{\mathit{nt}}_{{2}}}{\mathsf{x}}}{{\mathit{N}}_{{2}}}, {\mathit{vcvtop}}, {{\mathit{sx}}^?}, {\mathit{ci}})^\ast}~{{\mathrm{zero}}({\mathit{nt}}_{{2}})^{{\mathit{N}}_{{1}}}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vextunop}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{sh}}_{{1}} . {{{{{\mathit{vextunop}}}{\mathsf{\_}}}{{\mathit{sh}}_{{2}}}}{\mathsf{\_}}}{{\mathit{sx}}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{\mathrm{vextunop}}({\mathit{sh}}_{{1}}, {\mathit{sh}}_{{2}}, {\mathit{vextunop}}, {\mathit{sx}}, {\mathit{c}}_{{1}}) = {\mathit{c}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vextbinop}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{2}})~({\mathit{sh}}_{{1}} . {{{{{\mathit{vextbinop}}}{\mathsf{\_}}}{{\mathit{sh}}_{{2}}}}{\mathsf{\_}}}{{\mathit{sx}}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{\mathrm{vextbinop}}({\mathit{sh}}_{{1}}, {\mathit{sh}}_{{2}}, {\mathit{vextbinop}}, {\mathit{sx}}, {\mathit{c}}_{{1}}, {\mathit{c}}_{{2}}) = {\mathit{c}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}local.get}]} \quad & {\mathit{z}} ; (\mathsf{local.get}~{\mathit{x}}) &\hookrightarrow& {\mathit{val}}
  &\qquad \mbox{if}~{\mathit{z}}.\mathsf{locals}{}[{\mathit{x}}] = {\mathit{val}} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}local.set}]} \quad & {\mathit{z}} ; {\mathit{val}}~(\mathsf{local.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}{}[\mathsf{locals}{}[{\mathit{x}}] = {\mathit{val}}] ; \epsilon \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}local.tee}]} \quad & {\mathit{val}}~(\mathsf{local.tee}~{\mathit{x}}) &\hookrightarrow& {\mathit{val}}~{\mathit{val}}~(\mathsf{local.set}~{\mathit{x}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}global.get}]} \quad & {\mathit{z}} ; (\mathsf{global.get}~{\mathit{x}}) &\hookrightarrow& {\mathit{val}}
  &\qquad \mbox{if}~{\mathit{z}}.\mathsf{globals}{}[{\mathit{x}}].\mathsf{value} = {\mathit{val}} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}global.set}]} \quad & {\mathit{z}} ; {\mathit{val}}~(\mathsf{global.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}{}[\mathsf{globals}{}[{\mathit{x}}].\mathsf{value} = {\mathit{val}}] ; \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.get{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{table.get}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{\mathit{i}} \geq {|{\mathit{z}}.\mathsf{tables}{}[{\mathit{x}}].\mathsf{refs}|} \\
{[\textsc{\scriptsize E{-}table.get{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{table.get}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}.\mathsf{tables}{}[{\mathit{x}}].\mathsf{refs}{}[{\mathit{i}}]
  &\qquad \mbox{if}~{\mathit{i}} < {|{\mathit{z}}.\mathsf{tables}{}[{\mathit{x}}].\mathsf{refs}|} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.set{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{ref}}~(\mathsf{table.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap}
  &\qquad \mbox{if}~{\mathit{i}} \geq {|{\mathit{z}}.\mathsf{tables}{}[{\mathit{x}}].\mathsf{refs}|} \\
{[\textsc{\scriptsize E{-}table.set{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{ref}}~(\mathsf{table.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}{}[\mathsf{tables}{}[{\mathit{x}}].\mathsf{refs}{}[{\mathit{i}}] = {\mathit{ref}}] ; \epsilon
  &\qquad \mbox{if}~{\mathit{i}} < {|{\mathit{z}}.\mathsf{tables}{}[{\mathit{x}}].\mathsf{refs}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.size}]} \quad & {\mathit{z}} ; (\mathsf{table.size}~{\mathit{x}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})
  &\qquad \mbox{if}~{|{\mathit{z}}.\mathsf{tables}{}[{\mathit{x}}].\mathsf{refs}|} = {\mathit{n}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.grow{-}succeed}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.grow}~{\mathit{x}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ {\mathit{z}}{}[\mathsf{tables}{}[{\mathit{x}}] = {\mathit{ti}}] ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{\mathit{z}}.\mathsf{tables}{}[{\mathit{x}}].\mathsf{refs}|}) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{\mathit{ti}} = {\mathrm{growtable}}({\mathit{z}}.\mathsf{tables}{}[{\mathit{x}}], {\mathit{n}}, {\mathit{ref}})} \\
{[\textsc{\scriptsize E{-}table.grow{-}fail}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.grow}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{{{{\mathrm{signed}}}_{32}^{{-1}}}}{({-1})}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.fill{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.fill}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{tables}{}[{\mathit{x}}].\mathsf{refs}|} \\
{[\textsc{\scriptsize E{-}table.fill{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.fill}~{\mathit{x}}) &\hookrightarrow& \epsilon
  &\qquad \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}table.fill{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.fill}~{\mathit{x}}) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{table.set}~{\mathit{x}}) \\ (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{table.fill}~{\mathit{x}}) \end{array} }
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.copy{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.copy}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{tables}{}[{\mathit{y}}].\mathsf{refs}|} \lor {\mathit{j}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{tables}{}[{\mathit{x}}].\mathsf{refs}|}} \\
{[\textsc{\scriptsize E{-}table.copy{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.copy}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \epsilon
  &\qquad \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}table.copy{-}le}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.copy}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{table.get}~{\mathit{y}})~(\mathsf{table.set}~{\mathit{x}}) \\ (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{table.copy}~{\mathit{x}}~{\mathit{y}}) \end{array} }
  &\qquad \mbox{otherwise, if}~{\mathit{j}} \leq {\mathit{i}} \\
{[\textsc{\scriptsize E{-}table.copy{-}gt}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.copy}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + {\mathit{n}} - 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + {\mathit{n}} - 1)~(\mathsf{table.get}~{\mathit{y}})~(\mathsf{table.set}~{\mathit{x}}) \\ (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{table.copy}~{\mathit{x}}~{\mathit{y}}) \end{array} }
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.init{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.init}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{elems}{}[{\mathit{y}}].\mathsf{refs}|} \lor {\mathit{j}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{tables}{}[{\mathit{x}}].\mathsf{refs}|}} \\
{[\textsc{\scriptsize E{-}table.init{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.init}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \epsilon
  &\qquad \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}table.init{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.init}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~{\mathit{z}}.\mathsf{elems}{}[{\mathit{y}}].\mathsf{refs}{}[{\mathit{i}}]~(\mathsf{table.set}~{\mathit{x}}) \\ (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{table.init}~{\mathit{x}}~{\mathit{y}}) \end{array} }
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}elem.drop}]} \quad & {\mathit{z}} ; (\mathsf{elem.drop}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}{}[\mathsf{elems}{}[{\mathit{x}}].\mathsf{refs} = \epsilon] ; \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}load{-}num{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{load}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {|{\mathit{nt}}|} / 8 > {|{\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}|}} \\
{[\textsc{\scriptsize E{-}load{-}num{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{load}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{{\mathrm{bytes}}}_{{\mathit{nt}}}({\mathit{c}}) = {\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}{}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {|{\mathit{nt}}|} / 8]} \\
{[\textsc{\scriptsize E{-}load{-}pack{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({{\mathsf{i}}{{\mathit{n}}}.\mathsf{load}}{{{{\mathit{n}}}{\mathsf{\_}}}{{\mathit{sx}}}}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {\mathit{n}} / 8 > {|{\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}|}} \\
{[\textsc{\scriptsize E{-}load{-}pack{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({{\mathsf{i}}{{\mathit{n}}}.\mathsf{load}}{{{{\mathit{n}}}{\mathsf{\_}}}{{\mathit{sx}}}}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ ({\mathsf{i}}{{\mathit{n}}}.\mathsf{const}~{{{{\mathrm{ext}}}_{{\mathit{n}}, {|{\mathsf{i}}{{\mathit{n}}}|}}^{{\mathit{sx}}}}}{({\mathit{c}})}) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{{\mathrm{bytes}}}_{{\mathsf{i}}{{\mathit{n}}}}({\mathit{c}}) = {\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}{}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {\mathit{n}} / 8]} \\
{[\textsc{\scriptsize E{-}vload{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{v{\scriptstyle128}.load}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {|\mathsf{v{\scriptstyle128}}|} / 8 > {|{\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}vload{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{v{\scriptstyle128}.load}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{{\mathrm{bytes}}}_{\mathsf{v{\scriptstyle128}}}({\mathit{c}}) = {\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}{}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {|\mathsf{v{\scriptstyle128}}|} / 8] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vload{-}shape{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathsf{v{\scriptstyle128}.load}}{{{{{\mathsf{shape}}{{\mathit{M}}}}{\mathsf{x}}}{{\mathit{N}}}}{{\mathit{sx}}}}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {\mathit{M}} \cdot {\mathit{N}} / 8 > {|{\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}vload{-}shape{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathsf{v{\scriptstyle128}.load}}{{{{{\mathsf{shape}}{{\mathit{M}}}}{\mathsf{x}}}{{\mathit{N}}}}{{\mathit{sx}}}}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~({{\mathrm{bytes}}}_{{\mathsf{i}}{{\mathit{M}}}}({\mathit{j}}) = {\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}{}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {\mathit{k}} \cdot {\mathit{M}} / 8 : {\mathit{M}} / 8])^{{\mathit{k}}<{\mathit{N}}} \\
  &&&&\qquad {\land}~{|{\mathsf{i}}{{\mathit{n}}}|} = {\mathit{M}} \cdot 2 \\
  &&&&\qquad {\land}~{\mathit{c}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{N}}}}^{{-1}}}}{({{{{{\mathrm{ext}}}_{{\mathit{M}}, {|{\mathsf{i}}{{\mathit{n}}}|}}^{{\mathit{sx}}}}}{({\mathit{j}})}^{{\mathit{N}}}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vload{-}splat{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathsf{v{\scriptstyle128}.load}}{{\mathsf{splat}}{{\mathit{N}}}}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {\mathit{N}} / 8 > {|{\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}vload{-}splat{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathsf{v{\scriptstyle128}.load}}{{\mathsf{splat}}{{\mathit{N}}}}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{{\mathrm{bytes}}}_{{\mathsf{i}}{{\mathit{N}}}}({\mathit{j}}) = {\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}{}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {\mathit{N}} / 8] \\
  &&&&\qquad {\land}~{\mathit{N}} = {|{\mathsf{i}}{{\mathit{n}}}|} \\
  &&&&\qquad {\land}~{\mathit{M}} = 128 / {\mathit{N}} \\
  &&&&\qquad {\land}~{\mathit{c}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{M}}}}^{{-1}}}}{({{\mathit{j}}^{{\mathit{M}}}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vload{-}zero{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathsf{v{\scriptstyle128}.load}}{{\mathsf{zero}}{{\mathit{N}}}}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {\mathit{N}} / 8 > {|{\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}vload{-}zero{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathsf{v{\scriptstyle128}.load}}{{\mathsf{zero}}{{\mathit{N}}}}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{{\mathrm{bytes}}}_{{\mathsf{i}}{{\mathit{N}}}}({\mathit{j}}) = {\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}{}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {\mathit{N}} / 8] \\
  &&&&\qquad {\land}~{\mathit{c}} = {{{{\mathrm{ext}}}_{{\mathit{N}}, 128}^{\mathsf{u}}}}{({\mathit{j}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vload\_lane{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~({{{\mathsf{v{\scriptstyle128}.load}}{{\mathit{N}}}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~{\mathit{mo}}~{\mathit{j}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {\mathit{N}} / 8 > {|{\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}vload\_lane{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{1}})~({{{\mathsf{v{\scriptstyle128}.load}}{{\mathit{N}}}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~{\mathit{mo}}~{\mathit{j}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})
  &\qquad \mbox{if}~{{\mathrm{bytes}}}_{{\mathsf{i}}{{\mathit{N}}}}({\mathit{k}}) = {\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}{}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {\mathit{N}} / 8] \\
  &&&&\qquad {\land}~{\mathit{N}} = {|{\mathsf{i}}{{\mathit{n}}}|} \\
  &&&&\qquad {\land}~{\mathit{M}} = {|\mathsf{v{\scriptstyle128}}|} / {\mathit{N}} \\
  &&&&\qquad {\land}~{\mathit{c}} = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{M}}}}^{{-1}}}}{({{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{M}}}}({\mathit{c}}_{{1}}){}[{}[{\mathit{j}}] = {\mathit{k}}])} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}store{-}num{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~({\mathit{nt}}.\mathsf{store}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ {\mathit{z}} ; \mathsf{trap} } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {|{\mathit{nt}}|} / 8 > {|{\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}|}} \\
{[\textsc{\scriptsize E{-}store{-}num{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~({\mathit{nt}}.\mathsf{store}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ {\mathit{z}}{}[\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}{}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {|{\mathit{nt}}|} / 8] = {{\mathit{b}}^\ast}] ; \epsilon } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{{\mathit{b}}^\ast} = {{\mathrm{bytes}}}_{{\mathit{nt}}}({\mathit{c}})} \\
{[\textsc{\scriptsize E{-}store{-}pack{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathsf{i}}{{\mathit{n}}}.\mathsf{const}~{\mathit{c}})~({{\mathit{nt}}.\mathsf{store}}{{\mathit{n}}}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ {\mathit{z}} ; \mathsf{trap} } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {\mathit{n}} / 8 > {|{\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}|}} \\
{[\textsc{\scriptsize E{-}store{-}pack{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathsf{i}}{{\mathit{n}}}.\mathsf{const}~{\mathit{c}})~({{\mathit{nt}}.\mathsf{store}}{{\mathit{n}}}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ {\mathit{z}}{}[\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}{}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {\mathit{n}} / 8] = {{\mathit{b}}^\ast}] ; \epsilon } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{{\mathit{b}}^\ast} = {{\mathrm{bytes}}}_{{\mathsf{i}}{{\mathit{n}}}}({{{\mathrm{wrap}}}_{{|{\mathsf{i}}{{\mathit{n}}}|}, {\mathit{n}}}}{({\mathit{c}})})} \\
{[\textsc{\scriptsize E{-}vstore{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})~(\mathsf{v{\scriptstyle128}.store}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap}
  &\qquad \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {|\mathsf{v{\scriptstyle128}}|} / 8 > {|{\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}vstore{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})~(\mathsf{v{\scriptstyle128}.store}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& {\mathit{z}}{}[\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}{}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {|\mathsf{v{\scriptstyle128}}|} / 8] = {{\mathit{b}}^\ast}] ; \epsilon
  &\qquad \mbox{if}~{{\mathit{b}}^\ast} = {{\mathrm{bytes}}}_{\mathsf{v{\scriptstyle128}}}({\mathit{c}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vstore\_lane{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})~({{{\mathsf{v{\scriptstyle128}.store}}{{\mathit{N}}}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~{\mathit{mo}}~{\mathit{j}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap}
  &\qquad \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {\mathit{N}} > {|{\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}vstore\_lane{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}})~({{{\mathsf{v{\scriptstyle128}.store}}{{\mathit{N}}}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~{\mathit{mo}}~{\mathit{j}}) &\hookrightarrow& {\mathit{z}}{}[\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}{}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {\mathit{N}} / 8] = {{\mathit{b}}^\ast}] ; \epsilon
  &\qquad \mbox{if}~{\mathit{N}} = {|{\mathsf{i}}{{\mathit{n}}}|} \\
  &&&&\qquad {\land}~{\mathit{M}} = 128 / {\mathit{N}} \\
  &&&&\qquad {\land}~{{\mathit{b}}^\ast} = {{\mathrm{bytes}}}_{{\mathsf{i}}{{\mathit{N}}}}({{\mathrm{lanes}}}_{{{{\mathsf{i}}{{\mathit{n}}}}{\mathsf{x}}}{{\mathit{M}}}}({\mathit{c}}){}[{\mathit{j}}]) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.size}]} \quad & {\mathit{z}} ; (\mathsf{memory.size}~{\mathit{x}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})
  &\qquad \mbox{if}~{\mathit{n}} \cdot 64 \, {\mathrm{Ki}} = {|{\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.grow{-}succeed}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.grow}~{\mathit{x}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ {\mathit{z}}{}[\mathsf{mems}{}[{\mathit{x}}] = {\mathit{mi}}] ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}|} / 64 \, {\mathrm{Ki}}) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{\mathit{mi}} = {\mathrm{growmemory}}({\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}], {\mathit{n}})} \\
{[\textsc{\scriptsize E{-}memory.grow{-}fail}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.grow}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{{{{\mathrm{signed}}}_{32}^{{-1}}}}{({-1})}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.fill{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.fill}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}memory.fill{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.fill}~{\mathit{x}}) &\hookrightarrow& \epsilon
  &\qquad \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}memory.fill{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.fill}~{\mathit{x}}) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~{\mathit{x}}) \\ (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{memory.fill}~{\mathit{x}}) \end{array} }
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.copy{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~{\mathit{i}}_{{1}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}_{{1}}].\mathsf{bytes}|} \lor {\mathit{i}}_{{2}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}_{{2}}].\mathsf{bytes}|}} \\
{[\textsc{\scriptsize E{-}memory.copy{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \epsilon
  &\qquad \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}memory.copy{-}le}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~({\mathsf{i{\scriptstyle32}}.\mathsf{load}}{{{8}{\mathsf{\_}}}{\mathsf{u}}}~{\mathit{x}}_{{2}})~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~{\mathit{x}}_{{1}}) \\ (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) \end{array} }
  &\qquad \mbox{otherwise, if}~{\mathit{i}}_{{1}} \leq {\mathit{i}}_{{2}} \\
{[\textsc{\scriptsize E{-}memory.copy{-}gt}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}} + {\mathit{n}} - 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}} + {\mathit{n}} - 1)~({\mathsf{i{\scriptstyle32}}.\mathsf{load}}{{{8}{\mathsf{\_}}}{\mathsf{u}}}~{\mathit{x}}_{{2}})~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~{\mathit{x}}_{{1}}) \\ (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) \end{array} }
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.init{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{datas}{}[{\mathit{y}}].\mathsf{bytes}|} \lor {\mathit{j}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{mems}{}[{\mathit{x}}].\mathsf{bytes}|}} \\
{[\textsc{\scriptsize E{-}memory.init{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \epsilon
  &\qquad \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}memory.init{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{z}}.\mathsf{datas}{}[{\mathit{y}}].\mathsf{bytes}{}[{\mathit{i}}])~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~{\mathit{x}}) \\ (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}}) \end{array} }
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}data.drop}]} \quad & {\mathit{z}} ; (\mathsf{data.drop}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}{}[\mathsf{datas}{}[{\mathit{x}}].\mathsf{bytes} = \epsilon] ; \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{alloctypes}}(\epsilon) &=& \epsilon \\
{\mathrm{alloctypes}}({{\mathit{type}'}^\ast}~{\mathit{type}}) &=& {{\mathit{deftype}'}^\ast}~{{\mathit{deftype}}^\ast}
  &\qquad \mbox{if}~{{\mathit{deftype}'}^\ast} = {\mathrm{alloctypes}}({{\mathit{type}'}^\ast}) \\
  &&&\qquad {\land}~{\mathit{type}} = \mathsf{type}~{\mathit{rectype}} \\
  &&&\qquad {\land}~{{\mathit{deftype}}^\ast} = {{{\mathrm{roll}}}_{{\mathit{x}}}({\mathit{rectype}})}{{}[{ := }\;{{\mathit{deftype}'}^\ast}]} \\
  &&&\qquad {\land}~{\mathit{x}} = {|{{\mathit{deftype}'}^\ast}|} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocfunc}}({\mathit{s}}, {\mathit{mm}}, {\mathit{func}}) &=& ({\mathit{s}}{}[\mathsf{funcs} = ..{\mathit{fi}}],\, {|{\mathit{s}}.\mathsf{funcs}|})
  &\qquad \mbox{if}~{\mathit{func}} = \mathsf{func}~{\mathit{x}}~{{\mathit{local}}^\ast}~{\mathit{expr}} \\
  &&&\qquad {\land}~{\mathit{fi}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{mm}}.\mathsf{types}{}[{\mathit{x}}],\; \mathsf{module}~{\mathit{mm}},\; \mathsf{code}~{\mathit{func}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocfuncs}}({\mathit{s}}, {\mathit{mm}}, \epsilon) &=& ({\mathit{s}},\, \epsilon) \\
{\mathrm{allocfuncs}}({\mathit{s}}, {\mathit{mm}}, {\mathit{func}}~{{\mathit{func}'}^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{fa}}~{{\mathit{fa}'}^\ast})
  &\qquad \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{fa}}) = {\mathrm{allocfunc}}({\mathit{s}}, {\mathit{mm}}, {\mathit{func}}) \\
  &&&\qquad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{fa}'}^\ast}) = {\mathrm{allocfuncs}}({\mathit{s}}_{{1}}, {\mathit{mm}}, {{\mathit{func}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocglobal}}({\mathit{s}}, {\mathit{globaltype}}, {\mathit{val}}) &=& ({\mathit{s}}{}[\mathsf{globals} = ..{\mathit{gi}}],\, {|{\mathit{s}}.\mathsf{globals}|})
  &\qquad \mbox{if}~{\mathit{gi}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{globaltype}},\; \mathsf{value}~{\mathit{val}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocglobals}}({\mathit{s}}, \epsilon, \epsilon) &=& ({\mathit{s}},\, \epsilon) \\
{\mathrm{allocglobals}}({\mathit{s}}, {\mathit{globaltype}}~{{\mathit{globaltype}'}^\ast}, {\mathit{val}}~{{\mathit{val}'}^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{ga}}~{{\mathit{ga}'}^\ast})
  &\qquad \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{ga}}) = {\mathrm{allocglobal}}({\mathit{s}}, {\mathit{globaltype}}, {\mathit{val}}) \\
  &&&\qquad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ga}'}^\ast}) = {\mathrm{allocglobals}}({\mathit{s}}_{{1}}, {{\mathit{globaltype}'}^\ast}, {{\mathit{val}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{alloctable}}({\mathit{s}}, {}[{\mathit{i}} .. {\mathit{j}}]~{\mathit{rt}}, {\mathit{ref}}) &=& ({\mathit{s}}{}[\mathsf{tables} = ..{\mathit{ti}}],\, {|{\mathit{s}}.\mathsf{tables}|})
  &\qquad \mbox{if}~{\mathit{ti}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~({}[{\mathit{i}} .. {\mathit{j}}]~{\mathit{rt}}),\; \mathsf{refs}~{{\mathit{ref}}^{{\mathit{i}}}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{alloctables}}({\mathit{s}}, \epsilon, \epsilon) &=& ({\mathit{s}},\, \epsilon) \\
{\mathrm{alloctables}}({\mathit{s}}, {\mathit{tabletype}}~{{\mathit{tabletype}'}^\ast}, {\mathit{ref}}~{{\mathit{ref}'}^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{ta}}~{{\mathit{ta}'}^\ast})
  &\qquad \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{ta}}) = {\mathrm{alloctable}}({\mathit{s}}, {\mathit{tabletype}}, {\mathit{ref}}) \\
  &&&\qquad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ta}'}^\ast}) = {\mathrm{alloctables}}({\mathit{s}}_{{1}}, {{\mathit{tabletype}'}^\ast}, {{\mathit{ref}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocmem}}({\mathit{s}}, {}[{\mathit{i}} .. {\mathit{j}}]~\mathsf{i{\scriptstyle8}}) &=& ({\mathit{s}}{}[\mathsf{mems} = ..{\mathit{mi}}],\, {|{\mathit{s}}.\mathsf{mems}|})
  &\qquad \mbox{if}~{\mathit{mi}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~({}[{\mathit{i}} .. {\mathit{j}}]~\mathsf{i{\scriptstyle8}}),\; \mathsf{bytes}~{0^{{\mathit{i}} \cdot 64 \, {\mathrm{Ki}}}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocmems}}({\mathit{s}}, \epsilon) &=& ({\mathit{s}},\, \epsilon) \\
{\mathrm{allocmems}}({\mathit{s}}, {\mathit{memtype}}~{{\mathit{memtype}'}^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{ma}}~{{\mathit{ma}'}^\ast})
  &\qquad \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{ma}}) = {\mathrm{allocmem}}({\mathit{s}}, {\mathit{memtype}}) \\
  &&&\qquad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ma}'}^\ast}) = {\mathrm{allocmems}}({\mathit{s}}_{{1}}, {{\mathit{memtype}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocelem}}({\mathit{s}}, {\mathit{rt}}, {{\mathit{ref}}^\ast}) &=& ({\mathit{s}}{}[\mathsf{elems} = ..{\mathit{ei}}],\, {|{\mathit{s}}.\mathsf{elems}|})
  &\qquad \mbox{if}~{\mathit{ei}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{rt}},\; \mathsf{refs}~{{\mathit{ref}}^\ast} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocelems}}({\mathit{s}}, \epsilon, \epsilon) &=& ({\mathit{s}},\, \epsilon) \\
{\mathrm{allocelems}}({\mathit{s}}, {\mathit{rt}}~{{\mathit{rt}'}^\ast}, ({{\mathit{ref}}^\ast})~{({{\mathit{ref}'}^\ast})^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{ea}}~{{\mathit{ea}'}^\ast})
  &\qquad \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{ea}}) = {\mathrm{allocelem}}({\mathit{s}}, {\mathit{rt}}, {{\mathit{ref}}^\ast}) \\
  &&&\qquad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ea}'}^\ast}) = {\mathrm{allocelems}}({\mathit{s}}_{{2}}, {{\mathit{rt}'}^\ast}, {({{\mathit{ref}'}^\ast})^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocdata}}({\mathit{s}}, {{\mathit{byte}}^\ast}) &=& ({\mathit{s}}{}[\mathsf{datas} = ..{\mathit{di}}],\, {|{\mathit{s}}.\mathsf{datas}|})
  &\qquad \mbox{if}~{\mathit{di}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{bytes}~{{\mathit{byte}}^\ast} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocdatas}}({\mathit{s}}, \epsilon) &=& ({\mathit{s}},\, \epsilon) \\
{\mathrm{allocdatas}}({\mathit{s}}, ({{\mathit{byte}}^\ast})~{({{\mathit{byte}'}^\ast})^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{da}}~{{\mathit{da}'}^\ast})
  &\qquad \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{da}}) = {\mathrm{allocdata}}({\mathit{s}}, {{\mathit{byte}}^\ast}) \\
  &&&\qquad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{da}'}^\ast}) = {\mathrm{allocdatas}}({\mathit{s}}_{{1}}, {({{\mathit{byte}'}^\ast})^\ast}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{instexport}}({{\mathit{fa}}^\ast}, {{\mathit{ga}}^\ast}, {{\mathit{ta}}^\ast}, {{\mathit{ma}}^\ast}, \mathsf{export}~{\mathit{name}}~(\mathsf{func}~{\mathit{x}})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{func}~{{\mathit{fa}}^\ast}{}[{\mathit{x}}]) \}\end{array} \\
{\mathrm{instexport}}({{\mathit{fa}}^\ast}, {{\mathit{ga}}^\ast}, {{\mathit{ta}}^\ast}, {{\mathit{ma}}^\ast}, \mathsf{export}~{\mathit{name}}~(\mathsf{global}~{\mathit{x}})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{global}~{{\mathit{ga}}^\ast}{}[{\mathit{x}}]) \}\end{array} \\
{\mathrm{instexport}}({{\mathit{fa}}^\ast}, {{\mathit{ga}}^\ast}, {{\mathit{ta}}^\ast}, {{\mathit{ma}}^\ast}, \mathsf{export}~{\mathit{name}}~(\mathsf{table}~{\mathit{x}})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{table}~{{\mathit{ta}}^\ast}{}[{\mathit{x}}]) \}\end{array} \\
{\mathrm{instexport}}({{\mathit{fa}}^\ast}, {{\mathit{ga}}^\ast}, {{\mathit{ta}}^\ast}, {{\mathit{ma}}^\ast}, \mathsf{export}~{\mathit{name}}~(\mathsf{mem}~{\mathit{x}})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{mem}~{{\mathit{ma}}^\ast}{}[{\mathit{x}}]) \}\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocmodule}}({\mathit{s}}, {\mathit{module}}, {{\mathit{externval}}^\ast}, {{\mathit{val}}_{{\mathit{g}}}^\ast}, {{\mathit{ref}}_{{\mathit{t}}}^\ast}, {({{\mathit{ref}}_{{\mathit{e}}}^\ast})^\ast}) &=& ({\mathit{s}}_{{6}},\, {\mathit{mm}})
  &\qquad \mbox{if}~{\mathit{module}} = \begin{array}[t]{@{}l@{}} \mathsf{module} \\ {{\mathit{type}}^\ast} \\ {{\mathit{import}}^\ast} \\ {{\mathit{func}}^{{\mathit{n}}_{{\mathit{f}}}}} \\ {(\mathsf{global}~{\mathit{globaltype}}~{\mathit{expr}}_{{\mathit{g}}})^{{\mathit{n}}_{{\mathit{g}}}}} \\ {(\mathsf{table}~{\mathit{tabletype}}~{\mathit{expr}}_{{\mathit{t}}})^{{\mathit{n}}_{{\mathit{t}}}}} \\ {(\mathsf{memory}~{\mathit{memtype}})^{{\mathit{n}}_{{\mathit{m}}}}} \\ {(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}_{{\mathit{e}}}^\ast}~{\mathit{elemmode}})^{{\mathit{n}}_{{\mathit{e}}}}} \\ {(\mathsf{data}~{{\mathit{byte}}^\ast}~{\mathit{datamode}})^{{\mathit{n}}_{{\mathit{d}}}}} \\ {{\mathit{start}}^?} \\ {{\mathit{export}}^\ast} \end{array} \\
  &&&\qquad {\land}~{{\mathit{fa}}_{{\mathit{ex}}}^\ast} = {\mathrm{funcs}}({{\mathit{externval}}^\ast}) \\
  &&&\qquad {\land}~{{\mathit{ga}}_{{\mathit{ex}}}^\ast} = {\mathrm{globals}}({{\mathit{externval}}^\ast}) \\
  &&&\qquad {\land}~{{\mathit{ta}}_{{\mathit{ex}}}^\ast} = {\mathrm{tables}}({{\mathit{externval}}^\ast}) \\
  &&&\qquad {\land}~{{\mathit{ma}}_{{\mathit{ex}}}^\ast} = {\mathrm{mems}}({{\mathit{externval}}^\ast}) \\
  &&&\qquad {\land}~{{\mathit{fa}}^\ast} = {{|{\mathit{s}}.\mathsf{funcs}|} + {\mathit{i}}_{{\mathit{f}}}^{{\mathit{i}}_{{\mathit{f}}}<{\mathit{n}}_{{\mathit{f}}}}} \\
  &&&\qquad {\land}~{{\mathit{ga}}^\ast} = {{|{\mathit{s}}.\mathsf{globals}|} + {\mathit{i}}_{{\mathit{g}}}^{{\mathit{i}}_{{\mathit{g}}}<{\mathit{n}}_{{\mathit{g}}}}} \\
  &&&\qquad {\land}~{{\mathit{ta}}^\ast} = {{|{\mathit{s}}.\mathsf{tables}|} + {\mathit{i}}_{{\mathit{t}}}^{{\mathit{i}}_{{\mathit{t}}}<{\mathit{n}}_{{\mathit{t}}}}} \\
  &&&\qquad {\land}~{{\mathit{ma}}^\ast} = {{|{\mathit{s}}.\mathsf{mems}|} + {\mathit{i}}_{{\mathit{m}}}^{{\mathit{i}}_{{\mathit{m}}}<{\mathit{n}}_{{\mathit{m}}}}} \\
  &&&\qquad {\land}~{{\mathit{ea}}^\ast} = {{|{\mathit{s}}.\mathsf{elems}|} + {\mathit{i}}_{{\mathit{e}}}^{{\mathit{i}}_{{\mathit{e}}}<{\mathit{n}}_{{\mathit{e}}}}} \\
  &&&\qquad {\land}~{{\mathit{da}}^\ast} = {{|{\mathit{s}}.\mathsf{datas}|} + {\mathit{i}}_{{\mathit{d}}}^{{\mathit{i}}_{{\mathit{d}}}<{\mathit{n}}_{{\mathit{d}}}}} \\
  &&&\qquad {\land}~{{\mathit{xi}}^\ast} = {{\mathrm{instexport}}({{\mathit{fa}}_{{\mathit{ex}}}^\ast}~{{\mathit{fa}}^\ast}, {{\mathit{ga}}_{{\mathit{ex}}}^\ast}~{{\mathit{ga}}^\ast}, {{\mathit{ta}}_{{\mathit{ex}}}^\ast}~{{\mathit{ta}}^\ast}, {{\mathit{ma}}_{{\mathit{ex}}}^\ast}~{{\mathit{ma}}^\ast}, {\mathit{export}})^\ast} \\
  &&&\qquad {\land}~{\mathit{mm}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{types}~{{\mathit{dt}}^\ast},\; \\
  \mathsf{funcs}~{{\mathit{fa}}_{{\mathit{ex}}}^\ast}~{{\mathit{fa}}^\ast},\; \\
  \mathsf{globals}~{{\mathit{ga}}_{{\mathit{ex}}}^\ast}~{{\mathit{ga}}^\ast},\; \\
  \mathsf{tables}~{{\mathit{ta}}_{{\mathit{ex}}}^\ast}~{{\mathit{ta}}^\ast},\; \\
  \mathsf{mems}~{{\mathit{ma}}_{{\mathit{ex}}}^\ast}~{{\mathit{ma}}^\ast},\; \\
  \mathsf{elems}~{{\mathit{ea}}^\ast},\; \\
  \mathsf{datas}~{{\mathit{da}}^\ast},\; \\
  \mathsf{exports}~{{\mathit{xi}}^\ast} \}\end{array} \\
  &&&\qquad {\land}~{{\mathit{dt}}^\ast} = {\mathrm{alloctypes}}({{\mathit{type}}^\ast}) \\
  &&&\qquad {\land}~({\mathit{s}}_{{1}},\, {{\mathit{fa}}^\ast}) = {\mathrm{allocfuncs}}({\mathit{s}}, {\mathit{mm}}, {{\mathit{func}}^{{\mathit{n}}_{{\mathit{f}}}}}) \\
  &&&\qquad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ga}}^\ast}) = {\mathrm{allocglobals}}({\mathit{s}}_{{1}}, {{\mathit{globaltype}}^{{\mathit{n}}_{{\mathit{g}}}}}, {{\mathit{val}}_{{\mathit{g}}}^\ast}) \\
  &&&\qquad {\land}~({\mathit{s}}_{{3}},\, {{\mathit{ta}}^\ast}) = {\mathrm{alloctables}}({\mathit{s}}_{{2}}, {{\mathit{tabletype}}^{{\mathit{n}}_{{\mathit{t}}}}}, {{\mathit{ref}}_{{\mathit{t}}}^\ast}) \\
  &&&\qquad {\land}~({\mathit{s}}_{{4}},\, {{\mathit{ma}}^\ast}) = {\mathrm{allocmems}}({\mathit{s}}_{{3}}, {{\mathit{memtype}}^{{\mathit{n}}_{{\mathit{m}}}}}) \\
  &&&\qquad {\land}~({\mathit{s}}_{{5}},\, {{\mathit{ea}}^\ast}) = {\mathrm{allocelems}}({\mathit{s}}_{{4}}, {{\mathit{reftype}}^{{\mathit{n}}_{{\mathit{e}}}}}, {({{\mathit{ref}}_{{\mathit{e}}}^\ast})^\ast}) \\
  &&&\qquad {\land}~({\mathit{s}}_{{6}},\, {{\mathit{da}}^\ast}) = {\mathrm{allocdatas}}({\mathit{s}}_{{5}}, {({{\mathit{byte}}^\ast})^{{\mathit{n}}_{{\mathit{d}}}}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{runelem}}(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}^\ast}~(\mathsf{passive}), {\mathit{y}}) &=& \epsilon \\
{\mathrm{runelem}}(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}^\ast}~(\mathsf{declare}), {\mathit{y}}) &=& (\mathsf{elem.drop}~{\mathit{y}}) \\
{\mathrm{runelem}}(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}^\ast}~(\mathsf{active}~{\mathit{x}}~{{\mathit{instr}}^\ast}), {\mathit{y}}) &=& {{\mathit{instr}}^\ast}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{{\mathit{expr}}^\ast}|})~(\mathsf{table.init}~{\mathit{x}}~{\mathit{y}})~(\mathsf{elem.drop}~{\mathit{y}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{rundata}}(\mathsf{data}~{{\mathit{byte}}^\ast}~(\mathsf{passive}), {\mathit{y}}) &=& \epsilon \\
{\mathrm{rundata}}(\mathsf{data}~{{\mathit{byte}}^\ast}~(\mathsf{active}~{\mathit{x}}~{{\mathit{instr}}^\ast}), {\mathit{y}}) &=& {{\mathit{instr}}^\ast}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{{\mathit{byte}}^\ast}|})~(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}})~(\mathsf{data.drop}~{\mathit{y}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{instantiate}}({\mathit{s}}, {\mathit{module}}, {{\mathit{externval}}^\ast}) &=& {\mathit{s}'} ; {\mathit{f}} ; {{\mathit{instr}}_{{\mathit{E}}}^\ast}~{{\mathit{instr}}_{{\mathsf{d}}}^\ast}~{(\mathsf{call}~{\mathit{x}})^?}
  &\qquad \mbox{if}~{\mathit{module}} = \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast} \\
  &&&\qquad {\land}~{{\mathit{global}}^\ast} = {(\mathsf{global}~{\mathit{globaltype}}~{\mathit{expr}}_{{\mathsf{g}}})^\ast} \\
  &&&\qquad {\land}~{{\mathit{table}}^\ast} = {(\mathsf{table}~{\mathit{tabletype}}~{\mathit{expr}}_{{\mathsf{t}}})^\ast} \\
  &&&\qquad {\land}~{{\mathit{elem}}^\ast} = {(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}_{{\mathit{E}}}^\ast}~{\mathit{elemmode}})^\ast} \\
  &&&\qquad {\land}~{{\mathit{start}}^?} = {(\mathsf{start}~{\mathit{x}})^?} \\
  &&&\qquad {\land}~{\mathit{n}}_{{\mathsf{f}}} = {|{{\mathit{func}}^\ast}|} \\
  &&&\qquad {\land}~{\mathit{n}}_{{\mathit{E}}} = {|{{\mathit{elem}}^\ast}|} \\
  &&&\qquad {\land}~{\mathit{n}}_{{\mathsf{d}}} = {|{{\mathit{data}}^\ast}|} \\
  &&&\qquad {\land}~{\mathit{mm}}_{{\mathit{init}}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{types}~{\mathrm{alloctypes}}({{\mathit{type}}^\ast}),\; \\
  \mathsf{funcs}~{\mathrm{funcs}}({{\mathit{externval}}^\ast})~{{|{\mathit{s}}.\mathsf{funcs}|} + {\mathit{i}}_{{\mathsf{f}}}^{{\mathit{i}}_{{\mathsf{f}}}<{\mathit{n}}_{{\mathsf{f}}}}},\; \\
  \mathsf{globals}~{\mathrm{globals}}({{\mathit{externval}}^\ast}),\; \\
   \}\end{array} \\
  &&&\qquad {\land}~{\mathit{z}} = {\mathit{s}} ; \{ \begin{array}[t]{@{}l@{}}
\mathsf{module}~{\mathit{mm}}_{{\mathit{init}}} \}\end{array} \\
  &&&\qquad {\land}~({\mathit{z}} ; {\mathit{expr}}_{{\mathsf{g}}} \hookrightarrow^\ast {\mathit{z}} ; {\mathit{val}}_{{\mathsf{g}}})^\ast \\
  &&&\qquad {\land}~({\mathit{z}} ; {\mathit{expr}}_{{\mathsf{t}}} \hookrightarrow^\ast {\mathit{z}} ; {\mathit{ref}}_{{\mathsf{t}}})^\ast \\
  &&&\qquad {\land}~{({\mathit{z}} ; {\mathit{expr}}_{{\mathit{E}}} \hookrightarrow^\ast {\mathit{z}} ; {\mathit{ref}}_{{\mathit{E}}})^\ast}^\ast \\
  &&&\qquad {\land}~({\mathit{s}'},\, {\mathit{mm}}) = {\mathrm{allocmodule}}({\mathit{s}}, {\mathit{module}}, {{\mathit{externval}}^\ast}, {{\mathit{val}}_{{\mathsf{g}}}^\ast}, {{\mathit{ref}}_{{\mathsf{t}}}^\ast}, {({{\mathit{ref}}_{{\mathit{E}}}^\ast})^\ast}) \\
  &&&\qquad {\land}~{\mathit{f}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{module}~{\mathit{mm}} \}\end{array} \\
  &&&\qquad {\land}~{{\mathit{instr}}_{{\mathit{E}}}^\ast} = {\mathrm{concat}}({{\mathrm{runelem}}({{\mathit{elem}}^\ast}{}[{\mathit{i}}], {\mathit{i}})^{{\mathit{i}}<{\mathit{n}}_{{\mathit{E}}}}}) \\
  &&&\qquad {\land}~{{\mathit{instr}}_{{\mathsf{d}}}^\ast} = {\mathrm{concat}}({{\mathrm{rundata}}({{\mathit{data}}^\ast}{}[{\mathit{j}}], {\mathit{j}})^{{\mathit{j}}<{\mathit{n}}_{{\mathsf{d}}}}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{invoke}}({\mathit{s}}, {\mathit{fa}}, {{\mathit{val}}^{{\mathit{n}}}}) &=& {\mathit{s}} ; {\mathit{f}} ; {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{ref.func}~{\mathit{fa}})~(\mathsf{call\_ref}~({\mathit{s}} ; {\mathit{f}}).\mathsf{funcs}{}[{\mathit{fa}}].\mathsf{type})
  &\qquad \mbox{if}~{\mathit{f}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{module}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \}\end{array} \\
  &&&\qquad {\land}~({\mathit{s}} ; {\mathit{f}}).\mathsf{funcs}{}[{\mathit{fa}}].\mathsf{code} = \mathsf{func}~{\mathit{x}}~{{\mathit{local}}^\ast}~{\mathit{expr}} \\
  &&&\qquad {\land}~{\mathit{s}}.\mathsf{funcs}{}[{\mathit{fa}}].\mathsf{type} \approx \mathsf{func}~({{\mathit{t}}_{{1}}^{{\mathit{n}}}} \rightarrow {{\mathit{t}}_{{2}}^\ast}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{vec}}({\mathtt{X}}) &::=& {\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}}~{({\mathit{el}}{:}{\mathtt{X}})^{{\mathit{n}}}} &\Rightarrow& {{\mathit{el}}^{{\mathit{n}}}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{byte}} &::=& {\mathit{b}}{:}\mathtt{0x00} ~|~ \dots ~|~ {\mathit{b}}{:}\mathtt{0xFF} &\Rightarrow& {\mathit{b}} \\
& {{\mathtt{u}}}{{\mathit{N}}{:}{\mathtt{N}}} &::=& {\mathit{n}}{:}{\mathtt{byte}} &\Rightarrow& {\mathit{n}}
  &\qquad \mbox{if}~{\mathit{n}} < {2^{7}} \land {\mathit{n}} < {2^{{\mathit{N}}}} \\ &&|&
{\mathit{n}}{:}{\mathtt{byte}}~{\mathit{m}}{:}{{\mathtt{u}}}{({\mathit{N}} - 7)} &\Rightarrow& {2^{7}} \cdot {\mathit{m}} + ({\mathit{n}} - {2^{7}})
  &\qquad \mbox{if}~{\mathit{n}} \geq {2^{7}} \land {\mathit{N}} > 7 \\
& {{\mathtt{s}}}{{\mathit{N}}{:}{\mathtt{N}}} &::=& {\mathit{n}}{:}{\mathtt{byte}} &\Rightarrow& {\mathit{n}}
  &\qquad \mbox{if}~{\mathit{n}} < {2^{6}} \land {\mathit{n}} < {2^{{\mathit{N}} - 1}} \\ &&|&
{\mathit{n}}{:}{\mathtt{byte}} &\Rightarrow& {\mathit{n}} - {2^{7}}
  &\qquad \mbox{if}~{2^{6}} \leq {\mathit{n}} < {2^{7}} \land {\mathit{n}} \geq {2^{7}} - {2^{{\mathit{N}} - 1}} \\ &&|&
{\mathit{n}}{:}{\mathtt{byte}}~{\mathit{i}}{:}{{\mathtt{u}}}{({\mathit{N}} - 7)} &\Rightarrow& {2^{7}} \cdot {\mathit{i}} + ({\mathit{n}} - {2^{7}})
  &\qquad \mbox{if}~{\mathit{n}} \geq {2^{7}} \land {\mathit{N}} > 7 \\
& {{\mathtt{i}}}{{\mathit{N}}{:}{\mathtt{N}}} &::=& {\mathit{i}}{:}{{\mathtt{s}}}{{\mathtt{N}}} &\Rightarrow& {{{{\mathrm{signed}}}_{{\mathit{N}}}^{{-1}}}}{({\mathit{i}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {{\mathtt{f}}}{{\mathit{N}}{:}{\mathtt{N}}} &::=& {{\mathit{b}}^\ast}{:}{{\mathtt{byte}}^{{\mathit{N}} / 8}} &\Rightarrow& {\mathrm{invfbytes}}({\mathit{N}}, {{\mathit{b}}^\ast}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{u{\scriptstyle32}}} &::=& {\mathit{n}}{:}{{\mathtt{u}}}{32} &\Rightarrow& {\mathit{n}} \\
& {\mathtt{u{\scriptstyle64}}} &::=& {\mathit{n}}{:}{{\mathtt{u}}}{64} &\Rightarrow& {\mathit{n}} \\
& {\mathtt{s{\scriptstyle33}}} &::=& {\mathit{i}}{:}{{\mathtt{s}}}{33} &\Rightarrow& {\mathit{i}} \\
& {\mathtt{f{\scriptstyle32}}} &::=& {\mathit{p}}{:}{{\mathtt{f}}}{32} &\Rightarrow& {\mathit{p}} \\
& {\mathtt{f{\scriptstyle64}}} &::=& {\mathit{p}}{:}{{\mathtt{f}}}{64} &\Rightarrow& {\mathit{p}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{utf{\scriptstyle8}}}({\mathit{ch}}) &=& {\mathit{b}}
  &\qquad \mbox{if}~{\mathit{ch}} < \mathrm{U{+}80} \land {\mathit{ch}} = {\mathit{b}} \\
{\mathrm{utf{\scriptstyle8}}}({\mathit{ch}}) &=& {\mathit{b}}_{{1}}~{\mathit{b}}_{{2}}
  &\qquad \mbox{if}~\mathrm{U{+}80} \leq {\mathit{ch}} < \mathrm{U{+}0800} \land {\mathit{ch}} = {2^{6}} \cdot ({\mathit{b}}_{{1}} - \mathtt{0xC0}) + ({\mathit{b}}_{{2}} - \mathtt{0x80}) \\
{\mathrm{utf{\scriptstyle8}}}({\mathit{ch}}) &=& {\mathit{b}}_{{1}}~{\mathit{b}}_{{2}}~{\mathit{b}}_{{3}}
  &\qquad \mbox{if}~(\mathrm{U{+}0800} \leq {\mathit{ch}} < \mathrm{U{+}D800} \lor \mathrm{U{+}E000} \leq {\mathit{ch}} < \mathrm{U{+}10000}) \land {\mathit{ch}} = {2^{12}} \cdot ({\mathit{b}}_{{1}} - \mathtt{0xE0}) + {2^{6}} \cdot ({\mathit{b}}_{{2}} - \mathtt{0x80}) + ({\mathit{b}}_{{3}} - \mathtt{0x80}) \\
{\mathrm{utf{\scriptstyle8}}}({\mathit{ch}}) &=& {\mathit{b}}_{{1}}~{\mathit{b}}_{{2}}~{\mathit{b}}_{{3}}~{\mathit{b}}_{{4}}
  &\qquad \mbox{if}~(\mathrm{U{+}10000} \leq {\mathit{ch}} < \mathrm{U{+}11000}) \land {\mathit{ch}} = {2^{18}} \cdot ({\mathit{b}}_{{1}} - \mathtt{0xF0}) + {2^{12}} \cdot ({\mathit{b}}_{{2}} - \mathtt{0x80}) + {2^{6}} \cdot ({\mathit{b}}_{{3}} - \mathtt{0x80}) + ({\mathit{b}}_{{4}} - \mathtt{0x80}) \\
{\mathrm{utf{\scriptstyle8}}}({{\mathit{ch}}^\ast}) &=& {\mathrm{concat}}({{\mathrm{utf{\scriptstyle8}}}({\mathit{ch}})^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{name}} &::=& {{\mathit{b}}^\ast}{:}{\mathtt{vec}}({\mathtt{byte}}) &\Rightarrow& {\mathit{name}}
  &\qquad \mbox{if}~{\mathrm{utf{\scriptstyle8}}}({\mathit{name}}) = {{\mathit{b}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{typeidx}} &::=& {\mathit{x}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{x}} \\
& {\mathtt{funcidx}} &::=& {\mathit{x}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{x}} \\
& {\mathtt{globalidx}} &::=& {\mathit{x}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{x}} \\
& {\mathtt{tableidx}} &::=& {\mathit{x}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{x}} \\
& {\mathtt{memidx}} &::=& {\mathit{x}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{x}} \\
& {\mathtt{elemidx}} &::=& {\mathit{x}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{x}} \\
& {\mathtt{dataidx}} &::=& {\mathit{x}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{x}} \\
& {\mathtt{localidx}} &::=& {\mathit{x}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{x}} \\
& {\mathtt{labelidx}} &::=& {\mathit{x}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{x}} \\
& {\mathtt{externidx}} &::=& \mathtt{0x00}~{\mathit{x}}{:}{\mathtt{funcidx}} &\Rightarrow& \mathsf{func}~{\mathit{x}} \\ &&|&
\mathtt{0x01}~{\mathit{x}}{:}{\mathtt{tableidx}} &\Rightarrow& \mathsf{table}~{\mathit{x}} \\ &&|&
\mathtt{0x02}~{\mathit{x}}{:}{\mathtt{memidx}} &\Rightarrow& \mathsf{mem}~{\mathit{x}} \\ &&|&
\mathtt{0x03}~{\mathit{x}}{:}{\mathtt{globalidx}} &\Rightarrow& \mathsf{global}~{\mathit{x}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{numtype}} &::=& \mathtt{0x7F} &\Rightarrow& \mathsf{i{\scriptstyle32}} \\ &&|&
\mathtt{0x7E} &\Rightarrow& \mathsf{i{\scriptstyle64}} \\ &&|&
\mathtt{0x7D} &\Rightarrow& \mathsf{f{\scriptstyle32}} \\ &&|&
\mathtt{0x7C} &\Rightarrow& \mathsf{f{\scriptstyle64}} \\
& {\mathtt{vectype}} &::=& \mathtt{0x7B} &\Rightarrow& \mathsf{v{\scriptstyle128}} \\
& {\mathtt{absheaptype}} &::=& \mathtt{0x73} &\Rightarrow& \mathsf{nofunc} \\ &&|&
\mathtt{0x72} &\Rightarrow& \mathsf{noextern} \\ &&|&
\mathtt{0x71} &\Rightarrow& \mathsf{none} \\ &&|&
\mathtt{0x70} &\Rightarrow& \mathsf{func} \\ &&|&
\mathtt{0x6F} &\Rightarrow& \mathsf{extern} \\ &&|&
\mathtt{0x6E} &\Rightarrow& \mathsf{any} \\ &&|&
\mathtt{0x6D} &\Rightarrow& \mathsf{eq} \\ &&|&
\mathtt{0x6C} &\Rightarrow& \mathsf{i{\scriptstyle31}} \\ &&|&
\mathtt{0x6B} &\Rightarrow& \mathsf{struct} \\ &&|&
\mathtt{0x6A} &\Rightarrow& \mathsf{array} \\
& {\mathtt{heaptype}} &::=& {\mathit{ht}}{:}{\mathtt{absheaptype}} &\Rightarrow& {\mathit{ht}} \\ &&|&
{{\mathit{x}}}{:}{\mathtt{s{\scriptstyle33}}} &\Rightarrow& {{\mathit{x}}}
  &\qquad \mbox{if}~{{\mathit{x}}} \geq 0 \\
& {\mathtt{reftype}} &::=& \mathtt{0x64}~{\mathit{ht}}{:}{\mathtt{heaptype}} &\Rightarrow& \mathsf{ref}~{\mathit{ht}} \\ &&|&
\mathtt{0x63}~{\mathit{ht}}{:}{\mathtt{heaptype}} &\Rightarrow& \mathsf{ref}~\mathsf{null}~{\mathit{ht}} \\ &&|&
{\mathit{ht}}{:}{\mathtt{absheaptype}} &\Rightarrow& \mathsf{ref}~\mathsf{null}~{\mathit{ht}} \\
& {\mathtt{valtype}} &::=& {\mathit{nt}}{:}{\mathtt{numtype}} &\Rightarrow& {\mathit{nt}} \\ &&|&
{\mathit{vt}}{:}{\mathtt{vectype}} &\Rightarrow& {\mathit{vt}} \\ &&|&
{\mathit{rt}}{:}{\mathtt{reftype}} &\Rightarrow& {\mathit{rt}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{resulttype}} &::=& {{\mathit{t}}^\ast}{:}{\mathtt{vec}}({\mathtt{valtype}}) &\Rightarrow& {{\mathit{t}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{mut}} &::=& \mathtt{0x00} &\Rightarrow& \epsilon \\ &&|&
\mathtt{0x01} &\Rightarrow& \mathsf{mut} \\
& {\mathtt{packtype}} &::=& \mathtt{0x78} &\Rightarrow& \mathsf{i{\scriptstyle8}} \\ &&|&
\mathtt{0x77} &\Rightarrow& \mathsf{i{\scriptstyle16}} \\
& {\mathtt{storagetype}} &::=& {\mathit{t}}{:}{\mathtt{valtype}} &\Rightarrow& {\mathit{t}} \\ &&|&
{\mathit{pt}}{:}{\mathtt{packtype}} &\Rightarrow& {\mathit{pt}} \\
& {\mathtt{fieldtype}} &::=& {\mathit{zt}}{:}{\mathtt{storagetype}}~{\mathit{mut}}{:}{\mathtt{mut}} &\Rightarrow& {\mathit{mut}}~{\mathit{zt}} \\
& {\mathtt{comptype}} &::=& \mathtt{0x60}~{{\mathit{t}}_{{1}}^\ast}{:}{\mathtt{resulttype}}~{{\mathit{t}}_{{2}}^\ast}{:}{\mathtt{resulttype}} &\Rightarrow& \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}) \\ &&|&
\mathtt{0x59}~{{\mathit{yt}}^\ast}{:}{\mathtt{vec}}({\mathtt{fieldtype}}) &\Rightarrow& \mathsf{struct}~{{\mathit{yt}}^\ast} \\ &&|&
\mathtt{0x58}~{\mathit{yt}}{:}{\mathtt{fieldtype}} &\Rightarrow& \mathsf{array}~{\mathit{yt}} \\
& {\mathtt{subtype}} &::=& \mathtt{0x50}~{{\mathit{x}}^\ast}{:}{\mathtt{vec}}({\mathtt{typeidx}})~{\mathit{ct}}{:}{\mathtt{comptype}} &\Rightarrow& \mathsf{sub}~{{\mathit{x}}^\ast}~{\mathit{ct}} \\ &&|&
\mathtt{0x49}~{{\mathit{x}}^\ast}{:}{\mathtt{vec}}({\mathtt{typeidx}})~{\mathit{ct}}{:}{\mathtt{comptype}} &\Rightarrow& \mathsf{sub}~\mathsf{final}~{{\mathit{x}}^\ast}~{\mathit{ct}} \\ &&|&
{\mathit{ct}}{:}{\mathtt{comptype}} &\Rightarrow& \mathsf{sub}~\mathsf{final}~\epsilon~{\mathit{ct}} \\
& {\mathtt{rectype}} &::=& \mathtt{0x48}~{{\mathit{st}}^\ast}{:}{\mathtt{vec}}({\mathtt{subtype}}) &\Rightarrow& \mathsf{rec}~{{\mathit{st}}^\ast} \\ &&|&
{\mathit{st}}{:}{\mathtt{subtype}} &\Rightarrow& \mathsf{rec}~{\mathit{st}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{limits}} &::=& \mathtt{0x00}~{\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {}[{\mathit{n}} .. {2^{32}} - 1] \\ &&|&
\mathtt{0x01}~{\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{m}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {}[{\mathit{n}} .. {\mathit{m}}] \\
& {\mathtt{globaltype}} &::=& {\mathit{t}}{:}{\mathtt{valtype}}~{\mathit{mut}}{:}{\mathtt{mut}} &\Rightarrow& {\mathit{mut}}~{\mathit{t}} \\
& {\mathtt{tabletype}} &::=& {\mathit{rt}}{:}{\mathtt{reftype}}~{\mathit{lim}}{:}{\mathtt{limits}} &\Rightarrow& {\mathit{lim}}~{\mathit{rt}} \\
& {\mathtt{memtype}} &::=& {\mathit{lim}}{:}{\mathtt{limits}} &\Rightarrow& {\mathit{lim}}~\mathsf{i{\scriptstyle8}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{externtype}} &::=& \mathtt{0x00}~{\mathit{x}}{:}{\mathtt{typeidx}} &\Rightarrow& \mathsf{func}~{\mathit{x}} \\ &&|&
\mathtt{0x01}~{\mathit{tt}}{:}{\mathtt{tabletype}} &\Rightarrow& \mathsf{table}~{\mathit{tt}} \\ &&|&
\mathtt{0x02}~{\mathit{mt}}{:}{\mathtt{memtype}} &\Rightarrow& \mathsf{mem}~{\mathit{mt}} \\ &&|&
\mathtt{0x03}~{\mathit{gt}}{:}{\mathtt{globaltype}} &\Rightarrow& \mathsf{global}~{\mathit{gt}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{blocktype}} &::=& \mathtt{0x40} &\Rightarrow& \epsilon \\ &&|&
{\mathit{t}}{:}{\mathtt{valtype}} &\Rightarrow& {\mathit{t}} \\ &&|&
{\mathit{i}}{:}{\mathtt{s{\scriptstyle33}}} &\Rightarrow& {\mathit{x}}
  &\qquad \mbox{if}~{\mathit{i}} \geq 0 \land {\mathit{i}} = {\mathit{x}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{instr}} &::=& \mathtt{0x00} &\Rightarrow& \mathsf{unreachable} \\ &&|&
\mathtt{0x01} &\Rightarrow& \mathsf{nop} \\ &&|&
\mathtt{0x02}~{\mathit{bt}}{:}{\mathtt{blocktype}}~{({\mathit{in}}{:}{\mathtt{instr}})^\ast}~\mathtt{0x0B} &\Rightarrow& \mathsf{block}~{\mathit{bt}}~{{\mathit{in}}^\ast} \\ &&|&
\mathtt{0x03}~{\mathit{bt}}{:}{\mathtt{blocktype}}~{({\mathit{in}}{:}{\mathtt{instr}})^\ast}~\mathtt{0x0B} &\Rightarrow& \mathsf{loop}~{\mathit{bt}}~{{\mathit{in}}^\ast} \\ &&|&
\mathtt{0x04}~{\mathit{bt}}{:}{\mathtt{blocktype}}~{({\mathit{in}}{:}{\mathtt{instr}})^\ast}~\mathtt{0x0B} &\Rightarrow& \mathsf{if}~{\mathit{bt}}~{{\mathit{in}}^\ast}~\mathsf{else}~\epsilon \\ &&|&
\mathtt{0x04}~{\mathit{bt}}{:}{\mathtt{blocktype}}~{({\mathit{in}}_{{1}}{:}{\mathtt{instr}})^\ast}~\mathtt{0x05}~{({\mathit{in}}_{{2}}{:}{\mathtt{instr}})^\ast}~\mathtt{0x0B} &\Rightarrow& \mathsf{if}~{\mathit{bt}}~{{\mathit{in}}_{{1}}^\ast}~\mathsf{else}~{{\mathit{in}}_{{2}}^\ast} \\ &&|&
\mathtt{0x0C}~{\mathit{l}}{:}{\mathtt{labelidx}} &\Rightarrow& \mathsf{br}~{\mathit{l}} \\ &&|&
\mathtt{0x0D}~{\mathit{l}}{:}{\mathtt{labelidx}} &\Rightarrow& \mathsf{br\_if}~{\mathit{l}} \\ &&|&
\mathtt{0x0E}~{{\mathit{l}}^\ast}{:}{\mathtt{vec}}({\mathtt{labelidx}})~{\mathit{l}}_{{\mathit{N}}}{:}{\mathtt{labelidx}} &\Rightarrow& \mathsf{br\_table}~{{\mathit{l}}^\ast}~{\mathit{l}}_{{\mathit{N}}} \\ &&|&
\mathtt{0x0F} &\Rightarrow& \mathsf{return} \\ &&|&
\mathtt{0x10}~{\mathit{x}}{:}{\mathtt{funcidx}} &\Rightarrow& \mathsf{call}~{\mathit{x}} \\ &&|&
\mathtt{0x11}~{\mathit{y}}{:}{\mathtt{typeidx}}~{\mathit{x}}{:}{\mathtt{tableidx}} &\Rightarrow& \mathsf{call\_indirect}~{\mathit{x}}~{\mathit{y}} \\ &&|&
\mathtt{0x12}~{\mathit{x}}{:}{\mathtt{funcidx}} &\Rightarrow& \mathsf{return\_call}~{\mathit{x}} \\ &&|&
\mathtt{0x13}~{\mathit{y}}{:}{\mathtt{typeidx}}~{\mathit{x}}{:}{\mathtt{tableidx}} &\Rightarrow& \mathsf{return\_call\_indirect}~{\mathit{x}}~{\mathit{y}} \\ &&|&
\dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{castop}} &::=& ({\mathit{nul}},\, {\mathit{nul}}) \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{castop}} &::=& \mathtt{0x00} &\Rightarrow& (\epsilon,\, \epsilon) \\ &&|&
\mathtt{0x01} &\Rightarrow& (\mathsf{null},\, \epsilon) \\ &&|&
\mathtt{0x02} &\Rightarrow& (\epsilon,\, \mathsf{null}) \\ &&|&
\mathtt{0x03} &\Rightarrow& (\mathsf{null},\, \mathsf{null}) \\
& {\mathtt{instr}} &::=& \dots \\ &&|&
\mathtt{0xD0}~{\mathit{ht}}{:}{\mathtt{heaptype}} &\Rightarrow& \mathsf{ref.null}~{\mathit{ht}} \\ &&|&
\mathtt{0xD1} &\Rightarrow& \mathsf{ref.is\_null} \\ &&|&
\mathtt{0xD2}~{\mathit{x}}{:}{\mathtt{funcidx}} &\Rightarrow& \mathsf{ref.func}~{\mathit{x}} \\ &&|&
\mathtt{0xD3} &\Rightarrow& \mathsf{ref.eq} \\ &&|&
\mathtt{0xD4} &\Rightarrow& \mathsf{ref.as\_non\_null} \\ &&|&
\mathtt{0xD5}~{\mathit{l}}{:}{\mathtt{labelidx}} &\Rightarrow& \mathsf{br\_on\_null}~{\mathit{l}} \\ &&|&
\mathtt{0xD6}~{\mathit{l}}{:}{\mathtt{labelidx}} &\Rightarrow& \mathsf{br\_on\_non\_null}~{\mathit{l}} \\ &&|&
\mathtt{0xFB}~20{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{ht}}{:}{\mathtt{heaptype}} &\Rightarrow& \mathsf{ref.test}~(\mathsf{ref}~{\mathit{ht}}) \\ &&|&
\mathtt{0xFB}~21{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{ht}}{:}{\mathtt{heaptype}} &\Rightarrow& \mathsf{ref.test}~(\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \\ &&|&
\mathtt{0xFB}~22{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{ht}}{:}{\mathtt{heaptype}} &\Rightarrow& \mathsf{ref.cast}~(\mathsf{ref}~{\mathit{ht}}) \\ &&|&
\mathtt{0xFB}~23{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{ht}}{:}{\mathtt{heaptype}} &\Rightarrow& \mathsf{ref.cast}~(\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \\ &&|&
\mathtt{0xFB}~24{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{nul}}_{{1}},\, {\mathit{nul}}_{{2}}){:}{\mathtt{castop}}~{\mathit{l}}{:}{\mathtt{labelidx}}~{\mathit{ht}}_{{1}}{:}{\mathtt{heaptype}}~{\mathit{ht}}_{{2}}{:}{\mathtt{heaptype}} &\Rightarrow& \mathsf{br\_on\_cast}~{\mathit{l}}~(\mathsf{ref}~{\mathit{nul}}_{{1}}~{\mathit{ht}}_{{1}})~(\mathsf{ref}~{\mathit{nul}}_{{2}}~{\mathit{ht}}_{{2}}) \\ &&|&
\mathtt{0xFB}~25{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{nul}}_{{1}},\, {\mathit{nul}}_{{2}}){:}{\mathtt{castop}}~{\mathit{l}}{:}{\mathtt{labelidx}}~{\mathit{ht}}_{{1}}{:}{\mathtt{heaptype}}~{\mathit{ht}}_{{2}}{:}{\mathtt{heaptype}} &\Rightarrow& \mathsf{br\_on\_cast\_fail}~{\mathit{l}}~(\mathsf{ref}~{\mathit{nul}}_{{1}}~{\mathit{ht}}_{{1}})~(\mathsf{ref}~{\mathit{nul}}_{{2}}~{\mathit{ht}}_{{2}}) \\ &&|&
\dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{instr}} &::=& \dots \\ &&|&
\mathtt{0xFB}~0{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}} &\Rightarrow& \mathsf{struct.new}~{\mathit{x}} \\ &&|&
\mathtt{0xFB}~1{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}} &\Rightarrow& \mathsf{struct.new\_default}~{\mathit{x}} \\ &&|&
\mathtt{0xFB}~2{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}}~{\mathit{i}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{struct.get}~{\mathit{x}}~{\mathit{i}} \\ &&|&
\mathtt{0xFB}~3{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}}~{\mathit{i}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {{\mathsf{struct.get}}{\mathsf{\_}}}{\mathsf{s}}~{\mathit{x}}~{\mathit{i}} \\ &&|&
\mathtt{0xFB}~4{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}}~{\mathit{i}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {{\mathsf{struct.get}}{\mathsf{\_}}}{\mathsf{u}}~{\mathit{x}}~{\mathit{i}} \\ &&|&
\mathtt{0xFB}~5{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}}~{\mathit{i}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{struct.set}~{\mathit{x}}~{\mathit{i}} \\ &&|&
\mathtt{0xFB}~6{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}} &\Rightarrow& \mathsf{array.new}~{\mathit{x}} \\ &&|&
\mathtt{0xFB}~7{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}} &\Rightarrow& \mathsf{array.new\_default}~{\mathit{x}} \\ &&|&
\mathtt{0xFB}~8{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}}~{\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}} \\ &&|&
\mathtt{0xFB}~9{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}}~{\mathit{y}}{:}{\mathtt{dataidx}} &\Rightarrow& \mathsf{array.new\_data}~{\mathit{x}}~{\mathit{y}} \\ &&|&
\mathtt{0xFB}~10{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}}~{\mathit{y}}{:}{\mathtt{elemidx}} &\Rightarrow& \mathsf{array.new\_elem}~{\mathit{x}}~{\mathit{y}} \\ &&|&
\mathtt{0xFB}~11{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}} &\Rightarrow& \mathsf{array.get}~{\mathit{x}} \\ &&|&
\mathtt{0xFB}~12{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}} &\Rightarrow& {{\mathsf{array.get}}{\mathsf{\_}}}{\mathsf{s}}~{\mathit{x}} \\ &&|&
\mathtt{0xFB}~13{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}} &\Rightarrow& {{\mathsf{array.get}}{\mathsf{\_}}}{\mathsf{u}}~{\mathit{x}} \\ &&|&
\mathtt{0xFB}~14{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}} &\Rightarrow& \mathsf{array.set}~{\mathit{x}} \\ &&|&
\mathtt{0xFB}~15{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{array.len} \\ &&|&
\mathtt{0xFB}~16{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}} &\Rightarrow& \mathsf{array.fill}~{\mathit{x}} \\ &&|&
\mathtt{0xFB}~17{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}_{{1}}{:}{\mathtt{typeidx}}~{\mathit{x}}_{{2}}{:}{\mathtt{typeidx}} &\Rightarrow& \mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}} \\ &&|&
\mathtt{0xFB}~18{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}}~{\mathit{y}}{:}{\mathtt{dataidx}} &\Rightarrow& \mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}} \\ &&|&
\mathtt{0xFB}~19{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}}~{\mathit{y}}{:}{\mathtt{elemidx}} &\Rightarrow& \mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}} \\ &&|&
\mathtt{0xFB}~26{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{any.convert\_extern} \\ &&|&
\mathtt{0xFB}~27{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{extern.convert\_any} \\ &&|&
\mathtt{0xFB}~28{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{ref.i{\scriptstyle31}} \\ &&|&
\mathtt{0xFB}~29{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {{\mathsf{i{\scriptstyle31}.get}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFB}~30{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {{\mathsf{i{\scriptstyle31}.get}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{instr}} &::=& \dots \\ &&|&
\mathtt{0x1A} &\Rightarrow& \mathsf{drop} \\ &&|&
\mathtt{0x1B} &\Rightarrow& \mathsf{select} \\ &&|&
\mathtt{0x1C}~{\mathit{ts}}{:}{\mathtt{vec}}({\mathtt{valtype}}) &\Rightarrow& \mathsf{select}~{\mathit{ts}} \\ &&|&
\dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{instr}} &::=& \dots \\ &&|&
\mathtt{0x20}~{\mathit{x}}{:}{\mathtt{localidx}} &\Rightarrow& \mathsf{local.get}~{\mathit{x}} \\ &&|&
\mathtt{0x21}~{\mathit{x}}{:}{\mathtt{localidx}} &\Rightarrow& \mathsf{local.set}~{\mathit{x}} \\ &&|&
\mathtt{0x22}~{\mathit{x}}{:}{\mathtt{localidx}} &\Rightarrow& \mathsf{local.tee}~{\mathit{x}} \\ &&|&
\mathtt{0x23}~{\mathit{x}}{:}{\mathtt{globalidx}} &\Rightarrow& \mathsf{global.get}~{\mathit{x}} \\ &&|&
\mathtt{0x24}~{\mathit{x}}{:}{\mathtt{globalidx}} &\Rightarrow& \mathsf{global.set}~{\mathit{x}} \\ &&|&
\dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{instr}} &::=& \dots \\ &&|&
\mathtt{0x25}~{\mathit{x}}{:}{\mathtt{tableidx}} &\Rightarrow& \mathsf{table.get}~{\mathit{x}} \\ &&|&
\mathtt{0x26}~{\mathit{x}}{:}{\mathtt{tableidx}} &\Rightarrow& \mathsf{table.set}~{\mathit{x}} \\ &&|&
\mathtt{0xFC}~12{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{y}}{:}{\mathtt{elemidx}}~{\mathit{x}}{:}{\mathtt{tableidx}} &\Rightarrow& \mathsf{table.init}~{\mathit{x}}~{\mathit{y}} \\ &&|&
\mathtt{0xFC}~13{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{elemidx}} &\Rightarrow& \mathsf{elem.drop}~{\mathit{x}} \\ &&|&
\mathtt{0xFC}~14{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}_{{1}}{:}{\mathtt{tableidx}}~{\mathit{x}}_{{2}}{:}{\mathtt{tableidx}} &\Rightarrow& \mathsf{table.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}} \\ &&|&
\mathtt{0xFC}~15{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{tableidx}} &\Rightarrow& \mathsf{table.grow}~{\mathit{x}} \\ &&|&
\mathtt{0xFC}~16{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{tableidx}} &\Rightarrow& \mathsf{table.size}~{\mathit{x}} \\ &&|&
\mathtt{0xFC}~17{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{tableidx}} &\Rightarrow& \mathsf{table.fill}~{\mathit{x}} \\ &&|&
\dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{memidxop}} &::=& ({\mathit{memidx}},\, {\mathit{memop}}) \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{memop}} &::=& {\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{m}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& (0,\, \{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~{\mathit{n}},\; \mathsf{offset}~{\mathit{m}} \}\end{array})
  &\qquad \mbox{if}~{\mathit{n}} < {2^{6}} \\ &&|&
{\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{memidx}}~{\mathit{m}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({\mathit{x}},\, \{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~{\mathit{n}},\; \mathsf{offset}~{\mathit{m}} \}\end{array})
  &\qquad \mbox{if}~{2^{6}} \leq {\mathit{n}} < {2^{7}} \\
& {\mathtt{instr}} &::=& \dots \\ &&|&
\mathtt{0x28}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{i{\scriptstyle32}}.\mathsf{load}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x29}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{i{\scriptstyle64}}.\mathsf{load}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x2A}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{f{\scriptstyle32}}.\mathsf{load}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x2B}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{f{\scriptstyle64}}.\mathsf{load}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x2C}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{load}}{{{8}{\mathsf{\_}}}{\mathsf{s}}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x2D}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{load}}{{{8}{\mathsf{\_}}}{\mathsf{u}}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x2E}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{load}}{{{16}{\mathsf{\_}}}{\mathsf{s}}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x2F}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{load}}{{{16}{\mathsf{\_}}}{\mathsf{u}}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x30}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{load}}{{{8}{\mathsf{\_}}}{\mathsf{s}}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x31}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{load}}{{{8}{\mathsf{\_}}}{\mathsf{u}}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x32}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{load}}{{{16}{\mathsf{\_}}}{\mathsf{s}}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x33}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{load}}{{{16}{\mathsf{\_}}}{\mathsf{u}}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x34}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{load}}{{{32}{\mathsf{\_}}}{\mathsf{s}}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x35}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{load}}{{{32}{\mathsf{\_}}}{\mathsf{u}}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x36}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{i{\scriptstyle32}}.\mathsf{store}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x37}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{i{\scriptstyle64}}.\mathsf{store}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x38}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{f{\scriptstyle32}}.\mathsf{store}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x39}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{f{\scriptstyle64}}.\mathsf{store}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x3A}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x3B}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{store}}{16}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x3C}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{store}}{8}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x3D}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{store}}{16}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x3E}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{store}}{32}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x3F}~{\mathit{x}}{:}{\mathtt{memidx}} &\Rightarrow& \mathsf{memory.size}~{\mathit{x}} \\ &&|&
\mathtt{0x40}~{\mathit{x}}{:}{\mathtt{memidx}} &\Rightarrow& \mathsf{memory.grow}~{\mathit{x}} \\ &&|&
\mathtt{0xFC}~8{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{y}}{:}{\mathtt{dataidx}}~{\mathit{x}}{:}{\mathtt{memidx}} &\Rightarrow& \mathsf{memory.init}~{\mathit{x}}~{\mathit{y}} \\ &&|&
\mathtt{0xFC}~9{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{dataidx}} &\Rightarrow& \mathsf{data.drop}~{\mathit{x}} \\ &&|&
\mathtt{0xFC}~10{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}_{{1}}{:}{\mathtt{memidx}}~{\mathit{x}}_{{2}}{:}{\mathtt{memidx}} &\Rightarrow& \mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}} \\ &&|&
\mathtt{0xFC}~11{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{memidx}} &\Rightarrow& \mathsf{memory.fill}~{\mathit{x}} \\ &&|&
\dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{instr}} &::=& \dots \\ &&|&
\mathtt{0x41}~{\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} \\ &&|&
\mathtt{0x42}~{\mathit{n}}{:}{\mathtt{u{\scriptstyle64}}} &\Rightarrow& \mathsf{i{\scriptstyle64}}.\mathsf{const}~{\mathit{n}} \\ &&|&
\mathtt{0x43}~{\mathit{p}}{:}{\mathtt{f{\scriptstyle32}}} &\Rightarrow& \mathsf{f{\scriptstyle32}}.\mathsf{const}~{\mathit{p}} \\ &&|&
\mathtt{0x44}~{\mathit{p}}{:}{\mathtt{f{\scriptstyle64}}} &\Rightarrow& \mathsf{f{\scriptstyle64}}.\mathsf{const}~{\mathit{p}} \\ &&|&
\mathtt{0x45} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{eqz} \\ &&|&
\mathtt{0x46} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{eq} \\ &&|&
\mathtt{0x47} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{ne} \\ &&|&
\mathtt{0x48} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{lt\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x49} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{lt\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x4A} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{gt\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x4B} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{gt\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x4C} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{le\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x4D} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{le\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x4E} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{ge\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x4F} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{ge\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x50} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{eqz} \\ &&|&
\mathtt{0x51} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{eq} \\ &&|&
\mathtt{0x52} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{ne} \\ &&|&
\mathtt{0x53} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{lt\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x54} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{lt\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x55} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{gt\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x56} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{gt\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x57} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{le\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x58} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{le\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x59} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{ge\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x5A} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{ge\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x5B} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{eq} \\ &&|&
\mathtt{0x5C} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{ne} \\ &&|&
\mathtt{0x5D} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{lt} \\ &&|&
\mathtt{0x5E} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{gt} \\ &&|&
\mathtt{0x5F} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{le} \\ &&|&
\mathtt{0x60} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{ge} \\ &&|&
\mathtt{0x61} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{eq} \\ &&|&
\mathtt{0x62} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{ne} \\ &&|&
\mathtt{0x63} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{lt} \\ &&|&
\mathtt{0x64} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{gt} \\ &&|&
\mathtt{0x65} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{le} \\ &&|&
\mathtt{0x66} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{ge} \\ &&|&
\mathtt{0x67} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{clz} \\ &&|&
\mathtt{0x68} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{ctz} \\ &&|&
\mathtt{0x69} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{popcnt} \\ &&|&
\mathtt{0x6A} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{add} \\ &&|&
\mathtt{0x6B} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{sub} \\ &&|&
\mathtt{0x6C} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{mul} \\ &&|&
\mathtt{0x6D} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{div\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x6E} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{div\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x6F} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{rem\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x70} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{rem\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x71} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{and} \\ &&|&
\mathtt{0x72} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{or} \\ &&|&
\mathtt{0x73} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{xor} \\ &&|&
\mathtt{0x74} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{shl} \\ &&|&
\mathtt{0x75} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{shr\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x76} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{shr\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x77} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{rotl} \\ &&|&
\mathtt{0x78} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{rotr} \\ &&|&
\mathtt{0x79} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{clz} \\ &&|&
\mathtt{0x7A} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{ctz} \\ &&|&
\mathtt{0x7B} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{popcnt} \\ &&|&
\mathtt{0x7C} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{add} \\ &&|&
\mathtt{0x7D} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{sub} \\ &&|&
\mathtt{0x7E} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{mul} \\ &&|&
\mathtt{0x7F} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{div\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x80} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{div\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x81} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{rem\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x82} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{rem\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x83} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{and} \\ &&|&
\mathtt{0x84} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{or} \\ &&|&
\mathtt{0x85} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{xor} \\ &&|&
\mathtt{0x86} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{shl} \\ &&|&
\mathtt{0x87} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{shr\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x88} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{shr\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x89} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{rotl} \\ &&|&
\mathtt{0x8A} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{rotr} \\ &&|&
\mathtt{0x8B} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{abs} \\ &&|&
\mathtt{0x8C} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{neg} \\ &&|&
\mathtt{0x8D} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{ceil} \\ &&|&
\mathtt{0x8E} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{floor} \\ &&|&
\mathtt{0x8F} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{trunc} \\ &&|&
\mathtt{0x90} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{nearest} \\ &&|&
\mathtt{0x91} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{sqrt} \\ &&|&
\mathtt{0x92} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{add} \\ &&|&
\mathtt{0x93} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{sub} \\ &&|&
\mathtt{0x94} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{mul} \\ &&|&
\mathtt{0x95} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{div} \\ &&|&
\mathtt{0x96} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{min} \\ &&|&
\mathtt{0x97} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{max} \\ &&|&
\mathtt{0x98} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{copysign} \\ &&|&
\mathtt{0x99} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{abs} \\ &&|&
\mathtt{0x9A} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{neg} \\ &&|&
\mathtt{0x9B} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{ceil} \\ &&|&
\mathtt{0x9C} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{floor} \\ &&|&
\mathtt{0x9D} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{trunc} \\ &&|&
\mathtt{0x9E} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{nearest} \\ &&|&
\mathtt{0x9F} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{sqrt} \\ &&|&
\mathtt{0xA0} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{add} \\ &&|&
\mathtt{0xA1} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{sub} \\ &&|&
\mathtt{0xA2} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{mul} \\ &&|&
\mathtt{0xA3} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{div} \\ &&|&
\mathtt{0xA4} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{min} \\ &&|&
\mathtt{0xA5} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{max} \\ &&|&
\mathtt{0xA6} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{copysign} \\ &&|&
\dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{instr}} &::=& \dots \\ &&|&
\mathtt{0xA7} &\Rightarrow& \mathsf{i{\scriptstyle32}} . {{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle64}}} \\ &&|&
\mathtt{0xA8} &\Rightarrow& \mathsf{i{\scriptstyle32}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xA9} &\Rightarrow& \mathsf{i{\scriptstyle32}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xAA} &\Rightarrow& \mathsf{i{\scriptstyle32}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xAB} &\Rightarrow& \mathsf{i{\scriptstyle32}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xAC} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xAD} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xAE} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xAF} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xB0} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xB1} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xB2} &\Rightarrow& \mathsf{f{\scriptstyle32}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xB3} &\Rightarrow& \mathsf{f{\scriptstyle32}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xB4} &\Rightarrow& \mathsf{f{\scriptstyle32}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xB5} &\Rightarrow& \mathsf{f{\scriptstyle32}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xB6} &\Rightarrow& \mathsf{f{\scriptstyle32}} . {{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle64}}} \\ &&|&
\mathtt{0xB7} &\Rightarrow& \mathsf{f{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xB8} &\Rightarrow& \mathsf{f{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xB9} &\Rightarrow& \mathsf{f{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xBA} &\Rightarrow& \mathsf{f{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xBB} &\Rightarrow& \mathsf{f{\scriptstyle64}} . {{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle32}}} \\ &&|&
\mathtt{0xBC} &\Rightarrow& \mathsf{i{\scriptstyle32}} . {{\mathsf{reinterpret}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle32}}} \\ &&|&
\mathtt{0xBD} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{\mathsf{reinterpret}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle64}}} \\ &&|&
\mathtt{0xBE} &\Rightarrow& \mathsf{f{\scriptstyle32}} . {{\mathsf{reinterpret}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle32}}} \\ &&|&
\mathtt{0xBF} &\Rightarrow& \mathsf{f{\scriptstyle64}} . {{\mathsf{reinterpret}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle64}}} \\ &&|&
\mathtt{0xC0} &\Rightarrow& \mathsf{i{\scriptstyle32}} . (\mathsf{extend}~8) \\ &&|&
\mathtt{0xC1} &\Rightarrow& \mathsf{i{\scriptstyle32}} . (\mathsf{extend}~16) \\ &&|&
\mathtt{0xC2} &\Rightarrow& \mathsf{i{\scriptstyle64}} . (\mathsf{extend}~8) \\ &&|&
\mathtt{0xC3} &\Rightarrow& \mathsf{i{\scriptstyle64}} . (\mathsf{extend}~16) \\ &&|&
\mathtt{0xC4} &\Rightarrow& \mathsf{i{\scriptstyle64}} . (\mathsf{extend}~32) \\ &&|&
\dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{laneidx}} &::=& {\mathit{l}}{:}{\mathtt{byte}} &\Rightarrow& {\mathit{l}} \\
& {\mathtt{instr}} &::=& \dots \\ &&|&
\mathtt{0xFD}~0{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{v{\scriptstyle128}.load}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0xFD}~1{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{v{\scriptstyle128}.load}}{{{{{\mathsf{shape}}{8}}{\mathsf{x}}}{8}}{\mathsf{s}}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0xFD}~2{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{v{\scriptstyle128}.load}}{{{{{\mathsf{shape}}{8}}{\mathsf{x}}}{8}}{\mathsf{u}}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0xFD}~3{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{v{\scriptstyle128}.load}}{{{{{\mathsf{shape}}{16}}{\mathsf{x}}}{4}}{\mathsf{s}}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0xFD}~4{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{v{\scriptstyle128}.load}}{{{{{\mathsf{shape}}{16}}{\mathsf{x}}}{4}}{\mathsf{u}}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0xFD}~5{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{v{\scriptstyle128}.load}}{{{{{\mathsf{shape}}{32}}{\mathsf{x}}}{2}}{\mathsf{s}}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0xFD}~6{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{v{\scriptstyle128}.load}}{{{{{\mathsf{shape}}{32}}{\mathsf{x}}}{2}}{\mathsf{u}}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0xFD}~7{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{v{\scriptstyle128}.load}}{{\mathsf{splat}}{8}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0xFD}~8{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{v{\scriptstyle128}.load}}{{\mathsf{splat}}{16}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0xFD}~9{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{v{\scriptstyle128}.load}}{{\mathsf{splat}}{32}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0xFD}~10{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{v{\scriptstyle128}.load}}{{\mathsf{splat}}{64}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0xFD}~92{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{v{\scriptstyle128}.load}}{{\mathsf{zero}}{32}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0xFD}~92{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{v{\scriptstyle128}.load}}{{\mathsf{zero}}{64}}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0xFD}~11{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{v{\scriptstyle128}.store}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0xFD}~84{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& {{{\mathsf{v{\scriptstyle128}.load}}{8}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~{\mathit{mo}}~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~85{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& {{{\mathsf{v{\scriptstyle128}.load}}{16}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~{\mathit{mo}}~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~86{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& {{{\mathsf{v{\scriptstyle128}.load}}{32}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~{\mathit{mo}}~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~87{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& {{{\mathsf{v{\scriptstyle128}.load}}{64}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~{\mathit{mo}}~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~88{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& {{{\mathsf{v{\scriptstyle128}.store}}{8}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~{\mathit{mo}}~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~89{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& {{{\mathsf{v{\scriptstyle128}.store}}{16}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~{\mathit{mo}}~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~90{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& {{{\mathsf{v{\scriptstyle128}.store}}{32}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~{\mathit{mo}}~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~91{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& {{{\mathsf{v{\scriptstyle128}.store}}{64}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~{\mathit{mo}}~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~12{:}{\mathtt{u{\scriptstyle32}}}~{({\mathit{b}}{:}{\mathtt{byte}})^{16}} &\Rightarrow& \mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{b}'}
  &\qquad \mbox{if}~{{\mathrm{bytes}}}_{{\mathsf{i}}{128}}({\mathit{b}'}) = {\mathit{b}} \\ &&|&
\mathtt{0xFD}~13{:}{\mathtt{u{\scriptstyle32}}}~{({\mathit{l}}{:}{\mathtt{laneidx}})^{16}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}).\mathsf{shuffle}~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~21{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& {({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}).\mathsf{extract\_lane\_}}{\mathsf{s}}~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~22{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& {({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}).\mathsf{extract\_lane\_}}{\mathsf{u}}~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~23{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}).\mathsf{replace\_lane}~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~24{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& {({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}).\mathsf{extract\_lane\_}}{\mathsf{s}}~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~25{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& {({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}).\mathsf{extract\_lane\_}}{\mathsf{u}}~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~26{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}).\mathsf{replace\_lane}~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~27{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& \mathsf{vextract\_lane}~({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4})~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~28{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}).\mathsf{replace\_lane}~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~29{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& \mathsf{vextract\_lane}~({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2})~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~30{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}).\mathsf{replace\_lane}~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~31{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& \mathsf{vextract\_lane}~({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4})~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~32{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}).\mathsf{replace\_lane}~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~33{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& \mathsf{vextract\_lane}~({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2})~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~34{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{l}}{:}{\mathtt{laneidx}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}).\mathsf{replace\_lane}~{\mathit{l}} \\ &&|&
\mathtt{0xFD}~14{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}).\mathsf{swizzle} \\ &&|&
\mathtt{0xFD}~15{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}).\mathsf{splat} \\ &&|&
\mathtt{0xFD}~16{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}).\mathsf{splat} \\ &&|&
\mathtt{0xFD}~17{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}).\mathsf{splat} \\ &&|&
\mathtt{0xFD}~18{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}).\mathsf{splat} \\ &&|&
\mathtt{0xFD}~19{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}).\mathsf{splat} \\ &&|&
\mathtt{0xFD}~20{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}).\mathsf{splat} \\ &&|&
\mathtt{0xFD}~35{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . \mathsf{eq} \\ &&|&
\mathtt{0xFD}~36{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . \mathsf{ne} \\ &&|&
\mathtt{0xFD}~37{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . ({\mathsf{lt\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~38{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . ({\mathsf{lt\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~39{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . ({\mathsf{gt\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~40{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . ({\mathsf{gt\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~41{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . ({\mathsf{le\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~42{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . ({\mathsf{le\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~43{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . ({\mathsf{ge\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~44{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . ({\mathsf{ge\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~45{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . \mathsf{eq} \\ &&|&
\mathtt{0xFD}~46{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . \mathsf{ne} \\ &&|&
\mathtt{0xFD}~47{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . ({\mathsf{lt\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~48{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . ({\mathsf{lt\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~49{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . ({\mathsf{gt\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~50{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . ({\mathsf{gt\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~51{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . ({\mathsf{le\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~52{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . ({\mathsf{le\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~53{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . ({\mathsf{ge\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~54{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . ({\mathsf{ge\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~55{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{eq} \\ &&|&
\mathtt{0xFD}~56{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{ne} \\ &&|&
\mathtt{0xFD}~57{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . ({\mathsf{lt\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~58{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . ({\mathsf{lt\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~59{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . ({\mathsf{gt\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~60{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . ({\mathsf{gt\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~61{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . ({\mathsf{le\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~62{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . ({\mathsf{le\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~63{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . ({\mathsf{ge\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~64{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . ({\mathsf{ge\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~214{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{eq} \\ &&|&
\mathtt{0xFD}~215{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{ne} \\ &&|&
\mathtt{0xFD}~216{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . ({\mathsf{lt\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~217{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . ({\mathsf{gt\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~218{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . ({\mathsf{le\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~219{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . ({\mathsf{ge\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~65{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{eq} \\ &&|&
\mathtt{0xFD}~66{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{ne} \\ &&|&
\mathtt{0xFD}~67{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{lt} \\ &&|&
\mathtt{0xFD}~68{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{gt} \\ &&|&
\mathtt{0xFD}~69{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{le} \\ &&|&
\mathtt{0xFD}~70{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{ge} \\ &&|&
\mathtt{0xFD}~71{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{eq} \\ &&|&
\mathtt{0xFD}~72{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{ne} \\ &&|&
\mathtt{0xFD}~73{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{lt} \\ &&|&
\mathtt{0xFD}~74{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{gt} \\ &&|&
\mathtt{0xFD}~75{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{le} \\ &&|&
\mathtt{0xFD}~76{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{ge} \\ &&|&
\mathtt{0xFD}~77{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{v{\scriptstyle128}} . \mathsf{not} \\ &&|&
\mathtt{0xFD}~78{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{v{\scriptstyle128}} . \mathsf{and} \\ &&|&
\mathtt{0xFD}~79{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{v{\scriptstyle128}} . \mathsf{andnot} \\ &&|&
\mathtt{0xFD}~80{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{v{\scriptstyle128}} . \mathsf{or} \\ &&|&
\mathtt{0xFD}~81{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{v{\scriptstyle128}} . \mathsf{xor} \\ &&|&
\mathtt{0xFD}~82{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{v{\scriptstyle128}} . \mathsf{bitselect} \\ &&|&
\mathtt{0xFD}~83{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{v{\scriptstyle128}} . \mathsf{any\_true} \\ &&|&
\mathtt{0xFD}~96{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . \mathsf{abs} \\ &&|&
\mathtt{0xFD}~97{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . \mathsf{neg} \\ &&|&
\mathtt{0xFD}~98{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . \mathsf{popcnt} \\ &&|&
\mathtt{0xFD}~99{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . \mathsf{all\_true} \\ &&|&
\mathtt{0xFD}~100{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}).\mathsf{bitmask} \\ &&|&
\mathtt{0xFD}~101{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {{{{({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}).\mathsf{narrow}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~102{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {{{{({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}).\mathsf{narrow}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~107{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . \mathsf{shl} \\ &&|&
\mathtt{0xFD}~108{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . ({\mathsf{shr\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~109{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . ({\mathsf{shr\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~110{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . \mathsf{add} \\ &&|&
\mathtt{0xFD}~111{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . ({{\mathsf{add\_sat}}{\mathsf{\_}}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~112{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . ({{\mathsf{add\_sat}}{\mathsf{\_}}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~113{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . \mathsf{sub} \\ &&|&
\mathtt{0xFD}~114{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . ({{\mathsf{sub\_sat}}{\mathsf{\_}}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~115{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . ({{\mathsf{sub\_sat}}{\mathsf{\_}}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~118{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . ({{\mathsf{min}}{\mathsf{\_}}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~119{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . ({{\mathsf{min}}{\mathsf{\_}}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~120{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . ({{\mathsf{max}}{\mathsf{\_}}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~121{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . ({{\mathsf{max}}{\mathsf{\_}}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~123{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}) . \mathsf{avgr\_u} \\ &&|&
\mathtt{0xFD}~124{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . {{{{\mathsf{extadd\_pairwise}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~125{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . {{{{\mathsf{extadd\_pairwise}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~128{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . \mathsf{abs} \\ &&|&
\mathtt{0xFD}~129{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . \mathsf{neg} \\ &&|&
\mathtt{0xFD}~130{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . \mathsf{q{\scriptstyle15}mulr\_sat\_s} \\ &&|&
\mathtt{0xFD}~131{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . \mathsf{all\_true} \\ &&|&
\mathtt{0xFD}~132{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}).\mathsf{bitmask} \\ &&|&
\mathtt{0xFD}~133{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {{{{({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}).\mathsf{narrow}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~134{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {{{{({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}).\mathsf{narrow}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~135{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . {{{{{{\mathsf{extend}}{\mathsf{\_}}}{\mathsf{low}}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~136{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . {{{{{{\mathsf{extend}}{\mathsf{\_}}}{\mathsf{high}}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~137{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . {{{{{{\mathsf{extend}}{\mathsf{\_}}}{\mathsf{low}}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~138{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . {{{{{{\mathsf{extend}}{\mathsf{\_}}}{\mathsf{high}}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~139{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . \mathsf{shl} \\ &&|&
\mathtt{0xFD}~140{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . ({\mathsf{shr\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~141{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . ({\mathsf{shr\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~142{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . \mathsf{add} \\ &&|&
\mathtt{0xFD}~143{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . ({{\mathsf{add\_sat}}{\mathsf{\_}}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~144{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . ({{\mathsf{add\_sat}}{\mathsf{\_}}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~145{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . \mathsf{sub} \\ &&|&
\mathtt{0xFD}~146{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . ({{\mathsf{sub\_sat}}{\mathsf{\_}}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~147{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . ({{\mathsf{sub\_sat}}{\mathsf{\_}}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~149{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . \mathsf{mul} \\ &&|&
\mathtt{0xFD}~150{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . ({{\mathsf{min}}{\mathsf{\_}}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~151{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . ({{\mathsf{min}}{\mathsf{\_}}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~152{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . ({{\mathsf{max}}{\mathsf{\_}}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~153{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . ({{\mathsf{max}}{\mathsf{\_}}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~155{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . \mathsf{avgr\_u} \\ &&|&
\mathtt{0xFD}~156{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . {{{{({{\mathsf{extmul}}{\mathsf{\_}}}{\mathsf{low}})}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~157{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . {{{{({{\mathsf{extmul}}{\mathsf{\_}}}{\mathsf{high}})}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~158{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . {{{{({{\mathsf{extmul}}{\mathsf{\_}}}{\mathsf{low}})}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~159{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}) . {{{{({{\mathsf{extmul}}{\mathsf{\_}}}{\mathsf{high}})}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle8}}}{\mathsf{x}}}{16}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~126{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . {{{{\mathsf{extadd\_pairwise}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~127{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . {{{{\mathsf{extadd\_pairwise}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~160{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{abs} \\ &&|&
\mathtt{0xFD}~161{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{neg} \\ &&|&
\mathtt{0xFD}~163{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{all\_true} \\ &&|&
\mathtt{0xFD}~164{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}).\mathsf{bitmask} \\ &&|&
\mathtt{0xFD}~167{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . {{{{{{\mathsf{extend}}{\mathsf{\_}}}{\mathsf{low}}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~168{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . {{{{{{\mathsf{extend}}{\mathsf{\_}}}{\mathsf{high}}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~169{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . {{{{{{\mathsf{extend}}{\mathsf{\_}}}{\mathsf{low}}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~170{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . {{{{{{\mathsf{extend}}{\mathsf{\_}}}{\mathsf{high}}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~171{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{shl} \\ &&|&
\mathtt{0xFD}~172{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . ({\mathsf{shr\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~173{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . ({\mathsf{shr\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~174{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{add} \\ &&|&
\mathtt{0xFD}~177{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{sub} \\ &&|&
\mathtt{0xFD}~181{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{mul} \\ &&|&
\mathtt{0xFD}~182{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . ({{\mathsf{min}}{\mathsf{\_}}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~183{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . ({{\mathsf{min}}{\mathsf{\_}}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~184{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . ({{\mathsf{max}}{\mathsf{\_}}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~185{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . ({{\mathsf{max}}{\mathsf{\_}}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~186{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . {{{{\mathsf{dot}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~188{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . {{{{({{\mathsf{extmul}}{\mathsf{\_}}}{\mathsf{low}})}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~189{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . {{{{({{\mathsf{extmul}}{\mathsf{\_}}}{\mathsf{high}})}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~190{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . {{{{({{\mathsf{extmul}}{\mathsf{\_}}}{\mathsf{low}})}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~191{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . {{{{({{\mathsf{extmul}}{\mathsf{\_}}}{\mathsf{high}})}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle16}}}{\mathsf{x}}}{8}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~192{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{abs} \\ &&|&
\mathtt{0xFD}~193{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{neg} \\ &&|&
\mathtt{0xFD}~195{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{all\_true} \\ &&|&
\mathtt{0xFD}~196{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}).\mathsf{bitmask} \\ &&|&
\mathtt{0xFD}~199{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . {{{{{{\mathsf{extend}}{\mathsf{\_}}}{\mathsf{low}}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~200{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . {{{{{{\mathsf{extend}}{\mathsf{\_}}}{\mathsf{high}}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~201{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . {{{{{{\mathsf{extend}}{\mathsf{\_}}}{\mathsf{low}}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~202{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . {{{{{{\mathsf{extend}}{\mathsf{\_}}}{\mathsf{high}}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~203{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{shl} \\ &&|&
\mathtt{0xFD}~204{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . ({\mathsf{shr\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0xFD}~205{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . ({\mathsf{shr\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0xFD}~206{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{add} \\ &&|&
\mathtt{0xFD}~209{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{sub} \\ &&|&
\mathtt{0xFD}~213{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{mul} \\ &&|&
\mathtt{0xFD}~220{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . {{{{({{\mathsf{extmul}}{\mathsf{\_}}}{\mathsf{low}})}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~221{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . {{{{({{\mathsf{extmul}}{\mathsf{\_}}}{\mathsf{high}})}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~222{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . {{{{({{\mathsf{extmul}}{\mathsf{\_}}}{\mathsf{low}})}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~223{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle64}}}{\mathsf{x}}}{2}) . {{{{({{\mathsf{extmul}}{\mathsf{\_}}}{\mathsf{high}})}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~103{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{ceil} \\ &&|&
\mathtt{0xFD}~104{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{floor} \\ &&|&
\mathtt{0xFD}~105{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{trunc} \\ &&|&
\mathtt{0xFD}~106{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{nearest} \\ &&|&
\mathtt{0xFD}~224{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{abs} \\ &&|&
\mathtt{0xFD}~225{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{neg} \\ &&|&
\mathtt{0xFD}~227{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{sqrt} \\ &&|&
\mathtt{0xFD}~228{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{add} \\ &&|&
\mathtt{0xFD}~229{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{sub} \\ &&|&
\mathtt{0xFD}~230{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{mul} \\ &&|&
\mathtt{0xFD}~231{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{div} \\ &&|&
\mathtt{0xFD}~232{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{min} \\ &&|&
\mathtt{0xFD}~233{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{max} \\ &&|&
\mathtt{0xFD}~234{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{pmin} \\ &&|&
\mathtt{0xFD}~235{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) . \mathsf{pmax} \\ &&|&
\mathtt{0xFD}~116{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{ceil} \\ &&|&
\mathtt{0xFD}~117{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{floor} \\ &&|&
\mathtt{0xFD}~122{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{trunc} \\ &&|&
\mathtt{0xFD}~148{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{nearest} \\ &&|&
\mathtt{0xFD}~236{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{abs} \\ &&|&
\mathtt{0xFD}~237{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{neg} \\ &&|&
\mathtt{0xFD}~239{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{sqrt} \\ &&|&
\mathtt{0xFD}~240{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{add} \\ &&|&
\mathtt{0xFD}~241{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{sub} \\ &&|&
\mathtt{0xFD}~242{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{mul} \\ &&|&
\mathtt{0xFD}~243{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{div} \\ &&|&
\mathtt{0xFD}~244{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{min} \\ &&|&
\mathtt{0xFD}~245{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{max} \\ &&|&
\mathtt{0xFD}~246{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{pmin} \\ &&|&
\mathtt{0xFD}~247{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . \mathsf{pmax} \\ &&|&
\mathtt{0xFD}~248{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{vcvtop}~({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4})~\mathsf{trunc\_sat}~({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4})~\mathsf{s} \\ &&|&
\mathtt{0xFD}~249{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{vcvtop}~({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4})~\mathsf{trunc\_sat}~({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4})~\mathsf{u} \\ &&|&
\mathtt{0xFD}~250{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{vcvtop}~({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4})~\mathsf{convert}~({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4})~\mathsf{s} \\ &&|&
\mathtt{0xFD}~251{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{vcvtop}~({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4})~\mathsf{convert}~({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4})~\mathsf{u} \\ &&|&
\mathtt{0xFD}~252{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . {{{{{{\mathsf{trunc\_sat}}{\mathsf{\_}}}{{{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}}}{\mathsf{\_}}}{\mathsf{s}}}{\mathsf{\_}}}{\mathsf{zero}} \\ &&|&
\mathtt{0xFD}~253{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}) . {{{{{{\mathsf{trunc\_sat}}{\mathsf{\_}}}{{{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}}}{\mathsf{\_}}}{\mathsf{u}}}{\mathsf{\_}}}{\mathsf{zero}} \\ &&|&
\mathtt{0xFD}~254{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . {{{{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{low}}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~255{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2}) . {{{{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{low}}}{\mathsf{\_}}}{{{\mathsf{i{\scriptstyle32}}}{\mathsf{x}}}{4}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~94{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{vcvtop}~({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4})~\mathsf{demote}~({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2})~\mathsf{zero} \\ &&|&
\mathtt{0xFD}~95{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{vcvtop}~({{\mathsf{f{\scriptstyle64}}}{\mathsf{x}}}{2})~\mathsf{promote}~\mathsf{low}~({{\mathsf{f{\scriptstyle32}}}{\mathsf{x}}}{4}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{expr}} &::=& {({\mathit{in}}{:}{\mathtt{instr}})^\ast}~\mathtt{0x0B} &\Rightarrow& {{\mathit{in}}^\ast} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {{\mathtt{section}}}_{{\mathit{N}}}({\mathtt{X}}) &::=& {\mathit{N}}{:}{\mathtt{byte}}~{\mathit{sz}}{:}{\mathtt{u{\scriptstyle32}}}~{{\mathit{en}}^\ast}{:}{\mathtt{X}} &\Rightarrow& {{\mathit{en}}^\ast}
  &\qquad \mbox{if}~{\mathit{sz}} = ||{\mathtt{X}}|| \\ &&|&
\epsilon &\Rightarrow& \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{custom}} &::=& {\mathtt{name}}~{{\mathtt{byte}}^\ast} &\Rightarrow& () \\
& {\mathtt{customsec}} &::=& {{\mathtt{section}}}_{0}({\mathtt{custom}}) &\Rightarrow& () \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{type}} &::=& {\mathit{qt}}{:}{\mathtt{rectype}} &\Rightarrow& \mathsf{type}~{\mathit{qt}} \\
& {\mathtt{typesec}} &::=& {{\mathit{ty}}^\ast}{:}{{\mathtt{section}}}_{1}({\mathtt{vec}}({\mathtt{type}})) &\Rightarrow& {{\mathit{ty}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{import}} &::=& {\mathit{nm}}_{{1}}{:}{\mathtt{name}}~{\mathit{nm}}_{{2}}{:}{\mathtt{name}}~{\mathit{xt}}{:}{\mathtt{externtype}} &\Rightarrow& \mathsf{import}~{\mathit{nm}}_{{1}}~{\mathit{nm}}_{{2}}~{\mathit{xt}} \\
& {\mathtt{importsec}} &::=& {{\mathit{im}}^\ast}{:}{{\mathtt{section}}}_{2}({\mathtt{vec}}({\mathtt{import}})) &\Rightarrow& {{\mathit{im}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{funcsec}} &::=& {{\mathit{x}}^\ast}{:}{{\mathtt{section}}}_{3}({\mathtt{vec}}({\mathtt{typeidx}})) &\Rightarrow& {{\mathit{x}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{table}} &::=& {\mathit{tt}}{:}{\mathtt{tabletype}}~{\mathit{e}}{:}{\mathtt{expr}} &\Rightarrow& \mathsf{table}~{\mathit{tt}}~{\mathit{e}} \\
& {\mathtt{tablesec}} &::=& {{\mathit{tab}}^\ast}{:}{{\mathtt{section}}}_{4}({\mathtt{vec}}({\mathtt{table}})) &\Rightarrow& {{\mathit{tab}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{mem}} &::=& {\mathit{mt}}{:}{\mathtt{memtype}} &\Rightarrow& \mathsf{memory}~{\mathit{mt}} \\
& {\mathtt{memsec}} &::=& {{\mathit{mem}}^\ast}{:}{{\mathtt{section}}}_{5}({\mathtt{vec}}({\mathtt{mem}})) &\Rightarrow& {{\mathit{mem}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{global}} &::=& {\mathit{gt}}{:}{\mathtt{globaltype}}~{\mathit{e}}{:}{\mathtt{expr}} &\Rightarrow& \mathsf{global}~{\mathit{gt}}~{\mathit{e}} \\
& {\mathtt{globalsec}} &::=& {{\mathit{glob}}^\ast}{:}{{\mathtt{section}}}_{6}({\mathtt{vec}}({\mathtt{global}})) &\Rightarrow& {{\mathit{glob}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{export}} &::=& {\mathit{nm}}{:}{\mathtt{name}}~{\mathit{ux}}{:}{\mathtt{externidx}} &\Rightarrow& \mathsf{export}~{\mathit{nm}}~{\mathit{ux}} \\
& {\mathtt{exportsec}} &::=& {{\mathit{ex}}^\ast}{:}{{\mathtt{section}}}_{7}({\mathtt{vec}}({\mathtt{export}})) &\Rightarrow& {{\mathit{ex}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{start}} &::=& {\mathit{x}}{:}{\mathtt{funcidx}} &\Rightarrow& (\mathsf{start}~{\mathit{x}}) \\
& {\mathtt{startsec}} &::=& {{\mathit{start}}^\ast}{:}{{\mathtt{section}}}_{8}({\mathtt{start}}) &\Rightarrow& {{\mathit{start}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{elemkind}} &::=& \mathtt{0x00} &\Rightarrow& \mathsf{ref}~\mathsf{null}~\mathsf{func} \\
& {\mathtt{elem}} &::=& 0{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{e}}_{{\mathit{o}}}{:}{\mathtt{expr}}~{{\mathit{y}}^\ast}{:}{\mathtt{vec}}({\mathtt{funcidx}}) &\Rightarrow& \mathsf{elem}~(\mathsf{ref}~\mathsf{null}~\mathsf{func})~{(\mathsf{ref.func}~{\mathit{y}})^\ast}~(\mathsf{active}~0~{\mathit{e}}_{{\mathit{o}}}) \\ &&|&
1{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{rt}}{:}{\mathtt{elemkind}}~{{\mathit{y}}^\ast}{:}{\mathtt{vec}}({\mathtt{funcidx}}) &\Rightarrow& \mathsf{elem}~{\mathit{rt}}~{(\mathsf{ref.func}~{\mathit{y}})^\ast}~\mathsf{passive} \\ &&|&
2{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{tableidx}}~{\mathit{expr}}{:}{\mathtt{expr}}~{\mathit{rt}}{:}{\mathtt{elemkind}}~{{\mathit{y}}^\ast}{:}{\mathtt{vec}}({\mathtt{funcidx}}) &\Rightarrow& \mathsf{elem}~{\mathit{rt}}~{(\mathsf{ref.func}~{\mathit{y}})^\ast}~(\mathsf{active}~{\mathit{x}}~{\mathit{expr}}) \\ &&|&
3{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{rt}}{:}{\mathtt{elemkind}}~{{\mathit{y}}^\ast}{:}{\mathtt{vec}}({\mathtt{funcidx}}) &\Rightarrow& \mathsf{elem}~{\mathit{rt}}~{(\mathsf{ref.func}~{\mathit{y}})^\ast}~\mathsf{declare} \\ &&|&
4{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{e}}_{{\mathit{o}}}{:}{\mathtt{expr}}~{{\mathit{e}}^\ast}{:}{\mathtt{vec}}({\mathtt{expr}}) &\Rightarrow& \mathsf{elem}~(\mathsf{ref}~\mathsf{null}~\mathsf{func})~{{\mathit{e}}^\ast}~(\mathsf{active}~0~{\mathit{e}}_{{\mathit{o}}}) \\ &&|&
5{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{rt}}{:}{\mathtt{reftype}}~{{\mathit{e}}^\ast}{:}{\mathtt{vec}}({\mathtt{expr}}) &\Rightarrow& \mathsf{elem}~{\mathit{rt}}~{{\mathit{e}}^\ast}~\mathsf{passive} \\ &&|&
6{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{tableidx}}~{\mathit{expr}}{:}{\mathtt{expr}}~{{\mathit{e}}^\ast}{:}{\mathtt{vec}}({\mathtt{expr}}) &\Rightarrow& \mathsf{elem}~(\mathsf{ref}~\mathsf{null}~\mathsf{func})~{{\mathit{e}}^\ast}~(\mathsf{active}~{\mathit{x}}~{\mathit{expr}}) \\ &&|&
7{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{rt}}{:}{\mathtt{reftype}}~{{\mathit{e}}^\ast}{:}{\mathtt{vec}}({\mathtt{expr}}) &\Rightarrow& \mathsf{elem}~{\mathit{rt}}~{{\mathit{e}}^\ast}~\mathsf{declare} \\
& {\mathtt{elemsec}} &::=& {{\mathit{elem}}^\ast}{:}{{\mathtt{section}}}_{9}({\mathtt{vec}}({\mathtt{elem}})) &\Rightarrow& {{\mathit{elem}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{code}} &::=& ({{\mathit{local}}^\ast},\, {\mathit{expr}}) \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{locals}} &::=& {\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{t}}{:}{\mathtt{valtype}} &\Rightarrow& {(\mathsf{local}~{\mathit{t}})^{{\mathit{n}}}} \\
& {\mathtt{func}} &::=& {{{\mathit{local}}^\ast}^\ast}{:}{\mathtt{vec}}({\mathtt{locals}})~{\mathit{expr}}{:}{\mathtt{expr}} &\Rightarrow& ({\mathrm{concat}}({{{\mathit{local}}^\ast}^\ast}),\, {\mathit{expr}}) \\
& {\mathtt{code}} &::=& {\mathit{sz}}{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{code}}{:}{\mathtt{func}} &\Rightarrow& {\mathit{code}}
  &\qquad \mbox{if}~{\mathit{sz}} = ||{\mathtt{func}}|| \\
& {\mathtt{codesec}} &::=& {{\mathit{code}}^\ast}{:}{{\mathtt{section}}}_{10}({\mathtt{vec}}({\mathtt{code}})) &\Rightarrow& {{\mathit{code}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{data}} &::=& 0{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{e}}{:}{\mathtt{expr}}~{{\mathit{b}}^\ast}{:}{\mathtt{vec}}({\mathtt{byte}}) &\Rightarrow& \mathsf{data}~{{\mathit{b}}^\ast}~(\mathsf{active}~0~{\mathit{e}}) \\ &&|&
1{:}{\mathtt{u{\scriptstyle32}}}~{{\mathit{b}}^\ast}{:}{\mathtt{vec}}({\mathtt{byte}}) &\Rightarrow& \mathsf{data}~{{\mathit{b}}^\ast}~\mathsf{passive} \\ &&|&
2{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{memidx}}~{\mathit{e}}{:}{\mathtt{expr}}~{{\mathit{b}}^\ast}{:}{\mathtt{vec}}({\mathtt{byte}}) &\Rightarrow& \mathsf{data}~{{\mathit{b}}^\ast}~(\mathsf{active}~{\mathit{x}}~{\mathit{e}}) \\
& {\mathtt{datasec}} &::=& {{\mathit{data}}^\ast}{:}{{\mathtt{section}}}_{11}({\mathtt{vec}}({\mathtt{data}})) &\Rightarrow& {{\mathit{data}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{datacnt}} &::=& {\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{n}} \\
& {\mathtt{datacntsec}} &::=& {{\mathit{n}}^\ast}{:}{{\mathtt{section}}}_{12}({\mathtt{datacnt}}) &\Rightarrow& {{\mathit{n}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{module}} &::=& \mathtt{0x00}~\mathtt{0x61}~\mathtt{0x73}~\mathtt{0x6D}~1{:}{\mathtt{u{\scriptstyle32}}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{type}}^\ast}{:}{\mathtt{typesec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{import}}^\ast}{:}{\mathtt{importsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{typeidx}}^{{\mathit{n}}}}{:}{\mathtt{funcsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{table}}^\ast}{:}{\mathtt{tablesec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{mem}}^\ast}{:}{\mathtt{memsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{global}}^\ast}{:}{\mathtt{globalsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{export}}^\ast}{:}{\mathtt{exportsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{start}}^\ast}{:}{\mathtt{startsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{elem}}^\ast}{:}{\mathtt{elemsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{m}'}^\ast}{:}{\mathtt{datacntsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{({{\mathit{local}}^\ast},\, {\mathit{expr}})^{{\mathit{n}}}}{:}{\mathtt{codesec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{data}}^{{\mathit{m}}}}{:}{\mathtt{datasec}}~{{\mathtt{customsec}}^\ast} &\Rightarrow& \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^{{\mathit{n}}}}~{{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^{{\mathit{m}}}}~{{\mathit{start}}^\ast}~{{\mathit{export}}^\ast}
  &\qquad \mbox{if}~{{\mathit{m}'}^\ast} = \epsilon \lor {\mathrm{free}}_{{\mathit{dataidx}}}({{\mathit{func}}^{{\mathit{n}}}}) = \epsilon \\
  &&&&&&\qquad {\land}~{\mathit{m}} = {\mathrm{sum}}({{\mathit{m}'}^\ast}) \\
  &&&&&&\qquad {\land}~(({\mathit{func}} = \mathsf{func}~{\mathit{typeidx}}~{{\mathit{local}}^\ast}~{\mathit{expr}}))^{{\mathit{n}}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{A}} &::=& {\mathit{nat}} \\
& {\mathit{B}} &::=& {\mathit{nat}} \\
& {\mathit{sym}} &::=& {\mathit{A}}_{{1}} ~|~ \dots ~|~ {\mathit{A}}_{{\mathit{n}}} \\
& {\mathit{sym}} &::=& {\mathit{A}}_{{1}} ~|~ {\mathit{A}}_{{2}} \\
& \dots &::=& \dots \\
& {\mathit{r}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
{\mathsf{field}}_{1}~{\mathit{A}}_{{1}},\; {\mathsf{field}}_{2}~{\mathit{A}}_{{2}},\; ~\dots \}\end{array} \\
& {\mathit{r}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
{\mathsf{field}}_{1}~{{\mathit{A}}_{{1}}^\ast},\; {\mathsf{field}}_{2}~{{\mathit{A}}_{{2}}^\ast},\; ~\dots \}\end{array} \\
& {\mathit{recordeq}} &::=& {\mathit{r}}~\oplus~{\mathit{r}}~=~{\mathit{r}} \\
& {\mathit{pth}} &::=& {({}[{\mathit{i}}]~\mid~.\mathsf{field})^{+}} \\
& {\mathit{pthaux}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
{\mathit{pth}}~(),\; \\
  {}[{\mathit{i}}]~{\mathit{pth}}~(),\; \\
  \mathsf{field}~{\mathit{pth}}~(),\; \\
  .\mathsf{field}~() \}\end{array} \\
\end{array}
$$


```

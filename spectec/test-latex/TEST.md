# Test

```sh
$ (dune exec ../src/exe-watsup/main.exe -- test.watsup -o test.tex && cat test.tex)
$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{test}}_{{\mathit{sub}}_{{\mathsf{atom}}_{{22}}}}({\mathit{n}}_{{3}_{{\mathsf{atom}}_{{\mathit{y}}}}}) &=& 0 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{curried}}}_{{\mathit{n}}_{{1}}}({\mathit{n}}_{{2}}) &=& {\mathit{n}}_{{1}} + {\mathit{n}}_{{2}} &  \\
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
$ (dune exec ../src/exe-watsup/main.exe -- ../spec/wasm-3.0/*.watsup)
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
{\mathrm{Ki}} &=& 1024 &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{min}}(0, {\mathit{j}}) &=& 0 &  \\
{\mathrm{min}}({\mathit{i}}, 0) &=& 0 &  \\
{\mathrm{min}}({\mathit{i}} + 1, {\mathit{j}} + 1) &=& {\mathrm{min}}({\mathit{i}}, {\mathit{j}}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{sum}}(\epsilon) &=& 0 &  \\
{\mathrm{sum}}({\mathit{n}}~{{\mathit{n}'}^\ast}) &=& {\mathit{n}} + {\mathrm{sum}}({{\mathit{n}'}^\ast}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(character)} & {\mathit{char}} &::=& \mathrm{U{+}00} ~|~ \dots ~|~ \mathrm{U{+}D7FF} ~|~ \mathrm{U{+}E000} ~|~ \dots ~|~ \mathrm{U{+}10FFFF} \\
\mbox{(name)} & {\mathit{name}} &::=& {{\mathit{char}}^\ast} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(byte)} & {\mathit{byte}} &::=& \mathtt{0x00} ~|~ \dots ~|~ \mathtt{0xFF} \\
\mbox{(unsigned integer)} & {\mathit{uN}}({\mathit{N}}) &::=& 0 ~|~ \dots ~|~ {2^{{\mathit{N}}}} - 1 \\
\mbox{(signed integer)} & {\mathit{sN}}({\mathit{N}}) &::=& {-{2^{{\mathit{N}} - 1}}} ~|~ \dots ~|~ {-1} ~|~ 0 ~|~ {+1} ~|~ \dots ~|~ {2^{{\mathit{N}} - 1}} - 1 \\
\mbox{(integer)} & {\mathit{iN}}({\mathit{N}}) &::=& {\mathit{uN}}({\mathit{N}}) \\
& {\mathit{u{\scriptstyle8}}} &::=& {\mathit{uN}}(8) \\
& {\mathit{u{\scriptstyle31}}} &::=& {\mathit{uN}}(31) \\
& {\mathit{u{\scriptstyle32}}} &::=& {\mathit{uN}}(32) \\
& {\mathit{u{\scriptstyle64}}} &::=& {\mathit{uN}}(64) \\
& {\mathit{u{\scriptstyle128}}} &::=& {\mathit{uN}}(128) \\
& {\mathit{s{\scriptstyle33}}} &::=& {\mathit{sN}}(33) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{signif}}(32) &=& 23 &  \\
{\mathrm{signif}}(64) &=& 52 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{expon}}(32) &=& 8 &  \\
{\mathrm{expon}}(64) &=& 11 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{M}}}_{{\mathit{N}}} &=& {\mathrm{signif}}({\mathit{N}}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{E}}}_{{\mathit{N}}} &=& {\mathrm{expon}}({\mathit{N}}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(floating-point number)} & {\mathit{fN}}({\mathit{N}}) &::=& {+{\mathit{fmag}}({\mathit{N}})} \\ &&|&
{-{\mathit{fmag}}({\mathit{N}})} \\
\mbox{(floating-point magnitude)} & {\mathit{fmag}}({\mathit{N}}) &::=& (1 + {\mathit{m}} \cdot {2^{{-{{\mathrm{M}}}_{{\mathit{N}}}}}}) \cdot {2^{{\mathit{n}}}} &\quad
  \mbox{if}~2 - {2^{{{\mathrm{E}}}_{{\mathit{N}}} - 1}} \leq {\mathit{n}} \leq {2^{{{\mathrm{E}}}_{{\mathit{N}}} - 1}} - 1 \\ &&|&
(0 + {\mathit{m}} \cdot {2^{{-{{\mathrm{M}}}_{{\mathit{N}}}}}}) \cdot {2^{{\mathit{n}}}} &\quad
  \mbox{if}~2 - {2^{{{\mathrm{E}}}_{{\mathit{N}}} - 1}} = {\mathit{n}} \\ &&|&
\infty \\ &&|&
{\mathsf{nan}}{({\mathit{n}})} &\quad
  \mbox{if}~1 \leq {\mathit{n}} < {{\mathrm{M}}}_{{\mathit{N}}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{+0} &=& {+((1 + 0 \cdot {2^{{-{{\mathrm{M}}}_{{\mathit{N}}}}}}) \cdot {2^{0}})} &  \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{f{\scriptstyle32}}} &::=& {\mathit{fN}}(32) \\
& {\mathit{f{\scriptstyle64}}} &::=& {\mathit{fN}}(64) \\
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
\mbox{(abstract heap type)} & {\mathit{absheaptype}} &::=& \mathsf{any} ~|~ \mathsf{eq} ~|~ \mathsf{i{\scriptstyle31}} ~|~ \mathsf{struct} ~|~ \mathsf{array} ~|~ \mathsf{none} \\ &&|&
\mathsf{func} ~|~ \mathsf{nofunc} \\ &&|&
\mathsf{extern} ~|~ \mathsf{noextern} \\ &&|&
\mathsf{bot} \\
\mbox{(heap type)} & {\mathit{heaptype}} &::=& {\mathit{absheaptype}} \\ &&|&
{\mathit{typeidx}} \\ &&|&
\dots \\
\mbox{(reference type)} & {\mathit{reftype}} &::=& \mathsf{ref}~{\mathit{nul}}~{\mathit{heaptype}} \\
\mbox{(value type)} & {\mathit{valtype}} &::=& {\mathit{numtype}} ~|~ {\mathit{vectype}} ~|~ {\mathit{reftype}} ~|~ \mathsf{bot} \\
& {\mathsf{i}}{{\mathit{n}}} &::=& \mathsf{i{\scriptstyle32}} ~|~ \mathsf{i{\scriptstyle64}} \\
& {\mathsf{f}}{{\mathit{n}}} &::=& \mathsf{f{\scriptstyle32}} ~|~ \mathsf{f{\scriptstyle64}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(result type)} & {\mathit{resulttype}} &::=& {{\mathit{valtype}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{mut}} &::=& {\mathsf{mut}^?} \\
& {\mathit{fin}} &::=& {\mathsf{final}^?} \\
\mbox{(packed type)} & {\mathit{packedtype}} &::=& \mathsf{i{\scriptstyle8}} ~|~ \mathsf{i{\scriptstyle16}} \\
\mbox{(storage type)} & {\mathit{storagetype}} &::=& {\mathit{valtype}} ~|~ {\mathit{packedtype}} \\
\mbox{(field type)} & {\mathit{fieldtype}} &::=& {\mathit{mut}}~{\mathit{storagetype}} \\
\mbox{(function type)} & {\mathit{functype}} &::=& {\mathit{resulttype}} \rightarrow {\mathit{resulttype}} \\
\mbox{(composite type)} & {\mathit{comptype}} &::=& \mathsf{struct}~{{\mathit{fieldtype}}^\ast} \\ &&|&
\mathsf{array}~{\mathit{fieldtype}} \\ &&|&
\mathsf{func}~{\mathit{functype}} \\
\mbox{(sub type)} & {\mathit{subtype}} &::=& \mathsf{sub}~{\mathit{fin}}~{{\mathit{typeidx}}^\ast}~{\mathit{comptype}} \\ &&|&
\dots \\
\mbox{(recursive type)} & {\mathit{rectype}} &::=& \mathsf{rec}~{{\mathit{subtype}}^\ast} \\
\mbox{(defined type)} & {\mathit{deftype}} &::=& {\mathit{rectype}} . {\mathit{nat}} \\
\mbox{(heap type)} & {\mathit{heaptype}} &::=& \dots \\ &&|&
{\mathit{deftype}} \\ &&|&
\mathsf{rec}~{\mathit{nat}} \\
\mbox{(sub type)} & {\mathit{subtype}} &::=& \dots \\ &&|&
\mathsf{sub}~{\mathit{fin}}~{{\mathit{heaptype}}^\ast}~{\mathit{comptype}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(limits)} & {\mathit{limits}} &::=& [{\mathit{u{\scriptstyle32}}} .. {\mathit{u{\scriptstyle32}}}] \\
\mbox{(global type)} & {\mathit{globaltype}} &::=& {\mathit{mut}}~{\mathit{valtype}} \\
\mbox{(table type)} & {\mathit{tabletype}} &::=& {\mathit{limits}}~{\mathit{reftype}} \\
\mbox{(memory type)} & {\mathit{memtype}} &::=& {\mathit{limits}}~\mathsf{i{\scriptstyle8}} \\
\mbox{(element type)} & {\mathit{elemtype}} &::=& {\mathit{reftype}} \\
\mbox{(data type)} & {\mathit{datatype}} &::=& \mathsf{ok} \\
\mbox{(external type)} & {\mathit{externtype}} &::=& \mathsf{func}~{\mathit{deftype}} ~|~ \mathsf{global}~{\mathit{globaltype}} ~|~ \mathsf{table}~{\mathit{tabletype}} ~|~ \mathsf{mem}~{\mathit{memtype}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(signedness)} & {\mathit{sx}} &::=& \mathsf{u} ~|~ \mathsf{s} \\
& {\mathit{iunop}} &::=& \mathsf{clz} ~|~ \mathsf{ctz} ~|~ \mathsf{popcnt} \\
& {\mathit{funop}} &::=& \mathsf{abs} ~|~ \mathsf{neg} ~|~ \mathsf{sqrt} ~|~ \mathsf{ceil} ~|~ \mathsf{floor} ~|~ \mathsf{trunc} ~|~ \mathsf{nearest} \\
& {\mathit{ibinop}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{mul} ~|~ {\mathsf{div\_}}{{\mathit{sx}}} ~|~ {\mathsf{rem\_}}{{\mathit{sx}}} \\ &&|&
\mathsf{and} ~|~ \mathsf{or} ~|~ \mathsf{xor} ~|~ \mathsf{shl} ~|~ {\mathsf{shr\_}}{{\mathit{sx}}} ~|~ \mathsf{rotl} ~|~ \mathsf{rotr} \\
& {\mathit{fbinop}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{mul} ~|~ \mathsf{div} ~|~ \mathsf{min} ~|~ \mathsf{max} ~|~ \mathsf{copysign} \\
& {\mathit{itestop}} &::=& \mathsf{eqz} \\
& {\mathit{ftestop}} &::=&  \\
& {\mathit{irelop}} &::=& \mathsf{eq} ~|~ \mathsf{ne} ~|~ {\mathsf{lt\_}}{{\mathit{sx}}} ~|~ {\mathsf{gt\_}}{{\mathit{sx}}} ~|~ {\mathsf{le\_}}{{\mathit{sx}}} ~|~ {\mathsf{ge\_}}{{\mathit{sx}}} \\
& {\mathit{frelop}} &::=& \mathsf{eq} ~|~ \mathsf{ne} ~|~ \mathsf{lt} ~|~ \mathsf{gt} ~|~ \mathsf{le} ~|~ \mathsf{ge} \\
& {\mathit{unop}}_{{\mathit{numtype}}} &::=& {\mathit{iunop}} ~|~ {\mathit{funop}} \\
& {\mathit{binop}}_{{\mathit{numtype}}} &::=& {\mathit{ibinop}} ~|~ {\mathit{fbinop}} \\
& {\mathit{testop}}_{{\mathit{numtype}}} &::=& {\mathit{itestop}} ~|~ {\mathit{ftestop}} \\
& {\mathit{relop}}_{{\mathit{numtype}}} &::=& {\mathit{irelop}} ~|~ {\mathit{frelop}} \\
& {\mathit{cvtop}} &::=& \mathsf{convert} ~|~ \mathsf{reinterpret} ~|~ \mathsf{convert\_sat} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{unopVVXX}} &::=& \mathsf{not} \\
& {\mathit{binopVVXX}} &::=& \mathsf{and} ~|~ \mathsf{andnot} ~|~ \mathsf{or} ~|~ \mathsf{xor} \\
& {\mathit{ternopVVXX}} &::=& \mathsf{bitselect} \\
& {\mathit{testopVVXX}} &::=& \mathsf{any\_true} \\
& {\mathit{testopVIXX}} &::=& \mathsf{all\_true} \\
& {\mathit{relopVIXX}} &::=& \mathsf{eq} ~|~ \mathsf{ne} ~|~ {\mathsf{lt\_}}{{\mathit{sx}}} ~|~ {\mathsf{gt\_}}{{\mathit{sx}}} ~|~ {\mathsf{le\_}}{{\mathit{sx}}} ~|~ {\mathsf{ge\_}}{{\mathit{sx}}} \\
& {\mathit{relopVFXX}} &::=& \mathsf{eq} ~|~ \mathsf{ne} ~|~ \mathsf{lt} ~|~ \mathsf{gt} ~|~ \mathsf{le} ~|~ \mathsf{ge} \\
& {\mathit{unopVIXX}} &::=& \mathsf{abs} ~|~ \mathsf{neg} \\
& {\mathit{binopVIXX}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{swizzle} \\
& {\mathit{minmaxopVIXX}} &::=& \mathsf{min}~{\mathit{sx}} ~|~ \mathsf{max}~{\mathit{sx}} \\
& {\mathit{satbinopVIXX}} &::=& \mathsf{add\_sat}~{\mathit{sx}} ~|~ \mathsf{sub\_sat}~{\mathit{sx}} \\
& {\mathit{shiftopVIXX}} &::=& \mathsf{shl} ~|~ {\mathsf{shr\_}}{{\mathit{sx}}} \\
& {\mathit{unopVFXX}} &::=& \mathsf{abs} ~|~ \mathsf{neg} ~|~ \mathsf{sqrt} ~|~ \mathsf{ceil} ~|~ \mathsf{floor} ~|~ \mathsf{trunc} ~|~ \mathsf{nearest} \\
& {\mathit{binopVFXX}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{mul} ~|~ \mathsf{div} ~|~ \mathsf{min} ~|~ \mathsf{max} ~|~ \mathsf{pmin} ~|~ \mathsf{pmax} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{unop}}_{{\mathit{vvectype}}} &::=& {\mathit{unopVVXX}} \\
& {\mathit{binop}}_{{\mathit{vvectype}}} &::=& {\mathit{binopVVXX}} \\
& {\mathit{ternop}}_{{\mathit{vvectype}}} &::=& {\mathit{ternopVVXX}} \\
& {\mathit{testop}}_{{\mathit{vvectype}}} &::=& {\mathit{testopVVXX}} \\
& {\mathit{shiftop}}_{{\mathit{vectype}}} &::=& {\mathit{shiftopVIXX}} \\
& {\mathit{unop}}_{{\mathit{vectype}}} &::=& {\mathit{unopVIXX}} ~|~ {\mathit{unopVFXX}} ~|~ \mathsf{popcnt} \\
& {\mathit{binop}}_{{\mathit{vectype}}} &::=& {\mathit{binopVIXX}}~{\mathit{minmaxopVIXX}}~{\mathit{satbinopVIXX}} ~|~ {\mathit{binopVFXX}} ~|~ \mathsf{mul} ~|~ \mathsf{avgr\_u} ~|~ \mathsf{q{\scriptstyle15}mulr\_sat\_s} \\
& {\mathit{testop}}_{{\mathit{vectype}}} &::=& {\mathit{testopVIXX}} \\
& {\mathit{relop}}_{{\mathit{vectype}}} &::=& {\mathit{relopVIXX}} ~|~ {\mathit{relopVFXX}} \\
& {\mathit{cvtop}}_{{\mathit{vectype}}} &::=& \mathsf{extend} ~|~ \mathsf{trunc\_sat} ~|~ \mathsf{convert} ~|~ \mathsf{demote} ~|~ \mathsf{promote} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(memory operator)} & {\mathit{memop}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{align}~{\mathit{u{\scriptstyle32}}},\; \mathsf{offset}~{\mathit{u{\scriptstyle32}}} \;\}\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{c}} &::=& {\mathit{nat}} \\
& {\mathit{c}}_{{\mathit{numtype}}} &::=& {\mathit{nat}} \\
& {\mathit{c}}_{{\mathit{vectype}}} &::=& {\mathit{nat}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(block type)} & {\mathit{blocktype}} &::=& {{\mathit{valtype}}^?} \\ &&|&
{\mathit{funcidx}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(instruction)} & {\mathit{instr}} &::=& \mathsf{unreachable} \\ &&|&
\mathsf{nop} \\ &&|&
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
\mathsf{call\_ref}~{{\mathit{typeidx}}^?} \\ &&|&
\mathsf{call\_indirect}~{\mathit{tableidx}}~{\mathit{typeidx}} \\ &&|&
\mathsf{return} \\ &&|&
\mathsf{return\_call}~{\mathit{funcidx}} \\ &&|&
\mathsf{return\_call\_ref}~{{\mathit{typeidx}}^?} \\ &&|&
\mathsf{return\_call\_indirect}~{\mathit{tableidx}}~{\mathit{typeidx}} \\ &&|&
{\mathit{numtype}}.\mathsf{const}~{\mathit{c}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {\mathit{unop}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {\mathit{binop}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {\mathit{testop}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {\mathit{relop}}_{{\mathit{numtype}}} \\ &&|&
{{\mathit{numtype}}.\mathsf{extend}}{{\mathit{n}}} \\ &&|&
{\mathit{numtype}} . {{{{{\mathit{cvtop}}}{\mathsf{\_}}}{{\mathit{numtype}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}} \\ &&|&
\dots \\
\mbox{(lane type)} & {\mathit{lanetype}} &::=& {\mathit{packedtype}} ~|~ {\mathit{numtype}} \\
\mbox{(lane size)} & {\mathit{lanesize}} &::=& {\mathit{nat}} \\
\mbox{(shape)} & {\mathit{shape}} &::=& {\mathit{lanetype}}~\mathsf{x}~{\mathit{lanesize}} \\
& {\mathit{half}} &::=& \mathsf{low} ~|~ \mathsf{high} \\
& {\mathit{zero}} &::=& {\mathsf{zero}^?} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(instruction)} & {\mathit{instr}} &::=& \dots \\ &&|&
{\mathit{vectype}}.\mathsf{const}~{\mathit{c}}_{{\mathit{vectype}}} \\ &&|&
{\mathit{vectype}} . {\mathit{unop}}_{{\mathit{vvectype}}} \\ &&|&
{\mathit{vectype}} . {\mathit{binop}}_{{\mathit{vvectype}}} \\ &&|&
{\mathit{vectype}} . {\mathit{ternop}}_{{\mathit{vvectype}}} \\ &&|&
{\mathit{vectype}} . {\mathit{testop}}_{{\mathit{vvectype}}} \\ &&|&
{\mathit{shape}}.\mathsf{vswizzle} \\ &&|&
{\mathit{shape}}.\mathsf{vshuffle}~{{\mathit{laneidx}}^\ast} \\ &&|&
{\mathit{shape}}.\mathsf{vsplat} \\ &&|&
{{{{{\mathit{shape}}.\mathsf{vextract}}{\mathsf{\_}}}{\mathsf{lane}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{laneidx}} \\ &&|&
{{{\mathit{shape}}.\mathsf{vreplace}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{laneidx}} \\ &&|&
{\mathit{shape}} . {\mathit{unop}}_{{\mathit{vectype}}} \\ &&|&
{\mathit{shape}} . {\mathit{binop}}_{{\mathit{vectype}}} \\ &&|&
{\mathit{shape}} . {\mathit{relop}}_{{\mathit{vectype}}} \\ &&|&
{\mathit{shape}} . {\mathit{shiftop}}_{{\mathit{vectype}}} \\ &&|&
{\mathit{shape}}.\mathsf{vall\_true} \\ &&|&
{\mathit{shape}}.\mathsf{vbitmask} \\ &&|&
{{{{{\mathit{shape}}.\mathsf{vnarrow}}{\mathsf{\_}}}{{\mathit{shape}}}}{\mathsf{\_}}}{{\mathit{sx}}} \\ &&|&
{\mathit{shape}} . {{{{{{{{{\mathit{cvtop}}_{{\mathit{vectype}}}}{\mathsf{\_}}}{{{\mathit{half}}^?}}}{\mathsf{\_}}}{{\mathit{shape}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}}{\mathsf{\_}}}{{\mathit{zero}}} \\ &&|&
{{{{{{{\mathit{shape}}.\mathsf{vextmul}}{\mathsf{\_}}}{{\mathit{half}}}}{\mathsf{\_}}}{{\mathit{shape}}}}{\mathsf{\_}}}{{\mathit{sx}}} \\ &&|&
{{{{{\mathit{shape}}.\mathsf{vdot}}{\mathsf{\_}}}{{\mathit{shape}}}}{\mathsf{\_}}}{{\mathit{sx}}} \\ &&|&
{{{{{\mathit{shape}}.\mathsf{vextadd\_pairwise}}{\mathsf{\_}}}{{\mathit{shape}}}}{\mathsf{\_}}}{{\mathit{sx}}} \\ &&|&
\dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(instruction)} & {\mathit{instr}} &::=& \dots \\ &&|&
\mathsf{ref.null}~{\mathit{heaptype}} \\ &&|&
\mathsf{ref.i{\scriptstyle31}} \\ &&|&
\mathsf{ref.func}~{\mathit{funcidx}} \\ &&|&
\mathsf{ref.is\_null} \\ &&|&
\mathsf{ref.as\_non\_null} \\ &&|&
\mathsf{ref.eq} \\ &&|&
\mathsf{ref.test}~{\mathit{reftype}} \\ &&|&
\mathsf{ref.cast}~{\mathit{reftype}} \\ &&|&
{{\mathsf{i{\scriptstyle31}.get}}{\mathsf{\_}}}{{\mathit{sx}}} \\ &&|&
\mathsf{struct.new}~{\mathit{typeidx}} \\ &&|&
\mathsf{struct.new\_default}~{\mathit{typeidx}} \\ &&|&
{{\mathsf{struct.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{typeidx}}~{\mathit{u{\scriptstyle32}}} \\ &&|&
\mathsf{struct.set}~{\mathit{typeidx}}~{\mathit{u{\scriptstyle32}}} \\ &&|&
\mathsf{array.new}~{\mathit{typeidx}} \\ &&|&
\mathsf{array.new\_default}~{\mathit{typeidx}} \\ &&|&
\mathsf{array.new\_fixed}~{\mathit{typeidx}}~{\mathit{nat}} \\ &&|&
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
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{packshape}} &::=& {\mathit{nat}}~\mathsf{x}~{\mathit{nat}} \\
& {\mathit{vloadop}} &::=& {{{\mathit{packshape}}}{\mathsf{\_}}}{{\mathit{sx}}} \\ &&|&
{{{\mathit{nat}}}{\mathsf{\_}}}{\mathsf{splat}} \\ &&|&
{{{\mathit{nat}}}{\mathsf{\_}}}{\mathsf{zero}} \\
\mbox{(instruction)} & {\mathit{instr}} &::=& \dots \\ &&|&
\mathsf{memory.size}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.grow}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.fill}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.copy}~{\mathit{memidx}}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.init}~{\mathit{memidx}}~{\mathit{dataidx}} \\ &&|&
\mathsf{data.drop}~{\mathit{dataidx}} \\ &&|&
{{\mathit{numtype}}.\mathsf{load}}{{({\mathit{n}}~\mathsf{\_}~{\mathit{sx}})^?}}~{\mathit{memidx}}~{\mathit{memop}} \\ &&|&
{{\mathit{numtype}}.\mathsf{store}}{{{\mathit{n}}^?}}~{\mathit{memidx}}~{\mathit{memop}} \\ &&|&
{\mathsf{v{\scriptstyle128}.load}}{{{\mathit{vloadop}}^?}}~{\mathit{memidx}}~{\mathit{memop}} \\ &&|&
{{{\mathsf{v{\scriptstyle128}.load}}{{\mathit{n}}}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{memidx}}~{\mathit{memop}}~{\mathit{laneidx}} \\ &&|&
\mathsf{v{\scriptstyle128}.store}~{\mathit{memidx}}~{\mathit{memop}} \\ &&|&
{{{\mathsf{v{\scriptstyle128}.store}}{{\mathit{n}}}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{memidx}}~{\mathit{memop}}~{\mathit{laneidx}} \\
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
\epsilon \setminus {{\mathit{y}}^\ast} &=& \epsilon &  \\
{\mathit{x}}_{{1}}~{{\mathit{x}}^\ast} \setminus {{\mathit{y}}^\ast} &=& {\mathrm{setminus{\scriptstyle1}}}({\mathit{x}}_{{1}}, {{\mathit{y}}^\ast})~{{\mathit{x}}^\ast} \setminus {{\mathit{y}}^\ast} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{setminus{\scriptstyle1}}}({\mathit{x}}, \epsilon) &=& {\mathit{x}} &  \\
{\mathrm{setminus{\scriptstyle1}}}({\mathit{x}}, {\mathit{y}}_{{1}}~{{\mathit{y}}^\ast}) &=& \epsilon &\quad
  \mbox{if}~{\mathit{x}} = {\mathit{y}}_{{1}} \\
{\mathrm{setminus{\scriptstyle1}}}({\mathit{x}}, {\mathit{y}}_{{1}}~{{\mathit{y}}^\ast}) &=& {\mathrm{setminus{\scriptstyle1}}}({\mathit{x}}, {{\mathit{y}}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{{\mathit{dataidx}}}(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}}) &=& {\mathit{y}} &  \\
{\mathrm{free}}_{{\mathit{dataidx}}}(\mathsf{data.drop}~{\mathit{x}}) &=& {\mathit{x}} &  \\
{\mathrm{free}}_{{\mathit{dataidx}}}({\mathit{in}}) &=& \epsilon &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{{\mathit{dataidx}}}(\epsilon) &=& \epsilon &  \\
{\mathrm{free}}_{{\mathit{dataidx}}}({\mathit{instr}}~{{\mathit{instr}'}^\ast}) &=& {\mathrm{free}}_{{\mathit{dataidx}}}({\mathit{instr}})~{\mathrm{free}}_{{\mathit{dataidx}}}({{\mathit{instr}'}^\ast}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{{\mathit{dataidx}}}({{\mathit{in}}^\ast}) &=& {\mathrm{free}}_{{\mathit{dataidx}}}({{\mathit{in}}^\ast}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{{\mathit{dataidx}}}(\mathsf{func}~{\mathit{x}}~{{\mathit{loc}}^\ast}~{\mathit{e}}) &=& {\mathrm{free}}_{{\mathit{dataidx}}}({\mathit{e}}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{{\mathit{dataidx}}}(\epsilon) &=& \epsilon &  \\
{\mathrm{free}}_{{\mathit{dataidx}}}({\mathit{func}}~{{\mathit{func}'}^\ast}) &=& {\mathrm{free}}_{{\mathit{dataidx}}}({\mathit{func}})~{\mathrm{free}}_{{\mathit{dataidx}}}({{\mathit{func}'}^\ast}) &  \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{concat}}(\epsilon) &=& \epsilon &  \\
{\mathrm{concat}}(({{\mathit{b}}^\ast})~{({{\mathit{b}'}^\ast})^\ast}) &=& {{\mathit{b}}^\ast}~{\mathrm{concat}}({({{\mathit{b}'}^\ast})^\ast}) &  \\
\end{array}
$$

\vspace{1ex}

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

$$
\begin{array}{@{}lcl@{}l@{}}
{|\mathsf{i{\scriptstyle8}}|} &=& 8 &  \\
{|\mathsf{i{\scriptstyle16}}|} &=& 16 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{|{\mathit{valtype}}|} &=& {|{\mathit{valtype}}|} &  \\
{|{\mathit{packedtype}}|} &=& {|{\mathit{packedtype}}|} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{|{\mathit{numtype}}|} &=& {|{\mathit{numtype}}|} &  \\
{|{\mathit{packedtype}}|} &=& {|{\mathit{packedtype}}|} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unpack}}({\mathit{valtype}}) &=& {\mathit{valtype}} &  \\
{\mathrm{unpack}}({\mathit{packedtype}}) &=& \mathsf{i{\scriptstyle32}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unpack}}({\mathit{numtype}}) &=& {\mathit{numtype}} &  \\
{\mathrm{unpack}}({\mathit{packedtype}}) &=& \mathsf{i{\scriptstyle32}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{sx}}({\mathit{valtype}}) &=& \epsilon &  \\
{\mathrm{sx}}({\mathit{packedtype}}) &=& \mathsf{s} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathsf{ref}~{\mathit{nul}}_{{1}}~{\mathit{ht}}_{{1}}) - (\mathsf{ref}~\mathsf{null}~{\mathit{ht}}_{{2}}) &=& (\mathsf{ref}~\epsilon~{\mathit{ht}}_{{1}}) &  \\
(\mathsf{ref}~{\mathit{nul}}_{{1}}~{\mathit{ht}}_{{1}}) - (\mathsf{ref}~\epsilon~{\mathit{ht}}_{{2}}) &=& (\mathsf{ref}~{\mathit{nul}}_{{1}}~{\mathit{ht}}_{{1}}) &  \\
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
{\mathit{x}} &=& {\mathit{x}} &  \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{xx}}}{[\epsilon := \epsilon]} &=& {\mathit{xx}} &  \\
{{\mathit{xx}}}{[{\mathit{xx}}_{{1}}~{{\mathit{xx}'}^\ast} := {\mathit{ht}}_{{1}}~{{\mathit{ht}'}^\ast}]} &=& {\mathit{ht}}_{{1}} &\quad
  \mbox{if}~{\mathit{xx}} = {\mathit{xx}}_{{1}} \\
{{\mathit{xx}}}{[{\mathit{xx}}_{{1}}~{{\mathit{xx}'}^\ast} := {\mathit{ht}}_{{1}}~{{\mathit{ht}'}^\ast}]} &=& {{\mathit{xx}}}{[{{\mathit{xx}'}^\ast} := {{\mathit{ht}'}^\ast}]} &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{nt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {\mathit{nt}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{vt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {\mathit{vt}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{xx}'}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {{\mathit{xx}'}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{{\mathit{dt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {{\mathit{dt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{{\mathit{ht}'}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {\mathit{ht}'} &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{ref}~{\mathit{nul}}~{\mathit{ht}'})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{ref}~{\mathit{nul}}~{{\mathit{ht}'}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{nt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {{\mathit{nt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{{\mathit{vt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {{\mathit{vt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{{\mathit{rt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {{\mathit{rt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{\mathsf{bot}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{bot} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{pt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {\mathit{pt}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{t}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {{\mathit{t}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{{\mathit{pt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {{\mathit{pt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{mut}}~{\mathit{zt}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {\mathit{mut}}~{{\mathit{zt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{struct}~{{\mathit{yt}}^\ast})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{struct}~{{{\mathit{yt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]}^\ast} &  \\
{(\mathsf{array}~{\mathit{yt}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{array}~{{\mathit{yt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{(\mathsf{func}~{\mathit{ft}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{func}~{{\mathit{ft}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{sub}~{\mathit{fin}}~{{\mathit{y}}^\ast}~{\mathit{ct}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{sub}~{\mathit{fin}}~{{{\mathit{y}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]}^\ast}~{{\mathit{ct}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{(\mathsf{sub}~{\mathit{fin}}~{{\mathit{ht}'}^\ast}~{\mathit{ct}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{sub}~{\mathit{fin}}~{{{\mathit{ht}'}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]}^\ast}~{{\mathit{ct}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{rec}~{{\mathit{st}}^\ast})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{rec}~{{{\mathit{st}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]}^\ast} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{qt}} . {\mathit{i}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {{\mathit{qt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} . {\mathit{i}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{mut}}~{\mathit{t}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {\mathit{mut}}~{{\mathit{t}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {{{\mathit{t}}_{{1}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]}^\ast} \rightarrow {{{\mathit{t}}_{{2}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]}^\ast} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{lim}}~\mathsf{i{\scriptstyle8}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {\mathit{lim}}~\mathsf{i{\scriptstyle8}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{lim}}~{\mathit{rt}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {\mathit{lim}}~{{\mathit{rt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{func}~{\mathit{dt}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{func}~{{\mathit{dt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{(\mathsf{global}~{\mathit{gt}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{global}~{{\mathit{gt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{(\mathsf{table}~{\mathit{tt}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{table}~{{\mathit{tt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{(\mathsf{mem}~{\mathit{mt}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{mem}~{{\mathit{mt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{rt}}}{[{ := }\;{{\mathit{ht}}^{{\mathit{n}}}}]} &=& {{\mathit{rt}}}{[{{\mathit{x}}^{{\mathit{x}}<{\mathit{n}}}} := {{\mathit{ht}}^{{\mathit{n}}}}]} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{dt}}}{[{ := }\;{{\mathit{ht}}^{{\mathit{n}}}}]} &=& {{\mathit{dt}}}{[{{\mathit{x}}^{{\mathit{x}}<{\mathit{n}}}} := {{\mathit{ht}}^{{\mathit{n}}}}]} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\epsilon}{[{ := }\;{{\mathit{ht}}^\ast}]} &=& \epsilon &  \\
{{\mathit{dt}}_{{1}}~{{\mathit{dt}}^\ast}}{[{ := }\;{{\mathit{ht}}^\ast}]} &=& {{\mathit{dt}}_{{1}}}{[{ := }\;{{\mathit{ht}}^\ast}]}~{{{\mathit{dt}}^\ast}}{[{ := }\;{{\mathit{ht}}^\ast}]} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{roll}}}_{{\mathit{x}}}(\mathsf{rec}~{{\mathit{st}}^{{\mathit{n}}}}) &=& \mathsf{rec}~{({{\mathit{st}}}{[{({\mathit{x}} + {\mathit{i}})^{{\mathit{i}}<{\mathit{n}}}} := {(\mathsf{rec}~{\mathit{i}})^{{\mathit{i}}<{\mathit{n}}}}]})^{{\mathit{n}}}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unroll}}(\mathsf{rec}~{{\mathit{st}}^{{\mathit{n}}}}) &=& \mathsf{rec}~{({{\mathit{st}}}{[{(\mathsf{rec}~{\mathit{i}})^{{\mathit{i}}<{\mathit{n}}}} := {({\mathit{qt}} . {\mathit{i}})^{{\mathit{i}}<{\mathit{n}}}}]})^{{\mathit{n}}}} &\quad
  \mbox{if}~{\mathit{qt}} = \mathsf{rec}~{{\mathit{st}}^{{\mathit{n}}}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{roll}}}_{{\mathit{x}}}({\mathit{qt}}) &=& {((\mathsf{rec}~{{\mathit{st}}^{{\mathit{n}}}}) . {\mathit{i}})^{{\mathit{i}}<{\mathit{n}}}} &\quad
  \mbox{if}~{{\mathrm{roll}}}_{{\mathit{x}}}({\mathit{qt}}) = \mathsf{rec}~{{\mathit{st}}^{{\mathit{n}}}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unroll}}({\mathit{qt}} . {\mathit{i}}) &=& {{\mathit{st}}^\ast}[{\mathit{i}}] &\quad
  \mbox{if}~{\mathrm{unroll}}({\mathit{qt}}) = \mathsf{rec}~{{\mathit{st}}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{expand}}({\mathit{dt}}) &=& {\mathit{ct}} &\quad
  \mbox{if}~{\mathrm{unroll}}({\mathit{dt}}) = \mathsf{sub}~{\mathit{fin}}~{{\mathit{ht}}^\ast}~{\mathit{ct}} \\
\end{array}
$$

$\boxed{{\mathit{deftype}} \approx {\mathit{comptype}}}$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize Expand}]} \quad & {\mathit{dt}} &\approx& {\mathit{ct}} &\quad
  \mbox{if}~{\mathrm{expand}}({\mathit{dt}}) = {\mathit{ct}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{funcs}}(\epsilon) &=& \epsilon &  \\
{\mathrm{funcs}}((\mathsf{func}~{\mathit{dt}})~{{\mathit{et}}^\ast}) &=& {\mathit{dt}}~{\mathrm{funcs}}({{\mathit{et}}^\ast}) &  \\
{\mathrm{funcs}}({\mathit{externtype}}~{{\mathit{et}}^\ast}) &=& {\mathrm{funcs}}({{\mathit{et}}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{globals}}(\epsilon) &=& \epsilon &  \\
{\mathrm{globals}}((\mathsf{global}~{\mathit{gt}})~{{\mathit{et}}^\ast}) &=& {\mathit{gt}}~{\mathrm{globals}}({{\mathit{et}}^\ast}) &  \\
{\mathrm{globals}}({\mathit{externtype}}~{{\mathit{et}}^\ast}) &=& {\mathrm{globals}}({{\mathit{et}}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{tables}}(\epsilon) &=& \epsilon &  \\
{\mathrm{tables}}((\mathsf{table}~{\mathit{tt}})~{{\mathit{et}}^\ast}) &=& {\mathit{tt}}~{\mathrm{tables}}({{\mathit{et}}^\ast}) &  \\
{\mathrm{tables}}({\mathit{externtype}}~{{\mathit{et}}^\ast}) &=& {\mathrm{tables}}({{\mathit{et}}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{mems}}(\epsilon) &=& \epsilon &  \\
{\mathrm{mems}}((\mathsf{mem}~{\mathit{mt}})~{{\mathit{et}}^\ast}) &=& {\mathit{mt}}~{\mathrm{mems}}({{\mathit{et}}^\ast}) &  \\
{\mathrm{mems}}({\mathit{externtype}}~{{\mathit{et}}^\ast}) &=& {\mathrm{mems}}({{\mathit{et}}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
 &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~0,\; \mathsf{offset}~0 \}\end{array} &  \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{signed}}}_{{\mathit{N}}}({\mathit{i}}) &=& {\mathit{i}} &\quad
  \mbox{if}~0 \leq {2^{{\mathit{N}} - 1}} \\
{{\mathrm{signed}}}_{{\mathit{N}}}({\mathit{i}}) &=& {\mathit{i}} - {2^{{\mathit{N}}}} &\quad
  \mbox{if}~{2^{{\mathit{N}} - 1}} \leq {\mathit{i}} < {2^{{\mathit{N}}}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{{{\mathrm{signed}}^{{-1}}}}{}}_{{\mathit{N}}}}{{\mathit{i}}} &=& {\mathit{j}} &\quad
  \mbox{if}~{{\mathrm{signed}}}_{{\mathit{N}}}({\mathit{j}}) = {\mathit{i}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{invibytes}}({\mathit{N}}, {{\mathit{b}}^\ast}) &=& {\mathit{n}} &\quad
  \mbox{if}~{{\mathrm{bytes}}}_{{{\mathit{i}}}{{\mathit{N}}}}({\mathit{n}}) = {{\mathit{b}}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{invfbytes}}({\mathit{N}}, {{\mathit{b}}^\ast}) &=& {\mathit{p}} &\quad
  \mbox{if}~{{\mathrm{bytes}}}_{{{\mathit{f}}}{{\mathit{N}}}}({\mathit{p}}) = {{\mathit{b}}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unpacked}}({\mathit{pt}}~\mathsf{x}~{\mathit{lns}}) &=& \mathsf{i{\scriptstyle32}} &  \\
{\mathrm{unpacked}}({\mathit{nt}}~\mathsf{x}~{\mathit{lns}}) &=& {\mathit{nt}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{dim}}({\mathit{lnt}}~\mathsf{x}~{\mathit{lns}}) &=& {\mathit{lns}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{halfop}}(\mathsf{low}, {\mathit{i}}, {\mathit{j}}) &=& {\mathit{i}} &  \\
{\mathrm{halfop}}(\mathsf{high}, {\mathit{i}}, {\mathit{j}}) &=& {\mathit{j}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{ishape}}(8) &=& \mathsf{i{\scriptstyle8}} &  \\
{\mathrm{ishape}}(16) &=& \mathsf{i{\scriptstyle16}} &  \\
{\mathrm{ishape}}(32) &=& \mathsf{i{\scriptstyle32}} &  \\
{\mathrm{ishape}}(64) &=& \mathsf{i{\scriptstyle64}} &  \\
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
\mbox{(number)} & {\mathit{num}} &::=& {\mathit{numtype}}.\mathsf{const}~{\mathit{c}}_{{\mathit{numtype}}} \\
\mbox{(vector)} & {\mathit{vec}} &::=& {\mathit{vectype}}.\mathsf{const}~{\mathit{c}}_{{\mathit{vectype}}} \\
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
& {\mathit{c}}_{{\mathit{packedtype}}} &::=& {\mathit{nat}} \\
\mbox{(function instance)} & {\mathit{funcinst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{deftype}},\; \\
  \mathsf{module}~{\mathit{moduleinst}},\; \\
  \mathsf{code}~{\mathit{func}} \;\}\end{array} \\
\mbox{(global instance)} & {\mathit{globalinst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{globaltype}},\; \\
  \mathsf{value}~{\mathit{val}} \;\}\end{array} \\
\mbox{(table instance)} & {\mathit{tableinst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{tabletype}},\; \\
  \mathsf{elem}~{{\mathit{ref}}^\ast} \;\}\end{array} \\
\mbox{(memory instance)} & {\mathit{meminst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{memtype}},\; \\
  \mathsf{data}~{{\mathit{byte}}^\ast} \;\}\end{array} \\
\mbox{(element instance)} & {\mathit{eleminst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{elemtype}},\; \\
  \mathsf{elem}~{{\mathit{ref}}^\ast} \;\}\end{array} \\
\mbox{(data instance)} & {\mathit{datainst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{data}~{{\mathit{byte}}^\ast} \;\}\end{array} \\
\mbox{(export instance)} & {\mathit{exportinst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \\
  \mathsf{value}~{\mathit{externval}} \;\}\end{array} \\
\mbox{(packed value)} & {\mathit{packedval}} &::=& {\mathit{packedtype}}.\mathsf{pack}~{\mathit{c}}_{{\mathit{packedtype}}} \\
\mbox{(field value)} & {\mathit{fieldval}} &::=& {\mathit{val}} ~|~ {\mathit{packedval}} \\
\mbox{(structure instance)} & {\mathit{structinst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{deftype}},\; \\
  \mathsf{field}~{{\mathit{fieldval}}^\ast} \;\}\end{array} \\
\mbox{(array instance)} & {\mathit{arrayinst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{deftype}},\; \\
  \mathsf{field}~{{\mathit{fieldval}}^\ast} \;\}\end{array} \\
\mbox{(module instance)} & {\mathit{moduleinst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{{\mathit{deftype}}^\ast},\; \\
  \mathsf{func}~{{\mathit{funcaddr}}^\ast},\; \\
  \mathsf{global}~{{\mathit{globaladdr}}^\ast},\; \\
  \mathsf{table}~{{\mathit{tableaddr}}^\ast},\; \\
  \mathsf{mem}~{{\mathit{memaddr}}^\ast},\; \\
  \mathsf{elem}~{{\mathit{elemaddr}}^\ast},\; \\
  \mathsf{data}~{{\mathit{dataaddr}}^\ast},\; \\
  \mathsf{export}~{{\mathit{exportinst}}^\ast} \;\}\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(store)} & {\mathit{store}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{func}~{{\mathit{funcinst}}^\ast},\; \\
  \mathsf{global}~{{\mathit{globalinst}}^\ast},\; \\
  \mathsf{table}~{{\mathit{tableinst}}^\ast},\; \\
  \mathsf{mem}~{{\mathit{meminst}}^\ast},\; \\
  \mathsf{elem}~{{\mathit{eleminst}}^\ast},\; \\
  \mathsf{data}~{{\mathit{datainst}}^\ast},\; \\
  \mathsf{struct}~{{\mathit{structinst}}^\ast},\; \\
  \mathsf{array}~{{\mathit{arrayinst}}^\ast} \;\}\end{array} \\
\mbox{(frame)} & {\mathit{frame}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{local}~{({{\mathit{val}}^?})^\ast},\; \\
  \mathsf{module}~{\mathit{moduleinst}} \;\}\end{array} \\
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
\mbox{(evaluation context)} & {\mathit{E}} &::=& [\mathsf{\_}] \\ &&|&
{{\mathit{val}}^\ast}~{\mathit{E}}~{{\mathit{instr}}^\ast} \\ &&|&
{{\mathsf{label}}_{{\mathit{n}}}}{\{{{\mathit{instr}}^\ast}\}}~{\mathit{E}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{inst}}}_{{\mathit{mm}}}({\mathit{rt}}) &=& {{\mathit{rt}}}{[{ := }\;{{\mathit{dt}}^\ast}]} &\quad
  \mbox{if}~{{\mathit{dt}}^\ast} = {\mathit{mm}}.\mathsf{type} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{default}}~\mathsf{i{\scriptstyle32}} &=& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) &  \\
{\mathrm{default}}~\mathsf{i{\scriptstyle64}} &=& (\mathsf{i{\scriptstyle64}}.\mathsf{const}~0) &  \\
{\mathrm{default}}~\mathsf{f{\scriptstyle32}} &=& (\mathsf{f{\scriptstyle32}}.\mathsf{const}~0) &  \\
{\mathrm{default}}~\mathsf{f{\scriptstyle64}} &=& (\mathsf{f{\scriptstyle64}}.\mathsf{const}~0) &  \\
{\mathrm{default}}~\mathsf{v{\scriptstyle128}} &=& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~0) &  \\
{\mathrm{default}}~\mathsf{ref}~\mathsf{null}~{\mathit{ht}} &=& (\mathsf{ref.null}~{\mathit{ht}}) &  \\
{\mathrm{default}}~\mathsf{ref}~\epsilon~{\mathit{ht}} &=& \epsilon &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{pack}}}_{{\mathit{t}}}({\mathit{val}}) &=& {\mathit{val}} &  \\
{{\mathrm{pack}}}_{{\mathit{pt}}}(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}) &=& {\mathit{pt}}.\mathsf{pack}~{{{\mathrm{wrap}}}_{(32,\, {|{\mathit{pt}}|})}}{({\mathit{i}})} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{{\mathrm{unpack}}}_{{\mathit{t}}}^{\epsilon}}}{({\mathit{val}})} &=& {\mathit{val}} &  \\
{{{{\mathrm{unpack}}}_{{\mathit{pt}}}^{{\mathit{sx}}}}}{({\mathit{pt}}.\mathsf{pack}~{\mathit{i}})} &=& \mathsf{i{\scriptstyle32}}.\mathsf{const}~{{{{\mathrm{ext}}}_{({|{\mathit{pt}}|},\, 32)}^{{\mathit{sx}}}}}{({\mathit{i}})} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{funcs}}(\epsilon) &=& \epsilon &  \\
{\mathrm{funcs}}((\mathsf{func}~{\mathit{fa}})~{{\mathit{xv}}^\ast}) &=& {\mathit{fa}}~{\mathrm{funcs}}({{\mathit{xv}}^\ast}) &  \\
{\mathrm{funcs}}({\mathit{externval}}~{{\mathit{xv}}^\ast}) &=& {\mathrm{funcs}}({{\mathit{xv}}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{globals}}(\epsilon) &=& \epsilon &  \\
{\mathrm{globals}}((\mathsf{global}~{\mathit{ga}})~{{\mathit{xv}}^\ast}) &=& {\mathit{ga}}~{\mathrm{globals}}({{\mathit{xv}}^\ast}) &  \\
{\mathrm{globals}}({\mathit{externval}}~{{\mathit{xv}}^\ast}) &=& {\mathrm{globals}}({{\mathit{xv}}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{tables}}(\epsilon) &=& \epsilon &  \\
{\mathrm{tables}}((\mathsf{table}~{\mathit{ta}})~{{\mathit{xv}}^\ast}) &=& {\mathit{ta}}~{\mathrm{tables}}({{\mathit{xv}}^\ast}) &  \\
{\mathrm{tables}}({\mathit{externval}}~{{\mathit{xv}}^\ast}) &=& {\mathrm{tables}}({{\mathit{xv}}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{mems}}(\epsilon) &=& \epsilon &  \\
{\mathrm{mems}}((\mathsf{mem}~{\mathit{ma}})~{{\mathit{xv}}^\ast}) &=& {\mathit{ma}}~{\mathrm{mems}}({{\mathit{xv}}^\ast}) &  \\
{\mathrm{mems}}({\mathit{externval}}~{{\mathit{xv}}^\ast}) &=& {\mathrm{mems}}({{\mathit{xv}}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{store} &=& {\mathit{s}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{frame} &=& {\mathit{f}} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{module}.\mathsf{func} &=& {\mathit{f}}.\mathsf{module}.\mathsf{func} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{func} &=& {\mathit{s}}.\mathsf{func} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{global} &=& {\mathit{s}}.\mathsf{global} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{table} &=& {\mathit{s}}.\mathsf{table} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{mem} &=& {\mathit{s}}.\mathsf{mem} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{elem} &=& {\mathit{s}}.\mathsf{elem} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{data} &=& {\mathit{s}}.\mathsf{data} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{struct} &=& {\mathit{s}}.\mathsf{struct} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{array} &=& {\mathit{s}}.\mathsf{array} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{module} &=& {\mathit{f}}.\mathsf{module} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{type}~[{\mathit{x}}] &=& {\mathit{f}}.\mathsf{module}.\mathsf{type}[{\mathit{x}}] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{s}} ; {\mathit{f}}).\mathsf{func}}{[{\mathit{x}}]} &=& {\mathit{s}}.\mathsf{func}[{\mathit{f}}.\mathsf{module}.\mathsf{func}[{\mathit{x}}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{s}} ; {\mathit{f}}).\mathsf{global}}{[{\mathit{x}}]} &=& {\mathit{s}}.\mathsf{global}[{\mathit{f}}.\mathsf{module}.\mathsf{global}[{\mathit{x}}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{s}} ; {\mathit{f}}).\mathsf{table}}{[{\mathit{x}}]} &=& {\mathit{s}}.\mathsf{table}[{\mathit{f}}.\mathsf{module}.\mathsf{table}[{\mathit{x}}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{s}} ; {\mathit{f}}).\mathsf{mem}}{[{\mathit{x}}]} &=& {\mathit{s}}.\mathsf{mem}[{\mathit{f}}.\mathsf{module}.\mathsf{mem}[{\mathit{x}}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{s}} ; {\mathit{f}}).\mathsf{elem}}{[{\mathit{x}}]} &=& {\mathit{s}}.\mathsf{elem}[{\mathit{f}}.\mathsf{module}.\mathsf{elem}[{\mathit{x}}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{s}} ; {\mathit{f}}).\mathsf{data}}{[{\mathit{x}}]} &=& {\mathit{s}}.\mathsf{data}[{\mathit{f}}.\mathsf{module}.\mathsf{data}[{\mathit{x}}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{s}} ; {\mathit{f}}).\mathsf{local}}{[{\mathit{x}}]} &=& {\mathit{f}}.\mathsf{local}[{\mathit{x}}] &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{local}[{\mathit{x}}] = {\mathit{v}}] &=& {\mathit{s}} ; {\mathit{f}}[\mathsf{local}[{\mathit{x}}] = {\mathit{v}}] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{global}[{\mathit{x}}].\mathsf{value} = {\mathit{v}}] &=& {\mathit{s}}[\mathsf{global}[{\mathit{f}}.\mathsf{module}.\mathsf{global}[{\mathit{x}}]].\mathsf{value} = {\mathit{v}}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{table}[{\mathit{x}}].\mathsf{elem}[{\mathit{i}}] = {\mathit{r}}] &=& {\mathit{s}}[\mathsf{table}[{\mathit{f}}.\mathsf{module}.\mathsf{table}[{\mathit{x}}]].\mathsf{elem}[{\mathit{i}}] = {\mathit{r}}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{table}[{\mathit{x}}] = {\mathit{ti}}] &=& {\mathit{s}}[\mathsf{table}[{\mathit{f}}.\mathsf{module}.\mathsf{table}[{\mathit{x}}]] = {\mathit{ti}}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{mem}[{\mathit{x}}].\mathsf{data}[{\mathit{i}} : {\mathit{j}}] = {{\mathit{b}}^\ast}] &=& {\mathit{s}}[\mathsf{mem}[{\mathit{f}}.\mathsf{module}.\mathsf{mem}[{\mathit{x}}]].\mathsf{data}[{\mathit{i}} : {\mathit{j}}] = {{\mathit{b}}^\ast}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{mem}[{\mathit{x}}] = {\mathit{mi}}] &=& {\mathit{s}}[\mathsf{mem}[{\mathit{f}}.\mathsf{module}.\mathsf{mem}[{\mathit{x}}]] = {\mathit{mi}}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{elem}[{\mathit{x}}].\mathsf{elem} = {{\mathit{r}}^\ast}] &=& {\mathit{s}}[\mathsf{elem}[{\mathit{f}}.\mathsf{module}.\mathsf{elem}[{\mathit{x}}]].\mathsf{elem} = {{\mathit{r}}^\ast}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{data}[{\mathit{x}}].\mathsf{data} = {{\mathit{b}}^\ast}] &=& {\mathit{s}}[\mathsf{data}[{\mathit{f}}.\mathsf{module}.\mathsf{data}[{\mathit{x}}]].\mathsf{data} = {{\mathit{b}}^\ast}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{struct}[{\mathit{a}}].\mathsf{field}[{\mathit{i}}] = {\mathit{fv}}] &=& {\mathit{s}}[\mathsf{struct}[{\mathit{a}}].\mathsf{field}[{\mathit{i}}] = {\mathit{fv}}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{struct}[{\mathit{a}}].\mathsf{field}[{\mathit{i}}] = {\mathit{fv}}] &=& {\mathit{s}}[\mathsf{array}[{\mathit{a}}].\mathsf{field}[{\mathit{i}}] = {\mathit{fv}}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{struct} = ..{{\mathit{si}}^\ast}] &=& {\mathit{s}}[\mathsf{struct} = ..{{\mathit{si}}^\ast}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{array} = ..{{\mathit{ai}}^\ast}] &=& {\mathit{s}}[\mathsf{array} = ..{{\mathit{ai}}^\ast}] ; {\mathit{f}} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{growtable}}({\mathit{ti}}, {\mathit{n}}, {\mathit{r}}) &=& {\mathit{ti}'} &\quad
  \mbox{if}~{\mathit{ti}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([{\mathit{i}} .. {\mathit{j}}]~{\mathit{rt}}),\; \mathsf{elem}~{{\mathit{r}'}^\ast} \}\end{array} \\
 &&&\quad {\land}~{\mathit{i}'} = {|{{\mathit{r}'}^\ast}|} + {\mathit{n}} \\
 &&&\quad {\land}~{\mathit{ti}'} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([{\mathit{i}'} .. {\mathit{j}}]~{\mathit{rt}}),\; \mathsf{elem}~{{\mathit{r}'}^\ast}~{{\mathit{r}}^{{\mathit{n}}}} \}\end{array} \\
 &&&\quad {\land}~{\mathit{i}'} \leq {\mathit{j}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{growmemory}}({\mathit{mi}}, {\mathit{n}}) &=& {\mathit{mi}'} &\quad
  \mbox{if}~{\mathit{mi}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([{\mathit{i}} .. {\mathit{j}}]~\mathsf{i{\scriptstyle8}}),\; \mathsf{data}~{{\mathit{b}}^\ast} \}\end{array} \\
 &&&\quad {\land}~{\mathit{i}'} = {|{{\mathit{b}}^\ast}|} / (64 \cdot {\mathrm{Ki}}) + {\mathit{n}} \\
 &&&\quad {\land}~{\mathit{mi}'} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([{\mathit{i}'} .. {\mathit{j}}]~\mathsf{i{\scriptstyle8}}),\; \mathsf{data}~{{\mathit{b}}^\ast}~{0^{{\mathit{n}} \cdot 64 \cdot {\mathrm{Ki}}}} \}\end{array} \\
 &&&\quad {\land}~{\mathit{i}'} \leq {\mathit{j}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(initialization status)} & {\mathit{init}} &::=& \mathsf{set} ~|~ \mathsf{unset} \\
\mbox{(local type)} & {\mathit{localtype}} &::=& {\mathit{init}}~{\mathit{valtype}} \\
\mbox{(instruction type)} & {\mathit{instrtype}} &::=& {\mathit{resulttype}} \rightarrow {{\mathit{localidx}}^\ast}~{\mathit{resulttype}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(context)} & {\mathit{context}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{{\mathit{deftype}}^\ast},\; \mathsf{rec}~{{\mathit{subtype}}^\ast},\; \\
  \mathsf{func}~{{\mathit{deftype}}^\ast},\; \mathsf{global}~{{\mathit{globaltype}}^\ast},\; \mathsf{table}~{{\mathit{tabletype}}^\ast},\; \mathsf{mem}~{{\mathit{memtype}}^\ast},\; \\
  \mathsf{elem}~{{\mathit{elemtype}}^\ast},\; \mathsf{data}~{{\mathit{datatype}}^\ast},\; \\
  \mathsf{local}~{{\mathit{localtype}}^\ast},\; \mathsf{label}~{{\mathit{resulttype}}^\ast},\; \mathsf{return}~{{\mathit{resulttype}}^?} \;\}\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{C}}[\mathsf{local}[\epsilon] = \epsilon] &=& {\mathit{C}} &  \\
{\mathit{C}}[\mathsf{local}[{\mathit{x}}_{{1}}~{{\mathit{x}}^\ast}] = {\mathit{lt}}_{{1}}~{{\mathit{lt}}^\ast}] &=& {\mathit{C}}[\mathsf{local}[{\mathit{x}}_{{1}}] = {\mathit{lt}}_{{1}}][\mathsf{local}[{{\mathit{x}}^\ast}] = {{\mathit{lt}}^\ast}] &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{clos}}~{\mathit{C}}~({\mathit{dt}}) &=& {{\mathit{dt}}}{[{ := }\;{{\mathit{dt}'}^\ast}]} &\quad
  \mbox{if}~{{\mathit{dt}'}^\ast} = {\mathrm{clos}}~{}^\ast~({\mathit{C}}.\mathsf{type}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{clos}}~{}^\ast~(\epsilon) &=& \epsilon &  \\
{\mathrm{clos}}~{}^\ast~({{\mathit{dt}}^\ast}~{\mathit{dt}}_{{\mathit{N}}}) &=& {{\mathit{dt}'}^\ast}~{{\mathit{dt}}_{{\mathit{N}}}}{[{ := }\;{{\mathit{dt}'}^\ast}]} &\quad
  \mbox{if}~{{\mathit{dt}'}^\ast} = {\mathrm{clos}}~{}^\ast~({{\mathit{dt}}^\ast}) \\
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
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] = {\mathit{dt}}
}{
{\mathit{C}} \vdash {\mathit{x}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}heap{-}typeidx}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{rec}[{\mathit{i}}] = {\mathit{st}}
}{
{\mathit{C}} \vdash \mathsf{rec}~{\mathit{i}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}heap{-}rec}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{ht}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{ref}~{\mathit{nul}}~{\mathit{ht}} : \mathsf{ok}
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
(({\mathit{C}}.\mathsf{local}[{\mathit{x}}] = {\mathit{lt}}))^\ast
}{
{\mathit{C}} \vdash {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{x}}^\ast}~{{\mathit{t}}_{{2}}^\ast} : \mathsf{ok}
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

$\boxed{{\mathit{context}} \vdash {\mathit{packedtype}} : \mathsf{ok}}$

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
{\mathit{C}} \vdash {\mathit{packedtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}packed}]}
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
{\mathit{C}} \vdash {\mathit{packedtype}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathit{packedtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}storage{-}packed}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{zt}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathit{mut}}~{\mathit{zt}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}field}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{C}} \vdash {\mathit{yt}} : \mathsf{ok})^\ast
}{
{\mathit{C}} \vdash \mathsf{struct}~{{\mathit{yt}}^\ast} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}comp{-}struct}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{yt}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{array}~{\mathit{yt}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}comp{-}array}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{ft}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{func}~{\mathit{ft}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}comp{-}func}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{|{{\mathit{y}}^\ast}|} \leq 1
 \qquad
(({\mathit{y}} < {\mathit{x}}))^\ast
 \qquad
(({\mathrm{unroll}}({\mathit{C}}.\mathsf{type}[{\mathit{y}}]) = \mathsf{sub}~{{\mathit{y}'}^\ast}~{\mathit{ct}'}))^\ast
 \qquad
{\mathit{C}} \vdash {\mathit{ct}} : \mathsf{ok}
 \qquad
({\mathit{C}} \vdash {\mathit{ct}} \leq {\mathit{ct}'})^\ast
}{
{\mathit{C}} \vdash \mathsf{sub}~{\mathit{fin}}~{{\mathit{y}}^\ast}~{\mathit{ct}} : {\mathsf{ok}}{({\mathit{x}})}
} \, {[\textsc{\scriptsize K{-}sub}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{deftype}} \prec {\mathit{x}}, {\mathit{i}} &=& \mathsf{true} &  \\
{\mathit{typeidx}} \prec {\mathit{x}}, {\mathit{i}} &=& {\mathit{typeidx}} < {\mathit{x}} &  \\
\mathsf{rec}~{\mathit{j}} \prec {\mathit{x}}, {\mathit{i}} &=& {\mathit{j}} < {\mathit{i}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{unroll}}}_{{\mathit{C}}}({\mathit{deftype}}) &=& {\mathrm{unroll}}({\mathit{deftype}}) &  \\
{{\mathrm{unroll}}}_{{\mathit{C}}}({\mathit{typeidx}}) &=& {\mathrm{unroll}}({\mathit{C}}.\mathsf{type}[{\mathit{typeidx}}]) &  \\
{{\mathrm{unroll}}}_{{\mathit{C}}}(\mathsf{rec}~{\mathit{i}}) &=& {\mathit{C}}.\mathsf{rec}[{\mathit{i}}] &  \\
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{|{{\mathit{ht}}^\ast}|} \leq 1
 \qquad
(({\mathit{ht}} \prec {\mathit{x}}, {\mathit{i}}))^\ast
 \qquad
(({{\mathrm{unroll}}}_{{\mathit{C}}}({\mathit{ht}}) = \mathsf{subd}~{{\mathit{ht}'}^\ast}~{\mathit{ct}'}))^\ast
 \qquad
{\mathit{C}} \vdash {\mathit{ct}} : \mathsf{ok}
 \qquad
({\mathit{C}} \vdash {\mathit{ct}} \leq {\mathit{ct}'})^\ast
}{
{\mathit{C}} \vdash \mathsf{sub}~{\mathit{fin}}~{{\mathit{ht}}^\ast}~{\mathit{ct}} : {\mathsf{ok}}{({\mathit{x}},\, {\mathit{i}})}
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
{\mathit{C}} \vdash {\mathit{st}}_{{1}} : {\mathsf{ok}}{({\mathit{x}})}
 \qquad
{\mathit{C}} \vdash \mathsf{rec}~{{\mathit{st}}^\ast} : {\mathsf{ok}}{({\mathit{x}} + 1)}
}{
{\mathit{C}} \vdash \mathsf{rec}~{\mathit{st}}_{{1}}~{{\mathit{st}}^\ast} : {\mathsf{ok}}{({\mathit{x}})}
} \, {[\textsc{\scriptsize K{-}rect{-}cons}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}, \mathsf{rec}~{{\mathit{st}}^\ast} \vdash \mathsf{rec}~{{\mathit{st}}^\ast} : {\mathsf{ok}}{({\mathit{x}},\, 0)}
}{
{\mathit{C}} \vdash \mathsf{rec}~{{\mathit{st}}^\ast} : {\mathsf{ok}}{({\mathit{x}})}
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
{\mathit{C}} \vdash {\mathit{st}}_{{1}} : {\mathsf{ok}}{({\mathit{x}},\, {\mathit{i}})}
 \qquad
{\mathit{C}} \vdash \mathsf{rec}~{{\mathit{st}}^\ast} : {\mathsf{ok}}{({\mathit{x}} + 1,\, {\mathit{i}} + 1)}
}{
{\mathit{C}} \vdash \mathsf{rec}~{\mathit{st}}_{{1}}~{{\mathit{st}}^\ast} : {\mathsf{ok}}{({\mathit{x}},\, {\mathit{i}})}
} \, {[\textsc{\scriptsize K{-}rec2{-}cons}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{qt}} : {\mathsf{ok}}{({\mathit{x}})}
 \qquad
{\mathit{qt}} = \mathsf{rec}~{{\mathit{st}}^{{\mathit{n}}}}
 \qquad
{\mathit{i}} < {\mathit{n}}
}{
{\mathit{C}} \vdash {\mathit{qt}} . {\mathit{i}} : \mathsf{ok}
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
{\mathit{n}}_{{1}} \leq {\mathit{n}}_{{2}} \leq {\mathit{k}}
}{
{\mathit{C}} \vdash [{\mathit{n}}_{{1}} .. {\mathit{n}}_{{2}}] : {\mathit{k}}
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
{\mathit{C}} \vdash {\mathit{mut}}~{\mathit{t}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{lim}} : {2^{32}} - 1
 \qquad
{\mathit{C}} \vdash {\mathit{rt}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathit{lim}}~{\mathit{rt}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{lim}} : {2^{16}}
}{
{\mathit{C}} \vdash {\mathit{lim}}~\mathsf{i{\scriptstyle8}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{dt}} : \mathsf{ok}
 \qquad
{\mathit{dt}} \approx \mathsf{func}~{\mathit{ft}}
}{
{\mathit{C}} \vdash \mathsf{func}~{\mathit{dt}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{gt}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{global}~{\mathit{gt}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{tt}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{table}~{\mathit{tt}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{mt}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{mem}~{\mathit{mt}} : \mathsf{ok}
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
{\mathit{C}} \vdash {\mathit{C}}.\mathsf{type}[{\mathit{typeidx}}] \leq {\mathit{heaptype}}
}{
{\mathit{C}} \vdash {\mathit{typeidx}} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}typeidx{-}l}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{heaptype}} \leq {\mathit{C}}.\mathsf{type}[{\mathit{typeidx}}]
}{
{\mathit{C}} \vdash {\mathit{heaptype}} \leq {\mathit{typeidx}}
} \, {[\textsc{\scriptsize S{-}heap{-}typeidx{-}r}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{rec}[{\mathit{i}}] = \mathsf{sub}~{\mathit{fin}}~({{\mathit{ht}}_{{1}}^\ast}~{\mathit{ht}}~{{\mathit{ht}}_{{2}}^\ast})~{\mathit{ct}}
}{
{\mathit{C}} \vdash \mathsf{rec}~{\mathit{i}} \leq {\mathit{ht}}
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
(({\mathit{C}}.\mathsf{local}[{\mathit{x}}] = \mathsf{set}~{\mathit{t}}))^\ast
}{
{\mathit{C}} \vdash {{\mathit{t}}_{{11}}^\ast} \rightarrow ({{\mathit{x}}_{{1}}^\ast})~{{\mathit{t}}_{{12}}^\ast} \leq {{\mathit{t}}_{{21}}^\ast} \rightarrow ({{\mathit{x}}_{{2}}^\ast})~{{\mathit{t}}_{{22}}^\ast}
} \, {[\textsc{\scriptsize S{-}instr}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{packedtype}} \leq {\mathit{packedtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{storagetype}} \leq {\mathit{storagetype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{fieldtype}} \leq {\mathit{fieldtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{functype}} \leq {\mathit{functype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{packedtype}} \leq {\mathit{packedtype}}
} \, {[\textsc{\scriptsize S{-}packed}]}
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
{\mathit{C}} \vdash {\mathit{packedtype}}_{{1}} \leq {\mathit{packedtype}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{packedtype}}_{{1}} \leq {\mathit{packedtype}}_{{2}}
} \, {[\textsc{\scriptsize S{-}storage{-}packed}]}
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
{\mathit{C}} \vdash \mathsf{struct}~{{\mathit{yt}}_{{1}}^\ast}~{\mathit{yt}'}_{{1}} \leq \mathsf{struct}~{{\mathit{yt}}_{{2}}^\ast}
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
{\mathrm{unroll}}({\mathit{deftype}}_{{1}}) = \mathsf{sub}~{\mathit{fin}}~({{\mathit{ht}}_{{1}}^\ast}~{\mathit{ht}}~{{\mathit{ht}}_{{2}}^\ast})~{\mathit{ct}}
 \qquad
{\mathit{C}} \vdash {\mathit{ht}} \leq {\mathit{deftype}}_{{2}}
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
{\mathit{C}} \vdash [{\mathit{n}}_{{11}} .. {\mathit{n}}_{{12}}] \leq [{\mathit{n}}_{{21}} .. {\mathit{n}}_{{22}}]
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

$\boxed{{\mathit{context}} \vdash {\mathit{instr}} : {\mathit{functype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{instr}} : {\mathit{instrtype}}}$

$\boxed{{\mathit{context}} \vdash {{\mathit{instr}}^\ast} : {\mathit{instrtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{expr}} : {\mathit{resulttype}}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : \epsilon \rightarrow (\epsilon)~{{\mathit{t}}^\ast}
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
{\mathit{C}} \vdash {\mathit{instr}} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
}{
{\mathit{C}} \vdash {\mathit{instr}} : {{\mathit{t}}_{{1}}^\ast} \rightarrow (\epsilon)~{{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}instr}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \epsilon : \epsilon \rightarrow (\epsilon)~\epsilon
} \, {[\textsc{\scriptsize T{-}instr*{-}empty}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
(({\mathit{C}}.\mathsf{local}[{\mathit{x}}_{{1}}] = {\mathit{init}}~{\mathit{t}}))^\ast
 \qquad
{\mathit{C}'} = {\mathit{C}}[\mathsf{local}[{{\mathit{x}}_{{1}}^\ast}] = {(\mathsf{set}~{\mathit{t}})^\ast}]
 \qquad
{\mathit{C}} \vdash {\mathit{instr}}_{{1}} : {{\mathit{t}}_{{1}}^\ast} \rightarrow ({{\mathit{x}}_{{1}}^\ast})~{{\mathit{t}}_{{2}}^\ast}
 \qquad
{\mathit{C}'} \vdash {{\mathit{instr}}_{{2}}^\ast} : {{\mathit{t}}_{{2}}^\ast} \rightarrow ({{\mathit{x}}_{{2}}^\ast})~{{\mathit{t}}_{{3}}^\ast}
}{
{\mathit{C}} \vdash {\mathit{instr}}_{{1}}~{{\mathit{instr}}_{{2}}^\ast} : {{\mathit{t}}_{{1}}^\ast} \rightarrow ({{\mathit{x}}_{{1}}^\ast}~{{\mathit{x}}_{{2}}^\ast})~{{\mathit{t}}_{{3}}^\ast}
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
}{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : {\mathit{it}'}
} \, {[\textsc{\scriptsize T{-}instr*{-}sub}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : {{\mathit{t}}_{{1}}^\ast} \rightarrow ({{\mathit{x}}^\ast})~{{\mathit{t}}_{{2}}^\ast}
}{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : {{\mathit{t}}^\ast}~{{\mathit{t}}_{{1}}^\ast} \rightarrow ({{\mathit{x}}^\ast})~({{\mathit{t}}^\ast}~{{\mathit{t}}_{{2}}^\ast})
} \, {[\textsc{\scriptsize T{-}instr*{-}frame}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{unreachable} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}unreachable}]}
\qquad
\end{array}
$$

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
}{
{\mathit{C}} \vdash \mathsf{select}~{\mathit{t}} : {\mathit{t}}~{\mathit{t}}~\mathsf{i{\scriptstyle32}} \rightarrow {\mathit{t}}
} \, {[\textsc{\scriptsize T{-}select{-}expl}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
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

$\boxed{{\mathit{context}} \vdash {\mathit{blocktype}} : {\mathit{functype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \epsilon : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize K{-}block{-}void}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{t}} : \epsilon \rightarrow {\mathit{t}}
} \, {[\textsc{\scriptsize K{-}block{-}result}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{func}~{\mathit{ft}}
}{
{\mathit{C}} \vdash {\mathit{x}} : {\mathit{ft}}
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
{\mathit{C}}, \mathsf{label}~({{\mathit{t}}_{{2}}^\ast}) \vdash {{\mathit{instr}}^\ast} : {{\mathit{t}}_{{1}}^\ast} \rightarrow ({{\mathit{x}}^\ast})~{{\mathit{t}}_{{2}}^\ast}
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
{\mathit{C}}, \mathsf{label}~({{\mathit{t}}_{{1}}^\ast}) \vdash {{\mathit{instr}}^\ast} : {{\mathit{t}}_{{1}}^\ast} \rightarrow ({{\mathit{x}}^\ast})~{{\mathit{t}}_{{2}}^\ast}
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
{\mathit{C}}, \mathsf{label}~({{\mathit{t}}_{{2}}^\ast}) \vdash {{\mathit{instr}}_{{1}}^\ast} : {{\mathit{t}}_{{1}}^\ast} \rightarrow ({{\mathit{x}}_{{1}}^\ast})~{{\mathit{t}}_{{2}}^\ast}
 \qquad
{\mathit{C}}, \mathsf{label}~({{\mathit{t}}_{{2}}^\ast}) \vdash {{\mathit{instr}}_{{2}}^\ast} : {{\mathit{t}}_{{1}}^\ast} \rightarrow ({{\mathit{x}}_{{2}}^\ast})~{{\mathit{t}}_{{2}}^\ast}
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
{\mathit{C}}.\mathsf{label}[{\mathit{l}}] = {{\mathit{t}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{br}~{\mathit{l}} : {{\mathit{t}}_{{1}}^\ast}~{{\mathit{t}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}br}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{label}[{\mathit{l}}] = {{\mathit{t}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{br\_if}~{\mathit{l}} : {{\mathit{t}}^\ast}~\mathsf{i{\scriptstyle32}} \rightarrow {{\mathit{t}}^\ast}
} \, {[\textsc{\scriptsize T{-}br\_if}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{C}} \vdash {{\mathit{t}}^\ast} \leq {\mathit{C}}.\mathsf{label}[{\mathit{l}}])^\ast
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}^\ast} \leq {\mathit{C}}.\mathsf{label}[{\mathit{l}'}]
}{
{\mathit{C}} \vdash \mathsf{br\_table}~{{\mathit{l}}^\ast}~{\mathit{l}'} : {{\mathit{t}}_{{1}}^\ast}~{{\mathit{t}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}br\_table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{label}[{\mathit{l}}] = {{\mathit{t}}^\ast}
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
{\mathit{C}}.\mathsf{label}[{\mathit{l}}] = {{\mathit{t}}^\ast}~(\mathsf{ref}~{\mathit{ht}})
 \qquad
{\mathit{C}} \vdash {\mathit{ht}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{br\_on\_non\_null}~{\mathit{l}} : {{\mathit{t}}^\ast}~(\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \rightarrow {{\mathit{t}}^\ast}
} \, {[\textsc{\scriptsize T{-}br\_on\_non\_null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{label}[{\mathit{l}}] = {{\mathit{t}}^\ast}~{\mathit{rt}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{1}} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} \leq {\mathit{rt}}_{{1}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} \leq {\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{br\_on\_cast}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}} : {{\mathit{t}}^\ast}~{\mathit{rt}}_{{1}} \rightarrow {{\mathit{t}}^\ast}~({\mathit{rt}}_{{1}} - {\mathit{rt}}_{{2}})
} \, {[\textsc{\scriptsize T{-}br\_on\_cast}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{label}[{\mathit{l}}] = {{\mathit{t}}^\ast}~{\mathit{rt}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{1}} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} \leq {\mathit{rt}}_{{1}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{1}} - {\mathit{rt}}_{{2}} \leq {\mathit{rt}}
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
{\mathit{C}}.\mathsf{return} = ({{\mathit{t}}^\ast})
}{
{\mathit{C}} \vdash \mathsf{return} : {{\mathit{t}}_{{1}}^\ast}~{{\mathit{t}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}return}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{func}[{\mathit{x}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
}{
{\mathit{C}} \vdash \mathsf{call}~{\mathit{x}} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}call}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
}{
{\mathit{C}} \vdash \mathsf{call\_ref}~{\mathit{x}} : {{\mathit{t}}_{{1}}^\ast}~(\mathsf{ref}~\mathsf{null}~{\mathit{x}}) \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}call\_ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}} \leq (\mathsf{ref}~\mathsf{null}~\mathsf{func})
 \qquad
{\mathit{C}}.\mathsf{type}[{\mathit{y}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
}{
{\mathit{C}} \vdash \mathsf{call\_indirect}~{\mathit{x}}~{\mathit{y}} : {{\mathit{t}}_{{1}}^\ast}~\mathsf{i{\scriptstyle32}} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}call\_indirect}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{func}[{\mathit{x}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
 \qquad
{\mathit{C}}.\mathsf{return} = ({{\mathit{t}'}_{{2}}^\ast})
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{2}}^\ast} \leq {{\mathit{t}'}_{{2}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{return\_call}~{\mathit{x}} : {{\mathit{t}}_{{3}}^\ast}~{{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{4}}^\ast}
} \, {[\textsc{\scriptsize T{-}return\_call}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
 \qquad
{\mathit{C}}.\mathsf{return} = ({{\mathit{t}'}_{{2}}^\ast})
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{2}}^\ast} \leq {{\mathit{t}'}_{{2}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{return\_call\_ref}~{\mathit{x}} : {{\mathit{t}}_{{3}}^\ast}~{{\mathit{t}}_{{1}}^\ast}~(\mathsf{ref}~\mathsf{null}~{\mathit{x}}) \rightarrow {{\mathit{t}}_{{4}}^\ast}
} \, {[\textsc{\scriptsize T{-}return\_call\_ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}} \leq (\mathsf{ref}~\mathsf{null}~\mathsf{func})
 \qquad
{\mathit{C}}.\mathsf{type}[{\mathit{y}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
 \qquad
{\mathit{C}}.\mathsf{return} = ({{\mathit{t}'}_{{2}}^\ast})
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{2}}^\ast} \leq {{\mathit{t}'}_{{2}}^\ast}
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
{\mathit{C}} \vdash {\mathit{nt}} . {\mathit{unop}} : {\mathit{nt}} \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}unop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{nt}} . {\mathit{binop}} : {\mathit{nt}}~{\mathit{nt}} \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}binop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{nt}} . {\mathit{testop}} : {\mathit{nt}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}testop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{nt}} . {\mathit{relop}} : {\mathit{nt}}~{\mathit{nt}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}relop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{n}} \leq {|{\mathit{nt}}|}
}{
{\mathit{C}} \vdash {{\mathit{nt}}.\mathsf{extend}}{{\mathit{n}}} : {\mathit{nt}} \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}extend}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{nt}}_{{1}} \neq {\mathit{nt}}_{{2}}
 \qquad
{|{\mathit{nt}}_{{1}}|} = {|{\mathit{nt}}_{{2}}|}
}{
{\mathit{C}} \vdash \mathsf{cvtop}~{\mathit{nt}}_{{1}}~\mathsf{reinterpret}~{\mathit{nt}}_{{2}} : {\mathit{nt}}_{{2}} \rightarrow {\mathit{nt}}_{{1}}
} \, {[\textsc{\scriptsize T{-}reinterpret}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{{\mathsf{i}}{{\mathit{n}}}}_{{1}} \neq {{\mathsf{i}}{{\mathit{n}}}}_{{2}}
 \qquad
{{\mathit{sx}}^?} = \epsilon \Leftrightarrow {|{{\mathsf{i}}{{\mathit{n}}}}_{{1}}|} > {|{{\mathsf{i}}{{\mathit{n}}}}_{{2}}|}
}{
{\mathit{C}} \vdash {{\mathsf{i}}{{\mathit{n}}}}_{{1}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{{{\mathsf{i}}{{\mathit{n}}}}_{{2}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}} : {{\mathsf{i}}{{\mathit{n}}}}_{{2}} \rightarrow {{\mathsf{i}}{{\mathit{n}}}}_{{1}}
} \, {[\textsc{\scriptsize T{-}convert{-}i}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{{\mathsf{f}}{{\mathit{n}}}}_{{1}} \neq {{\mathsf{f}}{{\mathit{n}}}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{cvtop}~{{\mathsf{f}}{{\mathit{n}}}}_{{1}}~\mathsf{convert}~{{\mathsf{f}}{{\mathit{n}}}}_{{2}} : {{\mathsf{f}}{{\mathit{n}}}}_{{2}} \rightarrow {{\mathsf{f}}{{\mathit{n}}}}_{{1}}
} \, {[\textsc{\scriptsize T{-}convert{-}f}]}
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
{\mathit{C}}.\mathsf{func}[{\mathit{x}}] = {\mathit{dt}}
}{
{\mathit{C}} \vdash \mathsf{ref.func}~{\mathit{x}} : {\mathit{epsilon}} \rightarrow (\mathsf{ref}~{\mathit{dt}})
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
}{
{\mathit{C}} \vdash \mathsf{ref.is\_null} : {\mathit{rt}} \rightarrow \mathsf{i{\scriptstyle32}}
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
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{struct}~{({\mathit{mut}}~{\mathit{zt}})^\ast}
}{
{\mathit{C}} \vdash \mathsf{struct.new}~{\mathit{x}} : {{\mathrm{unpack}}({\mathit{zt}})^\ast} \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}struct.new}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{struct}~{({\mathit{mut}}~{\mathit{zt}})^\ast}
 \qquad
(({\mathrm{default}}~{\mathrm{unpack}}({\mathit{zt}}) = {\mathit{val}}))^\ast
}{
{\mathit{C}} \vdash \mathsf{struct.new\_default}~{\mathit{x}} : {{\mathrm{unpack}}({\mathit{zt}})^\ast} \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}struct.new\_default}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{struct}~{{\mathit{yt}}^\ast}
 \qquad
{{\mathit{yt}}^\ast}[{\mathit{i}}] = {\mathit{mut}}~{\mathit{zt}}
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
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{struct}~{{\mathit{yt}}^\ast}
 \qquad
{{\mathit{yt}}^\ast}[{\mathit{i}}] = \mathsf{mut}~{\mathit{zt}}
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
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})
}{
{\mathit{C}} \vdash \mathsf{array.new}~{\mathit{x}} : {\mathrm{unpack}}({\mathit{zt}})~\mathsf{i{\scriptstyle32}} \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}array.new}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})
 \qquad
{\mathrm{default}}~{\mathrm{unpack}}({\mathit{zt}}) = {\mathit{val}}
}{
{\mathit{C}} \vdash \mathsf{array.new\_default}~{\mathit{x}} : \mathsf{i{\scriptstyle32}} \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}array.new\_default}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})
}{
{\mathit{C}} \vdash \mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}} : {\mathrm{unpack}}({\mathit{zt}}) \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}array.new\_fixed}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{rt}})
 \qquad
{\mathit{C}} \vdash {\mathit{C}}.\mathsf{elem}[{\mathit{y}}] \leq {\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{array.new\_elem}~{\mathit{x}}~{\mathit{y}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}array.new\_elem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{t}})
 \qquad
{\mathit{t}} = {\mathit{numtype}} \lor {\mathit{t}} = {\mathit{vectype}}
 \qquad
{\mathit{C}}.\mathsf{data}[{\mathit{y}}] = \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{array.new\_data}~{\mathit{x}}~{\mathit{y}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}array.new\_data}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})
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
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
}{
{\mathit{C}} \vdash \mathsf{array.set}~{\mathit{x}} : (\mathsf{ref}~\mathsf{null}~{\mathit{x}})~\mathsf{i{\scriptstyle32}}~{\mathrm{unpack}}({\mathit{zt}}) \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}array.set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
}{
{\mathit{C}} \vdash \mathsf{array.len} : (\mathsf{ref}~\mathsf{null}~\mathsf{array}) \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}array.len}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
}{
{\mathit{C}} \vdash \mathsf{array.fill}~{\mathit{x}} : (\mathsf{ref}~\mathsf{null}~{\mathit{x}})~\mathsf{i{\scriptstyle32}}~{\mathrm{unpack}}({\mathit{zt}})~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}array.fill}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}_{{1}}] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}}_{{1}})
 \qquad
{\mathit{C}}.\mathsf{type}[{\mathit{x}}_{{2}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}_{{2}})
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
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
 \qquad
{\mathit{C}} \vdash {\mathit{C}}.\mathsf{elem}[{\mathit{y}}] \leq {\mathit{zt}}
}{
{\mathit{C}} \vdash \mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}} : (\mathsf{ref}~\mathsf{null}~{\mathit{x}})~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}array.init\_elem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
 \qquad
{\mathit{t}} = {\mathit{numtype}} \lor {\mathit{t}} = {\mathit{vectype}}
 \qquad
{\mathit{C}}.\mathsf{data}[{\mathit{y}}] = \mathsf{ok}
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
{\mathit{C}} \vdash \mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{c}}_{{\mathit{vt}}} : \epsilon \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vvconst}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{vt}} . {\mathit{vvunop}} : \mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vvunop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{vt}} . {\mathit{vvbinop}} : \mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vvbinop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{vt}} . {\mathit{vvternop}} : \mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vvternop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{vt}} . {\mathit{vvtestop}} : \mathsf{v{\scriptstyle128}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}vvtestop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}}.\mathsf{vswizzle} : \mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vswizzle}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{laneidx}} < {\mathrm{dim}}({\mathit{sh}}) \cdot 2)^\ast
}{
{\mathit{C}} \vdash {\mathit{sh}}.\mathsf{vshuffle}~{{\mathit{laneidx}}^\ast} : \mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vshuffle}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}}.\mathsf{vsplat} : {\mathrm{unpacked}}({\mathit{sh}}) \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vsplat}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{laneidx}} < {\mathrm{dim}}({\mathit{sh}})
}{
{\mathit{C}} \vdash {{{{{\mathit{sh}}.\mathsf{vextract}}{\mathsf{\_}}}{\mathsf{lane}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{laneidx}} : \mathsf{v{\scriptstyle128}} \rightarrow {\mathrm{unpacked}}({\mathit{sh}})
} \, {[\textsc{\scriptsize T{-}vextract\_lane}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{laneidx}} < {\mathrm{dim}}({\mathit{sh}})
}{
{\mathit{C}} \vdash {{{\mathit{sh}}.\mathsf{vreplace}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{laneidx}} : \mathsf{v{\scriptstyle128}}~{\mathrm{unpacked}}({\mathit{sh}}) \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vreplace\_lane}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}} . {\mathit{vunop}} : \mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vunop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}} . {\mathit{vbinop}} : \mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vbinop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}} . {\mathit{vrelop}} : \mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vrelop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}} . {\mathit{vishiftop}} : \mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vishiftop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}}.\mathsf{vall\_true} : \mathsf{v{\scriptstyle128}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}vtestop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}} . {{{{{{{{{\mathit{vcvtop}}}{\mathsf{\_}}}{{{\mathit{hf}}^?}}}{\mathsf{\_}}}{{\mathit{sh}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}}{\mathsf{\_}}}{{\mathit{zero}}} : \mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vcvtop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {{{{{\mathit{sh}}.\mathsf{vnarrow}}{\mathsf{\_}}}{{\mathit{sh}}}}{\mathsf{\_}}}{{\mathit{sx}}} : \mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vnarrow}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{sh}}.\mathsf{vbitmask} : \mathsf{v{\scriptstyle128}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}vbitmask}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {{{{{\mathit{sh}}.\mathsf{vdot}}{\mathsf{\_}}}{{\mathit{sh}}}}{\mathsf{\_}}}{{\mathit{sx}}} : \mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vdot}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {{{{{{{\mathit{sh}}.\mathsf{vextmul}}{\mathsf{\_}}}{{\mathit{half}}}}{\mathsf{\_}}}{{\mathit{sh}}}}{\mathsf{\_}}}{{\mathit{sx}}} : \mathsf{v{\scriptstyle128}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vextmul}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {{{{{\mathit{sh}}.\mathsf{vextadd\_pairwise}}{\mathsf{\_}}}{{\mathit{sh}}}}{\mathsf{\_}}}{{\mathit{sx}}} : \mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vextadd\_pairwise}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{local}[{\mathit{x}}] = {\mathit{init}}~{\mathit{t}}
}{
{\mathit{C}} \vdash \mathsf{local.get}~{\mathit{x}} : \epsilon \rightarrow {\mathit{t}}
} \, {[\textsc{\scriptsize T{-}local.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{local}[{\mathit{x}}] = {\mathit{init}}~{\mathit{t}}
}{
{\mathit{C}} \vdash \mathsf{local.set}~{\mathit{x}} : {\mathit{t}} \rightarrow ({\mathit{x}})~\epsilon
} \, {[\textsc{\scriptsize T{-}local.set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{local}[{\mathit{x}}] = {\mathit{init}}~{\mathit{t}}
}{
{\mathit{C}} \vdash \mathsf{local.tee}~{\mathit{x}} : {\mathit{t}} \rightarrow ({\mathit{x}})~{\mathit{t}}
} \, {[\textsc{\scriptsize T{-}local.tee}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{global}[{\mathit{x}}] = {\mathit{mut}}~{\mathit{t}}
}{
{\mathit{C}} \vdash \mathsf{global.get}~{\mathit{x}} : \epsilon \rightarrow {\mathit{t}}
} \, {[\textsc{\scriptsize T{-}global.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{global}[{\mathit{x}}] = \mathsf{mut}~{\mathit{t}}
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
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{table.get}~{\mathit{x}} : \mathsf{i{\scriptstyle32}} \rightarrow {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}table.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{table.set}~{\mathit{x}} : \mathsf{i{\scriptstyle32}}~{\mathit{rt}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{tt}}
}{
{\mathit{C}} \vdash \mathsf{table.size}~{\mathit{x}} : \epsilon \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}table.size}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{table.grow}~{\mathit{x}} : {\mathit{rt}}~\mathsf{i{\scriptstyle32}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}table.grow}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{table.fill}~{\mathit{x}} : \mathsf{i{\scriptstyle32}}~{\mathit{rt}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.fill}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}_{{1}}] = {\mathit{lim}}_{{1}}~{\mathit{rt}}_{{1}}
 \qquad
{\mathit{C}}.\mathsf{table}[{\mathit{x}}_{{2}}] = {\mathit{lim}}_{{2}}~{\mathit{rt}}_{{2}}
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
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}_{{1}}
 \qquad
{\mathit{C}}.\mathsf{elem}[{\mathit{y}}] = {\mathit{rt}}_{{2}}
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
{\mathit{C}}.\mathsf{elem}[{\mathit{x}}] = {\mathit{rt}}
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
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
}{
{\mathit{C}} \vdash \mathsf{memory.size}~{\mathit{x}} : \epsilon \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}memory.size}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
}{
{\mathit{C}} \vdash \mathsf{memory.grow}~{\mathit{x}} : \mathsf{i{\scriptstyle32}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}memory.grow}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
}{
{\mathit{C}} \vdash \mathsf{memory.fill}~{\mathit{x}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}memory.fill}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}_{{1}}] = {\mathit{mt}}_{{1}}
 \qquad
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}_{{2}}] = {\mathit{mt}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}memory.copy}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{\mathit{C}}.\mathsf{data}[{\mathit{y}}] = \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{memory.init}~{\mathit{x}}~{\mathit{y}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}memory.init}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{data}[{\mathit{x}}] = \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{data.drop}~{\mathit{x}} : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}data.drop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{2^{{\mathit{n}}_{{\mathsf{a}}}}} \leq {|{\mathit{nt}}|} / 8
 \qquad
({2^{{\mathit{n}}_{{\mathsf{a}}}}} \leq {\mathit{n}} / 8 < {|{\mathit{nt}}|} / 8)^?
 \qquad
{{\mathit{n}}^?} = \epsilon \lor {\mathit{nt}} = {\mathsf{i}}{{\mathit{n}}}
}{
{\mathit{C}} \vdash {{\mathit{nt}}.\mathsf{load}}{{({\mathit{n}}~\mathsf{\_}~{\mathit{sx}})^?}}~{\mathit{x}}~\{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~{\mathit{n}}_{{\mathsf{a}}},\; \mathsf{offset}~{\mathit{n}}_{{\mathsf{o}}} \}\end{array} : \mathsf{i{\scriptstyle32}} \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}load}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{2^{{\mathit{n}}_{{\mathsf{a}}}}} \leq {|{\mathit{nt}}|} / 8
 \qquad
({2^{{\mathit{n}}_{{\mathsf{a}}}}} \leq {\mathit{n}} / 8 < {|{\mathit{nt}}|} / 8)^?
 \qquad
{{\mathit{n}}^?} = \epsilon \lor {\mathit{nt}} = {\mathsf{i}}{{\mathit{n}}}
}{
{\mathit{C}} \vdash {{\mathit{nt}}.\mathsf{store}}{{{\mathit{n}}^?}}~{\mathit{x}}~\{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~{\mathit{n}}_{{\mathsf{a}}},\; \mathsf{offset}~{\mathit{n}}_{{\mathsf{o}}} \}\end{array} : \mathsf{i{\scriptstyle32}}~{\mathit{nt}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}store}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{2^{{\mathit{n}}_{{\mathsf{a}}}}} \leq {\mathit{M}} / 8 \cdot {\mathit{N}}
}{
{\mathit{C}} \vdash {\mathsf{v{\scriptstyle128}.load}}{({{({\mathit{M}}~\mathsf{x}~{\mathit{N}})}{\mathsf{\_}}}{{\mathit{sx}}})}~{\mathit{x}}~\{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~{\mathit{n}}_{{\mathsf{a}}},\; \mathsf{offset}~{\mathit{n}}_{{\mathsf{o}}} \}\end{array} : \mathsf{i{\scriptstyle32}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vload}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{2^{{\mathit{n}}_{{\mathsf{a}}}}} \leq {\mathit{n}} / 8
}{
{\mathit{C}} \vdash {\mathsf{v{\scriptstyle128}.load}}{({{{\mathit{n}}}{\mathsf{\_}}}{\mathsf{splat}})}~{\mathit{x}}~\{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~{\mathit{n}}_{{\mathsf{a}}},\; \mathsf{offset}~{\mathit{n}}_{{\mathsf{o}}} \}\end{array} : \mathsf{i{\scriptstyle32}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vload{-}splat}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{2^{{\mathit{n}}_{{\mathsf{a}}}}} < {\mathit{n}} / 8
}{
{\mathit{C}} \vdash {\mathsf{v{\scriptstyle128}.load}}{({{{\mathit{n}}}{\mathsf{\_}}}{\mathsf{zero}})}~{\mathit{x}}~\{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~{\mathit{n}}_{{\mathsf{a}}},\; \mathsf{offset}~{\mathit{n}}_{{\mathsf{o}}} \}\end{array} : \mathsf{i{\scriptstyle32}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vload{-}zero}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{2^{{\mathit{n}}_{{\mathsf{a}}}}} < {\mathit{n}} / 8
 \qquad
{\mathit{laneidx}} < 128 / {\mathit{n}}
}{
{\mathit{C}} \vdash {{{\mathsf{v{\scriptstyle128}.load}}{{\mathit{n}}}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~\{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~{\mathit{n}}_{{\mathsf{a}}},\; \mathsf{offset}~{\mathit{n}}_{{\mathsf{o}}} \}\end{array}~{\mathit{laneidx}} : \mathsf{i{\scriptstyle32}}~\mathsf{v{\scriptstyle128}} \rightarrow \mathsf{v{\scriptstyle128}}
} \, {[\textsc{\scriptsize T{-}vload\_lane}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{2^{{\mathit{n}}_{{\mathsf{a}}}}} \leq {|\mathsf{v{\scriptstyle128}}|} / 8
}{
{\mathit{C}} \vdash \mathsf{v{\scriptstyle128}.store}~{\mathit{x}}~\{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~{\mathit{n}}_{{\mathsf{a}}},\; \mathsf{offset}~{\mathit{n}}_{{\mathsf{o}}} \}\end{array} : \mathsf{i{\scriptstyle32}}~\mathsf{v{\scriptstyle128}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}vstore}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{2^{{\mathit{n}}_{{\mathsf{a}}}}} < {\mathit{n}} / 8
 \qquad
{\mathit{laneidx}} < 128 / {\mathit{n}}
}{
{\mathit{C}} \vdash {{{\mathsf{v{\scriptstyle128}.store}}{{\mathit{n}}}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~\{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~{\mathit{n}}_{{\mathsf{a}}},\; \mathsf{offset}~{\mathit{n}}_{{\mathsf{o}}} \}\end{array}~{\mathit{laneidx}} : \mathsf{i{\scriptstyle32}}~\mathsf{v{\scriptstyle128}} \rightarrow \epsilon
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
{\mathit{C}} \vdash ({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}const}]}
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
{\mathit{C}} \vdash (\mathsf{ref.func}~{\mathit{x}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}ref.func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{global}[{\mathit{x}}] = {\mathit{t}}
}{
{\mathit{C}} \vdash (\mathsf{global.get}~{\mathit{x}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}global.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{nt}} \in {\mathit{epsilon}} &=& \mathsf{false} &  \\
{\mathit{nt}} \in {\mathit{nt}}_{{1}}~{{\mathit{nt}'}^\ast} &=& {\mathit{nt}} = {\mathit{nt}}_{{1}} \lor {\mathit{nt}} \in {{\mathit{nt}'}^\ast} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{binop}} \in {\mathit{epsilon}} &=& \mathsf{false} &  \\
{\mathit{binop}} \in {\mathit{ibinop}}_{{1}}~{{\mathit{ibinop}'}^\ast} &=& {\mathit{binop}} = {\mathit{ibinop}}_{{1}} \lor {\mathit{binop}} \in {{\mathit{ibinop}'}^\ast} &  \\
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{nt}} \in \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle64}}
 \qquad
{\mathit{binop}} \in \mathsf{add}~\mathsf{sub}~\mathsf{mul}
}{
{\mathit{C}} \vdash ({\mathit{nt}} . {\mathit{binop}})~\mathsf{const}
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
{\mathit{x}} = {|{\mathit{C}}.\mathsf{type}|}
 \qquad
{{\mathit{dt}}^\ast} = {{\mathrm{roll}}}_{{\mathit{x}}}({\mathit{rectype}})
 \qquad
{\mathit{C}}[\mathsf{type} = ..{{\mathit{dt}}^\ast}] \vdash {\mathit{rectype}} : {\mathsf{ok}}{({\mathit{x}})}
}{
{\mathit{C}} \vdash \mathsf{type}~{\mathit{rectype}} : {{\mathit{dt}}^\ast}
} \, {[\textsc{\scriptsize T{-}type}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathrm{default}}~{\mathit{t}} \neq \epsilon
}{
{\mathit{C}} \vdash \mathsf{local}~{\mathit{t}} : \mathsf{set}~{\mathit{t}}
} \, {[\textsc{\scriptsize T{-}local{-}set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathrm{default}}~{\mathit{t}} = \epsilon
}{
{\mathit{C}} \vdash \mathsf{local}~{\mathit{t}} : \mathsf{unset}~{\mathit{t}}
} \, {[\textsc{\scriptsize T{-}local{-}unset}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
 \qquad
({\mathit{C}} \vdash {\mathit{local}} : {\mathit{lt}})^\ast
 \qquad
{\mathit{C}}, \mathsf{local}~{(\mathsf{set}~{\mathit{t}}_{{1}})^\ast}~{{\mathit{lt}}^\ast}, \mathsf{label}~({{\mathit{t}}_{{2}}^\ast}), \mathsf{return}~({{\mathit{t}}_{{2}}^\ast}) \vdash {\mathit{expr}} : {{\mathit{t}}_{{2}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{func}~{\mathit{x}}~{{\mathit{local}}^\ast}~{\mathit{expr}} : {\mathit{C}}.\mathsf{type}[{\mathit{x}}]
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
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
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
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
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
{\mathit{C}}.\mathsf{func}[{\mathit{x}}] \approx \mathsf{func}~(\epsilon \rightarrow \epsilon)
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
{\mathit{C}}.\mathsf{func}[{\mathit{x}}] = {\mathit{dt}}
}{
{\mathit{C}} \vdash \mathsf{func}~{\mathit{x}} : \mathsf{func}~{\mathit{dt}}
} \, {[\textsc{\scriptsize T{-}externidx{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{global}[{\mathit{x}}] = {\mathit{gt}}
}{
{\mathit{C}} \vdash \mathsf{global}~{\mathit{x}} : \mathsf{global}~{\mathit{gt}}
} \, {[\textsc{\scriptsize T{-}externidx{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{tt}}
}{
{\mathit{C}} \vdash \mathsf{table}~{\mathit{x}} : \mathsf{table}~{\mathit{tt}}
} \, {[\textsc{\scriptsize T{-}externidx{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
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
\mathsf{type}~{{\mathit{dt}'}^\ast} \}\end{array} \vdash {\mathit{import}} : {\mathit{ixt}})^\ast
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
({\mathit{C}} \vdash {\mathit{export}} : {\mathit{et}})^\ast
 \\
{\mathit{C}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{{\mathit{dt}'}^\ast},\; \mathsf{func}~{{\mathit{idt}}^\ast}~{{\mathit{dt}}^\ast},\; \mathsf{global}~{{\mathit{igt}}^\ast}~{{\mathit{gt}}^\ast},\; \mathsf{table}~{{\mathit{itt}}^\ast}~{{\mathit{tt}}^\ast},\; \mathsf{mem}~{{\mathit{imt}}^\ast}~{{\mathit{mt}}^\ast},\; \mathsf{elem}~{{\mathit{rt}}^\ast},\; \mathsf{data}~{\mathsf{ok}^{{\mathit{n}}}} \}\end{array}
 \\
{\mathit{C}'} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{{\mathit{dt}'}^\ast},\; \mathsf{func}~{{\mathit{idt}}^\ast}~{{\mathit{dt}}^\ast},\; \mathsf{global}~{{\mathit{igt}}^\ast} \}\end{array}
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
{\mathit{C}}[\mathsf{type} = ..{{\mathit{dt}}_{{1}}^\ast}] \vdash {{\mathit{type}}^\ast} : {{\mathit{dt}}^\ast}
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
{\mathit{C}}[\mathsf{global} = ..{\mathit{gt}}_{{1}}] \vdash {{\mathit{global}}^\ast} : {{\mathit{gt}}^\ast}
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
{\mathit{s}}.\mathsf{struct}[{\mathit{a}}].\mathsf{type} = {\mathit{dt}}
}{
{\mathit{s}} \vdash \mathsf{ref.struct}~{\mathit{a}} : (\mathsf{ref}~\epsilon~{\mathit{dt}})
} \, {[\textsc{\scriptsize Ref\_ok{-}struct}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{s}}.\mathsf{array}[{\mathit{a}}].\mathsf{type} = {\mathit{dt}}
}{
{\mathit{s}} \vdash \mathsf{ref.array}~{\mathit{a}} : (\mathsf{ref}~\epsilon~{\mathit{dt}})
} \, {[\textsc{\scriptsize Ref\_ok{-}array}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{s}}.\mathsf{func}[{\mathit{a}}].\mathsf{type} = {\mathit{dt}}
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
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}pure}]} \quad & {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow& {\mathit{z}} ; {{\mathit{instr}'}^\ast} &\quad
  \mbox{if}~{{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\
{[\textsc{\scriptsize E{-}read}]} \quad & {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow& {\mathit{z}} ; {{\mathit{instr}'}^\ast} &\quad
  \mbox{if}~{\mathit{z}} ; {{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}refl}]} \quad & {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow^\ast& {\mathit{z}} ; {{\mathit{instr}}^\ast} &  \\
{[\textsc{\scriptsize E{-}trans}]} \quad & {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow^\ast& {\mathit{z}''} ; {{{\mathit{instr}}''}^\ast} &\quad
  \mbox{if}~{\mathit{z}} ; {{\mathit{instr}}^\ast} \hookrightarrow {\mathit{z}'} ; {{{\mathit{instr}}'}^\ast} \\
 &&&&\quad {\land}~{\mathit{z}'} ; {{\mathit{instr}}'} \hookrightarrow^\ast {\mathit{z}''} ; {{{\mathit{instr}}''}^\ast} \\
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{state}} ; {\mathit{expr}} \hookrightarrow^\ast {\mathit{state}} ; {{\mathit{val}}^\ast}}$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}expr}]} \quad & {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow^\ast& {\mathit{z}'} ; {{\mathit{val}}^\ast} &\quad
  \mbox{if}~{\mathit{z}} ; {{\mathit{instr}}^\ast} \hookrightarrow^\ast {\mathit{z}'} ; {{\mathit{val}}^\ast} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}unreachable}]} \quad & \mathsf{unreachable} &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}nop}]} \quad & \mathsf{nop} &\hookrightarrow& \epsilon &  \\
{[\textsc{\scriptsize E{-}drop}]} \quad & {\mathit{val}}~\mathsf{drop} &\hookrightarrow& \epsilon &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}select{-}true}]} \quad & {\mathit{val}}_{{1}}~{\mathit{val}}_{{2}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{select}~{{{\mathit{t}}^\ast}^?}) &\hookrightarrow& {\mathit{val}}_{{1}} &\quad
  \mbox{if}~{\mathit{c}} \neq 0 \\
{[\textsc{\scriptsize E{-}select{-}false}]} \quad & {\mathit{val}}_{{1}}~{\mathit{val}}_{{2}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{select}~{{{\mathit{t}}^\ast}^?}) &\hookrightarrow& {\mathit{val}}_{{2}} &\quad
  \mbox{if}~{\mathit{c}} = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{blocktype}}}_{{\mathit{z}}}(\epsilon) &=& \epsilon \rightarrow \epsilon &  \\
{{\mathrm{blocktype}}}_{{\mathit{z}}}({\mathit{t}}) &=& \epsilon \rightarrow {\mathit{t}} &  \\
{{\mathrm{blocktype}}}_{{\mathit{z}}}({\mathit{x}}) &=& {\mathit{ft}} &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}] \approx \mathsf{func}~{\mathit{ft}} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}block}]} \quad & {\mathit{z}} ; {{\mathit{val}}^{{\mathit{k}}}}~(\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{{\mathit{n}}}}{\{\epsilon\}}~({{\mathit{val}}^{{\mathit{k}}}}, {{\mathit{instr}}^\ast})) &\quad
  \mbox{if}~{{\mathrm{blocktype}}}_{{\mathit{z}}}({\mathit{bt}}) = {{\mathit{t}}_{{1}}^{{\mathit{k}}}} \rightarrow {{\mathit{t}}_{{2}}^{{\mathit{n}}}} \\
{[\textsc{\scriptsize E{-}loop}]} \quad & {\mathit{z}} ; {{\mathit{val}}^{{\mathit{k}}}}~(\mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{{\mathit{k}}}}{\{\mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast}\}}~({{\mathit{val}}^{{\mathit{k}}}}, {{\mathit{instr}}^\ast})) &\quad
  \mbox{if}~{{\mathrm{blocktype}}}_{{\mathit{z}}}({\mathit{bt}}) = {{\mathit{t}}_{{1}}^{{\mathit{k}}}} \rightarrow {{\mathit{t}}_{{2}}^{{\mathit{n}}}} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}if{-}true}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_{{1}}^\ast}~\mathsf{else}~{{\mathit{instr}}_{{2}}^\ast}) &\hookrightarrow& (\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}_{{1}}^\ast}) &\quad
  \mbox{if}~{\mathit{c}} \neq 0 \\
{[\textsc{\scriptsize E{-}if{-}false}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_{{1}}^\ast}~\mathsf{else}~{{\mathit{instr}}_{{2}}^\ast}) &\hookrightarrow& (\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}_{{2}}^\ast}) &\quad
  \mbox{if}~{\mathit{c}} = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}label{-}vals}]} \quad & ({{\mathsf{label}}_{{\mathit{n}}}}{\{{{\mathit{instr}}^\ast}\}}~{{\mathit{val}}^\ast}) &\hookrightarrow& {{\mathit{val}}^\ast} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br{-}zero}]} \quad & ({{\mathsf{label}}_{{\mathit{n}}}}{\{{{\mathit{instr}'}^\ast}\}}~({{\mathit{val}'}^\ast}, {{\mathit{val}}^{{\mathit{n}}}}, (\mathsf{br}~0), {{\mathit{instr}}^\ast})) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}}~{{\mathit{instr}'}^\ast} &  \\
{[\textsc{\scriptsize E{-}br{-}succ}]} \quad & ({{\mathsf{label}}_{{\mathit{n}}}}{\{{{\mathit{instr}'}^\ast}\}}~({{\mathit{val}}^\ast}, (\mathsf{br}~{\mathit{l}} + 1), {{\mathit{instr}}^\ast})) &\hookrightarrow& {{\mathit{val}}^\ast}~(\mathsf{br}~{\mathit{l}}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_if{-}true}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{br\_if}~{\mathit{l}}) &\hookrightarrow& (\mathsf{br}~{\mathit{l}}) &\quad
  \mbox{if}~{\mathit{c}} \neq 0 \\
{[\textsc{\scriptsize E{-}br\_if{-}false}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{br\_if}~{\mathit{l}}) &\hookrightarrow& \epsilon &\quad
  \mbox{if}~{\mathit{c}} = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_table{-}lt}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{br\_table}~{{\mathit{l}}^\ast}~{\mathit{l}'}) &\hookrightarrow& (\mathsf{br}~{{\mathit{l}}^\ast}[{\mathit{i}}]) &\quad
  \mbox{if}~{\mathit{i}} < {|{{\mathit{l}}^\ast}|} \\
{[\textsc{\scriptsize E{-}br\_table{-}ge}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{br\_table}~{{\mathit{l}}^\ast}~{\mathit{l}'}) &\hookrightarrow& (\mathsf{br}~{\mathit{l}'}) &\quad
  \mbox{if}~{\mathit{i}} \geq {|{{\mathit{l}}^\ast}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_null{-}null}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_null}~{\mathit{l}}) &\hookrightarrow& (\mathsf{br}~{\mathit{l}}) &\quad
  \mbox{if}~{\mathit{val}} = \mathsf{ref.null}~{\mathit{ht}} \\
{[\textsc{\scriptsize E{-}br\_on\_null{-}addr}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_null}~{\mathit{l}}) &\hookrightarrow& {\mathit{val}} &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_non\_null{-}null}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_non\_null}~{\mathit{l}}) &\hookrightarrow& \epsilon &\quad
  \mbox{if}~{\mathit{val}} = \mathsf{ref.null}~{\mathit{ht}} \\
{[\textsc{\scriptsize E{-}br\_on\_non\_null{-}addr}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_non\_null}~{\mathit{l}}) &\hookrightarrow& {\mathit{val}}~(\mathsf{br}~{\mathit{l}}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_cast{-}succeed}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{br\_on\_cast}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}}) &\hookrightarrow& {\mathit{ref}}~(\mathsf{br}~{\mathit{l}}) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{store} \vdash {\mathit{ref}} : {\mathit{rt}} \\
 &&&&\quad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}} \leq {{\mathrm{inst}}}_{{\mathit{z}}.\mathsf{module}}({\mathit{rt}}_{{2}}) \\
{[\textsc{\scriptsize E{-}br\_on\_cast{-}fail}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{br\_on\_cast}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}}) &\hookrightarrow& {\mathit{ref}} &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_cast\_fail{-}succeed}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{br\_on\_cast\_fail}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}}) &\hookrightarrow& {\mathit{ref}} &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{store} \vdash {\mathit{ref}} : {\mathit{rt}} \\
 &&&&\quad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}} \leq {{\mathrm{inst}}}_{{\mathit{z}}.\mathsf{module}}({\mathit{rt}}_{{2}}) \\
{[\textsc{\scriptsize E{-}br\_on\_cast\_fail{-}fail}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{br\_on\_cast\_fail}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}}) &\hookrightarrow& {\mathit{ref}}~(\mathsf{br}~{\mathit{l}}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}call}]} \quad & {\mathit{z}} ; (\mathsf{call}~{\mathit{x}}) &\hookrightarrow& (\mathsf{ref.func}~{\mathit{z}}.\mathsf{module}.\mathsf{func}[{\mathit{x}}])~(\mathsf{call\_ref}) &  \\
{[\textsc{\scriptsize E{-}call\_ref{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{call\_ref}~{{\mathit{x}}^?}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}call\_ref{-}func}]} \quad & {\mathit{z}} ; {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{ref.func}~{\mathit{a}})~(\mathsf{call\_ref}~{{\mathit{x}}^?}) &\hookrightarrow& ({{\mathsf{frame}}_{{\mathit{m}}}}{\{{\mathit{f}}\}}~({{\mathsf{label}}_{{\mathit{m}}}}{\{\epsilon\}}~{{\mathit{instr}}^\ast})) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{func}[{\mathit{a}}] = {\mathit{fi}} \\
 &&&&\quad {\land}~{\mathit{fi}}.\mathsf{type} \approx \mathsf{func}~({{\mathit{t}}_{{1}}^{{\mathit{n}}}} \rightarrow {{\mathit{t}}_{{2}}^{{\mathit{m}}}}) \\
 &&&&\quad {\land}~{\mathit{fi}}.\mathsf{code} = \mathsf{func}~{\mathit{y}}~{(\mathsf{local}~{\mathit{t}})^\ast}~({{\mathit{instr}}^\ast}) \\
 &&&&\quad {\land}~{\mathit{f}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{local}~{{\mathit{val}}^{{\mathit{n}}}}~{({\mathrm{default}}~{\mathit{t}})^\ast},\; \mathsf{module}~{\mathit{fi}}.\mathsf{module} \}\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}return\_call}]} \quad & {\mathit{z}} ; (\mathsf{return\_call}~{\mathit{x}}) &\hookrightarrow& (\mathsf{ref.func}~{\mathit{z}}.\mathsf{module}.\mathsf{func}[{\mathit{x}}])~(\mathsf{return\_call\_ref}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}return\_call\_ref{-}frame{-}null}]} \quad & {\mathit{z}} ; ({{\mathsf{frame}}_{{\mathit{k}}}}{\{{\mathit{f}}\}}~({{\mathit{val}}^\ast}, (\mathsf{ref.null}~{\mathit{ht}}), (\mathsf{return\_call\_ref}~{{\mathit{x}}^?}), {{\mathit{instr}}^\ast})) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}return\_call\_ref{-}frame{-}addr}]} \quad & {\mathit{z}} ; ({{\mathsf{frame}}_{{\mathit{k}}}}{\{{\mathit{f}}\}}~({{\mathit{val}'}^\ast}, {{\mathit{val}}^{{\mathit{n}}}}, (\mathsf{ref.func}~{\mathit{a}}), (\mathsf{return\_call\_ref}~{{\mathit{x}}^?}), {{\mathit{instr}}^\ast})) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{ref.func}~{\mathit{a}})~(\mathsf{call\_ref}~{{\mathit{x}}^?}) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{func}[{\mathit{a}}].\mathsf{type} \approx \mathsf{func}~({{\mathit{t}}_{{1}}^{{\mathit{n}}}} \rightarrow {{\mathit{t}}_{{2}}^{{\mathit{m}}}}) \\
{[\textsc{\scriptsize E{-}return\_call\_ref{-}label}]} \quad & {\mathit{z}} ; ({{\mathsf{label}}_{{\mathit{k}}}}{\{{{\mathit{instr}'}^\ast}\}}~({{\mathit{val}}^\ast}, (\mathsf{return\_call\_ref}~{{\mathit{x}}^?}), {{\mathit{instr}}^\ast})) &\hookrightarrow& {{\mathit{val}}^\ast}~(\mathsf{return\_call\_ref}~{{\mathit{x}}^?}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}call\_indirect{-}call}]} \quad & (\mathsf{call\_indirect}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& (\mathsf{table.get}~{\mathit{x}})~(\mathsf{ref.cast}~(\mathsf{ref}~\mathsf{null}~{\mathit{y}}))~(\mathsf{call\_ref}~{\mathit{y}}) &  \\
{[\textsc{\scriptsize E{-}return\_call\_indirect}]} \quad & (\mathsf{return\_call\_indirect}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& (\mathsf{table.get}~{\mathit{x}})~(\mathsf{ref.cast}~(\mathsf{ref}~\mathsf{null}~{\mathit{y}}))~(\mathsf{return\_call\_ref}~{\mathit{y}}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}frame{-}vals}]} \quad & ({{\mathsf{frame}}_{{\mathit{n}}}}{\{{\mathit{f}}\}}~{{\mathit{val}}^{{\mathit{n}}}}) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}} &  \\
{[\textsc{\scriptsize E{-}return{-}frame}]} \quad & ({{\mathsf{frame}}_{{\mathit{n}}}}{\{{\mathit{f}}\}}~({{\mathit{val}'}^\ast}, {{\mathit{val}}^{{\mathit{n}}}}, \mathsf{return}, {{\mathit{instr}}^\ast})) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}} &  \\
{[\textsc{\scriptsize E{-}return{-}label}]} \quad & ({{\mathsf{label}}_{{\mathit{k}}}}{\{{{\mathit{instr}'}^\ast}\}}~({{\mathit{val}}^\ast}, \mathsf{return}, {{\mathit{instr}}^\ast})) &\hookrightarrow& {{\mathit{val}}^\ast}~\mathsf{return} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}unop{-}val}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}} . {\mathit{unop}}) &\hookrightarrow& ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}) &\quad
  \mbox{if}~{{{{\mathit{unop}}}{}}_{{\mathit{nt}}}}{({\mathit{c}}_{{1}})} = {\mathit{c}} \\
{[\textsc{\scriptsize E{-}unop{-}trap}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}} . {\mathit{unop}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{{{{\mathit{unop}}}{}}_{{\mathit{nt}}}}{({\mathit{c}}_{{1}})} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}binop{-}val}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{2}})~({\mathit{nt}} . {\mathit{binop}}) &\hookrightarrow& ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}) &\quad
  \mbox{if}~{{{{\mathit{binop}}}{}}_{{\mathit{nt}}}}{({\mathit{c}}_{{1}},\, {\mathit{c}}_{{2}})} = {\mathit{c}} \\
{[\textsc{\scriptsize E{-}binop{-}trap}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{2}})~({\mathit{nt}} . {\mathit{binop}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{{{{\mathit{binop}}}{}}_{{\mathit{nt}}}}{({\mathit{c}}_{{1}},\, {\mathit{c}}_{{2}})} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}testop}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}} . {\mathit{testop}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}}) &\quad
  \mbox{if}~{\mathit{c}} = {{{{\mathit{testop}}}{}}_{{\mathit{nt}}}}{({\mathit{c}}_{{1}})} \\
{[\textsc{\scriptsize E{-}relop}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{2}})~({\mathit{nt}} . {\mathit{relop}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}}) &\quad
  \mbox{if}~{\mathit{c}} = {{{{\mathit{relop}}}{}}_{{\mathit{nt}}}}{({\mathit{c}}_{{1}},\, {\mathit{c}}_{{2}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}extend}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~({{\mathit{nt}}.\mathsf{extend}}{{\mathit{n}}}) &\hookrightarrow& ({\mathit{nt}}.\mathsf{const}~{{{{\mathrm{ext}}}_{({\mathit{n}},\, {|{\mathit{nt}}|})}^{\mathsf{s}}}}{({\mathit{c}})}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}cvtop{-}val}]} \quad & ({\mathit{nt}}_{{1}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}}_{{2}} . {{{{{\mathit{cvtop}}}{\mathsf{\_}}}{{\mathit{nt}}_{{1}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}) &\hookrightarrow& ({\mathit{nt}}_{{2}}.\mathsf{const}~{\mathit{c}}) &\quad
  \mbox{if}~{{{\mathit{cvtop}}}{{{}_{({\mathit{nt}}_{{1}},\, {\mathit{nt}}_{{2}})}^{{{\mathit{sx}}^?}}}}}{({\mathit{c}}_{{1}})} = {\mathit{c}} \\
{[\textsc{\scriptsize E{-}cvtop{-}trap}]} \quad & ({\mathit{nt}}_{{1}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}}_{{2}} . {{{{{\mathit{cvtop}}}{\mathsf{\_}}}{{\mathit{nt}}_{{1}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{{{\mathit{cvtop}}}{{{}_{({\mathit{nt}}_{{1}},\, {\mathit{nt}}_{{2}})}^{{{\mathit{sx}}^?}}}}}{({\mathit{c}}_{{1}})} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.func}]} \quad & {\mathit{z}} ; (\mathsf{ref.func}~{\mathit{x}}) &\hookrightarrow& (\mathsf{ref.func}~{\mathit{z}}.\mathsf{module}.\mathsf{func}[{\mathit{x}}]) &  \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.i31}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~\mathsf{ref.i{\scriptstyle31}} &\hookrightarrow& (\mathsf{ref.i{\scriptstyle31}}~{{{\mathrm{wrap}}}_{(32,\, 31)}}{({\mathit{i}})}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.is\_null{-}true}]} \quad & {\mathit{val}}~\mathsf{ref.is\_null} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1) &\quad
  \mbox{if}~{\mathit{val}} = (\mathsf{ref.null}~{\mathit{ht}}) \\
{[\textsc{\scriptsize E{-}ref.is\_null{-}false}]} \quad & {\mathit{val}}~\mathsf{ref.is\_null} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.as\_non\_null{-}null}]} \quad & {\mathit{ref}}~\mathsf{ref.as\_non\_null} &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{ref}} = (\mathsf{ref.null}~{\mathit{ht}}) \\
{[\textsc{\scriptsize E{-}ref.as\_non\_null{-}addr}]} \quad & {\mathit{ref}}~\mathsf{ref.as\_non\_null} &\hookrightarrow& {\mathit{ref}} &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.eq{-}null}]} \quad & {\mathit{ref}}_{{1}}~{\mathit{ref}}_{{2}}~\mathsf{ref.eq} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1) &\quad
  \mbox{if}~{\mathit{ref}}_{{1}} = \mathsf{ref.null}~{\mathit{ht}}_{{1}} \land {\mathit{ref}}_{{2}} = \mathsf{ref.null}~{\mathit{ht}}_{{2}} \\
{[\textsc{\scriptsize E{-}ref.eq{-}true}]} \quad & {\mathit{ref}}_{{1}}~{\mathit{ref}}_{{2}}~\mathsf{ref.eq} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1) &\quad
  \mbox{otherwise, if}~{\mathit{ref}}_{{1}} = {\mathit{ref}}_{{2}} \\
{[\textsc{\scriptsize E{-}ref.eq{-}false}]} \quad & {\mathit{ref}}_{{1}}~{\mathit{ref}}_{{2}}~\mathsf{ref.eq} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.test{-}true}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{ref.test}~{\mathit{rt}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{store} \vdash {\mathit{ref}} : {\mathit{rt}'} \\
 &&&&\quad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}'} \leq {{\mathrm{inst}}}_{{\mathit{z}}.\mathsf{module}}({\mathit{rt}}) \\
{[\textsc{\scriptsize E{-}ref.test{-}false}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{ref.test}~{\mathit{rt}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.cast{-}succeed}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{ref.cast}~{\mathit{rt}}) &\hookrightarrow& {\mathit{ref}} &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{store} \vdash {\mathit{ref}} : {\mathit{rt}'} \\
 &&&&\quad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}'} \leq {{\mathrm{inst}}}_{{\mathit{z}}.\mathsf{module}}({\mathit{rt}}) \\
{[\textsc{\scriptsize E{-}ref.cast{-}fail}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{ref.cast}~{\mathit{rt}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}i31.get{-}null}]} \quad & (\mathsf{ref.null}~{\mathit{ht}})~({{\mathsf{i{\scriptstyle31}.get}}{\mathsf{\_}}}{{\mathit{sx}}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}i31.get{-}num}]} \quad & (\mathsf{ref.i{\scriptstyle31}}~{\mathit{i}})~({{\mathsf{i{\scriptstyle31}.get}}{\mathsf{\_}}}{{\mathit{sx}}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{{{{\mathrm{ext}}}_{(31,\, 32)}^{{\mathit{sx}}}}}{({\mathit{i}})}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.new}]} \quad & {\mathit{z}} ; {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{struct.new}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{struct} = ..{\mathit{si}}] ; (\mathsf{ref.struct}~{|{\mathit{z}}.\mathsf{struct}|}) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}] \approx \mathsf{struct}~{({\mathit{mut}}~{\mathit{zt}})^{{\mathit{n}}}} \\
 &&&&\quad {\land}~{\mathit{si}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}],\; \mathsf{field}~{({{\mathrm{pack}}}_{{\mathit{zt}}}({\mathit{val}}))^{{\mathit{n}}}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.new\_default}]} \quad & {\mathit{z}} ; (\mathsf{struct.new\_default}~{\mathit{x}}) &\hookrightarrow& {{\mathit{val}}^\ast}~(\mathsf{struct.new}~{\mathit{x}}) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}] \approx \mathsf{struct}~{({\mathit{mut}}~{\mathit{zt}})^\ast} \\
 &&&&\quad {\land}~(({\mathrm{default}}~{\mathrm{unpack}}({\mathit{zt}}) = {\mathit{val}}))^\ast \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.get{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~({{\mathsf{struct.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}~{\mathit{i}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}struct.get{-}struct}]} \quad & {\mathit{z}} ; (\mathsf{ref.struct}~{\mathit{a}})~({{\mathsf{struct.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}~{\mathit{i}}) &\hookrightarrow& {{{{\mathrm{unpack}}}_{{{\mathit{zt}}^\ast}[{\mathit{i}}]}^{{{\mathit{sx}}^?}}}}{({\mathit{si}}.\mathsf{field}[{\mathit{i}}])} &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{struct}[{\mathit{a}}] = {\mathit{si}} \\
 &&&&\quad {\land}~{\mathit{si}}.\mathsf{type} \approx \mathsf{struct}~{({\mathit{mut}}~{\mathit{zt}})^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.set{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~{\mathit{val}}~(\mathsf{struct.set}~{\mathit{x}}~{\mathit{i}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}struct.set{-}struct}]} \quad & {\mathit{z}} ; (\mathsf{ref.struct}~{\mathit{a}})~{\mathit{val}}~(\mathsf{struct.set}~{\mathit{x}}~{\mathit{i}}) &\hookrightarrow& {\mathit{z}}[\mathsf{struct}[{\mathit{a}}].\mathsf{field}[{\mathit{i}}] = {\mathit{fv}}] ; \epsilon &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{struct}[{\mathit{a}}].\mathsf{type} \approx \mathsf{struct}~{({\mathit{mut}}~{\mathit{zt}})^\ast} \\
 &&&&\quad {\land}~{\mathit{fv}} = {{\mathrm{pack}}}_{{{\mathit{zt}}^\ast}[{\mathit{i}}]}({\mathit{val}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new}]} \quad & {\mathit{z}} ; {\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.new}~{\mathit{x}}) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}}) &  \\
{[\textsc{\scriptsize E{-}array.new\_default}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.new\_default}~{\mathit{x}}) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}}) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}) \\
 &&&&\quad {\land}~{\mathrm{default}}~{\mathrm{unpack}}({\mathit{zt}}) = {\mathit{val}} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new\_fixed}]} \quad & {\mathit{z}} ; {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}}) &\hookrightarrow& {\mathit{z}}[\mathsf{array} = ..{\mathit{ai}}] ; (\mathsf{ref.array}~{|{\mathit{z}}.\mathsf{array}|}) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}) \\
 &&&&\quad {\land}~{\mathit{ai}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}],\; \mathsf{field}~{({{\mathrm{pack}}}_{{\mathit{zt}}}({\mathit{val}}))^{{\mathit{n}}}} \}\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new\_elem{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.new\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{elem}}{[{\mathit{y}}]}.\mathsf{elem}|} \\
{[\textsc{\scriptsize E{-}array.new\_elem{-}alloc}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.new\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& {{\mathit{ref}}^{{\mathit{n}}}}~(\mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}}) &\quad
  \mbox{if}~{{\mathit{ref}}^{{\mathit{n}}}} = {{\mathit{z}}.\mathsf{elem}}{[{\mathit{y}}]}.\mathsf{elem}[{\mathit{i}} : {\mathit{n}}] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new\_data{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.new\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}) \\
 &&&&\quad {\land}~{\mathit{i}} + {\mathit{n}} \cdot {|{\mathit{zt}}|} / 8 > {|{{\mathit{z}}.\mathsf{data}}{[{\mathit{y}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}array.new\_data{-}alloc}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.new\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& {({\mathit{nt}}.\mathsf{const}~{\mathit{c}})^{{\mathit{n}}}}~(\mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}}) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}) \\
 &&&&\quad {\land}~{\mathit{nt}} = {\mathrm{unpack}}({\mathit{zt}}) \\
 &&&&\quad {\land}~{\mathrm{concat}}({{{\mathrm{bytes}}}_{{\mathit{zt}}}({\mathit{c}})^{{\mathit{n}}}}) = {{\mathit{z}}.\mathsf{data}}{[{\mathit{y}}]}.\mathsf{data}[{\mathit{i}} : {\mathit{n}} \cdot {|{\mathit{zt}}|} / 8] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.get{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.get{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} \geq {|{\mathit{z}}.\mathsf{array}[{\mathit{a}}].\mathsf{field}|} \\
{[\textsc{\scriptsize E{-}array.get{-}array}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}) &\hookrightarrow& {{{{\mathrm{unpack}}}_{{\mathit{zt}}}^{{{\mathit{sx}}^?}}}}{({\mathit{fv}})} &\quad
  \mbox{if}~{\mathit{fv}} = {\mathit{z}}.\mathsf{array}[{\mathit{a}}].\mathsf{field}[{\mathit{i}}] \\
 &&&&\quad {\land}~{\mathit{z}}.\mathsf{array}[{\mathit{a}}].\mathsf{type} \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.set{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{array.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.set{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{array.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} \geq {|{\mathit{z}}.\mathsf{array}[{\mathit{a}}].\mathsf{field}|} \\
{[\textsc{\scriptsize E{-}array.set{-}array}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{array.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{struct}[{\mathit{a}}].\mathsf{field}[{\mathit{i}}] = {\mathit{fv}}] ; \epsilon &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{array}[{\mathit{a}}].\mathsf{type} \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}) \\
 &&&&\quad {\land}~{\mathit{fv}} = {{\mathrm{pack}}}_{{\mathit{zt}}}({\mathit{val}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.len{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~\mathsf{array.len} &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.len{-}array}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~\mathsf{array.len} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}}) &\quad
  \mbox{if}~{\mathit{n}} = {|{\mathit{z}}.\mathsf{array}[{\mathit{a}}].\mathsf{field}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.fill{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.fill}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.fill{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.fill}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{array}[{\mathit{a}}].\mathsf{field}|} \\
{[\textsc{\scriptsize E{-}array.fill{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.fill}~{\mathit{x}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}array.fill{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.fill}~{\mathit{x}}) &\hookrightarrow& (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{array.set}~{\mathit{x}})~(\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{array.fill}~{\mathit{x}}) &\quad
  \mbox{otherwise} \\
{[\textsc{\scriptsize E{-}array.copy{-}null1}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~{\mathit{ref}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.copy{-}null2}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.null}~{\mathit{ht}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.copy{-}oob1}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}}_{{1}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{array}[{\mathit{a}}_{{1}}].\mathsf{field}|} \\
{[\textsc{\scriptsize E{-}array.copy{-}oob2}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}}_{{2}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{array}[{\mathit{a}}_{{2}}].\mathsf{field}|} \\
{[\textsc{\scriptsize E{-}array.copy{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}array.copy{-}le}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~({{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}_{{2}})~(\mathsf{array.set}~{\mathit{x}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}} + 1)~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\quad
  \mbox{otherwise, if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}_{{2}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}_{{2}}) \\
 &&&&\quad {\land}~{{\mathit{sx}}^?} = {\mathrm{sx}}({\mathit{zt}}_{{2}}) \\
 &&&&\quad {\land}~{\mathit{i}}_{{1}} \leq {\mathit{i}}_{{2}} \\
{[\textsc{\scriptsize E{-}array.copy{-}gt}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}} + {\mathit{n}} - 1)~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}} + {\mathit{n}} - 1)~({{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}_{{2}})~(\mathsf{array.set}~{\mathit{x}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\quad
  \mbox{otherwise, if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}_{{2}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}_{{2}}) \\
 &&&&\quad {\land}~{{\mathit{sx}}^?} = {\mathrm{sx}}({\mathit{zt}}_{{2}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.init\_elem{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}oob1}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{array}[{\mathit{a}}].\mathsf{field}|} \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}oob2}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{j}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{elem}}{[{\mathit{y}}]}.\mathsf{elem}|} \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{ref}}~(\mathsf{array.set}~{\mathit{x}})~(\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\quad
  \mbox{otherwise, if}~{\mathit{ref}} = {{\mathit{z}}.\mathsf{elem}}{[{\mathit{y}}]}.\mathsf{elem}[{\mathit{j}}] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.init\_data{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.init\_data{-}oob1}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{array}[{\mathit{a}}].\mathsf{field}|} \\
{[\textsc{\scriptsize E{-}array.init\_data{-}oob2}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}) \\
 &&&&\quad {\land}~{\mathit{j}} + {\mathit{n}} \cdot {|{\mathit{zt}}|} / 8 > {|{{\mathit{z}}.\mathsf{data}}{[{\mathit{y}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}array.init\_data{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}array.init\_data{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~(\mathsf{array.set}~{\mathit{x}})~(\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + {|{\mathit{zt}}|} / 8)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\quad
  \mbox{otherwise, if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}) \\
 &&&&\quad {\land}~{\mathit{nt}} = {\mathrm{unpack}}({\mathit{zt}}) \\
 &&&&\quad {\land}~{{\mathrm{bytes}}}_{{\mathit{zt}}}({\mathit{c}}) = {{\mathit{z}}.\mathsf{data}}{[{\mathit{y}}]}.\mathsf{data}[{\mathit{j}} : {|{\mathit{zt}}|} / 8] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}extern.convert\_any{-}null}]} \quad & (\mathsf{ref.null}~{\mathit{ht}})~\mathsf{extern.convert\_any} &\hookrightarrow& (\mathsf{ref.null}~\mathsf{extern}) &  \\
{[\textsc{\scriptsize E{-}extern.convert\_any{-}addr}]} \quad & {\mathit{addrref}}~\mathsf{extern.convert\_any} &\hookrightarrow& (\mathsf{ref.extern}~{\mathit{addrref}}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}any.convert\_extern{-}null}]} \quad & (\mathsf{ref.null}~{\mathit{ht}})~\mathsf{any.convert\_extern} &\hookrightarrow& (\mathsf{ref.null}~\mathsf{any}) &  \\
{[\textsc{\scriptsize E{-}any.convert\_extern{-}addr}]} \quad & (\mathsf{ref.extern}~{\mathit{addrref}})~\mathsf{any.convert\_extern} &\hookrightarrow& {\mathit{addrref}} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vvunop}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~(\mathsf{v{\scriptstyle128}} . {\mathit{vvunop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{{{{\mathit{vvunop}}}{}}_{\mathsf{v{\scriptstyle128}}}}{({\mathit{cv}}_{{1}})} = {\mathit{cv}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vvbinop}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{2}})~(\mathsf{v{\scriptstyle128}} . {\mathit{vvbinop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{{{{\mathit{vvbinop}}}{}}_{\mathsf{v{\scriptstyle128}}}}{({\mathit{cv}}_{{1}},\, {\mathit{cv}}_{{2}})} = {\mathit{cv}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vvternop}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{2}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{3}})~(\mathsf{v{\scriptstyle128}} . {\mathit{vvternop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{{{{\mathit{vvternop}}}{}}_{\mathsf{v{\scriptstyle128}}}}{({\mathit{cv}}_{{1}},\, {\mathit{cv}}_{{2}},\, {\mathit{cv}}_{{3}})} = {\mathit{cv}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vvtestop}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~(\mathsf{v{\scriptstyle128}} . \mathsf{any\_true}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}) &\quad
  \mbox{if}~{\mathit{i}} = {\mathrm{ine}}(128, {\mathit{cv}}_{{1}}, {\mathrm{vzero}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vswizzle}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{2}})~({\mathit{sh}}.\mathsf{vswizzle}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}'}) &\quad
  \mbox{if}~{\mathit{sh}} = {\mathit{lnt}}~\mathsf{x}~{\mathit{lns}} \\
 &&&&\quad {\land}~{{\mathit{i}}^\ast} = {{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}}_{{2}}) \\
 &&&&\quad {\land}~{{\mathit{c}}^\ast} = {{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}}_{{1}})~{0^{256 - {\mathit{lns}}}} \\
 &&&&\quad {\land}~{{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}'}) = {{{\mathit{c}}^\ast}[{{\mathit{i}}^\ast}[{\mathit{k}}]]^{{\mathit{k}}<{\mathit{lns}}}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vshuffle}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{2}})~({\mathit{sh}}.\mathsf{vshuffle}~{{\mathit{laneidx}}^\ast}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{\mathit{sh}} = {\mathit{lnt}}~\mathsf{x}~{\mathit{lns}} \\
 &&&&\quad {\land}~{{\mathit{i}}^\ast} = {{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}}_{{1}})~{{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}}_{{2}}) \\
 &&&&\quad {\land}~{{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}}) = {{{\mathit{i}}^\ast}[{{\mathit{laneidx}}^\ast}[{\mathit{k}}]]^{{\mathit{k}}<{\mathit{lns}}}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vsplat}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{sh}}.\mathsf{vsplat}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{\mathit{nt}} = {\mathrm{unpacked}}({\mathit{sh}}) \\
 &&&&\quad {\land}~{{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}}) = {{\mathit{c}}_{{1}}^{{\mathrm{dim}}({\mathit{sh}})}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vextract\_lane{-}num}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~(\mathsf{vextract\_lane}~{\mathit{sh}}~{\mathit{laneidx}}) &\hookrightarrow& ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{2}}) &\quad
  \mbox{if}~{\mathit{nt}} = {\mathrm{unpacked}}({\mathit{sh}}) \\
 &&&&\quad {\land}~{\mathit{sh}} = {\mathit{lnt}}~\mathsf{x}~{\mathit{lns}} \\
 &&&&\quad {\land}~{\mathit{c}}_{{2}} = {{{{\mathrm{ext}}}_{({|{\mathit{lnt}}|},\, {|{\mathit{nt}}|})}^{\mathsf{u}}}}{({{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}}_{{1}})[{\mathit{laneidx}}])} \\
{[\textsc{\scriptsize E{-}vextract\_lane{-}pack}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~({{{{{\mathit{sh}}.\mathsf{vextract}}{\mathsf{\_}}}{\mathsf{lane}}}{\mathsf{\_}}}{{\mathit{sx}}}~{\mathit{laneidx}}) &\hookrightarrow& ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{2}}) &\quad
  \mbox{if}~{\mathit{nt}} = {\mathrm{unpacked}}({\mathit{sh}}) \\
 &&&&\quad {\land}~{\mathit{sh}} = {\mathit{lnt}}~\mathsf{x}~{\mathit{lns}} \\
 &&&&\quad {\land}~{\mathit{c}}_{{2}} = {{{{\mathrm{ext}}}_{({|{\mathit{lnt}}|},\, {|{\mathit{nt}}|})}^{{\mathit{sx}}}}}{({{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}}_{{1}})[{\mathit{laneidx}}])} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vreplace\_lane}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{2}})~({{{\mathit{sh}}.\mathsf{vreplace}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{laneidx}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{{\mathit{i}}^\ast} = {{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}}_{{1}}) \\
 &&&&\quad {\land}~{{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}}) = ({{\mathit{i}}^\ast})[[{\mathit{laneidx}}] = {\mathit{c}}_{{2}}] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vunop}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~({\mathit{sh}} . {\mathit{vunop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{\mathit{cv}} = {{{{\mathit{vunop}}}{}}_{{\mathit{sh}}}}{({\mathit{cv}}_{{1}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vbinop{-}val}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{2}})~({\mathit{sh}} . {\mathit{vbinop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{{{{\mathit{vbinop}}}{}}_{{\mathit{sh}}}}{({\mathit{cv}}_{{1}},\, {\mathit{cv}}_{{2}})} = {\mathit{cv}} \\
{[\textsc{\scriptsize E{-}vbinop{-}trap}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{2}})~({\mathit{sh}} . {\mathit{vbinop}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{{{{\mathit{vbinop}}}{}}_{{\mathit{sh}}}}{({\mathit{cv}}_{{1}},\, {\mathit{cv}}_{{2}})} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vrelop}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{2}})~({\mathit{sh}} . {\mathit{vrelop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{{\mathit{i}}^\ast} = {{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}}_{{1}}) \\
 &&&&\quad {\land}~{{\mathit{j}}^\ast} = {{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}}_{{2}}) \\
 &&&&\quad {\land}~{\mathit{sh}} = {\mathit{lnt}}~\mathsf{x}~{\mathit{lns}} \\
 &&&&\quad {\land}~{{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}}) = {{{{{\mathrm{ext}}}_{(1,\, {|{\mathit{lnt}}|})}^{\mathsf{s}}}}{({{{{\mathit{vrelop}}}{}}_{{\mathit{sh}}}}{({\mathit{i}},\, {\mathit{j}})})}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vishiftop}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~({\mathit{sh}} . {\mathit{vishiftop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{\mathit{sh}} = {\mathit{lnt}}~\mathsf{x}~{\mathit{lns}} \\
 &&&&\quad {\land}~{{\mathit{i}}^\ast} = {{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}}_{{1}}) \\
 &&&&\quad {\land}~{{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}}) = {{{{{\mathit{vishiftop}}}{}}_{{\mathit{lnt}}}}{({\mathit{i}},\, {\mathit{n}})}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vall\_true{-}true}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}})~({\mathit{sh}}.\mathsf{vall\_true}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1) &\quad
  \mbox{if}~{{\mathit{i}}_{{1}}^\ast} = {{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}}) \\
 &&&&\quad {\land}~({\mathit{i}}_{{1}} \neq 0)^\ast \\
{[\textsc{\scriptsize E{-}vall\_true{-}false}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}})~({\mathit{sh}}.\mathsf{vall\_true}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vbitmask}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}})~({\mathit{sh}}.\mathsf{vbitmask}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}) &\quad
  \mbox{if}~{\mathit{sh}} = {\mathit{lnt}}~\mathsf{x}~{\mathit{lns}} \\
 &&&&\quad {\land}~{{\mathit{i}}_{{1}}^{{\mathit{lns}}}} = {{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}}) \\
 &&&&\quad {\land}~{\mathrm{ibits}}(32, {\mathit{i}}) = {{\mathrm{ilt}}(\mathsf{s}, {|{\mathit{lnt}}|}, {\mathit{i}}_{{1}}, 0)^{{\mathit{lns}}}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vnarrow}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{2}})~({{{{{\mathit{sh}}_{{2}}.\mathsf{vnarrow}}{\mathsf{\_}}}{{\mathit{sh}}_{{1}}}}{\mathsf{\_}}}{{\mathit{sx}}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{\mathit{sh}}_{{1}} = {\mathit{lnt}}_{{1}}~\mathsf{x}~{\mathit{lns}}_{{1}} \\
 &&&&\quad {\land}~{\mathit{sh}}_{{2}} = {\mathit{lnt}}_{{2}}~\mathsf{x}~{\mathit{lns}}_{{2}} \\
 &&&&\quad {\land}~{{\mathit{i}}_{{1}}^{{\mathit{lns}}_{{1}}}} = {{\mathrm{lanes}}}_{{\mathit{sh}}_{{1}}}({\mathit{cv}}_{{1}}) \\
 &&&&\quad {\land}~{{\mathit{i}}_{{2}}^{{\mathit{lns}}_{{1}}}} = {{\mathrm{lanes}}}_{{\mathit{sh}}_{{1}}}({\mathit{cv}}_{{2}}) \\
 &&&&\quad {\land}~{{\mathit{n}}_{{1}}^{{\mathit{lns}}_{{1}}}} = {{\mathrm{narrow}}({|{\mathit{lnt}}_{{1}}|}, {|{\mathit{lnt}}_{{2}}|}, {\mathit{sx}}, {\mathit{i}}_{{1}})^{{\mathit{lns}}_{{1}}}} \\
 &&&&\quad {\land}~{{\mathit{n}}_{{2}}^{{\mathit{lns}}_{{1}}}} = {{\mathrm{narrow}}({|{\mathit{lnt}}_{{1}}|}, {|{\mathit{lnt}}_{{2}}|}, {\mathit{sx}}, {\mathit{i}}_{{2}})^{{\mathit{lns}}_{{1}}}} \\
 &&&&\quad {\land}~{{\mathrm{lanes}}}_{{\mathit{sh}}_{{2}}}({\mathit{cv}}) = {{\mathit{n}}_{{1}}^{{\mathit{lns}}_{{1}}}}~{{\mathit{n}}_{{2}}^{{\mathit{lns}}_{{1}}}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vcvtop{-}normal}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~({\mathit{sh}}_{{2}} . {{{{{{{{{\mathit{vcvtop}}}{\mathsf{\_}}}{\epsilon}}{\mathsf{\_}}}{{\mathit{sh}}_{{1}}}}{\mathsf{\_}}}{{\mathit{sx}}}}{\mathsf{\_}}}{\epsilon}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{\mathit{sh}}_{{1}} = {\mathit{lnt}}_{{1}}~\mathsf{x}~{\mathit{lns}}_{{1}} \\
 &&&&\quad {\land}~{\mathit{sh}}_{{2}} = {\mathit{lnt}}_{{2}}~\mathsf{x}~{\mathit{lns}}_{{2}} \\
 &&&&\quad {\land}~{{\mathit{i}}^\ast} = {{\mathrm{lanes}}}_{{\mathit{sh}}_{{1}}}({\mathit{cv}}_{{1}}) \\
 &&&&\quad {\land}~{{\mathrm{lanes}}}_{{\mathit{sh}}_{{2}}}({\mathit{cv}}) = {{{{\mathit{vcvtop}}}{{{}_{({|{\mathit{lnt}}_{{1}}|},\, {|{\mathit{lnt}}_{{2}}|})}^{{\mathit{sx}}}}}}{({\mathit{i}})}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vcvtop{-}half}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~({\mathit{sh}}_{{2}} . {{{{{{{{{\mathit{vcvtop}}}{\mathsf{\_}}}{{\mathit{hf}}}}{\mathsf{\_}}}{{\mathit{sh}}_{{1}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}}{\mathsf{\_}}}{\epsilon}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{\mathit{sh}}_{{1}} = {\mathit{lnt}}_{{1}}~\mathsf{x}~{\mathit{lns}}_{{1}} \\
 &&&&\quad {\land}~{\mathit{sh}}_{{2}} = {\mathit{lnt}}_{{2}}~\mathsf{x}~{\mathit{lns}}_{{2}} \\
 &&&&\quad {\land}~{{\mathit{i}}^\ast} = {{\mathrm{lanes}}}_{{\mathit{sh}}_{{1}}}({\mathit{cv}}_{{1}})[{\mathrm{halfop}}({\mathit{hf}}, 0, {\mathit{lns}}_{{2}}) : {\mathit{lns}}_{{2}}] \\
 &&&&\quad {\land}~{{\mathrm{lanes}}}_{{\mathit{sh}}_{{2}}}({\mathit{cv}}) = {{{{\mathit{vcvtop}}}{{{}_{({|{\mathit{lnt}}_{{1}}|},\, {|{\mathit{lnt}}_{{2}}|})}^{{{\mathit{sx}}^?}}}}}{({\mathit{i}})}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vcvtop{-}zero}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~({\mathit{sh}}_{{2}} . {{{{{{{{{\mathit{vcvtop}}}{\mathsf{\_}}}{\epsilon}}{\mathsf{\_}}}{{\mathit{sh}}_{{1}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}}{\mathsf{\_}}}{\mathsf{zero}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{\mathit{sh}}_{{1}} = {\mathit{lnt}}_{{1}}~\mathsf{x}~{\mathit{lns}}_{{1}} \\
 &&&&\quad {\land}~{\mathit{sh}}_{{2}} = {\mathit{lnt}}_{{2}}~\mathsf{x}~{\mathit{lns}}_{{2}} \\
 &&&&\quad {\land}~{{\mathit{i}}^\ast} = {{\mathrm{lanes}}}_{{\mathit{sh}}_{{1}}}({\mathit{cv}}_{{1}}) \\
 &&&&\quad {\land}~{{\mathrm{lanes}}}_{{\mathit{sh}}_{{2}}}({\mathit{cv}}) = {{{{\mathit{vcvtop}}}{{{}_{({|{\mathit{lnt}}_{{1}}|},\, {|{\mathit{lnt}}_{{2}}|})}^{{{\mathit{sx}}^?}}}}}{({\mathit{i}})}^\ast}~{0^{{\mathit{lns}}_{{1}}}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vdot}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{2}})~({{{{{\mathit{sh}}_{{1}}.\mathsf{vdot}}{\mathsf{\_}}}{{\mathit{sh}}_{{2}}}}{\mathsf{\_}}}{\mathsf{s}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{\mathit{sh}}_{{1}} = {\mathit{lnt}}_{{1}}~\mathsf{x}~{\mathit{lns}}_{{1}} \\
 &&&&\quad {\land}~{\mathit{sh}}_{{2}} = {\mathit{lnt}}_{{2}}~\mathsf{x}~{\mathit{lns}}_{{2}} \\
 &&&&\quad {\land}~{\mathit{i}}_{{1}} = {|{\mathit{lnt}}_{{1}}|} \\
 &&&&\quad {\land}~{\mathit{i}}_{{2}} = {|{\mathit{lnt}}_{{2}}|} \\
 &&&&\quad {\land}~{{\mathit{k}}_{{1}}^{{\mathit{k}'}}} = {{\mathrm{lanes}}}_{{\mathit{sh}}_{{2}}}({\mathit{cv}}_{{1}}) \\
 &&&&\quad {\land}~{{\mathit{k}}_{{2}}^{{\mathit{k}'}}} = {{\mathrm{lanes}}}_{{\mathit{sh}}_{{2}}}({\mathit{cv}}_{{2}}) \\
 &&&&\quad {\land}~{\mathrm{concat}}({({\mathit{j}}_{{1}}~{\mathit{j}}_{{2}})^\ast}) = {{\mathrm{imul}}({\mathit{i}}_{{1}}, {{{{\mathrm{ext}}}_{({\mathit{i}}_{{2}},\, {\mathit{i}}_{{1}})}^{\mathsf{s}}}}{({\mathit{k}}_{{1}})}, {{{{\mathrm{ext}}}_{({\mathit{i}}_{{2}},\, {\mathit{i}}_{{1}})}^{\mathsf{s}}}}{({\mathit{k}}_{{2}})})^{{\mathit{k}'}}} \\
 &&&&\quad {\land}~{{\mathit{j}'}^\ast} = {{\mathrm{iadd}}({\mathit{i}}_{{1}}, {\mathit{j}}_{{1}}, {\mathit{j}}_{{2}})^\ast} \\
 &&&&\quad {\land}~{{\mathrm{lanes}}}_{{\mathit{sh}}_{{1}}}({\mathit{cv}}) = {{\mathit{j}'}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vextmul}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{2}})~({{{{{{{\mathit{sh}}_{{2}}.\mathsf{vextmul}}{\mathsf{\_}}}{{\mathit{hf}}}}{\mathsf{\_}}}{{\mathit{sh}}_{{1}}}}{\mathsf{\_}}}{{\mathit{sx}}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{\mathit{sh}}_{{1}} = {\mathit{lnt}}_{{1}}~\mathsf{x}~{\mathit{lns}}_{{1}} \\
 &&&&\quad {\land}~{\mathit{sh}}_{{2}} = {\mathit{lnt}}_{{2}}~\mathsf{x}~{\mathit{lns}}_{{2}} \\
 &&&&\quad {\land}~{{\mathit{i}}^{{\mathit{k}}}} = {{\mathrm{lanes}}}_{{\mathit{sh}}_{{1}}}({\mathit{cv}}_{{1}})[{\mathrm{halfop}}({\mathit{hf}}, 0, {\mathit{lns}}_{{2}}) : {\mathit{lns}}_{{2}}] \\
 &&&&\quad {\land}~{{\mathit{j}}^{{\mathit{k}}}} = {{\mathrm{lanes}}}_{{\mathit{sh}}_{{1}}}({\mathit{cv}}_{{2}})[{\mathrm{halfop}}({\mathit{hf}}, 0, {\mathit{lns}}_{{2}}) : {\mathit{lns}}_{{2}}] \\
 &&&&\quad {\land}~{{\mathrm{lanes}}}_{{\mathit{sh}}_{{2}}}({\mathit{cv}}) = {{\mathrm{imul}}({|{\mathit{lnt}}_{{2}}|}, {{{{\mathrm{ext}}}_{({|{\mathit{lnt}}_{{1}}|},\, {|{\mathit{lnt}}_{{2}}|})}^{{\mathit{sx}}}}}{({\mathit{i}})}, {{{{\mathrm{ext}}}_{({|{\mathit{lnt}}_{{1}}|},\, {|{\mathit{lnt}}_{{2}}|})}^{{\mathit{sx}}}}}{({\mathit{j}})})^{{\mathit{k}}}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}vextadd\_pairwise}]} \quad & (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~({{{{{\mathit{sh}}_{{2}}.\mathsf{vextadd\_pairwise}}{\mathsf{\_}}}{{\mathit{sh}}_{{1}}}}{\mathsf{\_}}}{{\mathit{sx}}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{\mathit{sh}}_{{1}} = {\mathit{lnt}}_{{1}}~\mathsf{x}~{\mathit{lns}}_{{1}} \\
 &&&&\quad {\land}~{\mathit{sh}}_{{2}} = {\mathit{lnt}}_{{2}}~\mathsf{x}~{\mathit{lns}}_{{2}} \\
 &&&&\quad {\land}~{{\mathit{i}}^{{\mathit{k}}}} = {{\mathrm{lanes}}}_{{\mathit{sh}}_{{1}}}({\mathit{cv}}_{{1}}) \\
 &&&&\quad {\land}~{\mathrm{concat}}({({\mathit{i}}_{{1}}~{\mathit{i}}_{{2}})^\ast}) = {{{{{\mathrm{ext}}}_{({|{\mathit{lnt}}_{{1}}|},\, {|{\mathit{lnt}}_{{2}}|})}^{{\mathit{sx}}}}}{({\mathit{i}})}^{{\mathit{k}}}} \\
 &&&&\quad {\land}~{{\mathit{j}}^\ast} = {{\mathrm{iadd}}({|{\mathit{lnt}}_{{2}}|}, {\mathit{i}}_{{1}}, {\mathit{i}}_{{2}})^\ast} \\
 &&&&\quad {\land}~{{\mathrm{lanes}}}_{{\mathit{sh}}_{{2}}}({\mathit{cv}}) = {{\mathit{j}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}local.get}]} \quad & {\mathit{z}} ; (\mathsf{local.get}~{\mathit{x}}) &\hookrightarrow& {\mathit{val}} &\quad
  \mbox{if}~{{\mathit{z}}.\mathsf{local}}{[{\mathit{x}}]} = {\mathit{val}} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}local.set}]} \quad & {\mathit{z}} ; {\mathit{val}}~(\mathsf{local.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{local}[{\mathit{x}}] = {\mathit{val}}] ; \epsilon &  \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}local.tee}]} \quad & {\mathit{val}}~(\mathsf{local.tee}~{\mathit{x}}) &\hookrightarrow& {\mathit{val}}~{\mathit{val}}~(\mathsf{local.set}~{\mathit{x}}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}global.get}]} \quad & {\mathit{z}} ; (\mathsf{global.get}~{\mathit{x}}) &\hookrightarrow& {{\mathit{z}}.\mathsf{global}}{[{\mathit{x}}]}.\mathsf{value} &  \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}global.set}]} \quad & {\mathit{z}} ; {\mathit{val}}~(\mathsf{global.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{global}[{\mathit{x}}].\mathsf{value} = {\mathit{val}}] ; \epsilon &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.get{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{table.get}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} \geq {|{{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}|} \\
{[\textsc{\scriptsize E{-}table.get{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{table.get}~{\mathit{x}}) &\hookrightarrow& {{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}[{\mathit{i}}] &\quad
  \mbox{if}~{\mathit{i}} < {|{{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}|} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.set{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{ref}}~(\mathsf{table.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} \geq {|{{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}|} \\
{[\textsc{\scriptsize E{-}table.set{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{ref}}~(\mathsf{table.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{table}[{\mathit{x}}].\mathsf{elem}[{\mathit{i}}] = {\mathit{ref}}] ; \epsilon &\quad
  \mbox{if}~{\mathit{i}} < {|{{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.size}]} \quad & {\mathit{z}} ; (\mathsf{table.size}~{\mathit{x}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}}) &\quad
  \mbox{if}~{|{{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}|} = {\mathit{n}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.grow{-}succeed}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.grow}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{table}[{\mathit{x}}] = {\mathit{ti}}] ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}|}) &\quad
  \mbox{if}~{\mathit{ti}} = {\mathrm{growtable}}({{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}, {\mathit{n}}, {\mathit{ref}}) \\
{[\textsc{\scriptsize E{-}table.grow{-}fail}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.grow}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{{{{{\mathrm{signed}}^{{-1}}}}{}}_{32}}{{-1}}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.fill{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.fill}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}|} \\
{[\textsc{\scriptsize E{-}table.fill{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.fill}~{\mathit{x}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}table.fill{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.fill}~{\mathit{x}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{table.set}~{\mathit{x}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{table.fill}~{\mathit{x}}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.copy{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.copy}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{table}}{[{\mathit{y}}]}.\mathsf{elem}|} \lor {\mathit{j}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}|} \\
{[\textsc{\scriptsize E{-}table.copy{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.copy}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}table.copy{-}le}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.copy}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{table.get}~{\mathit{y}})~(\mathsf{table.set}~{\mathit{x}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{table.copy}~{\mathit{x}}~{\mathit{y}}) &\quad
  \mbox{otherwise, if}~{\mathit{j}} \leq {\mathit{i}} \\
{[\textsc{\scriptsize E{-}table.copy{-}gt}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.copy}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + {\mathit{n}} - 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + {\mathit{n}} - 1)~(\mathsf{table.get}~{\mathit{y}})~(\mathsf{table.set}~{\mathit{x}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{table.copy}~{\mathit{x}}~{\mathit{y}}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.init{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.init}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{elem}}{[{\mathit{y}}]}.\mathsf{elem}|} \lor {\mathit{j}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}|} \\
{[\textsc{\scriptsize E{-}table.init{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.init}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}table.init{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.init}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~{{\mathit{z}}.\mathsf{elem}}{[{\mathit{y}}]}.\mathsf{elem}[{\mathit{i}}]~(\mathsf{table.set}~{\mathit{x}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{table.init}~{\mathit{x}}~{\mathit{y}}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}elem.drop}]} \quad & {\mathit{z}} ; (\mathsf{elem.drop}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{elem}[{\mathit{x}}].\mathsf{elem} = \epsilon] ; \epsilon &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}load{-}num{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{load}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {|{\mathit{nt}}|} / 8 > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}load{-}num{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{load}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}) &\quad
  \mbox{if}~{{\mathrm{bytes}}}_{{\mathit{nt}}}({\mathit{c}}) = {{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {|{\mathit{nt}}|} / 8] \\
{[\textsc{\scriptsize E{-}load{-}pack{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({{\mathit{nt}}.\mathsf{load}}{({\mathit{n}}~\mathsf{\_}~{\mathit{sx}})}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {\mathit{n}} / 8 > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}load{-}pack{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({{\mathit{nt}}.\mathsf{load}}{({\mathit{n}}~\mathsf{\_}~{\mathit{sx}})}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& ({\mathit{nt}}.\mathsf{const}~{{{{\mathrm{ext}}}_{({\mathit{n}},\, {|{\mathit{nt}}|})}^{{\mathit{sx}}}}}{({\mathit{c}})}) &\quad
  \mbox{if}~{{\mathrm{bytes}}}_{{{\mathit{i}}}{{\mathit{n}}}}({\mathit{c}}) = {{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {\mathit{n}} / 8] \\
{[\textsc{\scriptsize E{-}vload{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{v{\scriptstyle128}.load}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {|\mathsf{v{\scriptstyle128}}|} / 8 > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}vload{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{v{\scriptstyle128}.load}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{{\mathrm{bytes}}}_{\mathsf{v{\scriptstyle128}}}({\mathit{cv}}) = {{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {|\mathsf{v{\scriptstyle128}}|} / 8] \\
{[\textsc{\scriptsize E{-}vload{-}shape{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathsf{v{\scriptstyle128}.load}}{({{({\mathit{M}}~\mathsf{x}~{\mathit{N}})}{\mathsf{\_}}}{{\mathit{sx}}})}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {\mathit{M}} \cdot {\mathit{N}} / 8 > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}vload{-}shape{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathsf{v{\scriptstyle128}.load}}{({{({\mathit{M}}~\mathsf{x}~{\mathit{N}})}{\mathsf{\_}}}{{\mathit{sx}}})}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~({{\mathrm{bytes}}}_{{{\mathit{i}}}{{\mathit{M}}}}({\mathit{m}}) = {{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {\mathit{k}} \cdot {\mathit{M}} / 8 : {\mathit{M}} / 8])^{{\mathit{k}}<{\mathit{N}}} \\
 &&&&\quad {\land}~{{\mathrm{lanes}}}_{{\mathrm{ishape}}({\mathit{M}} \cdot 2)~\mathsf{x}~{\mathit{N}}}({\mathit{cv}}) = {{{{{\mathrm{ext}}}_{({\mathit{M}},\, {\mathit{M}} \cdot 2)}^{{\mathit{sx}}}}}{({\mathit{m}})}^{{\mathit{N}}}} \\
{[\textsc{\scriptsize E{-}vload{-}splat{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathsf{v{\scriptstyle128}.load}}{({{{\mathit{n}}}{\mathsf{\_}}}{\mathsf{splat}})}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {\mathit{n}} / 8 > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}vload{-}splat{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathsf{v{\scriptstyle128}.load}}{({{{\mathit{n}}}{\mathsf{\_}}}{\mathsf{splat}})}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{{\mathrm{bytes}}}_{{{\mathit{i}}}{{\mathit{n}}}}({\mathit{m}}) = {{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {\mathit{n}} / 8] \\
 &&&&\quad {\land}~{\mathit{l}} = 128 / {\mathit{n}} \\
 &&&&\quad {\land}~{{\mathrm{lanes}}}_{{\mathrm{ishape}}({\mathit{n}})~\mathsf{x}~{\mathit{l}}}({\mathit{cv}}) = {{\mathit{m}}^{{\mathit{l}}}} \\
{[\textsc{\scriptsize E{-}vload{-}zero{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathsf{v{\scriptstyle128}.load}}{({{{\mathit{n}}}{\mathsf{\_}}}{\mathsf{zero}})}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {\mathit{n}} / 8 > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}vload{-}zero{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathsf{v{\scriptstyle128}.load}}{({{{\mathit{n}}}{\mathsf{\_}}}{\mathsf{zero}})}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{{\mathrm{bytes}}}_{{{\mathit{i}}}{{\mathit{n}}}}({\mathit{c}}) = {{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {\mathit{n}} / 8] \\
 &&&&\quad {\land}~{\mathit{cv}} = {{{{\mathrm{ext}}}_{(128,\, {\mathit{n}})}^{\mathsf{u}}}}{({\mathit{c}})} \\
{[\textsc{\scriptsize E{-}vload\_lane{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~({{{\mathsf{v{\scriptstyle128}.load}}{{\mathit{n}}}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~{\mathit{mo}}~{\mathit{laneidx}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {\mathit{n}} / 8 > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}vload\_lane{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}_{{1}})~({{{\mathsf{v{\scriptstyle128}.load}}{{\mathit{n}}}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~{\mathit{mo}}~{\mathit{laneidx}}) &\hookrightarrow& (\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}}) &\quad
  \mbox{if}~{{\mathrm{bytes}}}_{{{\mathit{i}}}{{\mathit{n}}}}({\mathit{m}}) = {{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {\mathit{n}} / 8] \\
 &&&&\quad {\land}~{\mathit{sh}} = {\mathrm{ishape}}({\mathit{n}})~\mathsf{x}~128 / {\mathit{n}} \\
 &&&&\quad {\land}~{{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}}) = {{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{cv}}_{{1}})[[{\mathit{laneidx}}] = {\mathit{m}}] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}store{-}num{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~({\mathit{nt}}.\mathsf{store}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {|{\mathit{nt}}|} / 8 > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}store{-}num{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~({\mathit{nt}}.\mathsf{store}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& {\mathit{z}}[\mathsf{mem}[{\mathit{x}}].\mathsf{data}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {|{\mathit{nt}}|} / 8] = {{\mathit{b}}^\ast}] ; \epsilon &\quad
  \mbox{if}~{{\mathit{b}}^\ast} = {{\mathrm{bytes}}}_{{\mathit{nt}}}({\mathit{c}}) \\
{[\textsc{\scriptsize E{-}store{-}pack{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~({{\mathit{nt}}.\mathsf{store}}{{\mathit{n}}}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {\mathit{n}} / 8 > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}store{-}pack{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~({{\mathit{nt}}.\mathsf{store}}{{\mathit{n}}}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& {\mathit{z}}[\mathsf{mem}[{\mathit{x}}].\mathsf{data}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {\mathit{n}} / 8] = {{\mathit{b}}^\ast}] ; \epsilon &\quad
  \mbox{if}~{{\mathit{b}}^\ast} = {{\mathrm{bytes}}}_{{{\mathit{i}}}{{\mathit{n}}}}({{{\mathrm{wrap}}}_{({|{\mathit{nt}}|},\, {\mathit{n}})}}{({\mathit{c}})}) \\
{[\textsc{\scriptsize E{-}vstore{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}})~(\mathsf{v{\scriptstyle128}.store}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {|\mathsf{v{\scriptstyle128}}|} / 8 > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}vstore{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}})~(\mathsf{v{\scriptstyle128}.store}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& {\mathit{z}}[\mathsf{mem}[{\mathit{x}}].\mathsf{data}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {|\mathsf{v{\scriptstyle128}}|} / 8] = {{\mathit{b}}^\ast}] ; \epsilon &\quad
  \mbox{if}~{{\mathit{b}}^\ast} = {{\mathrm{bytes}}}_{\mathsf{v{\scriptstyle128}}}({\mathit{cv}}) \\
{[\textsc{\scriptsize E{-}vstore\_lane{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}})~({{{\mathsf{v{\scriptstyle128}.store}}{{\mathit{n}}}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~{\mathit{mo}}~{\mathit{laneidx}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}vstore\_lane{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{v{\scriptstyle128}}.\mathsf{const}~{\mathit{cv}})~({{{\mathsf{v{\scriptstyle128}.store}}{{\mathit{n}}}}{\mathsf{\_}}}{\mathsf{lane}}~{\mathit{x}}~{\mathit{mo}}~{\mathit{laneidx}}) &\hookrightarrow& {\mathit{z}}[\mathsf{mem}[{\mathit{x}}].\mathsf{data}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {\mathit{n}} / 8] = {{\mathit{b}}^\ast}] ; \epsilon &\quad
  \mbox{if}~{{\mathit{b}}^\ast} = {{\mathrm{bytes}}}_{{{\mathit{i}}}{{\mathit{n}}}}({{\mathrm{lanes}}}_{{\mathrm{ishape}}({\mathit{n}})~\mathsf{x}~128 / {\mathit{n}}}({\mathit{cv}})[{\mathit{laneidx}}]) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.size}]} \quad & {\mathit{z}} ; (\mathsf{memory.size}~{\mathit{x}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}}) &\quad
  \mbox{if}~{\mathit{n}} \cdot 64 \cdot {\mathrm{Ki}} = {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.grow{-}succeed}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.grow}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{mem}[{\mathit{x}}] = {\mathit{mi}}] ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} / (64 \cdot {\mathrm{Ki}})) &\quad
  \mbox{if}~{\mathit{mi}} = {\mathrm{growmemory}}({{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}, {\mathit{n}}) \\
{[\textsc{\scriptsize E{-}memory.grow{-}fail}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.grow}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{{{{{\mathrm{signed}}^{{-1}}}}{}}_{32}}{{-1}}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.fill{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.fill}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}memory.fill{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.fill}~{\mathit{x}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}memory.fill{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.fill}~{\mathit{x}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~{\mathit{x}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{memory.fill}~{\mathit{x}}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.copy{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}}_{{1}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}_{{1}}]}.\mathsf{data}|} \lor {\mathit{i}}_{{2}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}_{{2}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}memory.copy{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}memory.copy{-}le}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~({\mathsf{i{\scriptstyle32}}.\mathsf{load}}{(8~\mathsf{\_}~\mathsf{u})}~{\mathit{x}}_{{2}})~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~{\mathit{x}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\quad
  \mbox{otherwise, if}~{\mathit{i}}_{{1}} \leq {\mathit{i}}_{{2}} \\
{[\textsc{\scriptsize E{-}memory.copy{-}gt}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}} + {\mathit{n}} - 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}} + {\mathit{n}} - 1)~({\mathsf{i{\scriptstyle32}}.\mathsf{load}}{(8~\mathsf{\_}~\mathsf{u})}~{\mathit{x}}_{{2}})~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~{\mathit{x}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.init{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{data}}{[{\mathit{y}}]}.\mathsf{data}|} \lor {\mathit{j}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}memory.init{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}memory.init{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{{\mathit{z}}.\mathsf{data}}{[{\mathit{y}}]}.\mathsf{data}[{\mathit{i}}])~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~{\mathit{x}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}data.drop}]} \quad & {\mathit{z}} ; (\mathsf{data.drop}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{data}[{\mathit{x}}].\mathsf{data} = \epsilon] ; \epsilon &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{alloctypes}}(\epsilon) &=& \epsilon &  \\
{\mathrm{alloctypes}}({{\mathit{type}'}^\ast}~{\mathit{type}}) &=& {{\mathit{deftype}'}^\ast}~{{\mathit{deftype}}^\ast} &\quad
  \mbox{if}~{{\mathit{deftype}'}^\ast} = {\mathrm{alloctypes}}({{\mathit{type}'}^\ast}) \\
 &&&\quad {\land}~{\mathit{type}} = \mathsf{type}~{\mathit{rectype}} \\
 &&&\quad {\land}~{{\mathit{deftype}}^\ast} = {{{\mathrm{roll}}}_{{\mathit{x}}}({\mathit{rectype}})}{[{ := }\;{{\mathit{deftype}'}^\ast}]} \\
 &&&\quad {\land}~{\mathit{x}} = {|{{\mathit{deftype}'}^\ast}|} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocfunc}}({\mathit{s}}, {\mathit{mm}}, {\mathit{func}}) &=& ({\mathit{s}}[\mathsf{func} = ..{\mathit{fi}}],\, {|{\mathit{s}}.\mathsf{func}|}) &\quad
  \mbox{if}~{\mathit{func}} = \mathsf{func}~{\mathit{x}}~{{\mathit{local}}^\ast}~{\mathit{expr}} \\
 &&&\quad {\land}~{\mathit{fi}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{mm}}.\mathsf{type}[{\mathit{x}}],\; \mathsf{module}~{\mathit{mm}},\; \mathsf{code}~{\mathit{func}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocfuncs}}({\mathit{s}}, {\mathit{mm}}, \epsilon) &=& ({\mathit{s}},\, \epsilon) &  \\
{\mathrm{allocfuncs}}({\mathit{s}}, {\mathit{mm}}, {\mathit{func}}~{{\mathit{func}'}^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{fa}}~{{\mathit{fa}'}^\ast}) &\quad
  \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{fa}}) = {\mathrm{allocfunc}}({\mathit{s}}, {\mathit{mm}}, {\mathit{func}}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{fa}'}^\ast}) = {\mathrm{allocfuncs}}({\mathit{s}}_{{1}}, {\mathit{mm}}, {{\mathit{func}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocglobal}}({\mathit{s}}, {\mathit{globaltype}}, {\mathit{val}}) &=& ({\mathit{s}}[\mathsf{global} = ..{\mathit{gi}}],\, {|{\mathit{s}}.\mathsf{global}|}) &\quad
  \mbox{if}~{\mathit{gi}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{globaltype}},\; \mathsf{value}~{\mathit{val}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocglobals}}({\mathit{s}}, \epsilon, \epsilon) &=& ({\mathit{s}},\, \epsilon) &  \\
{\mathrm{allocglobals}}({\mathit{s}}, {\mathit{globaltype}}~{{\mathit{globaltype}'}^\ast}, {\mathit{val}}~{{\mathit{val}'}^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{ga}}~{{\mathit{ga}'}^\ast}) &\quad
  \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{ga}}) = {\mathrm{allocglobal}}({\mathit{s}}, {\mathit{globaltype}}, {\mathit{val}}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ga}'}^\ast}) = {\mathrm{allocglobals}}({\mathit{s}}_{{1}}, {{\mathit{globaltype}'}^\ast}, {{\mathit{val}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{alloctable}}({\mathit{s}}, [{\mathit{i}} .. {\mathit{j}}]~{\mathit{rt}}, {\mathit{ref}}) &=& ({\mathit{s}}[\mathsf{table} = ..{\mathit{ti}}],\, {|{\mathit{s}}.\mathsf{table}|}) &\quad
  \mbox{if}~{\mathit{ti}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([{\mathit{i}} .. {\mathit{j}}]~{\mathit{rt}}),\; \mathsf{elem}~{{\mathit{ref}}^{{\mathit{i}}}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{alloctables}}({\mathit{s}}, \epsilon, \epsilon) &=& ({\mathit{s}},\, \epsilon) &  \\
{\mathrm{alloctables}}({\mathit{s}}, {\mathit{tabletype}}~{{\mathit{tabletype}'}^\ast}, {\mathit{ref}}~{{\mathit{ref}'}^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{ta}}~{{\mathit{ta}'}^\ast}) &\quad
  \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{ta}}) = {\mathrm{alloctable}}({\mathit{s}}, {\mathit{tabletype}}, {\mathit{ref}}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ta}'}^\ast}) = {\mathrm{alloctables}}({\mathit{s}}_{{1}}, {{\mathit{tabletype}'}^\ast}, {{\mathit{ref}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocmem}}({\mathit{s}}, [{\mathit{i}} .. {\mathit{j}}]~\mathsf{i{\scriptstyle8}}) &=& ({\mathit{s}}[\mathsf{mem} = ..{\mathit{mi}}],\, {|{\mathit{s}}.\mathsf{mem}|}) &\quad
  \mbox{if}~{\mathit{mi}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([{\mathit{i}} .. {\mathit{j}}]~\mathsf{i{\scriptstyle8}}),\; \mathsf{data}~{0^{{\mathit{i}} \cdot 64 \cdot {\mathrm{Ki}}}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocmems}}({\mathit{s}}, \epsilon) &=& ({\mathit{s}},\, \epsilon) &  \\
{\mathrm{allocmems}}({\mathit{s}}, {\mathit{memtype}}~{{\mathit{memtype}'}^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{ma}}~{{\mathit{ma}'}^\ast}) &\quad
  \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{ma}}) = {\mathrm{allocmem}}({\mathit{s}}, {\mathit{memtype}}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ma}'}^\ast}) = {\mathrm{allocmems}}({\mathit{s}}_{{1}}, {{\mathit{memtype}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocelem}}({\mathit{s}}, {\mathit{rt}}, {{\mathit{ref}}^\ast}) &=& ({\mathit{s}}[\mathsf{elem} = ..{\mathit{ei}}],\, {|{\mathit{s}}.\mathsf{elem}|}) &\quad
  \mbox{if}~{\mathit{ei}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{rt}},\; \mathsf{elem}~{{\mathit{ref}}^\ast} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocelems}}({\mathit{s}}, \epsilon, \epsilon) &=& ({\mathit{s}},\, \epsilon) &  \\
{\mathrm{allocelems}}({\mathit{s}}, {\mathit{rt}}~{{\mathit{rt}'}^\ast}, ({{\mathit{ref}}^\ast})~{({{\mathit{ref}'}^\ast})^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{ea}}~{{\mathit{ea}'}^\ast}) &\quad
  \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{ea}}) = {\mathrm{allocelem}}({\mathit{s}}, {\mathit{rt}}, {{\mathit{ref}}^\ast}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ea}'}^\ast}) = {\mathrm{allocelems}}({\mathit{s}}_{{2}}, {{\mathit{rt}'}^\ast}, {({{\mathit{ref}'}^\ast})^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocdata}}({\mathit{s}}, {{\mathit{byte}}^\ast}) &=& ({\mathit{s}}[\mathsf{data} = ..{\mathit{di}}],\, {|{\mathit{s}}.\mathsf{data}|}) &\quad
  \mbox{if}~{\mathit{di}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{data}~{{\mathit{byte}}^\ast} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocdatas}}({\mathit{s}}, \epsilon) &=& ({\mathit{s}},\, \epsilon) &  \\
{\mathrm{allocdatas}}({\mathit{s}}, ({{\mathit{byte}}^\ast})~{({{\mathit{byte}'}^\ast})^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{da}}~{{\mathit{da}'}^\ast}) &\quad
  \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{da}}) = {\mathrm{allocdata}}({\mathit{s}}, {{\mathit{byte}}^\ast}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{da}'}^\ast}) = {\mathrm{allocdatas}}({\mathit{s}}_{{1}}, {({{\mathit{byte}'}^\ast})^\ast}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{instexport}}({{\mathit{fa}}^\ast}, {{\mathit{ga}}^\ast}, {{\mathit{ta}}^\ast}, {{\mathit{ma}}^\ast}, \mathsf{export}~{\mathit{name}}~(\mathsf{func}~{\mathit{x}})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{func}~{{\mathit{fa}}^\ast}[{\mathit{x}}]) \}\end{array} &  \\
{\mathrm{instexport}}({{\mathit{fa}}^\ast}, {{\mathit{ga}}^\ast}, {{\mathit{ta}}^\ast}, {{\mathit{ma}}^\ast}, \mathsf{export}~{\mathit{name}}~(\mathsf{global}~{\mathit{x}})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{global}~{{\mathit{ga}}^\ast}[{\mathit{x}}]) \}\end{array} &  \\
{\mathrm{instexport}}({{\mathit{fa}}^\ast}, {{\mathit{ga}}^\ast}, {{\mathit{ta}}^\ast}, {{\mathit{ma}}^\ast}, \mathsf{export}~{\mathit{name}}~(\mathsf{table}~{\mathit{x}})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{table}~{{\mathit{ta}}^\ast}[{\mathit{x}}]) \}\end{array} &  \\
{\mathrm{instexport}}({{\mathit{fa}}^\ast}, {{\mathit{ga}}^\ast}, {{\mathit{ta}}^\ast}, {{\mathit{ma}}^\ast}, \mathsf{export}~{\mathit{name}}~(\mathsf{mem}~{\mathit{x}})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{mem}~{{\mathit{ma}}^\ast}[{\mathit{x}}]) \}\end{array} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocmodule}}({\mathit{s}}, {\mathit{module}}, {{\mathit{externval}}^\ast}, {{\mathit{val}}_{{\mathit{g}}}^\ast}, {{\mathit{ref}}_{{\mathit{t}}}^\ast}, {({{\mathit{ref}}_{{\mathit{e}}}^\ast})^\ast}) &=& ({\mathit{s}}_{{6}},\, {\mathit{mm}}) &\quad
  \mbox{if}~{\mathit{module}} = \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^{{\mathit{n}}_{{\mathit{f}}}}}~{(\mathsf{global}~{\mathit{globaltype}}~{\mathit{expr}}_{{\mathit{g}}})^{{\mathit{n}}_{{\mathit{g}}}}}~{(\mathsf{table}~{\mathit{tabletype}}~{\mathit{expr}}_{{\mathit{t}}})^{{\mathit{n}}_{{\mathit{t}}}}}~{(\mathsf{memory}~{\mathit{memtype}})^{{\mathit{n}}_{{\mathit{m}}}}}~{(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}_{{\mathit{e}}}^\ast}~{\mathit{elemmode}})^{{\mathit{n}}_{{\mathit{e}}}}}~{(\mathsf{data}~{{\mathit{byte}}^\ast}~{\mathit{datamode}})^{{\mathit{n}}_{{\mathit{d}}}}}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast} \\
 &&&\quad {\land}~{{\mathit{fa}}_{{\mathit{ex}}}^\ast} = {\mathrm{funcs}}({{\mathit{externval}}^\ast}) \\
 &&&\quad {\land}~{{\mathit{ga}}_{{\mathit{ex}}}^\ast} = {\mathrm{globals}}({{\mathit{externval}}^\ast}) \\
 &&&\quad {\land}~{{\mathit{ta}}_{{\mathit{ex}}}^\ast} = {\mathrm{tables}}({{\mathit{externval}}^\ast}) \\
 &&&\quad {\land}~{{\mathit{ma}}_{{\mathit{ex}}}^\ast} = {\mathrm{mems}}({{\mathit{externval}}^\ast}) \\
 &&&\quad {\land}~{{\mathit{fa}}^\ast} = {{|{\mathit{s}}.\mathsf{func}|} + {\mathit{i}}_{{\mathit{f}}}^{{\mathit{i}}_{{\mathit{f}}}<{\mathit{n}}_{{\mathit{f}}}}} \\
 &&&\quad {\land}~{{\mathit{ga}}^\ast} = {{|{\mathit{s}}.\mathsf{global}|} + {\mathit{i}}_{{\mathit{g}}}^{{\mathit{i}}_{{\mathit{g}}}<{\mathit{n}}_{{\mathit{g}}}}} \\
 &&&\quad {\land}~{{\mathit{ta}}^\ast} = {{|{\mathit{s}}.\mathsf{table}|} + {\mathit{i}}_{{\mathit{t}}}^{{\mathit{i}}_{{\mathit{t}}}<{\mathit{n}}_{{\mathit{t}}}}} \\
 &&&\quad {\land}~{{\mathit{ma}}^\ast} = {{|{\mathit{s}}.\mathsf{mem}|} + {\mathit{i}}_{{\mathit{m}}}^{{\mathit{i}}_{{\mathit{m}}}<{\mathit{n}}_{{\mathit{m}}}}} \\
 &&&\quad {\land}~{{\mathit{ea}}^\ast} = {{|{\mathit{s}}.\mathsf{elem}|} + {\mathit{i}}_{{\mathit{e}}}^{{\mathit{i}}_{{\mathit{e}}}<{\mathit{n}}_{{\mathit{e}}}}} \\
 &&&\quad {\land}~{{\mathit{da}}^\ast} = {{|{\mathit{s}}.\mathsf{data}|} + {\mathit{i}}_{{\mathit{d}}}^{{\mathit{i}}_{{\mathit{d}}}<{\mathit{n}}_{{\mathit{d}}}}} \\
 &&&\quad {\land}~{{\mathit{xi}}^\ast} = {{\mathrm{instexport}}({{\mathit{fa}}_{{\mathit{ex}}}^\ast}~{{\mathit{fa}}^\ast}, {{\mathit{ga}}_{{\mathit{ex}}}^\ast}~{{\mathit{ga}}^\ast}, {{\mathit{ta}}_{{\mathit{ex}}}^\ast}~{{\mathit{ta}}^\ast}, {{\mathit{ma}}_{{\mathit{ex}}}^\ast}~{{\mathit{ma}}^\ast}, {\mathit{export}})^\ast} \\
 &&&\quad {\land}~{\mathit{mm}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{{\mathit{dt}}^\ast},\; \\
  \mathsf{func}~{{\mathit{fa}}_{{\mathit{ex}}}^\ast}~{{\mathit{fa}}^\ast},\; \\
  \mathsf{global}~{{\mathit{ga}}_{{\mathit{ex}}}^\ast}~{{\mathit{ga}}^\ast},\; \\
  \mathsf{table}~{{\mathit{ta}}_{{\mathit{ex}}}^\ast}~{{\mathit{ta}}^\ast},\; \\
  \mathsf{mem}~{{\mathit{ma}}_{{\mathit{ex}}}^\ast}~{{\mathit{ma}}^\ast},\; \\
  \mathsf{elem}~{{\mathit{ea}}^\ast},\; \\
  \mathsf{data}~{{\mathit{da}}^\ast},\; \\
  \mathsf{export}~{{\mathit{xi}}^\ast} \}\end{array} \\
 &&&\quad {\land}~{{\mathit{dt}}^\ast} = {\mathrm{alloctypes}}({{\mathit{type}}^\ast}) \\
 &&&\quad {\land}~({\mathit{s}}_{{1}},\, {{\mathit{fa}}^\ast}) = {\mathrm{allocfuncs}}({\mathit{s}}, {\mathit{mm}}, {{\mathit{func}}^{{\mathit{n}}_{{\mathit{f}}}}}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ga}}^\ast}) = {\mathrm{allocglobals}}({\mathit{s}}_{{1}}, {{\mathit{globaltype}}^{{\mathit{n}}_{{\mathit{g}}}}}, {{\mathit{val}}_{{\mathit{g}}}^\ast}) \\
 &&&\quad {\land}~({\mathit{s}}_{{3}},\, {{\mathit{ta}}^\ast}) = {\mathrm{alloctables}}({\mathit{s}}_{{2}}, {{\mathit{tabletype}}^{{\mathit{n}}_{{\mathit{t}}}}}, {{\mathit{ref}}_{{\mathit{t}}}^\ast}) \\
 &&&\quad {\land}~({\mathit{s}}_{{4}},\, {{\mathit{ma}}^\ast}) = {\mathrm{allocmems}}({\mathit{s}}_{{3}}, {{\mathit{memtype}}^{{\mathit{n}}_{{\mathit{m}}}}}) \\
 &&&\quad {\land}~({\mathit{s}}_{{5}},\, {{\mathit{ea}}^\ast}) = {\mathrm{allocelems}}({\mathit{s}}_{{4}}, {{\mathit{reftype}}^{{\mathit{n}}_{{\mathit{e}}}}}, {({{\mathit{ref}}_{{\mathit{e}}}^\ast})^\ast}) \\
 &&&\quad {\land}~({\mathit{s}}_{{6}},\, {{\mathit{da}}^\ast}) = {\mathrm{allocdatas}}({\mathit{s}}_{{5}}, {({{\mathit{byte}}^\ast})^{{\mathit{n}}_{{\mathit{d}}}}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{concat}}_{{\mathit{instr}}}(\epsilon) &=& \epsilon &  \\
{\mathrm{concat}}_{{\mathit{instr}}}(({{\mathit{instr}}^\ast})~{({{\mathit{instr}'}^\ast})^\ast}) &=& {{\mathit{instr}}^\ast}~{\mathrm{concat}}_{{\mathit{instr}}}({({{\mathit{instr}'}^\ast})^\ast}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{runelem}}(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}^\ast}~(\mathsf{passive}), {\mathit{y}}) &=& \epsilon &  \\
{\mathrm{runelem}}(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}^\ast}~(\mathsf{declare}), {\mathit{y}}) &=& (\mathsf{elem.drop}~{\mathit{y}}) &  \\
{\mathrm{runelem}}(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}^\ast}~(\mathsf{active}~{\mathit{x}}~{{\mathit{instr}}^\ast}), {\mathit{y}}) &=& {{\mathit{instr}}^\ast}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{{\mathit{expr}}^\ast}|})~(\mathsf{table.init}~{\mathit{x}}~{\mathit{y}})~(\mathsf{elem.drop}~{\mathit{y}}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{rundata}}(\mathsf{data}~{{\mathit{byte}}^\ast}~(\mathsf{passive}), {\mathit{y}}) &=& \epsilon &  \\
{\mathrm{rundata}}(\mathsf{data}~{{\mathit{byte}}^\ast}~(\mathsf{active}~{\mathit{x}}~{{\mathit{instr}}^\ast}), {\mathit{y}}) &=& {{\mathit{instr}}^\ast}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{{\mathit{byte}}^\ast}|})~(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}})~(\mathsf{data.drop}~{\mathit{y}}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{instantiate}}({\mathit{s}}, {\mathit{module}}, {{\mathit{externval}}^\ast}) &=& {\mathit{s}'} ; {\mathit{f}} ; {{\mathit{instr}}_{{\mathit{E}}}^\ast}~{{\mathit{instr}}_{{\mathsf{d}}}^\ast}~{(\mathsf{call}~{\mathit{x}})^?} &\quad
  \mbox{if}~{\mathit{module}} = \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast} \\
 &&&\quad {\land}~{{\mathit{global}}^\ast} = {(\mathsf{global}~{\mathit{globaltype}}~{\mathit{expr}}_{{\mathsf{g}}})^\ast} \\
 &&&\quad {\land}~{{\mathit{table}}^\ast} = {(\mathsf{table}~{\mathit{tabletype}}~{\mathit{expr}}_{{\mathsf{t}}})^\ast} \\
 &&&\quad {\land}~{{\mathit{elem}}^\ast} = {(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}_{{\mathit{E}}}^\ast}~{\mathit{elemmode}})^\ast} \\
 &&&\quad {\land}~{{\mathit{start}}^?} = {(\mathsf{start}~{\mathit{x}})^?} \\
 &&&\quad {\land}~{\mathit{n}}_{{\mathsf{f}}} = {|{{\mathit{func}}^\ast}|} \\
 &&&\quad {\land}~{\mathit{n}}_{{\mathit{E}}} = {|{{\mathit{elem}}^\ast}|} \\
 &&&\quad {\land}~{\mathit{n}}_{{\mathsf{d}}} = {|{{\mathit{data}}^\ast}|} \\
 &&&\quad {\land}~{\mathit{mm}}_{{\mathit{init}}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathrm{alloctypes}}({{\mathit{type}}^\ast}),\; \\
  \mathsf{func}~{\mathrm{funcs}}({{\mathit{externval}}^\ast})~{{|{\mathit{s}}.\mathsf{func}|} + {\mathit{i}}_{{\mathsf{f}}}^{{\mathit{i}}_{{\mathsf{f}}}<{\mathit{n}}_{{\mathsf{f}}}}},\; \\
  \mathsf{global}~{\mathrm{globals}}({{\mathit{externval}}^\ast}),\; \\
   \}\end{array} \\
 &&&\quad {\land}~{\mathit{z}} = {\mathit{s}} ; \{ \begin{array}[t]{@{}l@{}}
\mathsf{module}~{\mathit{mm}}_{{\mathit{init}}} \}\end{array} \\
 &&&\quad {\land}~({\mathit{z}} ; {\mathit{expr}}_{{\mathsf{g}}} \hookrightarrow^\ast {\mathit{z}} ; {\mathit{val}}_{{\mathsf{g}}})^\ast \\
 &&&\quad {\land}~({\mathit{z}} ; {\mathit{expr}}_{{\mathsf{t}}} \hookrightarrow^\ast {\mathit{z}} ; {\mathit{ref}}_{{\mathsf{t}}})^\ast \\
 &&&\quad {\land}~{({\mathit{z}} ; {\mathit{expr}}_{{\mathit{E}}} \hookrightarrow^\ast {\mathit{z}} ; {\mathit{ref}}_{{\mathit{E}}})^\ast}^\ast \\
 &&&\quad {\land}~({\mathit{s}'},\, {\mathit{mm}}) = {\mathrm{allocmodule}}({\mathit{s}}, {\mathit{module}}, {{\mathit{externval}}^\ast}, {{\mathit{val}}_{{\mathsf{g}}}^\ast}, {{\mathit{ref}}_{{\mathsf{t}}}^\ast}, {({{\mathit{ref}}_{{\mathit{E}}}^\ast})^\ast}) \\
 &&&\quad {\land}~{\mathit{f}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{module}~{\mathit{mm}} \}\end{array} \\
 &&&\quad {\land}~{{\mathit{instr}}_{{\mathit{E}}}^\ast} = {\mathrm{concat}}_{{\mathit{instr}}}({{\mathrm{runelem}}({{\mathit{elem}}^\ast}[{\mathit{i}}], {\mathit{i}})^{{\mathit{i}}<{\mathit{n}}_{{\mathit{E}}}}}) \\
 &&&\quad {\land}~{{\mathit{instr}}_{{\mathsf{d}}}^\ast} = {\mathrm{concat}}_{{\mathit{instr}}}({{\mathrm{rundata}}({{\mathit{data}}^\ast}[{\mathit{j}}], {\mathit{j}})^{{\mathit{j}}<{\mathit{n}}_{{\mathsf{d}}}}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{invoke}}({\mathit{s}}, {\mathit{fa}}, {{\mathit{val}}^{{\mathit{n}}}}) &=& {\mathit{s}} ; {\mathit{f}} ; {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{ref.func}~{\mathit{fa}})~(\mathsf{call\_ref}~0) &\quad
  \mbox{if}~{\mathit{f}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{module}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \}\end{array} \\
 &&&\quad {\land}~({\mathit{s}} ; {\mathit{f}}).\mathsf{func}[{\mathit{fa}}].\mathsf{code} = \mathsf{func}~{\mathit{x}}~{{\mathit{local}}^\ast}~{\mathit{expr}} \\
 &&&\quad {\land}~{\mathit{s}}.\mathsf{func}[{\mathit{fa}}].\mathsf{type} \approx \mathsf{func}~({{\mathit{t}}_{{1}}^{{\mathit{n}}}} \rightarrow {{\mathit{t}}_{{2}}^\ast}) \\
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
& {{\mathtt{u}}}{{\mathit{N}}} &::=& {\mathit{n}}{:}{\mathtt{byte}} &\Rightarrow& {\mathit{n}} &\quad
  \mbox{if}~{\mathit{n}} < {2^{7}} \land {\mathit{n}} < {2^{{\mathit{N}}}} \\ &&|&
{\mathit{n}}{:}{\mathtt{byte}}~{\mathit{m}}{:}{{\mathtt{u}}}{({\mathit{N}} - 7)} &\Rightarrow& {2^{7}} \cdot {\mathit{m}} + ({\mathit{n}} - {2^{7}}) &\quad
  \mbox{if}~{\mathit{n}} \geq {2^{7}} \land {\mathit{N}} > 7 \\
& {{\mathtt{s}}}{{\mathit{N}}} &::=& {\mathit{n}}{:}{\mathtt{byte}} &\Rightarrow& {\mathit{n}} &\quad
  \mbox{if}~{\mathit{n}} < {2^{6}} \land {\mathit{n}} < {2^{{\mathit{N}} - 1}} \\ &&|&
{\mathit{n}}{:}{\mathtt{byte}} &\Rightarrow& {\mathit{n}} - {2^{7}} &\quad
  \mbox{if}~{2^{6}} \leq {\mathit{n}} < {2^{7}} \land {\mathit{n}} \geq {2^{7}} - {2^{{\mathit{N}} - 1}} \\ &&|&
{\mathit{n}}{:}{\mathtt{byte}}~{\mathit{i}}{:}{{\mathtt{u}}}{({\mathit{N}} - 7)} &\Rightarrow& {2^{7}} \cdot {\mathit{i}} + ({\mathit{n}} - {2^{7}}) &\quad
  \mbox{if}~{\mathit{n}} \geq {2^{7}} \land {\mathit{N}} > 7 \\
& {{\mathtt{i}}}{{\mathit{N}}} &::=& {\mathit{i}}{:}{{\mathtt{s}}}{{\mathit{N}}} &\Rightarrow& {{{{{\mathrm{signed}}^{{-1}}}}{}}_{{\mathit{N}}}}{{\mathit{i}}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {{\mathtt{f}}}{{\mathit{N}}} &::=& {{\mathit{b}}^\ast}{:}{{\mathtt{byte}}^{{\mathit{N}} / 8}} &\Rightarrow& {\mathrm{invfbytes}}({\mathit{N}}, {{\mathit{b}}^\ast}) \\
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
{\mathrm{utf{\scriptstyle8}}}({\mathit{c}}) &=& {\mathit{b}} &\quad
  \mbox{if}~{\mathit{c}} < \mathrm{U{+}80} \land {\mathit{c}} = {\mathit{b}} \\
{\mathrm{utf{\scriptstyle8}}}({\mathit{c}}) &=& {\mathit{b}}_{{1}}~{\mathit{b}}_{{2}} &\quad
  \mbox{if}~\mathrm{U{+}80} \leq {\mathit{c}} < \mathrm{U{+}0800} \land {\mathit{c}} = {2^{6}} \cdot ({\mathit{b}}_{{1}} - \mathtt{0xC0}) + ({\mathit{b}}_{{2}} - \mathtt{0x80}) \\
{\mathrm{utf{\scriptstyle8}}}({\mathit{c}}) &=& {\mathit{b}}_{{1}}~{\mathit{b}}_{{2}}~{\mathit{b}}_{{3}} &\quad
  \mbox{if}~(\mathrm{U{+}0800} \leq {\mathit{c}} < \mathrm{U{+}D800} \lor \mathrm{U{+}E000} \leq {\mathit{c}} < \mathrm{U{+}10000}) \land {\mathit{c}} = {2^{12}} \cdot ({\mathit{b}}_{{1}} - \mathtt{0xE0}) + {2^{6}} \cdot ({\mathit{b}}_{{2}} - \mathtt{0x80}) + ({\mathit{b}}_{{3}} - \mathtt{0x80}) \\
{\mathrm{utf{\scriptstyle8}}}({\mathit{c}}) &=& {\mathit{b}}_{{1}}~{\mathit{b}}_{{2}}~{\mathit{b}}_{{3}}~{\mathit{b}}_{{4}} &\quad
  \mbox{if}~(\mathrm{U{+}10000} \leq {\mathit{c}} < \mathrm{U{+}11000}) \land {\mathit{c}} = {2^{18}} \cdot ({\mathit{b}}_{{1}} - \mathtt{0xF0}) + {2^{12}} \cdot ({\mathit{b}}_{{2}} - \mathtt{0x80}) + {2^{6}} \cdot ({\mathit{b}}_{{3}} - \mathtt{0x80}) + ({\mathit{b}}_{{4}} - \mathtt{0x80}) \\
{\mathrm{utf{\scriptstyle8}}}({{\mathit{c}}^\ast}) &=& {\mathrm{concat}}({{\mathrm{utf{\scriptstyle8}}}({\mathit{c}})^\ast}) &  \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{name}} &::=& {{\mathit{b}}^\ast}{:}{\mathtt{vec}}({\mathtt{byte}}) &\Rightarrow& {\mathit{name}} &\quad
  \mbox{if}~{\mathrm{utf{\scriptstyle8}}}({\mathit{name}}) = {{\mathit{b}}^\ast} \\
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
{{\mathit{x}}}{:}{\mathtt{s{\scriptstyle33}}} &\Rightarrow& {{\mathit{x}}} &\quad
  \mbox{if}~{{\mathit{x}}} \geq 0 \\
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
& {\mathtt{packedtype}} &::=& \mathtt{0x78} &\Rightarrow& \mathsf{i{\scriptstyle8}} \\ &&|&
\mathtt{0x77} &\Rightarrow& \mathsf{i{\scriptstyle16}} \\
& {\mathtt{storagetype}} &::=& {\mathit{t}}{:}{\mathtt{valtype}} &\Rightarrow& {\mathit{t}} \\ &&|&
{\mathit{pt}}{:}{\mathtt{packedtype}} &\Rightarrow& {\mathit{pt}} \\
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
& {\mathtt{limits}} &::=& \mathtt{0x00}~{\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& [{\mathit{n}} .. {2^{32}} - 1] \\ &&|&
\mathtt{0x01}~{\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{m}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& [{\mathit{n}} .. {\mathit{m}}] \\
& {\mathtt{globaltype}} &::=& {\mathit{t}}{:}{\mathtt{valtype}}~{\mathit{mut}}{:}{\mathtt{mut}} &\Rightarrow& {\mathit{mut}}~{\mathit{t}} \\
& {\mathtt{tabletype}} &::=& {\mathit{rt}}{:}{\mathtt{reftype}}~{\mathit{lim}}{:}{\mathtt{limits}} &\Rightarrow& {\mathit{lim}}~{\mathit{rt}} \\
& {\mathtt{memtype}} &::=& {\mathit{lim}}{:}{\mathtt{limits}} &\Rightarrow& {\mathit{lim}}~\mathsf{i{\scriptstyle8}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{externtype}} &::=& \mathtt{0x00}~{\mathit{ct}}{:}{\mathtt{comptype}} &\Rightarrow& \mathsf{func}~((\mathsf{rec}~(\mathsf{sub}~\mathsf{final}~\epsilon~{\mathit{ct}})) . 0) \\ &&|&
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
{\mathit{i}}{:}{\mathtt{s{\scriptstyle33}}} &\Rightarrow& {\mathit{x}} &\quad
  \mbox{if}~{\mathit{i}} \geq 0 \land {\mathit{i}} = {\mathit{x}} \\
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
\mathsf{align}~{\mathit{n}},\; \mathsf{offset}~{\mathit{m}} \}\end{array}) &\quad
  \mbox{if}~{\mathit{n}} < {2^{6}} \\ &&|&
{\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{memidx}}~{\mathit{m}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({\mathit{x}},\, \{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~{\mathit{n}},\; \mathsf{offset}~{\mathit{m}} \}\end{array}) &\quad
  \mbox{if}~{2^{6}} \leq {\mathit{n}} < {2^{7}} \\
& {\mathtt{instr}} &::=& \dots \\ &&|&
\mathtt{0x28}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{i{\scriptstyle32}}.\mathsf{load}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x29}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{i{\scriptstyle64}}.\mathsf{load}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x2A}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{f{\scriptstyle32}}.\mathsf{load}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x2B}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{f{\scriptstyle64}}.\mathsf{load}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x2C}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{load}}{(8~\mathsf{\_}~\mathsf{s})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x2D}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{load}}{(8~\mathsf{\_}~\mathsf{u})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x2E}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{load}}{(16~\mathsf{\_}~\mathsf{s})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x2F}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{load}}{(16~\mathsf{\_}~\mathsf{u})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x30}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{load}}{(8~\mathsf{\_}~\mathsf{s})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x31}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{load}}{(8~\mathsf{\_}~\mathsf{u})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x32}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{load}}{(16~\mathsf{\_}~\mathsf{s})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x33}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{load}}{(16~\mathsf{\_}~\mathsf{u})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x34}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{load}}{(32~\mathsf{\_}~\mathsf{s})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x35}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{load}}{(32~\mathsf{\_}~\mathsf{u})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
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
\mathtt{0xA7} &\Rightarrow& \mathsf{cvtop}~\mathsf{i{\scriptstyle32}}~\mathsf{convert}~\mathsf{i{\scriptstyle64}} \\ &&|&
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
\mathtt{0xB6} &\Rightarrow& \mathsf{cvtop}~\mathsf{f{\scriptstyle32}}~\mathsf{convert}~\mathsf{f{\scriptstyle64}} \\ &&|&
\mathtt{0xB7} &\Rightarrow& \mathsf{f{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xB8} &\Rightarrow& \mathsf{f{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xB9} &\Rightarrow& \mathsf{f{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xBA} &\Rightarrow& \mathsf{f{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xBB} &\Rightarrow& \mathsf{cvtop}~\mathsf{f{\scriptstyle64}}~\mathsf{convert}~\mathsf{f{\scriptstyle32}} \\ &&|&
\mathtt{0xBC} &\Rightarrow& \mathsf{cvtop}~\mathsf{i{\scriptstyle32}}~\mathsf{reinterpret}~\mathsf{f{\scriptstyle32}} \\ &&|&
\mathtt{0xBD} &\Rightarrow& \mathsf{cvtop}~\mathsf{i{\scriptstyle64}}~\mathsf{reinterpret}~\mathsf{f{\scriptstyle64}} \\ &&|&
\mathtt{0xBE} &\Rightarrow& \mathsf{cvtop}~\mathsf{f{\scriptstyle32}}~\mathsf{reinterpret}~\mathsf{i{\scriptstyle32}} \\ &&|&
\mathtt{0xBF} &\Rightarrow& \mathsf{cvtop}~\mathsf{f{\scriptstyle64}}~\mathsf{reinterpret}~\mathsf{i{\scriptstyle64}} \\ &&|&
\mathtt{0xFC}~0{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{i{\scriptstyle32}} . {{{{\mathsf{convert\_sat}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFC}~1{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{i{\scriptstyle32}} . {{{{\mathsf{convert\_sat}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFC}~2{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{i{\scriptstyle32}} . {{{{\mathsf{convert\_sat}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFC}~3{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{i{\scriptstyle32}} . {{{{\mathsf{convert\_sat}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFC}~4{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert\_sat}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFC}~5{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert\_sat}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFC}~6{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert\_sat}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFC}~7{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert\_sat}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xC0} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{extend}}{8} \\ &&|&
\mathtt{0xC1} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{extend}}{16} \\ &&|&
\mathtt{0xC2} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{extend}}{8} \\ &&|&
\mathtt{0xC3} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{extend}}{16} \\ &&|&
\mathtt{0xC4} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{extend}}{32} \\ &&|&
\dots \\
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
& {{\mathtt{section}}}_{{\mathit{N}}}({\mathtt{X}}) &::=& {\mathit{N}}{:}{\mathtt{byte}}~{\mathit{sz}}{:}{\mathtt{u{\scriptstyle32}}}~{{\mathit{en}}^\ast}{:}{\mathtt{X}} &\Rightarrow& {{\mathit{en}}^\ast} &\quad
  \mbox{if}~{\mathit{sz}} = ||{\mathtt{X}}|| \\ &&|&
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
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{concat}}(\epsilon) &=& \epsilon &  \\
{\mathrm{concat}}(({{\mathit{loc}}^\ast})~{({{\mathit{loc}'}^\ast})^\ast}) &=& {{\mathit{loc}}^\ast}~{\mathrm{concat}}({({{\mathit{loc}'}^\ast})^\ast}) &  \\
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
& {\mathtt{code}} &::=& {\mathit{sz}}{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{code}}{:}{\mathtt{func}} &\Rightarrow& {\mathit{code}} &\quad
  \mbox{if}~{\mathit{sz}} = ||{\mathtt{func}}|| \\
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
& {\mathtt{module}} &::=& \mathtt{0x00}~\mathtt{0x61}~\mathtt{0x73}~\mathtt{0x6D}~1{:}{\mathtt{u{\scriptstyle32}}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{type}}^\ast}{:}{\mathtt{typesec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{import}}^\ast}{:}{\mathtt{importsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{typeidx}}^{{\mathit{n}}}}{:}{\mathtt{funcsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{table}}^\ast}{:}{\mathtt{tablesec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{mem}}^\ast}{:}{\mathtt{memsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{global}}^\ast}{:}{\mathtt{globalsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{export}}^\ast}{:}{\mathtt{exportsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{start}}^\ast}{:}{\mathtt{startsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{elem}}^\ast}{:}{\mathtt{elemsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{m}'}^\ast}{:}{\mathtt{datacntsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{({{\mathit{local}}^\ast},\, {\mathit{expr}})^{{\mathit{n}}}}{:}{\mathtt{codesec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{data}}^{{\mathit{m}}}}{:}{\mathtt{datasec}}~{{\mathtt{customsec}}^\ast} &\Rightarrow& \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^{{\mathit{n}}}}~{{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^{{\mathit{m}}}}~{{\mathit{start}}^\ast}~{{\mathit{export}}^\ast} &\quad
  \mbox{if}~{{\mathit{m}'}^\ast} = \epsilon \lor {\mathrm{free}}_{{\mathit{dataidx}}}({{\mathit{func}}^{{\mathit{n}}}}) = \epsilon \\
 &&&&&&\quad {\land}~{\mathit{m}} = {\mathrm{sum}}({{\mathit{m}'}^\ast}) \\
 &&&&&&\quad {\land}~(({\mathit{func}} = \mathsf{func}~{\mathit{typeidx}}~{{\mathit{local}}^\ast}~{\mathit{expr}}))^\ast \\
\end{array}
$$


```

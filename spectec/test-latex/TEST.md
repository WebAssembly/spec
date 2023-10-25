# Preview

```sh
$ (dune exec ../src/exe-watsup/main.exe -- ../spec/*.watsup)
$$
\begin{array}{@{}lrrl@{}}
& {\mathit{n}} &::=& {\mathit{nat}} \\
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
{\mathrm{min}}(0,\, {\mathit{j}}) &=& 0 &  \\
{\mathrm{min}}({\mathit{i}},\, 0) &=& 0 &  \\
{\mathrm{min}}({\mathit{i}} + 1,\, {\mathit{j}} + 1) &=& {\mathrm{min}}({\mathit{i}},\, {\mathit{j}}) &  \\
\end{array}
$$

\vspace{1ex}

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
\begin{array}{@{}lrrl@{}}
& {\mathit{testfuse}} &::=& {\mathsf{ab}}_{{\mathit{nat}}}\,\,{\mathit{nat}}~{\mathit{nat}} \\ &&|&
{\mathsf{cd}}_{{\mathit{nat}}}\,{\mathit{nat}}~{\mathit{nat}} \\ &&|&
{\mathsf{ef\_}}{{\mathit{nat}}}~{\mathit{nat}}~{\mathit{nat}} \\ &&|&
{{\mathsf{gh}}_{{\mathit{nat}}}}{{\mathit{nat}}}~{\mathit{nat}} \\ &&|&
{{\mathsf{ij}}_{{\mathit{nat}}}}{{\mathit{nat}}}~{\mathit{nat}} \\ &&|&
{\mathsf{kl\_ab}}{{\mathit{nat}}}~{\mathit{nat}}~{\mathit{nat}} \\ &&|&
{\mathsf{mn\_}}{\mathsf{ab}}~{\mathit{nat}}~{\mathit{nat}}~{\mathit{nat}} \\ &&|&
{{\mathsf{op\_}}{\mathsf{ab}}}{{\mathit{nat}}}~{\mathit{nat}}~{\mathit{nat}} \\ &&|&
{{\mathsf{qr}}_{{\mathit{nat}}}}{\mathsf{ab}}~{\mathit{nat}}~{\mathit{nat}} \\
\mbox{(name)} & {\mathit{name}} &::=& {\mathit{text}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(byte)} & {\mathit{byte}} &::=& {\mathit{nat}} \\
\mbox{(31-bit integer)} & {\mathit{i{\scriptstyle31}}} &::=& {\mathit{nat}} \\
\mbox{(32-bit integer)} & {\mathit{i{\scriptstyle32}}} &::=& {\mathit{nat}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(index)} & {\mathit{idx}} &::=& {\mathit{i{\scriptstyle32}}} \\
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

$$
\begin{array}{@{}lrrl@{}}
& {\mathit{nul}} &::=& {\mathsf{null}^?} \\
\mbox{(number type)} & {\mathit{numtype}} &::=& \mathsf{i{\scriptstyle32}} ~|~ \mathsf{i{\scriptstyle64}} ~|~ \mathsf{f{\scriptstyle32}} ~|~ \mathsf{f{\scriptstyle64}} \\
\mbox{(vector type)} & {\mathit{vectype}} &::=& \mathsf{v{\scriptstyle128}} \\
\mbox{(abstract heap type)} & {\mathit{absheaptype}} &::=& \mathsf{any} ~|~ \mathsf{eq} ~|~ \mathsf{i{\scriptstyle31}} ~|~ \mathsf{struct} ~|~ \mathsf{array} ~|~ \mathsf{none} \\ &&|&
\mathsf{func} ~|~ \mathsf{nofunc} \\ &&|&
\mathsf{extern} ~|~ \mathsf{noextern} \\ &&|&
\mathsf{bot} \\
\mbox{(heap type)} & {\mathit{heaptype}} &::=& {\mathit{absheaptype}} \\ &&|&
{\mathit{typeidx}} \\ &&|&
... \\
\mbox{(reference type)} & {\mathit{reftype}} &::=& \mathsf{ref}~{\mathit{nul}}~{\mathit{heaptype}} \\
\mbox{(value type)} & {\mathit{valtype}} &::=& {\mathit{numtype}} ~|~ {\mathit{vectype}} ~|~ {\mathit{reftype}} ~|~ \mathsf{bot} \\
& {{\mathsf{i}}{{\mathit{n}}}} &::=& \mathsf{i{\scriptstyle32}} ~|~ \mathsf{i{\scriptstyle64}} \\
& {{\mathsf{f}}{{\mathit{n}}}} &::=& \mathsf{f{\scriptstyle32}} ~|~ \mathsf{f{\scriptstyle64}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(result type)} & {\mathit{resulttype}} &::=& {{\mathit{valtype}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
& {\mathit{mut}} &::=& {\mathsf{mut}^?} \\
& {\mathit{fin}} &::=& {\mathsf{final}^?} \\
\mbox{(packed type)} & {\mathit{packedtype}} &::=& \mathsf{i{\scriptstyle8}} ~|~ \mathsf{i{\scriptstyle16}} \\
\mbox{(storage type)} & {\mathit{storagetype}} &::=& {\mathit{valtype}} ~|~ {\mathit{packedtype}} \\
\mbox{(field type)} & {\mathit{fieldtype}} &::=& {\mathit{mut}}~{\mathit{storagetype}} \\
\mbox{(function type)} & {\mathit{functype}} &::=& {\mathit{resulttype}} \rightarrow {\mathit{resulttype}} \\
\mbox{(composite type)} & {\mathit{comptype}} &::=& \mathsf{struct}~{{\mathit{fieldtype}}^\ast} \\ &&|&
\mathsf{array}~{\mathit{fieldtype}} \\ &&|&
\mathsf{func}~{\mathit{functype}} \\
\mbox{(sub type)} & {\mathit{subtype}} &::=& \mathsf{sub}~{\mathit{fin}}~{{\mathit{typeidx}}^\ast}~{\mathit{comptype}} ~|~ \mathsf{sub}~{\mathit{fin}}~{{\mathit{heaptype}}^\ast}~{\mathit{comptype}} \\
\mbox{(recursive type)} & {\mathit{rectype}} &::=& \mathsf{rec}~{{\mathit{subtype}}^\ast} \\
\mbox{(defined type)} & {\mathit{deftype}} &::=& {\mathit{rectype}} . {\mathit{nat}} \\
\mbox{(heap type)} & {\mathit{heaptype}} &::=& ... ~|~ {\mathit{deftype}} \\ &&|&
 \\ &&|&
\mathsf{rec}~{\mathit{nat}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(limits)} & {\mathit{limits}} &::=& [{\mathit{i{\scriptstyle32}}} .. {\mathit{i{\scriptstyle32}}}] \\
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

$$
\begin{array}{@{}lrrl@{}}
\mbox{(signedness)} & {\mathit{sx}} &::=& \mathsf{u} ~|~ \mathsf{s} \\
& {{\mathit{unop}}_{{\mathsf{ixx}}}} &::=& \mathsf{clz} ~|~ \mathsf{ctz} ~|~ \mathsf{popcnt} \\
& {{\mathit{unop}}_{{\mathsf{fxx}}}} &::=& \mathsf{abs} ~|~ \mathsf{neg} ~|~ \mathsf{sqrt} ~|~ \mathsf{ceil} ~|~ \mathsf{floor} ~|~ \mathsf{trunc} ~|~ \mathsf{nearest} \\
& {{\mathit{binop}}_{{\mathsf{ixx}}}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{mul} ~|~ {\mathsf{div\_}}{{\mathit{sx}}} ~|~ {\mathsf{rem\_}}{{\mathit{sx}}} \\ &&|&
\mathsf{and} ~|~ \mathsf{or} ~|~ \mathsf{xor} ~|~ \mathsf{shl} ~|~ {\mathsf{shr\_}}{{\mathit{sx}}} ~|~ \mathsf{rotl} ~|~ \mathsf{rotr} \\
& {{\mathit{binop}}_{{\mathsf{fxx}}}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{mul} ~|~ \mathsf{div} ~|~ \mathsf{min} ~|~ \mathsf{max} ~|~ \mathsf{copysign} \\
& {{\mathit{testop}}_{{\mathsf{ixx}}}} &::=& \mathsf{eqz} \\
& {{\mathit{testop}}_{{\mathsf{fxx}}}} &::=&  \\
& {{\mathit{relop}}_{{\mathsf{ixx}}}} &::=& \mathsf{eq} ~|~ \mathsf{ne} ~|~ {\mathsf{lt\_}}{{\mathit{sx}}} ~|~ {\mathsf{gt\_}}{{\mathit{sx}}} ~|~ {\mathsf{le\_}}{{\mathit{sx}}} ~|~ {\mathsf{ge\_}}{{\mathit{sx}}} \\
& {{\mathit{refop}}_{{\mathsf{fxx}}}} &::=& \mathsf{eq} ~|~ \mathsf{ne} ~|~ \mathsf{lt} ~|~ \mathsf{gt} ~|~ \mathsf{le} ~|~ \mathsf{ge} \\
& {\mathit{unop}}_{{\mathit{numtype}}} &::=& {{\mathit{unop}}_{{\mathsf{ixx}}}} ~|~ {{\mathit{unop}}_{{\mathsf{fxx}}}} \\
& {\mathit{binop}}_{{\mathit{numtype}}} &::=& {{\mathit{binop}}_{{\mathsf{ixx}}}} ~|~ {{\mathit{binop}}_{{\mathsf{fxx}}}} \\
& {\mathit{testop}}_{{\mathit{numtype}}} &::=& {{\mathit{testop}}_{{\mathsf{ixx}}}} ~|~ {{\mathit{testop}}_{{\mathsf{fxx}}}} \\
& {\mathit{relop}}_{{\mathit{numtype}}} &::=& {{\mathit{relop}}_{{\mathsf{ixx}}}} ~|~ {{\mathit{refop}}_{{\mathsf{fxx}}}} \\
& {\mathit{cvtop}} &::=& \mathsf{convert} ~|~ \mathsf{reinterpret} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
& {\mathit{c}}_{{\mathit{numtype}}} &::=& {\mathit{nat}} \\
& {\mathit{c}}_{{\mathit{vectype}}} &::=& {\mathit{nat}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}}
\mbox{(block type)} & {\mathit{blocktype}} &::=& {\mathit{functype}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}}
\mbox{(instruction)} & {\mathit{instr}} &::=& \mathsf{unreachable} \\ &&|&
\mathsf{nop} \\ &&|&
\mathsf{drop} \\ &&|&
\mathsf{select}~{{\mathit{valtype}}^?} \\ &&|&
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
\mathsf{call\_ref}~{\mathit{typeidx}} \\ &&|&
\mathsf{call\_indirect}~{\mathit{tableidx}}~{\mathit{typeidx}} \\ &&|&
\mathsf{return} \\ &&|&
\mathsf{return\_call}~{\mathit{funcidx}} \\ &&|&
\mathsf{return\_call\_ref}~{\mathit{typeidx}} \\ &&|&
\mathsf{return\_call\_indirect}~{\mathit{tableidx}}~{\mathit{typeidx}} \\ &&|&
{\mathit{numtype}}.\mathsf{const}~{\mathit{c}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {\mathit{unop}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {\mathit{binop}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {\mathit{testop}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {\mathit{relop}}_{{\mathit{numtype}}} \\ &&|&
{{\mathit{numtype}}.\mathsf{extend}}{{\mathit{n}}} \\ &&|&
{\mathit{numtype}} . {{{{{\mathit{cvtop}}}{\mathsf{\_}}}{{\mathit{numtype}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}} \\ &&|&
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
{{\mathsf{struct.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{typeidx}}~{\mathit{i{\scriptstyle32}}} \\ &&|&
\mathsf{struct.set}~{\mathit{typeidx}}~{\mathit{i{\scriptstyle32}}} \\ &&|&
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
\mathsf{extern.internalize} \\ &&|&
\mathsf{extern.externalize} \\ &&|&
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
\mathsf{memory.size}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.grow}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.fill}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.copy}~{\mathit{memidx}}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.init}~{\mathit{memidx}}~{\mathit{dataidx}} \\ &&|&
\mathsf{data.drop}~{\mathit{dataidx}} \\ &&|&
{{\mathit{numtype}}.\mathsf{load}}{{({{{\mathit{n}}}{\mathsf{\_}}}{{\mathit{sx}}})^?}}~{\mathit{memidx}}~{\mathit{i{\scriptstyle32}}}~{\mathit{i{\scriptstyle32}}} \\ &&|&
{{\mathit{numtype}}.\mathsf{store}}{{{\mathit{n}}^?}}~{\mathit{memidx}}~{\mathit{i{\scriptstyle32}}}~{\mathit{i{\scriptstyle32}}} \\
\mbox{(expression)} & {\mathit{expr}} &::=& {{\mathit{instr}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
& {\mathit{elemmode}} &::=& \mathsf{table}~{\mathit{tableidx}}~{\mathit{expr}} ~|~ \mathsf{declare} \\
& {\mathit{datamode}} &::=& \mathsf{memory}~{\mathit{memidx}}~{\mathit{expr}} \\
\mbox{(type definition)} & {\mathit{type}} &::=& \mathsf{type}~{\mathit{rectype}} \\
\mbox{(local)} & {\mathit{local}} &::=& \mathsf{local}~{\mathit{valtype}} \\
\mbox{(function)} & {\mathit{func}} &::=& \mathsf{func}~{\mathit{typeidx}}~{{\mathit{local}}^\ast}~{\mathit{expr}} \\
\mbox{(global)} & {\mathit{global}} &::=& \mathsf{global}~{\mathit{globaltype}}~{\mathit{expr}} \\
\mbox{(table)} & {\mathit{table}} &::=& \mathsf{table}~{\mathit{tabletype}}~{\mathit{expr}} \\
\mbox{(memory)} & {\mathit{mem}} &::=& \mathsf{memory}~{\mathit{memtype}} \\
\mbox{(table segment)} & {\mathit{elem}} &::=& \mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}^\ast}~{{\mathit{elemmode}}^?} \\
\mbox{(memory segment)} & {\mathit{data}} &::=& \mathsf{data}~{{\mathit{byte}}^\ast}~{{\mathit{datamode}}^?} \\
\mbox{(start function)} & {\mathit{start}} &::=& \mathsf{start}~{\mathit{funcidx}} \\
\mbox{(external use)} & {\mathit{externuse}} &::=& \mathsf{func}~{\mathit{funcidx}} ~|~ \mathsf{global}~{\mathit{globalidx}} ~|~ \mathsf{table}~{\mathit{tableidx}} ~|~ \mathsf{mem}~{\mathit{memidx}} \\
\mbox{(export)} & {\mathit{export}} &::=& \mathsf{export}~{\mathit{name}}~{\mathit{externuse}} \\
\mbox{(import)} & {\mathit{import}} &::=& \mathsf{import}~{\mathit{name}}~{\mathit{name}}~{\mathit{externtype}} \\
\mbox{(module)} & {\mathit{module}} &::=& \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\epsilon \setminus {{\mathit{y}}^\ast} &=& \epsilon &  \\
{\mathit{x}}_{{1}}~{{\mathit{x}}^\ast} \setminus {{\mathit{y}}^\ast} &=& {\mathrm{setminus{\scriptstyle1}}}({\mathit{x}}_{{1}},\, {{\mathit{y}}^\ast})~{{\mathit{x}}^\ast} \setminus {{\mathit{y}}^\ast} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{setminus{\scriptstyle1}}}({\mathit{x}},\, \epsilon) &=& {\mathit{x}} &  \\
{\mathrm{setminus{\scriptstyle1}}}({\mathit{x}},\, {\mathit{y}}_{{1}}~{{\mathit{y}}^\ast}) &=& \epsilon &\quad
  \mbox{if}~{\mathit{x}} = {\mathit{y}}_{{1}} \\
{\mathrm{setminus{\scriptstyle1}}}({\mathit{x}},\, {\mathit{y}}_{{1}}~{{\mathit{y}}^\ast}) &=& {\mathrm{setminus{\scriptstyle1}}}({\mathit{x}},\, {{\mathit{y}}^\ast}) &\quad
  \mbox{otherwise} \\
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
\begin{array}{@{}lrrl@{}}
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
{{\mathit{ht}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {\mathit{ht}} &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{ref}~{\mathit{nul}}~{\mathit{ht}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{ref}~{\mathit{nul}}~{{\mathit{ht}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
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

$$
\begin{array}{@{}lrrl@{}}
\mbox{(address)} & {\mathit{addr}} &::=& {\mathit{nat}} \\
\mbox{(function address)} & {\mathit{funcaddr}} &::=& {\mathit{addr}} \\
\mbox{(global address)} & {\mathit{globaladdr}} &::=& {\mathit{addr}} \\
\mbox{(table address)} & {\mathit{tableaddr}} &::=& {\mathit{addr}} \\
\mbox{(memory address)} & {\mathit{memaddr}} &::=& {\mathit{addr}} \\
\mbox{(elem address)} & {\mathit{elemaddr}} &::=& {\mathit{addr}} \\
\mbox{(data address)} & {\mathit{dataaddr}} &::=& {\mathit{addr}} \\
\mbox{(label address)} & {\mathit{labeladdr}} &::=& {\mathit{addr}} \\
\mbox{(host address)} & {\mathit{hostaddr}} &::=& {\mathit{addr}} \\
\mbox{(structure address)} & {\mathit{structaddr}} &::=& {\mathit{addr}} \\
\mbox{(array address)} & {\mathit{arrayaddr}} &::=& {\mathit{addr}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(number)} & {\mathit{num}} &::=& {\mathit{numtype}}.\mathsf{const}~{\mathit{c}}_{{\mathit{numtype}}} \\
\mbox{(address reference)} & {\mathit{addrref}} &::=& \mathsf{ref.i{\scriptstyle31}}~{\mathit{i{\scriptstyle31}}} \\ &&|&
\mathsf{ref.struct}~{\mathit{structaddr}} \\ &&|&
\mathsf{ref.array}~{\mathit{arrayaddr}} \\ &&|&
\mathsf{ref.func}~{\mathit{funcaddr}} \\ &&|&
\mathsf{ref.host}~{\mathit{hostaddr}} \\ &&|&
\mathsf{ref.extern}~{\mathit{addrref}} \\
\mbox{(reference)} & {\mathit{ref}} &::=& {\mathit{addrref}} ~|~ \mathsf{ref.null}~{\mathit{heaptype}} \\ &&|&
 \\
\mbox{(value)} & {\mathit{val}} &::=& {\mathit{num}} ~|~ {\mathit{ref}} \\
\mbox{(result)} & {\mathit{result}} &::=& {{\mathit{val}}^\ast} ~|~ \mathsf{trap} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(external value)} & {\mathit{externval}} &::=& \mathsf{func}~{\mathit{funcaddr}} ~|~ \mathsf{global}~{\mathit{globaladdr}} ~|~ \mathsf{table}~{\mathit{tableaddr}} ~|~ \mathsf{mem}~{\mathit{memaddr}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
& {\mathit{c}}_{{\mathit{packedtype}}} &::=& {\mathit{nat}} \\
\mbox{(function instance)} & {\mathit{funcinst}} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{deftype}},\; \\
  \mathsf{module}~{\mathit{moduleinst}},\; \\
  \mathsf{code}~{\mathit{func}} \;\}\end{array} \\
\mbox{(global instance)} & {\mathit{globalinst}} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{globaltype}},\; \\
  \mathsf{value}~{\mathit{val}} \;\}\end{array} \\
\mbox{(table instance)} & {\mathit{tableinst}} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{tabletype}},\; \\
  \mathsf{elem}~{{\mathit{ref}}^\ast} \;\}\end{array} \\
\mbox{(memory instance)} & {\mathit{meminst}} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{memtype}},\; \\
  \mathsf{data}~{{\mathit{byte}}^\ast} \;\}\end{array} \\
\mbox{(element instance)} & {\mathit{eleminst}} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{elemtype}},\; \\
  \mathsf{elem}~{{\mathit{ref}}^\ast} \;\}\end{array} \\
\mbox{(data instance)} & {\mathit{datainst}} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{data}~{{\mathit{byte}}^\ast} \;\}\end{array} \\
\mbox{(export instance)} & {\mathit{exportinst}} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \\
  \mathsf{value}~{\mathit{externval}} \;\}\end{array} \\
\mbox{(packed value)} & {\mathit{packedval}} &::=& {\mathit{packedtype}}.\mathsf{pack}~{\mathit{c}}_{{\mathit{packedtype}}} \\
\mbox{(field value)} & {\mathit{fieldval}} &::=& {\mathit{val}} ~|~ {\mathit{packedval}} \\
\mbox{(structure instance)} & {\mathit{structinst}} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{deftype}},\; \\
  \mathsf{field}~{{\mathit{fieldval}}^\ast} \;\}\end{array} \\
\mbox{(array instance)} & {\mathit{arrayinst}} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{deftype}},\; \\
  \mathsf{field}~{{\mathit{fieldval}}^\ast} \;\}\end{array} \\
\mbox{(module instance)} & {\mathit{moduleinst}} &::=& \{\; \begin{array}[t]{@{}l@{}}
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
\begin{array}{@{}lrrl@{}}
\mbox{(store)} & {\mathit{store}} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{func}~{{\mathit{funcinst}}^\ast},\; \\
  \mathsf{global}~{{\mathit{globalinst}}^\ast},\; \\
  \mathsf{table}~{{\mathit{tableinst}}^\ast},\; \\
  \mathsf{mem}~{{\mathit{meminst}}^\ast},\; \\
  \mathsf{elem}~{{\mathit{eleminst}}^\ast},\; \\
  \mathsf{data}~{{\mathit{datainst}}^\ast},\; \\
  \mathsf{struct}~{{\mathit{structinst}}^\ast},\; \\
  \mathsf{array}~{{\mathit{arrayinst}}^\ast} \;\}\end{array} \\
\mbox{(frame)} & {\mathit{frame}} &::=& \{\; \begin{array}[t]{@{}l@{}}
\mathsf{local}~{({{\mathit{val}}^?})^\ast},\; \\
  \mathsf{module}~{\mathit{moduleinst}} \;\}\end{array} \\
\mbox{(state)} & {\mathit{state}} &::=& {\mathit{store}} ; {\mathit{frame}} \\
\mbox{(configuration)} & {\mathit{config}} &::=& {\mathit{state}} ; {{{\mathit{instr}}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(administrative instruction)} & {{\mathit{instr}}} &::=& {\mathit{instr}} \\ &&|&
{\mathit{addrref}} \\ &&|&
{{\mathsf{label}}_{{\mathit{n}}}}{\{{{\mathit{instr}}^\ast}\}}~{{{\mathit{instr}}}^\ast} \\ &&|&
{{\mathsf{frame}}_{{\mathit{n}}}}{\{{\mathit{frame}}\}}~{{{\mathit{instr}}}^\ast} \\ &&|&
\mathsf{trap} \\
\mbox{(evaluation context)} & {\mathit{E}} &::=& [\mathsf{\_}] \\ &&|&
{{\mathit{val}}^\ast}~{\mathit{E}}~{{\mathit{instr}}^\ast} \\ &&|&
{{\mathsf{label}}_{{\mathit{n}}}}{\{{{\mathit{instr}}^\ast}\}}~{\mathit{E}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{inst}}}_{{\mathit{mm}}}({\mathit{rt}}) &=& {{\mathit{rt}}}{[{ := }\;{{\mathit{dt}}^\ast}]} &\quad
  \mbox{if}~{{\mathit{dt}}^\ast} = {\mathit{mm}}.\mathsf{type} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{default}}}_{\mathsf{i{\scriptstyle32}}} &=& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) &  \\
{{\mathrm{default}}}_{\mathsf{i{\scriptstyle64}}} &=& (\mathsf{i{\scriptstyle64}}.\mathsf{const}~0) &  \\
{{\mathrm{default}}}_{\mathsf{f{\scriptstyle32}}} &=& (\mathsf{f{\scriptstyle32}}.\mathsf{const}~0) &  \\
{{\mathrm{default}}}_{\mathsf{f{\scriptstyle64}}} &=& (\mathsf{f{\scriptstyle64}}.\mathsf{const}~0) &  \\
{{\mathrm{default}}}_{\mathsf{ref}~\mathsf{null}~{\mathit{ht}}} &=& (\mathsf{ref.null}~{\mathit{ht}}) &  \\
{{\mathrm{default}}}_{\mathsf{ref}~\epsilon~{\mathit{ht}}} &=& \epsilon &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{pack}}}_{{\mathit{t}}}({\mathit{val}}) &=& {\mathit{val}} &  \\
{{\mathrm{pack}}}_{{\mathit{pt}}}(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}) &=& {\mathit{pt}}.\mathsf{pack}~{{{\mathrm{wrap}}}_{32,{|{\mathit{pt}}|}}}{({\mathit{i}})} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{{\mathrm{unpack}}}_{{\mathit{t}}}^{\epsilon}}}{({\mathit{val}})} &=& {\mathit{val}} &  \\
{{{{\mathrm{unpack}}}_{{\mathit{pt}}}^{{\mathit{sx}}}}}{({\mathit{pt}}.\mathsf{pack}~{\mathit{i}})} &=& \mathsf{i{\scriptstyle32}}.\mathsf{const}~{{{{\mathrm{ext}}}_{{|{\mathit{pt}}|},32}^{{\mathit{sx}}}}}{({\mathit{i}})} &  \\
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
{\mathrm{with}}_{{\mathit{struct}}}(({\mathit{s}} ; {\mathit{f}}),\, {\mathit{a}},\, {\mathit{i}},\, {\mathit{fv}}) &=& {\mathit{s}}[\mathsf{struct}[{\mathit{a}}].\mathsf{field}[{\mathit{i}}] = {\mathit{fv}}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{with}}_{{\mathit{array}}}(({\mathit{s}} ; {\mathit{f}}),\, {\mathit{a}},\, {\mathit{i}},\, {\mathit{fv}}) &=& {\mathit{s}}[\mathsf{array}[{\mathit{a}}].\mathsf{field}[{\mathit{i}}] = {\mathit{fv}}] ; {\mathit{f}} &  \\
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
{\mathrm{growtable}}({\mathit{ti}},\, {\mathit{n}},\, {\mathit{r}}) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{tt}'},\; \mathsf{elem}~{{\mathit{r}'}^\ast}~{{\mathit{r}}^{{\mathit{n}}}} \}\end{array} &\quad
  \mbox{if}~{\mathit{ti}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([{\mathit{i}} .. {\mathit{j}}]~{\mathit{rt}}),\; \mathsf{elem}~{{\mathit{r}'}^\ast} \}\end{array} \\
 &&&\quad {\land}~{\mathit{tt}'} = [({\mathit{i}} + {\mathit{n}}) .. {\mathit{j}}]~{\mathit{rt}} \\
 &&&\quad {\land}~{\mathit{i}} + {\mathit{n}} \leq {\mathit{j}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{growmemory}}({\mathit{mi}},\, {\mathit{n}}) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{mt}'},\; \mathsf{data}~{{\mathit{b}}^\ast}~{0^{{\mathit{n}} \cdot 64 \cdot {\mathrm{Ki}}}} \}\end{array} &\quad
  \mbox{if}~{\mathit{mi}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([{\mathit{i}} .. {\mathit{j}}]~\mathsf{i{\scriptstyle8}}),\; \mathsf{data}~{{\mathit{b}}^\ast} \}\end{array} \\
 &&&\quad {\land}~{\mathit{mt}'} = [({\mathit{i}} + {\mathit{n}}) .. {\mathit{j}}]~\mathsf{i{\scriptstyle8}} \\
 &&&\quad {\land}~{\mathit{i}} + {\mathit{n}} \leq {\mathit{j}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}}
\mbox{(initialization status)} & {\mathit{init}} &::=& \mathsf{set} ~|~ \mathsf{unset} \\
\mbox{(local type)} & {\mathit{localtype}} &::=& {\mathit{init}}~{\mathit{valtype}} \\
\mbox{(instruction type)} & {\mathit{instrtype}} &::=& {\mathit{resulttype}} \rightarrow {{\mathit{localidx}}^\ast}~{\mathit{resulttype}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}}
\mbox{(context)} & {\mathit{context}} &::=& \{\; \begin{array}[t]{@{}l@{}}
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
{{\mathrm{clos}}}_{{\mathit{C}}}~({\mathit{dt}}) &=& {{\mathit{dt}}}{[{ := }\;{{\mathit{dt}'}^\ast}]} &\quad
  \mbox{if}~{{\mathit{dt}'}^\ast} = {\mathrm{clos}}{}^\ast~({\mathit{C}}.\mathsf{type}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{clos}}{}^\ast~(\epsilon) &=& \epsilon &  \\
{\mathrm{clos}}{}^\ast~({{\mathit{dt}}^\ast}~{\mathit{dt}}_{{\mathsf{n}}}) &=& {{\mathit{dt}'}^\ast}~{{\mathit{dt}}_{{\mathsf{n}}}}{[{ := }\;{{\mathit{dt}'}^\ast}]} &\quad
  \mbox{if}~{{\mathit{dt}'}^\ast} = {\mathrm{clos}}{}^\ast~({{\mathit{dt}}^\ast}) \\
\end{array}
$$

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
\begin{array}{@{}lrrl@{}}
& {{\mathsf{ok}}{({\mathit{typeidx}})}} &::=& {\mathsf{ok}}{({\mathit{typeidx}})} \\
& {{\mathsf{ok}}{({\mathit{typeidx}},\, {\mathit{n}})}} &::=& {\mathsf{ok}}{({\mathit{typeidx}},\, {\mathit{nat}})} \\
\end{array}
$$

$\boxed{{\mathit{context}} \vdash {\mathit{packedtype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{fieldtype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{storagetype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{comptype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{functype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{subtype}} : {{\mathsf{ok}}{({\mathit{typeidx}})}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{rectype}} : {{\mathsf{ok}}{({\mathit{typeidx}})}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{subtype}} : {{\mathsf{ok}}{({\mathit{typeidx}},\, {\mathit{n}})}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{rectype}} : {{\mathsf{ok}}{({\mathit{typeidx}},\, {\mathit{n}})}}}$

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
(({\mathrm{unroll}}({\mathit{C}}.\mathsf{type}[{\mathit{y}}]) = \mathsf{sub}~\epsilon~{{\mathit{y}'}^\ast}~{\mathit{ct}'}))^\ast
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
{|{{\mathit{y}}^\ast}|} \leq 1
 \qquad
(({\mathit{ht}} \prec {\mathit{x}}, {\mathit{i}}))^\ast
 \qquad
(({{\mathrm{unroll}}}_{{\mathit{C}}}({\mathit{ht}}) = \mathsf{sub}~\epsilon~{{\mathit{ht}'}^\ast}~{\mathit{ct}'}))^\ast
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
{\mathit{C}} \vdash \mathsf{ref}~\epsilon~{\mathit{ht}}_{{1}} \leq \mathsf{ref}~\epsilon~{\mathit{ht}}_{{2}}
} \, {[\textsc{\scriptsize S{-}ref{-}nonnull}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{ht}}_{{1}} \leq {\mathit{ht}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{ref}~{\mathit{nul}}~{\mathit{ht}}_{{1}} \leq \mathsf{ref}~\mathsf{null}~{\mathit{ht}}_{{2}}
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
{\mathit{C}} \vdash \epsilon~{\mathit{zt}}_{{1}} \leq \epsilon~{\mathit{zt}}_{{2}}
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
{{\mathrm{clos}}}_{{\mathit{C}}}~({\mathit{deftype}}_{{1}}) = {{\mathrm{clos}}}_{{\mathit{C}}}~({\mathit{deftype}}_{{2}})
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
{\mathit{C}} \vdash \epsilon~{\mathit{t}}_{{1}} \leq \epsilon~{\mathit{t}}_{{2}}
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
{\mathit{C}} \vdash {\mathit{ft}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathit{ft}} : {\mathit{ft}}
} \, {[\textsc{\scriptsize K{-}block}]}
\qquad
\end{array}
$$

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
{\mathit{C}} \vdash \mathsf{br\_on\_null}~{\mathit{l}} : {{\mathit{t}}^\ast}~(\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \rightarrow {{\mathit{t}}^\ast}~(\mathsf{ref}~\epsilon~{\mathit{ht}})
} \, {[\textsc{\scriptsize T{-}br\_on\_null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{label}[{\mathit{l}}] = {{\mathit{t}}^\ast}~(\mathsf{ref}~\epsilon~{\mathit{ht}})
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
{\mathit{C}} \vdash \mathsf{br\_on\_cast}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}} : {{\mathit{t}}^\ast}~{\mathit{rt}}_{{1}} \rightarrow {{\mathit{t}}^\ast}~{\mathit{rt}}_{{2}}
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
{\mathit{C}} \vdash \mathsf{ref.func}~{\mathit{x}} : \epsilon \rightarrow (\mathsf{ref}~\epsilon~{\mathit{dt}})
} \, {[\textsc{\scriptsize T{-}ref.func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{ref.i{\scriptstyle31}} : \mathsf{i{\scriptstyle32}} \rightarrow (\mathsf{ref}~\epsilon~\mathsf{i{\scriptstyle31}})
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
{\mathit{C}} \vdash \mathsf{ref.as\_non\_null} : (\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \rightarrow (\mathsf{ref}~\epsilon~{\mathit{ht}})
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
{\mathit{C}} \vdash \mathsf{struct.new}~{\mathit{x}} : {{\mathrm{unpack}}({\mathit{zt}})^\ast} \rightarrow (\mathsf{ref}~\epsilon~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}struct.new}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{struct}~{({\mathit{mut}}~{\mathit{zt}})^\ast}
 \qquad
(({{\mathrm{default}}}_{{\mathrm{unpack}}({\mathit{zt}})} = {\mathit{val}}))^\ast
}{
{\mathit{C}} \vdash \mathsf{struct.new\_default}~{\mathit{x}} : {{\mathrm{unpack}}({\mathit{zt}})^\ast} \rightarrow (\mathsf{ref}~\epsilon~{\mathit{x}})
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
{\mathit{C}} \vdash \mathsf{array.new}~{\mathit{x}} : {\mathrm{unpack}}({\mathit{zt}})~\mathsf{i{\scriptstyle32}} \rightarrow (\mathsf{ref}~\epsilon~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}array.new}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})
 \qquad
{{\mathrm{default}}}_{{\mathrm{unpack}}({\mathit{zt}})} = {\mathit{val}}
}{
{\mathit{C}} \vdash \mathsf{array.new\_default}~{\mathit{x}} : \mathsf{i{\scriptstyle32}} \rightarrow (\mathsf{ref}~\epsilon~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}array.new\_default}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})
}{
{\mathit{C}} \vdash \mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}} : {\mathrm{unpack}}({\mathit{zt}}) \rightarrow (\mathsf{ref}~\epsilon~{\mathit{x}})
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
{\mathit{C}} \vdash \mathsf{array.new\_elem}~{\mathit{x}}~{\mathit{y}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow (\mathsf{ref}~\epsilon~{\mathit{x}})
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
{\mathit{C}} \vdash \mathsf{array.new\_data}~{\mathit{x}}~{\mathit{y}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow (\mathsf{ref}~\epsilon~{\mathit{x}})
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
{\mathit{C}} \vdash \mathsf{extern.externalize} : (\mathsf{ref}~{\mathit{nul}}~\mathsf{any}) \rightarrow (\mathsf{ref}~{\mathit{nul}}~\mathsf{extern})
} \, {[\textsc{\scriptsize T{-}extern.externalize}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{extern.internalize} : (\mathsf{ref}~{\mathit{nul}}~\mathsf{extern}) \rightarrow (\mathsf{ref}~{\mathit{nul}}~\mathsf{any})
} \, {[\textsc{\scriptsize T{-}extern.internalize}]}
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
{{\mathit{n}}^?} = \epsilon \lor {\mathit{nt}} = {{\mathsf{i}}{{\mathit{n}}}}
}{
{\mathit{C}} \vdash {{\mathit{nt}}.\mathsf{load}}{{({{{\mathit{n}}}{\mathsf{\_}}}{{\mathit{sx}}})^?}}~{\mathit{x}}~{\mathit{n}}_{{\mathsf{a}}}~{\mathit{n}}_{{\mathsf{o}}} : \mathsf{i{\scriptstyle32}} \rightarrow {\mathit{nt}}
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
{{\mathit{n}}^?} = \epsilon \lor {\mathit{nt}} = {{\mathsf{i}}{{\mathit{n}}}}
}{
{\mathit{C}} \vdash {{\mathit{nt}}.\mathsf{store}}{{{\mathit{n}}^?}}~{\mathit{x}}~{\mathit{n}}_{{\mathsf{a}}}~{\mathit{n}}_{{\mathsf{o}}} : \mathsf{i{\scriptstyle32}}~{\mathit{nt}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}store}]}
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
{\mathit{C}}.\mathsf{global}[{\mathit{x}}] = \epsilon~{\mathit{t}}
}{
{\mathit{C}} \vdash (\mathsf{global.get}~{\mathit{x}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}global.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{nt}}\in\epsilon &=& \mathsf{false} &  \\
{\mathit{nt}}\in{\mathit{nt}}_{{1}}~{{\mathit{nt}'}^\ast} &=& {\mathit{nt}} = {\mathit{nt}}_{{1}} \lor {\mathit{nt}}\in{{\mathit{nt}'}^\ast} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{binop}}\in\epsilon &=& \mathsf{false} &  \\
{\mathit{binop}}\in{{\mathit{binop}}_{{\mathsf{ixx}}}}_{{1}}~{{{\mathit{binop}}_{{\mathsf{ixx}}}'}^\ast} &=& {\mathit{binop}} = {{\mathit{binop}}_{{\mathsf{ixx}}}}_{{1}} \lor {\mathit{binop}}\in{{{\mathit{binop}}_{{\mathsf{ixx}}}'}^\ast} &  \\
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{nt}}\in\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle64}}
 \qquad
{\mathit{binop}}\in\mathsf{add}~\mathsf{sub}~\mathsf{mul}
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
}{
{\mathit{C}} \vdash \mathsf{table}~{\mathit{tt}} : {\mathit{tt}}
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
({\mathit{C}} \vdash {\mathit{expr}} : {\mathit{rt}})^\ast
 \qquad
({\mathit{C}} \vdash {\mathit{elemmode}} : {\mathit{rt}})^?
}{
{\mathit{C}} \vdash \mathsf{elem}~{\mathit{rt}}~{{\mathit{expr}}^\ast}~{{\mathit{elemmode}}^?} : {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}elem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{C}} \vdash {\mathit{datamode}} : \mathsf{ok})^?
}{
{\mathit{C}} \vdash \mathsf{data}~{{\mathit{b}}^\ast}~{{\mathit{datamode}}^?} : \mathsf{ok}
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
{\mathit{C}} \vdash \mathsf{table}~{\mathit{x}}~{\mathit{expr}} : {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}elemmode{-}active}]}
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
{\mathit{C}} \vdash \mathsf{memory}~{\mathit{x}}~{\mathit{expr}} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}datamode}]}
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

$\boxed{{\mathit{context}} \vdash {\mathit{externuse}} : {\mathit{externtype}}}$

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
{\mathit{C}} \vdash {\mathit{externuse}} : {\mathit{xt}}
}{
{\mathit{C}} \vdash \mathsf{export}~{\mathit{name}}~{\mathit{externuse}} : {\mathit{xt}}
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
} \, {[\textsc{\scriptsize T{-}externuse{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{global}[{\mathit{x}}] = {\mathit{gt}}
}{
{\mathit{C}} \vdash \mathsf{global}~{\mathit{x}} : \mathsf{global}~{\mathit{gt}}
} \, {[\textsc{\scriptsize T{-}externuse{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{tt}}
}{
{\mathit{C}} \vdash \mathsf{table}~{\mathit{x}} : \mathsf{table}~{\mathit{tt}}
} \, {[\textsc{\scriptsize T{-}externuse{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
}{
{\mathit{C}} \vdash \mathsf{mem}~{\mathit{x}} : \mathsf{mem}~{\mathit{mt}}
} \, {[\textsc{\scriptsize T{-}externuse{-}mem}]}
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

$\boxed{{{{\mathit{instr}}}^\ast} \hookrightarrow {{{\mathit{instr}}}^\ast}}$

$\boxed{{\mathit{config}} \hookrightarrow {{{\mathit{instr}}}^\ast}}$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}pure}]} \quad & {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow& {\mathit{z}} ; {{\mathit{instr}'}^\ast} &\quad
  \mbox{if}~{{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\
{[\textsc{\scriptsize E{-}read}]} \quad & {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow& {\mathit{z}} ; {{\mathit{instr}'}^\ast} &\quad
  \mbox{if}~{\mathit{z}} ; {{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{config}} \hookrightarrow^\ast {\mathit{state}} ; {{\mathit{val}}^\ast}}$

$\boxed{{\mathit{state}} ; {\mathit{expr}} \hookrightarrow^\ast {\mathit{state}} ; {{\mathit{val}}^\ast}}$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}expr{-}done}]} \quad & {\mathit{z}} ; {{\mathit{val}}^\ast} &\hookrightarrow^\ast& {\mathit{z}} ; {{\mathit{val}}^\ast} &  \\
{[\textsc{\scriptsize E{-}expr{-}step}]} \quad & {\mathit{z}} ; {{{\mathit{instr}}}^\ast} &\hookrightarrow^\ast& {\mathit{z}''} ; {{\mathit{val}}^\ast} &\quad
  \mbox{if}~{\mathit{z}} ; {{{\mathit{instr}}}^\ast} \hookrightarrow {\mathit{z}'} ; {{{\mathit{instr}}'}^\ast} \\
 &&&&\quad {\land}~{\mathit{z}'} ; {{\mathit{instr}}'} \hookrightarrow^\ast {\mathit{z}''} ; {{\mathit{val}}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}expr}]} \quad & {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow^\ast& {\mathit{z}'} ; {{\mathit{val}}^\ast} &\quad
  \mbox{if}~{\mathit{z}} ; {{\mathit{instr}}^\ast} \hookrightarrow^\ast {\mathit{z}} ; {{\mathit{val}}^\ast} \\
\end{array}
$$

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
{[\textsc{\scriptsize E{-}select{-}true}]} \quad & {\mathit{val}}_{{1}}~{\mathit{val}}_{{2}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{select}~{{\mathit{t}}^?}) &\hookrightarrow& {\mathit{val}}_{{1}} &\quad
  \mbox{if}~{\mathit{c}} \neq 0 \\
{[\textsc{\scriptsize E{-}select{-}false}]} \quad & {\mathit{val}}_{{1}}~{\mathit{val}}_{{2}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{select}~{{\mathit{t}}^?}) &\hookrightarrow& {\mathit{val}}_{{2}} &\quad
  \mbox{if}~{\mathit{c}} = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}block}]} \quad & {{\mathit{val}}^{{\mathit{k}}}}~(\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{{\mathit{n}}}}{\{\epsilon\}}~{{\mathit{val}}^{{\mathit{k}}}}~{{\mathit{instr}}^\ast}) &\quad
  \mbox{if}~{\mathit{bt}} = {{\mathit{t}}_{{1}}^{{\mathit{k}}}} \rightarrow {{\mathit{t}}_{{2}}^{{\mathit{n}}}} \\
{[\textsc{\scriptsize E{-}loop}]} \quad & {{\mathit{val}}^{{\mathit{k}}}}~(\mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{{\mathit{k}}}}{\{\mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast}\}}~{{\mathit{val}}^{{\mathit{k}}}}~{{\mathit{instr}}^\ast}) &\quad
  \mbox{if}~{\mathit{bt}} = {{\mathit{t}}_{{1}}^{{\mathit{k}}}} \rightarrow {{\mathit{t}}_{{2}}^{{\mathit{n}}}} \\
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
{[\textsc{\scriptsize E{-}br{-}zero}]} \quad & ({{\mathsf{label}}_{{\mathit{n}}}}{\{{{\mathit{instr}'}^\ast}\}}~{{\mathit{val}'}^\ast}~{{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{br}~0)~{{\mathit{instr}}^\ast}) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}}~{{\mathit{instr}'}^\ast} &  \\
{[\textsc{\scriptsize E{-}br{-}succ}]} \quad & ({{\mathsf{label}}_{{\mathit{n}}}}{\{{{\mathit{instr}'}^\ast}\}}~{{\mathit{val}}^\ast}~(\mathsf{br}~{\mathit{l}} + 1)~{{\mathit{instr}}^\ast}) &\hookrightarrow& {{\mathit{val}}^\ast}~(\mathsf{br}~{\mathit{l}}) &  \\
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
{[\textsc{\scriptsize E{-}br\_on\_null{-}non{-}null}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_null}~{\mathit{l}}) &\hookrightarrow& {\mathit{val}} &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_non\_null{-}null}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_non\_null}~{\mathit{l}}) &\hookrightarrow& \epsilon &\quad
  \mbox{if}~{\mathit{val}} = \mathsf{ref.null}~{\mathit{ht}} \\
{[\textsc{\scriptsize E{-}br\_on\_non\_null{-}non{-}null}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_non\_null}~{\mathit{l}}) &\hookrightarrow& {\mathit{val}}~(\mathsf{br}~{\mathit{l}}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_cast{-}succeed}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{br\_on\_cast}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}}) &\hookrightarrow& {\mathit{ref}}~(\mathsf{br}~{\mathit{l}}) &\quad
  \mbox{if}~{\mathit{s}} \vdash {\mathit{ref}} : {\mathit{rt}} \\
 &&&&\quad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}} \leq {{\mathrm{inst}}}_{{\mathit{f}}.\mathsf{module}}({\mathit{rt}}_{{2}}) \\
{[\textsc{\scriptsize E{-}br\_on\_cast{-}fail}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{br\_on\_cast}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}}) &\hookrightarrow& {\mathit{ref}} &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_cast\_fail{-}succeed}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{br\_on\_cast\_fail}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}}) &\hookrightarrow& {\mathit{ref}} &\quad
  \mbox{if}~{\mathit{s}} \vdash {\mathit{ref}} : {\mathit{rt}} \\
 &&&&\quad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}} \leq {{\mathrm{inst}}}_{{\mathit{f}}.\mathsf{module}}({\mathit{rt}}_{{2}}) \\
{[\textsc{\scriptsize E{-}br\_on\_cast\_fail{-}fail}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{br\_on\_cast\_fail}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}}) &\hookrightarrow& {\mathit{ref}}~(\mathsf{br}~{\mathit{l}}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}call}]} \quad & {\mathit{z}} ; (\mathsf{call}~{\mathit{x}}) &\hookrightarrow& (\mathsf{call\_ref}~{\mathit{z}}.\mathsf{module}.\mathsf{func}[{\mathit{x}}]) &  \\
{[\textsc{\scriptsize E{-}call\_ref{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{call\_ref}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}call\_ref{-}func}]} \quad & {\mathit{z}} ; {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{ref.func}~{\mathit{a}})~(\mathsf{call\_ref}~{\mathit{x}}) &\hookrightarrow& ({{\mathsf{frame}}_{{\mathit{m}}}}{\{{\mathit{f}}\}}~({{\mathsf{label}}_{{\mathit{m}}}}{\{\epsilon\}}~{{\mathit{instr}}^\ast})) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{func}[{\mathit{a}}] = {\mathit{fi}} \\
 &&&&\quad {\land}~{\mathit{fi}}.\mathsf{type} \approx \mathsf{func}~({{\mathit{t}}_{{1}}^{{\mathit{n}}}} \rightarrow {{\mathit{t}}_{{2}}^{{\mathit{m}}}}) \\
 &&&&\quad {\land}~{\mathit{fi}}.\mathsf{code} = \mathsf{func}~{\mathit{x}}~{(\mathsf{local}~{\mathit{t}})^\ast}~({{\mathit{instr}}^\ast}) \\
 &&&&\quad {\land}~{\mathit{f}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{local}~{{\mathit{val}}^{{\mathit{n}}}}~{({{\mathrm{default}}}_{{\mathit{t}}})^\ast},\; \mathsf{module}~{\mathit{fi}}.\mathsf{module} \}\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}return\_call}]} \quad & {\mathit{z}} ; (\mathsf{return\_call}~{\mathit{x}}) &\hookrightarrow& (\mathsf{return\_call\_ref}~{\mathit{z}}.\mathsf{module}.\mathsf{func}[{\mathit{x}}]) &  \\
{[\textsc{\scriptsize E{-}return\_call\_ref{-}frame}]} \quad & {\mathit{z}} ; ({{\mathsf{frame}}_{{\mathit{k}}}}{\{{\mathit{f}}\}}~{{\mathit{val}'}^\ast}~{{\mathit{val}}^{{\mathit{n}}}}~{\mathit{ref}}~(\mathsf{return\_call\_ref}~{\mathit{x}})~{{\mathit{instr}}^\ast}) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}}~{\mathit{ref}}~(\mathsf{call\_ref}~{\mathit{x}}) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{func}[{\mathit{a}}].\mathsf{type} \approx \mathsf{func}~({{\mathit{t}}_{{1}}^{{\mathit{n}}}} \rightarrow {{\mathit{t}}_{{2}}^{{\mathit{m}}}}) \\
{[\textsc{\scriptsize E{-}return\_call\_ref{-}label}]} \quad & {\mathit{z}} ; ({{\mathsf{label}}_{{\mathit{k}}}}{\{{{\mathit{instr}'}^\ast}\}}~{{\mathit{val}'}^\ast}~{{\mathit{val}}^{{\mathit{n}}}}~{\mathit{ref}}~(\mathsf{return\_call\_ref}~{\mathit{x}})~{{\mathit{instr}}^\ast}) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}}~{\mathit{ref}}~(\mathsf{return\_call\_ref}~{\mathit{x}}) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{func}[{\mathit{a}}].\mathsf{type} \approx \mathsf{func}~({{\mathit{t}}_{{1}}^{{\mathit{n}}}} \rightarrow {{\mathit{t}}_{{2}}^{{\mathit{m}}}}) \\
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
{[\textsc{\scriptsize E{-}return{-}frame}]} \quad & ({{\mathsf{frame}}_{{\mathit{n}}}}{\{{\mathit{f}}\}}~{{\mathit{val}'}^\ast}~{{\mathit{val}}^{{\mathit{n}}}}~\mathsf{return}~{{\mathit{instr}}^\ast}) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}} &  \\
{[\textsc{\scriptsize E{-}return{-}label}]} \quad & ({{\mathsf{label}}_{{\mathit{k}}}}{\{{{\mathit{instr}'}^\ast}\}}~{{\mathit{val}}^\ast}~\mathsf{return}~{{\mathit{instr}}^\ast}) &\hookrightarrow& {{\mathit{val}}^\ast}~\mathsf{return} &  \\
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
{[\textsc{\scriptsize E{-}extend}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~({{\mathit{nt}}.\mathsf{extend}}{{\mathit{n}}}) &\hookrightarrow& ({\mathit{nt}}.\mathsf{const}~{{{{\mathrm{ext}}}_{{\mathit{n}},{|{\mathit{nt}}|}}^{\mathsf{s}}}}{({\mathit{c}})}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}cvtop{-}val}]} \quad & ({\mathit{nt}}_{{1}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}}_{{2}} . {{{{{\mathit{cvtop}}}{\mathsf{\_}}}{{\mathit{nt}}_{{1}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}) &\hookrightarrow& ({\mathit{nt}}_{{2}}.\mathsf{const}~{\mathit{c}}) &\quad
  \mbox{if}~{{{\mathit{cvtop}}}{{{}_{{\mathit{nt}}_{{1}},{\mathit{nt}}_{{2}}}^{{{\mathit{sx}}^?}}}}}{({\mathit{c}}_{{1}})} = {\mathit{c}} \\
{[\textsc{\scriptsize E{-}cvtop{-}trap}]} \quad & ({\mathit{nt}}_{{1}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}}_{{2}} . {{{{{\mathit{cvtop}}}{\mathsf{\_}}}{{\mathit{nt}}_{{1}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{{{\mathit{cvtop}}}{{{}_{{\mathit{nt}}_{{1}},{\mathit{nt}}_{{2}}}^{{{\mathit{sx}}^?}}}}}{({\mathit{c}}_{{1}})} = \epsilon \\
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
{[\textsc{\scriptsize E{-}ref.i31}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~\mathsf{ref.i{\scriptstyle31}} &\hookrightarrow& (\mathsf{ref.i{\scriptstyle31}}~{{{\mathrm{wrap}}}_{32,31}}{({\mathit{i}})}) &  \\
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
{[\textsc{\scriptsize E{-}ref.as\_non\_null{-}non\_null}]} \quad & {\mathit{ref}}~\mathsf{ref.as\_non\_null} &\hookrightarrow& {\mathit{ref}} &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.eq{-}null}]} \quad & {\mathit{ref}}_{{1}}~{\mathit{ref}}_{{2}}~\mathsf{ref.eq} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1) &\quad
  \mbox{if}~{\mathit{ref}}_{{1}} = (\mathsf{ref.null}~{\mathit{ht}}_{{1}}) \land {\mathit{ref}}_{{2}} = (\mathsf{ref.null}~{\mathit{ht}}_{{2}}) \\
{[\textsc{\scriptsize E{-}ref.eq{-}true}]} \quad & {\mathit{ref}}_{{1}}~{\mathit{ref}}_{{2}}~\mathsf{ref.eq} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1) &\quad
  \mbox{if}~{\mathit{ref}}_{{1}} = {\mathit{ref}}_{{2}} \\
{[\textsc{\scriptsize E{-}ref.eq{-}false}]} \quad & {\mathit{ref}}_{{1}}~{\mathit{ref}}_{{2}}~\mathsf{ref.eq} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.test{-}true}]} \quad & ({\mathit{s}} ; {\mathit{f}}) ; {\mathit{ref}}~(\mathsf{ref.test}~{\mathit{rt}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1) &\quad
  \mbox{if}~{\mathit{s}} \vdash {\mathit{ref}} : {\mathit{rt}'} \\
 &&&&\quad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}'} \leq {{\mathrm{inst}}}_{{\mathit{f}}.\mathsf{module}}({\mathit{rt}}) \\
{[\textsc{\scriptsize E{-}ref.test{-}false}]} \quad & ({\mathit{s}} ; {\mathit{f}}) ; {\mathit{ref}}~(\mathsf{ref.test}~{\mathit{rt}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.cast{-}succeed}]} \quad & ({\mathit{s}} ; {\mathit{f}}) ; {\mathit{ref}}~(\mathsf{ref.cast}~{\mathit{rt}}) &\hookrightarrow& {\mathit{ref}} &\quad
  \mbox{if}~{\mathit{s}} \vdash {\mathit{ref}} : {\mathit{rt}'} \\
 &&&&\quad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}'} \leq {{\mathrm{inst}}}_{{\mathit{f}}.\mathsf{module}}({\mathit{rt}}) \\
{[\textsc{\scriptsize E{-}ref.cast{-}fail}]} \quad & ({\mathit{s}} ; {\mathit{f}}) ; {\mathit{ref}}~(\mathsf{ref.cast}~{\mathit{rt}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}i31.get{-}null}]} \quad & (\mathsf{ref.null}~{\mathit{ht}})~({{\mathsf{i{\scriptstyle31}.get}}{\mathsf{\_}}}{{\mathit{sx}}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}i31.get{-}num}]} \quad & (\mathsf{ref.i{\scriptstyle31}}~{\mathit{i}})~({{\mathsf{i{\scriptstyle31}.get}}{\mathsf{\_}}}{{\mathit{sx}}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{{{{\mathrm{ext}}}_{31,32}^{{\mathit{sx}}}}}{({\mathit{i}})}) &  \\
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
 &&&&\quad {\land}~(({{\mathrm{default}}}_{{\mathrm{unpack}}({\mathit{zt}})} = {\mathit{val}}))^\ast \\
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
{[\textsc{\scriptsize E{-}struct.set{-}struct}]} \quad & {\mathit{z}} ; (\mathsf{ref.struct}~{\mathit{a}})~{\mathit{val}}~(\mathsf{struct.set}~{\mathit{x}}~{\mathit{i}}) &\hookrightarrow& {\mathrm{with}}_{{\mathit{struct}}}({\mathit{z}},\, {\mathit{a}},\, {\mathit{i}},\, {\mathit{fv}}) ; \epsilon &\quad
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
 &&&&\quad {\land}~{{\mathrm{default}}}_{{\mathrm{unpack}}({\mathit{zt}})} = {\mathit{val}} \\
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
 &&&&\quad {\land}~{{{{\mathrm{bytes}}}_{{|{\mathit{zt}}|}}}{{\mathit{c}}}^{{\mathit{n}}}} = {{\mathit{z}}.\mathsf{data}}{[{\mathit{y}}]}.\mathsf{data}[{\mathit{i}} : {\mathit{n}} \cdot {|{\mathit{zt}}|} / 8] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.get{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.get{-}array}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}) &\hookrightarrow& {{{{\mathrm{unpack}}}_{{\mathit{zt}}}^{{{\mathit{sx}}^?}}}}{({\mathit{ai}}.\mathsf{field}[{\mathit{i}}])} &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{array}[{\mathit{a}}] = {\mathit{ai}} \\
 &&&&\quad {\land}~{\mathit{ai}}.\mathsf{type} \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.set{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~{\mathit{val}}~(\mathsf{array.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.set{-}array}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~{\mathit{val}}~(\mathsf{array.set}~{\mathit{x}}) &\hookrightarrow& {\mathrm{with}}_{{\mathit{array}}}({\mathit{z}},\, {\mathit{a}},\, {\mathit{i}},\, {\mathit{fv}}) ; \epsilon &\quad
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
{[\textsc{\scriptsize E{-}array.fill{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)~(\mathsf{array.fill}~{\mathit{x}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise} \\
{[\textsc{\scriptsize E{-}array.fill{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} + 1)~(\mathsf{array.fill}~{\mathit{x}}) &\hookrightarrow& (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{array.set}~{\mathit{x}})~(\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.fill}~{\mathit{x}}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.copy{-}null1}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~{\mathit{ref}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.copy{-}null2}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.null}~{\mathit{ht}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.copy{-}oob1}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}}_{{1}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{array}[{\mathit{a}}_{{1}}].\mathsf{field}|} \\
{[\textsc{\scriptsize E{-}array.copy{-}oob2}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}}_{{2}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{array}[{\mathit{a}}_{{2}}].\mathsf{field}|} \\
{[\textsc{\scriptsize E{-}array.copy{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise} \\
{[\textsc{\scriptsize E{-}array.copy{-}le}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} + 1)~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~({{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}})~(\mathsf{array.set}~{\mathit{x}})~(\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}} + 1)~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\quad
  \mbox{if}~{\mathit{i}}_{{1}} \leq {\mathit{i}}_{{2}} \\
 &&&&\quad {\land}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}_{{2}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}_{{2}}) \\
 &&&&\quad {\land}~{{\mathit{sx}}^?} = {\mathrm{sx}}({\mathit{zt}}_{{2}}) \\
{[\textsc{\scriptsize E{-}array.copy{-}gt}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} + 1)~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}} + {\mathit{n}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}} + {\mathit{n}})~({{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}})~(\mathsf{array.set}~{\mathit{x}})~(\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\quad
  \mbox{if}~{\mathit{i}}_{{1}} > {\mathit{i}}_{{2}} \\
 &&&&\quad {\land}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}_{{2}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}_{{2}}) \\
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
{[\textsc{\scriptsize E{-}array.init\_elem{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise} \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} + 1)~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{ref}}~(\mathsf{array.set}~{\mathit{x}})~(\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\quad
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
{[\textsc{\scriptsize E{-}array.init\_data{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise} \\
{[\textsc{\scriptsize E{-}array.init\_data{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} + 1)~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~(\mathsf{array.set}~{\mathit{x}})~(\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\quad
  \mbox{otherwise, if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}) \\
 &&&&\quad {\land}~{\mathit{nt}} = {\mathrm{unpack}}({\mathit{zt}}) \\
 &&&&\quad {\land}~{{{\mathrm{bytes}}}_{{|{\mathit{zt}}|}}}{{\mathit{c}}} = {{\mathit{z}}.\mathsf{data}}{[{\mathit{y}}]}.\mathsf{data}[{\mathit{j}} : {|{\mathit{zt}}|} / 8] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}extern.externalize{-}null}]} \quad & (\mathsf{ref.null}~{\mathit{ht}})~\mathsf{extern.externalize} &\hookrightarrow& (\mathsf{ref.null}~\mathsf{extern}) &  \\
{[\textsc{\scriptsize E{-}extern.externalize{-}addr}]} \quad & {\mathit{addrref}}~\mathsf{extern.externalize} &\hookrightarrow& (\mathsf{ref.extern}~{\mathit{addrref}}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}extern.internalize{-}null}]} \quad & (\mathsf{ref.null}~{\mathit{ht}})~\mathsf{extern.internalize} &\hookrightarrow& (\mathsf{ref.null}~\mathsf{any}) &  \\
{[\textsc{\scriptsize E{-}extern.internalize{-}addr}]} \quad & (\mathsf{ref.extern}~{\mathit{addrref}})~\mathsf{extern.internalize} &\hookrightarrow& {\mathit{addrref}} &  \\
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
  \mbox{if}~{\mathrm{growtable}}({{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]},\, {\mathit{n}},\, {\mathit{ref}}) = {\mathit{ti}} \\
{[\textsc{\scriptsize E{-}table.grow{-}fail}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.grow}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~-1) &  \\
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
{[\textsc{\scriptsize E{-}load{-}num{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{load}~{\mathit{nt}}~{\mathit{x}}~{\mathit{n}}_{{\mathsf{a}}}~{\mathit{n}}_{{\mathsf{o}}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}}_{{\mathsf{o}}} + {|{\mathit{nt}}|} / 8 > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}load{-}num{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{load}~{\mathit{nt}}~{\mathit{x}}~{\mathit{n}}_{{\mathsf{a}}}~{\mathit{n}}_{{\mathsf{o}}}) &\hookrightarrow& ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}) &\quad
  \mbox{if}~{{{\mathrm{bytes}}}_{{|{\mathit{nt}}|}}}{{\mathit{c}}} = {{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}[{\mathit{i}} + {\mathit{n}}_{{\mathsf{o}}} : {|{\mathit{nt}}|} / 8] \\
{[\textsc{\scriptsize E{-}load{-}pack{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({{\mathit{nt}}.\mathsf{load}}{{{{\mathit{n}}}{\mathsf{\_}}}{{\mathit{sx}}}}~{\mathit{x}}~{\mathit{n}}_{{\mathsf{a}}}~{\mathit{n}}_{{\mathsf{o}}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}}_{{\mathsf{o}}} + {\mathit{n}} / 8 > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}load{-}pack{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({{\mathit{nt}}.\mathsf{load}}{{{{\mathit{n}}}{\mathsf{\_}}}{{\mathit{sx}}}}~{\mathit{x}}~{\mathit{n}}_{{\mathsf{a}}}~{\mathit{n}}_{{\mathsf{o}}}) &\hookrightarrow& ({\mathit{nt}}.\mathsf{const}~{{{{\mathrm{ext}}}_{{\mathit{n}},{|{\mathit{nt}}|}}^{{\mathit{sx}}}}}{({\mathit{c}})}) &\quad
  \mbox{if}~{{{\mathrm{bytes}}}_{{\mathit{n}}}}{{\mathit{c}}} = {{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}[{\mathit{i}} + {\mathit{n}}_{{\mathsf{o}}} : {\mathit{n}} / 8] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}store{-}num{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~(\mathsf{store}~{\mathit{nt}}~{\mathit{x}}~{\mathit{n}}_{{\mathsf{a}}}~{\mathit{n}}_{{\mathsf{o}}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}}_{{\mathsf{o}}} + {|{\mathit{nt}}|} / 8 > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}store{-}num{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~(\mathsf{store}~{\mathit{nt}}~{\mathit{x}}~{\mathit{n}}_{{\mathsf{a}}}~{\mathit{n}}_{{\mathsf{o}}}) &\hookrightarrow& {\mathit{z}}[\mathsf{mem}[{\mathit{x}}].\mathsf{data}[{\mathit{i}} + {\mathit{n}}_{{\mathsf{o}}} : {|{\mathit{nt}}|} / 8] = {{\mathit{b}}^\ast}] ; \epsilon &\quad
  \mbox{if}~{{\mathit{b}}^\ast} = {{{\mathrm{bytes}}}_{{|{\mathit{nt}}|}}}{{\mathit{c}}} \\
{[\textsc{\scriptsize E{-}store{-}pack{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~({{\mathit{nt}}.\mathsf{store}}{{\mathit{n}}}~{\mathit{x}}~{\mathit{n}}_{{\mathsf{a}}}~{\mathit{n}}_{{\mathsf{o}}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}}_{{\mathsf{o}}} + {\mathit{n}} / 8 > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}store{-}pack{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~({{\mathit{nt}}.\mathsf{store}}{{\mathit{n}}}~{\mathit{x}}~{\mathit{n}}_{{\mathsf{a}}}~{\mathit{n}}_{{\mathsf{o}}}) &\hookrightarrow& {\mathit{z}}[\mathsf{mem}[{\mathit{x}}].\mathsf{data}[{\mathit{i}} + {\mathit{n}}_{{\mathsf{o}}} : {\mathit{n}} / 8] = {{\mathit{b}}^\ast}] ; \epsilon &\quad
  \mbox{if}~{{\mathit{b}}^\ast} = {{{\mathrm{bytes}}}_{{\mathit{n}}}}{{{{\mathrm{wrap}}}_{{|{\mathit{nt}}|},{\mathit{n}}}}{({\mathit{c}})}} \\
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
{[\textsc{\scriptsize E{-}memory.grow{-}succeed}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.grow}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{mem}[{\mathit{x}}] = {\mathit{mi}}] ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{{\mathit{z}}.\mathsf{mem}}{[0]}.\mathsf{data}|} / (64 \cdot {\mathrm{Ki}})) &\quad
  \mbox{if}~{\mathrm{growmemory}}({{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]},\, {\mathit{n}}) = {\mathit{mi}} \\
{[\textsc{\scriptsize E{-}memory.grow{-}fail}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.grow}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~-1) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.fill{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.fill}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}memory.fill{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.fill}~{\mathit{x}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}memory.fill{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.fill}~{\mathit{x}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~{\mathit{x}}~0~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{memory.fill}~{\mathit{x}}) &\quad
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
{[\textsc{\scriptsize E{-}memory.copy{-}le}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~({\mathsf{i{\scriptstyle32}}.\mathsf{load}}{{{8}{\mathsf{\_}}}{\mathsf{u}}}~{\mathit{x}}_{{2}}~0~0)~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~{\mathit{x}}_{{1}}~0~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\quad
  \mbox{otherwise, if}~{\mathit{i}}_{{1}} \leq {\mathit{i}}_{{2}} \\
{[\textsc{\scriptsize E{-}memory.copy{-}gt}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}} + {\mathit{n}} - 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}} + {\mathit{n}} - 1)~({\mathsf{i{\scriptstyle32}}.\mathsf{load}}{{{8}{\mathsf{\_}}}{\mathsf{u}}}~{\mathit{x}}_{{2}}~0~0)~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~{\mathit{x}}_{{1}}~0~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\quad
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
{[\textsc{\scriptsize E{-}memory.init{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{{\mathit{z}}.\mathsf{data}}{[{\mathit{y}}]}.\mathsf{data}[{\mathit{i}}])~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~{\mathit{x}}~0~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}data.drop}]} \quad & {\mathit{z}} ; (\mathsf{data.drop}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{data}[{\mathit{x}}].\mathsf{data} = \epsilon] ; \epsilon &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocfunc}}({\mathit{s}},\, {\mathit{mm}},\, {\mathit{func}}) &=& ({\mathit{s}}[\mathsf{func} = ..{\mathit{fi}}],\, {|{\mathit{s}}.\mathsf{func}|}) &\quad
  \mbox{if}~{\mathit{func}} = \mathsf{func}~{\mathit{x}}~{{\mathit{local}}^\ast}~{\mathit{expr}} \\
 &&&\quad {\land}~{\mathit{fi}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{mm}}.\mathsf{type}[{\mathit{x}}],\; \mathsf{module}~{\mathit{mm}},\; \mathsf{code}~{\mathit{func}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocfuncs}}({\mathit{s}},\, {\mathit{mm}},\, \epsilon) &=& ({\mathit{s}},\, \epsilon) &  \\
{\mathrm{allocfuncs}}({\mathit{s}},\, {\mathit{mm}},\, {\mathit{func}}~{{\mathit{func}'}^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{fa}}~{{\mathit{fa}'}^\ast}) &\quad
  \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{fa}}) = {\mathrm{allocfunc}}({\mathit{s}},\, {\mathit{mm}},\, {\mathit{func}}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{fa}'}^\ast}) = {\mathrm{allocfuncs}}({\mathit{s}}_{{1}},\, {\mathit{mm}},\, {{\mathit{func}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocglobal}}({\mathit{s}},\, {\mathit{globaltype}},\, {\mathit{val}}) &=& ({\mathit{s}}[\mathsf{global} = ..{\mathit{gi}}],\, {|{\mathit{s}}.\mathsf{global}|}) &\quad
  \mbox{if}~{\mathit{gi}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{globaltype}},\; \mathsf{value}~{\mathit{val}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocglobals}}({\mathit{s}},\, \epsilon,\, \epsilon) &=& ({\mathit{s}},\, \epsilon) &  \\
{\mathrm{allocglobals}}({\mathit{s}},\, {\mathit{globaltype}}~{{\mathit{globaltype}'}^\ast},\, {\mathit{val}}~{{\mathit{val}'}^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{ga}}~{{\mathit{ga}'}^\ast}) &\quad
  \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{ga}}) = {\mathrm{allocglobal}}({\mathit{s}},\, {\mathit{globaltype}},\, {\mathit{val}}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ga}'}^\ast}) = {\mathrm{allocglobals}}({\mathit{s}}_{{1}},\, {{\mathit{globaltype}'}^\ast},\, {{\mathit{val}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{alloctable}}({\mathit{s}},\, [{\mathit{i}} .. {\mathit{j}}]~{\mathit{rt}},\, {\mathit{ref}}) &=& ({\mathit{s}}[\mathsf{table} = ..{\mathit{ti}}],\, {|{\mathit{s}}.\mathsf{table}|}) &\quad
  \mbox{if}~{\mathit{ti}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([{\mathit{i}} .. {\mathit{j}}]~{\mathit{rt}}),\; \mathsf{elem}~{{\mathit{ref}}^{{\mathit{i}}}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{alloctables}}({\mathit{s}},\, \epsilon,\, \epsilon) &=& ({\mathit{s}},\, \epsilon) &  \\
{\mathrm{alloctables}}({\mathit{s}},\, {\mathit{tabletype}}~{{\mathit{tabletype}'}^\ast},\, {\mathit{ref}}~{{\mathit{ref}'}^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{ta}}~{{\mathit{ta}'}^\ast}) &\quad
  \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{ta}}) = {\mathrm{alloctable}}({\mathit{s}},\, {\mathit{tabletype}},\, {\mathit{ref}}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ta}'}^\ast}) = {\mathrm{alloctables}}({\mathit{s}}_{{1}},\, {{\mathit{tabletype}'}^\ast},\, {{\mathit{ref}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocmem}}({\mathit{s}},\, [{\mathit{i}} .. {\mathit{j}}]~\mathsf{i{\scriptstyle8}}) &=& ({\mathit{s}}[\mathsf{mem} = ..{\mathit{mi}}],\, {|{\mathit{s}}.\mathsf{mem}|}) &\quad
  \mbox{if}~{\mathit{mi}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([{\mathit{i}} .. {\mathit{j}}]~\mathsf{i{\scriptstyle8}}),\; \mathsf{data}~{0^{{\mathit{i}} \cdot 64 \cdot {\mathrm{Ki}}}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocmems}}({\mathit{s}},\, \epsilon) &=& ({\mathit{s}},\, \epsilon) &  \\
{\mathrm{allocmems}}({\mathit{s}},\, {\mathit{memtype}}~{{\mathit{memtype}'}^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{ma}}~{{\mathit{ma}'}^\ast}) &\quad
  \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{ma}}) = {\mathrm{allocmem}}({\mathit{s}},\, {\mathit{memtype}}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ma}'}^\ast}) = {\mathrm{allocmems}}({\mathit{s}}_{{1}},\, {{\mathit{memtype}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocelem}}({\mathit{s}},\, {\mathit{rt}},\, {{\mathit{ref}}^\ast}) &=& ({\mathit{s}}[\mathsf{elem} = ..{\mathit{ei}}],\, {|{\mathit{s}}.\mathsf{elem}|}) &\quad
  \mbox{if}~{\mathit{ei}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{rt}},\; \mathsf{elem}~{{\mathit{ref}}^\ast} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocelems}}({\mathit{s}},\, \epsilon,\, \epsilon) &=& ({\mathit{s}},\, \epsilon) &  \\
{\mathrm{allocelems}}({\mathit{s}},\, {\mathit{rt}}~{{\mathit{rt}'}^\ast},\, ({{\mathit{ref}}^\ast})~{{{\mathit{ref}'}^\ast}^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{ea}}~{{\mathit{ea}'}^\ast}) &\quad
  \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{ea}}) = {\mathrm{allocelem}}({\mathit{s}},\, {\mathit{rt}},\, {{\mathit{ref}}^\ast}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ea}'}^\ast}) = {\mathrm{allocelems}}({\mathit{s}}_{{2}},\, {{\mathit{rt}'}^\ast},\, {{{\mathit{ref}'}^\ast}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocdata}}({\mathit{s}},\, {{\mathit{byte}}^\ast}) &=& ({\mathit{s}}[\mathsf{data} = ..{\mathit{di}}],\, {|{\mathit{s}}.\mathsf{data}|}) &\quad
  \mbox{if}~{\mathit{di}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{data}~{{\mathit{byte}}^\ast} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocdatas}}({\mathit{s}},\, \epsilon) &=& ({\mathit{s}},\, \epsilon) &  \\
{\mathrm{allocdatas}}({\mathit{s}},\, ({{\mathit{byte}}^\ast})~{{{\mathit{byte}'}^\ast}^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{da}}~{{\mathit{da}'}^\ast}) &\quad
  \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{da}}) = {\mathrm{allocdata}}({\mathit{s}},\, {{\mathit{byte}}^\ast}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{da}'}^\ast}) = {\mathrm{allocdatas}}({\mathit{s}}_{{1}},\, {{{\mathit{byte}'}^\ast}^\ast}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{instexport}}({{\mathit{fa}}^\ast},\, {{\mathit{ga}}^\ast},\, {{\mathit{ta}}^\ast},\, {{\mathit{ma}}^\ast},\, \mathsf{export}~{\mathit{name}}~(\mathsf{func}~{\mathit{x}})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{func}~{{\mathit{fa}}^\ast}[{\mathit{x}}]) \}\end{array} &  \\
{\mathrm{instexport}}({{\mathit{fa}}^\ast},\, {{\mathit{ga}}^\ast},\, {{\mathit{ta}}^\ast},\, {{\mathit{ma}}^\ast},\, \mathsf{export}~{\mathit{name}}~(\mathsf{global}~{\mathit{x}})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{global}~{{\mathit{ga}}^\ast}[{\mathit{x}}]) \}\end{array} &  \\
{\mathrm{instexport}}({{\mathit{fa}}^\ast},\, {{\mathit{ga}}^\ast},\, {{\mathit{ta}}^\ast},\, {{\mathit{ma}}^\ast},\, \mathsf{export}~{\mathit{name}}~(\mathsf{table}~{\mathit{x}})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{table}~{{\mathit{ta}}^\ast}[{\mathit{x}}]) \}\end{array} &  \\
{\mathrm{instexport}}({{\mathit{fa}}^\ast},\, {{\mathit{ga}}^\ast},\, {{\mathit{ta}}^\ast},\, {{\mathit{ma}}^\ast},\, \mathsf{export}~{\mathit{name}}~(\mathsf{mem}~{\mathit{x}})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{mem}~{{\mathit{ma}}^\ast}[{\mathit{x}}]) \}\end{array} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocmodule}}({\mathit{s}},\, {\mathit{module}},\, {{\mathit{externval}}^\ast},\, {{\mathit{val}}_{{\mathit{g}}}^\ast},\, {{\mathit{ref}}_{{\mathit{t}}}^\ast},\, {({{\mathit{ref}}_{{\mathit{e}}}^\ast})^\ast}) &=& ({\mathit{s}}_{{6}},\, {\mathit{mm}}) &\quad
  \mbox{if}~{\mathit{module}} = \mathsf{module}~{(\mathsf{type}~{\mathit{rectype}})^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^{{\mathit{n}}_{{\mathit{f}}}}}~{(\mathsf{global}~{\mathit{globaltype}}~{\mathit{expr}}_{{\mathit{g}}})^{{\mathit{n}}_{{\mathit{g}}}}}~{(\mathsf{table}~{\mathit{tabletype}}~{\mathit{expr}}_{{\mathit{t}}})^{{\mathit{n}}_{{\mathit{t}}}}}~{(\mathsf{memory}~{\mathit{memtype}})^{{\mathit{n}}_{{\mathit{m}}}}}~{(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}_{{\mathit{e}}}^\ast}~{{\mathit{elemmode}}^?})^{{\mathit{n}}_{{\mathit{e}}}}}~{(\mathsf{data}~{{\mathit{byte}}^\ast}~{{\mathit{datamode}}^?})^{{\mathit{n}}_{{\mathit{d}}}}}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast} \\
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
 &&&\quad {\land}~{{\mathit{xi}}^\ast} = {{\mathrm{instexport}}({{\mathit{fa}}_{{\mathit{ex}}}^\ast}~{{\mathit{fa}}^\ast},\, {{\mathit{ga}}_{{\mathit{ex}}}^\ast}~{{\mathit{ga}}^\ast},\, {{\mathit{ta}}_{{\mathit{ex}}}^\ast}~{{\mathit{ta}}^\ast},\, {{\mathit{ma}}_{{\mathit{ex}}}^\ast}~{{\mathit{ma}}^\ast},\, {\mathit{export}})^\ast} \\
 &&&\quad {\land}~{\mathit{mm}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{{\mathit{dt}}^\ast},\; \\
  \mathsf{func}~{{\mathit{fa}}_{{\mathit{ex}}}^\ast}~{{\mathit{fa}}^\ast},\; \\
  \mathsf{global}~{{\mathit{ga}}_{{\mathit{ex}}}^\ast}~{{\mathit{ga}}^\ast},\; \\
  \mathsf{table}~{{\mathit{ta}}_{{\mathit{ex}}}^\ast}~{{\mathit{ta}}^\ast},\; \\
  \mathsf{mem}~{{\mathit{ma}}_{{\mathit{ex}}}^\ast}~{{\mathit{ma}}^\ast},\; \\
  \mathsf{elem}~{{\mathit{ea}}^\ast},\; \\
  \mathsf{data}~{{\mathit{da}}^\ast},\; \\
  \mathsf{export}~{{\mathit{xi}}^\ast} \}\end{array} \\
 &&&\quad {\land}~({\mathit{s}}_{{1}},\, {{\mathit{fa}}^\ast}) = {\mathrm{allocfuncs}}({\mathit{s}},\, {\mathit{mm}},\, {{\mathit{func}}^{{\mathit{n}}_{{\mathit{f}}}}}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ga}}^\ast}) = {\mathrm{allocglobals}}({\mathit{s}}_{{1}},\, {{\mathit{globaltype}}^{{\mathit{n}}_{{\mathit{g}}}}},\, {{\mathit{val}}_{{\mathit{g}}}^\ast}) \\
 &&&\quad {\land}~({\mathit{s}}_{{3}},\, {{\mathit{ta}}^\ast}) = {\mathrm{alloctables}}({\mathit{s}}_{{2}},\, {{\mathit{tabletype}}^{{\mathit{n}}_{{\mathit{t}}}}},\, {{\mathit{ref}}_{{\mathit{t}}}^\ast}) \\
 &&&\quad {\land}~({\mathit{s}}_{{4}},\, {{\mathit{ma}}^\ast}) = {\mathrm{allocmems}}({\mathit{s}}_{{3}},\, {{\mathit{memtype}}^{{\mathit{n}}_{{\mathit{m}}}}}) \\
 &&&\quad {\land}~({\mathit{s}}_{{5}},\, {{\mathit{ea}}^\ast}) = {\mathrm{allocelems}}({\mathit{s}}_{{4}},\, {{\mathit{reftype}}^{{\mathit{n}}_{{\mathit{e}}}}},\, {({{\mathit{ref}}_{{\mathit{e}}}^\ast})^\ast}) \\
 &&&\quad {\land}~({\mathit{s}}_{{6}},\, {{\mathit{da}}^\ast}) = {\mathrm{allocdatas}}({\mathit{s}}_{{5}},\, {({{\mathit{byte}}^\ast})^{{\mathit{n}}_{{\mathit{d}}}}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{concat}}_{{\mathit{instr}}}(\epsilon) &=& \epsilon &  \\
{\mathrm{concat}}_{{\mathit{instr}}}(({{\mathit{instr}}^\ast})~{{{\mathit{instr}'}^\ast}^\ast}) &=& {{\mathit{instr}}^\ast}~{\mathrm{concat}}_{{\mathit{instr}}}({{{\mathit{instr}'}^\ast}^\ast}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{runelem}}(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}^\ast},\, {\mathit{y}}) &=& \epsilon &  \\
{\mathrm{runelem}}(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}^\ast}~(\mathsf{declare}),\, {\mathit{y}}) &=& (\mathsf{elem.drop}~{\mathit{y}}) &  \\
{\mathrm{runelem}}(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}^\ast}~(\mathsf{table}~{\mathit{x}}~{{\mathit{instr}}^\ast}),\, {\mathit{y}}) &=& {{\mathit{instr}}^\ast}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{{\mathit{expr}}^\ast}|})~(\mathsf{table.init}~{\mathit{x}}~{\mathit{y}})~(\mathsf{elem.drop}~{\mathit{y}}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{rundata}}(\mathsf{data}~{{\mathit{byte}}^\ast},\, {\mathit{y}}) &=& \epsilon &  \\
{\mathrm{rundata}}(\mathsf{data}~{{\mathit{byte}}^\ast}~(\mathsf{memory}~{\mathit{x}}~{{\mathit{instr}}^\ast}),\, {\mathit{y}}) &=& {{\mathit{instr}}^\ast}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{{\mathit{byte}}^\ast}|})~(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}})~(\mathsf{data.drop}~{\mathit{y}}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{instantiate}}({\mathit{s}},\, {\mathit{module}},\, {{\mathit{externval}}^\ast}) &=& {\mathit{s}'} ; {\mathit{f}} ; {{\mathit{instr}}_{{\mathit{e}}}^\ast}~{{\mathit{instr}}_{{\mathit{d}}}^\ast}~{(\mathsf{call}~{\mathit{x}})^?} &\quad
  \mbox{if}~{\mathit{module}} = \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^{{\mathit{n}}_{{\mathit{func}}}}}~{{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast} \\
 &&&\quad {\land}~{{\mathit{global}}^\ast} = {(\mathsf{global}~{\mathit{globaltype}}~{\mathit{expr}}_{{\mathit{g}}})^\ast} \\
 &&&\quad {\land}~{{\mathit{table}}^\ast} = {(\mathsf{table}~{\mathit{tabletype}}~{\mathit{expr}}_{{\mathit{t}}})^\ast} \\
 &&&\quad {\land}~{{\mathit{elem}}^\ast} = {(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}_{{\mathit{e}}}^\ast}~{{\mathit{elemmode}}^?})^\ast} \\
 &&&\quad {\land}~{{\mathit{start}}^?} = {(\mathsf{start}~{\mathit{x}})^?} \\
 &&&\quad {\land}~{\mathit{n}}_{{\mathit{e}}} = {|{{\mathit{elem}}^\ast}|} \\
 &&&\quad {\land}~{\mathit{n}}_{{\mathit{d}}} = {|{{\mathit{data}}^\ast}|} \\
 &&&\quad {\land}~{\mathit{mm}}_{{\mathit{init}}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{mm}}.\mathsf{type},\; \\
  \mathsf{func}~{\mathrm{funcs}}({{\mathit{externval}}^\ast})~{{|{\mathit{s}}.\mathsf{func}|} + {\mathit{i}}_{{\mathit{func}}}^{{\mathit{i}}_{{\mathit{func}}}<{\mathit{n}}_{{\mathit{func}}}}},\; \\
  \mathsf{global}~{\mathrm{globals}}({{\mathit{externval}}^\ast}),\; \\
  \mathsf{table}~\epsilon,\; \\
  \mathsf{mem}~\epsilon,\; \\
  \mathsf{elem}~\epsilon,\; \\
  \mathsf{data}~\epsilon,\; \\
  \mathsf{export}~\epsilon \}\end{array} \\
 &&&\quad {\land}~{\mathit{z}} = {\mathit{s}} ; \{ \begin{array}[t]{@{}l@{}}
\mathsf{module}~{\mathit{mm}}_{{\mathit{init}}} \}\end{array} \\
 &&&\quad {\land}~({\mathit{z}} ; {\mathit{expr}}_{{\mathit{g}}} \hookrightarrow^\ast {\mathit{z}} ; {\mathit{val}}_{{\mathit{g}}})^\ast \\
 &&&\quad {\land}~({\mathit{z}} ; {\mathit{expr}}_{{\mathit{t}}} \hookrightarrow^\ast {\mathit{z}} ; {\mathit{ref}}_{{\mathit{t}}})^\ast \\
 &&&\quad {\land}~{({\mathit{z}} ; {\mathit{expr}}_{{\mathit{e}}} \hookrightarrow^\ast {\mathit{z}} ; {\mathit{ref}}_{{\mathit{e}}})^\ast}^\ast \\
 &&&\quad {\land}~({\mathit{s}'},\, {\mathit{mm}}) = {\mathrm{allocmodule}}({\mathit{s}},\, {\mathit{module}},\, {{\mathit{externval}}^\ast},\, {{\mathit{val}}_{{\mathit{g}}}^\ast},\, {{\mathit{ref}}_{{\mathit{t}}}^\ast},\, {({{\mathit{ref}}_{{\mathit{e}}}^\ast})^\ast}) \\
 &&&\quad {\land}~{\mathit{f}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{module}~{\mathit{mm}} \}\end{array} \\
 &&&\quad {\land}~{{\mathit{instr}}_{{\mathit{e}}}^\ast} = {\mathrm{concat}}_{{\mathit{instr}}}({{\mathrm{runelem}}({{\mathit{elem}}^\ast}[{\mathit{i}}],\, {\mathit{i}})^{{\mathit{i}}<{\mathit{n}}_{{\mathit{e}}}}}) \\
 &&&\quad {\land}~{{\mathit{instr}}_{{\mathit{d}}}^\ast} = {\mathrm{concat}}_{{\mathit{instr}}}({{\mathrm{rundata}}({{\mathit{data}}^\ast}[{\mathit{j}}],\, {\mathit{j}})^{{\mathit{j}}<{\mathit{n}}_{{\mathit{d}}}}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{invoke}}({\mathit{s}},\, {\mathit{fa}},\, {{\mathit{val}}^{{\mathit{n}}}}) &=& {\mathit{s}} ; {\mathit{f}} ; {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{ref.func}~{\mathit{fa}})~(\mathsf{call\_ref}~0) &\quad
  \mbox{if}~{\mathit{mm}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{s}}.\mathsf{func}[{\mathit{fa}}].\mathsf{type},\; \\
  \mathsf{func}~\epsilon,\; \\
  \mathsf{global}~\epsilon,\; \\
  \mathsf{table}~\epsilon,\; \\
  \mathsf{mem}~\epsilon,\; \\
  \mathsf{elem}~\epsilon,\; \\
  \mathsf{data}~\epsilon,\; \\
  \mathsf{export}~\epsilon \}\end{array} \\
 &&&\quad {\land}~{\mathit{f}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{local}~\epsilon,\; \mathsf{module}~{\mathit{mm}} \}\end{array} \\
 &&&\quad {\land}~({\mathit{s}} ; {\mathit{f}}).\mathsf{func}[{\mathit{fa}}].\mathsf{code} = \mathsf{func}~{\mathit{x}}~{{\mathit{local}}^\ast}~{\mathit{expr}} \\
 &&&\quad {\land}~{\mathit{s}}.\mathsf{func}[{\mathit{fa}}].\mathsf{type} \approx \mathsf{func}~({{\mathit{t}}_{{1}}^{{\mathit{n}}}} \rightarrow {{\mathit{t}}_{{2}}^\ast}) \\
\end{array}
$$


```

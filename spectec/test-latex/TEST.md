# Test

```sh
$ (../src/exe-watsup/main.exe test.watsup --latex)
$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{test}}_{{\mathit{sub}}_{{\mathsf{atom}}_{22}}}(n_{1_{{\mathit{xyz}}_y}}) & = & 0 \\
{\mathrm{test}}_{{\mathit{sub}}_{{\mathsf{atom}}_{22}}}(n_{2_{{\mathsf{xyz}}_y}}) & = & 0 \\
{\mathrm{test}}_{{\mathit{sub}}_{{\mathsf{atom}}_{22}}}(n_{3_{{\mathsf{atom}}_y}}) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{curried}}}_{n_1}(n_2) & = & n_1 + n_2 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{testfuse}} & ::= & {\mathsf{ab}}_{\mathbb{N}}\,\mathbb{N}~\mathbb{N} \\
& & | & {\mathsf{cd}}_{\mathbb{N}}\,\mathbb{N}~\mathbb{N} \\
& & | & {\mathsf{ef}}{\mathbb{N}}~\mathbb{N}~\mathbb{N} \\
& & | & {{\mathsf{gh}}_{\mathbb{N}}}{\mathbb{N}}~\mathbb{N} \\
& & | & {{\mathsf{ij}}{\mathsf{\_}}~\mathbb{N}}{\mathsf{ab}}{\mathbb{N}}~\mathbb{N} \\
& & | & {\mathsf{kl\_ab}}{\mathbb{N}}~\mathbb{N}~\mathbb{N} \\
& & | & {\mathsf{mn}}{\mathsf{ab}}~\mathbb{N}~\mathbb{N}~\mathbb{N} \\
& & | & {\mathsf{op}}{\mathsf{ab}}{\mathbb{N}}~\mathbb{N}~\mathbb{N} \\
& & | & {{\mathsf{qr}}_{\mathbb{N}}}{\mathsf{ab}}~\mathbb{N}~\mathbb{N} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{InfixArrow}} & ::= & {\mathbb{N}^\ast} \rightarrow_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\mathit{InfixArrow{\kern-0.1em\scriptstyle 2}}} & ::= & {\mathbb{N}^\ast} \Rightarrow_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\mathit{AtomArrow}} & ::= & {\mathbb{N}^?}~{\rightarrow}_{{\mathbb{N}^\ast}}\,{\mathbb{N}^\ast} \\
& {\mathit{AtomArrow{\kern-0.1em\scriptstyle 2}}} & ::= & {\mathbb{N}^?}~{\Rightarrow}_{{\mathbb{N}^\ast}}\,{\mathbb{N}^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{InfixArrow}}(a \rightarrow_{c} {}) & = & 0 \\
{\mathrm{InfixArrow}}(a \rightarrow_{c} b) & = & 0 \\
{\mathrm{InfixArrow}}(a \rightarrow_{{c^\ast}} b) & = & 0 \\
{\mathrm{InfixArrow}}(a \rightarrow_{c} b_1~b_2) & = & 0 \\
{\mathrm{InfixArrow}}(a \rightarrow_{{c^\ast}} b_1~b_2) & = & 0 \\
{\mathrm{InfixArrow}}(a \rightarrow_{c_1~c_2} b_1~b_2) & = & 0 \\
{\mathrm{InfixArrow}}({\rightarrow}_{c_1~c_2} b_1~b_2) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{InfixArrow{\kern-0.1em\scriptstyle 2}}}(a \Rightarrow_{c} {}) & = & 0 \\
{\mathrm{InfixArrow{\kern-0.1em\scriptstyle 2}}}(a \Rightarrow_{c} b) & = & 0 \\
{\mathrm{InfixArrow{\kern-0.1em\scriptstyle 2}}}(a \Rightarrow_{{c^\ast}} b) & = & 0 \\
{\mathrm{InfixArrow{\kern-0.1em\scriptstyle 2}}}(a \Rightarrow_{c} b_1~b_2) & = & 0 \\
{\mathrm{InfixArrow{\kern-0.1em\scriptstyle 2}}}(a \Rightarrow_{{c^\ast}} b_1~b_2) & = & 0 \\
{\mathrm{InfixArrow{\kern-0.1em\scriptstyle 2}}}(a \Rightarrow_{c_1~c_2} b_1~b_2) & = & 0 \\
{\mathrm{InfixArrow{\kern-0.1em\scriptstyle 2}}}({\Rightarrow}_{c_1~c_2} b_1~b_2) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{AtomArrow}}(a~{\rightarrow}_{c}) & = & 0 \\
{\mathrm{AtomArrow}}(a~{\rightarrow}_{c}\,b) & = & 0 \\
{\mathrm{AtomArrow}}(a~{\rightarrow}_{{c^\ast}}\,b) & = & 0 \\
{\mathrm{AtomArrow}}(a~{\rightarrow}_{c}\,b_1~b_2) & = & 0 \\
{\mathrm{AtomArrow}}(a~{\rightarrow}_{{c^\ast}}\,b_1~b_2) & = & 0 \\
{\mathrm{AtomArrow}}(a~{\rightarrow}_{c_1~c_2}\,b_1~b_2) & = & 0 \\
{\mathrm{AtomArrow}}({\rightarrow}_{c_1~c_2}\,b_1~b_2) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{AtomArrow{\kern-0.1em\scriptstyle 2}}}(a~{\Rightarrow}_{c}) & = & 0 \\
{\mathrm{AtomArrow{\kern-0.1em\scriptstyle 2}}}(a~{\Rightarrow}_{c}\,b) & = & 0 \\
{\mathrm{AtomArrow{\kern-0.1em\scriptstyle 2}}}(a~{\Rightarrow}_{{c^\ast}}\,b) & = & 0 \\
{\mathrm{AtomArrow{\kern-0.1em\scriptstyle 2}}}(a~{\Rightarrow}_{c}\,b_1~b_2) & = & 0 \\
{\mathrm{AtomArrow{\kern-0.1em\scriptstyle 2}}}(a~{\Rightarrow}_{{c^\ast}}\,b_1~b_2) & = & 0 \\
{\mathrm{AtomArrow{\kern-0.1em\scriptstyle 2}}}(a~{\Rightarrow}_{c_1~c_2}\,b_1~b_2) & = & 0 \\
{\mathrm{AtomArrow{\kern-0.1em\scriptstyle 2}}}({\Rightarrow}_{c_1~c_2}\,b_1~b_2) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{MacroInfixArrow}} & ::= & {\mathbb{N}^\ast} \rightarrow_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\mathit{MacroAtomArrow}} & ::= & {\mathbb{N}^\ast} \rightarrow_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{MacroInfixArrow}}(a \rightarrow_{c} {}) & = & 0 \\
{\mathrm{MacroInfixArrow}}(a \rightarrow_{c} b) & = & 0 \\
{\mathrm{MacroInfixArrow}}(a \rightarrow_{{c^\ast}} b) & = & 0 \\
{\mathrm{MacroInfixArrow}}(a \rightarrow_{c} b_1~b_2) & = & 0 \\
{\mathrm{MacroInfixArrow}}(a \rightarrow_{{c^\ast}} b_1~b_2) & = & 0 \\
{\mathrm{MacroInfixArrow}}(a \rightarrow_{c_1~c_2} b_1~b_2) & = & 0 \\
{\mathrm{MacroInfixArrow}}({\rightarrow}_{c_1~c_2} b_1~b_2) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{MacroAtomArrow}}(a \rightarrow_{c} {}) & = & 0 \\
{\mathrm{MacroAtomArrow}}(a \rightarrow_{c} b) & = & 0 \\
{\mathrm{MacroAtomArrow}}(a \rightarrow_{{c^\ast}} b) & = & 0 \\
{\mathrm{MacroAtomArrow}}(a \rightarrow_{c} b_1~b_2) & = & 0 \\
{\mathrm{MacroAtomArrow}}(a \rightarrow_{{c^\ast}} b_1~b_2) & = & 0 \\
{\mathrm{MacroAtomArrow}}(a \rightarrow_{c_1~c_2} b_1~b_2) & = & 0 \\
{\mathrm{MacroAtomArrow}}({\rightarrow}_{c_1~c_2} b_1~b_2) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{ShowInfixArrow}} & ::= & {\mathbb{N}^\ast} \rightarrow_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\mathit{ShowAtomArrow}} & ::= & {\mathbb{N}^\ast}~{\rightarrow}_{{\mathbb{N}^\ast}}\,{\mathbb{N}^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{ShowInfixArrow}}(a \rightarrow_{c} ) & = & 0 \\
{\mathrm{ShowInfixArrow}}(a \rightarrow_{c} b) & = & 0 \\
{\mathrm{ShowInfixArrow}}(a \rightarrow_{({c^\ast})} b) & = & 0 \\
{\mathrm{ShowInfixArrow}}(a \rightarrow_{c} b_1~b_2) & = & 0 \\
{\mathrm{ShowInfixArrow}}(a \rightarrow_{({c^\ast})} b_1~b_2) & = & 0 \\
{\mathrm{ShowInfixArrow}}(a \rightarrow_{(c_1~c_2)} b_1~b_2) & = & 0 \\
{\mathrm{ShowInfixArrow}}({\rightarrow}_{(c_1~c_2)} b_1~b_2) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{ShowAtomArrow}}(a~{\rightarrow}_{c}) & = & 0 \\
{\mathrm{ShowAtomArrow}}(a~{\rightarrow}_{c}\,b) & = & 0 \\
{\mathrm{ShowAtomArrow}}(a~{\rightarrow}_{({c^\ast})}\,b) & = & 0 \\
{\mathrm{ShowAtomArrow}}(a~{\rightarrow}_{c}\,b_1~b_2) & = & 0 \\
{\mathrm{ShowAtomArrow}}(a~{\rightarrow}_{({c^\ast})}\,b_1~b_2) & = & 0 \\
{\mathrm{ShowAtomArrow}}(a~{\rightarrow}_{(c_1~c_2)}\,b_1~b_2) & = & 0 \\
{\mathrm{ShowAtomArrow}}({\rightarrow}_{(c_1~c_2)}\,b_1~b_2) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{ShowMacroInfixArrow}} & ::= & {\mathbb{N}^\ast} \rightarrow_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\mathit{ShowMacroAtomArrow}} & ::= & {\mathbb{N}^\ast}~{\rightarrow}_{{\mathbb{N}^\ast}}\,{\mathbb{N}^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{ShowMacroInfixArrow}}(a \rightarrow_{c} ) & = & 0 \\
{\mathrm{ShowMacroInfixArrow}}(a \rightarrow_{c} b) & = & 0 \\
{\mathrm{ShowMacroInfixArrow}}(a \rightarrow_{({c^\ast})} b) & = & 0 \\
{\mathrm{ShowMacroInfixArrow}}(a \rightarrow_{c} b_1~b_2) & = & 0 \\
{\mathrm{ShowMacroInfixArrow}}(a \rightarrow_{({c^\ast})} b_1~b_2) & = & 0 \\
{\mathrm{ShowMacroInfixArrow}}(a \rightarrow_{(c_1~c_2)} b_1~b_2) & = & 0 \\
{\mathrm{ShowMacroInfixArrow}}({\rightarrow}_{(c_1~c_2)} b_1~b_2) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{ShowMacroAtomArrow}}(a~{\rightarrow}_{c}) & = & 0 \\
{\mathrm{ShowMacroAtomArrow}}(a~{\rightarrow}_{c}\,b) & = & 0 \\
{\mathrm{ShowMacroAtomArrow}}(a~{\rightarrow}_{({c^\ast})}\,b) & = & 0 \\
{\mathrm{ShowMacroAtomArrow}}(a~{\rightarrow}_{c}\,b_1~b_2) & = & 0 \\
{\mathrm{ShowMacroAtomArrow}}(a~{\rightarrow}_{({c^\ast})}\,b_1~b_2) & = & 0 \\
{\mathrm{ShowMacroAtomArrow}}(a~{\rightarrow}_{(c_1~c_2)}\,b_1~b_2) & = & 0 \\
{\mathrm{ShowMacroAtomArrow}}({\rightarrow}_{(c_1~c_2)}\,b_1~b_2) & = & 0 \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{fii}} & ::= & \mathsf{fii} \\
& {\mathit{faa}} & ::= & \mathsf{faa} \\
& {\mathit{foo}} & ::= & \mathsf{foo} \\
& {\mathit{fuu}} & ::= & \mathsf{fuu} \\
& {\mathit{foobar}} & ::= & \mathsf{bar} \\
& {\mathit{fooboo}} & ::= & \mathsf{boo} \\
& {\mathit{fob}} & ::= & \mathsf{baz} \\
& {\mathit{fib}} & ::= & \mathsf{boi} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{macros{\kern-0.1em\scriptstyle 1}}} & = & 0 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {\mathit{fii}} = \mathsf{fii} \\
{\land}~ {\mathit{faa}} = \mathsf{faa} \\
{\land}~ {\mathit{foo}} = \mathsf{foo} \\
{\land}~ {\mathit{fuu}} = \mathsf{fuu} \\
{\land}~ {\mathit{foobar}} = \mathsf{bar} \\
{\land}~ {\mathit{fooboo}} = \mathsf{boo} \\
{\land}~ {\mathit{fob}} = \mathsf{baz} \\
{\land}~ {\mathit{fib}} = \mathsf{boi} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{ufii}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2) & ::= & \mathsf{ufii} \\
& {{\mathit{ufaa}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2) & ::= & \mathsf{ufaa} \\
& {{\mathit{ufoo}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2) & ::= & \mathsf{ufoo} \\
& {{\mathit{ufuu}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2) & ::= & \mathsf{ufuu} \\
& {{\mathit{ufoobar}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2, z) & ::= & \mathsf{ubar} \\
& {{\mathit{ufooboo}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2, z) & ::= & \mathsf{uboo} \\
& {{\mathit{ufob}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2, z) & ::= & \mathsf{ubaz} \\
& {{\mathit{ufib}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2, z) & ::= & \mathsf{uboi} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{macros{\kern-0.1em\scriptstyle 2}}} & = & 0 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {\mathit{ufii}} = \mathsf{ufii} \\
{\land}~ {\mathit{ufaa}} = \mathsf{ufaa} \\
{\land}~ {\mathit{ufoo}} = \mathsf{ufoo} \\
{\land}~ {\mathit{ufuu}} = \mathsf{ufuu} \\
{\land}~ {\mathit{ubar}} = \mathsf{ubar} \\
{\land}~ {\mathit{uboo}} = \mathsf{uboo} \\
{\land}~ {\mathit{ubaz}} = \mathsf{ubaz} \\
{\land}~ {\mathit{uboi}} = \mathsf{uboi} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{fii}} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{faa}} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{foo}} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{fuu}} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathit{foobar}} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathit{fooboo}} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathit{fob}} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathit{fib}} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ufii}}}_{x}(y) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ufaa}}}_{x}(y) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ufoo}}}_{x}(y) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ufuu}}}_{x}(y) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{ufoobar}}}_{x}(y, z) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{ufooboo}}}_{x}(y, z) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{ufob}}}_{x}(y, z) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{ufib}}}_{x}(y, z) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{foo\_bar}} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{foo\_boo}} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ufoo\_bar}}}_{x}(y) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ufoo\_boo}}}_{x}(y, z) & = & 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{parent}} & ::= & \mathsf{aa} \\
& & | & \mathsf{aax} \\
& & | & \mathsf{aay} \\
& & | & \mathsf{aaz} \\
& & | & \mathsf{bbb} \\
& & | & \mathsf{bbbx} \\
& & | & \mathsf{bbby} \\
& & | & \mathsf{bbbz} \\
& & | & \mathsf{cc}~\mathbb{N}~\mathsf{cccc} \\
& & | & \mathsf{ccx}~\mathbb{N}~\mathsf{ccxx} \\
& & | & \mathsf{ccy}~\mathbb{N}~\mathsf{ccyy} \\
& & | & \mathsf{ccz}~\mathbb{N}~\mathsf{cczz} \\
& & | & \mathsf{ddd}~\mathbb{N}~{\mathit{child}}~{\mathrm{foo}}~{\mathrm{fuu}}~{\mathrm{fiz}} \\
& & | & \mathsf{dddx}~\mathbb{N}~{\mathit{child}} \\
& & | & \mathsf{dddy}~\mathbb{N}~{\mathit{child}} \\
& & | & \mathsf{dddz}~\mathbb{N}~{\mathit{child}} \\
& & | & {\mathbb{N}}{\mathsf{\_}}{\mathsf{ea}}{\mathsf{ee}}~z \\
& & | & {\mathbb{N}}{\mathsf{\_}}{\mathsf{eb}}{\mathsf{eex}}~z \\
& & | & {\mathbb{N}}{\mathsf{\_}}{\mathsf{ec}}{\mathsf{eey}}~z \\
& & | & {\mathbb{N}}{\mathsf{\_}}{\mathsf{ed}}{\mathsf{eez}}~z \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{parent}}(\mathsf{aa}) & = & 0 \\
{\mathrm{parent}}(\mathsf{aax}) & = & 0 \\
{\mathrm{parent}}(\mathsf{aay}) & = & 0 \\
{\mathrm{parent}}(\mathsf{aaz}) & = & 0 \\
{\mathrm{parent}}(\mathsf{bbb}) & = & 0 \\
{\mathrm{parent}}(\mathsf{bbbx}) & = & 0 \\
{\mathrm{parent}}(\mathsf{bbby}) & = & 0 \\
{\mathrm{parent}}(\mathsf{bbbz}) & = & 0 \\
{\mathrm{parent}}(\mathsf{cc}~n~\mathsf{cccc}) & = & 0 \\
{\mathrm{parent}}(\mathsf{ccx}~n~\mathsf{ccxx}) & = & 0 \\
{\mathrm{parent}}(\mathsf{ccy}~n~\mathsf{ccyy}) & = & 0 \\
{\mathrm{parent}}(\mathsf{ccz}~n~\mathsf{cczz}) & = & 0 \\
{\mathrm{parent}}(\mathsf{ddd}~n~{\mathit{child}}~{\mathrm{foo}}~{\mathrm{fuu}}~{\mathrm{fiz}}) & = & 0 \\
{\mathrm{parent}}(\mathsf{dddx}~n~{\mathit{child}}) & = & 0 \\
{\mathrm{parent}}(\mathsf{dddy}~n~{\mathit{child}}) & = & 0 \\
{\mathrm{parent}}(\mathsf{dddz}~n~{\mathit{child}}) & = & 0 \\
{\mathrm{parent}}({n}{\mathsf{\_}}{\mathsf{ea}}{\mathsf{ee}}~z) & = & 0 \\
{\mathrm{parent}}({n}{\mathsf{\_}}{\mathsf{eb}}{\mathsf{eex}}~z) & = & 0 \\
{\mathrm{parent}}({n}{\mathsf{\_}}{\mathsf{ec}}{\mathsf{eey}}~z) & = & 0 \\
{\mathrm{parent}}({n}{\mathsf{\_}}{\mathsf{ed}}{\mathsf{eez}}~z) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{parentimplicit}}(t) & ::= & \mathsf{pp} \\
& & | & \mathsf{ppx} \\
& & | & \mathsf{ppy} \\
& & | & \mathsf{ppz} \\
& & | & \mathsf{qqq} \\
& & | & \mathsf{qqqx} \\
& & | & \mathsf{qqqy} \\
& & | & \mathsf{qqqz} \\
& & | & {t}{\mathsf{\_}}{\mathsf{ra}}{\mathsf{rr}}~z \\
& & | & {t}{\mathsf{\_}}{\mathsf{rb}}{\mathsf{rrx}}~z \\
& & | & {t}{\mathsf{\_}}{\mathsf{rc}}{\mathsf{rry}}~z \\
& & | & {t}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{parentimpl}}(\mathsf{pp}) & = & 0 \\
{\mathrm{parentimpl}}(\mathsf{ppx}) & = & 0 \\
{\mathrm{parentimpl}}(\mathsf{ppy}) & = & 0 \\
{\mathrm{parentimpl}}(\mathsf{ppz}) & = & 0 \\
{\mathrm{parentimpl}}(\mathsf{qqq}) & = & 0 \\
{\mathrm{parentimpl}}(\mathsf{qqqx}) & = & 0 \\
{\mathrm{parentimpl}}(\mathsf{qqqy}) & = & 0 \\
{\mathrm{parentimpl}}(\mathsf{qqqz}) & = & 0 \\
{\mathrm{parentimpl}}({n}{\mathsf{\_}}{\mathsf{ra}}{\mathsf{rr}}~z) & = & 0 \\
{\mathrm{parentimpl}}({n}{\mathsf{\_}}{\mathsf{rb}}{\mathsf{rrx}}~z) & = & 0 \\
{\mathrm{parentimpl}}({n}{\mathsf{\_}}{\mathsf{rc}}{\mathsf{rry}}~z) & = & 0 \\
{\mathrm{parentimpl}}({n}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{indirect}} & ::= & {\mathit{parentimplicit}}(\mathbb{N}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{indirect}}(\mathsf{pp}) & = & 0 \\
{\mathrm{indirect}}(\mathsf{ppx}) & = & 0 \\
{\mathrm{indirect}}(\mathsf{ppy}) & = & 0 \\
{\mathrm{indirect}}(\mathsf{ppz}) & = & 0 \\
{\mathrm{indirect}}(\mathsf{qqq}) & = & 0 \\
{\mathrm{indirect}}(\mathsf{qqqx}) & = & 0 \\
{\mathrm{indirect}}(\mathsf{qqqy}) & = & 0 \\
{\mathrm{indirect}}(\mathsf{qqqz}) & = & 0 \\
{\mathrm{indirect}}({n}{\mathsf{\_}}{\mathsf{ra}}{\mathsf{rr}}~z) & = & 0 \\
{\mathrm{indirect}}({n}{\mathsf{\_}}{\mathsf{rb}}{\mathsf{rrx}}~z) & = & 0 \\
{\mathrm{indirect}}({n}{\mathsf{\_}}{\mathsf{rc}}{\mathsf{rry}}~z) & = & 0 \\
{\mathrm{indirect}}({n}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{family}}(0) & ::= & \mathsf{ff} \\
& {\mathit{family}}(1) & ::= & \mathsf{gg} \\
& {\mathit{family}}(2) & ::= & \mathsf{hh} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{family}}(0, \mathsf{ff}) & = & 0 \\
{\mathrm{family}}(1, \mathsf{gg}) & = & 0 \\
{\mathrm{family}}(2, \mathsf{hh}) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{child}} & ::= & {\mathit{parent}} ~|~ {\mathit{family}}(0) ~|~ {\mathit{indirect}} ~|~ \mathsf{zzz} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{child}}(\mathsf{aa}) & = & 0 \\
{\mathrm{child}}(\mathsf{aax}) & = & 0 \\
{\mathrm{child}}(\mathsf{aay}) & = & 0 \\
{\mathrm{child}}(\mathsf{aaz}) & = & 0 \\
{\mathrm{child}}(\mathsf{bbb}) & = & 0 \\
{\mathrm{child}}(\mathsf{bbbx}) & = & 0 \\
{\mathrm{child}}(\mathsf{bbby}) & = & 0 \\
{\mathrm{child}}(\mathsf{bbbz}) & = & 0 \\
{\mathrm{child}}(\mathsf{cc}~n~\mathsf{cccc}) & = & 0 \\
{\mathrm{child}}(\mathsf{ccx}~n~\mathsf{ccxx}) & = & 0 \\
{\mathrm{child}}(\mathsf{ccy}~n~\mathsf{ccyy}) & = & 0 \\
{\mathrm{child}}(\mathsf{ccz}~n~\mathsf{cczz}) & = & 0 \\
{\mathrm{child}}(\mathsf{ddd}~n~{\mathit{child}}~{\mathrm{foo}}~{\mathrm{fuu}}~{\mathrm{fiz}}) & = & 0 \\
{\mathrm{child}}(\mathsf{dddx}~n~{\mathit{child}}) & = & 0 \\
{\mathrm{child}}(\mathsf{dddy}~n~{\mathit{child}}) & = & 0 \\
{\mathrm{child}}(\mathsf{dddz}~n~{\mathit{child}}) & = & 0 \\
{\mathrm{child}}({n}{\mathsf{\_}}{\mathsf{ea}}{\mathsf{ee}}~z) & = & 0 \\
{\mathrm{child}}({n}{\mathsf{\_}}{\mathsf{eb}}{\mathsf{eex}}~z) & = & 0 \\
{\mathrm{child}}({n}{\mathsf{\_}}{\mathsf{ec}}{\mathsf{eey}}~z) & = & 0 \\
{\mathrm{child}}({n}{\mathsf{\_}}{\mathsf{ed}}{\mathsf{eez}}~z) & = & 0 \\
{\mathrm{child}}(\mathsf{ff}) & = & 0 \\
{\mathrm{child}}(\mathsf{pp}) & = & 0 \\
{\mathrm{child}}(\mathsf{ppx}) & = & 0 \\
{\mathrm{child}}(\mathsf{ppy}) & = & 0 \\
{\mathrm{child}}(\mathsf{ppz}) & = & 0 \\
{\mathrm{child}}(\mathsf{qqq}) & = & 0 \\
{\mathrm{child}}(\mathsf{qqqx}) & = & 0 \\
{\mathrm{child}}(\mathsf{qqqy}) & = & 0 \\
{\mathrm{child}}(\mathsf{qqqz}) & = & 0 \\
{\mathrm{child}}({n}{\mathsf{\_}}{\mathsf{ra}}{\mathsf{rr}}~z) & = & 0 \\
{\mathrm{child}}({n}{\mathsf{\_}}{\mathsf{rb}}{\mathsf{rrx}}~z) & = & 0 \\
{\mathrm{child}}({n}{\mathsf{\_}}{\mathsf{rc}}{\mathsf{rry}}~z) & = & 0 \\
{\mathrm{child}}({n}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z) & = & 0 \\
{\mathrm{child}}(\mathsf{zzz}) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{grandchild}} & ::= & {\mathit{child}} ~|~ \mathsf{zzzz} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{grandchild}}(\mathsf{aa}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{aax}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{aay}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{aaz}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{bbb}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{bbbx}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{bbby}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{bbbz}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{cc}~n~\mathsf{cccc}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{ccx}~n~\mathsf{ccxx}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{ccy}~n~\mathsf{ccyy}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{ccz}~n~\mathsf{cczz}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{ddd}~n~{\mathit{child}}~{\mathrm{foo}}~{\mathrm{fuu}}~{\mathrm{fiz}}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{dddx}~n~{\mathit{child}}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{dddy}~n~{\mathit{child}}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{dddz}~n~{\mathit{child}}) & = & 0 \\
{\mathrm{grandchild}}({n}{\mathsf{\_}}{\mathsf{ea}}{\mathsf{ee}}~z) & = & 0 \\
{\mathrm{grandchild}}({n}{\mathsf{\_}}{\mathsf{eb}}{\mathsf{eex}}~z) & = & 0 \\
{\mathrm{grandchild}}({n}{\mathsf{\_}}{\mathsf{ec}}{\mathsf{eey}}~z) & = & 0 \\
{\mathrm{grandchild}}({n}{\mathsf{\_}}{\mathsf{ed}}{\mathsf{eez}}~z) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{ff}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{pp}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{ppx}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{ppy}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{ppz}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{qqq}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{qqqx}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{qqqy}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{qqqz}) & = & 0 \\
{\mathrm{grandchild}}({n}{\mathsf{\_}}{\mathsf{ra}}{\mathsf{rr}}~z) & = & 0 \\
{\mathrm{grandchild}}({n}{\mathsf{\_}}{\mathsf{rb}}{\mathsf{rrx}}~z) & = & 0 \\
{\mathrm{grandchild}}({n}{\mathsf{\_}}{\mathsf{rc}}{\mathsf{rry}}~z) & = & 0 \\
{\mathrm{grandchild}}({n}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{zzz}) & = & 0 \\
{\mathrm{grandchild}}(\mathsf{zzzz}) & = & 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{rec}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{fa}~{\mathbb{N}^\ast} \\
\mathsf{fb}~{\mathbb{N}^\ast} \\
\mathsf{fc}~{\mathbb{N}^\ast} \\
\mathsf{fd}~{\mathbb{N}^\ast} \\
\mathsf{fee}~{\mathbb{N}^\ast} \\
\mathsf{fff}~{\mathbb{N}^\ast} \\
\mathsf{fgg}~{\mathbb{N}^\ast} \\
\mathsf{fhh}~{\mathbb{N}^\ast} \} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{proj}}(r, 0) & = & r{.}\mathsf{fa} \\
{\mathrm{proj}}(r, 1) & = & r{.}\mathsf{fb} \\
{\mathrm{proj}}(r, 2) & = & r{.}\mathsf{fc} \\
{\mathrm{proj}}(r, 3) & = & r{.}\mathsf{fd} \\
{\mathrm{proj}}(r, 4) & = & r{.}\mathsf{fee} \\
{\mathrm{proj}}(r, 5) & = & r{.}\mathsf{fff} \\
{\mathrm{proj}}(r, 6) & = & r{.}\mathsf{fgg} \\
{\mathrm{proj}}(r, 7) & = & r{.}\mathsf{fhh} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{upd}}(r, 0) & = & r{}[{.}\mathsf{fa} = 0] \\
{\mathrm{upd}}(r, 1) & = & r{}[{.}\mathsf{fb} = 0] \\
{\mathrm{upd}}(r, 2) & = & r{}[{.}\mathsf{fc} = 0] \\
{\mathrm{upd}}(r, 3) & = & r{}[{.}\mathsf{fd} = 0] \\
{\mathrm{upd}}(r, 4) & = & r{}[{.}\mathsf{fee} = 0] \\
{\mathrm{upd}}(r, 5) & = & r{}[{.}\mathsf{fff} = 0] \\
{\mathrm{upd}}(r, 6) & = & r{}[{.}\mathsf{fgg} = 0] \\
{\mathrm{upd}}(r, 7) & = & r{}[{.}\mathsf{fhh} = 0] \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{ext}}(r, 0) & = & r{}[{.}\mathsf{fa} \mathrel{{=}{\oplus}} 0] \\
{\mathrm{ext}}(r, 1) & = & r{}[{.}\mathsf{fb} \mathrel{{=}{\oplus}} 0] \\
{\mathrm{ext}}(r, 2) & = & r{}[{.}\mathsf{fc} \mathrel{{=}{\oplus}} 0] \\
{\mathrm{ext}}(r, 3) & = & r{}[{.}\mathsf{fd} \mathrel{{=}{\oplus}} 0] \\
{\mathrm{ext}}(r, 4) & = & r{}[{.}\mathsf{fee} \mathrel{{=}{\oplus}} 0] \\
{\mathrm{ext}}(r, 5) & = & r{}[{.}\mathsf{fff} \mathrel{{=}{\oplus}} 0] \\
{\mathrm{ext}}(r, 6) & = & r{}[{.}\mathsf{fgg} \mathrel{{=}{\oplus}} 0] \\
{\mathrm{ext}}(r, 7) & = & r{}[{.}\mathsf{fhh} \mathrel{{=}{\oplus}} 0] \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{recimpl}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{fia}~{\mathbb{N}^\ast} \\
\mathsf{fib}~{\mathbb{N}^\ast} \\
\mathsf{fic}~{\mathbb{N}^\ast} \\
\mathsf{fid}~{\mathbb{N}^\ast} \\
\mathsf{fiee}~{\mathbb{N}^\ast} \\
\mathsf{fiff}~{\mathbb{N}^\ast} \\
\mathsf{figg}~{\mathbb{N}^\ast} \\
\mathsf{fihh}~{\mathbb{N}^\ast} \} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{rproj}}(r, 0) & = & r{.}\mathsf{fia} \\
{\mathrm{rproj}}(r, 1) & = & r{.}\mathsf{fib} \\
{\mathrm{rproj}}(r, 2) & = & r{.}\mathsf{fic} \\
{\mathrm{rproj}}(r, 3) & = & r{.}\mathsf{fid} \\
{\mathrm{rproj}}(r, 4) & = & r{.}\mathsf{fiee} \\
{\mathrm{rproj}}(r, 5) & = & r{.}\mathsf{fiff} \\
{\mathrm{rproj}}(r, 6) & = & r{.}\mathsf{figg} \\
{\mathrm{rproj}}(r, 7) & = & r{.}\mathsf{fihh} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{cona}} & ::= & \mathbb{N}~\mathsf{coa}~\mathbb{N} \\
& {\mathit{conb}} & ::= & \mathbb{N}~\mathsf{cob}~\mathbb{N} \\
& {\mathit{conc}} & ::= & \mathbb{N}~\mathsf{coc}~\mathbb{N} \\
& {\mathit{cond}} & ::= & \mathbb{N}~\mathsf{cod}~\mathbb{N} \\
& {\mathit{cone}} & ::= & \mathbb{N}~\mathsf{coe}~\mathbb{N} \\
& {\mathit{conf}} & ::= & \mathbb{N}~\mathsf{cof}~\mathbb{N} \\
& {\mathit{cong}} & ::= & \mathbb{N}~\mathsf{cog}~\mathbb{N} \\
& {\mathit{conh}} & ::= & \mathbb{N}~\mathsf{coh}~\mathbb{N} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& C & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
 \} \\
\end{array} \\
\end{array}
$$

$\boxed{C \vdash {\mathit{parent}} : \mathsf{ok}}$

$\boxed{C \vdash {\mathit{parent}} \leq {\mathit{parent}}}$

$\boxed{{\mathit{parent}} ; {\mathit{child}} \hookrightarrow {\mathit{parent}} ; {\mathit{child}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{aa} : \mathsf{ok}
} \, {[\textsc{\scriptsize Rok}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{parent}} \leq \mathsf{aa}
} \, {[\textsc{\scriptsize Rsub}]}
\qquad
\end{array}
$$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize Reval}]} \quad & {\mathit{parent}} ; {\mathit{child}} & \hookrightarrow & \mathsf{aa} ; \mathsf{bbb} \\
\end{array}
$$

$\boxed{C \vdash {\mathit{parent}} : \mathsf{ok}}$

$\boxed{C \vdash {\mathit{parent}} \leq {\mathit{parent}}}$

$\boxed{{\mathit{parent}} ; {\mathit{child}} \hookrightarrow {\mathit{parent}} ; {\mathit{child}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{aa} : \mathsf{ok}
} \, {[\textsc{\scriptsize Rok\_macro}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{parent}} \leq \mathsf{aa}
} \, {[\textsc{\scriptsize Rsub\_macro}]}
\qquad
\end{array}
$$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize Reval\_macro}]} \quad & {\mathit{parent}} ; {\mathit{child}} & \hookrightarrow & \mathsf{aa} ; \mathsf{bbb} \\
\end{array}
$$

$\boxed{C \vdash {\mathit{parent}} : \mathsf{ok}}$

$\boxed{C \vdash {\mathit{parent}} \leq {\mathit{parent}}}$

$\boxed{{\mathit{parent}} ; {\mathit{child}} \hookrightarrow {\mathit{parent}} ; {\mathit{child}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{aa} : \mathsf{ok}
} \, {[\textsc{\scriptsize Rok\_nomacro}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{parent}} \leq \mathsf{aa}
} \, {[\textsc{\scriptsize Rsub\_nomacro}]}
\qquad
\end{array}
$$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize Reval\_nomacro}]} \quad & {\mathit{parent}} ; {\mathit{child}} & \hookrightarrow & \mathsf{aa} ; \mathsf{bbb} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{argh}} & ::= & \mathsf{argh} \\
& {\mathit{borg}} & ::= & \mathsf{borg} \\
& {\mathit{curb}} & ::= & \mathsf{curb} \\
& {\mathit{dork}} & ::= & \mathsf{dork} \\
& {\mathit{eerk}} & ::= & \mathsf{eerk} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{dotstypex}} & ::= & {\mathit{argh}} ~|~ \mathsf{dx{\scriptstyle 1}} ~|~ \dots \\
& {\mathit{dotstypey}} & ::= & {\mathit{argh}} ~|~ \mathsf{dy{\scriptstyle 1}} ~|~ \dots \\
& {\mathit{dotstypex}} & ::= & \dots ~|~ {\mathit{borg}} ~|~ \mathsf{dx{\scriptstyle 2}} ~|~ \dots \\
& {\mathit{dotstypesep}} & ::= & {\mathit{borg}} \\
& {\mathit{dotstypex}} & ::= & \dots \\
& & | & {\mathit{curb}} ~|~ \mathsf{dx{\scriptstyle 3}} \\
& & | & \mathsf{dx{\scriptstyle 4}} ~|~ \mathsf{dx{\scriptstyle 5}} \\
& & | & \mathsf{dx{\scriptstyle 6}} ~|~ \dots \\
& {\mathit{dotstypey}} & ::= & \dots \\
& & | & {\mathit{borg}} ~|~ \mathsf{dy{\scriptstyle 2}} \\
& & | & \mathsf{dy{\scriptstyle 3}} ~|~ \mathsf{dy{\scriptstyle 4}} \\
& & | & \dots \\
& {\mathit{dotstypex}} & ::= & \dots ~|~ {\mathit{dork}} ~|~ \mathsf{dx{\scriptstyle 7}} \\
& {\mathit{dotstypey}} & ::= & \dots \\
& & | & {\mathit{dork}} \\
& & | & \mathsf{dy{\scriptstyle 5}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{casetype}} & ::= & \mathsf{la}~\mathbb{N}~{\mathit{argh}} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ \mathbb{N} = 0 \\
{\land}~ {\mathit{argh}} \neq \mathsf{argh} \\
\end{array} \\
& & | & \mathsf{lb}~{\mathit{borg}}~{\mathit{curb}} \\
& & | & \mathsf{lc}~{\mathit{dork}}_1~{\mathit{dork}}_2 & \quad \mbox{if}~ {\mathit{dork}}_1 \neq {\mathit{dork}}_2 \\
& & | & \mathsf{ld}~{\mathit{argh}}~\mathbb{N} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ \mathbb{N} > 0 \\
{\land}~ {\mathit{argh}} \neq \mathsf{argh} \\
\end{array} \\
& & | & \mathsf{le}~{\mathit{nat}}_1~{\mathit{nat}}_2 & \quad \mbox{if}~ {\mathit{nat}}_1 \leq {\mathit{nat}}_2 \\
& & | & \mathsf{lfa}~{\mathit{borg}} ~|~ \mathsf{lfb}~{\mathit{borg}} ~|~ \mathsf{lfc}~{\mathit{borg}} \\
& & | & \begin{array}[t]{@{}l@{}} \mathsf{lh}~{\mathit{borg}} \\
  {\mathit{argh}}~{\mathit{eerk}} \end{array} \\
& & | & \begin{array}[t]{@{}l@{}} \mathsf{li}~{\mathit{borg}} \\
  {\mathit{argh}}~{\mathit{eerk}} \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
& & | & \mathsf{lj}~{\mathit{borg}} &   \\
&&& \multicolumn{2}{@{}l@{}}{\quad  \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} } \\
& & | & \begin{array}[t]{@{}l@{}} \mathsf{lk}~{\mathit{borg}} \\
  {\mathit{argh}}~{\mathit{eerk}} \end{array} &   \\
&&& \multicolumn{2}{@{}l@{}}{\quad  \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} } \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{gram}} & ::= & \mbox{\texttt{`GA'}}~~\mbox{\texttt{`GB'}} & \quad\Rightarrow\quad & 0 & \quad \mbox{if}~ 0 < 1 \\
& & | & \mbox{\texttt{`GB'}}~~\mbox{\texttt{`GC'}}~~\mbox{\texttt{`GD'}} & \quad\Rightarrow\quad & 0 \\
& & | & \mbox{\texttt{`GC'}}~~\mbox{\texttt{`GD'}} & \quad\Rightarrow\quad & 0 & \quad \mbox{if}~ 0 < 1 \\
& & | & \mbox{\texttt{`GD'}}~~\mbox{\texttt{`GE'}} & \quad\Rightarrow\quad & 0 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
& & | & \mbox{\texttt{`GE'}}~~\mbox{\texttt{`GF'}} & \quad\Rightarrow\quad & 0 & \quad \mbox{if}~ 0 < 1 \\
& & | & \mbox{\texttt{`GFA'}}~~\mbox{\texttt{`GF'}} ~\Rightarrow~ 0 ~|~ \mbox{\texttt{`GFB'}}~~\mbox{\texttt{`GF'}} ~\Rightarrow~ 1 ~|~ \mbox{\texttt{`GFC'}} & \quad\Rightarrow\quad & 2 \\
& & | & \mbox{\texttt{`GG'}} & \quad\Rightarrow\quad &  & \\
&&& \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}} 0 & \quad \mbox{if}~ 1 > 0 \end{array} } \\
& & | & \mbox{\texttt{`GH'}} & \quad\Rightarrow\quad &  & \\
&&& \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}} 0 & \quad \mbox{if}~ 1 > 0 \end{array} } \\
& & | & \mbox{\texttt{`GI'}} & \quad\Rightarrow\quad &  & \\
&&& \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}} \begin{array}[t]{@{}l@{}} 0 \\
  1 \\
  2 \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \end{array} } \\
& & | & \mbox{\texttt{`GJ'}}~~\mbox{\texttt{`GJ'}} \\
  &&& \mbox{\texttt{`G'}}~~\mbox{\texttt{`J'}} & \quad\Rightarrow\quad & 0 \\
& & | & \mbox{\texttt{`GK'}}~~\mbox{\texttt{`GJ'}} \\
  &&& \mbox{\texttt{`G'}}~~\mbox{\texttt{`J'}} & \quad\Rightarrow\quad & 0 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
& & | & \mbox{\texttt{`GI'}} & \quad\Rightarrow\quad & 0~1~2 &   \\
&&& \multicolumn{4}{@{}l@{}}{\quad  \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} } \\
& & | & \mbox{\texttt{`GI'}} & \quad\Rightarrow\quad &  & \\
&&& \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}l@{}} \begin{array}[t]{@{}l@{}} 0 \\
  1 \\
  2 \end{array} &  & \\
 \multicolumn{3}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}} \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \end{array} } \end{array} } \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{func}}(n, m) & = & 0 \\
{\mathrm{func}}(n, m) & = & 0 & \quad \mbox{if}~ n < m \\
{\mathrm{func}}(n, m) & = & 0 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n > m \\
{\land}~ m < n \\
\end{array} \\
{\mathrm{func}}(n, m) & = & 0~1 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n < m \\
{\land}~ m > n \\
\end{array} \\
{\mathrm{func}}(n, m) & = &  & \\
 \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}} 0~1 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n < m \\
{\land}~ m > n \\
\end{array} \end{array} } \\
{\mathrm{func}}(n, m) & = &  & \\
 \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}} \begin{array}[t]{@{}l@{}} 0 \\
  1 \\
  2 \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n < m \\
{\land}~ m > n \\
\end{array} \end{array} } \\
{\mathrm{func}}(n, m) & = & 0~1~2 &   \\
&& \multicolumn{2}{@{}l@{}}{\quad  \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n < m \\
{\land}~ m > n \\
\end{array} } \\
{\mathrm{func}}(n, m) & = &  & \\
 \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}l@{}} \begin{array}[t]{@{}l@{}} 0 \\
  1 \\
  2 \end{array} &  & \\
 \multicolumn{3}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}} \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n < m \\
{\land}~ m > n \\
\end{array} \end{array} } \end{array} } \\
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{argh}}~{\mathit{borg}} \rightarrow {\mathit{curb}}~{\mathit{dork}}}$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize Rel{-}A}]} \quad & {\mathit{argh}}~{\mathit{borg}} & \rightarrow & {\mathit{curb}}~{\mathit{dork}} \\
{[\textsc{\scriptsize Rel{-}B}]} \quad & {\mathit{argh}}~{\mathit{borg}} & \rightarrow & {\mathit{curb}}~{\mathit{dork}} & \quad \mbox{if}~ 0 < 1 \\
{[\textsc{\scriptsize Rel{-}C}]} \quad & {\mathit{argh}}~{\mathit{borg}} & \rightarrow & {\mathit{curb}}~{\mathit{dork}} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
{[\textsc{\scriptsize Rel{-}D}]} \quad & {\mathit{argh}}~{\mathit{borg}} & \rightarrow & {\mathit{curb}}~{\mathit{dork}} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
{[\textsc{\scriptsize Rel{-}E}]} \quad & {\mathit{argh}}~{\mathit{borg}} & \rightarrow &  & \\
& \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}} {\mathit{curb}}~{\mathit{dork}} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \end{array} } \\
{[\textsc{\scriptsize Rel{-}F}]} \quad & {\mathit{argh}}~{\mathit{borg}} & \rightarrow & \begin{array}[t]{@{}l@{}} {\mathit{curb}} \\
  {\mathit{dork}} \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
{[\textsc{\scriptsize Rel{-}G}]} \quad & {\mathit{argh}}~{\mathit{borg}} & \rightarrow &  & \\
& \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}} \begin{array}[t]{@{}l@{}} {\mathit{curb}} \\
  {\mathit{dork}} \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \end{array} } \\
{[\textsc{\scriptsize Rel{-}DD}]} \quad & {\mathit{argh}}~{\mathit{borg}} & \rightarrow & {\mathit{curb}}~{\mathit{dork}} &   \\
&&& \multicolumn{2}{@{}l@{}}{\quad  \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} } \\
{[\textsc{\scriptsize Rel{-}EE}]} \quad & {\mathit{argh}}~{\mathit{borg}} & \rightarrow &  & \\
& \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}l@{}} {\mathit{curb}}~{\mathit{dork}} &  & \\
 \multicolumn{3}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}} \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \end{array} } \end{array} } \\
{[\textsc{\scriptsize Rel{-}FF}]} \quad & {\mathit{argh}}~{\mathit{borg}} & \rightarrow & \begin{array}[t]{@{}l@{}} {\mathit{curb}} \\
  {\mathit{dork}} \end{array} &   \\
&&& \multicolumn{2}{@{}l@{}}{\quad  \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} } \\
{[\textsc{\scriptsize Rel{-}GG}]} \quad & {\mathit{argh}}~{\mathit{borg}} & \rightarrow &  & \\
& \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}l@{}} \begin{array}[t]{@{}l@{}} {\mathit{curb}} \\
  {\mathit{dork}} \end{array} &  & \\
 \multicolumn{3}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}} \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \end{array} } \end{array} } \\
\end{array}
$$


```

```sh
$ (../src/exe-watsup/main.exe test.watsup --latex --latex-macros)
$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{test}}_{{\mathit{sub}}_{{\mathsf{atom}}_{22}}}(n_{1_{{\mathit{xyz}}_y}}) & = & 0 \\
{\mathrm{test}}_{{\mathit{sub}}_{{\mathsf{atom}}_{22}}}(n_{2_{{\mathsf{xyz}}_y}}) & = & 0 \\
{\mathrm{test}}_{{\mathit{sub}}_{{\mathsf{atom}}_{22}}}(n_{3_{{\mathsf{atom}}_y}}) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\curried}}_{n_1}(n_2) & = & n_1 + n_2 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\testfuse} & ::= & {\AB}_{\mathbb{N}}\,\mathbb{N}~\mathbb{N} \\
& & | & {\CD}_{\mathbb{N}}\,\mathbb{N}~\mathbb{N} \\
& & | & {\EF}{\mathbb{N}}~\mathbb{N}~\mathbb{N} \\
& & | & {{\GH}_{\mathbb{N}}}{\mathbb{N}}~\mathbb{N} \\
& & | & {{\IJ}{\mathsf{\_}}~\mathbb{N}}{\AB}{\mathbb{N}}~\mathbb{N} \\
& & | & {\KLAB}{\mathbb{N}}~\mathbb{N}~\mathbb{N} \\
& & | & {\MN}{\AB}~\mathbb{N}~\mathbb{N}~\mathbb{N} \\
& & | & {\OP}{\AB}{\mathbb{N}}~\mathbb{N}~\mathbb{N} \\
& & | & {{\QR}_{\mathbb{N}}}{\AB}~\mathbb{N}~\mathbb{N} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\InfixArrow} & ::= & {\mathbb{N}^\ast} \rightarrow_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\InfixArrow2} & ::= & {\mathbb{N}^\ast} \Rightarrow_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\AtomArrow} & ::= & {\mathbb{N}^?}~{\rightarrow}_{{\mathbb{N}^\ast}}\,{\mathbb{N}^\ast} \\
& {\AtomArrow2} & ::= & {\mathbb{N}^?}~{\Rightarrow}_{{\mathbb{N}^\ast}}\,{\mathbb{N}^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\InfixArrow}(a \rightarrow_{c} {}) & = & 0 \\
{\InfixArrow}(a \rightarrow_{c} b) & = & 0 \\
{\InfixArrow}(a \rightarrow_{{c^\ast}} b) & = & 0 \\
{\InfixArrow}(a \rightarrow_{c} b_1~b_2) & = & 0 \\
{\InfixArrow}(a \rightarrow_{{c^\ast}} b_1~b_2) & = & 0 \\
{\InfixArrow}(a \rightarrow_{c_1~c_2} b_1~b_2) & = & 0 \\
{\InfixArrow}({\rightarrow}_{c_1~c_2} b_1~b_2) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\InfixArrow2}(a \Rightarrow_{c} {}) & = & 0 \\
{\InfixArrow2}(a \Rightarrow_{c} b) & = & 0 \\
{\InfixArrow2}(a \Rightarrow_{{c^\ast}} b) & = & 0 \\
{\InfixArrow2}(a \Rightarrow_{c} b_1~b_2) & = & 0 \\
{\InfixArrow2}(a \Rightarrow_{{c^\ast}} b_1~b_2) & = & 0 \\
{\InfixArrow2}(a \Rightarrow_{c_1~c_2} b_1~b_2) & = & 0 \\
{\InfixArrow2}({\Rightarrow}_{c_1~c_2} b_1~b_2) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\AtomArrow}(a~{\rightarrow}_{c}) & = & 0 \\
{\AtomArrow}(a~{\rightarrow}_{c}\,b) & = & 0 \\
{\AtomArrow}(a~{\rightarrow}_{{c^\ast}}\,b) & = & 0 \\
{\AtomArrow}(a~{\rightarrow}_{c}\,b_1~b_2) & = & 0 \\
{\AtomArrow}(a~{\rightarrow}_{{c^\ast}}\,b_1~b_2) & = & 0 \\
{\AtomArrow}(a~{\rightarrow}_{c_1~c_2}\,b_1~b_2) & = & 0 \\
{\AtomArrow}({\rightarrow}_{c_1~c_2}\,b_1~b_2) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\AtomArrow2}(a~{\Rightarrow}_{c}) & = & 0 \\
{\AtomArrow2}(a~{\Rightarrow}_{c}\,b) & = & 0 \\
{\AtomArrow2}(a~{\Rightarrow}_{{c^\ast}}\,b) & = & 0 \\
{\AtomArrow2}(a~{\Rightarrow}_{c}\,b_1~b_2) & = & 0 \\
{\AtomArrow2}(a~{\Rightarrow}_{{c^\ast}}\,b_1~b_2) & = & 0 \\
{\AtomArrow2}(a~{\Rightarrow}_{c_1~c_2}\,b_1~b_2) & = & 0 \\
{\AtomArrow2}({\Rightarrow}_{c_1~c_2}\,b_1~b_2) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\MacroInfixArrow} & ::= & {\mathbb{N}^\ast} \to_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\MacroAtomArrow} & ::= & {\mathbb{N}^\ast} \to_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\MacroInfixArrow}(a \to_{c} {}) & = & 0 \\
{\MacroInfixArrow}(a \to_{c} b) & = & 0 \\
{\MacroInfixArrow}(a \to_{{c^\ast}} b) & = & 0 \\
{\MacroInfixArrow}(a \to_{c} b_1~b_2) & = & 0 \\
{\MacroInfixArrow}(a \to_{{c^\ast}} b_1~b_2) & = & 0 \\
{\MacroInfixArrow}(a \to_{c_1~c_2} b_1~b_2) & = & 0 \\
{\MacroInfixArrow}({\to}_{c_1~c_2} b_1~b_2) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\MacroAtomArrow}(a \to_{c} {}) & = & 0 \\
{\MacroAtomArrow}(a \to_{c} b) & = & 0 \\
{\MacroAtomArrow}(a \to_{{c^\ast}} b) & = & 0 \\
{\MacroAtomArrow}(a \to_{c} b_1~b_2) & = & 0 \\
{\MacroAtomArrow}(a \to_{{c^\ast}} b_1~b_2) & = & 0 \\
{\MacroAtomArrow}(a \to_{c_1~c_2} b_1~b_2) & = & 0 \\
{\MacroAtomArrow}({\to}_{c_1~c_2} b_1~b_2) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\ShowInfixArrow} & ::= & {\mathbb{N}^\ast} \rightarrow_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\ShowAtomArrow} & ::= & {\mathbb{N}^\ast}~{\rightarrow}_{{\mathbb{N}^\ast}}\,{\mathbb{N}^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\ShowInfixArrow}(a \rightarrow_{c} ) & = & 0 \\
{\ShowInfixArrow}(a \rightarrow_{c} b) & = & 0 \\
{\ShowInfixArrow}(a \rightarrow_{({c^\ast})} b) & = & 0 \\
{\ShowInfixArrow}(a \rightarrow_{c} b_1~b_2) & = & 0 \\
{\ShowInfixArrow}(a \rightarrow_{({c^\ast})} b_1~b_2) & = & 0 \\
{\ShowInfixArrow}(a \rightarrow_{(c_1~c_2)} b_1~b_2) & = & 0 \\
{\ShowInfixArrow}({\rightarrow}_{(c_1~c_2)} b_1~b_2) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\ShowAtomArrow}(a~{\rightarrow}_{c}) & = & 0 \\
{\ShowAtomArrow}(a~{\rightarrow}_{c}\,b) & = & 0 \\
{\ShowAtomArrow}(a~{\rightarrow}_{({c^\ast})}\,b) & = & 0 \\
{\ShowAtomArrow}(a~{\rightarrow}_{c}\,b_1~b_2) & = & 0 \\
{\ShowAtomArrow}(a~{\rightarrow}_{({c^\ast})}\,b_1~b_2) & = & 0 \\
{\ShowAtomArrow}(a~{\rightarrow}_{(c_1~c_2)}\,b_1~b_2) & = & 0 \\
{\ShowAtomArrow}({\rightarrow}_{(c_1~c_2)}\,b_1~b_2) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\ShowMacroInfixArrow} & ::= & {\mathbb{N}^\ast} \to_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\ShowMacroAtomArrow} & ::= & {\mathbb{N}^\ast}~{\to}_{{\mathbb{N}^\ast}}\,{\mathbb{N}^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\ShowMacroInfixArrow}(a \to_{c} ) & = & 0 \\
{\ShowMacroInfixArrow}(a \to_{c} b) & = & 0 \\
{\ShowMacroInfixArrow}(a \to_{({c^\ast})} b) & = & 0 \\
{\ShowMacroInfixArrow}(a \to_{c} b_1~b_2) & = & 0 \\
{\ShowMacroInfixArrow}(a \to_{({c^\ast})} b_1~b_2) & = & 0 \\
{\ShowMacroInfixArrow}(a \to_{(c_1~c_2)} b_1~b_2) & = & 0 \\
{\ShowMacroInfixArrow}({\to}_{(c_1~c_2)} b_1~b_2) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\ShowMacroAtomArrow}(a~{\to}_{c}) & = & 0 \\
{\ShowMacroAtomArrow}(a~{\to}_{c}\,b) & = & 0 \\
{\ShowMacroAtomArrow}(a~{\to}_{({c^\ast})}\,b) & = & 0 \\
{\ShowMacroAtomArrow}(a~{\to}_{c}\,b_1~b_2) & = & 0 \\
{\ShowMacroAtomArrow}(a~{\to}_{({c^\ast})}\,b_1~b_2) & = & 0 \\
{\ShowMacroAtomArrow}(a~{\to}_{(c_1~c_2)}\,b_1~b_2) & = & 0 \\
{\ShowMacroAtomArrow}({\to}_{(c_1~c_2)}\,b_1~b_2) & = & 0 \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\fii} & ::= & \FII \\
& {\faa} & ::= & \FAA \\
& {\XfooYfooZ} & ::= & \FOO \\
& {\mathit{fuu}} & ::= & \FUU \\
& {\foobar} & ::= & \BAR \\
& {\fooboo} & ::= & \BOO \\
& {\XfobYfobZ} & ::= & \BAZ \\
& {\mathit{fib}} & ::= & \BOI \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\macros1} & = & 0 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {\fii} = \FII \\
{\land}~ {\faa} = \FAA \\
{\land}~ {\XfooYfooZ} = \FOO \\
{\land}~ {\mathit{fuu}} = \FUU \\
{\land}~ {\foobar} = \BAR \\
{\land}~ {\fooboo} = \BOO \\
{\land}~ {\XfobYfobZ} = \BAZ \\
{\land}~ {\mathit{fib}} = \BOI \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\ufii}}_{{\mathit{nat}}_1}({\mathit{nat}}_2) & ::= & \UFII \\
& {{\ufaa}}_{{\mathit{nat}}_1}({\mathit{nat}}_2) & ::= & \UFAA \\
& {{\XufooYufooZ}}_{{\mathit{nat}}_1}({\mathit{nat}}_2) & ::= & \UFOO \\
& {{\mathit{ufuu}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2) & ::= & \UFUU \\
& {{\mathit{ufoobar}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2, z) & ::= & \UBAR \\
& {{\mathit{ufooboo}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2, z) & ::= & \UBOO \\
& {{\mathit{XufobYufobZ}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2, {\mathit{XzYzZ}}) & ::= & \UBAZ \\
& {{\mathit{ufib}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2, z) & ::= & \UBOI \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\macros2} & = & 0 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {\mathit{ufii}} = \UFII \\
{\land}~ {\mathit{ufaa}} = \UFAA \\
{\land}~ {\mathit{ufoo}} = \UFOO \\
{\land}~ {\mathit{ufuu}} = \UFUU \\
{\land}~ {\mathit{ubar}} = \UBAR \\
{\land}~ {\mathit{uboo}} = \UBOO \\
{\land}~ {\mathit{ubaz}} = \UBAZ \\
{\land}~ {\mathit{uboi}} = \UBOI \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\fii} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\faa} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\XfooYfooZ} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{fuu}} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathit{foobar}} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathit{fooboo}} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathit{XfobYfobZ}} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathit{fib}} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\ufii}}_{x}(y) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\ufaa}}_{x}(y) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\XufooYufooZ}}_{x}(y) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ufuu}}}_{x}(y) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{ufoobar}}}_{x}(y, z) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{ufooboo}}}_{x}(y, z) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{XufobYufobZ}}}_{x}(y, {\mathit{XzYzZ}}) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{ufib}}}_{x}(y, z) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\foobar} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\fooboo} & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\ufoobar}}_{x}(y) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\ufooboo}}_{x}(y, z) & = & 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\parent} & ::= & \AA \\
& & | & \AAX \\
& & | & \xAAYyAAYz \\
& & | & \mathsf{aaz} \\
& & | & \BBB \\
& & | & \BBBX \\
& & | & \xBBBYyBBBYz \\
& & | & \mathsf{bbbz} \\
& & | & \CC~\mathbb{N}~\CCCC \\
& & | & \CCX~\mathbb{N}~\CCXX \\
& & | & \xCCYyCCYz~\mathbb{N}~\xCCYYyCCYYz \\
& & | & \mathsf{ccz}~\mathbb{N}~\mathsf{cczz} \\
& & | & \DDD~\mathbb{N}~{\child}~{\XfooYfooZ}~{\mathrm{fuu}}~{\fiz} \\
& & | & \DDDX~\mathbb{N}~{\child} \\
& & | & \xDDDYyDDDYz~\mathbb{N}~{\mathit{xchildychildz}} \\
& & | & \mathsf{dddz}~\mathbb{N}~{\child} \\
& & | & {\mathbb{N}}{\mathsf{\_}}{\EA}{\EE}~z \\
& & | & {\mathbb{N}}{\mathsf{\_}}{\EB}{\EEX}~z \\
& & | & {\mathbb{N}}{\mathsf{\_}}{\xECyECz}{\xEEYyEEYz}~{\mathit{xzyzz}} \\
& & | & {\mathbb{N}}{\mathsf{\_}}{\mathsf{ed}}{\mathsf{eez}}~z \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\parent}(\AA) & = & 0 \\
{\parent}(\AAX) & = & 0 \\
{\parent}(\xAAYyAAYz) & = & 0 \\
{\parent}(\mathsf{aaz}) & = & 0 \\
{\parent}(\BBB) & = & 0 \\
{\parent}(\BBBX) & = & 0 \\
{\parent}(\xBBBYyBBBYz) & = & 0 \\
{\parent}(\mathsf{bbbz}) & = & 0 \\
{\parent}(\CC~n~\CCCC) & = & 0 \\
{\parent}(\CCX~n~\CCXX) & = & 0 \\
{\parent}(\xCCYyCCYz~n~\xCCYYyCCYYz) & = & 0 \\
{\parent}(\mathsf{ccz}~n~\mathsf{cczz}) & = & 0 \\
{\parent}(\DDD~n~{\child}~{\XfooYfooZ}~{\mathrm{fuu}}~{\fiz}) & = & 0 \\
{\parent}(\DDDX~n~{\child}) & = & 0 \\
{\parent}(\xDDDYyDDDYz~n~{\mathit{xchildychildz}}) & = & 0 \\
{\parent}(\mathsf{dddz}~n~{\child}) & = & 0 \\
{\parent}({n}{\mathsf{\_}}{\EA}{\EE}~z) & = & 0 \\
{\parent}({n}{\mathsf{\_}}{\EB}{\EEX}~z) & = & 0 \\
{\parent}({n}{\mathsf{\_}}{\xECyECz}{\xEEYyEEYz}~{\mathit{xzyzz}}) & = & 0 \\
{\parent}({n}{\mathsf{\_}}{\mathsf{ed}}{\mathsf{eez}}~z) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\parentimplicit}(t) & ::= & \PP \\
& & | & \PPX \\
& & | & \PPYxPPY \\
& & | & \mathsf{ppz} \\
& & | & \QQQ \\
& & | & \QQQX \\
& & | & \QQQYxQQQY \\
& & | & \mathsf{qqqz} \\
& & | & {t}{\mathsf{\_}}{\RA}{\RR}~z \\
& & | & {t}{\mathsf{\_}}{\RB}{\RRX}~z \\
& & | & {t}{\mathsf{\_}}{\RCxRC}{\RRYxRRY}~{\mathit{zxz}} \\
& & | & {t}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\parentimpl}(\PPimpl) & = & 0 \\
{\parentimpl}(\PPX) & = & 0 \\
{\parentimpl}(\PPYxPPY) & = & 0 \\
{\parentimpl}(\mathsf{ppz}) & = & 0 \\
{\parentimpl}(\QQQimpl) & = & 0 \\
{\parentimpl}(\QQQX) & = & 0 \\
{\parentimpl}(\QQQYxQQQY) & = & 0 \\
{\parentimpl}(\mathsf{qqqz}) & = & 0 \\
{\parentimpl}({n}{\mathsf{\_}}{\RAimpl}{\RRimpl}~{\mathit{zimpl}}) & = & 0 \\
{\parentimpl}({n}{\mathsf{\_}}{\RB}{\RRX}~z) & = & 0 \\
{\parentimpl}({n}{\mathsf{\_}}{\RCxRC}{\RRYxRRY}~{\mathit{zxz}}) & = & 0 \\
{\parentimpl}({n}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\indirect} & ::= & {\parentimplicit}(\mathbb{N}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\indirect}(\PPimpl) & = & 0 \\
{\indirect}(\PPX) & = & 0 \\
{\indirect}(\PPYxPPY) & = & 0 \\
{\indirect}(\mathsf{ppz}) & = & 0 \\
{\indirect}(\QQQimpl) & = & 0 \\
{\indirect}(\QQQX) & = & 0 \\
{\indirect}(\QQQYxQQQY) & = & 0 \\
{\indirect}(\mathsf{qqqz}) & = & 0 \\
{\indirect}({n}{\mathsf{\_}}{\RAimpl}{\RRimpl}~{\mathit{zimpl}}) & = & 0 \\
{\indirect}({n}{\mathsf{\_}}{\RB}{\RRX}~z) & = & 0 \\
{\indirect}({n}{\mathsf{\_}}{\RCxRC}{\RRYxRRY}~{\mathit{zxz}}) & = & 0 \\
{\indirect}({n}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\family}(0) & ::= & \FF \\
& {\family}(1) & ::= & \GGfamily \\
& {\family}(2) & ::= & \xHHy \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\family}(0, \FFfamily) & = & 0 \\
{\family}(1, \GGfamily) & = & 0 \\
{\family}(2, \xHHy) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\child} & ::= & {\parent} ~|~ {\family}(0) ~|~ {\indirect} ~|~ \ZZZ \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\child}(\AA) & = & 0 \\
{\child}(\AAX) & = & 0 \\
{\child}(\xAAYyAAYz) & = & 0 \\
{\child}(\mathsf{aaz}) & = & 0 \\
{\child}(\BBB) & = & 0 \\
{\child}(\BBBX) & = & 0 \\
{\child}(\xBBBYyBBBYz) & = & 0 \\
{\child}(\mathsf{bbbz}) & = & 0 \\
{\child}(\CC~n~\CCCC) & = & 0 \\
{\child}(\CCX~n~\CCXX) & = & 0 \\
{\child}(\xCCYyCCYz~n~\xCCYYyCCYYz) & = & 0 \\
{\child}(\mathsf{ccz}~n~\mathsf{cczz}) & = & 0 \\
{\child}(\DDD~n~{\child}~{\XfooYfooZ}~{\mathrm{fuu}}~{\fiz}) & = & 0 \\
{\child}(\DDDX~n~{\child}) & = & 0 \\
{\child}(\xDDDYyDDDYz~n~{\mathit{xchildychildz}}) & = & 0 \\
{\child}(\mathsf{dddz}~n~{\child}) & = & 0 \\
{\child}({n}{\mathsf{\_}}{\EA}{\EE}~z) & = & 0 \\
{\child}({n}{\mathsf{\_}}{\EB}{\EEX}~z) & = & 0 \\
{\child}({n}{\mathsf{\_}}{\xECyECz}{\xEEYyEEYz}~{\mathit{xzyzz}}) & = & 0 \\
{\child}({n}{\mathsf{\_}}{\mathsf{ed}}{\mathsf{eez}}~z) & = & 0 \\
{\child}(\FF) & = & 0 \\
{\child}(\PP) & = & 0 \\
{\child}(\PPX) & = & 0 \\
{\child}(\PPYxPPY) & = & 0 \\
{\child}(\mathsf{ppz}) & = & 0 \\
{\child}(\QQQ) & = & 0 \\
{\child}(\QQQX) & = & 0 \\
{\child}(\QQQYxQQQY) & = & 0 \\
{\child}(\mathsf{qqqz}) & = & 0 \\
{\child}({n}{\mathsf{\_}}{\RA}{\RR}~z) & = & 0 \\
{\child}({n}{\mathsf{\_}}{\RB}{\RRX}~z) & = & 0 \\
{\child}({n}{\mathsf{\_}}{\RCxRC}{\RRYxRRY}~{\mathit{zxz}}) & = & 0 \\
{\child}({n}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z) & = & 0 \\
{\child}(\ZZZ) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\grandchild} & ::= & {\child} ~|~ \ZZZZ \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\grandchild}(\AA) & = & 0 \\
{\grandchild}(\AAX) & = & 0 \\
{\grandchild}(\xAAYyAAYz) & = & 0 \\
{\grandchild}(\mathsf{aaz}) & = & 0 \\
{\grandchild}(\BBB) & = & 0 \\
{\grandchild}(\BBBX) & = & 0 \\
{\grandchild}(\xBBBYyBBBYz) & = & 0 \\
{\grandchild}(\mathsf{bbbz}) & = & 0 \\
{\grandchild}(\CC~n~\CCCC) & = & 0 \\
{\grandchild}(\CCX~n~\CCXX) & = & 0 \\
{\grandchild}(\xCCYyCCYz~n~\xCCYYyCCYYz) & = & 0 \\
{\grandchild}(\mathsf{ccz}~n~\mathsf{cczz}) & = & 0 \\
{\grandchild}(\DDD~n~{\child}~{\XfooYfooZ}~{\mathrm{fuu}}~{\fiz}) & = & 0 \\
{\grandchild}(\DDDX~n~{\child}) & = & 0 \\
{\grandchild}(\xDDDYyDDDYz~n~{\mathit{xchildychildz}}) & = & 0 \\
{\grandchild}(\mathsf{dddz}~n~{\child}) & = & 0 \\
{\grandchild}({n}{\mathsf{\_}}{\EA}{\EE}~z) & = & 0 \\
{\grandchild}({n}{\mathsf{\_}}{\EB}{\EEX}~z) & = & 0 \\
{\grandchild}({n}{\mathsf{\_}}{\xECyECz}{\xEEYyEEYz}~{\mathit{xzyzz}}) & = & 0 \\
{\grandchild}({n}{\mathsf{\_}}{\mathsf{ed}}{\mathsf{eez}}~z) & = & 0 \\
{\grandchild}(\FF) & = & 0 \\
{\grandchild}(\PP) & = & 0 \\
{\grandchild}(\PPX) & = & 0 \\
{\grandchild}(\PPYxPPY) & = & 0 \\
{\grandchild}(\mathsf{ppz}) & = & 0 \\
{\grandchild}(\QQQ) & = & 0 \\
{\grandchild}(\QQQX) & = & 0 \\
{\grandchild}(\QQQYxQQQY) & = & 0 \\
{\grandchild}(\mathsf{qqqz}) & = & 0 \\
{\grandchild}({n}{\mathsf{\_}}{\RA}{\RR}~z) & = & 0 \\
{\grandchild}({n}{\mathsf{\_}}{\RB}{\RRX}~z) & = & 0 \\
{\grandchild}({n}{\mathsf{\_}}{\RCxRC}{\RRYxRRY}~{\mathit{zxz}}) & = & 0 \\
{\grandchild}({n}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z) & = & 0 \\
{\grandchild}(\ZZZ) & = & 0 \\
{\grandchild}(\ZZZZ) & = & 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\rec} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\FA~{\mathbb{N}^\ast} \\
\FB~{\mathbb{N}^\ast} \\
\xFCyFCz~{\mathbb{N}^\ast} \\
\mathsf{fd}~{\mathbb{N}^\ast} \\
\FEE~{\mathbb{N}^\ast} \\
\FFF~{\mathbb{N}^\ast} \\
\xFGGyFGGz~{\mathbb{N}^\ast} \\
\mathsf{fhh}~{\mathbb{N}^\ast} \} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\proj}(r, 0) & = & r{.}\FA \\
{\proj}(r, 1) & = & r{.}\FB \\
{\proj}(r, 2) & = & r{.}\xFCyFCz \\
{\proj}(r, 3) & = & r{.}\mathsf{fd} \\
{\proj}(r, 4) & = & r{.}\FEE \\
{\proj}(r, 5) & = & r{.}\FFF \\
{\proj}(r, 6) & = & r{.}\xFGGyFGGz \\
{\proj}(r, 7) & = & r{.}\mathsf{fhh} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\upd}(r, 0) & = & r{}[{.}\FA = 0] \\
{\upd}(r, 1) & = & r{}[{.}\FB = 0] \\
{\upd}(r, 2) & = & r{}[{.}\xFCyFCz = 0] \\
{\upd}(r, 3) & = & r{}[{.}\mathsf{fd} = 0] \\
{\upd}(r, 4) & = & r{}[{.}\FEE = 0] \\
{\upd}(r, 5) & = & r{}[{.}\FFF = 0] \\
{\upd}(r, 6) & = & r{}[{.}\xFGGyFGGz = 0] \\
{\upd}(r, 7) & = & r{}[{.}\mathsf{fhh} = 0] \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\ext}(r, 0) & = & r{}[{.}\FA \mathrel{{=}{\oplus}} 0] \\
{\ext}(r, 1) & = & r{}[{.}\FB \mathrel{{=}{\oplus}} 0] \\
{\ext}(r, 2) & = & r{}[{.}\xFCyFCz \mathrel{{=}{\oplus}} 0] \\
{\ext}(r, 3) & = & r{}[{.}\mathsf{fd} \mathrel{{=}{\oplus}} 0] \\
{\ext}(r, 4) & = & r{}[{.}\FEE \mathrel{{=}{\oplus}} 0] \\
{\ext}(r, 5) & = & r{}[{.}\FFF \mathrel{{=}{\oplus}} 0] \\
{\ext}(r, 6) & = & r{}[{.}\xFGGyFGGz \mathrel{{=}{\oplus}} 0] \\
{\ext}(r, 7) & = & r{}[{.}\mathsf{fhh} \mathrel{{=}{\oplus}} 0] \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\recimpl} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\RFIA~{\mathbb{N}^\ast} \\
\FIB~{\mathbb{N}^\ast} \\
\xFICyFICz~{\mathbb{N}^\ast} \\
\mathsf{fid}~{\mathbb{N}^\ast} \\
\RFIEE~{\mathbb{N}^\ast} \\
\FIFF~{\mathbb{N}^\ast} \\
\xFIGGyFIGGz~{\mathbb{N}^\ast} \\
\mathsf{fihh}~{\mathbb{N}^\ast} \} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\rproj}(r, 0) & = & r{.}\RFIA \\
{\rproj}(r, 1) & = & r{.}\FIB \\
{\rproj}(r, 2) & = & r{.}\xFICyFICz \\
{\rproj}(r, 3) & = & r{.}\mathsf{fid} \\
{\rproj}(r, 4) & = & r{.}\RFIEE \\
{\rproj}(r, 5) & = & r{.}\FIFF \\
{\rproj}(r, 6) & = & r{.}\xFIGGyFIGGz \\
{\rproj}(r, 7) & = & r{.}\mathsf{fihh} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\cona} & ::= & \mathbb{N}~\COA~\mathbb{N} \\
& {\conb} & ::= & \mathbb{N}~\COB~\mathbb{N} \\
& {\conc} & ::= & \mathbb{N}~\xCOCyCOCz~\mathbb{N} \\
& {\cond} & ::= & \mathbb{N}~\mathsf{cod}~\mathbb{N} \\
& {\cone} & ::= & \mathbb{N}~\COE~\mathbb{N} \\
& {\conf} & ::= & \mathbb{N}~\COF~\mathbb{N} \\
& {\cong} & ::= & \mathbb{N}~\xCOGyCOGz~\mathbb{N} \\
& {\conh} & ::= & \mathbb{N}~\mathsf{coh}~\mathbb{N} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\C} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
 \} \\
\end{array} \\
\end{array}
$$

$\boxed{{\C} \vdash {\parent} : \mathsf{ok}}$

$\boxed{{\C} \vdash {\parent} \leq {\parent}}$

$\boxed{{\parent} ; {\child} \hookrightarrow {\parent} ; {\child}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\C} \vdash \AA : \mathsf{ok}
} \, {[\textsc{\scriptsize Rok}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\C} \vdash {\parent} \leq \AA
} \, {[\textsc{\scriptsize Rsub}]}
\qquad
\end{array}
$$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize Reval}]} \quad & {\parent} ; {\child} & \hookrightarrow & \AA ; \BBB \\
\end{array}
$$

$\boxed{{\C} \vdashok {\parent} : \OKok}$

$\boxed{{\C} \vdashsub {\parent} \subsub {\parent}}$

$\boxed{{\parent} ; {\child} \sqarroweval {\parent} ; {\child}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\C} \vdashok \AA : \OKok
} \, {[\textsc{\scriptsize Rok\_macro}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\C} \vdashsub {\parent} \subsub \AA
} \, {[\textsc{\scriptsize Rsub\_macro}]}
\qquad
\end{array}
$$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize Reval\_macro}]} \quad & {\parent} ; {\child} & \sqarroweval & \AA ; \BBB \\
\end{array}
$$

$\boxed{{\C} \vdash {\parent} : \mathsf{ok}}$

$\boxed{{\C} \vdash {\parent} \leq {\parent}}$

$\boxed{{\parent} ; {\child} \hookrightarrow {\parent} ; {\child}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\C} \vdash \AA : \mathsf{ok}
} \, {[\textsc{\scriptsize Rok\_nomacro}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\C} \vdash {\parent} \leq \AA
} \, {[\textsc{\scriptsize Rsub\_nomacro}]}
\qquad
\end{array}
$$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize Reval\_nomacro}]} \quad & {\parent} ; {\child} & \hookrightarrow & \AA ; \BBB \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\argh} & ::= & \ARGH \\
& {\borg} & ::= & \BORG \\
& {\curb} & ::= & \CURB \\
& {\dork} & ::= & \DORK \\
& {\eerk} & ::= & \EERK \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\dotstypex} & ::= & {\argh} ~|~ \DX1 ~|~ \dots \\
& {\dotstypey} & ::= & {\argh} ~|~ \DY1 ~|~ \dots \\
& {\dotstypex} & ::= & \dots ~|~ {\borg} ~|~ \DX2 ~|~ \dots \\
& {\dotstypesep} & ::= & {\borg} \\
& {\dotstypex} & ::= & \dots \\
& & | & {\curb} ~|~ \DX3 \\
& & | & \DX4 ~|~ \DX5 \\
& & | & \DX6 ~|~ \dots \\
& {\dotstypey} & ::= & \dots \\
& & | & {\borg} ~|~ \DY2 \\
& & | & \DY3 ~|~ \DY4 \\
& & | & \dots \\
& {\dotstypex} & ::= & \dots ~|~ {\dork} ~|~ \DX7 \\
& {\dotstypey} & ::= & \dots \\
& & | & {\dork} \\
& & | & \DY5 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\casetype} & ::= & \LA~\mathbb{N}~{\argh} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ \mathbb{N} = 0 \\
{\land}~ {\argh} \neq \ARGH \\
\end{array} \\
& & | & \LB~{\borg}~{\curb} \\
& & | & \LC~{\dork}_1~{\dork}_2 & \quad \mbox{if}~ {\dork}_1 \neq {\dork}_2 \\
& & | & \LD~{\argh}~\mathbb{N} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ \mathbb{N} > 0 \\
{\land}~ {\argh} \neq \ARGH \\
\end{array} \\
& & | & \LE~{\mathit{nat}}_1~{\mathit{nat}}_2 & \quad \mbox{if}~ {\mathit{nat}}_1 \leq {\mathit{nat}}_2 \\
& & | & \LFA~{\borg} ~|~ \LFB~{\borg} ~|~ \LFC~{\borg} \\
& & | & \begin{array}[t]{@{}l@{}} \LH~{\borg} \\
  {\argh}~{\eerk} \end{array} \\
& & | & \begin{array}[t]{@{}l@{}} \LI~{\borg} \\
  {\argh}~{\eerk} \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
& & | & \LJ~{\borg} &   \\
&&& \multicolumn{2}{@{}l@{}}{\quad  \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} } \\
& & | & \begin{array}[t]{@{}l@{}} \LK~{\borg} \\
  {\argh}~{\eerk} \end{array} &   \\
&&& \multicolumn{2}{@{}l@{}}{\quad  \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} } \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\gram} & ::= & \mbox{\texttt{`GA'}}~~\mbox{\texttt{`GB'}} & \quad\Rightarrow\quad & 0 & \quad \mbox{if}~ 0 < 1 \\
& & | & \mbox{\texttt{`GB'}}~~\mbox{\texttt{`GC'}}~~\mbox{\texttt{`GD'}} & \quad\Rightarrow\quad & 0 \\
& & | & \mbox{\texttt{`GC'}}~~\mbox{\texttt{`GD'}} & \quad\Rightarrow\quad & 0 & \quad \mbox{if}~ 0 < 1 \\
& & | & \mbox{\texttt{`GD'}}~~\mbox{\texttt{`GE'}} & \quad\Rightarrow\quad & 0 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
& & | & \mbox{\texttt{`GE'}}~~\mbox{\texttt{`GF'}} & \quad\Rightarrow\quad & 0 & \quad \mbox{if}~ 0 < 1 \\
& & | & \mbox{\texttt{`GFA'}}~~\mbox{\texttt{`GF'}} ~\Rightarrow~ 0 ~|~ \mbox{\texttt{`GFB'}}~~\mbox{\texttt{`GF'}} ~\Rightarrow~ 1 ~|~ \mbox{\texttt{`GFC'}} & \quad\Rightarrow\quad & 2 \\
& & | & \mbox{\texttt{`GG'}} & \quad\Rightarrow\quad &  & \\
&&& \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}} 0 & \quad \mbox{if}~ 1 > 0 \end{array} } \\
& & | & \mbox{\texttt{`GH'}} & \quad\Rightarrow\quad &  & \\
&&& \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}} 0 & \quad \mbox{if}~ 1 > 0 \end{array} } \\
& & | & \mbox{\texttt{`GI'}} & \quad\Rightarrow\quad &  & \\
&&& \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}} \begin{array}[t]{@{}l@{}} 0 \\
  1 \\
  2 \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \end{array} } \\
& & | & \mbox{\texttt{`GJ'}}~~\mbox{\texttt{`GJ'}} \\
  &&& \mbox{\texttt{`G'}}~~\mbox{\texttt{`J'}} & \quad\Rightarrow\quad & 0 \\
& & | & \mbox{\texttt{`GK'}}~~\mbox{\texttt{`GJ'}} \\
  &&& \mbox{\texttt{`G'}}~~\mbox{\texttt{`J'}} & \quad\Rightarrow\quad & 0 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
& & | & \mbox{\texttt{`GI'}} & \quad\Rightarrow\quad & 0~1~2 &   \\
&&& \multicolumn{4}{@{}l@{}}{\quad  \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} } \\
& & | & \mbox{\texttt{`GI'}} & \quad\Rightarrow\quad &  & \\
&&& \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}l@{}} \begin{array}[t]{@{}l@{}} 0 \\
  1 \\
  2 \end{array} &  & \\
 \multicolumn{3}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}} \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \end{array} } \end{array} } \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\func}(n, m) & = & 0 \\
{\func}(n, m) & = & 0 & \quad \mbox{if}~ n < m \\
{\func}(n, m) & = & 0 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n > m \\
{\land}~ m < n \\
\end{array} \\
{\func}(n, m) & = & 0~1 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n < m \\
{\land}~ m > n \\
\end{array} \\
{\func}(n, m) & = &  & \\
 \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}} 0~1 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n < m \\
{\land}~ m > n \\
\end{array} \end{array} } \\
{\func}(n, m) & = &  & \\
 \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}} \begin{array}[t]{@{}l@{}} 0 \\
  1 \\
  2 \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n < m \\
{\land}~ m > n \\
\end{array} \end{array} } \\
{\func}(n, m) & = & 0~1~2 &   \\
&& \multicolumn{2}{@{}l@{}}{\quad  \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n < m \\
{\land}~ m > n \\
\end{array} } \\
{\func}(n, m) & = &  & \\
 \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}l@{}} \begin{array}[t]{@{}l@{}} 0 \\
  1 \\
  2 \end{array} &  & \\
 \multicolumn{3}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}} \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n < m \\
{\land}~ m > n \\
\end{array} \end{array} } \end{array} } \\
\end{array}
$$

\vspace{1ex}

$\boxed{{\argh}~{\borg} \rightarrow {\curb}~{\dork}}$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize Rel{-}A}]} \quad & {\argh}~{\borg} & \rightarrow & {\curb}~{\dork} \\
{[\textsc{\scriptsize Rel{-}B}]} \quad & {\argh}~{\borg} & \rightarrow & {\curb}~{\dork} & \quad \mbox{if}~ 0 < 1 \\
{[\textsc{\scriptsize Rel{-}C}]} \quad & {\argh}~{\borg} & \rightarrow & {\curb}~{\dork} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
{[\textsc{\scriptsize Rel{-}D}]} \quad & {\argh}~{\borg} & \rightarrow & {\curb}~{\dork} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
{[\textsc{\scriptsize Rel{-}E}]} \quad & {\argh}~{\borg} & \rightarrow &  & \\
& \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}} {\curb}~{\dork} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \end{array} } \\
{[\textsc{\scriptsize Rel{-}F}]} \quad & {\argh}~{\borg} & \rightarrow & \begin{array}[t]{@{}l@{}} {\curb} \\
  {\dork} \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
{[\textsc{\scriptsize Rel{-}G}]} \quad & {\argh}~{\borg} & \rightarrow &  & \\
& \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}} \begin{array}[t]{@{}l@{}} {\curb} \\
  {\dork} \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \end{array} } \\
{[\textsc{\scriptsize Rel{-}DD}]} \quad & {\argh}~{\borg} & \rightarrow & {\curb}~{\dork} &   \\
&&& \multicolumn{2}{@{}l@{}}{\quad  \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} } \\
{[\textsc{\scriptsize Rel{-}EE}]} \quad & {\argh}~{\borg} & \rightarrow &  & \\
& \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}l@{}} {\curb}~{\dork} &  & \\
 \multicolumn{3}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}} \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \end{array} } \end{array} } \\
{[\textsc{\scriptsize Rel{-}FF}]} \quad & {\argh}~{\borg} & \rightarrow & \begin{array}[t]{@{}l@{}} {\curb} \\
  {\dork} \end{array} &   \\
&&& \multicolumn{2}{@{}l@{}}{\quad  \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} } \\
{[\textsc{\scriptsize Rel{-}GG}]} \quad & {\argh}~{\borg} & \rightarrow &  & \\
& \multicolumn{4}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}l@{}l@{}} \begin{array}[t]{@{}l@{}} {\curb} \\
  {\dork} \end{array} &  & \\
 \multicolumn{3}{@{}l@{}}{\quad  \begin{array}[t]{@{}l@{}} \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \end{array} } \end{array} } \\
\end{array}
$$


```

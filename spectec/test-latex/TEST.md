# Test

```sh
$ (../src/exe-spectec/main.exe test.spectec --latex)
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
& {\mathit{xfoo}} & ::= & \mathsf{xbarnull} \\
& & | & \mathsf{xbarun{\scriptstyle 0}} \\
& & | & \mathsf{xbarun{\scriptstyle 1}n}~\mathbb{N} \\
& & | & \mathsf{xbarun{\scriptstyle 11}}~\mathbb{N} \\
& & | & \mathsf{xbarunrest}~\mathbb{N} \\
& & | & \mathsf{xbarbin{\scriptstyle 0}} \\
& & | & \mathsf{xbarbin{\scriptstyle 1}n}~\mathbb{N}~\mathbb{N} \\
& & | & \mathsf{xbarbin{\scriptstyle 11}}~\mathbb{N}~\mathbb{N} \\
& & | & \mathsf{xbarbin{\scriptstyle 1}n{\scriptstyle 2}n}~\mathbb{N}~\mathbb{N} \\
& & | & \mathsf{xbarbin{\scriptstyle 1}n{\scriptstyle 22}}~\mathbb{N}~\mathbb{N} \\
& & | & \mathsf{xbarbin{\scriptstyle 112}n}~\mathbb{N}~\mathbb{N} \\
& & | & \mathsf{xbarbin{\scriptstyle 1122}}~\mathbb{N}~\mathbb{N} \\
& & | & \mathsf{xbarbin{\scriptstyle 22}}~\mathbb{N} \\
& & | & \mathsf{xbarbin{\scriptstyle 2211}}~\mathbb{N}~\mathbb{N} \\
& & | & \mathsf{xbarbinrest}~\mathbb{N}~\mathbb{N} \\
& & | & \mathsf{xbarbin{\scriptstyle 1}nrest}~\mathbb{N}~\mathbb{N} \\
& & | & \mathsf{xbarbin{\scriptstyle 1}nrest}~\mathbb{N}~\mathbb{N} \\
& & | & \mathsf{xbarbin{\scriptstyle 1}nrest}~\mathbb{N} \\
& & | & \mathsf{xbarbin{\scriptstyle 1}nrest}~\mathbb{N}~\mathbb{N} \\
& & | & \mathsf{xbarbin{\scriptstyle 1}nrest}~\mathbb{N}~\mathbb{N} \\
& & | & \mathsf{xbarbin{\scriptstyle 1}nrest}~\mathbb{N}~\mathbb{N}~\mathbb{N} \\
& & | & \mathsf{xbarbin{\scriptstyle 1}nrest}~\mathsf{xfooname{\scriptstyle 1}n{\scriptstyle 2}nrest}~\mathbb{N}~\mathbb{N} \\
& & | & \mathsf{xbarbin{\scriptstyle 1}nrest}~\mathsf{xfooname{\scriptstyle 1122}rest}~\mathbb{N}~\mathbb{N} \\
& & | & \mathsf{xbarbin{\scriptstyle 1}nrest}~\mathsf{xfooname{\scriptstyle 2211}rest}~\mathbb{N}~\mathbb{N}~\mathbb{N} \\
& {\mathit{xxfoo}} & ::= & {\mathit{xfoo}}~\mathbb{N} \\
& {\mathit{xxxfoo}} & ::= & \mathbb{N}~{\mathit{xfoo}}~\mathbb{N} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{xfoo}}(\mathsf{xbarnull}) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarun{\scriptstyle 0}}) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarun{\scriptstyle 1}n}~2) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarun{\scriptstyle 11}}~2) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarunrest}~2) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarbin{\scriptstyle 0}}) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarbin{\scriptstyle 1}n}~2~3) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarbin{\scriptstyle 11}}~2~3) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarbin{\scriptstyle 1}n{\scriptstyle 2}n}~2~3) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarbin{\scriptstyle 1}n{\scriptstyle 22}}~2~3) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarbin{\scriptstyle 112}n}~2~3) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarbin{\scriptstyle 1122}}~2~3) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarbin{\scriptstyle 22}}~3) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarbin{\scriptstyle 2211}}~3~2) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarbinrest}~2~3) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarbin{\scriptstyle 1}nrest}~2~3) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarbin{\scriptstyle 1}nrest}~2~3) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarbin{\scriptstyle 1}nrest}~3) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarbin{\scriptstyle 1}nrest}~2~3) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarbin{\scriptstyle 1}nrest}~2~3) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarbin{\scriptstyle 1}nrest}~3~2~3) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarbin{\scriptstyle 1}nrest}~\mathsf{xfooname{\scriptstyle 1}n{\scriptstyle 2}nrest}~2~3) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarbin{\scriptstyle 1}nrest}~\mathsf{xfooname{\scriptstyle 1122}rest}~2~3) & = & 0 \\
{\mathrm{xfoo}}(\mathsf{xbarbin{\scriptstyle 1}nrest}~\mathsf{xfooname{\scriptstyle 2211}rest}~3~2~3) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{xxfoo}}(\mathsf{xbarnull}) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{xxxfoo}}(\mathsf{xbarnull}) & = & 0 \\
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
& {\mathit{child}} & ::= & {\mathit{parent}} ~~|~~ {\mathit{family}}(0) ~~|~~ {\mathit{indirect}} ~~|~~ \mathsf{zzz} \\
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
& {\mathit{grandchild}} & ::= & {\mathit{child}} ~~|~~ \mathsf{zzzz} \\
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
& {\mathit{dotstypex}} & ::= & {\mathit{argh}} ~~|~~ \mathsf{dx{\scriptstyle 1}} ~~|~~ \dots \\
& {\mathit{dotstypey}} & ::= & {\mathit{argh}} ~~|~~ \mathsf{dy{\scriptstyle 1}} ~~|~~ \dots \\
& {\mathit{dotstypex}} & ::= & \dots ~~|~~ {\mathit{borg}} ~~|~~ \mathsf{dx{\scriptstyle 2}} ~~|~~ \dots \\
& {\mathit{dotstypesep}} & ::= & {\mathit{borg}} \\
& {\mathit{dotstypex}} & ::= & \dots \\
& & | & {\mathit{curb}} ~~|~~ \mathsf{dx{\scriptstyle 3}} \\
& & | & \mathsf{dx{\scriptstyle 4}} ~~|~~ \mathsf{dx{\scriptstyle 5}} \\
& & | & \mathsf{dx{\scriptstyle 6}} ~~|~~ \dots \\
& {\mathit{dotstypey}} & ::= & \dots \\
& & | & {\mathit{borg}} ~~|~~ \mathsf{dy{\scriptstyle 2}} \\
& & | & \mathsf{dy{\scriptstyle 3}} ~~|~~ \mathsf{dy{\scriptstyle 4}} \\
& & | & \dots \\
& {\mathit{dotstypex}} & ::= & \dots ~~|~~ {\mathit{dork}} ~~|~~ \mathsf{dx{\scriptstyle 7}} \\
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
& & | & \mathsf{lfa}~{\mathit{borg}} ~~|~~ \mathsf{lfb}~{\mathit{borg}} ~~|~~ \mathsf{lfc}~{\mathit{borg}} \\
& & | & \begin{array}[t]{@{}l@{}} \mathsf{lh}~{\mathit{borg}} \\
  {\mathit{argh}}~{\mathit{eerk}} \end{array} \\
& & | & \begin{array}[t]{@{}l@{}} \mathsf{li}~{\mathit{borg}} \\
  {\mathit{argh}}~{\mathit{eerk}} \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
& & | & \mathsf{lj}~{\mathit{borg}} &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array}
} \\
& & | & \begin{array}[t]{@{}l@{}} \mathsf{lk}~{\mathit{borg}} \\
  {\mathit{argh}}~{\mathit{eerk}} \end{array} &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{gram}} & ::= & \mbox{‘}\mathtt{GA}\mbox{’}~~\mbox{‘}\mathtt{GB}\mbox{’} & \quad\Rightarrow\quad{} & 0 & \quad \mbox{if}~ 0 < 1 \\
& & | & \mbox{‘}\mathtt{GB}\mbox{’}~~\mbox{‘}\mathtt{GC}\mbox{’}~~\mbox{‘}\mathtt{GD}\mbox{’} & \quad\Rightarrow\quad{} & 0 \\
& & | & \mbox{‘}\mathtt{GC}\mbox{’}~~\mbox{‘}\mathtt{GD}\mbox{’} & \quad\Rightarrow\quad{} & 0 & \quad \mbox{if}~ 0 < 1 \\
& & | & \mbox{‘}\mathtt{GD}\mbox{’}~~\mbox{‘}\mathtt{GE}\mbox{’} & \quad\Rightarrow\quad{} & 0 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
& & | & \mbox{‘}\mathtt{GE}\mbox{’}~~\mbox{‘}\mathtt{GF}\mbox{’} & \quad\Rightarrow\quad{} & 0 & \quad \mbox{if}~ 0 < 1 \\
& & | & \mbox{‘}\mathtt{GFA}\mbox{’}~~\mbox{‘}\mathtt{GF}\mbox{’} ~\Rightarrow~ 0 ~~|~~ \mbox{‘}\mathtt{GFB}\mbox{’}~~\mbox{‘}\mathtt{GF}\mbox{’} ~\Rightarrow~ 1 ~~|~~ \mbox{‘}\mathtt{GFC}\mbox{’} & \quad\Rightarrow\quad{} & 2 \\
& & | & \mbox{‘}\mathtt{GG}\mbox{’} & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
0 & \quad \mbox{if}~ 1 > 0 \\
\end{array}
} \\
& & | & \mbox{‘}\mathtt{GH}\mbox{’} & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
0 & \quad \mbox{if}~ 1 > 0 \\
\end{array}
} \\
& & | & \mbox{‘}\mathtt{GI}\mbox{’} & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} 0 \\
  1 \\
  2 \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
\end{array}
} \\
& & | & \begin{array}[t]{@{}l@{}} \mbox{‘}\mathtt{GJ}\mbox{’}~~\mbox{‘}\mathtt{GJ}\mbox{’} \\
  \mbox{‘}\mathtt{G}\mbox{’}~~\mbox{‘}\mathtt{J}\mbox{’} \end{array} & \quad\Rightarrow\quad{} & 0 \\
& & | & \begin{array}[t]{@{}l@{}} \mbox{‘}\mathtt{GK}\mbox{’}~~\mbox{‘}\mathtt{GJ}\mbox{’} \\
  \mbox{‘}\mathtt{G}\mbox{’}~~\mbox{‘}\mathtt{J}\mbox{’} \end{array} & \quad\Rightarrow\quad{} & 0 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
& & | & \mbox{‘}\mathtt{GI}\mbox{’} & \quad\Rightarrow\quad{} & 0~1~2 &  \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array}
} \\
& & | & \mbox{‘}\mathtt{GI}\mbox{’} & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} 0 \\
  1 \\
  2 \end{array} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
\end{array}
} \\
\end{array}
} \\
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
{\mathrm{func}}(n, m) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
0~1 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n < m \\
{\land}~ m > n \\
\end{array} \\
\end{array}
} \\
{\mathrm{func}}(n, m) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} 0 \\
  1 \\
  2 \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n < m \\
{\land}~ m > n \\
\end{array} \\
\end{array}
} \\
{\mathrm{func}}(n, m) & = & 0~1~2 &  \\
&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n < m \\
{\land}~ m > n \\
\end{array}
} \\
{\mathrm{func}}(n, m) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} 0 \\
  1 \\
  2 \end{array} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n < m \\
{\land}~ m > n \\
\end{array} \\
\end{array}
} \\
\end{array}
} \\
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
{[\textsc{\scriptsize Rel{-}E}]} \quad & {\mathit{argh}}~{\mathit{borg}} & \rightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
{\mathit{curb}}~{\mathit{dork}} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
\end{array}
} \\
{[\textsc{\scriptsize Rel{-}F}]} \quad & {\mathit{argh}}~{\mathit{borg}} & \rightarrow & \begin{array}[t]{@{}l@{}} {\mathit{curb}} \\
  {\mathit{dork}} \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
{[\textsc{\scriptsize Rel{-}G}]} \quad & {\mathit{argh}}~{\mathit{borg}} & \rightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} {\mathit{curb}} \\
  {\mathit{dork}} \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
\end{array}
} \\
{[\textsc{\scriptsize Rel{-}DD}]} \quad & {\mathit{argh}}~{\mathit{borg}} & \rightarrow & {\mathit{curb}}~{\mathit{dork}} &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array}
} \\
{[\textsc{\scriptsize Rel{-}EE}]} \quad & {\mathit{argh}}~{\mathit{borg}} & \rightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
{\mathit{curb}}~{\mathit{dork}} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
\end{array}
} \\
\end{array}
} \\
{[\textsc{\scriptsize Rel{-}FF}]} \quad & {\mathit{argh}}~{\mathit{borg}} & \rightarrow & \begin{array}[t]{@{}l@{}} {\mathit{curb}} \\
  {\mathit{dork}} \end{array} &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array}
} \\
{[\textsc{\scriptsize Rel{-}GG}]} \quad & {\mathit{argh}}~{\mathit{borg}} & \rightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} {\mathit{curb}} \\
  {\mathit{dork}} \end{array} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
\end{array}
} \\
\end{array}
} \\
\end{array}
$$


```

```sh
$ (../src/exe-spectec/main.exe test.spectec --latex --latex-macros)
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
& {\xfoo} & ::= & \XBARNULL \\
& & | & \XBARUN0 \\
& & | & \XBARUN1N~\mathbb{N} \\
& & | & \XBARUN11~\mathbb{N} \\
& & | & \XBARUNREST~\mathbb{N} \\
& & | & \XBARBIN0 \\
& & | & \XBARBIN1N~\mathbb{N}~\mathbb{N} \\
& & | & \XBARBIN11~\mathbb{N}~\mathbb{N} \\
& & | & \XBARBIN1N2N~\mathbb{N}~\mathbb{N} \\
& & | & \XBARBIN1N22~\mathbb{N}~\mathbb{N} \\
& & | & \XBARBIN112N~\mathbb{N}~\mathbb{N} \\
& & | & \XBARBIN1122~\mathbb{N}~\mathbb{N} \\
& & | & \XBARBIN22~\mathbb{N} \\
& & | & \XBARBIN2211~\mathbb{N}~\mathbb{N} \\
& & | & \XBARBINREST~\mathbb{N}~\mathbb{N} \\
& & | & \XBARBIN1NREST~\mathbb{N}~\mathbb{N} \\
& & | & \XBARBIN1NREST~\mathbb{N}~\mathbb{N} \\
& & | & \XBARBIN1NREST~\mathbb{N} \\
& & | & \XBARBIN1NREST~\mathbb{N}~\mathbb{N} \\
& & | & \XBARBIN1NREST~\mathbb{N}~\mathbb{N} \\
& & | & \XBARBIN1NREST~\mathbb{N}~\mathbb{N}~\mathbb{N} \\
& & | & \XBARBIN1NREST~\XFOONAME1N2NREST~\mathbb{N}~\mathbb{N} \\
& & | & \XBARBIN1NREST~\XFOONAME1122REST~\mathbb{N}~\mathbb{N} \\
& & | & \XBARBIN1NREST~\XFOONAME2211REST~\mathbb{N}~\mathbb{N}~\mathbb{N} \\
& {\xxfoo} & ::= & {\xfoo}~\mathbb{N} \\
& {\xxxfoo} & ::= & \mathbb{N}~{\xfoo}~\mathbb{N} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\xfoo}(\XBARNULL) & = & 0 \\
{\xfoo}(\XBARUN0) & = & 0 \\
{\xfoo}(\XBARUN1N~2) & = & 0 \\
{\xfoo}(\XBARUN11~2) & = & 0 \\
{\xfoo}(\XBARUNREST~2) & = & 0 \\
{\xfoo}(\XBARBIN0) & = & 0 \\
{\xfoo}(\XBARBIN1N~2~3) & = & 0 \\
{\xfoo}(\XBARBIN11~2~3) & = & 0 \\
{\xfoo}(\XBARBIN1N2N~2~3) & = & 0 \\
{\xfoo}(\XBARBIN1N22~2~3) & = & 0 \\
{\xfoo}(\XBARBIN112N~2~3) & = & 0 \\
{\xfoo}(\XBARBIN1122~2~3) & = & 0 \\
{\xfoo}(\XBARBIN22~3) & = & 0 \\
{\xfoo}(\XBARBIN2211~3~2) & = & 0 \\
{\xfoo}(\XBARBINREST~2~3) & = & 0 \\
{\xfoo}(\XBARBIN1NREST~2~3) & = & 0 \\
{\xfoo}(\XBARBIN1NREST~2~3) & = & 0 \\
{\xfoo}(\XBARBIN1NREST~3) & = & 0 \\
{\xfoo}(\XBARBIN1NREST~2~3) & = & 0 \\
{\xfoo}(\XBARBIN1NREST~2~3) & = & 0 \\
{\xfoo}(\XBARBIN1NREST~3~2~3) & = & 0 \\
{\xfoo}(\XBARBIN1NREST~\XFOONAME1N2NREST~2~3) & = & 0 \\
{\xfoo}(\XBARBIN1NREST~\XFOONAME1122REST~2~3) & = & 0 \\
{\xfoo}(\XBARBIN1NREST~\XFOONAME2211REST~3~2~3) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\xxfoo}(\XBARNULL) & = & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\xxxfoo}(\XBARNULL) & = & 0 \\
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
{\land}~ {\ufaa} = \UFAA \\
{\land}~ {\XufooYufooZ} = \UFOO \\
{\land}~ {\mathit{ufuu}} = \UFUU \\
{\land}~ {\mathit{ubar}} = \UBAR \\
{\land}~ {\uboo} = \UBOO \\
{\land}~ {\XubazYubazZ} = \UBAZ \\
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
& {\child} & ::= & {\parent} ~~|~~ {\family}(0) ~~|~~ {\indirect} ~~|~~ \ZZZ \\
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
& {\grandchild} & ::= & {\child} ~~|~~ \ZZZZ \\
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
& {\dotstypex} & ::= & {\argh} ~~|~~ \DX1 ~~|~~ \dots \\
& {\dotstypey} & ::= & {\argh} ~~|~~ \DY1 ~~|~~ \dots \\
& {\dotstypex} & ::= & \dots ~~|~~ {\borg} ~~|~~ \DX2 ~~|~~ \dots \\
& {\dotstypesep} & ::= & {\borg} \\
& {\dotstypex} & ::= & \dots \\
& & | & {\curb} ~~|~~ \DX3 \\
& & | & \DX4 ~~|~~ \DX5 \\
& & | & \DX6 ~~|~~ \dots \\
& {\dotstypey} & ::= & \dots \\
& & | & {\borg} ~~|~~ \DY2 \\
& & | & \DY3 ~~|~~ \DY4 \\
& & | & \dots \\
& {\dotstypex} & ::= & \dots ~~|~~ {\dork} ~~|~~ \DX7 \\
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
& & | & \LFA~{\borg} ~~|~~ \LFB~{\borg} ~~|~~ \LFC~{\borg} \\
& & | & \begin{array}[t]{@{}l@{}} \LH~{\borg} \\
  {\argh}~{\eerk} \end{array} \\
& & | & \begin{array}[t]{@{}l@{}} \LI~{\borg} \\
  {\argh}~{\eerk} \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
& & | & \LJ~{\borg} &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array}
} \\
& & | & \begin{array}[t]{@{}l@{}} \LK~{\borg} \\
  {\argh}~{\eerk} \end{array} &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\gram} & ::= & \mbox{‘}\mathtt{GA}\mbox{’}~~\mbox{‘}\mathtt{GB}\mbox{’} & \quad\Rightarrow\quad{} & 0 & \quad \mbox{if}~ 0 < 1 \\
& & | & \mbox{‘}\mathtt{GB}\mbox{’}~~\mbox{‘}\mathtt{GC}\mbox{’}~~\mbox{‘}\mathtt{GD}\mbox{’} & \quad\Rightarrow\quad{} & 0 \\
& & | & \mbox{‘}\mathtt{GC}\mbox{’}~~\mbox{‘}\mathtt{GD}\mbox{’} & \quad\Rightarrow\quad{} & 0 & \quad \mbox{if}~ 0 < 1 \\
& & | & \mbox{‘}\mathtt{GD}\mbox{’}~~\mbox{‘}\mathtt{GE}\mbox{’} & \quad\Rightarrow\quad{} & 0 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
& & | & \mbox{‘}\mathtt{GE}\mbox{’}~~\mbox{‘}\mathtt{GF}\mbox{’} & \quad\Rightarrow\quad{} & 0 & \quad \mbox{if}~ 0 < 1 \\
& & | & \mbox{‘}\mathtt{GFA}\mbox{’}~~\mbox{‘}\mathtt{GF}\mbox{’} ~\Rightarrow~ 0 ~~|~~ \mbox{‘}\mathtt{GFB}\mbox{’}~~\mbox{‘}\mathtt{GF}\mbox{’} ~\Rightarrow~ 1 ~~|~~ \mbox{‘}\mathtt{GFC}\mbox{’} & \quad\Rightarrow\quad{} & 2 \\
& & | & \mbox{‘}\mathtt{GG}\mbox{’} & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
0 & \quad \mbox{if}~ 1 > 0 \\
\end{array}
} \\
& & | & \mbox{‘}\mathtt{GH}\mbox{’} & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
0 & \quad \mbox{if}~ 1 > 0 \\
\end{array}
} \\
& & | & \mbox{‘}\mathtt{GI}\mbox{’} & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} 0 \\
  1 \\
  2 \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
\end{array}
} \\
& & | & \begin{array}[t]{@{}l@{}} \mbox{‘}\mathtt{GJ}\mbox{’}~~\mbox{‘}\mathtt{GJ}\mbox{’} \\
  \mbox{‘}\mathtt{G}\mbox{’}~~\mbox{‘}\mathtt{J}\mbox{’} \end{array} & \quad\Rightarrow\quad{} & 0 \\
& & | & \begin{array}[t]{@{}l@{}} \mbox{‘}\mathtt{GK}\mbox{’}~~\mbox{‘}\mathtt{GJ}\mbox{’} \\
  \mbox{‘}\mathtt{G}\mbox{’}~~\mbox{‘}\mathtt{J}\mbox{’} \end{array} & \quad\Rightarrow\quad{} & 0 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
& & | & \mbox{‘}\mathtt{GI}\mbox{’} & \quad\Rightarrow\quad{} & 0~1~2 &  \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array}
} \\
& & | & \mbox{‘}\mathtt{GI}\mbox{’} & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} 0 \\
  1 \\
  2 \end{array} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
\end{array}
} \\
\end{array}
} \\
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
{\func}(n, m) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
0~1 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n < m \\
{\land}~ m > n \\
\end{array} \\
\end{array}
} \\
{\func}(n, m) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} 0 \\
  1 \\
  2 \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n < m \\
{\land}~ m > n \\
\end{array} \\
\end{array}
} \\
{\func}(n, m) & = & 0~1~2 &  \\
&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n < m \\
{\land}~ m > n \\
\end{array}
} \\
{\func}(n, m) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} 0 \\
  1 \\
  2 \end{array} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n < m \\
{\land}~ m > n \\
\end{array} \\
\end{array}
} \\
\end{array}
} \\
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
{[\textsc{\scriptsize Rel{-}E}]} \quad & {\argh}~{\borg} & \rightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
{\curb}~{\dork} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
\end{array}
} \\
{[\textsc{\scriptsize Rel{-}F}]} \quad & {\argh}~{\borg} & \rightarrow & \begin{array}[t]{@{}l@{}} {\curb} \\
  {\dork} \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
{[\textsc{\scriptsize Rel{-}G}]} \quad & {\argh}~{\borg} & \rightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} {\curb} \\
  {\dork} \end{array} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
\end{array}
} \\
{[\textsc{\scriptsize Rel{-}DD}]} \quad & {\argh}~{\borg} & \rightarrow & {\curb}~{\dork} &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array}
} \\
{[\textsc{\scriptsize Rel{-}EE}]} \quad & {\argh}~{\borg} & \rightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
{\curb}~{\dork} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
\end{array}
} \\
\end{array}
} \\
{[\textsc{\scriptsize Rel{-}FF}]} \quad & {\argh}~{\borg} & \rightarrow & \begin{array}[t]{@{}l@{}} {\curb} \\
  {\dork} \end{array} &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array}
} \\
{[\textsc{\scriptsize Rel{-}GG}]} \quad & {\argh}~{\borg} & \rightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} {\curb} \\
  {\dork} \end{array} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ 0 < 1 \\
{\land}~ 1 > 0 \\
\end{array} \\
\end{array}
} \\
\end{array}
} \\
\end{array}
$$


```


# Preview

```sh
$ (../src/exe-spectec/main.exe ../../../../specification/wasm-3.0/*.spectec --latex)
$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& N & ::= & 0 ~~|~~ 1 ~~|~~ 2 ~~|~~ \dots \\
& M & ::= & 0 ~~|~~ 1 ~~|~~ 2 ~~|~~ \dots \\
& K & ::= & 0 ~~|~~ 1 ~~|~~ 2 ~~|~~ \dots \\
& n & ::= & 0 ~~|~~ 1 ~~|~~ 2 ~~|~~ \dots \\
& m & ::= & 0 ~~|~~ 1 ~~|~~ 2 ~~|~~ \dots \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{min}}(i, j) & = & i & \quad \mbox{if}~ i \leq j \\
{\mathrm{min}}(i, j) & = & j & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\Sigma}\, \epsilon & = & 0 \\
{\Sigma}\, n~{{n'}^\ast} & = & n + {\Sigma}\, {{n'}^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\Pi}\, \epsilon & = & 1 \\
{\Pi}\, n~{{n'}^\ast} & = & n \cdot {\Pi}\, {{n'}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
\epsilon & = & \epsilon \\
w & = & w \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\bigoplus}\, \epsilon & = & \epsilon \\
{\bigoplus}\, ({w^\ast})~{({{w'}^\ast})^\ast} & = & {w^\ast} \oplus {\bigoplus}\, {({{w'}^\ast})^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\bigoplus}\, \epsilon & = & \epsilon \\
{\bigoplus}\, ({w^{n}})~{({{w'}^{n}})^\ast} & = & {w^{n}}~{\bigoplus}\, {({{w'}^{n}})^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\bigoplus}\, \epsilon & = & \epsilon \\
{\bigoplus}\, ({w^?})~{({{w'}^?})^\ast} & = & {w^?} \oplus {\bigoplus}\, {({{w'}^?})^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
\epsilon~{\mathrm{disjoint}} & = & \mathsf{true} \\
w~{{w'}^\ast}~{\mathrm{disjoint}} & = & {\neg(w \in {{w'}^\ast})} \land {{w'}^\ast}~{\mathrm{disjoint}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
\epsilon \setminus {w^\ast} & = & \epsilon \\
w_1~{{w'}^\ast} \setminus {w^\ast} & = & {{\mathrm{setminus{\kern-0.1em\scriptstyle 1}}}}_{X}(w_1, {w^\ast}) \oplus {{w'}^\ast} \setminus {w^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{setminus{\kern-0.1em\scriptstyle 1}}}}_{X}(w, \epsilon) & = & w \\
{{\mathrm{setminus{\kern-0.1em\scriptstyle 1}}}}_{X}(w, w_1~{{w'}^\ast}) & = & \epsilon & \quad \mbox{if}~ w = w_1 \\
{{\mathrm{setminus{\kern-0.1em\scriptstyle 1}}}}_{X}(w, w_1~{{w'}^\ast}) & = & {{\mathrm{setminus{\kern-0.1em\scriptstyle 1}}}}_{X}(w, {{w'}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\Large\times}~\epsilon & = & (\epsilon) \\
{\Large\times}~({w_1^\ast})~{({w^\ast})^\ast} & = & {{\mathrm{setproduct{\kern-0.1em\scriptstyle 1}}}}_{X}({w_1^\ast}, {\Large\times}~{({w^\ast})^\ast}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{setproduct{\kern-0.1em\scriptstyle 1}}}}_{X}(\epsilon, {({w^\ast})^\ast}) & = & \epsilon \\
{{\mathrm{setproduct{\kern-0.1em\scriptstyle 1}}}}_{X}(w_1~{{w'}^\ast}, {({w^\ast})^\ast}) & = & {{\mathrm{setproduct{\kern-0.1em\scriptstyle 2}}}}_{X}(w_1, {({w^\ast})^\ast}) \oplus {{\mathrm{setproduct{\kern-0.1em\scriptstyle 1}}}}_{X}({{w'}^\ast}, {({w^\ast})^\ast}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{setproduct{\kern-0.1em\scriptstyle 2}}}}_{X}(w_1, \epsilon) & = & \epsilon \\
{{\mathrm{setproduct{\kern-0.1em\scriptstyle 2}}}}_{X}(w_1, ({{w'}^\ast})~{({w^\ast})^\ast}) & = & (w_1~{{w'}^\ast}) \oplus {{\mathrm{setproduct{\kern-0.1em\scriptstyle 2}}}}_{X}(w_1, {({w^\ast})^\ast}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(bit)} & {\mathit{bit}} & ::= & 0 ~~|~~ 1 \\
\mbox{(byte)} & {\mathit{byte}} & ::= & \mathtt{0x00} ~~|~~ \ldots ~~|~~ \mathtt{0xFF} \\
\mbox{(unsigned integer)} & {u}{N} & ::= & 0 ~~|~~ \ldots ~~|~~ {2^{N}} - 1 \\
\mbox{(signed integer)} & {s}{N} & ::= & {-{2^{N - 1}}} ~~|~~ \ldots ~~|~~ {-1} ~~|~~ 0 ~~|~~ {+1} ~~|~~ \ldots ~~|~~ {+{2^{N - 1}}} - 1 \\
\mbox{(integer)} & {i}{N} & ::= & {u}{N} \\
& {\mathit{u{\kern-0.1em\scriptstyle 8}}} & ::= & {u}{\mathsf{{\scriptstyle 8}}} \\
& {\mathit{u{\kern-0.1em\scriptstyle 16}}} & ::= & {u}{\mathsf{{\scriptstyle 16}}} \\
& {\mathit{u{\kern-0.1em\scriptstyle 31}}} & ::= & {u}{\mathsf{{\scriptstyle 31}}} \\
& {\mathit{u{\kern-0.1em\scriptstyle 32}}} & ::= & {u}{\mathsf{{\scriptstyle 32}}} \\
& {\mathit{u{\kern-0.1em\scriptstyle 64}}} & ::= & {u}{\mathsf{{\scriptstyle 64}}} \\
& {\mathit{u{\kern-0.1em\scriptstyle 128}}} & ::= & {u}{\mathsf{{\scriptstyle 128}}} \\
& {\mathit{s{\kern-0.1em\scriptstyle 33}}} & ::= & {s}{\mathsf{{\scriptstyle 33}}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{signif}}(32) & = & 23 \\
{\mathrm{signif}}(64) & = & 52 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{expon}}(32) & = & 8 \\
{\mathrm{expon}}(64) & = & 11 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
M & = & {\mathrm{signif}}(N) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
E & = & {\mathrm{expon}}(N) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(floating-point number)} & {f}{N} & ::= & {+{{\mathit{fNmag}}}} ~~|~~ {-{{\mathit{fNmag}}}} \\
& e & ::= & \dots ~~|~~ {-2} ~~|~~ {-1} ~~|~~ 0 ~~|~~ 1 ~~|~~ 2 ~~|~~ \dots \\
\mbox{(floating-point magnitude)} & {{\mathit{fNmag}}} & ::= & (1 + m \cdot {2^{{-M}}}) \cdot {2^{e}} & \quad \mbox{if}~ m < {2^{M}} \land 2 - {2^{E - 1}} \leq e \leq {2^{E - 1}} - 1 \\
& & | & (0 + m \cdot {2^{{-M}}}) \cdot {2^{e}} & \quad \mbox{if}~ m < {2^{M}} \land 2 - {2^{E - 1}} = e \\
& & | & \infty \\
& & | & {\mathsf{nan}}{(m)} & \quad \mbox{if}~ 1 \leq m < {2^{M}} \\
& {\mathit{f{\kern-0.1em\scriptstyle 32}}} & ::= & {f}{\mathsf{{\scriptstyle 32}}} \\
& {\mathit{f{\kern-0.1em\scriptstyle 64}}} & ::= & {f}{\mathsf{{\scriptstyle 64}}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{+0} & = & {+((0 + 0 \cdot {2^{{-M}}}) \cdot {2^{e}})} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{+N} & = & {+((1 + n \cdot {2^{{-M}}}) \cdot {2^{0}})} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{+1} & = & {+((1 + 1 \cdot {2^{{-M}}}) \cdot {2^{0}})} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{canon}}}_{N} & = & {2^{{\mathrm{signif}}(N) - 1}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(vector)} & {v}{N} & ::= & {u}{N} \\
& {\mathit{v{\kern-0.1em\scriptstyle 128}}} & ::= & {v}{\mathsf{{\scriptstyle 128}}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{list}}(X) & ::= & {X^\ast} & \quad \mbox{if}~ {|{X^\ast}|} < {2^{32}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(character)} & {\mathit{char}} & ::= & \mathrm{U{+}00} ~~|~~ \ldots ~~|~~ \mathrm{U{+}D7FF} ~~|~~ \mathrm{U{+}E000} ~~|~~ \ldots ~~|~~ \mathrm{U{+}10FFFF} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(name)} & {\mathit{name}} & ::= & {{\mathit{char}}^\ast} & \quad \mbox{if}~ {|{\mathrm{utf{\kern-0.1em\scriptstyle 8}}}({{\mathit{char}}^\ast})|} < {2^{32}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(index)} & {\mathit{idx}} & ::= & {\mathit{u{\kern-0.1em\scriptstyle 32}}} \\
\mbox{(lane index)} & {\mathit{laneidx}} & ::= & {\mathit{u{\kern-0.1em\scriptstyle 8}}} \\
\mbox{(type index)} & {\mathit{typeidx}} & ::= & {\mathit{idx}} \\
\mbox{(function index)} & {\mathit{funcidx}} & ::= & {\mathit{idx}} \\
\mbox{(global index)} & {\mathit{globalidx}} & ::= & {\mathit{idx}} \\
\mbox{(table index)} & {\mathit{tableidx}} & ::= & {\mathit{idx}} \\
\mbox{(memory index)} & {\mathit{memidx}} & ::= & {\mathit{idx}} \\
\mbox{(tag index)} & {\mathit{tagidx}} & ::= & {\mathit{idx}} \\
\mbox{(elem index)} & {\mathit{elemidx}} & ::= & {\mathit{idx}} \\
\mbox{(data index)} & {\mathit{dataidx}} & ::= & {\mathit{idx}} \\
\mbox{(label index)} & {\mathit{labelidx}} & ::= & {\mathit{idx}} \\
\mbox{(local index)} & {\mathit{localidx}} & ::= & {\mathit{idx}} \\
\mbox{(field index)} & {\mathit{fieldidx}} & ::= & {\mathit{idx}} \\
\mbox{(external index)} & {\mathit{externidx}} & ::= & \mathsf{func}~{\mathit{funcidx}} ~~|~~ \mathsf{global}~{\mathit{globalidx}} ~~|~~ \mathsf{table}~{\mathit{tableidx}} ~~|~~ \mathsf{mem}~{\mathit{memidx}} ~~|~~ \mathsf{tag}~{\mathit{tagidx}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{funcs}}(\epsilon) & = & \epsilon \\
{\mathrm{funcs}}((\mathsf{func}~x)~{{\mathit{xx}}^\ast}) & = & x~{\mathrm{funcs}}({{\mathit{xx}}^\ast}) \\
{\mathrm{funcs}}({\mathit{externidx}}~{{\mathit{xx}}^\ast}) & = & {\mathrm{funcs}}({{\mathit{xx}}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{globals}}(\epsilon) & = & \epsilon \\
{\mathrm{globals}}((\mathsf{global}~x)~{{\mathit{xx}}^\ast}) & = & x~{\mathrm{globals}}({{\mathit{xx}}^\ast}) \\
{\mathrm{globals}}({\mathit{externidx}}~{{\mathit{xx}}^\ast}) & = & {\mathrm{globals}}({{\mathit{xx}}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{tables}}(\epsilon) & = & \epsilon \\
{\mathrm{tables}}((\mathsf{table}~x)~{{\mathit{xx}}^\ast}) & = & x~{\mathrm{tables}}({{\mathit{xx}}^\ast}) \\
{\mathrm{tables}}({\mathit{externidx}}~{{\mathit{xx}}^\ast}) & = & {\mathrm{tables}}({{\mathit{xx}}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{mems}}(\epsilon) & = & \epsilon \\
{\mathrm{mems}}((\mathsf{mem}~x)~{{\mathit{xx}}^\ast}) & = & x~{\mathrm{mems}}({{\mathit{xx}}^\ast}) \\
{\mathrm{mems}}({\mathit{externidx}}~{{\mathit{xx}}^\ast}) & = & {\mathrm{mems}}({{\mathit{xx}}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{tags}}(\epsilon) & = & \epsilon \\
{\mathrm{tags}}((\mathsf{tag}~x)~{{\mathit{xx}}^\ast}) & = & x~{\mathrm{tags}}({{\mathit{xx}}^\ast}) \\
{\mathrm{tags}}({\mathit{externidx}}~{{\mathit{xx}}^\ast}) & = & {\mathrm{tags}}({{\mathit{xx}}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{free}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{types}~{{\mathit{typeidx}}^\ast} \\
\mathsf{funcs}~{{\mathit{funcidx}}^\ast} \\
\mathsf{globals}~{{\mathit{globalidx}}^\ast} \\
\mathsf{tables}~{{\mathit{tableidx}}^\ast} \\
\mathsf{mems}~{{\mathit{memidx}}^\ast} \\
\mathsf{elems}~{{\mathit{elemidx}}^\ast} \\
\mathsf{datas}~{{\mathit{dataidx}}^\ast} \\
\mathsf{locals}~{{\mathit{localidx}}^\ast} \\
\mathsf{labels}~{{\mathit{labelidx}}^\ast} \} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{opt}}(\epsilon) & = & \{  \} \\
{\mathrm{free}}_{\mathit{opt}}({\mathit{free}}) & = & {\mathit{free}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{list}}(\epsilon) & = & \{  \} \\
{\mathrm{free}}_{\mathit{list}}({\mathit{free}}~{{\mathit{free}'}^\ast}) & = & {\mathit{free}} \oplus {\mathrm{free}}_{\mathit{list}}({{\mathit{free}'}^\ast}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) & = & \{ \mathsf{types}~{\mathit{typeidx}} \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{funcidx}}({\mathit{funcidx}}) & = & \{ \mathsf{funcs}~{\mathit{funcidx}} \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{globalidx}}({\mathit{globalidx}}) & = & \{ \mathsf{globals}~{\mathit{globalidx}} \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) & = & \{ \mathsf{tables}~{\mathit{tableidx}} \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) & = & \{ \mathsf{mems}~{\mathit{memidx}} \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{elemidx}}({\mathit{elemidx}}) & = & \{ \mathsf{elems}~{\mathit{elemidx}} \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{dataidx}}({\mathit{dataidx}}) & = & \{ \mathsf{datas}~{\mathit{dataidx}} \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{localidx}}({\mathit{localidx}}) & = & \{ \mathsf{locals}~{\mathit{localidx}} \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{labelidx}}({\mathit{labelidx}}) & = & \{ \mathsf{labels}~{\mathit{labelidx}} \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{externidx}}(\mathsf{func}~{\mathit{funcidx}}) & = & {\mathrm{free}}_{\mathit{funcidx}}({\mathit{funcidx}}) \\
{\mathrm{free}}_{\mathit{externidx}}(\mathsf{global}~{\mathit{globalidx}}) & = & {\mathrm{free}}_{\mathit{globalidx}}({\mathit{globalidx}}) \\
{\mathrm{free}}_{\mathit{externidx}}(\mathsf{table}~{\mathit{tableidx}}) & = & {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \\
{\mathrm{free}}_{\mathit{externidx}}(\mathsf{mem}~{\mathit{memidx}}) & = & {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& \mathsf{null} & ::= & \mathsf{null} \\
\mbox{(address type)} & {\mathit{addrtype}} & ::= & \mathsf{i{\scriptstyle 32}} ~~|~~ \mathsf{i{\scriptstyle 64}} \\
\mbox{(number type)} & {\mathit{numtype}} & ::= & \mathsf{i{\scriptstyle 32}} ~~|~~ \mathsf{i{\scriptstyle 64}} ~~|~~ \mathsf{f{\scriptstyle 32}} ~~|~~ \mathsf{f{\scriptstyle 64}} \\
\mbox{(vector type)} & {\mathit{vectype}} & ::= & \mathsf{v{\scriptstyle 128}} \\
\mbox{(constant type)} & {\mathit{consttype}} & ::= & {\mathit{numtype}} ~~|~~ {\mathit{vectype}} \\
& {\mathit{absheaptype}} & ::= & \mathsf{any} ~~|~~ \mathsf{eq} ~~|~~ \mathsf{i{\scriptstyle 31}} ~~|~~ \mathsf{struct} ~~|~~ \mathsf{array} ~~|~~ \mathsf{none} \\
& & | & \mathsf{func} ~~|~~ \mathsf{nofunc} \\
& & | & \mathsf{exn} ~~|~~ \mathsf{noexn} \\
& & | & \mathsf{extern} ~~|~~ \mathsf{noextern} \\
& & | & \mathsf{bot} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(defined type)} & {\mathit{deftype}} & ::= & {\mathit{rectype}} {.} n \\
& {\mathit{typeuse}} & ::= & {\mathit{deftype}} ~~|~~ {\mathit{typeidx}} ~~|~~ \mathsf{rec} {.} n \\
\mbox{(type variable)} & {\mathit{typevar}} & ::= & {\mathit{typeidx}} ~~|~~ \mathsf{rec} {.} n \\
\mbox{(heap type)} & {\mathit{heaptype}} & ::= & {\mathit{absheaptype}} ~~|~~ {\mathit{typeuse}} \\
\mbox{(reference type)} & {\mathit{reftype}} & ::= & \mathsf{ref}~{\mathsf{null}^?}~{\mathit{heaptype}} \\
& {\mathit{valtype}} & ::= & {\mathit{numtype}} ~~|~~ {\mathit{vectype}} ~~|~~ {\mathit{reftype}} ~~|~~ \mathsf{bot} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathsf{i}}{N} & ::= & \mathsf{i{\scriptstyle 32}} ~~|~~ \mathsf{i{\scriptstyle 64}} \\
& {\mathsf{f}}{N} & ::= & \mathsf{f{\scriptstyle 32}} ~~|~~ \mathsf{f{\scriptstyle 64}} \\
& {\mathsf{v}}{N} & ::= & \mathsf{v{\scriptstyle 128}} \\
& t & ::= & {\mathsf{i}}{N} ~~|~~ {\mathsf{f}}{N} ~~|~~ {\mathsf{v}}{N} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
\mathsf{anyref} & = & (\mathsf{ref}~\mathsf{null}~\mathsf{any}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
\mathsf{eqref} & = & (\mathsf{ref}~\mathsf{null}~\mathsf{eq}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
\mathsf{i{\scriptstyle 31}ref} & = & (\mathsf{ref}~\mathsf{null}~\mathsf{i{\scriptstyle 31}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
\mathsf{structref} & = & (\mathsf{ref}~\mathsf{null}~\mathsf{struct}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
\mathsf{arrayref} & = & (\mathsf{ref}~\mathsf{null}~\mathsf{array}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
\mathsf{funcref} & = & (\mathsf{ref}~\mathsf{null}~\mathsf{func}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
\mathsf{exnref} & = & (\mathsf{ref}~\mathsf{null}~\mathsf{exn}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
\mathsf{externref} & = & (\mathsf{ref}~\mathsf{null}~\mathsf{extern}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
\mathsf{nullref} & = & (\mathsf{ref}~\mathsf{null}~\mathsf{none}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
\mathsf{nullfuncref} & = & (\mathsf{ref}~\mathsf{null}~\mathsf{nofunc}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
\mathsf{nullexnref} & = & (\mathsf{ref}~\mathsf{null}~\mathsf{noexn}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
\mathsf{nullexternref} & = & (\mathsf{ref}~\mathsf{null}~\mathsf{noextern}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(packed type)} & {\mathit{packtype}} & ::= & \mathsf{i{\scriptstyle 8}} ~~|~~ \mathsf{i{\scriptstyle 16}} \\
\mbox{(lane type)} & {\mathit{lanetype}} & ::= & {\mathit{numtype}} ~~|~~ {\mathit{packtype}} \\
\mbox{(storage type)} & {\mathit{storagetype}} & ::= & {\mathit{valtype}} ~~|~~ {\mathit{packtype}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathsf{i}}{N} & ::= & {\mathit{packtype}} \\
& {\mathsf{i}}{N} & ::= & {\mathsf{i}}{N} ~~|~~ {\mathsf{i}}{N} \\
& {\mathsf{i}}{N} & ::= & {\mathsf{i}}{N} ~~|~~ {\mathsf{f}}{N} ~~|~~ {\mathsf{i}}{N} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(result type)} & {\mathit{resulttype}} & ::= & {\mathit{list}}({\mathit{valtype}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& \mathsf{mut} & ::= & \mathsf{mut} \\
& \mathsf{final} & ::= & \mathsf{final} \\
\mbox{(field type)} & {\mathit{fieldtype}} & ::= & {\mathsf{mut}^?}~{\mathit{storagetype}} \\
\mbox{(composite type)} & {\mathit{comptype}} & ::= & \mathsf{struct}~{\mathit{list}}({\mathit{fieldtype}}) \\
& & | & \mathsf{array}~{\mathit{fieldtype}} \\
& & | & \mathsf{func}~{\mathit{resulttype}} \rightarrow {\mathit{resulttype}} \\
\mbox{(sub type)} & {\mathit{subtype}} & ::= & \mathsf{sub}~{\mathsf{final}^?}~{{\mathit{typeuse}}^\ast}~{\mathit{comptype}} \\
\mbox{(recursive type)} & {\mathit{rectype}} & ::= & \mathsf{rec}~{\mathit{list}}({\mathit{subtype}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(limits range)} & {\mathit{limits}} & ::= & {}[ {\mathit{u{\kern-0.1em\scriptstyle 64}}} .. {{\mathit{u{\kern-0.1em\scriptstyle 64}}}^?} ] \\
\mbox{(tag type)} & {\mathit{tagtype}} & ::= & {\mathit{typeuse}} \\
\mbox{(global type)} & {\mathit{globaltype}} & ::= & {\mathsf{mut}^?}~{\mathit{valtype}} \\
\mbox{(memory type)} & {\mathit{memtype}} & ::= & {\mathit{addrtype}}~{\mathit{limits}}~\mathsf{page} \\
\mbox{(table type)} & {\mathit{tabletype}} & ::= & {\mathit{addrtype}}~{\mathit{limits}}~{\mathit{reftype}} \\
\mbox{(data type)} & {\mathit{datatype}} & ::= & \mathsf{ok} \\
\mbox{(element type)} & {\mathit{elemtype}} & ::= & {\mathit{reftype}} \\
\mbox{(external type)} & {\mathit{externtype}} & ::= & \mathsf{tag}~{\mathit{tagtype}} ~~|~~ \mathsf{global}~{\mathit{globaltype}} ~~|~~ \mathsf{mem}~{\mathit{memtype}} ~~|~~ \mathsf{table}~{\mathit{tabletype}} ~~|~~ \mathsf{func}~{\mathit{typeuse}} \\
\mbox{(module type)} & {\mathit{moduletype}} & ::= & {{\mathit{externtype}}^\ast} \rightarrow {{\mathit{externtype}}^\ast} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathsf{i}}{32} & = & \mathsf{i{\scriptstyle 32}} \\
{\mathsf{i}}{64} & = & \mathsf{i{\scriptstyle 64}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathsf{f}}{32} & = & \mathsf{f{\scriptstyle 32}} \\
{\mathsf{f}}{64} & = & \mathsf{f{\scriptstyle 64}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathsf{i}}{8} & = & \mathsf{i{\scriptstyle 8}} \\
{\mathsf{i}}{16} & = & \mathsf{i{\scriptstyle 16}} \\
{\mathsf{i}}{32} & = & \mathsf{i{\scriptstyle 32}} \\
{\mathsf{i}}{64} & = & \mathsf{i{\scriptstyle 64}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{|\mathsf{i{\scriptstyle 32}}|} & = & 32 \\
{|\mathsf{i{\scriptstyle 64}}|} & = & 64 \\
{|\mathsf{f{\scriptstyle 32}}|} & = & 32 \\
{|\mathsf{f{\scriptstyle 64}}|} & = & 64 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{|\mathsf{v{\scriptstyle 128}}|} & = & 128 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{|\mathsf{i{\scriptstyle 8}}|} & = & 8 \\
{|\mathsf{i{\scriptstyle 16}}|} & = & 16 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{|{\mathit{numtype}}|} & = & {|{\mathit{numtype}}|} \\
{|{\mathit{packtype}}|} & = & {|{\mathit{packtype}}|} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{|{\mathit{numtype}}|} & = & {|{\mathit{numtype}}|} \\
{|{\mathit{vectype}}|} & = & {|{\mathit{vectype}}|} \\
{|{\mathit{packtype}}|} & = & {|{\mathit{packtype}}|} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{|{\mathsf{i}}{N}|} & = & {|{\mathsf{i}}{N}|} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{|{\mathsf{f}}{N}|} & = & {|{\mathsf{f}}{N}|} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{|{\mathsf{i}}{N}|} & = & {|{\mathsf{i}}{N}|} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{inv}}_{\mathit{isize}}(32) & = & \mathsf{i{\scriptstyle 32}} \\
{\mathrm{inv}}_{\mathit{isize}}(64) & = & \mathsf{i{\scriptstyle 64}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{inv}}_{\mathit{fsize}}(32) & = & \mathsf{f{\scriptstyle 32}} \\
{\mathrm{inv}}_{\mathit{fsize}}(64) & = & \mathsf{f{\scriptstyle 64}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{inv}}_{\mathit{jsize}}(8) & = & \mathsf{i{\scriptstyle 8}} \\
{\mathrm{inv}}_{\mathit{jsize}}(16) & = & \mathsf{i{\scriptstyle 16}} \\
{\mathrm{inv}}_{\mathit{jsize}}(n) & = & {\mathrm{inv}}_{\mathit{isize}}(n) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
N & = & {|{\mathit{nt}}|} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
N_1 & = & {|{\mathit{nt}}|} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
N_2 & = & {|{\mathit{nt}}|} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
N & = & {|{\mathit{vt}}|} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
N & = & {|{\mathit{pt}}|} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
N & = & {|{\mathit{lt}}|} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
N_1 & = & {|{\mathit{lt}}|} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
N_2 & = & {|{\mathit{lt}}|} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
N & = & {|{\mathsf{i}}{N}|} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{inv}}_{\mathit{jsizenn}}(n) & = & {\mathrm{inv}}_{\mathit{jsize}}(n) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{unpack}}({\mathit{numtype}}) & = & {\mathit{numtype}} \\
{\mathrm{unpack}}({\mathit{packtype}}) & = & \mathsf{i{\scriptstyle 32}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{unpack}}({\mathit{valtype}}) & = & {\mathit{valtype}} \\
{\mathrm{unpack}}({\mathit{packtype}}) & = & \mathsf{i{\scriptstyle 32}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{unpack}}({\mathit{numtype}}) & = & {\mathit{numtype}} \\
{\mathrm{unpack}}({\mathit{packtype}}) & = & \mathsf{i{\scriptstyle 32}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{unpack}}({\mathit{vectype}}) & = & {\mathit{vectype}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{unpack}}({\mathit{consttype}}) & = & {\mathit{consttype}} \\
{\mathrm{unpack}}({\mathit{packtype}}) & = & \mathsf{i{\scriptstyle 32}} \\
{\mathrm{unpack}}({\mathit{lanetype}}) & = & {\mathrm{unpack}}({\mathit{lanetype}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{min}}({\mathit{at}}_1, {\mathit{at}}_2) & = & {\mathit{at}}_1 & \quad \mbox{if}~ {|{\mathit{at}}_1|} \leq {|{\mathit{at}}_2|} \\
{\mathrm{min}}({\mathit{at}}_1, {\mathit{at}}_2) & = & {\mathit{at}}_2 & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(\mathsf{ref}~{{\mathsf{null}}_1^?}~{\mathit{ht}}_1) \setminus (\mathsf{ref}~\mathsf{null}~{\mathit{ht}}_2) & = & (\mathsf{ref}~{\mathit{ht}}_1) \\
(\mathsf{ref}~{{\mathsf{null}}_1^?}~{\mathit{ht}}_1) \setminus (\mathsf{ref}~{\mathit{ht}}_2) & = & (\mathsf{ref}~{{\mathsf{null}}_1^?}~{\mathit{ht}}_1) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathit{dt}} & = & {\mathit{dt}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{tags}}(\epsilon) & = & \epsilon \\
{\mathrm{tags}}((\mathsf{tag}~{\mathit{jt}})~{{\mathit{xt}}^\ast}) & = & {\mathit{jt}}~{\mathrm{tags}}({{\mathit{xt}}^\ast}) \\
{\mathrm{tags}}({\mathit{externtype}}~{{\mathit{xt}}^\ast}) & = & {\mathrm{tags}}({{\mathit{xt}}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{globals}}(\epsilon) & = & \epsilon \\
{\mathrm{globals}}((\mathsf{global}~{\mathit{gt}})~{{\mathit{xt}}^\ast}) & = & {\mathit{gt}}~{\mathrm{globals}}({{\mathit{xt}}^\ast}) \\
{\mathrm{globals}}({\mathit{externtype}}~{{\mathit{xt}}^\ast}) & = & {\mathrm{globals}}({{\mathit{xt}}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{mems}}(\epsilon) & = & \epsilon \\
{\mathrm{mems}}((\mathsf{mem}~{\mathit{mt}})~{{\mathit{xt}}^\ast}) & = & {\mathit{mt}}~{\mathrm{mems}}({{\mathit{xt}}^\ast}) \\
{\mathrm{mems}}({\mathit{externtype}}~{{\mathit{xt}}^\ast}) & = & {\mathrm{mems}}({{\mathit{xt}}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{tables}}(\epsilon) & = & \epsilon \\
{\mathrm{tables}}((\mathsf{table}~{\mathit{tt}})~{{\mathit{xt}}^\ast}) & = & {\mathit{tt}}~{\mathrm{tables}}({{\mathit{xt}}^\ast}) \\
{\mathrm{tables}}({\mathit{externtype}}~{{\mathit{xt}}^\ast}) & = & {\mathrm{tables}}({{\mathit{xt}}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{funcs}}(\epsilon) & = & \epsilon \\
{\mathrm{funcs}}((\mathsf{func}~{\mathit{dt}})~{{\mathit{xt}}^\ast}) & = & {\mathit{dt}}~{\mathrm{funcs}}({{\mathit{xt}}^\ast}) \\
{\mathrm{funcs}}({\mathit{externtype}}~{{\mathit{xt}}^\ast}) & = & {\mathrm{funcs}}({{\mathit{xt}}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{tv}}}{{}[ \epsilon := \epsilon ]} & = & {\mathit{tv}} \\
{{\mathit{tv}}}{{}[ {\mathit{tv}}_1~{{\mathit{tv}'}^\ast} := {\mathit{tu}}_1~{{\mathit{tu}'}^\ast} ]} & = & {\mathit{tu}}_1 & \quad \mbox{if}~ {\mathit{tv}} = {\mathit{tv}}_1 \\
{{\mathit{tv}}}{{}[ {\mathit{tv}}_1~{{\mathit{tv}'}^\ast} := {\mathit{tu}}_1~{{\mathit{tu}'}^\ast} ]} & = & {{\mathit{tv}}}{{}[ {{\mathit{tv}'}^\ast} := {{\mathit{tu}'}^\ast} ]} & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{tv}'}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {{\mathit{tv}'}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{{\mathit{dt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {{\mathit{dt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{at}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {\mathit{at}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{nt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {\mathit{nt}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{vt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {\mathit{vt}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{tv}'}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {{\mathit{tv}'}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{{\mathit{dt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {{\mathit{dt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{{\mathit{ht}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {\mathit{ht}} & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{(\mathsf{ref}~{\mathsf{null}^?}~{\mathit{ht}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & \mathsf{ref}~{\mathsf{null}^?}~{{\mathit{ht}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{nt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {{\mathit{nt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{{\mathit{vt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {{\mathit{vt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{{\mathit{rt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {{\mathit{rt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{\mathsf{bot}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & \mathsf{bot} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{pt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {\mathit{pt}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{t}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {t}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{{\mathit{pt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {{\mathit{pt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{({\mathsf{mut}^?}~{\mathit{zt}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {\mathsf{mut}^?}~{{\mathit{zt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{(\mathsf{struct}~{{\mathit{ft}}^\ast})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & \mathsf{struct}~{{{\mathit{ft}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]}^\ast} \\
{(\mathsf{array}~{\mathit{ft}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & \mathsf{array}~{{\mathit{ft}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{(\mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & \mathsf{func}~{{t_1}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]}^\ast} \rightarrow {{t_2}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]}^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{(\mathsf{sub}~{\mathsf{final}^?}~{{\mathit{tu}'}^\ast}~{\mathit{ct}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\mathsf{sub}~{\mathsf{final}^?}~{{{\mathit{tu}'}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]}^\ast}~{{\mathit{ct}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
\end{array}
} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{minus}}_{\mathit{recs}}(\epsilon, \epsilon) & = & (\epsilon, \epsilon) \\
{\mathrm{minus}}_{\mathit{recs}}((\mathsf{rec} {.} n)~{{\mathit{tv}}^\ast}, {\mathit{tu}}_1~{{\mathit{tu}}^\ast}) & = & {\mathrm{minus}}_{\mathit{recs}}({{\mathit{tv}}^\ast}, {{\mathit{tu}}^\ast}) \\
{\mathrm{minus}}_{\mathit{recs}}(x~{{\mathit{tv}}^\ast}, {\mathit{tu}}_1~{{\mathit{tu}}^\ast}) & = & (x~{{\mathit{tv}'}^\ast}, {\mathit{tu}}_1~{{\mathit{tu}'}^\ast}) & \quad \mbox{if}~ ({{\mathit{tv}'}^\ast}, {{\mathit{tu}'}^\ast}) = {\mathrm{minus}}_{\mathit{recs}}({{\mathit{tv}}^\ast}, {{\mathit{tu}}^\ast}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{(\mathsf{rec}~{{\mathit{st}}^\ast})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & \mathsf{rec}~{{{\mathit{st}}}{{}[ {{\mathit{tv}'}^\ast} := {{\mathit{tu}'}^\ast} ]}^\ast} & \quad \mbox{if}~ ({{\mathit{tv}'}^\ast}, {{\mathit{tu}'}^\ast}) = {\mathrm{minus}}_{\mathit{recs}}({{\mathit{tv}}^\ast}, {{\mathit{tu}}^\ast}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{({\mathit{qt}} {.} i)}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {{\mathit{qt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} {.} i \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{tu}'}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {{\mathit{tu}'}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{({\mathsf{mut}^?}~t)}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {\mathsf{mut}^?}~{t}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{({\mathit{at}}~{\mathit{lim}}~\mathsf{page})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {\mathit{at}}~{\mathit{lim}}~\mathsf{page} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{({\mathit{at}}~{\mathit{lim}}~{\mathit{rt}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {\mathit{at}}~{\mathit{lim}}~{{\mathit{rt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{(\mathsf{tag}~{\mathit{jt}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & \mathsf{tag}~{{\mathit{jt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{(\mathsf{global}~{\mathit{gt}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & \mathsf{global}~{{\mathit{gt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{(\mathsf{table}~{\mathit{tt}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & \mathsf{table}~{{\mathit{tt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{(\mathsf{mem}~{\mathit{mt}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & \mathsf{mem}~{{\mathit{mt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{(\mathsf{func}~{\mathit{dt}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & \mathsf{func}~{{\mathit{dt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{{\mathit{xt}}_1^\ast} \rightarrow {{\mathit{xt}}_2^\ast}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} & = & {{{\mathit{xt}}_1}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]}^\ast} \rightarrow {{{\mathit{xt}}_2}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{t}{{}[ {:=}\, {{\mathit{tu}}^{n}} ]} & = & {t}{{}[ {i^{i<n}} := {{\mathit{tu}}^{n}} ]} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{rt}}}{{}[ {:=}\, {{\mathit{tu}}^{n}} ]} & = & {{\mathit{rt}}}{{}[ {i^{i<n}} := {{\mathit{tu}}^{n}} ]} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{dt}}}{{}[ {:=}\, {{\mathit{tu}}^{n}} ]} & = & {{\mathit{dt}}}{{}[ {i^{i<n}} := {{\mathit{tu}}^{n}} ]} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{jt}}}{{}[ {:=}\, {{\mathit{tu}}^{n}} ]} & = & {{\mathit{jt}}}{{}[ {i^{i<n}} := {{\mathit{tu}}^{n}} ]} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{gt}}}{{}[ {:=}\, {{\mathit{tu}}^{n}} ]} & = & {{\mathit{gt}}}{{}[ {i^{i<n}} := {{\mathit{tu}}^{n}} ]} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{mt}}}{{}[ {:=}\, {{\mathit{tu}}^{n}} ]} & = & {{\mathit{mt}}}{{}[ {i^{i<n}} := {{\mathit{tu}}^{n}} ]} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{tt}}}{{}[ {:=}\, {{\mathit{tu}}^{n}} ]} & = & {{\mathit{tt}}}{{}[ {i^{i<n}} := {{\mathit{tu}}^{n}} ]} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{xt}}}{{}[ {:=}\, {{\mathit{tu}}^{n}} ]} & = & {{\mathit{xt}}}{{}[ {i^{i<n}} := {{\mathit{tu}}^{n}} ]} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathit{mmt}}}{{}[ {:=}\, {{\mathit{tu}}^{n}} ]} & = & {{\mathit{mmt}}}{{}[ {i^{i<n}} := {{\mathit{tu}}^{n}} ]} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\epsilon}{{}[ {:=}\, {{\mathit{tu}}^\ast} ]} & = & \epsilon \\
{{\mathit{dt}}_1~{{\mathit{dt}}^\ast}}{{}[ {:=}\, {{\mathit{tu}}^\ast} ]} & = & {{\mathit{dt}}_1}{{}[ {:=}\, {{\mathit{tu}}^\ast} ]}~{{{\mathit{dt}}^\ast}}{{}[ {:=}\, {{\mathit{tu}}^\ast} ]} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{roll}}}_{x}({\mathit{rectype}}) & = & \mathsf{rec}~{({{\mathit{subtype}}}{{}[ {(x + i)^{i<n}} := {(\mathsf{rec} {.} i)^{i<n}} ]})^{n}} & \quad \mbox{if}~ {\mathit{rectype}} = \mathsf{rec}~{{\mathit{subtype}}^{n}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{unroll}}({\mathit{rectype}}) & = & \mathsf{rec}~{({{\mathit{subtype}}}{{}[ {(\mathsf{rec} {.} i)^{i<n}} := {({\mathit{rectype}} {.} i)^{i<n}} ]})^{n}} & \quad \mbox{if}~ {\mathit{rectype}} = \mathsf{rec}~{{\mathit{subtype}}^{n}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{{{\mathrm{roll}}}_{x}^\ast}}{({\mathit{rectype}})} & = & {((\mathsf{rec}~{{\mathit{subtype}}^{n}}) {.} i)^{i<n}} & \quad \mbox{if}~ {{\mathrm{roll}}}_{x}({\mathit{rectype}}) = \mathsf{rec}~{{\mathit{subtype}}^{n}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{unroll}}({\mathit{rectype}} {.} i) & = & {{\mathit{subtype}}^\ast}{}[i] & \quad \mbox{if}~ {\mathrm{unroll}}({\mathit{rectype}}) = \mathsf{rec}~{{\mathit{subtype}}^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{expand}}({\mathit{deftype}}) & = & {\mathit{comptype}} & \quad \mbox{if}~ {\mathrm{unroll}}({\mathit{deftype}}) = \mathsf{sub}~{\mathsf{final}^?}~{{\mathit{typeuse}}^\ast}~{\mathit{comptype}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{addrtype}}({\mathit{addrtype}}) & = & \{  \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) & = & \{  \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{packtype}}({\mathit{packtype}}) & = & \{  \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{lanetype}}({\mathit{numtype}}) & = & {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \\
{\mathrm{free}}_{\mathit{lanetype}}({\mathit{packtype}}) & = & {\mathrm{free}}_{\mathit{packtype}}({\mathit{packtype}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) & = & \{  \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{consttype}}({\mathit{numtype}}) & = & {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \\
{\mathrm{free}}_{\mathit{consttype}}({\mathit{vectype}}) & = & {\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{absheaptype}}({\mathit{absheaptype}}) & = & \{  \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{deftype}}({\mathit{rectype}} {.} n) & = & {\mathrm{free}}_{\mathit{rectype}}({\mathit{rectype}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{typevar}}({\mathit{typeidx}}) & = & {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{typevar}}(\mathsf{rec} {.} n) & = & \{  \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{typeuse}}({\mathit{typevar}}) & = & {\mathrm{free}}_{\mathit{typevar}}({\mathit{typevar}}) \\
{\mathrm{free}}_{\mathit{typeuse}}({\mathit{deftype}}) & = & {\mathrm{free}}_{\mathit{deftype}}({\mathit{deftype}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{heaptype}}({\mathit{absheaptype}}) & = & {\mathrm{free}}_{\mathit{absheaptype}}({\mathit{absheaptype}}) \\
{\mathrm{free}}_{\mathit{heaptype}}({\mathit{typeuse}}) & = & {\mathrm{free}}_{\mathit{typeuse}}({\mathit{typeuse}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{reftype}}(\mathsf{ref}~{\mathsf{null}^?}~{\mathit{heaptype}}) & = & {\mathrm{free}}_{\mathit{heaptype}}({\mathit{heaptype}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{valtype}}({\mathit{numtype}}) & = & {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \\
{\mathrm{free}}_{\mathit{valtype}}({\mathit{vectype}}) & = & {\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \\
{\mathrm{free}}_{\mathit{valtype}}({\mathit{reftype}}) & = & {\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}) \\
{\mathrm{free}}_{\mathit{valtype}}(\mathsf{bot}) & = & \{  \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{resulttype}}({{\mathit{valtype}}^\ast}) & = & {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{valtype}}({\mathit{valtype}})^\ast}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{storagetype}}({\mathit{valtype}}) & = & {\mathrm{free}}_{\mathit{valtype}}({\mathit{valtype}}) \\
{\mathrm{free}}_{\mathit{storagetype}}({\mathit{packtype}}) & = & {\mathrm{free}}_{\mathit{packtype}}({\mathit{packtype}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{fieldtype}}({\mathsf{mut}^?}~{\mathit{storagetype}}) & = & {\mathrm{free}}_{\mathit{storagetype}}({\mathit{storagetype}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{comptype}}(\mathsf{struct}~{{\mathit{fieldtype}}^\ast}) & = & {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{fieldtype}}({\mathit{fieldtype}})^\ast}) \\
{\mathrm{free}}_{\mathit{comptype}}(\mathsf{array}~{\mathit{fieldtype}}) & = & {\mathrm{free}}_{\mathit{fieldtype}}({\mathit{fieldtype}}) \\
{\mathrm{free}}_{\mathit{comptype}}(\mathsf{func}~{\mathit{resulttype}}_1 \rightarrow {\mathit{resulttype}}_2) & = & {\mathrm{free}}_{\mathit{resulttype}}({\mathit{resulttype}}_1) \oplus {\mathrm{free}}_{\mathit{resulttype}}({\mathit{resulttype}}_2) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{subtype}}(\mathsf{sub}~{\mathsf{final}^?}~{{\mathit{typeuse}}^\ast}~{\mathit{comptype}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{typeuse}}({\mathit{typeuse}})^\ast}) \oplus {\mathrm{free}}_{\mathit{comptype}}({\mathit{comptype}}) \\
\end{array}
} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{rectype}}(\mathsf{rec}~{{\mathit{subtype}}^\ast}) & = & {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{subtype}}({\mathit{subtype}})^\ast}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{tagtype}}({\mathit{deftype}}) & = & {\mathrm{free}}_{\mathit{deftype}}({\mathit{deftype}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{globaltype}}({\mathsf{mut}^?}~{\mathit{valtype}}) & = & {\mathrm{free}}_{\mathit{valtype}}({\mathit{valtype}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{memtype}}({\mathit{addrtype}}~{\mathit{limits}}~\mathsf{page}) & = & {\mathrm{free}}_{\mathit{addrtype}}({\mathit{addrtype}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{tabletype}}({\mathit{addrtype}}~{\mathit{limits}}~{\mathit{reftype}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{addrtype}}({\mathit{addrtype}}) \oplus {\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}) \\
\end{array}
} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{datatype}}(\mathsf{ok}) & = & \{  \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{elemtype}}({\mathit{reftype}}) & = & {\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{externtype}}(\mathsf{tag}~{\mathit{tagtype}}) & = & {\mathrm{free}}_{\mathit{tagtype}}({\mathit{tagtype}}) \\
{\mathrm{free}}_{\mathit{externtype}}(\mathsf{global}~{\mathit{globaltype}}) & = & {\mathrm{free}}_{\mathit{globaltype}}({\mathit{globaltype}}) \\
{\mathrm{free}}_{\mathit{externtype}}(\mathsf{mem}~{\mathit{memtype}}) & = & {\mathrm{free}}_{\mathit{memtype}}({\mathit{memtype}}) \\
{\mathrm{free}}_{\mathit{externtype}}(\mathsf{table}~{\mathit{tabletype}}) & = & {\mathrm{free}}_{\mathit{tabletype}}({\mathit{tabletype}}) \\
{\mathrm{free}}_{\mathit{externtype}}(\mathsf{func}~{\mathit{typeuse}}) & = & {\mathrm{free}}_{\mathit{typeuse}}({\mathit{typeuse}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{moduletype}}({{\mathit{externtype}}_1^\ast} \rightarrow {{\mathit{externtype}}_2^\ast}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{externtype}}({\mathit{externtype}}_1)^\ast}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{externtype}}({\mathit{externtype}}_2)^\ast}) \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{num}}}_{{\mathsf{i}}{N}} & ::= & {i}{N} \\
& {{\mathit{num}}}_{{\mathsf{f}}{N}} & ::= & {f}{N} \\
& {{\mathit{pack}}}_{{\mathsf{i}}{N}} & ::= & {i}{N} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{lane}}}_{{\mathit{numtype}}} & ::= & {{\mathit{num}}}_{{\mathit{numtype}}} \\
& {{\mathit{lane}}}_{{\mathit{packtype}}} & ::= & {{\mathit{pack}}}_{{\mathit{packtype}}} \\
& {{\mathit{lane}}}_{{\mathsf{i}}{N}} & ::= & {i}{{|{\mathsf{i}}{N}|}} \\
& {{\mathit{vec}}}_{{\mathsf{v}}{N}} & ::= & {v}{{|{\mathsf{v}}{N}|}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{lit}}}_{{\mathit{numtype}}} & ::= & {{\mathit{num}}}_{{\mathit{numtype}}} \\
& {{\mathit{lit}}}_{{\mathit{vectype}}} & ::= & {{\mathit{vec}}}_{{\mathit{vectype}}} \\
& {{\mathit{lit}}}_{{\mathit{packtype}}} & ::= & {{\mathit{pack}}}_{{\mathit{packtype}}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(pack size)} & {\mathit{sz}} & ::= & \mathsf{{\scriptstyle 8}} ~~|~~ \mathsf{{\scriptstyle 16}} ~~|~~ \mathsf{{\scriptstyle 32}} ~~|~~ \mathsf{{\scriptstyle 64}} \\
\mbox{(signedness)} & {\mathit{sx}} & ::= & \mathsf{u} ~~|~~ \mathsf{s} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{unop}}}_{{\mathsf{i}}{N}} & ::= & \mathsf{clz} ~~|~~ \mathsf{ctz} ~~|~~ \mathsf{popcnt} ~~|~~ {\mathsf{extend}}{{\mathit{sz}}}{\mathsf{\_}}{\mathsf{s}} & \quad \mbox{if}~ {\mathit{sz}} < N \\
& {{\mathit{unop}}}_{{\mathsf{f}}{N}} & ::= & \mathsf{abs} ~~|~~ \mathsf{neg} ~~|~~ \mathsf{sqrt} ~~|~~ \mathsf{ceil} ~~|~~ \mathsf{floor} ~~|~~ \mathsf{trunc} ~~|~~ \mathsf{nearest} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{binop}}}_{{\mathsf{i}}{N}} & ::= & \mathsf{add} ~~|~~ \mathsf{sub} ~~|~~ \mathsf{mul} ~~|~~ {\mathsf{div}}{\mathsf{\_}}{{\mathit{sx}}} ~~|~~ {\mathsf{rem}}{\mathsf{\_}}{{\mathit{sx}}} \\
& & | & \mathsf{and} ~~|~~ \mathsf{or} ~~|~~ \mathsf{xor} ~~|~~ \mathsf{shl} ~~|~~ {\mathsf{shr}}{\mathsf{\_}}{{\mathit{sx}}} ~~|~~ \mathsf{rotl} ~~|~~ \mathsf{rotr} \\
& {{\mathit{binop}}}_{{\mathsf{f}}{N}} & ::= & \mathsf{add} ~~|~~ \mathsf{sub} ~~|~~ \mathsf{mul} ~~|~~ \mathsf{div} ~~|~~ \mathsf{min} ~~|~~ \mathsf{max} ~~|~~ \mathsf{copysign} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{testop}}}_{{\mathsf{i}}{N}} & ::= & \mathsf{eqz} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{relop}}}_{{\mathsf{i}}{N}} & ::= & \mathsf{eq} ~~|~~ \mathsf{ne} ~~|~~ {\mathsf{lt}}{\mathsf{\_}}{{\mathit{sx}}} ~~|~~ {\mathsf{gt}}{\mathsf{\_}}{{\mathit{sx}}} ~~|~~ {\mathsf{le}}{\mathsf{\_}}{{\mathit{sx}}} ~~|~~ {\mathsf{ge}}{\mathsf{\_}}{{\mathit{sx}}} \\
& {{\mathit{relop}}}_{{\mathsf{f}}{N}} & ::= & \mathsf{eq} ~~|~~ \mathsf{ne} ~~|~~ \mathsf{lt} ~~|~~ \mathsf{gt} ~~|~~ \mathsf{le} ~~|~~ \mathsf{ge} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{cvtop}}}_{{{\mathsf{i}}{N}}_1, {{\mathsf{i}}{N}}_2} & ::= & {\mathsf{extend}}{\mathsf{\_}}{{\mathit{sx}}} & \quad \mbox{if}~ N_1 < N_2 \\
& & | & \mathsf{wrap} & \quad \mbox{if}~ N_1 > N_2 \\
& {{\mathit{cvtop}}}_{{{\mathsf{i}}{N}}_1, {{\mathsf{f}}{N}}_2} & ::= & {\mathsf{convert}}{\mathsf{\_}}{{\mathit{sx}}} \\
& & | & \mathsf{reinterpret} & \quad \mbox{if}~ N_1 = N_2 \\
& {{\mathit{cvtop}}}_{{{\mathsf{f}}{N}}_1, {{\mathsf{i}}{N}}_2} & ::= & {\mathsf{trunc}}{\mathsf{\_}}{{\mathit{sx}}} \\
& & | & {\mathsf{trunc\_sat}}{\mathsf{\_}}{{\mathit{sx}}} \\
& & | & \mathsf{reinterpret} & \quad \mbox{if}~ N_1 = N_2 \\
& {{\mathit{cvtop}}}_{{{\mathsf{f}}{N}}_1, {{\mathsf{f}}{N}}_2} & ::= & \mathsf{promote} & \quad \mbox{if}~ N_1 < N_2 \\
& & | & \mathsf{demote} & \quad \mbox{if}~ N_1 > N_2 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(dimension)} & {\mathit{dim}} & ::= & \mathsf{{\scriptstyle 1}} ~~|~~ \mathsf{{\scriptstyle 2}} ~~|~~ \mathsf{{\scriptstyle 4}} ~~|~~ \mathsf{{\scriptstyle 8}} ~~|~~ \mathsf{{\scriptstyle 16}} \\
\mbox{(shape)} & {\mathit{shape}} & ::= & {{\mathit{lanetype}}}{\mathsf{x}}{{\mathit{dim}}} & \quad \mbox{if}~ {|{\mathit{lanetype}}|} \cdot {\mathit{dim}} = 128 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{dim}}({{\mathsf{i}}{N}}{\mathsf{x}}{N}) & = & N \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{lanetype}}({{\mathsf{i}}{N}}{\mathsf{x}}{N}) & = & {\mathsf{i}}{N} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{unpack}}({{\mathsf{i}}{N}}{\mathsf{x}}{N}) & = & {\mathrm{unpack}}({\mathsf{i}}{N}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(integer shape)} & {\mathit{ishape}} & ::= & {\mathit{shape}} & \quad \mbox{if}~ {\mathrm{lanetype}}({\mathit{shape}}) = {\mathsf{i}}{N} \\
\mbox{(byte shape)} & {\mathit{bshape}} & ::= & {\mathit{shape}} & \quad \mbox{if}~ {\mathrm{lanetype}}({\mathit{shape}}) = \mathsf{i{\scriptstyle 8}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{zero}} & ::= & \mathsf{zero} \\
& {\mathit{half}} & ::= & \mathsf{low} ~~|~~ \mathsf{high} \\
& {\mathit{vvunop}} & ::= & \mathsf{not} \\
& {\mathit{vvbinop}} & ::= & \mathsf{and} ~~|~~ \mathsf{andnot} ~~|~~ \mathsf{or} ~~|~~ \mathsf{xor} \\
& {\mathit{vvternop}} & ::= & \mathsf{bitselect} \\
& {\mathit{vvtestop}} & ::= & \mathsf{any\_true} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{vunop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}} & ::= & \mathsf{abs} ~~|~~ \mathsf{neg} \\
& & | & \mathsf{popcnt} & \quad \mbox{if}~ N = \mathsf{{\scriptstyle 8}} \\
& {{\mathit{vunop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}} & ::= & \mathsf{abs} ~~|~~ \mathsf{neg} ~~|~~ \mathsf{sqrt} ~~|~~ \mathsf{ceil} ~~|~~ \mathsf{floor} ~~|~~ \mathsf{trunc} ~~|~~ \mathsf{nearest} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{vbinop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}} & ::= & \mathsf{add} \\
& & | & \mathsf{sub} \\
& & | & {\mathsf{add\_sat}}{\mathsf{\_}}{{\mathit{sx}}} & \quad \mbox{if}~ N \leq \mathsf{{\scriptstyle 16}} \\
& & | & {\mathsf{sub\_sat}}{\mathsf{\_}}{{\mathit{sx}}} & \quad \mbox{if}~ N \leq \mathsf{{\scriptstyle 16}} \\
& & | & \mathsf{mul} & \quad \mbox{if}~ N \geq \mathsf{{\scriptstyle 16}} \\
& & | & {\mathsf{avgr}}{\mathsf{\_}}{\mathsf{u}} & \quad \mbox{if}~ N \leq \mathsf{{\scriptstyle 16}} \\
& & | & {\mathsf{q{\scriptstyle 15}mulr\_sat}}{\mathsf{\_}}{\mathsf{s}} & \quad \mbox{if}~ N = \mathsf{{\scriptstyle 16}} \\
& & | & {\mathsf{relaxed\_q{\scriptstyle 15}mulr}}{\mathsf{\_}}{\mathsf{s}} & \quad \mbox{if}~ N = \mathsf{{\scriptstyle 16}} \\
& & | & {\mathsf{min}}{\mathsf{\_}}{{\mathit{sx}}} & \quad \mbox{if}~ N \leq \mathsf{{\scriptstyle 32}} \\
& & | & {\mathsf{max}}{\mathsf{\_}}{{\mathit{sx}}} & \quad \mbox{if}~ N \leq \mathsf{{\scriptstyle 32}} \\
& {{\mathit{vbinop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}} & ::= & \mathsf{add} ~~|~~ \mathsf{sub} ~~|~~ \mathsf{mul} ~~|~~ \mathsf{div} ~~|~~ \mathsf{min} ~~|~~ \mathsf{max} ~~|~~ \mathsf{pmin} ~~|~~ \mathsf{pmax} \\
& & | & \mathsf{relaxed\_min} ~~|~~ \mathsf{relaxed\_max} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{vternop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}} & ::= & \mathsf{relaxed\_laneselect} \\
& {{\mathit{vternop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}} & ::= & \mathsf{relaxed\_madd} ~~|~~ \mathsf{relaxed\_nmadd} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{vtestop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}} & ::= & \mathsf{all\_true} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{vrelop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}} & ::= & \mathsf{eq} ~~|~~ \mathsf{ne} \\
& & | & {\mathsf{lt}}{\mathsf{\_}}{{\mathit{sx}}} & \quad \mbox{if}~ N \neq \mathsf{{\scriptstyle 64}} \lor {\mathit{sx}} = \mathsf{s} \\
& & | & {\mathsf{gt}}{\mathsf{\_}}{{\mathit{sx}}} & \quad \mbox{if}~ N \neq \mathsf{{\scriptstyle 64}} \lor {\mathit{sx}} = \mathsf{s} \\
& & | & {\mathsf{le}}{\mathsf{\_}}{{\mathit{sx}}} & \quad \mbox{if}~ N \neq \mathsf{{\scriptstyle 64}} \lor {\mathit{sx}} = \mathsf{s} \\
& & | & {\mathsf{ge}}{\mathsf{\_}}{{\mathit{sx}}} & \quad \mbox{if}~ N \neq \mathsf{{\scriptstyle 64}} \lor {\mathit{sx}} = \mathsf{s} \\
& {{\mathit{vrelop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}} & ::= & \mathsf{eq} ~~|~~ \mathsf{ne} ~~|~~ \mathsf{lt} ~~|~~ \mathsf{gt} ~~|~~ \mathsf{le} ~~|~~ \mathsf{ge} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{vshiftop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}} & ::= & \mathsf{shl} ~~|~~ {\mathsf{shr}}{\mathsf{\_}}{{\mathit{sx}}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{vswizzlop}}}_{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{M}} & ::= & \mathsf{swizzle} ~~|~~ \mathsf{relaxed\_swizzle} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{vextunop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}} & ::= & {\mathsf{extadd\_pairwise}}{\mathsf{\_}}{{\mathit{sx}}} & \quad \mbox{if}~ 16 \leq 2 \cdot N_1 = N_2 \leq \mathsf{{\scriptstyle 32}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{vextbinop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}} & ::= & {\mathsf{extmul}}{\mathsf{\_}}{{\mathit{half}}}{\mathsf{\_}}{{\mathit{sx}}} & \quad \mbox{if}~ 2 \cdot N_1 = N_2 \geq \mathsf{{\scriptstyle 16}} \\
& & | & {\mathsf{dot}}{\mathsf{\_}}{\mathsf{s}} & \quad \mbox{if}~ 2 \cdot N_1 = N_2 = \mathsf{{\scriptstyle 32}} \\
& & | & {\mathsf{relaxed\_dot}}{\mathsf{\_}}{\mathsf{s}} & \quad \mbox{if}~ 2 \cdot N_1 = N_2 = \mathsf{{\scriptstyle 16}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{vextternop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}} & ::= & {\mathsf{relaxed\_dot\_add}}{\mathsf{\_}}{\mathsf{s}} & \quad \mbox{if}~ 4 \cdot N_1 = N_2 = \mathsf{{\scriptstyle 32}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{vcvtop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}} & ::= & {\mathsf{extend}}{\mathsf{\_}}{{\mathit{half}}}{\mathsf{\_}}{{\mathit{sx}}} & \quad \mbox{if}~ N_2 = 2 \cdot N_1 \\
& {{\mathit{vcvtop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{f}}{N}}_2}{\mathsf{x}}{M_2}} & ::= & {\mathsf{convert}}{\mathsf{\_}}{{{\mathit{half}}^?}~{\mathit{sx}}} & \quad \mbox{if}~ N_2 = N_1 = \mathsf{{\scriptstyle 32}} \land {{\mathit{half}}^?} = \epsilon \lor N_2 = 2 \cdot N_1 \land {{\mathit{half}}^?} = \mathsf{low} \\
& {{\mathit{vcvtop}}}_{{{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}} & ::= & {\mathsf{trunc\_sat}}{\mathsf{\_}}{{\mathit{sx}}~{{\mathit{zero}}^?}} & \quad \mbox{if}~ N_1 = N_2 = \mathsf{{\scriptstyle 32}} \land {{\mathit{zero}}^?} = \epsilon \lor N_1 = 2 \cdot N_2 \land {{\mathit{zero}}^?} = \mathsf{zero} \\
& & | & {\mathsf{relaxed\_trunc}}{\mathsf{\_}}{{\mathit{sx}}~{{\mathit{zero}}^?}} & \quad \mbox{if}~ N_1 = N_2 = \mathsf{{\scriptstyle 32}} \land {{\mathit{zero}}^?} = \epsilon \lor N_1 = 2 \cdot N_2 \land {{\mathit{zero}}^?} = \mathsf{zero} \\
& {{\mathit{vcvtop}}}_{{{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{f}}{N}}_2}{\mathsf{x}}{M_2}} & ::= & {\mathsf{demote}}{\mathsf{\_}}{\mathsf{zero}} & \quad \mbox{if}~ N_1 = 2 \cdot N_2 \\
& & | & {\mathsf{promote}}{\mathsf{\_}}{\mathsf{low}} & \quad \mbox{if}~ 2 \cdot N_1 = N_2 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(memory argument)} & {\mathit{memarg}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{align}~{\mathit{u{\kern-0.1em\scriptstyle 32}}} ,  \mathsf{offset}~{\mathit{u{\kern-0.1em\scriptstyle 64}}} \} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{loadop}}}_{{\mathsf{i}}{N}} & ::= & {{\mathit{sz}}}{\mathsf{\_}}{{\mathit{sx}}} & \quad \mbox{if}~ {\mathit{sz}} < N \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{storeop}}}_{{\mathsf{i}}{N}} & ::= & {\mathit{sz}} & \quad \mbox{if}~ {\mathit{sz}} < N \\
& {{\mathit{vloadop}}}_{{\mathit{vectype}}} & ::= & {{\mathit{sz}}}{\mathsf{x}}{M}{\mathsf{\_}}{{\mathit{sx}}} & \quad \mbox{if}~ {\mathit{sz}} \cdot M = {|{\mathit{vectype}}|} / 2 \\
& & | & {{\mathit{sz}}}{\mathsf{\_}}{\mathsf{splat}} \\
& & | & {{\mathit{sz}}}{\mathsf{\_}}{\mathsf{zero}} & \quad \mbox{if}~ {\mathit{sz}} \geq \mathsf{{\scriptstyle 32}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(block type)} & {\mathit{blocktype}} & ::= & {{\mathit{valtype}}^?} \\
& & | & {\mathit{typeidx}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(instruction)} & {\mathit{instr}} & ::= & \mathsf{nop} \\
& & | & \mathsf{unreachable} \\
& & | & \mathsf{drop} \\
& & | & \mathsf{select}~{({{\mathit{valtype}}^\ast})^?} \\
& & | & \mathsf{block}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast} \\
& & | & \mathsf{loop}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast} \\
& & | & \mathsf{if}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast}~\mathsf{else}~{{\mathit{instr}}^\ast} \\
& & | & \mathsf{br}~{\mathit{labelidx}} \\
& & | & \mathsf{br\_if}~{\mathit{labelidx}} \\
& & | & \mathsf{br\_table}~{{\mathit{labelidx}}^\ast}~{\mathit{labelidx}} \\
& & | & \mathsf{br\_on\_null}~{\mathit{labelidx}} \\
& & | & \mathsf{br\_on\_non\_null}~{\mathit{labelidx}} \\
& & | & \mathsf{br\_on\_cast}~{\mathit{labelidx}}~{\mathit{reftype}}~{\mathit{reftype}} \\
& & | & \mathsf{br\_on\_cast\_fail}~{\mathit{labelidx}}~{\mathit{reftype}}~{\mathit{reftype}} \\
& & | & \mathsf{call}~{\mathit{funcidx}} \\
& & | & \mathsf{call\_ref}~{\mathit{typeuse}} \\
& & | & \mathsf{call\_indirect}~{\mathit{tableidx}}~{\mathit{typeuse}} \\
& & | & \mathsf{return} \\
& & | & \mathsf{return\_call}~{\mathit{funcidx}} \\
& & | & \mathsf{return\_call\_ref}~{\mathit{typeuse}} \\
& & | & \mathsf{return\_call\_indirect}~{\mathit{tableidx}}~{\mathit{typeuse}} \\
& & | & \mathsf{throw}~{\mathit{tagidx}} \\
& & | & \mathsf{throw\_ref} \\
& & | & \mathsf{try\_table}~{\mathit{blocktype}}~{\mathit{list}}({\mathit{catch}})~{{\mathit{instr}}^\ast} \\
& & | & \dots \\
\mbox{(catch clause)} & {\mathit{catch}} & ::= & \mathsf{catch}~{\mathit{tagidx}}~{\mathit{labelidx}} \\
& & | & \mathsf{catch\_ref}~{\mathit{tagidx}}~{\mathit{labelidx}} \\
& & | & \mathsf{catch\_all}~{\mathit{labelidx}} \\
& & | & \mathsf{catch\_all\_ref}~{\mathit{labelidx}} \\
\mbox{(instruction)} & {\mathit{instr}} & ::= & \dots \\
& & | & \mathsf{local{.}get}~{\mathit{localidx}} \\
& & | & \mathsf{local{.}set}~{\mathit{localidx}} \\
& & | & \mathsf{local{.}tee}~{\mathit{localidx}} \\
& & | & \mathsf{global{.}get}~{\mathit{globalidx}} \\
& & | & \mathsf{global{.}set}~{\mathit{globalidx}} \\
& & | & \mathsf{table{.}get}~{\mathit{tableidx}} \\
& & | & \mathsf{table{.}set}~{\mathit{tableidx}} \\
& & | & \mathsf{table{.}size}~{\mathit{tableidx}} \\
& & | & \mathsf{table{.}grow}~{\mathit{tableidx}} \\
& & | & \mathsf{table{.}fill}~{\mathit{tableidx}} \\
& & | & \mathsf{table{.}copy}~{\mathit{tableidx}}~{\mathit{tableidx}} \\
& & | & \mathsf{table{.}init}~{\mathit{tableidx}}~{\mathit{elemidx}} \\
& & | & \mathsf{elem{.}drop}~{\mathit{elemidx}} \\
& & | & {{\mathit{numtype}}{.}\mathsf{load}}{{{{\mathit{loadop}}}_{{\mathit{numtype}}}^?}}~{\mathit{memidx}}~{\mathit{memarg}} \\
& & | & {{\mathit{numtype}}{.}\mathsf{store}}{{{{\mathit{storeop}}}_{{\mathit{numtype}}}^?}}~{\mathit{memidx}}~{\mathit{memarg}} \\
& & | & {{\mathit{vectype}}{.}\mathsf{load}}{{{{\mathit{vloadop}}}_{{\mathit{vectype}}}^?}}~{\mathit{memidx}}~{\mathit{memarg}} \\
& & | & {{\mathit{vectype}}{.}\mathsf{load}}{{\mathit{sz}}}{\mathsf{\_}}{\mathsf{lane}}~{\mathit{memidx}}~{\mathit{memarg}}~{\mathit{laneidx}} \\
& & | & {\mathit{vectype}}{.}\mathsf{store}~{\mathit{memidx}}~{\mathit{memarg}} \\
& & | & {{\mathit{vectype}}{.}\mathsf{store}}{{\mathit{sz}}}{\mathsf{\_}}{\mathsf{lane}}~{\mathit{memidx}}~{\mathit{memarg}}~{\mathit{laneidx}} \\
& & | & \mathsf{memory{.}size}~{\mathit{memidx}} \\
& & | & \mathsf{memory{.}grow}~{\mathit{memidx}} \\
& & | & \mathsf{memory{.}fill}~{\mathit{memidx}} \\
& & | & \mathsf{memory{.}copy}~{\mathit{memidx}}~{\mathit{memidx}} \\
& & | & \mathsf{memory{.}init}~{\mathit{memidx}}~{\mathit{dataidx}} \\
& & | & \mathsf{data{.}drop}~{\mathit{dataidx}} \\
& & | & \mathsf{ref{.}null}~{\mathit{heaptype}} \\
& & | & \mathsf{ref{.}is\_null} \\
& & | & \mathsf{ref{.}as\_non\_null} \\
& & | & \mathsf{ref{.}eq} \\
& & | & \mathsf{ref{.}test}~{\mathit{reftype}} \\
& & | & \mathsf{ref{.}cast}~{\mathit{reftype}} \\
& & | & \mathsf{ref{.}func}~{\mathit{funcidx}} \\
& & | & \mathsf{ref{.}i{\scriptstyle 31}} \\
& & | & {\mathsf{i{\scriptstyle 31}{.}get}}{\mathsf{\_}}{{\mathit{sx}}} \\
& & | & \mathsf{struct{.}new}~{\mathit{typeidx}} \\
& & | & \mathsf{struct{.}new\_default}~{\mathit{typeidx}} \\
& & | & {\mathsf{struct{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~{\mathit{typeidx}}~{\mathit{u{\kern-0.1em\scriptstyle 32}}} \\
& & | & \mathsf{struct{.}set}~{\mathit{typeidx}}~{\mathit{u{\kern-0.1em\scriptstyle 32}}} \\
& & | & \mathsf{array{.}new}~{\mathit{typeidx}} \\
& & | & \mathsf{array{.}new\_default}~{\mathit{typeidx}} \\
& & | & \mathsf{array{.}new\_fixed}~{\mathit{typeidx}}~{\mathit{u{\kern-0.1em\scriptstyle 32}}} \\
& & | & \mathsf{array{.}new\_data}~{\mathit{typeidx}}~{\mathit{dataidx}} \\
& & | & \mathsf{array{.}new\_elem}~{\mathit{typeidx}}~{\mathit{elemidx}} \\
& & | & {\mathsf{array{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~{\mathit{typeidx}} \\
& & | & \mathsf{array{.}set}~{\mathit{typeidx}} \\
& & | & \mathsf{array{.}len} \\
& & | & \mathsf{array{.}fill}~{\mathit{typeidx}} \\
& & | & \mathsf{array{.}copy}~{\mathit{typeidx}}~{\mathit{typeidx}} \\
& & | & \mathsf{array{.}init\_data}~{\mathit{typeidx}}~{\mathit{dataidx}} \\
& & | & \mathsf{array{.}init\_elem}~{\mathit{typeidx}}~{\mathit{elemidx}} \\
& & | & \mathsf{extern{.}convert\_any} \\
& & | & \mathsf{any{.}convert\_extern} \\
& & | & {\mathit{numtype}}{.}\mathsf{const}~{{\mathit{num}}}_{{\mathit{numtype}}} \\
& & | & {\mathit{numtype}} {.} {{\mathit{unop}}}_{{\mathit{numtype}}} \\
& & | & {\mathit{numtype}} {.} {{\mathit{binop}}}_{{\mathit{numtype}}} \\
& & | & {\mathit{numtype}} {.} {{\mathit{testop}}}_{{\mathit{numtype}}} \\
& & | & {\mathit{numtype}} {.} {{\mathit{relop}}}_{{\mathit{numtype}}} \\
& & | & {\mathit{numtype}}_1 {.} {{{\mathit{cvtop}}}_{{\mathit{numtype}}_2, {\mathit{numtype}}_1}}{\mathsf{\_}}{{\mathit{numtype}}_2} \\
& & | & {\mathit{vectype}}{.}\mathsf{const}~{{\mathit{vec}}}_{{\mathit{vectype}}} \\
& & | & {\mathit{vectype}} {.} {\mathit{vvunop}} \\
& & | & {\mathit{vectype}} {.} {\mathit{vvbinop}} \\
& & | & {\mathit{vectype}} {.} {\mathit{vvternop}} \\
& & | & {\mathit{vectype}} {.} {\mathit{vvtestop}} \\
& & | & {\mathit{shape}} {.} {{\mathit{vunop}}}_{{\mathit{shape}}} \\
& & | & {\mathit{shape}} {.} {{\mathit{vbinop}}}_{{\mathit{shape}}} \\
& & | & {\mathit{shape}} {.} {{\mathit{vternop}}}_{{\mathit{shape}}} \\
& & | & {\mathit{shape}} {.} {{\mathit{vtestop}}}_{{\mathit{shape}}} \\
& & | & {\mathit{shape}} {.} {{\mathit{vrelop}}}_{{\mathit{shape}}} \\
& & | & {\mathit{ishape}} {.} {{\mathit{vshiftop}}}_{{\mathit{ishape}}} \\
& & | & {\mathit{ishape}}{.}\mathsf{bitmask} \\
& & | & {\mathit{bshape}} {.} {{\mathit{vswizzlop}}}_{{\mathit{bshape}}} \\
& & | & {\mathit{bshape}}{.}\mathsf{shuffle}~{{\mathit{laneidx}}^\ast} & \quad \mbox{if}~ {|{{\mathit{laneidx}}^\ast}|} = {\mathrm{dim}}({\mathit{bshape}}) \\
& & | & {\mathit{ishape}}_1 {.} {{{\mathit{vextunop}}}_{{\mathit{ishape}}_2, {\mathit{ishape}}_1}}{\mathsf{\_}}{{\mathit{ishape}}_2} \\
& & | & {\mathit{ishape}}_1 {.} {{{\mathit{vextbinop}}}_{{\mathit{ishape}}_2, {\mathit{ishape}}_1}}{\mathsf{\_}}{{\mathit{ishape}}_2} \\
& & | & {\mathit{ishape}}_1 {.} {{{\mathit{vextternop}}}_{{\mathit{ishape}}_2, {\mathit{ishape}}_1}}{\mathsf{\_}}{{\mathit{ishape}}_2} \\
& & | & {{\mathit{ishape}}_1{.}\mathsf{narrow}}{\mathsf{\_}}{{\mathit{ishape}}_2}{\mathsf{\_}}{{\mathit{sx}}} & \quad \mbox{if}~ {|{\mathrm{lanetype}}({\mathit{ishape}}_2)|} = 2 \cdot {|{\mathrm{lanetype}}({\mathit{ishape}}_1)|} \leq \mathsf{{\scriptstyle 32}} \\
& & | & {\mathit{shape}}_1 {.} {{{\mathit{vcvtop}}}_{{\mathit{shape}}_2, {\mathit{shape}}_1}}{\mathsf{\_}}{{\mathit{shape}}_2} \\
& & | & {\mathit{shape}}{.}\mathsf{splat} \\
& & | & {{\mathit{shape}}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~{\mathit{laneidx}} & \quad \mbox{if}~ {{\mathit{sx}}^?} = \epsilon \Leftrightarrow {\mathrm{lanetype}}({\mathit{shape}}) \in \mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 64}}~\mathsf{f{\scriptstyle 32}}~\mathsf{f{\scriptstyle 64}} \\
& & | & {\mathit{shape}}{.}\mathsf{replace\_lane}~{\mathit{laneidx}} \\
& & | & \dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(expression)} & {\mathit{expr}} & ::= & {{\mathit{instr}}^\ast} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
& = & \{ \mathsf{align}~0,\;\allowbreak \mathsf{offset}~0 \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathit{numtype}}{.}\mathsf{const}~c & = & ({\mathit{numtype}}{.}\mathsf{const}~c) \\
{\mathit{vectype}}{.}\mathsf{const}~c & = & ({\mathit{vectype}}{.}\mathsf{const}~c) \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{shape}}({{\mathit{lanetype}}}{\mathsf{x}}{{\mathit{dim}}}) & = & {\mathrm{free}}_{\mathit{lanetype}}({\mathit{lanetype}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{blocktype}}({{\mathit{valtype}}^?}) & = & {\mathrm{free}}_{\mathit{opt}}({{\mathrm{free}}_{\mathit{valtype}}({\mathit{valtype}})^?}) \\
{\mathrm{free}}_{\mathit{blocktype}}({\mathit{typeidx}}) & = & {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{instr}}(\mathsf{nop}) & = & \{  \} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{unreachable}) & = & \{  \} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{drop}) & = & \{  \} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{select}~{({{\mathit{valtype}}^\ast})^?}) & = & {\mathrm{free}}_{\mathit{opt}}({{\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{valtype}}({\mathit{valtype}})^\ast})^?}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{block}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast}) & = & {\mathrm{free}}_{\mathit{blocktype}}({\mathit{blocktype}}) \oplus {\mathrm{free}}_{\mathit{block}}({{\mathit{instr}}^\ast}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{loop}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast}) & = & {\mathrm{free}}_{\mathit{blocktype}}({\mathit{blocktype}}) \oplus {\mathrm{free}}_{\mathit{block}}({{\mathit{instr}}^\ast}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{if}~{\mathit{blocktype}}~{{\mathit{instr}}_1^\ast}~\mathsf{else}~{{\mathit{instr}}_2^\ast}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{blocktype}}({\mathit{blocktype}}) \oplus {\mathrm{free}}_{\mathit{block}}({{\mathit{instr}}_1^\ast}) \oplus {\mathrm{free}}_{\mathit{block}}({{\mathit{instr}}_2^\ast}) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{br}~{\mathit{labelidx}}) & = & {\mathrm{free}}_{\mathit{labelidx}}({\mathit{labelidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{br\_if}~{\mathit{labelidx}}) & = & {\mathrm{free}}_{\mathit{labelidx}}({\mathit{labelidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{br\_table}~{{\mathit{labelidx}}^\ast}~{\mathit{labelidx}'}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{labelidx}}({\mathit{labelidx}})^\ast}) \oplus {\mathrm{free}}_{\mathit{labelidx}}({\mathit{labelidx}'}) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{br\_on\_null}~{\mathit{labelidx}}) & = & {\mathrm{free}}_{\mathit{labelidx}}({\mathit{labelidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{br\_on\_non\_null}~{\mathit{labelidx}}) & = & {\mathrm{free}}_{\mathit{labelidx}}({\mathit{labelidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{br\_on\_cast}~{\mathit{labelidx}}~{\mathit{reftype}}_1~{\mathit{reftype}}_2) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{labelidx}}({\mathit{labelidx}}) \oplus {\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}_1) \oplus {\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}_2) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{br\_on\_cast\_fail}~{\mathit{labelidx}}~{\mathit{reftype}}_1~{\mathit{reftype}}_2) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{labelidx}}({\mathit{labelidx}}) \oplus {\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}_1) \oplus {\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}_2) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{call}~{\mathit{funcidx}}) & = & {\mathrm{free}}_{\mathit{funcidx}}({\mathit{funcidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{call\_ref}~{\mathit{typeuse}}) & = & {\mathrm{free}}_{\mathit{typeuse}}({\mathit{typeuse}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{call\_indirect}~{\mathit{tableidx}}~{\mathit{typeuse}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \oplus {\mathrm{free}}_{\mathit{typeuse}}({\mathit{typeuse}}) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{return}) & = & \{  \} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{return\_call}~{\mathit{funcidx}}) & = & {\mathrm{free}}_{\mathit{funcidx}}({\mathit{funcidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{return\_call\_ref}~{\mathit{typeuse}}) & = & {\mathrm{free}}_{\mathit{typeuse}}({\mathit{typeuse}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{return\_call\_indirect}~{\mathit{tableidx}}~{\mathit{typeuse}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \oplus {\mathrm{free}}_{\mathit{typeuse}}({\mathit{typeuse}}) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{numtype}}{.}\mathsf{const}~{\mathit{numlit}}) & = & {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{numtype}} {.} {\mathit{unop}}) & = & {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{numtype}} {.} {\mathit{binop}}) & = & {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{numtype}} {.} {\mathit{testop}}) & = & {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{numtype}} {.} {\mathit{relop}}) & = & {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{numtype}}_1 {.} {{\mathit{cvtop}}}{\mathsf{\_}}{{\mathit{numtype}}_2}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}_1) \oplus {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}_2) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{vectype}}{.}\mathsf{const}~{\mathit{veclit}}) & = & {\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{vectype}} {.} {\mathit{vvunop}}) & = & {\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{vectype}} {.} {\mathit{vvbinop}}) & = & {\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{vectype}} {.} {\mathit{vvternop}}) & = & {\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{vectype}} {.} {\mathit{vvtestop}}) & = & {\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{shape}} {.} {\mathit{vunop}}) & = & {\mathrm{free}}_{\mathit{shape}}({\mathit{shape}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{shape}} {.} {\mathit{vbinop}}) & = & {\mathrm{free}}_{\mathit{shape}}({\mathit{shape}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{shape}} {.} {\mathit{vternop}}) & = & {\mathrm{free}}_{\mathit{shape}}({\mathit{shape}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{shape}} {.} {\mathit{vtestop}}) & = & {\mathrm{free}}_{\mathit{shape}}({\mathit{shape}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{shape}} {.} {\mathit{vrelop}}) & = & {\mathrm{free}}_{\mathit{shape}}({\mathit{shape}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{ishape}} {.} {\mathit{vshiftop}}) & = & {\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{ishape}}{.}\mathsf{bitmask}) & = & {\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{bshape}} {.} {\mathit{vswizzlop}}) & = & {\mathrm{free}}_{\mathit{shape}}({\mathit{bshape}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{bshape}}{.}\mathsf{shuffle}~{{\mathit{laneidx}}^\ast}) & = & {\mathrm{free}}_{\mathit{shape}}({\mathit{bshape}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{ishape}}_1 {.} {{\mathit{vextunop}}}{\mathsf{\_}}{{\mathit{ishape}}_2}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}_1) \oplus {\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}_2) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{ishape}}_1 {.} {{\mathit{vextbinop}}}{\mathsf{\_}}{{\mathit{ishape}}_2}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}_1) \oplus {\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}_2) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{ishape}}_1 {.} {{\mathit{vextternop}}}{\mathsf{\_}}{{\mathit{ishape}}_2}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}_1) \oplus {\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}_2) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}({{\mathit{ishape}}_1{.}\mathsf{narrow}}{\mathsf{\_}}{{\mathit{ishape}}_2}{\mathsf{\_}}{{\mathit{sx}}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}_1) \oplus {\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}_2) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{shape}}_1 {.} {{\mathit{vcvtop}}}{\mathsf{\_}}{{\mathit{shape}}_2}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{shape}}({\mathit{shape}}_1) \oplus {\mathrm{free}}_{\mathit{shape}}({\mathit{shape}}_2) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{shape}}{.}\mathsf{splat}) & = & {\mathrm{free}}_{\mathit{shape}}({\mathit{shape}}) \\
{\mathrm{free}}_{\mathit{instr}}({{\mathit{shape}}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~{\mathit{laneidx}}) & = & {\mathrm{free}}_{\mathit{shape}}({\mathit{shape}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{shape}}{.}\mathsf{replace\_lane}~{\mathit{laneidx}}) & = & {\mathrm{free}}_{\mathit{shape}}({\mathit{shape}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{ref{.}null}~{\mathit{heaptype}}) & = & {\mathrm{free}}_{\mathit{heaptype}}({\mathit{heaptype}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{ref{.}is\_null}) & = & \{  \} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{ref{.}as\_non\_null}) & = & \{  \} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{ref{.}eq}) & = & \{  \} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{ref{.}test}~{\mathit{reftype}}) & = & {\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{ref{.}cast}~{\mathit{reftype}}) & = & {\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{ref{.}func}~{\mathit{funcidx}}) & = & {\mathrm{free}}_{\mathit{funcidx}}({\mathit{funcidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{ref{.}i{\scriptstyle 31}}) & = & \{  \} \\
{\mathrm{free}}_{\mathit{instr}}({\mathsf{i{\scriptstyle 31}{.}get}}{\mathsf{\_}}{{\mathit{sx}}}) & = & \{  \} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{struct{.}new}~{\mathit{typeidx}}) & = & \{  \} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{struct{.}new\_default}~{\mathit{typeidx}}) & = & {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathsf{struct{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~{\mathit{typeidx}}~{\mathit{u{\kern-0.1em\scriptstyle 32}}}) & = & {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{struct{.}set}~{\mathit{typeidx}}~{\mathit{u{\kern-0.1em\scriptstyle 32}}}) & = & {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}new}~{\mathit{typeidx}}) & = & {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}new\_default}~{\mathit{typeidx}}) & = & {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}new\_fixed}~{\mathit{typeidx}}~{\mathit{u{\kern-0.1em\scriptstyle 32}}}) & = & {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}new\_data}~{\mathit{typeidx}}~{\mathit{dataidx}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \oplus {\mathrm{free}}_{\mathit{dataidx}}({\mathit{dataidx}}) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}new\_elem}~{\mathit{typeidx}}~{\mathit{elemidx}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \oplus {\mathrm{free}}_{\mathit{elemidx}}({\mathit{elemidx}}) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}({\mathsf{array{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~{\mathit{typeidx}}) & = & {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}set}~{\mathit{typeidx}}) & = & {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}len}) & = & \{  \} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}fill}~{\mathit{typeidx}}) & = & {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}copy}~{\mathit{typeidx}}_1~{\mathit{typeidx}}_2) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}_1) \oplus {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}_2) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}init\_data}~{\mathit{typeidx}}~{\mathit{dataidx}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \oplus {\mathrm{free}}_{\mathit{dataidx}}({\mathit{dataidx}}) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}init\_elem}~{\mathit{typeidx}}~{\mathit{elemidx}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \oplus {\mathrm{free}}_{\mathit{elemidx}}({\mathit{elemidx}}) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{extern{.}convert\_any}) & = & \{  \} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{any{.}convert\_extern}) & = & \{  \} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{local{.}get}~{\mathit{localidx}}) & = & {\mathrm{free}}_{\mathit{localidx}}({\mathit{localidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{local{.}set}~{\mathit{localidx}}) & = & {\mathrm{free}}_{\mathit{localidx}}({\mathit{localidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{local{.}tee}~{\mathit{localidx}}) & = & {\mathrm{free}}_{\mathit{localidx}}({\mathit{localidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{global{.}get}~{\mathit{globalidx}}) & = & {\mathrm{free}}_{\mathit{globalidx}}({\mathit{globalidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{global{.}set}~{\mathit{globalidx}}) & = & {\mathrm{free}}_{\mathit{globalidx}}({\mathit{globalidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{table{.}get}~{\mathit{tableidx}}) & = & {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{table{.}set}~{\mathit{tableidx}}) & = & {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{table{.}size}~{\mathit{tableidx}}) & = & {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{table{.}grow}~{\mathit{tableidx}}) & = & {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{table{.}fill}~{\mathit{tableidx}}) & = & {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{table{.}copy}~{\mathit{tableidx}}_1~{\mathit{tableidx}}_2) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}_1) \oplus {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}_2) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{table{.}init}~{\mathit{tableidx}}~{\mathit{elemidx}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \oplus {\mathrm{free}}_{\mathit{elemidx}}({\mathit{elemidx}}) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{elem{.}drop}~{\mathit{elemidx}}) & = & {\mathrm{free}}_{\mathit{elemidx}}({\mathit{elemidx}}) \\
{\mathrm{free}}_{\mathit{instr}}({{\mathit{numtype}}{.}\mathsf{load}}{{{\mathit{loadop}}^?}}~{\mathit{memidx}}~{\mathit{memarg}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \oplus {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}({{\mathit{numtype}}{.}\mathsf{store}}{{{\mathit{storeop}}^?}}~{\mathit{memidx}}~{\mathit{memarg}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \oplus {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}({{\mathit{vectype}}{.}\mathsf{load}}{{{\mathit{vloadop}}^?}}~{\mathit{memidx}}~{\mathit{memarg}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \oplus {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}({{\mathit{vectype}}{.}\mathsf{load}}{{\mathit{sz}}}{\mathsf{\_}}{\mathsf{lane}}~{\mathit{memidx}}~{\mathit{memarg}}~{\mathit{laneidx}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \oplus {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{vectype}}{.}\mathsf{store}~{\mathit{memidx}}~{\mathit{memarg}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \oplus {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}({{\mathit{vectype}}{.}\mathsf{store}}{{\mathit{sz}}}{\mathsf{\_}}{\mathsf{lane}}~{\mathit{memidx}}~{\mathit{memarg}}~{\mathit{laneidx}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \oplus {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{memory{.}size}~{\mathit{memidx}}) & = & {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{memory{.}grow}~{\mathit{memidx}}) & = & {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{memory{.}fill}~{\mathit{memidx}}) & = & {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{memory{.}copy}~{\mathit{memidx}}_1~{\mathit{memidx}}_2) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}_1) \oplus {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}_2) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{memory{.}init}~{\mathit{memidx}}~{\mathit{dataidx}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \oplus {\mathrm{free}}_{\mathit{dataidx}}({\mathit{dataidx}}) \\
\end{array}
} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{data{.}drop}~{\mathit{dataidx}}) & = & {\mathrm{free}}_{\mathit{dataidx}}({\mathit{dataidx}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{shift}}_{\mathit{labelidxs}}(\epsilon) & = & \epsilon \\
{\mathrm{shift}}_{\mathit{labelidxs}}(0~{{\mathit{labelidx}'}^\ast}) & = & {\mathrm{shift}}_{\mathit{labelidxs}}({{\mathit{labelidx}'}^\ast}) \\
{\mathrm{shift}}_{\mathit{labelidxs}}({\mathit{labelidx}}~{{\mathit{labelidx}'}^\ast}) & = & ({\mathit{labelidx}} - 1)~{\mathrm{shift}}_{\mathit{labelidxs}}({{\mathit{labelidx}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{block}}({{\mathit{instr}}^\ast}) & = & {\mathit{free}}{}[{.}\mathsf{labels} = {\mathrm{shift}}_{\mathit{labelidxs}}({\mathit{free}}{.}\mathsf{labels})] & \quad \mbox{if}~ {\mathit{free}} = {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{instr}}({\mathit{instr}})^\ast}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{expr}}({{\mathit{instr}}^\ast}) & = & {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{instr}}({\mathit{instr}})^\ast}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(element mode)} & {\mathit{elemmode}} & ::= & \mathsf{active}~{\mathit{tableidx}}~{\mathit{expr}} ~~|~~ \mathsf{passive} ~~|~~ \mathsf{declare} \\
\mbox{(data mode)} & {\mathit{datamode}} & ::= & \mathsf{active}~{\mathit{memidx}}~{\mathit{expr}} ~~|~~ \mathsf{passive} \\
\mbox{(type definition)} & {\mathit{type}} & ::= & \mathsf{type}~{\mathit{rectype}} \\
\mbox{(tag)} & {\mathit{tag}} & ::= & \mathsf{tag}~{\mathit{tagtype}} \\
\mbox{(global)} & {\mathit{global}} & ::= & \mathsf{global}~{\mathit{globaltype}}~{\mathit{expr}} \\
\mbox{(memory)} & {\mathit{mem}} & ::= & \mathsf{memory}~{\mathit{memtype}} \\
\mbox{(table)} & {\mathit{table}} & ::= & \mathsf{table}~{\mathit{tabletype}}~{\mathit{expr}} \\
\mbox{(memory segment)} & {\mathit{data}} & ::= & \mathsf{data}~{{\mathit{byte}}^\ast}~{\mathit{datamode}} \\
\mbox{(local)} & {\mathit{local}} & ::= & \mathsf{local}~{\mathit{valtype}} \\
\mbox{(function)} & {\mathit{func}} & ::= & \mathsf{func}~{\mathit{typeidx}}~{{\mathit{local}}^\ast}~{\mathit{expr}} \\
\mbox{(table segment)} & {\mathit{elem}} & ::= & \mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}^\ast}~{\mathit{elemmode}} \\
\mbox{(start function)} & {\mathit{start}} & ::= & \mathsf{start}~{\mathit{funcidx}} \\
\mbox{(import)} & {\mathit{import}} & ::= & \mathsf{import}~{\mathit{name}}~{\mathit{name}}~{\mathit{externtype}} \\
\mbox{(export)} & {\mathit{export}} & ::= & \mathsf{export}~{\mathit{name}}~{\mathit{externidx}} \\
\mbox{(module)} & {\mathit{module}} & ::= & \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{tag}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{type}}(\mathsf{type}~{\mathit{rectype}}) & = & {\mathrm{free}}_{\mathit{rectype}}({\mathit{rectype}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{tag}}(\mathsf{tag}~{\mathit{tagtype}}) & = & {\mathrm{free}}_{\mathit{tagtype}}({\mathit{tagtype}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{global}}(\mathsf{global}~{\mathit{globaltype}}~{\mathit{expr}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{globaltype}}({\mathit{globaltype}}) \oplus {\mathrm{free}}_{\mathit{expr}}({\mathit{expr}}) \\
\end{array}
} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{mem}}(\mathsf{memory}~{\mathit{memtype}}) & = & {\mathrm{free}}_{\mathit{memtype}}({\mathit{memtype}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{table}}(\mathsf{table}~{\mathit{tabletype}}~{\mathit{expr}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{tabletype}}({\mathit{tabletype}}) \oplus {\mathrm{free}}_{\mathit{expr}}({\mathit{expr}}) \\
\end{array}
} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{local}}(\mathsf{local}~t) & = & {\mathrm{free}}_{\mathit{valtype}}(t) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{func}}(\mathsf{func}~{\mathit{typeidx}}~{{\mathit{local}}^\ast}~{\mathit{expr}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{local}}({\mathit{local}})^\ast}) \oplus {\mathrm{free}}_{\mathit{block}}({\mathit{expr}}){}[{.}\mathsf{locals} = \epsilon] \\
\end{array}
} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{data}}(\mathsf{data}~{{\mathit{byte}}^\ast}~{\mathit{datamode}}) & = & {\mathrm{free}}_{\mathit{datamode}}({\mathit{datamode}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{elem}}(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}^\ast}~{\mathit{elemmode}}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{expr}}({\mathit{expr}})^\ast}) \oplus {\mathrm{free}}_{\mathit{elemmode}}({\mathit{elemmode}}) \\
\end{array}
} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{elemmode}}(\mathsf{active}~{\mathit{tableidx}}~{\mathit{expr}}) & = & {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \oplus {\mathrm{free}}_{\mathit{expr}}({\mathit{expr}}) \\
{\mathrm{free}}_{\mathit{elemmode}}(\mathsf{passive}) & = & \{  \} \\
{\mathrm{free}}_{\mathit{elemmode}}(\mathsf{declare}) & = & \{  \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{datamode}}(\mathsf{active}~{\mathit{memidx}}~{\mathit{expr}}) & = & {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \oplus {\mathrm{free}}_{\mathit{expr}}({\mathit{expr}}) \\
{\mathrm{free}}_{\mathit{datamode}}(\mathsf{passive}) & = & \{  \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{start}}(\mathsf{start}~{\mathit{funcidx}}) & = & {\mathrm{free}}_{\mathit{funcidx}}({\mathit{funcidx}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{import}}(\mathsf{import}~{\mathit{name}}_1~{\mathit{name}}_2~{\mathit{externtype}}) & = & {\mathrm{free}}_{\mathit{externtype}}({\mathit{externtype}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{export}}(\mathsf{export}~{\mathit{name}}~{\mathit{externidx}}) & = & {\mathrm{free}}_{\mathit{externidx}}({\mathit{externidx}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{module}}(\mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{tag}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{type}}({\mathit{type}})^\ast}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{tag}}({\mathit{tag}})^\ast}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{global}}({\mathit{global}})^\ast}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{mem}}({\mathit{mem}})^\ast}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{table}}({\mathit{table}})^\ast}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{func}}({\mathit{func}})^\ast}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{data}}({\mathit{data}})^\ast}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{elem}}({\mathit{elem}})^\ast}) \oplus {\mathrm{free}}_{\mathit{opt}}({{\mathrm{free}}_{\mathit{start}}({\mathit{start}})^?}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{import}}({\mathit{import}})^\ast}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{export}}({\mathit{export}})^\ast}) \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{funcidx}}({\mathit{module}}) & = & {\mathrm{free}}_{\mathit{module}}({\mathit{module}}){.}\mathsf{funcs} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{dataidx}}({{\mathit{func}}^\ast}) & = & {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{func}}({\mathit{func}})^\ast}){.}\mathsf{datas} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(initialization status)} & {\mathit{init}} & ::= & \mathsf{set} ~~|~~ \mathsf{unset} \\
\mbox{(local type)} & {\mathit{localtype}} & ::= & {\mathit{init}}~{\mathit{valtype}} \\
\mbox{(instruction type)} & {\mathit{instrtype}} & ::= & {\mathit{resulttype}} \rightarrow_{{{\mathit{localidx}}^\ast}} {\mathit{resulttype}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(context)} & {\mathit{context}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{types}~{{\mathit{deftype}}^\ast} \\
\mathsf{recs}~{{\mathit{subtype}}^\ast} \\
\mathsf{tags}~{{\mathit{tagtype}}^\ast} \\
\mathsf{globals}~{{\mathit{globaltype}}^\ast} \\
\mathsf{mems}~{{\mathit{memtype}}^\ast} \\
\mathsf{tables}~{{\mathit{tabletype}}^\ast} \\
\mathsf{funcs}~{{\mathit{deftype}}^\ast} \\
\mathsf{datas}~{{\mathit{datatype}}^\ast} \\
\mathsf{elems}~{{\mathit{elemtype}}^\ast} \\
\mathsf{locals}~{{\mathit{localtype}}^\ast} \\
\mathsf{labels}~{{\mathit{resulttype}}^\ast} \\
\mathsf{return}~{{\mathit{resulttype}}^?} \\
\mathsf{refs}~{{\mathit{funcidx}}^\ast} \} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
C{}[{.}\mathsf{local}{}[\epsilon] = \epsilon] & = & C \\
C{}[{.}\mathsf{local}{}[x_1~{x^\ast}] = {{\mathit{lt}}}_1~{{{\mathit{lt}}}^\ast}] & = & C{}[{.}\mathsf{locals}{}[x_1] = {{\mathit{lt}}}_1]{}[{.}\mathsf{local}{}[{x^\ast}] = {{{\mathit{lt}}}^\ast}] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{clos}}}_{C}(t) & = & {t}{{}[ {:=}\, {{\mathit{dt}}^\ast} ]} & \quad \mbox{if}~ {{\mathit{dt}}^\ast} = {{{\mathrm{clos}}^\ast}}{(C{.}\mathsf{types})} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{clos}}}_{C}({\mathit{dt}}) & = & {{\mathit{dt}}}{{}[ {:=}\, {{\mathit{dt}'}^\ast} ]} & \quad \mbox{if}~ {{\mathit{dt}'}^\ast} = {{{\mathrm{clos}}^\ast}}{(C{.}\mathsf{types})} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{clos}}}_{C}({\mathit{jt}}) & = & {{\mathit{jt}}}{{}[ {:=}\, {{\mathit{dt}}^\ast} ]} & \quad \mbox{if}~ {{\mathit{dt}}^\ast} = {{{\mathrm{clos}}^\ast}}{(C{.}\mathsf{types})} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{clos}}}_{C}({\mathit{xt}}) & = & {{\mathit{xt}}}{{}[ {:=}\, {{\mathit{dt}}^\ast} ]} & \quad \mbox{if}~ {{\mathit{dt}}^\ast} = {{{\mathrm{clos}}^\ast}}{(C{.}\mathsf{types})} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{clos}}}_{C}({\mathit{mmt}}) & = & {{\mathit{mmt}}}{{}[ {:=}\, {{\mathit{dt}}^\ast} ]} & \quad \mbox{if}~ {{\mathit{dt}}^\ast} = {{{\mathrm{clos}}^\ast}}{(C{.}\mathsf{types})} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{{\mathrm{clos}}^\ast}}{(\epsilon)} & = & \epsilon \\
{{{\mathrm{clos}}^\ast}}{({{\mathit{dt}}^\ast}~{\mathit{dt}}_n)} & = & {{\mathit{dt}'}^\ast}~{{\mathit{dt}}_n}{{}[ {:=}\, {{\mathit{dt}'}^\ast} ]} & \quad \mbox{if}~ {{\mathit{dt}'}^\ast} = {{{\mathrm{clos}}^\ast}}{({{\mathit{dt}}^\ast})} \\
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{numtype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{vectype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{heaptype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{reftype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{valtype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{typeuse}} : \mathsf{ok}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{numtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}num}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{vectype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}vec}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{absheaptype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}heap{-}abs}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{typeuse}} : \mathsf{ok}
}{
C \vdash {\mathit{typeuse}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}heap{-}typeuse}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{heaptype}} : \mathsf{ok}
}{
C \vdash \mathsf{ref}~{\mathsf{null}^?}~{\mathit{heaptype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{numtype}} : \mathsf{ok}
}{
C \vdash {\mathit{numtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}val{-}num}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{vectype}} : \mathsf{ok}
}{
C \vdash {\mathit{vectype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}val{-}vec}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{reftype}} : \mathsf{ok}
}{
C \vdash {\mathit{reftype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}val{-}ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{bot} : \mathsf{ok}
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
(C \vdash t : \mathsf{ok})^\ast
}{
C \vdash {t^\ast} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}result}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {t_1^\ast} : \mathsf{ok}
 \qquad
C \vdash {t_2^\ast} : \mathsf{ok}
 \qquad
(C{.}\mathsf{locals}{}[x] = {{\mathit{lt}}})^\ast
}{
C \vdash {t_1^\ast} \rightarrow_{{x^\ast}} {t_2^\ast} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}instr}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{deftype}} \approx {\mathit{comptype}}}$

$\boxed{{\mathit{typeuse}} \approx_{{\mathit{context}}} {\mathit{comptype}}}$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize Expand}]} \quad & {\mathit{deftype}} & \approx & {\mathit{comptype}} & \quad \mbox{if}~ {\mathrm{expand}}({\mathit{deftype}}) = {\mathit{comptype}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize Expand\_use{-}deftype}]} \quad & {\mathit{deftype}} & {\approx}_{C} {} & {\mathit{comptype}} & \quad \mbox{if}~ {\mathit{deftype}} \approx {\mathit{comptype}} \\
{[\textsc{\scriptsize Expand\_use{-}typeidx}]} \quad & {\mathit{typeidx}} & {\approx}_{C} {} & {\mathit{comptype}} & \quad \mbox{if}~ C{.}\mathsf{types}{}[{\mathit{typeidx}}] \approx {\mathit{comptype}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathsf{ok}}{({\mathit{typeidx}})} & ::= & {\mathsf{ok}}{{\mathit{typeidx}}} \\
& {\mathsf{ok}}{({\mathit{typeidx}}, n)} & ::= & {\mathsf{ok}}{({\mathit{typeidx}}, \mathbb{N})} \\
\end{array}
$$

$\boxed{{\mathit{context}} \vdash {\mathit{packtype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{fieldtype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{storagetype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{comptype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{subtype}} : {\mathsf{ok}}{({\mathit{typeidx}})}}$

$\boxed{{\mathit{context}} \vdash {\mathit{rectype}} : {\mathsf{ok}}{({\mathit{typeidx}})}}$

$\boxed{{\mathit{context}} \vdash {\mathit{subtype}} : {\mathsf{ok}}{({\mathit{typeidx}}, n)}}$

$\boxed{{\mathit{context}} \vdash {\mathit{rectype}} : {\mathsf{ok}}{({\mathit{typeidx}}, n)}}$

$\boxed{{\mathit{context}} \vdash {\mathit{deftype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{comptype}} \leq {\mathit{comptype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{deftype}} \leq {\mathit{deftype}}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[{\mathit{typeidx}}] = {\mathit{dt}}
}{
C \vdash {\mathit{typeidx}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}typeuse{-}typeidx}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{recs}{}[i] = {\mathit{st}}
}{
C \vdash \mathsf{rec} {.} i : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}typeuse{-}rec}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{deftype}} : \mathsf{ok}
}{
C \vdash {\mathit{deftype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}typeuse{-}deftype}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{packtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}pack}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{valtype}} : \mathsf{ok}
}{
C \vdash {\mathit{valtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}storage{-}val}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{packtype}} : \mathsf{ok}
}{
C \vdash {\mathit{packtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}storage{-}pack}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{storagetype}} : \mathsf{ok}
}{
C \vdash {\mathsf{mut}^?}~{\mathit{storagetype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}field}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
(C \vdash {\mathit{fieldtype}} : \mathsf{ok})^\ast
}{
C \vdash \mathsf{struct}~{{\mathit{fieldtype}}^\ast} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}comp{-}struct}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{fieldtype}} : \mathsf{ok}
}{
C \vdash \mathsf{array}~{\mathit{fieldtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}comp{-}array}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {t_1^\ast} : \mathsf{ok}
 \qquad
C \vdash {t_2^\ast} : \mathsf{ok}
}{
C \vdash \mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}comp{-}func}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\begin{array}{@{}c@{}}
{|{x^\ast}|} \leq 1
 \qquad
(x < x_0)^\ast
 \qquad
({\mathrm{unroll}}(C{.}\mathsf{types}{}[x]) = \mathsf{sub}~{{x'}^\ast}~{\mathit{comptype}'})^\ast
 \\
C \vdash {\mathit{comptype}} : \mathsf{ok}
 \qquad
(C \vdash {\mathit{comptype}} \leq {\mathit{comptype}'})^\ast
\end{array}
}{
C \vdash \mathsf{sub}~{\mathsf{final}^?}~{x^\ast}~{\mathit{comptype}} : {\mathsf{ok}}{(x_0)}
} \, {[\textsc{\scriptsize K{-}sub}]}
\qquad
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathit{deftype}} \prec x, i & = & \mathsf{true} \\
{\mathit{typeidx}} \prec x, i & = & {\mathit{typeidx}} < x \\
\mathsf{rec} {.} j \prec x, i & = & j < i \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{unroll}}}_{C}({\mathit{deftype}}) & = & {\mathrm{unroll}}({\mathit{deftype}}) \\
{{\mathrm{unroll}}}_{C}({\mathit{typeidx}}) & = & {\mathrm{unroll}}(C{.}\mathsf{types}{}[{\mathit{typeidx}}]) \\
{{\mathrm{unroll}}}_{C}(\mathsf{rec} {.} i) & = & C{.}\mathsf{recs}{}[i] \\
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\begin{array}{@{}c@{}}
{|{{\mathit{typeuse}}^\ast}|} \leq 1
 \qquad
({\mathit{typeuse}} \prec x, i)^\ast
 \qquad
({{\mathrm{unroll}}}_{C}({\mathit{typeuse}}) = \mathsf{sub}~{{\mathit{typeuse}'}^\ast}~{\mathit{comptype}'})^\ast
 \\
C \vdash {\mathit{comptype}} : \mathsf{ok}
 \qquad
(C \vdash {\mathit{comptype}} \leq {\mathit{comptype}'})^\ast
\end{array}
}{
C \vdash \mathsf{sub}~{\mathsf{final}^?}~{{\mathit{typeuse}}^\ast}~{\mathit{compttype}} : {\mathsf{ok}}{(x, i)}
} \, {[\textsc{\scriptsize K{-}sub2}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{rec}~\epsilon : {\mathsf{ok}}{(x)}
} \, {[\textsc{\scriptsize K{-}rect{-}empty}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{subtype}}_1 : {\mathsf{ok}}{(x)}
 \qquad
C \vdash \mathsf{rec}~{{\mathit{subtype}}^\ast} : {\mathsf{ok}}{(x + 1)}
}{
C \vdash \mathsf{rec}~({\mathit{subtype}}_1~{{\mathit{subtype}}^\ast}) : {\mathsf{ok}}{(x)}
} \, {[\textsc{\scriptsize K{-}rect{-}cons}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C, \mathsf{recs}~{{\mathit{subtype}}^\ast} \vdash \mathsf{rec}~{{\mathit{subtype}}^\ast} : {\mathsf{ok}}{(x, 0)}
}{
C \vdash \mathsf{rec}~{{\mathit{subtype}}^\ast} : {\mathsf{ok}}{(x)}
} \, {[\textsc{\scriptsize K{-}rect{-}\_rec2}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{rec}~\epsilon : {\mathsf{ok}}{(x, i)}
} \, {[\textsc{\scriptsize K{-}rec2{-}empty}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{subtype}}_1 : {\mathsf{ok}}{(x, i)}
 \qquad
C \vdash \mathsf{rec}~{{\mathit{subtype}}^\ast} : {\mathsf{ok}}{(x + 1, i + 1)}
}{
C \vdash \mathsf{rec}~({\mathit{subtype}}_1~{{\mathit{subtype}}^\ast}) : {\mathsf{ok}}{(x, i)}
} \, {[\textsc{\scriptsize K{-}rec2{-}cons}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{rectype}} : {\mathsf{ok}}{(x)}
 \qquad
{\mathit{rectype}} = \mathsf{rec}~{{\mathit{subtype}}^{n}}
 \qquad
i < n
}{
C \vdash {\mathit{rectype}} {.} i : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}def}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{limits}} : \mathbb{N}}$

$\boxed{{\mathit{context}} \vdash {\mathit{tagtype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{globaltype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{memtype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{tabletype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{externtype}} : \mathsf{ok}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
n \leq k
 \qquad
(n \leq m \leq k)^?
}{
C \vdash {}[ n .. {m^?} ] : k
} \, {[\textsc{\scriptsize K{-}limits}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{typeuse}} : \mathsf{ok}
 \qquad
{\mathit{typeuse}} \approx_{C} \mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast}
}{
C \vdash {\mathit{typeuse}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}tag}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash t : \mathsf{ok}
}{
C \vdash {\mathsf{mut}^?}~t : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{limits}} : {2^{16}}
}{
C \vdash {\mathit{addrtype}}~{\mathit{limits}}~\mathsf{page} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}mem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{limits}} : {2^{32}} - 1
 \qquad
C \vdash {\mathit{reftype}} : \mathsf{ok}
}{
C \vdash {\mathit{addrtype}}~{\mathit{limits}}~{\mathit{reftype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}table}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{tagtype}} : \mathsf{ok}
}{
C \vdash \mathsf{tag}~{\mathit{tagtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}tag}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{globaltype}} : \mathsf{ok}
}{
C \vdash \mathsf{global}~{\mathit{globaltype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{memtype}} : \mathsf{ok}
}{
C \vdash \mathsf{mem}~{\mathit{memtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}mem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{tabletype}} : \mathsf{ok}
}{
C \vdash \mathsf{table}~{\mathit{tabletype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{typeuse}} : \mathsf{ok}
 \qquad
{\mathit{typeuse}} \approx_{C} \mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast}
}{
C \vdash \mathsf{func}~{\mathit{typeuse}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}func}]}
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
C \vdash {\mathit{numtype}} \leq {\mathit{numtype}}
} \, {[\textsc{\scriptsize S{-}num}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{vectype}} \leq {\mathit{vectype}}
} \, {[\textsc{\scriptsize S{-}vec}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{heaptype}} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}refl}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{heaptype}'} : \mathsf{ok}
 \qquad
C \vdash {\mathit{heaptype}}_1 \leq {\mathit{heaptype}'}
 \qquad
C \vdash {\mathit{heaptype}'} \leq {\mathit{heaptype}}_2
}{
C \vdash {\mathit{heaptype}}_1 \leq {\mathit{heaptype}}_2
} \, {[\textsc{\scriptsize S{-}heap{-}trans}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{eq} \leq \mathsf{any}
} \, {[\textsc{\scriptsize S{-}heap{-}eq{-}any}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{i{\scriptstyle 31}} \leq \mathsf{eq}
} \, {[\textsc{\scriptsize S{-}heap{-}i31{-}eq}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{struct} \leq \mathsf{eq}
} \, {[\textsc{\scriptsize S{-}heap{-}struct{-}eq}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{array} \leq \mathsf{eq}
} \, {[\textsc{\scriptsize S{-}heap{-}array{-}eq}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{deftype}} \approx \mathsf{struct}~{{\mathit{fieldtype}}^\ast}
}{
C \vdash {\mathit{deftype}} \leq \mathsf{struct}
} \, {[\textsc{\scriptsize S{-}heap{-}struct}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{deftype}} \approx \mathsf{array}~{\mathit{fieldtype}}
}{
C \vdash {\mathit{deftype}} \leq \mathsf{array}
} \, {[\textsc{\scriptsize S{-}heap{-}array}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{deftype}} \approx \mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast}
}{
C \vdash {\mathit{deftype}} \leq \mathsf{func}
} \, {[\textsc{\scriptsize S{-}heap{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{deftype}}_1 \leq {\mathit{deftype}}_2
}{
C \vdash {\mathit{deftype}}_1 \leq {\mathit{deftype}}_2
} \, {[\textsc{\scriptsize S{-}heap{-}def}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash C{.}\mathsf{types}{}[{\mathit{typeidx}}] \leq {\mathit{heaptype}}
}{
C \vdash {\mathit{typeidx}} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}typeidx{-}l}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{heaptype}} \leq C{.}\mathsf{types}{}[{\mathit{typeidx}}]
}{
C \vdash {\mathit{heaptype}} \leq {\mathit{typeidx}}
} \, {[\textsc{\scriptsize S{-}heap{-}typeidx{-}r}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{recs}{}[i] = \mathsf{sub}~{\mathsf{final}^?}~{{\mathit{typeuse}}^\ast}~{\mathit{ct}}
}{
C \vdash \mathsf{rec} {.} i \leq {{\mathit{typeuse}}^\ast}{}[j]
} \, {[\textsc{\scriptsize S{-}heap{-}rec}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{heaptype}} \leq \mathsf{any}
}{
C \vdash \mathsf{none} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}none}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{heaptype}} \leq \mathsf{func}
}{
C \vdash \mathsf{nofunc} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}nofunc}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{heaptype}} \leq \mathsf{exn}
}{
C \vdash \mathsf{noexn} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}noexn}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{heaptype}} \leq \mathsf{extern}
}{
C \vdash \mathsf{noextern} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}noextern}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{bot} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}bot}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{ht}}_1 \leq {\mathit{ht}}_2
}{
C \vdash \mathsf{ref}~{\mathit{ht}}_1 \leq \mathsf{ref}~{\mathit{ht}}_2
} \, {[\textsc{\scriptsize S{-}ref{-}nonnull}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{ht}}_1 \leq {\mathit{ht}}_2
}{
C \vdash \mathsf{ref}~{\mathsf{null}^?}~{\mathit{ht}}_1 \leq \mathsf{ref}~\mathsf{null}~{\mathit{ht}}_2
} \, {[\textsc{\scriptsize S{-}ref{-}null}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{numtype}}_1 \leq {\mathit{numtype}}_2
}{
C \vdash {\mathit{numtype}}_1 \leq {\mathit{numtype}}_2
} \, {[\textsc{\scriptsize S{-}val{-}num}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{vectype}}_1 \leq {\mathit{vectype}}_2
}{
C \vdash {\mathit{vectype}}_1 \leq {\mathit{vectype}}_2
} \, {[\textsc{\scriptsize S{-}val{-}vec}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{reftype}}_1 \leq {\mathit{reftype}}_2
}{
C \vdash {\mathit{reftype}}_1 \leq {\mathit{reftype}}_2
} \, {[\textsc{\scriptsize S{-}val{-}ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{bot} \leq {\mathit{valtype}}
} \, {[\textsc{\scriptsize S{-}val{-}bot}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{resulttype}} \leq {\mathit{resulttype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{instrtype}} \leq {\mathit{instrtype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
(C \vdash t_1 \leq t_2)^\ast
}{
C \vdash {t_1^\ast} \leq {t_2^\ast}
} \, {[\textsc{\scriptsize S{-}result}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {t_{21}^\ast} \leq {t_{11}^\ast}
 \qquad
C \vdash {t_{12}^\ast} \leq {t_{22}^\ast}
 \qquad
{x^\ast} = {x_2^\ast} \setminus {x_1^\ast}
 \qquad
(C{.}\mathsf{locals}{}[x] = \mathsf{set}~t)^\ast
}{
C \vdash {t_{11}^\ast} \rightarrow_{{x_1^\ast}} {t_{12}^\ast} \leq {t_{21}^\ast} \rightarrow_{{x_2^\ast}} {t_{22}^\ast}
} \, {[\textsc{\scriptsize S{-}instr}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{packtype}} \leq {\mathit{packtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{storagetype}} \leq {\mathit{storagetype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{fieldtype}} \leq {\mathit{fieldtype}}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{packtype}} \leq {\mathit{packtype}}
} \, {[\textsc{\scriptsize S{-}pack}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{valtype}}_1 \leq {\mathit{valtype}}_2
}{
C \vdash {\mathit{valtype}}_1 \leq {\mathit{valtype}}_2
} \, {[\textsc{\scriptsize S{-}storage{-}val}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{packtype}}_1 \leq {\mathit{packtype}}_2
}{
C \vdash {\mathit{packtype}}_1 \leq {\mathit{packtype}}_2
} \, {[\textsc{\scriptsize S{-}storage{-}pack}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{zt}}_1 \leq {\mathit{zt}}_2
}{
C \vdash {\mathit{zt}}_1 \leq {\mathit{zt}}_2
} \, {[\textsc{\scriptsize S{-}field{-}const}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{zt}}_1 \leq {\mathit{zt}}_2
 \qquad
C \vdash {\mathit{zt}}_2 \leq {\mathit{zt}}_1
}{
C \vdash \mathsf{mut}~{\mathit{zt}}_1 \leq \mathsf{mut}~{\mathit{zt}}_2
} \, {[\textsc{\scriptsize S{-}field{-}var}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
(C \vdash {\mathit{ft}}_1 \leq {\mathit{ft}}_2)^\ast
}{
C \vdash \mathsf{struct}~({{\mathit{ft}}_1^\ast}~{{\mathit{ft}'}_1^\ast}) \leq \mathsf{struct}~{{\mathit{ft}}_2^\ast}
} \, {[\textsc{\scriptsize S{-}comp{-}struct}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{ft}}_1 \leq {\mathit{ft}}_2
}{
C \vdash \mathsf{array}~{\mathit{ft}}_1 \leq \mathsf{array}~{\mathit{ft}}_2
} \, {[\textsc{\scriptsize S{-}comp{-}array}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {t_{21}^\ast} \leq {t_{11}^\ast}
 \qquad
C \vdash {t_{12}^\ast} \leq {t_{22}^\ast}
}{
C \vdash \mathsf{func}~{t_{11}^\ast} \rightarrow {t_{12}^\ast} \leq \mathsf{func}~{t_{21}^\ast} \rightarrow {t_{22}^\ast}
} \, {[\textsc{\scriptsize S{-}comp{-}func}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{{\mathrm{clos}}}_{C}({\mathit{deftype}}_1) = {{\mathrm{clos}}}_{C}({\mathit{deftype}}_2)
}{
C \vdash {\mathit{deftype}}_1 \leq {\mathit{deftype}}_2
} \, {[\textsc{\scriptsize S{-}def{-}refl}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathrm{unroll}}({\mathit{deftype}}_1) = \mathsf{sub}~{\mathsf{final}^?}~{{\mathit{typeuse}}^\ast}~{\mathit{ct}}
 \qquad
C \vdash {{\mathit{typeuse}}^\ast}{}[i] \leq {\mathit{deftype}}_2
}{
C \vdash {\mathit{deftype}}_1 \leq {\mathit{deftype}}_2
} \, {[\textsc{\scriptsize S{-}def{-}super}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{limits}} \leq {\mathit{limits}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{tagtype}} \leq {\mathit{tagtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{globaltype}} \leq {\mathit{globaltype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{memtype}} \leq {\mathit{memtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{tabletype}} \leq {\mathit{tabletype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{externtype}} \leq {\mathit{externtype}}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
n_1 \geq n_2
 \qquad
m_1 \leq m_2
}{
C \vdash {}[ n_1 .. m_1 ] \leq {}[ n_2 .. m_2 ]
} \, {[\textsc{\scriptsize S{-}limits}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{deftype}}_1 \leq {\mathit{deftype}}_2
 \qquad
C \vdash {\mathit{deftype}}_2 \leq {\mathit{deftype}}_1
}{
C \vdash {\mathit{deftype}}_1 \leq {\mathit{deftype}}_2
} \, {[\textsc{\scriptsize S{-}tag}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{valtype}}_1 \leq {\mathit{valtype}}_2
}{
C \vdash {\mathit{valtype}}_1 \leq {\mathit{valtype}}_2
} \, {[\textsc{\scriptsize S{-}global{-}const}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{valtype}}_1 \leq {\mathit{valtype}}_2
 \qquad
C \vdash {\mathit{valtype}}_2 \leq {\mathit{valtype}}_1
}{
C \vdash \mathsf{mut}~{\mathit{valtype}}_1 \leq \mathsf{mut}~{\mathit{valtype}}_2
} \, {[\textsc{\scriptsize S{-}global{-}var}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{limits}}_1 \leq {\mathit{limits}}_2
}{
C \vdash {\mathit{addrtype}}~{\mathit{limits}}_1~\mathsf{page} \leq {\mathit{addrtype}}~{\mathit{limits}}_2~\mathsf{page}
} \, {[\textsc{\scriptsize S{-}mem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{limits}}_1 \leq {\mathit{limits}}_2
 \qquad
C \vdash {\mathit{reftype}}_1 \leq {\mathit{reftype}}_2
 \qquad
C \vdash {\mathit{reftype}}_2 \leq {\mathit{reftype}}_1
}{
C \vdash {\mathit{addrtype}}~{\mathit{limits}}_1~{\mathit{reftype}}_1 \leq {\mathit{addrtype}}~{\mathit{limits}}_2~{\mathit{reftype}}_2
} \, {[\textsc{\scriptsize S{-}table}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{tagtype}}_1 \leq {\mathit{tagtype}}_2
}{
C \vdash \mathsf{tag}~{\mathit{tagtype}}_1 \leq \mathsf{tag}~{\mathit{tagtype}}_2
} \, {[\textsc{\scriptsize S{-}extern{-}tag}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{globaltype}}_1 \leq {\mathit{globaltype}}_2
}{
C \vdash \mathsf{global}~{\mathit{globaltype}}_1 \leq \mathsf{global}~{\mathit{globaltype}}_2
} \, {[\textsc{\scriptsize S{-}extern{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{memtype}}_1 \leq {\mathit{memtype}}_2
}{
C \vdash \mathsf{mem}~{\mathit{memtype}}_1 \leq \mathsf{mem}~{\mathit{memtype}}_2
} \, {[\textsc{\scriptsize S{-}extern{-}mem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{tabletype}}_1 \leq {\mathit{tabletype}}_2
}{
C \vdash \mathsf{table}~{\mathit{tabletype}}_1 \leq \mathsf{table}~{\mathit{tabletype}}_2
} \, {[\textsc{\scriptsize S{-}extern{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{deftype}}_1 \leq {\mathit{deftype}}_2
}{
C \vdash \mathsf{func}~{\mathit{deftype}}_1 \leq \mathsf{func}~{\mathit{deftype}}_2
} \, {[\textsc{\scriptsize S{-}extern{-}func}]}
\qquad
\end{array}
$$

$\boxed{{\mathit{context}} \vdash {\mathit{instr}} : {\mathit{instrtype}}}$

$\boxed{{\mathit{context}} \vdash {{\mathit{instr}}^\ast} : {\mathit{instrtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{expr}} : {\mathit{resulttype}}}$

$\boxed{{{\mathrm{default}}}_{{\mathit{valtype}}} \neq \epsilon}$

$\boxed{{{\mathrm{default}}}_{{\mathit{valtype}}} = \epsilon}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{nop} : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}nop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {t_1^\ast} \rightarrow {t_2^\ast} : \mathsf{ok}
}{
C \vdash \mathsf{unreachable} : {t_1^\ast} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}instr{-}unreachable}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash t : \mathsf{ok}
}{
C \vdash \mathsf{drop} : t \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}drop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash t : \mathsf{ok}
}{
C \vdash \mathsf{select}~t : t~t~\mathsf{i{\scriptstyle 32}} \rightarrow t
} \, {[\textsc{\scriptsize T{-}instr{-}select{-}expl}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash t : \mathsf{ok}
 \qquad
C \vdash t \leq {t'}
 \qquad
{t'} = {\mathit{numtype}} \lor {t'} = {\mathit{vectype}}
}{
C \vdash \mathsf{select} : t~t~\mathsf{i{\scriptstyle 32}} \rightarrow t
} \, {[\textsc{\scriptsize T{-}instr{-}select{-}impl}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{blocktype}} : {\mathit{instrtype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
(C \vdash {\mathit{valtype}} : \mathsf{ok})^?
}{
C \vdash {{\mathit{valtype}}^?} : \epsilon \rightarrow {{\mathit{valtype}}^?}
} \, {[\textsc{\scriptsize K{-}block{-}valtype}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[{\mathit{typeidx}}] \approx \mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast}
}{
C \vdash {\mathit{typeidx}} : {t_1^\ast} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize K{-}block{-}typeidx}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{bt}} : {t_1^\ast} \rightarrow {t_2^\ast}
 \qquad
\{ \mathsf{labels}~({t_2^\ast}) \} \oplus C \vdash {{\mathit{instr}}^\ast} : {t_1^\ast} \rightarrow_{{x^\ast}} {t_2^\ast}
}{
C \vdash \mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}^\ast} : {t_1^\ast} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}instr{-}block}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{bt}} : {t_1^\ast} \rightarrow {t_2^\ast}
 \qquad
\{ \mathsf{labels}~({t_1^\ast}) \} \oplus C \vdash {{\mathit{instr}}^\ast} : {t_1^\ast} \rightarrow_{{x^\ast}} {t_2^\ast}
}{
C \vdash \mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast} : {t_1^\ast} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}instr{-}loop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{bt}} : {t_1^\ast} \rightarrow {t_2^\ast}
 \qquad
\{ \mathsf{labels}~({t_2^\ast}) \} \oplus C \vdash {{\mathit{instr}}_1^\ast} : {t_1^\ast} \rightarrow_{{x_1^\ast}} {t_2^\ast}
 \qquad
\{ \mathsf{labels}~({t_2^\ast}) \} \oplus C \vdash {{\mathit{instr}}_2^\ast} : {t_1^\ast} \rightarrow_{{x_2^\ast}} {t_2^\ast}
}{
C \vdash \mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_1^\ast}~\mathsf{else}~{{\mathit{instr}}_2^\ast} : {t_1^\ast}~\mathsf{i{\scriptstyle 32}} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}instr{-}if}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{labels}{}[l] = {t^\ast}
 \qquad
C \vdash {t_1^\ast} \rightarrow {t_2^\ast} : \mathsf{ok}
}{
C \vdash \mathsf{br}~l : {t_1^\ast}~{t^\ast} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}instr{-}br}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{labels}{}[l] = {t^\ast}
}{
C \vdash \mathsf{br\_if}~l : {t^\ast}~\mathsf{i{\scriptstyle 32}} \rightarrow {t^\ast}
} \, {[\textsc{\scriptsize T{-}instr{-}br\_if}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
(C \vdash {t^\ast} \leq C{.}\mathsf{labels}{}[l])^\ast
 \qquad
C \vdash {t^\ast} \leq C{.}\mathsf{labels}{}[{l'}]
 \qquad
C \vdash {t_1^\ast}~{t^\ast}~\mathsf{i{\scriptstyle 32}} \rightarrow {t_2^\ast} : \mathsf{ok}
}{
C \vdash \mathsf{br\_table}~{l^\ast}~{l'} : {t_1^\ast}~{t^\ast}~\mathsf{i{\scriptstyle 32}} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}instr{-}br\_table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{labels}{}[l] = {t^\ast}
 \qquad
C \vdash {\mathit{ht}} : \mathsf{ok}
}{
C \vdash \mathsf{br\_on\_null}~l : {t^\ast}~(\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \rightarrow {t^\ast}~(\mathsf{ref}~{\mathit{ht}})
} \, {[\textsc{\scriptsize T{-}instr{-}br\_on\_null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{labels}{}[l] = {t^\ast}~(\mathsf{ref}~{\mathsf{null}^?}~{\mathit{ht}})
}{
C \vdash \mathsf{br\_on\_non\_null}~l : {t^\ast}~(\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \rightarrow {t^\ast}
} \, {[\textsc{\scriptsize T{-}instr{-}br\_on\_non\_null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{labels}{}[l] = {t^\ast}~{\mathit{rt}}
 \qquad
C \vdash {\mathit{rt}}_1 : \mathsf{ok}
 \qquad
C \vdash {\mathit{rt}}_2 : \mathsf{ok}
 \qquad
C \vdash {\mathit{rt}}_2 \leq {\mathit{rt}}_1
 \qquad
C \vdash {\mathit{rt}}_2 \leq {\mathit{rt}}
}{
C \vdash \mathsf{br\_on\_cast}~l~{\mathit{rt}}_1~{\mathit{rt}}_2 : {t^\ast}~{\mathit{rt}}_1 \rightarrow {t^\ast}~({\mathit{rt}}_1 \setminus {\mathit{rt}}_2)
} \, {[\textsc{\scriptsize T{-}instr{-}br\_on\_cast}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{labels}{}[l] = {t^\ast}~{\mathit{rt}}
 \qquad
C \vdash {\mathit{rt}}_1 : \mathsf{ok}
 \qquad
C \vdash {\mathit{rt}}_2 : \mathsf{ok}
 \qquad
C \vdash {\mathit{rt}}_2 \leq {\mathit{rt}}_1
 \qquad
C \vdash {\mathit{rt}}_1 \setminus {\mathit{rt}}_2 \leq {\mathit{rt}}
}{
C \vdash \mathsf{br\_on\_cast\_fail}~l~{\mathit{rt}}_1~{\mathit{rt}}_2 : {t^\ast}~{\mathit{rt}}_1 \rightarrow {t^\ast}~{\mathit{rt}}_2
} \, {[\textsc{\scriptsize T{-}instr{-}br\_on\_cast\_fail}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{funcs}{}[x] \approx \mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast}
}{
C \vdash \mathsf{call}~x : {t_1^\ast} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}instr{-}call}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast}
}{
C \vdash \mathsf{call\_ref}~x : {t_1^\ast}~(\mathsf{ref}~\mathsf{null}~x) \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}instr{-}call\_ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tables}{}[x] = {\mathit{at}}~{\mathit{lim}}~{\mathit{rt}}
 \qquad
C \vdash {\mathit{rt}} \leq (\mathsf{ref}~\mathsf{null}~\mathsf{func})
 \qquad
C{.}\mathsf{types}{}[y] \approx \mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast}
}{
C \vdash \mathsf{call\_indirect}~x~y : {t_1^\ast}~{\mathit{at}} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}instr{-}call\_indirect}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{return} = ({t^\ast})
 \qquad
C \vdash {t_1^\ast} \rightarrow {t_2^\ast} : \mathsf{ok}
}{
C \vdash \mathsf{return} : {t_1^\ast}~{t^\ast} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}instr{-}return}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{funcs}{}[x] \approx \mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast}
 \qquad
C{.}\mathsf{return} = ({{t'}_2^\ast})
 \qquad
C \vdash {t_2^\ast} \leq {{t'}_2^\ast}
 \qquad
C \vdash {t_3^\ast} \rightarrow {t_4^\ast} : \mathsf{ok}
}{
C \vdash \mathsf{return\_call}~x : {t_3^\ast}~{t_1^\ast} \rightarrow {t_4^\ast}
} \, {[\textsc{\scriptsize T{-}instr{-}return\_call}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast}
 \qquad
C{.}\mathsf{return} = ({{t'}_2^\ast})
 \qquad
C \vdash {t_2^\ast} \leq {{t'}_2^\ast}
 \qquad
C \vdash {t_3^\ast} \rightarrow {t_4^\ast} : \mathsf{ok}
}{
C \vdash \mathsf{return\_call\_ref}~x : {t_3^\ast}~{t_1^\ast}~(\mathsf{ref}~\mathsf{null}~x) \rightarrow {t_4^\ast}
} \, {[\textsc{\scriptsize T{-}instr{-}return\_call\_ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\begin{array}{@{}c@{}}
C{.}\mathsf{tables}{}[x] = {\mathit{at}}~{\mathit{lim}}~{\mathit{rt}}
 \qquad
C \vdash {\mathit{rt}} \leq (\mathsf{ref}~\mathsf{null}~\mathsf{func})
 \\
C{.}\mathsf{types}{}[y] \approx \mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast}
 \qquad
C{.}\mathsf{return} = ({{t'}_2^\ast})
 \qquad
C \vdash {t_2^\ast} \leq {{t'}_2^\ast}
 \qquad
C \vdash {t_3^\ast} \rightarrow {t_4^\ast} : \mathsf{ok}
\end{array}
}{
C \vdash \mathsf{return\_call\_indirect}~x~y : {t_3^\ast}~{t_1^\ast}~{\mathit{at}} \rightarrow {t_4^\ast}
} \, {[\textsc{\scriptsize T{-}instr{-}return\_call\_indirect}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{catch}} : \mathsf{ok}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tags}{}[x] \approx \mathsf{func}~{t^\ast} \rightarrow \epsilon
 \qquad
C \vdash {t_1^\ast} \rightarrow {t_2^\ast} : \mathsf{ok}
}{
C \vdash \mathsf{throw}~x : {t_1^\ast}~{t^\ast} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}instr{-}throw}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {t_1^\ast} \rightarrow {t_2^\ast} : \mathsf{ok}
}{
C \vdash \mathsf{throw\_ref} : {t_1^\ast}~(\mathsf{ref}~\mathsf{null}~\mathsf{exn}) \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}instr{-}throw\_ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{bt}} : {t_1^\ast} \rightarrow {t_2^\ast}
 \qquad
\{ \mathsf{labels}~({t_2^\ast}) \} \oplus C \vdash {{\mathit{instr}}^\ast} : {t_1^\ast} \rightarrow_{{x^\ast}} {t_2^\ast}
 \qquad
(C \vdash {\mathit{catch}} : \mathsf{ok})^\ast
}{
C \vdash \mathsf{try\_table}~{\mathit{bt}}~{{\mathit{catch}}^\ast}~{{\mathit{instr}}^\ast} : {t_1^\ast} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}instr{-}try\_table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tags}{}[x] \approx \mathsf{func}~{t^\ast} \rightarrow \epsilon
 \qquad
C \vdash {t^\ast} \leq C{.}\mathsf{labels}{}[l]
}{
C \vdash \mathsf{catch}~x~l : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}catch}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tags}{}[x] \approx \mathsf{func}~{t^\ast} \rightarrow \epsilon
 \qquad
C \vdash {t^\ast}~(\mathsf{ref}~\mathsf{exn}) \leq C{.}\mathsf{labels}{}[l]
}{
C \vdash \mathsf{catch\_ref}~x~l : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}catch\_ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash \epsilon \leq C{.}\mathsf{labels}{}[l]
}{
C \vdash \mathsf{catch\_all}~l : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}catch\_all}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash (\mathsf{ref}~\mathsf{exn}) \leq C{.}\mathsf{labels}{}[l]
}{
C \vdash \mathsf{catch\_all\_ref}~l : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}catch\_all\_ref}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{ht}} : \mathsf{ok}
}{
C \vdash \mathsf{ref{.}null}~{\mathit{ht}} : \epsilon \rightarrow (\mathsf{ref}~\mathsf{null}~{\mathit{ht}})
} \, {[\textsc{\scriptsize T{-}instr{-}ref.null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{funcs}{}[x] = {\mathit{dt}}
 \qquad
x \in C{.}\mathsf{refs}
}{
C \vdash \mathsf{ref{.}func}~x : \epsilon \rightarrow (\mathsf{ref}~{\mathit{dt}})
} \, {[\textsc{\scriptsize T{-}instr{-}ref.func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{ref{.}i{\scriptstyle 31}} : \mathsf{i{\scriptstyle 32}} \rightarrow (\mathsf{ref}~\mathsf{i{\scriptstyle 31}})
} \, {[\textsc{\scriptsize T{-}instr{-}ref.i31}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{ht}} : \mathsf{ok}
}{
C \vdash \mathsf{ref{.}is\_null} : (\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}instr{-}ref.is\_null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{ht}} : \mathsf{ok}
}{
C \vdash \mathsf{ref{.}as\_non\_null} : (\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \rightarrow (\mathsf{ref}~{\mathit{ht}})
} \, {[\textsc{\scriptsize T{-}instr{-}ref.as\_non\_null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{ref{.}eq} : (\mathsf{ref}~\mathsf{null}~\mathsf{eq})~(\mathsf{ref}~\mathsf{null}~\mathsf{eq}) \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}instr{-}ref.eq}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{rt}} : \mathsf{ok}
 \qquad
C \vdash {\mathit{rt}'} : \mathsf{ok}
 \qquad
C \vdash {\mathit{rt}} \leq {\mathit{rt}'}
}{
C \vdash \mathsf{ref{.}test}~{\mathit{rt}} : {\mathit{rt}'} \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}instr{-}ref.test}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{rt}} : \mathsf{ok}
 \qquad
C \vdash {\mathit{rt}'} : \mathsf{ok}
 \qquad
C \vdash {\mathit{rt}} \leq {\mathit{rt}'}
}{
C \vdash \mathsf{ref{.}cast}~{\mathit{rt}} : {\mathit{rt}'} \rightarrow {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}instr{-}ref.cast}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathsf{i{\scriptstyle 31}{.}get}}{\mathsf{\_}}{{\mathit{sx}}} : (\mathsf{ref}~\mathsf{null}~\mathsf{i{\scriptstyle 31}}) \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}instr{-}i31.get}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{struct}~{({\mathsf{mut}^?}~{\mathit{zt}})^\ast}
}{
C \vdash \mathsf{struct{.}new}~x : {{\mathrm{unpack}}({\mathit{zt}})^\ast} \rightarrow (\mathsf{ref}~x)
} \, {[\textsc{\scriptsize T{-}instr{-}struct.new}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{struct}~{({\mathsf{mut}^?}~{\mathit{zt}})^\ast}
 \qquad
({{\mathrm{default}}}_{{\mathrm{unpack}}({\mathit{zt}})} \neq \epsilon)^\ast
}{
C \vdash \mathsf{struct{.}new\_default}~x : \epsilon \rightarrow (\mathsf{ref}~x)
} \, {[\textsc{\scriptsize T{-}instr{-}struct.new\_default}]}
\qquad
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathit{zt}} = {\mathrm{unpack}}({\mathit{zt}}) & = & {\mathit{zt}} = {\mathrm{unpack}}({\mathit{zt}}) \\
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{struct}~{{\mathit{ft}}^\ast}
 \qquad
{{\mathit{ft}}^\ast}{}[i] = {\mathsf{mut}^?}~{\mathit{zt}}
 \qquad
{{\mathit{sx}}^?} = \epsilon \Leftrightarrow {\mathit{zt}} = {\mathrm{unpack}}({\mathit{zt}})
}{
C \vdash {\mathsf{struct{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~x~i : (\mathsf{ref}~\mathsf{null}~x) \rightarrow {\mathrm{unpack}}({\mathit{zt}})
} \, {[\textsc{\scriptsize T{-}instr{-}struct.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{struct}~{{\mathit{ft}}^\ast}
 \qquad
{{\mathit{ft}}^\ast}{}[i] = \mathsf{mut}~{\mathit{zt}}
}{
C \vdash \mathsf{struct{.}set}~x~i : (\mathsf{ref}~\mathsf{null}~x)~{\mathrm{unpack}}({\mathit{zt}}) \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}struct.set}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}})
}{
C \vdash \mathsf{array{.}new}~x : {\mathrm{unpack}}({\mathit{zt}})~\mathsf{i{\scriptstyle 32}} \rightarrow (\mathsf{ref}~x)
} \, {[\textsc{\scriptsize T{-}instr{-}array.new}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}})
 \qquad
{{\mathrm{default}}}_{{\mathrm{unpack}}({\mathit{zt}})} \neq \epsilon
}{
C \vdash \mathsf{array{.}new\_default}~x : \mathsf{i{\scriptstyle 32}} \rightarrow (\mathsf{ref}~x)
} \, {[\textsc{\scriptsize T{-}instr{-}array.new\_default}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}})
}{
C \vdash \mathsf{array{.}new\_fixed}~x~n : {{\mathrm{unpack}}({\mathit{zt}})^{n}} \rightarrow (\mathsf{ref}~x)
} \, {[\textsc{\scriptsize T{-}instr{-}array.new\_fixed}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{rt}})
 \qquad
C \vdash C{.}\mathsf{elems}{}[y] \leq {\mathit{rt}}
}{
C \vdash \mathsf{array{.}new\_elem}~x~y : \mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}} \rightarrow (\mathsf{ref}~x)
} \, {[\textsc{\scriptsize T{-}instr{-}array.new\_elem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}})
 \qquad
{\mathrm{unpack}}({\mathit{zt}}) = {\mathit{numtype}} \lor {\mathrm{unpack}}({\mathit{zt}}) = {\mathit{vectype}}
 \qquad
C{.}\mathsf{datas}{}[y] = \mathsf{ok}
}{
C \vdash \mathsf{array{.}new\_data}~x~y : \mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}} \rightarrow (\mathsf{ref}~x)
} \, {[\textsc{\scriptsize T{-}instr{-}array.new\_data}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}})
 \qquad
{{\mathit{sx}}^?} = \epsilon \Leftrightarrow {\mathit{zt}} = {\mathrm{unpack}}({\mathit{zt}})
}{
C \vdash {\mathsf{array{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~x : (\mathsf{ref}~\mathsf{null}~x)~\mathsf{i{\scriptstyle 32}} \rightarrow {\mathrm{unpack}}({\mathit{zt}})
} \, {[\textsc{\scriptsize T{-}instr{-}array.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
}{
C \vdash \mathsf{array{.}set}~x : (\mathsf{ref}~\mathsf{null}~x)~\mathsf{i{\scriptstyle 32}}~{\mathrm{unpack}}({\mathit{zt}}) \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}array.set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{array{.}len} : (\mathsf{ref}~\mathsf{null}~\mathsf{array}) \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}instr{-}array.len}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
}{
C \vdash \mathsf{array{.}fill}~x : (\mathsf{ref}~\mathsf{null}~x)~\mathsf{i{\scriptstyle 32}}~{\mathrm{unpack}}({\mathit{zt}})~\mathsf{i{\scriptstyle 32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}array.fill}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x_1] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}}_1)
 \qquad
C{.}\mathsf{types}{}[x_2] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}}_2)
 \qquad
C \vdash {\mathit{zt}}_2 \leq {\mathit{zt}}_1
}{
C \vdash \mathsf{array{.}copy}~x_1~x_2 : (\mathsf{ref}~\mathsf{null}~x_1)~\mathsf{i{\scriptstyle 32}}~(\mathsf{ref}~\mathsf{null}~x_2)~\mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}array.copy}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
 \qquad
C \vdash C{.}\mathsf{elems}{}[y] \leq {\mathit{zt}}
}{
C \vdash \mathsf{array{.}init\_elem}~x~y : (\mathsf{ref}~\mathsf{null}~x)~\mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}array.init\_elem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
 \qquad
{\mathrm{unpack}}({\mathit{zt}}) = {\mathit{numtype}} \lor {\mathrm{unpack}}({\mathit{zt}}) = {\mathit{vectype}}
 \qquad
C{.}\mathsf{datas}{}[y] = \mathsf{ok}
}{
C \vdash \mathsf{array{.}init\_data}~x~y : (\mathsf{ref}~\mathsf{null}~x)~\mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}array.init\_data}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{{\mathsf{null}}_1^?} = {{\mathsf{null}}_2^?}
}{
C \vdash \mathsf{extern{.}convert\_any} : (\mathsf{ref}~{{\mathsf{null}}_1^?}~\mathsf{any}) \rightarrow (\mathsf{ref}~{{\mathsf{null}}_2^?}~\mathsf{extern})
} \, {[\textsc{\scriptsize T{-}instr{-}extern.convert\_any}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{{\mathsf{null}}_1^?} = {{\mathsf{null}}_2^?}
}{
C \vdash \mathsf{any{.}convert\_extern} : (\mathsf{ref}~{{\mathsf{null}}_1^?}~\mathsf{extern}) \rightarrow (\mathsf{ref}~{{\mathsf{null}}_2^?}~\mathsf{any})
} \, {[\textsc{\scriptsize T{-}instr{-}any.convert\_extern}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{locals}{}[x] = \mathsf{set}~t
}{
C \vdash \mathsf{local{.}get}~x : \epsilon \rightarrow t
} \, {[\textsc{\scriptsize T{-}instr{-}local.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{locals}{}[x] = {\mathit{init}}~t
}{
C \vdash \mathsf{local{.}set}~x : t \rightarrow_{x} \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}local.set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{locals}{}[x] = {\mathit{init}}~t
}{
C \vdash \mathsf{local{.}tee}~x : t \rightarrow_{x} t
} \, {[\textsc{\scriptsize T{-}instr{-}local.tee}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{globals}{}[x] = {\mathsf{mut}^?}~t
}{
C \vdash \mathsf{global{.}get}~x : \epsilon \rightarrow t
} \, {[\textsc{\scriptsize T{-}instr{-}global.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{globals}{}[x] = \mathsf{mut}~t
}{
C \vdash \mathsf{global{.}set}~x : t \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}global.set}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tables}{}[x] = {\mathit{at}}~{\mathit{lim}}~{\mathit{rt}}
}{
C \vdash \mathsf{table{.}get}~x : {\mathit{at}} \rightarrow {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}instr{-}table.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tables}{}[x] = {\mathit{at}}~{\mathit{lim}}~{\mathit{rt}}
}{
C \vdash \mathsf{table{.}set}~x : {\mathit{at}}~{\mathit{rt}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}table.set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tables}{}[x] = {\mathit{at}}~{\mathit{lim}}~{\mathit{rt}}
}{
C \vdash \mathsf{table{.}size}~x : \epsilon \rightarrow {\mathit{at}}
} \, {[\textsc{\scriptsize T{-}instr{-}table.size}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tables}{}[x] = {\mathit{at}}~{\mathit{lim}}~{\mathit{rt}}
}{
C \vdash \mathsf{table{.}grow}~x : {\mathit{rt}}~{\mathit{at}} \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}instr{-}table.grow}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tables}{}[x] = {\mathit{at}}~{\mathit{lim}}~{\mathit{rt}}
}{
C \vdash \mathsf{table{.}fill}~x : {\mathit{at}}~{\mathit{rt}}~{\mathit{at}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}table.fill}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tables}{}[x_1] = {\mathit{at}}_1~{\mathit{lim}}_1~{\mathit{rt}}_1
 \qquad
C{.}\mathsf{tables}{}[x_2] = {\mathit{at}}_2~{\mathit{lim}}_2~{\mathit{rt}}_2
 \qquad
C \vdash {\mathit{rt}}_2 \leq {\mathit{rt}}_1
}{
C \vdash \mathsf{table{.}copy}~x_1~x_2 : {\mathit{at}}_1~{\mathit{at}}_2~{\mathrm{min}}({\mathit{at}}_1, {\mathit{at}}_2) \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}table.copy}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tables}{}[x] = {\mathit{at}}~{\mathit{lim}}~{\mathit{rt}}_1
 \qquad
C{.}\mathsf{elems}{}[y] = {\mathit{rt}}_2
 \qquad
C \vdash {\mathit{rt}}_2 \leq {\mathit{rt}}_1
}{
C \vdash \mathsf{table{.}init}~x~y : {\mathit{at}}~\mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}table.init}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{elems}{}[x] = {\mathit{rt}}
}{
C \vdash \mathsf{elem{.}drop}~x : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}elem.drop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\vdash}\, {\mathit{memarg}} : {\mathit{addrtype}} \rightarrow N}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{2^{n}} \leq N / 8
 \qquad
m < {2^{{|{\mathit{at}}|}}}
}{
{\vdash}\, \{ \mathsf{align}~n,\;\allowbreak \mathsf{offset}~m \} : {\mathit{at}} \rightarrow N
} \, {[\textsc{\scriptsize T{-}memarg}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{at}}~{\mathit{lim}}~\mathsf{page}
}{
C \vdash \mathsf{memory{.}size}~x : \epsilon \rightarrow {\mathit{at}}
} \, {[\textsc{\scriptsize T{-}instr{-}memory.size}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{at}}~{\mathit{lim}}~\mathsf{page}
}{
C \vdash \mathsf{memory{.}grow}~x : {\mathit{at}} \rightarrow {\mathit{at}}
} \, {[\textsc{\scriptsize T{-}instr{-}memory.grow}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{at}}~{\mathit{lim}}~\mathsf{page}
}{
C \vdash \mathsf{memory{.}fill}~x : {\mathit{at}}~\mathsf{i{\scriptstyle 32}}~{\mathit{at}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}memory.fill}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x_1] = {\mathit{at}}_1~{\mathit{lim}}_1~\mathsf{page}
 \qquad
C{.}\mathsf{mems}{}[x_2] = {\mathit{at}}_2~{\mathit{lim}}_2~\mathsf{page}
}{
C \vdash \mathsf{memory{.}copy}~x_1~x_2 : {\mathit{at}}_1~{\mathit{at}}_2~{\mathrm{min}}({\mathit{at}}_1, {\mathit{at}}_2) \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}memory.copy}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{at}}~{\mathit{lim}}~\mathsf{page}
 \qquad
C{.}\mathsf{datas}{}[y] = \mathsf{ok}
}{
C \vdash \mathsf{memory{.}init}~x~y : {\mathit{at}}~\mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}memory.init}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{datas}{}[x] = \mathsf{ok}
}{
C \vdash \mathsf{data{.}drop}~x : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}data.drop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{at}}~{\mathit{lim}}~\mathsf{page}
 \qquad
{\vdash}\, {\mathit{memarg}} : {\mathit{at}} \rightarrow {|{\mathit{nt}}|}
}{
C \vdash {\mathit{nt}}{.}\mathsf{load}~x~{\mathit{memarg}} : {\mathit{at}} \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}instr{-}load{-}val}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{at}}~{\mathit{lim}}~\mathsf{page}
 \qquad
{\vdash}\, {\mathit{memarg}} : {\mathit{at}} \rightarrow M
}{
C \vdash {{\mathsf{i}}{N}{.}\mathsf{load}}{{M}{\mathsf{\_}}{{\mathit{sx}}}}~x~{\mathit{memarg}} : {\mathit{at}} \rightarrow {\mathsf{i}}{N}
} \, {[\textsc{\scriptsize T{-}instr{-}load{-}pack}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{at}}~{\mathit{lim}}~\mathsf{page}
 \qquad
{\vdash}\, {\mathit{memarg}} : {\mathit{at}} \rightarrow {|{\mathit{nt}}|}
}{
C \vdash {\mathit{nt}}{.}\mathsf{store}~x~{\mathit{memarg}} : {\mathit{at}}~{\mathit{nt}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}store{-}val}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{at}}~{\mathit{lim}}~\mathsf{page}
 \qquad
{\vdash}\, {\mathit{memarg}} : {\mathit{at}} \rightarrow M
}{
C \vdash {{\mathsf{i}}{N}{.}\mathsf{store}}{M}~x~{\mathit{memarg}} : {\mathit{at}}~{\mathsf{i}}{N} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}store{-}pack}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{at}}~{\mathit{lim}}~\mathsf{page}
 \qquad
{\vdash}\, {\mathit{memarg}} : {\mathit{at}} \rightarrow {|\mathsf{v{\scriptstyle 128}}|}
}{
C \vdash \mathsf{v{\scriptstyle 128}}{.}\mathsf{load}~x~{\mathit{memarg}} : {\mathit{at}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vload{-}val}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{at}}~{\mathit{lim}}~\mathsf{page}
 \qquad
{\vdash}\, {\mathit{memarg}} : {\mathit{at}} \rightarrow M \cdot N
}{
C \vdash {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{M}{\mathsf{x}}{N}{\mathsf{\_}}{{\mathit{sx}}}}~x~{\mathit{memarg}} : {\mathit{at}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vload{-}pack}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{at}}~{\mathit{lim}}~\mathsf{page}
 \qquad
{\vdash}\, {\mathit{memarg}} : {\mathit{at}} \rightarrow N
}{
C \vdash {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{N}{\mathsf{\_}}{\mathsf{splat}}}~x~{\mathit{memarg}} : {\mathit{at}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vload{-}splat}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{at}}~{\mathit{lim}}~\mathsf{page}
 \qquad
{\vdash}\, {\mathit{memarg}} : {\mathit{at}} \rightarrow N
}{
C \vdash {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{N}{\mathsf{\_}}{\mathsf{zero}}}~x~{\mathit{memarg}} : {\mathit{at}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vload{-}zero}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{at}}~{\mathit{lim}}~\mathsf{page}
 \qquad
{\vdash}\, {\mathit{memarg}} : {\mathit{at}} \rightarrow N
 \qquad
i < 128 / N
}{
C \vdash {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{N}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{memarg}}~i : {\mathit{at}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vload\_lane}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{at}}~{\mathit{lim}}~\mathsf{page}
 \qquad
{\vdash}\, {\mathit{memarg}} : {\mathit{at}} \rightarrow {|\mathsf{v{\scriptstyle 128}}|}
}{
C \vdash \mathsf{v{\scriptstyle 128}}{.}\mathsf{store}~x~{\mathit{memarg}} : {\mathit{at}}~\mathsf{v{\scriptstyle 128}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}vstore}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{at}}~{\mathit{lim}}~\mathsf{page}
 \qquad
{\vdash}\, {\mathit{memarg}} : {\mathit{at}} \rightarrow N
 \qquad
i < 128 / N
}{
C \vdash {\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}}{N}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{memarg}}~i : {\mathit{at}}~\mathsf{v{\scriptstyle 128}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr{-}vstore\_lane}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{nt}}{.}\mathsf{const}~c_{\mathit{nt}} : \epsilon \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}instr{-}const}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{nt}} {.} {\mathit{unop}}_{\mathit{nt}} : {\mathit{nt}} \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}instr{-}unop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{nt}} {.} {\mathit{binop}}_{\mathit{nt}} : {\mathit{nt}}~{\mathit{nt}} \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}instr{-}binop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{nt}} {.} {\mathit{testop}}_{\mathit{nt}} : {\mathit{nt}} \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}instr{-}testop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{nt}} {.} {\mathit{relop}}_{\mathit{nt}} : {\mathit{nt}}~{\mathit{nt}} \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}instr{-}relop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{nt}}_1 {.} {{\mathit{cvtop}}}{\mathsf{\_}}{{\mathit{nt}}_2} : {\mathit{nt}}_2 \rightarrow {\mathit{nt}}_1
} \, {[\textsc{\scriptsize T{-}instr{-}cvtop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c : \epsilon \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vconst}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{v{\scriptstyle 128}} {.} {\mathit{vvunop}} : \mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vvunop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{v{\scriptstyle 128}} {.} {\mathit{vvbinop}} : \mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vvbinop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{v{\scriptstyle 128}} {.} {\mathit{vvternop}} : \mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vvternop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{v{\scriptstyle 128}} {.} {\mathit{vvtestop}} : \mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}instr{-}vvtestop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}} {.} {\mathit{vunop}} : \mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vunop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}} {.} {\mathit{vbinop}} : \mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vbinop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}} {.} {\mathit{vternop}} : \mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vternop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}} {.} {\mathit{vtestop}} : \mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}instr{-}vtestop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}} {.} {\mathit{vrelop}} : \mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vrelop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}} {.} {\mathit{vshiftop}} : \mathsf{v{\scriptstyle 128}}~\mathsf{i{\scriptstyle 32}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vshiftop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}}{.}\mathsf{bitmask} : \mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}instr{-}vbitmask}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}} {.} {\mathit{vswizzlop}} : \mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vswizzlop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
(i < 2 \cdot {\mathrm{dim}}({\mathit{sh}}))^\ast
}{
C \vdash {\mathit{sh}}{.}\mathsf{shuffle}~{i^\ast} : \mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vshuffle}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}}{.}\mathsf{splat} : {\mathrm{unpack}}({\mathit{sh}}) \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vsplat}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
i < {\mathrm{dim}}({\mathit{sh}})
}{
C \vdash {{\mathit{sh}}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~i : \mathsf{v{\scriptstyle 128}} \rightarrow {\mathrm{unpack}}({\mathit{sh}})
} \, {[\textsc{\scriptsize T{-}instr{-}vextract\_lane}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
i < {\mathrm{dim}}({\mathit{sh}})
}{
C \vdash {\mathit{sh}}{.}\mathsf{replace\_lane}~i : \mathsf{v{\scriptstyle 128}}~{\mathrm{unpack}}({\mathit{sh}}) \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vreplace\_lane}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}}_1 {.} {{\mathit{vextunop}}}{\mathsf{\_}}{{\mathit{sh}}_2} : \mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vextunop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}}_1 {.} {{\mathit{vextbinop}}}{\mathsf{\_}}{{\mathit{sh}}_2} : \mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vextbinop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}}_1 {.} {{\mathit{vextternop}}}{\mathsf{\_}}{{\mathit{sh}}_2} : \mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vextternop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {{\mathit{sh}}_1{.}\mathsf{narrow}}{\mathsf{\_}}{{\mathit{sh}}_2}{\mathsf{\_}}{{\mathit{sx}}} : \mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vnarrow}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}}_1 {.} {{\mathit{vcvtop}}}{\mathsf{\_}}{{\mathit{sh}}_2} : \mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}instr{-}vcvtop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \epsilon : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}instr*{-}empty}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{instr}}_1 : {t_1^\ast} \rightarrow_{{x_1^\ast}} {t_2^\ast}
 \qquad
(C{.}\mathsf{locals}{}[x_1] = {\mathit{init}}~t)^\ast
 \qquad
C{}[{.}\mathsf{local}{}[{x_1^\ast}] = {(\mathsf{set}~t)^\ast}] \vdash {{\mathit{instr}}_2^\ast} : {t_2^\ast} \rightarrow_{{x_2^\ast}} {t_3^\ast}
}{
C \vdash {\mathit{instr}}_1~{{\mathit{instr}}_2^\ast} : {t_1^\ast} \rightarrow_{{x_1^\ast}~{x_2^\ast}} {t_3^\ast}
} \, {[\textsc{\scriptsize T{-}instr*{-}seq}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {{\mathit{instr}}^\ast} : {\mathit{it}}
 \qquad
C \vdash {\mathit{it}} \leq {\mathit{it}'}
 \qquad
C \vdash {\mathit{it}'} : \mathsf{ok}
}{
C \vdash {{\mathit{instr}}^\ast} : {\mathit{it}'}
} \, {[\textsc{\scriptsize T{-}instr*{-}sub}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
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

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {{\mathit{instr}}^\ast} : \epsilon \rightarrow_{\epsilon} {t^\ast}
}{
C \vdash {{\mathit{instr}}^\ast} : {t^\ast}
} \, {[\textsc{\scriptsize T{-}expr}]}
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
C \vdash ({\mathit{nt}}{.}\mathsf{const}~c_{\mathit{nt}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}const}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash ({\mathit{vt}}{.}\mathsf{const}~c_{\mathit{vt}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}vconst}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash (\mathsf{ref{.}null}~{\mathit{ht}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}ref.null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash (\mathsf{ref{.}i{\scriptstyle 31}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}ref.i31}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash (\mathsf{ref{.}func}~x)~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}ref.func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash (\mathsf{struct{.}new}~x)~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}struct.new}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash (\mathsf{struct{.}new\_default}~x)~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}struct.new\_default}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash (\mathsf{array{.}new}~x)~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}array.new}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash (\mathsf{array{.}new\_default}~x)~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}array.new\_default}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash (\mathsf{array{.}new\_fixed}~x~n)~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}array.new\_fixed}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash (\mathsf{any{.}convert\_extern})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}any.convert\_extern}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash (\mathsf{extern{.}convert\_any})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}extern.convert\_any}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{globals}{}[x] = t
}{
C \vdash (\mathsf{global{.}get}~x)~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}global.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathsf{i}}{N} \in \mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 64}}
 \qquad
{\mathit{binop}} \in \mathsf{add}~\mathsf{sub}~\mathsf{mul}
}{
C \vdash ({\mathsf{i}}{N} {.} {\mathit{binop}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}binop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
(C \vdash {\mathit{instr}}~\mathsf{const})^\ast
}{
C \vdash {{\mathit{instr}}^\ast}~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}expr}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{expr}} : t
 \qquad
C \vdash {\mathit{expr}}~\mathsf{const}
}{
C \vdash {\mathit{expr}} : t~\mathsf{const}
} \, {[\textsc{\scriptsize TC{-}expr}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{type}} : {{\mathit{deftype}}^\ast}}$

$\boxed{{\mathit{context}} \vdash {\mathit{tag}} : {\mathit{tagtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{global}} : {\mathit{globaltype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{mem}} : {\mathit{memtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{table}} : {\mathit{tabletype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{func}} : {\mathit{deftype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{data}} : {\mathit{datatype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{elem}} : {\mathit{elemtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{datamode}} : {\mathit{datatype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{elemmode}} : {\mathit{elemtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{start}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{local}} : {\mathit{localtype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
x = {|C{.}\mathsf{types}|}
 \qquad
{{\mathit{dt}}^\ast} = {{{{\mathrm{roll}}}_{x}^\ast}}{({\mathit{rectype}})}
 \qquad
C \oplus \{ \mathsf{types}~{{\mathit{dt}}^\ast} \} \vdash {\mathit{rectype}} : {\mathsf{ok}}{(x)}
}{
C \vdash \mathsf{type}~{\mathit{rectype}} : {{\mathit{dt}}^\ast}
} \, {[\textsc{\scriptsize T{-}type}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{tagtype}} : \mathsf{ok}
}{
C \vdash \mathsf{tag}~{\mathit{tagtype}} : {{\mathrm{clos}}}_{C}({\mathit{tagtype}})
} \, {[\textsc{\scriptsize T{-}tag}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{globaltype}} : \mathsf{ok}
 \qquad
{\mathit{globaltype}} = {\mathsf{mut}^?}~t
 \qquad
C \vdash {\mathit{expr}} : t~\mathsf{const}
}{
C \vdash \mathsf{global}~{\mathit{globaltype}}~{\mathit{expr}} : {\mathit{globaltype}}
} \, {[\textsc{\scriptsize T{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{memtype}} : \mathsf{ok}
}{
C \vdash \mathsf{memory}~{\mathit{memtype}} : {\mathit{memtype}}
} \, {[\textsc{\scriptsize T{-}mem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{tabletype}} : \mathsf{ok}
 \qquad
{\mathit{tabletype}} = {\mathit{at}}~{\mathit{lim}}~{\mathit{rt}}
 \qquad
C \vdash {\mathit{expr}} : {\mathit{rt}}~\mathsf{const}
}{
C \vdash \mathsf{table}~{\mathit{tabletype}}~{\mathit{expr}} : {\mathit{tabletype}}
} \, {[\textsc{\scriptsize T{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{{\mathrm{default}}}_{t} \neq \epsilon
}{
C \vdash \mathsf{local}~t : \mathsf{set}~t
} \, {[\textsc{\scriptsize T{-}local{-}set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{{\mathrm{default}}}_{t} = \epsilon
}{
C \vdash \mathsf{local}~t : \mathsf{unset}~t
} \, {[\textsc{\scriptsize T{-}local{-}unset}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\begin{array}{@{}c@{}}
C{.}\mathsf{types}{}[x] \approx \mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast}
 \qquad
(C \vdash {\mathit{local}} : {{\mathit{lt}}})^\ast
 \\
C \oplus \{ \mathsf{locals}~{(\mathsf{set}~t_1)^\ast}~{{{\mathit{lt}}}^\ast},\;\allowbreak \mathsf{labels}~({t_2^\ast}),\;\allowbreak \mathsf{return}~({t_2^\ast}) \} \vdash {\mathit{expr}} : {t_2^\ast}
\end{array}
}{
C \vdash \mathsf{func}~x~{{\mathit{local}}^\ast}~{\mathit{expr}} : C{.}\mathsf{types}{}[x]
} \, {[\textsc{\scriptsize T{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{datamode}} : \mathsf{ok}
}{
C \vdash \mathsf{data}~{b^\ast}~{\mathit{datamode}} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}data}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{elemtype}} : \mathsf{ok}
 \qquad
(C \vdash {\mathit{expr}} : {\mathit{elemtype}}~\mathsf{const})^\ast
 \qquad
C \vdash {\mathit{elemmode}} : {\mathit{elemtype}}
}{
C \vdash \mathsf{elem}~{\mathit{elemtype}}~{{\mathit{expr}}^\ast}~{\mathit{elemmode}} : {\mathit{elemtype}}
} \, {[\textsc{\scriptsize T{-}elem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{passive} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}datamode{-}passive}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{at}}~{\mathit{lim}}~\mathsf{page}
 \qquad
C \vdash {\mathit{expr}} : {\mathit{at}}~\mathsf{const}
}{
C \vdash \mathsf{active}~x~{\mathit{expr}} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}datamode{-}active}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{passive} : {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}elemmode{-}passive}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{declare} : {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}elemmode{-}declare}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tables}{}[x] = {\mathit{at}}~{\mathit{lim}}~{\mathit{rt}'}
 \qquad
C \vdash {\mathit{rt}} \leq {\mathit{rt}'}
 \qquad
C \vdash {\mathit{expr}} : {\mathit{at}}~\mathsf{const}
}{
C \vdash \mathsf{active}~x~{\mathit{expr}} : {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}elemmode{-}active}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{funcs}{}[x] \approx \mathsf{func}~\epsilon \rightarrow \epsilon
}{
C \vdash \mathsf{start}~x : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}start}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{import}} : {\mathit{externtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{export}} : {\mathit{name}}~{\mathit{externtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{externidx}} : {\mathit{externtype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{xt}} : \mathsf{ok}
}{
C \vdash \mathsf{import}~{\mathit{name}}_1~{\mathit{name}}_2~{\mathit{xt}} : {{\mathrm{clos}}}_{C}({\mathit{xt}})
} \, {[\textsc{\scriptsize T{-}import}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{externidx}} : {\mathit{xt}}
}{
C \vdash \mathsf{export}~{\mathit{name}}~{\mathit{externidx}} : {\mathit{name}}~{\mathit{xt}}
} \, {[\textsc{\scriptsize T{-}export}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tags}{}[x] = {\mathit{jt}}
}{
C \vdash \mathsf{tag}~x : \mathsf{tag}~{\mathit{jt}}
} \, {[\textsc{\scriptsize T{-}externidx{-}tag}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{globals}{}[x] = {\mathit{gt}}
}{
C \vdash \mathsf{global}~x : \mathsf{global}~{\mathit{gt}}
} \, {[\textsc{\scriptsize T{-}externidx{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{mt}}
}{
C \vdash \mathsf{mem}~x : \mathsf{mem}~{\mathit{mt}}
} \, {[\textsc{\scriptsize T{-}externidx{-}mem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tables}{}[x] = {\mathit{tt}}
}{
C \vdash \mathsf{table}~x : \mathsf{table}~{\mathit{tt}}
} \, {[\textsc{\scriptsize T{-}externidx{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{funcs}{}[x] = {\mathit{dt}}
}{
C \vdash \mathsf{func}~x : \mathsf{func}~{\mathit{dt}}
} \, {[\textsc{\scriptsize T{-}externidx{-}func}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\vdash}\, {\mathit{module}} : {\mathit{moduletype}}}$

$\boxed{{\mathit{context}} \vdash {{\mathit{type}}^\ast} : {{\mathit{deftype}}^\ast}}$

$\boxed{{\mathit{context}} \vdash {{\mathit{global}}^\ast} : {{\mathit{globaltype}}^\ast}}$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{nonfuncs}} & ::= & {{\mathit{global}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{elem}}^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{funcidx}}({{\mathit{global}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{elem}}^\ast}) & = & {\mathrm{funcidx}}(\mathsf{module}~\epsilon~\epsilon~\epsilon~{{\mathit{global}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{table}}^\ast}~\epsilon~\epsilon~{{\mathit{elem}}^\ast}~\epsilon~\epsilon) \\
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\begin{array}{@{}c@{}}
\{  \} \vdash {{\mathit{type}}^\ast} : {{\mathit{dt}'}^\ast}
 \qquad
(\{ \mathsf{types}~{{\mathit{dt}'}^\ast} \} \vdash {\mathit{import}} : {\mathit{xt}}_{\mathsf{i}})^\ast
 \\
({C'} \vdash {\mathit{tag}} : {\mathit{jt}})^\ast
 \qquad
{C'} \vdash {{\mathit{global}}^\ast} : {{\mathit{gt}}^\ast}
 \qquad
({C'} \vdash {\mathit{mem}} : {\mathit{mt}})^\ast
 \qquad
({C'} \vdash {\mathit{table}} : {\mathit{tt}})^\ast
 \qquad
(C \vdash {\mathit{func}} : {\mathit{dt}})^\ast
 \\
(C \vdash {\mathit{data}} : {\mathit{ok}})^\ast
 \qquad
(C \vdash {\mathit{elem}} : {\mathit{rt}})^\ast
 \qquad
(C \vdash {\mathit{start}} : \mathsf{ok})^?
 \qquad
(C \vdash {\mathit{export}} : {\mathit{nm}}~{\mathit{xt}}_{\mathsf{e}})^\ast
 \qquad
{{\mathit{nm}}^\ast}~{\mathrm{disjoint}}
 \\
C = {C'} \oplus \{ \mathsf{tags}~{{\mathit{jt}}_{\mathsf{i}}^\ast}~{{\mathit{jt}}^\ast},\;\allowbreak \mathsf{globals}~{{\mathit{gt}}^\ast},\;\allowbreak \mathsf{mems}~{{\mathit{mt}}_{\mathsf{i}}^\ast}~{{\mathit{mt}}^\ast},\;\allowbreak \mathsf{tables}~{{\mathit{tt}}_{\mathsf{i}}^\ast}~{{\mathit{tt}}^\ast},\;\allowbreak \mathsf{datas}~{{\mathit{ok}}^\ast},\;\allowbreak \mathsf{elems}~{{\mathit{rt}}^\ast} \}
 \\
{C'} = \{ \mathsf{types}~{{\mathit{dt}'}^\ast},\;\allowbreak \mathsf{globals}~{{\mathit{gt}}_{\mathsf{i}}^\ast},\;\allowbreak \mathsf{funcs}~{{\mathit{dt}}_{\mathsf{i}}^\ast}~{{\mathit{dt}}^\ast},\;\allowbreak \mathsf{refs}~{x^\ast} \}
 \qquad
{x^\ast} = {\mathrm{funcidx}}({{\mathit{global}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{elem}}^\ast})
 \\
{{\mathit{jt}}_{\mathsf{i}}^\ast} = {\mathrm{tags}}({{\mathit{xt}}_{\mathsf{i}}^\ast})
 \qquad
{{\mathit{gt}}_{\mathsf{i}}^\ast} = {\mathrm{globals}}({{\mathit{xt}}_{\mathsf{i}}^\ast})
 \qquad
{{\mathit{mt}}_{\mathsf{i}}^\ast} = {\mathrm{mems}}({{\mathit{xt}}_{\mathsf{i}}^\ast})
 \qquad
{{\mathit{tt}}_{\mathsf{i}}^\ast} = {\mathrm{tables}}({{\mathit{xt}}_{\mathsf{i}}^\ast})
 \qquad
{{\mathit{dt}}_{\mathsf{i}}^\ast} = {\mathrm{funcs}}({{\mathit{xt}}_{\mathsf{i}}^\ast})
\end{array}
}{
{\vdash}\, \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{tag}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast} : {{\mathrm{clos}}}_{C}({{\mathit{xt}}_{\mathsf{i}}^\ast} \rightarrow {{\mathit{xt}}_{\mathsf{e}}^\ast})
} \, {[\textsc{\scriptsize T{-}module}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \epsilon : \epsilon
} \, {[\textsc{\scriptsize T{-}types{-}empty}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{type}}_1 : {{\mathit{dt}}_1^\ast}
 \qquad
C \oplus \{ \mathsf{types}~{{\mathit{dt}}_1^\ast} \} \vdash {{\mathit{type}}^\ast} : {{\mathit{dt}}^\ast}
}{
C \vdash {\mathit{type}}_1~{{\mathit{type}}^\ast} : {{\mathit{dt}}_1^\ast}~{{\mathit{dt}}^\ast}
} \, {[\textsc{\scriptsize T{-}types{-}cons}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \epsilon : \epsilon
} \, {[\textsc{\scriptsize T{-}globals{-}empty}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{global}}_1 : {\mathit{gt}}_1
 \qquad
C \oplus \{ \mathsf{globals}~{\mathit{gt}}_1 \} \vdash {{\mathit{global}}^\ast} : {{\mathit{gt}}^\ast}
}{
C \vdash {\mathit{global}}_1~{{\mathit{global}}^\ast} : {\mathit{gt}}_1~{{\mathit{gt}}^\ast}
} \, {[\textsc{\scriptsize T{-}globals{-}cons}]}
\qquad
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{relaxed{\kern-0.1em\scriptstyle 2}}} & ::= & 0 ~~|~~ 1 \\
& {\mathit{relaxed{\kern-0.1em\scriptstyle 4}}} & ::= & 0 ~~|~~ 1 ~~|~~ 2 ~~|~~ 3 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{relaxed}}(i)}{{}[ X_1, X_2 ]} & = & (X_1~X_2){}[i] & \quad \mbox{if}~ {\mathrm{ND}} \\
{{\mathrm{relaxed}}(i)}{{}[ X_1, X_2 ]} & = & (X_1~X_2){}[0] & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{relaxed}}(i)}{{}[ X_1, X_2, X_3, X_4 ]} & = & (X_1~X_2~X_3~X_4){}[i] & \quad \mbox{if}~ {\mathrm{ND}} \\
{{\mathrm{relaxed}}(i)}{{}[ X_1, X_2, X_3, X_4 ]} & = & (X_1~X_2~X_3~X_4){}[0] & \quad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{signed}}}_{N}(i) & = & i & \quad \mbox{if}~ i < {2^{N - 1}} \\
{{\mathrm{signed}}}_{N}(i) & = & i - {2^{N}} & \quad \mbox{if}~ {2^{N - 1}} \leq i < {2^{N}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{{{\mathrm{signed}}}_{N}^{{-1}}}}{(i)} & = & i & \quad \mbox{if}~ 0 \leq i < {2^{N - 1}} \\
{{{{\mathrm{signed}}}_{N}^{{-1}}}}{(i)} & = & i + {2^{N}} & \quad \mbox{if}~ {-{2^{N - 1}}} \leq i < 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{sx}}({\mathit{consttype}}) & = & \epsilon \\
{\mathrm{sx}}({\mathit{packtype}}) & = & \mathsf{s} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
0 & = & 0 \\
0 & = & {+0} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
\mathbb{B}(\mathsf{false}) & = & 0 \\
\mathbb{B}(\mathsf{true}) & = & 1 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{sat\_u}}}_{N}(i) & = & 0 & \quad \mbox{if}~ i < 0 \\
{{\mathrm{sat\_u}}}_{N}(i) & = & {2^{N}} - 1 & \quad \mbox{if}~ i > {2^{N}} - 1 \\
{{\mathrm{sat\_u}}}_{N}(i) & = & i & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{sat\_s}}}_{N}(i) & = & {-{2^{N - 1}}} & \quad \mbox{if}~ i < {-{2^{N - 1}}} \\
{{\mathrm{sat\_s}}}_{N}(i) & = & {2^{N - 1}} - 1 & \quad \mbox{if}~ i > {2^{N - 1}} - 1 \\
{{\mathrm{sat\_s}}}_{N}(i) & = & i & \quad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ineg}}}_{N}(i_1) & = & ({2^{N}} - i_1) \mathbin{\mathrm{mod}} {2^{N}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{iabs}}}_{N}(i_1) & = & i_1 & \quad \mbox{if}~ {{\mathrm{signed}}}_{N}(i_1) \geq 0 \\
{{\mathrm{iabs}}}_{N}(i_1) & = & {{\mathrm{ineg}}}_{N}(i_1) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{{{\mathrm{iextend}}}_{N, M}^{\mathsf{u}}}}{(i)} & = & i \mathbin{\mathrm{mod}} {2^{M}} \\
{{{{\mathrm{iextend}}}_{N, M}^{\mathsf{s}}}}{(i)} & = & {{{{\mathrm{signed}}}_{N}^{{-1}}}}{({{\mathrm{signed}}}_{M}(i \mathbin{\mathrm{mod}} {2^{M}}))} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{iadd}}}_{N}(i_1, i_2) & = & (i_1 + i_2) \mathbin{\mathrm{mod}} {2^{N}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{isub}}}_{N}(i_1, i_2) & = & ({2^{N}} + i_1 - i_2) \mathbin{\mathrm{mod}} {2^{N}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{imul}}}_{N}(i_1, i_2) & = & (i_1 \cdot i_2) \mathbin{\mathrm{mod}} {2^{N}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{idiv}}}{\mathsf{u}}{{}_{N}(i_1, 0)} & = & \epsilon \\
{{\mathrm{idiv}}}{\mathsf{u}}{{}_{N}(i_1, i_2)} & = & {\mathrm{truncz}}(i_1 / i_2) \\
{{\mathrm{idiv}}}{\mathsf{s}}{{}_{N}(i_1, 0)} & = & \epsilon \\
{{\mathrm{idiv}}}{\mathsf{s}}{{}_{N}(i_1, i_2)} & = & \epsilon & \quad \mbox{if}~ {{\mathrm{signed}}}_{N}(i_1) / {{\mathrm{signed}}}_{N}(i_2) = {2^{N - 1}} \\
{{\mathrm{idiv}}}{\mathsf{s}}{{}_{N}(i_1, i_2)} & = & {{{{\mathrm{signed}}}_{N}^{{-1}}}}{({\mathrm{truncz}}({{\mathrm{signed}}}_{N}(i_1) / {{\mathrm{signed}}}_{N}(i_2)))} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{irem}}}{\mathsf{u}}{{}_{N}(i_1, 0)} & = & \epsilon \\
{{\mathrm{irem}}}{\mathsf{u}}{{}_{N}(i_1, i_2)} & = & i_1 - i_2 \cdot {\mathrm{truncz}}(i_1 / i_2) \\
{{\mathrm{irem}}}{\mathsf{s}}{{}_{N}(i_1, 0)} & = & \epsilon \\
{{\mathrm{irem}}}{\mathsf{s}}{{}_{N}(i_1, i_2)} & = & {{{{\mathrm{signed}}}_{N}^{{-1}}}}{(j_1 - j_2 \cdot {\mathrm{truncz}}(j_1 / j_2))} & \quad \mbox{if}~ j_1 = {{\mathrm{signed}}}_{N}(i_1) \land j_2 = {{\mathrm{signed}}}_{N}(i_2) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{imin}}}{\mathsf{u}}{{}_{N}(i_1, i_2)} & = & i_1 & \quad \mbox{if}~ i_1 \leq i_2 \\
{{\mathrm{imin}}}{\mathsf{u}}{{}_{N}(i_1, i_2)} & = & i_2 & \quad \mbox{if}~ i_1 > i_2 \\
{{\mathrm{imin}}}{\mathsf{s}}{{}_{N}(i_1, i_2)} & = & i_1 & \quad \mbox{if}~ {{\mathrm{signed}}}_{N}(i_1) \leq {{\mathrm{signed}}}_{N}(i_2) \\
{{\mathrm{imin}}}{\mathsf{s}}{{}_{N}(i_1, i_2)} & = & i_2 & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{imax}}}{\mathsf{u}}{{}_{N}(i_1, i_2)} & = & i_1 & \quad \mbox{if}~ i_1 \geq i_2 \\
{{\mathrm{imax}}}{\mathsf{u}}{{}_{N}(i_1, i_2)} & = & i_2 & \quad \mbox{if}~ i_1 < i_2 \\
{{\mathrm{imax}}}{\mathsf{s}}{{}_{N}(i_1, i_2)} & = & i_1 & \quad \mbox{if}~ {{\mathrm{signed}}}_{N}(i_1) \geq {{\mathrm{signed}}}_{N}(i_2) \\
{{\mathrm{imax}}}{\mathsf{s}}{{}_{N}(i_1, i_2)} & = & i_2 & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{iadd\_sat}}}{\mathsf{u}}{{}_{N}(i_1, i_2)} & = & {{\mathrm{sat\_u}}}_{N}(i_1 + i_2) \\
{{\mathrm{iadd\_sat}}}{\mathsf{s}}{{}_{N}(i_1, i_2)} & = & {{{{\mathrm{signed}}}_{N}^{{-1}}}}{({{\mathrm{sat\_s}}}_{N}({{\mathrm{signed}}}_{N}(i_1) + {{\mathrm{signed}}}_{N}(i_2)))} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{isub\_sat}}}{\mathsf{u}}{{}_{N}(i_1, i_2)} & = & {{\mathrm{sat\_u}}}_{N}(i_1 - i_2) \\
{{\mathrm{isub\_sat}}}{\mathsf{s}}{{}_{N}(i_1, i_2)} & = & {{{{\mathrm{signed}}}_{N}^{{-1}}}}{({{\mathrm{sat\_s}}}_{N}({{\mathrm{signed}}}_{N}(i_1) - {{\mathrm{signed}}}_{N}(i_2)))} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ieqz}}}_{N}(i_1) & = & \mathbb{B}(i_1 = 0) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{inez}}}_{N}(i_1) & = & \mathbb{B}(i_1 \neq 0) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ieq}}}_{N}(i_1, i_2) & = & \mathbb{B}(i_1 = i_2) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ine}}}_{N}(i_1, i_2) & = & \mathbb{B}(i_1 \neq i_2) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ilt}}}{\mathsf{u}}{{}_{N}(i_1, i_2)} & = & \mathbb{B}(i_1 < i_2) \\
{{\mathrm{ilt}}}{\mathsf{s}}{{}_{N}(i_1, i_2)} & = & \mathbb{B}({{\mathrm{signed}}}_{N}(i_1) < {{\mathrm{signed}}}_{N}(i_2)) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{igt}}}{\mathsf{u}}{{}_{N}(i_1, i_2)} & = & \mathbb{B}(i_1 > i_2) \\
{{\mathrm{igt}}}{\mathsf{s}}{{}_{N}(i_1, i_2)} & = & \mathbb{B}({{\mathrm{signed}}}_{N}(i_1) > {{\mathrm{signed}}}_{N}(i_2)) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ile}}}{\mathsf{u}}{{}_{N}(i_1, i_2)} & = & \mathbb{B}(i_1 \leq i_2) \\
{{\mathrm{ile}}}{\mathsf{s}}{{}_{N}(i_1, i_2)} & = & \mathbb{B}({{\mathrm{signed}}}_{N}(i_1) \leq {{\mathrm{signed}}}_{N}(i_2)) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ige}}}{\mathsf{u}}{{}_{N}(i_1, i_2)} & = & \mathbb{B}(i_1 \geq i_2) \\
{{\mathrm{ige}}}{\mathsf{s}}{{}_{N}(i_1, i_2)} & = & \mathbb{B}({{\mathrm{signed}}}_{N}(i_1) \geq {{\mathrm{signed}}}_{N}(i_2)) \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

\vspace{1ex}

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{pack}}}_{{\mathit{numtype}}}(c) & = & c \\
{{\mathrm{pack}}}_{{\mathit{packtype}}}(c) & = & {{\mathrm{wrap}}}_{{|{\mathrm{unpack}}({\mathit{packtype}})|}, {|{\mathit{packtype}}|}}(c) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{pack}}}_{{\mathit{consttype}}}(c) & = & c \\
{{\mathrm{pack}}}_{{\mathit{packtype}}}(c) & = & {{\mathrm{wrap}}}_{{|{\mathrm{unpack}}({\mathit{packtype}})|}, {|{\mathit{packtype}}|}}(c) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{unpack}}}_{{\mathit{numtype}}}(c) & = & c \\
{{\mathrm{unpack}}}_{{\mathit{packtype}}}(c) & = & {{{{\mathrm{extend}}}_{{|{\mathit{packtype}}|}, {|{\mathrm{unpack}}({\mathit{packtype}})|}}^{\mathsf{u}}}}{(c)} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{unpack}}}_{{\mathit{consttype}}}(c) & = & c \\
{{\mathrm{unpack}}}_{{\mathit{packtype}}}(c) & = & {{{{\mathrm{extend}}}_{{|{\mathit{packtype}}|}, {|{\mathrm{unpack}}({\mathit{packtype}})|}}^{\mathsf{u}}}}{(c)} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathsf{clz}}{{}_{{\mathsf{i}}{N}}(i)} & = & {{\mathrm{iclz}}}_{N}(i) \\
{\mathsf{ctz}}{{}_{{\mathsf{i}}{N}}(i)} & = & {{\mathrm{ictz}}}_{N}(i) \\
{\mathsf{popcnt}}{{}_{{\mathsf{i}}{N}}(i)} & = & {{\mathrm{ipopcnt}}}_{N}(i) \\
{{\mathsf{extend}}{M}{\mathsf{\_}}{\mathsf{s}}}{{}_{{\mathsf{i}}{N}}(i)} & = & {{{{\mathrm{iextend}}}_{N, M}^{\mathsf{s}}}}{(i)} \\
{\mathsf{abs}}{{}_{{\mathsf{f}}{N}}(f)} & = & {{\mathrm{fabs}}}_{N}(f) \\
{\mathsf{neg}}{{}_{{\mathsf{f}}{N}}(f)} & = & {{\mathrm{fneg}}}_{N}(f) \\
{\mathsf{sqrt}}{{}_{{\mathsf{f}}{N}}(f)} & = & {{\mathrm{fsqrt}}}_{N}(f) \\
{\mathsf{ceil}}{{}_{{\mathsf{f}}{N}}(f)} & = & {{\mathrm{fceil}}}_{N}(f) \\
{\mathsf{floor}}{{}_{{\mathsf{f}}{N}}(f)} & = & {{\mathrm{ffloor}}}_{N}(f) \\
{\mathsf{trunc}}{{}_{{\mathsf{f}}{N}}(f)} & = & {{\mathrm{ftrunc}}}_{N}(f) \\
{\mathsf{nearest}}{{}_{{\mathsf{f}}{N}}(f)} & = & {{\mathrm{fnearest}}}_{N}(f) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathsf{add}}{{}_{{\mathsf{i}}{N}}(i_1, i_2)} & = & {{\mathrm{iadd}}}_{N}(i_1, i_2) \\
{\mathsf{sub}}{{}_{{\mathsf{i}}{N}}(i_1, i_2)} & = & {{\mathrm{isub}}}_{N}(i_1, i_2) \\
{\mathsf{mul}}{{}_{{\mathsf{i}}{N}}(i_1, i_2)} & = & {{\mathrm{imul}}}_{N}(i_1, i_2) \\
{{\mathsf{div}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{N}}(i_1, i_2)} & = & {{\mathrm{idiv}}}{{\mathit{sx}}}{{}_{N}(i_1, i_2)} \\
{{\mathsf{rem}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{N}}(i_1, i_2)} & = & {{\mathrm{irem}}}{{\mathit{sx}}}{{}_{N}(i_1, i_2)} \\
{\mathsf{and}}{{}_{{\mathsf{i}}{N}}(i_1, i_2)} & = & {{\mathrm{iand}}}_{N}(i_1, i_2) \\
{\mathsf{or}}{{}_{{\mathsf{i}}{N}}(i_1, i_2)} & = & {{\mathrm{ior}}}_{N}(i_1, i_2) \\
{\mathsf{xor}}{{}_{{\mathsf{i}}{N}}(i_1, i_2)} & = & {{\mathrm{ixor}}}_{N}(i_1, i_2) \\
{\mathsf{shl}}{{}_{{\mathsf{i}}{N}}(i_1, i_2)} & = & {{\mathrm{ishl}}}_{N}(i_1, i_2) \\
{{\mathsf{shr}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{N}}(i_1, i_2)} & = & {{\mathrm{ishr}}}{{\mathit{sx}}}{{}_{N}(i_1, i_2)} \\
{\mathsf{rotl}}{{}_{{\mathsf{i}}{N}}(i_1, i_2)} & = & {{\mathrm{irotl}}}_{N}(i_1, i_2) \\
{\mathsf{rotr}}{{}_{{\mathsf{i}}{N}}(i_1, i_2)} & = & {{\mathrm{irotr}}}_{N}(i_1, i_2) \\
{\mathsf{add}}{{}_{{\mathsf{f}}{N}}(f_1, f_2)} & = & {{\mathrm{fadd}}}_{N}(f_1, f_2) \\
{\mathsf{sub}}{{}_{{\mathsf{f}}{N}}(f_1, f_2)} & = & {{\mathrm{fsub}}}_{N}(f_1, f_2) \\
{\mathsf{mul}}{{}_{{\mathsf{f}}{N}}(f_1, f_2)} & = & {{\mathrm{fmul}}}_{N}(f_1, f_2) \\
{\mathsf{div}}{{}_{{\mathsf{f}}{N}}(f_1, f_2)} & = & {{\mathrm{fdiv}}}_{N}(f_1, f_2) \\
{\mathsf{min}}{{}_{{\mathsf{f}}{N}}(f_1, f_2)} & = & {{\mathrm{fmin}}}_{N}(f_1, f_2) \\
{\mathsf{max}}{{}_{{\mathsf{f}}{N}}(f_1, f_2)} & = & {{\mathrm{fmax}}}_{N}(f_1, f_2) \\
{\mathsf{copysign}}{{}_{{\mathsf{f}}{N}}(f_1, f_2)} & = & {{\mathrm{fcopysign}}}_{N}(f_1, f_2) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathsf{eqz}}{{}_{{\mathsf{i}}{N}}(i)} & = & {{\mathrm{ieqz}}}_{N}(i) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathsf{eq}}{{}_{{\mathsf{i}}{N}}(i_1, i_2)} & = & {{\mathrm{ieq}}}_{N}(i_1, i_2) \\
{\mathsf{ne}}{{}_{{\mathsf{i}}{N}}(i_1, i_2)} & = & {{\mathrm{ine}}}_{N}(i_1, i_2) \\
{{\mathsf{lt}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{N}}(i_1, i_2)} & = & {{\mathrm{ilt}}}{{\mathit{sx}}}{{}_{N}(i_1, i_2)} \\
{{\mathsf{gt}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{N}}(i_1, i_2)} & = & {{\mathrm{igt}}}{{\mathit{sx}}}{{}_{N}(i_1, i_2)} \\
{{\mathsf{le}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{N}}(i_1, i_2)} & = & {{\mathrm{ile}}}{{\mathit{sx}}}{{}_{N}(i_1, i_2)} \\
{{\mathsf{ge}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{N}}(i_1, i_2)} & = & {{\mathrm{ige}}}{{\mathit{sx}}}{{}_{N}(i_1, i_2)} \\
{\mathsf{eq}}{{}_{{\mathsf{f}}{N}}(f_1, f_2)} & = & {{\mathrm{feq}}}_{N}(f_1, f_2) \\
{\mathsf{ne}}{{}_{{\mathsf{f}}{N}}(f_1, f_2)} & = & {{\mathrm{fne}}}_{N}(f_1, f_2) \\
{\mathsf{lt}}{{}_{{\mathsf{f}}{N}}(f_1, f_2)} & = & {{\mathrm{flt}}}_{N}(f_1, f_2) \\
{\mathsf{gt}}{{}_{{\mathsf{f}}{N}}(f_1, f_2)} & = & {{\mathrm{fgt}}}_{N}(f_1, f_2) \\
{\mathsf{le}}{{}_{{\mathsf{f}}{N}}(f_1, f_2)} & = & {{\mathrm{fle}}}_{N}(f_1, f_2) \\
{\mathsf{ge}}{{}_{{\mathsf{f}}{N}}(f_1, f_2)} & = & {{\mathrm{fge}}}_{N}(f_1, f_2) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathsf{extend}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}_1, {{\mathsf{i}}{N}}_2}(i_1)} & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{{{{\mathrm{extend}}}_{N_1, N_2}^{{\mathit{sx}}}}}{(i_1)} \\
\end{array}
} \\
{\mathsf{wrap}}{{}_{{{\mathsf{i}}{N}}_1, {{\mathsf{i}}{N}}_2}(i_1)} & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{{\mathrm{wrap}}}_{N_1, N_2}(i_1) \\
\end{array}
} \\
{{\mathsf{trunc}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{f}}{N}}_1, {{\mathsf{i}}{N}}_2}(f_1)} & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{{{{\mathrm{trunc}}}_{N_1, N_2}^{{\mathit{sx}}}}}{(f_1)} \\
\end{array}
} \\
{{\mathsf{trunc\_sat}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{f}}{N}}_1, {{\mathsf{i}}{N}}_2}(f_1)} & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{{{{\mathrm{trunc\_sat}}}_{N_1, N_2}^{{\mathit{sx}}}}}{(f_1)} \\
\end{array}
} \\
{{\mathsf{convert}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}_1, {{\mathsf{f}}{N}}_2}(i_1)} & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{{{{\mathrm{convert}}}_{N_1, N_2}^{{\mathit{sx}}}}}{(i_1)} \\
\end{array}
} \\
{\mathsf{promote}}{{}_{{{\mathsf{f}}{N}}_1, {{\mathsf{f}}{N}}_2}(f_1)} & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{{\mathrm{promote}}}_{N_1, N_2}(f_1) \\
\end{array}
} \\
{\mathsf{demote}}{{}_{{{\mathsf{f}}{N}}_1, {{\mathsf{f}}{N}}_2}(f_1)} & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{{\mathrm{demote}}}_{N_1, N_2}(f_1) \\
\end{array}
} \\
{\mathsf{reinterpret}}{{}_{{{\mathsf{i}}{N}}_1, {{\mathsf{f}}{N}}_2}(i_1)} & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
{{\mathrm{reinterpret}}}_{{{\mathsf{i}}{N}}_1, {{\mathsf{f}}{N}}_2}(i_1) & \quad \mbox{if}~ {|{{\mathsf{i}}{N}}_1|} = {|{{\mathsf{f}}{N}}_2|} \\
\end{array}
} \\
{\mathsf{reinterpret}}{{}_{{{\mathsf{f}}{N}}_1, {{\mathsf{i}}{N}}_2}(f_1)} & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
{{\mathrm{reinterpret}}}_{{{\mathsf{f}}{N}}_1, {{\mathsf{i}}{N}}_2}(f_1) & \quad \mbox{if}~ {|{{\mathsf{f}}{N}}_1|} = {|{{\mathsf{i}}{N}}_2|} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{zeroop}}({{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}, {\mathsf{extend}}{\mathsf{\_}}{{\mathit{half}}}{\mathsf{\_}}{{\mathit{sx}}}) & = & \epsilon \\
{\mathrm{zeroop}}({{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{f}}{N}}_2}{\mathsf{x}}{M_2}, {\mathsf{convert}}{\mathsf{\_}}{{{\mathit{half}}^?}~{\mathit{sx}}}) & = & \epsilon \\
{\mathrm{zeroop}}({{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}, {\mathsf{trunc\_sat}}{\mathsf{\_}}{{\mathit{sx}}~{{\mathit{zero}}^?}}) & = & {{\mathit{zero}}^?} \\
{\mathrm{zeroop}}({{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}, {\mathsf{relaxed\_trunc}}{\mathsf{\_}}{{\mathit{sx}}~{{\mathit{zero}}^?}}) & = & {{\mathit{zero}}^?} \\
{\mathrm{zeroop}}({{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{f}}{N}}_2}{\mathsf{x}}{M_2}, {\mathsf{demote}}{\mathsf{\_}}{\mathsf{zero}}) & = & {\mathit{zero}} \\
{\mathrm{zeroop}}({{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{f}}{N}}_2}{\mathsf{x}}{M_2}, {\mathsf{promote}}{\mathsf{\_}}{\mathsf{low}}) & = & \epsilon \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{halfop}}({{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}, {\mathsf{extend}}{\mathsf{\_}}{{\mathit{half}}}{\mathsf{\_}}{{\mathit{sx}}}) & = & {\mathit{half}} \\
{\mathrm{halfop}}({{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{f}}{N}}_2}{\mathsf{x}}{M_2}, {\mathsf{convert}}{\mathsf{\_}}{{{\mathit{half}}^?}~{\mathit{sx}}}) & = & {{\mathit{half}}^?} \\
{\mathrm{halfop}}({{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}, {\mathsf{trunc\_sat}}{\mathsf{\_}}{{\mathit{sx}}~{{\mathit{zero}}^?}}) & = & \epsilon \\
{\mathrm{halfop}}({{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}, {\mathsf{relaxed\_trunc}}{\mathsf{\_}}{{\mathit{sx}}~{{\mathit{zero}}^?}}) & = & \epsilon \\
{\mathrm{halfop}}({{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{f}}{N}}_2}{\mathsf{x}}{M_2}, {\mathsf{demote}}{\mathsf{\_}}{\mathsf{zero}}) & = & \epsilon \\
{\mathrm{halfop}}({{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{f}}{N}}_2}{\mathsf{x}}{M_2}, {\mathsf{promote}}{\mathsf{\_}}{\mathsf{low}}) & = & \mathsf{low} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{half}}(\mathsf{low}, i, j) & = & i \\
{\mathrm{half}}(\mathsf{high}, i, j) & = & j \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{iswizzle}}_{{\mathit{lane}}}}_{N}({c^\ast}, i) & = & {c^\ast}{}[i] & \quad \mbox{if}~ i < {|{c^\ast}|} \\
{{\mathrm{iswizzle}}_{{\mathit{lane}}}}_{N}({c^\ast}, i) & = & 0 & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{irelaxed}}_{{\mathit{swizzle}}_{{\mathit{lane}}}}}_{N}({c^\ast}, i) & = & {c^\ast}{}[i] & \quad \mbox{if}~ i < {|{c^\ast}|} \\
{{\mathrm{irelaxed}}_{{\mathit{swizzle}}_{{\mathit{lane}}}}}_{N}({c^\ast}, i) & = & 0 & \quad \mbox{if}~ {{\mathrm{signed}}}_{N}(i) < 0 \\
{{\mathrm{irelaxed}}_{{\mathit{swizzle}}_{{\mathit{lane}}}}}_{N}({c^\ast}, i) & = & {{\mathrm{relaxed}}({\mathrm{R}}_{\mathit{swizzle}})}{{}[ 0, {c^\ast}{}[i \mathbin{\mathrm{mod}} {|{c^\ast}|}] ]} & \quad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ivunop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{f}}, v_1) & = & {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({c^\ast})} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1) \\
{\land}~ {c^\ast} = {{{\mathrm{f}}}_{N}(c_1)^\ast} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{fvunop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{f}}, v_1) & = & {{{{{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({c^\ast})}^\ast} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1) \\
{\land}~ {{c^\ast}^\ast} = {\Large\times}~{{{\mathrm{f}}}_{N}(c_1)^\ast} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ivbinop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{f}}, v_1, v_2) & = & {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({c^\ast})} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1) \\
{\land}~ {c_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_2) \\
{\land}~ {c^\ast} = {{{\mathrm{f}}}_{N}(c_1, c_2)^\ast} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ivbinopsx}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{f}}, {\mathit{sx}}, v_1, v_2) & = & {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({c^\ast})} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1) \\
{\land}~ {c_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_2) \\
{\land}~ {c^\ast} = {{{\mathrm{f}}}_{N}({\mathit{sx}}, c_1, c_2)^\ast} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ivbinopsxnd}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{f}}, {\mathit{sx}}, v_1, v_2) & = & {{{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({c^\ast})}^\ast} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1) \\
{\land}~ {c_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_2) \\
{\land}~ {{c^\ast}^\ast} = {\Large\times}~{{{\mathrm{f}}}_{N}({\mathit{sx}}, c_1, c_2)^\ast} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{fvbinop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{f}}, v_1, v_2) & = & {{{{{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({c^\ast})}^\ast} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1) \\
{\land}~ {c_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_2) \\
{\land}~ {{c^\ast}^\ast} = {\Large\times}~{{{\mathrm{f}}}_{N}(c_1, c_2)^\ast} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ivternopnd}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{f}}, v_1, v_2, v_3) & = & {{{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({c^\ast})}^\ast} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1) \\
{\land}~ {c_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_2) \\
{\land}~ {c_3^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_3) \\
{\land}~ {{c^\ast}^\ast} = {\Large\times}~{{{\mathrm{f}}}_{N}(c_1, c_2, c_3)^\ast} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{fvternop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{f}}, v_1, v_2, v_3) & = & {{{{{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({c^\ast})}^\ast} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1) \\
{\land}~ {c_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_2) \\
{\land}~ {c_3^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_3) \\
{\land}~ {{c^\ast}^\ast} = {\Large\times}~{{{\mathrm{f}}}_{N}(c_1, c_2, c_3)^\ast} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ivrelop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{f}}, v_1, v_2) & = & {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({c^\ast})} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1) \\
{\land}~ {c_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_2) \\
{\land}~ {c^\ast} = {{{{{\mathrm{extend}}}_{1, N}^{\mathsf{s}}}}{({{\mathrm{f}}}_{N}(c_1, c_2))}^\ast} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ivrelopsx}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{f}}, {\mathit{sx}}, v_1, v_2) & = & {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({c^\ast})} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1) \\
{\land}~ {c_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_2) \\
{\land}~ {c^\ast} = {{{{{\mathrm{extend}}}_{1, N}^{\mathsf{s}}}}{({{\mathrm{f}}}_{N}({\mathit{sx}}, c_1, c_2))}^\ast} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{fvrelop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{f}}, v_1, v_2) & = & {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({c^\ast})} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1) \\
{\land}~ {c_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_2) \\
{\land}~ {c^\ast} = {{{{{\mathrm{extend}}}_{1, N}^{\mathsf{s}}}}{({{\mathrm{f}}}_{N}(c_1, c_2))}^\ast} \\
{\land}~ {|{\mathsf{i}}{N}|} = {|{\mathsf{f}}{N}|} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ivshiftop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{f}}, v_1, i) & = & {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({c^\ast})} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1) \\
{\land}~ {c^\ast} = {{{\mathrm{f}}}_{N}(c_1, i)^\ast} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ivshiftopsx}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{f}}, {\mathit{sx}}, v_1, i) & = & {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({c^\ast})} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1) \\
{\land}~ {c^\ast} = {{{\mathrm{f}}}_{N}({\mathit{sx}}, c_1, i)^\ast} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ivbitmaskop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1) & = & {{\mathrm{irev}}}_{32}(c) & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1) \\
{\land}~ {{\mathrm{bits}}}_{{\mathsf{i}}{32}}(c) = {{{\mathrm{ilt}}}{\mathsf{s}}{{}_{N}(c_1, 0)}^\ast} \oplus {(0)^{32 - M}} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ivswizzlop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{f}}, v_1, v_2) & = & {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({c^\ast})} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1) \\
{\land}~ {c_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_2) \\
{\land}~ {c^\ast} = {{{\mathrm{f}}}_{N}({c_1^\ast}, c_2)^\ast} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ivshufflop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({i^\ast}, v_1, v_2) & = & {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({c^\ast})} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1) \\
{\land}~ {c_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_2) \\
{\land}~ {c^\ast} = {(({c_1^\ast} \oplus {c_2^\ast}){}[i])^\ast} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathsf{not}}{{}_{{\mathsf{v}}{N}}(v)} & = & {{\mathrm{inot}}}_{N}(v) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathsf{and}}{{}_{{\mathsf{v}}{N}}(v_1, v_2)} & = & {{\mathrm{iand}}}_{N}(v_1, v_2) \\
{\mathsf{andnot}}{{}_{{\mathsf{v}}{N}}(v_1, v_2)} & = & {{\mathrm{iandnot}}}_{N}(v_1, v_2) \\
{\mathsf{or}}{{}_{{\mathsf{v}}{N}}(v_1, v_2)} & = & {{\mathrm{ior}}}_{N}(v_1, v_2) \\
{\mathsf{xor}}{{}_{{\mathsf{v}}{N}}(v_1, v_2)} & = & {{\mathrm{ixor}}}_{N}(v_1, v_2) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathsf{bitselect}}{{}_{{\mathsf{v}}{N}}(v_1, v_2, v_3)} & = & {{\mathrm{ibitselect}}}_{N}(v_1, v_2, v_3) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathsf{abs}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v)} & = & {{\mathrm{fvunop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{fabs}}, v) \\
{\mathsf{neg}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v)} & = & {{\mathrm{fvunop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{fneg}}, v) \\
{\mathsf{sqrt}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v)} & = & {{\mathrm{fvunop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{fsqrt}}, v) \\
{\mathsf{ceil}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v)} & = & {{\mathrm{fvunop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{fceil}}, v) \\
{\mathsf{floor}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v)} & = & {{\mathrm{fvunop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{ffloor}}, v) \\
{\mathsf{trunc}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v)} & = & {{\mathrm{fvunop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{ftrunc}}, v) \\
{\mathsf{nearest}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v)} & = & {{\mathrm{fvunop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{fnearest}}, v) \\
{\mathsf{abs}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v)} & = & {{\mathrm{ivunop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{iabs}}, v) \\
{\mathsf{neg}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v)} & = & {{\mathrm{ivunop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{ineg}}, v) \\
{\mathsf{popcnt}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v)} & = & {{\mathrm{ivunop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{ipopcnt}}, v) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathsf{add}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{ivbinop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{iadd}}, v_1, v_2) \\
{\mathsf{sub}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{ivbinop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{isub}}, v_1, v_2) \\
{\mathsf{mul}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{ivbinop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{imul}}, v_1, v_2) \\
{{\mathsf{add\_sat}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{ivbinopsx}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{iadd}}_{{\mathit{sat}}}, {\mathit{sx}}, v_1, v_2) \\
{{\mathsf{sub\_sat}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{ivbinopsx}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{isub}}_{{\mathit{sat}}}, {\mathit{sx}}, v_1, v_2) \\
{{\mathsf{min}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{ivbinopsx}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{imin}}, {\mathit{sx}}, v_1, v_2) \\
{{\mathsf{max}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{ivbinopsx}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{imax}}, {\mathit{sx}}, v_1, v_2) \\
{{\mathsf{avgr}}{\mathsf{\_}}{\mathsf{u}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{ivbinopsx}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{iavgr}}, \mathsf{u}, v_1, v_2) \\
{{\mathsf{q{\scriptstyle 15}mulr\_sat}}{\mathsf{\_}}{\mathsf{s}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{ivbinopsx}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{iq{\kern-0.1em\scriptstyle 15\kern-0.1em}mulr}}_{{\mathit{sat}}}, \mathsf{s}, v_1, v_2) \\
{{\mathsf{relaxed\_q{\scriptstyle 15}mulr}}{\mathsf{\_}}{\mathsf{s}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{ivbinopsxnd}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{irelaxed}}_{{\mathit{q{\kern-0.1em\scriptstyle 15\kern-0.1em}mulr}}}, \mathsf{s}, v_1, v_2) \\
{\mathsf{add}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{fvbinop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{fadd}}, v_1, v_2) \\
{\mathsf{sub}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{fvbinop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{fsub}}, v_1, v_2) \\
{\mathsf{mul}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{fvbinop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{fmul}}, v_1, v_2) \\
{\mathsf{div}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{fvbinop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{fdiv}}, v_1, v_2) \\
{\mathsf{min}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{fvbinop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{fmin}}, v_1, v_2) \\
{\mathsf{max}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{fvbinop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{fmax}}, v_1, v_2) \\
{\mathsf{pmin}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{fvbinop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{fpmin}}, v_1, v_2) \\
{\mathsf{pmax}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{fvbinop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{fpmax}}, v_1, v_2) \\
{\mathsf{relaxed\_min}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{fvbinop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{frelaxed}}_{{\mathit{min}}}, v_1, v_2) \\
{\mathsf{relaxed\_max}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{fvbinop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{frelaxed}}_{{\mathit{max}}}, v_1, v_2) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathsf{relaxed\_laneselect}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1, v_2, v_3)} & = & {{\mathrm{ivternopnd}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{irelaxed}}_{{\mathit{laneselect}}}, v_1, v_2, v_3) \\
{\mathsf{relaxed\_madd}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1, v_2, v_3)} & = & {{\mathrm{fvternop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{frelaxed}}_{{\mathit{madd}}}, v_1, v_2, v_3) \\
{\mathsf{relaxed\_nmadd}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1, v_2, v_3)} & = & {{\mathrm{fvternop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{frelaxed}}_{{\mathit{nmadd}}}, v_1, v_2, v_3) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathsf{eq}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{ivrelop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{ieq}}, v_1, v_2) \\
{\mathsf{ne}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{ivrelop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{ine}}, v_1, v_2) \\
{{\mathsf{lt}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{ivrelopsx}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{ilt}}, {\mathit{sx}}, v_1, v_2) \\
{{\mathsf{gt}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{ivrelopsx}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{igt}}, {\mathit{sx}}, v_1, v_2) \\
{{\mathsf{le}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{ivrelopsx}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{ile}}, {\mathit{sx}}, v_1, v_2) \\
{{\mathsf{ge}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{ivrelopsx}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{ige}}, {\mathit{sx}}, v_1, v_2) \\
{\mathsf{eq}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{fvrelop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{feq}}, v_1, v_2) \\
{\mathsf{ne}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{fvrelop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{fne}}, v_1, v_2) \\
{\mathsf{lt}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{fvrelop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{flt}}, v_1, v_2) \\
{\mathsf{gt}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{fvrelop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{fgt}}, v_1, v_2) \\
{\mathsf{le}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{fvrelop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{fle}}, v_1, v_2) \\
{\mathsf{ge}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{fvrelop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathrm{fge}}, v_1, v_2) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathsf{shl}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}}{(v, i)} & = & {{\mathrm{ivshiftop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{ishl}}, v, i) \\
{{\mathsf{shr}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}}{(v, i)} & = & {{\mathrm{ivshiftopsx}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathrm{ishr}}, {\mathit{sx}}, v, i) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathsf{vbitmask}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v)} & = & {{\mathrm{ivbitmaskop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(v) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathsf{swizzle}}{{}_{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{ivswizzlop}}}_{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{M}}({\mathrm{iswizzle}}_{{\mathit{lane}}}, v_1, v_2) \\
{\mathsf{relaxed\_swizzle}}{{}_{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{M}}(v_1, v_2)} & = & {{\mathrm{ivswizzlop}}}_{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{M}}({\mathrm{irelaxed}}_{{\mathit{swizzle}}_{{\mathit{lane}}}}, v_1, v_2) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathsf{vshuffle}}{{}_{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{M}}({i^\ast}, v_1, v_2)} & = & {{\mathrm{ivshufflop}}}_{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{M}}({i^\ast}, v_1, v_2) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{lcvtop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}({\mathsf{extend}}{\mathsf{\_}}{{\mathit{half}}}{\mathsf{\_}}{{\mathit{sx}}}, c_1) & = & c & \quad \mbox{if}~ c = {{{{\mathrm{extend}}}_{N_1, N_2}^{{\mathit{sx}}}}}{(c_1)} \\
{{\mathrm{lcvtop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{f}}{N}}_2}{\mathsf{x}}{M_2}}({\mathsf{convert}}{\mathsf{\_}}{{{\mathit{half}}^?}~{\mathit{sx}}}, c_1) & = & c & \quad \mbox{if}~ c = {{{{\mathrm{convert}}}_{N_1, N_2}^{{\mathit{sx}}}}}{(c_1)} \\
{{\mathrm{lcvtop}}}_{{{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}({\mathsf{trunc\_sat}}{\mathsf{\_}}{{\mathit{sx}}~{{\mathit{zero}}^?}}, c_1) & = & {c^?} & \quad \mbox{if}~ {c^?} = {{{{\mathrm{trunc\_sat}}}_{N_1, N_2}^{{\mathit{sx}}}}}{(c_1)} \\
{{\mathrm{lcvtop}}}_{{{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}({\mathsf{relaxed\_trunc}}{\mathsf{\_}}{{\mathit{sx}}~{{\mathit{zero}}^?}}, c_1) & = & {c^?} & \quad \mbox{if}~ {c^?} = {{{{\mathrm{relaxed\_trunc}}}_{N_1, N_2}^{{\mathit{sx}}}}}{(c_1)} \\
{{\mathrm{lcvtop}}}_{{{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{f}}{N}}_2}{\mathsf{x}}{M_2}}({\mathsf{demote}}{\mathsf{\_}}{\mathsf{zero}}, c_1) & = & {c^\ast} & \quad \mbox{if}~ {c^\ast} = {{\mathrm{demote}}}_{N_1, N_2}(c_1) \\
{{\mathrm{lcvtop}}}_{{{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{f}}{N}}_2}{\mathsf{x}}{M_2}}({\mathsf{promote}}{\mathsf{\_}}{\mathsf{low}}, c_1) & = & {c^\ast} & \quad \mbox{if}~ {c^\ast} = {{\mathrm{promote}}}_{N_1, N_2}(c_1) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{vcvtop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M}}({\mathit{vcvtop}}, v_1) & = & v & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {\mathrm{halfop}}({{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M}, {\mathit{vcvtop}}) = \epsilon \land {\mathrm{zeroop}}({{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M}, {\mathit{vcvtop}}) = \epsilon \\
{\land}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M}}(v_1) \\
{\land}~ {{c^\ast}^\ast} = {\Large\times}~{{{\mathrm{lcvtop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M}}({\mathit{vcvtop}}, c_1)^\ast} \\
{\land}~ v \in {{{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M}}^{{-1}}}}{({c^\ast})}^\ast} \\
\end{array} \\
{{\mathrm{vcvtop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}({\mathit{vcvtop}}, v_1) & = & v & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {\mathrm{halfop}}({{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}, {\mathit{vcvtop}}) = {\mathit{half}} \\
{\land}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}}(v_1){}[{\mathrm{half}}({\mathit{half}}, 0, M_2) : M_2] \\
{\land}~ {{c^\ast}^\ast} = {\Large\times}~{{{\mathrm{lcvtop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}({\mathit{vcvtop}}, c_1)^\ast} \\
{\land}~ v \in {{{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}^{{-1}}}}{({c^\ast})}^\ast} \\
\end{array} \\
{{\mathrm{vcvtop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}({\mathit{vcvtop}}, v_1) & = & v & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {\mathrm{zeroop}}({{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}, {\mathit{vcvtop}}) = \mathsf{zero} \\
{\land}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}}(v_1) \\
{\land}~ {{c^\ast}^\ast} = {\Large\times}~({{{\mathrm{lcvtop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}({\mathit{vcvtop}}, c_1)^\ast} \oplus {{}[0]^{M_1}}) \\
{\land}~ v \in {{{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}^{{-1}}}}{({c^\ast})}^\ast} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathsf{vnarrow}}{{{}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}^{{\mathit{sx}}}}}{(v_1, v_2)} & = & v & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}}(v_1) \\
{\land}~ {c_2^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}}(v_2) \\
{\land}~ {{c'}_1^\ast} = {{{{{\mathrm{narrow}}}_{{|{{\mathsf{i}}{N}}_1|}, {|{{\mathsf{i}}{N}}_2|}}^{{\mathit{sx}}}}}{c_1}^\ast} \\
{\land}~ {{c'}_2^\ast} = {{{{{\mathrm{narrow}}}_{{|{{\mathsf{i}}{N}}_1|}, {|{{\mathsf{i}}{N}}_2|}}^{{\mathit{sx}}}}}{c_2}^\ast} \\
{\land}~ v = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}^{{-1}}}}{({{c'}_1^\ast} \oplus {{c'}_2^\ast})} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ivextunop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}({\mathrm{f}}, {\mathit{sx}}, v_1) & = & {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}^{{-1}}}}{({c^\ast})} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}}(v_1) \\
{\land}~ {{c'}_1^\ast} = {{{{{\mathrm{extend}}}_{N_1, N_2}^{{\mathit{sx}}}}}{(c_1)}^\ast} \\
{\land}~ {c^\ast} = {{\mathrm{f}}}_{N_2}({{c'}_1^\ast}) \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ivextbinop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}({\mathrm{f}}, {\mathit{sx}}_1, {\mathit{sx}}_2, i, k, v_1, v_2) & = & {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}^{{-1}}}}{({c^\ast})} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {c_1^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}}(v_1){}[i : k] \\
{\land}~ {c_2^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}}(v_2){}[i : k] \\
{\land}~ {{c'}_1^\ast} = {{{{{\mathrm{extend}}}_{N_1, N_2}^{{\mathit{sx}}_1}}}{(c_1)}^\ast} \\
{\land}~ {{c'}_2^\ast} = {{{{{\mathrm{extend}}}_{N_1, N_2}^{{\mathit{sx}}_2}}}{(c_2)}^\ast} \\
{\land}~ {c^\ast} = {{\mathrm{f}}}_{N_2}({{c'}_1^\ast}, {{c'}_2^\ast}) \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ivadd\_pairwise}}}_{N}({i^\ast}) & = & {{{\mathrm{iadd}}}_{N}(j_1, j_2)^\ast} & \quad \mbox{if}~ {\bigoplus}\, {(j_1~j_2)^\ast} = {i^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ivmul}}}_{N}({i_1^\ast}, {i_2^\ast}) & = & {{{\mathrm{imul}}}_{N}(i_1, i_2)^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ivdot}}}_{N}({i_1^\ast}, {i_2^\ast}) & = & {{{\mathrm{iadd}}}_{N}(j_1, j_2)^\ast} & \quad \mbox{if}~ {\bigoplus}\, {(j_1~j_2)^\ast} = {{{\mathrm{imul}}}_{N}(i_1, i_2)^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{ivdot\_sat}}}_{N}({i_1^\ast}, {i_2^\ast}) & = & {{{\mathrm{iadd\_sat}}}{\mathsf{s}}{{}_{N}(j_1, j_2)}^\ast} & \quad \mbox{if}~ {\bigoplus}\, {(j_1~j_2)^\ast} = {{{\mathrm{imul}}}_{N}(i_1, i_2)^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathsf{extadd\_pairwise}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}(v_1)} & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{{\mathrm{ivextunop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}({\mathrm{ivadd}}_{{\mathit{pairwise}}}, {\mathit{sx}}, v_1) \\
\end{array}
} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathsf{extmul}}{\mathsf{\_}}{{\mathit{half}}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}(v_1, v_2)} & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{{\mathrm{ivextbinop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}({\mathrm{ivmul}}, {\mathit{sx}}, {\mathit{sx}}, {\mathrm{half}}({\mathit{half}}, 0, M_2), M_2, v_1, v_2) \\
\end{array}
} \\
{{\mathsf{dot}}{\mathsf{\_}}{\mathsf{s}}}{{}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}(v_1, v_2)} & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{{\mathrm{ivextbinop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}({\mathrm{ivdot}}, \mathsf{s}, \mathsf{s}, 0, M_1, v_1, v_2) \\
\end{array}
} \\
{{\mathsf{relaxed\_dot}}{\mathsf{\_}}{\mathsf{s}}}{{}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}(v_1, v_2)} & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{{\mathrm{ivextbinop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}({\mathrm{ivdot}}_{{\mathit{sat}}}, \mathsf{s}, {{\mathrm{relaxed}}({\mathrm{R}}_{\mathit{idot}})}{{}[ \mathsf{s}, \mathsf{u} ]}, 0, M_1, v_1, v_2) \\
\end{array}
} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathsf{relaxed\_dot\_add}}{\mathsf{\_}}{\mathsf{s}}}{{}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}(c_1, c_2, c_3)} & = & c & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ N = 2 \cdot N_1 \\
{\land}~ M = 2 \, M_2 \\
{\land}~ {c'} = {{\mathsf{relaxed\_dot}}{\mathsf{\_}}{\mathsf{s}}}{{}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{\mathsf{i}}{N}}{\mathsf{x}}{M}}(c_1, c_2)} \\
{\land}~ {c''} = {{\mathsf{extadd\_pairwise}}{\mathsf{\_}}{\mathsf{s}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}({c'})} \\
{\land}~ c \in {\mathsf{add}}{{}_{{{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}({c''}, c_3)} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(address)} & {\mathit{addr}} & ::= & 0 ~~|~~ 1 ~~|~~ 2 ~~|~~ \dots \\
\mbox{(tag address)} & {\mathit{tagaddr}} & ::= & {\mathit{addr}} \\
\mbox{(global address)} & {\mathit{globaladdr}} & ::= & {\mathit{addr}} \\
\mbox{(memory address)} & {\mathit{memaddr}} & ::= & {\mathit{addr}} \\
\mbox{(table address)} & {\mathit{tableaddr}} & ::= & {\mathit{addr}} \\
\mbox{(function address)} & {\mathit{funcaddr}} & ::= & {\mathit{addr}} \\
\mbox{(data address)} & {\mathit{dataaddr}} & ::= & {\mathit{addr}} \\
\mbox{(elem address)} & {\mathit{elemaddr}} & ::= & {\mathit{addr}} \\
\mbox{(structure address)} & {\mathit{structaddr}} & ::= & {\mathit{addr}} \\
\mbox{(array address)} & {\mathit{arrayaddr}} & ::= & {\mathit{addr}} \\
\mbox{(exception address)} & {\mathit{exnaddr}} & ::= & {\mathit{addr}} \\
\mbox{(host address)} & {\mathit{hostaddr}} & ::= & {\mathit{addr}} \\
\mbox{(external address)} & {\mathit{externaddr}} & ::= & \mathsf{tag}~{\mathit{tagaddr}} ~~|~~ \mathsf{global}~{\mathit{globaladdr}} ~~|~~ \mathsf{mem}~{\mathit{memaddr}} ~~|~~ \mathsf{table}~{\mathit{tableaddr}} ~~|~~ \mathsf{func}~{\mathit{funcaddr}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(number value)} & {\mathit{num}} & ::= & {\mathit{numtype}}{.}\mathsf{const}~{{\mathit{num}}}_{{\mathit{numtype}}} \\
\mbox{(vector value)} & {\mathit{vec}} & ::= & {\mathit{vectype}}{.}\mathsf{const}~{{\mathit{vec}}}_{{\mathit{vectype}}} \\
\mbox{(address value)} & {\mathit{addrref}} & ::= & \mathsf{ref{.}i{\scriptstyle 31}}~{\mathit{u{\kern-0.1em\scriptstyle 31}}} \\
& & | & \mathsf{ref{.}struct}~{\mathit{structaddr}} \\
& & | & \mathsf{ref{.}array}~{\mathit{arrayaddr}} \\
& & | & \mathsf{ref{.}func}~{\mathit{funcaddr}} \\
& & | & \mathsf{ref{.}exn}~{\mathit{exnaddr}} \\
& & | & \mathsf{ref{.}host}~{\mathit{hostaddr}} \\
& & | & \mathsf{ref{.}extern}~{\mathit{addrref}} \\
\mbox{(reference value)} & {\mathit{ref}} & ::= & {\mathit{addrref}} \\
& & | & \mathsf{ref{.}null}~{\mathit{heaptype}} \\
\mbox{(value)} & {\mathit{val}} & ::= & {\mathit{num}} ~~|~~ {\mathit{vec}} ~~|~~ {\mathit{ref}} \\
\mbox{(result)} & {\mathit{result}} & ::= & {{\mathit{val}}^\ast} ~~|~~ ( \mathsf{ref{.}exn\_addr}~{\mathit{exnaddr}} )~\mathsf{throw\_ref} ~~|~~ \mathsf{trap} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(host function)} & {\mathit{hostfunc}} & ::= & \ldots \\
& {\mathit{code}} & ::= & {\mathit{func}} ~~|~~ {\mathit{hostfunc}} \\
\mbox{(tag instance)} & {\mathit{taginst}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{tagtype}} \} \\
\end{array} \\
\mbox{(global instance)} & {\mathit{globalinst}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{globaltype}} ,  \mathsf{value}~{\mathit{val}} \} \\
\end{array} \\
\mbox{(memory instance)} & {\mathit{meminst}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{memtype}} ,  \mathsf{bytes}~{{\mathit{byte}}^\ast} \} \\
\end{array} \\
\mbox{(table instance)} & {\mathit{tableinst}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{tabletype}} ,  \mathsf{refs}~{{\mathit{ref}}^\ast} \} \\
\end{array} \\
\mbox{(function instance)} & {\mathit{funcinst}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{deftype}} ,  \mathsf{module}~{\mathit{moduleinst}} ,  \mathsf{code}~{\mathit{code}} \} \\
\end{array} \\
\mbox{(data instance)} & {\mathit{datainst}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{bytes}~{{\mathit{byte}}^\ast} \} \\
\end{array} \\
\mbox{(element instance)} & {\mathit{eleminst}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{elemtype}} ,  \mathsf{refs}~{{\mathit{ref}}^\ast} \} \\
\end{array} \\
\mbox{(export instance)} & {\mathit{exportinst}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{name}~{\mathit{name}} ,  \mathsf{addr}~{\mathit{externaddr}} \} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(packed value)} & {\mathit{packval}} & ::= & {\mathit{packtype}}{.}\mathsf{pack}~{i}{N} \\
\mbox{(field value)} & {\mathit{fieldval}} & ::= & {\mathit{val}} ~~|~~ {\mathit{packval}} \\
\mbox{(structure instance)} & {\mathit{structinst}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{deftype}} ,  \mathsf{fields}~{{\mathit{fieldval}}^\ast} \} \\
\end{array} \\
\mbox{(array instance)} & {\mathit{arrayinst}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{deftype}} ,  \mathsf{fields}~{{\mathit{fieldval}}^\ast} \} \\
\end{array} \\
\mbox{(exception instance)} & {\mathit{exninst}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{tag}~{\mathit{tagaddr}} ,  \mathsf{fields}~{{\mathit{val}}^\ast} \} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(module instance)} & {\mathit{moduleinst}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{types}~{{\mathit{deftype}}^\ast} \\
\mathsf{tags}~{{\mathit{tagaddr}}^\ast} \\
\mathsf{globals}~{{\mathit{globaladdr}}^\ast} \\
\mathsf{mems}~{{\mathit{memaddr}}^\ast} \\
\mathsf{tables}~{{\mathit{tableaddr}}^\ast} \\
\mathsf{funcs}~{{\mathit{funcaddr}}^\ast} \\
\mathsf{datas}~{{\mathit{dataaddr}}^\ast} \\
\mathsf{elems}~{{\mathit{elemaddr}}^\ast} \\
\mathsf{exports}~{{\mathit{exportinst}}^\ast} \} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(store)} & {\mathit{store}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{tags}~{{\mathit{taginst}}^\ast} \\
\mathsf{globals}~{{\mathit{globalinst}}^\ast} \\
\mathsf{mems}~{{\mathit{meminst}}^\ast} \\
\mathsf{tables}~{{\mathit{tableinst}}^\ast} \\
\mathsf{funcs}~{{\mathit{funcinst}}^\ast} \\
\mathsf{datas}~{{\mathit{datainst}}^\ast} \\
\mathsf{elems}~{{\mathit{eleminst}}^\ast} \\
\mathsf{structs}~{{\mathit{structinst}}^\ast} \\
\mathsf{arrays}~{{\mathit{arrayinst}}^\ast} \\
\mathsf{exns}~{{\mathit{exninst}}^\ast} \} \\
\end{array} \\
\mbox{(frame)} & {\mathit{frame}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{locals}~{({{\mathit{val}}^?})^\ast} ,  \mathsf{module}~{\mathit{moduleinst}} \} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(instruction)} & {\mathit{instr}} & ::= & \dots \\
& & | & {\mathit{addrref}} \\
& & | & {{\mathsf{label}}_{n}}{\{ {{\mathit{instr}}^\ast} \}}~{{\mathit{instr}}^\ast} \\
& & | & {{\mathsf{frame}}_{n}}{\{ {\mathit{frame}} \}}~{{\mathit{instr}}^\ast} \\
& & | & {{\mathsf{handler}}_{n}}{\{ {{\mathit{catch}}^\ast} \}}~{{\mathit{instr}}^\ast} \\
& & | & \mathsf{trap} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(state)} & {\mathit{state}} & ::= & {\mathit{store}} ; {\mathit{frame}} \\
\mbox{(configuration)} & {\mathit{config}} & ::= & {\mathit{state}} ; {{\mathit{instr}}^\ast} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{Ki}} & = & 1024 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{pack}}}_{{\mathit{valtype}}}({\mathit{val}}) & = & {\mathit{val}} \\
{{\mathrm{pack}}}_{{\mathit{packtype}}}(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i) & = & {\mathit{packtype}}{.}\mathsf{pack}~{{\mathrm{wrap}}}_{32, {|{\mathit{packtype}}|}}(i) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{{{\mathrm{unpack}}}_{{\mathit{valtype}}}^{\epsilon}}}{({\mathit{val}})} & = & {\mathit{val}} \\
{{{{\mathrm{unpack}}}_{{\mathit{packtype}}}^{{\mathit{sx}}}}}{({\mathit{packtype}}{.}\mathsf{pack}~i)} & = & \mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~{{{{\mathrm{extend}}}_{{|{\mathit{packtype}}|}, 32}^{{\mathit{sx}}}}}{(i)} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{tags}}(\epsilon) & = & \epsilon \\
{\mathrm{tags}}((\mathsf{tag}~a)~{{\mathit{xa}}^\ast}) & = & a~{\mathrm{tags}}({{\mathit{xa}}^\ast}) \\
{\mathrm{tags}}({\mathit{externaddr}}~{{\mathit{xa}}^\ast}) & = & {\mathrm{tags}}({{\mathit{xa}}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{globals}}(\epsilon) & = & \epsilon \\
{\mathrm{globals}}((\mathsf{global}~a)~{{\mathit{xa}}^\ast}) & = & a~{\mathrm{globals}}({{\mathit{xa}}^\ast}) \\
{\mathrm{globals}}({\mathit{externaddr}}~{{\mathit{xa}}^\ast}) & = & {\mathrm{globals}}({{\mathit{xa}}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{mems}}(\epsilon) & = & \epsilon \\
{\mathrm{mems}}((\mathsf{mem}~a)~{{\mathit{xa}}^\ast}) & = & a~{\mathrm{mems}}({{\mathit{xa}}^\ast}) \\
{\mathrm{mems}}({\mathit{externaddr}}~{{\mathit{xa}}^\ast}) & = & {\mathrm{mems}}({{\mathit{xa}}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{tables}}(\epsilon) & = & \epsilon \\
{\mathrm{tables}}((\mathsf{table}~a)~{{\mathit{xa}}^\ast}) & = & a~{\mathrm{tables}}({{\mathit{xa}}^\ast}) \\
{\mathrm{tables}}({\mathit{externaddr}}~{{\mathit{xa}}^\ast}) & = & {\mathrm{tables}}({{\mathit{xa}}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{funcs}}(\epsilon) & = & \epsilon \\
{\mathrm{funcs}}((\mathsf{func}~a)~{{\mathit{xa}}^\ast}) & = & a~{\mathrm{funcs}}({{\mathit{xa}}^\ast}) \\
{\mathrm{funcs}}({\mathit{externaddr}}~{{\mathit{xa}}^\ast}) & = & {\mathrm{funcs}}({{\mathit{xa}}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{store} & = & s \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{frame} & = & f \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{tags} & = & f{.}\mathsf{module}{.}\mathsf{tags} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{module} & = & f{.}\mathsf{module} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{tags} & = & s{.}\mathsf{tags} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{globals} & = & s{.}\mathsf{globals} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{mems} & = & s{.}\mathsf{mems} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{tables} & = & s{.}\mathsf{tables} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{funcs} & = & s{.}\mathsf{funcs} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{datas} & = & s{.}\mathsf{datas} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{elems} & = & s{.}\mathsf{elems} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{structs} & = & s{.}\mathsf{structs} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{arrays} & = & s{.}\mathsf{arrays} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{exns} & = & s{.}\mathsf{exns} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{types}{}[x] & = & f{.}\mathsf{module}{.}\mathsf{types}{}[x] \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{tags}{}[x] & = & s{.}\mathsf{tags}{}[f{.}\mathsf{module}{.}\mathsf{tags}{}[x]] \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{globals}{}[x] & = & s{.}\mathsf{globals}{}[f{.}\mathsf{module}{.}\mathsf{globals}{}[x]] \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{mems}{}[x] & = & s{.}\mathsf{mems}{}[f{.}\mathsf{module}{.}\mathsf{mems}{}[x]] \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{tables}{}[x] & = & s{.}\mathsf{tables}{}[f{.}\mathsf{module}{.}\mathsf{tables}{}[x]] \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{funcs}{}[x] & = & s{.}\mathsf{funcs}{}[f{.}\mathsf{module}{.}\mathsf{funcs}{}[x]] \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{datas}{}[x] & = & s{.}\mathsf{datas}{}[f{.}\mathsf{module}{.}\mathsf{datas}{}[x]] \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{elems}{}[x] & = & s{.}\mathsf{elems}{}[f{.}\mathsf{module}{.}\mathsf{elems}{}[x]] \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{locals}{}[x] & = & f{.}\mathsf{locals}{}[x] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{locals}{}[x] = v] & = & s ; f{}[{.}\mathsf{locals}{}[x] = v] \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{globals}{}[x]{.}\mathsf{value} = v] & = & s{}[{.}\mathsf{globals}{}[f{.}\mathsf{module}{.}\mathsf{globals}{}[x]]{.}\mathsf{value} = v] ; f \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{tables}{}[x]{.}\mathsf{refs}{}[i] = r] & = & s{}[{.}\mathsf{tables}{}[f{.}\mathsf{module}{.}\mathsf{tables}{}[x]]{.}\mathsf{refs}{}[i] = r] ; f \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{tables}{}[x] = {\mathit{ti}}] & = & s{}[{.}\mathsf{tables}{}[f{.}\mathsf{module}{.}\mathsf{tables}{}[x]] = {\mathit{ti}}] ; f \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i : j] = {b^\ast}] & = & s{}[{.}\mathsf{mems}{}[f{.}\mathsf{module}{.}\mathsf{mems}{}[x]]{.}\mathsf{bytes}{}[i : j] = {b^\ast}] ; f \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{mems}{}[x] = {\mathit{mi}}] & = & s{}[{.}\mathsf{mems}{}[f{.}\mathsf{module}{.}\mathsf{mems}{}[x]] = {\mathit{mi}}] ; f \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{elems}{}[x]{.}\mathsf{refs} = {r^\ast}] & = & s{}[{.}\mathsf{elems}{}[f{.}\mathsf{module}{.}\mathsf{elems}{}[x]]{.}\mathsf{refs} = {r^\ast}] ; f \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{datas}{}[x]{.}\mathsf{bytes} = {b^\ast}] & = & s{}[{.}\mathsf{datas}{}[f{.}\mathsf{module}{.}\mathsf{datas}{}[x]]{.}\mathsf{bytes} = {b^\ast}] ; f \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{structs}{}[a]{.}\mathsf{fields}{}[i] = {\mathit{fv}}] & = & s{}[{.}\mathsf{structs}{}[a]{.}\mathsf{fields}{}[i] = {\mathit{fv}}] ; f \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}{}[i] = {\mathit{fv}}] & = & s{}[{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}{}[i] = {\mathit{fv}}] ; f \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{structs} \mathrel{{=}{\oplus}} {{\mathit{si}}^\ast}] & = & s{}[{.}\mathsf{structs} \mathrel{{=}{\oplus}} {{\mathit{si}}^\ast}] ; f \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{arrays} \mathrel{{=}{\oplus}} {{\mathit{ai}}^\ast}] & = & s{}[{.}\mathsf{arrays} \mathrel{{=}{\oplus}} {{\mathit{ai}}^\ast}] ; f \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{exns} \mathrel{{=}{\oplus}} {{\mathit{exn}}^\ast}] & = & s{}[{.}\mathsf{exns} \mathrel{{=}{\oplus}} {{\mathit{exn}}^\ast}] ; f \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{growtable}}({\mathit{tableinst}}, n, r) & = & {\mathit{tableinst}'} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {\mathit{tableinst}} = \{ \mathsf{type}~({\mathit{at}}~{}[ i .. {j^?} ]~{\mathit{rt}}),\; \mathsf{refs}~{{r'}^\ast} \} \\
{\land}~ {\mathit{tableinst}'} = \{ \mathsf{type}~({\mathit{at}}~{}[ {i'} .. {j^?} ]~{\mathit{rt}}),\; \mathsf{refs}~{{r'}^\ast}~{r^{n}} \} \\
{\land}~ {i'} = {|{{r'}^\ast}|} + n \\
{\land}~ ({i'} \leq j)^? \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{growmem}}({\mathit{meminst}}, n) & = & {\mathit{meminst}'} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {\mathit{meminst}} = \{ \mathsf{type}~({\mathit{at}}~{}[ i .. {j^?} ]~\mathsf{page}),\; \mathsf{bytes}~{b^\ast} \} \\
{\land}~ {\mathit{meminst}'} = \{ \mathsf{type}~({\mathit{at}}~{}[ {i'} .. {j^?} ]~\mathsf{page}),\; \mathsf{bytes}~{b^\ast}~{(\mathtt{0x00})^{n \cdot 64 \, {\mathrm{Ki}}}} \} \\
{\land}~ {i'} = {|{b^\ast}|} / (64 \, {\mathrm{Ki}}) + n \\
{\land}~ ({i'} \leq j)^? \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{default}}}_{{\mathsf{i}}{N}} & = & ({\mathsf{i}}{N}{.}\mathsf{const}~0) \\
{{\mathrm{default}}}_{{\mathsf{f}}{N}} & = & ({\mathsf{f}}{N}{.}\mathsf{const}~{+0}) \\
{{\mathrm{default}}}_{{\mathsf{v}}{N}} & = & ({\mathsf{v}}{N}{.}\mathsf{const}~0) \\
{{\mathrm{default}}}_{\mathsf{ref}~\mathsf{null}~{\mathit{ht}}} & = & (\mathsf{ref{.}null}~{\mathit{ht}}) \\
{{\mathrm{default}}}_{\mathsf{ref}~{\mathit{ht}}} & = & \epsilon \\
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{{\mathrm{default}}}_{t} \neq \epsilon
}{
{{\mathrm{default}}}_{t} \neq \epsilon
} \, {[\textsc{\scriptsize Defaultable}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{{\mathrm{default}}}_{t} = \epsilon
}{
{{\mathrm{default}}}_{t} = \epsilon
} \, {[\textsc{\scriptsize Nondefaultable}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{store}} \vdash {\mathit{num}} : {\mathit{numtype}}}$

$\boxed{{\mathit{store}} \vdash {\mathit{vec}} : {\mathit{vectype}}}$

$\boxed{{\mathit{store}} \vdash {\mathit{ref}} : {\mathit{reftype}}}$

$\boxed{{\mathit{store}} \vdash {\mathit{val}} : {\mathit{valtype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
s \vdash {\mathit{nt}}{.}\mathsf{const}~c : {\mathit{nt}}
} \, {[\textsc{\scriptsize Num\_ok}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
s \vdash {\mathit{vt}}{.}\mathsf{const}~c : {\mathit{vt}}
} \, {[\textsc{\scriptsize Vec\_ok}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\{  \} \vdash {\mathit{ht}'} \leq {\mathit{ht}}
}{
s \vdash \mathsf{ref{.}null}~{\mathit{ht}} : (\mathsf{ref}~\mathsf{null}~{\mathit{ht}'})
} \, {[\textsc{\scriptsize Ref\_ok{-}null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
s \vdash \mathsf{ref{.}i{\scriptstyle 31}}~i : (\mathsf{ref}~\mathsf{i{\scriptstyle 31}})
} \, {[\textsc{\scriptsize Ref\_ok{-}i31}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s{.}\mathsf{structs}{}[a]{.}\mathsf{type} = {\mathit{dt}}
}{
s \vdash \mathsf{ref{.}struct}~a : (\mathsf{ref}~{\mathit{dt}})
} \, {[\textsc{\scriptsize Ref\_ok{-}struct}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s{.}\mathsf{arrays}{}[a]{.}\mathsf{type} = {\mathit{dt}}
}{
s \vdash \mathsf{ref{.}array}~a : (\mathsf{ref}~{\mathit{dt}})
} \, {[\textsc{\scriptsize Ref\_ok{-}array}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s{.}\mathsf{funcs}{}[a]{.}\mathsf{type} = {\mathit{dt}}
}{
s \vdash \mathsf{ref{.}func}~a : (\mathsf{ref}~{\mathit{dt}})
} \, {[\textsc{\scriptsize Ref\_ok{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s{.}\mathsf{exns}{}[a] = {\mathit{exn}}
}{
s \vdash \mathsf{ref{.}exn}~a : (\mathsf{ref}~\mathsf{exn})
} \, {[\textsc{\scriptsize Ref\_ok{-}exn}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
s \vdash \mathsf{ref{.}host}~a : (\mathsf{ref}~\mathsf{any})
} \, {[\textsc{\scriptsize Ref\_ok{-}host}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s \vdash {\mathit{addrref}} : (\mathsf{ref}~\mathsf{any})
}{
s \vdash \mathsf{ref{.}extern}~{\mathit{addrref}} : (\mathsf{ref}~\mathsf{extern})
} \, {[\textsc{\scriptsize Ref\_ok{-}extern}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s \vdash {\mathit{ref}} : {\mathit{rt}'}
 \qquad
\{  \} \vdash {\mathit{rt}'} \leq {\mathit{rt}}
}{
s \vdash {\mathit{ref}} : {\mathit{rt}}
} \, {[\textsc{\scriptsize Ref\_ok{-}sub}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s \vdash {\mathit{num}} : {\mathit{nt}}
}{
s \vdash {\mathit{num}} : {\mathit{nt}}
} \, {[\textsc{\scriptsize Val\_ok{-}num}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s \vdash {\mathit{vec}} : {\mathit{vt}}
}{
s \vdash {\mathit{vec}} : {\mathit{vt}}
} \, {[\textsc{\scriptsize Val\_ok{-}vec}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s \vdash {\mathit{ref}} : {\mathit{rt}}
}{
s \vdash {\mathit{ref}} : {\mathit{rt}}
} \, {[\textsc{\scriptsize Val\_ok{-}ref}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{store}} \vdash {\mathit{externaddr}} : {\mathit{externtype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s{.}\mathsf{tags}{}[a] = {\mathit{taginst}}
}{
s \vdash \mathsf{tag}~a : \mathsf{tag}~{\mathit{taginst}}{.}\mathsf{type}
} \, {[\textsc{\scriptsize Externaddr\_ok{-}tag}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s{.}\mathsf{globals}{}[a] = {\mathit{globalinst}}
}{
s \vdash \mathsf{global}~a : \mathsf{global}~{\mathit{globalinst}}{.}\mathsf{type}
} \, {[\textsc{\scriptsize Externaddr\_ok{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s{.}\mathsf{mems}{}[a] = {\mathit{meminst}}
}{
s \vdash \mathsf{mem}~a : \mathsf{mem}~{\mathit{meminst}}{.}\mathsf{type}
} \, {[\textsc{\scriptsize Externaddr\_ok{-}mem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s{.}\mathsf{tables}{}[a] = {\mathit{tableinst}}
}{
s \vdash \mathsf{table}~a : \mathsf{table}~{\mathit{tableinst}}{.}\mathsf{type}
} \, {[\textsc{\scriptsize Externaddr\_ok{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s{.}\mathsf{funcs}{}[a] = {\mathit{funcinst}}
}{
s \vdash \mathsf{func}~a : \mathsf{func}~{\mathit{funcinst}}{.}\mathsf{type}
} \, {[\textsc{\scriptsize Externaddr\_ok{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s \vdash {\mathit{externaddr}} : {\mathit{xt}'}
 \qquad
\{  \} \vdash {\mathit{xt}'} \leq {\mathit{xt}}
}{
s \vdash {\mathit{externaddr}} : {\mathit{xt}}
} \, {[\textsc{\scriptsize Externaddr\_ok{-}sub}]}
\qquad
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{inst}}}_{{\mathit{moduleinst}}}(t) & = & {t}{{}[ {:=}\, {{\mathit{dt}}^\ast} ]} & \quad \mbox{if}~ {{\mathit{dt}}^\ast} = {\mathit{moduleinst}}{.}\mathsf{types} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{inst}}}_{{\mathit{moduleinst}}}({\mathit{rt}}) & = & {{\mathit{rt}}}{{}[ {:=}\, {{\mathit{dt}}^\ast} ]} & \quad \mbox{if}~ {{\mathit{dt}}^\ast} = {\mathit{moduleinst}}{.}\mathsf{types} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{inst}}}_{{\mathit{moduleinst}}}({\mathit{gt}}) & = & {{\mathit{gt}}}{{}[ {:=}\, {{\mathit{dt}}^\ast} ]} & \quad \mbox{if}~ {{\mathit{dt}}^\ast} = {\mathit{moduleinst}}{.}\mathsf{types} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{inst}}}_{{\mathit{moduleinst}}}({\mathit{mt}}) & = & {{\mathit{mt}}}{{}[ {:=}\, {{\mathit{dt}}^\ast} ]} & \quad \mbox{if}~ {{\mathit{dt}}^\ast} = {\mathit{moduleinst}}{.}\mathsf{types} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{inst}}}_{{\mathit{moduleinst}}}({\mathit{tt}}) & = & {{\mathit{tt}}}{{}[ {:=}\, {{\mathit{dt}}^\ast} ]} & \quad \mbox{if}~ {{\mathit{dt}}^\ast} = {\mathit{moduleinst}}{.}\mathsf{types} \\
\end{array}
$$

$\boxed{{\mathit{config}} \hookrightarrow {\mathit{config}}}$

$\boxed{{{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}}^\ast}}$

$\boxed{{\mathit{config}} \hookrightarrow {{\mathit{instr}}^\ast}}$

$\boxed{{\mathit{config}} \hookrightarrow^\ast {\mathit{config}}}$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}pure}]} \quad & z ; {{\mathit{instr}}^\ast} & \hookrightarrow & z ; {{\mathit{instr}'}^\ast} & \quad \mbox{if}~ {{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\
{[\textsc{\scriptsize E{-}read}]} \quad & z ; {{\mathit{instr}}^\ast} & \hookrightarrow & z ; {{\mathit{instr}'}^\ast} & \quad \mbox{if}~ z ; {{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}refl}]} \quad & z ; {{\mathit{instr}}^\ast} & \hookrightarrow^\ast & z ; {{\mathit{instr}}^\ast} \\
{[\textsc{\scriptsize E{-}trans}]} \quad & z ; {{\mathit{instr}}^\ast} & \hookrightarrow^\ast & {z''} ; {{\mathit{instr}''}^\ast} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ z ; {{\mathit{instr}}^\ast} \hookrightarrow {z'} ; {{\mathit{instr}'}^\ast} \\
{\land}~ {z'} ; {{\mathit{instr}'}^\ast} \hookrightarrow^\ast {z''} ; {{\mathit{instr}''}^\ast} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}ctxt{-}instrs}]} \quad & z ; {{\mathit{val}}^\ast}~{{\mathit{instr}}^\ast}~{{\mathit{instr}}_1^\ast} & \hookrightarrow & {z'} ; {{\mathit{val}}^\ast}~{{\mathit{instr}'}^\ast}~{{\mathit{instr}}_1^\ast} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ z ; {{\mathit{instr}}^\ast} \hookrightarrow {z'} ; {{\mathit{instr}'}^\ast} \\
{\land}~ {{\mathit{val}}^\ast} \neq \epsilon \lor {{\mathit{instr}}_1^\ast} \neq \epsilon \\
\end{array} \\
{[\textsc{\scriptsize E{-}ctxt{-}label}]} \quad & z ; ({{\mathsf{label}}_{n}}{\{ {{\mathit{instr}}_0^\ast} \}}~{{\mathit{instr}}^\ast}) & \hookrightarrow & {z'} ; ({{\mathsf{label}}_{n}}{\{ {{\mathit{instr}}_0^\ast} \}}~{{\mathit{instr}'}^\ast}) & \quad \mbox{if}~ z ; {{\mathit{instr}}^\ast} \hookrightarrow {z'} ; {{\mathit{instr}'}^\ast} \\
{[\textsc{\scriptsize E{-}ctxt{-}frame}]} \quad & s ; f ; ({{\mathsf{frame}}_{n}}{\{ {f'} \}}~{{\mathit{instr}}^\ast}) & \hookrightarrow & {s'} ; f ; ({{\mathsf{frame}}_{n}}{\{ {f''} \}}~{{\mathit{instr}'}^\ast}) & \quad \mbox{if}~ s ; {f'} ; {{\mathit{instr}}^\ast} \hookrightarrow {s'} ; {f''} ; {{\mathit{instr}'}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}unreachable}]} \quad & \mathsf{unreachable} & \hookrightarrow & \mathsf{trap} \\
{[\textsc{\scriptsize E{-}nop}]} \quad & \mathsf{nop} & \hookrightarrow & \epsilon \\
{[\textsc{\scriptsize E{-}drop}]} \quad & {\mathit{val}}~\mathsf{drop} & \hookrightarrow & \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}select{-}true}]} \quad & {\mathit{val}}_1~{\mathit{val}}_2~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)~(\mathsf{select}~{({t^\ast})^?}) & \hookrightarrow & {\mathit{val}}_1 & \quad \mbox{if}~ c \neq 0 \\
{[\textsc{\scriptsize E{-}select{-}false}]} \quad & {\mathit{val}}_1~{\mathit{val}}_2~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)~(\mathsf{select}~{({t^\ast})^?}) & \hookrightarrow & {\mathit{val}}_2 & \quad \mbox{if}~ c = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{blocktype}}}_{z}(x) & = & {t_1^\ast} \rightarrow {t_2^\ast} & \quad \mbox{if}~ z{.}\mathsf{types}{}[x] \approx \mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast} \\
{{\mathrm{blocktype}}}_{z}({t^?}) & = & \epsilon \rightarrow {t^?} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}block}]} \quad & z ; {{\mathit{val}}^{m}}~(\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}^\ast}) & \hookrightarrow & ({{\mathsf{label}}_{n}}{\{ \epsilon \}}~{{\mathit{val}}^{m}}~{{\mathit{instr}}^\ast}) & \quad \mbox{if}~ {{\mathrm{blocktype}}}_{z}({\mathit{bt}}) = {t_1^{m}} \rightarrow {t_2^{n}} \\
{[\textsc{\scriptsize E{-}loop}]} \quad & z ; {{\mathit{val}}^{m}}~(\mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast}) & \hookrightarrow & ({{\mathsf{label}}_{m}}{\{ \mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast} \}}~{{\mathit{val}}^{m}}~{{\mathit{instr}}^\ast}) & \quad \mbox{if}~ {{\mathrm{blocktype}}}_{z}({\mathit{bt}}) = {t_1^{m}} \rightarrow {t_2^{n}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}if{-}true}]} \quad & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)~(\mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_1^\ast}~\mathsf{else}~{{\mathit{instr}}_2^\ast}) & \hookrightarrow & (\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}_1^\ast}) & \quad \mbox{if}~ c \neq 0 \\
{[\textsc{\scriptsize E{-}if{-}false}]} \quad & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)~(\mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_1^\ast}~\mathsf{else}~{{\mathit{instr}}_2^\ast}) & \hookrightarrow & (\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}_2^\ast}) & \quad \mbox{if}~ c = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}label{-}vals}]} \quad & ({{\mathsf{label}}_{n}}{\{ {{\mathit{instr}}^\ast} \}}~{{\mathit{val}}^\ast}) & \hookrightarrow & {{\mathit{val}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}br{-}label{-}zero}]} \quad & ({{\mathsf{label}}_{n}}{\{ {{\mathit{instr}'}^\ast} \}}~{{\mathit{val}'}^\ast}~{{\mathit{val}}^{n}}~(\mathsf{br}~l)~{{\mathit{instr}}^\ast}) & \hookrightarrow & {{\mathit{val}}^{n}}~{{\mathit{instr}'}^\ast} & \quad \mbox{if}~ l = 0 \\
{[\textsc{\scriptsize E{-}br{-}label{-}succ}]} \quad & ({{\mathsf{label}}_{n}}{\{ {{\mathit{instr}'}^\ast} \}}~{{\mathit{val}}^\ast}~(\mathsf{br}~l)~{{\mathit{instr}}^\ast}) & \hookrightarrow & {{\mathit{val}}^\ast}~(\mathsf{br}~l - 1) & \quad \mbox{if}~ l > 0 \\
{[\textsc{\scriptsize E{-}br{-}handler}]} \quad & ({{\mathsf{handler}}_{n}}{\{ {{\mathit{catch}}^\ast} \}}~{{\mathit{val}}^\ast}~(\mathsf{br}~l)~{{\mathit{instr}}^\ast}) & \hookrightarrow & {{\mathit{val}}^\ast}~(\mathsf{br}~l) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_if{-}true}]} \quad & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)~(\mathsf{br\_if}~l) & \hookrightarrow & (\mathsf{br}~l) & \quad \mbox{if}~ c \neq 0 \\
{[\textsc{\scriptsize E{-}br\_if{-}false}]} \quad & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)~(\mathsf{br\_if}~l) & \hookrightarrow & \epsilon & \quad \mbox{if}~ c = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_table{-}lt}]} \quad & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{br\_table}~{l^\ast}~{l'}) & \hookrightarrow & (\mathsf{br}~{l^\ast}{}[i]) & \quad \mbox{if}~ i < {|{l^\ast}|} \\
{[\textsc{\scriptsize E{-}br\_table{-}ge}]} \quad & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{br\_table}~{l^\ast}~{l'}) & \hookrightarrow & (\mathsf{br}~{l'}) & \quad \mbox{if}~ i \geq {|{l^\ast}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_null{-}null}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_null}~l) & \hookrightarrow & (\mathsf{br}~l) & \quad \mbox{if}~ {\mathit{val}} = \mathsf{ref{.}null}~{\mathit{ht}} \\
{[\textsc{\scriptsize E{-}br\_on\_null{-}addr}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_null}~l) & \hookrightarrow & {\mathit{val}} & \quad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_non\_null{-}null}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_non\_null}~l) & \hookrightarrow & \epsilon & \quad \mbox{if}~ {\mathit{val}} = \mathsf{ref{.}null}~{\mathit{ht}} \\
{[\textsc{\scriptsize E{-}br\_on\_non\_null{-}addr}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_non\_null}~l) & \hookrightarrow & {\mathit{val}}~(\mathsf{br}~l) & \quad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_cast{-}succeed}]} \quad & s ; f ; {\mathit{ref}}~(\mathsf{br\_on\_cast}~l~{\mathit{rt}}_1~{\mathit{rt}}_2) & \hookrightarrow & {\mathit{ref}}~(\mathsf{br}~l) & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ s \vdash {\mathit{ref}} : {\mathit{rt}} \\
{\land}~ \{  \} \vdash {\mathit{rt}} \leq {{\mathrm{inst}}}_{f{.}\mathsf{module}}({\mathit{rt}}_2) \\
\end{array} \\
{[\textsc{\scriptsize E{-}br\_on\_cast{-}fail}]} \quad & s ; f ; {\mathit{ref}}~(\mathsf{br\_on\_cast}~l~{\mathit{rt}}_1~{\mathit{rt}}_2) & \hookrightarrow & {\mathit{ref}} & \quad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_cast\_fail{-}succeed}]} \quad & s ; f ; {\mathit{ref}}~(\mathsf{br\_on\_cast\_fail}~l~{\mathit{rt}}_1~{\mathit{rt}}_2) & \hookrightarrow & {\mathit{ref}} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ s \vdash {\mathit{ref}} : {\mathit{rt}} \\
{\land}~ \{  \} \vdash {\mathit{rt}} \leq {{\mathrm{inst}}}_{f{.}\mathsf{module}}({\mathit{rt}}_2) \\
\end{array} \\
{[\textsc{\scriptsize E{-}br\_on\_cast\_fail{-}fail}]} \quad & s ; f ; {\mathit{ref}}~(\mathsf{br\_on\_cast\_fail}~l~{\mathit{rt}}_1~{\mathit{rt}}_2) & \hookrightarrow & {\mathit{ref}}~(\mathsf{br}~l) & \quad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}call}]} \quad & z ; (\mathsf{call}~x) & \hookrightarrow & (\mathsf{ref{.}func}~a)~(\mathsf{call\_ref}~z{.}\mathsf{funcs}{}[a]{.}\mathsf{type}) & \quad \mbox{if}~ z{.}\mathsf{module}{.}\mathsf{funcs}{}[x] = a \\
{[\textsc{\scriptsize E{-}call\_ref{-}null}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}})~(\mathsf{call\_ref}~y) & \hookrightarrow & \mathsf{trap} \\
{[\textsc{\scriptsize E{-}call\_ref{-}func}]} \quad & z ; {{\mathit{val}}^{n}}~(\mathsf{ref{.}func}~a)~(\mathsf{call\_ref}~y) & \hookrightarrow & ({{\mathsf{frame}}_{m}}{\{ f \}}~({{\mathsf{label}}_{m}}{\{ \epsilon \}}~{{\mathit{instr}}^\ast})) &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ z{.}\mathsf{funcs}{}[a] = {\mathit{fi}} \\
{\land}~ {\mathit{fi}}{.}\mathsf{type} \approx \mathsf{func}~{t_1^{n}} \rightarrow {t_2^{m}} \\
{\land}~ {\mathit{fi}}{.}\mathsf{code} = \mathsf{func}~x~{(\mathsf{local}~t)^\ast}~({{\mathit{instr}}^\ast}) \\
{\land}~ f = \{ \mathsf{locals}~{{\mathit{val}}^{n}}~{({{\mathrm{default}}}_{t})^\ast},\;\allowbreak \mathsf{module}~{\mathit{fi}}{.}\mathsf{module} \} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}return\_call}]} \quad & z ; (\mathsf{return\_call}~x) & \hookrightarrow & (\mathsf{ref{.}func}~a)~(\mathsf{return\_call\_ref}~z{.}\mathsf{funcs}{}[a]{.}\mathsf{type}) & \quad \mbox{if}~ z{.}\mathsf{module}{.}\mathsf{funcs}{}[x] = a \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}return\_call\_ref{-}label}]} \quad & z ; ({{\mathsf{label}}_{k}}{\{ {{\mathit{instr}'}^\ast} \}}~{{\mathit{val}}^\ast}~(\mathsf{return\_call\_ref}~y)~{{\mathit{instr}}^\ast}) & \hookrightarrow & {{\mathit{val}}^\ast}~(\mathsf{return\_call\_ref}~y) \\
{[\textsc{\scriptsize E{-}return\_call\_ref{-}handler}]} \quad & z ; ({{\mathsf{handler}}_{k}}{\{ {{\mathit{catch}}^\ast} \}}~{{\mathit{val}}^\ast}~(\mathsf{return\_call\_ref}~y)~{{\mathit{instr}}^\ast}) & \hookrightarrow & {{\mathit{val}}^\ast}~(\mathsf{return\_call\_ref}~y) \\
{[\textsc{\scriptsize E{-}return\_call\_ref{-}frame{-}null}]} \quad & z ; ({{\mathsf{frame}}_{k}}{\{ f \}}~{{\mathit{val}}^\ast}~(\mathsf{ref{.}null}~{\mathit{ht}})~(\mathsf{return\_call\_ref}~y)~{{\mathit{instr}}^\ast}) & \hookrightarrow & \mathsf{trap} \\
{[\textsc{\scriptsize E{-}return\_call\_ref{-}frame{-}addr}]} \quad & z ; ({{\mathsf{frame}}_{k}}{\{ f \}}~{{\mathit{val}'}^\ast}~{{\mathit{val}}^{n}}~(\mathsf{ref{.}func}~a)~(\mathsf{return\_call\_ref}~y)~{{\mathit{instr}}^\ast}) & \hookrightarrow & {{\mathit{val}}^{n}}~(\mathsf{ref{.}func}~a)~(\mathsf{call\_ref}~y) &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ z{.}\mathsf{funcs}{}[a]{.}\mathsf{type} \approx \mathsf{func}~{t_1^{n}} \rightarrow {t_2^{m}}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}call\_indirect}]} \quad & (\mathsf{call\_indirect}~x~y) & \hookrightarrow & (\mathsf{table{.}get}~x)~(\mathsf{ref{.}cast}~(\mathsf{ref}~\mathsf{null}~y))~(\mathsf{call\_ref}~y) \\
{[\textsc{\scriptsize E{-}return\_call\_indirect}]} \quad & (\mathsf{return\_call\_indirect}~x~y) & \hookrightarrow & (\mathsf{table{.}get}~x)~(\mathsf{ref{.}cast}~(\mathsf{ref}~\mathsf{null}~y))~(\mathsf{return\_call\_ref}~y) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}frame{-}vals}]} \quad & ({{\mathsf{frame}}_{n}}{\{ f \}}~{{\mathit{val}}^{n}}) & \hookrightarrow & {{\mathit{val}}^{n}} \\
{[\textsc{\scriptsize E{-}return{-}frame}]} \quad & ({{\mathsf{frame}}_{n}}{\{ f \}}~{{\mathit{val}'}^\ast}~{{\mathit{val}}^{n}}~\mathsf{return}~{{\mathit{instr}}^\ast}) & \hookrightarrow & {{\mathit{val}}^{n}} \\
{[\textsc{\scriptsize E{-}return{-}label}]} \quad & ({{\mathsf{label}}_{n}}{\{ {{\mathit{instr}'}^\ast} \}}~{{\mathit{val}}^\ast}~\mathsf{return}~{{\mathit{instr}}^\ast}) & \hookrightarrow & {{\mathit{val}}^\ast}~\mathsf{return} \\
{[\textsc{\scriptsize E{-}return{-}handler}]} \quad & ({{\mathsf{handler}}_{n}}{\{ {{\mathit{catch}}^\ast} \}}~{{\mathit{val}}^\ast}~\mathsf{return}~{{\mathit{instr}}^\ast}) & \hookrightarrow & {{\mathit{val}}^\ast}~\mathsf{return} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}throw}]} \quad & z ; {{\mathit{val}}^{n}}~(\mathsf{throw}~x) & \hookrightarrow & z{}[{.}\mathsf{exns} \mathrel{{=}{\oplus}} {\mathit{exn}}] ; (\mathsf{ref{.}exn}~a)~\mathsf{throw\_ref} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ z{.}\mathsf{tags}{}[x]{.}\mathsf{type} \approx \mathsf{func}~{t^{n}} \rightarrow \epsilon \\
{\land}~ a = {|z{.}\mathsf{exns}|} \\
{\land}~ {\mathit{exn}} = \{ \mathsf{tag}~z{.}\mathsf{tags}{}[x],\;\allowbreak \mathsf{fields}~{{\mathit{val}}^{n}} \} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}throw\_ref{-}null}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}})~\mathsf{throw\_ref} & \hookrightarrow & \mathsf{trap} \\
{[\textsc{\scriptsize E{-}throw\_ref{-}instrs}]} \quad & z ; {{\mathit{val}}^\ast}~(\mathsf{ref{.}exn}~a)~\mathsf{throw\_ref}~{{\mathit{instr}}^\ast} & \hookrightarrow & (\mathsf{ref{.}exn}~a)~\mathsf{throw\_ref} &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ {{\mathit{val}}^\ast} \neq \epsilon \lor {{\mathit{instr}}^\ast} \neq \epsilon
} \\
{[\textsc{\scriptsize E{-}throw\_ref{-}label}]} \quad & z ; ({{\mathsf{label}}_{n}}{\{ {{\mathit{instr}'}^\ast} \}}~(\mathsf{ref{.}exn}~a)~\mathsf{throw\_ref}) & \hookrightarrow & (\mathsf{ref{.}exn}~a)~\mathsf{throw\_ref} \\
{[\textsc{\scriptsize E{-}throw\_ref{-}frame}]} \quad & z ; ({{\mathsf{frame}}_{n}}{\{ f \}}~(\mathsf{ref{.}exn}~a)~\mathsf{throw\_ref}) & \hookrightarrow & (\mathsf{ref{.}exn}~a)~\mathsf{throw\_ref} \\
{[\textsc{\scriptsize E{-}throw\_ref{-}handler{-}empty}]} \quad & z ; ({{\mathsf{handler}}_{n}}{\{ \epsilon \}}~(\mathsf{ref{.}exn}~a)~\mathsf{throw\_ref}) & \hookrightarrow & (\mathsf{ref{.}exn}~a)~\mathsf{throw\_ref} \\
{[\textsc{\scriptsize E{-}throw\_ref{-}handler{-}catch}]} \quad & z ; ({{\mathsf{handler}}_{n}}{\{ (\mathsf{catch}~x~l)~{{\mathit{catch}'}^\ast} \}}~(\mathsf{ref{.}exn}~a)~\mathsf{throw\_ref}) & \hookrightarrow & {{\mathit{val}}^\ast}~(\mathsf{br}~l) &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ z{.}\mathsf{exns}{}[a]{.}\mathsf{tag} = z{.}\mathsf{tags}{}[x] \\
{\land}~ {{\mathit{val}}^\ast} = z{.}\mathsf{exns}{}[a]{.}\mathsf{fields} \\
\end{array}
} \\
{[\textsc{\scriptsize E{-}throw\_ref{-}handler{-}catch\_ref}]} \quad & z ; ({{\mathsf{handler}}_{n}}{\{ (\mathsf{catch\_ref}~x~l)~{{\mathit{catch}'}^\ast} \}}~(\mathsf{ref{.}exn}~a)~\mathsf{throw\_ref}) & \hookrightarrow & {{\mathit{val}}^\ast}~(\mathsf{ref{.}exn}~a)~(\mathsf{br}~l) &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ z{.}\mathsf{exns}{}[a]{.}\mathsf{tag} = z{.}\mathsf{tags}{}[x] \\
{\land}~ {{\mathit{val}}^\ast} = z{.}\mathsf{exns}{}[a]{.}\mathsf{fields} \\
\end{array}
} \\
{[\textsc{\scriptsize E{-}throw\_ref{-}handler{-}catch\_all}]} \quad & z ; ({{\mathsf{handler}}_{n}}{\{ (\mathsf{catch\_all}~l)~{{\mathit{catch}'}^\ast} \}}~(\mathsf{ref{.}exn}~a)~\mathsf{throw\_ref}) & \hookrightarrow & (\mathsf{br}~l) \\
{[\textsc{\scriptsize E{-}throw\_ref{-}handler{-}catch\_all\_ref}]} \quad & z ; ({{\mathsf{handler}}_{n}}{\{ (\mathsf{catch\_all\_ref}~l)~{{\mathit{catch}'}^\ast} \}}~(\mathsf{ref{.}exn}~a)~\mathsf{throw\_ref}) & \hookrightarrow & (\mathsf{ref{.}exn}~a)~(\mathsf{br}~l) \\
{[\textsc{\scriptsize E{-}throw\_ref{-}handler{-}next}]} \quad & z ; ({{\mathsf{handler}}_{n}}{\{ {\mathit{catch}}~{{\mathit{catch}'}^\ast} \}}~(\mathsf{ref{.}exn}~a)~\mathsf{throw\_ref}) & \hookrightarrow & ({{\mathsf{handler}}_{n}}{\{ {{\mathit{catch}'}^\ast} \}}~(\mathsf{ref{.}exn}~a)~\mathsf{throw\_ref}) &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{otherwise}
} \\
{[\textsc{\scriptsize E{-}try\_table}]} \quad & z ; {{\mathit{val}}^{m}}~(\mathsf{try\_table}~{\mathit{bt}}~{{\mathit{catch}}^\ast}~{{\mathit{instr}}^\ast}) & \hookrightarrow & ({{\mathsf{handler}}_{n}}{\{ {{\mathit{catch}}^\ast} \}}~({{\mathsf{label}}_{n}}{\{ \epsilon \}}~{{\mathit{val}}^{m}}~{{\mathit{instr}}^\ast})) &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ {{\mathrm{blocktype}}}_{z}({\mathit{bt}}) = {t_1^{m}} \rightarrow {t_2^{n}}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}handler{-}vals}]} \quad & ({{\mathsf{handler}}_{n}}{\{ {{\mathit{catch}}^\ast} \}}~{{\mathit{val}}^\ast}) & \hookrightarrow & {{\mathit{val}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}trap{-}instrs}]} \quad & {{\mathit{val}}^\ast}~\mathsf{trap}~{{\mathit{instr}}^\ast} & \hookrightarrow & \mathsf{trap} & \quad \mbox{if}~ {{\mathit{val}}^\ast} \neq \epsilon \lor {{\mathit{instr}}^\ast} \neq \epsilon \\
{[\textsc{\scriptsize E{-}trap{-}label}]} \quad & ({{\mathsf{label}}_{n}}{\{ {{\mathit{instr}'}^\ast} \}}~\mathsf{trap}) & \hookrightarrow & \mathsf{trap} \\
{[\textsc{\scriptsize E{-}trap{-}frame}]} \quad & ({{\mathsf{frame}}_{n}}{\{ f \}}~\mathsf{trap}) & \hookrightarrow & \mathsf{trap} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}local.get}]} \quad & z ; (\mathsf{local{.}get}~x) & \hookrightarrow & {\mathit{val}} & \quad \mbox{if}~ z{.}\mathsf{locals}{}[x] = {\mathit{val}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}local.set}]} \quad & z ; {\mathit{val}}~(\mathsf{local{.}set}~x) & \hookrightarrow & z{}[{.}\mathsf{locals}{}[x] = {\mathit{val}}] ; \epsilon \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}local.tee}]} \quad & {\mathit{val}}~(\mathsf{local{.}tee}~x) & \hookrightarrow & {\mathit{val}}~{\mathit{val}}~(\mathsf{local{.}set}~x) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}global.get}]} \quad & z ; (\mathsf{global{.}get}~x) & \hookrightarrow & {\mathit{val}} & \quad \mbox{if}~ z{.}\mathsf{globals}{}[x]{.}\mathsf{value} = {\mathit{val}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}global.set}]} \quad & z ; {\mathit{val}}~(\mathsf{global{.}set}~x) & \hookrightarrow & z{}[{.}\mathsf{globals}{}[x]{.}\mathsf{value} = {\mathit{val}}] ; \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.get{-}oob}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~(\mathsf{table{.}get}~x) & \hookrightarrow & \mathsf{trap} & \quad \mbox{if}~ i \geq {|z{.}\mathsf{tables}{}[x]{.}\mathsf{refs}|} \\
{[\textsc{\scriptsize E{-}table.get{-}val}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~(\mathsf{table{.}get}~x) & \hookrightarrow & z{.}\mathsf{tables}{}[x]{.}\mathsf{refs}{}[i] & \quad \mbox{if}~ i < {|z{.}\mathsf{tables}{}[x]{.}\mathsf{refs}|} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.set{-}oob}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~{\mathit{ref}}~(\mathsf{table{.}set}~x) & \hookrightarrow & z ; \mathsf{trap} & \quad \mbox{if}~ i \geq {|z{.}\mathsf{tables}{}[x]{.}\mathsf{refs}|} \\
{[\textsc{\scriptsize E{-}table.set{-}val}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~{\mathit{ref}}~(\mathsf{table{.}set}~x) & \hookrightarrow & z{}[{.}\mathsf{tables}{}[x]{.}\mathsf{refs}{}[i] = {\mathit{ref}}] ; \epsilon & \quad \mbox{if}~ i < {|z{.}\mathsf{tables}{}[x]{.}\mathsf{refs}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.size}]} \quad & z ; (\mathsf{table{.}size}~x) & \hookrightarrow & ({\mathit{at}}{.}\mathsf{const}~n) & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {|z{.}\mathsf{tables}{}[x]{.}\mathsf{refs}|} = n \\
{\land}~ z{.}\mathsf{tables}{}[x]{.}\mathsf{type} = {\mathit{at}}~{\mathit{lim}}~{\mathit{rt}} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.grow{-}succeed}]} \quad & z ; {\mathit{ref}}~({\mathit{at}}{.}\mathsf{const}~n)~(\mathsf{table{.}grow}~x) & \hookrightarrow & z{}[{.}\mathsf{tables}{}[x] = {\mathit{ti}}] ; ({\mathit{at}}{.}\mathsf{const}~{|z{.}\mathsf{tables}{}[x]{.}\mathsf{refs}|}) &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ {\mathit{ti}} = {\mathrm{growtable}}(z{.}\mathsf{tables}{}[x], n, {\mathit{ref}})
} \\
{[\textsc{\scriptsize E{-}table.grow{-}fail}]} \quad & z ; {\mathit{ref}}~({\mathit{at}}{.}\mathsf{const}~n)~(\mathsf{table{.}grow}~x) & \hookrightarrow & z ; ({\mathit{at}}{.}\mathsf{const}~{{{{\mathrm{signed}}}_{{|{\mathit{at}}|}}^{{-1}}}}{({-1})}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.fill{-}oob}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~{\mathit{val}}~({\mathit{at}}{.}\mathsf{const}~n)~(\mathsf{table{.}fill}~x) & \hookrightarrow & \mathsf{trap} & \quad \mbox{if}~ i + n > {|z{.}\mathsf{tables}{}[x]{.}\mathsf{refs}|} \\
{[\textsc{\scriptsize E{-}table.fill{-}zero}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~{\mathit{val}}~({\mathit{at}}{.}\mathsf{const}~n)~(\mathsf{table{.}fill}~x) & \hookrightarrow & \epsilon & \quad \mbox{otherwise, if}~ n = 0 \\
{[\textsc{\scriptsize E{-}table.fill{-}succ}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~{\mathit{val}}~({\mathit{at}}{.}\mathsf{const}~n)~(\mathsf{table{.}fill}~x) & \hookrightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} ({\mathit{at}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{table{.}set}~x) \\
  ({\mathit{at}}{.}\mathsf{const}~i + 1)~{\mathit{val}}~({\mathit{at}}{.}\mathsf{const}~n - 1)~(\mathsf{table{.}fill}~x) \end{array} & \quad \mbox{otherwise} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.copy{-}oob}]} \quad & z ; ({\mathit{at}}_1{.}\mathsf{const}~i_1)~({\mathit{at}}_2{.}\mathsf{const}~i_2)~({\mathit{at}'}{.}\mathsf{const}~n)~(\mathsf{table{.}copy}~x_1~x_2) & \hookrightarrow & \mathsf{trap} &  \\
& \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{if}~ i_1 + n > {|z{.}\mathsf{tables}{}[x_1]{.}\mathsf{refs}|} \lor i_2 + n > {|z{.}\mathsf{tables}{}[x_2]{.}\mathsf{refs}|}
} \\
{[\textsc{\scriptsize E{-}table.copy{-}zero}]} \quad & z ; ({\mathit{at}}_1{.}\mathsf{const}~i_1)~({\mathit{at}}_2{.}\mathsf{const}~i_2)~({\mathit{at}'}{.}\mathsf{const}~n)~(\mathsf{table{.}copy}~x~y) & \hookrightarrow & \epsilon & \quad \mbox{otherwise, if}~ n = 0 \\
{[\textsc{\scriptsize E{-}table.copy{-}le}]} \quad & z ; ({\mathit{at}}_1{.}\mathsf{const}~i_1)~({\mathit{at}}_2{.}\mathsf{const}~i_2)~({\mathit{at}'}{.}\mathsf{const}~n)~(\mathsf{table{.}copy}~x~y) & \hookrightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} ({\mathit{at}}_1{.}\mathsf{const}~i_1)~({\mathit{at}}_2{.}\mathsf{const}~i_2)~(\mathsf{table{.}get}~y)~(\mathsf{table{.}set}~x) \\
  ({\mathit{at}}_1{.}\mathsf{const}~i_1 + 1)~({\mathit{at}}_2{.}\mathsf{const}~i_2 + 1)~({\mathit{at}'}{.}\mathsf{const}~n - 1)~(\mathsf{table{.}copy}~x~y) \end{array} & \quad \mbox{otherwise, if}~ i_1 \leq i_2 \\
\end{array}
} \\
{[\textsc{\scriptsize E{-}table.copy{-}gt}]} \quad & z ; ({\mathit{at}}_1{.}\mathsf{const}~i_1)~({\mathit{at}}_2{.}\mathsf{const}~i_2)~({\mathit{at}'}{.}\mathsf{const}~n)~(\mathsf{table{.}copy}~x~y) & \hookrightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} ({\mathit{at}}_1{.}\mathsf{const}~i_1 + n - 1)~({\mathit{at}}_2{.}\mathsf{const}~i_2 + n - 1)~(\mathsf{table{.}get}~y)~(\mathsf{table{.}set}~x) \\
  ({\mathit{at}}_1{.}\mathsf{const}~i_1)~({\mathit{at}}_2{.}\mathsf{const}~i_2)~({\mathit{at}'}{.}\mathsf{const}~n - 1)~(\mathsf{table{.}copy}~x~y) \end{array} & \quad \mbox{otherwise} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.init{-}oob}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{table{.}init}~x~y) & \hookrightarrow & \mathsf{trap} &  \\
& \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{if}~ i + n > {|z{.}\mathsf{tables}{}[x]{.}\mathsf{refs}|} \lor j + n > {|z{.}\mathsf{elems}{}[y]{.}\mathsf{refs}|}
} \\
{[\textsc{\scriptsize E{-}table.init{-}zero}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{table{.}init}~x~y) & \hookrightarrow & \epsilon & \quad \mbox{otherwise, if}~ n = 0 \\
{[\textsc{\scriptsize E{-}table.init{-}succ}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{table{.}init}~x~y) & \hookrightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} ({\mathit{at}}{.}\mathsf{const}~i)~z{.}\mathsf{elems}{}[y]{.}\mathsf{refs}{}[j]~(\mathsf{table{.}set}~x) \\
  ({\mathit{at}}{.}\mathsf{const}~i + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{table{.}init}~x~y) \end{array} & \quad \mbox{otherwise} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}elem.drop}]} \quad & z ; (\mathsf{elem{.}drop}~x) & \hookrightarrow & z{}[{.}\mathsf{elems}{}[x]{.}\mathsf{refs} = \epsilon] ; \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}load{-}num{-}oob}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~({\mathit{nt}}{.}\mathsf{load}~x~{\mathit{ao}}) & \hookrightarrow & \mathsf{trap} &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ i + {\mathit{ao}}{.}\mathsf{offset} + {|{\mathit{nt}}|} / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|}
} \\
{[\textsc{\scriptsize E{-}load{-}num{-}val}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~({\mathit{nt}}{.}\mathsf{load}~x~{\mathit{ao}}) & \hookrightarrow & ({\mathit{nt}}{.}\mathsf{const}~c) &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ {{\mathrm{bytes}}}_{{\mathit{nt}}}(c) = z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : {|{\mathit{nt}}|} / 8]
} \\
{[\textsc{\scriptsize E{-}load{-}pack{-}oob}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~({{\mathsf{i}}{N}{.}\mathsf{load}}{{n}{\mathsf{\_}}{{\mathit{sx}}}}~x~{\mathit{ao}}) & \hookrightarrow & \mathsf{trap} &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ i + {\mathit{ao}}{.}\mathsf{offset} + n / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|}
} \\
{[\textsc{\scriptsize E{-}load{-}pack{-}val}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~({{\mathsf{i}}{N}{.}\mathsf{load}}{{n}{\mathsf{\_}}{{\mathit{sx}}}}~x~{\mathit{ao}}) & \hookrightarrow & ({\mathsf{i}}{N}{.}\mathsf{const}~{{{{\mathrm{extend}}}_{n, {|{\mathsf{i}}{N}|}}^{{\mathit{sx}}}}}{(c)}) &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ {{\mathrm{bytes}}}_{{\mathsf{i}}{n}}(c) = z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : n / 8]
} \\
{[\textsc{\scriptsize E{-}vload{-}oob}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}~x~{\mathit{ao}}) & \hookrightarrow & \mathsf{trap} & \quad \mbox{if}~ i + {\mathit{ao}}{.}\mathsf{offset} + {|\mathsf{v{\scriptstyle 128}}|} / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}vload{-}val}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}~x~{\mathit{ao}}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) & \quad \mbox{if}~ {{\mathrm{bytes}}}_{\mathsf{v{\scriptstyle 128}}}(c) = z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : {|\mathsf{v{\scriptstyle 128}}|} / 8] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vload{-}pack{-}oob}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{M}{\mathsf{x}}{K}{\mathsf{\_}}{{\mathit{sx}}}}~x~{\mathit{ao}}) & \hookrightarrow & \mathsf{trap} & \quad \mbox{if}~ i + {\mathit{ao}}{.}\mathsf{offset} + M \cdot K / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}vload{-}pack{-}val}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{M}{\mathsf{x}}{K}{\mathsf{\_}}{{\mathit{sx}}}}~x~{\mathit{ao}}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) &  \\
& \multicolumn{4}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ ({{\mathrm{bytes}}}_{{\mathsf{i}}{M}}(j) = z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} + k \cdot M / 8 : M / 8])^{k<K} \\
{\land}~ c = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{K}}^{{-1}}}}{({{{{{\mathrm{extend}}}_{M, N}^{{\mathit{sx}}}}}{(j)}^{K}})} \land N = M \cdot 2 \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vload{-}splat{-}oob}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{N}{\mathsf{\_}}{\mathsf{splat}}}~x~{\mathit{ao}}) & \hookrightarrow & \mathsf{trap} & \quad \mbox{if}~ i + {\mathit{ao}}{.}\mathsf{offset} + N / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}vload{-}splat{-}val}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{N}{\mathsf{\_}}{\mathsf{splat}}}~x~{\mathit{ao}}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {{\mathrm{bytes}}}_{{\mathsf{i}}{N}}(j) = z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : N / 8] \\
{\land}~ N = {|{\mathsf{i}}{N}|} \\
{\land}~ M = 128 / N \\
{\land}~ c = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({j^{M}})} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vload{-}zero{-}oob}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{N}{\mathsf{\_}}{\mathsf{zero}}}~x~{\mathit{ao}}) & \hookrightarrow & \mathsf{trap} & \quad \mbox{if}~ i + {\mathit{ao}}{.}\mathsf{offset} + N / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}vload{-}zero{-}val}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{N}{\mathsf{\_}}{\mathsf{zero}}}~x~{\mathit{ao}}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {{\mathrm{bytes}}}_{{\mathsf{i}}{N}}(j) = z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : N / 8] \\
{\land}~ c = {{{{\mathrm{extend}}}_{N, 128}^{\mathsf{u}}}}{(j)} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vload\_lane{-}oob}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{N}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~j) & \hookrightarrow & \mathsf{trap} & \quad \mbox{if}~ i + {\mathit{ao}}{.}\mathsf{offset} + N / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}vload\_lane{-}val}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{N}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~j) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {{\mathrm{bytes}}}_{{\mathsf{i}}{N}}(k) = z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : N / 8] \\
{\land}~ N = {|{\mathsf{i}}{N}|} \\
{\land}~ M = {|\mathsf{v{\scriptstyle 128}}|} / N \\
{\land}~ c = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(c_1){}[{}[j] = k])} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}store{-}num{-}oob}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~({\mathit{nt}}{.}\mathsf{const}~c)~({\mathit{nt}}{.}\mathsf{store}~x~{\mathit{ao}}) & \hookrightarrow & z ; \mathsf{trap} &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ i + {\mathit{ao}}{.}\mathsf{offset} + {|{\mathit{nt}}|} / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|}
} \\
{[\textsc{\scriptsize E{-}store{-}num{-}val}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~({\mathit{nt}}{.}\mathsf{const}~c)~({\mathit{nt}}{.}\mathsf{store}~x~{\mathit{ao}}) & \hookrightarrow & z{}[{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : {|{\mathit{nt}}|} / 8] = {b^\ast}] ; \epsilon &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ {b^\ast} = {{\mathrm{bytes}}}_{{\mathit{nt}}}(c)
} \\
{[\textsc{\scriptsize E{-}store{-}pack{-}oob}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~({\mathsf{i}}{N}{.}\mathsf{const}~c)~({{\mathsf{i}}{N}{.}\mathsf{store}}{n}~x~{\mathit{ao}}) & \hookrightarrow & z ; \mathsf{trap} &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ i + {\mathit{ao}}{.}\mathsf{offset} + n / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|}
} \\
{[\textsc{\scriptsize E{-}store{-}pack{-}val}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~({\mathsf{i}}{N}{.}\mathsf{const}~c)~({{\mathsf{i}}{N}{.}\mathsf{store}}{n}~x~{\mathit{ao}}) & \hookrightarrow & z{}[{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : n / 8] = {b^\ast}] ; \epsilon &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ {b^\ast} = {{\mathrm{bytes}}}_{{\mathsf{i}}{n}}({{\mathrm{wrap}}}_{{|{\mathsf{i}}{N}|}, n}(c))
} \\
{[\textsc{\scriptsize E{-}vstore{-}oob}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}~x~{\mathit{ao}}) & \hookrightarrow & z ; \mathsf{trap} &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ i + {\mathit{ao}}{.}\mathsf{offset} + {|\mathsf{v{\scriptstyle 128}}|} / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|}
} \\
{[\textsc{\scriptsize E{-}vstore{-}val}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}~x~{\mathit{ao}}) & \hookrightarrow & z{}[{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : {|\mathsf{v{\scriptstyle 128}}|} / 8] = {b^\ast}] ; \epsilon &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ {b^\ast} = {{\mathrm{bytes}}}_{\mathsf{v{\scriptstyle 128}}}(c)
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vstore\_lane{-}oob}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}}{N}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~j) & \hookrightarrow & z ; \mathsf{trap} &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ i + {\mathit{ao}}{.}\mathsf{offset} + N > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|}
} \\
{[\textsc{\scriptsize E{-}vstore\_lane{-}val}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}}{N}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~j) & \hookrightarrow & z{}[{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : N / 8] = {b^\ast}] ; \epsilon &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ N = {|{\mathsf{i}}{N}|} \\
{\land}~ M = 128 / N \\
{\land}~ {b^\ast} = {{\mathrm{bytes}}}_{{\mathsf{i}}{N}}({{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(c){}[j]) \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.size}]} \quad & z ; (\mathsf{memory{.}size}~x) & \hookrightarrow & ({\mathit{at}}{.}\mathsf{const}~n) & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ n \cdot 64 \, {\mathrm{Ki}} = {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|} \\
{\land}~ z{.}\mathsf{mems}{}[x]{.}\mathsf{type} = {\mathit{at}}~{\mathit{lim}}~\mathsf{page} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.grow{-}succeed}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~n)~(\mathsf{memory{.}grow}~x) & \hookrightarrow & z{}[{.}\mathsf{mems}{}[x] = {\mathit{mi}}] ; ({\mathit{at}}{.}\mathsf{const}~{|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|} / 64 \, {\mathrm{Ki}}) &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ {\mathit{mi}} = {\mathrm{growmem}}(z{.}\mathsf{mems}{}[x], n)
} \\
{[\textsc{\scriptsize E{-}memory.grow{-}fail}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~n)~(\mathsf{memory{.}grow}~x) & \hookrightarrow & z ; ({\mathit{at}}{.}\mathsf{const}~{{{{\mathrm{signed}}}_{{|{\mathit{at}}|}}^{{-1}}}}{({-1})}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.fill{-}oob}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~{\mathit{val}}~({\mathit{at}}{.}\mathsf{const}~n)~(\mathsf{memory{.}fill}~x) & \hookrightarrow & \mathsf{trap} & \quad \mbox{if}~ i + n > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}memory.fill{-}zero}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~{\mathit{val}}~({\mathit{at}}{.}\mathsf{const}~n)~(\mathsf{memory{.}fill}~x) & \hookrightarrow & \epsilon & \quad \mbox{otherwise, if}~ n = 0 \\
{[\textsc{\scriptsize E{-}memory.fill{-}succ}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~{\mathit{val}}~({\mathit{at}}{.}\mathsf{const}~n)~(\mathsf{memory{.}fill}~x) & \hookrightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} ({\mathit{at}}{.}\mathsf{const}~i)~{\mathit{val}}~({\mathsf{i{\scriptstyle 32}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 8}}}~x) \\
  ({\mathit{at}}{.}\mathsf{const}~i + 1)~{\mathit{val}}~({\mathit{at}}{.}\mathsf{const}~n - 1)~(\mathsf{memory{.}fill}~x) \end{array} & \quad \mbox{otherwise} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.copy{-}oob}]} \quad & z ; ({\mathit{at}}_1{.}\mathsf{const}~i_1)~({\mathit{at}}_2{.}\mathsf{const}~i_2)~({\mathit{at}'}{.}\mathsf{const}~n)~(\mathsf{memory{.}copy}~x_1~x_2) & \hookrightarrow & \mathsf{trap} &  \\
& \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{if}~ i_1 + n > {|z{.}\mathsf{mems}{}[x_1]{.}\mathsf{bytes}|} \lor i_2 + n > {|z{.}\mathsf{mems}{}[x_2]{.}\mathsf{bytes}|}
} \\
{[\textsc{\scriptsize E{-}memory.copy{-}zero}]} \quad & z ; ({\mathit{at}}_1{.}\mathsf{const}~i_1)~({\mathit{at}}_2{.}\mathsf{const}~i_2)~({\mathit{at}'}{.}\mathsf{const}~n)~(\mathsf{memory{.}copy}~x_1~x_2) & \hookrightarrow & \epsilon & \quad \mbox{otherwise, if}~ n = 0 \\
{[\textsc{\scriptsize E{-}memory.copy{-}le}]} \quad & z ; ({\mathit{at}}_1{.}\mathsf{const}~i_1)~({\mathit{at}}_2{.}\mathsf{const}~i_2)~({\mathit{at}'}{.}\mathsf{const}~n)~(\mathsf{memory{.}copy}~x_1~x_2) & \hookrightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} ({\mathit{at}}_1{.}\mathsf{const}~i_1)~({\mathit{at}}_2{.}\mathsf{const}~i_2)~({\mathsf{i{\scriptstyle 32}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{u}}}~x_2)~({\mathsf{i{\scriptstyle 32}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 8}}}~x_1) \\
  ({\mathit{at}}_1{.}\mathsf{const}~i_1 + 1)~({\mathit{at}}_2{.}\mathsf{const}~i_2 + 1)~({\mathit{at}'}{.}\mathsf{const}~n - 1)~(\mathsf{memory{.}copy}~x_1~x_2) \end{array} & \quad \mbox{otherwise, if}~ i_1 \leq i_2 \\
\end{array}
} \\
{[\textsc{\scriptsize E{-}memory.copy{-}gt}]} \quad & z ; ({\mathit{at}}_1{.}\mathsf{const}~i_1)~({\mathit{at}}_2{.}\mathsf{const}~i_2)~({\mathit{at}'}{.}\mathsf{const}~n)~(\mathsf{memory{.}copy}~x_1~x_2) & \hookrightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} ({\mathit{at}}_1{.}\mathsf{const}~i_1 + n - 1)~({\mathit{at}}_2{.}\mathsf{const}~i_2 + n - 1)~({\mathsf{i{\scriptstyle 32}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{u}}}~x_2)~({\mathsf{i{\scriptstyle 32}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 8}}}~x_1) \\
  ({\mathit{at}}_1{.}\mathsf{const}~i_1)~({\mathit{at}}_2{.}\mathsf{const}~i_2)~({\mathit{at}'}{.}\mathsf{const}~n - 1)~(\mathsf{memory{.}copy}~x_1~x_2) \end{array} & \quad \mbox{otherwise} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.init{-}oob}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{memory{.}init}~x~y) & \hookrightarrow & \mathsf{trap} &  \\
& \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{if}~ i + n > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|} \lor j + n > {|z{.}\mathsf{datas}{}[y]{.}\mathsf{bytes}|}
} \\
{[\textsc{\scriptsize E{-}memory.init{-}zero}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{memory{.}init}~x~y) & \hookrightarrow & \epsilon & \quad \mbox{otherwise, if}~ n = 0 \\
{[\textsc{\scriptsize E{-}memory.init{-}succ}]} \quad & z ; ({\mathit{at}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{memory{.}init}~x~y) & \hookrightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} ({\mathit{at}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~z{.}\mathsf{datas}{}[y]{.}\mathsf{bytes}{}[j])~({\mathsf{i{\scriptstyle 32}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 8}}}~x) \\
  ({\mathit{at}}{.}\mathsf{const}~i + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{memory{.}init}~x~y) \end{array} & \quad \mbox{otherwise} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}data.drop}]} \quad & z ; (\mathsf{data{.}drop}~x) & \hookrightarrow & z{}[{.}\mathsf{datas}{}[x]{.}\mathsf{bytes} = \epsilon] ; \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.null{-}idx}]} \quad & z ; (\mathsf{ref{.}null}~x) & \hookrightarrow & (\mathsf{ref{.}null}~z{.}\mathsf{types}{}[x]) \\
{[\textsc{\scriptsize E{-}ref.func}]} \quad & z ; (\mathsf{ref{.}func}~x) & \hookrightarrow & (\mathsf{ref{.}func}~z{.}\mathsf{module}{.}\mathsf{funcs}{}[x]) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.i31}]} \quad & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~\mathsf{ref{.}i{\scriptstyle 31}} & \hookrightarrow & (\mathsf{ref{.}i{\scriptstyle 31}}~{{\mathrm{wrap}}}_{32, 31}(i)) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.is\_null{-}true}]} \quad & {\mathit{ref}}~\mathsf{ref{.}is\_null} & \hookrightarrow & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~1) & \quad \mbox{if}~ {\mathit{ref}} = (\mathsf{ref{.}null}~{\mathit{ht}}) \\
{[\textsc{\scriptsize E{-}ref.is\_null{-}false}]} \quad & {\mathit{ref}}~\mathsf{ref{.}is\_null} & \hookrightarrow & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~0) & \quad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.as\_non\_null{-}null}]} \quad & {\mathit{ref}}~\mathsf{ref{.}as\_non\_null} & \hookrightarrow & \mathsf{trap} & \quad \mbox{if}~ {\mathit{ref}} = (\mathsf{ref{.}null}~{\mathit{ht}}) \\
{[\textsc{\scriptsize E{-}ref.as\_non\_null{-}addr}]} \quad & {\mathit{ref}}~\mathsf{ref{.}as\_non\_null} & \hookrightarrow & {\mathit{ref}} & \quad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.eq{-}null}]} \quad & {\mathit{ref}}_1~{\mathit{ref}}_2~\mathsf{ref{.}eq} & \hookrightarrow & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~1) & \quad \mbox{if}~ {\mathit{ref}}_1 = (\mathsf{ref{.}null}~{\mathit{ht}}_1) \land {\mathit{ref}}_2 = (\mathsf{ref{.}null}~{\mathit{ht}}_2) \\
{[\textsc{\scriptsize E{-}ref.eq{-}true}]} \quad & {\mathit{ref}}_1~{\mathit{ref}}_2~\mathsf{ref{.}eq} & \hookrightarrow & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~1) & \quad \mbox{otherwise, if}~ {\mathit{ref}}_1 = {\mathit{ref}}_2 \\
{[\textsc{\scriptsize E{-}ref.eq{-}false}]} \quad & {\mathit{ref}}_1~{\mathit{ref}}_2~\mathsf{ref{.}eq} & \hookrightarrow & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~0) & \quad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.test{-}true}]} \quad & s ; f ; {\mathit{ref}}~(\mathsf{ref{.}test}~{\mathit{rt}}) & \hookrightarrow & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~1) & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ s \vdash {\mathit{ref}} : {\mathit{rt}'} \\
{\land}~ \{  \} \vdash {\mathit{rt}'} \leq {{\mathrm{inst}}}_{f{.}\mathsf{module}}({\mathit{rt}}) \\
\end{array} \\
{[\textsc{\scriptsize E{-}ref.test{-}false}]} \quad & s ; f ; {\mathit{ref}}~(\mathsf{ref{.}test}~{\mathit{rt}}) & \hookrightarrow & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~0) & \quad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.cast{-}succeed}]} \quad & s ; f ; {\mathit{ref}}~(\mathsf{ref{.}cast}~{\mathit{rt}}) & \hookrightarrow & {\mathit{ref}} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ s \vdash {\mathit{ref}} : {\mathit{rt}'} \\
{\land}~ \{  \} \vdash {\mathit{rt}'} \leq {{\mathrm{inst}}}_{f{.}\mathsf{module}}({\mathit{rt}}) \\
\end{array} \\
{[\textsc{\scriptsize E{-}ref.cast{-}fail}]} \quad & s ; f ; {\mathit{ref}}~(\mathsf{ref{.}cast}~{\mathit{rt}}) & \hookrightarrow & \mathsf{trap} & \quad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}i31.get{-}null}]} \quad & (\mathsf{ref{.}null}~{\mathit{ht}})~({\mathsf{i{\scriptstyle 31}{.}get}}{\mathsf{\_}}{{\mathit{sx}}}) & \hookrightarrow & \mathsf{trap} \\
{[\textsc{\scriptsize E{-}i31.get{-}num}]} \quad & (\mathsf{ref{.}i{\scriptstyle 31}}~i)~({\mathsf{i{\scriptstyle 31}{.}get}}{\mathsf{\_}}{{\mathit{sx}}}) & \hookrightarrow & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~{{{{\mathrm{extend}}}_{31, 32}^{{\mathit{sx}}}}}{(i)}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.new}]} \quad & z ; {{\mathit{val}}^{n}}~(\mathsf{struct{.}new}~x) & \hookrightarrow & z{}[{.}\mathsf{structs} \mathrel{{=}{\oplus}} {\mathit{si}}] ; (\mathsf{ref{.}struct}~a) & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ z{.}\mathsf{types}{}[x] \approx \mathsf{struct}~{({\mathsf{mut}^?}~{\mathit{zt}})^{n}} \\
{\land}~ a = {|z{.}\mathsf{structs}|} \\
{\land}~ {\mathit{si}} = \{ \mathsf{type}~z{.}\mathsf{types}{}[x],\;\allowbreak \mathsf{fields}~{({{\mathrm{pack}}}_{{\mathit{zt}}}({\mathit{val}}))^{n}} \} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.new\_default}]} \quad & z ; (\mathsf{struct{.}new\_default}~x) & \hookrightarrow & {{\mathit{val}}^\ast}~(\mathsf{struct{.}new}~x) & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ z{.}\mathsf{types}{}[x] \approx \mathsf{struct}~{({\mathsf{mut}^?}~{\mathit{zt}})^\ast} \\
{\land}~ ({{\mathrm{default}}}_{{\mathrm{unpack}}({\mathit{zt}})} = {\mathit{val}})^\ast \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.get{-}null}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}})~({\mathsf{struct{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~x~i) & \hookrightarrow & \mathsf{trap} \\
{[\textsc{\scriptsize E{-}struct.get{-}struct}]} \quad & z ; (\mathsf{ref{.}struct}~a)~({\mathsf{struct{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~x~i) & \hookrightarrow & {{{{\mathrm{unpack}}}_{{{\mathit{zt}}^\ast}{}[i]}^{{{\mathit{sx}}^?}}}}{(z{.}\mathsf{structs}{}[a]{.}\mathsf{fields}{}[i])} &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ z{.}\mathsf{types}{}[x] \approx \mathsf{struct}~{({\mathsf{mut}^?}~{\mathit{zt}})^\ast}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.set{-}null}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}})~{\mathit{val}}~(\mathsf{struct{.}set}~x~i) & \hookrightarrow & z ; \mathsf{trap} \\
{[\textsc{\scriptsize E{-}struct.set{-}struct}]} \quad & z ; (\mathsf{ref{.}struct}~a)~{\mathit{val}}~(\mathsf{struct{.}set}~x~i) & \hookrightarrow & z{}[{.}\mathsf{structs}{}[a]{.}\mathsf{fields}{}[i] = {{\mathrm{pack}}}_{{{\mathit{zt}}^\ast}{}[i]}({\mathit{val}})] ; \epsilon &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ z{.}\mathsf{types}{}[x] \approx \mathsf{struct}~{({\mathsf{mut}^?}~{\mathit{zt}})^\ast}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new}]} \quad & {\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}new}~x) & \hookrightarrow & {{\mathit{val}}^{n}}~(\mathsf{array{.}new\_fixed}~x~n) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new\_default}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}new\_default}~x) & \hookrightarrow & {{\mathit{val}}^{n}}~(\mathsf{array{.}new\_fixed}~x~n) & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ z{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}}) \\
{\land}~ {{\mathrm{default}}}_{{\mathrm{unpack}}({\mathit{zt}})} = {\mathit{val}} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new\_fixed}]} \quad & z ; {{\mathit{val}}^{n}}~(\mathsf{array{.}new\_fixed}~x~n) & \hookrightarrow & z{}[{.}\mathsf{arrays} \mathrel{{=}{\oplus}} {\mathit{ai}}] ; (\mathsf{ref{.}array}~a) &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ z{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}}) \\
{\land}~ a = {|z{.}\mathsf{arrays}|} \land {\mathit{ai}} = \{ \mathsf{type}~z{.}\mathsf{types}{}[x],\;\allowbreak \mathsf{fields}~{({{\mathrm{pack}}}_{{\mathit{zt}}}({\mathit{val}}))^{n}} \} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new\_elem{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}new\_elem}~x~y) & \hookrightarrow & \mathsf{trap} & \quad \mbox{if}~ i + n > {|z{.}\mathsf{elems}{}[y]{.}\mathsf{refs}|} \\
{[\textsc{\scriptsize E{-}array.new\_elem{-}alloc}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}new\_elem}~x~y) & \hookrightarrow & {{\mathit{ref}}^{n}}~(\mathsf{array{.}new\_fixed}~x~n) &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ {{\mathit{ref}}^{n}} = z{.}\mathsf{elems}{}[y]{.}\mathsf{refs}{}[i : n]
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new\_data{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}new\_data}~x~y) & \hookrightarrow & \mathsf{trap} &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ z{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}}) \\
{\land}~ i + n \cdot {|{\mathit{zt}}|} / 8 > {|z{.}\mathsf{datas}{}[y]{.}\mathsf{bytes}|} \\
\end{array}
} \\
{[\textsc{\scriptsize E{-}array.new\_data{-}num}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}new\_data}~x~y) & \hookrightarrow & {({\mathrm{unpack}}({\mathit{zt}}){.}\mathsf{const}~{{\mathrm{unpack}}}_{{\mathit{zt}}}(c))^{n}}~(\mathsf{array{.}new\_fixed}~x~n) &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ z{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}}) \\
{\land}~ {\bigoplus}\, {{{\mathrm{bytes}}}_{{\mathit{zt}}}(c)^{n}} = z{.}\mathsf{datas}{}[y]{.}\mathsf{bytes}{}[i : n \cdot {|{\mathit{zt}}|} / 8] \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.get{-}null}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathsf{array{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~x) & \hookrightarrow & \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.get{-}oob}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathsf{array{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~x) & \hookrightarrow & \mathsf{trap} & \quad \mbox{if}~ i \geq {|z{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}|} \\
{[\textsc{\scriptsize E{-}array.get{-}array}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathsf{array{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~x) & \hookrightarrow & {{{{\mathrm{unpack}}}_{{\mathit{zt}}}^{{{\mathit{sx}}^?}}}}{(z{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}{}[i])} &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ z{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}})
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.set{-}null}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{array{.}set}~x) & \hookrightarrow & z ; \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.set{-}oob}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{array{.}set}~x) & \hookrightarrow & z ; \mathsf{trap} & \quad \mbox{if}~ i \geq {|z{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}|} \\
{[\textsc{\scriptsize E{-}array.set{-}array}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{array{.}set}~x) & \hookrightarrow & z{}[{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}{}[i] = {{\mathrm{pack}}}_{{\mathit{zt}}}({\mathit{val}})] ; \epsilon &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ z{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}})
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.len{-}null}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}})~\mathsf{array{.}len} & \hookrightarrow & \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.len{-}array}]} \quad & z ; (\mathsf{ref{.}array}~a)~\mathsf{array{.}len} & \hookrightarrow & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~{|z{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}|}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.fill{-}null}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}fill}~x) & \hookrightarrow & \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.fill{-}oob}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}fill}~x) & \hookrightarrow & \mathsf{trap} & \quad \mbox{if}~ i + n > {|z{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}|} \\
{[\textsc{\scriptsize E{-}array.fill{-}zero}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}fill}~x) & \hookrightarrow & \epsilon & \quad \mbox{otherwise, if}~ n = 0 \\
{[\textsc{\scriptsize E{-}array.fill{-}succ}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}fill}~x) & \hookrightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{array{.}set}~x) \\
  (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i + 1)~{\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{array{.}fill}~x) \end{array} & \quad \mbox{otherwise} \\
\end{array}
} \\
{[\textsc{\scriptsize E{-}array.copy{-}null1}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}}_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~{\mathit{ref}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}copy}~x_1~x_2) & \hookrightarrow & \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.copy{-}null2}]} \quad & z ; {\mathit{ref}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{ref{.}null}~{\mathit{ht}}_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}copy}~x_1~x_2) & \hookrightarrow & \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.copy{-}oob1}]} \quad & z ; (\mathsf{ref{.}array}~a_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{ref{.}array}~a_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}copy}~x_1~x_2) & \hookrightarrow & \mathsf{trap} &  \\
& \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{if}~ i_1 + n > {|z{.}\mathsf{arrays}{}[a_1]{.}\mathsf{fields}|}
} \\
{[\textsc{\scriptsize E{-}array.copy{-}oob2}]} \quad & z ; (\mathsf{ref{.}array}~a_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{ref{.}array}~a_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}copy}~x_1~x_2) & \hookrightarrow & \mathsf{trap} &  \\
& \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{if}~ i_2 + n > {|z{.}\mathsf{arrays}{}[a_2]{.}\mathsf{fields}|}
} \\
{[\textsc{\scriptsize E{-}array.copy{-}zero}]} \quad & z ; (\mathsf{ref{.}array}~a_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{ref{.}array}~a_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}copy}~x_1~x_2) & \hookrightarrow & \epsilon &  \\
& \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{otherwise, if}~ n = 0
} \\
{[\textsc{\scriptsize E{-}array.copy{-}le}]} \quad & z ; (\mathsf{ref{.}array}~a_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{ref{.}array}~a_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}copy}~x_1~x_2) & \hookrightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} (\mathsf{ref{.}array}~a_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1) \\
  (\mathsf{ref{.}array}~a_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2) \\
  ({\mathsf{array{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~x_2)~(\mathsf{array{.}set}~x_1) \\
  (\mathsf{ref{.}array}~a_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1 + 1)~(\mathsf{ref{.}array}~a_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2 + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{array{.}copy}~x_1~x_2) \end{array} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad
\begin{array}[t]{@{}l@{}}
\mbox{otherwise, if}~ z{.}\mathsf{types}{}[x_2] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}}_2) \\
{\land}~ i_1 \leq i_2 \land {{\mathit{sx}}^?} = {\mathrm{sx}}({\mathit{zt}}_2) \\
\end{array} \\
\end{array}
} \\
\end{array}
} \\
{[\textsc{\scriptsize E{-}array.copy{-}gt}]} \quad & z ; (\mathsf{ref{.}array}~a_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{ref{.}array}~a_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}copy}~x_1~x_2) & \hookrightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} (\mathsf{ref{.}array}~a_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1 + n - 1) \\
  (\mathsf{ref{.}array}~a_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2 + n - 1) \\
  ({\mathsf{array{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~x_2)~(\mathsf{array{.}set}~x_1) \\
  (\mathsf{ref{.}array}~a_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{ref{.}array}~a_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{array{.}copy}~x_1~x_2) \end{array} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad
\begin{array}[t]{@{}l@{}}
\mbox{otherwise, if}~ z{.}\mathsf{types}{}[x_2] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}}_2) \\
{\land}~ {{\mathit{sx}}^?} = {\mathrm{sx}}({\mathit{zt}}_2) \\
\end{array} \\
\end{array}
} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.init\_elem{-}null}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_elem}~x~y) & \hookrightarrow & \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}oob1}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_elem}~x~y) & \hookrightarrow & \mathsf{trap} &  \\
& \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{if}~ i + n > {|z{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}|}
} \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}oob2}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_elem}~x~y) & \hookrightarrow & \mathsf{trap} &  \\
& \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{if}~ j + n > {|z{.}\mathsf{elems}{}[y]{.}\mathsf{refs}|}
} \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}zero}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_elem}~x~y) & \hookrightarrow & \epsilon &  \\
& \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{otherwise, if}~ n = 0
} \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}succ}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_elem}~x~y) & \hookrightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{ref}}~(\mathsf{array{.}set}~x) \\
  (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{array{.}init\_elem}~x~y) \end{array} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad \mbox{otherwise, if}~ {\mathit{ref}} = z{.}\mathsf{elems}{}[y]{.}\mathsf{refs}{}[j] \\
\end{array}
} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.init\_data{-}null}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_data}~x~y) & \hookrightarrow & \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.init\_data{-}oob1}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_data}~x~y) & \hookrightarrow & \mathsf{trap} &  \\
& \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{if}~ i + n > {|z{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}|}
} \\
{[\textsc{\scriptsize E{-}array.init\_data{-}oob2}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_data}~x~y) & \hookrightarrow & \mathsf{trap} &  \\
& \multicolumn{4}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ z{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}}) \\
{\land}~ j + n \cdot {|{\mathit{zt}}|} / 8 > {|z{.}\mathsf{datas}{}[y]{.}\mathsf{bytes}|} \\
\end{array}
} \\
{[\textsc{\scriptsize E{-}array.init\_data{-}zero}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_data}~x~y) & \hookrightarrow & \epsilon &  \\
& \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{otherwise, if}~ n = 0
} \\
{[\textsc{\scriptsize E{-}array.init\_data{-}num}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_data}~x~y) & \hookrightarrow & & \\
& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathrm{unpack}}({\mathit{zt}}){.}\mathsf{const}~{{\mathrm{unpack}}}_{{\mathit{zt}}}(c))~(\mathsf{array{.}set}~x) \\
  (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j + {|{\mathit{zt}}|} / 8)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{array{.}init\_data}~x~y) \end{array} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad
\begin{array}[t]{@{}l@{}}
\mbox{otherwise, if}~ z{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}}) \\
{\land}~ {{\mathrm{bytes}}}_{{\mathit{zt}}}(c) = z{.}\mathsf{datas}{}[y]{.}\mathsf{bytes}{}[j : {|{\mathit{zt}}|} / 8] \\
\end{array} \\
\end{array}
} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}extern.convert\_any{-}null}]} \quad & (\mathsf{ref{.}null}~{\mathit{ht}})~\mathsf{extern{.}convert\_any} & \hookrightarrow & (\mathsf{ref{.}null}~\mathsf{extern}) \\
{[\textsc{\scriptsize E{-}extern.convert\_any{-}addr}]} \quad & {\mathit{addrref}}~\mathsf{extern{.}convert\_any} & \hookrightarrow & (\mathsf{ref{.}extern}~{\mathit{addrref}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}any.convert\_extern{-}null}]} \quad & (\mathsf{ref{.}null}~{\mathit{ht}})~\mathsf{any{.}convert\_extern} & \hookrightarrow & (\mathsf{ref{.}null}~\mathsf{any}) \\
{[\textsc{\scriptsize E{-}any.convert\_extern{-}addr}]} \quad & (\mathsf{ref{.}extern}~{\mathit{addrref}})~\mathsf{any{.}convert\_extern} & \hookrightarrow & {\mathit{addrref}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}unop{-}val}]} \quad & ({\mathit{nt}}{.}\mathsf{const}~c_1)~({\mathit{nt}} {.} {\mathit{unop}}) & \hookrightarrow & ({\mathit{nt}}{.}\mathsf{const}~c) & \quad \mbox{if}~ c \in {{\mathit{unop}}}{{}_{{\mathit{nt}}}(c_1)} \\
{[\textsc{\scriptsize E{-}unop{-}trap}]} \quad & ({\mathit{nt}}{.}\mathsf{const}~c_1)~({\mathit{nt}} {.} {\mathit{unop}}) & \hookrightarrow & \mathsf{trap} & \quad \mbox{if}~ {{\mathit{unop}}}{{}_{{\mathit{nt}}}(c_1)} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}binop{-}val}]} \quad & ({\mathit{nt}}{.}\mathsf{const}~c_1)~({\mathit{nt}}{.}\mathsf{const}~c_2)~({\mathit{nt}} {.} {\mathit{binop}}) & \hookrightarrow & ({\mathit{nt}}{.}\mathsf{const}~c) & \quad \mbox{if}~ c \in {{\mathit{binop}}}{{}_{{\mathit{nt}}}(c_1, c_2)} \\
{[\textsc{\scriptsize E{-}binop{-}trap}]} \quad & ({\mathit{nt}}{.}\mathsf{const}~c_1)~({\mathit{nt}}{.}\mathsf{const}~c_2)~({\mathit{nt}} {.} {\mathit{binop}}) & \hookrightarrow & \mathsf{trap} & \quad \mbox{if}~ {{\mathit{binop}}}{{}_{{\mathit{nt}}}(c_1, c_2)} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}testop}]} \quad & ({\mathit{nt}}{.}\mathsf{const}~c_1)~({\mathit{nt}} {.} {\mathit{testop}}) & \hookrightarrow & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c) & \quad \mbox{if}~ c = {{\mathit{testop}}}{{}_{{\mathit{nt}}}(c_1)} \\
{[\textsc{\scriptsize E{-}relop}]} \quad & ({\mathit{nt}}{.}\mathsf{const}~c_1)~({\mathit{nt}}{.}\mathsf{const}~c_2)~({\mathit{nt}} {.} {\mathit{relop}}) & \hookrightarrow & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c) & \quad \mbox{if}~ c = {{\mathit{relop}}}{{}_{{\mathit{nt}}}(c_1, c_2)} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}cvtop{-}val}]} \quad & ({\mathit{nt}}_1{.}\mathsf{const}~c_1)~({\mathit{nt}}_2 {.} {{\mathit{cvtop}}}{\mathsf{\_}}{{\mathit{nt}}_1}) & \hookrightarrow & ({\mathit{nt}}_2{.}\mathsf{const}~c) & \quad \mbox{if}~ c \in {{\mathit{cvtop}}}{{}_{{\mathit{nt}}_1, {\mathit{nt}}_2}(c_1)} \\
{[\textsc{\scriptsize E{-}cvtop{-}trap}]} \quad & ({\mathit{nt}}_1{.}\mathsf{const}~c_1)~({\mathit{nt}}_2 {.} {{\mathit{cvtop}}}{\mathsf{\_}}{{\mathit{nt}}_1}) & \hookrightarrow & \mathsf{trap} & \quad \mbox{if}~ {{\mathit{cvtop}}}{{}_{{\mathit{nt}}_1, {\mathit{nt}}_2}(c_1)} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vvunop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}} {.} {\mathit{vvunop}}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) & \quad \mbox{if}~ c \in {{\mathit{vvunop}}}{{}_{\mathsf{v{\scriptstyle 128}}}(c_1)} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vvbinop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~(\mathsf{v{\scriptstyle 128}} {.} {\mathit{vvbinop}}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) & \quad \mbox{if}~ c \in {{\mathit{vvbinop}}}{{}_{\mathsf{v{\scriptstyle 128}}}(c_1, c_2)} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vvternop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_3)~(\mathsf{v{\scriptstyle 128}} {.} {\mathit{vvternop}}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ c \in {{\mathit{vvternop}}}{{}_{\mathsf{v{\scriptstyle 128}}}(c_1, c_2, c_3)}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vvtestop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}} {.} \mathsf{any\_true}) & \hookrightarrow & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c) & \quad \mbox{if}~ c = {{\mathrm{inez}}}_{{|\mathsf{v{\scriptstyle 128}}|}}(c_1) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vunop{-}val}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({\mathit{sh}} {.} {\mathit{vunop}}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) & \quad \mbox{if}~ c \in {{\mathit{vunop}}}{{}_{{\mathit{sh}}}(c_1)} \\
{[\textsc{\scriptsize E{-}vunop{-}trap}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({\mathit{sh}} {.} {\mathit{vunop}}) & \hookrightarrow & \mathsf{trap} & \quad \mbox{if}~ {{\mathit{vunop}}}{{}_{{\mathit{sh}}}(c_1)} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vbinop{-}val}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~({\mathit{sh}} {.} {\mathit{vbinop}}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) & \quad \mbox{if}~ c \in {{\mathit{vbinop}}}{{}_{{\mathit{sh}}}(c_1, c_2)} \\
{[\textsc{\scriptsize E{-}vbinop{-}trap}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~({\mathit{sh}} {.} {\mathit{vbinop}}) & \hookrightarrow & \mathsf{trap} & \quad \mbox{if}~ {{\mathit{vbinop}}}{{}_{{\mathit{sh}}}(c_1, c_2)} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vternop{-}val}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_3)~({\mathit{sh}} {.} {\mathit{vternop}}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) & \quad \mbox{if}~ c \in {{\mathit{vternop}}}{{}_{{\mathit{sh}}}(c_1, c_2, c_3)} \\
{[\textsc{\scriptsize E{-}vternop{-}trap}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_3)~({\mathit{sh}} {.} {\mathit{vternop}}) & \hookrightarrow & \mathsf{trap} & \quad \mbox{if}~ {{\mathit{vternop}}}{{}_{{\mathit{sh}}}(c_1, c_2, c_3)} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vtestop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({{\mathsf{i}}{N}}{\mathsf{x}}{M} {.} \mathsf{all\_true}) & \hookrightarrow & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c) & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {i^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(c_1) \\
{\land}~ c = {\Pi}\, ({{{\mathrm{inez}}}_{N}(i)^\ast}) \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vrelop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~({\mathit{sh}} {.} {\mathit{vrelop}}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) & \quad \mbox{if}~ c = {{\mathit{vrelop}}}{{}_{{\mathit{sh}}}(c_1, c_2)} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vshiftop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathit{sh}} {.} {\mathit{vshiftop}}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) & \quad \mbox{if}~ c = {{\mathit{vshiftop}}}{{}_{{\mathit{sh}}}}{(c_1, i)} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vbitmask}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({\mathit{sh}}{.}\mathsf{bitmask}) & \hookrightarrow & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c) & \quad \mbox{if}~ c = {\mathsf{vbitmask}}{{}_{{\mathit{sh}}}(c_1)} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vswizzlop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~({\mathit{sh}} {.} {\mathit{swizzlop}}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) & \quad \mbox{if}~ c = {{\mathit{swizzlop}}}{{}_{{\mathit{sh}}}(c_1, c_2)} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vshuffle}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~({\mathit{sh}}{.}\mathsf{shuffle}~{i^\ast}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) & \quad \mbox{if}~ c = {\mathsf{vshuffle}}{{}_{{\mathit{sh}}}({i^\ast}, c_1, c_2)} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vsplat}]} \quad & ({\mathrm{unpack}}({\mathsf{i}}{N}){.}\mathsf{const}~c_1)~({{\mathsf{i}}{N}}{\mathsf{x}}{M}{.}\mathsf{splat}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) & \quad \mbox{if}~ c = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{{\mathrm{pack}}}_{{\mathsf{i}}{N}}(c_1)^{M}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vextract\_lane{-}num}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({{\mathit{nt}}}{\mathsf{x}}{M}{.}\mathsf{extract\_lane}~i) & \hookrightarrow & ({\mathit{nt}}{.}\mathsf{const}~c_2) & \quad \mbox{if}~ c_2 = {{\mathrm{lanes}}}_{{{\mathit{nt}}}{\mathsf{x}}{M}}(c_1){}[i] \\
{[\textsc{\scriptsize E{-}vextract\_lane{-}pack}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({{{\mathit{pt}}}{\mathsf{x}}{M}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{{\mathit{sx}}}~i) & \hookrightarrow & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c_2) & \quad \mbox{if}~ c_2 = {{{{\mathrm{extend}}}_{{|{\mathit{pt}}|}, 32}^{{\mathit{sx}}}}}{({{\mathrm{lanes}}}_{{{\mathit{pt}}}{\mathsf{x}}{M}}(c_1){}[i])} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vreplace\_lane}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({\mathrm{unpack}}({\mathsf{i}}{N}){.}\mathsf{const}~c_2)~({{\mathsf{i}}{N}}{\mathsf{x}}{M}{.}\mathsf{replace\_lane}~i) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) &  \\
& \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{if}~ c = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(c_1){}[{}[i] = {{\mathrm{pack}}}_{{\mathsf{i}}{N}}(c_2)])}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vextunop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({\mathit{sh}}_2 {.} {{\mathit{vextunop}}}{\mathsf{\_}}{{\mathit{sh}}_1}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) & \quad \mbox{if}~ {{\mathit{vextunop}}}{{}_{{\mathit{sh}}_1, {\mathit{sh}}_2}(c_1)} = c \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vextbinop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~({\mathit{sh}}_2 {.} {{\mathit{vextbinop}}}{\mathsf{\_}}{{\mathit{sh}}_1}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) & \quad \mbox{if}~ {{\mathit{vextbinop}}}{{}_{{\mathit{sh}}_1, {\mathit{sh}}_2}(c_1, c_2)} = c \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vextternop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_3)~({\mathit{sh}}_2 {.} {{\mathit{vextternop}}}{\mathsf{\_}}{{\mathit{sh}}_1}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) &  \\
&&& \multicolumn{2}{@{}l@{}}{\quad
\quad \mbox{if}~ {{\mathit{vextternop}}}{{}_{{\mathit{sh}}_1, {\mathit{sh}}_2}(c_1, c_2, c_3)} = c
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vnarrow}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~({{\mathit{sh}}_2{.}\mathsf{narrow}}{\mathsf{\_}}{{\mathit{sh}}_1}{\mathsf{\_}}{{\mathit{sx}}}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) & \quad \mbox{if}~ c = {\mathsf{vnarrow}}{{{}_{{\mathit{sh}}_1, {\mathit{sh}}_2}^{{\mathit{sx}}}}}{(c_1, c_2)} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}vcvtop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({\mathit{sh}}_2 {.} {{\mathit{vcvtop}}}{\mathsf{\_}}{{\mathit{sh}}_1}) & \hookrightarrow & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) & \quad \mbox{if}~ c = {{\mathrm{vcvtop}}}_{{\mathit{sh}}_1, {\mathit{sh}}_2}({\mathit{vcvtop}}, c_1) \\
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{state}} ; {\mathit{expr}} \hookrightarrow^\ast {\mathit{state}} ; {{\mathit{val}}^\ast}}$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize E{-}expr}]} \quad & z ; {{\mathit{instr}}^\ast} & \hookrightarrow^\ast & {z'} ; {{\mathit{val}}^\ast} & \quad \mbox{if}~ z ; {{\mathit{instr}}^\ast} \hookrightarrow^\ast {z'} ; {{\mathit{val}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{{\mathrm{alloctype}}^\ast}}{(\epsilon)} & = & \epsilon \\
{{{\mathrm{alloctype}}^\ast}}{({{\mathit{type}'}^\ast}~{\mathit{type}})} & = & {{\mathit{deftype}'}^\ast}~{{\mathit{deftype}}^\ast} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {{\mathit{deftype}'}^\ast} = {{{\mathrm{alloctype}}^\ast}}{({{\mathit{type}'}^\ast})} \\
{\land}~ {\mathit{type}} = \mathsf{type}~{\mathit{rectype}} \\
{\land}~ {{\mathit{deftype}}^\ast} = {{{{{\mathrm{roll}}}_{x}^\ast}}{({\mathit{rectype}})}}{{}[ {:=}\, {{\mathit{deftype}'}^\ast} ]} \\
{\land}~ x = {|{{\mathit{deftype}'}^\ast}|} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{alloctag}}(s, {\mathit{tagtype}}) & = & (s \oplus \{ \mathsf{tags}~{\mathit{taginst}} \}, {|s{.}\mathsf{tags}|}) &  \\
 \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{if}~ {\mathit{taginst}} = \{ \mathsf{type}~{\mathit{tagtype}} \}
} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{{\mathrm{alloctag}}^\ast}}{(s, \epsilon)} & = & (s, \epsilon) \\
{{{\mathrm{alloctag}}^\ast}}{(s, {\mathit{tagtype}}~{{\mathit{tagtype}'}^\ast})} & = & (s_2, {\mathit{ja}}~{{\mathit{ja}'}^\ast}) & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ (s_1, {\mathit{ja}}) = {\mathrm{alloctag}}(s, {\mathit{tagtype}}) \\
{\land}~ (s_2, {{\mathit{ja}'}^\ast}) = {{{\mathrm{alloctag}}^\ast}}{(s_1, {{\mathit{tagtype}'}^\ast})} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{allocglobal}}(s, {\mathit{globaltype}}, {\mathit{val}}) & = & (s \oplus \{ \mathsf{globals}~{\mathit{globalinst}} \}, {|s{.}\mathsf{globals}|}) &  \\
 \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{if}~ {\mathit{globalinst}} = \{ \mathsf{type}~{\mathit{globaltype}},\;\allowbreak \mathsf{value}~{\mathit{val}} \}
} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{{\mathrm{allocglobal}}^\ast}}{(s, \epsilon, \epsilon)} & = & (s, \epsilon) \\
{{{\mathrm{allocglobal}}^\ast}}{(s, {\mathit{globaltype}}~{{\mathit{globaltype}'}^\ast}, {\mathit{val}}~{{\mathit{val}'}^\ast})} & = & (s_2, {\mathit{ga}}~{{\mathit{ga}'}^\ast}) & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ (s_1, {\mathit{ga}}) = {\mathrm{allocglobal}}(s, {\mathit{globaltype}}, {\mathit{val}}) \\
{\land}~ (s_2, {{\mathit{ga}'}^\ast}) = {{{\mathrm{allocglobal}}^\ast}}{(s_1, {{\mathit{globaltype}'}^\ast}, {{\mathit{val}'}^\ast})} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{allocmem}}(s, {\mathit{at}}~{}[ i .. {j^?} ]~\mathsf{page}) & = & (s \oplus \{ \mathsf{mems}~{\mathit{meminst}} \}, {|s{.}\mathsf{mems}|}) &  \\
 \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{if}~ {\mathit{meminst}} = \{ \mathsf{type}~({\mathit{at}}~{}[ i .. {j^?} ]~\mathsf{page}),\;\allowbreak \mathsf{bytes}~{(\mathtt{0x00})^{i \cdot 64 \, {\mathrm{Ki}}}} \}
} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{{\mathrm{allocmem}}^\ast}}{(s, \epsilon)} & = & (s, \epsilon) \\
{{{\mathrm{allocmem}}^\ast}}{(s, {\mathit{memtype}}~{{\mathit{memtype}'}^\ast})} & = & (s_2, {\mathit{ma}}~{{\mathit{ma}'}^\ast}) & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ (s_1, {\mathit{ma}}) = {\mathrm{allocmem}}(s, {\mathit{memtype}}) \\
{\land}~ (s_2, {{\mathit{ma}'}^\ast}) = {{{\mathrm{allocmem}}^\ast}}{(s_1, {{\mathit{memtype}'}^\ast})} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{alloctable}}(s, {\mathit{at}}~{}[ i .. {j^?} ]~{\mathit{rt}}, {\mathit{ref}}) & = & (s \oplus \{ \mathsf{tables}~{\mathit{tableinst}} \}, {|s{.}\mathsf{tables}|}) &  \\
 \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{if}~ {\mathit{tableinst}} = \{ \mathsf{type}~({\mathit{at}}~{}[ i .. {j^?} ]~{\mathit{rt}}),\;\allowbreak \mathsf{refs}~{{\mathit{ref}}^{i}} \}
} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{{\mathrm{alloctable}}^\ast}}{(s, \epsilon, \epsilon)} & = & (s, \epsilon) \\
{{{\mathrm{alloctable}}^\ast}}{(s, {\mathit{tabletype}}~{{\mathit{tabletype}'}^\ast}, {\mathit{ref}}~{{\mathit{ref}'}^\ast})} & = & (s_2, {\mathit{ta}}~{{\mathit{ta}'}^\ast}) & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ (s_1, {\mathit{ta}}) = {\mathrm{alloctable}}(s, {\mathit{tabletype}}, {\mathit{ref}}) \\
{\land}~ (s_2, {{\mathit{ta}'}^\ast}) = {{{\mathrm{alloctable}}^\ast}}{(s_1, {{\mathit{tabletype}'}^\ast}, {{\mathit{ref}'}^\ast})} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{allocfunc}}(s, {\mathit{deftype}}, {\mathit{code}}, {\mathit{moduleinst}}) & = & (s \oplus \{ \mathsf{funcs}~{\mathit{funcinst}} \}, {|s{.}\mathsf{funcs}|}) &  \\
 \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{if}~ {\mathit{funcinst}} = \{ \mathsf{type}~{\mathit{deftype}},\;\allowbreak \mathsf{module}~{\mathit{moduleinst}},\;\allowbreak \mathsf{code}~{\mathit{code}} \}
} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{{\mathrm{allocfunc}}^\ast}}{(s, \epsilon, \epsilon, \epsilon)} & = & (s, \epsilon) \\
{{{\mathrm{allocfunc}}^\ast}}{(s, {\mathit{dt}}~{{\mathit{dt}'}^\ast}, {\mathit{code}}~{{{\mathit{code}}'}^\ast}, {\mathit{moduleinst}}~{{\mathit{moduleinst}'}^\ast})} & = & (s_2, {\mathit{fa}}~{{\mathit{fa}'}^\ast}) & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ (s_1, {\mathit{fa}}) = {\mathrm{allocfunc}}(s, {\mathit{dt}}, {\mathit{code}}, {\mathit{moduleinst}}) \\
{\land}~ (s_2, {{\mathit{fa}'}^\ast}) = {{{\mathrm{allocfunc}}^\ast}}{(s_1, {{\mathit{dt}'}^\ast}, {{{\mathit{code}}'}^\ast}, {{\mathit{moduleinst}'}^\ast})} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{allocdata}}(s, \mathsf{ok}, {{\mathit{byte}}^\ast}) & = & (s \oplus \{ \mathsf{datas}~{\mathit{datainst}} \}, {|s{.}\mathsf{datas}|}) &  \\
 \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{if}~ {\mathit{datainst}} = \{ \mathsf{bytes}~{{\mathit{byte}}^\ast} \}
} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{{\mathrm{allocdata}}^\ast}}{(s, \epsilon, \epsilon)} & = & (s, \epsilon) \\
{{{\mathrm{allocdata}}^\ast}}{(s, {\mathit{ok}}~{{\mathit{ok}'}^\ast}, ({b^\ast})~{({{b'}^\ast})^\ast})} & = & (s_2, {\mathit{da}}~{{\mathit{da}'}^\ast}) & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ (s_1, {\mathit{da}}) = {\mathrm{allocdata}}(s, {\mathit{ok}}, {b^\ast}) \\
{\land}~ (s_2, {{\mathit{da}'}^\ast}) = {{{\mathrm{allocdata}}^\ast}}{(s_1, {{\mathit{ok}'}^\ast}, {({{b'}^\ast})^\ast})} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{allocelem}}(s, {\mathit{elemtype}}, {{\mathit{ref}}^\ast}) & = & (s \oplus \{ \mathsf{elems}~{\mathit{eleminst}} \}, {|s{.}\mathsf{elems}|}) &  \\
 \multicolumn{4}{@{}l@{}}{\quad
\quad \mbox{if}~ {\mathit{eleminst}} = \{ \mathsf{type}~{\mathit{elemtype}},\;\allowbreak \mathsf{refs}~{{\mathit{ref}}^\ast} \}
} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{{\mathrm{allocelem}}^\ast}}{(s, \epsilon, \epsilon)} & = & (s, \epsilon) \\
{{{\mathrm{allocelem}}^\ast}}{(s, {\mathit{rt}}~{{\mathit{rt}'}^\ast}, ({{\mathit{ref}}^\ast})~{({{\mathit{ref}'}^\ast})^\ast})} & = & (s_2, {\mathit{ea}}~{{\mathit{ea}'}^\ast}) & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ (s_1, {\mathit{ea}}) = {\mathrm{allocelem}}(s, {\mathit{rt}}, {{\mathit{ref}}^\ast}) \\
{\land}~ (s_2, {{\mathit{ea}'}^\ast}) = {{{\mathrm{allocelem}}^\ast}}{(s_1, {{\mathit{rt}'}^\ast}, {({{\mathit{ref}'}^\ast})^\ast})} \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{allocexport}}({\mathit{moduleinst}}, \mathsf{export}~{\mathit{name}}~(\mathsf{tag}~x)) & = & \{ \mathsf{name}~{\mathit{name}},\;\allowbreak \mathsf{addr}~(\mathsf{tag}~{\mathit{moduleinst}}{.}\mathsf{tags}{}[x]) \} \\
{\mathrm{allocexport}}({\mathit{moduleinst}}, \mathsf{export}~{\mathit{name}}~(\mathsf{global}~x)) & = & \{ \mathsf{name}~{\mathit{name}},\;\allowbreak \mathsf{addr}~(\mathsf{global}~{\mathit{moduleinst}}{.}\mathsf{globals}{}[x]) \} \\
{\mathrm{allocexport}}({\mathit{moduleinst}}, \mathsf{export}~{\mathit{name}}~(\mathsf{mem}~x)) & = & \{ \mathsf{name}~{\mathit{name}},\;\allowbreak \mathsf{addr}~(\mathsf{mem}~{\mathit{moduleinst}}{.}\mathsf{mems}{}[x]) \} \\
{\mathrm{allocexport}}({\mathit{moduleinst}}, \mathsf{export}~{\mathit{name}}~(\mathsf{table}~x)) & = & \{ \mathsf{name}~{\mathit{name}},\;\allowbreak \mathsf{addr}~(\mathsf{table}~{\mathit{moduleinst}}{.}\mathsf{tables}{}[x]) \} \\
{\mathrm{allocexport}}({\mathit{moduleinst}}, \mathsf{export}~{\mathit{name}}~(\mathsf{func}~x)) & = & \{ \mathsf{name}~{\mathit{name}},\;\allowbreak \mathsf{addr}~(\mathsf{func}~{\mathit{moduleinst}}{.}\mathsf{funcs}{}[x]) \} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{{\mathrm{allocexport}}^\ast}}{({\mathit{moduleinst}}, {{\mathit{export}}^\ast})} & = & {{\mathrm{allocexport}}({\mathit{moduleinst}}, {\mathit{export}})^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{allocmodule}}(s, {\mathit{module}}, {{\mathit{externaddr}}^\ast}, {{\mathit{val}}_{\mathsf{g}}^\ast}, {{\mathit{ref}}_{\mathsf{t}}^\ast}, {({{\mathit{ref}}_{\mathsf{e}}^\ast})^\ast}) & = & (s_7, {\mathit{moduleinst}}) &  \\
 \multicolumn{4}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {\mathit{module}} = \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{tag}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast} \\
{\land}~ {{\mathit{tag}}^\ast} = {(\mathsf{tag}~{\mathit{tagtype}})^\ast} \\
{\land}~ {{\mathit{global}}^\ast} = {(\mathsf{global}~{\mathit{globaltype}}~{\mathit{expr}}_{\mathsf{g}})^\ast} \\
{\land}~ {{\mathit{mem}}^\ast} = {(\mathsf{memory}~{\mathit{memtype}})^\ast} \\
{\land}~ {{\mathit{table}}^\ast} = {(\mathsf{table}~{\mathit{tabletype}}~{\mathit{expr}}_{\mathsf{t}})^\ast} \\
{\land}~ {{\mathit{func}}^\ast} = {(\mathsf{func}~x~{{\mathit{local}}^\ast}~{\mathit{expr}}_{\mathsf{f}})^\ast} \\
{\land}~ {{\mathit{data}}^\ast} = {(\mathsf{data}~{{\mathit{byte}}^\ast}~{\mathit{datamode}})^\ast} \\
{\land}~ {{\mathit{elem}}^\ast} = {(\mathsf{elem}~{\mathit{elemtype}}~{{\mathit{expr}}_{\mathsf{e}}^\ast}~{\mathit{elemmode}})^\ast} \\
{\land}~ {{\mathit{aa}}_{\mathsf{i}}^\ast} = {\mathrm{tags}}({{\mathit{externaddr}}^\ast}) \\
{\land}~ {{\mathit{ga}}_{\mathsf{i}}^\ast} = {\mathrm{globals}}({{\mathit{externaddr}}^\ast}) \\
{\land}~ {{\mathit{ma}}_{\mathsf{i}}^\ast} = {\mathrm{mems}}({{\mathit{externaddr}}^\ast}) \\
{\land}~ {{\mathit{ta}}_{\mathsf{i}}^\ast} = {\mathrm{tables}}({{\mathit{externaddr}}^\ast}) \\
{\land}~ {{\mathit{fa}}_{\mathsf{i}}^\ast} = {\mathrm{funcs}}({{\mathit{externaddr}}^\ast}) \\
{\land}~ {{\mathit{dt}}^\ast} = {{{\mathrm{alloctype}}^\ast}}{({{\mathit{type}}^\ast})} \\
{\land}~ {{\mathit{fa}}^\ast} = {({|s{.}\mathsf{funcs}|} + i_{\mathsf{f}})^{i_{\mathsf{f}}<{|{{\mathit{func}}^\ast}|}}} \\
{\land}~ (s_1, {{\mathit{aa}}^\ast}) = {{{\mathrm{alloctag}}^\ast}}{(s, {{{\mathit{tagtype}}}{{}[ {:=}\, {{\mathit{dt}}^\ast} ]}^\ast})} \\
{\land}~ (s_2, {{\mathit{ga}}^\ast}) = {{{\mathrm{allocglobal}}^\ast}}{(s_1, {{{\mathit{globaltype}}}{{}[ {:=}\, {{\mathit{dt}}^\ast} ]}^\ast}, {{\mathit{val}}_{\mathsf{g}}^\ast})} \\
{\land}~ (s_3, {{\mathit{ma}}^\ast}) = {{{\mathrm{allocmem}}^\ast}}{(s_2, {{{\mathit{memtype}}}{{}[ {:=}\, {{\mathit{dt}}^\ast} ]}^\ast})} \\
{\land}~ (s_4, {{\mathit{ta}}^\ast}) = {{{\mathrm{alloctable}}^\ast}}{(s_3, {{{\mathit{tabletype}}}{{}[ {:=}\, {{\mathit{dt}}^\ast} ]}^\ast}, {{\mathit{ref}}_{\mathsf{t}}^\ast})} \\
{\land}~ (s_5, {{\mathit{da}}^\ast}) = {{{\mathrm{allocdata}}^\ast}}{(s_4, {\mathsf{ok}^{{|{{\mathit{data}}^\ast}|}}}, {({{\mathit{byte}}^\ast})^\ast})} \\
{\land}~ (s_6, {{\mathit{ea}}^\ast}) = {{{\mathrm{allocelem}}^\ast}}{(s_5, {{{\mathit{elemtype}}}{{}[ {:=}\, {{\mathit{dt}}^\ast} ]}^\ast}, {({{\mathit{ref}}_{\mathsf{e}}^\ast})^\ast})} \\
{\land}~ (s_7, {{\mathit{fa}}^\ast}) = {{{\mathrm{allocfunc}}^\ast}}{(s_6, {{{\mathit{dt}}^\ast}{}[x]^\ast}, {(\mathsf{func}~x~{{\mathit{local}}^\ast}~{\mathit{expr}}_{\mathsf{f}})^\ast}, {{\mathit{moduleinst}}^{{|{{\mathit{func}}^\ast}|}}})} \\
{\land}~ {{\mathit{xi}}^\ast} = {{{\mathrm{allocexport}}^\ast}}{(\{ \mathsf{tags}~{{\mathit{aa}}_{\mathsf{i}}^\ast}~{{\mathit{aa}}^\ast},\; \mathsf{globals}~{{\mathit{ga}}_{\mathsf{i}}^\ast}~{{\mathit{ga}}^\ast},\; \mathsf{mems}~{{\mathit{ma}}_{\mathsf{i}}^\ast}~{{\mathit{ma}}^\ast},\; \mathsf{tables}~{{\mathit{ta}}_{\mathsf{i}}^\ast}~{{\mathit{ta}}^\ast},\; \mathsf{funcs}~{{\mathit{fa}}_{\mathsf{i}}^\ast}~{{\mathit{fa}}^\ast} \}, {{\mathit{export}}^\ast})} \\
{\land}~ {\mathit{moduleinst}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{types}~{{\mathit{dt}}^\ast},\; \\
  \mathsf{tags}~{{\mathit{aa}}_{\mathsf{i}}^\ast}~{{\mathit{aa}}^\ast},\; \mathsf{globals}~{{\mathit{ga}}_{\mathsf{i}}^\ast}~{{\mathit{ga}}^\ast},\; \\
  \mathsf{mems}~{{\mathit{ma}}_{\mathsf{i}}^\ast}~{{\mathit{ma}}^\ast},\; \\
  \mathsf{tables}~{{\mathit{ta}}_{\mathsf{i}}^\ast}~{{\mathit{ta}}^\ast},\; \mathsf{funcs}~{{\mathit{fa}}_{\mathsf{i}}^\ast}~{{\mathit{fa}}^\ast},\; \mathsf{datas}~{{\mathit{da}}^\ast},\; \\
  \mathsf{elems}~{{\mathit{ea}}^\ast},\; \mathsf{exports}~{{\mathit{xi}}^\ast} \}\end{array} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{rundata}}}_{x}(\mathsf{data}~{b^{n}}~(\mathsf{passive})) & = & \epsilon \\
{{\mathrm{rundata}}}_{x}(\mathsf{data}~{b^{n}}~(\mathsf{active}~y~{{\mathit{instr}}^\ast})) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{{\mathit{instr}}^\ast}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~0)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{memory{.}init}~y~x)~(\mathsf{data{.}drop}~x) \\
\end{array}
} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{\mathrm{runelem}}}_{x}(\mathsf{elem}~{\mathit{rt}}~{e^{n}}~(\mathsf{passive})) & = & \epsilon \\
{{\mathrm{runelem}}}_{x}(\mathsf{elem}~{\mathit{rt}}~{e^{n}}~(\mathsf{declare})) & = & (\mathsf{elem{.}drop}~x) \\
{{\mathrm{runelem}}}_{x}(\mathsf{elem}~{\mathit{rt}}~{e^{n}}~(\mathsf{active}~y~{{\mathit{instr}}^\ast})) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{{\mathit{instr}}^\ast}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~0)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{table{.}init}~y~x)~(\mathsf{elem{.}drop}~x) \\
\end{array}
} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{{\mathrm{evalglobal}}^\ast}}{(z, \epsilon, \epsilon)} & = & (z, \epsilon) \\
{{{\mathrm{evalglobal}}^\ast}}{(z, {\mathit{gt}}~{{\mathit{gt}'}^\ast}, {\mathit{expr}}~{{\mathit{expr}'}^\ast})} & = & ({z'}, {\mathit{val}}~{{\mathit{val}'}^\ast}) &  \\
&& \multicolumn{2}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ z ; {\mathit{expr}} \hookrightarrow^\ast z ; {\mathit{val}} \\
{\land}~ z = s ; f \\
{\land}~ ({s'}, a) = {\mathrm{allocglobal}}(s, {\mathit{gt}}, {\mathit{val}}) \\
{\land}~ ({z'}, {{\mathit{val}'}^\ast}) = {{{\mathrm{evalglobal}}^\ast}}{(({s'} ; f{}[{.}\mathsf{module}{.}\mathsf{globals} \mathrel{{=}{\oplus}} a]), {{\mathit{gt}'}^\ast}, {{\mathit{expr}'}^\ast})} \\
\end{array}
} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{instantiate}}(s, {\mathit{module}}, {{\mathit{externaddr}}^\ast}) & = & {s'} ; \{ \mathsf{module}~{\mathit{moduleinst}} \} ; {{\mathit{instr}}_{\mathsf{e}}^\ast}~{{\mathit{instr}}_{\mathsf{d}}^\ast}~{{\mathit{instr}}_{\mathsf{s}}^?} &  \\
 \multicolumn{4}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {\vdash}\, {\mathit{module}} : {{\mathit{xt}}_{\mathsf{i}}^\ast} \rightarrow {{\mathit{xt}}_{\mathsf{e}}^\ast} \\
{\land}~ (s \vdash {\mathit{externaddr}} : {\mathit{xt}}_{\mathsf{i}})^\ast \\[0.8ex]
{\land}~ {\mathit{module}} = \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{tag}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast} \\
{\land}~ {{\mathit{global}}^\ast} = {(\mathsf{global}~{\mathit{globaltype}}~{\mathit{expr}}_{\mathsf{g}})^\ast} \\
{\land}~ {{\mathit{table}}^\ast} = {(\mathsf{table}~{\mathit{tabletype}}~{\mathit{expr}}_{\mathsf{t}})^\ast} \\
{\land}~ {{\mathit{data}}^\ast} = {(\mathsf{data}~{{\mathit{byte}}^\ast}~{\mathit{datamode}})^\ast} \\
{\land}~ {{\mathit{elem}}^\ast} = {(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}_{\mathsf{e}}^\ast}~{\mathit{elemmode}})^\ast} \\
{\land}~ {{\mathit{start}}^?} = {(\mathsf{start}~x)^?} \\
{\land}~ {\mathit{moduleinst}}_0 = \{ \begin{array}[t]{@{}l@{}}
\mathsf{types}~{{{\mathrm{alloctype}}^\ast}}{({{\mathit{type}}^\ast})},\; \\
  \mathsf{globals}~{\mathrm{globals}}({{\mathit{externaddr}}^\ast}),\; \\
  \mathsf{funcs}~{\mathrm{funcs}}({{\mathit{externaddr}}^\ast})~{({|s{.}\mathsf{funcs}|} + i_{\mathsf{f}})^{i_{\mathsf{f}}<{|{{\mathit{func}}^\ast}|}}} \}\end{array} \\
{\land}~ z = s ; \{ \mathsf{module}~{\mathit{moduleinst}}_0 \} \\
{\land}~ ({z'}, {{\mathit{val}}_{\mathsf{g}}^\ast}) = {{{\mathrm{evalglobal}}^\ast}}{(z, {{\mathit{globaltype}}^\ast}, {{\mathit{expr}}_{\mathsf{g}}^\ast})} \\
{\land}~ ({z'} ; {\mathit{expr}}_{\mathsf{t}} \hookrightarrow^\ast {z'} ; {\mathit{ref}}_{\mathsf{t}})^\ast \\
{\land}~ {({z'} ; {\mathit{expr}}_{\mathsf{e}} \hookrightarrow^\ast {z'} ; {\mathit{ref}}_{\mathsf{e}})^\ast}^\ast \\
{\land}~ ({s'}, {\mathit{moduleinst}}) = {\mathrm{allocmodule}}(s, {\mathit{module}}, {{\mathit{externaddr}}^\ast}, {{\mathit{val}}_{\mathsf{g}}^\ast}, {{\mathit{ref}}_{\mathsf{t}}^\ast}, {({{\mathit{ref}}_{\mathsf{e}}^\ast})^\ast}) \\
{\land}~ {{\mathit{instr}}_{\mathsf{d}}^\ast} = {\bigoplus}\, {{{\mathrm{rundata}}}_{i_{\mathsf{d}}}({{\mathit{data}}^\ast}{}[i_{\mathsf{d}}])^{i_{\mathsf{d}}<{|{{\mathit{data}}^\ast}|}}} \\
{\land}~ {{\mathit{instr}}_{\mathsf{e}}^\ast} = {\bigoplus}\, {{{\mathrm{runelem}}}_{i_{\mathsf{e}}}({{\mathit{elem}}^\ast}{}[i_{\mathsf{e}}])^{i_{\mathsf{e}}<{|{{\mathit{elem}}^\ast}|}}} \\
{\land}~ {{\mathit{instr}}_{\mathsf{s}}^?} = {(\mathsf{call}~x)^?} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{invoke}}(s, {\mathit{funcaddr}}, {{\mathit{val}}^\ast}) & = & s ; \{ \mathsf{module}~\{  \} \} ; {{\mathit{val}}^\ast}~(\mathsf{ref{.}func}~{\mathit{funcaddr}})~(\mathsf{call\_ref}~s{.}\mathsf{funcs}{}[{\mathit{funcaddr}}]{.}\mathsf{type}) &  \\
 \multicolumn{4}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ s{.}\mathsf{funcs}{}[{\mathit{funcaddr}}]{.}\mathsf{type} \approx \mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast} \\
{\land}~ (s \vdash {\mathit{val}} : t_1)^\ast \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{byte}} & ::= & \mathtt{0x00} ~~|~~ \ldots ~~|~~ \mathtt{0xFF} \\
& {{\mathtt{u}}}{N} & ::= & n{:}{\mathtt{byte}} & \quad\Rightarrow\quad{} & n & \quad \mbox{if}~ n < {2^{7}} \land n < {2^{N}} \\
& & | & n{:}{\mathtt{byte}}~~m{:}{{\mathtt{u}}}{(N - 7)} & \quad\Rightarrow\quad{} & {2^{7}} \cdot m + (n - {2^{7}}) & \quad \mbox{if}~ n \geq {2^{7}} \land N > 7 \\
& {{\mathtt{s}}}{N} & ::= & n{:}{\mathtt{byte}} & \quad\Rightarrow\quad{} & n & \quad \mbox{if}~ n < {2^{6}} \land n < {2^{N - 1}} \\
& & | & n{:}{\mathtt{byte}} & \quad\Rightarrow\quad{} & n - {2^{7}} & \quad \mbox{if}~ {2^{6}} \leq n < {2^{7}} \land n \geq {2^{7}} - {2^{N - 1}} \\
& & | & n{:}{\mathtt{byte}}~~i{:}{{\mathtt{u}}}{(N - 7)} & \quad\Rightarrow\quad{} & {2^{7}} \cdot i + (n - {2^{7}}) & \quad \mbox{if}~ n \geq {2^{7}} \land N > 7 \\
& {{\mathtt{i}}}{N} & ::= & i{:}{{\mathtt{s}}}{N} & \quad\Rightarrow\quad{} & {{{{\mathrm{signed}}}_{N}^{{-1}}}}{(i)} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{f}}}{N} & ::= & {b^\ast}{:}{{\mathtt{byte}}^{N / 8}} & \quad\Rightarrow\quad{} & {{{{\mathrm{bytes}}}_{{\mathsf{f}}{N}}^{{-1}}}}{({b^\ast})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{u32}} & ::= & n{:}{{\mathtt{u}}}{32} & \quad\Rightarrow\quad{} & n \\
& {\mathtt{u64}} & ::= & n{:}{{\mathtt{u}}}{64} & \quad\Rightarrow\quad{} & n \\
& {\mathtt{s33}} & ::= & i{:}{{\mathtt{s}}}{33} & \quad\Rightarrow\quad{} & i \\
& {\mathtt{f32}} & ::= & p{:}{{\mathtt{f}}}{32} & \quad\Rightarrow\quad{} & p \\
& {\mathtt{f64}} & ::= & p{:}{{\mathtt{f}}}{64} & \quad\Rightarrow\quad{} & p \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{list}}({\mathtt{X}}) & ::= & n{:}{\mathtt{u32}}~~{({\mathit{el}}{:}{\mathtt{X}})^{n}} & \quad\Rightarrow\quad{} & {{\mathit{el}}^{n}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{cont}}(b) & = & b - \mathtt{0x80} & \quad \mbox{if}~ (\mathtt{0x80} < b < \mathtt{0xC0}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{utf{\kern-0.1em\scriptstyle 8}}}({{\mathit{ch}}^\ast}) & = & {\bigoplus}\, {{\mathrm{utf{\kern-0.1em\scriptstyle 8}}}({\mathit{ch}})^\ast} \\
{\mathrm{utf{\kern-0.1em\scriptstyle 8}}}({\mathit{ch}}) & = & b & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {\mathit{ch}} < \mathrm{U{+}80} \\
{\land}~ {\mathit{ch}} = b \\
\end{array} \\
{\mathrm{utf{\kern-0.1em\scriptstyle 8}}}({\mathit{ch}}) & = & b_1~b_2 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ \mathrm{U{+}80} \leq {\mathit{ch}} < \mathrm{U{+}0800} \\
{\land}~ {\mathit{ch}} = {2^{6}} \cdot (b_1 - \mathtt{0xC0}) + {\mathrm{cont}}(b_2) \\
\end{array} \\
{\mathrm{utf{\kern-0.1em\scriptstyle 8}}}({\mathit{ch}}) & = & b_1~b_2~b_3 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ \mathrm{U{+}0800} \leq {\mathit{ch}} < \mathrm{U{+}D800} \lor \mathrm{U{+}E000} \leq {\mathit{ch}} < \mathrm{U{+}10000} \\
{\land}~ {\mathit{ch}} = {2^{12}} \cdot (b_1 - \mathtt{0xE0}) + {2^{6}} \cdot {\mathrm{cont}}(b_2) + {\mathrm{cont}}(b_3) \\
\end{array} \\
{\mathrm{utf{\kern-0.1em\scriptstyle 8}}}({\mathit{ch}}) & = & b_1~b_2~b_3~b_4 & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ \mathrm{U{+}10000} \leq {\mathit{ch}} < \mathrm{U{+}11000} \\
{\land}~ {\mathit{ch}} = {2^{18}} \cdot (b_1 - \mathtt{0xF0}) + {2^{12}} \cdot {\mathrm{cont}}(b_2) + {2^{6}} \cdot {\mathrm{cont}}(b_3) + {\mathrm{cont}}(b_4) \\
\end{array} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{name}} & ::= & {b^\ast}{:}{\mathtt{list}}({\mathtt{byte}}) & \quad\Rightarrow\quad{} & {\mathit{name}} & \quad \mbox{if}~ {\mathrm{utf{\kern-0.1em\scriptstyle 8}}}({\mathit{name}}) = {b^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{typeidx}} & ::= & x{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & x \\
& {\mathtt{tagidx}} & ::= & x{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & x \\
& {\mathtt{globalidx}} & ::= & x{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & x \\
& {\mathtt{memidx}} & ::= & x{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & x \\
& {\mathtt{tableidx}} & ::= & x{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & x \\
& {\mathtt{funcidx}} & ::= & x{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & x \\
& {\mathtt{dataidx}} & ::= & x{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & x \\
& {\mathtt{elemidx}} & ::= & x{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & x \\
& {\mathtt{localidx}} & ::= & x{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & x \\
& {\mathtt{labelidx}} & ::= & l{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & l \\
& {\mathtt{externidx}} & ::= & \mathtt{0x00}~~x{:}{\mathtt{funcidx}} & \quad\Rightarrow\quad{} & \mathsf{func}~x \\
& & | & \mathtt{0x01}~~x{:}{\mathtt{tableidx}} & \quad\Rightarrow\quad{} & \mathsf{table}~x \\
& & | & \mathtt{0x02}~~x{:}{\mathtt{memidx}} & \quad\Rightarrow\quad{} & \mathsf{mem}~x \\
& & | & \mathtt{0x03}~~x{:}{\mathtt{globalidx}} & \quad\Rightarrow\quad{} & \mathsf{global}~x \\
& & | & \mathtt{0x04}~~x{:}{\mathtt{tagidx}} & \quad\Rightarrow\quad{} & \mathsf{tag}~x \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{numtype}} & ::= & \mathtt{0x7C} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} \\
& & | & \mathtt{0x7D} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} \\
& & | & \mathtt{0x7E} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} \\
& & | & \mathtt{0x7F} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} \\
& {\mathtt{vectype}} & ::= & \mathtt{0x7B} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}} \\
& {\mathtt{absheaptype}} & ::= & \mathtt{0x69} & \quad\Rightarrow\quad{} & \mathsf{exn} \\
& & | & \mathtt{0x6A} & \quad\Rightarrow\quad{} & \mathsf{array} \\
& & | & \mathtt{0x6B} & \quad\Rightarrow\quad{} & \mathsf{struct} \\
& & | & \mathtt{0x6C} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 31}} \\
& & | & \mathtt{0x6D} & \quad\Rightarrow\quad{} & \mathsf{eq} \\
& & | & \mathtt{0x6E} & \quad\Rightarrow\quad{} & \mathsf{any} \\
& & | & \mathtt{0x6F} & \quad\Rightarrow\quad{} & \mathsf{extern} \\
& & | & \mathtt{0x70} & \quad\Rightarrow\quad{} & \mathsf{func} \\
& & | & \mathtt{0x71} & \quad\Rightarrow\quad{} & \mathsf{none} \\
& & | & \mathtt{0x72} & \quad\Rightarrow\quad{} & \mathsf{noextern} \\
& & | & \mathtt{0x73} & \quad\Rightarrow\quad{} & \mathsf{nofunc} \\
& & | & \mathtt{0x74} & \quad\Rightarrow\quad{} & \mathsf{noexn} \\
& {\mathtt{heaptype}} & ::= & {\mathit{ht}}{:}{\mathtt{absheaptype}} & \quad\Rightarrow\quad{} & {\mathit{ht}} \\
& & | & x{:}{\mathtt{s33}} & \quad\Rightarrow\quad{} & x & \quad \mbox{if}~ x \geq 0 \\
& {\mathtt{reftype}} & ::= & \mathtt{0x63}~~{\mathit{ht}}{:}{\mathtt{heaptype}} & \quad\Rightarrow\quad{} & \mathsf{ref}~\mathsf{null}~{\mathit{ht}} \\
& & | & \mathtt{0x64}~~{\mathit{ht}}{:}{\mathtt{heaptype}} & \quad\Rightarrow\quad{} & \mathsf{ref}~{\mathit{ht}} \\
& & | & {\mathit{ht}}{:}{\mathtt{absheaptype}} & \quad\Rightarrow\quad{} & \mathsf{ref}~\mathsf{null}~{\mathit{ht}} \\
& {\mathtt{valtype}} & ::= & {\mathit{nt}}{:}{\mathtt{numtype}} & \quad\Rightarrow\quad{} & {\mathit{nt}} \\
& & | & {\mathit{vt}}{:}{\mathtt{vectype}} & \quad\Rightarrow\quad{} & {\mathit{vt}} \\
& & | & {\mathit{rt}}{:}{\mathtt{reftype}} & \quad\Rightarrow\quad{} & {\mathit{rt}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{resulttype}} & ::= & {t^\ast}{:}{\mathtt{list}}({\mathtt{valtype}}) & \quad\Rightarrow\quad{} & {t^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{mut}} & ::= & \mathtt{0x00} & \quad\Rightarrow\quad{} & \epsilon \\
& & | & \mathtt{0x01} & \quad\Rightarrow\quad{} & \mathsf{mut} \\
& {\mathtt{packtype}} & ::= & \mathtt{0x77} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 16}} \\
& & | & \mathtt{0x78} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 8}} \\
& {\mathtt{storagetype}} & ::= & t{:}{\mathtt{valtype}} & \quad\Rightarrow\quad{} & t \\
& & | & {\mathit{pt}}{:}{\mathtt{packtype}} & \quad\Rightarrow\quad{} & {\mathit{pt}} \\
& {\mathtt{fieldtype}} & ::= & {\mathit{zt}}{:}{\mathtt{storagetype}}~~{\mathsf{mut}^?}{:}{\mathtt{mut}} & \quad\Rightarrow\quad{} & {\mathsf{mut}^?}~{\mathit{zt}} \\
& {\mathtt{comptype}} & ::= & \mathtt{0x5E}~~{\mathit{ft}}{:}{\mathtt{fieldtype}} & \quad\Rightarrow\quad{} & \mathsf{array}~{\mathit{ft}} \\
& & | & \mathtt{0x5F}~~{{\mathit{ft}}^\ast}{:}{\mathtt{list}}({\mathtt{fieldtype}}) & \quad\Rightarrow\quad{} & \mathsf{struct}~{{\mathit{ft}}^\ast} \\
& & | & \mathtt{0x60}~~{t_1^\ast}{:}{\mathtt{resulttype}}~~{t_2^\ast}{:}{\mathtt{resulttype}} & \quad\Rightarrow\quad{} & \mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast} \\
& {\mathtt{subtype}} & ::= & \mathtt{0x4F}~~{x^\ast}{:}{\mathtt{list}}({\mathtt{typeidx}})~~{\mathit{ct}}{:}{\mathtt{comptype}} & \quad\Rightarrow\quad{} & \mathsf{sub}~\mathsf{final}~{x^\ast}~{\mathit{ct}} \\
& & | & \mathtt{0x50}~~{x^\ast}{:}{\mathtt{list}}({\mathtt{typeidx}})~~{\mathit{ct}}{:}{\mathtt{comptype}} & \quad\Rightarrow\quad{} & \mathsf{sub}~{x^\ast}~{\mathit{ct}} \\
& & | & {\mathit{ct}}{:}{\mathtt{comptype}} & \quad\Rightarrow\quad{} & \mathsf{sub}~\mathsf{final}~\epsilon~{\mathit{ct}} \\
& {\mathtt{rectype}} & ::= & \mathtt{0x4E}~~{{\mathit{st}}^\ast}{:}{\mathtt{list}}({\mathtt{subtype}}) & \quad\Rightarrow\quad{} & \mathsf{rec}~{{\mathit{st}}^\ast} \\
& & | & {\mathit{st}}{:}{\mathtt{subtype}} & \quad\Rightarrow\quad{} & \mathsf{rec}~{\mathit{st}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{limits}} & ::= & \mathtt{0x00}~~n{:}{\mathtt{u64}} & \quad\Rightarrow\quad{} & (\mathsf{i{\scriptstyle 32}}, {}[ n .. \epsilon ]) \\
& & | & \mathtt{0x01}~~n{:}{\mathtt{u64}}~~m{:}{\mathtt{u64}} & \quad\Rightarrow\quad{} & (\mathsf{i{\scriptstyle 32}}, {}[ n .. m ]) \\
& & | & \mathtt{0x04}~~n{:}{\mathtt{u64}} & \quad\Rightarrow\quad{} & (\mathsf{i{\scriptstyle 64}}, {}[ n .. \epsilon ]) \\
& & | & \mathtt{0x05}~~n{:}{\mathtt{u64}}~~m{:}{\mathtt{u64}} & \quad\Rightarrow\quad{} & (\mathsf{i{\scriptstyle 64}}, {}[ n .. m ]) \\
& {\mathtt{tagtype}} & ::= & \mathtt{0x00}~~x{:}{\mathtt{typeidx}} & \quad\Rightarrow\quad{} & x \\
& {\mathtt{globaltype}} & ::= & t{:}{\mathtt{valtype}}~~{\mathsf{mut}^?}{:}{\mathtt{mut}} & \quad\Rightarrow\quad{} & {\mathsf{mut}^?}~t \\
& {\mathtt{memtype}} & ::= & ({\mathit{at}}, {\mathit{lim}}){:}{\mathtt{limits}} & \quad\Rightarrow\quad{} & {\mathit{at}}~{\mathit{lim}}~\mathsf{page} \\
& {\mathtt{tabletype}} & ::= & {\mathit{rt}}{:}{\mathtt{reftype}}~~({\mathit{at}}, {\mathit{lim}}){:}{\mathtt{limits}} & \quad\Rightarrow\quad{} & {\mathit{at}}~{\mathit{lim}}~{\mathit{rt}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{externtype}} & ::= & \mathtt{0x00}~~x{:}{\mathtt{typeidx}} & \quad\Rightarrow\quad{} & \mathsf{func}~x \\
& & | & \mathtt{0x01}~~{\mathit{tt}}{:}{\mathtt{tabletype}} & \quad\Rightarrow\quad{} & \mathsf{table}~{\mathit{tt}} \\
& & | & \mathtt{0x02}~~{\mathit{mt}}{:}{\mathtt{memtype}} & \quad\Rightarrow\quad{} & \mathsf{mem}~{\mathit{mt}} \\
& & | & \mathtt{0x03}~~{\mathit{gt}}{:}{\mathtt{globaltype}} & \quad\Rightarrow\quad{} & \mathsf{global}~{\mathit{gt}} \\
& & | & \mathtt{0x04}~~{\mathit{jt}}{:}{\mathtt{tagtype}} & \quad\Rightarrow\quad{} & \mathsf{tag}~{\mathit{jt}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{instr}} & ::= & \mathtt{0x00} & \quad\Rightarrow\quad{} & \mathsf{unreachable} \\
& & | & \mathtt{0x01} & \quad\Rightarrow\quad{} & \mathsf{nop} \\
& & | & \mathtt{0x1A} & \quad\Rightarrow\quad{} & \mathsf{drop} \\
& & | & \mathtt{0x1B} & \quad\Rightarrow\quad{} & \mathsf{select} \\
& & | & \mathtt{0x1C}~~{t^\ast}{:}{\mathtt{list}}({\mathtt{valtype}}) & \quad\Rightarrow\quad{} & \mathsf{select}~{t^\ast} \\
& & | & \dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{blocktype}} & ::= & \mathtt{0x40} & \quad\Rightarrow\quad{} & \epsilon \\
& & | & t{:}{\mathtt{valtype}} & \quad\Rightarrow\quad{} & t \\
& & | & i{:}{\mathtt{s33}} & \quad\Rightarrow\quad{} & i & \quad \mbox{if}~ i \geq 0 \\
& {\mathtt{instr}} & ::= & \dots \\
& & | & \mathtt{0x02}~~{\mathit{bt}}{:}{\mathtt{blocktype}}~~{({\mathit{in}}{:}{\mathtt{instr}})^\ast}~~\mathtt{0x0B} & \quad\Rightarrow\quad{} & \mathsf{block}~{\mathit{bt}}~{{\mathit{in}}^\ast} \\
& & | & \mathtt{0x03}~~{\mathit{bt}}{:}{\mathtt{blocktype}}~~{({\mathit{in}}{:}{\mathtt{instr}})^\ast}~~\mathtt{0x0B} & \quad\Rightarrow\quad{} & \mathsf{loop}~{\mathit{bt}}~{{\mathit{in}}^\ast} \\
& & | & \mathtt{0x04}~~{\mathit{bt}}{:}{\mathtt{blocktype}}~~{({\mathit{in}}{:}{\mathtt{instr}})^\ast}~~\mathtt{0x0B} & \quad\Rightarrow\quad{} & \mathsf{if}~{\mathit{bt}}~{{\mathit{in}}^\ast}~\mathsf{else}~\epsilon \\
& & | & \begin{array}[t]{@{}l@{}} \mathtt{0x04}~~{\mathit{bt}}{:}{\mathtt{blocktype}}~~{({\mathit{in}}_1{:}{\mathtt{instr}})^\ast} \\
  \mathtt{0x05}~~{({\mathit{in}}_2{:}{\mathtt{instr}})^\ast}~~\mathtt{0x0B} \end{array} & \quad\Rightarrow\quad{} & \mathsf{if}~{\mathit{bt}}~{{\mathit{in}}_1^\ast}~\mathsf{else}~{{\mathit{in}}_2^\ast} \\
& & | & \mathtt{0x08}~~x{:}{\mathtt{tagidx}} & \quad\Rightarrow\quad{} & \mathsf{throw}~x \\
& & | & \mathtt{0x0A} & \quad\Rightarrow\quad{} & \mathsf{throw\_ref} \\
& & | & \mathtt{0x0C}~~l{:}{\mathtt{labelidx}} & \quad\Rightarrow\quad{} & \mathsf{br}~l \\
& & | & \mathtt{0x0D}~~l{:}{\mathtt{labelidx}} & \quad\Rightarrow\quad{} & \mathsf{br\_if}~l \\
& & | & \mathtt{0x0E}~~{l^\ast}{:}{\mathtt{list}}({\mathtt{labelidx}})~~l_n{:}{\mathtt{labelidx}} & \quad\Rightarrow\quad{} & \mathsf{br\_table}~{l^\ast}~l_n \\
& & | & \mathtt{0x0F} & \quad\Rightarrow\quad{} & \mathsf{return} \\
& & | & \mathtt{0x10}~~x{:}{\mathtt{funcidx}} & \quad\Rightarrow\quad{} & \mathsf{call}~x \\
& & | & \mathtt{0x11}~~y{:}{\mathtt{typeidx}}~~x{:}{\mathtt{tableidx}} & \quad\Rightarrow\quad{} & \mathsf{call\_indirect}~x~y \\
& & | & \mathtt{0x12}~~x{:}{\mathtt{funcidx}} & \quad\Rightarrow\quad{} & \mathsf{return\_call}~x \\
& & | & \mathtt{0x13}~~y{:}{\mathtt{typeidx}}~~x{:}{\mathtt{tableidx}} & \quad\Rightarrow\quad{} & \mathsf{return\_call\_indirect}~x~y \\
& & | & \mathtt{0x1F}~~{\mathit{bt}}{:}{\mathtt{blocktype}}~~{c^\ast}{:}{\mathtt{list}}({\mathtt{catch}})~~{({\mathit{in}}{:}{\mathtt{instr}})^\ast}~~\mathtt{0x0B} & \quad\Rightarrow\quad{} & \mathsf{try\_table}~{\mathit{bt}}~{c^\ast}~{{\mathit{in}}^\ast} \\
& & | & \dots \\
& {\mathtt{catch}} & ::= & \mathtt{0x00}~~x{:}{\mathtt{tagidx}}~~l{:}{\mathtt{labelidx}} & \quad\Rightarrow\quad{} & \mathsf{catch}~x~l \\
& & | & \mathtt{0x01}~~x{:}{\mathtt{tagidx}}~~l{:}{\mathtt{labelidx}} & \quad\Rightarrow\quad{} & \mathsf{catch\_ref}~x~l \\
& & | & \mathtt{0x02}~~l{:}{\mathtt{labelidx}} & \quad\Rightarrow\quad{} & \mathsf{catch\_all}~l \\
& & | & \mathtt{0x03}~~l{:}{\mathtt{labelidx}} & \quad\Rightarrow\quad{} & \mathsf{catch\_all\_ref}~l \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{instr}} & ::= & \dots \\
& & | & \mathtt{0x20}~~x{:}{\mathtt{localidx}} & \quad\Rightarrow\quad{} & \mathsf{local{.}get}~x \\
& & | & \mathtt{0x21}~~x{:}{\mathtt{localidx}} & \quad\Rightarrow\quad{} & \mathsf{local{.}set}~x \\
& & | & \mathtt{0x22}~~x{:}{\mathtt{localidx}} & \quad\Rightarrow\quad{} & \mathsf{local{.}tee}~x \\
& & | & \mathtt{0x23}~~x{:}{\mathtt{globalidx}} & \quad\Rightarrow\quad{} & \mathsf{global{.}get}~x \\
& & | & \mathtt{0x24}~~x{:}{\mathtt{globalidx}} & \quad\Rightarrow\quad{} & \mathsf{global{.}set}~x \\
& & | & \dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{instr}} & ::= & \dots \\
& & | & \mathtt{0x25}~~x{:}{\mathtt{tableidx}} & \quad\Rightarrow\quad{} & \mathsf{table{.}get}~x \\
& & | & \mathtt{0x26}~~x{:}{\mathtt{tableidx}} & \quad\Rightarrow\quad{} & \mathsf{table{.}set}~x \\
& & | & \mathtt{0xFC}~~12{:}{\mathtt{u32}}~~y{:}{\mathtt{elemidx}}~~x{:}{\mathtt{tableidx}} & \quad\Rightarrow\quad{} & \mathsf{table{.}init}~x~y \\
& & | & \mathtt{0xFC}~~13{:}{\mathtt{u32}}~~x{:}{\mathtt{elemidx}} & \quad\Rightarrow\quad{} & \mathsf{elem{.}drop}~x \\
& & | & \mathtt{0xFC}~~14{:}{\mathtt{u32}}~~x_1{:}{\mathtt{tableidx}}~~x_2{:}{\mathtt{tableidx}} & \quad\Rightarrow\quad{} & \mathsf{table{.}copy}~x_1~x_2 \\
& & | & \mathtt{0xFC}~~15{:}{\mathtt{u32}}~~x{:}{\mathtt{tableidx}} & \quad\Rightarrow\quad{} & \mathsf{table{.}grow}~x \\
& & | & \mathtt{0xFC}~~16{:}{\mathtt{u32}}~~x{:}{\mathtt{tableidx}} & \quad\Rightarrow\quad{} & \mathsf{table{.}size}~x \\
& & | & \mathtt{0xFC}~~17{:}{\mathtt{u32}}~~x{:}{\mathtt{tableidx}} & \quad\Rightarrow\quad{} & \mathsf{table{.}fill}~x \\
& & | & \dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{memidxop}} & ::= & ({\mathit{memidx}}, {\mathit{memarg}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{memarg}} & ::= & n{:}{\mathtt{u32}}~~m{:}{\mathtt{u64}} & \quad\Rightarrow\quad{} & (0, \{ \mathsf{align}~n,\;\allowbreak \mathsf{offset}~m \}) & \quad \mbox{if}~ n < {2^{6}} \\
& & | & n{:}{\mathtt{u32}}~~x{:}{\mathtt{memidx}}~~m{:}{\mathtt{u64}} & \quad\Rightarrow\quad{} & (x, \{ \mathsf{align}~(n - {2^{6}}),\;\allowbreak \mathsf{offset}~m \}) & \quad \mbox{if}~ {2^{6}} \leq n < {2^{7}} \\
& {\mathtt{instr}} & ::= & \dots \\
& & | & \mathtt{0x28}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}}{.}\mathsf{load}~x~{\mathit{ao}} \\
& & | & \mathtt{0x29}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}}{.}\mathsf{load}~x~{\mathit{ao}} \\
& & | & \mathtt{0x2A}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}}{.}\mathsf{load}~x~{\mathit{ao}} \\
& & | & \mathtt{0x2B}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}}{.}\mathsf{load}~x~{\mathit{ao}} \\
& & | & \mathtt{0x2C}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{s}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0x2D}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{u}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0x2E}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{s}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0x2F}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{u}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0x30}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{s}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0x31}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{u}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0x32}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{s}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0x33}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{u}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0x34}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 32}}}{\mathsf{\_}}{\mathsf{s}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0x35}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 32}}}{\mathsf{\_}}{\mathsf{u}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0x36}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}}{.}\mathsf{store}~x~{\mathit{ao}} \\
& & | & \mathtt{0x37}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}}{.}\mathsf{store}~x~{\mathit{ao}} \\
& & | & \mathtt{0x38}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}}{.}\mathsf{store}~x~{\mathit{ao}} \\
& & | & \mathtt{0x39}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}}{.}\mathsf{store}~x~{\mathit{ao}} \\
& & | & \mathtt{0x3A}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 8}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0x3B}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 16}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0x3C}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 8}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0x3D}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 16}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0x3E}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 32}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0x3F}~~x{:}{\mathtt{memidx}} & \quad\Rightarrow\quad{} & \mathsf{memory{.}size}~x \\
& & | & \mathtt{0x40}~~x{:}{\mathtt{memidx}} & \quad\Rightarrow\quad{} & \mathsf{memory{.}grow}~x \\
& & | & \mathtt{0xFC}~~8{:}{\mathtt{u32}}~~y{:}{\mathtt{dataidx}}~~x{:}{\mathtt{memidx}} & \quad\Rightarrow\quad{} & \mathsf{memory{.}init}~x~y \\
& & | & \mathtt{0xFC}~~9{:}{\mathtt{u32}}~~x{:}{\mathtt{dataidx}} & \quad\Rightarrow\quad{} & \mathsf{data{.}drop}~x \\
& & | & \mathtt{0xFC}~~10{:}{\mathtt{u32}}~~x_1{:}{\mathtt{memidx}}~~x_2{:}{\mathtt{memidx}} & \quad\Rightarrow\quad{} & \mathsf{memory{.}copy}~x_1~x_2 \\
& & | & \mathtt{0xFC}~~11{:}{\mathtt{u32}}~~x{:}{\mathtt{memidx}} & \quad\Rightarrow\quad{} & \mathsf{memory{.}fill}~x \\
& & | & \dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{castop}} & ::= & ({\mathsf{null}^?}, {\mathsf{null}^?}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{castop}} & ::= & \mathtt{0x00} & \quad\Rightarrow\quad{} & (\epsilon, \epsilon) \\
& & | & \mathtt{0x01} & \quad\Rightarrow\quad{} & (\mathsf{null}, \epsilon) \\
& & | & \mathtt{0x02} & \quad\Rightarrow\quad{} & (\epsilon, \mathsf{null}) \\
& & | & \mathtt{0x03} & \quad\Rightarrow\quad{} & (\mathsf{null}, \mathsf{null}) \\
& {\mathtt{instr}} & ::= & \dots \\
& & | & \mathtt{0xD0}~~{\mathit{ht}}{:}{\mathtt{heaptype}} & \quad\Rightarrow\quad{} & \mathsf{ref{.}null}~{\mathit{ht}} \\
& & | & \mathtt{0xD1} & \quad\Rightarrow\quad{} & \mathsf{ref{.}is\_null} \\
& & | & \mathtt{0xD2}~~x{:}{\mathtt{funcidx}} & \quad\Rightarrow\quad{} & \mathsf{ref{.}func}~x \\
& & | & \mathtt{0xD3} & \quad\Rightarrow\quad{} & \mathsf{ref{.}eq} \\
& & | & \mathtt{0xD4} & \quad\Rightarrow\quad{} & \mathsf{ref{.}as\_non\_null} \\
& & | & \mathtt{0xD5}~~l{:}{\mathtt{labelidx}} & \quad\Rightarrow\quad{} & \mathsf{br\_on\_null}~l \\
& & | & \mathtt{0xD6}~~l{:}{\mathtt{labelidx}} & \quad\Rightarrow\quad{} & \mathsf{br\_on\_non\_null}~l \\
& & | & \mathtt{0xFB}~~0{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}} & \quad\Rightarrow\quad{} & \mathsf{struct{.}new}~x \\
& & | & \mathtt{0xFB}~~1{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}} & \quad\Rightarrow\quad{} & \mathsf{struct{.}new\_default}~x \\
& & | & \mathtt{0xFB}~~2{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}}~~i{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{struct{.}get}~x~i \\
& & | & \mathtt{0xFB}~~3{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}}~~i{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{struct{.}get}}{\mathsf{\_}}{\mathsf{s}}~x~i \\
& & | & \mathtt{0xFB}~~4{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}}~~i{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{struct{.}get}}{\mathsf{\_}}{\mathsf{u}}~x~i \\
& & | & \mathtt{0xFB}~~5{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}}~~i{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{struct{.}set}~x~i \\
& & | & \mathtt{0xFB}~~6{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}} & \quad\Rightarrow\quad{} & \mathsf{array{.}new}~x \\
& & | & \mathtt{0xFB}~~7{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}} & \quad\Rightarrow\quad{} & \mathsf{array{.}new\_default}~x \\
& & | & \mathtt{0xFB}~~8{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}}~~n{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{array{.}new\_fixed}~x~n \\
& & | & \mathtt{0xFB}~~9{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}}~~y{:}{\mathtt{dataidx}} & \quad\Rightarrow\quad{} & \mathsf{array{.}new\_data}~x~y \\
& & | & \mathtt{0xFB}~~10{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}}~~y{:}{\mathtt{elemidx}} & \quad\Rightarrow\quad{} & \mathsf{array{.}new\_elem}~x~y \\
& & | & \mathtt{0xFB}~~11{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}} & \quad\Rightarrow\quad{} & \mathsf{array{.}get}~x \\
& & | & \mathtt{0xFB}~~12{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}} & \quad\Rightarrow\quad{} & {\mathsf{array{.}get}}{\mathsf{\_}}{\mathsf{s}}~x \\
& & | & \mathtt{0xFB}~~13{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}} & \quad\Rightarrow\quad{} & {\mathsf{array{.}get}}{\mathsf{\_}}{\mathsf{u}}~x \\
& & | & \mathtt{0xFB}~~14{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}} & \quad\Rightarrow\quad{} & \mathsf{array{.}set}~x \\
& & | & \mathtt{0xFB}~~15{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{array{.}len} \\
& & | & \mathtt{0xFB}~~16{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}} & \quad\Rightarrow\quad{} & \mathsf{array{.}fill}~x \\
& & | & \mathtt{0xFB}~~17{:}{\mathtt{u32}}~~x_1{:}{\mathtt{typeidx}}~~x_2{:}{\mathtt{typeidx}} & \quad\Rightarrow\quad{} & \mathsf{array{.}copy}~x_1~x_2 \\
& & | & \mathtt{0xFB}~~18{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}}~~y{:}{\mathtt{dataidx}} & \quad\Rightarrow\quad{} & \mathsf{array{.}init\_data}~x~y \\
& & | & \mathtt{0xFB}~~19{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}}~~y{:}{\mathtt{elemidx}} & \quad\Rightarrow\quad{} & \mathsf{array{.}init\_elem}~x~y \\
& & | & \mathtt{0xFB}~~20{:}{\mathtt{u32}}~~{\mathit{ht}}{:}{\mathtt{heaptype}} & \quad\Rightarrow\quad{} & \mathsf{ref{.}test}~(\mathsf{ref}~{\mathit{ht}}) \\
& & | & \mathtt{0xFB}~~21{:}{\mathtt{u32}}~~{\mathit{ht}}{:}{\mathtt{heaptype}} & \quad\Rightarrow\quad{} & \mathsf{ref{.}test}~(\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \\
& & | & \mathtt{0xFB}~~22{:}{\mathtt{u32}}~~{\mathit{ht}}{:}{\mathtt{heaptype}} & \quad\Rightarrow\quad{} & \mathsf{ref{.}cast}~(\mathsf{ref}~{\mathit{ht}}) \\
& & | & \mathtt{0xFB}~~23{:}{\mathtt{u32}}~~{\mathit{ht}}{:}{\mathtt{heaptype}} & \quad\Rightarrow\quad{} & \mathsf{ref{.}cast}~(\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \\
& & | & \begin{array}[t]{@{}l@{}} \mathtt{0xFB}~~24{:}{\mathtt{u32}}~~({{\mathsf{null}}_1^?}, {{\mathsf{null}}_2^?}){:}{\mathtt{castop}} \\
  l{:}{\mathtt{labelidx}}~~{\mathit{ht}}_1{:}{\mathtt{heaptype}}~~{\mathit{ht}}_2{:}{\mathtt{heaptype}} \end{array} & \quad\Rightarrow\quad{} & \mathsf{br\_on\_cast}~l~(\mathsf{ref}~{{\mathsf{null}}_1^?}~{\mathit{ht}}_1)~(\mathsf{ref}~{{\mathsf{null}}_2^?}~{\mathit{ht}}_2) \\
& & | & \begin{array}[t]{@{}l@{}} \mathtt{0xFB}~~25{:}{\mathtt{u32}}~~({{\mathsf{null}}_1^?}, {{\mathsf{null}}_2^?}){:}{\mathtt{castop}} \\
  l{:}{\mathtt{labelidx}}~~{\mathit{ht}}_1{:}{\mathtt{heaptype}}~~{\mathit{ht}}_2{:}{\mathtt{heaptype}} \end{array} & \quad\Rightarrow\quad{} & \mathsf{br\_on\_cast\_fail}~l~(\mathsf{ref}~{{\mathsf{null}}_1^?}~{\mathit{ht}}_1)~(\mathsf{ref}~{{\mathsf{null}}_2^?}~{\mathit{ht}}_2) \\
& & | & \mathtt{0xFB}~~26{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{any{.}convert\_extern} \\
& & | & \mathtt{0xFB}~~27{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{extern{.}convert\_any} \\
& & | & \mathtt{0xFB}~~28{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{ref{.}i{\scriptstyle 31}} \\
& & | & \mathtt{0xFB}~~29{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 31}{.}get}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFB}~~30{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 31}{.}get}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{instr}} & ::= & \dots \\
& & | & \mathtt{0x41}~~n{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n \\
& & | & \mathtt{0x42}~~n{:}{\mathtt{u64}} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}}{.}\mathsf{const}~n \\
& & | & \mathtt{0x43}~~p{:}{\mathtt{f32}} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}}{.}\mathsf{const}~p \\
& & | & \mathtt{0x44}~~p{:}{\mathtt{f64}} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}}{.}\mathsf{const}~p \\
& & | & \mathtt{0x45} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{eqz} \\
& & | & \mathtt{0x46} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{eq} \\
& & | & \mathtt{0x47} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{ne} \\
& & | & \mathtt{0x48} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0x49} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0x4A} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0x4B} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0x4C} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0x4D} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0x4E} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0x4F} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0x50} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{eqz} \\
& & | & \mathtt{0x51} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{eq} \\
& & | & \mathtt{0x52} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{ne} \\
& & | & \mathtt{0x53} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0x54} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0x55} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0x56} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0x57} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0x58} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0x59} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0x5A} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0x5B} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{eq} \\
& & | & \mathtt{0x5C} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{ne} \\
& & | & \mathtt{0x5D} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{lt} \\
& & | & \mathtt{0x5E} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{gt} \\
& & | & \mathtt{0x5F} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{le} \\
& & | & \mathtt{0x60} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{ge} \\
& & | & \mathtt{0x61} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{eq} \\
& & | & \mathtt{0x62} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{ne} \\
& & | & \mathtt{0x63} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{lt} \\
& & | & \mathtt{0x64} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{gt} \\
& & | & \mathtt{0x65} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{le} \\
& & | & \mathtt{0x66} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{ge} \\
& & | & \mathtt{0x67} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{clz} \\
& & | & \mathtt{0x68} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{ctz} \\
& & | & \mathtt{0x69} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{popcnt} \\
& & | & \mathtt{0x6A} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{add} \\
& & | & \mathtt{0x6B} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{sub} \\
& & | & \mathtt{0x6C} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{mul} \\
& & | & \mathtt{0x6D} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{div}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0x6E} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{div}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0x6F} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{rem}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0x70} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{rem}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0x71} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{and} \\
& & | & \mathtt{0x72} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{or} \\
& & | & \mathtt{0x73} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{xor} \\
& & | & \mathtt{0x74} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{shl} \\
& & | & \mathtt{0x75} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0x76} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0x77} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{rotl} \\
& & | & \mathtt{0x78} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{rotr} \\
& & | & \mathtt{0x79} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{clz} \\
& & | & \mathtt{0x7A} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{ctz} \\
& & | & \mathtt{0x7B} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{popcnt} \\
& & | & \mathtt{0xC0} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{extend}}{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xC1} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{extend}}{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xC2} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{extend}}{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xC3} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{extend}}{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xC4} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{extend}}{\mathsf{{\scriptstyle 32}}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0x7C} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{add} \\
& & | & \mathtt{0x7D} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{sub} \\
& & | & \mathtt{0x7E} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{mul} \\
& & | & \mathtt{0x7F} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{div}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0x80} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{div}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0x81} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{rem}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0x82} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{rem}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0x83} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{and} \\
& & | & \mathtt{0x84} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{or} \\
& & | & \mathtt{0x85} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{xor} \\
& & | & \mathtt{0x86} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{shl} \\
& & | & \mathtt{0x87} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0x88} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0x89} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{rotl} \\
& & | & \mathtt{0x8A} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{rotr} \\
& & | & \mathtt{0x8B} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{abs} \\
& & | & \mathtt{0x8C} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{neg} \\
& & | & \mathtt{0x8D} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{ceil} \\
& & | & \mathtt{0x8E} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{floor} \\
& & | & \mathtt{0x8F} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{trunc} \\
& & | & \mathtt{0x90} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{nearest} \\
& & | & \mathtt{0x91} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{sqrt} \\
& & | & \mathtt{0x92} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{add} \\
& & | & \mathtt{0x93} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{sub} \\
& & | & \mathtt{0x94} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{mul} \\
& & | & \mathtt{0x95} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{div} \\
& & | & \mathtt{0x96} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{min} \\
& & | & \mathtt{0x97} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{max} \\
& & | & \mathtt{0x98} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{copysign} \\
& & | & \mathtt{0x99} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{abs} \\
& & | & \mathtt{0x9A} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{neg} \\
& & | & \mathtt{0x9B} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{ceil} \\
& & | & \mathtt{0x9C} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{floor} \\
& & | & \mathtt{0x9D} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{trunc} \\
& & | & \mathtt{0x9E} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{nearest} \\
& & | & \mathtt{0x9F} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{sqrt} \\
& & | & \mathtt{0xA0} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{add} \\
& & | & \mathtt{0xA1} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{sub} \\
& & | & \mathtt{0xA2} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{mul} \\
& & | & \mathtt{0xA3} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{div} \\
& & | & \mathtt{0xA4} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{min} \\
& & | & \mathtt{0xA5} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{max} \\
& & | & \mathtt{0xA6} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{copysign} \\
& & | & \dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{instr}} & ::= & \dots \\
& & | & \mathtt{0xA7} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{wrap}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\
& & | & \mathtt{0xA8} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\
& & | & \mathtt{0xA9} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\
& & | & \mathtt{0xAA} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mathtt{0xAB} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mathtt{0xAC} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 32}}} \\
& & | & \mathtt{0xAD} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 32}}} \\
& & | & \mathtt{0xAE} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\
& & | & \mathtt{0xAF} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\
& & | & \mathtt{0xB0} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mathtt{0xB1} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mathtt{0xB2} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 32}}} \\
& & | & \mathtt{0xB3} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 32}}} \\
& & | & \mathtt{0xB4} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\
& & | & \mathtt{0xB5} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\
& & | & \mathtt{0xB6} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} {\mathsf{demote}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mathtt{0xB7} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 32}}} \\
& & | & \mathtt{0xB8} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 32}}} \\
& & | & \mathtt{0xB9} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\
& & | & \mathtt{0xBA} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\
& & | & \mathtt{0xBB} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} {\mathsf{promote}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mathtt{0xBC} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{reinterpret}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\
& & | & \mathtt{0xBD} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{reinterpret}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mathtt{0xBE} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} {\mathsf{reinterpret}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 32}}} \\
& & | & \mathtt{0xBF} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} {\mathsf{reinterpret}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\
& & | & \mathtt{0xFC}~~0{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\
& & | & \mathtt{0xFC}~~1{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\
& & | & \mathtt{0xFC}~~2{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mathtt{0xFC}~~3{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mathtt{0xFC}~~4{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\
& & | & \mathtt{0xFC}~~5{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\
& & | & \mathtt{0xFC}~~6{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mathtt{0xFC}~~7{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{laneidx}} & ::= & l{:}{\mathtt{byte}} & \quad\Rightarrow\quad{} & l \\
& {\mathtt{instr}} & ::= & \dots \\
& & | & \mathtt{0xFD}~~0{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}}{.}\mathsf{load}~x~{\mathit{ao}} \\
& & | & \mathtt{0xFD}~~1{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{s}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0xFD}~~2{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{u}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0xFD}~~3{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{\mathsf{\_}}{\mathsf{s}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0xFD}~~4{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{\mathsf{\_}}{\mathsf{u}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0xFD}~~5{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{\mathsf{\_}}{\mathsf{s}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0xFD}~~6{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{\mathsf{\_}}{\mathsf{u}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0xFD}~~7{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{splat}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0xFD}~~8{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{splat}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0xFD}~~9{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 32}}}{\mathsf{\_}}{\mathsf{splat}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0xFD}~~10{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 64}}}{\mathsf{\_}}{\mathsf{splat}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0xFD}~~11{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}}{.}\mathsf{store}~x~{\mathit{ao}} \\
& & | & \mathtt{0xFD}~~84{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}}~~i{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~i \\
& & | & \mathtt{0xFD}~~85{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}}~~i{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~i \\
& & | & \mathtt{0xFD}~~86{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}}~~i{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 32}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~i \\
& & | & \mathtt{0xFD}~~87{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}}~~i{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 64}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~i \\
& & | & \mathtt{0xFD}~~88{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}}~~i{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~i \\
& & | & \mathtt{0xFD}~~89{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}}~~i{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~i \\
& & | & \mathtt{0xFD}~~90{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}}~~i{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 32}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~i \\
& & | & \mathtt{0xFD}~~91{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}}~~i{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 64}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~i \\
& & | & \mathtt{0xFD}~~92{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 32}}}{\mathsf{\_}}{\mathsf{zero}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0xFD}~~93{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 64}}}{\mathsf{\_}}{\mathsf{zero}}}~x~{\mathit{ao}} \\
& & | & \mathtt{0xFD}~~12{:}{\mathtt{u32}}~~{(b{:}{\mathtt{byte}})^{16}} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~{{{{\mathrm{bytes}}}_{{\mathsf{i}}{\mathsf{{\scriptstyle 128}}}}^{{-1}}}}{({(b)^{16}})} \\
& & | & \mathtt{0xFD}~~13{:}{\mathtt{u32}}~~{(l{:}{\mathtt{laneidx}})^{16}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{shuffle}~{l^{16}} \\
& & | & \mathtt{0xFD}~~14{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{swizzle} \\
& & | & \mathtt{0xFD}~~256{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{relaxed\_swizzle} \\
& & | & \mathtt{0xFD}~~15{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{splat} \\
& & | & \mathtt{0xFD}~~16{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{splat} \\
& & | & \mathtt{0xFD}~~17{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{splat} \\
& & | & \mathtt{0xFD}~~18{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{splat} \\
& & | & \mathtt{0xFD}~~19{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{splat} \\
& & | & \mathtt{0xFD}~~20{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{splat} \\
& & | & \mathtt{0xFD}~~21{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{\mathsf{s}}~l \\
& & | & \mathtt{0xFD}~~22{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{\mathsf{u}}~l \\
& & | & \mathtt{0xFD}~~23{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{replace\_lane}~l \\
& & | & \mathtt{0xFD}~~24{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{\mathsf{s}}~l \\
& & | & \mathtt{0xFD}~~25{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{\mathsf{u}}~l \\
& & | & \mathtt{0xFD}~~26{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{replace\_lane}~l \\
& & | & \mathtt{0xFD}~~27{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{extract\_lane}~l \\
& & | & \mathtt{0xFD}~~28{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{replace\_lane}~l \\
& & | & \mathtt{0xFD}~~29{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{extract\_lane}~l \\
& & | & \mathtt{0xFD}~~30{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{replace\_lane}~l \\
& & | & \mathtt{0xFD}~~31{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{extract\_lane}~l \\
& & | & \mathtt{0xFD}~~32{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{replace\_lane}~l \\
& & | & \mathtt{0xFD}~~33{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{extract\_lane}~l \\
& & | & \mathtt{0xFD}~~34{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{replace\_lane}~l \\
& & | & \mathtt{0xFD}~~35{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{eq} \\
& & | & \mathtt{0xFD}~~36{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{ne} \\
& & | & \mathtt{0xFD}~~37{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~38{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~39{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~40{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~41{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~42{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~43{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~44{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~45{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{eq} \\
& & | & \mathtt{0xFD}~~46{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{ne} \\
& & | & \mathtt{0xFD}~~47{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~48{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~49{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~50{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~51{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~52{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~53{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~54{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~55{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{eq} \\
& & | & \mathtt{0xFD}~~56{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{ne} \\
& & | & \mathtt{0xFD}~~57{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~58{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~59{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~60{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~61{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~62{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~63{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~64{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~65{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{eq} \\
& & | & \mathtt{0xFD}~~66{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{ne} \\
& & | & \mathtt{0xFD}~~67{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{lt} \\
& & | & \mathtt{0xFD}~~68{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{gt} \\
& & | & \mathtt{0xFD}~~69{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{le} \\
& & | & \mathtt{0xFD}~~70{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{ge} \\
& & | & \mathtt{0xFD}~~71{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{eq} \\
& & | & \mathtt{0xFD}~~72{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{ne} \\
& & | & \mathtt{0xFD}~~73{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{lt} \\
& & | & \mathtt{0xFD}~~74{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{gt} \\
& & | & \mathtt{0xFD}~~75{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{le} \\
& & | & \mathtt{0xFD}~~76{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{ge} \\
& & | & \mathtt{0xFD}~~77{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}} {.} \mathsf{not} \\
& & | & \mathtt{0xFD}~~78{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}} {.} \mathsf{and} \\
& & | & \mathtt{0xFD}~~79{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}} {.} \mathsf{andnot} \\
& & | & \mathtt{0xFD}~~80{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}} {.} \mathsf{or} \\
& & | & \mathtt{0xFD}~~81{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}} {.} \mathsf{xor} \\
& & | & \mathtt{0xFD}~~82{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}} {.} \mathsf{bitselect} \\
& & | & \mathtt{0xFD}~~83{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}} {.} \mathsf{any\_true} \\
& & | & \mathtt{0xFD}~~96{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{abs} \\
& & | & \mathtt{0xFD}~~97{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{neg} \\
& & | & \mathtt{0xFD}~~98{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{popcnt} \\
& & | & \mathtt{0xFD}~~99{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{all\_true} \\
& & | & \mathtt{0xFD}~~100{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{bitmask} \\
& & | & \mathtt{0xFD}~~101{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{narrow}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~102{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{narrow}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~107{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{shl} \\
& & | & \mathtt{0xFD}~~108{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~109{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~110{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{add} \\
& & | & \mathtt{0xFD}~~111{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{add\_sat}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~112{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{add\_sat}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~113{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{sub} \\
& & | & \mathtt{0xFD}~~114{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{sub\_sat}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~115{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{sub\_sat}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~118{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{min}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~119{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{min}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~120{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{max}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~121{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{max}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~123{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{avgr}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~124{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extadd\_pairwise}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mathtt{0xFD}~~125{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extadd\_pairwise}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mathtt{0xFD}~~128{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{abs} \\
& & | & \mathtt{0xFD}~~129{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{neg} \\
& & | & \mathtt{0xFD}~~130{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{q{\scriptstyle 15}mulr\_sat}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~142{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{add} \\
& & | & \mathtt{0xFD}~~143{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{add\_sat}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~144{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{add\_sat}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~145{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{sub} \\
& & | & \mathtt{0xFD}~~146{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{sub\_sat}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~147{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{sub\_sat}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~149{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{mul} \\
& & | & \mathtt{0xFD}~~150{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{min}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~151{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{min}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~152{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{max}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~153{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{max}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~155{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{avgr}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~273{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{relaxed\_q{\scriptstyle 15}mulr}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~131{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{all\_true} \\
& & | & \mathtt{0xFD}~~132{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{bitmask} \\
& & | & \mathtt{0xFD}~~133{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{narrow}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~134{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{narrow}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~135{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mathtt{0xFD}~~136{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mathtt{0xFD}~~137{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mathtt{0xFD}~~138{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mathtt{0xFD}~~139{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{shl} \\
& & | & \mathtt{0xFD}~~140{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~141{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~156{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mathtt{0xFD}~~157{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mathtt{0xFD}~~158{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mathtt{0xFD}~~159{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mathtt{0xFD}~~274{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{relaxed\_dot}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mathtt{0xFD}~~126{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extadd\_pairwise}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mathtt{0xFD}~~127{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extadd\_pairwise}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mathtt{0xFD}~~160{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{abs} \\
& & | & \mathtt{0xFD}~~161{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{neg} \\
& & | & \mathtt{0xFD}~~163{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{all\_true} \\
& & | & \mathtt{0xFD}~~164{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{bitmask} \\
& & | & \mathtt{0xFD}~~167{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mathtt{0xFD}~~168{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mathtt{0xFD}~~169{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mathtt{0xFD}~~170{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mathtt{0xFD}~~171{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{shl} \\
& & | & \mathtt{0xFD}~~172{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~173{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~174{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{add} \\
& & | & \mathtt{0xFD}~~177{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{sub} \\
& & | & \mathtt{0xFD}~~181{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{mul} \\
& & | & \mathtt{0xFD}~~182{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{min}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~183{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{min}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~184{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{max}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~185{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{max}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~186{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{dot}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mathtt{0xFD}~~188{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mathtt{0xFD}~~189{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mathtt{0xFD}~~190{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mathtt{0xFD}~~191{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mathtt{0xFD}~~275{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{relaxed\_dot\_add}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mathtt{0xFD}~~192{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{abs} \\
& & | & \mathtt{0xFD}~~193{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{neg} \\
& & | & \mathtt{0xFD}~~195{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{all\_true} \\
& & | & \mathtt{0xFD}~~196{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{bitmask} \\
& & | & \mathtt{0xFD}~~199{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mathtt{0xFD}~~200{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mathtt{0xFD}~~201{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mathtt{0xFD}~~202{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mathtt{0xFD}~~203{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{shl} \\
& & | & \mathtt{0xFD}~~204{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~205{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mathtt{0xFD}~~206{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{add} \\
& & | & \mathtt{0xFD}~~209{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{sub} \\
& & | & \mathtt{0xFD}~~213{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{mul} \\
& & | & \mathtt{0xFD}~~214{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{eq} \\
& & | & \mathtt{0xFD}~~215{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{ne} \\
& & | & \mathtt{0xFD}~~216{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~217{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~218{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~219{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mathtt{0xFD}~~220{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mathtt{0xFD}~~221{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mathtt{0xFD}~~222{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mathtt{0xFD}~~223{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mathtt{0xFD}~~103{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{ceil} \\
& & | & \mathtt{0xFD}~~104{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{floor} \\
& & | & \mathtt{0xFD}~~105{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{trunc} \\
& & | & \mathtt{0xFD}~~106{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{nearest} \\
& & | & \mathtt{0xFD}~~224{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{abs} \\
& & | & \mathtt{0xFD}~~225{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{neg} \\
& & | & \mathtt{0xFD}~~227{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{sqrt} \\
& & | & \mathtt{0xFD}~~228{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{add} \\
& & | & \mathtt{0xFD}~~229{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{sub} \\
& & | & \mathtt{0xFD}~~230{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{mul} \\
& & | & \mathtt{0xFD}~~231{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{div} \\
& & | & \mathtt{0xFD}~~232{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{min} \\
& & | & \mathtt{0xFD}~~233{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{max} \\
& & | & \mathtt{0xFD}~~234{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{pmin} \\
& & | & \mathtt{0xFD}~~235{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{pmax} \\
& & | & \mathtt{0xFD}~~269{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{relaxed\_min} \\
& & | & \mathtt{0xFD}~~270{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{relaxed\_max} \\
& & | & \mathtt{0xFD}~~261{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{relaxed\_madd} \\
& & | & \mathtt{0xFD}~~262{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{relaxed\_nmadd} \\
& & | & \mathtt{0xFD}~~116{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{ceil} \\
& & | & \mathtt{0xFD}~~117{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{floor} \\
& & | & \mathtt{0xFD}~~122{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{trunc} \\
& & | & \mathtt{0xFD}~~148{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{nearest} \\
& & | & \mathtt{0xFD}~~236{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{abs} \\
& & | & \mathtt{0xFD}~~237{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{neg} \\
& & | & \mathtt{0xFD}~~239{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{sqrt} \\
& & | & \mathtt{0xFD}~~240{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{add} \\
& & | & \mathtt{0xFD}~~241{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{sub} \\
& & | & \mathtt{0xFD}~~242{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{mul} \\
& & | & \mathtt{0xFD}~~243{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{div} \\
& & | & \mathtt{0xFD}~~244{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{min} \\
& & | & \mathtt{0xFD}~~245{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{max} \\
& & | & \mathtt{0xFD}~~246{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{pmin} \\
& & | & \mathtt{0xFD}~~247{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{pmax} \\
& & | & \mathtt{0xFD}~~271{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{relaxed\_min} \\
& & | & \mathtt{0xFD}~~272{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{relaxed\_max} \\
& & | & \mathtt{0xFD}~~263{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{relaxed\_madd} \\
& & | & \mathtt{0xFD}~~264{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{relaxed\_nmadd} \\
& & | & \mathtt{0xFD}~~265{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{relaxed\_laneselect} \\
& & | & \mathtt{0xFD}~~266{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{relaxed\_laneselect} \\
& & | & \mathtt{0xFD}~~267{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{relaxed\_laneselect} \\
& & | & \mathtt{0xFD}~~268{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{relaxed\_laneselect} \\
& & | & \mathtt{0xFD}~~94{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{demote}}{\mathsf{\_}}{\mathsf{zero}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}} \\
& & | & \mathtt{0xFD}~~95{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{promote}}{\mathsf{\_}}{\mathsf{low}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mathtt{0xFD}~~248{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mathtt{0xFD}~~249{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mathtt{0xFD}~~250{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mathtt{0xFD}~~251{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mathtt{0xFD}~~252{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{s}~\mathsf{zero}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}} \\
& & | & \mathtt{0xFD}~~253{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{u}~\mathsf{zero}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}} \\
& & | & \mathtt{0xFD}~~254{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{low}~\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mathtt{0xFD}~~255{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{low}~\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mathtt{0xFD}~~257{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{relaxed\_trunc}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mathtt{0xFD}~~258{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{relaxed\_trunc}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mathtt{0xFD}~~259{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{relaxed\_trunc}}{\mathsf{\_}}{\mathsf{s}~\mathsf{zero}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}} \\
& & | & \mathtt{0xFD}~~260{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{relaxed\_trunc}}{\mathsf{\_}}{\mathsf{u}~\mathsf{zero}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{expr}} & ::= & {({\mathit{in}}{:}{\mathtt{instr}})^\ast}~~\mathtt{0x0B} & \quad\Rightarrow\quad{} & {{\mathit{in}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
\mbox{(section)} & {{\mathtt{section}}}_{N}({\mathtt{X}}) & ::= & N{:}{\mathtt{byte}}~~{\mathit{len}}{:}{\mathtt{u32}}~~{{\mathit{en}}^\ast}{:}{\mathtt{X}} & \quad\Rightarrow\quad{} & {{\mathit{en}}^\ast} & \quad \mbox{if}~ {\mathit{len}} = ||{\mathtt{X}}|| \\
& & | & \epsilon & \quad\Rightarrow\quad{} & \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
\mbox{(custom data)} & {\mathtt{custom}} & ::= & {\mathtt{name}}~~{{\mathtt{byte}}^\ast} \\
\mbox{(custom section)} & {\mathtt{customsec}} & ::= & {{\mathtt{section}}}_{0}({\mathtt{custom}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{type}} & ::= & {\mathit{qt}}{:}{\mathtt{rectype}} & \quad\Rightarrow\quad{} & \mathsf{type}~{\mathit{qt}} \\
\mbox{(type section)} & {\mathtt{typesec}} & ::= & {{\mathit{ty}}^\ast}{:}{{\mathtt{section}}}_{1}({\mathtt{list}}({\mathtt{type}})) & \quad\Rightarrow\quad{} & {{\mathit{ty}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{import}} & ::= & {\mathit{nm}}_1{:}{\mathtt{name}}~~{\mathit{nm}}_2{:}{\mathtt{name}}~~{\mathit{xt}}{:}{\mathtt{externtype}} & \quad\Rightarrow\quad{} & \mathsf{import}~{\mathit{nm}}_1~{\mathit{nm}}_2~{\mathit{xt}} \\
\mbox{(import section)} & {\mathtt{importsec}} & ::= & {{\mathit{im}}^\ast}{:}{{\mathtt{section}}}_{2}({\mathtt{list}}({\mathtt{import}})) & \quad\Rightarrow\quad{} & {{\mathit{im}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
\mbox{(function section)} & {\mathtt{funcsec}} & ::= & {x^\ast}{:}{{\mathtt{section}}}_{3}({\mathtt{list}}({\mathtt{typeidx}})) & \quad\Rightarrow\quad{} & {x^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{table}} & ::= & {\mathit{tt}}{:}{\mathtt{tabletype}} & \quad\Rightarrow\quad{} & \mathsf{table}~{\mathit{tt}}~(\mathsf{ref{.}null}~{\mathit{ht}}) & \quad \mbox{if}~ {\mathit{tt}} = {\mathit{at}}~{\mathit{lim}}~(\mathsf{ref}~{\mathsf{null}^?}~{\mathit{ht}}) \\
& & | & \mathtt{0x40}~~\mathtt{0x00}~~{\mathit{tt}}{:}{\mathtt{tabletype}}~~e{:}{\mathtt{expr}} & \quad\Rightarrow\quad{} & \mathsf{table}~{\mathit{tt}}~e \\
\mbox{(table section)} & {\mathtt{tablesec}} & ::= & {{\mathit{tab}}^\ast}{:}{{\mathtt{section}}}_{4}({\mathtt{list}}({\mathtt{table}})) & \quad\Rightarrow\quad{} & {{\mathit{tab}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{mem}} & ::= & {\mathit{mt}}{:}{\mathtt{memtype}} & \quad\Rightarrow\quad{} & \mathsf{memory}~{\mathit{mt}} \\
\mbox{(memory section)} & {\mathtt{memsec}} & ::= & {{\mathit{mem}}^\ast}{:}{{\mathtt{section}}}_{5}({\mathtt{list}}({\mathtt{mem}})) & \quad\Rightarrow\quad{} & {{\mathit{mem}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{global}} & ::= & {\mathit{gt}}{:}{\mathtt{globaltype}}~~e{:}{\mathtt{expr}} & \quad\Rightarrow\quad{} & \mathsf{global}~{\mathit{gt}}~e \\
\mbox{(global section)} & {\mathtt{globalsec}} & ::= & {{\mathit{glob}}^\ast}{:}{{\mathtt{section}}}_{6}({\mathtt{list}}({\mathtt{global}})) & \quad\Rightarrow\quad{} & {{\mathit{glob}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{export}} & ::= & {\mathit{nm}}{:}{\mathtt{name}}~~{\mathit{xx}}{:}{\mathtt{externidx}} & \quad\Rightarrow\quad{} & \mathsf{export}~{\mathit{nm}}~{\mathit{xx}} \\
\mbox{(export section)} & {\mathtt{exportsec}} & ::= & {{\mathit{ex}}^\ast}{:}{{\mathtt{section}}}_{7}({\mathtt{list}}({\mathtt{export}})) & \quad\Rightarrow\quad{} & {{\mathit{ex}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{start}} & ::= & x{:}{\mathtt{funcidx}} & \quad\Rightarrow\quad{} & (\mathsf{start}~x) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {{\mathit{start}}^?} & ::= & {{\mathit{start}}^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
\mbox{(start section)} & {\mathtt{startsec}} & ::= & {{\mathit{start}}^?}{:}{{\mathtt{section}}}_{8}({\mathtt{start}}) & \quad\Rightarrow\quad{} & {{\mathit{start}}^?} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
\mbox{(element kind)} & {\mathtt{elemkind}} & ::= & \mathtt{0x00} & \quad\Rightarrow\quad{} & \mathsf{ref}~\mathsf{null}~\mathsf{func} \\
& {\mathtt{elem}} & ::= & 0{:}{\mathtt{u32}}~~e_o{:}{\mathtt{expr}}~~{y^\ast}{:}{\mathtt{list}}({\mathtt{funcidx}}) & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\mathsf{elem}~(\mathsf{ref}~\mathsf{func})~{(\mathsf{ref{.}func}~y)^\ast}~(\mathsf{active}~0~e_o) \\
\end{array}
} \\
& & | & 1{:}{\mathtt{u32}}~~{\mathit{rt}}{:}{\mathtt{elemkind}}~~{y^\ast}{:}{\mathtt{list}}({\mathtt{funcidx}}) & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\mathsf{elem}~{\mathit{rt}}~{(\mathsf{ref{.}func}~y)^\ast}~\mathsf{passive} \\
\end{array}
} \\
& & | & 2{:}{\mathtt{u32}}~~x{:}{\mathtt{tableidx}}~~e{:}{\mathtt{expr}}~~{\mathit{rt}}{:}{\mathtt{elemkind}}~~{y^\ast}{:}{\mathtt{list}}({\mathtt{funcidx}}) & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\mathsf{elem}~{\mathit{rt}}~{(\mathsf{ref{.}func}~y)^\ast}~(\mathsf{active}~x~e) \\
\end{array}
} \\
& & | & 3{:}{\mathtt{u32}}~~{\mathit{rt}}{:}{\mathtt{elemkind}}~~{y^\ast}{:}{\mathtt{list}}({\mathtt{funcidx}}) & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\mathsf{elem}~{\mathit{rt}}~{(\mathsf{ref{.}func}~y)^\ast}~\mathsf{declare} \\
\end{array}
} \\
& & | & 4{:}{\mathtt{u32}}~~e_{\mathsf{o}}{:}{\mathtt{expr}}~~{e^\ast}{:}{\mathtt{list}}({\mathtt{expr}}) & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\mathsf{elem}~(\mathsf{ref}~\mathsf{null}~\mathsf{func})~{e^\ast}~(\mathsf{active}~0~e_{\mathsf{o}}) \\
\end{array}
} \\
& & | & 5{:}{\mathtt{u32}}~~{\mathit{rt}}{:}{\mathtt{reftype}}~~{e^\ast}{:}{\mathtt{list}}({\mathtt{expr}}) & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\mathsf{elem}~{\mathit{rt}}~{e^\ast}~\mathsf{passive} \\
\end{array}
} \\
& & | & 6{:}{\mathtt{u32}}~~x{:}{\mathtt{tableidx}}~~e_{\mathsf{o}}{:}{\mathtt{expr}}~~{e^\ast}{:}{\mathtt{list}}({\mathtt{expr}}) & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\mathsf{elem}~(\mathsf{ref}~\mathsf{null}~\mathsf{func})~{e^\ast}~(\mathsf{active}~x~e_{\mathsf{o}}) \\
\end{array}
} \\
& & | & 7{:}{\mathtt{u32}}~~{\mathit{rt}}{:}{\mathtt{reftype}}~~{e^\ast}{:}{\mathtt{list}}({\mathtt{expr}}) & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\mathsf{elem}~{\mathit{rt}}~{e^\ast}~\mathsf{declare} \\
\end{array}
} \\
\mbox{(element section)} & {\mathtt{elemsec}} & ::= & {{\mathit{elem}}^\ast}{:}{{\mathtt{section}}}_{9}({\mathtt{list}}({\mathtt{elem}})) & \quad\Rightarrow\quad{} & {{\mathit{elem}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{code}} & ::= & ({{\mathit{local}}^\ast}, {\mathit{expr}}) \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
\mbox{(local)} & {\mathtt{locals}} & ::= & n{:}{\mathtt{u32}}~~t{:}{\mathtt{valtype}} & \quad\Rightarrow\quad{} & {(\mathsf{local}~t)^{n}} \\
& {\mathtt{func}} & ::= & {{{\mathit{loc}}^\ast}^\ast}{:}{\mathtt{list}}({\mathtt{locals}})~~e{:}{\mathtt{expr}} & \quad\Rightarrow\quad{} & ({\bigoplus}\, {{{\mathit{loc}}^\ast}^\ast}, e) & \quad \mbox{if}~ {|{\bigoplus}\, {{{\mathit{loc}}^\ast}^\ast}|} < {2^{32}} \\
& {\mathtt{code}} & ::= & {\mathit{len}}{:}{\mathtt{u32}}~~{\mathit{code}}{:}{\mathtt{func}} & \quad\Rightarrow\quad{} & {\mathit{code}} & \quad \mbox{if}~ {\mathit{len}} = ||{\mathtt{func}}|| \\
\mbox{(code section)} & {\mathtt{codesec}} & ::= & {{\mathit{code}}^\ast}{:}{{\mathtt{section}}}_{10}({\mathtt{list}}({\mathtt{code}})) & \quad\Rightarrow\quad{} & {{\mathit{code}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{data}} & ::= & 0{:}{\mathtt{u32}}~~e{:}{\mathtt{expr}}~~{b^\ast}{:}{\mathtt{list}}({\mathtt{byte}}) & \quad\Rightarrow\quad{} & \mathsf{data}~{b^\ast}~(\mathsf{active}~0~e) \\
& & | & 1{:}{\mathtt{u32}}~~{b^\ast}{:}{\mathtt{list}}({\mathtt{byte}}) & \quad\Rightarrow\quad{} & \mathsf{data}~{b^\ast}~\mathsf{passive} \\
& & | & 2{:}{\mathtt{u32}}~~x{:}{\mathtt{memidx}}~~e{:}{\mathtt{expr}}~~{b^\ast}{:}{\mathtt{list}}({\mathtt{byte}}) & \quad\Rightarrow\quad{} & \mathsf{data}~{b^\ast}~(\mathsf{active}~x~e) \\
\mbox{(data section)} & {\mathtt{datasec}} & ::= & {{\mathit{data}}^\ast}{:}{{\mathtt{section}}}_{11}({\mathtt{list}}({\mathtt{data}})) & \quad\Rightarrow\quad{} & {{\mathit{data}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
\mbox{(data count)} & {\mathtt{datacnt}} & ::= & n{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & n \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {n^?} & ::= & {{\mathit{u{\kern-0.1em\scriptstyle 32}}}^\ast} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
\mbox{(data count section)} & {\mathtt{datacntsec}} & ::= & {n^?}{:}{{\mathtt{section}}}_{12}({\mathtt{datacnt}}) & \quad\Rightarrow\quad{} & {n^?} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{tag}} & ::= & {\mathit{jt}}{:}{\mathtt{tagtype}} & \quad\Rightarrow\quad{} & \mathsf{tag}~{\mathit{jt}} \\
\mbox{(tag section)} & {\mathtt{tagsec}} & ::= & {{\mathit{tag}}^\ast}{:}{{\mathtt{section}}}_{13}({\mathtt{list}}({\mathtt{tag}})) & \quad\Rightarrow\quad{} & {{\mathit{tag}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{magic}} & ::= & \mathtt{0x00}~~\mathtt{0x61}~~\mathtt{0x73}~~\mathtt{0x6D} \\
& {\mathtt{version}} & ::= & \mathtt{0x01}~~\mathtt{0x00}~~\mathtt{0x00}~~\mathtt{0x00} \\
& {\mathtt{module}} & ::= & \begin{array}[t]{@{}l@{}} {\mathtt{magic}}~~{\mathtt{version}} \\
  {{\mathtt{customsec}}^\ast}~~{{\mathit{type}}^\ast}{:}{\mathtt{typesec}} \\
  {{\mathtt{customsec}}^\ast}~~{{\mathit{import}}^\ast}{:}{\mathtt{importsec}} \\
  {{\mathtt{customsec}}^\ast}~~{{\mathit{typeidx}}^\ast}{:}{\mathtt{funcsec}} \\
  {{\mathtt{customsec}}^\ast}~~{{\mathit{table}}^\ast}{:}{\mathtt{tablesec}} \\
  {{\mathtt{customsec}}^\ast}~~{{\mathit{mem}}^\ast}{:}{\mathtt{memsec}} \\
  {{\mathtt{customsec}}^\ast}~~{{\mathit{tag}}^\ast}{:}{\mathtt{tagsec}} \\
  {{\mathtt{customsec}}^\ast}~~{{\mathit{global}}^\ast}{:}{\mathtt{globalsec}} \\
  {{\mathtt{customsec}}^\ast}~~{{\mathit{export}}^\ast}{:}{\mathtt{exportsec}} \\
  {{\mathtt{customsec}}^\ast}~~{{\mathit{start}}^?}{:}{\mathtt{startsec}} \\
  {{\mathtt{customsec}}^\ast}~~{{\mathit{elem}}^\ast}{:}{\mathtt{elemsec}} \\
  {{\mathtt{customsec}}^\ast}~~{n^?}{:}{\mathtt{datacntsec}} \\
  {{\mathtt{customsec}}^\ast}~~{({{\mathit{local}}^\ast}, {\mathit{expr}})^\ast}{:}{\mathtt{codesec}} \\
  {{\mathtt{customsec}}^\ast}~~{{\mathit{data}}^\ast}{:}{\mathtt{datasec}} \\
  {{\mathtt{customsec}}^\ast} \end{array} & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
\mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{tag}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ (n = {|{{\mathit{data}}^\ast}|})^? \\
{\land}~ ({n^?} \neq \epsilon \lor {\mathrm{dataidx}}({{\mathit{func}}^\ast}) = \epsilon) \\
{\land}~ ({\mathit{func}} = \mathsf{func}~{\mathit{typeidx}}~{{\mathit{local}}^\ast}~{\mathit{expr}})^\ast \\
\end{array} \\
\end{array}
} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{char}} & ::= & \mathrm{U{+}00} ~~|~~ \ldots ~~|~~ \mathrm{U{+}D7FF} ~~|~~ \mathrm{U{+}E000} ~~|~~ \ldots ~~|~~ \mathrm{U{+}10FFFF} \\
& {\mathtt{source}} & ::= & {{\mathtt{char}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{uN}} & ::= & \epsilon \\
& {\mathtt{sN}} & ::= & \epsilon \\
& {\mathtt{fN}} & ::= & \epsilon \\
& {\mathtt{token}} & ::= & {\mathtt{keyword}} ~~|~~ {\mathtt{uN}} ~~|~~ {\mathtt{sN}} ~~|~~ {\mathtt{fN}} ~~|~~ {\mathtt{string}} ~~|~~ {\mathtt{id}} ~~|~~ \mbox{‘}\mathtt{(}\mbox{’} ~~|~~ \mbox{‘}\mathtt{)}\mbox{’} ~~|~~ {\mathtt{reserved}} \\
& {\mathtt{keyword}} & ::= & (\mbox{‘}\mathtt{a}\mbox{’} ~~|~~ \ldots ~~|~~ \mbox{‘}\mathtt{z}\mbox{’})~~{{\mathtt{idchar}}^\ast} \\
& {\mathtt{reserved}} & ::= & {({\mathtt{idchar}} ~~|~~ {\mathtt{string}} ~~|~~ \mbox{‘}\mathtt{,}\mbox{’} ~~|~~ \mbox{‘}\mathtt{;}\mbox{’} ~~|~~ \mbox{‘}\mathtt{{[}}\mbox{’} ~~|~~ \mbox{‘}\mathtt{{]}}\mbox{’} ~~|~~ \mbox{‘}\mathtt{\{}\mbox{’} ~~|~~ \mbox{‘}\mathtt{\}}\mbox{’})^{+}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{space}} & ::= & {(\mbox{‘}\mathtt{ }\mbox{’} ~~|~~ {\mathtt{format}} ~~|~~ {\mathtt{comment}} ~~|~~ {\mathtt{annot}})^\ast} \\
& {\mathtt{format}} & ::= & {\mathtt{newline}} ~~|~~ \mathrm{U{+}09} \\
& {\mathtt{newline}} & ::= & \mathrm{U{+}0A} ~~|~~ \mathrm{U{+}0D} ~~|~~ \mathrm{U{+}0D}~~\mathrm{U{+}0A} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{comment}} & ::= & {\mathtt{linecomment}} ~~|~~ {\mathtt{blockcomment}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{linecomment}} & ::= & \mbox{‘}\mathtt{;;}\mbox{’}~~{{\mathtt{linechar}}^\ast}~~({\mathtt{newline}} ~~|~~ {\mathtt{eof}}) \\
& {\mathtt{eof}} & ::= & \mbox{‘}\mathtt{}\mbox{’} \\
& {\mathtt{linechar}} & ::= & c{:}{\mathtt{char}} & \quad \mbox{if}~ c \neq \mathrm{U{+}0A} \land c \neq \mathrm{U{+}0D} \\
& {\mathtt{blockcomment}} & ::= & \mbox{‘}\mathtt{(;}\mbox{’}~~{{\mathtt{blockchar}}^\ast}~~\mbox{‘}\mathtt{;)}\mbox{’} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{blockchar}} & ::= & c{:}{\mathtt{char}} & \quad \mbox{if}~ c \neq \mbox{‘}\mathtt{;}\mbox{’} \land c \neq \mbox{‘}\mathtt{(}\mbox{’} \\
& & | & {\mbox{‘}\mathtt{;}\mbox{’}^{+}}~~c{:}{\mathtt{char}} & \quad \mbox{if}~ c \neq \mbox{‘}\mathtt{;}\mbox{’} \land c \neq \mbox{‘}\mathtt{)}\mbox{’} \\
& & | & {\mbox{‘}\mathtt{(}\mbox{’}^{+}}~~c{:}{\mathtt{char}} & \quad \mbox{if}~ c \neq \mbox{‘}\mathtt{;}\mbox{’} \land c \neq \mbox{‘}\mathtt{(}\mbox{’} \\
& & | & {\mathtt{blockcomment}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{annot}} & ::= & \mbox{‘}\mathtt{(@}\mbox{’}~~{\mathtt{annotid}}~~{({\mathtt{space}} ~~|~~ {\mathtt{token}})^\ast}~~\mbox{‘}\mathtt{)}\mbox{’} \\
& {\mathtt{annotid}} & ::= & {{\mathtt{idchar}}^{+}} ~~|~~ {\mathtt{name}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{sign}} & ::= & \epsilon ~\Rightarrow~ {+1} ~~|~~ \mbox{‘}\mathtt{+}\mbox{’} ~\Rightarrow~ {+1} ~~|~~ \mbox{‘}\mathtt{\mbox{-}}\mbox{’} ~\Rightarrow~ {-1} \\
& {\mathtt{digit}} & ::= & \mbox{‘}\mathtt{0}\mbox{’} ~\Rightarrow~ 0 ~~|~~ \ldots ~~|~~ \mbox{‘}\mathtt{9}\mbox{’} ~\Rightarrow~ 9 \\
& {\mathtt{hexdigit}} & ::= & d{:}{\mathtt{digit}} ~\Rightarrow~ d \\
& & | & \mbox{‘}\mathtt{A}\mbox{’} ~\Rightarrow~ 10 ~~|~~ \ldots ~~|~~ \mbox{‘}\mathtt{F}\mbox{’} ~\Rightarrow~ 15 \\
& & | & \mbox{‘}\mathtt{a}\mbox{’} ~\Rightarrow~ 10 ~~|~~ \ldots ~~|~~ \mbox{‘}\mathtt{f}\mbox{’} ~\Rightarrow~ 15 \\
& {\mathtt{num}} & ::= & d{:}{\mathtt{digit}} & \quad\Rightarrow\quad{} & d \\
& & | & n{:}{\mathtt{num}}~~{\mbox{‘}\mathtt{\_}\mbox{’}^?}~~d{:}{\mathtt{digit}} & \quad\Rightarrow\quad{} & 10 \, n + d \\
& {\mathtt{hexnum}} & ::= & h{:}{\mathtt{hexdigit}} & \quad\Rightarrow\quad{} & h \\
& & | & n{:}{\mathtt{hexnum}}~~{\mbox{‘}\mathtt{\_}\mbox{’}^?}~~h{:}{\mathtt{hexdigit}} & \quad\Rightarrow\quad{} & 16 \, n + h \\
& {{\mathtt{u}}}{N} & ::= & n{:}{\mathtt{num}} & \quad\Rightarrow\quad{} & n & \quad \mbox{if}~ n < {2^{N}} \\
& & | & \mbox{‘}\mathtt{0x}\mbox{’}~~n{:}{\mathtt{hexnum}} & \quad\Rightarrow\quad{} & n & \quad \mbox{if}~ n < {2^{N}} \\
& {{\mathtt{s}}}{N} & ::= & s{:}{\mathtt{sign}}~~n{:}{{\mathtt{u}}}{N} & \quad\Rightarrow\quad{} & s \cdot n & \quad \mbox{if}~ {-{2^{N - 1}}} \leq s \cdot n < {2^{N - 1}} \\
& {{\mathtt{i}}}{N} & ::= & n{:}{{\mathtt{u}}}{N} & \quad\Rightarrow\quad{} & n \\
& & | & i{:}{{\mathtt{s}}}{N} & \quad\Rightarrow\quad{} & {{{{\mathrm{signed}}}_{N}^{{-1}}}}{(i)} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{frac}} & ::= & d{:}{\mathtt{digit}} & \quad\Rightarrow\quad{} & d / 10 \\
& & | & d{:}{\mathtt{digit}}~~{\mbox{‘}\mathtt{\_}\mbox{’}^?}~~p{:}{\mathtt{frac}} & \quad\Rightarrow\quad{} & (d + p / 10) / 10 \\
& {\mathtt{hexfrac}} & ::= & h{:}{\mathtt{hexdigit}} & \quad\Rightarrow\quad{} & h / 16 \\
& & | & h{:}{\mathtt{hexdigit}}~~{\mbox{‘}\mathtt{\_}\mbox{’}^?}~~p{:}{\mathtt{hexfrac}} & \quad\Rightarrow\quad{} & (h + p / 16) / 16 \\
& {\mathtt{mant}} & ::= & p{:}{\mathtt{num}}~~{\mbox{‘}\mathtt{.}\mbox{’}^?} & \quad\Rightarrow\quad{} & p \\
& & | & p{:}{\mathtt{num}}~~\mbox{‘}\mathtt{.}\mbox{’}~~q{:}{\mathtt{frac}} & \quad\Rightarrow\quad{} & p + q \\
& {\mathtt{hexmant}} & ::= & p{:}{\mathtt{hexnum}}~~{\mbox{‘}\mathtt{.}\mbox{’}^?} & \quad\Rightarrow\quad{} & p \\
& & | & p{:}{\mathtt{hexnum}}~~\mbox{‘}\mathtt{.}\mbox{’}~~q{:}{\mathtt{hexfrac}} & \quad\Rightarrow\quad{} & p + q \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{float}} & ::= & p{:}{\mathtt{mant}}~~(\mbox{‘}\mathtt{E}\mbox{’} ~~|~~ \mbox{‘}\mathtt{e}\mbox{’})~~s{:}{\mathtt{sign}}~~e{:}{\mathtt{num}} & \quad\Rightarrow\quad{} & p \cdot {10^{s \cdot e}} \\
& {\mathtt{hexfloat}} & ::= & \mbox{‘}\mathtt{0x}\mbox{’}~~p{:}{\mathtt{hexmant}}~~(\mbox{‘}\mathtt{P}\mbox{’} ~~|~~ \mbox{‘}\mathtt{p}\mbox{’})~~s{:}{\mathtt{sign}}~~e{:}{\mathtt{num}} & \quad\Rightarrow\quad{} & p \cdot {2^{s \cdot e}} \\
& {\mathtt{fNmag}} & ::= & q{:}{\mathtt{float}} & \quad\Rightarrow\quad{} & {{\mathrm{ieee}}}_{N}(q) & \quad \mbox{if}~ {{\mathrm{ieee}}}_{N}(q) \neq \infty \\
& & | & q{:}{\mathtt{hexfloat}} & \quad\Rightarrow\quad{} & {{\mathrm{ieee}}}_{N}(q) & \quad \mbox{if}~ {{\mathrm{ieee}}}_{N}(q) \neq \infty \\
& & | & \mbox{‘}\mathtt{inf}\mbox{’} & \quad\Rightarrow\quad{} & \infty \\
& & | & \mbox{‘}\mathtt{nan}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{nan}}{({{\mathrm{canon}}}_{N})} \\
& & | & \mbox{‘}\mathtt{nan:0x}\mbox{’}~~n{:}{\mathtt{hexnum}} & \quad\Rightarrow\quad{} & {\mathsf{nan}}{(n)} & \quad \mbox{if}~ 1 \leq n < {2^{{\mathrm{signif}}(N)}} \\
& {{\mathtt{f}}}{N} & ::= & ({+1}){:}{\mathtt{sign}}~~q{:}{\mathtt{fNmag}} & \quad\Rightarrow\quad{} & {+q} \\
& & | & ({-1}){:}{\mathtt{sign}}~~q{:}{\mathtt{fNmag}} & \quad\Rightarrow\quad{} & {-q} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{u8}} & ::= & {{\mathtt{u}}}{\mathsf{{\scriptstyle 8}}} \\
& {\mathtt{u32}} & ::= & {{\mathtt{u}}}{\mathsf{{\scriptstyle 32}}} \\
& {\mathtt{u64}} & ::= & {{\mathtt{u}}}{\mathsf{{\scriptstyle 64}}} \\
& {\mathtt{i8}} & ::= & {{\mathtt{i}}}{\mathsf{{\scriptstyle 8}}} \\
& {\mathtt{i16}} & ::= & {{\mathtt{i}}}{\mathsf{{\scriptstyle 16}}} \\
& {\mathtt{i32}} & ::= & {{\mathtt{i}}}{\mathsf{{\scriptstyle 32}}} \\
& {\mathtt{i64}} & ::= & {{\mathtt{i}}}{\mathsf{{\scriptstyle 64}}} \\
& {\mathtt{i128}} & ::= & {{\mathtt{i}}}{\mathsf{{\scriptstyle 128}}} \\
& {\mathtt{f32}} & ::= & {{\mathtt{f}}}{\mathsf{{\scriptstyle 32}}} \\
& {\mathtt{f64}} & ::= & {{\mathtt{f}}}{\mathsf{{\scriptstyle 64}}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{stringchar}} & ::= & c{:}{\mathtt{char}} & \quad\Rightarrow\quad{} & c & \quad \mbox{if}~ c \geq \mathrm{U{+}20} \land c \neq \mathrm{U{+}7F} \land c \neq \mbox{‘}\mathtt{\kern-0.02em{'}\kern-0.05em{'}\kern-0.02em}\mbox{’} \land c \neq \mbox{‘}\mathtt{\backslash{}}\mbox{’} \\
& & | & \mbox{‘}\mathtt{\backslash{}t}\mbox{’} & \quad\Rightarrow\quad{} & \mathrm{U{+}09} \\
& & | & \mbox{‘}\mathtt{\backslash{}n}\mbox{’} & \quad\Rightarrow\quad{} & \mathrm{U{+}0A} \\
& & | & \mbox{‘}\mathtt{\backslash{}r}\mbox{’} & \quad\Rightarrow\quad{} & \mathrm{U{+}0D} \\
& & | & \mbox{‘}\mathtt{\backslash{}\kern-0.02em{'}\kern-0.05em{'}\kern-0.02em}\mbox{’} & \quad\Rightarrow\quad{} & \mathrm{U{+}22} \\
& & | & \mbox{‘}\mathtt{\backslash{}\kern0.03em{'}\kern0.03em}\mbox{’} & \quad\Rightarrow\quad{} & \mathrm{U{+}27} \\
& & | & \mbox{‘}\mathtt{\backslash{}\backslash{}}\mbox{’} & \quad\Rightarrow\quad{} & \mathrm{U{+}5C} \\
& & | & \mbox{‘}\mathtt{\backslash{}u\{}\mbox{’}~~n{:}{\mathtt{hexnum}}~~\mbox{‘}\mathtt{\}}\mbox{’} & \quad\Rightarrow\quad{} & n & \quad \mbox{if}~ n < \mathtt{0xD800} \lor \mathtt{0xE800} \leq n < \mathtt{0x110000} \\
& {\mathtt{stringelem}} & ::= & c{:}{\mathtt{stringchar}} & \quad\Rightarrow\quad{} & {\mathrm{utf{\kern-0.1em\scriptstyle 8}}}(c) \\
& & | & \mbox{‘}\mathtt{\backslash{}}\mbox{’}~~h_1{:}{\mathtt{hexdigit}}~~h_2{:}{\mathtt{hexdigit}} & \quad\Rightarrow\quad{} & 16 \, h_1 + h_2 \\
& {\mathtt{string}} & ::= & \mbox{‘}\mathtt{\kern-0.02em{'}\kern-0.05em{'}\kern-0.02em}\mbox{’}~~{({b^\ast}{:}{\mathtt{stringelem}})^\ast}~~\mbox{‘}\mathtt{\kern-0.02em{'}\kern-0.05em{'}\kern-0.02em}\mbox{’} & \quad\Rightarrow\quad{} & {\bigoplus}\, {{b^\ast}^\ast} & \quad \mbox{if}~ {|{\bigoplus}\, {{b^\ast}^\ast}|} < {2^{32}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{list}}({\mathtt{X}}) & ::= & {({\mathit{el}}{:}{\mathtt{X}})^\ast} & \quad\Rightarrow\quad{} & {{\mathit{el}}^\ast} & \quad \mbox{if}~ {|{{\mathit{el}}^\ast}|} < {2^{32}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{name}} & ::= & {b^\ast}{:}{\mathtt{string}} & \quad\Rightarrow\quad{} & {c^\ast} & \quad \mbox{if}~ {b^\ast} = {\mathrm{utf{\kern-0.1em\scriptstyle 8}}}({c^\ast}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{idchar}} & ::= & \mbox{‘}\mathtt{0}\mbox{’} ~~|~~ \ldots ~~|~~ \mbox{‘}\mathtt{9}\mbox{’} \\
& & | & \mbox{‘}\mathtt{A}\mbox{’} ~~|~~ \ldots ~~|~~ \mbox{‘}\mathtt{Z}\mbox{’} \\
& & | & \mbox{‘}\mathtt{a}\mbox{’} ~~|~~ \ldots ~~|~~ \mbox{‘}\mathtt{z}\mbox{’} \\
& & | & \mbox{‘}\mathtt{!}\mbox{’} ~~|~~ \mbox{‘}\mathtt{\#}\mbox{’} ~~|~~ \mbox{‘}\mathtt{\$}\mbox{’} ~~|~~ \mbox{‘}\mathtt{\%}\mbox{’} ~~|~~ \mbox{‘}\mathtt{\&}\mbox{’} ~~|~~ \mbox{‘}\mathtt{\kern0.03em{'}\kern0.03em}\mbox{’} ~~|~~ \mbox{‘}\mathtt{*}\mbox{’} ~~|~~ \mbox{‘}\mathtt{+}\mbox{’} ~~|~~ \mbox{‘}\mathtt{\mbox{-}}\mbox{’} ~~|~~ \mbox{‘}\mathtt{.}\mbox{’} ~~|~~ \mbox{‘}\mathtt{/}\mbox{’} \\
& & | & \mbox{‘}\mathtt{:}\mbox{’} ~~|~~ \mbox{‘}\mathtt{<}\mbox{’} ~~|~~ \mbox{‘}\mathtt{=}\mbox{’} ~~|~~ \mbox{‘}\mathtt{>}\mbox{’} ~~|~~ \mbox{‘}\mathtt{?}\mbox{’} ~~|~~ \mbox{‘}\mathtt{@}\mbox{’} ~~|~~ \mbox{‘}\mathtt{\backslash{}}\mbox{’} ~~|~~ \mbox{‘}\mathtt{\hat{~~}}\mbox{’} ~~|~~ \mbox{‘}\mathtt{\_}\mbox{’} ~~|~~ \mbox{‘}\mathtt{\grave{~~}}\mbox{’} ~~|~~ \mbox{‘}\mathtt{|}\mbox{’} ~~|~~ \mbox{‘}\mathtt{\tilde{~~}}\mbox{’} \\
& {\mathtt{id}} & ::= & \mbox{‘}\mathtt{\$}\mbox{’}~~{c^\ast}{:}{{\mathtt{idchar}}^{+}} & \quad\Rightarrow\quad{} & {c^\ast} \\
& & | & \mbox{‘}\mathtt{\$}\mbox{’}~~{c^\ast}{:}{\mathtt{name}} & \quad\Rightarrow\quad{} & {c^\ast} & \quad \mbox{if}~ {|{c^\ast}|} > 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(identifier context)} & {\mathit{idctxt}} & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{types}~{({{\mathit{name}}^?})^\ast} \\
\mathsf{tags}~{({{\mathit{name}}^?})^\ast} \\
\mathsf{globals}~{({{\mathit{name}}^?})^\ast} \\
\mathsf{mems}~{({{\mathit{name}}^?})^\ast} \\
\mathsf{tables}~{({{\mathit{name}}^?})^\ast} \\
\mathsf{funcs}~{({{\mathit{name}}^?})^\ast} \\
\mathsf{datas}~{({{\mathit{name}}^?})^\ast} \\
\mathsf{elems}~{({{\mathit{name}}^?})^\ast} \\
\mathsf{locals}~{({{\mathit{name}}^?})^\ast} \\
\mathsf{labels}~{({{\mathit{name}}^?})^\ast} \\
\mathsf{fields}~{({({{\mathit{name}}^?})^\ast})^\ast} \\
\mathsf{typedefs}~{({{\mathit{subtype}}^?})^\ast} \} \\
\end{array} \\
& I & ::= & {\mathit{idctxt}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{concat}}_{\mathit{idctxt}}(\epsilon) & = & \{  \} \\
{\mathrm{concat}}_{\mathit{idctxt}}(I~{I'}) & = & I \oplus {\mathrm{concat}}_{\mathit{idctxt}}({{I'}^\ast}) \\
\end{array}
$$

\vspace{1ex}

$\boxed{{\vdash}\, {\mathit{idctxt}} : \mathsf{ok}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\bigoplus}\, I{.}\mathsf{types}~{\mathrm{disjoint}}
 \qquad
{\bigoplus}\, I{.}\mathsf{tags}~{\mathrm{disjoint}}
 \qquad
{\bigoplus}\, I{.}\mathsf{globals}~{\mathrm{disjoint}}
 \qquad
{\bigoplus}\, I{.}\mathsf{mems}~{\mathrm{disjoint}}
 \qquad
{\bigoplus}\, I{.}\mathsf{tables}~{\mathrm{disjoint}}
 \qquad
{\bigoplus}\, I{.}\mathsf{funcs}~{\mathrm{disjoint}}
 \qquad
{\bigoplus}\, I{.}\mathsf{datas}~{\mathrm{disjoint}}
 \qquad
{\bigoplus}\, I{.}\mathsf{elems}~{\mathrm{disjoint}}
 \qquad
{\bigoplus}\, I{.}\mathsf{locals}~{\mathrm{disjoint}}
 \qquad
{\bigoplus}\, I{.}\mathsf{labels}~{\mathrm{disjoint}}
 \qquad
({\bigoplus}\, {{\mathit{field}}^\ast}~{\mathrm{disjoint}})^\ast
 \qquad
{{{\mathit{field}}^\ast}^\ast} = I{.}\mathsf{fields}
}{
{\vdash}\, I : \mathsf{ok}
} \, {[\textsc{\scriptsize Idctxt\_ok}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{idx}}}_{{\mathit{ids}}} & ::= & x{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & x \\
& & | & {\mathit{id}}{:}{\mathtt{id}} & \quad\Rightarrow\quad{} & x & \quad \mbox{if}~ {\mathit{ids}}{}[x] = {\mathit{id}} \\
& {{\mathtt{typeidx}}}_{I} & ::= & {{\mathtt{idx}}}_{I{.}\mathsf{types}} \\
& {{\mathtt{tagidx}}}_{I} & ::= & {{\mathtt{idx}}}_{I{.}\mathsf{tags}} \\
& {{\mathtt{globalidx}}}_{I} & ::= & {{\mathtt{idx}}}_{I{.}\mathsf{globals}} \\
& {{\mathtt{memidx}}}_{I} & ::= & {{\mathtt{idx}}}_{I{.}\mathsf{mems}} \\
& {{\mathtt{tableidx}}}_{I} & ::= & {{\mathtt{idx}}}_{I{.}\mathsf{tables}} \\
& {{\mathtt{funcidx}}}_{I} & ::= & {{\mathtt{idx}}}_{I{.}\mathsf{funcs}} \\
& {{\mathtt{dataidx}}}_{I} & ::= & {{\mathtt{idx}}}_{I{.}\mathsf{datas}} \\
& {{\mathtt{elemidx}}}_{I} & ::= & {{\mathtt{idx}}}_{I{.}\mathsf{elems}} \\
& {{\mathtt{localidx}}}_{I} & ::= & {{\mathtt{idx}}}_{I{.}\mathsf{locals}} \\
& {{\mathtt{labelidx}}}_{I} & ::= & {{\mathtt{idx}}}_{I{.}\mathsf{labels}} \\
& {{\mathtt{fieldidx}}}_{I, x} & ::= & {{\mathtt{idx}}}_{I{.}\mathsf{fields}{}[x]} \\
& {{\mathtt{externidx}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{tag}\mbox{’}~~x{:}{{\mathtt{tagidx}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{tag}~x \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{global}\mbox{’}~~x{:}{{\mathtt{globalidx}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{global}~x \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{memory}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{mem}~x \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{table}\mbox{’}~~x{:}{{\mathtt{tableidx}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{table}~x \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{func}\mbox{’}~~x{:}{{\mathtt{funcidx}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{func}~x \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{numtype}} & ::= & \mbox{‘}\mathtt{i32}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} \\
& & | & \mbox{‘}\mathtt{i64}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} \\
& & | & \mbox{‘}\mathtt{f32}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} \\
& & | & \mbox{‘}\mathtt{f64}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} \\
& {\mathtt{vectype}} & ::= & \mbox{‘}\mathtt{v128}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{absheaptype}} & ::= & \mbox{‘}\mathtt{any}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{any} \\
& & | & \mbox{‘}\mathtt{eq}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{eq} \\
& & | & \mbox{‘}\mathtt{i31}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 31}} \\
& & | & \mbox{‘}\mathtt{struct}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{struct} \\
& & | & \mbox{‘}\mathtt{array}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{array} \\
& & | & \mbox{‘}\mathtt{none}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{none} \\
& & | & \mbox{‘}\mathtt{func}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{func} \\
& & | & \mbox{‘}\mathtt{nofunc}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{nofunc} \\
& & | & \mbox{‘}\mathtt{exn}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{exn} \\
& & | & \mbox{‘}\mathtt{noexn}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{noexn} \\
& & | & \mbox{‘}\mathtt{extern}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{extern} \\
& & | & \mbox{‘}\mathtt{noextern}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{noextern} \\
& {{\mathtt{heaptype}}}_{I} & ::= & {\mathit{ht}}{:}{\mathtt{absheaptype}} & \quad\Rightarrow\quad{} & {\mathit{ht}} \\
& & | & x{:}{{\mathtt{typeidx}}}_{I} & \quad\Rightarrow\quad{} & x \\
& {\mathtt{null}} & ::= & \mbox{‘}\mathtt{null}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{null} \\
& {{\mathtt{reftype}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{ref}\mbox{’}~~{\mathsf{null}^?}{:}{{\mathtt{null}}^?}~~{\mathit{ht}}{:}{{\mathtt{heaptype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{ref}~{\mathsf{null}^?}~{\mathit{ht}} \\
& & | & \mbox{‘}\mathtt{anyref}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{ref}\mbox{’}~~\mbox{‘}\mathtt{null}\mbox{’}~~\mbox{‘}\mathtt{any}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \\
& & | & \mbox{‘}\mathtt{eqref}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{ref}\mbox{’}~~\mbox{‘}\mathtt{null}\mbox{’}~~\mbox{‘}\mathtt{eq}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \\
& & | & \mbox{‘}\mathtt{i31ref}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{ref}\mbox{’}~~\mbox{‘}\mathtt{null}\mbox{’}~~\mbox{‘}\mathtt{i31}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \\
& & | & \mbox{‘}\mathtt{structref}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{ref}\mbox{’}~~\mbox{‘}\mathtt{null}\mbox{’}~~\mbox{‘}\mathtt{struct}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \\
& & | & \mbox{‘}\mathtt{arrayref}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{ref}\mbox{’}~~\mbox{‘}\mathtt{null}\mbox{’}~~\mbox{‘}\mathtt{array}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \\
& & | & \mbox{‘}\mathtt{nullref}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{ref}\mbox{’}~~\mbox{‘}\mathtt{null}\mbox{’}~~\mbox{‘}\mathtt{none}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \\
& & | & \mbox{‘}\mathtt{funcref}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{ref}\mbox{’}~~\mbox{‘}\mathtt{null}\mbox{’}~~\mbox{‘}\mathtt{func}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \\
& & | & \mbox{‘}\mathtt{nullfuncref}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{ref}\mbox{’}~~\mbox{‘}\mathtt{null}\mbox{’}~~\mbox{‘}\mathtt{nofunc}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \\
& & | & \mbox{‘}\mathtt{exnref}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{ref}\mbox{’}~~\mbox{‘}\mathtt{null}\mbox{’}~~\mbox{‘}\mathtt{exn}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \\
& & | & \mbox{‘}\mathtt{nullexnref}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{ref}\mbox{’}~~\mbox{‘}\mathtt{null}\mbox{’}~~\mbox{‘}\mathtt{noexn}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \\
& & | & \mbox{‘}\mathtt{externref}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{ref}\mbox{’}~~\mbox{‘}\mathtt{null}\mbox{’}~~\mbox{‘}\mathtt{extern}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \\
& & | & \mbox{‘}\mathtt{nullexternref}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{ref}\mbox{’}~~\mbox{‘}\mathtt{null}\mbox{’}~~\mbox{‘}\mathtt{noextern}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \\
& {{\mathtt{valtype}}}_{I} & ::= & {\mathit{nt}}{:}{\mathtt{numtype}} & \quad\Rightarrow\quad{} & {\mathit{nt}} \\
& & | & {\mathit{vt}}{:}{\mathtt{vectype}} & \quad\Rightarrow\quad{} & {\mathit{vt}} \\
& & | & {\mathit{rt}}{:}{{\mathtt{reftype}}}_{I} & \quad\Rightarrow\quad{} & {\mathit{rt}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{packtype}} & ::= & \mbox{‘}\mathtt{i8}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 8}} \\
& & | & \mbox{‘}\mathtt{i16}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 16}} \\
& {{\mathtt{storagetype}}}_{I} & ::= & t{:}{{\mathtt{valtype}}}_{I} & \quad\Rightarrow\quad{} & t \\
& & | & {\mathit{pt}}{:}{\mathtt{packtype}} & \quad\Rightarrow\quad{} & {\mathit{pt}} \\
& {{\mathtt{fieldtype}}}_{I} & ::= & {\mathit{zt}}{:}{{\mathtt{storagetype}}}_{I} & \quad\Rightarrow\quad{} & {\mathit{zt}} \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{mut}\mbox{’}~~{\mathit{zt}}{:}{{\mathtt{storagetype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{mut}~{\mathit{zt}} \\
& {{\mathtt{field}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{field}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~{\mathit{ft}}{:}{{\mathtt{fieldtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & ({\mathit{ft}}, {{\mathit{id}}^?}) \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{field}\mbox{’}~~{{{\mathtt{fieldtype}}}_{I}^\ast}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\equiv\quad{} & {(\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{field}\mbox{’}~~{{\mathtt{fieldtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’})^\ast} \\
& {{\mathtt{param}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{param}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~t{:}{{\mathtt{valtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (t, {{\mathit{id}}^?}) \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{param}\mbox{’}~~{{{\mathtt{valtype}}}_{I}^\ast}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\equiv\quad{} & {(\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{param}\mbox{’}~~{{\mathtt{valtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’})^\ast} \\
& {{\mathtt{result}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{result}\mbox{’}~~t{:}{{\mathtt{valtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & t \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{result}\mbox{’}~~{{{\mathtt{valtype}}}_{I}^\ast}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\equiv\quad{} & {(\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{param}\mbox{’}~~{{\mathtt{valtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’})^\ast} \\
& {{\mathtt{comptype}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{struct}\mbox{’}~~{({\mathit{ft}}, {{\mathit{id}}^?})^\ast}{:}{\mathtt{list}}({{\mathtt{field}}}_{I})~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{struct}~{{\mathit{ft}}^\ast}, \{ \mathsf{fields}~{({{\mathit{id}}^?})^\ast} \}) \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{array}\mbox{’}~~{\mathit{ft}}{:}{{\mathtt{fieldtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{array}~{\mathit{ft}}, \{  \}) \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{func}\mbox{’}~~{(t_1, {{\mathit{id}}^?})^\ast}{:}{\mathtt{list}}({{\mathtt{param}}}_{I})~~{t_2^\ast}{:}{\mathtt{list}}({{\mathtt{result}}}_{I})~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast}, \{  \}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{final}} & ::= & \mbox{‘}\mathtt{final}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{final} \\
& {{\mathtt{subtype}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{sub}\mbox{’}~~{{\mathit{fin}}^?}{:}{{\mathtt{final}}^?}~~{x^\ast}{:}{\mathtt{list}}({{\mathtt{typeidx}}}_{I})~~({\mathit{ct}}, {I'}){:}{{\mathtt{comptype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{sub}~{{\mathit{fin}}^?}~{x^\ast}~{\mathit{ct}}, {I'}) \\
& & | & {{\mathtt{comptype}}}_{I} & \quad\equiv\quad{} & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{sub}\mbox{’}~~\mbox{‘}\mathtt{final}\mbox{’}~~{{\mathtt{comptype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} \\
& {{\mathtt{typedef}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{type}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~({\mathit{st}}, {I'}){:}{{\mathtt{subtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & ({\mathit{st}}, {I'} \oplus \{ \mathsf{types}~({{\mathit{id}}^?}) \}) \\
& {{\mathtt{rectype}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{rec}\mbox{’}~~{({\mathit{st}}, {I'})^\ast}{:}{\mathtt{list}}({{\mathtt{typedef}}}_{I})~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{rec}~{{\mathit{st}}^\ast}, {\mathrm{concat}}_{\mathit{idctxt}}({{I'}^\ast})) \\
& & | & {{\mathtt{typedef}}}_{I} & \quad\equiv\quad{} & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{rec}\mbox{’}~~{{\mathtt{typedef}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{addrtype}} & ::= & \mbox{‘}\mathtt{i32}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} \\
& & | & \mbox{‘}\mathtt{i64}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} \\
& & | & \epsilon & \quad\equiv\quad{} & \mbox{‘}\mathtt{i32}\mbox{’} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{limits}} & ::= & n{:}{\mathtt{u64}} & \quad\Rightarrow\quad{} & {}[ n .. \epsilon ] \\
& & | & n{:}{\mathtt{u64}}~~m{:}{\mathtt{u64}} & \quad\Rightarrow\quad{} & {}[ n .. m ] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{tagtype}}}_{I} & ::= & (x, {I'}){:}{{\mathtt{typeuse}}}_{I} & \quad\Rightarrow\quad{} & x \\
& {{\mathtt{globaltype}}}_{I} & ::= & t{:}{{\mathtt{valtype}}}_{I} & \quad\Rightarrow\quad{} & t \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{mut}\mbox{’}~~t{:}{{\mathtt{valtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{mut}~t \\
& {{\mathtt{memtype}}}_{I} & ::= & {\mathit{at}}{:}{\mathtt{addrtype}}~~{\mathit{lim}}{:}{\mathtt{limits}} & \quad\Rightarrow\quad{} & {\mathit{at}}~{\mathit{lim}}~\mathsf{page} \\
& {{\mathtt{tabletype}}}_{I} & ::= & {\mathit{at}}{:}{\mathtt{addrtype}}~~{\mathit{lim}}{:}{\mathtt{limits}}~~{\mathit{rt}}{:}{{\mathtt{reftype}}}_{I} & \quad\Rightarrow\quad{} & {\mathit{at}}~{\mathit{lim}}~{\mathit{rt}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{externtype}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{tag}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~{\mathit{jt}}{:}{{\mathtt{tagtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{tag}~{\mathit{jt}}, \{ \mathsf{tags}~({{\mathit{id}}^?}) \}) \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{global}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~{\mathit{gt}}{:}{{\mathtt{globaltype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{global}~{\mathit{gt}}, \{ \mathsf{globals}~({{\mathit{id}}^?}) \}) \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{memory}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~{\mathit{mt}}{:}{{\mathtt{memtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{mem}~{\mathit{mt}}, \{ \mathsf{mems}~({{\mathit{id}}^?}) \}) \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{table}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~{\mathit{tt}}{:}{{\mathtt{tabletype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{table}~{\mathit{tt}}, \{ \mathsf{tables}~({{\mathit{id}}^?}) \}) \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{func}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~(x, {I'}){:}{{\mathtt{typeuse}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{func}~x, \{ \mathsf{funcs}~({{\mathit{id}}^?}) \}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{typeuse}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{type}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (x, {I'}) &  \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ I{.}\mathsf{typedefs}{}[x] = \mathsf{sub}~\mathsf{final}~(\mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast}) \\
{\land}~ {I'} = \{ \mathsf{locals}~{(\epsilon)^{{|{t_1^\ast}|}}} \} \\
\end{array}
} \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{type}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’}~~{(t_1, {{\mathit{id}}^?})^\ast}{:}{{{\mathtt{param}}}_{I}^\ast}~~{t_2^\ast}{:}{{{\mathtt{result}}}_{I}^\ast} & \quad\Rightarrow\quad{} & (x, {I'}) &  \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ I{.}\mathsf{typedefs}{}[x] = \mathsf{sub}~\mathsf{final}~(\mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast}) \\
{\land}~ {I'} = \{ \mathsf{locals}~{({{\mathit{id}}^?})^\ast} \} \\
{\land}~ {\vdash}\, {I'} : \mathsf{ok} \\
\end{array}
} \\
& & | & {(t_1, {{\mathit{id}}^?})^\ast}{:}{{{\mathtt{param}}}_{I}^\ast}~~{t_2^\ast}{:}{{{\mathtt{result}}}_{I}^\ast} & \quad\equiv\quad{} & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{type}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’}~~{{{\mathtt{param}}}_{I}^\ast}~~{{{\mathtt{result}}}_{I}^\ast} &  \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ I{.}\mathsf{typedefs}{}[x] = \mathsf{sub}~\mathsf{final}~(\mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast}) \\
{\land}~ (I{.}\mathsf{typedefs}{}[i] \neq \mathsf{sub}~\mathsf{final}~(\mathsf{func}~{t_1^\ast} \rightarrow {t_2^\ast}))^{i<x} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{label}}}_{I} & ::= & \epsilon & \quad\Rightarrow\quad{} & (\epsilon, \{ \mathsf{labels}~\epsilon \} \oplus I) \\
& & | & {\mathit{id}}{:}{\mathtt{id}} & \quad\Rightarrow\quad{} & ({\mathit{id}}, \{ \mathsf{labels}~{\mathit{id}} \} \oplus I) & \quad \mbox{if}~ {\neg({\mathit{id}} \in I{.}\mathsf{labels})} \\
& & | & {\mathit{id}}{:}{\mathtt{id}} & \quad\Rightarrow\quad{} & ({\mathit{id}}, \{ \mathsf{labels}~{\mathit{id}} \} \oplus I{}[{.}\mathsf{labels}{}[x] = \epsilon]) & \quad \mbox{if}~ {\mathit{id}} = I{.}\mathsf{labels}{}[x] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{instr}}}_{I} & ::= & {\mathit{in}}{:}{{\mathtt{plaininstr}}}_{I} & \quad\Rightarrow\quad{} & {\mathit{in}} \\
& & | & {\mathit{in}}{:}{{\mathtt{blockinstr}}}_{I} & \quad\Rightarrow\quad{} & {\mathit{in}} \\
& {{\mathtt{instrs}}}_{I} & ::= & {{\mathit{in}}^\ast}{:}{{{\mathtt{instr}}}_{I}^\ast} & \quad\Rightarrow\quad{} & {{\mathit{in}}^\ast} \\
& & | & {{{\mathit{in}}^\ast}^\ast}{:}{{{\mathtt{foldedinstr}}}_{I}^\ast} & \quad\Rightarrow\quad{} & {\bigoplus}\, {{{\mathit{in}}^\ast}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{foldedinstr}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~{\mathit{in}}{:}{{\mathtt{plaininstr}}}_{I}~~{{\mathit{in}'}^\ast}{:}{{\mathtt{instrs}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & {{\mathit{in}'}^\ast}~{\mathit{in}} \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{block}\mbox{’}~~({{\mathit{id}}^?}, {I'}){:}{{\mathtt{label}}}_{I}~~{\mathit{bt}}{:}{{\mathtt{blocktype}}}_{I}~~{{\mathit{in}}^\ast}{:}{{\mathtt{instrs}}}_{{I'}}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\mathsf{block}~{\mathit{bt}}~{{\mathit{in}}^\ast} \\
\end{array}
} \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{loop}\mbox{’}~~({{\mathit{id}}^?}, {I'}){:}{{\mathtt{label}}}_{I}~~{\mathit{bt}}{:}{{\mathtt{blocktype}}}_{I}~~{{\mathit{in}}^\ast}{:}{{\mathtt{instrs}}}_{{I'}}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\mathsf{loop}~{\mathit{bt}}~{{\mathit{in}}^\ast} \\
\end{array}
} \\
& & | & \begin{array}[t]{@{}l@{}} \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{if}\mbox{’}~~({{\mathit{id}}^?}, {I'}){:}{{\mathtt{label}}}_{I}~~{\mathit{bt}}{:}{{\mathtt{blocktype}}}_{I}~~{{\mathit{in}}^\ast}{:}{{\mathtt{instrs}}}_{{I'}} \\
  \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{then}\mbox{’}~~{{\mathit{in}}_1^\ast}{:}{{\mathtt{instrs}}}_{{I'}}~~\mbox{‘}\mathtt{)}\mbox{’} \\
  {(\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{else}\mbox{’}~~{{\mathit{in}}_2^\ast}{:}{{\mathtt{instrs}}}_{{I'}}~~\mbox{‘}\mathtt{)}\mbox{’})^?}~~\mbox{‘}\mathtt{)}\mbox{’} \end{array} & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{{\mathit{in}}^\ast}~(\mathsf{if}~{\mathit{bt}}~{{\mathit{in}}_1^\ast}~\mathsf{else}~{{\mathit{in}}_2^\ast}) \\
\end{array}
} \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{try\_table}\mbox{’}~~({{\mathit{id}}^?}, {I'}){:}{{\mathtt{label}}}_{I}~~{\mathit{bt}}{:}{{\mathtt{blocktype}}}_{I}~~{c^\ast}{:}{{{\mathtt{catch}}}_{I}^\ast}~~{{\mathit{in}}^\ast}{:}{{\mathtt{instrs}}}_{{I'}}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\mathsf{try\_table}~{\mathit{bt}}~{c^\ast}~{{\mathit{in}}^\ast} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{plaininstr}}}_{I} & ::= & \mbox{‘}\mathtt{unreachable}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{unreachable} \\
& & | & \mbox{‘}\mathtt{nop}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{nop} \\
& & | & \mbox{‘}\mathtt{drop}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{drop} \\
& & | & \mbox{‘}\mathtt{select}\mbox{’}~~{t^?}{:}{{{\mathtt{result}}}_{I}^?} & \quad\Rightarrow\quad{} & \mathsf{select}~{t^?} \\
& & | & \dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{blocktype}}}_{I} & ::= & {t^?}{:}{{{\mathtt{result}}}_{I}^?} & \quad\Rightarrow\quad{} & {t^?} \\
& & | & (x, {I'}){:}{{\mathtt{typeuse}}}_{I} & \quad\Rightarrow\quad{} & x & \quad \mbox{if}~ {I'} = \{ \mathsf{locals}~{(\epsilon)^\ast} \} \\
& {{\mathtt{blockinstr}}}_{I} & ::= & \mbox{‘}\mathtt{block}\mbox{’}~~({{\mathit{id}}^?}, {I'}){:}{{\mathtt{label}}}_{I}~~{\mathit{bt}}{:}{{\mathtt{blocktype}}}_{I}~~{{\mathit{in}}^\ast}{:}{{\mathtt{instrs}}}_{{I'}}~~\mbox{‘}\mathtt{end}\mbox{’}~~{{\mathit{id}'}^?}{:}{{\mathtt{id}}^?} & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\mathsf{block}~{\mathit{bt}}~{{\mathit{in}}^\ast} & \quad \mbox{if}~ {{\mathit{id}'}^?} = \epsilon \lor {{\mathit{id}'}^?} = {{\mathit{id}}^?} \\
\end{array}
} \\
& & | & \mbox{‘}\mathtt{loop}\mbox{’}~~({{\mathit{id}}^?}, {I'}){:}{{\mathtt{label}}}_{I}~~{\mathit{bt}}{:}{{\mathtt{blocktype}}}_{I}~~{{\mathit{in}}^\ast}{:}{{\mathtt{instrs}}}_{{I'}}~~\mbox{‘}\mathtt{end}\mbox{’}~~{{\mathit{id}'}^?}{:}{{\mathtt{id}}^?} & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\mathsf{loop}~{\mathit{bt}}~{{\mathit{in}}^\ast} & \quad \mbox{if}~ {{\mathit{id}'}^?} = \epsilon \lor {{\mathit{id}'}^?} = {{\mathit{id}}^?} \\
\end{array}
} \\
& & | & \mbox{‘}\mathtt{if}\mbox{’}~~({{\mathit{id}}^?}, {I'}){:}{{\mathtt{label}}}_{I}~~{\mathit{bt}}{:}{{\mathtt{blocktype}}}_{I}~~{{\mathit{in}}_1^\ast}{:}{{\mathtt{instrs}}}_{{I'}}~~\mbox{‘}\mathtt{else}\mbox{’}~~{{\mathit{id}}_1^?}{:}{{\mathtt{id}}^?}~~{{\mathit{in}}_2^\ast}{:}{{\mathtt{instrs}}}_{{I'}}~~\mbox{‘}\mathtt{end}\mbox{’}~~{{\mathit{id}}_2^?}{:}{{\mathtt{id}}^?} & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\mathsf{if}~{\mathit{bt}}~{{\mathit{in}}_1^\ast}~\mathsf{else}~{{\mathit{in}}_2^\ast} & \quad \mbox{if}~ ({{\mathit{id}}_1^?} = \epsilon \lor {{\mathit{id}}_1^?} = {{\mathit{id}}^?}) \land ({{\mathit{id}}_2^?} = \epsilon \lor {{\mathit{id}}_2^?} = {{\mathit{id}}^?}) \\
\end{array}
} \\
& & | & \mbox{‘}\mathtt{try\_table}\mbox{’}~~({{\mathit{id}}^?}, {I'}){:}{{\mathtt{label}}}_{I}~~{\mathit{bt}}{:}{{\mathtt{blocktype}}}_{I}~~{c^\ast}{:}{{{\mathtt{catch}}}_{I}^\ast}~~{{\mathit{in}}^\ast}{:}{{\mathtt{instrs}}}_{{I'}}~~\mbox{‘}\mathtt{end}\mbox{’}~~{{\mathit{id}'}^?}{:}{{\mathtt{id}}^?} & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\mathsf{try\_table}~{\mathit{bt}}~{c^\ast}~{{\mathit{in}}^\ast} & \quad \mbox{if}~ {{\mathit{id}'}^?} = \epsilon \lor {{\mathit{id}'}^?} = {{\mathit{id}}^?} \\
\end{array}
} \\
& & | & \mbox{‘}\mathtt{if}\mbox{’}~~{{\mathtt{label}}}_{I}~~{{\mathtt{blocktype}}}_{I}~~{{\mathtt{instrs}}}_{I}~~\mbox{‘}\mathtt{end}\mbox{’}~~{{\mathtt{id}}^?} & \quad\equiv\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\mbox{‘}\mathtt{if}\mbox{’}~~{{\mathtt{label}}}_{I}~~{{\mathtt{blocktype}}}_{I}~~{{\mathtt{instrs}}}_{I}~~\mbox{‘}\mathtt{else}\mbox{’}~~\mbox{‘}\mathtt{end}\mbox{’}~~{{\mathtt{id}}^?} \\
\end{array}
} \\
& {{\mathtt{catch}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{catch}\mbox{’}~~x{:}{{\mathtt{tagidx}}}_{I}~~l{:}{{\mathtt{labelidx}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{catch}~x~l \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{catch\_ref}\mbox{’}~~x{:}{{\mathtt{tagidx}}}_{I}~~l{:}{{\mathtt{labelidx}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{catch\_ref}~x~l \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{catch\_all}\mbox{’}~~l{:}{{\mathtt{labelidx}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{catch\_all}~l \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{catch\_all\_ref}\mbox{’}~~l{:}{{\mathtt{labelidx}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{catch\_all\_ref}~l \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{plaininstr}}}_{I} & ::= & \dots \\
& & | & \mbox{‘}\mathtt{br}\mbox{’}~~l{:}{{\mathtt{labelidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{br}~l \\
& & | & \mbox{‘}\mathtt{br\_if}\mbox{’}~~l{:}{{\mathtt{labelidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{br\_if}~l \\
& & | & \mbox{‘}\mathtt{br\_table}\mbox{’}~~{l^\ast}{:}{{{\mathtt{labelidx}}}_{I}^\ast}~~{l'}{:}{{\mathtt{labelidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{br\_table}~{l^\ast}~{l'} \\
& & | & \mbox{‘}\mathtt{br\_on\_null}\mbox{’}~~l{:}{{\mathtt{labelidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{br\_on\_null}~l \\
& & | & \mbox{‘}\mathtt{br\_on\_non\_null}\mbox{’}~~l{:}{{\mathtt{labelidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{br\_on\_non\_null}~l \\
& & | & \mbox{‘}\mathtt{br\_on\_cast}\mbox{’}~~l{:}{{\mathtt{labelidx}}}_{I}~~{\mathit{rt}}_1{:}{{\mathtt{reftype}}}_{I}~~{\mathit{rt}}_2{:}{{\mathtt{reftype}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{br\_on\_cast}~l~{\mathit{rt}}_1~{\mathit{rt}}_2 \\
& & | & \mbox{‘}\mathtt{br\_on\_cast\_fail}\mbox{’}~~l{:}{{\mathtt{labelidx}}}_{I}~~{\mathit{rt}}_1{:}{{\mathtt{reftype}}}_{I}~~{\mathit{rt}}_2{:}{{\mathtt{reftype}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{br\_on\_cast\_fail}~l~{\mathit{rt}}_1~{\mathit{rt}}_2 \\
& & | & \mbox{‘}\mathtt{call}\mbox{’}~~x{:}{{\mathtt{funcidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{call}~x \\
& & | & \mbox{‘}\mathtt{call\_ref}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{call\_ref}~x \\
& & | & \mbox{‘}\mathtt{call\_indirect}\mbox{’}~~x{:}{{\mathtt{tableidx}}}_{I}~~(y, {I'}){:}{{\mathtt{typeuse}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{call\_indirect}~x~y & \quad \mbox{if}~ {I'} = \{ \mathsf{locals}~{(\epsilon)^\ast} \} \\
& & | & \mbox{‘}\mathtt{return}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{return} \\
& & | & \mbox{‘}\mathtt{return\_call}\mbox{’}~~x{:}{{\mathtt{funcidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{return\_call}~x \\
& & | & \mbox{‘}\mathtt{return\_call\_ref}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{return\_call\_ref}~x \\
& & | & \mbox{‘}\mathtt{return\_call\_indirect}\mbox{’}~~x{:}{{\mathtt{tableidx}}}_{I}~~(y, {I'}){:}{{\mathtt{typeuse}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{return\_call\_indirect}~x~y & \quad \mbox{if}~ {I'} = \{ \mathsf{locals}~{(\epsilon)^\ast} \} \\
& & | & \mbox{‘}\mathtt{call\_indirect}\mbox{’}~~{{\mathtt{typeuse}}}_{I} & \quad\equiv\quad{} & \mbox{‘}\mathtt{call\_indirect}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{typeuse}}}_{I} \\
& & | & \mbox{‘}\mathtt{return\_call\_indirect}\mbox{’}~~{{\mathtt{typeuse}}}_{I} & \quad\equiv\quad{} & \mbox{‘}\mathtt{return\_call\_indirect}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{typeuse}}}_{I} \\
& & | & \mbox{‘}\mathtt{throw}\mbox{’}~~x{:}{{\mathtt{tagidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{throw}~x \\
& & | & \mbox{‘}\mathtt{throw\_ref}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{throw\_ref} \\
& & | & \dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{plaininstr}}}_{I} & ::= & \dots \\
& & | & \mbox{‘}\mathtt{local.get}\mbox{’}~~x{:}{{\mathtt{localidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{local{.}get}~x \\
& & | & \mbox{‘}\mathtt{local.set}\mbox{’}~~x{:}{{\mathtt{localidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{local{.}set}~x \\
& & | & \mbox{‘}\mathtt{local.tee}\mbox{’}~~x{:}{{\mathtt{localidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{local{.}tee}~x \\
& & | & \mbox{‘}\mathtt{global.get}\mbox{’}~~x{:}{{\mathtt{globalidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{global{.}get}~x \\
& & | & \mbox{‘}\mathtt{global.set}\mbox{’}~~x{:}{{\mathtt{globalidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{global{.}set}~x \\
& & | & \dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{plaininstr}}}_{I} & ::= & \dots \\
& & | & \mbox{‘}\mathtt{table.get}\mbox{’}~~x{:}{{\mathtt{tableidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{table{.}get}~x \\
& & | & \mbox{‘}\mathtt{table.set}\mbox{’}~~x{:}{{\mathtt{tableidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{table{.}set}~x \\
& & | & \mbox{‘}\mathtt{table.size}\mbox{’}~~x{:}{{\mathtt{tableidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{table{.}size}~x \\
& & | & \mbox{‘}\mathtt{table.grow}\mbox{’}~~x{:}{{\mathtt{tableidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{table{.}grow}~x \\
& & | & \mbox{‘}\mathtt{table.fill}\mbox{’}~~x{:}{{\mathtt{tableidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{table{.}fill}~x \\
& & | & \mbox{‘}\mathtt{table.copy}\mbox{’}~~x_1{:}{{\mathtt{tableidx}}}_{I}~~x_2{:}{{\mathtt{tableidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{table{.}copy}~x_1~x_2 \\
& & | & \mbox{‘}\mathtt{table.init}\mbox{’}~~x{:}{{\mathtt{tableidx}}}_{I}~~y{:}{{\mathtt{elemidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{table{.}init}~x~y \\
& & | & \mbox{‘}\mathtt{table.get}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{table.get}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’} \\
& & | & \mbox{‘}\mathtt{table.set}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{table.set}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’} \\
& & | & \mbox{‘}\mathtt{table.size}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{table.size}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’} \\
& & | & \mbox{‘}\mathtt{table.grow}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{table.grow}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’} \\
& & | & \mbox{‘}\mathtt{table.fill}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{table.fill}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’} \\
& & | & \mbox{‘}\mathtt{table.copy}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{table.copy}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’} \\
& & | & \mbox{‘}\mathtt{table.init}\mbox{’}~~{{\mathtt{elemidx}}}_{I} & \quad\equiv\quad{} & \mbox{‘}\mathtt{table.init}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{elemidx}}}_{I} \\
& & | & \mbox{‘}\mathtt{elem.drop}\mbox{’}~~x{:}{{\mathtt{elemidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{elem{.}drop}~x \\
& & | & \dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{memarg}}}_{N} & ::= & n{:}{\mathtt{offset}}~~m{:}{{\mathtt{align}}}_{N} & \quad\Rightarrow\quad{} & \{ \mathsf{align}~n,\;\allowbreak \mathsf{offset}~m \} \\
& {\mathtt{offset}} & ::= & \mbox{‘}\mathtt{offset=}\mbox{’}~~n{:}{\mathtt{u64}} & \quad\Rightarrow\quad{} & n \\
& {{\mathtt{align}}}_{N} & ::= & \mbox{‘}\mathtt{align=}\mbox{’}~~m{:}{\mathtt{u64}} & \quad\Rightarrow\quad{} & m & \quad \mbox{if}~ m = {2^{n}} \\
& {\mathtt{laneidx}} & ::= & i{:}{\mathtt{u8}} & \quad\Rightarrow\quad{} & i \\
& {{\mathtt{plaininstr}}}_{I} & ::= & \dots \\
& & | & \mbox{‘}\mathtt{i32.load}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{4} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}}{.}\mathsf{load}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{i64.load}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{8} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}}{.}\mathsf{load}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{f32.load}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{4} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}}{.}\mathsf{load}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{f64.load}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{8} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}}{.}\mathsf{load}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{i32.load8\_s}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{1} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{s}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{i32.load8\_u}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{1} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{u}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{i32.load16\_s}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{2} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{s}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{i32.load16\_u}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{2} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{u}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{i64.load8\_s}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{1} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{s}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{i64.load8\_u}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{1} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{u}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{i64.load16\_s}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{2} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{s}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{i64.load16\_u}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{2} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{u}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{i64.load32\_s}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{4} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 32}}}{\mathsf{\_}}{\mathsf{s}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{i64.load32\_u}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{4} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 32}}}{\mathsf{\_}}{\mathsf{u}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{v128.load}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{16} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}}{.}\mathsf{load}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{v128.load8x8\_s}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{8} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{s}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{v128.load8x8\_u}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{8} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{u}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{v128.load16x4\_s}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{8} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{\mathsf{\_}}{\mathsf{s}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{v128.load16x4\_u}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{8} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{\mathsf{\_}}{\mathsf{u}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{v128.load32x2\_s}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{8} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{\mathsf{\_}}{\mathsf{s}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{v128.load32x2\_u}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{8} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{\mathsf{\_}}{\mathsf{u}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{v128.load8\_splat}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{1} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{splat}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{v128.load16\_splat}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{2} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{splat}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{v128.load32\_splat}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{4} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 32}}}{\mathsf{\_}}{\mathsf{splat}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{v128.load64\_splat}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{8} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 64}}}{\mathsf{\_}}{\mathsf{splat}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{v128.load32\_zero}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{4} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 32}}}{\mathsf{\_}}{\mathsf{zero}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{v128.load64\_zero}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{8} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 64}}}{\mathsf{\_}}{\mathsf{zero}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{v128.load8\_lane}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{1}~~i{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~i \\
& & | & \mbox{‘}\mathtt{v128.load16\_lane}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{2}~~i{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~i \\
& & | & \mbox{‘}\mathtt{v128.load32\_lane}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{4}~~i{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 32}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~i \\
& & | & \mbox{‘}\mathtt{v128.load64\_lane}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{8}~~i{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 64}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~i \\
& & | & \mbox{‘}\mathtt{i32.store}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{4} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}}{.}\mathsf{store}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{i64.store}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{8} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}}{.}\mathsf{store}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{f32.store}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{4} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}}{.}\mathsf{store}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{f64.store}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{8} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}}{.}\mathsf{store}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{i32.store8}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{1} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 8}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{i32.store16}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{2} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 16}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{i64.store8}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{1} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 8}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{i64.store16}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{2} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 16}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{i64.store32}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{4} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 32}}}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{v128.store}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{16} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}}{.}\mathsf{store}~x~{\mathit{ao}} \\
& & | & \mbox{‘}\mathtt{v128.store8\_lane}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{1}~~i{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~i \\
& & | & \mbox{‘}\mathtt{v128.store16\_lane}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{2}~~i{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~i \\
& & | & \mbox{‘}\mathtt{v128.store32\_lane}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{4}~~i{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 32}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~i \\
& & | & \mbox{‘}\mathtt{v128.store64\_lane}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~{\mathit{ao}}{:}{{\mathtt{memarg}}}_{8}~~i{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 64}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~i \\
& & | & \mbox{‘}\mathtt{memory.size}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{memory{.}size}~x \\
& & | & \mbox{‘}\mathtt{memory.grow}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{memory{.}grow}~x \\
& & | & \mbox{‘}\mathtt{memory.fill}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{memory{.}fill}~x \\
& & | & \mbox{‘}\mathtt{memory.copy}\mbox{’}~~x_1{:}{{\mathtt{memidx}}}_{I}~~x_2{:}{{\mathtt{memidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{memory{.}copy}~x_1~x_2 \\
& & | & \mbox{‘}\mathtt{memory.init}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~y{:}{{\mathtt{dataidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{memory{.}init}~x~y \\
& & | & \mbox{‘}\mathtt{i32.load}\mbox{’}~~{{\mathtt{memarg}}}_{4} & \quad\equiv\quad{} & \mbox{‘}\mathtt{i32.load}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{4} \\
& & | & \mbox{‘}\mathtt{i64.load}\mbox{’}~~{{\mathtt{memarg}}}_{8} & \quad\equiv\quad{} & \mbox{‘}\mathtt{i64.load}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{8} \\
& & | & \mbox{‘}\mathtt{f32.load}\mbox{’}~~{{\mathtt{memarg}}}_{4} & \quad\equiv\quad{} & \mbox{‘}\mathtt{f32.load}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{4} \\
& & | & \mbox{‘}\mathtt{f64.load}\mbox{’}~~{{\mathtt{memarg}}}_{8} & \quad\equiv\quad{} & \mbox{‘}\mathtt{f64.load}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{8} \\
& & | & \mbox{‘}\mathtt{i32.load8\_s}\mbox{’}~~{{\mathtt{memarg}}}_{1} & \quad\equiv\quad{} & \mbox{‘}\mathtt{i32.load8\_s}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{1} \\
& & | & \mbox{‘}\mathtt{i32.load8\_u}\mbox{’}~~{{\mathtt{memarg}}}_{1} & \quad\equiv\quad{} & \mbox{‘}\mathtt{i32.load8\_u}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{1} \\
& & | & \mbox{‘}\mathtt{i32.load16\_s}\mbox{’}~~{{\mathtt{memarg}}}_{2} & \quad\equiv\quad{} & \mbox{‘}\mathtt{i32.load16\_s}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{2} \\
& & | & \mbox{‘}\mathtt{i32.load16\_u}\mbox{’}~~{{\mathtt{memarg}}}_{2} & \quad\equiv\quad{} & \mbox{‘}\mathtt{i32.load16\_u}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{2} \\
& & | & \mbox{‘}\mathtt{i64.load8\_s}\mbox{’}~~{{\mathtt{memarg}}}_{1} & \quad\equiv\quad{} & \mbox{‘}\mathtt{i64.load8\_s}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{1} \\
& & | & \mbox{‘}\mathtt{i64.load8\_u}\mbox{’}~~{{\mathtt{memarg}}}_{1} & \quad\equiv\quad{} & \mbox{‘}\mathtt{i64.load8\_u}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{1} \\
& & | & \mbox{‘}\mathtt{i64.load16\_s}\mbox{’}~~{{\mathtt{memarg}}}_{2} & \quad\equiv\quad{} & \mbox{‘}\mathtt{i64.load16\_s}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{2} \\
& & | & \mbox{‘}\mathtt{i64.load16\_u}\mbox{’}~~{{\mathtt{memarg}}}_{2} & \quad\equiv\quad{} & \mbox{‘}\mathtt{i64.load16\_u}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{2} \\
& & | & \mbox{‘}\mathtt{i64.load32\_s}\mbox{’}~~{{\mathtt{memarg}}}_{4} & \quad\equiv\quad{} & \mbox{‘}\mathtt{i64.load32\_s}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{4} \\
& & | & \mbox{‘}\mathtt{i64.load32\_u}\mbox{’}~~{{\mathtt{memarg}}}_{4} & \quad\equiv\quad{} & \mbox{‘}\mathtt{i64.load32\_u}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{4} \\
& & | & \mbox{‘}\mathtt{v128.load}\mbox{’}~~{{\mathtt{memarg}}}_{16} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.load}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{16} \\
& & | & \mbox{‘}\mathtt{v128.load8x8\_s}\mbox{’}~~{{\mathtt{memarg}}}_{8} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.load8x8\_s}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{8} \\
& & | & \mbox{‘}\mathtt{v128.load8x8\_u}\mbox{’}~~{{\mathtt{memarg}}}_{8} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.load8x8\_u}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{8} \\
& & | & \mbox{‘}\mathtt{v128.load16x4\_s}\mbox{’}~~{{\mathtt{memarg}}}_{8} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.load16x4\_s}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{8} \\
& & | & \mbox{‘}\mathtt{v128.load16x4\_u}\mbox{’}~~{{\mathtt{memarg}}}_{8} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.load16x4\_u}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{8} \\
& & | & \mbox{‘}\mathtt{v128.load32x2\_s}\mbox{’}~~{{\mathtt{memarg}}}_{8} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.load32x2\_s}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{8} \\
& & | & \mbox{‘}\mathtt{v128.load32x2\_u}\mbox{’}~~{{\mathtt{memarg}}}_{8} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.load32x2\_u}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{8} \\
& & | & \mbox{‘}\mathtt{v128.load8\_splat}\mbox{’}~~{{\mathtt{memarg}}}_{1} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.load8\_splat}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{1} \\
& & | & \mbox{‘}\mathtt{v128.load16\_splat}\mbox{’}~~{{\mathtt{memarg}}}_{2} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.load16\_splat}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{2} \\
& & | & \mbox{‘}\mathtt{v128.load32\_splat}\mbox{’}~~{{\mathtt{memarg}}}_{4} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.load32\_splat}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{4} \\
& & | & \mbox{‘}\mathtt{v128.load64\_splat}\mbox{’}~~{{\mathtt{memarg}}}_{8} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.load64\_splat}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{8} \\
& & | & \mbox{‘}\mathtt{v128.load32\_zero}\mbox{’}~~{{\mathtt{memarg}}}_{4} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.load32\_zero}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{4} \\
& & | & \mbox{‘}\mathtt{v128.load64\_zero}\mbox{’}~~{{\mathtt{memarg}}}_{8} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.load64\_zero}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{8} \\
& & | & \mbox{‘}\mathtt{v128.load8\_lane}\mbox{’}~~{{\mathtt{memarg}}}_{1}~~{\mathtt{laneidx}} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.load8\_lane}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{1}~~{\mathtt{laneidx}} \\
& & | & \mbox{‘}\mathtt{v128.load16\_lane}\mbox{’}~~{{\mathtt{memarg}}}_{2}~~{\mathtt{laneidx}} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.load16\_lane}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{2}~~{\mathtt{laneidx}} \\
& & | & \mbox{‘}\mathtt{v128.load32\_lane}\mbox{’}~~{{\mathtt{memarg}}}_{4}~~{\mathtt{laneidx}} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.load32\_lane}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{4}~~{\mathtt{laneidx}} \\
& & | & \mbox{‘}\mathtt{v128.load64\_lane}\mbox{’}~~{{\mathtt{memarg}}}_{8}~~{\mathtt{laneidx}} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.load64\_lane}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{8}~~{\mathtt{laneidx}} \\
& & | & \mbox{‘}\mathtt{i32.store}\mbox{’}~~{{\mathtt{memarg}}}_{4} & \quad\equiv\quad{} & \mbox{‘}\mathtt{i32.store}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{4} \\
& & | & \mbox{‘}\mathtt{i64.store}\mbox{’}~~{{\mathtt{memarg}}}_{8} & \quad\equiv\quad{} & \mbox{‘}\mathtt{i64.store}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{8} \\
& & | & \mbox{‘}\mathtt{f32.store}\mbox{’}~~{{\mathtt{memarg}}}_{4} & \quad\equiv\quad{} & \mbox{‘}\mathtt{f32.store}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{4} \\
& & | & \mbox{‘}\mathtt{f64.store}\mbox{’}~~{{\mathtt{memarg}}}_{8} & \quad\equiv\quad{} & \mbox{‘}\mathtt{f64.store}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{8} \\
& & | & \mbox{‘}\mathtt{i32.store8}\mbox{’}~~{{\mathtt{memarg}}}_{1} & \quad\equiv\quad{} & \mbox{‘}\mathtt{i32.store8}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{1} \\
& & | & \mbox{‘}\mathtt{i32.store16}\mbox{’}~~{{\mathtt{memarg}}}_{2} & \quad\equiv\quad{} & \mbox{‘}\mathtt{i32.store16}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{2} \\
& & | & \mbox{‘}\mathtt{i64.store8}\mbox{’}~~{{\mathtt{memarg}}}_{1} & \quad\equiv\quad{} & \mbox{‘}\mathtt{i64.store8}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{1} \\
& & | & \mbox{‘}\mathtt{i64.store16}\mbox{’}~~{{\mathtt{memarg}}}_{2} & \quad\equiv\quad{} & \mbox{‘}\mathtt{i64.store16}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{2} \\
& & | & \mbox{‘}\mathtt{i64.store32}\mbox{’}~~{{\mathtt{memarg}}}_{4} & \quad\equiv\quad{} & \mbox{‘}\mathtt{i64.store32}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{4} \\
& & | & \mbox{‘}\mathtt{v128.store}\mbox{’}~~{{\mathtt{memarg}}}_{16} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.store}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{16} \\
& & | & \mbox{‘}\mathtt{v128.store8\_lane}\mbox{’}~~{{\mathtt{memarg}}}_{1}~~{\mathtt{laneidx}} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.store8\_lane}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{1}~~{\mathtt{laneidx}} \\
& & | & \mbox{‘}\mathtt{v128.store16\_lane}\mbox{’}~~{{\mathtt{memarg}}}_{2}~~{\mathtt{laneidx}} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.store16\_lane}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{1}~~{\mathtt{laneidx}} \\
& & | & \mbox{‘}\mathtt{v128.store32\_lane}\mbox{’}~~{{\mathtt{memarg}}}_{4}~~{\mathtt{laneidx}} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.store32\_lane}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{1}~~{\mathtt{laneidx}} \\
& & | & \mbox{‘}\mathtt{v128.store64\_lane}\mbox{’}~~{{\mathtt{memarg}}}_{8}~~{\mathtt{laneidx}} & \quad\equiv\quad{} & \mbox{‘}\mathtt{v128.store64\_lane}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{memarg}}}_{1}~~{\mathtt{laneidx}} \\
& & | & \mbox{‘}\mathtt{memory.size}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{memory.size}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’} \\
& & | & \mbox{‘}\mathtt{memory.grow}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{memory.grow}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’} \\
& & | & \mbox{‘}\mathtt{memory.fill}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{memory.fill}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’} \\
& & | & \mbox{‘}\mathtt{memory.copy}\mbox{’} & \quad\equiv\quad{} & \mbox{‘}\mathtt{memory.copy}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’} \\
& & | & \mbox{‘}\mathtt{memory.init}\mbox{’}~~{{\mathtt{dataidx}}}_{I} & \quad\equiv\quad{} & \mbox{‘}\mathtt{memory.init}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~{{\mathtt{dataidx}}}_{I} \\
& & | & \mbox{‘}\mathtt{data.drop}\mbox{’}~~x{:}{{\mathtt{dataidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{data{.}drop}~x \\
& & | & \dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{plaininstr}}}_{I} & ::= & \dots \\
& & | & \mbox{‘}\mathtt{ref.null}\mbox{’}~~{\mathit{ht}}{:}{{\mathtt{heaptype}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{ref{.}null}~{\mathit{ht}} \\
& & | & \mbox{‘}\mathtt{ref.func}\mbox{’}~~x{:}{{\mathtt{funcidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{ref{.}func}~x \\
& & | & \mbox{‘}\mathtt{ref.is\_null}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{ref{.}is\_null} \\
& & | & \mbox{‘}\mathtt{ref.as\_non\_null}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{ref{.}as\_non\_null} \\
& & | & \mbox{‘}\mathtt{ref.eq}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{ref{.}eq} \\
& & | & \mbox{‘}\mathtt{ref.test}\mbox{’}~~{\mathit{rt}}{:}{{\mathtt{reftype}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{ref{.}test}~{\mathit{rt}} \\
& & | & \mbox{‘}\mathtt{ref.cast}\mbox{’}~~{\mathit{rt}}{:}{{\mathtt{reftype}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{ref{.}cast}~{\mathit{rt}} \\
& & | & \mbox{‘}\mathtt{ref.i31}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{ref{.}i{\scriptstyle 31}} \\
& & | & \mbox{‘}\mathtt{i31.get\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 31}{.}get}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i31.get\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 31}{.}get}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{struct.new}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{struct{.}new}~x \\
& & | & \mbox{‘}\mathtt{struct.new\_default}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{struct{.}new\_default}~x \\
& & | & \mbox{‘}\mathtt{struct.get}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I}~~i{:}{{\mathtt{fieldidx}}}_{I, x} & \quad\Rightarrow\quad{} & \mathsf{struct{.}get}~x~i \\
& & | & \mbox{‘}\mathtt{struct.get\_s}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I}~~i{:}{{\mathtt{fieldidx}}}_{I, x} & \quad\Rightarrow\quad{} & {\mathsf{struct{.}get}}{\mathsf{\_}}{\mathsf{s}}~x~i \\
& & | & \mbox{‘}\mathtt{struct.get\_u}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I}~~i{:}{{\mathtt{fieldidx}}}_{I, x} & \quad\Rightarrow\quad{} & {\mathsf{struct{.}get}}{\mathsf{\_}}{\mathsf{u}}~x~i \\
& & | & \mbox{‘}\mathtt{struct.set}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I}~~i{:}{{\mathtt{fieldidx}}}_{I, x} & \quad\Rightarrow\quad{} & \mathsf{struct{.}set}~x~i \\
& & | & \mbox{‘}\mathtt{array.new}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{array{.}new}~x \\
& & | & \mbox{‘}\mathtt{array.new\_default}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{array{.}new\_default}~x \\
& & | & \mbox{‘}\mathtt{array.new\_fixed}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I}~~n{:}{\mathtt{u32}} & \quad\Rightarrow\quad{} & \mathsf{array{.}new\_fixed}~x~n \\
& & | & \mbox{‘}\mathtt{array.new\_data}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I}~~y{:}{{\mathtt{dataidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{array{.}new\_data}~x~y \\
& & | & \mbox{‘}\mathtt{array.new\_elem}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I}~~y{:}{{\mathtt{elemidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{array{.}new\_elem}~x~y \\
& & | & \mbox{‘}\mathtt{array.get}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{array{.}get}~x \\
& & | & \mbox{‘}\mathtt{array.get\_s}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I} & \quad\Rightarrow\quad{} & {\mathsf{array{.}get}}{\mathsf{\_}}{\mathsf{s}}~x \\
& & | & \mbox{‘}\mathtt{array.get\_u}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I} & \quad\Rightarrow\quad{} & {\mathsf{array{.}get}}{\mathsf{\_}}{\mathsf{u}}~x \\
& & | & \mbox{‘}\mathtt{array.set}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{array{.}set}~x \\
& & | & \mbox{‘}\mathtt{array.len}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{array{.}len} \\
& & | & \mbox{‘}\mathtt{array.fill}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{array{.}fill}~x \\
& & | & \mbox{‘}\mathtt{array.copy}\mbox{’}~~x_1{:}{{\mathtt{typeidx}}}_{I}~~x_2{:}{{\mathtt{typeidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{array{.}copy}~x_1~x_2 \\
& & | & \mbox{‘}\mathtt{array.init\_data}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I}~~y{:}{{\mathtt{dataidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{array{.}init\_data}~x~y \\
& & | & \mbox{‘}\mathtt{array.init\_elem}\mbox{’}~~x{:}{{\mathtt{typeidx}}}_{I}~~y{:}{{\mathtt{elemidx}}}_{I} & \quad\Rightarrow\quad{} & \mathsf{array{.}init\_elem}~x~y \\
& & | & \mbox{‘}\mathtt{any.convert\_extern}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{any{.}convert\_extern} \\
& & | & \mbox{‘}\mathtt{extern.convert\_any}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{extern{.}convert\_any} \\
& & | & \dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{plaininstr}}}_{I} & ::= & \dots \\
& & | & \mbox{‘}\mathtt{i32.const}\mbox{’}~~c{:}{\mathtt{i32}} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c \\
& & | & \mbox{‘}\mathtt{i64.const}\mbox{’}~~c{:}{\mathtt{i64}} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}}{.}\mathsf{const}~c \\
& & | & \mbox{‘}\mathtt{f32.const}\mbox{’}~~c{:}{\mathtt{f32}} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}}{.}\mathsf{const}~c \\
& & | & \mbox{‘}\mathtt{f64.const}\mbox{’}~~c{:}{\mathtt{f64}} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}}{.}\mathsf{const}~c \\
& & | & \mbox{‘}\mathtt{i32.eqz}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{eqz} \\
& & | & \mbox{‘}\mathtt{i64.eqz}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{eqz} \\
& & | & \mbox{‘}\mathtt{i32.eq}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{eq} \\
& & | & \mbox{‘}\mathtt{i32.ne}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{ne} \\
& & | & \mbox{‘}\mathtt{i32.lt\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i32.lt\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i32.gt\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i32.gt\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i32.le\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i32.le\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i32.ge\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i32.ge\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i64.eq}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{eq} \\
& & | & \mbox{‘}\mathtt{i64.ne}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{ne} \\
& & | & \mbox{‘}\mathtt{i64.lt\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i64.lt\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i64.gt\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i64.gt\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i64.le\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i64.le\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i64.ge\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i64.ge\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{f32.eq}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{eq} \\
& & | & \mbox{‘}\mathtt{f32.ne}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{ne} \\
& & | & \mbox{‘}\mathtt{f32.lt}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{lt} \\
& & | & \mbox{‘}\mathtt{f32.gt}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{gt} \\
& & | & \mbox{‘}\mathtt{f32.le}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{le} \\
& & | & \mbox{‘}\mathtt{f32.ge}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{ge} \\
& & | & \mbox{‘}\mathtt{f64.eq}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{eq} \\
& & | & \mbox{‘}\mathtt{f64.ne}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{ne} \\
& & | & \mbox{‘}\mathtt{f64.lt}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{lt} \\
& & | & \mbox{‘}\mathtt{f64.gt}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{gt} \\
& & | & \mbox{‘}\mathtt{f64.le}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{le} \\
& & | & \mbox{‘}\mathtt{f64.ge}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{ge} \\
& & | & \mbox{‘}\mathtt{i32.clz}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{clz} \\
& & | & \mbox{‘}\mathtt{i32.ctz}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{ctz} \\
& & | & \mbox{‘}\mathtt{i32.popcnt}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{popcnt} \\
& & | & \mbox{‘}\mathtt{i32.extend8\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{extend}}{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i32.extend16\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{extend}}{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i64.clz}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{clz} \\
& & | & \mbox{‘}\mathtt{i64.ctz}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{ctz} \\
& & | & \mbox{‘}\mathtt{i64.popcnt}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{popcnt} \\
& & | & \mbox{‘}\mathtt{i64.extend8\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{extend}}{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i64.extend16\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{extend}}{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i64.extend32\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{extend}}{\mathsf{{\scriptstyle 32}}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{f32.abs}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{abs} \\
& & | & \mbox{‘}\mathtt{f32.neg}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{neg} \\
& & | & \mbox{‘}\mathtt{f32.sqrt}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{sqrt} \\
& & | & \mbox{‘}\mathtt{f32.ceil}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{ceil} \\
& & | & \mbox{‘}\mathtt{f32.floor}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{floor} \\
& & | & \mbox{‘}\mathtt{f32.trunc}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{trunc} \\
& & | & \mbox{‘}\mathtt{f32.nearest}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{nearest} \\
& & | & \mbox{‘}\mathtt{f64.abs}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{abs} \\
& & | & \mbox{‘}\mathtt{f64.neg}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{neg} \\
& & | & \mbox{‘}\mathtt{f64.sqrt}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{sqrt} \\
& & | & \mbox{‘}\mathtt{f64.ceil}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{ceil} \\
& & | & \mbox{‘}\mathtt{f64.floor}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{floor} \\
& & | & \mbox{‘}\mathtt{f64.trunc}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{trunc} \\
& & | & \mbox{‘}\mathtt{f64.nearest}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{nearest} \\
& & | & \mbox{‘}\mathtt{i32.add}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{add} \\
& & | & \mbox{‘}\mathtt{i32.sub}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{sub} \\
& & | & \mbox{‘}\mathtt{i32.mul}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{mul} \\
& & | & \mbox{‘}\mathtt{i32.div\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{div}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i32.div\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{div}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i32.rem\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{rem}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i32.rem\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{rem}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i32.and}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{and} \\
& & | & \mbox{‘}\mathtt{i32.or}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{or} \\
& & | & \mbox{‘}\mathtt{i32.xor}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{xor} \\
& & | & \mbox{‘}\mathtt{i32.shl}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{shl} \\
& & | & \mbox{‘}\mathtt{i32.shr\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i32.shr\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i32.rotl}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{rotl} \\
& & | & \mbox{‘}\mathtt{i32.rotr}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} \mathsf{rotr} \\
& & | & \mbox{‘}\mathtt{i64.add}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{add} \\
& & | & \mbox{‘}\mathtt{i64.sub}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{sub} \\
& & | & \mbox{‘}\mathtt{i64.mul}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{mul} \\
& & | & \mbox{‘}\mathtt{i64.div\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{div}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i64.div\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{div}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i64.rem\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{rem}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i64.rem\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{rem}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i64.and}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{and} \\
& & | & \mbox{‘}\mathtt{i64.or}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{or} \\
& & | & \mbox{‘}\mathtt{i64.xor}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{xor} \\
& & | & \mbox{‘}\mathtt{i64.shl}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{shl} \\
& & | & \mbox{‘}\mathtt{i64.shr\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i64.shr\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i64.rotl}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{rotl} \\
& & | & \mbox{‘}\mathtt{i64.rotr}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} \mathsf{rotr} \\
& & | & \mbox{‘}\mathtt{f32.add}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{add} \\
& & | & \mbox{‘}\mathtt{f32.sub}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{sub} \\
& & | & \mbox{‘}\mathtt{f32.mul}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{mul} \\
& & | & \mbox{‘}\mathtt{f32.div}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{div} \\
& & | & \mbox{‘}\mathtt{f32.min}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{min} \\
& & | & \mbox{‘}\mathtt{f32.max}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{max} \\
& & | & \mbox{‘}\mathtt{f32.copysign}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} \mathsf{copysign} \\
& & | & \mbox{‘}\mathtt{f64.add}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{add} \\
& & | & \mbox{‘}\mathtt{f64.sub}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{sub} \\
& & | & \mbox{‘}\mathtt{f64.mul}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{mul} \\
& & | & \mbox{‘}\mathtt{f64.div}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{div} \\
& & | & \mbox{‘}\mathtt{f64.min}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{min} \\
& & | & \mbox{‘}\mathtt{f64.max}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{max} \\
& & | & \mbox{‘}\mathtt{f64.copysign}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} \mathsf{copysign} \\
& & | & \mbox{‘}\mathtt{i32.wrap\_i64}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{wrap}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\
& & | & \mbox{‘}\mathtt{i32.trunc\_f32\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\
& & | & \mbox{‘}\mathtt{i32.trunc\_f32\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\
& & | & \mbox{‘}\mathtt{i32.trunc\_f64\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mbox{‘}\mathtt{i32.trunc\_f64\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mbox{‘}\mathtt{i32.trunc\_sat\_f32\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\
& & | & \mbox{‘}\mathtt{i32.trunc\_sat\_f32\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\
& & | & \mbox{‘}\mathtt{i32.trunc\_sat\_f64\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mbox{‘}\mathtt{i32.trunc\_sat\_f64\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mbox{‘}\mathtt{i64.extend\_i64\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\
& & | & \mbox{‘}\mathtt{i64.extend\_i64\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\
& & | & \mbox{‘}\mathtt{i64.trunc\_f32\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\
& & | & \mbox{‘}\mathtt{i64.trunc\_f32\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\
& & | & \mbox{‘}\mathtt{i64.trunc\_f64\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mbox{‘}\mathtt{i64.trunc\_f64\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mbox{‘}\mathtt{i64.trunc\_sat\_f32\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\
& & | & \mbox{‘}\mathtt{i64.trunc\_sat\_f32\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\
& & | & \mbox{‘}\mathtt{i64.trunc\_sat\_f64\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mbox{‘}\mathtt{i64.trunc\_sat\_f64\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mbox{‘}\mathtt{f32.demote\_f64}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} {\mathsf{demote}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mbox{‘}\mathtt{f32.convert\_i32\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 32}}} \\
& & | & \mbox{‘}\mathtt{f32.convert\_i32\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 32}}} \\
& & | & \mbox{‘}\mathtt{f32.convert\_i64\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\
& & | & \mbox{‘}\mathtt{f32.convert\_i64\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\
& & | & \mbox{‘}\mathtt{f64.promote\_f32}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} {\mathsf{promote}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\
& & | & \mbox{‘}\mathtt{f64.convert\_i32\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 32}}} \\
& & | & \mbox{‘}\mathtt{f64.convert\_i32\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 32}}} \\
& & | & \mbox{‘}\mathtt{f64.convert\_i64\_s}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\
& & | & \mbox{‘}\mathtt{f64.convert\_i64\_u}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\
& & | & \mbox{‘}\mathtt{i32.reinterpret\_f32}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 32}} {.} {\mathsf{reinterpret}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\
& & | & \mbox{‘}\mathtt{i64.reinterpret\_f64}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{i{\scriptstyle 64}} {.} {\mathsf{reinterpret}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\
& & | & \mbox{‘}\mathtt{f32.reinterpret\_i32}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 32}} {.} {\mathsf{reinterpret}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 32}}} \\
& & | & \mbox{‘}\mathtt{f64.reinterpret\_i64}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{f{\scriptstyle 64}} {.} {\mathsf{reinterpret}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\
& & | & \dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{plaininstr}}}_{I} & ::= & \dots \\
& & | & \mbox{‘}\mathtt{v128.const}\mbox{’}~~\mbox{‘}\mathtt{i8x16}\mbox{’}~~{c^\ast}{:}{{\mathtt{i8}}^{16}} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~{{{{\mathrm{bytes}}}_{{\mathsf{i}}{128}}^{{-1}}}}{({\bigoplus}\, {{{\mathrm{bytes}}}_{{\mathsf{i}}{8}}(c)^\ast})} \\
& & | & \mbox{‘}\mathtt{v128.const}\mbox{’}~~\mbox{‘}\mathtt{i16x8}\mbox{’}~~{c^\ast}{:}{{\mathtt{i16}}^{8}} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~{{{{\mathrm{bytes}}}_{{\mathsf{i}}{128}}^{{-1}}}}{({\bigoplus}\, {{{\mathrm{bytes}}}_{{\mathsf{i}}{16}}(c)^\ast})} \\
& & | & \mbox{‘}\mathtt{v128.const}\mbox{’}~~\mbox{‘}\mathtt{i32x4}\mbox{’}~~{c^\ast}{:}{{\mathtt{i32}}^{4}} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~{{{{\mathrm{bytes}}}_{{\mathsf{i}}{128}}^{{-1}}}}{({\bigoplus}\, {{{\mathrm{bytes}}}_{{\mathsf{i}}{32}}(c)^\ast})} \\
& & | & \mbox{‘}\mathtt{v128.const}\mbox{’}~~\mbox{‘}\mathtt{i64x2}\mbox{’}~~{c^\ast}{:}{{\mathtt{i64}}^{2}} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~{{{{\mathrm{bytes}}}_{{\mathsf{i}}{128}}^{{-1}}}}{({\bigoplus}\, {{{\mathrm{bytes}}}_{{\mathsf{i}}{64}}(c)^\ast})} \\
& & | & \mbox{‘}\mathtt{v128.const}\mbox{’}~~\mbox{‘}\mathtt{f32x4}\mbox{’}~~{c^\ast}{:}{{\mathtt{f32}}^{4}} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~{{{{\mathrm{bytes}}}_{{\mathsf{i}}{128}}^{{-1}}}}{({\bigoplus}\, {{{\mathrm{bytes}}}_{{\mathsf{f}}{32}}(c)^\ast})} \\
& & | & \mbox{‘}\mathtt{v128.const}\mbox{’}~~\mbox{‘}\mathtt{f64x2}\mbox{’}~~{c^\ast}{:}{{\mathtt{f64}}^{2}} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~{{{{\mathrm{bytes}}}_{{\mathsf{i}}{128}}^{{-1}}}}{({\bigoplus}\, {{{\mathrm{bytes}}}_{{\mathsf{f}}{64}}(c)^\ast})} \\
& & | & \mbox{‘}\mathtt{i8x16.shuffle}\mbox{’}~~{i^\ast}{:}{{\mathtt{laneidx}}^{16}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{shuffle}~{i^\ast} \\
& & | & \mbox{‘}\mathtt{i8x16.swizzle}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{swizzle} \\
& & | & \mbox{‘}\mathtt{i8x16.relaxed\_swizzle}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{relaxed\_swizzle} \\
& & | & \mbox{‘}\mathtt{i8x16.splat}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{splat} \\
& & | & \mbox{‘}\mathtt{i16x8.splat}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{splat} \\
& & | & \mbox{‘}\mathtt{i32x4.splat}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{splat} \\
& & | & \mbox{‘}\mathtt{i64x2.splat}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{splat} \\
& & | & \mbox{‘}\mathtt{f32x4.splat}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{splat} \\
& & | & \mbox{‘}\mathtt{f64x2.splat}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{splat} \\
& & | & \mbox{‘}\mathtt{i8x16.extract\_lane\_s}\mbox{’}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{\mathsf{s}}~l \\
& & | & \mbox{‘}\mathtt{i8x16.extract\_lane\_u}\mbox{’}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{\mathsf{u}}~l \\
& & | & \mbox{‘}\mathtt{i16x8.extract\_lane\_s}\mbox{’}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{\mathsf{s}}~l \\
& & | & \mbox{‘}\mathtt{i16x8.extract\_lane\_u}\mbox{’}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{\mathsf{u}}~l \\
& & | & \mbox{‘}\mathtt{i32x4.extract\_lane}\mbox{’}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{extract\_lane}~l \\
& & | & \mbox{‘}\mathtt{i64x2.extract\_lane}\mbox{’}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{extract\_lane}~l \\
& & | & \mbox{‘}\mathtt{f32x4.extract\_lane}\mbox{’}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{extract\_lane}~l \\
& & | & \mbox{‘}\mathtt{f64x2.extract\_lane}\mbox{’}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{extract\_lane}~l \\
& & | & \mbox{‘}\mathtt{i8x16.replace\_lane}\mbox{’}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{replace\_lane}~l \\
& & | & \mbox{‘}\mathtt{i16x8.replace\_lane}\mbox{’}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{replace\_lane}~l \\
& & | & \mbox{‘}\mathtt{i32x4.replace\_lane}\mbox{’}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{replace\_lane}~l \\
& & | & \mbox{‘}\mathtt{i64x2.replace\_lane}\mbox{’}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{replace\_lane}~l \\
& & | & \mbox{‘}\mathtt{f32x4.replace\_lane}\mbox{’}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{replace\_lane}~l \\
& & | & \mbox{‘}\mathtt{f64x2.replace\_lane}\mbox{’}~~l{:}{\mathtt{laneidx}} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{replace\_lane}~l \\
& & | & \mbox{‘}\mathtt{v128.any\_true}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}} {.} \mathsf{any\_true} \\
& & | & \mbox{‘}\mathtt{i8x16.all\_true}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{all\_true} \\
& & | & \mbox{‘}\mathtt{i16x8.all\_true}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{all\_true} \\
& & | & \mbox{‘}\mathtt{i32x4.all\_true}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{all\_true} \\
& & | & \mbox{‘}\mathtt{i64x2.all\_true}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{all\_true} \\
& & | & \mbox{‘}\mathtt{i8x16.eq}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{eq} \\
& & | & \mbox{‘}\mathtt{i8x16.ne}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{ne} \\
& & | & \mbox{‘}\mathtt{i8x16.lt\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i8x16.lt\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i8x16.gt\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i8x16.gt\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i8x16.le\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i8x16.le\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i8x16.ge\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i8x16.ge\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i16x8.eq}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{eq} \\
& & | & \mbox{‘}\mathtt{i16x8.ne}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{ne} \\
& & | & \mbox{‘}\mathtt{i16x8.lt\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i16x8.lt\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i16x8.gt\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i16x8.gt\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i16x8.le\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i16x8.le\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i16x8.ge\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i16x8.ge\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i32x4.eq}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{eq} \\
& & | & \mbox{‘}\mathtt{i32x4.ne}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{ne} \\
& & | & \mbox{‘}\mathtt{i32x4.lt\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i32x4.lt\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i32x4.gt\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i32x4.gt\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i32x4.le\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i32x4.le\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i32x4.ge\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i32x4.ge\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i64x2.eq}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{eq} \\
& & | & \mbox{‘}\mathtt{i64x2.ne}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{ne} \\
& & | & \mbox{‘}\mathtt{i64x2.lt\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i64x2.gt\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i64x2.le\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i64x2.ge\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{f32x4.eq}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{eq} \\
& & | & \mbox{‘}\mathtt{f32x4.ne}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{ne} \\
& & | & \mbox{‘}\mathtt{f32x4.lt}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{lt} \\
& & | & \mbox{‘}\mathtt{f32x4.gt}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{gt} \\
& & | & \mbox{‘}\mathtt{f32x4.le}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{le} \\
& & | & \mbox{‘}\mathtt{f32x4.ge}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{ge} \\
& & | & \mbox{‘}\mathtt{f64x2.eq}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{eq} \\
& & | & \mbox{‘}\mathtt{f64x2.ne}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{ne} \\
& & | & \mbox{‘}\mathtt{f64x2.lt}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{lt} \\
& & | & \mbox{‘}\mathtt{f64x2.gt}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{gt} \\
& & | & \mbox{‘}\mathtt{f64x2.le}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{le} \\
& & | & \mbox{‘}\mathtt{f64x2.ge}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{ge} \\
& & | & \mbox{‘}\mathtt{v128.not}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}} {.} \mathsf{not} \\
& & | & \mbox{‘}\mathtt{i8x16.abs}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{abs} \\
& & | & \mbox{‘}\mathtt{i8x16.neg}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{neg} \\
& & | & \mbox{‘}\mathtt{i8x16.popcnt}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{popcnt} \\
& & | & \mbox{‘}\mathtt{i16x8.abs}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{abs} \\
& & | & \mbox{‘}\mathtt{i16x8.neg}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{neg} \\
& & | & \mbox{‘}\mathtt{i32x4.abs}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{abs} \\
& & | & \mbox{‘}\mathtt{i32x4.neg}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{neg} \\
& & | & \mbox{‘}\mathtt{i64x2.abs}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{abs} \\
& & | & \mbox{‘}\mathtt{i64x2.neg}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{neg} \\
& & | & \mbox{‘}\mathtt{f32x4.abs}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{abs} \\
& & | & \mbox{‘}\mathtt{f32x4.neg}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{neg} \\
& & | & \mbox{‘}\mathtt{f32x4.sqrt}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{sqrt} \\
& & | & \mbox{‘}\mathtt{f32x4.ceil}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{ceil} \\
& & | & \mbox{‘}\mathtt{f32x4.floor}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{floor} \\
& & | & \mbox{‘}\mathtt{f32x4.trunc}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{trunc} \\
& & | & \mbox{‘}\mathtt{f32x4.nearest}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{nearest} \\
& & | & \mbox{‘}\mathtt{f64x2.abs}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{abs} \\
& & | & \mbox{‘}\mathtt{f64x2.neg}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{neg} \\
& & | & \mbox{‘}\mathtt{f64x2.sqrt}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{sqrt} \\
& & | & \mbox{‘}\mathtt{f64x2.ceil}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{ceil} \\
& & | & \mbox{‘}\mathtt{f64x2.floor}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{floor} \\
& & | & \mbox{‘}\mathtt{f64x2.trunc}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{trunc} \\
& & | & \mbox{‘}\mathtt{f64x2.nearest}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{nearest} \\
& & | & \mbox{‘}\mathtt{v128.and}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}} {.} \mathsf{and} \\
& & | & \mbox{‘}\mathtt{v128.andnot}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}} {.} \mathsf{andnot} \\
& & | & \mbox{‘}\mathtt{v128.or}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}} {.} \mathsf{or} \\
& & | & \mbox{‘}\mathtt{v128.xor}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}} {.} \mathsf{xor} \\
& & | & \mbox{‘}\mathtt{i8x16.add}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{add} \\
& & | & \mbox{‘}\mathtt{i8x16.add\_sat\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{add\_sat}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i8x16.add\_sat\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{add\_sat}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i8x16.sub}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{sub} \\
& & | & \mbox{‘}\mathtt{i8x16.sub\_sat\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{sub\_sat}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i8x16.sub\_sat\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{sub\_sat}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i8x16.min\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{min}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i8x16.min\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{min}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i8x16.max\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{max}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i8x16.max\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{max}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i8x16.avgr\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{avgr}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i16x8.add}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{add} \\
& & | & \mbox{‘}\mathtt{i16x8.add\_sat\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{add\_sat}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i16x8.add\_sat\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{add\_sat}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i16x8.sub}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{sub} \\
& & | & \mbox{‘}\mathtt{i16x8.sub\_sat\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{sub\_sat}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i16x8.sub\_sat\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{sub\_sat}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i16x8.mul}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{mul} \\
& & | & \mbox{‘}\mathtt{i16x8.min\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{min}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i16x8.min\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{min}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i16x8.max\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{max}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i16x8.max\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{max}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i16x8.avgr\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{avgr}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i16x8.q15mulr\_sat\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{q{\scriptstyle 15}mulr\_sat}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i16x8.relaxed\_q15mulr\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{relaxed\_q{\scriptstyle 15}mulr}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i32x4.add}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{add} \\
& & | & \mbox{‘}\mathtt{i32x4.sub}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{sub} \\
& & | & \mbox{‘}\mathtt{i32x4.mul}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{mul} \\
& & | & \mbox{‘}\mathtt{i32x4.min\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{min}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i32x4.min\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{min}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i32x4.max\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{max}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i32x4.max\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{max}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i64x2.add}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{add} \\
& & | & \mbox{‘}\mathtt{i64x2.sub}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{sub} \\
& & | & \mbox{‘}\mathtt{i64x2.mul}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{mul} \\
& & | & \mbox{‘}\mathtt{f32x4.add}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{add} \\
& & | & \mbox{‘}\mathtt{f32x4.sub}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{sub} \\
& & | & \mbox{‘}\mathtt{f32x4.mul}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{mul} \\
& & | & \mbox{‘}\mathtt{f32x4.div}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{div} \\
& & | & \mbox{‘}\mathtt{f32x4.min}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{min} \\
& & | & \mbox{‘}\mathtt{f32x4.max}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{max} \\
& & | & \mbox{‘}\mathtt{f32x4.pmin}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{pmin} \\
& & | & \mbox{‘}\mathtt{f32x4.pmax}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{pmax} \\
& & | & \mbox{‘}\mathtt{f32x4.relaxed\_min}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{relaxed\_min} \\
& & | & \mbox{‘}\mathtt{f32x4.relaxed\_max}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{relaxed\_max} \\
& & | & \mbox{‘}\mathtt{f64x2.add}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{add} \\
& & | & \mbox{‘}\mathtt{f64x2.sub}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{sub} \\
& & | & \mbox{‘}\mathtt{f64x2.mul}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{mul} \\
& & | & \mbox{‘}\mathtt{f64x2.div}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{div} \\
& & | & \mbox{‘}\mathtt{f64x2.min}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{min} \\
& & | & \mbox{‘}\mathtt{f64x2.max}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{max} \\
& & | & \mbox{‘}\mathtt{f64x2.pmin}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{pmin} \\
& & | & \mbox{‘}\mathtt{f64x2.pmax}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{pmax} \\
& & | & \mbox{‘}\mathtt{f64x2.relaxed\_min}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{relaxed\_min} \\
& & | & \mbox{‘}\mathtt{f64x2.relaxed\_max}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{relaxed\_max} \\
& & | & \mbox{‘}\mathtt{v128.bitselect}\mbox{’} & \quad\Rightarrow\quad{} & \mathsf{v{\scriptstyle 128}} {.} \mathsf{bitselect} \\
& & | & \mbox{‘}\mathtt{i8x16.relaxed\_laneselect}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{relaxed\_laneselect} \\
& & | & \mbox{‘}\mathtt{i16x8.relaxed\_laneselect}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{relaxed\_laneselect} \\
& & | & \mbox{‘}\mathtt{i32x4.relaxed\_laneselect}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{relaxed\_laneselect} \\
& & | & \mbox{‘}\mathtt{i64x2.relaxed\_laneselect}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{relaxed\_laneselect} \\
& & | & \mbox{‘}\mathtt{f32x4.relaxed\_madd}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{relaxed\_madd} \\
& & | & \mbox{‘}\mathtt{f32x4.relaxed\_nmadd}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{relaxed\_nmadd} \\
& & | & \mbox{‘}\mathtt{f64x2.relaxed\_madd}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{relaxed\_madd} \\
& & | & \mbox{‘}\mathtt{f64x2.relaxed\_nmadd}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{relaxed\_nmadd} \\
& & | & \mbox{‘}\mathtt{i8x16.shl}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{shl} \\
& & | & \mbox{‘}\mathtt{i8x16.shr\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i8x16.shr\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i16x8.shl}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{shl} \\
& & | & \mbox{‘}\mathtt{i16x8.shr\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i16x8.shr\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i32x4.shl}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{shl} \\
& & | & \mbox{‘}\mathtt{i32x4.shr\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i32x4.shr\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i64x2.shl}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{shl} \\
& & | & \mbox{‘}\mathtt{i64x2.shr\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i64x2.shr\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i8x16.bitmask}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{bitmask} \\
& & | & \mbox{‘}\mathtt{i16x8.bitmask}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{bitmask} \\
& & | & \mbox{‘}\mathtt{i32x4.bitmask}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{bitmask} \\
& & | & \mbox{‘}\mathtt{i64x2.bitmask}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{bitmask} \\
& & | & \mbox{‘}\mathtt{i8x16.narrow\_i16x8\_s}\mbox{’} & \quad\Rightarrow\quad{} & {{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{narrow}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i8x16.narrow\_i16x8\_u}\mbox{’} & \quad\Rightarrow\quad{} & {{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{narrow}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i16x8.narrow\_i32x4\_s}\mbox{’} & \quad\Rightarrow\quad{} & {{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{narrow}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}}{\mathsf{\_}}{\mathsf{s}} \\
& & | & \mbox{‘}\mathtt{i16x8.narrow\_i32x4\_u}\mbox{’} & \quad\Rightarrow\quad{} & {{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{narrow}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}}{\mathsf{\_}}{\mathsf{u}} \\
& & | & \mbox{‘}\mathtt{i16x8.extend\_low\_i8x16\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mbox{‘}\mathtt{i16x8.extend\_low\_i8x16\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mbox{‘}\mathtt{i16x8.extend\_high\_i8x16\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mbox{‘}\mathtt{i16x8.extend\_high\_i8x16\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mbox{‘}\mathtt{i32x4.extend\_low\_i16x8\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mbox{‘}\mathtt{i32x4.extend\_low\_i16x8\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mbox{‘}\mathtt{i32x4.extend\_high\_i16x8\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mbox{‘}\mathtt{i32x4.extend\_high\_i16x8\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mbox{‘}\mathtt{i32x4.trunc\_sat\_f32x4\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mbox{‘}\mathtt{i32x4.trunc\_sat\_f32x4\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mbox{‘}\mathtt{i32x4.trunc\_sat\_f64x2\_s\_zero}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{s}~\mathsf{zero}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}} \\
& & | & \mbox{‘}\mathtt{i32x4.trunc\_sat\_f64x2\_u\_zero}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{u}~\mathsf{zero}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}} \\
& & | & \mbox{‘}\mathtt{i32x4.relaxed\_trunc\_f32x4\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{relaxed\_trunc}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mbox{‘}\mathtt{i32x4.relaxed\_trunc\_f32x4\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{relaxed\_trunc}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mbox{‘}\mathtt{i32x4.relaxed\_trunc\_f64x2\_s\_zero}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{relaxed\_trunc}}{\mathsf{\_}}{\mathsf{s}~\mathsf{zero}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}} \\
& & | & \mbox{‘}\mathtt{i32x4.relaxed\_trunc\_f64x2\_u\_zero}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{relaxed\_trunc}}{\mathsf{\_}}{\mathsf{u}~\mathsf{zero}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}} \\
& & | & \mbox{‘}\mathtt{i64x2.extend\_low\_i32x4\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mbox{‘}\mathtt{i64x2.extend\_low\_i32x4\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mbox{‘}\mathtt{i64x2.extend\_high\_i32x4\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mbox{‘}\mathtt{i64x2.extend\_high\_i32x4\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mbox{‘}\mathtt{f32x4.demote\_f64x2\_zero}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{demote}}{\mathsf{\_}}{\mathsf{zero}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}} \\
& & | & \mbox{‘}\mathtt{f32x4.convert\_i32x4\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mbox{‘}\mathtt{f32x4.convert\_i32x4\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mbox{‘}\mathtt{f64x2.promote\_low\_f32x4}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{promote}}{\mathsf{\_}}{\mathsf{low}}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mbox{‘}\mathtt{f64x2.convert\_low\_i32x4\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{low}~\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mbox{‘}\mathtt{f64x2.convert\_low\_i32x4\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{low}~\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mbox{‘}\mathtt{i16x8.extadd\_pairwise\_i8x16\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extadd\_pairwise}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mbox{‘}\mathtt{i16x8.extadd\_pairwise\_i8x16\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extadd\_pairwise}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mbox{‘}\mathtt{i32x4.extadd\_pairwise\_i16x8\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extadd\_pairwise}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mbox{‘}\mathtt{i32x4.extadd\_pairwise\_i16x8\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extadd\_pairwise}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mbox{‘}\mathtt{i16x8.extmul\_low\_i8x16\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mbox{‘}\mathtt{i16x8.extmul\_low\_i8x16\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mbox{‘}\mathtt{i16x8.extmul\_high\_i8x16\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mbox{‘}\mathtt{i16x8.extmul\_high\_i8x16\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\
& & | & \mbox{‘}\mathtt{i32x4.extmul\_low\_i16x8\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mbox{‘}\mathtt{i32x4.extmul\_low\_i16x8\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mbox{‘}\mathtt{i32x4.extmul\_high\_i16x8\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mbox{‘}\mathtt{i32x4.extmul\_high\_i16x8\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mbox{‘}\mathtt{i32x4.dot\_i16x8\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{dot}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\
& & | & \mbox{‘}\mathtt{i64x2.extmul\_low\_i32x4\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mbox{‘}\mathtt{i64x2.extmul\_low\_i32x4\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{low}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mbox{‘}\mathtt{i64x2.extmul\_high\_i32x4\_s}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
& & | & \mbox{‘}\mathtt{i64x2.extmul\_high\_i32x4\_u}\mbox{’} & \quad\Rightarrow\quad{} & {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{high}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{expr}}}_{I} & ::= & {{\mathit{in}}^\ast}{:}{{\mathtt{instrs}}}_{I} & \quad\Rightarrow\quad{} & {{\mathit{in}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{type}}}_{I} & ::= & ({\mathit{qt}}, {I'}){:}{{\mathtt{rectype}}}_{I} & \quad\Rightarrow\quad{} & (\mathsf{type}~{\mathit{qt}}, {I'} \oplus {I''}) & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {\mathit{qt}} = \mathsf{rec}~{{\mathit{st}}^{n}} \\
{\land}~ n = 1 \land {I''} = \{ \mathsf{typedefs}~{\mathit{st}} \} \lor n \neq 1 \land {I''} = \{ \mathsf{typedefs}~{\epsilon^{n}} \} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{tag}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{tag}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~{\mathit{jt}}{:}{{\mathtt{tagtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{tag}~{\mathit{jt}}, \{ \mathsf{tags}~({{\mathit{id}}^?}) \}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{global}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{global}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~{\mathit{gt}}{:}{{\mathtt{globaltype}}}_{I}~~e{:}{{\mathtt{expr}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{global}~{\mathit{gt}}~e, \{ \mathsf{globals}~({{\mathit{id}}^?}) \}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{mem}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{memory}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~{\mathit{mt}}{:}{{\mathtt{memtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{memory}~{\mathit{mt}}, \{ \mathsf{mems}~({{\mathit{id}}^?}) \}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{table}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{table}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~{\mathit{tt}}{:}{{\mathtt{tabletype}}}_{I}~~e{:}{{\mathtt{expr}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{table}~{\mathit{tt}}~e, \{ \mathsf{tables}~({{\mathit{id}}^?}) \}) \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{table}\mbox{’}~~{{\mathtt{id}}^?}~~{\mathit{tt}}{:}{{\mathtt{tabletype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\equiv\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{table}\mbox{’}~~{{\mathtt{id}}^?}~~{\mathit{tt}}{:}{{\mathtt{tabletype}}}_{I}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{ref.null}\mbox{’}~~{\mathit{ht}}{:}{{\mathtt{heaptype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad \mbox{if}~ {\mathit{tt}} = {\mathit{at}}~{\mathit{lim}}~(\mathsf{ref}~{\mathsf{null}^?}~{\mathit{ht}}) \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{func}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{func}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~(x, I_1){:}{{\mathtt{typeuse}}}_{I}~~{(({{\mathit{loc}}^\ast}, I_2){:}{{\mathtt{local}}}_{I})^\ast}~~e{:}{{\mathtt{expr}}}_{{I'}}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{func}~x~{\bigoplus}\, {{{\mathit{loc}}^\ast}^\ast}~e, \{ \mathsf{funcs}~({{\mathit{id}}^?}) \}) & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {I'} = I \oplus I_1 \oplus {\mathrm{concat}}_{\mathit{idctxt}}({I_2^\ast}) \\
{\land}~ {\vdash}\, {I'} : \mathsf{ok} \\
\end{array} \\
& {{\mathtt{local}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{local}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~t{:}{{\mathtt{valtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{local}~t, \{ \mathsf{locals}~({{\mathit{id}}^?}) \}) \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{local}\mbox{’}~~t{:}{{{\mathtt{valtype}}}_{I}^\ast}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\equiv\quad{} & {(\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{local}\mbox{’}~~t{:}{{\mathtt{valtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’})^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{data}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{data}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~{b^\ast}{:}{\mathtt{datastring}}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{data}~{b^\ast}~\mathsf{passive}, \{ \mathsf{datas}~({{\mathit{id}}^?}) \}) \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{data}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~{b^\ast}{:}{\mathtt{datastring}}~~x{:}{{\mathtt{memuse}}}_{I}~~e{:}{{\mathtt{offset}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{data}~{b^\ast}~(\mathsf{active}~x~e), \{ \mathsf{datas}~({{\mathit{id}}^?}) \}) \\
& {\mathtt{datastring}} & ::= & {{b^\ast}^\ast}{:}{{\mathtt{string}}^\ast} & \quad\Rightarrow\quad{} & {\bigoplus}\, {{b^\ast}^\ast} \\
& {{\mathtt{memuse}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{memory}\mbox{’}~~x{:}{{\mathtt{memidx}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & x \\
& & | & \epsilon & \quad\Rightarrow\quad{} & 0 \\
& {{\mathtt{offset}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{offset}\mbox{’}~~e{:}{{\mathtt{expr}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & e \\
& & | & {{\mathtt{foldedinstr}}}_{I} & \quad\equiv\quad{} & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{offset}\mbox{’}~~{{\mathtt{foldedinstr}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{elem}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{elem}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~({\mathit{rt}}, {e^\ast}){:}{{\mathtt{elemlist}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{elem}~{\mathit{rt}}~{e^\ast}~\mathsf{passive}, \{ \mathsf{elems}~({{\mathit{id}}^?}) \}) \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{elem}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~({\mathit{rt}}, {e^\ast}){:}{{\mathtt{elemlist}}}_{I}~~x{:}{{\mathtt{tableuse}}}_{I}~~{e'}{:}{{\mathtt{offset}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{elem}~{\mathit{rt}}~{e^\ast}~(\mathsf{active}~x~{e'}), \{ \mathsf{elems}~({{\mathit{id}}^?}) \}) \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{elem}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~\mbox{‘}\mathtt{declare}\mbox{’}~~({\mathit{rt}}, {e^\ast}){:}{{\mathtt{elemlist}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{elem}~{\mathit{rt}}~{e^\ast}~\mathsf{declare}, \{ \mathsf{elems}~({{\mathit{id}}^?}) \}) \\
& {{\mathtt{elemlist}}}_{I} & ::= & {\mathit{rt}}{:}{{\mathtt{reftype}}}_{I}~~{e^\ast}{:}{\mathtt{list}}({{\mathtt{expr}}}_{I}) & \quad\Rightarrow\quad{} & ({\mathit{rt}}, {e^\ast}) \\
& & | & \mbox{‘}\mathtt{func}\mbox{’}~~{x^\ast}{:}{{{\mathtt{funcidx}}}_{I}^\ast} & \quad\equiv\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{ref}\mbox{’}~~\mbox{‘}\mathtt{func}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’}~~{(\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{ref.func}\mbox{’}~~{{\mathtt{funcidx}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’})^\ast} \\
\end{array}
} \\
& {{\mathtt{elemexpr}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{item}\mbox{’}~~e{:}{{\mathtt{expr}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & e \\
& & | & {{\mathtt{foldedinstr}}}_{I} & \quad\equiv\quad{} & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{item}\mbox{’}~~{{\mathtt{foldedinstr}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} \\
& {{\mathtt{tableuse}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{table}\mbox{’}~~x{:}{{\mathtt{tableidx}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & x \\
& & | & \epsilon & \quad\Rightarrow\quad{} & 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{start}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{start}\mbox{’}~~x{:}{{\mathtt{funcidx}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{start}~x, \{  \}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{import}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{import}\mbox{’}~~{\mathit{nm}}_1{:}{\mathtt{name}}~~{\mathit{nm}}_2{:}{\mathtt{name}}~~({\mathit{xt}}, {I'}){:}{{\mathtt{externtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{import}~{\mathit{nm}}_1~{\mathit{nm}}_2~{\mathit{xt}}, {I'}) \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{tag}\mbox{’}~~{{\mathtt{id}}^?}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{import}\mbox{’}~~{{\mathtt{name}}^{2}}~~\mbox{‘}\mathtt{)}\mbox{’}~~{{\mathtt{tagtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\equiv\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{import}\mbox{’}~~{{\mathtt{name}}^{2}}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{tag}\mbox{’}~~{{\mathtt{id}}^?}~~{{\mathtt{tagtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \\
\end{array}
} \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{global}\mbox{’}~~{{\mathtt{id}}^?}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{import}\mbox{’}~~{{\mathtt{name}}^{2}}~~\mbox{‘}\mathtt{)}\mbox{’}~~{{\mathtt{globaltype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\equiv\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{import}\mbox{’}~~{{\mathtt{name}}^{2}}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{global}\mbox{’}~~{{\mathtt{id}}^?}~~{{\mathtt{globaltype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \\
\end{array}
} \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{memory}\mbox{’}~~{{\mathtt{id}}^?}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{import}\mbox{’}~~{{\mathtt{name}}^{2}}~~\mbox{‘}\mathtt{)}\mbox{’}~~{{\mathtt{memtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\equiv\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{import}\mbox{’}~~{{\mathtt{name}}^{2}}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{memory}\mbox{’}~~{{\mathtt{id}}^?}~~{{\mathtt{memtype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \\
\end{array}
} \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{table}\mbox{’}~~{{\mathtt{id}}^?}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{import}\mbox{’}~~{{\mathtt{name}}^{2}}~~\mbox{‘}\mathtt{)}\mbox{’}~~{{\mathtt{tabletype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\equiv\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{import}\mbox{’}~~{{\mathtt{name}}^{2}}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{table}\mbox{’}~~{{\mathtt{id}}^?}~~{{\mathtt{tabletype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \\
\end{array}
} \\
& & | & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{func}\mbox{’}~~{{\mathtt{id}}^?}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{import}\mbox{’}~~{{\mathtt{name}}^{2}}~~\mbox{‘}\mathtt{)}\mbox{’}~~{{\mathtt{typeuse}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\equiv\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{import}\mbox{’}~~{{\mathtt{name}}^{2}}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{func}\mbox{’}~~{{\mathtt{id}}^?}~~{{\mathtt{typeuse}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{export}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{export}\mbox{’}~~{\mathit{nm}}{:}{\mathtt{name}}~~{\mathit{xx}}{:}{{\mathtt{externidx}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & (\mathsf{export}~{\mathit{nm}}~{\mathit{xx}}, \{  \}) \\
& {\mathtt{exportdots}} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{export}\mbox{’}~~{\mathtt{name}}~~\mbox{‘}\mathtt{)}\mbox{’} \\
& {\mathtt{importdots}} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{import}\mbox{’}~~{\mathtt{name}}~~{\mathtt{name}}~~\mbox{‘}\mathtt{)}\mbox{’} \\
& \ldots & ::= & {{\mathtt{exportdots}}^\ast}~~{{\mathtt{tagtype}}}_{I} \\
& & | & {{\mathtt{exportdots}}^\ast}~~{\mathtt{importdots}}~~{{\mathtt{tagtype}}}_{I} \\
& \ldots & ::= & {{\mathtt{exportdots}}^\ast}~~{{\mathtt{globaltype}}}_{I}~~{{\mathtt{expr}}}_{I} \\
& & | & {{\mathtt{exportdots}}^\ast}~~{\mathtt{importdots}}~~{{\mathtt{globaltype}}}_{I} \\
& \ldots & ::= & {{\mathtt{exportdots}}^\ast}~~{{\mathtt{memtype}}}_{I} \\
& & | & {{\mathtt{exportdots}}^\ast}~~{{\mathtt{addrtype}}^?}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{data}\mbox{’}~~{\mathtt{datastring}}~~\mbox{‘}\mathtt{)}\mbox{’} \\
& & | & {{\mathtt{exportdots}}^\ast}~~{\mathtt{importdots}}~~{{\mathtt{memtype}}}_{I} \\
& \ldots & ::= & {{\mathtt{exportdots}}^\ast}~~{{\mathtt{tabletype}}}_{I}~~{{{\mathtt{expr}}}_{I}^?} \\
& & | & {{\mathtt{exportdots}}^\ast}~~{{\mathtt{addrtype}}^?}~~{{\mathtt{reftype}}}_{I}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{elem}\mbox{’}~~{{\mathtt{elemlist}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} \\
& & | & {{\mathtt{exportdots}}^\ast}~~{\mathtt{importdots}}~~{{\mathtt{tabletype}}}_{I} \\
& \ldots & ::= & {{\mathtt{exportdots}}^\ast}~~{{\mathtt{typeuse}}}_{I}~~{{{\mathtt{local}}}_{I}^\ast}~~{{\mathtt{expr}}}_{I} \\
& & | & {{\mathtt{exportdots}}^\ast}~~{\mathtt{importdots}}~~{{\mathtt{typeuse}}}_{I} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{exporttag}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{tag}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{export}\mbox{’}~~{\mathtt{name}}~~\mbox{‘}\mathtt{)}\mbox{’}~~\ldots~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\equiv\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{tag}\mbox{’}~~{\mathit{id}'}{:}{\mathtt{id}}~~\ldots~~\mbox{‘}\mathtt{)}\mbox{’} \\
  \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{export}\mbox{’}~~{\mathtt{name}}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{tag}\mbox{’}~~{\mathtt{id}}~~\mbox{‘}\mathtt{)}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \end{array} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad \mbox{if}~ {{\mathit{id}}^?} = {\mathit{id}'} \lor {{\mathit{id}}^?} = \epsilon \land {\neg({\mathit{id}'} \in I{.}\mathsf{tags})} \\
\end{array}
} \\
\end{array}
} \\
& {{\mathtt{exportglobal}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{global}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{export}\mbox{’}~~{\mathtt{name}}~~\mbox{‘}\mathtt{)}\mbox{’}~~\ldots~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\equiv\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{global}\mbox{’}~~{\mathit{id}'}{:}{\mathtt{id}}~~\ldots~~\mbox{‘}\mathtt{)}\mbox{’} \\
  \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{export}\mbox{’}~~{\mathtt{name}}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{global}\mbox{’}~~{\mathtt{id}}~~\mbox{‘}\mathtt{)}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \end{array} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad \mbox{if}~ {{\mathit{id}}^?} = {\mathit{id}'} \lor {{\mathit{id}}^?} = \epsilon \land {\neg({\mathit{id}'} \in I{.}\mathsf{globals})} \\
\end{array}
} \\
\end{array}
} \\
& {{\mathtt{exportmemory}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{memory}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{export}\mbox{’}~~{\mathtt{name}}~~\mbox{‘}\mathtt{)}\mbox{’}~~\ldots~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\equiv\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{memory}\mbox{’}~~{\mathit{id}'}{:}{\mathtt{id}}~~\ldots~~\mbox{‘}\mathtt{)}\mbox{’} \\
  \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{export}\mbox{’}~~{\mathtt{name}}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{memory}\mbox{’}~~{\mathtt{id}}~~\mbox{‘}\mathtt{)}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \end{array} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad \mbox{if}~ {{\mathit{id}}^?} = {\mathit{id}'} \lor {{\mathit{id}}^?} = \epsilon \land {\neg({\mathit{id}'} \in I{.}\mathsf{mems})} \\
\end{array}
} \\
\end{array}
} \\
& {{\mathtt{exporttable}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{table}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{export}\mbox{’}~~{\mathtt{name}}~~\mbox{‘}\mathtt{)}\mbox{’}~~\ldots~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\equiv\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{table}\mbox{’}~~{\mathit{id}'}{:}{\mathtt{id}}~~\ldots~~\mbox{‘}\mathtt{)}\mbox{’} \\
  \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{export}\mbox{’}~~{\mathtt{name}}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{table}\mbox{’}~~{\mathtt{id}}~~\mbox{‘}\mathtt{)}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \end{array} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad \mbox{if}~ {{\mathit{id}}^?} = {\mathit{id}'} \lor {{\mathit{id}}^?} = \epsilon \land {\neg({\mathit{id}'} \in I{.}\mathsf{tables})} \\
\end{array}
} \\
\end{array}
} \\
& {{\mathtt{exportfunc}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{func}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{export}\mbox{’}~~{\mathtt{name}}~~\mbox{‘}\mathtt{)}\mbox{’}~~\ldots~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\equiv\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{func}\mbox{’}~~{\mathit{id}'}{:}{\mathtt{id}}~~\ldots~~\mbox{‘}\mathtt{)}\mbox{’} \\
  \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{export}\mbox{’}~~{\mathtt{name}}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{func}\mbox{’}~~{\mathtt{id}}~~\mbox{‘}\mathtt{)}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} \end{array} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad \mbox{if}~ {{\mathit{id}}^?} = {\mathit{id}'} \lor {{\mathit{id}}^?} = \epsilon \land {\neg({\mathit{id}'} \in I{.}\mathsf{funcs})} \\
\end{array}
} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{datamemory}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{memory}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~{{\mathit{at}}^?}{:}{{\mathtt{addrtype}}^?}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{data}\mbox{’}~~{b^\ast}{:}{\mathtt{datastring}}~~\mbox{‘}\mathtt{)}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\equiv\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{memory}\mbox{’}~~{\mathit{id}'}{:}{\mathtt{id}}~~{{\mathit{at}}^?}{:}{{\mathtt{addrtype}}^?}~~n{:}{\mathtt{u64}}~~n{:}{\mathtt{u64}}~~\mbox{‘}\mathtt{)}\mbox{’} \\
  \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{data}\mbox{’}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{memory}\mbox{’}~~{\mathit{id}'}{:}{\mathtt{id}}~~\mbox{‘}\mathtt{)}\mbox{’}~~\mbox{‘}\mathtt{(}\mbox{’}~~{\mathit{at}'}{:}{\mathtt{addrtype}}~~\mbox{‘}\mathtt{.const}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’}~~{\mathtt{datastring}}~~\mbox{‘}\mathtt{)}\mbox{’} \end{array} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {{\mathit{id}}^?} = {\mathit{id}'} \lor {{\mathit{id}}^?} = \epsilon \land {\neg({\mathit{id}'} \in I{.}\mathsf{mems})} \\
{\land}~ {{\mathit{at}}^?} = {\mathit{at}'} \lor {{\mathit{at}}^?} = \epsilon \land {\mathit{at}'} = \mathsf{i{\scriptstyle 32}} \\
{\land}~ n = {\mathrm{ceilz}}({|{b^\ast}|} / 64 \cdot {\mathrm{Ki}}) \\
\end{array} \\
\end{array}
} \\
\end{array}
} \\
& {{\mathtt{elemtable}}}_{I} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{table}\mbox{’}~~{{\mathit{id}}^?}{:}{{\mathtt{id}}^?}~~{{\mathit{at}}^?}{:}{{\mathtt{addrtype}}^?}~~{{\mathtt{reftype}}}_{I}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{elem}\mbox{’}~~({\mathit{rt}}, {e^\ast}){:}{{\mathtt{elemlist}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\equiv\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}l@{}}
\begin{array}[t]{@{}l@{}} \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{table}\mbox{’}~~{\mathit{id}'}{:}{\mathtt{id}}~~{{\mathit{at}}^?}{:}{{\mathtt{addrtype}}^?}~~n{:}{\mathtt{u64}}~~n{:}{\mathtt{u64}}~~{{\mathtt{reftype}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} \\
  \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{elem}\mbox{’}~~\mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{table}\mbox{’}~~{\mathit{id}'}{:}{\mathtt{id}}~~\mbox{‘}\mathtt{)}\mbox{’}~~\mbox{‘}\mathtt{(}\mbox{’}~~{\mathit{at}'}{:}{\mathtt{addrtype}}~~\mbox{‘}\mathtt{.const}\mbox{’}~~\mbox{‘}\mathtt{0}\mbox{’}~~\mbox{‘}\mathtt{)}\mbox{’}~~{{\mathtt{elemlist}}}_{I}~~\mbox{‘}\mathtt{)}\mbox{’} \end{array} & & \\
 \multicolumn{3}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
\quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {{\mathit{id}}^?} = {\mathit{id}'} \lor {{\mathit{id}}^?} = \epsilon \land {\neg({\mathit{id}'} \in I{.}\mathsf{tables})} \\
{\land}~ {{\mathit{at}}^?} = {\mathit{at}'} \lor {{\mathit{at}}^?} = \epsilon \land {\mathit{at}'} = \mathsf{i{\scriptstyle 32}} \\
{\land}~ n = {|{e^\ast}|} \\
\end{array} \\
\end{array}
} \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{decl}} & ::= & {\mathit{type}} ~~|~~ {\mathit{import}} ~~|~~ {\mathit{tag}} ~~|~~ {\mathit{global}} ~~|~~ {\mathit{mem}} ~~|~~ {\mathit{table}} ~~|~~ {\mathit{func}} ~~|~~ {\mathit{data}} ~~|~~ {\mathit{elem}} ~~|~~ {\mathit{start}} ~~|~~ {\mathit{export}} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{types}}(\epsilon) & = & \epsilon \\
{\mathrm{types}}({\mathit{type}}~{{\mathit{decl}'}^\ast}) & = & {\mathit{type}}~{\mathrm{types}}({{\mathit{decl}'}^\ast}) \\
{\mathrm{types}}({\mathit{decl}}~{{\mathit{decl}'}^\ast}) & = & {\mathrm{types}}({{\mathit{decl}'}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{imports}}(\epsilon) & = & \epsilon \\
{\mathrm{imports}}({\mathit{import}}~{{\mathit{decl}'}^\ast}) & = & {\mathit{import}}~{\mathrm{imports}}({{\mathit{decl}'}^\ast}) \\
{\mathrm{imports}}({\mathit{decl}}~{{\mathit{decl}'}^\ast}) & = & {\mathrm{imports}}({{\mathit{decl}'}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{tags}}(\epsilon) & = & \epsilon \\
{\mathrm{tags}}({\mathit{tag}}~{{\mathit{decl}'}^\ast}) & = & {\mathit{tag}}~{\mathrm{tags}}({{\mathit{decl}'}^\ast}) \\
{\mathrm{tags}}({\mathit{decl}}~{{\mathit{decl}'}^\ast}) & = & {\mathrm{tags}}({{\mathit{decl}'}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{globals}}(\epsilon) & = & \epsilon \\
{\mathrm{globals}}({\mathit{global}}~{{\mathit{decl}'}^\ast}) & = & {\mathit{global}}~{\mathrm{globals}}({{\mathit{decl}'}^\ast}) \\
{\mathrm{globals}}({\mathit{decl}}~{{\mathit{decl}'}^\ast}) & = & {\mathrm{globals}}({{\mathit{decl}'}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{mems}}(\epsilon) & = & \epsilon \\
{\mathrm{mems}}({\mathit{mem}}~{{\mathit{decl}'}^\ast}) & = & {\mathit{mem}}~{\mathrm{mems}}({{\mathit{decl}'}^\ast}) \\
{\mathrm{mems}}({\mathit{decl}}~{{\mathit{decl}'}^\ast}) & = & {\mathrm{mems}}({{\mathit{decl}'}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{tables}}(\epsilon) & = & \epsilon \\
{\mathrm{tables}}({\mathit{table}}~{{\mathit{decl}'}^\ast}) & = & {\mathit{table}}~{\mathrm{tables}}({{\mathit{decl}'}^\ast}) \\
{\mathrm{tables}}({\mathit{decl}}~{{\mathit{decl}'}^\ast}) & = & {\mathrm{tables}}({{\mathit{decl}'}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{funcs}}(\epsilon) & = & \epsilon \\
{\mathrm{funcs}}({\mathit{func}}~{{\mathit{decl}'}^\ast}) & = & {\mathit{func}}~{\mathrm{funcs}}({{\mathit{decl}'}^\ast}) \\
{\mathrm{funcs}}({\mathit{decl}}~{{\mathit{decl}'}^\ast}) & = & {\mathrm{funcs}}({{\mathit{decl}'}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{datas}}(\epsilon) & = & \epsilon \\
{\mathrm{datas}}({\mathit{data}}~{{\mathit{decl}'}^\ast}) & = & {\mathit{data}}~{\mathrm{datas}}({{\mathit{decl}'}^\ast}) \\
{\mathrm{datas}}({\mathit{decl}}~{{\mathit{decl}'}^\ast}) & = & {\mathrm{datas}}({{\mathit{decl}'}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{elems}}(\epsilon) & = & \epsilon \\
{\mathrm{elems}}({\mathit{elem}}~{{\mathit{decl}'}^\ast}) & = & {\mathit{elem}}~{\mathrm{elems}}({{\mathit{decl}'}^\ast}) \\
{\mathrm{elems}}({\mathit{decl}}~{{\mathit{decl}'}^\ast}) & = & {\mathrm{elems}}({{\mathit{decl}'}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{starts}}(\epsilon) & = & \epsilon \\
{\mathrm{starts}}({\mathit{start}}~{{\mathit{decl}'}^\ast}) & = & {\mathit{start}}~{\mathrm{starts}}({{\mathit{decl}'}^\ast}) \\
{\mathrm{starts}}({\mathit{decl}}~{{\mathit{decl}'}^\ast}) & = & {\mathrm{starts}}({{\mathit{decl}'}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{exports}}(\epsilon) & = & \epsilon \\
{\mathrm{exports}}({\mathit{export}}~{{\mathit{decl}'}^\ast}) & = & {\mathit{export}}~{\mathrm{exports}}({{\mathit{decl}'}^\ast}) \\
{\mathrm{exports}}({\mathit{decl}}~{{\mathit{decl}'}^\ast}) & = & {\mathrm{exports}}({{\mathit{decl}'}^\ast}) & \quad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{\mathrm{ordered}}(\epsilon) & = & \mathsf{true} \\
{\mathrm{ordered}}({{\mathit{decl}'}^\ast}) & = & ({\mathrm{imports}}({{\mathit{decl}'}^\ast}) = \epsilon) \\
{\mathrm{ordered}}({{\mathit{decl}}_1^\ast}~{\mathit{import}}~{{\mathit{decl}}_2^\ast}) & = & & \\
 \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}}
{\mathrm{imports}}({{\mathit{decl}}_1^\ast}) = \epsilon \land {\mathrm{tags}}({{\mathit{decl}}_1^\ast}) = \epsilon \land {\mathrm{globals}}({{\mathit{decl}}_1^\ast}) = \epsilon \land {\mathrm{mems}}({{\mathit{decl}}_1^\ast}) = \epsilon \land {\mathrm{tables}}({{\mathit{decl}}_1^\ast}) = \epsilon \land {\mathrm{funcs}}({{\mathit{decl}}_1^\ast}) = \epsilon \\
\end{array}
} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {{\mathtt{decl}}}_{I} & ::= & {{\mathtt{type}}}_{I} ~~|~~ {{\mathtt{import}}}_{I} ~~|~~ {{\mathtt{tag}}}_{I} ~~|~~ {{\mathtt{global}}}_{I} ~~|~~ {{\mathtt{mem}}}_{I} ~~|~~ {{\mathtt{table}}}_{I} ~~|~~ {{\mathtt{func}}}_{I} ~~|~~ {{\mathtt{data}}}_{I} ~~|~~ {{\mathtt{elem}}}_{I} ~~|~~ {{\mathtt{start}}}_{I} ~~|~~ {{\mathtt{export}}}_{I} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{module}} & ::= & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{module}\mbox{’}~~{{\mathtt{id}}^?}~~{({\mathit{decl}}, I)^\ast}{:}{{{\mathtt{decl}}}_{{I'}}^\ast}~~\mbox{‘}\mathtt{)}\mbox{’} & \quad\Rightarrow\quad{} & & \\
&&& \multicolumn{4}{@{}l@{}}{\quad
\begin{array}[t]{@{}l@{}l@{}}
\mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{tag}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast} & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ {I'} = {\mathrm{concat}}_{\mathit{idctxt}}({I^\ast}) \\
{\land}~ {\vdash}\, {I'} : \mathsf{ok} \\
{\land}~ {{\mathit{type}}^\ast} = {\mathrm{types}}({{\mathit{decl}}^\ast}) \\
{\land}~ {{\mathit{import}}^\ast} = {\mathrm{imports}}({{\mathit{decl}}^\ast}) \\
{\land}~ {{\mathit{tag}}^\ast} = {\mathrm{tags}}({{\mathit{decl}}^\ast}) \\
{\land}~ {{\mathit{global}}^\ast} = {\mathrm{globals}}({{\mathit{decl}}^\ast}) \\
{\land}~ {{\mathit{mem}}^\ast} = {\mathrm{mems}}({{\mathit{decl}}^\ast}) \\
{\land}~ {{\mathit{table}}^\ast} = {\mathrm{tables}}({{\mathit{decl}}^\ast}) \\
{\land}~ {{\mathit{func}}^\ast} = {\mathrm{funcs}}({{\mathit{decl}}^\ast}) \\
{\land}~ {{\mathit{data}}^\ast} = {\mathrm{datas}}({{\mathit{decl}}^\ast}) \\
{\land}~ {{\mathit{elem}}^\ast} = {\mathrm{elems}}({{\mathit{decl}}^\ast}) \\
{\land}~ {{\mathit{start}}^?} = {\mathrm{starts}}({{\mathit{decl}}^\ast}) \\
{\land}~ {{\mathit{export}}^\ast} = {\mathrm{exports}}({{\mathit{decl}}^\ast}) \\
{\land}~ {\mathrm{ordered}}({{\mathit{decl}}^\ast}) \\
\end{array} \\
\end{array}
} \\
& & | & {{{\mathtt{decl}}}_{I}^\ast} & \quad\equiv\quad{} & \mbox{‘}\mathtt{(}\mbox{’}~~\mbox{‘}\mathtt{module}\mbox{’}~~{{{\mathtt{decl}}}_{I}^\ast}~~\mbox{‘}\mathtt{)}\mbox{’} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& A & ::= & 0 ~~|~~ 1 ~~|~~ 2 ~~|~~ \dots \\
& B & ::= & 0 ~~|~~ 1 ~~|~~ 2 ~~|~~ \dots \\
& {\mathit{sym}} & ::= & A_1 ~~|~~ \ldots ~~|~~ A_n \\
& {\mathit{sym}} & ::= & A_1 ~~|~~ A_2 \\
& & ::= & () \\
& r & ::= & \{ \begin{array}[t]{@{}l@{}l@{}}
{\mathsf{field}}_{1}~A_1 ,  {\mathsf{field}}_{2}~A_2 ,  \ldots~ \} \\
\end{array} \\
& {\mathit{pth}} & ::= & {({}[ i ]~\mid~{.}\mathsf{field})^{+}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& T & ::= & 0 ~~|~~ 1 ~~|~~ 2 ~~|~~ \dots \\
\end{array}
$$

$\boxed{\mathbb{N}}$

$\boxed{\ldots}$

$\boxed{\mathbb{N}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{premise}}_1
 \qquad
{\mathit{premise}}_2
 \qquad
\ldots
 \qquad
{\mathit{premise}}_n
}{
{\mathit{conclusion}}
} \, {[\textsc{\scriptsize NotationTypingScheme}]}
\qquad
\end{array}
$$

$\boxed{{\mathit{context}} \vdash {{\mathit{instr}}^\ast} : {\mathit{instrtype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{i{\scriptstyle 32}} {.} \mathsf{add} : \mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}} \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize NotationTypingInstrScheme{-}i32.add}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{globals}{}[x] = \mathsf{mut}~t
}{
C \vdash \mathsf{global{.}get}~x : \epsilon \rightarrow t
} \, {[\textsc{\scriptsize NotationTypingInstrScheme{-}global.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{blocktype}} : {t_1^\ast} \rightarrow {t_2^\ast}
 \qquad
\{ \mathsf{labels}~({t_2^\ast}) \} \oplus C \vdash {{\mathit{instr}}^\ast} : {t_1^\ast} \rightarrow {t_2^\ast}
}{
C \vdash \mathsf{block}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast} : {t_1^\ast} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize NotationTypingInstrScheme{-}block}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\hookrightarrow}\, {{\mathit{instr}}^\ast}}$

$$
\begin{array}[t]{@{}lrcl@{}l@{}}
{[\textsc{\scriptsize NotationReduct{-}2}]} \quad & & \hookrightarrow & (\mathsf{f{\scriptstyle 64}}{.}\mathsf{const}~q_1)~(\mathsf{f{\scriptstyle 64}}{.}\mathsf{const}~q_4)~(\mathsf{f{\scriptstyle 64}}{.}\mathsf{const}~q_3)~(\mathsf{f{\scriptstyle 64}} {.} \mathsf{add})~(\mathsf{f{\scriptstyle 64}} {.} \mathsf{mul}) \\
{[\textsc{\scriptsize NotationReduct{-}3}]} \quad & & \hookrightarrow & (\mathsf{f{\scriptstyle 64}}{.}\mathsf{const}~q_1)~(\mathsf{f{\scriptstyle 64}}{.}\mathsf{const}~q_5)~(\mathsf{f{\scriptstyle 64}} {.} \mathsf{mul}) \\
{[\textsc{\scriptsize NotationReduct{-}4}]} \quad & & \hookrightarrow & (\mathsf{f{\scriptstyle 64}}{.}\mathsf{const}~q_6) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
\mbox{(label)} & {\mathit{label}} & ::= & {{\mathsf{label}}_{n}}{\{ {{\mathit{instr}}^\ast} \}} \\
\mbox{(call frame)} & {\mathit{callframe}} & ::= & {{\mathsf{frame}}_{n}}{\{ {\mathit{frame}} \}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lcl@{}l@{}}
{{{\mathrm{allocX}}^\ast}}{(s, \epsilon, \epsilon)} & = & (s, \epsilon) \\
{{{\mathrm{allocX}}^\ast}}{(s, X~{{X'}^\ast}, Y~{{Y'}^\ast})} & = & (s_2, a~{{a'}^\ast}) & \quad
\begin{array}[t]{@{}l@{}}
\mbox{if}~ (s_1, a) = {\mathrm{allocX}}(X, Y, s, X, Y) \\
{\land}~ (s_2, {{a'}^\ast}) = {{{\mathrm{allocX}}^\ast}}{(s_1, {{X'}^\ast}, {{Y'}^\ast})} \\
\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& \ldots & ::= & 0 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lcl@{}l@{}}
X & = & \mathtt{0x00} \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& X & ::= & \mathtt{0x00} \\
& {\mathtt{sym}} & ::= & B_1 ~\Rightarrow~ A_1 ~~|~~ \ldots ~~|~~ B_n ~\Rightarrow~ A_n \\
& {\mathtt{sym}} & ::= & B_1 ~~|~~ B_2 \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& X & ::= & \mathtt{0x00} \\
& {\mathtt{sym}} & ::= & T_1 ~\Rightarrow~ A_1 ~~|~~ \ldots ~~|~~ T_n ~\Rightarrow~ A_n \\
& {\mathtt{sym}} & ::= & B_1 ~~|~~ B_2 \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}}
& {\mathit{abbreviated}} & ::= & () \\
& {\mathit{expanded}} & ::= & () \\
& {\mathit{syntax}} & ::= & () \\
\end{array}
$$

$$
\begin{array}[t]{@{}lrrl@{}l@{}l@{}l@{}}
& {\mathtt{sym}} & ::= & {\mathit{abbreviated}}~~{\mathit{syntax}} & \quad\equiv\quad{} & {\mathit{expanded}}~~{\mathit{syntax}} \\
\end{array}
$$


```

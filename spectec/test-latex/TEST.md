# Test

```sh
$ (../src/exe-watsup/main.exe test.watsup --latex)
$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{test}}_{{\mathit{sub}}_{{\mathsf{atom}}_{22}}}(n_{1_{{\mathit{xyz}}_y}}) &=& 0 \\
{\mathrm{test}}_{{\mathit{sub}}_{{\mathsf{atom}}_{22}}}(n_{2_{{\mathsf{xyz}}_y}}) &=& 0 \\
{\mathrm{test}}_{{\mathit{sub}}_{{\mathsf{atom}}_{22}}}(n_{3_{{\mathsf{atom}}_y}}) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{curried}}}_{n_1}(n_2) &=& n_1 + n_2 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{testfuse}} &::=& {\mathsf{ab}}_{\mathbb{N}}\,\mathbb{N}~\mathbb{N} \\ &&|&
{\mathsf{cd}}_{\mathbb{N}}\,\mathbb{N}~\mathbb{N} \\ &&|&
{\mathsf{ef}}{\mathbb{N}}~\mathbb{N}~\mathbb{N} \\ &&|&
{{\mathsf{gh}}_{\mathbb{N}}}{\mathbb{N}}~\mathbb{N} \\ &&|&
{{\mathsf{ij}}{\mathsf{\_}}~\mathbb{N}}{\mathsf{ab}}{\mathbb{N}}~\mathbb{N} \\ &&|&
{\mathsf{kl\_ab}}{\mathbb{N}}~\mathbb{N}~\mathbb{N} \\ &&|&
{\mathsf{mn}}{\mathsf{ab}}~\mathbb{N}~\mathbb{N}~\mathbb{N} \\ &&|&
{\mathsf{op}}{\mathsf{ab}}{\mathbb{N}}~\mathbb{N}~\mathbb{N} \\ &&|&
{{\mathsf{qr}}_{\mathbb{N}}}{\mathsf{ab}}~\mathbb{N}~\mathbb{N} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{InfixArrow}} &::=& {\mathbb{N}^\ast} \rightarrow_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\mathit{InfixArrow{\kern-0.1em\scriptstyle 2}}} &::=& {\mathbb{N}^\ast} \Rightarrow_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\mathit{AtomArrow}} &::=& {\mathbb{N}^?}~{\rightarrow}_{{\mathbb{N}^\ast}}\,{\mathbb{N}^\ast} \\
& {\mathit{AtomArrow{\kern-0.1em\scriptstyle 2}}} &::=& {\mathbb{N}^?}~{\Rightarrow}_{{\mathbb{N}^\ast}}\,{\mathbb{N}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{InfixArrow}}(a \rightarrow_{c} {}) &=& 0 \\
{\mathrm{InfixArrow}}(a \rightarrow_{c} b) &=& 0 \\
{\mathrm{InfixArrow}}(a \rightarrow_{{c^\ast}} b) &=& 0 \\
{\mathrm{InfixArrow}}(a \rightarrow_{c} b_1~b_2) &=& 0 \\
{\mathrm{InfixArrow}}(a \rightarrow_{{c^\ast}} b_1~b_2) &=& 0 \\
{\mathrm{InfixArrow}}(a \rightarrow_{c_1~c_2} b_1~b_2) &=& 0 \\
{\mathrm{InfixArrow}}({\rightarrow}_{c_1~c_2} b_1~b_2) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{InfixArrow{\kern-0.1em\scriptstyle 2}}}(a \Rightarrow_{c} {}) &=& 0 \\
{\mathrm{InfixArrow{\kern-0.1em\scriptstyle 2}}}(a \Rightarrow_{c} b) &=& 0 \\
{\mathrm{InfixArrow{\kern-0.1em\scriptstyle 2}}}(a \Rightarrow_{{c^\ast}} b) &=& 0 \\
{\mathrm{InfixArrow{\kern-0.1em\scriptstyle 2}}}(a \Rightarrow_{c} b_1~b_2) &=& 0 \\
{\mathrm{InfixArrow{\kern-0.1em\scriptstyle 2}}}(a \Rightarrow_{{c^\ast}} b_1~b_2) &=& 0 \\
{\mathrm{InfixArrow{\kern-0.1em\scriptstyle 2}}}(a \Rightarrow_{c_1~c_2} b_1~b_2) &=& 0 \\
{\mathrm{InfixArrow{\kern-0.1em\scriptstyle 2}}}({\Rightarrow}_{c_1~c_2} b_1~b_2) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{AtomArrow}}(a~{\rightarrow}_{c}) &=& 0 \\
{\mathrm{AtomArrow}}(a~{\rightarrow}_{c}\,b) &=& 0 \\
{\mathrm{AtomArrow}}(a~{\rightarrow}_{{c^\ast}}\,b) &=& 0 \\
{\mathrm{AtomArrow}}(a~{\rightarrow}_{c}\,b_1~b_2) &=& 0 \\
{\mathrm{AtomArrow}}(a~{\rightarrow}_{{c^\ast}}\,b_1~b_2) &=& 0 \\
{\mathrm{AtomArrow}}(a~{\rightarrow}_{c_1~c_2}\,b_1~b_2) &=& 0 \\
{\mathrm{AtomArrow}}({\rightarrow}_{c_1~c_2}\,b_1~b_2) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{AtomArrow{\kern-0.1em\scriptstyle 2}}}(a~{\Rightarrow}_{c}) &=& 0 \\
{\mathrm{AtomArrow{\kern-0.1em\scriptstyle 2}}}(a~{\Rightarrow}_{c}\,b) &=& 0 \\
{\mathrm{AtomArrow{\kern-0.1em\scriptstyle 2}}}(a~{\Rightarrow}_{{c^\ast}}\,b) &=& 0 \\
{\mathrm{AtomArrow{\kern-0.1em\scriptstyle 2}}}(a~{\Rightarrow}_{c}\,b_1~b_2) &=& 0 \\
{\mathrm{AtomArrow{\kern-0.1em\scriptstyle 2}}}(a~{\Rightarrow}_{{c^\ast}}\,b_1~b_2) &=& 0 \\
{\mathrm{AtomArrow{\kern-0.1em\scriptstyle 2}}}(a~{\Rightarrow}_{c_1~c_2}\,b_1~b_2) &=& 0 \\
{\mathrm{AtomArrow{\kern-0.1em\scriptstyle 2}}}({\Rightarrow}_{c_1~c_2}\,b_1~b_2) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{MacroInfixArrow}} &::=& {\mathbb{N}^\ast} \rightarrow_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\mathit{MacroAtomArrow}} &::=& {\mathbb{N}^\ast} \rightarrow_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{MacroInfixArrow}}(a \rightarrow_{c} {}) &=& 0 \\
{\mathrm{MacroInfixArrow}}(a \rightarrow_{c} b) &=& 0 \\
{\mathrm{MacroInfixArrow}}(a \rightarrow_{{c^\ast}} b) &=& 0 \\
{\mathrm{MacroInfixArrow}}(a \rightarrow_{c} b_1~b_2) &=& 0 \\
{\mathrm{MacroInfixArrow}}(a \rightarrow_{{c^\ast}} b_1~b_2) &=& 0 \\
{\mathrm{MacroInfixArrow}}(a \rightarrow_{c_1~c_2} b_1~b_2) &=& 0 \\
{\mathrm{MacroInfixArrow}}({\rightarrow}_{c_1~c_2} b_1~b_2) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{MacroAtomArrow}}(a \rightarrow_{c} {}) &=& 0 \\
{\mathrm{MacroAtomArrow}}(a \rightarrow_{c} b) &=& 0 \\
{\mathrm{MacroAtomArrow}}(a \rightarrow_{{c^\ast}} b) &=& 0 \\
{\mathrm{MacroAtomArrow}}(a \rightarrow_{c} b_1~b_2) &=& 0 \\
{\mathrm{MacroAtomArrow}}(a \rightarrow_{{c^\ast}} b_1~b_2) &=& 0 \\
{\mathrm{MacroAtomArrow}}(a \rightarrow_{c_1~c_2} b_1~b_2) &=& 0 \\
{\mathrm{MacroAtomArrow}}({\rightarrow}_{c_1~c_2} b_1~b_2) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{ShowInfixArrow}} &::=& {\mathbb{N}^\ast} \rightarrow_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\mathit{ShowAtomArrow}} &::=& {\mathbb{N}^\ast}~{\rightarrow}_{{\mathbb{N}^\ast}}\,{\mathbb{N}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{ShowInfixArrow}}(a \rightarrow_{c} ) &=& 0 \\
{\mathrm{ShowInfixArrow}}(a \rightarrow_{c} b) &=& 0 \\
{\mathrm{ShowInfixArrow}}(a \rightarrow_{({c^\ast})} b) &=& 0 \\
{\mathrm{ShowInfixArrow}}(a \rightarrow_{c} b_1~b_2) &=& 0 \\
{\mathrm{ShowInfixArrow}}(a \rightarrow_{({c^\ast})} b_1~b_2) &=& 0 \\
{\mathrm{ShowInfixArrow}}(a \rightarrow_{(c_1~c_2)} b_1~b_2) &=& 0 \\
{\mathrm{ShowInfixArrow}}({\rightarrow}_{(c_1~c_2)} b_1~b_2) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{ShowAtomArrow}}(a~{\rightarrow}_{c}) &=& 0 \\
{\mathrm{ShowAtomArrow}}(a~{\rightarrow}_{c}\,b) &=& 0 \\
{\mathrm{ShowAtomArrow}}(a~{\rightarrow}_{({c^\ast})}\,b) &=& 0 \\
{\mathrm{ShowAtomArrow}}(a~{\rightarrow}_{c}\,b_1~b_2) &=& 0 \\
{\mathrm{ShowAtomArrow}}(a~{\rightarrow}_{({c^\ast})}\,b_1~b_2) &=& 0 \\
{\mathrm{ShowAtomArrow}}(a~{\rightarrow}_{(c_1~c_2)}\,b_1~b_2) &=& 0 \\
{\mathrm{ShowAtomArrow}}({\rightarrow}_{(c_1~c_2)}\,b_1~b_2) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{ShowMacroInfixArrow}} &::=& {\mathbb{N}^\ast} \rightarrow_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\mathit{ShowMacroAtomArrow}} &::=& {\mathbb{N}^\ast}~{\rightarrow}_{{\mathbb{N}^\ast}}\,{\mathbb{N}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{ShowMacroInfixArrow}}(a \rightarrow_{c} ) &=& 0 \\
{\mathrm{ShowMacroInfixArrow}}(a \rightarrow_{c} b) &=& 0 \\
{\mathrm{ShowMacroInfixArrow}}(a \rightarrow_{({c^\ast})} b) &=& 0 \\
{\mathrm{ShowMacroInfixArrow}}(a \rightarrow_{c} b_1~b_2) &=& 0 \\
{\mathrm{ShowMacroInfixArrow}}(a \rightarrow_{({c^\ast})} b_1~b_2) &=& 0 \\
{\mathrm{ShowMacroInfixArrow}}(a \rightarrow_{(c_1~c_2)} b_1~b_2) &=& 0 \\
{\mathrm{ShowMacroInfixArrow}}({\rightarrow}_{(c_1~c_2)} b_1~b_2) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{ShowMacroAtomArrow}}(a~{\rightarrow}_{c}) &=& 0 \\
{\mathrm{ShowMacroAtomArrow}}(a~{\rightarrow}_{c}\,b) &=& 0 \\
{\mathrm{ShowMacroAtomArrow}}(a~{\rightarrow}_{({c^\ast})}\,b) &=& 0 \\
{\mathrm{ShowMacroAtomArrow}}(a~{\rightarrow}_{c}\,b_1~b_2) &=& 0 \\
{\mathrm{ShowMacroAtomArrow}}(a~{\rightarrow}_{({c^\ast})}\,b_1~b_2) &=& 0 \\
{\mathrm{ShowMacroAtomArrow}}(a~{\rightarrow}_{(c_1~c_2)}\,b_1~b_2) &=& 0 \\
{\mathrm{ShowMacroAtomArrow}}({\rightarrow}_{(c_1~c_2)}\,b_1~b_2) &=& 0 \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{fii}} &::=& \mathsf{fii} \\
& {\mathit{faa}} &::=& \mathsf{faa} \\
& {\mathit{foo}} &::=& \mathsf{foo} \\
& {\mathit{fuu}} &::=& \mathsf{fuu} \\
& {\mathit{foobar}} &::=& \mathsf{bar} \\
& {\mathit{fooboo}} &::=& \mathsf{boo} \\
& {\mathit{fob}} &::=& \mathsf{baz} \\
& {\mathit{fib}} &::=& \mathsf{boi} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{macros{\kern-0.1em\scriptstyle 1}}} &=& 0
  &\qquad \mbox{if}~{\mathit{fii}} = \mathsf{fii} \\
  &&&\qquad {\land}~{\mathit{faa}} = \mathsf{faa} \\
  &&&\qquad {\land}~{\mathit{foo}} = \mathsf{foo} \\
  &&&\qquad {\land}~{\mathit{fuu}} = \mathsf{fuu} \\
  &&&\qquad {\land}~{\mathit{foobar}} = \mathsf{bar} \\
  &&&\qquad {\land}~{\mathit{fooboo}} = \mathsf{boo} \\
  &&&\qquad {\land}~{\mathit{fob}} = \mathsf{baz} \\
  &&&\qquad {\land}~{\mathit{fib}} = \mathsf{boi} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{ufii}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2) &::=& \mathsf{ufii} \\
& {{\mathit{ufaa}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2) &::=& \mathsf{ufaa} \\
& {{\mathit{ufoo}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2) &::=& \mathsf{ufoo} \\
& {{\mathit{ufuu}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2) &::=& \mathsf{ufuu} \\
& {{\mathit{ufoobar}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2, z) &::=& \mathsf{ubar} \\
& {{\mathit{ufooboo}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2, z) &::=& \mathsf{uboo} \\
& {{\mathit{ufob}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2, z) &::=& \mathsf{ubaz} \\
& {{\mathit{ufib}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2, z) &::=& \mathsf{uboi} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{macros{\kern-0.1em\scriptstyle 2}}} &=& 0
  &\qquad \mbox{if}~{\mathit{ufii}} = \mathsf{ufii} \\
  &&&\qquad {\land}~{\mathit{ufaa}} = \mathsf{ufaa} \\
  &&&\qquad {\land}~{\mathit{ufoo}} = \mathsf{ufoo} \\
  &&&\qquad {\land}~{\mathit{ufuu}} = \mathsf{ufuu} \\
  &&&\qquad {\land}~{\mathit{ubar}} = \mathsf{ubar} \\
  &&&\qquad {\land}~{\mathit{uboo}} = \mathsf{uboo} \\
  &&&\qquad {\land}~{\mathit{ubaz}} = \mathsf{ubaz} \\
  &&&\qquad {\land}~{\mathit{uboi}} = \mathsf{uboi} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{fii}} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{faa}} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{foo}} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{fuu}} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{foobar}} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{fooboo}} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{fob}} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{fib}} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{ufii}}}_{x}(y) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{ufaa}}}_{x}(y) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{ufoo}}}_{x}(y) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{ufuu}}}_{x}(y) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{ufoobar}}}_{x}(y, z) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{ufooboo}}}_{x}(y, z) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{ufob}}}_{x}(y, z) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{ufib}}}_{x}(y, z) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{foo\_bar}} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{foo\_boo}} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{ufoo\_bar}}}_{x}(y) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{ufoo\_boo}}}_{x}(y, z) &=& 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{parent}} &::=& \mathsf{aa} \\ &&|&
\mathsf{aax} \\ &&|&
\mathsf{aay} \\ &&|&
\mathsf{aaz} \\ &&|&
\mathsf{bbb} \\ &&|&
\mathsf{bbbx} \\ &&|&
\mathsf{bbby} \\ &&|&
\mathsf{bbbz} \\ &&|&
\mathsf{cc}~\mathbb{N}~\mathsf{cccc} \\ &&|&
\mathsf{ccx}~\mathbb{N}~\mathsf{ccxx} \\ &&|&
\mathsf{ccy}~\mathbb{N}~\mathsf{ccyy} \\ &&|&
\mathsf{ccz}~\mathbb{N}~\mathsf{cczz} \\ &&|&
\mathsf{ddd}~\mathbb{N}~{\mathit{child}}~{\mathrm{foo}}~{\mathrm{fuu}}~{\mathrm{fiz}} \\ &&|&
\mathsf{dddx}~\mathbb{N}~{\mathit{child}} \\ &&|&
\mathsf{dddy}~\mathbb{N}~{\mathit{child}} \\ &&|&
\mathsf{dddz}~\mathbb{N}~{\mathit{child}} \\ &&|&
{\mathbb{N}}{\mathsf{\_}}{\mathsf{ea}}{\mathsf{ee}}~z \\ &&|&
{\mathbb{N}}{\mathsf{\_}}{\mathsf{eb}}{\mathsf{eex}}~z \\ &&|&
{\mathbb{N}}{\mathsf{\_}}{\mathsf{ec}}{\mathsf{eey}}~z \\ &&|&
{\mathbb{N}}{\mathsf{\_}}{\mathsf{ed}}{\mathsf{eez}}~z \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{parent}}(\mathsf{aa}) &=& 0 \\
{\mathrm{parent}}(\mathsf{aax}) &=& 0 \\
{\mathrm{parent}}(\mathsf{aay}) &=& 0 \\
{\mathrm{parent}}(\mathsf{aaz}) &=& 0 \\
{\mathrm{parent}}(\mathsf{bbb}) &=& 0 \\
{\mathrm{parent}}(\mathsf{bbbx}) &=& 0 \\
{\mathrm{parent}}(\mathsf{bbby}) &=& 0 \\
{\mathrm{parent}}(\mathsf{bbbz}) &=& 0 \\
{\mathrm{parent}}(\mathsf{cc}~n~\mathsf{cccc}) &=& 0 \\
{\mathrm{parent}}(\mathsf{ccx}~n~\mathsf{ccxx}) &=& 0 \\
{\mathrm{parent}}(\mathsf{ccy}~n~\mathsf{ccyy}) &=& 0 \\
{\mathrm{parent}}(\mathsf{ccz}~n~\mathsf{cczz}) &=& 0 \\
{\mathrm{parent}}(\mathsf{ddd}~n~{\mathit{child}}~{\mathrm{foo}}~{\mathrm{fuu}}~{\mathrm{fiz}}) &=& 0 \\
{\mathrm{parent}}(\mathsf{dddx}~n~{\mathit{child}}) &=& 0 \\
{\mathrm{parent}}(\mathsf{dddy}~n~{\mathit{child}}) &=& 0 \\
{\mathrm{parent}}(\mathsf{dddz}~n~{\mathit{child}}) &=& 0 \\
{\mathrm{parent}}({n}{\mathsf{\_}}{\mathsf{ea}}{\mathsf{ee}}~z) &=& 0 \\
{\mathrm{parent}}({n}{\mathsf{\_}}{\mathsf{eb}}{\mathsf{eex}}~z) &=& 0 \\
{\mathrm{parent}}({n}{\mathsf{\_}}{\mathsf{ec}}{\mathsf{eey}}~z) &=& 0 \\
{\mathrm{parent}}({n}{\mathsf{\_}}{\mathsf{ed}}{\mathsf{eez}}~z) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{parentimplicit}}(t) &::=& \mathsf{pp} \\ &&|&
\mathsf{ppx} \\ &&|&
\mathsf{ppy} \\ &&|&
\mathsf{ppz} \\ &&|&
\mathsf{qqq} \\ &&|&
\mathsf{qqqx} \\ &&|&
\mathsf{qqqy} \\ &&|&
\mathsf{qqqz} \\ &&|&
{t}{\mathsf{\_}}{\mathsf{ra}}{\mathsf{rr}}~z \\ &&|&
{t}{\mathsf{\_}}{\mathsf{rb}}{\mathsf{rrx}}~z \\ &&|&
{t}{\mathsf{\_}}{\mathsf{rc}}{\mathsf{rry}}~z \\ &&|&
{t}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{parentimpl}}(\mathsf{pp}) &=& 0 \\
{\mathrm{parentimpl}}(\mathsf{ppx}) &=& 0 \\
{\mathrm{parentimpl}}(\mathsf{ppy}) &=& 0 \\
{\mathrm{parentimpl}}(\mathsf{ppz}) &=& 0 \\
{\mathrm{parentimpl}}(\mathsf{qqq}) &=& 0 \\
{\mathrm{parentimpl}}(\mathsf{qqqx}) &=& 0 \\
{\mathrm{parentimpl}}(\mathsf{qqqy}) &=& 0 \\
{\mathrm{parentimpl}}(\mathsf{qqqz}) &=& 0 \\
{\mathrm{parentimpl}}({n}{\mathsf{\_}}{\mathsf{ra}}{\mathsf{rr}}~z) &=& 0 \\
{\mathrm{parentimpl}}({n}{\mathsf{\_}}{\mathsf{rb}}{\mathsf{rrx}}~z) &=& 0 \\
{\mathrm{parentimpl}}({n}{\mathsf{\_}}{\mathsf{rc}}{\mathsf{rry}}~z) &=& 0 \\
{\mathrm{parentimpl}}({n}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{indirect}} &::=& {\mathit{parentimplicit}}(\mathbb{N}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{indirect}}(\mathsf{pp}) &=& 0 \\
{\mathrm{indirect}}(\mathsf{ppx}) &=& 0 \\
{\mathrm{indirect}}(\mathsf{ppy}) &=& 0 \\
{\mathrm{indirect}}(\mathsf{ppz}) &=& 0 \\
{\mathrm{indirect}}(\mathsf{qqq}) &=& 0 \\
{\mathrm{indirect}}(\mathsf{qqqx}) &=& 0 \\
{\mathrm{indirect}}(\mathsf{qqqy}) &=& 0 \\
{\mathrm{indirect}}(\mathsf{qqqz}) &=& 0 \\
{\mathrm{indirect}}({n}{\mathsf{\_}}{\mathsf{ra}}{\mathsf{rr}}~z) &=& 0 \\
{\mathrm{indirect}}({n}{\mathsf{\_}}{\mathsf{rb}}{\mathsf{rrx}}~z) &=& 0 \\
{\mathrm{indirect}}({n}{\mathsf{\_}}{\mathsf{rc}}{\mathsf{rry}}~z) &=& 0 \\
{\mathrm{indirect}}({n}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{family}}(0) &::=& \mathsf{ff} \\
& {\mathit{family}}(1) &::=& \mathsf{gg} \\
& {\mathit{family}}(2) &::=& \mathsf{hh} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{family}}(0, \mathsf{ff}) &=& 0 \\
{\mathrm{family}}(1, \mathsf{gg}) &=& 0 \\
{\mathrm{family}}(2, \mathsf{hh}) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{child}} &::=& {\mathit{parent}} ~|~ {\mathit{family}}(0) ~|~ {\mathit{indirect}} ~|~ \mathsf{zzz} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{child}}(\mathsf{aa}) &=& 0 \\
{\mathrm{child}}(\mathsf{aax}) &=& 0 \\
{\mathrm{child}}(\mathsf{aay}) &=& 0 \\
{\mathrm{child}}(\mathsf{aaz}) &=& 0 \\
{\mathrm{child}}(\mathsf{bbb}) &=& 0 \\
{\mathrm{child}}(\mathsf{bbbx}) &=& 0 \\
{\mathrm{child}}(\mathsf{bbby}) &=& 0 \\
{\mathrm{child}}(\mathsf{bbbz}) &=& 0 \\
{\mathrm{child}}(\mathsf{cc}~n~\mathsf{cccc}) &=& 0 \\
{\mathrm{child}}(\mathsf{ccx}~n~\mathsf{ccxx}) &=& 0 \\
{\mathrm{child}}(\mathsf{ccy}~n~\mathsf{ccyy}) &=& 0 \\
{\mathrm{child}}(\mathsf{ccz}~n~\mathsf{cczz}) &=& 0 \\
{\mathrm{child}}(\mathsf{ddd}~n~{\mathit{child}}~{\mathrm{foo}}~{\mathrm{fuu}}~{\mathrm{fiz}}) &=& 0 \\
{\mathrm{child}}(\mathsf{dddx}~n~{\mathit{child}}) &=& 0 \\
{\mathrm{child}}(\mathsf{dddy}~n~{\mathit{child}}) &=& 0 \\
{\mathrm{child}}(\mathsf{dddz}~n~{\mathit{child}}) &=& 0 \\
{\mathrm{child}}({n}{\mathsf{\_}}{\mathsf{ea}}{\mathsf{ee}}~z) &=& 0 \\
{\mathrm{child}}({n}{\mathsf{\_}}{\mathsf{eb}}{\mathsf{eex}}~z) &=& 0 \\
{\mathrm{child}}({n}{\mathsf{\_}}{\mathsf{ec}}{\mathsf{eey}}~z) &=& 0 \\
{\mathrm{child}}({n}{\mathsf{\_}}{\mathsf{ed}}{\mathsf{eez}}~z) &=& 0 \\
{\mathrm{child}}(\mathsf{ff}) &=& 0 \\
{\mathrm{child}}(\mathsf{pp}) &=& 0 \\
{\mathrm{child}}(\mathsf{ppx}) &=& 0 \\
{\mathrm{child}}(\mathsf{ppy}) &=& 0 \\
{\mathrm{child}}(\mathsf{ppz}) &=& 0 \\
{\mathrm{child}}(\mathsf{qqq}) &=& 0 \\
{\mathrm{child}}(\mathsf{qqqx}) &=& 0 \\
{\mathrm{child}}(\mathsf{qqqy}) &=& 0 \\
{\mathrm{child}}(\mathsf{qqqz}) &=& 0 \\
{\mathrm{child}}({n}{\mathsf{\_}}{\mathsf{ra}}{\mathsf{rr}}~z) &=& 0 \\
{\mathrm{child}}({n}{\mathsf{\_}}{\mathsf{rb}}{\mathsf{rrx}}~z) &=& 0 \\
{\mathrm{child}}({n}{\mathsf{\_}}{\mathsf{rc}}{\mathsf{rry}}~z) &=& 0 \\
{\mathrm{child}}({n}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z) &=& 0 \\
{\mathrm{child}}(\mathsf{zzz}) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{grandchild}} &::=& {\mathit{child}} ~|~ \mathsf{zzzz} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{grandchild}}(\mathsf{aa}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{aax}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{aay}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{aaz}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{bbb}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{bbbx}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{bbby}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{bbbz}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{cc}~n~\mathsf{cccc}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{ccx}~n~\mathsf{ccxx}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{ccy}~n~\mathsf{ccyy}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{ccz}~n~\mathsf{cczz}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{ddd}~n~{\mathit{child}}~{\mathrm{foo}}~{\mathrm{fuu}}~{\mathrm{fiz}}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{dddx}~n~{\mathit{child}}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{dddy}~n~{\mathit{child}}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{dddz}~n~{\mathit{child}}) &=& 0 \\
{\mathrm{grandchild}}({n}{\mathsf{\_}}{\mathsf{ea}}{\mathsf{ee}}~z) &=& 0 \\
{\mathrm{grandchild}}({n}{\mathsf{\_}}{\mathsf{eb}}{\mathsf{eex}}~z) &=& 0 \\
{\mathrm{grandchild}}({n}{\mathsf{\_}}{\mathsf{ec}}{\mathsf{eey}}~z) &=& 0 \\
{\mathrm{grandchild}}({n}{\mathsf{\_}}{\mathsf{ed}}{\mathsf{eez}}~z) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{ff}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{pp}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{ppx}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{ppy}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{ppz}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{qqq}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{qqqx}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{qqqy}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{qqqz}) &=& 0 \\
{\mathrm{grandchild}}({n}{\mathsf{\_}}{\mathsf{ra}}{\mathsf{rr}}~z) &=& 0 \\
{\mathrm{grandchild}}({n}{\mathsf{\_}}{\mathsf{rb}}{\mathsf{rrx}}~z) &=& 0 \\
{\mathrm{grandchild}}({n}{\mathsf{\_}}{\mathsf{rc}}{\mathsf{rry}}~z) &=& 0 \\
{\mathrm{grandchild}}({n}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{zzz}) &=& 0 \\
{\mathrm{grandchild}}(\mathsf{zzzz}) &=& 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{rec}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{fa}~{\mathbb{N}^\ast},\; \\
  \mathsf{fb}~{\mathbb{N}^\ast},\; \\
  \mathsf{fc}~{\mathbb{N}^\ast},\; \\
  \mathsf{fd}~{\mathbb{N}^\ast},\; \\
  \mathsf{fee}~{\mathbb{N}^\ast},\; \\
  \mathsf{fff}~{\mathbb{N}^\ast},\; \\
  \mathsf{fgg}~{\mathbb{N}^\ast},\; \\
  \mathsf{fhh}~{\mathbb{N}^\ast} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{proj}}(r, 0) &=& r{.}\mathsf{fa} \\
{\mathrm{proj}}(r, 1) &=& r{.}\mathsf{fb} \\
{\mathrm{proj}}(r, 2) &=& r{.}\mathsf{fc} \\
{\mathrm{proj}}(r, 3) &=& r{.}\mathsf{fd} \\
{\mathrm{proj}}(r, 4) &=& r{.}\mathsf{fee} \\
{\mathrm{proj}}(r, 5) &=& r{.}\mathsf{fff} \\
{\mathrm{proj}}(r, 6) &=& r{.}\mathsf{fgg} \\
{\mathrm{proj}}(r, 7) &=& r{.}\mathsf{fhh} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{upd}}(r, 0) &=& r{}[{.}\mathsf{fa} = 0] \\
{\mathrm{upd}}(r, 1) &=& r{}[{.}\mathsf{fb} = 0] \\
{\mathrm{upd}}(r, 2) &=& r{}[{.}\mathsf{fc} = 0] \\
{\mathrm{upd}}(r, 3) &=& r{}[{.}\mathsf{fd} = 0] \\
{\mathrm{upd}}(r, 4) &=& r{}[{.}\mathsf{fee} = 0] \\
{\mathrm{upd}}(r, 5) &=& r{}[{.}\mathsf{fff} = 0] \\
{\mathrm{upd}}(r, 6) &=& r{}[{.}\mathsf{fgg} = 0] \\
{\mathrm{upd}}(r, 7) &=& r{}[{.}\mathsf{fhh} = 0] \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{ext}}(r, 0) &=& r{}[{.}\mathsf{fa} \mathrel{{=}{\oplus}} 0] \\
{\mathrm{ext}}(r, 1) &=& r{}[{.}\mathsf{fb} \mathrel{{=}{\oplus}} 0] \\
{\mathrm{ext}}(r, 2) &=& r{}[{.}\mathsf{fc} \mathrel{{=}{\oplus}} 0] \\
{\mathrm{ext}}(r, 3) &=& r{}[{.}\mathsf{fd} \mathrel{{=}{\oplus}} 0] \\
{\mathrm{ext}}(r, 4) &=& r{}[{.}\mathsf{fee} \mathrel{{=}{\oplus}} 0] \\
{\mathrm{ext}}(r, 5) &=& r{}[{.}\mathsf{fff} \mathrel{{=}{\oplus}} 0] \\
{\mathrm{ext}}(r, 6) &=& r{}[{.}\mathsf{fgg} \mathrel{{=}{\oplus}} 0] \\
{\mathrm{ext}}(r, 7) &=& r{}[{.}\mathsf{fhh} \mathrel{{=}{\oplus}} 0] \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{recimpl}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{fia}~{\mathbb{N}^\ast},\; \\
  \mathsf{fib}~{\mathbb{N}^\ast},\; \\
  \mathsf{fic}~{\mathbb{N}^\ast},\; \\
  \mathsf{fid}~{\mathbb{N}^\ast},\; \\
  \mathsf{fiee}~{\mathbb{N}^\ast},\; \\
  \mathsf{fiff}~{\mathbb{N}^\ast},\; \\
  \mathsf{figg}~{\mathbb{N}^\ast},\; \\
  \mathsf{fihh}~{\mathbb{N}^\ast} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{rproj}}(r, 0) &=& r{.}\mathsf{fia} \\
{\mathrm{rproj}}(r, 1) &=& r{.}\mathsf{fib} \\
{\mathrm{rproj}}(r, 2) &=& r{.}\mathsf{fic} \\
{\mathrm{rproj}}(r, 3) &=& r{.}\mathsf{fid} \\
{\mathrm{rproj}}(r, 4) &=& r{.}\mathsf{fiee} \\
{\mathrm{rproj}}(r, 5) &=& r{.}\mathsf{fiff} \\
{\mathrm{rproj}}(r, 6) &=& r{.}\mathsf{figg} \\
{\mathrm{rproj}}(r, 7) &=& r{.}\mathsf{fihh} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{cona}} &::=& \mathbb{N}~\mathsf{coa}~\mathbb{N} \\
& {\mathit{conb}} &::=& \mathbb{N}~\mathsf{cob}~\mathbb{N} \\
& {\mathit{conc}} &::=& \mathbb{N}~\mathsf{coc}~\mathbb{N} \\
& {\mathit{cond}} &::=& \mathbb{N}~\mathsf{cod}~\mathbb{N} \\
& {\mathit{cone}} &::=& \mathbb{N}~\mathsf{coe}~\mathbb{N} \\
& {\mathit{conf}} &::=& \mathbb{N}~\mathsf{cof}~\mathbb{N} \\
& {\mathit{cong}} &::=& \mathbb{N}~\mathsf{cog}~\mathbb{N} \\
& {\mathit{conh}} &::=& \mathbb{N}~\mathsf{coh}~\mathbb{N} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& C &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
 \}\end{array} \\
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
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize Reval}]} \quad & {\mathit{parent}} ; {\mathit{child}} &\hookrightarrow& \mathsf{aa} ; \mathsf{bbb} \\
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
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize Reval\_macro}]} \quad & {\mathit{parent}} ; {\mathit{child}} &\hookrightarrow& \mathsf{aa} ; \mathsf{bbb} \\
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
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize Reval\_nomacro}]} \quad & {\mathit{parent}} ; {\mathit{child}} &\hookrightarrow& \mathsf{aa} ; \mathsf{bbb} \\
\end{array}
$$


```

```sh
$ (../src/exe-watsup/main.exe test.watsup --latex --latex-macros)
$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{test}}_{{\mathit{sub}}_{{\mathsf{atom}}_{22}}}(n_{1_{{\mathit{xyz}}_y}}) &=& 0 \\
{\mathrm{test}}_{{\mathit{sub}}_{{\mathsf{atom}}_{22}}}(n_{2_{{\mathsf{xyz}}_y}}) &=& 0 \\
{\mathrm{test}}_{{\mathit{sub}}_{{\mathsf{atom}}_{22}}}(n_{3_{{\mathsf{atom}}_y}}) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\curried}}_{n_1}(n_2) &=& n_1 + n_2 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\testfuse} &::=& {\AB}_{\mathbb{N}}\,\mathbb{N}~\mathbb{N} \\ &&|&
{\CD}_{\mathbb{N}}\,\mathbb{N}~\mathbb{N} \\ &&|&
{\EF}{\mathbb{N}}~\mathbb{N}~\mathbb{N} \\ &&|&
{{\GH}_{\mathbb{N}}}{\mathbb{N}}~\mathbb{N} \\ &&|&
{{\IJ}{\mathsf{\_}}~\mathbb{N}}{\AB}{\mathbb{N}}~\mathbb{N} \\ &&|&
{\KLAB}{\mathbb{N}}~\mathbb{N}~\mathbb{N} \\ &&|&
{\MN}{\AB}~\mathbb{N}~\mathbb{N}~\mathbb{N} \\ &&|&
{\OP}{\AB}{\mathbb{N}}~\mathbb{N}~\mathbb{N} \\ &&|&
{{\QR}_{\mathbb{N}}}{\AB}~\mathbb{N}~\mathbb{N} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\InfixArrow} &::=& {\mathbb{N}^\ast} \rightarrow_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\InfixArrow2} &::=& {\mathbb{N}^\ast} \Rightarrow_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\AtomArrow} &::=& {\mathbb{N}^?}~{\rightarrow}_{{\mathbb{N}^\ast}}\,{\mathbb{N}^\ast} \\
& {\AtomArrow2} &::=& {\mathbb{N}^?}~{\Rightarrow}_{{\mathbb{N}^\ast}}\,{\mathbb{N}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\InfixArrow}(a \rightarrow_{c} {}) &=& 0 \\
{\InfixArrow}(a \rightarrow_{c} b) &=& 0 \\
{\InfixArrow}(a \rightarrow_{{c^\ast}} b) &=& 0 \\
{\InfixArrow}(a \rightarrow_{c} b_1~b_2) &=& 0 \\
{\InfixArrow}(a \rightarrow_{{c^\ast}} b_1~b_2) &=& 0 \\
{\InfixArrow}(a \rightarrow_{c_1~c_2} b_1~b_2) &=& 0 \\
{\InfixArrow}({\rightarrow}_{c_1~c_2} b_1~b_2) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\InfixArrow2}(a \Rightarrow_{c} {}) &=& 0 \\
{\InfixArrow2}(a \Rightarrow_{c} b) &=& 0 \\
{\InfixArrow2}(a \Rightarrow_{{c^\ast}} b) &=& 0 \\
{\InfixArrow2}(a \Rightarrow_{c} b_1~b_2) &=& 0 \\
{\InfixArrow2}(a \Rightarrow_{{c^\ast}} b_1~b_2) &=& 0 \\
{\InfixArrow2}(a \Rightarrow_{c_1~c_2} b_1~b_2) &=& 0 \\
{\InfixArrow2}({\Rightarrow}_{c_1~c_2} b_1~b_2) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\AtomArrow}(a~{\rightarrow}_{c}) &=& 0 \\
{\AtomArrow}(a~{\rightarrow}_{c}\,b) &=& 0 \\
{\AtomArrow}(a~{\rightarrow}_{{c^\ast}}\,b) &=& 0 \\
{\AtomArrow}(a~{\rightarrow}_{c}\,b_1~b_2) &=& 0 \\
{\AtomArrow}(a~{\rightarrow}_{{c^\ast}}\,b_1~b_2) &=& 0 \\
{\AtomArrow}(a~{\rightarrow}_{c_1~c_2}\,b_1~b_2) &=& 0 \\
{\AtomArrow}({\rightarrow}_{c_1~c_2}\,b_1~b_2) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\AtomArrow2}(a~{\Rightarrow}_{c}) &=& 0 \\
{\AtomArrow2}(a~{\Rightarrow}_{c}\,b) &=& 0 \\
{\AtomArrow2}(a~{\Rightarrow}_{{c^\ast}}\,b) &=& 0 \\
{\AtomArrow2}(a~{\Rightarrow}_{c}\,b_1~b_2) &=& 0 \\
{\AtomArrow2}(a~{\Rightarrow}_{{c^\ast}}\,b_1~b_2) &=& 0 \\
{\AtomArrow2}(a~{\Rightarrow}_{c_1~c_2}\,b_1~b_2) &=& 0 \\
{\AtomArrow2}({\Rightarrow}_{c_1~c_2}\,b_1~b_2) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\MacroInfixArrow} &::=& {\mathbb{N}^\ast} \to_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\MacroAtomArrow} &::=& {\mathbb{N}^\ast} \to_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\MacroInfixArrow}(a \to_{c} {}) &=& 0 \\
{\MacroInfixArrow}(a \to_{c} b) &=& 0 \\
{\MacroInfixArrow}(a \to_{{c^\ast}} b) &=& 0 \\
{\MacroInfixArrow}(a \to_{c} b_1~b_2) &=& 0 \\
{\MacroInfixArrow}(a \to_{{c^\ast}} b_1~b_2) &=& 0 \\
{\MacroInfixArrow}(a \to_{c_1~c_2} b_1~b_2) &=& 0 \\
{\MacroInfixArrow}({\to}_{c_1~c_2} b_1~b_2) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\MacroAtomArrow}(a \to_{c} {}) &=& 0 \\
{\MacroAtomArrow}(a \to_{c} b) &=& 0 \\
{\MacroAtomArrow}(a \to_{{c^\ast}} b) &=& 0 \\
{\MacroAtomArrow}(a \to_{c} b_1~b_2) &=& 0 \\
{\MacroAtomArrow}(a \to_{{c^\ast}} b_1~b_2) &=& 0 \\
{\MacroAtomArrow}(a \to_{c_1~c_2} b_1~b_2) &=& 0 \\
{\MacroAtomArrow}({\to}_{c_1~c_2} b_1~b_2) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\ShowInfixArrow} &::=& {\mathbb{N}^\ast} \rightarrow_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\ShowAtomArrow} &::=& {\mathbb{N}^\ast}~{\rightarrow}_{{\mathbb{N}^\ast}}\,{\mathbb{N}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\ShowInfixArrow}(a \rightarrow_{c} ) &=& 0 \\
{\ShowInfixArrow}(a \rightarrow_{c} b) &=& 0 \\
{\ShowInfixArrow}(a \rightarrow_{({c^\ast})} b) &=& 0 \\
{\ShowInfixArrow}(a \rightarrow_{c} b_1~b_2) &=& 0 \\
{\ShowInfixArrow}(a \rightarrow_{({c^\ast})} b_1~b_2) &=& 0 \\
{\ShowInfixArrow}(a \rightarrow_{(c_1~c_2)} b_1~b_2) &=& 0 \\
{\ShowInfixArrow}({\rightarrow}_{(c_1~c_2)} b_1~b_2) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\ShowAtomArrow}(a~{\rightarrow}_{c}) &=& 0 \\
{\ShowAtomArrow}(a~{\rightarrow}_{c}\,b) &=& 0 \\
{\ShowAtomArrow}(a~{\rightarrow}_{({c^\ast})}\,b) &=& 0 \\
{\ShowAtomArrow}(a~{\rightarrow}_{c}\,b_1~b_2) &=& 0 \\
{\ShowAtomArrow}(a~{\rightarrow}_{({c^\ast})}\,b_1~b_2) &=& 0 \\
{\ShowAtomArrow}(a~{\rightarrow}_{(c_1~c_2)}\,b_1~b_2) &=& 0 \\
{\ShowAtomArrow}({\rightarrow}_{(c_1~c_2)}\,b_1~b_2) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\ShowMacroInfixArrow} &::=& {\mathbb{N}^\ast} \to_{{\mathbb{N}^\ast}} {\mathbb{N}^\ast} \\
& {\ShowMacroAtomArrow} &::=& {\mathbb{N}^\ast}~{\to}_{{\mathbb{N}^\ast}}\,{\mathbb{N}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\ShowMacroInfixArrow}(a \to_{c} ) &=& 0 \\
{\ShowMacroInfixArrow}(a \to_{c} b) &=& 0 \\
{\ShowMacroInfixArrow}(a \to_{({c^\ast})} b) &=& 0 \\
{\ShowMacroInfixArrow}(a \to_{c} b_1~b_2) &=& 0 \\
{\ShowMacroInfixArrow}(a \to_{({c^\ast})} b_1~b_2) &=& 0 \\
{\ShowMacroInfixArrow}(a \to_{(c_1~c_2)} b_1~b_2) &=& 0 \\
{\ShowMacroInfixArrow}({\to}_{(c_1~c_2)} b_1~b_2) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\ShowMacroAtomArrow}(a~{\to}_{c}) &=& 0 \\
{\ShowMacroAtomArrow}(a~{\to}_{c}\,b) &=& 0 \\
{\ShowMacroAtomArrow}(a~{\to}_{({c^\ast})}\,b) &=& 0 \\
{\ShowMacroAtomArrow}(a~{\to}_{c}\,b_1~b_2) &=& 0 \\
{\ShowMacroAtomArrow}(a~{\to}_{({c^\ast})}\,b_1~b_2) &=& 0 \\
{\ShowMacroAtomArrow}(a~{\to}_{(c_1~c_2)}\,b_1~b_2) &=& 0 \\
{\ShowMacroAtomArrow}({\to}_{(c_1~c_2)}\,b_1~b_2) &=& 0 \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\fii} &::=& \FII \\
& {\faa} &::=& \FAA \\
& {\XfooYfooZ} &::=& \FOO \\
& {\mathit{fuu}} &::=& \FUU \\
& {\foobar} &::=& \BAR \\
& {\fooboo} &::=& \BOO \\
& {\XfobYfobZ} &::=& \BAZ \\
& {\mathit{fib}} &::=& \BOI \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\macros1} &=& 0
  &\qquad \mbox{if}~{\fii} = \FII \\
  &&&\qquad {\land}~{\faa} = \FAA \\
  &&&\qquad {\land}~{\XfooYfooZ} = \FOO \\
  &&&\qquad {\land}~{\mathit{fuu}} = \FUU \\
  &&&\qquad {\land}~{\foobar} = \BAR \\
  &&&\qquad {\land}~{\fooboo} = \BOO \\
  &&&\qquad {\land}~{\XfobYfobZ} = \BAZ \\
  &&&\qquad {\land}~{\mathit{fib}} = \BOI \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\ufii}}_{{\mathit{nat}}_1}({\mathit{nat}}_2) &::=& \UFII \\
& {{\ufaa}}_{{\mathit{nat}}_1}({\mathit{nat}}_2) &::=& \UFAA \\
& {{\XufooYufooZ}}_{{\mathit{nat}}_1}({\mathit{nat}}_2) &::=& \UFOO \\
& {{\mathit{ufuu}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2) &::=& \UFUU \\
& {{\mathit{ufoobar}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2, z) &::=& \UBAR \\
& {{\mathit{ufooboo}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2, z) &::=& \UBOO \\
& {{\mathit{XufobYufobZ}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2, {\mathit{XzYzZ}}) &::=& \UBAZ \\
& {{\mathit{ufib}}}_{{\mathit{nat}}_1}({\mathit{nat}}_2, z) &::=& \UBOI \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\macros2} &=& 0
  &\qquad \mbox{if}~{\mathit{ufii}} = \UFII \\
  &&&\qquad {\land}~{\mathit{ufaa}} = \UFAA \\
  &&&\qquad {\land}~{\mathit{ufoo}} = \UFOO \\
  &&&\qquad {\land}~{\mathit{ufuu}} = \UFUU \\
  &&&\qquad {\land}~{\mathit{ubar}} = \UBAR \\
  &&&\qquad {\land}~{\mathit{uboo}} = \UBOO \\
  &&&\qquad {\land}~{\mathit{ubaz}} = \UBAZ \\
  &&&\qquad {\land}~{\mathit{uboi}} = \UBOI \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\fii} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\faa} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\XfooYfooZ} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{fuu}} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{foobar}} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{fooboo}} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{XfobYfobZ}} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{fib}} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\ufii}}_{x}(y) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\ufaa}}_{x}(y) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\XufooYufooZ}}_{x}(y) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{ufuu}}}_{x}(y) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{ufoobar}}}_{x}(y, z) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{ufooboo}}}_{x}(y, z) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{XufobYufobZ}}}_{x}(y, {\mathit{XzYzZ}}) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{ufib}}}_{x}(y, z) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\foobar} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\fooboo} &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\ufoobar}}_{x}(y) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\ufooboo}}_{x}(y, z) &=& 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\parent} &::=& \AA \\ &&|&
\AAX \\ &&|&
\xAAYyAAYz \\ &&|&
\mathsf{aaz} \\ &&|&
\BBB \\ &&|&
\BBBX \\ &&|&
\xBBBYyBBBYz \\ &&|&
\mathsf{bbbz} \\ &&|&
\CC~\mathbb{N}~\CCCC \\ &&|&
\CCX~\mathbb{N}~\CCXX \\ &&|&
\xCCYyCCYz~\mathbb{N}~\xCCYYyCCYYz \\ &&|&
\mathsf{ccz}~\mathbb{N}~\mathsf{cczz} \\ &&|&
\DDD~\mathbb{N}~{\child}~{\XfooYfooZ}~{\mathrm{fuu}}~{\fiz} \\ &&|&
\DDDX~\mathbb{N}~{\child} \\ &&|&
\xDDDYyDDDYz~\mathbb{N}~{\mathit{xchildychildz}} \\ &&|&
\mathsf{dddz}~\mathbb{N}~{\child} \\ &&|&
{\mathbb{N}}{\mathsf{\_}}{\EA}{\EE}~z \\ &&|&
{\mathbb{N}}{\mathsf{\_}}{\EB}{\EEX}~z \\ &&|&
{\mathbb{N}}{\mathsf{\_}}{\xECyECz}{\xEEYyEEYz}~{\mathit{xzyzz}} \\ &&|&
{\mathbb{N}}{\mathsf{\_}}{\mathsf{ed}}{\mathsf{eez}}~z \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\parent}(\AA) &=& 0 \\
{\parent}(\AAX) &=& 0 \\
{\parent}(\xAAYyAAYz) &=& 0 \\
{\parent}(\mathsf{aaz}) &=& 0 \\
{\parent}(\BBB) &=& 0 \\
{\parent}(\BBBX) &=& 0 \\
{\parent}(\xBBBYyBBBYz) &=& 0 \\
{\parent}(\mathsf{bbbz}) &=& 0 \\
{\parent}(\CC~n~\CCCC) &=& 0 \\
{\parent}(\CCX~n~\CCXX) &=& 0 \\
{\parent}(\xCCYyCCYz~n~\xCCYYyCCYYz) &=& 0 \\
{\parent}(\mathsf{ccz}~n~\mathsf{cczz}) &=& 0 \\
{\parent}(\DDD~n~{\child}~{\XfooYfooZ}~{\mathrm{fuu}}~{\fiz}) &=& 0 \\
{\parent}(\DDDX~n~{\child}) &=& 0 \\
{\parent}(\xDDDYyDDDYz~n~{\mathit{xchildychildz}}) &=& 0 \\
{\parent}(\mathsf{dddz}~n~{\child}) &=& 0 \\
{\parent}({n}{\mathsf{\_}}{\EA}{\EE}~z) &=& 0 \\
{\parent}({n}{\mathsf{\_}}{\EB}{\EEX}~z) &=& 0 \\
{\parent}({n}{\mathsf{\_}}{\xECyECz}{\xEEYyEEYz}~{\mathit{xzyzz}}) &=& 0 \\
{\parent}({n}{\mathsf{\_}}{\mathsf{ed}}{\mathsf{eez}}~z) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\parentimplicit}(t) &::=& \PP \\ &&|&
\PPX \\ &&|&
\PPYxPPY \\ &&|&
\mathsf{ppz} \\ &&|&
\QQQ \\ &&|&
\QQQX \\ &&|&
\QQQYxQQQY \\ &&|&
\mathsf{qqqz} \\ &&|&
{t}{\mathsf{\_}}{\RA}{\RR}~z \\ &&|&
{t}{\mathsf{\_}}{\RB}{\RRX}~z \\ &&|&
{t}{\mathsf{\_}}{\RCxRC}{\RRYxRRY}~{\mathit{zxz}} \\ &&|&
{t}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\parentimpl}(\PPimpl) &=& 0 \\
{\parentimpl}(\PPX) &=& 0 \\
{\parentimpl}(\PPYxPPY) &=& 0 \\
{\parentimpl}(\mathsf{ppz}) &=& 0 \\
{\parentimpl}(\QQQimpl) &=& 0 \\
{\parentimpl}(\QQQX) &=& 0 \\
{\parentimpl}(\QQQYxQQQY) &=& 0 \\
{\parentimpl}(\mathsf{qqqz}) &=& 0 \\
{\parentimpl}({n}{\mathsf{\_}}{\RAimpl}{\RRimpl}~{\mathit{zimpl}}) &=& 0 \\
{\parentimpl}({n}{\mathsf{\_}}{\RB}{\RRX}~z) &=& 0 \\
{\parentimpl}({n}{\mathsf{\_}}{\RCxRC}{\RRYxRRY}~{\mathit{zxz}}) &=& 0 \\
{\parentimpl}({n}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\indirect} &::=& {\parentimplicit}(\mathbb{N}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\indirect}(\PPimpl) &=& 0 \\
{\indirect}(\PPX) &=& 0 \\
{\indirect}(\PPYxPPY) &=& 0 \\
{\indirect}(\mathsf{ppz}) &=& 0 \\
{\indirect}(\QQQimpl) &=& 0 \\
{\indirect}(\QQQX) &=& 0 \\
{\indirect}(\QQQYxQQQY) &=& 0 \\
{\indirect}(\mathsf{qqqz}) &=& 0 \\
{\indirect}({n}{\mathsf{\_}}{\RAimpl}{\RRimpl}~{\mathit{zimpl}}) &=& 0 \\
{\indirect}({n}{\mathsf{\_}}{\RB}{\RRX}~z) &=& 0 \\
{\indirect}({n}{\mathsf{\_}}{\RCxRC}{\RRYxRRY}~{\mathit{zxz}}) &=& 0 \\
{\indirect}({n}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\family}(0) &::=& \FF \\
& {\family}(1) &::=& \GGfamily \\
& {\family}(2) &::=& \xHHy \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\family}(0, \FFfamily) &=& 0 \\
{\family}(1, \GGfamily) &=& 0 \\
{\family}(2, \xHHy) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\child} &::=& {\parent} ~|~ {\family}(0) ~|~ {\indirect} ~|~ \ZZZ \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\child}(\AA) &=& 0 \\
{\child}(\AAX) &=& 0 \\
{\child}(\xAAYyAAYz) &=& 0 \\
{\child}(\mathsf{aaz}) &=& 0 \\
{\child}(\BBB) &=& 0 \\
{\child}(\BBBX) &=& 0 \\
{\child}(\xBBBYyBBBYz) &=& 0 \\
{\child}(\mathsf{bbbz}) &=& 0 \\
{\child}(\CC~n~\CCCC) &=& 0 \\
{\child}(\CCX~n~\CCXX) &=& 0 \\
{\child}(\xCCYyCCYz~n~\xCCYYyCCYYz) &=& 0 \\
{\child}(\mathsf{ccz}~n~\mathsf{cczz}) &=& 0 \\
{\child}(\DDD~n~{\child}~{\XfooYfooZ}~{\mathrm{fuu}}~{\fiz}) &=& 0 \\
{\child}(\DDDX~n~{\child}) &=& 0 \\
{\child}(\xDDDYyDDDYz~n~{\mathit{xchildychildz}}) &=& 0 \\
{\child}(\mathsf{dddz}~n~{\child}) &=& 0 \\
{\child}({n}{\mathsf{\_}}{\EA}{\EE}~z) &=& 0 \\
{\child}({n}{\mathsf{\_}}{\EB}{\EEX}~z) &=& 0 \\
{\child}({n}{\mathsf{\_}}{\xECyECz}{\xEEYyEEYz}~{\mathit{xzyzz}}) &=& 0 \\
{\child}({n}{\mathsf{\_}}{\mathsf{ed}}{\mathsf{eez}}~z) &=& 0 \\
{\child}(\FF) &=& 0 \\
{\child}(\PP) &=& 0 \\
{\child}(\PPX) &=& 0 \\
{\child}(\PPYxPPY) &=& 0 \\
{\child}(\mathsf{ppz}) &=& 0 \\
{\child}(\QQQ) &=& 0 \\
{\child}(\QQQX) &=& 0 \\
{\child}(\QQQYxQQQY) &=& 0 \\
{\child}(\mathsf{qqqz}) &=& 0 \\
{\child}({n}{\mathsf{\_}}{\RA}{\RR}~z) &=& 0 \\
{\child}({n}{\mathsf{\_}}{\RB}{\RRX}~z) &=& 0 \\
{\child}({n}{\mathsf{\_}}{\RCxRC}{\RRYxRRY}~{\mathit{zxz}}) &=& 0 \\
{\child}({n}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z) &=& 0 \\
{\child}(\ZZZ) &=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\grandchild} &::=& {\child} ~|~ \ZZZZ \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\grandchild}(\AA) &=& 0 \\
{\grandchild}(\AAX) &=& 0 \\
{\grandchild}(\xAAYyAAYz) &=& 0 \\
{\grandchild}(\mathsf{aaz}) &=& 0 \\
{\grandchild}(\BBB) &=& 0 \\
{\grandchild}(\BBBX) &=& 0 \\
{\grandchild}(\xBBBYyBBBYz) &=& 0 \\
{\grandchild}(\mathsf{bbbz}) &=& 0 \\
{\grandchild}(\CC~n~\CCCC) &=& 0 \\
{\grandchild}(\CCX~n~\CCXX) &=& 0 \\
{\grandchild}(\xCCYyCCYz~n~\xCCYYyCCYYz) &=& 0 \\
{\grandchild}(\mathsf{ccz}~n~\mathsf{cczz}) &=& 0 \\
{\grandchild}(\DDD~n~{\child}~{\XfooYfooZ}~{\mathrm{fuu}}~{\fiz}) &=& 0 \\
{\grandchild}(\DDDX~n~{\child}) &=& 0 \\
{\grandchild}(\xDDDYyDDDYz~n~{\mathit{xchildychildz}}) &=& 0 \\
{\grandchild}(\mathsf{dddz}~n~{\child}) &=& 0 \\
{\grandchild}({n}{\mathsf{\_}}{\EA}{\EE}~z) &=& 0 \\
{\grandchild}({n}{\mathsf{\_}}{\EB}{\EEX}~z) &=& 0 \\
{\grandchild}({n}{\mathsf{\_}}{\xECyECz}{\xEEYyEEYz}~{\mathit{xzyzz}}) &=& 0 \\
{\grandchild}({n}{\mathsf{\_}}{\mathsf{ed}}{\mathsf{eez}}~z) &=& 0 \\
{\grandchild}(\FF) &=& 0 \\
{\grandchild}(\PP) &=& 0 \\
{\grandchild}(\PPX) &=& 0 \\
{\grandchild}(\PPYxPPY) &=& 0 \\
{\grandchild}(\mathsf{ppz}) &=& 0 \\
{\grandchild}(\QQQ) &=& 0 \\
{\grandchild}(\QQQX) &=& 0 \\
{\grandchild}(\QQQYxQQQY) &=& 0 \\
{\grandchild}(\mathsf{qqqz}) &=& 0 \\
{\grandchild}({n}{\mathsf{\_}}{\RA}{\RR}~z) &=& 0 \\
{\grandchild}({n}{\mathsf{\_}}{\RB}{\RRX}~z) &=& 0 \\
{\grandchild}({n}{\mathsf{\_}}{\RCxRC}{\RRYxRRY}~{\mathit{zxz}}) &=& 0 \\
{\grandchild}({n}{\mathsf{\_}}{\mathsf{rd}}{\mathsf{rrz}}~z) &=& 0 \\
{\grandchild}(\ZZZ) &=& 0 \\
{\grandchild}(\ZZZZ) &=& 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\rec} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\FA~{\mathbb{N}^\ast},\; \\
  \FB~{\mathbb{N}^\ast},\; \\
  \xFCyFCz~{\mathbb{N}^\ast},\; \\
  \mathsf{fd}~{\mathbb{N}^\ast},\; \\
  \FEE~{\mathbb{N}^\ast},\; \\
  \FFF~{\mathbb{N}^\ast},\; \\
  \xFGGyFGGz~{\mathbb{N}^\ast},\; \\
  \mathsf{fhh}~{\mathbb{N}^\ast} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\proj}(r, 0) &=& r{.}\FA \\
{\proj}(r, 1) &=& r{.}\FB \\
{\proj}(r, 2) &=& r{.}\xFCyFCz \\
{\proj}(r, 3) &=& r{.}\mathsf{fd} \\
{\proj}(r, 4) &=& r{.}\FEE \\
{\proj}(r, 5) &=& r{.}\FFF \\
{\proj}(r, 6) &=& r{.}\xFGGyFGGz \\
{\proj}(r, 7) &=& r{.}\mathsf{fhh} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\upd}(r, 0) &=& r{}[{.}\FA = 0] \\
{\upd}(r, 1) &=& r{}[{.}\FB = 0] \\
{\upd}(r, 2) &=& r{}[{.}\xFCyFCz = 0] \\
{\upd}(r, 3) &=& r{}[{.}\mathsf{fd} = 0] \\
{\upd}(r, 4) &=& r{}[{.}\FEE = 0] \\
{\upd}(r, 5) &=& r{}[{.}\FFF = 0] \\
{\upd}(r, 6) &=& r{}[{.}\xFGGyFGGz = 0] \\
{\upd}(r, 7) &=& r{}[{.}\mathsf{fhh} = 0] \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\ext}(r, 0) &=& r{}[{.}\FA \mathrel{{=}{\oplus}} 0] \\
{\ext}(r, 1) &=& r{}[{.}\FB \mathrel{{=}{\oplus}} 0] \\
{\ext}(r, 2) &=& r{}[{.}\xFCyFCz \mathrel{{=}{\oplus}} 0] \\
{\ext}(r, 3) &=& r{}[{.}\mathsf{fd} \mathrel{{=}{\oplus}} 0] \\
{\ext}(r, 4) &=& r{}[{.}\FEE \mathrel{{=}{\oplus}} 0] \\
{\ext}(r, 5) &=& r{}[{.}\FFF \mathrel{{=}{\oplus}} 0] \\
{\ext}(r, 6) &=& r{}[{.}\xFGGyFGGz \mathrel{{=}{\oplus}} 0] \\
{\ext}(r, 7) &=& r{}[{.}\mathsf{fhh} \mathrel{{=}{\oplus}} 0] \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\recimpl} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\RFIA~{\mathbb{N}^\ast},\; \\
  \FIB~{\mathbb{N}^\ast},\; \\
  \xFICyFICz~{\mathbb{N}^\ast},\; \\
  \mathsf{fid}~{\mathbb{N}^\ast},\; \\
  \RFIEE~{\mathbb{N}^\ast},\; \\
  \FIFF~{\mathbb{N}^\ast},\; \\
  \xFIGGyFIGGz~{\mathbb{N}^\ast},\; \\
  \mathsf{fihh}~{\mathbb{N}^\ast} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\rproj}(r, 0) &=& r{.}\RFIA \\
{\rproj}(r, 1) &=& r{.}\FIB \\
{\rproj}(r, 2) &=& r{.}\xFICyFICz \\
{\rproj}(r, 3) &=& r{.}\mathsf{fid} \\
{\rproj}(r, 4) &=& r{.}\RFIEE \\
{\rproj}(r, 5) &=& r{.}\FIFF \\
{\rproj}(r, 6) &=& r{.}\xFIGGyFIGGz \\
{\rproj}(r, 7) &=& r{.}\mathsf{fihh} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\cona} &::=& \mathbb{N}~\COA~\mathbb{N} \\
& {\conb} &::=& \mathbb{N}~\COB~\mathbb{N} \\
& {\conc} &::=& \mathbb{N}~\xCOCyCOCz~\mathbb{N} \\
& {\cond} &::=& \mathbb{N}~\mathsf{cod}~\mathbb{N} \\
& {\cone} &::=& \mathbb{N}~\COE~\mathbb{N} \\
& {\conf} &::=& \mathbb{N}~\COF~\mathbb{N} \\
& {\cong} &::=& \mathbb{N}~\xCOGyCOGz~\mathbb{N} \\
& {\conh} &::=& \mathbb{N}~\mathsf{coh}~\mathbb{N} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\C} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
 \}\end{array} \\
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
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize Reval}]} \quad & {\parent} ; {\child} &\hookrightarrow& \AA ; \BBB \\
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
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize Reval\_macro}]} \quad & {\parent} ; {\child} &\sqarroweval& \AA ; \BBB \\
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
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize Reval\_nomacro}]} \quad & {\parent} ; {\child} &\hookrightarrow& \AA ; \BBB \\
\end{array}
$$


```


# Preview

```sh
$ (../src/exe-watsup/main.exe ../spec/wasm-3.0/*.watsup --latex)
\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& N &::=& \mathbb{N} \\
& M &::=& \mathbb{N} \\
& K &::=& \mathbb{N} \\
& n &::=& \mathbb{N} \\
& m &::=& \mathbb{N} \\
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
{\mathrm{min}}(0, j) &=& 0 \\
{\mathrm{min}}(i, 0) &=& 0 \\
{\mathrm{min}}(i + 1, j + 1) &=& {\mathrm{min}}(i, j) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\Sigma}\, \epsilon &=& 0 \\
{\Sigma}\, n~{{n'}^\ast} &=& n + {\Sigma}\, {{n'}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
\epsilon &=& \epsilon \\
w &=& w \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\epsilon &=& \epsilon \\
w &=& w \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\bigoplus}\, \epsilon &=& \epsilon \\
{\bigoplus}\, ({w^\ast})~{({{w'}^\ast})^\ast} &=& {w^\ast} \oplus {\bigoplus}\, {({{w'}^\ast})^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\epsilon~{\mathrm{disjoint}} &=& \mathsf{true} \\
w~{{w'}^\ast}~{\mathrm{disjoint}} &=& {\neg(w \in {{w'}^\ast})} \land {{w'}^\ast}~{\mathrm{disjoint}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\epsilon \setminus {w^\ast} &=& \epsilon \\
w_1~{{w'}^\ast} \setminus {w^\ast} &=& {{\mathrm{setminus{\kern-0.1em\scriptstyle 1}}}}_{X}(w_1, {w^\ast}) \oplus {{w'}^\ast} \setminus {w^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{setminus{\kern-0.1em\scriptstyle 1}}}}_{X}(w, \epsilon) &=& w \\
{{\mathrm{setminus{\kern-0.1em\scriptstyle 1}}}}_{X}(w, w_1~{{w'}^\ast}) &=& \epsilon
  &\qquad \mbox{if}~w = w_1 \\
{{\mathrm{setminus{\kern-0.1em\scriptstyle 1}}}}_{X}(w, w_1~{{w'}^\ast}) &=& {{\mathrm{setminus{\kern-0.1em\scriptstyle 1}}}}_{X}(w, {{w'}^\ast})
  &\qquad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\Large\times~\epsilon &=& (\epsilon) \\
\Large\times~({w_1^\ast})~{({w^\ast})^\ast} &=& {{\mathrm{setproduct{\kern-0.1em\scriptstyle 1}}}}_{X}({w_1^\ast}, \Large\times~{({w^\ast})^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{setproduct{\kern-0.1em\scriptstyle 1}}}}_{X}(\epsilon, {({w^\ast})^\ast}) &=& \epsilon \\
{{\mathrm{setproduct{\kern-0.1em\scriptstyle 1}}}}_{X}(w_1~{{w'}^\ast}, {({w^\ast})^\ast}) &=& {{\mathrm{setproduct{\kern-0.1em\scriptstyle 2}}}}_{X}(w_1, {({w^\ast})^\ast}) \oplus {{\mathrm{setproduct{\kern-0.1em\scriptstyle 1}}}}_{X}({{w'}^\ast}, {({w^\ast})^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{setproduct{\kern-0.1em\scriptstyle 2}}}}_{X}(w_1, \epsilon) &=& \epsilon \\
{{\mathrm{setproduct{\kern-0.1em\scriptstyle 2}}}}_{X}(w_1, ({{w'}^\ast})~{({w^\ast})^\ast}) &=& (w_1~{{w'}^\ast}) \oplus {{\mathrm{setproduct{\kern-0.1em\scriptstyle 2}}}}_{X}(w_1, {({w^\ast})^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{list}}(X) &::=& {X^\ast}
  &\qquad \mbox{if}~{|{X^\ast}|} < {2^{32}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(bit)} & {\mathit{bit}} &::=& 0 ~|~ 1 \\
\mbox{(byte)} & {\mathit{byte}} &::=& \mathtt{0x00} ~|~ \ldots ~|~ \mathtt{0xFF} \\
\mbox{(unsigned integer)} & {u}{N} &::=& 0 ~|~ \ldots ~|~ {2^{N}} - 1 \\
\mbox{(signed integer)} & {s}{N} &::=& {-{2^{N - 1}}} ~|~ \ldots ~|~ {-1} ~|~ 0 ~|~ {+1} ~|~ \ldots ~|~ {2^{N - 1}} - 1 \\
\mbox{(integer)} & {i}{N} &::=& {u}{N} \\
& {\mathit{u{\kern-0.1em\scriptstyle 8}}} &::=& {u}{8} \\
& {\mathit{u{\kern-0.1em\scriptstyle 16}}} &::=& {u}{16} \\
& {\mathit{u{\kern-0.1em\scriptstyle 31}}} &::=& {u}{31} \\
& {\mathit{u{\kern-0.1em\scriptstyle 32}}} &::=& {u}{32} \\
& {\mathit{u{\kern-0.1em\scriptstyle 64}}} &::=& {u}{64} \\
& {\mathit{u{\kern-0.1em\scriptstyle 128}}} &::=& {u}{128} \\
& {\mathit{s{\kern-0.1em\scriptstyle 33}}} &::=& {s}{33} \\
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
M &=& {\mathrm{signif}}(N) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
E &=& {\mathrm{expon}}(N) \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(floating-point number)} & {f}{N} &::=& {+{{\mathit{fNmag}}}} ~|~ {-{{\mathit{fNmag}}}} \\
\mbox{(floating-point magnitude)} & {{\mathit{fNmag}}} &::=& (1 + m \cdot {2^{{-M}}}) \cdot {2^{n}}
  &\qquad \mbox{if}~m < {2^{M}} \land 2 - {2^{E - 1}} \leq n \leq {2^{E - 1}} - 1 \\ &&|&
(0 + m \cdot {2^{{-M}}}) \cdot {2^{n}}
  &\qquad \mbox{if}~m < {2^{M}} \land 2 - {2^{E - 1}} = n \\ &&|&
\infty \\ &&|&
{\mathsf{nan}}{(m)}
  &\qquad \mbox{if}~1 \leq m < {2^{M}} \\
& {\mathit{f{\kern-0.1em\scriptstyle 32}}} &::=& {f}{32} \\
& {\mathit{f{\kern-0.1em\scriptstyle 64}}} &::=& {f}{64} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{+0} &=& {+((0 + 0 \cdot {2^{{-M}}}) \cdot {2^{n}})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{+1} &=& {+((1 + 1 \cdot {2^{{-M}}}) \cdot {2^{0}})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{canon}}}_{N} &=& {2^{{\mathrm{signif}}(N) - 1}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(vector)} & {v}{N} &::=& {i}{N} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(character)} & {\mathit{char}} &::=& \mathrm{U{+}00} ~|~ \ldots ~|~ \mathrm{U{+}D7FF} ~|~ \mathrm{U{+}E000} ~|~ \ldots ~|~ \mathrm{U{+}10FFFF} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(name)} & {\mathit{name}} &::=& {{\mathit{char}}^\ast}
  &\qquad \mbox{if}~{|{\mathrm{utf{\kern-0.1em\scriptstyle 8}}}({{\mathit{char}}^\ast})|} < {2^{32}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(index)} & {\mathit{idx}} &::=& {\mathit{u{\kern-0.1em\scriptstyle 32}}} \\
\mbox{(lane index)} & {\mathit{laneidx}} &::=& {\mathit{u{\kern-0.1em\scriptstyle 8}}} \\
\mbox{(type index)} & {\mathit{typeidx}} &::=& {\mathit{idx}} \\
\mbox{(function index)} & {\mathit{funcidx}} &::=& {\mathit{idx}} \\
\mbox{(global index)} & {\mathit{globalidx}} &::=& {\mathit{idx}} \\
\mbox{(table index)} & {\mathit{tableidx}} &::=& {\mathit{idx}} \\
\mbox{(memory index)} & {\mathit{memidx}} &::=& {\mathit{idx}} \\
\mbox{(elem index)} & {\mathit{elemidx}} &::=& {\mathit{idx}} \\
\mbox{(data index)} & {\mathit{dataidx}} &::=& {\mathit{idx}} \\
\mbox{(label index)} & {\mathit{labelidx}} &::=& {\mathit{idx}} \\
\mbox{(local index)} & {\mathit{localidx}} &::=& {\mathit{idx}} \\
\mbox{(field index)} & {\mathit{fieldidx}} &::=& {\mathit{idx}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathsf{null}^?} &::=& {\mathsf{null}^?} \\
& {\mathsf{null}}{{{}_{1}^?}} &::=& {\mathsf{null}^?} \\
& {\mathsf{null}}{{{}_{2}^?}} &::=& {\mathsf{null}^?} \\
\mbox{(number type)} & {\mathit{numtype}} &::=& \mathsf{i{\scriptstyle 32}} ~|~ \mathsf{i{\scriptstyle 64}} ~|~ \mathsf{f{\scriptstyle 32}} ~|~ \mathsf{f{\scriptstyle 64}} \\
\mbox{(vector type)} & {\mathit{vectype}} &::=& \mathsf{v{\scriptstyle 128}} \\
\mbox{(literal type)} & {\mathit{consttype}} &::=& {\mathit{numtype}} ~|~ {\mathit{vectype}} \\
& {\mathit{absheaptype}} &::=& \mathsf{any} ~|~ \mathsf{eq} ~|~ \mathsf{i{\scriptstyle 31}} ~|~ \mathsf{struct} ~|~ \mathsf{array} ~|~ \mathsf{none} \\ &&|&
\mathsf{func} ~|~ \mathsf{nofunc} \\ &&|&
\mathsf{extern} ~|~ \mathsf{noextern} \\ &&|&
\mathsf{bot} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(defined type)} & {\mathit{deftype}} &::=& {\mathit{rectype}} {.} n \\
& {\mathit{typeuse}} &::=& {\mathit{deftype}} ~|~ {\mathit{typeidx}} ~|~ \mathsf{rec}~n \\
\mbox{(heap type)} & {\mathit{heaptype}} &::=& {\mathit{absheaptype}} ~|~ {\mathit{typeuse}} \\
\mbox{(reference type)} & {\mathit{reftype}} &::=& \mathsf{ref}~{\mathsf{null}^?}~{\mathit{heaptype}} \\
& {\mathit{valtype}} &::=& {\mathit{numtype}} ~|~ {\mathit{vectype}} ~|~ {\mathit{reftype}} ~|~ \mathsf{bot} \\
& {\mathsf{i}}{N} &::=& \mathsf{i{\scriptstyle 32}} ~|~ \mathsf{i{\scriptstyle 64}} \\
& {\mathsf{f}}{N} &::=& \mathsf{f{\scriptstyle 32}} ~|~ \mathsf{f{\scriptstyle 64}} \\
& {\mathsf{v}}{N} &::=& \mathsf{v{\scriptstyle 128}} \\
& t &::=& {\mathsf{i}}{N} ~|~ {\mathsf{f}}{N} ~|~ {\mathsf{v}}{N} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathsf{anyref} &=& (\mathsf{ref}~\mathsf{null}~\mathsf{any}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathsf{eqref} &=& (\mathsf{ref}~\mathsf{null}~\mathsf{eq}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathsf{i{\scriptstyle 31}ref} &=& (\mathsf{ref}~\mathsf{null}~\mathsf{i{\scriptstyle 31}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathsf{structref} &=& (\mathsf{ref}~\mathsf{null}~\mathsf{struct}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathsf{arrayref} &=& (\mathsf{ref}~\mathsf{null}~\mathsf{array}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathsf{funcref} &=& (\mathsf{ref}~\mathsf{null}~\mathsf{func}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathsf{externref} &=& (\mathsf{ref}~\mathsf{null}~\mathsf{extern}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathsf{nullref} &=& (\mathsf{ref}~\mathsf{null}~\mathsf{none}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathsf{nullfuncref} &=& (\mathsf{ref}~\mathsf{null}~\mathsf{nofunc}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
\mathsf{nullexternref} &=& (\mathsf{ref}~\mathsf{null}~\mathsf{noextern}) \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(result type)} & {\mathit{resulttype}} &::=& {\mathit{list}}({\mathit{valtype}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(packed type)} & {\mathit{packtype}} &::=& \mathsf{i{\scriptstyle 8}} ~|~ \mathsf{i{\scriptstyle 16}} \\
\mbox{(lane type)} & {\mathit{lanetype}} &::=& {\mathit{numtype}} ~|~ {\mathit{packtype}} \\
\mbox{(storage type)} & {\mathit{storagetype}} &::=& {\mathit{valtype}} ~|~ {\mathit{packtype}} \\
& {\mathsf{i}}{N} &::=& \mathsf{i{\scriptstyle 8}} ~|~ \mathsf{i{\scriptstyle 16}} \\
& {\mathsf{i}}{N} &::=& {\mathsf{i}}{N} ~|~ {\mathsf{i}}{N} \\
& {\mathsf{i}}{N} &::=& {\mathsf{i}}{N} ~|~ {\mathsf{f}}{N} ~|~ {\mathsf{i}}{N} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathsf{mut}^?} &::=& {\mathsf{mut}^?} \\
& {\mathsf{mut}}{{{}_{1}^?}} &::=& {\mathsf{mut}^?} \\
& {\mathsf{mut}}{{{}_{2}^?}} &::=& {\mathsf{mut}^?} \\
& {\mathsf{final}^?} &::=& {\mathsf{final}^?} \\
\mbox{(field type)} & {\mathit{fieldtype}} &::=& {\mathsf{mut}^?}~{\mathit{storagetype}} \\
\mbox{(function type)} & {\mathit{functype}} &::=& {\mathit{resulttype}} \rightarrow {\mathit{resulttype}} \\
\mbox{(structure type)} & {\mathit{structtype}} &::=& {\mathit{list}}({\mathit{fieldtype}}) \\
\mbox{(array type)} & {\mathit{arraytype}} &::=& {\mathit{fieldtype}} \\
\mbox{(composite type)} & {\mathit{comptype}} &::=& \mathsf{struct}~{\mathit{structtype}} \\ &&|&
\mathsf{array}~{\mathit{arraytype}} \\ &&|&
\mathsf{func}~{\mathit{functype}} \\
\mbox{(sub type)} & {\mathit{subtype}} &::=& \mathsf{sub}~{\mathsf{final}^?}~{{\mathit{typeuse}}^\ast}~{\mathit{comptype}} \\
\mbox{(recursive type)} & {\mathit{rectype}} &::=& \mathsf{rec}~{\mathit{list}}({\mathit{subtype}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(limits)} & {\mathit{limits}} &::=& {}[ {\mathit{u{\kern-0.1em\scriptstyle 32}}} .. {\mathit{u{\kern-0.1em\scriptstyle 32}}} ] \\
\mbox{(global type)} & {\mathit{globaltype}} &::=& {\mathsf{mut}^?}~{\mathit{valtype}} \\
\mbox{(table type)} & {\mathit{tabletype}} &::=& {\mathit{limits}}~{\mathit{reftype}} \\
\mbox{(memory type)} & {\mathit{memtype}} &::=& {\mathit{limits}}~\mathsf{page} \\
\mbox{(element type)} & {\mathit{elemtype}} &::=& {\mathit{reftype}} \\
\mbox{(data type)} & {\mathit{datatype}} &::=& \mathsf{ok} \\
\mbox{(external type)} & {\mathit{externtype}} &::=& \mathsf{func}~{\mathit{typeuse}} ~|~ \mathsf{global}~{\mathit{globaltype}} ~|~ \mathsf{table}~{\mathit{tabletype}} ~|~ \mathsf{mem}~{\mathit{memtype}} \\
\mbox{(module type)} & {\mathit{moduletype}} &::=& {{\mathit{externtype}}^\ast} \rightarrow {{\mathit{externtype}}^\ast} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
N &=& {|{\mathit{nt}}|} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
N_1 &=& {|{\mathit{nt}}|} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
N_2 &=& {|{\mathit{nt}}|} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
N &=& {|{\mathit{pt}}|} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
N &=& {|{\mathit{lt}}|} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
N_1 &=& {|{\mathit{lt}}|} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
N_2 &=& {|{\mathit{lt}}|} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{num}}}_{{\mathsf{i}}{N}} &::=& {i}{N} \\
& {{\mathit{num}}}_{{\mathsf{f}}{N}} &::=& {f}{N} \\
& {{\mathit{pack}}}_{{\mathsf{i}}{N}} &::=& {i}{N} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{lane}}}_{{\mathit{numtype}}} &::=& {{\mathit{num}}}_{{\mathit{numtype}}} \\
& {{\mathit{lane}}}_{{\mathit{packtype}}} &::=& {{\mathit{pack}}}_{{\mathit{packtype}}} \\
& {{\mathit{lane}}}_{{\mathsf{i}}{N}} &::=& {i}{{|{\mathsf{i}}{N}|}} \\
& {{\mathit{vec}}}_{{\mathsf{v}}{N}} &::=& {v}{{|{\mathsf{v}}{N}|}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{lit}}}_{{\mathit{numtype}}} &::=& {{\mathit{num}}}_{{\mathit{numtype}}} \\
& {{\mathit{lit}}}_{{\mathit{vectype}}} &::=& {{\mathit{vec}}}_{{\mathit{vectype}}} \\
& {{\mathit{lit}}}_{{\mathit{packtype}}} &::=& {{\mathit{pack}}}_{{\mathit{packtype}}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
0 &=& 0 \\
0 &=& {+0} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(pack size)} & {\mathit{sz}} &::=& \mathsf{{\scriptstyle 8}} ~|~ \mathsf{{\scriptstyle 16}} ~|~ \mathsf{{\scriptstyle 32}} ~|~ \mathsf{{\scriptstyle 64}} \\
\mbox{(signedness)} & {\mathit{sx}} &::=& \mathsf{u} ~|~ \mathsf{s} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{unop}}}_{{\mathsf{i}}{N}} &::=& \mathsf{clz} ~|~ \mathsf{ctz} ~|~ \mathsf{popcnt} ~|~ {\mathsf{extend}}{{\mathit{sz}}}{\mathsf{\_}}{\mathsf{s}}
  &\qquad \mbox{if}~{\mathit{sz}} < N \\
& {{\mathit{unop}}}_{{\mathsf{f}}{N}} &::=& \mathsf{abs} ~|~ \mathsf{neg} ~|~ \mathsf{sqrt} ~|~ \mathsf{ceil} ~|~ \mathsf{floor} ~|~ \mathsf{trunc} ~|~ \mathsf{nearest} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{binop}}}_{{\mathsf{i}}{N}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{mul} ~|~ {\mathsf{div}}{\mathsf{\_}}{{\mathit{sx}}} ~|~ {\mathsf{rem}}{\mathsf{\_}}{{\mathit{sx}}} \\ &&|&
\mathsf{and} ~|~ \mathsf{or} ~|~ \mathsf{xor} ~|~ \mathsf{shl} ~|~ {\mathsf{shr}}{\mathsf{\_}}{{\mathit{sx}}} ~|~ \mathsf{rotl} ~|~ \mathsf{rotr} \\
& {{\mathit{binop}}}_{{\mathsf{f}}{N}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{mul} ~|~ \mathsf{div} ~|~ \mathsf{min} ~|~ \mathsf{max} ~|~ \mathsf{copysign} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{testop}}}_{{\mathsf{i}}{N}} &::=& \mathsf{eqz} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{relop}}}_{{\mathsf{i}}{N}} &::=& \mathsf{eq} ~|~ \mathsf{ne} ~|~ {\mathsf{lt}}{\mathsf{\_}}{{\mathit{sx}}} ~|~ {\mathsf{gt}}{\mathsf{\_}}{{\mathit{sx}}} ~|~ {\mathsf{le}}{\mathsf{\_}}{{\mathit{sx}}} ~|~ {\mathsf{ge}}{\mathsf{\_}}{{\mathit{sx}}} \\
& {{\mathit{relop}}}_{{\mathsf{f}}{N}} &::=& \mathsf{eq} ~|~ \mathsf{ne} ~|~ \mathsf{lt} ~|~ \mathsf{gt} ~|~ \mathsf{le} ~|~ \mathsf{ge} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{cvtop}}}_{{{\mathsf{i}}{N}}_1, {{\mathsf{i}}{N}}_2} &::=& {\mathsf{extend}}{\mathsf{\_}}{{\mathit{sx}}}
  &\qquad \mbox{if}~N_1 < N_2 \\ &&|&
\mathsf{wrap}
  &\qquad \mbox{if}~N_1 > N_2 \\
& {{\mathit{cvtop}}}_{{{\mathsf{i}}{N}}_1, {{\mathsf{f}}{N}}_2} &::=& {\mathsf{convert}}{\mathsf{\_}}{{\mathit{sx}}} \\ &&|&
\mathsf{reinterpret}
  &\qquad \mbox{if}~N_1 = N_2 \\
& {{\mathit{cvtop}}}_{{{\mathsf{f}}{N}}_1, {{\mathsf{i}}{N}}_2} &::=& {\mathsf{trunc}}{\mathsf{\_}}{{\mathit{sx}}} \\ &&|&
{\mathsf{trunc\_sat}}{\mathsf{\_}}{{\mathit{sx}}} \\ &&|&
\mathsf{reinterpret}
  &\qquad \mbox{if}~N_1 = N_2 \\
& {{\mathit{cvtop}}}_{{{\mathsf{f}}{N}}_1, {{\mathsf{f}}{N}}_2} &::=& \mathsf{promote}
  &\qquad \mbox{if}~N_1 < N_2 \\ &&|&
\mathsf{demote}
  &\qquad \mbox{if}~N_1 > N_2 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(dimension)} & {\mathit{dim}} &::=& \mathsf{{\scriptstyle 1}} ~|~ \mathsf{{\scriptstyle 2}} ~|~ \mathsf{{\scriptstyle 4}} ~|~ \mathsf{{\scriptstyle 8}} ~|~ \mathsf{{\scriptstyle 16}} \\
\mbox{(shape)} & {\mathit{shape}} &::=& {{\mathit{lanetype}}}{\mathsf{x}}{{\mathit{dim}}} \\
\mbox{(shape)} & {\mathit{ishape}} &::=& {{\mathsf{i}}{N}}{\mathsf{x}}{{\mathit{dim}}} \\
\mbox{(shape)} & {\mathit{fshape}} &::=& {{\mathsf{f}}{N}}{\mathsf{x}}{{\mathit{dim}}} \\
\mbox{(shape)} & {\mathit{pshape}} &::=& {{\mathsf{i}}{N}}{\mathsf{x}}{{\mathit{dim}}} \\
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
& {{\mathit{vunop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}} &::=& \mathsf{abs} ~|~ \mathsf{neg} \\ &&|&
\mathsf{popcnt}
  &\qquad \mbox{if}~N = \mathsf{{\scriptstyle 8}} \\
& {{\mathit{vunop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}} &::=& \mathsf{abs} ~|~ \mathsf{neg} ~|~ \mathsf{sqrt} ~|~ \mathsf{ceil} ~|~ \mathsf{floor} ~|~ \mathsf{trunc} ~|~ \mathsf{nearest} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{vbinop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}} &::=& \mathsf{add} \\ &&|&
\mathsf{sub} \\ &&|&
{\mathsf{add\_sat}}{\mathsf{\_}}{{\mathit{sx}}}
  &\qquad \mbox{if}~N \leq \mathsf{{\scriptstyle 16}} \\ &&|&
{\mathsf{sub\_sat}}{\mathsf{\_}}{{\mathit{sx}}}
  &\qquad \mbox{if}~N \leq \mathsf{{\scriptstyle 16}} \\ &&|&
\mathsf{mul}
  &\qquad \mbox{if}~N \geq \mathsf{{\scriptstyle 16}} \\ &&|&
{\mathsf{avgr}}{\mathsf{\_}}{\mathsf{u}}
  &\qquad \mbox{if}~N \leq \mathsf{{\scriptstyle 16}} \\ &&|&
{\mathsf{q{\scriptstyle 15}mulr\_sat}}{\mathsf{\_}}{\mathsf{s}}
  &\qquad \mbox{if}~N = \mathsf{{\scriptstyle 16}} \\ &&|&
{\mathsf{min}}{\mathsf{\_}}{{\mathit{sx}}}
  &\qquad \mbox{if}~N \leq \mathsf{{\scriptstyle 32}} \\ &&|&
{\mathsf{max}}{\mathsf{\_}}{{\mathit{sx}}}
  &\qquad \mbox{if}~N \leq \mathsf{{\scriptstyle 32}} \\
& {{\mathit{vbinop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{mul} ~|~ \mathsf{div} ~|~ \mathsf{min} ~|~ \mathsf{max} ~|~ \mathsf{pmin} ~|~ \mathsf{pmax} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{vtestop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}} &::=& \mathsf{all\_true} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{vrelop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}} &::=& \mathsf{eq} ~|~ \mathsf{ne} \\ &&|&
{\mathsf{lt}}{\mathsf{\_}}{{\mathit{sx}}}
  &\qquad \mbox{if}~N \neq \mathsf{{\scriptstyle 64}} \lor {\mathit{sx}} = \mathsf{s} \\ &&|&
{\mathsf{gt}}{\mathsf{\_}}{{\mathit{sx}}}
  &\qquad \mbox{if}~N \neq \mathsf{{\scriptstyle 64}} \lor {\mathit{sx}} = \mathsf{s} \\ &&|&
{\mathsf{le}}{\mathsf{\_}}{{\mathit{sx}}}
  &\qquad \mbox{if}~N \neq \mathsf{{\scriptstyle 64}} \lor {\mathit{sx}} = \mathsf{s} \\ &&|&
{\mathsf{ge}}{\mathsf{\_}}{{\mathit{sx}}}
  &\qquad \mbox{if}~N \neq \mathsf{{\scriptstyle 64}} \lor {\mathit{sx}} = \mathsf{s} \\
& {{\mathit{vrelop}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}} &::=& \mathsf{eq} ~|~ \mathsf{ne} ~|~ \mathsf{lt} ~|~ \mathsf{gt} ~|~ \mathsf{le} ~|~ \mathsf{ge} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{vcvtop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}} &::=& {\mathsf{extend}}{\mathsf{\_}}{{\mathit{sx}}}
  &\qquad \mbox{if}~N_2 = 2 \cdot N_1 \\
& {{\mathit{vcvtop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{f}}{N}}_2}{\mathsf{x}}{M_2}} &::=& {\mathsf{convert}}{\mathsf{\_}}{{\mathit{sx}}}
  &\qquad \mbox{if}~N_2 \geq N_1 = \mathsf{{\scriptstyle 32}} \\
& {{\mathit{vcvtop}}}_{{{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}} &::=& {\mathsf{trunc\_sat}}{\mathsf{\_}}{{\mathit{sx}}}
  &\qquad \mbox{if}~N_1 \geq N_2 = \mathsf{{\scriptstyle 32}} \\
& {{\mathit{vcvtop}}}_{{{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{f}}{N}}_2}{\mathsf{x}}{M_2}} &::=& \mathsf{demote}
  &\qquad \mbox{if}~N_1 > N_2 \\ &&|&
\mathsf{promote}
  &\qquad \mbox{if}~N_1 < N_2 \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{half}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}} &::=& \mathsf{low} ~|~ \mathsf{high}
  &\qquad \mbox{if}~2 \cdot N_1 = N_1 \\
& {{\mathit{half}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{f}}{N}}_2}{\mathsf{x}}{M_2}} &::=& \mathsf{low}
  &\qquad \mbox{if}~2 \cdot N_1 = N_1 = \mathsf{{\scriptstyle 64}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{zero}}}_{{{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}} &::=& \mathsf{zero}
  &\qquad \mbox{if}~2 \cdot N_2 = N_1 = \mathsf{{\scriptstyle 64}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{vshiftop}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}} &::=& \mathsf{shl} ~|~ {\mathsf{shr}}{\mathsf{\_}}{{\mathit{sx}}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{vextunop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}} &::=& {\mathsf{extadd\_pairwise}}{\mathsf{\_}}{{\mathit{sx}}}
  &\qquad \mbox{if}~16 \leq 2 \cdot N_1 = N_2 \leq \mathsf{{\scriptstyle 32}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{vextbinop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}} &::=& {\mathsf{extmul}}{\mathsf{\_}}{{\mathit{sx}}}{\mathsf{\_}}{{{\mathit{half}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}}
  &\qquad \mbox{if}~2 \cdot N_1 = N_2 \geq \mathsf{{\scriptstyle 16}} \\ &&|&
{\mathsf{dot}}{\mathsf{\_}}{\mathsf{s}}
  &\qquad \mbox{if}~2 \cdot N_1 = N_2 = \mathsf{{\scriptstyle 32}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(memory argument)} & {\mathit{memarg}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{align}~{\mathit{u{\kern-0.1em\scriptstyle 32}}},\; \mathsf{offset}~{\mathit{u{\kern-0.1em\scriptstyle 32}}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{loadop}}}_{{\mathsf{i}}{N}} &::=& {\mathit{sz}}~{\mathit{sx}}
  &\qquad \mbox{if}~{\mathit{sz}} < N \\
& {{\mathit{vloadop}}}_{{\mathit{vectype}}} &::=& {{\mathit{sz}}}{\mathsf{x}}{M}{\mathsf{\_}}{{\mathit{sx}}}
  &\qquad \mbox{if}~{\mathit{sz}} \cdot M = {|{\mathit{vectype}}|} / 2 \\ &&|&
{{\mathit{sz}}}{\mathsf{\_}}{\mathsf{splat}} \\ &&|&
{{\mathit{sz}}}{\mathsf{\_}}{\mathsf{zero}}
  &\qquad \mbox{if}~{\mathit{sz}} \geq \mathsf{{\scriptstyle 32}} \\
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
{\mathit{numtype}}{.}\mathsf{const}~{{\mathit{num}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} {.} {{\mathit{unop}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} {.} {{\mathit{binop}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} {.} {{\mathit{testop}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} {.} {{\mathit{relop}}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}}_1 {.} {{{\mathit{cvtop}}}_{{\mathit{numtype}}_2, {\mathit{numtype}}_1}}{\mathsf{\_}}{{\mathit{numtype}}_2} \\ &&|&
{\mathit{vectype}}{.}\mathsf{const}~{{\mathit{vec}}}_{{\mathit{vectype}}} \\ &&|&
{\mathit{vectype}} {.} {\mathit{vvunop}} \\ &&|&
{\mathit{vectype}} {.} {\mathit{vvbinop}} \\ &&|&
{\mathit{vectype}} {.} {\mathit{vvternop}} \\ &&|&
{\mathit{vectype}} {.} {\mathit{vvtestop}} \\ &&|&
{\mathit{shape}} {.} {{\mathit{vunop}}}_{{\mathit{shape}}} \\ &&|&
{\mathit{shape}} {.} {{\mathit{vbinop}}}_{{\mathit{shape}}} \\ &&|&
{\mathit{shape}} {.} {{\mathit{vtestop}}}_{{\mathit{shape}}} \\ &&|&
{\mathit{shape}} {.} {{\mathit{vrelop}}}_{{\mathit{shape}}} \\ &&|&
{\mathit{ishape}} {.} {{\mathit{vshiftop}}}_{{\mathit{ishape}}} \\ &&|&
{\mathit{ishape}}{.}\mathsf{bitmask} \\ &&|&
{\mathit{ishape}}{.}\mathsf{swizzle}
  &\qquad \mbox{if}~{\mathit{ishape}} = {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} \\ &&|&
{\mathit{ishape}}{.}\mathsf{shuffle}~{{\mathit{laneidx}}^\ast}
  &\qquad \mbox{if}~{\mathit{ishape}} = {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} \land {|{{\mathit{laneidx}}^\ast}|} = \mathsf{{\scriptstyle 16}} \\ &&|&
{\mathit{ishape}}_1 {.} {{{\mathit{vextunop}}}_{{\mathit{ishape}}_2, {\mathit{ishape}}_1}}{\mathsf{\_}}{{\mathit{ishape}}_2} \\ &&|&
{\mathit{ishape}}_1 {.} {{{\mathit{vextbinop}}}_{{\mathit{ishape}}_2, {\mathit{ishape}}_1}}{\mathsf{\_}}{{\mathit{ishape}}_2} \\ &&|&
{{\mathit{ishape}}_1{.}\mathsf{narrow}}{\mathsf{\_}}{{\mathit{ishape}}_2}{\mathsf{\_}}{{\mathit{sx}}}
  &\qquad \mbox{if}~{|{\mathrm{lanetype}}({\mathit{ishape}}_2)|} = 2 \cdot {|{\mathrm{lanetype}}({\mathit{ishape}}_1)|} \leq \mathsf{{\scriptstyle 32}} \\ &&|&
{\mathit{shape}}_1 {.} {{{\mathit{vcvtop}}}_{{\mathit{shape}}_2, {\mathit{shape}}_1}}{\mathsf{\_}}{{{{\mathit{zero}}}_{{\mathit{shape}}_2, {\mathit{shape}}_1}^?}}{\mathsf{\_}}{{\mathit{shape}}_2}{\mathsf{\_}}{{{{\mathit{half}}}_{{\mathit{shape}}_2, {\mathit{shape}}_1}^?}}
  &\qquad \mbox{if}~{\mathrm{lanetype}}({\mathit{shape}}_1) \neq {\mathrm{lanetype}}({\mathit{shape}}_2) \\ &&|&
{\mathit{shape}}{.}\mathsf{splat} \\ &&|&
{{\mathit{shape}}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~{\mathit{laneidx}}
  &\qquad \mbox{if}~{{\mathit{sx}}^?} = \epsilon \Leftrightarrow {\mathrm{lanetype}}({\mathit{shape}}) = {\mathit{numtype}} \\ &&|&
{\mathit{shape}}{.}\mathsf{replace\_lane}~{\mathit{laneidx}} \\ &&|&
\mathsf{ref{.}null}~{\mathit{heaptype}} \\ &&|&
\mathsf{ref{.}is\_null} \\ &&|&
\mathsf{ref{.}as\_non\_null} \\ &&|&
\mathsf{ref{.}eq} \\ &&|&
\mathsf{ref{.}test}~{\mathit{reftype}} \\ &&|&
\mathsf{ref{.}cast}~{\mathit{reftype}} \\ &&|&
\mathsf{ref{.}func}~{\mathit{funcidx}} \\ &&|&
\mathsf{ref{.}i{\scriptstyle 31}} \\ &&|&
{\mathsf{i{\scriptstyle 31}{.}get}}{\mathsf{\_}}{{\mathit{sx}}} \\ &&|&
\mathsf{struct{.}new}~{\mathit{typeidx}} \\ &&|&
\mathsf{struct{.}new\_default}~{\mathit{typeidx}} \\ &&|&
{\mathsf{struct{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~{\mathit{typeidx}}~{\mathit{u{\kern-0.1em\scriptstyle 32}}} \\ &&|&
\mathsf{struct{.}set}~{\mathit{typeidx}}~{\mathit{u{\kern-0.1em\scriptstyle 32}}} \\ &&|&
\mathsf{array{.}new}~{\mathit{typeidx}} \\ &&|&
\mathsf{array{.}new\_default}~{\mathit{typeidx}} \\ &&|&
\mathsf{array{.}new\_fixed}~{\mathit{typeidx}}~{\mathit{u{\kern-0.1em\scriptstyle 32}}} \\ &&|&
\mathsf{array{.}new\_data}~{\mathit{typeidx}}~{\mathit{dataidx}} \\ &&|&
\mathsf{array{.}new\_elem}~{\mathit{typeidx}}~{\mathit{elemidx}} \\ &&|&
{\mathsf{array{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~{\mathit{typeidx}} \\ &&|&
\mathsf{array{.}set}~{\mathit{typeidx}} \\ &&|&
\mathsf{array{.}len} \\ &&|&
\mathsf{array{.}fill}~{\mathit{typeidx}} \\ &&|&
\mathsf{array{.}copy}~{\mathit{typeidx}}~{\mathit{typeidx}} \\ &&|&
\mathsf{array{.}init\_data}~{\mathit{typeidx}}~{\mathit{dataidx}} \\ &&|&
\mathsf{array{.}init\_elem}~{\mathit{typeidx}}~{\mathit{elemidx}} \\ &&|&
\mathsf{extern{.}convert\_any} \\ &&|&
\mathsf{any{.}convert\_extern} \\ &&|&
\mathsf{local{.}get}~{\mathit{localidx}} \\ &&|&
\mathsf{local{.}set}~{\mathit{localidx}} \\ &&|&
\mathsf{local{.}tee}~{\mathit{localidx}} \\ &&|&
\mathsf{global{.}get}~{\mathit{globalidx}} \\ &&|&
\mathsf{global{.}set}~{\mathit{globalidx}} \\ &&|&
\mathsf{table{.}get}~{\mathit{tableidx}} \\ &&|&
\mathsf{table{.}set}~{\mathit{tableidx}} \\ &&|&
\mathsf{table{.}size}~{\mathit{tableidx}} \\ &&|&
\mathsf{table{.}grow}~{\mathit{tableidx}} \\ &&|&
\mathsf{table{.}fill}~{\mathit{tableidx}} \\ &&|&
\mathsf{table{.}copy}~{\mathit{tableidx}}~{\mathit{tableidx}} \\ &&|&
\mathsf{table{.}init}~{\mathit{tableidx}}~{\mathit{elemidx}} \\ &&|&
\mathsf{elem{.}drop}~{\mathit{elemidx}} \\ &&|&
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
\mathsf{data{.}drop}~{\mathit{dataidx}} \\ &&|&
\ldots \\
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
\mbox{(module)} & {\mathit{module}} &::=& \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{|\mathsf{i{\scriptstyle 32}}|} &=& 32 \\
{|\mathsf{i{\scriptstyle 64}}|} &=& 64 \\
{|\mathsf{f{\scriptstyle 32}}|} &=& 32 \\
{|\mathsf{f{\scriptstyle 64}}|} &=& 64 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{|\mathsf{v{\scriptstyle 128}}|} &=& 128 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{|\mathsf{i{\scriptstyle 8}}|} &=& 8 \\
{|\mathsf{i{\scriptstyle 16}}|} &=& 16 \\
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

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{i}}{32} &=& \mathsf{i{\scriptstyle 32}} \\
{\mathsf{i}}{64} &=& \mathsf{i{\scriptstyle 64}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{f}}{32} &=& \mathsf{f{\scriptstyle 32}} \\
{\mathsf{f}}{64} &=& \mathsf{f{\scriptstyle 64}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{i}}{8} &=& \mathsf{i{\scriptstyle 8}} \\
{\mathsf{i}}{16} &=& \mathsf{i{\scriptstyle 16}} \\
{\mathsf{i}}{32} &=& \mathsf{i{\scriptstyle 32}} \\
{\mathsf{i}}{64} &=& \mathsf{i{\scriptstyle 64}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unpack}}({\mathit{numtype}}) &=& {\mathit{numtype}} \\
{\mathrm{unpack}}({\mathit{packtype}}) &=& \mathsf{i{\scriptstyle 32}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unpack}}({\mathit{valtype}}) &=& {\mathit{valtype}} \\
{\mathrm{unpack}}({\mathit{packtype}}) &=& \mathsf{i{\scriptstyle 32}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unpack}}({\mathit{numtype}}) &=& {\mathit{numtype}} \\
{\mathrm{unpack}}({\mathit{packtype}}) &=& \mathsf{i{\scriptstyle 32}} \\
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
{\mathrm{unpack}}({\mathit{packtype}}) &=& \mathsf{i{\scriptstyle 32}} \\
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
{\mathit{numtype}}{.}\mathsf{const}~c &=& ({\mathit{numtype}}{.}\mathsf{const}~c) \\
{\mathit{vectype}}{.}\mathsf{const}~c &=& ({\mathit{vectype}}{.}\mathsf{const}~c) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{lanetype}}({{\mathsf{i}}{N}}{\mathsf{x}}{N}) &=& {\mathsf{i}}{N} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{dim}}({{\mathsf{i}}{N}}{\mathsf{x}}{N}) &=& N \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{|{{\mathsf{i}}{N}}{\mathsf{x}}{N}|} &=& {|{\mathsf{i}}{N}|} \cdot N \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unpack}}({{\mathsf{i}}{N}}{\mathsf{x}}{N}) &=& {\mathrm{unpack}}({\mathsf{i}}{N}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathsf{ref}~{\mathsf{null}}{{{}_{1}^?}}~{\mathit{ht}}_1) \setminus (\mathsf{ref}~\mathsf{null}~{\mathit{ht}}_2) &=& (\mathsf{ref}~{\mathit{ht}}_1) \\
(\mathsf{ref}~{\mathsf{null}}{{{}_{1}^?}}~{\mathit{ht}}_1) \setminus (\mathsf{ref}~{\mathit{ht}}_2) &=& (\mathsf{ref}~{\mathsf{null}}{{{}_{1}^?}}~{\mathit{ht}}_1) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{typevar}} &::=& {\mathit{typeidx}} ~|~ \mathsf{rec}~\mathbb{N} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
x &=& x \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{free}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{types}~{{\mathit{typeidx}}^\ast},\; \\
  \mathsf{funcs}~{{\mathit{funcidx}}^\ast},\; \\
  \mathsf{globals}~{{\mathit{globalidx}}^\ast},\; \\
  \mathsf{tables}~{{\mathit{tableidx}}^\ast},\; \\
  \mathsf{mems}~{{\mathit{memidx}}^\ast},\; \\
  \mathsf{elems}~{{\mathit{elemidx}}^\ast},\; \\
  \mathsf{datas}~{{\mathit{dataidx}}^\ast},\; \\
  \mathsf{locals}~{{\mathit{localidx}}^\ast},\; \\
  \mathsf{labels}~{{\mathit{labelidx}}^\ast} \}\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{opt}}(\epsilon) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
{\mathrm{free}}_{\mathit{opt}}({\mathit{free}}) &=& {\mathit{free}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{list}}(\epsilon) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
{\mathrm{free}}_{\mathit{list}}({\mathit{free}}~{{\mathit{free}'}^\ast}) &=& {\mathit{free}} \oplus {\mathrm{free}}_{\mathit{list}}({{\mathit{free}'}^\ast}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{types}~{\mathit{typeidx}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{funcidx}}({\mathit{funcidx}}) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{funcs}~{\mathit{funcidx}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{globalidx}}({\mathit{globalidx}}) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{globals}~{\mathit{globalidx}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{tables}~{\mathit{tableidx}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{mems}~{\mathit{memidx}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{elemidx}}({\mathit{elemidx}}) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{elems}~{\mathit{elemidx}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{dataidx}}({\mathit{dataidx}}) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{datas}~{\mathit{dataidx}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{localidx}}({\mathit{localidx}}) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{locals}~{\mathit{localidx}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{labelidx}}({\mathit{labelidx}}) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{labels}~{\mathit{labelidx}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{externidx}}(\mathsf{func}~{\mathit{funcidx}}) &=& {\mathrm{free}}_{\mathit{funcidx}}({\mathit{funcidx}}) \\
{\mathrm{free}}_{\mathit{externidx}}(\mathsf{global}~{\mathit{globalidx}}) &=& {\mathrm{free}}_{\mathit{globalidx}}({\mathit{globalidx}}) \\
{\mathrm{free}}_{\mathit{externidx}}(\mathsf{table}~{\mathit{tableidx}}) &=& {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \\
{\mathrm{free}}_{\mathit{externidx}}(\mathsf{mem}~{\mathit{memidx}}) &=& {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{packtype}}({\mathit{packtype}}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{lanetype}}({\mathit{numtype}}) &=& {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \\
{\mathrm{free}}_{\mathit{lanetype}}({\mathit{packtype}}) &=& {\mathrm{free}}_{\mathit{packtype}}({\mathit{packtype}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{consttype}}({\mathit{numtype}}) &=& {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \\
{\mathrm{free}}_{\mathit{consttype}}({\mathit{vectype}}) &=& {\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{absheaptype}}({\mathit{absheaptype}}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{deftype}}({\mathit{rectype}} {.} n) &=& {\mathrm{free}}_{\mathit{rectype}}({\mathit{rectype}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{typeuse}}({\mathit{typeidx}}) &=& {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{typeuse}}(\mathsf{rec}~n) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
{\mathrm{free}}_{\mathit{typeuse}}({\mathit{deftype}}) &=& {\mathrm{free}}_{\mathit{deftype}}({\mathit{deftype}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{heaptype}}({\mathit{absheaptype}}) &=& {\mathrm{free}}_{\mathit{absheaptype}}({\mathit{absheaptype}}) \\
{\mathrm{free}}_{\mathit{heaptype}}({\mathit{typeuse}}) &=& {\mathrm{free}}_{\mathit{typeuse}}({\mathit{typeuse}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{reftype}}(\mathsf{ref}~{\mathsf{null}^?}~{\mathit{heaptype}}) &=& {\mathrm{free}}_{\mathit{heaptype}}({\mathit{heaptype}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{valtype}}({\mathit{numtype}}) &=& {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \\
{\mathrm{free}}_{\mathit{valtype}}({\mathit{vectype}}) &=& {\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \\
{\mathrm{free}}_{\mathit{valtype}}({\mathit{reftype}}) &=& {\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}) \\
{\mathrm{free}}_{\mathit{valtype}}(\mathsf{bot}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{resulttype}}({{\mathit{valtype}}^\ast}) &=& {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{valtype}}({\mathit{valtype}})^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{storagetype}}({\mathit{valtype}}) &=& {\mathrm{free}}_{\mathit{valtype}}({\mathit{valtype}}) \\
{\mathrm{free}}_{\mathit{storagetype}}({\mathit{packtype}}) &=& {\mathrm{free}}_{\mathit{packtype}}({\mathit{packtype}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{fieldtype}}({\mathsf{mut}^?}~{\mathit{storagetype}}) &=& {\mathrm{free}}_{\mathit{storagetype}}({\mathit{storagetype}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{functype}}({\mathit{resulttype}}_1 \rightarrow {\mathit{resulttype}}_2) &=& {\mathrm{free}}_{\mathit{resulttype}}({\mathit{resulttype}}_1) \oplus {\mathrm{free}}_{\mathit{resulttype}}({\mathit{resulttype}}_2) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{structtype}}({{\mathit{fieldtype}}^\ast}) &=& {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{fieldtype}}({\mathit{fieldtype}})^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{arraytype}}({\mathit{fieldtype}}) &=& {\mathrm{free}}_{\mathit{fieldtype}}({\mathit{fieldtype}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{comptype}}(\mathsf{struct}~{\mathit{structtype}}) &=& {\mathrm{free}}_{\mathit{structtype}}({\mathit{structtype}}) \\
{\mathrm{free}}_{\mathit{comptype}}(\mathsf{array}~{\mathit{arraytype}}) &=& {\mathrm{free}}_{\mathit{arraytype}}({\mathit{arraytype}}) \\
{\mathrm{free}}_{\mathit{comptype}}(\mathsf{func}~{\mathit{functype}}) &=& {\mathrm{free}}_{\mathit{functype}}({\mathit{functype}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{subtype}}(\mathsf{sub}~{\mathsf{final}^?}~{{\mathit{typeuse}}^\ast}~{\mathit{comptype}}) &=& {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{typeuse}}({\mathit{typeuse}})^\ast}) \oplus {\mathrm{free}}_{\mathit{comptype}}({\mathit{comptype}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{rectype}}(\mathsf{rec}~{{\mathit{subtype}}^\ast}) &=& {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{subtype}}({\mathit{subtype}})^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{globaltype}}({\mathsf{mut}^?}~{\mathit{valtype}}) &=& {\mathrm{free}}_{\mathit{valtype}}({\mathit{valtype}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{tabletype}}({\mathit{limits}}~{\mathit{reftype}}) &=& {\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{memtype}}({\mathit{limits}}~\mathsf{page}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{elemtype}}({\mathit{reftype}}) &=& {\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{datatype}}(\mathsf{ok}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{externtype}}(\mathsf{func}~{\mathit{typeuse}}) &=& {\mathrm{free}}_{\mathit{typeuse}}({\mathit{typeuse}}) \\
{\mathrm{free}}_{\mathit{externtype}}(\mathsf{global}~{\mathit{globaltype}}) &=& {\mathrm{free}}_{\mathit{globaltype}}({\mathit{globaltype}}) \\
{\mathrm{free}}_{\mathit{externtype}}(\mathsf{table}~{\mathit{tabletype}}) &=& {\mathrm{free}}_{\mathit{tabletype}}({\mathit{tabletype}}) \\
{\mathrm{free}}_{\mathit{externtype}}(\mathsf{mem}~{\mathit{memtype}}) &=& {\mathrm{free}}_{\mathit{memtype}}({\mathit{memtype}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{moduletype}}({{\mathit{externtype}}_1^\ast} \rightarrow {{\mathit{externtype}}_2^\ast}) &=& {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{externtype}}({\mathit{externtype}}_1)^\ast}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{externtype}}({\mathit{externtype}}_2)^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{blocktype}}({{\mathit{valtype}}^?}) &=& {\mathrm{free}}_{\mathit{opt}}({{\mathrm{free}}_{\mathit{valtype}}({\mathit{valtype}})^?}) \\
{\mathrm{free}}_{\mathit{blocktype}}({\mathit{funcidx}}) &=& {\mathrm{free}}_{\mathit{funcidx}}({\mathit{funcidx}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{shape}}({{\mathit{lanetype}}}{\mathsf{x}}{{\mathit{dim}}}) &=& {\mathrm{free}}_{\mathit{lanetype}}({\mathit{lanetype}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{instr}}(\mathsf{nop}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{unreachable}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{drop}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{select}~{({{\mathit{valtype}}^\ast})^?}) &=& {\mathrm{free}}_{\mathit{opt}}({{\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{valtype}}({\mathit{valtype}})^\ast})^?}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{block}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast}) &=& {\mathrm{free}}_{\mathit{blocktype}}({\mathit{blocktype}}) \oplus {\mathrm{free}}_{\mathit{block}}({{\mathit{instr}}^\ast}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{loop}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast}) &=& {\mathrm{free}}_{\mathit{blocktype}}({\mathit{blocktype}}) \oplus {\mathrm{free}}_{\mathit{block}}({{\mathit{instr}}^\ast}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{if}~{\mathit{blocktype}}~{{\mathit{instr}}_1^\ast}~\mathsf{else}~{{\mathit{instr}}_2^\ast}) &=& {\mathrm{free}}_{\mathit{blocktype}}({\mathit{blocktype}}) \oplus {\mathrm{free}}_{\mathit{block}}({{\mathit{instr}}_1^\ast}) \oplus {\mathrm{free}}_{\mathit{block}}({{\mathit{instr}}_2^\ast}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{br}~{\mathit{labelidx}}) &=& {\mathrm{free}}_{\mathit{labelidx}}({\mathit{labelidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{br\_if}~{\mathit{labelidx}}) &=& {\mathrm{free}}_{\mathit{labelidx}}({\mathit{labelidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{br\_table}~{{\mathit{labelidx}}^\ast}~{\mathit{labelidx}'}) &=& {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{labelidx}}({\mathit{labelidx}})^\ast}) \oplus {\mathrm{free}}_{\mathit{labelidx}}({\mathit{labelidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{br\_on\_null}~{\mathit{labelidx}}) &=& {\mathrm{free}}_{\mathit{labelidx}}({\mathit{labelidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{br\_on\_non\_null}~{\mathit{labelidx}}) &=& {\mathrm{free}}_{\mathit{labelidx}}({\mathit{labelidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{br\_on\_cast}~{\mathit{labelidx}}~{\mathit{reftype}}_1~{\mathit{reftype}}_2) &=& {\mathrm{free}}_{\mathit{labelidx}}({\mathit{labelidx}}) \oplus {\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}_1) \oplus {\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}_2) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{br\_on\_cast\_fail}~{\mathit{labelidx}}~{\mathit{reftype}}_1~{\mathit{reftype}}_2) &=& {\mathrm{free}}_{\mathit{labelidx}}({\mathit{labelidx}}) \oplus {\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}_1) \oplus {\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}_2) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{call}~{\mathit{funcidx}}) &=& {\mathrm{free}}_{\mathit{funcidx}}({\mathit{funcidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{call\_ref}~{\mathit{typeuse}}) &=& {\mathrm{free}}_{\mathit{typeuse}}({\mathit{typeuse}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{call\_indirect}~{\mathit{tableidx}}~{\mathit{typeuse}}) &=& {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \oplus {\mathrm{free}}_{\mathit{typeuse}}({\mathit{typeuse}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{return}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{return\_call}~{\mathit{funcidx}}) &=& {\mathrm{free}}_{\mathit{funcidx}}({\mathit{funcidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{return\_call\_ref}~{\mathit{typeuse}}) &=& {\mathrm{free}}_{\mathit{typeuse}}({\mathit{typeuse}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{return\_call\_indirect}~{\mathit{tableidx}}~{\mathit{typeuse}}) &=& {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \oplus {\mathrm{free}}_{\mathit{typeuse}}({\mathit{typeuse}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{numtype}}{.}\mathsf{const}~{\mathit{numlit}}) &=& {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{numtype}} {.} {\mathit{unop}}) &=& {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{numtype}} {.} {\mathit{binop}}) &=& {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{numtype}} {.} {\mathit{testop}}) &=& {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{numtype}} {.} {\mathit{relop}}) &=& {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{numtype}}_1 {.} {{\mathit{cvtop}}}{\mathsf{\_}}{{\mathit{numtype}}_2}) &=& {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}_1) \oplus {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}_2) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{vectype}}{.}\mathsf{const}~{\mathit{veclit}}) &=& {\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{vectype}} {.} {\mathit{vvunop}}) &=& {\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{vectype}} {.} {\mathit{vvbinop}}) &=& {\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{vectype}} {.} {\mathit{vvternop}}) &=& {\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{vectype}} {.} {\mathit{vvtestop}}) &=& {\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{shape}} {.} {\mathit{vunop}}) &=& {\mathrm{free}}_{\mathit{shape}}({\mathit{shape}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{shape}} {.} {\mathit{vbinop}}) &=& {\mathrm{free}}_{\mathit{shape}}({\mathit{shape}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{shape}} {.} {\mathit{vtestop}}) &=& {\mathrm{free}}_{\mathit{shape}}({\mathit{shape}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{shape}} {.} {\mathit{vrelop}}) &=& {\mathrm{free}}_{\mathit{shape}}({\mathit{shape}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{ishape}} {.} {\mathit{vshiftop}}) &=& {\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{ishape}}{.}\mathsf{bitmask}) &=& {\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{ishape}}{.}\mathsf{swizzle}) &=& {\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{ishape}}{.}\mathsf{shuffle}~{{\mathit{laneidx}}^\ast}) &=& {\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{ishape}}_1 {.} {{\mathit{vextunop}}}{\mathsf{\_}}{{\mathit{ishape}}_2}) &=& {\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}_1) \oplus {\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}_2) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{ishape}}_1 {.} {{\mathit{vextbinop}}}{\mathsf{\_}}{{\mathit{ishape}}_2}) &=& {\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}_1) \oplus {\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}_2) \\
{\mathrm{free}}_{\mathit{instr}}({{\mathit{ishape}}_1{.}\mathsf{narrow}}{\mathsf{\_}}{{\mathit{ishape}}_2}{\mathsf{\_}}{{\mathit{sx}}}) &=& {\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}_1) \oplus {\mathrm{free}}_{\mathit{shape}}({\mathit{ishape}}_2) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{shape}}_1 {.} {{\mathit{vcvtop}}}{\mathsf{\_}}{{{\mathit{zero}}^?}}{\mathsf{\_}}{{\mathit{shape}}_2}{\mathsf{\_}}{{{\mathit{half}}^?}}) &=& {\mathrm{free}}_{\mathit{shape}}({\mathit{shape}}_1) \oplus {\mathrm{free}}_{\mathit{shape}}({\mathit{shape}}_2) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{shape}}{.}\mathsf{splat}) &=& {\mathrm{free}}_{\mathit{shape}}({\mathit{shape}}) \\
{\mathrm{free}}_{\mathit{instr}}({{\mathit{shape}}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~{\mathit{laneidx}}) &=& {\mathrm{free}}_{\mathit{shape}}({\mathit{shape}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{shape}}{.}\mathsf{replace\_lane}~{\mathit{laneidx}}) &=& {\mathrm{free}}_{\mathit{shape}}({\mathit{shape}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{ref{.}null}~{\mathit{heaptype}}) &=& {\mathrm{free}}_{\mathit{heaptype}}({\mathit{heaptype}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{ref{.}is\_null}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{ref{.}as\_non\_null}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{ref{.}eq}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{ref{.}test}~{\mathit{reftype}}) &=& {\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{ref{.}cast}~{\mathit{reftype}}) &=& {\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{ref{.}func}~{\mathit{funcidx}}) &=& {\mathrm{free}}_{\mathit{funcidx}}({\mathit{funcidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{ref{.}i{\scriptstyle 31}}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
{\mathrm{free}}_{\mathit{instr}}({\mathsf{i{\scriptstyle 31}{.}get}}{\mathsf{\_}}{{\mathit{sx}}}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{struct{.}new}~{\mathit{typeidx}}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{struct{.}new\_default}~{\mathit{typeidx}}) &=& {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathsf{struct{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~{\mathit{typeidx}}~{\mathit{u{\kern-0.1em\scriptstyle 32}}}) &=& {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{struct{.}set}~{\mathit{typeidx}}~{\mathit{u{\kern-0.1em\scriptstyle 32}}}) &=& {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}new}~{\mathit{typeidx}}) &=& {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}new\_default}~{\mathit{typeidx}}) &=& {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}new\_fixed}~{\mathit{typeidx}}~{\mathit{u{\kern-0.1em\scriptstyle 32}}}) &=& {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}new\_data}~{\mathit{typeidx}}~{\mathit{dataidx}}) &=& {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \oplus {\mathrm{free}}_{\mathit{dataidx}}({\mathit{dataidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}new\_elem}~{\mathit{typeidx}}~{\mathit{elemidx}}) &=& {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \oplus {\mathrm{free}}_{\mathit{elemidx}}({\mathit{elemidx}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathsf{array{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~{\mathit{typeidx}}) &=& {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}set}~{\mathit{typeidx}}) &=& {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}len}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}fill}~{\mathit{typeidx}}) &=& {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}copy}~{\mathit{typeidx}}_1~{\mathit{typeidx}}_2) &=& {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}_1) \oplus {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}_2) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}init\_data}~{\mathit{typeidx}}~{\mathit{dataidx}}) &=& {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \oplus {\mathrm{free}}_{\mathit{dataidx}}({\mathit{dataidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{array{.}init\_elem}~{\mathit{typeidx}}~{\mathit{elemidx}}) &=& {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \oplus {\mathrm{free}}_{\mathit{elemidx}}({\mathit{elemidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{extern{.}convert\_any}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{any{.}convert\_extern}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{local{.}get}~{\mathit{localidx}}) &=& {\mathrm{free}}_{\mathit{localidx}}({\mathit{localidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{local{.}set}~{\mathit{localidx}}) &=& {\mathrm{free}}_{\mathit{localidx}}({\mathit{localidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{local{.}tee}~{\mathit{localidx}}) &=& {\mathrm{free}}_{\mathit{localidx}}({\mathit{localidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{global{.}get}~{\mathit{globalidx}}) &=& {\mathrm{free}}_{\mathit{globalidx}}({\mathit{globalidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{global{.}set}~{\mathit{globalidx}}) &=& {\mathrm{free}}_{\mathit{globalidx}}({\mathit{globalidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{table{.}get}~{\mathit{tableidx}}) &=& {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{table{.}set}~{\mathit{tableidx}}) &=& {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{table{.}size}~{\mathit{tableidx}}) &=& {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{table{.}grow}~{\mathit{tableidx}}) &=& {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{table{.}fill}~{\mathit{tableidx}}) &=& {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{table{.}copy}~{\mathit{tableidx}}_1~{\mathit{tableidx}}_2) &=& {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}_1) \oplus {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}_2) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{table{.}init}~{\mathit{tableidx}}~{\mathit{elemidx}}) &=& {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \oplus {\mathrm{free}}_{\mathit{elemidx}}({\mathit{elemidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{elem{.}drop}~{\mathit{elemidx}}) &=& {\mathrm{free}}_{\mathit{elemidx}}({\mathit{elemidx}}) \\
{\mathrm{free}}_{\mathit{instr}}({{\mathit{numtype}}{.}\mathsf{load}}{{\mathit{loadop}}}~{\mathit{memidx}}~{\mathit{memarg}}) &=& {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \oplus {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
{\mathrm{free}}_{\mathit{instr}}({{\mathit{numtype}}{.}\mathsf{store}}{{{\mathit{sz}}^?}}~{\mathit{memidx}}~{\mathit{memarg}}) &=& {\mathrm{free}}_{\mathit{numtype}}({\mathit{numtype}}) \oplus {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
{\mathrm{free}}_{\mathit{instr}}({{\mathit{vectype}}{.}\mathsf{load}}{{{\mathit{vloadop}}^?}}~{\mathit{memidx}}~{\mathit{memarg}}) &=& {\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \oplus {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
{\mathrm{free}}_{\mathit{instr}}({{\mathit{vectype}}{.}\mathsf{load}}{{\mathit{sz}}}{\mathsf{\_}}{\mathsf{lane}}~{\mathit{memidx}}~{\mathit{memarg}}~{\mathit{laneidx}}) &=& {\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \oplus {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
{\mathrm{free}}_{\mathit{instr}}({\mathit{vectype}}{.}\mathsf{store}~{\mathit{memidx}}~{\mathit{memarg}}) &=& {\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \oplus {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
{\mathrm{free}}_{\mathit{instr}}({{\mathit{vectype}}{.}\mathsf{store}}{{\mathit{sz}}}{\mathsf{\_}}{\mathsf{lane}}~{\mathit{memidx}}~{\mathit{memarg}}~{\mathit{laneidx}}) &=& {\mathrm{free}}_{\mathit{vectype}}({\mathit{vectype}}) \oplus {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{memory{.}size}~{\mathit{memidx}}) &=& {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{memory{.}grow}~{\mathit{memidx}}) &=& {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{memory{.}fill}~{\mathit{memidx}}) &=& {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{memory{.}copy}~{\mathit{memidx}}_1~{\mathit{memidx}}_2) &=& {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}_1) \oplus {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}_2) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{memory{.}init}~{\mathit{memidx}}~{\mathit{dataidx}}) &=& {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \oplus {\mathrm{free}}_{\mathit{dataidx}}({\mathit{dataidx}}) \\
{\mathrm{free}}_{\mathit{instr}}(\mathsf{data{.}drop}~{\mathit{dataidx}}) &=& {\mathrm{free}}_{\mathit{dataidx}}({\mathit{dataidx}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{shift}}_{\mathit{labelidxs}}(\epsilon) &=& \epsilon \\
{\mathrm{shift}}_{\mathit{labelidxs}}(0~{{\mathit{labelidx}'}^\ast}) &=& {\mathrm{shift}}_{\mathit{labelidxs}}({{\mathit{labelidx}'}^\ast}) \\
{\mathrm{shift}}_{\mathit{labelidxs}}({\mathit{labelidx}}~{{\mathit{labelidx}'}^\ast}) &=& ({\mathit{labelidx}} - 1)~{\mathrm{shift}}_{\mathit{labelidxs}}({{\mathit{labelidx}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{block}}({{\mathit{instr}}^\ast}) &=& {\mathit{free}}{}[{.}\mathsf{labels} = {\mathrm{shift}}_{\mathit{labelidxs}}({\mathit{free}}{.}\mathsf{labels})]
  &\qquad \mbox{if}~{\mathit{free}} = {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{instr}}({\mathit{instr}})^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{expr}}({{\mathit{instr}}^\ast}) &=& {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{instr}}({\mathit{instr}})^\ast}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{type}}(\mathsf{type}~{\mathit{rectype}}) &=& {\mathrm{free}}_{\mathit{rectype}}({\mathit{rectype}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{local}}(\mathsf{local}~t) &=& {\mathrm{free}}_{\mathit{valtype}}(t) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{func}}(\mathsf{func}~{\mathit{typeidx}}~{{\mathit{local}}^\ast}~{\mathit{expr}}) &=& {\mathrm{free}}_{\mathit{typeidx}}({\mathit{typeidx}}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{local}}({\mathit{local}})^\ast}) \oplus {\mathrm{free}}_{\mathit{block}}({\mathit{expr}}){}[{.}\mathsf{locals} = \epsilon] \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{global}}(\mathsf{global}~{\mathit{globaltype}}~{\mathit{expr}}) &=& {\mathrm{free}}_{\mathit{globaltype}}({\mathit{globaltype}}) \oplus {\mathrm{free}}_{\mathit{expr}}({\mathit{expr}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{table}}(\mathsf{table}~{\mathit{tabletype}}~{\mathit{expr}}) &=& {\mathrm{free}}_{\mathit{tabletype}}({\mathit{tabletype}}) \oplus {\mathrm{free}}_{\mathit{expr}}({\mathit{expr}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{mem}}(\mathsf{memory}~{\mathit{memtype}}) &=& {\mathrm{free}}_{\mathit{memtype}}({\mathit{memtype}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{elemmode}}(\mathsf{active}~{\mathit{tableidx}}~{\mathit{expr}}) &=& {\mathrm{free}}_{\mathit{tableidx}}({\mathit{tableidx}}) \oplus {\mathrm{free}}_{\mathit{expr}}({\mathit{expr}}) \\
{\mathrm{free}}_{\mathit{elemmode}}(\mathsf{passive}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
{\mathrm{free}}_{\mathit{elemmode}}(\mathsf{declare}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{datamode}}(\mathsf{active}~{\mathit{memidx}}~{\mathit{expr}}) &=& {\mathrm{free}}_{\mathit{memidx}}({\mathit{memidx}}) \oplus {\mathrm{free}}_{\mathit{expr}}({\mathit{expr}}) \\
{\mathrm{free}}_{\mathit{datamode}}(\mathsf{passive}) &=& \{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{elem}}(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}^\ast}~{\mathit{elemmode}}) &=& {\mathrm{free}}_{\mathit{reftype}}({\mathit{reftype}}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{expr}}({\mathit{expr}})^\ast}) \oplus {\mathrm{free}}_{\mathit{elemmode}}({\mathit{elemmode}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{data}}(\mathsf{data}~{{\mathit{byte}}^\ast}~{\mathit{datamode}}) &=& {\mathrm{free}}_{\mathit{datamode}}({\mathit{datamode}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{start}}(\mathsf{start}~{\mathit{funcidx}}) &=& {\mathrm{free}}_{\mathit{funcidx}}({\mathit{funcidx}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{export}}(\mathsf{export}~{\mathit{name}}~{\mathit{externidx}}) &=& {\mathrm{free}}_{\mathit{externidx}}({\mathit{externidx}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{import}}(\mathsf{import}~{\mathit{name}}_1~{\mathit{name}}_2~{\mathit{externtype}}) &=& {\mathrm{free}}_{\mathit{externtype}}({\mathit{externtype}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{\mathit{module}}(\mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast}) &=& {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{type}}({\mathit{type}})^\ast}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{import}}({\mathit{import}})^\ast}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{func}}({\mathit{func}})^\ast}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{global}}({\mathit{global}})^\ast}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{table}}({\mathit{table}})^\ast}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{mem}}({\mathit{mem}})^\ast}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{elem}}({\mathit{elem}})^\ast}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{data}}({\mathit{data}})^\ast}) \oplus {\mathrm{free}}_{\mathit{opt}}({{\mathrm{free}}_{\mathit{start}}({\mathit{start}})^?}) \oplus {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{export}}({\mathit{export}})^\ast}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{funcidx}}({\mathit{module}}) &=& {\mathrm{free}}_{\mathit{module}}({\mathit{module}}){.}\mathsf{funcs} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{dataidx}}({{\mathit{func}}^\ast}) &=& {\mathrm{free}}_{\mathit{list}}({{\mathrm{free}}_{\mathit{func}}({\mathit{func}})^\ast}){.}\mathsf{datas} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{tv}}}{{}[ \epsilon := \epsilon ]} &=& {\mathit{tv}} \\
{{\mathit{tv}}}{{}[ {\mathit{tv}}_1~{{\mathit{tv}'}^\ast} := {\mathit{tu}}_1~{{\mathit{tu}'}^\ast} ]} &=& {\mathit{tu}}_1
  &\qquad \mbox{if}~{\mathit{tv}} = {\mathit{tv}}_1 \\
{{\mathit{tv}}}{{}[ {\mathit{tv}}_1~{{\mathit{tv}'}^\ast} := {\mathit{tu}}_1~{{\mathit{tu}'}^\ast} ]} &=& {{\mathit{tv}}}{{}[ {{\mathit{tv}'}^\ast} := {{\mathit{tu}'}^\ast} ]}
  &\qquad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{tv}'}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {{\mathit{tv}'}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{{\mathit{dt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {{\mathit{dt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{nt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {\mathit{nt}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{vt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {\mathit{vt}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{tv}'}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {{\mathit{tv}'}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{{\mathit{dt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {{\mathit{dt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{{\mathit{ht}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {\mathit{ht}}
  &\qquad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{ref}~{\mathsf{null}^?}~{\mathit{ht}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& \mathsf{ref}~{\mathsf{null}^?}~{{\mathit{ht}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{nt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {{\mathit{nt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{{\mathit{vt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {{\mathit{vt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{{\mathit{rt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {{\mathit{rt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{\mathsf{bot}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& \mathsf{bot} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{pt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {\mathit{pt}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{t}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {t}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{{\mathit{pt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {{\mathit{pt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathsf{mut}^?}~{\mathit{zt}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {\mathsf{mut}^?}~{{\mathit{zt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{struct}~{{\mathit{yt}}^\ast})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& \mathsf{struct}~{{{\mathit{yt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]}^\ast} \\
{(\mathsf{array}~{\mathit{yt}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& \mathsf{array}~{{\mathit{yt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{(\mathsf{func}~{\mathit{ft}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& \mathsf{func}~{{\mathit{ft}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{sub}~{\mathsf{final}^?}~{{\mathit{tu}'}^\ast}~{\mathit{ct}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& \mathsf{sub}~{\mathsf{final}^?}~{{{\mathit{tu}'}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]}^\ast}~{{\mathit{ct}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{rec}~{{\mathit{st}}^\ast})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& \mathsf{rec}~{{{\mathit{st}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{qt}} {.} i)}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {{\mathit{qt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} {.} i \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathsf{mut}^?}~t)}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {\mathsf{mut}^?}~{t}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({t_1^\ast} \rightarrow {t_2^\ast})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {{t_1}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]}^\ast} \rightarrow {{t_2}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{lim}}~\mathsf{page})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {\mathit{lim}}~\mathsf{page} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{lim}}~{\mathit{rt}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {\mathit{lim}}~{{\mathit{rt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{func}~{\mathit{dt}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& \mathsf{func}~{{\mathit{dt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{(\mathsf{global}~{\mathit{gt}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& \mathsf{global}~{{\mathit{gt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{(\mathsf{table}~{\mathit{tt}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& \mathsf{table}~{{\mathit{tt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
{(\mathsf{mem}~{\mathit{mt}})}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& \mathsf{mem}~{{\mathit{mt}}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{\mathit{xt}}_1^\ast} \rightarrow {{\mathit{xt}}_2^\ast}}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]} &=& {{{\mathit{xt}}_1}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]}^\ast} \rightarrow {{{\mathit{xt}}_2}{{}[ {{\mathit{tv}}^\ast} := {{\mathit{tu}}^\ast} ]}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{t}{{}[ {:=}\, {{\mathit{tu}}^{n}} ]} &=& {t}{{}[ {i^{i<n}} := {{\mathit{tu}}^{n}} ]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{rt}}}{{}[ {:=}\, {{\mathit{tu}}^{n}} ]} &=& {{\mathit{rt}}}{{}[ {i^{i<n}} := {{\mathit{tu}}^{n}} ]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{dt}}}{{}[ {:=}\, {{\mathit{tu}}^{n}} ]} &=& {{\mathit{dt}}}{{}[ {i^{i<n}} := {{\mathit{tu}}^{n}} ]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{mmt}}}{{}[ {:=}\, {{\mathit{tu}}^{n}} ]} &=& {{\mathit{mmt}}}{{}[ {i^{i<n}} := {{\mathit{tu}}^{n}} ]} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\epsilon}{{}[ {:=}\, {{\mathit{tu}}^\ast} ]} &=& \epsilon \\
{{\mathit{dt}}_1~{{\mathit{dt}}^\ast}}{{}[ {:=}\, {{\mathit{tu}}^\ast} ]} &=& {{\mathit{dt}}_1}{{}[ {:=}\, {{\mathit{tu}}^\ast} ]}~{{{\mathit{dt}}^\ast}}{{}[ {:=}\, {{\mathit{tu}}^\ast} ]} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{roll}}}_{x}({\mathit{rectype}}) &=& \mathsf{rec}~{({{\mathit{subtype}}}{{}[ {(x + i)^{i<n}} := {(\mathsf{rec}~i)^{i<n}} ]})^{n}}
  &\qquad \mbox{if}~{\mathit{rectype}} = \mathsf{rec}~{{\mathit{subtype}}^{n}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unroll}}({\mathit{rectype}}) &=& \mathsf{rec}~{({{\mathit{subtype}}}{{}[ {(\mathsf{rec}~i)^{i<n}} := {({\mathit{rectype}} {.} i)^{i<n}} ]})^{n}}
  &\qquad \mbox{if}~{\mathit{rectype}} = \mathsf{rec}~{{\mathit{subtype}}^{n}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{{\mathrm{roll}}}_{x}^\ast}}{({\mathit{rectype}})} &=& {((\mathsf{rec}~{{\mathit{subtype}}^{n}}) {.} i)^{i<n}}
  &\qquad \mbox{if}~{{\mathrm{roll}}}_{x}({\mathit{rectype}}) = \mathsf{rec}~{{\mathit{subtype}}^{n}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unroll}}({\mathit{rectype}} {.} i) &=& {{\mathit{subtype}}^\ast}{}[i]
  &\qquad \mbox{if}~{\mathrm{unroll}}({\mathit{rectype}}) = \mathsf{rec}~{{\mathit{subtype}}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{expand}}({\mathit{deftype}}) &=& {\mathit{comptype}}
  &\qquad \mbox{if}~{\mathrm{unroll}}({\mathit{deftype}}) = \mathsf{sub}~{\mathsf{final}^?}~{{\mathit{typeuse}}^\ast}~{\mathit{comptype}} \\
\end{array}
$$

$\boxed{{\mathit{deftype}} \approx {\mathit{comptype}}}$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize Expand}]} \quad & {\mathit{deftype}} &\approx& {\mathit{comptype}}
  &\qquad \mbox{if}~{\mathrm{unroll}}({\mathit{deftype}}) = \mathsf{sub}~{\mathsf{final}^?}~{{\mathit{typeuse}}^\ast}~{\mathit{comptype}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{funcs}}(\epsilon) &=& \epsilon \\
{\mathrm{funcs}}((\mathsf{func}~x)~{{\mathit{xx}}^\ast}) &=& x~{\mathrm{funcs}}({{\mathit{xx}}^\ast}) \\
{\mathrm{funcs}}({\mathit{externidx}}~{{\mathit{xx}}^\ast}) &=& {\mathrm{funcs}}({{\mathit{xx}}^\ast})
  &\qquad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{globals}}(\epsilon) &=& \epsilon \\
{\mathrm{globals}}((\mathsf{global}~x)~{{\mathit{xx}}^\ast}) &=& x~{\mathrm{globals}}({{\mathit{xx}}^\ast}) \\
{\mathrm{globals}}({\mathit{externidx}}~{{\mathit{xx}}^\ast}) &=& {\mathrm{globals}}({{\mathit{xx}}^\ast})
  &\qquad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{tables}}(\epsilon) &=& \epsilon \\
{\mathrm{tables}}((\mathsf{table}~x)~{{\mathit{xx}}^\ast}) &=& x~{\mathrm{tables}}({{\mathit{xx}}^\ast}) \\
{\mathrm{tables}}({\mathit{externidx}}~{{\mathit{xx}}^\ast}) &=& {\mathrm{tables}}({{\mathit{xx}}^\ast})
  &\qquad \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{mems}}(\epsilon) &=& \epsilon \\
{\mathrm{mems}}((\mathsf{mem}~x)~{{\mathit{xx}}^\ast}) &=& x~{\mathrm{mems}}({{\mathit{xx}}^\ast}) \\
{\mathrm{mems}}({\mathit{externidx}}~{{\mathit{xx}}^\ast}) &=& {\mathrm{mems}}({{\mathit{xx}}^\ast})
  &\qquad \mbox{otherwise} \\
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
{{\mathrm{signed}}}_{N}(i) &=& i
  &\qquad \mbox{if}~0 \leq {2^{N - 1}} \\
{{\mathrm{signed}}}_{N}(i) &=& i - {2^{N}}
  &\qquad \mbox{if}~{2^{N - 1}} \leq i < {2^{N}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{{\mathrm{signed}}}_{N}^{{-1}}}}{(i)} &=& j
  &\qquad \mbox{if}~{{\mathrm{signed}}}_{N}(j) = i \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{{{\mathrm{bytes}}}_{{\mathsf{i}}{N}}^{{-1}}}}{({b^\ast})} &=& n
  &\qquad \mbox{if}~{{\mathrm{bytes}}}_{{\mathsf{i}}{N}}(n) = {b^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{{\mathrm{bytes}}}_{{\mathsf{f}}{N}}^{{-1}}}}{({b^\ast})} &=& p
  &\qquad \mbox{if}~{{\mathrm{bytes}}}_{{\mathsf{f}}{N}}(p) = {b^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{add}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}}_1, {\mathit{iN}}_2)} &=& {{\mathrm{iadd}}}_{N}({\mathit{iN}}_1, {\mathit{iN}}_2) \\
{\mathsf{sub}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}}_1, {\mathit{iN}}_2)} &=& {{\mathrm{isub}}}_{N}({\mathit{iN}}_1, {\mathit{iN}}_2) \\
{\mathsf{mul}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}}_1, {\mathit{iN}}_2)} &=& {{\mathrm{imul}}}_{N}({\mathit{iN}}_1, {\mathit{iN}}_2) \\
{{\mathsf{div}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}}_1, {\mathit{iN}}_2)} &=& {{{{\mathrm{idiv}}}_{N}^{{\mathit{sx}}}}}{({\mathit{iN}}_1, {\mathit{iN}}_2)} \\
{{\mathsf{rem}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}}_1, {\mathit{iN}}_2)} &=& {{{{\mathrm{irem}}}_{N}^{{\mathit{sx}}}}}{({\mathit{iN}}_1, {\mathit{iN}}_2)} \\
{\mathsf{and}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}}_1, {\mathit{iN}}_2)} &=& {{\mathrm{iand}}}_{N}({\mathit{iN}}_1, {\mathit{iN}}_2) \\
{\mathsf{or}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}}_1, {\mathit{iN}}_2)} &=& {{\mathrm{ior}}}_{N}({\mathit{iN}}_1, {\mathit{iN}}_2) \\
{\mathsf{xor}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}}_1, {\mathit{iN}}_2)} &=& {{\mathrm{ixor}}}_{N}({\mathit{iN}}_1, {\mathit{iN}}_2) \\
{\mathsf{shl}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}}_1, {\mathit{iN}}_2)} &=& {{\mathrm{ishl}}}_{N}({\mathit{iN}}_1, {\mathit{iN}}_2) \\
{{\mathsf{shr}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}}_1, {\mathit{iN}}_2)} &=& {{{{\mathrm{ishr}}}_{N}^{{\mathit{sx}}}}}{({\mathit{iN}}_1, {\mathit{iN}}_2)} \\
{\mathsf{rotl}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}}_1, {\mathit{iN}}_2)} &=& {{\mathrm{irotl}}}_{N}({\mathit{iN}}_1, {\mathit{iN}}_2) \\
{\mathsf{rotr}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}}_1, {\mathit{iN}}_2)} &=& {{\mathrm{irotr}}}_{N}({\mathit{iN}}_1, {\mathit{iN}}_2) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{clz}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}})} &=& {{\mathrm{iclz}}}_{N}({\mathit{iN}}) \\
{\mathsf{ctz}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}})} &=& {{\mathrm{ictz}}}_{N}({\mathit{iN}}) \\
{\mathsf{popcnt}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}})} &=& {{\mathrm{ipopcnt}}}_{N}({\mathit{iN}}) \\
{{\mathsf{extend}}{M}{\mathsf{\_}}{\mathsf{s}}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}})} &=& {{{{\mathrm{extend}}}_{M, N}^{\mathsf{s}}}}{({{\mathrm{wrap}}}_{N, M}({\mathit{iN}}))} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{eqz}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}})} &=& {{\mathrm{ieqz}}}_{N}({\mathit{iN}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{eq}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}}_1, {\mathit{iN}}_2)} &=& {{\mathrm{ieq}}}_{N}({\mathit{iN}}_1, {\mathit{iN}}_2) \\
{\mathsf{ne}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}}_1, {\mathit{iN}}_2)} &=& {{\mathrm{ine}}}_{N}({\mathit{iN}}_1, {\mathit{iN}}_2) \\
{{\mathsf{lt}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}}_1, {\mathit{iN}}_2)} &=& {{{{\mathrm{ilt}}}_{N}^{{\mathit{sx}}}}}{({\mathit{iN}}_1, {\mathit{iN}}_2)} \\
{{\mathsf{gt}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}}_1, {\mathit{iN}}_2)} &=& {{{{\mathrm{igt}}}_{N}^{{\mathit{sx}}}}}{({\mathit{iN}}_1, {\mathit{iN}}_2)} \\
{{\mathsf{le}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}}_1, {\mathit{iN}}_2)} &=& {{{{\mathrm{ile}}}_{N}^{{\mathit{sx}}}}}{({\mathit{iN}}_1, {\mathit{iN}}_2)} \\
{{\mathsf{ge}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{\mathsf{i}}{N}}({\mathit{iN}}_1, {\mathit{iN}}_2)} &=& {{{{\mathrm{ige}}}_{N}^{{\mathit{sx}}}}}{({\mathit{iN}}_1, {\mathit{iN}}_2)} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{add}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}}_1, {\mathit{fN}}_2)} &=& {{\mathrm{fadd}}}_{N}({\mathit{fN}}_1, {\mathit{fN}}_2) \\
{\mathsf{sub}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}}_1, {\mathit{fN}}_2)} &=& {{\mathrm{fsub}}}_{N}({\mathit{fN}}_1, {\mathit{fN}}_2) \\
{\mathsf{mul}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}}_1, {\mathit{fN}}_2)} &=& {{\mathrm{fmul}}}_{N}({\mathit{fN}}_1, {\mathit{fN}}_2) \\
{\mathsf{div}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}}_1, {\mathit{fN}}_2)} &=& {{\mathrm{fdiv}}}_{N}({\mathit{fN}}_1, {\mathit{fN}}_2) \\
{\mathsf{min}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}}_1, {\mathit{fN}}_2)} &=& {{\mathrm{fmin}}}_{N}({\mathit{fN}}_1, {\mathit{fN}}_2) \\
{\mathsf{max}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}}_1, {\mathit{fN}}_2)} &=& {{\mathrm{fmax}}}_{N}({\mathit{fN}}_1, {\mathit{fN}}_2) \\
{\mathsf{copysign}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}}_1, {\mathit{fN}}_2)} &=& {{\mathrm{fcopysign}}}_{N}({\mathit{fN}}_1, {\mathit{fN}}_2) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{abs}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}})} &=& {{\mathrm{fabs}}}_{N}({\mathit{fN}}) \\
{\mathsf{neg}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}})} &=& {{\mathrm{fneg}}}_{N}({\mathit{fN}}) \\
{\mathsf{sqrt}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}})} &=& {{\mathrm{fsqrt}}}_{N}({\mathit{fN}}) \\
{\mathsf{ceil}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}})} &=& {{\mathrm{fceil}}}_{N}({\mathit{fN}}) \\
{\mathsf{floor}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}})} &=& {{\mathrm{ffloor}}}_{N}({\mathit{fN}}) \\
{\mathsf{trunc}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}})} &=& {{\mathrm{ftrunc}}}_{N}({\mathit{fN}}) \\
{\mathsf{nearest}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}})} &=& {{\mathrm{fnearest}}}_{N}({\mathit{fN}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{eq}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}}_1, {\mathit{fN}}_2)} &=& {{\mathrm{feq}}}_{N}({\mathit{fN}}_1, {\mathit{fN}}_2) \\
{\mathsf{ne}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}}_1, {\mathit{fN}}_2)} &=& {{\mathrm{fne}}}_{N}({\mathit{fN}}_1, {\mathit{fN}}_2) \\
{\mathsf{lt}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}}_1, {\mathit{fN}}_2)} &=& {{\mathrm{flt}}}_{N}({\mathit{fN}}_1, {\mathit{fN}}_2) \\
{\mathsf{gt}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}}_1, {\mathit{fN}}_2)} &=& {{\mathrm{fgt}}}_{N}({\mathit{fN}}_1, {\mathit{fN}}_2) \\
{\mathsf{le}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}}_1, {\mathit{fN}}_2)} &=& {{\mathrm{fle}}}_{N}({\mathit{fN}}_1, {\mathit{fN}}_2) \\
{\mathsf{ge}}{{}_{{\mathsf{f}}{N}}({\mathit{fN}}_1, {\mathit{fN}}_2)} &=& {{\mathrm{fge}}}_{N}({\mathit{fN}}_1, {\mathit{fN}}_2) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{extend}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}_1, {{\mathsf{i}}{N}}_2}({\mathit{iN}}_1)} &=& {{{{\mathrm{extend}}}_{N_1, N_2}^{{\mathit{sx}}}}}{({\mathit{iN}}_1)} \\
{\mathsf{wrap}}{{}_{{{\mathsf{i}}{N}}_1, {{\mathsf{i}}{N}}_2}({\mathit{iN}}_1)} &=& {{\mathrm{wrap}}}_{N_1, N_2}({\mathit{iN}}_1) \\
{{\mathsf{trunc}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{f}}{N}}_1, {{\mathsf{i}}{N}}_2}({\mathit{fN}}_1)} &=& {{{{\mathrm{trunc}}}_{N_1, N_2}^{{\mathit{sx}}}}}{({\mathit{fN}}_1)} \\
{{\mathsf{trunc\_sat}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{f}}{N}}_1, {{\mathsf{i}}{N}}_2}({\mathit{fN}}_1)} &=& {{{{\mathrm{trunc\_sat}}}_{N_1, N_2}^{{\mathit{sx}}}}}{({\mathit{fN}}_1)} \\
{{\mathsf{convert}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}_1, {{\mathsf{f}}{N}}_2}({\mathit{iN}}_1)} &=& {{{{\mathrm{convert}}}_{N_1, N_2}^{{\mathit{sx}}}}}{({\mathit{iN}}_1)} \\
{\mathsf{promote}}{{}_{{{\mathsf{f}}{N}}_1, {{\mathsf{f}}{N}}_2}({\mathit{fN}}_1)} &=& {{\mathrm{promote}}}_{N_1, N_2}({\mathit{fN}}_1) \\
{\mathsf{demote}}{{}_{{{\mathsf{f}}{N}}_1, {{\mathsf{f}}{N}}_2}({\mathit{fN}}_1)} &=& {{\mathrm{demote}}}_{N_1, N_2}({\mathit{fN}}_1) \\
{\mathsf{reinterpret}}{{}_{{{\mathsf{i}}{N}}_1, {{\mathsf{f}}{N}}_2}({\mathit{iN}}_1)} &=& {{\mathrm{reinterpret}}}_{{{\mathsf{i}}{N}}_1, {{\mathsf{f}}{N}}_2}({\mathit{iN}}_1)
  &\qquad \mbox{if}~{|{{\mathsf{i}}{N}}_1|} = {|{{\mathsf{f}}{N}}_2|} \\
{\mathsf{reinterpret}}{{}_{{{\mathsf{f}}{N}}_1, {{\mathsf{i}}{N}}_2}({\mathit{fN}}_1)} &=& {{\mathrm{reinterpret}}}_{{{\mathsf{f}}{N}}_1, {{\mathsf{i}}{N}}_2}({\mathit{fN}}_1)
  &\qquad \mbox{if}~{|{{\mathsf{f}}{N}}_1|} = {|{{\mathsf{i}}{N}}_2|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{pack}}}_{{\mathit{numtype}}}(c) &=& c \\
{{\mathrm{pack}}}_{{\mathit{packtype}}}(c) &=& {{\mathrm{wrap}}}_{{|{\mathrm{unpack}}({\mathit{packtype}})|}, {|{\mathit{packtype}}|}}(c) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{unpack}}}_{{\mathit{numtype}}}(c) &=& c \\
{{\mathrm{unpack}}}_{{\mathit{packtype}}}(c) &=& {{{{\mathrm{extend}}}_{{|{\mathit{packtype}}|}, {|{\mathrm{unpack}}({\mathit{packtype}})|}}^{\mathsf{u}}}}{(c)} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{pack}}}_{{\mathit{consttype}}}(c) &=& c \\
{{\mathrm{pack}}}_{{\mathit{packtype}}}(c) &=& {{\mathrm{wrap}}}_{{|{\mathrm{unpack}}({\mathit{packtype}})|}, {|{\mathit{packtype}}|}}(c) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{unpack}}}_{{\mathit{consttype}}}(c) &=& c \\
{{\mathrm{unpack}}}_{{\mathit{packtype}}}(c) &=& {{{{\mathrm{extend}}}_{{|{\mathit{packtype}}|}, {|{\mathrm{unpack}}({\mathit{packtype}})|}}^{\mathsf{u}}}}{(c)} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{{{\mathrm{lanes}}}_{{\mathit{sh}}}^{{-1}}}}{({c^\ast})} &=& {\mathit{vc}}
  &\qquad \mbox{if}~{c^\ast} = {{\mathrm{lanes}}}_{{\mathit{sh}}}({\mathit{vc}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{half}}(\mathsf{low}, i, j) &=& i \\
{\mathrm{half}}(\mathsf{high}, i, j) &=& j \\
{\mathrm{half}}(\mathsf{low}, i, j) &=& i \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{not}}{{}_{\mathsf{v{\scriptstyle 128}}}({\mathit{v{\kern-0.1em\scriptstyle 128}}})} &=& {{\mathrm{inot}}}_{{|\mathsf{v{\scriptstyle 128}}|}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{and}}{{}_{\mathsf{v{\scriptstyle 128}}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {{\mathrm{iand}}}_{{|\mathsf{v{\scriptstyle 128}}|}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
{\mathsf{andnot}}{{}_{\mathsf{v{\scriptstyle 128}}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {{\mathrm{iandnot}}}_{{|\mathsf{v{\scriptstyle 128}}|}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
{\mathsf{or}}{{}_{\mathsf{v{\scriptstyle 128}}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {{\mathrm{ior}}}_{{|\mathsf{v{\scriptstyle 128}}|}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
{\mathsf{xor}}{{}_{\mathsf{v{\scriptstyle 128}}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {{\mathrm{ixor}}}_{{|\mathsf{v{\scriptstyle 128}}|}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{bitselect}}{{}_{\mathsf{v{\scriptstyle 128}}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_3)} &=& {{\mathrm{ibitselect}}}_{{|\mathsf{v{\scriptstyle 128}}|}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_3) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{abs}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{{\mathrm{iabs}}}_{N}({\mathit{lane}}_1)^\ast})} \\
{\mathsf{neg}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{{\mathrm{ineg}}}_{N}({\mathit{lane}}_1)^\ast})} \\
{\mathsf{popcnt}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{{\mathrm{ipopcnt}}}_{N}({\mathit{lane}}_1)^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{add}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{{\mathrm{iadd}}}_{N}({\mathit{lane}}_1, {\mathit{lane}}_2)^\ast})} \\
{\mathsf{sub}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{{\mathrm{isub}}}_{N}({\mathit{lane}}_1, {\mathit{lane}}_2)^\ast})} \\
{{\mathsf{min}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{{\mathrm{imin}}}_{N}({\mathit{sx}}, {\mathit{lane}}_1, {\mathit{lane}}_2)^\ast})} \\
{{\mathsf{max}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{{\mathrm{imax}}}_{N}({\mathit{sx}}, {\mathit{lane}}_1, {\mathit{lane}}_2)^\ast})} \\
{{\mathsf{add\_sat}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{{{{\mathrm{iadd\_sat}}}_{N}^{{\mathit{sx}}}}}{({\mathit{lane}}_1, {\mathit{lane}}_2)}^\ast})} \\
{{\mathsf{sub\_sat}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{{{{\mathrm{isub\_sat}}}_{N}^{{\mathit{sx}}}}}{({\mathit{lane}}_1, {\mathit{lane}}_2)}^\ast})} \\
{\mathsf{mul}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{{\mathrm{imul}}}_{N}({\mathit{lane}}_1, {\mathit{lane}}_2)^\ast})} \\
{{\mathsf{avgr}}{\mathsf{\_}}{\mathsf{u}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{{{{\mathrm{iavgr}}}_{N}^{\mathsf{u}}}}{({\mathit{lane}}_1, {\mathit{lane}}_2)}^\ast})} \\
{{\mathsf{q{\scriptstyle 15}mulr\_sat}}{\mathsf{\_}}{\mathsf{s}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{{{{\mathrm{iq{\kern-0.1em\scriptstyle 15\kern-0.1em}mulr\_sat}}}_{N}^{\mathsf{s}}}}{({\mathit{lane}}_1, {\mathit{lane}}_2)}^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{eq}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{\mathit{lane}}^\ast} = {{{{{\mathrm{extend}}}_{1, N}^{\mathsf{s}}}}{({{\mathrm{ieq}}}_{N}({\mathit{lane}}_1, {\mathit{lane}}_2))}^\ast} \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})} \\
{\mathsf{ne}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{\mathit{lane}}^\ast} = {{{{{\mathrm{extend}}}_{1, N}^{\mathsf{s}}}}{({{\mathrm{ine}}}_{N}({\mathit{lane}}_1, {\mathit{lane}}_2))}^\ast} \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})} \\
{{\mathsf{lt}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{\mathit{lane}}^\ast} = {{{{{\mathrm{extend}}}_{1, N}^{\mathsf{s}}}}{({{{{\mathrm{ilt}}}_{N}^{{\mathit{sx}}}}}{({\mathit{lane}}_1, {\mathit{lane}}_2)})}^\ast} \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})} \\
{{\mathsf{gt}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{\mathit{lane}}^\ast} = {{{{{\mathrm{extend}}}_{1, N}^{\mathsf{s}}}}{({{{{\mathrm{igt}}}_{N}^{{\mathit{sx}}}}}{({\mathit{lane}}_1, {\mathit{lane}}_2)})}^\ast} \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})} \\
{{\mathsf{le}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{\mathit{lane}}^\ast} = {{{{{\mathrm{extend}}}_{1, N}^{\mathsf{s}}}}{({{{{\mathrm{ile}}}_{N}^{{\mathit{sx}}}}}{({\mathit{lane}}_1, {\mathit{lane}}_2)})}^\ast} \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})} \\
{{\mathsf{ge}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{\mathit{lane}}^\ast} = {{{{{\mathrm{extend}}}_{1, N}^{\mathsf{s}}}}{({{{{\mathrm{ige}}}_{N}^{{\mathit{sx}}}}}{({\mathit{lane}}_1, {\mathit{lane}}_2)})}^\ast} \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{abs}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1)} &=& {{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{{\mathit{lane}}^\ast}^\ast} = \Large\times~{{{\mathrm{fabs}}}_{N}({\mathit{lane}}_1)^\ast} \\
  &&&\qquad {\land}~{{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast} = {{{{{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})}^\ast} \\
{\mathsf{neg}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1)} &=& {{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{{\mathit{lane}}^\ast}^\ast} = \Large\times~{{{\mathrm{fneg}}}_{N}({\mathit{lane}}_1)^\ast} \\
  &&&\qquad {\land}~{{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast} = {{{{{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})}^\ast} \\
{\mathsf{sqrt}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1)} &=& {{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{{\mathit{lane}}^\ast}^\ast} = \Large\times~{{{\mathrm{fsqrt}}}_{N}({\mathit{lane}}_1)^\ast} \\
  &&&\qquad {\land}~{{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast} = {{{{{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})}^\ast} \\
{\mathsf{ceil}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1)} &=& {{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{{\mathit{lane}}^\ast}^\ast} = \Large\times~{{{\mathrm{fceil}}}_{N}({\mathit{lane}}_1)^\ast} \\
  &&&\qquad {\land}~{{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast} = {{{{{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})}^\ast} \\
{\mathsf{floor}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1)} &=& {{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{{\mathit{lane}}^\ast}^\ast} = \Large\times~{{{\mathrm{ffloor}}}_{N}({\mathit{lane}}_1)^\ast} \\
  &&&\qquad {\land}~{{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast} = {{{{{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})}^\ast} \\
{\mathsf{trunc}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1)} &=& {{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{{\mathit{lane}}^\ast}^\ast} = \Large\times~{{{\mathrm{ftrunc}}}_{N}({\mathit{lane}}_1)^\ast} \\
  &&&\qquad {\land}~{{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast} = {{{{{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})}^\ast} \\
{\mathsf{nearest}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1)} &=& {{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{{\mathit{lane}}^\ast}^\ast} = \Large\times~{{{\mathrm{fnearest}}}_{N}({\mathit{lane}}_1)^\ast} \\
  &&&\qquad {\land}~{{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast} = {{{{{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{add}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{{\mathit{lane}}^\ast}^\ast} = \Large\times~{{{\mathrm{fadd}}}_{N}({\mathit{lane}}_1, {\mathit{lane}}_2)^\ast} \\
  &&&\qquad {\land}~{{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast} = {{{{{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})}^\ast} \\
{\mathsf{sub}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{{\mathit{lane}}^\ast}^\ast} = \Large\times~{{{\mathrm{fsub}}}_{N}({\mathit{lane}}_1, {\mathit{lane}}_2)^\ast} \\
  &&&\qquad {\land}~{{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast} = {{{{{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})}^\ast} \\
{\mathsf{mul}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{{\mathit{lane}}^\ast}^\ast} = \Large\times~{{{\mathrm{fmul}}}_{N}({\mathit{lane}}_1, {\mathit{lane}}_2)^\ast} \\
  &&&\qquad {\land}~{{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast} = {{{{{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})}^\ast} \\
{\mathsf{div}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{{\mathit{lane}}^\ast}^\ast} = \Large\times~{{{\mathrm{fdiv}}}_{N}({\mathit{lane}}_1, {\mathit{lane}}_2)^\ast} \\
  &&&\qquad {\land}~{{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast} = {{{{{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})}^\ast} \\
{\mathsf{min}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{{\mathit{lane}}^\ast}^\ast} = \Large\times~{{{\mathrm{fmin}}}_{N}({\mathit{lane}}_1, {\mathit{lane}}_2)^\ast} \\
  &&&\qquad {\land}~{{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast} = {{{{{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})}^\ast} \\
{\mathsf{max}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{{\mathit{lane}}^\ast}^\ast} = \Large\times~{{{\mathrm{fmax}}}_{N}({\mathit{lane}}_1, {\mathit{lane}}_2)^\ast} \\
  &&&\qquad {\land}~{{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast} = {{{{{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})}^\ast} \\
{\mathsf{pmin}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{{\mathit{lane}}^\ast}^\ast} = \Large\times~{{{\mathrm{fpmin}}}_{N}({\mathit{lane}}_1, {\mathit{lane}}_2)^\ast} \\
  &&&\qquad {\land}~{{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast} = {{{{{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})}^\ast} \\
{\mathsf{pmax}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{{\mathit{lane}}^\ast}^\ast} = \Large\times~{{{\mathrm{fpmax}}}_{N}({\mathit{lane}}_1, {\mathit{lane}}_2)^\ast} \\
  &&&\qquad {\land}~{{\mathit{v{\kern-0.1em\scriptstyle 128}}}^\ast} = {{{{{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{eq}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{\mathit{lane}}^\ast} = {{{{{\mathrm{extend}}}_{1, N}^{\mathsf{s}}}}{({{\mathrm{feq}}}_{N}({\mathit{lane}}_1, {\mathit{lane}}_2))}^\ast} \\
  &&&\qquad {\land}~{|{\mathsf{i}}{N}|} = {|{\mathsf{f}}{N}|} \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})} \\
{\mathsf{ne}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{\mathit{lane}}^\ast} = {{{{{\mathrm{extend}}}_{1, N}^{\mathsf{s}}}}{({{\mathrm{fne}}}_{N}({\mathit{lane}}_1, {\mathit{lane}}_2))}^\ast} \\
  &&&\qquad {\land}~{|{\mathsf{i}}{N}|} = {|{\mathsf{f}}{N}|} \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})} \\
{\mathsf{lt}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{\mathit{lane}}^\ast} = {{{{{\mathrm{extend}}}_{1, N}^{\mathsf{s}}}}{({{\mathrm{flt}}}_{N}({\mathit{lane}}_1, {\mathit{lane}}_2))}^\ast} \\
  &&&\qquad {\land}~{|{\mathsf{i}}{N}|} = {|{\mathsf{f}}{N}|} \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})} \\
{\mathsf{gt}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{\mathit{lane}}^\ast} = {{{{{\mathrm{extend}}}_{1, N}^{\mathsf{s}}}}{({{\mathrm{fgt}}}_{N}({\mathit{lane}}_1, {\mathit{lane}}_2))}^\ast} \\
  &&&\qquad {\land}~{|{\mathsf{i}}{N}|} = {|{\mathsf{f}}{N}|} \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})} \\
{\mathsf{le}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{\mathit{lane}}^\ast} = {{{{{\mathrm{extend}}}_{1, N}^{\mathsf{s}}}}{({{\mathrm{fle}}}_{N}({\mathit{lane}}_1, {\mathit{lane}}_2))}^\ast} \\
  &&&\qquad {\land}~{|{\mathsf{i}}{N}|} = {|{\mathsf{f}}{N}|} \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})} \\
{\mathsf{ge}}{{}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1, {\mathit{v{\kern-0.1em\scriptstyle 128}}}_2)} &=& {\mathit{v{\kern-0.1em\scriptstyle 128}}}
  &\qquad \mbox{if}~{{\mathit{lane}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_1) \\
  &&&\qquad {\land}~{{\mathit{lane}}_2^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{f}}{N}}{\mathsf{x}}{M}}({\mathit{v{\kern-0.1em\scriptstyle 128}}}_2) \\
  &&&\qquad {\land}~{{\mathit{lane}}^\ast} = {{{{{\mathrm{extend}}}_{1, N}^{\mathsf{s}}}}{({{\mathrm{fge}}}_{N}({\mathit{lane}}_1, {\mathit{lane}}_2))}^\ast} \\
  &&&\qquad {\land}~{|{\mathsf{i}}{N}|} = {|{\mathsf{f}}{N}|} \\
  &&&\qquad {\land}~{\mathit{v{\kern-0.1em\scriptstyle 128}}} = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{lane}}^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{vcvtop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}({\mathsf{extend}}{\mathsf{\_}}{{\mathit{sx}}}, {\mathit{iN}}_1) &=& {\mathit{iN}}_2
  &\qquad \mbox{if}~{\mathit{iN}}_2 = {{{{\mathrm{extend}}}_{N_1, N_2}^{{\mathit{sx}}}}}{({\mathit{iN}}_1)} \\
{{\mathrm{vcvtop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{f}}{N}}_2}{\mathsf{x}}{M_2}}({\mathsf{convert}}{\mathsf{\_}}{{\mathit{sx}}}, {\mathit{iN}}_1) &=& {\mathit{fN}}_2
  &\qquad \mbox{if}~{\mathit{fN}}_2 = {{{{\mathrm{convert}}}_{N_1, N_2}^{{\mathit{sx}}}}}{({\mathit{iN}}_1)} \\
{{\mathrm{vcvtop}}}_{{{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}({\mathsf{trunc\_sat}}{\mathsf{\_}}{{\mathit{sx}}}, {\mathit{fN}}_1) &=& {{\mathit{iN}}_2^?}
  &\qquad \mbox{if}~{{\mathit{iN}}_2^?} = {{{{\mathrm{trunc\_sat}}}_{N_1, N_2}^{{\mathit{sx}}}}}{({\mathit{fN}}_1)} \\
{{\mathrm{vcvtop}}}_{{{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{f}}{N}}_2}{\mathsf{x}}{M_2}}(\mathsf{demote}, {\mathit{fN}}_1) &=& {{\mathit{fN}}_2^\ast}
  &\qquad \mbox{if}~{{\mathit{fN}}_2^\ast} = {{\mathrm{demote}}}_{N_1, N_2}({\mathit{fN}}_1) \\
{{\mathrm{vcvtop}}}_{{{{\mathsf{f}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{f}}{N}}_2}{\mathsf{x}}{M_2}}(\mathsf{promote}, {\mathit{fN}}_1) &=& {{\mathit{fN}}_2^\ast}
  &\qquad \mbox{if}~{{\mathit{fN}}_2^\ast} = {{\mathrm{promote}}}_{N_1, N_2}({\mathit{fN}}_1) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{extadd\_pairwise}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}(c_1)} &=& c
  &\qquad \mbox{if}~{{\mathit{ci}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}}(c_1) \\
  &&&\qquad {\land}~{\bigoplus}\, {({\mathit{cj}}_1~{\mathit{cj}}_2)^\ast} = {{{{{\mathrm{extend}}}_{N_1, N_2}^{{\mathit{sx}}}}}{({\mathit{ci}})}^\ast} \\
  &&&\qquad {\land}~c = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}^{{-1}}}}{({{{\mathrm{iadd}}}_{N_2}({\mathit{cj}}_1, {\mathit{cj}}_2)^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathsf{extmul}}{\mathsf{\_}}{{\mathit{sx}}}{\mathsf{\_}}{{\mathit{half}}}}{{}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}(c_1, c_2)} &=& c
  &\qquad \mbox{if}~{{\mathit{ci}}_1^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}}(c_1){}[{\mathrm{half}}({\mathit{half}}, 0, M_2) : M_2] \\
  &&&\qquad {\land}~{{\mathit{ci}}_2^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}}(c_2){}[{\mathrm{half}}({\mathit{half}}, 0, M_2) : M_2] \\
  &&&\qquad {\land}~c = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}^{{-1}}}}{({{{\mathrm{imul}}}_{N_2}({{{{\mathrm{extend}}}_{N_1, N_2}^{{\mathit{sx}}}}}{({\mathit{ci}}_1)}, {{{{\mathrm{extend}}}_{N_1, N_2}^{{\mathit{sx}}}}}{({\mathit{ci}}_2)})^\ast})} \\
{{\mathsf{dot}}{\mathsf{\_}}{\mathsf{s}}}{{}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}(c_1, c_2)} &=& c
  &\qquad \mbox{if}~{{\mathit{ci}}_1^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}}(c_1) \\
  &&&\qquad {\land}~{{\mathit{ci}}_2^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}}(c_2) \\
  &&&\qquad {\land}~{\bigoplus}\, {({\mathit{cj}}_1~{\mathit{cj}}_2)^\ast} = {{{\mathrm{imul}}}_{N_2}({{{{\mathrm{extend}}}_{N_1, N_2}^{\mathsf{s}}}}{({\mathit{ci}}_1)}, {{{{\mathrm{extend}}}_{N_1, N_2}^{\mathsf{s}}}}{({\mathit{ci}}_2)})^\ast} \\
  &&&\qquad {\land}~c = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}^{{-1}}}}{({{{\mathrm{iadd}}}_{N_2}({\mathit{cj}}_1, {\mathit{cj}}_2)^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathsf{shl}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}}{({\mathit{lane}}, n)} &=& {{\mathrm{ishl}}}_{N}({\mathit{lane}}, n) \\
{{\mathsf{shr}}{\mathsf{\_}}{{\mathit{sx}}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}}{({\mathit{lane}}, n)} &=& {{{{\mathrm{ishr}}}_{N}^{{\mathit{sx}}}}}{({\mathit{lane}}, n)} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(address)} & {\mathit{addr}} &::=& \mathbb{N} \\
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
\mbox{(number value)} & {\mathit{num}} &::=& {\mathit{numtype}}{.}\mathsf{const}~{{\mathit{num}}}_{{\mathit{numtype}}} \\
\mbox{(vector value)} & {\mathit{vec}} &::=& {\mathit{vectype}}{.}\mathsf{const}~{{\mathit{vec}}}_{{\mathit{vectype}}} \\
\mbox{(address value)} & {\mathit{addrref}} &::=& \mathsf{ref{.}i{\scriptstyle 31}}~{\mathit{u{\kern-0.1em\scriptstyle 31}}} \\ &&|&
\mathsf{ref{.}struct}~{\mathit{structaddr}} \\ &&|&
\mathsf{ref{.}array}~{\mathit{arrayaddr}} \\ &&|&
\mathsf{ref{.}func}~{\mathit{funcaddr}} \\ &&|&
\mathsf{ref{.}host}~{\mathit{hostaddr}} \\ &&|&
\mathsf{ref{.}extern}~{\mathit{addrref}} \\
\mbox{(reference value)} & {\mathit{ref}} &::=& {\mathit{addrref}} \\ &&|&
\mathsf{ref{.}null}~{\mathit{heaptype}} \\
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
\mbox{(host function)} & {\mathit{hostfunc}} &::=& \ldots \\
& {\mathit{code}} &::=& {\mathit{func}} ~|~ {\mathit{hostfunc}} \\
\mbox{(function instance)} & {\mathit{funcinst}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{deftype}},\; \mathsf{module}~{\mathit{moduleinst}},\; \mathsf{code}~{\mathit{code}} \}\end{array} \\
\mbox{(global instance)} & {\mathit{globalinst}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{globaltype}},\; \mathsf{value}~{\mathit{val}} \}\end{array} \\
\mbox{(table instance)} & {\mathit{tableinst}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{tabletype}},\; \mathsf{refs}~{{\mathit{ref}}^\ast} \}\end{array} \\
\mbox{(memory instance)} & {\mathit{meminst}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{memtype}},\; \mathsf{bytes}~{{\mathit{byte}}^\ast} \}\end{array} \\
\mbox{(element instance)} & {\mathit{eleminst}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{elemtype}},\; \mathsf{refs}~{{\mathit{ref}}^\ast} \}\end{array} \\
\mbox{(data instance)} & {\mathit{datainst}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{bytes}~{{\mathit{byte}}^\ast} \}\end{array} \\
\mbox{(export instance)} & {\mathit{exportinst}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~{\mathit{externval}} \}\end{array} \\
\mbox{(packed value)} & {\mathit{packval}} &::=& {\mathit{packtype}}{.}\mathsf{pack}~{i}{N} \\
\mbox{(field value)} & {\mathit{fieldval}} &::=& {\mathit{val}} ~|~ {\mathit{packval}} \\
\mbox{(structure instance)} & {\mathit{structinst}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{deftype}},\; \mathsf{fields}~{{\mathit{fieldval}}^\ast} \}\end{array} \\
\mbox{(array instance)} & {\mathit{arrayinst}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{deftype}},\; \mathsf{fields}~{{\mathit{fieldval}}^\ast} \}\end{array} \\
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
\mathsf{locals}~{({{\mathit{val}}^?})^\ast},\; \mathsf{module}~{\mathit{moduleinst}} \}\end{array} \\
\mbox{(state)} & {\mathit{state}} &::=& {\mathit{store}} ; {\mathit{frame}} \\
\mbox{(configuration)} & {\mathit{config}} &::=& {\mathit{state}} ; {{\mathit{instr}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(instruction)} & {\mathit{instr}} &::=& \ldots \\ &&|&
{\mathit{addrref}} \\ &&|&
{{\mathsf{label}}_{n}}{\{ {{\mathit{instr}}^\ast} \}}~{{\mathit{instr}}^\ast} \\ &&|&
{{\mathsf{frame}}_{n}}{\{ {\mathit{frame}} \}}~{{\mathit{instr}}^\ast} \\ &&|&
\mathsf{trap} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{inst}}}_{{\mathit{moduleinst}}}(t) &=& {t}{{}[ {:=}\, {{\mathit{dt}}^\ast} ]}
  &\qquad \mbox{if}~{{\mathit{dt}}^\ast} = {\mathit{moduleinst}}{.}\mathsf{types} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{inst}}}_{{\mathit{moduleinst}}}({\mathit{rt}}) &=& {{\mathit{rt}}}{{}[ {:=}\, {{\mathit{dt}}^\ast} ]}
  &\qquad \mbox{if}~{{\mathit{dt}}^\ast} = {\mathit{moduleinst}}{.}\mathsf{types} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{default}}}_{{\mathsf{i}}{N}} &=& ({\mathsf{i}}{N}{.}\mathsf{const}~0) \\
{{\mathrm{default}}}_{{\mathsf{f}}{N}} &=& ({\mathsf{f}}{N}{.}\mathsf{const}~{+0}) \\
{{\mathrm{default}}}_{{\mathsf{v}}{N}} &=& ({\mathsf{v}}{N}{.}\mathsf{const}~0) \\
{{\mathrm{default}}}_{\mathsf{ref}~\mathsf{null}~{\mathit{ht}}} &=& (\mathsf{ref{.}null}~{\mathit{ht}}) \\
{{\mathrm{default}}}_{\mathsf{ref}~{\mathit{ht}}} &=& \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{pack}}}_{{\mathit{valtype}}}({\mathit{val}}) &=& {\mathit{val}} \\
{{\mathrm{pack}}}_{{\mathit{packtype}}}(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i) &=& {\mathit{packtype}}{.}\mathsf{pack}~{{\mathrm{wrap}}}_{32, {|{\mathit{packtype}}|}}(i) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{{\mathrm{unpack}}}_{{\mathit{valtype}}}^{\epsilon}}}{({\mathit{val}})} &=& {\mathit{val}} \\
{{{{\mathrm{unpack}}}_{{\mathit{packtype}}}^{{\mathit{sx}}}}}{({\mathit{packtype}}{.}\mathsf{pack}~i)} &=& \mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~{{{{\mathrm{extend}}}_{{|{\mathit{packtype}}|}, 32}^{{\mathit{sx}}}}}{(i)} \\
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
(s ; f){.}\mathsf{store} &=& s \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{frame} &=& f \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{module} &=& f{.}\mathsf{module} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{funcs} &=& s{.}\mathsf{funcs} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{globals} &=& s{.}\mathsf{globals} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{tables} &=& s{.}\mathsf{tables} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{mems} &=& s{.}\mathsf{mems} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{elems} &=& s{.}\mathsf{elems} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{datas} &=& s{.}\mathsf{datas} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{structs} &=& s{.}\mathsf{structs} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{arrays} &=& s{.}\mathsf{arrays} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{types}{}[x] &=& f{.}\mathsf{module}{.}\mathsf{types}{}[x] \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{funcs}{}[x] &=& s{.}\mathsf{funcs}{}[f{.}\mathsf{module}{.}\mathsf{funcs}{}[x]] \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{globals}{}[x] &=& s{.}\mathsf{globals}{}[f{.}\mathsf{module}{.}\mathsf{globals}{}[x]] \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{tables}{}[x] &=& s{.}\mathsf{tables}{}[f{.}\mathsf{module}{.}\mathsf{tables}{}[x]] \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{mems}{}[x] &=& s{.}\mathsf{mems}{}[f{.}\mathsf{module}{.}\mathsf{mems}{}[x]] \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{elems}{}[x] &=& s{.}\mathsf{elems}{}[f{.}\mathsf{module}{.}\mathsf{elems}{}[x]] \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{datas}{}[x] &=& s{.}\mathsf{datas}{}[f{.}\mathsf{module}{.}\mathsf{datas}{}[x]] \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){.}\mathsf{locals}{}[x] &=& f{.}\mathsf{locals}{}[x] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{locals}{}[x] = v] &=& s ; f{}[{.}\mathsf{locals}{}[x] = v] \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{globals}{}[x]{.}\mathsf{value} = v] &=& s{}[{.}\mathsf{globals}{}[f{.}\mathsf{module}{.}\mathsf{globals}{}[x]]{.}\mathsf{value} = v] ; f \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{tables}{}[x]{.}\mathsf{refs}{}[i] = r] &=& s{}[{.}\mathsf{tables}{}[f{.}\mathsf{module}{.}\mathsf{tables}{}[x]]{.}\mathsf{refs}{}[i] = r] ; f \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{tables}{}[x] = {\mathit{ti}}] &=& s{}[{.}\mathsf{tables}{}[f{.}\mathsf{module}{.}\mathsf{tables}{}[x]] = {\mathit{ti}}] ; f \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i : j] = {b^\ast}] &=& s{}[{.}\mathsf{mems}{}[f{.}\mathsf{module}{.}\mathsf{mems}{}[x]]{.}\mathsf{bytes}{}[i : j] = {b^\ast}] ; f \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{mems}{}[x] = {\mathit{mi}}] &=& s{}[{.}\mathsf{mems}{}[f{.}\mathsf{module}{.}\mathsf{mems}{}[x]] = {\mathit{mi}}] ; f \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{elems}{}[x]{.}\mathsf{refs} = {r^\ast}] &=& s{}[{.}\mathsf{elems}{}[f{.}\mathsf{module}{.}\mathsf{elems}{}[x]]{.}\mathsf{refs} = {r^\ast}] ; f \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{datas}{}[x]{.}\mathsf{bytes} = {b^\ast}] &=& s{}[{.}\mathsf{datas}{}[f{.}\mathsf{module}{.}\mathsf{datas}{}[x]]{.}\mathsf{bytes} = {b^\ast}] ; f \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{structs}{}[a]{.}\mathsf{fields}{}[i] = {\mathit{fv}}] &=& s{}[{.}\mathsf{structs}{}[a]{.}\mathsf{fields}{}[i] = {\mathit{fv}}] ; f \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}{}[i] = {\mathit{fv}}] &=& s{}[{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}{}[i] = {\mathit{fv}}] ; f \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{structs} \mathrel{{=}{\oplus}} {{\mathit{si}}^\ast}] &=& s{}[{.}\mathsf{structs} \mathrel{{=}{\oplus}} {{\mathit{si}}^\ast}] ; f \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
(s ; f){}[{.}\mathsf{arrays} \mathrel{{=}{\oplus}} {{\mathit{ai}}^\ast}] &=& s{}[{.}\mathsf{arrays} \mathrel{{=}{\oplus}} {{\mathit{ai}}^\ast}] ; f \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{growtable}}({\mathit{tableinst}}, n, r) &=& {\mathit{tableinst}'}
  &\qquad \mbox{if}~{\mathit{tableinst}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~({}[ i .. j ]~{\mathit{rt}}),\; \mathsf{refs}~{{r'}^\ast} \}\end{array} \\
  &&&\qquad {\land}~{\mathit{tableinst}'} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~({}[ {i'} .. j ]~{\mathit{rt}}),\; \mathsf{refs}~{{r'}^\ast}~{r^{n}} \}\end{array} \\
  &&&\qquad {\land}~{i'} = {|{{r'}^\ast}|} + n \leq j \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{growmem}}({\mathit{meminst}}, n) &=& {\mathit{meminst}'}
  &\qquad \mbox{if}~{\mathit{meminst}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~({}[ i .. j ]~\mathsf{page}),\; \mathsf{bytes}~{b^\ast} \}\end{array} \\
  &&&\qquad {\land}~{\mathit{meminst}'} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~({}[ {i'} .. j ]~\mathsf{page}),\; \mathsf{bytes}~{b^\ast}~{(\mathtt{0x00})^{n \cdot 64 \, {\mathrm{Ki}}}} \}\end{array} \\
  &&&\qquad {\land}~{i'} = {|{b^\ast}|} / (64 \, {\mathrm{Ki}}) + n \leq j \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(initialization status)} & {\mathit{init}} &::=& \mathsf{set} ~|~ \mathsf{unset} \\
\mbox{(local type)} & {\mathit{localtype}} &::=& {\mathit{init}}~{\mathit{valtype}} \\
\mbox{(instruction type)} & {\mathit{instrtype}} &::=& {\mathit{resulttype}} \rightarrow_{{{\mathit{localidx}}^\ast}} {\mathit{resulttype}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(context)} & {\mathit{context}} &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
\mathsf{types}~{{\mathit{deftype}}^\ast},\; \\
  \mathsf{recs}~{{\mathit{subtype}}^\ast},\; \\
  \mathsf{funcs}~{{\mathit{deftype}}^\ast},\; \\
  \mathsf{globals}~{{\mathit{globaltype}}^\ast},\; \\
  \mathsf{tables}~{{\mathit{tabletype}}^\ast},\; \\
  \mathsf{mems}~{{\mathit{memtype}}^\ast},\; \\
  \mathsf{elems}~{{\mathit{elemtype}}^\ast},\; \\
  \mathsf{datas}~{{\mathit{datatype}}^\ast},\; \\
  \mathsf{locals}~{{\mathit{localtype}}^\ast},\; \\
  \mathsf{labels}~{{\mathit{resulttype}}^\ast},\; \\
  \mathsf{return}~{{\mathit{resulttype}}^?},\; \\
  \mathsf{refs}~{{\mathit{funcidx}}^\ast} \}\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
C{}[{.}\mathsf{local}{}[\epsilon] = \epsilon] &=& C \\
C{}[{.}\mathsf{local}{}[x_1~{x^\ast}] = {{\mathit{lt}}}_1~{{{\mathit{lt}}}^\ast}] &=& C{}[{.}\mathsf{locals}{}[x_1] = {{\mathit{lt}}}_1]{}[{.}\mathsf{local}{}[{x^\ast}] = {{{\mathit{lt}}}^\ast}] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{clos}}}_{C}(t) &=& {t}{{}[ {:=}\, {{\mathit{dt}}^\ast} ]}
  &\qquad \mbox{if}~{{\mathit{dt}}^\ast} = {{{\mathrm{clos}}^\ast}}{(C{.}\mathsf{types})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{clos}}}_{C}({\mathit{dt}}) &=& {{\mathit{dt}}}{{}[ {:=}\, {{\mathit{dt}'}^\ast} ]}
  &\qquad \mbox{if}~{{\mathit{dt}'}^\ast} = {{{\mathrm{clos}}^\ast}}{(C{.}\mathsf{types})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{clos}}}_{C}({\mathit{mmt}}) &=& {{\mathit{mmt}}}{{}[ {:=}\, {{\mathit{dt}}^\ast} ]}
  &\qquad \mbox{if}~{{\mathit{dt}}^\ast} = {{{\mathrm{clos}}^\ast}}{(C{.}\mathsf{types})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{\mathrm{clos}}^\ast}}{(\epsilon)} &=& \epsilon \\
{{{\mathrm{clos}}^\ast}}{({{\mathit{dt}}^\ast}~{\mathit{dt}}_n)} &=& {{\mathit{dt}'}^\ast}~{{\mathit{dt}}_n}{{}[ {:=}\, {{\mathit{dt}'}^\ast} ]}
  &\qquad \mbox{if}~{{\mathit{dt}'}^\ast} = {{{\mathrm{clos}}^\ast}}{({{\mathit{dt}}^\ast})} \\
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
C{.}\mathsf{types}{}[{\mathit{typeidx}}] = {\mathit{dt}}
}{
C \vdash {\mathit{typeidx}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}heap{-}typeidx}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{recs}{}[i] = {\mathit{st}}
}{
C \vdash \mathsf{rec}~i : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}heap{-}rec}]}
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

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathsf{ok}}{({\mathit{typeidx}})} &::=& {\mathsf{ok}}{{\mathit{typeidx}}} \\
& {\mathsf{ok}}{({\mathit{typeidx}}, n)} &::=& {\mathsf{ok}}{({\mathit{typeidx}}, \mathbb{N})} \\
\end{array}
$$

$\boxed{{\mathit{context}} \vdash {\mathit{packtype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{fieldtype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{storagetype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{comptype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{functype}} : \mathsf{ok}}$

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
C \vdash {\mathit{functype}} : \mathsf{ok}
}{
C \vdash \mathsf{func}~{\mathit{functype}} : \mathsf{ok}
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
C \vdash \mathsf{sub}~{\mathsf{final}^?}~{{\mathit{typeidx}}^\ast}~{\mathit{comptype}} : {\mathsf{ok}}{(x_0)}
} \, {[\textsc{\scriptsize K{-}sub}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{deftype}} \prec x, i &=& \mathsf{true} \\
{\mathit{typeidx}} \prec x, i &=& {\mathit{typeidx}} < x \\
\mathsf{rec}~j \prec x, i &=& j < i \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{unroll}}}_{C}({\mathit{deftype}}) &=& {\mathrm{unroll}}({\mathit{deftype}}) \\
{{\mathrm{unroll}}}_{C}({\mathit{typeidx}}) &=& {\mathrm{unroll}}(C{.}\mathsf{types}{}[{\mathit{typeidx}}]) \\
{{\mathrm{unroll}}}_{C}(\mathsf{rec}~i) &=& C{.}\mathsf{recs}{}[i] \\
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
} \, {[\textsc{\scriptsize K{-}rect{-}rec2}]}
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

$\boxed{{\mathit{context}} \vdash {\mathit{globaltype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{tabletype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{memtype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{externtype}} : \mathsf{ok}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
n \leq m \leq k
}{
C \vdash {}[ n .. m ] : k
} \, {[\textsc{\scriptsize K{-}limits}]}
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
C \vdash {t_1^\ast} \rightarrow {t_2^\ast} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}func}]}
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
C \vdash {\mathit{limits}} : {2^{32}} - 1
 \qquad
C \vdash {\mathit{reftype}} : \mathsf{ok}
}{
C \vdash {\mathit{limits}}~{\mathit{reftype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{limits}} : {2^{16}}
}{
C \vdash {\mathit{limits}}~\mathsf{page} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{deftype}} : \mathsf{ok}
 \qquad
{\mathit{deftype}} \approx \mathsf{func}~{\mathit{functype}}
}{
C \vdash \mathsf{func}~{\mathit{deftype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}func}]}
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
C \vdash {\mathit{memtype}} : \mathsf{ok}
}{
C \vdash \mathsf{mem}~{\mathit{memtype}} : \mathsf{ok}
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
{\mathit{deftype}} \approx \mathsf{func}~{\mathit{functype}}
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
C \vdash \mathsf{rec}~i \leq {{\mathit{typeuse}}^\ast}{}[j]
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

$\boxed{{\mathit{context}} \vdash {{\mathit{valtype}}^\ast} \leq {{\mathit{valtype}}^\ast}}$

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

$\boxed{{\mathit{context}} \vdash {\mathit{functype}} \leq {\mathit{functype}}}$

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
(C \vdash {\mathit{yt}}_1 \leq {\mathit{yt}}_2)^\ast
}{
C \vdash \mathsf{struct}~({{\mathit{yt}}_1^\ast}~{\mathit{yt}'}_1) \leq \mathsf{struct}~{{\mathit{yt}}_2^\ast}
} \, {[\textsc{\scriptsize S{-}comp{-}struct}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{yt}}_1 \leq {\mathit{yt}}_2
}{
C \vdash \mathsf{array}~{\mathit{yt}}_1 \leq \mathsf{array}~{\mathit{yt}}_2
} \, {[\textsc{\scriptsize S{-}comp{-}array}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{ft}}_1 \leq {\mathit{ft}}_2
}{
C \vdash \mathsf{func}~{\mathit{ft}}_1 \leq \mathsf{func}~{\mathit{ft}}_2
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

$\boxed{{\mathit{context}} \vdash {\mathit{globaltype}} \leq {\mathit{globaltype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{tabletype}} \leq {\mathit{tabletype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{memtype}} \leq {\mathit{memtype}}}$

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
C \vdash {t_{21}^\ast} \leq {t_{11}^\ast}
 \qquad
C \vdash {t_{12}^\ast} \leq {t_{22}^\ast}
}{
C \vdash {t_{11}^\ast} \rightarrow {t_{12}^\ast} \leq {t_{21}^\ast} \rightarrow {t_{22}^\ast}
} \, {[\textsc{\scriptsize S{-}func}]}
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
 \qquad
C \vdash {\mathit{reftype}}_1 \leq {\mathit{reftype}}_2
 \qquad
C \vdash {\mathit{reftype}}_2 \leq {\mathit{reftype}}_1
}{
C \vdash {\mathit{limits}}_1~{\mathit{reftype}}_1 \leq {\mathit{limits}}_2~{\mathit{reftype}}_2
} \, {[\textsc{\scriptsize S{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{limits}}_1 \leq {\mathit{limits}}_2
}{
C \vdash {\mathit{limits}}_1~\mathsf{page} \leq {\mathit{limits}}_2~\mathsf{page}
} \, {[\textsc{\scriptsize S{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

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
C \vdash {\mathit{memtype}}_1 \leq {\mathit{memtype}}_2
}{
C \vdash \mathsf{mem}~{\mathit{memtype}}_1 \leq \mathsf{mem}~{\mathit{memtype}}_2
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
C \vdash {{\mathit{instr}}^\ast} : \epsilon \rightarrow_{\epsilon} {t^\ast}
}{
C \vdash {{\mathit{instr}}^\ast} : {t^\ast}
} \, {[\textsc{\scriptsize T{-}expr}]}
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
}{
C \vdash \mathsf{nop} : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}nop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {t_1^\ast} \rightarrow {t_2^\ast} : \mathsf{ok}
}{
C \vdash \mathsf{unreachable} : {t_1^\ast} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}unreachable}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash t : \mathsf{ok}
}{
C \vdash \mathsf{drop} : t \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}drop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash t : \mathsf{ok}
}{
C \vdash \mathsf{select}~t : t~t~\mathsf{i{\scriptstyle 32}} \rightarrow t
} \, {[\textsc{\scriptsize T{-}select{-}expl}]}
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
} \, {[\textsc{\scriptsize T{-}select{-}impl}]}
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
C{.}\mathsf{types}{}[{\mathit{typeidx}}] \approx \mathsf{func}~({t_1^\ast} \rightarrow {t_2^\ast})
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

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{labels}{}[l] = {t^\ast}
 \qquad
C \vdash {t_1^\ast} \rightarrow {t_2^\ast} : \mathsf{ok}
}{
C \vdash \mathsf{br}~l : {t_1^\ast}~{t^\ast} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}br}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{labels}{}[l] = {t^\ast}
}{
C \vdash \mathsf{br\_if}~l : {t^\ast}~\mathsf{i{\scriptstyle 32}} \rightarrow {t^\ast}
} \, {[\textsc{\scriptsize T{-}br\_if}]}
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
C \vdash {t_1^\ast} \rightarrow {t_2^\ast} : \mathsf{ok}
}{
C \vdash \mathsf{br\_table}~{l^\ast}~{l'} : {t_1^\ast}~{t^\ast} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}br\_table}]}
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
} \, {[\textsc{\scriptsize T{-}br\_on\_null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{labels}{}[l] = {t^\ast}~(\mathsf{ref}~{\mathit{ht}})
}{
C \vdash \mathsf{br\_on\_non\_null}~l : {t^\ast}~(\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \rightarrow {t^\ast}
} \, {[\textsc{\scriptsize T{-}br\_on\_non\_null}]}
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
} \, {[\textsc{\scriptsize T{-}br\_on\_cast}]}
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
} \, {[\textsc{\scriptsize T{-}br\_on\_cast\_fail}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{funcs}{}[x] \approx \mathsf{func}~({t_1^\ast} \rightarrow {t_2^\ast})
}{
C \vdash \mathsf{call}~x : {t_1^\ast} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}call}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{func}~({t_1^\ast} \rightarrow {t_2^\ast})
}{
C \vdash \mathsf{call\_ref}~x : {t_1^\ast}~(\mathsf{ref}~\mathsf{null}~x) \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}call\_ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tables}{}[x] = {\mathit{lim}}~{\mathit{rt}}
 \qquad
C \vdash {\mathit{rt}} \leq (\mathsf{ref}~\mathsf{null}~\mathsf{func})
 \qquad
C{.}\mathsf{types}{}[y] \approx \mathsf{func}~({t_1^\ast} \rightarrow {t_2^\ast})
}{
C \vdash \mathsf{call\_indirect}~x~y : {t_1^\ast}~\mathsf{i{\scriptstyle 32}} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize T{-}call\_indirect}]}
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
} \, {[\textsc{\scriptsize T{-}return}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{funcs}{}[x] \approx \mathsf{func}~({t_1^\ast} \rightarrow {t_2^\ast})
 \qquad
C{.}\mathsf{return} = ({{t'}_2^\ast})
 \qquad
C \vdash {t_2^\ast} \leq {{t'}_2^\ast}
 \qquad
C \vdash {t_3^\ast} \rightarrow {t_4^\ast} : \mathsf{ok}
}{
C \vdash \mathsf{return\_call}~x : {t_3^\ast}~{t_1^\ast} \rightarrow {t_4^\ast}
} \, {[\textsc{\scriptsize T{-}return\_call}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{func}~({t_1^\ast} \rightarrow {t_2^\ast})
 \qquad
C{.}\mathsf{return} = ({{t'}_2^\ast})
 \qquad
C \vdash {t_2^\ast} \leq {{t'}_2^\ast}
 \qquad
C \vdash {t_3^\ast} \rightarrow {t_4^\ast} : \mathsf{ok}
}{
C \vdash \mathsf{return\_call\_ref}~x : {t_3^\ast}~{t_1^\ast}~(\mathsf{ref}~\mathsf{null}~x) \rightarrow {t_4^\ast}
} \, {[\textsc{\scriptsize T{-}return\_call\_ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\begin{array}{@{}c@{}}
C{.}\mathsf{tables}{}[x] = {\mathit{lim}}~{\mathit{rt}}
 \qquad
C \vdash {\mathit{rt}} \leq (\mathsf{ref}~\mathsf{null}~\mathsf{func})
 \\
C{.}\mathsf{types}{}[y] \approx \mathsf{func}~({t_1^\ast} \rightarrow {t_2^\ast})
 \qquad
C{.}\mathsf{return} = ({{t'}_2^\ast})
 \qquad
C \vdash {t_2^\ast} \leq {{t'}_2^\ast}
 \qquad
C \vdash {t_3^\ast} \rightarrow {t_4^\ast} : \mathsf{ok}
\end{array}
}{
C \vdash \mathsf{return\_call\_indirect}~x~y : {t_3^\ast}~{t_1^\ast}~\mathsf{i{\scriptstyle 32}} \rightarrow {t_4^\ast}
} \, {[\textsc{\scriptsize T{-}return\_call\_indirect}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{nt}}{.}\mathsf{const}~c_{\mathit{nt}} : \epsilon \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}const}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{nt}} {.} {\mathit{unop}}_{\mathit{nt}} : {\mathit{nt}} \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}unop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{nt}} {.} {\mathit{binop}}_{\mathit{nt}} : {\mathit{nt}}~{\mathit{nt}} \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}binop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{nt}} {.} {\mathit{testop}}_{\mathit{nt}} : {\mathit{nt}} \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}testop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{nt}} {.} {\mathit{relop}}_{\mathit{nt}} : {\mathit{nt}}~{\mathit{nt}} \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}relop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{nt}}_1 {.} {{\mathit{cvtop}}}{\mathsf{\_}}{{\mathit{nt}}_2} : {\mathit{nt}}_2 \rightarrow {\mathit{nt}}_1
} \, {[\textsc{\scriptsize T{-}cvtop}]}
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
} \, {[\textsc{\scriptsize T{-}ref.null}]}
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
} \, {[\textsc{\scriptsize T{-}ref.func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{ref{.}i{\scriptstyle 31}} : \mathsf{i{\scriptstyle 32}} \rightarrow (\mathsf{ref}~\mathsf{i{\scriptstyle 31}})
} \, {[\textsc{\scriptsize T{-}ref.i31}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{ht}} : \mathsf{ok}
}{
C \vdash \mathsf{ref{.}is\_null} : (\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}ref.is\_null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{ht}} : \mathsf{ok}
}{
C \vdash \mathsf{ref{.}as\_non\_null} : (\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \rightarrow (\mathsf{ref}~{\mathit{ht}})
} \, {[\textsc{\scriptsize T{-}ref.as\_non\_null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{ref{.}eq} : (\mathsf{ref}~\mathsf{null}~\mathsf{eq})~(\mathsf{ref}~\mathsf{null}~\mathsf{eq}) \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}ref.eq}]}
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
} \, {[\textsc{\scriptsize T{-}ref.test}]}
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
} \, {[\textsc{\scriptsize T{-}ref.cast}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathsf{i{\scriptstyle 31}{.}get}}{\mathsf{\_}}{{\mathit{sx}}} : (\mathsf{ref}~\mathsf{null}~\mathsf{i{\scriptstyle 31}}) \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}i31.get}]}
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
} \, {[\textsc{\scriptsize T{-}struct.new}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{struct}~{({\mathsf{mut}^?}~{\mathit{zt}})^\ast}
 \qquad
({{\mathrm{default}}}_{{\mathrm{unpack}}({\mathit{zt}})} = {\mathit{val}})^\ast
}{
C \vdash \mathsf{struct{.}new\_default}~x : \epsilon \rightarrow (\mathsf{ref}~x)
} \, {[\textsc{\scriptsize T{-}struct.new\_default}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{struct}~{{\mathit{yt}}^\ast}
 \qquad
{{\mathit{yt}}^\ast}{}[i] = {\mathsf{mut}^?}~{\mathit{zt}}
 \qquad
{{\mathit{sx}}^?} = \epsilon \Leftrightarrow {\mathit{zt}} = {\mathrm{unpack}}({\mathit{zt}})
}{
C \vdash {\mathsf{struct{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~x~i : (\mathsf{ref}~\mathsf{null}~x) \rightarrow {\mathrm{unpack}}({\mathit{zt}})
} \, {[\textsc{\scriptsize T{-}struct.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{struct}~{{\mathit{yt}}^\ast}
 \qquad
{{\mathit{yt}}^\ast}{}[i] = \mathsf{mut}~{\mathit{zt}}
}{
C \vdash \mathsf{struct{.}set}~x~i : (\mathsf{ref}~\mathsf{null}~x)~{\mathrm{unpack}}({\mathit{zt}}) \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}struct.set}]}
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
} \, {[\textsc{\scriptsize T{-}array.new}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}})
 \qquad
{{\mathrm{default}}}_{{\mathrm{unpack}}({\mathit{zt}})} = {\mathit{val}}
}{
C \vdash \mathsf{array{.}new\_default}~x : \mathsf{i{\scriptstyle 32}} \rightarrow (\mathsf{ref}~x)
} \, {[\textsc{\scriptsize T{-}array.new\_default}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}})
}{
C \vdash \mathsf{array{.}new\_fixed}~x~n : {{\mathrm{unpack}}({\mathit{zt}})^{n}} \rightarrow (\mathsf{ref}~x)
} \, {[\textsc{\scriptsize T{-}array.new\_fixed}]}
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
} \, {[\textsc{\scriptsize T{-}array.new\_elem}]}
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
} \, {[\textsc{\scriptsize T{-}array.new\_data}]}
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
} \, {[\textsc{\scriptsize T{-}array.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
}{
C \vdash \mathsf{array{.}set}~x : (\mathsf{ref}~\mathsf{null}~x)~\mathsf{i{\scriptstyle 32}}~{\mathrm{unpack}}({\mathit{zt}}) \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}array.set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
}{
C \vdash \mathsf{array{.}len} : (\mathsf{ref}~\mathsf{null}~\mathsf{array}) \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}array.len}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{types}{}[x] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
}{
C \vdash \mathsf{array{.}fill}~x : (\mathsf{ref}~\mathsf{null}~x)~\mathsf{i{\scriptstyle 32}}~{\mathrm{unpack}}({\mathit{zt}})~\mathsf{i{\scriptstyle 32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}array.fill}]}
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
} \, {[\textsc{\scriptsize T{-}array.copy}]}
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
} \, {[\textsc{\scriptsize T{-}array.init\_elem}]}
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
} \, {[\textsc{\scriptsize T{-}array.init\_data}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{extern{.}convert\_any} : (\mathsf{ref}~{\mathsf{null}^?}~\mathsf{any}) \rightarrow (\mathsf{ref}~{\mathsf{null}^?}~\mathsf{extern})
} \, {[\textsc{\scriptsize T{-}extern.convert\_any}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{any{.}convert\_extern} : (\mathsf{ref}~{\mathsf{null}^?}~\mathsf{extern}) \rightarrow (\mathsf{ref}~{\mathsf{null}^?}~\mathsf{any})
} \, {[\textsc{\scriptsize T{-}any.convert\_extern}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c : \epsilon \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vconst}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{v{\scriptstyle 128}} {.} {\mathit{vvunop}} : \mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vvunop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{v{\scriptstyle 128}} {.} {\mathit{vvbinop}} : \mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vvbinop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{v{\scriptstyle 128}} {.} {\mathit{vvternop}} : \mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vvternop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash \mathsf{v{\scriptstyle 128}} {.} {\mathit{vvtestop}} : \mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}vvtestop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}} {.} {\mathit{vunop}} : \mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vunop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}} {.} {\mathit{vbinop}} : \mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vbinop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}} {.} {\mathit{vtestop}} : \mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}vtestop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}} {.} {\mathit{vrelop}} : \mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vrelop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}} {.} {\mathit{vshiftop}} : \mathsf{v{\scriptstyle 128}}~\mathsf{i{\scriptstyle 32}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vshiftop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}}{.}\mathsf{bitmask} : \mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}vbitmask}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}}{.}\mathsf{swizzle} : \mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vswizzle}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
(i < 2 \cdot {\mathrm{dim}}({\mathit{sh}}))^\ast
}{
C \vdash {\mathit{sh}}{.}\mathsf{shuffle}~{i^\ast} : \mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vshuffle}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}}{.}\mathsf{splat} : {\mathrm{unpack}}({\mathit{sh}}) \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vsplat}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
i < {\mathrm{dim}}({\mathit{sh}})
}{
C \vdash {{\mathit{sh}}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~i : \mathsf{v{\scriptstyle 128}} \rightarrow {\mathrm{unpack}}({\mathit{sh}})
} \, {[\textsc{\scriptsize T{-}vextract\_lane}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
i < {\mathrm{dim}}({\mathit{sh}})
}{
C \vdash {\mathit{sh}}{.}\mathsf{replace\_lane}~i : \mathsf{v{\scriptstyle 128}}~{\mathrm{unpack}}({\mathit{sh}}) \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vreplace\_lane}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}}_1 {.} {{\mathit{vextunop}}}{\mathsf{\_}}{{\mathit{sh}}_2} : \mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vextunop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}}_1 {.} {{\mathit{vextbinop}}}{\mathsf{\_}}{{\mathit{sh}}_2} : \mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vextbinop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {{\mathit{sh}}_1{.}\mathsf{narrow}}{\mathsf{\_}}{{\mathit{sh}}_2}{\mathsf{\_}}{{\mathit{sx}}} : \mathsf{v{\scriptstyle 128}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vnarrow}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
C \vdash {\mathit{sh}}_1 {.} {{\mathit{vcvtop}}}{\mathsf{\_}}{{{\mathit{zero}}^?}}{\mathsf{\_}}{{\mathit{sh}}_2}{\mathsf{\_}}{{{\mathit{half}}^?}} : \mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vcvtop}]}
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
} \, {[\textsc{\scriptsize T{-}local.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{locals}{}[x] = {\mathit{init}}~t
}{
C \vdash \mathsf{local{.}set}~x : t \rightarrow_{x} \epsilon
} \, {[\textsc{\scriptsize T{-}local.set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{locals}{}[x] = {\mathit{init}}~t
}{
C \vdash \mathsf{local{.}tee}~x : t \rightarrow_{x} t
} \, {[\textsc{\scriptsize T{-}local.tee}]}
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
} \, {[\textsc{\scriptsize T{-}global.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{globals}{}[x] = \mathsf{mut}~t
}{
C \vdash \mathsf{global{.}set}~x : t \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}global.set}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tables}{}[x] = {\mathit{lim}}~{\mathit{rt}}
}{
C \vdash \mathsf{table{.}get}~x : \mathsf{i{\scriptstyle 32}} \rightarrow {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}table.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tables}{}[x] = {\mathit{lim}}~{\mathit{rt}}
}{
C \vdash \mathsf{table{.}set}~x : \mathsf{i{\scriptstyle 32}}~{\mathit{rt}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tables}{}[x] = {\mathit{lim}}~{\mathit{rt}}
}{
C \vdash \mathsf{table{.}size}~x : \epsilon \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}table.size}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tables}{}[x] = {\mathit{lim}}~{\mathit{rt}}
}{
C \vdash \mathsf{table{.}grow}~x : {\mathit{rt}}~\mathsf{i{\scriptstyle 32}} \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}table.grow}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tables}{}[x] = {\mathit{lim}}~{\mathit{rt}}
}{
C \vdash \mathsf{table{.}fill}~x : \mathsf{i{\scriptstyle 32}}~{\mathit{rt}}~\mathsf{i{\scriptstyle 32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.fill}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tables}{}[x_1] = {\mathit{lim}}_1~{\mathit{rt}}_1
 \qquad
C{.}\mathsf{tables}{}[x_2] = {\mathit{lim}}_2~{\mathit{rt}}_2
 \qquad
C \vdash {\mathit{rt}}_2 \leq {\mathit{rt}}_1
}{
C \vdash \mathsf{table{.}copy}~x_1~x_2 : \mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.copy}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{tables}{}[x] = {\mathit{lim}}~{\mathit{rt}}_1
 \qquad
C{.}\mathsf{elems}{}[y] = {\mathit{rt}}_2
 \qquad
C \vdash {\mathit{rt}}_2 \leq {\mathit{rt}}_1
}{
C \vdash \mathsf{table{.}init}~x~y : \mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.init}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{elems}{}[x] = {\mathit{rt}}
}{
C \vdash \mathsf{elem{.}drop}~x : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}elem.drop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{mt}}
}{
C \vdash \mathsf{memory{.}size}~x : \epsilon \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}memory.size}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{mt}}
}{
C \vdash \mathsf{memory{.}grow}~x : \mathsf{i{\scriptstyle 32}} \rightarrow \mathsf{i{\scriptstyle 32}}
} \, {[\textsc{\scriptsize T{-}memory.grow}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{mt}}
}{
C \vdash \mathsf{memory{.}fill}~x : \mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}memory.fill}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x_1] = {\mathit{mt}}_1
 \qquad
C{.}\mathsf{mems}{}[x_2] = {\mathit{mt}}_2
}{
C \vdash \mathsf{memory{.}copy}~x_1~x_2 : \mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}memory.copy}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{mt}}
 \qquad
C{.}\mathsf{datas}{}[y] = \mathsf{ok}
}{
C \vdash \mathsf{memory{.}init}~x~y : \mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}}~\mathsf{i{\scriptstyle 32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}memory.init}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{datas}{}[x] = \mathsf{ok}
}{
C \vdash \mathsf{data{.}drop}~x : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}data.drop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{mt}}
 \qquad
{2^{{\mathit{memarg}}{.}\mathsf{align}}} \leq {|{\mathit{nt}}|} / 8
}{
C \vdash {\mathit{nt}}{.}\mathsf{load}~x~{\mathit{memarg}} : \mathsf{i{\scriptstyle 32}} \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}load{-}val}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{mt}}
 \qquad
{2^{{\mathit{memarg}}{.}\mathsf{align}}} \leq M / 8
}{
C \vdash {{\mathsf{i}}{N}{.}\mathsf{load}}{M~{\mathit{sx}}}~x~{\mathit{memarg}} : \mathsf{i{\scriptstyle 32}} \rightarrow {\mathsf{i}}{N}
} \, {[\textsc{\scriptsize T{-}load{-}pack}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{mt}}
 \qquad
{2^{{\mathit{memarg}}{.}\mathsf{align}}} \leq {|{\mathit{nt}}|} / 8
}{
C \vdash {\mathit{nt}}{.}\mathsf{store}~x~{\mathit{memarg}} : \mathsf{i{\scriptstyle 32}}~{\mathit{nt}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}store{-}val}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{mt}}
 \qquad
{2^{{\mathit{memarg}}{.}\mathsf{align}}} \leq M / 8
}{
C \vdash {{\mathsf{i}}{N}{.}\mathsf{store}}{M}~x~{\mathit{memarg}} : \mathsf{i{\scriptstyle 32}}~{\mathsf{i}}{N} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}store{-}pack}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{mt}}
 \qquad
{2^{{\mathit{memarg}}{.}\mathsf{align}}} \leq {|\mathsf{v{\scriptstyle 128}}|} / 8
}{
C \vdash \mathsf{v{\scriptstyle 128}}{.}\mathsf{load}~x~{\mathit{memarg}} : \mathsf{i{\scriptstyle 32}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vload{-}val}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{mt}}
 \qquad
{2^{{\mathit{memarg}}{.}\mathsf{align}}} \leq M / 8 \cdot N
}{
C \vdash {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{M}{\mathsf{x}}{N}{\mathsf{\_}}{{\mathit{sx}}}}~x~{\mathit{memarg}} : \mathsf{i{\scriptstyle 32}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vload{-}pack}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{mt}}
 \qquad
{2^{{\mathit{memarg}}{.}\mathsf{align}}} \leq N / 8
}{
C \vdash {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{N}{\mathsf{\_}}{\mathsf{splat}}}~x~{\mathit{memarg}} : \mathsf{i{\scriptstyle 32}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vload{-}splat}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{mt}}
 \qquad
{2^{{\mathit{memarg}}{.}\mathsf{align}}} \leq N / 8
}{
C \vdash {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{N}{\mathsf{\_}}{\mathsf{zero}}}~x~{\mathit{memarg}} : \mathsf{i{\scriptstyle 32}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vload{-}zero}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{mt}}
 \qquad
{2^{{\mathit{memarg}}{.}\mathsf{align}}} \leq N / 8
 \qquad
i < 128 / N
}{
C \vdash {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{N}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{memarg}}~i : \mathsf{i{\scriptstyle 32}}~\mathsf{v{\scriptstyle 128}} \rightarrow \mathsf{v{\scriptstyle 128}}
} \, {[\textsc{\scriptsize T{-}vload\_lane}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{mt}}
 \qquad
{2^{{\mathit{memarg}}{.}\mathsf{align}}} \leq {|\mathsf{v{\scriptstyle 128}}|} / 8
}{
C \vdash \mathsf{v{\scriptstyle 128}}{.}\mathsf{store}~x~{\mathit{memarg}} : \mathsf{i{\scriptstyle 32}}~\mathsf{v{\scriptstyle 128}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}vstore}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{mems}{}[x] = {\mathit{mt}}
 \qquad
{2^{{\mathit{memarg}}{.}\mathsf{align}}} \leq N / 8
 \qquad
i < 128 / N
}{
C \vdash {\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}}{N}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{memarg}}~i : \mathsf{i{\scriptstyle 32}}~\mathsf{v{\scriptstyle 128}} \rightarrow \epsilon
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

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{type}} : {{\mathit{deftype}}^\ast}}$

$\boxed{{\mathit{context}} \vdash {\mathit{func}} : {\mathit{deftype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{local}} : {\mathit{localtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{global}} : {\mathit{globaltype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{table}} : {\mathit{tabletype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{mem}} : {\mathit{memtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{elem}} : {\mathit{elemtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{data}} : {\mathit{datatype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{elemmode}} : {\mathit{elemtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{datamode}} : {\mathit{datatype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{start}} : \mathsf{ok}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
x = {|C{.}\mathsf{types}|}
 \qquad
{{\mathit{dt}}^\ast} = {{{{\mathrm{roll}}}_{x}^\ast}}{({\mathit{rectype}})}
 \qquad
C \oplus \{ \begin{array}[t]{@{}l@{}}
\mathsf{types}~{{\mathit{dt}}^\ast} \}\end{array} \vdash {\mathit{rectype}} : {\mathsf{ok}}{(x)}
}{
C \vdash \mathsf{type}~{\mathit{rectype}} : {{\mathit{dt}}^\ast}
} \, {[\textsc{\scriptsize T{-}type}]}
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
C{.}\mathsf{types}{}[x] \approx \mathsf{func}~({t_1^\ast} \rightarrow {t_2^\ast})
 \qquad
(C \vdash {\mathit{local}} : {{\mathit{lt}}})^\ast
 \qquad
C \oplus \{ \begin{array}[t]{@{}l@{}}
\mathsf{locals}~{(\mathsf{set}~t_1)^\ast}~{{{\mathit{lt}}}^\ast},\; \mathsf{labels}~({t_2^\ast}),\; \mathsf{return}~({t_2^\ast}) \}\end{array} \vdash {\mathit{expr}} : {t_2^\ast}
}{
C \vdash \mathsf{func}~x~{{\mathit{local}}^\ast}~{\mathit{expr}} : C{.}\mathsf{types}{}[x]
} \, {[\textsc{\scriptsize T{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C \vdash {\mathit{gt}} : \mathsf{ok}
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
C \vdash {\mathit{tt}} : \mathsf{ok}
 \qquad
{\mathit{tabletype}} = {\mathit{lim}}~{\mathit{rt}}
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
C{.}\mathsf{tables}{}[x] = {\mathit{lim}}~{\mathit{rt}'}
 \qquad
C \vdash {\mathit{rt}} \leq {\mathit{rt}'}
 \qquad
C \vdash {\mathit{expr}} : \mathsf{i{\scriptstyle 32}}~\mathsf{const}
}{
C \vdash \mathsf{active}~x~{\mathit{expr}} : {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}elemmode{-}active}]}
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
C{.}\mathsf{mems}{}[x] = {\mathit{mt}}
 \qquad
C \vdash {\mathit{expr}} : \mathsf{i{\scriptstyle 32}}~\mathsf{const}
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
C \vdash \mathsf{passive} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}datamode{-}passive}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
C{.}\mathsf{funcs}{}[x] \approx \mathsf{func}~(\epsilon \rightarrow \epsilon)
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
C \vdash \mathsf{import}~{\mathit{name}}_1~{\mathit{name}}_2~{\mathit{xt}} : {\mathit{xt}}
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
C{.}\mathsf{funcs}{}[x] = {\mathit{dt}}
}{
C \vdash \mathsf{func}~x : \mathsf{func}~{\mathit{dt}}
} \, {[\textsc{\scriptsize T{-}externidx{-}func}]}
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
C{.}\mathsf{mems}{}[x] = {\mathit{mt}}
}{
C \vdash \mathsf{mem}~x : \mathsf{mem}~{\mathit{mt}}
} \, {[\textsc{\scriptsize T{-}externidx{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\vdash}\, {\mathit{module}} : {\mathit{moduletype}}}$

$\boxed{{\mathit{context}} \vdash {{\mathit{type}}^\ast} : {{\mathit{deftype}}^\ast}}$

$\boxed{{\mathit{context}} \vdash {{\mathit{global}}^\ast} : {{\mathit{globaltype}}^\ast}}$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{nonfuncs}} &::=& {{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{funcidx}}({{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^\ast}) &=& {\mathrm{funcidx}}(\mathsf{module}~\epsilon~\epsilon~\epsilon~{{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^\ast}~\epsilon~\epsilon) \\
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\begin{array}{@{}c@{}}
\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {{\mathit{type}}^\ast} : {{\mathit{dt}'}^\ast}
 \qquad
(\{ \begin{array}[t]{@{}l@{}}
\mathsf{types}~{{\mathit{dt}'}^\ast} \}\end{array} \vdash {\mathit{import}} : {\mathit{xt}}_{\mathsf{i}})^\ast
 \\
{C'} \vdash {{\mathit{global}}^\ast} : {{\mathit{gt}}^\ast}
 \qquad
({C'} \vdash {\mathit{table}} : {\mathit{tt}})^\ast
 \qquad
({C'} \vdash {\mathit{mem}} : {\mathit{mt}})^\ast
 \qquad
(C \vdash {\mathit{func}} : {\mathit{dt}})^\ast
 \\
(C \vdash {\mathit{elem}} : {\mathit{rt}})^\ast
 \qquad
(C \vdash {\mathit{data}} : {\mathit{ok}})^\ast
 \qquad
(C \vdash {\mathit{start}} : \mathsf{ok})^?
 \qquad
(C \vdash {\mathit{export}} : {\mathit{nm}}~{\mathit{xt}}_{\mathsf{e}})^\ast
 \qquad
{{\mathit{nm}}^\ast}~{\mathrm{disjoint}}
 \\
C = \{ \begin{array}[t]{@{}l@{}}
\mathsf{types}~{{\mathit{dt}'}^\ast},\; \mathsf{funcs}~{{\mathit{dt}}_{\mathsf{i}}^\ast}~{{\mathit{dt}}^\ast},\; \mathsf{globals}~{{\mathit{gt}}_{\mathsf{i}}^\ast}~{{\mathit{gt}}^\ast},\; \mathsf{tables}~{{\mathit{tt}}_{\mathsf{i}}^\ast}~{{\mathit{tt}}^\ast},\; \mathsf{mems}~{{\mathit{mt}}_{\mathsf{i}}^\ast}~{{\mathit{mt}}^\ast},\; \mathsf{elems}~{{\mathit{rt}}^\ast},\; \mathsf{datas}~{{\mathit{ok}}^\ast},\; \mathsf{refs}~{x^\ast} \}\end{array}
 \\
{C'} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{types}~{{\mathit{dt}'}^\ast},\; \mathsf{funcs}~{{\mathit{dt}}_{\mathsf{i}}^\ast}~{{\mathit{dt}}^\ast},\; \mathsf{globals}~{{\mathit{gt}}_{\mathsf{i}}^\ast},\; \mathsf{refs}~{x^\ast} \}\end{array}
 \qquad
{x^\ast} = {\mathrm{funcidx}}({{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^\ast})
 \\
{{\mathit{dt}}_{\mathsf{i}}^\ast} = {\mathrm{funcs}}({{\mathit{xt}}_{\mathsf{i}}^\ast})
 \qquad
{{\mathit{gt}}_{\mathsf{i}}^\ast} = {\mathrm{globals}}({{\mathit{xt}}_{\mathsf{i}}^\ast})
 \qquad
{{\mathit{tt}}_{\mathsf{i}}^\ast} = {\mathrm{tables}}({{\mathit{xt}}_{\mathsf{i}}^\ast})
 \qquad
{{\mathit{mt}}_{\mathsf{i}}^\ast} = {\mathrm{mems}}({{\mathit{xt}}_{\mathsf{i}}^\ast})
\end{array}
}{
{\vdash}\, \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast} : {{\mathrm{clos}}}_{C}({{\mathit{xt}}_{\mathsf{i}}^\ast} \rightarrow {{\mathit{xt}}_{\mathsf{e}}^\ast})
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
C \oplus \{ \begin{array}[t]{@{}l@{}}
\mathsf{types}~{{\mathit{dt}}_1^\ast} \}\end{array} \vdash {{\mathit{type}}^\ast} : {{\mathit{dt}}^\ast}
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
C \vdash {\mathit{global}} : {\mathit{gt}}_1
 \qquad
C \oplus \{ \begin{array}[t]{@{}l@{}}
\mathsf{globals}~{\mathit{gt}}_1 \}\end{array} \vdash {{\mathit{global}}^\ast} : {{\mathit{gt}}^\ast}
}{
C \vdash {\mathit{global}}_1~{{\mathit{global}}^\ast} : {\mathit{gt}}_1~{{\mathit{gt}}^\ast}
} \, {[\textsc{\scriptsize T{-}globals{-}cons}]}
\qquad
\end{array}
$$

$\boxed{{\mathit{store}} \vdash {\mathit{num}} : {\mathit{numtype}}}$

$\boxed{{\mathit{store}} \vdash {\mathit{vec}} : {\mathit{vectype}}}$

$\boxed{{\mathit{store}} \vdash {\mathit{ref}} : {\mathit{reftype}}}$

$\boxed{{\mathit{store}} \vdash {\mathit{val}} : {\mathit{valtype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
s \vdash {\mathit{nt}}{.}\mathsf{const}~c : {\mathit{nt}}
} \, {[\textsc{\scriptsize Num\_type}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
s \vdash {\mathit{vt}}{.}\mathsf{const}~c : {\mathit{vt}}
} \, {[\textsc{\scriptsize Vec\_type}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
s \vdash \mathsf{ref{.}null}~{\mathit{ht}} : (\mathsf{ref}~\mathsf{null}~{\mathit{ht}})
} \, {[\textsc{\scriptsize Ref\_type{-}null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
s \vdash \mathsf{ref{.}i{\scriptstyle 31}}~i : (\mathsf{ref}~\epsilon~\mathsf{i{\scriptstyle 31}})
} \, {[\textsc{\scriptsize Ref\_type{-}i31}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s{.}\mathsf{structs}{}[a]{.}\mathsf{type} = {\mathit{dt}}
}{
s \vdash \mathsf{ref{.}struct}~a : (\mathsf{ref}~\epsilon~{\mathit{dt}})
} \, {[\textsc{\scriptsize Ref\_type{-}struct}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s{.}\mathsf{arrays}{}[a]{.}\mathsf{type} = {\mathit{dt}}
}{
s \vdash \mathsf{ref{.}array}~a : (\mathsf{ref}~\epsilon~{\mathit{dt}})
} \, {[\textsc{\scriptsize Ref\_type{-}array}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s{.}\mathsf{funcs}{}[a]{.}\mathsf{type} = {\mathit{dt}}
}{
s \vdash \mathsf{ref{.}func}~a : (\mathsf{ref}~\epsilon~{\mathit{dt}})
} \, {[\textsc{\scriptsize Ref\_type{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
s \vdash \mathsf{ref{.}host}~a : (\mathsf{ref}~\epsilon~\mathsf{any})
} \, {[\textsc{\scriptsize Ref\_type{-}host}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
s \vdash \mathsf{ref{.}extern}~{\mathit{addrref}} : (\mathsf{ref}~\epsilon~\mathsf{extern})
} \, {[\textsc{\scriptsize Ref\_type{-}extern}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s \vdash {\mathit{ref}} : {\mathit{rt}'}
 \qquad
\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}'} \leq {\mathit{rt}}
}{
s \vdash {\mathit{ref}} : {\mathit{rt}}
} \, {[\textsc{\scriptsize Ref\_type{-}sub}]}
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
} \, {[\textsc{\scriptsize Val\_type{-}num}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s \vdash {\mathit{vec}} : {\mathit{vt}}
}{
s \vdash {\mathit{vec}} : {\mathit{vt}}
} \, {[\textsc{\scriptsize Val\_type{-}vec}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s \vdash {\mathit{ref}} : {\mathit{rt}}
}{
s \vdash {\mathit{ref}} : {\mathit{rt}}
} \, {[\textsc{\scriptsize Val\_type{-}ref}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{store}} \vdash {\mathit{externval}} : {\mathit{externtype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s{.}\mathsf{funcs}{}[a] = {\mathit{funcinst}}
}{
s \vdash \mathsf{func}~a : \mathsf{func}~{\mathit{funcinst}}{.}\mathsf{type}
} \, {[\textsc{\scriptsize Externval\_type{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s{.}\mathsf{globals}{}[a] = {\mathit{globalinst}}
}{
s \vdash \mathsf{global}~a : \mathsf{global}~{\mathit{globalinst}}{.}\mathsf{type}
} \, {[\textsc{\scriptsize Externval\_type{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s{.}\mathsf{tables}{}[a] = {\mathit{tableinst}}
}{
s \vdash \mathsf{table}~a : \mathsf{table}~{\mathit{tableinst}}{.}\mathsf{type}
} \, {[\textsc{\scriptsize Externval\_type{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s{.}\mathsf{mems}{}[a] = {\mathit{meminst}}
}{
s \vdash \mathsf{mem}~a : \mathsf{mem}~{\mathit{meminst}}{.}\mathsf{type}
} \, {[\textsc{\scriptsize Externval\_type{-}mem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
s \vdash {\mathit{externval}} : {\mathit{xt}'}
 \qquad
\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{xt}'} \leq {\mathit{xt}}
}{
s \vdash {\mathit{externval}} : {\mathit{xt}}
} \, {[\textsc{\scriptsize Externval\_type{-}sub}]}
\qquad
\end{array}
$$

$\boxed{{\mathit{config}} \hookrightarrow {\mathit{config}}}$

$\boxed{{{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}}^\ast}}$

$\boxed{{\mathit{config}} \hookrightarrow {{\mathit{instr}}^\ast}}$

$\boxed{{\mathit{config}} \hookrightarrow^\ast {\mathit{config}}}$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}pure}]} \quad & z ; {{\mathit{instr}}^\ast} &\hookrightarrow& z ; {{\mathit{instr}'}^\ast}
  &\qquad \mbox{if}~{{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\
{[\textsc{\scriptsize E{-}read}]} \quad & z ; {{\mathit{instr}}^\ast} &\hookrightarrow& z ; {{\mathit{instr}'}^\ast}
  &\qquad \mbox{if}~z ; {{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}refl}]} \quad & z ; {{\mathit{instr}}^\ast} &\hookrightarrow^\ast& z ; {{\mathit{instr}}^\ast} \\
{[\textsc{\scriptsize E{-}trans}]} \quad & z ; {{\mathit{instr}}^\ast} &\hookrightarrow^\ast& {z''} ; {{\mathit{instr}''}^\ast}
  &\qquad \mbox{if}~z ; {{\mathit{instr}}^\ast} \hookrightarrow {z'} ; {{\mathit{instr}'}^\ast} \\
  &&&&\qquad {\land}~{z'} ; {\mathit{instr}'} \hookrightarrow^\ast {z''} ; {{\mathit{instr}''}^\ast} \\
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{state}} ; {\mathit{expr}} \hookrightarrow^\ast {\mathit{state}} ; {{\mathit{val}}^\ast}}$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}expr}]} \quad & z ; {{\mathit{instr}}^\ast} &\hookrightarrow^\ast& {z'} ; {{\mathit{val}}^\ast}
  &\qquad \mbox{if}~z ; {{\mathit{instr}}^\ast} \hookrightarrow^\ast {z'} ; {{\mathit{val}}^\ast} \\
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
{[\textsc{\scriptsize E{-}select{-}true}]} \quad & {\mathit{val}}_1~{\mathit{val}}_2~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)~(\mathsf{select}~{({t^\ast})^?}) &\hookrightarrow& {\mathit{val}}_1
  &\qquad \mbox{if}~c \neq 0 \\
{[\textsc{\scriptsize E{-}select{-}false}]} \quad & {\mathit{val}}_1~{\mathit{val}}_2~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)~(\mathsf{select}~{({t^\ast})^?}) &\hookrightarrow& {\mathit{val}}_2
  &\qquad \mbox{if}~c = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{blocktype}}}_{z}(x) &=& {\mathit{ft}}
  &\qquad \mbox{if}~z{.}\mathsf{types}{}[x] \approx \mathsf{func}~{\mathit{ft}} \\
{{\mathrm{blocktype}}}_{z}({t^?}) &=& \epsilon \rightarrow {t^?} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}block}]} \quad & z ; {{\mathit{val}}^{m}}~(\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{n}}{\{ \epsilon \}}~{{\mathit{val}}^{m}}~{{\mathit{instr}}^\ast})
  &\qquad \mbox{if}~{{\mathrm{blocktype}}}_{z}({\mathit{bt}}) = {t_1^{m}} \rightarrow {t_2^{n}} \\
{[\textsc{\scriptsize E{-}loop}]} \quad & z ; {{\mathit{val}}^{m}}~(\mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{m}}{\{ \mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast} \}}~{{\mathit{val}}^{m}}~{{\mathit{instr}}^\ast})
  &\qquad \mbox{if}~{{\mathrm{blocktype}}}_{z}({\mathit{bt}}) = {t_1^{m}} \rightarrow {t_2^{n}} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}if{-}true}]} \quad & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)~(\mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_1^\ast}~\mathsf{else}~{{\mathit{instr}}_2^\ast}) &\hookrightarrow& (\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}_1^\ast})
  &\qquad \mbox{if}~c \neq 0 \\
{[\textsc{\scriptsize E{-}if{-}false}]} \quad & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)~(\mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_1^\ast}~\mathsf{else}~{{\mathit{instr}}_2^\ast}) &\hookrightarrow& (\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}_2^\ast})
  &\qquad \mbox{if}~c = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}label{-}vals}]} \quad & ({{\mathsf{label}}_{n}}{\{ {{\mathit{instr}}^\ast} \}}~{{\mathit{val}}^\ast}) &\hookrightarrow& {{\mathit{val}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}br{-}zero}]} \quad & ({{\mathsf{label}}_{n}}{\{ {{\mathit{instr}'}^\ast} \}}~{{\mathit{val}'}^\ast}~{{\mathit{val}}^{n}}~(\mathsf{br}~l)~{{\mathit{instr}}^\ast}) &\hookrightarrow& {{\mathit{val}}^{n}}~{{\mathit{instr}'}^\ast}
  &\qquad \mbox{if}~l = 0 \\
{[\textsc{\scriptsize E{-}br{-}succ}]} \quad & ({{\mathsf{label}}_{n}}{\{ {{\mathit{instr}'}^\ast} \}}~{{\mathit{val}}^\ast}~(\mathsf{br}~l)~{{\mathit{instr}}^\ast}) &\hookrightarrow& {{\mathit{val}}^\ast}~(\mathsf{br}~l - 1)
  &\qquad \mbox{if}~l > 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_if{-}true}]} \quad & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)~(\mathsf{br\_if}~l) &\hookrightarrow& (\mathsf{br}~l)
  &\qquad \mbox{if}~c \neq 0 \\
{[\textsc{\scriptsize E{-}br\_if{-}false}]} \quad & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)~(\mathsf{br\_if}~l) &\hookrightarrow& \epsilon
  &\qquad \mbox{if}~c = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_table{-}lt}]} \quad & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{br\_table}~{l^\ast}~{l'}) &\hookrightarrow& (\mathsf{br}~{l^\ast}{}[i])
  &\qquad \mbox{if}~i < {|{l^\ast}|} \\
{[\textsc{\scriptsize E{-}br\_table{-}ge}]} \quad & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{br\_table}~{l^\ast}~{l'}) &\hookrightarrow& (\mathsf{br}~{l'})
  &\qquad \mbox{if}~i \geq {|{l^\ast}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_null{-}null}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_null}~l) &\hookrightarrow& (\mathsf{br}~l)
  &\qquad \mbox{if}~{\mathit{val}} = \mathsf{ref{.}null}~{\mathit{ht}} \\
{[\textsc{\scriptsize E{-}br\_on\_null{-}addr}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_null}~l) &\hookrightarrow& {\mathit{val}}
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_non\_null{-}null}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_non\_null}~l) &\hookrightarrow& \epsilon
  &\qquad \mbox{if}~{\mathit{val}} = \mathsf{ref{.}null}~{\mathit{ht}} \\
{[\textsc{\scriptsize E{-}br\_on\_non\_null{-}addr}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_non\_null}~l) &\hookrightarrow& {\mathit{val}}~(\mathsf{br}~l)
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_cast{-}succeed}]} \quad & s ; f ; {\mathit{ref}}~(\mathsf{br\_on\_cast}~l~{\mathit{rt}}_1~{\mathit{rt}}_2) &\hookrightarrow& {\mathit{ref}}~(\mathsf{br}~l)
  &\qquad \mbox{if}~s \vdash {\mathit{ref}} : {\mathit{rt}} \\
  &&&&\qquad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}} \leq {{\mathrm{inst}}}_{f{.}\mathsf{module}}({\mathit{rt}}_2) \\
{[\textsc{\scriptsize E{-}br\_on\_cast{-}fail}]} \quad & s ; f ; {\mathit{ref}}~(\mathsf{br\_on\_cast}~l~{\mathit{rt}}_1~{\mathit{rt}}_2) &\hookrightarrow& {\mathit{ref}}
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_cast\_fail{-}succeed}]} \quad & s ; f ; {\mathit{ref}}~(\mathsf{br\_on\_cast\_fail}~l~{\mathit{rt}}_1~{\mathit{rt}}_2) &\hookrightarrow& {\mathit{ref}}
  &\qquad \mbox{if}~s \vdash {\mathit{ref}} : {\mathit{rt}} \\
  &&&&\qquad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}} \leq {{\mathrm{inst}}}_{f{.}\mathsf{module}}({\mathit{rt}}_2) \\
{[\textsc{\scriptsize E{-}br\_on\_cast\_fail{-}fail}]} \quad & s ; f ; {\mathit{ref}}~(\mathsf{br\_on\_cast\_fail}~l~{\mathit{rt}}_1~{\mathit{rt}}_2) &\hookrightarrow& {\mathit{ref}}~(\mathsf{br}~l)
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}call}]} \quad & z ; (\mathsf{call}~x) &\hookrightarrow& (\mathsf{ref{.}func}~a)~(\mathsf{call\_ref}~z{.}\mathsf{funcs}{}[a]{.}\mathsf{type})
  &\qquad \mbox{if}~z{.}\mathsf{module}{.}\mathsf{funcs}{}[x] = a \\
{[\textsc{\scriptsize E{-}call\_ref{-}null}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}})~(\mathsf{call\_ref}~y) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}call\_ref{-}func}]} \quad & z ; {{\mathit{val}}^{n}}~(\mathsf{ref{.}func}~a)~(\mathsf{call\_ref}~y) &\hookrightarrow& \multicolumn{2}{l@{}}{ ({{\mathsf{frame}}_{m}}{\{ f \}}~({{\mathsf{label}}_{m}}{\{ \epsilon \}}~{{\mathit{instr}}^\ast})) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~z{.}\mathsf{funcs}{}[a] = {\mathit{fi}}} \\
  &&& \multicolumn{2}{l@{}}{\quad {\land}~{\mathit{fi}}{.}\mathsf{type} \approx \mathsf{func}~({t_1^{n}} \rightarrow {t_2^{m}})} \\
  &&& \multicolumn{2}{l@{}}{\quad {\land}~{\mathit{fi}}{.}\mathsf{code} = \mathsf{func}~x~{(\mathsf{local}~t)^\ast}~({{\mathit{instr}}^\ast})} \\
  &&& \multicolumn{2}{l@{}}{\quad {\land}~f = \{ \begin{array}[t]{@{}l@{}}
\mathsf{locals}~{{\mathit{val}}^{n}}~{({{\mathrm{default}}}_{t})^\ast},\; \mathsf{module}~{\mathit{fi}}{.}\mathsf{module} \}\end{array}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}return\_call}]} \quad & z ; (\mathsf{return\_call}~x) &\hookrightarrow& (\mathsf{ref{.}func}~a)~(\mathsf{return\_call\_ref}~z{.}\mathsf{funcs}{}[a]{.}\mathsf{type})
  &\qquad \mbox{if}~z{.}\mathsf{module}{.}\mathsf{funcs}{}[x] = a \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}return\_call\_ref{-}label}]} \quad & z ; ({{\mathsf{label}}_{k}}{\{ {{\mathit{instr}'}^\ast} \}}~{{\mathit{val}}^\ast}~(\mathsf{return\_call\_ref}~y)~{{\mathit{instr}}^\ast}) &\hookrightarrow& {{\mathit{val}}^\ast}~(\mathsf{return\_call\_ref}~y) \\
{[\textsc{\scriptsize E{-}return\_call\_ref{-}frame{-}null}]} \quad & z ; ({{\mathsf{frame}}_{k}}{\{ f \}}~{{\mathit{val}}^\ast}~(\mathsf{ref{.}null}~{\mathit{ht}})~(\mathsf{return\_call\_ref}~y)~{{\mathit{instr}}^\ast}) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}return\_call\_ref{-}frame{-}addr}]} \quad & z ; ({{\mathsf{frame}}_{k}}{\{ f \}}~{{\mathit{val}'}^\ast}~{{\mathit{val}}^{n}}~(\mathsf{ref{.}func}~a)~(\mathsf{return\_call\_ref}~y)~{{\mathit{instr}}^\ast}) &\hookrightarrow& \multicolumn{2}{l@{}}{ {{\mathit{val}}^{n}}~(\mathsf{ref{.}func}~a)~(\mathsf{call\_ref}~y) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~z{.}\mathsf{funcs}{}[a]{.}\mathsf{type} \approx \mathsf{func}~({t_1^{n}} \rightarrow {t_2^{m}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}call\_indirect}]} \quad & (\mathsf{call\_indirect}~x~y) &\hookrightarrow& (\mathsf{table{.}get}~x)~(\mathsf{ref{.}cast}~(\mathsf{ref}~\mathsf{null}~y))~(\mathsf{call\_ref}~y) \\
{[\textsc{\scriptsize E{-}return\_call\_indirect}]} \quad & (\mathsf{return\_call\_indirect}~x~y) &\hookrightarrow& (\mathsf{table{.}get}~x)~(\mathsf{ref{.}cast}~(\mathsf{ref}~\mathsf{null}~y))~(\mathsf{return\_call\_ref}~y) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}frame{-}vals}]} \quad & ({{\mathsf{frame}}_{n}}{\{ f \}}~{{\mathit{val}}^{n}}) &\hookrightarrow& {{\mathit{val}}^{n}} \\
{[\textsc{\scriptsize E{-}return{-}frame}]} \quad & ({{\mathsf{frame}}_{n}}{\{ f \}}~{{\mathit{val}'}^\ast}~{{\mathit{val}}^{n}}~\mathsf{return}~{{\mathit{instr}}^\ast}) &\hookrightarrow& {{\mathit{val}}^{n}} \\
{[\textsc{\scriptsize E{-}return{-}label}]} \quad & ({{\mathsf{label}}_{n}}{\{ {{\mathit{instr}'}^\ast} \}}~{{\mathit{val}}^\ast}~\mathsf{return}~{{\mathit{instr}}^\ast}) &\hookrightarrow& {{\mathit{val}}^\ast}~\mathsf{return} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}trap{-}vals}]} \quad & {{\mathit{val}}^\ast}~\mathsf{trap}~{{\mathit{instr}}^\ast} &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{{\mathit{val}}^\ast} \neq \epsilon \lor {{\mathit{instr}}^\ast} \neq \epsilon \\
{[\textsc{\scriptsize E{-}trap{-}label}]} \quad & ({{\mathsf{label}}_{n}}{\{ {{\mathit{instr}'}^\ast} \}}~\mathsf{trap}) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}trap{-}frame}]} \quad & ({{\mathsf{frame}}_{n}}{\{ f \}}~\mathsf{trap}) &\hookrightarrow& \mathsf{trap} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}ctxt{-}label}]} \quad & z ; ({{\mathsf{label}}_{n}}{\{ {{\mathit{instr}}_0^\ast} \}}~{{\mathit{instr}}^\ast}) &\hookrightarrow& {z'} ; ({{\mathsf{label}}_{n}}{\{ {{\mathit{instr}}_0^\ast} \}}~{{\mathit{instr}'}^\ast})
  &\qquad \mbox{if}~z ; {{\mathit{instr}}^\ast} \hookrightarrow {z'} ; {{\mathit{instr}'}^\ast} \\
{[\textsc{\scriptsize E{-}ctxt{-}frame}]} \quad & s ; f ; ({{\mathsf{frame}}_{n}}{\{ {f'} \}}~{{\mathit{instr}}^\ast}) &\hookrightarrow& {s'} ; f ; ({{\mathsf{frame}}_{n}}{\{ {f'} \}}~{{\mathit{instr}'}^\ast})
  &\qquad \mbox{if}~s ; {f'} ; {{\mathit{instr}}^\ast} \hookrightarrow {s'} ; {f'} ; {{\mathit{instr}'}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}unop{-}val}]} \quad & ({\mathit{nt}}{.}\mathsf{const}~c_1)~({\mathit{nt}} {.} {\mathit{unop}}) &\hookrightarrow& ({\mathit{nt}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~c \in {{\mathit{unop}}}{{}_{{\mathit{nt}}}(c_1)} \\
{[\textsc{\scriptsize E{-}unop{-}trap}]} \quad & ({\mathit{nt}}{.}\mathsf{const}~c_1)~({\mathit{nt}} {.} {\mathit{unop}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{{\mathit{unop}}}{{}_{{\mathit{nt}}}(c_1)} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}binop{-}val}]} \quad & ({\mathit{nt}}{.}\mathsf{const}~c_1)~({\mathit{nt}}{.}\mathsf{const}~c_2)~({\mathit{nt}} {.} {\mathit{binop}}) &\hookrightarrow& ({\mathit{nt}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~c \in {{\mathit{binop}}}{{}_{{\mathit{nt}}}(c_1, c_2)} \\
{[\textsc{\scriptsize E{-}binop{-}trap}]} \quad & ({\mathit{nt}}{.}\mathsf{const}~c_1)~({\mathit{nt}}{.}\mathsf{const}~c_2)~({\mathit{nt}} {.} {\mathit{binop}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{{\mathit{binop}}}{{}_{{\mathit{nt}}}(c_1, c_2)} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}testop}]} \quad & ({\mathit{nt}}{.}\mathsf{const}~c_1)~({\mathit{nt}} {.} {\mathit{testop}}) &\hookrightarrow& (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~c = {{\mathit{testop}}}{{}_{{\mathit{nt}}}(c_1)} \\
{[\textsc{\scriptsize E{-}relop}]} \quad & ({\mathit{nt}}{.}\mathsf{const}~c_1)~({\mathit{nt}}{.}\mathsf{const}~c_2)~({\mathit{nt}} {.} {\mathit{relop}}) &\hookrightarrow& (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~c = {{\mathit{relop}}}{{}_{{\mathit{nt}}}(c_1, c_2)} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}cvtop{-}val}]} \quad & ({\mathit{nt}}_1{.}\mathsf{const}~c_1)~({\mathit{nt}}_2 {.} {{\mathit{cvtop}}}{\mathsf{\_}}{{\mathit{nt}}_1}) &\hookrightarrow& ({\mathit{nt}}_2{.}\mathsf{const}~c)
  &\qquad \mbox{if}~c \in {{\mathit{cvtop}}}{{}_{{\mathit{nt}}_1, {\mathit{nt}}_2}(c_1)} \\
{[\textsc{\scriptsize E{-}cvtop{-}trap}]} \quad & ({\mathit{nt}}_1{.}\mathsf{const}~c_1)~({\mathit{nt}}_2 {.} {{\mathit{cvtop}}}{\mathsf{\_}}{{\mathit{nt}}_1}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{{\mathit{cvtop}}}{{}_{{\mathit{nt}}_1, {\mathit{nt}}_2}(c_1)} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.null{-}idx}]} \quad & z ; (\mathsf{ref{.}null}~x) &\hookrightarrow& (\mathsf{ref{.}null}~z{.}\mathsf{types}{}[x]) \\
{[\textsc{\scriptsize E{-}ref.func}]} \quad & z ; (\mathsf{ref{.}func}~x) &\hookrightarrow& (\mathsf{ref{.}func}~z{.}\mathsf{module}{.}\mathsf{funcs}{}[x]) \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.i31}]} \quad & (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~\mathsf{ref{.}i{\scriptstyle 31}} &\hookrightarrow& (\mathsf{ref{.}i{\scriptstyle 31}}~{{\mathrm{wrap}}}_{32, 31}(i)) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.is\_null{-}true}]} \quad & {\mathit{ref}}~\mathsf{ref{.}is\_null} &\hookrightarrow& (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~1)
  &\qquad \mbox{if}~{\mathit{ref}} = (\mathsf{ref{.}null}~{\mathit{ht}}) \\
{[\textsc{\scriptsize E{-}ref.is\_null{-}false}]} \quad & {\mathit{ref}}~\mathsf{ref{.}is\_null} &\hookrightarrow& (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~0)
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.as\_non\_null{-}null}]} \quad & {\mathit{ref}}~\mathsf{ref{.}as\_non\_null} &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{\mathit{ref}} = (\mathsf{ref{.}null}~{\mathit{ht}}) \\
{[\textsc{\scriptsize E{-}ref.as\_non\_null{-}addr}]} \quad & {\mathit{ref}}~\mathsf{ref{.}as\_non\_null} &\hookrightarrow& {\mathit{ref}}
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.eq{-}null}]} \quad & {\mathit{ref}}_1~{\mathit{ref}}_2~\mathsf{ref{.}eq} &\hookrightarrow& (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~1)
  &\qquad \mbox{if}~{\mathit{ref}}_1 = (\mathsf{ref{.}null}~{\mathit{ht}}_1) \land {\mathit{ref}}_2 = (\mathsf{ref{.}null}~{\mathit{ht}}_2) \\
{[\textsc{\scriptsize E{-}ref.eq{-}true}]} \quad & {\mathit{ref}}_1~{\mathit{ref}}_2~\mathsf{ref{.}eq} &\hookrightarrow& (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~1)
  &\qquad \mbox{otherwise, if}~{\mathit{ref}}_1 = {\mathit{ref}}_2 \\
{[\textsc{\scriptsize E{-}ref.eq{-}false}]} \quad & {\mathit{ref}}_1~{\mathit{ref}}_2~\mathsf{ref{.}eq} &\hookrightarrow& (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~0)
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.test{-}true}]} \quad & s ; f ; {\mathit{ref}}~(\mathsf{ref{.}test}~{\mathit{rt}}) &\hookrightarrow& (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~1)
  &\qquad \mbox{if}~s \vdash {\mathit{ref}} : {\mathit{rt}'} \\
  &&&&\qquad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}'} \leq {{\mathrm{inst}}}_{f{.}\mathsf{module}}({\mathit{rt}}) \\
{[\textsc{\scriptsize E{-}ref.test{-}false}]} \quad & s ; f ; {\mathit{ref}}~(\mathsf{ref{.}test}~{\mathit{rt}}) &\hookrightarrow& (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~0)
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.cast{-}succeed}]} \quad & s ; f ; {\mathit{ref}}~(\mathsf{ref{.}cast}~{\mathit{rt}}) &\hookrightarrow& {\mathit{ref}}
  &\qquad \mbox{if}~s \vdash {\mathit{ref}} : {\mathit{rt}'} \\
  &&&&\qquad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}'} \leq {{\mathrm{inst}}}_{f{.}\mathsf{module}}({\mathit{rt}}) \\
{[\textsc{\scriptsize E{-}ref.cast{-}fail}]} \quad & s ; f ; {\mathit{ref}}~(\mathsf{ref{.}cast}~{\mathit{rt}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}i31.get{-}null}]} \quad & (\mathsf{ref{.}null}~{\mathit{ht}})~({\mathsf{i{\scriptstyle 31}{.}get}}{\mathsf{\_}}{{\mathit{sx}}}) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}i31.get{-}num}]} \quad & (\mathsf{ref{.}i{\scriptstyle 31}}~i)~({\mathsf{i{\scriptstyle 31}{.}get}}{\mathsf{\_}}{{\mathit{sx}}}) &\hookrightarrow& (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~{{{{\mathrm{extend}}}_{31, 32}^{{\mathit{sx}}}}}{(i)}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.new}]} \quad & z ; {{\mathit{val}}^{n}}~(\mathsf{struct{.}new}~x) &\hookrightarrow& z{}[{.}\mathsf{structs} \mathrel{{=}{\oplus}} {\mathit{si}}] ; (\mathsf{ref{.}struct}~a)
  &\qquad \mbox{if}~z{.}\mathsf{types}{}[x] \approx \mathsf{struct}~{({\mathsf{mut}^?}~{\mathit{zt}})^{n}} \\
  &&&&\qquad {\land}~a = {|z{.}\mathsf{structs}|} \\
  &&&&\qquad {\land}~{\mathit{si}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~z{.}\mathsf{types}{}[x],\; \mathsf{fields}~{({{\mathrm{pack}}}_{{\mathit{zt}}}({\mathit{val}}))^{n}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.new\_default}]} \quad & z ; (\mathsf{struct{.}new\_default}~x) &\hookrightarrow& {{\mathit{val}}^\ast}~(\mathsf{struct{.}new}~x)
  &\qquad \mbox{if}~z{.}\mathsf{types}{}[x] \approx \mathsf{struct}~{({\mathsf{mut}^?}~{\mathit{zt}})^\ast} \\
  &&&&\qquad {\land}~({{\mathrm{default}}}_{{\mathrm{unpack}}({\mathit{zt}})} = {\mathit{val}})^\ast \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.get{-}null}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}})~({\mathsf{struct{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~x~i) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}struct.get{-}struct}]} \quad & z ; (\mathsf{ref{.}struct}~a)~({\mathsf{struct{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~x~i) &\hookrightarrow& {{{{\mathrm{unpack}}}_{{{\mathit{zt}}^\ast}{}[i]}^{{{\mathit{sx}}^?}}}}{(z{.}\mathsf{structs}{}[a]{.}\mathsf{fields}{}[i])}
  &\qquad \mbox{if}~z{.}\mathsf{types}{}[x] \approx \mathsf{struct}~{({\mathsf{mut}^?}~{\mathit{zt}})^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.set{-}null}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}})~{\mathit{val}}~(\mathsf{struct{.}set}~x~i) &\hookrightarrow& z ; \mathsf{trap} \\
{[\textsc{\scriptsize E{-}struct.set{-}struct}]} \quad & z ; (\mathsf{ref{.}struct}~a)~{\mathit{val}}~(\mathsf{struct{.}set}~x~i) &\hookrightarrow& z{}[{.}\mathsf{structs}{}[a]{.}\mathsf{fields}{}[i] = {{\mathrm{pack}}}_{{{\mathit{zt}}^\ast}{}[i]}({\mathit{val}})] ; \epsilon
  &\qquad \mbox{if}~z{.}\mathsf{types}{}[x] \approx \mathsf{struct}~{({\mathsf{mut}^?}~{\mathit{zt}})^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new}]} \quad & {\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}new}~x) &\hookrightarrow& {{\mathit{val}}^{n}}~(\mathsf{array{.}new\_fixed}~x~n) \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new\_default}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}new\_default}~x) &\hookrightarrow& {{\mathit{val}}^{n}}~(\mathsf{array{.}new\_fixed}~x~n)
  &\qquad \mbox{if}~z{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}}) \\
  &&&&\qquad {\land}~{{\mathrm{default}}}_{{\mathrm{unpack}}({\mathit{zt}})} = {\mathit{val}} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new\_fixed}]} \quad & z ; {{\mathit{val}}^{n}}~(\mathsf{array{.}new\_fixed}~x~n) &\hookrightarrow& \multicolumn{2}{l@{}}{ z{}[{.}\mathsf{arrays} \mathrel{{=}{\oplus}} {\mathit{ai}}] ; (\mathsf{ref{.}array}~a) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~z{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}})} \\
  &&& \multicolumn{2}{l@{}}{\quad {\land}~a = {|z{.}\mathsf{arrays}|} \land {\mathit{ai}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~z{.}\mathsf{types}{}[x],\; \mathsf{fields}~{({{\mathrm{pack}}}_{{\mathit{zt}}}({\mathit{val}}))^{n}} \}\end{array}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new\_elem{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}new\_elem}~x~y) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~i + n > {|z{.}\mathsf{elems}{}[y]{.}\mathsf{refs}|} \\
{[\textsc{\scriptsize E{-}array.new\_elem{-}alloc}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}new\_elem}~x~y) &\hookrightarrow& \multicolumn{2}{l@{}}{ {{\mathit{ref}}^{n}}~(\mathsf{array{.}new\_fixed}~x~n) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{{\mathit{ref}}^{n}} = z{.}\mathsf{elems}{}[y]{.}\mathsf{refs}{}[i : n]} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new\_data{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}new\_data}~x~y) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~z{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}})} \\
  &&& \multicolumn{2}{l@{}}{\quad {\land}~i + n \cdot {|{\mathit{zt}}|} / 8 > {|z{.}\mathsf{datas}{}[y]{.}\mathsf{bytes}|}} \\
{[\textsc{\scriptsize E{-}array.new\_data{-}num}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}new\_data}~x~y) &\hookrightarrow& \multicolumn{2}{l@{}}{ {({\mathrm{unpack}}({\mathit{zt}}){.}\mathsf{const}~{{\mathrm{unpack}}}_{{\mathit{zt}}}(c))^{n}}~(\mathsf{array{.}new\_fixed}~x~n) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~z{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}})} \\
  &&& \multicolumn{2}{l@{}}{\quad {\land}~{\bigoplus}\, {{{\mathrm{bytes}}}_{{\mathit{zt}}}(c)^{n}} = z{.}\mathsf{datas}{}[y]{.}\mathsf{bytes}{}[i : n \cdot {|{\mathit{zt}}|} / 8]} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.get{-}null}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathsf{array{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~x) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.get{-}oob}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathsf{array{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~x) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~i \geq {|z{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}|} \\
{[\textsc{\scriptsize E{-}array.get{-}array}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathsf{array{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~x) &\hookrightarrow& \multicolumn{2}{l@{}}{ {{{{\mathrm{unpack}}}_{{\mathit{zt}}}^{{{\mathit{sx}}^?}}}}{(z{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}{}[i])} } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~z{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.set{-}null}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{array{.}set}~x) &\hookrightarrow& z ; \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.set{-}oob}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{array{.}set}~x) &\hookrightarrow& z ; \mathsf{trap}
  &\qquad \mbox{if}~i \geq {|z{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}|} \\
{[\textsc{\scriptsize E{-}array.set{-}array}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{array{.}set}~x) &\hookrightarrow& \multicolumn{2}{l@{}}{ z{}[{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}{}[i] = {{\mathrm{pack}}}_{{\mathit{zt}}}({\mathit{val}})] ; \epsilon } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~z{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.len{-}null}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}})~\mathsf{array{.}len} &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.len{-}array}]} \quad & z ; (\mathsf{ref{.}array}~a)~\mathsf{array{.}len} &\hookrightarrow& (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~{|z{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}|}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.fill{-}null}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}fill}~x) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.fill{-}oob}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}fill}~x) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~i + n > {|z{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}|} \\
{[\textsc{\scriptsize E{-}array.fill{-}zero}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}fill}~x) &\hookrightarrow& \epsilon
  &\qquad \mbox{otherwise, if}~n = 0 \\
{[\textsc{\scriptsize E{-}array.fill{-}succ}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}fill}~x) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{array{.}set}~x) \\ (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i + 1)~{\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{array{.}fill}~x) \end{array} }
  &\qquad \mbox{otherwise} \\
{[\textsc{\scriptsize E{-}array.copy{-}null1}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}}_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~{\mathit{ref}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}copy}~x_1~x_2) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.copy{-}null2}]} \quad & z ; {\mathit{ref}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{ref{.}null}~{\mathit{ht}}_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}copy}~x_1~x_2) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.copy{-}oob1}]} \quad & z ; (\mathsf{ref{.}array}~a_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{ref{.}array}~a_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}copy}~x_1~x_2) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~i_1 + n > {|z{.}\mathsf{arrays}{}[a_1]{.}\mathsf{fields}|}} \\
{[\textsc{\scriptsize E{-}array.copy{-}oob2}]} \quad & z ; (\mathsf{ref{.}array}~a_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{ref{.}array}~a_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}copy}~x_1~x_2) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~i_2 + n > {|z{.}\mathsf{arrays}{}[a_2]{.}\mathsf{fields}|}} \\
{[\textsc{\scriptsize E{-}array.copy{-}zero}]} \quad & z ; (\mathsf{ref{.}array}~a_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{ref{.}array}~a_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}copy}~x_1~x_2) &\hookrightarrow& \multicolumn{2}{l@{}}{ \epsilon } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{otherwise, if}~n = 0} \\
{[\textsc{\scriptsize E{-}array.copy{-}le}]} \quad & z ; (\mathsf{ref{.}array}~a_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{ref{.}array}~a_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}copy}~x_1~x_2) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{ref{.}array}~a_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1) \\ (\mathsf{ref{.}array}~a_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2) \\ ({\mathsf{array{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~x_2)~(\mathsf{array{.}set}~x_1) \\ (\mathsf{ref{.}array}~a_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1 + 1)~(\mathsf{ref{.}array}~a_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2 + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{array{.}copy}~x_1~x_2) \end{array} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{otherwise, if}~z{.}\mathsf{types}{}[x_2] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}}_2)} \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~i_1 \leq i_2 \land {{\mathit{sx}}^?} = {\mathrm{sx}}({\mathit{zt}}_2)} \\
{[\textsc{\scriptsize E{-}array.copy{-}gt}]} \quad & z ; (\mathsf{ref{.}array}~a_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{ref{.}array}~a_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}copy}~x_1~x_2) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{ref{.}array}~a_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1 + n - 1) \\ (\mathsf{ref{.}array}~a_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2 + n - 1) \\ ({\mathsf{array{.}get}}{\mathsf{\_}}{{{\mathit{sx}}^?}}~x_2)~(\mathsf{array{.}set}~x_1) \\ (\mathsf{ref{.}array}~a_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{ref{.}array}~a_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{array{.}copy}~x_1~x_2) \end{array} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{otherwise, if}~z{.}\mathsf{types}{}[x_2] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}}_2)} \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{sx}}^?} = {\mathrm{sx}}({\mathit{zt}}_2)} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.init\_elem{-}null}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_elem}~x~y) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}oob1}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_elem}~x~y) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~i + n > {|z{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}|}} \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}oob2}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_elem}~x~y) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~j + n > {|z{.}\mathsf{elems}{}[y]{.}\mathsf{refs}|}} \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}zero}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_elem}~x~y) &\hookrightarrow& \multicolumn{2}{l@{}}{ \epsilon } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{otherwise, if}~n = 0} \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}succ}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_elem}~x~y) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{ref}}~(\mathsf{array{.}set}~x) \\ (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{array{.}init\_elem}~x~y) \end{array} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{otherwise, if}~{\mathit{ref}} = z{.}\mathsf{elems}{}[y]{.}\mathsf{refs}{}[j]} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.init\_data{-}null}]} \quad & z ; (\mathsf{ref{.}null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_data}~x~y) &\hookrightarrow& \mathsf{trap} \\
{[\textsc{\scriptsize E{-}array.init\_data{-}oob1}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_data}~x~y) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~i + n > {|z{.}\mathsf{arrays}{}[a]{.}\mathsf{fields}|}} \\
{[\textsc{\scriptsize E{-}array.init\_data{-}oob2}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_data}~x~y) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~z{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}})} \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~j + n \cdot {|{\mathit{zt}}|} / 8 > {|z{.}\mathsf{datas}{}[y]{.}\mathsf{bytes}|}} \\
{[\textsc{\scriptsize E{-}array.init\_data{-}zero}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_data}~x~y) &\hookrightarrow& \multicolumn{2}{l@{}}{ \epsilon } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{otherwise, if}~n = 0} \\
{[\textsc{\scriptsize E{-}array.init\_data{-}num}]} \quad & z ; (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{array{.}init\_data}~x~y) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathrm{unpack}}({\mathit{zt}}){.}\mathsf{const}~{{\mathrm{unpack}}}_{{\mathit{zt}}}(c))~(\mathsf{array{.}set}~x) \\ (\mathsf{ref{.}array}~a)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j + {|{\mathit{zt}}|} / 8)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{array{.}init\_data}~x~y) \end{array} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{otherwise, if}~z{.}\mathsf{types}{}[x] \approx \mathsf{array}~({\mathsf{mut}^?}~{\mathit{zt}})} \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathrm{bytes}}}_{{\mathit{zt}}}(c) = z{.}\mathsf{datas}{}[y]{.}\mathsf{bytes}{}[j : {|{\mathit{zt}}|} / 8]} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}extern.convert\_any{-}null}]} \quad & (\mathsf{ref{.}null}~{\mathit{ht}})~\mathsf{extern{.}convert\_any} &\hookrightarrow& (\mathsf{ref{.}null}~\mathsf{extern}) \\
{[\textsc{\scriptsize E{-}extern.convert\_any{-}addr}]} \quad & {\mathit{addrref}}~\mathsf{extern{.}convert\_any} &\hookrightarrow& (\mathsf{ref{.}extern}~{\mathit{addrref}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}any.convert\_extern{-}null}]} \quad & (\mathsf{ref{.}null}~{\mathit{ht}})~\mathsf{any{.}convert\_extern} &\hookrightarrow& (\mathsf{ref{.}null}~\mathsf{any}) \\
{[\textsc{\scriptsize E{-}any.convert\_extern{-}addr}]} \quad & (\mathsf{ref{.}extern}~{\mathit{addrref}})~\mathsf{any{.}convert\_extern} &\hookrightarrow& {\mathit{addrref}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vvunop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}} {.} {\mathit{vvunop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~c \in {{\mathit{vvunop}}}{{}_{\mathsf{v{\scriptstyle 128}}}(c_1)} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vvbinop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~(\mathsf{v{\scriptstyle 128}} {.} {\mathit{vvbinop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~c \in {{\mathit{vvbinop}}}{{}_{\mathsf{v{\scriptstyle 128}}}(c_1, c_2)} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vvternop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_3)~(\mathsf{v{\scriptstyle 128}} {.} {\mathit{vvternop}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~c \in {{\mathit{vvternop}}}{{}_{\mathsf{v{\scriptstyle 128}}}(c_1, c_2, c_3)}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vvtestop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}} {.} \mathsf{any\_true}) &\hookrightarrow& (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~c = {{\mathrm{ine}}}_{{|\mathsf{v{\scriptstyle 128}}|}}(c_1, 0) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vunop{-}val}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({\mathit{sh}} {.} {\mathit{vunop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~c \in {{\mathit{vunop}}}{{}_{{\mathit{sh}}}(c_1)} \\
{[\textsc{\scriptsize E{-}vunop{-}trap}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({\mathit{sh}} {.} {\mathit{vunop}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{{\mathit{vunop}}}{{}_{{\mathit{sh}}}(c_1)} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vbinop{-}val}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~({\mathit{sh}} {.} {\mathit{vbinop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~c \in {{\mathit{vbinop}}}{{}_{{\mathit{sh}}}(c_1, c_2)} \\
{[\textsc{\scriptsize E{-}vbinop{-}trap}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~({\mathit{sh}} {.} {\mathit{vbinop}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~{{\mathit{vbinop}}}{{}_{{\mathit{sh}}}(c_1, c_2)} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vtestop{-}true}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)~({{\mathsf{i}}{N}}{\mathsf{x}}{M} {.} \mathsf{all\_true}) &\hookrightarrow& (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~1)
  &\qquad \mbox{if}~{{\mathit{ci}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(c) \\
  &&&&\qquad {\land}~({\mathit{ci}}_1 \neq 0)^\ast \\
{[\textsc{\scriptsize E{-}vtestop{-}false}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)~({{\mathsf{i}}{N}}{\mathsf{x}}{M} {.} \mathsf{all\_true}) &\hookrightarrow& (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~0)
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vrelop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~({\mathit{sh}} {.} {\mathit{vrelop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~{{\mathit{vrelop}}}{{}_{{\mathit{sh}}}(c_1, c_2)} = c \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vshiftop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~({{\mathsf{i}}{N}}{\mathsf{x}}{M} {.} {\mathit{vshiftop}}) &\hookrightarrow& (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~{{c'}^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(c_1) \\
  &&&&\qquad {\land}~c = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{{\mathit{vshiftop}}}{{}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}}{({c'}, n)}^\ast})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vbitmask}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)~({{\mathsf{i}}{N}}{\mathsf{x}}{M}{.}\mathsf{bitmask}) &\hookrightarrow& (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~{\mathit{ci}})
  &\qquad \mbox{if}~{{\mathit{ci}}_1^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(c) \\
  &&&&\qquad {\land}~{{\mathrm{bits}}}_{{\mathsf{i}}{32}}({\mathit{ci}}) = {{{{{\mathrm{ilt}}}_{{|{\mathsf{i}}{N}|}}^{\mathsf{s}}}}{({\mathit{ci}}_1, 0)}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vswizzle}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~({{\mathsf{i}}{N}}{\mathsf{x}}{M}{.}\mathsf{swizzle}) &\hookrightarrow& (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~{{\mathit{ci}}^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(c_2) \\
  &&&&\qquad {\land}~{{c'}^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(c_1)~{0^{256 - M}} \\
  &&&&\qquad {\land}~c = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{{c'}^\ast}{}[{{\mathit{ci}}^\ast}{}[k]]^{k<M}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vshuffle}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~({{\mathsf{i}}{N}}{\mathsf{x}}{M}{.}\mathsf{shuffle}~{i^\ast}) &\hookrightarrow& (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~{{c'}^\ast} = {{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(c_1)~{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(c_2) \\
  &&&&\qquad {\land}~c = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{{c'}^\ast}{}[{i^\ast}{}[k]]^{k<M}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vsplat}]} \quad & ({\mathrm{unpack}}({\mathsf{i}}{N}){.}\mathsf{const}~c_1)~({{\mathsf{i}}{N}}{\mathsf{x}}{M}{.}\mathsf{splat}) &\hookrightarrow& (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~c = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{{\mathrm{pack}}}_{{\mathsf{i}}{N}}(c_1)^{M}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vextract\_lane{-}num}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({{\mathit{nt}}}{\mathsf{x}}{M}{.}\mathsf{extract\_lane}~i) &\hookrightarrow& ({\mathit{nt}}{.}\mathsf{const}~c_2)
  &\qquad \mbox{if}~c_2 = {{\mathrm{lanes}}}_{{{\mathit{nt}}}{\mathsf{x}}{M}}(c_1){}[i] \\
{[\textsc{\scriptsize E{-}vextract\_lane{-}pack}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({{{\mathit{pt}}}{\mathsf{x}}{M}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{{\mathit{sx}}}~i) &\hookrightarrow& (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~c_2)
  &\qquad \mbox{if}~c_2 = {{{{\mathrm{extend}}}_{{|{\mathit{pt}}|}, 32}^{{\mathit{sx}}}}}{({{\mathrm{lanes}}}_{{{\mathit{pt}}}{\mathsf{x}}{M}}(c_1){}[i])} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vreplace\_lane}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({\mathrm{unpack}}({\mathsf{i}}{N}){.}\mathsf{const}~c_2)~({{\mathsf{i}}{N}}{\mathsf{x}}{M}{.}\mathsf{replace\_lane}~i) &\hookrightarrow& (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~c = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(c_1){}[{}[i] = {{\mathrm{pack}}}_{{\mathsf{i}}{N}}(c_2)])} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vextunop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({\mathit{sh}}_2 {.} {{\mathit{vextunop}}}{\mathsf{\_}}{{\mathit{sh}}_1}) &\hookrightarrow& (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~{{\mathit{vextunop}}}{{}_{{\mathit{sh}}_1, {\mathit{sh}}_2}(c_1)} = c \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vextbinop}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~({\mathit{sh}}_2 {.} {{\mathit{vextbinop}}}{\mathsf{\_}}{{\mathit{sh}}_1}) &\hookrightarrow& (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~{{\mathit{vextbinop}}}{{}_{{\mathit{sh}}_1, {\mathit{sh}}_2}(c_1, c_2)} = c \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vnarrow}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_2)~({{{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}{.}\mathsf{narrow}}{\mathsf{\_}}{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}}{\mathsf{\_}}{{\mathit{sx}}}) &\hookrightarrow& (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~{{\mathit{ci}}_1^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}}(c_1) \\
  &&&&\qquad {\land}~{{\mathit{ci}}_2^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}}(c_2) \\
  &&&&\qquad {\land}~{{\mathit{cj}}_1^\ast} = {{{{{\mathrm{narrow}}}_{{|{{\mathsf{i}}{N}}_1|}, {|{{\mathsf{i}}{N}}_2|}}^{{\mathit{sx}}}}}{{\mathit{ci}}_1}^\ast} \\
  &&&&\qquad {\land}~{{\mathit{cj}}_2^\ast} = {{{{{\mathrm{narrow}}}_{{|{{\mathsf{i}}{N}}_1|}, {|{{\mathsf{i}}{N}}_2|}}^{{\mathit{sx}}}}}{{\mathit{ci}}_2}^\ast} \\
  &&&&\qquad {\land}~c = {{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}^{{-1}}}}{({{\mathit{cj}}_1^\ast}~{{\mathit{cj}}_2^\ast})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vcvtop{-}full}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M} {.} {{\mathit{vcvtop}}}{\mathsf{\_}}{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M}}) &\hookrightarrow& (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~{{\mathit{ci}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M}}(c_1) \\
  &&&&\qquad {\land}~{{{\mathit{cj}}^\ast}^\ast} = \Large\times~{{{\mathrm{vcvtop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M}}({\mathit{vcvtop}}, {\mathit{ci}})^\ast} \\
  &&&&\qquad {\land}~c \in {{{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathit{cj}}^\ast})}^\ast} \\
{[\textsc{\scriptsize E{-}vcvtop{-}half}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2} {.} {{\mathit{vcvtop}}}{\mathsf{\_}}{\epsilon}{\mathsf{\_}}{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}}{\mathsf{\_}}{{\mathit{half}}}) &\hookrightarrow& (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~{{\mathit{ci}}^\ast} = {{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}}(c_1){}[{\mathrm{half}}({\mathit{half}}, 0, M_2) : M_2] \\
  &&&&\qquad {\land}~{{{\mathit{cj}}^\ast}^\ast} = \Large\times~{{{\mathrm{vcvtop}}}_{{{{\mathsf{i}}{N}}_1}{\mathsf{x}}{M_1}, {{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}({\mathit{vcvtop}}, {\mathit{ci}})^\ast} \\
  &&&&\qquad {\land}~c \in {{{{{\mathrm{lanes}}}_{{{{\mathsf{i}}{N}}_2}{\mathsf{x}}{M_2}}^{{-1}}}}{({{\mathit{cj}}^\ast})}^\ast} \\
{[\textsc{\scriptsize E{-}vcvtop{-}zero}]} \quad & (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({{\mathit{nt}}_2}{\mathsf{x}}{M_2} {.} {{\mathit{vcvtop}}}{\mathsf{\_}}{{\mathit{zero}}}{\mathsf{\_}}{{{\mathit{nt}}_1}{\mathsf{x}}{M_1}}{\mathsf{\_}}{\epsilon}) &\hookrightarrow& (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~{{\mathit{ci}}^\ast} = {{\mathrm{lanes}}}_{{{\mathit{nt}}_1}{\mathsf{x}}{M_1}}(c_1) \\
  &&&&\qquad {\land}~{{{\mathit{cj}}^\ast}^\ast} = \Large\times~({{{\mathrm{vcvtop}}}_{{{\mathit{nt}}_1}{\mathsf{x}}{M_1}, {{\mathit{nt}}_2}{\mathsf{x}}{M_2}}({\mathit{vcvtop}}, {\mathit{ci}})^\ast} \oplus {0^{M_1}}) \\
  &&&&\qquad {\land}~c \in {{{{{\mathrm{lanes}}}_{{{\mathit{nt}}_2}{\mathsf{x}}{M_2}}^{{-1}}}}{({{\mathit{cj}}^\ast})}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}local.get}]} \quad & z ; (\mathsf{local{.}get}~x) &\hookrightarrow& {\mathit{val}}
  &\qquad \mbox{if}~z{.}\mathsf{locals}{}[x] = {\mathit{val}} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}local.set}]} \quad & z ; {\mathit{val}}~(\mathsf{local{.}set}~x) &\hookrightarrow& z{}[{.}\mathsf{locals}{}[x] = {\mathit{val}}] ; \epsilon \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}local.tee}]} \quad & {\mathit{val}}~(\mathsf{local{.}tee}~x) &\hookrightarrow& {\mathit{val}}~{\mathit{val}}~(\mathsf{local{.}set}~x) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}global.get}]} \quad & z ; (\mathsf{global{.}get}~x) &\hookrightarrow& {\mathit{val}}
  &\qquad \mbox{if}~z{.}\mathsf{globals}{}[x]{.}\mathsf{value} = {\mathit{val}} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}global.set}]} \quad & z ; {\mathit{val}}~(\mathsf{global{.}set}~x) &\hookrightarrow& z{}[{.}\mathsf{globals}{}[x]{.}\mathsf{value} = {\mathit{val}}] ; \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.get{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{table{.}get}~x) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~i \geq {|z{.}\mathsf{tables}{}[x]{.}\mathsf{refs}|} \\
{[\textsc{\scriptsize E{-}table.get{-}val}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{table{.}get}~x) &\hookrightarrow& z{.}\mathsf{tables}{}[x]{.}\mathsf{refs}{}[i]
  &\qquad \mbox{if}~i < {|z{.}\mathsf{tables}{}[x]{.}\mathsf{refs}|} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.set{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{ref}}~(\mathsf{table{.}set}~x) &\hookrightarrow& z ; \mathsf{trap}
  &\qquad \mbox{if}~i \geq {|z{.}\mathsf{tables}{}[x]{.}\mathsf{refs}|} \\
{[\textsc{\scriptsize E{-}table.set{-}val}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{ref}}~(\mathsf{table{.}set}~x) &\hookrightarrow& z{}[{.}\mathsf{tables}{}[x]{.}\mathsf{refs}{}[i] = {\mathit{ref}}] ; \epsilon
  &\qquad \mbox{if}~i < {|z{.}\mathsf{tables}{}[x]{.}\mathsf{refs}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.size}]} \quad & z ; (\mathsf{table{.}size}~x) &\hookrightarrow& (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)
  &\qquad \mbox{if}~{|z{.}\mathsf{tables}{}[x]{.}\mathsf{refs}|} = n \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.grow{-}succeed}]} \quad & z ; {\mathit{ref}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{table{.}grow}~x) &\hookrightarrow& \multicolumn{2}{l@{}}{ z{}[{.}\mathsf{tables}{}[x] = {\mathit{ti}}] ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~{|z{.}\mathsf{tables}{}[x]{.}\mathsf{refs}|}) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{\mathit{ti}} = {\mathrm{growtable}}(z{.}\mathsf{tables}{}[x], n, {\mathit{ref}})} \\
{[\textsc{\scriptsize E{-}table.grow{-}fail}]} \quad & z ; {\mathit{ref}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{table{.}grow}~x) &\hookrightarrow& z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~{{{{\mathrm{signed}}}_{32}^{{-1}}}}{({-1})}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.fill{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{table{.}fill}~x) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~i + n > {|z{.}\mathsf{tables}{}[x]{.}\mathsf{refs}|} \\
{[\textsc{\scriptsize E{-}table.fill{-}zero}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{table{.}fill}~x) &\hookrightarrow& \epsilon
  &\qquad \mbox{otherwise, if}~n = 0 \\
{[\textsc{\scriptsize E{-}table.fill{-}succ}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{table{.}fill}~x) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{table{.}set}~x) \\ (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i + 1)~{\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{table{.}fill}~x) \end{array} }
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.copy{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{table{.}copy}~x~y) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~i + n > {|z{.}\mathsf{tables}{}[y]{.}\mathsf{refs}|} \lor j + n > {|z{.}\mathsf{tables}{}[x]{.}\mathsf{refs}|}} \\
{[\textsc{\scriptsize E{-}table.copy{-}zero}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{table{.}copy}~x~y) &\hookrightarrow& \epsilon
  &\qquad \mbox{otherwise, if}~n = 0 \\
{[\textsc{\scriptsize E{-}table.copy{-}le}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{table{.}copy}~x~y) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{table{.}get}~y)~(\mathsf{table{.}set}~x) \\ (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{table{.}copy}~x~y) \end{array} }
  &\qquad \mbox{otherwise, if}~j \leq i \\
{[\textsc{\scriptsize E{-}table.copy{-}gt}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{table{.}copy}~x~y) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j + n - 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i + n - 1)~(\mathsf{table{.}get}~y)~(\mathsf{table{.}set}~x) \\ (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{table{.}copy}~x~y) \end{array} }
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.init{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{table{.}init}~x~y) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~i + n > {|z{.}\mathsf{elems}{}[y]{.}\mathsf{refs}|} \lor j + n > {|z{.}\mathsf{tables}{}[x]{.}\mathsf{refs}|}} \\
{[\textsc{\scriptsize E{-}table.init{-}zero}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{table{.}init}~x~y) &\hookrightarrow& \epsilon
  &\qquad \mbox{otherwise, if}~n = 0 \\
{[\textsc{\scriptsize E{-}table.init{-}succ}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{table{.}init}~x~y) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~z{.}\mathsf{elems}{}[y]{.}\mathsf{refs}{}[i]~(\mathsf{table{.}set}~x) \\ (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{table{.}init}~x~y) \end{array} }
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}elem.drop}]} \quad & z ; (\mathsf{elem{.}drop}~x) &\hookrightarrow& z{}[{.}\mathsf{elems}{}[x]{.}\mathsf{refs} = \epsilon] ; \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}load{-}num{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathit{nt}}{.}\mathsf{load}~x~{\mathit{ao}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~i + {\mathit{ao}}{.}\mathsf{offset} + {|{\mathit{nt}}|} / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|}} \\
{[\textsc{\scriptsize E{-}load{-}num{-}val}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathit{nt}}{.}\mathsf{load}~x~{\mathit{ao}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ ({\mathit{nt}}{.}\mathsf{const}~c) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{{\mathrm{bytes}}}_{{\mathit{nt}}}(c) = z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : {|{\mathit{nt}}|} / 8]} \\
{[\textsc{\scriptsize E{-}load{-}pack{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({{\mathsf{i}}{N}{.}\mathsf{load}}{n~{\mathit{sx}}}~x~{\mathit{ao}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~i + {\mathit{ao}}{.}\mathsf{offset} + n / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|}} \\
{[\textsc{\scriptsize E{-}load{-}pack{-}val}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({{\mathsf{i}}{N}{.}\mathsf{load}}{n~{\mathit{sx}}}~x~{\mathit{ao}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ ({\mathsf{i}}{N}{.}\mathsf{const}~{{{{\mathrm{extend}}}_{n, {|{\mathsf{i}}{N}|}}^{{\mathit{sx}}}}}{(c)}) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{{\mathrm{bytes}}}_{{\mathsf{i}}{n}}(c) = z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : n / 8]} \\
{[\textsc{\scriptsize E{-}vload{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}~x~{\mathit{ao}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~i + {\mathit{ao}}{.}\mathsf{offset} + {|\mathsf{v{\scriptstyle 128}}|} / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}vload{-}val}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}~x~{\mathit{ao}}) &\hookrightarrow& (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)
  &\qquad \mbox{if}~{{\mathrm{bytes}}}_{\mathsf{v{\scriptstyle 128}}}(c) = z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : {|\mathsf{v{\scriptstyle 128}}|} / 8] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vload{-}pack{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{M}{\mathsf{x}}{K}{\mathsf{\_}}{{\mathit{sx}}}}~x~{\mathit{ao}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~i + {\mathit{ao}}{.}\mathsf{offset} + M \cdot K / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}vload{-}pack{-}val}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{M}{\mathsf{x}}{K}{\mathsf{\_}}{{\mathit{sx}}}}~x~{\mathit{ao}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~({{\mathrm{bytes}}}_{{\mathsf{i}}{M}}(j) = z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} + k \cdot M / 8 : M / 8])^{k<K}} \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~c = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{K}}^{{-1}}}}{({{{{{\mathrm{extend}}}_{M, N}^{{\mathit{sx}}}}}{(j)}^{K}})} \land N = M \cdot 2} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vload{-}splat{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{N}{\mathsf{\_}}{\mathsf{splat}}}~x~{\mathit{ao}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~i + {\mathit{ao}}{.}\mathsf{offset} + N / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}vload{-}splat{-}val}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{N}{\mathsf{\_}}{\mathsf{splat}}}~x~{\mathit{ao}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{{\mathrm{bytes}}}_{{\mathsf{i}}{N}}(j) = z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : N / 8]} \\
  &&& \multicolumn{2}{l@{}}{\quad {\land}~N = {|{\mathsf{i}}{N}|}} \\
  &&& \multicolumn{2}{l@{}}{\quad {\land}~M = 128 / N} \\
  &&& \multicolumn{2}{l@{}}{\quad {\land}~c = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({j^{M}})}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vload{-}zero{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{N}{\mathsf{\_}}{\mathsf{zero}}}~x~{\mathit{ao}}) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~i + {\mathit{ao}}{.}\mathsf{offset} + N / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}vload{-}zero{-}val}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{N}{\mathsf{\_}}{\mathsf{zero}}}~x~{\mathit{ao}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{{\mathrm{bytes}}}_{{\mathsf{i}}{N}}(j) = z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : N / 8]} \\
  &&& \multicolumn{2}{l@{}}{\quad {\land}~c = {{{{\mathrm{extend}}}_{N, 128}^{\mathsf{u}}}}{(j)}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vload\_lane{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{N}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~j) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~i + {\mathit{ao}}{.}\mathsf{offset} + N / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}vload\_lane{-}val}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c_1)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{N}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~j) &\hookrightarrow& \multicolumn{2}{l@{}}{ (\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{{\mathrm{bytes}}}_{{\mathsf{i}}{N}}(k) = z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : N / 8]} \\
  &&& \multicolumn{2}{l@{}}{\quad {\land}~N = {|{\mathsf{i}}{N}|}} \\
  &&& \multicolumn{2}{l@{}}{\quad {\land}~M = {|\mathsf{v{\scriptstyle 128}}|} / N} \\
  &&& \multicolumn{2}{l@{}}{\quad {\land}~c = {{{{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}^{{-1}}}}{({{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(c_1){}[{}[j] = k])}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}store{-}num{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathit{nt}}{.}\mathsf{const}~c)~({\mathit{nt}}{.}\mathsf{store}~x~{\mathit{ao}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ z ; \mathsf{trap} } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~i + {\mathit{ao}}{.}\mathsf{offset} + {|{\mathit{nt}}|} / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|}} \\
{[\textsc{\scriptsize E{-}store{-}num{-}val}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathit{nt}}{.}\mathsf{const}~c)~({\mathit{nt}}{.}\mathsf{store}~x~{\mathit{ao}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ z{}[{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : {|{\mathit{nt}}|} / 8] = {b^\ast}] ; \epsilon } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{b^\ast} = {{\mathrm{bytes}}}_{{\mathit{nt}}}(c)} \\
{[\textsc{\scriptsize E{-}store{-}pack{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathsf{i}}{N}{.}\mathsf{const}~c)~({{\mathit{nt}}{.}\mathsf{store}}{n}~x~{\mathit{ao}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ z ; \mathsf{trap} } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~i + {\mathit{ao}}{.}\mathsf{offset} + n / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|}} \\
{[\textsc{\scriptsize E{-}store{-}pack{-}val}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~({\mathsf{i}}{N}{.}\mathsf{const}~c)~({{\mathit{nt}}{.}\mathsf{store}}{n}~x~{\mathit{ao}}) &\hookrightarrow& \multicolumn{2}{l@{}}{ z{}[{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : n / 8] = {b^\ast}] ; \epsilon } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{b^\ast} = {{\mathrm{bytes}}}_{{\mathsf{i}}{n}}({{\mathrm{wrap}}}_{{|{\mathsf{i}}{N}|}, n}(c))} \\
{[\textsc{\scriptsize E{-}vstore{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}~x~{\mathit{ao}}) &\hookrightarrow& z ; \mathsf{trap}
  &\qquad \mbox{if}~i + {\mathit{ao}}{.}\mathsf{offset} + {|\mathsf{v{\scriptstyle 128}}|} / 8 > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}vstore{-}val}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}~x~{\mathit{ao}}) &\hookrightarrow& z{}[{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : {|\mathsf{v{\scriptstyle 128}}|} / 8] = {b^\ast}] ; \epsilon
  &\qquad \mbox{if}~{b^\ast} = {{\mathrm{bytes}}}_{\mathsf{v{\scriptstyle 128}}}(c) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}vstore\_lane{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}}{N}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~j) &\hookrightarrow& z ; \mathsf{trap}
  &\qquad \mbox{if}~i + {\mathit{ao}}{.}\mathsf{offset} + N > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}vstore\_lane{-}val}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~c)~({\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}}{N}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~j) &\hookrightarrow& z{}[{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}{}[i + {\mathit{ao}}{.}\mathsf{offset} : N / 8] = {b^\ast}] ; \epsilon
  &\qquad \mbox{if}~N = {|{\mathsf{i}}{N}|} \\
  &&&&\qquad {\land}~M = 128 / N \\
  &&&&\qquad {\land}~{b^\ast} = {{\mathrm{bytes}}}_{{\mathsf{i}}{N}}({{\mathrm{lanes}}}_{{{\mathsf{i}}{N}}{\mathsf{x}}{M}}(c){}[j]) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.size}]} \quad & z ; (\mathsf{memory{.}size}~x) &\hookrightarrow& (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)
  &\qquad \mbox{if}~n \cdot 64 \, {\mathrm{Ki}} = {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.grow{-}succeed}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{memory{.}grow}~x) &\hookrightarrow& \multicolumn{2}{l@{}}{ z{}[{.}\mathsf{mems}{}[x] = {\mathit{mi}}] ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~{|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|} / 64 \, {\mathrm{Ki}}) } \\
  &&& \multicolumn{2}{l@{}}{\quad \mbox{if}~{\mathit{mi}} = {\mathrm{growmem}}(z{.}\mathsf{mems}{}[x], n)} \\
{[\textsc{\scriptsize E{-}memory.grow{-}fail}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{memory{.}grow}~x) &\hookrightarrow& z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~{{{{\mathrm{signed}}}_{32}^{{-1}}}}{({-1})}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.fill{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{memory{.}fill}~x) &\hookrightarrow& \mathsf{trap}
  &\qquad \mbox{if}~i + n > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|} \\
{[\textsc{\scriptsize E{-}memory.fill{-}zero}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{memory{.}fill}~x) &\hookrightarrow& \epsilon
  &\qquad \mbox{otherwise, if}~n = 0 \\
{[\textsc{\scriptsize E{-}memory.fill{-}succ}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{memory{.}fill}~x) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~{\mathit{val}}~({\mathsf{i{\scriptstyle 32}}{.}\mathsf{store}}{8}~x) \\ (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i + 1)~{\mathit{val}}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{memory{.}fill}~x) \end{array} }
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.copy{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{memory{.}copy}~x_1~x_2) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~i_1 + n > {|z{.}\mathsf{mems}{}[x_1]{.}\mathsf{bytes}|} \lor i_2 + n > {|z{.}\mathsf{mems}{}[x_2]{.}\mathsf{bytes}|}} \\
{[\textsc{\scriptsize E{-}memory.copy{-}zero}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{memory{.}copy}~x_1~x_2) &\hookrightarrow& \epsilon
  &\qquad \mbox{otherwise, if}~n = 0 \\
{[\textsc{\scriptsize E{-}memory.copy{-}le}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{memory{.}copy}~x_1~x_2) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~({\mathsf{i{\scriptstyle 32}}{.}\mathsf{load}}{8~\mathsf{u}}~x_2)~({\mathsf{i{\scriptstyle 32}}{.}\mathsf{store}}{8}~x_1) \\ (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1 + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2 + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{memory{.}copy}~x_1~x_2) \end{array} }
  &\qquad \mbox{otherwise, if}~i_1 \leq i_2 \\
{[\textsc{\scriptsize E{-}memory.copy{-}gt}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{memory{.}copy}~x_1~x_2) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1 + n - 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2 + n - 1)~({\mathsf{i{\scriptstyle 32}}{.}\mathsf{load}}{8~\mathsf{u}}~x_2)~({\mathsf{i{\scriptstyle 32}}{.}\mathsf{store}}{8}~x_1) \\ (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i_2)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{memory{.}copy}~x_1~x_2) \end{array} }
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.init{-}oob}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{memory{.}init}~x~y) &\hookrightarrow& \multicolumn{2}{l@{}}{ \mathsf{trap} } \\
  & \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~i + n > {|z{.}\mathsf{datas}{}[y]{.}\mathsf{bytes}|} \lor j + n > {|z{.}\mathsf{mems}{}[x]{.}\mathsf{bytes}|}} \\
{[\textsc{\scriptsize E{-}memory.init{-}zero}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{memory{.}init}~x~y) &\hookrightarrow& \epsilon
  &\qquad \mbox{otherwise, if}~n = 0 \\
{[\textsc{\scriptsize E{-}memory.init{-}succ}]} \quad & z ; (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{memory{.}init}~x~y) &\hookrightarrow& \\
  & \multicolumn{3}{@{}l@{}}{\qquad \begin{array}[t]{@{}l@{}} (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~z{.}\mathsf{datas}{}[y]{.}\mathsf{bytes}{}[i])~({\mathsf{i{\scriptstyle 32}}{.}\mathsf{store}}{8}~x) \\ (\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~j + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~i + 1)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n - 1)~(\mathsf{memory{.}init}~x~y) \end{array} }
  &\qquad \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize E{-}data.drop}]} \quad & z ; (\mathsf{data{.}drop}~x) &\hookrightarrow& z{}[{.}\mathsf{datas}{}[x]{.}\mathsf{bytes} = \epsilon] ; \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{{\mathrm{alloctype}}^\ast}}{(\epsilon)} &=& \epsilon \\
{{{\mathrm{alloctype}}^\ast}}{({{\mathit{type}'}^\ast}~{\mathit{type}})} &=& {{\mathit{deftype}'}^\ast}~{{\mathit{deftype}}^\ast}
  &\qquad \mbox{if}~{{\mathit{deftype}'}^\ast} = {{{\mathrm{alloctype}}^\ast}}{({{\mathit{type}'}^\ast})} \\
  &&&\qquad {\land}~{\mathit{type}} = \mathsf{type}~{\mathit{rectype}} \\
  &&&\qquad {\land}~{{\mathit{deftype}}^\ast} = {{{{{\mathrm{roll}}}_{x}^\ast}}{({\mathit{rectype}})}}{{}[ {:=}\, {{\mathit{deftype}'}^\ast} ]} \\
  &&&\qquad {\land}~x = {|{{\mathit{deftype}'}^\ast}|} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocfunc}}(s, {\mathit{deftype}}, {\mathit{code}}, {\mathit{moduleinst}}) &=& \multicolumn{2}{l@{}}{ (s \oplus \{ \begin{array}[t]{@{}l@{}}
\mathsf{funcs}~{\mathit{funcinst}} \}\end{array}, {|s{.}\mathsf{funcs}|}) } \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~{\mathit{funcinst}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{deftype}},\; \mathsf{module}~{\mathit{moduleinst}},\; \mathsf{code}~{\mathit{code}} \}\end{array}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{\mathrm{allocfunc}}^\ast}}{(s, \epsilon, \epsilon, \epsilon)} &=& (s, \epsilon) \\
{{{\mathrm{allocfunc}}^\ast}}{(s, {\mathit{dt}}~{{\mathit{dt}'}^\ast}, {\mathit{code}}~{{{\mathit{code}}'}^\ast}, {\mathit{moduleinst}}~{{\mathit{moduleinst}'}^\ast})} &=& (s_2, {\mathit{fa}}~{{\mathit{fa}'}^\ast})
  &\qquad \mbox{if}~(s_1, {\mathit{fa}}) = {\mathrm{allocfunc}}(s, {\mathit{dt}}, {\mathit{code}}, {\mathit{moduleinst}}) \\
  &&&\qquad {\land}~(s_2, {{\mathit{fa}'}^\ast}) = {{{\mathrm{allocfunc}}^\ast}}{(s_1, {{\mathit{dt}'}^\ast}, {{{\mathit{code}}'}^\ast}, {{\mathit{moduleinst}'}^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocglobal}}(s, {\mathit{globaltype}}, {\mathit{val}}) &=& \multicolumn{2}{l@{}}{ (s \oplus \{ \begin{array}[t]{@{}l@{}}
\mathsf{globals}~{\mathit{globalinst}} \}\end{array}, {|s{.}\mathsf{globals}|}) } \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~{\mathit{globalinst}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{globaltype}},\; \mathsf{value}~{\mathit{val}} \}\end{array}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{\mathrm{allocglobal}}^\ast}}{(s, \epsilon, \epsilon)} &=& (s, \epsilon) \\
{{{\mathrm{allocglobal}}^\ast}}{(s, {\mathit{globaltype}}~{{\mathit{globaltype}'}^\ast}, {\mathit{val}}~{{\mathit{val}'}^\ast})} &=& (s_2, {\mathit{ga}}~{{\mathit{ga}'}^\ast})
  &\qquad \mbox{if}~(s_1, {\mathit{ga}}) = {\mathrm{allocglobal}}(s, {\mathit{globaltype}}, {\mathit{val}}) \\
  &&&\qquad {\land}~(s_2, {{\mathit{ga}'}^\ast}) = {{{\mathrm{allocglobal}}^\ast}}{(s_1, {{\mathit{globaltype}'}^\ast}, {{\mathit{val}'}^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{alloctable}}(s, {}[ i .. j ]~{\mathit{rt}}, {\mathit{ref}}) &=& \multicolumn{2}{l@{}}{ (s \oplus \{ \begin{array}[t]{@{}l@{}}
\mathsf{tables}~{\mathit{tableinst}} \}\end{array}, {|s{.}\mathsf{tables}|}) } \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~{\mathit{tableinst}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~({}[ i .. j ]~{\mathit{rt}}),\; \mathsf{refs}~{{\mathit{ref}}^{i}} \}\end{array}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{\mathrm{alloctable}}^\ast}}{(s, \epsilon, \epsilon)} &=& (s, \epsilon) \\
{{{\mathrm{alloctable}}^\ast}}{(s, {\mathit{tabletype}}~{{\mathit{tabletype}'}^\ast}, {\mathit{ref}}~{{\mathit{ref}'}^\ast})} &=& (s_2, {\mathit{ta}}~{{\mathit{ta}'}^\ast})
  &\qquad \mbox{if}~(s_1, {\mathit{ta}}) = {\mathrm{alloctable}}(s, {\mathit{tabletype}}, {\mathit{ref}}) \\
  &&&\qquad {\land}~(s_2, {{\mathit{ta}'}^\ast}) = {{{\mathrm{alloctable}}^\ast}}{(s_1, {{\mathit{tabletype}'}^\ast}, {{\mathit{ref}'}^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocmem}}(s, {}[ i .. j ]~\mathsf{page}) &=& \multicolumn{2}{l@{}}{ (s \oplus \{ \begin{array}[t]{@{}l@{}}
\mathsf{mems}~{\mathit{meminst}} \}\end{array}, {|s{.}\mathsf{mems}|}) } \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~{\mathit{meminst}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~({}[ i .. j ]~\mathsf{page}),\; \mathsf{bytes}~{(\mathtt{0x00})^{i \cdot 64 \, {\mathrm{Ki}}}} \}\end{array}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{\mathrm{allocmem}}^\ast}}{(s, \epsilon)} &=& (s, \epsilon) \\
{{{\mathrm{allocmem}}^\ast}}{(s, {\mathit{memtype}}~{{\mathit{memtype}'}^\ast})} &=& (s_2, {\mathit{ma}}~{{\mathit{ma}'}^\ast})
  &\qquad \mbox{if}~(s_1, {\mathit{ma}}) = {\mathrm{allocmem}}(s, {\mathit{memtype}}) \\
  &&&\qquad {\land}~(s_2, {{\mathit{ma}'}^\ast}) = {{{\mathrm{allocmem}}^\ast}}{(s_1, {{\mathit{memtype}'}^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocelem}}(s, {\mathit{elemtype}}, {{\mathit{ref}}^\ast}) &=& \multicolumn{2}{l@{}}{ (s \oplus \{ \begin{array}[t]{@{}l@{}}
\mathsf{elems}~{\mathit{eleminst}} \}\end{array}, {|s{.}\mathsf{elems}|}) } \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~{\mathit{eleminst}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{elemtype}},\; \mathsf{refs}~{{\mathit{ref}}^\ast} \}\end{array}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{\mathrm{allocelem}}^\ast}}{(s, \epsilon, \epsilon)} &=& (s, \epsilon) \\
{{{\mathrm{allocelem}}^\ast}}{(s, {\mathit{rt}}~{{\mathit{rt}'}^\ast}, ({{\mathit{ref}}^\ast})~{({{\mathit{ref}'}^\ast})^\ast})} &=& (s_2, {\mathit{ea}}~{{\mathit{ea}'}^\ast})
  &\qquad \mbox{if}~(s_1, {\mathit{ea}}) = {\mathrm{allocelem}}(s, {\mathit{rt}}, {{\mathit{ref}}^\ast}) \\
  &&&\qquad {\land}~(s_2, {{\mathit{ea}'}^\ast}) = {{{\mathrm{allocelem}}^\ast}}{(s_2, {{\mathit{rt}'}^\ast}, {({{\mathit{ref}'}^\ast})^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocdata}}(s, \mathsf{ok}, {{\mathit{byte}}^\ast}) &=& \multicolumn{2}{l@{}}{ (s \oplus \{ \begin{array}[t]{@{}l@{}}
\mathsf{datas}~{\mathit{datainst}} \}\end{array}, {|s{.}\mathsf{datas}|}) } \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~{\mathit{datainst}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{bytes}~{{\mathit{byte}}^\ast} \}\end{array}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{\mathrm{allocdata}}^\ast}}{(s, \epsilon, \epsilon)} &=& (s, \epsilon) \\
{{{\mathrm{allocdata}}^\ast}}{(s, {\mathit{ok}}~{{\mathit{ok}'}^\ast}, ({b^\ast})~{({{b'}^\ast})^\ast})} &=& (s_2, {\mathit{da}}~{{\mathit{da}'}^\ast})
  &\qquad \mbox{if}~(s_1, {\mathit{da}}) = {\mathrm{allocdata}}(s, {\mathit{ok}}, {b^\ast}) \\
  &&&\qquad {\land}~(s_2, {{\mathit{da}'}^\ast}) = {{{\mathrm{allocdata}}^\ast}}{(s_1, {{\mathit{ok}'}^\ast}, {({{b'}^\ast})^\ast})} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocexport}}({\mathit{moduleinst}}, \mathsf{export}~{\mathit{name}}~(\mathsf{func}~x)) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{func}~{\mathit{moduleinst}}{.}\mathsf{funcs}{}[x]) \}\end{array} \\
{\mathrm{allocexport}}({\mathit{moduleinst}}, \mathsf{export}~{\mathit{name}}~(\mathsf{global}~x)) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{global}~{\mathit{moduleinst}}{.}\mathsf{globals}{}[x]) \}\end{array} \\
{\mathrm{allocexport}}({\mathit{moduleinst}}, \mathsf{export}~{\mathit{name}}~(\mathsf{table}~x)) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{table}~{\mathit{moduleinst}}{.}\mathsf{tables}{}[x]) \}\end{array} \\
{\mathrm{allocexport}}({\mathit{moduleinst}}, \mathsf{export}~{\mathit{name}}~(\mathsf{mem}~x)) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{mem}~{\mathit{moduleinst}}{.}\mathsf{mems}{}[x]) \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{\mathrm{allocexport}}^\ast}}{({\mathit{moduleinst}}, {{\mathit{export}}^\ast})} &=& {{\mathrm{allocexport}}({\mathit{moduleinst}}, {\mathit{export}})^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocmodule}}(s, {\mathit{module}}, {{\mathit{externval}}^\ast}, {{\mathit{val}}_{\mathsf{g}}^\ast}, {{\mathit{ref}}_{\mathsf{t}}^\ast}, {({{\mathit{ref}}_{\mathsf{e}}^\ast})^\ast}) &=& \multicolumn{2}{l@{}}{ (s_6, {\mathit{moduleinst}}) } \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~{\mathit{module}} = \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{func}}^\ast} = {(\mathsf{func}~x~{{\mathit{local}}^\ast}~{\mathit{expr}}_{\mathsf{f}})^\ast}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{global}}^\ast} = {(\mathsf{global}~{\mathit{globaltype}}~{\mathit{expr}}_{\mathsf{g}})^\ast}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{table}}^\ast} = {(\mathsf{table}~{\mathit{tabletype}}~{\mathit{expr}}_{\mathsf{t}})^\ast}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{mem}}^\ast} = {(\mathsf{memory}~{\mathit{memtype}})^\ast}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{elem}}^\ast} = {(\mathsf{elem}~{\mathit{elemtype}}~{{\mathit{expr}}_{\mathsf{e}}^\ast}~{\mathit{elemmode}})^\ast}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{data}}^\ast} = {(\mathsf{data}~{{\mathit{byte}}^\ast}~{\mathit{datamode}})^\ast}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{fa}}_{\mathsf{i}}^\ast} = {\mathrm{funcs}}({{\mathit{externval}}^\ast})} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{ga}}_{\mathsf{i}}^\ast} = {\mathrm{globals}}({{\mathit{externval}}^\ast})} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{ta}}_{\mathsf{i}}^\ast} = {\mathrm{tables}}({{\mathit{externval}}^\ast})} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{ma}}_{\mathsf{i}}^\ast} = {\mathrm{mems}}({{\mathit{externval}}^\ast})} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{fa}}^\ast} = {({|s{.}\mathsf{funcs}|} + i_{\mathsf{f}})^{i_{\mathsf{f}}<{|{{\mathit{func}}^\ast}|}}}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{ga}}^\ast} = {({|s{.}\mathsf{globals}|} + i_{\mathsf{g}})^{i_{\mathsf{g}}<{|{{\mathit{global}}^\ast}|}}}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{ta}}^\ast} = {({|s{.}\mathsf{tables}|} + i_{\mathsf{t}})^{i_{\mathsf{t}}<{|{{\mathit{table}}^\ast}|}}}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{ma}}^\ast} = {({|s{.}\mathsf{mems}|} + i_{\mathsf{m}})^{i_{\mathsf{m}}<{|{{\mathit{mem}}^\ast}|}}}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{ea}}^\ast} = {({|s{.}\mathsf{elems}|} + i_{\mathsf{e}})^{i_{\mathsf{e}}<{|{{\mathit{elem}}^\ast}|}}}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{da}}^\ast} = {({|s{.}\mathsf{datas}|} + i_{\mathsf{d}})^{i_{\mathsf{d}}<{|{{\mathit{data}}^\ast}|}}}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{dt}}^\ast} = {{{\mathrm{alloctype}}^\ast}}{({{\mathit{type}}^\ast})}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~(s_1, {{\mathit{fa}}^\ast}) = {{{\mathrm{allocfunc}}^\ast}}{(s, {{{\mathit{dt}}^\ast}{}[x]^\ast}, {(\mathsf{func}~x~{{\mathit{local}}^\ast}~{\mathit{expr}}_{\mathsf{f}})^\ast}, {{\mathit{moduleinst}}^{{|{{\mathit{func}}^\ast}|}}})}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~(s_2, {{\mathit{ga}}^\ast}) = {{{\mathrm{allocglobal}}^\ast}}{(s_1, {{\mathit{globaltype}}^\ast}, {{\mathit{val}}_{\mathsf{g}}^\ast})}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~(s_3, {{\mathit{ta}}^\ast}) = {{{\mathrm{alloctable}}^\ast}}{(s_2, {{\mathit{tabletype}}^\ast}, {{\mathit{ref}}_{\mathsf{t}}^\ast})}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~(s_4, {{\mathit{ma}}^\ast}) = {{{\mathrm{allocmem}}^\ast}}{(s_3, {{\mathit{memtype}}^\ast})}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~(s_5, {{\mathit{ea}}^\ast}) = {{{\mathrm{allocelem}}^\ast}}{(s_4, {{\mathit{elemtype}}^\ast}, {({{\mathit{ref}}_{\mathsf{e}}^\ast})^\ast})}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~(s_6, {{\mathit{da}}^\ast}) = {{{\mathrm{allocdata}}^\ast}}{(s_5, {\mathsf{ok}^{{|{{\mathit{data}}^\ast}|}}}, {({{\mathit{byte}}^\ast})^\ast})}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{xi}}^\ast} = {{{\mathrm{allocexport}}^\ast}}{(\{ \begin{array}[t]{@{}l@{}}
\mathsf{funcs}~{{\mathit{fa}}_{\mathsf{i}}^\ast}~{{\mathit{fa}}^\ast},\; \mathsf{globals}~{{\mathit{ga}}_{\mathsf{i}}^\ast}~{{\mathit{ga}}^\ast},\; \mathsf{tables}~{{\mathit{ta}}_{\mathsf{i}}^\ast}~{{\mathit{ta}}^\ast},\; \mathsf{mems}~{{\mathit{ma}}_{\mathsf{i}}^\ast}~{{\mathit{ma}}^\ast} \}\end{array}, {{\mathit{export}}^\ast})}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{\mathit{moduleinst}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{types}~{{\mathit{dt}}^\ast},\; \\
  \mathsf{funcs}~{{\mathit{fa}}_{\mathsf{i}}^\ast}~{{\mathit{fa}}^\ast},\; \mathsf{globals}~{{\mathit{ga}}_{\mathsf{i}}^\ast}~{{\mathit{ga}}^\ast},\; \\
  \mathsf{tables}~{{\mathit{ta}}_{\mathsf{i}}^\ast}~{{\mathit{ta}}^\ast},\; \mathsf{mems}~{{\mathit{ma}}_{\mathsf{i}}^\ast}~{{\mathit{ma}}^\ast},\; \\
  \mathsf{elems}~{{\mathit{ea}}^\ast},\; \mathsf{datas}~{{\mathit{da}}^\ast},\; \\
  \mathsf{exports}~{{\mathit{xi}}^\ast} \}\end{array}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{runelem}}}_{x}(\mathsf{elem}~{\mathit{rt}}~{e^{n}}~(\mathsf{passive})) &=& \epsilon \\
{{\mathrm{runelem}}}_{x}(\mathsf{elem}~{\mathit{rt}}~{e^{n}}~(\mathsf{declare})) &=& (\mathsf{elem{.}drop}~x) \\
{{\mathrm{runelem}}}_{x}(\mathsf{elem}~{\mathit{rt}}~{e^{n}}~(\mathsf{active}~y~{{\mathit{instr}}^\ast})) &=& {{\mathit{instr}}^\ast}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~0)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{table{.}init}~y~x)~(\mathsf{elem{.}drop}~x) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{rundata}}}_{x}(\mathsf{data}~{b^{n}}~(\mathsf{passive})) &=& \epsilon \\
{{\mathrm{rundata}}}_{x}(\mathsf{data}~{b^{n}}~(\mathsf{active}~y~{{\mathit{instr}}^\ast})) &=& {{\mathit{instr}}^\ast}~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~0)~(\mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n)~(\mathsf{memory{.}init}~y~x)~(\mathsf{data{.}drop}~x) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{instantiate}}(s, {\mathit{module}}, {{\mathit{externval}}^\ast}) &=& \multicolumn{2}{l@{}}{ {s'} ; f ; {{\mathit{instr}}_{\mathsf{e}}^\ast}~{{\mathit{instr}}_{\mathsf{d}}^\ast}~{{\mathit{instr}}_{\mathsf{s}}^?} } \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~{\vdash}\, {\mathit{module}} : {{\mathit{xt}}_{\mathsf{i}}^\ast} \rightarrow {{\mathit{xt}}_{\mathsf{e}}^\ast}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~(s \vdash {\mathit{externval}} : {\mathit{xt}}_{\mathsf{i}})^\ast} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{\mathit{module}} = \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{global}}^\ast} = {(\mathsf{global}~{\mathit{globaltype}}~{\mathit{expr}}_{\mathsf{g}})^\ast}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{table}}^\ast} = {(\mathsf{table}~{\mathit{tabletype}}~{\mathit{expr}}_{\mathsf{t}})^\ast}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{elem}}^\ast} = {(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}_{\mathsf{e}}^\ast}~{\mathit{elemmode}})^\ast}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{data}}^\ast} = {(\mathsf{data}~{{\mathit{byte}}^\ast}~{\mathit{datamode}})^\ast}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{start}}^?} = {(\mathsf{start}~x)^?}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{\mathit{moduleinst}}_0 = \{ \begin{array}[t]{@{}l@{}}
\mathsf{types}~{{{\mathrm{alloctype}}^\ast}}{({{\mathit{type}}^\ast})},\; \\
  \mathsf{funcs}~{\mathrm{funcs}}({{\mathit{externval}}^\ast})~{({|s{.}\mathsf{funcs}|} + i_{\mathsf{f}})^{i_{\mathsf{f}}<{|{{\mathit{func}}^\ast}|}}},\; \\
  \mathsf{globals}~{\mathrm{globals}}({{\mathit{externval}}^\ast}) \}\end{array}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~z = s ; \{ \begin{array}[t]{@{}l@{}}
\mathsf{module}~{\mathit{moduleinst}}_0 \}\end{array}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~(z ; {\mathit{expr}}_{\mathsf{g}} \hookrightarrow^\ast z ; {\mathit{val}}_{\mathsf{g}})^\ast} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~(z ; {\mathit{expr}}_{\mathsf{t}} \hookrightarrow^\ast z ; {\mathit{ref}}_{\mathsf{t}})^\ast} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{(z ; {\mathit{expr}}_{\mathsf{e}} \hookrightarrow^\ast z ; {\mathit{ref}}_{\mathsf{e}})^\ast}^\ast} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~({s'}, {\mathit{moduleinst}}) = {\mathrm{allocmodule}}(s, {\mathit{module}}, {{\mathit{externval}}^\ast}, {{\mathit{val}}_{\mathsf{g}}^\ast}, {{\mathit{ref}}_{\mathsf{t}}^\ast}, {({{\mathit{ref}}_{\mathsf{e}}^\ast})^\ast})} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~f = \{ \begin{array}[t]{@{}l@{}}
\mathsf{module}~{\mathit{moduleinst}} \}\end{array}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{instr}}_{\mathsf{e}}^\ast} = {\bigoplus}\, {{{\mathrm{runelem}}}_{i_{\mathsf{e}}}({{\mathit{elem}}^\ast}{}[i_{\mathsf{e}}])^{i_{\mathsf{e}}<{|{{\mathit{elem}}^\ast}|}}}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{instr}}_{\mathsf{d}}^\ast} = {\bigoplus}\, {{{\mathrm{rundata}}}_{i_{\mathsf{d}}}({{\mathit{data}}^\ast}{}[i_{\mathsf{d}}])^{i_{\mathsf{d}}<{|{{\mathit{data}}^\ast}|}}}} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~{{\mathit{instr}}_{\mathsf{s}}^?} = {(\mathsf{call}~x)^?}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{invoke}}(s, {\mathit{funcaddr}}, {{\mathit{val}}^\ast}) &=& \multicolumn{2}{l@{}}{ s ; f ; {{\mathit{val}}^\ast}~(\mathsf{ref{.}func}~{\mathit{funcaddr}})~(\mathsf{call\_ref}~s{.}\mathsf{funcs}{}[{\mathit{funcaddr}}]{.}\mathsf{type}) } \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad \mbox{if}~s{.}\mathsf{funcs}{}[{\mathit{funcaddr}}]{.}\mathsf{type} \approx \mathsf{func}~({t_1^\ast} \rightarrow {t_2^\ast})} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~(s \vdash {\mathit{val}} : t_1)^\ast} \\
   \multicolumn{4}{@{}l@{}}{\qquad\quad {\land}~f = \{ \begin{array}[t]{@{}l@{}}
\mathsf{module}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \}\end{array}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{list}}({\mathtt{X}}) &::=& n{:}{\mathtt{u32}}~~{({\mathit{el}}{:}{\mathtt{X}})^{n}} &\quad\Rightarrow&\quad {{\mathit{el}}^{n}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{byte}} &::=& b{:}\mathtt{0x00} ~|~ \ldots ~|~ b{:}\mathtt{0xFF} &\quad\Rightarrow&\quad b \\
& {{\mathtt{u}}}{N} &::=& n{:}{\mathtt{byte}} &\quad\Rightarrow&\quad n
  &\qquad \mbox{if}~n < {2^{7}} \land n < {2^{N}} \\ &&|&
n{:}{\mathtt{byte}}~~m{:}{{\mathtt{u}}}{(N - 7)} &\quad\Rightarrow&\quad {2^{7}} \cdot m + (n - {2^{7}})
  &\qquad \mbox{if}~n \geq {2^{7}} \land N > 7 \\
& {{\mathtt{s}}}{N} &::=& n{:}{\mathtt{byte}} &\quad\Rightarrow&\quad n
  &\qquad \mbox{if}~n < {2^{6}} \land n < {2^{N - 1}} \\ &&|&
n{:}{\mathtt{byte}} &\quad\Rightarrow&\quad n - {2^{7}}
  &\qquad \mbox{if}~{2^{6}} \leq n < {2^{7}} \land n \geq {2^{7}} - {2^{N - 1}} \\ &&|&
n{:}{\mathtt{byte}}~~i{:}{{\mathtt{u}}}{(N - 7)} &\quad\Rightarrow&\quad {2^{7}} \cdot i + (n - {2^{7}})
  &\qquad \mbox{if}~n \geq {2^{7}} \land N > 7 \\
& {{\mathtt{i}}}{N} &::=& i{:}{{\mathtt{s}}}{N} &\quad\Rightarrow&\quad {{{{\mathrm{signed}}}_{N}^{{-1}}}}{(i)} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {{\mathtt{f}}}{N} &::=& {b^\ast}{:}{{\mathtt{byte}}^{N / 8}} &\quad\Rightarrow&\quad {{{{\mathrm{bytes}}}_{{\mathsf{f}}{N}}^{{-1}}}}{({b^\ast})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{u32}} &::=& n{:}{{\mathtt{u}}}{32} &\quad\Rightarrow&\quad n \\
& {\mathtt{u64}} &::=& n{:}{{\mathtt{u}}}{64} &\quad\Rightarrow&\quad n \\
& {\mathtt{s33}} &::=& i{:}{{\mathtt{s}}}{33} &\quad\Rightarrow&\quad i \\
& {\mathtt{f32}} &::=& p{:}{{\mathtt{f}}}{32} &\quad\Rightarrow&\quad p \\
& {\mathtt{f64}} &::=& p{:}{{\mathtt{f}}}{64} &\quad\Rightarrow&\quad p \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{cont}}(b) &=& b - \mathtt{0x80}
  &\qquad \mbox{if}~(\mathtt{0x80} < b < \mathtt{0xC0}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{utf{\kern-0.1em\scriptstyle 8}}}({{\mathit{ch}}^\ast}) &=& {\bigoplus}\, {{\mathrm{utf{\kern-0.1em\scriptstyle 8}}}({\mathit{ch}})^\ast} \\
{\mathrm{utf{\kern-0.1em\scriptstyle 8}}}({\mathit{ch}}) &=& b
  &\qquad \mbox{if}~{\mathit{ch}} < \mathrm{U{+}80} \\
  &&&\qquad {\land}~{\mathit{ch}} = b \\
{\mathrm{utf{\kern-0.1em\scriptstyle 8}}}({\mathit{ch}}) &=& b_1~b_2
  &\qquad \mbox{if}~\mathrm{U{+}80} \leq {\mathit{ch}} < \mathrm{U{+}0800} \\
  &&&\qquad {\land}~{\mathit{ch}} = {2^{6}} \cdot (b_1 - \mathtt{0xC0}) + {\mathrm{cont}}(b_2) \\
{\mathrm{utf{\kern-0.1em\scriptstyle 8}}}({\mathit{ch}}) &=& b_1~b_2~b_3
  &\qquad \mbox{if}~\mathrm{U{+}0800} \leq {\mathit{ch}} < \mathrm{U{+}D800} \lor \mathrm{U{+}E000} \leq {\mathit{ch}} < \mathrm{U{+}10000} \\
  &&&\qquad {\land}~{\mathit{ch}} = {2^{12}} \cdot (b_1 - \mathtt{0xE0}) + {2^{6}} \cdot {\mathrm{cont}}(b_2) + {\mathrm{cont}}(b_3) \\
{\mathrm{utf{\kern-0.1em\scriptstyle 8}}}({\mathit{ch}}) &=& b_1~b_2~b_3~b_4
  &\qquad \mbox{if}~\mathrm{U{+}10000} \leq {\mathit{ch}} < \mathrm{U{+}11000} \\
  &&&\qquad {\land}~{\mathit{ch}} = {2^{18}} \cdot (b_1 - \mathtt{0xF0}) + {2^{12}} \cdot {\mathrm{cont}}(b_2) + {2^{6}} \cdot {\mathrm{cont}}(b_3) + {\mathrm{cont}}(b_4) \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{name}} &::=& {b^\ast}{:}{\mathtt{list}}({\mathtt{byte}}) &\quad\Rightarrow&\quad {\mathit{name}}
  &\qquad \mbox{if}~{\mathrm{utf{\kern-0.1em\scriptstyle 8}}}({\mathit{name}}) = {b^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{typeidx}} &::=& x{:}{\mathtt{u32}} &\quad\Rightarrow&\quad x \\
& {\mathtt{funcidx}} &::=& x{:}{\mathtt{u32}} &\quad\Rightarrow&\quad x \\
& {\mathtt{globalidx}} &::=& x{:}{\mathtt{u32}} &\quad\Rightarrow&\quad x \\
& {\mathtt{tableidx}} &::=& x{:}{\mathtt{u32}} &\quad\Rightarrow&\quad x \\
& {\mathtt{memidx}} &::=& x{:}{\mathtt{u32}} &\quad\Rightarrow&\quad x \\
& {\mathtt{elemidx}} &::=& x{:}{\mathtt{u32}} &\quad\Rightarrow&\quad x \\
& {\mathtt{dataidx}} &::=& x{:}{\mathtt{u32}} &\quad\Rightarrow&\quad x \\
& {\mathtt{localidx}} &::=& x{:}{\mathtt{u32}} &\quad\Rightarrow&\quad x \\
& {\mathtt{labelidx}} &::=& l{:}{\mathtt{u32}} &\quad\Rightarrow&\quad l \\
& {\mathtt{externidx}} &::=& \mathtt{0x00}~~x{:}{\mathtt{funcidx}} &\quad\Rightarrow&\quad \mathsf{func}~x \\ &&|&
\mathtt{0x01}~~x{:}{\mathtt{tableidx}} &\quad\Rightarrow&\quad \mathsf{table}~x \\ &&|&
\mathtt{0x02}~~x{:}{\mathtt{memidx}} &\quad\Rightarrow&\quad \mathsf{mem}~x \\ &&|&
\mathtt{0x03}~~x{:}{\mathtt{globalidx}} &\quad\Rightarrow&\quad \mathsf{global}~x \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{numtype}} &::=& \mathtt{0x7C} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} \\ &&|&
\mathtt{0x7D} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} \\ &&|&
\mathtt{0x7E} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} \\ &&|&
\mathtt{0x7F} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} \\
& {\mathtt{vectype}} &::=& \mathtt{0x7B} &\quad\Rightarrow&\quad \mathsf{v{\scriptstyle 128}} \\
& {\mathtt{absheaptype}} &::=& \mathtt{0x6A} &\quad\Rightarrow&\quad \mathsf{array} \\ &&|&
\mathtt{0x6B} &\quad\Rightarrow&\quad \mathsf{struct} \\ &&|&
\mathtt{0x6C} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 31}} \\ &&|&
\mathtt{0x6D} &\quad\Rightarrow&\quad \mathsf{eq} \\ &&|&
\mathtt{0x6E} &\quad\Rightarrow&\quad \mathsf{any} \\ &&|&
\mathtt{0x6F} &\quad\Rightarrow&\quad \mathsf{extern} \\ &&|&
\mathtt{0x70} &\quad\Rightarrow&\quad \mathsf{func} \\ &&|&
\mathtt{0x71} &\quad\Rightarrow&\quad \mathsf{none} \\ &&|&
\mathtt{0x72} &\quad\Rightarrow&\quad \mathsf{noextern} \\ &&|&
\mathtt{0x73} &\quad\Rightarrow&\quad \mathsf{nofunc} \\
& {\mathtt{heaptype}} &::=& {\mathit{ht}}{:}{\mathtt{absheaptype}} &\quad\Rightarrow&\quad {\mathit{ht}} \\ &&|&
x{:}{\mathtt{s33}} &\quad\Rightarrow&\quad x
  &\qquad \mbox{if}~x \geq 0 \\
& {\mathtt{reftype}} &::=& \mathtt{0x63}~~{\mathit{ht}}{:}{\mathtt{heaptype}} &\quad\Rightarrow&\quad \mathsf{ref}~\mathsf{null}~{\mathit{ht}} \\ &&|&
\mathtt{0x64}~~{\mathit{ht}}{:}{\mathtt{heaptype}} &\quad\Rightarrow&\quad \mathsf{ref}~{\mathit{ht}} \\ &&|&
{\mathit{ht}}{:}{\mathtt{absheaptype}} &\quad\Rightarrow&\quad \mathsf{ref}~\mathsf{null}~{\mathit{ht}} \\
& {\mathtt{valtype}} &::=& {\mathit{nt}}{:}{\mathtt{numtype}} &\quad\Rightarrow&\quad {\mathit{nt}} \\ &&|&
{\mathit{vt}}{:}{\mathtt{vectype}} &\quad\Rightarrow&\quad {\mathit{vt}} \\ &&|&
{\mathit{rt}}{:}{\mathtt{reftype}} &\quad\Rightarrow&\quad {\mathit{rt}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{resulttype}} &::=& {t^\ast}{:}{\mathtt{list}}({\mathtt{valtype}}) &\quad\Rightarrow&\quad {t^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{mut}} &::=& \mathtt{0x00} &\quad\Rightarrow&\quad \epsilon \\ &&|&
\mathtt{0x01} &\quad\Rightarrow&\quad \mathsf{mut} \\
& {\mathtt{packtype}} &::=& \mathtt{0x77} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 16}} \\ &&|&
\mathtt{0x78} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 8}} \\
& {\mathtt{storagetype}} &::=& t{:}{\mathtt{valtype}} &\quad\Rightarrow&\quad t \\ &&|&
{\mathit{pt}}{:}{\mathtt{packtype}} &\quad\Rightarrow&\quad {\mathit{pt}} \\
& {\mathtt{fieldtype}} &::=& {\mathit{zt}}{:}{\mathtt{storagetype}}~~{\mathsf{mut}^?}{:}{\mathtt{mut}} &\quad\Rightarrow&\quad {\mathsf{mut}^?}~{\mathit{zt}} \\
& {\mathtt{comptype}} &::=& \mathtt{0x5E}~~{\mathit{yt}}{:}{\mathtt{fieldtype}} &\quad\Rightarrow&\quad \mathsf{array}~{\mathit{yt}} \\ &&|&
\mathtt{0x5F}~~{{\mathit{yt}}^\ast}{:}{\mathtt{list}}({\mathtt{fieldtype}}) &\quad\Rightarrow&\quad \mathsf{struct}~{{\mathit{yt}}^\ast} \\ &&|&
\mathtt{0x60}~~{t_1^\ast}{:}{\mathtt{resulttype}}~~{t_2^\ast}{:}{\mathtt{resulttype}} &\quad\Rightarrow&\quad \mathsf{func}~({t_1^\ast} \rightarrow {t_2^\ast}) \\
& {\mathtt{subtype}} &::=& \mathtt{0x4F}~~{x^\ast}{:}{\mathtt{list}}({\mathtt{typeidx}})~~{\mathit{ct}}{:}{\mathtt{comptype}} &\quad\Rightarrow&\quad \mathsf{sub}~\mathsf{final}~{x^\ast}~{\mathit{ct}} \\ &&|&
\mathtt{0x50}~~{x^\ast}{:}{\mathtt{list}}({\mathtt{typeidx}})~~{\mathit{ct}}{:}{\mathtt{comptype}} &\quad\Rightarrow&\quad \mathsf{sub}~{x^\ast}~{\mathit{ct}} \\ &&|&
{\mathit{ct}}{:}{\mathtt{comptype}} &\quad\Rightarrow&\quad \mathsf{sub}~\mathsf{final}~\epsilon~{\mathit{ct}} \\
& {\mathtt{rectype}} &::=& \mathtt{0x4E}~~{{\mathit{st}}^\ast}{:}{\mathtt{list}}({\mathtt{subtype}}) &\quad\Rightarrow&\quad \mathsf{rec}~{{\mathit{st}}^\ast} \\ &&|&
{\mathit{st}}{:}{\mathtt{subtype}} &\quad\Rightarrow&\quad \mathsf{rec}~{\mathit{st}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{limits}} &::=& \mathtt{0x00}~~n{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {}[ n .. {2^{32}} - 1 ] \\ &&|&
\mathtt{0x01}~~n{:}{\mathtt{u32}}~~m{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {}[ n .. m ] \\
& {\mathtt{globaltype}} &::=& t{:}{\mathtt{valtype}}~~{\mathsf{mut}^?}{:}{\mathtt{mut}} &\quad\Rightarrow&\quad {\mathsf{mut}^?}~t \\
& {\mathtt{tabletype}} &::=& {\mathit{rt}}{:}{\mathtt{reftype}}~~{\mathit{lim}}{:}{\mathtt{limits}} &\quad\Rightarrow&\quad {\mathit{lim}}~{\mathit{rt}} \\
& {\mathtt{memtype}} &::=& {\mathit{lim}}{:}{\mathtt{limits}} &\quad\Rightarrow&\quad {\mathit{lim}}~\mathsf{page} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{externtype}} &::=& \mathtt{0x00}~~x{:}{\mathtt{typeidx}} &\quad\Rightarrow&\quad \mathsf{func}~x \\ &&|&
\mathtt{0x01}~~{\mathit{tt}}{:}{\mathtt{tabletype}} &\quad\Rightarrow&\quad \mathsf{table}~{\mathit{tt}} \\ &&|&
\mathtt{0x02}~~{\mathit{mt}}{:}{\mathtt{memtype}} &\quad\Rightarrow&\quad \mathsf{mem}~{\mathit{mt}} \\ &&|&
\mathtt{0x03}~~{\mathit{gt}}{:}{\mathtt{globaltype}} &\quad\Rightarrow&\quad \mathsf{global}~{\mathit{gt}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{blocktype}} &::=& \mathtt{0x40} &\quad\Rightarrow&\quad \epsilon \\ &&|&
t{:}{\mathtt{valtype}} &\quad\Rightarrow&\quad t \\ &&|&
i{:}{\mathtt{s33}} &\quad\Rightarrow&\quad i
  &\qquad \mbox{if}~i \geq 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{instr}} &::=& \mathtt{0x00} &\quad\Rightarrow&\quad \mathsf{unreachable} \\ &&|&
\mathtt{0x01} &\quad\Rightarrow&\quad \mathsf{nop} \\ &&|&
\mathtt{0x02}~~{\mathit{bt}}{:}{\mathtt{blocktype}}~~{({\mathit{in}}{:}{\mathtt{instr}})^\ast}~~\mathtt{0x0B} &\quad\Rightarrow&\quad \mathsf{block}~{\mathit{bt}}~{{\mathit{in}}^\ast} \\ &&|&
\mathtt{0x03}~~{\mathit{bt}}{:}{\mathtt{blocktype}}~~{({\mathit{in}}{:}{\mathtt{instr}})^\ast}~~\mathtt{0x0B} &\quad\Rightarrow&\quad \mathsf{loop}~{\mathit{bt}}~{{\mathit{in}}^\ast} \\ &&|&
\mathtt{0x04}~~{\mathit{bt}}{:}{\mathtt{blocktype}}~~{({\mathit{in}}{:}{\mathtt{instr}})^\ast}~~\mathtt{0x0B} &\quad\Rightarrow&\quad \mathsf{if}~{\mathit{bt}}~{{\mathit{in}}^\ast}~\mathsf{else}~\epsilon \\ &&|&
\mathtt{0x04}~~{\mathit{bt}}{:}{\mathtt{blocktype}}~~{({\mathit{in}}_1{:}{\mathtt{instr}})^\ast} \\ &&& \mathtt{0x05}~~{({\mathit{in}}_2{:}{\mathtt{instr}})^\ast}~~\mathtt{0x0B} &\quad\Rightarrow&\quad \mathsf{if}~{\mathit{bt}}~{{\mathit{in}}_1^\ast}~\mathsf{else}~{{\mathit{in}}_2^\ast} \\ &&|&
\mathtt{0x0C}~~l{:}{\mathtt{labelidx}} &\quad\Rightarrow&\quad \mathsf{br}~l \\ &&|&
\mathtt{0x0D}~~l{:}{\mathtt{labelidx}} &\quad\Rightarrow&\quad \mathsf{br\_if}~l \\ &&|&
\mathtt{0x0E}~~{l^\ast}{:}{\mathtt{list}}({\mathtt{labelidx}})~~l_n{:}{\mathtt{labelidx}} &\quad\Rightarrow&\quad \mathsf{br\_table}~{l^\ast}~l_n \\ &&|&
\mathtt{0x0F} &\quad\Rightarrow&\quad \mathsf{return} \\ &&|&
\mathtt{0x10}~~x{:}{\mathtt{funcidx}} &\quad\Rightarrow&\quad \mathsf{call}~x \\ &&|&
\mathtt{0x11}~~y{:}{\mathtt{typeidx}}~~x{:}{\mathtt{tableidx}} &\quad\Rightarrow&\quad \mathsf{call\_indirect}~x~y \\ &&|&
\mathtt{0x12}~~x{:}{\mathtt{funcidx}} &\quad\Rightarrow&\quad \mathsf{return\_call}~x \\ &&|&
\mathtt{0x13}~~y{:}{\mathtt{typeidx}}~~x{:}{\mathtt{tableidx}} &\quad\Rightarrow&\quad \mathsf{return\_call\_indirect}~x~y \\ &&|&
\ldots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{castop}} &::=& ({\mathsf{null}^?}, {\mathsf{null}^?}) \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{castop}} &::=& \mathtt{0x00} &\quad\Rightarrow&\quad (\epsilon, \epsilon) \\ &&|&
\mathtt{0x01} &\quad\Rightarrow&\quad (\mathsf{null}, \epsilon) \\ &&|&
\mathtt{0x02} &\quad\Rightarrow&\quad (\epsilon, \mathsf{null}) \\ &&|&
\mathtt{0x03} &\quad\Rightarrow&\quad (\mathsf{null}, \mathsf{null}) \\
& {\mathtt{instr}} &::=& \ldots \\ &&|&
\mathtt{0xD0}~~{\mathit{ht}}{:}{\mathtt{heaptype}} &\quad\Rightarrow&\quad \mathsf{ref{.}null}~{\mathit{ht}} \\ &&|&
\mathtt{0xD1} &\quad\Rightarrow&\quad \mathsf{ref{.}is\_null} \\ &&|&
\mathtt{0xD2}~~x{:}{\mathtt{funcidx}} &\quad\Rightarrow&\quad \mathsf{ref{.}func}~x \\ &&|&
\mathtt{0xD3} &\quad\Rightarrow&\quad \mathsf{ref{.}eq} \\ &&|&
\mathtt{0xD4} &\quad\Rightarrow&\quad \mathsf{ref{.}as\_non\_null} \\ &&|&
\mathtt{0xD5}~~l{:}{\mathtt{labelidx}} &\quad\Rightarrow&\quad \mathsf{br\_on\_null}~l \\ &&|&
\mathtt{0xD6}~~l{:}{\mathtt{labelidx}} &\quad\Rightarrow&\quad \mathsf{br\_on\_non\_null}~l \\ &&|&
\mathtt{0xFB}~~0{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}} &\quad\Rightarrow&\quad \mathsf{struct{.}new}~x \\ &&|&
\mathtt{0xFB}~~1{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}} &\quad\Rightarrow&\quad \mathsf{struct{.}new\_default}~x \\ &&|&
\mathtt{0xFB}~~2{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}}~~i{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{struct{.}get}~x~i \\ &&|&
\mathtt{0xFB}~~3{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}}~~i{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{struct{.}get}}{\mathsf{\_}}{\mathsf{s}}~x~i \\ &&|&
\mathtt{0xFB}~~4{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}}~~i{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{struct{.}get}}{\mathsf{\_}}{\mathsf{u}}~x~i \\ &&|&
\mathtt{0xFB}~~5{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}}~~i{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{struct{.}set}~x~i \\ &&|&
\mathtt{0xFB}~~6{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}} &\quad\Rightarrow&\quad \mathsf{array{.}new}~x \\ &&|&
\mathtt{0xFB}~~7{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}} &\quad\Rightarrow&\quad \mathsf{array{.}new\_default}~x \\ &&|&
\mathtt{0xFB}~~8{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}}~~n{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{array{.}new\_fixed}~x~n \\ &&|&
\mathtt{0xFB}~~9{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}}~~y{:}{\mathtt{dataidx}} &\quad\Rightarrow&\quad \mathsf{array{.}new\_data}~x~y \\ &&|&
\mathtt{0xFB}~~10{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}}~~y{:}{\mathtt{elemidx}} &\quad\Rightarrow&\quad \mathsf{array{.}new\_elem}~x~y \\ &&|&
\mathtt{0xFB}~~11{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}} &\quad\Rightarrow&\quad \mathsf{array{.}get}~x \\ &&|&
\mathtt{0xFB}~~12{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}} &\quad\Rightarrow&\quad {\mathsf{array{.}get}}{\mathsf{\_}}{\mathsf{s}}~x \\ &&|&
\mathtt{0xFB}~~13{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}} &\quad\Rightarrow&\quad {\mathsf{array{.}get}}{\mathsf{\_}}{\mathsf{u}}~x \\ &&|&
\mathtt{0xFB}~~14{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}} &\quad\Rightarrow&\quad \mathsf{array{.}set}~x \\ &&|&
\mathtt{0xFB}~~15{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{array{.}len} \\ &&|&
\mathtt{0xFB}~~16{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}} &\quad\Rightarrow&\quad \mathsf{array{.}fill}~x \\ &&|&
\mathtt{0xFB}~~17{:}{\mathtt{u32}}~~x_1{:}{\mathtt{typeidx}}~~x_2{:}{\mathtt{typeidx}} &\quad\Rightarrow&\quad \mathsf{array{.}copy}~x_1~x_2 \\ &&|&
\mathtt{0xFB}~~18{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}}~~y{:}{\mathtt{dataidx}} &\quad\Rightarrow&\quad \mathsf{array{.}init\_data}~x~y \\ &&|&
\mathtt{0xFB}~~19{:}{\mathtt{u32}}~~x{:}{\mathtt{typeidx}}~~y{:}{\mathtt{elemidx}} &\quad\Rightarrow&\quad \mathsf{array{.}init\_elem}~x~y \\ &&|&
\mathtt{0xFB}~~20{:}{\mathtt{u32}}~~{\mathit{ht}}{:}{\mathtt{heaptype}} &\quad\Rightarrow&\quad \mathsf{ref{.}test}~(\mathsf{ref}~{\mathit{ht}}) \\ &&|&
\mathtt{0xFB}~~21{:}{\mathtt{u32}}~~{\mathit{ht}}{:}{\mathtt{heaptype}} &\quad\Rightarrow&\quad \mathsf{ref{.}test}~(\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \\ &&|&
\mathtt{0xFB}~~22{:}{\mathtt{u32}}~~{\mathit{ht}}{:}{\mathtt{heaptype}} &\quad\Rightarrow&\quad \mathsf{ref{.}cast}~(\mathsf{ref}~{\mathit{ht}}) \\ &&|&
\mathtt{0xFB}~~23{:}{\mathtt{u32}}~~{\mathit{ht}}{:}{\mathtt{heaptype}} &\quad\Rightarrow&\quad \mathsf{ref{.}cast}~(\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \\ &&|&
\mathtt{0xFB}~~24{:}{\mathtt{u32}}~~({\mathsf{null}}{{{}_{1}^?}}, {\mathsf{null}}{{{}_{2}^?}}){:}{\mathtt{castop}} \\ &&& l{:}{\mathtt{labelidx}}~~{\mathit{ht}}_1{:}{\mathtt{heaptype}}~~{\mathit{ht}}_2{:}{\mathtt{heaptype}} &\quad\Rightarrow&\quad \mathsf{br\_on\_cast}~l~(\mathsf{ref}~{\mathsf{null}}{{{}_{1}^?}}~{\mathit{ht}}_1)~(\mathsf{ref}~{\mathsf{null}}{{{}_{2}^?}}~{\mathit{ht}}_2) \\ &&|&
\mathtt{0xFB}~~25{:}{\mathtt{u32}}~~({\mathsf{null}}{{{}_{1}^?}}, {\mathsf{null}}{{{}_{2}^?}}){:}{\mathtt{castop}} \\ &&& l{:}{\mathtt{labelidx}}~~{\mathit{ht}}_1{:}{\mathtt{heaptype}}~~{\mathit{ht}}_2{:}{\mathtt{heaptype}} &\quad\Rightarrow&\quad \mathsf{br\_on\_cast\_fail}~l~(\mathsf{ref}~{\mathsf{null}}{{{}_{1}^?}}~{\mathit{ht}}_1)~(\mathsf{ref}~{\mathsf{null}}{{{}_{2}^?}}~{\mathit{ht}}_2) \\ &&|&
\mathtt{0xFB}~~26{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{any{.}convert\_extern} \\ &&|&
\mathtt{0xFB}~~27{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{extern{.}convert\_any} \\ &&|&
\mathtt{0xFB}~~28{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{ref{.}i{\scriptstyle 31}} \\ &&|&
\mathtt{0xFB}~~29{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 31}{.}get}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFB}~~30{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 31}{.}get}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\ldots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{instr}} &::=& \ldots \\ &&|&
\mathtt{0x1A} &\quad\Rightarrow&\quad \mathsf{drop} \\ &&|&
\mathtt{0x1B} &\quad\Rightarrow&\quad \mathsf{select} \\ &&|&
\mathtt{0x1C}~~{\mathit{ts}}{:}{\mathtt{list}}({\mathtt{valtype}}) &\quad\Rightarrow&\quad \mathsf{select}~{\mathit{ts}} \\ &&|&
\ldots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{instr}} &::=& \ldots \\ &&|&
\mathtt{0x20}~~x{:}{\mathtt{localidx}} &\quad\Rightarrow&\quad \mathsf{local{.}get}~x \\ &&|&
\mathtt{0x21}~~x{:}{\mathtt{localidx}} &\quad\Rightarrow&\quad \mathsf{local{.}set}~x \\ &&|&
\mathtt{0x22}~~x{:}{\mathtt{localidx}} &\quad\Rightarrow&\quad \mathsf{local{.}tee}~x \\ &&|&
\mathtt{0x23}~~x{:}{\mathtt{globalidx}} &\quad\Rightarrow&\quad \mathsf{global{.}get}~x \\ &&|&
\mathtt{0x24}~~x{:}{\mathtt{globalidx}} &\quad\Rightarrow&\quad \mathsf{global{.}set}~x \\ &&|&
\ldots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{instr}} &::=& \ldots \\ &&|&
\mathtt{0x25}~~x{:}{\mathtt{tableidx}} &\quad\Rightarrow&\quad \mathsf{table{.}get}~x \\ &&|&
\mathtt{0x26}~~x{:}{\mathtt{tableidx}} &\quad\Rightarrow&\quad \mathsf{table{.}set}~x \\ &&|&
\mathtt{0xFC}~~12{:}{\mathtt{u32}}~~y{:}{\mathtt{elemidx}}~~x{:}{\mathtt{tableidx}} &\quad\Rightarrow&\quad \mathsf{table{.}init}~x~y \\ &&|&
\mathtt{0xFC}~~13{:}{\mathtt{u32}}~~x{:}{\mathtt{elemidx}} &\quad\Rightarrow&\quad \mathsf{elem{.}drop}~x \\ &&|&
\mathtt{0xFC}~~14{:}{\mathtt{u32}}~~x_1{:}{\mathtt{tableidx}}~~x_2{:}{\mathtt{tableidx}} &\quad\Rightarrow&\quad \mathsf{table{.}copy}~x_1~x_2 \\ &&|&
\mathtt{0xFC}~~15{:}{\mathtt{u32}}~~x{:}{\mathtt{tableidx}} &\quad\Rightarrow&\quad \mathsf{table{.}grow}~x \\ &&|&
\mathtt{0xFC}~~16{:}{\mathtt{u32}}~~x{:}{\mathtt{tableidx}} &\quad\Rightarrow&\quad \mathsf{table{.}size}~x \\ &&|&
\mathtt{0xFC}~~17{:}{\mathtt{u32}}~~x{:}{\mathtt{tableidx}} &\quad\Rightarrow&\quad \mathsf{table{.}fill}~x \\ &&|&
\ldots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{memidxop}} &::=& ({\mathit{memidx}}, {\mathit{memarg}}) \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{memarg}} &::=& n{:}{\mathtt{u32}}~~m{:}{\mathtt{u32}} &\quad\Rightarrow&\quad (0, \{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~n,\; \mathsf{offset}~m \}\end{array})
  &\qquad \mbox{if}~n < {2^{6}} \\ &&|&
n{:}{\mathtt{u32}}~~x{:}{\mathtt{memidx}}~~m{:}{\mathtt{u32}} &\quad\Rightarrow&\quad (x, \{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~(n - {2^{6}}),\; \mathsf{offset}~m \}\end{array})
  &\qquad \mbox{if}~{2^{6}} \leq n < {2^{7}} \\
& {\mathtt{instr}} &::=& \ldots \\ &&|&
\mathtt{0x28}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}}{.}\mathsf{load}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x29}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}}{.}\mathsf{load}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x2A}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}}{.}\mathsf{load}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x2B}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}}{.}\mathsf{load}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x2C}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 8}}~\mathsf{s}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x2D}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 8}}~\mathsf{u}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x2E}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 16}}~\mathsf{s}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x2F}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 16}}~\mathsf{u}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x30}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 8}}~\mathsf{s}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x31}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 8}}~\mathsf{u}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x32}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 16}}~\mathsf{s}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x33}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 16}}~\mathsf{u}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x34}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 32}}~\mathsf{s}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x35}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 32}}~\mathsf{u}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x36}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}}{.}\mathsf{store}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x37}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}}{.}\mathsf{store}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x38}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}}{.}\mathsf{store}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x39}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}}{.}\mathsf{store}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x3A}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 8}}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x3B}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 16}}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x3C}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 8}}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x3D}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 16}}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x3E}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 32}}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0x3F}~~x{:}{\mathtt{memidx}} &\quad\Rightarrow&\quad \mathsf{memory{.}size}~x \\ &&|&
\mathtt{0x40}~~x{:}{\mathtt{memidx}} &\quad\Rightarrow&\quad \mathsf{memory{.}grow}~x \\ &&|&
\mathtt{0xFC}~~8{:}{\mathtt{u32}}~~y{:}{\mathtt{dataidx}}~~x{:}{\mathtt{memidx}} &\quad\Rightarrow&\quad \mathsf{memory{.}init}~x~y \\ &&|&
\mathtt{0xFC}~~9{:}{\mathtt{u32}}~~x{:}{\mathtt{dataidx}} &\quad\Rightarrow&\quad \mathsf{data{.}drop}~x \\ &&|&
\mathtt{0xFC}~~10{:}{\mathtt{u32}}~~x_1{:}{\mathtt{memidx}}~~x_2{:}{\mathtt{memidx}} &\quad\Rightarrow&\quad \mathsf{memory{.}copy}~x_1~x_2 \\ &&|&
\mathtt{0xFC}~~11{:}{\mathtt{u32}}~~x{:}{\mathtt{memidx}} &\quad\Rightarrow&\quad \mathsf{memory{.}fill}~x \\ &&|&
\ldots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{instr}} &::=& \ldots \\ &&|&
\mathtt{0x41}~~n{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}}{.}\mathsf{const}~n \\ &&|&
\mathtt{0x42}~~n{:}{\mathtt{u64}} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}}{.}\mathsf{const}~n \\ &&|&
\mathtt{0x43}~~p{:}{\mathtt{f32}} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}}{.}\mathsf{const}~p \\ &&|&
\mathtt{0x44}~~p{:}{\mathtt{f64}} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}}{.}\mathsf{const}~p \\ &&|&
\mathtt{0x45} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} \mathsf{eqz} \\ &&|&
\mathtt{0x46} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} \mathsf{eq} \\ &&|&
\mathtt{0x47} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} \mathsf{ne} \\ &&|&
\mathtt{0x48} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0x49} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0x4A} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0x4B} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0x4C} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0x4D} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0x4E} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0x4F} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0x50} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} \mathsf{eqz} \\ &&|&
\mathtt{0x51} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} \mathsf{eq} \\ &&|&
\mathtt{0x52} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} \mathsf{ne} \\ &&|&
\mathtt{0x53} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0x54} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0x55} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0x56} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0x57} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0x58} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0x59} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0x5A} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0x5B} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{eq} \\ &&|&
\mathtt{0x5C} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{ne} \\ &&|&
\mathtt{0x5D} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{lt} \\ &&|&
\mathtt{0x5E} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{gt} \\ &&|&
\mathtt{0x5F} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{le} \\ &&|&
\mathtt{0x60} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{ge} \\ &&|&
\mathtt{0x61} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{eq} \\ &&|&
\mathtt{0x62} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{ne} \\ &&|&
\mathtt{0x63} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{lt} \\ &&|&
\mathtt{0x64} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{gt} \\ &&|&
\mathtt{0x65} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{le} \\ &&|&
\mathtt{0x66} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{ge} \\ &&|&
\mathtt{0x67} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} \mathsf{clz} \\ &&|&
\mathtt{0x68} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} \mathsf{ctz} \\ &&|&
\mathtt{0x69} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} \mathsf{popcnt} \\ &&|&
\mathtt{0x6A} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} \mathsf{add} \\ &&|&
\mathtt{0x6B} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} \mathsf{sub} \\ &&|&
\mathtt{0x6C} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} \mathsf{mul} \\ &&|&
\mathtt{0x6D} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {\mathsf{div}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0x6E} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {\mathsf{div}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0x6F} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {\mathsf{rem}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0x70} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {\mathsf{rem}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0x71} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} \mathsf{and} \\ &&|&
\mathtt{0x72} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} \mathsf{or} \\ &&|&
\mathtt{0x73} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} \mathsf{xor} \\ &&|&
\mathtt{0x74} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} \mathsf{shl} \\ &&|&
\mathtt{0x75} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0x76} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0x77} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} \mathsf{rotl} \\ &&|&
\mathtt{0x78} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} \mathsf{rotr} \\ &&|&
\mathtt{0x79} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} \mathsf{clz} \\ &&|&
\mathtt{0x7A} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} \mathsf{ctz} \\ &&|&
\mathtt{0x7B} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} \mathsf{popcnt} \\ &&|&
\mathtt{0xC0} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {\mathsf{extend}}{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xC1} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {\mathsf{extend}}{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xC2} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {\mathsf{extend}}{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xC3} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {\mathsf{extend}}{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xC4} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {\mathsf{extend}}{\mathsf{{\scriptstyle 32}}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0x7C} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} \mathsf{add} \\ &&|&
\mathtt{0x7D} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} \mathsf{sub} \\ &&|&
\mathtt{0x7E} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} \mathsf{mul} \\ &&|&
\mathtt{0x7F} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {\mathsf{div}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0x80} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {\mathsf{div}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0x81} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {\mathsf{rem}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0x82} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {\mathsf{rem}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0x83} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} \mathsf{and} \\ &&|&
\mathtt{0x84} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} \mathsf{or} \\ &&|&
\mathtt{0x85} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} \mathsf{xor} \\ &&|&
\mathtt{0x86} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} \mathsf{shl} \\ &&|&
\mathtt{0x87} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0x88} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0x89} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} \mathsf{rotl} \\ &&|&
\mathtt{0x8A} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} \mathsf{rotr} \\ &&|&
\mathtt{0x8B} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{abs} \\ &&|&
\mathtt{0x8C} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{neg} \\ &&|&
\mathtt{0x8D} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{ceil} \\ &&|&
\mathtt{0x8E} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{floor} \\ &&|&
\mathtt{0x8F} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{trunc} \\ &&|&
\mathtt{0x90} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{nearest} \\ &&|&
\mathtt{0x91} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{sqrt} \\ &&|&
\mathtt{0x92} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{add} \\ &&|&
\mathtt{0x93} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{sub} \\ &&|&
\mathtt{0x94} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{mul} \\ &&|&
\mathtt{0x95} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{div} \\ &&|&
\mathtt{0x96} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{min} \\ &&|&
\mathtt{0x97} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{max} \\ &&|&
\mathtt{0x98} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} \mathsf{copysign} \\ &&|&
\mathtt{0x99} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{abs} \\ &&|&
\mathtt{0x9A} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{neg} \\ &&|&
\mathtt{0x9B} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{ceil} \\ &&|&
\mathtt{0x9C} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{floor} \\ &&|&
\mathtt{0x9D} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{trunc} \\ &&|&
\mathtt{0x9E} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{nearest} \\ &&|&
\mathtt{0x9F} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{sqrt} \\ &&|&
\mathtt{0xA0} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{add} \\ &&|&
\mathtt{0xA1} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{sub} \\ &&|&
\mathtt{0xA2} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{mul} \\ &&|&
\mathtt{0xA3} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{div} \\ &&|&
\mathtt{0xA4} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{min} \\ &&|&
\mathtt{0xA5} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{max} \\ &&|&
\mathtt{0xA6} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} \mathsf{copysign} \\ &&|&
\ldots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{instr}} &::=& \ldots \\ &&|&
\mathtt{0xA7} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {\mathsf{wrap}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\ &&|&
\mathtt{0xA8} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\ &&|&
\mathtt{0xA9} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\ &&|&
\mathtt{0xAA} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\ &&|&
\mathtt{0xAB} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\ &&|&
\mathtt{0xAC} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 32}}} \\ &&|&
\mathtt{0xAD} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{extend}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 32}}} \\ &&|&
\mathtt{0xAE} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\ &&|&
\mathtt{0xAF} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\ &&|&
\mathtt{0xB0} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\ &&|&
\mathtt{0xB1} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\ &&|&
\mathtt{0xB2} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 32}}} \\ &&|&
\mathtt{0xB3} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 32}}} \\ &&|&
\mathtt{0xB4} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\ &&|&
\mathtt{0xB5} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\ &&|&
\mathtt{0xB6} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} {\mathsf{demote}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\ &&|&
\mathtt{0xB7} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 32}}} \\ &&|&
\mathtt{0xB8} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 32}}} \\ &&|&
\mathtt{0xB9} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\ &&|&
\mathtt{0xBA} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} {{\mathsf{convert}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\ &&|&
\mathtt{0xBB} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} {\mathsf{promote}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\ &&|&
\mathtt{0xBC} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {\mathsf{reinterpret}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\ &&|&
\mathtt{0xBD} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {\mathsf{reinterpret}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\ &&|&
\mathtt{0xBE} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 32}} {.} {\mathsf{reinterpret}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 32}}} \\ &&|&
\mathtt{0xBF} &\quad\Rightarrow&\quad \mathsf{f{\scriptstyle 64}} {.} {\mathsf{reinterpret}}{\mathsf{\_}}{\mathsf{i{\scriptstyle 64}}} \\ &&|&
\mathtt{0xFC}~~0{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\ &&|&
\mathtt{0xFC}~~1{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\ &&|&
\mathtt{0xFC}~~2{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\ &&|&
\mathtt{0xFC}~~3{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 32}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\ &&|&
\mathtt{0xFC}~~4{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\ &&|&
\mathtt{0xFC}~~5{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 32}}} \\ &&|&
\mathtt{0xFC}~~6{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\ &&|&
\mathtt{0xFC}~~7{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{i{\scriptstyle 64}} {.} {{\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{\mathsf{f{\scriptstyle 64}}} \\ &&|&
\ldots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{laneidx}} &::=& l{:}{\mathtt{byte}} &\quad\Rightarrow&\quad l \\
& {\mathtt{instr}} &::=& \ldots \\ &&|&
\mathtt{0xFD}~~0{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad \mathsf{v{\scriptstyle 128}}{.}\mathsf{load}~x~{\mathit{ao}} \\ &&|&
\mathtt{0xFD}~~1{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{s}}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0xFD}~~2{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{u}}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0xFD}~~3{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{\mathsf{\_}}{\mathsf{s}}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0xFD}~~4{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{\mathsf{\_}}{\mathsf{u}}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0xFD}~~5{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{\mathsf{\_}}{\mathsf{s}}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0xFD}~~6{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{\mathsf{\_}}{\mathsf{u}}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0xFD}~~7{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{splat}}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0xFD}~~8{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{splat}}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0xFD}~~9{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 32}}}{\mathsf{\_}}{\mathsf{splat}}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0xFD}~~10{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 64}}}{\mathsf{\_}}{\mathsf{splat}}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0xFD}~~11{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad \mathsf{v{\scriptstyle 128}}{.}\mathsf{store}~x~{\mathit{ao}} \\ &&|&
\mathtt{0xFD}~~84{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~l \\ &&|&
\mathtt{0xFD}~~85{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~l \\ &&|&
\mathtt{0xFD}~~86{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 32}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~l \\ &&|&
\mathtt{0xFD}~~87{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{\mathsf{{\scriptstyle 64}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~l \\ &&|&
\mathtt{0xFD}~~88{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 8}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~l \\ &&|&
\mathtt{0xFD}~~89{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 16}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~l \\ &&|&
\mathtt{0xFD}~~90{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 32}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~l \\ &&|&
\mathtt{0xFD}~~91{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{store}}{\mathsf{{\scriptstyle 64}}}{\mathsf{\_}}{\mathsf{lane}}~x~{\mathit{ao}}~l \\ &&|&
\mathtt{0xFD}~~92{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 32}}}{\mathsf{\_}}{\mathsf{zero}}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0xFD}~~93{:}{\mathtt{u32}}~~(x, {\mathit{ao}}){:}{\mathtt{memarg}} &\quad\Rightarrow&\quad {\mathsf{v{\scriptstyle 128}}{.}\mathsf{load}}{{\mathsf{{\scriptstyle 64}}}{\mathsf{\_}}{\mathsf{zero}}}~x~{\mathit{ao}} \\ &&|&
\mathtt{0xFD}~~12{:}{\mathtt{u32}}~~{(b{:}{\mathtt{byte}})^{16}} &\quad\Rightarrow&\quad \mathsf{v{\scriptstyle 128}}{.}\mathsf{const}~{{{{\mathrm{bytes}}}_{{\mathsf{i}}{\mathsf{{\scriptstyle 128}}}}^{{-1}}}}{({(b)^{16}})} \\ &&|&
\mathtt{0xFD}~~13{:}{\mathtt{u32}}~~{(l{:}{\mathtt{laneidx}})^{16}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{shuffle}~l \\ &&|&
\mathtt{0xFD}~~14{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{swizzle} \\ &&|&
\mathtt{0xFD}~~15{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{splat} \\ &&|&
\mathtt{0xFD}~~16{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{splat} \\ &&|&
\mathtt{0xFD}~~17{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{splat} \\ &&|&
\mathtt{0xFD}~~18{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{splat} \\ &&|&
\mathtt{0xFD}~~19{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{splat} \\ &&|&
\mathtt{0xFD}~~20{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{splat} \\ &&|&
\mathtt{0xFD}~~21{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{\mathsf{s}}~l \\ &&|&
\mathtt{0xFD}~~22{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{\mathsf{u}}~l \\ &&|&
\mathtt{0xFD}~~23{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{replace\_lane}~l \\ &&|&
\mathtt{0xFD}~~24{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{\mathsf{s}}~l \\ &&|&
\mathtt{0xFD}~~25{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{extract\_lane}}{\mathsf{\_}}{\mathsf{u}}~l \\ &&|&
\mathtt{0xFD}~~26{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{replace\_lane}~l \\ &&|&
\mathtt{0xFD}~~27{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{extract\_lane}~l \\ &&|&
\mathtt{0xFD}~~28{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{replace\_lane}~l \\ &&|&
\mathtt{0xFD}~~29{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{extract\_lane}~l \\ &&|&
\mathtt{0xFD}~~30{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{replace\_lane}~l \\ &&|&
\mathtt{0xFD}~~31{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{extract\_lane}~l \\ &&|&
\mathtt{0xFD}~~32{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{replace\_lane}~l \\ &&|&
\mathtt{0xFD}~~33{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{extract\_lane}~l \\ &&|&
\mathtt{0xFD}~~34{:}{\mathtt{u32}}~~l{:}{\mathtt{laneidx}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{replace\_lane}~l \\ &&|&
\mathtt{0xFD}~~35{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{eq} \\ &&|&
\mathtt{0xFD}~~36{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{ne} \\ &&|&
\mathtt{0xFD}~~37{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~38{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~39{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~40{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~41{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~42{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~43{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~44{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~45{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{eq} \\ &&|&
\mathtt{0xFD}~~46{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{ne} \\ &&|&
\mathtt{0xFD}~~47{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~48{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~49{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~50{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~51{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~52{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~53{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~54{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~55{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{eq} \\ &&|&
\mathtt{0xFD}~~56{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{ne} \\ &&|&
\mathtt{0xFD}~~57{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~58{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~59{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~60{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~61{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~62{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~63{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~64{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~65{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{eq} \\ &&|&
\mathtt{0xFD}~~66{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{ne} \\ &&|&
\mathtt{0xFD}~~67{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{lt} \\ &&|&
\mathtt{0xFD}~~68{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{gt} \\ &&|&
\mathtt{0xFD}~~69{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{le} \\ &&|&
\mathtt{0xFD}~~70{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{ge} \\ &&|&
\mathtt{0xFD}~~71{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{eq} \\ &&|&
\mathtt{0xFD}~~72{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{ne} \\ &&|&
\mathtt{0xFD}~~73{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{lt} \\ &&|&
\mathtt{0xFD}~~74{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{gt} \\ &&|&
\mathtt{0xFD}~~75{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{le} \\ &&|&
\mathtt{0xFD}~~76{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{ge} \\ &&|&
\mathtt{0xFD}~~77{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{v{\scriptstyle 128}} {.} \mathsf{not} \\ &&|&
\mathtt{0xFD}~~78{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{v{\scriptstyle 128}} {.} \mathsf{and} \\ &&|&
\mathtt{0xFD}~~79{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{v{\scriptstyle 128}} {.} \mathsf{andnot} \\ &&|&
\mathtt{0xFD}~~80{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{v{\scriptstyle 128}} {.} \mathsf{or} \\ &&|&
\mathtt{0xFD}~~81{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{v{\scriptstyle 128}} {.} \mathsf{xor} \\ &&|&
\mathtt{0xFD}~~82{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{v{\scriptstyle 128}} {.} \mathsf{bitselect} \\ &&|&
\mathtt{0xFD}~~83{:}{\mathtt{u32}} &\quad\Rightarrow&\quad \mathsf{v{\scriptstyle 128}} {.} \mathsf{any\_true} \\ &&|&
\mathtt{0xFD}~~96{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{abs} \\ &&|&
\mathtt{0xFD}~~97{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{neg} \\ &&|&
\mathtt{0xFD}~~98{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{popcnt} \\ &&|&
\mathtt{0xFD}~~99{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{all\_true} \\ &&|&
\mathtt{0xFD}~~100{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{bitmask} \\ &&|&
\mathtt{0xFD}~~101{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{narrow}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~102{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}{.}\mathsf{narrow}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~107{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{shl} \\ &&|&
\mathtt{0xFD}~~108{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~109{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~110{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{add} \\ &&|&
\mathtt{0xFD}~~111{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{add\_sat}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~112{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{add\_sat}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~113{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} \mathsf{sub} \\ &&|&
\mathtt{0xFD}~~114{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{sub\_sat}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~115{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{sub\_sat}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~118{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{min}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~119{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{min}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~120{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{max}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~121{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{max}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~123{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}} {.} {\mathsf{avgr}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~124{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extadd\_pairwise}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\ &&|&
\mathtt{0xFD}~~125{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extadd\_pairwise}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\ &&|&
\mathtt{0xFD}~~128{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{abs} \\ &&|&
\mathtt{0xFD}~~129{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{neg} \\ &&|&
\mathtt{0xFD}~~130{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{q{\scriptstyle 15}mulr\_sat}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~131{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{all\_true} \\ &&|&
\mathtt{0xFD}~~132{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{bitmask} \\ &&|&
\mathtt{0xFD}~~133{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{narrow}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~134{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}{.}\mathsf{narrow}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~135{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {({\mathsf{extend}}{\mathsf{\_}}{\mathsf{s}})}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}}{\mathsf{\_}}{\mathsf{low}} \\ &&|&
\mathtt{0xFD}~~136{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {({\mathsf{extend}}{\mathsf{\_}}{\mathsf{s}})}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}}{\mathsf{\_}}{\mathsf{high}} \\ &&|&
\mathtt{0xFD}~~137{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {({\mathsf{extend}}{\mathsf{\_}}{\mathsf{u}})}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}}{\mathsf{\_}}{\mathsf{low}} \\ &&|&
\mathtt{0xFD}~~138{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {({\mathsf{extend}}{\mathsf{\_}}{\mathsf{u}})}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}}{\mathsf{\_}}{\mathsf{high}} \\ &&|&
\mathtt{0xFD}~~139{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{shl} \\ &&|&
\mathtt{0xFD}~~140{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~141{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~142{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{add} \\ &&|&
\mathtt{0xFD}~~143{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{add\_sat}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~144{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{add\_sat}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~145{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{sub} \\ &&|&
\mathtt{0xFD}~~146{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{sub\_sat}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~147{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{sub\_sat}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~149{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} \mathsf{mul} \\ &&|&
\mathtt{0xFD}~~150{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{min}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~151{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{min}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~152{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{max}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~153{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{max}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~155{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {\mathsf{avgr}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~156{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{s}}{\mathsf{\_}}{\mathsf{low}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\ &&|&
\mathtt{0xFD}~~157{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{s}}{\mathsf{\_}}{\mathsf{high}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\ &&|&
\mathtt{0xFD}~~158{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{u}}{\mathsf{\_}}{\mathsf{low}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\ &&|&
\mathtt{0xFD}~~159{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{u}}{\mathsf{\_}}{\mathsf{high}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 8}}}{\mathsf{x}}{\mathsf{{\scriptstyle 16}}}} \\ &&|&
\mathtt{0xFD}~~126{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extadd\_pairwise}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\ &&|&
\mathtt{0xFD}~~127{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extadd\_pairwise}}{\mathsf{\_}}{\mathsf{u}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\ &&|&
\mathtt{0xFD}~~160{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{abs} \\ &&|&
\mathtt{0xFD}~~161{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{neg} \\ &&|&
\mathtt{0xFD}~~163{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{all\_true} \\ &&|&
\mathtt{0xFD}~~164{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}{.}\mathsf{bitmask} \\ &&|&
\mathtt{0xFD}~~167{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {({\mathsf{extend}}{\mathsf{\_}}{\mathsf{s}})}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}}{\mathsf{\_}}{\mathsf{low}} \\ &&|&
\mathtt{0xFD}~~168{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {({\mathsf{extend}}{\mathsf{\_}}{\mathsf{s}})}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}}{\mathsf{\_}}{\mathsf{high}} \\ &&|&
\mathtt{0xFD}~~169{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {({\mathsf{extend}}{\mathsf{\_}}{\mathsf{u}})}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}}{\mathsf{\_}}{\mathsf{low}} \\ &&|&
\mathtt{0xFD}~~170{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {({\mathsf{extend}}{\mathsf{\_}}{\mathsf{u}})}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}}{\mathsf{\_}}{\mathsf{high}} \\ &&|&
\mathtt{0xFD}~~171{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{shl} \\ &&|&
\mathtt{0xFD}~~172{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~173{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~174{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{add} \\ &&|&
\mathtt{0xFD}~~177{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{sub} \\ &&|&
\mathtt{0xFD}~~181{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{mul} \\ &&|&
\mathtt{0xFD}~~182{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{min}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~183{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{min}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~184{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{max}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~185{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{max}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~186{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{dot}}{\mathsf{\_}}{\mathsf{s}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\ &&|&
\mathtt{0xFD}~~188{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{s}}{\mathsf{\_}}{\mathsf{low}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\ &&|&
\mathtt{0xFD}~~189{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{s}}{\mathsf{\_}}{\mathsf{high}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\ &&|&
\mathtt{0xFD}~~190{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{u}}{\mathsf{\_}}{\mathsf{low}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\ &&|&
\mathtt{0xFD}~~191{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{u}}{\mathsf{\_}}{\mathsf{high}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 16}}}{\mathsf{x}}{\mathsf{{\scriptstyle 8}}}} \\ &&|&
\mathtt{0xFD}~~192{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{abs} \\ &&|&
\mathtt{0xFD}~~193{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{neg} \\ &&|&
\mathtt{0xFD}~~195{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{all\_true} \\ &&|&
\mathtt{0xFD}~~196{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}{.}\mathsf{bitmask} \\ &&|&
\mathtt{0xFD}~~199{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {({\mathsf{extend}}{\mathsf{\_}}{\mathsf{s}})}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}}{\mathsf{\_}}{\mathsf{low}} \\ &&|&
\mathtt{0xFD}~~200{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {({\mathsf{extend}}{\mathsf{\_}}{\mathsf{s}})}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}}{\mathsf{\_}}{\mathsf{high}} \\ &&|&
\mathtt{0xFD}~~201{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {({\mathsf{extend}}{\mathsf{\_}}{\mathsf{u}})}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}}{\mathsf{\_}}{\mathsf{low}} \\ &&|&
\mathtt{0xFD}~~202{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {({\mathsf{extend}}{\mathsf{\_}}{\mathsf{u}})}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}}{\mathsf{\_}}{\mathsf{high}} \\ &&|&
\mathtt{0xFD}~~203{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{shl} \\ &&|&
\mathtt{0xFD}~~204{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~205{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {\mathsf{shr}}{\mathsf{\_}}{\mathsf{u}} \\ &&|&
\mathtt{0xFD}~~206{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{add} \\ &&|&
\mathtt{0xFD}~~209{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{sub} \\ &&|&
\mathtt{0xFD}~~213{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{mul} \\ &&|&
\mathtt{0xFD}~~214{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{eq} \\ &&|&
\mathtt{0xFD}~~215{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{ne} \\ &&|&
\mathtt{0xFD}~~216{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {\mathsf{lt}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~217{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {\mathsf{gt}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~218{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {\mathsf{le}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~219{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {\mathsf{ge}}{\mathsf{\_}}{\mathsf{s}} \\ &&|&
\mathtt{0xFD}~~220{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{s}}{\mathsf{\_}}{\mathsf{low}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\ &&|&
\mathtt{0xFD}~~221{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{s}}{\mathsf{\_}}{\mathsf{high}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\ &&|&
\mathtt{0xFD}~~222{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{u}}{\mathsf{\_}}{\mathsf{low}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\ &&|&
\mathtt{0xFD}~~223{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {{\mathsf{extmul}}{\mathsf{\_}}{\mathsf{u}}{\mathsf{\_}}{\mathsf{high}}}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\ &&|&
\mathtt{0xFD}~~103{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{ceil} \\ &&|&
\mathtt{0xFD}~~104{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{floor} \\ &&|&
\mathtt{0xFD}~~105{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{trunc} \\ &&|&
\mathtt{0xFD}~~106{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{nearest} \\ &&|&
\mathtt{0xFD}~~224{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{abs} \\ &&|&
\mathtt{0xFD}~~225{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{neg} \\ &&|&
\mathtt{0xFD}~~227{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{sqrt} \\ &&|&
\mathtt{0xFD}~~228{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{add} \\ &&|&
\mathtt{0xFD}~~229{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{sub} \\ &&|&
\mathtt{0xFD}~~230{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{mul} \\ &&|&
\mathtt{0xFD}~~231{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{div} \\ &&|&
\mathtt{0xFD}~~232{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{min} \\ &&|&
\mathtt{0xFD}~~233{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{max} \\ &&|&
\mathtt{0xFD}~~234{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{pmin} \\ &&|&
\mathtt{0xFD}~~235{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} \mathsf{pmax} \\ &&|&
\mathtt{0xFD}~~116{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{ceil} \\ &&|&
\mathtt{0xFD}~~117{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{floor} \\ &&|&
\mathtt{0xFD}~~122{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{trunc} \\ &&|&
\mathtt{0xFD}~~148{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{nearest} \\ &&|&
\mathtt{0xFD}~~236{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{abs} \\ &&|&
\mathtt{0xFD}~~237{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{neg} \\ &&|&
\mathtt{0xFD}~~239{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{sqrt} \\ &&|&
\mathtt{0xFD}~~240{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{add} \\ &&|&
\mathtt{0xFD}~~241{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{sub} \\ &&|&
\mathtt{0xFD}~~242{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{mul} \\ &&|&
\mathtt{0xFD}~~243{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{div} \\ &&|&
\mathtt{0xFD}~~244{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{min} \\ &&|&
\mathtt{0xFD}~~245{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{max} \\ &&|&
\mathtt{0xFD}~~246{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{pmin} \\ &&|&
\mathtt{0xFD}~~247{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} \mathsf{pmax} \\ &&|&
\mathtt{0xFD}~~94{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {\mathsf{demote}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}}{\mathsf{\_}}{\mathsf{zero}} \\ &&|&
\mathtt{0xFD}~~95{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {\mathsf{promote}}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}}{\mathsf{\_}}{\mathsf{low}} \\ &&|&
\mathtt{0xFD}~~248{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {({\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{s}})}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\ &&|&
\mathtt{0xFD}~~249{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {({\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{u}})}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\ &&|&
\mathtt{0xFD}~~250{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {({\mathsf{convert}}{\mathsf{\_}}{\mathsf{s}})}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\ &&|&
\mathtt{0xFD}~~251{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {({\mathsf{convert}}{\mathsf{\_}}{\mathsf{u}})}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}} \\ &&|&
\mathtt{0xFD}~~252{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {({\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{s}})}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}}{\mathsf{\_}}{\mathsf{zero}} \\ &&|&
\mathtt{0xFD}~~253{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}} {.} {({\mathsf{trunc\_sat}}{\mathsf{\_}}{\mathsf{u}})}{\mathsf{\_}}{{\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}}}{\mathsf{\_}}{\mathsf{zero}} \\ &&|&
\mathtt{0xFD}~~254{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {({\mathsf{convert}}{\mathsf{\_}}{\mathsf{s}})}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}}{\mathsf{\_}}{\mathsf{low}} \\ &&|&
\mathtt{0xFD}~~255{:}{\mathtt{u32}} &\quad\Rightarrow&\quad {\mathsf{f{\scriptstyle 64}}}{\mathsf{x}}{\mathsf{{\scriptstyle 2}}} {.} {({\mathsf{convert}}{\mathsf{\_}}{\mathsf{u}})}{\mathsf{\_}}{{\mathsf{i{\scriptstyle 32}}}{\mathsf{x}}{\mathsf{{\scriptstyle 4}}}}{\mathsf{\_}}{\mathsf{low}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{expr}} &::=& {({\mathit{in}}{:}{\mathtt{instr}})^\ast}~~\mathtt{0x0B} &\quad\Rightarrow&\quad {{\mathit{in}}^\ast} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {{\mathtt{section}}}_{N}({\mathtt{X}}) &::=& N{:}{\mathtt{byte}}~~{\mathit{len}}{:}{\mathtt{u32}}~~{{\mathit{en}}^\ast}{:}{\mathtt{X}} &\quad\Rightarrow&\quad {{\mathit{en}}^\ast}
  &\qquad \mbox{if}~{\mathit{len}} = ||{\mathtt{X}}|| \\ &&|&
\epsilon &\quad\Rightarrow&\quad \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{custom}} &::=& {\mathtt{name}}~~{{\mathtt{byte}}^\ast} \\
& {\mathtt{customsec}} &::=& {{\mathtt{section}}}_{0}({\mathtt{custom}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{type}} &::=& {\mathit{qt}}{:}{\mathtt{rectype}} &\quad\Rightarrow&\quad \mathsf{type}~{\mathit{qt}} \\
& {\mathtt{typesec}} &::=& {{\mathit{ty}}^\ast}{:}{{\mathtt{section}}}_{1}({\mathtt{list}}({\mathtt{type}})) &\quad\Rightarrow&\quad {{\mathit{ty}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{import}} &::=& {\mathit{nm}}_1{:}{\mathtt{name}}~~{\mathit{nm}}_2{:}{\mathtt{name}}~~{\mathit{xt}}{:}{\mathtt{externtype}} &\quad\Rightarrow&\quad \mathsf{import}~{\mathit{nm}}_1~{\mathit{nm}}_2~{\mathit{xt}} \\
& {\mathtt{importsec}} &::=& {{\mathit{im}}^\ast}{:}{{\mathtt{section}}}_{2}({\mathtt{list}}({\mathtt{import}})) &\quad\Rightarrow&\quad {{\mathit{im}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{funcsec}} &::=& {x^\ast}{:}{{\mathtt{section}}}_{3}({\mathtt{list}}({\mathtt{typeidx}})) &\quad\Rightarrow&\quad {x^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{table}} &::=& {\mathit{tt}}{:}{\mathtt{tabletype}} &\quad\Rightarrow&\quad \mathsf{table}~{\mathit{tt}}~(\mathsf{ref{.}null}~{\mathit{ht}})
  &\qquad \mbox{if}~{\mathit{tt}} = {\mathit{lim}}~(\mathsf{ref}~{\mathsf{null}^?}~{\mathit{ht}}) \\ &&|&
\mathtt{0x40}~~\mathtt{0x00}~~{\mathit{tt}}{:}{\mathtt{tabletype}}~~e{:}{\mathtt{expr}} &\quad\Rightarrow&\quad \mathsf{table}~{\mathit{tt}}~e \\
& {\mathtt{tablesec}} &::=& {{\mathit{tab}}^\ast}{:}{{\mathtt{section}}}_{4}({\mathtt{list}}({\mathtt{table}})) &\quad\Rightarrow&\quad {{\mathit{tab}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{mem}} &::=& {\mathit{mt}}{:}{\mathtt{memtype}} &\quad\Rightarrow&\quad \mathsf{memory}~{\mathit{mt}} \\
& {\mathtt{memsec}} &::=& {{\mathit{mem}}^\ast}{:}{{\mathtt{section}}}_{5}({\mathtt{list}}({\mathtt{mem}})) &\quad\Rightarrow&\quad {{\mathit{mem}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{global}} &::=& {\mathit{gt}}{:}{\mathtt{globaltype}}~~e{:}{\mathtt{expr}} &\quad\Rightarrow&\quad \mathsf{global}~{\mathit{gt}}~e \\
& {\mathtt{globalsec}} &::=& {{\mathit{glob}}^\ast}{:}{{\mathtt{section}}}_{6}({\mathtt{list}}({\mathtt{global}})) &\quad\Rightarrow&\quad {{\mathit{glob}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{export}} &::=& {\mathit{nm}}{:}{\mathtt{name}}~~{\mathit{xx}}{:}{\mathtt{externidx}} &\quad\Rightarrow&\quad \mathsf{export}~{\mathit{nm}}~{\mathit{xx}} \\
& {\mathtt{exportsec}} &::=& {{\mathit{ex}}^\ast}{:}{{\mathtt{section}}}_{7}({\mathtt{list}}({\mathtt{export}})) &\quad\Rightarrow&\quad {{\mathit{ex}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{start}} &::=& x{:}{\mathtt{funcidx}} &\quad\Rightarrow&\quad (\mathsf{start}~x) \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {{\mathit{start}}^?} &::=& {{\mathit{start}}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{startsec}} &::=& {{\mathit{start}}^?}{:}{{\mathtt{section}}}_{8}({\mathtt{start}}) &\quad\Rightarrow&\quad {{\mathit{start}}^?} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{elemkind}} &::=& \mathtt{0x00} &\quad\Rightarrow&\quad \mathsf{ref}~\mathsf{null}~\mathsf{func} \\
& {\mathtt{elem}} &::=& 0{:}{\mathtt{u32}}~~e_o{:}{\mathtt{expr}}~~{y^\ast}{:}{\mathtt{list}}({\mathtt{funcidx}}) &\quad\Rightarrow&\quad \\
  &&& \multicolumn{3}{@{}l@{}}{\qquad \mathsf{elem}~(\mathsf{ref}~\mathsf{func})~{(\mathsf{ref{.}func}~y)^\ast}~(\mathsf{active}~0~e_o) } \\ &&|&
1{:}{\mathtt{u32}}~~{\mathit{rt}}{:}{\mathtt{elemkind}}~~{y^\ast}{:}{\mathtt{list}}({\mathtt{funcidx}}) &\quad\Rightarrow&\quad \\
  &&& \multicolumn{3}{@{}l@{}}{\qquad \mathsf{elem}~{\mathit{rt}}~{(\mathsf{ref{.}func}~y)^\ast}~\mathsf{passive} } \\ &&|&
2{:}{\mathtt{u32}}~~x{:}{\mathtt{tableidx}}~~e{:}{\mathtt{expr}}~~{\mathit{rt}}{:}{\mathtt{elemkind}}~~{y^\ast}{:}{\mathtt{list}}({\mathtt{funcidx}}) &\quad\Rightarrow&\quad \\
  &&& \multicolumn{3}{@{}l@{}}{\qquad \mathsf{elem}~{\mathit{rt}}~{(\mathsf{ref{.}func}~y)^\ast}~(\mathsf{active}~x~e) } \\ &&|&
3{:}{\mathtt{u32}}~~{\mathit{rt}}{:}{\mathtt{elemkind}}~~{y^\ast}{:}{\mathtt{list}}({\mathtt{funcidx}}) &\quad\Rightarrow&\quad \\
  &&& \multicolumn{3}{@{}l@{}}{\qquad \mathsf{elem}~{\mathit{rt}}~{(\mathsf{ref{.}func}~y)^\ast}~\mathsf{declare} } \\ &&|&
4{:}{\mathtt{u32}}~~e_{\mathsf{o}}{:}{\mathtt{expr}}~~{e^\ast}{:}{\mathtt{list}}({\mathtt{expr}}) &\quad\Rightarrow&\quad \\
  &&& \multicolumn{3}{@{}l@{}}{\qquad \mathsf{elem}~(\mathsf{ref}~\mathsf{null}~\mathsf{func})~{e^\ast}~(\mathsf{active}~0~e_{\mathsf{o}}) } \\ &&|&
5{:}{\mathtt{u32}}~~{\mathit{rt}}{:}{\mathtt{reftype}}~~{e^\ast}{:}{\mathtt{list}}({\mathtt{expr}}) &\quad\Rightarrow&\quad \\
  &&& \multicolumn{3}{@{}l@{}}{\qquad \mathsf{elem}~{\mathit{rt}}~{e^\ast}~\mathsf{passive} } \\ &&|&
6{:}{\mathtt{u32}}~~x{:}{\mathtt{tableidx}}~~e_{\mathsf{o}}{:}{\mathtt{expr}}~~{e^\ast}{:}{\mathtt{list}}({\mathtt{expr}}) &\quad\Rightarrow&\quad \\
  &&& \multicolumn{3}{@{}l@{}}{\qquad \mathsf{elem}~(\mathsf{ref}~\mathsf{null}~\mathsf{func})~{e^\ast}~(\mathsf{active}~x~e_{\mathsf{o}}) } \\ &&|&
7{:}{\mathtt{u32}}~~{\mathit{rt}}{:}{\mathtt{reftype}}~~{e^\ast}{:}{\mathtt{list}}({\mathtt{expr}}) &\quad\Rightarrow&\quad \\
  &&& \multicolumn{3}{@{}l@{}}{\qquad \mathsf{elem}~{\mathit{rt}}~{e^\ast}~\mathsf{declare} } \\
& {\mathtt{elemsec}} &::=& {{\mathit{elem}}^\ast}{:}{{\mathtt{section}}}_{9}({\mathtt{list}}({\mathtt{elem}})) &\quad\Rightarrow&\quad {{\mathit{elem}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{code}} &::=& ({{\mathit{local}}^\ast}, {\mathit{expr}}) \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{locals}} &::=& n{:}{\mathtt{u32}}~~t{:}{\mathtt{valtype}} &\quad\Rightarrow&\quad {(\mathsf{local}~t)^{n}} \\
& {\mathtt{func}} &::=& {{{\mathit{loc}}^\ast}^\ast}{:}{\mathtt{list}}({\mathtt{locals}})~~e{:}{\mathtt{expr}} &\quad\Rightarrow&\quad ({\bigoplus}\, {{{\mathit{loc}}^\ast}^\ast}, e)
  &\qquad \mbox{if}~{|{\bigoplus}\, {{{\mathit{loc}}^\ast}^\ast}|} < {2^{32}} \\
& {\mathtt{code}} &::=& {\mathit{len}}{:}{\mathtt{u32}}~~{\mathit{code}}{:}{\mathtt{func}} &\quad\Rightarrow&\quad {\mathit{code}}
  &\qquad \mbox{if}~{\mathit{len}} = ||{\mathtt{func}}|| \\
& {\mathtt{codesec}} &::=& {{\mathit{code}}^\ast}{:}{{\mathtt{section}}}_{10}({\mathtt{list}}({\mathtt{code}})) &\quad\Rightarrow&\quad {{\mathit{code}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{data}} &::=& 0{:}{\mathtt{u32}}~~e{:}{\mathtt{expr}}~~{b^\ast}{:}{\mathtt{list}}({\mathtt{byte}}) &\quad\Rightarrow&\quad \mathsf{data}~{b^\ast}~(\mathsf{active}~0~e) \\ &&|&
1{:}{\mathtt{u32}}~~{b^\ast}{:}{\mathtt{list}}({\mathtt{byte}}) &\quad\Rightarrow&\quad \mathsf{data}~{b^\ast}~\mathsf{passive} \\ &&|&
2{:}{\mathtt{u32}}~~x{:}{\mathtt{memidx}}~~e{:}{\mathtt{expr}}~~{b^\ast}{:}{\mathtt{list}}({\mathtt{byte}}) &\quad\Rightarrow&\quad \mathsf{data}~{b^\ast}~(\mathsf{active}~x~e) \\
& {\mathtt{datasec}} &::=& {{\mathit{data}}^\ast}{:}{{\mathtt{section}}}_{11}({\mathtt{list}}({\mathtt{data}})) &\quad\Rightarrow&\quad {{\mathit{data}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{datacnt}} &::=& n{:}{\mathtt{u32}} &\quad\Rightarrow&\quad n \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {n^?} &::=& {{\mathit{u{\kern-0.1em\scriptstyle 32}}}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{datacntsec}} &::=& {n^?}{:}{{\mathtt{section}}}_{12}({\mathtt{datacnt}}) &\quad\Rightarrow&\quad {n^?} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{magic}} &::=& \mathtt{0x00}~~\mathtt{0x61}~~\mathtt{0x73}~~\mathtt{0x6D} \\
& {\mathtt{version}} &::=& \mathtt{0x01}~~\mathtt{0x00}~~\mathtt{0x00}~~\mathtt{0x00} \\
& {\mathtt{module}} &::=& {\mathtt{magic}}~~{\mathtt{version}} \\ &&& {{\mathtt{customsec}}^\ast}~~{{\mathit{type}}^\ast}{:}{\mathtt{typesec}} \\ &&& {{\mathtt{customsec}}^\ast}~~{{\mathit{import}}^\ast}{:}{\mathtt{importsec}} \\ &&& {{\mathtt{customsec}}^\ast}~~{{\mathit{typeidx}}^\ast}{:}{\mathtt{funcsec}} \\ &&& {{\mathtt{customsec}}^\ast}~~{{\mathit{table}}^\ast}{:}{\mathtt{tablesec}} \\ &&& {{\mathtt{customsec}}^\ast}~~{{\mathit{mem}}^\ast}{:}{\mathtt{memsec}} \\ &&& {{\mathtt{customsec}}^\ast}~~{{\mathit{global}}^\ast}{:}{\mathtt{globalsec}} \\ &&& {{\mathtt{customsec}}^\ast}~~{{\mathit{export}}^\ast}{:}{\mathtt{exportsec}} \\ &&& {{\mathtt{customsec}}^\ast}~~{{\mathit{start}}^?}{:}{\mathtt{startsec}} \\ &&& {{\mathtt{customsec}}^\ast}~~{{\mathit{elem}}^\ast}{:}{\mathtt{elemsec}} \\ &&& {{\mathtt{customsec}}^\ast}~~{n^?}{:}{\mathtt{datacntsec}} \\ &&& {{\mathtt{customsec}}^\ast}~~{({{\mathit{local}}^\ast}, {\mathit{expr}})^\ast}{:}{\mathtt{codesec}} \\ &&& {{\mathtt{customsec}}^\ast}~~{{\mathit{data}}^\ast}{:}{\mathtt{datasec}} \\ &&& {{\mathtt{customsec}}^\ast} &\quad\Rightarrow&\quad \\
  &&& \multicolumn{3}{@{}l@{}}{\qquad \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast} } \\
  &&&&& \multicolumn{2}{l@{}}{\quad \mbox{if}~(n = {|{{\mathit{data}}^\ast}|})^?} \\
  &&&&& \multicolumn{2}{l@{}}{\quad {\land}~{n^?} \neq \epsilon \lor {\mathrm{dataidx}}({{\mathit{func}}^\ast}) = \epsilon} \\
  &&&&& \multicolumn{2}{l@{}}{\quad {\land}~({\mathit{func}} = \mathsf{func}~{\mathit{typeidx}}~{{\mathit{local}}^\ast}~{\mathit{expr}})^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& A &::=& \mathbb{N} \\
& B &::=& \mathbb{N} \\
& {\mathit{sym}} &::=& A_1 ~|~ \ldots ~|~ A_n \\
& {\mathit{sym}} &::=& A_1 ~|~ A_2 \\
&  &::=& () \\
& r &::=& \{ \begin{array}[t]{@{}l@{}l@{}}
{\mathsf{field}}_{1}~A_1,\; {\mathsf{field}}_{2}~A_2,\; \ldots~ \}\end{array} \\
& {\mathit{pth}} &::=& {({}[ i ]~\mid~{.}\mathsf{field})^{+}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& T &::=& \mathbb{N} \\
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

$\boxed{{\mathit{context}} \vdash {{\mathit{instr}}^\ast} : {\mathit{functype}}}$

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
C{.}\mathsf{globals}{}[x] = {\mathsf{mut}^?}~t
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
\{ \begin{array}[t]{@{}l@{}}
\mathsf{labels}~({t_2^\ast}) \}\end{array} \oplus C \vdash {{\mathit{instr}}^\ast} : {t_1^\ast} \rightarrow {t_2^\ast}
}{
C \vdash \mathsf{block}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast} : {t_1^\ast} \rightarrow {t_2^\ast}
} \, {[\textsc{\scriptsize NotationTypingInstrScheme{-}block}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\hookrightarrow}\, {{\mathit{instr}}^\ast}}$

$$
\begin{array}{@{}l@{}rcl@{}l@{}}
{[\textsc{\scriptsize NotationReduct{-}2}]} \quad &  &\hookrightarrow& (\mathsf{f{\scriptstyle 64}}{.}\mathsf{const}~q_1)~(\mathsf{f{\scriptstyle 64}}{.}\mathsf{const}~q_4)~(\mathsf{f{\scriptstyle 64}}{.}\mathsf{const}~q_3)~\mathsf{f{\scriptstyle 64}} {.} \mathsf{add}~\mathsf{f{\scriptstyle 64}} {.} \mathsf{mul} \\
{[\textsc{\scriptsize NotationReduct{-}3}]} \quad &  &\hookrightarrow& (\mathsf{f{\scriptstyle 64}}{.}\mathsf{const}~q_1)~(\mathsf{f{\scriptstyle 64}}{.}\mathsf{const}~q_5)~\mathsf{f{\scriptstyle 64}} {.} \mathsf{mul} \\
{[\textsc{\scriptsize NotationReduct{-}4}]} \quad &  &\hookrightarrow& (\mathsf{f{\scriptstyle 64}}{.}\mathsf{const}~q_6) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(label)} & {\mathit{label}} &::=& {{\mathsf{label}}_{n}}{\{ {{\mathit{instr}}^\ast} \}} \\
\mbox{(call frame)} & {\mathit{callframe}} &::=& {{\mathsf{frame}}_{n}}{\{ {\mathit{frame}} \}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{{\mathrm{allocX}}^\ast}}{(s, \epsilon, \epsilon)} &=& (s, \epsilon) \\
{{{\mathrm{allocX}}^\ast}}{(s, X~{{X'}^\ast}, Y~{{Y'}^\ast})} &=& (s_2, a~{{a'}^\ast})
  &\qquad \mbox{if}~(s_1, a) = {\mathrm{allocX}}(X, Y, s, X, Y) \\
  &&&\qquad {\land}~(s_2, {{a'}^\ast}) = {{{\mathrm{allocX}}^\ast}}{(s_1, {{X'}^\ast}, {{Y'}^\ast})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& {\mathtt{typewriter}} &::=& \mathtt{0x00} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& \ldots &::=& 0 \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
X &=& \mathtt{0x00} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrl@{}l@{}l@{}l@{}}
& X &::=& \mathtt{0x00} \\
& {\mathtt{sym}} &::=& B_1 &\quad\Rightarrow&\quad A_1 \\ &&|&
\ldots ~|~ B_n &\quad\Rightarrow&\quad A_n \\
\end{array}
$$


```

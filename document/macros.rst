.. To comment out stuff

.. |void| mathmacro:: \def\void#1{}\void


.. Type-setting of names
.. X - (multi-letter) variables / non-terminals
.. F - functions (meta-level)
.. K - keywords / terminals

.. |X| mathmacro:: \mathit
.. |F| mathmacro:: \mathrm
.. |K| mathmacro:: \mathsf


.. Auxiliary definitions for grammars

.. |production| mathmacro:: \def\vo_id#1{}\vo_id


.. Values, terminals and auxiliary

.. |hex| mathmacro:: \def\hex#1{\mathrm{0x#1}}\hex
.. |byte| mathmacro:: \mathrm{byte}
.. |bytes| mathmacro:: \mathrm{bytes}


.. Values, non-terminals

.. |by| mathmacro:: \href{../syntax/values.html#syntax-byte}{byte}

.. |uX| mathmacro:: \def\uX#1{\mathit{uint}_{#1}}\uX
.. |sX| mathmacro:: \def\sX#1{\mathit{sint}_{#1}}\sX
.. |iX| mathmacro:: \def\iX#1{\mathit{int}_{#1}}\iX
.. |fX| mathmacro:: \def\fX#1{\mathit{float}_{#1}}\fX
.. |uN| mathmacro:: \href{../syntax/values.html#syntax-int}{\mathit{uint}_{N}}
.. |u1| mathmacro:: \href{../syntax/values.html#syntax-int}{\mathit{uint}_{1}}
.. |u8| mathmacro:: \href{../syntax/values.html#syntax-int}{\mathit{uint}_{8}}
.. |u16| mathmacro:: \href{../syntax/values.html#syntax-int}{\mathit{uint}_{16}}
.. |u32| mathmacro:: \href{../syntax/values.html#syntax-int}{\mathit{uint}_{32}}
.. |u64| mathmacro:: \href{../syntax/values.html#syntax-int}{\mathit{uint}_{64}}

.. |sN| mathmacro:: \href{../syntax/values.html#syntax-int}{\mathit{sint}_{N}}
.. |s32| mathmacro:: \href{../syntax/values.html#syntax-int}{\mathit{sint}_{32}}
.. |s64| mathmacro:: \href{../syntax/values.html#syntax-int}{\mathit{sint}_{64}}

.. |iN| mathmacro:: \href{../syntax/values.html#syntax-int}{\mathit{int}_{N}}
.. |i32| mathmacro:: \href{../syntax/values.html#syntax-int}{\mathit{int}_{32}}
.. |i64| mathmacro:: \href{../syntax/values.html#syntax-int}{\mathit{int}_{64}}

.. |fN| mathmacro:: \href{../syntax/values.html#syntax-float}{\mathit{float}_{N}}
.. |f32| mathmacro:: \href{../syntax/values.html#syntax-float}{\mathit{float}_{32}}
.. |f64| mathmacro:: \href{../syntax/values.html#syntax-float}{\mathit{float}_{64}}

.. |vec| mathmacro:: \href{../syntax/values.html#syntax-vec}{\mathit{vec}}
.. |name| mathmacro:: \href{../syntax/values.html#syntax-name}{\mathit{name}}


.. Types, terminals

.. |I32| mathmacro:: \href{../syntax/types.html#syntax-valtype}{\mathsf{i32}}
.. |I64| mathmacro:: \href{../syntax/types.html#syntax-valtype}{\mathsf{i64}}
.. |F32| mathmacro:: \href{../syntax/types.html#syntax-valtype}{\mathsf{f32}}
.. |F64| mathmacro:: \href{../syntax/types.html#syntax-valtype}{\mathsf{f64}}

.. |ANYFUNC| mathmacro:: \href{../syntax/types.html#syntax-elemtype}{\mathsf{anyfunc}}
.. |MUT| mathmacro:: \href{../syntax/types.html#syntax-mut}{\mathsf{mut}}

.. |MIN| mathmacro:: \mathsf{min}
.. |MAX| mathmacro:: \mathsf{max}


.. Types, non-terminals

.. |valtype| mathmacro:: \href{../syntax/types.html#syntax-valtype}{\mathit{valtype}}
.. |resulttype| mathmacro:: \href{../syntax/types.html#syntax-resulttype}{\mathit{resulttype}}
.. |functype| mathmacro:: \href{../syntax/types.html#syntax-functype}{\mathit{functype}}
.. |globaltype| mathmacro:: \href{../syntax/types.html#syntax-globaltype}{\mathit{globaltype}}
.. |tabletype| mathmacro:: \href{../syntax/types.html#syntax-tabletype}{\mathit{tabletype}}
.. |elemtype| mathmacro:: \href{../syntax/types.html#syntax-elemtype}{\mathit{elemtype}}
.. |memtype| mathmacro:: \href{../syntax/types.html#syntax-memtype}{\mathit{memtype}}
.. |externtype| mathmacro:: \href{../syntax/types.html#syntax-externtype}{\mathit{externtype}}
.. |limits| mathmacro:: \href{../syntax/types.html#syntax-limits}{\mathit{limits}}
.. |mut| mathmacro:: \href{../syntax/types.html#syntax-mut}{\mathit{mut}}


.. Indices

.. |typeidx| mathmacro:: \href{../syntax/modules.html#syntax-typeidx}{\mathit{typeidx}}
.. |funcidx| mathmacro:: \href{../syntax/modules.html#syntax-funcidx}{\mathit{funcidx}}
.. |tableidx| mathmacro:: \href{../syntax/modules.html#syntax-tableidx}{\mathit{tableidx}}
.. |memidx| mathmacro:: \href{../syntax/modules.html#syntax-memidx}{\mathit{memidx}}
.. |globalidx| mathmacro:: \href{../syntax/modules.html#syntax-globalidx}{\mathit{globalidx}}
.. |localidx| mathmacro:: \href{../syntax/modules.html#syntax-localidx}{\mathit{localidx}}
.. |labelidx| mathmacro:: \href{../syntax/modules.html#syntax-labelidx}{\mathit{labelidx}}


.. Modules, terminals

.. |TYPES| mathmacro:: \mathsf{types}
.. |FUNCS| mathmacro:: \mathsf{funcs}
.. |TABLES| mathmacro:: \mathsf{tables}
.. |MEMS| mathmacro:: \mathsf{mems}
.. |GLOBALS| mathmacro:: \mathsf{globals}
.. |LOCALS| mathmacro:: \mathsf{locals}
.. |LABELS| mathmacro:: \mathsf{labels}
.. |IMPORTS| mathmacro:: \mathsf{imports}
.. |EXPORTS| mathmacro:: \mathsf{exports}

.. |MODULE| mathmacro:: \mathsf{module}
.. |TYPE| mathmacro:: \mathsf{type}
.. |FUNC| mathmacro:: \mathsf{func}
.. |TABLE| mathmacro:: \mathsf{table}
.. |MEM| mathmacro:: \mathsf{mem}
.. |GLOBAL| mathmacro:: \mathsf{global}
.. |LOCAL| mathmacro:: \mathsf{local}
.. |LABEL| mathmacro:: \mathsf{label}
.. |IMPORT| mathmacro:: \mathsf{import}
.. |EXPORT| mathmacro:: \mathsf{export}
.. |CODE| mathmacro:: \mathsf{code}
.. |DATA| mathmacro:: \mathsf{data}
.. |ELEM| mathmacro:: \mathsf{elem}
.. |START| mathmacro:: \mathsf{start}
.. |CUSTOM| mathmacro:: \mathsf{custom}

.. |INDEX| mathmacro:: \mathsf{index}
.. |VALUE| mathmacro:: \mathsf{value}
.. |INIT| mathmacro:: \mathsf{init}
.. |BODY| mathmacro:: \mathsf{body}
.. |NAME| mathmacro:: \mathsf{name}
.. |DESC| mathmacro:: \mathsf{desc}


.. Modules, non-terminals

.. |module| mathmacro:: \href{../syntax/modules.html#syntax-module}{\mathit{module}}
.. |type| mathmacro:: \href{../syntax/modules.html#syntax-type}{\mathit{type}}
.. |func| mathmacro:: \href{../syntax/modules.html#syntax-func}{\mathit{func}}
.. |table| mathmacro:: \href{../syntax/modules.html#syntax-table}{\mathit{table}}
.. |mem| mathmacro:: \href{../syntax/modules.html#syntax-mem}{\mathit{mem}}
.. |global| mathmacro:: \href{../syntax/modules.html#syntax-global}{\mathit{global}}
.. |import| mathmacro:: \href{../syntax/modules.html#syntax-import}{\mathit{import}}
.. |export| mathmacro:: \href{../syntax/modules.html#syntax-export}{\mathit{export}}
.. |importdesc| mathmacro:: \href{../syntax/modules.html#syntax-importdesc}{\mathit{importdesc}}
.. |exportdesc| mathmacro:: \href{../syntax/modules.html#syntax-exportdesc}{\mathit{exportdesc}}
.. |elem| mathmacro:: \href{../syntax/modules.html#syntax-elemseg}{\mathit{elem}}
.. |data| mathmacro:: \href{../syntax/modules.html#syntax-dataseg}{\mathit{data}}
.. |start| mathmacro:: \href{../syntax/modules.html#syntax-start}{\mathit{start}}


.. Modules, meta functions

.. |funcs| mathmacro:: \href{../syntax/types.html#syntax-externtype}{\mathrm{funcs}}
.. |tables| mathmacro:: \href{../syntax/types.html#syntax-externtype}{\mathrm{tables}}
.. |mems| mathmacro:: \href{../syntax/types.html#syntax-externtype}{\mathrm{mems}}
.. |globals| mathmacro:: \href{../syntax/types.html#syntax-externtype}{\mathrm{globals}}


.. Instructions, terminals

.. |OFFSET| mathmacro:: \mathsf{offset}
.. |ALIGN| mathmacro:: \mathsf{align}

.. |UNREACHABLE| mathmacro:: \mathsf{unreachable}
.. |NOP| mathmacro:: \mathsf{nop}
.. |BLOCK| mathmacro:: \mathsf{block}
.. |LOOP| mathmacro:: \mathsf{loop}
.. |IF| mathmacro:: \mathsf{if}
.. |ELSE| mathmacro:: \mathsf{else}
.. |END| mathmacro:: \mathsf{end}
.. |BR| mathmacro:: \mathsf{br}
.. |BRIF| mathmacro:: \mathsf{br\_if}
.. |BRTABLE| mathmacro:: \mathsf{br\_table}
.. |RETURN| mathmacro:: \mathsf{return}
.. |CALL| mathmacro:: \mathsf{call}
.. |CALLINDIRECT| mathmacro:: \mathsf{call\_indirect}
.. |DROP| mathmacro:: \mathsf{drop}
.. |SELECT| mathmacro:: \mathsf{select}
.. |GETLOCAL| mathmacro:: \mathsf{get\_local}
.. |SETLOCAL| mathmacro:: \mathsf{set\_local}
.. |TEELOCAL| mathmacro:: \mathsf{tee\_local}
.. |GETGLOBAL| mathmacro:: \mathsf{get\_global}
.. |SETGLOBAL| mathmacro:: \mathsf{set\_global}
.. |LOAD| mathmacro:: \mathsf{load}
.. |STORE| mathmacro:: \mathsf{store}
.. |CURRENTMEMORY| mathmacro:: \mathsf{current\_memory}
.. |GROWMEMORY| mathmacro:: \mathsf{grow\_memory}
.. |CONST| mathmacro:: \mathsf{const}


.. Instructions, non-terminals

.. |unop| mathmacro:: \mathit{unop}
.. |binop| mathmacro:: \mathit{binop}
.. |testop| mathmacro:: \mathit{testop}
.. |relop| mathmacro:: \mathit{relop}
.. |cvtop| mathmacro:: \mathit{cvtop}

.. |sx| mathmacro:: \href{../syntax/instructions.html#syntax-sx}{\mathit{sx}}
.. |memarg| mathmacro:: \href{../syntax/instructions.html#syntax-memarg}{\mathit{memarg}}

.. |instr| mathmacro:: \href{../syntax/instructions.html#syntax-instr}{\mathit{instr}}
.. |expr| mathmacro:: \href{../syntax/modules.html#syntax-expr}{\mathit{expr}}

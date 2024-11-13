Modules
-------

:ref:`Modules <syntax-module>` are valid when all the components they contain are valid.
Furthermore, most definitions are themselves classified with a suitable type.


.. index:: type, type index, defined type, recursive type
   pair: abstract syntax; type
   single: abstract syntax; type
.. _valid-types:

Types
~~~~~

The sequence of :ref:`types <syntax-type>` defined in a module is validated incrementally, yielding a suitable :ref:`context <context>`.

:math:`\type^\ast`
..................

* If the sequence is empty, then:

  * The :ref:`context <context>` :math:`C` must be empty.

  * Then the type sequence is valid.

* Otherwise:

  * Let the :ref:`recursive type <syntax-rectype>` :math:`\rectype` be the last element in the sequence.

  * The sequence without :math:`\rectype` must be valid for some context :math:`C'`.

  * Let the :ref:`type index <syntax-typeidx>` :math:`x` be the length of :math:`C'.\CTYPES`, i.e., the first type index free in :math:`C'`.

  * Let the sequence of :ref:`defined types <syntax-deftype>` :math:`\deftype^\ast` be the result :math:`\rolldt_{x}(\rectype)` of :ref:`rolling up <aux-roll-deftype>` into its sequence of :ref:`defined types <syntax-deftype>`.

  * The :ref:`recursive type <syntax-rectype>` :math:`\rectype` must be :ref:`valid <valid-rectype>` under the context :math:`C` for :ref:`type index <syntax-typeidx>` :math:`x`.

  * The current :ref:`context <context>` :math:`C` be the same as :math:`C'`, but with :math:`\deftype^\ast` appended to |CTYPES|.

  * Then the type sequence is valid.

.. math::
   \frac{
   }{
     \{\} \vdashtypes \epsilon \ok
   }

.. math::
   \frac{
     C' \vdashtypes \type^\ast \ok
     \qquad
     C = C' \with \CTYPES = C'.\CTYPES~\rolldt_{|C'.\CTYPES|}(\rectype)
     \qquad
     C \vdashrectype \rectype ~{\ok}(|C'.\CTYPES|)
   }{
     C \vdashtypes \type^\ast~\rectype \ok
   }

.. note::
   Despite the appearance, the context :math:`C` is effectively an _output_ of this judgement.


.. index:: function, local, function index, local index, type index, function type, value type, local type, expression, import
   pair: abstract syntax; function
   single: abstract syntax; function
.. _valid-local:
.. _valid-func:

Functions
~~~~~~~~~

Functions :math:`\func` are classified by :ref:`defined types <syntax-deftype>` that :ref:`expand <aux-expand-deftype>` to :ref:`function types <syntax-functype>` of the form :math:`\TFUNC~[t_1^\ast] \toF [t_2^\ast]`.


:math:`\{ \FTYPE~x, \FLOCALS~t^\ast, \FBODY~\expr \}`
.....................................................

* The :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]` must be a :ref:`function type <syntax-functype>`.

* Let :math:`\TFUNC~[t_1^\ast] \toF [t_2^\ast]` be the :ref:`expansion <aux-expand-deftype>` of the :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]`.

* For each local declared by a :ref:`value type <syntax-valtype>` :math:`t` in :math:`t^\ast`:

  * The local for type :math:`t` must be :ref:`valid <valid-localtype>` with :ref:`local type <syntax-localtype>` :math:`\localtype_i`.

* Let :math:`\localtype^\ast` be the concatenation of all :math:`\localtype_i`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`,
  but with:

  * |CLOCALS| set to the sequence of :ref:`value types <syntax-valtype>` :math:`(\SET~t_1)^\ast~\localtype^\ast`, concatenating parameters and locals,

  * |CLABELS| set to the singular sequence containing only :ref:`result type <syntax-resulttype>` :math:`[t_2^\ast]`.

  * |CRETURN| set to the :ref:`result type <syntax-resulttype>` :math:`[t_2^\ast]`.

* Under the context :math:`C'`,
  the expression :math:`\expr` must be valid with type :math:`[t_2^\ast]`.

* Then the function definition is valid with type :math:`C.\CTYPES[x]`.

.. math::
   \frac{
     \expanddt(C.\CTYPES[x]) = \TFUNC~[t_1^\ast] \toF [t_2^\ast]
     \qquad
     (C \vdashlocal \{\LTYPE~t\} : \init~t)^\ast
     \qquad
     C,\CLOCALS\,(\SET~t_1)^\ast~(\init~t)^\ast,\CLABELS~[t_2^\ast],\CRETURN~[t_2^\ast] \vdashexpr \expr : [t_2^\ast]
   }{
     C \vdashfunc \{ \FTYPE~x, \FLOCALS~\{\LTYPE~t\}^\ast, \FBODY~\expr \} : C.\CTYPES[x]
   }


.. index:: local, local type, value type
   pair: validation; local
   single: abstract syntax; local
.. _valid-localtype:

Locals
~~~~~~

:ref:`Locals <syntax-local>` are classified with :ref:`local types <syntax-localtype>`.

:math:`\{ \LTYPE~\valtype \}`
.............................

* The :ref:`value type <syntax-valtype>` :math:`\valtype` must be :ref:`valid <valid-valtype>`.

* If :math:`\valtype` is :ref:`defaultable <valid-defaultable>`, then:

  * The local is valid with :ref:`local type <syntax-localtype>` :math:`\SET~\valtype`.

* Else:

  * The local is valid with :ref:`local type <syntax-localtype>` :math:`\UNSET~\valtype`.

.. math::
   \frac{
     C \vdashvaltype t \ok
     \qquad
     C \vdashvaltypedefaultable t \defaultable
   }{
     C \vdashlocal \{ \LTYPE~t \} : \SET~t
   }

.. math::
   \frac{
     C \vdashvaltype t \ok
   }{
     C \vdashlocal \{ \LTYPE~t \} : \UNSET~t
   }

.. note::
   For cases where both rules are applicable, the former yields the more permissable type.


.. index:: table, table type, reference type, expression, constant, defaultable
   pair: validation; table
   single: abstract syntax; table
.. _valid-table:

Tables
~~~~~~

Tables :math:`\table` are classified by :ref:`table types <syntax-tabletype>`.

:math:`\{ \TTYPE~\tabletype, \TINIT~\expr \}`
.............................................

* The :ref:`table type <syntax-tabletype>` :math:`\tabletype` must be :ref:`valid <valid-tabletype>`.

* Let :math:`t` be the element :ref:`reference type <syntax-reftype>` of :math:`\tabletype`.

* The expression :math:`\expr` must be :ref:`valid <valid-expr>` with :ref:`result type <syntax-resulttype>` :math:`[t]`.

* The expression :math:`\expr` must be :ref:`constant <valid-constant>`.

* Then the table definition is valid with type :math:`\tabletype`.

.. math::
   \frac{
     C \vdashtabletype \tabletype \ok
     \qquad
     \tabletype = \limits~t
     \qquad
     C \vdashexpr \expr : [t]
     \qquad
     C \vdashexprconst \expr \const
   }{
     C \vdashtable \{ \TTYPE~\tabletype, \TINIT~\expr \} : \tabletype
   }


.. index:: memory, memory type
   pair: validation; memory
   single: abstract syntax; memory
.. _valid-mem:

Memories
~~~~~~~~

Memories :math:`\mem` are classified by :ref:`memory types <syntax-memtype>`.

:math:`\{ \MTYPE~\memtype \}`
.............................

* The :ref:`memory type <syntax-memtype>` :math:`\memtype` must be :ref:`valid <valid-memtype>`.

* Then the memory definition is valid with type :math:`\memtype`.

.. math::
   \frac{
     C \vdashmemtype \memtype \ok
   }{
     C \vdashmem \{ \MTYPE~\memtype \} : \memtype
   }


.. index:: global, global type, expression, constant
   pair: validation; global
   single: abstract syntax; global
.. _valid-global:
.. _valid-globalseq:

Globals
~~~~~~~

Globals :math:`\global` are classified by :ref:`global types <syntax-globaltype>` of the form :math:`\mut~t`.

Sequences of globals are handled incrementally, such that each definition has access to previous definitions.


:math:`\{ \GTYPE~\mut~t, \GINIT~\expr \}`
.........................................

* The :ref:`global type <syntax-globaltype>` :math:`\mut~t` must be :ref:`valid <valid-globaltype>`.

* The expression :math:`\expr` must be :ref:`valid <valid-expr>` with :ref:`result type <syntax-resulttype>` :math:`[t]`.

* The expression :math:`\expr` must be :ref:`constant <valid-constant>`.

* Then the global definition is valid with type :math:`\mut~t`.

.. math::
   \frac{
     C \vdashglobaltype \mut~t \ok
     \qquad
     C \vdashexpr \expr : [t]
     \qquad
     C \vdashexprconst \expr \const
   }{
     C \vdashglobal \{ \GTYPE~\mut~t, \GINIT~\expr \} : \mut~t
   }


:math:`\global^\ast`
....................

* If the sequence is empty, then it is valid with the empty sequence of :ref:`global types <syntax-globaltype>`.

* Else:

  * The first global definition must be :ref:`valid <valid-global>` with some type :ref:`global type <syntax-globaltype>` :math:`\X{gt}_1`.

  * Let :math:`C'` be the same :ref:`context <context>` as :math:`C`, but with the :ref:`global type <syntax-globaltype>` :math:`\X{gt}_1` apppended to the |CGLOBALS| vector.

  * Under context :math:`C'`, the remainder of the sequence must be valid with some sequence :math:`\X{gt}^\ast` of :ref:`global types <syntax-globaltype>`.

  * Then the sequence is valid with the sequence of :ref:`global types <syntax-globaltype>` consisting of :math:`\X{gt}_1` prepended to :math:`\X{gt}^\ast`.

.. math::
   ~\\
   \frac{
   }{
     C \vdashglobals \epsilon : \epsilon
   }
   \qquad
   \frac{
     C \vdashglobal \global_1 : \X{gt}_1
     \qquad
     C \compose \{\CGLOBALS~\X{gt}_1\} \vdashglobals \global^\ast : \X{gt}^\ast
   }{
     C \vdashglobals \global_1~\global^\ast : \X{gt}_1~\X{gt}^\ast
   }



.. index:: tag, tag type, function type, exception tag
   pair: validation; tag
   single: abstract syntax; tag
.. _valid-tag:

Tags
~~~~

Tags :math:`\tag` are classified by their :ref:`tag type <syntax-tagtype>`,
each containing an index to a :ref:`function type <syntax-functype>` with empty result.

:math:`\{ \TAGTYPE~x \}`
........................

* The type :math:`C.\CTYPES[x]` must be defined in the context.

* Let :math:`[t^\ast] \to [{t'}^\ast]` be the :ref:`function type <syntax-functype>` :math:`C.\CTYPES[x]`.

* The sequence :math:`{t'}^\ast` must be empty.

* Then the tag definition is valid with :ref:`tag type <syntax-tagtype>` :math:`[t^\ast]\to[]`.

.. math::
   \frac{
     C.\CTYPES[x] = [t^\ast] \to []
   }{
     C \vdashtag \{ \TAGTYPE~x \} : [t^\ast]\to[]
   }

.. note::
   Future versions of WebAssembly might allow non-empty return types for tags.


.. index:: element, table, table index, expression, constant, function index
   pair: validation; element
   single: abstract syntax; element
   single: table; element
   single: element; segment
.. _valid-elem:

Element Segments
~~~~~~~~~~~~~~~~

Element segments :math:`\elem` are classified by the :ref:`reference type <syntax-reftype>` of their elements.

:math:`\{ \ETYPE~t, \EINIT~e^\ast, \EMODE~\elemmode \}`
.......................................................

* The :ref:`reference type <syntax-reftype>` :math:`t` must be :ref:`valid <valid-reftype>`.

* For each :math:`e_i` in :math:`e^\ast`:

  * The expression :math:`e_i` must be :ref:`valid <valid-expr>` with some :ref:`result type <syntax-resulttype>` :math:`[t]`.

  * The expression :math:`e_i` must be :ref:`constant <valid-constant>`.

* The element mode :math:`\elemmode` must be valid with some :ref:`reference type <syntax-reftype>` :math:`t'`.

* The reference type :math:`t` must :ref:`match <match-reftype>` the reference type :math:`t'`.

* Then the element segment is valid with :ref:`reference type <syntax-reftype>` :math:`t`.


.. math::
   \frac{
     C \vdashreftype t \ok
     \qquad
     (C \vdashexpr e : [t])^\ast
     \qquad
     (C \vdashexprconst e \const)^\ast
     \qquad
     C \vdashelemmode \elemmode : t'
     \qquad
     C \vdashreftypematch t \matchesreftype t'
   }{
     C \vdashelem \{ \ETYPE~t, \EINIT~e^\ast, \EMODE~\elemmode \} : t
   }


.. _valid-elemmode:

:math:`\EPASSIVE`
.................

* The element mode is valid with any :ref:`valid <valid-reftype>` :ref:`reference type <syntax-reftype>`.

.. math::
   \frac{
     C \vdashreftype \reftype \ok
   }{
     C \vdashelemmode \EPASSIVE : \reftype
   }


:math:`\EACTIVE~\{ \ETABLE~x, \EOFFSET~\expr \}`
................................................

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Let :math:`\limits~t` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[x]`.

* The expression :math:`\expr` must be :ref:`valid <valid-expr>` with :ref:`result type <syntax-resulttype>` :math:`[\I32]`.

* The expression :math:`\expr` must be :ref:`constant <valid-constant>`.

* Then the element mode is valid with :ref:`reference type <syntax-reftype>` :math:`t`.

.. math::
   \frac{
     \begin{array}{@{}c@{}}
     C.\CTABLES[x] = \limits~t
     \\
     C \vdashexpr \expr : [\I32]
     \qquad
     C \vdashexprconst \expr \const
     \end{array}
   }{
     C \vdashelemmode \EACTIVE~\{ \ETABLE~x, \EOFFSET~\expr \} : t
   }

:math:`\EDECLARATIVE`
.....................

* The element mode is valid with any :ref:`valid <valid-reftype>` :ref:`reference type <syntax-reftype>`.

.. math::
   \frac{
     C \vdashreftype \reftype \ok
   }{
     C \vdashelemmode \EDECLARATIVE : \reftype
   }



.. index:: data, memory, memory index, expression, constant, byte
   pair: validation; data
   single: abstract syntax; data
   single: memory; data
   single: data; segment
.. _valid-data:

Data Segments
~~~~~~~~~~~~~

Data segments :math:`\data` are not classified by any type but merely checked for well-formedness.

:math:`\{ \DINIT~b^\ast, \DMODE~\datamode \}`
....................................................

* The data mode :math:`\datamode` must be valid.

* Then the data segment is valid.

.. math::
   \frac{
     C \vdashdatamode \datamode \ok
   }{
     C \vdashdata \{ \DINIT~b^\ast, \DMODE~\datamode \} \ok
   }


.. _valid-datamode:

:math:`\DPASSIVE`
.................

* The data mode is valid.

.. math::
   \frac{
   }{
     C \vdashdatamode \DPASSIVE \ok
   }


:math:`\DACTIVE~\{ \DMEM~x, \DOFFSET~\expr \}`
..............................................

* The memory :math:`C.\CMEMS[x]` must be defined in the context.

* The expression :math:`\expr` must be :ref:`valid <valid-expr>` with :ref:`result type <syntax-resulttype>` :math:`[\I32]`.

* The expression :math:`\expr` must be :ref:`constant <valid-constant>`.

* Then the data mode is valid.

.. math::
   \frac{
     C.\CMEMS[x] = \limits
     \qquad
     C \vdashexpr \expr : [\I32]
     \qquad
     C \vdashexprconst \expr \const
   }{
     C \vdashdatamode \DACTIVE~\{ \DMEM~x, \DOFFSET~\expr \} \ok
   }


.. index:: start function, function index
   pair: validation; start function
   single: abstract syntax; start function
.. _valid-start:

Start Function
~~~~~~~~~~~~~~

Start function declarations :math:`\start` are not classified by any type.

:math:`\{ \SFUNC~x \}`
......................

* The function :math:`C.\CFUNCS[x]` must be defined in the context.

* The :ref:`expansion <aux-expand-deftype>` of :math:`C.\CFUNCS[x]` must be a :ref:`function type <syntax-functype>` :math:`\TFUNC~[] \toF []`.

* Then the start function is valid.


.. math::
   \frac{
     \expanddt(C.\CFUNCS[x]) = \TFUNC~[] \toF []
   }{
     C \vdashstart \{ \SFUNC~x \} \ok
   }


.. index:: export, name, index, function index, table index, memory index, global index, tag index
   pair: validation; export
   single: abstract syntax; export
.. _valid-exportdesc:
.. _valid-export:

Exports
~~~~~~~

Exports :math:`\export` and export descriptions :math:`\exportdesc` are classified by their :ref:`external type <syntax-externtype>`.


:math:`\{ \ENAME~\name, \EDESC~\exportdesc \}`
..............................................

* The export description :math:`\exportdesc` must be valid with :ref:`external type <syntax-externtype>` :math:`\externtype`.

* Then the export is valid with :ref:`external type <syntax-externtype>` :math:`\externtype`.

.. math::
   \frac{
     C \vdashexportdesc \exportdesc : \externtype
   }{
     C \vdashexport \{ \ENAME~\name, \EDESC~\exportdesc \} : \externtype
   }


:math:`\EDFUNC~x`
.................

* The function :math:`C.\CFUNCS[x]` must be defined in the context.

* Let :math:`\X{dt}` be the :ref:`defined type <syntax-deftype>` :math:`C.\CFUNCS[x]`.

* Then the export description is valid with :ref:`external type <syntax-externtype>` :math:`\ETFUNC~\X{dt}`.

.. math::
   \frac{
     C.\CFUNCS[x] = \X{dt}
   }{
     C \vdashexportdesc \EDFUNC~x : \ETFUNC~\X{dt}
   }


:math:`\EDTABLE~x`
..................

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Then the export description is valid with :ref:`external type <syntax-externtype>` :math:`\ETTABLE~C.\CTABLES[x]`.

.. math::
   \frac{
     C.\CTABLES[x] = \tabletype
   }{
     C \vdashexportdesc \EDTABLE~x : \ETTABLE~\tabletype
   }


:math:`\EDMEM~x`
................

* The memory :math:`C.\CMEMS[x]` must be defined in the context.

* Then the export description is valid with :ref:`external type <syntax-externtype>` :math:`\ETMEM~C.\CMEMS[x]`.

.. math::
   \frac{
     C.\CMEMS[x] = \memtype
   }{
     C \vdashexportdesc \EDMEM~x : \ETMEM~\memtype
   }


:math:`\EDGLOBAL~x`
...................

* The global :math:`C.\CGLOBALS[x]` must be defined in the context.

* Then the export description is valid with :ref:`external type <syntax-externtype>` :math:`\ETGLOBAL~C.\CGLOBALS[x]`.

.. math::
   \frac{
     C.\CGLOBALS[x] = \globaltype
   }{
     C \vdashexportdesc \EDGLOBAL~x : \ETGLOBAL~\globaltype
   }


:math:`\EDTAG~x`
................

* The tag :math:`C.\CTAGS[x]` must be defined in the context.

* Then the export description is valid with :ref:`external type <syntax-externtype>` :math:`\ETTAG~C.\CTAGS[x]`.

.. math::
   \frac{
     C.\CTAGS[x] = \tagtype
   }{
     C \vdashexportdesc \EDTAG~x : \ETTAG~\tagtype
   }


.. index:: import, name, function type, table type, memory type, global type, tag type
   pair: validation; import
   single: abstract syntax; import
.. _valid-importdesc:
.. _valid-import:

Imports
~~~~~~~

Imports :math:`\import` and import descriptions :math:`\importdesc` are classified by :ref:`external types <syntax-externtype>`.


:math:`\{ \IMODULE~\name_1, \INAME~\name_2, \IDESC~\importdesc \}`
..................................................................

* The import description :math:`\importdesc` must be valid with type :math:`\externtype`.

* Then the import is valid with type :math:`\externtype`.

.. math::
   \frac{
     C \vdashimportdesc \importdesc : \externtype
   }{
     C \vdashimport \{ \IMODULE~\name_1, \INAME~\name_2, \IDESC~\importdesc \} : \externtype
   }


:math:`\IDFUNC~x`
.................

* The :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]` must be a :ref:`function type <syntax-functype>`.

* Then the import description is valid with type :math:`\ETFUNC~C.\CTYPES[x]`.

.. math::
   \frac{
     \expanddt(C.\CTYPES[x]) = \TFUNC~\functype
   }{
     C \vdashimportdesc \IDFUNC~x : \ETFUNC~C.\CTYPES[x]
   }


:math:`\IDTABLE~\tabletype`
...........................

* The table type :math:`\tabletype` must be :ref:`valid <valid-tabletype>`.

* Then the import description is valid with type :math:`\ETTABLE~\tabletype`.

.. math::
   \frac{
     C \vdashtable \tabletype \ok
   }{
     C \vdashimportdesc \IDTABLE~\tabletype : \ETTABLE~\tabletype
   }


:math:`\IDMEM~\memtype`
.......................

* The memory type :math:`\memtype` must be :ref:`valid <valid-memtype>`.

* Then the import description is valid with type :math:`\ETMEM~\memtype`.

.. math::
   \frac{
     C \vdashmemtype \memtype \ok
   }{
     C \vdashimportdesc \IDMEM~\memtype : \ETMEM~\memtype
   }


:math:`\IDGLOBAL~\globaltype`
.............................

* The global type :math:`\globaltype` must be :ref:`valid <valid-globaltype>`.

* Then the import description is valid with type :math:`\ETGLOBAL~\globaltype`.

.. math::
   \frac{
     C \vdashglobaltype \globaltype \ok
   }{
     C \vdashimportdesc \IDGLOBAL~\globaltype : \ETGLOBAL~\globaltype
   }


:math:`\IDTAG~\tag`
...................

* Let :math:`\{ \TAGTYPE~x \}` be the tag :math:`\tag`.

* The type :math:`C.\CTYPES[x]` must be defined in the context.

* The :ref:`tag type <syntax-tagtype>` :math:`C.\CTYPES[x]` must be a :ref:`valid tag type <valid-tagtype>`.

* Then the import description is valid with type :math:`\ETTAG~C.\CTYPES[x]`.

.. math::
   \frac{
     \vdashtagtype C.\CTYPES[x] \ok
   }{
     C \vdashimportdesc \IDTAG~\{ \TAGTYPE~x \} : \ETTAG~C.\CTYPES[x]
   }



.. index:: module, type definition, function type, function, table, memory, global, tag, element, data, start function, import, export, context
   pair: validation; module
   single: abstract syntax; module
.. _valid-module:

Modules
~~~~~~~

Modules are classified by their mapping from the :ref:`external types <syntax-externtype>` of their :ref:`imports <syntax-import>` to those of their :ref:`exports <syntax-export>`.

A module is entirely *closed*,
that is, its components can only refer to definitions that appear in the module itself.
Consequently, no initial :ref:`context <context>` is required.
Instead, the context :math:`C` for validation of the module's content is constructed from the definitions in the module.

The :ref:`external types <syntax-externtype>` classifying a module may contain free :ref:`type indices <syntax-typeidx>` that refer to types defined within the module.


* Let :math:`\module` be the module to validate.

* The :ref:`types <syntax-type>` :math:`\module.\MTYPES` must be :ref:`valid <valid-type>` yielding a :ref:`context <context>` :math:`C_0`.

* Let :math:`C` be a :ref:`context <context>` where:

  * :math:`C.\CTYPES` is :math:`C_0.\CTYPES`,

  * :math:`C.\CFUNCS` is :math:`\etfuncs(\X{it}^\ast)` concatenated with :math:`\X{dt}^\ast`,
    with the import's :ref:`external types <syntax-externtype>` :math:`\X{it}^\ast` and the internal :ref:`defined types <syntax-deftype>` :math:`\X{dt}^\ast` as determined below,

  * :math:`C.\CTABLES` is :math:`\ettables(\X{it}^\ast)` concatenated with :math:`\X{tt}^\ast`,
    with the import's :ref:`external types <syntax-externtype>` :math:`\X{it}^\ast` and the internal :ref:`table types <syntax-tabletype>` :math:`\X{tt}^\ast` as determined below,

  * :math:`C.\CMEMS` is :math:`\etmems(\X{it}^\ast)` concatenated with :math:`\X{mt}^\ast`,
    with the import's :ref:`external types <syntax-externtype>` :math:`\X{it}^\ast` and the internal :ref:`memory types <syntax-memtype>` :math:`\X{mt}^\ast` as determined below,

  * :math:`C.\CGLOBALS` is :math:`\etglobals(\X{it}^\ast)` concatenated with :math:`\X{gt}^\ast`,
    with the import's :ref:`external types <syntax-externtype>` :math:`\X{it}^\ast` and the internal :ref:`global types <syntax-globaltype>` :math:`\X{gt}^\ast` as determined below,

  * :math:`C.\CTAGS` is :math:`\ettags(\X{it}^\ast)` concatenated with :math:`\X{ht}^\ast`,
    with the import's :ref:`external types <syntax-externtype>` :math:`\X{it}^\ast` and the internal :ref:`tag types <syntax-tagtype>` :math:`\X{ht}^\ast` as determined below,

  * :math:`C.\CELEMS` is :math:`{\X{rt}}^\ast` as determined below,

  * :math:`C.\CDATAS` is :math:`{\ok}^n`, where :math:`n` is the length of the vector :math:`\module.\MDATAS`,

  * :math:`C.\CLOCALS` is empty,

  * :math:`C.\CLABELS` is empty,

  * :math:`C.\CRETURN` is empty.

  * :math:`C.\CREFS` is the set :math:`\freefuncidx(\module \with \MFUNCS = \epsilon \with \MSTART = \epsilon)`, i.e., the set of :ref:`function indices <syntax-funcidx>` occurring in the module, except in its :ref:`functions <syntax-func>` or :ref:`start function <syntax-start>`.

* Let :math:`C'` be the :ref:`context <context>` where:

  * :math:`C'.\CGLOBALS` is the sequence :math:`\etglobals(\X{it}^\ast)`,

  * :math:`C'.\CTYPES` is the same as :math:`C.\CTYPES`,

  * :math:`C'.\CFUNCS` is the same as :math:`C.\CFUNCS`,

  * :math:`C'.\CTABLES` is the same as :math:`C.\CTABLES`,

  * :math:`C'.\CMEMS` is the same as :math:`C.\CMEMS`,

  * :math:`C'.\CREFS` is the same as :math:`C.\CREFS`,

  * all other fields are empty.

* Under the context :math:`C'`:

  * The sequence :math:`\module.\MGLOBALS` of :ref:`globals <syntax-global>` must be :ref:`valid <valid-globalseq>` with a sequence :math:`\X{gt}^\ast` of :ref:`global types <syntax-globaltype>`.

  * For each :math:`\table_i` in :math:`\module.\MTABLES`,
    the definition :math:`\table_i` must be :ref:`valid <valid-table>` with a :ref:`table type <syntax-tabletype>` :math:`\X{tt}_i`.

  * For each :math:`\mem_i` in :math:`\module.\MMEMS`,
    the definition :math:`\mem_i` must be :ref:`valid <valid-mem>` with a :ref:`memory type <syntax-memtype>` :math:`\X{mt}_i`.

* Under the context :math:`C`:

  * For each :math:`\func_i` in :math:`\module.\MFUNCS`,
    the definition :math:`\func_i` must be :ref:`valid <valid-func>` with a :ref:`defined type <syntax-deftype>` :math:`\X{dt}_i`.

  * For each :math:`\tag_i` in :math:`\module.\MTAGS`,
    the definition :math:`\tag_i` must be :ref:`valid <valid-tag>` with a :ref:`tag type <syntax-tagtype>` :math:`\X{ht}_i`.

  * For each :math:`\elem_i` in :math:`\module.\MELEMS`,
    the segment :math:`\elem_i` must be :ref:`valid <valid-elem>` with :ref:`reference type <syntax-reftype>` :math:`\X{rt}_i`.

  * For each :math:`\data_i` in :math:`\module.\MDATAS`,
    the segment :math:`\data_i` must be :ref:`valid <valid-data>`.

  * If :math:`\module.\MSTART` is non-empty,
    then :math:`\module.\MSTART` must be :ref:`valid <valid-start>`.

  * For each :math:`\import_i` in :math:`\module.\MIMPORTS`,
    the segment :math:`\import_i` must be :ref:`valid <valid-import>` with an :ref:`external type <syntax-externtype>` :math:`\X{it}_i`.

  * For each :math:`\export_i` in :math:`\module.\MEXPORTS`,
    the segment :math:`\export_i` must be :ref:`valid <valid-export>` with :ref:`external type <syntax-externtype>` :math:`\X{et}_i`.

* Let :math:`\X{dt}^\ast` be the concatenation of the internal :ref:`function types <syntax-functype>` :math:`\X{dt}_i`, in index order.

* Let :math:`\X{tt}^\ast` be the concatenation of the internal :ref:`table types <syntax-tabletype>` :math:`\X{tt}_i`, in index order.

* Let :math:`\X{mt}^\ast` be the concatenation of the internal :ref:`memory types <syntax-memtype>` :math:`\X{mt}_i`, in index order.

* Let :math:`\X{gt}^\ast` be the concatenation of the internal :ref:`global types <syntax-globaltype>` :math:`\X{gt}_i`, in index order.

* Let :math:`\X{ht}^\ast` be the concatenation of the internal :ref:`tag types <syntax-tagtype>` :math:`\X{ht}_i`, in index order.

* Let :math:`\X{rt}^\ast` be the concatenation of the :ref:`reference types <syntax-reftype>` :math:`\X{rt}_i`, in index order.

* Let :math:`\X{it}^\ast` be the concatenation of :ref:`external types <syntax-externtype>` :math:`\X{it}_i` of the imports, in index order.

* Let :math:`\X{et}^\ast` be the concatenation of :ref:`external types <syntax-externtype>` :math:`\X{et}_i` of the exports, in index order.

* All export names :math:`\export_i.\ENAME` must be different.

* Then the module is valid with :ref:`external types <syntax-externtype>` :math:`\X{it}^\ast \to \X{et}^\ast`.

.. math::
   \frac{
     \begin{array}{@{}c@{}}
     C_0 \vdashtypes \type^\ast \ok
     \quad
     C' \vdashglobals \global^\ast : \X{gt}^\ast
     \quad
     (C' \vdashtable \table : \X{tt})^\ast
     \quad
     (C' \vdashmem \mem : \X{mt})^\ast
     \quad
     (C \vdashfunc \func : \X{dt})^\ast
     \quad
     (C \vdashtag \tag : \X{ht})^\ast
     \\
     (C \vdashelem \elem : \X{rt})^\ast
     \quad
     (C \vdashdata \data \ok)^n
     \quad
     (C \vdashstart \start \ok)^?
     \quad
     (C \vdashimport \import : \X{it})^\ast
     \\
     \X{idt}^\ast = \etfuncs(\X{it}^\ast)
     \qquad
     \X{itt}^\ast = \ettables(\X{it}^\ast)
     \qquad
     \X{imt}^\ast = \etmems(\X{it}^\ast)
     \\
     \X{igt}^\ast = \etglobals(\X{it}^\ast)
     \qquad
     \X{iht}^\ast = \ettags(\X{it}^\ast)
     \\
     x^\ast = \freefuncidx(\module \with \MFUNCS = \epsilon \with \MSTART = \epsilon)
     \\
     C = \{
       \CTYPES~C_0.\CTYPES,
       \CFUNCS~\X{idt}^\ast\,\X{dt}^\ast,
       \CTABLES~\X{itt}^\ast\,\X{tt}^\ast,
       \CMEMS~\X{imt}^\ast\,\X{mt}^\ast,
       \CGLOBALS~\X{igt}^\ast\,\X{gt}^\ast,
       \CTAGS~\X{iht}^\ast\,\X{ht}^\ast,
       \CELEMS~\X{rt}^\ast,
       \CDATAS~{\ok}^n,
       \CREFS~x^\ast \}
     \\
     C' = \{ \CTYPES~C_0.\CTYPES, \CGLOBALS~\X{igt}^\ast, \CFUNCS~(C.\CFUNCS), \CTABLES~(C.\CTABLES), \CMEMS~(C.\CMEMS), \CREFS~(C.\CREFS) \}
     \qquad
     (\export.\ENAME)^\ast ~\F{disjoint}
     \\
     \module = \{
       \begin{array}[t]{@{}l@{}}
         \MTYPES~\type^\ast,
         \MFUNCS~\func^\ast,
         \MTABLES~\table^\ast,
         \MMEMS~\mem^\ast,
         \MGLOBALS~\global^\ast,
         \MTAGS~\tag^\ast, \\
         \MELEMS~\elem^\ast,
         \MDATAS~\data^n,
         \MSTART~\start^?,
         \MIMPORTS~\import^\ast,
         \MEXPORTS~\export^\ast \}
       \end{array}
     \end{array}
   }{
     \vdashmodule \module : \X{it}^\ast \to \X{et}^\ast
   }

.. note::
   All functions in a module are mutually recursive.
   Consequently, the definition of the :ref:`context <context>` :math:`C` in this rule is recursive:
   it depends on the outcome of validation of the function, table, memory, and global definitions contained in the module,
   which itself depends on :math:`C`.
   However, this recursion is just a specification device.
   All types needed to construct :math:`C` can easily be determined from a simple pre-pass over the module that does not perform any actual validation.

   Globals, however, are not recursive but evaluated sequentially, such that each :ref:`constant expressions <valid-const>` only has access to imported or previously defined globals.

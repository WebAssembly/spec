Modules
-------

:ref:`Modules <syntax-module>` are valid when all the components they contain are valid.
Furthermore, most definitions are themselves classified with a suitable type.


.. index:: function, local, function index, local index, type index, function type, value type, expression, import
   pair: abstract syntax; function
   single: abstract syntax; function
.. _valid-local:
.. _valid-func:

Functions
~~~~~~~~~

Functions :math:`\func` are classified by :ref:`function types <syntax-functype>` of the form :math:`[t_1^\ast] \to [t_2^?]`.


:math:`\{ \FTYPE~x, \FLOCALS~t^\ast, \FBODY~\expr \}`
.....................................................

* The type :math:`C.\CTYPES[x]` must be defined in the context.

* Let :math:`[t_1^\ast] \to [t_2^?]` be the :ref:`function type <syntax-functype>` :math:`C.\CTYPES[x]`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`,
  but with:

  * |CLOCALS| set to the sequence of :ref:`value types <syntax-valtype>` :math:`t_1^\ast~t^\ast`, concatenating parameters and locals,

  * |CLABELS| set to the singular sequence containing only :ref:`result type <syntax-valtype>` :math:`[t_2^?]`.

  * |CRETURN| set to the :ref:`result type <syntax-valtype>` :math:`[t_2^?]`.

* Under the context :math:`C'`,
  the expression :math:`\expr` must be valid with type :math:`t_2^?`.

* Then the function definition is valid with type :math:`[t_1^\ast] \to [t_2^?]`.

.. math::
   \frac{
     C.\CTYPES[x] = [t_1^\ast] \to [t_2^?]
     \qquad
     C,\CLOCALS\,t_1^\ast~t^\ast,\CLABELS~[t_2^?],\CRETURN~[t_2^?] \vdashexpr \expr : [t_2^?]
   }{
     C \vdashfunc \{ \FTYPE~x, \FLOCALS~t^\ast, \FBODY~\expr \} : [t_1^\ast] \to [t_2^?]
   }

.. note::
   The restriction on the length of the result types :math:`t_2^\ast` may be lifted in future versions of WebAssembly.


.. index:: table, table type
   pair: validation; table
   single: abstract syntax; table
.. _valid-table:

Tables
~~~~~~

Tables :math:`\table` are classified by :ref:`table types <syntax-tabletype>`.

:math:`\{ \TTYPE~\tabletype \}`
...............................

* The :ref:`table type <syntax-tabletype>` :math:`\tabletype` must be :ref:`valid <valid-tabletype>`.

* Then the table definition is valid with type :math:`\tabletype`.

.. math::
   \frac{
     \vdashtabletype \tabletype \ok
   }{
     C \vdashtable \{ \TTYPE~\tabletype \} : \tabletype
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
     \vdashmemtype \memtype \ok
   }{
     C \vdashmem \{ \MTYPE~\memtype \} : \memtype
   }


.. index:: global, global type, expression
   pair: validation; global
   single: abstract syntax; global
.. _valid-global:

Globals
~~~~~~~

Globals :math:`\global` are classified by :ref:`global types <syntax-globaltype>` of the form :math:`\mut~t`.


:math:`\{ \GTYPE~\mut~t, \GINIT~\expr \}`
.........................................

* The :ref:`global type <syntax-globaltype>` :math:`\mut~t` must be :ref:`valid <valid-globaltype>`.

* The expression :math:`\expr` must be :ref:`valid <valid-expr>` with :ref:`result type <syntax-resulttype>` :math:`[t]`.

* The expression :math:`\expr` must be :ref:`constant <valid-constant>`.

* Then the global definition is valid with type :math:`\mut~t`.

.. math::
   \frac{
     \vdashglobaltype \mut~t \ok
     \qquad
     C \vdashexpr \expr : [t]
     \qquad
     C \vdashexprconst \expr \const
   }{
     C \vdashglobal \{ \GTYPE~\mut~t, \GINIT~\expr \} : \mut~t
   }


.. index:: element, table, table index, expression, function index
   pair: validation; element
   single: abstract syntax; element
   single: table; element
   single: element; segment
.. _valid-elem:

Element Segments
~~~~~~~~~~~~~~~~

Element segments :math:`\elem` are classified by :ref:`segment types <syntax-segtype>`.

:math:`\{ \ETABLE~x, \EOFFSET~\expr, \EINIT~e^\ast \}`
......................................................

* The table :math:`C.\CTABLES[x]` must be defined in the context.

* Let :math:`\limits~\elemtype` be the :ref:`table type <syntax-tabletype>` :math:`C.\CTABLES[x]`.

* The :ref:`element type <syntax-elemtype>` :math:`\elemtype` must be |FUNCREF|.

* The expression :math:`\expr` must be :ref:`valid <valid-expr>` with :ref:`result type <syntax-resulttype>` :math:`[\I32]`.

* The expression :math:`\expr` must be :ref:`constant <valid-constant>`.

* For each :math:`e_i` in :math:`e^\ast`,

  * The element expression :math:`e_i` must be :ref:`valid <valid-elemexpr>`.

* Then the element segment is valid with type |SACTIVE|.


.. math::
   \frac{
     C.\CTABLES[x] = \limits~\FUNCREF
     \qquad
     C \vdashexpr \expr : [\I32]
     \qquad
     C \vdashexprconst \expr \const
     \qquad
     (C \vdashelemexpr e \ok)^\ast
   }{
     C \vdashelem \{ \ETABLE~x, \EOFFSET~\expr, \EINIT~e^\ast \} : \SACTIVE
   }


:math:`\{ \ETYPE~et, \EINIT~e^\ast \}`
......................................

* For each :math:`e_i` in :math:`e^\ast`,

  * The element expression :math:`e_i` must be :ref:`valid <valid-elemexpr>`.

* Then the element segment is valid with type |SPASSIVE|.


.. math::
   \frac{
     (C \vdashelemexpr e \ok)^\ast
   }{
     C \vdashelem \{ \ETYPE~et, \EINIT~e^\ast \} : \SPASSIVE
   }


.. _valid-elemexpr:

:math:`\elemexpr`
.................

* An element expression must be:

  * either of the form :math:`\REFNULL~\END`,

  * or of the form :math:`(\REFFUNC~x)~\END`, in which case :math:`C.\CFUNCS[x]` must be defined in the context.

.. math::
   \frac{
   }{
     C \vdashelemexpr \REFNULL~\END \ok
   }
   \qquad
   \frac{
     C.\CFUNCS[x] = \functype
   }{
     C \vdashelemexpr (\REFFUNC~x)~\END \ok
   }


.. index:: data, memory, memory index, expression, byte
   pair: validation; data
   single: abstract syntax; data
   single: memory; data
   single: data; segment
.. _valid-data:

Data Segments
~~~~~~~~~~~~~

Data segments :math:`\data` are classified by :ref:`segment types <syntax-segtype>`.

:math:`\{ \DMEM~x, \DOFFSET~\expr, \DINIT~b^\ast \}`
....................................................

* The memory :math:`C.\CMEMS[x]` must be defined in the context.

* The expression :math:`\expr` must be :ref:`valid <valid-expr>` with :ref:`result type <syntax-resulttype>` :math:`[\I32]`.

* The expression :math:`\expr` must be :ref:`constant <valid-constant>`.

* Then the data segment is valid with type |SACTIVE|.


.. math::
   \frac{
     C.\CMEMS[x] = \limits
     \qquad
     C \vdashexpr \expr : [\I32]
     \qquad
     C \vdashexprconst \expr \const
   }{
     C \vdashdata \{ \DMEM~x, \DOFFSET~\expr, \DINIT~b^\ast \} : \SACTIVE
   }


:math:`\{ \DINIT~b^\ast \}`
....................................................

* The data segment is valid.


.. math::
   \frac{
   }{
     C \vdashdata \{ \DINIT~b^\ast \} : \SPASSIVE
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

* The type of :math:`C.\CFUNCS[x]` must be :math:`[] \to []`.

* Then the start function is valid.


.. math::
   \frac{
     C.\CFUNCS[x] = [] \to []
   }{
     C \vdashstart \{ \SFUNC~x \} \ok
   }


.. index:: export, name, index, function index, table index, memory index, global index
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

* Then the export description is valid with :ref:`external type <syntax-externtype>` :math:`\ETFUNC~C.\CFUNCS[x]`.

.. math::
   \frac{
     C.\CFUNCS[x] = \functype
   }{
     C \vdashexportdesc \EDFUNC~x : \ETFUNC~\functype
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


.. index:: import, name, function type, table type, memory type, global type
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

* The function :math:`C.\CTYPES[x]` must be defined in the context.

* Let :math:`[t_1^\ast] \to [t_2^\ast]` be the :ref:`function type <syntax-functype>` :math:`C.\CTYPES[x]`.

* Then the import description is valid with type :math:`\ETFUNC~[t_1^\ast] \to [t_2^\ast]`.

.. math::
   \frac{
     C.\CTYPES[x] = [t_1^\ast] \to [t_2^\ast]
   }{
     C \vdashimportdesc \IDFUNC~x : \ETFUNC~[t_1^\ast] \to [t_2^\ast]
   }


:math:`\IDTABLE~\tabletype`
...........................

* The table type :math:`\tabletype` must be :ref:`valid <valid-tabletype>`.

* Then the import description is valid with type :math:`\ETTABLE~\tabletype`.

.. math::
   \frac{
     \vdashtable \tabletype \ok
   }{
     C \vdashimportdesc \IDTABLE~\tabletype : \ETTABLE~\tabletype
   }


:math:`\IDMEM~\memtype`
.......................

* The memory type :math:`\memtype` must be :ref:`valid <valid-memtype>`.

* Then the import description is valid with type :math:`\ETMEM~\memtype`.

.. math::
   \frac{
     \vdashmemtype \memtype \ok
   }{
     C \vdashimportdesc \IDMEM~\memtype : \ETMEM~\memtype
   }


:math:`\IDGLOBAL~\globaltype`
.............................

* The global type :math:`\globaltype` must be :ref:`valid <valid-globaltype>`.

* Then the import description is valid with type :math:`\ETGLOBAL~\globaltype`.

.. math::
   \frac{
     \vdashglobaltype \globaltype \ok
   }{
     C \vdashimportdesc \IDGLOBAL~\globaltype : \ETGLOBAL~\globaltype
   }


.. index:: module, type definition, function type, function, table, memory, global, element, data, start function, import, export, context
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

* Let :math:`\module` be the module to validate.

* Let :math:`C` be a :ref:`context <context>` where:

  * :math:`C.\CTYPES` is :math:`\module.\MTYPES`,

  * :math:`C.\CFUNCS` is :math:`\etfuncs(\X{it}^\ast)` concatenated with :math:`\X{ft}^\ast`,
    with the import's :ref:`external types <syntax-externtype>` :math:`\X{it}^\ast` and the internal :ref:`function types <syntax-functype>` :math:`\X{ft}^\ast` as determined below,

  * :math:`C.\CTABLES` is :math:`\ettables(\X{it}^\ast)` concatenated with :math:`\X{tt}^\ast`,
    with the import's :ref:`external types <syntax-externtype>` :math:`\X{it}^\ast` and the internal :ref:`table types <syntax-tabletype>` :math:`\X{tt}^\ast` as determined below,

  * :math:`C.\CMEMS` is :math:`\etmems(\X{it}^\ast)` concatenated with :math:`\X{mt}^\ast`,
    with the import's :ref:`external types <syntax-externtype>` :math:`\X{it}^\ast` and the internal :ref:`memory types <syntax-memtype>` :math:`\X{mt}^\ast` as determined below,

  * :math:`C.\CGLOBALS` is :math:`\etglobals(\X{it}^\ast)` concatenated with :math:`\X{gt}^\ast`,
    with the import's :ref:`external types <syntax-externtype>` :math:`\X{it}^\ast` and the internal :ref:`global types <syntax-globaltype>` :math:`\X{gt}^\ast` as determined below,

  * :math:`C.\CELEM` is :math:`\X{est}^\ast`, with :ref:`segment types <syntax-segtype>` :math:`\X{est}^\ast` as determined below,

  * :math:`C.\CDATA` is :math:`\X{dst}^\ast`, with :ref:`segment types <syntax-segtype>` :math:`\X{dst}^\ast` as determined below,

  * :math:`C.\CLOCALS` is empty,

  * :math:`C.\CLABELS` is empty,

  * :math:`C.\CRETURN` is empty.

* Let :math:`C'` be the :ref:`context <context>` where :math:`C'.\CGLOBALS` is the sequence :math:`\etglobals(\X{it}^\ast)` and all other fields are empty.

* Under the context :math:`C`:

  * For each :math:`\functype_i` in :math:`\module.\MTYPES`,
    the :ref:`function type <syntax-functype>` :math:`\functype_i` must be :ref:`valid <valid-functype>`.

  * For each :math:`\func_i` in :math:`\module.\MFUNCS`,
    the definition :math:`\func_i` must be :ref:`valid <valid-func>` with a :ref:`function type <syntax-functype>` :math:`\X{ft}_i`.

  * For each :math:`\table_i` in :math:`\module.\MTABLES`,
    the definition :math:`\table_i` must be :ref:`valid <valid-table>` with a :ref:`table type <syntax-tabletype>` :math:`\X{tt}_i`.

  * For each :math:`\mem_i` in :math:`\module.\MMEMS`,
    the definition :math:`\mem_i` must be :ref:`valid <valid-mem>` with a :ref:`memory type <syntax-memtype>` :math:`\X{mt}_i`.

  * For each :math:`\global_i` in :math:`\module.\MGLOBALS`:

    * Under the context :math:`C'`,
      the definition :math:`\global_i` must be :ref:`valid <valid-global>` with a :ref:`global type <syntax-globaltype>` :math:`\X{gt}_i`.

  * For each :math:`\elem_i` in :math:`\module.\MELEM`,
    the segment :math:`\elem_i` must be :ref:`valid <valid-elem>` with a :ref:`segment type <syntax-segtype>` :math:`\X{est}_i`.

  * For each :math:`\data_i` in :math:`\module.\MDATA`,
    the segment :math:`\data_i` must be :ref:`valid <valid-data>` with a :ref:`segment type <syntax-segtype>` :math:`\X{dst}_i`.

  * If :math:`\module.\MSTART` is non-empty,
    then :math:`\module.\MSTART` must be :ref:`valid <valid-start>`.

  * For each :math:`\import_i` in :math:`\module.\MIMPORTS`,
    the segment :math:`\import_i` must be :ref:`valid <valid-import>` with an :ref:`external type <syntax-externtype>` :math:`\X{it}_i`.

  * For each :math:`\export_i` in :math:`\module.\MEXPORTS`,
    the segment :math:`\export_i` must be :ref:`valid <valid-export>` with :ref:`external type <syntax-externtype>` :math:`\X{et}_i`.

* The length of :math:`C.\CTABLES` must not be larger than :math:`1`.

* The length of :math:`C.\CMEMS` must not be larger than :math:`1`.

* All export names :math:`\export_i.\ENAME` must be different.

* Let :math:`\X{ft}^\ast` be the concatenation of the internal :ref:`function types <syntax-functype>` :math:`\X{ft}_i`, in index order.

* Let :math:`\X{tt}^\ast` be the concatenation of the internal :ref:`table types <syntax-tabletype>` :math:`\X{tt}_i`, in index order.

* Let :math:`\X{mt}^\ast` be the concatenation of the internal :ref:`memory types <syntax-memtype>` :math:`\X{mt}_i`, in index order.

* Let :math:`\X{gt}^\ast` be the concatenation of the internal :ref:`global types <syntax-globaltype>` :math:`\X{gt}_i`, in index order.

* Let :math:`\X{est}^\ast` be the concatenation of the :ref:`segment types <syntax-segtype>` :math:`\X{est}_i`, in index order.

* Let :math:`\X{dst}^\ast` be the concatenation of the :ref:`segment types <syntax-segtype>` :math:`\X{dst}_i`, in index order.

* Let :math:`\X{it}^\ast` be the concatenation of :ref:`external types <syntax-externtype>` :math:`\X{it}_i` of the imports, in index order.

* Let :math:`\X{et}^\ast` be the concatenation of :ref:`external types <syntax-externtype>` :math:`\X{et}_i` of the exports, in index order.

* Then the module is valid with :ref:`external types <syntax-externtype>` :math:`\X{it}^\ast \to \X{et}^\ast`.

.. math::
   \frac{
     \begin{array}{@{}c@{}}
     (\vdashfunctype \functype \ok)^\ast
     \quad
     (C \vdashfunc \func : \X{ft})^\ast
     \quad
     (C \vdashtable \table : \X{tt})^\ast
     \quad
     (C \vdashmem \mem : \X{mt})^\ast
     \quad
     (C' \vdashglobal \global : \X{gt})^\ast
     \\
     (C \vdashelem \elem : \X{est})^\ast
     \quad
     (C \vdashdata \data : \X{dst})^\ast
     \quad
     (C \vdashstart \start \ok)^?
     \quad
     (C \vdashimport \import : \X{it})^\ast
     \quad
     (C \vdashexport \export : \X{et})^\ast
     \\
     \X{ift}^\ast = \etfuncs(\X{it}^\ast)
     \qquad
     \X{itt}^\ast = \ettables(\X{it}^\ast)
     \qquad
     \X{imt}^\ast = \etmems(\X{it}^\ast)
     \qquad
     \X{igt}^\ast = \etglobals(\X{it}^\ast)
     \\
     C = \{ \CTYPES~\functype^\ast, \CFUNCS~\X{ift}^\ast~\X{ft}^\ast, \CTABLES~\X{itt}^\ast~\X{tt}^\ast, \CMEMS~\X{imt}^\ast~\X{mt}^\ast, \CGLOBALS~\X{igt}^\ast~\X{gt}^\ast, \CELEM~\X{est}^\ast, \CDATA~\X{dst}^\ast \}
     \\
     C' = \{ \CGLOBALS~\X{igt}^\ast \}
     \qquad
     |C.\CTABLES| \leq 1
     \qquad
     |C.\CMEMS| \leq 1
     \qquad
     (\export.\ENAME)^\ast ~\F{disjoint}
     \end{array}
   }{
     \vdashmodule \{
       \begin{array}[t]{@{}l@{}}
         \MTYPES~\functype^\ast,
         \MFUNCS~\func^\ast,
         \MTABLES~\table^\ast,
         \MMEMS~\mem^\ast,
         \MGLOBALS~\global^\ast, \\
         \MELEM~\elem^\ast,
         \MDATA~\data^\ast,
         \MSTART~\start^?,
         \MIMPORTS~\import^\ast,
         \MEXPORTS~\export^\ast \} : \X{it}^\ast \to \X{et}^\ast \\
       \end{array}
   }

.. note::
   Most definitions in a module -- particularly functions -- are mutually recursive.
   Consequently, the definition of the :ref:`context <context>` :math:`C` in this rule is recursive:
   it depends on the outcome of validation of the function, table, memory, and global definitions contained in the module,
   which itself depends on :math:`C`.
   However, this recursion is just a specification device.
   All types needed to construct :math:`C` can easily be determined from a simple pre-pass over the module that does not perform any actual validation.

   Globals, however, are not recursive.
   The effect of defining the limited context :math:`C'` for validating the module's globals is that their initialization expressions can only access imported globals and nothing else.

.. note::
   The restriction on the number of tables and memories may be lifted in future versions of WebAssembly.

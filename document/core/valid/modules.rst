Modules
-------

:ref:`Modules <syntax-module>` are valid when all the components they contain are valid.
To verify this, most definitions are themselves classified with a suitable type.


.. index:: type, type index, defined type, recursive type
   pair: abstract syntax; type
   single: abstract syntax; type
.. _valid-type:
.. _valid-types:

Types
~~~~~

The sequence of :ref:`types <syntax-type>` defined in a module is validated incrementally, yielding a sequence of :ref:`defined types <syntax-deftype>` representing them individually.

$${rule-prose: Type_ok}

$${rule: Type_ok}


$${rule-prose: Types_ok}

$${rule: {Types_ok/*}}


.. index:: function, local, function index, local index, type index, function type, value type, local type, expression, import
   pair: abstract syntax; function
   single: abstract syntax; function
.. _valid-func:

Functions
~~~~~~~~~

Functions ${:func} are classified by :ref:`defined types <syntax-deftype>` that :ref:`expand <aux-expand-deftype>` to :ref:`function types <syntax-functype>` of the form ${comptype: FUNC (t_1* -> t_2*)}.


$${rule-prose: Func_ok}
.. todo::
 below is the official specification

* The :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]` must be a :ref:`function type <syntax-functype>`.

* Let :math:`\TFUNC~[t_1^\ast] \toF [t_2^\ast]` be the :ref:`expansion <aux-expand-deftype>` of the :ref:`defined type <syntax-deftype>` :math:`C.\CTYPES[x]`.

* For each local declared by a :ref:`value type <syntax-valtype>` :math:`t` in :math:`t^\ast`:

  * The local for type :math:`t` must be :ref:`valid <valid-local>` with :ref:`local type <syntax-localtype>` :math:`\localtype_i`.

* Let :math:`\localtype^\ast` be the concatenation of all :math:`\localtype_i`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`,
  but with:

  * |CLOCALS| set to the sequence of :ref:`value types <syntax-valtype>` :math:`(\SET~t_1)^\ast~\localtype^\ast`, concatenating parameters and locals,

  * |CLABELS| set to the singular sequence containing only :ref:`result type <syntax-resulttype>` :math:`[t_2^\ast]`.

  * |CRETURN| set to the :ref:`result type <syntax-resulttype>` :math:`[t_2^\ast]`.

* Under the context :math:`C'`,
  the expression :math:`\expr` must be valid with type :math:`[t_2^\ast]`.

* Then the function definition is valid with type :math:`C.\CTYPES[x]`.

$${rule: Func_ok}


.. index:: local, local type, value type
   pair: validation; local
   single: abstract syntax; local
.. _valid-local:

Locals
~~~~~~

Locals ${:local} are classified with :ref:`local types <syntax-localtype>`.

$${rule-prose: Local_ok}

$${rule: {Local_ok/*}}

.. note::
   For cases where both rules are applicable, the former yields the more permissable type.


.. index:: table, table type, reference type, expression, constant, defaultable
   pair: validation; table
   single: abstract syntax; table
.. _valid-table:

Tables
~~~~~~

Tables ${:table} are classified by :ref:`table types <syntax-tabletype>`.

$${rule-prose: Table_ok}

$${rule: Table_ok}


.. index:: memory, memory type
   pair: validation; memory
   single: abstract syntax; memory
.. _valid-mem:

Memories
~~~~~~~~

Memories ${:mem} are classified by :ref:`memory types <syntax-memtype>`.

$${rule-prose: Mem_ok}

$${rule: Mem_ok}


.. index:: global, global type, expression, constant
   pair: validation; global
   single: abstract syntax; global
.. _valid-global:
.. _valid-globalseq:

Globals
~~~~~~~

Globals ${:global} are classified by :ref:`global types <syntax-globaltype>`.

$${rule-prose: Global_ok}

$${rule: Global_ok}

Sequences of globals are handled incrementally, such that each definition has access to previous definitions.

$${rule-prose: Globals_ok}

$${rule: {Globals_ok/*}}


.. index:: tag, tag type, function type, exception tag
   pair: validation; tag
   single: abstract syntax; tag
.. _valid-tag:

Tags
~~~~

Tags :math:`\tag` are classified by their :ref:`tag types <syntax-tagtype>`,
which are :ref:`defined types <syntax-deftype>` expanding to :ref:`function types <syntax-functype>`.

$${rule-prose: Tag_ok}

$${rule: Tag_ok}


.. index:: element, table, table index, expression, constant, function index
   pair: validation; element
   single: abstract syntax; element
   single: table; element
   single: element; segment
.. _valid-elem:

Element Segments
~~~~~~~~~~~~~~~~

Element segments ${:elem} are classified by their :ref:`element type <syntax-elemtype>`.

$${rule-prose: Elem_ok}

$${rule: Elem_ok}


.. _valid-elemmode:

$${rule-prose:Elemmode_ok}

$${rule: {Elemmode_ok/*}}


.. index:: data, memory, memory index, expression, constant, byte
   pair: validation; data
   single: abstract syntax; data
   single: memory; data
   single: data; segment
.. _valid-data:

Data Segments
~~~~~~~~~~~~~

Data segments ${:data} are classified by the singleton :ref:`data type <syntax-datatype>`, which merely expresses well-formedness.

$${rule-prose: Data_ok}

$${rule: Data_ok}


.. _valid-datamode:

$${rule-prose: Datamode_ok}

$${rule: {Datamode_ok/*}}


.. index:: start function, function index
   pair: validation; start function
   single: abstract syntax; start function
.. _valid-start:

Start Function
~~~~~~~~~~~~~~

$${rule-prose: Start_ok}

$${rule: Start_ok}


.. index:: export, name, index, function index, table index, memory index, global index, tag index
   pair: validation; export
   single: abstract syntax; export
.. _valid-exportdesc:
.. _valid-export:
.. _valid-externidx:

Exports
~~~~~~~

Exports ${:export} are classified by their :ref:`external type <syntax-externtype>`.

$${rule-prose: Export_ok}

$${rule: Export_ok}


:math:`\XDFUNC~x`
.................

$${rule-prose: Externidx_ok/func}

$${rule: Externidx_ok/func}


:math:`\XDTABLE~x`
..................

$${rule-prose: Externidx_ok/table}

$${rule: Externidx_ok/table}


:math:`\XDMEM~x`
................

$${rule-prose: Externidx_ok/mem}

$${rule: Externidx_ok/mem}


:math:`\XDGLOBAL~x`
...................

$${rule-prose: Externidx_ok/global}

$${rule: Externidx_ok/global}



:math:`\XDTAG~x`
................

$${rule-prose: Externidx_ok/tag}

$${rule: Externidx_ok/tag}


.. index:: import, name, function type, table type, memory type, global type, tag type
   pair: validation; import
   single: abstract syntax; import
.. _valid-importdesc:
.. _valid-import:

Imports
~~~~~~~

Imports ${:import} are classified by :ref:`external types <syntax-externtype>`.

$${rule-prose: Import_ok}

$${rule: Import_ok}


.. index:: module, type definition, function type, function, table, memory, global, tag, element, data, start function, import, export, context
   pair: validation; module
   single: abstract syntax; module
.. _valid-module:
.. _syntax-moduletype:

Modules
~~~~~~~

Modules are classified by their mapping from the :ref:`external types <syntax-externtype>` of their :ref:`imports <syntax-import>` to those of their :ref:`exports <syntax-export>`.

A module is entirely *closed*,
that is, its components can only refer to definitions that appear in the module itself.
Consequently, no initial :ref:`context <context>` is required.
Instead, the :ref:`context <context>` ${:C} for validation of the module's content is constructed from the definitions in the module.

$${rule-prose: Module_ok}
.. todo::
 below is the official specification


* Let :math:`\module` be the module to validate.

* The :ref:`types <syntax-type>` :math:`\module.\MTYPES` must be :ref:`valid <valid-type>` yielding a :ref:`context <context>` :math:`C_0`.

* Let :math:`C` be a :ref:`context <context>` where:

  * :math:`C.\CTYPES` is :math:`C_0.\CTYPES`,

  * :math:`C.\CFUNCS` is :math:`\funcsxt(\X{it}^\ast)` concatenated with :math:`\X{dt}^\ast`,
    with the import's :ref:`external types <syntax-externtype>` :math:`\X{it}^\ast` and the internal :ref:`defined types <syntax-deftype>` :math:`\X{dt}^\ast` as determined below,

  * :math:`C.\CTABLES` is :math:`\tablesxt(\X{it}^\ast)` concatenated with :math:`\X{tt}^\ast`,
    with the import's :ref:`external types <syntax-externtype>` :math:`\X{it}^\ast` and the internal :ref:`table types <syntax-tabletype>` :math:`\X{tt}^\ast` as determined below,

  * :math:`C.\CMEMS` is :math:`\memsxt(\X{it}^\ast)` concatenated with :math:`\X{mt}^\ast`,
    with the import's :ref:`external types <syntax-externtype>` :math:`\X{it}^\ast` and the internal :ref:`memory types <syntax-memtype>` :math:`\X{mt}^\ast` as determined below,

  * :math:`C.\CGLOBALS` is :math:`\globalsxt(\X{it}^\ast)` concatenated with :math:`\X{gt}^\ast`,
    with the import's :ref:`external types <syntax-externtype>` :math:`\X{it}^\ast` and the internal :ref:`global types <syntax-globaltype>` :math:`\X{gt}^\ast` as determined below,

  * :math:`C.\CTAGS` is :math:`\tagsxt(\X{it}^\ast)` concatenated with :math:`\X{ht}^\ast`,
    with the import's :ref:`external types <syntax-externtype>` :math:`\X{it}^\ast` and the internal :ref:`tag types <syntax-tagtype>` :math:`\X{ht}^\ast` as determined below,

  * :math:`C.\CELEMS` is :math:`{\X{rt}}^\ast` as determined below,

  * :math:`C.\CDATAS` is :math:`{\X{ok}}^\ast` as determined below,

  * :math:`C.\CLOCALS` is empty,

  * :math:`C.\CLABELS` is empty,

  * :math:`C.\CRETURN` is empty.

  * :math:`C.\CREFS` is the set :math:`\freefuncidx(\module \with \MFUNCS = \epsilon \with \MSTART = \epsilon)`, i.e., the set of :ref:`function indices <syntax-funcidx>` occurring in the module, except in its :ref:`functions <syntax-func>` or :ref:`start function <syntax-start>`.

* Let :math:`C'` be the :ref:`context <context>` where:

  * :math:`C'.\CGLOBALS` is the sequence :math:`\globalsxt(\X{it}^\ast)`,

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
    the segment :math:`\data_i` must be :ref:`valid <valid-data>` with :ref:`data type <syntax-datatype>` :math:`\X{ok}_i`.

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

* Let :math:`\X{ok}^\ast` be the concatenation of the :ref:`data types <syntax-datatype>` :math:`\X{ok}_i`, in index order.

* Let :math:`\X{it}^\ast` be the concatenation of :ref:`external types <syntax-externtype>` :math:`\X{it}_i` of the imports, in index order.

* Let :math:`\X{et}^\ast` be the concatenation of :ref:`external types <syntax-externtype>` :math:`\X{et}_i` of the exports, in index order.

* All export names :math:`\export_i.\XNAME` must be different.

* Then the module is valid with :ref:`external types <syntax-externtype>` :math:`\X{it}^\ast \to \X{et}^\ast`.

$${rule: Module_ok}

.. todo:: Check refs; check export names

.. note::
   All functions in a module are mutually recursive.
   Consequently, the definition of the :ref:`context <context>` ${:C} in this rule is recursive:
   it depends on the outcome of validation of the function, table, memory, and global definitions contained in the module,
   which itself depends on ${:C}.
   However, this recursion is just a specification device.
   All types needed to construct ${:C} can easily be determined from a simple pre-pass over the module that does not perform any actual validation.

   Globals, however, are not recursive but evaluated sequentially, such that each :ref:`constant expressions <valid-const>` only has access to imported or previously defined globals.

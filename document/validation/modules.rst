.. _valid-module:
.. index:: modules, type definition, function type, function, table, memory, global, element, data, start function, import, export, context
   pair: validation; module
   single: abstract syntax; module

Modules
-------

Modules are valid when all the definitions they contain are valid.
To that end, each definition is classified with a suitable type.

A module is entirely *closed*,
that is, it only refers to definitions that appear in the module itself.
Consequently, no initial :ref:`context <context>` is required.
Instead, the context :math:`C` for validation of the module's content is constructed from the types of definitions in the module itself.

* Let :math:`\module` be the module to validate.

* Let :math:`C` be a :ref:`context <context>` where:

  * :math:`C.\TYPES` is :math:`\module.\TYPES`,

  * :math:`C.\FUNCS` is :math:`\funcs(\externtype_i^\ast)` concatenated with :math:`\functype_i^\ast`,
    with the type sequences :math:`\externtype_i^\ast` and :math:`\functype_i^\ast` as determined below,

  * :math:`C.\TABLES` is :math:`\tables(\externtype_i^\ast)` concatenated with :math:`\tabletype_i^\ast`,
    with the type sequences :math:`\externtype_i^\ast` and :math:`\tabletype_i^\ast` as determined below,

  * :math:`C.\MEMS` is :math:`\mems(\externtype_i^\ast)` concatenated with :math:`\memtype_i^\ast`,
    with the type sequences :math:`\externtype_i^\ast` and :math:`\memtype_i^\ast` as determined below,

  * :math:`C.\GLOBALS` is :math:`\globals(\externtype_i^\ast)` concatenated with :math:`\globaltype_i^\ast`,
    with the type sequences :math:`\externtype_i^\ast` and :math:`\globaltype_i^\ast` as determined below.

  * :math:`C.\LOCALS` is empty,

  * :math:`C.\LABELS` is empty.

* Under the context :math:`C`:

  * For each :math:`\func_i` in :math:`\module.\FUNCS`,
    the definition :math:`\func_i` must be :ref:`valid <valid-func>` with a :ref:`function type <syntax-functype>` :math:`\functype_i`.

  * For each :math:`\table_i` in :math:`\module.\TABLES`,
    the definition :math:`\table_i` must be :ref:`valid <valid-table>` with a :ref:`table type <syntax-tabletype>` :math:`\tabletype_i`.

  * For each :math:`\mem_i` in :math:`\module.\MEMS`,
    the definition :math:`\mem_i` must be :ref:`valid <valid-mem>` with a :ref:`memory type <syntax-memtype>` :math:`\memtype_i`.

  * For each :math:`\global_i` in :math:`\module.\GLOBALS`:

    * Let :math:`C_i` be the :ref:`context <context>` where :math:`C_i.\GLOBALS` is the sequence :math:`\globals(\externtype_i^\ast)` concatenated with :math:`\globaltype_0~\dots~\globaltype_{i-1}`, and all other fields are empty.

    * Under the context :math:`C_i`,
      the definition :math:`\global_i` must be :ref:`valid <valid-global>` with a :ref:`global type <syntax-globaltype>` :math:`\globaltype_i`.

  * For each :math:`\elem_i` in :math:`\module.\ELEM`,
    the segment :math:`\elem_i` must be :ref:`valid <valid-elem>`.

  * For each :math:`\data_i` in :math:`\module.\DATA`,
    the segment :math:`\elem_i` must be :ref:`valid <valid-data>`.

  * If :math:`\module.\START` is non-empty,
    then :math:`\module.\START` must be :ref:`valid <valid-start>`.

  * For each :math:`\import_i` in :math:`\module.\IMPORTS`,
    the segment :math:`\import_i` must be :ref:`valid <valid-import>` with an :ref:`external type <syntax-externtype>` :math:`\externtype_i`.

  * For each :math:`\export_i` in :math:`\module.\EXPORTS`,
    the segment :math:`\import_i` must be :ref:`valid <valid-export>` with a :ref:`name <syntax-name>` :math:`\name_i`.

* The length of :math:`C.\TABLES` must not be larger than :math:`1`.

* The length of :math:`C.\MEMS` must not be larger than :math:`1`.

* All export names :math:`\name_i` must be different.

.. math::
   \frac{
     \begin{array}{@{}c@{}}
     (C \vdash \func : \X{ft})^\ast
     \quad
     (C \vdash \table : \X{tt})^\ast
     \quad
     (C \vdash \mem : \X{mt})^\ast
     \quad
     (C_i \vdash \global : \X{gt})_i^\ast
     \\
     (C \vdash \elem ~\F{ok})^\ast
     \quad
     (C \vdash \data ~\F{ok})^\ast
     \quad
     (C \vdash \start ~\F{ok})^?
     \quad
     (C \vdash \import : \X{it})^\ast
     \quad
     (C \vdash \export : \X{name})^\ast
     \\
     \X{ift}^\ast = \funcs(\X{it}^\ast)
     \qquad
     \X{itt}^\ast = \tables(\X{it}^\ast)
     \qquad
     \X{imt}^\ast = \mems(\X{it}^\ast)
     \qquad
     \X{igt}^\ast = \globals(\X{it}^\ast)
     \\
     C = \{ \TYPES~\functype^\ast, \FUNCS~\X{ift}^\ast~\X{ft}^\ast, \TABLES~\X{itt}^\ast~\X{tt}^\ast, \MEMS~\X{imt}^\ast~\X{mt}^\ast, \GLOBALS~\X{igt}^\ast~\X{gt}^\ast \}
     \\
     |C.\TABLES| \leq 1
     \qquad
     |C.\MEMS| \leq 1
     \qquad
     \name^\ast ~\F{disjoint}
     \qquad
     (C_i = \{ \GLOBALS~[\X{igt}^\ast~\X{gt}^{i-1}] \})_i^\ast
     \end{array}
   }{
     \vdash \{
       \begin{array}[t]{@{}l@{}}
         \TYPES~\functype^\ast,
         \FUNCS~\func^\ast,
         \TABLES~\table^\ast,
         \MEMS~\mem^\ast,
         \GLOBALS~\global^\ast, \\
         \ELEM~\elem^\ast,
         \DATA~\data^\ast,
         \START~\start^?,
         \IMPORTS~\import^\ast,
         \EXPORTS~\export^\ast \} ~\F{ok} \\
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
   The effect of defining the limited contexts :math:`C_i` for validating the module's globals is that their initialization expressions can only access imported and previously defined globals and nothing else.

.. note::
   The restriction on the number of tables and memories may be lifted in future versions of WebAssembly.


Auxiliary Rules
~~~~~~~~~~~~~~~

.. _valid-limits:

Limits :math:`\{ \MIN~n, \MAX~m^? \}`
.....................................

* If the maximum :math:`m^?` is not empty, then its value must not be smaller than :math:`n`.

* Then the limit is valid.

.. math::
   \frac{
     (n \leq m)^?
   }{
     \vdash \{ \MIN~n, \MAX~m^? \} ~\F{ok}
   }


.. _valid-expr:
.. index:: expression
   pair: validation; expression
   single: abstract syntax; expression
   single: expression; constant

Expressions
~~~~~~~~~~~

Expressions :math:`\expr` are classified by :ref:`result types <syntax-resulttype>` of the form :math:`t^?`.


:math:`\instr^\ast~\END`
........................

* The :ref:`instruction sequence <syntax-instr-seq>` must be :ref:`valid <valid-instr-seq>` with type :math:`[] \to [t^?]`,
  for some optional :ref:`value type <syntax-valtype>` :math:`t^?`.

* Then the expression is valid with :ref:`result type <syntax-resulttype>` :math:`t^?`.

.. math::
   \frac{
     C \vdash \instr^\ast : [] \to [t^?]
   }{
     C \vdash \instr^\ast~\END : t^?
   }


.. _valid-const:
.. index:: ! constant

Constant Expressions
....................

* In a *constant* expression :math:`\instr^\ast~\END` all instructions in :math:`\instr^\ast` must be constant.

* A constant instruction :math:`\instr` must be:

  * either of the form :math:`t.\CONST~c`,

  * or of the form :math:`\GETGLOBAL~x`, in which case :math:`C.\GLOBALS[x]` must be a :ref:`global type <syntax-globaltype>` of the form :math:`\CONST~t`.

.. math::
   \frac{
     (C \vdash \instr ~\F{const})^\ast
   }{
     C \vdash \instr~\END ~\F{const}
   }
   \qquad
   \frac{
   }{
     C \vdash t.\CONST~c ~\F{const}
   }
   \qquad
   \frac{
     C.\GLOBALS[x] = \CONST~t
   }{
     C \vdash \GETGLOBAL~x ~\F{const}
   }

.. note::
   The definition of constant expression may be extended in future versions of WebAssembly.


.. _valid-func:
.. index:: function, local, function index, local index, type index, function type, value type, expression, import
   pair: abstract syntax; function

Functions
~~~~~~~~~

Functions :math:`\func` are classified by :ref:`function types <syntax-functype>` of the form :math:`[t_1^\ast] \to [t_2^?]`.


:math:`\{ \TYPE~x, \LOCALS~t^\ast, \BODY~\expr \}`
....................................................

* The type :math:`C.\TYPES[x]` must be defined in the context.

* Let :math:`[t_1^\ast] \to [t_2^\ast]` be the :ref:`function type <syntax-functype>` :math:`C.\TYPES[x]`.

* The length of :math:`t_2^\ast` must not be larger than :math:`1`.

* Let :math:`C'` be the same :ref:`context <context>` as :math:`C`,
  but with:

  * the |LOCALS| set to the sequence of :ref:`value types <syntax-valtype>` :math:`t_1^\ast~t^\ast`, concatenating parameters and locals,

  * the |LABELS| set to the singular sequence with :ref:`result type <syntax-valtype>` :math:`(t_2^\ast)`.

* Under the context :math:`C'`,
  the expression :math:`\expr` must be valid with type :math:`t_2^\ast`.

* Then the function definition is valid with type :math:`[t_1^\ast] \to [t_2^\ast]`.

.. math::
   \frac{
     C.\TYPES[x] = [t_1^\ast] \to [t_2^?]
     \qquad
     C,\LOCALS\,t_1^\ast~t^\ast,\LABELS~(t_2^?) \vdash \expr : t_2^?
   }{
     C \vdash \{ \TYPE~x, \LOCALS~t^\ast, \BODY~\expr \} : t_2^?
   }

.. note::
   The restriction on the length of the result types :math:`t_2^\ast` may be lifted in future versions of WebAssembly.


.. _valid-table:
.. index:: table, table type, limits, element type
   pair: validation; table
   single: abstract syntax; table

Tables
~~~~~~

Tables :math:`\table` are classified by :ref:`table types <syntax-tabletype>` of the form :math:`\limits~\elemtype`.


:math:`\{ \TYPE~\limits~\elemtype \}`
.....................................

* The limits :math:`\limits` must be :ref:`valid <valid-limits>`.

* Then the table definition is valid with type :math:`\limits~\elemtype`.

.. math::
   \frac{
     \vdash \limits~\F{ok}
   }{
     C \vdash \{ \TYPE~\limits~\elemtype \} : \limits~\elemtype
   }


.. _valid-mem:
.. index:: memory, memory type, limits
   pair: validation; memory
   single: abstract syntax; memory

Memories
~~~~~~~~

Memories :math:`\mem` are classified by :ref:`memory types <syntax-memtype>` of the form :math:`\limits`.


:math:`\{ \TYPE~\limits \}`
...........................

* The limits :math:`\limits` must be :ref:`valid <valid-limits>`.

* Then the memory definition is valid with type :math:`\limits`.

.. math::
   \frac{
     \vdash \limits~\F{ok}
   }{
     C \vdash \{ \TYPE~\limits \} : \limits~\elemtype
   }


.. _valid-global:
.. index:: global, global type, mutability, expression
   pair: validation; global
   single: abstract syntax; global

Globals
~~~~~~~

Globals :math:`\global` are classified by :ref:`global types <syntax-globaltype>` of the form :math:`\mut~t`.


:math:`\{ \TYPE~\mut~t, \INIT~\expr \}`
.......................................

* The expression :math:`\expr` must be :ref:`valid <valid-expr>` with :ref:`result type <syntax-resulttype>` :math:`t`.

* The expression :math:`\expr` must be :ref:`constant <constant>`.

* Then the global definition is valid with type :math:`\mut~t`.

.. math::
   \frac{
     C \vdash \expr : t
     \qquad
     C \vdash \expr ~\F{const}
   }{
     C \vdash \{ \TYPE~\mut~t, \INIT~\expr \} : \mut~t
   }


.. _valid-elem:
.. index:: element, table, table index, expression, function index
   pair: validation; element
   single: abstract syntax; element
   single: table; element
   single: element; segment

Element Segments
~~~~~~~~~~~~~~~~

Element segments :math:`\elem` are not classified by a type.

:math:`\{ \TABLE~x, \OFFSET~\expr, \INIT~y^\ast \}`
...................................................

* The table :math:`C.\TABLES[x]` must be defined in the context.

* Let :math:`\limits~\elemtype` be the :ref:`table type <syntax-tabletype>` :math:`C.\TABLES[x]`.

* The :ref:`element type <syntax-elemtype>` :math:`\elemtype` must be |ANYFUNC|.

* The expression :math:`\expr` must be :ref:`valid <valid-expr>` with :ref:`result type <syntax-resulttype>` |I32|.

* The expression :math:`\expr` must be :ref:`constant <constant>`.

* For each :math:`y_i` in :math:`y^\ast`,
  the function :math:`C.\FUNCS[y]` must be defined in the context.

* Then the element segment is valid.


.. math::
   \frac{
     C.\TABLES[x] = \limits~\ANYFUNC
     \qquad
     C \vdash \expr : \I32
     \qquad
     C \vdash \expr ~\F{const}
     \qquad
     (C.\FUNCS[y] = \functype)^\ast
   }{
     C \vdash \{ \TABLE~x, \OFFSET~\expr, \INIT~y^\ast \} ~\F{ok}
   }


.. _valid-data:
.. index:: data, memory, memory index, expression, byte
   pair: validation; data
   single: abstract syntax; data
   single: memory; data
   single: data; segment

Data Segments
~~~~~~~~~~~~~

Data segments :math:`\data` are not classified by any type.

:math:`\{ \MEM~x, \OFFSET~\expr, \INIT~b^\ast \}`
.................................................

* The memory :math:`C.\MEMS[x]` must be defined in the context.

* The expression :math:`\expr` must be :ref:`valid <valid-expr>` with :ref:`result type <syntax-resulttype>` |I32|.

* The expression :math:`\expr` must be :ref:`constant <constant>`.

* Then the data segment is valid.


.. math::
   \frac{
     C.\MEMS[x] = \limits
     \qquad
     C \vdash \expr : \I32
     \qquad
     C \vdash \expr ~\F{const}
   }{
     C \vdash \{ \MEM~x, \OFFSET~\expr, \INIT~b^\ast \} ~\F{ok}
   }


.. _valid-start:
.. index:: start function, function index
   pair: validation; start function
   single: abstract syntax; start function

Start Function
~~~~~~~~~~~~~~

Start function declarations :math:`\start` are not classified by any type.

:math:`\{ \FUNC~x \}`
.....................

* The function :math:`C.\FUNCS[x]` must be defined in the context.

* The type of :math:`C.\FUNCS[x]` must be :math:`[] \to []`.

* Then the start function is valid.


.. math::
   \frac{
     C.\FUNCS[x] = [] \to []
   }{
     C \vdash \{ \FUNC~x \} ~\F{ok}
   }


.. _valid-export:
.. index:: export, name, index, function index, table index, memory index, global index
   validation: abstract syntax; export
   single: abstract syntax; export

Exports
~~~~~~~

Exports :math:`\export` are classified by their export :ref:`name <syntax-name>`.
Export descriptions :math:`\exportdesc` are not classified by any type.


:math:`\{ \NAME~\name, \DESC~\exportdesc \}`
............................................

* The export description :math:`\exportdesc` must be valid with type :math:`\externtype`.

* Then the export is valid with name :math:`\name`.

.. math::
   \frac{
     C \vdash \exportdesc ~\F{ok}
   }{
     C \vdash \{ \NAME~\name, \DESC~\exportdesc \} : \name
   }


:math:`\FUNC~x`
...............

* The function :math:`C.\FUNCS[x]` must be defined in the context.

* Then the export description is valid.

.. math::
   \frac{
     C.\FUNCS[x] = \functype
   }{
     C \vdash \FUNC~x ~\F{ok}
   }


:math:`\TABLE~x`
................

* The table :math:`C.\TABLES[x]` must be defined in the context.

* Then the export description is valid.

.. math::
   \frac{
     C.\TABLES[x] = \tabletype
   }{
     C \vdash \TABLE~x ~\F{ok}
   }


:math:`\MEM~x`
..............

* The memory :math:`C.\MEMS[x]` must be defined in the context.

* Then the export description is valid.

.. math::
   \frac{
     C.\MEMS[x] = \memtype
   }{
     C \vdash \MEM~x ~\F{ok}
   }


:math:`\GLOBAL~x`
.................

* The global :math:`C.\GLOBALS[x]` must be defined in the context.

* Let :math:`\mut~t` be the :ref:`global type <syntax-globaltype>` :math:`C.\GLOBALS[x]`.

* The mutability :math:`\mut` must be |CONST|.

* Then the export description is valid.

.. math::
   \frac{
     C.\GLOBALS[x] = \CONST~t
   }{
     C \vdash \GLOBAL~x ~\F{ok}
   }


.. _valid-import:
.. index:: import, name, function type, table type, memory type, global type
   pair: validation; import
   single: abstract syntax; import

Imports
~~~~~~~

Imports :math:`\import` and import descriptions :math:`\importdesc` are classified by :ref:`external types <syntax-externtype>`.


:math:`\{ \MODULE~\name_1, \NAME~\name_2, \DESC~\importdesc \}`
...............................................................

* The import description :math:`\importdesc` must be valid with type :math:`\externtype`.

* Then the import is valid with type :math:`\externtype`.

.. math::
   \frac{
     C \vdash \importdesc : \externtype
   }{
     C \vdash \{ \MODULE~\name_1, \NAME~\name_2, \DESC~\importdesc \} : \externtype
   }


:math:`\FUNC~x`
...............

* The function :math:`C.\TYPES[x]` must be defined in the context.

* Let :math:`[t_1^\ast] \to [t_2^\ast]` be the :ref:`function type <syntax-functype>` :math:`C.\TYPES[x]`.

* The length of :math:`t_2^\ast` must not be larger than :math:`1`.

* Then the import description is valid with type :math:`\FUNC~[t_1^\ast] \to [t_2^\ast]`.

.. math::
   \frac{
     C.\TYPES[x] = [t_1^\ast] \to [t_2^?]
   }{
     C \vdash \FUNC~x : \FUNC~[t_1^\ast] \to [t_2^?]
   }

.. note::
   The restriction on the length of the result types :math:`t_2^\ast` may be lifted in future versions of WebAssembly.


:math:`\TABLE~\limits~\elemtype`
................................

* The limits :math:`\limits` must be valid.

* Then the import description is valid with type :math:`\TABLE~\limits~\elemtype`.

.. math::
   \frac{
     \vdash \limits ~\F{ok}
   }{
     C \vdash \TABLE~\limits~\elemtype : \TABLE~\limits~\elemtype
   }


:math:`\MEM~\limits`
....................

* The limits :math:`\limits` must be valid.

* Then the import description is valid with type :math:`\MEM~\limits`.

.. math::
   \frac{
     \vdash \limits ~\F{ok}
   }{
     C \vdash \MEM~\limits : \MEM~\limits
   }


:math:`\GLOBAL~\mut~t`
......................

* The mutability :math:`\mut` must be |CONST|.

* Then the import description is valid with type :math:`\GLOBAL~t`.

.. math::
   \frac{
   }{
     C \vdash \GLOBAL~t : \GLOBAL~t
   }

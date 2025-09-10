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


.. index:: memory, memory type
   pair: validation; memory
   single: abstract syntax; memory
.. _valid-mem:

Memories
~~~~~~~~

Memories ${:mem} are classified by :ref:`memory types <syntax-memtype>`.

$${rule-prose: Mem_ok}

$${rule: Mem_ok}


.. index:: table, table type, reference type, expression, constant, defaultable
   pair: validation; table
   single: abstract syntax; table
.. _valid-table:

Tables
~~~~~~

Tables ${:table} are classified by :ref:`table types <syntax-tabletype>`.

$${rule-prose: Table_ok}

$${rule: Table_ok}


.. index:: function, local, function index, local index, type index, function type, value type, local type, expression, import
   pair: abstract syntax; function
   single: abstract syntax; function
.. _valid-func:

Functions
~~~~~~~~~

Functions ${:func} are classified by :ref:`defined types <syntax-deftype>` that :ref:`expand <aux-expand-deftype>` to :ref:`function types <syntax-functype>` of the form ${comptype: FUNC t_1* -> t_2*}.

$${rule-prose: Func_ok}

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

$${rule: {Elemmode_ok/passive Elemmode_ok/declare} {Elemmode_ok/active}}


.. index:: start function, function index
   pair: validation; start function
   single: abstract syntax; start function
.. _valid-start:

Start Function
~~~~~~~~~~~~~~

$${rule-prose: Start_ok}

$${rule: Start_ok}


.. index:: import, name, tag type, global type, memory type, table type, function type
   pair: validation; import
   single: abstract syntax; import
.. _valid-importdesc:
.. _valid-import:

Imports
~~~~~~~

Imports ${:import} are classified by :ref:`external types <syntax-externtype>`.

$${rule-prose: Import_ok}

$${rule: Import_ok}


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


:math:`\XXTAG~x`
................

$${rule-prose: Externidx_ok/tag}

$${rule: Externidx_ok/tag}


:math:`\XXGLOBAL~x`
...................

$${rule-prose: Externidx_ok/global}

$${rule: Externidx_ok/global}


:math:`\XXMEM~x`
................

$${rule-prose: Externidx_ok/mem}

$${rule: Externidx_ok/mem}


:math:`\XXTABLE~x`
..................

$${rule-prose: Externidx_ok/table}

$${rule: Externidx_ok/table}


:math:`\XXFUNC~x`
.................

$${rule-prose: Externidx_ok/func}

$${rule: Externidx_ok/func}


.. index:: module, type definition, recursive type, tag, global, memory, table, function, data segment, element segment, start function, import, export, context
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

$${rule: Module_ok}

.. note::
   All functions in a module are mutually recursive.
   Consequently, the definition of the :ref:`context <context>` ${:C} in this rule is recursive:
   it depends on the outcome of validation of the function, table, memory, and global definitions contained in the module,
   which itself depends on ${:C}.
   However, this recursion is just a specification device.
   All types needed to construct ${:C} can easily be determined from a simple pre-pass over the module that does not perform any actual validation.

   Globals, however, are not recursive but evaluated sequentially, such that each :ref:`constant expressions <valid-const>` only has access to imported or previously defined globals.

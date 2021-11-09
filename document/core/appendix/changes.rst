.. index:: ! changes
.. _changes:

Change History
--------------

Since the original release 1.0 of the WebAssembly specification, a number of proposals for extensions have been integrated.
The following sections provide an overview of what has changed.

Release 1.1
~~~~~~~~~~~

.. index:: instruction, integer

Sign extension instructions
...........................

Added new numeric instructions for performing sign extension within integer representations [#proposal-signext]_.

* New :ref:`numeric instructions <syntax-instr-numeric>`: :math:`\K{i}\X{nn}\K{.}\EXTEND\X{N}\K{\_s}`


.. index:: instruction, trap, floating-point, integer

Non-trapping float-to-int conversions
.....................................

Added new conversion instructions that avoid trapping when converting a floating-point number to an integer [#proposal-cvtsat]_.

* New :ref:`numeric instructions <syntax-instr-numeric>`: :math:`\K{i}\X{nn}\K{.}\TRUNC\K{\_sat\_f}\X{mm}\K{\_}\sx`


.. index:: block, function, value type, result type

Multiple values
...............

Generalized the result type of blocks and functions to allow for multiple values; in addition, introduced the ability to have block parameters [#proposal-multivalue]_.

* :ref:`Function types <syntax-functype>` allow more than one result

* :ref:`Block types <syntax-blocktype>` can be arbitrary function types


.. index:: value type, reference, reference type, instruction, element segment

Reference types
...............

Added |FUNCREF| and |EXTERNREF| as new value types and respective instructions [#proposal-reftype]_.

* New :ref:`value types <syntax-valtype>`: :ref:`reference types <syntax-reftype>` |FUNCREF| and |EXTERNREF|

* New :ref:`reference instructions <syntax-instr-ref>`: |REFNULL|, |REFFUNC|, |REFISNULL|

* Enrich :ref:`parametric instruction <syntax-instr-parametric>`: |SELECT| with optional type immediate

* New :ref:`declarative <syntax-elemmode>` form of :ref:`element segment <syntax-elem>`


.. index:: reference, instruction, table, table type

Table instructions
..................

Added instructions to directly access and modify tables [#proposal-reftype]_.

* :ref:`Table types <syntax-tabletype>` allow any :ref:`reference type <syntax-reftype>` as element type

* New :ref:`table instructions <syntax-instr-table>`: |TABLEGET|, |TABLESET|, |TABLESIZE|, |TABLEGROW|


.. index:: table, instruction, table index, element segment

Multiple tables
...............

Added the ability to use multiple tables per module [#proposal-reftype]_.

* :ref:`Modules <syntax-module>` may :ref:`define <syntax-table>`, :ref:`import <syntax-import>`, and :ref:`export <syntax-export>` multiple tables

* :ref:`Table instructions <syntax-instr-table>` take a :ref:`table index <syntax-tableidx>` immediate: |TABLEGET|, |TABLESET|, |TABLESIZE|, |TABLEGROW|, |CALLINDIRECT|

* :ref:`Element segments <syntax-elem>` take a :ref:`table index <syntax-tableidx>`


.. index:: instruction, table, memory, data segment, element segment

Bulk memory and table instructions
..................................

Added instructions that modify ranges of memory or table entries [#proposal-reftype]_ [#proposal-bulk]_

* New :ref:`memory instructions <syntax-instr-memory>`: |MEMORYFILL|, |MEMORYINIT|, |MEMORYCOPY|, |DATADROP|

* New :ref:`table instructions <syntax-instr-table>`: |TABLEFILL|, |TABLEINIT|, |TABLECOPY|, |ELEMDROP|

* New :ref:`passive <syntax-datamode>` form of :ref:`data segment <syntax-data>`

* New :ref:`passive <syntax-elemmode>` form of :ref:`element segment <syntax-elem>`

* New :ref:`data count section <binary-datacountsec>` in binary format

* Active data and element segments boundaries are no longer checked at compile time but may trap instead


.. [#proposal-signext]
   https://github.com/WebAssembly/spec/tree/main/proposals/sign-extension-ops/

.. [#proposal-cvtsat]
   https://github.com/WebAssembly/spec/tree/main/proposals/nontrapping-float-to-int-conversion/

.. [#proposal-multivalue]
   https://github.com/WebAssembly/spec/tree/main/proposals/multi-value/

.. [#proposal-reftype]
   https://github.com/WebAssembly/spec/tree/main/proposals/reference-types/

.. [#proposal-bulk]
   https://github.com/WebAssembly/spec/tree/main/proposals/bulk-memory-operations/

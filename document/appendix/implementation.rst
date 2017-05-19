.. _impl:
.. index:: ! implementation limitations, implementation

Implementation Limitations
--------------------------

Implementations typically impose additional restrictions on a number of aspects of a WebAssembly module or execution.
These may stem from:

* physical resource limits,
* constraints imposed by the embedder or its environment,
* limitations of selected implementation strategies.

This section lists allowed limitations.
Where restrictions take the form of numeric limits, no minimum requirements are given,
nor are the limits assumed to be concrete, fixed numbers.
However, it is expected that all implementations have "reasonably" large limits  to enable common applications.

.. note::
   A conforming implementation is not allowed to leave out individual *features*.
   However, designated subsets of WebAssembly may be specified in the future.


Syntactic Limits
~~~~~~~~~~~~~~~~

.. _impl-syntax:
.. index:: abstract syntax, module, type, function, table, memory, global, element, data, import, export, parameter, result, local, structured control instruction, instruction, name, Unicode, code point

Structure
.........

An implementation may impose restrictions on the following dimensions of a module:

* the number of :ref:`types <syntax-type>` in a :ref:`module <syntax-module>`
* the number of :ref:`functions <syntax-func>` in a :ref:`module <syntax-module>`, including imports
* the number of :ref:`tables <syntax-table>` in a :ref:`module <syntax-module>`, including imports
* the number of :ref:`memories <syntax-mem>` in a :ref:`module <syntax-module>`, including imports
* the number of :ref:`globals <syntax-global>` in a :ref:`module <syntax-module>`, including imports
* the number of :ref:`element segments <syntax-elem>` in a :ref:`module <syntax-module>`
* the number of :ref:`data segments <syntax-data>` in a :ref:`module <syntax-module>`
* the number of :ref:`imports <syntax-import>` to a :ref:`module <syntax-module>`
* the number of :ref:`exports <syntax-export>` form a :ref:`module <syntax-module>`
* the number of parameters in a :ref:`function type <syntax-functype>`
* the number of results in a :ref:`function type <syntax-functype>`
* the number of :ref:`locals <syntax-local>` in a :ref:`function <syntax-func>`
* the size of a :ref:`function <syntax-func>` body
* the size of a :ref:`structured control instruction <syntax-instr-control>`
* the number of :ref:`structured control instructions <syntax-instr-control>` in a :ref:`function <syntax-func>`
* the nesting depth of :ref:`structured control instructions <syntax-instr-control>`
* the length of an :ref:`element segment <syntax-elem>`
* the length of a :ref:`data segment <syntax-data>`
* the length of a :ref:`name <syntax-name>`
* the range of :ref:`code points <syntax-codepoint>` in a :ref:`name <syntax-name>`


.. _impl-binary:
.. index:: binary format, module, section, function, code

Binary Format
.............

For a module given in :ref:`binary format <binary>`, additional limitations may be imposed on the following dimensions:

* the size of a :ref:`module <binary-module>`
* the size of any :ref:`section <binary-section>`
* the size of an individual :ref:`function's code <binary-func>`
* the number of :ref:`sections <binary-section>`


.. _impl-text:
.. index:: text format, source text, token, identifier, character, unicode

Text Format
...........

For a module given in :ref:`text format <text>`, additional limitations may be imposed on the following dimensions:

* the size of the :ref:`source text <source>`
* the size of any syntactic element
* the size of an individual :ref:`token <text-token>`
* the nesting depth of :ref:`folded instructions <text-foldedinstr>`
* the length of symbolic :ref:`identifiers <text-id>`
* the range of literal :ref:`characters <text-char>` (code points) allowed in the :ref:`source text <source>`


.. _impl-valid:
.. index:: validation, function

Validation
~~~~~~~~~~

An implementation may defer :ref:`validation <valid>` of individual :ref:`functions <syntax-func>` until they are first :ref:`invoked <exec-invoke>`.
If a function turns out to be invalid, the invocation, and every consecutive call to the same function, results in a :ref:`trap <trap>`.

.. note::
   This is to allow implementations to use interpretation or just-in-time compilation for functions.
   The function must still be fully validated before execution of its body begins.


.. _impl-exec:
.. index:: execution, module instance, function instance, table instance, memory instance, global instance, allocation, frame, label, value

Execution
~~~~~~~~~

Restrictions on the following dimensions may be imposed during :ref:`execution <exec>` of a WebAssembly program:

* the number of allocated :ref:`module instances <syntax-moduleinst>`
* the number of allocated :ref:`function instances <syntax-funcinst>`
* the number of allocated :ref:`table instances <syntax-tableinst>`
* the number of allocated :ref:`memory instances <syntax-meminst>`
* the number of allocated :ref:`global instances <syntax-globalinst>`
* the size of a :ref:`table instance <syntax-tableinst>`
* the size of a :ref:`memory instance <syntax-meminst>`
* the number of :ref:`frames <syntax-frame>` on the :ref:`stack <syntax-stack>`
* the number of :ref:`labels <syntax-label>` on the :ref:`stack <syntax-stack>`
* the number of :ref:`values <syntax-val>` on the :ref:`stack <syntax-stack>`

.. note::
   Concrete limits are usually not fixed but may be dependent on specifics, interdependent, vary over time, or depend on other implementation- or embedder-specific variables.

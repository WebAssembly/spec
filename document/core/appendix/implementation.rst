.. index:: ! implementation limitations, implementation
.. _impl:

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

.. index:: abstract syntax, module, type, function, table, memory, global, element, data, import, export, parameter, result, local, structured control instruction, instruction, name, Unicode, character
.. _impl-syntax:

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
* the number of :ref:`exports <syntax-export>` from a :ref:`module <syntax-module>`
* the number of :ref:`sub types <syntax-subtype>` in a :ref:`recursive type <syntax-rectype>`
* the subtyping depth of a :ref:`sub type <syntax-subtype>`
* the number of fields in a :ref:`structure type <syntax-structtype>`
* the number of parameters in a :ref:`function type <syntax-functype>`
* the number of results in a :ref:`function type <syntax-functype>`
* the number of parameters in a :ref:`block type <syntax-blocktype>`
* the number of results in a :ref:`block type <syntax-blocktype>`
* the number of :ref:`locals <syntax-local>` in a :ref:`function <syntax-func>`
* the size of a :ref:`function <syntax-func>` body
* the size of a :ref:`structured control instruction <syntax-instr-control>`
* the number of :ref:`structured control instructions <syntax-instr-control>` in a :ref:`function <syntax-func>`
* the nesting depth of :ref:`structured control instructions <syntax-instr-control>`
* the number of :ref:`label indices <syntax-labelidx>` in a |BRTABLE| instruction
* the length of the array in a |ARRAYNEWFIXED| instruction
* the length of an :ref:`element segment <syntax-elem>`
* the length of a :ref:`data segment <syntax-data>`
* the length of a :ref:`name <syntax-name>`
* the range of :ref:`characters <syntax-char>` in a :ref:`name <syntax-name>`

If the limits of an implementation are exceeded for a given module,
then the implementation may reject the :ref:`validation <valid>`, compilation, or :ref:`instantiation <exec-instantiation>` of that module with an embedder-specific error.

.. note::
   The last item allows :ref:`embedders <embedder>` that operate in limited environments without support for
   |Unicode|_ to limit the
   names of :ref:`imports <syntax-import>` and :ref:`exports <syntax-export>`
   to common subsets like |ASCII|_.


.. index:: binary format, module, section, function, code
.. _impl-binary:

Binary Format
.............

For a module given in :ref:`binary format <binary>`, additional limitations may be imposed on the following dimensions:

* the size of a :ref:`module <binary-module>`
* the size of any :ref:`section <binary-section>`
* the size of an individual function's :ref:`code <binary-code>`
* the number of :ref:`sections <binary-section>`


.. index:: text format, source text, token, identifier, character, unicode
.. _impl-text:

Text Format
...........

For a module given in :ref:`text format <text>`, additional limitations may be imposed on the following dimensions:

* the size of the :ref:`source text <source>`
* the size of any syntactic element
* the size of an individual :ref:`token <text-token>`
* the nesting depth of :ref:`folded instructions <text-foldedinstr>`
* the length of symbolic :ref:`identifiers <text-id>`
* the range of literal :ref:`characters <text-char>` allowed in the :ref:`source text <source>`


.. index:: validation, function
.. _impl-valid:

Validation
~~~~~~~~~~

An implementation may defer :ref:`validation <valid>` of individual :ref:`functions <syntax-func>` until they are first :ref:`invoked <exec-invoke>`.

If a function turns out to be invalid, then the invocation, and every consecutive call to the same function, results in a :ref:`trap <trap>`.

.. note::
   This is to allow implementations to use interpretation or just-in-time compilation for functions.
   The function must still be fully validated before execution of its body begins.


.. index:: execution, module instance, function instance, table instance, memory instance, global instance, allocation, frame, label, value
.. _impl-exec:

Execution
~~~~~~~~~

Restrictions on the following dimensions may be imposed during :ref:`execution <exec>` of a WebAssembly program:

* the number of allocated :ref:`module instances <syntax-moduleinst>`
* the number of allocated :ref:`function instances <syntax-funcinst>`
* the number of allocated :ref:`table instances <syntax-tableinst>`
* the number of allocated :ref:`memory instances <syntax-meminst>`
* the number of allocated :ref:`global instances <syntax-globalinst>`
* the number of allocated :ref:`structure instances <syntax-structinst>`
* the number of allocated :ref:`array instances <syntax-arrayinst>`
* the size of a :ref:`table instance <syntax-tableinst>`
* the size of a :ref:`memory instance <syntax-meminst>`
* the size of an :ref:`array instance <syntax-arrayinst>`
* the number of :ref:`frames <syntax-frame>` on the :ref:`stack <stack>`
* the number of :ref:`labels <syntax-label>` on the :ref:`stack <stack>`
* the number of :ref:`values <syntax-val>` on the :ref:`stack <stack>`

If the runtime limits of an implementation are exceeded during execution of a computation,
then it may terminate that computation and report an embedder-specific error to the invoking code.

Some of the above limits may already be verified during instantiation, in which case an implementation may report exceedance in the same manner as for :ref:`syntactic limits <impl-syntax>`.

.. note::
   Concrete limits are usually not fixed but may be dependent on specifics, interdependent, vary over time, or depend on other implementation- or embedder-specific situations or events.

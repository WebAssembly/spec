.. index:: type
   pair: binary format; type
.. _binary-type:

Types
-----

.. note::
   In some places, possible types include both type constructors or types denoted by :ref:`type indices <syntax-typeidx>`.
   Thus, the binary format for type constructors corresponds to the encodings of small negative ${:sN(N)} values, such that they can unambiguously occur in the same place as (positive) type indices.


.. index:: number type
   pair: binary format; number type
.. _binary-numtype:

Number Types
~~~~~~~~~~~~

:ref:`Number types <syntax-numtype>` are encoded by a single byte.

$${grammar: Bnumtype}


.. index:: vector type
   pair: binary format; vector type
.. _binary-vectype:

Vector Types
~~~~~~~~~~~~

:ref:`Vector types <syntax-vectype>` are also encoded by a single byte.

$${grammar: Bvectype}


.. index:: heap type
   pair: binary format; heap type
.. _binary-heaptype:
.. _binary-absheaptype:

Heap Types
~~~~~~~~~~

:ref:`Heap types <syntax-reftype>` are encoded as either a single byte, or as a :ref:`type index <binary-typeidx>` encoded as a positive :ref:`signed integer <binary-sint>`.

$${grammar: Babsheaptype Bheaptype}

.. note::
   The heap type ${heaptype: BOT} cannot occur in a module.


.. index:: reference type
   pair: binary format; reference type
.. _binary-reftype:

Reference Types
~~~~~~~~~~~~~~~

:ref:`Reference types <syntax-reftype>` are either encoded by a single byte followed by a :ref:`heap type <binary-heaptype>`, or, as a short form, directly as an :ref:`abstract heap type <binary-absheaptype>`.

$${grammar: Breftype}


.. index:: value type, number type, reference type
   pair: binary format; value type
.. _binary-valtype:

Value Types
~~~~~~~~~~~

:ref:`Value types <syntax-valtype>` are encoded with their respective encoding as a :ref:`number type <binary-numtype>`, :ref:`vector type <binary-vectype>`, or :ref:`reference type <binary-reftype>`.

$${grammar: Bvaltype}

.. note::
   The value type ${valtype: BOT} cannot occur in a module.

   Value types can occur in contexts where :ref:`type indices <syntax-typeidx>` are also allowed, such as in the case of :ref:`block types <binary-blocktype>`.
   Thus, the binary format for types corresponds to the |SignedLEB128|_ :ref:`encoding <binary-sint>` of small negative ${:sN(N)} values, so that they can coexist with (positive) type indices in the future.


.. index:: result type, value type
   pair: binary format; result type
.. _binary-resulttype:

Result Types
~~~~~~~~~~~~

:ref:`Result types <syntax-resulttype>` are encoded by the respective :ref:`lists <binary-list>` of :ref:`value types <binary-valtype>`.

$${grammar: Bresulttype}


.. index:: composite type, aggregate type, structure type, array type, function type, result type, value type, field type, storage type, packed type, mutability
   pair: binary format; composite type
   pair: binary format; aggregate type
   pair: binary format; function type
   pair: binary format; structure type
   pair: binary format; array type
   pair: binary format; field type
   pair: binary format; storage type
   pair: binary format; packed type
.. _binary-comptype:
.. _binary-aggrtype:
.. _binary-functype:
.. _binary-structtype:
.. _binary-arraytype:
.. _binary-fieldtype:
.. _binary-storagetype:
.. _binary-packtype:

Composite Types
~~~~~~~~~~~~~~~

:ref:`Composite types <syntax-comptype>` are encoded by a distinct byte followed by a type encoding of the respective form.

$${grammar: Bmut Bcomptype Bfieldtype Bstoragetype Bpacktype}


.. index:: recursive type, sub type, composite type
   pair: binary format; recursive type
   pair: binary format; sub type
.. _binary-rectype:
.. _binary-subtype:

Recursive Types
~~~~~~~~~~~~~~~

:ref:`Recursive types <syntax-rectype>` are encoded by the byte ${:0x4E} followed by a :ref:`list <binary-list>` of :ref:`sub types <syntax-subtype>`.
Additional shorthands are recognized for unary recursions and sub types without super types.

$${grammar: Brectype Bsubtype}


.. index:: limits
   pair: binary format; limits
.. _binary-limits:

Limits
~~~~~~

:ref:`Limits <syntax-limits>` are encoded with a preceding flag indicating whether a maximum is present.

$${grammar: Blimits}


.. index:: memory type, limits, page size
   pair: binary format; memory type
.. _binary-memtype:

Memory Types
~~~~~~~~~~~~

:ref:`Memory types <syntax-memtype>` are encoded with their :ref:`limits <binary-limits>`.

$${grammar: Bmemtype}


.. index:: table type, reference type, limits
   pair: binary format; table type
.. _binary-tabletype:

Table Types
~~~~~~~~~~~

:ref:`Table types <syntax-tabletype>` are encoded with their :ref:`limits <binary-limits>` and the encoding of their element :ref:`reference type <syntax-reftype>`.

$${grammar: Btabletype}


.. index:: global type, mutability, value type
   pair: binary format; global type
   pair: binary format; mutability
.. _binary-mut:
.. _binary-globaltype:

Global Types
~~~~~~~~~~~~

:ref:`Global types <syntax-globaltype>` are encoded by their :ref:`value type <binary-valtype>` and a flag for their :ref:`mutability <syntax-mut>`.

$${grammar: Bglobaltype}

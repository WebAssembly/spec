.. index:: type
   pair: binary format; type
.. _binary-type:

Types
-----

.. note::
   In some places, possible types include both type constructors or types denoted by :ref:`type indices <syntax-typeidx>`.
   Thus, the binary format for type constructors corresponds to the encodings of small negative :math:`\xref{binary/values}{binary-sint}{\sN}` values, such that they can unambiguously occur in the same place as (positive) type indices.


.. index:: number type
   pair: binary format; number type
.. _binary-numtype:

Number Types
~~~~~~~~~~~~

:ref:`Number types <syntax-numtype>` are encoded by a single byte.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{number type} & \Bnumtype &::=&
     \hex{7F} &\Rightarrow& \I32 \\ &&|&
     \hex{7E} &\Rightarrow& \I64 \\ &&|&
     \hex{7D} &\Rightarrow& \F32 \\ &&|&
     \hex{7C} &\Rightarrow& \F64 \\
   \end{array}


.. index:: vector type
   pair: binary format; vector type
.. _binary-vectype:

Vector Types
~~~~~~~~~~~~

:ref:`Vector types <syntax-vectype>` are also encoded by a single byte.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{vector type} & \Bvectype &::=&
     \hex{7B} &\Rightarrow& \V128 \\
   \end{array}


.. index:: heap type
   pair: binary format; heap type
.. _binary-heaptype:
.. _binary-absheaptype:

Heap Types
~~~~~~~~~~

:ref:`Heap types <syntax-reftype>` are encoded as either a single byte, or as a :ref:`type index <binary-typeidx>` encoded as a positive :ref:`signed integer <binary-sint>`.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{abstract heap type} & \Babsheaptype &::=&
     \hex{73} &\Rightarrow& \NOFUNC \\ &&|&
     \hex{72} &\Rightarrow& \NOEXTERN \\ &&|&
     \hex{71} &\Rightarrow& \NONE \\ &&|&
     \hex{70} &\Rightarrow& \FUNC \\ &&|&
     \hex{6F} &\Rightarrow& \EXTERN \\ &&|&
     \hex{6E} &\Rightarrow& \ANY \\ &&|&
     \hex{6D} &\Rightarrow& \EQT \\ &&|&
     \hex{6C} &\Rightarrow& \I31 \\ &&|&
     \hex{6B} &\Rightarrow& \STRUCT \\ &&|&
     \hex{6A} &\Rightarrow& \ARRAY \\
   \production{heap type} & \Bheaptype &::=&
     \X{ht}{:}\Babsheaptype &\Rightarrow& \X{ht} \\ &&|&
     x{:}\Bs33 &\Rightarrow& x & (\iff x \geq 0) \\
   \end{array}


.. index:: reference type
   pair: binary format; reference type
.. _binary-reftype:

Reference Types
~~~~~~~~~~~~~~~

:ref:`Reference types <syntax-reftype>` are either encoded by a single byte followed by a :ref:`heap type <binary-heaptype>`, or, as a short form, directly as an :ref:`abstract heap type <binary-absheaptype>`.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{reference type} & \Breftype &::=&
     \hex{64}~~\X{ht}{:}\Bheaptype &\Rightarrow& \REF~\X{ht} \\ &&|&
     \hex{63}~~\X{ht}{:}\Bheaptype &\Rightarrow& \REF~\NULL~\X{ht} \\ &&|&
     \X{ht}{:}\Babsheaptype &\Rightarrow& \REF~\NULL~\X{ht} \\
   \end{array}


.. index:: value type, number type, reference type
   pair: binary format; value type
.. _binary-valtype:

Value Types
~~~~~~~~~~~

:ref:`Value types <syntax-valtype>` are encoded with their respective encoding as a :ref:`number type <binary-numtype>`, :ref:`vector type <binary-vectype>`, or :ref:`reference type <binary-reftype>`.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{value type} & \Bvaltype &::=&
     t{:}\Bnumtype &\Rightarrow& t \\ &&|&
     t{:}\Bvectype &\Rightarrow& t \\ &&|&
     t{:}\Breftype &\Rightarrow& t \\
   \end{array}

.. note::
   The type :math:`\BOT` cannot occur in a module.

   Value types can occur in contexts where :ref:`type indices <syntax-typeidx>` are also allowed, such as in the case of :ref:`block types <binary-blocktype>`.
   Thus, the binary format for types corresponds to the |SignedLEB128|_ :ref:`encoding <binary-sint>` of small negative :math:`\sN` values, so that they can coexist with (positive) type indices in the future.


.. index:: result type, value type
   pair: binary format; result type
.. _binary-resulttype:

Result Types
~~~~~~~~~~~~

:ref:`Result types <syntax-resulttype>` are encoded by the respective :ref:`vectors <binary-vec>` of :ref:`value types <binary-valtype>`.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{result type} & \Bresulttype &::=&
     t^\ast{:\,}\Bvec(\Bvaltype) &\Rightarrow& [t^\ast] \\
   \end{array}


.. index:: function type, value type, result type
   pair: binary format; function type
.. _binary-functype:

Function Types
~~~~~~~~~~~~~~

:ref:`Function types <syntax-functype>` are encoded by the respective :ref:`vectors <binary-vec>` of parameter and result types.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{function type} & \Bfunctype &::=&
     \X{rt}_1{:\,}\Bresulttype~~\X{rt}_2{:\,}\Bresulttype
       &\Rightarrow& \X{rt}_1 \to \X{rt}_2 \\
   \end{array}


.. index:: aggregate type, value type, structure type, array type, field type, storage type, packed type, mutability
   pair: binary format; aggregate type
   pair: binary format; structure type
   pair: binary format; array type
   pair: binary format; field type
   pair: binary format; storage type
   pair: binary format; packed type
.. _binary-aggrtype:
.. _binary-structtype:
.. _binary-arraytype:
.. _binary-fieldtype:
.. _binary-storagetype:
.. _binary-packedtype:

Aggregate Types
~~~~~~~~~~~~~~~

:ref:`Aggregate types <syntax-aggrtype>` are encoded with their respective :ref:`field types <syntax-fieldtype>`.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{array type} & \Barraytype &::=&
     \X{ft}{:\,}\Bfieldtype
       &\Rightarrow& \X{ft} \\
   \production{structure type} & \Bstructtype &::=&
     \X{ft}^\ast{:\,}\Bvec(\Bfieldtype)
       &\Rightarrow& \X{ft}^\ast \\
   \production{field type} & \Bfieldtype &::=&
     \X{st}{:}\Bstoragetype~~m{:}\Bmut
       &\Rightarrow& m~\X{st} \\
   \production{storage type} & \Bstoragetype &::=&
     t{:}\Bvaltype
       &\Rightarrow& t \\ &&|&
     t{:}\Bpackedtype
       &\Rightarrow& t \\
   \production{packed type} & \Bpackedtype &::=&
     \hex{7A}
       &\Rightarrow& \I8 \\ &&|&
     \hex{79}
       &\Rightarrow& \I16 \\
   \end{array}


.. index:: composite type, structure type, array type, function type
   pair: binary format; composite type
.. _binary-comptype:

Composite Types
~~~~~~~~~~~~~~~

:ref:`Composite types <syntax-comptype>` are encoded by a distinct byte followed by a type encoding of the respective form.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{composite type} & \Bcomptype &::=&
     \hex{5E}~~\X{at}{:}\Barraytype
       &\Rightarrow& \TARRAY~\X{at} \\ &&|&
     \hex{5F}~~\X{st}{:}\Bstructtype
       &\Rightarrow& \TSTRUCT~\X{st} \\ &&|&
     \hex{60}~~\X{ft}{:}\Bfunctype
       &\Rightarrow& \TFUNC~\X{ft} \\
   \end{array}


.. index:: recursive type, sub type, composite type
   pair: binary format; recursive type
   pair: binary format; sub type
.. _binary-rectype:
.. _binary-subtype:

Recursive Types
~~~~~~~~~~~~~~~

:ref:`Recursive types <syntax-rectype>` are encoded by the byte :math:`\hex{31}` followed by a :ref:`vector <binary-vec>` of :ref:`sub types <syntax-subtype>`.
Additional shorthands are recognized for unary recursions and sub types without super types.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{recursive type} & \Brectype &::=&
     \hex{4F}~~\X{st}^\ast{:\,}\Bvec(\Bsubtype)
       &\Rightarrow& \TREC~\X{st}^\ast \\ &&|&
     \X{st}{:}\Bsubtype
       &\Rightarrow& \TREC~\X{st} \\
   \production{sub type} & \Bsubtype &::=&
     \hex{50}~~x^\ast{:\,}\Bvec(\Btypeidx)~~\X{ct}{:}\Bcomptype
       &\Rightarrow& \TSUB~x^\ast~\X{ct} \\ &&|&
     \hex{4E}~~x^\ast{:\,}\Bvec(\Btypeidx)~~\X{ct}{:}\Bcomptype
       &\Rightarrow& \TSUB~\TFINAL~x^\ast~\X{ct} \\ &&|&
     \X{ct}{:}\Bcomptype
       &\Rightarrow& \TSUB~\TFINAL~\epsilon~\X{ct} \\
   \end{array}


.. index:: limits
   pair: binary format; limits
.. _binary-limits:

Limits
~~~~~~

:ref:`Limits <syntax-limits>` are encoded with a preceding flag indicating whether a maximum is present.

.. math::
   \begin{array}{llclll}
   \production{limits} & \Blimits &::=&
     \hex{00}~~n{:}\Bu32 &\Rightarrow& \{ \LMIN~n, \LMAX~\epsilon \} \\ &&|&
     \hex{01}~~n{:}\Bu32~~m{:}\Bu32 &\Rightarrow& \{ \LMIN~n, \LMAX~m \} \\
   \end{array}


.. index:: memory type, limits, page size
   pair: binary format; memory type
.. _binary-memtype:

Memory Types
~~~~~~~~~~~~

:ref:`Memory types <syntax-memtype>` are encoded with their :ref:`limits <binary-limits>`.

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{memory type} & \Bmemtype &::=&
     \X{lim}{:}\Blimits &\Rightarrow& \X{lim} \\
   \end{array}


.. index:: table type, reference type, limits
   pair: binary format; table type
.. _binary-tabletype:

Table Types
~~~~~~~~~~~

:ref:`Table types <syntax-tabletype>` are encoded with their :ref:`limits <binary-limits>` and the encoding of their element :ref:`reference type <syntax-reftype>`.

.. math::
   \begin{array}{llclll}
   \production{table type} & \Btabletype &::=&
     \X{et}{:}\Breftype~~\X{lim}{:}\Blimits &\Rightarrow& \X{lim}~\X{et} \\
   \end{array}


.. index:: global type, mutability, value type
   pair: binary format; global type
   pair: binary format; mutability
.. _binary-mut:
.. _binary-globaltype:

Global Types
~~~~~~~~~~~~

:ref:`Global types <syntax-globaltype>` are encoded by their :ref:`value type <binary-valtype>` and a flag for their :ref:`mutability <syntax-mut>`.

.. math::
   \begin{array}{llclll}
   \production{global type} & \Bglobaltype &::=&
     t{:}\Bvaltype~~m{:}\Bmut &\Rightarrow& m~t \\
   \production{mutability} & \Bmut &::=&
     \hex{00} &\Rightarrow& \MCONST \\ &&|&
     \hex{01} &\Rightarrow& \MVAR \\
   \end{array}

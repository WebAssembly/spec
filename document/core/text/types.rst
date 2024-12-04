.. index:: type
   pair: text format; type
.. _text-type:

Types
-----

.. index:: number type
   pair: text format; number type
.. _text-numtype:

Number Types
~~~~~~~~~~~~

.. math::
   \begin{array}{llrll@{\qquad\qquad}l}
   \production{number type} & \Tnumtype_I &::=&
     \text{i32} &\Rightarrow& \I32 \\ &&|&
     \text{i64} &\Rightarrow& \I64 \\ &&|&
     \text{f32} &\Rightarrow& \F32 \\ &&|&
     \text{f64} &\Rightarrow& \F64 \\
   \end{array}


.. index:: vector type
   pair: text format; vector type
.. _text-vectype:

Vector Types
~~~~~~~~~~~~

.. math::
   \begin{array}{llcll@{\qquad\qquad}l}
   \production{vector type} & \Tvectype_I &::=&
     \text{v128} &\Rightarrow& \V128 \\
   \end{array}


.. index:: heap type
   pair: text format; heap type
.. _text-heaptype:
.. _text-absheaptype:

Heap Types
~~~~~~~~~~

.. math::
   \begin{array}{llrll@{\qquad\qquad}l}
   \production{abstract heap type} & \Tabsheaptype &::=&
     \text{any} &\Rightarrow& \ANY \\ &&|&
     \text{eq} &\Rightarrow& \EQT \\ &&|&
     \text{i31} &\Rightarrow& \I31 \\ &&|&
     \text{struct} &\Rightarrow& \STRUCT \\ &&|&
     \text{array} &\Rightarrow& \ARRAY \\ &&|&
     \text{none} &\Rightarrow& \NONE \\ &&|&
     \text{func} &\Rightarrow& \FUNC \\ &&|&
     \text{nofunc} &\Rightarrow& \NOFUNC \\ &&|&
     \text{extern} &\Rightarrow& \EXTERN \\ &&|&
     \text{noexn} &\Rightarrow& \NOEXN \\ &&|&
     \text{exn} &\Rightarrow& \EXN \\ &&|&
     \text{noextern} &\Rightarrow& \NOEXTERN \\
   \production{heap type} & \Theaptype_I &::=&
     t{:}\Tabsheaptype &\Rightarrow& y \\ &&|&
     x{:}\Ttypeidx_I &\Rightarrow& x \\
   \end{array}


.. index:: reference type
   pair: text format; reference type
.. _text-reftype:

Reference Types
~~~~~~~~~~~~~~~

.. math::
   \begin{array}{llcll@{\qquad\qquad}l}
   \production{reference type} & \Treftype_I &::=&
     \text{(}~\text{ref}~~\X{ht}{:}\Theaptype~\text{)}
       &\Rightarrow& \REF~\X{ht} \\ &&|&
     \text{(}~\text{ref}~~\text{null}~~\X{ht}{:}\Theaptype~\text{)}
       &\Rightarrow& \REF~\NULL~\X{ht} \\
   \end{array}

Abbreviations
.............

There are shorthands for references to abstract heap types.

.. math::
   \begin{array}{llclll}
   \production{reference type} &
     \text{anyref} &\equiv& \text{(}~\text{ref}~~\text{null}~~\text{any}~\text{)} \\
     \text{eqref} &\equiv& \text{(}~\text{ref}~~\text{null}~~\text{eq}~\text{)} \\
     \text{i31ref} &\equiv& \text{(}~\text{ref}~~\text{null}~~\text{i31}~\text{)} \\
     \text{structref} &\equiv& \text{(}~\text{ref}~~\text{null}~~\text{struct}~\text{)} \\
     \text{arrayref} &\equiv& \text{(}~\text{ref}~~\text{null}~~\text{array}~\text{)} \\
     \text{nullref} &\equiv& \text{(}~\text{ref}~~\text{null}~~\text{none}~\text{)} \\
     \text{funcref} &\equiv& \text{(}~\text{ref}~~\text{null}~~\text{func}~\text{)} \\
     \text{nullfuncref} &\equiv& \text{(}~\text{ref}~~\text{null}~~\text{nofunc}~\text{)} \\
     \text{exnref} &\equiv& \text{(}~\text{ref}~~\text{null}~~\text{exn}~\text{)} \\
     \text{nullexnref} &\equiv& \text{(}~\text{ref}~~\text{null}~~\text{noexn}~\text{)} \\
     \text{externref} &\equiv& \text{(}~\text{ref}~~\text{null}~~\text{extern}~\text{)} \\
     \text{nullexternref} &\equiv& \text{(}~\text{ref}~~\text{null}~~\text{noextern}~\text{)} \\
   \end{array}


.. index:: value type, number type, vector type, reference type
   pair: text format; value type
.. _text-valtype:

Value Types
~~~~~~~~~~~

.. math::
   \begin{array}{llcll@{\qquad\qquad}l}
   \production{value type} & \Tvaltype_I &::=&
     t{:}\Tnumtype_I &\Rightarrow& t \\ &&|&
     t{:}\Tvectype_I &\Rightarrow& t \\ &&|&
     t{:}\Treftype_I &\Rightarrow& t \\
   \end{array}


.. index:: function type, value type, result type
   pair: text format; function type
.. _text-param:
.. _text-result:
.. _text-functype:

Function Types
~~~~~~~~~~~~~~

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{function type} & \Tfunctype_I &::=&
     \text{(}~\text{func}~~t_1^\ast{:\,}\Tlist(\Tparam_I)~~t_2^\ast{:\,}\Tlist(\Tresult_I)~\text{)}
       &\Rightarrow& [t_1^\ast] \to [t_2^\ast] \\
   \production{parameter} & \Tparam_I &::=&
     \text{(}~\text{param}~~\Tid^?~~t{:}\Tvaltype_I~\text{)}
       &\Rightarrow& t \\
   \production{result} & \Tresult_I &::=&
     \text{(}~\text{result}~~t{:}\Tvaltype_I~\text{)}
       &\Rightarrow& t \\
   \end{array}

.. note::
   The optional identifier names for parameters in a function type only have documentation purpose.
   They cannot be referenced from anywhere.


Abbreviations
.............

Multiple anonymous parameters or results may be combined into a single declaration:

.. math::
   \begin{array}{llclll}
   \production{parameter} &
     \text{(}~~\text{param}~~\Tvaltype^\ast~~\text{)} &\equiv&
     (\text{(}~~\text{param}~~\Tvaltype~~\text{)})^\ast \\
   \production{result} &
     \text{(}~~\text{result}~~\Tvaltype^\ast~~\text{)} &\equiv&
     (\text{(}~~\text{result}~~\Tvaltype~~\text{)})^\ast \\
   \end{array}


.. index:: aggregate type, value type, structure type, array type, field type, storage type, packed type, mutability
   pair: text format; aggregate type
   pair: text format; structure type
   pair: text format; array type
   pair: text format; field type
   pair: text format; storage type
   pair: text format; packed type
.. _text-aggrtype:
.. _text-structtype:
.. _text-arraytype:
.. _text-fieldtype:
.. _text-storagetype:
.. _text-packtype:

Aggregate Types
~~~~~~~~~~~~~~~

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{array type} & \Tarraytype_I &::=&
     \text{(}~\text{array}~~\X{ft}{:}\Tfieldtype_I~\text{)}
       &\Rightarrow& \X{ft} \\
   \production{structure type} & \Tstructtype_I &::=&
     \text{(}~\text{struct}~~\X{ft}^\ast{:\,}\Tlist(\Tfield_I)~\text{)}
       &\Rightarrow& \X{ft}^\ast \\
   \production{field} & \Tfield_I &::=&
     \text{(}~\text{field}~~\Tid^?~~\X{ft}{:}\Tfieldtype_I~\text{)}
       &\Rightarrow& \X{ft} \\
   \production{field type} & \Tfieldtype_I &::=&
     \X{st}{:}\Bstoragetype
       &\Rightarrow& \MCONST~\X{st} \\ &&|&
     \text{(}~\text{mut}~~\X{st}{:}\Bstoragetype~\text{)}
       &\Rightarrow& \MVAR~\X{st} \\
   \production{storage type} & \Tstoragetype_I &::=&
     t{:}\Tvaltype_I
       &\Rightarrow& t \\ &&|&
     t{:}\Tpacktype
       &\Rightarrow& t \\
   \production{packed type} & \Tpacktype &::=&
     \text{i8}
       &\Rightarrow& \I8 \\ &&|&
     \text{i16}
       &\Rightarrow& \I16 \\
   \end{array}

Abbreviations
.............

Multiple anonymous structure fields may be combined into a single declaration:

.. math::
   \begin{array}{llclll}
   \production{field} &
     \text{(}~~\text{field}~~\Tfieldtype^\ast~~\text{)} &\equiv&
     (\text{(}~~\text{field}~~\Tfieldtype~~\text{)})^\ast \\
   \end{array}


.. index:: composite type, structure type, array type, function type
   pair: text format; composite type
.. _text-comptype:

Composite Types
~~~~~~~~~~~~~~~

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{composite type} & \Tcomptype_I &::=&
     \X{at}{:}\Tarraytype_I
       &\Rightarrow& \TARRAY~\X{at} \\ &&|&
     \X{st}{:}\Tstructtype_I
       &\Rightarrow& \TSTRUCT~\X{at} \\ &&|&
     \X{ft}{:}\Tfunctype_I
       &\Rightarrow& \TFUNC~\X{ft} \\
   \end{array}


.. index:: recursive type, sub type, composite type
   pair: text format; recursive type
   pair: text format; sub type
.. _text-rectype:
.. _text-subtype:
.. _text-typedef:

Recursive Types
~~~~~~~~~~~~~~~

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{recursive type} & \Trectype_I &::=&
     \text{(}~\text{rec}~~\X{st}^\ast{:\,}\Tlist(\Ttypedef_I)~\text{)}
       &\Rightarrow& \TREC~\X{st}^\ast \\
   \production{defined type} & \Ttypedef_I &::=&
     \text{(}~\text{type}~~\Tid^?~~\X{st}{:}\Tsubtype_I~\text{)}
       &\Rightarrow& \X{st} \\
   \production{sub type} & \Tsubtype_I &::=&
     \text{(}~\text{sub}~~\text{final}^?~~x^\ast{:\,}\Tlist(\Ttypeidx_I)~~\X{ct}{:}\Tcomptype_I~\text{)}
       &\Rightarrow& \TSUB~\TFINAL^?~x^\ast~\X{ct} \\
   \end{array}


Abbreviations
.............

Singular recursive types can omit the :math:`\text{rec}` keyword:

.. math::
   \begin{array}{llclll}
   \production{recursive type} &
     \Ttypedef &\equiv&
     \text{(}~~\text{rec}~~\Ttypedef~~\text{)} \\
   \end{array}

Similarly, final sub types with no super-types can omit the |Tsub| keyword and arguments:

.. math::
   \begin{array}{llclll}
   \production{sub type} &
     \Tcomptype &\equiv&
     \text{(}~~\text{sub}~~\text{final}~~\epsilon~~\Tcomptype~~\text{)} \\
   \end{array}


.. index:: address type
   pair: text format; address type
.. _text-addrtype:

Address Types
~~~~~~~~~~~~~

.. math::
   \begin{array}{llclll}
   \production{address type} & \Taddrtype &::=&
     \text{i32} &\Rightarrow& \I32 \\ &&|&
     \text{i64} &\Rightarrow& \I64 \\
   \end{array}

Abbreviations
.............

The address type can be omited, in which case it defaults :math:`\I32`:

.. math::
   \begin{array}{llclll}
   \production{address type} &
     \text{} &\equiv& \text{i32}
   \end{array}


.. index:: limits
   pair: text format; limits
.. _text-limits:

Limits
~~~~~~

.. math::
    \begin{array}{llclll}
    \production{limits} & \Tlimits &::=&
      n{:}\Tu32 &\Rightarrow& \{ \LMIN~n, \LMAX~\epsilon \} \\ &&|&
      n{:}\Tu32~~m{:}\Tu32 &\Rightarrow& \{ \LMIN~n, \LMAX~m \} \\
    \end{array}


.. index:: memory type, limits, page size
   pair: text format; memory type
.. _text-memtype:

Memory Types
~~~~~~~~~~~~

.. math::
   \begin{array}{llclll@{\qquad\qquad}l}
   \production{memory type} & \Tmemtype_I &::=&
     \X{at}{:}\Taddrtype~~\X{lim}{:}\Tlimits &\Rightarrow& \X{at}~\X{lim} \\
   \end{array}


.. index:: table type, reference type, limits
   pair: text format; table type
.. _text-tabletype:

Table Types
~~~~~~~~~~~

.. math::
   \begin{array}{llclll}
   \production{table type} & \Ttabletype_I &::=&
     \X{at}{:}\Taddrtype~~\X{lim}{:}\Tlimits~~\X{et}{:}\Treftype_I &\Rightarrow& \X{at}~\X{lim}~\X{et} \\
   \end{array}


.. index:: global type, mutability, value type
   pair: text format; global type
   pair: text format; mutability
.. _text-globaltype:

Global Types
~~~~~~~~~~~~

.. math::
   \begin{array}{llclll}
   \production{global type} & \Tglobaltype_I &::=&
     t{:}\Tvaltype &\Rightarrow& \MCONST~t \\ &&|&
     \text{(}~\text{mut}~~t{:}\Tvaltype_I~\text{)} &\Rightarrow& \MVAR~t \\
   \end{array}

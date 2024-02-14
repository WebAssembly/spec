.. index:: custom section, section, binary format

Custom Sections
---------------

This appendix defines dedicated :ref:`custom sections <binary-customsec>` for WebAssembly's :ref:`binary format <binary>`.
Such sections do not contribute to, or otherwise affect, the WebAssembly semantics, and like any custom section they may be ignored by an implementation.
However, they provide useful meta data that implementations can make use of to improve user experience or take compilation hints.

Currently, only one dedicated custom section is defined, the :ref:`name section<binary-namesec>`.


.. index:: ! name section, name, Unicode UTF-8
.. _binary-namesec:

Name Section
~~~~~~~~~~~~

The *name section* is a :ref:`custom section <binary-customsec>` whose name string is itself :math:`\text{name}`.
The name section should appear only once in a module, and only after the :ref:`data section <binary-datasec>`.

The purpose of this section is to attach printable names to definitions in a module, which e.g. can be used by a debugger or when parts of the module are to be rendered in :ref:`text form <text>`.

.. note::
   All :ref:`names <binary-name>` are represented in |Unicode|_ encoded in UTF-8.
   Names need not be unique.


.. _binary-namesubsection:

Subsections
...........

The :ref:`data <binary-customsec>` of a name section consists of a sequence of *subsections*.
Each subsection consists of a

* a one-byte subsection *id*,
* the |U32| *size* of the contents, in bytes,
* the actual *contents*, whose structure is dependent on the subsection id.

.. math::
   \begin{array}{llcll}
   \production{name section} & \Bnamesec &::=&
     \Bsection_0(\Bnamedata) \\
   \production{name data} & \Bnamedata &::=&
     n{:}\Bname & (\iff n = \text{name}) \\ &&&
     \Bmodulenamesubsec^? \\ &&&
     \Bfuncnamesubsec^? \\ &&&
     \Blocalnamesubsec^? \\
   \production{name subsection} & \Bnamesubsection_N(\B{B}) &::=&
     N{:}\Bbyte~~\X{size}{:}\Bu32~~\B{B}
       & (\iff \X{size} = ||\B{B}||) \\
   \end{array}

The following subsection ids are used:

==  ===========================================
Id  Subsection                                 
==  ===========================================
 0  :ref:`module name <binary-modulenamesec>`
 1  :ref:`function names <binary-funcnamesec>`    
 2  :ref:`local names <binary-localnamesec>`
 4  :ref:`type names <binary-typenamesec>`
10  :ref:`field names <binary-fieldnamesec>`
==  ===========================================

Each subsection may occur at most once, and in order of increasing id.


.. index:: ! name map, index, index space
.. _binary-indirectnamemap:
.. _binary-namemap:

Name Maps
.........

A *name map* assigns :ref:`names <syntax-name>` to :ref:`indices <syntax-index>` in a given :ref:`index space <syntax-index>`.
It consists of a :ref:`vector <binary-vec>` of index/name pairs in order of increasing index value.
Each index must be unique, but the assigned names need not be.

.. math::
   \begin{array}{llclll}
   \production{name map} & \Bnamemap &::=&
     \Bvec(\Bnameassoc) \\
   \production{name association} & \Bnameassoc &::=&
     \Bidx~\Bname \\
   \end{array}

An *indirect name map* assigns :ref:`names <syntax-name>` to a two-dimensional :ref:`index space <syntax-index>`, where secondary indices are *grouped* by primary indices.
It consists of a vector of primary index/name map pairs in order of increasing index value, where each name map in turn maps secondary indices to names.
Each primary index must be unique, and likewise each secondary index per individual name map.

.. math::
   \begin{array}{llclll}
   \production{indirect name map} & \Bindirectnamemap &::=&
     \Bvec(\Bindirectnameassoc) \\
   \production{indirect name association} & \Bindirectnameassoc &::=&
     \Bidx~\Bnamemap \\
   \end{array}


.. index:: module
.. _binary-modulenamesec:

Module Names
............

The *module name subsection* has the id 0.
It simply consists of a single :ref:`name <binary-name>` that is assigned to the module itself.

.. math::
   \begin{array}{llclll}
   \production{module name subsection} & \Bmodulenamesubsec &::=&
     \Bnamesubsection_0(\Bname) \\
   \end{array}


.. index:: function, function index
.. _binary-funcnamesec:

Function Names
..............

The *function name subsection* has the id 1.
It consists of a :ref:`name map <binary-namemap>` assigning function names to :ref:`function indices <syntax-funcidx>`.

.. math::
   \begin{array}{llclll}
   \production{function name subsection} & \Bfuncnamesubsec &::=&
     \Bnamesubsection_1(\Bnamemap) \\
   \end{array}


.. index:: function, local, function index, local index
.. _binary-localnamesec:

Local Names
...........

The *local name subsection* has the id 2.
It consists of an :ref:`indirect name map <binary-indirectnamemap>` assigning local names to :ref:`local indices <syntax-localidx>` grouped by :ref:`function indices <syntax-funcidx>`.

.. math::
   \begin{array}{llclll}
   \production{local name subsection} & \Blocalnamesubsec &::=&
     \Bnamesubsection_2(\Bindirectnamemap) \\
   \end{array}


.. index:: type, type index
.. _binary-typenamesec:

Type Names
..............

The *type name subsection* has the id 4.
It consists of a :ref:`name map <binary-namemap>` assigning type names to :ref:`type indices <syntax-typeidx>`.

.. math::
   \begin{array}{llclll}
   \production{type name subsection} & \Btypenamesubsec &::=&
     \Bnamesubsection_1(\Bnamemap) \\
   \end{array}


.. index:: type, field, type index, field index
.. _binary-fieldnamesec:

Field Names
...........

The *field name subsection* has the id 10.
It consists of an :ref:`indirect name map <binary-indirectnamemap>` assigning field names to :ref:`field indices <syntax-fieldidx>` grouped by :ref:`type indices <syntax-typeidx>`.

.. math::
   \begin{array}{llclll}
   \production{field name subsection} & \Bfieldnamesubsec &::=&
     \Bnamesubsection_2(\Bindirectnamemap) \\
   \end{array}

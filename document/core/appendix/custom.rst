.. index:: custom section, section, binary format, annotation, text format

Custom Sections and Annotations
-------------------------------

This appendix defines dedicated :ref:`custom sections <binary-customsec>` for WebAssembly's :ref:`binary format <binary>` and :ref:`annotations <text-annot>` for the text format.
Such sections or annotations do not contribute to, or otherwise affect, the WebAssembly semantics, and may be ignored by an implementation.
However, they provide useful meta data that implementations can make use of to improve user experience or take compilation hints.



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
* the actual *contents*, whose structure is depended on the subsection id.

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


.. index:: ! name annotation, name, Unicode UTF-8
.. _text-nameannot:

Name Annotations
~~~~~~~~~~~~~~~~

*Name annotations* are the textual analogue to the :ref:`name section <binary-namesec>` and provide a textual representation for it.
Consequently, their id is :math:`\T{@name}`.

Analogous to the name section, name annotations are allowed on :ref:`modules <text-module>`, :ref:`functions <text-func>`, and :ref:`locals <text-local>` (including  :ref:`parameters <text-param>`).
They can be placed where the text format allows binding occurrences of respective :ref:`identifiers <text-id>`.
If both an identifier and a name annotation are given, the annotation is expected *after* the identifier.
In that case, the annotation takes precedence over the identifier as a textual representation of the binding's name.
At most one name annotation may be given per binding.

All name annotations have the following format:

.. math::
   \begin{array}{llclll}
   \production{name annotation} & \Tnameannot &::=&
     \text{(@name}~\Tstring~\text{)} \\
   \end{array}


.. note::
   All name annotations can be arbitrary UTF-8 :ref:`strings <text-string>`.
   Names need not be unique.


.. index:: module
.. _text-modulenameannot:

Module Names
............

A *module name annotation* must be placed on a :ref:`module <text-module>` definition,
directly after the :math:`\text{module}` keyword, or if present, after the following module :ref:`identifier <text-id>`.

.. math::
   \begin{array}{llclll}
   \production{module name annotation} & \Tmodulenameannot &::=&
     \Tnameannot \\
   \end{array}


.. index:: function
.. _binary-funcnameannot:

Function Names
..............

A *function name annotation* must be placed on a :ref:`function <text-func>` definition or function :ref:`import <text-import>`,
directly after the :math:`\text{func}` keyword, or if present, after the following function :ref:`identifier <text-id>` or.

.. math::
   \begin{array}{llclll}
   \production{function name annotation} & \Tfuncnameannot &::=&
     \Tnameannot \\
   \end{array}


.. index:: function, parameter
.. _binary-paramnameannot:

Parameter Names
...............

A *parameter name annotation* must be placed on a :ref:`parameter <text-param>` declaration,
directly after the :math:`\text{param}` keyword, or if present, after the following parameter :ref:`identifier <text-id>`.
It may only be placed on a declaration that declares exactly one parameter.

.. math::
   \begin{array}{llclll}
   \production{parameter name annotation} & \Tparamnameannot &::=&
     \Tnameannot \\
   \end{array}


.. index:: function, local
.. _binary-localnameannot:

Local Names
...........

A *local name annotation* must be placed on a :ref:`local <text-param>` declaration,
directly after the :math:`\text{local}` keyword, or if present, after the following local :ref:`identifier <text-id>`.
It may only be placed on a declaration that declares exactly one local.

.. math::
   \begin{array}{llclll}
   \production{local name annotation} & \Tlocalnameannot &::=&
     \Tnameannot \\
   \end{array}


.. index:: ! custom annotation, custom section
.. _text-customannot:

Custom Annotations
~~~~~~~~~~~~~~~~~~

*Custom annotations* are a generic textual representation for any :ref:`custom section <binary-customsec>`.
Their id is :math:`\T{@custom}`.
By generating custom annotations, tools converting between :ref:`binary format <binary>` and :ref:`text format <text>` can maintain and round-trip the content of custom sections even when they do not recognize them.

Custom annotations must be placed inside a :ref:`module <text-module>` definition.
They must occur anywhere after the :math:`\text{module}` keyword, or if present, after the following module :ref:`identifier <text-id>`.
They must not be nested into other constructs.

.. math::
   \begin{array}{llclll}
   \production{custom annotation} & \Tcustomannot &::=&
     \text{(@custom}~~\Tstring~~\Tcustomplace^?~~\Tdatastring~~\text{)} \\
   \production{custom placement} & \Tcustomplace &::=&
     \text{(}~\text{before}~~\text{first}~\text{)} \\ &&|&
     \text{(}~\text{before}~~\Tsec~\text{)} \\ &&|&
     \text{(}~\text{after}~~\Tsec~\text{)} \\ &&|&
     \text{(}~\text{after}~~\text{last}~\text{)} \\
   \production{section} & \Tsec &::=&
     \text{type} \\ &&|&
     \text{import} \\ &&|&
     \text{func} \\ &&|&
     \text{table} \\ &&|&
     \text{memory} \\ &&|&
     \text{global} \\ &&|&
     \text{export} \\ &&|&
     \text{start} \\ &&|&
     \text{elem} \\ &&|&
     \text{code} \\ &&|&
     \text{data} \\ &&|&
     \text{datacount} \\
   \end{array}

The first :ref:`string <text-string>` in a custom annotation denotes the name of the custom section it represents.
The remaining strings collectively represent the section's payload data, written as a :ref:`data string <text-datastring>`, which can be split up into a possibly empty sequence of individual string literals (similar to :ref:`data segments <text-data>`).

An arbitrary number of custom annotations (even of the same name) may occur in a module,
each defining a separate custom section when converting to :ref:`binary format <binary>`.
Placement of the sections in the binary can be customized via explicit *placement* directives, that position them either directly before or directly after a known section.
That section must exist and be non-empty in the binary encoding of the annotated module.
The placements :math:`\T{(before~first)}` and :math:`\T{(after~last)}` denote virtual sections before the first and after the last known section, respectively.
When the placement directive is omitted, it defaults to :math:`\T{(after~last)}`.

If multiple placement directives appear for the same position, then the sections are all placed there, in order of their appearance in the text.
For this purpose, the position :math:`\T{after}` a section is considered different from the position :math:`\T{before}` the consecutive section, and the former occurs before the latter.

.. note::
   Future versions of WebAssembly may introduce additional sections between others or at the beginning or end of a module.
   Using :math:`\T{first}` and :math:`\T{last}` guarantees that placement will still go before or after any future section, respectively.

If a custom section with a specific section id is given as well as annotations representing the same custom section (e.g., :math:`\T{@name}` :ref:`annotations <text-nameannot>` as well as a :math:`\T{@custom}` annotation for a :math:`\T{name}` :ref:`section <binary-namesec>`), then two sections are assumed to be created.
Their relative placement will depend on the placement directive given for the :math:`\T{@custom}` annotation as well as the implicit placement requirements of the custom section, which are applied to the other annotation.

.. note::

   For example, the following module,

   .. code-block:: none

      (module
        (@custom "A" "aaa")
        (type $t (func))
        (@custom "B" (after func) "bbb")
        (@custom "C" (before func) "ccc")
        (@custom "D" (after last) "ddd")
        (table 10 funcref)
        (func (type $t))
        (@custom "E" (after import) "eee")
        (@custom "F" (before type) "fff")
        (@custom "G" (after data) "ggg")
        (@custom "H" (after code) "hhh")
        (@custom "I" (after func) "iii")
        (@custom "J" (before func) "jjj")
        (@custom "K" (before first) "kkk")
      )

   will result in the following section ordering:

   .. code-block:: none

      custom section "K"
      custom section "F"
      type section
      custom section "E"
      custom section "C"
      custom section "J"
      function section
      custom section "B"
      custom section "I"
      table section
      code section
      custom section "H"
      custom section "G"
      custom section "A"
      custom section "D"


.. index:: ! branch hints section, hint
.. _binary-branchHintsSec:
.. _binary-funchints:

Branch Hints Section
~~~~~~~~~~~~~~~~~~~~

The *branch hints section* is a :ref:`custom section <binary-customsec>` whose name string is :math:`\text{branchHints}`.
The branch hints section should appear only once in a module, and only before the :ref:`code section <binary-codesec>`.

The purpose of this section is to aid the compilation of conditional branch instructions, by providing a hint that a branch is very likely (or unlikely) to be taken.

An implementation is not required to follow the hints, and this section can be entirely ignored.

The section contains a vector of *function branch hints* each representing the branch hints for a single function.

Each *function branch hints* structure consists of

* the :ref:`function index <binary-funcidx>` of the function the hints are referring to,
* a single 0 byte,
* a vector of *branch hints* for the function.

Elements of the *function branch hints* vector must appear in increasing function index order,
and a function index can appear at most once.

Each *branch hint* structure consists of

* a |U32| indicating the meaning of the hint:

=====  ===========================================
Value  Meaning                                    
=====  ===========================================
 0x00  branch likely not taken
 0x01  branch likely taken
=====  ===========================================

* the |U32| byte offset of the hinted instruction from the first instruction of the function.

Elements of the *branch hints* vector must appear in increasing byte offset order,
and a byte offset can appear at most once. A |BRIF| or |IF| instruction must be present
in the code section at the specified offset.


.. math::
   \begin{array}{llclll}
   \production{branch hints section} & \Bbranchhintssec &::=&
     \Bsection_0(\Bvec(\Bfuncbranchhints)) \\
   \production{function branch hints} & \Bfuncbranchhints &::=&
     \Bfuncidx~\hex{00}~\Bvec(\Bbranchhint) \\
   \production{branch hint} & \Bbranchhint &::=&
     \Bbranchhintkind~~\X{instoff}{:}\Bu32 \\
   \production{branch hint kind} & \Bbranchhintkind &::=&
     \hex{00} \\ &&&
     \hex{01} \\
   \end{array}


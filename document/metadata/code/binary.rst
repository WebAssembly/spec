.. _binary:

Binary Format
=============

.. _binary-codemetadata:

Code Metadata
-------------

A Code Metadata item is a piece of information logically attached to an instruction.

An item is associated with a format, which defines the item's payload.

All code metadata items of a format named *T* are grouped under a custom section
named *'metadata.code.T'*.
The following parametrized grammar rules define the generic structure of a code metadata
section of format *T*.

.. math::
   \begin{array}{llcll}
   \production{code metadata section} & \Bcodemetadatasec(\B{T}) &::=&
     \Bsection_0(\Bcodemetadata(\B{T})) \\
   \production{code metadata} & \Bcodemetadata(\B{T}) &::=&
     n{:}\Bname & (\iff n = \text{metadata.code.T}) \\ &&&
     \Bvec(\Bcodemetadatafunc(\B{T})) \\
   \production{code metadata function} & \Bcodemetadatafunc(\B{T}) &::=&
     x{:}\Bfuncidx~\Bvec(\Bcodemetadataitem(\B{T})) \\
   \production{code metadata item} & \Bcodemetadataitem(\B{T}) &::=&
     \X{off}{:}\Bu32 ~~ \X{size}{:}\Bu32 & (\iff \X{size} = ||\B{T}||) \\ &&&
      \X{data}{:}\B{T} \\
   \end{array}
.. index:: ! code metadata section

Where :math:`\X{off}` is the byte offset of the attached instruction, relative to the beginning of the |Bfunc| declaration, and :math:`\X{data}` is a further payload, whose content depends on the format :math:`T`.

|Bcodemetadatafunc| entries must appear in order of increasing :math:`x`, and duplicate id values are not allowed. |Bcodemetadata| entries must appear in order of increasing :math:`\X{off}`, and duplicate offset values are not allowed.

.. _binary-branchhints:

Branch Hints
~~~~~~~~~~~~

A Branch Hint is a code metadata item with format *branch_hint*.

It can only be attached to |BRIF| and |IF| instructions.

Its payload indicates whether the branch is likely or unlikely to be taken.

All branch hints for a module are contained in a single code metadata section
with name *'metadata.code.branch_hint'*.

.. math::
   \begin{array}{llcll}
   \production{branch hint section} & \Bbranchhintsec &::=&
     \Bcodemetadatasec(\Bbranchhint) \\
   \production{branch hint} & \Bbranchhint &::=&
     \Bunlikely \\ &&|&
     \Blikely \\
   \production{unlikely} & \Bunlikely &::=&
     \hex{00} \\
   \production{likely} & \Blikely &::=&
     \hex{01} \\
   \end{array}
.. index:: ! branch hint section

A value of |Blikely| means that the branch is likely to be taken, while a
value of |Bunlikely| means the opposite. A branch with no hints is considered
equally likely to be taken or not.

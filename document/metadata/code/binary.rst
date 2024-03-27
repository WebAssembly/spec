.. _binary:

Binary Format
=============

.. _binary-codemetadata:

Code Metadata
-------------

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

Where :math:`\X{off}` is the byte offset of the annotation starting from the beginning of the function body, and :math:`\X{data}` is a further payload, whose content depends on the format :math:`T`.

*code metadata function* entries must appear in order of increasing *function id*, and duplicate id values are not allowed. *code metadata item* entries must appear in order of increasing *instruction offset*, and duplicate offset values are not allowed.

.. _binary-branchhints:

Branch Hints
~~~~~~~~~~~~

A Branch Hint is code metadata item with format *branch_hint*.
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


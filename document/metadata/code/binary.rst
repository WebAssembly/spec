.. _binary:

Binary Format
=============

.. _binary-codemetadata:

Code Metadata
-------------

All code metadata items of a given type *T* are grouped under a custom section
named *'metadata.code.T'*.
The following parametrized grammar rules define the generic structure of a code metadata
section of type *T*.

.. math::
   \begin{array}{llcll}
   \production{code metadata section} & \Bcodemetadatasec(\B{T}) &::=&
     \Bsection_0(\Bcodemetadata(\B{T})) \\
   \production{code metadata} & \Bcodemetadata(\B{T}) &::=&
     n{:}\Bname & (\iff n = \text{metadata.code.T}) \\ &&&
     \Bvec(\Bcodemetadatafunc(\B{T})) \\
   \production{code metadata function} & \Bcodemetadatafunc(\B{T}) &::=&
     fidx{:}\Bfuncidx~\Bvec(\Bcodemetadataitem(\B{T})) \\
   \production{code metadata item} & \Bcodemetadataitem(\B{T}) &::=&
     \X{instoff}{:}\Bu32 ~~ \X{size}{:}\Bu32 & (\iff \X{size} = ||\B{T}||) \\ &&&
      \X{data}{:}\B{T} \\
   \end{array}
.. index:: ! code metadata section

Where *funcpos* is the byte offset of the annotation starting from the beginning of the function body, and *data* is a further payload, whose content depends on the type *T*.

*code metadata function* entries must appear in order of increasing *function id*, and duplicate id values are not allowed. *code metadata item* entries must appear in order of increasing *instruction offset*, and duplicate offset values are not allowed.

.. _binary-branchhints:

Branch Hints
~~~~~~~~~~~~

A Branch Hint is code metadata item with type *branch_hint*.
All branch hints for a module are contained in a single code metadata section
with name *'metadata.code.branch_hint'*.

.. math::
   \begin{array}{llcll}
   \production{branch hint section} & \Bbranchhintsec &::=&
     \Bcodemetadatasec(\Bbranchhint) \\
   \production{branch hint} & \Bbranchhint &::=&
     \hex{00} \\ &&|&
     \hex{01} \\
   \end{array}
.. index:: ! branch hint section


.. _text:

Text Format
===========

Code Metadata
-------------

Code Metadata items appear in the text format as custom annotations, and are considered
attached to the first instruction that follows them.


.. math::
   \begin{array}{llclll}
   \production{code metadata annotation} & \Tcodemetadataannot(\B{T}) &::=&
     \text{(@metadata.code.T}~\X{data}{:}\B{T}~\text{)} \\
   \end{array}

Where `T` is the type of the item, and `data` is a byte string containing the same
payload as in the binary format.


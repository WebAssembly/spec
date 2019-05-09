.. _security-considerations:

Security and Privacy Considerations
-----------------------

On its own, WebAssembly provides no access to the native computing environment; all I/O is performed by marshaling data through functions exposed by the :ref:`import <syntax-import>` and :ref:`export <syntax-export>` operators.
An implementation could provide access to native libraries by e.g. pre-defining standard functions.
Such a system would have to define its security and privacy behavior.
As of the data of publication, the only host binding is the :ref:`Javascript Interface js-api`, which states how WebAssembly interacts with the web environment.
Future versions will provide threads which can be used to create a high-resolution clock, which can be used for timing-based attacks (e.g. spectre).

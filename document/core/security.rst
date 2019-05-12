.. index:: ! security, host, embedder,  module, function, import
.. _security:

Security and Privacy Considerations
-----------------------

WebAssembly provides no ambient access to the computing environment in which code is executed.
Any interaction with the environment, such as I/O, access to resources, or operating system calls, can only be performed by invoking :ref:`functions <function>` provided by the :ref:`embedder <embedder>` and imported into a WebAssembly :ref:`module <module>`.
An embedder can establish security policies suitable for a respective environment by controlling or limiting which functional capabilities it makes available for import.
Such considerations are an embedder’s responsibility and the subject of :ref:`API definitions <scope>` for a specific environment.

Because WebAssembly is designed to be translated into machine code running directly on the host's hardware, it is potentially vulnerable to side channel attacks on the hardware level.
In environments where this is a concern, an embedder may have to put suitable mitigations into place to isolate WebAssembly computations.

As of the data of publication, the only specified embedder is the :ref:`Javascript Interface js-api`, which states how WebAssembly interacts with the web environment.

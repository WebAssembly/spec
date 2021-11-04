WebAssembly Specification
=========================

.. only:: html

   | Release |release|

   | Editor: Andreas Rossberg

   | Latest Draft: |WasmDraft|
   | Issue Tracker: |WasmIssues|

.. only:: builder_singlehtml

  .. toctree::
     :caption: Table of Contents
     :numbered:
     :maxdepth: 3

     intro/index
     syntax/index
     valid/index
     exec/index
     binary/index
     text/index
     appendix/index

.. only:: builder_html and not newhtml

  .. toctree::
     :maxdepth: 2

     intro/index
     syntax/index
     valid/index
     exec/index
     binary/index
     text/index
     appendix/index

.. only:: builder_html and newhtml

  .. toctree::
     :maxdepth: 3

     intro/index
     syntax/index
     valid/index
     exec/index
     binary/index
     text/index
     appendix/index

.. only:: latex

   .. toctree::

      appendix/index-types
      appendix/index-instructions
      appendix/index-rules

..
   Only include these links when using (multi-page) html builder.
   (The singlepage html builder is called builder_singlehtml.)

.. only:: builder_html

   * :ref:`index-type`
   * :ref:`index-instr`
   * :ref:`index-rules`

   * :ref:`genindex`

Changes
=======

Changes since the previous `Working Draft <https://www.w3.org/TR/2018/WD-wasm-core-1-20180904/>`_:

* changed function reference notation from :math:`\K{anyfunc}` to |FUNCREF|
* numerics functions renamed (e.g. :math:`\K{i64.}\EXTEND\K{\_}\sx\K{/i32}` becomes :math:`\K{i64.}\EXTEND\K{\_i32}\K{\_}\sx`)
* variable instructions renamed (e.g. :math:`\K{get\_local}` becomes |LOCALGET|)
* notation for numeric instructions changed (e.g. :math:`t_2\K{.}\cvtop\K{/}t_1` becomes :math:`t_2\K{.}\cvtop\K{\_}t_1\K{\_}\sx^?`)
* conversion functions renamed (e.g. :math:`\F{extend\_u}` becomes |extendu|)
* corrected |Unicode| terminology "scalar values" instead of "code points"
* :ref:`3.2.3 <valid-tabletype>` tables are limited to having :math:`2^{32}` elements
* :ref:`3.2.4 <valid-memtype>` memory is limited to having :math:`2^{16}` pages
* :ref:`3.2.6 <valid-externtype>` validation of external types
* :ref:`4.3.1.3 <aux-littleendian>` fix :math:`\littleendian` definition
* semantics for growing tables :ref:`4.5.3.6 <grow-table>` and growing memory :ref:`4.5.3.7 <grow-mem>` made more explicit
* :ref:`4.5.5 <exec-invocation>` push a dummy frame instead of raw values
* :ref:`5.2.4 <binary-name>` fix :math:`\utf8` to disallow surrogates
* :ref:`A.1 <embed>` add pre- and post-conditions section
* :ref:`A.1 <embed-store>` rename functions to follow noun_verb format (e.g. :math:`\F{decode\_module}` becomes :math:`\F{module\_decode}`)
* :ref:`A.4 <binary-namesubsection>` note that each subsection may occur at most once, in order of increasing id

.. index:: instruction, function type, store, validation
.. _exec-instr:

Instructions
------------

WebAssembly computation is performed by executing individual :ref:`instructions <syntax-instr>`.


.. index:: parametric instruction, value
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-parametric:

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _exec-nop:

$${rule-prose: exec/nop}

$${rule: {Step_pure/nop}}


.. _exec-unreachable:

$${rule-prose: exec/unreachable}

$${rule: {Step_pure/unreachable}}


.. _exec-drop:

$${rule-prose: exec/drop}

.. todo:: (1) Remove trailing "Do nothing."

$${rule: Step_pure/drop}


.. _exec-select:

$${rule-prose: exec/select}

$${rule: {Step_pure/select-*}}

.. note::
   In future versions of WebAssembly, ${:SELECT} may allow more than one value per choice.


.. index:: numeric instruction, determinism, trap, NaN, value, value type
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-numeric:

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~

Numeric instructions are defined in terms of the generic :ref:`numeric operators <exec-numeric>`.
The mapping of numeric instructions to their underlying operators is expressed by the following definition:

.. math::
   \begin{array}{lll@{\qquad}l}
   \X{op}_{\IN}(i_1,\dots,i_k) &=& \xref{exec/numerics}{int-ops}{\F{i}\X{op}}_N(i_1,\dots,i_k) \\
   \X{op}_{\FN}(z_1,\dots,z_k) &=& \xref{exec/numerics}{float-ops}{\F{f}\X{op}}_N(z_1,\dots,z_k) \\
   \end{array}

And for :ref:`conversion operators <exec-cvtop>`:

.. math::
   \begin{array}{lll@{\qquad}l}
   \cvtop^{\sx^?}_{t_1,t_2}(c) &=& \xref{exec/numerics}{convert-ops}{\X{cvtop}}^{\sx^?}_{|t_1|,|t_2|}(c) \\
   \end{array}

Where the underlying operators are partial, the corresponding instruction will :ref:`trap <trap>` when the result is not defined.
Where the underlying operators are non-deterministic, because they may return one of multiple possible :ref:`NaN <syntax-nan>` values, so are the corresponding instructions.

.. note::
   For example, the result of instruction :math:`\I32.\ADD` applied to operands :math:`i_1, i_2`
   invokes :math:`\ADD_{\I32}(i_1, i_2)`,
   which maps to the generic :math:`\iadd_{32}(i_1, i_2)` via the above definition.
   Similarly, :math:`\I64.\TRUNC\K{\_}\F32\K{\_s}` applied to :math:`z`
   invokes :math:`\TRUNC^{\K{s}}_{\F32,\I64}(z)`,
   which maps to the generic :math:`\truncs_{32,64}(z)`.


.. _exec-const:

:math:`t\K{.}\CONST~c`
......................

1. Push the value :math:`t.\CONST~c` to the stack.

.. note::
   No formal reduction rule is required for this instruction, since :math:`\CONST` instructions already are :ref:`values <syntax-val>`.


.. _exec-unop:

$${rule-prose: exec/unop}

.. todo:: (2) SpecTec currently defines the image of unop as a sequence, not a set.

$${rule: {Step_pure/unop-*}}


.. _exec-binop:

$${rule-prose: exec/binop}

.. todo:: (2) SpecTec currently defines the image of binop as a sequence, not a set.

$${rule: {Step_pure/binop-*}}


.. _exec-testop:

$${rule-prose: exec/testop}

.. todo:: (2) SpecTec currently defines the image of testop as a sequence, not a set.

$${rule: Step_pure/testop}


.. _exec-relop:

$${rule-prose: exec/relop}

.. todo:: (2) SpecTec currently defines the image of testop as a sequence, not a set.

$${rule: Step_pure/relop}


.. _exec-cvtop:

$${rule-prose: exec/cvtop}

.. todo:: (2) SpecTec currently defines the image of testop as a sequence, not a set.

$${rule: {Step_pure/cvtop-*}}


.. index:: reference instructions, reference
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-ref:

Reference Instructions
~~~~~~~~~~~~~~~~~~~~~~

.. _exec-ref.null:

:math:`\REFNULL~x`
.......................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-ref.null>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Push the value :math:`\REFNULL~\deftype` to the stack.

$${rule: {Step_read/ref.null-*}}

.. note::
   No formal reduction rule is required for the case |REFNULL| |ABSHEAPTYPE|,
   since the instruction form is already a :ref:`value <syntax-val>`.


.. _exec-ref.func:

$${rule-prose: exec/ref.func}

$${rule: Step_read/ref.func}


.. _exec-ref.is_null:

$${rule-prose: exec/ref.is_null}

.. todo:: (3) Introduce if-let instruction instead of "is of the case".

$${rule: {Step_pure/ref.is_null-*}}


.. _exec-ref.as_non_null:

$${rule-prose: exec/ref.as_non_null}

.. todo:: (3) Introduce if-let instruction instead of "is of the case".

$${rule: {Step_pure/ref.as_non_null-*}}


.. _exec-ref.eq:

$${rule-prose: exec/ref.eq}

.. todo:: (3) Introduce if-let instruction instead of "is of the case".

$${rule: {Step_pure/ref.eq-*}}


.. _exec-ref.test:

$${rule-prose: exec/ref.test}

.. todo::
   Below is the actual prose. 
   (9) Need to handle RulePr s \|- ref : rt properly in prose instead of $ref_type_of

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Let :math:`\X{rt}_1` be the :ref:`reference type <syntax-reftype>` :math:`\insttype_{F.\AMODULE}(\X{rt})`.

3. Assert: due to :ref:`validation <valid-ref.test>`, :math:`\X{rt}_1` is :ref:`closed <type-closed>`.

4. Assert: due to :ref:`validation <valid-ref.test>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

5. Pop the value :math:`\reff` from the stack.

6. Assert: due to validation, the :ref:`reference value <syntax-ref>` is :ref:`valid <valid-ref>` with some :ref:`reference type <syntax-reftype>`.

7. Let :math:`\X{rt}_2` be the :ref:`reference type <syntax-reftype>` of :math:`\reff`.

8. If the :ref:`reference type <syntax-reftype>` :math:`\X{rt}_2` :ref:`matches <match-reftype>` :math:`\X{rt}_1`, then:

   a. Push the value :math:`\I32.\CONST~1` to the stack.

9. Else:

   a. Push the value :math:`\I32.\CONST~0` to the stack.

$${rule: {Step_read/ref.test-*}}


.. _exec-ref.cast:

$${rule-prose: exec/ref.cast}

.. todo::
   Below is the actual prose. 
   (9) Need to handle RulePr s \|- ref : rt properly in prose instead of $ref_type_of

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Let :math:`\X{rt}_1` be the :ref:`reference type <syntax-reftype>` :math:`\insttype_{F.\AMODULE}(\X{rt})`.

3. Assert: due to :ref:`validation <valid-ref.test>`, :math:`\X{rt}_1` is :ref:`closed <type-closed>`.

4. Assert: due to :ref:`validation <valid-ref.test>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

5. Pop the value :math:`\reff` from the stack.

6. Assert: due to validation, the :ref:`reference value <syntax-ref>` is :ref:`valid <valid-ref>` with some :ref:`reference type <syntax-reftype>`.

7. Let :math:`\X{rt}_2` be the :ref:`reference type <syntax-reftype>` of :math:`\reff`.

8. If the :ref:`reference type <syntax-reftype>` :math:`\X{rt}_2` :ref:`matches <match-reftype>` :math:`\X{rt}_1`, then:

   a. Push the value :math:`\reff` back to the stack.

9. Else:

   a. Trap.

$${rule: {Step_read/ref.cast-*}}


.. _exec-ref.i31:

$${rule-prose: exec/ref.i31}

$${rule: {Step_pure/ref.i31}}


.. _exec-i31.get_sx:

$${rule-prose: exec/i31.get}

.. todo::
   Below is the actual prose.
   (3) Introduce if-let instruction instead of "is of the case".
   (4) Guarantees from validation can help simplify the prose.

1. Assert: due to :ref:`validation <valid-i31.get_sx>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`(\REF~\NULL~\I31)` is on the top of the stack.

2. Pop the value :math:`\reff` from the stack.

3. If :math:`\reff` is :math:`\REFNULL~t`, then:

   a. Trap.

4. Assert: due to :ref:`validation <valid-i31.get_sx>`, a :math:`\reff` is a :ref:`scalar reference <syntax-ref.i31>`.

5. Let :math:`\REFI31NUM~i` be the reference value :math:`\reff`.

6. Let :math:`j` be the result of computing :math:`\ext^{\sx}_{31,32}(i)`.

7. Push the value :math:`\I32.\CONST~j` to the stack.

$${rule: {Step_pure/i31.get-*}}


.. _exec-struct.new:

$${rule-prose: exec/struct.new}

.. todo::
   Below is the actual prose.
   (3') Introduce let binding instead of "is of the case".
   (5) Use "the expansion of" instead of $expand function application.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-struct.new>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-struct.new>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is a :ref:`structure type <syntax-structtype>`.

5. Let :math:`\TSTRUCT~\X{ft}^\ast` be the :ref:`expanded <aux-expand-deftype>` :ref:`structure type <syntax-structtype>` of :math:`\deftype`.

6. Let :math:`n` be the length of the :ref:`field type <syntax-fieldtype>` sequence :math:`\X{ft}^\ast`.

7. Assert: due to :ref:`validation <valid-struct.new>`, :math:`n` :ref:`values <syntax-val>` are on the top of the stack.

8. Pop the :math:`n` values :math:`\val^\ast` from the stack.

9. For every value :math:`\val_i` in :math:`\val^\ast` and corresponding :ref:`field type <syntax-fieldtype>` :math:`\X{ft}_i` in :math:`\X{ft}^\ast`:

   a. Let :math:`\fieldval_i` be the result of computing :math:`\packfield_{\X{ft}_i}(\val_i))`.

10. Let :math:`\fieldval^\ast` the concatenation of all field values :math:`\fieldval_i`.

11. Let :math:`\X{si}` be the :ref:`structure instance <syntax-structinst>` :math:`\{\SITYPE~\deftype, \SIFIELDS~\fieldval^\ast\}`.

12. Let :math:`a` be the length of :math:`S.\SSTRUCTS`.

13. Append :math:`\X{si}` to :math:`S.\SSTRUCTS`.

14. Push the :ref:`structure reference <syntax-ref.struct>` :math:`\REFSTRUCTADDR~a` to the stack.

$${rule: {Step/struct.new}}


.. _exec-struct.new_default:

$${rule-prose: exec/struct.new_default}

.. todo::
   Below is the actual prose.
   (3') Introduce let binding instead of "is of the case".
   (5) Use "the expansion of" instead of $expand function application.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-struct.new_default>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-struct.new_default>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is a :ref:`structure type <syntax-structtype>`.

5. Let :math:`\TSTRUCT~\X{ft}^\ast` be the :ref:`expanded <aux-expand-deftype>` :ref:`structure type <syntax-structtype>` of :math:`\deftype`.

6. Let :math:`n` be the length of the :ref:`field type <syntax-fieldtype>` sequence :math:`\X{ft}^\ast`.

7. For every :ref:`field type <syntax-fieldtype>` :math:`\X{ft}_i` in :math:`\X{ft}^\ast`:

   a. Let :math:`t_i` be the :ref:`value type <syntax-valtype>` :math:`\unpack(\X{ft}_i)`.

   b. Assert: due to :ref:`validation <valid-struct.new_default>`, :math:`\default_{t_i}` is defined.

   c. Push the :ref:`value <syntax-val>` :math:`\default_{t_i}` to the stack.

8. Execute the instruction :math:`(\STRUCTNEW~x)`.

$${rule: {Step_read/struct.new_default}}


.. _exec-struct.get:
.. _exec-struct.get_sx:

$${rule-prose: exec/struct.get}

.. todo::
   Below is the actual prose.
   (3) Introduce if-let instruction instead of "is of the case".
   (5) Use "the expansion of" instead of $expand function application.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-struct.get>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-struct.get>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is a :ref:`structure type <syntax-structtype>` with at least :math:`y + 1` fields.

5. Let :math:`\TSTRUCT~\X{ft}^\ast` be the :ref:`expanded <aux-expand-deftype>` :ref:`structure type <syntax-structtype>` of :math:`\deftype`.

6. Let :math:`\X{ft}_y` be the :math:`y`-th :ref:`field type <syntax-fieldtype>` of :math:`\X{ft}^\ast`.

7. Assert: due to :ref:`validation <valid-struct.get>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`(\REF~\NULL~x)` is on the top of the stack.

8. Pop the value :math:`\reff` from the stack.

9. If :math:`\reff` is :math:`\REFNULL~t`, then:

   a. Trap.

10. Assert: due to :ref:`validation <valid-struct.get>`, a :math:`\reff` is a :ref:`structure reference <syntax-ref.struct>`.

11. Let :math:`\REFSTRUCTADDR~a` be the reference value :math:`\reff`.

12. Assert: due to :ref:`validation <valid-struct.get>`, the :ref:`structure instance <syntax-structinst>` :math:`S.\SSTRUCTS[a]` exists and has at least :math:`y + 1` fields.

13. Let :math:`\fieldval` be the :ref:`field value <syntax-fieldval>` :math:`S.\SSTRUCTS[a].\SIFIELDS[y]`.

14. Let :math:`\val` be the result of computing :math:`\unpackfield^{\sx^?}_{\X{ft}_y}(\fieldval))`.

15. Push the value :math:`\val` to the stack.

$${rule: {Step_read/struct.get-*}}


.. _exec-struct.set:

$${rule-prose: exec/struct.set}

.. todo::
   Below is the actual prose.
   (3) Introduce if-let instruction instead of "is of the case".
   (5) Use "the expansion of" instead of $expand function application.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-struct.set>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-struct.set>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is a :ref:`structure type <syntax-structtype>` with at least :math:`y + 1` fields.

5. Let :math:`\TSTRUCT~\X{ft}^\ast` be the :ref:`expanded <aux-expand-deftype>` :ref:`structure type <syntax-structtype>` of :math:`\deftype`.

6. Let :math:`\X{ft}_y` be the :math:`y`-th :ref:`field type <syntax-fieldtype>` of :math:`\X{ft}^\ast`.

7. Assert: due to :ref:`validation <valid-struct.set>`, a :ref:`value <syntax-val>` is on the top of the stack.

8. Pop the value :math:`\val` from the stack.

9. Assert: due to :ref:`validation <valid-struct.set>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`(\REF~\NULL~x)` is on the top of the stack.

10. Pop the value :math:`\reff` from the stack.

11. If :math:`\reff` is :math:`\REFNULL~t`, then:

   a. Trap.

12. Assert: due to :ref:`validation <valid-struct.set>`, a :math:`\reff` is a :ref:`structure reference <syntax-ref.struct>`.

13. Let :math:`\REFSTRUCTADDR~a` be the reference value :math:`\reff`.

14. Assert: due to :ref:`validation <valid-struct.set>`, the :ref:`structure instance <syntax-structinst>` :math:`S.\SSTRUCTS[a]` exists and has at least :math:`y + 1` fields.

15. Let :math:`\fieldval` be the result of computing :math:`\packfield_{\X{ft}_y}(\val))`.

16. Replace the :ref:`field value <syntax-fieldval>` :math:`S.\SSTRUCTS[a].\SIFIELDS[y]` with :math:`\fieldval`.

$${rule: {Step/struct.set-*}}
   

.. _exec-array.new:

$${rule-prose: exec/array.new}

$${rule: {Step_pure/array.new}}


.. _exec-array.new_default:

$${rule-prose: exec/array.new_default}

.. todo::
   Below is the actual prose.
   (3') Introduce let binding instead of "is of the case".
   (5) Use "the expansion of" instead of $expand function application.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-array.new_default>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-array.new_default>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is an :ref:`array type <syntax-arraytype>`.

5. Let :math:`\TARRAY~\X{ft}` be the :ref:`expanded <aux-expand-deftype>` :ref:`array type <syntax-arraytype>` of :math:`\deftype`.

6. Assert: due to :ref:`validation <valid-array.new_default>`, a :ref:`value <syntax-val>` of type :math:`\I32` is on the top of the stack.

7. Pop the value :math:`\I32.\CONST~n` from the stack.

8. Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`\unpack(\X{ft})`.

9. Assert: due to :ref:`validation <valid-array.new_default>`, :math:`\default_t` is defined.

10. Push the :ref:`value <syntax-val>` :math:`\default_t` to the stack :math:`n` times.

11. Execute the instruction :math:`(\ARRAYNEWFIXED~x~n)`.

$${rule: {Step_read/array.new_default}}


.. _exec-array.new_fixed:

$${rule-prose: exec/array.new_fixed}

.. todo::
   Below is the actual prose.
   (3') Introduce let binding instead of "is of the case".
   (5) Use "the expansion of" instead of $expand function application.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-array.new_fixed>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-array.new_fixed>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is a :ref:`array type <syntax-arraytype>`.

5. Let :math:`\TARRAY~\X{ft}` be the :ref:`expanded <aux-expand-deftype>` :ref:`array type <syntax-arraytype>` of :math:`\deftype`.

6. Assert: due to :ref:`validation <valid-array.new_fixed>`, :math:`n` :ref:`values <syntax-val>` are on the top of the stack.

7. Pop the :math:`n` values :math:`\val^\ast` from the stack.

8. For every value :math:`\val_i` in :math:`\val^\ast`:

   a. Let :math:`\fieldval_i` be the result of computing :math:`\packfield_{\X{ft}}(\val_i))`.

9. Let :math:`\fieldval^\ast` be the concatenation of all field values :math:`\fieldval_i`.

10. Let :math:`\X{ai}` be the :ref:`array instance <syntax-arrayinst>` :math:`\{\AITYPE~\deftype, \AIFIELDS~\fieldval^\ast\}`.

11. Let :math:`a` be the length of :math:`S.\SARRAYS`.

12. Append :math:`\X{ai}` to :math:`S.\SARRAYS`.

13. Push the :ref:`array reference <syntax-ref.array>` :math:`\REFARRAYADDR~a` to the stack.

$${rule: {Step/array.new_fixed}}


.. _exec-array.new_data:

$${rule-prose: exec/array.new_data}

.. todo::
   Below is the actual prose.
   (7) Render $inverse_ with display hint.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-array.new_data>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-array.new_data>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is an :ref:`array type <syntax-arraytype>`.

5. Let :math:`\TARRAY~\X{ft}` be the :ref:`expanded <aux-expand-deftype>` :ref:`array type <syntax-arraytype>` of :math:`\deftype`.

6. Assert: due to :ref:`validation <valid-array.new_data>`, the :ref:`data address <syntax-dataaddr>` :math:`F.\AMODULE.\MIDATAS[y]` exists.

7. Let :math:`\X{da}` be the :ref:`data address <syntax-dataaddr>` :math:`F.\AMODULE.\MIDATAS[y]`.

8. Assert: due to :ref:`validation <valid-array.new_data>`, the :ref:`data instance <syntax-datainst>` :math:`S.\SDATAS[\X{da}]` exists.

9. Let :math:`\datainst` be the :ref:`data instance <syntax-datainst>` :math:`S.\SDATAS[\X{da}]`.

10. Assert: due to :ref:`validation <valid-array.new_data>`, two :ref:`values <syntax-val>` of type :math:`\I32` are on the top of the stack.

11. Pop the value :math:`\I32.\CONST~n` from the stack.

12. Pop the value :math:`\I32.\CONST~s` from the stack.

13. Assert: due to :ref:`validation <valid-array.new_data>`, the :ref:`field type <syntax-fieldtype>` :math:`\X{ft}` has a defined :ref:`bit width <bitwidth-fieldtype>`.

14. Let :math:`z` be the :ref:`bit width <bitwidth-fieldtype>` of :ref:`field type <syntax-fieldtype>` :math:`\X{ft}` divided by eight.

15. If the sum of :math:`s` and :math:`n` times :math:`z` is larger than the length of :math:`\datainst.\DIBYTES`, then:

    a. Trap.

16. Let :math:`b^\ast` be the :ref:`byte <syntax-byte>` sequence :math:`\datainst.\DIBYTES[s \slice n \cdot z]`.

17. Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`\unpack(\X{ft})`.

18. For each consecutive subsequence :math:`{b'}^n` of :math:`b^\ast`:

    a. Assert: due to :ref:`validation <valid-array.new_data>`, :math:`\bytes_{\X{ft}}` is defined.

    b. Let :math:`c_i` be the constant for which :math:`\bytes_{\X{ft}}(c_i)` is :math:`{b'}^n`.

    c. Push the value :math:`t.\CONST~c_i` to the stack.

19. Execute the instruction :math:`(\ARRAYNEWFIXED~x~n)`.

$${rule: {Step_read/array.new_data-*}}


.. _exec-array.new_elem:

$${rule-prose: exec/array.new_elem}

$${rule: {Step_read/array.new_elem-*}}


.. _exec-array.get:
.. _exec-array.get_sx:

$${rule-prose: exec/array.get}

.. todo::
   Below is the actual prose.
   (3) Introduce if-let instruction instead of "is of the case".
   (5) Use "the expansion of" instead of $expand function application.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-array.get>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-array.get>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is an :ref:`array type <syntax-arraytype>`.

5. Let :math:`\TARRAY~\X{ft}` be the :ref:`expanded <aux-expand-deftype>` :ref:`array type <syntax-arraytype>` of :math:`\deftype`.

6. Assert: due to :ref:`validation <valid-array.get>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`\I32` is on the top of the stack.

7. Pop the value :math:`\I32.\CONST~i` from the stack.

8. Assert: due to :ref:`validation <valid-array.get>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`(\REF~\NULL~x)` is on the top of the stack.

9. Pop the value :math:`\reff` from the stack.

10. If :math:`\reff` is :math:`\REFNULL~t`, then:

   a. Trap.

11. Assert: due to :ref:`validation <valid-array.get>`, :math:`\reff` is an :ref:`array reference <syntax-ref.array>`.

12. Let :math:`\REFARRAYADDR~a` be the reference value :math:`\reff`.

13. Assert: due to :ref:`validation <valid-array.get>`, the :ref:`array instance <syntax-arrayinst>` :math:`S.\SARRAYS[a]` exists.

14. If :math:`n` is larger than or equal to the length of :math:`S.\SARRAYS[a].\AIFIELDS`, then:

    a. Trap.

15. Let :math:`\fieldval` be the :ref:`field value <syntax-fieldval>` :math:`S.\SARRAYS[a].\AIFIELDS[i]`.

16. Let :math:`\val` be the result of computing :math:`\unpackfield^{\sx^?}_{\X{ft}}(\fieldval))`.

17. Push the value :math:`\val` to the stack.

$${rule: {Step_read/array.get-*}}


.. _exec-array.set:

$${rule-prose: exec/array.set}

.. todo::
   Below is the actual prose.
   (3) Introduce if-let instruction instead of "is of the case".
   (5) Use "the expansion of" instead of $expand function application.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-array.set>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-array.set>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is an :ref:`array type <syntax-arraytype>`.

5. Let :math:`\TARRAY~\X{ft}` be the :ref:`expanded <aux-expand-deftype>` :ref:`array type <syntax-arraytype>` of :math:`\deftype`.

6. Assert: due to :ref:`validation <valid-array.set>`, a :ref:`value <syntax-val>` is on the top of the stack.

7. Pop the value :math:`\val` from the stack.

8. Assert: due to :ref:`validation <valid-array.set>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`\I32` is on the top of the stack.

9. Pop the value :math:`\I32.\CONST~i` from the stack.

10. Assert: due to :ref:`validation <valid-array.set>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`(\REF~\NULL~x)` is on the top of the stack.

11. Pop the value :math:`\reff` from the stack.

12. If :math:`\reff` is :math:`\REFNULL~t`, then:

   a. Trap.

13. Assert: due to :ref:`validation <valid-array.set>`, :math:`\reff` is an :ref:`array reference <syntax-ref.array>`.

14. Let :math:`\REFARRAYADDR~a` be the reference value :math:`\reff`.

15. Assert: due to :ref:`validation <valid-array.set>`, the :ref:`array instance <syntax-arrayinst>` :math:`S.\SARRAYS[a]` exists.

16. If :math:`n` is larger than or equal to the length of :math:`S.\SARRAYS[a].\AIFIELDS`, then:

    a. Trap.

17. Let :math:`\fieldval` be the result of computing :math:`\packfield_{\X{ft}}(\val))`.

18. Replace the :ref:`field value <syntax-fieldval>` :math:`S.\SARRAYS[a].\AIFIELDS[i]` with :math:`\fieldval`.

$${rule: {Step/array.set-*}}


.. _exec-array.len:

$${rule-prose: exec/array.len}

.. todo:: (3) Introduce if-let instruction instead of "is of the case".

$${rule: {Step_read/array.len-*}}


.. _exec-array.fill:

$${rule-prose: exec/array.fill}

.. todo:: (3) Introduce if-let instruction instead of "is of the case".

$${rule: {Step_read/array.fill-*}}


.. _exec-array.copy:

$${rule-prose: exec/array.copy}

.. todo::
   Below is the actual prose.
   (3) Introduce if-let instruction instead of "is of the case".
   (5) Use "the expansion of" instead of $expand function application.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-array.copy>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[y]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[y]`.

4. Assert: due to :ref:`validation <valid-array.copy>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is an :ref:`array type <syntax-arraytype>`.

5. Let :math:`\TARRAY~\mut~\X{st}` be the :ref:`expanded <aux-expand-deftype>` :ref:`array type <syntax-arraytype>` :math:`\deftype`.

6. Assert: due to :ref:`validation <valid-array.copy>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`\I32` is on the top of the stack.

7. Pop the value :math:`\I32.\CONST~n` from the stack.

8. Assert: due to :ref:`validation <valid-array.copy>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`\I32` is on the top of the stack.

9. Pop the value :math:`\I32.\CONST~s` from the stack.

10. Assert: due to :ref:`validation <valid-array.copy>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`(\REF~\NULL~y)` is on the top of the stack.

11. Pop the value :math:`\reff_2` from the stack.

12. Assert: due to :ref:`validation <valid-array.copy>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`\I32` is on the top of the stack.

13. Pop the value :math:`\I32.\CONST~d` from the stack.

14. Assert: due to :ref:`validation <valid-array.copy>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`(\REF~\NULL~x)` is on the top of the stack.

15. Pop the value :math:`\reff_1` from the stack.

16. If :math:`\reff_1` is :math:`\REFNULL~t`, then:

   a. Trap.

17. Assert: due to :ref:`validation <valid-array.copy>`, :math:`\reff_1` is an :ref:`array reference <syntax-ref.array>`.

18. Let :math:`\REFARRAYADDR~a_1` be the reference value :math:`\reff_1`.

19. If :math:`\reff_2` is :math:`\REFNULL~t`, then:

   a. Trap.

20. Assert: due to :ref:`validation <valid-array.copy>`, :math:`\reff_2` is an :ref:`array reference <syntax-ref.array>`.

21. Let :math:`\REFARRAYADDR~a_2` be the reference value :math:`\reff_2`.

22. Assert: due to :ref:`validation <valid-array.copy>`, the :ref:`array instance <syntax-arrayinst>` :math:`S.\SARRAYS[a_1]` exists.

23. Assert: due to :ref:`validation <valid-array.copy>`, the :ref:`array instance <syntax-arrayinst>` :math:`S.\SARRAYS[a_2]` exists.

24. If :math:`d + n` is larger than the length of :math:`S.\SARRAYS[a_1].\AIFIELDS`, then:

    a. Trap.

25. If :math:`s + n` is larger than the length of :math:`S.\SARRAYS[a_2].\AIFIELDS`, then:

    a. Trap.

26. If :math:`n = 0`, then:

    a. Return.

27. If :math:`d \leq s`, then:

    a. Push the value :math:`\REFARRAYADDR~a_1` to the stack.

    b. Push the value :math:`\I32.\CONST~d` to the stack.

    c. Push the value :math:`\REFARRAYADDR~a_2` to the stack.

    d. Push the value :math:`\I32.\CONST~s` to the stack.

    e. Execute :math:`\F{getfield}(\X{st})`.

    f. Execute the instruction :math:`\ARRAYSET~x`.

    g. Push the value :math:`\REFARRAYADDR~a_1` to the stack.

    h. Assert: due to the earlier check against the array size, :math:`d+1 < 2^{32}`.

    i. Push the value :math:`\I32.\CONST~(d+1)` to the stack.

    j. Push the value :math:`\REFARRAYADDR~a_2` to the stack.

    k. Assert: due to the earlier check against the array size, :math:`s+1 < 2^{32}`.

    l. Push the value :math:`\I32.\CONST~(s+1)` to the stack.

28. Else:

    a. Push the value :math:`\REFARRAYADDR~a_1` to the stack.

    b. Assert: due to the earlier check against the array size, :math:`d+n-1 < 2^{32}`.

    c. Push the value :math:`\I32.\CONST~(d+n-1)` to the stack.

    d. Push the value :math:`\REFARRAYADDR~a_2` to the stack.

    e. Assert: due to the earlier check against the array size, :math:`s+n-1 < 2^{32}`.

    f. Push the value :math:`\I32.\CONST~(s+n-1)` to the stack.

    g. Execute :math:`\F{getfield}(\X{st})`.

    h. Execute the instruction :math:`\ARRAYSET~x`.

    i. Push the value :math:`\REFARRAYADDR~a_1` to the stack.

    j. Push the value :math:`\I32.\CONST~d` to the stack.

    k. Push the value :math:`\REFARRAYADDR~a_2` to the stack.

    l. Push the value :math:`\I32.\CONST~s` to the stack.

29. Push the value :math:`\I32.\CONST~(n-1)` to the stack.

30. Execute the instruction :math:`\ARRAYCOPY~x~y`.

$${rule: {Step_read/array.copy-*}}

Where:

.. _aux-sx:

$${definition: sx}

.. _exec-array.init_data:

$${rule-prose: exec/array.init_data}

.. todo::
   Below is the actual prose.
   (7) Render $inverse_ with display hint.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-array.init_data>`, the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]` exists.

3. Let :math:`\deftype` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[x]`.

4. Assert: due to :ref:`validation <valid-array.init_data>`, the :ref:`expansion <aux-expand-deftype>` of :math:`\deftype` is an :ref:`array type <syntax-arraytype>`.

5. Let :math:`\TARRAY~\X{ft}` be the :ref:`expanded <aux-expand-deftype>` :ref:`array type <syntax-arraytype>` :math:`\deftype`.

6. Assert: due to :ref:`validation <valid-array.init_data>`, the :ref:`data address <syntax-dataaddr>` :math:`F.\AMODULE.\MIDATAS[y]` exists.

7. Let :math:`\X{da}` be the :ref:`data address <syntax-dataaddr>` :math:`F.\AMODULE.\MIDATAS[y]`.

8. Assert: due to :ref:`validation <valid-array.init_data>`, the :ref:`data instance <syntax-datainst>` :math:`S.\SDATAS[\X{da}]` exists.

9. Let :math:`\datainst` be the :ref:`data instance <syntax-datainst>` :math:`S.\SDATAS[\X{da}]`.

10. Assert: due to :ref:`validation <valid-array.init_data>`, three values of type :math:`\I32` are on the top of the stack.

11. Pop the value :math:`\I32.\CONST~n` from the stack.

12. Pop the value :math:`\I32.\CONST~s` from the stack.

13. Pop the value :math:`\I32.\CONST~d` from the stack.

14. Assert: due to :ref:`validation <valid-array.init_data>`, a :ref:`value <syntax-val>` of :ref:`type <syntax-valtype>` :math:`(\REF~\NULL~x)` is on the top of the stack.

15. Pop the value :math:`\reff` from the stack.

16. If :math:`\reff` is :math:`\REFNULL~t`, then:

   a. Trap.

17. Assert: due to :ref:`validation <valid-array.init_data>`, :math:`\reff` is an :ref:`array reference <syntax-ref.array>`.

18. Let :math:`\REFARRAYADDR~a` be the reference value :math:`\reff`.

19. Assert: due to :ref:`validation <valid-array.init_data>`, the :ref:`array instance <syntax-arrayinst>` :math:`S.\SARRAYS[a]` exists.

20. Assert: due to :ref:`validation <valid-array.init_data>`, the :ref:`field type <syntax-fieldtype>` :math:`\X{ft}` has a defined :ref:`bit width <bitwidth-fieldtype>`.

21. Let :math:`z` be the :ref:`bit width <bitwidth-fieldtype>` of :ref:`field type <syntax-fieldtype>` :math:`\X{ft}` divided by eight.

22. If :math:`d + n` is larger than the length of :math:`S.\SARRAYS[a].\AIFIELDS`, or the sum of :math:`s` and :math:`n` times :math:`z` is larger than the length of :math:`\datainst.\DIBYTES`, then:

    a. Trap.

23. If :math:`n = 0`, then:

    a. Return.

24. Let :math:`b^\ast` be the :ref:`byte <syntax-byte>` sequence :math:`\datainst.\DIBYTES[s \slice z]`.

25. Let :math:`t` be the :ref:`value type <syntax-valtype>` :math:`\unpack(\X{ft})`.

26. Assert: due to :ref:`validation <valid-array.init_data>`, :math:`\bytes_{\X{ft}}` is defined.

27. Let :math:`c` be the constant for which :math:`\bytes_{\X{ft}}(c)` is :math:`b^\ast`.

28. Push the value :math:`\REFARRAYADDR~a` to the stack.

29. Push the value :math:`\I32.\CONST~d` to the stack.

30. Push the value :math:`t.\CONST~c` to the stack.

31. Execute the instruction :math:`\ARRAYSET~x`.

32. Push the value :math:`\REFARRAYADDR~a` to the stack.

33. Push the value :math:`\I32.\CONST~(d+1)` to the stack.

34. Push the value :math:`\I32.\CONST~(s+z)` to the stack.

35. Push the value :math:`\I32.\CONST~(n-1)` to the stack.

36. Execute the instruction :math:`\ARRAYINITDATA~x~y`.

$${rule: {Step_read/array.init_data-*}}


.. _exec-array.init_elem:

$${rule-prose: exec/array.init_elem}

.. todo:: (3) Introduce if-let instruction instead of "is of the case".

$${rule: {Step_read/array.init_elem-*}}


.. _exec-any.convert_extern:

$${rule-prose: exec/any.convert_extern}

.. todo:: (3) Introduce if-let instruction instead of "is of the case".

$${rule: {Step_pure/any.convert_extern-*}}


.. _exec-extern.convert_any:

$${rule-prose: exec/extern.convert_any}

.. todo:: (3) Introduce if-let instruction instead of "is of the case".

$${rule: {Step_pure/extern.convert_any-*}}


.. index:: vector instruction
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-vec:

Vector Instructions
~~~~~~~~~~~~~~~~~~~

Vector instructions that operate bitwise are handled as integer operations of respective width.

.. math::
   \begin{array}{lll@{\qquad}l}
   \X{op}_{\VN}(i_1,\dots,i_k) &=& \xref{exec/numerics}{int-ops}{\F{i}\X{op}}_N(i_1,\dots,i_k) \\
   \end{array}

Most other vector instructions are defined in terms of numeric operators that are applied lane-wise according to the given :ref:`shape <syntax-shape>`.

.. math::
   \begin{array}{llll}
   \X{op}_{t\K{x}N}(n_1,\dots,n_k) &=&
     \lanes^{-1}_{t\K{x}N}(\xref{exec/instructions}{exec-instr-numeric}{\X{op}}_t(i_1,\dots,i_k)^\ast) & \qquad(\iff i_1^\ast = \lanes_{t\K{x}N}(n_1) \land \dots \land i_k^\ast = \lanes_{t\K{x}N}(n_k) \\
   \end{array}

.. note::
   For example, the result of instruction :math:`\K{i32x4}.\ADD` applied to operands :math:`v_1, v_2`
   invokes :math:`\ADD_{\K{i32x4}}(v_1, v_2)`, which maps to
   :math:`\lanes^{-1}_{\K{i32x4}}(\ADD_{\I32}(i_1, i_2)^\ast)`,
   where :math:`i_1^\ast` and :math:`i_2^\ast` are sequences resulting from invoking
   :math:`\lanes_{\K{i32x4}}(v_1)` and :math:`\lanes_{\K{i32x4}}(v_2)`
   respectively.


.. _exec-vconst:

:math:`\V128\K{.}\VCONST~c`
...........................

1. Push the value :math:`\V128.\VCONST~c` to the stack.

.. note::
   No formal reduction rule is required for this instruction, since |VCONST| instructions coincide with :ref:`values <syntax-val>`.


.. _exec-vvunop:

$${rule-prose: exec/vvunop}

$${rule: {Step_pure/vvunop}}


.. _exec-vvbinop:

$${rule-prose: exec/vvbinop}

$${rule: {Step_pure/vvbinop}}


.. _exec-vvternop:

$${rule-prose: exec/vvternop}

$${rule: {Step_pure/vvternop}}


.. _exec-vvtestop:

$${rule-prose: exec/vvtestop}

$${rule: {Step_pure/vvtestop}}


.. _exec-vunop:

$${rule-prose: exec/vunop}

$${rule: {Step_pure/vunop}}


.. _exec-vbinop:

$${rule-prose: exec/vbinop}

.. todo:: (2) SpecTec currently defines the image of vbinop as a sequence, not a set.

$${rule: {Step_pure/vbinop-*}}


.. _exec-vtestop:

$${rule-prose: exec/vtestop}

$${rule: {Step_pure/vtestop-*}}


.. _exec-vrelop:

$${rule-prose: exec/vrelop}

.. todo::
   Below is the actual prose.

1. Assert: due to :ref:`validation <valid-vrelop>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. Let :math:`i_1^\ast` be the result of computing :math:`\lanes_{t\K{x}N}(c_1)`.

5. Let :math:`i_2^\ast` be the result of computing :math:`\lanes_{t\K{x}N}(c_2)`.

6. Let :math:`i^\ast` be the result of computing :math:`\vrelop_t(i_1^\ast, i_2^\ast)`.

7. Let :math:`j^\ast` be the result of computing :math:`\exts_{1,|t|}(i^\ast)`.

8. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{t\K{x}N}(j^\ast)`.

9. Push the value :math:`\V128.\VCONST~c` to the stack.

$${rule: {Step_pure/vrelop}}

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~t\K{x}N\K{.}\vrelop &\stepto& (\V128\K{.}\VCONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff c = \lanes^{-1}_{t\K{x}N}(\exts_{1,|t|}(\vrelop_t(\lanes_{t\K{x}N}(c_1), \lanes_{t\K{x}N}(c_2)))))
     \end{array}
   \end{array}

.. _exec-vshiftop:

$${rule-prose: exec/vshiftop}

.. todo::
   Below is the actual prose.

1. Assert: due to :ref:`validation <valid-vshiftop>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

2. Pop the value :math:`\I32.\CONST~s` from the stack.

3. Assert: due to :ref:`validation <valid-vshiftop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

4. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

5. Let :math:`i^\ast` be the result of computing :math:`\lanes_{t\K{x}N}(c_1)`.

6. Let :math:`j^\ast` be the result of computing :math:`\vishiftop_{t}(i^\ast, s^N)`.

7. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{t\K{x}N}(j^\ast)`.

8. Push the value :math:`\V128.\VCONST~c` to the stack.

$${rule: {Step_pure/vshiftop}}

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\I32\K{.}\CONST~s)~t\K{x}N\K{.}\vishiftop &\stepto& (\V128\K{.}\VCONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & i^\ast = \lanes_{t\K{x}N}(c_1) \\
     \wedge & c = \lanes^{-1}_{t\K{x}N}(\vishiftop_{t}(i^\ast, s^N)))
     \end{array}
   \end{array}


.. _exec-vbitmask:

$${rule-prose: exec/vbitmask}

.. todo::
   Below is the actual prose.

1. Assert: due to :ref:`validation <valid-vbitmask>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c` from the stack.

3. Let :math:`i_1^N` be the result of computing :math:`\lanes_{t\K{x}N}(c)`.

4. Let :math:`B` be the :ref:`bit width <syntax-valtype>` :math:`|t|` of :ref:`value type <syntax-valtype>` :math:`t`.

5. Let :math:`i_2^N` be the result of computing :math:`\ilts_{B}(i_1^N, 0^N)`.

6. Let :math:`j^\ast` be the concatenation of the two sequences :math:`i_2^N` and :math:`0^{32-N}`.

7. Let :math:`i` be the result of computing :math:`\ibits_{32}^{-1}(j^\ast)`.

8. Push the value :math:`\I32.\CONST~i` onto the stack.

$${rule: {Step_pure/vbitmask}}

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c)~t\K{x}N\K{.}\VBITMASK &\stepto& (\I32\K{.}\CONST~i)
     & (\iff i = \ibits_{32}^{-1}(\ilts_{|t|}(\lanes_{t\K{x}N}(c), 0^N)))
     \\
   \end{array}


.. _exec-vswizzle:

$${rule-prose: exec/vswizzle}

.. todo::
   Below is the actual prose.

1. Assert: due to :ref:`validation <valid-vbinop>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

3. Let :math:`i^\ast` be the result of computing :math:`\lanes_{\I8X16}(c_2)`.

4. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

5. Let :math:`j^\ast` be the result of computing :math:`\lanes_{\I8X16}(c_1)`.

6. Let :math:`c^\ast` be the concatenation of the two sequences :math:`j^\ast` and :math:`0^{240}`.

7. Let :math:`c'` be the result of computing :math:`\lanes^{-1}_{\I8X16}(c^\ast[ i^\ast[0] ] \dots c^\ast[ i^\ast[15] ])`.

8. Push the value :math:`\V128.\VCONST~c'` onto the stack.

$${rule: {Step_pure/vswizzle}}

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~\I8X16\K{.}\VSWIZZLE &\stepto& (\V128\K{.}\VCONST~c')
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & i^\ast = \lanes_{\I8X16}(c_2) \\
      \wedge & c^\ast = \lanes_{\I8X16}(c_1)~0^{240} \\
      \wedge & c' = \lanes^{-1}_{\I8X16}(c^\ast[ i^\ast[0] ] \dots c^\ast[ i^\ast[15] ]))
     \end{array}
   \end{array}


.. _exec-vshuffle:

$${rule-prose: exec/vshuffle}

.. todo::
   Below is the actual prose.

1. Assert: due to :ref:`validation <valid-vshuffle>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Assert: due to :ref:`validation <valid-vshuffle>`, for all :math:`x_i` in :math:`x^\ast` it holds that :math:`x_i < 32`.

3. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

4. Let :math:`i_2^\ast` be the result of computing :math:`\lanes_{\I8X16}(c_2)`.

5. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

6. Let :math:`i_1^\ast` be the result of computing :math:`\lanes_{\I8X16}(c_1)`.

7. Let :math:`i^\ast` be the concatenation of the two sequences :math:`i_1^\ast` and :math:`i_2^\ast`.

8. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{\I8X16}(i^\ast[x^\ast[0]] \dots i^\ast[x^\ast[15]])`.

9. Push the value :math:`\V128.\VCONST~c` onto the stack.

$${rule: {Step_pure/vshuffle}}

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~(\I8X16\K{.}\VSHUFFLE~x^\ast) &\stepto& (\V128\K{.}\VCONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & i^\ast = \lanes_{\I8X16}(c_1)~\lanes_{\I8X16}(c_2) \\
      \wedge & c = \lanes^{-1}_{\I8X16}(i^\ast[x^\ast[0]] \dots i^\ast[x^\ast[15]]))
     \end{array}
   \end{array}


.. _exec-vsplat:

$${rule-prose: exec/vsplat}

.. todo::
   Below is the actual prose.

1. Let :math:`t` be the type :math:`\unpackshape(\shape)`.

2. Assert: due to :ref:`validation <valid-vsplat>`, a value of :ref:`value type <syntax-valtype>` :math:`t` is on the top of the stack.

3. Pop the value :math:`t.\CONST~c_1` from the stack.

4. Let :math:`N` be the integer :math:`\shdim(\shape)`.

5. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{\shape}(c_1^N)`.

6. Push the value :math:`\V128.\VCONST~c` to the stack.

$${rule: {Step_pure/vsplat}}

.. math::
   \begin{array}{lcl@{\qquad}l}
   (t\K{.}\CONST~c_1)~\shape\K{.}\VSPLAT &\stepto& (\V128\K{.}\VCONST~c)
     & (\iff t = \unpackshape(\shape)
       \wedge c = \lanes^{-1}_{\shape}(c_1^{\shdim(\shape)}))
     \\
   \end{array}


.. _exec-vextract_lane:

$${rule-prose: exec/vextract_lane}

.. todo::
   Below is the actual prose.

1. Assert: due to :ref:`validation <valid-vextract_lane>`, :math:`x < N`.

2. Assert: due to :ref:`validation <valid-vextract_lane>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. Let :math:`i^\ast` be the result of computing :math:`\lanes_{t_1\K{x}N}(c_1)`.

5. Let :math:`t_2` be the type :math:`\unpackshape(t_1\K{x}N)`.

6. Let :math:`c_2` be the result of computing :math:`\ext^{sx^?}_{t_1,t_2}(i^\ast[x])`.

7. Push the value :math:`t_2.\CONST~c_2` to the stack.

$${rule: {Step_pure/vextract_lane-*}}

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(t_1\K{x}N\K{.}\VEXTRACTLANE~x) &\stepto& (t_2\K{.}\CONST~c_2)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & t_2 = \unpackshape(t_1\K{x}N) \\
       \wedge & c_2 = \ext^{sx^?}_{t_1,t_2}(\lanes_{t_1\K{x}N}(c_1)[x]))
     \end{array}
   \end{array}


.. _exec-vreplace_lane:

$${rule-prose: exec/vreplace_lane}

.. todo::
   Below is the actual prose.

1. Assert: due to :ref:`validation <valid-vreplace_lane>`, :math:`x < \shdim(\shape)`.

2. Let :math:`t_2` be the type :math:`\unpackshape(\shape)`.

3. Assert: due to :ref:`validation <valid-vreplace_lane>`, a value of :ref:`value type <syntax-valtype>` :math:`t_1` is on the top of the stack.

4. Pop the value :math:`t_2.\CONST~c_2` from the stack.

5. Assert: due to :ref:`validation <valid-vreplace_lane>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

6. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

7. Let :math:`i^\ast` be the result of computing :math:`\lanes_{\shape}(c_1)`.

8. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{\shape}(i^\ast \with [x] = c_2)`.

9. Push :math:`\V128.\VCONST~c` on the stack.

$${rule: {Step_pure/vreplace_lane}}

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(t_2\K{.}\CONST~c_2)~(\shape\K{.}\VREPLACELANE~x) &\stepto& (\V128\K{.}\VCONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
      (\iff & i^\ast = \lanes_{\shape}(c_1) \\
       \wedge & c = \lanes^{-1}_{\shape}(i^\ast \with [x] = c_2))
     \end{array}
   \end{array}


.. _exec-vextadd_pairwise:

$${rule-prose: exec/vextunop}

.. todo::
   Below is the actual prose.

1. Assert: due to :ref:`syntax <syntax-instr-vec>`, :math:`N = M / 2`.

2. Assert: due to :ref:`validation <valid-vextunop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. Let :math:`i^\ast` be the result of computing :math:`\lanes_{t_1\K{x}M}(c_1)`.

5. Let :math:`(j_1~j_2)^\ast` be the result of computing :math:`\ext^{\sx}_{|t_1|,|t_2|}(i^\ast)`.

6. Let :math:`k^\ast` be the result of computing :math:`\iadd_{|t_2|}(j_1, j_2)^\ast`.

7. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{t_2\K{x}N}(k^\ast)`.

8. Push the value :math:`\V128.\VCONST~c` to the stack.

$${rule: {Step_pure/vextunop}}

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~t_2\K{x}N\K{.}\VEXTADDPAIRWISE\_t_1\K{x}M\_\sx &\stepto& (\V128\K{.}\VCONST~c) \\
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & (i_1~i_2)^\ast = \ext^{\sx}_{|t_1|,|t_2|}(\lanes_{t_1\K{x}M}(c_1)) \\
     \wedge & j^\ast = \iadd_{|t_2|}(i_1, i_2)^\ast \\
     \wedge & c = \lanes^{-1}_{t_2\K{x}N}(j^\ast))
     \end{array}
   \end{array}


.. _exec-vextmul:

$${rule-prose: exec/vextbinop}

.. todo::
   Below is the actual prose.

1. Assert: due to :ref:`syntax <syntax-instr-vec>`, :math:`N = M / 2`.

2. Assert: due to :ref:`validation <valid-vbinop>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

3. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

4. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

5. Let :math:`i_1^\ast` be the result of computing :math:`\lanes_{t_1\K{x}M}(c_1)`.

6. Let :math:`i_2^\ast` be the result of computing :math:`\lanes_{t_1\K{x}M}(c_2)`.

7. If :math:`\half` is :math:`\K{low}`, then:

   a. Let :math:`j_1^\ast` be the sequence :math:`i_1^\ast[0 \slice N]`.

   b. Let :math:`j_2^\ast` be the sequence :math:`i_2^\ast[0 \slice N]`.

8. Else:

   a. Let :math:`j_1^\ast` be the sequence :math:`i_1^\ast[N \slice N]`.

   b. Let :math:`j_2^\ast` be the sequence :math:`i_2^\ast[N \slice N]`.

9. Let :math:`k_1^\ast` be the result of computing :math:`\ext^{\sx}_{|t_1|,|t_2|}(j_1^\ast)`.

10. Let :math:`k_2^\ast` be the result of computing :math:`\ext^{\sx}_{|t_1|,|t_2|}(j_2^\ast)`.

11. Let :math:`k^\ast` be the result of computing :math:`\imul_{|t_2|}(k_1^\ast, k_2^\ast)`.

12. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{t_2\K{x}N}(k^\ast)`.

13. Push the value :math:`\V128.\VCONST~c` onto the stack.

$${rule: {Step_pure/vextbinop}}

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~t_2\K{x}N\K{.}\VEXTMUL\K{\_}\half\K{\_}t_1\K{x}M\_\sx &\stepto& (\V128\K{.}\VCONST~c) \\
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & i^\ast = \lanes_{t_1\K{x}M}(c_1)[\half(0, N) \slice N] \\
     \wedge & j^\ast = \lanes_{t_1\K{x}M}(c_2)[\half(0, N) \slice N] \\
     \wedge & c = \lanes^{-1}_{t_2\K{x}N}(\imul_{|t_2|}(\ext^{\sx}_{|t_1|,|t_2|}(i^\ast), \ext^{\sx}_{|t_1|,|t_2|}(j^\ast))))
     \end{array}

where:

.. math::
   \begin{array}{lcl}
   \K{low}(x, y) &=& x \\
   \K{high}(x, y) &=& y \\
   \end{array}


.. _exec-vdot:

:math:`\K{i32x4.}\VDOT\K{\_i16x8\_s}`
.....................................

.. todo:: (*) Prose not spliced, for this seems to be WIP on @Andreas.

1. Assert: due to :ref:`validation <valid-vextbinop>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

2. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. Let :math:`i_1^\ast` be the result of computing :math:`\lanes_{\I16X8}(c_1)`.

5. Let :math:`j_1^\ast` be the result of computing :math:`\exts_{16,32}(i_1^\ast)`.

6. Let :math:`i_2^\ast` be the result of computing :math:`\lanes_{\I16X8}(c_2)`.

7. Let :math:`j_2^\ast` be the result of computing :math:`\exts_{16,32}(i_2^\ast)`.

8. Let :math:`(k_1~k_2)^\ast` be the result of computing :math:`\imul_{32}(j_1^\ast, j_2^\ast)`.

9. Let :math:`k^\ast` be the result of computing :math:`\iadd_{32}(k_1, k_2)^\ast`.

10. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{\I32X4}(k^\ast)`.

11. Push the value :math:`\V128.\VCONST~c` onto the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~\K{i32x4.}\VDOT\K{\_i16x8\_s} &\stepto& (\V128\K{.}\VCONST~c) \\
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & (i_1~i_2)^\ast = \imul_{32}(\exts_{16,32}(\lanes_{\I16X8}(c_1)), \exts_{16,32}(\lanes_{\I16X8}(c_2))) \\
     \wedge & j^\ast = \iadd_{32}(i_1, i_2)^\ast \\
     \wedge & c = \lanes^{-1}_{\I32X4}(j^\ast))
     \end{array}
   \end{array}


.. _exec-vnarrow:

$${rule-prose: exec/vnarrow}

.. todo::
   Below is the actual prose.

1. Assert: due to :ref:`syntax <syntax-instr-vec>`, :math:`N = 2\cdot M`.

2. Assert: due to :ref:`validation <valid-vnarrow>`, two values of :ref:`value type <syntax-valtype>` |V128| are on the top of the stack.

3. Pop the value :math:`\V128.\VCONST~c_2` from the stack.

4. Let :math:`i_2^M` be the result of computing :math:`\lanes_{t_1\K{x}M}(c_2)`.

5. Let :math:`d_2^M` be the result of computing :math:`\narrow^{\sx}_{|t_1|,|t_2|}(i_2^M)`.

6. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

7. Let :math:`i_1^M` be the result of computing :math:`\lanes_{t_1\K{x}M}(c_1)`.

8. Let :math:`d_1^M` be the result of computing :math:`\narrow^{\sx}_{|t_1|,|t_2|}(i_1^M)`.

9. Let :math:`j^N` be the concatenation of the two sequences :math:`d_1^M` and :math:`d_2^M`.

10. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{t_2\K{x}N}(j^N)`.

11. Push the value :math:`\V128.\VCONST~c` onto the stack.

$${rule: {Step_pure/vnarrow}}

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~(\V128\K{.}\VCONST~c_2)~t_2\K{x}N\K{.}\VNARROW\_t_1\K{x}M\_\sx &\stepto& (\V128\K{.}\VCONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & d_1^M = \narrow^{\sx}_{|t_1|,|t_2|}( \lanes_{t_1\K{x}M}(c_1)) \\
     \wedge & d_2^M = \narrow^{\sx}_{|t_1|,|t_2|}( \lanes_{t_1\K{x}M}(c_2)) \\
     \wedge & c = \lanes^{-1}_{t_2\K{x}N}(d_1^M~d_2^M))
     \end{array}
   \end{array}


.. _exec-vcvtop:

:math:`t_2\K{x}N\K{.}\vcvtop\K{\_}t_1\K{x}M\K{\_}\sx`
.....................................................

.. todo:: (*) Prose not spliced, for it has merged multiple rules for vcvtop into one algorithm.

1. Assert: due to :ref:`syntax <syntax-instr-vec>`, :math:`N = M`.

2. Assert: due to :ref:`validation <valid-vcvtop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. Let :math:`i^\ast` be the result of computing :math:`\lanes_{t_1\K{x}M}(c_1)`.

5. Let :math:`j^\ast` be the result of computing :math:`\vcvtop^{\sx}_{|t_1|,|t_2|}(i^\ast)`.

6. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{t_2\K{x}N}(j^\ast)`.

7. Push the value :math:`\V128.\VCONST~c` onto the stack.

$${rule: {Step_pure/vcvtop-full}}

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~t_2\K{x}N\K{.}\vcvtop\K{\_}t_1\K{x}M\K{\_}\sx &\stepto& (\V128\K{.}\VCONST~c) \\
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & c = \lanes^{-1}_{t_2\K{x}N}(\vcvtop^{\sx}_{|t_1|,|t_2|}(\lanes_{t_1\K{x}M}(c_1))))
     \end{array}
   \end{array}


:math:`t_2\K{x}N\K{.}\vcvtop\K{\_}\half\K{\_}t_1\K{x}M\K{\_}\sx^?`
..................................................................

.. todo:: (*) Prose not spliced, for it has merged multiple rules for vcvtop into one algorithm.

1. Assert: due to :ref:`syntax <syntax-instr-vec>`, :math:`N = M / 2`.

2. Assert: due to :ref:`validation <valid-vcvtop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. Let :math:`i^\ast` be the result of computing :math:`\lanes_{t_1\K{x}M}(c_1)`.

5. If :math:`\half` is :math:`\K{low}`, then:

   a. Let :math:`j^\ast` be the sequence :math:`i^\ast[0 \slice N]`.

6. Else:

   a. Let :math:`j^\ast` be the sequence :math:`i^\ast[N \slice N]`.

7. Let :math:`k^\ast` be the result of computing :math:`\vcvtop^{\sx^?}_{|t_1|,|t_2|}(j^\ast)`.

8. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{t_2\K{x}N}(k^\ast)`.

9. Push the value :math:`\V128.\VCONST~c` onto the stack.

$${rule: {Step_pure/vcvtop-half}}

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~t_2\K{x}N\K{.}\vcvtop\K{\_}\half\K{\_}t_1\K{x}M\K{\_}\sx^? &\stepto& (\V128\K{.}\VCONST~c) \\
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & c = \lanes^{-1}_{t_2\K{x}N}(\vcvtop^{\sx^?}_{|t_1|,|t_2|}(\lanes_{t_1\K{x}M}(c_1)[\half(0, N) \slice N])))
     \end{array}
   \end{array}

where:

.. math::
   \begin{array}{lcl}
   \K{low}(x, y) &=& x \\
   \K{high}(x, y) &=& y \\
   \end{array}


:math:`t_2\K{x}N\K{.}\vcvtop\K{\_}t_1\K{x}M\K{\_}\sx^?\K{\_zero}`
.................................................................

.. todo:: (*) Prose not spliced, for it has merged multiple rules for vcvtop into one algorithm.

1. Assert: due to :ref:`syntax <syntax-instr-vec>`, :math:`N = 2 \cdot M`.

2. Assert: due to :ref:`validation <valid-vcvtop>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

3. Pop the value :math:`\V128.\VCONST~c_1` from the stack.

4. Let :math:`i^\ast` be the result of computing :math:`\lanes_{t_1\K{x}M}(c_1)`.

5. Let :math:`j^\ast` be the result of computing :math:`\vcvtop^{\sx^?}_{|t_1|,|t_2|}(i^\ast)`.

6. Let :math:`k^\ast` be the concatenation of the two sequences :math:`j^\ast` and :math:`0^M`.

7. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{t_2\K{x}N}(k^\ast)`.

8. Push the value :math:`\V128.\VCONST~c` onto the stack.

$${rule: {Step_pure/vcvtop-zero}}

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   (\V128\K{.}\VCONST~c_1)~t_2\K{x}N\K{.}\vcvtop\K{\_}t_1\K{x}M\K{\_}\sx^?\K{\_zero} &\stepto& (\V128\K{.}\VCONST~c) \\
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & c = \lanes^{-1}_{t_2\K{x}N}(\vcvtop^{\sx^?}_{|t_1|,|t_2|}(\lanes_{t_1\K{x}M}(c_1))~0^M))
     \end{array}
   \end{array}


.. index:: variable instructions, local index, global index, address, global address, global instance, store, frame, value
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-variable:

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _exec-local.get:

$${rule-prose: exec/local.get}

$${rule: Step_read/local.get}


.. _exec-local.set:

$${rule-prose: exec/local.set}

$${rule: Step/local.set}


.. _exec-local.tee:

$${rule-prose: exec/local.tee}

$${rule: Step_pure/local.tee}


.. _exec-global.get:

$${rule-prose: exec/global.get}

$${rule: Step_read/global.get}


.. _exec-global.set:

$${rule-prose: exec/global.set}

$${rule: Step/global.set}


.. index:: table instruction, table index, store, frame, address, table address, table instance, element address, element instance, value, integer, limits, reference, reference type
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-instr-table:

Table Instructions
~~~~~~~~~~~~~~~~~~

.. _exec-table.get:

$${rule-prose: exec/table.get}

$${rule: {Step_read/table.get-*}}


.. _exec-table.set:

$${rule-prose: exec/table.set}

$${rule: {Step/table.set-*}}


.. _exec-table.size:

$${rule-prose: exec/table.size}

$${rule: Step_read/table.size}


.. _exec-table.grow:

$${rule-prose: exec/table.grow}

.. todo:: (6) Maybe we want to be more precise than just saying "Either" in the prose, elaborating that it may succeed or fail non-deterministically.

$${rule: {Step/table.grow-*}}

.. note::
   The |TABLEGROW| instruction is non-deterministic.
   It may either succeed, returning the old table size :math:`\X{sz}`,
   or fail, returning :math:`{-1}`.
   Failure *must* occur if the referenced table instance has a maximum size defined that would be exceeded.
   However, failure *can* occur in other cases as well.
   In practice, the choice depends on the :ref:`resources <impl-exec>` available to the :ref:`embedder <embedder>`.

.. _exec-table.fill:

$${rule-prose: exec/table.fill}

$${rule: {Step_read/table.fill-*}}


.. _exec-table.copy:

$${rule-prose: exec/table.copy}

$${rule: {Step_read/table.copy-*}}


.. _exec-table.init:

$${rule-prose: exec/table.init}

$${rule: {Step_read/table.init-*}}


.. _exec-elem.drop:

$${rule-prose: exec/elem.drop}

$${rule: Step/elem.drop}


.. index:: memory instruction, memory index, store, frame, address, memory address, memory instance, value, integer, limits, value type, bit width
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-memarg:
.. _exec-instr-memory:

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. note::
   The alignment :math:`\memarg.\ALIGN` in load and store instructions does not affect the semantics.
   It is an indication that the offset :math:`\X{ea}` at which the memory is accessed is intended to satisfy the property :math:`\X{ea} \mod 2^{\memarg.\ALIGN} = 0`.
   A WebAssembly implementation can use this hint to optimize for the intended use.
   Unaligned access violating that property is still allowed and must succeed regardless of the annotation.
   However, it may be substantially slower on some hardware.


.. _exec-load-val:
.. _exec-load-pack:
.. _exec-vload-val:

$${rule-prose: exec/load}

.. todo::
   Below is the actual prose.
   (7) Render $inverse_of_nbytes with display hint.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-load-pack>`, :math:`F.\AMODULE.\MIMEMS[x]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[x]`.

4. Assert: due to :ref:`validation <valid-load-pack>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Assert: due to :ref:`validation <valid-load-pack>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

7. Pop the value :math:`\I32.\CONST~i` from the stack.

8. Let :math:`\X{ea}` be the integer :math:`i + \memarg.\OFFSET`.

9. If :math:`N` is not part of the instruction, then:

   a. Let :math:`N` be the :ref:`bit width <syntax-numtype>` :math:`|t|` of :ref:`number type <syntax-numtype>` :math:`t`.

10. If :math:`\X{ea} + N/8` is larger than the length of :math:`\X{mem}.\MIBYTES`, then:

    a. Trap.

11. Let :math:`b^\ast` be the byte sequence :math:`\X{mem}.\MIBYTES[\X{ea} \slice N/8]`.

12. If :math:`N` and :math:`\sx` are part of the instruction, then:

    a. Let :math:`n` be the integer for which :math:`\bytes_{\iN}(n) = b^\ast`.

    b. Let :math:`c` be the result of computing :math:`\ext^{\sx}_{N,|t|}(n)`.

13. Else:

    a. Let :math:`c` be the constant for which :math:`\bytes_t(c) = b^\ast`.

14. Push the value :math:`t.\CONST~c` to the stack.

$${rule: {Step_read/load-*}}


.. _exec-vload-pack:

:math:`\V128\K{.}\VLOAD{M}\K{x}N\_\sx~x~\memarg`
................................................

.. todo:: (*) Rule and prose both not spliced.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-vload-pack>`, :math:`F.\AMODULE.\MIMEMS[x]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[x]`.

4. Assert: due to :ref:`validation <valid-vload-pack>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Assert: due to :ref:`validation <valid-vload-pack>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

7. Pop the value :math:`\I32.\CONST~i` from the stack.

8. Let :math:`\X{ea}` be the integer :math:`i + \memarg.\OFFSET`.

9. If :math:`\X{ea} + M \cdot N /8` is larger than the length of :math:`\X{mem}.\MIBYTES`, then:

    a. Trap.

10. Let :math:`b^\ast` be the byte sequence :math:`\X{mem}.\MIBYTES[\X{ea} \slice M \cdot N /8]`.

11. Let :math:`m_k` be the integer for which :math:`\bytes_{\iM}(m_k) = b^\ast[k \cdot M/8 \slice M/8]`.

12. Let :math:`W` be the integer :math:`M \cdot 2`.

13. Let :math:`n_k` be the result of computing :math:`\ext^{\sx}_{M,W}(m_k)`.

14. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{\K{i}W\K{x}N}(n_0 \dots n_{N-1})`.

15. Push the value :math:`\V128.\CONST~c` to the stack.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\V128.\VLOAD{M}\K{x}N\_\sx~x~\memarg) &\stepto&
     S; F; (\V128.\CONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + M \cdot N / 8 \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIBYTES| \\
     \wedge & \bytes_{\iM}(m_k) = S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIBYTES[\X{ea} + k \cdot M/8 \slice M/8]) \\
     \wedge & W = M \cdot 2 \\
     \wedge & c = \lanes^{-1}_{\K{i}W\K{x}N}(\ext^{\sx}_{M,W}(m_0) \dots \ext^{\sx}_{M,W}(m_{N-1})))
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\V128.\VLOAD{M}\K{x}N\K{\_}\sx~x~\memarg) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise) \\
   \end{array}

$${rule: {Step_read/vload-pack-*}}


.. _exec-vload-splat:

:math:`\V128\K{.}\VLOAD{N}\K{\_splat}~x~\memarg`
................................................

.. todo:: (*) Rule and prose both not spliced.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-vload-splat>`, :math:`F.\AMODULE.\MIMEMS[x]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[x]`.

4. Assert: due to :ref:`validation <valid-vload-splat>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Assert: due to :ref:`validation <valid-vload-splat>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

7. Pop the value :math:`\I32.\CONST~i` from the stack.

8. Let :math:`\X{ea}` be the integer :math:`i + \memarg.\OFFSET`.

9. If :math:`\X{ea} + N/8` is larger than the length of :math:`\X{mem}.\MIBYTES`, then:

    a. Trap.

10. Let :math:`b^\ast` be the byte sequence :math:`\X{mem}.\MIBYTES[\X{ea} \slice N/8]`.

11. Let :math:`n` be the integer for which :math:`\bytes_{\iN}(n) = b^\ast`.

12. Let :math:`L` be the integer :math:`128 / N`.

13. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{\IN\K{x}L}(n^L)`.

14. Push the value :math:`\V128.\CONST~c` to the stack.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\V128\K{.}\VLOAD{N}\K{\_splat}~x~\memarg) &\stepto& S; F; (\V128.\CONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + N/8 \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIBYTES| \\
     \wedge & \bytes_{\iN}(n) = S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIBYTES[\X{ea} \slice N/8] \\
     \wedge & c = \lanes^{-1}_{\IN\K{x}L}(n^L))
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\V128.\VLOAD{N}\K{\_splat}~x~\memarg) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise) \\
   \end{array}

$${rule: {Step_read/vload-splat-*}}


.. _exec-vload-zero:

:math:`\V128\K{.}\VLOAD{N}\K{\_zero}~x~\memarg`
...............................................

.. todo:: (*) Rule and prose both not spliced.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-vload-zero>`, :math:`F.\AMODULE.\MIMEMS[x]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[x]`.

4. Assert: due to :ref:`validation <valid-vload-zero>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Assert: due to :ref:`validation <valid-vload-zero>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

7. Pop the value :math:`\I32.\CONST~i` from the stack.

8. Let :math:`\X{ea}` be the integer :math:`i + \memarg.\OFFSET`.

9. If :math:`\X{ea} + N/8` is larger than the length of :math:`\X{mem}.\MIBYTES`, then:

    a. Trap.

10. Let :math:`b^\ast` be the byte sequence :math:`\X{mem}.\MIBYTES[\X{ea} \slice N/8]`.

11. Let :math:`n` be the integer for which :math:`\bytes_{\iN}(n) = b^\ast`.

12. Let :math:`c` be the result of computing :math:`\extu_{N,128}(n)`.

13. Push the value :math:`\V128.\CONST~c` to the stack.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\V128\K{.}\VLOAD{N}\K{\_zero}~x~\memarg) &\stepto& S; F; (\V128.\CONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + N/8 \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIBYTES| \\
     \wedge & \bytes_{\iN}(n) = S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIBYTES[\X{ea} \slice N/8]) \\
     \wedge & c = \extu_{N,128}(n)
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\V128.\VLOAD{N}\K{\_zero}~x~\memarg) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise) \\
   \end{array}

$${rule: {Step_read/vload-zero-*}}


.. _exec-vload_lane:

:math:`\V128\K{.}\VLOAD{N}\K{\_lane}~x~\memarg~y`
.................................................

.. todo:: (*) Rule and prose both not spliced.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-vload_lane>`, :math:`F.\AMODULE.\MIMEMS[x]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[x]`.

4. Assert: due to :ref:`validation <valid-vload_lane>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Assert: due to :ref:`validation <valid-vload_lane>`, a value of :ref:`value type <syntax-valtype>` |V128| is on the top of the stack.

7. Pop the value :math:`\V128.\CONST~v` from the stack.

8. Assert: due to :ref:`validation <valid-vload_lane>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

9. Pop the value :math:`\I32.\CONST~i` from the stack.

10. Let :math:`\X{ea}` be the integer :math:`i + \memarg.\OFFSET`.

11. If :math:`\X{ea} + N/8` is larger than the length of :math:`\X{mem}.\MIBYTES`, then:

    a. Trap.

12. Let :math:`b^\ast` be the byte sequence :math:`\X{mem}.\MIBYTES[\X{ea} \slice N/8]`.

13. Let :math:`r` be the constant for which :math:`\bytes_{\iN}(r) = b^\ast`.

14. Let :math:`L` be :math:`128 / N`.

15. Let :math:`j^\ast` be the result of computing :math:`\lanes_{\IN\K{x}L}(v)`.

16. Let :math:`c` be the result of computing :math:`\lanes^{-1}_{\IN\K{x}L}(j^\ast \with [y] = r)`.

17. Push the value :math:`\V128.\CONST~c` to the stack.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\V128.\CONST~v)~(\V128\K{.}\VLOAD{N}\K{\_lane}~x~\memarg~y) &\stepto& S; F; (\V128.\CONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + N/8 \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIBYTES| \\
     \wedge & \bytes_{\iN}(r) = S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIBYTES[\X{ea} \slice N/8]) \\
     \wedge & L = 128/N \\
     \wedge & c = \lanes^{-1}_{\IN\K{x}L}(\lanes_{\IN\K{x}L}(v) \with [y] = r))
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\V128.\CONST~v)~(\V128.\VLOAD{N}\K{\_lane}~x~\memarg~y) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise) \\
   \end{array}

$${rule: {Step_read/vload_lane-*}}


.. _exec-store-val:
.. _exec-store-pack:
.. _exec-vstore:

$${rule-prose: exec/store}

$${rule: {Step/store-* Step/vstore-*}}


.. _exec-vstore_lane:

:math:`\V128\K{.}\VSTORE{N}\K{\_lane}~x~\memarg~y`
..................................................

.. todo:: (*) Rule and prose both not spliced.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-vstore_lane>`, :math:`F.\AMODULE.\MIMEMS[x]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\AMODULE.\MIMEMS[x]`.

4. Assert: due to :ref:`validation <valid-store-pack>`, :math:`S.\SMEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\SMEMS[a]`.

6. Assert: due to :ref:`validation <valid-vstore_lane>`, a value of :ref:`value type <syntax-valtype>` :math:`\V128` is on the top of the stack.

7. Pop the value :math:`\V128.\CONST~c` from the stack.

8. Assert: due to :ref:`validation <valid-vstore_lane>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

9. Pop the value :math:`\I32.\CONST~i` from the stack.

10. Let :math:`\X{ea}` be the integer :math:`i + \memarg.\OFFSET`.

11. If :math:`\X{ea} + N/8` is larger than the length of :math:`\X{mem}.\MIBYTES`, then:

    a. Trap.

12. Let :math:`L` be :math:`128/N`.

13. Let :math:`j^\ast` be the result of computing :math:`\lanes_{\IN\K{x}L}(c)`.

14. Let :math:`b^\ast` be the result of computing :math:`\bytes_{\iN}(j^\ast[y])`.

15. Replace the bytes :math:`\X{mem}.\MIBYTES[\X{ea} \slice N/8]` with :math:`b^\ast`.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\V128.\CONST~c)~(\V128.\VSTORE{N}\K{\_lane}~x~\memarg~y) &\stepto& S'; F; \epsilon
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + N \leq |S.\SMEMS[F.\AMODULE.\MIMEMS[x]].\MIBYTES| \\
     \wedge & L = 128/N \\
     \wedge & S' = S \with \SMEMS[F.\AMODULE.\MIMEMS[x]].\MIBYTES[\X{ea} \slice N/8] = \bytes_{\iN}(\lanes_{\IN\K{x}L}(c)[y]))
     \end{array}
   \\[1ex]
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\V128.\CONST~c)~(\V128.\VSTORE{N}\K{\_lane}~x~\memarg~y) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\otherwise) \\
   \end{array}

$${rule: {Step/vstore_lane-*}}


.. _exec-memory.size:

$${rule-prose: exec/memory.size}

$${rule: {Step_read/memory.size}}


.. _exec-memory.grow:

$${rule-prose: exec/memory.grow}

.. todo:: (6) Maybe we want to be more precise than just saying "Either" in the prose, elaborating that it may succeed or fail non-deterministically.

$${rule: {Step/memory.grow-*}}

.. note::
   The |MEMORYGROW| instruction is non-deterministic.
   It may either succeed, returning the old memory size :math:`\X{sz}`,
   or fail, returning :math:`{-1}`.
   Failure *must* occur if the referenced memory instance has a maximum size defined that would be exceeded.
   However, failure *can* occur in other cases as well.
   In practice, the choice depends on the :ref:`resources <impl-exec>` available to the :ref:`embedder <embedder>`.


.. _exec-memory.fill:

$${rule-prose: exec/memory.fill}

$${rule: {Step_read/memory.fill-*}}


.. _exec-memory.copy:

$${rule-prose: exec/memory.copy}

$${rule: {Step_read/memory.copy-*}}


.. _exec-memory.init:

$${rule-prose: exec/memory.init}

$${rule: {Step_read/memory.init-*}}


.. _exec-data.drop:

$${rule-prose: exec/data.drop}

$${rule: {Step/data.drop}}


.. index:: control instructions, structured control, label, block, branch, result type, label index, function index, type index, list, address, table address, table instance, store, frame
   pair: execution; instruction
   single: abstract syntax; instruction
.. _exec-label:
.. _exec-instr-control:

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-block:

$${rule-prose: exec/block}

$${rule: {Step_read/block}}


.. _exec-loop:

$${rule-prose: exec/loop}

$${rule: {Step_read/loop}}


.. _exec-if:

$${rule-prose: exec/if}

$${rule: {Step_pure/if-*}}


.. _exec-br:

$${rule-prose: exec/br}

$${rule: {Step_pure/br-*}}


.. _exec-br_if:

$${rule-prose: exec/br_if}

$${rule: {Step_pure/br_if-*}}


.. _exec-br_table:

$${rule-prose: exec/br_table}

$${rule: {Step_pure/br_table-*}}


.. _exec-br_on_null:

$${rule-prose: exec/br_on_null}

.. todo:: (3) Introduce if-let instruction instead of "is of the case".

$${rule: {Step_pure/br_on_null-*}}


.. _exec-br_on_non_null:

$${rule-prose: exec/br_on_non_null}

.. todo:: (3) Introduce if-let instruction instead of "is of the case".

$${rule: {Step_pure/br_on_non_null-*}}


.. _exec-br_on_cast:

$${rule-prose: exec/br_on_cast}

.. todo::
   Below is the acutal prose.
   (9) Need to handle RulePr s \|- ref : rt properly in prose instead of $ref_type_of

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Let :math:`\X{rt}'_2` be the :ref:`reference type <syntax-reftype>` :math:`\insttype_{F.\AMODULE}(\X{rt}_2)`.

3. Assert: due to :ref:`validation <valid-ref.test>`, :math:`\X{rt}'_2` is :ref:`closed <type-closed>`.

4. Assert: due to :ref:`validation <valid-ref.test>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

5. Pop the value :math:`\reff` from the stack.

6. Assert: due to validation, the :ref:`reference value <syntax-ref>` is :ref:`valid <valid-ref>` with some :ref:`reference type <syntax-reftype>`.

7. Let :math:`\X{rt}` be the :ref:`reference type <syntax-reftype>` of :math:`\reff`.

8. Push the value :math:`\reff` back to the stack.

9. If the :ref:`reference type <syntax-reftype>` :math:`\X{rt}` :ref:`matches <match-reftype>` :math:`\X{rt}'_2`, then:

   a. :ref:`Execute <exec-br>` the instruction :math:`(\BR~l)`.

$${rule: {Step_read/br_on_cast-*}}


.. _exec-br_on_cast_fail:

$${rule-prose: exec/br_on_cast_fail}

.. todo::
   Below is the actual prose.
   (9) Need to handle RulePr s \|- ref : rt properly in prose instead of $ref_type_of

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Let :math:`\X{rt}'_2` be the :ref:`reference type <syntax-reftype>` :math:`\insttype_{F.\AMODULE}(\X{rt}_2)`.

3. Assert: due to :ref:`validation <valid-ref.test>`, :math:`\X{rt}'_2` is :ref:`closed <type-closed>`.

4. Assert: due to :ref:`validation <valid-ref.test>`, a :ref:`reference value <syntax-ref>` is on the top of the stack.

5. Pop the value :math:`\reff` from the stack.

6. Assert: due to validation, the :ref:`reference value <syntax-ref>` is :ref:`valid <valid-ref>` with some :ref:`reference type <syntax-reftype>`.

7. Let :math:`\X{rt}` be the :ref:`reference type <syntax-reftype>` of :math:`\reff`.

8. Push the value :math:`\reff` back to the stack.

9. If the :ref:`reference type <syntax-reftype>` :math:`\X{rt}` does not :ref:`match <match-reftype>` :math:`\X{rt}'_2`, then:

   a. :ref:`Execute <exec-br>` the instruction :math:`(\BR~l)`.

$${rule: {Step_read/br_on_cast_fail-*}}


.. _exec-return:

$${rule-prose: exec/return}

$${rule: {Step_pure/return-*}}


.. _exec-call:

$${rule-prose: exec/call}

$${rule: {Step_read/call}}


.. _exec-call_ref:

:math:`\CALLREF~x`
..................

.. todo:: (*) Prose not spliced, for the prose merges the two cases of null and non-null references.

1. Assert: due to :ref:`validation <valid-call_ref>`, a null or :ref:`function reference <syntax-ref>` is on the top of the stack.

2. Pop the reference value :math:`r` from the stack.

3. If :math:`r` is :math:`\REFNULL~\X{ht}`, then:

    a. Trap.

4. Assert: due to :ref:`validation <valid-call_ref>`, :math:`r` is a :ref:`function reference <syntax-ref>`.

5. Let :math:`\REFFUNCADDR~a` be the reference :math:`r`.

6. :ref:`Invoke <exec-invoke>` the function instance at address :math:`a`.

$${rule: {Step_read/call_ref-null}}

.. note::
   The formal rule for calling a non-null function reference is described :ref:`below <exec-invoke>`.


.. _exec-call_indirect:

$${rule-prose: exec/call_indirect}

.. todo::
   Below is the actual prose.
   (11) ref.cast (ref (null ()) y) is rendered differently. Need to handle TERMINAL? case in AL-to-EL-expr phase.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`F.\AMODULE.\MITABLES[x]` exists.

3. Let :math:`\X{ta}` be the :ref:`table address <syntax-tableaddr>` :math:`F.\AMODULE.\MITABLES[x]`.

4. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`S.\STABLES[\X{ta}]` exists.

5. Let :math:`\X{tab}` be the :ref:`table instance <syntax-tableinst>` :math:`S.\STABLES[\X{ta}]`.

6. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`F.\AMODULE.\MITYPES[y]` is defined.

7. Let :math:`\X{dt}_{\F{expect}}` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[y]`.

8. Assert: due to :ref:`validation <valid-call_indirect>`, a value with :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

9. Pop the value :math:`\I32.\CONST~i` from the stack.

10. If :math:`i` is not smaller than the length of :math:`\X{tab}.\TIREFS`, then:

    a. Trap.

11. Let :math:`r` be the :ref:`reference <syntax-ref>` :math:`\X{tab}.\TIREFS[i]`.

12. If :math:`r` is :math:`\REFNULL~\X{ht}`, then:

    a. Trap.

13. Assert: due to :ref:`validation of table mutation <valid-table.set>`, :math:`r` is a :ref:`function reference <syntax-ref.func>`.

14. Let :math:`\REFFUNCADDR~a` be the :ref:`function reference <syntax-ref.func>` :math:`r`.

15. Assert: due to :ref:`validation of table mutation <valid-table.set>`, :math:`S.\SFUNCS[a]` exists.

16. Let :math:`\X{f}` be the :ref:`function instance <syntax-funcinst>` :math:`S.\SFUNCS[a]`.

17. Let :math:`\X{dt}_{\F{actual}}` be the :ref:`defined type <syntax-deftype>` :math:`\X{f}.\FITYPE`.

18. If :math:`\X{dt}_{\F{actual}}` does not :ref:`match <match-deftype>` :math:`\X{dt}_{\F{expect}}`, then:

    a. Trap.

19. :ref:`Invoke <exec-invoke>` the function instance at address :math:`a`.

$${rule: {Step_pure/call_indirect}}


.. _exec-return_call:

$${rule-prose: exec/return_call}

$${rule: {Step_read/return_call}}


.. _exec-return_call_ref:

:math:`\RETURNCALLREF~x`
........................

.. todo::
   (*) Prose not spliced, Sphinx cannot build the document with deeply nested ordered list. (mainly caused by spurious conditions that should be assertions)

1. Assert: due to :ref:`validation <valid-return_call_ref>`, a :ref:`function reference <syntax-ref>` is on the top of the stack.

2. Pop the reference value :math:`r` from the stack.

3. If :math:`r` is :math:`\REFNULL~\X{ht}`, then:

    a. Trap.

4. Assert: due to :ref:`validation <valid-call_ref>`, :math:`r` is a :ref:`function reference <syntax-ref>`.

5. Let :math:`\REFFUNCADDR~a` be the reference :math:`r`.

6. :ref:`Tail-invoke <exec-invoke>` the function instance at address :math:`a`.

$${rule: {Step_read/return_call_ref-*}}


.. _exec-return_call_indirect:

$${rule-prose: exec/return_call_indirect}

.. todo::
   Below is the actual prose.
   (11) ref.cast (ref (null ()) y) is rendered differently. Need to handle TERMINAL? case in AL-to-EL-expr phase.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`F.\AMODULE.\MITABLES[x]` exists.

3. Let :math:`\X{ta}` be the :ref:`table address <syntax-tableaddr>` :math:`F.\AMODULE.\MITABLES[x]`.

4. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`S.\STABLES[\X{ta}]` exists.

5. Let :math:`\X{tab}` be the :ref:`table instance <syntax-tableinst>` :math:`S.\STABLES[\X{ta}]`.

6. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`F.\AMODULE.\MITYPES[y]` exists.

7. Let :math:`\X{dt}_{\F{expect}}` be the :ref:`defined type <syntax-deftype>` :math:`F.\AMODULE.\MITYPES[y]`.

8. Assert: due to :ref:`validation <valid-call_indirect>`, a value with :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

9. Pop the value :math:`\I32.\CONST~i` from the stack.

10. If :math:`i` is not smaller than the length of :math:`\X{tab}.\TIREFS`, then:

    a. Trap.

11. If :math:`\X{tab}.\TIREFS[i]` is uninitialized, then:

    a. Trap.

12. Let :math:`a` be the :ref:`function address <syntax-funcaddr>` :math:`\X{tab}.\TIREFS[i]`.

13. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`S.\SFUNCS[a]` exists.

14. Let :math:`\X{f}` be the :ref:`function instance <syntax-funcinst>` :math:`S.\SFUNCS[a]`.

15. Let :math:`\X{dt}_{\F{actual}}` be the :ref:`defined type <syntax-functype>` :math:`\X{f}.\FITYPE`.

16. If :math:`\X{dt}_{\F{actual}}` does not :ref:`match <match-functype>` :math:`\X{dt}_{\F{expect}}`, then:

    a. Trap.

17. :ref:`Tail-invoke <exec-invoke>` the function instance at address :math:`a`.

$${rule: {Step_pure/return_call_indirect}}


.. _exec-throw:

$${rule-prose: exec/throw}

.. todo:: check prose

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-throw>`, :math:`F.\AMODULE.\MITAGS[x]` exists.

3. Let :math:`ta` be the :ref:`tag address <syntax-tagaddr>` :math:`F.\AMODULE.\MITAGS[x]`.

4. Assert: due to :ref:`validation <valid-throw>`, :math:`S.\STAGS[ta]` exists.

5. Let :math:`\X{ti}` be the :ref:`tag instance <syntax-taginst>` :math:`S.\STAGS[ta]`.

6. Let :math:`[t^n] \toF [{t'}^\ast]` be the :ref:`tag type <syntax-tagtype>` :math:`\X{ti}.\TAGITYPE`.

7. Assert: due to :ref:`validation <valid-throw>`, there are at least :math:`n` values on the top of the stack.

8. Pop the :math:`n` values :math:`\val^n` from the stack.

9. Let :math:`\X{ea}` be the :ref:`exception address <syntax-exnaddr>` resulting from :ref:`allocating <alloc-exception>` an exception instance with tag address :math:`ta` and initializer values :math:`\val^n`.

10. Let :math:`\X{exn}` be :math:`S.\SEXNS[ea]`

11. Push the value :math:`\REFEXNADDR~\X{ea}` to the stack.

12. Execute the instruction |THROWREF|.

$${rule: Step/throw}


.. _exec-throw_ref:

$${rule-prose: exec/throw_ref}

.. todo:: check prose

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-throw_ref>`, a :ref:`reference <syntax-ref>` is on the top of the stack.

3. Pop the reference :math:`\reff` from the stack.

4. If :math:`\reff` is :math:`\REFNULL~\X{ht}`, then:

   a. Trap.

5. Assert: due to :ref:`validation <valid-throw_ref>`, :math:`\reff` is an :ref:`exception reference <syntax-ref.exn>`.

6. Let :math:`\REFEXNADDR~\X{ea}` be :math:`\reff`.

7. Assert: due to :ref:`validation <valid-throw_ref>`, :math:`S.\SEXNS[\X{ea}]` exists.

8. Let :math:`\X{exn}` be the :ref:`exception instance <syntax-exninst>` :math:`S.\SEXNS[\X{ea}]`.

9. Let :math:`a` be the :ref:`tag address <syntax-tagaddr>` :math:`\X{exn}.\EITAG`.

10. While the stack is not empty and the top of the stack is not an :ref:`exception handler <syntax-handler>`, do:

   a. Pop the top element from the stack.

11. Assert: the stack is now either empty, or there is an exception handler on the top of the stack.

12. If the stack is empty, then:

   a. Return the exception :math:`(\REFEXNADDR~a)` as a :ref:`result <syntax-result>`.

13. Assert: there is an :ref:`exception handler <syntax-handler>` on the top of the stack.

14. Pop the exception handler  :math:`\HANDLER_n\{\catch^\ast\}` from the stack.

15. If :math:`\catch^\ast` is empty, then:

    a. Push the exception reference :math:`\REFEXNADDR~\X{ea}` back to the stack.

    b. Execute the instruction |THROWREF| again.

16. Else:

    a. Let :math:`\catch_1` be the first :ref:`catch clause <syntax-catch>` in :math:`\catch^\ast` and :math:`{\catch'}^\ast` the remaining clauses.

    b. If :math:`\catch_1` is of the form :math:`\CATCH~x~l` and the :ref:`tag address <syntax-tagaddr>` :math:`a` equals :math:`F.\AMODULE.\MITAGS[x]`, then:

       i. Push the values :math:`\X{exn}.\EIFIELDS` to the stack.

       ii. Execute the instruction :math:`\BR~l`.

    c. Else if :math:`\catch_1` is of the form :math:`\CATCHREF~x~l` and the :ref:`tag address <syntax-tagaddr>` :math:`a` equals :math:`F.\AMODULE.\MITAGS[x]`, then:

       i. Push the values :math:`\X{exn}.\EIFIELDS` to the stack.

       ii. Push the exception reference :math:`\REFEXNADDR~\X{ea}` to the stack.

       iii. Execute the instruction :math:`\BR~l`.

    d. Else if :math:`\catch_1` is of the form :math:`\CATCHALL~l`, then:

       i. Execute the instruction :math:`\BR~l`.

    e. Else if :math:`\catch_1` is of the form :math:`\CATCHALLREF~l`, then:

       i. Push the exception reference :math:`\REFEXNADDR~\X{ea}` to the stack.

       ii. Execute the instruction :math:`\BR~l`.

    f. Else:

       1. Push the modified handler  :math:`\HANDLER_n\{{\catch'}^\ast\}` back to the stack.

       2. Push the exception reference :math:`\REFEXNADDR~\X{ea}` back to the stack.

       3. Execute the instruction :math:`\THROWREF` again.

$${rule: Step_pure/throw_ref-*}


.. _exec-try_table:

$${rule-prose: exec/try_table}

.. todo:: check prose

1. Assert: due to :ref:`validation <valid-blocktype>`, :math:`\fblocktype_{S;F}(\blocktype)` is defined.

2. Let :math:`[t_1^m] \to [t_2^n]` be the :ref:`instruction type <syntax-instrtype>` :math:`\fblocktype_{S;F}(\blocktype)`.

3. Assert: due to :ref:`validation <valid-try_table>`, there are at least :math:`m` values on the top of the stack.

4. Pop the values :math:`\val^m` from the stack.

5. Let :math:`L` be the label whose arity is :math:`n` and whose continuation is the end of the |TRYTABLE| instruction.

6. :ref:`Enter <exec-handler-enter>` the block :math:`\val^m~\instr_1^\ast` with label :math:`L` and exception handler :math:`\HANDLER_n\{\catch^\ast\}`.

$${rule: Step_pure/try_table}


.. index:: instruction, instruction sequence, block, exception, trap
.. _exec-instrs:

Blocks
~~~~~~

The following auxiliary rules define the semantics of executing an :ref:`instruction sequence <syntax-instrs>`
that forms a :ref:`block <exec-instr-control>`.


.. _exec-instrs-enter:

Entering :math:`\instr^\ast` with label :math:`L`
.................................................

1. Push :math:`L` to the stack.

2. Jump to the start of the instruction sequence :math:`\instr^\ast`.

.. note::
   No formal reduction rule is needed for entering an instruction sequence,
   because the label :math:`L` is embedded in the :ref:`administrative instruction <syntax-instr-admin>` that structured control instructions reduce to directly.


.. _exec-instrs-exit:

Exiting :math:`\instr^\ast` with label :math:`L`
................................................

When the end of a block is reached without a jump, :ref:`exception <exception>`, or :ref:`trap <trap>` aborting it, then the following steps are performed.

1. Pop all values :math:`\val^\ast` from the top of the stack.

2. Assert: due to :ref:`validation <valid-instrs>`, the label :math:`L` is now on the top of the stack.

3. Pop the label from the stack.

4. Push :math:`\val^\ast` back to the stack.

5. Jump to the position after the |END| of the :ref:`structured control instruction <syntax-instr-control>` associated with the label :math:`L`.

$${rule: Step_pure/label-vals}

.. note::
   This semantics also applies to the instruction sequence contained in a ${:LOOP} instruction.
   Therefore, execution of a loop falls off the end, unless a backwards branch is performed explicitly.


.. index:: exception, handler, throw context, tag, exception tag

.. _exec-handler:

Exception Handling
~~~~~~~~~~~~~~~~~~

The following auxiliary rules define the semantics of entering and exiting ${:TRY_TABLE} blocks.

.. _exec-handler-enter:

Entering :math:`\instr^\ast` with label :math:`L` and exception handler :math:`H`
.................................................................................

1. Push :math:`L` to the stack.

2. Push :math:`H` onto the stack.

3. Jump to the start of the instruction sequence :math:`\instr^\ast`.

.. note::
   No formal reduction rule is needed for entering an exception :ref:`handler <syntax-handler>`
   because it is an :ref:`administrative instruction <syntax-instr-admin>`
   that the ${:TRY_TABLE} instruction reduces to directly.


.. _exec-handler-exit:

Exiting an exception handler
............................

When the end of a ${:TRY_TABLE} block is reached without a jump, :ref:`exception <exception>`, or :ref:`trap <trap>`, then the following steps are performed.

1. Let :math:`m` be the number of values on the top of the stack.

2. Pop the values :math:`\val^m` from the stack.

3. Assert: due to :ref:`validation <valid-instr-seq>`, a handler and a label are now on the top of the stack.

4. Pop the label from the stack.

5. Pop the handler :math:`H` from the stack.

6. Push :math:`\val^m` back to the stack.

7. Jump to the position after the |END| of the administrative instruction associated with the handler :math:`H`.

$${rule: Step_pure/handler-vals}

.. math::
   ~\\[-1ex]
   \begin{array}{lcl@{\qquad}l}
   \HANDLER_m\{\catch^\ast\}~\val^m~\END &\stepto& \val^m \\
   \end{array}


.. index:: ! call, function, function instance, label, frame

Function Calls
~~~~~~~~~~~~~~

The following auxiliary rules define the semantics of invoking a :ref:`function instance <syntax-funcinst>`
through one of the :ref:`call instructions <exec-instr-control>`
and returning from it.


.. _exec-invoke:

Invocation of :ref:`function reference <syntax-ref.func>` :math:`(\REFFUNCADDR~a)`
..................................................................................

1. Assert: due to :ref:`validation <valid-call>`, :math:`S.\SFUNCS[a]` exists.

2. Let :math:`f` be the :ref:`function instance <syntax-funcinst>`, :math:`S.\SFUNCS[a]`.

3. Let :math:`\TFUNC~[t_1^n] \toF [t_2^m]` be the :ref:`composite type <syntax-comptype>` :math:`\expanddt(\X{f}.\FITYPE)`.

4. Let :math:`\local^\ast` be the list of :ref:`locals <syntax-local>` :math:`f.\FICODE.\FLOCALS`.

5. Let :math:`\instr^\ast~\END` be the :ref:`expression <syntax-expr>` :math:`f.\FICODE.\FBODY`.

6. Assert: due to :ref:`validation <valid-call>`, :math:`n` values are on the top of the stack.

7. Pop the values :math:`\val^n` from the stack.

8. Let :math:`F` be the :ref:`frame <syntax-frame>` :math:`\{ \AMODULE~f.\FIMODULE, \ALOCALS~\val^n~(\default_t)^\ast \}`.

9. Push the activation of :math:`F` with arity :math:`m` to the stack.

10. Let :math:`L` be the :ref:`label <syntax-label>` whose arity is :math:`m` and whose continuation is the end of the function.

11. :ref:`Enter <exec-instrs-enter>` the instruction sequence :math:`\instr^\ast` with label :math:`L`.

$${rule: {Step_read/call_ref-func}}

.. note::
   For non-defaultable types, the respective local is left uninitialized by these rules.


.. _exec-invoke-exit:

Returning from a function
.........................

When the end of a function is reached without a jump (including through |RETURN|), or an :ref:`exception <exception>` or :ref:`trap <trap>` aborting it, then the following steps are performed.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Let :math:`n` be the arity of the activation of :math:`F`.

3. Assert: due to :ref:`validation <valid-instrs>`, there are :math:`n` values on the top of the stack.

4. Pop the results :math:`\val^n` from the stack.

5. Assert: due to :ref:`validation <valid-func>`, the frame :math:`F` is now on the top of the stack.

6. Pop the frame from the stack.

7. Push :math:`\val^n` back to the stack.

8. Jump to the instruction after the original call.

$${rule: Step_pure/frame-vals}


.. index:: host function, store
.. _exec-invoke-host:

Host Functions
..............

Invoking a :ref:`host function <syntax-hostfunc>` has non-deterministic behavior.
It may either terminate with a :ref:`trap <trap>`, an :ref:`exception <exception>`, or return regularly.
However, in the latter case, it must consume and produce the right number and types of WebAssembly :ref:`values <syntax-val>` on the stack,
according to its :ref:`function type <syntax-functype>`.

A host function may also modify the :ref:`store <syntax-store>`.
However, all store modifications must result in an :ref:`extension <extend-store>` of the original store, i.e., they must only modify mutable contents and must not have instances removed.
Furthermore, the resulting store must be :ref:`valid <valid-store>`, i.e., all data and code in it is well-typed.

.. math::
   ~\\[-1ex]
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; \val^n~(\INVOKE~a) &\stepto& S'; \result
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & S.\SFUNCS[a] = \{ \FITYPE~\deftype, \FIHOSTFUNC~\X{hf} \} \\
     \wedge & \expanddt(\deftype) = \TFUNC~[t_1^n] \toF [t_2^m] \\
     \wedge & (S'; \result) \in \X{hf}(S; \val^n)) \\
     \end{array} \\
   \begin{array}{lcl@{\qquad}l}
   S; \val^n~(\INVOKE~a) &\stepto& S; \val^n~(\INVOKE~a)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\iff & S.\SFUNCS[a] = \{ \FITYPE~\deftype, \FIHOSTFUNC~\X{hf} \} \\
     \wedge & \expanddt(\deftype) = \TFUNC~[t_1^n] \toF [t_2^m] \\
     \wedge & \bot \in \X{hf}(S; \val^n)) \\
     \end{array} \\
   \end{array}

Here, :math:`\X{hf}(S; \val^n)` denotes the implementation-defined execution of host function :math:`\X{hf}` in current store :math:`S` with arguments :math:`\val^n`.
It yields a set of possible outcomes, where each element is either a pair of a modified store :math:`S'` and a :ref:`result <syntax-result>`
or the special value :math:`\bot` indicating divergence.
A host function is non-deterministic if there is at least one argument for which the set of outcomes is not singular.

For a WebAssembly implementation to be :ref:`sound <soundness>` in the presence of host functions,
every :ref:`host function instance <syntax-funcinst>` must be :ref:`valid <valid-hostfuncinst>`,
which means that it adheres to suitable pre- and post-conditions:
under a :ref:`valid store <valid-store>` :math:`S`, and given arguments :math:`\val^n` matching the ascribed parameter types :math:`t_1^n`,
executing the host function must yield a non-empty set of possible outcomes each of which is either divergence or consists of a valid store :math:`S'` that is an :ref:`extension <extend-store>` of :math:`S` and a result matching the ascribed return types :math:`t_2^m`.
All these notions are made precise in the :ref:`Appendix <soundness>`.

.. note::
   A host function can call back into WebAssembly by :ref:`invoking <exec-invocation>` a function :ref:`exported <syntax-export>` from a :ref:`module <syntax-module>`.
   However, the effects of any such call are subsumed by the non-deterministic behavior allowed for the host function.



.. index:: expression
   pair: execution; expression
   single: abstract syntax; expression
.. _exec-expr:

Expressions
~~~~~~~~~~~

An :ref:`expression <syntax-expr>` is *evaluated* relative to a :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>` pointing to its containing :ref:`module instance <syntax-moduleinst>`.

1. Jump to the start of the instruction sequence :math:`\instr^\ast` of the expression.

2. Execute the instruction sequence.

3. Assert: due to :ref:`validation <valid-expr>`, the top of the stack contains a :ref:`value <syntax-val>`.

4. Pop the :ref:`value <syntax-val>` :math:`\val` from the stack.

The value :math:`\val` is the result of the evaluation.

$${rule: Eval_expr}

.. math::
   S; F; \instr^\ast \stepto S'; F'; \instr'^\ast
   \qquad (\iff S; F; \instr^\ast~\END \stepto S'; F'; \instr'^\ast~\END)

.. note::
   Evaluation iterates this reduction rule until reaching a value.
   Expressions constituting :ref:`function <syntax-func>` bodies are executed during function :ref:`invocation <exec-invoke>`.

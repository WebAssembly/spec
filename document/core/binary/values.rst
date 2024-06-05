.. index:: value
   pair: binary format; value
.. _binary-value:

Values
------


.. index:: byte
   pair: binary format; byte
.. _binary-byte:

Bytes
~~~~~

:ref:`Bytes <syntax-byte>` encode themselves.

$${grammar: Bbyte}


.. index:: integer, unsigned integer, signed integer, uninterpreted integer, LEB128, two's complement
   pair: binary format; integer
   pair: binary format; unsigned integer
   pair: binary format; signed integer
   pair: binary format; uninterpreted integer
.. _binary-sint:
.. _binary-uint:
.. _binary-int:

Integers
~~~~~~~~

All :ref:`integers <syntax-int>` are encoded using the |LEB128|_ variable-length integer encoding, in either unsigned or signed variant.

:ref:`Unsigned integers <syntax-uint>` are encoded in |UnsignedLEB128|_ format.
As an additional constraint, the total number of bytes encoding a ${:uN(N)} value must not exceed ${:$ceil($(N/7))} bytes.

$${grammar: BuN}

:ref:`Signed integers <syntax-sint>` are encoded in |SignedLEB128|_ format, which uses a two's complement representation.
As an additional constraint, the total number of bytes encoding an ${:sN(N)} value must not exceed ${:$ceil($(N/7))} bytes.

$${grammar: BsN}

:ref:`Uninterpreted integers <syntax-int>` are encoded as signed integers.

$${grammar: BiN}

.. note::
   The side conditions ${:$(N>7)} in the productions for non-terminal bytes of the ${:uN(N)} and ${:sN(N)} encodings restrict the encoding's length.
   However, "trailing zeros" are still allowed within these bounds.
   For example, ${:0x03} and ${:0x83 0x00} are both well-formed encodings for the value ${:3} as a ${:u8}.
   Similarly, either of ${:0x7E} and ${:0xFE 0x7F} and ${:0xFE 0xFF 0x7F} are well-formed encodings of the value ${:$(-2)} as an ${:s16}.

   The side conditions on the value ${:n} of terminal bytes further enforce that
   any unused bits in these bytes must be ${:0} for positive values and ${:1} for negative ones.
   For example, ${:0x83 0x10} is malformed as a ${:u8} encoding.
   Similarly, both ${:0x83 0x3E} and ${:0xFF 0x7B} are malformed as ${:s8} encodings.


.. index:: floating-point number, little endian
   pair: binary format; floating-point number
.. _binary-float:

Floating-Point
~~~~~~~~~~~~~~

:ref:`Floating-point <syntax-float>` values are encoded directly by their |IEEE754|_ (Section 3.4) bit pattern in |LittleEndian|_ byte order:

$${grammar: BfN}


.. index:: name, byte, Unicode, ! UTF-8
   pair: binary format; name
.. _binary-utf8:
.. _binary-name:

Names
~~~~~

:ref:`Names <syntax-name>` are encoded as a :ref:`list <binary-list>` of bytes containing the |Unicode|_ (Section 3.9) UTF-8 encoding of the name's character sequence.

$${grammar: Bname}

The auxiliary ${:$utf8} function expressing this encoding is defined as follows:

$${definition: utf8}

where ${definition: cont}

.. note::
   Unlike in some other formats, name strings are not 0-terminated.

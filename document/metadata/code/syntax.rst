.. _syntax:

Structure
=========

Code Metadata
-------------

A Code Metadata item is a piece of information logically attached to an instruction.

An item has a type and a paylod, whose format is defined by its type.

TODO: can this be expressed with the math notation?

Branch Hints
~~~~~~~~~~~~

A Branch Hint is a type of Code Metadata that can be attached to `br_if` and `if` instructions.
Its payload indicates whether the branch is likely or unlikely to be taken.

TODO: math definition


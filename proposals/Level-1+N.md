# Exception Handling Level 1+N Extensions

While the Level 1 Proposal establishes the minimum viable product (MVP) for
exception handling, there are several extensions that would be nice to have for
various reasons. These include:
* More compact WebAssembly code. Compound instructions can capture common
  sequences and save on code size.
* More efficient embedder implementation. Some changes to the baseline spec can
  open up opportunities for embedders to generate better code.
* General completeness. The baseline proposal has some arbitrary limitations
  that are only there to reduce implementation effort but do not have any
  fundamental theoretical reasons.

Many of these extensions are complementary and build upon each other. Thus a
layered approach works well, where sets of features that are logically related
can be added at once.

This document captures several feature levels at a high level. The goal is not
to exhaustively specify them but to carve out the design space in sufficient
detail that we can ensure the Level 1 proposal is future proof with respect to
these. Each level will likely become its own WebAssembly proposal after the
initial exception handling support is accepted, but if there are strong use
cases and a low enough specification and implementation burden, these may be
included with the initial exception proposal. The goal is to make sure each set
of features can be discussed in terms of its own merits independent of the other
features.

# Level 2

## Specific Catch

The Level 1 proposal only supports `catch_all`, meaning a single catch clause
that runs for all exceptions. Some languages may only be interested in catching
certain exceptions. Specific catch allows programs to specify which exceptions
that will handle with a certain `try` block. This improves performance by not
running code that is not needed and, more importantly, opens up for efficient
implementation strategies for the embedder such as being able to go directly to
the catch clause for the given exception.

This feature extends try blocks as follows:

```
try resulttype
  instruction*
(catch exception_index
  instruction* )*
(catch
  instruction* )?
end
```

Note that the `catch exteption_index` and `catch` forms of the catch clause should be given different opcodes.

### Alternate Form: Catch Lists

In this version, a catch clause lists which exception indices it handles. An
empty list is equivalent to `catch_all`. An example is given below.

```
try resulttype
  instruction*
catch exception_index*
  instrunction*
end
```

One downside of this form is that it does not directly support running different
code for different exception types. This can still be accomplished, however, by
dyanmically inspecting the exception inside the catch block.

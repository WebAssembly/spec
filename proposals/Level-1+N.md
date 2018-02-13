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

Please note that everything in here should be considered fluid and subject to
change.

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

# Level 3

## Resumable Exceptions

This proposal allows exception handlers to return a value to the site where the
exception was thrown. Resumable exceptions enable or are equivalent to a number
of advanced control flow features such as generators, coroutines, delimited
continuations and effect handlers.

In high level code, this would enable programs such as:

```
Exception FileNotFound: string -> string

try {
  filename = "foo.txt"
  while(!(file = open(filename))) {
    filename = throw FileNotFound(filename);
  }
} catch (FileNotFound e) {
  new_file_name = ask_user_for_filename();
  resume e(new_file_name)
}
```

The key changes are that exception types are now allowed to include return
values, `throw` can return a value (we might want to introduce a different
opcode for this version, such as `raise` or `throw_resumable`), and there is a
`resume` instruction that returns values back to where the exception was thrown
from.

Below are several examples showing how other control flow patterns can be
expressed in terms of resumable exceptions.

### Example: Algebraic Effect Handlers

Consider the following example, taken from http://www.eff-lang.org/try/:

```
handle
    std#print "A";
    std#print "B";
    std#print "C";
    std#print "D"
with
| std#print msg k ->
    std#print ("I see you tried to print " ^ msg ^ ". Okay, you may.\n");
    k ()
```

This could be lowered to Wasm resumable exception pseudo-code like this:

```
Exception StdPrint: string -> ()

import function RealPrint: string -> ()

try:
  throw StdPrint("A")
  throw StdPrint("B")
  throw StdPrint("C")
  throw StdPrint("D")
catch e: StdPrint(msg):
  RealPrint("I see you tried to print " + msg + ". Okay, you may.\n")
  resume e()
end
```

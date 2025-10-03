# 3rd Proposal Formal Spec Overview

This is an overview of the 3rd proposal's formal spec additions, to aid in discussions concerning the proposed semantics.

## Abstract Syntax

### Types

#### Tag Types

```
tagtype ::= [valtype*]→[]
```

### Instructions

```
instr ::= ... | 'throw' tagidx | 'rethrow' labelidx
        | 'try' blocktype instr* ('catch' tagidx instr*)* ('catch_all' instr*)? 'end'
        | 'try' blocktype instr* 'delegate' labelidx
```

### Modules

#### Tags

```
tag ::= export* 'tag' tagtype  | export* 'tag' tagtype import
```

#### Modules

```
mod ::= 'module' ... tag*
```

## Validation (Typing)

### Validation Contexts: Tagtypes and modified Labels

To verify that the `rethrow l` instruction refers to a label surrounding the instructions of a catch block (call this a catch-label), an optional `catch` specifier is introduced to labels in the validation context.

```
labeltype ::= 'catch'? resulttype
```

The original notation `labels [t*]` is now an abbreviation for:

```
'labels' [t*] ::= 'labels' ε [t*]
```

The `labels` entry of validation contexts is modified to use the above definition of labels.
Moreover, validation contexts now hold a list of tag types, one for each tag known to them.

```
C ::= { ..., 'labels' labeltype, 'tags' tagtype*}
```

### Validation Rules for Instructions


```
C.tags[x] = [t*]→[]
-----------------------------
C ⊢ throw x : [t1* t*]→[t2*]


C.labels[l] = catch [t*]
----------------------------
C ⊢ rethrow l : [t1*]→[t2*]


C ⊢ bt : [t1*]→[t2*]
C, labels [t2*] ⊢ instr1* : [t1*]→[t2*]
(C.tags[x] = [t*]→[] ∧
 C, labels (catch [t2*]) ⊢ instr2* : [t*]→[t2*])*
(C, labels (catch [t2*]) ⊢ instr3* : []→[t2*])?
-----------------------------------------------------------------------------
C ⊢ try bt instr1* (catch x instr2*)* (catch_all instr3*)? end : [t1*]→[t2*]


C ⊢ bt : [t1*]→[t2*]
C, labels [t2*] ⊢ instr* : [t1*]→[t2*]
C.labels[l] = [t0*]
-------------------------------------------
C ⊢ try bt instr* delegate l : [t1*]→[t2*]
```

Note that `try ... delegate 0` may appear without any explicitly surrounding block, in which case the label 0 refers to the label of the frame. Currently it is not allowed to refer to a label higher than the one of the frame.

## Execution (Reduction)

### Runtime Structure

#### Stores

```
S ::= {..., 'tags' taginst*}
```

#### Tag Instances

```
taginst ::= {'type' tagtype}
```

#### Module Instances

```
m ::= {..., 'tags' tagaddr*}
```
#### Stack

```
handler ::= (tagaddr? instr*)* | labelidx
exn ::= tagaddr val*
```

#### Administrative Instructions

```
instr ::= ... | 'throw' tagaddr | 'handler'_n{handler} instr* 'end'
        | 'handler'_n{ labelidx } instr* 'end' | 'caught'_n{exn} instr* 'end'
```

#### Block Contexts and Label Kinds

So far block contexts are only used in the reduction of `br l` and `return`, and only include labels or values on the stack on the left side of the hole `[_]`. To be able to break jumping over try-catch and try-delegate blocks, the new administrative control instructions must be allowed to appear after labels in block contexts.

```
B^0 ::= val* '[_]' instr* | val* C^0 instr*
B^{k+1} ::= val* ('label'_n{instr*} B^k 'end') instr* | val* C^{k+1} instr*
C^k ::= 'handler'_n{ handler } B^k 'end'
      | 'caught'_n{ exn } B^k 'end'
```

Note the `C` in `C^k` above stands for `control`, because the related administrative instructions are in some ways modeling [control frame opcodes](https://webassembly.github.io/spec/core/appendix/algorithm.html?highlight=control#data-structures) "on the stack".

#### Throw Contexts

Throw contexts don't skip over handlers.
Throw contexts are used to match a thrown exception with the innermost handler.

```
T ::= '[_]' | val* T instr*
   | 'label'_n{instr*} T 'end'
   | 'caught'_n{exn} T 'end'
   | 'frame'_n{F} T 'end'
```

Note that because handlers are not included above, popping the throw context stops when the innermost handler is found, if any. Note that this also means that `caught_n{exn} instr* end` is not a potential catching block for exceptions thrown by `instr*`. The instruction sequence `instr*` is inside a `catch` or `catch_all` block.

### Reduction of Instructions

Reduction steps for the new instructions or administrative instructions.

An absent tag address in a handler (i.e., `a? = ε`) represents a `catch_all`.

```
F; throw x  ↪  F; throw a  (if F.module.tagaddrs[x]=a)

caught_n{a val*} B^l[rethrow l] end
  ↪ caught_n{a val*} B^l[val* (throw a)] end

caught_n{a val0*} val^n end  ↪  val^n


F; val^n (try bt instr1* (catch x instr2*)* (catch_all instr3*)? end)
  ↪  F; label_m{} (handler_m{(a instr2*)*(ε instr3*)?} val^n instr1* end) end
  (if expand_F(bt) = [t1^n]→[t2^m] ∧ (F.module.tagaddrs[x]=a)*)

handler_m{(a? instr*)*} val^m end ↪ val^m

S; F; handler_m{(a1? instr1*)(a0? instr0*)*} T[val^n (throw a)] end
  ↪  S; F; caught_m{a val^n} (val^n)? instr1* end
  (if (a1? = ε ∨ a1? = a) ∧ S.tags(a).type = [t^n]→[])

handler_m{(a1? instr*)(a0? instr0*)*} T[(throw a)] end
  ↪ handler_m{(a0? instr0*)*} T[(throw a)] end
  (if a1? ≠ ε ∧ a1? ≠ a)

handler_m{} T[(throw a)] end ↪  T[(throw a)]
  (if S.tags(a).type = [t^n]→[])


F; val^n (try bt instr* delegate l)
  ↪ F; label_m{} (handler_m{l} val^n instr* end) end
  (if expand_F(bt) = [t1^n]→[t2^m])

handler_m{l} val^m end ↪ val^m

label_m{} B^l[ handler_m{l} T[(throw a)] end ] end
  ↪ T[(throw a)]
```

Note that the last reduction step above is similar to the reduction of `br l` [1], the entire `handler_m{l}...end` is seen as a `br l` immediately followed by a throw.

There is a subtle difference though. The instruction `br l` searches for the `l+1`th surrounding block and breaks out after that block. Because `handler_m{l}` is always wrapped in its own `label_m{} ... end` [2], with the same lookup as for `br l` the instruction ends up breaking inside the `l+1`th surrounding block, and throwing there. So if that `l+1`th surrounding block is a try, the exception is thrown in the "try code", and thus correctly getting delegated to that try's catches.

- [1] [The execution step for `br l`](https://webassembly.github.io/spec/core/exec/instructions.html#xref-syntax-instructions-syntax-instr-control-mathsf-br-l)
- [2] The label that always wraps `delegate{l}...end` can be thought of as "level -1" and cannot be referred to by the delegate's label index `l`.

### Typing Rules for Administrative Instructions


```
S ⊢ tag a : tag [t*]→[]
-------------------------------
S;C ⊢ throw a : [t1* t*]→[t2*]

((S ⊢ tag a : tag [t1*]→[])?
 S;C, labels (catch [t2^m]) ⊢ instr2* : [t1*?]→[t2^m])*
S;C, labels [t2^m] ⊢ instr1* : []→[t2^m]
-----------------------------------------------------------
S;C, labels [t2^m] ⊢ handler_m{(a? instr2*)*} instr1* end : []→[t2^m]

S;C ⊢ instr* : []→[t^m]
C.labels[l+1] = [t0*]
------------------------------------------------------
S;C ⊢ handler_m{l} instr* end : []→[t^m]

S ⊢ tag a : tag [t0*]→[]
(val:t0)*
S;C, labels (catch [t^n]) ⊢ instr* : []→[t^n]
------------------------------------------------------------
S;C, labels [t^n] ⊢ caught_n{a val^*} instr* end : []→[t^n]
```

## Uncaught Exceptions

A new [result](https://webassembly.github.io/spec/core/exec/runtime.html#syntax-result) value is added to describe uncaught exceptions.

```
result ::= val* | trap
         | val* (throw tagaddr)
```


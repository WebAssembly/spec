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

#### Modification to Labels

To verify that the `rethrow l` instruction refers to a label surrounding the instructions of a catch block (call this a catch-label), we introduce a `kind` attribute to labels in the validation context, which is set to `catch` when the label is a catch-label and empty otherwise.

```
labelkind ::= 'catch'
labeltype ::= 'catch'? resulttype
C ::= {..., 'labels' labeltype}
```

The original notation `labels [t*]` is now an abbreviation for:

```
'labels' [t*] ::= 'labels' ε [t*]
```

### Validation Contexts

Validation contexts now hold a list of tag types, one for each tag known to them.
```
C ::= { ..., 'tags' tagtype*}
```

### Validation Rules for Instructions


```
C.tags[x] = [t*]→[]
-----------------------------
C ⊢ throw x : [t1* t*]→[t2*]


C.labels[l].kind = catch
----------------------------
C ⊢ rethrow l : [t1*]→[t2*]


C ⊢ bt : [t1*]→[t2*]
C, labels [t2*] ⊢ instr* : [t1*]→[t2*]
(C.tags[x] = [t*]→[] ∧
 C, labels catch [t2*] ⊢ instr'* : [t*]→[t2*])*
(C, labels catch [t2*] ⊢ instr''* : []→[t2*])?
-----------------------------------------------------------------------------
C ⊢ try bt instr* (catch x instr'*)* (catch_all instr''*)? end : [t1*]→[t2*]


C ⊢ bt : [t1*]→[t2*]
C, labels [t2*] ⊢ instr* : [t1*]→[t2*]
C.labels[l] = [t*]
-------------------------------------------
C ⊢ try bt instr* delegate l : [t1*]→[t2*]
```

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

#### Administrative Instructions

```
instr ::= ... | 'throw' tagaddr | 'catch'{ tagaddr? instr* }* instr* 'end'
        | 'delegate'{ labelidx } instr* 'end' | 'caught'{ tagaddr val^n } instr* 'end'
```

#### Block Contexts and Label Kinds

So far block contexts are only used in the reduction of `br l` and `return`, and only include labels or values on the stack on the left side of the hole `[_]`. If we want to be able to break jumping over try-catch and try-delegate blocks, we must allow for the new administrative control instructions to appear after labels in block contexts.

```
B^0 ::= val* '[_]' instr* | val* C^0 instr*
B^{k+1} ::= val* ('label'_n{instr*} B^k 'end') instr* | val* C^{k+1} instr*
C^k ::= 'catch'{ tagaddr? instr* }* B^k 'end'
      | 'caught'{ tagaddr val* } B^k 'end'
      | 'delegate'{ labelidx } B^k 'end'
```

#### Throw Contexts

Throw contexts don't skip over handlers (administrative `catch` or `delegate` instructions).
Throw contexts are used to match a thrown exception with the innermost handler.

```
T ::= val* '[_]' instr* | 'label'_n{instr*} T 'end'
   | 'caught'{ tagaddr val^n } T 'end'
   | 'frame'_n{F} T end
```

Note that because `catch` and `delegate` instructions are not included above, there is always a unique maximal throw context to match the reduction rules. Note that this basically means that `caught{..} instr* end` is not a potential catching block for exceptions thrown by `instr*`. The instruction sequence `instr*` is inside a `catch` or `catch_all` block.

### Reduction of Instructions

Reduction steps for the new instructions or administrative instructions.

An absent tag address in a `catch` administrative instruction (i.e., `a? = ε`) represents a `catch_all`.

```
F; throw x  ↪  F; throw a  (if F.module.tagaddrs[x]=a)

caught{a val^n} B^l[rethrow l] end
  ↪ caught{a val^n} B^l[val^n (throw a)] end

caught{a val^n} val^m end  ↪  val^m


F; val^n (try bt instr* (catch x instr'*)* (catch_all instr''*)? end)
  ↪  F; label_m{} (catch{a instr'*}*{ε instr''*}? val^n instr* end) end
  (if expand_F(bt) = [t1^n]→[t2^m] ∧ (F.module.tagaddrs[x]=a)*)

catch{a? instr*}* val^m end ↪ val^m

S; F; catch{a1? instr*}{a'? instr'*}* T[val^n (throw a)] end
  ↪  S; F; caught{a val^n} (val^n)? instr* end
  (if (a1? = ε ∨ a1? = a) ∧ S.tags(a).type = [t^n]→[])

catch{a1? instr*}{a'? instr'*}* T[val^n (throw a)] end
  ↪ catch{a'? instr'*}* T[val^n (throw a)] end
  (if a1? ≠ ε ∧ a1? ≠ a)

catch T[val^n (throw a)] end ↪  val^n (throw a)


F; val^n (try bt instr* delegate l)
  ↪ F; label_m{} (delegate{l} val^n instr* end) end
  (if expand_F(bt) = [t^n]→[t^m])

delegate{l} val^n end ↪ val^n

label_m{} B^l[ delegate{l} T[val^n (throw a)] end ] end
  ↪ val^n (throw a)
```

Note that the last reduction step above is similar to the reduction of `br l` [1](https://webassembly.github.io/spec/core/exec/instructions.html#xref-syntax-instructions-syntax-instr-control-mathsf-br-l), if we look at the entire `delegate{l}...end` as the `br l`, but also doing a throw after it breaks.

There is a subtle difference though. The instruction `br l` searches for the `l+1`th surrounding block and breaks out after that block. Because `delegate{l}` is always wrapped in its own `label_n{} ... end` [2], with the same lookup as for `br l` we end up breaking inside the `l+1`th surrounding block, and throwing there. So if that `l+1`th surrounding block is a try, we end up throwing in its "try code", and thus correctly getting delegated to that try's catches.

- [1] [The execution step for `br l`](https://webassembly.github.io/spec/core/exec/instructions.html#xref-syntax-instructions-syntax-instr-control-mathsf-br-l)  
- [2] The label that always wraps `delegate{l}...end` can be thought of as "level -1" and cannot be referred to by the delegate's label index `l`.

### Typing Rules for Administrative Instructions

```
S.tags[a].type = [t*]→[]
--------------------------------
S;C ⊢ throw a : [t1* t*]→[t2*]

((S.tags[a].type = [t'*]→[])?
 S;C, labels catch [t*] ⊢ instr'* : [t'*?]→[t*])*
S;C, labels [t*] ⊢ instr* : []→[t*]
-----------------------------------------------------------
S;C, labels [t*] ⊢ catch{a? instr'*}* instr* end : []→[t*]

S;C, labels [t*] ⊢ instr* : []→[t*]
C.labels[l] = [t'*]
------------------------------------------------------
S;C, labels [t*] ⊢ delegate{l} instr* end : []→[t*]

S.tags[a].type = [t'*]→[]
(val:t')*
S;C, labels catch [t*] ⊢ instr* : []→[t*]
----------------------------------------------------------
S;C, labels [t*] ⊢ caught{a val^n} instr* end : []→[t*]
```

## TODO Uncaught Exceptions

We haven't yet described the formalism for an uncaught exception being the result of evaluation.

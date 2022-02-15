# 3rd Proposal Formal Spec Examples

This document contains WebAssembly code examples mentioned in comments on this repository, and what they reduce to, according to the ["3rd proposal formal spec overview"](Exceptions-formal-overview.md).

Its purpose is to make sure everyone is happy with the implications of the semantics in the current 3rd proposal, or to aid discussions on these semantics.

The first *example 0* contains all the new instructions, and it is the only one with an almost full reduction displayed. It is meant to easily show how the spec works, even if the reader has not spent much time with the WebAssembly formal spec.

For all other examples just the result of the reduction is given. These examples are taken from comments in this repository, which are linked. Sometimes/often the examples are modified to fit the current syntax.

If anyone would like that I add another reduction trace, or other examples, please let me know, I'd be happy to.

### Notation

If `x` is an exception tag index, then `a_x` denotes its exception tag address, i.e., `a_x := F.tag[x]`, where `F` is the current frame.

Note that the block contexts and throw contexts given for the reductions are the largest possible in each case, so the reduction steps are the only possible ones.

## Example 0

The only example with an almost full reduction trace, and all new instructions. Such explicit reduction steps are only shown in Example 4 and Example 5, to highlight the reduction step of the administrative `delegate`.

In the following reduction, we don't show the first 4 steps, which just reduce the several `try`s and the `throw x` to their respective administrative instructions. The type of the tag `$x` here is `[]→[]`.

```
(tag $x)
(func (result i32) (local i32)
  try (result i32)
    try
      try
        throw $x
      catch_all
        i32.const 27
        local.set 0
        rethrow 0
      end
    delegate 0
  catch $x
    local.get 0
  end)
```

We write the body of this function in folded form, because it is easier to parse.

```
(try (result i32)
  (do
    (try
      (do
        (try
          (do
            (throw $x))
          (catch_all
            (local.set 0 (i32.const 27))
            (rethrow 0))))
      (delegate 0)))
  (catch $x
    (local.get 0)))
```

Take the frame `F = (locals i32.const 0, module m)`. We have:

```
↪ ↪ ↪
↪ F; (label_1{}
        (catch_1{ a_x (local.get 0) }
          (label_0{}
            (delegate{ 0 }
              (label_0{}
                (catch_0{ ε (local.set 0 (i32.const 27)) (rethrow 0) }
                  (throw a_x) end) end) end) end) end) end)
```

For the trivial throw context `T = [_]` the above is the same as

```
↪ F; (label_1{}
        (catch_1{ a_x (local.get 0) }
          (label_0{}
            (delegate{ 0 }
              (label_0{}
                (catch_0{ ε (local.set 0 (i32.const 27)) (rethrow 0) }
                  T[(throw a_x)]) end) end) end) end) end)

↪ F; (label_1{}
        (catch_1{ a_x (local.get 0) }
          (label_0{}
            (delegate{ 0 }
              (label_0{}
                (caught_0{ a_x ε }
                  (local.set 0 (i32.const 27))
                  (rethrow 0) end) end) end) end) end) end)
```

Let `F'` be the frame `{locals i32.const 27, module m}`, and let `B^0 = [_]` to reduce `rethrow 0`.

```
↪ F'; (label_1{}
         (catch_1{ a_x (local.get 0) }
           (label_0{}
             (delegate{ 0 }
               (label_0{}
                 (caught_0{ a_x ε }
                   B^0[ (rethrow 0) ] end) end) end) end) end) end)

↪ F'; (label_1{}
         (catch_1{ a_x (local.get 0) }
           (label_0{}
             (delegate{ 0 }
               (label_0{}
                 (caught_0{ a_x ε }
                   (throw a_x) end) end) end) end) end) end)
```

Let `T' = (label_0{} (caught_0{ a_x ε } [_] end) end)` and use the same `B^0` as above to reduce the throw with the delegate.

```
↪ F'; (label_1{}
         (catch_1{ a_x (local.get 0) }
           (label_0{}
             B^0[ (delegate{ 0 } T'[ (throw a_x) ] end) ] end) end) end)

↪ F'; (label_1{}
         (catch_1{ a_x (local.get 0) }
           (throw a_x) end) end)
```

Use the trivial throw context `T` again, this time to match the throw to the `catch_1`.

```
↪ F'; (label_1{}
         (catch_1{ a_x (local.get 0) }
           T[ (throw a_x) ] end) end)

↪ F'; (label_1{}
         (caught_1{ a_x ε }
           (local.get 0) end) end)

↪ F'; (label_1{}
         (caught_1{ a_x ε }
           (i32.const 27) end) end)

↪ F'; (label_1{}
         (i32.const 27) end)

↪ F'; (i32.const 27)
```

## Behavior of `rethrow`

### Example 1

Location of a rethrown exception. Let `x, y, z` be tag indices of tags with type `[t_x]→[]`, `[t_y]→[]`, and `[t_z]→[]` respectively. Let `val_p : t_p` for every `p` among `x, y, z`.

```
try
  val_x
  throw x
catch x
  try $label2
    val_y
    throw y
  catch_all
    try
      val_z
      throw z
    catch z
      rethrow $label2 ;; This is rethrow 2.
    end
  end
end
```

Folded it looks as follows.

```
(try
  (do
    val_x
    (throw x))
  (catch x  ;; <--- (rethrow 2) targets this catch.
    (try
      (do
        val_y
        (throw y))
      (catch_all
        (try
          (do
            val_z
            (throw z))
          (catch z
            (rethrow 2)))))))
```

In the above example, all thrown exceptions get caught and the first one gets rethrown from the catching block of the last one. So the above reduces to

```
(label_0{}
  (caught_0{ a_x val_x } ;; <---- The exception rethrown by `rethrow 2` below.
    val_x
    (label_0{}
      (caught_0{ a_y val_y }
        ;; The catch_all does not leave val_y here.
        (label_0{}
          (caught_0{ a_z val_z }
            val_z
            ;; (rethrow 2) puts val_x and the throw below.
            val_x
            (throw a_x) end) end) end) end) end) end)
```

This reduces to `val_x (throw a_x)`, throwing to the caller.

### Example 2

`rethrow`'s immediate validation error.

@aheejin gave the following
[example in this comment](https://github.com/WebAssembly/exception-handling/pull/143#discussion_r522673735)

```
(func
  try $label0
    rethrow $label0 ;; cannot be done, because it's not within catch below
  catch x
  end)
```

This is a validation error (no catch block at given rethrow depth).

## Target of `delegate`'s Immediate (Label Depth)

### Example 3

`delegate 0` target.

```
(try $l
  (do
    (throw x))
  (delegate $l))
```

This is a validation error, a `delegate` always refers to an outer block.

### Example 4

`delegate` correctly targeting a `try-delegate` and a `try-catch`.

```
try $label1
  try
    try $label0
      try
        throw x
      delegate $label0 ;; delegate 0
    delegate $label1 ;; delegate 1
  catch_all
  end
catch x
  instr*
end
```

In folded form and reduced to the point `throw x` is called, this is:

```
(label_0{}
  (catch_0{ a_x instr* }
    (label_0{}
      (catch_0{ ε ε }
        (label_0{}
          (delegate{ 1 }
            (label_0{}
              (delegate{ 0 }
                (throw a_x) end) end) end) end) end) end) end) end)
```

The `delegate{ 0 }` reduces using the trivial throw and block contexts to:

```
(label_0{}
  (catch_0{ a_x instr* }
    (label_0{}
      (catch_0{ ε ε }
        (label_0{}
          (delegate{ 1 }
            (throw a_x) end) end) end) end) end) end)
```

The `delegate{ 1 }` reduces using the trivial throw context and the block context `B^1 := (catch_0{ ε ε } (label_0{} [_] end) end)` to the following:

```
(label_0{}
  (catch_0{ a_x instr* }
    (throw a_x) end) end)
```
The thrown exception is (eventually) caught by the outer try's `catch x`, so the above reduces to the following.

```
(label_0 {}
  (caught_0{a_x}
    instr* end) end)
```

### Example 5

`delegate 0` targeting a catch inside a try.

```
try (result i32)
  try $label0
    throw x
  catch_all
    try
      throw y
    delegate $label0 ;; delegate 0
  end
catch_all
  i32.const 4
end
```

In folded form this is:

```
(try (result i32)
  (do
    (try
      (do
        (throw x))
      (catch_all
        (try
          (do
            (throw y)
          (delegate 0))))))
  (catch_all
    (i32.const 4)))
```

When it's time to reduce `(throw y)`, the reduction looks as follows.

```
(label_1{}
  (catch_1{ ε (i32.const 4) }
    (label_0{}
      (caught_0{ a_x ε }
        (label_0{}
          (delegate{ 0 }
            (throw a_y) end) end) end) end) end) end)
```

For `B^0 := [_] := T`, the above is the same as the following.

```
(label_1{}
  (catch_1{ ε (i32.const 4) }
    (label_0{}
      (caught_0{ a_x ε }
        (label_0{}
          B^0 [(delegate{ 0 } T[ (throw a_y) ] end)] end) end) end) end) end)

↪ (label_1{}
     (catch_1{ ε (i32.const 4) }
       (label_0{}
         (caught_0{ a_x ε }
           (throw a_y) end) end) end) end)
```

So `throw a_y` gets correctly caught by `catch_1{ ε (i32.const 4) }` and this example reduces to `(i32.const 4)`.

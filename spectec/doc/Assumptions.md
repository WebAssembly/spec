# Assumptions

The following are the assumptions that the SpecTec prose generator currently makes about input specifications. If these assumptions are not met, prose may not be generated as intended. In future versions of SpecTec, some of these assumptions may be relaxed or new assumptions may be added.

## Il2al translation ([src/il2al](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/il2al))

### The form of relations and rules
SpecTec can define any type of relation, but only two types of relations are converted into prose.
- Validation Rule: All relations expressed using the turnstile symbol (`|-`) are considered validation rules and automatically converted into declarative prose.
- Reduction Rule: `Step`, `Step_pure`, `Step_read` relations, expressed using `~>`, are considered reduction rules and converted to prose. The left-hand side of this relation must satisfy one of the following conditions:
  - The left-hand side must be a list containing multiple Wasm values, with a Wasm instruction as the final element.
  - The left-hand side must be a list consisting of precisely one Wasm instruction, and that instruction must be an instruction with another instruction list as a child, such as `Label`, `Frame`, or `Handler`.

### Partitioned input space
We assume that different rules or function definitions grouped into a single prose collectively partition the expected input space. That is:
- Different definitions grouped into a single prose are assumed to be mutually exclusive. 
  - `memory.grow` and `table.grow` are hardcoded exceptions: nondeterministic. They are converted to `Either` (TODO: to include a hint `nondeterministic` here by `@f52985`).
- Different definitions grouped into a single prose are assumed to cover all inputs.
  - Except for function definitions with hint `partial`. In other cases, failure is explicitly inserted.

### Cyclic binding / Forward reference
Premises involving cyclic dependencies cannot be converted into algorithmic prose.
Ex:
```
-- if a = f(b)
-- if b = g(a)
```

### Otherwise
- When using `otherwise`, the order between rules is also important.
- The prose backend assumes the following about `otherwise`. If these assumptions are not met, the generated prose may exhibit unexpected behavior: 
  - `otherwise` must have the same input as all other rules bound to it (the same ‘argument’ for a function, the same ‘input’ for a relation).
  - If a rule containing `otherwise` appears, a rule without `otherwise` must not appear thereafter.	
  - If a rule containing `otherwise` is the last in the order, then no other premises should appear in that rule. If the rule is not the last in the order, then there must be precisely one premise below it.
Ex:
  ```
  rule Rel/rule1:
  |- input: output1
  -- if P
  
  rule Rel/rule2:
  |- input: output2 ;; must have the same `input`
  -- otherwise
  -- if Q
  
  rule Rel/rule3:
  |- input: output3
  -- otherwise
  ```
  generates the following prose:
  ```
  1. If P then:
    a. Return output1
  2. Else if Q then:
    a. Return output2
  3. Else:
    a. Return output3
  ```

### Inverse functions
A premise that assigns values ​​to variables in the arguments of a function `-- if $f(output) = input`,  is changed to an inverse function call `-- if output = $f^-1(input)`. 

Here, values can also be assigned ​​to several variables for functions with multiple arguments. Ex:
```
-- if $f(output1, input1, output2) = input2
```
is changed to the following:
```
–- output1, output2 = $f^-1(input1, intput2)
```
Moreover, depending on how values ​​are assigned to variables in arguments, a single function may have multiple inverse functions. Each inverse function must be implemented through hardcoding in OCaml, and an error occurs if they do not exist.

### Validation relations as functions
In the reduction rules for runtime semantics, there are cases where other relations, especially validation relations, appear as one of the premises. An arbitrary relation premise cannot be automatically converted, and only those with a specific form (`|- input : output`) are converted to premises with a function call. These functions must be implemented through hardcoding in OCaml, and an error occurs if they do not exist.
- The name of the relation is assumed to be the function name.
- The expressions appearing on the left of the colon are assumed to be the function's inputs.
- The expressions appearing on the right of the colon are assumed to be the function's outputs.
Ex:
```
-- Module_ok: |- module : t1* -> t2*
```
is converted to the following:
```
-- if t1* -> t2* = $Module_ok(module)
```

### Remove store only for interpreter
When translating IL to AL, the store is processed globally through `remove_store`, but the store information is needed again when rendering prose. For this reason, state information is not deleted in cases other than interpreter and test; this is managed using the `for_interp` variable in ([transpile.ml](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/il2al/transpile.ml)).

## Interpreter ([src/backend-interpreter](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-interpreter))

- The AL interpreter has two main entry points: instantiation and invocation.
- Certain AL algorithms related to relations and numeric functions are hardcoded in ([numerics.ml](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-interpreter/numerics.ml)).
- The store fields are hardcoded, meaning any newly added field must be explicitly hardcoded. The variable name corresponding to the store is hardcoded as “`s`” ([ds.ml#L48-L68](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-interpreter/ds.ml#L48-L68)).
- When handling a Wasm instruction, the logic for determining whether it is a Wasm value is hardcoded. If a new Wasm value is added, hardcoding must be added ([interpreter.ml#L675-L683](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-interpreter/interpreter.ml#L675-L683)).
- Partial assignment logic for `Let` instruction is not fully supported.
- `Either` instruction tries the first branch; if an error occurs, it then tries the second branch.
- The translation between the reference interpreter AST and AL AST is hardcoded in ([construct.ml](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-interpreter/construct.ml)).

## Prose ([src/backend-prose](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-prose))

### IL to prose statements (Validation)

- As in the IL-to-AL translations, only relations containing the turnstile symbol (`|-`) are considered validation relations and processed to generate validation prose.
- Specific relations can be excluded from validation prose generation based on their names. Currently, prose for `Expand` and `Expand_use` is not generated ([gen.ml#L34-L49](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-prose/gen.ml#L34-L49)).
- A rule whose name begins with `_` is treated as a hidden rule and does not appear in relation prose ([gen.ml#L444](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-prose/gen.ml#L444)).
- Assume that the validation relation is one of the eight types below. If you want to add a new type, you should: (TODO: Replace this completely with prose hints by `@f52985`).
  - Add the new type to the `rel_kind` type ([gen.ml#L126-L135](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-prose/gen.ml#L126-L135)).
  - Implement a function to convert the type and add it to `proses_of_rel` ([gen.ml#L548-L557](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-prose/gen.ml#L548-L557)).
  - Add corresponding pattern to `get_rel_kind` ([gen.ml#L137-L146](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-prose/gen.ml#L137-L146)).
  ```
  C |- expr : OK
  C |- instr : type
  C |- expr : expr
  C |- type <: type
  C |- expr CONST
  C |- expr : expr CONST
  C |- expr : expr expr
  |- expr DEFAULTABLE  or  |- expr NONDEFAULTABLE
  ```
- (CAN BE CHANGED) When a validation rule states “`A is valid with B`” and `B` contains a non-trivial construct (e.g., `CallE`), introduce a binding (”`Let t be B`“ ) and update the rule’s conclusion to “`A is valid with t`” ([gen.ml#L380-L391](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-prose/gen.ml#L380-L391)).
  Ex. `struct.new` : 
  ```
  The instruction (struct.new 𝑥) is valid with the instruction type unpack(zt)* → (ref 𝜖𝑥) if:
  ```
  is changed to:
  ```
  The instruction (struct.new 𝑥) is valid with the instruction type 𝑡* → (ref 𝜖𝑥) if:
  Let 𝑡* be the value type sequence unpack(zt)*
  ```
- Validation rules implicitly assume that context C is defined. Therefore, C is omitted from validation prose except in specific cases such as the following.
  - (CAN BE CHANGED) If `ExtE` (extend) is applied to the context expression C, a statement is added that resolves `ExtE` into prose and binds it to a new context C’ ([gen.ml#L258-L266](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-prose/gen.ml#L258-L266)).
	Ex. `Instrs_ok/block`:
    ```
    Instrs_ok: {LABELS (t_2*)} ++ C
      - Let 𝐶′ be the same context as 𝐶, but with the result type sequence 𝑡_2* prepended to the field labels.
      - Under the context 𝐶′, ~
    ```

### Prose hint

- Prose hints are hardcoded as text ([prose_util.ml#L217-L236](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-prose/prose_util.ml#L217-L236)).
  Currently, prose hints are simple, hardcoded text (enclosed in quotes) and are parsed via the `split_prose_hint` function (TODO: Change prose hints to a form that can be parsed into EL instead of text by `@702fbtngus`).
- The prose backend assumes that the ids of prose hints have the prefix “prose” ([gen.ml#L58-L68](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-prose/gen.ml#L58-L68)).

### Exceptional cases in rendering

- `$concat_` and `$concatn_` ([render.ml#L630-L637](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-prose/render.ml#L630-L637), [L1259-L1279](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-prose/render.ml#L1259-L1279)) functions are rendered as `the concatenation of ...` instead of the general function notation.
  - For the inverse function of `concatn_`, there is an additional handling. Since the length of each element is given, its inverse function can be defined. Ex:
    ```
    concatn_ ([[1, 2], [3, 4], [5, 6]], 2) = [1, 2, 3, 4, 5, 6]
    concatn_^-1 ([1, 2, 3, 4, 5, 6], 2) = [[1, 2], [3, 4], [5, 6]]
    ```
    However, the existing output did not sufficiently capture this meaning:
    ```
    Let `elem**` be the result for which the concatenation of (`elem**`) is `input`
    ```
    Since `elem**` in the above is not unique, we modified it to output more accurate prose by considering the characteristics of `concatn_`:
    ```
    Let `elem**` be the result for which each `elem*` has length `n`, and the concatenation of (`elem**`) is `input`
    ```
- As mentioned earlier, relations are converted into function calls in AL. Ad hoc rendering is implemented for each relation to ensure these function calls are correctly displayed.
[render.ml#L638-L660](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-prose/render.ml#L638-L660) contains the rendering for the expression itself,
and [render.ml#L1286-L1303](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-prose/render.ml#L1286-L1303) contains additional validation strings required before and after expressions of the form `LetI(_, CallE(relation))`.
- Control frames ([render.ml#L688-L705](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-prose/render.ml#L688-L705)):
The first atom in the `mixop` of `CaseE` directly matches the hardcoded string (`LABEL_`, `FRAME_`, `HANDLER_`). The string should also be added here if a new control frame is added.
- Omitting `Due to validation` ([render.ml#L1161-L1164](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-prose/render.ml#L1161-L1164)):
Assert instructions (`AssertI`) can be divided into those generated due to validation and those that are not. The prose backend checks whether `at` of `AssertI` corresponds to `module.watsup`. If not, the phrase `Due to validation` is omitted.
- Rendering `If not cond*, then fail` ([render.ml#L1049-L1112](https://github.com/Wasm-DSL/spectec/blob/965415756005b74ecaa39fe81aec1986ba79a210/spectec/src/backend-prose/render.ml#L1049-L1112)):
We hardcode the sentence in the above format to include a length condition and output it in more detail. Ex:
  ```
  #. If not $Externaddr_ok(externaddr, xt_I)*, then:
    a. Fail.
  ```
  is changed to:
  ```
  #. If |externaddr*| != |xt_I*|, then:
    a. Fail.
  #. For all externaddr, and xt_I in (externaddr, xi_I)*:
    a. If externaddr is not valid with type xt_I, then:
      1. Fail.
  ```
- Rendering descriptions of struct:
`desc` hints are used to express types. The name of the type of the corresponding expression is used to find it, but in the case of an expression in the form of `AccE(AccE(_, DotP), IdxP)`, such as `C.FUNCS[x]`, `desc` hint of `AccE(_, DotP)` is used preferentially.
This allows us to use `function` as the description of `C.FUNCS[x]`. Thus, from the following specification:
  ```
  syntax context hint(desc "context") hint(macro "%" "C%") =
    { TYPES deftype*          hint(desc "type"),
      RECS  subtype*          hint(desc "recursive type"),
      FUNCS deftype*          hint(desc "function"),
      ...
  }
  ```
  we can generate the following prose:
  ```
  Let _ be the function C.FUNCS[x].
  ```

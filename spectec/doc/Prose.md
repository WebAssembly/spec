# Prose Generation

### Overview

SpecTec can automatically translate specifications written in DSL into stylized prose (natural language).
It can output the generated prose as plain text, or render it in reStructuredText (reST) format.

SpecTec generates three kinds of definitions:

#### Validation Rules

SpecTec produces declarative prose to describe the validation rules for each relevant part of the abstract syntax.

**Example:**
```wasm
;; 3-typing.spectec
rule Instr_ok/local.get:
  C |- LOCAL.GET x : eps -> t
  -- if C.LOCALS[x] = SET t
```

**Generated Prose:**
```
Instr_ok/local.get
- The instruction `LOCAL.GET x` is valid with the instruction type `[] -> [t]` if:
  - The local type `C.LOCALS[x]` exists.
  - `C.LOCALS[x]` is `SET t`.
```

#### Execution Semantics

SpecTec generates stepwise, algorithmic prose to describe the execution semantics (reduction rules) of instructions.

**Example:**
```wasm
;; 8-reduction.spectec
rule Step_read/local.get:
  z; (LOCAL.GET x)  ~>  val
  -- if $local(z, x) = val
```

**Generated Prose:**
```
Step_read/local.get x
1. Let `z` be the current state.
2. Assert: Due to validation, `$local(z, x)` is defined.
3. Let `val` be `$local(z, x)`.
4. Push `val` onto the stack.
```

#### Function Definitions

SpecTec also generates stepwise, algorithmic prose for function definitions. These functions typically serve as auxiliary helper functions or define module-level semantics.

**Example:**
```wasm
;; 1-syntax.spectec
def $size(numtype) : nat

def $size(I32) = 32
def $size(I64) = 64
def $size(F32) = 32
def $size(F64) = 64
```

**Generated Prose:**
```
size(nt)
1. If `nt = I32`, then:
  a. Return `32`.
2. If `nt = I64`, then:
  a. Return `64`.
3. If `nt = F32`, then:
  a. Return `32`.
4. If `nt = F64`, then:
  a. Return `64`.
```

### Usage Examples

The following command generates prose for the given spec files in the `spec/wasm-latest` directory and prints it to stdout in plain text:
```sh
./spectec spec/wasm-latest/*.spectec --prose
```

To generate prose in ReStructuredText format, use:
```sh
./spectec spec/wasm-latest/*.spectec --prose-rst
```

### Caveats

Due to the inherent differences between declarative formal notations and algorithmic prose notation, prose generation may exhibit unexpected or unintended behavior, especially if a given rule is overly complex or highly declarative.

For example, the order of premises may occasionally be interchanged unexpectedly.

If the spliced prose in ReStructuredText format is not generated as intended, you can disable the splice anchor for that specific definition and manually use conventional ReStructuredText prose instead.

### Preprocessing

#### Anti-Unification
When rendering multiple rules or functions at once, they are merged into a single paragraph of prose.
For that, the 'inputs' of relations or functions are anti-unified into a single variable.
For example, in the above example, when merging the case for the function definition `$size`,
the new fresh variable `nt` is introduced so that case analysis can be performed in the prose.

#### Inference of Variable Bindings
One challenge in translating declarative reduction rules into algorithmic execution prose is that it is not explicitly denoted which variables are bound in each premise.

For example, consider the premise `if x = 1`. It is ambiguous whether it should be translated into a binding prose (`Let x be 1`) or a conditional prose (`If x is 1, then ...`).

To resolve this, SpecTec first infers which variables are bound by each equality premise and then translates the prose accordingly.

### Prose Hints

For relations, users can provide a `prose-hint` to specify how it should be rendered in declarative validation prose. The `i`-th argument can be referenced as `%i`.

**Example:**
```wasm
;; 2-syntax-aux.spectec
relation Expand: deftype ~~ comptype   hint(prose "The expansion of" %1 "is" %2)

;; 3-typing.spectec
rule Instr_ok/call:
  C |- CALL x : t_1* -> t_2*
  -- Expand: C.FUNCS[x] ~~ FUNC (t_1* -> t_2*)
```

**Generated Prose:**
```
Instr_ok/call
- The instruction `(CALL x)` is valid with the instruction type `t_1* -> t_2*` if:
  - The defined type `C.FUNCS[x]` exists.
  - The expansion of `C.FUNCS[x]` is the composite type `(FUNC t_1* -> t_2*)`.
```

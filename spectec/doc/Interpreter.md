# Indirect Interpreter for Wasm

### Overview

SpecTec can interpret any given WebAssembly (Wasm) program with respect to an input specification.
It achieves this by **directly** interpreting the prose specification as if the specification itself were a program, effectively **indirectly** interpreting the Wasm program.

Internally, SpecTec represents the WebAssembly prose specification using an intermediate language called AL (Algorithmic Language).
It treats the specification as an executable program composed of multiple algorithms.
There are two entry algorithms: the module instantiation, and the function invocation.
A Wasm module or function is provided as input to these algorithms, and the computed result is returned as output.
SpecTec's AL interpreter takes the specification (represented as an AL program) as input, along with a Wasm module or function (encoded as AL runtime values).
The AL interpreter then executes the specification, ultimately producing a return value that corresponds to the execution result of the given Wasm module or function.

### Usage

- Instantiate a Wasm module
  The following command instantiates the Wasm module `sample.wasm` using the input specification located in `spec/wasm-3.0` and prints the instantiation result to stdout:
  ```sh
  ./spectec spec/wasm-3.0/*.spectec --interpreter sample.wasm
  ```
  - If the instantiation succeeds, execution terminates normally.
  - If a trap occurs during execution, the message `Backend_interpreter.Exception.Trap` is printed.

- Run a Wasm test script
  The following command executes the test script `sample.wast`:
  ```sh
  ./spectec spec/wasm-3.0/*.spectec --interpreter sample.wast
  ```
  - The output indicates the number of successful tests.

- Run all Wasm tests in a directory
  The following command runs **all** Wasm tests located in `test-interpreter/wasm-3.0`:
  ```sh
  ./spectec spec/wasm-3.0/*.spectec --interpreter test-interpreter/wasm-3.0
  ```

### Interpreting Prose

The prose interpreter executes the prose specification step by step, interpreting each line sequentially.
Its behavior is mostly straightforward.
(TODO: Formally describe the behavior of each step.)

The interpreter follows the computation model assumed in the prose specification:

- An implicit stack is assumed, modified by pushing or popping values, labels, frames, and handlers.
- A state `z` is maintained, consisting of a store `s`, and a current frame `f` (the most recently pushed frame)
- Both the store and the current frame can be mutated by replacing some of their components.
Such replacements are assumed to apply globally.
- If a `Trap`, `Throw`, or `Fail` step is encountered, execution is immediately aborted, and no further modifications to the store are made.

### Dependency on the Reference Interpreter

Some parts of the indirect interpreter still rely on the official Wasm reference interpreter:

#### 1. Parser Dependency
To execute actual Wasm programs, SpecTec currently borrows the parser from the reference interpreter.
The reference interpreter can parse both textual and binary representations of Wasm modules and convert them into an AST.

SpecTec includes a manual translation layer that converts between the reference interpreter’s AST representation and AL values.
Whenever new syntax is added to the reference interpreter, corresponding translation logic must also be implemented manually.

One of our future goals is to automate this process by extracting the parser directly from the specification.
This would allow SpecTec to parse Wasm programs using the input grammar without relying on the reference interpreter.

#### 2. Validation Dependency
Some validation algorithms are hardcoded in `src/backend-interpreter/manual.ml`.
These implementations call the validation functions of the reference interpreter.
Further efforts may be needed to make this validation independent.

#### 3. Numerics Dependency
Some numeric functions, such as `$fadd_`, are declared but not defined in the specification.
For these functions, SpecTec's interpreter currently relies on the implementation from the reference interpreter.
Our goal is to eventually implement these numeric functions directly within the specification.

### Formal Semantics of Prose

TODO
